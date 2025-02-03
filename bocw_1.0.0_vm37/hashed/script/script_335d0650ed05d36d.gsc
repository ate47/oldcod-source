#using script_335d0650ed05d36d;
#using script_3e196d275a6fb180;
#using script_44b0b8420eabacad;
#using script_491ff5a2ba670762;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\map;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;
#using scripts\core_common\util_shared;

#namespace spawning;

// Namespace spawning/namespace_ade8eb98
// Params 0, eflags: 0x0
// Checksum 0xdce5ed1, Offset: 0x130
// Size: 0xd4
function function_d0149d6b() {
    assert(isdefined(level.spawnsystem));
    if (!isdefined(level.spawnsystem.var_bfd7cd96)) {
        level.spawnsystem.var_bfd7cd96 = &function_4fe2525a;
    }
    if (!isdefined(level.supportedspawntypes)) {
        level.supportedspawntypes = [];
    }
    mapbundle = map::get_script_bundle();
    if (isdefined(mapbundle) && isdefined(mapbundle.var_2feed9e4)) {
        setdvar(#"spawnsystem_sight_check_max_distance", mapbundle.var_2feed9e4);
    }
}

// Namespace spawning/namespace_ade8eb98
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x210
// Size: 0x4
function clear_spawn_points() {
    
}

// Namespace spawning/namespace_ade8eb98
// Params 1, eflags: 0x0
// Checksum 0x1f0343a8, Offset: 0x220
// Size: 0x4a
function function_32b97d1b(callbackfunction) {
    if (!isdefined(level.spawnsystem)) {
        level.spawnsystem = spawnstruct();
    }
    level.spawnsystem.var_bfd7cd96 = callbackfunction;
}

// Namespace spawning/namespace_ade8eb98
// Params 1, eflags: 0x0
// Checksum 0xffd2cfd, Offset: 0x278
// Size: 0x4a
function function_adbbb58a(callbackfunction) {
    if (!isdefined(level.spawnsystem)) {
        level.spawnsystem = spawnstruct();
    }
    level.spawnsystem.var_adbbb58a = callbackfunction;
}

// Namespace spawning/namespace_ade8eb98
// Params 0, eflags: 0x0
// Checksum 0x821eb5bb, Offset: 0x2d0
// Size: 0x10
function function_c40af6fa() {
    level.supportedspawntypes = [];
}

// Namespace spawning/namespace_ade8eb98
// Params 1, eflags: 0x0
// Checksum 0xf6fa586f, Offset: 0x2e8
// Size: 0xb2
function function_d3d4ff67(spawn) {
    foreach (var_a24ffdcc in level.supportedspawntypes) {
        supportedspawntype = var_a24ffdcc.type;
        if (function_82ca1565(spawn, supportedspawntype)) {
            return true;
        }
    }
    return false;
}

// Namespace spawning/namespace_ade8eb98
// Params 1, eflags: 0x0
// Checksum 0x2e1bcc6d, Offset: 0x3a8
// Size: 0xd2
function function_7309b6b3(spawn) {
    if (!isdefined(level.supportedspawntypes)) {
        level.supportedspawntypes = [];
    }
    foreach (var_a24ffdcc in level.supportedspawntypes) {
        supportedspawntype = var_a24ffdcc.type;
        if (function_82ca1565(spawn, supportedspawntype)) {
            return true;
        }
    }
    return false;
}

// Namespace spawning/namespace_ade8eb98
// Params 2, eflags: 0x0
// Checksum 0x7e993ce8, Offset: 0x488
// Size: 0x8c
function addsupportedspawnpointtype(spawnpointtype, team) {
    if (!isdefined(level.supportedspawntypes)) {
        level.supportedspawntypes = [];
    }
    spawnpointstruct = spawnstruct();
    spawnpointstruct.type = spawnpointtype;
    if (isdefined(team)) {
        spawnpointstruct.team = team;
    }
    array::add(level.supportedspawntypes, spawnpointstruct);
}

// Namespace spawning/namespace_ade8eb98
// Params 1, eflags: 0x0
// Checksum 0x37d3ea3b, Offset: 0x520
// Size: 0xd2
function function_b404fc61(rawspawns) {
    if (isdefined(level.spawnsystem.var_adbbb58a)) {
        validspawns = [];
        foreach (spawn in rawspawns) {
            if (![[ level.spawnsystem.var_adbbb58a ]](spawn)) {
                validspawns[validspawns.size] = spawn;
            }
        }
        rawspawns = validspawns;
    }
    return rawspawns;
}

// Namespace spawning/namespace_ade8eb98
// Params 0, eflags: 0x0
// Checksum 0x65a7932c, Offset: 0x600
// Size: 0x22
function function_4fe2525a() {
    return struct::get_array("mp_spawn_point", "targetname");
}

// Namespace spawning/namespace_ade8eb98
// Params 1, eflags: 0x0
// Checksum 0x6a0c0678, Offset: 0x630
// Size: 0x294
function function_beae80f9(rawspawns) {
    rawspawns = function_b404fc61(rawspawns);
    var_2014d551 = [];
    var_f152fde5 = [];
    var_22a1f7c8 = [];
    foreach (spawn in rawspawns) {
        if (!isdefined(spawn.group_index)) {
            spawn.group_index = 0;
        }
        if (!function_7309b6b3(spawn)) {
            continue;
        }
        if (oob::chr_party(spawn.origin) && territory::is_inside(spawn.origin)) {
            continue;
        }
        if (!isdefined(var_2014d551[spawn.group_index])) {
            var_2014d551[spawn.group_index] = [];
        }
        if (!isdefined(var_f152fde5[spawn.group_index])) {
            var_f152fde5[spawn.group_index] = [];
        }
        if (!isdefined(var_22a1f7c8[spawn.group_index])) {
            var_22a1f7c8[spawn.group_index] = [];
        }
        if (is_true(spawn._human_were)) {
            array::add(var_f152fde5[spawn.group_index], spawn);
        } else {
            array::add(var_2014d551[spawn.group_index], spawn);
        }
        if (is_true(spawn.var_4a7883fa)) {
            array::add(var_22a1f7c8[spawn.group_index], spawn);
        }
    }
    function_4277fa85(var_2014d551, "auto_normal");
    function_4277fa85(var_f152fde5, "start_spawn");
    function_4277fa85(var_22a1f7c8, "hq");
}

// Namespace spawning/namespace_ade8eb98
// Params 2, eflags: 0x4
// Checksum 0x3f36505c, Offset: 0x8d0
// Size: 0xf8
function private function_4277fa85(spawnpoints, var_6de73ddb) {
    spawngroups = getarraykeys(spawnpoints);
    foreach (groupindex in spawngroups) {
        function_923afc2e(spawnpoints[groupindex]);
        var_4a4a963a = function_3ea24e49(groupindex);
        addspawnpoints(var_4a4a963a, spawnpoints[groupindex], var_6de73ddb);
    }
}

// Namespace spawning/namespace_ade8eb98
// Params 0, eflags: 0x0
// Checksum 0xa0468f32, Offset: 0x9d0
// Size: 0xe4
function addspawns() {
    clearspawnpoints("auto_normal");
    clearspawnpoints("fallback");
    rawspawns = [[ level.spawnsystem.var_bfd7cd96 ]]();
    if (isdefined(rawspawns)) {
        function_beae80f9(rawspawns);
    }
    function_100e84f();
    function_fbff01ea();
    calculate_map_center();
    spawnpoint = get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
}

// Namespace spawning/namespace_ade8eb98
// Params 0, eflags: 0x0
// Checksum 0x9d8fb3ad, Offset: 0xac0
// Size: 0x1d4
function function_b4f071cd() {
    var_ba7cd990 = struct::get(#"hash_3ccb068cc20d10fb");
    var_3ab559fb = struct::get(#"hash_2a16a120d7d497f0");
    if (!isdefined(var_ba7cd990) || !isdefined(var_3ab559fb)) {
        println("<dev string:x38>");
        return;
    }
    spawns = function_82061144("start_spawn", #"allies");
    if (spawns.size == 0) {
        println("<dev string:x83>");
        return;
    }
    var_bbd0ce18 = distancesquared(spawns[0].origin, var_ba7cd990.origin);
    var_1f5969dc = distancesquared(spawns[0].origin, var_3ab559fb.origin);
    if (var_bbd0ce18 < var_1f5969dc) {
        var_ba7cd990.team = #"allies";
        var_3ab559fb.team = #"axis";
    } else {
        var_3ab559fb.team = #"allies";
        var_ba7cd990.team = #"axis";
    }
    util::function_c77e4851(var_ba7cd990.team, var_3ab559fb.team);
}

