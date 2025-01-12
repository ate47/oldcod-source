#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_powerup_shield_charge;

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 0, eflags: 0x2
// Checksum 0xab317207, Offset: 0x120
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_shield_charge", &__init__, undefined, undefined);
}

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 0, eflags: 0x0
// Checksum 0x9c175890, Offset: 0x168
// Size: 0xb4
function __init__() {
    zm_powerups::register_powerup("shield_charge", &grab_shield_charge);
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("shield_charge", "p7_zm_zod_nitrous_tank", #"hash_3f5e4aa38f9aeba5", &func_drop_when_players_own, 1, 0, 0);
        zm_powerups::powerup_set_statless_powerup("shield_charge");
    }
    /#
        thread shield_devgui();
    #/
}

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 0, eflags: 0x0
// Checksum 0x76869403, Offset: 0x228
// Size: 0x6
function func_drop_when_players_own() {
    return false;
}

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 1, eflags: 0x0
// Checksum 0x23e74ccd, Offset: 0x238
// Size: 0x24
function grab_shield_charge(player) {
    level thread shield_charge_powerup(self, player);
}

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 2, eflags: 0x0
// Checksum 0xbb69a70, Offset: 0x268
// Size: 0x74
function shield_charge_powerup(item, player) {
    if (isdefined(player.hasriotshield) && player.hasriotshield) {
        player givestartammo(player.weaponriotshield);
    }
    level thread shield_on_hud(item, player.team);
}

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 2, eflags: 0x0
// Checksum 0x8c370bc2, Offset: 0x2e8
// Size: 0x13c
function shield_on_hud(drop_item, player_team) {
    /#
        self endon(#"disconnect");
        hudelem = hud::function_32e9b9b7("<dev string:x30>", 2);
        hudelem hud::setpoint("<dev string:x3a>", undefined, 0, zombie_utility::get_zombie_var(#"zombie_timer_offset") - zombie_utility::get_zombie_var(#"zombie_timer_offset_interval") * 2);
        hudelem.sort = 0.5;
        hudelem.alpha = 0;
        hudelem fadeovertime(0.5);
        hudelem.alpha = 1;
        if (isdefined(drop_item)) {
            hudelem.label = drop_item.hint;
        }
        hudelem thread full_ammo_move_hud(player_team);
    #/
}

/#

    // Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
    // Params 1, eflags: 0x0
    // Checksum 0xa4f77d65, Offset: 0x430
    // Size: 0xd4
    function full_ammo_move_hud(player_team) {
        players = getplayers(player_team);
        players[0] playsoundtoteam("<dev string:x3e>", player_team);
        wait 0.5;
        move_fade_time = 1.5;
        self fadeovertime(move_fade_time);
        self moveovertime(move_fade_time);
        self.y = 270;
        self.alpha = 0;
        wait move_fade_time;
        self destroy();
    }

    // Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
    // Params 0, eflags: 0x0
    // Checksum 0x9d0e6646, Offset: 0x510
    // Size: 0x7c
    function shield_devgui() {
        level flagsys::wait_till("<dev string:x4c>");
        wait 1;
        zm_devgui::add_custom_devgui_callback(&shield_devgui_callback);
        adddebugcommand("<dev string:x65>");
        adddebugcommand("<dev string:xb6>");
    }

    // Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
    // Params 1, eflags: 0x0
    // Checksum 0x9214d750, Offset: 0x598
    // Size: 0xc8
    function shield_devgui_callback(cmd) {
        players = getplayers();
        retval = 0;
        switch (cmd) {
        case #"shield_charge":
            zm_devgui::zombie_devgui_give_powerup(cmd, 1);
            break;
        case #"next_shield_charge":
            zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
            break;
        }
        return retval;
    }

#/
