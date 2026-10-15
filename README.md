# ZTweaks for Black Ops II

**Optional gameplay settings for Black Ops II Zombies (Plutonium T6)**

ZTweaks, by Xep.

[**Download the latest release**](https://github.com/Xeptix/ZTweaks/releases/latest)

Set up the Zombies match you want to play, from the lobby or pause menu. Start on a
different round, bring a different loadout, speed up the horde, change the perk limit,
open the ordinary doors, or let the next game start itself. Change only the rules you
want: DEFAULT leaves that part of the map in control.

- Match setup, automatic restart and rotation among installed maps.
- Player health, movement, damage, points, perks and supported revive rules.
- Starting weapon classes, upgrades, ammo, grenades and equipment.
- Ordinary zombie health, speed, population and spawn timing.
- Startup power and doors, bank capacity, Mystery Box and power-up controls.
- Supported challenge rules and personal character preferences.
- Saved settings, host-aware controls and a compatibility report for the current map.

## Requirements

Plutonium T6, Black Ops II Zombies. The selectable mod remains the recommended complete
edition: its gameplay script, Lua settings menu and menu asset belong together. In co-op,
the host controls shared gameplay rules; each player needs a compatible settings UI
to supply their own character preference. A missing preference reply is treated as RANDOM.

## Install

Download the latest versioned `ZTweaks T6` release ZIP and extract the whole archive.

1. Run `installer/windows/install.bat`. The installer targets your Plutonium folder;
   use `-Root "path\to\Plutonium"` for a different location.
2. Start Plutonium Black Ops II Zombies and select **zm_ztweaks** under **Mods**.
3. Open **ZTWEAKS SETTINGS** in the Zombies lobby. Configure the host's match settings
   before starting a game.

On Linux, run `bash installer/linux/install.sh --root /path/to/Plutonium`.
For a manual installation, copy the archive's `Plutonium` folder into `%LOCALAPPDATA%`.
The mod lives in `Plutonium/storage/t6/mods/zm_ztweaks`.
The included `SHA256SUMS` files cover the download and its contents.

## Loose script edition

The download also carries a loose gameplay script at
`Plutonium/storage/t6/scripts/zm/ztweaks.gsc`. T6 cannot load the Lua lobby/pause menu
from a loose script, so that edition has no graphical settings page, menu background or
way for each co-op player to send a personal character choice. Configure its gameplay
dvars outside the menu; use the selectable mod for the complete interface and co-op
character preferences. The
loose script does not save settings through a graphical menu: only dvars supplied by
an external configuration or console apply.

Install that edition with `install.ps1 -Slot t6-script` or
`install.sh --slot t6-script`; the default slot remains `t6-mod`. Both installers also
support `-List/--list`, `-Find/--find`, `-Verify/--verify`,
`-Configure/--configure`, and ownership-safe `-Uninstall/--uninstall` operations.

The installer also supplies `storage/t6/images/menu_zm_cac_backing.iwi`, the shared menu
background. It backs up a pre-existing replacement and restores it on uninstall when
ZTweaks still owns the installed image. Run the Windows installer with `-Uninstall`, or
the Linux installer with `--uninstall`, to remove the installed files.

## Usage

Open **ZTWEAKS SETTINGS** in the Zombies lobby, change the rules you want, then start
the match normally. Open the same entry in the pause menu to inspect or change them
during play. The row's application boundary tells you when a change can take effect.

Use **Q/E**, **LB/RB**, or the clickable tabs to change category. Holding a tab control
keeps cycling; the first and last categories wrap around. Select a row to read what it
does and when it applies. In-game changes obey that boundary: for example, NEXT SPAWN
does not rewrite a player who has already spawned.

The **HOST / CLIENT / UNKNOWN** indicator shows your menu authority. Host-owned rows
are locked for clients and when authority cannot be established. Personal character
preferences remain editable. A locked host row says **HOST VALUE UNAVAILABLE** if no
authoritative value is available; it does not present your local preference as the host's.
Greyed or forced rows remain selectable so their explanation can be read.

Changed settings have their own view. Reset Tab, Randomize, and Reset All ask for
confirmation and respect row ownership. Availability changes retain the selected row
and scroll position. Settings are saved in the local player's archived configuration.

## Match setup and restarting

**Starting Round** and **Starting Points** are independent. Leave either at GAME DEFAULT
to retain the map's calculation, or choose a fixed value before starting. **Headshots
Only** uses the standard Zombies rule. **Game Start Delay** adds a wait before ordinary
zombies spawn; it does not skip an intro or remove the map's own opening sequence.

**Auto Restart Level** waits for the normal game-over results, returns to the lobby,
and starts another match. **Next Map** independently chooses CURRENT MAP, RANDOM STOCK,
RANDOM CUSTOM or RANDOM ALL from installed maps. A random choice avoids the current map
when another valid map exists. With Auto Restart off, Next Map changes the lobby
selection but does not launch it. Manual End Game does not automatically start another
match. The pause menu adds Restart Level only where the stock menu lacks that action.

## Player rules and perks

**Perk Limit** can keep the map's limit, set a number or remove the limit. An explicit
ZTweaks limit takes precedence over ZShare's while retaining map-added perk slots.
**Random Starting Perks** gives each player a separate selection from perks registered
by that map, without duplicates; **Start With All Perks** takes precedence over it.

Health and movement scale from normal values. **Point Gain** changes positive awards,
not purchase costs. Weapon and melee damage have separate multipliers. Standard fall
damage can be scaled or disabled, explosive self-damage can be prevented, and Spawn
Protection adds a short period of damage immunity after spawning.

Revive Time and Bleed-out Time scale the map's standard timers. Down Limit controls
ordinary co-op downs, not solo auto-revives or special roles. Perk-loss and weapon-
retention options are available only where a safe implementation exists; a menu choice
does not bypass a private map inventory or last-stand system.

## Starting loadouts

Choose a primary starting **weapon class**, with an optional secondary class. ZTweaks
uses weapons registered by the map, not an imported gun list. An unavailable class
leaves the map's default in place. Starting Weapon Upgraded can Pack-a-Punch either
selected slot or both where a safe upgraded variant exists.

Starting Ammo controls the initial fill, including EMPTY. Max Reserve Ammo scales
native reserve grants without replacing the weapon's magazine or ammo type; asset
limits can cap the result. Grenade/equipment type, starting count and carried capacity
are separate settings. If both starting count and capacity are set, the lower count
wins. Unsupported equipment is not silently substituted with a different item.

## Zombies and round pacing

Zombie Health and Speed scale the map's ordinary round curves. Each has a RANDOM
choice that picks one of its listed percentages for the match. **Zombies Per Round**
changes the standard population, while **Zombie Spawn Rate** changes the delay between
ordinary spawns: a higher rate means a shorter wait.

**Round Delay** sets the standard wait between rounds. INSTANT removes that wait, not
the round-change presentation or scripted events. Map-owned special enemies, objective
spawns and special rounds are not forced through ordinary-zombie rules.

## Power, doors and the Mystery Box

**Start With Power On** activates compatible stock power consumers, including published
power zones. It does not complete generator counters or activation rituals on the map's
behalf. Systems that normally listen to power can still unlock through that path.

**Start With Doors Open** opens ordinary purchasable doors, barriers, debris and supported
power-gated blockers through their normal paths after spawning. It is not an Easter
egg or quest-completion switch; kill-counter and custom quest blockers stay map-owned.

**Mystery Box Quality** can exclude registered wonder weapons, favor stronger registered
weapons, or use the full map pool while keeping ownership and quest-safety checks.
**Mystery Box Lock** prevents normal random relocation, not a scripted quest move.
**Bank Limit** changes the BO2 persistent bank cap where that system exists; it does
nothing on maps without a standard bank.

## Power-ups

Ground Time changes how long a normal drop waits before its flashing phase. Effect
Time scales registered timed effects. For a repeated active power-up, Stacking can
**REFRESH** its duration, **EXTEND** the timer or **IGNORE** the extra pickup's timer
change. Map-specific and infinite quest-drop lifetimes remain in control.

Drop Rate and Drop Cap are independent: the first reaches ordinary score thresholds
sooner or later, while the second limits regular drops per round. Neither is a global
rewrite of boss rewards, random kill drops or scripted quest power-ups.

## Challenges

The challenge page offers restrictions such as No Perks, No Pack-a-Punch, No Mystery
Box and One-Box Challenge where the map exposes a safe control. Random Starting
Loadout chooses separately for each player; explicit primary/secondary choices win.
Randomized Rules chooses one compatible shared challenge without replacing explicit
challenge selections.

Some listed rules, including starting-room, wall-only, gun progression or private
perk/inventory behavior, can be unavailable. The compatibility report is authoritative:
a listed option is not a promise to override every map's custom scripts.

## Character preferences

Choose names for **Victis** (TranZit, Die Rise, Buried), **Mob of the Dead**, and
**Origins**. Each player saves their own preferences. RANDOM (VANILLA) retains the
initial character unless displaced by another player's request; displaced players get
a remaining character. The host wins a contested preference; non-host ties are random.
Required co-op story roles take precedence and characters are not duplicated.

Swaps happen after normal spawn through the map's identity callback, not in the intro.
The other saved casts are available to custom maps that explicitly supply a compatible
character adapter; unknown casts stay untouched. See [the character settings](SETTINGS.md#characters)
for every name and family.

## Configuration and saved settings

The menu is the normal configuration route. Every row has a dvar, default and application
boundary in [SETTINGS.md](SETTINGS.md). GAME DEFAULT is not the same as forcing 100%:
the default leaves map behavior alone, while an explicit setting requests an override.

| Boundary | When the setting can apply |
| --- | --- |
| NEXT MATCH | Set before starting; it does not rebuild a running match. |
| NEXT SPAWN / NEXT DOWN | The next qualifying player event, not a live player rewrite. |
| NEXT ROUND | The next standard round calculation. |
| NEXT DROP / NEXT POWER-UP | The next qualifying drop or pickup. |
| NEXT GAME OVER | The next normal completed-game transition. |

Menu selections are archived in the local player configuration. The host's settings
govern shared match rules; joining players' local values do not replace them. Use the
changed-settings view to inspect overrides and Reset to return to inherited defaults.
Restoring a setting does not undo an event already performed, such as a door opened
at match start; begin a fresh match to reset the map.

## Compatibility and other Z mods

DEFAULT settings make no gameplay change. Enabled settings check the map's capabilities.
The **COMPATIBILITY REPORT** distinguishes active, partially applied, unavailable, and
conflicting settings. An unavailable rule leaves the map's system in control. Quest
blockers, temporary player bodies, and private inventory/last-stand systems are not
replaced merely to force a setting to apply.

Use **ZBundle** to run ZTweaks alongside ZPause, ZShare, and ZStats as one selected mod.
Subscribing to or installing multiple standalone mods does not merge their menus or
scripts. The bundle uses the shared **ZBUNDLE SETTINGS** entry and keeps each component's
settings under its owner.

- [ZPause on GitHub](https://github.com/Xeptix/ZPause) adds a synced co-op pause.
- [ZShare on GitHub](https://github.com/Xeptix/ZShare) adds weapon, point, and purchase sharing.
- [ZStats on GitHub](https://github.com/Xeptix/ZStats) adds a stats HUD, personal bests, and match recaps.

For an unexpected result, include the map, selected mod/version, setting and value,
whether you were host, and the compatibility reason or game log. A failed map load
without ZTweaks selected is not by itself evidence of a ZTweaks regression.

## Ports

This is the BO2 edition. The [BO3 edition](https://github.com/Xeptix/ZTweaksT7) uses
the same menu conventions and shared settings where the engine supports them. Bank
capacity is BO2-only; GobbleGum scaling is BO3-only. Map availability can differ.

## Changelog

### v1.4

- Pace the initial co-op Compatibility report after round readiness instead of
  sending all active rows at once. Live status changes still appear.
- The BO2 gameplay choices and menu remain unchanged; unsupported map systems
  continue to fail safe.

### v1.3

- This maintenance release keeps the BO2 gameplay and menu settings from v1.2.
- The BO2 package is rebuilt alongside the BO3 co-op loading fix so both editions
  carry the same release version and installer contract.

### v1.2

- New starting-weapon Pack-a-Punch, standard Box/Fire Sale/trap pricing, box teddy
  and repeat controls, six ordinary power-up exclusions, and One Weapon Slot.
- New ordinary combat and reward controls: melee and Pack-a-Punch damage, health
  regeneration delay, rising player damage, round bonus, Max Ammo reload, and
  points retained after an ordinary death.
- Experimental Tweaks defaults OFF. Its Faster Barrier Rebuild option only acts
  on compatible stock barriers; enabling it never forces unsupported custom maps.
- The shared menu retains the visible tab window after a setting change. Unsupported
  systems report a compatibility reason and keep the map's own behavior.

### v1.1

- Twelve-language menu and notice catalogs with English fallback and portable,
  owner-aware localization for standalone and ZBundle rows.
- A limited loose-script route with ownership-safe Windows/Linux installers and
  explicit menu, persistence, and co-op preference limitations.
- Shared menu/action authority fixes, collision-safe ZBundle integration, and
  stricter reproducible packaging and installer lifecycle checks.
- Compatibility-first map adapters retain stock ownership when a custom map does
  not expose a supported system; the stock-map matrix covers every BO2 Zombies route.

### v1.0

- Settings menu hardening: effective disabled/forced values, grey inactive rows,
  stable refresh focus/scroll, live CHANGED availability and guarded button actions.
- First public release, distributed as a Plutonium mod.
- Persistent lobby and pause settings, host-aware locks, row explanations, and a
  per-match compatibility report.
- Match, player, loadout, zombie, world, bank, power-up, and challenge controls.
- Saved named character preferences with host-priority co-op assignment and custom-map
  adapter support.
- Normal-results Auto Restart, installed-map rotation, and the missing-row Restart fallback.

## Credits and support

### Translations

ZTweaks supports English, French, German, Italian, Spanish,
Brazilian Portuguese, Russian, Polish, Japanese, Simplified and Traditional Chinese,
Korean, and Czech. Translations were made by AI and may contain mistakes.
ChatGPT produced the initial translations.
Please [report incorrect or unclear translations](https://github.com/Xeptix/ZTweaks/issues)
so I can get them fixed. Include the game, version, language, menu or setting,
current wording and suggested correction; a screenshot is helpful.

By Xep. Built around Treyarch's Zombies systems. MIT licensed; see [LICENSE](LICENSE).

[![Support the mod on Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/xeptix)
[![Support the mod on Patreon](https://img.shields.io/badge/Patreon-Xeptix-F96854?logo=patreon&logoColor=white)](https://www.patreon.com/Xeptix)
[![Join the Discord](https://img.shields.io/badge/Discord-Join-5865F2?logo=discord&logoColor=white)](https://discord.gg/RE85HRwYZZ)
