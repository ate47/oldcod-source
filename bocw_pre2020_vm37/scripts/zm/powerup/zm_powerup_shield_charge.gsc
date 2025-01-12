#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_shield_charge;

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 0, eflags: 0x6
// Checksum 0xe8393366, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_shield_charge", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 0, eflags: 0x4
// Checksum 0x2e51f846, Offset: 0xf8
// Size: 0x154
function private function_70a657d8() {
    zm_powerups::register_powerup("shield_charge", &grab_shield_charge);
    if (zm_powerups::function_cc33adc8()) {
        zm_powerups::add_zombie_powerup("shield_charge", "p8_wz_armor_scrap", #"hash_3f5e4aa38f9aeba5", &func_drop_when_players_own, 1, 0, 0);
        zm_powerups::function_59f7f2c6("shield_charge", #"hash_6c72c13078ae03d7", #"hash_3d58d22b97f9c9b4", #"hash_53f81d6d588b9984");
        zm_powerups::powerup_set_statless_powerup("shield_charge");
        if (is_true(level.var_2f5a329e)) {
            zm_powerups::function_b3430817("shield_charge", 2);
        } else {
            zm_powerups::function_b3430817("shield_charge", 10);
        }
    }
    /#
        thread shield_devgui();
    #/
}

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 0, eflags: 0x0
// Checksum 0xcc6043d4, Offset: 0x258
// Size: 0xb6
function func_drop_when_players_own() {
    players = getplayers();
    foreach (player in players) {
        if ((isdefined(player.armortier) ? player.armortier : 0) > 0) {
            return true;
        }
    }
    return false;
}

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 1, eflags: 0x0
// Checksum 0xb4dd0e7, Offset: 0x318
// Size: 0x24
function grab_shield_charge(player) {
    level thread shield_charge_powerup(self, player);
}

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 2, eflags: 0x0
// Checksum 0xef6a20f9, Offset: 0x348
// Size: 0xce
function shield_charge_powerup(*item, player) {
    var_2cacdde7 = 50;
    inventoryitem = player.inventory.items[6];
    if (isdefined(inventoryitem)) {
        var_2cacdde7 = isdefined(inventoryitem.var_a6762160.var_a3aa1ca2) ? inventoryitem.var_a6762160.var_a3aa1ca2 : 50;
        if (var_2cacdde7 == 0) {
            var_2cacdde7 = 50;
        }
    }
    player.armor += math::clamp(var_2cacdde7, 0, player.maxarmor);
}

/#

    // Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
    // Params 0, eflags: 0x0
    // Checksum 0x4f8d1258, Offset: 0x420
    // Size: 0x7c
    function shield_devgui() {
        level flag::wait_till("<dev string:x38>");
        wait 1;
        zm_devgui::add_custom_devgui_callback(&shield_devgui_callback);
        adddebugcommand("<dev string:x54>");
        adddebugcommand("<dev string:xa8>");
    }

    // Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
    // Params 1, eflags: 0x0
    // Checksum 0x19e388d8, Offset: 0x4a8
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
