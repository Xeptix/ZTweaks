# ZTweaks Black Ops II settings

Generated from the shared settings catalog. Configure these in ZTweaks Settings;
the compatibility report determines which choices the current map can apply.

DEFAULT inherits the map's behavior. Character preferences use RANDOM (VANILLA).
Rows without a safe implementation report unavailable rather than changing the map.

## MATCH

### AUTO RESTART LEVEL

Restart the current level after the normal game-over results have been shown. DEFAULT is OFF.

Dvar: `zt_auto_restart`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### NEXT MAP

Choose the map selected after every completed game. This works independently of Auto Restart: with Auto Restart off, ZTweaks changes the lobby selection without launching it. Random choices exclude the current map when another valid map exists.

Dvar: `zt_next_map`. Default: `same`. Applies: NEXT GAME OVER.

Choices: `same` = CURRENT MAP, `stock` = RANDOM STOCK, `custom` = RANDOM CUSTOM, `all` = RANDOM ALL.

### STARTING ROUND

Round used when a new match begins. GAME DEFAULT leaves the map's normal starting round and starting-points calculation untouched.

Dvar: `zt_starting_round`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `1` = 1, `5` = 5, `10` = 10, `15` = 15, `20` = 20, `30` = 30, `50` = 50.

### STARTING POINTS

Points given to each player when a new match begins. GAME DEFAULT preserves the map's normal behavior, including BO3's stock starting-round calculation of 500 points per selected round.

Dvar: `zt_starting_points`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `500` = 500, `1000` = 1,000, `2500` = 2,500, `5000` = 5,000, `10000` = 10,000, `25000` = 25,000, `50000` = 50,000.

### HEADSHOTS ONLY

Require headshots for standard zombie kills using the stock Zombies rule. OFF is inert and leaves the map's own game setting unchanged.

Dvar: `zt_headshots_only`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### GAME START DELAY

Additional seconds before ordinary zombies begin spawning in the first round. GAME DEFAULT preserves the map's own delay; this does not remove the stock round-opening presentation or map-authored scripted waits.

Dvar: `zt_game_start_delay`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = GAME DEFAULT, `0` = NO EXTRA DELAY, `2` = 2 SECONDS, `5` = 5 SECONDS, `10` = 10 SECONDS, `15` = 15 SECONDS, `20` = 20 SECONDS, `30` = 30 SECONDS.

### EXPERIMENTAL TWEAKS

Allow selected stock-map-only tweaks. Custom-map support may be limited. OFF makes every experimental tweak inert even if its own saved option is ON; it does not relax compatibility checks or other Z mods' ownership.

Dvar: `zt_experimental_tweaks`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

## PLAYER

### PERK LIMIT

Maximum perks a player may hold. DEFAULT leaves the map or ZShare in control; a number replaces the base limit while preserving map-added slots; UNLIMITED removes the limit. ZTweaks takes precedence over ZShare when enabled.

Dvar: `zt_perk_limit`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `4` = 4, `5` = 5, `6` = 6, `8` = 8, `-1` = UNLIMITED.

### PLAYER HEALTH

Percentage of normal player health. GAME DEFAULT leaves the map in control. Perks continue to scale from the modified base health.

Dvar: `zt_player_health`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = GAME DEFAULT, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### HEALTH REGEN DELAY

Percentage of the stock delay before health regeneration begins after damage. GAME DEFAULT preserves the map's delay. This does not change the regeneration rate or map-owned healing systems.

Dvar: `zt_health_regen_delay`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `50` = 50%, `150` = 150%, `200` = 200%.

### PLAYER SPEED

Percentage of normal player movement speed applied at spawn. GAME DEFAULT leaves movement untouched so map-authored movement rules remain authoritative.

Dvar: `zt_player_speed`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = GAME DEFAULT, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### RANDOM STARTING PERKS

Number of random perks granted independently to each player when they spawn. NONE is inert. Perks are chosen without duplicates from those registered by the current map; if fewer are available, every available perk is granted.

Dvar: `zt_random_starting_perks`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = NONE, `1` = 1, `2` = 2, `3` = 3, `4` = 4, `5` = 5, `6` = 6, `7` = 7, `8` = 8.

### START WITH ALL PERKS

