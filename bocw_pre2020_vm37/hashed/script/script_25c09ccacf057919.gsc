#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace namespace_d9b7a459;

/#

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x6
    // Checksum 0xdaa9442b, Offset: 0xa8
    // Size: 0x4c
    function private autoexec __init__system__() {
        system::register(#"hash_5f4a915350d11e3b", &function_70a657d8, &postinit, undefined, undefined);
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x4
    // Checksum 0x889f18b1, Offset: 0x100
    // Size: 0x340
    function private function_70a657d8() {
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
        var_df014f39 = [];
        foreach (n_index, s_instance in level.var_2fb0636f) {
            str_name = isdefined(s_instance.targetname) ? s_instance.targetname : "<dev string:x6a>" + n_index;
            s_instance.targetname = str_name;
            var_df014f39[str_name] = s_instance;
        }
        level.var_2fb0636f = arraycopy(var_df014f39);
        var_91562d8c = struct::get_array("<dev string:x82>", "<dev string:x95>");
        level.var_4aca3c1 = [];
        foreach (n_index, var_d7eff26a in var_91562d8c) {
            str_name = isdefined(var_d7eff26a.targetname) ? var_d7eff26a.targetname : "<dev string:xa4>" + n_index;
            level.var_4aca3c1[str_name] = var_d7eff26a;
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x4
    // Checksum 0x12ddce9f, Offset: 0x448
    // Size: 0x5c
    function private postinit() {
        if (!level.var_2fb0636f.size) {
            return;
        }
        function_f29b39b1();
        level thread function_51acf127();
        level thread function_291b284f();
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xfb1c7058, Offset: 0x4b0
    // Size: 0x8c
    function function_291b284f() {
        level flag::wait_till("<dev string:xc1>");
        level.var_59a2c772 = 1;
        level.var_acfca739 = 1;
        level thread function_1c40531e();
        level thread function_e01777dc();
        level thread function_fcde0f45();
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xeed73f6d, Offset: 0x548
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

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x91735088, Offset: 0x948
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

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x6ae1b400, Offset: 0xb30
    // Size: 0xf0
    function function_cad382ca() {
        foreach (s_instance in level.var_2fb0636f) {
            if (isdefined(s_instance.var_906f7138)) {
                s_instance.var_906f7138 delete();
            }
            if (isdefined(s_instance.var_3f6461c1)) {
                s_instance.var_3f6461c1 delete();
            }
            if (isdefined(s_instance.var_ef831719)) {
                s_instance.var_ef831719 delete();
            }
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xcb2cb267, Offset: 0xc28
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

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x19db29b4, Offset: 0xcf8
    // Size: 0x4b8
    function function_f29b39b1() {
        foreach (var_a0eafb23 in level.var_2fb0636f) {
            if (isdefined(var_a0eafb23.targetname)) {
                var_a0eafb23.var_c2e8ace2 = getentarray(var_a0eafb23.targetname, "<dev string:x44f>");
            }
            var_a52f9ea8 = getscriptbundle(var_a0eafb23.scriptbundlename);
            foreach (var_58de05e9 in var_a52f9ea8.assetlist) {
                var_1b72f1aa = {#str_name:isdefined(var_58de05e9.var_8427fa8a) ? var_58de05e9.var_8427fa8a : var_58de05e9.model, #str_label:var_58de05e9.var_6e6d4eda, #str_type:var_58de05e9.assettype};
                if (isarray(var_58de05e9.var_7970f5e5)) {
                    foreach (s_anim in var_58de05e9.var_7970f5e5) {
                        if (!isdefined(var_1b72f1aa.var_c2edc777)) {
                            var_1b72f1aa.var_c2edc777 = [];
                        } else if (!isarray(var_1b72f1aa.var_c2edc777)) {
                            var_1b72f1aa.var_c2edc777 = array(var_1b72f1aa.var_c2edc777);
                        }
                        var_1b72f1aa.var_c2edc777[var_1b72f1aa.var_c2edc777.size] = s_anim.animation;
                    }
                }
                var_1b72f1aa.var_417ff571 = var_58de05e9.var_f603705;
                var_1b72f1aa.var_e33b5953 = var_58de05e9.model;
                var_1b72f1aa.str_fx_tag = var_58de05e9.fxtag;
                var_1b72f1aa.var_d3c21d73 = (isdefined(var_58de05e9.var_cb839fdc) ? var_58de05e9.var_cb839fdc : 0, isdefined(var_58de05e9.var_d7e738a3) ? var_58de05e9.var_d7e738a3 : 0, isdefined(var_58de05e9.var_e5a95427) ? var_58de05e9.var_e5a95427 : 0);
                var_1b72f1aa.v_ang_offset = (isdefined(var_58de05e9.var_5b038738) ? var_58de05e9.var_5b038738 : 0, isdefined(var_58de05e9.var_db060743) ? var_58de05e9.var_db060743 : 0, isdefined(var_58de05e9.var_ed4c2bcf) ? var_58de05e9.var_ed4c2bcf : 0);
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
                level thread function_765ece13(var_a0eafb23);
            }
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xbe23aac5, Offset: 0x11b8
    // Size: 0x73a
    function function_1c40531e() {
        level flag::wait_till("<dev string:x459>");
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
                host val::reset("<dev string:x470>", "<dev string:x483>");
                host val::reset("<dev string:x470>", "<dev string:x491>");
                host val::reset("<dev string:x470>", "<dev string:x4ac>");
                waitframe(1);
                continue;
            }
            host val::set("<dev string:x470>", "<dev string:x491>", 1);
            host val::set("<dev string:x470>", "<dev string:x4ac>", 0);
            if (host fragbuttonpressed()) {
                var_334c38a9 = 1;
                var_e0acd843 = 0;
                host val::set("<dev string:x470>", "<dev string:x483>", 0);
            } else if (host adsbuttonpressed()) {
                var_e0acd843 = 1;
                var_334c38a9 = 0;
                host val::reset("<dev string:x470>", "<dev string:x483>");
            } else {
                var_e0acd843 = 0;
                var_334c38a9 = 0;
                host val::reset("<dev string:x470>", "<dev string:x483>");
            }
            if (host actionslotonebuttonpressed() && !host sprintbuttonpressed()) {
                if (var_334c38a9) {
                    host function_801766d7("<dev string:x4ba>");
                } else if (var_e0acd843) {
                } else {
                    function_b9ad688b();
                }
                while (host actionslotonebuttonpressed()) {
                    if (!var_334c38a9 && !var_e0acd843) {
                        function_3964f9d();
                    }
                    waitframe(1);
                }
            }
            if (host actionslotthreebuttonpressed() && !host sprintbuttonpressed()) {
                if (var_334c38a9) {
                    host function_801766d7("<dev string:x4c2>");
                } else if (var_e0acd843) {
                    endcamanimscripted(host);
                } else {
                    host function_c9fccb3d("<dev string:x4c2>");
                }
                while (host actionslotthreebuttonpressed()) {
                    waitframe(1);
                }
            }
            if (host actionslotfourbuttonpressed() && !host sprintbuttonpressed()) {
                if (var_334c38a9) {
                    host function_801766d7("<dev string:x4ca>");
                } else if (var_e0acd843) {
                    level flag::toggle("<dev string:x4d3>");
                } else {
                    host function_c9fccb3d("<dev string:x4ca>");
                }
                while (host actionslotfourbuttonpressed()) {
                    waitframe(1);
                }
            }
            if (host actionslottwobuttonpressed() && !host sprintbuttonpressed()) {
                if (var_334c38a9) {
                    function_2ccbc3d6();
                    host function_801766d7("<dev string:x4f1>");
                } else if (var_e0acd843) {
                    foreach (s_instance in level.var_2fb0636f) {
                        if (isdefined(s_instance.var_906f7138) && isdefined(s_instance.var_3f6461c1) && !is_true(s_instance.var_906f7138.var_769f97fc)) {
                            s_instance.var_906f7138 unlink();
                            s_instance.var_906f7138 function_5fcc703c();
                            s_instance.var_906f7138 linkto(s_instance.var_3f6461c1);
                        }
                    }
                } else {
                    level flag::toggle("<dev string:x4fa>");
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
                    level flag::toggle("<dev string:x517>");
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

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xfe888c5b, Offset: 0x1900
    // Size: 0x1dc
    function function_d6a44f15(var_1e2181c9) {
        if (var_1e2181c9 === "<dev string:x66>") {
            return;
        }
        s_instance = level.var_2fb0636f[var_1e2181c9];
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
        s_instance.var_ef831719 = util::spawn_model("<dev string:x538>", v_origin);
        s_instance.var_3f6461c1.origin = v_origin;
        s_instance.var_3f6461c1 linkto(s_instance.var_ef831719);
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x2a51654a, Offset: 0x1ae8
    // Size: 0x1c4
    function function_e099a386(var_1e2181c9) {
        if (var_1e2181c9 === "<dev string:x66>") {
            return;
        }
        s_instance = level.var_2fb0636f[var_1e2181c9];
        function_86086836(s_instance);
        host = getplayers()[0];
        v_forward = anglestoforward(host getplayerangles());
        v_forward = vectorscale(v_forward, 125);
        v_player_origin = host getorigin();
        v_origin = v_player_origin + v_forward;
        if (isdefined(s_instance.var_ef831719)) {
            s_instance.var_ef831719 delete();
        }
        s_instance.var_ef831719 = util::spawn_model("<dev string:x538>", v_origin);
        s_instance.var_ef831719.var_14e5bc7e = 1;
        s_instance.var_3f6461c1.origin = s_instance.var_ef831719.origin;
        s_instance.var_3f6461c1 linkto(s_instance.var_ef831719);
        s_instance.var_ef831719 linkto(host);
        s_instance.var_ef831719 thread function_e742c352();
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xdabaed4e, Offset: 0x1cb8
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

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x56797cff, Offset: 0x1e00
    // Size: 0xbe
    function function_5f0fa6bb(var_1e2181c9) {
        if (var_1e2181c9 === "<dev string:x66>") {
            return;
        }
        s_instance = level.var_2fb0636f[var_1e2181c9];
        function_86086836(s_instance);
        host = getplayers()[0];
        if (isdefined(s_instance.var_ef831719)) {
            s_instance.var_ef831719 delete();
        }
        s_instance.var_3f6461c1.origin = s_instance.origin;
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x7f684270, Offset: 0x1ec8
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

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xbcc7d440, Offset: 0x1fb0
    // Size: 0x3c
    function function_37ee741(s_instance) {
        var_618821b1 = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_name;
        return var_618821b1;
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x2610d665, Offset: 0x1ff8
    // Size: 0x3c
    function function_fb7f89f1(s_instance) {
        str_type = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_type;
        return str_type;
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x8c868a96, Offset: 0x2040
    // Size: 0xba
    function function_9e86911f(s_instance) {
        var_30bd5f98 = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98;
        if (isarray(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_c2edc777) && isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_c2edc777[var_30bd5f98])) {
            str_anim = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_c2edc777[var_30bd5f98];
        }
        return str_anim;
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x371a7e65, Offset: 0x2108
    // Size: 0x3a2
    function function_801766d7(var_ec8eb4fa) {
        if (!isdefined(var_ec8eb4fa)) {
            var_ec8eb4fa = "<dev string:x4ca>";
        }
        foreach (s_instance in level.var_2fb0636f) {
            if (!self function_756c5bf4(s_instance) || !isarray(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_c2edc777)) {
                continue;
            }
            if (var_ec8eb4fa == "<dev string:x4c2>") {
                if (!isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98)) {
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 = 1;
                }
                s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98--;
                if (s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 < 0) {
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 = s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_c2edc777.size - 1;
                }
                s_instance.var_906f7138.var_734e9da0 = undefined;
            } else if (var_ec8eb4fa == "<dev string:x4ca>") {
                if (!isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98)) {
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 = -1;
                }
                s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98++;
                if (s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 > s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_c2edc777.size - 1) {
                    s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_30bd5f98 = 0;
                }
                s_instance.var_906f7138.var_734e9da0 = undefined;
            }
            str_anim = function_9e86911f(s_instance);
            if (isdefined(str_anim)) {
                if (isdefined(s_instance.var_906f7138)) {
                    if (var_ec8eb4fa == "<dev string:x4f1>") {
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
                s_instance.var_906f7138 linkto(s_instance.var_3f6461c1);
                s_instance.var_906f7138.var_734e9da0 = undefined;
            }
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 2, eflags: 0x0
    // Checksum 0x69390150, Offset: 0x24b8
    // Size: 0x1b4
    function function_77a3cb81(str_anim, var_2cc700ad) {
        if (!isdefined(var_2cc700ad)) {
            var_2cc700ad = 0;
        }
        if (var_2cc700ad) {
            if (is_true(self.var_906f7138.var_734e9da0)) {
                n_start_time = self.var_906f7138 getanimtime(str_anim);
                self.var_906f7138 thread animation::play(str_anim, self.var_3f6461c1, undefined, level.var_5a4e0f2e, 0.5, undefined, undefined, n_start_time, undefined, 0, undefined, undefined, "<dev string:x546>");
            }
            return;
        }
        if (is_true(self.var_906f7138.var_734e9da0)) {
            n_start_time = self.var_906f7138 getanimtime(str_anim);
            var_e8c75d3a = 1;
            self.var_906f7138.var_734e9da0 = undefined;
        } else {
            n_start_time = self.var_906f7138 getanimtime(str_anim);
            var_e8c75d3a = 0;
            self.var_906f7138.var_734e9da0 = 1;
        }
        self.var_906f7138 thread animation::play(str_anim, self.var_3f6461c1, undefined, level.var_5a4e0f2e, 0.5, undefined, undefined, n_start_time, undefined, 0, undefined, var_e8c75d3a, "<dev string:x546>");
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xcd9696cd, Offset: 0x2678
    // Size: 0x178
    function function_c9fccb3d(str_direction) {
        if (!isdefined(str_direction)) {
            str_direction = "<dev string:x4ca>";
        }
        foreach (s_instance in level.var_2fb0636f) {
            if (!self function_756c5bf4(s_instance)) {
                continue;
            }
            if (str_direction == "<dev string:x4c2>") {
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
            function_765ece13(s_instance);
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x8495a82b, Offset: 0x27f8
    // Size: 0x114
    function function_86086836(s_instance) {
        level flag::set("<dev string:xc1>");
        if (!isdefined(s_instance.var_3f6461c1)) {
            s_instance.var_3f6461c1 = util::spawn_model("<dev string:x538>", s_instance.origin, s_instance.angles);
        }
        if (!isdefined(s_instance.var_bfd82e27) && isdefined(s_instance.linkname)) {
            s_instance.var_bfd82e27 = util::spawn_model("<dev string:x538>", s_instance.origin, s_instance.angles);
            s_instance.var_af075c72 = getentarray(s_instance.linkname, "<dev string:x557>");
            array::run_all(s_instance.var_af075c72, &linkto, s_instance.var_bfd82e27);
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x723d3bd0, Offset: 0x2918
    // Size: 0x624
    function function_765ece13(s_instance) {
        level flag::wait_till("<dev string:x561>");
        function_86086836(s_instance);
        host = getplayers()[0];
        endcamanimscripted(host);
        if (isdefined(s_instance.var_906f7138)) {
            s_instance.var_906f7138 delete();
        }
        var_9eb2d2aa = function_37ee741(s_instance);
        str_type = function_fb7f89f1(s_instance);
        v_pos = s_instance.var_3f6461c1.origin + s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_d3c21d73;
        v_ang = s_instance.var_3f6461c1.angles + s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].v_ang_offset;
        switch (str_type) {
        case #"vehicle":
            s_instance.var_906f7138 = spawnvehicle(var_9eb2d2aa, v_pos, v_ang);
            s_instance.var_906f7138 val::set("<dev string:x57a>", "<dev string:x586>", 1);
            s_instance.var_906f7138 val::set("<dev string:x57a>", "<dev string:x593>", 1);
            break;
        case #"aitype":
            s_instance.var_906f7138 = spawnactor(var_9eb2d2aa, v_pos, v_ang, undefined, 1);
            s_instance.var_906f7138 val::set("<dev string:x57a>", "<dev string:x586>", 1);
            s_instance.var_906f7138 val::set("<dev string:x57a>", "<dev string:x593>", 1);
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
            s_instance.var_906f7138 = util::spawn_model(isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_e33b5953) ? s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].var_e33b5953 : "<dev string:x538>", v_pos, v_ang);
            s_instance.var_906f7138 fx::play(var_9eb2d2aa, v_pos, v_ang, undefined, 1, isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_fx_tag) ? s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_fx_tag : "<dev string:x538>", 1);
            s_instance.var_906f7138.var_769f97fc = 1;
            break;
        default:
            /#
                iprintlnbold("<dev string:x59f>");
            #/
            return;
        }
        s_instance.var_906f7138 linkto(s_instance.var_3f6461c1);
        s_instance.var_3f6461c1 unlink();
        s_instance.var_3f6461c1.angles = (s_instance.var_3f6461c1.angles[0], s_instance.var_3f6461c1.angles[1], 0);
        if (isdefined(s_instance.var_ef831719)) {
            s_instance.var_ef831719 unlink();
            s_instance.var_ef831719.angles = (s_instance.var_ef831719.angles[0], s_instance.var_ef831719.angles[1], 0);
            if (is_true(s_instance.var_ef831719.var_14e5bc7e)) {
                s_instance.var_3f6461c1 linkto(s_instance.var_ef831719);
                s_instance.var_ef831719 linkto(host);
            }
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

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x1280c81e, Offset: 0x2f48
    // Size: 0x4b6
    function function_6559555e() {
        while (true) {
            /#
                if (level flag::get(#"menu_open") || !level.var_acfca739) {
                    waitframe(1);
                    continue;
                }
                if (level.var_59a2c772) {
                    if (getplayers()[0] fragbuttonpressed()) {
                        debug2dtext((50, 530, 0), "<dev string:x5bc>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0), "<dev string:x5f2>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 2, "<dev string:x616>", undefined, undefined, undefined, 1, 0.8, 1);
                    } else if (getplayers()[0] adsbuttonpressed()) {
                        debug2dtext((50, 530, 0), "<dev string:x63d>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0), "<dev string:x657>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 2, "<dev string:x67c>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 3, "<dev string:x6a8>", undefined, undefined, undefined, 1, 0.8, 1);
                    } else {
                        debug2dtext((50, 530, 0), "<dev string:x6db>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0), "<dev string:x6fe>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 2, "<dev string:x719>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 3, "<dev string:x743>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 4, "<dev string:x75e>", undefined, undefined, undefined, 1, 0.8, 1);
                        debug2dtext((50, 530, 0) + (0, 20, 0) * 5, "<dev string:x784>", undefined, undefined, undefined, 1, 0.8, 1);
                    }
                    debug2dtext((640, 25, 0), "<dev string:x79c>", undefined, undefined, undefined, 1, 0.8, 1);
                    function_c88700();
                }
            #/
            waitframe(1);
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x84d2885, Offset: 0x3408
    // Size: 0xf0
    function function_b9ad688b() {
        level.var_402412cd -= 0.25;
        if (level.var_402412cd < 0.25) {
            level.var_402412cd = 1;
        }
        foreach (s_instance in level.var_2fb0636f) {
            if (isdefined(s_instance.var_906f7138)) {
                s_instance.var_906f7138 setscale(level.var_402412cd);
            }
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x98a23cf4, Offset: 0x3500
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

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0x9f904852, Offset: 0x3590
    // Size: 0x282
    function function_e01777dc(s_instance) {
        while (true) {
            if (level flag::get("<dev string:x4fa>") || level flag::get("<dev string:x4d3>")) {
                foreach (s_instance in level.var_2fb0636f) {
                    function_86086836(s_instance);
                    var_5a15da23 = (s_instance.var_3f6461c1.angles[0], s_instance.var_3f6461c1.angles[1], s_instance.var_3f6461c1.angles[2]);
                    if (level flag::get("<dev string:x831>")) {
                        var_5a15da23 = (var_5a15da23[0] + 3, var_5a15da23[1], var_5a15da23[2]);
                    }
                    if (level flag::get("<dev string:x4fa>")) {
                        var_5a15da23 = (s_instance.var_3f6461c1.angles[0], s_instance.var_3f6461c1.angles[1] + 3, s_instance.var_3f6461c1.angles[2]);
                    }
                    if (level flag::get("<dev string:x4d3>")) {
                        var_5a15da23 = (var_5a15da23[0], var_5a15da23[1], var_5a15da23[2] + 3);
                    }
                    var_5a15da23 = absangleclamp360(var_5a15da23);
                    s_instance.var_3f6461c1 rotateto(var_5a15da23, float(function_60d95f53()) / 1000);
                }
            }
            waitframe(1);
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 1, eflags: 0x0
    // Checksum 0xaed1156e, Offset: 0x3820
    // Size: 0x102
    function function_fcde0f45(s_instance) {
        while (true) {
            if (level flag::get("<dev string:x517>")) {
                foreach (s_instance in level.var_2fb0636f) {
                    if (isdefined(s_instance.var_bfd82e27)) {
                        s_instance.var_bfd82e27 rotateyaw(3, float(function_60d95f53()) / 1000);
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x853f0e0a, Offset: 0x3930
    // Size: 0x5c
    function function_3964f9d() {
        if (level.var_59a2c772) {
            /#
                debug2dtext((700, 530, 0), "<dev string:x850>" + level.var_402412cd, undefined, undefined, undefined, 1, 1, 5);
            #/
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x72caed96, Offset: 0x3998
    // Size: 0x64
    function function_c7030deb() {
        if (level.var_59a2c772) {
            /#
                debug2dtext((700, 530, 0), "<dev string:x86b>" + level.var_5a4e0f2e + "<dev string:x885>", undefined, undefined, undefined, 1, 1, 5);
            #/
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0xa1353bc2, Offset: 0x3a08
    // Size: 0x1f0
    function function_c88700() {
        if (level.var_59a2c772) {
            /#
                foreach (s_instance in level.var_2fb0636f) {
                    if (isdefined(s_instance.var_906f7138)) {
                        var_c954ac15 = "<dev string:x88a>" + (isdefined(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_label) ? "<dev string:x66>" + s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_label : "<dev string:x66>") + "<dev string:x894>" + s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_type + "<dev string:x89f>" + function_9e72a96(s_instance.var_e3cf25b2[s_instance.var_d6cb6df6].str_name) + "<dev string:x8aa>" + s_instance.targetname;
                        if (level.host util::is_player_looking_at(s_instance.var_906f7138 getcentroid(), 0.9, 1, s_instance.var_906f7138)) {
                            print3d(s_instance.var_906f7138.origin + (15, 0, 20), var_c954ac15, (1, 1, 0), 1, 0.2);
                        }
                    }
                }
            #/
        }
    }

    // Namespace namespace_d9b7a459/namespace_3c79982f
    // Params 0, eflags: 0x0
    // Checksum 0x71ea6c81, Offset: 0x3c00
    // Size: 0xda
    function function_5fcc703c() {
        v_ground = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"];
        var_b8c346f = self getpointinbounds(0, 0, -1);
        n_z_diff = var_b8c346f[2] - v_ground[2];
        self.origin = (self.origin[0], self.origin[1], self.origin[2] - n_z_diff);
    }

#/
