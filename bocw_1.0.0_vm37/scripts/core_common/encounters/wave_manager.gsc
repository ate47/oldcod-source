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

    var var_23802722;
    var var_246fb97f;
    var var_376c2c29;
    var var_4417045b;
    var var_6da7cde5;
    var var_a709a080;

    // Namespace cwavemanager/wave_manager
    // Params 0, eflags: 0x8
    // Checksum 0xbb51d88e, Offset: 0x238
    // Size: 0x4a
    constructor() {
        var_376c2c29 = [];
        var_4417045b = 1;
        var_23802722 = [];
        var_246fb97f = [];
        var_a709a080 = 0;
        var_6da7cde5 = 1;
    }

}

// Namespace wave_manager_sys
// Method(s) 2 Total 2
class class_2443998c {

    var var_bb290b79;
    var var_bcd4e683;

    // Namespace class_2443998c/wave_manager
    // Params 0, eflags: 0x8
    // Checksum 0x5df05e05, Offset: 0x328
    // Size: 0x1a
    constructor() {
        var_bcd4e683 = 0;
        var_bb290b79 = [];
    }

}

#namespace wave_manager;

// Namespace wave_manager
// Method(s) 2 Total 2
class class_8e39177 {

    var a_params;

    // Namespace class_8e39177/wave_manager
    // Params 0, eflags: 0x8
    // Checksum 0x7769208f, Offset: 0x5440
    // Size: 0xe
    constructor() {
        a_params = [];
    }

}

