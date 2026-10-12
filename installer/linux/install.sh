#!/usr/bin/env bash
set -euo pipefail
usage(){ echo "Usage: ./install.sh [--slot SLOT] [--root DIR] [--state-root DIR] [--yes] [--uninstall|--find|--list|--verify|--configure]"; }
slot=t6-mod; root=""; state_root=""; yes=0; action=install
while [ "$#" -gt 0 ]; do case "$1" in
  --slot) shift; slot="${1:-}";; --root) shift; root="${1:-}";; --state-root) shift; state_root="${1:-}";; --yes) yes=1;;
  --uninstall) action=uninstall;; --find) action=find;; --list) action=list;;
  --install) action=install;; --verify) action=verify;; --configure) action=configure;; -h|--help) usage; exit 0;;
  *) echo "Unknown option: $1"; usage; exit 2;; esac; shift; done
case "$slot" in t6-mod|t6-script|boiii-game|boiii-appdata|t7x-game|t7compiler);; *) usage; exit 2;; esac
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; download="$(cd "$script_dir/../.." && pwd)"; repository=0
if [ -f "$script_dir/tools/build.py" ]; then repository=1; case "$slot" in t6-*) download="$script_dir/dist/t6/src";; *) download="$script_dir/dist/t7/src";; esac; fi
steam_libraries(){
  local steam vdf library
  for steam in "$HOME/.steam/steam" "$HOME/.steam/root" "$HOME/.local/share/Steam" "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam" "$HOME/.var/app/com.valvesoftware.Steam/data/Steam"; do
    [ -d "$steam/steamapps" ]||continue
    printf '%s\n' "$steam"
    vdf="$steam/steamapps/libraryfolders.vdf"
    [ -f "$vdf" ]||continue
    while IFS= read -r library; do [ -d "$library/steamapps" ]&&printf '%s\n' "$library"; done < <(grep -oE '"path"[[:space:]]+"[^"]+"' "$vdf" 2>/dev/null|sed -E 's/.*"path"[[:space:]]+"([^"]+)".*/\1/' | sed 's/\\\\/\\/g')
  done
}
find_bo3(){
  [ -n "${BO3_DIR:-}" ]&&[ -d "$BO3_DIR" ]&&{ printf %s "$BO3_DIR"; return; }
  local library candidate prefix
  while IFS= read -r library; do
    for candidate in "$library/steamapps/common"/*Black\ Ops\ III*; do
      [ -d "$candidate" ]||continue
      case "$candidate" in *455130*) continue;; esac
      [ -f "$candidate/BlackOps3.exe" ]||[ -f "$candidate/boiii.exe" ]||[ -f "$candidate/t7x.exe" ]||continue
      printf %s "$candidate"; return
    done
  done < <(steam_libraries)
  # Proton/DeckOps and Wine expose the Windows game through drive_c. Find a
  # real existing install only; never invent a prefix or client folder.
  while IFS= read -r library; do
    prefix="$library/steamapps/compatdata/311210/pfx"
    [ -d "$prefix/drive_c/Program Files (x86)/Steam/steamapps/common/Call of Duty Black Ops III" ]&&{ printf %s "$prefix/drive_c/Program Files (x86)/Steam/steamapps/common/Call of Duty Black Ops III"; return; }
  done < <(steam_libraries)
  prefix="$HOME/.wine"
  [ -d "$prefix/drive_c/Program Files (x86)/Steam/steamapps/common/Call of Duty Black Ops III" ]&&printf %s "$prefix/drive_c/Program Files (x86)/Steam/steamapps/common/Call of Duty Black Ops III"
}
find_appdata(){
  [ -n "${BOIII_DATA_DIR:-}" ]&&[ -d "$BOIII_DATA_DIR" ]&&{ printf %s "$BOIII_DATA_DIR"; return; }
  [ -n "${LOCALAPPDATA:-}" ]&&[ -d "$LOCALAPPDATA/boiii" ]&&{ printf %s "$LOCALAPPDATA/boiii"; return; }
  local candidate library search_root
  for candidate in "$HOME/.wine/drive_c/users"/*/AppData/Local/boiii "$HOME/Games/Heroic/Prefixes"/*/drive_c/users/*/AppData/Local/boiii "$HOME/Games/Heroic/Prefixes/default"/*/drive_c/users/*/AppData/Local/boiii "$HOME/.config/heroic/Prefixes"/*/drive_c/users/*/AppData/Local/boiii "$HOME/.local/share/bottles/bottles"/*/drive_c/users/*/AppData/Local/boiii "$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles"/*/drive_c/users/*/AppData/Local/boiii; do
    [ -d "$candidate" ]&&{ printf %s "$candidate"; return; }
  done
  while IFS= read -r library; do
    for candidate in "$library/steamapps/compatdata"/*/pfx/drive_c/users/*/AppData/Local/boiii; do [ -d "$candidate" ]&&{ printf %s "$candidate"; return; }; done
  done < <(steam_libraries)
  for search_root in "$HOME/.local/share/lutris" "$HOME/Games" "$HOME/.var/app/com.heroicgameslauncher.hgl/config/heroic/Prefixes" "$HOME/.var/app/com.heroicgameslauncher.hgl/data/heroic/Prefixes"; do
    [ -d "$search_root" ]||continue
    candidate="$(find "$search_root" -type d -path '*/drive_c/users/*/AppData/Local/boiii' -print -quit 2>/dev/null || true)"
    [ -z "$candidate" ]||{ printf %s "$candidate"; return; }
  done
}
find_plutonium(){
  [ -n "${PLUTONIUM_DIR:-}" ]&&[ -d "$PLUTONIUM_DIR" ]&&{ printf %s "$PLUTONIUM_DIR"; return; }
  [ -n "${LOCALAPPDATA:-}" ]&&[ -d "$LOCALAPPDATA/Plutonium" ]&&{ printf %s "$LOCALAPPDATA/Plutonium"; return; }
  local candidate search_root
  for candidate in "$HOME/.wine/drive_c/users"/*/AppData/Local/Plutonium "$HOME/Games/Heroic/Prefixes"/*/drive_c/users/*/AppData/Local/Plutonium "$HOME/Games/Heroic/Prefixes/default"/*/drive_c/users/*/AppData/Local/Plutonium "$HOME/.config/heroic/Prefixes"/*/drive_c/users/*/AppData/Local/Plutonium "$HOME/.local/share/bottles/bottles"/*/drive_c/users/*/AppData/Local/Plutonium "$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles"/*/drive_c/users/*/AppData/Local/Plutonium; do
    [ -d "$candidate" ]&&{ printf %s "$candidate"; return; }
  done
  while IFS= read -r library; do
    candidate="$(find "$library/steamapps/compatdata" -type d -path '*/pfx/drive_c/users/*/AppData/Local/Plutonium' -print -quit 2>/dev/null || true)"
    [ -z "$candidate" ]||{ printf %s "$candidate"; return; }
  done < <(steam_libraries)
  for search_root in "$HOME/.local/share/lutris" "$HOME/Games" "$HOME/.var/app/com.heroicgameslauncher.hgl/config/heroic/Prefixes" "$HOME/.var/app/com.heroicgameslauncher.hgl/data/heroic/Prefixes"; do
    [ -d "$search_root" ]||continue
    candidate="$(find "$search_root" -type d -path '*/drive_c/users/*/AppData/Local/Plutonium' -print -quit 2>/dev/null || true)"
    [ -z "$candidate" ]||{ printf %s "$candidate"; return; }
  done
  printf %s "${XDG_DATA_HOME:-$HOME/.local/share}/Plutonium"
}
default_root(){ case "$1" in t6-*) find_plutonium;; boiii-game|t7x-game) found="$(find_bo3)"; printf %s "${found:-$HOME/.steam/steam/steamapps/common/Call of Duty Black Ops III}";; boiii-appdata) found="$(find_appdata)"; printf %s "${found:-${XDG_DATA_HOME:-$HOME/.local/share}/boiii}";; t7compiler) printf %s "$PWD/t7-compiler";; esac; }
source_rel(){ case "$1" in t6-mod) echo Plutonium/storage/t6/mods/zm_ztweaks;; t6-script) echo Plutonium/storage/t6/scripts/zm/ztweaks.gsc;; boiii-game) echo 'Black Ops III/boiii';; boiii-appdata) echo AppData/boiii/data;; t7x-game) echo t7x;; t7compiler) echo t7-compiler;; esac; }
target_rel(){ case "$1" in t6-mod) echo storage/t6/mods/zm_ztweaks;; t6-script) echo storage/t6/scripts/zm/ztweaks.gsc;; boiii-game) echo boiii;; boiii-appdata) echo data;; t7x-game) echo t7x;; t7compiler) echo '';; esac; }
kind(){ [ "$1" = t6-script ] && echo file || echo tree; }
hash_file(){ if command -v sha256sum >/dev/null 2>&1; then sha256sum "$1"|awk '{print $1}'; else shasum -a 256 "$1"|awk '{print $1}'; fi; }
installed_version(){
  local dest="$1" candidate=""
  if [ -f "$dest" ]; then candidate="$dest"; elif [ -d "$dest" ]; then candidate="$(find "$dest" -type f \( -name '*.gsc' -o -name '*.gscc' \) -print -quit 2>/dev/null || true)"; fi
  [ -n "$candidate" ]||{ printf %s -; return; }
  local version; version="$(grep -aom1 'ZTweaks v[0-9][0-9A-Za-z.\-]*' "$candidate" 2>/dev/null | sed 's/^ZTweaks v//' || true)"
  printf %s "${version:-unknown}"
}
log_line(){ mkdir -p "$(dirname "$log")"; printf '%s %s\n' "$(date -u +%FT%TZ)" "$1">>"$log"; }
slots='t6-mod t6-script boiii-game boiii-appdata t7x-game t7compiler'
if [ "$action" = list ]; then for item in $slots; do package="$download"; if [ "$repository" -eq 1 ]; then case "$item" in t6-*) package="$script_dir/dist/t6/src";; *) package="$script_dir/dist/t7/src";; esac; fi; if [ -n "$root" ]&&[ "$item" = "$slot" ]; then base="$root"; else base="$(default_root "$item")"; fi; dest="${base%/}/$(target_rel "$item")"; dest="${dest%/}"; if [ "$(kind "$item")" = file ]; then own="$dest.ztweaks.sha256"; else own="$dest/.zmods-installer/ztweaks.tsv"; fi; [ -e "$package/$(source_rel "$item")" ]&&a=yes||a=no; if [ -f "$own" ]; then i=yes; v="$(installed_version "$dest")"; else i=no; v=-; fi; printf '%-18s payload=%s installed=%s version=%s root=%s\n' "$item" "$a" "$i" "$v" "$base"; done; exit 0; fi
[ -n "$root" ]||root="$(default_root "$slot")"; source_path="$download/$(source_rel "$slot")"; target="${root%/}/$(target_rel "$slot")"; target="${target%/}"
if [ "$(kind "$slot")" = file ]; then marker="$target.ztweaks.sha256"; else marker="$target/.zmods-installer/ztweaks.tsv"; fi
log="${state_root:-${XDG_STATE_HOME:-$HOME/.local/state}}/ztweaks/installer.log"
case "$action" in
 find) echo "Slot: $slot"; echo "Root: $root"; [ -e "$source_path" ]&&echo 'Payload available: yes'||echo 'Payload available: no'; [ -f "$marker" ]&&echo 'Installed marker: yes'||echo 'Installed marker: no'; exit 0;;
 configure) case "$slot" in t6-*) s=ztweaks-t6.settings;; *) s=ztweaks-t7.settings;; esac; echo "Settings reference: $download/$s"; [ ! -f "$download/$s" ]||cat "$download/$s"; echo 'Change these settings in the ZTweaks/ZBundle menu; the list above is the exact installed dvar reference.'; exit 0;;
 verify) [ -f "$marker" ]||{ echo "No ZTweaks ownership marker for $slot"; exit 1; }; bad=0; if [ "$(kind "$slot")" = file ]; then [ -f "$target" ]&&[ "$(hash_file "$target")" = "$(cat "$marker")" ]||{ echo "Missing or changed: $target"; bad=1; }; else while IFS=$'\t' read -r h r backed; do r="${r//\\//}"; [ -f "$target/$r" ]&&[ "$(hash_file "$target/$r")" = "$h" ]||{ echo "Missing or changed: $target/$r"; bad=1; }; done<"$marker"; fi; [ "$bad" -eq 0 ]||exit 1; echo "Verified ZTweaks slot $slot at $target"; exit 0;;
 uninstall) [ -f "$marker" ]||{ echo "ZTweaks slot $slot is not owned by this installer."; exit 0; }; if [ "$yes" -ne 1 ]; then read -r -p "Remove installer-owned ZTweaks files from $target? [y/N] " a; case "$a" in y|Y|yes|YES);; *) exit 0;; esac; fi; changed=0; file_kind=0; if [ "$(kind "$slot")" = file ]; then file_kind=1; if [ -f "$target" ]&&[ "$(hash_file "$target")" = "$(cat "$marker")" ]; then [ ! -f "$target.ztweaks-backup" ]&&rm -f -- "$target"||mv -f -- "$target.ztweaks-backup" "$target"; changed=$((changed+1)); fi; else while IFS=$'\t' read -r h r backed; do [ -n "$r" ]||continue; r="${r//\\//}"; p="$target/$r"; if [ -f "$p" ]&&[ "$(hash_file "$p")" = "$h" ]; then [ "$backed" != 1 ]&&rm -f -- "$p"||mv -f -- "$p.ztweaks-backup" "$p"; changed=$((changed+1)); d="$(dirname "$p")"; while [ "$d" != "$target" ]; do rmdir -- "$d" 2>/dev/null||break; d="$(dirname "$d")"; done; fi; done<"$marker"; fi; if [ "$changed" -eq 0 ]; then echo "Refusing to delete an ownership marker because no installer-owned file was removed or restored: $marker" >&2; exit 1; fi; rm -f -- "$marker"; [ "$file_kind" -eq 1 ]||rmdir -- "$(dirname "$marker")" 2>/dev/null||true; if [ "$slot" = t6-mod ]; then image="$root/storage/t6/images/menu_zm_cac_backing.iwi"; im="$image.ztweaks.sha256"; ib="$image.ztweaks-backup"; if [ -f "$im" ]&&[ -f "$image" ]&&[ "$(hash_file "$image")" = "$(cat "$im")" ]; then if [ -f "$ib" ]; then mv -f -- "$ib" "$image"; else rm -f -- "$image"; fi; fi; rm -f -- "$im"; fi; log_line "removed slot=$slot target=$target"; echo "Removed installer-owned files for $slot"; exit 0;;
esac
[ -e "$source_path" ]||{ echo "The $slot payload is missing at $source_path."; exit 1; }
if [ "$yes" -ne 1 ]; then read -r -p "Install ZTweaks $slot to $target? [Y/n] " a; case "$a" in n|N|no|NO) exit 0;; esac; fi
if [ "$(kind "$slot")" = file ]; then
  mkdir -p "$(dirname "$target")"; [ ! -f "$target" ]||[ -f "$marker" ]||[ -f "$target.ztweaks-backup" ]||cp -f -- "$target" "$target.ztweaks-backup"; cp -f -- "$source_path" "$target"; hash_file "$target">"$marker"
else
  had_marker=0; declare -A old_backups=(); if [ -f "$marker" ]; then had_marker=1; while IFS=$'\t' read -r old_h old_r old_backed; do old_r="${old_r//\\//}"; [ "$old_backed" != 1 ]||old_backups["$old_r"]=1; done<"$marker"; fi; mkdir -p "$target"
  if [ "$slot" = t7compiler ]; then
    for shared in gsc.conf README.md; do
      [ ! -f "$source_path/$shared" ]||[ ! -f "$target/$shared" ]||cmp -s -- "$source_path/$shared" "$target/$shared"||{
        echo "The existing shared t7-compiler $shared differs from this Z Mod contract. Use matching Z Mod versions; nothing was overwritten." >&2
        exit 1
      }
    done
  fi
  mkdir -p "$(dirname "$marker")"; :>"$marker"
  while IFS= read -r -d '' f; do
    r="${f#"$source_path/"}"; d="$target/$r"; mkdir -p "$(dirname "$d")"; backed="${old_backups[$r]:-0}"; if [ "$had_marker" -eq 0 ]&&[ -f "$d" ]&& ! cmp -s -- "$f" "$d"&&[ ! -f "$d.ztweaks-backup" ]; then cp -f -- "$d" "$d.ztweaks-backup"; backed=1; fi; cp -f -- "$f" "$d"
    if [ "$slot" != t7compiler ]||{ [ "$r" != gsc.conf ]&&[ "$r" != README.md ]; }; then printf '%s\t%s\t%s\n' "$(hash_file "$d")" "$r" "$backed">>"$marker"; fi
  done < <(find "$source_path" -type f -print0)
fi
if [ "$slot" = t6-mod ]&&[ -f "$download/Plutonium/storage/t6/images/menu_zm_cac_backing.iwi" ]; then image="$root/storage/t6/images/menu_zm_cac_backing.iwi"; im="$image.ztweaks.sha256"; ib="$image.ztweaks-backup"; mkdir -p "$(dirname "$image")"; owned=0; [ -f "$im" ]&&[ -f "$image" ]&&[ "$(hash_file "$image")" = "$(cat "$im")" ]&&owned=1||true; [ -f "$image" ]&&[ "$owned" -eq 0 ]&&[ ! -f "$ib" ]&&cp -f -- "$image" "$ib"||true; cp -f -- "$download/Plutonium/storage/t6/images/menu_zm_cac_backing.iwi" "$image"; hash_file "$image">"$im"; fi
log_line "installed slot=$slot target=$target"
echo "Installed ZTweaks $slot to $target"
echo "Installer log: $log"
