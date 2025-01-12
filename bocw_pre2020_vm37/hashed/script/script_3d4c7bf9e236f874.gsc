#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_2049e8e1;

// Namespace namespace_2049e8e1/namespace_2049e8e1
// Params 0, eflags: 0x6
// Checksum 0xac0c6b2a, Offset: 0x110
// Size: 0x34
function private autoexec __init__system__() {
    system::register(#"hash_74f3a91387b796d6", undefined, undefined, &finalize, undefined);
}

// Namespace namespace_2049e8e1/namespace_2049e8e1
// Params 0, eflags: 0x1 linked
// Checksum 0x4f3c282d, Offset: 0x150
// Size: 0x5c
function finalize() {
    callback::on_game_playing(&on_game_playing);
    scene::add_scene_func(#"hash_574b1836fb59ee9", &function_4cb3705c, "play");
}

// Namespace namespace_2049e8e1/namespace_2049e8e1
// Params 0, eflags: 0x1 linked
// Checksum 0xb6bbecd, Offset: 0x1b8
// Size: 0x10e
function on_game_playing() {
    level endon(#"game_ended");
    wait 5;
    if (!getdvarint(#"hash_54481d23eb6a2061", 1) || getdvarstring(#"hash_31435ea827fda47b") !== "ruka" || getdvarstring(#"g_gametype") === "survival" || getdvarstring(#"g_gametype") === "zsurvival") {
        return;
    }
    while (true) {
        level scene::play(#"hash_574b1836fb59ee9");
        wait 10;
    }
}

/#

    // Namespace namespace_2049e8e1/namespace_2049e8e1
    // Params 0, eflags: 0x0
    // Checksum 0x18eb37fb, Offset: 0x2d0
    // Size: 0x64
    function init_devgui() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x38>");
        adddebugcommand("<dev string:x72>" + mapname + "<dev string:x84>");
    }

#/

// Namespace namespace_2049e8e1/namespace_2049e8e1
// Params 1, eflags: 0x1 linked
// Checksum 0x3c79b8a1, Offset: 0x340
// Size: 0x34
function function_4cb3705c(a_ents) {
    array::run_all(a_ents, &setmovingplatformenabled, 1, 0);
}

// Namespace namespace_2049e8e1/namespace_2049e8e1
// Params 0, eflags: 0x0
// Checksum 0xa8f8634d, Offset: 0x380
// Size: 0x60
function function_bbd87559() {
    while (getdvarint(#"hash_54481d23eb6a2061", 0)) {
        function_e4f2ebb6();
        array::wait_till(level.var_57db5adb, "reached_end_node");
    }
}

// Namespace namespace_2049e8e1/namespace_2049e8e1
// Params 0, eflags: 0x1 linked
// Checksum 0xad9798f1, Offset: 0x3e8
// Size: 0x3e0
function function_e4f2ebb6() {
    if (!isdefined(level.var_57db5adb)) {
        spawner = getent("monorail3_car", "targetname");
        var_3c212853 = getent("monorail3_car_mid", "targetname");
        var_bcf0f848 = getent("monorail3_car_jun", "targetname");
        if (isdefined(spawner)) {
            for (i = 0; i < 3; i++) {
                if (i == 0) {
                    var_49360986 = spawner spawnfromspawner("monorail3_car");
                    var_49360986.var_b5c6dd1a = getvehiclenode("monorail3_car", "targetname");
                } else if (i == 1) {
                    var_49360986 = var_bcf0f848 spawnfromspawner("monorail3_car_jun");
                    var_49360986.var_b5c6dd1a = getvehiclenode("monorail3_car_jun", "targetname");
                } else {
                    var_49360986 = var_3c212853 spawnfromspawner("monorail3_car_mid");
                    var_49360986.var_b5c6dd1a = getvehiclenode("monorail3_car_mid", "targetname");
                }
                var_49360986.origin = var_49360986.var_b5c6dd1a.origin;
                var_49360986.angles = var_49360986.var_b5c6dd1a.angles;
                if (!isdefined(level.var_57db5adb)) {
                    level.var_57db5adb = [];
                } else if (!isarray(level.var_57db5adb)) {
                    level.var_57db5adb = array(level.var_57db5adb);
                }
                level.var_57db5adb[level.var_57db5adb.size] = var_49360986;
                util::wait_network_frame();
            }
        }
    }
    foreach (i, var_49360986 in level.var_57db5adb) {
        train_car_length = 32;
        if (var_49360986.targetname == "monorail3_car_jun") {
            train_car_length = 180;
        } else if (var_49360986.targetname == "monorail3_car_mid") {
            train_car_length = 160;
        }
        var_49360986 setmovingplatformenabled(1);
        var_49360986 setspeed(getdvarint(#"hash_36d72526a152d196", 35));
        var_49360986 function_ded6dd2e(var_49360986.var_b5c6dd1a, 0);
        var_49360986 startpath();
        var_49360986 thread function_91b0cb60();
    }
}

// Namespace namespace_2049e8e1/namespace_2049e8e1
// Params 0, eflags: 0x1 linked
// Checksum 0x92bf2ec6, Offset: 0x7d0
// Size: 0x170
function function_91b0cb60() {
    self notify(#"hash_5f32c5fea14a4455");
    self endon(#"hash_5f32c5fea14a4455", #"reached_end_node", #"death");
    while (true) {
        waitframe(5);
        var_458f1f54 = getdvarint(#"hash_36d72526a152d196", 35);
        cur_speed = 0.0568182 * self getspeed();
        if (var_458f1f54 != int(cur_speed)) {
            accel = int(var_458f1f54 / 4);
            decel = int(var_458f1f54 / 8);
            if (accel < 5) {
                accel = 5;
            }
            if (decel < 5) {
                decel = 5;
            }
            self setspeed(var_458f1f54, accel, decel);
        }
    }
}