Grant every perk registered by the current map at spawn. OFF is inert. When enabled, this takes precedence over Random Starting Perks.

Dvar: `zt_start_all_perks`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = OFF, `1` = ON.

### POINT GAIN

Percentage of normal positive score awards, including zombie damage, kills, headshots, and standard repairs. GAME DEFAULT leaves every map-authored award unchanged; point costs are never scaled.

Dvar: `zt_point_gain`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `25` = 25%, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### POINTS RETAINED AFTER DEATH

Percentage of points kept at the next standard spectator respawn, after any stock minimum-respawn score is applied. The rest is lost. GAME DEFAULT preserves the map's death penalty; custom death-score rules remain map-owned.

Dvar: `zt_death_points_retained`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = GAME DEFAULT, `100` = 100%, `50` = 50%, `0` = 0%.

### WEAPON DAMAGE

Percentage of normal player weapon damage dealt to zombies. Melee uses its own setting. GAME DEFAULT preserves the stock and custom-map damage path.

Dvar: `zt_weapon_damage`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `25` = 25%, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### MELEE DAMAGE

Percentage of normal player melee damage dealt to zombies. GAME DEFAULT leaves knife, melee weapon, perk, and map behavior untouched.

Dvar: `zt_melee_damage`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `25` = 25%, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### PACK-A-PUNCH DAMAGE

Scale ordinary hits from registered Pack-a-Punched weapons against standard zombies. GAME DEFAULT preserves normal damage. Custom upgrades and map-owned damage callbacks remain unchanged.

Dvar: `zt_pap_damage_multiplier`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `50` = 50%, `150` = 150%, `200` = 200%.

### EXPLOSIVE SELF-DAMAGE

Prevent a player's own grenades, launchers, and other standard explosives from damaging that player. OFF leaves the stock damage callback untouched.

Dvar: `zt_no_explosive_self_damage`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = NO SELF-DAMAGE.

### FALL DAMAGE

Scale standard fall damage or turn it off. GAME DEFAULT delegates to the map; custom scripted hazards are not reclassified as falls.

Dvar: `zt_fall_damage`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `-1` = OFF, `25` = 25%, `50` = 50%, `75` = 75%, `100` = 100%, `150` = 150%, `200` = 200%, `300` = 300%.

### DOWN LIMIT

Maximum ordinary co-op downs before stock bleeds the player out instead of allowing another revive. UNLIMITED keeps stock co-op's unlimited downs. Solo auto-revive, special-role and non-composable map routes stay stock and report unavailable.

Dvar: `zt_down_limit`. Default: `0`. Applies: NEXT DOWN.

Choices: `0` = GAME DEFAULT, `-1` = UNLIMITED, `1` = 1, `2` = 2, `3` = 3, `5` = 5, `10` = 10.

### REVIVE TIME

Percentage of the map's normal revive interaction time. GAME DEFAULT preserves map, perk, and equipment modifiers.

Dvar: `zt_revive_time`. Default: `0`. Applies: NEXT DOWN.

Choices: `0` = GAME DEFAULT, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### BLEED-OUT TIME

Percentage of the map's normal last-stand bleed-out duration. GAME DEFAULT preserves the map's timer.

Dvar: `zt_bleedout_time`. Default: `0`. Applies: NEXT DOWN.

Choices: `0` = GAME DEFAULT, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### SPAWN PROTECTION

Seconds of damage immunity after a player spawns or respawns. GAME DEFAULT adds no ZTweaks protection and leaves map-authored protection alone.

Dvar: `zt_spawn_protection`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = GAME DEFAULT, `1` = 1 SECOND, `2` = 2 SECONDS, `3` = 3 SECONDS, `5` = 5 SECONDS, `10` = 10 SECONDS.

### LOSE PERKS ON DOWN

Choose how many perks are removed through the standard down path. MAP DEFAULT keeps the map rule; NONE attempts to preserve every standard registered perk.

Dvar: `zt_lose_perks_on_down`. Default: `default`. Applies: NEXT DOWN.

Choices: `default` = MAP DEFAULT, `all` = ALL, `none` = NONE, `1` = 1, `2` = 2, `3` = 3, `4` = 4.

### KEEP WEAPONS AFTER BLEED-OUT

