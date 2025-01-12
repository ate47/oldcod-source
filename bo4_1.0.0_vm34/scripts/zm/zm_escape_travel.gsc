#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm\zm_escape_util;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_escape_travel;

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x10a862ac, Offset: 0x440
// Size: 0x7dc
function init_alcatraz_zipline() {
    level thread gondola_hostmigration();
    level.player_intersection_tracker_override = &zombie_alcatraz_player_intersection_tracker_override;
    level.var_ab2fc54c = 0;
    level flag::init("gondola_at_roof");
    level flag::init("gondola_at_docks");
    level flag::init("gondola_doors_moving");
    level flag::init("gondola_in_motion");
    level flag::init("gondola_initialized");
    e_gondola = getent("zipline_gondola", "targetname");
    e_gondola setmovingplatformenabled(1);
    level.e_gondola = e_gondola;
    e_gondola.location = "roof";
    e_gondola.destination = undefined;
    level.e_gondola.t_ride = getent("gondola_ride_trigger", "targetname");
    level.e_gondola.t_ride enablelinkto();
    level.e_gondola.t_ride linkto(e_gondola);
    var_adb5f9e = getentarray("gondola_call_trigger", "targetname");
    foreach (trigger in var_adb5f9e) {
        trigger sethintstring(#"hash_ebd3d1458a3b46e");
    }
    var_9cb23aff = getentarray("gondola_move_trigger", "targetname");
    foreach (trigger in var_9cb23aff) {
        if (zm_utility::is_standard()) {
            trigger sethintstring(#"hash_675cfe2c548c034e");
        } else {
            trigger sethintstring(#"hash_c0173e448a7253f", 750);
        }
        trigger setinvisibletoall();
    }
    a_gondola_doors = getentarray("gondola_doors", "targetname");
    foreach (mdl_door in a_gondola_doors) {
        mdl_door linkto(e_gondola);
        e_gondola establish_gondola_door_definition(mdl_door);
    }
    a_gondola_gates = getentarray("gondola_gates", "targetname");
    foreach (mdl_gate in a_gondola_gates) {
        mdl_gate linkto(e_gondola);
        e_gondola establish_gondola_gate_definition(mdl_gate);
    }
    a_gondola_landing_doors = getentarray("gondola_landing_doors", "targetname");
    foreach (mdl_door in a_gondola_landing_doors) {
        e_gondola establish_gondola_landing_door_definition(mdl_door);
    }
    a_gondola_landing_gates = getentarray("gondola_landing_gates", "targetname");
    foreach (mdl_gate in a_gondola_landing_gates) {
        e_gondola establish_gondola_landing_gate_definition(mdl_gate);
    }
    gondola_lights_red();
    level flag::wait_till("power_on1");
    var_e31f16c9 = getentarray("gondola_powered_on", "script_string");
    foreach (var_b3c91599 in var_e31f16c9) {
        var_b3c91599 notify(#"blast_attack");
    }
    level flag::set("gondola_at_roof");
    e_gondola gondola_doors_move("roof", 1);
    level flag::set("gondola_initialized");
    gondola_lights_green();
    level.var_f0d177cc = 0;
    level.var_a53ecf22 = 0;
    level.var_821e47e0 = 0;
    array::thread_all(var_9cb23aff, &zipline_move_trigger_think);
    array::thread_all(var_adb5f9e, &zipline_call_trigger_think);
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x5c00ebba, Offset: 0xc28
// Size: 0x2f8
function gondola_hostmigration() {
    level endon(#"end_game");
    level notify(#"gondola_hostmigration");
    level endon(#"gondola_hostmigration");
    while (true) {
        level waittill(#"host_migration_begin");
        level.var_2f19b64f = [];
        a_players = getplayers();
        foreach (player in a_players) {
            player thread link_player_to_gondola();
        }
        level waittill(#"host_migration_end");
        a_players = getplayers();
        foreach (player in a_players) {
            player unlink();
        }
        foreach (e_origin in level.var_2f19b64f) {
            e_origin delete();
        }
        if (!(isdefined(level.e_gondola.is_moving) && level.e_gondola.is_moving)) {
            if (level.e_gondola.location == "roof") {
                var_323ebea9 = getnode("nd_on_top_r", "targetname");
                if (isdefined(var_323ebea9)) {
                    linktraversal(var_323ebea9);
                }
                continue;
            }
            var_a1b49895 = getnode("nd_on_bottom_r", "targetname");
            if (isdefined(var_a1b49895)) {
                linktraversal(var_a1b49895);
            }
        }
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x39239ce, Offset: 0xf28
// Size: 0xd4
function link_player_to_gondola() {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(self)) {
        return;
    }
    if (self function_250c012e()) {
        e_origin = spawn("script_origin", self.origin);
        e_origin.angles = self.angles;
        level.var_2f19b64f[level.var_2f19b64f.size] = e_origin;
        e_origin linkto(level.e_gondola);
        self playerlinkto(e_origin);
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0xd9df1635, Offset: 0x1008
// Size: 0x6c
function function_250c012e() {
    if (isplayer(self) || isactor(self)) {
        if (self istouching(level.e_gondola.t_ride)) {
            return 1;
        }
        return 0;
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 1, eflags: 0x0
// Checksum 0x284534b4, Offset: 0x1080
// Size: 0xf6
function zombie_alcatraz_player_intersection_tracker_override(other_player) {
    if (isdefined(self.afterlife_revived) && self.afterlife_revived || isdefined(other_player.afterlife_revived) && other_player.afterlife_revived) {
        return true;
    }
    if (isdefined(self.is_on_gondola) && self.is_on_gondola && isdefined(level.e_gondola.is_moving) && level.e_gondola.is_moving) {
        return true;
    }
    if (isdefined(other_player.is_on_gondola) && other_player.is_on_gondola && isdefined(level.e_gondola.is_moving) && level.e_gondola.is_moving) {
        return true;
    }
    return false;
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 1, eflags: 0x0
// Checksum 0x88ce0292, Offset: 0x1180
// Size: 0xba
function establish_gondola_door_definition(mdl_door) {
    str_identifier = mdl_door.script_noteworthy;
    switch (str_identifier) {
    case #"roof left":
        self.door_roof_left = mdl_door;
        break;
    case #"roof right":
        self.door_roof_right = mdl_door;
        break;
    case #"docks left":
        self.door_docks_left = mdl_door;
        break;
    case #"docks right":
        self.door_docks_right = mdl_door;
        break;
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 1, eflags: 0x0
// Checksum 0x651546d0, Offset: 0x1248
// Size: 0xba
function establish_gondola_gate_definition(mdl_gate) {
    str_identifier = mdl_gate.script_noteworthy;
    switch (str_identifier) {
    case #"roof left":
        self.gate_roof_left = mdl_gate;
        break;
    case #"roof right":
        self.gate_roof_right = mdl_gate;
        break;
    case #"docks left":
        self.gate_docks_left = mdl_gate;
        break;
    case #"docks right":
        self.gate_docks_right = mdl_gate;
        break;
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 1, eflags: 0x0
// Checksum 0xc0e0d3ef, Offset: 0x1310
// Size: 0xba
function establish_gondola_landing_door_definition(mdl_door) {
    str_identifier = mdl_door.script_noteworthy;
    switch (str_identifier) {
    case #"roof left":
        self.landing_door_roof_left = mdl_door;
        break;
    case #"roof right":
        self.landing_door_roof_right = mdl_door;
        break;
    case #"docks left":
        self.landing_door_docks_left = mdl_door;
        break;
    case #"docks right":
        self.landing_door_docks_right = mdl_door;
        break;
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 1, eflags: 0x0
// Checksum 0x464ce771, Offset: 0x13d8
// Size: 0xba
function establish_gondola_landing_gate_definition(mdl_gate) {
    str_identifier = mdl_gate.script_noteworthy;
    switch (str_identifier) {
    case #"roof left":
        self.landing_gate_roof_left = mdl_gate;
        break;
    case #"roof right":
        self.landing_gate_roof_right = mdl_gate;
        break;
    case #"docks left":
        self.landing_gate_docks_left = mdl_gate;
        break;
    case #"docks right":
        self.landing_gate_docks_right = mdl_gate;
        break;
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 2, eflags: 0x0
// Checksum 0x5c8d9f63, Offset: 0x14a0
// Size: 0x4c8
function gondola_doors_move(str_side, n_state) {
    if (str_side == "roof") {
        mdl_door_left = self.door_roof_left;
        var_ee43fbc4 = self.gate_roof_left;
        mdl_door_right = self.door_roof_right;
        var_9bc5693b = self.gate_roof_right;
        var_d7af90f3 = self.landing_door_roof_left;
        var_52320f98 = self.landing_gate_roof_left;
        var_cc202de6 = self.landing_door_roof_right;
        var_baf7c527 = self.landing_gate_roof_right;
        n_side_modifier = 1;
    } else if (str_side == "docks") {
        mdl_door_left = self.door_docks_left;
        var_ee43fbc4 = self.gate_docks_left;
        mdl_door_right = self.door_docks_right;
        var_9bc5693b = self.gate_docks_right;
        var_d7af90f3 = self.landing_door_docks_left;
        var_52320f98 = self.landing_gate_docks_left;
        var_cc202de6 = self.landing_door_docks_right;
        var_baf7c527 = self.landing_gate_docks_right;
        n_side_modifier = -1;
    }
    a_doors_and_gates = [];
    a_doors_and_gates[0] = mdl_door_left;
    a_doors_and_gates[1] = var_ee43fbc4;
    a_doors_and_gates[2] = mdl_door_right;
    a_doors_and_gates[3] = var_9bc5693b;
    foreach (mdl_model in a_doors_and_gates) {
        mdl_model unlink();
    }
    if (n_state == 1) {
        mdl_door_left playsound(#"hash_717283b43ea8d0a4");
        gondola_gate_moves(n_state, n_side_modifier, var_ee43fbc4, var_9bc5693b, var_52320f98, var_baf7c527);
        gondola_gate_and_door_moves(n_state, n_side_modifier, var_ee43fbc4, mdl_door_left, var_9bc5693b, mdl_door_right, var_52320f98, var_d7af90f3, var_baf7c527, var_cc202de6);
        if (n_side_modifier == 1) {
            var_323ebea9 = getnode("nd_on_top_r", "targetname");
            if (isdefined(var_323ebea9)) {
                linktraversal(var_323ebea9);
            }
        } else {
            var_a1b49895 = getnode("nd_on_bottom_r", "targetname");
            if (isdefined(var_a1b49895)) {
                linktraversal(var_a1b49895);
            }
        }
    } else {
        if (n_side_modifier == 1) {
            var_323ebea9 = getnode("nd_on_top_r", "targetname");
            if (isdefined(var_323ebea9)) {
                unlinktraversal(var_323ebea9);
            }
        } else {
            var_a1b49895 = getnode("nd_on_bottom_r", "targetname");
            if (isdefined(var_a1b49895)) {
                unlinktraversal(var_a1b49895);
            }
        }
        mdl_door_left playsound(#"hash_ac1fa6f62462ed8");
        gondola_gate_and_door_moves(n_state, n_side_modifier, var_ee43fbc4, mdl_door_left, var_9bc5693b, mdl_door_right, var_52320f98, var_d7af90f3, var_baf7c527, var_cc202de6);
        gondola_gate_moves(n_state, n_side_modifier, var_ee43fbc4, var_9bc5693b, var_52320f98, var_baf7c527);
    }
    foreach (mdl_model in a_doors_and_gates) {
        mdl_model linkto(self);
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 6, eflags: 0x0
// Checksum 0x2acf5d4, Offset: 0x1970
// Size: 0x1bc
function gondola_gate_moves(n_state, n_side_modifier, var_ee43fbc4, var_9bc5693b, var_52320f98, var_baf7c527) {
    var_ee43fbc4 moveto(var_ee43fbc4.origin + (22.5 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
    var_9bc5693b moveto(var_9bc5693b.origin + (22.5 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
    var_52320f98 moveto(var_52320f98.origin + (22.5 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
    var_baf7c527 moveto(var_baf7c527.origin + (22.5 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
    var_9bc5693b waittill(#"movedone");
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 10, eflags: 0x0
// Checksum 0x9001fb55, Offset: 0x1b38
// Size: 0x30c
function gondola_gate_and_door_moves(n_state, n_side_modifier, var_ee43fbc4, mdl_door_left, var_9bc5693b, mdl_door_right, var_52320f98, var_d7af90f3, var_baf7c527, var_cc202de6) {
    mdl_door_left moveto(mdl_door_left.origin + (24 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
    var_ee43fbc4 moveto(var_ee43fbc4.origin + (24 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
    mdl_door_right moveto(mdl_door_right.origin + (24 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
    var_9bc5693b moveto(var_9bc5693b.origin + (24 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
    var_d7af90f3 moveto(var_d7af90f3.origin + (24 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
    var_52320f98 moveto(var_52320f98.origin + (24 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
    var_cc202de6 moveto(var_cc202de6.origin + (24 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
    var_baf7c527 moveto(var_baf7c527.origin + (24 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
    var_9bc5693b waittill(#"movedone");
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0xb6c728b, Offset: 0x1e50
// Size: 0x3a6
function zipline_move_trigger_think() {
    level endon("interrupt_gondola_move_trigger_" + self.script_string);
    self.cost = 750;
    self.in_use = 0;
    self.is_available = 1;
    self setcursorhint("HINT_NOICON");
    while (true) {
        level flag::wait_till("gondola_at_" + self.script_string);
        self setvisibletoall();
        s_result = self waittill(#"trigger");
        e_who = s_result.activator;
        b_forced = s_result.b_forced;
        level.var_224d0ed4 = e_who;
        level thread gondola_moving_vo();
        if (!(isdefined(b_forced) && b_forced) && e_who zm_utility::in_revive_trigger()) {
            continue;
        }
        if (!isdefined(self.is_available)) {
            continue;
        }
        if (isdefined(b_forced) && b_forced || zm_utility::is_player_valid(e_who) && e_who.score >= self.cost) {
            if (!self.in_use) {
                self.in_use = 1;
                self.is_available = undefined;
                self setinvisibletoall();
                if (isdefined(e_who)) {
                    zm_utility::play_sound_at_pos("purchase", e_who.origin);
                    e_who zm_score::minus_to_player_score(self.cost);
                }
                if (self.script_string == "roof") {
                    level notify(#"interrupt_gondola_call_trigger_docks");
                    str_loc = "docks";
                } else if (self.script_string == "docks") {
                    level notify(#"interrupt_gondola_call_trigger_roof");
                    str_loc = "roof";
                }
                a_t_trig = getentarray("gondola_call_trigger", "targetname");
                foreach (trigger in a_t_trig) {
                    if (trigger.script_string == str_loc) {
                        t_opposite_call_trigger = trigger;
                        break;
                    }
                }
                move_gondola();
                t_opposite_call_trigger thread zipline_call_trigger_think();
                t_opposite_call_trigger playsound(#"zmb_trap_available");
                self.in_use = 0;
                self.is_available = 1;
            }
        }
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x93e13ac3, Offset: 0x2200
// Size: 0x3de
function zipline_call_trigger_think() {
    level endon("interrupt_gondola_call_trigger_" + self.script_string);
    self.cost = 0;
    self.in_use = 0;
    self.is_available = 1;
    self setcursorhint("HINT_NOICON");
    e_gondola = level.e_gondola;
    if (self.script_string == "roof") {
        str_gondola_loc = "docks";
    } else if (self.script_string == "docks") {
        str_gondola_loc = "roof";
    }
    while (true) {
        self sethintstring("");
        level flag::wait_till("gondola_at_" + str_gondola_loc);
        self notify(#"available");
        self sethintstring(#"hash_bbb24669638bc76");
        s_result = self waittill(#"trigger");
        e_who = s_result.activator;
        b_forced = s_result.b_forced;
        level.var_224d0ed4 = e_who;
        if (!(isdefined(b_forced) && b_forced) && e_who zm_utility::in_revive_trigger()) {
            continue;
        }
        if (!isdefined(self.is_available)) {
            continue;
        }
        if (isdefined(b_forced) && b_forced || zm_utility::is_player_valid(e_who)) {
            if (!self.in_use) {
                self.in_use = 1;
                if (self.script_string == "roof") {
                    level notify(#"interrupt_gondola_move_trigger_docks");
                    str_loc = "docks";
                } else if (self.script_string == "docks") {
                    level notify(#"interrupt_gondola_move_trigger_roof");
                    str_loc = "roof";
                }
                a_t_trig = getentarray("gondola_move_trigger", "targetname");
                foreach (trigger in a_t_trig) {
                    if (trigger.script_string == str_loc) {
                        t_opposite_move_trigger = trigger;
                        t_opposite_move_trigger setinvisibletoall();
                        break;
                    }
                }
                self playsound(#"zmb_trap_activate");
                move_gondola();
                t_opposite_move_trigger thread zipline_move_trigger_think();
                self.in_use = 0;
                self playsound(#"zmb_trap_available");
                self.is_available = 1;
            }
        }
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 1, eflags: 0x0
// Checksum 0xd71cc6e1, Offset: 0x25e8
// Size: 0xb8c
function move_gondola(b_suppress_doors_close = 0) {
    gondola_lights_red();
    a_t_call = getentarray("gondola_call_trigger", "targetname");
    foreach (trigger in a_t_call) {
        trigger sethintstring(#"hash_1923fe59e50dfb0e");
    }
    e_gondola = level.e_gondola;
    t_ride = level.e_gondola.t_ride;
    e_gondola.is_moving = 1;
    if (e_gondola.location == "roof") {
        var_3311990f = getvehiclenode("roof_gondola_start", "targetname");
        e_gondola.destination = "docks";
        level thread function_99f0f1c4();
    } else if (e_gondola.location == "docks") {
        var_3311990f = getvehiclenode("docks_gondola_start", "targetname");
        e_gondola.destination = "roof";
        level thread function_aa5a7d5f();
    }
    if (level flag::get("gondola_initialized")) {
        level flag::set("gondola_roof_to_dock");
        level flag::set("gondola_dock_to_roof");
        level flag::set("gondola_ride_zone_enabled");
        zm_zonemgr::enable_zone("zone_cellblock_west");
        zm_zonemgr::enable_zone("zone_broadway_floor_2");
        zm_zonemgr::enable_zone("zone_cellblock_west_barber");
        zm_zonemgr::enable_zone("zone_cellblock_west_warden");
        zm_zonemgr::enable_zone("zone_cellblock_east");
    }
    level flag::clear("gondola_at_" + e_gondola.location);
    a_players = getplayers();
    foreach (player in a_players) {
        if (player function_250c012e()) {
            zm_ai_utility::function_66bc9d2f(player);
        }
    }
    if (!(isdefined(b_suppress_doors_close) && b_suppress_doors_close)) {
        level flag::set("gondola_doors_moving");
        e_gondola gondola_doors_move(e_gondola.location, -1);
    }
    level notify(#"gondola_moving");
    check_when_gondola_moves_if_groundent_is_undefined(e_gondola);
    level flag::clear("gondola_doors_moving");
    a_players = getplayers();
    foreach (player in a_players) {
        if (player function_250c012e()) {
            player clientfield::set_to_player("" + #"rumble_gondola", 1);
            player.is_on_gondola = 1;
        }
    }
    a_e_brutus = getaiarchetypearray("brutus");
    foreach (e_brutus in a_e_brutus) {
        if (e_brutus function_250c012e()) {
            e_brutus.var_76b55fb2 = 1;
            e_brutus.var_fbe1f7e9 = 1;
            var_ba12b0c3 = 1;
        }
    }
    foreach (e_enemy in level.ai[#"axis"]) {
        if (e_enemy function_250c012e()) {
            e_enemy.no_powerups = 1;
        }
    }
    e_gondola thread create_gondola_poi();
    e_gondola playsound(#"zmb_gondola_start");
    e_gondola playloopsound(#"zmb_gondola_lp", 1);
    e_gondola thread gondola_physics_explosion(10);
    level flag::set("gondola_in_motion");
    e_gondola thread function_255d6eb8();
    e_gondola vehicle::get_on_and_go_path(var_3311990f);
    e_gondola waittill(#"reached_end_node");
    level flag::clear("gondola_in_motion");
    a_e_brutus = getaiarchetypearray("brutus");
    foreach (e_brutus in a_e_brutus) {
        if (e_brutus function_250c012e()) {
            e_brutus.var_76b55fb2 = 0;
            e_brutus.var_fbe1f7e9 = undefined;
            var_8d963630 = 1;
        }
    }
    if (isdefined(var_ba12b0c3) && var_ba12b0c3 && isdefined(var_8d963630) && var_8d963630) {
        foreach (e_player in level.players) {
            if (isalive(e_player) && e_player function_250c012e()) {
                e_player notify(#"hash_7af72088379d7ac6");
            }
        }
    }
    e_gondola stoploopsound(0.5);
    e_gondola thread function_dc878e7d();
    e_gondola playsound(#"zmb_gondola_stop");
    player_escaped_gondola_failsafe();
    a_players = getplayers();
    foreach (player in a_players) {
        if (isdefined(player.is_on_gondola) && player.is_on_gondola) {
            player clientfield::set_to_player("" + #"rumble_gondola", 0);
            player.is_on_gondola = undefined;
        }
    }
    level flag::set("gondola_doors_moving");
    e_gondola gondola_doors_move(e_gondola.destination, 1);
    e_gondola.is_moving = 0;
    e_gondola thread tear_down_gondola_poi();
    level flag::clear("gondola_doors_moving");
    wait 1;
    if (e_gondola.location == "roof") {
        e_gondola.location = "docks";
        str_zone = "zone_dock_gondola";
    } else if (e_gondola.location == "docks") {
        e_gondola.location = "roof";
        str_zone = "zone_cellblock_west_gondola_dock";
    }
    level notify(#"gondola_arrived", str_zone);
    gondola_cooldown();
    level flag::set("gondola_at_" + e_gondola.location);
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x54d08448, Offset: 0x3180
// Size: 0xb6
function gondola_lights_red() {
    var_fda7490b = getentarray("gondola_state_light", "targetname");
    foreach (model in var_fda7490b) {
        model setmodel(#"p8_zm_esc_gondola_frame_light_red");
        waitframe(1);
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0xb3d6e94b, Offset: 0x3240
// Size: 0xb6
function gondola_lights_green() {
    var_fda7490b = getentarray("gondola_state_light", "targetname");
    foreach (model in var_fda7490b) {
        model setmodel(#"p8_zm_esc_gondola_frame_light_green");
        waitframe(1);
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0xa3655346, Offset: 0x3300
// Size: 0x1a
function function_99f0f1c4() {
    wait 5;
    level.var_ab2fc54c = 1;
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0xd4916bb5, Offset: 0x3328
// Size: 0x1a
function function_aa5a7d5f() {
    wait 5;
    level.var_ab2fc54c = 0;
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 1, eflags: 0x0
// Checksum 0xaf1085bb, Offset: 0x3350
// Size: 0x11e
function check_when_gondola_moves_if_groundent_is_undefined(e_gondola) {
    wait 1;
    a_zombies = getaiteamarray(level.zombie_team);
    a_zombies = util::get_array_of_closest(e_gondola.origin, a_zombies);
    for (i = 0; i < a_zombies.size; i++) {
        if (distancesquared(e_gondola.origin, a_zombies[i].origin) < 90000) {
            ground_ent = a_zombies[i] getgroundent();
            if (!isdefined(ground_ent)) {
                a_zombies[i] dodamage(a_zombies[i].health + 1000, a_zombies[i].origin);
            }
        }
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0xf4545a4c, Offset: 0x3478
// Size: 0x218
function create_gondola_poi() {
    a_players = getplayers();
    foreach (player in a_players) {
        if (!(isdefined(player.is_on_gondola) && player.is_on_gondola)) {
            return;
        }
    }
    s_poi = struct::get("gondola_poi_" + self.destination, "targetname");
    e_poi = spawn("script_origin", s_poi.origin);
    e_poi zm_utility::create_zombie_point_of_interest(1000, 30, 5000, 1);
    e_poi zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 128);
    self.poi = e_poi;
    a_ai_zombies = getaiteamarray(level.zombie_team);
    foreach (ai_zombie in a_ai_zombies) {
        if (ai_zombie istouching(level.e_gondola.t_ride)) {
            ai_zombie zm_utility::add_poi_to_ignore_list(e_poi);
        }
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x48c998e1, Offset: 0x3698
// Size: 0x44
function tear_down_gondola_poi() {
    if (isdefined(self.poi)) {
        zm_utility::remove_poi_attractor(self.poi);
        self.poi delete();
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x94907b12, Offset: 0x36e8
// Size: 0xec
function gondola_moving_vo() {
    if (isdefined(level.custom_gondola_moving_vo_func)) {
        self thread [[ level.custom_gondola_moving_vo_func ]]();
        return;
    }
    a_zombies = getaiteamarray(level.zombie_team);
    if (!level function_20662bf0(a_zombies, level.e_gondola)) {
        if (isdefined(level.var_224d0ed4)) {
            if (level.var_f0d177cc < 3) {
                level.var_224d0ed4 zm_audio::create_and_play_dialog("gondola", "active", undefined, 1);
                level.var_f0d177cc++;
            }
            level thread function_91e8e624();
        }
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x4ed7bdea, Offset: 0x37e0
// Size: 0xb8
function array_players_on_gondola() {
    a_players_on_gondola = [];
    a_players = getplayers();
    foreach (player in a_players) {
        if (player function_250c012e()) {
            a_players_on_gondola[a_players_on_gondola.size] = player;
        }
    }
    return a_players_on_gondola;
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 2, eflags: 0x0
// Checksum 0x25a5b38c, Offset: 0x38a0
// Size: 0x58
function function_20662bf0(a_zombies, e_gondola) {
    a_zombies = util::get_array_of_closest(e_gondola.origin, a_zombies, undefined, 1, 256);
    if (a_zombies.size > 0) {
        return 1;
    }
    return 0;
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x63387e3f, Offset: 0x3900
// Size: 0x94
function function_91e8e624() {
    wait 7;
    var_bdaa9c32 = array_players_on_gondola();
    if (var_bdaa9c32.size == 1) {
        var_bdaa9c32[0] zm_audio::create_and_play_dialog("gondola", "ride_solo", undefined, 1);
        return;
    }
    if (var_bdaa9c32.size > 1) {
        level zm_vo::play_banter("gondola_banter", undefined, var_bdaa9c32);
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 1, eflags: 0x0
// Checksum 0xe10192ef, Offset: 0x39a0
// Size: 0x7a
function gondola_physics_explosion(n_move_time) {
    self endon(#"movedone");
    for (i = 0; i < 2; i++) {
        physicsexplosionsphere(self.origin, 1000, 0.1, 0.1);
        wait n_move_time / 2;
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x3b62d0a8, Offset: 0x3a28
// Size: 0x74
function function_dc878e7d() {
    self playloopsound(#"zmb_gondola_cooldown_lp", 1);
    wait 10;
    wait 2;
    self stoploopsound(0.5);
    self playsound(#"hash_5ecb872a9078d4bf");
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x44e96db6, Offset: 0x3aa8
// Size: 0x1d0
function player_escaped_gondola_failsafe() {
    a_players = getplayers();
    foreach (player in a_players) {
        if (isdefined(player.is_on_gondola) && player.is_on_gondola && !player function_250c012e()) {
            if (!(isdefined(player.afterlife) && player.afterlife) && isalive(player)) {
                a_s_orgs = struct::get_array("gondola_dropped_parts_" + level.e_gondola.destination, "targetname");
                foreach (struct in a_s_orgs) {
                    if (!positionwouldtelefrag(struct.origin)) {
                        player setorigin(struct.origin);
                        break;
                    }
                }
            }
        }
    }
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x0
// Checksum 0x75fa328c, Offset: 0x3c80
// Size: 0xcc
function gondola_cooldown() {
    a_t_call = getentarray("gondola_call_trigger", "targetname");
    foreach (trigger in a_t_call) {
        trigger sethintstring(#"hash_72dc5724ddfb88b5");
    }
    wait 10;
    gondola_lights_green();
}

// Namespace zm_escape_travel/zm_escape_travel
// Params 0, eflags: 0x4
// Checksum 0x16e1c80b, Offset: 0x3d58
// Size: 0x74
function private function_255d6eb8() {
    var_fe86219d = struct::get("gondola_wires");
    var_fe86219d thread scene::play("Shot 2");
    self waittill(#"reached_end_node");
    var_fe86219d thread scene::play("Shot 1");
}

