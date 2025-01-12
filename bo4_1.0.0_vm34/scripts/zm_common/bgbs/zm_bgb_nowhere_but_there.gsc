#using scripts\core_common\array_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_bgb_nowhere_but_there;

// Namespace zm_bgb_nowhere_but_there/zm_bgb_nowhere_but_there
// Params 0, eflags: 0x2
// Checksum 0xbb8954a8, Offset: 0x118
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_bgb_nowhere_but_there", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_nowhere_but_there/zm_bgb_nowhere_but_there
// Params 0, eflags: 0x0
// Checksum 0x8418adaa, Offset: 0x160
// Size: 0xc4
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_nowhere_but_there", "activated", 1, undefined, undefined, &validation, &activation);
    bgb::function_4cda71bf(#"zm_bgb_nowhere_but_there", 1);
    bgb::function_e1ef21fb(#"zm_bgb_nowhere_but_there", 1);
}

// Namespace zm_bgb_nowhere_but_there/zm_bgb_nowhere_but_there
// Params 0, eflags: 0x0
// Checksum 0x7b4e75b4, Offset: 0x230
// Size: 0x61c
function activation() {
    self val::set(#"zm_bgb_nowhere_but_there", "ignoreme");
    zm_ai_utility::function_9e2bcbcf(self);
    playsoundatposition(#"zmb_bgb_abh_teleport_out", self.origin);
    if (isdefined(level.var_3a1718ed)) {
        s_respawn_point = self [[ level.var_3a1718ed ]]();
    } else {
        s_respawn_point = self function_f2a3427e();
    }
    assert(isdefined(s_respawn_point), "<dev string:x30>" + self.origin);
    self setorigin(s_respawn_point.origin);
    self.angles = s_respawn_point.angles;
    self val::set(#"zm_bgb_nowhere_but_there", "freezecontrols", 1);
    v_return_pos = self.origin + (0, 0, 60);
    a_closest = [];
    foreach (player in level.activeplayers) {
        if (player laststand::player_is_in_laststand()) {
            if (!isdefined(a_closest)) {
                a_closest = [];
            } else if (!isarray(a_closest)) {
                a_closest = array(a_closest);
            }
            a_closest[a_closest.size] = player;
        }
    }
    if (a_closest.size) {
        a_closest = arraysortclosest(a_closest, self.origin);
        foreach (player in a_closest) {
            n_trace_val = player sightconetrace(v_return_pos, self);
            if (n_trace_val > 0.2) {
                var_72bb9cba = player;
                break;
            }
        }
        if (isdefined(var_72bb9cba)) {
            self setplayerangles(vectortoangles(var_72bb9cba getcentroid() - v_return_pos));
        }
    }
    self playsound(#"zmb_bgb_abh_teleport_in");
    if (isdefined(level.var_4a0dc6a8)) {
        self [[ level.var_4a0dc6a8 ]]();
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
    self val::reset(#"zm_bgb_nowhere_but_there", "freezecontrols");
    wait 3;
    self val::reset(#"zm_bgb_nowhere_but_there", "ignoreme");
}

// Namespace zm_bgb_nowhere_but_there/zm_bgb_nowhere_but_there
// Params 0, eflags: 0x0
// Checksum 0x7aa07b31, Offset: 0x858
// Size: 0x4e
function validation() {
    if (isdefined(level.var_12d4b7bf)) {
        return [[ level.var_12d4b7bf ]]();
    }
    s_point = function_f2a3427e();
    if (!isdefined(s_point)) {
        return 0;
    }
    return 1;
}

// Namespace zm_bgb_nowhere_but_there/zm_bgb_nowhere_but_there
// Params 0, eflags: 0x0
// Checksum 0xf2ef4c0f, Offset: 0x8b0
// Size: 0x4e4
function function_f2a3427e() {
    var_7d16658 = [];
    foreach (player in level.activeplayers) {
        if (player laststand::player_is_in_laststand()) {
            if (!isdefined(var_7d16658)) {
                var_7d16658 = [];
            } else if (!isarray(var_7d16658)) {
                var_7d16658 = array(var_7d16658);
            }
            var_7d16658[var_7d16658.size] = player;
        }
    }
    if (var_7d16658.size) {
        arraysortclosest(var_7d16658, self.origin);
        var_7d16658 = array::reverse(var_7d16658);
        e_player = var_7d16658[0];
    } else {
        return undefined;
    }
    a_s_respawn_points = struct::get_array("player_respawn_point", "targetname");
    a_s_valid_respawn_points = [];
    foreach (s_respawn_point in a_s_respawn_points) {
        if (zm_utility::is_point_inside_enabled_zone(s_respawn_point.origin)) {
            if (!isdefined(a_s_valid_respawn_points)) {
                a_s_valid_respawn_points = [];
            } else if (!isarray(a_s_valid_respawn_points)) {
                a_s_valid_respawn_points = array(a_s_valid_respawn_points);
            }
            a_s_valid_respawn_points[a_s_valid_respawn_points.size] = s_respawn_point;
        }
    }
    var_ad3df001 = e_player zm_zonemgr::get_player_zone();
    if (level.zones[var_ad3df001].a_loc_types[#"wait_location"].size) {
        a_s_valid_respawn_points = arraycombine(a_s_valid_respawn_points, level.zones[var_ad3df001].a_loc_types[#"wait_location"], 0, 0);
    }
    if (isdefined(level.var_4ec5147a)) {
        a_s_valid_respawn_points = [[ level.var_4ec5147a ]](a_s_valid_respawn_points);
    }
    s_player_respawn = undefined;
    if (a_s_valid_respawn_points.size > 0) {
        var_90551969 = arraygetclosest(e_player.origin, a_s_valid_respawn_points);
        if (var_90551969.script_noteworthy == "wait_location") {
            if (!positionwouldtelefrag(var_90551969.origin)) {
                return var_90551969;
            }
        }
        var_46b9bbf8 = struct::get_array(var_90551969.target, "targetname");
        foreach (var_dbd59eb2 in var_46b9bbf8) {
            n_script_int = self getentitynumber() + 1;
            if (var_dbd59eb2.script_int === n_script_int) {
                if (!positionwouldtelefrag(var_dbd59eb2.origin)) {
                    return var_dbd59eb2;
                }
            }
        }
        if (!isdefined(s_player_respawn)) {
            foreach (var_dbd59eb2 in var_46b9bbf8) {
                if (!positionwouldtelefrag(var_dbd59eb2.origin)) {
                    return var_dbd59eb2;
                }
            }
        }
    }
    return s_player_respawn;
}

// Namespace zm_bgb_nowhere_but_there/zm_bgb_nowhere_but_there
// Params 1, eflags: 0x0
// Checksum 0xb817067a, Offset: 0xda0
// Size: 0x76
function function_8490322c(b_enable = 1) {
    if (b_enable) {
        level.var_4ec5147a = level.var_b8fb023f;
        level.var_b8fb023f = undefined;
        return;
    }
    level.var_b8fb023f = level.var_4ec5147a;
    level.var_4ec5147a = &function_c0874225;
}

// Namespace zm_bgb_nowhere_but_there/zm_bgb_nowhere_but_there
// Params 1, eflags: 0x0
// Checksum 0xd07e3c04, Offset: 0xe20
// Size: 0xe
function function_c0874225(var_cbd1652f) {
    return [];
}