Restore a player's standard weapon inventory after bleeding out and respawning. OFF leaves the map's death and respawn loadout untouched.

Dvar: `zt_keep_weapons_bleedout`. Default: `0`. Applies: NEXT BLEED-OUT.

Choices: `0` = OFF, `1` = ON.

## CHARACTERS

### VICTIS

Preferred character on TranZit, Die Rise, or Buried. Solo and co-op: host wins ties; tied non-hosts draw randomly. RANDOM keeps the stock choice unless displaced. No T7 stock map uses Victis.

Dvar: `scr_zt_char_victis`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = RANDOM (VANILLA), `0` = RUSSMAN, `1` = STUHLINGER, `2` = MISTY, `3` = MARLTON.

### MOB OF THE DEAD

Preferred Mob of the Dead character, solo or co-op. Host wins ties; tied non-hosts draw randomly. RANDOM keeps the stock choice unless displaced. No T7 stock map uses this cast.

Dvar: `scr_zt_char_mob`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = RANDOM (VANILLA), `0` = FINN, `1` = SAL, `2` = BILLY, `3` = WEASEL.

### ORIGINS

Preferred Origins character in either game, solo or co-op; saved separately from Primis. Host wins ties; tied non-hosts draw randomly. RANDOM keeps stock unless displaced. Required co-op story roles are preserved.

Dvar: `scr_zt_char_origins`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = RANDOM (VANILLA), `0` = DEMPSEY, `1` = NIKOLAI, `2` = RICHTOFEN, `3` = TAKEO.

### SHADOWS OF EVIL

Preferred Shadows of Evil character, solo or co-op. Host wins ties; tied non-hosts draw randomly. RANDOM keeps the stock choice unless displaced. No T6 stock map uses this cast.

Dvar: `scr_zt_char_soe`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = RANDOM (VANILLA), `0` = FLOYD, `1` = JACK VINCENT, `2` = JESSICA, `3` = NERO.

### PRIMIS

Preferred character on The Giant, Der Eisendrache, Zetsubou, Gorod Krovi or Revelations, solo or co-op. Origins is separate. Host wins ties; tied non-hosts draw randomly. Required co-op story roles are preserved.

Dvar: `scr_zt_char_primis`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = RANDOM (VANILLA), `0` = DEMPSEY, `1` = NIKOLAI, `2` = RICHTOFEN, `3` = TAKEO.

### ULTIMIS

Preferred character on BO3 Moon, Ascension, Shangri-La, Kino, Nacht, Verruckt or Shi No Numa. Solo and co-op: host wins ties; tied non-hosts draw randomly. Required co-op roles are preserved. No T6 stock map uses Ultimis.

Dvar: `scr_zt_char_ultimis`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = RANDOM (VANILLA), `0` = DEMPSEY, `1` = NIKOLAI, `2` = RICHTOFEN, `3` = TAKEO.

## LOADOUT

### STARTING WEAPON

Weapon class that replaces the map's primary starting weapon. MAP DEFAULT preserves the map choice. If the selected class is unavailable, ZTweaks safely keeps the map default.

Dvar: `zt_starting_weapon`. Default: `default`. Applies: NEXT MATCH.

Choices: `default` = MAP DEFAULT, `pistol` = PISTOL, `burst` = BURST PISTOL, `smg` = SMG, `shotgun` = SHOTGUN, `ar` = ASSAULT RIFLE, `lmg` = LMG, `sniper` = SNIPER RIFLE.

### SECONDARY WEAPON

Optional additional starting weapon class. MAP DEFAULT grants no extra weapon. This is separate from the primary Starting Weapon override and does not replace or select the primary.

Dvar: `zt_secondary_starting_weapon`. Default: `default`. Applies: NEXT SPAWN.

Choices: `default` = MAP DEFAULT, `pistol` = PISTOL, `burst` = BURST PISTOL, `smg` = SMG, `shotgun` = SHOTGUN, `ar` = ASSAULT RIFLE, `lmg` = LMG, `sniper` = SNIPER RIFLE.

### STARTING GRENADE

Lethal grenade type given at spawn. MAP DEFAULT preserves the map's choice. A selected type is used only when that map has registered a compatible grenade.

Dvar: `zt_starting_grenade`. Default: `default`. Applies: NEXT SPAWN.

