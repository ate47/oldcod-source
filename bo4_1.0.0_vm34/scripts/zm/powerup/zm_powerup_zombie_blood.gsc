#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_zombie_blood;

// Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
// Params 0, eflags: 0x2
// Checksum 0x30c8a917, Offset: 0x1c8
// Size: 0x34
function autoexec __init__system__() {
    system::register("zm_powerup_zombie_blood", &__init__, undefined, undefined);
}

// Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
// Params 0, eflags: 0x0
// Checksum 0x41b28f4, Offset: 0x208
// Size: 0x204
function __init__() {
    clientfield::register("allplayers", "" + #"player_zombie_blood_fx", 1, 1, "int");
    zm_powerups::register_powerup("zombie_blood", &grab_zombie_blood);
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("zombie_blood", "p8_zm_esc_blood_power_up", #"zombie_powerup_max_ammo", &zm_powerups::func_should_never_drop, 1, 0, 0, undefined, "powerup_zombie_blood", "zombie_powerup_zombie_blood_time", "zombie_powerup_zombie_blood_on", 1, 0);
        zm_powerups::powerup_set_can_pick_up_in_last_stand("zombie_blood", 0);
        zm_powerups::powerup_set_statless_powerup("zombie_blood");
    }
    callback::on_connect(&init_player_zombie_blood_vars);
    level.a_zombie_blood_entities = getentarray("zombie_blood_visible", "targetname");
    if (isdefined(level.a_zombie_blood_entities)) {
        foreach (var_e81648f0 in level.a_zombie_blood_entities) {
            var_e81648f0 thread make_zombie_blood_entity();
        }
    }
    /#
        level thread function_af2ce62f();
    #/
}

// Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
// Params 0, eflags: 0x0
// Checksum 0xf8dfb8ab, Offset: 0x418
// Size: 0x3e
function init_player_zombie_blood_vars() {
    self.zombie_vars[#"zombie_powerup_zombie_blood_on"] = 0;
    self.zombie_vars[#"zombie_powerup_zombie_blood_time"] = 30;
}

// Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
// Params 1, eflags: 0x0
// Checksum 0xbdb1fbf3, Offset: 0x460
// Size: 0x24
function grab_zombie_blood(e_player) {
    level thread zombie_blood_powerup(self, e_player);
}

// Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
// Params 2, eflags: 0x0
// Checksum 0xb107380e, Offset: 0x490
// Size: 0x4c0
function zombie_blood_powerup(mdl_powerup, e_player) {
    e_player notify(#"zombie_blood");
    e_player endon(#"disconnect", #"zombie_blood");
    e_player thread zm_powerups::powerup_vo("zombie_blood");
    e_player._show_solo_hud = 1;
    if (bgb::is_team_enabled("zm_bgb_temporal_gift")) {
        var_bf0a128b = 60;
    } else {
        var_bf0a128b = 30;
    }
    if (!e_player.zombie_vars[#"zombie_powerup_zombie_blood_on"]) {
        e_player val::set("zombie_blood", "ignoreme", 1);
    }
    e_player.zombie_vars[#"zombie_powerup_zombie_blood_time"] = var_bf0a128b;
    e_player.zombie_vars[#"zombie_powerup_zombie_blood_on"] = 1;
    e_player setcharacteroutfit(1);
    level notify(#"player_zombie_blood", e_player);
    e_player clientfield::set("" + #"player_zombie_blood_fx", 1);
    level.a_zombie_blood_entities = array::remove_undefined(level.a_zombie_blood_entities);
    foreach (e_zombie_blood in level.a_zombie_blood_entities) {
        if (isdefined(e_zombie_blood.e_unique_player)) {
            if (e_zombie_blood.e_unique_player == e_player) {
                e_zombie_blood setvisibletoplayer(e_player);
            }
            continue;
        }
        e_zombie_blood setvisibletoplayer(e_player);
    }
    e_player thread watch_zombie_blood_early_exit();
    while (e_player.zombie_vars[#"zombie_powerup_zombie_blood_time"] >= 0) {
        waitframe(1);
        e_player.zombie_vars[#"zombie_powerup_zombie_blood_time"] = e_player.zombie_vars[#"zombie_powerup_zombie_blood_time"] - 0.05;
    }
    e_player setcharacteroutfit(0);
    e_player notify(#"zombie_blood_over");
    if (isdefined(e_player.characterindex)) {
        e_player playsound("vox_plr_" + e_player.characterindex + "_exert_grunt_" + randomintrange(0, 3));
    }
    e_player.zombie_vars[#"zombie_powerup_zombie_blood_on"] = 0;
    e_player.zombie_vars[#"zombie_powerup_zombie_blood_time"] = 30;
    e_player._show_solo_hud = 0;
    e_player clientfield::set("" + #"player_zombie_blood_fx", 0);
    e_player val::reset("zombie_blood", "ignoreme");
    level.a_zombie_blood_entities = array::remove_undefined(level.a_zombie_blood_entities);
    foreach (e_zombie_blood in level.a_zombie_blood_entities) {
        e_zombie_blood setinvisibletoplayer(e_player);
    }
}

// Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
// Params 0, eflags: 0x0
// Checksum 0x9bf1ad86, Offset: 0x958
// Size: 0xa2
function watch_zombie_blood_early_exit() {
    self notify(#"early_exit_watch");
    self endon(#"disconnect", #"early_exit_watch", #"zombie_blood_over");
    util::waittill_any_ents_two(self, "player_downed", level, "end_game");
    self.zombie_vars[#"zombie_powerup_zombie_blood_time"] = -0.05;
    self.early_exit = 1;
}

// Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
// Params 0, eflags: 0x0
// Checksum 0x970e91c5, Offset: 0xa08
// Size: 0x190
function make_zombie_blood_entity() {
    assert(isdefined(level.a_zombie_blood_entities), "<dev string:x30>");
    if (!isdefined(level.a_zombie_blood_entities)) {
        level.a_zombie_blood_entities = [];
    } else if (!isarray(level.a_zombie_blood_entities)) {
        level.a_zombie_blood_entities = array(level.a_zombie_blood_entities);
    }
    level.a_zombie_blood_entities[level.a_zombie_blood_entities.size] = self;
    self setinvisibletoall();
    foreach (e_player in getplayers()) {
        if (e_player.zombie_vars[#"zombie_powerup_zombie_blood_on"]) {
            if (isdefined(self.e_unique_player)) {
                if (self.e_unique_player == e_player) {
                    self setvisibletoplayer(e_player);
                }
                continue;
            }
            self setvisibletoplayer(e_player);
        }
    }
}

/#

    // Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
    // Params 0, eflags: 0x0
    // Checksum 0xc73cbf09, Offset: 0xba0
    // Size: 0x7c
    function function_af2ce62f() {
        level flagsys::wait_till("<dev string:x5e>");
        wait 1;
        zm_devgui::add_custom_devgui_callback(&function_525945b3);
        adddebugcommand("<dev string:x77>");
        adddebugcommand("<dev string:xc6>");
    }

    // Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
    // Params 1, eflags: 0x0
    // Checksum 0xa8a7577b, Offset: 0xc28
    // Size: 0xa8
    function function_525945b3(cmd) {
        b_return = 0;
        switch (cmd) {
        case #"zombie_blood":
            zm_devgui::zombie_devgui_give_powerup("<dev string:x11d>", 1);
            break;
        case #"next_zombie_blood":
            zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
            break;
        }
        return b_return;
    }

#/
