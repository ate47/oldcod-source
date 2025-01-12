#using scripts\core_common\array_shared;
#using scripts\core_common\encounters\aispawning;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;

#namespace wave_manager_sys;

// Namespace wave_manager_sys
// Method(s) 2 Total 2
class cwavemanager {

    var var_52719fc2;
    var var_a9577a5;
    var var_d7eda565;
    var var_f3403408;
    var var_f4ed1c57;
    var var_f8179a0f;

    // Namespace cwavemanager/wave_manager
    // Params 0, eflags: 0x8
    // Checksum 0xb967f095, Offset: 0x200
    // Size: 0x4a
    constructor() {
        var_f8179a0f = [];
        var_a9577a5 = 1;
        var_52719fc2 = [];
        var_f3403408 = [];
        var_d7eda565 = 0;
        var_f4ed1c57 = 1;
    }

}

// Namespace wave_manager_sys
// Method(s) 2 Total 2
class class_fdc85a6b {

    var var_1265f1d6;
    var var_16873967;

    // Namespace class_fdc85a6b/wave_manager
    // Params 0, eflags: 0x8
    // Checksum 0x2859022c, Offset: 0x2f8
    // Size: 0x1a
    constructor() {
        var_1265f1d6 = 0;
        var_16873967 = [];
    }

}

#namespace wave_manager;

// Namespace wave_manager
// Method(s) 2 Total 2
class class_2fce69cd {

    var a_params;

    // Namespace class_2fce69cd/wave_manager
    // Params 0, eflags: 0x8
    // Checksum 0x96437c4b, Offset: 0x5600
    // Size: 0xe
    constructor() {
        a_params = [];
    }

}