Choices: `default` = MAP DEFAULT, `frag` = FRAG, `semtex` = SEMTEX.

### STARTING GRENADES

Number of lethal grenades given at spawn. GAME DEFAULT preserves stock start ammo. When Max Grenades is also enabled, the lower value wins at spawn.

Dvar: `zt_starting_grenade_count`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = GAME DEFAULT, `1` = 1, `2` = 2, `3` = 3, `4` = 4, `6` = 6, `8` = 8, `10` = 10.

### MAX GRENADES

Carried lethal-grenade capacity. GAME DEFAULT leaves the weapon and map limit untouched; enabled values initialize newly granted grenades to this amount and cap later grants at it.

Dvar: `zt_max_grenades`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = GAME DEFAULT, `2` = 2, `4` = 4, `6` = 6, `8` = 8, `10` = 10.

### STARTING EQUIPMENT

Tactical or placeable equipment given at spawn. MAP DEFAULT preserves the map choice. Unsupported items fail closed instead of substituting a different type.

Dvar: `zt_starting_equipment`. Default: `default`. Applies: NEXT SPAWN.

Choices: `default` = MAP DEFAULT, `monkey` = MONKEY BOMB, `emp` = EMP GRENADE, `mine` = MINE.

### STARTING EQUIPMENT COUNT

Amount of the active tactical or placeable equipment given at spawn. GAME DEFAULT preserves stock start ammo. When Max Equipment is enabled, the lower value wins at spawn.

Dvar: `zt_starting_equipment_count`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = GAME DEFAULT, `1` = 1, `2` = 2, `3` = 3, `4` = 4, `6` = 6.

### MAX EQUIPMENT

Carried tactical or placeable-equipment capacity. GAME DEFAULT leaves each item and map in control; enabled values initialize newly granted equipment to this amount and cap later grants at it.

Dvar: `zt_max_equipment`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = GAME DEFAULT, `1` = 1, `2` = 2, `3` = 3, `4` = 4, `6` = 6.

### STARTING AMMO

Percentage of normal starting ammo for the player's starting weapons. GAME DEFAULT preserves stock ammo; EMPTY leaves the weapon with no reserve or loaded rounds.

Dvar: `zt_starting_ammo`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = GAME DEFAULT, `-1` = EMPTY, `25` = 25%, `50` = 50%, `75` = 75%, `100` = FULL.

### MAX RESERVE AMMO

Scale the native reserve ammo granted to selected or inherited starting weapons while retaining each weapon's own magazine and ammo type. Values above an asset's hard capacity safely clamp and report degraded compatibility. GAME DEFAULT preserves stock ammo.

Dvar: `zt_reserve_ammo`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = GAME DEFAULT, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### STARTING WEAPON PACK-A-PUNCHED

Spawn with the selected ZTweaks starting weapon slots Pack-a-Punched when the map registers a safe upgraded variant. MAP DEFAULT leaves both slots unmodified.

Dvar: `zt_starting_weapon_upgraded`. Default: `default`. Applies: NEXT SPAWN.

Choices: `default` = MAP DEFAULT, `primary` = PRIMARY, `secondary` = SECONDARY, `both` = BOTH.

## ZOMBIES

### ZOMBIE HEALTH

Percentage of the map's normal zombie-health curve. GAME DEFAULT leaves both starting health and round-to-round growth untouched. RANDOM independently chooses one listed percentage when each match initializes.

Dvar: `zt_zombie_health`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `25` = 25%, `50` = 50%, `75` = 75%, `100` = 100%, `150` = 150%, `200` = 200%, `300` = 300%, `500` = 500%, `-1` = RANDOM.

### ZOMBIE DAMAGE

Percentage of direct damage dealt to players by ordinary zombies. GAME DEFAULT preserves map damage; bosses, quest actors, traps, and environmental damage remain map-controlled.

Dvar: `zt_zombie_damage`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `25` = 25%, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### ZOMBIE SPEED

Percentage of the map's normal zombie speed curve. GAME DEFAULT is inert. RANDOM independently chooses one listed percentage when each match initializes. Standard round zombies are scaled; map-owned special enemies remain untouched.

Dvar: `zt_zombie_speed`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%, `-1` = RANDOM.

