#using scripts/core_common/array_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/scriptbundle_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace scene;

/#

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x2
    // Checksum 0xda77534d, Offset: 0x1b0
    // Size: 0x34
    function autoexec __init__sytem__() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1b310e1b, Offset: 0x1f0
    // Size: 0x8c
    function __init__() {
        if (getdvarstring("<dev string:x34>", "<dev string:x44>") == "<dev string:x44>") {
            setdvar("<dev string:x34>", "<dev string:x45>");
        }
        level thread run_scene_tests();
        level thread toggle_scene_menu();
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe6bf66f6, Offset: 0x288
    // Size: 0x4c6
    function run_scene_tests() {
        level endon(#"run_scene_tests");
        level.scene_test_struct = spawnstruct();
        level.scene_test_struct.origin = (0, 0, 0);
        level.scene_test_struct.angles = (0, 0, 0);
        while (true) {
            str_scene = getdvarstring("<dev string:x4d>");
            str_mode = tolower(getdvarstring("<dev string:x34>", "<dev string:x45>"));
            if (str_scene != "<dev string:x44>") {
                setdvar("<dev string:x4d>", "<dev string:x44>");
                clear_old_ents(str_scene);
                b_found = 0;
                a_scenes = struct::get_array(str_scene, "<dev string:x5e>");
                foreach (s_instance in a_scenes) {
                    if (isdefined(s_instance)) {
                        b_found = 1;
                        s_instance thread test_play(undefined, str_mode);
                    }
                }
                if (isdefined(level.active_scenes[str_scene])) {
                    foreach (s_instance in level.active_scenes[str_scene]) {
                        if (!isinarray(a_scenes, s_instance)) {
                            b_found = 1;
                            s_instance thread test_play(str_scene, str_mode);
                        }
                    }
                }
                if (!b_found) {
                    level.scene_test_struct thread test_play(str_scene, str_mode);
                }
            }
            str_scene = getdvarstring("<dev string:x6f>");
            if (str_scene != "<dev string:x44>") {
                setdvar("<dev string:x6f>", "<dev string:x44>");
                clear_old_ents(str_scene);
                b_found = 0;
                a_scenes = struct::get_array(str_scene, "<dev string:x5e>");
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
            str_scene = getdvarstring("<dev string:x81>");
            if (str_scene != "<dev string:x44>") {
                setdvar("<dev string:x81>", "<dev string:x44>");
                level stop(str_scene, 1);
            }
            waitframe(1);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x3104f026, Offset: 0x758
    // Size: 0xd2
    function clear_old_ents(str_scene) {
        foreach (ent in getentarray(0)) {
            if (ent.scene_spawned === str_scene && ent.finished_scene === str_scene) {
                ent delete();
            }
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xaa46653f, Offset: 0x838
    // Size: 0x15e
    function toggle_scene_menu() {
        setdvar("<dev string:x93>", 0);
        n_scene_menu_last = -1;
        while (true) {
            n_scene_menu = getdvarstring("<dev string:x93>");
            if (n_scene_menu != "<dev string:x44>") {
                n_scene_menu = int(n_scene_menu);
                if (n_scene_menu != n_scene_menu_last) {
                    switch (n_scene_menu) {
                    case 1:
                        level thread display_scene_menu("<dev string:xa5>");
                        break;
                    case 2:
                        level thread display_scene_menu("<dev string:xab>");
                        break;
                    default:
                        level flagsys::clear("<dev string:xb2>");
                        level notify(#"scene_menu_cleanup");
                        setdvar("<dev string:xbc>", 1);
                        break;
                    }
                    n_scene_menu_last = n_scene_menu;
                }
            }
            waitframe(1);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 2, eflags: 0x0
    // Checksum 0x2828a2a, Offset: 0x9a0
    // Size: 0x19a
    function function_5d3bb86a(scene_name, index) {
        alpha = 1;
        color = (0.9, 0.9, 0.9);
        if (index != -1) {
            if (index != 5) {
                alpha = 1 - abs(5 - index) / 5;
            }
        }
        if (alpha == 0) {
            alpha = 0.05;
        }
        hudelem = createluimenu(0, "<dev string:xcb>");
        setluimenudata(0, hudelem, "<dev string:xda>", scene_name);
        setluimenudata(0, hudelem, "<dev string:xdf>", 100);
        setluimenudata(0, hudelem, "<dev string:xe1>", 500 + index * 22);
        setluimenudata(0, hudelem, "<dev string:xe3>", 1000);
        openluimenu(0, hudelem);
        return hudelem;
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6a734195, Offset: 0xb48
    // Size: 0x732
    function display_scene_menu(str_type) {
        if (!isdefined(str_type)) {
            str_type = "<dev string:xa5>";
        }
        level notify(#"scene_menu_cleanup");
        level endon(#"scene_menu_cleanup");
        waittillframeend();
        level flagsys::set("<dev string:xb2>");
        setdvar("<dev string:xbc>", 0);
        level thread function_96d7ecd1();
        a_scenedefs = get_scenedefs(str_type);
        if (str_type == "<dev string:xa5>") {
            a_scenedefs = arraycombine(a_scenedefs, get_scenedefs("<dev string:xe9>"), 0, 1);
        }
        names = [];
        foreach (s_scenedef in a_scenedefs) {
            array::add_sorted(names, s_scenedef.name, 0);
        }
        names[names.size] = "<dev string:xf3>";
        elems = function_b0ed6108();
        title = function_5d3bb86a(str_type + "<dev string:xf8>", -1);
        selected = 0;
        up_pressed = 0;
        down_pressed = 0;
        held = 0;
        scene_list_settext(elems, names, selected);
        old_selected = selected;
        level thread scene_menu_cleanup(elems, title);
        while (true) {
            scene_list_settext(elems, names, selected);
            if (held) {
                wait 0.5;
            }
            if (!up_pressed) {
                if (level.localplayers[0] util::up_button_pressed()) {
                    up_pressed = 1;
                    selected--;
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
            if (level.localplayers[0] buttonpressed("<dev string:xfb>")) {
                setdvar("<dev string:x93>", 0);
            }
            if (level.localplayers[0] buttonpressed("<dev string:x104>") || level.localplayers[0] buttonpressed("<dev string:x10d>") || level.localplayers[0] buttonpressed("<dev string:x116>")) {
                if (names[selected] == "<dev string:xf3>") {
                    setdvar("<dev string:x93>", 0);
                } else if (is_scene_playing(names[selected])) {
                    setdvar("<dev string:x81>", names[selected]);
                } else if (is_scene_initialized(names[selected])) {
                    setdvar("<dev string:x4d>", names[selected]);
                } else if (has_init_state(names[selected])) {
                    setdvar("<dev string:x6f>", names[selected]);
                } else {
                    setdvar("<dev string:x4d>", names[selected]);
                }
                while (level.localplayers[0] buttonpressed("<dev string:x104>") || level.localplayers[0] buttonpressed("<dev string:x10d>") || level.localplayers[0] buttonpressed("<dev string:x116>")) {
                    waitframe(1);
                }
            }
            waitframe(1);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3079ab8f, Offset: 0x1288
    // Size: 0x234
    function function_96d7ecd1() {
        hudelem = createluimenu(0, "<dev string:xcb>");
        setluimenudata(0, hudelem, "<dev string:xdf>", 100);
        setluimenudata(0, hudelem, "<dev string:xe1>", 510 + 484);
        setluimenudata(0, hudelem, "<dev string:xe3>", 1000);
        openluimenu(0, hudelem);
        while (level flagsys::get("<dev string:xb2>")) {
            str_mode = tolower(getdvarstring("<dev string:x34>", "<dev string:x45>"));
            switch (str_mode) {
            case #"default":
                setluimenudata(0, hudelem, "<dev string:xda>", "<dev string:x11c>");
                break;
            case #"loop":
                setluimenudata(0, hudelem, "<dev string:xda>", "<dev string:x12f>");
                break;
            case #"capture_single":
                setluimenudata(0, hudelem, "<dev string:xda>", "<dev string:x149>");
                break;
            case #"capture_series":
                setluimenudata(0, hudelem, "<dev string:xda>", "<dev string:x16d>");
                break;
            }
            waitframe(1);
        }
        closeluimenu(0, hudelem);
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd5cbc295, Offset: 0x14c8
    // Size: 0x82
    function function_b0ed6108() {
        hud_array = [];
        for (i = 0; i < 22; i++) {
            hud = function_5d3bb86a("<dev string:x44>", i);
            hud_array[hud_array.size] = hud;
        }
        return hud_array;
    }

    // Namespace scene/scene_debug_shared
    // Params 3, eflags: 0x0
    // Checksum 0x7b58a814, Offset: 0x1558
    // Size: 0x1ee
    function scene_list_settext(hud_array, strings, num) {
        for (i = 0; i < hud_array.size; i++) {
            index = i + num - 5;
            if (isdefined(strings[index])) {
                text = strings[index];
            } else {
                text = "<dev string:x44>";
            }
            if (is_scene_playing(text)) {
                setluimenudata(0, hud_array[i], "<dev string:x182>", 1);
                text += "<dev string:x188>";
            } else if (is_scene_initialized(text)) {
                setluimenudata(0, hud_array[i], "<dev string:x182>", 1);
                text += "<dev string:x193>";
            } else {
                setluimenudata(0, hud_array[i], "<dev string:x182>", 0.5);
            }
            if (i == 5) {
                setluimenudata(0, hud_array[i], "<dev string:x182>", 1);
                text = "<dev string:x1a2>" + text + "<dev string:x1a4>";
            }
            setluimenudata(0, hud_array[i], "<dev string:xda>", text);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x698a0acc, Offset: 0x1750
    // Size: 0x60
    function is_scene_playing(str_scene) {
        if (str_scene != "<dev string:x44>" && str_scene != "<dev string:xf3>") {
            if (level flagsys::get(str_scene + "<dev string:x1a6>")) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd858cc4d, Offset: 0x17b8
    // Size: 0x60
    function is_scene_initialized(str_scene) {
        if (str_scene != "<dev string:x44>" && str_scene != "<dev string:xf3>") {
            if (level flagsys::get(str_scene + "<dev string:x1af>")) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace scene/scene_debug_shared
    // Params 2, eflags: 0x0
    // Checksum 0xd39fe628, Offset: 0x1820
    // Size: 0x8e
    function scene_menu_cleanup(elems, title) {
        level waittill("<dev string:x1bc>");
        closeluimenu(0, title);
        for (i = 0; i < elems.size; i++) {
            closeluimenu(0, elems[i]);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x65056d70, Offset: 0x18b8
    // Size: 0x2c
    function test_init(arg1) {
        init(arg1, undefined, undefined, 1);
    }

    // Namespace scene/scene_debug_shared
    // Params 2, eflags: 0x0
    // Checksum 0x2c62bd37, Offset: 0x18f0
    // Size: 0x3c
    function test_play(arg1, str_mode) {
        play(arg1, undefined, undefined, 1, str_mode);
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x24a35ceb, Offset: 0x1938
    // Size: 0x31a
    function debug_display() {
        self endon(#"death");
        if (!(isdefined(self.debug_display) && self.debug_display) && self != level) {
            self.debug_display = 1;
            while (true) {
                level flagsys::wait_till("<dev string:x1cf>");
                debug_frames = randomintrange(5, 15);
                debug_time = debug_frames / 60;
                sphere(self.origin, 1, (0, 1, 1), 1, 1, 8, debug_frames);
                if (isdefined(self.scenes)) {
                    foreach (i, o_scene in self.scenes) {
                        n_offset = 15 * (i + 1);
                        print3d(self.origin - (0, 0, n_offset), o_scene._str_name, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
                        print3d(self.origin - (0, 0, n_offset + 5), "<dev string:x1da>" + (isdefined([[ o_scene ]]->get_state()) ? "<dev string:x44>" + [[ o_scene ]]->get_state() : "<dev string:x44>") + "<dev string:x1dc>", (0.8, 0.2, 0.8), 1, 0.15, debug_frames);
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
