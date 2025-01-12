#using scripts\core_common\array_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace scene;

/#

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x2
    // Checksum 0x3e13848, Offset: 0x98
    // Size: 0x3c
    function autoexec __init__system__() {
        system::register(#"scene_debug", &function_60a7c0fb, undefined, undefined);
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1828492e, Offset: 0xe0
    // Size: 0x9c
    function function_60a7c0fb() {
        if (getdvarstring(#"scene_menu_mode", "<dev string:x30>") == "<dev string:x30>") {
            setdvar(#"scene_menu_mode", "<dev string:x31>");
        }
        level thread run_scene_tests();
        level thread toggle_scene_menu();
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xdec75aa6, Offset: 0x188
    // Size: 0x4fe
    function run_scene_tests() {
        level endon(#"run_scene_tests");
        level.scene_test_struct = spawnstruct();
        level.scene_test_struct.origin = (0, 0, 0);
        level.scene_test_struct.angles = (0, 0, 0);
        while (true) {
            str_scene = getdvarstring(#"run_client_scene");
            str_mode = tolower(getdvarstring(#"scene_menu_mode", "<dev string:x31>"));
            a_toks = strtok(str_scene, "<dev string:x39>");
            str_scene = a_toks[0];
            str_shot = a_toks[1];
            if (!isdefined(str_scene)) {
                str_scene = "<dev string:x30>";
            }
            if (str_scene != "<dev string:x30>") {
                setdvar(#"run_client_scene", "<dev string:x30>");
                clear_old_ents(str_scene);
                b_found = 0;
                a_scenes = struct::get_array(str_scene, "<dev string:x3b>");
                foreach (s_instance in a_scenes) {
                    if (isdefined(s_instance)) {
                        b_found = 1;
                        s_instance thread test_play(undefined, str_shot, str_mode);
                    }
                }
                if (isdefined(level.active_scenes[str_scene])) {
                    foreach (s_instance in level.active_scenes[str_scene]) {
                        if (!isinarray(a_scenes, s_instance)) {
                            b_found = 1;
                            s_instance thread test_play(str_scene, str_shot, str_mode);
                        }
                    }
                }
                if (!b_found) {
                    level.scene_test_struct thread test_play(str_scene, str_shot, str_mode);
                }
            }
            str_scene = getdvarstring(#"init_client_scene");
            if (str_scene != "<dev string:x30>") {
                setdvar(#"init_client_scene", "<dev string:x30>");
                clear_old_ents(str_scene);
                b_found = 0;
                a_scenes = struct::get_array(str_scene, "<dev string:x3b>");
                foreach (s_instance in a_scenes) {
                    if (isdefined(s_instance)) {
                        b_found = 1;
                        s_instance thread test_init();
                    }
                }
                if (!b_found) {
                    level.scene_test_struct thread test_init(str_scene);
                }
            }
            str_scene = getdvarstring(#"stop_client_scene");
            if (str_scene != "<dev string:x30>") {
                setdvar(#"stop_client_scene", "<dev string:x30>");
                function_83ef29c9(level.var_65499128);
                level stop(str_scene, 1);
            }
            waitframe(1);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x40f3336a, Offset: 0x690
    // Size: 0xb8
    function clear_old_ents(str_scene) {
        foreach (ent in getentarray(0)) {
            if (ent.scene_spawned === str_scene && ent.finished_scene === str_scene) {
                ent delete();
            }
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4586c5c5, Offset: 0x750
    // Size: 0x1f4
    function toggle_scene_menu() {
        setdvar(#"client_scene_menu", 0);
        n_scene_menu_last = -1;
        while (true) {
            n_scene_menu = getdvarstring(#"client_scene_menu");
            if (n_scene_menu != "<dev string:x30>") {
                n_scene_menu = int(n_scene_menu);
                if (n_scene_menu != n_scene_menu_last) {
                    switch (n_scene_menu) {
                    case 1:
                        level thread display_scene_menu("<dev string:x4c>");
                        break;
                    case 2:
                        level thread display_scene_menu("<dev string:x52>");
                        break;
                    default:
                        level flagsys::clear(#"menu_open");
                        level flagsys::clear(#"hash_4035a6aa4a6ba08d");
                        level flagsys::clear(#"hash_7b50fddf7a4b9e2e");
                        level flagsys::clear(#"hash_5bcd66a9c21f5b2d");
                        level notify(#"scene_menu_cleanup");
                        setdvar(#"cl_tacticalhud", 1);
                        break;
                    }
                    n_scene_menu_last = n_scene_menu;
                }
            }
            waitframe(1);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x72a94add, Offset: 0x950
    // Size: 0xdc
    function function_6435e76d(o_scene) {
        if (isdefined(o_scene) && isdefined(o_scene._s)) {
            str_type = isdefined(o_scene._s.scenetype) ? o_scene._s.scenetype : "<dev string:x4c>";
            if (level flagsys::get(str_type + "<dev string:x59>") && level flagsys::get(#"hash_5bcd66a9c21f5b2d")) {
                level thread display_scene_menu(o_scene._s.scenetype);
            }
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 2, eflags: 0x0
    // Checksum 0xe83942d8, Offset: 0xa38
    // Size: 0xd26
    function display_scene_menu(str_type, str_scene) {
        if (!isdefined(str_type)) {
            str_type = "<dev string:x4c>";
        }
        level flagsys::clear(#"hash_4035a6aa4a6ba08d");
        level flagsys::clear(#"hash_7b50fddf7a4b9e2e");
        level notify(#"scene_menu_cleanup");
        level endon(#"scene_menu_cleanup");
        waittillframeend();
        level flagsys::set(#"menu_open");
        setdvar(#"cl_tacticalhud", 0);
        b_shot_menu = 0;
        a_scenedefs = get_scenedefs(str_type);
        if (str_type == "<dev string:x4c>") {
            a_scenedefs = arraycombine(a_scenedefs, get_scenedefs("<dev string:x6b>"), 0, 1);
        }
        names = [];
        if (isstring(str_scene)) {
            names[names.size] = "<dev string:x75>";
            names[names.size] = "<dev string:x7a>";
            names[names.size] = "<dev string:x30>";
            names = arraycombine(names, get_all_shot_names(str_scene), 1, 0);
            names[names.size] = "<dev string:x30>";
            names[names.size] = "<dev string:x7f>";
            names[names.size] = "<dev string:x30>";
            names[names.size] = "<dev string:x84>";
            str_title = str_scene;
            b_shot_menu = 1;
            selected = isdefined(level.scene_menu_shot_index) ? level.scene_menu_shot_index : 0;
        } else {
            level flagsys::set(str_type + "<dev string:x59>");
            names[0] = "<dev string:x89>";
            names[1] = "<dev string:x30>";
            if (level flagsys::get(#"hash_5bcd66a9c21f5b2d")) {
                println("<dev string:xa8>" + toupper(str_type) + "<dev string:xba>");
            }
            var_7431670 = 1;
            foreach (s_scenedef in a_scenedefs) {
                if (s_scenedef.vmtype === "<dev string:xc9>" && s_scenedef.scenetype === str_type) {
                    if (level flagsys::get(#"hash_5bcd66a9c21f5b2d")) {
                        if (is_active(s_scenedef.name) && function_9685c117(s_scenedef)) {
                            array::add_sorted(names, s_scenedef.name, 0);
                            println("<dev string:xd0>" + toupper(str_type) + "<dev string:xe2>" + var_7431670 + "<dev string:xe4>" + s_scenedef.name);
                            var_7431670++;
                        }
                        continue;
                    }
                    if (function_9685c117(s_scenedef)) {
                        array::add_sorted(names, s_scenedef.name, 0);
                    }
                }
            }
            if (level flagsys::get(#"hash_5bcd66a9c21f5b2d")) {
                println("<dev string:xa8>" + toupper(str_type) + "<dev string:xeb>");
            }
            names[names.size] = "<dev string:xf8>";
            str_title = str_type + "<dev string:xfd>";
        }
        selected = 0;
        up_pressed = 0;
        down_pressed = 0;
        held = 0;
        old_selected = selected;
        while (true) {
            if (held) {
                scene_list_settext(names, selected, str_title, 30);
                wait 0.5;
            } else {
                scene_list_settext(names, selected, str_title, 1);
            }
            if (!up_pressed) {
                if (level.localplayers[0] util::up_button_pressed()) {
                    up_pressed = 1;
                    selected--;
                    if (names[selected] === "<dev string:x30>") {
                        selected--;
                    }
                }
            } else if (level.localplayers[0] util::up_button_held()) {
                held = 1;
                selected -= 10;
            } else if (!level.localplayers[0] util::up_button_pressed()) {
                held = 0;
                up_pressed = 0;
            }
            if (!down_pressed) {
                if (level.localplayers[0] util::down_button_pressed()) {
                    down_pressed = 1;
                    selected++;
                    if (names[selected] === "<dev string:x30>") {
                        selected++;
                    }
                }
            } else if (level.localplayers[0] util::down_button_held()) {
                held = 1;
                selected += 10;
            } else if (!level.localplayers[0] util::down_button_pressed()) {
                held = 0;
                down_pressed = 0;
            }
            if (held) {
                if (selected < 0) {
                    selected = 0;
                } else if (selected >= names.size) {
                    selected = names.size - 1;
                }
            } else if (selected < 0) {
                selected = names.size - 1;
            } else if (selected >= names.size) {
                selected = 0;
            }
            if (level.localplayers[0] buttonpressed("<dev string:x100>")) {
                if (b_shot_menu) {
                    while (level.localplayers[0] buttonpressed("<dev string:x100>")) {
                        waitframe(1);
                    }
                    level.scene_menu_shot_index = selected;
                    level thread display_scene_menu(str_type);
                } else {
                    level.scene_menu_shot_index = selected;
                    setdvar(#"client_scene_menu", 0);
                }
            }
            if (level.localplayers[0] buttonpressed("<dev string:x109>") || level.localplayers[0] buttonpressed("<dev string:x112>") || level.localplayers[0] buttonpressed("<dev string:x11b>")) {
                if (names[selected] == "<dev string:x89>") {
                    level flagsys::toggle("<dev string:x121>");
                    while (level.localplayers[0] buttonpressed("<dev string:x109>") || level.localplayers[0] buttonpressed("<dev string:x112>") || level.localplayers[0] buttonpressed("<dev string:x11b>")) {
                        waitframe(1);
                    }
                    level thread display_scene_menu(str_type);
                } else if (names[selected] == "<dev string:xf8>") {
                    setdvar(#"client_scene_menu", 0);
                } else if (b_shot_menu) {
                    if (names[selected] == "<dev string:x84>") {
                        level.scene_menu_shot_index = selected;
                        while (level.localplayers[0] buttonpressed("<dev string:x109>") || level.localplayers[0] buttonpressed("<dev string:x112>") || level.localplayers[0] buttonpressed("<dev string:x11b>")) {
                            waitframe(1);
                        }
                        level thread display_scene_menu(str_type);
                    } else if (names[selected] == "<dev string:x7f>") {
                        setdvar(#"stop_client_scene", str_scene);
                    } else if (names[selected] == "<dev string:x75>") {
                        setdvar(#"init_client_scene", str_scene);
                    } else if (names[selected] == "<dev string:x7a>") {
                        setdvar(#"run_client_scene", str_scene);
                    } else {
                        setdvar(#"run_client_scene", str_scene + "<dev string:x39>" + names[selected]);
                    }
                }
                while (level.localplayers[0] buttonpressed("<dev string:x109>") || level.localplayers[0] buttonpressed("<dev string:x112>") || level.localplayers[0] buttonpressed("<dev string:x11b>")) {
                    waitframe(1);
                }
                if (!b_shot_menu && isdefined(names[selected]) && names[selected] != "<dev string:x30>") {
                    level.scene_menu_shot_index = selected;
                    level thread display_scene_menu(str_type, names[selected]);
                }
            }
            waitframe(1);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x56222441, Offset: 0x1768
    // Size: 0x84
    function function_9685c117(s_scenedef) {
        if (!(isdefined(s_scenedef.var_cb596183) && s_scenedef.var_cb596183) || isdefined(s_scenedef.var_cb596183) && s_scenedef.var_cb596183 && getdvarint(#"zm_debug_ee", 0)) {
            return 1;
        }
        return 0;
    }

    // Namespace scene/scene_debug_shared
    // Params 4, eflags: 0x0
    // Checksum 0x42e90e56, Offset: 0x17f8
    // Size: 0x4c
    function scene_list_settext(strings, n_selected, str_title, var_a315e132) {
        level thread _scene_list_settext(strings, n_selected, str_title, var_a315e132);
    }

    // Namespace scene/scene_debug_shared
    // Params 4, eflags: 0x0
    // Checksum 0x145944bd, Offset: 0x1850
    // Size: 0x38e
    function _scene_list_settext(strings, n_selected, str_title, var_a315e132) {
        if (!isdefined(var_a315e132)) {
            var_a315e132 = 1;
        }
        debug2dtext((150, 325, 0), str_title, (1, 1, 1), 1, (0, 0, 0), 1, 1, var_a315e132);
        str_mode = tolower(getdvarstring(#"scene_menu_mode", "<dev string:x31>"));
        switch (str_mode) {
        case #"default":
            debug2dtext((150, 362.5, 0), "<dev string:x138>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_a315e132);
            break;
        case #"loop":
            debug2dtext((150, 362.5, 0), "<dev string:x146>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_a315e132);
            break;
        case #"capture_single":
            debug2dtext((150, 362.5, 0), "<dev string:x151>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_a315e132);
            break;
        case #"capture_series":
            debug2dtext((150, 362.5, 0), "<dev string:x166>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_a315e132);
            break;
        }
        for (i = 0; i < 16; i++) {
            index = i + n_selected - 5;
            if (isdefined(strings[index])) {
                text = strings[index];
            } else {
                text = "<dev string:x30>";
            }
            if (is_scene_playing(text)) {
                text += "<dev string:x17b>";
                str_color = (0, 1, 0);
            } else if (is_scene_initialized(text)) {
                text += "<dev string:x186>";
                str_color = (0, 1, 0);
            } else {
                str_color = (1, 1, 1);
            }
            if (i == 5) {
                text = "<dev string:x195>" + text + "<dev string:x197>";
                str_color = (0.8, 0.4, 0);
            }
            debug2dtext((136, 400 + i * 25, 0), text, str_color, 1, (0, 0, 0), 1, 1, var_a315e132);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0xeea7ae11, Offset: 0x1be8
    // Size: 0x60
    function is_scene_playing(str_scene) {
        if (str_scene != "<dev string:x30>" && str_scene != "<dev string:x199>") {
            if (level flagsys::get(str_scene + "<dev string:x19e>")) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x3fb1778f, Offset: 0x1c50
    // Size: 0x60
    function is_scene_initialized(str_scene) {
        if (str_scene != "<dev string:x30>" && str_scene != "<dev string:x199>") {
            if (level flagsys::get(str_scene + "<dev string:x1a7>")) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb10cf7a0, Offset: 0x1cb8
    // Size: 0x2c
    function test_init(arg1) {
        init(arg1, undefined, undefined, 1);
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0xbf9e90ee, Offset: 0x1cf0
    // Size: 0x1b2
    function function_bbad8d21(var_65499128) {
        /#
            if (getdvarint(#"dvr_enable", 0) > 0 && getdvarint(#"scr_scene_dvr", 0) > 0) {
                if (!isdefined(var_65499128)) {
                    var_65499128 = spawnstruct();
                }
                var_65499128.drawbig = getdvarint(#"hash_13d62f4d290ef671", 0);
                var_65499128.var_d4735582 = getdvarint(#"scr_show_shot_info_for_igcs", 0);
                var_65499128.drawfps = getdvarint(#"cg_drawfps", 1);
                level.var_65499128 = var_65499128;
                setdvar(#"hash_13d62f4d290ef671", 1);
                setdvar(#"scr_show_shot_info_for_igcs", 1);
                setdvar(#"cg_drawfps", 0);
                adddebugcommand(0, "<dev string:x1b4>");
                wait 1;
            }
        #/
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa06c90bb, Offset: 0x1eb0
    // Size: 0x17c
    function function_83ef29c9(var_65499128) {
        /#
            if (getdvarint(#"dvr_enable", 0) > 0 && getdvarint(#"scr_scene_dvr", 0) > 0) {
                drawbig = 0;
                var_d4735582 = 0;
                drawfps = 1;
                if (isdefined(var_65499128)) {
                    if (isdefined(var_65499128.drawbig)) {
                        drawbig = var_65499128.drawbig;
                    }
                    if (isdefined(var_65499128.var_d4735582)) {
                        var_d4735582 = var_65499128.var_d4735582;
                    }
                    if (isdefined(var_65499128.drawfps)) {
                        drawfps = var_65499128.drawfps;
                    }
                }
                setdvar(#"hash_13d62f4d290ef671", drawbig);
                setdvar(#"scr_show_shot_info_for_igcs", var_d4735582);
                setdvar(#"cg_drawfps", drawfps);
                adddebugcommand(0, "<dev string:x1c0>");
            }
        #/
    }

    // Namespace scene/scene_debug_shared
    // Params 3, eflags: 0x0
    // Checksum 0xdd544447, Offset: 0x2038
    // Size: 0x114
    function test_play(arg1, arg2, str_mode) {
        if (!isdefined(level.var_65499128)) {
            level.var_65499128 = spawnstruct();
        }
        var_65499128 = spawnstruct();
        var_65499128.name = arg1;
        if (!isdefined(var_65499128.name)) {
            var_65499128.name = self.scriptbundlename;
        }
        if (!isdefined(var_65499128.name)) {
            var_65499128.name = "<dev string:x31>";
        }
        function_bbad8d21(var_65499128);
        play(arg1, arg2, undefined, 1, str_mode);
        function_83ef29c9(var_65499128);
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x54ed590f, Offset: 0x2158
    // Size: 0x380
    function debug_display() {
        self endon(#"death");
        if (!(isdefined(self.debug_display) && self.debug_display) && self != level) {
            self.debug_display = 1;
            while (true) {
                level flagsys::wait_till("<dev string:x1ca>");
                debug_frames = randomintrange(5, 15);
                debug_time = debug_frames / 60;
                sphere(self.origin, 1, (0, 1, 1), 1, 1, 8, debug_frames);
                if (isdefined(self.scenes)) {
                    foreach (i, o_scene in self.scenes) {
                        n_offset = 15 * (i + 1);
                        print3d(self.origin - (0, 0, n_offset), o_scene._str_name, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
                        print3d(self.origin - (0, 0, n_offset + 5), "<dev string:x1d5>" + (isdefined([[ o_scene ]]->function_1faf391c()) ? "<dev string:x30>" + [[ o_scene ]]->function_1faf391c() : "<dev string:x30>") + "<dev string:x1e5>", (0.8, 0.2, 0.8), 1, 0.15, debug_frames);
                        print3d(self.origin - (0, 0, n_offset + 10), "<dev string:x1e7>" + (isdefined(function_a2174d35(o_scene._str_name)) ? "<dev string:x30>" + function_a2174d35(o_scene._str_name) : "<dev string:x30>") + "<dev string:x1f7>", (0.8, 0.2, 0.8), 1, 0.15, debug_frames);
                    }
                } else if (isdefined(self.scriptbundlename)) {
                    print3d(self.origin - (0, 0, 15), self.scriptbundlename, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
                } else {
                    self.debug_display = 0;
                    break;
                }
                wait debug_time;
            }
        }
    }

#/
