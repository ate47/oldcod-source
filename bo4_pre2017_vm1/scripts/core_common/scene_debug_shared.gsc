#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace scene;

/#

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x2
    // Checksum 0x4e33ca79, Offset: 0x1d0
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6a9ff584, Offset: 0x210
    // Size: 0x11c
    function __init__() {
        if (getdvarstring("<dev string:x34>", "<dev string:x44>") == "<dev string:x44>") {
            setdvar("<dev string:x34>", "<dev string:x45>");
        }
        setdvar("<dev string:x4d>", "<dev string:x44>");
        setdvar("<dev string:x5e>", "<dev string:x44>");
        setdvar("<dev string:x70>", "<dev string:x44>");
        level thread run_scene_tests();
        level thread toggle_scene_menu();
        level thread toggle_postfx_igc_loop();
        level thread debug_display_all();
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x647b20cc, Offset: 0x338
    // Size: 0x4a6
    function run_scene_tests() {
        level endon(#"run_scene_tests");
        while (true) {
            str_run_scene = getdvarstring("<dev string:x82>");
            a_toks = strtok(str_run_scene, "<dev string:x8c>");
            str_scene = a_toks[0];
            str_shot = a_toks[1];
            if (!isdefined(str_scene)) {
                str_scene = "<dev string:x44>";
            }
            str_client_scene = getdvarstring("<dev string:x4d>");
            str_mode = tolower(getdvarstring("<dev string:x34>", "<dev string:x45>"));
            b_capture = str_mode == "<dev string:x8e>" || str_mode == "<dev string:x9d>";
            if (b_capture) {
                if (ispc()) {
                    if (str_scene != "<dev string:x44>") {
                        setdvar("<dev string:xac>", str_scene);
                        setdvar("<dev string:x82>", "<dev string:x44>");
                    }
                } else {
                    setdvar("<dev string:x34>", "<dev string:x45>");
                }
            } else {
                if (str_client_scene != "<dev string:x44>") {
                    level util::clientnotify(str_client_scene + "<dev string:xb7>");
                    util::wait_network_frame();
                }
                if (str_scene != "<dev string:x44>") {
                    setdvar("<dev string:x82>", "<dev string:x44>");
                    level thread test_play(str_scene, str_shot, str_mode);
                }
            }
            str_scene = getdvarstring("<dev string:xac>");
            str_client_scene = getdvarstring("<dev string:x5e>");
            if (str_client_scene != "<dev string:x44>") {
                level util::clientnotify(str_client_scene + "<dev string:xc0>");
                util::wait_network_frame();
            }
            if (str_scene != "<dev string:x44>") {
                setdvar("<dev string:xac>", "<dev string:x44>");
                level thread test_play(str_scene, "<dev string:xc9>");
                if (b_capture) {
                    capture_scene(str_scene, str_mode);
                }
            }
            str_scene = getdvarstring("<dev string:xce>");
            str_client_scene = getdvarstring("<dev string:x70>");
            if (str_client_scene != "<dev string:x44>") {
                level util::clientnotify(str_client_scene + "<dev string:xd9>");
                util::wait_network_frame();
            }
            if (str_scene != "<dev string:x44>") {
                setdvar("<dev string:xce>", "<dev string:x44>");
                level stop(str_scene);
            }
            str_scene = getdvarstring("<dev string:xe2>");
            if (str_scene != "<dev string:x44>") {
                setdvar("<dev string:xe2>", "<dev string:x44>");
                level stop(str_scene);
                level delete_scene_spawned_ents(str_scene);
            }
            waitframe(1);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 2, eflags: 0x0
    // Checksum 0x7beb2e62, Offset: 0x7e8
    // Size: 0x5c
    function capture_scene(str_scene, str_mode) {
        setdvar("<dev string:xee>", 0);
        level play(str_scene, undefined, undefined, 1, str_mode);
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x37d0c219, Offset: 0x850
    // Size: 0x176
    function toggle_scene_menu() {
        setdvar("<dev string:xee>", 0);
        n_scene_menu_last = -1;
        while (true) {
            n_scene_menu = getdvarstring("<dev string:xee>");
            if (n_scene_menu != "<dev string:x44>") {
                n_scene_menu = int(n_scene_menu);
                if (n_scene_menu != n_scene_menu_last) {
                    switch (n_scene_menu) {
                    case 1:
                        level thread display_scene_menu("<dev string:xf9>");
                        break;
                    case 2:
                        level thread display_scene_menu("<dev string:xff>");
                        break;
                    default:
                        level flagsys::clear("<dev string:x106>");
                        level notify(#"scene_menu_cleanup");
                        setdvar("<dev string:x110>", 0);
                        setdvar("<dev string:x12c>", 1);
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
    // Checksum 0x41a341a7, Offset: 0x9d0
    // Size: 0x14a
    function function_5d3bb86a(scene_name, index) {
        player = level.host;
        hudelem = player openluimenu("<dev string:x13b>");
        player setluimenudata(hudelem, "<dev string:x14a>", scene_name);
        player setluimenudata(hudelem, "<dev string:x14f>", 100);
        player setluimenudata(hudelem, "<dev string:x151>", 500 + index * 22);
        player setluimenudata(hudelem, "<dev string:x153>", 1000);
        player setluimenudata(hudelem, "<dev string:x159>", 1);
        player lui::set_color(hudelem, (1, 1, 1));
        return hudelem;
    }

    // Namespace scene/scene_debug_shared
    // Params 2, eflags: 0x0
    // Checksum 0x4dfe918d, Offset: 0xb28
    // Size: 0xdb6
    function display_scene_menu(str_type, str_scene) {
        if (!isdefined(str_type)) {
            str_type = "<dev string:xf9>";
        }
        level notify(#"scene_menu_cleanup");
        level endon(#"scene_menu_cleanup");
        waittillframeend();
        level flagsys::set("<dev string:x106>");
        setdvar("<dev string:x110>", 1);
        setdvar("<dev string:x12c>", 0);
        names = [];
        b_shot_menu = 0;
        if (isstring(str_scene)) {
            var_7a217697 = get_all_shot_names(str_scene);
            foreach (shotname in var_7a217697) {
                array::add_sorted(names, shotname, 0);
            }
            names[names.size] = "<dev string:x44>";
            names[names.size] = "<dev string:x15f>";
            names[names.size] = "<dev string:x164>";
            title = function_5d3bb86a(str_scene, -1);
            b_shot_menu = 1;
            selected = isdefined(level.scene_menu_shot_index) ? level.scene_menu_shot_index : 0;
        } else {
            foreach (str_scenedef in level.scenedefs) {
                s_scenedef = getscriptbundle(str_scenedef);
                if (s_scenedef.vmtype !== "<dev string:x16a>" && s_scenedef.scenetype === str_type) {
                    array::add_sorted(names, str_scenedef, 0);
                }
            }
            names[names.size] = "<dev string:x44>";
            names[names.size] = "<dev string:x171>";
            title = function_5d3bb86a(str_type + "<dev string:x176>", -1);
            selected = isdefined(level.scene_menu_index) ? level.scene_menu_index : 0;
        }
        if (selected > names.size - 1) {
            selected = 0;
        }
        if (!b_shot_menu) {
            level thread function_96d7ecd1();
            hudelem = level.host openluimenu("<dev string:x13b>");
            level.host setluimenudata(hudelem, "<dev string:x14a>", "<dev string:x178>");
            level.host setluimenudata(hudelem, "<dev string:x14f>", 100);
            level.host setluimenudata(hudelem, "<dev string:x151>", 510 + 484);
            level.host setluimenudata(hudelem, "<dev string:x153>", 1000);
        }
        elems = function_b0ed6108();
        up_pressed = 0;
        down_pressed = 0;
        held = 0;
        scene_list_settext(elems, names, selected);
        old_selected = selected;
        level thread scene_menu_cleanup(elems, title, hudelem);
        while (true) {
            if (b_shot_menu) {
                if (isdefined(level.last_scene_state) && isdefined(level.last_scene_state[str_scene])) {
                    level.host setluimenudata(title, "<dev string:x14a>", str_scene + "<dev string:x19a>" + level.last_scene_state[str_scene] + "<dev string:x19d>");
                } else {
                    level.host setluimenudata(title, "<dev string:x14a>", str_scene);
                }
                level.host lui::set_color(title, is_scene_active(str_scene) ? (0, 1, 0) : (1, 1, 1));
            }
            scene_list_settext(elems, names, selected);
            if (held) {
                wait 0.5;
            }
            if (!up_pressed) {
                if (level.host util::up_button_pressed()) {
                    up_pressed = 1;
                    selected--;
                    if (names[selected] === "<dev string:x44>") {
                        selected--;
                    }
                }
            } else if (level.host util::up_button_held()) {
                held = 1;
                selected -= 10;
            } else if (!level.host util::up_button_pressed()) {
                held = 0;
                up_pressed = 0;
            }
            if (!down_pressed) {
                if (level.host util::down_button_pressed()) {
                    down_pressed = 1;
                    selected++;
                    if (names[selected] === "<dev string:x44>") {
                        selected++;
                    }
                }
            } else if (level.host util::down_button_held()) {
                held = 1;
                selected += 10;
            } else if (!level.host util::down_button_pressed()) {
                held = 0;
                down_pressed = 0;
            }
            if (!down_pressed && !up_pressed) {
                if (names[selected] === "<dev string:x44>") {
                    selected++;
                }
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
            if (level.host buttonpressed("<dev string:x19f>")) {
                if (b_shot_menu) {
                    while (level.host buttonpressed("<dev string:x19f>")) {
                        waitframe(1);
                    }
                    level.scene_menu_shot_index = selected;
                    level thread display_scene_menu(str_type);
                } else {
                    level.scene_menu_index = selected;
                    setdvar("<dev string:xee>", 0);
                }
            }
            if (names[selected] != "<dev string:x171>" && !b_shot_menu) {
                if (level.host buttonpressed("<dev string:x1a8>") || level.host buttonpressed("<dev string:x1b3>")) {
                    level.host move_to_scene(names[selected]);
                    while (level.host buttonpressed("<dev string:x1a8>") || level.host buttonpressed("<dev string:x1b3>")) {
                        waitframe(1);
                    }
                } else if (level.host buttonpressed("<dev string:x1be>") || level.host buttonpressed("<dev string:x1c8>")) {
                    level.host move_to_scene(names[selected], 1);
                    while (level.host buttonpressed("<dev string:x1be>") || level.host buttonpressed("<dev string:x1c8>")) {
                        waitframe(1);
                    }
                }
            }
            if (level.host buttonpressed("<dev string:x1d2>") || level.host buttonpressed("<dev string:x1db>") || level.host buttonpressed("<dev string:x1e4>")) {
                if (names[selected] == "<dev string:x171>") {
                    setdvar("<dev string:xee>", 0);
                }
                if (b_shot_menu) {
                    if (names[selected] == "<dev string:x15f>") {
                        setdvar("<dev string:xce>", str_scene);
                    } else if (names[selected] == "<dev string:x164>") {
                        setdvar("<dev string:xe2>", str_scene);
                    } else {
                        setdvar("<dev string:x82>", str_scene + "<dev string:x8c>" + names[selected]);
                    }
                }
                while (level.host buttonpressed("<dev string:x1d2>") || level.host buttonpressed("<dev string:x1db>") || level.host buttonpressed("<dev string:x1e4>")) {
                    waitframe(1);
                }
                if (!b_shot_menu && isdefined(names[selected]) && names[selected] != "<dev string:x44>") {
                    level.scene_menu_index = selected;
                    level thread display_scene_menu(str_type, names[selected]);
                }
            }
            waitframe(1);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x478bdaed, Offset: 0x18e8
    // Size: 0x2cc
    function function_96d7ecd1(var_e71a3632) {
        if (!isdefined(var_e71a3632)) {
            var_e71a3632 = 1;
        }
        if (!var_e71a3632) {
            level flagsys::clear("<dev string:x1ea>");
            return;
        }
        hudelem = level.host openluimenu("<dev string:x13b>");
        level.host setluimenudata(hudelem, "<dev string:x14f>", 100);
        level.host setluimenudata(hudelem, "<dev string:x151>", 490);
        level.host setluimenudata(hudelem, "<dev string:x153>", 500);
        while (level flagsys::get("<dev string:x106>") && level flagsys::get("<dev string:x1ea>")) {
            str_mode = tolower(getdvarstring("<dev string:x34>", "<dev string:x45>"));
            switch (str_mode) {
            case #"default":
                level.host setluimenudata(hudelem, "<dev string:x14a>", "<dev string:x202>");
                break;
            case #"loop":
                level.host setluimenudata(hudelem, "<dev string:x14a>", "<dev string:x215>");
                break;
            case #"capture_single":
                level.host setluimenudata(hudelem, "<dev string:x14a>", "<dev string:x220>");
                break;
            case #"capture_series":
                level.host setluimenudata(hudelem, "<dev string:x14a>", "<dev string:x235>");
                break;
            }
            waitframe(1);
        }
        level.host closeluimenu(hudelem);
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa67e7398, Offset: 0x1bc0
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
    // Checksum 0x5ff92f80, Offset: 0x1c50
    // Size: 0x246
    function scene_list_settext(hud_array, strings, num) {
        for (i = 0; i < hud_array.size; i++) {
            index = i + num - 5;
            if (isdefined(strings[index])) {
                text = strings[index];
            } else {
                text = "<dev string:x44>";
            }
            str_scene = text;
            if (isdefined(level.last_scene_state) && isdefined(level.last_scene_state[text])) {
                text += "<dev string:x19a>" + level.last_scene_state[text] + "<dev string:x19d>";
            }
            if (i == 5) {
                text = "<dev string:x24a>" + text;
                level.host setluimenudata(hud_array[i], "<dev string:x14f>", 86);
                level.host lui::set_color(hud_array[i], (0.8, 0.4, 0));
            } else {
                level.host setluimenudata(hud_array[i], "<dev string:x14f>", 100);
                level.host lui::set_color(hud_array[i], is_scene_active(str_scene) ? (0, 1, 0) : (1, 1, 1));
            }
            level.host setluimenudata(hud_array[i], "<dev string:x14a>", text);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0xbb17d47f, Offset: 0x1ea0
    // Size: 0x58
    function is_scene_active(str_scene) {
        if (str_scene != "<dev string:x44>" && str_scene != "<dev string:x171>") {
            if (level is_active(str_scene)) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace scene/scene_debug_shared
    // Params 3, eflags: 0x0
    // Checksum 0x2c812265, Offset: 0x1f00
    // Size: 0xd4
    function scene_menu_cleanup(elems, title, hudelem) {
        level waittill("<dev string:x24d>");
        level.host closeluimenu(title);
        for (i = 0; i < elems.size; i++) {
            level.host closeluimenu(elems[i]);
        }
        if (isdefined(hudelem)) {
            level.host closeluimenu(hudelem);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 3, eflags: 0x0
    // Checksum 0xc85cd0fe, Offset: 0x1fe0
    // Size: 0x94
    function test_play(arg1, arg2, str_mode) {
        n_skipto = getdvarfloat("<dev string:x260>", 0);
        if (n_skipto > 0) {
            str_mode += "<dev string:x276>" + n_skipto;
        }
        play(arg1, arg2, undefined, 1, str_mode);
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa440f7fb, Offset: 0x2080
    // Size: 0x13c
    function debug_display_all() {
        while (true) {
            level flagsys::wait_till("<dev string:x27f>");
            debug_frames = randomintrange(5, 10);
            debug_time = debug_frames / 20;
            if (isdefined(level.scene_roots)) {
                level.scene_roots = array::remove_undefined(level.scene_roots);
                foreach (scene in level.scene_roots) {
                    scene debug_display(debug_frames);
                }
            }
            wait debug_time;
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x20ed9888, Offset: 0x21c8
    // Size: 0x344
    function debug_display(debug_frames) {
        sphere(debug_display_origin(), 1, (1, 1, 0), 1, 1, 8, debug_frames);
        i = 0;
        if (self == level) {
            b_found = 0;
            if (isdefined(self.scene_ents)) {
                a_scenes = getarraykeys(self.scene_ents);
                foreach (str_scene in a_scenes) {
                    if (isarray(self.scene_ents[str_scene])) {
                        foreach (ent in self.scene_ents[str_scene]) {
                            if (isdefined(ent)) {
                                b_found = 1;
                                print_scene_debug(debug_frames, i, str_scene, self.last_scene_state_instance[str_scene]);
                                i++;
                                break;
                            }
                        }
                    }
                }
            }
            if (!b_found) {
                return;
            }
            return;
        }
        if (isdefined(self.last_scene_state_instance)) {
            foreach (str_scene, str_state in self.last_scene_state_instance) {
                print_scene_debug(debug_frames, i, str_scene, str_state);
                i++;
            }
            return;
        }
        if (isdefined(self.scriptbundlename)) {
            n_offset = 15;
            print3d(debug_display_origin() - (0, 0, n_offset), self.scriptbundlename, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
        }
    }

    // Namespace scene/scene_debug_shared
    // Params 4, eflags: 0x0
    // Checksum 0x25f358a8, Offset: 0x2518
    // Size: 0x11c
    function print_scene_debug(debug_frames, i, str_scene, str_state) {
        v_origin = debug_display_origin();
        n_offset = 15 * (i + 1);
        print3d(v_origin - (0, 0, n_offset), str_scene, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
        print3d(v_origin - (0, 0, n_offset + 5), "<dev string:x28a>" + str_state + "<dev string:x28c>", (0.8, 0.2, 0.8), 1, 0.15, debug_frames);
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf8389f33, Offset: 0x2640
    // Size: 0x28
    function debug_display_origin() {
        if (self == level) {
            return (0, 0, 0);
        }
        return self.origin;
    }

    // Namespace scene/scene_debug_shared
    // Params 2, eflags: 0x0
    // Checksum 0xa0074dc4, Offset: 0x2670
    // Size: 0x264
    function move_to_scene(str_scene, b_reverse_dir) {
        if (!isdefined(b_reverse_dir)) {
            b_reverse_dir = 0;
        }
        if (!(level.debug_current_scene_name === str_scene)) {
            level.debug_current_scene_instances = struct::get_array(str_scene, "<dev string:x28e>");
            level.debug_current_scene_index = 0;
            level.debug_current_scene_name = str_scene;
        } else if (b_reverse_dir) {
            level.debug_current_scene_index--;
            if (level.debug_current_scene_index == -1) {
                level.debug_current_scene_index = level.debug_current_scene_instances.size - 1;
            }
        } else {
            level.debug_current_scene_index++;
            if (level.debug_current_scene_index == level.debug_current_scene_instances.size) {
                level.debug_current_scene_index = 0;
            }
        }
        if (level.debug_current_scene_instances.size == 0) {
            s_bundle = struct::get_script_bundle("<dev string:xf9>", str_scene);
            if (isdefined(s_bundle.aligntarget)) {
                e_align = get_existing_ent(s_bundle.aligntarget, 0, 1);
                if (isdefined(e_align)) {
                    level.host set_origin(e_align.origin);
                } else {
                    error_on_screen("<dev string:x29f>");
                }
            } else {
                error_on_screen("<dev string:x2cf>");
            }
            return;
        }
        s_scene = level.debug_current_scene_instances[level.debug_current_scene_index];
        level.host set_origin(s_scene.origin);
    }

    // Namespace scene/scene_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x75c36b3a, Offset: 0x28e0
    // Size: 0x64
    function set_origin(v_origin) {
        if (!self isinmovemode("<dev string:x2fe>", "<dev string:x302>")) {
            adddebugcommand("<dev string:x302>");
        }
        self setorigin(v_origin);
    }

    // Namespace scene/scene_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf47634c8, Offset: 0x2950
    // Size: 0x74
    function toggle_postfx_igc_loop() {
        while (true) {
            if (getdvarint("<dev string:x309>", 0)) {
                array::run_all(level.activeplayers, &clientfield::increment_to_player, "<dev string:x31d>", 1);
                wait 4;
            }
            wait 1;
        }
    }

#/