### ZOMBIES PER ROUND

Percentage of the standard zombie count calculated for each round. GAME DEFAULT is inert. Scripted special rounds and objective spawns remain map-controlled.

Dvar: `zt_zombies_per_round`. Default: `0`. Applies: NEXT ROUND.

Choices: `0` = GAME DEFAULT, `25` = 25%, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### ROUND DELAY

Seconds between a completed round and the next round. GAME DEFAULT preserves the map's delay. INSTANT removes only the standard between-round wait; round-change HUD and map-authored scripted waits remain intact.

Dvar: `zt_round_delay`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = GAME DEFAULT, `0` = INSTANT, `2` = 2 SECONDS, `5` = 5 SECONDS, `10` = 10 SECONDS, `15` = 15 SECONDS, `20` = 20 SECONDS, `30` = 30 SECONDS.

### ROUND BONUS

Extra points awarded to each active player when a standard round ends. GAME DEFAULT adds no bonus. Map-authored round rewards remain unchanged.

Dvar: `zt_round_bonus`. Default: `0`. Applies: NEXT ROUND.

Choices: `0` = GAME DEFAULT, `100` = 100, `250` = 250, `500` = 500.

### ZOMBIE SPAWN RATE

Percentage of the map's normal standard-zombie spawn cadence. Higher values shorten the delay between ordinary spawns. GAME DEFAULT is inert; special, objective, and scripted spawners remain map-controlled.

Dvar: `zt_zombie_spawn_rate`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

## WORLD

### FASTER BARRIER REBUILD

Reduce the pause between standard barrier-board repairs. Requires Experimental Tweaks. Available only on recognized stock maps with the stock blocker system; custom-map support may be limited. A map-authored repair delay always wins.

Dvar: `zt_fast_barrier_rebuild`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### START WITH POWER ON

Turn on the map's stock power consumers at match start. Global systems use the common power state; zoned systems activate published perk, random-perk, and door power zones. Activation rituals/generators and their counters remain map-controlled; downstream systems that listen to real power, including stock traversal and Pack-a-Punch, still unlock.

Dvar: `zt_start_power_on`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### START WITH DOORS OPEN

Open ordinary, delayed, and power-gated purchasable doors, barriers, debris, and airlocks for free through their stock blocker paths after the first player spawns. Kill-counter and custom scripted quest blockers remain map-controlled.

Dvar: `zt_start_doors_open`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### MAX AMMO RELOADS MAGAZINES

After a standard Max Ammo pickup refills reserves, also refill the magazines of eligible held firearms. OFF preserves stock behavior. Quest equipment, excluded weapons, custom ammo systems, and a replacement weapon acquired during pickup remain untouched.

Dvar: `zt_max_ammo_reload`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### DISABLE NUKE DROPS

Exclude this type from regular random drops when another eligible type exists. Scripted drops are unchanged. If all are excluded, one eligible type remains to avoid stalling the game.

Dvar: `zt_disable_nuke_drops`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### DISABLE MAX AMMO DROPS

Exclude this type from regular random drops when another eligible type exists. Scripted drops are unchanged. If all are excluded, one eligible type remains to avoid stalling the game.

Dvar: `zt_disable_max_ammo_drops`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### DISABLE INSTA-KILL DROPS

Exclude this type from regular random drops when another eligible type exists. Scripted drops are unchanged. If all are excluded, one eligible type remains to avoid stalling the game.

Dvar: `zt_disable_insta_kill_drops`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### DISABLE DOUBLE POINTS DROPS

Exclude this type from regular random drops when another eligible type exists. Scripted drops are unchanged. If all are excluded, one eligible type remains to avoid stalling the game.

Dvar: `zt_disable_double_points_drops`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### DISABLE CARPENTER DROPS

Exclude this type from regular random drops when another eligible type exists. Scripted drops are unchanged. If all are excluded, one eligible type remains to avoid stalling the game.

Dvar: `zt_disable_carpenter_drops`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### DISABLE FIRE SALE DROPS

Exclude this type from regular random drops when another eligible type exists. Scripted drops are unchanged. If all are excluded, one eligible type remains to avoid stalling the game.

Dvar: `zt_disable_fire_sale_drops`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### POWER-UP GROUND TIME

