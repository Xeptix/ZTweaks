[CmdletBinding()]
param(
    [ValidateSet('t6-mod','t6-script','boiii-game','boiii-appdata','t7x-game','t7compiler')]
    [string]$Slot = 't6-mod',
    [switch]$Install, [switch]$Uninstall, [switch]$Find, [switch]$List,
    [switch]$Verify, [switch]$Configure, [string]$Root, [string]$StateRoot, [switch]$Yes
)
$ErrorActionPreference = 'Stop'
$download = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$repository = Test-Path -LiteralPath (Join-Path $PSScriptRoot 'tools\build.py')

function Find-SteamBO3 {
    $roots = @()
    foreach ($key in @('HKCU:\Software\Valve\Steam','HKLM:\SOFTWARE\WOW6432Node\Valve\Steam')) {
        try {
            $steam = Get-ItemProperty -Path $key -ErrorAction Stop
            $base = $steam.SteamPath; if (-not $base) { $base = $steam.InstallPath }
            if ($base) {
                $roots += $base
                $vdf = Join-Path $base 'steamapps\libraryfolders.vdf'
                if (Test-Path -LiteralPath $vdf) {
                    foreach ($line in Get-Content -LiteralPath $vdf) {
                        if ($line -match '"path"\s+"([^"]+)"') { $roots += ($Matches[1] -replace '\\\\','\') }
                    }
                }
            }
        } catch {}
    }
    foreach ($root in $roots | Select-Object -Unique) {
        $common = Join-Path $root 'steamapps\common'
        if (-not (Test-Path -LiteralPath $common -PathType Container)) { continue }
        foreach ($game in Get-ChildItem -LiteralPath $common -Directory -ErrorAction SilentlyContinue) {
            if ($game.Name -notlike '*Black Ops III*' -or $game.Name -like '*455130*') { continue }
            foreach ($exe in @('BlackOps3.exe','boiii.exe','t7x.exe')) {
                if (Test-Path -LiteralPath (Join-Path $game.FullName $exe) -PathType Leaf) { return $game.FullName }
            }
        }
    }
    return $null
}

function Default-Root([string]$Name) {
    switch -Wildcard ($Name) {
        't6-*' { if ($env:PLUTONIUM_DIR -and (Test-Path -LiteralPath $env:PLUTONIUM_DIR -PathType Container)) { return $env:PLUTONIUM_DIR }; if ($env:LOCALAPPDATA) { return Join-Path $env:LOCALAPPDATA 'Plutonium' } }
        'boiii-game' { if ($env:BO3_DIR -and (Test-Path -LiteralPath $env:BO3_DIR -PathType Container)) { return $env:BO3_DIR }; $found = Find-SteamBO3; if ($found) { return $found }; return 'C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops III' }
        'boiii-appdata' { if ($env:BOIII_DATA_DIR -and (Test-Path -LiteralPath $env:BOIII_DATA_DIR -PathType Container)) { return $env:BOIII_DATA_DIR }; if ($env:LOCALAPPDATA) { return Join-Path $env:LOCALAPPDATA 'boiii' } }
        't7x-game' { if ($env:BO3_DIR -and (Test-Path -LiteralPath $env:BO3_DIR -PathType Container)) { return $env:BO3_DIR }; $found = Find-SteamBO3; if ($found) { return $found }; return 'C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops III' }
        't7compiler' { return Join-Path (Get-Location) 't7-compiler' }
    }
    return $null
}
function Slot-Map([string]$Name, [string]$Base) {
    switch ($Name) {
        't6-mod' { return @{ Source='Plutonium\storage\t6\mods\zm_ztweaks'; Target=(Join-Path $Base 'storage\t6\mods\zm_ztweaks'); Kind='tree' } }
        't6-script' { return @{ Source='Plutonium\storage\t6\scripts\zm\ztweaks.gsc'; Target=(Join-Path $Base 'storage\t6\scripts\zm\ztweaks.gsc'); Kind='file' } }
        'boiii-game' { return @{ Source='Black Ops III\boiii'; Target=(Join-Path $Base 'boiii'); Kind='tree' } }
        'boiii-appdata' { return @{ Source='AppData\boiii\data'; Target=(Join-Path $Base 'data'); Kind='tree' } }
        't7x-game' { return @{ Source='t7x'; Target=(Join-Path $Base 't7x'); Kind='tree' } }
        't7compiler' { return @{ Source='t7-compiler'; Target=$Base; Kind='tree' } }
    }
}
function Hash-File([string]$Path) { return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant() }
function Installed-Version([hashtable]$Map) {
    $candidate = if ($Map.Kind -eq 'file') { $Map.Target } else {
        Get-ChildItem -LiteralPath $Map.Target -File -Recurse -ErrorAction SilentlyContinue |
            Where-Object { $_.Extension -in @('.gsc','.gscc') } | Select-Object -First 1 -ExpandProperty FullName
    }
    if (-not $candidate -or -not (Test-Path -LiteralPath $candidate -PathType Leaf)) { return '-' }
    try {
        $text = [Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes($candidate))
        if ($text -match 'ZTweaks v([0-9][0-9A-Za-z.\-]*)') { return $Matches[1] }
    } catch {}
    return 'unknown'
}
function Package-Root([string]$Name) {
    if (-not $repository) { return $download }
    return Join-Path $PSScriptRoot ($(if ($Name -like 't6-*') { 'dist\t6\src' } else { 'dist\t7\src' }))
}
function Relative-To([string]$Path, [string]$Base) {
    $fullPath = [IO.Path]::GetFullPath($Path)
    $fullBase = [IO.Path]::GetFullPath($Base).TrimEnd('\') + '\'
    if (-not $fullPath.StartsWith($fullBase, [StringComparison]::OrdinalIgnoreCase)) { throw "$fullPath is outside $fullBase" }
    # The ownership marker is shared with the Bash installer. Always serialize
    # portable slash-separated paths; PowerShell accepts them when reading.
    return ($fullPath.Substring($fullBase.Length) -replace '\\','/')
}
function Remove-EmptyParents([string]$Path, [string]$StopAt) {
    $stop = [IO.Path]::GetFullPath($StopAt).TrimEnd([char[]]@('\','/'))
    $current = Split-Path -Parent $Path
    while ($current -and [IO.Path]::GetFullPath($current).TrimEnd([char[]]@('\','/')) -ne $stop) {
        if (-not (Test-Path -LiteralPath $current -PathType Container)) { $current = Split-Path -Parent $current; continue }
        if (Get-ChildItem -LiteralPath $current -Force | Select-Object -First 1) { break }
        Remove-Item -LiteralPath $current -Force
        $current = Split-Path -Parent $current
    }
}

$slots = @('t6-mod','t6-script','boiii-game','boiii-appdata','t7x-game','t7compiler')
if ($List) {
    foreach ($name in $slots) {
        $candidate = if ($Root -and $name -eq $Slot) { $Root } else { Default-Root $name }; $map = Slot-Map $name $candidate; $package = Package-Root $name
        $owned = if ($map.Kind -eq 'file') { Test-Path -LiteralPath "$($map.Target).ztweaks.sha256" -PathType Leaf } else { Test-Path -LiteralPath (Join-Path $map.Target '.zmods-installer\ztweaks.tsv') -PathType Leaf }
        $version = if ($owned) { Installed-Version $map } else { '-' }
        "{0,-18} payload={1} installed={2} version={3} root={4}" -f $name,[bool](Test-Path -LiteralPath (Join-Path $package $map.Source)),$owned,$version,$candidate
    }
    exit 0
}
$download = Package-Root $Slot
if (-not $Root) { $Root = Default-Root $Slot }
if (-not $Root) { throw 'No default installation root is available. Pass -Root explicitly.' }
$Root = [IO.Path]::GetFullPath($Root); $route = Slot-Map $Slot $Root
$source = Join-Path $download $route.Source; $target = $route.Target
$marker = if ($route.Kind -eq 'file') { "$target.ztweaks.sha256" } else { Join-Path $target '.zmods-installer\ztweaks.tsv' }
$localState = if ($StateRoot) { $StateRoot } elseif ($env:XDG_STATE_HOME) { $env:XDG_STATE_HOME } elseif ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { [Environment]::GetFolderPath('LocalApplicationData') }
$log = Join-Path $localState 'ZTweaks\installer.log'
function Log([string]$Message) {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $log) | Out-Null
    Add-Content -LiteralPath $log -Value ("{0:u} {1}" -f (Get-Date),$Message)
}

if ($Find) {
    Write-Host "Slot: $Slot"; Write-Host "Root: $Root"
    Write-Host "Payload available: $([bool](Test-Path -LiteralPath $source))"
    Write-Host "Installed marker: $([bool](Test-Path -LiteralPath $marker -PathType Leaf))"; exit 0
}
if ($Configure) {
    $settings = if ($Slot -like 't6-*') { 'ztweaks-t6.settings' } else { 'ztweaks-t7.settings' }
    $reference = Join-Path $download $settings
    Write-Host "Settings reference: $reference"
    if (Test-Path -LiteralPath $reference) { Get-Content -LiteralPath $reference }
    Write-Host 'Change these settings in the ZTweaks/ZBundle menu; the list above is the exact installed dvar reference.'; exit 0
}
if ($Verify) {
    if (-not (Test-Path -LiteralPath $marker -PathType Leaf)) { Write-Error "No ZTweaks ownership marker for $Slot"; exit 1 }
    $bad = @()
    if ($route.Kind -eq 'file') {
        if (-not (Test-Path -LiteralPath $target -PathType Leaf) -or (Hash-File $target) -ne (Get-Content -LiteralPath $marker -Raw).Trim()) { $bad += $target }
    } else {
        foreach ($line in Get-Content -LiteralPath $marker) {
            $parts = $line -split "`t", 3; if ($parts.Count -lt 2) { continue }
            $path = Join-Path $target $parts[1]
            if (-not (Test-Path -LiteralPath $path -PathType Leaf) -or (Hash-File $path) -ne $parts[0]) { $bad += $path }
        }
    }
    if ($bad.Count) { $bad | ForEach-Object { Write-Error "Missing or changed: $_" }; exit 1 }
    Write-Host "Verified ZTweaks slot $Slot at $target"; exit 0
}
if ($Uninstall) {
    if (-not (Test-Path -LiteralPath $marker -PathType Leaf)) { Write-Host "ZTweaks slot $Slot is not owned by this installer."; exit 0 }
    if (-not $Yes -and (Read-Host "Remove installer-owned ZTweaks files from $target ? [y/N]") -notmatch '^(?i)y(?:es)?$') { exit 0 }
    $changed = 0
    if ($route.Kind -eq 'file') {
        if ((Test-Path -LiteralPath $target -PathType Leaf) -and (Hash-File $target) -eq (Get-Content -LiteralPath $marker -Raw).Trim()) {
            if (Test-Path -LiteralPath "$target.ztweaks-backup" -PathType Leaf) { Move-Item -LiteralPath "$target.ztweaks-backup" -Destination $target -Force }
            else { Remove-Item -LiteralPath $target -Force }
            $changed++
        }
    } else {
        foreach ($line in Get-Content -LiteralPath $marker) {
            $parts = $line -split "`t", 3; if ($parts.Count -lt 2) { continue }
            $relative = [string]$parts[1] -replace '\\','/'
            $path = Join-Path $target $relative
            if ((Test-Path -LiteralPath $path -PathType Leaf) -and (Hash-File $path) -eq $parts[0]) {
                if ($parts.Count -ge 3 -and $parts[2] -eq '1' -and (Test-Path -LiteralPath "$path.ztweaks-backup" -PathType Leaf)) { Move-Item -LiteralPath "$path.ztweaks-backup" -Destination $path -Force }
                else { Remove-Item -LiteralPath $path -Force }
                $changed++
                Remove-EmptyParents $path $target
            }
        }
    }
    if ($changed -eq 0) {
        Write-Error "Refusing to delete an ownership marker because no installer-owned file was removed or restored: $marker"
        exit 1
    }
    Remove-Item -LiteralPath $marker -Force
    # A file-slot marker is a sibling of the installed file. Its parent may
    # predate ZTweaks, so only tree slots may prune their private marker folder.
    if ($route.Kind -ne 'file') { Remove-EmptyParents $marker $target }
    if ($Slot -eq 't6-mod') {
        $imageDestination = Join-Path $Root 'storage\t6\images\menu_zm_cac_backing.iwi'
        $imageMarker = "$imageDestination.ztweaks.sha256"; $imageBackup = "$imageDestination.ztweaks-backup"
        if ((Test-Path -LiteralPath $imageMarker -PathType Leaf) -and (Test-Path -LiteralPath $imageDestination -PathType Leaf) -and (Hash-File $imageDestination) -eq (Get-Content -LiteralPath $imageMarker -Raw).Trim()) {
            if (Test-Path -LiteralPath $imageBackup -PathType Leaf) { Move-Item -LiteralPath $imageBackup -Destination $imageDestination -Force }
            else { Remove-Item -LiteralPath $imageDestination -Force }
        }
        if (Test-Path -LiteralPath $imageMarker -PathType Leaf) { Remove-Item -LiteralPath $imageMarker -Force }
    }
    Log "removed slot=$Slot target=$target"
    Write-Host "Removed installer-owned files for $Slot"; exit 0
}
if (-not (Test-Path -LiteralPath $source)) { throw "The $Slot payload is missing at $source. Use the matching complete release zip." }
if (-not $Yes -and (Read-Host "Install ZTweaks $Slot to $target ? [Y/n]") -match '^(?i)n(?:o)?$') { exit 0 }
if ($route.Kind -eq 'file') {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
    if ((Test-Path -LiteralPath $target -PathType Leaf) -and -not (Test-Path -LiteralPath $marker -PathType Leaf) -and -not (Test-Path -LiteralPath "$target.ztweaks-backup" -PathType Leaf)) { Copy-Item -LiteralPath $target -Destination "$target.ztweaks-backup" }
    Copy-Item -LiteralPath $source -Destination $target -Force
    (Hash-File $target) | Set-Content -LiteralPath $marker -NoNewline
} else {
    $hadMarker = Test-Path -LiteralPath $marker -PathType Leaf
    $oldBackups = @{}
    if ($hadMarker) {
        foreach ($line in Get-Content -LiteralPath $marker) {
            $parts = $line -split "`t", 3
            if ($parts.Count -ge 3 -and $parts[2] -eq '1') {
                $oldRelative = [string]$parts[1] -replace '\\','/'
                $oldBackups[$oldRelative] = $true
            }
        }
    }
    New-Item -ItemType Directory -Force -Path $target | Out-Null; $records = @()
    if ($Slot -eq 't7compiler') {
        foreach ($shared in @('gsc.conf','README.md')) {
            $sharedSource = Join-Path $source $shared
            $sharedDestination = Join-Path $target $shared
            if ((Test-Path -LiteralPath $sharedSource -PathType Leaf) -and
                (Test-Path -LiteralPath $sharedDestination -PathType Leaf) -and
                (Hash-File $sharedDestination) -ne (Hash-File $sharedSource)) {
                throw "The existing shared t7-compiler $shared differs from this Z Mod contract. Use matching Z Mod versions; nothing was overwritten."
            }
        }
    }
    foreach ($file in (Get-ChildItem -LiteralPath $source -File -Recurse)) {
        $relative = Relative-To $file.FullName $source; $destination = Join-Path $target $relative
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $destination) | Out-Null
        $backup = [bool]$oldBackups[$relative]
        if (-not $hadMarker -and (Test-Path -LiteralPath $destination -PathType Leaf) -and (Hash-File $destination) -ne (Hash-File $file.FullName) -and -not (Test-Path -LiteralPath "$destination.ztweaks-backup" -PathType Leaf)) {
            Copy-Item -LiteralPath $destination -Destination "$destination.ztweaks-backup"; $backup = $true
        }
        Copy-Item -LiteralPath $file.FullName -Destination $destination -Force
        # Compiler config/docs are identical shared overlay infrastructure.
        # Leave them behind when one component uninstalls so another installed
        # fragment cannot lose the one-project/one-injection contract.
        if ($Slot -ne 't7compiler' -or $relative -notin @('gsc.conf','README.md')) {
            $records += [pscustomobject]@{ path=$relative; sha256=(Hash-File $destination); backup=$backup }
        }
    }
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $marker) | Out-Null
    $lines = @($records | ForEach-Object { "{0}`t{1}`t{2}" -f $_.sha256,$_.path,$([int][bool]$_.backup) })
    [IO.File]::WriteAllText($marker, (($lines -join "`n") + "`n"), (New-Object Text.UTF8Encoding($false)))
}
if ($Slot -eq 't6-mod') {
    $imageSource = Join-Path $download 'Plutonium\storage\t6\images\menu_zm_cac_backing.iwi'
    $imageDestination = Join-Path $Root 'storage\t6\images\menu_zm_cac_backing.iwi'
    if (Test-Path -LiteralPath $imageSource -PathType Leaf) {
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $imageDestination) | Out-Null
        $imageMarker = "$imageDestination.ztweaks.sha256"; $imageBackup = "$imageDestination.ztweaks-backup"
        $imageOwned = (Test-Path -LiteralPath $imageMarker -PathType Leaf) -and (Test-Path -LiteralPath $imageDestination -PathType Leaf) -and (Hash-File $imageDestination) -eq (Get-Content -LiteralPath $imageMarker -Raw).Trim()
        if ((Test-Path -LiteralPath $imageDestination -PathType Leaf) -and -not $imageOwned -and -not (Test-Path -LiteralPath $imageBackup -PathType Leaf)) { Copy-Item -LiteralPath $imageDestination -Destination $imageBackup -Force }
        Copy-Item -LiteralPath $imageSource -Destination $imageDestination -Force
        (Hash-File $imageDestination) | Set-Content -LiteralPath $imageMarker -NoNewline
    }
}
Log "installed slot=$Slot target=$target"
Write-Host "Installed ZTweaks $Slot to $target"
Write-Host "Installer log: $log"
