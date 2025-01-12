#using script_19367cd29a4485db;
#using script_3411bb48d41bd3b;
#using script_34ab99a4ca1a43d;
#using script_6a4a2311f8a4697;
#using script_7fc996fe8678852;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_78804a69;

// Namespace namespace_78804a69/namespace_78804a69
// Params 0, eflags: 0x6
// Checksum 0x4a95ac07, Offset: 0x118
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_66deecfe045e25a5", &function_70a657d8, undefined, undefined, #"hash_f81b9dea74f0ee");
}

// Namespace namespace_78804a69/namespace_78804a69
// Params 0, eflags: 0x1 linked
// Checksum 0x3404096b, Offset: 0x168
// Size: 0x6c
function function_70a657d8() {
    if (!zm_utility::is_survival()) {
        return;
    }
    namespace_8b6a9d79::function_b3464a7c(#"hash_66deecfe045e25a5", &function_f3ab2353);
    /#
        level thread namespace_420b39d3::function_2fab7a62("<dev string:x38>");
    #/
}

// Namespace namespace_78804a69/namespace_78804a69
// Params 1, eflags: 0x1 linked
// Checksum 0xe53eeae1, Offset: 0x1e0
// Size: 0x178
function function_cd133a5e(destination) {
    foreach (location in destination.locations) {
        if (isdefined(location.var_5eba96b3)) {
            foreach (instance in location.var_5eba96b3) {
                if (instance.content_script_name === "kill_hvt" && instance.target === "objectives_location_zoo_2") {
                    return;
                }
            }
        }
        if (isdefined(location.instances[#"hash_66deecfe045e25a5"])) {
            namespace_8b6a9d79::function_20d7e9c7(location.instances[#"hash_66deecfe045e25a5"]);
        }
    }
}

// Namespace namespace_78804a69/namespace_78804a69
// Params 1, eflags: 0x5 linked
// Checksum 0xac3da358, Offset: 0x360
// Size: 0x11c
function private function_f3ab2353(s_instance) {
    s_instance flag::clear("cleanup");
    s_instance callback::function_d8abfc3d(#"hash_345e9169ebba28fb", &function_149da5dd);
    s_chest = s_instance.var_fe2612fe[#"hash_6b1e5d8f9e70a70e"][0];
    var_7ebc9406 = s_instance.var_fe2612fe[#"hash_6a6fc91720d4e9cf"][0];
    if (!s_instance flag::get("first_spawn")) {
        s_instance flag::set("first_spawn");
        function_1315b51a(var_7ebc9406);
    }
    namespace_58949729::function_25979f32(s_chest, 1, s_instance);
}

// Namespace namespace_78804a69/namespace_78804a69
// Params 0, eflags: 0x1 linked
// Checksum 0x9d5c332b, Offset: 0x488
// Size: 0x8c
function function_149da5dd() {
    self callback::function_52ac9652(#"hash_345e9169ebba28fb", &function_149da5dd);
    self flag::set("cleanup");
    s_chest = self.var_fe2612fe[#"hash_6b1e5d8f9e70a70e"][0];
    namespace_58949729::function_a3852ab5(s_chest);
}

// Namespace namespace_78804a69/namespace_78804a69
// Params 1, eflags: 0x1 linked
// Checksum 0x4036f73e, Offset: 0x520
// Size: 0xfc
function function_1315b51a(var_7ebc9406) {
    level flag::wait_till(#"hash_408fb58a3f3c6243");
    if (isdefined(var_7ebc9406.scriptbundlename)) {
        var_76dffad4 = namespace_60c38ce9::function_104e0ed7(var_7ebc9406.scriptbundlename, var_7ebc9406.origin, var_7ebc9406.angles, var_7ebc9406.radius, var_7ebc9406.height, var_7ebc9406.var_9b178666, var_7ebc9406.var_48d0f926, var_7ebc9406.var_19e89e4e, var_7ebc9406.var_81314a61, var_7ebc9406.var_499035e2);
        var_6bca277 = namespace_60c38ce9::function_3bdf488(var_76dffad4);
        if (!is_true(var_6bca277.var_45d1a7df)) {
            namespace_60c38ce9::function_8844b193(var_6bca277);
        }
    }
}

// Namespace namespace_78804a69/namespace_78804a69
// Params 1, eflags: 0x0
// Checksum 0x2aa31f8f, Offset: 0x628
// Size: 0x22c
function function_8e054205(var_14e73f0a) {
    v_loc = getclosestpointonnavmesh(var_14e73f0a.origin, var_14e73f0a.radius);
    a_v_points = getrandomnavpoints(v_loc, var_14e73f0a.radius, 12, 24);
    n_players = getplayers().size;
    n_spawned = 0;
    if (n_players == 1) {
        var_191d6d71 = randomintrangeinclusive(4, 8);
    } else if (n_players <= 3) {
        var_191d6d71 = randomintrangeinclusive(8, 10);
    } else {
        var_191d6d71 = randomintrangeinclusive(10, 12);
    }
    for (i = 0; i < var_191d6d71; i++) {
        if (i == 0) {
            var_283596b4 = #"hash_4f87aa2a203d37d0";
        } else {
            var_fc0b4b9f = randomfloat(1);
            if (var_fc0b4b9f <= 0.75) {
                var_283596b4 = #"hash_7cba8a05511ceedf";
            } else if (var_fc0b4b9f <= 0.9) {
                var_283596b4 = #"hash_338eb4103e0ed797";
            } else {
                var_283596b4 = #"hash_46c917a1b5ed91e7";
            }
        }
        ai_spawned = namespace_85745671::function_9d3ad056(var_283596b4, a_v_points[i], (0, 0, 0), "dungeon_zombie");
        if (isdefined(ai_spawned)) {
            ai_spawned thread function_ec9d4ec9();
        }
    }
}

// Namespace namespace_78804a69/namespace_78804a69
// Params 0, eflags: 0x1 linked
// Checksum 0x84718fea, Offset: 0x860
// Size: 0x76
function function_ec9d4ec9() {
    self endon(#"death");
    while (true) {
        if (getplayers("all", self.origin, 8000).size == 0) {
            self callback::callback(#"hash_10ab46b52df7967a");
        }
        wait 5;
    }
}

