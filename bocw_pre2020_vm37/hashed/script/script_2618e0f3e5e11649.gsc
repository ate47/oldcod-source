#using script_19367cd29a4485db;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;

#namespace namespace_ce1f29cc;

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0xae4cf0df, Offset: 0x128
// Size: 0x238
function function_6b885d72(destination) {
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        return;
    }
    assert(!isdefined(level.var_f804b293));
    if (!isdefined(level.var_f804b293)) {
        level.var_f804b293 = [];
    }
    if (!isdefined(level.var_3b4ee947)) {
        level.var_3b4ee947 = [];
    }
    if (!isdefined(level.var_39b4b1e2)) {
        level.var_39b4b1e2 = [];
    }
    foreach (s_location in destination.locations) {
        var_f804b293 = struct::get_array(s_location.targetname, "target");
        var_f804b293 = function_7b8e26b3(var_f804b293, "hotzone", "variantname");
        var_f804b293 = function_61f56bb6(var_f804b293);
        foreach (hotzone in var_f804b293) {
            function_4aca4e83(hotzone);
        }
        level.var_f804b293 = arraycombine(level.var_f804b293, var_f804b293, 0, 0);
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x7985b3a7, Offset: 0x368
// Size: 0x246
function function_61f56bb6(var_f804b293) {
    var_be6053fa = [];
    var_c6d0eb25 = [];
    foreach (hotzone in var_f804b293) {
        if (!isdefined(hotzone.var_c43420a)) {
            var_be6053fa[var_be6053fa.size] = hotzone;
            continue;
        }
        if (!isdefined(var_c6d0eb25[hotzone.var_c43420a])) {
            var_c6d0eb25[hotzone.var_c43420a] = [];
        } else if (!isarray(var_c6d0eb25[hotzone.var_c43420a])) {
            var_c6d0eb25[hotzone.var_c43420a] = array(var_c6d0eb25[hotzone.var_c43420a]);
        }
        var_c6d0eb25[hotzone.var_c43420a][var_c6d0eb25[hotzone.var_c43420a].size] = hotzone;
    }
    foreach (group in var_c6d0eb25) {
        group = array::randomize(group);
        var_7e24bb5a = group[0].var_d3455e4;
        assert(var_7e24bb5a <= group.size);
        for (i = 0; i < var_7e24bb5a; i++) {
            var_be6053fa[var_be6053fa.size] = array::pop_front(group, 0);
        }
    }
    return var_be6053fa;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0xb2e8d257, Offset: 0x5b8
// Size: 0x13c
function function_4aca4e83(var_89bd79c0) {
    tunables = getscriptbundle(var_89bd79c0.scriptbundlename);
    var_89bd79c0.instance = {};
    function_8ff3e9d(var_89bd79c0, tunables);
    function_c43e2960(var_89bd79c0, tunables);
    var_89bd79c0.instance.tier = 1;
    var_89bd79c0.instance.var_743c45a5 = [];
    var_89bd79c0.instance.var_4188d7c8 = 0;
    var_89bd79c0.instance.spawned_ai = 0;
    var_89bd79c0.instance.priority = 0;
    var_89bd79c0.instance.var_bb0c9afd = [];
    var_89bd79c0.instance.var_ee69e628 = [];
    var_89bd79c0.instance.var_ac7b2365 = [];
    /#
        var_89bd79c0.instance.priority_debug = [];
    #/
    function_3c977c4f(var_89bd79c0, 0);
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x1 linked
// Checksum 0xa7274852, Offset: 0x700
// Size: 0x72
function function_8ff3e9d(var_89bd79c0, tunables) {
    if (!isdefined(var_89bd79c0.var_117ccd5c)) {
        var_89bd79c0.var_117ccd5c = function_65c306e7(tunables.var_d5ae73b2);
    }
    if (!isdefined(var_89bd79c0.var_192fb9a2)) {
        var_89bd79c0.var_192fb9a2 = function_65c306e7(tunables.var_1d67b7db);
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0xf35ea6d6, Offset: 0x780
// Size: 0x9e
function function_65c306e7(var_71398223) {
    list = [];
    foreach (struct in var_71398223) {
        list[list.size] = struct.var_210a8489;
    }
    return list;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x1 linked
// Checksum 0xcc742736, Offset: 0x828
// Size: 0x54c
function function_c43e2960(var_89bd79c0, tunables) {
    if (isdefined(var_89bd79c0.instance.initial_spawn_points) && isdefined(var_89bd79c0.instance.var_d9c7b945)) {
        return;
    }
    if (!isdefined(var_89bd79c0.var_9b178666)) {
        var_89bd79c0.var_9b178666 = var_89bd79c0.radius;
    }
    spawn_points = struct::get_array(var_89bd79c0.targetname, "target");
    initial_spawn_points = function_7b8e26b3(spawn_points, "hotzone_spawn_point_initial", "variantname");
    function_ba8b8ba3(initial_spawn_points);
    initial_spawn_points = function_3759eaa0(var_89bd79c0, initial_spawn_points, (isdefined(tunables.var_e4de985f) ? tunables.var_e4de985f : 0) + (isdefined(tunables.var_e4de985f) ? tunables.var_e4de985f : 0) * (isdefined(tunables.var_4dc06056) ? tunables.var_4dc06056 : 0) * 3);
    var_d9c7b945 = function_7b8e26b3(spawn_points, "hotzone_spawn_point_hot", "variantname");
    function_ba8b8ba3(var_d9c7b945);
    var_d9c7b945 = function_3759eaa0(var_89bd79c0, var_d9c7b945, isdefined(tunables.var_783fc5e) ? tunables.var_783fc5e : 0);
    var_89bd79c0.instance.initial_spawn_points = array::randomize(initial_spawn_points);
    var_89bd79c0.instance.var_d9c7b945 = array::randomize(var_d9c7b945);
    var_89bd79c0.instance.var_968f26a5 = [];
    foreach (spawn_point in var_89bd79c0.instance.initial_spawn_points) {
        if (isdefined(spawn_point.aitype)) {
            if (!isdefined(var_89bd79c0.instance.var_968f26a5[spawn_point.aitype])) {
                var_89bd79c0.instance.var_968f26a5[spawn_point.aitype] = 0;
            }
        }
    }
    foreach (spawn_point in var_89bd79c0.instance.var_d9c7b945) {
        if (isdefined(spawn_point.aitype)) {
            if (!isdefined(var_89bd79c0.instance.var_968f26a5[spawn_point.aitype])) {
                var_89bd79c0.instance.var_968f26a5[spawn_point.aitype] = 0;
            }
        }
    }
    var_89bd79c0.instance.var_f2be2673 = [];
    foreach (spawn_point in var_89bd79c0.instance.initial_spawn_points) {
        if (isdefined(spawn_point.archetype)) {
            if (!isdefined(var_89bd79c0.instance.var_f2be2673[spawn_point.archetype])) {
                var_89bd79c0.instance.var_f2be2673[spawn_point.archetype] = 0;
            }
        }
    }
    foreach (spawn_point in var_89bd79c0.instance.var_d9c7b945) {
        if (isdefined(spawn_point.archetype)) {
            if (!isdefined(var_89bd79c0.instance.var_f2be2673[spawn_point.archetype])) {
                var_89bd79c0.instance.var_f2be2673[spawn_point.archetype] = 0;
            }
        }
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x5130a39d, Offset: 0xd80
// Size: 0xc6
function function_ba8b8ba3(&spawn_points) {
    foreach (point in spawn_points) {
        if (point.var_90d0c0ff === #" ") {
            point.var_90d0c0ff = undefined;
        }
        if (point.archetype === #" ") {
            point.archetype = undefined;
        }
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 3, eflags: 0x1 linked
// Checksum 0xb89e1b6e, Offset: 0xe50
// Size: 0x102
function function_3759eaa0(var_89bd79c0, var_9b694d6c, var_36a2355b) {
    if (var_9b694d6c.size <= var_36a2355b) {
        if (!is_true(var_89bd79c0.var_19e89e4e)) {
            var_53911b23 = namespace_85745671::function_e4791424(var_89bd79c0.origin, var_36a2355b - var_9b694d6c.size, var_89bd79c0.var_48d0f926, var_89bd79c0.var_9b178666, var_89bd79c0.var_243d78a7, 0, 0);
        } else {
            var_53911b23 = namespace_85745671::function_7a1b21f6(var_89bd79c0.origin, var_89bd79c0.angles, var_36a2355b - var_9b694d6c.size, var_89bd79c0.var_499035e2, var_89bd79c0.var_81314a61, var_89bd79c0.var_48d0f926, 0, 0);
        }
        var_9b694d6c = arraycombine(var_9b694d6c, var_53911b23, 0, 0);
    }
    return var_9b694d6c;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x20f293be, Offset: 0xf60
// Size: 0x1aa
function deactivate_hotzones(destination) {
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        return;
    }
    level notify(#"hash_1a8453d57fb3fe48");
    foreach (s_location in destination.locations) {
        var_f804b293 = struct::get_array(s_location.targetname, "target");
        var_f804b293 = function_7b8e26b3(var_f804b293, "variantname", "hotzone");
        foreach (hotzone in var_f804b293) {
            function_ea2997e4(hotzone);
        }
    }
    level.var_f804b293 = undefined;
    level.var_3b4ee947 = undefined;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x56103e59, Offset: 0x1118
// Size: 0xda
function function_ea2997e4(var_89bd79c0) {
    if (is_true(var_89bd79c0.instance.var_4188d7c8)) {
        function_e5786b9a(var_89bd79c0);
    }
    foreach (ai in var_89bd79c0.instance.var_743c45a5) {
        ai delete();
    }
    var_89bd79c0.instance = undefined;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x1 linked
// Checksum 0xa542b28f, Offset: 0x1200
// Size: 0x1fe
function function_3c977c4f(hotzone, state) {
    if (hotzone.instance.current_state !== state) {
        hotzone.instance.spawn_point_index = 0;
        hotzone.instance.tier = level.var_f534e0;
        /#
            if (getdvarint(#"hash_15ed4f1fab002e20", 0)) {
                hotzone.instance.tier = getdvarint(#"hash_15ed4f1fab002e20", 0);
            }
        #/
        hotzone.instance.var_1fb426c4 = function_e670bffd(hotzone.scriptbundlename, state);
        hotzone.instance.var_735d3a6b = function_d0e4a026(hotzone.scriptbundlename);
        list_name = function_47ae367f(hotzone, hotzone.instance.tier, state);
        if (isdefined(list_name)) {
            if (!isdefined(hotzone.instance.var_bb0c9afd[state])) {
                hotzone.instance.var_bb0c9afd[state] = namespace_679a22ba::function_77be8a83(list_name);
            }
        }
        hotzone.instance.var_d36a24ed = hotzone.instance.var_bb0c9afd[state];
        hotzone.instance.var_98957c00 = undefined;
        if (hotzone.instance.current_state === 2) {
            hotzone.instance.var_ee69e628 = [];
        }
    }
    hotzone.instance.current_state = state;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 0, eflags: 0x0
// Checksum 0x6bc8fb66, Offset: 0x1408
// Size: 0xde
function function_fac3e87c() {
    spawns = [];
    foreach (hotzone in level.var_f804b293) {
        if (!isdefined(hotzone.targetname)) {
            continue;
        }
        spawn_points = struct::get_array(hotzone.targetname, "target");
        spawns = arraycombine(spawn_points, spawns);
    }
    return spawns;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x0
// Checksum 0x86ee359a, Offset: 0x14f0
// Size: 0x130
function function_e24de31c(*params) {
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        return;
    }
    level notify(#"hash_1a8453d57fb3fe48");
    foreach (hotzone in level.var_f804b293) {
        if (is_true(hotzone.instance.var_4188d7c8)) {
            function_e5786b9a(hotzone);
        }
        function_fb4091d0(hotzone);
        function_3c977c4f(hotzone, 3);
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 0, eflags: 0x0
// Checksum 0xc5337af9, Offset: 0x1628
// Size: 0xb8
function function_368a7cde() {
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        return;
    }
    foreach (hotzone in level.var_f804b293) {
        function_87f604a(hotzone);
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x0
// Checksum 0xaba6971c, Offset: 0x16e8
// Size: 0xf0
function function_c981b20b(origin, radius) {
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        return;
    }
    var_ea21a801 = function_72d3bca6(level.var_f804b293, origin, undefined, 0, radius);
    foreach (hotzone in var_ea21a801) {
        function_87f604a(hotzone);
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x1 linked
// Checksum 0x188b9e5, Offset: 0x17e0
// Size: 0x128
function function_12c2f41f(origin, radius) {
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        return;
    }
    level notify(#"hash_1a8453d57fb3fe48");
    var_ea21a801 = function_72d3bca6(level.var_f804b293, origin, undefined, 0, radius);
    foreach (hotzone in var_ea21a801) {
        function_ea2997e4(hotzone);
        arrayremovevalue(level.var_f804b293, hotzone);
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x4d17d81, Offset: 0x1910
// Size: 0x9c
function function_87f604a(hotzone) {
    level notify(#"hash_1a8453d57fb3fe48");
    hotzone.instance.disabled = 1;
    function_3c977c4f(hotzone, 0);
    if (is_true(hotzone.instance.var_4188d7c8)) {
        function_e5786b9a(hotzone);
    }
    function_fb4091d0(hotzone);
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 0, eflags: 0x0
// Checksum 0x4a2bf3ab, Offset: 0x19b8
// Size: 0xb8
function function_fca72198() {
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        return;
    }
    foreach (hotzone in level.var_f804b293) {
        function_33cf33f9(hotzone);
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x0
// Checksum 0x57ce8516, Offset: 0x1a78
// Size: 0xf0
function function_1724f4ac(origin, radius) {
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        return;
    }
    var_ea21a801 = function_72d3bca6(level.var_f804b293, origin, undefined, 0, radius);
    foreach (hotzone in var_ea21a801) {
        function_33cf33f9(hotzone);
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x462fdbab, Offset: 0x1b70
// Size: 0x32
function function_33cf33f9(hotzone) {
    level notify(#"hash_1a8453d57fb3fe48");
    hotzone.instance.disabled = undefined;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x81e2b227, Offset: 0x1bb0
// Size: 0x1c
function function_15bf0b91(tier) {
    level.var_f534e0 = tier;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x1 linked
// Checksum 0x871e0131, Offset: 0x1bd8
// Size: 0x112
function function_e670bffd(var_f4a682a0, state) {
    tunables = getscriptbundle(var_f4a682a0);
    var_1fb426c4 = 0;
    if (state == 1) {
        var_1fb426c4 = namespace_679a22ba::function_b9ea4226(isdefined(tunables.var_e4de985f) ? tunables.var_e4de985f : 0, isdefined(tunables.var_4dc06056) ? tunables.var_4dc06056 : 0);
    } else if (state == 2) {
        var_1fb426c4 = namespace_679a22ba::function_b9ea4226(isdefined(tunables.var_b8fc9deb) ? tunables.var_b8fc9deb : 0, isdefined(tunables.var_a1208a9a) ? tunables.var_a1208a9a : 0);
    }
    return var_1fb426c4;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x6f5f7821, Offset: 0x1cf8
// Size: 0x82
function function_d0e4a026(var_f4a682a0) {
    tunables = getscriptbundle(var_f4a682a0);
    return namespace_679a22ba::function_b9ea4226(isdefined(tunables.var_735d3a6b) ? tunables.var_735d3a6b : 0, isdefined(tunables.var_d961aeb3) ? tunables.var_d961aeb3 : 0);
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 3, eflags: 0x1 linked
// Checksum 0x6adb593e, Offset: 0x1d88
// Size: 0xde
function function_47ae367f(hotzone, tier, state) {
    if (state == 1) {
        index = int(min(hotzone.var_117ccd5c.size - 1, tier - 1));
        return hotzone.var_117ccd5c[index];
    }
    if (state == 2) {
        index = int(min(hotzone.var_192fb9a2.size - 1, tier - 1));
        return hotzone.var_192fb9a2[index];
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x1 linked
// Checksum 0x905fc8c2, Offset: 0x1e70
// Size: 0x58
function function_6d39329f(hotzone, state) {
    if (state == 1) {
        return hotzone.instance.initial_spawn_points;
    }
    if (state == 2) {
        return hotzone.instance.var_d9c7b945;
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 3, eflags: 0x1 linked
// Checksum 0x4e93b9ce, Offset: 0x1ed0
// Size: 0xfa
function function_6b51cc65(&var_e592e473, var_8437e990, aitype) {
    var_2a3ffa2e = function_7b8e26b3(var_e592e473, aitype, "aitype");
    if (var_2a3ffa2e.size) {
        for (i = 0; i < var_2a3ffa2e.size; i++) {
            var_8437e990.var_968f26a5[aitype] = (var_8437e990.var_968f26a5[aitype] + 1) % var_2a3ffa2e.size;
            spawn_point = var_2a3ffa2e[var_8437e990.var_968f26a5[aitype]];
            if (getplayers(undefined, spawn_point.origin, 256).size) {
                continue;
            }
            assert(isdefined(spawn_point));
            return spawn_point;
        }
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 3, eflags: 0x1 linked
// Checksum 0x3cf51103, Offset: 0x1fd8
// Size: 0xfa
function function_1e745fc0(&var_e592e473, var_8437e990, archetype) {
    var_630a610f = function_7b8e26b3(var_e592e473, archetype, "archetype");
    if (var_630a610f.size) {
        for (i = 0; i < var_630a610f.size; i++) {
            var_8437e990.var_f2be2673[archetype] = (var_8437e990.var_f2be2673[archetype] + 1) % var_630a610f.size;
            spawn_point = var_630a610f[var_8437e990.var_f2be2673[archetype]];
            if (getplayers(undefined, spawn_point.origin, 256).size) {
                continue;
            }
            assert(isdefined(spawn_point));
            return spawn_point;
        }
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 3, eflags: 0x1 linked
// Checksum 0x72206539, Offset: 0x20e0
// Size: 0x18a
function function_89116a1e(&var_e592e473, var_8437e990, aitype) {
    if (isdefined(aitype)) {
        spawn_point = function_6b51cc65(var_e592e473, var_8437e990, aitype);
        if (isdefined(spawn_point)) {
            return spawn_point;
        }
        archetype = getarchetypefromclassname(aitype);
        spawn_point = function_1e745fc0(var_e592e473, var_8437e990, archetype);
        if (isdefined(spawn_point)) {
            return spawn_point;
        }
    }
    for (i = 0; i < var_e592e473.size; i++) {
        var_8437e990.spawn_point_index = (var_8437e990.spawn_point_index + 1) % var_e592e473.size;
        spawn_point = var_e592e473[var_8437e990.spawn_point_index];
        if (getplayers(undefined, spawn_point.origin, 256).size || isdefined(aitype) && isdefined(spawn_point.var_90d0c0ff) && !function_ee71d10f(aitype, spawn_point.var_90d0c0ff)) {
            continue;
        }
        assert(isdefined(spawn_point));
        return spawn_point;
    }
    return array::random(var_e592e473);
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x2d432417, Offset: 0x2278
// Size: 0x4ac
function function_ffbebde3(&var_f804b293) {
    level endon(#"hash_1a8453d57fb3fe48");
    /#
        if (is_true(level.var_70da9652.var_780e31de)) {
            return;
        }
    #/
    foreach (hotzone in var_f804b293) {
        hotzone.instance.var_8fa06b8e = 0;
        /#
            hotzone.instance.var_19b23216 = [];
        #/
    }
    players = getplayers();
    fake_players = [];
    foreach (player in players) {
        fake_players[fake_players.size] = {#origin:player.origin, #angles:player.angles};
    }
    foreach (hotzone in var_f804b293) {
        if (hotzone.instance.current_state == 3 || is_true(hotzone.instance.disabled)) {
            continue;
        }
        var_1414fb7f = function_72d3bca6(fake_players, hotzone.origin, undefined, undefined, 10000);
        if (!var_1414fb7f.size) {
            continue;
        }
        proximity = function_3e21a60b(hotzone, var_1414fb7f);
        /#
            hotzone.instance.var_19b23216[#"proximity"] = proximity;
        #/
        hotzone.instance.var_8fa06b8e += proximity;
        facing = function_b6a93fcd(hotzone, var_1414fb7f);
        /#
            hotzone.instance.var_19b23216[#"facing"] = facing;
        #/
        hotzone.instance.var_8fa06b8e += facing;
        state = function_df47d6e7(hotzone);
        /#
            hotzone.instance.var_19b23216[#"state"] = state;
        #/
        hotzone.instance.var_8fa06b8e += state;
        waitframe(1);
    }
    for (index = 0; index < var_f804b293.size; index++) {
        hotzone = var_f804b293[index];
        hotzone.instance.priority = hotzone.instance.var_8fa06b8e;
        hotzone.instance.var_8fa06b8e = undefined;
        /#
            hotzone.instance.priority_debug = hotzone.instance.var_19b23216;
            hotzone.instance.var_19b23216 = undefined;
        #/
    }
    array::bubble_sort(var_f804b293, &function_d4dbf960);
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x5 linked
// Checksum 0x634abced, Offset: 0x2730
// Size: 0x38
function private function_d4dbf960(left, right) {
    return right.instance.priority < left.instance.priority;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x1 linked
// Checksum 0x8d59c78c, Offset: 0x2770
// Size: 0x1dc
function function_3e21a60b(hotzone, &var_303e0423) {
    score = 0;
    radius = hotzone.radius;
    radiussq = function_a3f6cdac(radius);
    for (player_index = var_303e0423.size - 1; player_index >= 0; player_index--) {
        player = var_303e0423[player_index];
        if (player.origin[2] > hotzone.origin[2] && player.origin[2] < hotzone.origin[2] + hotzone.height && distance2dsquared(player.origin, hotzone.origin) <= radiussq) {
            score += 100;
            continue;
        }
        if (player.origin[2] > hotzone.origin[2] - 2000 && player.origin[2] < hotzone.origin[2] + hotzone.height + 2000) {
            score += mapfloat(radius, 10000, 100, 0, distance2d(player.origin, hotzone.origin));
        }
    }
    return score;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x1 linked
// Checksum 0xd0433cfc, Offset: 0x2958
// Size: 0x168
function function_b6a93fcd(hotzone, &var_303e0423) {
    score = 0;
    fov = cos(45);
    foreach (player in var_303e0423) {
        normal = vectornormalize(hotzone.origin - player.origin);
        forward = anglestoforward(player.angles);
        dot = vectordot(forward, normal);
        if (dot < fov) {
            continue;
        }
        score += mapfloat(fov, 1, 0, 25, dot);
    }
    return score;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x20288dc9, Offset: 0x2ac8
// Size: 0x78
function function_df47d6e7(hotzone) {
    if (hotzone.instance.current_state == 2) {
        if (!isdefined(hotzone.instance.var_ac7b2365[#"chase"])) {
            return 50;
        }
        return 400;
    }
    if (hotzone.instance.current_state == 1) {
        return 30;
    }
    return 0;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 0, eflags: 0x0
// Checksum 0x693e82e, Offset: 0x2b48
// Size: 0x548
function update_hotzone_states() {
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        return;
    }
    level endon(#"game_ended");
    if (!isdefined(level.var_f804b293)) {
        level.var_f804b293 = [];
    }
    if (!isdefined(level.var_3b4ee947)) {
        level.var_3b4ee947 = [];
    }
    while (true) {
        waitframe(1);
        var_d8ee487e = [];
        if (!isdefined(level.var_f804b293)) {
            continue;
        }
        function_ffbebde3(level.var_f804b293);
        waitframe(1);
        if (!isdefined(level.var_f804b293)) {
            continue;
        }
        for (index = 0; index < level.var_f804b293.size; index++) {
            hotzone = level.var_f804b293[index];
            if (var_d8ee487e.size >= getdvarint(#"hash_7c3872b765911891", 4)) {
                break;
            }
            if (is_true(hotzone.instance.var_4188d7c8)) {
                function_e5786b9a(hotzone);
                function_a3ad37ef(hotzone);
            }
            if (hotzone.instance.current_state == 3 || is_true(hotzone.instance.disabled)) {
                continue;
            }
            var_d8ee487e[var_d8ee487e.size] = hotzone;
        }
        waitframe(1);
        foreach (hotzone in var_d8ee487e) {
            switch (hotzone.instance.current_state) {
            case 0:
                function_3c977c4f(hotzone, 1);
                break;
            case 1:
                if (function_64a303c6(hotzone)) {
                    function_3c977c4f(hotzone, 2);
                }
                break;
            case 2:
                if (function_64a303c6(hotzone) || function_e923faaf(hotzone)) {
                    hotzone.instance.var_c80ba91c = undefined;
                } else if (isdefined(hotzone.instance.var_c80ba91c) && hotzone.instance.var_c80ba91c < gettime()) {
                    function_3c977c4f(hotzone, 1);
                    function_fb4091d0(hotzone);
                } else if (!isdefined(hotzone.instance.var_c80ba91c)) {
                    hotzone.instance.var_c80ba91c = gettime() + int(10 * 1000);
                }
                break;
            }
            arrayremovevalue(level.var_3b4ee947, hotzone, 0);
        }
        foreach (hotzone in level.var_3b4ee947) {
            if (is_true(hotzone.instance.disabled)) {
                continue;
            }
            switch (hotzone.instance.current_state) {
            case 1:
            case 2:
                function_fb4091d0(hotzone);
                function_3c977c4f(hotzone, 0);
                break;
            }
        }
        level.var_3b4ee947 = var_d8ee487e;
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 0, eflags: 0x0
// Checksum 0xf93d7372, Offset: 0x3098
// Size: 0x4ac
function function_9e0aba37() {
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        return;
    }
    level endon(#"game_ended");
    level.var_71c1e90a = 0;
    while (true) {
        waitframe(1);
        if (getaicount() >= getailimit() || !isdefined(level.var_3b4ee947)) {
            continue;
        }
        foreach (hotzone in level.var_3b4ee947) {
            instance = hotzone.instance;
            if (is_true(hotzone.instance.var_4188d7c8)) {
                function_e5786b9a(hotzone);
                function_a3ad37ef(hotzone);
            }
            if (is_true(instance.var_98957c00) || instance.spawned_ai >= instance.var_735d3a6b || instance.current_state == 1 && level.var_71c1e90a >= 30) {
                continue;
            }
            if (instance.var_743c45a5.size < instance.var_1fb426c4) {
                var_944250d2 = spawn_ai(hotzone);
                if (!isdefined(var_944250d2)) {
                    continue;
                }
                instance.var_743c45a5[instance.var_743c45a5.size] = var_944250d2;
                namespace_679a22ba::function_266ee075(var_944250d2.list_name, var_944250d2.var_89592ba7);
                instance.spawned_ai++;
                if (hotzone.instance.current_state == 1) {
                    var_944250d2.var_722e942 = 1;
                    level.var_71c1e90a++;
                    var_13a8c4ed = instance.var_743c45a5.size;
                    foreach (ai in instance.var_743c45a5) {
                        if (is_true(ai.var_f3723430)) {
                            var_13a8c4ed--;
                        }
                    }
                    if (var_13a8c4ed >= instance.var_1fb426c4) {
                        instance.var_98957c00 = 1;
                    }
                } else if (hotzone.instance.current_state == 2) {
                    if (hotzone.instance.var_ee69e628.size) {
                        var_32ba732d = array::randomize(hotzone.instance.var_ee69e628);
                        for (i = 0; i < var_32ba732d.size; i++) {
                            if (!isalive(var_32ba732d[i].entity)) {
                                continue;
                            }
                            event = {#type:0, #position:var_32ba732d[i].entity.origin};
                            var_944250d2 callback::function_d8abfc3d(#"hash_790882ac8688cee5", &function_a007a803, undefined, array(event, var_32ba732d[i].entity));
                            break;
                        }
                    }
                }
                break;
            }
        }
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x453d089d, Offset: 0x3550
// Size: 0x300
function spawn_ai(hotzone) {
    assert(hotzone.instance.current_state == 1 || hotzone.instance.current_state == 2, "<dev string:x38>");
    instance = hotzone.instance;
    list_name = function_47ae367f(hotzone, instance.tier, instance.current_state);
    var_e592e473 = function_6d39329f(hotzone, instance.current_state);
    if (!var_e592e473.size) {
        return undefined;
    }
    spawn_info = namespace_679a22ba::function_ca209564(list_name, instance.var_d36a24ed);
    if (!isdefined(spawn_info)) {
        return;
    }
    spawn_point = function_89116a1e(var_e592e473, instance, spawn_info.var_990b33df);
    var_944250d2 = spawnactor(spawn_info.var_990b33df, spawn_point.origin, spawn_point.angles, undefined, 1);
    if (isdefined(var_944250d2)) {
        var_944250d2.spawn_point = spawn_point;
        var_944250d2.list_name = spawn_info.list_name;
        var_944250d2.var_89592ba7 = instance.var_d36a24ed;
        var_944250d2.var_341387d5 = hotzone.origin;
        var_944250d2.var_b518f045 = 3000;
        var_944250d2.hotzone = hotzone;
        if (isdefined(spawn_point.var_90d0c0ff) && function_ee71d10f(spawn_info.var_990b33df, spawn_point.var_90d0c0ff)) {
            var_944250d2.var_c9b11cb3 = spawn_point.var_90d0c0ff;
        }
        var_944250d2 callback::function_d8abfc3d(#"on_ai_killed", &on_ai_killed, undefined, [hotzone]);
        var_944250d2 callback::function_d8abfc3d(#"on_entity_deleted", &function_95899b5c);
        var_944250d2 callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_18c143e6);
        var_944250d2 callback::function_d8abfc3d(#"hash_540e54ba804a87b9", &function_527d149a);
        var_944250d2 thread function_8967ab54();
    }
    return var_944250d2;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x80da25b0, Offset: 0x3858
// Size: 0xe8
function function_fb4091d0(hotzone) {
    foreach (ai in hotzone.instance.var_743c45a5) {
        if (isalive(ai) && !is_true(ai.var_f3723430)) {
            ai.var_f3723430 = 1;
            ai callback::callback(#"hash_10ab46b52df7967a");
        }
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x0
// Checksum 0x596ea508, Offset: 0x3948
// Size: 0x1dc
function function_418ab095(ai, hotzone) {
    ai callback::function_d8abfc3d(#"on_ai_killed", &on_ai_killed, undefined, [hotzone]);
    ai callback::function_d8abfc3d(#"on_entity_deleted", &function_95899b5c);
    ai callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_18c143e6);
    ai callback::function_d8abfc3d(#"hash_540e54ba804a87b9", &function_527d149a);
    ai.hotzone = hotzone;
    ai function_18c143e6();
    if (ai.current_state.name === #"chase" && isdefined(ai.favoriteenemy) && ai.favoriteenemy.team !== level.zombie_team) {
        self function_11efa003(hotzone, ai.favoriteenemy);
    } else {
        ai thread function_8967ab54();
    }
    hotzone.instance.var_743c45a5[hotzone.instance.var_743c45a5.size] = ai;
    if (ai.var_722e942 === 1) {
        level.var_71c1e90a++;
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x1 linked
// Checksum 0xeb9a4612, Offset: 0x3b30
// Size: 0x140
function on_ai_killed(params, hotzone) {
    hotzone.instance.var_4188d7c8 = 1;
    self function_527d149a();
    if (self.var_722e942 === 1) {
        level.var_71c1e90a--;
        self.var_39f7f68 = 1;
    }
    var_26b5ea9d = 0;
    if (isdefined(self.var_813a079f)) {
        var_26b5ea9d = self [[ self.var_813a079f ]](params, hotzone);
    } else if (!isplayer(params.eattacker) && isdefined(self.list_name) && isdefined(self.var_89592ba7) && !is_true(self.var_7a68cd0c)) {
        var_26b5ea9d = 1;
    }
    if (var_26b5ea9d) {
        namespace_679a22ba::function_898aced0(self.list_name, self.var_89592ba7);
        hotzone.instance.spawned_ai--;
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0xc1c1c94f, Offset: 0x3c78
// Size: 0x44
function function_95899b5c(*params) {
    if (self.var_722e942 === 1 && !is_true(self.var_39f7f68)) {
        level.var_71c1e90a--;
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 3, eflags: 0x1 linked
// Checksum 0xe91d23ce, Offset: 0x3cc8
// Size: 0xb4
function function_a007a803(*params, event, enemy) {
    if (isalive(enemy)) {
        event.position = enemy.origin;
    }
    awareness::function_1db27761(self, event);
    self.var_3eaac485 = gettime() + int(3 * 1000);
    self callback::function_52ac9652(#"hash_790882ac8688cee5", &function_a007a803);
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0xf9394d1c, Offset: 0x3d88
// Size: 0xa6
function function_18c143e6(*params) {
    if (!isdefined(self.hotzone.instance)) {
        return;
    }
    if (!isdefined(self.hotzone.instance.var_ac7b2365[self.current_state.name])) {
        self.hotzone.instance.var_ac7b2365[self.current_state.name] = 0;
    }
    self.hotzone.instance.var_ac7b2365[self.current_state.name]++;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0xcc591a02, Offset: 0x3e38
// Size: 0xec
function function_527d149a(*params) {
    if (!isdefined(self.hotzone.instance)) {
        return;
    }
    if (!isdefined(self.hotzone.instance.var_ac7b2365[self.current_state.name])) {
        return;
    }
    self.hotzone.instance.var_ac7b2365[self.current_state.name]--;
    if (self.hotzone.instance.var_ac7b2365[self.current_state.name] <= 0) {
        arrayremoveindex(self.hotzone.instance.var_ac7b2365, self.current_state.name, 1);
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x2a1aad06, Offset: 0x3f30
// Size: 0xe2
function function_e923faaf(hotzone) {
    var_be320827 = [#"wander", #"idle"];
    foreach (key, __ in hotzone.instance.var_ac7b2365) {
        if (!isinarray(var_be320827, key)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 0, eflags: 0x1 linked
// Checksum 0x4afa45d0, Offset: 0x4020
// Size: 0x9c
function function_8967ab54() {
    self notify("6792ef0a6b71dcc5");
    self endon("6792ef0a6b71dcc5");
    self endon(#"death", #"deleted");
    level endon(#"game_ended");
    waitresult = self waittill(#"hash_151828d1d5e024ee");
    self function_11efa003(self.hotzone, waitresult.enemy);
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x1 linked
// Checksum 0xe2518a4a, Offset: 0x40c8
// Size: 0xbe
function function_11efa003(hotzone, enemy) {
    if (!isdefined(hotzone.instance.var_ee69e628[enemy getentitynumber()])) {
        hotzone.instance.var_ee69e628[enemy getentitynumber()] = {#count:0, #entity:enemy};
        /#
            hotzone.instance.var_ee69e628[enemy getentitynumber()].entities = [];
        #/
    }
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0xec0a5278, Offset: 0x4190
// Size: 0x3e
function function_e5786b9a(hotzone) {
    function_1eaaceab(hotzone.instance.var_743c45a5);
    hotzone.instance.var_4188d7c8 = 0;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0x5a02249, Offset: 0x41d8
// Size: 0x14c
function function_a3ad37ef(hotzone) {
    if (!isdefined(hotzone.instance.var_d36a24ed)) {
        return;
    }
    if (hotzone.instance.var_743c45a5.size) {
        return;
    }
    if (!is_true(hotzone.instance.var_98957c00) && hotzone.instance.spawned_ai < hotzone.instance.var_735d3a6b) {
        spawn_list = function_47ae367f(hotzone, hotzone.instance.tier, hotzone.instance.current_state);
        var_b47234f1 = namespace_679a22ba::function_ce65eab6(hotzone.instance.var_d36a24ed);
        if (var_b47234f1.var_cffbc08 == -1 || var_b47234f1.spawned < var_b47234f1.var_cffbc08) {
            return;
        }
    }
    function_3c977c4f(hotzone, 3);
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 1, eflags: 0x1 linked
// Checksum 0xdcbaf635, Offset: 0x4330
// Size: 0x10e
function function_64a303c6(hotzone) {
    if (!hotzone.instance.var_743c45a5.size || !getplayers(undefined, hotzone.origin, 3000).size) {
        return false;
    }
    foreach (ai in hotzone.instance.var_743c45a5) {
        if (isdefined(ai.current_state) && ai.current_state.name == #"chase") {
            return true;
        }
    }
    return false;
}

// Namespace namespace_ce1f29cc/namespace_ce1f29cc
// Params 2, eflags: 0x1 linked
// Checksum 0x2a6c1b99, Offset: 0x4448
// Size: 0x8a
function function_ee71d10f(aitype, alias) {
    if (!isdefined(level.var_39b4b1e2[alias])) {
        level.var_39b4b1e2[alias] = [];
    }
    if (!isdefined(level.var_39b4b1e2[alias][aitype])) {
        level.var_39b4b1e2[alias][aitype] = function_c4cb6239(aitype, alias);
    }
    return level.var_39b4b1e2[alias][aitype];
}

/#

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 0, eflags: 0x0
    // Checksum 0x47f40b2a, Offset: 0x44e0
    // Size: 0xc54
    function function_9b928fad() {
        if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
            return;
        }
        while (!canadddebugcommand()) {
            waitframe(1);
        }
        level.var_70da9652 = {};
        function_5ac4dc99("<dev string:x7e>", 0);
        function_5ac4dc99("<dev string:x92>", "<dev string:xaa>");
        adddebugcommand("<dev string:xae>");
        adddebugcommand("<dev string:xe1>");
        adddebugcommand("<dev string:x110>");
        adddebugcommand("<dev string:x142>");
        adddebugcommand("<dev string:x16c>");
        adddebugcommand("<dev string:x197>");
        var_46903069 = (isdefined(var_46903069) ? var_46903069 : -1) + 1;
        adddebugcommand("<dev string:x1c9>" + "<dev string:x1e4>" + "<dev string:x1f5>" + var_46903069 + "<dev string:x1fa>" + "<dev string:x7e>");
        var_46903069++;
        var_46903069 = (isdefined(var_46903069) ? var_46903069 : -1) + 1;
        adddebugcommand("<dev string:x1c9>" + "<dev string:x200>" + "<dev string:x1f5>" + var_46903069 + "<dev string:x1fa>" + "<dev string:x218>");
        var_46903069 = (isdefined(var_46903069) ? var_46903069 : -1) + 1;
        adddebugcommand("<dev string:x1c9>" + "<dev string:x23b>" + "<dev string:x1f5>" + var_46903069 + "<dev string:x1fa>" + "<dev string:x252>");
        var_46903069 = (isdefined(var_46903069) ? var_46903069 : -1) + 1;
        adddebugcommand("<dev string:x1c9>" + "<dev string:x26c>" + "<dev string:x1f5>" + var_46903069 + "<dev string:x1fa>" + "<dev string:x285>");
        var_46903069 = (isdefined(var_46903069) ? var_46903069 : -1) + 1;
        adddebugcommand("<dev string:x2a1>" + "<dev string:x2bb>" + "<dev string:x1f5>" + var_46903069 + "<dev string:x2d4>" + "<dev string:x2f4>" + "<dev string:x30e>");
        var_46903069 = (isdefined(var_46903069) ? var_46903069 : -1) + 1;
        adddebugcommand("<dev string:x2a1>" + "<dev string:x313>" + "<dev string:x1f5>" + var_46903069 + "<dev string:x2d4>" + "<dev string:x32c>" + "<dev string:x30e>");
        var_46903069 = (isdefined(var_46903069) ? var_46903069 : -1) + 1;
        adddebugcommand("<dev string:x2a1>" + "<dev string:x345>" + "<dev string:x1f5>" + var_46903069 + "<dev string:x2d4>" + "<dev string:x360>" + "<dev string:x30e>");
        var_46903069 = (isdefined(var_46903069) ? var_46903069 : -1) + 1;
        adddebugcommand("<dev string:x2a1>" + "<dev string:x37b>" + "<dev string:x1f5>" + var_46903069 + "<dev string:x2d4>" + "<dev string:x395>" + "<dev string:x30e>");
        var_46903069 = (isdefined(var_46903069) ? var_46903069 : -1) + 1;
        adddebugcommand("<dev string:x2a1>" + "<dev string:x3af>" + "<dev string:x1f5>" + var_46903069 + "<dev string:x2d4>" + "<dev string:x3c7>" + "<dev string:x30e>");
        var_46903069 = (isdefined(var_46903069) ? var_46903069 : -1) + 1;
        adddebugcommand("<dev string:x2a1>" + "<dev string:x3d9>" + "<dev string:x1f5>" + var_46903069 + "<dev string:x2d4>" + "<dev string:x3f8>" + "<dev string:x30e>");
        var_46903069 = (isdefined(var_46903069) ? var_46903069 : -1) + 1;
        adddebugcommand("<dev string:x2a1>" + "<dev string:x416>" + "<dev string:x1f5>" + var_46903069 + "<dev string:x2d4>" + "<dev string:x438>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x457>" + "<dev string:x488>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x1fa>" + "<dev string:x49d>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x457>" + "<dev string:x4bb>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x1fa>" + "<dev string:x4c9>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x512>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x525>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x536>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x548>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x558>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x56f>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x584>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x5a2>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x5be>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x5e6>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x60c>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x623>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x638>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x64d>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x660>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x67f>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x69c>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x6b7>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x6d0>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x6f0>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x70f>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x72d>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x74b>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x765>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x77d>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x79b>" + "<dev string:x30e>");
        var_525602a9 = (isdefined(var_525602a9) ? var_525602a9 : -1) + 1;
        adddebugcommand("<dev string:x4e2>" + "<dev string:x7b7>" + "<dev string:x1f5>" + var_525602a9 + "<dev string:x2d4>" + "<dev string:x7cf>" + "<dev string:x30e>");
        function_cd140ee9("<dev string:x7e>", &function_3fbd8696);
        function_cd140ee9("<dev string:x92>", &function_542b33bf);
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 1, eflags: 0x0
    // Checksum 0xa5d736e7, Offset: 0x5140
    // Size: 0xc2
    function function_3fbd8696(dvar) {
        switch (dvar.value) {
        case 0:
            level notify(#"hash_7ef679d3b9fffd3f");
            break;
        case 1:
            level thread function_3de1c8ac(&function_c3eed624);
            break;
        case 2:
            level thread function_3de1c8ac(&function_bf876de8);
            break;
        }
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 1, eflags: 0x0
    // Checksum 0x2a0b168b, Offset: 0x5210
    // Size: 0x7b4
    function function_542b33bf(dvar) {
        switch (dvar.value) {
        case #"hash_35a3b819e2c0441d":
            level.var_70da9652.var_4b72bf24 = !is_true(level.var_70da9652.var_4b72bf24);
            break;
        case #"hash_1a6ac45da64a952e":
            level.var_70da9652.var_42f5dda4 = !is_true(level.var_70da9652.var_42f5dda4);
            break;
        case #"hash_4a89612f4c29723c":
            level.var_70da9652.var_22a4a482 = !is_true(level.var_70da9652.var_22a4a482);
            break;
        case #"hash_9980be38b90805c":
            level.var_70da9652.var_5ff49272 = !is_true(level.var_70da9652.var_5ff49272);
            break;
        case #"hash_70840771b862a3e":
            level.var_70da9652.var_4bff9c78 = !is_true(level.var_70da9652.var_4bff9c78);
            break;
        case #"hash_2d98dc88067eb39b":
            level.var_70da9652.var_3eef4d41 = !is_true(level.var_70da9652.var_3eef4d41);
            break;
        case #"hash_2bdd64b5fe882d98":
            level.var_70da9652.var_4e02b047 = !is_true(level.var_70da9652.var_4e02b047);
            break;
        case #"hash_46b8b4503ce24c31":
            level.var_70da9652.var_26ba38c4 = !is_true(level.var_70da9652.var_26ba38c4);
            break;
        case #"hash_7ba17de60e0b4f0d":
            level.var_70da9652.var_5cdd46ee = !is_true(level.var_70da9652.var_5cdd46ee);
            break;
        case #"hash_45c58b02a981f2bd":
            level.var_70da9652.var_419cf6f8 = !is_true(level.var_70da9652.var_419cf6f8);
            break;
        case #"hash_759ea2f57b13650e":
            level.var_70da9652.var_780e31de = !is_true(level.var_70da9652.var_780e31de);
            if (is_true(level.var_70da9652.var_780e31de)) {
                level.var_70da9652.var_2269342d = {};
                foreach (player in getplayers()) {
                    if (!isdefined(level.var_70da9652.var_2269342d.player_info)) {
                        level.var_70da9652.var_2269342d.player_info = [];
                    } else if (!isarray(level.var_70da9652.var_2269342d.player_info)) {
                        level.var_70da9652.var_2269342d.player_info = array(level.var_70da9652.var_2269342d.player_info);
                    }
                    level.var_70da9652.var_2269342d.player_info[level.var_70da9652.var_2269342d.player_info.size] = {#origin:player.origin, #angles:player.angles};
                }
            } else {
                level.var_70da9652.var_2269342d = undefined;
            }
            break;
        case #"hash_5401bac31bdc67":
        case #"hash_18e3d1b23392828e":
            level.var_70da9652.var_c5d20e33 = dvar.value;
            break;
        case #"hash_4f3a0e609d3f7e2b":
            function_bc437ca0();
            break;
        case #"hash_125f47c25f63a021":
            function_e24de31c();
            break;
        case #"hash_155d8615abc8b3f5":
            spawns = function_fac3e87c();
            level thread namespace_420b39d3::function_46997bdf(&spawns, "<dev string:x7e7>");
            break;
        case #"hash_635a7b13408b9567":
            spawns = function_fac3e87c();
            namespace_420b39d3::function_70e877d7(&spawns);
            break;
        case #"hash_2a330edd1205dc06":
            level.var_70da9652.var_bf84a5e9 = !is_true(level.var_70da9652.var_bf84a5e9);
            break;
        case #"hash_6832c8f3ef9fb279":
            level.var_70da9652.var_cb0c00c7 = !is_true(level.var_70da9652.var_cb0c00c7);
            break;
        case #"hash_7f507f57d1cfb17":
            level.var_70da9652.var_9da890d8 = !is_true(level.var_70da9652.var_9da890d8);
            break;
        case #"hash_278df421cdf19ebe":
            level.var_70da9652.var_bd4a2cac = !is_true(level.var_70da9652.var_bd4a2cac);
        default:
            break;
        }
        if (dvar.value != "<dev string:xaa>") {
            setdvar(dvar.name, "<dev string:xaa>");
        }
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 0, eflags: 0x0
    // Checksum 0x9cc0043f, Offset: 0x59d0
    // Size: 0xc0
    function function_bc437ca0() {
        waittillframeend();
        level notify(#"hash_1a8453d57fb3fe48");
        foreach (hotzone in level.var_f804b293) {
            function_ea2997e4(hotzone);
            function_4aca4e83(hotzone);
        }
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 0, eflags: 0x0
    // Checksum 0xab75d797, Offset: 0x5a98
    // Size: 0x6a
    function function_d78228f7() {
        level.var_70da9652.var_b74207be = getdvarint(#"hash_3de4c46e91e294cc", 0);
        level.var_70da9652.var_84a7284e = getdvarint(#"hash_3558c135587c5d42", 0);
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 0, eflags: 0x0
    // Checksum 0x311e0832, Offset: 0x5b10
    // Size: 0x24
    function function_c3eed624() {
        return getplayers()[0].origin;
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 0, eflags: 0x0
    // Checksum 0xed35c71, Offset: 0x5b40
    // Size: 0x168
    function function_bf876de8() {
        player = getplayers()[0];
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        direction_vec = (direction_vec[0] * 20000, direction_vec[1] * 20000, direction_vec[2] * 20000);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        circle(trace[#"position"], 16, (1, 0.5, 0), 1, 1, 1);
        debugstar(trace[#"position"], 1, (1, 0.5, 0));
        return trace[#"position"];
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 1, eflags: 0x0
    // Checksum 0xeb5daba5, Offset: 0x5cb0
    // Size: 0x3de
    function function_3de1c8ac(var_2da12984) {
        level endon(#"game_ended", #"hash_7ef679d3b9fffd3f");
        self notify("<dev string:x7f2>");
        self endon("<dev string:x7f2>");
        while (true) {
            waitframe(1);
            function_d78228f7();
            origin = getplayers()[0].origin;
            options = level.var_70da9652;
            var_3bd2fa1f = arraysortclosest(level.var_f804b293, [[ var_2da12984 ]](), options.var_b74207be);
            var_f804b293 = level.var_f804b293;
            if (isdefined(options.var_c5d20e33)) {
                if (options.var_c5d20e33 === "<dev string:x360>") {
                    function_c981b20b([[ var_2da12984 ]](), 2000);
                } else {
                    function_1724f4ac([[ var_2da12984 ]](), 2000);
                }
                level.var_70da9652.var_c5d20e33 = undefined;
            }
            foreach (index, hotzone in level.var_f804b293) {
                scale = 0.7;
                distance = distance(hotzone.origin, origin);
                if (distance > 400) {
                    scale = distance * 0.002;
                }
                if (!isinarray(var_3bd2fa1f, hotzone)) {
                    function_a5ea005d(hotzone, index, scale);
                    continue;
                }
                function_1a530376(hotzone, index, scale);
            }
            if (isarray(options.var_2269342d.player_info)) {
                foreach (info in options.var_2269342d.player_info) {
                    function_af647be2(info);
                }
            }
            if (is_true(options.var_bf84a5e9)) {
                scale = 0.85;
                offset = 75;
                debug2dtext((105, offset * scale, 0), "<dev string:x806>" + level.var_71c1e90a, (1, 1, 0), undefined, (0.4, 0.4, 0.4), 0.9, scale);
                offset += 22;
            }
        }
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 3, eflags: 0x0
    // Checksum 0x8484bda4, Offset: 0x6098
    // Size: 0xec
    function function_a5ea005d(hotzone, array_index, scale) {
        index = 0;
        options = level.var_70da9652;
        var_a7c842b3 = function_6320ae1d(hotzone, options);
        if (is_true(options.var_419cf6f8)) {
            index = function_af798ce8(index, scale, 1, var_a7c842b3, array_index, hotzone);
            return;
        }
        line(hotzone.origin, hotzone.origin + (0, 0, 300), var_a7c842b3, 1);
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 3, eflags: 0x0
    // Checksum 0xc68b3c09, Offset: 0x6190
    // Size: 0x5b4
    function function_1a530376(hotzone, array_index, scale) {
        index = 0;
        options = level.var_70da9652;
        var_a7c842b3 = function_6320ae1d(hotzone, options);
        debugstar(hotzone.origin, 1, var_a7c842b3);
        if (is_true(options.var_419cf6f8)) {
            index = function_af798ce8(index, scale, 1, var_a7c842b3, array_index, hotzone);
        }
        print3d(hotzone.origin + (0, 0, index), function_89a74781(hotzone) + "<dev string:x814>" + hotzone.instance.tier, var_a7c842b3, 1, scale * 0.8, 1);
        index += 17 * scale * 0.8;
        print3d(hotzone.origin + (0, 0, index), function_9e72a96(hotzone.scriptbundlename), var_a7c842b3, 1, scale * 1, 1);
        index += 17 * scale * 1;
        print3d(hotzone.origin + (0, 0, index), is_true(hotzone.instance.disabled) ? "<dev string:x81e>" : "<dev string:x82a>", is_true(hotzone.instance.disabled) ? (1, 0, 1) : (0, 1, 1), 1, scale * 1, 1);
        index += 17 * scale * 1;
        if (is_true(options.var_5cdd46ee)) {
            index = function_42926dcf(index, scale, 1, hotzone);
        }
        if (is_true(options.var_4e02b047)) {
            index = function_d937ea12(index, scale, 1, var_a7c842b3, hotzone, options);
        }
        if (is_true(options.var_9da890d8)) {
            index = function_11ba669e(index, scale, 1, var_a7c842b3, hotzone, options);
        }
        if (is_true(options.var_bd4a2cac)) {
            index = function_22dd41d8(index, scale, 1, var_a7c842b3, hotzone, options);
        }
        if (is_true(options.var_4b72bf24)) {
            function_9c8936c1(hotzone.instance.initial_spawn_points, hotzone.origin, (0, 1, 1));
        }
        if (is_true(options.var_42f5dda4)) {
            function_9c8936c1(hotzone.instance.var_d9c7b945, hotzone.origin, (1, 0, 0));
        }
        if (is_true(options.var_5ff49272)) {
            function_59a41525(hotzone.origin, hotzone.radius, hotzone.height, (1, 0, 1), 1);
        }
        if (is_true(options.var_4bff9c78)) {
            function_59a41525(hotzone.origin, 3000, hotzone.height, (1, 0.5, 0), 1);
        }
        if (is_true(options.var_3eef4d41) && !is_true(hotzone.var_19e89e4e)) {
            function_59a41525(hotzone.origin, hotzone.var_9b178666, hotzone.var_48d0f926, (1, 1, 0), 1);
            return;
        }
        if (is_true(options.var_3eef4d41) && is_true(hotzone.var_19e89e4e)) {
            draw_box(hotzone.origin, hotzone.angles, hotzone.var_499035e2, hotzone.var_81314a61, hotzone.var_48d0f926, (1, 1, 0));
        }
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 6, eflags: 0x0
    // Checksum 0xae30ccb1, Offset: 0x6750
    // Size: 0x312
    function function_af798ce8(index, scale, alpha, color, var_5ab1a705, hotzone) {
        if (!hotzone.instance.priority) {
            line(hotzone.origin, hotzone.origin + (0, 0, 300), color);
            return index;
        }
        print3d(hotzone.origin + (0, 0, index), "<dev string:x835>" + hotzone.instance.priority, color, alpha, scale * 1, 1);
        index += 17 * scale * 1;
        foreach (key, value in hotzone.instance.priority_debug) {
            print3d(hotzone.origin + (0, 0, index), function_9e72a96(key) + "<dev string:x1f5>" + value, color, alpha, scale * 1, 1);
            index += 17 * scale * 1;
        }
        if (!level.var_f804b293[0].instance.priority) {
            var_2a5f3b00 = mapfloat(0, level.var_f804b293.size, 0, 1, var_5ab1a705);
        } else {
            var_2a5f3b00 = mapfloat(0, level.var_f804b293[0].instance.priority, 0, 1, hotzone.instance.priority);
        }
        height = 300 + 1000 * var_2a5f3b00;
        line(hotzone.origin, hotzone.origin + (0, 0, height), color);
        print3d(hotzone.origin + (0, 0, height), var_5ab1a705, color, 1, scale * 2);
        return index;
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 6, eflags: 0x0
    // Checksum 0xa1649111, Offset: 0x6a70
    // Size: 0x590
    function function_d937ea12(index, scale, alpha, color, hotzone, options) {
        list_name = function_47ae367f(hotzone, hotzone.instance.tier, hotzone.instance.current_state);
        print3d(hotzone.origin + (0, 0, index), "<dev string:x842>" + (is_true(hotzone.instance.var_98957c00) ? "<dev string:x854>" : "<dev string:x85c>"), color, alpha, scale * 0.75, 1);
        index += 17 * scale * 0.75;
        print3d(hotzone.origin + (0, 0, index), "<dev string:x865>" + (is_true(hotzone.instance.var_4188d7c8) ? "<dev string:x854>" : "<dev string:x85c>"), color, alpha, scale * 0.75, 1);
        index += 17 * scale * 0.75;
        print3d(hotzone.origin + (0, 0, index), "<dev string:x879>" + hotzone.instance.var_743c45a5.size + "<dev string:x887>" + hotzone.instance.var_1fb426c4, color, alpha, scale * 0.75, 1);
        index += 17 * scale * 0.75;
        print3d(hotzone.origin + (0, 0, index), "<dev string:x88c>" + hotzone.instance.spawned_ai + "<dev string:x887>" + hotzone.instance.var_735d3a6b, color, alpha, scale * 0.75, 1);
        index += 17 * scale * 0.75;
        index += 17 * scale * 0.75;
        if (isdefined(hotzone.instance.var_d36a24ed)) {
            spawn_info = namespace_679a22ba::function_ce65eab6(hotzone.instance.var_d36a24ed);
            print3d(hotzone.origin + (0, 0, index), "<dev string:x89e>" + spawn_info.spawned + "<dev string:x887>" + (spawn_info.var_cffbc08 == -1 ? "<dev string:x8b1>" : spawn_info.var_cffbc08), color, alpha, scale * 0.75, 1);
            index += 17 * scale * 0.75;
            if (is_true(options.var_26ba38c4)) {
                for (i = hotzone.instance.var_d36a24ed.var_7c88c117.size - 1; i >= 0; i--) {
                    entry = hotzone.instance.var_d36a24ed.var_7c88c117[i];
                    print3d(hotzone.origin + (0, 0, index), "<dev string:x8b8>" + entry.name + "<dev string:x1f5>" + entry.spawned + "<dev string:x887>" + (entry.var_cffbc08 == -1 ? "<dev string:x8b1>" : entry.var_cffbc08), color, alpha, scale * 0.75, 1);
                    index += 17 * scale * 0.75;
                }
            }
        }
        print3d(hotzone.origin + (0, 0, index), "<dev string:x8c3>" + (isdefined(list_name) ? list_name : "<dev string:xaa>"), (0, 1, 1), alpha, scale * 0.75, 1);
        index += 17 * scale * 0.75;
        return index;
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 6, eflags: 0x0
    // Checksum 0xacb17a5a, Offset: 0x7008
    // Size: 0x268
    function function_11ba669e(index, scale, alpha, var_a7c842b3, hotzone, *options) {
        foreach (var_4b6c578e, var_687dacb8 in options.instance.var_ee69e628) {
            print3d(options.origin + (0, 0, scale), "<dev string:x8ce>" + var_4b6c578e + "<dev string:x8d6>" + var_687dacb8.count, hotzone, var_a7c842b3, alpha * 0.75, 1);
            scale += 17 * alpha * 0.75;
            foreach (ai in var_687dacb8.entities) {
                if (!isalive(ai)) {
                    continue;
                }
                line(ai.origin + (0, 0, ai function_6a9ae71()), var_687dacb8.entity.origin, (1, 0, 1));
            }
        }
        print3d(options.origin + (0, 0, scale), "<dev string:x8dc>", hotzone, var_a7c842b3, alpha * 0.75, 1);
        scale += 17 * alpha * 0.75;
        return scale;
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 6, eflags: 0x0
    // Checksum 0x1a18fd61, Offset: 0x7278
    // Size: 0x1b0
    function function_22dd41d8(index, scale, alpha, var_a7c842b3, hotzone, *options) {
        scale += 17 * alpha * 0.75;
        foreach (state_name, count in options.instance.var_ac7b2365) {
            print3d(options.origin + (0, 0, scale), "<dev string:x8f1>" + function_9e72a96(state_name) + "<dev string:x8d6>" + count, hotzone, var_a7c842b3, alpha * 0.75, 1);
            scale += 17 * alpha * 0.75;
        }
        print3d(options.origin + (0, 0, scale), "<dev string:x8f9>", hotzone, var_a7c842b3, alpha * 0.75, 1);
        scale += 17 * alpha * 0.75;
        return scale;
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 4, eflags: 0x0
    // Checksum 0xe6885195, Offset: 0x7430
    // Size: 0xc8
    function function_42926dcf(index, scale, alpha, hotzone) {
        if (!isdefined(hotzone.var_c43420a)) {
            return index;
        }
        print3d(hotzone.origin + (0, 0, index), "<dev string:x910>" + hotzone.var_c43420a + "<dev string:x91a>" + hotzone.var_d3455e4, (1, 0, 1), alpha, scale * 0.75, 1);
        index += 17 * scale * 0.75;
        return index;
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 2, eflags: 0x0
    // Checksum 0x8cd198c5, Offset: 0x7500
    // Size: 0x16a
    function function_6320ae1d(hotzone, options) {
        if (is_true(options.var_419cf6f8)) {
            if (!level.var_f804b293[0].instance.priority) {
                return (1, 0, 0);
            } else {
                var_2a5f3b00 = mapfloat(0, level.var_f804b293[0].instance.priority, 0, 1, hotzone.instance.priority);
                return vectorlerp((1, 0, 0), (0, 1, 0), var_2a5f3b00);
            }
        }
        switch (hotzone.instance.current_state) {
        case 0:
            return (1, 0, 0);
        case 1:
            return (0, 1, 0);
        case 2:
            return (1, 0.5, 0);
        default:
            return (0.3, 0.3, 0.3);
        }
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 1, eflags: 0x0
    // Checksum 0x5f249355, Offset: 0x7678
    // Size: 0xfa
    function function_89a74781(hotzone) {
        switch (hotzone.instance.current_state) {
        case 0:
            return "<dev string:x923>";
        case 1:
            return "<dev string:x92f>";
        case 2:
            if (!isdefined(hotzone.instance.var_c80ba91c)) {
                return "<dev string:x939>";
            } else {
                return ("<dev string:x940>" + float(hotzone.instance.var_c80ba91c - gettime()) / 1000);
            }
            break;
        default:
            return "<dev string:x948>";
        }
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 5, eflags: 0x0
    // Checksum 0x71bcd213, Offset: 0x7780
    // Size: 0xb4
    function function_59a41525(origin, radius, height, color, depthtest) {
        circle(origin, radius, color, depthtest, 1, 1);
        circle(origin + (0, 0, height), radius, color, depthtest, 1, 1);
        line(origin, origin + (0, 0, height), color, 1, depthtest, 1);
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 7, eflags: 0x0
    // Checksum 0x5a8ba96a, Offset: 0x7840
    // Size: 0xfc
    function draw_box(origin, angles, width, length, height, color, centered) {
        if (!isdefined(centered)) {
            centered = 0;
        }
        mins = (-0.5 * width, -0.5 * length, centered ? height / -2 : 0);
        maxs = (0.5 * width, 0.5 * length, centered ? height / 2 : height);
        box(origin, mins, maxs, angles, color, 1, 1, 1);
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 3, eflags: 0x0
    // Checksum 0x744a76fc, Offset: 0x7948
    // Size: 0x236
    function function_9c8936c1(&var_af4acf6e, origin, color) {
        foreach (point in var_af4acf6e) {
            index = 0;
            debugstar(point.origin, 1, color);
            line(point.origin, origin, color);
            if (is_true(level.var_70da9652.var_22a4a482) && isdefined(point.var_90d0c0ff)) {
                draw_box(point.origin, point.angles, 8, 8, 8, (1, 0.752941, 0.796078), 1);
                index = function_774fd83c(point, color, index, 0.75, 1);
            }
            if (is_true(level.var_70da9652.var_cb0c00c7) && isdefined(point.archetype)) {
                print3d(point.origin + (0, 0, index), point.archetype, color, 1, 0.75 * 0.75, 1, 1);
                index += 17 * 0.75 * 0.75;
            }
        }
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 5, eflags: 0x0
    // Checksum 0xb06b7aa4, Offset: 0x7b88
    // Size: 0xfa
    function function_774fd83c(spawn_point, color, index, scale, alpha) {
        print3d(spawn_point.origin + (0, 0, index), spawn_point.var_90d0c0ff, color, alpha, scale * scale, 1, 1);
        index += 17 * scale * scale;
        draw_arrow(spawn_point.origin, spawn_point.origin + anglestoforward(spawn_point.angles) * 15, (1, 0.752941, 0.796078), 6);
        return index;
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 1, eflags: 0x0
    // Checksum 0x23d9be49, Offset: 0x7c90
    // Size: 0x1fc
    function function_af647be2(player) {
        line(player.origin + (0, 0, 72), player.origin + (0, 0, 572), (0, 1, 1));
        draw_box(player.origin, player.angles, 32, 32, 72, (0, 1, 1));
        var_9029dbde = rotatepointaroundaxis((256, 0, 0), (0, 0, 1), angleclamp180(player.angles[1] + 45));
        var_9029dbde += player.origin;
        line(player.origin, var_9029dbde, (1, 0.5, 0));
        var_a9e71ad4 = rotatepointaroundaxis((256, 0, 0), (0, 0, 1), angleclamp180(player.angles[1] - 45));
        var_a9e71ad4 += player.origin;
        line(player.origin, var_a9e71ad4, (1, 0.5, 0));
        line(player.origin, player.origin + anglestoforward(player.angles) * 256, (1, 1, 0));
    }

    // Namespace namespace_ce1f29cc/namespace_ce1f29cc
    // Params 4, eflags: 0x0
    // Checksum 0x14be4006, Offset: 0x7e98
    // Size: 0x164
    function draw_arrow(start, end, color, var_6c0bdd43) {
        angles = vectortoangles(end - start);
        var_7df0eab3 = var_6c0bdd43 / sqrt(2);
        var_697b6725 = var_6c0bdd43 / sqrt(2);
        line(start, end, color);
        var_52defcab = rotatepoint((-1 * var_697b6725, -1 * var_7df0eab3, 0), angles);
        var_2ded77 = rotatepoint((-1 * var_697b6725, var_7df0eab3, 0), angles);
        line(end, end + var_52defcab, color);
        line(end, end + var_2ded77, color);
    }

#/