Seconds a normal dropped power-up remains collectible before its stock flashing phase begins. GAME DEFAULT uses 15 seconds. Map-authored custom lifetimes, infinite quest drops, and BO3 Temporal Gift remain authoritative.

Dvar: `zt_powerup_ground_time`. Default: `0`. Applies: NEXT DROP.

Choices: `0` = GAME DEFAULT, `5` = 5 SECONDS, `10` = 10 SECONDS, `15` = 15 SECONDS, `20` = 20 SECONDS, `30` = 30 SECONDS, `45` = 45 SECONDS, `60` = 60 SECONDS.

### POWER-UP EFFECT TIME

Percentage of each timed power-up's map-selected effect duration. This includes team, global, and player-only timed effects registered through the stock power-up system. GAME DEFAULT preserves every map-authored duration.

Dvar: `zt_powerup_effect_time`. Default: `0`. Applies: NEXT POWER-UP.

Choices: `0` = GAME DEFAULT, `25` = 25%, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### POWER-UP DROP RATE

Multiplier for stock regular score-threshold power-up drops. Higher values reach each drop threshold sooner. GAME DEFAULT preserves the map threshold; max-per-round, random kill drops, and scripted drops remain untouched.

Dvar: `zt_powerup_drop_rate`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `25` = 25%, `50` = 50%, `75` = 75%, `100` = 100%, `125` = 125%, `150` = 150%, `200` = 200%, `300` = 300%.

### POWER-UP DROP CAP

Maximum regular score-threshold power-up drops allowed in each round. GAME DEFAULT preserves the map's own cap. Scripted rewards, boss drops, quest drops, and other map-authored power-ups remain untouched.

Dvar: `zt_powerup_max_per_round`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `1` = 1, `2` = 2, `3` = 3, `4` = 4, `5` = 5, `6` = 6, `8` = 8, `10` = 10.

### TRAP PRICE

Percentage of each standard purchasable trap's map-authored price. GAME DEFAULT leaves the trap alone. Custom trap purchase callbacks and later map price changes remain map-controlled; maps without standard purchase traps are unaffected.

Dvar: `zt_trap_price_multiplier`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = GAME DEFAULT, `0` = FREE, `50` = 50%, `200` = 200%.

### MYSTERY BOX PRICE

Percentage of each standard Mystery Box location's map-authored normal price. GAME DEFAULT preserves each location's own price. FREE affects ordinary box purchases but does not change the Fire Sale price.

Dvar: `zt_box_price_multiplier`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = GAME DEFAULT, `0` = FREE, `25` = 25%, `50` = 50%, `75` = 75%, `100` = 100%, `150` = 150%, `200` = 200%.

### FIRE SALE BOX PRICE

Point cost of standard Mystery Boxes while Fire Sale is active. GAME DEFAULT preserves the stock or map-authored sale price. Normal box prices and map-authored nonstandard weapon lotteries remain untouched.

Dvar: `zt_fire_sale_box_price`. Default: `-1`. Applies: NEXT FIRE SALE.

Choices: `-1` = GAME DEFAULT, `0` = FREE, `10` = 10, `50` = 50, `100` = 100, `250` = 250, `500` = 500, `950` = 950.

### TEDDY-BEAR CHANCE

Chance of a teddy bear on each eligible standard Mystery Box pull. GAME DEFAULT keeps the map's chance. The map's minimum pulls, no-fly-away boxes, Fire Sales, and custom chance callbacks remain protected; 0% prevents ordinary teddy-bear moves.

Dvar: `zt_teddy_chance`. Default: `-1`. Applies: NEXT MATCH.

Choices: `-1` = GAME DEFAULT, `0` = 0%, `25` = 25%, `50` = 50%, `75` = 75%, `100` = 100%.

### AVOID REPEAT BOX WEAPONS

Avoid offering the same weapon on two consecutive standard Mystery Box pulls by the same player when another eligible registered weapon exists. OFF keeps stock selection. Map-authored special picks and weapon eligibility remain unchanged.

Dvar: `zt_box_no_repeat`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### MYSTERY BOX QUALITY

Adjust the standard Mystery Box weapon pool. NO WONDER WEAPONS removes registered wonder weapons; IMPROVED raises the chance of stronger registered weapons; FULL MAP POOL bypasses map-authored weighting while preserving stock ownership and quest-safety checks.

