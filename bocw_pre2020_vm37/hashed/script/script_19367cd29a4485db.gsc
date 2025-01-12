#using script_16b1b77a76492c6a;
#using script_2618e0f3e5e11649;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_7a5293d92c61c788;
#using script_7fc996fe8678852;
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

#namespace namespace_420b39d3;

/#

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x6
    // Checksum 0x9e222df6, Offset: 0x148
    // Size: 0x4c
    function private autoexec __init__system__() {
        system::register(#"hash_3a0015e9f67cadaf", &function_70a657d8, &postinit, undefined, undefined);
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0x31e8ac23, Offset: 0x1a0
    // Size: 0x1b4
    function private function_70a657d8() {
        util::init_dvar(#"hash_3a0015e9f67cadaf", "<dev string:x38>", &function_8cf627fd);
        util::init_dvar(#"hash_664590b4ac90cb22", "<dev string:x38>", &function_33430942);
        util::init_dvar(#"hash_6307f5372b3c2a6f", "<dev string:x38>", &function_33430942);
        util::init_dvar(#"hash_5c0d8210d7e4072b", "<dev string:x38>", &function_33430942);
        util::init_dvar(#"hash_e4ff0414d01c696", "<dev string:x38>", &function_42d3c9f5);
        util::init_dvar(#"hash_5c583988a48d4115", 0, &function_867e712a);
        util::init_dvar(#"hash_601883712ebe3542", 0, &function_ad391a04);
        util::init_dvar(#"hash_6f6defbd7ae55a98", 0, &function_3fe9e6d5);
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0x6280e97a, Offset: 0x360
    // Size: 0x1c
    function private postinit() {
        level thread function_76de3950();
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x0
    // Checksum 0x23d63831, Offset: 0x388
    // Size: 0x140
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
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0x4c09b914, Offset: 0x4d0
    // Size: 0x1e8
    function private function_6f31d177() {
        var_d9c347d9 = struct::get_array("<dev string:x63>", "<dev string:x72>");
        foreach (var_aafdab5f in var_d9c347d9) {
            if (isdefined(var_aafdab5f.target)) {
                a_s_spawns = struct::get_array(var_aafdab5f.targetname, "<dev string:x89>");
                foreach (n_index, s_spawn in a_s_spawns) {
                    util::add_debug_command("<dev string:x93>" + var_aafdab5f.target + "<dev string:xbd>" + n_index + "<dev string:xc8>" + var_aafdab5f.target + "<dev string:xe8>" + n_index + "<dev string:xed>");
                }
                util::add_debug_command("<dev string:x93>" + var_aafdab5f.target + "<dev string:xf2>" + var_aafdab5f.target + "<dev string:xed>");
            }
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x4
    // Checksum 0x8072f834, Offset: 0x6c0
    // Size: 0x150
    function private function_c4fe091c() {
        var_de82b392 = function_19df1c1c();
        foreach (var_7ecdee63 in var_de82b392) {
            var_7ecdee63 = function_9e72a96(var_7ecdee63);
            util::add_debug_command("<dev string:x123>" + var_7ecdee63 + "<dev string:x13f>" + var_7ecdee63 + "<dev string:xed>");
            util::add_debug_command("<dev string:x123>" + var_7ecdee63 + "<dev string:x170>" + var_7ecdee63 + "<dev string:xed>");
            util::add_debug_command("<dev string:x123>" + var_7ecdee63 + "<dev string:x19e>" + var_7ecdee63 + "<dev string:xed>");
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x0
    // Checksum 0x57f2b80, Offset: 0x818
    // Size: 0x52c
    function function_8cf627fd(params) {
        self notify("<dev string:x1cf>");
        self endon("<dev string:x1cf>");
        waitframe(1);
        switch (params.value) {
        case #"hash_c959cc1595e2f7":
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
                level thread function_e59c3c07();
            } else {
                level notify(#"hash_2a5b4fb329b3984a");
            }
            break;
        case #"hash_79295473b7f29d5":
            var_9965967d = namespace_ce1f29cc::function_fac3e87c();
            var_625b64e6 = namespace_2c949ef8::function_10c88d2e();
            spawns = arraycombine(&var_9965967d, &var_625b64e6, 0);
            level thread function_46997bdf(&spawns, "<dev string:x1e3>");
            break;
        case #"hash_6c29b11ea918c7bb":
            var_9965967d = namespace_ce1f29cc::function_fac3e87c();
            var_625b64e6 = namespace_2c949ef8::function_10c88d2e();
            spawns = arraycombine(&var_9965967d, &var_625b64e6, 0);
            function_70e877d7(&spawns);
            break;
        default:
            return;
        }
        setdvar(#"hash_3a0015e9f67cadaf", "<dev string:x38>");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x0
    // Checksum 0xf7dca1c3, Offset: 0xd50
    // Size: 0x3a4
    function function_33430942(params) {
        self notify("<dev string:x1f5>");
        self endon("<dev string:x1f5>");
        waitframe(1);
        if (params.value === "<dev string:x38>") {
            return;
        }
        switch (params.name) {
        case #"hash_664590b4ac90cb22":
            host = getplayers()[0];
            v_forward = anglestoforward(host getplayerangles());
            v_forward = vectorscale(v_forward, 4000);
            var_5927a215 = (10, 10, 10);
            v_eye = host getplayercamerapos();
            var_abd03397 = physicstrace(v_eye, v_eye + v_forward, -1 * var_5927a215, var_5927a215, getplayers()[0], 64 | 2);
            v_origin = var_abd03397[#"position"];
            ai = spawnactor(params.value, v_origin, host.angles + (0, 180, 0), undefined, 1);
            if (isdefined(ai)) {
                if (!isdefined(level.var_a46cf88a)) {
                    level.var_a46cf88a = [];
                } else if (!isarray(level.var_a46cf88a)) {
                    level.var_a46cf88a = array(level.var_a46cf88a);
                }
                level.var_a46cf88a[level.var_a46cf88a.size] = ai;
                function_1eaaceab(level.var_a46cf88a);
            } else {
                iprintlnbold("<dev string:x209>" + params.value + "<dev string:x216>" + getailimit() + "<dev string:x24f>");
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
    // Checksum 0x6d20c6c8, Offset: 0x1100
    // Size: 0x10c
    function private function_e645d51a(a_ai, var_7ecdee63) {
        if (isarray(a_ai)) {
            foreach (ai in a_ai) {
                if (isalive(ai) && (!isdefined(var_7ecdee63) || ai.aitype === var_7ecdee63)) {
                    ai.allowdeath = 1;
                    ai kill();
                }
            }
            function_1eaaceab(a_ai);
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x4
    // Checksum 0xf319d587, Offset: 0x1218
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
    // Checksum 0xdfceec8a, Offset: 0x1270
    // Size: 0x192
    function private function_51403488() {
        level notify(#"hash_275c4bf3f697b9e");
        level endon(#"hash_275c4bf3f697b9e");
        while (true) {
            player = getplayers()[0];
            a_ai = player getenemiesinradius(player.origin, 2000);
            foreach (ai in a_ai) {
                if (isalive(ai)) {
                    print3d(ai.origin + (0, 0, 68), "<dev string:x256>" + ai.health + "<dev string:x25e>" + (isdefined(ai.maxhealth) ? ai.maxhealth : "<dev string:x263>"), (0, 1, 0), 1, 0.5);
                }
            }
            waitframe(1);
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x4
    // Checksum 0x9a70ae8f, Offset: 0x1410
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
    // Checksum 0x12b43a54, Offset: 0x1468
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
                        str_archetype = function_9e72a96(ai.archetype) + "<dev string:x268>" + function_9e72a96(ai.var_9fde8624) + "<dev string:x26e>";
                    } else {
                        str_archetype = function_9e72a96(ai.archetype);
                    }
                    if (!isdefined(var_6a432250[str_archetype])) {
                        var_6a432250[str_archetype] = 0;
                    }
                    var_6a432250[str_archetype]++;
                }
            }
            debug2dtext((700, var_c708e6e1, 0), "<dev string:x273>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1.5, 5);
            var_c708e6e1 += 33;
            debug2dtext((700, var_c708e6e1, 0), "<dev string:x28d>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 5);
            foreach (str_archetype, n_ai_count in var_6a432250) {
                var_c708e6e1 += 22;
                debug2dtext((700, var_c708e6e1, 0), function_9e72a96(str_archetype) + "<dev string:x2b8>" + n_ai_count + "<dev string:x2be>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 5);
            }
            waitframe(5);
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x4
    // Checksum 0xda839812, Offset: 0x17b8
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
    // Checksum 0x5363b77b, Offset: 0x18c0
    // Size: 0x90
    function private function_e9939aa7() {
        self endon(#"death");
        level endon(#"hash_339fb98e940fbaf6");
        while (true) {
            waitframe(1);
            record3dtext(is_true(self.var_1fa24724) ? "<dev string:x2c3>" : "<dev string:x2dc>", self.origin, (0, 1, 0), "<dev string:x2f3>", self);
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x4
    // Checksum 0x485aa2e6, Offset: 0x1958
    // Size: 0x24c
    function private function_42d3c9f5(params) {
        if (params.value === "<dev string:x38>") {
            return;
        }
        var_bfae6869 = strtok(params.value, "<dev string:xe8>");
        var_3480e14d = var_bfae6869[0];
        var_a75f9486 = var_bfae6869[1];
        s_instance = namespace_8b6a9d79::function_f703a5a(struct::get(var_3480e14d))[0];
        a_s_spawns = namespace_8b6a9d79::function_f703a5a(s_instance);
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
    // Checksum 0x26f2a1e7, Offset: 0x1bb0
    // Size: 0xac
    function function_2fab7a62(str_type) {
        str_dvar = "<dev string:x2fd>" + str_type;
        util::init_dvar(str_dvar, 0, &function_2a3a4bf6);
        util::add_devgui(namespace_8b6a9d79::devgui_path("<dev string:x315>", function_9e72a96(str_type), 103), "<dev string:x333>" + str_dvar + "<dev string:x33e>");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x0
    // Checksum 0xba0f9b9e, Offset: 0x1c68
    // Size: 0xcc
    function function_2a3a4bf6(params) {
        var_806a0877 = function_9e72a96(params.name);
        a_str_tokens = strtok(var_806a0877, "<dev string:xe8>");
        assert(isdefined(a_str_tokens) && a_str_tokens.size > 1, var_806a0877 + "<dev string:x346>");
        str_type = a_str_tokens[1];
        level thread function_afb25532(str_type, params.value);
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 2, eflags: 0x0
    // Checksum 0x7cddfc4e, Offset: 0x1d40
    // Size: 0x38e
    function function_afb25532(str_type, b_enable) {
        if (!isdefined(b_enable)) {
            b_enable = 1;
        }
        level notify("<dev string:x3b6>" + str_type);
        level endon("<dev string:x3b6>" + str_type);
        if (b_enable) {
            while (true) {
                var_e5880035 = struct::get_array(str_type, "<dev string:x72>");
                if (!var_e5880035.size) {
                    return;
                }
                foreach (var_97aab885 in var_e5880035) {
                    if (isdefined(var_97aab885.var_fe2612fe[#"capture_point"][0])) {
                        v_loc = var_97aab885.var_fe2612fe[#"capture_point"][0].origin;
                        v_color = (0, 1, 0);
                    } else if (isdefined(var_97aab885.var_fe2612fe[#"hash_6b1e5d8f9e70a70e"][0])) {
                        v_loc = var_97aab885.var_fe2612fe[#"hash_6b1e5d8f9e70a70e"][0].origin;
                        v_color = (0, 1, 0);
                    } else if (isdefined(var_97aab885.var_fe2612fe[#"trigger_spawn"][0])) {
                        v_loc = var_97aab885.var_fe2612fe[#"trigger_spawn"][0].origin;
                        v_color = (0, 1, 0);
                    } else {
                        v_loc = var_97aab885.origin;
                        v_color = (1, 0, 0);
                    }
                    print3d(v_loc, "<dev string:x3ce>" + str_type + "<dev string:x3df>" + (isdefined(var_97aab885.targetname) ? var_97aab885.targetname : "<dev string:x3f0>"), (1, 1, 0), undefined, 1);
                    n_radius = 64;
                    n_dist = distance(v_loc, getplayers()[0].origin);
                    n_radius *= n_dist / 3000;
                    sphere(v_loc, n_radius, v_color);
                }
                debug2dtext((100, 900, 0), "<dev string:x403>", (0, 1, 0), undefined, undefined, undefined, 1.5);
                debug2dtext((100, 925, 0), "<dev string:x422>", (1, 0, 0), undefined, undefined, undefined, 1.5);
                waitframe(1);
            }
            return;
        }
        level notify("<dev string:x3b6>" + str_type);
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 0, eflags: 0x0
    // Checksum 0x5c46e47, Offset: 0x20d8
    // Size: 0x296
    function function_e59c3c07() {
        level notify(#"hash_2a5b4fb329b3984a");
        level endon(#"hash_2a5b4fb329b3984a");
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
    // Checksum 0x4a49777b, Offset: 0x2378
    // Size: 0x588
    function function_46997bdf(spawn_points, var_e6c99abc) {
        level endon(#"game_ended");
        if (!isdefined(var_e6c99abc)) {
            var_e6c99abc = "<dev string:x441>";
        }
        totalspawns = spawn_points.size;
        if (!isdefined(level.var_7d45d0d4.currentdestination)) {
            return;
        }
        destination = level.var_7d45d0d4.currentdestination;
        iprintln("<dev string:x44b>" + var_e6c99abc + "<dev string:x46b>");
        println("<dev string:x476>");
        println("<dev string:x4c4>" + destination.targetname + "<dev string:x4cb>" + totalspawns + "<dev string:x46b>");
        println("<dev string:x4ef>" + var_e6c99abc + "<dev string:x4ff>");
        println("<dev string:x476>");
        level notify(#"hash_2d15e9ef4a8fd60c");
        level.var_5c5abaf2 = 1;
        level.var_135a36f7 = [];
        level.var_d3582224 = 0;
        var_4777a582 = getdvar(#"hash_7c3872b765911891");
        setdvar(#"hash_7c3872b765911891", 0);
        if (var_4777a582 != 0) {
            wait 3;
        }
        var_34bcb139 = getailimit() - getaicount();
        iprintln("<dev string:x521>" + var_34bcb139);
        foreach (spawn_point in spawn_points) {
            var_34bcb139 = getailimit() - getaicount();
            if (var_34bcb139 > 0 && function_103c90c0(spawn_point, 0)) {
                var_34bcb139 -= 1;
            }
            while (var_34bcb139 <= 0) {
                var_34bcb139 = getailimit() - getaicount();
                wait 0.1;
            }
        }
        while (level.var_d3582224 > 0) {
            wait 0.1;
        }
        var_d6d7c500 = level.var_135a36f7.size > 0;
        var_76fb4fcc = var_d6d7c500 ? "<dev string:x53e>" + level.var_135a36f7.size + "<dev string:x46b>" : "<dev string:x54d>";
        color = var_d6d7c500 ? "<dev string:x557>" : "<dev string:x55d>";
        println(color + "<dev string:x563>");
        println(color + "<dev string:x5af>" + destination.targetname + "<dev string:x5b4>" + var_e6c99abc + "<dev string:x5b9>" + var_76fb4fcc);
        println(color + "<dev string:x563>");
        iprintlnbold(color + "<dev string:x5af>" + destination.targetname + "<dev string:x5b4>" + var_e6c99abc + "<dev string:x5b9>" + var_76fb4fcc);
        if (var_d6d7c500) {
            foreach (msg in level.var_135a36f7) {
                println(color + msg);
            }
            println(color + "<dev string:x563>");
        }
        setdvar(#"hash_7c3872b765911891", var_4777a582);
        level.var_5c5abaf2 = 0;
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x0
    // Checksum 0x1f2e71b6, Offset: 0x2908
    // Size: 0x244
    function function_70e877d7(spawn_points) {
        var_d610cbe2 = function_a3f6cdac(1000);
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
            iprintln("<dev string:x5cf>" + var_167af5ff.origin);
            if (function_103c90c0(var_167af5ff, 1)) {
                debugstar(var_167af5ff.origin, 30, (0, 0, 1), "<dev string:x5ef>");
            }
            return;
        }
        iprintln("<dev string:x5fb>");
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 2, eflags: 0x0
    // Checksum 0x82031640, Offset: 0x2b58
    // Size: 0x182
    function function_103c90c0(spawn_point, var_957493b8) {
        if (!isdefined(var_957493b8)) {
            var_957493b8 = 0;
        }
        var_944250d2 = spawnactor(#"hash_7cba8a05511ceedf", spawn_point.origin, spawn_point.angles, undefined, 1);
        if (!isdefined(var_944250d2)) {
            println("<dev string:x616>" + spawn_point.origin);
            debugstar(spawn_point.origin, 30, (1, 0, 0), "<dev string:x63f>");
            return 0;
        }
        if (!isdefined(level.var_d3582224)) {
            level.var_d3582224 = 0;
        }
        if (is_false(var_957493b8)) {
            level.var_d3582224 += 1;
        }
        if (isdefined(spawn_point.var_90d0c0ff) && function_c4cb6239(#"hash_7cba8a05511ceedf", spawn_point.var_90d0c0ff)) {
            var_944250d2.var_c9b11cb3 = spawn_point.var_90d0c0ff;
        }
        var_944250d2 thread function_fabd315d(spawn_point, var_957493b8);
        return 1;
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 2, eflags: 0x0
    // Checksum 0x5809d3ef, Offset: 0x2ce8
    // Size: 0x3a4
    function function_fabd315d(spawn_point, var_957493b8) {
        if (is_false(var_957493b8)) {
            self endoncallback(&function_cad1a4b5, #"death");
        } else {
            self endon(#"death");
        }
        self waittill(#"goal_changed");
        if (!ispointonnavmesh(self.origin, self)) {
            println("<dev string:x655>" + spawn_point.origin);
            debugstar(spawn_point.origin, 80, (1, 0, 0), "<dev string:x693>");
            if (isdefined(level.var_135a36f7)) {
                errormsg = "<dev string:x6ab>" + spawn_point.origin;
                if (isdefined(self.var_90d0c0ff)) {
                    errormsg += "<dev string:x6d3>" + self.var_90d0c0ff;
                }
                level.var_135a36f7[level.var_135a36f7.size] = errormsg;
            }
        } else {
            for (i = 0; i < 1; i++) {
                goal = awareness::function_b184324d(spawn_point.origin, isdefined(spawn_point.wander_radius) ? spawn_point.wander_radius : 128, self getpathfindingradius() * 1.2, self getpathfindingradius() * 1.2);
                if (isdefined(goal)) {
                    self setgoal(goal);
                }
                waitresult = self waittilltimeout(10, #"goal", #"bad_path", #"death");
                if (waitresult._notify != #"goal" && waitresult._notify != "<dev string:x6e0>") {
                    println("<dev string:x6e9>" + spawn_point.origin);
                    debugstar(spawn_point.origin, 80, (1, 0, 0), "<dev string:x720>");
                    if (isdefined(level.var_135a36f7)) {
                        errormsg = "<dev string:x730>" + spawn_point.origin;
                        if (isdefined(self.var_90d0c0ff)) {
                            errormsg += "<dev string:x6d3>" + self.var_90d0c0ff;
                        }
                        level.var_135a36f7[level.var_135a36f7.size] = errormsg;
                    }
                    break;
                }
                self waittilltimeout(2, #"goal_changed");
            }
        }
        if (is_false(var_957493b8)) {
            self.allowdeath = 1;
            self kill();
        }
    }

    // Namespace namespace_420b39d3/namespace_420b39d3
    // Params 1, eflags: 0x4
    // Checksum 0xc58cfffb, Offset: 0x3098
    // Size: 0x2c
    function private function_cad1a4b5(*str_notify) {
        level.var_d3582224 -= 1;
    }

#/
