#using scripts\core_common\array_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_bgb_anywhere_but_here;

// Namespace zm_bgb_anywhere_but_here/zm_bgb_anywhere_but_here
// Params 0, eflags: 0x2
// Checksum 0xec25932c, Offset: 0x1b8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_anywhere_but_here", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_anywhere_but_here/zm_bgb_anywhere_but_here
// Params 0, eflags: 0x0
// Checksum 0xd49fb4f2, Offset: 0x208
// Size: 0x13c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    level._effect[#"teleport_splash"] = "zombie/fx_bgb_anywhere_but_here_teleport_zmb";
    level._effect[#"teleport_aoe"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_zmb";
    level._effect[#"teleport_aoe_kill"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_kill_zmb";
    bgb::register(#"zm_bgb_anywhere_but_here", "activated", 1, undefined, undefined, &validation, &activation);
    bgb::function_4cda71bf(#"zm_bgb_anywhere_but_here", 1);
    bgb::function_e1ef21fb(#"zm_bgb_anywhere_but_here", 1);
}

// Namespace zm_bgb_anywhere_but_here/zm_bgb_anywhere_but_here
// Params 0, eflags: 0x0
// Checksum 0x258ec3a7, Offset: 0x350
// Size: 0x594
function activation() {
    self val::set(#"hash_7d2b25df35ca5b3", "ignoreme");
    zm_ai_utility::function_9e2bcbcf(self);
    playsoundatposition(#"zmb_bgb_abh_teleport_out", self.origin);
    if (isdefined(level.var_2c12d9a6)) {
        s_respawn_point = self [[ level.var_2c12d9a6 ]]();
    } else {
        s_respawn_point = self function_728dfe3();
    }
    assert(isdefined(s_respawn_point), "<dev string:x30>" + self.origin);
    self setorigin(s_respawn_point.origin);
    self.angles = s_respawn_point.angles;
    self val::set(#"hash_7d2b25df35ca5b3", "freezecontrols", 1);
    v_return_pos = self.origin + (0, 0, 60);
    a_ai = getaiteamarray(level.zombie_team);
    a_closest = [];
    ai_closest = undefined;
    if (a_ai.size) {
        a_closest = arraysortclosest(a_ai, self.origin);
        foreach (ai in a_closest) {
            n_trace_val = ai sightconetrace(v_return_pos, self);
            if (n_trace_val > 0.2) {
                ai_closest = ai;
                break;
            }
        }
        if (isdefined(ai_closest)) {
            self setplayerangles(vectortoangles(ai_closest getcentroid() - v_return_pos));
        }
    }
    self playsound(#"zmb_bgb_abh_teleport_in");
    if (isdefined(level.var_2300a8ad)) {
        self [[ level.var_2300a8ad ]]();
    }
    wait 0.5;
    self show();
    playfx(level._effect[#"teleport_splash"], self.origin);
    playfx(level._effect[#"teleport_aoe"], self.origin);
    a_ai = getaiarray();
    a_aoe_ai = arraysortclosest(a_ai, self.origin, a_ai.size, 0, 200);
    foreach (ai in a_aoe_ai) {
        if (isactor(ai)) {
            if (ai.archetype === "zombie") {
                playfx(level._effect[#"teleport_aoe_kill"], ai gettagorigin("j_spineupper"));
            } else {
                playfx(level._effect[#"teleport_aoe_kill"], ai.origin);
            }
            ai.marked_for_recycle = 1;
            ai.has_been_damaged_by_player = 0;
            ai dodamage(ai.health + 1000, self.origin, self);
        }
    }
    wait 0.2;
    self val::reset(#"hash_7d2b25df35ca5b3", "freezecontrols");
    self zm_stats::increment_challenge_stat("GUM_GOBBLER_ANYWHERE_BUT_HERE");
    wait 3;
    self val::reset(#"hash_7d2b25df35ca5b3", "ignoreme");
}

// Namespace zm_bgb_anywhere_but_here/zm_bgb_anywhere_but_here
// Params 0, eflags: 0x0
// Checksum 0x7c30daf, Offset: 0x8f0
// Size: 0x4e
function validation() {
    if (isdefined(level.zm_bgb_anywhere_but_here_validation_override)) {
        return [[ level.zm_bgb_anywhere_but_here_validation_override ]]();
    }
    s_point = function_728dfe3();
    if (!isdefined(s_point)) {
        return 0;
    }
    return 1;
}

// Namespace zm_bgb_anywhere_but_here/zm_bgb_anywhere_but_here
// Params 0, eflags: 0x0
// Checksum 0xe4161e14, Offset: 0x948
// Size: 0x2a8
function function_728dfe3() {
    var_a6abcc5d = zm_zonemgr::get_zone_from_position(self.origin + (0, 0, 32), 0);
    if (!isdefined(var_a6abcc5d)) {
        var_a6abcc5d = self.zone_name;
    }
    if (isdefined(var_a6abcc5d)) {
        var_c30975d2 = level.zones[var_a6abcc5d];
    }
    a_s_respawn_points = struct::get_array("player_respawn_point", "targetname");
    a_s_valid_respawn_points = [];
    foreach (s_respawn_point in a_s_respawn_points) {
        if (zm_utility::is_point_inside_enabled_zone(s_respawn_point.origin, var_c30975d2)) {
            if (!isdefined(a_s_valid_respawn_points)) {
                a_s_valid_respawn_points = [];
            } else if (!isarray(a_s_valid_respawn_points)) {
                a_s_valid_respawn_points = array(a_s_valid_respawn_points);
            }
            a_s_valid_respawn_points[a_s_valid_respawn_points.size] = s_respawn_point;
        }
    }
    if (isdefined(level.var_2d4e3645)) {
        a_s_valid_respawn_points = [[ level.var_2d4e3645 ]](a_s_valid_respawn_points);
    }
    s_player_respawn = undefined;
    if (a_s_valid_respawn_points.size > 0) {
        var_90551969 = array::random(a_s_valid_respawn_points);
        var_46b9bbf8 = struct::get_array(var_90551969.target, "targetname");
        foreach (var_dbd59eb2 in var_46b9bbf8) {
            n_script_int = self getentitynumber() + 1;
            if (var_dbd59eb2.script_int === n_script_int) {
                s_player_respawn = var_dbd59eb2;
            }
        }
    }
    return s_player_respawn;
}

// Namespace zm_bgb_anywhere_but_here/zm_bgb_anywhere_but_here
// Params 1, eflags: 0x0
// Checksum 0x7208dff8, Offset: 0xbf8
// Size: 0x76
function function_f9947cd5(b_enable = 1) {
    if (b_enable) {
        level.var_2d4e3645 = level.var_939891e;
        level.var_939891e = undefined;
        return;
    }
    level.var_939891e = level.var_2d4e3645;
    level.var_2d4e3645 = &function_b0574f0e;
}

// Namespace zm_bgb_anywhere_but_here/zm_bgb_anywhere_but_here
// Params 1, eflags: 0x0
// Checksum 0xe4e1abf2, Offset: 0xc78
// Size: 0xe
function function_b0574f0e(var_cbd1652f) {
    return [];
}

