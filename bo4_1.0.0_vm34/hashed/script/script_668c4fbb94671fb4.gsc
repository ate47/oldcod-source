#using script_46cea9e5d4ef9e21;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm\weapons\zm_weap_spectral_shield;
#using scripts\zm\zm_escape_paschal;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\util\ai_brutus_util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_zonemgr;

#namespace namespace_8adb45e8;

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x2
// Checksum 0x34652bc, Offset: 0xd00
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_3478ed13fc9440e6", &__init__, undefined, undefined);
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x0
// Checksum 0x11fa346c, Offset: 0xd48
// Size: 0x65c
function __init__() {
    n_bits = getminbitcountfornum(3);
    clientfield::register("scriptmover", "" + #"hash_632f7bc0b1a15f71", 1, n_bits, "int");
    clientfield::register("scriptmover", "" + #"hash_4614e4fa180c79af", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_53586aa63ca15286", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_65da20412fcaf97e", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_65da20412fcaf97e", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_7d4d423d8dabbee3", 1, getminbitcountfornum(10), "int");
    clientfield::register("toplayer", "" + #"hash_49fecafe0b5d6da4", 1, 2, "counter");
    clientfield::register("vehicle", "" + #"hash_584f13d0c8662647", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_584f13d0c8662647", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_a51ae59006ab41b", 1, getminbitcountfornum(4), "int");
    clientfield::register("scriptmover", "" + #"hash_64f2dd36b17bf17", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_119729072e708651", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_3e506d7aedac6ae0", 1, getminbitcountfornum(10), "int");
    clientfield::register("actor", "" + #"hash_34562274d7e875a4", 1, getminbitcountfornum(10), "int");
    clientfield::register("scriptmover", "" + #"hash_34562274d7e875a4", 1, getminbitcountfornum(10), "int");
    clientfield::register("vehicle", "" + #"hash_34562274d7e875a4", 1, getminbitcountfornum(10), "int");
    clientfield::register("scriptmover", "" + #"hash_7dc9331ef45ed81f", 1, getminbitcountfornum(10), "int");
    clientfield::register("scriptmover", "" + #"hash_7dc9341ef45ed9d2", 1, getminbitcountfornum(10), "int");
    clientfield::register("scriptmover", "" + #"hash_7dc9351ef45edb85", 1, getminbitcountfornum(10), "int");
    clientfield::register("actor", "" + #"hash_7a8eab5597b25400", 1, 1, "int");
    if (getdvarint(#"zm_ee_enabled", 0)) {
        if (zm_custom::function_5638f689(#"hash_3c5363541b97ca3e")) {
            /#
                level thread function_5a5c83a0();
            #/
        }
    }
    level._effect[#"powerup_grabbed_red"] = #"zombie/fx_powerup_grab_red_zmb";
    level thread function_4e7ad873();
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x7acce4b8, Offset: 0x13b0
// Size: 0x34
function private function_4e7ad873() {
    level waittill(#"all_players_spawned");
    hidemiscmodels("rt_gh_sanim");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0x9866695e, Offset: 0x13f0
// Size: 0x338
function function_1ad1808(var_4df52d26) {
    if (var_4df52d26) {
        var_a6fab7ce = struct::get_array("pa_po_pos", "targetname");
        foreach (s_portal_pos in var_a6fab7ce) {
            var_a57f187f = util::spawn_model("tag_origin", s_portal_pos.origin, s_portal_pos.angles);
            var_a57f187f.script_string = s_portal_pos.script_string;
            level thread paschal::function_881a1269("tag_socket_a");
            level thread paschal::function_881a1269("tag_socket_c");
            level thread paschal::function_881a1269("tag_socket_d");
            level thread paschal::function_881a1269("tag_socket_e");
            level thread paschal::function_881a1269("tag_socket_g");
            var_a57f187f clientfield::set("" + #"hash_632f7bc0b1a15f71", 2);
            exploder::exploder("fxexp_script_leyline_docks");
            exploder::exploder("fxexp_script_leyline_cellblock");
            exploder::exploder("fxexp_script_leyline_new_industries");
            exploder::exploder("fxexp_script_leyline_showers");
            exploder::exploder("fxexp_script_leyline_power_plant");
            var_a57f187f clientfield::set("" + #"hash_53586aa63ca15286", 1);
            waitframe(1);
            var_a57f187f clientfield::set("" + #"hash_53586aa63ca15286", 0);
        }
        return;
    }
    zm::register_actor_damage_callback(&function_d3e7cee1);
    level.var_8427a8af = array("docks", "cellblock", "new_industries", "showers", "power_plant");
    level function_3264bf8d();
    level notify(#"hash_29b90ce9aa921f78");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x1c644b8, Offset: 0x1730
// Size: 0xb6c
function private function_3264bf8d() {
    level endon(#"game_ended", #"hash_54eae43edf7f08cd");
    if (!isdefined(level.var_f5b75383)) {
        var_93078c57 = struct::get("k_fx_pos", "targetname");
        level.var_f5b75383 = util::spawn_model(#"hash_4c06bc763e373f0f", var_93078c57.origin, var_93078c57.angles);
    }
    while (level.var_8427a8af.size > 0) {
        if (!(isdefined(level.var_2a952da3) && level.var_2a952da3)) {
            s_beam = struct::get("s_p_s1_lh_r_light");
            if (!isdefined(s_beam.mdl_beam)) {
                s_beam.mdl_beam = util::spawn_model("tag_origin", s_beam.origin);
                s_beam.mdl_beam clientfield::set("" + #"hash_1f572bbcdde55d9d", 1);
            }
            v_dir = vectornormalize(level.var_f5b75383.origin - s_beam.mdl_beam.origin);
            v_angles = vectortoangles(v_dir);
            s_beam.mdl_beam.angles = v_angles;
            level.var_f5b75383 thread function_ddf76a13();
            level.var_f5b75383 thread scene::play("p8_fxanim_zm_esc_book_zombie_shuffle_bundle", "Shot 2", level.var_f5b75383);
            level.var_f5b75383 clientfield::set("" + #"hash_4614e4fa180c79af", 1);
            level.var_f5b75383 waittill(#"hash_1f3cf68a268a10f1");
            level.var_f5b75383 clientfield::set("" + #"hash_4614e4fa180c79af", 0);
            level.var_f5b75383 thread scene::play("p8_fxanim_zm_esc_book_zombie_shuffle_bundle", "Shot 1", level.var_f5b75383);
        }
        var_a57f187f = function_4149f32();
        var_a57f187f clientfield::set("" + #"hash_632f7bc0b1a15f71", 1);
        switch (var_a57f187f.script_string) {
        case #"docks":
            str_hint_text = #"hash_4213dc004145588f";
            break;
        case #"cellblock":
            str_hint_text = #"hash_70fa5ff9f448bc96";
            break;
        case #"new_industries":
            str_hint_text = #"hash_786af67b8225aaf4";
            break;
        case #"showers":
            str_hint_text = #"hash_8a1754e2c346504";
            break;
        case #"power_plant":
            str_hint_text = #"hash_7806b6b51cd2aed2";
            break;
        }
        if (!(isdefined(level.var_2a952da3) && level.var_2a952da3)) {
            level.var_3165b64a = level function_46f65ade();
            var_f2c56ecf = "" + level.var_3165b64a[0] + level.var_3165b64a[1] + level.var_3165b64a[2];
            level thread function_7af3bebf();
            callback::on_connect(&function_7af3bebf);
            level thread function_c02b97ba();
            while (true) {
                s_result = level waittill(#"hash_1ba800da972b0558");
                if (s_result.str_code == var_f2c56ecf) {
                    arrayremovevalue(level.var_6d1783e6, level.var_3165b64a);
                    level thread function_22182709();
                    break;
                }
            }
        }
        s_beam = struct::get("s_p_s1_lh_r_light");
        if (!isdefined(s_beam.mdl_beam)) {
            s_beam.mdl_beam = util::spawn_model("tag_origin", s_beam.origin);
            s_beam.mdl_beam clientfield::set("" + #"hash_1f572bbcdde55d9d", 1);
        }
        v_dir = vectornormalize(var_a57f187f.origin - s_beam.mdl_beam.origin);
        v_angles = vectortoangles(v_dir);
        s_beam.mdl_beam.angles = v_angles;
        var_a57f187f clientfield::set("" + #"hash_53586aa63ca15286", 1);
        if (!(isdefined(level.var_2a952da3) && level.var_2a952da3)) {
            var_a57f187f thread function_2d9bf517();
            s_result = var_a57f187f waittill(#"portal_timeout", #"blast_attack");
            if (s_result._notify == #"portal_timeout") {
                var_a57f187f clientfield::set("" + #"hash_632f7bc0b1a15f71", 0);
                var_a57f187f delete();
                continue;
            }
        } else {
            level.var_2a952da3 = undefined;
            waitframe(1);
        }
        var_a57f187f clientfield::set("" + #"hash_53586aa63ca15286", 0);
        switch (var_a57f187f.script_string) {
        case #"docks":
            var_a57f187f thread function_7451c1c2();
            var_81e5ddde = "tag_socket_g";
            var_fe9d63c7 = "fxexp_script_leyline_docks";
            break;
        case #"cellblock":
            var_a57f187f thread function_9edd01e9();
            var_81e5ddde = "tag_socket_e";
            var_fe9d63c7 = "fxexp_script_leyline_cellblock";
            break;
        case #"new_industries":
            var_a57f187f thread function_b2ba4805();
            var_81e5ddde = "tag_socket_c";
            var_fe9d63c7 = "fxexp_script_leyline_new_industries";
            break;
        case #"showers":
            var_a57f187f thread function_28c76e8b();
            var_81e5ddde = "tag_socket_d";
            var_fe9d63c7 = "fxexp_script_leyline_showers";
            break;
        case #"power_plant":
            var_a57f187f thread function_2894448f();
            var_81e5ddde = "tag_socket_a";
            var_fe9d63c7 = "fxexp_script_leyline_power_plant";
            break;
        }
        /#
            var_a57f187f thread function_682454da();
        #/
        s_result = var_a57f187f waittill(#"hash_300e9fed7925cd69");
        if (isdefined(s_result.b_success) && s_result.b_success) {
            var_a57f187f clientfield::set("" + #"hash_632f7bc0b1a15f71", 2);
            exploder::exploder(var_fe9d63c7);
            if (!isdefined(level.var_497f669a)) {
                level.var_497f669a = [];
            } else if (!isarray(level.var_497f669a)) {
                level.var_497f669a = array(level.var_497f669a);
            }
            if (!isinarray(level.var_497f669a, var_81e5ddde)) {
                level.var_497f669a[level.var_497f669a.size] = var_81e5ddde;
            }
        } else {
            var_a57f187f clientfield::set("" + #"hash_632f7bc0b1a15f71", 0);
            var_a57f187f delete();
            level waittill(#"between_round_over");
            continue;
        }
        arrayremovevalue(level.var_8427a8af, var_a57f187f.script_string);
        level waittill(#"between_round_over");
    }
    if (level.var_497f669a.size) {
        var_af330228 = struct::get("s_p_s2_ins");
        var_af330228.s_unitrigger_stub waittill(#"hash_4c6ab2a4a99f9539");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x72610803, Offset: 0x22a8
// Size: 0x186
function private function_4149f32() {
    if (isdefined(level.var_2d5907f7) && isinarray(level.var_8427a8af, level.var_2d5907f7)) {
        var_3b0136d8 = level.var_2d5907f7;
        level.var_2d5907f7 = undefined;
    } else {
        var_3b0136d8 = array::random(level.var_8427a8af);
    }
    var_a6fab7ce = struct::get_array("pa_po_pos", "targetname");
    foreach (s_portal_pos in var_a6fab7ce) {
        if (s_portal_pos.script_string === var_3b0136d8) {
            var_a57f187f = util::spawn_model("tag_origin", s_portal_pos.origin, s_portal_pos.angles);
            var_a57f187f.script_string = s_portal_pos.script_string;
            var_a57f187f.script_noteworthy = "blast_attack_interactables";
            break;
        }
    }
    return var_a57f187f;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x3dd2ea96, Offset: 0x2438
// Size: 0x2c2
function private function_46f65ade() {
    var_c25932f7 = randomint(10);
    var_5051c3bc = randomint(10);
    for (var_76543e25 = randomint(10); !namespace_d8b81d0b::function_7bf90968(var_c25932f7, var_5051c3bc, var_76543e25); var_76543e25 = randomint(10)) {
        var_c25932f7 = randomint(10);
        var_5051c3bc = randomint(10);
    }
    if (!isdefined(level.var_6d1783e6)) {
        level.var_6d1783e6 = [];
    } else if (!isarray(level.var_6d1783e6)) {
        level.var_6d1783e6 = array(level.var_6d1783e6);
    }
    if (!isinarray(level.var_6d1783e6, array(var_c25932f7, var_5051c3bc, var_76543e25))) {
        level.var_6d1783e6[level.var_6d1783e6.size] = array(var_c25932f7, var_5051c3bc, var_76543e25);
    }
    var_7ddf10a = struct::get_array("nixie_tubes", "script_noteworthy");
    foreach (var_bf6e40b in var_7ddf10a) {
        switch (var_bf6e40b.script_string) {
        case #"nixie_tube_trigger_1":
            n_code = var_c25932f7;
            break;
        case #"nixie_tube_trigger_2":
            n_code = var_5051c3bc;
            break;
        case #"nixie_tube_trigger_3":
            n_code = var_76543e25;
            break;
        }
    }
    return array(var_c25932f7, var_5051c3bc, var_76543e25);
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xd5e2f5a9, Offset: 0x2708
// Size: 0x1ce
function private function_7af3bebf() {
    level.var_f5b75383 clientfield::set("" + #"hash_7dc9331ef45ed81f", 0);
    level.var_f5b75383 clientfield::set("" + #"hash_7dc9341ef45ed9d2", 0);
    level.var_f5b75383 clientfield::set("" + #"hash_7dc9351ef45edb85", 0);
    for (i = 0; i < level.var_3165b64a.size; i++) {
        switch (i) {
        case 0:
            var_7b4fdf26 = "" + #"hash_7dc9331ef45ed81f";
            break;
        case 1:
            var_7b4fdf26 = "" + #"hash_7dc9341ef45ed9d2";
            break;
        case 2:
            var_7b4fdf26 = "" + #"hash_7dc9351ef45edb85";
            break;
        }
        if (level.var_3165b64a[i] == 0) {
            level.var_f5b75383 clientfield::set(var_7b4fdf26, 10);
            continue;
        }
        level.var_f5b75383 clientfield::set(var_7b4fdf26, level.var_3165b64a[i]);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x92d7eb9e, Offset: 0x28e0
// Size: 0xb4
function private function_22182709() {
    callback::remove_on_connect(&function_7af3bebf);
    level.var_f5b75383 clientfield::set("" + #"hash_7dc9331ef45ed81f", 0);
    level.var_f5b75383 clientfield::set("" + #"hash_7dc9341ef45ed9d2", 0);
    level.var_f5b75383 clientfield::set("" + #"hash_7dc9351ef45edb85", 0);
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x95a092ee, Offset: 0x29a0
// Size: 0x118
function private function_c02b97ba() {
    foreach (e_player in level.players) {
        w_current = e_player getcurrentweapon();
        if (w_current == level.var_3d9066fe || w_current == level.var_cc1a6c85) {
            if (e_player adsbuttonpressed()) {
                e_player clientfield::set_to_player("afterlife_vision_play", 0);
                util::wait_network_frame();
                e_player clientfield::set_to_player("afterlife_vision_play", 1);
            }
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xbdd8b255, Offset: 0x2ac0
// Size: 0x66
function private function_2d9bf517() {
    self endon(#"death", #"hash_300e9fed7925cd69", #"blast_attack");
    wait 180;
    level waittill(#"between_round_over");
    self notify(#"portal_timeout");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x16f5d242, Offset: 0x2b30
// Size: 0x54e
function private function_7451c1c2() {
    self endoncallback(&function_2506277e, #"death", #"hash_300e9fed7925cd69");
    b_success = undefined;
    level.var_6f18b374 = [];
    var_1ac093e6 = level function_b597e4f4();
    var_3c335c6e = getent("m_c_ra", "targetname");
    var_3c335c6e thread function_623ed342(var_1ac093e6);
    level waittill(#"hash_3ffb8bc647b5d06b");
    var_3b53f744 = getvehiclenode("gh_b_st_node", "targetname");
    level.var_9bd15c60 = vehicle::spawn(undefined, "gh_tb", #"hash_741d76f17830f464", var_3b53f744.origin, var_3b53f744.angles);
    level.var_9bd15c60 thread function_83a1d57f(var_3b53f744);
    array::thread_all(level.players, &function_a37b79dc, level.var_9bd15c60, #"hash_115ac6d40d4cc85b");
    self thread function_e248ebae();
    level waittill(#"hash_361c36fab747c7f0");
    var_c86525fe = struct::get("gh_d_pos", "targetname");
    level.var_9bd15c60 notify(#"stop_path");
    level.var_9bd15c60 vehicle::detach_path();
    level.var_9bd15c60 clientfield::set("" + #"hash_34562274d7e875a4", 0);
    level.var_9bd15c60 delete();
    level.var_7b633f41 = util::spawn_model(var_c86525fe.model, var_c86525fe.origin, var_c86525fe.angles);
    level.var_7b633f41 clientfield::set("" + #"hash_34562274d7e875a4", 1);
    level.var_7b633f41 clientfield::set("" + #"hash_584f13d0c8662647", 1);
    var_1a56dad8 = struct::get("gh_b_pos", "targetname");
    level.var_753bd3f6 = spawn("trigger_radius_new", var_1a56dad8.origin, (512 | 2) + 8, var_1a56dad8.radius);
    while (true) {
        s_result = level.var_753bd3f6 waittill(#"trigger");
        if (s_result.activator == level.var_28babbfc) {
            callback::remove_on_ai_killed(&function_33350eb2);
            level.var_28babbfc notify(#"hash_71716a8e79096aee");
            if (isdefined(level.var_28babbfc.t_interact)) {
                level.var_28babbfc.t_interact delete();
            }
            var_3695ea28 = level.var_28babbfc.origin;
            level.var_28babbfc delete();
            break;
        }
    }
    level.var_753bd3f6 delete();
    level.var_7b633f41 thread function_d0077d93(var_c86525fe);
    var_cbafe82b = level function_a4bafaf7(var_3695ea28);
    if (isdefined(var_cbafe82b) && var_cbafe82b) {
        level thread function_b47cb025(#"hash_7d360b71501ba662");
    }
    self thread function_2506277e();
    self notify(#"hash_300e9fed7925cd69", {#b_success:var_cbafe82b});
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x2befe39b, Offset: 0x3088
// Size: 0x1ac
function private function_2506277e(var_e34146dc) {
    callback::remove_on_ai_killed(&function_33350eb2);
    if (isdefined(level.var_c2dcef84)) {
        level.var_c2dcef84 delete();
    }
    if (isdefined(level.var_28babbfc)) {
        if (isdefined(level.var_28babbfc.t_interact)) {
            level.var_28babbfc.t_interact delete();
        }
        level.var_28babbfc delete();
    }
    if (isdefined(level.var_9bd15c60)) {
        level.var_9bd15c60 delete();
    }
    if (isdefined(level.a_t_codes)) {
        while (level.a_t_codes.size) {
            t_code = level.a_t_codes[0];
            t_code delete();
            arrayremovevalue(level.a_t_codes, t_code);
        }
        level.a_t_codes = undefined;
    }
    if (isdefined(level.var_7b633f41)) {
        level.var_7b633f41 delete();
    }
    if (isdefined(level.var_753bd3f6)) {
        level.var_753bd3f6 delete();
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x5efef154, Offset: 0x3240
// Size: 0xd6
function private function_83a1d57f(var_3b53f744) {
    self endon(#"death", #"stop_path");
    waitframe(1);
    self clientfield::set("" + #"hash_584f13d0c8662647", 1);
    self clientfield::set("" + #"hash_34562274d7e875a4", 1);
    while (true) {
        self vehicle::get_on_and_go_path(var_3b53f744);
        self vehicle::detach_path();
        waitframe(1);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xc6ccf8c6, Offset: 0x3320
// Size: 0x2f4
function private function_b597e4f4() {
    var_ead6bbdd = randomint(10);
    var_cf7e2585 = randomint(10);
    var_d3fa4e86 = randomint(10);
    var_1ac093e6 = var_ead6bbdd + var_cf7e2585 + var_d3fa4e86;
    level.a_t_codes = [];
    var_bfa6c14b = struct::get_array("m_c_pos", "targetname");
    foreach (var_e82cbaab in var_bfa6c14b) {
        t_code = spawn("trigger_radius_new", var_e82cbaab.origin, 0, var_e82cbaab.radius, 96);
        t_code.script_noteworthy = var_e82cbaab.script_noteworthy;
        t_code.targetname = var_e82cbaab.targetname;
        t_code.s_lookat = struct::get(var_e82cbaab.target, "targetname");
        if (!isdefined(level.a_t_codes)) {
            level.a_t_codes = [];
        } else if (!isarray(level.a_t_codes)) {
            level.a_t_codes = array(level.a_t_codes);
        }
        if (!isinarray(level.a_t_codes, t_code)) {
            level.a_t_codes[level.a_t_codes.size] = t_code;
        }
        switch (var_e82cbaab.script_noteworthy) {
        case #"gondola_platform":
            t_code.n_code = var_d3fa4e86;
            break;
        case #"catwalk":
            t_code.n_code = var_ead6bbdd;
            break;
        case #"model_industries":
            t_code.n_code = var_cf7e2585;
            break;
        }
        t_code thread function_50d8eb57();
    }
    return var_1ac093e6;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x2db3353e, Offset: 0x3620
// Size: 0xe6
function private function_50d8eb57() {
    level endon(#"hash_3ffb8bc647b5d06b");
    self endon(#"death");
    while (true) {
        s_result = self waittill(#"trigger");
        if (isplayer(s_result.activator) && !(isdefined(s_result.activator.var_d448216a) && s_result.activator.var_d448216a)) {
            s_result.activator.var_d448216a = 1;
            self thread function_de8731ff(s_result.activator);
        }
        waitframe(1);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xee26f424, Offset: 0x3710
// Size: 0x362
function private function_de8731ff(e_player) {
    level endon(#"hash_3ffb8bc647b5d06b");
    e_player endon(#"death");
    self endon(#"death");
    while (e_player istouching(self)) {
        w_current = e_player getcurrentweapon();
        if ((w_current == level.var_3d9066fe || w_current == level.var_cc1a6c85) && e_player util::is_looking_at(self.s_lookat.origin)) {
            e_player thread function_77f38972(self.n_code);
            exploder::exploder("fxexp_buoy_light");
            if (!isdefined(level.var_6f18b374)) {
                level.var_6f18b374 = [];
            } else if (!isarray(level.var_6f18b374)) {
                level.var_6f18b374 = array(level.var_6f18b374);
            }
            if (!isinarray(level.var_6f18b374, self)) {
                level.var_6f18b374[level.var_6f18b374.size] = self;
            }
            if (level.var_6f18b374.size >= 3) {
                level notify(#"hash_31bf59ee8be67433");
            }
            n_start_time = gettime();
            for (n_total_time = 0; n_total_time < 8 && e_player istouching(self) && (w_current == level.var_3d9066fe || w_current == level.var_cc1a6c85) && e_player util::is_looking_at(self.s_lookat.origin); n_total_time = (n_current_time - n_start_time) / 1000) {
                wait 0.1;
                w_current = e_player getcurrentweapon();
                n_current_time = gettime();
            }
            if (e_player clientfield::get_to_player("" + #"hash_7d4d423d8dabbee3")) {
                e_player clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", 0);
            }
            exploder::stop_exploder("fxexp_buoy_light");
        }
        waitframe(1);
    }
    e_player.var_d448216a = undefined;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xdb85f7a2, Offset: 0x3a80
// Size: 0x74
function private function_77f38972(n_num) {
    if (n_num == 0) {
        self clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", 10);
        return;
    }
    self clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", n_num);
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x375942a7, Offset: 0x3b00
// Size: 0x8a6
function private function_623ed342(var_1ac093e6) {
    level.var_c2dcef84 = spawn("trigger_radius_use", self.origin, 0, 64);
    level.var_c2dcef84 triggerignoreteam();
    level.var_c2dcef84 sethintstring(#"");
    level.var_c2dcef84 setcursorhint("HINT_NOICON");
    level.var_c2dcef84.is_visible = 1;
    level.var_c2dcef84 endon(#"death");
    var_999ca24 = undefined;
    var_7ba1395f = 0;
    var_8bb61e6f = [];
    var_19aeaf34 = [];
    var_93243688 = #"code_dot";
    var_93bbc1a7 = #"code_dash";
    if (var_1ac093e6 == 30) {
        var_999ca24 = 3;
        var_8bb61e6f = array(var_93243688, var_93243688, var_93243688, var_93bbc1a7, var_93bbc1a7);
    } else if (var_1ac093e6 >= 20) {
        var_999ca24 = 2;
        var_8bb61e6f = array(var_93243688, var_93243688, var_93bbc1a7, var_93bbc1a7, var_93bbc1a7);
    } else if (var_1ac093e6 >= 10) {
        var_999ca24 = 1;
        var_8bb61e6f = array(var_93243688, var_93bbc1a7, var_93bbc1a7, var_93bbc1a7, var_93bbc1a7);
    }
    switch (var_1ac093e6) {
    case 1:
    case 11:
    case 21:
        var_7ba1395f = 1;
        var_19aeaf34 = array(var_93243688, var_93bbc1a7, var_93bbc1a7, var_93bbc1a7, var_93bbc1a7);
        break;
    case 2:
    case 12:
    case 22:
        var_7ba1395f = 2;
        var_19aeaf34 = array(var_93243688, var_93243688, var_93bbc1a7, var_93bbc1a7, var_93bbc1a7);
        break;
    case 3:
    case 13:
    case 23:
        var_7ba1395f = 3;
        var_19aeaf34 = array(var_93243688, var_93243688, var_93243688, var_93bbc1a7, var_93bbc1a7);
        break;
    case 4:
    case 14:
    case 24:
        var_7ba1395f = 4;
        var_19aeaf34 = array(var_93243688, var_93243688, var_93243688, var_93243688, var_93bbc1a7);
        break;
    case 5:
    case 15:
    case 25:
        var_7ba1395f = 5;
        var_19aeaf34 = array(var_93243688, var_93243688, var_93243688, var_93243688, var_93243688);
        break;
    case 6:
    case 16:
    case 26:
        var_7ba1395f = 6;
        var_19aeaf34 = array(var_93bbc1a7, var_93243688, var_93243688, var_93243688, var_93243688);
        break;
    case 7:
    case 17:
    case 27:
        var_7ba1395f = 7;
        var_19aeaf34 = array(var_93bbc1a7, var_93bbc1a7, var_93243688, var_93243688, var_93243688);
        break;
    case 8:
    case 18:
    case 28:
        var_7ba1395f = 8;
        var_19aeaf34 = array(var_93bbc1a7, var_93bbc1a7, var_93bbc1a7, var_93243688, var_93243688);
        break;
    case 9:
    case 19:
    case 29:
        var_7ba1395f = 9;
        var_19aeaf34 = array(var_93bbc1a7, var_93bbc1a7, var_93bbc1a7, var_93bbc1a7, var_93243688);
        break;
    case 0:
    case 10:
    case 20:
    case 30:
        var_7ba1395f = 0;
        var_19aeaf34 = array(var_93bbc1a7, var_93bbc1a7, var_93bbc1a7, var_93bbc1a7, var_93bbc1a7);
        break;
    default:
        break;
    }
    var_7dd2a26b = 0;
    while (true) {
        s_result = level.var_c2dcef84 waittill(#"trigger");
        e_player = s_result.activator;
        level.var_c2dcef84 setinvisibletoall();
        level.var_c2dcef84.is_visible = 0;
        if (!isplayer(e_player)) {
            level.var_c2dcef84 setvisibletoall();
            level.var_c2dcef84.is_visible = 1;
            continue;
        }
        if (!(isdefined(var_7dd2a26b) && var_7dd2a26b)) {
            level.var_c2dcef84 thread function_9e5a8252();
            var_7dd2a26b = 1;
        }
        if (isdefined(var_999ca24) && var_999ca24 > 0) {
            var_a9fef020 = e_player function_bea3eba8(var_8bb61e6f, var_999ca24);
            if (!(isdefined(var_a9fef020) && var_a9fef020)) {
                e_player playlocalsound(level.zmb_laugh_alias);
                level.var_c2dcef84 setvisibletoall();
                level.var_c2dcef84.is_visible = 1;
                continue;
            }
        }
        if (isplayer(e_player)) {
            var_1c065f5b = e_player function_bea3eba8(var_19aeaf34, var_7ba1395f);
            if (isdefined(var_1c065f5b) && var_1c065f5b) {
                playsoundatposition(#"zmb_lightning_l", level.var_c2dcef84.origin);
                level notify(#"hash_3ffb8bc647b5d06b");
                level.var_c2dcef84 delete();
                return;
            } else {
                e_player playlocalsound(level.zmb_laugh_alias);
            }
        }
        level.var_c2dcef84 setvisibletoall();
        level.var_c2dcef84.is_visible = 1;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x8210aaf9, Offset: 0x43b0
// Size: 0xb8
function private function_9e5a8252() {
    self endon(#"death");
    level endon(#"hash_3ffb8bc647b5d06b");
    level waittill(#"end_of_round");
    while (isdefined(level.var_c2dcef84) && !(isdefined(level.var_c2dcef84.is_visible) && level.var_c2dcef84.is_visible)) {
        waitframe(1);
    }
    level notify(#"hash_1a286cacd101f4eb", {#b_success:0});
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 2, eflags: 0x4
// Checksum 0x48c2f830, Offset: 0x4470
// Size: 0x25e
function private function_bea3eba8(var_2afad667, n_entry) {
    self.var_120d9c5e = 1;
    self thread function_344c2c9f();
    if (isdefined(level.var_15211139) && level.var_15211139) {
        self thread function_77f38972(n_entry);
        wait 6;
        self clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", 0);
        return true;
    } else {
        for (i = 0; i < var_2afad667.size; i++) {
            var_d80f0c94 = var_2afad667[i];
            while (!self usebuttonpressed() && isdefined(self.var_120d9c5e) && self.var_120d9c5e) {
                waitframe(1);
            }
            n_start_time = gettime();
            while (self usebuttonpressed() && isdefined(self.var_120d9c5e) && self.var_120d9c5e) {
                waitframe(1);
            }
            if (!(isdefined(self.var_120d9c5e) && self.var_120d9c5e)) {
                return false;
            }
            var_b13eaf00 = gettime();
            n_total_time = (var_b13eaf00 - n_start_time) / 1000;
            if (n_total_time <= 1.25) {
                self clientfield::increment_to_player("" + #"hash_49fecafe0b5d6da4", 1);
                var_6f537046 = #"code_dot";
            } else {
                self clientfield::increment_to_player("" + #"hash_49fecafe0b5d6da4", 2);
                var_6f537046 = #"code_dash";
            }
            if (var_6f537046 !== var_d80f0c94) {
                return false;
            }
        }
    }
    return true;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xaf9a5de8, Offset: 0x46d8
// Size: 0x76
function private function_344c2c9f() {
    self endon(#"death");
    level.var_c2dcef84 endon(#"death");
    while (distance2d(self.origin, level.var_c2dcef84.origin) <= 64) {
        waitframe(1);
    }
    self.var_120d9c5e = undefined;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x566cf967, Offset: 0x4758
// Size: 0x156
function private function_24b93802(var_f65b7f3e) {
    self endon(#"death", #"hash_fdbf10dbf063a82");
    var_81aa2f69 = var_f65b7f3e;
    for (s_next_pos = struct::get(var_f65b7f3e.target, "targetname"); true; s_next_pos = var_f65b7f3e) {
        n_dist = distance(s_next_pos.origin, var_81aa2f69.origin);
        n_time_travel = n_dist / 45;
        self moveto(s_next_pos.origin, n_time_travel);
        self rotateto(s_next_pos.angles, n_time_travel);
        wait n_time_travel;
        var_81aa2f69 = s_next_pos;
        if (isdefined(var_81aa2f69.target)) {
            s_next_pos = struct::get(var_81aa2f69.target, "targetname");
            continue;
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x6aa0dee1, Offset: 0x48b8
// Size: 0x200
function private function_e248ebae() {
    self endon(#"death", #"hash_300e9fed7925cd69");
    callback::on_ai_killed(&function_33350eb2);
    level waittill(#"hash_4e2f6e88e9985f10");
    level.var_28babbfc endon(#"death");
    level.var_28babbfc thread function_2c8ed6fe("in_gh_pa");
    level.var_28babbfc waittill(#"blast_attack");
    level.var_28babbfc notify(#"hash_585dd04498227242");
    level.var_28babbfc setgoal(level.var_28babbfc.origin);
    level.var_28babbfc clientfield::set("" + #"hash_65da20412fcaf97e", 0);
    level.var_28babbfc thread function_29eb2511();
    level.var_28babbfc waittill(#"hash_17de7292d988f537");
    level.var_28babbfc.var_c15e9c85 = 1;
    level.var_28babbfc thread function_1ddd68a8();
    var_4430fff1 = getent("pa_do_vol", "targetname");
    while (!level.var_28babbfc istouching(var_4430fff1)) {
        wait 1;
    }
    level notify(#"hash_361c36fab747c7f0");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0x55a782d, Offset: 0x4ac0
// Size: 0x294
function function_33350eb2(s_params) {
    if (!isdefined(level.var_28babbfc) && isplayer(s_params.eattacker) && (self zm_zonemgr::entity_in_zone("zone_infirmary") || self zm_zonemgr::entity_in_zone("zone_infirmary_roof"))) {
        level.var_28babbfc = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "gh_bm");
        while (!isdefined(level.var_28babbfc)) {
            waitframe(1);
            level.var_28babbfc = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "gh_bm");
        }
        level.var_28babbfc function_4d7812f4();
        level.var_28babbfc forceteleport(self.origin + (0, 0, 5), self.angles, 1, 1);
        level.var_28babbfc.script_noteworthy = "blast_attack_interactables";
        level.var_28babbfc thread function_57f4d0b1(s_params.eattacker, #"hash_fd8e78c22906fc1");
        waitframe(1);
        level notify(#"hash_4e2f6e88e9985f10");
        return;
    }
    if (isdefined(level.var_28babbfc) && isplayer(s_params.eattacker) && distance2d(self.origin, level.var_28babbfc.origin) < 600 && isdefined(level.var_28babbfc.var_c15e9c85) && level.var_28babbfc.var_c15e9c85) {
        self thread function_dd876e3c(level.var_28babbfc);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xded2d60b, Offset: 0x4d60
// Size: 0x8a
function private function_1358aae6() {
    self endon(#"death", #"hash_71716a8e79096aee");
    self.var_9f264d71 = 0;
    while (true) {
        s_result = self waittill(#"hash_7b36770a2988e5d1");
        self.var_9f264d71 += 15;
        self notify(#"hash_2499fc5cec93bec8");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x5add3f1d, Offset: 0x4df8
// Size: 0x138
function private function_1ddd68a8() {
    self endon(#"death", #"hash_71716a8e79096aee");
    self thread function_1358aae6();
    while (true) {
        while (self.var_9f264d71 > 0) {
            self.goalradius = 128;
            if (isalive(self.e_activator)) {
                self setgoal(self.e_activator);
            } else {
                self setgoal(self.origin);
            }
            wait 0.25;
            self.var_9f264d71 = math::clamp(self.var_9f264d71 - 0.25, 0, 300);
        }
        self setgoal(self.origin);
        s_result = self waittill(#"hash_2499fc5cec93bec8");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xb9405b42, Offset: 0x4f38
// Size: 0x14c
function private function_d0077d93(var_81aa2f69) {
    self endon(#"death");
    s_next_pos = struct::get(var_81aa2f69.target, "targetname");
    n_dist = distance(s_next_pos.origin, var_81aa2f69.origin);
    n_time_travel = n_dist / 45;
    self moveto(s_next_pos.origin, n_time_travel);
    self rotateto(s_next_pos.angles, n_time_travel);
    wait n_time_travel;
    self clientfield::set("" + #"hash_584f13d0c8662647", 0);
    self clientfield::set("" + #"hash_34562274d7e875a4", 1);
    self delete();
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xa551af65, Offset: 0x5090
// Size: 0x42e
function private function_9edd01e9() {
    self endoncallback(&function_d2ccd075, #"death", #"hash_300e9fed7925cd69");
    b_success = undefined;
    self thread function_6ceb431d();
    level waittill(#"hash_4e2f6e88e9985f10");
    waitframe(1);
    level.var_1a053705 waittill(#"hash_17de7292d988f537");
    level.var_1a053705 notify(#"hash_71716a8e79096aee");
    self thread function_7524af92();
    if (isdefined(level.var_1a053705.t_interact)) {
        level.var_1a053705.t_interact delete();
    }
    a_s_firewalls = struct::get_array("cellblocks_barrier_fx", "targetname");
    self thread function_f112f181(a_s_firewalls, "fxexp_flame_wall_door_glow_shower_cellblock");
    self thread function_5d17c7a0();
    level.var_1a053705 thread function_1cb09925();
    level.var_1a053705 val::reset(#"ai_ghost", "ignoreme");
    level.var_1a053705 val::reset(#"ai_ghost", "allowdeath");
    level.var_1a053705 setcandamage(1);
    level.var_1a053705 solid();
    if (!(isdefined(zm_ai_utility::is_zombie_target(level.var_1a053705)) && zm_ai_utility::is_zombie_target(level.var_1a053705))) {
        zm_ai_utility::make_zombie_target(level.var_1a053705);
    }
    level.var_1a053705 thread function_3c624016();
    s_result = level.var_1a053705 waittill(#"death", #"hash_6f435cd868870904");
    if (s_result._notify == #"hash_6f435cd868870904") {
        var_fa23ac71 = 1;
    } else {
        level.var_1a053705 thread function_48690dc8();
    }
    if (isdefined(level.var_1a053705)) {
        if (isdefined(zm_ai_utility::is_zombie_target(level.var_1a053705)) && zm_ai_utility::is_zombie_target(level.var_1a053705)) {
            zm_ai_utility::remove_zombie_target(level.var_1a053705);
        }
        var_3695ea28 = level.var_1a053705.origin;
    }
    self thread function_d2ccd075();
    if (isdefined(var_fa23ac71) && var_fa23ac71) {
        var_cbafe82b = level function_a4bafaf7(var_3695ea28);
    }
    if (isdefined(var_cbafe82b) && var_cbafe82b) {
        level thread function_b47cb025(#"hash_368df266f54ec3b1");
    }
    self notify(#"hash_300e9fed7925cd69", {#b_success:var_cbafe82b});
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xedfccb29, Offset: 0x54c8
// Size: 0x7c
function private function_d2ccd075(var_e34146dc) {
    if (isdefined(level.var_1a053705)) {
        level.var_1a053705 delete();
    }
    hidemiscmodels("rt_gh_sanim");
    exploder::stop_exploder("fxexp_riot_ghoul");
    exploder::stop_exploder("fxexp_riot_ghoul2");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x6a1b69ac, Offset: 0x5550
// Size: 0x56
function private function_7524af92() {
    var_bb4e86a9 = zombie_utility::get_current_zombie_count();
    if (var_bb4e86a9 + level.zombie_total < 4) {
        level.zombie_total += 5;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x7b647d02, Offset: 0x55b0
// Size: 0xdc
function private function_5d17c7a0() {
    showmiscmodels("rt_gh_sanim");
    exploder::exploder("fxexp_riot_ghoul");
    exploder::exploder("fxexp_riot_ghoul2");
    level thread function_22088c8(#"hash_72bb7bc935d4da67");
    self waittill(#"death", #"hash_300e9fed7925cd69");
    hidemiscmodels("rt_gh_sanim");
    exploder::stop_exploder("fxexp_riot_ghoul");
    exploder::stop_exploder("fxexp_riot_ghoul2");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x5da7ca88, Offset: 0x5698
// Size: 0xf0
function private function_3c624016() {
    self endon(#"death");
    var_c6145e32 = 10;
    while (isalive(self)) {
        s_result = self waittill(#"damage");
        n_percent = self.health / 800;
        n_blood = int(n_percent * 10);
        if (n_blood != var_c6145e32) {
            self clientfield::set("" + #"hash_3e506d7aedac6ae0", n_blood);
            var_c6145e32 = n_blood;
        }
        self function_156dcbd3();
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xa5b67a20, Offset: 0x5790
// Size: 0xf4
function private function_156dcbd3() {
    self endon(#"death");
    self setcandamage(0);
    var_cb2ae2a1 = 0;
    is_visible = 1;
    while (var_cb2ae2a1 < 7) {
        if (isdefined(is_visible) && is_visible) {
            self ghost();
            is_visible = 0;
        } else {
            self show();
            is_visible = 1;
        }
        var_cb2ae2a1++;
        wait 0.1;
    }
    self show();
    self setcandamage(1);
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 12, eflags: 0x0
// Checksum 0xa374a317, Offset: 0x5890
// Size: 0x98
function function_d3e7cee1(einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (self === level.var_1a053705 && isplayer(eattacker)) {
        return 0;
    }
    return -1;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xc4826009, Offset: 0x5930
// Size: 0x1de
function private function_1cb09925() {
    self endon(#"death");
    self.goalradius = 64;
    var_36421eb9 = struct::get_array("cellblocks_final_path", "script_noteworthy");
    var_81aa2f69 = arraygetclosest(self.origin, var_36421eb9);
    s_next_pos = struct::get(var_81aa2f69.target, "targetname");
    self setgoal(var_81aa2f69.origin);
    self waittill(#"goal");
    while (isdefined(s_next_pos)) {
        self setgoal(s_next_pos.origin);
        self waittill(#"goal");
        if (s_next_pos.script_string === "smoke") {
            s_next_pos thread function_2dc36159();
        } else if (s_next_pos.script_string === "brutus_sp") {
            level thread function_36bebd4();
        }
        var_81aa2f69 = s_next_pos;
        if (isdefined(var_81aa2f69.target)) {
            s_next_pos = struct::get(var_81aa2f69.target, "targetname");
            continue;
        }
        s_next_pos = undefined;
    }
    self notify(#"hash_6f435cd868870904");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x658f7b83, Offset: 0x5b18
// Size: 0x1cc
function private function_36bebd4() {
    s_brutus_location = struct::get("cel_bru_pos", "targetname");
    var_1cc0028e = struct::get(s_brutus_location.target, "targetname");
    if (level.brutus_count + 1 <= level.brutus_max_count) {
        ai_brutus = zombie_utility::spawn_zombie(level.var_20c2ed6c[0]);
        if (isalive(ai_brutus)) {
            ai_brutus endon(#"death");
            ai_brutus zombie_brutus_util::brutus_spawn(undefined, undefined, undefined, undefined, undefined);
            ai_brutus forceteleport(s_brutus_location.origin, s_brutus_location.angles);
            ai_brutus playsound(#"zmb_ai_brutus_spawn_2d");
            ai_brutus val::set(#"ai_brutus", "ignoreall", 1);
            ai_brutus setgoal(var_1cc0028e.origin);
            ai_brutus waittill(#"goal");
            ai_brutus val::reset(#"ai_brutus", "ignoreall");
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x98d4a37e, Offset: 0x5cf0
// Size: 0x13c
function private function_2dc36159() {
    if (math::cointoss()) {
        v_target_pos = (self.origin[0] + randomfloat(256), self.origin[1] + randomfloat(256), self.origin[2]);
        v_target_pos = getclosestpointonnavmesh(v_target_pos, 256, 16);
        if (isdefined(v_target_pos)) {
            mdl_pos = util::spawn_model("tag_origin", v_target_pos + (0, 0, 32));
            e_grenade = mdl_pos magicgrenadetype(getweapon(#"willy_pete"), v_target_pos, (0, 0, 0), 0.4);
            waitframe(1);
            mdl_pos delete();
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xc4662521, Offset: 0x5e38
// Size: 0x144
function private function_6ceb431d() {
    self endon(#"death", #"hash_300e9fed7925cd69");
    callback::on_ai_killed(&function_49111d6b);
    level waittill(#"hash_4e2f6e88e9985f10");
    level.var_1a053705 endon(#"death");
    level.var_1a053705 thread function_2c8ed6fe("ce_gh_pa");
    level.var_1a053705 waittill(#"blast_attack");
    level.var_1a053705 notify(#"hash_585dd04498227242");
    level.var_1a053705 setgoal(level.var_1a053705.origin);
    level.var_1a053705 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
    level.var_1a053705 thread function_29eb2511();
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0xc1a57698, Offset: 0x5f88
// Size: 0x1f8
function function_49111d6b(s_params) {
    if (!isdefined(level.var_1a053705) && isplayer(s_params.eattacker) && (self zm_zonemgr::entity_in_zone("zone_cafeteria") || self zm_zonemgr::entity_in_zone("zone_cafeteria_end"))) {
        callback::remove_on_ai_killed(&function_49111d6b);
        level.var_1a053705 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "cb_gh");
        while (!isdefined(level.var_1a053705)) {
            waitframe(1);
            level.var_1a053705 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "cb_gh");
        }
        level.var_1a053705 function_4d7812f4(0);
        level.var_1a053705 forceteleport(self.origin + (0, 0, 5), self.angles, 1, 1);
        level.var_1a053705.script_noteworthy = "blast_attack_interactables";
        level.var_1a053705 thread function_57f4d0b1(s_params.eattacker, #"hash_2ea20c8cd81b5464");
        level notify(#"hash_4e2f6e88e9985f10");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x5edf0723, Offset: 0x6188
// Size: 0x104
function private function_48690dc8() {
    foreach (e_player in level.activeplayers) {
        if (e_player zm_utility::is_player_looking_at(self.origin + (0, 0, 32))) {
            level thread function_22088c8(#"ghost_disappears", e_player);
        }
    }
    e_player = array::random(level.activeplayers);
    level thread function_22088c8(#"ghost_disappears", e_player);
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x9536ecf8, Offset: 0x6298
// Size: 0x4d6
function private function_b2ba4805() {
    self endoncallback(&function_16125636, #"death", #"hash_300e9fed7925cd69");
    b_success = undefined;
    self thread function_5190227();
    level waittill(#"hash_4e2f6e88e9985f10");
    waitframe(1);
    level.var_af446d50 waittill(#"hash_585dd04498227242");
    self thread function_e6ecede0(level.var_af446d50);
    s_result = self waittilltimeout(10, #"hash_754ca63bdd999035");
    if (s_result._notify == "timeout") {
        self notify(#"hash_141c4fe73e47836f");
    }
    level.var_af446d50 thread function_dee3dc63();
    level.var_af446d50 thread function_e518e4b6();
    level.var_af446d50 waittill(#"hash_57648a286155c924");
    array::thread_all(level.players, &function_a37b79dc, level.var_af446d50, #"hash_7cf90fc327de893e");
    level.var_af446d50 thread function_52cfbebb();
    level.var_af446d50 waittill(#"hash_42d705f0ff5334bb");
    level.var_af446d50 ai::set_behavior_attribute("run", 0);
    level thread function_6d5efa04("door_model_west_side_exterior_to_new_industries");
    if (level.var_af446d50 clientfield::get("" + #"hash_65da20412fcaf97e")) {
        level.var_af446d50 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
    }
    level scene::add_scene_func(#"aib_vign_zm_mob_spoon_ghost_stab", &function_4dc17f49, "init");
    level thread scene::init(#"aib_vign_zm_mob_spoon_ghost_stab");
    level.var_af446d50 thread function_8fc3bba4(self);
    var_6d3f23ed = getentarray("zm_spinning_trap", "script_noteworthy");
    array::thread_all(var_6d3f23ed, &function_b6ec2309, self);
    s_result = level.var_af446d50 waittill(#"death", #"hash_436fe34b5e12d99a");
    var_3695ea28 = level.var_af446d50.origin;
    if (s_result._notify == "death") {
        var_fa23ac71 = 1;
        level thread scene::stop(#"aib_vign_zm_mob_spoon_ghost_stab");
    } else {
        e_player = array::random(level.activeplayers);
        level thread function_22088c8(#"hash_7ab135537c096a5a", e_player);
    }
    level thread function_16125636();
    if (isdefined(var_fa23ac71) && var_fa23ac71) {
        var_cbafe82b = level function_a4bafaf7(var_3695ea28);
    }
    if (isdefined(var_cbafe82b) && var_cbafe82b) {
        level thread function_b47cb025(#"hash_53aafd7783e33981");
    }
    self notify(#"hash_300e9fed7925cd69", {#b_success:var_cbafe82b});
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xff47ec4a, Offset: 0x6778
// Size: 0xdc
function private function_e6ecede0(ai_ghost) {
    self endon(#"death", #"hash_300e9fed7925cd69", #"hash_141c4fe73e47836f");
    foreach (e_player in level.activeplayers) {
        if (e_player util::is_looking_at(ai_ghost getcentroid())) {
            self notify(#"hash_754ca63bdd999035");
            return;
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xf44e558, Offset: 0x6860
// Size: 0x174
function private function_5190227() {
    self endon(#"death", #"hash_300e9fed7925cd69");
    callback::on_ai_killed(&function_1e5e0d4b);
    level waittill(#"hash_4e2f6e88e9985f10");
    level.var_af446d50 endon(#"death");
    level.var_af446d50 thread function_2c8ed6fe("ni_gh_pa");
    level.var_af446d50 waittill(#"blast_attack");
    level.var_af446d50 notify(#"hash_585dd04498227242");
    level.var_af446d50 setgoal(level.var_af446d50.origin);
    level.var_af446d50 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
    level.var_af446d50.var_78113eef = 1;
    level.var_9cdf0277 = level.var_af446d50;
    level.var_af446d50 solid();
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0x6cadcd4d, Offset: 0x69e0
// Size: 0x210
function function_1e5e0d4b(s_params) {
    if (!isdefined(level.var_af446d50) && isplayer(s_params.eattacker) && (self zm_zonemgr::entity_in_zone("zone_library") || self zm_zonemgr::entity_in_zone("zone_start"))) {
        callback::remove_on_ai_killed(&function_1e5e0d4b);
        level.var_af446d50 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "ni_gh");
        while (!isdefined(level.var_af446d50)) {
            waitframe(1);
            level.var_af446d50 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "ni_gh");
        }
        level.var_af446d50 function_4d7812f4(0);
        level.var_af446d50 forceteleport(self.origin + (0, 0, 5), self.angles, 1, 1);
        level.var_af446d50.script_noteworthy = "blast_attack_interactables";
        level.var_af446d50 thread function_57f4d0b1(s_params.eattacker, #"hash_1d191ca6765471c6");
        level.var_af446d50.var_36dc13fb = 1;
        level notify(#"hash_4e2f6e88e9985f10");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x63662aee, Offset: 0x6bf8
// Size: 0x33c
function private function_e518e4b6() {
    self endon(#"death");
    var_48e8db75 = struct::get_array("ni_sp_pos", "targetname");
    v_pos = undefined;
    array::randomize(var_48e8db75);
    while (!isdefined(v_pos)) {
        foreach (var_a10e64d5 in var_48e8db75) {
            v_pos = getclosestpointonnavmesh(var_a10e64d5.origin, 128, 16);
            v_angles = var_a10e64d5.angles;
            if (isdefined(v_pos)) {
                path_success = self findpath(self.origin, v_pos, 1, 0);
                if (path_success) {
                    break;
                } else {
                    /#
                        iprintln("<dev string:x30>" + var_a10e64d5.origin);
                    #/
                }
                continue;
            }
            /#
                iprintln("<dev string:x55>" + var_a10e64d5.origin);
            #/
        }
    }
    level.var_b6deb404 = util::spawn_model(#"wpn_t8_zm_spoon_world", v_pos, v_angles);
    self.goalradius = 64;
    while (distance2d(self.origin, v_pos) > 80) {
        self setgoal(v_pos);
        self waittilltimeout(6, #"goal");
    }
    self notify(#"hash_57648a286155c924");
    self scene::play(#"aib_vign_zm_mob_ghost_spoon_pickup", self);
    if (isdefined(level.var_b6deb404)) {
        level.var_b6deb404 delete();
    }
    self.mdl_spoon = util::spawn_model(#"wpn_t8_zm_spoon_world", self gettagorigin("tag_weapon_right"), self gettagangles("tag_weapon_right"));
    self.mdl_spoon linkto(self, "tag_weapon_right");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x2b2743a5, Offset: 0x6f40
// Size: 0x1d8
function private function_dee3dc63() {
    self endon(#"death", #"hash_3cef5405e0643505", #"hash_436fe34b5e12d99a");
    self thread function_c3ff018b();
    wait 10;
    level.var_af446d50.var_78113eef = undefined;
    level.var_9cdf0277 = undefined;
    level.var_af446d50 notsolid();
    level.var_af446d50 clientfield::set("" + #"hash_65da20412fcaf97e", 1);
    while (true) {
        level.var_af446d50 waittill(#"blast_attack");
        level.var_af446d50.var_78113eef = 1;
        level.var_9cdf0277 = level.var_af446d50;
        level.var_af446d50 solid();
        level.var_af446d50 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
        wait 10;
        level.var_af446d50.var_78113eef = undefined;
        level.var_9cdf0277 = undefined;
        level.var_af446d50 notsolid();
        level.var_af446d50 clientfield::set("" + #"hash_65da20412fcaf97e", 1);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x2b23d365, Offset: 0x7120
// Size: 0x2dc
function private function_c3ff018b() {
    self endon(#"death");
    if (level.players.size == 1) {
        var_708eb51a = 60;
    } else {
        var_708eb51a = 100;
    }
    var_2ee6ebc0 = 0;
    var_77e6b54f = undefined;
    var_9dfa8aa4 = 10;
    while (var_2ee6ebc0 <= var_708eb51a) {
        if (isdefined(self.var_78113eef) && self.var_78113eef && isdefined(self.var_65bbe67a) && self.var_65bbe67a) {
            var_2ee6ebc0++;
        }
        var_83c20410 = (var_708eb51a - var_2ee6ebc0) / var_708eb51a;
        var_de74d592 = int(var_83c20410 * 10);
        if (var_de74d592 != var_9dfa8aa4) {
            self clientfield::set("" + #"hash_3e506d7aedac6ae0", var_de74d592);
            var_9dfa8aa4 = var_de74d592;
        }
        /#
            if (var_83c20410 == 0.25 || var_83c20410 == 0.5 || var_83c20410 == 0.75 && var_77e6b54f !== var_83c20410) {
                var_77e6b54f = var_83c20410;
                iprintlnbold("<dev string:x74>" + var_83c20410);
            }
        #/
        wait 1;
    }
    level.var_af446d50 notify(#"hash_3cef5405e0643505");
    waitframe(1);
    if (level.var_af446d50 clientfield::get("" + #"hash_65da20412fcaf97e")) {
        level.var_af446d50 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
    }
    /#
        iprintlnbold("<dev string:x8f>");
    #/
    level.var_af446d50.var_78113eef = undefined;
    level.var_9cdf0277 = undefined;
    level.var_af446d50.var_36dc13fb = undefined;
    level.var_af446d50 solid();
    level.var_af446d50 ai::set_behavior_attribute("run", 1);
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x789ce058, Offset: 0x7408
// Size: 0xd6
function private function_52cfbebb() {
    self endon(#"death");
    var_52d1ba0e = struct::get("ni_gh_fi", "targetname");
    self.goalradius = 64;
    while (distance2d(self.origin, var_52d1ba0e.origin) > 80) {
        self setgoal(var_52d1ba0e.origin);
        self waittilltimeout(30, #"goal");
    }
    self notify(#"hash_42d705f0ff5334bb");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xd195e64, Offset: 0x74e8
// Size: 0x19c
function private function_8fc3bba4(var_a57f187f) {
    self endon(#"death");
    var_a57f187f endon(#"hash_300e9fed7925cd69");
    var_f649a6a0 = struct::get("gh_vi_pos", "targetname");
    self.goalradius = 24;
    while (distance2d(self.origin, var_f649a6a0.origin) > self.goalradius) {
        self setgoal(var_f649a6a0.origin, 1);
        self waittilltimeout(15, #"goal");
    }
    self notify(#"hash_436fe34b5e12d99a");
    if (isalive(level.var_af446d50) && level.var_af446d50 clientfield::get("" + #"hash_65da20412fcaf97e")) {
        level.var_af446d50 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
    }
    level thread scene::play(#"aib_vign_zm_mob_spoon_ghost_stab");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xe33a9fc0, Offset: 0x7690
// Size: 0x1d8
function private function_b6ec2309(var_a57f187f) {
    level.var_af446d50 endon(#"death");
    var_a57f187f endon(#"hash_300e9fed7925cd69");
    while (true) {
        s_result = self waittill(#"trigger");
        if (isdefined(self._trap_in_use) && self._trap_in_use && s_result.activator === level.var_af446d50 && !(isdefined(level.var_af446d50.var_36dc13fb) && level.var_af446d50.var_36dc13fb)) {
            level.var_af446d50 val::reset(#"ai_ghost", "allowdeath");
            level.var_af446d50 setcandamage(1);
            level.var_af446d50 clientfield::set("" + #"hash_7a8eab5597b25400", 1);
            playsoundatposition("zmb_spoon_ghost_annihilate", level.var_af446d50.origin);
            gibserverutils::annihilate(level.var_af446d50);
            level.var_af446d50 dodamage(level.var_af446d50.health + 1000, self.origin, undefined, self);
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x8b309dd5, Offset: 0x7870
// Size: 0xbc
function private function_16125636(var_e34146dc) {
    if (isdefined(level.var_af446d50)) {
        if (isdefined(level.var_af446d50.mdl_spoon)) {
            level.var_af446d50.mdl_spoon delete();
        }
        level.var_af446d50 delete();
    }
    if (isdefined(level.var_30f3dd21)) {
        level.var_30f3dd21 delete();
    }
    if (isdefined(level.var_b6deb404)) {
        level.var_b6deb404 delete();
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0x6d423ac1, Offset: 0x7938
// Size: 0x74
function function_4dc17f49(a_ents) {
    if (isdefined(a_ents[#"ni_gh_vi"])) {
        level.var_30f3dd21 = a_ents[#"ni_gh_vi"];
        level.var_30f3dd21 clientfield::set("" + #"hash_34562274d7e875a4", 1);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x50936a6e, Offset: 0x79b8
// Size: 0x6d6
function private function_28c76e8b() {
    self endoncallback(&function_acd52573, #"death", #"hash_300e9fed7925cd69");
    b_success = undefined;
    var_94830e0d = undefined;
    a_str_zones = array("cellblock_shower");
    while (!(isdefined(var_94830e0d) && var_94830e0d)) {
        foreach (e_player in level.players) {
            if (isdefined(e_player zm_zonemgr::is_player_in_zone(a_str_zones)) && e_player zm_zonemgr::is_player_in_zone(a_str_zones)) {
                var_94830e0d = 1;
                break;
            }
        }
        waitframe(1);
    }
    s_scene = struct::get("sh_b_scene", "targetname");
    s_scene scene::add_scene_func(s_scene.scriptbundlename, &function_f9fb4ce, "init");
    s_scene thread scene::init(#"aib_vign_zm_mob_banjo_ghost");
    level thread function_22088c8(#"hash_1e0663f4102106fa", level.var_3d440933.e_activator);
    waitframe(1);
    level.var_3d440933 waittill(#"hash_17de7292d988f537");
    level.var_3d440933.t_interact setinvisibletoall();
    level.var_91f6a140 clientfield::set("" + #"hash_34562274d7e875a4", 2);
    /#
        iprintlnbold("<dev string:xb1>");
    #/
    exploder::exploder("fxexp_shower_ambient_ground_fog");
    a_s_firewalls = struct::get_array("sh_ba_fx", "targetname");
    self thread function_f112f181(a_s_firewalls, "fxexp_flame_wall_door_glow_shower");
    wait 2;
    if (level.players.size == 1) {
        self thread function_63ad9cf6();
    }
    s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_of");
    level.var_3d440933.t_interact setvisibletoall();
    level.var_3d440933.e_activator = undefined;
    level.var_3d440933 waittill(#"hash_17de7292d988f537");
    level.var_3d440933.t_interact setinvisibletoall();
    self thread function_f28388e4(0, level.var_3d440933.e_activator);
    level thread function_22088c8(#"hash_46252c9e0b200ae6", level.var_3d440933.e_activator);
    self thread function_9332e966(s_scene);
    self thread function_1e698a16();
    s_result = self waittill(#"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
    if (s_result._notify == #"hash_4636f041ae52f0fa") {
        s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_out");
        var_410fdabb = scene::function_3dd10dad(#"aib_vign_zm_mob_banjo_ghost", "shot_out");
        wait var_410fdabb;
    } else {
        /#
            iprintlnbold("<dev string:xca>");
        #/
        level.var_3d440933.t_interact setvisibletoplayer(level.var_3d440933.e_activator);
        level.var_3d440933 waittill(#"hash_17de7292d988f537");
        self thread function_f28388e4(1);
        var_3695ea28 = level.var_3d440933.origin;
        s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_out");
        var_410fdabb = scene::function_3dd10dad(#"aib_vign_zm_mob_banjo_ghost", "shot_out");
        wait var_410fdabb;
        var_fa23ac71 = 1;
    }
    exploder::stop_exploder("fxexp_shower_ambient_ground_fog");
    if (isdefined(var_fa23ac71) && var_fa23ac71) {
        var_cbafe82b = level function_a4bafaf7(var_3695ea28);
    }
    if (isdefined(var_cbafe82b) && var_cbafe82b) {
        level thread function_b47cb025(#"hash_51300ea0974da947", level.var_3d440933.e_activator);
    }
    self thread function_acd52573();
    self notify(#"hash_300e9fed7925cd69", {#b_success:var_cbafe82b});
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0xdeccb627, Offset: 0x8098
// Size: 0xfc
function function_f9fb4ce(a_ents) {
    if (isdefined(a_ents[#"gh_sh"])) {
        level.var_3d440933 = a_ents[#"gh_sh"];
        level.var_3d440933 thread function_29eb2511();
        level.var_3d440933 clientfield::set("" + #"hash_34562274d7e875a4", 1);
    }
    if (isdefined(a_ents[#"gh_ba"])) {
        level.var_91f6a140 = a_ents[#"gh_ba"];
        level.var_91f6a140 clientfield::set("" + #"hash_34562274d7e875a4", 1);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x506824cf, Offset: 0x81a0
// Size: 0x228
function private function_9332e966(s_scene) {
    self endon(#"death", #"hash_300e9fed7925cd69", #"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
    s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_wa");
    while (true) {
        level.var_3d440933.t_interact setvisibletoplayer(level.var_3d440933.e_activator);
        self thread function_75b9926e(level.var_3d440933.e_activator);
        level.var_3d440933 waittill(#"hash_17de7292d988f537");
        self thread function_f28388e4(1);
        level.var_3d440933.e_activator notify(#"hash_c5c509724d92ec4");
        s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_of");
        level.var_3d440933.t_interact setvisibletoall();
        level.var_3d440933.e_activator = undefined;
        level.var_3d440933 waittill(#"hash_17de7292d988f537");
        level.var_3d440933.t_interact setinvisibletoall();
        self thread function_f28388e4(0, level.var_3d440933.e_activator);
        s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_wa");
        wait 2;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xcd56c6f4, Offset: 0x83d0
// Size: 0xce
function private function_acd52573(var_e34146dc) {
    if (isdefined(level.var_3d440933)) {
        if (isdefined(level.var_3d440933.t_interact)) {
            level.var_3d440933.t_interact delete();
        }
        level.var_3d440933 delete();
    }
    if (isdefined(level.var_91f6a140)) {
        level.var_91f6a140 delete();
    }
    if (isdefined(level.var_73839cc5)) {
        level.var_73839cc5 delete();
    }
    self notify(#"hash_7953672ffc47be3");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xe3c31928, Offset: 0x84a8
// Size: 0xe8
function private function_75b9926e(e_player) {
    e_player endon(#"death", #"hash_c5c509724d92ec4");
    self endon(#"death", #"hash_300e9fed7925cd69", #"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
    self thread function_765ffa3c(e_player);
    wait 60;
    while (isalive(e_player)) {
        e_player dodamage(10, e_player.origin);
        wait 1;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0xa35f12b, Offset: 0x8598
// Size: 0xdc
function function_765ffa3c(e_player) {
    e_player endon(#"hash_c5c509724d92ec4");
    self endon(#"death", #"hash_300e9fed7925cd69", #"hash_7953672ffc47be3");
    e_player waittill(#"death", #"player_downed");
    self notify(#"hash_4636f041ae52f0fa");
    e_speaker = zm_utility::get_closest_player(e_player.origin);
    level thread function_22088c8(#"hash_26aa170c4122be2b", e_speaker);
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xbc14c05c, Offset: 0x8680
// Size: 0x24a
function private function_1e698a16() {
    self endon(#"death", #"hash_300e9fed7925cd69");
    var_d624813c = struct::get_array("showers_kill_pos", "targetname");
    callback::on_ai_killed(&function_56fbbf40);
    level.var_558e9909 = 0;
    while (true) {
        var_fccb0f9c = array::random(var_d624813c);
        var_b4caad4a = util::spawn_model("tag_origin", var_fccb0f9c.origin, var_fccb0f9c.angles);
        self thread function_d479fb97();
        self thread function_3aa3c496(var_b4caad4a);
        var_26c935c2 = randomfloatrange(15, 45);
        s_result = self waittilltimeout(var_26c935c2, #"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
        var_b4caad4a clientfield::set("" + #"hash_a51ae59006ab41b", 0);
        var_b4caad4a delete();
        level.var_2e979f31 delete();
        if (s_result._notify == #"hash_7953672ffc47be3" || s_result._notify == #"hash_4636f041ae52f0fa") {
            callback::remove_on_ai_killed(&function_56fbbf40);
            level.var_558e9909 = undefined;
            return;
        }
        self notify(#"hash_60f9171b687c9d06");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x3fd50774, Offset: 0x88d8
// Size: 0x41c
function private function_3aa3c496(var_b4caad4a) {
    self endon(#"death", #"hash_60f9171b687c9d06", #"hash_4636f041ae52f0fa", #"hash_300e9fed7925cd69");
    level.var_2e979f31 = spawn("trigger_radius_new", var_b4caad4a.origin, (512 | 1) + 2, 80, 64);
    var_b4caad4a clientfield::set("" + #"hash_a51ae59006ab41b", 1);
    while (isdefined(var_b4caad4a)) {
        var_66ab4eac = 0;
        foreach (e_player in level.activeplayers) {
            if (e_player istouching(level.var_2e979f31)) {
                var_66ab4eac++;
            }
        }
        switch (var_66ab4eac) {
        case 0:
            if (var_b4caad4a clientfield::get("" + #"hash_a51ae59006ab41b") !== 1) {
                var_b4caad4a clientfield::set("" + #"hash_a51ae59006ab41b", 1);
                level.var_2e979f31.maxs = (80, 80, 64);
            }
            break;
        case 1:
            if (var_b4caad4a clientfield::get("" + #"hash_a51ae59006ab41b") !== 2) {
                var_b4caad4a clientfield::set("" + #"hash_a51ae59006ab41b", 2);
                level.var_2e979f31.maxs = (98, 98, 64);
            }
            break;
        case 2:
            if (var_b4caad4a clientfield::get("" + #"hash_a51ae59006ab41b") !== 3) {
                var_b4caad4a clientfield::set("" + #"hash_a51ae59006ab41b", 3);
                level.var_2e979f31.maxs = (112, 112, 64);
            }
            break;
        case 3:
        case 4:
            if (var_b4caad4a clientfield::get("" + #"hash_a51ae59006ab41b") !== 4) {
                var_b4caad4a clientfield::set("" + #"hash_a51ae59006ab41b", 4);
                level.var_2e979f31.maxs = (128, 128, 64);
            }
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x3dabd384, Offset: 0x8d00
// Size: 0x1dc
function private function_d479fb97() {
    self endon(#"death", #"hash_60f9171b687c9d06", #"hash_4636f041ae52f0fa", #"hash_300e9fed7925cd69");
    var_c6145e32 = 2;
    while (level.var_558e9909 < 20) {
        n_percent = level.var_558e9909 / 20;
        n_blood = int(n_percent * 10);
        if (n_blood != var_c6145e32 && n_blood > 2) {
            level.var_91f6a140 clientfield::set("" + #"hash_34562274d7e875a4", n_blood);
            var_c6145e32 = n_blood;
            if (isdefined(level.var_73839cc5)) {
                level.var_73839cc5 clientfield::set("" + #"hash_34562274d7e875a4", n_blood);
            }
        }
        wait 0.2;
    }
    self notify(#"hash_7953672ffc47be3");
    level.var_91f6a140 clientfield::set("" + #"hash_34562274d7e875a4", 10);
    if (isdefined(level.var_73839cc5)) {
        level.var_73839cc5 clientfield::set("" + #"hash_34562274d7e875a4", 10);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0xccc476f4, Offset: 0x8ee8
// Size: 0xf0
function function_56fbbf40(s_params) {
    if (isplayer(s_params.eattacker) && isdefined(level.var_2e979f31) && s_params.eattacker istouching(level.var_2e979f31)) {
        if (isdefined(level.var_3d440933.e_activator) && isdefined(level.var_2e979f31) && level.var_3d440933.e_activator istouching(level.var_2e979f31)) {
            self thread function_dd876e3c(level.var_3d440933.e_activator, "tag_weapon_right");
            level.var_558e9909++;
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 2, eflags: 0x4
// Checksum 0x789f7821, Offset: 0x8fe0
// Size: 0x1cc
function private function_f28388e4(var_168e6657 = 1, e_player) {
    self endon(#"death", #"hash_60f9171b687c9d06", #"hash_4636f041ae52f0fa", #"hash_300e9fed7925cd69");
    if (var_168e6657) {
        if (isdefined(level.var_73839cc5)) {
            level.var_73839cc5 unlink();
            level.var_73839cc5 delete();
        }
        level.var_91f6a140 show();
        return;
    }
    level.var_91f6a140 ghost();
    if (isdefined(e_player)) {
        level.var_73839cc5 = util::spawn_model(#"hash_122bc018037432b0", e_player gettagorigin("tag_stowed_back"), e_player gettagangles("tag_stowed_back"));
        level.var_73839cc5 linkto(e_player, "tag_stowed_back", (30, -2, -5), (0, 90, -90));
        level.var_73839cc5 clientfield::set("" + #"hash_34562274d7e875a4", 1);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x604b2ab6, Offset: 0x91b8
// Size: 0x1ce
function private function_63ad9cf6() {
    var_f97c401 = "cellblock_shower";
    a_str_active_zones = zm_cleanup::get_adjacencies_to_zone(var_f97c401);
    arrayremovevalue(a_str_active_zones, var_f97c401);
    zone_shower = level.zones[var_f97c401];
    a_str_zones = arraycopy(a_str_active_zones);
    foreach (str_zones in a_str_zones) {
        if (zone_shower.adjacent_zones[str_zones].is_connected) {
            zone_shower.adjacent_zones[str_zones].is_connected = 0;
            continue;
        }
        arrayremovevalue(a_str_active_zones, str_zones);
    }
    self waittill(#"death", #"hash_300e9fed7925cd69");
    foreach (str_zones in a_str_active_zones) {
        zone_shower.adjacent_zones[str_zones].is_connected = 1;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x877262b1, Offset: 0x9390
// Size: 0x486
function private function_2894448f() {
    self endoncallback(&function_52675c5d, #"death", #"hash_300e9fed7925cd69");
    b_success = undefined;
    var_25ea69d9 = undefined;
    a_str_zones = array("zone_powerhouse");
    while (!(isdefined(var_25ea69d9) && var_25ea69d9)) {
        foreach (e_player in level.players) {
            if (isdefined(e_player zm_zonemgr::is_player_in_zone(a_str_zones)) && e_player zm_zonemgr::is_player_in_zone(a_str_zones)) {
                var_25ea69d9 = 1;
                break;
            }
        }
        waitframe(1);
    }
    self thread function_5fa19275();
    self function_cb924125(e_player);
    var_343a6583 = struct::get("ph_gen_pos", "targetname");
    self thread function_1193afb3(var_343a6583);
    self waittill(#"hash_47037a033334904");
    self thread function_1ee937a();
    var_12e362d9 = self waittill(#"hash_2877e7dda4d090c8");
    e_generator = getent("b64_si_gen", "script_noteworthy");
    e_generator setmodel(e_generator.model_on);
    e_generator thread scene::play(e_generator.bundle, "ON", e_generator);
    exploder::exploder("lgtexp_building64_power_on");
    if (!(isdefined(var_12e362d9.b_success) && var_12e362d9.b_success)) {
        self notify(#"hash_300e9fed7925cd69", {#b_success:b_success});
        self thread function_52675c5d();
        return;
    }
    self thread function_85610010();
    s_result = self waittill(#"punchcard_pickup");
    level thread function_22088c8(#"hash_57a7dd2d1b78a952", s_result.activator);
    self thread function_f7c9ef2();
    self waittill(#"hash_1548855706869d2f");
    self thread function_6cd27f6d();
    self thread function_9097569();
    var_fa23ac71 = self function_249912ca();
    self notify(#"hash_3e30564346f7cd94");
    var_3695ea28 = level.var_170a2567.origin;
    self thread function_52675c5d();
    if (isdefined(var_fa23ac71) && var_fa23ac71) {
        var_cbafe82b = level function_a4bafaf7(var_3695ea28);
    }
    if (isdefined(var_cbafe82b) && var_cbafe82b) {
        level thread function_b47cb025(#"hash_34aad6dd5eebdb0b", e_player);
    }
    self notify(#"hash_300e9fed7925cd69", {#b_success:var_cbafe82b});
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x80ffc529, Offset: 0x9820
// Size: 0x174
function private function_cb924125(e_player) {
    self endon(#"death", #"hash_300e9fed7925cd69");
    if (!isdefined(level.var_170a2567)) {
        var_8ff99dc7 = struct::get("ph_gh_sp", "targetname");
        level.var_170a2567 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "ph_gh", var_8ff99dc7);
        while (!isdefined(level.var_170a2567)) {
            waitframe(1);
            level.var_170a2567 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "ph_gh", var_8ff99dc7);
        }
    }
    level.var_170a2567 function_4d7812f4();
    level.var_170a2567 thread function_57f4d0b1(e_player, #"hash_4c753651e8079572");
    self thread function_db711360("ph_gh_pa");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xcc565716, Offset: 0x99a0
// Size: 0x5aa
function private function_db711360(var_a57e1939) {
    level.var_170a2567 endon(#"death", #"hash_585dd04498227242");
    self endon(#"death", #"hash_300e9fed7925cd69");
    level.var_170a2567.goalradius = 16;
    var_a7ddf137 = struct::get_array(var_a57e1939, "script_noteworthy");
    level.var_170a2567 waittilltimeout(20, #"goal");
    var_a1bcb429 = 1;
    for (s_next_pos = array::random(var_a7ddf137); !(isdefined(level.var_170a2567.var_4cdf220d) && level.var_170a2567.var_4cdf220d); s_next_pos = struct::get(var_81aa2f69.target, "targetname")) {
        level.var_170a2567 setgoal(s_next_pos.origin);
        level.var_170a2567 waittilltimeout(20, #"goal");
        if (isdefined(level.var_170a2567.b_visible) && level.var_170a2567.b_visible && isinarray(level.var_59be4a46, s_next_pos.script_int)) {
            mdl_lever = getent("flicker_" + s_next_pos.script_int + 1, "targetname");
            mdl_lever scene::play(#"aib_vign_zm_mob_power_ghost_opperate_success", array(level.var_170a2567, mdl_lever));
            arrayremovevalue(level.var_59be4a46, s_next_pos.script_int);
            level.var_170a2567 notify(#"hash_6f38117315565110", {#b_success:1});
            self thread function_e0f78c67(s_next_pos.script_int);
        } else {
            s_next_pos scene::play(#"aib_vign_zm_mob_power_ghost_opperate_fail", level.var_170a2567);
            if (isdefined(level.var_170a2567.b_visible) && level.var_170a2567.b_visible && isinarray(level.var_59be4a46, s_next_pos.script_int)) {
                mdl_lever = getent("flicker_" + s_next_pos.script_int + 1, "targetname");
                mdl_lever scene::play(#"aib_vign_zm_mob_power_ghost_opperate_success", array(level.var_170a2567, mdl_lever));
                arrayremovevalue(level.var_59be4a46, s_next_pos.script_int);
                level.var_170a2567 notify(#"hash_6f38117315565110", {#b_success:1});
                self thread function_e0f78c67(s_next_pos.script_int);
            } else if (isdefined(level.var_170a2567.b_visible) && level.var_170a2567.b_visible) {
                level.var_170a2567 notify(#"hash_6f38117315565110", {#b_success:0});
            }
        }
        wait 1;
        var_81aa2f69 = s_next_pos;
        if (var_a1bcb429 && isdefined(var_81aa2f69.target)) {
            s_next_pos = struct::get(var_81aa2f69.target, "targetname");
            continue;
        }
        if (var_a1bcb429 && !isdefined(var_81aa2f69.target)) {
            var_a1bcb429 = 0;
            s_next_pos = struct::get(var_81aa2f69.targetname, "target");
            continue;
        }
        if (!var_a1bcb429 && var_81aa2f69.script_int != 0) {
            s_next_pos = struct::get(var_81aa2f69.targetname, "target");
            continue;
        }
        if (!var_a1bcb429 && var_81aa2f69.script_int == 0) {
            var_a1bcb429 = 1;
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xff59b13, Offset: 0x9f58
// Size: 0x248
function private function_6cd27f6d() {
    exploder::exploder("lgtexp_comm_monitors_on");
    level.var_ed991e20 = getentarray("jcc_01", "targetname");
    foreach (mdl_monitor in level.var_ed991e20) {
        var_454244b1 = mdl_monitor.origin + anglestoforward(mdl_monitor.angles) * -15;
        mdl_monitor.t_interact = spawn("trigger_radius_use", var_454244b1, 0, 64, 64);
        mdl_monitor.t_interact sethintstring(#"");
        mdl_monitor.t_interact setcursorhint("HINT_NOICON");
        mdl_monitor.t_interact triggerignoreteam();
        mdl_monitor thread function_3e6c3571(self);
    }
    self waittill(#"death", #"hash_300e9fed7925cd69");
    foreach (mdl_monitor in level.var_ed991e20) {
        mdl_monitor setmodel(#"p8_zm_esc_comm_monitor_sml_01_screen_off");
        mdl_monitor.t_interact delete();
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x8bc65211, Offset: 0xa1a8
// Size: 0x264
function private function_3e6c3571(var_a57f187f) {
    var_a57f187f endon(#"death", #"hash_300e9fed7925cd69");
    switch (self.script_int) {
    case 0:
        var_7ee0394d = #"hash_7b807c00f606fd42";
        var_a67c5467 = #"hash_7b807600f606f310";
        break;
    case 1:
        var_7ee0394d = #"hash_7b807b00f606fb8f";
        var_a67c5467 = #"hash_7b808500f6070c8d";
        break;
    case 2:
        var_7ee0394d = #"hash_7b807a00f606f9dc";
        var_a67c5467 = #"hash_7b808400f6070ada";
        break;
    case 3:
        var_7ee0394d = #"hash_7b807900f606f829";
        var_a67c5467 = #"hash_7b7cf700f603e56c";
        break;
    case 4:
        var_7ee0394d = #"hash_7b807800f606f676";
        var_a67c5467 = #"hash_7b7cf800f603e71f";
        break;
    case 5:
        var_7ee0394d = #"hash_7b807700f606f4c3";
        var_a67c5467 = #"hash_7b7cf900f603e8d2";
        break;
    }
    self setmodel(var_7ee0394d);
    var_24f1396a = var_a67c5467;
    while (isdefined(self.t_interact)) {
        s_result = self.t_interact waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            self setmodel(var_24f1396a);
            if (var_24f1396a == var_a67c5467) {
                var_24f1396a = var_7ee0394d;
            } else {
                var_24f1396a = var_a67c5467;
            }
        }
        wait 0.25;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x47c6eaf8, Offset: 0xa418
// Size: 0x1ca
function private function_249912ca() {
    self endon(#"death", #"hash_300e9fed7925cd69");
    level.var_170a2567 endon(#"death");
    level.var_170a2567.script_noteworthy = "blast_attack_interactables";
    while (!(isdefined(level.var_170a2567.var_4cdf220d) && level.var_170a2567.var_4cdf220d)) {
        level.var_170a2567 waittill(#"blast_attack");
        level.var_170a2567 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
        level.var_170a2567.b_visible = 1;
        s_result = level.var_170a2567 waittill(#"hash_6f38117315565110");
        level.var_170a2567 clientfield::set("" + #"hash_65da20412fcaf97e", 1);
        level.var_170a2567.b_visible = undefined;
        if (!(isdefined(s_result.b_success) && s_result.b_success)) {
            level.var_170a2567.var_4cdf220d = 1;
            return false;
        }
        if (level.var_59be4a46.size <= 0) {
            level.var_170a2567.var_4cdf220d = 1;
            return true;
        }
    }
    return false;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0xc5415d5f, Offset: 0xa5f0
// Size: 0x1ec
function function_e0f78c67(n_num) {
    level.var_170a2567 endon(#"death", #"hash_585dd04498227242");
    self endon(#"death", #"hash_300e9fed7925cd69");
    switch (n_num) {
    case 0:
        str_exploder = "fxexp_power_house_machine_00";
        var_946c2012 = "fxexp_power_house_machine_00_green";
        break;
    case 1:
        str_exploder = "fxexp_power_house_machine_02";
        var_946c2012 = "fxexp_power_house_machine_02_green";
        break;
    case 2:
        str_exploder = "fxexp_power_house_machine_05";
        var_946c2012 = "fxexp_power_house_machine_05_green";
        break;
    case 3:
        str_exploder = "fxexp_power_house_machine_07";
        var_946c2012 = "fxexp_power_house_machine_07_green";
        break;
    case 4:
        str_exploder = "fxexp_power_house_machine_09";
        var_946c2012 = "fxexp_power_house_machine_09_green";
        break;
    case 5:
        str_exploder = "fxexp_power_house_machine_11";
        var_946c2012 = "fxexp_power_house_machine_11_green";
        break;
    }
    exploder::stop_exploder(str_exploder);
    exploder::exploder(var_946c2012);
    wait 3;
    exploder::exploder(str_exploder);
    exploder::stop_exploder(var_946c2012);
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x847e13c2, Offset: 0xa7e8
// Size: 0x2ce
function private function_1193afb3(s_interact) {
    self endon(#"death", #"hash_300e9fed7925cd69");
    e_generator = getent("b64_si_gen", "script_noteworthy");
    e_generator setmodel(e_generator.model_off);
    e_generator thread scene::play(e_generator.bundle, "OFF", e_generator);
    s_interact.var_a5fb2c3e = util::spawn_model("tag_origin", s_interact.origin, s_interact.angles);
    s_interact.var_a5fb2c3e clientfield::set("" + #"hash_64f2dd36b17bf17", 1);
    s_interact.t_interact = spawn("trigger_radius_use", s_interact.origin, 0, 128, 64);
    s_interact.t_interact sethintstring(#"");
    s_interact.t_interact setcursorhint("HINT_NOICON");
    s_interact.t_interact triggerignoreteam();
    s_interact.t_interact setvisibletoall();
    while (true) {
        s_result = s_interact.t_interact waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            s_interact.e_activator = s_result.activator;
            break;
        }
    }
    s_interact.t_interact delete();
    s_interact.var_a5fb2c3e clientfield::set("" + #"hash_64f2dd36b17bf17", 0);
    s_interact.var_a5fb2c3e delete();
    exploder::stop_exploder("lgtexp_building64_power_on");
    self notify(#"hash_47037a033334904");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x6ef703e1, Offset: 0xaac0
// Size: 0x5c0
function private function_1ee937a() {
    self endon(#"death", #"hash_300e9fed7925cd69");
    b_success = undefined;
    if (!isdefined(level.var_6d4ee5ba)) {
        level.var_6d4ee5ba = 5;
    }
    if (!isdefined(level.var_37b34838)) {
        level function_1cd5ba2c();
    }
    b_success = self function_66523dec();
    self notify(#"hash_3e30564346f7cd94");
    self notify(#"hash_2877e7dda4d090c8", {#b_success:b_success});
    if (isdefined(b_success) && b_success) {
        level.var_37b34838 = array::randomize(level.var_37b34838);
        level.var_59be4a46 = array(level.var_37b34838[0].script_int, level.var_37b34838[1].script_int, level.var_37b34838[2].script_int);
        var_bb376203 = [];
        foreach (var_ba98e418 in level.var_37b34838) {
            if (isinarray(level.var_59be4a46, var_ba98e418.script_int)) {
                if (!isdefined(var_bb376203)) {
                    var_bb376203 = [];
                } else if (!isarray(var_bb376203)) {
                    var_bb376203 = array(var_bb376203);
                }
                if (!isinarray(var_bb376203, var_ba98e418.mdl_light)) {
                    var_bb376203[var_bb376203.size] = var_ba98e418.mdl_light;
                }
                var_ba98e418.mdl_light setmodel(#"p8_zm_zod_light_bulb_01_on");
                var_ba98e418.mdl_light clientfield::set("" + #"hash_119729072e708651", 1);
                continue;
            }
            var_ba98e418.mdl_light setmodel(#"p8_zm_zod_light_bulb_01_off");
            var_ba98e418.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
        }
        wait 6;
        var_cb2ae2a1 = 0;
        var_82ce5e80 = 1;
        while (var_cb2ae2a1 < 7) {
            foreach (mdl_light in var_bb376203) {
                if (isdefined(var_82ce5e80) && var_82ce5e80) {
                    mdl_light setmodel(#"p8_zm_zod_light_bulb_01_off");
                    var_ba98e418.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
                    var_82ce5e80 = 0;
                    continue;
                }
                mdl_light setmodel(#"p8_zm_zod_light_bulb_01_on");
                var_ba98e418.mdl_light clientfield::set("" + #"hash_119729072e708651", 1);
                var_82ce5e80 = 1;
            }
            var_cb2ae2a1++;
            wait 0.2;
        }
    }
    level.var_88d48b22 = undefined;
    level.var_191b8e6a = undefined;
    if (isdefined(level.var_37b34838)) {
        foreach (var_ba98e418 in level.var_37b34838) {
            if (isdefined(var_ba98e418.mdl_light)) {
                var_ba98e418.mdl_light setmodel(#"p8_zm_zod_light_bulb_01_off");
                var_ba98e418.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
            }
            if (isdefined(var_ba98e418.t_interact)) {
                var_ba98e418.t_interact setinvisibletoall();
            }
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x0
// Checksum 0x23a9b06, Offset: 0xb088
// Size: 0x326
function function_1cd5ba2c() {
    level.var_37b34838 = struct::get_array("64_sm_pos", "targetname");
    foreach (var_ba98e418 in level.var_37b34838) {
        var_ba98e418.mdl_symbol = util::spawn_model(var_ba98e418.model, var_ba98e418.origin, var_ba98e418.angles);
        var_ba98e418.mdl_light = getent(var_ba98e418.target, "targetname");
        var_ba98e418.t_interact = spawn("trigger_radius_use", var_ba98e418.origin, 0, 64, 64);
        var_ba98e418.t_interact sethintstring(#"");
        var_ba98e418.t_interact setcursorhint("HINT_NOICON");
        var_ba98e418.t_interact triggerignoreteam();
        var_ba98e418.t_interact setinvisibletoall();
    }
    level.var_210dc63b = [];
    var_dc9ab481 = struct::get_array("ph_sm_pos", "targetname");
    foreach (var_d2e77fe in var_dc9ab481) {
        mdl_symbol = util::spawn_model(var_d2e77fe.model, var_d2e77fe.origin, var_d2e77fe.angles);
        if (!isdefined(level.var_210dc63b)) {
            level.var_210dc63b = [];
        } else if (!isarray(level.var_210dc63b)) {
            level.var_210dc63b = array(level.var_210dc63b);
        }
        if (!isinarray(level.var_210dc63b, mdl_symbol)) {
            level.var_210dc63b[level.var_210dc63b.size] = mdl_symbol;
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x543ab89, Offset: 0xb3b8
// Size: 0x630
function private function_66523dec() {
    self endon(#"death", #"hash_300e9fed7925cd69");
    level.var_191b8e6a = function_47d419a1();
    var_596f3725 = 1;
    b_trace_passed = 0;
    n_start_time = gettime();
    for (n_total_time = 0; !(isdefined(b_trace_passed) && b_trace_passed) & n_total_time < 6.1; n_total_time = (n_current_time - n_start_time) / 1000) {
        foreach (e_player in level.players) {
            if (isdefined(level.var_191b8e6a[0].mdl_symbol sightconetrace(e_player geteye(), e_player, vectornormalize(e_player getplayerangles()), 30)) && level.var_191b8e6a[0].mdl_symbol sightconetrace(e_player geteye(), e_player, vectornormalize(e_player getplayerangles()), 30)) {
                b_trace_passed = 1;
                break;
            }
        }
        waitframe(1);
        n_current_time = gettime();
    }
    self thread function_9097569();
    while (var_596f3725 <= level.var_6d4ee5ba) {
        for (i = 0; i < var_596f3725; i++) {
            level.var_191b8e6a[i].mdl_light setmodel(#"p8_zm_zod_light_bulb_01_on");
            level.var_191b8e6a[i].mdl_light clientfield::set("" + #"hash_119729072e708651", 1);
            wait 3.9;
            level.var_191b8e6a[i].mdl_light setmodel(#"p8_zm_zod_light_bulb_01_off");
            level.var_191b8e6a[i].mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
            if (var_596f3725 > 1) {
                wait 1.3;
            }
        }
        foreach (var_ba98e418 in level.var_37b34838) {
            var_ba98e418.t_interact setvisibletoall();
        }
        level.var_88d48b22 = 0;
        array::thread_all(level.var_37b34838, &function_5851a2f4, self, var_596f3725);
        s_result = self waittilltimeout(30, #"hash_34486fb413da1672");
        foreach (var_ba98e418 in level.var_37b34838) {
            var_ba98e418.t_interact setinvisibletoall();
        }
        if (!(isdefined(s_result.b_success) && s_result.b_success)) {
            if (isdefined(s_result.e_player)) {
                s_result.e_player playlocalsound(level.zmb_laugh_alias);
            }
            return false;
        }
        foreach (var_ba98e418 in level.var_37b34838) {
            if (isdefined(var_ba98e418.mdl_light)) {
                var_ba98e418.mdl_light setmodel(#"p8_zm_zod_light_bulb_01_off");
                var_ba98e418.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
            }
        }
        var_596f3725++;
        level.var_191b8e6a = function_47d419a1();
    }
    playsoundatposition(#"zmb_cha_ching", (0, 0, 0));
    return true;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 2, eflags: 0x4
// Checksum 0x403a6e5e, Offset: 0xb9f0
// Size: 0x1f8
function private function_5851a2f4(var_a57f187f, var_596f3725) {
    var_a57f187f endon(#"death", #"hash_300e9fed7925cd69", #"hash_34486fb413da1672");
    while (level.var_88d48b22 < var_596f3725) {
        s_result = self.t_interact waittill(#"trigger");
        self.mdl_light setmodel(#"p8_zm_zod_light_bulb_01_on");
        self.mdl_light clientfield::set("" + #"hash_119729072e708651", 1);
        wait 1;
        self.mdl_light setmodel(#"p8_zm_zod_light_bulb_01_off");
        self.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
        wait 1;
        if (self !== level.var_191b8e6a[level.var_88d48b22]) {
            var_a57f187f notify(#"hash_34486fb413da1672", {#b_success:0, #e_player:s_result.activator});
        }
        level.var_88d48b22++;
    }
    var_a57f187f notify(#"hash_34486fb413da1672", {#b_success:1, #e_player:s_result.activator});
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x707cadad, Offset: 0xbbf0
// Size: 0xc4
function private function_47d419a1() {
    var_191b8e6a = [];
    for (i = 0; i < level.var_6d4ee5ba; i++) {
        s_pos[i] = array::random(level.var_37b34838);
        if (!isdefined(var_191b8e6a)) {
            var_191b8e6a = [];
        } else if (!isarray(var_191b8e6a)) {
            var_191b8e6a = array(var_191b8e6a);
        }
        var_191b8e6a[var_191b8e6a.size] = s_pos[i];
    }
    return var_191b8e6a;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xea59ed66, Offset: 0xbcc0
// Size: 0x2cc
function private function_52675c5d(var_e34146dc) {
    if (isdefined(level.var_170a2567)) {
        level.var_170a2567 notify(#"hash_585dd04498227242");
        level.var_170a2567 delete();
    }
    var_343a6583 = struct::get("ph_gen_pos", "targetname");
    if (isdefined(var_343a6583.t_interact)) {
        var_343a6583.t_interact delete();
    }
    if (isdefined(var_343a6583.var_a5fb2c3e)) {
        var_343a6583.var_a5fb2c3e delete();
    }
    level.var_88d48b22 = undefined;
    level.var_191b8e6a = undefined;
    if (isdefined(level.var_37b34838)) {
        foreach (var_ba98e418 in level.var_37b34838) {
            if (isdefined(var_ba98e418.mdl_light)) {
                var_ba98e418.mdl_light setmodel(#"p8_zm_zod_light_bulb_01_off");
                var_ba98e418.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
            }
            if (isdefined(var_ba98e418.t_interact)) {
                var_ba98e418.t_interact setinvisibletoall();
            }
        }
    }
    var_21245fd0 = struct::get("ph_pc_pos", "targetname");
    if (isdefined(var_21245fd0.var_fb308adf)) {
        var_21245fd0.var_fb308adf delete();
    }
    if (isdefined(var_21245fd0.t_interact)) {
        var_21245fd0.t_interact delete();
    }
    var_7f3a250d = getent("md_te_mi", "targetname");
    if (isdefined(var_7f3a250d)) {
        if (isdefined(var_7f3a250d.t_interact)) {
            var_7f3a250d.t_interact delete();
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xed6a147b, Offset: 0xbf98
// Size: 0x1de
function private function_85610010() {
    self endon(#"death", #"hash_300e9fed7925cd69");
    var_21245fd0 = struct::get("ph_pc_pos", "targetname");
    var_21245fd0.var_fb308adf = util::spawn_model(var_21245fd0.model, var_21245fd0.origin, var_21245fd0.angles);
    var_21245fd0.t_interact = spawn("trigger_radius_use", var_21245fd0.origin, 0, 64, 64);
    var_21245fd0.t_interact sethintstring(#"");
    var_21245fd0.t_interact setcursorhint("HINT_NOICON");
    var_21245fd0.t_interact triggerignoreteam();
    while (true) {
        s_result = var_21245fd0.t_interact waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            var_21245fd0.var_fb308adf delete();
            break;
        }
    }
    self notify(#"punchcard_pickup", {#activator:s_result.activator});
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x6ac5d32f, Offset: 0xc180
// Size: 0x1c0
function private function_f7c9ef2() {
    self endon(#"death", #"hash_300e9fed7925cd69");
    var_7f3a250d = getent("md_te_mi", "targetname");
    var_454244b1 = var_7f3a250d.origin + anglestoforward(var_7f3a250d.angles) * -15 + (0, 0, 5);
    var_7f3a250d.t_interact = spawn("trigger_radius_use", var_454244b1, 0, 64, 64);
    var_7f3a250d.t_interact sethintstring(#"");
    var_7f3a250d.t_interact setcursorhint("HINT_NOICON");
    var_7f3a250d.t_interact triggerignoreteam();
    while (isdefined(var_7f3a250d.t_interact)) {
        s_result = var_7f3a250d.t_interact waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            self notify(#"hash_1548855706869d2f");
            var_7f3a250d.t_interact delete();
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x72a255e8, Offset: 0xc348
// Size: 0x210
function private function_5fa19275() {
    level scene::add_scene_func(#"p8_fxanim_zm_escape_pigeon_standing_01", &function_b099f3fb, "play");
    level scene::add_scene_func(#"p8_fxanim_zm_escape_pigeon_standing_02", &function_b099f3fb, "play");
    level scene::add_scene_func(#"p8_fxanim_zm_escape_pigeon_standing_03", &function_b099f3fb, "play");
    level scene::add_scene_func(#"p8_fxanim_zm_escape_pigeon_standing_04", &function_b099f3fb, "play");
    a_s_pigeons = struct::get_array("ph_gh_pi", "targetname");
    foreach (s_pigeon in a_s_pigeons) {
        s_pigeon thread scene::play();
    }
    self waittill(#"death", #"hash_300e9fed7925cd69");
    foreach (s_pigeon in a_s_pigeons) {
        s_pigeon thread scene::stop();
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0x2fbbb0ef, Offset: 0xc560
// Size: 0xd8
function function_b099f3fb(a_ents) {
    foreach (e_ent in a_ents) {
        e_ent clientfield::set("" + #"hash_34562274d7e875a4", 1);
        e_ent clientfield::set("" + #"hash_65da20412fcaf97e", 1);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x31b4be23, Offset: 0xc640
// Size: 0xda
function private function_9097569() {
    self endon(#"death", #"hash_300e9fed7925cd69", #"hash_3e30564346f7cd94");
    if (level.players.size == 1) {
        return;
    }
    while (true) {
        wait randomfloatrange(3, 15);
        if (zombie_utility::get_current_zombie_count() < zombie_utility::get_zombie_var(#"zombie_max_ai")) {
            ai_dog = zombie_utility::spawn_zombie(level.dog_spawners[0]);
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 2, eflags: 0x4
// Checksum 0xc87df3cc, Offset: 0xc728
// Size: 0x44a
function private function_22088c8(var_68f2b527, e_player) {
    level endon(#"hash_11fb44a7b531b27d", #"hash_54eae43edf7f08cd");
    while (!isalive(e_player)) {
        waitframe(1);
        e_player = array::random(level.activeplayers);
    }
    switch (var_68f2b527) {
    case #"hash_57e9c23bed1bd753":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_ghost_spot_first_0";
        break;
    case #"ghost_disappears":
        n_rand = randomintrange(1, 5);
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_ghost_gone_" + n_rand + "_" + n_rand - 1;
        break;
    case #"hash_2ea20c8cd81b5464":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_ghost_spot_cell_0";
        break;
    case #"hash_72bb7bc935d4da67":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_ghost_riot_0";
        break;
    case #"hash_fd8e78c22906fc1":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_ghost_docks_0";
        break;
    case #"hash_115ac6d40d4cc85b":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_boat_react_0";
        break;
    case #"hash_1d191ca6765471c6":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_ghost_indu_0";
        break;
    case #"hash_7cf90fc327de893e":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_ghost_spoon_0";
        break;
    case #"hash_7ab135537c096a5a":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_ghost_murder_0";
        break;
    case #"hash_4c753651e8079572":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_ghost_power_0";
        break;
    case #"hash_487ac9fba78b1604":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_bout_react_0";
        break;
    case #"hash_57a7dd2d1b78a952":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_pcard_pickup_0";
        break;
    case #"hash_1e0663f4102106fa":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_ghost_shower_0";
        break;
    case #"hash_46252c9e0b200ae6":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_banjo_pickup_0";
        break;
    case #"hash_26aa170c4122be2b":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_banjo_down_0";
        break;
    }
    for (b_said = undefined; !(isdefined(b_said) && b_said); b_said = e_player zm_vo::vo_say(str_vo_line, 0, 1, 9999)) {
        zm_vo::function_2426269b(e_player.origin, 512);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 2, eflags: 0x4
// Checksum 0xa3c97dab, Offset: 0xcb80
// Size: 0x48a
function private function_b47cb025(var_68f2b527, e_player) {
    level endon(#"hash_11fb44a7b531b27d", #"hash_54eae43edf7f08cd");
    while (!isalive(e_player)) {
        waitframe(1);
        e_player = array::random(level.activeplayers);
    }
    e_richtofen = paschal::function_6a0e1ac2();
    switch (var_68f2b527) {
    case #"hash_368df266f54ec3b1":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_cell_port_comp_" + e_player.characterindex - 5;
        var_c0fa0da7 = "vox_stuh_m_quest_cell_port_comp_4";
        var_b0fc6533 = "vox_plr_5_m_quest_cell_port_comp_5";
        break;
    case #"hash_7d360b71501ba662":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_dock_port_comp_" + e_player.characterindex - 5;
        var_c0fa0da7 = "vox_stuh_m_quest_dock_port_comp_4";
        var_b0fc6533 = "vox_plr_5_m_quest_dock_port_comp_5";
        break;
    case #"hash_53aafd7783e33981":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_indu_port_comp_" + e_player.characterindex - 5;
        var_c0fa0da7 = "vox_stuh_m_quest_indu_port_comp_4";
        var_b0fc6533 = "vox_plr_5_m_quest_indu_port_comp_5";
        break;
    case #"hash_34aad6dd5eebdb0b":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_power_port_comp_" + e_player.characterindex - 5;
        var_c0fa0da7 = "vox_stuh_m_quest_power_port_comp_4";
        var_b0fc6533 = "vox_plr_5_m_quest_power_port_comp_5";
        break;
    case #"hash_51300ea0974da947":
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_shower_port_comp_" + e_player.characterindex - 5;
        var_c0fa0da7 = "vox_stuh_m_quest_shower_port_comp_1_0";
        var_b0fc6533 = "vox_plr_5_m_quest_shower_port_comp_2_0";
        break;
    case #"hash_334295910a49036e":
        str_suffix = 1;
        if (e_player === e_richtofen) {
            str_suffix = 0;
        }
        str_vo_line = "vox_plr_" + e_player.characterindex + "_m_quest_all_port_comp_" + str_suffix;
        var_c0fa0da7 = "vox_stuh_m_quest_all_port_comp_2";
        var_b0fc6533 = "vox_plr_5_m_quest_all_port_comp_3";
        break;
    }
    for (b_said = undefined; !(isdefined(b_said) && b_said); b_said = e_player zm_vo::vo_say(str_vo_line, 0, 1, 9999)) {
        zm_vo::function_2426269b(e_player.origin, 512);
    }
    if (!isdefined(e_richtofen) || !isalive(e_richtofen) || !(isdefined(e_richtofen.var_94b48394) && e_richtofen.var_94b48394)) {
        return;
    }
    e_richtofen playsoundtoplayer(var_c0fa0da7, e_richtofen);
    wait soundgetplaybacktime(var_c0fa0da7) * 0.001;
    for (var_de15c4ec = undefined; !(isdefined(var_de15c4ec) && var_de15c4ec) && isalive(e_richtofen); var_de15c4ec = e_richtofen zm_vo::vo_say(var_b0fc6533)) {
        zm_vo::function_2426269b(e_richtofen.origin, 512);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 2, eflags: 0x4
// Checksum 0x7822b266, Offset: 0xd018
// Size: 0x132
function private function_a37b79dc(e_ghost, var_68f2b527) {
    e_ghost endon(#"death", #"ghost_seen");
    self endon(#"disconnect");
    while (true) {
        if (self zm_utility::is_player_looking_at(e_ghost getcentroid()) && self adsbuttonpressed()) {
            if (!(isdefined(level.var_5adaf763) && level.var_5adaf763)) {
                level.var_5adaf763 = 1;
                level function_22088c8(#"hash_57e9c23bed1bd753", self);
                wait 3;
            }
            level thread function_22088c8(var_68f2b527, self);
            e_ghost notify(#"ghost_seen");
        }
        waitframe(1);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0x4d54f2f8, Offset: 0xd158
// Size: 0x120
function private function_ddf76a13() {
    self endon(#"death");
    self.t_interact = spawn("trigger_radius_use", self.origin, 0, 94, 64);
    self.t_interact sethintstring(#"");
    self.t_interact setcursorhint("HINT_NOICON");
    self.t_interact triggerignoreteam();
    while (isdefined(self.t_interact)) {
        s_result = self.t_interact waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            self notify(#"hash_1f3cf68a268a10f1");
            self.t_interact delete();
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xffd0f2fb, Offset: 0xd280
// Size: 0x194
function private function_4d7812f4(var_b76b97d7 = 1) {
    if (var_b76b97d7) {
        self clientfield::set("" + #"hash_34562274d7e875a4", 1);
    } else {
        self clientfield::set("" + #"hash_3e506d7aedac6ae0", 10);
    }
    self setteam(util::get_enemy_team(level.zombie_team));
    self.health = 800;
    self val::set(#"ai_ghost", "ignoreme", 1);
    self val::set(#"ai_ghost", "ignoreall", 1);
    self val::set(#"ai_ghost", "allowdeath", 0);
    self setcandamage(0);
    self.b_ignore_cleanup = 1;
    self.var_e1e2f768 = &function_3d7fa675;
    self notsolid();
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 2, eflags: 0x4
// Checksum 0x682ec1be, Offset: 0xd420
// Size: 0x74
function private function_57f4d0b1(e_attacker, var_68f2b527) {
    self clientfield::set("" + #"hash_65da20412fcaf97e", 1);
    array::thread_all(level.players, &function_a37b79dc, self, var_68f2b527);
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x1d30cdcd, Offset: 0xd4a0
// Size: 0x1d2
function private function_2c8ed6fe(var_a57e1939) {
    self endon(#"death", #"hash_585dd04498227242");
    var_a7ddf137 = struct::get_array(var_a57e1939, "script_noteworthy");
    var_81aa2f69 = arraygetclosest(self.origin, var_a7ddf137);
    s_next_pos = struct::get(var_81aa2f69.target, "targetname");
    self.goalradius = 64;
    v_pos = getclosestpointonnavmesh(var_81aa2f69.origin, 128, 16);
    assert(isdefined(v_pos), "<dev string:xe5>" + var_81aa2f69.origin);
    self setgoal(v_pos);
    self waittilltimeout(20, #"goal");
    while (true) {
        self setgoal(s_next_pos.origin);
        self waittilltimeout(20, #"goal");
        var_81aa2f69 = s_next_pos;
        if (isdefined(var_81aa2f69.target)) {
            s_next_pos = struct::get(var_81aa2f69.target, "targetname");
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x4
// Checksum 0xc968c23c, Offset: 0xd680
// Size: 0x1be
function private function_29eb2511() {
    self endon(#"death", #"hash_71716a8e79096aee");
    self.t_interact = spawn("trigger_radius_use", self.origin + anglestoforward(self.angles) * 5 + (0, 0, 5), 0, 80, 64);
    self.t_interact enablelinkto();
    self.t_interact linkto(self);
    self.t_interact sethintstring(#"");
    self.t_interact setcursorhint("HINT_NOICON");
    self.t_interact triggerignoreteam();
    self.t_interact setvisibletoall();
    self.t_interact endon(#"death");
    while (true) {
        s_result = self.t_interact waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            self notify(#"hash_17de7292d988f537");
            self.e_activator = s_result.activator;
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 2, eflags: 0x4
// Checksum 0xa3e78ccf, Offset: 0xd848
// Size: 0x1c8
function private function_f112f181(a_s_firewalls, str_exploder) {
    var_58e90f8 = (0, 0, 48);
    foreach (s_firewall in a_s_firewalls) {
        s_firewall.var_44febfef = util::spawn_model("collision_player_wall_128x128x10", s_firewall.origin + var_58e90f8, s_firewall.angles);
        s_firewall.var_44febfef ghost();
    }
    if (isdefined(str_exploder)) {
        exploder::exploder(str_exploder);
    }
    self waittill(#"death", #"hash_300e9fed7925cd69");
    if (isdefined(str_exploder)) {
        exploder::stop_exploder(str_exploder);
    }
    foreach (s_firewall in a_s_firewalls) {
        if (isdefined(s_firewall.var_44febfef)) {
            s_firewall.var_44febfef delete();
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x9b75b77f, Offset: 0xda18
// Size: 0x2a6
function private function_3d7fa675(e_player) {
    self notify(#"hash_3f91506396266ee6");
    self endon(#"hash_3f91506396266ee6");
    e_player endon(#"disconnect");
    if (!isalive(self) || isdefined(self.var_65bbe67a) && self.var_65bbe67a || isdefined(self.aat_turned) && self.aat_turned || !(isdefined(self.var_78113eef) && self.var_78113eef)) {
        return;
    }
    self.var_65bbe67a = 1;
    self ai::stun();
    self.instakill_func = &function_847b41da;
    if (!self clientfield::get("zombie_spectral_key_stun")) {
        var_382c276e = e_player getentitynumber();
        self clientfield::set("zombie_spectral_key_stun", var_382c276e + 1);
        e_player clientfield::set("spectral_key_beam_flash", 2);
    }
    while (e_player.var_2aeb2774 === self && isalive(self) && isdefined(self.var_78113eef) && self.var_78113eef) {
        waitframe(1);
    }
    var_621a0307 = e_player clientfield::get("spectral_key_beam_flash");
    if (e_player attackbuttonpressed() && var_621a0307 === 2) {
        e_player clientfield::set("spectral_key_beam_flash", 1);
    }
    if (isalive(self)) {
        if (self clientfield::get("zombie_spectral_key_stun")) {
            self clientfield::set("zombie_spectral_key_stun", 0);
        }
        self.var_65bbe67a = 0;
        self ai::clear_stun();
        self.instakill_func = undefined;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 3, eflags: 0x4
// Checksum 0xc3c391f6, Offset: 0xdcc8
// Size: 0x6e
function private function_847b41da(e_player, mod, shitloc) {
    w_current = e_player getcurrentweapon();
    if (w_current === level.var_b258bbfd || w_current === level.var_42c2d7ca) {
        return true;
    }
    return false;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 2, eflags: 0x4
// Checksum 0x6d35a3fd, Offset: 0xdd40
// Size: 0x2b4
function private function_dd876e3c(var_68d6713f, str_tag = "j_spinelower") {
    var_68d6713f endon(#"death", #"hash_71716a8e79096aee");
    v_pos = self getcentroid();
    var_b44c4d3d = util::spawn_model("tag_origin", v_pos + (0, 0, 12), self.angles);
    var_b44c4d3d clientfield::set("spectral_key_essence", 1);
    n_dist = distance(var_b44c4d3d.origin, var_68d6713f gettagorigin(str_tag));
    n_move_time = n_dist / 800;
    n_dist_sq = distance2dsquared(var_b44c4d3d.origin, var_68d6713f gettagorigin(str_tag));
    n_start_time = gettime();
    n_total_time = 0;
    while (n_dist_sq > 576 && isalive(var_68d6713f)) {
        var_b44c4d3d moveto(var_68d6713f gettagorigin(str_tag), n_move_time);
        wait 0.1;
        if (isalive(var_68d6713f)) {
            n_current_time = gettime();
            n_total_time = (n_current_time - n_start_time) / 1000;
            n_move_time = var_68d6713f zm_weap_spectral_shield::function_a12ca473(var_b44c4d3d, n_total_time);
            if (n_move_time == 0) {
                break;
            }
            n_dist_sq = distance2dsquared(var_b44c4d3d.origin, var_68d6713f geteye());
        }
    }
    var_b44c4d3d clientfield::set("spectral_key_essence", 0);
    wait 0.5;
    var_68d6713f notify(#"hash_7b36770a2988e5d1");
    var_b44c4d3d delete();
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x334f2375, Offset: 0xe000
// Size: 0xda
function private function_a4bafaf7(var_3695ea28) {
    if (!isdefined(var_3695ea28)) {
        return 0;
    }
    var_8cf442cf = getclosestpointonnavmesh(var_3695ea28, 128, 16);
    if (isdefined(var_8cf442cf)) {
        var_3695ea28 = var_8cf442cf;
        var_8cf442cf = groundtrace(var_3695ea28 + (0, 0, 100), var_3695ea28 + (0, 0, -1000), 0, undefined, 0)[#"position"];
        if (isdefined(var_8cf442cf)) {
            var_3695ea28 = var_8cf442cf;
        }
    }
    b_success = level function_a8b84638(var_3695ea28);
    return b_success;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xf425cc7e, Offset: 0xe0e8
// Size: 0x2c6
function private function_a8b84638(v_pos) {
    mdl_orb = util::spawn_model(#"p8_zm_esc_orb_red_small", v_pos + (0, 0, 5));
    mdl_orb setscale(5);
    mdl_orb.t_interact = spawn("trigger_radius_use", v_pos + (0, 0, 20), 0, 64, 64);
    mdl_orb.t_interact sethintstring(#"");
    mdl_orb.t_interact setcursorhint("HINT_NOICON");
    mdl_orb.t_interact triggerignoreteam();
    mdl_orb thread function_51007efc();
    while (isdefined(mdl_orb)) {
        s_result = mdl_orb.t_interact waittill(#"trigger", #"hash_27669b352d06dead");
        if (s_result._notify == #"hash_27669b352d06dead") {
            playfx(level._effect[#"powerup_grabbed_red"], mdl_orb.origin);
            mdl_orb.t_interact delete();
            mdl_orb delete();
            return 0;
        }
        if (isplayer(s_result.activator) && s_result._notify == "trigger") {
            playfx(level._effect[#"powerup_grabbed_red"], mdl_orb.origin);
            mdl_orb.t_interact delete();
            mdl_orb delete();
            s_result.activator thread zm_audio::create_and_play_dialog("component_pickup", "generic");
            return 1;
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x0
// Checksum 0xda44cc0e, Offset: 0xe3b8
// Size: 0xcc
function function_51007efc() {
    self endon(#"death");
    wait 60;
    for (i = 0; i < 40; i++) {
        if (i % 2) {
            self ghost();
        } else {
            self show();
        }
        if (i < 15) {
            wait 0.5;
            continue;
        }
        if (i < 25) {
            wait 0.25;
            continue;
        }
        wait 0.1;
    }
    self.t_interact notify(#"hash_27669b352d06dead");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x14287ac3, Offset: 0xe490
// Size: 0x122
function private function_6d5efa04(str_door_name) {
    a_e_zombie_doors = getentarray(str_door_name, "target");
    foreach (zombie_door in a_e_zombie_doors) {
        if (isdefined(zombie_door.b_opened) && zombie_door.b_opened) {
            continue;
        }
        zombie_door notify(#"trigger", {#activator:zombie_door, #is_forced:1});
        zombie_door.script_flag_wait = undefined;
        zombie_door notify(#"power_on");
        zombie_door.b_opened = 1;
    }
}

/#

    // Namespace namespace_8adb45e8/namespace_8adb45e8
    // Params 0, eflags: 0x0
    // Checksum 0x7f206067, Offset: 0xe5c0
    // Size: 0x194
    function function_5a5c83a0() {
        zm_devgui::add_custom_devgui_callback(&function_5bd66a97);
        adddebugcommand("<dev string:x10e>");
        adddebugcommand("<dev string:x17d>");
        adddebugcommand("<dev string:x1fe>");
        adddebugcommand("<dev string:x275>");
        adddebugcommand("<dev string:x2e8>");
        adddebugcommand("<dev string:x363>");
        adddebugcommand("<dev string:x3ce>");
        adddebugcommand("<dev string:x44b>");
        adddebugcommand("<dev string:x4be>");
        adddebugcommand("<dev string:x52d>");
        adddebugcommand("<dev string:x5a4>");
        adddebugcommand("<dev string:x618>");
        adddebugcommand("<dev string:x692>");
        adddebugcommand("<dev string:x702>");
        adddebugcommand("<dev string:x76c>");
    }

    // Namespace namespace_8adb45e8/namespace_8adb45e8
    // Params 1, eflags: 0x0
    // Checksum 0x76617c06, Offset: 0xe760
    // Size: 0x2ea
    function function_5bd66a97(cmd) {
        switch (cmd) {
        case #"hash_77f372679d07a739":
            level.var_2d5907f7 = "<dev string:x7d6>";
            break;
        case #"hash_439f7c3b2be3e69e":
            level.var_2d5907f7 = "<dev string:x7dc>";
            break;
        case #"hash_4c0666160f60f30c":
            level.var_2d5907f7 = "<dev string:x7eb>";
            break;
        case #"hash_18772c2e191751b2":
            level.var_2d5907f7 = "<dev string:x7f5>";
            break;
        case #"hash_476f76510ea19e0a":
            level.var_2d5907f7 = "<dev string:x7fd>";
            break;
        case #"hash_7993d72e5b3831ee":
            level.var_2a952da3 = 1;
            level.var_2d5907f7 = "<dev string:x7d6>";
            break;
        case #"hash_619ec063638bb2df":
            level.var_2a952da3 = 1;
            level.var_2d5907f7 = "<dev string:x7dc>";
            break;
        case #"hash_63836a8684b4a3db":
            level.var_2a952da3 = 1;
            level.var_2d5907f7 = "<dev string:x7eb>";
            break;
        case #"hash_6efe06e0e34fcda1":
            level.var_2a952da3 = 1;
            level.var_2d5907f7 = "<dev string:x7f5>";
            break;
        case #"hash_55764ba6b85e2f4d":
            level.var_2a952da3 = 1;
            level.var_2d5907f7 = "<dev string:x7fd>";
            break;
        case #"hash_18be8ae474605ed0":
            level notify(#"hash_1a286cacd101f4eb", {#b_success:0});
            break;
        case #"hash_58ae202f026c337":
            level notify(#"hash_1a286cacd101f4eb", {#b_success:1});
            break;
        case #"hash_6499ce5666508b":
            level.var_15211139 = 1;
            break;
        case #"hash_70db80c9c71f4e66":
            level.var_6d4ee5ba = 1;
            break;
        case #"hash_70db7ec9c71f4b00":
            level.var_6d4ee5ba = 3;
            break;
        }
    }

    // Namespace namespace_8adb45e8/namespace_8adb45e8
    // Params 0, eflags: 0x4
    // Checksum 0xaaf75adf, Offset: 0xea58
    // Size: 0xb6
    function private function_682454da() {
        self endon(#"death", #"hash_300e9fed7925cd69");
        s_result = level waittill(#"hash_1a286cacd101f4eb");
        if (isdefined(s_result.b_success) && s_result.b_success) {
            self notify(#"hash_300e9fed7925cd69", {#b_success:1});
            return;
        }
        self notify(#"hash_300e9fed7925cd69", {#b_success:0});
    }

#/
