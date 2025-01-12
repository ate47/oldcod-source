#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_powerup_full_ammo;

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 0, eflags: 0x2
// Checksum 0x5529d098, Offset: 0x108
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_full_ammo", &__init__, undefined, undefined);
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 0, eflags: 0x0
// Checksum 0x32bdd43f, Offset: 0x150
// Size: 0x84
function __init__() {
    zm_powerups::register_powerup("full_ammo", &grab_full_ammo);
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("full_ammo", "p7_zm_power_up_max_ammo", #"zombie/powerup_max_ammo", &function_5ddf4793, 0, 0, 0);
    }
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 1, eflags: 0x0
// Checksum 0x5c03e714, Offset: 0x1e0
// Size: 0x8c
function grab_full_ammo(player) {
    if (zm_powerups::function_ffd24ecc(#"full_ammo")) {
        level thread function_38941e7a(self, player);
    } else {
        level thread full_ammo_powerup(self, player);
    }
    player thread zm_powerups::powerup_vo("full_ammo");
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 2, eflags: 0x0
// Checksum 0x25c29d5, Offset: 0x278
// Size: 0x2b4
function function_38941e7a(e_powerup, player) {
    if (isdefined(level.check_player_is_ready_for_ammo)) {
        if ([[ level.check_player_is_ready_for_ammo ]](player) == 0) {
            return;
        }
    }
    a_w_weapons = player getweaponslist(0);
    player.var_48044c94 = undefined;
    player notify(#"zmb_max_ammo");
    player notify(#"hash_1fdb7e931333fd8b");
    player zm_placeable_mine::disable_all_prompts_for_player();
    foreach (w_weapon in a_w_weapons) {
        if (level.headshots_only && zm_loadout::is_lethal_grenade(w_weapon)) {
            continue;
        }
        if (isdefined(level.zombie_include_equipment) && isdefined(level.zombie_include_equipment[w_weapon]) && !(isdefined(level.zombie_equipment[w_weapon].refill_max_ammo) && level.zombie_equipment[w_weapon].refill_max_ammo)) {
            continue;
        }
        if (isdefined(level.zombie_weapons_no_max_ammo) && isdefined(level.zombie_weapons_no_max_ammo[w_weapon.name])) {
            continue;
        }
        if (zm_loadout::is_hero_weapon(w_weapon)) {
            continue;
        }
        if (player hasweapon(w_weapon)) {
            if (zm_loadout::is_lethal_grenade(w_weapon)) {
                player gadgetpowerset(player gadgetgetslot(w_weapon), 100);
                continue;
            }
            player zm_weapons::ammo_give(w_weapon, 0);
        }
    }
    player playsoundtoplayer("zmb_full_ammo", player);
    if (isdefined(e_powerup)) {
        player zm_utility::function_d7a33664(e_powerup.hint);
    }
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 2, eflags: 0x0
// Checksum 0x7be88411, Offset: 0x538
// Size: 0x33c
function full_ammo_powerup(drop_item, player) {
    players = getplayers(player.team);
    if (isdefined(level.var_d925b1ef)) {
        players = [[ level.var_d925b1ef ]](player);
    }
    level notify(#"zmb_max_ammo_level");
    foreach (player in players) {
        if (isdefined(level.check_player_is_ready_for_ammo)) {
            if ([[ level.check_player_is_ready_for_ammo ]](player) == 0) {
                continue;
            }
        }
        a_w_weapons = player getweaponslist(0);
        player.var_48044c94 = undefined;
        player notify(#"zmb_max_ammo");
        player notify(#"hash_1fdb7e931333fd8b");
        player zm_placeable_mine::disable_all_prompts_for_player();
        foreach (w_weapon in a_w_weapons) {
            if (level.headshots_only && zm_loadout::is_lethal_grenade(w_weapon)) {
                continue;
            }
            if (isdefined(level.zombie_include_equipment) && isdefined(level.zombie_include_equipment[w_weapon]) && !(isdefined(level.zombie_equipment[w_weapon].refill_max_ammo) && level.zombie_equipment[w_weapon].refill_max_ammo)) {
                continue;
            }
            if (isdefined(level.zombie_weapons_no_max_ammo) && isdefined(level.zombie_weapons_no_max_ammo[w_weapon.name])) {
                continue;
            }
            if (zm_loadout::is_hero_weapon(w_weapon)) {
                continue;
            }
            if (player hasweapon(w_weapon)) {
                if (zm_loadout::is_lethal_grenade(w_weapon)) {
                    player gadgetpowerset(player gadgetgetslot(w_weapon), 100);
                    continue;
                }
                player zm_weapons::ammo_give(w_weapon, 0);
            }
        }
    }
    level thread full_ammo_on_hud(drop_item, player.team);
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 2, eflags: 0x0
// Checksum 0x5d2ef5d2, Offset: 0x880
// Size: 0x84
function full_ammo_on_hud(drop_item, player_team) {
    players = getplayers(player_team);
    players[0] playsoundtoteam("zmb_full_ammo", player_team);
    if (isdefined(drop_item)) {
        level zm_utility::function_d7a33664(drop_item.hint);
    }
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 0, eflags: 0x0
// Checksum 0xc3c81be2, Offset: 0x910
// Size: 0x12
function function_5ddf4793() {
    return level.var_bdd2f351 == 0;
}