#namespace wave_manager_sys;

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x2
// Checksum 0x807bcec8, Offset: 0x1b8
// Size: 0x3c
function autoexec __init__system__() {
    system::register("wave_manager", &__init__, &__main__, undefined);
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0x2fe550cf, Offset: 0x3c0
// Size: 0x5c
function private __init__() {
    level.var_28f45c5a = [];
    level.a_s_wave_managers = [];
    /#
        setdvar(#"hash_1feb7de8a9fa6573", -1);
        level thread debug_think();
    #/
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0x89174dbf, Offset: 0x428
// Size: 0xec
function private __main__() {
    level.a_s_wave_managers = struct::get_script_bundle_instances("wave_manager");
    foreach (s_wave_manager in level.a_s_wave_managers) {
        s_wave_manager flag::init("wave_manager_started");
        s_wave_manager function_e4be50e1();
    }
    level function_4583bfd0();
    level function_172065a5();
}

/#

    // Namespace wave_manager_sys/wave_manager
    // Params 0, eflags: 0x4
    // Checksum 0xd2d689a1, Offset: 0x520
    // Size: 0x1a4
    function private update_devgui() {
        if (!isdefined(level.var_6649c6f5)) {
            level.var_6649c6f5 = 0;
        }
        level.var_6649c6f5++;
        str_map_name = util::get_map_name();
        foreach (var_341eaaa8 in level.var_28f45c5a) {
            var_5e68ca3 = var_341eaaa8.var_15bcffcf;
            str_team = var_341eaaa8.m_str_team;
            str_name = var_341eaaa8.var_ea8ccd6c;
            cmd = "<dev string:x30>" + str_map_name + "<dev string:x3e>" + str_team + "<dev string:x54>" + "<dev string:x56>" + var_5e68ca3 + "<dev string:x58>" + str_name + "<dev string:x5a>" + var_5e68ca3 + "<dev string:x7b>";
            adddebugcommand(cmd);
        }
        cmd = "<dev string:x30>" + str_map_name + "<dev string:x7f>";
        adddebugcommand(cmd);
    }

    // Namespace wave_manager_sys/wave_manager
    // Params 0, eflags: 0x4
    // Checksum 0x1942823a, Offset: 0x6d0
    // Size: 0xe5a
    function private debug_think() {
        while (true) {
            n_wave_manager_id = getdvarint(#"hash_1feb7de8a9fa6573", 0);
            if (n_wave_manager_id != -1) {
                if (isdefined(level.var_28f45c5a[n_wave_manager_id])) {
                    n_y_offset = 22;
                    var_6d872969 = 22;
                    var_81e9aa1a = 120;
                    var_341eaaa8 = level.var_28f45c5a[n_wave_manager_id];
                    var_5e68ca3 = var_341eaaa8.var_15bcffcf;
                    str_name = var_341eaaa8.var_ea8ccd6c;
                    if (var_341eaaa8 flag::get("<dev string:xc6>")) {
                        /#
                            var_81e9aa1a += n_y_offset;
                            str_text = str_name + "<dev string:xce>";
                            debug2dtext((800, var_81e9aa1a, 0), str_text, (1, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
                            var_81e9aa1a += n_y_offset;
                            debug2dtext((800, var_81e9aa1a, 0), "<dev string:xd8>", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
                        #/
                        waitframe(1);
                        continue;
                    }
                    if (isdefined(var_341eaaa8.var_8bf660aa) && var_341eaaa8.var_8bf660aa && var_341eaaa8.var_a9577a5 > var_341eaaa8.var_8edc2513) {
                        waitframe(1);
                        continue;
                    }
                    str_team = var_341eaaa8.m_str_team;
                    /#
                        var_81e9aa1a += n_y_offset;
                        debug2dtext((800, var_81e9aa1a, 0), "<dev string:xd8>", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
                    #/
                    if (isdefined(var_341eaaa8.var_8bf660aa) && var_341eaaa8.var_8bf660aa) {
                        str_status = "<dev string:x100>";
                    } else if (function_43f49887(var_341eaaa8)) {
                        str_status = "<dev string:x108>";
                    } else {
                        str_status = "<dev string:x111>";
                    }
                    /#
                        var_81e9aa1a += n_y_offset;
                        str_text = str_name + "<dev string:x119>" + str_status + "<dev string:x11b>";
                        debug2dtext((800, var_81e9aa1a, 0), str_text, (1, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
                        var_81e9aa1a += n_y_offset;
                        debug2dtext((800, var_81e9aa1a, 0), "<dev string:xd8>", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
                    #/
                    if (function_bdf8c402(var_341eaaa8, var_341eaaa8.var_a9577a5)) {
                        str_status = "<dev string:x11d>";
                    } else if (function_43f49887(var_341eaaa8, var_341eaaa8.var_a9577a5)) {
                        str_status = "<dev string:x108>";
                    } else {
                        str_status = "<dev string:x111>";
                    }
                    /#
                        str_text = "<dev string:x125>" + var_341eaaa8.var_a9577a5 + "<dev string:x135>" + var_341eaaa8.var_8edc2513 + "<dev string:x119>" + str_status + "<dev string:x13d>";
                        var_81e9aa1a += n_y_offset;
                        debug2dtext((800, var_81e9aa1a, 0), str_text, (0, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
                    #/
                    n_total_count = 0;
                    var_31561fde = 0;
                    foreach (var_642557c1 in var_341eaaa8.var_f8179a0f) {
                        n_total_count += var_642557c1.var_367bd3a2;
                        var_31561fde += var_642557c1.var_c49b9272;
                    }
                    /#
                        str_text = "<dev string:x145>" + n_total_count + "<dev string:x157>" + var_31561fde + "<dev string:x58>";
                        var_81e9aa1a += n_y_offset;
                        debug2dtext((800, var_81e9aa1a, 0), str_text, (0, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
                        var_81e9aa1a += n_y_offset;
                        debug2dtext((800, var_81e9aa1a, 0), "<dev string:xd8>", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
                    #/
                    if (isdefined(var_341eaaa8.var_f8179a0f)) {
                        var_81e9aa1a += n_y_offset;
                        var_1b71cd8d = 1;
                        foreach (var_642557c1 in var_341eaaa8.var_f8179a0f) {
                            if (function_39423d35(var_642557c1)) {
                                str_status = "<dev string:x11d>";
                            } else if (function_7b0fa35a(var_642557c1)) {
                                str_status = "<dev string:x166>";
                            } else {
                                str_status = "<dev string:x111>";
                            }
                            /#
                                str_text = "<dev string:x175>" + var_1b71cd8d + "<dev string:x180>" + var_642557c1.var_1265f1d6 + "<dev string:x18b>" + var_642557c1.var_367bd3a2 + "<dev string:x119>" + str_status + "<dev string:x193>";
                                debug2dtext((800, var_81e9aa1a, 0), str_text, (1, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
                                var_81e9aa1a += var_6d872969;
                            #/
                            var_1b71cd8d++;
                        }
                    }
                    if (isdefined(var_341eaaa8.var_f8179a0f)) {
                        var_1b71cd8d = 1;
                        foreach (var_642557c1 in var_341eaaa8.var_f8179a0f) {
                            foreach (ai in var_642557c1.var_16873967) {
                                if (isdefined(ai)) {
                                    /#
                                        sphere(ai.origin, 4, (0, 0, 1), 1, 0, 8, 1);
                                        print3d(ai.origin + (0, 0, 10), "<dev string:x196>" + var_341eaaa8.var_a9577a5 + "<dev string:x19c>" + var_1b71cd8d, (0, 0, 1), 1, 0.5, 1);
                                    #/
                                    if (isdefined(var_341eaaa8.var_2aaace40)) {
                                        /#
                                            line(ai.origin + (0, 0, 30), var_341eaaa8.var_2aaace40.origin, (0, 0, 1), 1, 0, 1);
                                        #/
                                        continue;
                                    }
                                    if (isdefined(level.players[0])) {
                                        /#
                                            origin = level.players[0].origin + vectorscale(anglestoforward(level.players[0].angles), 100);
                                            line(ai.origin + (0, 0, 30), origin, (0, 0, 1), 1, 0, 1);
                                        #/
                                    }
                                }
                            }
                            var_1b71cd8d++;
                        }
                    }
                    if (isdefined(var_341eaaa8.var_56de1d33)) {
                        foreach (var_f745aa07, v in var_341eaaa8.var_56de1d33) {
                            foreach (ai in v) {
                                if (isdefined(ai)) {
                                    /#
                                        sphere(ai.origin, 4, (1, 0, 0), 1, 0, 8, 1);
                                        print3d(ai.origin + (0, 0, 10), "<dev string:x196>" + var_f745aa07, (1, 0, 0), 1, 0.5, 1);
                                    #/
                                    if (isdefined(var_341eaaa8.var_2aaace40)) {
                                        /#
                                            line(ai.origin + (0, 0, 30), var_341eaaa8.var_2aaace40.origin, (1, 0, 0), 1, 0, 1);
                                        #/
                                        continue;
                                    }
                                    if (isdefined(level.players[0])) {
                                        /#
                                            origin = level.players[0].origin + vectorscale(anglestoforward(level.players[0].angles), 100);
                                            line(ai.origin + (0, 0, 30), origin, (1, 0, 0), 1, 0, 1);
                                        #/
                                    }
                                }
                            }
                        }
                    }
                    if (isdefined(var_341eaaa8.var_2aaace40)) {
                        /#
                            sphere(var_341eaaa8.var_2aaace40.origin, 30, (0, 0, 1), 1, 0, 20, 1);
                        #/
                    }
                    if (isdefined(var_341eaaa8.var_f3403408) && isarray(var_341eaaa8.var_f3403408)) {
                        foreach (var_ea6d1824 in var_341eaaa8.var_f3403408) {
                            /#
                                sphere(var_ea6d1824.origin, 4, (0, 1, 0), 1, 0, 8, 1);
                                print3d(var_ea6d1824.origin + (0, 0, 10), function_15979fa9(var_ea6d1824.archetype), (0, 1, 0), 1, 0.5, 1);
                                line(var_ea6d1824.origin, var_ea6d1824.origin + (0, 0, 45), (0, 1, 0), 1, 0, 1);
                            #/
                        }
                    }
                }
            }
            waitframe(1);
        }
    }

#/

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0x7ddc89b3, Offset: 0x1538
// Size: 0x15c
function private function_e4be50e1() {
    self namespace_8955127e::register_callback("script_enable_on_success", &wave_manager::start);
    self namespace_8955127e::register_callback("script_enable_on_failure", &wave_manager::start);
    self namespace_8955127e::register_callback("script_enable_no_specialist", &wave_manager::start);
    self namespace_8955127e::register_callback("script_disable_on_success", &wave_manager::stop);
    self namespace_8955127e::register_callback("script_disable_on_failure", &wave_manager::stop);
    self namespace_8955127e::register_custom_callback("breadcrumb", "script_enable_on_success", &function_17cb4d69);
    self namespace_8955127e::register_custom_callback("breadcrumb", "script_enable_on_failure", &function_17cb4d69);
    self namespace_8955127e::register_custom_callback("breadcrumb", "script_enable_no_specialist", &function_17cb4d69);
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0xdbd3db69, Offset: 0x16a0
// Size: 0x148
function private function_4583bfd0() {
    foreach (var_ca698447 in trigger::get_all()) {
        var_962ab8f0 = [];
        foreach (s_wave_manager in level.a_s_wave_managers) {
            if (isdefined(var_ca698447.target) && var_ca698447.target === s_wave_manager.targetname) {
                array::add(var_962ab8f0, s_wave_manager);
            }
        }
        if (var_962ab8f0.size) {
            var_ca698447 thread function_a47f087e(var_962ab8f0);
        }
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x7d51f5a6, Offset: 0x17f0
// Size: 0xa8
function private function_a47f087e(var_962ab8f0) {
    self endon(#"death");
    self trigger::wait_till();
    foreach (s_wave_manager in var_962ab8f0) {
        s_wave_manager wave_manager::start();
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0x99f98343, Offset: 0x18a0
// Size: 0x1d8
function private function_172065a5() {
    foreach (s_wave_manager in level.a_s_wave_managers) {
        if (isdefined(level.var_fee90489) && isdefined(s_wave_manager.script_enable_on_skipto)) {
            foreach (var_6194780b in level.var_fee90489) {
                if (var_6194780b == s_wave_manager.script_enable_on_skipto) {
                    s_wave_manager wave_manager::start();
                    s_wave_manager.var_cd8ec17f = 1;
                }
            }
        }
    }
    foreach (s_wave_manager in level.a_s_wave_managers) {
        if (isdefined(s_wave_manager.script_enable_on_start) && s_wave_manager.script_enable_on_start && !(isdefined(s_wave_manager.var_cd8ec17f) && s_wave_manager.var_cd8ec17f)) {
            s_wave_manager wave_manager::start();
        }
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 3, eflags: 0x4
// Checksum 0xd47081ce, Offset: 0x1a80
// Size: 0x34
function private function_17cb4d69(e_player, var_72acec4c, b_branch) {
    start_internal(self);
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xc01c3aea, Offset: 0x1ac0
// Size: 0x14e
function private init_flags(var_341eaaa8) {
    assert(isdefined(var_341eaaa8));
    var_341eaaa8 flag::init("complete");
    var_341eaaa8 flag::init("cleared");
    var_341eaaa8 flag::init("paused");
    var_341eaaa8 flag::init("stopped");
    var_341eaaa8 flag::init("all_dead");
    for (n_wave = 1; n_wave <= var_341eaaa8.var_8edc2513; n_wave++) {
        var_341eaaa8 flag::init("wave" + n_wave + "_complete");
        var_341eaaa8 flag::init("wave" + n_wave + "_cleared");
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x68cb5770, Offset: 0x1c18
// Size: 0xfe
function private reset(var_341eaaa8) {
    assert(isdefined(var_341eaaa8));
    var_341eaaa8 flag::clear("complete");
    var_341eaaa8 flag::clear("cleared");
    for (n_wave = 1; n_wave <= var_341eaaa8.var_8edc2513; n_wave++) {
        var_341eaaa8 flag::clear("wave" + n_wave + "_complete");
        var_341eaaa8 flag::clear("wave" + n_wave + "_cleared");
    }
    var_341eaaa8.var_a9577a5 = 1;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x4ff48b7e, Offset: 0x1d20
// Size: 0x7c
function private function_8d79ea5d(var_341eaaa8) {
    var_341eaaa8 flag::set("wave" + var_341eaaa8.var_a9577a5 + "_complete");
    if (var_341eaaa8.var_a9577a5 == var_341eaaa8.var_8edc2513) {
        var_341eaaa8 flag::set("complete");
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0x6befdcfd, Offset: 0x1da8
// Size: 0x6c
function private function_43f49887(var_341eaaa8, n_wave) {
    if (isdefined(n_wave)) {
        return var_341eaaa8 flag::get("wave" + n_wave + "_complete");
    }
    return var_341eaaa8 flag::get("complete");
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0x24b32b1f, Offset: 0x1e20
// Size: 0x6c
function private function_88dfbd16(var_341eaaa8, n_wave) {
    if (isdefined(n_wave)) {
        var_341eaaa8 flag::wait_till("wave" + n_wave + "_complete");
        return;
    }
    var_341eaaa8 flag::wait_till("complete");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x3186415, Offset: 0x1e98
// Size: 0x74
function private function_d11a8a74(var_341eaaa8) {
    var_341eaaa8 flag::set("wave" + var_341eaaa8.var_a9577a5 + "_cleared");
    if (var_341eaaa8.var_a9577a5 == var_341eaaa8.var_8edc2513) {
        function_70e47c4a(var_341eaaa8);
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0x9f203cd1, Offset: 0x1f18
// Size: 0x6c
function private function_bdf8c402(var_341eaaa8, n_wave) {
    if (isdefined(n_wave)) {
        return var_341eaaa8 flag::get("wave" + n_wave + "_cleared");
    }
    return var_341eaaa8 flag::get("cleared");
}

// Namespace wave_manager_sys/wave_manager
// Params 3, eflags: 0x4
// Checksum 0xc7055093, Offset: 0x1f90
// Size: 0x9c
function private function_18dfdf79(var_341eaaa8, n_wave, var_e6146cfe) {
    if (isdefined(n_wave)) {
        var_341eaaa8 flag::wait_till("wave" + n_wave + "_cleared");
        return;
    }
    if (var_e6146cfe) {
        var_341eaaa8 flag::wait_till("all_dead");
        return;
    }
    var_341eaaa8 flag::wait_till("cleared");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xd5f2a908, Offset: 0x2038
// Size: 0x258
function private function_70e47c4a(var_341eaaa8) {
    var_341eaaa8 flag::set("cleared");
    if (isdefined(var_341eaaa8.var_8bf660aa) && var_341eaaa8.var_8bf660aa) {
        return;
    }
    var_341eaaa8 flag::set("stopped");
    var_341eaaa8.var_2aaace40 = undefined;
    var_341eaaa8.m_s_bundle = undefined;
    var_341eaaa8.var_f8179a0f = undefined;
    var_341eaaa8.var_a9577a5 = undefined;
    var_341eaaa8.var_8edc2513 = undefined;
    var_341eaaa8.var_52719fc2 = undefined;
    var_341eaaa8.var_f3403408 = undefined;
    if (isdefined(var_341eaaa8.var_56de1d33)) {
        if (var_341eaaa8.var_d7eda565) {
            foreach (var_b7fd693 in var_341eaaa8.var_56de1d33) {
                var_b7fd693 = array::remove_dead(var_b7fd693);
                array::thread_all(var_b7fd693, &util::auto_delete);
            }
        }
        thread function_3a57d4df(var_341eaaa8);
        if (var_341eaaa8.var_f4ed1c57) {
            a_spawners = getspawnerarray(var_341eaaa8.var_a3d5a8ad, "targetname");
            if (isdefined(a_spawners) && a_spawners.size) {
                foreach (spawner in a_spawners) {
                    if (isdefined(spawner)) {
                        spawner delete();
                    }
                }
            }
        }
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0xd52303d2, Offset: 0x2298
// Size: 0x19e
function private stop_internal(var_341eaaa8, var_b4611c71) {
    if (var_341eaaa8 flag::get("stopped") || var_341eaaa8 flag::get("cleared") && !(isdefined(var_341eaaa8.var_8bf660aa) && var_341eaaa8.var_8bf660aa)) {
        return;
    }
    if (var_b4611c71) {
        var_341eaaa8.var_d7eda565 = 1;
    }
    function_f9edd069(var_341eaaa8);
    var_341eaaa8 flag::set("stopped");
    var_341eaaa8 flag::set("complete");
    for (n_wave = 1; n_wave <= var_341eaaa8.var_8edc2513; n_wave++) {
        var_341eaaa8 flag::set("wave" + n_wave + "_complete");
        if (var_341eaaa8.var_a9577a5 < n_wave) {
            var_341eaaa8 flag::set("wave" + n_wave + "_cleared");
        }
    }
    var_341eaaa8.var_8edc2513 = var_341eaaa8.var_a9577a5;
}

// Namespace wave_manager_sys/wave_manager
// Params 6, eflags: 0x4
// Checksum 0xe0efa5f8, Offset: 0x2440
// Size: 0x450
function private start_internal(s_wave_manager_struct, str_team, b_looping, str_wavemanager, var_b88be120, var_20097276) {
    var_341eaaa8 = new cwavemanager();
    var_341eaaa8.m_s_bundle = struct::get_script_bundle("wave_manager", isdefined(str_wavemanager) ? str_wavemanager : s_wave_manager_struct.scriptbundlename);
    var_341eaaa8.var_15bcffcf = get_unique_id();
    var_341eaaa8.var_ea8ccd6c = var_341eaaa8.m_s_bundle.name;
    if (isdefined(s_wave_manager_struct)) {
        var_341eaaa8.var_2aaace40 = s_wave_manager_struct;
        s_wave_manager_struct.var_341eaaa8 = var_341eaaa8;
        if (isdefined(s_wave_manager_struct.target)) {
            var_341eaaa8.var_a3d5a8ad = s_wave_manager_struct.target;
        }
        var_341eaaa8.m_str_team = util::get_team_mapping(s_wave_manager_struct.script_team);
        var_341eaaa8.var_8bf660aa = isdefined(s_wave_manager_struct.script_looping) && s_wave_manager_struct.script_looping;
        var_341eaaa8.var_d7eda565 = isdefined(s_wave_manager_struct.script_auto_delete) && s_wave_manager_struct.script_auto_delete;
        if (isdefined(s_wave_manager_struct.var_6d11fb56)) {
            foreach (var_4a0da3e in s_wave_manager_struct.var_6d11fb56) {
                if (!isdefined(var_341eaaa8.var_52719fc2)) {
                    var_341eaaa8.var_52719fc2 = [];
                } else if (!isarray(var_341eaaa8.var_52719fc2)) {
                    var_341eaaa8.var_52719fc2 = array(var_341eaaa8.var_52719fc2);
                }
                if (!isinarray(var_341eaaa8.var_52719fc2, var_4a0da3e)) {
                    var_341eaaa8.var_52719fc2[var_341eaaa8.var_52719fc2.size] = var_4a0da3e;
                }
            }
        }
    } else {
        var_341eaaa8.m_str_team = str_team;
        var_341eaaa8.var_8bf660aa = b_looping;
        if (isdefined(var_b88be120)) {
            var_341eaaa8.var_a3d5a8ad = var_b88be120;
        }
    }
    var_341eaaa8.var_8edc2513 = var_341eaaa8.m_s_bundle.wavecount;
    if (isdefined(var_20097276)) {
        if (!isdefined(var_341eaaa8.var_52719fc2)) {
            var_341eaaa8.var_52719fc2 = [];
        } else if (!isarray(var_341eaaa8.var_52719fc2)) {
            var_341eaaa8.var_52719fc2 = array(var_341eaaa8.var_52719fc2);
        }
        if (!isinarray(var_341eaaa8.var_52719fc2, var_20097276)) {
            var_341eaaa8.var_52719fc2[var_341eaaa8.var_52719fc2.size] = var_20097276;
        }
    }
    level.var_28f45c5a[var_341eaaa8.var_15bcffcf] = var_341eaaa8;
    init_flags(var_341eaaa8);
    thread think(var_341eaaa8);
    /#
        update_devgui();
    #/
    if (isdefined(s_wave_manager_struct)) {
        s_wave_manager_struct flag::set("wave_manager_started");
    }
    return var_341eaaa8;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xc5d4089a, Offset: 0x2898
// Size: 0x662
function private think(var_341eaaa8) {
    while (true) {
        if (var_341eaaa8 flag::get("stopped")) {
            break;
        }
        if (var_341eaaa8.var_a9577a5 > var_341eaaa8.var_8edc2513) {
            if (isdefined(var_341eaaa8.var_8bf660aa) && var_341eaaa8.var_8bf660aa) {
                reset(var_341eaaa8);
            } else {
                break;
            }
        }
        var_d7e4cb56 = var_341eaaa8.m_s_bundle.waves[var_341eaaa8.var_a9577a5 - 1];
        var_e9e340bd = isdefined(var_d7e4cb56.transitioncount) ? var_d7e4cb56.transitioncount : 0;
        var_a39645e4 = isdefined(var_d7e4cb56.transitiondelaymin) ? var_d7e4cb56.transitiondelaymin : 0;
        var_e0fa50fa = isdefined(var_d7e4cb56.transitiondelaymax) ? var_d7e4cb56.transitiondelaymax : 0;
        if (var_a39645e4 < var_e0fa50fa) {
            var_301776fd = randomfloatrange(var_a39645e4, var_e0fa50fa);
        } else {
            var_301776fd = var_a39645e4;
        }
        var_341eaaa8.var_f8179a0f = [];
        for (var_d65497b5 = 0; var_d65497b5 < var_d7e4cb56.spawns.size; var_d65497b5++) {
            var_a3c541ed = var_d7e4cb56.spawns[var_d65497b5];
            if (function_bd534657(var_a3c541ed)) {
                var_642557c1 = new class_fdc85a6b();
                var_642557c1.var_9a7983f9 = var_a3c541ed;
                var_642557c1.var_9a27d504 = var_d65497b5;
                if (!isdefined(var_341eaaa8.var_f8179a0f)) {
                    var_341eaaa8.var_f8179a0f = [];
                } else if (!isarray(var_341eaaa8.var_f8179a0f)) {
                    var_341eaaa8.var_f8179a0f = array(var_341eaaa8.var_f8179a0f);
                }
                var_341eaaa8.var_f8179a0f[var_341eaaa8.var_f8179a0f.size] = var_642557c1;
                thread function_a8fe53d6(var_341eaaa8, var_642557c1);
                continue;
            }
            /#
                println("<dev string:x1aa>" + var_d65497b5 + 1 + "<dev string:x1cd>");
                iprintln("<dev string:x1aa>" + var_d65497b5 + 1 + "<dev string:x1cd>");
            #/
        }
        while (true) {
            b_transition_into_next_wave = 1;
            b_wave_complete = 1;
            b_wave_cleared = 1;
            foreach (var_642557c1 in var_341eaaa8.var_f8179a0f) {
                if (!function_7b0fa35a(var_642557c1)) {
                    b_wave_complete = 0;
                    break;
                }
            }
            if (!isdefined(var_e9e340bd) || var_e9e340bd == 0) {
                foreach (var_642557c1 in var_341eaaa8.var_f8179a0f) {
                    if (!function_39423d35(var_642557c1)) {
                        b_wave_cleared = 0;
                        b_transition_into_next_wave = 0;
                        break;
                    }
                }
            } else if (b_wave_complete) {
                var_7fe92ae0 = 0;
                foreach (var_642557c1 in var_341eaaa8.var_f8179a0f) {
                    if (isdefined(var_642557c1.var_16873967)) {
                        var_7fe92ae0 += var_642557c1.var_16873967.size;
                    }
                }
                if (var_7fe92ae0 > var_e9e340bd) {
                    b_wave_cleared = 0;
                    b_transition_into_next_wave = 0;
                }
            } else {
                foreach (var_642557c1 in var_341eaaa8.var_f8179a0f) {
                    if (!function_39423d35(var_642557c1)) {
                        b_wave_cleared = 0;
                        b_transition_into_next_wave = 0;
                        break;
                    }
                }
            }
            if (b_wave_complete) {
                function_8d79ea5d(var_341eaaa8);
            }
            if (b_wave_cleared) {
                function_f9edd069(var_341eaaa8);
                function_d11a8a74(var_341eaaa8);
            }
            if (b_transition_into_next_wave) {
                break;
            }
            wait 0.1;
        }
        if (isdefined(var_341eaaa8.var_a9577a5)) {
            var_341eaaa8.var_a9577a5++;
        }
        wait var_301776fd + 0.1;
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0xce16550a, Offset: 0x2f08
// Size: 0x100
function private function_8665d954(var_341eaaa8, ai) {
    assert(isdefined(var_341eaaa8), "<dev string:x1f8>");
    assert(isdefined(ai), "<dev string:x238>");
    if (isdefined(var_341eaaa8.var_52719fc2)) {
        foreach (var_20097276 in var_341eaaa8.var_52719fc2) {
            if (isdefined(var_20097276.var_ea85bc8d)) {
                util::single_thread_argarray(ai, var_20097276.var_ea85bc8d, var_20097276.a_params);
            }
        }
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xdfaa5494, Offset: 0x3010
// Size: 0x284
function private function_f9edd069(var_341eaaa8) {
    if (!isdefined(var_341eaaa8.var_56de1d33)) {
        var_341eaaa8.var_56de1d33 = [];
    }
    foreach (var_642557c1 in var_341eaaa8.var_f8179a0f) {
        var_642557c1.var_16873967 = array::remove_dead(var_642557c1.var_16873967);
        if (var_642557c1.var_16873967.size) {
            if (!isdefined(var_341eaaa8.var_56de1d33[var_341eaaa8.var_a9577a5])) {
                var_341eaaa8.var_56de1d33[var_341eaaa8.var_a9577a5] = [];
            }
            foreach (ai in var_642557c1.var_16873967) {
                if (!isdefined(var_341eaaa8.var_56de1d33[var_341eaaa8.var_a9577a5])) {
                    var_341eaaa8.var_56de1d33[var_341eaaa8.var_a9577a5] = [];
                } else if (!isarray(var_341eaaa8.var_56de1d33[var_341eaaa8.var_a9577a5])) {
                    var_341eaaa8.var_56de1d33[var_341eaaa8.var_a9577a5] = array(var_341eaaa8.var_56de1d33[var_341eaaa8.var_a9577a5]);
                }
                if (!isinarray(var_341eaaa8.var_56de1d33[var_341eaaa8.var_a9577a5], ai)) {
                    var_341eaaa8.var_56de1d33[var_341eaaa8.var_a9577a5][var_341eaaa8.var_56de1d33[var_341eaaa8.var_a9577a5].size] = ai;
                }
            }
        }
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x262ff0bc, Offset: 0x32a0
// Size: 0x56
function private function_3a57d4df(var_341eaaa8) {
    while (function_e63833c(var_341eaaa8)) {
        wait 1;
    }
    var_341eaaa8 flag::set("all_dead");
    var_341eaaa8.var_56de1d33 = undefined;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xb310d0fa, Offset: 0x3300
// Size: 0x9c
function private function_e63833c(var_341eaaa8) {
    foreach (a_ai in var_341eaaa8.var_56de1d33) {
        a_ai = array::remove_dead(a_ai);
        if (a_ai.size) {
            return true;
        }
    }
    return false;
}

// Namespace wave_manager_sys/wave_manager
// Params 3, eflags: 0x4
// Checksum 0x59f90c73, Offset: 0x33a8
// Size: 0x55a
function private function_d7d758c5(var_341eaaa8, n_wave, var_ec728d91) {
    n_spawns = 0;
    if (var_341eaaa8 flag::get("stopped")) {
        if (var_ec728d91) {
            if (isdefined(var_341eaaa8.var_56de1d33)) {
                if (isdefined(n_wave)) {
                    if (isdefined(var_341eaaa8.var_56de1d33[n_wave])) {
                        var_341eaaa8.var_56de1d33[n_wave] = array::remove_dead(var_341eaaa8.var_56de1d33[n_wave]);
                        foreach (ai in var_341eaaa8.var_56de1d33[n_wave]) {
                            n_spawns++;
                        }
                    }
                } else {
                    foreach (var_b7fd693 in var_341eaaa8.var_56de1d33) {
                        var_b7fd693 = array::remove_dead(var_b7fd693);
                        foreach (ai in var_b7fd693) {
                            n_spawns++;
                        }
                    }
                }
            }
        }
    } else {
        for (i = 1; i <= var_341eaaa8.var_8edc2513; i++) {
            if (isdefined(n_wave)) {
                if (i < n_wave) {
                    continue;
                } else if (i > n_wave) {
                    break;
                }
            }
            if (i < var_341eaaa8.var_a9577a5) {
                if (var_ec728d91) {
                    if (isdefined(var_341eaaa8.var_56de1d33)) {
                        if (isdefined(var_341eaaa8.var_56de1d33[i])) {
                            var_341eaaa8.var_56de1d33[i] = array::remove_dead(var_341eaaa8.var_56de1d33[i]);
                            foreach (ai in var_341eaaa8.var_56de1d33[i]) {
                                n_spawns++;
                            }
                        }
                    }
                }
                continue;
            }
            if (i == var_341eaaa8.var_a9577a5) {
                foreach (var_642557c1 in var_341eaaa8.var_f8179a0f) {
                    var_9085194d = var_642557c1.var_367bd3a2 - var_642557c1.var_1265f1d6;
                    if (isdefined(var_642557c1.var_16873967)) {
                        var_642557c1.var_16873967 = array::remove_dead(var_642557c1.var_16873967);
                        var_9085194d += var_642557c1.var_16873967.size;
                    }
                    n_spawns += var_9085194d;
                }
            } else {
                foreach (var_a3c541ed in var_341eaaa8.m_s_bundle.waves[i - 1].spawns) {
                    n_spawns += isdefined(var_a3c541ed.totalcount) ? var_a3c541ed.totalcount : 1;
                }
            }
            if (!var_ec728d91) {
                if (isdefined(var_341eaaa8.m_s_bundle.waves[i - 1].transitioncount)) {
                    n_spawns -= var_341eaaa8.m_s_bundle.waves[i - 1].transitioncount;
                }
            }
        }
    }
    return n_spawns;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x9ba2edcf, Offset: 0x3910
// Size: 0x9c
function private function_fb21d58a(var_642557c1) {
    assert(isdefined(var_642557c1), "<dev string:x26d>");
    var_642557c1 flag::init("spawn_set_" + var_642557c1.var_9a27d504 + "_complete");
    var_642557c1 flag::init("spawn_set_" + var_642557c1.var_9a27d504 + "_cleared");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x39bab2a8, Offset: 0x39b8
// Size: 0x44
function private complete_spawn_set(var_642557c1) {
    var_642557c1 flag::set("spawn_set_" + var_642557c1.var_9a27d504 + "_complete");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xade26117, Offset: 0x3a08
// Size: 0x42
function private function_7b0fa35a(var_642557c1) {
    return var_642557c1 flag::get("spawn_set_" + var_642557c1.var_9a27d504 + "_complete");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xea179b5b, Offset: 0x3a58
// Size: 0x44
function private function_398ef161(var_642557c1) {
    var_642557c1 flag::set("spawn_set_" + var_642557c1.var_9a27d504 + "_cleared");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x621f6459, Offset: 0x3aa8
// Size: 0x42
function private function_39423d35(var_642557c1) {
    return var_642557c1 flag::get("spawn_set_" + var_642557c1.var_9a27d504 + "_cleared");
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0xda9ee372, Offset: 0x3af8
// Size: 0x1024
function private function_a8fe53d6(var_341eaaa8, var_642557c1) {
    function_fb21d58a(var_642557c1);
    var_a3c541ed = var_642557c1.var_9a7983f9;
    var_b34d6c0f = function_6949359d(var_a3c541ed);
    var_642557c1.var_c49b9272 = isdefined(var_a3c541ed.activecount) ? var_a3c541ed.activecount : 1;
    var_642557c1.var_367bd3a2 = isdefined(var_a3c541ed.totalcount) ? var_a3c541ed.totalcount : 1;
    var_647263c2 = isdefined(var_a3c541ed.groupsizemin) ? var_a3c541ed.groupsizemin : 1;
    var_270e58ac = isdefined(var_a3c541ed.groupsizemax) ? var_a3c541ed.groupsizemax : 1;
    if (var_647263c2 < var_270e58ac) {
        var_970843cf = 1;
    } else {
        var_970843cf = 0;
        n_group_size = var_647263c2;
    }
    var_aa521699 = isdefined(var_a3c541ed.var_813afa97) ? var_a3c541ed.var_813afa97 : 1;
    var_c7a0fc85 = isdefined(var_a3c541ed.var_b79d537c) ? var_a3c541ed.var_b79d537c : 0;
    var_f23307cb = isdefined(var_a3c541ed.var_e4a9c7c2) ? var_a3c541ed.var_e4a9c7c2 : 0;
    if (var_c7a0fc85 < var_f23307cb) {
        n_start_delay = randomfloatrange(var_c7a0fc85, var_f23307cb);
    } else {
        n_start_delay = var_c7a0fc85;
    }
    var_e458dc50 = isdefined(var_a3c541ed.spawndelaymin) ? var_a3c541ed.spawndelaymin : 0;
    var_91816d8e = isdefined(var_a3c541ed.spawndelaymax) ? var_a3c541ed.spawndelaymax : 0;
    if (var_e458dc50 < var_91816d8e) {
        var_5dbeadf5 = 1;
    } else {
        var_5dbeadf5 = 0;
        n_spawn_delay = var_e458dc50;
    }
    var_3421d47d = gettime();
    var_a110b9e7 = 1;
    var_15c55736 = 1;
    while (true) {
        if (var_341eaaa8 flag::get("stopped")) {
            break;
        }
        if (var_341eaaa8 flag::get("paused")) {
            wait 0.1;
            continue;
        }
        if (var_b34d6c0f.size == 0) {
            break;
        }
        if (var_642557c1.var_1265f1d6 >= var_642557c1.var_367bd3a2) {
            break;
        }
        var_e0e346bc = 0;
        var_ab509ddf = undefined;
        if (isdefined(var_642557c1.var_16873967)) {
            var_642557c1.var_16873967 = array::remove_dead(var_642557c1.var_16873967);
        }
        foreach (var_8bebffec in var_b34d6c0f) {
            var_8bebffec.var_7d8493e9 = array::remove_dead(var_8bebffec.var_7d8493e9);
        }
        var_62210284 = var_642557c1.var_367bd3a2 - var_642557c1.var_1265f1d6;
        if (var_a110b9e7) {
            if (var_970843cf) {
                var_647263c2 = math::clamp(var_647263c2, 1, var_62210284);
                var_270e58ac = math::clamp(var_270e58ac, 1, var_62210284);
                if (var_647263c2 == var_270e58ac) {
                    n_group_size = var_647263c2;
                } else {
                    n_group_size = randomintrange(var_647263c2, var_270e58ac + 1);
                }
            } else {
                n_group_size = math::clamp(n_group_size, 1, var_62210284);
            }
            if (var_15c55736) {
                var_8444974 = n_start_delay;
                var_15c55736 = 0;
            } else {
                if (var_5dbeadf5) {
                    n_spawn_delay = randomfloatrange(var_e458dc50, var_91816d8e);
                }
                var_8444974 = n_spawn_delay;
            }
        }
        var_a110b9e7 = 0;
        if (!isdefined(var_642557c1.var_16873967) || var_642557c1.var_16873967.size < var_642557c1.var_c49b9272) {
            var_ab509ddf = var_642557c1.var_c49b9272 - var_642557c1.var_16873967.size;
            var_b981ff57 = function_a74fcff9(var_b34d6c0f);
            if (var_ab509ddf >= n_group_size && var_b981ff57.size) {
                var_62022462 = gettime() - var_3421d47d;
                var_65f4dc49 = float(var_62022462);
                if (var_65f4dc49 >= int(var_8444974 * 1000)) {
                    var_e0e346bc = 1;
                }
            }
        }
        if (!var_e0e346bc) {
            wait 0.1;
            continue;
        }
        var_83310bb6 = 0;
        assert(isdefined(var_ab509ddf), "<dev string:x2a1>");
        var_8e3bb18c = undefined;
        var_8db92885 = undefined;
        var_13ead218 = undefined;
        while (var_83310bb6 < n_group_size) {
            if (n_group_size <= 1) {
                var_13ead218 = undefined;
            }
            if (var_341eaaa8 flag::get("stopped")) {
                break;
            }
            if (var_341eaaa8 flag::get("paused")) {
                wait 0.1;
                continue;
            }
            var_b981ff57 = function_a74fcff9(var_b34d6c0f);
            if (!var_b981ff57.size) {
                /#
                    println("<dev string:x2dd>" + var_341eaaa8.var_ea8ccd6c + "<dev string:x31b>" + var_642557c1.var_9a27d504 + 1 + "<dev string:x332>");
                    iprintln("<dev string:x2dd>" + var_341eaaa8.var_ea8ccd6c + "<dev string:x31b>" + var_642557c1.var_9a27d504 + 1 + "<dev string:x332>");
                #/
                break;
            }
            if (!(isdefined(var_aa521699) && var_aa521699) && isdefined(var_8e3bb18c)) {
                if (!isinarray(var_b981ff57, var_8db92885)) {
                    /#
                        println("<dev string:x346>" + var_8db92885 + "<dev string:x364>" + var_341eaaa8.var_ea8ccd6c + "<dev string:x31b>" + var_642557c1.var_9a27d504 + 1 + "<dev string:x37f>");
                        iprintln("<dev string:x346>" + var_8db92885 + "<dev string:x364>" + var_341eaaa8.var_ea8ccd6c + "<dev string:x31b>" + var_642557c1.var_9a27d504 + 1 + "<dev string:x37f>");
                    #/
                    break;
                }
                var_3e987aab = var_8e3bb18c;
                var_56d259ba = var_8db92885;
            } else {
                var_56d259ba = var_b981ff57[randomint(var_b981ff57.size)];
            }
            spawner::global_spawn_throttle();
            if (!isdefined(var_13ead218) || !isdefined(var_13ead218[#"spawner"]) || var_13ead218[#"spawner"].count < 1 && !(isdefined(var_13ead218[#"spawner"].spawnflags) && (var_13ead218[#"spawner"].spawnflags & 64) == 64)) {
                s_spawn_point = aispawningutility::function_c2f6a5c3(var_341eaaa8.m_str_team, var_341eaaa8.var_a3d5a8ad, var_56d259ba);
                if (!isdefined(s_spawn_point)) {
                    /#
                        println("<dev string:x39f>" + var_56d259ba + "<dev string:x3c7>" + var_341eaaa8.var_ea8ccd6c + "<dev string:x3d9>");
                        iprintln("<dev string:x39f>" + var_56d259ba + "<dev string:x3c7>" + var_341eaaa8.var_ea8ccd6c + "<dev string:x3d9>");
                    #/
                    arrayremoveindex(var_b34d6c0f, var_56d259ba, 1);
                    if (var_b34d6c0f.size > 0 && isdefined(var_aa521699) && var_aa521699) {
                        continue;
                    }
                    break;
                }
            }
            v_origin = isdefined(s_spawn_point) ? s_spawn_point[#"origin"] : (0, 0, 0);
            v_angles = isdefined(s_spawn_point) ? s_spawn_point[#"angles"] : (0, 0, 0);
            var_66b3a491 = isdefined(s_spawn_point) ? s_spawn_point[#"spawner"] : undefined;
            if (n_group_size > 1) {
                var_13ead218 = s_spawn_point;
            }
            if (isdefined(var_66b3a491)) {
                b_infinite_spawn = isdefined(var_66b3a491.spawnflags) && (var_66b3a491.spawnflags & 64) == 64;
                b_force_spawn = isdefined(var_66b3a491.spawnflags) && (var_66b3a491.spawnflags & 16) == 16;
            }
            var_41365c80 = isdefined(var_66b3a491.aitype) && function_791f6cc0(var_66b3a491.aitype);
            if (var_41365c80) {
                if (isdefined(var_66b3a491)) {
                    ai = var_66b3a491 spawnfromspawner(s_spawn_point[#"spawner"].targetname, b_force_spawn, 0, b_infinite_spawn);
                    if (!isdefined(var_341eaaa8.var_f3403408)) {
                        var_341eaaa8.var_f3403408 = [];
                    } else if (!isarray(var_341eaaa8.var_f3403408)) {
                        var_341eaaa8.var_f3403408 = array(var_341eaaa8.var_f3403408);
                    }
                    if (!isinarray(var_341eaaa8.var_f3403408, var_66b3a491)) {
                        var_341eaaa8.var_f3403408[var_341eaaa8.var_f3403408.size] = var_66b3a491;
                    }
                }
            } else if (isdefined(var_66b3a491)) {
                ai = var_66b3a491 spawnfromspawner(s_spawn_point[#"spawner"].targetname, b_force_spawn, 0, b_infinite_spawn);
                if (!isdefined(var_341eaaa8.var_f3403408)) {
                    var_341eaaa8.var_f3403408 = [];
                } else if (!isarray(var_341eaaa8.var_f3403408)) {
                    var_341eaaa8.var_f3403408 = array(var_341eaaa8.var_f3403408);
                }
                if (!isinarray(var_341eaaa8.var_f3403408, var_66b3a491)) {
                    var_341eaaa8.var_f3403408[var_341eaaa8.var_f3403408.size] = var_66b3a491;
                }
            }
            if (isdefined(ai)) {
                function_8665d954(var_341eaaa8, ai);
                if (!isdefined(var_642557c1.var_16873967)) {
                    var_642557c1.var_16873967 = [];
                } else if (!isarray(var_642557c1.var_16873967)) {
                    var_642557c1.var_16873967 = array(var_642557c1.var_16873967);
                }
                var_642557c1.var_16873967[var_642557c1.var_16873967.size] = ai;
                if (!isdefined(var_b34d6c0f[var_56d259ba].var_7d8493e9)) {
                    var_b34d6c0f[var_56d259ba].var_7d8493e9 = [];
                } else if (!isarray(var_b34d6c0f[var_56d259ba].var_7d8493e9)) {
                    var_b34d6c0f[var_56d259ba].var_7d8493e9 = array(var_b34d6c0f[var_56d259ba].var_7d8493e9);
                }
                var_b34d6c0f[var_56d259ba].var_7d8493e9[var_b34d6c0f[var_56d259ba].var_7d8493e9.size] = ai;
                var_3421d47d = gettime();
                var_a110b9e7 = 1;
                var_642557c1.var_1265f1d6++;
                var_83310bb6++;
            }
            var_8e3bb18c = var_3e987aab;
            var_8db92885 = var_56d259ba;
            wait 0.1;
        }
        wait 0.1;
    }
    complete_spawn_set(var_642557c1);
    while (true) {
        var_642557c1.var_16873967 = array::remove_dead(var_642557c1.var_16873967);
        if (!var_642557c1.var_16873967.size) {
            function_398ef161(var_642557c1);
            return;
        }
        wait 0.1;
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0x734556e7, Offset: 0x4b28
// Size: 0x48
function private get_unique_id() {
    if (!isdefined(level.n_wave_manager_id)) {
        level.n_wave_manager_id = 0;
    }
    id = level.n_wave_manager_id;
    level.n_wave_manager_id++;
    return id;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xbdf385b2, Offset: 0x4b78
// Size: 0x98
function private function_bd534657(var_a3c541ed) {
    if (isdefined(var_a3c541ed.spawntypes)) {
        foreach (s_spawn_type in var_a3c541ed.spawntypes) {
            if (isdefined(s_spawn_type.variant)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x491890d9, Offset: 0x4c18
// Size: 0x12e
function private function_6949359d(var_a3c541ed) {
    var_b34d6c0f = [];
    if (isdefined(var_a3c541ed.spawntypes)) {
        foreach (s_spawn_type in var_a3c541ed.spawntypes) {
            if (isdefined(s_spawn_type.variant)) {
                var_a033c737 = isdefined(s_spawn_type.var_b3920099) ? s_spawn_type.var_b3920099 : 0;
                var_8bebffec = {#var_a033c737:var_a033c737, #var_7d8493e9:[], #name:s_spawn_type.variant};
                var_b34d6c0f[s_spawn_type.variant] = var_8bebffec;
            }
        }
    }
    return var_b34d6c0f;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xa269dbf, Offset: 0x4d50
// Size: 0x130
function private function_a74fcff9(var_b34d6c0f) {
    var_b981ff57 = [];
    foreach (v in var_b34d6c0f) {
        var_a033c737 = v.var_a033c737;
        if (var_a033c737 == 0 || v.var_7d8493e9.size < var_a033c737) {
            if (!isdefined(var_b981ff57)) {
                var_b981ff57 = [];
            } else if (!isarray(var_b981ff57)) {
                var_b981ff57 = array(var_b981ff57);
            }
            if (!isinarray(var_b981ff57, v.name)) {
                var_b981ff57[var_b981ff57.size] = v.name;
            }
        }
    }
    return var_b981ff57;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x9903b4a3, Offset: 0x4e88
// Size: 0x318
function private function_ad8c51fe(kvp) {
    var_e1727e63 = [];
    if (isdefined(kvp)) {
        str_key = "targetname";
        str_value = kvp;
        if (isarray(kvp)) {
            str_key = kvp[0];
            str_value = kvp[1];
        }
        a_s_wave_managers = struct::get_array(str_value, str_key);
        a_s_wave_managers = array::filter(a_s_wave_managers, 0, &function_a2d950c1);
        foreach (s_wave_manager in a_s_wave_managers) {
            if (isdefined(s_wave_manager.var_341eaaa8)) {
                if (!isdefined(var_e1727e63)) {
                    var_e1727e63 = [];
                } else if (!isarray(var_e1727e63)) {
                    var_e1727e63 = array(var_e1727e63);
                }
                if (!isinarray(var_e1727e63, s_wave_manager.var_341eaaa8)) {
                    var_e1727e63[var_e1727e63.size] = s_wave_manager.var_341eaaa8;
                }
            }
        }
        assert(a_s_wave_managers.size, "<dev string:x408>" + str_key + "<dev string:x42a>" + str_value + "<dev string:x42e>");
    } else {
        var_8c21c9f2 = self;
        if (!isdefined(var_8c21c9f2)) {
            var_8c21c9f2 = [];
        } else if (!isarray(var_8c21c9f2)) {
            var_8c21c9f2 = array(var_8c21c9f2);
        }
        foreach (var_541cb73b in var_8c21c9f2) {
            var_341eaaa8 = var_541cb73b function_73a0480c();
            if (isdefined(var_341eaaa8)) {
                if (!isdefined(var_e1727e63)) {
                    var_e1727e63 = [];
                } else if (!isarray(var_e1727e63)) {
                    var_e1727e63 = array(var_e1727e63);
                }
                var_e1727e63[var_e1727e63.size] = var_341eaaa8;
            }
        }
    }
    return var_e1727e63;
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0x9ad67b83, Offset: 0x51a8
// Size: 0x178
function private function_3f99ed0d(kvp, b_assert = 1) {
    a_s_wave_managers = [];
    if (isdefined(kvp)) {
        if (isarray(kvp)) {
            str_value = kvp[0];
            str_key = kvp[1];
        } else {
            str_value = kvp;
            str_key = "targetname";
        }
        a_s_wave_managers = struct::get_array(str_value, str_key);
    } else {
        a_s_wave_managers = self;
        if (!isdefined(a_s_wave_managers)) {
            a_s_wave_managers = [];
        } else if (!isarray(a_s_wave_managers)) {
            a_s_wave_managers = array(a_s_wave_managers);
        }
    }
    a_s_wave_managers = array::filter(a_s_wave_managers, 0, &function_a2d950c1);
    if (b_assert) {
        assert(a_s_wave_managers.size, isdefined(kvp) ? "<dev string:x408>" + str_key + "<dev string:x42a>" + str_value + "<dev string:x42e>" : "<dev string:x430>");
    }
    return a_s_wave_managers;
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0xbffc85, Offset: 0x5328
// Size: 0x7e
function private function_73a0480c() {
    if (isinarray(level.a_s_wave_managers, self)) {
        if (isdefined(self.var_341eaaa8)) {
            return self.var_341eaaa8;
        } else {
            return undefined;
        }
    } else if (self function_a7b551aa()) {
        return self;
    }
    assertmsg("<dev string:x44b>");
    return undefined;
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0x5431ac17, Offset: 0x53b0
// Size: 0x32
function private function_a7b551aa() {
    if (isdefined(self.var_15bcffcf) && level.var_28f45c5a[self.var_15bcffcf] == self) {
        return true;
    }
    return false;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xaa12c319, Offset: 0x53f0
// Size: 0x2a
function private function_a2d950c1(var_915f9cbd) {
    return isinarray(level.a_s_wave_managers, var_915f9cbd);
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0xd269b5ac, Offset: 0x5428
// Size: 0x1ce
function private function_b9d60b33(n_wave, var_ec728d91) {
    s_bundle = struct::get_script_bundle("wave_manager", self.scriptbundlename);
    n_ai_count = 0;
    foreach (n_index, s_wave in s_bundle.waves) {
        if (isdefined(n_wave)) {
            if (n_index < n_wave - 1) {
                continue;
            } else if (n_index > n_wave - 1) {
                break;
            }
        }
        var_bcb2310c = 0;
        foreach (var_a3c541ed in s_wave.spawns) {
            var_bcb2310c += isdefined(var_a3c541ed.totalcount) ? var_a3c541ed.totalcount : 1;
        }
        if (!var_ec728d91 && isdefined(s_wave.transitioncount)) {
            var_bcb2310c -= s_wave.transitioncount;
        }
        n_ai_count += var_bcb2310c;
    }
    return n_ai_count;
}

#namespace wave_manager;

// Namespace wave_manager/wave_manager
// Params 3, eflags: 0x20 variadic
// Checksum 0xef95b5f3, Offset: 0x56b8
// Size: 0xf8
function start(kvp, var_ea85bc8d, ...) {
    a_s_wave_managers = self wave_manager_sys::function_3f99ed0d(kvp);
    foreach (s_wave_manager in a_s_wave_managers) {
        var_20097276 = new class_2fce69cd();
        var_20097276.var_ea85bc8d = var_ea85bc8d;
        var_20097276.a_params = vararg;
        wave_manager_sys::start_internal(s_wave_manager, undefined, undefined, undefined, undefined, var_20097276);
    }
}

// Namespace wave_manager/wave_manager
// Params 6, eflags: 0x20 variadic
// Checksum 0x6d19c61, Offset: 0x57b8
// Size: 0xa2
function function_6ede8202(var_3d680ad7, str_team, b_looping = 0, var_b88be120, var_ea85bc8d, ...) {
    var_20097276 = new class_2fce69cd();
    var_20097276.var_ea85bc8d = var_ea85bc8d;
    var_20097276.a_params = vararg;
    return wave_manager_sys::start_internal(undefined, str_team, b_looping, var_3d680ad7, var_b88be120, var_20097276);
}

// Namespace wave_manager/wave_manager
// Params 1, eflags: 0x0
// Checksum 0x51b944a3, Offset: 0x5868
// Size: 0x130
function wait_till_complete(n_wave) {
    var_8c21c9f2 = self;
    if (!isdefined(var_8c21c9f2)) {
        var_8c21c9f2 = [];
    } else if (!isarray(var_8c21c9f2)) {
        var_8c21c9f2 = array(var_8c21c9f2);
    }
    foreach (var_541cb73b in var_8c21c9f2) {
        if (wave_manager_sys::function_a2d950c1(var_541cb73b)) {
            var_541cb73b flag::wait_till("wave_manager_started");
        }
        var_341eaaa8 = var_541cb73b wave_manager_sys::function_73a0480c();
        if (isdefined(var_341eaaa8)) {
            wave_manager_sys::function_88dfbd16(var_341eaaa8, n_wave);
        }
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0x8621cef9, Offset: 0x59a0
// Size: 0x148
function wait_till_cleared(n_wave, var_e6146cfe = 0) {
    var_8c21c9f2 = self;
    if (!isdefined(var_8c21c9f2)) {
        var_8c21c9f2 = [];
    } else if (!isarray(var_8c21c9f2)) {
        var_8c21c9f2 = array(var_8c21c9f2);
    }
    foreach (var_541cb73b in var_8c21c9f2) {
        if (wave_manager_sys::function_a2d950c1(var_541cb73b)) {
            var_541cb73b flag::wait_till("wave_manager_started");
        }
        var_341eaaa8 = var_541cb73b wave_manager_sys::function_73a0480c();
        if (isdefined(var_341eaaa8)) {
            wave_manager_sys::function_18dfdf79(var_341eaaa8, n_wave, var_e6146cfe);
        }
    }
}

// Namespace wave_manager/wave_manager
// Params 0, eflags: 0x0
// Checksum 0x99b8f6fc, Offset: 0x5af0
// Size: 0x130
function function_21f0d926() {
    var_8c21c9f2 = self;
    if (!isdefined(var_8c21c9f2)) {
        var_8c21c9f2 = [];
    } else if (!isarray(var_8c21c9f2)) {
        var_8c21c9f2 = array(var_8c21c9f2);
    }
    foreach (var_541cb73b in var_8c21c9f2) {
        if (wave_manager_sys::function_a2d950c1(var_541cb73b)) {
            var_541cb73b flag::wait_till("wave_manager_started");
        }
        var_341eaaa8 = var_541cb73b wave_manager_sys::function_73a0480c();
        if (isdefined(var_341eaaa8)) {
            var_341eaaa8 flag::wait_till("stopped");
        }
    }
}

// Namespace wave_manager/wave_manager
// Params 0, eflags: 0x0
// Checksum 0x8c5efe13, Offset: 0x5c28
// Size: 0x80
function is_looping() {
    var_341eaaa8 = self wave_manager_sys::function_73a0480c();
    if (isdefined(var_341eaaa8)) {
        return (isdefined(var_341eaaa8.var_8bf660aa) && var_341eaaa8.var_8bf660aa);
    }
    if (wave_manager_sys::function_a2d950c1(self)) {
        return (isdefined(self.script_looping) && self.script_looping);
    }
    return false;
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0x6f969bc9, Offset: 0x5cb0
// Size: 0x1c6
function function_1e9eaadf(kvp, var_6cc2e848) {
    var_e1727e63 = self wave_manager_sys::function_ad8c51fe(kvp);
    foreach (var_341eaaa8 in var_e1727e63) {
        assert(isdefined(var_6cc2e848));
        a_sp_new = getspawnerteamarray(var_341eaaa8.m_str_team);
        var_909f4f28 = 0;
        if (isdefined(a_sp_new) && isarray(a_sp_new) && a_sp_new.size) {
            foreach (sp_new in a_sp_new) {
                if (sp_new.targetname === var_6cc2e848) {
                    var_909f4f28 = 1;
                    break;
                }
            }
        }
        assert(var_909f4f28, "<dev string:x490>" + var_6cc2e848);
        var_341eaaa8.var_a3d5a8ad = var_6cc2e848;
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0xeed97a70, Offset: 0x5e80
// Size: 0x206
function function_e8811971(kvp, var_ff3481ec) {
    a_ai = [];
    var_e1727e63 = self wave_manager_sys::function_ad8c51fe(kvp);
    if (isdefined(var_ff3481ec)) {
        var_ff3481ec--;
    }
    foreach (var_341eaaa8 in var_e1727e63) {
        if (isdefined(var_341eaaa8.var_f8179a0f)) {
            if (isdefined(var_ff3481ec) && var_ff3481ec > 0) {
                if (isdefined(var_341eaaa8.var_f8179a0f[var_ff3481ec])) {
                    a_ai = var_341eaaa8.var_f8179a0f[var_ff3481ec].var_16873967;
                }
            } else {
                foreach (var_642557c1 in var_341eaaa8.var_f8179a0f) {
                    foreach (ai in var_642557c1.var_16873967) {
                        a_ai[a_ai.size] = ai;
                    }
                }
            }
            a_ai = array::remove_dead(a_ai);
        }
    }
    return a_ai;
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0x14e365c6, Offset: 0x6090
// Size: 0x3f6
function function_2f79f7c0(kvp, n_wave) {
    a_ai = [];
    var_e1727e63 = self wave_manager_sys::function_ad8c51fe(kvp);
    foreach (var_341eaaa8 in var_e1727e63) {
        if (isdefined(var_341eaaa8.var_f8179a0f)) {
            if (!isdefined(n_wave) || n_wave === var_341eaaa8.var_a9577a5) {
                foreach (var_642557c1 in var_341eaaa8.var_f8179a0f) {
                    foreach (ai in var_642557c1.var_16873967) {
                        a_ai[a_ai.size] = ai;
                    }
                }
            }
        }
        if (isdefined(var_341eaaa8.var_56de1d33)) {
            if (isdefined(n_wave)) {
                if (isdefined(var_341eaaa8.var_56de1d33[n_wave])) {
                    foreach (ai in var_341eaaa8.var_56de1d33[n_wave]) {
                        if (!isdefined(a_ai)) {
                            a_ai = [];
                        } else if (!isarray(a_ai)) {
                            a_ai = array(a_ai);
                        }
                        if (!isinarray(a_ai, ai)) {
                            a_ai[a_ai.size] = ai;
                        }
                    }
                }
            } else {
                foreach (var_b7fd693 in var_341eaaa8.var_56de1d33) {
                    foreach (ai in var_b7fd693) {
                        if (!isdefined(a_ai)) {
                            a_ai = [];
                        } else if (!isarray(a_ai)) {
                            a_ai = array(a_ai);
                        }
                        if (!isinarray(a_ai, ai)) {
                            a_ai[a_ai.size] = ai;
                        }
                    }
                }
            }
        }
        a_ai = array::remove_dead(a_ai);
    }
    return a_ai;
}

// Namespace wave_manager/wave_manager
// Params 3, eflags: 0x0
// Checksum 0x63ab451c, Offset: 0x6490
// Size: 0x128
function function_e3c64893(kvp, n_wave, var_ec728d91 = 1) {
    a_s_wave_managers = [];
    a_s_wave_managers = self wave_manager_sys::function_3f99ed0d(kvp);
    var_f75cabf9 = 0;
    foreach (s_wave_manager in a_s_wave_managers) {
        if (isdefined(s_wave_manager.var_341eaaa8)) {
            var_f75cabf9 += wave_manager_sys::function_d7d758c5(s_wave_manager.var_341eaaa8, n_wave, var_ec728d91);
            continue;
        }
        var_f75cabf9 += s_wave_manager wave_manager_sys::function_b9d60b33(n_wave, var_ec728d91);
    }
    return var_f75cabf9;
}

// Namespace wave_manager/wave_manager
// Params 3, eflags: 0x20 variadic
// Checksum 0x138c6010, Offset: 0x65c0
// Size: 0x37a
function add_spawn_function(kvp, var_ea85bc8d, ...) {
    assert(isdefined(var_ea85bc8d));
    a_s_wave_managers = self wave_manager_sys::function_3f99ed0d(kvp, 0);
    if (a_s_wave_managers.size) {
        foreach (s_wave_manager in a_s_wave_managers) {
            var_20097276 = new class_2fce69cd();
            var_20097276.var_ea85bc8d = var_ea85bc8d;
            var_20097276.a_params = vararg;
            if (isdefined(s_wave_manager.var_341eaaa8)) {
                if (!isdefined(s_wave_manager.var_341eaaa8.var_52719fc2)) {
                    s_wave_manager.var_341eaaa8.var_52719fc2 = [];
                } else if (!isarray(s_wave_manager.var_341eaaa8.var_52719fc2)) {
                    s_wave_manager.var_341eaaa8.var_52719fc2 = array(s_wave_manager.var_341eaaa8.var_52719fc2);
                }
                if (!isinarray(s_wave_manager.var_341eaaa8.var_52719fc2, var_20097276)) {
                    s_wave_manager.var_341eaaa8.var_52719fc2[s_wave_manager.var_341eaaa8.var_52719fc2.size] = var_20097276;
                }
                continue;
            }
            if (!isdefined(s_wave_manager.var_6d11fb56)) {
                s_wave_manager.var_6d11fb56 = [];
            } else if (!isarray(s_wave_manager.var_6d11fb56)) {
                s_wave_manager.var_6d11fb56 = array(s_wave_manager.var_6d11fb56);
            }
            if (!isinarray(s_wave_manager.var_6d11fb56, var_20097276)) {
                s_wave_manager.var_6d11fb56[s_wave_manager.var_6d11fb56.size] = var_20097276;
            }
        }
        return;
    }
    if (self wave_manager_sys::function_a7b551aa()) {
        var_20097276 = new class_2fce69cd();
        var_20097276.var_ea85bc8d = var_ea85bc8d;
        var_20097276.a_params = vararg;
        if (!isdefined(self.var_52719fc2)) {
            self.var_52719fc2 = [];
        } else if (!isarray(self.var_52719fc2)) {
            self.var_52719fc2 = array(self.var_52719fc2);
        }
        if (!isinarray(self.var_52719fc2, var_20097276)) {
            self.var_52719fc2[self.var_52719fc2.size] = var_20097276;
        }
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0x88988b75, Offset: 0x6948
// Size: 0x2ee
function remove_spawn_function(kvp, var_ea85bc8d) {
    assert(isdefined(var_ea85bc8d));
    a_s_wave_managers = self wave_manager_sys::function_3f99ed0d(kvp, 0);
    if (a_s_wave_managers.size) {
        foreach (s_wave_manager in a_s_wave_managers) {
            if (isdefined(s_wave_manager.var_341eaaa8)) {
                var_341eaaa8 = s_wave_manager.var_341eaaa8;
                foreach (var_20097276 in var_341eaaa8.var_52719fc2) {
                    if (var_20097276.var_ea85bc8d === var_ea85bc8d) {
                        var_341eaaa8.var_52719fc2 = array::exclude(var_341eaaa8.var_52719fc2, var_20097276);
                    }
                }
            }
            if (isdefined(s_wave_manager.var_6d11fb56)) {
                foreach (var_20097276 in s_wave_manager.var_6d11fb56) {
                    if (var_20097276.var_ea85bc8d === var_ea85bc8d) {
                        s_wave_manager.var_6d11fb56 = array::exclude(s_wave_manager.var_6d11fb56, var_20097276);
                        if (!s_wave_manager.var_6d11fb56.size) {
                            s_wave_manager.var_6d11fb56 = undefined;
                        }
                    }
                }
            }
        }
        return;
    }
    if (self wave_manager_sys::function_a7b551aa()) {
        foreach (var_20097276 in self.var_52719fc2) {
            if (var_20097276.var_ea85bc8d === var_ea85bc8d) {
                self.var_52719fc2 = array::exclude(self.var_52719fc2, var_20097276);
            }
        }
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0xabb60bf4, Offset: 0x6c40
// Size: 0xc0
function stop(kvp, var_b4611c71 = 0) {
    var_e1727e63 = self wave_manager_sys::function_ad8c51fe(kvp);
    foreach (var_341eaaa8 in var_e1727e63) {
        wave_manager_sys::stop_internal(var_341eaaa8, var_b4611c71);
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0xb9a96eba, Offset: 0x6d08
// Size: 0xc0
function pause(kvp, var_b4611c71 = 0) {
    var_e1727e63 = self wave_manager_sys::function_ad8c51fe(kvp);
    foreach (var_341eaaa8 in var_e1727e63) {
        var_341eaaa8 flag::set("paused");
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0xfdec169c, Offset: 0x6dd0
// Size: 0xc0
function resume(kvp, var_b4611c71 = 0) {
    var_e1727e63 = self wave_manager_sys::function_ad8c51fe(kvp);
    foreach (var_341eaaa8 in var_e1727e63) {
        var_341eaaa8 flag::clear("paused");
    }
}

