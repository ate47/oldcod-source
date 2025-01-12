#using script_1caf36ff04a85ff6;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\item_inventory;
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
// Params 0, eflags: 0x6
// Checksum 0x8cdde109, Offset: 0x120
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_full_ammo", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 0, eflags: 0x5 linked
// Checksum 0xe791bba3, Offset: 0x168
// Size: 0x84
function private function_70a657d8() {
    zm_powerups::register_powerup("full_ammo", &grab_full_ammo);
    if (zm_powerups::function_cc33adc8()) {
        zm_powerups::add_zombie_powerup("full_ammo", "p7_zm_power_up_max_ammo", #"zombie/powerup_max_ammo", &function_b695b971, 0, 0, 0);
    }
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 1, eflags: 0x1 linked
// Checksum 0xe776429, Offset: 0x1f8
// Size: 0x8c
function grab_full_ammo(player) {
    if (zm_powerups::function_cfd04802(#"full_ammo")) {
        level thread function_dae1df4d(self, player);
    } else {
        level thread full_ammo_powerup(self, player);
    }
    player thread zm_powerups::powerup_vo("full_ammo");
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 2, eflags: 0x1 linked
// Checksum 0x82cedf4e, Offset: 0x290
// Size: 0x10c
function function_dae1df4d(e_powerup, player) {
    if (isdefined(level.check_player_is_ready_for_ammo)) {
        if ([[ level.check_player_is_ready_for_ammo ]](player) == 0) {
            return;
        }
    }
    player.var_655c0753 = undefined;
    player notify(#"zmb_max_ammo");
    player zm_placeable_mine::disable_all_prompts_for_player();
    player zm_weapons::function_51aa5813(17 + 1);
    player zm_weapons::function_51aa5813(17 + 1 + 8 + 1);
    player playsoundtoplayer(#"zmb_full_ammo", player);
    if (isdefined(e_powerup)) {
        player zm_utility::function_7a35b1d7(e_powerup.hint);
    }
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 2, eflags: 0x1 linked
// Checksum 0x69be7539, Offset: 0x3a8
// Size: 0x27c
function full_ammo_powerup(drop_item, player) {
    players = getplayers(player.team);
    if (isdefined(level.var_73345bfd)) {
        players = [[ level.var_73345bfd ]](player);
    }
    level notify(#"zmb_max_ammo_level");
    foreach (player in players) {
        if (isdefined(level.check_player_is_ready_for_ammo)) {
            if ([[ level.check_player_is_ready_for_ammo ]](player) == 0) {
                continue;
            }
        }
        if (player util::is_spectating()) {
            continue;
        }
        player.var_655c0753 = undefined;
        player notify(#"zmb_max_ammo");
        player zm_placeable_mine::disable_all_prompts_for_player();
        player zm_weapons::function_51aa5813(17 + 1);
        player zm_weapons::function_51aa5813(17 + 1 + 8 + 1);
        if (is_true(level.var_2f5a329e)) {
            a_w_weapons = player getweaponslist(0);
            foreach (weapon in a_w_weapons) {
                player zm_weapons::function_7c5dd4bd(weapon);
            }
        }
    }
    level thread full_ammo_on_hud(drop_item, player.team);
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 1, eflags: 0x0
// Checksum 0x6a93e0eb, Offset: 0x630
// Size: 0x10c
function function_3ecbd9d(w_weapon) {
    self endon(#"disconnect");
    n_slot = self gadgetgetslot(w_weapon);
    if (w_weapon == getweapon(#"tomahawk_t8") || w_weapon == getweapon(#"tomahawk_t8_upgraded")) {
        while (self function_36dfc05f(n_slot)) {
            waitframe(1);
        }
        self notify(#"hash_3d73720d4588203c");
        self gadgetpowerset(n_slot, 100);
        return;
    }
    self gadgetpowerset(n_slot, 100);
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 2, eflags: 0x1 linked
// Checksum 0xcf123c37, Offset: 0x748
// Size: 0x94
function full_ammo_on_hud(drop_item, player_team) {
    players = getplayers(player_team);
    players[0] playsoundtoteam("zmb_full_ammo", player_team);
    if (isdefined(drop_item) && isdefined(drop_item.hint)) {
        level zm_utility::function_7a35b1d7(drop_item.hint);
    }
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 0, eflags: 0x1 linked
// Checksum 0xc6efdcc4, Offset: 0x7e8
// Size: 0x12
function function_b695b971() {
    return level.zm_genesis_robot_pay_towardsreactswordstart == 0;
}