Dvar: `zt_box_quality`. Default: `default`. Applies: NEXT MATCH.

Choices: `default` = MAP DEFAULT, `no_wonders` = NO WONDER WEAPONS, `improved` = IMPROVED, `everything` = FULL MAP POOL.

### MYSTERY BOX LOCK

Prevent the standard Mystery Box from randomly relocating after normal purchases. Explicit scripted or quest-owned box moves remain map-controlled. OFF preserves every map-authored relocation rule.

Dvar: `zt_box_lock`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = LOCK LOCATION.

### POWER-UP STACKING

Choose how a repeated standard timed power-up affects its active timer. REFRESH restarts the configured duration, EXTEND adds another duration, and IGNORE preserves the current timer.

Dvar: `zt_powerup_stacking`. Default: `default`. Applies: NEXT POWER-UP.

Choices: `default` = GAME DEFAULT, `refresh` = REFRESH, `extend` = EXTEND, `ignore` = IGNORE.

### BANK LIMIT

Maximum points stored in the BO2 persistent bank. GAME DEFAULT preserves the stock 250,000-point limit. On maps without the standard bank capability this setting safely does nothing.

Dvar: `zt_bank_limit`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = GAME DEFAULT, `50000` = 50,000, `100000` = 100,000, `250000` = 250,000, `500000` = 500,000, `1000000` = 1,000,000.

## CHALLENGES

### NO PERKS

Disable standard perk acquisition and ZTweaks starting-perk grants. Map quest rewards that cannot be safely intercepted are reported as a compatibility limitation.

Dvar: `zt_challenge_no_perks`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### NO PACK-A-PUNCH

Disable the standard Pack-a-Punch interaction when the map exposes it safely. Scripted upgrade quests remain map-controlled and are reported if they cannot be disabled.

Dvar: `zt_challenge_no_pap`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### NO MYSTERY BOX

Disable the standard Mystery Box. Custom scripted weapon lotteries remain untouched unless they register the stock box capability.

Dvar: `zt_challenge_no_box`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### WALL WEAPONS ONLY

Disable standard non-wall weapon acquisition while leaving wall buys enabled. Unsupported map-authored reward systems are reported instead of forcibly removed.

Dvar: `zt_challenge_wall_only`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### STARTING ROOM ONLY

Keep players in the map's starting zone only when the map safely identifies its exit doors. The challenge disables itself rather than guessing at scripted progression blockers.

Dvar: `zt_challenge_starting_room`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### ONE-BOX CHALLENGE

Allow each player one completed standard Mystery Box purchase. Maps without the stock box-use notification disable this rule safely.

Dvar: `zt_challenge_one_box`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### GUN GAME

Progress each player through a compatible registered weapon sequence using zombie kills. The challenge disables itself if the map cannot supply a safe progression list.

Dvar: `zt_challenge_gun_game`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### RANDOM STARTING LOADOUT

Choose an independent compatible registered starting weapon loadout for each player. Explicit primary and secondary starting-weapon choices take precedence.

Dvar: `zt_challenge_random_loadout`. Default: `0`. Applies: NEXT SPAWN.

Choices: `0` = OFF, `1` = ON.

### ONE WEAPON SLOT

Limit normal weapon pickups to one primary slot through the stock weapon-limit callback. ZTweaks will not grant a secondary starting weapon. Map-owned weapon limits and scripted quest inventory remain in control.

Dvar: `zt_challenge_one_weapon_slot`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.

### RISING PLAYER DAMAGE

Increase ordinary player weapon and melee damage against standard zombies each round after round 1. The selected percentage is added per round, up to 500% of normal damage. OFF preserves the map's damage. Quest actors, friendly NPCs, and map-owned damage callbacks remain protected.

Dvar: `zt_challenge_rising_damage`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `5` = 5%, `10` = 10%, `25` = 25%.

### RANDOMIZED RULES

Select one shared, compatible challenge rule for the match and report the chosen rule to the host. Explicitly enabled challenge rows are never overwritten.

Dvar: `zt_challenge_random_rules`. Default: `0`. Applies: NEXT MATCH.

Choices: `0` = OFF, `1` = ON.