#namespace wave_manager_sys;

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x6
// Checksum 0xdaa8427b, Offset: 0x1e8
// Size: 0x44
function private autoexec __init__system__() {
    system::register("wave_manager", &preinit, &postinit, undefined, undefined);
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0x488e3a6, Offset: 0x3e8
// Size: 0x5c
function private preinit() {
    level.var_ca74a4bc = [];
    level.a_s_wave_managers = [];
    /#
        setdvar(#"hash_1feb7de8a9fa6573", -1);
        level thread debug_think();
    #/
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0xbf866b2, Offset: 0x450
// Size: 0xf4
function private postinit() {
    level.a_s_wave_managers = struct::get_script_bundle_instances("wave_manager");
    foreach (s_wave_manager in level.a_s_wave_managers) {
        s_wave_manager flag::init("wave_manager_started");
        s_wave_manager function_51ce850d();
    }
    level function_374e4d47();
    level function_ad40f5b3();
}

/#

    // Namespace wave_manager_sys/wave_manager
    // Params 0, eflags: 0x4
    // Checksum 0x4623db0f, Offset: 0x550
    // Size: 0x1a4
    function private update_devgui() {
        if (!isdefined(level.var_a44d1e7)) {
            level.var_a44d1e7 = 0;
        }
        level.var_a44d1e7++;
        str_map_name = util::get_map_name();
        foreach (var_dcd6c23 in level.var_ca74a4bc) {
            var_29b80910 = var_dcd6c23.var_cf3bea8a;
            str_team = var_dcd6c23.m_str_team;
            str_name = var_dcd6c23.var_556afb3d;
            cmd = "<dev string:x38>" + str_map_name + "<dev string:x49>" + str_team + "<dev string:x62>" + "<dev string:x67>" + var_29b80910 + "<dev string:x6c>" + str_name + "<dev string:x71>" + var_29b80910 + "<dev string:x95>";
            adddebugcommand(cmd);
        }
        cmd = "<dev string:x38>" + str_map_name + "<dev string:x9c>";
        adddebugcommand(cmd);
    }

    // Namespace wave_manager_sys/wave_manager
    // Params 0, eflags: 0x4
    // Checksum 0x41c98055, Offset: 0x700
    // Size: 0xe3a
    function private debug_think() {
        while (true) {
            n_wave_manager_id = getdvarint(#"hash_1feb7de8a9fa6573", 0);
            if (n_wave_manager_id != -1) {
                if (isdefined(level.var_ca74a4bc[n_wave_manager_id])) {
                    n_y_offset = 22;
                    var_90fbd845 = 22;
                    var_c708e6e1 = 120;
                    var_dcd6c23 = level.var_ca74a4bc[n_wave_manager_id];
                    var_29b80910 = var_dcd6c23.var_cf3bea8a;
                    str_name = var_dcd6c23.var_556afb3d;
                    if (var_dcd6c23 flag::get("<dev string:xe6>")) {
                        /#
                            var_c708e6e1 += n_y_offset;
                            str_text = str_name + "<dev string:xf1>";
                            debug2dtext((800, var_c708e6e1, 0), str_text, (1, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
                            var_c708e6e1 += n_y_offset;
                            debug2dtext((800, var_c708e6e1, 0), "<dev string:xfe>", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
                        #/
                        waitframe(1);
                        continue;
                    }
                    if (is_true(var_dcd6c23.var_f68bc980) && var_dcd6c23.var_4417045b > var_dcd6c23.var_592f8f7f) {
                        waitframe(1);
                        continue;
                    }
                    str_team = var_dcd6c23.m_str_team;
                    /#
                        var_c708e6e1 += n_y_offset;
                        debug2dtext((800, var_c708e6e1, 0), "<dev string:xfe>", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
                    #/
                    if (is_true(var_dcd6c23.var_f68bc980)) {
                        str_status = "<dev string:x129>";
                    } else if (function_e43e16d2(var_dcd6c23)) {
                        str_status = "<dev string:x134>";
                    } else {
                        str_status = "<dev string:x140>";
                    }
                    /#
                        var_c708e6e1 += n_y_offset;
                        str_text = str_name + "<dev string:x14b>" + str_status + "<dev string:x150>";
                        debug2dtext((800, var_c708e6e1, 0), str_text, (1, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
                        var_c708e6e1 += n_y_offset;
                        debug2dtext((800, var_c708e6e1, 0), "<dev string:xfe>", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
                    #/
                    if (function_a2115dc4(var_dcd6c23, var_dcd6c23.var_4417045b)) {
                        str_status = "<dev string:x155>";
                    } else if (function_e43e16d2(var_dcd6c23, var_dcd6c23.var_4417045b)) {
                        str_status = "<dev string:x134>";
                    } else {
                        str_status = "<dev string:x140>";
                    }
                    /#
                        str_text = "<dev string:x160>" + var_dcd6c23.var_4417045b + "<dev string:x173>" + var_dcd6c23.var_592f8f7f + "<dev string:x14b>" + str_status + "<dev string:x17e>";
                        var_c708e6e1 += n_y_offset;
                        debug2dtext((800, var_c708e6e1, 0), str_text, (0, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
                    #/
                    n_total_count = 0;
                    var_a549e716 = 0;
                    foreach (var_c21b798e in var_dcd6c23.var_376c2c29) {
                        n_total_count += var_c21b798e.var_23791f08;
                        var_a549e716 += var_c21b798e.var_a4202481;
                    }
                    /#
                        str_text = "<dev string:x189>" + n_total_count + "<dev string:x19e>" + var_a549e716 + "<dev string:x6c>";
                        var_c708e6e1 += n_y_offset;
                        debug2dtext((800, var_c708e6e1, 0), str_text, (0, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
                        var_c708e6e1 += n_y_offset;
                        debug2dtext((800, var_c708e6e1, 0), "<dev string:xfe>", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
                    #/
                    if (isdefined(var_dcd6c23.var_376c2c29)) {
                        var_c708e6e1 += n_y_offset;
                        var_1d3b29d6 = 1;
                        foreach (var_c21b798e in var_dcd6c23.var_376c2c29) {
                            if (function_f77ad8a3(var_c21b798e)) {
                                str_status = "<dev string:x155>";
                            } else if (function_9e2b33f4(var_c21b798e)) {
                                str_status = "<dev string:x1b0>";
                            } else {
                                str_status = "<dev string:x140>";
                            }
                            /#
                                str_text = "<dev string:x1c2>" + var_1d3b29d6 + "<dev string:x1d0>" + var_c21b798e.var_bcd4e683 + "<dev string:x1de>" + var_c21b798e.var_23791f08 + "<dev string:x14b>" + str_status + "<dev string:x1e9>";
                                debug2dtext((800, var_c708e6e1, 0), str_text, (1, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
                                var_c708e6e1 += var_90fbd845;
                            #/
                            var_1d3b29d6++;
                        }
                    }
                    if (isdefined(var_dcd6c23.var_376c2c29)) {
                        var_1d3b29d6 = 1;
                        foreach (var_c21b798e in var_dcd6c23.var_376c2c29) {
                            foreach (ai in var_c21b798e.var_bb290b79) {
                                if (isdefined(ai)) {
                                    /#
                                        sphere(ai.origin, 4, (0, 0, 1), 1, 0, 8, 1);
                                        print3d(ai.origin + (0, 0, 10), "<dev string:x1ef>" + var_dcd6c23.var_4417045b + "<dev string:x1f8>" + var_1d3b29d6, (0, 0, 1), 1, 0.5, 1);
                                    #/
                                    if (isdefined(var_dcd6c23.var_3844e966)) {
                                        /#
                                            line(ai.origin + (0, 0, 30), var_dcd6c23.var_3844e966.origin, (0, 0, 1), 1, 0, 1);
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
                            var_1d3b29d6++;
                        }
                    }
                    if (isdefined(var_dcd6c23.var_419edb9f)) {
                        foreach (var_c082553f, v in var_dcd6c23.var_419edb9f) {
                            foreach (ai in v) {
                                if (isdefined(ai)) {
                                    /#
                                        sphere(ai.origin, 4, (1, 0, 0), 1, 0, 8, 1);
                                        print3d(ai.origin + (0, 0, 10), "<dev string:x1ef>" + var_c082553f, (1, 0, 0), 1, 0.5, 1);
                                    #/
                                    if (isdefined(var_dcd6c23.var_3844e966)) {
                                        /#
                                            line(ai.origin + (0, 0, 30), var_dcd6c23.var_3844e966.origin, (1, 0, 0), 1, 0, 1);
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
                    if (isdefined(var_dcd6c23.var_3844e966)) {
                        /#
                            sphere(var_dcd6c23.var_3844e966.origin, 30, (0, 0, 1), 1, 0, 20, 1);
                        #/
                    }
                    if (isdefined(var_dcd6c23.var_246fb97f) && isarray(var_dcd6c23.var_246fb97f)) {
                        foreach (var_fa24a14b in var_dcd6c23.var_246fb97f) {
                            /#
                                sphere(var_fa24a14b.origin, 4, (0, 1, 0), 1, 0, 8, 1);
                                print3d(var_fa24a14b.origin + (0, 0, 10), function_9e72a96(var_fa24a14b.archetype), (0, 1, 0), 1, 0.5, 1);
                                line(var_fa24a14b.origin, var_fa24a14b.origin + (0, 0, 45), (0, 1, 0), 1, 0, 1);
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
// Checksum 0xc99cfc1, Offset: 0x1548
// Size: 0x15c
function private function_51ce850d() {
    self namespace_2e6206f9::register_callback("script_enable_on_success", &wave_manager::start);
    self namespace_2e6206f9::register_callback("script_enable_on_failure", &wave_manager::start);
    self namespace_2e6206f9::register_callback("script_enable_no_specialist", &wave_manager::start);
    self namespace_2e6206f9::register_callback("script_disable_on_success", &wave_manager::stop);
    self namespace_2e6206f9::register_callback("script_disable_on_failure", &wave_manager::stop);
    self namespace_2e6206f9::register_custom_callback("breadcrumb", "script_enable_on_success", &function_710cbc75);
    self namespace_2e6206f9::register_custom_callback("breadcrumb", "script_enable_on_failure", &function_710cbc75);
    self namespace_2e6206f9::register_custom_callback("breadcrumb", "script_enable_no_specialist", &function_710cbc75);
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0x50804d63, Offset: 0x16b0
// Size: 0x160
function private function_374e4d47() {
    foreach (var_7418aa09 in trigger::get_all()) {
        var_a40eadd = [];
        foreach (s_wave_manager in level.a_s_wave_managers) {
            if (isdefined(var_7418aa09.target) && var_7418aa09.target === s_wave_manager.targetname) {
                array::add(var_a40eadd, s_wave_manager);
            }
        }
        if (var_a40eadd.size) {
            var_7418aa09 thread function_be478e08(var_a40eadd);
        }
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xe3b74c09, Offset: 0x1818
// Size: 0xb8
function private function_be478e08(var_a40eadd) {
    self endon(#"death");
    self trigger::wait_till();
    foreach (s_wave_manager in var_a40eadd) {
        s_wave_manager wave_manager::start();
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0x648d373e, Offset: 0x18d8
// Size: 0x1f8
function private function_ad40f5b3() {
    foreach (s_wave_manager in level.a_s_wave_managers) {
        if (isdefined(level.var_28c22d88) && isdefined(s_wave_manager.script_enable_on_skipto)) {
            foreach (var_d3440450 in level.var_28c22d88) {
                if (var_d3440450 == s_wave_manager.script_enable_on_skipto) {
                    s_wave_manager wave_manager::start();
                    s_wave_manager.var_f50b617f = 1;
                }
            }
        }
    }
    foreach (s_wave_manager in level.a_s_wave_managers) {
        if (is_true(s_wave_manager.script_enable_on_start) && !is_true(s_wave_manager.var_f50b617f)) {
            s_wave_manager wave_manager::start();
        }
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 3, eflags: 0x4
// Checksum 0x336ef505, Offset: 0x1ad8
// Size: 0x34
function private function_710cbc75(*e_player, *var_1ad9db60, *b_branch) {
    start_internal(self);
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x5ba16e17, Offset: 0x1b18
// Size: 0x14c
function private init_flags(var_dcd6c23) {
    assert(isdefined(var_dcd6c23));
    var_dcd6c23 flag::init("complete");
    var_dcd6c23 flag::init("cleared");
    var_dcd6c23 flag::init("paused");
    var_dcd6c23 flag::init("stopped");
    var_dcd6c23 flag::init("all_dead");
    for (n_wave = 1; n_wave <= var_dcd6c23.var_592f8f7f; n_wave++) {
        var_dcd6c23 flag::init("wave" + n_wave + "_complete");
        var_dcd6c23 flag::init("wave" + n_wave + "_cleared");
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xd72ab6e1, Offset: 0x1c70
// Size: 0xfa
function private reset(var_dcd6c23) {
    assert(isdefined(var_dcd6c23));
    var_dcd6c23 flag::clear("complete");
    var_dcd6c23 flag::clear("cleared");
    for (n_wave = 1; n_wave <= var_dcd6c23.var_592f8f7f; n_wave++) {
        var_dcd6c23 flag::clear("wave" + n_wave + "_complete");
        var_dcd6c23 flag::clear("wave" + n_wave + "_cleared");
    }
    var_dcd6c23.var_4417045b = 1;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x266b376b, Offset: 0x1d78
// Size: 0x74
function private function_68766ec1(var_dcd6c23) {
    var_dcd6c23 flag::set("wave" + var_dcd6c23.var_4417045b + "_complete");
    if (var_dcd6c23.var_4417045b == var_dcd6c23.var_592f8f7f) {
        var_dcd6c23 flag::set("complete");
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0x2b7448d4, Offset: 0x1df8
// Size: 0x6c
function private function_e43e16d2(var_dcd6c23, n_wave) {
    if (isdefined(n_wave)) {
        return var_dcd6c23 flag::get("wave" + n_wave + "_complete");
    }
    return var_dcd6c23 flag::get("complete");
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0xa388b995, Offset: 0x1e70
// Size: 0x6c
function private function_aa6a8e4a(var_dcd6c23, n_wave) {
    if (isdefined(n_wave)) {
        var_dcd6c23 flag::wait_till("wave" + n_wave + "_complete");
        return;
    }
    var_dcd6c23 flag::wait_till("complete");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x6540e7fb, Offset: 0x1ee8
// Size: 0x6c
function private function_2bba6468(var_dcd6c23) {
    var_dcd6c23 flag::set("wave" + var_dcd6c23.var_4417045b + "_cleared");
    if (var_dcd6c23.var_4417045b == var_dcd6c23.var_592f8f7f) {
        function_d9af887b(var_dcd6c23);
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0xcd66897, Offset: 0x1f60
// Size: 0x6c
function private function_a2115dc4(var_dcd6c23, n_wave) {
    if (isdefined(n_wave)) {
        return var_dcd6c23 flag::get("wave" + n_wave + "_cleared");
    }
    return var_dcd6c23 flag::get("cleared");
}

// Namespace wave_manager_sys/wave_manager
// Params 3, eflags: 0x4
// Checksum 0x940c7b05, Offset: 0x1fd8
// Size: 0x9c
function private function_55525f13(var_dcd6c23, n_wave, var_b8b3e39d) {
    if (isdefined(n_wave)) {
        var_dcd6c23 flag::wait_till("wave" + n_wave + "_cleared");
        return;
    }
    if (var_b8b3e39d) {
        var_dcd6c23 flag::wait_till("all_dead");
        return;
    }
    var_dcd6c23 flag::wait_till("cleared");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x3ca2c4cc, Offset: 0x2080
// Size: 0x260
function private function_d9af887b(var_dcd6c23) {
    var_dcd6c23 flag::set("cleared");
    if (is_true(var_dcd6c23.var_f68bc980)) {
        return;
    }
    var_dcd6c23 flag::set("stopped");
    var_dcd6c23.var_3844e966 = undefined;
    var_dcd6c23.m_s_bundle = undefined;
    var_dcd6c23.var_376c2c29 = undefined;
    var_dcd6c23.var_4417045b = undefined;
    var_dcd6c23.var_592f8f7f = undefined;
    var_dcd6c23.var_23802722 = undefined;
    var_dcd6c23.var_246fb97f = undefined;
    if (isdefined(var_dcd6c23.var_419edb9f)) {
        if (var_dcd6c23.var_a709a080) {
            foreach (var_13528014 in var_dcd6c23.var_419edb9f) {
                function_1eaaceab(var_13528014);
                array::thread_all(var_13528014, &util::auto_delete);
            }
        }
        thread function_30956db0(var_dcd6c23);
        if (var_dcd6c23.var_6da7cde5) {
            a_spawners = getspawnerarray(var_dcd6c23.var_27eacb34, "targetname");
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
// Checksum 0x13461baf, Offset: 0x22e8
// Size: 0x18e
function private stop_internal(var_dcd6c23, var_4bb2faf8) {
    if (var_dcd6c23 flag::get("stopped") || var_dcd6c23 flag::get("cleared") && !is_true(var_dcd6c23.var_f68bc980)) {
        return;
    }
    if (var_4bb2faf8) {
        var_dcd6c23.var_a709a080 = 1;
    }
    function_68ed489(var_dcd6c23);
    var_dcd6c23 flag::set("stopped");
    var_dcd6c23 flag::set("complete");
    for (n_wave = 1; n_wave <= var_dcd6c23.var_592f8f7f; n_wave++) {
        var_dcd6c23 flag::set("wave" + n_wave + "_complete");
        if (var_dcd6c23.var_4417045b < n_wave) {
            var_dcd6c23 flag::set("wave" + n_wave + "_cleared");
        }
    }
    var_dcd6c23.var_592f8f7f = var_dcd6c23.var_4417045b;
}

// Namespace wave_manager_sys/wave_manager
// Params 6, eflags: 0x4
// Checksum 0x135102a6, Offset: 0x2480
// Size: 0x3d0
function private start_internal(s_wave_manager_struct, str_team, b_looping, str_wavemanager, var_e4db2502, var_e8332bc1) {
    var_dcd6c23 = new cwavemanager();
    var_dcd6c23.m_s_bundle = getscriptbundle(isdefined(str_wavemanager) ? str_wavemanager : s_wave_manager_struct.scriptbundlename);
    var_dcd6c23.var_cf3bea8a = get_unique_id();
    var_dcd6c23.var_556afb3d = var_dcd6c23.m_s_bundle.name;
    if (isdefined(s_wave_manager_struct)) {
        var_dcd6c23.var_3844e966 = s_wave_manager_struct;
        s_wave_manager_struct.var_dcd6c23 = var_dcd6c23;
        if (isdefined(s_wave_manager_struct.target)) {
            var_dcd6c23.var_27eacb34 = s_wave_manager_struct.target;
        }
        var_dcd6c23.m_str_team = util::get_team_mapping(s_wave_manager_struct.script_team);
        var_dcd6c23.var_f68bc980 = is_true(s_wave_manager_struct.script_looping);
        var_dcd6c23.var_a709a080 = is_true(s_wave_manager_struct.script_auto_delete);
        if (isdefined(s_wave_manager_struct.var_a69f424f)) {
            foreach (var_7635207b in s_wave_manager_struct.var_a69f424f) {
                if (!isdefined(var_dcd6c23.var_23802722)) {
                    var_dcd6c23.var_23802722 = [];
                } else if (!isarray(var_dcd6c23.var_23802722)) {
                    var_dcd6c23.var_23802722 = array(var_dcd6c23.var_23802722);
                }
                if (!isinarray(var_dcd6c23.var_23802722, var_7635207b)) {
                    var_dcd6c23.var_23802722[var_dcd6c23.var_23802722.size] = var_7635207b;
                }
            }
        }
    } else {
        var_dcd6c23.m_str_team = str_team;
        var_dcd6c23.var_f68bc980 = b_looping;
        if (isdefined(var_e4db2502)) {
            var_dcd6c23.var_27eacb34 = var_e4db2502;
        }
    }
    var_dcd6c23.var_592f8f7f = var_dcd6c23.m_s_bundle.wavecount;
    if (isdefined(var_e8332bc1)) {
        if (!isdefined(var_dcd6c23.var_23802722)) {
            var_dcd6c23.var_23802722 = [];
        } else if (!isarray(var_dcd6c23.var_23802722)) {
            var_dcd6c23.var_23802722 = array(var_dcd6c23.var_23802722);
        }
        if (!isinarray(var_dcd6c23.var_23802722, var_e8332bc1)) {
            var_dcd6c23.var_23802722[var_dcd6c23.var_23802722.size] = var_e8332bc1;
        }
    }
    level.var_ca74a4bc[var_dcd6c23.var_cf3bea8a] = var_dcd6c23;
    init_flags(var_dcd6c23);
    thread think(var_dcd6c23);
    /#
        update_devgui();
    #/
    if (isdefined(s_wave_manager_struct)) {
        s_wave_manager_struct flag::set("wave_manager_started");
    }
    return var_dcd6c23;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x9d7f595b, Offset: 0x2858
// Size: 0x652
function private think(var_dcd6c23) {
    while (true) {
        if (var_dcd6c23 flag::get("stopped")) {
            break;
        }
        if (var_dcd6c23.var_4417045b > var_dcd6c23.var_592f8f7f) {
            if (is_true(var_dcd6c23.var_f68bc980)) {
                reset(var_dcd6c23);
            } else {
                break;
            }
        }
        var_ed407c11 = var_dcd6c23.m_s_bundle.waves[var_dcd6c23.var_4417045b - 1];
        var_4e56e285 = isdefined(var_ed407c11.transitioncount) ? var_ed407c11.transitioncount : 0;
        var_b7681e7b = isdefined(var_ed407c11.transitiondelaymin) ? var_ed407c11.transitiondelaymin : 0;
        var_711b891b = isdefined(var_ed407c11.transitiondelaymax) ? var_ed407c11.transitiondelaymax : 0;
        if (var_b7681e7b < var_711b891b) {
            var_791750f5 = randomfloatrange(var_b7681e7b, var_711b891b);
        } else {
            var_791750f5 = var_b7681e7b;
        }
        var_dcd6c23.var_376c2c29 = [];
        for (var_f5d6a44e = 0; var_f5d6a44e < var_ed407c11.spawns.size; var_f5d6a44e++) {
            var_a2b4b991 = var_ed407c11.spawns[var_f5d6a44e];
            if (function_d081cf72(var_a2b4b991)) {
                var_c21b798e = new class_2443998c();
                var_c21b798e.var_4fb3156c = var_a2b4b991;
                var_c21b798e.var_ef327d57 = var_f5d6a44e;
                if (!isdefined(var_dcd6c23.var_376c2c29)) {
                    var_dcd6c23.var_376c2c29 = [];
                } else if (!isarray(var_dcd6c23.var_376c2c29)) {
                    var_dcd6c23.var_376c2c29 = array(var_dcd6c23.var_376c2c29);
                }
                var_dcd6c23.var_376c2c29[var_dcd6c23.var_376c2c29.size] = var_c21b798e;
                thread function_8f5ed189(var_dcd6c23, var_c21b798e);
                continue;
            }
            /#
                println("<dev string:x209>" + var_f5d6a44e + 1 + "<dev string:x22f>");
                iprintln("<dev string:x209>" + var_f5d6a44e + 1 + "<dev string:x22f>");
            #/
        }
        while (true) {
            b_transition_into_next_wave = 1;
            b_wave_complete = 1;
            b_wave_cleared = 1;
            foreach (var_c21b798e in var_dcd6c23.var_376c2c29) {
                if (!function_9e2b33f4(var_c21b798e)) {
                    b_wave_complete = 0;
                    break;
                }
            }
            if (!isdefined(var_4e56e285) || var_4e56e285 == 0) {
                foreach (var_c21b798e in var_dcd6c23.var_376c2c29) {
                    if (!function_f77ad8a3(var_c21b798e)) {
                        b_wave_cleared = 0;
                        b_transition_into_next_wave = 0;
                        break;
                    }
                }
            } else if (b_wave_complete) {
                var_179ea866 = 0;
                foreach (var_c21b798e in var_dcd6c23.var_376c2c29) {
                    if (isdefined(var_c21b798e.var_bb290b79)) {
                        var_179ea866 += var_c21b798e.var_bb290b79.size;
                    }
                }
                if (var_179ea866 > var_4e56e285) {
                    b_wave_cleared = 0;
                    b_transition_into_next_wave = 0;
                }
            } else {
                foreach (var_c21b798e in var_dcd6c23.var_376c2c29) {
                    if (!function_f77ad8a3(var_c21b798e)) {
                        b_wave_cleared = 0;
                        b_transition_into_next_wave = 0;
                        break;
                    }
                }
            }
            if (b_wave_complete) {
                function_68766ec1(var_dcd6c23);
            }
            if (b_wave_cleared) {
                function_68ed489(var_dcd6c23);
                function_2bba6468(var_dcd6c23);
            }
            if (b_transition_into_next_wave) {
                break;
            }
            wait 0.1;
        }
        if (isdefined(var_dcd6c23.var_4417045b)) {
            var_dcd6c23.var_4417045b++;
        }
        wait var_791750f5 + 0.1;
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0x351f99f8, Offset: 0x2eb8
// Size: 0x108
function private function_ff49692b(var_dcd6c23, ai) {
    assert(isdefined(var_dcd6c23), "<dev string:x25d>");
    assert(isdefined(ai), "<dev string:x2a0>");
    if (isdefined(var_dcd6c23.var_23802722)) {
        foreach (var_e8332bc1 in var_dcd6c23.var_23802722) {
            if (isdefined(var_e8332bc1.var_964c77e1)) {
                util::single_thread_argarray(ai, var_e8332bc1.var_964c77e1, var_e8332bc1.a_params);
            }
        }
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xe013e794, Offset: 0x2fc8
// Size: 0x24a
function private function_68ed489(var_dcd6c23) {
    if (!isdefined(var_dcd6c23.var_419edb9f)) {
        var_dcd6c23.var_419edb9f = [];
    }
    foreach (var_c21b798e in var_dcd6c23.var_376c2c29) {
        function_1eaaceab(var_c21b798e.var_bb290b79);
        if (var_c21b798e.var_bb290b79.size) {
            if (!isdefined(var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b])) {
                var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b] = [];
            }
            foreach (ai in var_c21b798e.var_bb290b79) {
                if (!isdefined(var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b])) {
                    var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b] = [];
                } else if (!isarray(var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b])) {
                    var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b] = array(var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b]);
                }
                if (!isinarray(var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b], ai)) {
                    var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b][var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b].size] = ai;
                }
            }
        }
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x4a8c9656, Offset: 0x3220
// Size: 0x56
function private function_30956db0(var_dcd6c23) {
    while (function_4b7647f(var_dcd6c23)) {
        wait 1;
    }
    var_dcd6c23 flag::set("all_dead");
    var_dcd6c23.var_419edb9f = undefined;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x6282a734, Offset: 0x3280
// Size: 0xa2
function private function_4b7647f(var_dcd6c23) {
    foreach (a_ai in var_dcd6c23.var_419edb9f) {
        function_1eaaceab(a_ai);
        if (a_ai.size) {
            return true;
        }
    }
    return false;
}

// Namespace wave_manager_sys/wave_manager
// Params 3, eflags: 0x4
// Checksum 0x837816c3, Offset: 0x3330
// Size: 0x510
function private function_7909260f(var_dcd6c23, n_wave, var_bced2a83) {
    n_spawns = 0;
    if (var_dcd6c23 flag::get("stopped")) {
        if (var_bced2a83) {
            if (isdefined(var_dcd6c23.var_419edb9f)) {
                if (isdefined(n_wave)) {
                    if (isdefined(var_dcd6c23.var_419edb9f[n_wave])) {
                        function_1eaaceab(var_dcd6c23.var_419edb9f[n_wave]);
                        foreach (ai in var_dcd6c23.var_419edb9f[n_wave]) {
                            n_spawns++;
                        }
                    }
                } else {
                    foreach (var_13528014 in var_dcd6c23.var_419edb9f) {
                        function_1eaaceab(var_13528014);
                        foreach (ai in var_13528014) {
                            n_spawns++;
                        }
                    }
                }
            }
        }
    } else {
        for (i = 1; i <= var_dcd6c23.var_592f8f7f; i++) {
            if (isdefined(n_wave)) {
                if (i < n_wave) {
                    continue;
                } else if (i > n_wave) {
                    break;
                }
            }
            if (i < var_dcd6c23.var_4417045b) {
                if (var_bced2a83) {
                    if (isdefined(var_dcd6c23.var_419edb9f)) {
                        if (isdefined(var_dcd6c23.var_419edb9f[i])) {
                            function_1eaaceab(var_dcd6c23.var_419edb9f[i]);
                            foreach (ai in var_dcd6c23.var_419edb9f[i]) {
                                n_spawns++;
                            }
                        }
                    }
                }
                continue;
            }
            if (i == var_dcd6c23.var_4417045b) {
                foreach (var_c21b798e in var_dcd6c23.var_376c2c29) {
                    var_1c88138f = var_c21b798e.var_23791f08 - var_c21b798e.var_bcd4e683;
                    if (isdefined(var_c21b798e.var_bb290b79)) {
                        function_1eaaceab(var_c21b798e.var_bb290b79);
                        var_1c88138f += var_c21b798e.var_bb290b79.size;
                    }
                    n_spawns += var_1c88138f;
                }
            } else {
                foreach (var_a2b4b991 in var_dcd6c23.m_s_bundle.waves[i - 1].spawns) {
                    n_spawns += isdefined(var_a2b4b991.totalcount) ? var_a2b4b991.totalcount : 1;
                }
            }
            if (!var_bced2a83) {
                if (isdefined(var_dcd6c23.m_s_bundle.waves[i - 1].transitioncount)) {
                    n_spawns -= var_dcd6c23.m_s_bundle.waves[i - 1].transitioncount;
                }
            }
        }
    }
    return n_spawns;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xec74d943, Offset: 0x3848
// Size: 0x8c
function private function_60fa5e02(var_c21b798e) {
    assert(isdefined(var_c21b798e), "<dev string:x2d8>");
    var_c21b798e flag::init("spawn_set_" + var_c21b798e.var_ef327d57 + "_complete");
    var_c21b798e flag::init("spawn_set_" + var_c21b798e.var_ef327d57 + "_cleared");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x6d80951d, Offset: 0x38e0
// Size: 0x3c
function private complete_spawn_set(var_c21b798e) {
    var_c21b798e flag::set("spawn_set_" + var_c21b798e.var_ef327d57 + "_complete");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xbd0f0415, Offset: 0x3928
// Size: 0x3a
function private function_9e2b33f4(var_c21b798e) {
    return var_c21b798e flag::get("spawn_set_" + var_c21b798e.var_ef327d57 + "_complete");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xca59e807, Offset: 0x3970
// Size: 0x3c
function private function_d652a051(var_c21b798e) {
    var_c21b798e flag::set("spawn_set_" + var_c21b798e.var_ef327d57 + "_cleared");
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x64474acd, Offset: 0x39b8
// Size: 0x3a
function private function_f77ad8a3(var_c21b798e) {
    return var_c21b798e flag::get("spawn_set_" + var_c21b798e.var_ef327d57 + "_cleared");
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0x7692258a, Offset: 0x3a00
// Size: 0xf34
function private function_8f5ed189(var_dcd6c23, var_c21b798e) {
    function_60fa5e02(var_c21b798e);
    var_a2b4b991 = var_c21b798e.var_4fb3156c;
    var_c165240a = function_ed819a97(var_a2b4b991);
    var_c21b798e.var_a4202481 = isdefined(var_a2b4b991.activecount) ? var_a2b4b991.activecount : 1;
    var_c21b798e.var_23791f08 = isdefined(var_a2b4b991.totalcount) ? var_a2b4b991.totalcount : 1;
    var_ac751707 = isdefined(var_a2b4b991.groupsizemin) ? var_a2b4b991.groupsizemin : 1;
    var_777f23ac = isdefined(var_a2b4b991.groupsizemax) ? var_a2b4b991.groupsizemax : 1;
    if (var_ac751707 < var_777f23ac) {
        var_ff8eea0d = 1;
    } else {
        var_ff8eea0d = 0;
        n_group_size = var_ac751707;
    }
    var_393f60f2 = isdefined(var_a2b4b991.var_5794c814) ? var_a2b4b991.var_5794c814 : 1;
    var_58b22097 = isdefined(var_a2b4b991.var_455e5daf) ? var_a2b4b991.var_455e5daf : 0;
    var_685248c4 = isdefined(var_a2b4b991.var_6d514904) ? var_a2b4b991.var_6d514904 : 0;
    if (var_58b22097 < var_685248c4) {
        n_start_delay = randomfloatrange(var_58b22097, var_685248c4);
    } else {
        n_start_delay = var_58b22097;
    }
    var_4e06036b = isdefined(var_a2b4b991.spawndelaymin) ? var_a2b4b991.spawndelaymin : 0;
    var_d18f896 = isdefined(var_a2b4b991.spawndelaymax) ? var_a2b4b991.spawndelaymax : 0;
    if (var_4e06036b < var_d18f896) {
        var_178b2076 = 1;
    } else {
        var_178b2076 = 0;
        n_spawn_delay = var_4e06036b;
    }
    var_88f8dfe3 = gettime();
    var_e7bc5a90 = 1;
    var_a9e6e26a = 1;
    while (true) {
        if (var_dcd6c23 flag::get("stopped")) {
            break;
        }
        if (var_dcd6c23 flag::get("paused")) {
            wait 0.1;
            continue;
        }
        if (var_c165240a.size == 0) {
            break;
        }
        if (var_c21b798e.var_bcd4e683 >= var_c21b798e.var_23791f08) {
            break;
        }
        var_a9dc13fe = 0;
        var_a5f569fc = undefined;
        if (isdefined(var_c21b798e.var_bb290b79)) {
            function_1eaaceab(var_c21b798e.var_bb290b79);
        }
        foreach (var_40b0c36 in var_c165240a) {
            function_1eaaceab(var_40b0c36.var_a33f2319);
        }
        var_303d0ec5 = var_c21b798e.var_23791f08 - var_c21b798e.var_bcd4e683;
        if (var_e7bc5a90) {
            if (var_ff8eea0d) {
                var_ac751707 = math::clamp(var_ac751707, 1, var_303d0ec5);
                var_777f23ac = math::clamp(var_777f23ac, 1, var_303d0ec5);
                if (var_ac751707 == var_777f23ac) {
                    n_group_size = var_ac751707;
                } else {
                    n_group_size = randomintrange(var_ac751707, var_777f23ac + 1);
                }
            } else {
                n_group_size = math::clamp(n_group_size, 1, var_303d0ec5);
            }
            if (var_a9e6e26a) {
                var_cfe8c244 = n_start_delay;
                var_a9e6e26a = 0;
            } else {
                if (var_178b2076) {
                    n_spawn_delay = randomfloatrange(var_4e06036b, var_d18f896);
                }
                var_cfe8c244 = n_spawn_delay;
            }
        }
        var_e7bc5a90 = 0;
        if (!isdefined(var_c21b798e.var_bb290b79) || var_c21b798e.var_bb290b79.size < var_c21b798e.var_a4202481) {
            var_a5f569fc = var_c21b798e.var_a4202481 - var_c21b798e.var_bb290b79.size;
            var_db4208eb = function_d8cca6d5(var_c165240a);
            if (var_a5f569fc >= n_group_size && var_db4208eb.size) {
                var_7c275302 = gettime() - var_88f8dfe3;
                var_1b5feb05 = float(var_7c275302);
                if (var_1b5feb05 >= int(var_cfe8c244 * 1000)) {
                    var_a9dc13fe = 1;
                }
            }
        }
        if (!var_a9dc13fe) {
            wait 0.1;
            continue;
        }
        var_6a60a2e6 = 0;
        assert(isdefined(var_a5f569fc), "<dev string:x30f>");
        var_13027679 = undefined;
        var_26413beb = undefined;
        var_549391b8 = undefined;
        while (var_6a60a2e6 < n_group_size) {
            if (n_group_size <= 1) {
                var_549391b8 = undefined;
            }
            if (var_dcd6c23 flag::get("stopped")) {
                break;
            }
            if (var_dcd6c23 flag::get("paused")) {
                wait 0.1;
                continue;
            }
            var_db4208eb = function_d8cca6d5(var_c165240a);
            if (!var_db4208eb.size) {
                /#
                    println("<dev string:x34e>" + var_dcd6c23.var_556afb3d + "<dev string:x38f>" + var_c21b798e.var_ef327d57 + 1 + "<dev string:x3a9>");
                    iprintln("<dev string:x34e>" + var_dcd6c23.var_556afb3d + "<dev string:x38f>" + var_c21b798e.var_ef327d57 + 1 + "<dev string:x3a9>");
                #/
                break;
            }
            if (!is_true(var_393f60f2) && isdefined(var_13027679)) {
                if (!isinarray(var_db4208eb, var_26413beb)) {
                    /#
                        println("<dev string:x3c0>" + var_26413beb + "<dev string:x3e1>" + var_dcd6c23.var_556afb3d + "<dev string:x38f>" + var_c21b798e.var_ef327d57 + 1 + "<dev string:x3ff>");
                        iprintln("<dev string:x3c0>" + var_26413beb + "<dev string:x3e1>" + var_dcd6c23.var_556afb3d + "<dev string:x38f>" + var_c21b798e.var_ef327d57 + 1 + "<dev string:x3ff>");
                    #/
                    break;
                }
                var_aea390b6 = var_13027679;
                var_82706add = var_26413beb;
            } else {
                var_82706add = var_db4208eb[randomint(var_db4208eb.size)];
            }
            spawner::global_spawn_throttle();
            if (!isdefined(var_549391b8) || !isdefined(var_549391b8[#"spawner"]) || var_549391b8[#"spawner"].count < 1 && !(isdefined(var_549391b8[#"spawner"].spawnflags) && (var_549391b8[#"spawner"].spawnflags & 64) == 64)) {
                s_spawn_point = aispawningutility::function_e312ad4d(var_dcd6c23.m_str_team, var_dcd6c23.var_27eacb34, var_82706add);
                if (!isdefined(s_spawn_point)) {
                    /#
                        println("<dev string:x422>" + var_82706add + "<dev string:x44d>" + var_dcd6c23.var_556afb3d + "<dev string:x462>");
                        iprintln("<dev string:x422>" + var_82706add + "<dev string:x44d>" + var_dcd6c23.var_556afb3d + "<dev string:x462>");
                    #/
                    arrayremoveindex(var_c165240a, var_82706add, 1);
                    if (var_c165240a.size > 0 && is_true(var_393f60f2)) {
                        continue;
                    }
                    break;
                }
            }
            v_origin = isdefined(s_spawn_point) ? s_spawn_point[#"origin"] : (0, 0, 0);
            v_angles = isdefined(s_spawn_point) ? s_spawn_point[#"angles"] : (0, 0, 0);
            var_c8fa21da = isdefined(s_spawn_point) ? s_spawn_point[#"spawner"] : undefined;
            if (n_group_size > 1) {
                var_549391b8 = s_spawn_point;
            }
            if (isdefined(var_c8fa21da)) {
                b_infinite_spawn = isdefined(var_c8fa21da.spawnflags) && (var_c8fa21da.spawnflags & 64) == 64;
                b_force_spawn = isdefined(var_c8fa21da.spawnflags) && (var_c8fa21da.spawnflags & 16) == 16;
            }
            var_ae2df0a1 = isdefined(var_c8fa21da.aitype) && function_e949cfd7(var_c8fa21da.aitype);
            if (var_ae2df0a1) {
                if (isdefined(var_c8fa21da)) {
                    ai = var_c8fa21da spawnfromspawner(s_spawn_point[#"spawner"].targetname, b_force_spawn, 0, b_infinite_spawn);
                    if (!isdefined(var_dcd6c23.var_246fb97f)) {
                        var_dcd6c23.var_246fb97f = [];
                    } else if (!isarray(var_dcd6c23.var_246fb97f)) {
                        var_dcd6c23.var_246fb97f = array(var_dcd6c23.var_246fb97f);
                    }
                    if (!isinarray(var_dcd6c23.var_246fb97f, var_c8fa21da)) {
                        var_dcd6c23.var_246fb97f[var_dcd6c23.var_246fb97f.size] = var_c8fa21da;
                    }
                }
            } else if (isdefined(var_c8fa21da)) {
                ai = var_c8fa21da spawnfromspawner(s_spawn_point[#"spawner"].targetname, b_force_spawn, 0, b_infinite_spawn);
                if (!isdefined(var_dcd6c23.var_246fb97f)) {
                    var_dcd6c23.var_246fb97f = [];
                } else if (!isarray(var_dcd6c23.var_246fb97f)) {
                    var_dcd6c23.var_246fb97f = array(var_dcd6c23.var_246fb97f);
                }
                if (!isinarray(var_dcd6c23.var_246fb97f, var_c8fa21da)) {
                    var_dcd6c23.var_246fb97f[var_dcd6c23.var_246fb97f.size] = var_c8fa21da;
                }
            }
            if (isdefined(ai)) {
                function_ff49692b(var_dcd6c23, ai);
                if (!isdefined(var_c21b798e.var_bb290b79)) {
                    var_c21b798e.var_bb290b79 = [];
                } else if (!isarray(var_c21b798e.var_bb290b79)) {
                    var_c21b798e.var_bb290b79 = array(var_c21b798e.var_bb290b79);
                }
                var_c21b798e.var_bb290b79[var_c21b798e.var_bb290b79.size] = ai;
                if (!isdefined(var_c165240a[var_82706add].var_a33f2319)) {
                    var_c165240a[var_82706add].var_a33f2319 = [];
                } else if (!isarray(var_c165240a[var_82706add].var_a33f2319)) {
                    var_c165240a[var_82706add].var_a33f2319 = array(var_c165240a[var_82706add].var_a33f2319);
                }
                var_c165240a[var_82706add].var_a33f2319[var_c165240a[var_82706add].var_a33f2319.size] = ai;
                var_88f8dfe3 = gettime();
                var_e7bc5a90 = 1;
                var_c21b798e.var_bcd4e683++;
                var_6a60a2e6++;
            }
            var_13027679 = var_aea390b6;
            var_26413beb = var_82706add;
            wait 0.1;
        }
        wait 0.1;
    }
    complete_spawn_set(var_c21b798e);
    while (true) {
        function_1eaaceab(var_c21b798e.var_bb290b79);
        if (!var_c21b798e.var_bb290b79.size) {
            function_d652a051(var_c21b798e);
            return;
        }
        wait 0.1;
    }
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0x3d838a49, Offset: 0x4940
// Size: 0x44
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
// Checksum 0x8eca54bd, Offset: 0x4990
// Size: 0xa4
function private function_d081cf72(var_a2b4b991) {
    if (isdefined(var_a2b4b991.spawntypes)) {
        foreach (s_spawn_type in var_a2b4b991.spawntypes) {
            if (isdefined(s_spawn_type.variant)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x28bbcdd5, Offset: 0x4a40
// Size: 0x130
function private function_ed819a97(var_a2b4b991) {
    var_c165240a = [];
    if (isdefined(var_a2b4b991.spawntypes)) {
        foreach (s_spawn_type in var_a2b4b991.spawntypes) {
            if (isdefined(s_spawn_type.variant)) {
                var_2f2d7675 = isdefined(s_spawn_type.var_34ceb858) ? s_spawn_type.var_34ceb858 : 0;
                var_40b0c36 = {#var_2f2d7675:var_2f2d7675, #var_a33f2319:[], #name:s_spawn_type.variant};
                var_c165240a[s_spawn_type.variant] = var_40b0c36;
            }
        }
    }
    return var_c165240a;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0xf597cd, Offset: 0x4b78
// Size: 0x132
function private function_d8cca6d5(var_c165240a) {
    var_db4208eb = [];
    foreach (v in var_c165240a) {
        var_2f2d7675 = v.var_2f2d7675;
        if (var_2f2d7675 == 0 || v.var_a33f2319.size < var_2f2d7675) {
            if (!isdefined(var_db4208eb)) {
                var_db4208eb = [];
            } else if (!isarray(var_db4208eb)) {
                var_db4208eb = array(var_db4208eb);
            }
            if (!isinarray(var_db4208eb, v.name)) {
                var_db4208eb[var_db4208eb.size] = v.name;
            }
        }
    }
    return var_db4208eb;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x246121a4, Offset: 0x4cb8
// Size: 0x322
function private function_32b947df(kvp) {
    var_fed53aae = [];
    if (isdefined(kvp)) {
        str_key = "targetname";
        str_value = kvp;
        if (isarray(kvp)) {
            str_key = kvp[0];
            str_value = kvp[1];
        }
        a_s_wave_managers = struct::get_array(str_value, str_key);
        a_s_wave_managers = array::filter(a_s_wave_managers, 0, &function_5b3b889f);
        foreach (s_wave_manager in a_s_wave_managers) {
            if (isdefined(s_wave_manager.var_dcd6c23)) {
                if (!isdefined(var_fed53aae)) {
                    var_fed53aae = [];
                } else if (!isarray(var_fed53aae)) {
                    var_fed53aae = array(var_fed53aae);
                }
                if (!isinarray(var_fed53aae, s_wave_manager.var_dcd6c23)) {
                    var_fed53aae[var_fed53aae.size] = s_wave_manager.var_dcd6c23;
                }
            }
        }
        assert(a_s_wave_managers.size, "<dev string:x494>" + str_key + "<dev string:x4b9>" + str_value + "<dev string:x4c0>");
    } else {
        var_666d249b = self;
        if (!isdefined(var_666d249b)) {
            var_666d249b = [];
        } else if (!isarray(var_666d249b)) {
            var_666d249b = array(var_666d249b);
        }
        foreach (var_989041ce in var_666d249b) {
            var_dcd6c23 = var_989041ce function_fa056daa();
            if (isdefined(var_dcd6c23)) {
                if (!isdefined(var_fed53aae)) {
                    var_fed53aae = [];
                } else if (!isarray(var_fed53aae)) {
                    var_fed53aae = array(var_fed53aae);
                }
                var_fed53aae[var_fed53aae.size] = var_dcd6c23;
            }
        }
    }
    return var_fed53aae;
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0x5b4a73e2, Offset: 0x4fe8
// Size: 0x178
function private function_63e08195(kvp, b_assert = 1) {
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
    a_s_wave_managers = array::filter(a_s_wave_managers, 0, &function_5b3b889f);
    if (b_assert) {
        assert(a_s_wave_managers.size, isdefined(kvp) ? "<dev string:x494>" + str_key + "<dev string:x4b9>" + str_value + "<dev string:x4c0>" : "<dev string:x4c5>");
    }
    return a_s_wave_managers;
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0x73417d77, Offset: 0x5168
// Size: 0x7e
function private function_fa056daa() {
    if (isinarray(level.a_s_wave_managers, self)) {
        if (isdefined(self.var_dcd6c23)) {
            return self.var_dcd6c23;
        } else {
            return undefined;
        }
    } else if (self function_e0bfee59()) {
        return self;
    }
    assertmsg("<dev string:x4e3>");
    return undefined;
}

// Namespace wave_manager_sys/wave_manager
// Params 0, eflags: 0x4
// Checksum 0xc14ddbeb, Offset: 0x51f0
// Size: 0x32
function private function_e0bfee59() {
    if (isdefined(self.var_cf3bea8a) && level.var_ca74a4bc[self.var_cf3bea8a] == self) {
        return true;
    }
    return false;
}

// Namespace wave_manager_sys/wave_manager
// Params 1, eflags: 0x4
// Checksum 0x86477d50, Offset: 0x5230
// Size: 0x2a
function private function_5b3b889f(var_ac1d69cd) {
    return isinarray(level.a_s_wave_managers, var_ac1d69cd);
}

// Namespace wave_manager_sys/wave_manager
// Params 2, eflags: 0x4
// Checksum 0x35243bc, Offset: 0x5268
// Size: 0x1ca
function private function_bf55c711(n_wave, var_bced2a83) {
    s_bundle = getscriptbundle(self.scriptbundlename);
    n_ai_count = 0;
    foreach (n_index, s_wave in s_bundle.waves) {
        if (isdefined(n_wave)) {
            if (n_index < n_wave - 1) {
                continue;
            } else if (n_index > n_wave - 1) {
                break;
            }
        }
        var_b4d30f09 = 0;
        foreach (var_a2b4b991 in s_wave.spawns) {
            var_b4d30f09 += isdefined(var_a2b4b991.totalcount) ? var_a2b4b991.totalcount : 1;
        }
        if (!var_bced2a83 && isdefined(s_wave.transitioncount)) {
            var_b4d30f09 -= s_wave.transitioncount;
        }
        n_ai_count += var_b4d30f09;
    }
    return n_ai_count;
}

#namespace wave_manager;

// Namespace wave_manager/wave_manager
// Params 3, eflags: 0x20 variadic
// Checksum 0x144d7ff4, Offset: 0x54f0
// Size: 0x100
function start(kvp, var_964c77e1, ...) {
    a_s_wave_managers = self wave_manager_sys::function_63e08195(kvp);
    foreach (s_wave_manager in a_s_wave_managers) {
        var_e8332bc1 = new class_8e39177();
        var_e8332bc1.var_964c77e1 = var_964c77e1;
        var_e8332bc1.a_params = vararg;
        wave_manager_sys::start_internal(s_wave_manager, undefined, undefined, undefined, undefined, var_e8332bc1);
    }
}

// Namespace wave_manager/wave_manager
// Params 6, eflags: 0x20 variadic
// Checksum 0xf491e857, Offset: 0x55f8
// Size: 0x9a
function function_be3a34f(var_b6ee6116, str_team, b_looping = 0, var_e4db2502, var_964c77e1, ...) {
    var_e8332bc1 = new class_8e39177();
    var_e8332bc1.var_964c77e1 = var_964c77e1;
    var_e8332bc1.a_params = vararg;
    return wave_manager_sys::start_internal(undefined, str_team, b_looping, var_b6ee6116, var_e4db2502, var_e8332bc1);
}

// Namespace wave_manager/wave_manager
// Params 1, eflags: 0x0
// Checksum 0x8cba82d2, Offset: 0x56a0
// Size: 0x140
function wait_till_complete(n_wave) {
    var_666d249b = self;
    if (!isdefined(var_666d249b)) {
        var_666d249b = [];
    } else if (!isarray(var_666d249b)) {
        var_666d249b = array(var_666d249b);
    }
    foreach (var_989041ce in var_666d249b) {
        if (wave_manager_sys::function_5b3b889f(var_989041ce)) {
            var_989041ce flag::wait_till("wave_manager_started");
        }
        var_dcd6c23 = var_989041ce wave_manager_sys::function_fa056daa();
        if (isdefined(var_dcd6c23)) {
            wave_manager_sys::function_aa6a8e4a(var_dcd6c23, n_wave);
        }
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0xb79ef79c, Offset: 0x57e8
// Size: 0x150
function wait_till_cleared(n_wave, var_b8b3e39d = 0) {
    var_666d249b = self;
    if (!isdefined(var_666d249b)) {
        var_666d249b = [];
    } else if (!isarray(var_666d249b)) {
        var_666d249b = array(var_666d249b);
    }
    foreach (var_989041ce in var_666d249b) {
        if (wave_manager_sys::function_5b3b889f(var_989041ce)) {
            var_989041ce flag::wait_till("wave_manager_started");
        }
        var_dcd6c23 = var_989041ce wave_manager_sys::function_fa056daa();
        if (isdefined(var_dcd6c23)) {
            wave_manager_sys::function_55525f13(var_dcd6c23, n_wave, var_b8b3e39d);
        }
    }
}

// Namespace wave_manager/wave_manager
// Params 0, eflags: 0x0
// Checksum 0x1ba75cd6, Offset: 0x5940
// Size: 0x140
function function_fa5a19de() {
    var_666d249b = self;
    if (!isdefined(var_666d249b)) {
        var_666d249b = [];
    } else if (!isarray(var_666d249b)) {
        var_666d249b = array(var_666d249b);
    }
    foreach (var_989041ce in var_666d249b) {
        if (wave_manager_sys::function_5b3b889f(var_989041ce)) {
            var_989041ce flag::wait_till("wave_manager_started");
        }
        var_dcd6c23 = var_989041ce wave_manager_sys::function_fa056daa();
        if (isdefined(var_dcd6c23)) {
            var_dcd6c23 flag::wait_till("stopped");
        }
    }
}

// Namespace wave_manager/wave_manager
// Params 0, eflags: 0x0
// Checksum 0x64fb1c5a, Offset: 0x5a88
// Size: 0x7e
function is_looping() {
    var_dcd6c23 = self wave_manager_sys::function_fa056daa();
    if (isdefined(var_dcd6c23)) {
        return is_true(var_dcd6c23.var_f68bc980);
    }
    if (wave_manager_sys::function_5b3b889f(self)) {
        return is_true(self.script_looping);
    }
    return 0;
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0xa228638d, Offset: 0x5b10
// Size: 0x1e6
function function_1c556906(kvp, var_b3a058ca) {
    var_fed53aae = self wave_manager_sys::function_32b947df(kvp);
    foreach (var_dcd6c23 in var_fed53aae) {
        assert(isdefined(var_b3a058ca));
        a_sp_new = getspawnerteamarray(var_dcd6c23.m_str_team);
        var_91504a05 = 0;
        if (isdefined(a_sp_new) && isarray(a_sp_new) && a_sp_new.size) {
            foreach (sp_new in a_sp_new) {
                if (sp_new.targetname === var_b3a058ca) {
                    var_91504a05 = 1;
                    break;
                }
            }
        }
        assert(var_91504a05, "<dev string:x52b>" + var_b3a058ca);
        var_dcd6c23.var_27eacb34 = var_b3a058ca;
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0x55249cf6, Offset: 0x5d00
// Size: 0x214
function function_a3469200(kvp, var_4b054c7f) {
    a_ai = [];
    var_fed53aae = self wave_manager_sys::function_32b947df(kvp);
    if (isdefined(var_4b054c7f)) {
        var_4b054c7f--;
    }
    foreach (var_dcd6c23 in var_fed53aae) {
        if (isdefined(var_dcd6c23.var_376c2c29)) {
            if (isdefined(var_4b054c7f) && var_4b054c7f > 0) {
                if (isdefined(var_dcd6c23.var_376c2c29[var_4b054c7f])) {
                    a_ai = var_dcd6c23.var_376c2c29[var_4b054c7f].var_bb290b79;
                }
            } else {
                foreach (var_c21b798e in var_dcd6c23.var_376c2c29) {
                    foreach (ai in var_c21b798e.var_bb290b79) {
                        a_ai[a_ai.size] = ai;
                    }
                }
            }
            function_1eaaceab(a_ai);
        }
    }
    return a_ai;
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0x770e28cb, Offset: 0x5f20
// Size: 0x414
function function_77941ace(kvp, n_wave) {
    a_ai = [];
    var_fed53aae = self wave_manager_sys::function_32b947df(kvp);
    foreach (var_dcd6c23 in var_fed53aae) {
        if (isdefined(var_dcd6c23.var_376c2c29)) {
            if (!isdefined(n_wave) || n_wave === var_dcd6c23.var_4417045b) {
                foreach (var_c21b798e in var_dcd6c23.var_376c2c29) {
                    foreach (ai in var_c21b798e.var_bb290b79) {
                        a_ai[a_ai.size] = ai;
                    }
                }
            }
        }
        if (isdefined(var_dcd6c23.var_419edb9f)) {
            if (isdefined(n_wave)) {
                if (isdefined(var_dcd6c23.var_419edb9f[n_wave])) {
                    foreach (ai in var_dcd6c23.var_419edb9f[n_wave]) {
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
                foreach (var_13528014 in var_dcd6c23.var_419edb9f) {
                    foreach (ai in var_13528014) {
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
        function_1eaaceab(a_ai);
    }
    return a_ai;
}

// Namespace wave_manager/wave_manager
// Params 3, eflags: 0x0
// Checksum 0xdb646127, Offset: 0x6340
// Size: 0x130
function function_6893f05b(kvp, n_wave, var_bced2a83 = 1) {
    a_s_wave_managers = [];
    a_s_wave_managers = self wave_manager_sys::function_63e08195(kvp);
    var_a1f4e09d = 0;
    foreach (s_wave_manager in a_s_wave_managers) {
        if (isdefined(s_wave_manager.var_dcd6c23)) {
            var_a1f4e09d += wave_manager_sys::function_7909260f(s_wave_manager.var_dcd6c23, n_wave, var_bced2a83);
            continue;
        }
        var_a1f4e09d += s_wave_manager wave_manager_sys::function_bf55c711(n_wave, var_bced2a83);
    }
    return var_a1f4e09d;
}

// Namespace wave_manager/wave_manager
// Params 3, eflags: 0x20 variadic
// Checksum 0x5a1145dd, Offset: 0x6478
// Size: 0x350
function add_spawn_function(kvp, var_964c77e1, ...) {
    assert(isdefined(var_964c77e1));
    a_s_wave_managers = self wave_manager_sys::function_63e08195(kvp, 0);
    if (a_s_wave_managers.size) {
        foreach (s_wave_manager in a_s_wave_managers) {
            var_e8332bc1 = new class_8e39177();
            var_e8332bc1.var_964c77e1 = var_964c77e1;
            var_e8332bc1.a_params = vararg;
            if (isdefined(s_wave_manager.var_dcd6c23)) {
                if (!isdefined(s_wave_manager.var_dcd6c23.var_23802722)) {
                    s_wave_manager.var_dcd6c23.var_23802722 = [];
                } else if (!isarray(s_wave_manager.var_dcd6c23.var_23802722)) {
                    s_wave_manager.var_dcd6c23.var_23802722 = array(s_wave_manager.var_dcd6c23.var_23802722);
                }
                if (!isinarray(s_wave_manager.var_dcd6c23.var_23802722, var_e8332bc1)) {
                    s_wave_manager.var_dcd6c23.var_23802722[s_wave_manager.var_dcd6c23.var_23802722.size] = var_e8332bc1;
                }
                continue;
            }
            if (!isdefined(s_wave_manager.var_a69f424f)) {
                s_wave_manager.var_a69f424f = [];
            } else if (!isarray(s_wave_manager.var_a69f424f)) {
                s_wave_manager.var_a69f424f = array(s_wave_manager.var_a69f424f);
            }
            if (!isinarray(s_wave_manager.var_a69f424f, var_e8332bc1)) {
                s_wave_manager.var_a69f424f[s_wave_manager.var_a69f424f.size] = var_e8332bc1;
            }
        }
        return;
    }
    if (self wave_manager_sys::function_e0bfee59()) {
        var_e8332bc1 = new class_8e39177();
        var_e8332bc1.var_964c77e1 = var_964c77e1;
        var_e8332bc1.a_params = vararg;
        if (!isdefined(self.var_23802722)) {
            self.var_23802722 = [];
        } else if (!isarray(self.var_23802722)) {
            self.var_23802722 = array(self.var_23802722);
        }
        if (!isinarray(self.var_23802722, var_e8332bc1)) {
            self.var_23802722[self.var_23802722.size] = var_e8332bc1;
        }
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0x590f5f38, Offset: 0x67d0
// Size: 0x30e
function remove_spawn_function(kvp, var_964c77e1) {
    assert(isdefined(var_964c77e1));
    a_s_wave_managers = self wave_manager_sys::function_63e08195(kvp, 0);
    if (a_s_wave_managers.size) {
        foreach (s_wave_manager in a_s_wave_managers) {
            if (isdefined(s_wave_manager.var_dcd6c23)) {
                var_dcd6c23 = s_wave_manager.var_dcd6c23;
                foreach (var_e8332bc1 in var_dcd6c23.var_23802722) {
                    if (var_e8332bc1.var_964c77e1 === var_964c77e1) {
                        var_dcd6c23.var_23802722 = array::exclude(var_dcd6c23.var_23802722, var_e8332bc1);
                    }
                }
            }
            if (isdefined(s_wave_manager.var_a69f424f)) {
                foreach (var_e8332bc1 in s_wave_manager.var_a69f424f) {
                    if (var_e8332bc1.var_964c77e1 === var_964c77e1) {
                        s_wave_manager.var_a69f424f = array::exclude(s_wave_manager.var_a69f424f, var_e8332bc1);
                        if (!s_wave_manager.var_a69f424f.size) {
                            s_wave_manager.var_a69f424f = undefined;
                        }
                    }
                }
            }
        }
        return;
    }
    if (self wave_manager_sys::function_e0bfee59()) {
        foreach (var_e8332bc1 in self.var_23802722) {
            if (var_e8332bc1.var_964c77e1 === var_964c77e1) {
                self.var_23802722 = array::exclude(self.var_23802722, var_e8332bc1);
            }
        }
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0x1503fcb6, Offset: 0x6ae8
// Size: 0xc8
function stop(kvp, var_4bb2faf8 = 0) {
    var_fed53aae = self wave_manager_sys::function_32b947df(kvp);
    foreach (var_dcd6c23 in var_fed53aae) {
        wave_manager_sys::stop_internal(var_dcd6c23, var_4bb2faf8);
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0xbd84d04b, Offset: 0x6bb8
// Size: 0xc0
function pause(kvp, *var_4bb2faf8) {
    var_fed53aae = self wave_manager_sys::function_32b947df(var_4bb2faf8);
    foreach (var_dcd6c23 in var_fed53aae) {
        var_dcd6c23 flag::set("paused");
    }
}

// Namespace wave_manager/wave_manager
// Params 2, eflags: 0x0
// Checksum 0xda1300df, Offset: 0x6c80
// Size: 0xc0
function resume(kvp, *var_4bb2faf8) {
    var_fed53aae = self wave_manager_sys::function_32b947df(var_4bb2faf8);
    foreach (var_dcd6c23 in var_fed53aae) {
        var_dcd6c23 flag::clear("paused");
    }
}

