#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace elevators;

// Namespace elevators
// Method(s) 18 Total 18
class class_b62431d2 {

    var m_e_trigger;
    var m_s_bundle;
    var var_126900b9;
    var var_4a7f62e7;
    var var_65c5056a;
    var var_7109088f;
    var var_857cf957;
    var var_b4519bb7;
    var var_ccdffe96;

    // Namespace namespace_b62431d2/elevators_shared
    // Params 1, eflags: 0x0
    // Checksum 0xcc3a8fd3, Offset: 0x2e80
    // Size: 0xa4
    function function_6f5dd252(var_e200da78) {
        if (!self flag::get("elevator_moving")) {
            if (m_s_bundle.var_21960e14 == "auto_up" || m_s_bundle.var_21960e14 == "auto_down") {
                moving_down(var_e200da78);
                return;
            }
            if (var_b4519bb7 > 1) {
                moving_down(var_e200da78);
            }
        }
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 1, eflags: 0x0
    // Checksum 0x75358af, Offset: 0x2dc8
    // Size: 0xac
    function function_60016c09(var_e200da78) {
        if (!self flag::get("elevator_moving")) {
            if (m_s_bundle.var_21960e14 == "auto_up" || m_s_bundle.var_21960e14 == "auto_down") {
                moving_up(var_e200da78);
                return;
            }
            if (var_b4519bb7 < m_s_bundle.var_4cc3904c) {
                moving_up(var_e200da78);
            }
        }
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 2, eflags: 0x0
    // Checksum 0x1fb51384, Offset: 0x28f8
    // Size: 0x4c4
    function moving_down(var_e200da78, var_4654bd78) {
        self flag::set("elevator_moving");
        if (isdefined(var_65c5056a) && isdefined(var_65c5056a.mdl_gameobject.b_enabled) && var_65c5056a.mdl_gameobject.b_enabled) {
            var_65c5056a gameobjects::disable_object();
        }
        if (!(isdefined(var_4654bd78) && var_4654bd78)) {
            if (isdefined(m_s_bundle.var_332fb328)) {
                var_4a7f62e7 playsound(m_s_bundle.var_332fb328);
            }
            if (isdefined(m_s_bundle.var_a27a663e)) {
                if (!isdefined(var_126900b9)) {
                    var_126900b9 = spawn("script_origin", var_4a7f62e7.origin);
                    var_126900b9 linkto(var_4a7f62e7);
                }
                var_126900b9 stoploopsound();
                var_126900b9 playloopsound(m_s_bundle.var_a27a663e);
            }
        }
        if (var_7109088f[var_b4519bb7] === 1) {
            function_ae76ac8d(var_b4519bb7);
        }
        var_c4284d06 = 0;
        if (var_e200da78 > var_b4519bb7) {
            var_c4284d06 = var_e200da78 - var_b4519bb7;
        } else if (var_e200da78 < var_b4519bb7) {
            var_c4284d06 = var_b4519bb7 - var_e200da78;
        }
        n_movetime = m_s_bundle.var_d86d98cf * var_c4284d06;
        n_movetime = math::clamp(n_movetime, 1, 30);
        var_4a7f62e7 movez(-1 * m_s_bundle.var_b75768b1 * var_c4284d06, n_movetime, 0.1, 0.1);
        var_4a7f62e7 waittill(#"movedone");
        var_b4519bb7 = var_e200da78;
        if (isdefined(var_126900b9)) {
            var_126900b9 stoploopsound();
        }
        if (isdefined(m_s_bundle.var_3e689947)) {
            var_4a7f62e7 playsound(m_s_bundle.var_3e689947);
        }
        self flag::clear("elevator_moving");
        if (isdefined(var_65c5056a)) {
            var_65c5056a.mdl_gameobject.interactteam = #"any";
            var_65c5056a gameobjects::enable_object();
        }
        function_bdf11c81(var_e200da78);
        wait isdefined(m_s_bundle.var_5221a6bf) ? m_s_bundle.var_5221a6bf : 0;
        if (isdefined(m_s_bundle.var_ccae2ef7) && m_s_bundle.var_ccae2ef7 && m_s_bundle.var_21960e14 == "auto_down") {
            thread function_60016c09(1);
        }
        if (m_s_bundle.var_21960e14 == "up_and_down") {
            if (var_857cf957.size >= 1) {
                var_e200da78 = array::pop_front(var_857cf957);
                if (var_e200da78 < var_b4519bb7) {
                    thread function_6f5dd252(var_e200da78);
                }
                if (var_e200da78 > var_b4519bb7) {
                    thread function_60016c09(var_e200da78);
                }
            }
        }
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 2, eflags: 0x0
    // Checksum 0x3f6b9224, Offset: 0x2430
    // Size: 0x4bc
    function moving_up(var_e200da78, var_4654bd78) {
        self flag::set("elevator_moving");
        if (isdefined(var_65c5056a) && isdefined(var_65c5056a.mdl_gameobject.b_enabled) && var_65c5056a.mdl_gameobject.b_enabled) {
            var_65c5056a gameobjects::disable_object();
        }
        if (!(isdefined(var_4654bd78) && var_4654bd78)) {
            if (isdefined(m_s_bundle.var_332fb328)) {
                var_4a7f62e7 playsound(m_s_bundle.var_332fb328);
            }
            if (isdefined(m_s_bundle.var_a27a663e)) {
                if (!isdefined(var_126900b9)) {
                    var_126900b9 = spawn("script_origin", var_4a7f62e7.origin);
                    var_126900b9 linkto(var_4a7f62e7);
                }
                var_126900b9 stoploopsound();
                var_126900b9 playloopsound(m_s_bundle.var_a27a663e);
            }
        }
        if (var_7109088f[var_b4519bb7] === 1) {
            function_ae76ac8d(var_b4519bb7);
        }
        var_c4284d06 = 0;
        if (var_e200da78 > var_b4519bb7) {
            var_c4284d06 = var_e200da78 - var_b4519bb7;
        } else if (var_e200da78 < var_b4519bb7) {
            var_c4284d06 = var_b4519bb7 - var_e200da78;
        }
        n_movetime = m_s_bundle.var_d86d98cf * var_c4284d06;
        n_movetime = math::clamp(n_movetime, 1, 30);
        var_4a7f62e7 movez(m_s_bundle.var_b75768b1 * var_c4284d06, n_movetime, 0.1, 0.1);
        var_4a7f62e7 waittill(#"movedone");
        var_b4519bb7 = var_e200da78;
        if (isdefined(var_126900b9)) {
            var_126900b9 stoploopsound();
        }
        if (isdefined(m_s_bundle.var_3e689947)) {
            var_4a7f62e7 playsound(m_s_bundle.var_3e689947);
        }
        self flag::clear("elevator_moving");
        if (isdefined(var_65c5056a)) {
            var_65c5056a.mdl_gameobject.interactteam = #"any";
            var_65c5056a gameobjects::enable_object();
        }
        function_bdf11c81(var_e200da78);
        wait isdefined(m_s_bundle.var_5221a6bf) ? m_s_bundle.var_5221a6bf : 0;
        if (isdefined(m_s_bundle.var_ccae2ef7) && m_s_bundle.var_ccae2ef7 && m_s_bundle.var_21960e14 == "auto_up") {
            thread function_6f5dd252(1);
            return;
        }
        if (m_s_bundle.var_21960e14 == "up_and_down") {
            if (var_857cf957.size >= 1) {
                var_e200da78 = array::pop_front(var_857cf957);
                if (var_e200da78 < var_b4519bb7) {
                    thread function_6f5dd252(var_e200da78);
                }
                if (var_e200da78 > var_b4519bb7) {
                    thread function_60016c09(var_e200da78);
                }
            }
        }
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5a6ed262, Offset: 0x1f10
    // Size: 0x512
    function function_bdf11c81(var_e200da78) {
        if (!(var_7109088f[var_e200da78] === 0)) {
            return;
        }
        switch (var_e200da78) {
        case 1:
            var_1cb702f6 = struct::get("elevator_doors_parking_1", "targetname");
            if (isdefined(var_1cb702f6)) {
                var_1cb702f6 scene::play("shot 5");
            }
            break;
        case 2:
            var_f6b4888d = struct::get("elevator_doors_parking_2", "targetname");
            if (isdefined(var_f6b4888d)) {
                var_f6b4888d scene::play("shot 1");
            }
            break;
        case 3:
            var_f6b4888d = struct::get("elevator_doors_parking_2", "targetname");
            if (isdefined(var_f6b4888d)) {
                var_f6b4888d scene::play("shot 3");
            }
            break;
        case 4:
            var_f6b4888d = struct::get("elevator_doors_parking_2", "targetname");
            if (isdefined(var_f6b4888d)) {
                var_f6b4888d scene::play("shot 5");
            }
            break;
        case 6:
            var_308e621a = struct::get("elevator_doors_lobby", "targetname");
            if (isdefined(var_308e621a)) {
                var_308e621a scene::play("shot 1");
            }
            break;
        case 7:
            var_308e621a = struct::get("elevator_doors_lobby", "targetname");
            if (isdefined(var_308e621a)) {
                var_308e621a scene::play("shot 3");
            }
            break;
        case 45:
            var_4bb7c4a8 = struct::get("elevator_doors_mall", "targetname");
            if (isdefined(var_4bb7c4a8)) {
                var_4bb7c4a8 scene::play("shot 1");
            }
            break;
        case 46:
            var_4bb7c4a8 = struct::get("elevator_doors_mall", "targetname");
            if (isdefined(var_4bb7c4a8)) {
                var_4bb7c4a8 scene::play("shot 3");
            }
            break;
        case 57:
            var_6da6479a = struct::get("elevator_doors_park", "targetname");
            if (isdefined(var_6da6479a)) {
                var_6da6479a scene::play("shot 1");
            }
            break;
        case 58:
            var_6da6479a = struct::get("elevator_doors_park", "targetname");
            if (isdefined(var_6da6479a)) {
                var_6da6479a scene::play("shot 3");
            }
            break;
        case 59:
            var_6da6479a = struct::get("elevator_doors_park", "targetname");
            if (isdefined(var_6da6479a)) {
                var_6da6479a scene::play("shot 5");
            }
            break;
        case 97:
            var_de3f5964 = struct::get("elevator_doors_roof", "targetname");
            if (isdefined(var_de3f5964)) {
                var_de3f5964 scene::play("shot 5", undefined, undefined, undefined, undefined, 0);
            }
            break;
        }
        if (isdefined(var_7109088f[var_e200da78])) {
            var_7109088f[var_e200da78] = 1;
        }
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 1, eflags: 0x0
    // Checksum 0x521d6d40, Offset: 0x19f8
    // Size: 0x50a
    function function_ae76ac8d(var_e200da78) {
        if (!(var_7109088f[var_e200da78] === 1)) {
            return;
        }
        switch (var_e200da78) {
        case 1:
            var_1cb702f6 = struct::get("elevator_doors_parking_1", "targetname");
            if (isdefined(var_1cb702f6)) {
                var_1cb702f6 scene::play("shot 6");
            }
            break;
        case 2:
            var_f6b4888d = struct::get("elevator_doors_parking_2", "targetname");
            if (isdefined(var_f6b4888d)) {
                var_f6b4888d scene::play("shot 2");
            }
            break;
        case 3:
            var_f6b4888d = struct::get("elevator_doors_parking_2", "targetname");
            if (isdefined(var_f6b4888d)) {
                var_f6b4888d scene::play("shot 4");
            }
            break;
        case 4:
            var_f6b4888d = struct::get("elevator_doors_parking_2", "targetname");
            if (isdefined(var_f6b4888d)) {
                var_f6b4888d scene::play("shot 6");
            }
            break;
        case 6:
            var_308e621a = struct::get("elevator_doors_lobby", "targetname");
            if (isdefined(var_308e621a)) {
                var_308e621a scene::play("shot 2");
            }
            break;
        case 7:
            var_308e621a = struct::get("elevator_doors_lobby", "targetname");
            if (isdefined(var_308e621a)) {
                var_308e621a scene::play("shot 4");
            }
            break;
        case 45:
            var_4bb7c4a8 = struct::get("elevator_doors_mall", "targetname");
            if (isdefined(var_4bb7c4a8)) {
                var_4bb7c4a8 scene::play("shot 2");
            }
            break;
        case 46:
            var_4bb7c4a8 = struct::get("elevator_doors_mall", "targetname");
            if (isdefined(var_4bb7c4a8)) {
                var_4bb7c4a8 scene::play("shot 4");
            }
            break;
        case 57:
            var_6da6479a = struct::get("elevator_doors_park", "targetname");
            if (isdefined(var_6da6479a)) {
                var_6da6479a scene::play("shot 2");
            }
            break;
        case 58:
            var_6da6479a = struct::get("elevator_doors_park", "targetname");
            if (isdefined(var_6da6479a)) {
                var_6da6479a scene::play("shot 4");
            }
            break;
        case 59:
            var_6da6479a = struct::get("elevator_doors_park", "targetname");
            if (isdefined(var_6da6479a)) {
                var_6da6479a scene::play("shot 6");
            }
            break;
        case 97:
            var_de3f5964 = struct::get("elevator_doors_roof", "targetname");
            if (isdefined(var_de3f5964)) {
                var_de3f5964 scene::play("shot 6");
            }
            break;
        }
        if (isdefined(var_7109088f[var_e200da78])) {
            var_7109088f[var_e200da78] = 0;
        }
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 2, eflags: 0x0
    // Checksum 0x735395c3, Offset: 0x17f8
    // Size: 0x1f4
    function function_3e4f9529(var_e200da78, b_inside) {
        if (var_e200da78 != var_b4519bb7) {
            var_dc31469a = 0;
            foreach (var_cff6a63e in var_857cf957) {
                if (var_cff6a63e == var_e200da78) {
                    var_dc31469a = 1;
                    break;
                }
            }
            if (!var_dc31469a) {
                array::push(var_857cf957, var_e200da78);
            }
        } else {
            if (isdefined(var_65c5056a) && isdefined(b_inside) && b_inside) {
                var_65c5056a.mdl_gameobject.interactteam = #"any";
                var_65c5056a gameobjects::enable_object();
                return;
            }
            if (!(isdefined(b_inside) && b_inside)) {
                function_bdf11c81(var_e200da78);
            }
            return;
        }
        if (!self flag::get("elevator_moving")) {
            if (var_857cf957.size >= 1) {
                var_e200da78 = array::pop_front(var_857cf957);
                if (var_e200da78 < var_b4519bb7) {
                    thread function_6f5dd252(var_e200da78);
                }
                if (var_e200da78 > var_b4519bb7) {
                    thread function_60016c09(var_e200da78);
                }
            }
        }
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 3, eflags: 0x0
    // Checksum 0xfa50f65d, Offset: 0x1550
    // Size: 0x29e
    function function_1d8e091e(var_dcf4cbb0, var_39854448, b_inside) {
        var_39b44fa3 = isdefined(var_dcf4cbb0.script_int) ? var_dcf4cbb0.script_int : 1;
        if (b_inside) {
            var_4a7f62e7 endon(#"hash_10ae3aed4e10c4c7");
        }
        while (true) {
            waitresult = var_dcf4cbb0.mdl_gameobject waittill(#"gameobject_end_use_player");
            e_player = waitresult.player;
            if (var_39854448) {
                function_3e4f9529(var_39b44fa3);
            } else if (b_inside) {
                flag::set("inner_button_menu_active");
                var_65c5056a gameobjects::function_7d73edfd();
                thread function_186fa1dc(e_player);
                e_player clientfield::set_to_player("elevator_floor_selection", 1);
                waitresult = e_player waittill(#"menuresponse", #"disconnect", #"death");
                flag::clear("inner_button_menu_active");
                if (waitresult._notify == "menuresponse") {
                    menu = waitresult.menu;
                    response = waitresult.response;
                    if (menu == "Elevator" && response == "floor") {
                        floornum = waitresult.intpayload;
                        function_3e4f9529(floornum, b_inside);
                    } else {
                        var_65c5056a.mdl_gameobject.interactteam = #"any";
                        var_65c5056a gameobjects::enable_object();
                    }
                }
                e_player clientfield::set_to_player("elevator_floor_selection", 0);
            }
            waitframe(1);
        }
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 1, eflags: 0x0
    // Checksum 0xbd01b9cd, Offset: 0x1478
    // Size: 0xce
    function function_9e1c4217(var_dcf4cbb0) {
        while (true) {
            if (isdefined(var_dcf4cbb0.mdl_gameobject)) {
                waitresult = var_dcf4cbb0.mdl_gameobject waittill(#"gameobject_end_use_player");
                e_player = waitresult.player;
                if (!self flag::get("elevator_moving")) {
                    if (var_b4519bb7 == 1) {
                        function_60016c09(2);
                    } else {
                        function_6f5dd252(1);
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 1, eflags: 0x0
    // Checksum 0x180b656, Offset: 0x1310
    // Size: 0x15a
    function function_186fa1dc(e_player) {
        if (!isalive(e_player)) {
            return;
        }
        e_player endon(#"death");
        while (flag::get("inner_button_menu_active")) {
            n_distance = distance(e_player.origin, var_4a7f62e7.origin);
            if (n_distance > 128) {
                var_4a7f62e7 notify(#"hash_10ae3aed4e10c4c7");
                e_player clientfield::set_to_player("elevator_floor_selection", 0);
                flag::clear("inner_button_menu_active");
                var_65c5056a.mdl_gameobject.interactteam = #"any";
                var_65c5056a gameobjects::enable_object();
                thread function_1d8e091e(var_65c5056a, 0, 1);
                break;
            }
            waitframe(1);
        }
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 0, eflags: 0x0
    // Checksum 0x56b5786c, Offset: 0x12e8
    // Size: 0x1c
    function function_af7c8f42() {
        var_65c5056a gameobjects::disable_object();
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 3, eflags: 0x0
    // Checksum 0x5bb5ffc, Offset: 0x1238
    // Size: 0xa4
    function function_a623eea9(var_dcf4cbb0, var_39854448, b_inside) {
        if (b_inside) {
            var_65c5056a = var_dcf4cbb0;
            var_dcf4cbb0.mdl_gameobject.trigger enablelinkto();
            var_dcf4cbb0.mdl_gameobject.trigger linkto(var_4a7f62e7);
        }
        thread function_1d8e091e(var_dcf4cbb0, var_39854448, b_inside);
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 0, eflags: 0x0
    // Checksum 0x36ea05bd, Offset: 0x10b8
    // Size: 0x176
    function function_ecacec01() {
        while (true) {
            waitresult = m_e_trigger waittill(#"trigger");
            wait isdefined(m_s_bundle.var_a1d97cff) ? m_s_bundle.var_a1d97cff : 0;
            e_player = waitresult.activator;
            if (e_player istouching(m_e_trigger)) {
                if (!self flag::get("elevator_moving")) {
                    if (m_s_bundle.var_21960e14 == "auto_up") {
                        if (var_b4519bb7 == 1) {
                            function_60016c09(2);
                        } else {
                            function_6f5dd252(1);
                        }
                    }
                    if (m_s_bundle.var_21960e14 == "auto_down") {
                        if (var_b4519bb7 == 1) {
                            function_6f5dd252(2);
                        } else {
                            function_60016c09(1);
                        }
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 0, eflags: 0x0
    // Checksum 0x22c4ece4, Offset: 0xe90
    // Size: 0x21c
    function function_9760c309() {
        v_offset = (isdefined(var_ccdffe96.var_ba8fccb9) ? var_ccdffe96.var_ba8fccb9 : 0, isdefined(var_ccdffe96.var_948d5250) ? var_ccdffe96.var_948d5250 : 0, isdefined(var_ccdffe96.var_694c18b) ? var_ccdffe96.var_694c18b : 0);
        v_pos = var_ccdffe96.origin;
        v_angles = var_ccdffe96.angles;
        if (v_offset[0]) {
            v_side = anglestoforward(v_angles);
            v_pos += v_offset[0] * v_side;
        }
        if (v_offset[1]) {
            v_dir = anglestoright(v_angles);
            v_pos += v_offset[1] * v_dir;
        }
        if (v_offset[2]) {
            v_up = anglestoup(v_angles);
            v_pos += v_offset[2] * v_up;
        }
        m_e_trigger = spawn("trigger_radius", v_pos, 16384 | 4096, var_ccdffe96.var_68ad033, var_ccdffe96.var_edf4b994);
        m_e_trigger enablelinkto();
        m_e_trigger linkto(var_4a7f62e7);
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 0, eflags: 0x0
    // Checksum 0x497f548b, Offset: 0xda0
    // Size: 0xe4
    function function_ebd28b9e() {
        e_or_str_model = m_s_bundle.model;
        if (isentity(e_or_str_model)) {
            var_4a7f62e7 = m_s_bundle.model;
        } else if (!isdefined(e_or_str_model) && !isdefined(var_ccdffe96.model)) {
            e_or_str_model = "tag_origin";
        }
        if (!isdefined(var_4a7f62e7)) {
            var_4a7f62e7 = util::spawn_model(e_or_str_model, var_ccdffe96.origin, var_ccdffe96.angles);
        }
        var_4a7f62e7 setmovingplatformenabled(1);
    }

    // Namespace namespace_b62431d2/elevators_shared
    // Params 2, eflags: 0x0
    // Checksum 0xdcef6d37, Offset: 0xbc0
    // Size: 0x1d6
    function init(var_acff6c9c, s_instance) {
        var_7109088f = [];
        var_7109088f[1] = 0;
        var_7109088f[2] = 0;
        var_7109088f[3] = 0;
        var_7109088f[4] = 0;
        var_7109088f[6] = 0;
        var_7109088f[7] = 0;
        var_7109088f[21] = 0;
        var_7109088f[22] = 0;
        var_7109088f[35] = 0;
        var_7109088f[36] = 0;
        var_7109088f[37] = 0;
        var_7109088f[38] = 0;
        var_7109088f[45] = 0;
        var_7109088f[46] = 0;
        var_7109088f[57] = 0;
        var_7109088f[58] = 0;
        var_7109088f[59] = 0;
        var_7109088f[97] = 0;
        m_s_bundle = var_acff6c9c;
        var_ccdffe96 = s_instance;
        var_b4519bb7 = isdefined(var_acff6c9c.var_93b8e5e2) ? var_acff6c9c.var_93b8e5e2 : 1;
        var_857cf957 = [];
    }

}

// Namespace elevators/elevators_shared
// Params 0, eflags: 0x2
// Checksum 0xe735b0de, Offset: 0x2c8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"elevators", &__init__, &__main__, undefined);
}

// Namespace elevators/elevators_shared
// Params 0, eflags: 0x0
// Checksum 0xa71c205c, Offset: 0x318
// Size: 0x304
function __init__() {
    clientfield::register("toplayer", "elevator_floor_selection", 1, 1, "int");
    var_1a62b1ae = struct::get_array("scriptbundle_elevators", "classname");
    foreach (s_instance in var_1a62b1ae) {
        var_988bc339 = s_instance init_elevator();
        if (isdefined(var_988bc339)) {
            s_instance.var_988bc339 = var_988bc339;
        }
    }
    var_a3b2d199 = struct::get("elevator_doors_roof", "targetname");
    if (isdefined(var_a3b2d199)) {
        level scene::init("elevator_doors_roof", "targetname");
    }
    var_1c0c389f = struct::get("elevator_doors_roof", "targetname");
    if (isdefined(var_1c0c389f)) {
        level scene::init("elevator_doors_park", "targetname");
    }
    var_c22f01bd = struct::get("elevator_doors_roof", "targetname");
    if (isdefined(var_c22f01bd)) {
        level scene::init("elevator_doors_mall", "targetname");
    }
    var_6c2eb025 = struct::get("elevator_doors_roof", "targetname");
    if (isdefined(var_6c2eb025)) {
        level scene::init("elevator_doors_lobby", "targetname");
    }
    var_3e880965 = struct::get("elevator_doors_parking_1", "targetname");
    var_648a83ce = struct::get("elevator_doors_parking_2", "targetname");
    if (isdefined(var_3e880965)) {
        level scene::init("elevator_doors_parking_1", "targetname");
    }
    if (isdefined(var_648a83ce)) {
        level scene::init("elevator_doors_parking_2", "targetname");
    }
}

// Namespace elevators/elevators_shared
// Params 0, eflags: 0x0
// Checksum 0x47fa1fb6, Offset: 0x628
// Size: 0x250
function init_elevator() {
    if (!isdefined(self.angles)) {
        self.angles = (0, 0, 0);
    }
    var_acff6c9c = struct::get_script_bundle("elevators", isdefined(self.var_df1e88e4) ? self.var_df1e88e4 : self.scriptbundlename);
    var_988bc339 = new class_b62431d2();
    [[ var_988bc339 ]]->init(var_acff6c9c, self);
    var_988bc339 flag::init("elevator_moving");
    var_988bc339 flag::init("floor_reached");
    var_988bc339 flag::init("inner_button_menu_active");
    [[ var_988bc339 ]]->function_ebd28b9e();
    if (var_988bc339.m_s_bundle.var_21960e14 == "auto_up" || var_988bc339.m_s_bundle.var_21960e14 == "auto_down") {
        [[ var_988bc339 ]]->function_9760c309();
    } else if (var_988bc339.m_s_bundle.var_21960e14 == "push_button") {
        a_s_gameobjects = struct::get_array("elevator_push_button", "targetname");
        foreach (var_dcf4cbb0 in a_s_gameobjects) {
            if (isdefined(var_dcf4cbb0.target) && var_dcf4cbb0.target === var_988bc339.var_ccdffe96.targetname) {
                thread [[ var_988bc339 ]]->function_9e1c4217(var_dcf4cbb0);
            }
        }
    }
    return var_988bc339;
}

// Namespace elevators/elevators_shared
// Params 0, eflags: 0x0
// Checksum 0xaf985be2, Offset: 0x880
// Size: 0x3c
function __main__() {
    level flagsys::wait_till("radiant_gameobjects_initialized");
    level function_36bfdf1e();
}

// Namespace elevators/elevators_shared
// Params 0, eflags: 0x0
// Checksum 0xb7e504be, Offset: 0x8c8
// Size: 0x2cc
function function_36bfdf1e() {
    var_1a62b1ae = struct::get_array("scriptbundle_elevators", "classname");
    foreach (s_instance in var_1a62b1ae) {
        if (s_instance.var_988bc339.m_s_bundle.var_21960e14 == "auto_up" || s_instance.var_988bc339.m_s_bundle.var_21960e14 == "auto_down") {
            thread [[ s_instance.var_988bc339 ]]->function_ecacec01();
            continue;
        }
        if (s_instance.var_988bc339.m_s_bundle.var_21960e14 == "up_and_down") {
            var_3e284bac = struct::get_array("elevator_button_inside", "targetname");
            var_68413260 = struct::get_array("elevator_button_call", "targetname");
            foreach (var_dcf4cbb0 in var_3e284bac) {
                if (isdefined(var_dcf4cbb0.target) && var_dcf4cbb0.target == s_instance.targetname) {
                    [[ s_instance.var_988bc339 ]]->function_a623eea9(var_dcf4cbb0, 0, 1);
                    break;
                }
            }
            foreach (var_dcf4cbb0 in var_68413260) {
                if (isdefined(var_dcf4cbb0.target) && var_dcf4cbb0.target == s_instance.targetname) {
                    [[ s_instance.var_988bc339 ]]->function_a623eea9(var_dcf4cbb0, 1, 0);
                }
            }
        }
    }
}

