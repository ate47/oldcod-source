#using script_668c4fbb94671fb4;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\weapons\zm_weap_spectral_shield;
#using scripts\zm\weapons\zm_weap_tomahawk;
#using scripts\zm\zm_escape_util;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here;
#using scripts\zm_common\util\ai_brutus_util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_bgb_pack;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace paschal;

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x3f125a60, Offset: 0x1778
// Size: 0x7c
function init() {
    init_clientfield();
    init_flags();
    init_fx();
    init_steps();
    scene::add_scene_func(#"p8_fxanim_zm_esc_lab_map_burning_bundle", &function_8c8b8b5a, "init");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x6fa9fb13, Offset: 0x1800
// Size: 0x2fc
function main() {
    var_3cfd5670 = getent("w_h_h_d_clip", "targetname");
    var_3cfd5670 disconnectpaths();
    var_76e9d85b = getentarray("mdl_p_s_4_clip", "script_noteworthy");
    foreach (mdl_clip in var_76e9d85b) {
        mdl_clip notsolid();
    }
    var_ed835dbf = getent("w_h_f_d", "targetname");
    var_ed835dbf hide();
    level thread function_ec8cb0d2();
    level flag::wait_till("start_zombie_round_logic");
    exploder::exploder("fxexp_poison_ambient");
    exploder::exploder("fxexp_lighthouse_light");
    var_8d028b06 = struct::get("s_p_s1_w_b");
    var_718723c7 = var_8d028b06.scene_ents[#"door"];
    if (isdefined(var_718723c7)) {
        var_718723c7 hidepart("tag_wall_damaged");
        var_718723c7 hidepart("tag_wall_destroyed");
    }
    if (getdvarint(#"zm_ee_enabled", 0)) {
        if (!isdefined(level.var_37b34838)) {
            level namespace_8adb45e8::function_1cd5ba2c();
        }
        if (zm_custom::function_5638f689(#"hash_3c5363541b97ca3e")) {
            zm_sq::start(#"paschal_quest");
        }
    }
    hidemiscmodels("mechanical_chair");
    mdl_chair = getent("mechanical_chair", "targetname");
    mdl_chair hide();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xb71a96b7, Offset: 0x1b08
// Size: 0x3f4
function init_clientfield() {
    var_eaa623ff = getminbitcountfornum(6);
    clientfield::register("scriptmover", "" + #"dm_energy", 1, var_eaa623ff, "int");
    clientfield::register("scriptmover", "" + #"hash_1f572bbcdde55d9d", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_4bea78fdf78a2613", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_6e2f9a57d1bc4b6a", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"ritual_gobo", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"seagull_fx", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_7c708a514455bf88", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_592c96b2803d9fd5", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"summoning_key_glow", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_2b6e463a7a482630", 1, 1, "counter");
    clientfield::register("actor", "" + #"hash_df589cc30f4c7dd", 1, 1, "int");
    clientfield::register("allplayers", "" + #"hash_4f58771e117ee3ee", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_2928b6d60aaacda6", 1, getminbitcountfornum(7), "int");
    clientfield::register("world", "" + #"attic_room", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_670a34b297f8faca", 1, 1, "int");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x4ed085a4, Offset: 0x1f08
// Size: 0x1e4
function init_flags() {
    level flag::init(#"hash_379fc22ed85f0dbc");
    level flag::init(#"hash_68a1656980e771da");
    level flag::init(#"main_quest_completed");
    level flag::init(#"hash_4fac802bd5dcebf4");
    level flag::init(#"hash_40e9ad323fe8402a");
    level flag::init(#"hash_36138b6e1d539829");
    level flag::init(#"hash_6048c3f423fd987");
    level flag::init(#"hash_61bba9aa86f61865");
    level flag::init(#"hash_3cc421108aedf47f");
    level flag::init(#"hash_6716f701ec61662f");
    level flag::init(#"hash_1b4b6ce05cb62d56");
    level flag::init(#"hash_3d16465b22e70170");
    level flag::init(#"richtofen_sacrifice");
    level flag::init(#"hash_12a631be319641a1");
    level flag::init(#"hash_7680c620ba7315e5");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x20f8
// Size: 0x4
function init_fx() {
    
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xfd660079, Offset: 0x2108
// Size: 0x354
function init_steps() {
    zm_vo::function_32bfa028(5);
    zm_vo::function_32bfa028(6);
    zm_vo::function_32bfa028(7);
    zm_sq::register(#"paschal_quest", #"1", #"paschal_quest_step_1", &step_1, &step_1_cleanup);
    zm_sq::register(#"paschal_quest", #"2", #"paschal_quest_step_2", &step_2, &step_2_cleanup);
    zm_sq::register(#"paschal_quest", #"3", #"paschal_quest_step_3", &step_3, &step_3_cleanup);
    zm_sq::register(#"paschal_quest", #"4", #"paschal_quest_step_4", &step_4, &step_4_cleanup);
    zm_sq::register(#"paschal_quest", #"5", #"paschal_quest_step_5", &step_5, &step_5_cleanup);
    zm_sq::register(#"paschal_quest", #"6", #"paschal_quest_step_6", &step_6, &step_6_cleanup);
    zm_sq::register(#"paschal_quest", #"7", #"paschal_quest_step_7", &step_7, &step_7_cleanup, 1);
    zm_sq::register(#"paschal_quest", #"outro", #"hash_4b2d3fa2839cfcf8", &outro, &outro_cleanup);
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x1384a5b0, Offset: 0x2468
// Size: 0x57c
function step_1(var_4df52d26) {
    level flag::wait_till(#"all_players_spawned");
    /#
        level thread function_60da641a();
        level thread function_9b910b41();
        level thread function_73fca177();
    #/
    var_3cfd5670 = getent("w_h_h_d_clip", "targetname");
    var_8d028b06 = struct::get("s_p_s1_w_b");
    var_718723c7 = var_8d028b06.scene_ents[#"door"];
    var_718723c7 hidepart("tag_wall_damaged");
    var_718723c7 hidepart("tag_wall_destroyed");
    var_718723c7 setcandamage(1);
    var_718723c7.health = 100000000;
    var_718723c7 thread function_89427126();
    level waittill(#"hash_4aedd2f50e5e307");
    var_8d028b06 scene::play("damaged");
    var_3cfd5670 thread function_c3656f3e();
    s_result = level waittill(#"hash_703a48e58dfd43d6");
    if (isdefined(s_result.var_10321ca5)) {
        level.var_7788d1c4 = s_result.var_10321ca5;
    }
    if (isalive(s_result.e_brutus)) {
        s_result.e_brutus thread function_fbb9be53();
    }
    level thread function_eab9f679();
    var_aff1cb49 = struct::get(#"s_r_w_a_r");
    var_aff1cb49 scene::init();
    level clientfield::set("" + #"attic_room", 1);
    if (!isdefined(level.var_7788d1c4)) {
        level.var_7788d1c4 = util::spawn_model("tag_origin", var_3cfd5670.origin);
    }
    level.var_7788d1c4 thread function_d440e4cf();
    music::setmusicstate("escape_attic");
    var_8d028b06 thread scene::play("destroyed");
    var_3cfd5670 connectpaths();
    var_3cfd5670 notsolid();
    zm_zonemgr::enable_zone("zone_warden_home");
    level flag::set("activate_warden_house_2_attic");
    s_orb = struct::get("s_house_orb");
    s_orb.mdl_orb = util::spawn_model(#"p8_zm_esc_orb_red_small", s_orb.origin, s_orb.angles);
    s_orb.s_unitrigger_stub = s_orb zm_unitrigger::create("", 48, &function_c2b8c714);
    var_545afe99 = struct::get("s_ch_sw");
    var_545afe99.mdl_switch = util::spawn_model(#"p7_zm_der_pswitch_handle", var_545afe99.origin, var_545afe99.angles);
    var_545afe99.mdl_switch setscale(var_545afe99.modelscale);
    var_545afe99.s_unitrigger_stub = var_545afe99 zm_unitrigger::create("", 64, &function_905dbafc);
    level flag::wait_till_all(array(#"hash_61bba9aa86f61865", #"hash_379fc22ed85f0dbc"));
    level.var_7788d1c4 delete();
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0x1858eabc, Offset: 0x29f0
// Size: 0x6a2
function step_1_cleanup(var_4df52d26, var_c86ff890) {
    level flag::set(#"hash_40e9ad323fe8402a");
    level thread pause_zombies(0, 0);
    level thread pause_zombies();
    var_8d028b06 = struct::get("s_p_s1_w_b");
    var_718723c7 = var_8d028b06.scene_ents[#"door"];
    var_3cfd5670 = getent("w_h_h_d_clip", "targetname");
    if (var_4df52d26 || var_c86ff890) {
        if (!isdefined(level.var_497f669a)) {
            level.var_497f669a = [];
        } else if (!isarray(level.var_497f669a)) {
            level.var_497f669a = array(level.var_497f669a);
        }
        if (!isinarray(level.var_497f669a, "tag_socket_f")) {
            level.var_497f669a[level.var_497f669a.size] = "tag_socket_f";
        }
        var_8d028b06 scene::play("damaged");
        var_8d028b06 scene::play("destroyed");
        if (!zm_zonemgr::zone_is_enabled("zone_warden_home")) {
            var_3cfd5670 connectpaths();
            zm_zonemgr::enable_zone("zone_warden_home");
            level flag::set("activate_warden_house_2_attic");
        }
    }
    if (var_4df52d26 || var_c86ff890) {
        s_beam = struct::get("s_p_s1_lh_r_light");
        v_angles = (44.7, 269.9, 0);
        exploder::kill_exploder("fxexp_lighthouse_light");
        if (!isdefined(s_beam.mdl_beam)) {
            s_beam.mdl_beam = util::spawn_model("tag_origin", s_beam.origin, v_angles);
            s_beam.mdl_beam clientfield::set("" + #"hash_1f572bbcdde55d9d", 1);
        }
        level thread scene::play("s_r_w_a_r", "Main & Idle Loop Out");
        wait 4.8;
    }
    mdl_pristine = getent("w_h_f", "targetname");
    var_a178d2fe = getent("w_h_f_d", "targetname");
    var_a178d2fe show();
    if (isdefined(mdl_pristine)) {
        mdl_pristine delete();
    }
    var_3cfd5670 delete();
    if (isdefined(level.var_7788d1c4)) {
        level.var_7788d1c4 delete();
        level.var_7788d1c4 = undefined;
    }
    s_orb = struct::get("s_house_orb");
    if (isdefined(s_orb.mdl_orb)) {
        s_orb.mdl_orb delete();
    }
    if (isdefined(s_orb.s_unitrigger_stub)) {
        zm_unitrigger::unregister_unitrigger(s_orb.s_unitrigger_stub);
    }
    var_545afe99 = struct::get("s_ch_sw");
    if (isdefined(var_545afe99.s_unitrigger_stub)) {
        zm_unitrigger::unregister_unitrigger(var_545afe99.s_unitrigger_stub);
    }
    if (!isdefined(var_545afe99.mdl_switch)) {
        var_545afe99.mdl_switch = util::spawn_model(#"p7_zm_der_pswitch_handle", var_545afe99.origin, var_545afe99.angles);
    }
    if (isdefined(var_545afe99.mdl_switch) && !level flag::get(#"hash_379fc22ed85f0dbc")) {
        var_545afe99.mdl_switch rotateroll(-90, 0.5);
    }
    if (level flag::exists(#"hash_61bba9aa86f61865")) {
        level flag::delete(#"hash_61bba9aa86f61865");
    }
    if (level flag::exists(#"hash_379fc22ed85f0dbc")) {
        level flag::delete(#"hash_379fc22ed85f0dbc");
    }
    foreach (e_player in level.activeplayers) {
        if (isdefined(e_player.var_94b48394) && e_player.var_94b48394) {
            e_player.var_94b48394 = undefined;
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x9442553, Offset: 0x30a0
// Size: 0x134
function function_89427126() {
    level endon(#"paschal_quest_step_1" + "_completed", #"paschal_quest_step_1" + "_skipped_over", #"paschal_quest_step_1" + "_ended_early", #"hash_4aedd2f50e5e307");
    while (true) {
        s_result = self waittill(#"damage");
        if (s_result.weapon == getweapon(#"spoon_alcatraz") || s_result.weapon == getweapon(#"spork_alcatraz") || s_result.weapon == getweapon(#"spknifeork")) {
            level notify(#"hash_4aedd2f50e5e307");
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x3468888f, Offset: 0x31e0
// Size: 0x14c
function function_c3656f3e() {
    level endon(#"paschal_quest_step_1" + "_completed", #"paschal_quest_step_1" + "_skipped_over", #"paschal_quest_step_1" + "_ended_early", #"hash_703a48e58dfd43d6");
    while (true) {
        s_result = level waittill(#"hash_79c0225ea09cd215");
        if (distance2dsquared(self.origin, s_result.brutus.origin) < 5625) {
            var_10321ca5 = util::spawn_model(#"wpn_t8_zm_monkey_bomb_world", s_result.var_af11b0eb, s_result.var_b9c44175);
            level notify(#"hash_703a48e58dfd43d6", {#var_10321ca5:var_10321ca5, #e_brutus:s_result.brutus});
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x92247a20, Offset: 0x3338
// Size: 0x54
function private function_fbb9be53() {
    self endon(#"death");
    self playsound(#"zmb_ai_brutus_spawn_2d");
    level thread zm_escape_util::function_ddd7ade1(self);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xa40d9bdc, Offset: 0x3398
// Size: 0x24
function function_d440e4cf() {
    wait 0.1;
    self ghost();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x525eb5c2, Offset: 0x33c8
// Size: 0x1c2
function function_c2b8c714() {
    level endon(#"paschal_quest_step_1" + "_completed", #"paschal_quest_step_1" + "_skipped_over", #"paschal_quest_step_1" + "_ended_early", #"hash_61bba9aa86f61865");
    while (true) {
        s_result = self waittill(#"trigger");
        if (isplayer(s_result.activator) && isalive(s_result.activator)) {
            self.stub.related_parent.mdl_orb ghost();
            level flag::set(#"hash_61bba9aa86f61865");
            if (!isdefined(level.var_497f669a)) {
                level.var_497f669a = [];
            } else if (!isarray(level.var_497f669a)) {
                level.var_497f669a = array(level.var_497f669a);
            }
            if (!isinarray(level.var_497f669a, "tag_socket_f")) {
                level.var_497f669a[level.var_497f669a.size] = "tag_socket_f";
            }
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xbb5df85, Offset: 0x3598
// Size: 0x300
function function_905dbafc() {
    level endon(#"paschal_quest_step_1" + "_completed", #"paschal_quest_step_1" + "_skipped_over", #"paschal_quest_step_1" + "_ended_early", #"hash_379fc22ed85f0dbc");
    while (true) {
        s_result = self waittill(#"trigger");
        if (isplayer(s_result.activator) && isalive(s_result.activator)) {
            self.stub.related_parent.mdl_switch rotateroll(-180, 0.5);
            wait 0.5;
            level thread pause_zombies(1, 0);
            s_beam = struct::get("s_p_s1_lh_r_light");
            v_angles = (44.7, 269.9, 0);
            exploder::kill_exploder("fxexp_lighthouse_light");
            s_beam.mdl_beam = util::spawn_model("tag_origin", s_beam.origin, v_angles);
            s_beam.mdl_beam clientfield::set("" + #"hash_1f572bbcdde55d9d", 1);
            level thread scene::play("s_r_w_a_r", "Main & Idle Loop Out");
            wait 4.8;
            mdl_pristine = getent("w_h_f", "targetname");
            var_a178d2fe = getent("w_h_f_d", "targetname");
            mdl_pristine hide();
            var_a178d2fe show();
            wait 1;
            level thread function_f0cf7137();
            wait function_b6fdcf2f(#"hash_2a39cae40007f5e2");
            level flag::set(#"hash_379fc22ed85f0dbc");
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xfd812322, Offset: 0x38a0
// Size: 0x13c
function function_eab9f679() {
    level endon(#"hash_40e9ad323fe8402a");
    e_player = array::random(level.activeplayers);
    for (str_zone = e_player zm_zonemgr::get_player_zone(); !isalive(e_player) || !isdefined(str_zone) || str_zone != "zone_warden_home"; str_zone = e_player zm_zonemgr::get_player_zone()) {
        wait 0.1;
        e_player = array::random(level.activeplayers);
    }
    zm_vo::function_2426269b(e_player.origin, 512);
    e_player zm_vo::vo_say("vox_plr_" + e_player.characterindex + "_m_quest_attic_react_0", 0, 1, 9999);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x51fad031, Offset: 0x39e8
// Size: 0x13c
function function_f0cf7137() {
    level endon(#"hash_40e9ad323fe8402a");
    e_player = function_df4dd4a4();
    zm_vo::function_2426269b(e_player.origin, 512);
    e_player thread zm_vo::vo_say("vox_plr_" + e_player.characterindex + "_m_quest_light_react_0", 0, 1, 9999);
    wait function_b6fdcf2f(#"hash_2a39cae40007f5e2");
    e_player = function_df4dd4a4();
    zm_vo::function_2426269b(e_player.origin, 512);
    e_player zm_vo::vo_say("vox_plr_" + e_player.characterindex + "_m_quest_elec_chair_react_0", 0, 1, 9999);
    level thread pause_zombies(0, 0);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xc2d97c12, Offset: 0x3b30
// Size: 0xc6
function function_df4dd4a4() {
    e_player = array::random(level.activeplayers);
    for (str_zone = e_player zm_zonemgr::get_player_zone(); !isalive(e_player) || !isdefined(str_zone) || str_zone != "zone_warden_home"; str_zone = e_player zm_zonemgr::get_player_zone()) {
        wait 0.1;
        e_player = array::random(level.activeplayers);
    }
    return e_player;
}

/#

    // Namespace paschal/zm_escape_paschal
    // Params 0, eflags: 0x0
    // Checksum 0x3ec15b53, Offset: 0x3c00
    // Size: 0x5c
    function function_60da641a() {
        zm_devgui::add_custom_devgui_callback(&function_76a6c85);
        adddebugcommand("<dev string:x30>");
        adddebugcommand("<dev string:x7b>");
    }

    // Namespace paschal/zm_escape_paschal
    // Params 1, eflags: 0x0
    // Checksum 0xe8bc6bf5, Offset: 0x3c68
    // Size: 0x72
    function function_76a6c85(cmd) {
        switch (cmd) {
        case #"hash_17435d3d0cb6939a":
            level notify(#"hash_4aedd2f50e5e307");
            break;
        case #"hash_17435c3d0cb691e7":
            level notify(#"hash_703a48e58dfd43d6");
            break;
        }
    }

#/

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xcb737bd5, Offset: 0x3ce8
// Size: 0x314
function step_2(var_4df52d26) {
    level zm_ui_inventory::function_31a39683(#"zm_escape_paschal", 2);
    if (var_4df52d26) {
        return;
    }
    level thread function_e61c8174();
    while (!isinarray(level.var_607bd06e, "tag_socket_f")) {
        var_af330228 = struct::get("s_p_s2_ins");
        var_af330228.s_unitrigger_stub waittill(#"hash_4c6ab2a4a99f9539");
    }
    var_6490632b = struct::get("s_p_s2_b");
    var_6490632b.scene_ents[#"book"] clientfield::set("" + #"hash_6e2f9a57d1bc4b6a", 1);
    var_d8ffc79d = struct::get("s_p_s2_b_en_po");
    e_activator = var_d8ffc79d zm_unitrigger::function_b7e350e6("", 64);
    var_6490632b thread scene::play("IN");
    wait 1;
    level flag::clear("spawn_zombies");
    function_3e644234(e_activator);
    function_295e4a26();
    level flag::set("spawn_zombies");
    level thread function_5823f0af();
    function_e8067f41();
    level thread function_32217646();
    var_fb4d1777 = struct::get("k_fx_pos");
    e_activator = var_fb4d1777 zm_unitrigger::function_b7e350e6("", 64);
    level.var_f5b75383 = util::spawn_model(#"hash_4c06bc763e373f0f", var_fb4d1777.origin, var_fb4d1777.angles);
    level thread pause_zombies(1);
    function_5a514c5e(e_activator);
    level thread pause_zombies(0, 0);
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0xf745582e, Offset: 0x4008
// Size: 0x35e
function step_2_cleanup(var_4df52d26, var_c86ff890) {
    level flag::set(#"hash_36138b6e1d539829");
    level thread pause_zombies(0, 0);
    level.var_4f76c7b2 = undefined;
    callback::remove_on_connect(&function_78afc32d);
    callback::remove_on_connect(&function_c0b63a78);
    callback::remove_on_connect(&function_151bce11);
    arrayremovevalue(level.a_tomahawk_pickup_funcs, &function_1b27394e);
    if (var_4df52d26) {
        level thread function_881a1269("tag_socket_f");
    }
    s_seagull = struct::get("s_p_s2_gul");
    if (isdefined(s_seagull.mdl_seagull)) {
        if (isdefined(s_seagull.mdl_seagull.var_4661abd8)) {
            s_seagull.mdl_seagull.var_4661abd8 delete();
        }
        s_seagull.mdl_seagull delete();
    }
    if (isdefined(level.var_476496a5)) {
        if (isdefined(level.var_476496a5.mdl_prop)) {
            level.var_476496a5.mdl_prop delete();
        }
        if (isdefined(level.var_476496a5.mdl_bird)) {
            level.var_476496a5.mdl_bird delete();
        }
        level.var_476496a5 = undefined;
    }
    foreach (e_player in level.activeplayers) {
        if (isdefined(e_player.var_acd80213) && e_player.var_acd80213) {
            e_player.var_acd80213 = undefined;
        }
    }
    var_fb4d1777 = struct::get("k_fx_pos");
    if (isdefined(var_fb4d1777.var_11bbedd5)) {
        var_fb4d1777.var_11bbedd5 delete();
    }
    if (!isdefined(level.var_f5b75383)) {
        var_fb4d1777 = struct::get("k_fx_pos");
        level.var_f5b75383 = util::spawn_model(#"hash_4c06bc763e373f0f", var_fb4d1777.origin, var_fb4d1777.angles);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x2c61a460, Offset: 0x4370
// Size: 0x53c
function private function_295e4a26() {
    level endon(#"hash_36138b6e1d539829");
    s_seagull = struct::get("s_p_s2_gul");
    s_seagull.mdl_origin = util::spawn_model("tag_origin", s_seagull.origin, s_seagull.angles);
    s_seagull.mdl_seagull = util::spawn_model(#"hash_91c31763b1101e6", s_seagull.origin, s_seagull.angles);
    s_seagull.mdl_seagull clientfield::set("" + #"hash_34562274d7e875a4", 1);
    s_seagull.mdl_seagull linkto(s_seagull.mdl_origin);
    s_seagull.mdl_origin scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "materialize", s_seagull.mdl_seagull);
    s_seagull.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "attack", s_seagull.mdl_seagull);
    s_seagull.mdl_seagull waittill(#"att_fx");
    s_seagull.mdl_seagull clientfield::set("" + #"seagull_fx", 1);
    v_position = function_cfee2a04(s_seagull.mdl_seagull.origin, 512);
    if (isdefined(v_position)) {
        s_seagull.mdl_origin.var_4661abd8 = util::spawn_model("tag_origin", v_position[#"point"], s_seagull.mdl_seagull.angles);
        s_seagull.mdl_origin.var_4661abd8 clientfield::set("" + #"hash_7c708a514455bf88", 1);
    }
    var_6490632b = struct::get("s_p_s2_b");
    var_6490632b thread scene::play("OUT");
    level thread function_c142146a();
    s_seagull.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "loop_anim", s_seagull.mdl_seagull);
    for (var_1912b060 = struct::get("s_p_s2_gul_esc"); isdefined(var_1912b060); var_1912b060 = struct::get(var_1912b060.target)) {
        n_time = distance(s_seagull.mdl_origin.origin, var_1912b060.origin) / 150;
        s_seagull.mdl_origin moveto(var_1912b060.origin, n_time);
        s_seagull.mdl_origin rotateto(var_1912b060.angles, n_time);
        s_seagull.mdl_origin waittill(#"movedone");
        if (isdefined(var_1912b060.var_14523373) && var_1912b060.var_14523373) {
            s_seagull.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "dissolve", s_seagull.mdl_seagull);
        }
    }
    level thread function_434d7bfe(s_seagull.mdl_seagull.origin, s_seagull.mdl_seagull.angles);
    s_seagull.mdl_seagull notify(#"delete_seagull");
    s_seagull.mdl_origin.var_4661abd8 delete();
    s_seagull.mdl_seagull delete();
    s_seagull.mdl_origin delete();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x1ffc9ac3, Offset: 0x48b8
// Size: 0x1ee
function private function_e8067f41() {
    level endon(#"hash_36138b6e1d539829");
    level.var_4f76c7b2 = 0;
    while (level.var_4f76c7b2 < 3) {
        function_f3241330();
    }
    level notify(#"hash_3872b8f91be564bc");
    callback::remove_on_connect(&function_c0b63a78);
    foreach (e_player in level.activeplayers) {
        e_player thread function_151bce11();
    }
    callback::on_connect(&function_151bce11);
    function_8b6b5dc5();
    if (!isdefined(level.a_tomahawk_pickup_funcs)) {
        level.a_tomahawk_pickup_funcs = [];
    } else if (!isarray(level.a_tomahawk_pickup_funcs)) {
        level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
    }
    level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_1b27394e;
    level waittill(#"hash_1b94645b5f964ebe");
    level.var_64ab9226 = undefined;
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x2d9c421f, Offset: 0x4ab0
// Size: 0x484
function private function_f3241330() {
    level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe");
    var_be757f37 = struct::get_array("s_p_s2_b_loc");
    var_476496a5 = array::random(var_be757f37);
    if (level.var_4f76c7b2 == 0) {
        str_location = var_476496a5.script_string;
        var_998bd1ce = array("zone_cellblock_east", "zone_cellblock_west_gondola", "zone_library");
        while (!isinarray(var_998bd1ce, str_location)) {
            var_476496a5 = array::random(var_be757f37);
            str_location = var_476496a5.script_string;
        }
    } else {
        var_9a813858 = 0;
        while (!var_9a813858) {
            var_9a813858 = 1;
            for (var_476496a5 = array::random(var_be757f37); var_476496a5.script_string == level.var_476496a5.script_string; var_476496a5 = array::random(var_be757f37)) {
            }
            mdl_origin = util::spawn_model("tag_origin", var_476496a5.origin);
            foreach (e_player in level.activeplayers) {
                s_cost = zm_zonemgr::function_a5972886(e_player, mdl_origin);
                if (isdefined(s_cost) && s_cost.cost < 3) {
                    var_9a813858 = 0;
                }
            }
            mdl_origin delete();
        }
    }
    level.var_476496a5 = var_476496a5;
    function_cfb906cc(var_476496a5);
    var_476496a5.mdl_bird thread function_4d7e76c9();
    foreach (e_player in level.players) {
        e_player thread function_78afc32d();
        e_player thread function_c0b63a78();
    }
    callback::on_connect(&function_78afc32d);
    callback::on_connect(&function_c0b63a78);
    /#
        iprintln("<dev string:xc6>" + var_476496a5.script_string);
    #/
    level waittill(#"seagull_blasted");
    level.var_4f76c7b2++;
    function_ddc92919();
    foreach (e_player in level.activeplayers) {
        if (isdefined(e_player.var_5257a535) && e_player.var_5257a535) {
            e_player.var_5257a535 = undefined;
        }
    }
    level waittill(#"between_round_over");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x4beb9765, Offset: 0x4f40
// Size: 0x1dc
function private function_8b6b5dc5() {
    level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe");
    var_be757f37 = struct::get_array("s_p_s2_b_loc");
    var_476496a5 = array::random(var_be757f37);
    str_location = var_476496a5.script_string;
    var_968d56dd = array("zone_citadel_basement", "zone_citadel_basement_building", "zone_studio", "zone_dock_gondola", "zone_dock", "zone_citadel_shower", "zone_citadel_warden", "cellblock_shower", "zone_cellblock_west_warden", "zone_sally_port");
    while (!isinarray(var_968d56dd, str_location) || str_location == level.var_476496a5.script_string) {
        var_476496a5 = array::random(var_be757f37);
        str_location = var_476496a5.script_string;
    }
    level.var_476496a5 = var_476496a5;
    function_cfb906cc(var_476496a5, 0, 1);
    var_476496a5.mdl_bird setinvisibletoall();
    var_476496a5.mdl_book setinvisibletoall();
    /#
        iprintln("<dev string:xc6>" + var_476496a5.script_string);
    #/
}

// Namespace paschal/zm_escape_paschal
// Params 3, eflags: 0x0
// Checksum 0x31baf381, Offset: 0x5128
// Size: 0x48e
function function_cfb906cc(var_476496a5, var_b4353748 = 1, var_5723df47 = 0) {
    n_item = randomint(3);
    level.var_476496a5 = var_476496a5;
    switch (n_item) {
    case 0:
        var_476496a5.mdl_prop = util::spawn_model(#"p8_zm_esc_weasel_hat", var_476496a5.origin, var_476496a5.angles);
        break;
    case 1:
        var_476496a5.mdl_prop = util::spawn_model(#"p8_zm_esc_comicbook_drawing", var_476496a5.origin + (0, 0, 1), var_476496a5.angles);
        break;
    case 2:
        var_476496a5.mdl_prop = util::spawn_model(#"hash_153ac5fda9f2b0c9", var_476496a5.origin, var_476496a5.angles);
        break;
    }
    a_s_birds = struct::get_array(var_476496a5.target);
    s_bird = array::random(a_s_birds);
    var_476496a5.mdl_bird = util::spawn_model(#"hash_91c31763b1101e6", s_bird.origin, s_bird.angles);
    if (var_b4353748) {
        var_476496a5.mdl_bird clientfield::set("" + #"hash_7327d0447d656234", 1);
    }
    var_476496a5.mdl_bird clientfield::set("" + #"seagull_fx", 1);
    var_476496a5.mdl_bird clientfield::set("" + #"hash_34562274d7e875a4", 1);
    var_476496a5.mdl_origin = util::spawn_model("tag_origin", s_bird.origin, s_bird.angles);
    var_476496a5.mdl_bird linkto(var_476496a5.mdl_origin);
    var_476496a5.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "idle_grounded_loop", var_476496a5.mdl_bird);
    var_476496a5.mdl_bird.script_noteworthy = "blast_attack_interactables";
    s_book = struct::get(s_bird.target);
    if (var_5723df47 && isdefined(s_book)) {
        var_476496a5.mdl_book = util::spawn_model(#"p7_zm_ctl_book_zombie", s_book.origin, s_book.angles);
        var_476496a5.mdl_book clientfield::set("" + #"hash_6e2f9a57d1bc4b6a", 1);
    }
    if (isdefined(s_book) && !var_5723df47) {
        var_476496a5.mdl_origin.origin -= (0, 0, 5);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xe65e298, Offset: 0x55c0
// Size: 0x94
function function_4d7e76c9() {
    level endon(#"seagull_blasted", #"hash_36138b6e1d539829");
    self setcandamage(1);
    self.health = 100000000;
    while (true) {
        s_result = self waittill(#"blast_attack");
        level notify(#"seagull_blasted");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x5ca8bd74, Offset: 0x5660
// Size: 0x208
function function_78afc32d() {
    self notify(#"hash_7472292fa861b6ed");
    self endon(#"death", #"disconnect", #"hash_7472292fa861b6ed");
    level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe");
    while (true) {
        if (self.currentweapon == level.var_3d9066fe || self.currentweapon == level.var_cc1a6c85) {
            var_f97c401 = self zm_zonemgr::get_player_zone();
            a_str_active_zones = zm_cleanup::get_adjacencies_to_zone(level.var_476496a5.script_string);
            if (isdefined(var_f97c401) && isdefined(a_str_active_zones)) {
                var_da1a13a0 = 0;
                foreach (str_zone in a_str_active_zones) {
                    if (var_f97c401 == str_zone) {
                        var_da1a13a0 = 1;
                        break;
                    }
                }
                if (var_da1a13a0 && isdefined(level.var_476496a5.mdl_bird)) {
                    playsoundatposition(#"hash_6cd665a68de4367e", level.var_476496a5.mdl_bird.origin, self);
                    wait 5;
                }
            }
        }
        wait 1;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x7c386428, Offset: 0x5870
// Size: 0x2ac
function function_151bce11() {
    self endon(#"death", #"disconnect");
    level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe");
    while (true) {
        if (isdefined(level.var_476496a5.mdl_bird)) {
            if (self.currentweapon == level.var_3d9066fe || self.currentweapon == level.var_cc1a6c85) {
                var_f97c401 = zm_zonemgr::get_player_zone();
                if (isdefined(var_f97c401) && var_f97c401 == level.var_476496a5.script_string && isdefined(level.var_476496a5.mdl_bird)) {
                    var_44a0fc5b = level.var_476496a5.mdl_bird sightconetrace(self getweaponmuzzlepoint(), self, self getweaponforwarddir(), 10);
                    if (isdefined(var_44a0fc5b) && var_44a0fc5b) {
                        playsoundatposition(#"hash_46a6d025135db080", level.var_476496a5.mdl_bird.origin, self);
                        if (!(isdefined(level.var_64ab9226) && level.var_64ab9226)) {
                            level.var_64ab9226 = 1;
                            self thread function_312c1f04();
                        }
                        if (!(isdefined(level.var_476496a5.mdl_bird.var_8e2cfbff) && level.var_476496a5.mdl_bird.var_8e2cfbff)) {
                            /#
                                iprintln("<dev string:xd7>");
                            #/
                            level.var_476496a5.mdl_bird.var_8e2cfbff = 1;
                            level thread function_a7426793();
                        }
                        wait soundgetplaybacktime(#"hash_46a6d025135db080") * 0.001;
                    }
                }
            }
        }
        wait 1;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x1c2ba76d, Offset: 0x5b28
// Size: 0x196
function private function_312c1f04() {
    level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe", #"hash_38f418ba1b5571a2");
    level.var_476496a5.mdl_origin endon(#"death");
    level.var_476496a5.mdl_origin clientfield::set("" + #"hash_670a34b297f8faca", 1);
    while (isdefined(level.var_476496a5.mdl_bird sightconetrace(self getweaponmuzzlepoint(), self, self getweaponforwarddir(), 10)) && level.var_476496a5.mdl_bird sightconetrace(self getweaponmuzzlepoint(), self, self getweaponforwarddir(), 10)) {
        waitframe(1);
    }
    level.var_476496a5.mdl_origin clientfield::set("" + #"hash_670a34b297f8faca", 0);
    level.var_64ab9226 = undefined;
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x20aaf921, Offset: 0x5cc8
// Size: 0x94
function function_a7426793() {
    level endon(#"hash_36138b6e1d539829", #"hash_38f418ba1b5571a2");
    while (zm_zonemgr::any_player_in_zone(level.var_476496a5.script_string)) {
        wait 1;
    }
    level thread function_a96c954f();
    /#
        iprintln("<dev string:xf2>");
    #/
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xcce4ad77, Offset: 0x5d68
// Size: 0x364
function private function_a96c954f() {
    level endon(#"hash_36138b6e1d539829", #"hash_38f418ba1b5571a2", #"hash_1b94645b5f964ebe");
    while (true) {
        a_e_players = zm_zonemgr::get_players_in_zone(level.var_476496a5.script_string, 1);
        for (i = 0; i < a_e_players.size; i++) {
            if (!(isdefined(a_e_players[i].bgb_in_plain_sight_active) && a_e_players[i].bgb_in_plain_sight_active) && !(isdefined(a_e_players[i].var_1aaf8148) && a_e_players[i].var_1aaf8148) && !a_e_players[i].zombie_vars[#"zombie_powerup_zombie_blood_on"]) {
                if (isdefined(level.var_476496a5.mdl_bird)) {
                    level.var_476496a5.mdl_bird setvisibletoall();
                }
                function_ddc92919();
                /#
                    iprintln("<dev string:x105>");
                #/
                level thread function_72e2ae48();
                foreach (e_player in level.activeplayers) {
                    if (isdefined(e_player.var_acd80213) && e_player.var_acd80213) {
                        e_player.var_acd80213 = undefined;
                    }
                }
                level notify(#"hash_38f418ba1b5571a2");
                level.var_64ab9226 = undefined;
                continue;
            }
            if (isdefined(level.var_476496a5.mdl_bird)) {
                level.var_476496a5.mdl_bird setvisibletoplayer(a_e_players[i]);
            }
            if (isdefined(level.var_476496a5.mdl_book)) {
                level.var_476496a5.mdl_book setvisibletoplayer(a_e_players[i]);
            }
            if (!(isdefined(a_e_players[i].var_acd80213) && a_e_players[i].var_acd80213)) {
                a_e_players[i].var_acd80213 = 1;
                a_e_players[i] thread function_6fe48f23();
                /#
                    iprintln("<dev string:x130>");
                #/
            }
        }
        wait 1;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xa316b589, Offset: 0x60d8
// Size: 0x44
function function_72e2ae48() {
    level endon(#"hash_36138b6e1d539829");
    level waittill(#"between_round_over");
    function_8b6b5dc5();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xb8250d5a, Offset: 0x6128
// Size: 0x120
function function_6fe48f23() {
    self endon(#"death", #"disconnect");
    level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe", #"hash_38f418ba1b5571a2");
    while (true) {
        s_result = self waittill(#"throwing_tomahawk");
        e_tomahawk = s_result.e_grenade;
        while (isdefined(e_tomahawk)) {
            if (distancesquared(e_tomahawk.origin, level.var_476496a5.mdl_bird gettagorigin("j_jaw")) < 40000) {
                level.var_476496a5.mdl_bird.var_853d10b9 = 1;
                break;
            }
            wait 0.1;
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0x76882917, Offset: 0x6250
// Size: 0x1a4
function function_1b27394e(e_grenade, n_grenade_charge_power) {
    self endon(#"disconnect");
    if (!isdefined(level.var_476496a5.mdl_bird) || !(isdefined(self.var_acd80213) && self.var_acd80213)) {
        return false;
    }
    if (isdefined(level.var_476496a5.mdl_bird.var_853d10b9) && level.var_476496a5.mdl_bird.var_853d10b9) {
        if (isdefined(level.var_476496a5.mdl_book)) {
            mdl_tomahawk = zm_weap_tomahawk::tomahawk_spawn(e_grenade.origin);
            mdl_tomahawk.n_grenade_charge_power = n_grenade_charge_power;
            var_11bbedd5 = util::spawn_model(level.var_476496a5.mdl_book.model, e_grenade.origin);
            var_11bbedd5 linkto(mdl_tomahawk);
            self thread zm_weap_tomahawk::tomahawk_return_player(mdl_tomahawk, undefined, 800);
            self thread function_8156faa1(mdl_tomahawk, var_11bbedd5);
            level thread function_ddc92919();
            return true;
        } else {
            return false;
        }
    }
    return false;
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0x9375f1e7, Offset: 0x6400
// Size: 0xd8
function function_8156faa1(mdl_tomahawk, var_11bbedd5) {
    self endoncallback(&function_ca337b6f, #"disconnect");
    while (isdefined(mdl_tomahawk)) {
        waitframe(1);
    }
    var_11bbedd5 delete();
    self thread function_712f3f50();
    s_result = level waittill(#"hash_2a774132e6f379ae");
    if (isdefined(s_result.e_player)) {
        s_result.e_player thread function_158ebef5();
    }
    level notify(#"hash_1b94645b5f964ebe");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x60c30fa8, Offset: 0x64e0
// Size: 0x2bc
function private function_712f3f50() {
    var_9af2eac0 = self.origin + anglestoforward(self getplayerangles()) * 16;
    v_pos = getclosestpointonnavmesh(var_9af2eac0, 128, 16);
    assert(isdefined(v_pos), "<dev string:x143>" + var_9af2eac0);
    var_11bbedd5 = util::spawn_model(#"p7_zm_ctl_book_zombie", v_pos + (0, 0, 24));
    var_11bbedd5 clientfield::set("" + #"hash_6e2f9a57d1bc4b6a", 1);
    var_11bbedd5 thread function_9762621e();
    t_interact = spawn("trigger_radius_use", var_11bbedd5.origin, 0, 64, 64);
    t_interact sethintstring(#"");
    t_interact setcursorhint("HINT_NOICON");
    t_interact triggerignoreteam();
    t_interact setvisibletoall();
    t_interact endon(#"death");
    while (isdefined(var_11bbedd5)) {
        s_result = t_interact waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            level notify(#"hash_2a774132e6f379ae", {#e_player:s_result.activator});
            var_11bbedd5 clientfield::set("" + #"hash_6e2f9a57d1bc4b6a", 0);
            var_11bbedd5 delete();
        }
    }
    t_interact delete();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x9f1b3d42, Offset: 0x67a8
// Size: 0x138
function private function_9762621e() {
    self endon(#"death");
    while (isdefined(self)) {
        waittime = randomfloatrange(2.5, 5);
        yaw = math::clamp(randomint(45), 0, 45);
        yaw = self.angles[1] + yaw;
        new_angles = (-45 + randomint(45), yaw, -45 + randomint(45));
        self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        wait randomfloat(waittime - 0.1);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x8a3ab8fe, Offset: 0x68e8
// Size: 0x76
function function_ca337b6f() {
    if (isdefined(level.var_476496a5.mdl_bird) && isdefined(level.var_476496a5.mdl_bird.var_853d10b9) && level.var_476496a5.mdl_bird.var_853d10b9) {
        level.var_476496a5.mdl_bird.var_853d10b9 = undefined;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x6b5dc4e4, Offset: 0x6968
// Size: 0x184
function function_ddc92919() {
    if (isdefined(level.var_476496a5.mdl_prop)) {
        level.var_476496a5.mdl_prop delete();
    }
    if (isdefined(level.var_476496a5.mdl_book)) {
        level.var_476496a5.mdl_book delete();
    }
    if (isdefined(level.var_476496a5.mdl_bird) && isdefined(level.var_476496a5.mdl_origin)) {
        level.var_476496a5.mdl_origin scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "fly_off", level.var_476496a5.mdl_bird);
        level thread function_434d7bfe(level.var_476496a5.mdl_origin.origin, level.var_476496a5.mdl_origin.angles);
        waitframe(1);
        level.var_476496a5.mdl_bird delete();
        level.var_476496a5.mdl_origin delete();
    }
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x4
// Checksum 0xdd6f726e, Offset: 0x6af8
// Size: 0xcc
function private function_434d7bfe(v_position, v_angles) {
    var_bbb1872c = v_position + anglestoforward(v_angles) * 48 + (0, 0, 8);
    mdl_fx = util::spawn_model("tag_origin", var_bbb1872c, v_angles);
    mdl_fx clientfield::set("" + #"hash_592c96b2803d9fd5", 1);
    wait 2;
    mdl_fx delete();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xf80f3c8, Offset: 0x6bd0
// Size: 0x3b4
function function_e61c8174() {
    level endon(#"hash_11fb44a7b531b27d", #"hash_36138b6e1d539829");
    wait 3;
    e_richtofen = function_6a0e1ac2();
    if (!isdefined(e_richtofen) || !isalive(e_richtofen) || !(isdefined(e_richtofen.var_c6724157) && e_richtofen.var_c6724157)) {
        return;
    }
    e_richtofen playsoundtoplayer("vox_stuh_m_quest_stuhl_1_0_0", e_richtofen);
    wait soundgetplaybacktime("vox_stuh_m_quest_stuhl_1_0_0") * 0.001;
    if (isalive(e_richtofen)) {
        zm_vo::function_2426269b(e_richtofen.origin, 512);
        b_play_vo = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_stuhl_1_1_0");
    }
    if (b_play_vo && isalive(e_richtofen)) {
        e_richtofen playsoundtoplayer("vox_stuh_m_quest_stuhl_1_2_0", e_richtofen);
        wait soundgetplaybacktime("vox_stuh_m_quest_stuhl_1_2_0") * 0.001;
        if (isalive(e_richtofen)) {
            zm_vo::function_2426269b(e_richtofen.origin, 512);
            b_play_vo = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_stuhl_1_3_0");
        }
        if (b_play_vo && isalive(e_richtofen)) {
            e_richtofen playsoundtoplayer("vox_stuh_m_quest_stuhl_1_4_0", e_richtofen);
            wait soundgetplaybacktime("vox_stuh_m_quest_stuhl_1_4_0") * 0.001;
            if (isalive(e_richtofen)) {
                zm_vo::function_2426269b(e_richtofen.origin, 512);
                b_play_vo = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_stuhl_1_5_0");
                if (b_play_vo && level.activeplayers.size > 1) {
                    var_d692d28b = function_47053062(e_richtofen);
                    if (isdefined(var_d692d28b) && isalive(var_d692d28b)) {
                        zm_vo::function_2426269b(var_d692d28b.origin, 512);
                        b_play_vo = var_d692d28b zm_vo::vo_say("vox_plr_" + var_d692d28b.characterindex + "_m_quest_stuhl_1_6_0");
                        if (b_play_vo && isalive(e_richtofen)) {
                            e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_stuhl_1_7_0", 0.5);
                        }
                    }
                }
            }
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x8869b407, Offset: 0x6f90
// Size: 0xac
function function_3e644234(e_player) {
    level notify(#"hash_11fb44a7b531b27d");
    level endon(#"hash_11fb44a7b531b27d", #"hash_36138b6e1d539829");
    if (isalive(e_player)) {
        zm_vo::function_2426269b(e_player.origin, 512);
        e_player zm_vo::vo_say("vox_plr_" + e_player.characterindex + "_m_quest_kron_react_0");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x238466cd, Offset: 0x7048
// Size: 0x126
function function_c142146a() {
    level notify(#"hash_11fb44a7b531b27d");
    level endon(#"hash_11fb44a7b531b27d", #"hash_36138b6e1d539829");
    for (e_player = array::random(level.activeplayers); !isalive(e_player) || e_player zm_zonemgr::get_player_zone() != "zone_model_industries"; e_player = array::random(level.activeplayers)) {
        wait 0.1;
    }
    zm_vo::function_2426269b(e_player.origin, 512);
    b_played_line = e_player zm_vo::vo_say("vox_plr_" + e_player.characterindex + "_m_quest_theft_react_0");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xda36eccb, Offset: 0x7178
// Size: 0x3de
function function_5823f0af() {
    level notify(#"hash_11fb44a7b531b27d");
    level endon(#"hash_11fb44a7b531b27d", #"hash_36138b6e1d539829");
    wait 3;
    e_richtofen = function_6a0e1ac2();
    if (!isdefined(e_richtofen) || !isalive(e_richtofen) || !(isdefined(e_richtofen.var_c6724157) && e_richtofen.var_c6724157)) {
        return;
    }
    e_richtofen playsoundtoplayer("vox_stuh_m_quest_stuhl_2_0_0", e_richtofen);
    wait soundgetplaybacktime("vox_stuh_m_quest_stuhl_2_0_0") * 0.001;
    if (isalive(e_richtofen)) {
        zm_vo::function_2426269b(e_richtofen.origin, 512);
        b_say = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_stuhl_2_1_0");
        if (b_say && isalive(e_richtofen)) {
            e_richtofen playsoundtoplayer("vox_stuh_m_quest_stuhl_2_2_0", e_richtofen);
            wait soundgetplaybacktime("vox_stuh_m_quest_stuhl_2_2_0") * 0.001;
            if (isalive(e_richtofen)) {
                zm_vo::function_2426269b(e_richtofen.origin, 512);
                b_say = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_stuhl_2_3_0");
                if (b_say && level.activeplayers.size > 1) {
                    var_5b77c633 = function_47053062(e_richtofen);
                    if (isdefined(var_5b77c633) && isalive(var_5b77c633)) {
                        zm_vo::function_2426269b(var_5b77c633.origin, 512);
                        b_say = var_5b77c633 zm_vo::vo_say("vox_plr_" + var_5b77c633.characterindex + "_m_quest_stuhl_2_4_0");
                        if (b_say && isalive(e_richtofen)) {
                            e_richtofen playsoundtoplayer("vox_stuh_m_quest_stuhl_2_5_0", e_richtofen);
                            wait soundgetplaybacktime("vox_stuh_m_quest_stuhl_2_5_0") * 0.001;
                            if (isalive(e_richtofen)) {
                                zm_vo::function_2426269b(e_richtofen.origin, 512);
                                b_say = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_stuhl_2_6_0");
                                if (b_say && isalive(e_richtofen)) {
                                    e_richtofen playsoundtoplayer("vox_stuh_m_quest_stuhl_2_7_0", e_richtofen);
                                    wait soundgetplaybacktime("vox_stuh_m_quest_stuhl_2_7_0") * 0.001;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x109cdf9f, Offset: 0x7560
// Size: 0x124
function function_6a0e1ac2(var_e03299f1 = 0) {
    e_richtofen = undefined;
    a_players = level.activeplayers;
    if (var_e03299f1) {
        a_players = level.players;
    }
    foreach (e_player in a_players) {
        if (e_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"))) {
            if (isalive(e_player) || var_e03299f1) {
                e_richtofen = e_player;
                break;
            }
        }
    }
    return e_richtofen;
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xb6ad85c, Offset: 0x7690
// Size: 0x156
function function_47053062(e_richtofen) {
    a_e_players = array::randomize(level.activeplayers);
    var_d692d28b = undefined;
    foreach (e_player in a_e_players) {
        if (!e_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311")) && isalive(e_player) && isalive(e_richtofen) && distancesquared(e_player.origin, e_richtofen.origin) < 589824) {
            var_d692d28b = e_player;
            break;
        }
    }
    return var_d692d28b;
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xcecee92b, Offset: 0x77f0
// Size: 0x230
function function_c0b63a78() {
    self notify(#"hash_dbc4bce5474323a");
    self endon(#"death", #"disconnect", #"hash_dbc4bce5474323a");
    level endon(#"hash_36138b6e1d539829", #"hash_3872b8f91be564bc");
    while (true) {
        if ((self.currentweapon == level.var_3d9066fe || self.currentweapon == level.var_cc1a6c85) && !(isdefined(self.var_5257a535) && self.var_5257a535)) {
            if (isdefined(level.var_476496a5.mdl_bird) && distancesquared(level.var_476496a5.mdl_bird.origin, self.origin) < 262144) {
                n_trace = level.var_476496a5.mdl_bird sightconetrace(self getweaponmuzzlepoint(), self, self getweaponforwarddir());
                if (n_trace > 0.65) {
                    n_line = randomint(5);
                    var_51e76ac1 = n_line + 1;
                    zm_vo::function_2426269b(self.origin, 512);
                    self.var_5257a535 = self zm_vo::vo_say("vox_plr_" + self.characterindex + "_m_quest_icarus_" + var_51e76ac1 + "_" + n_line);
                }
            }
        }
        wait 1;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x55291732, Offset: 0x7a28
// Size: 0x54
function function_158ebef5() {
    self zm_vo::function_2426269b(self.origin, 512);
    self zm_vo::vo_say("vox_plr_" + self.characterindex + "_m_quest_kron_pickup_0");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xb7b0b50d, Offset: 0x7a88
// Size: 0x39c
function function_32217646() {
    level notify(#"hash_11fb44a7b531b27d");
    level endon(#"hash_11fb44a7b531b27d", #"hash_36138b6e1d539829");
    wait 3;
    e_richtofen = function_6a0e1ac2();
    if (!isdefined(e_richtofen) || !isalive(e_richtofen) || !(isdefined(e_richtofen.var_c6724157) && e_richtofen.var_c6724157)) {
        return;
    }
    e_richtofen playsoundtoplayer("vox_stuh_m_quest_stuhl_3_0_0", e_richtofen);
    wait soundgetplaybacktime("vox_stuh_m_quest_stuhl_3_0_0") * 0.001;
    if (isalive(e_richtofen)) {
        zm_vo::function_2426269b(e_richtofen.origin, 512);
        b_say = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_stuhl_3_1_0");
        if (b_say && isalive(e_richtofen)) {
            e_richtofen playsoundtoplayer("vox_stuh_m_quest_stuhl_3_2_0", e_richtofen);
            wait soundgetplaybacktime("vox_stuh_m_quest_stuhl_3_2_0") * 0.001;
            if (isalive(e_richtofen)) {
                zm_vo::function_2426269b(e_richtofen.origin, 512);
                b_say = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_stuhl_3_3_0");
                if (b_say && isalive(e_richtofen)) {
                    var_5b77c633 = function_47053062(e_richtofen);
                    if (isdefined(var_5b77c633)) {
                        zm_vo::function_2426269b(var_5b77c633.origin, 512);
                        b_say = var_5b77c633 zm_vo::vo_say("vox_plr_" + var_5b77c633.characterindex + "_m_quest_stuhl_3_4_0");
                        if (b_say && isalive(e_richtofen)) {
                            e_richtofen playsoundtoplayer("vox_stuh_m_quest_stuhl_3_5_0", e_richtofen);
                            wait soundgetplaybacktime("vox_stuh_m_quest_stuhl_3_5_0") * 0.001;
                            if (isalive(e_richtofen)) {
                                zm_vo::function_2426269b(e_richtofen.origin, 512);
                                b_say = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_stuhl_3_6_0");
                                if (b_say && isalive(e_richtofen)) {
                                    e_richtofen playsoundtoplayer("vox_stuh_m_quest_stuhl_3_7_0", e_richtofen);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x889a5fbb, Offset: 0x7e30
// Size: 0x20c
function function_5a514c5e(e_activator) {
    level notify(#"hash_11fb44a7b531b27d");
    if (!isalive(e_activator)) {
        return;
    }
    zm_vo::function_2426269b(e_activator.origin, 512);
    b_say = e_activator zm_vo::vo_say("vox_plr_" + e_activator.characterindex + "_m_quest_kron_place_0");
    if (b_say && isalive(e_activator) && !e_activator zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"))) {
        e_richtofen = function_6a0e1ac2();
        if (isalive(e_richtofen) && distancesquared(e_richtofen.origin, e_activator.origin) < 589824) {
            zm_vo::function_2426269b(e_richtofen.origin, 768);
            var_73b5f866 = zm_characters::get_character_index(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"));
            e_richtofen zm_vo::vo_say("vox_plr_" + var_73b5f866 + "_m_quest_kron_place_0");
        }
    }
}

/#

    // Namespace paschal/zm_escape_paschal
    // Params 0, eflags: 0x0
    // Checksum 0x2881077f, Offset: 0x8048
    // Size: 0x11c
    function function_9b910b41() {
        zm_devgui::add_custom_devgui_callback(&function_d76b0d6a);
        adddebugcommand("<dev string:x16c>");
        adddebugcommand("<dev string:x1b7>");
        adddebugcommand("<dev string:x202>");
        adddebugcommand("<dev string:x24d>");
        adddebugcommand("<dev string:x298>");
        adddebugcommand("<dev string:x2e3>");
        adddebugcommand("<dev string:x32e>");
        adddebugcommand("<dev string:x379>");
        adddebugcommand("<dev string:x3e5>");
        adddebugcommand("<dev string:x466>");
    }

    // Namespace paschal/zm_escape_paschal
    // Params 1, eflags: 0x0
    // Checksum 0x72cfff5, Offset: 0x8170
    // Size: 0x5e2
    function function_d76b0d6a(cmd) {
        switch (cmd) {
        case #"hash_c8e283d06114e8b":
            var_af330228 = struct::get("<dev string:x4e7>");
            var_af330228.s_unitrigger_stub notify(#"hash_4c6ab2a4a99f9539");
            level thread function_881a1269("<dev string:x4f2>");
            break;
        case #"hash_c8e293d0611503e":
            var_6490632b = struct::get("<dev string:x4ff>");
            var_6490632b notify(#"trigger_activated");
            break;
        case #"hash_c8e2a3d061151f1":
            level notify(#"seagull_blasted");
            zm_devgui::zombie_devgui_goto_round(level.round_number + 1);
            break;
        case #"hash_c8e2b3d061153a4":
            level notify(#"seagull_blasted");
            zm_devgui::zombie_devgui_goto_round(level.round_number + 1);
            break;
        case #"hash_c8e2c3d06115557":
            level notify(#"seagull_blasted");
            zm_devgui::zombie_devgui_goto_round(level.round_number + 1);
            break;
        case #"hash_c8e2d3d0611570a":
            level notify(#"hash_1b94645b5f964ebe");
            break;
        case #"hash_c8e2e3d061158bd":
            var_6490632b = struct::get("<dev string:x50e>");
            var_6490632b notify(#"trigger_activated");
            break;
        case #"hash_39361a1fa06167ab":
            var_9bd6775c = struct::get_array("<dev string:x517>");
            level.a_s_birds = [];
            foreach (s_loc in var_9bd6775c) {
                a_s_birds = struct::get_array(s_loc.target);
                s_loc.var_1e458457 = util::spawn_model(#"hash_91c31763b1101e6", a_s_birds[0].origin, a_s_birds[0].angles);
                s_loc.var_1e458457 clientfield::set("<dev string:x524>" + #"hash_34562274d7e875a4", 1);
                s_loc.var_1e458457.script_noteworthy = "<dev string:x525>";
                s_loc.var_1e458457 thread function_501d6792();
                a_s_birds[0] thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "<dev string:x540>", s_loc.var_1e458457);
                s_book = struct::get(a_s_birds[0].target);
                if (isdefined(s_book)) {
                    s_loc.var_160cc695 = util::spawn_model(#"p7_zm_ctl_book_zombie", s_book.origin, s_book.angles);
                    s_loc.var_160cc695 clientfield::set("<dev string:x524>" + #"hash_6e2f9a57d1bc4b6a", 1);
                }
                if (!isdefined(level.a_s_birds)) {
                    level.a_s_birds = [];
                } else if (!isarray(level.a_s_birds)) {
                    level.a_s_birds = array(level.a_s_birds);
                }
                level.a_s_birds[level.a_s_birds.size] = s_loc;
            }
            foreach (e_player in level.activeplayers) {
                e_player thread function_f7c082c2();
            }
            break;
        case #"hash_62edc78ae04218b":
            level thread function_621f22f0();
            break;
        case #"hash_1f91117ebc8b22a3":
            level thread function_38e82e54();
            break;
        }
    }

    // Namespace paschal/zm_escape_paschal
    // Params 0, eflags: 0x0
    // Checksum 0xf4a76c54, Offset: 0x8760
    // Size: 0x1d0
    function function_f7c082c2() {
        self endon(#"death", #"disconnect");
        while (true) {
            s_result = self waittill(#"throwing_tomahawk");
            e_tomahawk = s_result.e_grenade;
            str_zone = self zm_zonemgr::get_player_zone();
            while (isdefined(e_tomahawk)) {
                foreach (s_seagull in level.a_s_birds) {
                    if (isdefined(str_zone) && str_zone == s_seagull.script_string) {
                        iprintln("<dev string:x553>" + distance(e_tomahawk.origin, s_seagull.var_1e458457 gettagorigin("<dev string:x55e>")));
                        if (distancesquared(e_tomahawk.origin, s_seagull.var_1e458457 gettagorigin("<dev string:x55e>")) < 40000) {
                            iprintln("<dev string:x564>");
                        }
                    }
                }
                wait 0.1;
            }
        }
    }

    // Namespace paschal/zm_escape_paschal
    // Params 0, eflags: 0x0
    // Checksum 0x2fbf9805, Offset: 0x8938
    // Size: 0x72
    function function_621f22f0() {
        level notify(#"hash_600fbb2538368696");
        level endon(#"hash_600fbb2538368696");
        if (isdefined(level.var_10debcec) && level.var_10debcec) {
            level.var_10debcec = 0;
            return;
        }
        level.var_10debcec = 1;
    }

    // Namespace paschal/zm_escape_paschal
    // Params 0, eflags: 0x0
    // Checksum 0xbaaa6611, Offset: 0x89b8
    // Size: 0xf0
    function function_38e82e54() {
        level notify(#"hash_1971ee3d4c0a3ede");
        level endon(#"hash_1971ee3d4c0a3ede");
        if (isdefined(level.var_a4b98c19) && level.var_a4b98c19) {
            level.var_a4b98c19 = 0;
        } else {
            level.var_a4b98c19 = 1;
        }
        while (level.var_a4b98c19) {
            if (isdefined(level.var_476496a5) && isdefined(level.var_476496a5.mdl_bird)) {
                debugstar(level.var_476496a5.mdl_bird.origin, 10, (0, 1, 0));
                waitframe(10);
                continue;
            }
            wait 1;
        }
    }

    // Namespace paschal/zm_escape_paschal
    // Params 0, eflags: 0x0
    // Checksum 0x7d26bf2c, Offset: 0x8ab0
    // Size: 0x78
    function function_501d6792() {
        self setcandamage(1);
        self.health = 100000000;
        while (true) {
            s_result = self waittill(#"blast_attack");
            iprintln("<dev string:x57e>");
        }
    }

#/

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x32ab2556, Offset: 0x8b30
// Size: 0x6c
function step_3(var_4df52d26) {
    level zm_ui_inventory::function_31a39683(#"zm_escape_paschal", 3);
    level thread namespace_8adb45e8::function_1ad1808(var_4df52d26);
    if (!var_4df52d26) {
        level waittill(#"hash_29b90ce9aa921f78");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0xb479f659, Offset: 0x8ba8
// Size: 0x28
function step_3_cleanup(var_4df52d26, var_c86ff890) {
    level notify(#"hash_54eae43edf7f08cd");
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xb14cc0e2, Offset: 0x8bd8
// Size: 0x324
function step_4(var_4df52d26) {
    level zm_ui_inventory::function_31a39683(#"zm_escape_paschal", 4);
    level flag::init(#"hash_67f8280f4ac19125");
    level flag::init(#"hash_2ae01ca8561c1819");
    level flag::init(#"hash_66efd29e4fb12cb5");
    level flag::init(#"hash_46e13471f21f98d0");
    level flag::init(#"hash_6bacf600a3126b18");
    level.var_20c2ed6c[0] spawner::add_spawn_function(&function_8eb25495);
    if (var_4df52d26) {
        level.lighting_state = 2;
        self util::set_lighting_state(level.lighting_state);
        return;
    }
    if (!(isdefined(level.var_a212ab11) && level.var_a212ab11)) {
        function_40071d7c();
        function_2af7aa78();
    }
    level.var_295b09e3 = level.brutus_max_count;
    level.brutus_max_count = 4;
    level.check_for_valid_spawn_near_team_callback = &function_8a3047d4;
    function_53cf4996();
    if (!(isdefined(level.var_a212ab11) && level.var_a212ab11)) {
        function_a91d4a6c();
        function_e9dbe84a();
    }
    wait 3;
    level.lighting_state = 2;
    self util::set_lighting_state(level.lighting_state);
    level.var_7bfcd6cc = undefined;
    function_265c25ac();
    level thread function_9793368a();
    level flag::set(#"hash_2ae01ca8561c1819");
    level thread function_ec6adf95();
    level thread function_a76b3376();
    level waittill(#"hash_66efd29e4fb12cb5");
    level thread function_5dd15798();
    function_ce6a07b3();
    function_b157b8cc();
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0xf662e9c9, Offset: 0x8f08
// Size: 0x47c
function step_4_cleanup(var_4df52d26, var_c86ff890) {
    level flag::set(#"hash_6048c3f423fd987");
    callback::remove_on_spawned(&function_acd62f33);
    exploder::stop_exploder("fxexp_flame_wall_door_glow_recreation_yard");
    exploder::stop_exploder("fxexp_flame_wall_door_glow_shower");
    exploder::stop_exploder("fxexp_flame_wall_door_glow_all");
    zm_bgb_anywhere_but_here::function_f9947cd5(1);
    level.check_for_valid_spawn_near_team_callback = undefined;
    level.var_1169d000 = undefined;
    level thread function_2aeb2960();
    foreach (e_player in level.players) {
        if (isdefined(e_player.s_loadout)) {
            e_player zm_weapons::player_give_loadout(e_player.s_loadout);
            e_player.s_loadout = undefined;
        }
        if (isdefined(e_player.var_43a7260a)) {
            e_player zm_trial_util::function_e023e6a5(e_player.var_43a7260a);
            e_player.var_43a7260a = undefined;
        }
        e_player bgb_pack::function_f27f6f96(0);
    }
    level.var_20c2ed6c[0] spawner::remove_spawn_function(&function_8eb25495);
    if (isdefined(level.var_260d34ca)) {
        zm_escape_util::function_ddd7ade1(level.var_260d34ca);
        level.var_260d34ca = undefined;
    }
    if (!level flag::get(#"hash_2ae01ca8561c1819")) {
        function_8a74f1aa();
    }
    level flag::delete(#"hash_2ae01ca8561c1819");
    var_76e9d85b = getentarray("mdl_p_s_4_clip", "script_noteworthy");
    array::run_all(var_76e9d85b, &delete);
    s_orb = struct::get("s_p_s_4_b_g_p_orb");
    if (isdefined(s_orb.mdl_orb)) {
        s_orb.mdl_orb delete();
    }
    if (isdefined(level.var_295b09e3)) {
        level.brutus_max_count = level.var_295b09e3;
        level.var_295b09e3 = undefined;
    }
    if (isdefined(level.var_e347756f)) {
        if (isdefined(level.var_e347756f.mdl_origin)) {
            level.var_e347756f.mdl_origin delete();
        }
        level.var_e347756f notify(#"delete_seagull");
        level.var_e347756f delete();
        level.var_e347756f = undefined;
    }
    var_c2c87029 = struct::get("p_s_4_bag");
    if (isdefined(var_c2c87029.mdl_bag)) {
        var_c2c87029.mdl_bag delete();
        var_c2c87029.mdl_bag = undefined;
    }
    s_beam = struct::get("s_p_s1_lh_r_light");
    if (isdefined(s_beam.mdl_beam)) {
        s_beam.mdl_beam delete();
    }
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0x73011cdc, Offset: 0x9390
// Size: 0x18c
function function_8a3047d4(e_revivee, s_return) {
    if (!level flag::get(#"hash_46e13471f21f98d0")) {
        a_s_player_spawns = struct::get_array("p_s_4_spawn_start");
    } else if (level flag::get(#"hash_46e13471f21f98d0") && !level flag::get(#"hash_6bacf600a3126b18")) {
        a_s_player_spawns = struct::get_array("catwalk_04_respawn_points");
    } else {
        a_s_player_spawns = struct::get_array("west_side_exterior_upper_02_respawn_points");
    }
    n_player = e_revivee getentitynumber() + 1;
    foreach (s_spawn in a_s_player_spawns) {
        if (s_spawn.script_int == n_player) {
            var_8748162d = s_spawn;
        }
    }
    return var_8748162d;
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xe7822e4b, Offset: 0x9528
// Size: 0x44
function private function_2aeb2960() {
    level endon(#"hash_4fac802bd5dcebf4");
    wait 180;
    pause_zombies(0);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xb4ce7434, Offset: 0x9578
// Size: 0x2cc
function private function_40071d7c() {
    level endon(#"hash_2f5e904d74557a67", #"hash_4ff99434ccb06268");
    level thread scene::init_streamer(#"aib_vign_zm_mob_brutus_revealed", #"allies", 0, 0);
    var_c3b40fda = struct::get_array("s_p_s4_p_st");
    foreach (var_137f1b5b in var_c3b40fda) {
        var_137f1b5b.mdl_prop = util::spawn_model(var_137f1b5b.model, var_137f1b5b.origin, var_137f1b5b.angles);
    }
    var_69faecb8 = struct::get("s_p_s4_s_k_ins");
    var_69faecb8.e_activator = var_69faecb8 zm_unitrigger::function_b7e350e6("", 64);
    var_69faecb8.mdl_key = util::spawn_model(var_69faecb8.model, var_69faecb8.origin, var_69faecb8.angles);
    var_69faecb8.mdl_key clientfield::set("" + #"summoning_key_glow", 1);
    level thread function_761cb28d(var_69faecb8.e_activator);
    foreach (var_137f1b5b in var_c3b40fda) {
        var_137f1b5b.mdl_prop clientfield::set("" + #"hash_3e57db9b106dff0a", 1);
        var_137f1b5b thread function_1508272a();
    }
    level thread function_eb0be5f7();
    level waittill(#"hash_2f5e904d74557a67");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xb22bd097, Offset: 0x9850
// Size: 0x2e8
function private function_1508272a() {
    level endon(#"hash_2f5e904d74557a67");
    while (true) {
        if (isdefined(self.e_owner)) {
            if (isalive(self.e_owner)) {
                if (distance2dsquared(self.e_owner.origin, self.origin) > self.radius * self.radius) {
                    self.e_owner clientfield::set_to_player("rumble_spinning_trap", 0);
                    self.e_owner clientfield::set("" + #"hash_4f58771e117ee3ee", 0);
                    self.e_owner.var_137f1b5b = undefined;
                    self.e_owner = undefined;
                    self.var_5c19739a = undefined;
                    /#
                        iprintln("<dev string:x58e>" + self.script_int);
                    #/
                }
            } else {
                self.e_owner = undefined;
                self.var_5c19739a = undefined;
                /#
                    iprintln("<dev string:x58e>" + self.script_int);
                #/
            }
        } else {
            foreach (e_player in level.players) {
                if (isdefined(e_player.var_137f1b5b)) {
                    continue;
                }
                if (isalive(e_player) && distance2dsquared(e_player.origin, self.origin) < self.radius * self.radius) {
                    self.var_5c19739a = gettime();
                    self.e_owner = e_player;
                    e_player.var_137f1b5b = self;
                    e_player clientfield::set_to_player("rumble_spinning_trap", 1);
                    e_player clientfield::set("" + #"hash_4f58771e117ee3ee", 1);
                    /#
                        iprintln("<dev string:x5b2>" + self.script_int);
                    #/
                    break;
                }
            }
        }
        wait 0.25;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xc5deda49, Offset: 0x9b40
// Size: 0x13c
function private function_eb0be5f7() {
    level endon(#"hash_2f5e904d74557a67");
    var_c3b40fda = struct::get_array("s_p_s4_p_st");
    while (true) {
        n_current_time = gettime();
        var_543ee5c3 = 0;
        foreach (var_137f1b5b in var_c3b40fda) {
            if (isdefined(var_137f1b5b.e_owner) && isdefined(var_137f1b5b.var_5c19739a) && n_current_time - var_137f1b5b.var_5c19739a > 3000) {
                var_543ee5c3++;
            }
        }
        if (var_543ee5c3 == level.players.size) {
            level notify(#"hash_2f5e904d74557a67");
        }
        wait 0.25;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xdc466336, Offset: 0x9c88
// Size: 0x334
function private function_2af7aa78() {
    level endon(#"hash_4ff99434ccb06268");
    if (isdefined(level.var_a212ab11) && level.var_a212ab11) {
        return;
    }
    level flag::set(#"hash_67f8280f4ac19125");
    scene::add_scene_func(#"aib_vign_zm_mob_brutus_revealed", &function_7484f477, "Shot 1");
    foreach (e_player in level.players) {
        e_player clientfield::set("" + #"hash_4f58771e117ee3ee", 0);
        e_player clientfield::set_to_player("rumble_spinning_trap", 0);
        waitframe(1);
    }
    var_c3b40fda = struct::get_array("s_p_s4_p_st");
    foreach (var_137f1b5b in var_c3b40fda) {
        var_137f1b5b.mdl_prop clientfield::set("" + #"hash_3e57db9b106dff0a", 0);
    }
    level thread pause_zombies(1, 0);
    level.musicsystemoverride = 1;
    music::setmusicstate("escape_lockup");
    level thread scene::play(#"p8_fxanim_zm_esc_lighthouse_explosion_bundle", "Main & Idle Loop Out");
    level thread util::delay(5.5, undefined, &function_9515920d);
    s_beam = struct::get("s_p_s1_lh_r_light");
    s_beam.mdl_beam clientfield::set("" + #"hash_1f572bbcdde55d9d", 0);
    waitframe(1);
    s_beam.mdl_beam delete();
    level scene::play(#"aib_vign_zm_mob_brutus_revealed", "Shot 1");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xc2db0daa, Offset: 0x9fc8
// Size: 0x24
function function_9515920d() {
    level util::clientnotify("sndlhouse");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x884dcf96, Offset: 0x9ff8
// Size: 0x3ac
function private function_53cf4996() {
    lui::screen_fade_out(0, "white");
    wait 0.1;
    var_8dc57997 = getent("activate_cellblock_ca", "script_flag");
    if (isdefined(var_8dc57997)) {
        a_e_players = getplayers();
        a_e_players[0] zm_score::add_to_player_score(var_8dc57997.zombie_cost);
        var_8dc57997 notify(#"trigger", {#activator:a_e_players[0], #is_forced:1});
    }
    zm_escape_util::function_ef3caaa9();
    foreach (e_player in level.players) {
        e_player thread function_acd62f33();
    }
    callback::on_spawned(&function_acd62f33);
    exploder::exploder("fxexp_flame_wall_door_glow_shower");
    exploder::exploder("fxexp_flame_wall_door_glow_all");
    exploder::exploder("fxexp_flame_wall_door_glow_recreation_yard");
    zm_bgb_anywhere_but_here::function_f9947cd5(0);
    pause_zombies(1, 0);
    var_c2c87029 = struct::get("p_s_4_bag");
    var_c2c87029.mdl_bag = util::spawn_model(var_c2c87029.model, var_c2c87029.origin, var_c2c87029.angles);
    var_c2c87029 = struct::get(var_c2c87029.target);
    var_c2c87029.s_unitrigger_stub = var_c2c87029 zm_unitrigger::create(&function_773b7064, 64, &function_ef086408);
    scene::add_scene_func("aib_vign_zm_mob_brutus_monologue", &function_bed92832, "play");
    var_76e9d85b = getentarray("mdl_p_s_4_clip", "script_noteworthy");
    array::run_all(var_76e9d85b, &solid);
    wait 2;
    lui::screen_fade_in(2, "white");
    if (!level flag::get(#"hash_67f8280f4ac19125")) {
        level flag::set(#"hash_67f8280f4ac19125");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xd329ea82, Offset: 0xa3b0
// Size: 0x1a4
function function_e9dbe84a() {
    level endon(#"hash_4ff99434ccb06268");
    if (isdefined(level.var_a212ab11) && level.var_a212ab11) {
        return;
    }
    if (!isdefined(level.var_7bfcd6cc)) {
        level.var_1169d000 = 1;
        a_e_brutus = getaiarchetypearray("brutus");
        if (a_e_brutus.size == 0) {
            zombie_brutus_util::attempt_brutus_spawn(1);
            for (a_e_brutus = getaiarchetypearray("brutus"); a_e_brutus.size == 0; a_e_brutus = getaiarchetypearray("brutus")) {
                waitframe(1);
            }
        }
        level.var_7bfcd6cc = a_e_brutus[0];
        level.var_7bfcd6cc.ignore_nuke = 1;
    }
    level thread scene::play(#"aib_vign_zm_mob_brutus_monologue", "play", level.var_7bfcd6cc);
    level waittill(#"hash_29b3019a498b7165");
    zm_escape_util::function_ddd7ade1(level.var_7bfcd6cc);
    level.var_1169d000 = undefined;
    level.musicsystemoverride = 0;
    music::setmusicstate("none");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x664d7cb0, Offset: 0xa560
// Size: 0x134
function private function_acd62f33() {
    self endon(#"disconnect");
    a_s_start_points = struct::get_array("p_s_4_spawn_start");
    n_script_int = self getentitynumber() + 1;
    foreach (s_point in a_s_start_points) {
        if (s_point.script_int == n_script_int) {
            self setorigin(s_point.origin);
            self setplayerangles(s_point.angles);
            break;
        }
    }
    self thread function_4e9917f1();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x72313a81, Offset: 0xa6a0
// Size: 0x6fc
function private function_4e9917f1() {
    self endon(#"disconnect");
    var_f0e32b93 = array(getweapon(#"tomahawk_t8"), getweapon(#"tomahawk_t8_upgraded"), getweapon(#"spoon_alcatraz"), getweapon(#"spork_alcatraz"), getweapon(#"spknifeork"), getweapon(#"knife"));
    var_94f72d74 = [];
    a_w_player_weapons = self getweaponslist();
    foreach (w_player_weapon in a_w_player_weapons) {
        if (isinarray(var_f0e32b93, w_player_weapon)) {
            if (!isdefined(var_94f72d74)) {
                var_94f72d74 = [];
            } else if (!isarray(var_94f72d74)) {
                var_94f72d74 = array(var_94f72d74);
            }
            if (!isinarray(var_94f72d74, w_player_weapon)) {
                var_94f72d74[var_94f72d74.size] = w_player_weapon;
            }
        }
    }
    if (self hasweapon(getweapon(#"zhield_spectral_dw_upgraded"))) {
        self.var_fa288d25 = 1;
        self takeweapon(getweapon(#"zhield_spectral_dw_upgraded"));
    } else if (self hasweapon(getweapon(#"zhield_spectral_dw"))) {
        self.var_dc481ca8 = 1;
        self takeweapon(getweapon(#"zhield_spectral_dw"));
    }
    self.s_loadout = self zm_weapons::player_get_loadout();
    self zm_weapons::player_take_loadout(self.s_loadout);
    self bgb_pack::function_f27f6f96(1);
    if (isinarray(var_94f72d74, getweapon(#"tomahawk_t8_upgraded"))) {
        self giveweapon(getweapon(#"tomahawk_t8_upgraded"));
        self switchtoweapon(getweapon(#"tomahawk_t8_upgraded"), 1);
    } else if (isinarray(var_94f72d74, getweapon(#"tomahawk_t8"))) {
        self giveweapon(getweapon(#"tomahawk_t8"));
        self switchtoweapon(getweapon(#"tomahawk_t8"), 1);
    }
    if (isinarray(var_94f72d74, getweapon(#"spknifeork"))) {
        self giveweapon(getweapon(#"spknifeork"));
        self switchtoweapon(getweapon(#"spknifeork"), 1);
    } else if (isinarray(var_94f72d74, getweapon(#"spork_alcatraz"))) {
        self giveweapon(getweapon(#"spork_alcatraz"));
        self switchtoweapon(getweapon(#"spork_alcatraz"), 1);
    } else if (isinarray(var_94f72d74, getweapon(#"spoon_alcatraz"))) {
        self giveweapon(getweapon(#"spoon_alcatraz"));
        self switchtoweapon(getweapon(#"spoon_alcatraz"), 1);
    } else {
        self giveweapon(getweapon(#"knife"));
        self switchtoweapon(getweapon(#"knife"));
    }
    self disableweapons();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xcb2e9d14, Offset: 0xada8
// Size: 0x368
function function_ef086408() {
    while (true) {
        s_result = self waittill(#"trigger");
        if (isplayer(s_result.activator) && isalive(s_result.activator)) {
            e_player = s_result.activator;
            e_player enableweapons();
            if (isdefined(e_player.s_loadout)) {
                if (e_player.s_loadout.current == getweapon(#"zhield_spectral_dw") || e_player.s_loadout.current == getweapon(#"zhield_spectral_dw_upgraded")) {
                    e_player.var_26a502d8 = 1;
                }
                e_player zm_weapons::player_give_loadout(e_player.s_loadout);
                e_player.s_loadout = undefined;
                level notify(#"hash_71944131dc1aa5f0");
            }
            if (isdefined(e_player.var_43a7260a)) {
                e_player zm_trial_util::function_e023e6a5(e_player.var_43a7260a);
                e_player.var_43a7260a = undefined;
            }
            e_player bgb_pack::function_f27f6f96(0);
            if (isdefined(e_player.var_dc481ca8) && e_player.var_dc481ca8) {
                e_player giveweapon(getweapon(#"zhield_spectral_dw"));
                e_player.var_dc481ca8 = undefined;
                if (isdefined(e_player.var_26a502d8) && e_player.var_26a502d8) {
                    e_player switchtoweapon(getweapon(#"zhield_spectral_dw"));
                    e_player.var_26a502d8 = undefined;
                }
            } else if (isdefined(e_player.var_fa288d25) && e_player.var_fa288d25) {
                e_player giveweapon(getweapon(#"zhield_spectral_dw_upgraded"));
                e_player.var_fa288d25 = undefined;
                if (isdefined(e_player.var_26a502d8) && e_player.var_26a502d8) {
                    e_player switchtoweapon(getweapon(#"zhield_spectral_dw_upgraded"));
                    e_player.var_26a502d8 = undefined;
                }
            }
            if (isdefined(e_player.var_65f7ac63) && e_player.var_65f7ac63 > 0) {
                e_player thread zm_weap_spectral_shield::function_dea8d9ae(1);
            }
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xf59f887f, Offset: 0xb118
// Size: 0x4a
function function_773b7064(player) {
    if (isdefined(player.s_loadout)) {
        self sethintstring(#"hash_d1d8e2ab13aec92");
        return 1;
    }
    return 0;
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xca4827e, Offset: 0xb170
// Size: 0xe4
function private function_8eb25495() {
    if (level flag::get(#"hash_66efd29e4fb12cb5") || !level flag::get(#"hash_67f8280f4ac19125")) {
        return;
    }
    self.ignore_enemy_count = 1;
    self.b_ignore_cleanup = 1;
    self.ignore_find_flesh = 1;
    self ai::set_behavior_attribute("scripted_mode", 1);
    self val::set(#"hash_1742bf14f2dc303f", "ignoreall", 1);
    self zombie_utility::set_zombie_run_cycle("walk");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xea47289c, Offset: 0xb260
// Size: 0x8c
function private function_abefc69f() {
    self endon(#"death");
    self.ignore_find_flesh = 0;
    self ai::set_behavior_attribute("scripted_mode", 0);
    self val::set(#"hash_1742bf14f2dc303f", "ignoreall", 0);
    self zombie_utility::set_zombie_run_cycle("run");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xf13c6c64, Offset: 0xb2f8
// Size: 0x30c
function private function_265c25ac() {
    s_seagull = struct::get("s_p_s4_gul");
    level.var_e347756f = util::spawn_model(#"hash_91c31763b1101e6", s_seagull.origin, s_seagull.angles);
    level.var_e347756f clientfield::set("" + #"seagull_fx", 1);
    level.var_e347756f clientfield::set("" + #"hash_34562274d7e875a4", 1);
    level.var_e347756f.mdl_origin = util::spawn_model("tag_origin", level.var_e347756f.origin, level.var_e347756f.angles);
    level.var_e347756f linkto(level.var_e347756f.mdl_origin);
    level.var_e347756f move_seagull(s_seagull.target);
    level.var_e347756f.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "attack", level.var_e347756f);
    level.var_e347756f waittill(#"att_fx");
    v_position = function_cfee2a04(level.var_e347756f.origin, 512);
    if (isdefined(v_position)) {
        level.var_e347756f.var_4661abd8 = util::spawn_model("tag_origin", v_position[#"point"], level.var_e347756f.angles);
        level.var_e347756f.var_4661abd8 clientfield::set("" + #"hash_7c708a514455bf88", 1);
    }
    var_8ceada94 = getent("p_s_4_box", "script_string");
    var_8ceada94 notify(#"blast_attack");
    exploder::exploder("bx_cellblock_off");
    function_8a74f1aa();
    level.var_e347756f thread move_seagull("s_p4_gull_wait_0", undefined, 500);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x675a007f, Offset: 0xb610
// Size: 0x258
function private function_8a74f1aa() {
    var_96cc30fd = getent("lockup_door_1", "targetname");
    var_bcceab66 = getent("lockup_door_2", "targetname");
    var_e2d125cf = getent("lockup_door_3", "targetname");
    var_d8bfccf0 = getent("lockup_door_4", "targetname");
    var_96cc30fd movex(39 * -1, 1);
    var_bcceab66 movex(39 * -1, 1);
    var_e2d125cf movex(39, 1);
    var_d8bfccf0 movex(39, 1);
    playsoundatposition(#"hash_2903807228236fbc", var_96cc30fd.origin);
    playsoundatposition(#"hash_2903807228236fbc", var_bcceab66.origin);
    playsoundatposition(#"hash_2903807228236fbc", var_e2d125cf.origin);
    playsoundatposition(#"hash_2903807228236fbc", var_d8bfccf0.origin);
    foreach (e_player in level.activeplayers) {
        e_player enableweapons();
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x2b54edcd, Offset: 0xb870
// Size: 0x294
function private function_a76b3376() {
    level endon(#"hash_6048c3f423fd987");
    level.var_e347756f thread function_7296b4be();
    level.s_brutus_spawn = struct::get("p_s_4_br_patrol_spawn");
    if (!isdefined(level.var_260d34ca)) {
        level.var_260d34ca = zombie_utility::spawn_zombie(level.var_20c2ed6c[0], undefined, level.s_brutus_spawn);
    }
    level.var_260d34ca thread function_e786d75b(level.s_brutus_spawn);
    level.var_260d34ca thread function_c4a7d21f(5);
    level.var_260d34ca thread function_a87f12ec("zone_start");
    level thread function_7890165a("s_player_in_library_t", "p_s_4_br_patrol_spawn_2", 1);
    level thread function_6f1054b3("zone_cellblock_west", #"hash_3fbae87a461a2833");
    level thread function_844fe6bc();
    level thread function_c3402701();
    level waittill(#"hash_3fbae87a461a2833");
    level thread function_121e2d90("s_player_in_cd_street_t", #"hash_27676df2bce09242");
    level waittill(#"hash_27676df2bce09242");
    level thread function_6f1054b3("zone_library", #"hash_3ae7273b29d5ffee");
    level waittill(#"hash_3ae7273b29d5ffee");
    level thread function_121e2d90("s_player_in_d_block_t", #"hash_1eb5db47aabd9f93");
    level waittill(#"hash_1eb5db47aabd9f93");
    level thread function_6f1054b3("zone_cellblock_entrance", #"hash_74f17d1c19851203");
    level waittill(#"hash_74f17d1c19851203");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x2bccfa85, Offset: 0xbb10
// Size: 0x1d4
function private function_7296b4be() {
    s_result = level waittill(#"hash_71944131dc1aa5f0", #"hash_3fbae87a461a2833");
    if (s_result._notify == #"hash_71944131dc1aa5f0") {
        self thread move_seagull("s_p4_gull_wait_1", #"hash_27676df2bce09242", 500);
        level waittill(#"hash_3fbae87a461a2833", #"hash_585f05da94c76f1c");
    }
    self thread move_seagull("s_p4_gull_wait_2", #"hash_3ae7273b29d5ffee", 500);
    level waittill(#"hash_27676df2bce09242", #"hash_585f05da94c76f1c");
    self thread move_seagull("s_p4_gull_wait_3", #"hash_1eb5db47aabd9f93", 500);
    level waittill(#"hash_3ae7273b29d5ffee");
    self thread move_seagull("s_p4_gull_wait_4", #"hash_1eb5db47aabd9f93", 500);
    level waittill(#"hash_1eb5db47aabd9f93", #"hash_5694107be23fa3c2");
    self thread move_seagull("s_p4_gull_wait_5", #"hash_74f17d1c19851203", 500);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x65b27adc, Offset: 0xbcf0
// Size: 0xf8
function private function_66577a71() {
    level endon(#"hash_6048c3f423fd987");
    self endon(#"hash_3ae5db037968d6de");
    while (true) {
        foreach (e_player in level.activeplayers) {
            if (distance2dsquared(self.origin, e_player.origin) < 128 * 128) {
                self notify(#"player_close");
            }
        }
        wait 0.1;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x4
// Checksum 0xe8a0e323, Offset: 0xbdf0
// Size: 0x102
function private function_e786d75b(s_brutus_spawn) {
    self endon(#"death", #"damage", #"brutus_attack_players");
    level endon(#"hash_6048c3f423fd987");
    self endon(#"teleport_brutus");
    for (s_next = struct::get(s_brutus_spawn.target); isdefined(s_next); s_next = struct::get(s_next.target)) {
        self setgoal(s_next.origin, 1);
        self waittill(#"goal");
        level.s_brutus_spawn = s_next;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x4
// Checksum 0xc129f8e3, Offset: 0xbf00
// Size: 0x98
function private function_a87f12ec(var_c663e2fd) {
    self endon(#"death", #"brutus_attack_players");
    while (true) {
        str_zone = zm_zonemgr::get_zone_from_position(self.origin);
        if (isdefined(str_zone) && str_zone == var_c663e2fd) {
            level notify(#"hash_585f05da94c76f1c");
            break;
        }
        wait 1;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x4
// Checksum 0x4c29d78d, Offset: 0xbfa0
// Size: 0x1f8
function private function_c4a7d21f(n_wait) {
    self endon(#"death");
    self endoncallback(&function_bfee8839, #"damage", #"brutus_attack_players");
    level endon(#"hash_6048c3f423fd987");
    if (isdefined(n_wait) && isfloat(n_wait)) {
        wait n_wait;
    }
    var_795761fb = 0;
    while (true) {
        var_e256f022 = 0;
        foreach (e_player in level.activeplayers) {
            if (distance2dsquared(e_player.origin, self.origin) < 192 * 192) {
                var_e256f022 = 1;
                if (distance2dsquared(e_player.origin, self.origin) < 64 * 64) {
                    self notify(#"brutus_attack_players");
                }
            }
        }
        if (var_e256f022) {
            var_795761fb++;
        } else {
            var_795761fb--;
            if (var_795761fb < 0) {
                var_795761fb = 0;
            }
        }
        if (var_795761fb >= 15) {
            self notify(#"brutus_attack_players");
        }
        waitframe(1);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x7e3542f5, Offset: 0xc1a0
// Size: 0x74
function function_bfee8839(str_notify) {
    self endon(#"death");
    self thread function_abefc69f();
    n_line = randomint(5);
    self playsound("vox_ward_m_quest_ward_alert_" + n_line);
}

// Namespace paschal/zm_escape_paschal
// Params 3, eflags: 0x0
// Checksum 0xc0313d50, Offset: 0xc220
// Size: 0x24c
function function_7890165a(str_target, str_teleport_name, var_aa041974 = 0) {
    level.var_260d34ca endon(#"brutus_attack_players", #"death");
    s_check = struct::get(str_target);
    b_continue = 1;
    while (b_continue) {
        foreach (e_player in level.players) {
            if (distance2dsquared(e_player.origin, s_check.origin) < s_check.radius * s_check.radius) {
                b_continue = 0;
                break;
            }
        }
        waitframe(1);
    }
    if (level.var_260d34ca ai::get_behavior_attribute("scripted_mode")) {
        level.var_260d34ca notify(#"teleport_brutus");
        level.var_260d34ca clientfield::set("brutus_spawn_clientfield", 0);
        level.s_brutus_spawn = struct::get(str_teleport_name);
        level.var_260d34ca forceteleport(level.s_brutus_spawn.origin, level.s_brutus_spawn.angles);
        waitframe(1);
        level.var_260d34ca clientfield::set("brutus_spawn_clientfield", 1);
        level.var_260d34ca function_e786d75b(level.s_brutus_spawn);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x4
// Checksum 0x82bed2aa, Offset: 0xc478
// Size: 0x68
function private function_6f1054b3(str_zone, var_e34146dc) {
    level endon(var_e34146dc);
    while (true) {
        n_players = zm_zonemgr::get_players_in_zone(str_zone);
        if (n_players > 0) {
            level notify(var_e34146dc);
        }
        wait 0.1;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0x82b12465, Offset: 0xc4e8
// Size: 0xde
function function_121e2d90(str_name, var_e34146dc) {
    level endon(var_e34146dc);
    var_bee53d74 = struct::get(str_name);
    t_detect = spawn("trigger_radius", var_bee53d74.origin, 0, var_bee53d74.radius, 100);
    t_detect setteamfortrigger(#"allies");
    s_result = t_detect waittill(#"trigger");
    t_detect delete();
    level notify(var_e34146dc);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xea6b210, Offset: 0xc5d0
// Size: 0x10c
function private function_c3402701() {
    var_bbf870dc = getnode("nd_d_p_p", "targetname");
    level.var_fde0e30a = zombie_utility::spawn_zombie(level.dog_spawners[0], var_bbf870dc.origin);
    waitframe(1);
    level.var_fde0e30a zm_escape_util::function_389bc4e7(var_bbf870dc);
    level.var_fde0e30a ai::set_behavior_attribute("sprint", 0);
    s_path = zm_ai_utility::get_pathnode_path(var_bbf870dc);
    zm_ai_utility::start_patrol(level.var_fde0e30a, s_path.path, 1);
    level.var_fde0e30a thread function_2d60dc97();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x98ab7773, Offset: 0xc6e8
// Size: 0x120
function private function_2d60dc97() {
    self endon(#"death");
    self endoncallback(&function_a56df3d2, #"damage", #"detected_players");
    while (true) {
        foreach (e_player in level.players) {
            if (isalive(e_player) && distance2dsquared(e_player.origin, self.origin) < 147456) {
                self notify(#"detected_players");
            }
        }
        wait 0.1;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xa2fc949c, Offset: 0xc810
// Size: 0x24
function function_a56df3d2(str_notify) {
    zm_ai_utility::stop_patrol(self);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x67ca34fa, Offset: 0xc840
// Size: 0xc4
function private function_ec6adf95() {
    level endon(#"hash_6048c3f423fd987");
    level waittill(#"hash_1eb5db47aabd9f93");
    s_brutus_spawn = struct::get("p_s_4_br_stun_spawn");
    var_8042a6d1 = zombie_utility::spawn_zombie(level.var_20c2ed6c[0]);
    waitframe(1);
    var_8042a6d1 forceteleport(s_brutus_spawn.origin, s_brutus_spawn.angles);
    var_8042a6d1 thread function_81207cce();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x17bf3ef0, Offset: 0xc910
// Size: 0x1d6
function private function_81207cce() {
    self endoncallback(&function_3dda12d1, #"damage", #"detected_players");
    self endon(#"death");
    b_continue = 1;
    s_detect = struct::get("s_br_detect");
    while (b_continue) {
        foreach (e_player in level.players) {
            if (distance2dsquared(e_player.origin, s_detect.origin) < s_detect.radius * s_detect.radius) {
                str_zone = e_player zm_zonemgr::get_player_zone();
                if (self sightconetrace(e_player getweaponmuzzlepoint(), e_player, e_player getweaponforwarddir(), 65) || isdefined(str_zone) && str_zone == "zone_cellblock_entrance") {
                    b_continue = 0;
                    break;
                }
            }
        }
        waitframe(1);
    }
    self notify(#"detected_players");
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x6f695606, Offset: 0xcaf0
// Size: 0x3c
function function_3dda12d1(str_notify) {
    self function_abefc69f();
    level thread function_4eabcc3f(self);
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x4
// Checksum 0x3f6f806a, Offset: 0xcb38
// Size: 0x23c
function private function_4eabcc3f(e_brutus) {
    e_brutus val::set(#"hash_54a371c662e546eb", "allowdeath", 0);
    while (distance2dsquared(e_brutus.origin, level.var_e347756f.mdl_origin.origin) > 147456) {
        waitframe(1);
    }
    level.var_e347756f.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "attack", level.var_e347756f);
    level.var_e347756f waittill(#"att_fx");
    v_position = function_cfee2a04(level.var_e347756f.origin, 512);
    if (isdefined(v_position)) {
        if (isdefined(level.var_e347756f.var_4661abd8)) {
            level.var_e347756f.var_4661abd8 delete();
            waitframe(1);
        }
        level.var_e347756f.var_4661abd8 = util::spawn_model("tag_origin", v_position[#"point"], level.var_e347756f.angles);
        level.var_e347756f.var_4661abd8 clientfield::set("" + #"hash_7c708a514455bf88", 1);
    }
    e_brutus ai::stun(1);
    e_brutus val::reset(#"hash_54a371c662e546eb", "allowdeath");
    level flag::set(#"hash_66efd29e4fb12cb5");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xe40b675e, Offset: 0xcd80
// Size: 0x2a4
function private function_ce6a07b3() {
    level endon(#"hash_6048c3f423fd987");
    callback::remove_on_spawned(&function_acd62f33);
    level.var_e347756f thread function_88af246f();
    wait 1;
    level thread function_f88bd14f();
    level thread function_c65e11cf();
    level thread function_59854c6();
    level thread function_cc554d04();
    level thread function_ac84f602();
    level thread function_ef6dc90b();
    level thread function_121e2d90("s_player_w_g_1", #"s_player_w_g_1");
    level thread function_121e2d90("s_player_w_g_2", #"s_player_w_g_2");
    level thread function_121e2d90("s_player_w_g_3", #"s_player_w_g_3");
    level thread function_121e2d90("s_player_w_g_4", #"s_player_w_g_4");
    level thread function_121e2d90("s_player_w_g_5", #"s_player_w_g_5");
    level thread function_121e2d90("s_player_w_g_6", #"s_player_w_g_6");
    a_s_dog_spawn = struct::get_array("s_p_s_4_c_d_s");
    foreach (s_spawn in a_s_dog_spawn) {
        s_spawn thread function_6b49f9c2();
    }
    level flag::wait_till(#"hash_6bacf600a3126b18");
    function_9cc49e99();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x5f029ff, Offset: 0xd030
// Size: 0x1e4
function function_88af246f() {
    level endon(#"hash_6048c3f423fd987");
    self thread move_seagull("s_p4_gull_wait_6", #"s_player_w_g_1", 500);
    level waittill(#"s_player_w_g_1");
    self thread move_seagull("s_p4_gull_wait_7", #"s_player_w_g_2", 500);
    level waittill(#"s_player_w_g_2");
    self thread move_seagull("s_p4_gull_wait_8", #"s_player_w_g_3", 500);
    level waittill(#"s_player_w_g_3");
    self thread move_seagull("s_p4_gull_wait_9", #"s_player_w_g_4", 500);
    level waittill(#"s_player_w_g_4");
    self thread move_seagull("s_p4_gull_wait_10", #"s_player_w_g_5", 500);
    level waittill(#"s_player_w_g_5");
    self thread move_seagull("s_p4_gull_wait_11", #"s_player_w_g_6", 500);
    level waittill(#"s_player_w_g_6");
    self thread move_seagull("s_p4_gull_wait_12", undefined, 500);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xe45e7cf1, Offset: 0xd220
// Size: 0xf4
function private function_f88bd14f() {
    level endon(#"hash_6048c3f423fd987");
    var_8628c2fc = getent("mdl_p_s_4_clip_entrance", "targetname");
    var_8628c2fc notsolid();
    var_8628c2fc ghost();
    exploder::stop_exploder("fxexp_flame_wall_door_glow_recreation_yard");
    level flag::wait_till(#"hash_46e13471f21f98d0");
    var_8628c2fc show();
    var_8628c2fc solid();
    exploder::exploder("fxexp_flame_wall_door_glow_recreation_yard");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x6ed5485a, Offset: 0xd320
// Size: 0x88
function private function_c65e11cf() {
    level endon(#"hash_6048c3f423fd987", #"hash_46e13471f21f98d0");
    while (true) {
        var_1d246650 = function_111422ac();
        if (var_1d246650 == 0) {
            level flag::set(#"hash_46e13471f21f98d0");
        }
        wait 0.1;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xb2871526, Offset: 0xd3b0
// Size: 0x15c
function private function_844fe6bc() {
    level endon(#"hash_6048c3f423fd987");
    level.var_260d34ca endon(#"death", #"brutus_attack_players");
    if (!isdefined(level.var_260d34ca)) {
        return;
    }
    s_kill = struct::get("s_br_kill");
    b_continue = 1;
    while (b_continue) {
        if (distance2dsquared(level.var_260d34ca.origin, s_kill.origin) < s_kill.radius * s_kill.radius) {
            b_continue = 0;
        }
        waitframe(1);
    }
    if (isalive(level.var_260d34ca) && level.var_260d34ca ai::get_behavior_attribute("scripted_mode")) {
        level notify(#"hash_5694107be23fa3c2");
        zm_escape_util::function_ddd7ade1(level.var_260d34ca);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xea1076ce, Offset: 0xd518
// Size: 0xe0
function private function_111422ac() {
    a_str_zones = array("zone_cellblock_entrance", "zone_cellblock_east", "zone_start", "zone_library", "zone_cellblock_west", "zone_broadway_floor_2", "zone_cellblock_west_gondola");
    var_1d246650 = 0;
    foreach (str_zone in a_str_zones) {
        var_1d246650 += zm_zonemgr::get_players_in_zone(str_zone);
    }
    return var_1d246650;
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xe72b2e89, Offset: 0xd600
// Size: 0xf0
function private function_59854c6() {
    level endoncallback(&function_ffa0fd95, #"hash_46e13471f21f98d0");
    level endon(#"hash_6048c3f423fd987");
    while (true) {
        wait 5;
        foreach (e_player in level.activeplayers) {
            if (level.brutus_count < level.brutus_max_count) {
                zombie_brutus_util::attempt_brutus_spawn(1);
                break;
            }
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x532e6965, Offset: 0xd6f8
// Size: 0x96
function function_ffa0fd95(str_notify) {
    a_e_brutus = getaiarchetypearray("brutus");
    if (a_e_brutus.size > 1) {
        for (i = 0; i < a_e_brutus.size - 1; i++) {
            e_brutus = a_e_brutus[i];
            level thread zm_escape_util::function_ddd7ade1(e_brutus);
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x4ae23c0a, Offset: 0xd798
// Size: 0x88
function private function_cc554d04() {
    level endon(#"hash_6048c3f423fd987", #"hash_6bacf600a3126b18");
    while (true) {
        a_e_brutus = getaiarchetypearray("brutus");
        if (a_e_brutus.size == 0) {
            zombie_brutus_util::attempt_brutus_spawn(1);
        }
        wait 2;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xd41d3c43, Offset: 0xd828
// Size: 0x190
function private function_6b49f9c2() {
    level endon(#"hash_6048c3f423fd987");
    self.t_detect = spawn("trigger_radius", self.origin, 0, self.radius, 200);
    self.t_detect setteamfortrigger(#"allies");
    self.t_detect waittill(#"trigger");
    self.t_detect delete();
    a_s_dog_spawns = struct::get_array(self.target);
    foreach (s_dog_spawn in a_s_dog_spawns) {
        e_dog = zombie_utility::spawn_zombie(level.dog_spawners[0]);
        waitframe(1);
        if (isalive(e_dog)) {
            e_dog thread zm_escape_util::function_389bc4e7(s_dog_spawn);
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xe0bed0ab, Offset: 0xd9c0
// Size: 0x7b0
function private function_ef6dc90b() {
    level endon(#"hash_6048c3f423fd987", #"hash_6bacf600a3126b18");
    var_ab729287 = [];
    var_a16139a8 = [];
    var_c763b411 = [];
    var_ed662e7a = [];
    var_c9904bba = [];
    var_3df385f2 = struct::get_array("dog_location", "script_noteworthy");
    foreach (s_loc in var_3df385f2) {
        switch (s_loc.targetname) {
        case #"hash_2fabd8fdb4f5a1a3":
            if (!isdefined(var_ed662e7a)) {
                var_ed662e7a = [];
            } else if (!isarray(var_ed662e7a)) {
                var_ed662e7a = array(var_ed662e7a);
            }
            if (!isinarray(var_ed662e7a, s_loc)) {
                var_ed662e7a[var_ed662e7a.size] = s_loc;
            }
            break;
        case #"hash_12643042b422bb7c":
            if (!isdefined(var_c763b411)) {
                var_c763b411 = [];
            } else if (!isarray(var_c763b411)) {
                var_c763b411 = array(var_c763b411);
            }
            if (!isinarray(var_c763b411, s_loc)) {
                var_c763b411[var_c763b411.size] = s_loc;
            }
            break;
        case #"hash_16a7184ca95fade1":
            if (!isdefined(var_a16139a8)) {
                var_a16139a8 = [];
            } else if (!isarray(var_a16139a8)) {
                var_a16139a8 = array(var_a16139a8);
            }
            if (!isinarray(var_a16139a8, s_loc)) {
                var_a16139a8[var_a16139a8.size] = s_loc;
            }
            break;
        case #"hash_116cd8a82caef692":
            if (!isdefined(var_ab729287)) {
                var_ab729287 = [];
            } else if (!isarray(var_ab729287)) {
                var_ab729287 = array(var_ab729287);
            }
            if (!isinarray(var_ab729287, s_loc)) {
                var_ab729287[var_ab729287.size] = s_loc;
            }
            break;
        case #"hash_766712dab6b3164c":
            if (!isdefined(var_c9904bba)) {
                var_c9904bba = [];
            } else if (!isarray(var_c9904bba)) {
                var_c9904bba = array(var_c9904bba);
            }
            if (!isinarray(var_c9904bba, s_loc)) {
                var_c9904bba[var_c9904bba.size] = s_loc;
            }
            break;
        }
    }
    while (true) {
        a_ai = getaiteamarray(level.zombie_team);
        if (a_ai.size > 4) {
            wait randomfloatrange(3, 5);
            continue;
        }
        var_ed662e7a = array::randomize(var_ed662e7a);
        var_c763b411 = array::randomize(var_c763b411);
        var_a16139a8 = array::randomize(var_a16139a8);
        var_ab729287 = array::randomize(var_ab729287);
        var_c9904bba = array::randomize(var_c9904bba);
        var_6a0090cb = zm_zonemgr::get_players_in_zone("zone_catwalk_01", 1);
        var_f7f92190 = zm_zonemgr::get_players_in_zone("zone_catwalk_02", 1);
        var_1dfb9bf9 = zm_zonemgr::get_players_in_zone("zone_catwalk_03", 1);
        var_dc080006 = zm_zonemgr::get_players_in_zone("zone_catwalk_04", 1);
        var_3a39ac04 = zm_zonemgr::get_players_in_zone("zone_cellblock_entrance", 1);
        if (var_6a0090cb.size > 0) {
            s_loc = arraygetfarthest(var_6a0090cb[0].origin, var_c9904bba, 512);
        } else if (var_f7f92190.size > 0) {
            s_loc = arraygetfarthest(var_f7f92190[0].origin, var_ed662e7a, 512);
            if (!isdefined(s_loc)) {
                s_loc = arraygetclosest(var_f7f92190[0].origin, var_c9904bba, 512);
            }
        } else if (var_1dfb9bf9.size > 0) {
            s_loc = arraygetfarthest(var_1dfb9bf9[0].origin, var_c763b411, 512);
            if (!isdefined(s_loc)) {
                s_loc = arraygetclosest(var_1dfb9bf9[0].origin, var_ed662e7a, 512);
            }
        } else if (var_dc080006.size > 0) {
            s_loc = arraygetfarthest(var_dc080006[0].origin, var_a16139a8, 512);
            if (!isdefined(s_loc)) {
                s_loc = arraygetclosest(var_dc080006[0].origin, var_c763b411, 512);
            }
            s_loc = array::random(var_a16139a8);
        } else if (var_3a39ac04.size > 0) {
            s_loc = arraygetfarthest(var_3a39ac04[0].origin, var_ab729287, 512);
            if (!isdefined(s_loc)) {
                s_loc = arraygetclosest(var_3a39ac04[0].origin, var_a16139a8, 512);
            }
            s_loc = array::random(var_ab729287);
        }
        if (isdefined(s_loc)) {
            e_dog = zombie_utility::spawn_zombie(level.dog_spawners[0]);
            waitframe(1);
            e_dog thread zm_escape_util::function_389bc4e7(s_loc);
        }
        wait randomfloatrange(5, 7);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x7db8b19d, Offset: 0xe178
// Size: 0x90
function private function_ac84f602() {
    level endon(#"hash_6048c3f423fd987", #"hash_6bacf600a3126b18");
    while (true) {
        n_players = zm_zonemgr::get_players_in_zone("zone_west_side_exterior_upper_02");
        if (n_players > 0) {
            level flag::set(#"hash_6bacf600a3126b18");
        }
        wait 0.1;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xe21474ee, Offset: 0xe210
// Size: 0xa0
function private function_9cc49e99() {
    a_e_brutus = getaiarchetypearray("brutus");
    foreach (e_brutus in a_e_brutus) {
        level thread zm_escape_util::function_ddd7ade1(e_brutus);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xb6379d11, Offset: 0xe2b8
// Size: 0x536
function private function_b157b8cc() {
    level endon(#"hash_6048c3f423fd987");
    scene::add_scene_func(#"hash_314849ff967504f5", &function_a82b9916, "play");
    s_orb = struct::get("s_p_s_4_b_g_p_orb");
    s_orb.mdl_orb = util::spawn_model(s_orb.model, s_orb.origin, s_orb.angles);
    s_orb.mdl_orb ghost();
    var_c6c0e8f3 = struct::get("s_p_s_4_b_g_p");
    var_f1a89e99 = 0;
    while (!var_f1a89e99) {
        foreach (e_player in level.players) {
            if (distance2dsquared(e_player.origin, var_c6c0e8f3.origin) <= var_c6c0e8f3.radius * var_c6c0e8f3.radius) {
                var_f1a89e99 = 1;
                break;
            }
        }
        if (!var_f1a89e99) {
            wait 0.1;
        }
    }
    var_ef2153bb = struct::get("s_p_s_4_b_r_s");
    var_ef2153bb thread scene::play(var_ef2153bb.scriptbundlename, "Shot 1");
    var_ef2153bb.scene_ents[#"brutus"] waittill(#"play_fx");
    var_ef2153bb.scene_ents[#"brutus"] clientfield::increment("" + #"hash_2b6e463a7a482630");
    var_ef2153bb.scene_ents[#"brutus"] waittill(#"teleport");
    var_ef2153bb.scene_ents[#"brutus"] ghost();
    level thread scene::play("s_p_s_4_b_g_p_s", "play");
    level waittill(#"drop_o");
    s_orb.mdl_orb show();
    var_1ea28db = struct::get(s_orb.target);
    s_orb.mdl_orb moveto(var_1ea28db.origin, 0.5);
    s_orb.mdl_orb waittill(#"movedone");
    level thread function_1f6aa03();
    level.var_e347756f.mdl_origin moveto(level.var_e347756f.mdl_origin.origin + vectornormalize(anglestoforward(level.var_e347756f.mdl_origin.angles)) * 48, 1);
    level.var_e347756f.mdl_origin scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "dissolve", level.var_e347756f);
    level.var_e347756f.mdl_origin clientfield::set("" + #"hash_592c96b2803d9fd5", 1);
    level.var_e347756f ghost();
    var_1ea28db = struct::get(var_1ea28db.target);
    var_1ea28db.s_unitrigger_stub = var_1ea28db zm_unitrigger::function_b7e350e6("", 64);
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xb87ec071, Offset: 0xe7f8
// Size: 0x184
function function_a82b9916(a_ents) {
    e_brutus = a_ents[#"brutus"];
    e_brutus thread zombie_utility::delayed_zombie_eye_glow();
    e_brutus clientfield::set("" + #"hash_df589cc30f4c7dd", 1);
    var_7431c062 = a_ents[#"ghost_1"];
    var_4e2f45f9 = a_ents[#"ghost_2"];
    var_282ccb90 = a_ents[#"ghost_3"];
    var_7431c062 clientfield::set("" + #"hash_34562274d7e875a4", 1);
    var_4e2f45f9 clientfield::set("" + #"hash_34562274d7e875a4", 1);
    var_282ccb90 clientfield::set("" + #"hash_34562274d7e875a4", 1);
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x4
// Checksum 0xb59178aa, Offset: 0xe988
// Size: 0x28c
function private function_761cb28d(e_activator) {
    level endon(#"end_game", #"hash_2f5e904d74557a67");
    zm_vo::function_2426269b(e_activator.origin, 512);
    b_say = e_activator zm_vo::vo_say("vox_plr_" + e_activator.characterindex + "_m_quest_summon_key_0_0");
    if (b_say) {
        if (e_activator zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"))) {
            e_richtofen = e_activator;
        }
        if (level.players.size > 1 && !e_activator zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"))) {
            e_richtofen = function_6a0e1ac2();
            if (isalive(e_richtofen)) {
                b_say = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_summon_key_0_0");
            }
        }
        if (b_say && isdefined(e_richtofen) && isalive(e_richtofen) && isdefined(e_richtofen.var_c6724157) && e_richtofen.var_c6724157) {
            e_richtofen playsoundtoplayer(#"hash_e35061d74fae6d1", e_richtofen);
            wait soundgetplaybacktime(#"hash_e35061d74fae6d1") * 0.001;
            if (isalive(e_richtofen)) {
                zm_vo::function_2426269b(e_richtofen.origin, 512);
                e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_summon_key_2_0");
            }
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xf47c1a6d, Offset: 0xec20
// Size: 0x30c
function function_7484f477(a_ents) {
    level endon(#"hash_4ff99434ccb06268");
    if (isdefined(level.var_a212ab11) && level.var_a212ab11) {
        return;
    }
    zm_vo::function_2426269b(a_ents[#"brutus"].origin, 1024);
    foreach (e_player in level.players) {
        e_player zm_vo::function_2426269b(e_player.origin, 512);
    }
    a_ents[#"brutus"] waittill(#"b_at_l");
    wait soundgetplaybacktime(#"hash_4f85660ed0a84967") * 0.001;
    e_player = array::random(level.players);
    e_player zm_vo::function_2426269b(e_player.origin, 512);
    e_player zm_vo::vo_say("vox_plr_" + e_player.characterindex + "_m_quest_ward_trap_1_0");
    if (e_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"))) {
        e_richtofen = e_player;
    } else if (level.players.size > 1) {
        e_richtofen = function_6a0e1ac2();
    }
    if (isdefined(e_richtofen) && e_richtofen != e_player) {
        e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_ward_trap_1_0");
    }
    if (isdefined(e_richtofen) && isdefined(e_richtofen.var_c6724157) && e_richtofen.var_c6724157) {
        e_richtofen playsoundtoplayer("vox_stuh_m_quest_ward_trap_2_0", e_richtofen);
    }
    a_ents[#"brutus"] waittill(#"b_fade");
    level lui::screen_fade_out(1.5, "white");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x5cf32fbb, Offset: 0xef38
// Size: 0x20c
function private function_a91d4a6c() {
    level endon(#"hash_4ff99434ccb06268");
    if (isdefined(level.var_a212ab11) && level.var_a212ab11) {
        return;
    }
    e_random_player = array::random(level.activeplayers);
    e_random_player zm_vo::vo_say("vox_plr_" + e_random_player.characterindex + "_m_quest_lock_solo_0");
    e_richtofen = function_6a0e1ac2();
    if (isdefined(e_richtofen) && isdefined(e_richtofen.var_c6724157) && e_richtofen.var_c6724157) {
        e_richtofen playsoundtoplayer("vox_stuh_m_quest_lock_solo_rich_0_0", e_richtofen);
        wait soundgetplaybacktime("vox_stuh_m_quest_lock_solo_rich_0_0") * 0.001;
        if (isalive(e_richtofen)) {
            b_say = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_lock_solo_rich_1_0");
            if (b_say && isalive(e_richtofen)) {
                e_richtofen playsoundtoplayer("vox_stuh_m_quest_lock_solo_rich_2_0", e_richtofen);
                wait soundgetplaybacktime("vox_stuh_m_quest_lock_solo_rich_2_0") * 0.001;
                if (isalive(e_richtofen)) {
                    b_say = e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_lock_solo_rich_3_0");
                }
            }
        }
    }
    zm_vo::function_da6b9f3b(5);
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x4
// Checksum 0x1564f314, Offset: 0xf150
// Size: 0x400
function private function_bed92832(a_ents) {
    e_brutus = a_ents[#"brutus"];
    e_brutus waittill(#"hash_3d462b3e9905546c");
    wait soundgetplaybacktime("vox_ward_m_quest_warden_sequence_0_0") * 0.001;
    e_brutus playsound("vox_ward_m_quest_warden_sequence_1_0");
    wait soundgetplaybacktime("vox_ward_m_quest_warden_sequence_1_0") * 0.001;
    e_random_player = array::random(level.activeplayers);
    e_random_player zm_vo::vo_say("vox_plr_" + e_random_player.characterindex + "_m_quest_warden_sequence_2_0");
    wait 3;
    e_brutus playsound("vox_ward_m_quest_warden_sequence_3_0");
    wait soundgetplaybacktime("vox_ward_m_quest_warden_sequence_3_0") * 0.001;
    e_brutus playsound("vox_ward_m_quest_warden_sequence_4_0");
    wait soundgetplaybacktime("vox_ward_m_quest_warden_sequence_4_0") * 0.001;
    exploder::stop_exploder("bx_cellblock_off");
    e_brutus hide();
    if (level.activeplayers.size == 1) {
        if (level.activeplayers[0] zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"))) {
            wait 5;
        } else {
            level.activeplayers[0] zm_vo::vo_say("vox_plr_" + level.activeplayers[0].characterindex + "_m_quest_warden_sequence_5_0", 3);
        }
    } else {
        for (e_random_player = array::random(level.activeplayers); e_random_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311")); e_random_player = array::random(level.activeplayers)) {
        }
        e_random_player zm_vo::vo_say("vox_plr_" + level.activeplayers[0].characterindex + "_m_quest_warden_sequence_5_0", 3);
    }
    e_richtofen = function_6a0e1ac2();
    if (isalive(e_richtofen) && isdefined(e_richtofen.var_c6724157) && e_richtofen.var_c6724157) {
        e_richtofen playsoundtoplayer("vox_stuh_m_quest_warden_sequence_6_0", e_richtofen);
        wait soundgetplaybacktime("vox_stuh_m_quest_warden_sequence_6_0") * 0.001;
    }
    level notify(#"hash_29b3019a498b7165");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xea99fbb8, Offset: 0xf558
// Size: 0x18e
function private function_9793368a() {
    level endon(#"hash_6048c3f423fd987");
    e_random_player = array::random(level.activeplayers);
    if (e_random_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"))) {
        e_random_player zm_vo::vo_say("vox_plr_" + e_random_player.characterindex + "_m_quest_warden_sequence_8_0");
    } else {
        e_random_player zm_vo::vo_say("vox_plr_" + e_random_player.characterindex + "_m_quest_warden_sequence_7_0");
    }
    e_richtofen = function_6a0e1ac2();
    if (isalive(e_richtofen) && isdefined(e_richtofen.var_c6724157) && e_richtofen.var_c6724157) {
        e_richtofen playsoundtoplayer("vox_stuh_m_quest_warden_sequence_9_0", e_richtofen);
        wait soundgetplaybacktime("vox_stuh_m_quest_warden_sequence_9_0") * 0.001;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xd010767b, Offset: 0xf6f0
// Size: 0x94
function private function_5dd15798() {
    level endon(#"hash_6048c3f423fd987");
    e_random_player = array::random(level.activeplayers);
    zm_vo::function_2426269b(e_random_player.origin, 512);
    e_random_player zm_vo::vo_say("vox_plr_" + e_random_player.characterindex + "_m_quest_ward_stun_0");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xe1f81287, Offset: 0xf790
// Size: 0x114
function private function_1f6aa03() {
    e_richtofen = function_6a0e1ac2();
    if (isalive(e_richtofen)) {
        e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_ward_taken_0_0");
        if (isalive(e_richtofen) && isdefined(e_richtofen.var_c6724157) && e_richtofen.var_c6724157) {
            e_richtofen playsoundtoplayer("vox_stuh_m_quest_ward_taken_1_0", e_richtofen);
        }
        return;
    }
    e_player = array::random(level.activeplayers);
    e_player zm_vo::vo_say("vox_plr_" + e_player.characterindex + "_m_quest_ward_taken_0_0");
}

/#

    // Namespace paschal/zm_escape_paschal
    // Params 0, eflags: 0x0
    // Checksum 0x385a4fdc, Offset: 0xf8b0
    // Size: 0x44
    function function_73fca177() {
        zm_devgui::add_custom_devgui_callback(&function_520d5604);
        adddebugcommand("<dev string:x5ce>");
    }

    // Namespace paschal/zm_escape_paschal
    // Params 1, eflags: 0x0
    // Checksum 0x4aa1f95f, Offset: 0xf900
    // Size: 0x5a
    function function_520d5604(cmd) {
        switch (cmd) {
        case #"hash_7d175a3cfdd62ec1":
            level notify(#"hash_4ff99434ccb06268");
            level.var_a212ab11 = 1;
            break;
        }
    }

#/

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xf0c15d51, Offset: 0xf968
// Size: 0x30c
function step_5(var_4df52d26) {
    zm_vo::function_646c38ba(6);
    level zm_ui_inventory::function_31a39683(#"zm_escape_paschal", 5);
    mdl_door = getent("jar_1", "targetname");
    if (!var_4df52d26) {
        s_interact = spawnstruct();
        s_interact.origin = mdl_door gettagorigin("tag_socket_b");
        mdl_door.s_interact = s_interact;
        e_who = s_interact zm_unitrigger::function_b7e350e6(undefined, 39);
        level thread function_125daff9(e_who);
    }
    level thread function_881a1269("tag_socket_b");
    wait 1.6;
    s_map = struct::get(#"hash_137eedd5080e585d");
    s_map scene::play("Shot 2");
    mdl_door scene::play(#"p8_fxanim_zm_esc_lab_door_map_bundle", mdl_door);
    var_a62801e4 = getent("jar_2", "targetname");
    var_f728f687 = getent("jar_2_fxanim", "targetname");
    var_f728f687 thread scene::play(#"p8_fxanim_zm_esc_door_lab_double_bundle", "OPENED", var_f728f687);
    wait 1.6;
    var_a62801e4 delete();
    if (!var_4df52d26) {
        level flag::set(#"activate_west_side_exterior_stairs");
        function_843c33e6(level.activeplayers.size);
        level.var_22e20324 = 1;
        mdl_door = getent("c29_door", "targetname");
        playsoundatposition("zmb_c29_door_open", mdl_door.origin);
        mdl_door movez(96, 1.6);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x2ed3d9e3, Offset: 0xfc80
// Size: 0x6c
function function_8c8b8b5a(a_ents) {
    mdl_door = getent("jar_1", "targetname");
    a_ents[#"prop 1"] linkto(mdl_door, "tag_door_anim", (0, 0, 0));
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xcba3eed7, Offset: 0xfcf8
// Size: 0x13c
function function_843c33e6(var_dd8f7ae1) {
    level flag::clear(#"hash_4fac802bd5dcebf4");
    level.var_29ef4092 = [];
    level.var_60685f1c = 0;
    for (i = 1; i <= 4; i++) {
        mdl_plate = getent("c29_plate_" + i, "targetname");
        mdl_plate setmodel(#"p7_light_round_spot_flat_off");
        if (i > var_dd8f7ae1) {
            mdl_plate setmodel(#"p7_light_round_spot_flat_on_warm");
            continue;
        }
        level thread function_2d153271(i);
        level.var_60685f1c++;
    }
    level flag::wait_till(#"hash_4fac802bd5dcebf4");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x5e530baa, Offset: 0xfe40
// Size: 0x118
function function_6e1174e9() {
    for (i = 1; i <= 4; i++) {
        mdl_plate = getent("c29_plate_" + i, "targetname");
        if (isdefined(mdl_plate.var_699d3546)) {
            mdl_plate.var_699d3546 delete();
        }
    }
    foreach (player in level.activeplayers) {
        if (isdefined(player.var_e5a4a905)) {
            player.var_e5a4a905 delete();
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xcba4d65, Offset: 0xff60
// Size: 0x4c8
function function_2d153271(var_452c41f8) {
    level endon(#"hash_4fac802bd5dcebf4");
    mdl_plate = getent("c29_plate_" + var_452c41f8, "targetname");
    mdl_plate.var_699d3546 = spawn("trigger_radius", mdl_plate.origin, 0, 16);
    mdl_plate.var_699d3546.b_locked = 0;
    while (true) {
        s_info = mdl_plate.var_699d3546 waittill(#"trigger");
        if ((!array::contains(level.var_29ef4092, s_info.activator) || level.var_60685f1c > level.activeplayers.size) && !mdl_plate.var_699d3546.b_locked) {
            mdl_plate.var_699d3546.b_locked = 1;
            mdl_plate setmodel(#"p7_light_round_spot_flat_on_warm");
            s_info.activator.var_7d981b81 = var_452c41f8;
            if (!isdefined(level.var_29ef4092)) {
                level.var_29ef4092 = [];
            } else if (!isarray(level.var_29ef4092)) {
                level.var_29ef4092 = array(level.var_29ef4092);
            }
            level.var_29ef4092[level.var_29ef4092.size] = s_info.activator;
            s_info.activator.mdl_plate = mdl_plate;
            s_info.activator thread function_a0ddd9d6(mdl_plate);
            if (level.var_29ef4092.size == level.var_60685f1c) {
                level.var_4c2907e3 = [];
                foreach (player in level.activeplayers) {
                    if (isdefined(player.mdl_plate)) {
                        player thread function_25d37c89(player.mdl_plate.origin);
                    }
                }
                a_str_flags = array(#"hash_12a631be319641a1", #"hash_7680c620ba7315e5");
                var_372d787d = level flag::wait_till_any(a_str_flags);
                foreach (player in level.activeplayers) {
                    if (isdefined(player.var_e5a4a905)) {
                        player.var_e5a4a905 delete();
                    }
                }
                if (var_372d787d._notify == #"hash_12a631be319641a1") {
                    level flag::set(#"hash_4fac802bd5dcebf4");
                }
            } else {
                a_str_flags = array(#"hash_12a631be319641a1", #"hash_7680c620ba7315e5");
                level flag::wait_till_any(a_str_flags);
            }
            level flag::clear(#"hash_12a631be319641a1");
            level flag::clear(#"hash_7680c620ba7315e5");
        }
        wait 0.15;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xb14a98be, Offset: 0x10430
// Size: 0x176
function function_a0ddd9d6(mdl_plate) {
    self endon(#"death", #"hash_7680c620ba7315e5");
    mdl_plate.var_699d3546 endon(#"death");
    if (!self flag::exists(#"hash_7680c620ba7315e5")) {
        self flag::init(#"hash_7680c620ba7315e5");
    }
    while (true) {
        if (!self istouching(mdl_plate.var_699d3546)) {
            arrayremovevalue(level.var_29ef4092, self);
            mdl_plate.var_699d3546.b_locked = 0;
            mdl_plate setmodel(#"p7_light_round_spot_flat_off");
            level flag::set(#"hash_7680c620ba7315e5");
            self flag::set(#"hash_7680c620ba7315e5");
        } else {
            self playrumbleonentity("damage_light");
        }
        waitframe(1);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xa987012b, Offset: 0x105b0
// Size: 0x214
function function_25d37c89(var_f8c1449d) {
    self endon(#"death");
    level endon(#"hash_12a631be319641a1", #"hash_7680c620ba7315e5");
    self.var_e5a4a905 = spawn("trigger_radius_use", var_f8c1449d + (0, 0, 64), 0, 64, 64);
    self.var_e5a4a905 sethintstring(#"hash_6d663dca450595ef");
    self.var_e5a4a905 setcursorhint("HINT_NOICON");
    self.var_e5a4a905 triggerignoreteam();
    self.var_e5a4a905 setvisibletoplayer(self);
    while (true) {
        s_info = self.var_e5a4a905 waittill(#"trigger");
        if (!array::contains(level.var_4c2907e3, s_info.activator)) {
            if (!isdefined(level.var_4c2907e3)) {
                level.var_4c2907e3 = [];
            } else if (!isarray(level.var_4c2907e3)) {
                level.var_4c2907e3 = array(level.var_4c2907e3);
            }
            level.var_4c2907e3[level.var_4c2907e3.size] = s_info.activator;
            if (level.var_4c2907e3.size == level.activeplayers.size) {
                level notify(#"hash_12a631be319641a1");
            }
        }
        wait 0.15;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x65015e2b, Offset: 0x107d0
// Size: 0x134
function function_125daff9(var_7aad01c3) {
    var_7aad01c3 zm_vo::vo_say("vox_plr_" + var_7aad01c3.characterindex + "_m_quest_reveall_pods_0_0");
    e_richtofen = function_6a0e1ac2();
    if (!var_7aad01c3 zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"))) {
        if (isdefined(e_richtofen)) {
            e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_reveal_pods_1_0");
        }
    }
    if (isdefined(e_richtofen) && isdefined(e_richtofen.var_94b48394) && e_richtofen.var_94b48394) {
        e_richtofen zm_vo::vo_say("vox_stuh_m_quest_reveal_pods_2_0");
        e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_reveal_pods_3_0");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0xca88fe92, Offset: 0x10910
// Size: 0x11c
function step_5_cleanup(var_4df52d26, var_c86ff890) {
    level flag::set(#"activate_west_side_exterior_stairs");
    level flag::set(#"hash_4fac802bd5dcebf4");
    level flag::clear("zombie_drop_powerups");
    zm_zonemgr::enable_zone("zone_west_side_exterior_upper_03");
    level thread pause_zombies(1, 0);
    mdl_door = getent("jar_1", "targetname");
    if (isdefined(mdl_door.s_interact)) {
        zm_unitrigger::unregister_unitrigger(mdl_door.s_interact.s_unitrigger);
    }
    function_6e1174e9();
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x2cec2aac, Offset: 0x10a38
// Size: 0x218
function step_6(var_4df52d26) {
    showmiscmodels("mechanical_chair");
    mdl_chair = getent("mechanical_chair", "targetname");
    mdl_chair show();
    exploder::kill_exploder("fxexp_poison_ambient");
    exploder::exploder("lgtexp_bossArena_on");
    zm_bgb_anywhere_but_here::function_f9947cd5(0);
    boss_fight_setup();
    level zm_ui_inventory::function_31a39683(#"zm_escape_paschal", 6);
    level thread function_a9379378();
    if (!var_4df52d26) {
        var_9e0494e1 = function_24c3d09c();
        scene::add_scene_func(#"aib_vign_zm_mob_brutus_boss_ghost_intro", &function_4f64990d, "done");
        level scene::play(#"aib_vign_zm_mob_brutus_boss_ghost_intro", var_9e0494e1);
    }
    level.var_75eda423 = &function_fc37117d;
    changeadvertisedstatus(0);
    if (!var_4df52d26) {
        function_be8ed1b(2, 4);
        while (!isdefined(level.var_902dadca)) {
            function_13e7786d();
            if (!isdefined(level.var_902dadca)) {
                function_be8ed1b(2, 8, 3);
            }
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x49ba8e10, Offset: 0x10c58
// Size: 0x5a
function function_fc37117d(player) {
    a_s_player_spawns = struct::get_array(#"hash_26ba975865fbda23");
    s_player_spawn = array::random(a_s_player_spawns);
    return s_player_spawn;
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x63a752ea, Offset: 0x10cc0
// Size: 0xbc
function function_4f64990d(a_ents) {
    playsoundatposition(#"vox_ward_m_quest_arena_intro_0_0", (9860, 10237, 617));
    wait soundgetplaybacktime("vox_ward_m_quest_arena_intro_0_0") * 0.001;
    e_player = array::random(level.activeplayers);
    e_player zm_vo::vo_say("vox_plr_" + e_player.characterindex + "_m_quest_arena_intro_1_0");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x2c2e26d6, Offset: 0x10d88
// Size: 0x266
function function_a9379378() {
    if (isdefined(level.var_22e20324) && level.var_22e20324) {
        foreach (player in level.activeplayers) {
            player thread function_144a3d24();
        }
        level waittill(#"hash_3bb155b55ea4338a");
        mdl_door = getent("c29_door", "targetname");
        playsoundatposition("zmb_c29_door_close", mdl_door.origin);
        mdl_door movez(-96, 1.6);
        return;
    }
    s_portal = struct::get(#"hash_4f3ae1de39c4b3e3");
    for (i = 1; i <= level.activeplayers.size; i++) {
        v_facing = s_portal.origin - level.activeplayers[i - 1].origin;
        v_angle = vectortoangles(v_facing);
        s_teleport = struct::get(#"c29_teleport_" + i);
        level.activeplayers[i - 1] setorigin(s_teleport.origin);
        level.activeplayers[i - 1] setplayerangles(v_angle);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xaed58c45, Offset: 0x10ff8
// Size: 0x174
function function_144a3d24() {
    self endon(#"death");
    s_portal = struct::get(#"hash_4f3ae1de39c4b3e3");
    v_facing = s_portal.origin - self.origin;
    v_angle = vectortoangles(v_facing);
    mdl_origin = util::spawn_model("tag_origin", self.origin, v_angle);
    self linkto(mdl_origin);
    wait 0.9;
    if (isdefined(self.var_7d981b81)) {
        s_goto = struct::get(#"c29_teleport_" + self.var_7d981b81);
        mdl_origin moveto(s_goto.origin, 1.6);
    }
    wait 1.6;
    level notify(#"hash_3bb155b55ea4338a");
    self unlink();
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x27536873, Offset: 0x11178
// Size: 0x28c
function boss_fight_setup() {
    level.var_51fc8aa2 = 0;
    if (level.round_number < 26) {
        level.var_74b7ddca = level.zombie_vars[#"zombie_health_start"];
        for (i = 2; i <= 26; i++) {
            if (i >= 10) {
                n_old_health = level.var_74b7ddca;
                level.var_74b7ddca += int(level.var_74b7ddca * level.zombie_vars[#"zombie_health_increase_multiplier"]);
                if (level.var_74b7ddca < n_old_health) {
                    level.var_74b7ddca = n_old_health;
                    break;
                }
                continue;
            }
            level.var_74b7ddca = int(level.var_74b7ddca + level.zombie_vars[#"zombie_health_increase"]);
        }
    } else {
        level.var_74b7ddca = level.zombie_health;
    }
    if (level.brutus_round_count < 7) {
        level.brutus_round_count = 7;
    }
    zm::register_actor_damage_callback(&function_4afcb780, 1);
    level.var_8f5050e8 = 0;
    s_portal = struct::get(#"hash_4f3ae1de39c4b3e3");
    mdl_portal = util::spawn_model("tag_origin", s_portal.origin, s_portal.angles);
    mdl_portal.targetname = "c29_energy";
    mdl_portal clientfield::set("" + #"dm_energy", 3);
    mdl_portal.script_noteworthy = "blast_attack_interactables";
    mdl_portal thread function_e7a9806();
}

// Namespace paschal/zm_escape_paschal
// Params 12, eflags: 0x0
// Checksum 0x246b6a1c, Offset: 0x11410
// Size: 0x12c
function function_4afcb780(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    n_damage = -1;
    if (isdefined(attacker) && !isplayer(attacker)) {
        var_d943a558 = getweapon(#"hash_494f5501b3f8e1e9");
        if (isdefined(weapon) && weapon == var_d943a558) {
            n_damage = 0;
        }
    } else if (isdefined(self.var_ea94c12a) && self.var_ea94c12a == #"brutus_special" && !level.var_51fc8aa2) {
        n_damage = 0;
    }
    return n_damage;
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xbfbb50e0, Offset: 0x11548
// Size: 0xac
function function_e7a9806() {
    self endon(#"death");
    while (true) {
        s_info = self waittill(#"blast_attack");
        if (isdefined(level.var_9198751b) && level.var_9198751b) {
            if (isdefined(s_info.e_player)) {
                level.var_530935d = s_info.e_player;
            }
            level.var_abfee5a0 = 1;
            level notify(#"hash_6721db7073dcfe48");
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 5, eflags: 0x0
// Checksum 0x4fee7628, Offset: 0x11600
// Size: 0x5a0
function function_be8ed1b(var_530b6d6d, n_brutus = 0, var_edaed8be = 0, var_cf05a9fd = 0, n_zombies_max) {
    switch (level.activeplayers.size) {
    case 1:
        var_8812bedf = 36;
        break;
    case 2:
        var_8812bedf = 37;
        break;
    case 3:
        var_8812bedf = 38;
        break;
    default:
        var_8812bedf = 39;
        break;
    }
    level.var_f80885aa = 1;
    level.n_brutus_spawned = 0;
    if (var_edaed8be > 0) {
        level thread function_f1068e26(var_edaed8be);
    }
    if (var_cf05a9fd) {
        level thread function_f07c3daf();
    }
    if (n_brutus != 0) {
        level thread function_cf76a5ab(n_brutus, var_cf05a9fd);
    }
    var_7342a21c = function_23f3ef04(var_530b6d6d);
    var_3e91f7e8 = 0;
    var_e0558b95 = 0;
    var_b24e4ae1 = struct::get_array(#"hash_12b8ce4101a20d47");
    var_b24e4ae1 = array::randomize(var_b24e4ae1);
    if (isdefined(n_zombies_max)) {
        for (i = 0; i < var_b24e4ae1.size; i++) {
            if (var_b24e4ae1[i].script_noteworthy == "riser_location") {
                var_b24e4ae1[i] = undefined;
            }
        }
        var_b24e4ae1 = array::remove_undefined(var_b24e4ae1);
    }
    while (level.var_f80885aa) {
        var_d7a579ca = getaiteamarray(level.zombie_team).size;
        if (level.activeplayers.size == 1 && level flag::get(#"richtofen_sacrifice") && !level flag::get(#"hash_68a1656980e771da")) {
            if (var_d7a579ca >= 23) {
                wait var_7342a21c;
                continue;
            }
        }
        if (isdefined(n_zombies_max) && var_d7a579ca >= n_zombies_max) {
            wait var_7342a21c;
            continue;
        }
        if (var_e0558b95 == var_b24e4ae1.size) {
            var_e0558b95 = 0;
            var_b24e4ae1 = array::randomize(var_b24e4ae1);
        }
        s_spawn_loc = var_b24e4ae1[var_e0558b95];
        if (s_spawn_loc.script_noteworthy == "riser_location") {
            ai_zombie = zombie_utility::spawn_zombie(level.zombie_spawners[0], undefined, s_spawn_loc);
            ai_zombie thread function_f91917ad();
        } else if (s_spawn_loc.script_noteworthy == "dog_location") {
            ai_zombie = zombie_utility::spawn_zombie(level.dog_spawners[0]);
            ai_zombie thread function_d6a05673(s_spawn_loc);
        }
        if (isdefined(ai_zombie)) {
            var_e0558b95++;
            var_3e91f7e8++;
        }
        if (n_brutus == 0) {
            if (var_3e91f7e8 > var_8812bedf) {
                level.var_f80885aa = 0;
            }
        }
        wait var_7342a21c;
    }
    if (!isdefined(n_zombies_max)) {
        for (var_d7a579ca = getaiteamarray(level.zombie_team).size; var_d7a579ca > 0; var_d7a579ca = getaiteamarray(level.zombie_team).size) {
            wait 1.6;
        }
        var_6010e96 = struct::get_array(#"hash_3ea8e97c5c09e1a5", "variantname");
        s_location = array::random(var_6010e96);
        level.var_736fe9c9 = s_location.script_int;
        e_powerup = zm_powerups::specific_powerup_drop("full_ammo", s_location.origin);
        e_powerup waittilltimeout(16, #"powerup_grabbed");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x3a6300ce, Offset: 0x11ba8
// Size: 0xd4
function function_f91917ad() {
    self endon(#"death");
    waitframe(1);
    self thread zm_escape_util::function_1332d61();
    self.maxhealth = int(level.var_74b7ddca);
    self.health = self.maxhealth;
    n_roll = randomint(10);
    if (n_roll <= 6) {
        self zombie_utility::set_zombie_run_cycle("sprint");
        return;
    }
    self zombie_utility::set_zombie_run_cycle("run");
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x8c185057, Offset: 0x11c88
// Size: 0x5c
function function_d6a05673(s_spawn_loc) {
    self endon(#"death");
    waitframe(1);
    self thread zm_escape_util::function_389bc4e7(s_spawn_loc);
    self ai::set_behavior_attribute("sprint", 1);
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0x13d67f42, Offset: 0x11cf0
// Size: 0x188
function function_cf76a5ab(n_brutus, var_cf05a9fd = 0) {
    if (var_cf05a9fd) {
        level flag::wait_till(#"hash_68a1656980e771da");
    }
    wait 1.6;
    a_str_notifies = array("brutus_spawned", "brutus_spawn_failed");
    while (level.var_f80885aa) {
        zombie_brutus_util::attempt_brutus_spawn(1, "zone_west_side_exterior_upper_03", 1);
        s_waittill = level waittill(a_str_notifies);
        if (isdefined(s_waittill.ai_brutus)) {
            level.n_brutus_spawned++;
            s_waittill.ai_brutus ai::set_behavior_attribute("can_ground_slam", 1);
            s_waittill.ai_brutus.var_76b55fb2 = 1;
            s_waittill.ai_brutus waittilltimeout(12.6, #"death");
            if (n_brutus != -1 && level.n_brutus_spawned >= n_brutus) {
                level.var_f80885aa = 0;
            }
            continue;
        }
        wait 16;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x53fbb684, Offset: 0x11e80
// Size: 0xe8
function function_f1068e26(var_edaed8be) {
    wait 2.6;
    while (level.var_f80885aa) {
        var_7c36cced = struct::get_array(#"hash_238da2de7cf910d9", "variantname");
        var_7c36cced = array::randomize(var_7c36cced);
        for (i = 0; i < var_edaed8be; i++) {
            s_cloud = var_7c36cced[i];
            function_fc3f52d(s_cloud);
            wait randomfloatrange(1.6, 6.1);
        }
        wait 16;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xb88955a, Offset: 0x11f70
// Size: 0x180
function function_fc3f52d(s_cloud) {
    mdl_cloud = util::spawn_model("tag_origin", s_cloud.origin, s_cloud.angles + (270, 0, 0));
    mdl_cloud clientfield::set("" + #"ritual_gobo", 1);
    mdl_cloud thread function_e9291ca8();
    wait 7.6;
    foreach (player in level.activeplayers) {
        if (distance2dsquared(mdl_cloud.origin, player.origin) < 5041) {
            player dodamage(player.health + 16, player.origin);
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xee3db887, Offset: 0x120f8
// Size: 0x34
function function_e9291ca8() {
    wait 6.1;
    self clientfield::set("" + #"ritual_gobo", 0);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x3fb6cedf, Offset: 0x12138
// Size: 0xc0
function function_24c3d09c() {
    var_aa169fdc = getent("spawner_zm_brutus_special", "targetname");
    var_9e0494e1 = zombie_utility::spawn_zombie(var_aa169fdc);
    var_9e0494e1 clientfield::set("brutus_spawn_clientfield", 1);
    var_9e0494e1 disableaimassist();
    var_9e0494e1 clientfield::set("" + #"hash_df589cc30f4c7dd", 1);
    return var_9e0494e1;
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x18033684, Offset: 0x12200
// Size: 0x204
function function_f07c3daf() {
    var_aa169fdc = getent("spawner_zm_brutus_special", "targetname");
    var_9e0494e1 = zombie_utility::spawn_zombie(var_aa169fdc);
    while (!isdefined(var_9e0494e1)) {
        var_9e0494e1 = zombie_utility::spawn_zombie(var_aa169fdc);
        waitframe(1);
    }
    var_9e0494e1 thread zombie_brutus_util::brutus_spawn(undefined, undefined, undefined, undefined, "zone_west_side_exterior_upper_03");
    var_9e0494e1 ai::set_behavior_attribute("can_ground_slam", 1);
    var_9e0494e1.var_76b55fb2 = 1;
    var_9e0494e1.script_noteworthy = "spawner_zm_brutus_special_ai";
    var_9e0494e1 clientfield::set("" + #"hash_df589cc30f4c7dd", 1);
    level notify(#"hash_7fbbfdf42f9d741");
    var_9e0494e1 thread function_5b7e3d0c();
    level flag::wait_till(#"hash_68a1656980e771da");
    var_9e0494e1 clientfield::set("" + #"hash_df589cc30f4c7dd", 0);
    var_9e0494e1 ai::stun(2.9);
    level.var_51fc8aa2 = 1;
    var_9e0494e1 waittill(#"death");
    level.var_f80885aa = 0;
    level flag::set(#"main_quest_completed");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x4830e075, Offset: 0x12410
// Size: 0xd2
function function_5b7e3d0c() {
    self endon(#"death");
    level endon(#"hash_68a1656980e771da");
    while (true) {
        wait 16;
        if (!zm_vo::function_68ee653()) {
            var_51a18059 = randomint(10);
            self playsoundtoteam("vox_ward_m_quest_ward_taunt_" + var_51a18059, level.activeplayers[0].team);
            wait soundgetplaybacktime("vox_ward_m_quest_ward_taunt_" + var_51a18059) * 0.001;
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x1b1f27ce, Offset: 0x124f0
// Size: 0x7c4
function function_c5f79dd5() {
    level thread function_e98d3970();
    e_richtofen = function_6a0e1ac2(1);
    if (!isdefined(e_richtofen)) {
        e_richtofen = bot::add_bot(level.activeplayers[0].team);
        waitframe(1);
        var_73b5f866 = zm_characters::get_character_index(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"));
        e_richtofen.var_f1a6dad4 = var_73b5f866;
        e_richtofen.characterindex = var_73b5f866;
        wait 0.45;
        e_richtofen zm_player::spectator_respawn_player();
        e_richtofen endon(#"death");
        e_richtofen thread function_4e4e6fca();
        e_richtofen enableinvulnerability();
        e_richtofen val::set(#"hash_7982a3b40442a935", "ignoreme", 1);
    } else if (e_richtofen util::is_spectating()) {
        e_richtofen zm_player::spectator_respawn_player();
    }
    level flag::set(#"hash_6716f701ec61662f");
    mdl_chair = getent("mechanical_chair", "targetname");
    for (i = 1; i <= 3; i++) {
        mdl_chair setmodel(#"hash_4fb2e1f3ca435307" + i);
        wait 3.9;
    }
    if (!isbot(e_richtofen)) {
        s_interact = struct::get(#"dm_activate");
        s_interact zm_unitrigger::create(#"hash_676b19ae139cb760", undefined, &function_f000b35f);
        s_interact waittill(#"trigger_activated");
        zm_unitrigger::unregister_unitrigger(s_interact.s_unitrigger);
        s_interact.s_unitrigger = undefined;
        e_richtofen enableinvulnerability();
        e_richtofen val::set(#"hash_7982a3b40442a935", "ignoreme", 1);
    } else {
        s_location = struct::get(#"dm_location");
        e_richtofen bot_util::function_3896525e(s_location.origin, 1, 16);
        e_richtofen waittill(#"goal");
    }
    level flag::set(#"hash_1b4b6ce05cb62d56");
    if (level.activeplayers.size == 1) {
        level.var_4af51a33 = &function_21e73731;
    }
    e_richtofen.var_fa6d2a24 = 1;
    e_richtofen zm_weapons::clear_stowed_weapon();
    scene::add_scene_func(#"vign_zm_mob_into_machine_idle", &function_789dd188);
    level thread scene::play(#"vign_zm_mob_into_machine_idle");
    level scene::play(#"vign_zm_mob_into_machine", e_richtofen);
    level flag::set(#"richtofen_sacrifice");
    e_richtofen setcharacteroutfit(2);
    wait 0.15;
    level scene::play("ai_vign_zm_mob_pod", e_richtofen);
    e_richtofen.var_fa6d2a24 = 0;
    e_richtofen zm_weapons::set_stowed_weapon(e_richtofen.weaponriotshield);
    level flag::wait_till(#"hash_3d16465b22e70170");
    if (isbot(e_richtofen)) {
        s_door = struct::get(#"hash_5835bfd32af5f016");
        e_richtofen bot_util::function_3896525e(s_door.origin, 1, 16);
        e_richtofen waittill(#"goal");
        var_67916001 = struct::get(#"hash_47f2014efe5d289b");
        e_richtofen setorigin(var_67916001.origin);
        e_richtofen setplayerangles(var_67916001.angles);
        level notify(#"hash_1f6e4e9964d89d5e");
    } else {
        function_843c33e6(1);
        var_67916001 = struct::get(#"hash_47f2014efe5d289b");
        e_richtofen setorigin(var_67916001.origin);
        e_richtofen setplayerangles(var_67916001.angles);
        function_6e1174e9();
    }
    level thread lui::screen_flash(0.2, 0.5, 1, 0.16, "white");
    level flag::set(#"hash_68a1656980e771da");
    if (isbot(e_richtofen)) {
        level waittill(#"hash_13084094b40f3c48");
        bot::remove_bot(e_richtofen);
    } else {
        e_richtofen disableinvulnerability();
        e_richtofen val::set(#"hash_7982a3b40442a935", "ignoreme", 0);
    }
    changeadvertisedstatus(1);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xa37860ef, Offset: 0x12cc0
// Size: 0xd8
function function_f000b35f() {
    self endon(#"death");
    e_richtofen = function_6a0e1ac2();
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (!zm_utility::can_use(e_player) || e_player != e_richtofen) {
            continue;
        }
        self.stub.related_parent notify(#"trigger_activated", {#e_who:e_player});
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x4734dc70, Offset: 0x12da0
// Size: 0x7c
function function_789dd188(a_ents) {
    a_ents[#"fake_richtofen"] hide();
    level flag::wait_till(#"richtofen_sacrifice");
    a_ents[#"fake_richtofen"] show();
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xf92cb6fd, Offset: 0x12e28
// Size: 0x24
function function_21e73731(str_zone_name) {
    if (str_zone_name == "zone_west_side_exterior_upper_03") {
        return true;
    }
    return false;
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xfb1d0aad, Offset: 0x12e58
// Size: 0x3b4
function function_e98d3970() {
    level flag::wait_till(#"hash_3cc421108aedf47f");
    level flag::wait_till(#"hash_6716f701ec61662f");
    e_richtofen = function_6a0e1ac2();
    var_e478f9b1 = function_81acde7e();
    if (isdefined(var_e478f9b1)) {
        var_e478f9b1 zm_vo::vo_say("vox_plr_" + var_e478f9b1.characterindex + "_m_quest_port_capture_0_0");
    }
    e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_port_capture_1_0");
    if (isdefined(e_richtofen.var_94b48394) && e_richtofen.var_94b48394) {
        e_richtofen zm_vo::vo_say("vox_stuh_m_quest_port_capture_2_0");
        e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_port_capture_3_0");
    }
    level flag::wait_till(#"hash_1b4b6ce05cb62d56");
    wait 1.6;
    e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_rich_enter_0_0");
    var_e478f9b1 = function_81acde7e();
    if (isdefined(var_e478f9b1)) {
        var_e478f9b1 zm_vo::vo_say("vox_plr_" + var_e478f9b1.characterindex + "_m_quest_rich_enter_1_0");
    }
    e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_rich_enter_2_0");
    level flag::wait_till(#"richtofen_sacrifice");
    wait 0.1;
    e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_medi_awake_0_0");
    e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_medi_awake_1_0");
    zm_vo::function_da6b9f3b(7);
    level flag::set(#"hash_3d16465b22e70170");
    level flag::wait_till(#"hash_68a1656980e771da");
    ai_boss = getent("spawner_zm_brutus_special_ai", "script_noteworthy");
    ai_boss playsoundtoteam("vox_ward_m_quest_ward_vulner_0_0", level.activeplayers[0].team);
    wait soundgetplaybacktime("vox_ward_m_quest_ward_vulner_0_0") * 0.001;
    e_richtofen zm_vo::vo_say("vox_plr_5_m_quest_ward_vulner_1_0");
    level notify(#"hash_13084094b40f3c48");
    var_e478f9b1 = function_81acde7e();
    if (isdefined(var_e478f9b1)) {
        var_e478f9b1 zm_vo::vo_say("vox_plr_" + var_e478f9b1.characterindex + "_m_quest_ward_vulner_2_0");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xa234af03, Offset: 0x13218
// Size: 0xd0
function function_81acde7e() {
    a_random_players = array::randomize(level.activeplayers);
    foreach (e_player in a_random_players) {
        if (!e_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"))) {
            return e_player;
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x56cfaaac, Offset: 0x132f0
// Size: 0x30
function function_4e4e6fca() {
    self waittill(#"death");
    level notify(#"hash_1f6e4e9964d89d5e");
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x554df8f9, Offset: 0x13328
// Size: 0x9a
function function_23f3ef04(n_multiplier = 1) {
    n_wait = 0.9;
    n_wait *= n_multiplier;
    n_wait -= (level.activeplayers.size - 1) * 0.2;
    if (n_wait < 0.2) {
        n_wait = 0.2;
    }
    return n_wait;
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x72d219d3, Offset: 0x133d0
// Size: 0x494
function function_13e7786d() {
    var_c6595461 = array("energy_location_up", "energy_location_right", "energy_location_left", "energy_location_bottom");
    if (!isdefined(level.var_736fe9c9)) {
        level.var_736fe9c9 = randomintrange(1, 5);
    }
    if (level.var_736fe9c9 <= 2) {
        var_2c339b11 = level.var_736fe9c9 + 2;
    } else {
        var_2c339b11 = level.var_736fe9c9 - 2;
    }
    var_33c962c5 = struct::get("sbrutus_attack_" + var_2c339b11);
    var_d5c578e4 = int(232);
    /#
        circle(var_33c962c5.origin + (0, 0, -61), 256, (1, 1, 1), 0, 1, var_d5c578e4);
    #/
    level.var_9198751b = 0;
    level.var_abfee5a0 = 0;
    level.var_a6c4b23d = 0;
    exploder::exploder("fxexp_poison_0" + var_2c339b11);
    foreach (e_player in level.players) {
        e_player thread function_d829fa8d(var_33c962c5.origin);
    }
    var_9e0494e1 = function_24c3d09c();
    scene::add_scene_func(#"hash_5d4bfbee934372eb", &function_1a71d242, "init");
    var_33c962c5 thread scene::play(var_9e0494e1);
    var_9e0494e1 thread function_2b4b865c(var_c6595461[var_2c339b11 - 1], var_33c962c5.origin);
    level thread function_be8ed1b(3, 0, 0, 0, level.activeplayers.size);
    level waittilltimeout(11.6, #"boss_loses");
    level.var_f80885aa = 0;
    level.var_a6c4b23d = 1;
    if (level.var_9198751b) {
        var_9e0494e1 scene::play(#"aib_vign_zm_mob_brutus_grand_attack_fail", var_9e0494e1);
        var_d5c578e4 = int(32);
        /#
            circle(var_33c962c5.origin + (0, 0, -61), 256, (1, 1, 1), 0, 1, var_d5c578e4);
        #/
        level waittilltimeout(6.1, #"hash_6721db7073dcfe48");
        level notify(#"hash_77922c6d618e505a");
        if (level.var_abfee5a0) {
            level.var_8f5050e8++;
            level thread function_39e04181();
        }
    } else {
        level.var_8f5050e8--;
        level thread function_6fe747b();
        var_9e0494e1 thread scene::play(#"hash_dc3b3b48b040137", var_9e0494e1);
        wait 1;
        level notify(#"hash_7dc902a6d75721a1");
    }
    exploder::kill_exploder("fxexp_poison_0" + var_2c339b11);
    function_1e645634();
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x918611fc, Offset: 0x13870
// Size: 0x9c
function function_1a71d242(a_ents) {
    var_8a6227a2 = [];
    var_8a6227a2[-1] = "vox_ward_m_quest_ward_ritual_4";
    var_8a6227a2[0] = "vox_ward_m_quest_ward_ritual_2";
    var_8a6227a2[1] = "vox_ward_m_quest_ward_ritual_0";
    a_ents[#"boss"] playsoundtoteam(var_8a6227a2[level.var_8f5050e8], level.activeplayers[0].team);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xcd10cf6d, Offset: 0x13918
// Size: 0x144
function function_39e04181() {
    if (level.var_8f5050e8 == 0) {
        var_dcc30708 = randomintrange(0, 3);
    } else if (level.var_8f5050e8 == 1) {
        var_dcc30708 = randomintrange(3, 5);
    }
    if (isdefined(var_dcc30708)) {
        str_vo = "vox_plr_" + level.var_530935d.characterindex + "_m_quest_prim_win_" + var_dcc30708 + 1 + "_" + var_dcc30708;
        level.var_530935d zm_vo::vo_say("vox_plr_" + level.var_530935d.characterindex + "_m_quest_prim_win_" + var_dcc30708 + 1 + "_" + var_dcc30708);
    }
    if (level.var_8f5050e8 == 2) {
        level flag::set(#"hash_3cc421108aedf47f");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xea5d76a0, Offset: 0x13a68
// Size: 0xcc
function function_6fe747b() {
    if (level.var_8f5050e8 == 0) {
        var_dcc30708 = randomintrange(0, 3);
    } else if (level.var_8f5050e8 == -1) {
        var_dcc30708 = randomintrange(3, 5);
    }
    if (isdefined(var_dcc30708)) {
        mdl_portal = getent("c29_energy", "targetname");
        mdl_portal playsoundtoteam("vox_ward_m_quest_ward_win_" + var_dcc30708, level.activeplayers[0].team);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x956f43ad, Offset: 0x13b40
// Size: 0xc0
function function_d829fa8d(var_f566b294) {
    self endon(#"death");
    level endon(#"hash_77922c6d618e505a", #"hash_7dc902a6d75721a1");
    while (true) {
        wait 1.6;
        n_dist_2d_sq = distance2dsquared(var_f566b294, self.origin);
        var_249b3407 = 65536;
        if (n_dist_2d_sq > var_249b3407) {
            self dodamage(50, self.origin);
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0xab245788, Offset: 0x13c08
// Size: 0x1fe
function function_2b4b865c(var_a622dba2, var_f566b294) {
    level endon(#"hash_77922c6d618e505a");
    level.var_ccf2076 = 0;
    a_mdl_orbs = [];
    for (i = 1; i <= 3; i++) {
        s_orb = struct::get(var_a622dba2 + "_" + i);
        mdl_orb = util::spawn_model(#"hash_6d68fe0dc773635f", s_orb.origin, s_orb.angles);
        mdl_orb setcandamage(1);
        mdl_orb.health = 1116 * level.activeplayers.size;
        mdl_orb.var_f566b294 = var_f566b294;
        mdl_orb thread function_4e019426();
        callback::function_789c6271(&function_321455b6, mdl_orb);
        self thread scene::play(#"hash_4b825982d02adb40" + i, "Shot 1", mdl_orb);
        if (!isdefined(a_mdl_orbs)) {
            a_mdl_orbs = [];
        } else if (!isarray(a_mdl_orbs)) {
            a_mdl_orbs = array(a_mdl_orbs);
        }
        a_mdl_orbs[a_mdl_orbs.size] = mdl_orb;
        mdl_orb thread function_f52c32b3(self, i);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0x28fea6b8, Offset: 0x13e10
// Size: 0xb6
function function_f52c32b3(var_9e0494e1, var_79c1dcf0) {
    self endon(#"death");
    self thread function_485452cf();
    wait 11.6;
    self clientfield::set("" + #"hash_4bea78fdf78a2613", 1);
    var_9e0494e1 scene::play(#"hash_4b825982d02adb40" + var_79c1dcf0, "Shot 2", self);
    self notify(#"delete_me");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xe13befd5, Offset: 0x13ed0
// Size: 0x4c
function function_485452cf() {
    self endon(#"death");
    self hide();
    wait 1.6;
    self show();
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0x3b8424a6, Offset: 0x13f28
// Size: 0x110
function function_321455b6(var_8f5afe72, s_info) {
    if (!isdefined(s_info)) {
        n_damage = 0;
    } else {
        n_damage = s_info.idamage;
        if (!level.var_a6c4b23d) {
            n_dist_2d_sq = distance2dsquared(self.var_f566b294, s_info.eattacker.origin);
            var_249b3407 = 65536;
            if (n_dist_2d_sq > var_249b3407) {
                n_damage = 0;
            }
            n_health_after_damage = self.health - n_damage * 2;
            if (n_health_after_damage <= 0) {
                self notify(#"delete_me");
                n_damage = 0;
            }
        }
        if (n_damage > 0) {
            s_info.eattacker util::show_hit_marker();
        }
    }
    return n_damage;
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x377f185, Offset: 0x14040
// Size: 0xa6
function function_4e019426() {
    self waittill(#"delete_me");
    self clientfield::set("" + #"hash_4bea78fdf78a2613", 0);
    wait 0.1;
    self delete();
    level.var_ccf2076++;
    if (level.var_ccf2076 == 3) {
        level notify(#"boss_loses");
        level.var_9198751b = 1;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xdf5ec6c0, Offset: 0x140f0
// Size: 0x2b4
function function_1e645634() {
    mdl_portal = getent("c29_energy", "targetname");
    waitframe(1);
    if (level.var_8f5050e8 == 2) {
        level.var_902dadca = "players_won";
        mdl_portal clientfield::set("" + #"dm_energy", 1);
        return;
    }
    if (level.var_8f5050e8 == -2) {
        mdl_portal clientfield::set("" + #"dm_energy", 5);
        level.var_902dadca = "players_lose";
        foreach (e_player in level.players) {
            e_player thread function_b3ef08e5();
        }
        mdl_portal playsoundtoteam("vox_ward_m_quest_ward_port_0", level.activeplayers[0].team);
        wait soundgetplaybacktime("vox_ward_m_quest_ward_port_0") * 0.001;
        level notify(#"end_game");
        return;
    }
    if (level.var_8f5050e8 == 1) {
        mdl_portal clientfield::set("" + #"dm_energy", 2);
        return;
    }
    if (level.var_8f5050e8 == 0) {
        mdl_portal clientfield::set("" + #"dm_energy", 3);
        return;
    }
    if (level.var_8f5050e8 == -1) {
        mdl_portal clientfield::set("" + #"dm_energy", 4);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0xea6b7b99, Offset: 0x143b0
// Size: 0x66
function function_b3ef08e5() {
    self endon(#"death");
    while (true) {
        if (isalive(self)) {
            self dodamage(self.health + 1, self.origin);
        }
        waitframe(1);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0xf2a16551, Offset: 0x14420
// Size: 0x44
function step_6_cleanup(var_4df52d26, var_c86ff890) {
    if (var_4df52d26 || var_c86ff890) {
        level flag::set(#"hash_3cc421108aedf47f");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xa3ed42b5, Offset: 0x14470
// Size: 0x128
function step_7(var_4df52d26) {
    level zm_ui_inventory::function_31a39683(#"zm_escape_paschal", 7);
    if (!var_4df52d26) {
        level thread function_c5f79dd5();
        level flag::wait_till(#"hash_6716f701ec61662f");
        level waittilltimeout(6.1, #"hash_1b4b6ce05cb62d56");
        level thread function_be8ed1b(2, -1, 3, 1);
        level thread scene::init_streamer(#"hash_641ed02ad1d85897", #"allies", 0, 0);
        level flag::wait_till(#"main_quest_completed");
        level notify(#"hash_108cb6aa18caf726");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0xb2935155, Offset: 0x145a0
// Size: 0xdc
function step_7_cleanup(var_4df52d26, var_c86ff890) {
    a_ai_brutus = getaiarchetypearray("brutus");
    foreach (ai_brutus in a_ai_brutus) {
        ai_brutus dodamage(ai_brutus.health + 666, ai_brutus.origin);
    }
    function_5db6ba34(1);
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xe8f37650, Offset: 0x14688
// Size: 0xfc
function outro(var_4df52d26) {
    level.lighting_state = 0;
    self util::set_lighting_state(level.lighting_state);
    mdl_chair = getent("mechanical_chair", "targetname");
    mdl_chair hide();
    mdl_portal = getent("c29_energy", "targetname");
    mdl_portal clientfield::set("" + #"dm_energy", 0);
    level scene::play(#"hash_641ed02ad1d85897");
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0xc8172d4d, Offset: 0x14790
// Size: 0x28
function outro_cleanup(var_4df52d26, var_c86ff890) {
    level notify(#"end_game");
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0xfc90a8b0, Offset: 0x147c0
// Size: 0xac
function pause_zombies(b_pause = 0, var_9d3d4d3f = 1) {
    if (b_pause) {
        level.disable_nuke_delay_spawning = 1;
        level flag::clear("spawn_zombies");
        function_5db6ba34(var_9d3d4d3f);
        return;
    }
    level.disable_nuke_delay_spawning = 0;
    level flag::set("spawn_zombies");
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0xa646d17a, Offset: 0x14878
// Size: 0x378
function function_5db6ba34(var_1a60ad71 = 1) {
    if (var_1a60ad71) {
        level thread lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
    }
    wait 0.5;
    a_ai_zombies = getaiteamarray(level.zombie_team);
    var_6b1085eb = [];
    foreach (ai_zombie in a_ai_zombies) {
        ai_zombie.no_powerups = 1;
        ai_zombie.deathpoints_already_given = 1;
        if (isdefined(ai_zombie.ignore_nuke) && ai_zombie.ignore_nuke) {
            continue;
        }
        if (isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death) {
            continue;
        }
        if (isdefined(ai_zombie.nuke_damage_func)) {
            ai_zombie thread [[ ai_zombie.nuke_damage_func ]]();
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(ai_zombie)) {
            continue;
        }
        ai_zombie.marked_for_death = 1;
        ai_zombie.nuked = 1;
        var_6b1085eb[var_6b1085eb.size] = ai_zombie;
    }
    foreach (i, var_f92b3d80 in var_6b1085eb) {
        wait randomfloatrange(0.1, 0.2);
        if (!isdefined(var_f92b3d80)) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(var_f92b3d80)) {
            continue;
        }
        if (i < 5 && !(isdefined(var_f92b3d80.isdog) && var_f92b3d80.isdog)) {
            var_f92b3d80 thread zombie_death::flame_death_fx();
        }
        if (!(isdefined(var_f92b3d80.isdog) && var_f92b3d80.isdog)) {
            if (!(isdefined(var_f92b3d80.no_gib) && var_f92b3d80.no_gib)) {
                var_f92b3d80 zombie_utility::zombie_head_gib();
            }
        }
        var_f92b3d80 dodamage(var_f92b3d80.health, var_f92b3d80.origin);
        if (!level flag::get("special_round")) {
            level.zombie_total++;
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 3, eflags: 0x0
// Checksum 0xde285a2e, Offset: 0x14bf8
// Size: 0x1e6
function move_seagull(var_92630b7e, str_endon_notify, n_speed = 300) {
    if (isdefined(str_endon_notify) && (isstring(str_endon_notify) || ishash(str_endon_notify))) {
        self endon(str_endon_notify);
        level endon(str_endon_notify);
    }
    self.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "loop_anim", self);
    for (var_1912b060 = struct::get(var_92630b7e); isdefined(var_1912b060); var_1912b060 = struct::get(var_1912b060.target)) {
        n_time = distance(self.origin, var_1912b060.origin) / n_speed;
        self.mdl_origin moveto(var_1912b060.origin, n_time);
        self.mdl_origin rotateto(var_1912b060.angles, n_time);
        self.mdl_origin waittill(#"movedone");
    }
    self.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "idle_flying_loop", self);
    self notify(#"hash_10107d27cb385d36");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xa0368aa, Offset: 0x14de8
// Size: 0x1dc
function private function_ec8cb0d2() {
    level.var_497f669a = [];
    level.var_607bd06e = [];
    level thread function_2c34106b();
    mdl_map = getent("jar_1", "targetname");
    mdl_map hidepart("tag_socket_a");
    mdl_map hidepart("tag_socket_b");
    mdl_map hidepart("tag_socket_c");
    mdl_map hidepart("tag_socket_d");
    mdl_map hidepart("tag_socket_e");
    mdl_map hidepart("tag_socket_f");
    mdl_map hidepart("tag_socket_g");
    mdl_map hidepart("tag_glow_a");
    mdl_map hidepart("tag_glow_c");
    mdl_map hidepart("tag_glow_d");
    mdl_map hidepart("tag_glow_e");
    mdl_map hidepart("tag_glow_g");
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0xbd0614c2, Offset: 0x14fd0
// Size: 0x5e
function private function_2c34106b() {
    var_af330228 = struct::get("s_p_s2_ins");
    var_af330228.s_unitrigger_stub = var_af330228 zm_unitrigger::create(&function_eb5684a1, 40, &function_151f99ae);
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x5fcabba7, Offset: 0x15038
// Size: 0x138
function function_151f99ae() {
    while (true) {
        s_result = self waittill(#"trigger");
        if (isplayer(s_result.activator) && level.var_497f669a.size) {
            a_str_tags = arraycopy(level.var_497f669a);
            foreach (str_tag in a_str_tags) {
                level thread function_881a1269(str_tag);
                arrayremovevalue(level.var_497f669a, str_tag);
            }
            self.stub notify(#"hash_4c6ab2a4a99f9539");
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x4c78b582, Offset: 0x15178
// Size: 0x2a
function function_eb5684a1(e_player) {
    if (level.var_497f669a.size) {
        return 1;
    }
    return 0;
}

// Namespace paschal/zm_escape_paschal
// Params 1, eflags: 0x0
// Checksum 0x529ed425, Offset: 0x151b0
// Size: 0x54a
function function_881a1269(str_tag) {
    mdl_map = getent("jar_1", "targetname");
    if (!isdefined(level.var_607bd06e)) {
        level.var_607bd06e = [];
    } else if (!isarray(level.var_607bd06e)) {
        level.var_607bd06e = array(level.var_607bd06e);
    }
    if (!isinarray(level.var_607bd06e, str_tag)) {
        level.var_607bd06e[level.var_607bd06e.size] = str_tag;
    }
    switch (str_tag) {
    case #"tag_socket_a":
        mdl_map hidepart("tag_map_part_a");
        mdl_map showpart("tag_socket_a");
        mdl_map clientfield::set("" + #"hash_2928b6d60aaacda6", 1);
        mdl_map showpart("tag_glow_a");
        break;
    case #"tag_socket_b":
        mdl_map hidepart("tag_map_part_b");
        mdl_map showpart("tag_socket_b");
        mdl_map clientfield::set("" + #"hash_2928b6d60aaacda6", 2);
        break;
    case #"tag_socket_c":
        mdl_map hidepart("tag_map_part_c");
        mdl_map showpart("tag_socket_c");
        mdl_map clientfield::set("" + #"hash_2928b6d60aaacda6", 3);
        mdl_map showpart("tag_glow_c");
        break;
    case #"tag_socket_d":
        mdl_map hidepart("tag_map_part_d");
        mdl_map showpart("tag_socket_d");
        mdl_map clientfield::set("" + #"hash_2928b6d60aaacda6", 4);
        mdl_map showpart("tag_glow_d");
        break;
    case #"tag_socket_e":
        mdl_map hidepart("tag_map_part_e");
        mdl_map showpart("tag_socket_e");
        mdl_map clientfield::set("" + #"hash_2928b6d60aaacda6", 5);
        mdl_map showpart("tag_glow_e");
        break;
    case #"tag_socket_f":
        mdl_map hidepart("tag_map_part_f");
        mdl_map showpart("tag_socket_f");
        mdl_map clientfield::set("" + #"hash_2928b6d60aaacda6", 6);
        break;
    case #"tag_socket_g":
        mdl_map hidepart("tag_map_part_g");
        mdl_map showpart("tag_socket_g");
        mdl_map clientfield::set("" + #"hash_2928b6d60aaacda6", 7);
        mdl_map showpart("tag_glow_g");
        break;
    }
}

