#using script_27347f09888ad15;
#using script_3411bb48d41bd3b;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace namespace_60c38ce9;

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x0
// Checksum 0x2e594449, Offset: 0x110
// Size: 0x13c
function init(var_3c7084f9) {
    level.var_2b36f9ae = {#var_367330c0:0, #difficulty:0, #var_a6a3aad1:#"hash_4c73befd306d59d5", #clusters:[], #var_a3ead99e:[], #var_f48fec1b:[], #var_f46a3413:[], #var_179ada5f:[]};
    setdvar(#"hash_c8bfb7e63cf0d50", "mixed_zombies");
    level flag::init(#"hash_408fb58a3f3c6243", 0);
    level thread setup_clusters(var_3c7084f9);
    /#
        level.var_2b36f9ae.debug_info = {};
        level thread function_fe4932a1();
    #/
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x5 linked
// Checksum 0x9b03d6f5, Offset: 0x258
// Size: 0x38c
function private setup_clusters(triggers) {
    level endon(#"game_ended");
    start_time = getrealtime();
    var_c63f2b85 = start_time + 100;
    pixbeginevent("setup_clusters");
    clusters = struct::get_array(#"hash_754f7bdb468e9322", "script_noteworthy");
    clusters = function_97af8791(clusters);
    foreach (cluster in clusters) {
        if (isarray(triggers)) {
            is_touching = 0;
            foreach (trigger in triggers) {
                if (trigger istouching(cluster.origin, (cluster.radius, cluster.radius, cluster.height))) {
                    is_touching = 1;
                    break;
                }
            }
            if (!is_touching) {
                continue;
            }
        }
        var_6bca277 = function_3bdf488(cluster);
        if (!is_true(var_6bca277.var_45d1a7df)) {
            function_8844b193(var_6bca277);
        } else {
            /#
                if (!isdefined(level.var_2b36f9ae.var_a9bdfe7)) {
                    level.var_2b36f9ae.var_a9bdfe7 = [];
                }
                level.var_2b36f9ae.var_a9bdfe7[level.var_2b36f9ae.var_a9bdfe7.size] = var_6bca277;
            #/
        }
        if (getrealtime() > var_c63f2b85) {
            pixendevent();
            waitframe(1);
            pixbeginevent("setup_clusters");
            var_c63f2b85 = getrealtime() + 100;
        }
    }
    level flag::set(#"hash_408fb58a3f3c6243");
    pixendevent();
    println("<dev string:x38>" + getrealtime() - start_time + "<dev string:x53>");
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x5 linked
// Checksum 0xca6291b0, Offset: 0x5f0
// Size: 0x3d0
function private function_97af8791(clusters) {
    var_e680d0ec = [];
    var_65edfab7 = [];
    foreach (cluster in clusters) {
        if (isdefined(cluster.var_95dbbc4c) && isdefined(cluster.var_60ec68a2)) {
            if (!isdefined(var_65edfab7[cluster.var_95dbbc4c])) {
                var_65edfab7[cluster.var_95dbbc4c] = [];
            } else if (!isarray(var_65edfab7[cluster.var_95dbbc4c])) {
                var_65edfab7[cluster.var_95dbbc4c] = array(var_65edfab7[cluster.var_95dbbc4c]);
            }
            var_65edfab7[cluster.var_95dbbc4c][var_65edfab7[cluster.var_95dbbc4c].size] = cluster;
            continue;
        }
        var_e680d0ec[var_e680d0ec.size] = cluster;
    }
    /#
        foreach (var_95dbbc4c in var_65edfab7) {
            var_60ec68a2 = var_95dbbc4c[0].var_60ec68a2;
            foreach (cluster in var_95dbbc4c) {
                if (var_60ec68a2 !== cluster.var_60ec68a2) {
                    println("<dev string:x63>" + cluster.origin[0] + "<dev string:x9b>" + cluster.origin[1] + "<dev string:x9b>" + cluster.origin[2] + "<dev string:xa0>");
                }
            }
        }
    #/
    foreach (var_95dbbc4c in var_65edfab7) {
        for (i = 0; i < int(var_95dbbc4c[0].var_60ec68a2); i++) {
            random_index = var_95dbbc4c.size < 1 ? 0 : randomintrange(0, var_95dbbc4c.size);
            var_e680d0ec[var_e680d0ec.size] = array::pop(var_95dbbc4c, random_index, 0);
            if (var_95dbbc4c.size == 0) {
                break;
            }
        }
    }
    return var_e680d0ec;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x4
// Checksum 0xa49ecca8, Offset: 0x9c8
// Size: 0x11c
function private function_3b9488f8(var_76dffad4) {
    var_afb0c2b6 = [];
    for (i = 0; i < 3; i++) {
        if (isdefined(var_76dffad4.("aitype_" + i))) {
            aitype = var_76dffad4.("aitype_" + i);
            count = var_76dffad4.("aitype_" + i + "_num");
            assert(function_e949cfd7(aitype), "<dev string:xa5>" + aitype + "<dev string:xb0>");
            var_afb0c2b6[var_afb0c2b6.size] = {#aitype:aitype, #count:count};
        }
    }
    return var_afb0c2b6;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 2, eflags: 0x1 linked
// Checksum 0x33125ff5, Offset: 0xaf0
// Size: 0xf4
function function_67f6704e(var_76dffad4, bundle) {
    foreach (var_d243fa8a in bundle.var_fc18097c) {
        if (isdefined(var_d243fa8a.var_210a8489)) {
            var_89592ba7 = namespace_679a22ba::function_77be8a83(var_d243fa8a.var_210a8489);
        }
        if (!isdefined(var_89592ba7)) {
            var_89592ba7 = {#var_7c88c117:[]};
        }
        var_76dffad4.var_a1c6a560[var_76dffad4.var_a1c6a560.size] = var_89592ba7;
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x1 linked
// Checksum 0x32c6a6d1, Offset: 0xbf0
// Size: 0x750
function function_3bdf488(var_76dffad4) {
    assert(isdefined(var_76dffad4.scriptbundlename), "<dev string:xcf>");
    spawn_points = [];
    if (isdefined(var_76dffad4.targetname)) {
        spawn_points = struct::get_array(var_76dffad4.targetname, "target");
    }
    var_76dffad4.radius = int(var_76dffad4.radius);
    var_76dffad4.height = int(var_76dffad4.height);
    var_76dffad4.var_9b178666 = int(isdefined(var_76dffad4.var_9b178666) ? var_76dffad4.var_9b178666 : "0");
    var_76dffad4.var_48d0f926 = int(isdefined(var_76dffad4.var_48d0f926) ? var_76dffad4.var_48d0f926 : "0");
    var_76dffad4.var_499035e2 = int(isdefined(var_76dffad4.var_499035e2) ? var_76dffad4.var_499035e2 : "0");
    var_76dffad4.var_81314a61 = int(isdefined(var_76dffad4.var_81314a61) ? var_76dffad4.var_81314a61 : "0");
    var_76dffad4.var_2badd965 = level.var_2b36f9ae.difficulty;
    var_76dffad4.tier = var_76dffad4.var_2badd965;
    bundle = getscriptbundle(var_76dffad4.scriptbundlename);
    var_76dffad4.var_783fc5e = bundle.var_783fc5e;
    var_76dffad4.wander_radius = int(isdefined(var_76dffad4.wander_radius) ? var_76dffad4.wander_radius : bundle.wander_radius);
    var_76dffad4.var_1fb426c4 = bundle.var_1fb426c4;
    var_76dffad4.var_abf4838d = bundle.var_abf4838d;
    var_76dffad4.var_b263bc97 = bundle.var_1fb426c4;
    var_76dffad4.var_cba07089 = bundle.var_abf4838d;
    if (is_true(bundle.var_7f144c84)) {
        var_76dffad4.var_19e89e4e = 1;
    }
    var_76dffad4.move_speed = bundle.move_speed;
    var_76dffad4.var_a1c6a560 = [];
    if (isdefined(bundle.var_fc18097c)) {
        var_76dffad4.tier = int(min(var_76dffad4.var_2badd965, bundle.var_fc18097c.size - 1));
        function_67f6704e(var_76dffad4, bundle);
    }
    assert(isdefined(var_76dffad4.radius) && isdefined(var_76dffad4.height), "<dev string:x139>");
    if (var_76dffad4.var_9b178666 == 0) {
        var_76dffad4.var_9b178666 = 256;
    }
    if (var_76dffad4.var_48d0f926 == 0) {
        var_76dffad4.var_48d0f926 = 128;
    }
    foreach (spawn_point in spawn_points) {
        spawn_point.offset = spawn_point.origin - var_76dffad4.origin;
        spawn_point.variantname = undefined;
        spawn_point.wander_radius = undefined;
    }
    if (spawn_points.size < var_76dffad4.var_783fc5e) {
        var_33c150db = [];
        if (is_true(var_76dffad4.var_19e89e4e)) {
            var_33c150db = namespace_85745671::function_7a1b21f6(var_76dffad4.origin, var_76dffad4.angles, var_76dffad4.var_783fc5e - spawn_points.size, var_76dffad4.var_499035e2, var_76dffad4.var_81314a61, var_76dffad4.var_48d0f926, 1, 0);
        } else {
            var_33c150db = namespace_85745671::function_e4791424(var_76dffad4.origin, var_76dffad4.var_783fc5e - spawn_points.size, var_76dffad4.var_48d0f926, var_76dffad4.var_9b178666, var_76dffad4.var_eadf44e7, 1, 0);
        }
        spawn_points = arraycombine(spawn_points, var_33c150db, 1, 0);
        if (!var_33c150db.size) {
            var_76dffad4.var_45d1a7df = 1;
        }
    }
    level.var_2b36f9ae.var_367330c0 = max(max(var_76dffad4.radius, var_76dffad4.height), level.var_2b36f9ae.var_367330c0);
    var_76dffad4.spawn_points = array::randomize(spawn_points);
    var_76dffad4.status = 0;
    var_76dffad4.var_575b98d2 = 0;
    var_76dffad4.var_2b1e932c = 0;
    var_76dffad4.var_c0bddfa9 = var_76dffad4.var_abf4838d - var_76dffad4.var_2b1e932c;
    var_76dffad4.var_8152d04 = 0;
    var_76dffad4.var_743c45a5 = [];
    var_76dffad4.spawn_point_index = 0;
    if (isdefined(var_76dffad4.target) && isdefined(getnode(var_76dffad4.target, "targetname"))) {
        next_goal = getnode(var_76dffad4.target, "targetname");
        var_76dffad4.next_goal = next_goal;
        var_76dffad4.var_a3ead2f = var_76dffad4;
        var_76dffad4.move_speed = float(var_76dffad4.move_speed);
        var_76dffad4.var_c3467a5d = vectornormalize(var_76dffad4.next_goal.origin - var_76dffad4.var_a3ead2f.origin);
    }
    if (is_true(var_76dffad4.script_start_disabled)) {
        function_94825461(var_76dffad4);
    }
    return var_76dffad4;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 3, eflags: 0x5 linked
// Checksum 0xd454561f, Offset: 0x1348
// Size: 0x6c
function private function_b65096b1(value = 0, count = 0, scaler) {
    return value + int(floor(value * scaler * count));
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x5 linked
// Checksum 0x4e48d226, Offset: 0x13c0
// Size: 0x32e
function private function_50349401(cluster) {
    count = getplayers().size - 1;
    /#
        if (getdvarint(#"hash_718bfcd5ab690a9c", 0) > 0) {
            count = getdvarint(#"hash_718bfcd5ab690a9c", 0) - 1;
        }
    #/
    if (cluster.var_7859e563 === count) {
        return;
    }
    var_653002ff = getscriptbundle(cluster.scriptbundlename);
    if (isdefined(var_653002ff.var_fc18097c) && cluster.var_2badd965 !== level.var_2b36f9ae.difficulty) {
        cluster.var_2badd965 = level.var_2b36f9ae.difficulty;
        cluster.tier = int(min(cluster.var_2badd965, var_653002ff.var_fc18097c.size - 1));
    }
    cluster.var_abf4838d = function_b65096b1(var_653002ff.var_abf4838d, count, var_653002ff.var_d961aeb3);
    cluster.var_1fb426c4 = function_b65096b1(var_653002ff.var_1fb426c4, count, var_653002ff.var_d961aeb3);
    cluster.var_8152d04 = cluster.var_abf4838d <= cluster.var_2b1e932c;
    foreach (var_a85527c1, var_d243fa8a in var_653002ff.var_fc18097c) {
        if (isdefined(var_d243fa8a.var_210a8489)) {
            var_3561dd4b = getscriptbundle(var_d243fa8a.var_210a8489);
            foreach (var_478ea257, spawn_list in var_3561dd4b.var_210a8489) {
                cluster.var_a1c6a560[var_a85527c1].var_7c88c117[var_478ea257].var_cffbc08 = function_b65096b1(spawn_list.var_a949845f, count, var_653002ff.var_d961aeb3);
            }
        }
    }
    cluster.var_7859e563 = count;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 2, eflags: 0x5 linked
// Checksum 0x36e20266, Offset: 0x16f8
// Size: 0xce
function private function_7ff205c5(cluster, &var_bb45dc6c) {
    if (cluster.status !== 1) {
        if (cluster.status == 0) {
            function_50349401(cluster);
        }
        cluster.var_52c3894a = undefined;
        cluster.var_cd6724f6 = undefined;
        cluster.var_7303b52f = undefined;
        cluster.status = 1;
    }
    var_bb45dc6c[var_bb45dc6c.size] = cluster;
    arrayremovevalue(level.var_2b36f9ae.var_f48fec1b, cluster);
    cluster.var_575b98d2 = gettime() + function_60d95f53();
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 2, eflags: 0x5 linked
// Checksum 0x1ca03b2d, Offset: 0x17d0
// Size: 0x194
function private function_411a4fc8(cluster, var_ed51a51f) {
    if (cluster.status === 1) {
        if (!is_true(var_ed51a51f)) {
            cluster.status = 2;
            cluster.var_cd6724f6 = gettime();
            cluster.var_7303b52f = 0;
            cluster.var_52c3894a = 0;
            level.var_2b36f9ae.var_f48fec1b[level.var_2b36f9ae.var_f48fec1b.size] = cluster;
            return;
        }
        cluster.status = 0;
        foreach (ai in cluster.var_743c45a5) {
            if (isalive(ai) && !is_true(ai.var_4c52cd24)) {
                cleanup_ai(ai);
                ai.var_4c52cd24 = 1;
            }
        }
        arrayremovevalue(level.var_2b36f9ae.var_a3ead99e, cluster);
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x0
// Checksum 0xb2bcb087, Offset: 0x1970
// Size: 0x16
function function_3421ef1f(cluster) {
    cluster.script_start_disabled = undefined;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x1 linked
// Checksum 0x1b4f4806, Offset: 0x1990
// Size: 0x34
function function_94825461(cluster) {
    cluster.script_start_disabled = 1;
    function_411a4fc8(cluster, 1);
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 2, eflags: 0x1 linked
// Checksum 0x41517b3c, Offset: 0x19d0
// Size: 0x108
function function_e3a05cb9(origin, radius) {
    if (!isdefined(level.var_2b36f9ae.clusters)) {
        return;
    }
    level flag::wait_till(#"hash_408fb58a3f3c6243");
    clusters = arraysortclosest(level.var_2b36f9ae.clusters, origin, undefined, 0, radius);
    foreach (cluster in clusters) {
        function_94825461(cluster);
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x1 linked
// Checksum 0x1086bb29, Offset: 0x1ae0
// Size: 0x16
function function_660e8304(cluster) {
    cluster.paused = undefined;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x1 linked
// Checksum 0xf4d7de41, Offset: 0x1b00
// Size: 0x1a
function function_aaf493fe(cluster) {
    cluster.paused = 1;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 3, eflags: 0x0
// Checksum 0x11f87058, Offset: 0x1b28
// Size: 0x120
function function_c5867c46(origin, radius, paused) {
    if (!isdefined(level.var_2b36f9ae.clusters)) {
        return;
    }
    clusters = arraysortclosest(level.var_2b36f9ae.clusters, origin, undefined, 0, radius);
    foreach (cluster in clusters) {
        if (is_true(paused)) {
            function_aaf493fe(cluster);
            continue;
        }
        function_660e8304(cluster);
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 0, eflags: 0x0
// Checksum 0x251e2d78, Offset: 0x1c50
// Size: 0x35c
function function_2d88e8c3() {
    if (!isdefined(level.var_2b36f9ae) || !isdefined(level.var_2b36f9ae.var_a3ead99e) || !level.var_2b36f9ae.var_a3ead99e.size) {
        return false;
    }
    var_808239f1 = [];
    foreach (cluster in level.var_2b36f9ae.var_a3ead99e) {
        foreach (ai in cluster.var_743c45a5) {
            if (!isalive(ai) || is_true(ai.var_4c52cd24) || is_true(ai.var_4df707f6)) {
                continue;
            }
            var_808239f1[var_808239f1.size] = ai;
        }
    }
    if (var_808239f1.size == 0) {
        return false;
    }
    max_dist = 0;
    var_202d087b = undefined;
    players = getplayers();
    foreach (player in players) {
        if (player.sessionstate === "spectator") {
            continue;
        }
        var_3817a6b3 = arraygetfarthest(player.origin, var_808239f1);
        closest_player = arraygetclosest(var_3817a6b3.origin, players);
        dist = distancesquared(closest_player.origin, var_3817a6b3.origin);
        if (max_dist < dist) {
            max_dist = dist;
            var_202d087b = var_3817a6b3;
        }
    }
    if (!isdefined(var_202d087b)) {
        var_202d087b = array::random(var_808239f1);
    }
    if (isdefined(var_202d087b)) {
        cleanup_ai(var_202d087b);
        return true;
    }
    return false;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x1 linked
// Checksum 0x65d28443, Offset: 0x1fb8
// Size: 0x3e
function function_855c828f(difficulty) {
    if (!isdefined(level.var_2b36f9ae)) {
        level.var_2b36f9ae = {};
    }
    level.var_2b36f9ae.difficulty = difficulty;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 2, eflags: 0x0
// Checksum 0x5236e1eb, Offset: 0x2000
// Size: 0x42
function function_70ebc098(cluster, realm) {
    if (!isdefined(cluster.var_ad4da806)) {
        cluster.var_ad4da806 = cluster.tier;
    }
    cluster.tier = realm;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x0
// Checksum 0xbed9c74a, Offset: 0x2050
// Size: 0x5a
function function_3fd807b8(cluster) {
    assert(isdefined(cluster.var_ad4da806), "<dev string:x1dd>");
    cluster.tier = cluster.var_ad4da806;
    cluster.var_ad4da806 = undefined;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 10, eflags: 0x1 linked
// Checksum 0x63db472f, Offset: 0x20b8
// Size: 0x164
function function_104e0ed7(scriptbundlename, origin, angles, radius = 6000, height = 1024, var_9b178666 = 256, var_48d0f926 = 128, var_19e89e4e = undefined, var_81314a61 = 0, var_499035e2 = 0) {
    return {#scriptbundlename:scriptbundlename, #origin:origin, #angles:angles, #radius:radius, #height:height, #var_19e89e4e:var_19e89e4e, #var_9b178666:var_9b178666, #var_48d0f926:var_48d0f926, #var_81314a61:var_81314a61, #var_499035e2:var_499035e2};
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x1 linked
// Checksum 0xadeba0da, Offset: 0x2228
// Size: 0x70
function function_8844b193(var_76dffad4) {
    assert(isdefined(var_76dffad4) && !is_true(var_76dffad4.var_45d1a7df));
    level.var_2b36f9ae.clusters[level.var_2b36f9ae.clusters.size] = var_76dffad4;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x5 linked
// Checksum 0xcc6c62b7, Offset: 0x22a0
// Size: 0x2c
function private cleanup_ai(ai) {
    ai callback::callback(#"hash_10ab46b52df7967a");
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 2, eflags: 0x1 linked
// Checksum 0x1a68efce, Offset: 0x22d8
// Size: 0x68
function function_d551eaac(cluster, spawn_point) {
    if (isdefined(cluster.origin)) {
        return (cluster.origin + (isvec(spawn_point) ? spawn_point : spawn_point.offset));
    }
    return spawn_point.origin;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x0
// Checksum 0xb596df51, Offset: 0x2348
// Size: 0x9a
function function_7acda77b(cluster) {
    if (isdefined(cluster.var_d0d52561) && isdefined(cluster.var_f7b2a090) && cluster.var_d0d52561 < cluster.var_f7b2a090) {
        wander_radius = randomfloatrange(cluster.var_d0d52561, cluster.var_f7b2a090);
    } else {
        wander_radius = cluster.wander_radius;
    }
    return isdefined(wander_radius) ? wander_radius : 128;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 2, eflags: 0x5 linked
// Checksum 0x899b5105, Offset: 0x23f0
// Size: 0x324
function private spawn_aitype(spawn_info, cluster) {
    if (cluster.var_743c45a5.size < cluster.var_1fb426c4 && cluster.spawn_points.size > 0) {
        spawn_point = function_89116a1e(spawn_info.var_990b33df, cluster);
        if (!isdefined(spawn_point)) {
            return false;
        }
        spawn_point_origin = function_d551eaac(cluster, spawn_point);
        if (function_99f98cdb(cluster) || function_58335fa3(cluster)) {
            if (is_true(cluster.var_19e89e4e)) {
                point = namespace_85745671::function_5f4ef4d0(cluster.origin, cluster.angles, (spawn_point[0], spawn_point[1], cluster.var_48d0f926), cluster.var_499035e2, cluster.var_81314a61, cluster.var_48d0f926);
            } else {
                point = namespace_85745671::function_6b273d22(cluster.origin, (spawn_point[0], spawn_point[1], cluster.var_48d0f926), cluster.var_9b178666, cluster.var_eadf44e7);
            }
            if (!isdefined(point)) {
                return false;
            }
            spawn_point_origin = point;
        }
        if (isvec(spawn_point)) {
            angles = (0, spawn_point[1], 0);
        } else {
            angles = (0, spawn_point.offset[1], 0);
        }
        assert(function_e949cfd7(spawn_info.var_990b33df));
        var_944250d2 = spawnactor(spawn_info.var_990b33df, spawn_point_origin, angles);
        if (isdefined(var_944250d2)) {
            var_944250d2 callback::function_d8abfc3d(#"on_ai_killed", &function_1ac9da1f, cluster);
            cluster.var_743c45a5[cluster.var_743c45a5.size] = var_944250d2;
            cluster.var_c0bddfa9 = cluster.var_abf4838d - cluster.var_2b1e932c - cluster.var_743c45a5.size;
            var_944250d2.cluster = cluster;
            var_944250d2.spawn_point = spawn_point;
            var_944250d2.list_name = spawn_info.list_name;
            function_3bb6e8c8(cluster, spawn_info.list_name);
            return true;
        }
    }
    return false;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 2, eflags: 0x5 linked
// Checksum 0x99b10a7d, Offset: 0x2720
// Size: 0x14c
function private function_89116a1e(aitype, cluster) {
    var_abb67865 = [];
    for (i = 0; i < cluster.spawn_points.size; i++) {
        index = (i + cluster.spawn_point_index) % cluster.spawn_points.size;
        spawn_point = cluster.spawn_points[index];
        if (getplayers(undefined, function_d551eaac(cluster, spawn_point), 512).size) {
            continue;
        }
        if (isvec(spawn_point) || !isdefined(spawn_point.aitype) || spawn_point.aitype === aitype) {
            cluster.spawn_point_index = (index + 1) % cluster.spawn_points.size;
            return spawn_point;
        }
        var_abb67865[var_abb67865.size] = spawn_point;
    }
    if (var_abb67865.size) {
        return array::random(var_abb67865);
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x5 linked
// Checksum 0xe285bb69, Offset: 0x2878
// Size: 0x12c
function private function_29ff63fa(cluster) {
    var_653002ff = getscriptbundle(cluster.scriptbundlename);
    if (isdefined(var_653002ff.var_fc18097c[cluster.tier].var_210a8489)) {
        spawn_info = namespace_679a22ba::function_ca209564(var_653002ff.var_fc18097c[cluster.tier].var_210a8489, cluster.var_a1c6a560[cluster.tier]);
    }
    if (isdefined(spawn_info.var_990b33df)) {
        return spawn_info;
    }
    if (isdefined(var_653002ff.var_fc18097c[cluster.tier].var_4af2c07b)) {
        spawn_info = namespace_679a22ba::function_ca209564(var_653002ff.var_fc18097c[cluster.tier].var_4af2c07b);
    }
    if (isdefined(spawn_info.var_990b33df)) {
        return spawn_info;
    }
    return {#var_990b33df:level.var_2b36f9ae.var_a6a3aad1};
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 2, eflags: 0x5 linked
// Checksum 0x3a0543be, Offset: 0x29b0
// Size: 0x44
function private function_3bb6e8c8(cluster, list_name) {
    if (isdefined(list_name)) {
        namespace_679a22ba::function_266ee075(list_name, cluster.var_a1c6a560[cluster.tier]);
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 2, eflags: 0x5 linked
// Checksum 0xe80329d0, Offset: 0x2a00
// Size: 0x44
function private function_b93e8a0b(cluster, list_name) {
    if (isdefined(list_name)) {
        namespace_679a22ba::function_898aced0(list_name, cluster.var_a1c6a560[cluster.tier]);
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 2, eflags: 0x5 linked
// Checksum 0x5e38b8c5, Offset: 0x2a50
// Size: 0xf6
function private function_1ac9da1f(ai, params) {
    if (!isinarray(level.var_2b36f9ae.var_179ada5f, self)) {
        level.var_2b36f9ae.var_179ada5f[level.var_2b36f9ae.var_179ada5f.size] = self;
    }
    if (!isplayer(params.eattacker) && !is_true(ai.var_7a68cd0c)) {
        function_b93e8a0b(self, ai.list_name);
        return;
    }
    self.var_2b1e932c++;
    self.var_8152d04 = self.var_abf4838d <= self.var_2b1e932c;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x4
// Checksum 0x7303ca75, Offset: 0x2b50
// Size: 0x5e
function private function_2a0cb819(cluster) {
    var_c0bddfa9 = cluster.var_abf4838d - cluster.var_2b1e932c - cluster.var_743c45a5.size;
    return cluster.var_743c45a5.size < cluster.var_1fb426c4 && var_c0bddfa9 > 0;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x5 linked
// Checksum 0xa28460c8, Offset: 0x2bb8
// Size: 0xa2
function private function_8948d10(player) {
    if (player isinvehicle()) {
        velocity = player getvehicleoccupied() getvelocity();
    } else {
        velocity = player getvelocity();
    }
    return int(1024 + length(velocity) * 2);
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x5 linked
// Checksum 0x6ad9edfe, Offset: 0x2c68
// Size: 0x10
function private function_6d373ef8(*player) {
    return 64;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x5 linked
// Checksum 0xc2d05a57, Offset: 0x2c80
// Size: 0x82
function private function_b5c91b37(player) {
    if (player isinvehicle()) {
        velocity = player getvehicleoccupied() getvelocity();
    } else {
        velocity = player getvelocity();
    }
    return player.origin + velocity * 5;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 0, eflags: 0x0
// Checksum 0x2535a49b, Offset: 0x2d10
// Size: 0x148
function function_cb67cef1() {
    level endon(#"game_ended");
    level flag::wait_till(#"hash_408fb58a3f3c6243");
    if (level.var_2b36f9ae.clusters.size > 0) {
        level thread function_71a3d3f7();
        level thread function_48928d63();
        level thread function_9f1e2f6d();
        foreach (cluster in level.var_2b36f9ae.clusters) {
            if (is_true(cluster.var_ee103c26)) {
                function_5f30b11c(cluster);
            }
        }
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 0, eflags: 0x5 linked
// Checksum 0xc19cb003, Offset: 0x2e60
// Size: 0x648
function private function_71a3d3f7() {
    level endon(#"game_ended");
    while (true) {
        waitframe(1);
        foreach (cluster in level.var_2b36f9ae.var_179ada5f) {
            function_1eaaceab(cluster.var_743c45a5);
            arrayremovevalue(cluster.var_743c45a5, undefined);
            cluster.var_c0bddfa9 = cluster.var_abf4838d - cluster.var_2b1e932c - cluster.var_743c45a5.size;
        }
        level.var_2b36f9ae.var_179ada5f = [];
        var_5502295b = function_8af8f660();
        level.var_2b36f9ae.var_a3ead99e = arraysortclosest(level.var_2b36f9ae.var_a3ead99e, var_5502295b);
        var_5a27f21f = [];
        waitframe(1);
        if (!level flag::get(#"objective_locked")) {
            foreach (player in getplayers()) {
                if (!isdefined(player)) {
                    continue;
                }
                if (player.sessionstate === "spectator") {
                    continue;
                }
                var_d8ce746b = function_8948d10(player);
                var_c01dbc61 = function_6d373ef8(player);
                var_50977866 = function_b5c91b37(player);
                var_4665b016 = max(var_d8ce746b, var_c01dbc61);
                var_d34e197c = arraysortclosest(level.var_2b36f9ae.clusters, var_50977866, undefined, 0, var_4665b016 + level.var_2b36f9ae.var_367330c0);
                waitframe(1);
                foreach (index, cluster in var_d34e197c) {
                    if ((index + 1) % 12 == 0) {
                        waitframe(1);
                    }
                    if (!isdefined(player)) {
                        break;
                    }
                    if (!is_true(cluster.script_start_disabled) && !cluster.var_8152d04 && distance2dsquared(cluster.origin, player.origin) <= function_a3f6cdac(cluster.radius + var_d8ce746b) && abs(cluster.origin[2] - player.origin[2]) < cluster.height + var_c01dbc61) {
                        if ((cluster.status === 1 || cluster.status === 2) && level.var_2b36f9ae.var_a3ead99e.size && cluster === level.var_2b36f9ae.var_a3ead99e[level.var_2b36f9ae.var_a3ead99e.size - 1] && getaicount() > int(getailimit() * 0.8)) {
                            continue;
                        }
                        function_7ff205c5(cluster, var_5a27f21f);
                    }
                }
                waitframe(1);
            }
            waitframe(1);
        }
        foreach (cluster in level.var_2b36f9ae.var_a3ead99e) {
            if (level flag::get(#"objective_locked") || !isinarray(var_5a27f21f, cluster)) {
                function_411a4fc8(cluster);
            }
        }
        level.var_2b36f9ae.var_a3ead99e = var_5a27f21f;
        level flag::wait_till_clear(#"objective_locked");
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 0, eflags: 0x5 linked
// Checksum 0x5ce6c1a3, Offset: 0x34b0
// Size: 0x54a
function private function_48928d63() {
    level endon(#"game_ended");
    while (true) {
        time = gettime();
        var_13c3b876 = [];
        var_ef192f84 = getaicount() >= getailimit();
        foreach (index, cluster in level.var_2b36f9ae.var_a3ead99e) {
            if (!is_true(cluster.paused) && cluster.var_743c45a5.size < cluster.var_1fb426c4 && cluster.var_c0bddfa9 && !var_ef192f84) {
                aitype = function_29ff63fa(cluster);
                var_ef192f84 = spawn_aitype(aitype, cluster);
            }
            if (var_ef192f84) {
                break;
            }
            if (index + 1 == 0) {
                waitframe(1);
            }
        }
        waitframe(1);
        foreach (index, cluster in level.var_2b36f9ae.var_f48fec1b) {
            while (cluster.var_52c3894a < time) {
                cluster.var_7303b52f++;
                foreach (ai in cluster.var_743c45a5) {
                    if (isalive(ai) && !is_true(ai.var_4c52cd24) && !is_true(ai.var_972b23bb)) {
                        cleanup_ai(ai);
                        ai.var_4c52cd24 = 1;
                        break;
                    }
                }
                cluster.var_52c3894a = cluster.var_cd6724f6 + int(1 / cluster.var_1fb426c4 * 1000) * cluster.var_7303b52f;
            }
            if (cluster.var_cd6724f6 + int(1 * 1000) <= time) {
                cluster.status = 0;
                var_13c3b876[var_13c3b876.size] = cluster;
                foreach (ai in cluster.var_743c45a5) {
                    if (isalive(ai) && !is_true(ai.var_4c52cd24) && !is_true(ai.var_972b23bb)) {
                        cleanup_ai(ai);
                        ai.var_4c52cd24 = 1;
                    }
                }
            }
            if (index + 1 == 0) {
                waitframe(1);
            }
        }
        foreach (cluster in var_13c3b876) {
            arrayremovevalue(level.var_2b36f9ae.var_a3ead99e, cluster);
            arrayremovevalue(level.var_2b36f9ae.var_f48fec1b, cluster);
        }
        waitframe(1);
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 0, eflags: 0x5 linked
// Checksum 0x82c3ac2f, Offset: 0x3a08
// Size: 0xf2
function private function_8af8f660() {
    var_657dc854 = (0, 0, 0);
    a_players = getplayers();
    foreach (player in a_players) {
        if (player.sessionstate === "spectator") {
            continue;
        }
        var_657dc854 += function_b5c91b37(player);
    }
    if (a_players.size > 1) {
        var_657dc854 /= a_players.size;
    }
    return var_657dc854;
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x1 linked
// Checksum 0x9f1755e3, Offset: 0x3b08
// Size: 0xe2
function function_5f30b11c(cluster) {
    if (!isstruct(cluster)) {
        cluster = struct::get(cluster);
    }
    if (isdefined(cluster.var_a3ead2f) && isdefined(cluster.next_goal) && isdefined(cluster.move_speed) && isdefined(cluster.var_c3467a5d) && !isinarray(level.var_2b36f9ae.var_f46a3413, cluster)) {
        level.var_2b36f9ae.var_f46a3413[level.var_2b36f9ae.var_f46a3413.size] = cluster;
        cluster.var_f6738cdd = 1;
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x1 linked
// Checksum 0xf9bbb5f1, Offset: 0x3bf8
// Size: 0x44
function function_99f98cdb(cluster) {
    return !isdefined(cluster.next_move_time) && isinarray(level.var_2b36f9ae.var_f46a3413, cluster);
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x1 linked
// Checksum 0xb9f7ce00, Offset: 0x3c48
// Size: 0x22
function function_58335fa3(cluster) {
    return is_true(cluster.var_f6738cdd);
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 1, eflags: 0x1 linked
// Checksum 0x60f4d245, Offset: 0x3c78
// Size: 0x64
function function_81e5cd2b(cluster) {
    if (!isstruct(cluster)) {
        cluster = struct::get(cluster);
    }
    arrayremovevalue(level.var_2b36f9ae.var_f46a3413, cluster);
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 0, eflags: 0x5 linked
// Checksum 0xe99f8fec, Offset: 0x3ce8
// Size: 0x3e4
function private function_9f1e2f6d() {
    level endon(#"game_ended");
    while (true) {
        waitframe(1);
        time = gettime();
        var_a4d3f176 = [];
        foreach (cluster in level.var_2b36f9ae.var_f46a3413) {
            if (isdefined(cluster.next_move_time) && time < cluster.next_move_time) {
                continue;
            }
            if (isdefined(cluster.var_a3ead2f) && isdefined(cluster.next_goal) && isdefined(cluster.move_speed) && isdefined(cluster.var_c3467a5d)) {
                var_bfc7faf6 = distancesquared(cluster.next_goal.origin, cluster.origin);
                if (var_bfc7faf6 < function_a3f6cdac(cluster.move_speed)) {
                    cluster.origin = cluster.next_goal.origin;
                    if (!isdefined(cluster.next_move_time) && isdefined(cluster.next_goal.wait_time)) {
                        wait_time = int(float(cluster.next_goal.wait_time) * 1000);
                        cluster.next_move_time = time + wait_time;
                        continue;
                    } else {
                        cluster.next_move_time = undefined;
                    }
                    if (!isdefined(cluster.next_goal.target)) {
                        var_a4d3f176[var_a4d3f176.size] = cluster;
                        continue;
                    }
                    var_32171a69 = getnode(cluster.next_goal.target, "targetname");
                    if (!isdefined(var_32171a69)) {
                        var_32171a69 = struct::get(cluster.next_goal.target, "targetname");
                    }
                    assert(isdefined(var_32171a69));
                    cluster.var_a3ead2f = cluster.next_goal;
                    cluster.next_goal = var_32171a69;
                    cluster.var_c3467a5d = vectornormalize(cluster.next_goal.origin - cluster.var_a3ead2f.origin);
                    continue;
                }
                velocity = cluster.var_c3467a5d * cluster.move_speed;
                cluster.origin += velocity;
            }
        }
        foreach (cluster in var_a4d3f176) {
            function_81e5cd2b(cluster);
        }
    }
}

// Namespace namespace_60c38ce9/namespace_c7495ae4
// Params 0, eflags: 0x0
// Checksum 0x6b26f50e, Offset: 0x40d8
// Size: 0x19e
function function_7cd867b() {
    foreach (var_7ebc9406 in level.var_2b36f9ae.clusters) {
        var_7ebc9406.var_2b1e932c = 0;
        var_7ebc9406.var_c0bddfa9 = var_7ebc9406.var_abf4838d - var_7ebc9406.var_2b1e932c;
        var_7ebc9406.var_8152d04 = 0;
        foreach (var_6975951a in var_7ebc9406.var_a1c6a560) {
            foreach (ai_list in var_6975951a.var_7c88c117) {
                ai_list.spawned = 0;
            }
        }
    }
}

/#

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 0, eflags: 0x0
    // Checksum 0x1b06477c, Offset: 0x4280
    // Size: 0x2b4
    function function_fe4932a1() {
        level endon(#"game_ended");
        if (level.var_2b36f9ae.clusters.size > 0) {
            callback::on_connect(&on_player_connect);
        }
        while (!canadddebugcommand()) {
            waitframe(1);
        }
        adddebugcommand("<dev string:x229>");
        adddebugcommand("<dev string:x24c>");
        adddebugcommand("<dev string:x27f>");
        adddebugcommand("<dev string:x2ae>");
        adddebugcommand("<dev string:x2d3>");
        adddebugcommand("<dev string:x306>");
        adddebugcommand("<dev string:x338>");
        adddebugcommand("<dev string:x375>");
        adddebugcommand("<dev string:x3c1>");
        adddebugcommand("<dev string:x422>");
        adddebugcommand("<dev string:x477>");
        adddebugcommand("<dev string:x4f9>");
        adddebugcommand("<dev string:x571>");
        adddebugcommand("<dev string:x5e5>");
        adddebugcommand("<dev string:x664>");
        adddebugcommand("<dev string:x6e3>");
        adddebugcommand("<dev string:x75f>");
        adddebugcommand("<dev string:x7d2>");
        adddebugcommand("<dev string:x85d>");
        adddebugcommand("<dev string:x8b1>");
        adddebugcommand("<dev string:x909>");
        adddebugcommand("<dev string:x9ad>");
        adddebugcommand("<dev string:xa53>");
        adddebugcommand("<dev string:xadf>");
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 0, eflags: 0x0
    // Checksum 0x2a10dcc5, Offset: 0x4540
    // Size: 0x34
    function on_player_connect() {
        if (self ishost()) {
            self thread function_7167563b();
        }
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 0, eflags: 0x0
    // Checksum 0x265d7e17, Offset: 0x4580
    // Size: 0x4ba
    function function_88dbe5f3() {
        var_f7b072d1 = getdvarstring(#"hash_4df49ceee95e62d1", "<dev string:xb59>");
        setdvar(#"hash_4df49ceee95e62d1", "<dev string:xb59>");
        if (var_f7b072d1 == "<dev string:xb59>") {
            return;
        }
        tokens = strtok(var_f7b072d1, "<dev string:xb5d>");
        cmd = tokens[0];
        switch (cmd) {
        case #"show_help":
            level.var_2b36f9ae.debug_info.show_help = !is_true(level.var_2b36f9ae.debug_info.show_help);
            break;
        case #"hash_3773555d783dd227":
            level.var_2b36f9ae.debug_info.var_15399312 = !is_true(level.var_2b36f9ae.debug_info.var_15399312);
            break;
        case #"hash_9980be38b90805c":
            level.var_2b36f9ae.debug_info.var_5ff49272 = !is_true(level.var_2b36f9ae.debug_info.var_5ff49272);
            break;
        case #"hash_3c1cae46e431c8b":
            level.var_2b36f9ae.debug_info.var_a7b33bcc = !is_true(level.var_2b36f9ae.debug_info.var_a7b33bcc);
            break;
        case #"hash_5d466507c2c2ef3a":
            level.var_2b36f9ae.debug_info.var_6df6d63b = !is_true(level.var_2b36f9ae.debug_info.var_6df6d63b);
            break;
        case #"hash_567068834c1a538a":
            level.var_2b36f9ae.debug_info.var_c7b4e621 = !is_true(level.var_2b36f9ae.debug_info.var_c7b4e621);
            break;
        case #"hash_f4658b8a001728b":
            level.var_2b36f9ae.debug_info.var_952b6009 = !is_true(level.var_2b36f9ae.debug_info.var_952b6009);
            break;
        case #"hash_1a1487eb4d06d478":
            level.var_2b36f9ae.debug_info.var_2856b91 = !is_true(level.var_2b36f9ae.debug_info.var_2856b91);
            break;
        case #"hash_277f15acf5b11f6a":
            level.var_2b36f9ae.debug_info.var_2e5d03bc = !is_true(level.var_2b36f9ae.debug_info.var_2e5d03bc);
            break;
        case #"hash_7711f3dcdebf900c":
            if (!isdefined(level.var_2b36f9ae.debug_info.var_978f5059)) {
                level.var_2b36f9ae.debug_info.var_952b6009 = 1;
                function_8d3eba05();
            } else {
                level.var_2b36f9ae.debug_info.var_952b6009 = !is_true(level.var_2b36f9ae.debug_info.var_952b6009);
            }
            level.var_2b36f9ae.debug_info.var_2f28be27 = level.var_2b36f9ae.debug_info.var_952b6009;
            break;
        }
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 0, eflags: 0x4
    // Checksum 0x830cb424, Offset: 0x4a48
    // Size: 0x180
    function private function_8d3eba05() {
        level.var_2b36f9ae.debug_info.var_978f5059 = 1;
        if (!isdefined(level.var_2b36f9ae.var_a9bdfe7)) {
            return;
        }
        foreach (cluster in level.var_2b36f9ae.var_a9bdfe7) {
            foreach (index, spawn_point in cluster.spawn_points) {
                if (isvec(spawn_point)) {
                    cluster.spawn_points[index] = undefined;
                }
            }
            arrayremovevalue(cluster.spawn_points, undefined);
            function_3bdf488(cluster);
        }
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 0, eflags: 0x4
    // Checksum 0x1908ec97, Offset: 0x4bd0
    // Size: 0x8a4
    function private function_7167563b() {
        self endon(#"disconnect");
        self.var_757a1b3d = [];
        var_2715b4f = is_true(level.var_2b36f9ae.debug_info.var_15399312);
        while (true) {
            waitframe(1);
            if (var_2715b4f != is_true(level.var_2b36f9ae.debug_info.var_15399312)) {
                foreach (cluster in level.var_2b36f9ae.clusters) {
                    if (is_true(level.var_2b36f9ae.debug_info.var_15399312)) {
                        function_94825461(cluster);
                        continue;
                    }
                    function_3421ef1f(cluster);
                }
            }
            var_2715b4f = is_true(level.var_2b36f9ae.debug_info.var_15399312);
            if (getdvarstring(#"hash_c8bfb7e63cf0d50", "<dev string:xb59>") != "<dev string:xb59>" && getdvarstring(#"hash_c8bfb7e63cf0d50", "<dev string:xb59>") != "<dev string:xb62>") {
                level.var_2b36f9ae.var_a6a3aad1 = getdvarstring(#"hash_c8bfb7e63cf0d50", "<dev string:xb73>");
                setdvar(#"hash_c8bfb7e63cf0d50", "<dev string:xb59>");
            }
            function_88dbe5f3();
            if (!getdvarint(#"hash_13c7553398a980f6", 0)) {
                if (is_true(self.var_d1628c28)) {
                    self notify(#"hash_b56a06f36c48331");
                }
                continue;
            }
            self function_61470747();
            if (is_true(level.var_2b36f9ae.debug_info.var_c7b4e621)) {
                self function_c090e608();
            }
            player_origin = self.origin;
            if (getdvarint(#"hash_13c7553398a980f6", 0) == 2) {
                direction = self getplayerangles();
                direction_vec = anglestoforward(direction);
                eye = self geteye();
                scale = 20000;
                direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
                trace = bullettrace(eye, eye + direction_vec, 0, undefined);
                circle(trace[#"position"], 16, (1, 0.5, 0), 1, 1, 1);
                debugstar(trace[#"position"], 1, (1, 0.5, 0));
                player_origin = trace[#"position"];
                foreach (cluster in level.var_2b36f9ae.clusters) {
                    debugstar(cluster.origin, 1, (1, 0, 0));
                }
            }
            if (!is_true(self.var_d1628c28)) {
                self thread function_d1628c28();
            }
            max_count = getdvarint(#"hash_363ae431c06be84b", 0);
            var_4701a47f = self.var_757a1b3d;
            if (!isdefined(self.var_757a1b3d) || !is_true(self.var_ef2d10a5)) {
                var_4701a47f = arraysortclosest(level.var_2b36f9ae.clusters, player_origin, 100, 0, getdvarint(#"hash_2a5203320297118b", 1000));
            }
            var_f072093e = [];
            foreach (index, cluster in var_4701a47f) {
                if (index + 1 <= max_count) {
                    var_f072093e[var_f072093e.size] = cluster;
                    function_ab9a7955(cluster, self);
                    continue;
                }
                function_e27fc1d6(cluster);
            }
            self.var_757a1b3d = var_f072093e;
            if (is_true(level.var_2b36f9ae.debug_info.var_952b6009) && isdefined(level.var_2b36f9ae.var_a9bdfe7)) {
                foreach (cluster in level.var_2b36f9ae.var_a9bdfe7) {
                    print3d(cluster.origin, "<dev string:xb8c>", (1, 0, 0), 1, 5, 1);
                    if (cluster.height > 0 && cluster.radius > 0) {
                        function_59a41525(cluster.origin, cluster.radius, cluster.height, (1, 0, 0), 1);
                        if (is_true(level.var_2b36f9ae.debug_info.var_2f28be27) && isdefined(cluster.var_2646f9a2)) {
                            function_b65c0fb5(cluster, cluster.var_2646f9a2);
                        }
                    }
                }
            }
        }
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 1, eflags: 0x0
    // Checksum 0x50d1ce59, Offset: 0x5480
    // Size: 0x22
    function function_f65c276a(*notifyhash) {
        self.var_ef2d10a5 = undefined;
        self.var_d1628c28 = undefined;
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 0, eflags: 0x0
    // Checksum 0xa88712db, Offset: 0x54b0
    // Size: 0xb2
    function function_d1628c28() {
        self endoncallback(&function_f65c276a, #"disconnect", #"hash_b56a06f36c48331");
        self.var_d1628c28 = 1;
        while (true) {
            self util::waittill_use_button_pressed();
            while (self usebuttonpressed()) {
                waitframe(1);
            }
            self.var_ef2d10a5 = !is_true(self.var_ef2d10a5);
        }
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 1, eflags: 0x0
    // Checksum 0xab539591, Offset: 0x5570
    // Size: 0xbc
    function function_e27fc1d6(cluster) {
        color = (1, 0, 0);
        if (cluster.status == 1) {
            color = (0, 1, 0);
        } else if (cluster.status == 2) {
            color = (1, 0.5, 0);
        }
        line(cluster.origin, cluster.origin + (0, 0, 300), color, 0.8, 1, 1);
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 2, eflags: 0x0
    // Checksum 0xf91a6a36, Offset: 0x5638
    // Size: 0x120
    function function_b65c0fb5(cluster, &list) {
        foreach (spawn_point in list) {
            color = (0, 0, 1);
            if (isstruct(spawn_point)) {
                color = (1, 0, 1);
            }
            debugstar(function_d551eaac(cluster, spawn_point), 1, color);
            line(cluster.origin, function_d551eaac(cluster, spawn_point), color, 1, 0, 1);
        }
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 5, eflags: 0x0
    // Checksum 0x6306a2ce, Offset: 0x5760
    // Size: 0xb4
    function function_59a41525(origin, radius, height, color, depthtest) {
        circle(origin, radius, color, depthtest, 1, 1);
        circle(origin + (0, 0, height), radius, color, depthtest, 1, 1);
        line(origin, origin + (0, 0, height), color, 1, depthtest, 1);
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 8, eflags: 0x0
    // Checksum 0x7517ee78, Offset: 0x5820
    // Size: 0x190
    function function_eeec418e(cluster, status, bundle, list_name, var_946093a5, index, alpha, scale) {
        for (i = cluster.var_a1c6a560.size - 1; i >= 0; i--) {
            if (!isdefined(bundle.var_fc18097c[i].(list_name))) {
                continue;
            }
            if (i === cluster.tier) {
                index = function_c8c72eb8(cluster, bundle.var_fc18097c[i].(list_name), var_946093a5, index, alpha, scale);
            }
            color = i === cluster.tier ? (0, 1, 1) : status.color;
            print3d(cluster.origin + (0, 0, index), bundle.var_fc18097c[i].(list_name), color, alpha, scale * 0.65, 1);
            index += 16 * scale * 0.65;
        }
        return index;
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 5, eflags: 0x0
    // Checksum 0x6e10a7a1, Offset: 0x59b8
    // Size: 0xf8
    function function_7347dad5(cluster, status, index, alpha, scale) {
        for (i = cluster.var_a1c6a560.size - 1; i >= 0; i--) {
            print3d(cluster.origin + (0, 0, index), cluster.var_a1c6a560[i].aitype + "<dev string:xb9b>" + cluster.var_a1c6a560[i].count, status.color, alpha, scale * 0.65, 1);
            index += 16 * scale * 0.65;
        }
        return index;
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 2, eflags: 0x0
    // Checksum 0x7d5875dc, Offset: 0x5ab8
    // Size: 0x99c
    function function_ab9a7955(cluster, player) {
        alpha = 1;
        scale = 0.7;
        bundle = getscriptbundle(cluster.scriptbundlename);
        distance = distance(cluster.origin, player.origin);
        if (distance > 400) {
            scale = distance * 0.002;
        }
        status = {#text:"<dev string:xba0>", #color:(1, 0, 0)};
        if (cluster.status == 1) {
            status = {#text:"<dev string:xbac>", #color:(0, 1, 0)};
        } else if (cluster.status == 2) {
            status = {#text:"<dev string:xbb6>" + int(float(cluster.var_cd6724f6 + int(1 * 1000) - gettime()) / 1000), #color:(1, 0.5, 0)};
        }
        if (is_true(level.var_2b36f9ae.debug_info.var_6df6d63b)) {
            function_b65c0fb5(cluster, cluster.spawn_points);
        }
        index = 0;
        print3d(cluster.origin + (0, 0, index), status.text, status.color, alpha, scale * 1, 1);
        index += 16 * scale * 1;
        if (is_true(cluster.paused)) {
            print3d(cluster.origin + (0, 0, index), "<dev string:xbc8>", (0, 1, 1), alpha, scale * 1, 1);
            index += 16 * scale * 1;
        }
        if (is_true(cluster.script_start_disabled)) {
            print3d(cluster.origin + (0, 0, index), "<dev string:xbd2>", (1, 0, 0), alpha, scale * 1, 1);
            index += 16 * scale * 1;
        }
        if (isdefined(cluster.var_95dbbc4c)) {
            print3d(cluster.origin + (0, 0, index), "<dev string:xbde>" + cluster.var_95dbbc4c + "<dev string:xb9b>" + cluster.var_60ec68a2, (1, 0, 1), alpha, scale * 1, 1);
            index += 16 * scale * 1;
        }
        print3d(cluster.origin + (0, 0, index), "<dev string:xbe8>" + cluster.var_743c45a5.size + "<dev string:xbf7>" + cluster.var_1fb426c4, status.color, alpha, scale * 1, 1);
        index += 16 * scale * 1;
        print3d(cluster.origin + (0, 0, index), "<dev string:xbfc>" + cluster.var_2b1e932c + "<dev string:xbf7>" + cluster.var_abf4838d, status.color, alpha, scale * 1, 1);
        index += 16 * scale * 1;
        index += 16 * scale * 0.8;
        if (is_true(level.var_2b36f9ae.debug_info.var_2856b91)) {
            index = function_eeec418e(cluster, status, bundle, "<dev string:xc0d>", 1, index, alpha, scale);
            print3d(cluster.origin + (0, 0, index), "<dev string:xc17>", status.color, alpha, scale * 1, 1);
            index += 16 * scale * 1;
            index += 16 * scale * 0.8;
        }
        if (is_true(level.var_2b36f9ae.debug_info.var_2e5d03bc)) {
            index = function_eeec418e(cluster, status, bundle, "<dev string:xc2b>", 0, index, alpha, scale);
            print3d(cluster.origin + (0, 0, index), "<dev string:xc3c>", status.color, alpha, scale * 1, 1);
            index += 16 * scale * 1;
        }
        foreach (ai in cluster.var_743c45a5) {
            if (isdefined(ai) && isdefined(ai.list_name)) {
                print3d(ai.origin + (0, 0, ai function_6a9ae71() * 1.2), ai.list_name, (1, 0, 1), alpha, 0.5, 1);
            }
        }
        if (cluster.height > 0 && cluster.radius > 0 && is_true(level.var_2b36f9ae.debug_info.var_5ff49272)) {
            function_59a41525(cluster.origin, cluster.radius, cluster.height, status.color, 1);
        }
        if (is_true(level.var_2b36f9ae.debug_info.var_a7b33bcc)) {
            if (!is_true(cluster.var_19e89e4e)) {
                function_59a41525(cluster.origin, cluster.var_9b178666, cluster.var_48d0f926, (1, 1, 0), 1);
            } else {
                mins = (-0.5 * cluster.var_499035e2, -0.5 * cluster.var_81314a61, -0.5 * cluster.var_48d0f926);
                maxs = (0.5 * cluster.var_499035e2, 0.5 * cluster.var_81314a61, 0.5 * cluster.var_48d0f926);
                box(cluster.origin, mins, maxs, cluster.angles, (1, 1, 0));
            }
            if (cluster.status != 1) {
                function_b65c0fb5(cluster, cluster.spawn_points);
            }
        }
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 6, eflags: 0x0
    // Checksum 0xbdf3eb94, Offset: 0x6460
    // Size: 0x264
    function function_c8c72eb8(cluster, var_e98de867, var_946093a5, index, alpha, scale) {
        bundle = getscriptbundle(var_e98de867);
        foreach (var_6158b9ee, entry in bundle.var_210a8489) {
            if (is_true(var_946093a5)) {
                print3d(cluster.origin + (0, 0, index), "<dev string:xc50>" + entry.var_857deb66 + "<dev string:xc57>" + entry.entryname + "<dev string:xb9b>" + namespace_679a22ba::function_c60389b6(cluster.var_a1c6a560[cluster.tier].var_7c88c117[var_6158b9ee], cluster.var_a1c6a560[cluster.tier].var_b0abb10e) + "<dev string:xbf7>" + cluster.var_a1c6a560[cluster.tier].var_7c88c117[var_6158b9ee].var_cffbc08, (1, 1, 0), alpha, scale * 0.65, 1);
                index += 16 * scale * 0.65;
                continue;
            }
            print3d(cluster.origin + (0, 0, index), "<dev string:xc50>" + entry.var_857deb66 + "<dev string:xc57>" + entry.entryname, (1, 1, 0), alpha, scale * 0.65, 1);
            index += 16 * scale * 0.65;
        }
        return index;
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 0, eflags: 0x0
    // Checksum 0x2e10b2c2, Offset: 0x66d0
    // Size: 0x582
    function function_61470747() {
        offset = 75;
        if (!is_true(level.var_2b36f9ae.debug_info.show_help)) {
            debug2dtext((105, offset * 0.85, 0), "<dev string:xc5e>" + (is_true(self.var_ef2d10a5) ? "<dev string:xc74>" : "<dev string:xc80>"), undefined, undefined, undefined, 0.9, 0.85);
            offset += 22;
            return;
        }
        debug2dtext((105, offset * 0.85, 0), "<dev string:xc8e>", undefined, undefined, undefined, 0.9, 0.85);
        offset += 22;
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xc9f>", undefined, undefined, undefined, 0.9, 0.85);
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xcaf>", (1, 0.5, 0), undefined, undefined, 0.9, 0.85);
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xcdb>", (1, 1, 0), undefined, undefined, 0.9, 0.85);
        offset += 22;
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xd07>", undefined, undefined, undefined, 0.9, 0.85);
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xc5e>" + (is_true(self.var_ef2d10a5) ? "<dev string:xc74>" : "<dev string:xc80>"), undefined, undefined, undefined, 0.9, 0.85);
        offset += 22;
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xd44>", undefined, undefined, undefined, 0.9, 0.85);
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xd5d>", (1, 0, 0), undefined, undefined, 0.9, 0.85);
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xd72>", (1, 0.5, 0), undefined, undefined, 0.9, 0.85);
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xd8b>", (0, 1, 0), undefined, undefined, 0.9, 0.85);
        offset += 22;
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xd9e>", undefined, undefined, undefined, 0.9, 0.85);
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xdbb>", (0, 0, 1), undefined, (0.4, 0.4, 0.4), 0.9, 0.85);
        offset += 22;
        debug2dtext((105, offset * 0.85, 0), "<dev string:xdd1>", (1, 0, 1), undefined, undefined, 0.9, 0.85);
        offset += 22;
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 0, eflags: 0x4
    // Checksum 0x4f8ee188, Offset: 0x6c60
    // Size: 0x2e0
    function private function_33526165() {
        foreach (cluster in level.var_2b36f9ae.clusters) {
            function_94825461(cluster);
        }
        wait 5;
        level.var_2b36f9ae.var_2646f9a2 = [];
        foreach (cluster in level.var_2b36f9ae.clusters) {
            foreach (spawn_point in cluster.spawn_points) {
                origin = function_d551eaac(cluster, spawn_point);
                traceresult = physicstrace(origin, origin, (-15, -15, 0), (15, 15, 72));
                if (traceresult[#"fraction"] == 0) {
                    level.var_2b36f9ae.var_2646f9a2[level.var_2b36f9ae.var_2646f9a2.size] = {#cluster:cluster, #spawn_point:spawn_point};
                }
            }
        }
        foreach (cluster in level.var_2b36f9ae.clusters) {
            function_3421ef1f(cluster);
        }
    }

    // Namespace namespace_60c38ce9/namespace_c7495ae4
    // Params 0, eflags: 0x4
    // Checksum 0xb539fb8f, Offset: 0x6f48
    // Size: 0x138
    function private function_c090e608() {
        if (!isdefined(level.var_2b36f9ae.var_2646f9a2)) {
            function_33526165();
        }
        foreach (struct in level.var_2b36f9ae.var_2646f9a2) {
            origin = function_d551eaac(struct.cluster, struct.spawn_point);
            box(origin, (-15, -15, 0), (15, 15, 72), 0, (1, 0, 0));
            line(origin, struct.cluster.origin, (0, 1, 0));
        }
    }

#/
