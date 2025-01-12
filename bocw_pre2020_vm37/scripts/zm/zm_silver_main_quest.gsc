#using script_3411bb48d41bd3b;
#using script_36f4be19da8eb6d0;
#using script_4d1e366b77f0b4b;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_silver_util;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_silver_main_quest;

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x89754f86, Offset: 0xf00
// Size: 0x24c
function init() {
    array::run_all(getentarray("text_clue", "script_noteworthy"), &hide);
    if (!zm_utility::is_ee_enabled()) {
        return;
    }
    init_steps();
    level.var_c666969c = gettime();
    level.var_46a47223 = [];
    level.var_e6e5751 = [];
    level.var_9bca1c1e = [];
    clientfield::register("scriptmover", "" + #"hash_8358a32177aa60e", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_6ac50b8c31412793", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_654274a0648df21d", 1, 1, "int");
    scene::add_scene_func("aib_t9_zm_silver_secretecho_2_lastsoldier_01", &function_21b1ba52, "done");
    scene::add_scene_func("aib_t9_zm_silver_secretecho_1_kurtzandvogel_01", &function_21b1ba52, "done");
    scene::add_scene_func("aib_t9_zm_silver_secretecho_3_dmitriyev_kalashnik_01_throw", &function_21b1ba52, "done");
    scene::add_scene_func("aib_t9_zm_silver_secretecho_5_valentinaandpeck", &function_21b1ba52, "done");
    scene::add_scene_func("aib_t9_zm_silver_echo_5_orlov_01", &function_21b1ba52, "done");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xfbc7f5d, Offset: 0x1158
// Size: 0x58c
function init_steps() {
    var_71d5d06f = array(getent("mq_terminal_1", "targetname"), getent("mq_terminal_2", "targetname"));
    level zm_sq::register(#"main_quest", #"hash_3d1c7144a1afab2a", #"hash_3d1c7144a1afab2a", &function_e1ffd71a, &function_de0b1ab2, undefined, undefined, #"hash_9096e6ed9966653", var_71d5d06f, #"hash_c2d79d755228c4b");
    level zm_sq::register(#"main_quest", #"hash_31615b8387c7fe75", #"hash_31615b8387c7fe75", &function_5c9f6aa5, &function_d280572e);
    level zm_sq::register(#"main_quest", #"hash_1e814d4b4714c618", #"hash_1e814d4b4714c618", &function_f8065ad8, &function_bdfb3840);
    level zm_sq::register(#"main_quest", #"hash_61ed135b2872c893", #"hash_61ed135b2872c893", &function_6e538fed, &function_2bc04c1);
    level zm_sq::register(#"main_quest", #"hash_92c2f3cbebbdf63", #"hash_92c2f3cbebbdf63", &function_7d5e3785, &function_3520ea1b);
    var_767ca252 = getent("vol_trap_zone", "script_noteworthy");
    level zm_sq::register(#"main_quest", #"hash_3d0833fa6be461ba", #"hash_3d0833fa6be461ba", &function_ea72075c, &function_9c7d7ce3, undefined, undefined, #"hash_909716ed9966b6c", var_767ca252.origin + (0, 0, -80), #"hash_71435b928ff6e5ba");
    level zm_sq::register(#"main_quest", #"hash_a9a2facc1258eb5", #"hash_a9a2facc1258eb5", &function_54ad1c95, &function_afbc77b5, undefined, undefined, #"hash_909716ed9966b6c", var_767ca252.origin, #"hash_71435b928ff6e5ba");
    level zm_sq::register(#"main_quest", #"hash_76f226ea4b16acdf", #"hash_76f226ea4b16acdf", &function_cb0e55f0, &function_70ffca9c);
    level zm_sq::register(#"main_quest", #"hash_4bb113a34a5e1d91", #"hash_4bb113a34a5e1d91", &function_1bddc36a, &function_d5e55496);
    level zm_sq::register(#"main_quest", #"defend", #"defend", &function_34c29791, &function_d7ef969f);
    var_c807dc8e = getent("mq_extraction_vol", "script_noteworthy");
    level zm_sq::register(#"main_quest", #"hash_48ee9c10dd3affe2", #"hash_48ee9c10dd3affe2", &function_852146cc, &function_e3bd1289, undefined, undefined, #"hash_909756ed9967238", var_c807dc8e.origin, #"hash_a2691054a670ad6");
    level thread function_5f94604c();
}

/#

    // Namespace zm_silver_main_quest/zm_silver_main_quest
    // Params 1, eflags: 0x4
    // Checksum 0xa8deb9ed, Offset: 0x16f0
    // Size: 0x106
    function private function_7a4e3128(var_77f5a825) {
        if (!getdvarint(#"zm_debug_ee", 0)) {
            return;
        }
        self notify(#"hash_706c332950c29a");
        self endon(#"death", #"trigger_activated", #"hash_706c332950c29a");
        if (isdefined(var_77f5a825)) {
            level endon(var_77f5a825);
        }
        while (true) {
            print3d(self.origin, isdefined(self.targetname) ? self.targetname : "<dev string:x38>", (1, 1, 0));
            circle(self.origin, 50, (1, 0, 0));
            waitframe(1);
        }
    }

#/

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x5 linked
// Checksum 0xca6ce8e9, Offset: 0x1800
// Size: 0xa4
function private function_5f94604c() {
    level flag::wait_till(#"pap_quest_completed");
    exploder::exploder("lgt_1_terminal_default");
    exploder::exploder("lgt_2_terminal_default");
    showmiscmodels("mq_terminal_1_screen_inactive");
    showmiscmodels("mq_terminal_2_screen_inactive");
    level zm_sq::start(#"main_quest");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xa4a2db4a, Offset: 0x18b0
// Size: 0x4c
function function_e1ffd71a(b_skipped) {
    if (!b_skipped) {
        level thread function_333bb0bf();
        level flag::wait_till(#"hash_f76df886bf08a69");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x9965b9c8, Offset: 0x1908
// Size: 0x1a4
function function_333bb0bf() {
    level endon(#"hash_f76df886bf08a69");
    level flag::set("on_mq_step_0_2");
    var_763f6aa3 = getent("mq_terminal_1", "targetname");
    var_84288675 = getent("mq_terminal_2", "targetname");
    var_763f6aa3 thread function_61b74ad2(1);
    var_84288675 thread function_61b74ad2(2);
    /#
        var_763f6aa3 thread function_7a4e3128(#"hash_1147084612afb48");
        var_84288675 thread function_7a4e3128(#"hash_1147084612afb48");
    #/
    level flag::wait_till_all(["terminal_1_is_on", "terminal_2_is_on"]);
    exploder::kill_exploder("lgt_1_central_ring_on");
    exploder::kill_exploder("lgt_2_central_ring_on");
    exploder::exploder("lgt_central_ring_powered_on");
    level flag::set(#"hash_f76df886bf08a69");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x298565ce, Offset: 0x1ab8
// Size: 0x2d4
function function_61b74ad2(num) {
    self function_d0ea17ef();
    self playloopsound(#"hash_e427104e61379b4");
    self zm_unitrigger::function_fac87205(#"hash_4ac2088091af9f3", (128, 128, 128));
    zm_sq::objective_complete(#"hash_9096e6ed9966653", self);
    exploder::kill_exploder("lgt_" + num + "_terminal_default");
    exploder::exploder("lgt_" + num + "_terminal_powered_on");
    exploder::exploder("lgt_" + num + "_central_ring_on");
    level flag::set("terminal_" + num + "_is_on");
    self function_243362d5();
    var_30873e2 = getent(self.target, "targetname");
    if (num == 1) {
        hidemiscmodels("mq_terminal_1_screen_inactive");
        showmiscmodels("mq_terminal_1_screen_active");
        playsoundatposition(#"hash_2476018476499593", (1616, 741, -270));
        var_30873e2 thread scene::play(#"hash_5907836ecd97d65b", var_30873e2);
    } else {
        hidemiscmodels("mq_terminal_2_screen_inactive");
        showmiscmodels("mq_terminal_2_screen_active");
        level notify(#"hash_3537191335625c");
        var_30873e2 scene::play(#"hash_7e0c2c7083a69618", var_30873e2);
        var_30873e2 thread scene::play(#"hash_9bd0219148fe33d", var_30873e2);
    }
    self stoploopsound();
    self playsound(#"hash_5d3d77f0c8fb9cab");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x84345186, Offset: 0x1d98
// Size: 0x24
function function_d0ea17ef() {
    self playloopsound(#"hash_7c54bdcaad060d12");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xdf162352, Offset: 0x1dc8
// Size: 0x44
function function_243362d5() {
    self stoploopsound();
    playsoundatposition(#"hash_9df6c6dfef5d0b5", self.origin);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x44e0a7b, Offset: 0x1e18
// Size: 0x44
function function_de0b1ab2(b_skipped, var_19e802fa) {
    if (b_skipped || var_19e802fa) {
        level flag::set(#"hash_f76df886bf08a69");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xcb45a246, Offset: 0x1e68
// Size: 0x4c
function function_5c9f6aa5(b_skipped) {
    if (!b_skipped) {
        level thread function_16b7f990();
        level flag::wait_till(#"assemble_aetherscope_finished");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xcab9681d, Offset: 0x1ec0
// Size: 0x834
function function_16b7f990() {
    level endon(#"assemble_aetherscope_finished");
    level thread function_34a1157d("aib_t9_zm_silver_secretecho_2_lastsoldier_01", "zone_proto_interior_lower", "assemble_aetherscope_finished");
    level thread function_34a1157d("aib_t9_zm_silver_secretecho_1_kurtzandvogel_01", "zone_center_upper_north", "assemble_aetherscope_finished");
    var_32b1f567 = struct::get_array("aetherscope_tear_location", "targetname");
    var_44aa636e = getent("mq_crafting_table", "targetname");
    var_9ea5e482 = var_44aa636e zm_unitrigger::create(&function_c2af573e, (96, 96, 96), undefined, 0);
    var_7588c69f = 0;
    var_952641e5 = 0;
    var_2d4fbfe0 = undefined;
    while (true) {
        if (var_32b1f567.size == 0) {
            break;
        }
        if (!isdefined(var_2d4fbfe0)) {
            var_2d4fbfe0 = var_32b1f567[randomint(var_32b1f567.size)];
        }
        var_f2484ed9 = util::spawn_model("tag_origin", var_2d4fbfe0.origin);
        var_f2484ed9 clientfield::set("" + #"hash_7ec80a02e9bb051a", 1);
        var_2d4fbfe0 function_19986231();
        if (!isdefined(level.var_83de12b4)) {
            level.var_83de12b4 = [];
        } else if (!isarray(level.var_83de12b4)) {
            level.var_83de12b4 = array(level.var_83de12b4);
        }
        level.var_83de12b4[level.var_83de12b4.size] = var_f2484ed9;
        /#
            var_f2484ed9 thread function_7a4e3128(#"hash_2dd625fe64fe0cd3");
        #/
        if (!var_7588c69f) {
            zm_sq::function_266d66eb(#"hash_9096d6ed99664a0", var_f2484ed9, 1, #"hash_680d1678e7a47e8e");
        }
        var_f2484ed9 zm_unitrigger::function_fac87205(#"hash_622731cfc9a72bfa", 96);
        level notify(#"into_the_dark_side");
        var_f2484ed9 clientfield::set("" + #"hash_7ec80a02e9bb051a", 0);
        zm_sq::objective_complete(#"hash_9096d6ed99664a0", var_f2484ed9);
        var_f2484ed9 delete();
        var_1fe5108 = getent(var_2d4fbfe0.var_96dbe9c2, "targetname");
        var_1fe5108 show();
        var_f6425d8c = struct::get(var_2d4fbfe0.target2, "targetname");
        mdl_part = util::spawn_model(var_f6425d8c.model, var_f6425d8c.origin, var_f6425d8c.angles);
        mdl_part setscale(2);
        /#
            mdl_part thread function_7a4e3128(#"hash_2dd625fe64fe0cd3");
        #/
        var_dc044193 = mdl_part zm_unitrigger::create(&function_1ccda577, 64, &function_90b46fda);
        waitresult = level waittill(#"manage_to_find_aetherscope_part", #"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
        if (waitresult._notify === "manage_to_find_aetherscope_part") {
            if (isdefined(var_1fe5108)) {
                var_1fe5108 delete();
            }
            var_2607d9f3 = getent(var_44aa636e.var_96dbe9c2, "targetname");
            var_2607d9f3 show();
            var_7588c69f = 1;
            zm_sq::objective_complete(#"hash_9096d6ed99664a0", mdl_part);
            if (!var_952641e5) {
                zm_sq::function_266d66eb(#"hash_7169b55bba8d35a6", var_44aa636e, undefined, #"hash_75abf36ec4eadd1c");
                var_952641e5 = 1;
            }
            arrayremovevalue(var_32b1f567, var_2d4fbfe0);
            var_2d4fbfe0 = undefined;
            var_7dee5616 = struct::get(var_f6425d8c.target, "targetname");
            mdl_part.origin = var_7dee5616.origin;
            mdl_part.angles = var_7dee5616.angles;
            mdl_part thread function_6e288d90();
        } else {
            mdl_part delete();
        }
        zm_unitrigger::unregister_unitrigger(var_dc044193);
    }
    zm_unitrigger::unregister_unitrigger(var_9ea5e482);
    var_44aa636e zm_unitrigger::function_fac87205(#"hash_6b9271f7c080a17d", 96);
    if (isdefined(var_2607d9f3)) {
        var_2607d9f3 delete();
    }
    level notify(#"hash_69c57c772395bf4a");
    /#
        iprintlnbold("<dev string:x43>");
    #/
    wait 3;
    var_9d20261b = util::spawn_model("p9_zm_ndu_aetherscope", struct::get("mq_aetherscope_loc").origin, struct::get("mq_aetherscope_loc").angles);
    var_9d20261b setscale(2);
    var_44aa636e zm_unitrigger::function_fac87205(#"hash_6dd4891f4477255f", 96);
    var_9d20261b delete();
    zm_sq::objective_complete(#"hash_7169b55bba8d35a6", var_44aa636e);
    /#
        iprintlnbold("<dev string:x6d>");
    #/
    level function_a3de347d();
    level flag::set(#"assemble_aetherscope_finished");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x63b5258c, Offset: 0x2700
// Size: 0x30
function function_c2af573e(*e_player) {
    self sethintstring(#"hash_2136e9a168798916");
    return true;
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x9bad36a5, Offset: 0x2738
// Size: 0x54
function function_1ccda577(*e_player) {
    if (level flag::get(#"dark_aether_active")) {
        self sethintstring(#"hash_1527cc781ba274a8");
        return true;
    }
    return false;
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xcd65cd5a, Offset: 0x2798
// Size: 0x30
function function_90b46fda() {
    self waittill(#"trigger");
    level notify(#"manage_to_find_aetherscope_part");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x9e5ba4c, Offset: 0x27d0
// Size: 0x4c
function function_6e288d90() {
    level endon(#"end_game");
    level waittill(#"hash_69c57c772395bf4a");
    self delete();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x713763f0, Offset: 0x2828
// Size: 0x14
function function_a3de347d() {
    zm_silver_util::function_8fbe908e();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x72dd6c64, Offset: 0x2848
// Size: 0xc4
function function_d280572e(b_skipped, var_19e802fa) {
    if (b_skipped || var_19e802fa) {
        if (isarray(level.var_83de12b4)) {
            arrayremovevalue(level.var_83de12b4, undefined);
            array::run_all(level.var_83de12b4, &delete);
        }
        level flag::set(#"assemble_aetherscope_finished");
        level function_a3de347d();
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x6335166b, Offset: 0x2918
// Size: 0x4c
function function_f8065ad8(b_skipped) {
    if (!b_skipped) {
        level thread function_6498e65c();
        level flag::wait_till(#"init_purifier_finished");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x30212e03, Offset: 0x2970
// Size: 0x3a4
function function_6498e65c() {
    level endon(#"init_purifier_finished");
    level.var_3bc06d8a = getent("mq_researcher_computer", "script_noteworthy");
    var_617f86a3 = getent("control_room_tear", "script_noteworthy");
    var_617f86a3 thread function_a3d3d7c2();
    function_7b6e6199();
    if (isdefined(getent(var_617f86a3.var_96dbe9c2, "targetname"))) {
        getent(var_617f86a3.var_96dbe9c2, "targetname") delete();
    }
    level flag::wait_till_clear(#"dark_aether_active");
    /#
        level.var_3bc06d8a thread function_7a4e3128(#"hash_1a730a397ac55112");
    #/
    level.var_3bc06d8a zm_unitrigger::function_fac87205(#"hash_2a4e3990e91343b9", 64);
    /#
        iprintlnbold("<dev string:x88>");
    #/
    if (isdefined(level.var_6c682532)) {
        level.var_6c682532 delete();
    }
    level.var_7c6e836b = util::spawn_model(#"hash_23c2423afaccc4e5", level.var_b2371398.origin, level.var_b2371398.angles);
    level.var_3a734155 = util::spawn_model(#"hash_2a7c99f5ca0f1bbd", level.var_b2371398.origin, level.var_b2371398.angles);
    wait 1;
    if (isdefined(level.var_3a734155)) {
        level.var_3a734155 delete();
    }
    level.var_fc67035a = util::spawn_model(#"hash_23c2493afaccd0ca", level.var_b2371398.origin, level.var_b2371398.angles);
    level.var_50356cd9 = util::spawn_model(#"hash_2a7c98f5ca0f1a0a", level.var_b2371398.origin, level.var_b2371398.angles);
    wait 1;
    if (isdefined(level.var_50356cd9)) {
        level.var_50356cd9 delete();
    }
    level.var_729c7023 = util::spawn_model(#"hash_23c24b3afaccd430", level.var_b2371398.origin, level.var_b2371398.angles);
    wait 1;
    level flag::set(#"init_purifier_finished");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x5 linked
// Checksum 0xd9af5993, Offset: 0x2d20
// Size: 0x13c
function private function_51cc09e(var_f2484ed9) {
    level endon(#"end_game");
    zm_sq::function_266d66eb(#"hash_909706ed99669b9", var_f2484ed9, 1, #"hash_41e9386b4e3c3f9d");
    zm_sq::function_3029d343(#"hash_909706ed99669b9", var_f2484ed9);
    while (!level flag::get(#"init_purifier_finished") && !zm_zonemgr::any_player_in_zone(#"zone_trans_north")) {
        wait 0.5;
    }
    zm_sq::function_aee0b4b4(#"hash_909706ed99669b9", var_f2484ed9);
    level flag::wait_till(#"init_purifier_finished");
    zm_sq::objective_complete(#"hash_909706ed99669b9", var_f2484ed9);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xdcbf5cf6, Offset: 0x2e68
// Size: 0x6c8
function function_a3d3d7c2() {
    level endon(#"end_game", #"hash_737db8433b93b7ae");
    var_75e3c719 = util::spawn_model("tag_origin", self.origin);
    var_ff8e8b10 = getent("mq_researcher_notebook", "script_noteworthy");
    var_59a8717 = getent("mq_researcher_notebook_dark", "script_noteworthy");
    var_59a8717 hide();
    var_b1b19002 = getent("dark_notebook_trig", "script_noteworthy");
    var_b1b19002.origin = var_59a8717.origin;
    var_b1b19002 setinvisibletoall();
    level thread function_51cc09e(var_75e3c719);
    while (true) {
        level flag::wait_till_clear(#"dark_aether_active");
        var_75e3c719 clientfield::set("" + #"hash_7ec80a02e9bb051a", 1);
        /#
            var_75e3c719 thread function_7a4e3128(#"hash_1a730a397ac55112");
        #/
        var_75e3c719 function_19986231();
        var_75e3c719 zm_unitrigger::function_fac87205(#"hash_622731cfc9a72bfa", 96);
        level zm_sq::function_3029d343(#"hash_909706ed99669b9", var_75e3c719);
        var_75e3c719 clientfield::set("" + #"hash_7ec80a02e9bb051a", 0);
        level notify(#"into_the_dark_side");
        var_1fe5108 = getent(self.var_96dbe9c2, "targetname");
        var_1fe5108 show();
        var_c32b93c6 = zm_zonemgr::get_active_zone_names();
        var_a96b643a = [];
        var_bca19f66 = struct::get_array("steiner_location", "script_noteworthy");
        foreach (spawner in var_bca19f66) {
            if (isinarray(var_c32b93c6, hash(spawner.zone_name))) {
                if (!isdefined(var_a96b643a)) {
                    var_a96b643a = [];
                } else if (!isarray(var_a96b643a)) {
                    var_a96b643a = array(var_a96b643a);
                }
                var_a96b643a[var_a96b643a.size] = spawner;
            }
        }
        var_39c83b76 = var_a96b643a[randomint(var_a96b643a.size)];
        if (isdefined(var_39c83b76)) {
            var_704c79ef = spawnactor(#"hash_acac3fe7a341329", var_39c83b76.origin, var_39c83b76.angles);
        } else {
            /#
                iprintlnbold("<dev string:x9d>");
            #/
            var_704c79ef = spawnactor(#"hash_acac3fe7a341329", var_bca19f66[0].origin, var_bca19f66[0].angles);
        }
        var_ff8e8b10 hide();
        if (!level flag::get("someone_has_notebook")) {
            var_59a8717 show();
            var_59a8717 clientfield::set("" + #"hash_6cfa6a77c2e81774", 1);
            /#
                var_59a8717 thread function_7a4e3128(#"hash_1a730a397ac55112");
            #/
            var_b1b19002 function_4dec7915();
            if (level.var_ba3a0e1f > 0) {
                var_59a8717 hide();
                var_b1b19002 setinvisibletoall();
                /#
                    iprintlnbold("<dev string:xc6>");
                #/
                level flag::set("someone_has_notebook");
                level waittill(#"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
            } else {
                var_59a8717 hide();
                var_b1b19002 setinvisibletoall();
            }
        } else {
            var_59a8717 hide();
            var_b1b19002 setinvisibletoall();
            level waittill(#"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
        }
        if (isdefined(var_704c79ef)) {
            var_704c79ef delete();
        }
        level zm_sq::function_aee0b4b4(#"hash_909706ed99669b9", var_75e3c719);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xe5d95a24, Offset: 0x3538
// Size: 0x72
function function_4dec7915() {
    level endon(#"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
    self setvisibletoall();
    self sethintstring(#"hash_120862ef7e3a3a04");
    self waittill(#"trigger");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x39a95125, Offset: 0x35b8
// Size: 0x3c0
function function_7b6e6199() {
    level endon(#"init_purifier_finished");
    var_3d0030f2 = getentarray("dark_aether_echo", "script_noteworthy");
    while (true) {
        if (var_3d0030f2.size == 0) {
            break;
        }
        if (!level flag::get(#"dark_aether_active")) {
            level waittill(#"into_the_dark_side");
        }
        var_94c7397b = util::spawn_model("tag_origin", var_3d0030f2[0].origin);
        var_94c7397b thread function_de34115();
        var_2943b0b6 = getent("dark_echo_trig", "script_noteworthy");
        var_2943b0b6.origin = var_94c7397b.origin;
        var_2943b0b6 function_7b82152b();
        var_2943b0b6 setinvisibletoall();
        if (level.var_ba3a0e1f > 0) {
            var_94c7397b flag::set("orb_is_deciphered");
            switch (var_3d0030f2.size) {
            case 3:
                level thread function_28cbcd87("aib_t9_zm_silver_echo_1_vogel_01", "init");
                break;
            case 2:
                level thread function_28cbcd87("aib_t9_zm_silver_echo_2_vogel_01", "init");
                break;
            case 1:
                level thread function_28cbcd87("aib_t9_zm_silver_echo_3_vogel_01", "init");
                break;
            }
            var_88ac8c9a = getent("dark_echo_mdl_trig", "script_noteworthy");
            var_88ac8c9a.origin = var_3d0030f2[0].origin;
            var_88ac8c9a function_81e13749();
            var_88ac8c9a setinvisibletoall();
            if (level.var_ba3a0e1f > 0) {
                switch (var_3d0030f2.size) {
                case 3:
                    level thread scene::play("aib_t9_zm_silver_echo_1_vogel_01", "main");
                    break;
                case 2:
                    level thread scene::play("aib_t9_zm_silver_echo_2_vogel_01", "main");
                    break;
                case 1:
                    level thread scene::play("aib_t9_zm_silver_echo_3_vogel_01", "main");
                    break;
                }
                arrayremovevalue(var_3d0030f2, var_3d0030f2[0]);
                if (var_3d0030f2.size == 0) {
                    level flag::set(#"hash_737db8433b93b7ae");
                }
            }
        }
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x7db61e25, Offset: 0x3980
// Size: 0x94
function function_28cbcd87(scene_name, shot_name) {
    if (isdefined(shot_name)) {
        level scene::play(scene_name, shot_name);
    } else {
        level scene::play(scene_name);
    }
    level flag::wait_till_clear(#"dark_aether_active");
    level scene::delete_scene_spawned_ents(scene_name);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xcd732bb, Offset: 0x3a20
// Size: 0xbc
function function_7b82152b() {
    level endon(#"end_game", #"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
    self setvisibletoall();
    self sethintstring(#"hash_51eee553370b6580");
    waitresult = self waittill(#"trigger");
    waitresult.activator thread flag::set_for_time(2, #"hash_7ef7aab6a305d0b0");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x7f31bdb1, Offset: 0x3ae8
// Size: 0x34
function function_de34115() {
    self function_d2fe6299();
    self function_79d4f5fd();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb5651436, Offset: 0x3b28
// Size: 0x20e
function function_d2fe6299() {
    level endon(#"end_game", #"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
    /#
        self thread function_7a4e3128(#"hash_1a730a397ac55112");
    #/
    while (!self flag::get("orb_is_deciphered")) {
        var_a330507a = 0;
        all_players = getplayers();
        foreach (player in all_players) {
            if (distancesquared(self.origin, player.origin) <= 65536) {
                var_a330507a = 1;
                if (!player flag::get(#"hash_1154242c9b1e4518")) {
                    player flag::set(#"hash_1154242c9b1e4518");
                }
                continue;
            }
            if (player flag::get(#"hash_1154242c9b1e4518")) {
                player flag::clear(#"hash_1154242c9b1e4518");
            }
        }
        self clientfield::set("" + #"hash_8358a32177aa60e", var_a330507a);
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb12aa2c2, Offset: 0x3d40
// Size: 0xf4
function function_79d4f5fd() {
    all_players = getplayers();
    foreach (player in all_players) {
        if (player flag::get(#"hash_1154242c9b1e4518")) {
            player flag::clear(#"hash_1154242c9b1e4518");
        }
    }
    self clientfield::set("" + #"hash_8358a32177aa60e", 0);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x1600fe96, Offset: 0x3e40
// Size: 0xce
function function_2bea7db4() {
    level endon(#"end_game", #"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
    self endon(#"trigger");
    while (true) {
        if (level flag::get("someone_has_notebook")) {
            self setvisibletoall();
            self sethintstring(#"hash_79ebe2a27b154ea0");
        } else {
            self setinvisibletoall();
        }
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x4bb3a397, Offset: 0x3f18
// Size: 0x62
function function_81e13749() {
    level endon(#"end_game", #"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
    self thread function_2bea7db4();
    self waittill(#"trigger");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0xb0d53973, Offset: 0x3f88
// Size: 0x44
function function_bdfb3840(b_skipped, var_19e802fa) {
    if (b_skipped || var_19e802fa) {
        level flag::set(#"init_purifier_finished");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x3cd0b047, Offset: 0x3fd8
// Size: 0x4c
function function_6e538fed(b_skipped) {
    if (!b_skipped) {
        level thread function_dd3b6aa2();
        level flag::wait_till(#"hash_5d063793500cc512");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xa064ff2b, Offset: 0x4030
// Size: 0x2c4
function function_dd3b6aa2() {
    level endon(#"hash_5d063793500cc512");
    if (isdefined(level.var_7c6e836b)) {
        level.var_7c6e836b delete();
    }
    if (isdefined(level.var_fc67035a)) {
        level.var_fc67035a delete();
    }
    if (isdefined(level.var_729c7023)) {
        level.var_729c7023 delete();
    }
    level.var_59b6e9a5 setmodel(#"hash_ae53eff256fd336");
    level flag::clear("on_mq_step_0_2");
    var_5476aa4c = getentarray("purifier_power_receptacle", "script_noteworthy");
    zm_sq::function_266d66eb(#"hash_9096f6ed9966806", struct::get(#"hash_7c3cac2f2706c927").origin, undefined, #"hash_b89b87ca0383dc0");
    foreach (var_cd5bf397 in var_5476aa4c) {
        var_6e56e8a6 = getent(var_cd5bf397.target, "targetname");
        var_6e56e8a6 thread function_3536208d();
    }
    level flag::wait_till_all(["power_particle_collected", "power_gas_collected", "power_nitrogen_collected", "power_plasma_collected"]);
    zm_sq::objective_complete(#"hash_9096f6ed9966806");
    /#
        iprintlnbold("<dev string:xda>");
    #/
    level flag::set(#"hash_5d063793500cc512");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x0
// Checksum 0x8187956b, Offset: 0x4300
// Size: 0x4e
function function_f5edeec7(player, time) {
    if (time >= 2000) {
        self notify(#"hash_323bacd5b189fc1e", {#player:player});
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x6531f0b0, Offset: 0x4358
// Size: 0x3d2
function function_3536208d() {
    self endon(#"hash_6d87c51108eb2436");
    self enablegrenadetouchdamage();
    flag = function_27f2ef17(self);
    function_4e3bb793(self, flag & ~512);
    /#
        self thread function_7a4e3128(#"hash_5be263faf0397bd");
    #/
    while (true) {
        waitresult = self waittill(#"damage");
        if (isplayer(waitresult.attacker) && !isdefined(waitresult.var_98e101b0)) {
            if (namespace_b376a999::function_c988c217(waitresult.weapon) && !level flag::get("power_particle_collected")) {
                level flag::set("power_particle_collected");
                /#
                    iprintlnbold("<dev string:xf0>");
                #/
                self flag::set(#"hash_6d87c51108eb2436");
                /#
                    self notify(#"hash_706c332950c29a");
                #/
            }
            if (namespace_b376a999::function_f1c015e1(waitresult.weapon) && !level flag::get("power_gas_collected")) {
                level flag::set("power_gas_collected");
                /#
                    iprintlnbold("<dev string:x10c>");
                #/
                self flag::set(#"hash_6d87c51108eb2436");
                /#
                    self notify(#"hash_706c332950c29a");
                #/
            }
            if (namespace_b376a999::function_8fbb3409(waitresult.weapon) && !level flag::get("power_nitrogen_collected")) {
                level flag::set("power_nitrogen_collected");
                /#
                    iprintlnbold("<dev string:x123>");
                #/
                self flag::set(#"hash_6d87c51108eb2436");
                /#
                    self notify(#"hash_706c332950c29a");
                #/
            }
            if (namespace_b376a999::function_f17bb85a(waitresult.weapon) && !level flag::get("power_plasma_collected")) {
                level flag::set("power_plasma_collected");
                /#
                    iprintlnbold("<dev string:x13f>");
                #/
                self flag::set(#"hash_6d87c51108eb2436");
                /#
                    self notify(#"hash_706c332950c29a");
                #/
            }
        }
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x77b36949, Offset: 0x4738
// Size: 0x64
function function_2bc04c1(b_skipped, var_19e802fa) {
    if (b_skipped || var_19e802fa) {
        level flag::set(#"hash_5d063793500cc512");
        zm_sq::objective_complete(#"hash_9096f6ed9966806");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x24866dcb, Offset: 0x47a8
// Size: 0x4c
function function_7d5e3785(b_skipped) {
    if (!b_skipped) {
        level thread function_2555092e();
        level flag::wait_till(#"hash_6ddc7fc43d014f02");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xdbe99174, Offset: 0x4800
// Size: 0x5a4
function function_2555092e() {
    level endon(#"hash_6ddc7fc43d014f02");
    level.var_59b6e9a5 setmodel(#"hash_3198b312a1aa0a17");
    level thread function_34a1157d("aib_t9_zm_silver_secretecho_3_dmitriyev_kalashnik_01_throw", "zone_proto_plane_exterior", #"hash_6ddc7fc43d014f02");
    level.var_e5b2e1c9 = getent("mq_gold_container_receptacle", "script_noteworthy");
    /#
        level.var_e5b2e1c9 thread function_7a4e3128(#"hash_53506d2bbecd0fad");
    #/
    zm_sq::function_266d66eb(#"hash_909726ed9966d1f", level.var_e5b2e1c9.origin, undefined, #"hash_5e441db8a8f63707");
    var_21bf9806 = getent("gold_container", "script_noteworthy");
    var_617f86a3 = getent("gold_container_tear", "script_noteworthy");
    var_617f86a3 thread function_2368f5bd();
    function_ac2843b4();
    level flag::wait_till_clear(#"dark_aether_active");
    var_fb3df967 = util::spawn_model("p8_sta_pegboard_tools_wrench_01", var_617f86a3.origin);
    var_fb3df967 rotate((0, 90, 0));
    var_fb3df967 setscale(3);
    var_fb3df967 clientfield::set("" + #"hash_6ac50b8c31412793", 1);
    var_fb3df967 zm_unitrigger::function_fac87205(#"hash_234cb6ada96c6142", 64);
    var_fb3df967 delete();
    tank = getent("panzer_tank", "script_noteworthy");
    tank zm_unitrigger::function_fac87205(#"hash_137a43a0f69e43b3", (256, 256, 256));
    /#
        iprintlnbold("<dev string:x159>");
    #/
    wait 2;
    /#
        iprintlnbold("<dev string:x181>");
    #/
    wait 2;
    tank clientfield::set("" + #"hash_654274a0648df21d", 1);
    foreach (player in getplayers()) {
        if (distancesquared(tank.origin, player.origin) <= 262144) {
            earthquake(0.6, 1, player.origin, 100);
            player playrumbleonentity("damage_heavy");
            continue;
        }
        if (distancesquared(tank.origin, player.origin) <= 1048576) {
            earthquake(0.3, 1, player.origin, 100);
            player playrumbleonentity("damage_heavy");
        }
    }
    /#
        iprintlnbold("<dev string:x198>");
    #/
    var_bb89ed42 = struct::get("gold_container_drop_loc", "script_noteworthy");
    level.var_6f1da2d5 = var_bb89ed42.origin;
    time = var_21bf9806 zm_utility::fake_physicslaunch(var_bb89ed42.origin, 500);
    wait time;
    var_21bf9806 delete();
    level thread function_460881cd();
    zm_sq::objective_complete(#"hash_909726ed9966d1f");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x0
// Checksum 0xb2f8f490, Offset: 0x4db0
// Size: 0x5c
function function_fd44fce7(e_player) {
    if (e_player flag::get("is_gold_container_owner")) {
        self sethintstringforplayer(e_player, #"hash_5d9e8fd25c0e4991");
        return true;
    }
    return false;
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xefba73cf, Offset: 0x4e18
// Size: 0x148
function function_2368f5bd() {
    level endon(#"end_game");
    var_75e3c719 = util::spawn_model("tag_origin", self.origin);
    while (!level flag::get("soldier_dark_echo_found")) {
        var_75e3c719 clientfield::set("" + #"hash_7ec80a02e9bb051a", 1);
        var_75e3c719 function_19986231();
        var_75e3c719 zm_unitrigger::function_fac87205(#"hash_622731cfc9a72bfa", 96);
        var_75e3c719 clientfield::set("" + #"hash_7ec80a02e9bb051a", 0);
        level notify(#"into_the_dark_side");
        level waittill(#"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x5127b896, Offset: 0x4f68
// Size: 0x1b4
function function_ac2843b4() {
    level endon(#"hash_6ddc7fc43d014f02");
    var_d81818fc = struct::get("soldier_echo", "script_noteworthy");
    while (true) {
        level waittill(#"into_the_dark_side");
        var_94c7397b = util::spawn_model("tag_origin", var_d81818fc.origin);
        var_94c7397b thread function_de34115();
        var_2943b0b6 = getent("dark_echo_trig", "script_noteworthy");
        var_2943b0b6.origin = var_94c7397b.origin;
        var_2943b0b6 function_7b82152b();
        var_2943b0b6 setinvisibletoall();
        var_94c7397b clientfield::set("" + #"hash_8358a32177aa60e", 0);
        if (level.var_ba3a0e1f > 0) {
            var_94c7397b flag::set("orb_is_deciphered");
            level thread function_28cbcd87("aib_t9_zm_silver_echo_4_dmitriyev_kalashnik_01");
            level flag::set("soldier_dark_echo_found");
            break;
        }
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x9accb799, Offset: 0x5128
// Size: 0x64
function function_3520ea1b(b_skipped, var_19e802fa) {
    if (b_skipped || var_19e802fa) {
        level flag::set(#"hash_6ddc7fc43d014f02");
        zm_sq::objective_complete(#"hash_909726ed9966d1f");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x33e4ca7e, Offset: 0x5198
// Size: 0x2c
function function_ea72075c(b_skipped) {
    if (b_skipped) {
        return;
    }
    function_2a8262fa();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0xe2de5c1b, Offset: 0x51d0
// Size: 0x194
function function_9c7d7ce3(b_skipped, var_19e802fa) {
    if (b_skipped || var_19e802fa) {
        var_a4dd4eab = struct::get("mq_capture_point_right_02", "script_noteworthy");
        var_61a235dc = struct::get("mq_capture_point_left_02", "script_noteworthy");
        var_22a16427 = getent("mq_purifier_ent", "script_noteworthy");
        var_93700de7 = spawnactor(#"spawner_zm_steiner_split_radiation_blast", var_a4dd4eab.origin, var_a4dd4eab.angles);
        var_7ffcff59 = spawnactor(#"spawner_zm_steiner_split_radiation_bomb", var_61a235dc.origin, var_61a235dc.angles);
        var_93700de7.ai.var_b90dccd6 = 1;
        var_7ffcff59.ai.var_b90dccd6 = 1;
        var_93700de7 linkto(var_22a16427);
        var_7ffcff59 linkto(var_22a16427);
        level flag::set(#"hash_77fa97e90fc553ec");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x92dca2c, Offset: 0x5370
// Size: 0x2c
function function_54ad1c95(b_skipped) {
    if (b_skipped) {
        return;
    }
    function_dbe6d6b3();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x81e2b7a6, Offset: 0x53a8
// Size: 0x44
function function_afbc77b5(b_skipped, var_19e802fa) {
    if (b_skipped || var_19e802fa) {
        level flag::set(#"hash_3b2ee17e5ce02f9e");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x605a6db7, Offset: 0x53f8
// Size: 0x2c
function function_cb0e55f0(b_skipped) {
    if (b_skipped) {
        return;
    }
    function_41e8018f();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0xcc0e3387, Offset: 0x5430
// Size: 0x74
function function_70ffca9c(b_skipped, var_19e802fa) {
    if (b_skipped || var_19e802fa) {
        zm_sq::objective_complete(#"hash_909746ed9967085", level.var_3bc06d8a);
        level flag::set(#"hash_3e332b6888c86102");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x47b6442b, Offset: 0x54b0
// Size: 0x2c
function function_1bddc36a(b_skipped) {
    if (b_skipped) {
        return;
    }
    function_8c5dae74();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0xa8252c29, Offset: 0x54e8
// Size: 0x64
function function_d5e55496(b_skipped, var_19e802fa) {
    if (b_skipped || var_19e802fa) {
        zm_sq::objective_complete(#"hash_909736ed9966ed2");
        level flag::set(#"hash_322c7f92525e008e");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x19cd3410, Offset: 0x5558
// Size: 0x2c
function function_34c29791(b_skipped) {
    if (b_skipped) {
        return;
    }
    function_1226c0a6();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x4edc9c43, Offset: 0x5590
// Size: 0x13c
function function_d7ef969f(b_skipped, var_19e802fa) {
    if (b_skipped || var_19e802fa) {
        var_bf48e9e2 = function_b6a1fe09();
        foreach (var_2cbc18b7 in var_bf48e9e2) {
            zm_sq::objective_complete(#"hash_909766ed99673eb", var_2cbc18b7);
        }
    }
    level flag::set(#"hash_3a617ab5e651c2a9");
    level flag::set(#"hash_4a49aa778b3cdd8");
    level flag::set(#"hash_1aab687832f4e02b");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x3cbbfc1, Offset: 0x56d8
// Size: 0x2c
function function_852146cc(b_skipped) {
    if (b_skipped) {
        return;
    }
    function_39f889a2();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0xdd054943, Offset: 0x5710
// Size: 0x44
function function_e3bd1289(b_skipped, var_19e802fa) {
    if (b_skipped || var_19e802fa) {
    }
    level flag::set(#"main_quest_completed");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xd7b2da14, Offset: 0x5760
// Size: 0xf4
function function_e3cee79f() {
    assert(isdefined(self.var_6f1da2d5));
    if (isdefined(self.e_container)) {
        zm_unitrigger::unregister_unitrigger(self.e_container.s_unitrigger);
        self.e_container delete();
    }
    e_container = util::spawn_model("wpn_t9_zm_gold_container_b", self.var_6f1da2d5);
    e_container clientfield::set("" + #"hash_6ac50b8c31412793", 1);
    self.e_container = e_container;
    self.e_container thread function_4ad1059d();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x89be4d61, Offset: 0x5860
// Size: 0xdc
function function_460881cd() {
    level.var_5e824298 = getweapon("equip_gold_container_zm");
    level function_e3cee79f();
    var_5cce521e = level.var_e5b2e1c9 zm_unitrigger::create(&function_e8030fb1, 64, &function_8b8ae486);
    zm_unitrigger::unitrigger_force_per_player_triggers(var_5cce521e, 1);
    zm_player::function_a827358a(&on_player_damage);
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x770959fd, Offset: 0x5948
// Size: 0x140
function function_8b8ae486() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (zm_utility::can_use(e_player) || e_player getcurrentweapon() === level.var_5e824298) {
            if (isdefined(self.stub) && isdefined(self.stub.related_parent)) {
                self.stub.related_parent notify(#"trigger_activated", {#e_who:e_player});
                var_693201b7 = util::spawn_model("wpn_t9_zm_gold_container_b", level.var_e5b2e1c9.origin);
                /#
                    iprintlnbold("<dev string:x1a6>");
                #/
            }
        }
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xd9df8b9e, Offset: 0x5a90
// Size: 0x1ac
function function_714e14de() {
    level endon(#"end_game");
    v_start = self.origin + (0, 0, 32);
    v_end = self.origin - (0, 0, 1000);
    a_trace = groundtrace(v_start, v_end, 0, self, 1);
    v_ground_pos = (isdefined(a_trace[#"position"]) ? a_trace[#"position"] : self.origin) + (0, 0, 40);
    level.e_container unlink();
    level.e_container moveto(v_ground_pos, 0.001);
    level.e_container waittill(#"movedone");
    level.e_container show();
    level.e_container solid();
    level.e_container clientfield::set("" + #"hash_6ac50b8c31412793", 1);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xe13ecaf7, Offset: 0x5c48
// Size: 0x9c
function function_c9c7c89(e_player) {
    if (zm_utility::is_player_valid(e_player) && e_player getcurrentweapon() != level.var_5e824298 && e_player getstance() != "prone") {
        self sethintstringforplayer(e_player, #"hash_59e71eb437317859");
        return true;
    }
    return false;
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x7a81c321, Offset: 0x5cf0
// Size: 0x9c
function function_e8030fb1(e_player) {
    if (zm_utility::is_player_valid(e_player) && e_player getcurrentweapon() == level.var_5e824298 && e_player getstance() != "prone") {
        self sethintstringforplayer(e_player, #"hash_5d9e8fd25c0e4991");
        return true;
    }
    return false;
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x4cea727, Offset: 0x5d98
// Size: 0x74
function function_85e60c0a() {
    self notify("17272be6688144ad");
    self endon("17272be6688144ad");
    level endon(#"end_game", #"hash_1f20be24ebb9923c");
    wait 60;
    level notify(#"hash_e853f57d046c3c0");
    level function_e3cee79f();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xd4ceca19, Offset: 0x5e18
// Size: 0x16c
function function_4ad1059d() {
    self notify("2082b2cc13ab2605");
    self endon("2082b2cc13ab2605");
    level endon(#"end_game", #"hash_e853f57d046c3c0");
    self flag::set(#"hash_34f3622313246418");
    var_feff37a5 = self zm_unitrigger::function_fac87205(&function_c9c7c89);
    level notify(#"hash_1f20be24ebb9923c");
    self flag::clear(#"hash_34f3622313246418");
    var_feff37a5.e_container = self;
    level.e_container hide();
    level.e_container notsolid();
    level.e_container clientfield::set("" + #"hash_6ac50b8c31412793", 0);
    level.e_container linkto(var_feff37a5);
    self thread function_7acfbb3a(var_feff37a5);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 10, eflags: 0x1 linked
// Checksum 0xd7528955, Offset: 0x5f90
// Size: 0xb6
function on_player_damage(*einflictor, *eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime) {
    if (psoffsettime >= self.health) {
        if (self getcurrentweapon() === level.var_5e824298) {
            self notify(#"hash_46a03eeac0661b25", {#str_result:"dropped"});
        }
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x9c299a4d, Offset: 0x6050
// Size: 0xd0
function on_player_disconnect() {
    if (!self util::is_spectating()) {
        var_2e07b8ff = self getweaponslistprimaries();
        foreach (w_weapon in var_2e07b8ff) {
            if (w_weapon === level.var_5e824298) {
                self thread function_86404122();
            }
        }
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb5756732, Offset: 0x6128
// Size: 0x8c
function function_86404122() {
    self thread function_714e14de();
    self.e_container thread function_85e60c0a();
    self.e_container thread function_4ad1059d();
    callback::remove_on_weapon_change(&function_e9df7768);
    callback::function_824d206(&function_7904960c);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x623d469b, Offset: 0x61c0
// Size: 0x1e0
function function_7acfbb3a(e_player) {
    e_player endon(#"hash_46a03eeac0661b25", #"disconnect");
    e_player val::set(#"hash_754e9e4a6ccbcb80", "disable_weapon_cycling", 1);
    w_current = e_player getcurrentweapon();
    e_player.w_current_weapon = w_current;
    e_player.var_2cf11630 = e_player getammocount(w_current);
    e_player takeweapon(w_current);
    e_player zm_weapons::weapon_give(level.var_5e824298);
    e_player thread function_f4b436d5();
    e_player waittill(#"weapon_change_complete");
    callback::on_weapon_change(&function_e9df7768);
    callback::function_33f0ddd3(&function_7904960c);
    e_player val::reset(#"hash_754e9e4a6ccbcb80", "disable_weapon_cycling");
    self thread function_114098ba(e_player);
    level.var_e5b2e1c9 waittill(#"trigger_activated");
    e_player notify(#"hash_46a03eeac0661b25", {#str_result:"recovered"});
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb243d30b, Offset: 0x63a8
// Size: 0x22c
function function_f4b436d5() {
    self endon(#"disconnect");
    self.is_drinking = 1;
    self val::set(#"hash_754e9e4a6ccbcb80", "disable_offhand_weapons", 1);
    self val::set(#"hash_754e9e4a6ccbcb80", "allow_melee", 0);
    self val::set(#"hash_754e9e4a6ccbcb80", "allow_sprint", 0);
    self val::set(#"hash_754e9e4a6ccbcb80", "allow_jump", 0);
    self val::set(#"hash_754e9e4a6ccbcb80", "allow_crouch", 0);
    self val::set(#"hash_754e9e4a6ccbcb80", "allow_prone", 0);
    self waittill(#"hash_46a03eeac0661b25");
    self.is_drinking = 0;
    self val::reset(#"hash_754e9e4a6ccbcb80", "disable_offhand_weapons");
    self val::reset(#"hash_754e9e4a6ccbcb80", "allow_melee");
    self val::reset(#"hash_754e9e4a6ccbcb80", "allow_sprint");
    self val::reset(#"hash_754e9e4a6ccbcb80", "allow_jump");
    self val::reset(#"hash_754e9e4a6ccbcb80", "allow_crouch");
    self val::reset(#"hash_754e9e4a6ccbcb80", "allow_prone");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xcdf89fff, Offset: 0x65e0
// Size: 0x316
function function_114098ba(e_player) {
    e_player endon(#"disconnect");
    s_result = e_player waittill(#"hash_46a03eeac0661b25", #"fake_death");
    callback::remove_on_weapon_change(&function_e9df7768);
    callback::function_824d206(&function_7904960c);
    e_player.e_container = undefined;
    if (s_result.str_result === "dropped" || s_result.str_result === "loadout_changed" || s_result._notify == "fake_death") {
        if (e_player getcurrentweapon() === level.var_5e824298) {
            e_player takeweapon(level.var_5e824298);
        }
        e_player thread function_714e14de();
        self thread function_85e60c0a();
        self thread function_4ad1059d();
    } else if (is_true(s_result.str_result === "recovered")) {
        e_player takeweapon(level.var_5e824298);
        level flag::set(#"hash_6ddc7fc43d014f02");
        zm_sq::objective_complete(#"hash_909726ed9966d1f");
        level.var_dd02875c = 1;
        level.e_container delete();
    }
    if (s_result.str_result === "loadout_changed" || s_result._notify == "fake_death") {
        return;
    }
    e_player giveweapon(e_player.w_current_weapon);
    e_player switchtoweapon(e_player.w_current_weapon);
    if (is_true(e_player.var_ada0236a)) {
        e_player zm_weapons::function_7c5dd4bd(e_player.w_current_weapon);
    } else {
        e_player setweaponammoclip(e_player.w_current_weapon, e_player.var_2cf11630);
    }
    e_player.var_ada0236a = undefined;
    e_player.w_current_weapon = undefined;
    e_player.var_2cf11630 = undefined;
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x8245c5e5, Offset: 0x6900
// Size: 0x36
function function_e9df7768(*s_params) {
    self notify(#"hash_46a03eeac0661b25", {#str_result:"dropped"});
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xd5d1046a, Offset: 0x6940
// Size: 0x36
function function_7904960c(*eventstruct) {
    self notify(#"hash_46a03eeac0661b25", {#str_result:"loadout_changed"});
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xc1cce2c3, Offset: 0x6980
// Size: 0x5a2
function function_2a8262fa() {
    level endon(#"hash_77fa97e90fc553ec");
    level.var_59b6e9a5 setmodel(#"hash_2d1765d7129d576b");
    var_864e26e4 = getent("vol_trap_zone", "script_noteworthy");
    var_755e4da7 = struct::get("mq_capture_point_right_01", "script_noteworthy");
    var_fcb8287 = struct::get("mq_capture_point_right_02", "script_noteworthy");
    var_8431070e = struct::get("mq_capture_point_left_01", "script_noteworthy");
    var_7f25fcf8 = struct::get("mq_capture_point_left_02", "script_noteworthy");
    var_cec31715 = getent("mq_steiner_capture_agent_right", "script_noteworthy");
    var_21a98a47 = getent("mq_steiner_capture_agent_left", "script_noteworthy");
    var_41d71fcc = [];
    var_211fb567 = [];
    while (true) {
        var_743a066e = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
        arrayremovevalue(var_211fb567, undefined, 0);
        arrayremovevalue(var_41d71fcc, undefined, 0);
        foreach (actor in var_743a066e) {
            if (isalive(actor) && actor istouching(var_864e26e4) && isdefined(actor.var_9fde8624)) {
                if (actor.var_9fde8624 == #"hash_70162f4bc795092") {
                    if (!is_true(actor.ai.var_b90dccd6)) {
                        actor.ai.var_b90dccd6 = 1;
                        actor.takedamage = 0;
                        actor thread function_8d1b6fd8(var_21a98a47, var_8431070e, var_7f25fcf8);
                        if (!isdefined(var_211fb567)) {
                            var_211fb567 = [];
                        } else if (!isarray(var_211fb567)) {
                            var_211fb567 = array(var_211fb567);
                        }
                        var_211fb567[var_211fb567.size] = actor;
                    }
                    if (var_211fb567.size > 1) {
                        foreach (var_fbed7bd8 in var_211fb567) {
                            var_fbed7bd8 kill();
                        }
                    }
                }
                if (actor.var_9fde8624 == #"hash_5653bbc44a034094") {
                    if (!is_true(actor.ai.var_b90dccd6)) {
                        actor.ai.var_b90dccd6 = 1;
                        actor.takedamage = 0;
                        actor thread function_8d1b6fd8(var_cec31715, var_755e4da7, var_fcb8287);
                        if (!isdefined(var_41d71fcc)) {
                            var_41d71fcc = [];
                        } else if (!isarray(var_41d71fcc)) {
                            var_41d71fcc = array(var_41d71fcc);
                        }
                        var_41d71fcc[var_41d71fcc.size] = actor;
                    }
                    if (var_41d71fcc.size > 1) {
                        foreach (var_1d1995be in var_41d71fcc) {
                            var_1d1995be kill();
                        }
                    }
                }
            }
        }
        if (var_41d71fcc.size == 1 && var_211fb567.size == 1) {
            level flag::set(#"hash_77fa97e90fc553ec");
            break;
        }
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x24129823, Offset: 0x6f30
// Size: 0x18a
function function_dbe6d6b3() {
    level endon(#"hash_3b2ee17e5ce02f9e");
    level flag::wait_till(#"hash_77fa97e90fc553ec");
    /#
        iprintlnbold("<dev string:x1c2>");
    #/
    var_448b5a02 = getent("vol_medical_lab_control_room_zone", "script_noteworthy");
    while (true) {
        var_90976634 = 0;
        players = getplayers();
        foreach (player in players) {
            if (player istouching(var_448b5a02)) {
                var_90976634 += 1;
            }
        }
        if (var_90976634 >= level.players.size) {
            level flag::set(#"hash_3b2ee17e5ce02f9e");
            break;
        }
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x6efbcae5, Offset: 0x70c8
// Size: 0x84c
function function_41e8018f() {
    level flag::wait_till(#"hash_3b2ee17e5ce02f9e");
    level.var_59b6e9a5 setmodel(#"hash_4a5671156b3bf14d");
    var_5e6542ac = struct::get("friendly_steiner_break_through_destination_accelerator_room", "script_noteworthy");
    var_c039fc43 = struct::get("friendly_steiner_break_through_destination_power_room", "script_noteworthy");
    var_465f425d = getent("mq_purifier_ent", "script_noteworthy");
    var_dc67de8c = getent("ent_blast_shield_left", "script_noteworthy");
    var_f059f398 = getent("ent_blast_shield_right", "script_noteworthy");
    var_8d8424 = getent("clip_blast_shield_left", "script_noteworthy");
    var_3e2f2fec = getent("clip_blast_shield_right", "script_noteworthy");
    level.var_3bc06d8a = getent("mq_researcher_computer", "script_noteworthy");
    var_24de243e = [];
    var_743a066e = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
    foreach (actor in var_743a066e) {
        if (isalive(actor) && is_true(actor.ai.var_b90dccd6)) {
            if (!isdefined(var_24de243e)) {
                var_24de243e = [];
            } else if (!isarray(var_24de243e)) {
                var_24de243e = array(var_24de243e);
            }
            var_24de243e[var_24de243e.size] = actor;
        }
    }
    zm_sq::function_266d66eb(#"hash_909746ed9967085", level.var_3bc06d8a, undefined, #"hash_3badb2537d14b549");
    level.var_3bc06d8a zm_unitrigger::function_fac87205(#"hash_57620d2432a64bf9", 50);
    zm_sq::objective_complete(#"hash_909746ed9967085", level.var_3bc06d8a);
    a_zombies = getaispeciesarray(level.zombie_team);
    foreach (steiner in var_24de243e) {
        arrayremovevalue(a_zombies, steiner);
    }
    foreach (zombie in a_zombies) {
        zombie kill();
    }
    var_8d8424 moveto(var_8d8424.origin + (0, 0, -272), 0.01, 0, 0);
    var_3e2f2fec moveto(var_3e2f2fec.origin + (0, 0, -272), 0.01, 0, 0);
    var_dc67de8c moveto(var_dc67de8c.origin + (0, 0, -272), 1, 0, 0.5);
    var_f059f398 moveto(var_f059f398.origin + (0, 0, -272), 1, 0, 0.5);
    level flag::clear("spawn_zombies");
    /#
        iprintlnbold("<dev string:x1f4>");
    #/
    namespace_88795f45::function_67a0e9a2(var_24de243e, var_24de243e[0]);
    level flag::wait_till(#"steiner_merge_done");
    var_b0eb5e2 = function_b6a1fe09()[0];
    var_b0eb5e2 linkto(var_465f425d);
    var_b0eb5e2 unlink();
    wait 18;
    if (zm_utility::check_point_in_enabled_zone(var_5e6542ac.origin)) {
        var_b0eb5e2 namespace_88795f45::function_7e855c12(getclosestpointonnavmesh(var_5e6542ac.origin), "run");
    } else if (zm_utility::check_point_in_enabled_zone(var_c039fc43.origin)) {
        var_b0eb5e2 namespace_88795f45::function_7e855c12(getclosestpointonnavmesh(var_c039fc43.origin), "run");
    }
    var_b0eb5e2 hide();
    var_b0eb5e2 kill();
    level flag::set(#"spawn_zombies");
    var_8d8424 moveto(var_8d8424.origin + (0, 0, 272), 0.01, 0, 0);
    var_3e2f2fec moveto(var_3e2f2fec.origin + (0, 0, 272), 0.01, 0, 0);
    var_dc67de8c moveto(var_dc67de8c.origin + (0, 0, 272), 1, 0, 0.5);
    var_f059f398 moveto(var_f059f398.origin + (0, 0, 272), 1, 0, 0.5);
    level flag::set(#"hash_3e332b6888c86102");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xa695912, Offset: 0x7920
// Size: 0x394
function function_8c5dae74() {
    level flag::wait_till(#"hash_3e332b6888c86102");
    level.var_59b6e9a5 setmodel(#"hash_1fbce5805347884");
    var_4da8bc2b = getent("ent_family_photo", "script_noteworthy");
    var_9bb7cfb8 = struct::get("photo_tear", "script_noteworthy");
    var_ccd37052 = struct::get("steiner_photo_loc", "script_noteworthy");
    level thread function_34a1157d("aib_t9_zm_silver_secretecho_5_valentinaandpeck", "zone_power_room", #"hash_22a4a6dd73981ef1");
    exploder::exploder("lgt_env_photo_spotlight");
    level flag::set(#"hash_94bda7ad49639f5");
    exploder::kill_exploder("lgt_env_powered_on_room_10");
    exploder::exploder("lgt_env_powered_off_room_10");
    function_abc0783b("mq_steiner_yell_speaker");
    players = getplayers();
    foreach (player in players) {
        player thread function_9951a0d8();
    }
    zm_sq::function_266d66eb(#"hash_909736ed9966ed2", var_ccd37052.origin, 1, #"hash_30b82baf001f640c");
    var_9bb7cfb8 thread function_a1bf0a43();
    function_b771ea49();
    var_4da8bc2b moveto(var_4da8bc2b.origin + (0, 0, -93), 3, 1, 1);
    var_4da8bc2b waittill(#"movedone");
    var_4da8bc2b zm_unitrigger::function_fac87205(#"hash_472d94931c9eca6c", 50);
    var_4da8bc2b delete();
    zm_silver_util::function_30fe7a2(3);
    level thread function_61724ef9();
    level flag::wait_till(#"hash_22a4a6dd73981ef1");
    zm_sq::objective_complete(#"hash_909736ed9966ed2");
    level flag::set(#"hash_322c7f92525e008e");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x6b6e5d7d, Offset: 0x7cc0
// Size: 0xb0
function function_9d3a3c54() {
    slots = namespace_85745671::function_bdb2b85b(self, self.origin, self.angles, 64, 10, 16);
    if (!isdefined(slots) || slots.size <= 0) {
        return;
    }
    self.is_active = 1;
    self.var_b79a8ac7 = {#var_f019ea1a:6000, #slots:slots};
    level.attackables[level.attackables.size] = self;
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x330bc658, Offset: 0x7d78
// Size: 0x24
function function_1c0daa38() {
    self.is_active = 0;
    namespace_85745671::function_b70e2a37(self);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x3bb6e22c, Offset: 0x7da8
// Size: 0x6f4
function function_1226c0a6() {
    level flag::wait_till(#"hash_322c7f92525e008e");
    var_ccd37052 = struct::get("steiner_photo_loc", "script_noteworthy");
    var_c257a44 = struct::get("friendly_steiner_absorb_loc_01", "script_noteworthy");
    var_fe76dee7 = struct::get("friendly_steiner_absorb_loc_02", "script_noteworthy");
    var_28a53343 = struct::get("friendly_steiner_absorb_loc_03", "script_noteworthy");
    var_ddfe70e = struct::get("friendly_steiner_face_target_loc_01", "script_noteworthy");
    var_9f3609bc = struct::get("friendly_steiner_face_target_loc_02", "script_noteworthy");
    var_b058ac01 = struct::get("friendly_steiner_face_target_loc_03", "script_noteworthy");
    level flag::clear("spawn_zombies");
    function_b8e662e5(0);
    exploder::kill_exploder("lgt_env_photo_spotlight");
    /#
        iprintlnbold("<dev string:x20c>");
    #/
    wait 3;
    /#
        iprintlnbold("<dev string:x22e>");
    #/
    var_b0eb5e2 = namespace_88795f45::function_f045e7c(var_ccd37052, 0);
    zm_sq::function_266d66eb(#"hash_909766ed99673eb", var_b0eb5e2, 1, #"hash_31c12596d6427df3");
    /#
        iprintlnbold("<dev string:x24f>");
    #/
    wait 3;
    /#
        iprintlnbold("<dev string:x27b>");
    #/
    wait 3;
    /#
        iprintlnbold("<dev string:x2b1>");
    #/
    /#
        iprintlnbold("<dev string:x2e0>");
    #/
    level thread function_a0d2927f();
    level thread function_e59122de();
    level thread function_3e7488f3();
    level flag::clear(#"hash_94bda7ad49639f5");
    if (!level flag::get(#"dark_aether_active")) {
        exploder::kill_exploder("lgt_env_powered_off_room_10");
        exploder::exploder("lgt_env_powered_on_room_10");
    }
    var_b0eb5e2 namespace_88795f45::function_7e855c12(getclosestpointonnavmesh(var_c257a44.origin), "run");
    wait 0.5;
    var_b0eb5e2 namespace_88795f45::function_c6579189(var_ddfe70e);
    var_c257a44 function_9d3a3c54();
    wait 1;
    var_b0eb5e2.ai.var_8c90ae8e = 1;
    var_b0eb5e2.pushable = 0;
    var_b0eb5e2 thread function_be97976d(30, 1);
    level flag::wait_till(#"hash_3a617ab5e651c2a9");
    var_b0eb5e2.ai.var_8c90ae8e = 0;
    zm_powerups::specific_powerup_drop("full_ammo", var_c257a44.origin);
    var_c257a44 function_1c0daa38();
    wait 3;
    var_b0eb5e2 namespace_88795f45::function_7e855c12(getclosestpointonnavmesh(var_fe76dee7.origin), "run");
    wait 0.5;
    var_b0eb5e2 namespace_88795f45::function_c6579189(var_9f3609bc);
    var_9f3609bc function_9d3a3c54();
    wait 1;
    var_b0eb5e2.ai.var_8c90ae8e = 1;
    var_b0eb5e2.pushable = 0;
    var_b0eb5e2 thread function_be97976d(30, 2);
    level flag::wait_till(#"hash_4a49aa778b3cdd8");
    var_b0eb5e2.ai.var_8c90ae8e = 0;
    zm_powerups::specific_powerup_drop("full_ammo", var_fe76dee7.origin);
    var_fe76dee7 function_1c0daa38();
    wait 3;
    var_b0eb5e2 namespace_88795f45::function_7e855c12(getclosestpointonnavmesh(var_28a53343.origin), "run");
    wait 0.5;
    var_b0eb5e2 namespace_88795f45::function_c6579189(var_b058ac01);
    var_b058ac01 function_9d3a3c54();
    wait 1;
    var_b0eb5e2.ai.var_8c90ae8e = 1;
    var_b0eb5e2.pushable = 0;
    var_b0eb5e2 thread function_be97976d(30, 3);
    level flag::wait_till(#"hash_1aab687832f4e02b");
    var_b0eb5e2.ai.var_8c90ae8e = 0;
    zm_powerups::specific_powerup_drop("full_ammo", var_28a53343.origin);
    var_28a53343 function_1c0daa38();
    zm_sq::objective_complete(#"hash_909766ed99673eb", var_b0eb5e2);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb1728f61, Offset: 0x84a8
// Size: 0x280
function function_39f889a2() {
    /#
        iprintlnbold("<dev string:x2f4>");
    #/
    function_b86587a6();
    level flag::set(#"spawn_zombies");
    level flag::set(#"infinite_round_spawning");
    level flag::set(#"pause_round_timeout");
    level thread function_739579e6();
    level thread function_fb092189("power_tunnel_spawner_actived", "zone_proto_start_spawns", "mq_exfil_spawn_trigger_power_tunnel", 10);
    level thread function_fb092189("starting_area_spawner_actived", "zone_proto_interior_lower_spawns", "mq_exfil_spawn_trigger_start_area", 10);
    level thread function_fb092189("ruin_spawner_actived", "zone_proto_roof_center_spawns", "mq_exfil_spawn_trigger_ruin", 10);
    var_45030b70 = getent("mq_extraction_vol", "script_noteworthy");
    while (true) {
        var_f848b220 = 0;
        a_players = getplayers();
        foreach (player in a_players) {
            if (player istouching(var_45030b70)) {
                var_f848b220 += 1;
            }
        }
        if (var_f848b220 >= a_players.size) {
            /#
                iprintlnbold("<dev string:x304>");
            #/
            level flag::set(#"main_quest_completed");
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 3, eflags: 0x1 linked
// Checksum 0xeb23b6a5, Offset: 0x8730
// Size: 0x10c
function function_8d1b6fd8(var_26fccdce, var_db71c2c9, var_89ed1fd9) {
    self endon(#"hash_d215e9a497df471", #"death");
    wait 3;
    var_26fccdce.origin = self.origin;
    self linkto(var_26fccdce);
    var_26fccdce moveto(var_db71c2c9.origin, 4, 1, 0);
    var_26fccdce waittill(#"movedone");
    var_26fccdce moveto(var_89ed1fd9.origin, 4, 0, 1);
    var_26fccdce waittill(#"movedone");
    self flag::set(#"hash_d215e9a497df471");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xaf43bb34, Offset: 0x8848
// Size: 0x1ce
function function_61724ef9() {
    level endon(#"hash_22a4a6dd73981ef1");
    var_135a7960 = 0;
    while (true) {
        players = getplayers();
        foreach (player in players) {
            str_zone = player zm_zonemgr::get_player_zone();
            if (isdefined(str_zone)) {
                if (str_zone == "zone_center_upper" || str_zone == "zone_center_lower" || str_zone == "zone_center_upper_north" || str_zone == "zone_center_upper_west") {
                    var_135a7960 = 1;
                    continue;
                }
                var_135a7960 = 0;
                break;
            }
        }
        if (var_135a7960) {
            var_ccd37052 = struct::get("steiner_photo_loc", "script_noteworthy");
            var_ccd37052 zm_unitrigger::function_fac87205(#"hash_6b426f26dc072fda", 99);
            level flag::set(#"hash_22a4a6dd73981ef1");
        }
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x5 linked
// Checksum 0x6596fd0e, Offset: 0x8a20
// Size: 0x132
function private function_b6a1fe09() {
    var_84e505 = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
    var_3fa8bde0 = [];
    foreach (steiner in var_84e505) {
        if (isalive(steiner) && steiner.team == #"allies") {
            if (!isdefined(var_3fa8bde0)) {
                var_3fa8bde0 = [];
            } else if (!isarray(var_3fa8bde0)) {
                var_3fa8bde0 = array(var_3fa8bde0);
            }
            var_3fa8bde0[var_3fa8bde0.size] = steiner;
        }
    }
    return var_3fa8bde0;
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xf0f9eb49, Offset: 0x8b60
// Size: 0x16c
function function_9951a0d8() {
    self endon(#"disconnect");
    level endon(#"hash_22a4a6dd73981ef1");
    while (true) {
        var_2f39336 = self zm_zonemgr::get_player_zone();
        self waittill(#"zone_change");
        if (is_true(level.var_a760155a.var_2c085075) && (var_2f39336 == "zone_trans_south" && self.cached_zone_name == "zone_center_upper_west" || var_2f39336 == "zone_trans_north" && self.cached_zone_name == "zone_center_upper_north" || var_2f39336 == "zone_power_tunnel" && self.cached_zone_name == "zone_center_upper" || var_2f39336 == "zone_power_tunnel" && self.cached_zone_name == "zone_center_lower") && randomfloat(1) > 0.2) {
            level notify(#"hash_59b1c24ec69056a4");
        }
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x4d018d4c, Offset: 0x8cd8
// Size: 0xfc
function function_abc0783b(var_3e9e754f) {
    var_fe2f597c = getent(var_3e9e754f, "script_noteworthy");
    level.var_a760155a = spawnstruct();
    level.var_a760155a.var_52fca55d = array(#"hash_4bd6300927dd8a3f", #"hash_50b17a7f7e104b9a", #"hash_4bd6300927dd8a3f", #"hash_50b17a7f7e104b9a", #"hash_4bd6300927dd8a3f");
    level.var_a760155a.var_400dbfbb = 0;
    level.var_a760155a.var_2c085075 = 1;
    var_fe2f597c thread function_52a4f924();
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x119f82b2, Offset: 0x8de0
// Size: 0x14e
function function_52a4f924() {
    self endon(#"death");
    level endon(#"hash_22a4a6dd73981ef1", #"death");
    while (true) {
        level waittill(#"hash_59b1c24ec69056a4");
        if (level.var_a760155a.var_400dbfbb < level.var_a760155a.var_52fca55d.size) {
            /#
                iprintlnbold("<dev string:x31a>" + level.var_a760155a.var_400dbfbb);
            #/
            self zm_vo::vo_say(level.var_a760155a.var_52fca55d[level.var_a760155a.var_400dbfbb]);
            level.var_a760155a.var_400dbfbb++;
        } else {
            level.var_a760155a.var_2c085075 = 0;
            break;
        }
        level.var_a760155a.var_2c085075 = 0;
        wait 20;
        level.var_a760155a.var_2c085075 = 1;
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x6855254b, Offset: 0x8f38
// Size: 0xd6
function function_a0d2927f() {
    level endon(#"hash_1aab687832f4e02b");
    while (true) {
        var_69f3d8db = 8 + (getplayers().size - 1) * 4;
        function_1eaaceab(level.var_46a47223);
        if (gettime() >= level.var_c666969c) {
            if (level.var_46a47223.size <= var_69f3d8db) {
                level thread function_57626ffa(1);
                level.var_c666969c = gettime() + 500;
            }
        }
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x41ea7847, Offset: 0x9018
// Size: 0x106
function function_e59122de() {
    level endon(#"hash_6d5f0babef82cff6");
    var_39c83b76 = struct::get("mq_hvt_steiner_spawner", "script_noteworthy");
    var_cd7e3d74 = gettime() + 15000;
    while (true) {
        if (gettime() >= var_cd7e3d74) {
            var_704c79ef = spawnactor(#"hash_acac3fe7a341329", var_39c83b76.origin, var_39c83b76.angles);
            var_704c79ef thread function_106bc9f8();
            var_704c79ef thread function_d76cb937();
            level flag::set(#"hash_6d5f0babef82cff6");
        }
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x4033b88f, Offset: 0x9128
// Size: 0x240
function function_d76cb937() {
    self endon(#"death");
    var_ea78a7cd = self.health;
    var_f7b87e0 = 0;
    while (true) {
        function_1eaaceab(level.var_e6e5751);
        var_f7b87e0 += var_ea78a7cd - self.health;
        if (var_f7b87e0 >= self.maxhealth * 0.1) {
            if (level.var_e6e5751.size < 10) {
                var_93700de7 = spawnactor(#"spawner_zm_steiner_split_radiation_blast", self.origin, self.angles);
                var_7ffcff59 = spawnactor(#"spawner_zm_steiner_split_radiation_bomb", self.origin, self.angles);
                if (!isdefined(level.var_e6e5751)) {
                    level.var_e6e5751 = [];
                } else if (!isarray(level.var_e6e5751)) {
                    level.var_e6e5751 = array(level.var_e6e5751);
                }
                level.var_e6e5751[level.var_e6e5751.size] = var_93700de7;
                if (!isdefined(level.var_e6e5751)) {
                    level.var_e6e5751 = [];
                } else if (!isarray(level.var_e6e5751)) {
                    level.var_e6e5751 = array(level.var_e6e5751);
                }
                level.var_e6e5751[level.var_e6e5751.size] = var_7ffcff59;
                function_25ea253(var_93700de7, var_7ffcff59);
                var_f7b87e0 = 0;
            }
        }
        var_ea78a7cd = self.health;
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x9d8b37b9, Offset: 0x9370
// Size: 0x34
function function_106bc9f8() {
    self endon(#"death");
    function_f7968d5b(30, self);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xf637f894, Offset: 0x93b0
// Size: 0x5c
function function_3e7488f3() {
    level endon(#"hash_1aab687832f4e02b");
    var_39c83b76 = struct::get("mq_hvt_steiner_spawner", "script_noteworthy");
    function_f7968d5b(15, var_39c83b76);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0xdf19019, Offset: 0x9418
// Size: 0x230
function function_f7968d5b(n_interval, spawner) {
    level endon(#"hash_1aab687832f4e02b");
    var_c666969c = gettime() + n_interval * 1000;
    while (true) {
        function_1eaaceab(level.var_e6e5751);
        if (gettime() >= var_c666969c) {
            if (level.var_e6e5751.size < 10) {
                var_93700de7 = spawnactor(#"spawner_zm_steiner_split_radiation_blast", spawner.origin, spawner.angles);
                var_7ffcff59 = spawnactor(#"spawner_zm_steiner_split_radiation_bomb", spawner.origin, spawner.angles);
                if (!isdefined(level.var_e6e5751)) {
                    level.var_e6e5751 = [];
                } else if (!isarray(level.var_e6e5751)) {
                    level.var_e6e5751 = array(level.var_e6e5751);
                }
                level.var_e6e5751[level.var_e6e5751.size] = var_93700de7;
                if (!isdefined(level.var_e6e5751)) {
                    level.var_e6e5751 = [];
                } else if (!isarray(level.var_e6e5751)) {
                    level.var_e6e5751 = array(level.var_e6e5751);
                }
                level.var_e6e5751[level.var_e6e5751.size] = var_7ffcff59;
                function_25ea253(var_93700de7, var_7ffcff59);
                var_c666969c = gettime() + n_interval * 1000;
            }
        }
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0xb31ece75, Offset: 0x9650
// Size: 0x218
function function_25ea253(var_aacbfbf7, var_57ba55cd) {
    arrayremovevalue(level.var_9bca1c1e, undefined, 0);
    if (level.var_9bca1c1e.size == 0) {
        var_aacbfbf7.var_72411ccf = &function_7d583dd;
        var_57ba55cd.var_72411ccf = &function_7d583dd;
        if (!isdefined(level.var_9bca1c1e)) {
            level.var_9bca1c1e = [];
        } else if (!isarray(level.var_9bca1c1e)) {
            level.var_9bca1c1e = array(level.var_9bca1c1e);
        }
        level.var_9bca1c1e[level.var_9bca1c1e.size] = var_aacbfbf7;
        if (!isdefined(level.var_9bca1c1e)) {
            level.var_9bca1c1e = [];
        } else if (!isarray(level.var_9bca1c1e)) {
            level.var_9bca1c1e = array(level.var_9bca1c1e);
        }
        level.var_9bca1c1e[level.var_9bca1c1e.size] = var_57ba55cd;
    }
    if (level.var_9bca1c1e.size == 1) {
        var_aacbfbf7.var_72411ccf = &function_7d583dd;
        if (!isdefined(level.var_9bca1c1e)) {
            level.var_9bca1c1e = [];
        } else if (!isarray(level.var_9bca1c1e)) {
            level.var_9bca1c1e = array(level.var_9bca1c1e);
        }
        level.var_9bca1c1e[level.var_9bca1c1e.size] = var_aacbfbf7;
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb6e1b316, Offset: 0x9870
// Size: 0xb6
function function_739579e6() {
    level endon(#"end_game");
    while (true) {
        if (gettime() >= level.var_c666969c) {
            if (level.var_46a47223.size < 50) {
                level thread function_57626ffa(1);
                level.var_c666969c = gettime() + 1500;
            }
        }
        if (level.var_46a47223.size > 0) {
            arrayremovevalue(level.var_46a47223, undefined, 0);
        }
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x419380b2, Offset: 0x9930
// Size: 0x1cc
function function_be97976d(var_8286522a, var_3f612bdd) {
    switch (var_3f612bdd) {
    case 1:
        level endon(#"hash_3a617ab5e651c2a9");
        break;
    case 2:
        level endon(#"hash_4a49aa778b3cdd8");
        break;
    case 3:
        level endon(#"hash_1aab687832f4e02b");
        break;
    }
    n_duration = var_8286522a * 1000;
    lasttime = gettime();
    while (true) {
        if (self.ai.var_a49798e7) {
        } else {
            n_duration -= gettime() - lasttime;
        }
        lasttime = gettime();
        if (n_duration <= 0) {
            switch (var_3f612bdd) {
            case 1:
                level flag::set(#"hash_3a617ab5e651c2a9");
                break;
            case 2:
                level flag::set(#"hash_4a49aa778b3cdd8");
                break;
            case 3:
                level flag::set(#"hash_1aab687832f4e02b");
                break;
            }
        }
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x8f86bd0f, Offset: 0x9b08
// Size: 0x12c
function function_57626ffa(var_387a5fb6) {
    level endon(#"spawn_done");
    while (var_387a5fb6 > 0) {
        ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], undefined, undefined, 20);
        set_zombie(ai);
        var_387a5fb6 -= 1;
        if (!isdefined(level.var_46a47223)) {
            level.var_46a47223 = [];
        } else if (!isarray(level.var_46a47223)) {
            level.var_46a47223 = array(level.var_46a47223);
        }
        level.var_46a47223[level.var_46a47223.size] = ai;
        wait 0.3;
    }
    level flag::set(#"spawn_done");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x0
// Checksum 0x9fb84, Offset: 0x9c40
// Size: 0xdc
function function_5ee4cff0() {
    a_players = getplayers();
    var_bf48e9e2 = function_b6a1fe09();
    a_targets = arraycombine(a_players, var_bf48e9e2);
    self.favoriteenemy = arraygetclosest(self.origin, a_targets);
    if (isdefined(self.favoriteenemy)) {
        self zm_utility::function_64259898(self.favoriteenemy.origin, 128);
        return;
    }
    self setgoal(self.origin);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x1ab1c057, Offset: 0x9d28
// Size: 0x2e
function function_7d583dd() {
    var_bf48e9e2 = function_b6a1fe09();
    self.favoriteenemy = var_bf48e9e2[0];
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x95ff5d3c, Offset: 0x9d60
// Size: 0x140
function function_a1bf0a43() {
    level endon(#"end_game", #"hash_1b2a9d1d0a0cf16b");
    var_f2484ed9 = util::spawn_model("tag_origin", self.origin);
    while (true) {
        var_f2484ed9 clientfield::set("" + #"hash_7ec80a02e9bb051a", 1);
        var_f2484ed9 function_19986231();
        var_f2484ed9 zm_unitrigger::function_fac87205(#"hash_622731cfc9a72bfa", 96);
        var_f2484ed9 clientfield::set("" + #"hash_7ec80a02e9bb051a", 0);
        level notify(#"into_the_dark_side");
        level waittill(#"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xbad1b355, Offset: 0x9ea8
// Size: 0x1b4
function function_b771ea49() {
    var_bc71f81d = struct::get("photo_echo", "script_noteworthy");
    while (true) {
        level waittill(#"into_the_dark_side");
        var_cbd423bc = util::spawn_model("tag_origin", var_bc71f81d.origin);
        var_cbd423bc thread function_de34115();
        var_2943b0b6 = getent("dark_echo_trig", "script_noteworthy");
        var_2943b0b6.origin = var_cbd423bc.origin;
        var_2943b0b6 function_7b82152b();
        var_2943b0b6 setinvisibletoall();
        var_cbd423bc clientfield::set("" + #"hash_8358a32177aa60e", 0);
        if (level.var_ba3a0e1f > 0) {
            var_cbd423bc flag::set("orb_is_deciphered");
            level.var_ba3a0e1f += 60;
            level scene::play("aib_t9_zm_silver_echo_5_orlov_01");
            level flag::set(#"hash_1b2a9d1d0a0cf16b");
            break;
        }
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 3, eflags: 0x1 linked
// Checksum 0xe195ab2a, Offset: 0xa068
// Size: 0x14c
function function_34a1157d(var_3b3f5ecb, var_c30fa3c6, var_7928fb3d) {
    level endon(var_7928fb3d);
    a_players = getplayers();
    while (true) {
        level flag::wait_till(#"dark_aether_active");
        foreach (player in a_players) {
            player thread function_1ea8dfd1(var_3b3f5ecb, var_c30fa3c6, "stop_watching_echo_zones");
        }
        level flag::wait_till_clear(#"dark_aether_active");
        level scene::delete_scene_spawned_ents(var_3b3f5ecb);
        level notify(#"stop_watching_echo_zones");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 3, eflags: 0x1 linked
// Checksum 0x3f07bd36, Offset: 0xa1c0
// Size: 0xa0
function function_1ea8dfd1(var_3b3f5ecb, var_c30fa3c6, var_7928fb3d) {
    if (isdefined(self)) {
        level endon(var_7928fb3d);
        self endon(#"disconnect");
        while (true) {
            self waittill(#"zone_change");
            str_zone = self zm_zonemgr::get_player_zone();
            if (str_zone == var_c30fa3c6) {
                level scene::play(var_3b3f5ecb);
            }
        }
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xe4745d12, Offset: 0xa268
// Size: 0xac
function function_21b1ba52(*a_ents) {
    level scene::delete_scene_spawned_ents("aib_t9_zm_silver_secretecho_2_lastsoldier_01");
    level scene::delete_scene_spawned_ents("aib_t9_zm_silver_secretecho_1_kurtzandvogel_01");
    level scene::delete_scene_spawned_ents("aib_t9_zm_silver_secretecho_3_dmitriyev_kalashnik_01_throw");
    level scene::delete_scene_spawned_ents("aib_t9_zm_silver_secretecho_5_valentinaandpeck");
    level scene::delete_scene_spawned_ents("aib_t9_zm_silver_echo_5_orlov_01");
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x2888f338, Offset: 0xa320
// Size: 0x286
function function_b8e662e5(var_c76bbbcc) {
    level.zones[#"zone_proto_start"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_proto_start2"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_proto_upstairs"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_proto_roof_plane"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_proto_interior_cave"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_proto_interior_lower"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_proto_upstairs_2"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_proto_roof_center"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_proto_plane_exterior"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_proto_exterior_rear2"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_tunnel_interior"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_power_room"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_power_trans_north"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_trans_north"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_power_trans_south"].is_spawning_allowed = var_c76bbbcc;
    level.zones[#"zone_trans_south"].is_spawning_allowed = var_c76bbbcc;
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xf1e0f038, Offset: 0xa5b0
// Size: 0x36e
function function_b86587a6() {
    level.zones[#"zone_proto_start"].is_spawning_allowed = 1;
    level.zones[#"zone_proto_start2"].is_spawning_allowed = 1;
    level.zones[#"zone_proto_upstairs"].is_spawning_allowed = 1;
    level.zones[#"zone_proto_interior_cave"].is_spawning_allowed = 1;
    level.zones[#"zone_proto_interior_lower"].is_spawning_allowed = 1;
    level.zones[#"zone_proto_upstairs_2"].is_spawning_allowed = 1;
    level.zones[#"zone_proto_roof_center"].is_spawning_allowed = 1;
    level.zones[#"zone_proto_roof_plane"].is_spawning_allowed = 1;
    level.zones[#"zone_proto_plane_exterior"].is_spawning_allowed = 1;
    level.zones[#"zone_proto_plane_exterior2"].is_spawning_allowed = 1;
    level.zones[#"zone_proto_exterior_rear"].is_spawning_allowed = 1;
    level.zones[#"zone_proto_exterior_rear2"].is_spawning_allowed = 1;
    level.zones[#"zone_tunnel_interior"].is_spawning_allowed = 1;
    level.zones[#"zone_power_room"].is_spawning_allowed = 1;
    level.zones[#"zone_power_trans_north"].is_spawning_allowed = 1;
    level.zones[#"zone_trans_north"].is_spawning_allowed = 1;
    level.zones[#"zone_power_trans_south"].is_spawning_allowed = 1;
    level.zones[#"zone_trans_south"].is_spawning_allowed = 1;
    level.zones[#"zone_center_upper_west"].is_spawning_allowed = 1;
    level.zones[#"zone_center_upper_north"].is_spawning_allowed = 1;
    level.zones[#"zone_center_upper"].is_spawning_allowed = 1;
    level.zones[#"zone_center_lower"].is_spawning_allowed = 1;
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 1, eflags: 0x5 linked
// Checksum 0x22b480fc, Offset: 0xa928
// Size: 0x6e
function private set_zombie(e_zombie) {
    if (isdefined(e_zombie)) {
        e_zombie.var_126d7bef = 1;
        e_zombie.ignore_round_spawn_failsafe = 1;
        e_zombie.b_ignore_cleanup = 1;
        e_zombie.ignore_enemy_count = 1;
        e_zombie.no_powerups = 1;
        if (e_zombie.health < 2000) {
            e_zombie.health = 2000;
        }
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 4, eflags: 0x1 linked
// Checksum 0x17742cc5, Offset: 0xa9a0
// Size: 0x1fa
function function_fb092189(var_426f34de, var_e5eba4b1, str_trigger_name, var_cad90ac0) {
    level endon(var_426f34de, #"end_game");
    var_33507048 = struct::get(str_trigger_name, "script_noteworthy");
    a_spawn_locs = struct::get_array(var_e5eba4b1, "targetname");
    while (true) {
        a_players = getplayers();
        foreach (player in a_players) {
            if (distancesquared(player.origin, var_33507048.origin) <= 62500) {
                while (var_cad90ac0 > 0) {
                    ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], undefined, array::random(a_spawn_locs), 20);
                    set_zombie(ai);
                    var_cad90ac0 -= 1;
                    wait 0.1;
                }
                level flag::set(var_426f34de);
            }
        }
        waitframe(1);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xda9f67c6, Offset: 0xaba8
// Size: 0xfc
function function_19986231() {
    if (!self flag::get(#"hash_7a42d508140ae262")) {
        foreach (player in getplayers()) {
            player clientfield::set_to_player("" + #"hash_1fa45e1c3652d753", 1);
        }
    }
    self flag::set(#"hash_7a42d508140ae262");
}

