#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace art_test;

/#

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x6
    // Checksum 0xb9bc2efa, Offset: 0xa8
    // Size: 0x4c
    function private autoexec __init__system__() {
        system::register(#"art_test", &preinit, &postinit, undefined, undefined);
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x4
    // Checksum 0x3f89e1d2, Offset: 0x100
    // Size: 0x340
    function private preinit() {
        level.var_2fb0636f = struct::get_array("<dev string:x38>", "<dev string:x59>");
        if (!level.var_2fb0636f.size) {
            return;
        }
        setdvar(#"hash_68eef81d0a2a76ed", 1);
        setdvar(#"hash_3c4a113ed57cc120", 1);
        setdvar(#"hash_130bfa97ce58483d", "<dev string:x66>");
        setdvar(#"hash_236d76abc8b15698", "<dev string:x66>");
        setdvar(#"hash_69bc1ab1b58a4dd9", "<dev string:x66>");
        setdvar(#"hash_4adbfcef4bba8e12", "<dev string:x66>");
        setdvar(#"hash_2fd7846bcf2b3161", 0);
        level.var_402412cd = 1;
        level.var_5a4e0f2e = 1;
        level.var_59a2c772 = 0;
        level.var_acfca739 = 0;
        a_s_temp = [];
        foreach (n_index, s_instance in level.var_2fb0636f) {
            str_name = isdefined(s_instance.targetname) ? s_instance.targetname : "<dev string:x6a>" + n_index;
            s_instance.targetname = str_name;
            a_s_temp[str_name] = s_instance;
        }
        level.var_2fb0636f = arraycopy(a_s_temp);
        var_91562d8c = struct::get_array("<dev string:x82>", "<dev string:x95>");
        level.var_4aca3c1 = [];
        foreach (n_index, var_d7eff26a in var_91562d8c) {
            str_name = isdefined(var_d7eff26a.targetname) ? var_d7eff26a.targetname : "<dev string:xa4>" + n_index;
            level.var_4aca3c1[str_name] = var_d7eff26a;
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x4
    // Checksum 0x8bf5d969, Offset: 0x448
    // Size: 0x5c
    function private postinit() {
        if (!level.var_2fb0636f.size) {
            return;
        }
        function_f29b39b1();
        level thread function_51acf127();
        level thread function_291b284f();
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x7da15570, Offset: 0x4b0
    // Size: 0x8c
    function function_291b284f() {
        level flag::wait_till("<dev string:xc1>");
        level.var_59a2c772 = 1;
        level.var_acfca739 = 1;
        level thread function_1c40531e();
        level thread function_e01777dc();
        level thread function_fcde0f45();
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xd8b168ed, Offset: 0x548
    // Size: 0x3f4
    function function_51acf127() {
        adddebugcommand("<dev string:xe2>");
        adddebugcommand("<dev string:x12f>");
        adddebugcommand("<dev string:x17d>");
        util::waittill_can_add_debug_command();
        foreach (str_name, s_teleport in level.var_4aca3c1) {
            adddebugcommand("<dev string:x1d3>" + function_9e72a96(str_name) + "<dev string:x208>" + function_9e72a96(str_name) + "<dev string:x22c>");
        }
        foreach (var_80b4780d, s_instance in level.var_2fb0636f) {
            adddebugcommand("<dev string:x232>" + function_9e72a96(var_80b4780d) + "<dev string:x260>" + function_9e72a96(var_80b4780d) + "<dev string:x22c>");
            adddebugcommand("<dev string:x284>" + function_9e72a96(var_80b4780d) + "<dev string:x2b5>" + function_9e72a96(var_80b4780d) + "<dev string:x22c>");
            adddebugcommand("<dev string:x2dc>" + function_9e72a96(var_80b4780d) + "<dev string:x313>" + function_9e72a96(var_80b4780d) + "<dev string:x22c>");
            util::waittill_can_add_debug_command();
        }
        util::waittill_can_add_debug_command();
        adddebugcommand("<dev string:x337>");
        function_cd140ee9("<dev string:x38c>", &function_ddb1f662);
        function_cd140ee9("<dev string:x3a5>", &function_ddb1f662);
        function_cd140ee9("<dev string:x3c1>", &function_ddb1f662);
        function_cd140ee9("<dev string:x3de>", &function_ddb1f662);
        function_cd140ee9("<dev string:x3fa>", &function_ddb1f662);
        function_cd140ee9("<dev string:x419>", &function_ddb1f662);
        function_cd140ee9("<dev string:x435>", &function_ddb1f662);
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xa38db5a0, Offset: 0x948
    // Size: 0x1da
    function function_ddb1f662(params) {
        switch (params.name) {
        case #"hash_68eef81d0a2a76ed":
            level.var_59a2c772 = params.value;
            break;
        case #"hash_130bfa97ce58483d":
            teleport_player(params.value);
            break;
        case #"hash_3c4a113ed57cc120":
            level.var_acfca739 = params.value;
            break;
        case #"hash_236d76abc8b15698":
            thread function_e099a386(params.value);
            setdvar(#"hash_236d76abc8b15698", "<dev string:x66>");
            break;
        case #"hash_69bc1ab1b58a4dd9":
            function_d6a44f15(params.value);
            setdvar(#"hash_69bc1ab1b58a4dd9", "<dev string:x66>");
            break;
        case #"hash_4adbfcef4bba8e12":
            function_5f0fa6bb(params.value);
            setdvar(#"hash_4adbfcef4bba8e12", "<dev string:x66>");
            break;
        case #"hash_2fd7846bcf2b3161":
            function_cad382ca();
            break;
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xbff6a733, Offset: 0xb30
    // Size: 0xf0
    function function_cad382ca() {
        foreach (s_instance in level.var_2fb0636f) {
            if (isdefined(s_instance.var_906f7138)) {
                s_instance.var_906f7138 delete();
            }
            if (isdefined(s_instance.e_rotator)) {
                s_instance.e_rotator delete();
            }
            if (isdefined(s_instance.var_ef831719)) {
                s_instance.var_ef831719 delete();
            }
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x26dfefe0, Offset: 0xc28
    // Size: 0xc4
    function teleport_player(str_name) {
        if (str_name === "<dev string:x66>") {
            return;
        }
        s_teleport = level.var_4aca3c1[str_name];
        if (isdefined(s_teleport)) {
            player = util::gethostplayer();
            player setorigin(s_teleport.origin);
            player setplayerangles(s_teleport.angles);
            setdvar(#"hash_130bfa97ce58483d", "<dev string:x66>");
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xc961d671, Offset: 0xcf8
    // Size: 0x8a0
    function function_f29b39b1() {
        foreach (var_a0eafb23 in level.var_2fb0636f) {
            if (isdefined(var_a0eafb23.targetname)) {
                var_a0eafb23.var_c2e8ace2 = getentarray(var_a0eafb23.targetname, "<dev string:x44f>");
            }
            var_a52f9ea8 = getscriptbundle(var_a0eafb23.scriptbundlename);
            foreach (s_asset in var_a52f9ea8.assetlist) {
                if (s_asset.assettype === "<dev string:x459>") {
                    str_asset = s_asset.playeroutfit;
                } else {
                    str_asset = isdefined(s_asset.var_8427fa8a) ? s_asset.var_8427fa8a : s_asset.model;
                }
                var_1b72f1aa = {#str_name:str_asset, #str_label:s_asset.assetlabel, #str_type:s_asset.assettype};
                if (isarray(s_asset.var_7970f5e5)) {
                    foreach (s_anim in s_asset.var_7970f5e5) {
                        var_480e1f7d = {#animation:s_anim.animation, #var_867459dc:s_anim.attachmodel, #var_31e8d962:s_anim.var_e7723a7f};
                        var_480e1f7d.var_4ec51611 = (isdefined(s_anim.var_16da66bb) ? s_anim.var_16da66bb : 0, isdefined(s_anim.var_a8938a2f) ? s_anim.var_a8938a2f : 0, isdefined(s_anim.var_bb462f94) ? s_anim.var_bb462f94 : 0);
                        var_480e1f7d.var_4224ff2d = (isdefined(s_anim.var_45ebfe9b) ? s_anim.var_45ebfe9b : 0, isdefined(s_anim.var_e28537cb) ? s_anim.var_e28537cb : 0, isdefined(s_anim.var_b437db31) ? s_anim.var_b437db31 : 0);
                        if (!isdefined(var_1b72f1aa.var_ab3948d3)) {
                            var_1b72f1aa.var_ab3948d3 = [];
                        } else if (!isarray(var_1b72f1aa.var_ab3948d3)) {
                            var_1b72f1aa.var_ab3948d3 = array(var_1b72f1aa.var_ab3948d3);
                        }
                        var_1b72f1aa.var_ab3948d3[var_1b72f1aa.var_ab3948d3.size] = var_480e1f7d;
                    }
                }
                if (isarray(s_asset.var_a69bae99)) {
                    foreach (var_7517594c in s_asset.var_a69bae99) {
                        if (s_asset.assettype === "<dev string:x459>") {
                            if (!isdefined(var_1b72f1aa.var_cfa4576)) {
                                var_1b72f1aa.var_cfa4576 = [];
                            } else if (!isarray(var_1b72f1aa.var_cfa4576)) {
                                var_1b72f1aa.var_cfa4576 = array(var_1b72f1aa.var_cfa4576);
                            }
                            var_1b72f1aa.var_cfa4576[var_1b72f1aa.var_cfa4576.size] = var_7517594c.var_c29d189;
                            continue;
                        }
                        if (!isdefined(var_1b72f1aa.var_cfa4576)) {
                            var_1b72f1aa.var_cfa4576 = [];
                        } else if (!isarray(var_1b72f1aa.var_cfa4576)) {
                            var_1b72f1aa.var_cfa4576 = array(var_1b72f1aa.var_cfa4576);
                        }
                        var_1b72f1aa.var_cfa4576[var_1b72f1aa.var_cfa4576.size] = var_7517594c.modelvariant;
                    }
                }
                var_1b72f1aa.var_417ff571 = s_asset.var_f603705;
                var_1b72f1aa.var_e33b5953 = s_asset.model;
                var_1b72f1aa.str_fx_tag = s_asset.fxtag;
                var_1b72f1aa.var_d3c21d73 = (isdefined(s_asset.var_cb839fdc) ? s_asset.var_cb839fdc : 0, isdefined(s_asset.var_d7e738a3) ? s_asset.var_d7e738a3 : 0, isdefined(s_asset.var_e5a95427) ? s_asset.var_e5a95427 : 0);
                var_1b72f1aa.v_ang_offset = (isdefined(s_asset.var_5b038738) ? s_asset.var_5b038738 : 0, isdefined(s_asset.var_db060743) ? s_asset.var_db060743 : 0, isdefined(s_asset.var_ed4c2bcf) ? s_asset.var_ed4c2bcf : 0);
                var_1b72f1aa.var_867459dc = s_asset.attachmodel;
                var_1b72f1aa.var_31e8d962 = s_asset.var_e7723a7f;
                var_1b72f1aa.var_4ec51611 = (isdefined(s_asset.var_16da66bb) ? s_asset.var_16da66bb : 0, isdefined(s_asset.var_a8938a2f) ? s_asset.var_a8938a2f : 0, isdefined(s_asset.var_bb462f94) ? s_asset.var_bb462f94 : 0);
                var_1b72f1aa.var_4224ff2d = (isdefined(s_asset.var_45ebfe9b) ? s_asset.var_45ebfe9b : 0, isdefined(s_asset.var_e28537cb) ? s_asset.var_e28537cb : 0, isdefined(s_asset.var_b437db31) ? s_asset.var_b437db31 : 0);
                if (!isdefined(var_a0eafb23.var_e3cf25b2)) {
                    var_a0eafb23.var_e3cf25b2 = [];
                } else if (!isarray(var_a0eafb23.var_e3cf25b2)) {
                    var_a0eafb23.var_e3cf25b2 = array(var_a0eafb23.var_e3cf25b2);
                }
                if (!isinarray(var_a0eafb23.var_e3cf25b2, var_1b72f1aa)) {
                    var_a0eafb23.var_e3cf25b2[var_a0eafb23.var_e3cf25b2.size] = var_1b72f1aa;
                }
            }
            var_a0eafb23.var_d6cb6df6 = 0;
            if (is_true(var_a0eafb23.script_enable_on_start)) {
                level flag::set("<dev string:xc1>");
                level thread spawn_asset(var_a0eafb23);
            }
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xdfa2d17, Offset: 0x15a0
    // Size: 0x74a
    function function_1c40531e() {
        level flag::wait_till("<dev string:x469>");
        host = util::gethostplayer();
        level thread function_6559555e();
        host endon(#"disconnect");
        var_e0acd843 = 0;
        while (true) {
            if (level flag::get(#"menu_open")) {
                waitframe(1);
                continue;
            }
            if (!level.var_acfca739) {
                host val::reset("<dev string:x480>", "<dev string:x493>");
                host val::reset("<dev string:x480>", "<dev string:x4a1>");
                host val::reset("<dev string:x480>", "<dev string:x4bc>");
                waitframe(1);
                continue;
            }
            host val::set("<dev string:x480>", "<dev string:x4a1>", 1);
            host val::set("<dev string:x480>", "<dev string:x4bc>", 0);
            if (host fragbuttonpressed()) {
                var_334c38a9 = 1;
                var_e0acd843 = 0;
                host val::set("<dev string:x480>", "<dev string:x493>", 0);
            } else if (host adsbuttonpressed()) {
                var_e0acd843 = 1;
                var_334c38a9 = 0;
                host val::reset("<dev string:x480>", "<dev string:x493>");
            } else {
                var_e0acd843 = 0;
                var_334c38a9 = 0;
                host val::reset("<dev string:x480>", "<dev string:x493>");
            }
            if (host actionslotonebuttonpressed() && !host sprintbuttonpressed()) {
                if (var_334c38a9) {
                    host function_801766d7("<dev string:x4ca>");
                } else if (var_e0acd843) {
                    function_b9ad688b();
                } else {
                    function_e5720d25();
                }
                while (host actionslotonebuttonpressed()) {
                    if (var_e0acd843) {
                        function_3964f9d();
                    }
                    waitframe(1);
                }
            }
            if (host actionslotthreebuttonpressed() && !host sprintbuttonpressed()) {
                if (var_334c38a9) {
                    host function_801766d7("<dev string:x4d2>");
                } else if (var_e0acd843) {
                    endcamanimscripted(host);
                } else {
                    host cycle_model("<dev string:x4d2>");
                }
                while (host actionslotthreebuttonpressed()) {
                    waitframe(1);
                }
            }
            if (host actionslotfourbuttonpressed() && !host sprintbuttonpressed()) {
                if (var_334c38a9) {
                    host function_801766d7("<dev string:x4da>");
                } else if (var_e0acd843) {
                    level flag::toggle("<dev string:x4e3>");
                } else {
                    host cycle_model("<dev string:x4da>");
                }
                while (host actionslotfourbuttonpressed()) {
                    waitframe(1);
                }
            }
            if (host actionslottwobuttonpressed() && !host sprintbuttonpressed()) {
                if (var_334c38a9) {
                    function_2ccbc3d6();
                    host function_801766d7("<dev string:x501>");
                } else if (var_e0acd843) {
                    foreach (s_instance in level.var_2fb0636f) {
                        if (isdefined(s_instance.var_906f7138) && isdefined(s_instance.e_rotator) && !is_true(s_instance.var_906f7138.var_769f97fc)) {
                            s_instance.var_906f7138 unlink();
                            s_instance.var_906f7138 function_5fcc703c();
                            s_instance.var_906f7138 linkto(s_instance.e_rotator);
                        }
                    }
                } else {
                    level flag::toggle("<dev string:x50a>");
                }
                while (host actionslottwobuttonpressed()) {
                    if (var_334c38a9) {
                        function_c7030deb();
                    }
                    waitframe(1);
                }
            }
            if (host secondaryoffhandbuttonpressed()) {
                if (var_e0acd843) {
                } else {
                    level flag::toggle("<dev string:x527>");
                }
                while (host secondaryoffhandbuttonpressed()) {
                    waitframe(1);
                }
            }
            if (host jumpbuttonpressed()) {
                while (host jumpbuttonpressed()) {
                    waitframe(1);
                }
            }
            waitframe(1);
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x79df31a7, Offset: 0x1cf8
    // Size: 0x1dc
    function function_d6a44f15(str_instance) {
        if (str_instance === "<dev string:x66>") {
            return;
        }
        s_instance = level.var_2fb0636f[str_instance];
        function_86086836(s_instance);
        host = getplayers()[0];
        v_forward = anglestoforward(host getplayerangles());
        v_forward = vectorscale(v_forward, 4000);
        var_5927a215 = (10, 10, 10);
        v_eye = host getplayercamerapos();
        var_abd03397 = physicstrace(v_eye, v_eye + v_forward, -1 * var_5927a215, var_5927a215, getplayers()[0], 64 | 2);
        v_origin = var_abd03397[#"position"];
        if (isdefined(s_instance.var_ef831719)) {
            s_instance.var_ef831719 delete();
        }
        s_instance.var_ef831719 = util::spawn_model("<dev string:x548>", v_origin);
        s_instance.e_rotator.origin = v_origin;
        s_instance.e_rotator linkto(s_instance.var_ef831719);
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xa3122823, Offset: 0x1ee0
    // Size: 0x1c4
    function function_e099a386(str_instance) {
        if (str_instance === "<dev string:x66>") {
            return;
        }
        s_instance = level.var_2fb0636f[str_instance];
        function_86086836(s_instance);
        host = getplayers()[0];
        v_forward = anglestoforward(host getplayerangles());
        v_forward = vectorscale(v_forward, 125);
        v_player_origin = host getorigin();
        v_origin = v_player_origin + v_forward;
        if (isdefined(s_instance.var_ef831719)) {
            s_instance.var_ef831719 delete();
        }
        s_instance.var_ef831719 = util::spawn_model("<dev string:x548>", v_origin);
        s_instance.var_ef831719.var_14e5bc7e = 1;
        s_instance.e_rotator.origin = s_instance.var_ef831719.origin;
        s_instance.e_rotator linkto(s_instance.var_ef831719);
        s_instance.var_ef831719 linkto(host);
        s_instance.var_ef831719 thread function_e742c352();
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xee31e11e, Offset: 0x20b0
    // Size: 0x13e
    function function_e742c352() {
        host = getplayers()[0];
        host endon(#"death");
        self endon(#"death");
        while (true) {
            var_74aaeccd = host getnormalizedmovement();
            var_3e6ac197 = host getnormalizedcameramovement();
            if (level.var_acfca739 && host adsbuttonpressed() && var_3e6ac197 != (0, 0, 0)) {
                self unlink();
                self.origin = (self.origin[0], self.origin[1], self.origin[2] + var_3e6ac197[0] * 3);
                self linkto(host);
            }
            waitframe(1);
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x1598340, Offset: 0x21f8
    // Size: 0xbe
    function function_5f0fa6bb(str_instance) {
        if (str_instance === "<dev string:x66>") {
            return;
        }
        s_instance = level.var_2fb0636f[str_instance];
        function_86086836(s_instance);
        host = getplayers()[0];
        if (isdefined(s_instance.var_ef831719)) {
            s_instance.var_ef831719 delete();
        }
        s_instance.e_rotator.origin = s_instance.origin;
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x1338ef6e, Offset: 0x22c0
    // Size: 0xdc
    function function_756c5bf4(s_instance) {
        if (!isarray(s_instance.var_c2e8ace2) || !s_instance.var_c2e8ace2.size) {
            return 1;
        }
        foreach (var_cce981c8 in s_instance.var_c2e8ace2) {
            if (self istouching(var_cce981c8)) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xd42b5553, Offset: 0x23a8
    // Size: 0x3c
    function function_37ee741(s_instance) {
        str_asset = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_name;
        return str_asset;
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x9c1d8e88, Offset: 0x23f0
    // Size: 0x3c
    function function_fb7f89f1(s_instance) {
        str_type = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_type;
        return str_type;
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xc93d0a05, Offset: 0x2438
    // Size: 0xc8
    function function_9e86911f(s_instance) {
        var_30bd5f98 = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98;
        if (isarray(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_ab3948d3) && isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_ab3948d3[var_30bd5f98].animation)) {
            str_anim = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_ab3948d3[var_30bd5f98].animation;
        }
        return str_anim;
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x9e2c10f7, Offset: 0x2508
    // Size: 0x2ec
    function function_637cc13b(s_instance) {
        var_30bd5f98 = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98;
        if (isdefined(s_instance.var_906f7138.var_546c3278)) {
            s_instance.var_906f7138.var_546c3278 delete();
        }
        if (isarray(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_ab3948d3) && isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_ab3948d3[var_30bd5f98].var_867459dc)) {
            s_anim = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_ab3948d3[var_30bd5f98];
            var_867459dc = s_anim.var_867459dc;
            str_tag = isdefined(s_anim.var_31e8d962) ? s_anim.var_31e8d962 : "<dev string:x548>";
            s_instance.var_906f7138.var_546c3278 = util::spawn_model(var_867459dc, s_instance.var_906f7138.origin, s_instance.var_906f7138.angles);
            s_instance.var_906f7138.var_546c3278 linkto(s_instance.var_906f7138, str_tag, s_anim.var_4ec51611, s_anim.var_4224ff2d);
            return;
        }
        if (isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_867459dc)) {
            var_867459dc = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_867459dc;
            str_tag = isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_31e8d962) ? s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_31e8d962 : "<dev string:x548>";
            s_instance.var_906f7138.var_546c3278 = util::spawn_model(var_867459dc, s_instance.var_906f7138.origin, s_instance.var_906f7138.angles);
            s_instance.var_906f7138.var_546c3278 linkto(s_instance.var_906f7138, str_tag, s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_4ec51611, s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_4224ff2d);
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xa0a1fe84, Offset: 0x2800
    // Size: 0x3a2
    function function_801766d7(str_option) {
        if (!isdefined(str_option)) {
            str_option = "<dev string:x4da>";
        }
        foreach (s_instance in level.var_2fb0636f) {
            if (!self function_756c5bf4(s_instance) || !isarray(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_ab3948d3)) {
                continue;
            }
            if (str_option == "<dev string:x4d2>") {
                if (!isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98)) {
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 = 1;
                }
                s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98--;
                if (s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 < 0) {
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_ab3948d3.size - 1;
                }
                s_instance.var_906f7138.var_734e9da0 = undefined;
            } else if (str_option == "<dev string:x4da>") {
                if (!isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98)) {
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 = -1;
                }
                s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98++;
                if (s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 > s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_ab3948d3.size - 1) {
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 = 0;
                }
                s_instance.var_906f7138.var_734e9da0 = undefined;
            }
            str_anim = function_9e86911f(s_instance);
            if (isdefined(str_anim)) {
                if (isdefined(s_instance.var_906f7138)) {
                    if (str_option == "<dev string:x501>") {
                        var_9b259ac1 = 1;
                    } else {
                        var_9b259ac1 = 0;
                    }
                    s_instance function_77a3cb81(str_anim, var_9b259ac1);
                }
                continue;
            }
            if (isdefined(s_instance.var_906f7138) && !is_true(s_instance.var_906f7138.var_769f97fc)) {
                s_instance.var_906f7138 animation::stop();
                s_instance.var_906f7138 linkto(s_instance.e_rotator);
                s_instance.var_906f7138.var_734e9da0 = undefined;
            }
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 2, eflags: 0x0
    // Checksum 0xe1a85749, Offset: 0x2bb0
    // Size: 0x1cc
    function function_77a3cb81(str_anim, var_2cc700ad) {
        if (!isdefined(var_2cc700ad)) {
            var_2cc700ad = 0;
        }
        function_637cc13b(self);
        if (var_2cc700ad) {
            if (is_true(self.var_906f7138.var_734e9da0)) {
                n_start_time = self.var_906f7138 getanimtime(str_anim);
                self.var_906f7138 thread animation::play(str_anim, self.e_rotator, undefined, level.var_5a4e0f2e, 0.5, undefined, undefined, n_start_time, undefined, 0, undefined, undefined, "<dev string:x556>");
            }
            return;
        }
        if (is_true(self.var_906f7138.var_734e9da0)) {
            n_start_time = self.var_906f7138 getanimtime(str_anim);
            b_paused = 1;
            self.var_906f7138.var_734e9da0 = undefined;
        } else {
            n_start_time = self.var_906f7138 getanimtime(str_anim);
            b_paused = 0;
            self.var_906f7138.var_734e9da0 = 1;
        }
        self.var_906f7138 thread animation::play(str_anim, self.e_rotator, undefined, level.var_5a4e0f2e, 0.5, undefined, undefined, n_start_time, undefined, 0, undefined, b_paused, "<dev string:x556>");
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xa29f5026, Offset: 0x2d88
    // Size: 0x178
    function cycle_model(str_direction) {
        if (!isdefined(str_direction)) {
            str_direction = "<dev string:x4da>";
        }
        foreach (s_instance in level.var_2fb0636f) {
            if (!self function_756c5bf4(s_instance)) {
                continue;
            }
            if (str_direction == "<dev string:x4d2>") {
                if (!isdefined(s_instance.var_d6cb6df6)) {
                    s_instance.var_d6cb6df6 = 1;
                }
                s_instance.var_d6cb6df6--;
                if (s_instance.var_d6cb6df6 < 0) {
                    s_instance.var_d6cb6df6 = s_instance.var_e3cf25b2.size - 1;
                }
            } else {
                if (!isdefined(s_instance.var_d6cb6df6)) {
                    s_instance.var_d6cb6df6 = -1;
                }
                s_instance.var_d6cb6df6++;
                if (s_instance.var_d6cb6df6 > s_instance.var_e3cf25b2.size - 1) {
                    s_instance.var_d6cb6df6 = 0;
                }
            }
            spawn_asset(s_instance);
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xc6cd7c25, Offset: 0x2f08
    // Size: 0x114
    function function_86086836(s_instance) {
        level flag::set("<dev string:xc1>");
        if (!isdefined(s_instance.e_rotator)) {
            s_instance.e_rotator = util::spawn_model("<dev string:x548>", s_instance.origin, s_instance.angles);
        }
        if (!isdefined(s_instance.var_bfd82e27) && isdefined(s_instance.linkname)) {
            s_instance.var_bfd82e27 = util::spawn_model("<dev string:x548>", s_instance.origin, s_instance.angles);
            s_instance.var_af075c72 = getentarray(s_instance.linkname, "<dev string:x567>");
            array::run_all(s_instance.var_af075c72, &linkto, s_instance.var_bfd82e27);
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 2, eflags: 0x0
    // Checksum 0x671d6c14, Offset: 0x3028
    // Size: 0x85c
    function spawn_asset(s_instance, var_b9701a73) {
        level flag::wait_till("<dev string:x571>");
        function_86086836(s_instance);
        host = getplayers()[0];
        endcamanimscripted(host);
        if (isdefined(s_instance.var_906f7138.var_546c3278)) {
            s_instance.var_906f7138.var_546c3278 delete();
        }
        if (isdefined(s_instance.var_906f7138)) {
            s_instance.var_906f7138 delete();
        }
        var_9eb2d2aa = function_37ee741(s_instance);
        str_type = function_fb7f89f1(s_instance);
        v_pos = s_instance.e_rotator.origin + s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_d3c21d73;
        v_ang = s_instance.e_rotator.angles + s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].v_ang_offset;
        switch (str_type) {
        case #"playeroutfit":
            s_instance.var_906f7138 = function_ff217e96(isdefined(var_b9701a73) ? var_b9701a73 : var_9eb2d2aa, v_pos, v_ang);
            if (!isdefined(s_instance.var_906f7138)) {
                iprintlnbold("<dev string:x58a>" + function_9e72a96(isdefined(var_b9701a73) ? var_b9701a73 : var_9eb2d2aa) + "<dev string:x59c>");
                s_instance.var_906f7138 = util::spawn_anim_player_model("<dev string:x548>", v_pos, v_ang);
            }
            break;
        case #"vehicle":
            s_instance.var_906f7138 = spawnvehicle(var_9eb2d2aa, v_pos, v_ang);
            s_instance.var_906f7138 val::set("<dev string:x5db>", "<dev string:x5e7>", 1);
            s_instance.var_906f7138 val::set("<dev string:x5db>", "<dev string:x5f4>", 1);
            break;
        case #"aitype":
            s_instance.var_906f7138 = spawnactor(var_9eb2d2aa, v_pos, v_ang, undefined, 1);
            s_instance.var_906f7138 val::set("<dev string:x5db>", "<dev string:x5e7>", 1);
            s_instance.var_906f7138 val::set("<dev string:x5db>", "<dev string:x5f4>", 1);
            break;
        case #"character":
        case #"xmodel":
            if (is_true(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_417ff571)) {
                s_instance.var_906f7138 = util::spawn_anim_player_model(var_9eb2d2aa, v_pos, v_ang);
            } else {
                s_instance.var_906f7138 = util::spawn_anim_model(var_9eb2d2aa, v_pos, v_ang);
            }
            break;
        case #"fx":
            s_instance.var_906f7138 = util::spawn_model(isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_e33b5953) ? s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_e33b5953 : "<dev string:x548>", v_pos, v_ang);
            s_instance.var_906f7138 fx::play(var_9eb2d2aa, v_pos, v_ang, undefined, 1, isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_fx_tag) ? s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_fx_tag : "<dev string:x548>", 1);
            s_instance.var_906f7138.var_769f97fc = 1;
            break;
        default:
            /#
                iprintlnbold("<dev string:x600>");
            #/
            return;
        }
        s_instance.var_906f7138 linkto(s_instance.e_rotator);
        s_instance.e_rotator unlink();
        s_instance.e_rotator.angles = (s_instance.e_rotator.angles[0], s_instance.e_rotator.angles[1], 0);
        if (isdefined(s_instance.var_ef831719)) {
            s_instance.var_ef831719 unlink();
            s_instance.var_ef831719.angles = (s_instance.var_ef831719.angles[0], s_instance.var_ef831719.angles[1], 0);
            if (is_true(s_instance.var_ef831719.var_14e5bc7e)) {
                s_instance.e_rotator linkto(s_instance.var_ef831719);
                s_instance.var_ef831719 linkto(host);
            }
        }
        if (isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_867459dc)) {
            str_tag = isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_31e8d962) ? s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_31e8d962 : "<dev string:x548>";
            s_instance.var_906f7138.var_546c3278 = util::spawn_model(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_867459dc, s_instance.var_906f7138.origin, s_instance.var_906f7138.angles);
            s_instance.var_906f7138.var_546c3278 linkto(s_instance.var_906f7138, str_tag, s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_4ec51611, s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_4224ff2d);
        }
        if (isdefined(s_instance.script_string)) {
            if (isdefined(s_instance.script_label)) {
                s_align = struct::get(s_instance.script_label);
            } else {
                s_align = s_instance;
            }
            camanimscripted(getplayers()[0], s_instance.script_string, 0, s_align.origin, s_align.angles);
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 4, eflags: 0x0
    // Checksum 0xf1e783fb, Offset: 0x3890
    // Size: 0x2ae
    function function_ff217e96(var_5a86a1c2, v_pos, v_ang, s_instance) {
        level flag::wait_till("<dev string:x61d>");
        player = getplayers()[0];
        var_be7bc546 = currentsessionmode();
        var_123ebd30 = getallcharacterbodies(var_be7bc546);
        foreach (var_2074c3ff in var_123ebd30) {
            var_b744a7ed = function_d299ef16(var_2074c3ff, var_be7bc546);
            for (var_6e0e2531 = 0; var_6e0e2531 < var_b744a7ed; var_6e0e2531++) {
                var_322595c6 = function_d7c3cf6c(var_2074c3ff, var_6e0e2531, var_be7bc546);
                if (var_322595c6.namehash === var_5a86a1c2) {
                    var_c22fcaad = player getcharacterbodytype();
                    var_81cd46bd = player getcharacteroutfit();
                    player setcharacterbodytype(var_2074c3ff);
                    player setcharacteroutfit(var_6e0e2531);
                    var_412d5310 = player util::spawn_player_clone(player);
                    var_412d5310.origin = v_pos;
                    var_412d5310.angles = v_ang;
                    if (!is_true(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_417ff571)) {
                        var_412d5310 useanimtree("<dev string:x635>");
                    }
                    player setcharacterbodytype(var_c22fcaad);
                    player setcharacteroutfit(var_81cd46bd);
                    return var_412d5310;
                }
            }
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x97a9ac8f, Offset: 0x3b48
    // Size: 0x506
    function function_6559555e() {
        while (true) {
            /#
                if (level flag::get(#"menu_open") || !level.var_acfca739) {
                    waitframe(1);
                    continue;
                }
                if (level.var_59a2c772) {
                    if (getplayers()[0] fragbuttonpressed()) {
                        debug2dtext((50, 530, 0), "<dev string:x640>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0), "<dev string:x676>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 2, "<dev string:x69a>", undefined, undefined, undefined, 1, 0.8, 1);
                    } else if (getplayers()[0] adsbuttonpressed()) {
                        debug2dtext((50, 530, 0), "<dev string:x6c1>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0), "<dev string:x6db>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 2, "<dev string:x700>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 3, "<dev string:x72c>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 4, "<dev string:x75f>", undefined, undefined, undefined, 1, 0.8, 1);
                    } else {
                        debug2dtext((50, 530, 0), "<dev string:x779>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0), "<dev string:x79c>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 2, "<dev string:x7c0>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 3, "<dev string:x7ea>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 4, "<dev string:x805>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 5, "<dev string:x82b>", undefined, undefined, undefined, 1, 0.8, 1);
                    }
                    debug2dtext((640, 25, 0), "<dev string:x843>", undefined, undefined, undefined, 1, 0.8, 1);
                    function_c88700();
                }
            #/
            waitframe(1);
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xe5b0f4a7, Offset: 0x4058
    // Size: 0x130
    function function_b9ad688b() {
        level.var_402412cd -= 0.25;
        if (level.var_402412cd < 0.25) {
            level.var_402412cd = 1;
        }
        foreach (s_instance in level.var_2fb0636f) {
            if (isdefined(s_instance.var_906f7138)) {
                s_instance.var_906f7138 setscale(level.var_402412cd);
            }
            if (isdefined(s_instance.var_906f7138.var_546c3278)) {
                s_instance.var_906f7138.var_546c3278 setscale(level.var_402412cd);
            }
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x6b41f5b8, Offset: 0x4190
    // Size: 0x478
    function function_e5720d25() {
        foreach (s_instance in level.var_2fb0636f) {
            if (isarray(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_cfa4576) && s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_cfa4576.size > 0 && isdefined(s_instance.var_906f7138)) {
                if (isdefined(s_instance.var_906f7138.head) && s_instance.var_906f7138 isattached(s_instance.var_906f7138.head)) {
                    s_instance.var_906f7138 detach(s_instance.var_906f7138.head);
                }
                if (!isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_50f3b70e)) {
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_50f3b70e = 0;
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_67bb5365 = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_cfa4576[s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_50f3b70e];
                    var_67bb5365 = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_67bb5365;
                    if (s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_type === "<dev string:x459>") {
                        spawn_asset(s_instance, var_67bb5365);
                    } else {
                        s_instance.var_906f7138 setmodel(var_67bb5365);
                    }
                    continue;
                }
                s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_50f3b70e++;
                if (s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_50f3b70e >= s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_cfa4576.size) {
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_50f3b70e = -1;
                    if (s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_type === "<dev string:x459>") {
                        spawn_asset(s_instance, s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_name);
                    } else {
                        s_instance.var_906f7138 setmodel(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_name);
                    }
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_67bb5365 = undefined;
                    continue;
                }
                s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_67bb5365 = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_cfa4576[s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_50f3b70e];
                var_67bb5365 = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_67bb5365;
                if (isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_67bb5365)) {
                    if (s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_type === "<dev string:x459>") {
                        spawn_asset(s_instance, var_67bb5365);
                        continue;
                    }
                    s_instance.var_906f7138 setmodel(var_67bb5365);
                }
            }
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x547d9dce, Offset: 0x4610
    // Size: 0x84
    function function_2ccbc3d6() {
        if (level.var_5a4e0f2e == 1) {
            level.var_5a4e0f2e = 0.1;
            return;
        }
        if (level.var_5a4e0f2e == 0.5) {
            level.var_5a4e0f2e = 1;
            return;
        }
        if (level.var_5a4e0f2e == 0.1) {
            level.var_5a4e0f2e = 0.5;
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x6f9bc08e, Offset: 0x46a0
    // Size: 0x282
    function function_e01777dc(s_instance) {
        while (true) {
            if (level flag::get("<dev string:x50a>") || level flag::get("<dev string:x4e3>")) {
                foreach (s_instance in level.var_2fb0636f) {
                    function_86086836(s_instance);
                    var_5a15da23 = (s_instance.e_rotator.angles[0], s_instance.e_rotator.angles[1], s_instance.e_rotator.angles[2]);
                    if (level flag::get("<dev string:x8d8>")) {
                        var_5a15da23 = (var_5a15da23[0] + 3, var_5a15da23[1], var_5a15da23[2]);
                    }
                    if (level flag::get("<dev string:x50a>")) {
                        var_5a15da23 = (s_instance.e_rotator.angles[0], s_instance.e_rotator.angles[1] + 3, s_instance.e_rotator.angles[2]);
                    }
                    if (level flag::get("<dev string:x4e3>")) {
                        var_5a15da23 = (var_5a15da23[0], var_5a15da23[1], var_5a15da23[2] + 3);
                    }
                    var_5a15da23 = absangleclamp360(var_5a15da23);
                    s_instance.e_rotator rotateto(var_5a15da23, float(function_60d95f53()) / 1000);
                }
            }
            waitframe(1);
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xd4ed281e, Offset: 0x4930
    // Size: 0x102
    function function_fcde0f45(s_instance) {
        while (true) {
            if (level flag::get("<dev string:x527>")) {
                foreach (s_instance in level.var_2fb0636f) {
                    if (isdefined(s_instance.var_bfd82e27)) {
                        s_instance.var_bfd82e27 rotateyaw(3, float(function_60d95f53()) / 1000);
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xd3ee8f84, Offset: 0x4a40
    // Size: 0x5c
    function function_3964f9d() {
        if (level.var_59a2c772) {
            /#
                debug2dtext((700, 530, 0), "<dev string:x8f7>" + level.var_402412cd, undefined, undefined, undefined, 1, 1, 5);
            #/
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x9d15c919, Offset: 0x4aa8
    // Size: 0x64
    function function_c7030deb() {
        if (level.var_59a2c772) {
            /#
                debug2dtext((700, 530, 0), "<dev string:x912>" + level.var_5a4e0f2e + "<dev string:x92c>", undefined, undefined, undefined, 1, 1, 5);
            #/
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x70958240, Offset: 0x4b18
    // Size: 0x408
    function function_c88700() {
        if (level.var_59a2c772) {
            /#
                foreach (s_instance in level.var_2fb0636f) {
                    if (isdefined(s_instance.var_906f7138)) {
                        var_c954ac15 = "<dev string:x931>" + (isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_label) ? "<dev string:x66>" + s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_label : "<dev string:x66>") + "<dev string:x93b>" + s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_type + "<dev string:x946>" + function_9e72a96(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_name) + "<dev string:x951>" + s_instance.targetname;
                        if (is_true(s_instance.var_906f7138.var_734e9da0) && isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98) && isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_ab3948d3[s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98].var_867459dc)) {
                            var_c954ac15 = var_c954ac15 + "<dev string:x960>" + function_9e72a96(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_ab3948d3[s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98].var_867459dc);
                        } else if (isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_867459dc)) {
                            var_c954ac15 = var_c954ac15 + "<dev string:x978>" + function_9e72a96(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_867459dc);
                        }
                        if (isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_67bb5365)) {
                            if (s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_type === "<dev string:x459>") {
                                var_9e3d7699 = "<dev string:x996>";
                            } else {
                                var_9e3d7699 = "<dev string:x9a9>";
                            }
                            var_c954ac15 = var_c954ac15 + "<dev string:x9bb>" + var_9e3d7699 + s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_50f3b70e + 1 + "<dev string:x9c0>" + function_9e72a96(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_67bb5365);
                        }
                        if (level.host util::is_player_looking_at(s_instance.var_906f7138 getcentroid(), 0.9, 1, s_instance.var_906f7138)) {
                            print3d(s_instance.var_906f7138.origin + (15, 0, 20), var_c954ac15, (1, 1, 0), 1, 0.2);
                        }
                    }
                }
            #/
        }
    }

    // Namespace art_test/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xb8209883, Offset: 0x4f28
    // Size: 0xda
    function function_5fcc703c() {
        v_ground = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"];
        var_b8c346f = self getpointinbounds(0, 0, -1);
        n_z_diff = var_b8c346f[2] - v_ground[2];
        self.origin = (self.origin[0], self.origin[1], self.origin[2] - n_z_diff);
    }

#/
