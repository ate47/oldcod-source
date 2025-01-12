#using script_1cc417743d7c262d;
#using script_75da5547b1822294;
#using script_d9b5c8b1ad38ef5;
#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot_insertion;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_free_fall;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace player_insertion;

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x6
// Checksum 0x4eb65a17, Offset: 0xa48
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player_insertion", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x683dba58, Offset: 0xa90
// Size: 0x1c
function function_63977a98(newtime) {
    level.var_8367fa0f = newtime;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x42797d72, Offset: 0xab8
// Size: 0x1c
function function_d28162a2(newtime) {
    level.var_ab0cc070 = newtime;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0xdf4939e4, Offset: 0xae0
// Size: 0x1c
function function_1a50e8a5(newtime) {
    level.var_b28c6a29 = newtime;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x5 linked
// Checksum 0x8a0e4d4f, Offset: 0xb08
// Size: 0x54c
function private function_70a657d8() {
    if (level.var_f2814a96 !== 0 && level.var_f2814a96 !== 2) {
        return;
    }
    var_1194a9a5 = struct::get_array("infil_spawn", "targetname");
    /#
        if (var_1194a9a5.size == 0) {
            var_1194a9a5 = struct::get_array("<dev string:x38>", "<dev string:x4a>");
        }
    #/
    level.insertions = [];
    var_3bc28449 = max(isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1, 1);
    assert(var_3bc28449 > 0 && var_3bc28449 <= 2);
    for (index = 0; index < var_3bc28449; index++) {
        insertion = {#index:index, #allowed:1, #spawnpoints:var_1194a9a5, #players:[]};
        level.insertions[level.insertions.size] = insertion;
        callback::on_finalize_initialization(&on_finalize_initialization, insertion);
    }
    level.insertion = level.insertions[0];
    clientfield::register("vehicle", "infiltration_transport", 1, 1, "int");
    clientfield::register("vehicle", "infiltration_landing_gear", 1, 1, "int");
    clientfield::register("toplayer", "infiltration_jump_warning", 1, 1, "int");
    clientfield::register("toplayer", "infiltration_final_warning", 1, 1, "int");
    clientfield::register("toplayer", "inside_infiltration_vehicle", 1, 1, "int");
    clientfield::register("world", "infiltration_compass", 1, 2, "int");
    clientfield::register("scriptmover", "infiltration_ent", 1, 2, "int");
    clientfield::register("scriptmover", "infiltration_plane", 1, 2, "int");
    clientfield::register("scriptmover", "infiltration_camera", 1, 3, "int");
    clientfield::register("scriptmover", "infiltration_jump_point", 1, 2, "int");
    clientfield::register("scriptmover", "infiltration_force_drop_point", 1, 2, "int");
    clientfield::register("toplayer", "heatblurpostfx", 1, 1, "int");
    clientfield::register("vehicle", "warpportalfx", 1, 1, "int");
    clientfield::register("vehicle", "warpportalfx_launch", 1, 1, "counter");
    clientfield::register("toplayer", "warpportal_fx_wormhole", 1, 1, "int");
    /#
        level thread function_943c98fb(level.insertion);
    #/
    if (!isdefined(level.var_8367fa0f)) {
        level.var_8367fa0f = 2;
    }
    if (!isdefined(level.var_ab0cc070)) {
        level.var_ab0cc070 = 2;
    }
    if (!isdefined(level.var_b28c6a29)) {
        level.var_b28c6a29 = 5;
    }
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x1 linked
// Checksum 0xf2fa0674, Offset: 0x1060
// Size: 0x5a
function function_1e4302d0(value, index) {
    assert(index < 2);
    newvalue = value << 1 | index & 1;
    return newvalue;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x1209c692, Offset: 0x10c8
// Size: 0x172
function function_3ca86964(var_1d83d08d) {
    var_6024133d = getentarray("map_corner", "targetname");
    if (var_6024133d.size == 0) {
        return;
    }
    mins = (-150000, -150000, 0);
    maxs = (150000, 150000, 0);
    o_a = var_6024133d[0].origin;
    o_b = var_6024133d[1].origin;
    mins = (min(o_a[0], o_b[0]), min(o_a[1], o_b[1]), -150000);
    maxs = (max(o_a[0], o_b[0]), max(o_a[1], o_b[1]), 150000);
    return function_24531a26(var_1d83d08d.start, var_1d83d08d.end, mins, maxs);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x5 linked
// Checksum 0xf5d249a4, Offset: 0x1248
// Size: 0x2fc
function private on_finalize_initialization() {
    if (level.deathcircle.enabled) {
        level flag::wait_till(#"hash_43bac6444a9b65f3");
    }
    level.var_c7f8ccf6 = isdefined(level.var_427d6976.("insertionSpeed")) ? level.var_427d6976.("insertionSpeed") : 100;
    /#
        level.var_c7f8ccf6 = getdvarfloat(#"hash_51db9b26f6097296", level.var_c7f8ccf6);
    #/
    insertion = self;
    assert(isstruct(insertion));
    waitframe(1);
    /#
        if (getdvarint(#"scr_disable_infiltration", 0)) {
            return;
        }
        var_6024133d = getentarray("<dev string:x58>", "<dev string:x4a>");
        if (var_6024133d.size == 0) {
            return;
        }
    #/
    var_3bc28449 = isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1;
    offsetdistance = isdefined(getgametypesetting(#"hash_75a36f7e4a81c93")) ? getgametypesetting(#"hash_75a36f7e4a81c93") : 0;
    if (var_3bc28449 > 0 && insertion.index > 0) {
        var_df4f7099 = level.insertions[0];
        var_df4f7099 flag::wait_till(#"hash_4e5fc66b9144a5c8");
        function_d53a8c5b(insertion, var_df4f7099.fly_over_point, var_df4f7099.var_59526dd5 - 180, offsetdistance);
        return;
    }
    var_7ed8b321 = function_6671872c();
    var_684dfce3 = function_45644b08();
    function_d53a8c5b(insertion, var_7ed8b321, var_684dfce3, offsetdistance);
}

// Namespace player_insertion/player_insertion
// Params 3, eflags: 0x5 linked
// Checksum 0x9ad4583a, Offset: 0x1550
// Size: 0x7a
function private function_fd3c1bcc(start, end, default_val) {
    trace = worldtrace(start, end);
    if (trace[#"fraction"] < 1) {
        return trace[#"position"];
    }
    return default_val;
}

// Namespace player_insertion/player_insertion
// Params 4, eflags: 0x1 linked
// Checksum 0x5dedc149, Offset: 0x15d8
// Size: 0x304
function function_d53a8c5b(insertion, fly_over_point, var_59526dd5, offset) {
    assert(isstruct(insertion));
    assert(isvec(fly_over_point));
    assert(isint(var_59526dd5) || isfloat(var_59526dd5));
    insertion.fly_over_point = fly_over_point;
    insertion.var_59526dd5 = var_59526dd5;
    var_872f085f = (0, var_59526dd5, 0);
    direction = anglestoforward(var_872f085f);
    direction = vectornormalize(direction);
    var_7c712437 = fly_over_point + anglestoright(var_872f085f) * offset;
    var_1d83d08d = {#start:var_7c712437 + direction * -150000, #end:var_7c712437 + direction * 150000};
    result = function_3ca86964(var_1d83d08d);
    midpoint = (result.start + result.end) / 2;
    var_1d83d08d.start = function_fd3c1bcc(midpoint, var_1d83d08d.start, result.start);
    var_1d83d08d.end = function_fd3c1bcc(midpoint, var_1d83d08d.end, result.end);
    if (is_true(getgametypesetting(#"hash_82c01ef004ff0a3"))) {
        function_9ddb4115(var_1d83d08d);
    }
    var_1d83d08d.start = function_ea1ad421(insertion, fly_over_point, var_1d83d08d.start);
    var_1d83d08d.end = function_ea1ad421(insertion, fly_over_point, var_1d83d08d.end);
    fly_path(insertion, var_1d83d08d, var_7c712437, var_59526dd5);
    insertion flag::set(#"hash_4e5fc66b9144a5c8");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x5 linked
// Checksum 0x61b810a1, Offset: 0x18e8
// Size: 0x26a
function private function_9ddb4115(var_1d83d08d) {
    assert(isstruct(var_1d83d08d));
    assert(isdefined(var_1d83d08d.start));
    assert(isdefined(var_1d83d08d.end));
    if (isdefined(level.deathcircles) && level.deathcircles.size > 0) {
        initcircle = level.deathcircles[0];
        newstart = var_1d83d08d.start;
        toend = vectornormalize(var_1d83d08d.end - var_1d83d08d.start);
        for (var_164fe5c9 = distance2dsquared(newstart, initcircle.origin); var_164fe5c9 > function_a3f6cdac(initcircle.radius); var_164fe5c9 = var_c820832) {
            newstart += toend * 1000;
            var_c820832 = distance2dsquared(newstart, initcircle.origin);
            if (var_c820832 > var_164fe5c9) {
                break;
            }
        }
        var_1d83d08d.start = newstart;
        var_1b8e09d2 = var_1d83d08d.end;
        var_6d773f9e = toend * -1;
        for (var_164fe5c9 = distance2dsquared(var_1b8e09d2, initcircle.origin); var_164fe5c9 > function_a3f6cdac(initcircle.radius); var_164fe5c9 = var_c820832) {
            var_1b8e09d2 += var_6d773f9e * 1000;
            var_c820832 = distance2dsquared(var_1b8e09d2, initcircle.origin);
            if (var_c820832 > var_164fe5c9) {
                break;
            }
        }
        var_1d83d08d.end = var_1b8e09d2;
    }
}

// Namespace player_insertion/player_insertion
// Params 4, eflags: 0x5 linked
// Checksum 0x7bd5eb0f, Offset: 0x1b60
// Size: 0x704
function private fly_path(insertion, var_1d83d08d, fly_over_point, var_59526dd5) {
    assert(isstruct(insertion));
    var_872f085f = (0, var_59526dd5, 0);
    direction = anglestoforward(var_872f085f);
    direction = vectornormalize(direction);
    var_b828343b = isdefined(level.var_427d6976.("insertionDropStartOffset")) ? level.var_427d6976.("insertionDropStartOffset") : 5000;
    var_59141f3d = isdefined(level.var_427d6976.("insertionDropEndOffset")) ? level.var_427d6976.("insertionDropEndOffset") : 15000;
    var_82b0af47 = var_1d83d08d.start + var_b828343b * direction;
    var_ee07e61a = var_1d83d08d.end - var_59141f3d * direction;
    var_5d59bc67 = 17.6 * level.var_c7f8ccf6;
    var_858edbc2 = var_5d59bc67 * (isdefined(level.var_427d6976.("insertionPreDropTime")) ? level.var_427d6976.("insertionPreDropTime") : 10);
    var_abb846da = var_5d59bc67 * (isdefined(level.var_427d6976.("insertionPostDropTime")) ? level.var_427d6976.("insertionPostDropTime") : 20);
    startpoint = var_82b0af47 - var_858edbc2 * direction;
    endpoint = var_ee07e61a + var_abb846da * direction;
    /#
        if (getdvarint(#"scr_insertion_debug", 0) == 1) {
            offset = (0, 0, 300);
            debug_sphere(var_1d83d08d.start + 2 * offset, 45, (0, 1, 1));
            debug_sphere(var_1d83d08d.end + 2 * offset, 45, (1, 1, 0));
            debug_sphere(fly_over_point, 75, (1, 1, 1));
            var_92a2e682 = (0, 0, 500);
            debug_sphere(var_82b0af47, 75, (0, 1, 0));
            debug_sphere(var_ee07e61a, 75, (1, 0, 0));
            debug_line(var_82b0af47, var_ee07e61a, (0, 1, 0));
            debug_line(var_82b0af47 + var_92a2e682, var_82b0af47 - var_92a2e682, (0, 1, 0));
            debug_line(var_ee07e61a + var_92a2e682, var_ee07e61a - var_92a2e682, (1, 0, 0));
            debug_sphere(startpoint, 75, (1, 0.5, 0));
            debug_sphere(endpoint, 75, (1, 0.5, 0));
            debug_line(var_82b0af47, startpoint, (1, 0, 0));
            debug_line(var_ee07e61a, endpoint, (1, 0, 0));
        }
    #/
    var_742f9da2 = distance(startpoint, var_82b0af47);
    var_f69b665b = distance(startpoint, var_ee07e61a);
    insertion thread function_e04b0ea8(insertion, startpoint, var_872f085f, var_742f9da2, var_f69b665b);
    currentvalue = level clientfield::get("infiltration_compass");
    newvalue = 1 << insertion.index | currentvalue;
    level clientfield::set("infiltration_compass", newvalue);
    insertion.start_point = startpoint;
    insertion.end_point = endpoint;
    insertion.var_f253731f = var_872f085f;
    insertion.var_37362e08 = var_742f9da2;
    insertion.var_7743b329 = var_f69b665b;
    if (max(isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1, 1) > 1) {
        util::wait_network_frame();
        insertion.infilteament = spawn("script_model", (0, 0, 0));
        insertion.infilteament.targetname = "infil_team_ent";
        insertion.infilteament setinvisibletoall();
        activeplayers = function_a1ef346b();
        foreach (player in activeplayers) {
            if (function_20cba65e(player) == insertion.index) {
                function_9368af66(insertion, player);
            }
        }
        callback::on_spawned(&function_1db63266);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xe7edf5bf, Offset: 0x2270
// Size: 0x9c
function function_1db63266() {
    assert(isplayer(self));
    insertionindex = function_20cba65e(self);
    insertion = level.insertions[insertionindex];
    if (isdefined(insertion) && isdefined(insertion.infilteament)) {
        function_9368af66(insertion, self);
    }
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x1 linked
// Checksum 0x4c3d976a, Offset: 0x2318
// Size: 0xc4
function function_9368af66(insertion, player) {
    assert(isstruct(insertion));
    assert(isplayer(player));
    insertion.infilteament setvisibletoplayer(player);
    insertion.infilteament clientfield::set("infiltration_ent", function_1e4302d0(1, insertion.index));
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0xa13adee3, Offset: 0x23e8
// Size: 0x1b4
function function_20cba65e(player) {
    assert(isplayer(player));
    if (!isdefined(player)) {
        return 0;
    }
    teams = array(#"allies", #"axis");
    for (index = 3; index <= level.teamcount; index++) {
        teams[teams.size] = #"team" + index;
    }
    var_aa3d62e3 = [];
    for (index = 0; index < teams.size; index++) {
        var_aa3d62e3[teams[index]] = index;
    }
    for (index = 0; index < max(isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1, 1); index++) {
        if (isdefined(var_aa3d62e3[player.team]) && var_aa3d62e3[player.team] == index % (teams.size - 1)) {
            return index;
        }
    }
    return 0;
}

// Namespace player_insertion/player_insertion
// Params 3, eflags: 0x1 linked
// Checksum 0xda5fe1e7, Offset: 0x25a8
// Size: 0x118
function function_ea1ad421(insertion, start, end) {
    assert(isstruct(insertion));
    direction = end - start;
    direction = vectornormalize(direction);
    step = isdefined(level.var_427d6976.("insertionOOBCheckStepSize")) ? level.var_427d6976.("insertionOOBCheckStepSize") : 1000;
    assert(!oob::chr_party(start));
    point = function_f31cf3bb(start, direction, step, 0);
    if (!isdefined(point)) {
        return end;
    }
    return point;
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x1 linked
// Checksum 0xc146aaf9, Offset: 0x26c8
// Size: 0x128
function function_f31cf3bb(point, direction, step, depth, var_94a1d56d = 5) {
    var_23685c5 = point;
    var_19132446 = 50;
    if (step < var_19132446) {
        return var_23685c5;
    }
    count = 0;
    fail_safe = 50;
    while (true) {
        if (depth > var_94a1d56d || count > fail_safe) {
            return undefined;
        }
        new_point = var_23685c5 + direction * step;
        touching = oob::chr_party(new_point);
        /#
        #/
        if (touching) {
            depth++;
            return function_f31cf3bb(var_23685c5, direction, step / 2, depth, var_94a1d56d);
        } else {
            count++;
        }
        var_23685c5 = new_point;
    }
}

// Namespace player_insertion/player_insertion
// Params 4, eflags: 0x0
// Checksum 0x3efc64dc, Offset: 0x27f8
// Size: 0x100
function function_bb2c2f4d(point, direction, step, depth) {
    for (var_6b1f4b9c = point; true; var_6b1f4b9c = new_point) {
        if (depth > 10) {
            return undefined;
        }
        new_point = var_6b1f4b9c - direction * step;
        touching = oob::chr_party(new_point);
        /#
            debug_sphere(new_point - (0, 0, 300), 45, touching ? (1, 0, 0) : (0, 1, 0));
        #/
        depth++;
        if (!touching) {
            return function_f31cf3bb(new_point, direction, step / 2, depth, 10);
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x5 linked
// Checksum 0x2a19b696, Offset: 0x2900
// Size: 0x19c
function private function_abd3bc1a() {
    if (!isalive(self)) {
        return;
    }
    self setactionslot(3, "");
    self setactionslot(4, "");
    self flag::clear(#"hash_224cb97b8f682317");
    self flag::clear(#"hash_287397edba8966f9");
    self val::set(#"player_insertion", "freezecontrols", 1);
    self val::set(#"player_insertion", "disablegadgets", 1);
    self val::set(#"player_insertion", "show_hud", 0);
    self val::set(#"player_insertion", "show_weapon_hud", 0);
    self death_circle::function_b57e3cde(1);
    if (isbot(self)) {
        self bot_insertion::function_9699dc95();
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x5 linked
// Checksum 0xdb3bd61, Offset: 0x2aa8
// Size: 0x7c
function private function_7a4c1517() {
    self val::reset(#"player_insertion", "freezecontrols");
    self val::reset(#"player_insertion", "disablegadgets");
    self val::reset(#"player_insertion", "show_hud");
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x857c89bb, Offset: 0x2b30
// Size: 0x64
function function_b9a53f50() {
    if (!self function_8b1a219a()) {
        self val::set(#"player_insertion", "freezecontrols_allowlook", 1);
    }
    self disableweapons();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x67fc81cf, Offset: 0x2ba0
// Size: 0x5c
function function_3354a054() {
    if (!self function_8b1a219a()) {
        self val::reset(#"player_insertion", "freezecontrols_allowlook");
    }
    self enableweapons();
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x5 linked
// Checksum 0x77f7f274, Offset: 0x2c08
// Size: 0x170
function private function_bc824660(insertion) {
    assert(isstruct(insertion));
    foreach (heli in insertion.var_41091905) {
        if (isdefined(heli)) {
            heli setspeedimmediate(level.var_c7f8ccf6 + 20);
        }
    }
    foreach (heli in insertion.var_dfaba736) {
        if (isdefined(heli)) {
            heli setspeedimmediate(level.var_c7f8ccf6 + 20);
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x5 linked
// Checksum 0x7eeb127e, Offset: 0x2d80
// Size: 0xd0
function private function_948ac812(insertion) {
    assert(isstruct(insertion));
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        player function_abd3bc1a();
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x5b01ec75, Offset: 0x2e58
// Size: 0x4c
function function_ff107056(insertion) {
    insertion flag::clear(#"insertion_teleport_completed");
    insertion flag::clear(#"insertion_presentation_completed");
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xb2323a75, Offset: 0x2eb0
// Size: 0x31c
function function_8dcd8623() {
    assert(isarray(level.insertions));
    /#
        if (getdvarint(#"scr_disable_infiltration", 0)) {
            level.var_bde3d03 = undefined;
            level flag::set(#"hash_60fcdd11812a0134");
            level flag::set(#"insertion_teleport_completed");
            level flag::set(#"insertion_begin_completed");
            return;
        }
        while (getplayers().size == 0) {
            wait 0.5;
        }
    #/
    level flag::set(#"spawning_allowed");
    level flag::clear(#"hash_60fcdd11812a0134");
    level flag::clear(#"insertion_teleport_completed");
    level flag::clear(#"insertion_begin_completed");
    for (index = 0; index < level.insertions.size; index++) {
        insertion = level.insertions[index];
        if (!is_true(insertion.allowed)) {
            return;
        }
        var_7eb8f61a = isdefined(getgametypesetting(#"wzplayerinsertiontypeindex")) ? getgametypesetting(#"wzplayerinsertiontypeindex") : 0;
        switch (var_7eb8f61a) {
        case 0:
            level thread function_82c73974(insertion);
            break;
        case 1:
            function_51c5f95f(insertion);
            break;
        case 2:
            function_35742117(insertion);
            break;
        case 3:
            level thread function_51b480e0(insertion);
            break;
        }
    }
    level flag::wait_till(#"insertion_begin_completed");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x7088f0d9, Offset: 0x31d8
// Size: 0x3bc
function function_82c73974(insertion) {
    assert(isstruct(insertion));
    insertion flag::clear(#"hash_60fcdd11812a0134");
    insertion flag::clear(#"hash_122f326d72f4c884");
    function_ff107056(insertion);
    fadeouttime = level.var_8367fa0f;
    blacktime = level.var_ab0cc070;
    fadeintime = level.var_b28c6a29;
    insertioncount = isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1;
    if (insertioncount > 0) {
        activeplayers = function_a1ef346b();
        var_2c34761b = [];
        otherplayers = [];
        foreach (player in activeplayers) {
            if (function_20cba65e(player) == insertion.index) {
                var_2c34761b[var_2c34761b.size] = player;
                continue;
            }
            otherplayers[otherplayers.size] = player;
        }
        insertion.players = var_2c34761b;
        insertion.otherplayers = otherplayers;
    } else {
        insertion.players = function_a1ef346b();
        insertion.otherplayers = [];
    }
    insertion thread function_c71552d0(insertion, fadeouttime, blacktime, fadeintime, 1);
    wait fadeouttime + 0.1;
    level callback::add_callback(#"hash_774be40ec06d5212", &function_bcde1e07, insertion);
    insertion thread globallogic_audio::function_85818e24("matchstart");
    insertion thread function_a4deb676();
    insertion flag::set(#"hash_122f326d72f4c884");
    level function_e59d879f(insertion, function_d9dfa25(), 1);
    function_dd34168c(insertion, #"insertion_teleport_completed");
    insertion flag::wait_till_timeout(blacktime + fadeintime + 0.5, #"insertion_presentation_completed");
    function_dd34168c(insertion, #"insertion_begin_completed");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0xb689d9ed, Offset: 0x35a0
// Size: 0x3ac
function function_51b480e0(insertion) {
    assert(isstruct(insertion));
    insertion flag::clear(#"hash_60fcdd11812a0134");
    insertion flag::clear(#"hash_122f326d72f4c884");
    function_ff107056(insertion);
    fadeouttime = level.var_8367fa0f;
    blacktime = level.var_ab0cc070;
    fadeintime = level.var_b28c6a29;
    insertioncount = isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1;
    if (insertioncount > 0) {
        activeplayers = function_a1ef346b();
        var_2c34761b = [];
        otherplayers = [];
        foreach (player in activeplayers) {
            if (function_20cba65e(player) == insertion.index) {
                var_2c34761b[var_2c34761b.size] = player;
                continue;
            }
            otherplayers[otherplayers.size] = player;
        }
        insertion.players = var_2c34761b;
        insertion.otherplayers = otherplayers;
    } else {
        insertion.players = function_a1ef346b();
        insertion.otherplayers = [];
    }
    insertion thread function_c71552d0(insertion, fadeouttime, blacktime, fadeintime, 1);
    wait fadeouttime + 0.1;
    level callback::add_callback(#"hash_774be40ec06d5212", &function_bcde1e07, insertion);
    insertion thread globallogic_audio::function_85818e24("matchstart");
    insertion thread function_a4deb676();
    insertion flag::set(#"hash_122f326d72f4c884");
    level function_7341cc88(insertion, 0);
    function_dd34168c(insertion, #"insertion_teleport_completed");
    insertion flag::wait_till_timeout(blacktime + fadeintime + 0.5, #"insertion_presentation_completed");
    function_dd34168c(insertion, #"insertion_begin_completed");
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x1 linked
// Checksum 0xa9fb4c8, Offset: 0x3958
// Size: 0x5c
function function_dd34168c(insertion, flag) {
    insertion flag::set(flag);
    if (function_df47b31b(flag)) {
        level flag::set(flag);
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0xf9f3ab6b, Offset: 0x39c0
// Size: 0x76
function function_df47b31b(flag) {
    for (index = 0; index < level.insertions.size; index++) {
        insertion = level.insertions[index];
        if (!insertion flag::get(flag)) {
            return false;
        }
    }
    return true;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x37663649, Offset: 0x3a40
// Size: 0x4c8
function function_35742117(insertion) {
    assert(isstruct(insertion));
    insertion flag::clear(#"hash_60fcdd11812a0134");
    insertion flag::clear(#"hash_122f326d72f4c884");
    function_ff107056(insertion);
    fadeouttime = level.var_8367fa0f;
    insertion.players = function_a1ef346b();
    foreach (player in insertion.players) {
        player val::set(#"player_insertion", "freezecontrols", 1);
        player val::set(#"player_insertion", "disablegadgets", 1);
    }
    insertion thread function_c71552d0(insertion, fadeouttime, 5, 5, 0);
    wait fadeouttime + 0.1;
    level thread function_a4deb676();
    insertion flag::set(#"hash_122f326d72f4c884");
    function_dd34168c(insertion, #"hash_60fcdd11812a0134");
    function_dd34168c(insertion, #"insertion_teleport_completed");
    level callback::callback(#"hash_774be40ec06d5212");
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (!isalive(player)) {
            continue;
        }
        player setorigin(player.resurrect_origin);
        player setplayerangles(player.resurrect_angles);
        level callback::callback(#"hash_74b19f5972b0ee52", {#player:player});
    }
    function_dd34168c(insertion, #"insertion_begin_completed");
    wait 5 + fadeouttime / 3;
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (!isalive(player)) {
            continue;
        }
        player val::reset(#"player_insertion", "freezecontrols");
        player val::reset(#"player_insertion", "disablegadgets");
        player clientfield::set_to_player("realtime_multiplay", 1);
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x2ac65097, Offset: 0x3f10
// Size: 0x39c
function function_51c5f95f(insertion) {
    assert(isstruct(insertion));
    insertion flag::clear(#"hash_60fcdd11812a0134");
    insertion flag::clear(#"hash_122f326d72f4c884");
    function_ff107056(insertion);
    fadeouttime = level.var_8367fa0f;
    blacktime = level.var_ab0cc070;
    fadeintime = level.var_b28c6a29;
    insertion.players = function_a1ef346b();
    level function_948ac812(insertion);
    insertion thread function_c71552d0(insertion, fadeouttime, blacktime, fadeintime, 1);
    wait fadeouttime + 0.1;
    insertion thread globallogic_audio::function_85818e24("matchstart");
    level thread function_a4deb676();
    insertion flag::set(#"hash_122f326d72f4c884");
    function_dd34168c(insertion, #"hash_60fcdd11812a0134");
    function_dd34168c(insertion, #"insertion_teleport_completed");
    level function_57d4a011(insertion);
    insertion flag::wait_till_timeout(0.5, #"insertion_presentation_completed");
    function_26fbfab4(insertion);
    var_990e3011 = 3;
    /#
        if (getdvarint(#"hash_96d977cb1cf39f8", 0) != 0) {
            var_990e3011 = getdvarint(#"hash_96d977cb1cf39f8", 2);
        }
    #/
    wait var_990e3011;
    level callback::callback(#"hash_774be40ec06d5212");
    callback::remove_on_spawned(&function_aa3a20fb);
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (!isalive(player)) {
            continue;
        }
        player thread function_adc8cff4();
    }
    function_dd34168c(insertion, #"insertion_begin_completed");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x97b96466, Offset: 0x42b8
// Size: 0x166
function function_26fbfab4(insertion) {
    assert(isstruct(insertion));
    level endon(#"game_ended");
    var_850118f3 = 5;
    /#
        if (getdvarint(#"hash_7f8ced042799da77", 0) != 0) {
            var_850118f3 = getdvarint(#"hash_7f8ced042799da77", 2);
        }
    #/
    foreach (player in insertion.players) {
        player function_abd3bc1a();
        if (!isalive(player)) {
            continue;
        }
        player thread function_135ed50e();
    }
    wait var_850118f3;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x86c63abe, Offset: 0x4428
// Size: 0xac
function function_135ed50e() {
    self endon(#"death");
    var_850118f3 = 5;
    /#
        if (getdvarint(#"hash_7f8ced042799da77", 0) != 0) {
            var_850118f3 = getdvarint(#"hash_7f8ced042799da77", 2);
        }
    #/
    self function_75488834();
    wait var_850118f3;
    self function_3a77bd05();
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x8d254116, Offset: 0x44e0
// Size: 0x6b4
function function_57d4a011(insertion) {
    assert(isstruct(insertion));
    var_5199e69 = getdvarint(#"hash_3602c5d9aaca933c", 20000);
    function_a5fd9aa8(insertion);
    bot_insertion::function_24ca8ecf(insertion);
    var_719e741e = getentarray("camera_vehicle", "targetname");
    if (isdefined(var_719e741e)) {
        numplayers = insertion.players.size;
        numteams = 1;
        assert(numplayers > 0, "<dev string:x66>");
        foreach (team in level.teams) {
            if (is_true(level.everexisted[team])) {
                numteams++;
            }
        }
        level.warp_portal_vehicles = [];
        count = 1;
        foreach (var_e1dd0f66 in var_719e741e) {
            var_b06f2346 = "warp_portal_vehicle_spawn_" + count;
            var_7cac53bf = var_e1dd0f66 spawnfromspawner(var_b06f2346, 1, 1);
            var_7cac53bf.takedamage = 0;
            var_7cac53bf ghost();
            if (!isdefined(level.warp_portal_vehicles)) {
                level.warp_portal_vehicles = [];
            } else if (!isarray(level.warp_portal_vehicles)) {
                level.warp_portal_vehicles = array(level.warp_portal_vehicles);
            }
            level.warp_portal_vehicles[level.warp_portal_vehicles.size] = var_7cac53bf;
            if (count >= numteams) {
                break;
            }
            count++;
        }
        var_8a2c40d0 = struct::get("warp_zone_look_at", "targetname");
        step_size = 360 / numteams;
        if (isdefined(var_8a2c40d0)) {
            center = var_8a2c40d0.origin;
            radius = 9000;
            angle = 0;
            foreach (portal_vehicle in level.warp_portal_vehicles) {
                x_pos = center[0] + radius * cos(angle);
                y_pos = center[1] + radius * sin(angle);
                z_pos = var_5199e69;
                portal_vehicle.origin = (x_pos, y_pos, z_pos);
                portal_vehicle.angle_step = angle;
                angle += step_size;
                target = var_8a2c40d0.origin - portal_vehicle.origin;
                target = vectornormalize(target);
                angles = vectortoangles(target);
                portal_vehicle.angles = angles;
            }
        }
        var_30fc202f = 0;
        foreach (team in level.teams) {
            if (is_true(level.everexisted[team])) {
                players = getplayers(team);
                foreach (player in players) {
                    if (isalive(player)) {
                        player.var_30fc202f = var_30fc202f;
                        player thread function_a25e421c();
                    }
                }
                var_30fc202f++;
                if (var_30fc202f > numteams - 1) {
                    var_30fc202f = numteams - 1;
                    break;
                }
            }
        }
    }
    callback::on_spawned(&function_aa3a20fb);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x4cf6cf5b, Offset: 0x4ba0
// Size: 0x164
function function_adc8cff4(reinserting = 0) {
    self endon(#"disconnect", #"death");
    self startcameratween(0.5);
    util::wait_network_frame();
    self show();
    self solid();
    self setclientthirdperson(0);
    self death_circle::function_b57e3cde(0);
    self val::set(#"player_insertion", "disable_oob", 0);
    self clientfield::set_to_player("realtime_multiplay", 1);
    self thread function_7bf9c38f(reinserting);
    level callback::callback(#"hash_74b19f5972b0ee52", {#player:self});
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xa99f5ec, Offset: 0x4d10
// Size: 0x68
function getmapcenter() {
    minimaporigins = territory::function_1f583d2e("minimap_corner", "targetname");
    if (minimaporigins.size) {
        return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
    }
    return (0, 0, 0);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0xc0c439c9, Offset: 0x4d80
// Size: 0x2fc
function function_7bf9c38f(*reinserting) {
    self endon(#"disconnect", #"death");
    self flag::set(#"hash_224cb97b8f682317");
    self flag::set(#"hash_287397edba8966f9");
    speed = 4400;
    circleindex = 1;
    if (isdefined(level.deathcircleindex)) {
        circleindex = level.deathcircleindex + 2;
    }
    speed /= circleindex;
    self unlink();
    var_180a7b48 = self function_ec7cfdb();
    /#
        if (getdvarint(#"hash_37b6eccbe31b5875", 0) != 0) {
            var_180a7b48 = getdvarint(#"hash_37b6eccbe31b5875", 1);
        }
    #/
    assert(isdefined(var_180a7b48), "<dev string:x8b>");
    if (!isdefined(var_180a7b48)) {
        var_180a7b48 = 0;
    }
    if (!isdefined(level.warp_portal_vehicles)) {
        level.warp_portal_vehicles = [];
    }
    if (level.warp_portal_vehicles.size) {
        portal = level.warp_portal_vehicles[var_180a7b48];
    }
    assert(isdefined(portal), "<dev string:xa6>");
    if (isdefined(portal)) {
        self setorigin(portal.origin);
    } else {
        center = getmapcenter();
        center = (center[0], center[1], getdvarint(#"hash_3602c5d9aaca933c", 20000));
        self setorigin(center);
    }
    velocity = anglestoforward(self getplayerangles()) * speed;
    start_freefall(velocity, 1);
    if (isdefined(portal)) {
        portal function_723d686d();
    }
    self thread function_2b276ae0();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x3dd72247, Offset: 0x5088
// Size: 0x344
function function_a25e421c() {
    self endon(#"disconnect", #"death");
    if (isalive(self)) {
        self thread status_effect::function_6519f95f();
        self death_circle::function_b57e3cde(1);
        self val::set(#"player_insertion", "disable_oob", 1);
        self stopanimscripted();
        self unlink();
        self setstance("stand");
        var_180a7b48 = self function_ec7cfdb();
        /#
            if (getdvarint(#"hash_37b6eccbe31b5875", 0) != 0) {
                var_180a7b48 = getdvarint(#"hash_37b6eccbe31b5875", 1);
            }
        #/
        if (isdefined(level.warp_portal_vehicles)) {
            portal = level.warp_portal_vehicles[var_180a7b48];
            if (isdefined(portal)) {
                self setorigin(level.warp_portal_vehicles[var_180a7b48].origin);
                self function_648c1f6(level.warp_portal_vehicles[var_180a7b48], undefined, 0, 180, 180, 180, 180, 0);
                if (death_circle::is_active()) {
                    target = death_circle::get_next_origin() - self.origin;
                } else {
                    var_8a2c40d0 = struct::get("warp_zone_look_at", "targetname");
                    target = var_8a2c40d0.origin - self.origin;
                }
                target = vectornormalize(target);
                angles = vectortoangles(target);
                self setplayerangles(angles);
            }
        }
        self gadget_health_regen::heal_end();
        self.health = self.spawnhealth;
        self ghost();
        self notsolid();
        self setclientthirdperson(1);
        self dontinterpolate();
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x4e8737e5, Offset: 0x53d8
// Size: 0x14c
function function_f2867466() {
    self notify("98dd2efe3faf84");
    self endon("98dd2efe3faf84");
    self endon(#"disconnect");
    level endon(#"game_ended");
    self flag::clear(#"hash_224cb97b8f682317");
    self flag::clear(#"hash_287397edba8966f9");
    waitframe(1);
    self function_a25e421c();
    self function_abd3bc1a();
    self function_135ed50e();
    var_990e3011 = 3;
    /#
        if (getdvarint(#"hash_96d977cb1cf39f8", 0) != 0) {
            var_990e3011 = getdvarint(#"hash_96d977cb1cf39f8", 2);
        }
    #/
    wait var_990e3011;
    self function_adc8cff4(1);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x2a436792, Offset: 0x5530
// Size: 0x84
function function_a5fd9aa8(insertion) {
    assert(isstruct(insertion));
    arrayremovevalue(insertion.players, undefined, 0);
    if (isdefined(insertion.otherplayers)) {
        arrayremovevalue(insertion.otherplayers, undefined, 0);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xd6eb5e76, Offset: 0x55c0
// Size: 0x34
function function_bcde1e07() {
    insertion = self;
    callback::remove_on_spawned(&function_80c60f66, insertion);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x5 linked
// Checksum 0xf3ad0045, Offset: 0x5600
// Size: 0x194
function private function_c62b5591(insertion) {
    assert(isstruct(insertion));
    if (!isdefined(insertion.cameraent)) {
        insertion.cameraent = [];
    }
    var_163b0077 = 0;
    foreach (i, plane in insertion.var_41091905) {
        if (self islinkedto(plane)) {
            if (isdefined(insertion.cameraent[i])) {
                insertion.cameraent[i] setvisibletoplayer(self);
            }
            var_163b0077 = 1;
            break;
        }
    }
    if (!var_163b0077 && insertion.var_41091905.size > 0) {
        if (isdefined(insertion.cameraent[insertion.var_41091905.size])) {
            insertion.cameraent[insertion.var_41091905.size] setvisibletoplayer(self);
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x1 linked
// Checksum 0xe117e7e1, Offset: 0x57a0
// Size: 0x60
function function_57fe9b21(*insertion, origin) {
    camera = spawn("script_model", origin);
    camera.targetname = "insertion_camera";
    camera setinvisibletoall();
    return camera;
}

// Namespace player_insertion/player_insertion
// Params 4, eflags: 0x1 linked
// Checksum 0x346d148a, Offset: 0x5808
// Size: 0xda8
function function_ca5b6591(insertion, *startorigin, endorigin, var_872f085f) {
    assert(isstruct(startorigin));
    self notify("5a96b093b9ce8192");
    self endon("5a96b093b9ce8192");
    startorigin.cameraent = [];
    var_21e6b5ae = anglestoforward(var_872f085f);
    var_1978c281 = isdefined(level.var_427d6976.("insertionCameraFollowPitch")) ? level.var_427d6976.("insertionCameraFollowPitch") : 35;
    var_8b5e86f4 = (var_1978c281, var_872f085f[1], var_872f085f[2]);
    var_65537f6d = anglestoforward(var_8b5e86f4);
    var_9cade497 = isdefined(level.var_427d6976.("insertionCameraFollowDistance")) ? level.var_427d6976.("insertionCameraFollowDistance") : 1600;
    camera_offset = var_9cade497 * -1 * var_65537f6d + var_21e6b5ae * level.var_c7f8ccf6 * 17.6 * 3;
    for (index = 0; index <= startorigin.var_41091905.size; index++) {
        plane = startorigin.var_41091905[index];
        if (!isdefined(plane)) {
            plane = startorigin.var_41091905[0];
        }
        if (isdefined(startorigin.cameraent[index])) {
            startorigin.cameraent[index] delete();
        }
        var_c5f933e4 = plane.origin + camera_offset;
        startorigin.cameraent[index] = function_57fe9b21(startorigin, var_c5f933e4);
        startorigin.cameraent[index].angles = var_8b5e86f4;
        startorigin.cameraent[index] clientfield::set("infiltration_camera", function_1e4302d0(1, startorigin.index));
    }
    function_a5fd9aa8(startorigin);
    foreach (player in startorigin.players) {
        player function_c62b5591(startorigin);
        player show_postfx();
    }
    foreach (player in startorigin.otherplayers) {
        player function_c62b5591(startorigin);
    }
    var_5960815d = 8.95;
    var_1b6a3e44 = [];
    for (index = 0; index <= startorigin.var_41091905.size; index++) {
        plane = startorigin.var_41091905[index];
        if (!isdefined(plane)) {
            plane = startorigin.var_41091905[0];
        }
        target_origin = plane.origin + (0, 0, 250) + var_21e6b5ae * level.var_c7f8ccf6 * 17.6 * var_5960815d;
        startorigin.cameraent[index] moveto(target_origin, var_5960815d + 4, 0, 0);
        if (!isdefined(var_1b6a3e44)) {
            var_1b6a3e44 = [];
        } else if (!isarray(var_1b6a3e44)) {
            var_1b6a3e44 = array(var_1b6a3e44);
        }
        var_1b6a3e44[var_1b6a3e44.size] = target_origin;
    }
    function_a5fd9aa8(startorigin);
    if (getgametypesetting(#"wzplayerinsertiontypeindex") != 3) {
        wait 3.75;
        foreach (player in startorigin.players) {
            player playrumbleonentity(#"infiltration_rumble");
        }
        wait 1;
        function_a5fd9aa8(startorigin);
        foreach (player in startorigin.players) {
            player playrumbleonentity(#"hash_233b436a07cd091a");
        }
        wait 0.2;
        function_a5fd9aa8(startorigin);
        foreach (player in startorigin.players) {
            player playrumbleonentity(#"infiltration_rumble");
        }
        wait 2;
        function_a5fd9aa8(startorigin);
        foreach (player in startorigin.players) {
            if (!isdefined(player)) {
                continue;
            }
            player playrumbleonentity(#"hash_62ba49f452a20378");
        }
        wait 2;
    }
    startorigin callback::callback(#"hash_1634199a59f10727");
    if (getgametypesetting(#"wzplayerinsertiontypeindex") == 3) {
        wait 5;
    }
    for (index = 0; index <= startorigin.var_41091905.size; index++) {
        plane = startorigin.var_41091905[index];
        if (!isdefined(plane)) {
            plane = startorigin.var_41091905[0];
        }
        var_f945990b = plane.origin + (0, 0, 250);
        targetpos = var_f945990b + var_21e6b5ae * level.var_c7f8ccf6 * 17.6 * 4;
        if (isdefined(startorigin.cameraent[index])) {
            startorigin.cameraent[index] moveto(targetpos, 4, 1, 0);
            startorigin.cameraent[index] rotateto((var_872f085f[0] + var_1978c281, var_872f085f[1], var_872f085f[2]), 4, 1, 1);
        }
    }
    wait 4;
    for (index = 0; index <= startorigin.var_41091905.size; index++) {
        var_f3d7d863 = endorigin + rotatepoint((0, 0, 250), var_872f085f);
        timetotarget = distance(var_f3d7d863, targetpos) / level.var_c7f8ccf6 * 17.6;
        if (isdefined(startorigin.cameraent[index])) {
            startorigin.cameraent[index] moveto(var_f3d7d863, timetotarget);
        }
    }
    startorigin flag::wait_till_timeout(0.05, #"insertion_presentation_completed");
    function_a5fd9aa8(startorigin);
    foreach (player in startorigin.players) {
        if (!isdefined(player)) {
            continue;
        }
        player setplayerangles((var_872f085f[0] + var_1978c281, var_872f085f[1], var_872f085f[2]));
    }
    waitframe(2);
    for (index = 0; index <= startorigin.var_41091905.size; index++) {
        startorigin.cameraent[index] clientfield::set("infiltration_plane", function_1e4302d0(1, startorigin.index));
    }
    for (index = 0; index < startorigin.var_41091905.size; index++) {
        startorigin.cameraent[index] clientfield::set("infiltration_camera", function_1e4302d0(2, startorigin.index));
    }
    startorigin thread function_bc824660(startorigin);
    for (index = 0; index <= startorigin.var_41091905.size; index++) {
        var_f3d7d863 = endorigin + rotatepoint((0, 0, 250), var_872f085f);
        timetotarget = distance(var_f3d7d863, targetpos) / (level.var_c7f8ccf6 + 20) * 17.6;
        startorigin.cameraent[index] moveto(var_f3d7d863, timetotarget);
    }
    function_a5fd9aa8(startorigin);
    foreach (player in startorigin.players) {
        if (!isalive(player)) {
            continue;
        }
        player function_7a4c1517();
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x2a8a0b55, Offset: 0x65b8
// Size: 0x134
function function_77132caf() {
    self unlink();
    self setstance("stand");
    self function_4feecc32();
    center = death_circle::function_b980b4ca();
    radius = death_circle::function_f8dae197() * 0.85;
    if (radius == 0) {
        radius = 500;
    }
    spawn_point = rotatepoint((radius, 0, 0), (0, randomint(360), 0));
    self setorigin(center + spawn_point + (0, 0, 30000));
    self start_freefall((0, 0, 0), 0);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x77e330f0, Offset: 0x66f8
// Size: 0x1a
function function_ec7cfdb() {
    if (isdefined(self.var_30fc202f)) {
        return self.var_30fc202f;
    }
    return 0;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x837df0bc, Offset: 0x6720
// Size: 0xb0
function function_c4f5c468(insertion) {
    assert(isstruct(insertion));
    teammask = getteammask(self.team);
    for (teamindex = 0; teammask > 1; teamindex++) {
        teammask >>= 1;
    }
    planeindex = teamindex % insertion.var_41091905.size;
    return insertion.var_41091905[planeindex];
}

// Namespace player_insertion/player_insertion
// Params 3, eflags: 0x1 linked
// Checksum 0x7e6ce081, Offset: 0x67d8
// Size: 0x2cc
function function_f795bf83(insertion, vehicle, yaw) {
    assert(isstruct(insertion));
    if (!isdefined(self) || !isentity(self)) {
        return;
    }
    self endon(#"disconnect");
    if (!isdefined(vehicle)) {
        self function_77132caf();
        return;
    }
    self notify(#"insertion_starting");
    if (!isdefined(insertion.passengercount)) {
        insertion.passengercount = 0;
    }
    insertion.passengercount++;
    self stopanimscripted();
    self unlink();
    self setstance("stand");
    self function_648c1f6(vehicle, undefined, 0, 180, 180, 85, 85);
    self gadget_health_regen::heal_end();
    self.health = self.spawnhealth;
    self cameraactivate(1);
    self setclientthirdperson(1);
    self setplayerangles((0, yaw, 0));
    self dontinterpolate();
    self ghost();
    self notsolid();
    self thread status_effect::function_6519f95f();
    self val::set(#"player_insertion", "disable_oob", 1);
    self clientfield::set_to_player("inside_infiltration_vehicle", 1);
    self clientfield::set_player_uimodel("hudItems.showReinsertionPassengerCount", 0);
    level thread function_2e54d73e(insertion, self, vehicle);
    self thread function_2d683dc2(vehicle);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x5 linked
// Checksum 0x6b8da53e, Offset: 0x6ab0
// Size: 0x66
function private function_e3f18577() {
    height = 0;
    /#
        height = getdvarint(#"hash_37d751a610a5c2fc", 0);
    #/
    if (height == 0) {
        height = level.var_427d6976.("insertionHeightAboveCenter");
    }
    return height;
}

/#

    // Namespace player_insertion/player_insertion
    // Params 3, eflags: 0x4
    // Checksum 0x5fb174d9, Offset: 0x6b20
    // Size: 0x2ca
    function private function_7d880672(original_origin, var_9f8395cb, refly) {
        self notify("<dev string:xbf>");
        self endon("<dev string:xbf>");
        self endon(#"disconnect");
        origin = self.origin;
        origin = (original_origin[0], original_origin[1], function_e3f18577());
        self setorigin(origin);
        self dontinterpolate();
        var_cc56f8da = 0;
        var_cc56f8da = getdvarint(#"hash_380d8ae5bfc8f45b", 1);
        switch (var_cc56f8da) {
        case 0:
        default:
            var_59526dd5 = 0;
            break;
        case 1:
            var_59526dd5 = var_9f8395cb;
            break;
        case 2:
            var_59526dd5 = randomint(360);
            break;
        }
        var_872f085f = (0, var_59526dd5, 0);
        self setplayerangles(var_872f085f);
        direction = anglestoforward(var_872f085f);
        vectornormalize(direction);
        if (refly > 2) {
            speed = 1000;
            velocity = direction * speed;
            self player_free_fall::function_7705a7fc(2, velocity);
        }
        if (refly % 2 == 0) {
            while (true) {
                waitframe(1);
                if (self isonground() || self.origin[2] < -5000) {
                    while (self isonground() && self.origin[2] > -5000) {
                        waitframe(1);
                    }
                    self thread function_7d880672(original_origin, var_9f8395cb, refly);
                    return;
                }
            }
        }
    }

#/

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xed52daf5, Offset: 0x6df8
// Size: 0x44
function function_aa3a20fb() {
    if (!isdefined(level.warp_portal_vehicles)) {
        self thread function_77132caf();
        return;
    }
    self thread function_f2867466();
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0xf0b7fa63, Offset: 0x6e48
// Size: 0x184
function function_80c60f66(player) {
    insertion = self;
    assert(isstruct(insertion));
    for (index = 0; index < level.insertions.size; index++) {
        var_18310f7e = level.insertions[index];
        if (insertion == var_18310f7e) {
            var_18310f7e.players[var_18310f7e.players.size] = player;
            continue;
        }
        var_18310f7e.otherplayers[var_18310f7e.otherplayers.size] = player;
        player function_c62b5591(var_18310f7e);
    }
    player function_abd3bc1a();
    plane = player function_c4f5c468(insertion);
    player function_f795bf83(insertion, plane, insertion.leadplane.angles[1]);
    player function_c62b5591(insertion);
    player show_postfx();
}

/#

    // Namespace player_insertion/player_insertion
    // Params 0, eflags: 0x0
    // Checksum 0x84ba3966, Offset: 0x6fd8
    // Size: 0x102
    function function_88c53de8() {
        refly = getdvarint(#"hash_1632f4021ab7a921", 0);
        if (refly) {
            players = getplayers();
            foreach (player in players) {
                player thread function_7d880672(player.origin, player.angles[1], refly);
            }
            return 1;
        }
        return 0;
    }

#/

// Namespace player_insertion/player_insertion
// Params 3, eflags: 0x5 linked
// Checksum 0x2d11e2fa, Offset: 0x70e8
// Size: 0x8e8
function private function_e59d879f(insertion, s_formation, var_cf46aa72) {
    assert(isstruct(insertion));
    /#
        if (function_88c53de8()) {
            return;
        }
    #/
    function_948ac812(insertion);
    bot_insertion::function_24ca8ecf(insertion);
    vehiclespawns = [#"vehicle_t9_mil_air_transport_hpc_intro":"vehicle_t9_mil_air_transport_hpc_intro", #"vehicle_t8_mil_helicopter_transport_dark_wz_infiltration":"vehicle_t8_mil_helicopter_transport_dark_wz_infiltration", #"vehicle_t8_mil_helicopter_gunship_wz_infiltration":"vehicle_t8_mil_helicopter_gunship_wz_infiltration", #"vehicle_t8_mil_helicopter_light_transport_wz_infil":"vehicle_t8_mil_helicopter_light_transport_wz_infil"];
    if (vehiclespawns.size == 0) {
        return 0;
    }
    spawner::global_spawn_throttle(1);
    if (true) {
        var_69f4f44c = "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration";
    } else {
        var_69f4f44c = "vehicle_t9_mil_air_transport_hpc_intro";
    }
    startpoint = insertion.start_point;
    endpoint = insertion.end_point;
    var_872f085f = insertion.var_f253731f;
    var_37362e08 = insertion.var_37362e08;
    var_7743b329 = insertion.var_7743b329;
    insertion.leadplane = spawnvehicle(var_69f4f44c, startpoint, var_872f085f, "insertion_plane");
    insertion.leadplane.takedamage = 0;
    insertion.passengercount = 0;
    insertion.var_ef5094f9 = undefined;
    insertion.var_dfaba736 = [];
    insertion.var_27d17f06 = [];
    insertion.var_41091905 = [];
    if (!isdefined(insertion.var_41091905)) {
        insertion.var_41091905 = [];
    } else if (!isarray(insertion.var_41091905)) {
        insertion.var_41091905 = array(insertion.var_41091905);
    }
    insertion.var_41091905[insertion.var_41091905.size] = insertion.leadplane;
    if (true) {
        insertion.var_dfaba736 = [];
        insertion thread function_45b56b0a(insertion, startpoint, endpoint, var_872f085f, vehiclespawns);
        if (var_cf46aa72) {
            insertion thread function_f87ddcf0(insertion, startpoint, endpoint, var_872f085f, vehiclespawns);
        }
        for (i = 0; i < s_formation.var_c85ebc15; i++) {
            spawner::global_spawn_throttle(1);
            rotatedstart = startpoint + rotatepoint(s_formation.var_86cb4eb8[i], var_872f085f);
            var_4875d958 = vehiclespawns[s_formation.var_f5cff63[i]];
            vehicle = spawnvehicle(var_4875d958, rotatedstart, var_872f085f, "insertion_secondary");
            if (isdefined(vehicle)) {
                vehicle notsolid();
                vehicle.takedamage = 0;
                vehicle.startorigin = rotatedstart;
                if (!isdefined(insertion.var_dfaba736)) {
                    insertion.var_dfaba736 = [];
                } else if (!isarray(insertion.var_dfaba736)) {
                    insertion.var_dfaba736 = array(insertion.var_dfaba736);
                }
                insertion.var_dfaba736[insertion.var_dfaba736.size] = vehicle;
                if (s_formation.var_f5cff63[i] == "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration") {
                    if (!isdefined(insertion.var_41091905)) {
                        insertion.var_41091905 = [];
                    } else if (!isarray(insertion.var_41091905)) {
                        insertion.var_41091905 = array(insertion.var_41091905);
                    }
                    insertion.var_41091905[insertion.var_41091905.size] = vehicle;
                }
                if (i == s_formation.var_84f704f) {
                    insertion.var_ef5094f9 = vehicle;
                    vehicle.forwardoffset = s_formation.var_86cb4eb8[i][0];
                }
            }
        }
        if (!isdefined(insertion.var_ef5094f9)) {
            insertion.var_ef5094f9 = insertion.leadplane;
            insertion.var_ef5094f9.startorigin = startpoint;
            insertion.var_ef5094f9.endorigin = endpoint;
            insertion.var_ef5094f9.forwardoffset = 0;
        }
        for (i = 0; i < s_formation.var_c85ebc15; i++) {
            if (!isdefined(insertion.var_dfaba736[i])) {
                continue;
            }
            rotatedend = endpoint + rotatepoint(s_formation.var_86cb4eb8[i], var_872f085f);
            insertion.var_dfaba736[i].endorigin = rotatedend;
            insertion.var_dfaba736[i] setneargoalnotifydist(512);
            insertion.var_dfaba736[i] thread function_ea6a4f96(insertion.var_dfaba736[i].startorigin, rotatedend, var_872f085f, s_formation.hoverparams[i], s_formation.var_86255b48[i]);
        }
    } else {
        insertion.var_ef5094f9 = insertion.leadplane;
        insertion.var_ef5094f9.startorigin = startpoint;
        insertion.var_ef5094f9.endorigin = endpoint;
        insertion.var_ef5094f9.forwardoffset = 0;
    }
    insertion.leadplane setneargoalnotifydist(512);
    var_913594d7 = (0, 16, 16);
    insertion.leadplane thread function_ea6a4f96(startpoint, endpoint, var_872f085f, var_913594d7, 2);
    callback::on_spawned(&function_80c60f66, insertion);
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (isalive(player)) {
            plane = player function_c4f5c468(insertion);
            player function_f795bf83(insertion, plane, var_872f085f[1]);
        }
    }
    insertion thread function_afdad0c8(insertion, insertion.leadplane, startpoint, endpoint, var_7743b329);
    insertion thread function_6da3daa0(insertion, insertion.var_ef5094f9, insertion.var_ef5094f9.startorigin, insertion.var_ef5094f9.endorigin, var_37362e08 + insertion.var_ef5094f9.forwardoffset);
    insertion thread function_ca5b6591(insertion, startpoint, endpoint, var_872f085f);
    return 1;
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x5 linked
// Checksum 0x74f1a977, Offset: 0x79d8
// Size: 0x4a8
function private function_7341cc88(insertion, *var_cf46aa72) {
    assert(isstruct(var_cf46aa72));
    /#
        if (function_88c53de8()) {
            return;
        }
    #/
    function_948ac812(var_cf46aa72);
    bot_insertion::function_24ca8ecf(var_cf46aa72);
    vehiclespawns = ["vehicle_t9_mil_air_transport_hpc_intro"];
    if (vehiclespawns.size == 0) {
        return 0;
    }
    spawner::global_spawn_throttle(1);
    var_69f4f44c = "vehicle_t9_mil_air_transport_hpc_intro";
    startpoint = var_cf46aa72.start_point;
    endpoint = var_cf46aa72.end_point;
    var_872f085f = var_cf46aa72.var_f253731f;
    var_37362e08 = var_cf46aa72.var_37362e08;
    var_7743b329 = var_cf46aa72.var_7743b329;
    var_cf46aa72.leadplane = spawnvehicle(var_69f4f44c, startpoint, var_872f085f, "insertion_plane");
    var_cf46aa72.leadplane.takedamage = 0;
    var_cf46aa72.passengercount = 0;
    var_cf46aa72.var_ef5094f9 = undefined;
    var_cf46aa72.var_dfaba736 = [];
    var_cf46aa72.var_27d17f06 = [];
    var_cf46aa72.var_41091905 = [];
    if (!isdefined(var_cf46aa72.var_41091905)) {
        var_cf46aa72.var_41091905 = [];
    } else if (!isarray(var_cf46aa72.var_41091905)) {
        var_cf46aa72.var_41091905 = array(var_cf46aa72.var_41091905);
    }
    var_cf46aa72.var_41091905[var_cf46aa72.var_41091905.size] = var_cf46aa72.leadplane;
    level thread function_663e35b8();
    var_cf46aa72.var_ef5094f9 = var_cf46aa72.leadplane;
    var_cf46aa72.var_ef5094f9.startorigin = startpoint;
    var_cf46aa72.var_ef5094f9.endorigin = endpoint;
    var_cf46aa72.var_ef5094f9.forwardoffset = 0;
    var_cf46aa72.leadplane setneargoalnotifydist(512);
    var_913594d7 = (0, 16, 16);
    var_cf46aa72.leadplane thread function_ea6a4f96(startpoint, endpoint, var_872f085f, var_913594d7, 2);
    callback::on_spawned(&function_80c60f66, var_cf46aa72);
    function_a5fd9aa8(var_cf46aa72);
    foreach (player in var_cf46aa72.players) {
        if (isalive(player)) {
            plane = player function_c4f5c468(var_cf46aa72);
            player function_f795bf83(var_cf46aa72, plane, var_872f085f[1]);
        }
    }
    var_cf46aa72 thread function_afdad0c8(var_cf46aa72, var_cf46aa72.leadplane, startpoint, endpoint, var_7743b329);
    var_cf46aa72 thread function_6da3daa0(var_cf46aa72, var_cf46aa72.var_ef5094f9, var_cf46aa72.var_ef5094f9.startorigin, var_cf46aa72.var_ef5094f9.endorigin, var_37362e08 + var_cf46aa72.var_ef5094f9.forwardoffset);
    var_cf46aa72 thread function_ca5b6591(var_cf46aa72, startpoint, endpoint, var_872f085f);
    return 1;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xa18e697e, Offset: 0x7e88
// Size: 0x20
function function_663e35b8() {
    wait 4;
    level notify(#"formation_start");
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x1 linked
// Checksum 0xc6916a00, Offset: 0x7eb0
// Size: 0x1ac
function function_e04b0ea8(insertion, start_point, var_872f085f, var_37362e08, var_f69b665b) {
    assert(isstruct(insertion));
    direction = anglestoforward(var_872f085f);
    insertion.var_b686c9d = spawn("script_model", start_point + direction * var_37362e08);
    insertion.var_b686c9d.targetname = "insertion_jump";
    insertion.var_b686c9d.angles = var_872f085f;
    insertion.var_d908905e = spawn("script_model", start_point + direction * var_f69b665b);
    insertion.var_d908905e.targetname = "insertion_force";
    insertion.var_d908905e.angles = var_872f085f;
    waitframe(1);
    insertion.var_b686c9d clientfield::set("infiltration_jump_point", function_1e4302d0(1, insertion.index));
    insertion.var_d908905e clientfield::set("infiltration_force_drop_point", function_1e4302d0(1, insertion.index));
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xa9e08ac5, Offset: 0x8068
// Size: 0x8c
function function_43cc81fc() {
    s_formation = {#var_c85ebc15:0, #var_f5cff63:[], #var_86cb4eb8:[], #hoverparams:[], #var_86255b48:[], #var_84f704f:0, #alignment:"center"};
    return s_formation;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x80154266, Offset: 0x8100
// Size: 0xa76
function function_d9dfa25() {
    a_formations = [];
    s_formation = {#var_c85ebc15:5, #var_f5cff63:array("vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration"), #var_86cb4eb8:array((2750, -550, 0), (2000, -1200, 0), (1500, 750, 0), (500, 1500, 0), (-900, -700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_86255b48:array(2, 2, 2, 2, 2), #var_84f704f:4, #alignment:"left"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    s_formation = {#var_c85ebc15:5, #var_f5cff63:array("vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration"), #var_86cb4eb8:array((2750, 550, 0), (2000, 1200, 0), (1500, -750, 0), (500, -1500, 0), (-900, 700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_86255b48:array(2, 2, 2, 2, 2), #var_84f704f:4, #alignment:"right"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    s_formation = {#var_c85ebc15:5, #var_f5cff63:array("vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration"), #var_86cb4eb8:array((2750, -900, 0), (2000, 100, 0), (1250, 1100, 0), (500, 2100, 0), (-900, -700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_86255b48:array(2, 2, 2, 2, 2), #var_84f704f:4, #alignment:"left"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    s_formation = {#var_c85ebc15:5, #var_f5cff63:array("vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration"), #var_86cb4eb8:array((2750, 900, 0), (2000, -100, 0), (1500, -1100, 0), (500, -2100, 0), (-900, 700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_86255b48:array(2, 2, 2, 2, 2), #var_84f704f:4, #alignment:"right"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    /#
        index = getdvarint(#"hash_5293cadde39a7ceb", -1);
        if (index > -1) {
            if (isdefined(a_formations[index])) {
                return a_formations[index];
            }
        }
    #/
    var_86cb4eb8[#"left"] = array((1200, -2300, 0), (-200, -2300, 0), (-1600, -2300, 0), (-3000, -2300, 0));
    var_86cb4eb8[#"right"] = array((1200, 2300, 0), (-200, 2300, 0), (-1600, 2300, 0), (-3000, 2300, 0));
    var_5637e595 = {#var_c85ebc15:4, #var_f5cff63:array("vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration"), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192)), #var_86255b48:array(2, 2, 2, 2)};
    s_formation = array::random(a_formations);
    s_formation.var_c85ebc15 += var_5637e595.var_c85ebc15;
    s_formation.var_f5cff63 = arraycombine(s_formation.var_f5cff63, var_5637e595.var_f5cff63, 1, 0);
    s_formation.var_86cb4eb8 = arraycombine(s_formation.var_86cb4eb8, var_86cb4eb8[s_formation.alignment], 1, 0);
    s_formation.hoverparams = arraycombine(s_formation.hoverparams, var_5637e595.hoverparams, 1, 0);
    s_formation.var_86255b48 = arraycombine(s_formation.var_86255b48, var_5637e595.var_86255b48, 1, 0);
    return s_formation;
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x1 linked
// Checksum 0x36a4e0e5, Offset: 0x8b80
// Size: 0x206
function function_45b56b0a(insertion, startpoint, endpoint, var_872f085f, vehiclespawns) {
    offset = (500, -50, 600);
    goaloffset = (0, 0, -400);
    rotatedstart = startpoint + rotatepoint(offset, var_872f085f);
    var_31e5487a = vehiclespawns[#"vehicle_t8_mil_helicopter_light_transport_wz_infil"];
    insertion.var_933bdcf2 = spawnvehicle(var_31e5487a, rotatedstart, var_872f085f, "insertion_presentation");
    if (!isdefined(insertion.var_933bdcf2)) {
        assert(0);
        return;
    }
    insertion.var_933bdcf2.startorigin = rotatedstart;
    rotatedend = endpoint + rotatepoint(goaloffset, var_872f085f);
    insertion.var_933bdcf2.endorigin = rotatedend;
    wait 0.5;
    insertion.var_933bdcf2 setrotorspeed(1);
    insertion.var_933bdcf2 setspeedimmediate(level.var_c7f8ccf6 + 20);
    insertion.var_933bdcf2 setneargoalnotifydist(512);
    insertion.var_933bdcf2 vehlookat(rotatedend);
    insertion.var_933bdcf2 function_a57c34b7(rotatedend, 0, 0);
    insertion.var_933bdcf2.takedamage = 0;
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x1 linked
// Checksum 0xfc51e0c2, Offset: 0x8d90
// Size: 0x33c
function function_f87ddcf0(insertion, startpoint, endpoint, var_872f085f, vehiclespawns) {
    offset = array((500, -100, 800), (500, 100, 800));
    goaloffset = array((0, 60000, -10000), (0, -60000, -10000));
    var_5b967418 = array("vehicle_t8_mil_helicopter_light_transport_wz_infil", "vehicle_t8_mil_helicopter_light_transport_wz_infil");
    insertion.var_27d17f06 = [];
    for (i = 0; i < 2; i++) {
        waitframe(1);
        rotatedstart = startpoint + rotatepoint(offset[i], var_872f085f);
        var_31e5487a = vehiclespawns[var_5b967418[i]];
        vehicle = spawnvehicle(var_31e5487a, rotatedstart, var_872f085f, "insertion_presentation");
        vehicle.origin = rotatedstart;
        vehicle.angles = var_872f085f;
        vehicle.startorigin = rotatedstart;
        if (!isdefined(insertion.var_27d17f06)) {
            insertion.var_27d17f06 = [];
        } else if (!isarray(insertion.var_27d17f06)) {
            insertion.var_27d17f06 = array(insertion.var_27d17f06);
        }
        insertion.var_27d17f06[insertion.var_27d17f06.size] = vehicle;
        waitframe(1);
    }
    for (i = 0; i < 2; i++) {
        rotatedend = endpoint + rotatepoint(goaloffset[i], var_872f085f);
        insertion.var_27d17f06[i].endorigin = rotatedend;
        insertion.var_27d17f06[i] setrotorspeed(1);
        insertion.var_27d17f06[i] setspeedimmediate(2);
        insertion.var_27d17f06[i] setneargoalnotifydist(512);
        insertion.var_27d17f06[i].takedamage = 0;
        insertion.var_27d17f06[i] thread function_700e474f(insertion.var_27d17f06[i].startorigin, rotatedend, var_872f085f, goaloffset[i][1], i);
    }
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x1 linked
// Checksum 0xefaea50d, Offset: 0x90d8
// Size: 0x34c
function function_700e474f(startorigin, endorigin, var_872f085f, goal, index) {
    self endon(#"death");
    dist = distance2d(endorigin, startorigin) / 3;
    offset = (dist / 2, math::sign(goal) * 1000, -1000);
    var_e8ab2c6b = startorigin + rotatepoint(offset, var_872f085f);
    offset = (dist / 2, math::sign(goal) * 1000, -1000);
    var_9fa20618 = var_e8ab2c6b + rotatepoint(offset, var_872f085f);
    /#
        if (getdvarint(#"hash_5bbd3d044e1ec1b8", 0)) {
            self thread function_84898b3f(var_e8ab2c6b, var_9fa20618, endorigin, index);
        }
    #/
    wait 0.25;
    self setrotorspeed(1);
    self setspeedimmediate(2);
    self vehlookat(var_e8ab2c6b);
    self function_a57c34b7(var_e8ab2c6b, 0, 0);
    if (index > 0) {
        wait 0.75;
    }
    self setspeedimmediate(level.var_c7f8ccf6 - 30);
    self thread function_71da60d1();
    self waittill(#"goal", #"near_goal");
    self vehlookat(var_9fa20618);
    self function_a57c34b7(var_9fa20618, 0, 0);
    self waittill(#"goal", #"near_goal");
    self vehlookat(endorigin);
    self function_a57c34b7(endorigin, 0, 0);
    self setspeed(level.var_c7f8ccf6 + level.var_c7f8ccf6 * 0.66667);
    self waittill(#"goal", #"near_goal");
    self deletedelay();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xb5bf5cfd, Offset: 0x9430
// Size: 0x3c
function function_71da60d1() {
    wait 4;
    level notify(#"formation_start");
    self setspeed(level.var_c7f8ccf6);
}

/#

    // Namespace player_insertion/player_insertion
    // Params 4, eflags: 0x0
    // Checksum 0x35b2450a, Offset: 0x9478
    // Size: 0x116
    function function_84898b3f(var_e8ab2c6b, var_9fa20618, endorigin, index) {
        self endon(#"death");
        while (getdvarint(#"hash_5bbd3d044e1ec1b8", 0)) {
            color = index < 0 ? (0, 0, 1) : (1, 0, 0);
            sphere(var_e8ab2c6b, 700, color);
            sphere(var_9fa20618, 700, color);
            sphere(endorigin, 700, color);
            line(var_e8ab2c6b, var_9fa20618, color);
            line(var_9fa20618, endorigin, color);
            waitframe(1);
        }
    }

#/

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x1 linked
// Checksum 0xe9c220ad, Offset: 0x9598
// Size: 0x234
function function_ea6a4f96(startorigin, endorigin, var_872f085f, offsetvec, var_35c96bb3) {
    self endon(#"death");
    self setspeedimmediate(5);
    self setrotorspeed(1);
    self function_a57c34b7(endorigin, 0, 0);
    level waittill(#"formation_start");
    self setspeedimmediate(level.var_c7f8ccf6);
    if (true) {
        direction = anglestoforward(var_872f085f);
        distance = distance(endorigin, startorigin);
        var_27dfb385 = int(distance) / 5000;
        remainingdist = int(distance) % 5000;
        for (i = 1; i <= var_27dfb385; i++) {
            self pathvariableoffset(offsetvec * (var_27dfb385 - i + 1), var_35c96bb3);
            self function_85635daf(startorigin, distance, i * 5000 / distance);
        }
        if (remainingdist > 0) {
            self pathvariableoffset(offsetvec, var_35c96bb3);
        }
    }
    self waittill(#"goal", #"near_goal");
    self deletedelay();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x7334f37, Offset: 0x97d8
// Size: 0x68
function function_15945f95() {
    var_6024133d = getentarray("map_corner", "targetname");
    if (var_6024133d.size) {
        return math::find_box_center(var_6024133d[0].origin, var_6024133d[1].origin);
    }
    return (0, 0, 0);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x8904ca10, Offset: 0x9848
// Size: 0x118
function function_ab6af198() {
    var_6024133d = getentarray("map_corner", "targetname");
    if (var_6024133d.size) {
        x = abs(var_6024133d[0].origin[0] - var_6024133d[1].origin[0]);
        y = abs(var_6024133d[0].origin[1] - var_6024133d[1].origin[1]);
        max_width = max(x, y);
        max_width *= 0.75;
        return math::clamp(max_width, 10000, max_width);
    }
    return 10000;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xa5460d8b, Offset: 0x9968
// Size: 0x438
function function_6671872c() {
    height = level.mapcenter[2] + function_e3f18577();
    if (is_true(getgametypesetting(#"wzintersectdeathcircle"))) {
        circleindex = isdefined(getgametypesetting(#"wzintersectdeathcircleindex")) ? getgametypesetting(#"wzintersectdeathcircleindex") : 0;
        if (isdefined(level.deathcircles) && level.deathcircles.size > 0 && circleindex < level.deathcircles.size) {
            center = level.deathcircles[circleindex].origin;
            return (center[0], center[1], height);
        }
    }
    if (isdefined(level.var_cd008cab)) {
        var_7ed8b321 = [[ level.var_cd008cab ]]();
        if (isdefined(var_7ed8b321)) {
            return (var_7ed8b321[0], var_7ed8b321[1], height);
        }
    }
    assert(isdefined(level.var_6d222488));
    assert(isdefined(level.var_7ac790f2));
    map_center = level.mapcenter;
    map_center = (map_center[0], map_center[1], height);
    x = abs(level.var_7ac790f2[0] - level.var_6d222488[0]) * 0.5;
    y = abs(level.var_7ac790f2[1] - level.var_6d222488[1]) * 0.5;
    if (is_true(getgametypesetting(#"hash_2b05db5822050708"))) {
        return map_center;
    }
    ratio_max = math::clamp(level.var_427d6976.("insertionFlyoverBoundsOuterRatio"), 0, 1);
    var_40f8484d = math::clamp(level.var_427d6976.("insertionFlyoverBoundsInnerRatio"), 0, ratio_max);
    var_5017ad06 = (x * (ratio_max - var_40f8484d), y * (ratio_max - var_40f8484d), 0);
    random_point = (randomfloatrange(var_5017ad06[0] * -1, var_5017ad06[0]), randomfloatrange(var_5017ad06[1] * -1, var_5017ad06[1]), 0);
    if (var_40f8484d > 0) {
        random_point = (random_point[0] + math::sign(random_point[0]) * x * var_40f8484d, random_point[1] + math::sign(random_point[1]) * y * var_40f8484d, 0);
    }
    fly_over_point = map_center + random_point;
    fly_over_point = (fly_over_point[0], fly_over_point[1], height);
    return fly_over_point;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x9cefa09a, Offset: 0x9da8
// Size: 0x1d2
function function_45644b08() {
    if (is_true(getgametypesetting(#"wzintersectdeathcircle"))) {
        circleindex = isdefined(getgametypesetting(#"wzintersectdeathcircleindex")) ? getgametypesetting(#"wzintersectdeathcircleindex") : 0;
        if (isdefined(level.deathcircles) && level.deathcircles.size > 0 && circleindex < level.deathcircles.size) {
            center = level.deathcircles[circleindex].origin;
            if (circleindex > 0) {
                var_6bf489f1 = level.deathcircles[0].origin;
                var_1ce870a0 = vectornormalize(center - var_6bf489f1);
                var_6e3e0ad7 = vectortoangles(var_1ce870a0);
                if (math::cointoss()) {
                    return var_6e3e0ad7[1];
                }
                return (var_6e3e0ad7[1] - 180);
            }
        }
    }
    if (isdefined(level.var_fd30a287)) {
        var_684dfce3 = [[ level.var_fd30a287 ]]();
        if (isdefined(var_684dfce3)) {
            return var_684dfce3;
        }
    }
    return randomint(360);
}

/#

    // Namespace player_insertion/player_insertion
    // Params 0, eflags: 0x4
    // Checksum 0xe00e0c27, Offset: 0x9f88
    // Size: 0xd8
    function private function_63793dbe() {
        time = getdvarfloat(#"hash_102dc944a54c88d9", 0);
        if (time) {
            wait time;
            foreach (player in function_a1ef346b()) {
                player flag::set(#"hash_224cb97b8f682317");
            }
        }
    }

#/

// Namespace player_insertion/player_insertion
// Params 3, eflags: 0x1 linked
// Checksum 0x3dbda7e6, Offset: 0xa068
// Size: 0x74
function function_85635daf(startpoint, total_distance, delta_t) {
    while (true) {
        current_distance = distance(startpoint, self.origin);
        current_t = current_distance / total_distance;
        if (current_t > delta_t) {
            return;
        }
        waitframe(1);
    }
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x5 linked
// Checksum 0x7d1fa352, Offset: 0xa0e8
// Size: 0x63c
function private function_afdad0c8(insertion, plane, startpoint, endpoint, var_671fc488) {
    assert(isstruct(insertion));
    self notify("df60f3e2fd1642b");
    self endon("df60f3e2fd1642b");
    plane endon(#"death");
    foreach (vehicle in insertion.var_41091905) {
        vehicle clientfield::set("infiltration_landing_gear", 1);
        vehicle setrotorspeed(1);
    }
    var_5d59bc67 = 17.6 * level.var_c7f8ccf6;
    var_5e24c814 = 5 * var_5d59bc67;
    total_distance = distance(startpoint, endpoint);
    assert(total_distance > var_671fc488);
    assert(var_671fc488 - var_5e24c814 > 0);
    assert(total_distance > var_671fc488 - var_5e24c814);
    var_f26cf241 = (var_671fc488 - var_5e24c814) / total_distance;
    end_t = var_671fc488 / total_distance;
    /#
        level thread function_63793dbe();
    #/
    plane function_85635daf(startpoint, total_distance, var_f26cf241);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (is_true(player.var_97b0977)) {
            continue;
        }
        player clientfield::set_to_player("infiltration_final_warning", 1);
    }
    plane function_85635daf(startpoint, total_distance, end_t);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    level callback::callback(#"hash_774be40ec06d5212");
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        player flag::set(#"hash_224cb97b8f682317");
    }
    function_dd34168c(insertion, #"hash_60fcdd11812a0134");
    wait 1;
    foreach (vehicle in insertion.var_41091905) {
        vehicle clientfield::set("infiltration_transport", 0);
    }
    for (index = 0; index <= insertion.var_41091905.size; index++) {
        if (isdefined(insertion.cameraent[index])) {
            insertion.cameraent[index] delete();
        }
    }
    if (isdefined(insertion.var_b686c9d)) {
        insertion.var_b686c9d delete();
    }
    if (isdefined(insertion.var_d908905e)) {
        insertion.var_d908905e delete();
    }
    if (isdefined(insertion.infilteament)) {
        insertion.infilteament delete();
    }
    wait 5;
    currentvalue = level clientfield::get("infiltration_compass");
    newvalue = ~(1 << insertion.index) & currentvalue;
    level clientfield::set("infiltration_compass", newvalue);
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x5 linked
// Checksum 0xd3678e59, Offset: 0xa730
// Size: 0x2ec
function private function_6da3daa0(insertion, plane, startpoint, endpoint, var_6a694ed8) {
    assert(isstruct(insertion));
    self notify("1a47ff0fe35ef70");
    self endon("1a47ff0fe35ef70");
    plane endon(#"death");
    var_5d59bc67 = 17.6 * level.var_c7f8ccf6;
    var_7cd0d619 = 0.6 * var_5d59bc67;
    total_distance = distance(startpoint, endpoint);
    assert(total_distance > var_6a694ed8);
    assert(var_6a694ed8 - var_7cd0d619 > 0);
    assert(total_distance > var_6a694ed8 - var_7cd0d619);
    cargo_t = (var_6a694ed8 - var_7cd0d619) / total_distance;
    start_t = var_6a694ed8 / total_distance;
    plane function_85635daf(startpoint, total_distance, cargo_t);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    insertion thread function_d11a5f0c(insertion);
    plane function_85635daf(startpoint, total_distance, start_t);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        player flag::set(#"hash_287397edba8966f9");
    }
    wait 2;
    insertion callback::callback(#"hash_20fcd06900f62558");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x77f81650, Offset: 0xaa28
// Size: 0x118
function function_bc16f3b4(insertion) {
    assert(isstruct(insertion));
    self clientfield::set("infiltration_transport", 1);
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (player islinkedto(self)) {
            player clientfield::set_to_player("infiltration_jump_warning", 1);
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x49c3a72e, Offset: 0xab48
// Size: 0x218
function function_d11a5f0c(insertion) {
    assert(isstruct(insertion));
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        player.var_97b0977 = 0;
    }
    foreach (vehicle in insertion.var_41091905) {
        vehicle function_bc16f3b4(insertion);
        wait randomfloatrange(0.5, 1);
    }
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (isdefined(player)) {
            player clientfield::set_to_player("realtime_multiplay", 1);
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x5e50183e, Offset: 0xad68
// Size: 0x178
function function_b80277f7() {
    if (isbot(self)) {
        self bot_insertion::function_a4f516ef();
        return;
    }
    while (true) {
        waitframe(1);
        if (self flag::get(#"hash_287397edba8966f9") && isdefined(level.insertionpassenger) && isdefined(level.var_f3320ad2) && isdefined(level.var_a3c0d635) && isdefined(level.var_ce84dde9) && !level.insertionpassenger [[ level.var_a3c0d635 ]](self)) {
            level.insertionpassenger [[ level.var_f3320ad2 ]](self, 0);
            level.insertionpassenger [[ level.var_ce84dde9 ]](self, level.insertion.passengercount);
        }
        if (self flag::get(#"hash_224cb97b8f682317") || self flag::get(#"hash_287397edba8966f9") && self jumpbuttonpressed()) {
            return;
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0xcb47118f, Offset: 0xaee8
// Size: 0xbc
function function_1c06c249(plane) {
    if (isplayer(self) && isdefined(plane)) {
        self match_record::function_ded5f5b6(#"hash_1657e02fb5073e4a", plane.origin);
        self match_record::set_player_stat(#"hash_16618233fdac5c29", gettime());
        self match_record::set_player_stat(#"hash_63b95d780b2bd355", self flag::get(#"hash_224cb97b8f682317"));
    }
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x1 linked
// Checksum 0xf112a1c3, Offset: 0xafb0
// Size: 0xfc
function function_25facefd(count, *ignore_player) {
    if (isdefined(level.insertionpassenger) && isdefined(level.var_a3c0d635) && isdefined(level.var_ce84dde9)) {
        foreach (player in getplayers()) {
            if (level.insertionpassenger [[ level.var_a3c0d635 ]](player)) {
                level.insertionpassenger [[ level.var_ce84dde9 ]](player, ignore_player);
            }
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 3, eflags: 0x1 linked
// Checksum 0x48a6fd70, Offset: 0xb0b8
// Size: 0xcc
function function_2e54d73e(insertion, passenger, vehicle) {
    assert(isstruct(insertion));
    if (isdefined(vehicle)) {
        vehicle endon(#"death");
    }
    waitresult = passenger waittill(#"disconnect", #"player_jumped");
    if (isdefined(insertion.passengercount)) {
        insertion.passengercount--;
        function_25facefd(insertion.passengercount);
    }
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x5 linked
// Checksum 0xaaaba7a9, Offset: 0xb190
// Size: 0xbc
function private function_ced05c63(note, payload) {
    teammates = getplayers(self.team);
    foreach (player in teammates) {
        if (player == self) {
            continue;
        }
        player notify(note, payload);
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0xb5a51d50, Offset: 0xb258
// Size: 0x264
function function_2d683dc2(aircraft) {
    self notify("509bfcbcc91c9fa4");
    self endon("509bfcbcc91c9fa4");
    self endon(#"death");
    self function_b9a53f50();
    self function_b80277f7();
    self function_ced05c63(#"hash_3a41cbe85bdb81e1", {#player:self});
    self function_1c06c249(aircraft);
    self startcameratween(0.5);
    util::wait_network_frame();
    self cameraactivate(0);
    self setclientthirdperson(0);
    self show();
    self solid();
    self death_circle::function_b57e3cde(0);
    self clientfield::set_to_player("inside_infiltration_vehicle", 0);
    if (isdefined(level.insertionpassenger) && isdefined(level.var_81b39a59)) {
        level.insertionpassenger [[ level.var_81b39a59 ]](self);
    }
    self thread player_freefall(aircraft);
    self hide_postfx();
    self stoprumble(#"hash_233b436a07cd091a");
    self val::reset(#"player_insertion", "show_weapon_hud");
    level callback::callback(#"hash_74b19f5972b0ee52", {#player:self});
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x9f3ed18a, Offset: 0xb4c8
// Size: 0x98
function function_ba904ee2(*velocity) {
    speed = 17.6 * (isdefined(level.var_427d6976.("insertionPlayerFreefallStartSpeed")) ? level.var_427d6976.("insertionPlayerFreefallStartSpeed") : 0);
    var_4626a28f = (10, self.angles[1], 0);
    return anglestoforward(var_4626a28f) * speed;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x3cde17f1, Offset: 0xb568
// Size: 0x1b4
function player_freefall(aircraft) {
    self notify("61c8a1fd5de53356");
    self endon("61c8a1fd5de53356");
    self endon(#"disconnect");
    self notify(#"player_jumped");
    lateraloffset = (0, 0, 0);
    forward = anglestoforward(self.angles);
    origin = self.origin + forward * 512 - (0, 0, 542);
    origin = (origin[0] + randomfloatrange(-300, 300), origin[1] + randomfloatrange(-300, 300), origin[2] + randomfloatrange(-300, 300));
    self unlink();
    self setorigin(origin);
    velocity = function_ba904ee2(aircraft getvelocity());
    self start_freefall(velocity, aircraft.origin[2]);
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x1 linked
// Checksum 0x287c671e, Offset: 0xb728
// Size: 0x16c
function start_freefall(velocity, height) {
    self function_8a945c0e(0);
    self callback::function_d8abfc3d(#"freefall", &function_3b9bcf85);
    self player_free_fall::function_7705a7fc(0, velocity);
    var_a91303da = 2;
    self clientfield::set_player_uimodel("hudItems.skydiveAltimeterVisible", 1);
    self clientfield::set_world_uimodel("hudItems.skydiveAltimeterHeight", int(height));
    self clientfield::set_world_uimodel("hudItems.skydiveAltimeterSeaHeight", 0);
    self.var_97b0977 = 1;
    self hud_message::clearlowermessage();
    self val::set(#"player_insertion", "disable_oob", 0);
    self function_3354a054();
    self thread function_712f9f52();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x2ff6865b, Offset: 0xb8a0
// Size: 0x6e
function function_4630bf0a() {
    if (isplayer(self)) {
        self match_record::function_ded5f5b6(#"hash_7d9d379ecba10793", self.origin);
        self match_record::set_player_stat(#"hash_1469faf3180d8b7a", gettime());
        self.var_37ef8626 = gettime();
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xf118fe17, Offset: 0xb918
// Size: 0xdc
function function_4eb0c560() {
    self val::reset(#"player_insertion", "disablegadgets");
    self val::reset(#"player_insertion", "show_hud");
    self val::reset(#"player_insertion", "show_weapon_hud");
    if (is_true(level.deathcirclerespawn) || isdefined(level.waverespawndelay) && level.waverespawndelay > 0) {
        self clientfield::set_player_uimodel("hudItems.showReinsertionPassengerCount", 1);
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x77c1aad2, Offset: 0xba00
// Size: 0x5c
function function_3b9bcf85(args) {
    if (!is_true(args.freefall) && !is_true(args.var_695a7111)) {
        function_4eb0c560();
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x4ab509c4, Offset: 0xba68
// Size: 0x1c
function function_916470ec(*args) {
    function_4eb0c560();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xd8dccc78, Offset: 0xba90
// Size: 0xfc
function function_4feecc32() {
    self setclientthirdperson(0);
    self show();
    self solid();
    self val::reset(#"player_insertion", "takedamage");
    self val::reset(#"warzonestaging", "takedamage");
    self death_circle::function_b57e3cde(0);
    self val::set(#"player_insertion", "disable_oob", 0);
    self clientfield::set_to_player("realtime_multiplay", 1);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xbcd42d8a, Offset: 0xbb98
// Size: 0xcc
function function_2b276ae0() {
    self endon(#"death");
    wait 1;
    self val::reset(#"player_insertion", "freezecontrols");
    self function_4feecc32();
    callback::function_d8abfc3d(#"parachute", &function_66c91693);
    callback::on_death(&function_916470ec);
    self thread function_7a4c1517();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x8f09bae0, Offset: 0xbc70
// Size: 0xbc
function function_712f9f52() {
    self endon(#"death");
    if (is_true(level.var_7abaaef1)) {
        callback::function_d8abfc3d(#"parachute", &function_66c91693);
    } else {
        callback::function_d8abfc3d(#"skydive_end", &function_f99c2453);
    }
    callback::on_death(&function_916470ec);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x5 linked
// Checksum 0x40865871, Offset: 0xbd38
// Size: 0x5c
function private function_f99c2453(*params) {
    self clientfield::set_player_uimodel("hudItems.skydiveAltimeterVisible", 0);
    self callback::function_52ac9652(#"skydive_end", &function_f99c2453);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x5 linked
// Checksum 0x1b43bfe6, Offset: 0xbda0
// Size: 0x94
function private function_66c91693(eventstruct) {
    if (!eventstruct.parachute) {
        self function_4630bf0a();
        function_916470ec(self);
        self callback::function_52ac9652(#"parachute", &function_66c91693);
        self callback::remove_on_death(&function_916470ec);
    }
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x1 linked
// Checksum 0x4ba948e7, Offset: 0xbe40
// Size: 0x3dc
function function_c71552d0(insertion, fadeouttime, blacktime, fadeintime, rumble) {
    assert(isstruct(insertion));
    if (isdefined(lui::get_luimenu("FullScreenBlack"))) {
        lui_menu = lui::get_luimenu("FullScreenBlack");
    } else {
        insertion flag::set(#"insertion_presentation_completed");
        return;
    }
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (isdefined(player)) {
            if (![[ lui_menu ]]->function_7bfd10e6(player)) {
                [[ lui_menu ]]->open(player);
            }
            [[ lui_menu ]]->set_startalpha(player, 0);
            [[ lui_menu ]]->set_endalpha(player, 1);
            [[ lui_menu ]]->set_fadeovertime(player, int(fadeouttime * 1000));
        }
    }
    wait fadeouttime + blacktime;
    insertion flag::wait_till_timeout(2, #"insertion_teleport_completed");
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (rumble) {
            player playrumbleonentity(#"infiltration_rumble");
        }
        if (![[ lui_menu ]]->function_7bfd10e6(player)) {
            [[ lui_menu ]]->open(player);
        }
        [[ lui_menu ]]->set_startalpha(player, 1);
        [[ lui_menu ]]->set_endalpha(player, 0);
        [[ lui_menu ]]->set_fadeovertime(player, int(fadeintime * 1000));
    }
    wait fadeintime;
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        [[ lui_menu ]]->close(player);
    }
    insertion flag::set(#"insertion_presentation_completed");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0x29cbeb31, Offset: 0xc228
// Size: 0x98
function private function_d7f18e8f(players) {
    foreach (player in players) {
        if (!isbot(player)) {
            return player;
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xb31d7f5c, Offset: 0xc2c8
// Size: 0x86
function function_6660c1f() {
    if (!isdefined(level.insertions)) {
        return false;
    }
    for (index = 0; index < level.insertions.size; index++) {
        insertion = level.insertions[index];
        if (insertion flag::get(#"hash_60fcdd11812a0134")) {
            return false;
        }
    }
    return true;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xf58679bb, Offset: 0xc358
// Size: 0x76
function function_e5d4df1c() {
    for (index = 0; index < level.insertions.size; index++) {
        insertion = level.insertions[index];
        if (insertion flag::get(#"hash_122f326d72f4c884")) {
            return true;
        }
    }
    return false;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x5 linked
// Checksum 0x8fc31a8, Offset: 0xc3d8
// Size: 0xea
function private function_a4deb676() {
    a_start_buttons = getentarray("game_start_button", "script_noteworthy");
    array::delete_all(a_start_buttons);
    if (isdefined(level.var_63460f40)) {
        foreach (object in level.var_63460f40) {
            object gameobjects::destroy_object(1);
        }
        level.var_63460f40 = undefined;
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x9719ab86, Offset: 0xc4d0
// Size: 0x24
function show_postfx() {
    self clientfield::set_to_player("heatblurpostfx", 1);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xcdb2129a, Offset: 0xc500
// Size: 0x24
function hide_postfx() {
    self clientfield::set_to_player("heatblurpostfx", 0);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x72a92beb, Offset: 0xc530
// Size: 0x24
function function_75488834() {
    self clientfield::set_to_player("warpportal_fx_wormhole", 1);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xdaf1fafb, Offset: 0xc560
// Size: 0x24
function function_3a77bd05() {
    self clientfield::set_to_player("warpportal_fx_wormhole", 0);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x38bfa154, Offset: 0xc590
// Size: 0x24
function function_723d686d() {
    self clientfield::increment("warpportalfx_launch");
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xeb6cf983, Offset: 0xc5c0
// Size: 0x24
function function_808b3790() {
    self clientfield::set("warpportalfx", 1);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x48ea5518, Offset: 0xc5f0
// Size: 0x24
function function_8fc2a69e() {
    self clientfield::set("warpportalfx", 0);
}

/#

    // Namespace player_insertion/player_insertion
    // Params 5, eflags: 0x4
    // Checksum 0x15d69b50, Offset: 0xc620
    // Size: 0xf4
    function private debug_sphere(origin, radius, color, alpha, time) {
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        if (!isdefined(time)) {
            time = 5000;
        }
        if (getdvarint(#"scr_insertion_debug", 0) == 1) {
            if (!isdefined(color)) {
                color = (1, 1, 1);
            }
            sides = int(10 * (1 + int(radius / 100)));
            sphere(origin, radius, color, alpha, 1, sides, time);
        }
    }

    // Namespace player_insertion/player_insertion
    // Params 5, eflags: 0x0
    // Checksum 0x65f29eae, Offset: 0xc720
    // Size: 0xc4
    function debug_line(from, to, color, time, depthtest) {
        if (!isdefined(time)) {
            time = 5000;
        }
        if (!isdefined(depthtest)) {
            depthtest = 1;
        }
        if (getdvarint(#"scr_insertion_debug", 0) == 1) {
            if (distancesquared(from, to) < 0.01) {
                return;
            }
            line(from, to, color, 1, depthtest, time);
        }
    }

    // Namespace player_insertion/player_insertion
    // Params 1, eflags: 0x4
    // Checksum 0x299fd75c, Offset: 0xc7f0
    // Size: 0x2a0
    function private function_943c98fb(insertion) {
        assert(isstruct(insertion));
        mapname = util::get_map_name();
        adddebugcommand("<dev string:xd3>" + mapname + "<dev string:xe4>");
        waitframe(1);
        adddebugcommand("<dev string:xd3>" + mapname + "<dev string:x137>");
        waitframe(1);
        adddebugcommand("<dev string:xd3>" + mapname + "<dev string:x186>");
        waitframe(1);
        adddebugcommand("<dev string:xd3>" + mapname + "<dev string:x1df>");
        waitframe(1);
        adddebugcommand("<dev string:xd3>" + mapname + "<dev string:x237>");
        while (true) {
            waitframe(1);
            string = getdvarstring(#"hash_683dafe2da41b42e", "<dev string:x28f>");
            start_insertion = 0;
            switch (string) {
            case #"start_insertion":
                start_insertion = 1;
                break;
            case #"repath_flight":
                insertion on_finalize_initialization();
            default:
                break;
            }
            if (start_insertion) {
                level function_8dcd8623();
            }
            setdvar(#"hash_683dafe2da41b42e", "<dev string:x28f>");
            if (getdvarint(#"hash_5566ccc7de522a4a", 0)) {
                setdvar(#"hash_5566ccc7de522a4a", 0);
                level thread function_4910c182(insertion);
            }
        }
    }

    // Namespace player_insertion/player_insertion
    // Params 1, eflags: 0x0
    // Checksum 0xdb0af2bc, Offset: 0xca98
    // Size: 0x304
    function function_4910c182(insertion) {
        assert(isdefined(insertion));
        insertion flag::clear(#"hash_60fcdd11812a0134");
        insertion flag::clear(#"hash_122f326d72f4c884");
        function_ff107056();
        insertion.players = function_a1ef346b();
        level function_948ac812(insertion);
        level thread function_c71552d0(insertion, 2, 2, 5, 1);
        wait 2 + 0.1;
        level thread globallogic_audio::function_85818e24("<dev string:x293>");
        level thread function_a4deb676();
        insertion flag::set(#"hash_122f326d72f4c884");
        insertion flag::set(#"hash_60fcdd11812a0134");
        insertion flag::set(#"insertion_teleport_completed");
        foreach (player in insertion.players) {
            player function_a25e421c();
        }
        level flag::wait_till_timeout(0.5, #"insertion_presentation_completed");
        function_26fbfab4();
        var_990e3011 = 3;
        /#
            if (getdvarint(#"hash_96d977cb1cf39f8", 0) != 0) {
                var_990e3011 = getdvarint(#"hash_96d977cb1cf39f8", 2);
            }
        #/
        wait var_990e3011;
        players = getplayers();
        players[0] function_adc8cff4();
    }

#/

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x95f2d369, Offset: 0xcda8
// Size: 0x3f4
function function_bc144896() {
    var_f91e1d86 = 256;
    var_15e03744 = 0;
    var_eb0cb2e8 = 1;
    var_ceb87008 = 0.5;
    var_ec878a03 = 0;
    var_345d6bc2 = 0;
    var_56e391f5 = 5000;
    var_387d8ced = 10;
    var_84d65252 = 2;
    var_82a96275 = 10000;
    var_9fc10c55 = 7500;
    var_708b2fe0 = -2;
    function_5ac4dc99("scr_parachute_redeploy_min_height", var_f91e1d86);
    function_5ac4dc99("scr_parachute_redeploy_input_type", var_15e03744);
    function_5ac4dc99("scr_parachute_auto_kick_map_center", (0, 0, 0));
    function_5ac4dc99("scr_parachute_camera_transition_mode", 2);
    function_5ac4dc99("scr_parachute_FFSM_enabled", 1);
    function_5ac4dc99("scr_parachute_hint_enabled", var_eb0cb2e8);
    function_5ac4dc99("scr_parachute_hint_zdrop", var_ceb87008);
    function_5ac4dc99("scr_parachute_hint_zoffset", var_ec878a03);
    function_5ac4dc99("scr_parachute_hint_zvelscale", var_345d6bc2);
    function_5ac4dc99("scr_parachute_hint_zlimit", var_56e391f5);
    function_5ac4dc99("scr_parachute_hint_xyvelscale_high", var_387d8ced);
    function_5ac4dc99("scr_parachute_hint_xyvelscale_low", var_84d65252);
    function_5ac4dc99("scr_parachute_hint_xyvelscale_maxheight", var_82a96275);
    function_5ac4dc99("scr_parachute_hint_xylimit", var_9fc10c55);
    function_5ac4dc99("scr_parachute_hint_falling_xyratio", var_708b2fe0);
    level.parachutecancutautodeploy = getdvarint(#"hash_66102f189c07f6f", 1);
    level.parachutecancutparachute = getdvarint(#"hash_432959289606da80", 1);
    level.parachuteinitfinished = 1;
    level.activeparachuters = [];
    if (!isdefined(level.dontshootwhileparachuting)) {
        level.dontshootwhileparachuting = 1;
    }
    if (!isdefined(level.freefallstartcb)) {
        level.freefallstartcb = &function_435d1356;
    }
    if (!isdefined(level.parachuteopencb)) {
        level.parachuteopencb = &function_2f112556;
    }
    if (!isdefined(level.parachutecompletecb)) {
        level.parachutecompletecb = &function_a4f5dbf9;
    }
    if (!isdefined(level.parachutetakeweaponscb)) {
        level.parachutetakeweaponscb = &function_e5b1d4c7;
    }
    if (!isdefined(level.parachuterestoreweaponscb)) {
        level.parachuterestoreweaponscb = &function_750cef68;
    }
    if (!isdefined(level.parachuteprelaststandfunc)) {
        level.parachuteprelaststandfunc = &function_9e7ff546;
    }
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x0
// Checksum 0x6f79aa6, Offset: 0xd1a8
// Size: 0x3aa
function function_d0031669(falltime, var_1e13fbc6, var_921a1f7e, var_dc39d0fc, var_21da2e39) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"freefallfromplanestatemachine");
    self endon(#"freefallfromplanestatemachine");
    player = self;
    player.ffsm_state = 1;
    player.ffsm_nextstreamhinttime = 0;
    player ffsm_introsetup(falltime, var_1e13fbc6, var_921a1f7e, var_dc39d0fc, var_21da2e39);
    player ffsm_skydive_stateenter();
    var_d5dd0ca5 = 2000;
    starttime = gettime();
    while (true) {
        if (player isskydiving() || starttime + var_d5dd0ca5 < gettime() || player function_b9370594()) {
            break;
        }
        waitframe(1);
    }
    while (true) {
        if (player isinfreefall() && player.ffsm_state != 1) {
            player ffsm_skydive_stateenter();
            player.ffsm_state = 1;
        }
        if (player isparachuting() && player.ffsm_state != 2) {
            player ffsm_parachuteopen_stateenter();
            player.ffsm_state = 2;
        }
        if (!player isskydiving() && player.ffsm_state != 3 && player.ffsm_state != 4 && player.ffsm_state != 6 || player.ffsm_state == 5) {
            player ffsm_landed_stateenter();
            if (player.ffsm_state != 5) {
                player.ffsm_state = 3;
            } else {
                assert(player.ffsm_state == 5);
                player.ffsm_state = 6;
            }
        }
        var_a58af056 = is_true(player.inlaststand);
        var_de16a625 = player isonground() && (player.ffsm_state == 3 || player function_b9370594());
        var_91d1c5fd = !isalive(player);
        if (var_a58af056 || var_de16a625 || var_91d1c5fd) {
            player ffsm_onground_stateenter();
            player.ffsm_state = undefined;
            player.ffsm_isgulagrespawn = undefined;
            player.ffsm_nextstreamhinttime = undefined;
            return;
        }
        waitframe(1);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xf4a6e1ed, Offset: 0xd560
// Size: 0x30
function function_b9370594() {
    return isdefined(self.ffsm_state) && (self.ffsm_state == 5 || self.ffsm_state == 6);
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x1 linked
// Checksum 0x6eb2c956, Offset: 0xd598
// Size: 0x1d8
function ffsm_introsetup(falltime, var_1e13fbc6, *var_921a1f7e, var_dc39d0fc, var_21da2e39) {
    /#
        if (getdvarint(#"hash_517fa3f3ae2f8e77", 0) == 1) {
            self thread function_c3c0b24b();
        }
    #/
    self function_8cf53a19();
    if (!is_true(level.parachuteinitfinished)) {
        function_bc144896();
    }
    var_e5fc45d3 = 4;
    if (!isdefined(var_1e13fbc6)) {
        var_1e13fbc6 = var_e5fc45d3;
    }
    if (!isdefined(var_21da2e39)) {
        var_21da2e39 = 1;
    }
    self [[ level.freefallstartcb ]]();
    if (isdefined(var_dc39d0fc)) {
        self setvelocity(var_dc39d0fc);
    }
    self function_b02c52b();
    if (getdvarint(#"scr_parachute_camera_transition_mode", 1) != 2) {
        self function_41170420(1);
    }
    if (is_true(var_921a1f7e)) {
        self thread player_free_fall::function_2979b1be(0);
    } else {
        self thread player_free_fall::function_2979b1be(var_1e13fbc6);
    }
    self [[ level.parachuterestoreweaponscb ]]();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0xd778
// Size: 0x4
function ffsm_skydive_stateenter() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x11871196, Offset: 0xd788
// Size: 0x48
function ffsm_parachuteopen_stateenter() {
    self notify(#"freefall_complete");
    if (!is_true(level.dontshootwhileparachuting)) {
        self [[ level.parachuteopencb ]]();
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x1 linked
// Checksum 0x2ed00afe, Offset: 0xd7d8
// Size: 0xde
function ffsm_landed_stateenter(*var_991bab43) {
    self.ignorefalldamagetime = gettime() + 5000;
    if (is_true(self.delayswaploadout)) {
        self.delayswaploadout = 0;
    }
    if (is_true(level.dontshootwhileparachuting)) {
        self [[ level.parachutecompletecb ]]();
    }
    self notify(#"parachute_landed");
    self function_41170420(0);
    if (!self function_b9370594()) {
        self function_8b8a321a(1);
    }
    self notify(#"parachute_complete");
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xfeedecce, Offset: 0xd8c0
// Size: 0x40
function ffsm_onground_stateenter() {
    self thread function_71205442();
    if (isdefined(level.onfirstlandcallback)) {
        self [[ level.onfirstlandcallback ]](self);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0xd908
// Size: 0x4
function function_71205442() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0xbf1c9a8c, Offset: 0xd918
// Size: 0x1c
function function_435d1356() {
    self disableusability();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0xd940
// Size: 0x4
function function_2f112556() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x9c1a8db0, Offset: 0xd950
// Size: 0x4a
function function_a4f5dbf9() {
    self enableusability();
    if (isdefined(level.modespecificparachutecompletecb)) {
        self [[ level.modespecificparachutecompletecb ]]();
    }
    self.jumptype = undefined;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0xd9a8
// Size: 0x4
function function_e5b1d4c7() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0xd9b8
// Size: 0x4
function function_750cef68() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xd9c8
// Size: 0x4
function function_7c164b8f() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xd9d8
// Size: 0x4
function function_7e55f28b() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x6c783104, Offset: 0xd9e8
// Size: 0x72
function function_9e7ff546() {
    player = self;
    if (isdefined(player.ffsm_state) && (player.ffsm_state == 1 || player.ffsm_state == 2)) {
        player ffsm_landed_stateenter();
        player.ffsm_state = 3;
    }
}

/#

    // Namespace player_insertion/player_insertion
    // Params 4, eflags: 0x0
    // Checksum 0xe303232, Offset: 0xda68
    // Size: 0xb2
    function draw_line(start, end, var_7c97a37e, color) {
        var_7c927bcc = int(var_7c97a37e / float(function_60d95f53()) / 1000);
        for (frame = 0; frame < var_7c927bcc; frame++) {
            line(start, end, color);
            waitframe(1);
        }
    }

    // Namespace player_insertion/player_insertion
    // Params 4, eflags: 0x0
    // Checksum 0xee7aa7fd, Offset: 0xdb28
    // Size: 0x19a
    function draw_angles(origin, angles, var_753aae30, scalar) {
        if (!isdefined(scalar)) {
            scalar = 1;
        }
        var_7c927bcc = int(var_753aae30 / float(function_60d95f53()) / 1000);
        for (frame = 0; frame < var_7c927bcc; frame++) {
            fwd = anglestoforward(angles);
            right = anglestoright(angles);
            up = anglestoup(angles);
            line(origin, origin + fwd * 12 * scalar, (1, 0, 0));
            line(origin, origin + right * 12 * scalar, (0, 1, 0));
            line(origin, origin + up * 12 * scalar, (0, 0, 1));
            waitframe(1);
        }
    }

    // Namespace player_insertion/player_insertion
    // Params 0, eflags: 0x0
    // Checksum 0x70bb7bef, Offset: 0xdcd0
    // Size: 0xfe
    function function_c3c0b24b() {
        self endon(#"death", #"disconnect");
        self endon(#"parachute_complete");
        while (true) {
            thread draw_angles(self.origin, self.angles, 0.05, 5);
            velocity = self getvelocity();
            mag = length(velocity);
            thread draw_line(self.origin, self.origin + vectornormalize(velocity) * mag, 0.05, (1, 0, 1));
            waitframe(1);
        }
    }

#/
