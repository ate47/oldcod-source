#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_7a5293d92c61c788;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\armor;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\dev_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\popups_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_utility;

#namespace namespace_420b39d3;

/#

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x6
    // Checksum 0xfd374727, Offset: 0x140
    // Size: 0x4c
    function private autoexec __init__system__() {
        system::register(#"hash_3a0015e9f67cadaf", &preinit, &postinit, undefined, undefined);
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0xf10735d, Offset: 0x198
    // Size: 0x1e4
    function private preinit() {
        util::init_dvar(#"hash_3a0015e9f67cadaf", "<dev string:x38>", &function_8cf627fd);
        util::init_dvar(#"hash_664590b4ac90cb22", "<dev string:x38>", &function_33430942);
        util::init_dvar(#"hash_6307f5372b3c2a6f", "<dev string:x38>", &function_33430942);
        util::init_dvar(#"hash_5c0d8210d7e4072b", "<dev string:x38>", &function_33430942);
        util::init_dvar(#"hash_e4ff0414d01c696", "<dev string:x38>", &function_42d3c9f5);
        util::init_dvar(#"hash_5c583988a48d4115", 0, &function_867e712a);
        util::init_dvar(#"hash_601883712ebe3542", 0, &function_ad391a04);
        util::init_dvar(#"hash_6f6defbd7ae55a98", 0, &function_3fe9e6d5);
        util::init_dvar(#"hash_46ea982132a001ec", 0, &function_f1f26ccb);
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0xdb413e3f, Offset: 0x388
    // Size: 0x1c
    function private postinit() {
        level thread function_76de3950();
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x0
    // Checksum 0xa339aff4, Offset: 0x3b0
    // Size: 0x178
    function function_76de3950() {
        function_6f31d177();
        function_c4fe091c();
        if (is_true(level.aat_in_use)) {
            level thread aat::setup_devgui("<dev string:x3c>");
        }
        util::waittill_can_add_debug_command();
        if (isdefined(level.var_c0f77370)) {
            level thread [[ level.var_c0f77370 ]]();
        }
        util::waittill_can_add_debug_command();
        if (isdefined(level.var_633b283d)) {
            level thread [[ level.var_633b283d ]]();
        }
        util::waittill_can_add_debug_command();
        if (isdefined(level.var_f793af68)) {
            level thread [[ level.var_f793af68 ]]();
        }
        util::waittill_can_add_debug_command();
        if (isdefined(level.var_6aa829ef)) {
            level thread [[ level.var_6aa829ef ]]();
        }
        util::waittill_can_add_debug_command();
        if (isdefined(level.var_800654fc)) {
            level thread [[ level.var_800654fc ]]();
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0x51bdcc5c, Offset: 0x530
    // Size: 0x1e8
    function private function_6f31d177() {
        var_d9c347d9 = struct::get_array("<dev string:x68>", "<dev string:x77>");
        foreach (var_aafdab5f in var_d9c347d9) {
            if (isdefined(var_aafdab5f.target)) {
                a_s_spawns = struct::get_array(var_aafdab5f.targetname, "<dev string:x8e>");
                foreach (n_index, s_spawn in a_s_spawns) {
                    util::add_debug_command("<dev string:x98>" + var_aafdab5f.target + "<dev string:xc2>" + n_index + "<dev string:xcd>" + var_aafdab5f.target + "<dev string:xed>" + n_index + "<dev string:xf2>");
                }
                util::add_debug_command("<dev string:x98>" + var_aafdab5f.target + "<dev string:xf7>" + var_aafdab5f.target + "<dev string:xf2>");
            }
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0x582535ad, Offset: 0x720
    // Size: 0x1b0
    function private function_c4fe091c() {
        util::add_debug_command("<dev string:x128>");
        util::add_debug_command("<dev string:x184>");
        util::add_debug_command("<dev string:x1dc>");
        util::add_debug_command("<dev string:x238>");
        var_de82b392 = function_19df1c1c();
        foreach (str_aitype in var_de82b392) {
            str_aitype = function_9e72a96(str_aitype);
            util::add_debug_command("<dev string:x290>" + str_aitype + "<dev string:x2ac>" + str_aitype + "<dev string:xf2>");
            util::add_debug_command("<dev string:x290>" + str_aitype + "<dev string:x2dd>" + str_aitype + "<dev string:xf2>");
            util::add_debug_command("<dev string:x290>" + str_aitype + "<dev string:x30b>" + str_aitype + "<dev string:xf2>");
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x0
    // Checksum 0xfc424e95, Offset: 0x8d8
    // Size: 0x8b4
    function function_8cf627fd(params) {
        self notify("<dev string:x33c>");
        self endon("<dev string:x33c>");
        waitframe(1);
        switch (params.value) {
        case #"defend_setup":
            array::thread_all(function_a1ef346b(), &zm_devgui::function_8d799ebd);
            break;
        case #"hash_1f1842f8525e2b9e":
            array::thread_all(function_a1ef346b(), &zm_devgui::zombie_devgui_give_money, 50);
            break;
        case #"hash_122c4df3e2c0a31e":
            array::thread_all(function_a1ef346b(), &zm_devgui::zombie_devgui_give_money, 100);
            break;
        case #"hash_346579f3f60438aa":
            array::thread_all(function_a1ef346b(), &zm_devgui::zombie_devgui_give_money, 500);
            break;
        case #"hash_ca6d38b092c2dae":
            array::thread_all(function_a1ef346b(), &zm_devgui::zombie_devgui_give_money, 5000);
            break;
        case #"hash_27d4bc4bf6d98bdf":
            array::thread_all(function_a1ef346b(), &namespace_dd7e54e3::function_b2f69241);
            break;
        case #"hash_67c3788855e430dd":
            array::thread_all(function_a1ef346b(), &namespace_dd7e54e3::give_armor, #"armor_item_lv1_t9_sr");
            break;
        case #"hash_67c3758855e42bc4":
            array::thread_all(function_a1ef346b(), &namespace_dd7e54e3::give_armor, #"armor_item_lv2_t9_sr");
            break;
        case #"hash_67c3768855e42d77":
            array::thread_all(function_a1ef346b(), &namespace_dd7e54e3::give_armor, #"armor_item_lv3_t9_sr");
            break;
        case #"hash_278d3011e8daefc9":
            var_cc6e64ae = getdvarint(#"hash_7255c78e5d6bfa33", -1);
            if (isdefined(level.var_37778628)) {
                [[ level.var_37778628 ]](var_cc6e64ae);
            }
            break;
        case #"hash_68b02f0279a6018a":
            level.var_c7552541 = !is_true(level.var_c7552541);
            if (level.var_c7552541) {
                level thread debug_attackables();
            } else {
                level notify(#"debug_attackables");
            }
            break;
        case #"hash_17f656e4906d263d":
            zombies = getaiarchetypearray(#"zombie");
            foreach (zombie in zombies) {
                zombie zombie_utility::set_zombie_run_cycle_override_value("<dev string:x350>");
            }
            break;
        case #"hash_58f657c627e51661":
            level.var_f662b93f = !is_true(level.var_f662b93f);
            if (level.var_f662b93f) {
                getplayers()[0] thread function_df5be8b2();
            } else {
                level notify(#"hash_624d34392463b628");
            }
            break;
        case #"hash_3d82e58502d3b9a7":
            v_origin = getplayers()[0] function_7ae85497();
            v_origin = getclosestpointonnavmesh(v_origin, 64, 32);
            if (!isdefined(v_origin)) {
                break;
            }
            if (!isdefined(level.var_29cf6901)) {
                level.var_29cf6901 = {};
            }
            level.var_29cf6901.start = v_origin;
            level thread function_37c30a3b();
            break;
        case #"hash_166eb0846966ee22":
            v_origin = getplayers()[0] function_7ae85497();
            v_origin = getclosestpointonnavmesh(v_origin, 64, 32);
            if (!isdefined(v_origin)) {
                break;
            }
            if (!isdefined(level.var_29cf6901)) {
                level.var_29cf6901 = {};
            }
            level.var_29cf6901.end = v_origin;
            level thread function_37c30a3b();
            break;
        case #"hash_5814e765f67e3421":
            if (isdefined(level.var_29cf6901)) {
                level.var_29cf6901 = undefined;
                level notify(#"hash_38fcca4f222bb813");
            }
            break;
        case #"hash_53ef32337d945db1":
            if (!(isdefined(level.var_29cf6901.start) && isdefined(level.var_29cf6901) && isdefined(level.var_29cf6901.end))) {
                break;
            }
            if (isdefined(level.var_29cf6901.ai)) {
                level.var_29cf6901.ai deletedelay();
            }
            forward = level.var_29cf6901.end - level.var_29cf6901.start;
            var_1a614c37 = spawnactor(#"spawner_zm_zombie", level.var_29cf6901.start, vectortoangles((0, forward[1], 0)), "<dev string:x35a>", 1);
            if (!isdefined(var_1a614c37)) {
                break;
            }
            var_1a614c37.ignoreall = 1;
            var_1a614c37.var_67faa700 = 1;
            var_1a614c37.backedupgoal = var_1a614c37.origin;
            var_1a614c37.b_ignore_cleanup = 1;
            var_1a614c37 thread function_eee42c73();
            level.var_29cf6901.ai = var_1a614c37;
            break;
        default:
            return;
        }
        setdvar(#"hash_3a0015e9f67cadaf", "<dev string:x38>");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x0
    // Checksum 0xda72944, Offset: 0x1198
    // Size: 0x94
    function function_eee42c73() {
        self endon(#"death");
        while (isdefined(level.var_29cf6901) && zm_utility::is_classic() && !is_true(self.completed_emerging_into_playable_area)) {
            waitframe(1);
        }
        self setgoal(level.var_29cf6901.end);
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x0
    // Checksum 0xeaa1435e, Offset: 0x1238
    // Size: 0x188
    function function_37c30a3b() {
        self notify("<dev string:x36a>");
        self endon("<dev string:x36a>");
        level endon(#"game_ended", #"hash_38fcca4f222bb813");
        while (true) {
            waitframe(1);
            if (!isdefined(level.var_29cf6901)) {
                continue;
            }
            if (isdefined(level.var_29cf6901.start)) {
                debugstar(level.var_29cf6901.start, 1, (0, 1, 0));
            }
            if (isdefined(level.var_29cf6901.end)) {
                debugstar(level.var_29cf6901.end, 1, (1, 0, 0));
            }
            if (isdefined(level.var_29cf6901.ai)) {
                line(level.var_29cf6901.ai.origin, level.var_29cf6901.ai.origin + (0, 0, level.var_29cf6901.ai function_6a9ae71()), (1, 0, 1), 1, 0, 1);
            }
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x0
    // Checksum 0xac37e8d6, Offset: 0x13c8
    // Size: 0xe8
    function function_7ae85497(*dist) {
        v_forward = anglestoforward(self getplayerangles());
        v_forward = vectorscale(v_forward, 4000);
        var_5927a215 = (10, 10, 10);
        v_eye = self getplayercamerapos();
        var_abd03397 = physicstrace(v_eye, v_eye + v_forward, -1 * var_5927a215, var_5927a215, getplayers()[0], 64 | 2);
        return var_abd03397[#"position"];
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x0
    // Checksum 0xc964c950, Offset: 0x14b8
    // Size: 0x2e4
    function function_33430942(params) {
        self notify("<dev string:x37e>");
        self endon("<dev string:x37e>");
        waitframe(1);
        if (params.value === "<dev string:x38>") {
            return;
        }
        switch (params.name) {
        case #"hash_664590b4ac90cb22":
            host = getplayers()[0];
            v_origin = host function_7ae85497();
            ai = spawnactor(params.value, v_origin, host.angles + (0, 180, 0), "<dev string:x35a>", 1);
            if (isdefined(ai)) {
                if (!isdefined(level.var_a46cf88a)) {
                    level.var_a46cf88a = [];
                } else if (!isarray(level.var_a46cf88a)) {
                    level.var_a46cf88a = array(level.var_a46cf88a);
                }
                level.var_a46cf88a[level.var_a46cf88a.size] = ai;
                function_1eaaceab(level.var_a46cf88a);
            } else {
                iprintlnbold("<dev string:x391>" + params.value + "<dev string:x39e>" + getailimit() + "<dev string:x3d7>");
            }
            break;
        case #"hash_6307f5372b3c2a6f":
            function_e645d51a(level.var_a46cf88a, params.value);
            break;
        case #"hash_5c0d8210d7e4072b":
            function_e645d51a(getaiarray(), params.value);
            break;
        default:
            break;
        }
        setdvar(#"hash_664590b4ac90cb22", "<dev string:x38>");
        setdvar(#"hash_6307f5372b3c2a6f", "<dev string:x38>");
        setdvar(#"hash_5c0d8210d7e4072b", "<dev string:x38>");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 2, eflags: 0x4
    // Checksum 0x80370f5e, Offset: 0x17a8
    // Size: 0x10c
    function private function_e645d51a(a_ai, str_aitype) {
        if (isarray(a_ai)) {
            foreach (ai in a_ai) {
                if (isalive(ai) && (!isdefined(str_aitype) || ai.aitype === str_aitype)) {
                    ai.allowdeath = 1;
                    ai kill();
                }
            }
            function_1eaaceab(a_ai);
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x4
    // Checksum 0x3ea9f50a, Offset: 0x18c0
    // Size: 0x50
    function private function_867e712a(params) {
        if (params.value) {
            level thread function_51403488();
            return;
        }
        level notify(#"hash_275c4bf3f697b9e");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0xff26fb8c, Offset: 0x1918
    // Size: 0x1ba
    function private function_51403488() {
        level notify(#"hash_275c4bf3f697b9e");
        level endon(#"hash_275c4bf3f697b9e", #"end_game", #"game_ended");
        while (true) {
            player = getplayers()[0];
            if (!isdefined(player)) {
                return;
            }
            a_ai = player getenemiesinradius(player.origin, 2000);
            foreach (ai in a_ai) {
                if (isalive(ai)) {
                    print3d(ai.origin + (0, 0, 68), "<dev string:x3de>" + ai.health + "<dev string:x3e6>" + (isdefined(ai.maxhealth) ? ai.maxhealth : "<dev string:x3eb>"), (0, 1, 0), 1, 0.5);
                }
            }
            waitframe(1);
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x4
    // Checksum 0x32792933, Offset: 0x1ae0
    // Size: 0x50
    function private function_ad391a04(params) {
        if (params.value) {
            level thread print_zombie_counts();
            return;
        }
        level notify(#"hash_87534d41fedbdf9");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0x640d97ab, Offset: 0x1b38
    // Size: 0x342
    function private print_zombie_counts() {
        level notify(#"hash_87534d41fedbdf9");
        level endon(#"hash_87534d41fedbdf9");
        while (true) {
            var_c708e6e1 = 120;
            var_6a432250 = [];
            a_ai = getaiarray();
            foreach (ai in a_ai) {
                if (isalive(ai)) {
                    if (isdefined(ai.var_9fde8624)) {
                        str_archetype = function_9e72a96(ai.archetype) + "<dev string:x3f0>" + function_9e72a96(ai.var_9fde8624) + "<dev string:x3f6>";
                    } else {
                        str_archetype = function_9e72a96(ai.archetype);
                    }
                    if (!isdefined(var_6a432250[str_archetype])) {
                        var_6a432250[str_archetype] = 0;
                    }
                    var_6a432250[str_archetype]++;
                }
            }
            debug2dtext((700, var_c708e6e1, 0), "<dev string:x3fb>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1.5, 5);
            var_c708e6e1 += 33;
            debug2dtext((700, var_c708e6e1, 0), "<dev string:x415>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 5);
            foreach (str_archetype, n_ai_count in var_6a432250) {
                var_c708e6e1 += 22;
                debug2dtext((700, var_c708e6e1, 0), function_9e72a96(str_archetype) + "<dev string:x440>" + n_ai_count + "<dev string:x446>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 5);
            }
            waitframe(5);
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x4
    // Checksum 0xf4eec608, Offset: 0x1e88
    // Size: 0x100
    function private function_3fe9e6d5(params) {
        if (params.value) {
            spawner::add_ai_spawn_function(&function_e9939aa7);
            foreach (zombie in getactorarray()) {
                zombie thread function_e9939aa7();
            }
            return;
        }
        spawner::function_932006d1(&function_e9939aa7);
        level notify(#"hash_339fb98e940fbaf6");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0xd705975d, Offset: 0x1f90
    // Size: 0x90
    function private function_e9939aa7() {
        self endon(#"death");
        level endon(#"hash_339fb98e940fbaf6");
        while (true) {
            waitframe(1);
            record3dtext(is_true(self.var_1fa24724) ? "<dev string:x44b>" : "<dev string:x464>", self.origin, (0, 1, 0), "<dev string:x47b>", self);
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x4
    // Checksum 0xc0efb2, Offset: 0x2028
    // Size: 0x58
    function private function_f1f26ccb(params) {
        level.var_2b46c827 = is_true(params.value);
        if (!level.var_2b46c827) {
            level notify(#"hash_39e4c9a17bf97f7d");
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x4
    // Checksum 0xa4109ccf, Offset: 0x2088
    // Size: 0x24c
    function private function_42d3c9f5(params) {
        if (params.value === "<dev string:x38>") {
            return;
        }
        var_bfae6869 = strtok(params.value, "<dev string:xed>");
        var_3480e14d = var_bfae6869[0];
        var_a75f9486 = var_bfae6869[1];
        s_instance = content_manager::get_children(struct::get(var_3480e14d))[0];
        a_s_spawns = content_manager::get_children(s_instance);
        if (isdefined(var_a75f9486)) {
            var_a75f9486 = int(var_a75f9486);
            player = getplayers()[0];
            player setorigin(a_s_spawns[var_a75f9486].origin);
            player setplayerangles(a_s_spawns[var_a75f9486].angles);
        } else {
            foreach (n_index, player in getplayers()) {
                s_spawn = a_s_spawns[n_index];
                if (isdefined(s_spawn)) {
                    player setorigin(s_spawn.origin);
                    player setplayerangles(s_spawn.angles);
                }
            }
        }
        setdvar(#"hash_e4ff0414d01c696", "<dev string:x38>");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x0
    // Checksum 0xfc5d430a, Offset: 0x22e0
    // Size: 0xac
    function function_2fab7a62(str_type) {
        str_dvar = "<dev string:x485>" + str_type;
        util::init_dvar(str_dvar, 0, &function_2a3a4bf6);
        util::add_devgui(content_manager::devgui_path("<dev string:x49d>", function_9e72a96(str_type), 103), "<dev string:x4bb>" + str_dvar + "<dev string:x4c6>");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x0
    // Checksum 0xcc5c8d73, Offset: 0x2398
    // Size: 0xcc
    function function_2a3a4bf6(params) {
        var_806a0877 = function_9e72a96(params.name);
        a_str_tokens = strtok(var_806a0877, "<dev string:xed>");
        assert(isdefined(a_str_tokens) && a_str_tokens.size > 1, var_806a0877 + "<dev string:x4ce>");
        str_type = a_str_tokens[1];
        level thread function_afb25532(str_type, params.value);
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 2, eflags: 0x0
    // Checksum 0x57a9f413, Offset: 0x2470
    // Size: 0x3be
    function function_afb25532(str_type, b_enable) {
        if (!isdefined(b_enable)) {
            b_enable = 1;
        }
        level notify("<dev string:x53e>" + str_type);
        level endon("<dev string:x53e>" + str_type, #"end_game", #"game_ended");
        if (b_enable) {
            while (true) {
                player = getplayers()[0];
                if (!isdefined(player)) {
                    return;
                }
                var_e5880035 = struct::get_array(str_type, "<dev string:x77>");
                if (!var_e5880035.size) {
                    return;
                }
                foreach (var_97aab885 in var_e5880035) {
                    if (isdefined(var_97aab885.contentgroups[#"capture_point"][0])) {
                        v_loc = var_97aab885.contentgroups[#"capture_point"][0].origin;
                        v_color = (0, 1, 0);
                    } else if (isdefined(var_97aab885.contentgroups[#"chest_spawn"][0])) {
                        v_loc = var_97aab885.contentgroups[#"chest_spawn"][0].origin;
                        v_color = (0, 1, 0);
                    } else if (isdefined(var_97aab885.contentgroups[#"trigger_spawn"][0])) {
                        v_loc = var_97aab885.contentgroups[#"trigger_spawn"][0].origin;
                        v_color = (0, 1, 0);
                    } else {
                        v_loc = var_97aab885.origin;
                        v_color = (1, 0, 0);
                    }
                    print3d(v_loc, "<dev string:x556>" + str_type + "<dev string:x567>" + (isdefined(var_97aab885.targetname) ? var_97aab885.targetname : "<dev string:x578>"), (1, 1, 0), undefined, 1);
                    n_radius = 64;
                    n_dist = distance(v_loc, player.origin);
                    n_radius *= n_dist / 3000;
                    sphere(v_loc, n_radius, v_color);
                }
                debug2dtext((100, 900, 0), "<dev string:x58b>", (0, 1, 0), undefined, undefined, undefined, 1.5);
                debug2dtext((100, 925, 0), "<dev string:x5aa>", (1, 0, 0), undefined, undefined, undefined, 1.5);
                waitframe(1);
            }
            return;
        }
        level notify("<dev string:x53e>" + str_type);
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x0
    // Checksum 0xc323343c, Offset: 0x2838
    // Size: 0x296
    function debug_attackables() {
        level notify(#"debug_attackables");
        level endon(#"debug_attackables");
        while (isdefined(level.attackables)) {
            foreach (attackable in level.attackables) {
                circle(attackable.origin, attackable.var_b79a8ac7.var_f019ea1a, (1, 0, 1), 0, 1);
                foreach (slot in attackable.var_b79a8ac7.slots) {
                    circle(slot.origin, 8, (1, 0, 1), 0, 1);
                    debugstar(slot.origin, 1, (1, 0, 1));
                    line(attackable.origin, slot.origin, (1, 0, 1), 1, 0);
                    if (!isalive(slot.entity)) {
                        continue;
                    }
                    circle(slot.entity.origin, slot.entity getpathfindingradius(), (0, 1, 1), 0, 1);
                    line(slot.origin, slot.entity.origin, (0, 1, 1), 1, 0);
                }
            }
            waitframe(1);
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 2, eflags: 0x0
    // Checksum 0x1db2d015, Offset: 0x2ad8
    // Size: 0x588
    function function_46997bdf(spawn_points, var_e6c99abc) {
        level endon(#"game_ended");
        if (!isdefined(var_e6c99abc)) {
            var_e6c99abc = "<dev string:x5c9>";
        }
        totalspawns = spawn_points.size;
        if (!isdefined(level.contentmanager.currentdestination)) {
            return;
        }
        destination = level.contentmanager.currentdestination;
        iprintln("<dev string:x5d3>" + var_e6c99abc + "<dev string:x5f3>");
        println("<dev string:x5fe>");
        println("<dev string:x64c>" + destination.targetname + "<dev string:x653>" + totalspawns + "<dev string:x5f3>");
        println("<dev string:x677>" + var_e6c99abc + "<dev string:x687>");
        println("<dev string:x5fe>");
        level notify(#"hash_2d15e9ef4a8fd60c");
        level.var_5c5abaf2 = 1;
        level.var_135a36f7 = [];
        level.var_d3582224 = 0;
        var_4777a582 = getdvar(#"hash_7c3872b765911891");
        setdvar(#"hash_7c3872b765911891", 0);
        if (var_4777a582 != 0) {
            wait 3;
        }
        available_slots = getailimit() - getaicount();
        iprintln("<dev string:x6a9>" + available_slots);
        foreach (spawn_point in spawn_points) {
            available_slots = getailimit() - getaicount();
            if (available_slots > 0 && function_103c90c0(spawn_point, 0)) {
                available_slots -= 1;
            }
            while (available_slots <= 0) {
                available_slots = getailimit() - getaicount();
                wait 0.1;
            }
        }
        while (level.var_d3582224 > 0) {
            wait 0.1;
        }
        var_d6d7c500 = level.var_135a36f7.size > 0;
        var_76fb4fcc = var_d6d7c500 ? "<dev string:x6c6>" + level.var_135a36f7.size + "<dev string:x5f3>" : "<dev string:x6d5>";
        color = var_d6d7c500 ? "<dev string:x6df>" : "<dev string:x6e5>";
        println(color + "<dev string:x6eb>");
        println(color + "<dev string:x737>" + destination.targetname + "<dev string:x73c>" + var_e6c99abc + "<dev string:x741>" + var_76fb4fcc);
        println(color + "<dev string:x6eb>");
        iprintlnbold(color + "<dev string:x737>" + destination.targetname + "<dev string:x73c>" + var_e6c99abc + "<dev string:x741>" + var_76fb4fcc);
        if (var_d6d7c500) {
            foreach (msg in level.var_135a36f7) {
                println(color + msg);
            }
            println(color + "<dev string:x6eb>");
        }
        setdvar(#"hash_7c3872b765911891", var_4777a582);
        level.var_5c5abaf2 = 0;
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x0
    // Checksum 0x880652dd, Offset: 0x3068
    // Size: 0x254
    function function_70e877d7(spawn_points) {
        level.var_135a36f7 = undefined;
        var_d610cbe2 = sqr(1000);
        player = getplayers()[0];
        player_vec = vectornormalize(anglestoforward(player getplayerangles()));
        var_167af5ff = undefined;
        best_dot = 0.707;
        foreach (spawn_point in spawn_points) {
            var_a9944b6 = vectornormalize(spawn_point.origin - player.origin);
            dot = vectordot(player_vec, var_a9944b6);
            if (dot > best_dot && distancesquared(spawn_point.origin, player.origin) < var_d610cbe2) {
                best_dot = dot;
                var_167af5ff = spawn_point;
            }
        }
        if (isdefined(var_167af5ff)) {
            iprintln("<dev string:x757>" + var_167af5ff.origin);
            if (function_103c90c0(var_167af5ff, 1)) {
                debugstar(var_167af5ff.origin, 30, (0, 0, 1), "<dev string:x777>");
            }
            return;
        }
        iprintln("<dev string:x783>");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 2, eflags: 0x0
    // Checksum 0x20573b5d, Offset: 0x32c8
    // Size: 0x182
    function function_103c90c0(spawn_point, var_957493b8) {
        if (!isdefined(var_957493b8)) {
            var_957493b8 = 0;
        }
        new_ai = spawnactor(#"hash_7cba8a05511ceedf", spawn_point.origin, spawn_point.angles, undefined, 1);
        if (!isdefined(new_ai)) {
            println("<dev string:x79e>" + spawn_point.origin);
            debugstar(spawn_point.origin, 30, (1, 0, 0), "<dev string:x7c7>");
            return 0;
        }
        if (!isdefined(level.var_d3582224)) {
            level.var_d3582224 = 0;
        }
        if (is_false(var_957493b8)) {
            level.var_d3582224 += 1;
        }
        if (isdefined(spawn_point.var_90d0c0ff) && function_c4cb6239(#"hash_7cba8a05511ceedf", spawn_point.var_90d0c0ff)) {
            new_ai.var_c9b11cb3 = spawn_point.var_90d0c0ff;
        }
        new_ai thread function_fabd315d(spawn_point, var_957493b8);
        return 1;
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 2, eflags: 0x0
    // Checksum 0x7e208ceb, Offset: 0x3458
    // Size: 0x4ec
    function function_fabd315d(spawn_point, var_957493b8) {
        if (is_false(var_957493b8)) {
            self endoncallback(&function_cad1a4b5, #"death");
        } else {
            self endon(#"death");
        }
        self waittill(#"hash_790882ac8688cee5");
        if (!ispointonnavmesh(self.origin, self)) {
            println("<dev string:x7dd>" + spawn_point.origin);
            debugstar(spawn_point.origin, 80, (1, 0, 0), "<dev string:x81b>");
            if (isdefined(level.var_135a36f7)) {
                errormsg = "<dev string:x833>" + spawn_point.origin;
                if (isdefined(self.var_90d0c0ff) && isdefined(self.var_1a02009e)) {
                    errormsg += "<dev string:x85c>" + self.var_90d0c0ff + "<dev string:x869>" + function_9e72a96(self.var_1a02009e);
                }
                level.var_135a36f7[level.var_135a36f7.size] = errormsg;
            } else {
                errormsg = "<dev string:x833>" + spawn_point.origin;
                if (isdefined(self.var_90d0c0ff) && isdefined(self.var_1a02009e)) {
                    errormsg += "<dev string:x85c>" + self.var_90d0c0ff + "<dev string:x869>" + function_9e72a96(self.var_1a02009e);
                }
                println("<dev string:x875>" + errormsg);
            }
        } else {
            self.cant_move_cb = &function_bc21ac74;
            var_6e56b150 = 0;
            for (i = 0; i < 2; i++) {
                goal = awareness::function_b184324d(spawn_point.origin, isdefined(spawn_point.wander_radius) ? spawn_point.wander_radius : 128, self getpathfindingradius() * 1.2, self getpathfindingradius() * 1.2);
                if (isdefined(goal)) {
                    self setgoal(goal);
                }
                waitresult = self waittilltimeout(7, #"goal", #"bad_path", #"death");
                if (waitresult._notify == #"goal" || waitresult._notify == "<dev string:x87c>") {
                    break;
                } else if (waitresult._notify == #"bad_path") {
                    var_6e56b150++;
                }
                self waittilltimeout(2, #"goal_changed");
            }
            if (var_6e56b150 >= 2) {
                println("<dev string:x885>" + spawn_point.origin);
                debugstar(spawn_point.origin, 80, (1, 0, 0), "<dev string:x8bc>");
                if (isdefined(level.var_135a36f7)) {
                    errormsg = "<dev string:x8da>" + spawn_point.origin;
                    if (isdefined(self.var_90d0c0ff) && isdefined(self.var_1a02009e)) {
                        errormsg += "<dev string:x85c>" + self.var_90d0c0ff + "<dev string:x869>" + function_9e72a96(self.var_1a02009e);
                    }
                    level.var_135a36f7[level.var_135a36f7.size] = errormsg;
                }
            }
        }
        if (is_false(var_957493b8)) {
            self.allowdeath = 1;
            self kill();
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x4
    // Checksum 0xcc33d1d5, Offset: 0x3950
    // Size: 0x2c
    function private function_cad1a4b5(*str_notify) {
        level.var_d3582224 -= 1;
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0xf3bcacc7, Offset: 0x3988
    // Size: 0x1e
    function private function_bc21ac74() {
        self notify(#"bad_path");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0xb33efd72, Offset: 0x39b0
    // Size: 0x26e
    function private function_df5be8b2() {
        self endon(#"death", #"disconnect");
        level endon(#"hash_624d34392463b628");
        while (true) {
            view_pos = self getplayercamerapos();
            dir = anglestoforward(self getplayerangles()) * 500;
            end_pos = view_pos + dir;
            trace = physicstraceex(view_pos, end_pos, (0, 0, 0), (0, 0, 0), self);
            if (getdvarint(#"recorder_enablerec", 0)) {
                recordline(view_pos, view_pos + dir * trace[#"fraction"], (0, 1, 0), "<dev string:x47b>");
            } else {
                line(view_pos, view_pos + dir * trace[#"fraction"], (0, 1, 0));
            }
            if (getdvarint(#"recorder_enablerec", 0)) {
                recordcircle(end_pos, 32, (0, 1, 0), "<dev string:x47b>");
            } else {
                circle(end_pos, 32, (0, 1, 0), 0, 1);
            }
            if (getdvarint(#"recorder_enablerec", 0)) {
                recordstar(view_pos + dir * trace[#"fraction"], (1, 0, 0), "<dev string:x47b>");
            } else {
                debugstar(view_pos + dir * trace[#"fraction"], (1, 0, 0));
            }
            waitframe(1);
        }
    }

#/
