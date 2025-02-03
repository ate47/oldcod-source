#using script_335d0650ed05d36d;
#using script_7d712f77ab8d0c16;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;
#using scripts\core_common\util_shared;

#namespace spawning;

// Namespace spawning/namespace_48f955ce
// Params 0, eflags: 0x0
// Checksum 0x8541d9e, Offset: 0x138
// Size: 0x11c
function calculate_map_center() {
    if (isdefined(level.mapcenter)) {
        return;
    }
    if (!function_5abfedf7("auto_normal")) {
        return;
    }
    var_7465f696 = function_92f03095("auto_normal");
    level.spawnmins = var_7465f696[#"mins"];
    level.spawnmaxs = var_7465f696[#"maxs"];
    level.mapbounds.var_1d694d71 = var_7465f696[#"mins"];
    level.mapbounds.var_a13a9915 = var_7465f696[#"maxs"];
    level.mapbounds.center = var_7465f696[#"center"];
    level.mapcenter = var_7465f696[#"center"];
    setmapcenter(level.mapcenter);
}

// Namespace spawning/namespace_48f955ce
// Params 0, eflags: 0x0
// Checksum 0xce3a701f, Offset: 0x260
// Size: 0x3a
function function_1bc642b7() {
    if (game.switchedsides == 0) {
        return false;
    }
    if (level.spawnsystem.var_3709dc53 == 0) {
        return true;
    }
    return false;
}

// Namespace spawning/namespace_48f955ce
// Params 3, eflags: 0x0
// Checksum 0x51b63095, Offset: 0x2a8
// Size: 0xba
function get_spawnpoint_random(spawnpoints, predictedspawn, isintermissionspawn = 0) {
    if (!isdefined(spawnpoints)) {
        return undefined;
    }
    for (i = 0; i < spawnpoints.size; i++) {
        j = randomint(spawnpoints.size);
        spawnpoint = spawnpoints[i];
        spawnpoints[i] = spawnpoints[j];
        spawnpoints[j] = spawnpoint;
    }
    return get_spawnpoint_final(spawnpoints, predictedspawn, isintermissionspawn);
}

// Namespace spawning/namespace_48f955ce
// Params 3, eflags: 0x0
// Checksum 0xf101b94a, Offset: 0x370
// Size: 0x250
function get_spawnpoint_final(spawnpoints, predictedspawn, isintermmissionspawn = 0) {
    var_e627dced = &positionwouldtelefrag;
    if (isdefined(level.var_79f19f00)) {
        var_e627dced = level.var_79f19f00;
    }
    bestspawnpoint = undefined;
    if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
        return undefined;
    }
    if (!isdefined(predictedspawn)) {
        predictedspawn = 0;
    }
    if (isdefined(self.lastspawnpoint) && self.lastspawnpoint.lastspawnpredicted && !predictedspawn && !isintermmissionspawn && (!isdefined(self.var_7007b746) || !self.var_7007b746)) {
        if (![[ var_e627dced ]](self.lastspawnpoint.origin)) {
            bestspawnpoint = self.lastspawnpoint;
        }
    }
    if (!isdefined(bestspawnpoint)) {
        for (i = 0; i < spawnpoints.size; i++) {
            if (isdefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i] && !self.lastspawnpoint.lastspawnpredicted) {
                continue;
            }
            if ([[ var_e627dced ]](spawnpoints[i].origin)) {
                continue;
            }
            bestspawnpoint = spawnpoints[i];
            break;
        }
    }
    if (!isdefined(bestspawnpoint)) {
        if (isdefined(self.lastspawnpoint) && ![[ var_e627dced ]](self.lastspawnpoint.origin)) {
            for (i = 0; i < spawnpoints.size; i++) {
                if (spawnpoints[i] == self.lastspawnpoint) {
                    bestspawnpoint = spawnpoints[i];
                    break;
                }
            }
        }
    }
    if (!isdefined(bestspawnpoint)) {
        bestspawnpoint = spawnpoints[0];
    }
    self finalize_spawnpoint_choice(bestspawnpoint, predictedspawn);
    return bestspawnpoint;
}

// Namespace spawning/namespace_48f955ce
// Params 0, eflags: 0x0
// Checksum 0x81596cb3, Offset: 0x5c8
// Size: 0xc2
function get_random_intermission_point() {
    spawnpoints = get_spawnpoint_array("mp_global_intermission");
    if (!spawnpoints.size) {
        spawnpoints = get_spawnpoint_array("cp_global_intermission");
    }
    if (!spawnpoints.size) {
        spawnpoints = get_spawnpoint_array("info_player_start");
    }
    assert(spawnpoints.size);
    spawnpoint = get_spawnpoint_random(spawnpoints, undefined, 1);
    return spawnpoint;
}

// Namespace spawning/namespace_48f955ce
// Params 2, eflags: 0x0
// Checksum 0xb6fc2ad8, Offset: 0x698
// Size: 0x6a
function finalize_spawnpoint_choice(spawnpoint, predictedspawn) {
    time = gettime();
    self.lastspawnpoint = spawnpoint;
    self.lastspawntime = time;
    self.var_7007b746 = 0;
    spawnpoint.lastspawnedplayer = self;
    spawnpoint.lastspawntime = time;
    spawnpoint.lastspawnpredicted = predictedspawn;
}

// Namespace spawning/namespace_48f955ce
// Params 4, eflags: 0x0
// Checksum 0xcca1b464, Offset: 0x710
// Size: 0x196
function move_spawn_point(var_75347e0b, start_point, new_point, new_angles) {
    targetnamearray = [];
    if (isarray(var_75347e0b)) {
        targetnamearray = var_75347e0b;
    } else {
        if (!isdefined(targetnamearray)) {
            targetnamearray = [];
        } else if (!isarray(targetnamearray)) {
            targetnamearray = array(targetnamearray);
        }
        targetnamearray[targetnamearray.size] = var_75347e0b;
    }
    foreach (targetname in targetnamearray) {
        spawn_points = get_spawnpoint_array(targetname);
        for (i = 0; i < spawn_points.size; i++) {
            if (distancesquared(spawn_points[i].origin, start_point) < 1) {
                spawn_points[i].origin = new_point;
                if (isdefined(new_angles)) {
                    spawn_points[i].angles = new_angles;
                }
            }
        }
    }
}

// Namespace spawning/namespace_48f955ce
// Params 2, eflags: 0x0
// Checksum 0xbbacab69, Offset: 0x8b0
// Size: 0x16a
function get_spawnpoint_array(classname, include_disabled = 0) {
    spawn_points = struct::get_array(classname, "targetname");
    if (!include_disabled && getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0) {
        enabled_spawn_points = [];
        foreach (spawn_point in spawn_points) {
            if (!is_true(spawn_point.disabled)) {
                if (!isdefined(enabled_spawn_points)) {
                    enabled_spawn_points = [];
                } else if (!isarray(enabled_spawn_points)) {
                    enabled_spawn_points = array(enabled_spawn_points);
                }
                enabled_spawn_points[enabled_spawn_points.size] = spawn_point;
            }
        }
        spawn_points = enabled_spawn_points;
    }
    return spawn_points;
}

// Namespace spawning/namespace_48f955ce
// Params 1, eflags: 0x0
// Checksum 0xa52e7999, Offset: 0xa28
// Size: 0x9c
function drop_spawn_points(spawnpointname) {
    spawnpoints = get_spawnpoint_array(spawnpointname);
    if (!spawnpoints.size) {
        println("<dev string:x38>" + spawnpointname + "<dev string:x41>");
        return;
    }
    for (index = 0; index < spawnpoints.size; index++) {
        placespawnpoint(spawnpoints[index]);
    }
}

// Namespace spawning/namespace_48f955ce
// Params 2, eflags: 0x0
// Checksum 0xf727d45c, Offset: 0xad0
// Size: 0x954
function function_82ca1565(spawnpoint, gametype) {
    switch (gametype) {
    case #"base":
        return (isdefined(spawnpoint.base) && spawnpoint.base);
    case #"ffa":
        return (isdefined(spawnpoint.ffa) && spawnpoint.ffa);
    case #"sd":
        return (isdefined(spawnpoint.sd) && spawnpoint.sd);
    case #"ctf":
        return (isdefined(spawnpoint.ctf) && spawnpoint.ctf);
    case #"dom":
        return (isdefined(spawnpoint.domination) && spawnpoint.domination);
    case #"dem":
        return (isdefined(spawnpoint.demolition) && spawnpoint.demolition);
    case #"gg":
        return (isdefined(spawnpoint.gg) && spawnpoint.gg);
    case #"tdm":
        return (isdefined(spawnpoint.tdm) && spawnpoint.tdm);
    case #"infil":
        return (isdefined(spawnpoint.infiltration) && spawnpoint.infiltration);
    case #"control":
        return (isdefined(spawnpoint.control) && spawnpoint.control);
    case #"uplink":
        return (isdefined(spawnpoint.uplink) && spawnpoint.uplink);
    case #"kc":
        return (isdefined(spawnpoint.kc) && spawnpoint.kc);
    case #"koth":
        return (isdefined(spawnpoint.hardpoint) && spawnpoint.hardpoint);
    case #"frontline":
        return (isdefined(spawnpoint.frontline) && spawnpoint.frontline);
    case #"dom_flag_a":
        return (isdefined(spawnpoint.domination_flag_a) && spawnpoint.domination_flag_a);
    case #"dom_flag_b":
        return (isdefined(spawnpoint.domination_flag_b) && spawnpoint.domination_flag_b);
    case #"dom_flag_c":
        return (isdefined(spawnpoint.domination_flag_c) && spawnpoint.domination_flag_c);
    case #"dom_flag_d":
        return (isdefined(spawnpoint.var_99227e72) && spawnpoint.var_99227e72);
    case #"dom_flag_e":
        return (isdefined(spawnpoint.var_6cd325d0) && spawnpoint.var_6cd325d0);
    case #"dom_flag_f":
        return (isdefined(spawnpoint.var_991d7e64) && spawnpoint.var_991d7e64);
    case #"hash_6056c310624d5afd":
        return (isdefined(spawnpoint.demolition_attacker_a) && spawnpoint.demolition_attacker_a);
    case #"hash_6056c010624d55e4":
        return (isdefined(spawnpoint.demolition_attacker_b) && spawnpoint.demolition_attacker_b);
    case #"hash_6ef2d89ce8ee9a32":
        return (isdefined(spawnpoint.demolition_remove_a) && spawnpoint.demolition_remove_a);
    case #"hash_6ef2d79ce8ee987f":
        return (isdefined(spawnpoint.demolition_remove_b) && spawnpoint.demolition_remove_b);
    case #"dem_overtime":
        return (isdefined(spawnpoint.demolition_overtime) && spawnpoint.demolition_overtime);
    case #"hash_7cb9d0a58715cebe":
        return (isdefined(spawnpoint.demolition_start_spawn) && spawnpoint.demolition_start_spawn);
    case #"hash_6d83e5f1bdefa7dd":
        return (isdefined(spawnpoint.demolition_defender_a) && spawnpoint.demolition_defender_a);
    case #"hash_6d83e2f1bdefa2c4":
        return (isdefined(spawnpoint.demolition_defender_b) && spawnpoint.demolition_defender_b);
    case #"control_attack_add_0":
        return (isdefined(spawnpoint.control_attack_add_a) && spawnpoint.control_attack_add_a);
    case #"control_attack_add_1":
        return (isdefined(spawnpoint.control_attack_add_b) && spawnpoint.control_attack_add_b);
    case #"control_attack_remove_0":
        return (isdefined(spawnpoint.control_attack_remove_a) && spawnpoint.control_attack_remove_a);
    case #"control_attack_remove_1":
        return (isdefined(spawnpoint.control_attack_remove_b) && spawnpoint.control_attack_remove_b);
    case #"control_defend_add_0":
        return (isdefined(spawnpoint.registerlast_mapshouldstun) && spawnpoint.registerlast_mapshouldstun);
    case #"control_defend_add_1":
        return (isdefined(spawnpoint.control_defend_add_b) && spawnpoint.control_defend_add_b);
    case #"control_defend_remove_0":
        return (isdefined(spawnpoint.control_defend_remove_a) && spawnpoint.control_defend_remove_a);
    case #"control_defend_remove_1":
        return (isdefined(spawnpoint.control_defend_remove_b) && spawnpoint.control_defend_remove_b);
    case #"ct":
        return (isdefined(spawnpoint.ct) && spawnpoint.ct);
    case #"escort":
        return (isdefined(spawnpoint.escort) && spawnpoint.escort);
    case #"bounty":
        return (isdefined(spawnpoint.bounty) && spawnpoint.bounty);
    case #"fireteam":
        return is_true(spawnpoint.fireteam);
    case #"vip":
        return is_true(spawnpoint.vip);
    case #"war":
        return is_true(spawnpoint.war);
    case #"dropkick":
        return is_true(spawnpoint.dropkick);
    case #"hash_35b3b60f0a291417":
        return is_true(spawnpoint.var_3cb82e5e);
    case #"hash_450dd6aacc69e524":
        return is_true(spawnpoint.var_d8e690f8);
    case #"hash_42f07692f7d48364":
        return is_true(spawnpoint.var_3d72e6da);
    default:
        assertmsg("<dev string:x61>" + gametype + "<dev string:x70>" + spawnpoint.origin[0] + "<dev string:x9c>" + spawnpoint.origin[1] + "<dev string:xa4>" + spawnpoint.origin[2]);
        break;
    }
    return 0;
}

// Namespace spawning/namespace_48f955ce
// Params 1, eflags: 0x0
// Checksum 0xcc956478, Offset: 0x1430
// Size: 0xc2
function is_spawn_trapped(team) {
    if (!level.rankedmatch) {
        return false;
    }
    if (level.spawnsystem.spawntraptriggertime == 0) {
        return false;
    }
    if (isdefined(level.alivetimesaverage) && isdefined(level.alivetimesaverage[team]) && level.alivetimesaverage[team] != 0 && level.alivetimesaverage[team] < int(level.spawnsystem.spawntraptriggertime * 1000)) {
        return true;
    }
    return false;
}

// Namespace spawning/namespace_48f955ce
// Params 2, eflags: 0x0
// Checksum 0xe4ac6272, Offset: 0x1500
// Size: 0x7e
function function_e1a7c3d9(spawn_origin, spawn_angles) {
    var_50747a19 = spawn_origin + (0, 0, 60);
    self predictspawnpoint(var_50747a19, spawn_angles);
    self.predicted_spawn_point = {#origin:var_50747a19, #angles:spawn_angles};
}

// Namespace spawning/namespace_48f955ce
// Params 1, eflags: 0x0
// Checksum 0x664a7d4b, Offset: 0x1588
// Size: 0x44
function function_754c78a6(func_callback) {
    if (!isdefined(level.var_811300ad)) {
        level.var_811300ad = [];
    }
    array::add(level.var_811300ad, func_callback);
}

// Namespace spawning/namespace_48f955ce
// Params 1, eflags: 0x0
// Checksum 0x761d5550, Offset: 0x15d8
// Size: 0xe2
function function_4c00b132(func_callback) {
    assert(isdefined(level.var_811300ad) && level.var_811300ad.size, "<dev string:xac>");
    foreach (index, func in level.var_811300ad) {
        if (func == func_callback) {
            arrayremoveindex(level.var_811300ad, index, 0);
            return;
        }
    }
}

// Namespace spawning/namespace_48f955ce
// Params 1, eflags: 0x0
// Checksum 0x1a853dcc, Offset: 0x16c8
// Size: 0xc4
function function_a782529(e_player) {
    var_8bfdbbee = [];
    foreach (func in level.var_811300ad) {
        var_ee69d92d = [[ func ]](e_player);
        if (isdefined(var_ee69d92d)) {
            array::add(var_8bfdbbee, var_ee69d92d);
        }
    }
    return var_8bfdbbee;
}

// Namespace spawning/namespace_48f955ce
// Params 0, eflags: 0x0
// Checksum 0xbb551c4a, Offset: 0x1798
// Size: 0x46
function usestartspawns() {
    if (is_true(level.alwaysusestartspawns)) {
        return true;
    }
    if (!is_true(level.usestartspawns)) {
        return false;
    }
    return true;
}

// Namespace spawning/namespace_48f955ce
// Params 0, eflags: 0x0
// Checksum 0xa934b8d2, Offset: 0x17e8
// Size: 0x10
function function_7a87efaa() {
    level.usestartspawns = 0;
}

// Namespace spawning/namespace_48f955ce
// Params 0, eflags: 0x0
// Checksum 0x7831d557, Offset: 0x1800
// Size: 0x14
function function_6325a7c5() {
    level.usestartspawns = 1;
}

// Namespace spawning/namespace_48f955ce
// Params 1, eflags: 0x0
// Checksum 0xe117c327, Offset: 0x1820
// Size: 0x90
function function_923afc2e(spawnpointarray) {
    foreach (spawn in spawnpointarray) {
        placespawnpoint(spawn);
    }
}

// Namespace spawning/namespace_48f955ce
// Params 1, eflags: 0x0
// Checksum 0x2b9ec418, Offset: 0x18b8
// Size: 0x6c
function function_3ea24e49(team) {
    correctedteam = team;
    if (game.switchedsides && (team == 2 || team == 1)) {
        correctedteam = team == 1 ? 2 : 1;
    }
    return correctedteam;
}

// Namespace spawning/namespace_48f955ce
// Params 3, eflags: 0x0
// Checksum 0xb445eae9, Offset: 0x1930
// Size: 0x2cc
function function_fac242d0(var_9be0d23f, var_f64fe0e3, var_efb263ee) {
    spawns = struct::get_array("mp_spawn_point", "targetname");
    var_a6155878 = [];
    foreach (spawn in spawns) {
        for (index = 0; index < var_9be0d23f; index++) {
            key = var_f64fe0e3 + index;
            if (is_true(spawn.(key))) {
                if (!isdefined(var_a6155878[index])) {
                    var_a6155878[index] = [];
                }
                if (!isdefined(var_a6155878[index][spawn.group_index])) {
                    var_a6155878[index][spawn.group_index] = [];
                } else if (!isarray(var_a6155878[index][spawn.group_index])) {
                    var_a6155878[index][spawn.group_index] = array(var_a6155878[index][spawn.group_index]);
                }
                var_a6155878[index][spawn.group_index][var_a6155878[index][spawn.group_index].size] = spawn;
            }
        }
    }
    var_3d07f18c = getarraykeys(var_a6155878);
    for (index = 0; index < var_3d07f18c.size; index++) {
        var_49c85f88 = var_3d07f18c[index];
        spawnlistname = [[ var_efb263ee ]](var_49c85f88);
        var_f3ec1a55 = getarraykeys(var_a6155878[var_49c85f88]);
        for (teamindex = 0; teamindex < var_f3ec1a55.size; teamindex++) {
            var_b2b02f12 = var_f3ec1a55[teamindex];
            var_598298ff = var_a6155878[var_49c85f88][var_b2b02f12];
            addspawnpoints(var_b2b02f12, var_598298ff, spawnlistname);
        }
    }
}

// Namespace spawning/namespace_48f955ce
// Params 0, eflags: 0x0
// Checksum 0x4be10962, Offset: 0x1c08
// Size: 0x122
function function_90dee50d() {
    var_637da63f = [];
    spawns = function_4fe2525a();
    foreach (spawn in spawns) {
        if (!territory::is_valid(spawn)) {
            continue;
        }
        if (territory::is_inside(spawn.origin)) {
            if (!isdefined(var_637da63f)) {
                var_637da63f = [];
            } else if (!isarray(var_637da63f)) {
                var_637da63f = array(var_637da63f);
            }
            var_637da63f[var_637da63f.size] = spawn;
        }
    }
    return var_637da63f;
}

// Namespace spawning/namespace_48f955ce
// Params 1, eflags: 0x0
// Checksum 0x779fd91c, Offset: 0x1d38
// Size: 0x44
function function_c24e290c(spawn) {
    if (!territory::is_valid(spawn)) {
        return false;
    }
    return !territory::is_inside(spawn.origin);
}

