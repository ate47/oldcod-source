#using script_36222395658446f5;
#using script_46cea9e5d4ef9e21;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_escape_util;
#using scripts\zm\zm_escape_vo_hooks;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_unitrigger;

#namespace namespace_a9db3299;

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0xe834762c, Offset: 0x308
// Size: 0xa4
function init_clientfields() {
    clientfield::register("scriptmover", "p_w_o_num", 1, getminbitcountfornum(10), "int");
    clientfield::register("toplayer", "sp_ar_pi", 1, 1, "int");
    clientfield::register("scriptmover", "elevator_rumble", 1, 1, "counter");
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0x57731fa1, Offset: 0x3b8
// Size: 0x13c
function main() {
    level flag::init(#"hash_ed90925c898d1b0");
    level flag::init(#"hash_dd62a8822ea4a38");
    level flag::init(#"hash_2444d210a1dd0dd");
    level flag::init(#"hash_6f71660057a5952f");
    level flag::init(#"hash_66f358c0066d77d8");
    init_steps();
    if (getdvarint(#"zm_ee_enabled", 0)) {
        zm_sq::start(#"spoon_quest");
        /#
            level thread function_948d7da5();
        #/
    }
    level thread setup_docks_crane();
    level thread crane_shock_box();
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0xb054d521, Offset: 0x500
// Size: 0x64
function init_steps() {
    zm_sq::register(#"spoon_quest", #"1", #"spoon_quest_step_1", &step_1, &step_1_cleanup);
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 1, eflags: 0x0
// Checksum 0xc6452b7e, Offset: 0x570
// Size: 0xb6
function step_1(var_4df52d26) {
    level flag::wait_till("start_zombie_round_logic");
    level thread function_c3ca8bf();
    level thread function_53612e64();
    var_67894141 = "" + #"spoon_quest_step_1" + "_";
    level waittill(var_67894141 + "completed", var_67894141 + "skipped_over", var_67894141 + "ended_early");
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 2, eflags: 0x0
// Checksum 0xe7f48923, Offset: 0x630
// Size: 0x14
function step_1_cleanup(var_4df52d26, var_c86ff890) {
    
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0x28b4b68e, Offset: 0x650
// Size: 0xe4
function function_f180b755() {
    level flag::set(#"hash_ed90925c898d1b0");
    self thread scene::play("Shot 1");
    wait 1;
    var_5b0d2743 = self.scene_ents[#"prop 1"];
    var_5b0d2743 clientfield::increment("elevator_rumble");
    level thread zm_escape_vo_hooks::function_65b3a0a();
    self thread scene::play("Shot 2");
    level flag::set(#"hash_dd62a8822ea4a38");
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0xd794a1c9, Offset: 0x740
// Size: 0x3ec
function function_c3ca8bf() {
    var_c25932f7 = randomint(10);
    var_5051c3bc = randomint(10);
    for (var_76543e25 = randomint(10); !namespace_d8b81d0b::function_7bf90968(var_c25932f7, var_5051c3bc, var_76543e25); var_76543e25 = randomint(10)) {
        var_c25932f7 = randomint(10);
        var_5051c3bc = randomint(10);
    }
    var_7ddf10a = struct::get_array("nixie_tubes", "script_noteworthy");
    foreach (var_bf6e40b in var_7ddf10a) {
        switch (var_bf6e40b.script_string) {
        case #"nixie_tube_trigger_1":
            var_bf6e40b.var_df0ccd26 = var_c25932f7;
            var_bf6e40b.str_hint_string = #"";
            var_fe8c3eb1 = "n_c_w_p_01";
            var_e64280cf = #"hash_30683ab79a855d68";
            break;
        case #"nixie_tube_trigger_2":
            var_bf6e40b.var_df0ccd26 = var_5051c3bc;
            var_bf6e40b.str_hint_string = #"";
            var_fe8c3eb1 = "n_c_w_p_02";
            var_e64280cf = #"hash_30683db79a856281";
            break;
        case #"nixie_tube_trigger_3":
            var_bf6e40b.var_df0ccd26 = var_76543e25;
            var_bf6e40b.str_hint_string = #"";
            var_fe8c3eb1 = "n_c_w_p_03";
            var_e64280cf = #"hash_30683cb79a8560ce";
            break;
        }
        s_paper = struct::get(var_fe8c3eb1);
        s_paper.script_int = var_bf6e40b.var_df0ccd26;
        mdl_paper = util::spawn_model(var_e64280cf, s_paper.origin, s_paper.angles);
        mdl_paper.targetname = "mdl_wa_pap";
        mdl_paper.script_int = var_bf6e40b.var_df0ccd26;
        mdl_paper ghost();
    }
    foreach (e_player in level.players) {
        e_player thread function_a5e3b8d5();
    }
    callback::on_connect(&function_a5e3b8d5);
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0xe84f4d02, Offset: 0xb38
// Size: 0xe8
function function_a5e3b8d5() {
    var_92a040ec = getentarray("mdl_wa_pap", "targetname");
    foreach (mdl_paper in var_92a040ec) {
        if (mdl_paper.script_int == 0) {
            mdl_paper clientfield::set("p_w_o_num", 10);
            continue;
        }
        mdl_paper clientfield::set("p_w_o_num", mdl_paper.script_int);
    }
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0x5e75a9fe, Offset: 0xc28
// Size: 0xac
function function_53612e64() {
    level flag::wait_till(#"hash_ed90925c898d1b0");
    var_a74a8eb6 = struct::get("nixie_tube_2");
    playsoundatposition(#"hash_59db059ae5cc54c2", var_a74a8eb6.origin);
    var_1f748941 = struct::get("citadel_elevator");
    var_1f748941 thread function_f180b755();
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0x352e2028, Offset: 0xce0
// Size: 0x1d4
function setup_docks_crane() {
    level flag::wait_till("start_zombie_round_logic");
    var_c4cb2247 = struct::get("docks_crane");
    var_ab9e098 = struct::get("docks_zombie");
    scene::add_scene_func(var_c4cb2247.scriptbundlename, &function_a894dc72, "Shot 2");
    scene::add_scene_func(var_ab9e098.scriptbundlename, &function_e449567e, "init");
    var_8d611a0b = var_c4cb2247.scene_ents[#"skeleton_arm"];
    var_8d611a0b ghost();
    var_d11c4eb4 = var_c4cb2247.scene_ents[#"crane"];
    var_d11c4eb4 hidepart("jnt_skeleton", "p8_fxanim_zm_esc_crane_mod", 1);
    var_d11c4eb4.targetname = "docks_crane_link";
    level.var_d11c4eb4 = var_d11c4eb4;
    level flag::wait_till(#"hash_dd62a8822ea4a38");
    var_d11c4eb4 showpart("jnt_skeleton", "p8_fxanim_zm_esc_crane_mod", 1);
    var_8d611a0b show();
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0xc539ed16, Offset: 0xec0
// Size: 0x2d2
function crane_shock_box() {
    var_ccf99daf = getent("crane_shock_box", "script_string");
    var_c4cb2247 = struct::get("docks_crane");
    while (true) {
        var_ccf99daf waittill(#"hash_7e1d78666f0be68b");
        if (level flag::get(#"hash_2444d210a1dd0dd")) {
            continue;
        }
        level flag::set(#"hash_2444d210a1dd0dd");
        wait 1;
        var_c4cb2247 thread scene::play("Shot 2");
        n_anim_length = getanimlength(#"hash_3fbc33140c093c0d");
        wait n_anim_length;
        level flag::set(#"hash_6f71660057a5952f");
        if (!level flag::get(#"hash_66f358c0066d77d8") && level flag::get(#"hash_dd62a8822ea4a38")) {
            foreach (e_player in level.activeplayers) {
                e_player thread function_fb23f45f(var_c4cb2247);
            }
        }
        wait 10;
        level notify(#"hash_2fd493c2a926e006");
        level flag::clear(#"hash_6f71660057a5952f");
        var_ccf99daf.var_ecdefca6 = 1;
        var_ccf99daf notify(#"turn_off");
        var_c4cb2247 thread scene::play("Shot 1");
        n_anim_length = getanimlength(#"hash_923a7a2394d952d");
        wait n_anim_length;
        level flag::clear(#"hash_2444d210a1dd0dd");
        var_ccf99daf.var_ecdefca6 = undefined;
    }
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 1, eflags: 0x0
// Checksum 0x995b8917, Offset: 0x11a0
// Size: 0x152
function function_fb23f45f(var_c4cb2247) {
    self endon(#"death", #"disconnect");
    level endon(#"hash_2fd493c2a926e006", #"hash_66f358c0066d77d8");
    while (true) {
        s_result = self waittill(#"throwing_tomahawk");
        e_tomahawk = s_result.e_grenade;
        if (!isdefined(e_tomahawk)) {
            return;
        }
        while (isdefined(e_tomahawk) && !level flag::get(#"hash_66f358c0066d77d8")) {
            var_10e4f8e9 = struct::get("crane_skeleton_hit_box");
            var_e7db9fc0 = getent("cr_sk_hit", "targetname");
            if (e_tomahawk istouching(var_e7db9fc0)) {
                level thread function_427498a6(var_c4cb2247);
            }
            waitframe(1);
        }
    }
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 1, eflags: 0x0
// Checksum 0x89ee630d, Offset: 0x1300
// Size: 0x20c
function function_427498a6(var_c4cb2247) {
    level notify(#"hash_4302325b2fe2d5d8");
    level endon(#"hash_4302325b2fe2d5d8");
    level flag::set(#"hash_66f358c0066d77d8");
    var_c4cb2247 thread scene::play("Shot 3");
    n_anim_length = getanimlength(#"hash_2bf732b76b5383ba");
    wait n_anim_length;
    mdl_spoon = var_c4cb2247.scene_ents[#"skeleton_arm"];
    mdl_spoon hide();
    foreach (e_player in level.activeplayers) {
        e_player clientfield::set_to_player("sp_ar_pi", 1);
    }
    var_e53a50ac = struct::get("t_sp_pi");
    var_e53a50ac.s_unitrigger_stub = var_e53a50ac zm_unitrigger::create(&function_c255153b, var_e53a50ac.radius, &function_1bf5c083);
    zm_unitrigger::unitrigger_force_per_player_triggers(var_e53a50ac.s_unitrigger_stub, 1);
    callback::on_spawned(&function_f3247255);
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 1, eflags: 0x0
// Checksum 0xf8dc1249, Offset: 0x1518
// Size: 0xea
function function_c255153b(player) {
    if (player hasweapon(getweapon(#"spoon_alcatraz")) || player hasweapon(getweapon(#"spork_alcatraz")) || player flag::get(#"hash_6b33efdeedf241f")) {
        self sethintstring("");
        return 0;
    }
    self sethintstring(#"hash_51ad91916b4b0de5");
    return 1;
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0x77af6392, Offset: 0x1610
// Size: 0x176
function function_1bf5c083() {
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        if (!e_player hasweapon(getweapon(#"spoon_alcatraz")) && !e_player hasweapon(getweapon(#"spork_alcatraz"))) {
            if (!isdefined(e_player.var_22a7e110)) {
                e_player.var_22a7e110 = e_player.slot_weapons[#"melee_weapon"];
            }
            e_player clientfield::set_to_player("sp_ar_pi", 0);
            e_player thread function_ccf6c6d4();
            e_player zm_audio::create_and_play_dialog("spoon", "pickup", undefined, 1);
            level flag::set(#"spoon_quest_completed");
        }
        waitframe(1);
    }
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x4
// Checksum 0x746a80cb, Offset: 0x1790
// Size: 0x3c
function private function_ccf6c6d4() {
    self endon(#"disconnect");
    self zm_melee_weapon::award_melee_weapon(#"spoon_alcatraz");
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0x772150e2, Offset: 0x17d8
// Size: 0xe4
function function_f3247255() {
    if (!self hasweapon(getweapon(#"spoon_alcatraz")) && !self hasweapon(getweapon(#"spork_alcatraz")) && level flag::get(#"hash_66f358c0066d77d8") && !self flag::get(#"hash_6b33efdeedf241f")) {
        self clientfield::set_to_player("sp_ar_pi", 1);
    }
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 1, eflags: 0x0
// Checksum 0xf243f656, Offset: 0x18c8
// Size: 0x616
function function_a894dc72(a_ents) {
    if (level flag::get(#"hash_dd62a8822ea4a38") && !level flag::get(#"hash_66f358c0066d77d8")) {
        level.var_d11c4eb4 showpart("jnt_skeleton", "p8_fxanim_zm_esc_crane_mod", 1);
        return;
    }
    var_d11c4eb4 = a_ents[#"crane"];
    level.var_d11c4eb4 hidepart("jnt_skeleton", "p8_fxanim_zm_esc_crane_mod", 1);
    if (isdefined(level.var_bdf1d58d) && level.var_bdf1d58d hasweapon(getweapon(#"tomahawk_t8_upgraded")) && level.var_bdf1d58d flag::get(#"hash_d41f651bb868608") && !level.var_bdf1d58d flag::get(#"hash_465b23ced2029d95")) {
        var_43e94696 = #"p8_zm_esc_rock_small_blue";
        var_91d80b6a = 1.2;
        v_origin = var_d11c4eb4 gettagorigin("tag_net_3") + (-15, -10, -15);
        v_angles = (324, 135, 72);
    } else {
        n_chance = randomint(100);
        if (n_chance < 4 || isdefined(level.var_40304c3) && level.var_40304c3) {
            level.var_40304c3 = undefined;
            wait getanimlength(#"hash_3fbc33140c093c0d");
            var_88d8b597 = array("double_points", "full_ammo", "insta_kill");
            var_9930f0b7 = var_88d8b597[randomint(var_88d8b597.size)];
            v_origin = var_d11c4eb4 gettagorigin("tag_net_3") - (0, 0, 80);
            mdl_powerup = zm_powerups::specific_powerup_drop(var_9930f0b7, v_origin);
        } else if (n_chance >= 20 && n_chance < 40 || isdefined(level.var_b3a48eeb) && level.var_b3a48eeb) {
            level.var_b3a48eeb = undefined;
            var_ab9e098 = struct::get("docks_zombie");
            var_ab9e098 thread scene::init();
        } else if (n_chance >= 4 && n_chance < 20 || isdefined(level.var_b198cee7) && level.var_b198cee7) {
            level.var_b198cee7 = undefined;
            var_43e94696 = #"p8_zm_vending_three_gun_sign";
            v_origin = var_d11c4eb4 gettagorigin("tag_net_3") + (-15, -10, -13);
            v_angles = (324, 135, 72);
        } else if (n_chance >= 70 || isdefined(level.var_981b1e7) && level.var_981b1e7) {
            level.var_981b1e7 = undefined;
            var_43e94696 = #"p7_tire_rubber_worn_wet";
            if (level flag::get(#"hash_dd62a8822ea4a38")) {
                v_origin = var_d11c4eb4 gettagorigin("tag_net_3") + (10, 0, -10);
                v_angles = (324, 0, 0);
            } else {
                v_origin = var_d11c4eb4 gettagorigin("tag_net_3") + (0, -5, -12);
                v_angles = (300, 0, 0);
            }
        }
    }
    if (isdefined(var_43e94696)) {
        var_4507207e = util::spawn_model(var_43e94696, v_origin, v_angles);
        if (isdefined(var_91d80b6a)) {
            level.var_3fefdc53 = var_4507207e;
            var_4507207e setscale(var_91d80b6a);
            var_91d80b6a = undefined;
        }
        var_4507207e linkto(var_d11c4eb4, "tag_net_3");
        level flag::wait_till_clear(#"hash_2444d210a1dd0dd");
        if (isdefined(var_4507207e)) {
            var_4507207e delete();
        }
        level.var_3fefdc53 = undefined;
    }
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 1, eflags: 0x0
// Checksum 0x333f4107, Offset: 0x1ee8
// Size: 0x254
function function_e36e9ceb(a_ents) {
    if (level flag::get(#"hash_dd62a8822ea4a38") && !level flag::get(#"hash_66f358c0066d77d8")) {
        return;
    }
    var_f5f527ed = randomint(100);
    var_d11c4eb4 = a_ents[#"crane"];
    if (var_f5f527ed < 34) {
        var_43e94696 = #"p7_tire_rubber_worn_wet";
        if (level flag::get(#"hash_dd62a8822ea4a38")) {
            v_origin = var_d11c4eb4 gettagorigin("tag_net_3") + (10, 0, -10);
            v_angles = (324, 0, 0);
        } else {
            v_origin = var_d11c4eb4 gettagorigin("tag_net_3") + (0, -5, -12);
            v_angles = (300, 0, 0);
        }
    } else if (var_f5f527ed > 67) {
        var_43e94696 = #"p8_zm_vending_three_gun_sign";
        v_origin = var_d11c4eb4 gettagorigin("tag_net_3") + (-15, -10, -15);
        v_angles = (324, 135, 72);
    }
    if (isdefined(var_43e94696)) {
        var_4507207e = util::spawn_model(var_43e94696, v_origin, v_angles);
        var_4507207e linkto(var_d11c4eb4, "tag_net_3");
        level flag::wait_till_clear(#"hash_2444d210a1dd0dd");
        var_4507207e delete();
    }
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 1, eflags: 0x0
// Checksum 0xf1980349, Offset: 0x2148
// Size: 0x94
function function_e449567e(a_ents) {
    a_ents[#"zombie"] thread function_bc095cbb();
    level flag::wait_till_clear(#"hash_2444d210a1dd0dd");
    if (isdefined(a_ents[#"zombie"])) {
        a_ents[#"zombie"] delete();
    }
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0x15949c3f, Offset: 0x21e8
// Size: 0xf4
function function_bc095cbb() {
    self endon(#"death");
    self.var_1e23c048 = 50;
    while (self.health > 1) {
        s_waitresult = self waittill(#"damage");
        if (isplayer(s_waitresult.attacker) && isalive(s_waitresult.attacker) && self.var_1e23c048 > 0) {
            s_waitresult.attacker zm_score::add_to_player_score(10);
            self.var_1e23c048 -= 10;
        }
        if (self.health <= 1) {
            break;
        }
    }
}

/#

    // Namespace namespace_a9db3299/namespace_a9db3299
    // Params 0, eflags: 0x0
    // Checksum 0x71827ecf, Offset: 0x22e8
    // Size: 0xd4
    function function_948d7da5() {
        zm_devgui::add_custom_devgui_callback(&function_b6a326de);
        adddebugcommand("<dev string:x30>");
        adddebugcommand("<dev string:x96>");
        adddebugcommand("<dev string:xff>");
        adddebugcommand("<dev string:x168>");
        adddebugcommand("<dev string:x1d4>");
        adddebugcommand("<dev string:x244>");
        adddebugcommand("<dev string:x2aa>");
    }

    // Namespace namespace_a9db3299/namespace_a9db3299
    // Params 1, eflags: 0x0
    // Checksum 0xdf029ab3, Offset: 0x23c8
    // Size: 0x222
    function function_b6a326de(cmd) {
        switch (cmd) {
        case #"hash_42dce9e99181c0bc":
            function_7f7351fd();
            break;
        case #"hash_22d60bf8b1f181a7":
            level flag::set(#"hash_ed90925c898d1b0");
            break;
        case #"hash_6959afd9d36f38b8":
            if (getdvarint(#"zm_ee_enabled", 0)) {
                var_8148144d = struct::get("<dev string:x314>");
                var_a74a8eb6 = struct::get("<dev string:x321>");
                var_cd4d091f = struct::get("<dev string:x32e>");
                var_e488f5b3 = var_8148144d.var_df0ccd26;
                var_72818678 = var_a74a8eb6.var_df0ccd26;
                var_988400e1 = var_cd4d091f.var_df0ccd26;
                iprintln("<dev string:x33b>" + var_e488f5b3 + var_72818678 + var_988400e1);
            }
            break;
        case #"hash_6f5ba9c8e47bde8b":
            level.var_40304c3 = 1;
            break;
        case #"hash_7ed9eae4551e92d3":
            level.var_b198cee7 = 1;
            break;
        case #"hash_6a0c48ca2516a0a3":
            level.var_981b1e7 = 1;
            break;
        case #"hash_67a9a21aa06e4ecf":
            level.var_b3a48eeb = 1;
            break;
        }
    }

    // Namespace namespace_a9db3299/namespace_a9db3299
    // Params 0, eflags: 0x0
    // Checksum 0x803b2c1e, Offset: 0x25f8
    // Size: 0xd4
    function function_7f7351fd() {
        w_component = zm_crafting::get_component(#"zitem_spectral_shield_part_3");
        foreach (e_player in level.activeplayers) {
            e_player zm_crafting::function_38b14e61(w_component);
        }
        level flag::set(#"hash_7039457b1cc827de");
    }

#/
