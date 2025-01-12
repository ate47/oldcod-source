#using script_43bba08258745838;
#using script_681abc4248c2bc7d;
#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_lockdown_util;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_sq_modules;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace namespace_d17fd4ae;

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x0
// Checksum 0x70fa2e49, Offset: 0x2a8
// Size: 0x68c
function init() {
    level.a_s_chests = struct::get_array(#"hash_396f65af88a25e7d");
    foreach (s_chest in level.a_s_chests) {
        s_chest chest_init();
        zm_sq_modules::function_8ab612a3(s_chest.script_noteworthy, 1, s_chest, &function_1ce0ded1, &function_f4718d55);
    }
    level.heldconcentratetext = zm_zod_wonderweapon_quest::register("heldConcentrateText");
    if (zm_custom::function_5638f689(#"zmwonderweaponisenabled")) {
        zm_sq::register(#"hash_1222a3e832bad772", #"hash_2725edd09b4bb1b6", #"hash_13b316981d67e1ad", &step_1_setup, &step_1_cleanup);
        zm_sq::register(#"hash_1222a3e832bad772", #"hash_6cc4f52e0ed36f92", #"hash_13b313981d67dc94", &step_2_setup, &step_2_cleanup);
        zm_sq::register(#"hash_1222a3e832bad772", #"hash_575b4d3faca8bf2e", #"hash_13b314981d67de47", &step_3_setup, &step_3_cleanup);
        zm_sq::register(#"hash_1222a3e832bad772", #"hash_1d89a5560669ab60", #"hash_13b311981d67d92e", &step_4_setup, &step_4_cleanup);
        level flag::init(#"hash_1562cc6d96b2bc4");
        level flag::init(#"hash_635fa9d7a8be6607");
        level flag::init(#"hash_2889330d50a4cc38");
        level flag::init(#"hash_35ab49975b4cc894");
        level flag::init(#"hash_477e8ec5d0789334");
        level.w_tricannon_base = getweapon(#"ww_tricannon_t8");
        namespace_96796d10::function_60c07221(level.w_tricannon_base);
        callback::on_spawned(&function_54a16649);
        zm_weapons::include_zombie_weapon(#"hash_41a492d8cc5893f9", 0);
        zm_weapons::add_zombie_weapon(#"hash_41a492d8cc5893f9", "", "", 0, undefined, undefined, 0, "", 0, 0, "");
        level.n_kill_count = 0;
        level.var_11365f10 = array(#"hash_10d96c6e67b7604d", #"p7_compass_vintage", #"p7_world_globe_vintage_01", #"p7_ra2_tool_vintage_pincer_02", #"p7_zm_ori_scope_vintage");
        level.var_67ddbc99 = array(#"hash_6750f91495cec97a", #"hash_5cfcc1e6699e46b6", #"hash_6e6d2b3030f3d6c6", #"hash_6382fc1f3035ccb0", #"hash_76274c14299e46ca");
        level.var_dcc30708 = randomint(level.a_s_chests.size);
        level.var_4b8a9db3 = level.a_s_chests[level.var_dcc30708];
        level.var_4b8a9db3 show_chest();
        level thread function_2d2cc7ab();
        w_blueprint = zm_crafting::function_ad17f25(#"zblueprint_zod_tricannon_upgrade");
        if (isdefined(w_blueprint)) {
            w_blueprint.var_8c31a577.var_cbf7a606 = #"hash_4223e614aaaeb5be";
            w_blueprint.var_1a2a363c.var_cbf7a606 = #"condenser_coil";
            w_blueprint.var_402cb0a5.var_cbf7a606 = #"hash_d2d731e2804301b";
        }
    }
    clientfield::register("scriptmover", "" + #"clue_fx", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"despawn_fx", 1, 1, "int");
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0x6c92ca87, Offset: 0x940
// Size: 0x52
function private chest_init() {
    self.var_a0abc709 = getent(self.target, "targetname");
    self.s_chest = struct::get(self.target, "targetname");
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0xb06ce38c, Offset: 0x9a0
// Size: 0x104
function private function_2d2cc7ab() {
    level waittill(#"all_players_spawned");
    a_e_players = getplayers();
    for (i = 0; i < a_e_players.size; i++) {
        level.var_1ee22144[i] = 0;
        a_e_players[i] thread function_9cf2b185();
    }
    callback::on_connect(&function_9cf2b185);
    zm_crafting::function_80bf4df3(#"zblueprint_zod_tricannon_upgrade", &function_3f903b89);
    zm_sq::start(#"hash_1222a3e832bad772", 1);
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0xb1e76522, Offset: 0xab0
// Size: 0x64
function private step_1_setup(var_4df52d26) {
    level endon(#"end_game");
    if (!var_4df52d26) {
        callback::on_ai_spawned(&function_39af32e1);
        level waittill(#"hash_1562cc6d96b2bc4");
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 2, eflags: 0x4
// Checksum 0x8a6aab4c, Offset: 0xb20
// Size: 0xcc
function private step_1_cleanup(var_4df52d26, var_c86ff890) {
    if (!var_4df52d26) {
        callback::remove_on_ai_spawned(&function_39af32e1);
        if (var_c86ff890) {
            if (isdefined(level.var_ae97e2b3)) {
                level.var_ae97e2b3 delete();
                level.var_a5a0de80 delete();
            }
            level flag::set(#"hash_1562cc6d96b2bc4");
        }
        return;
    }
    level flag::set(#"hash_1562cc6d96b2bc4");
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0x378863c5, Offset: 0xbf8
// Size: 0x254
function private function_39af32e1() {
    level endon(#"hash_1562cc6d96b2bc4", #"end_game");
    if (self.archetype == #"stoker") {
        waitresult = self waittill(#"hash_4651621237a54fc7", #"death");
        if (waitresult._notify == #"hash_4651621237a54fc7") {
            if (!isdefined(level.var_ae97e2b3)) {
                level.var_ae97e2b3 = util::spawn_model(#"p8_zm_kraken_chest_key", self.origin + (0, 0, 32), self.angles);
                level.var_ae97e2b3 playsound(#"hash_1390af6222266716");
                level.var_ae97e2b3 playloopsound(#"hash_1f450c20e20a55c5", 2);
                level.var_a5a0de80 = spawn("trigger_radius_use", level.var_ae97e2b3.origin, 0, 72, 72);
                level.var_a5a0de80 setcursorhint("HINT_NOICON");
                level.var_a5a0de80 sethintstring(#"hash_6b3d148fe21d6acd");
                level.var_a5a0de80 triggerignoreteam();
                level.var_a5a0de80 setvisibletoall();
                level thread function_8123e3cb();
                level thread function_4582e41b();
            }
        }
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0xb0f8a433, Offset: 0xe58
// Size: 0x144
function private function_8123e3cb() {
    level endon(#"hash_503e8bfd27a38f08", #"hash_1562cc6d96b2bc4", #"end_game");
    waitresult = level.var_a5a0de80 waittill(#"trigger");
    player = waitresult.activator;
    if (isdefined(player)) {
        player playsound(#"hash_1560d47a810c72df");
        player util::delay(0.5, "death", &zm_audio::create_and_play_dialog, #"stoker_key", #"pick_up");
    }
    level.var_a5a0de80 delete();
    level.var_ae97e2b3 delete();
    level flag::set(#"hash_1562cc6d96b2bc4");
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0x527d7327, Offset: 0xfa8
// Size: 0x120
function private function_4582e41b() {
    level endon(#"hash_1562cc6d96b2bc4", #"hash_1562cc6d96b2bc4", #"end_game");
    level.var_ae97e2b3 rotate((0, 360, 0));
    wait 15;
    level.var_ae97e2b3 zm_powerups::hide_and_show(&ghost, &show);
    level.var_ae97e2b3 playsound(#"hash_5a2daa895f64b2e2");
    level.var_a5a0de80 delete();
    level.var_ae97e2b3 delete();
    level notify(#"hash_503e8bfd27a38f08");
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0x65eb259c, Offset: 0x10d0
// Size: 0xbc
function private step_2_setup(var_4df52d26) {
    level endon(#"end_game");
    if (!var_4df52d26) {
        e_activator = level.var_4b8a9db3 zm_unitrigger::function_b7e350e6(#"hash_14651a427e1b9f98", (64, 48, 72));
        if (isalive(e_activator)) {
            e_activator zm_audio::create_and_play_dialog(#"treasure_chest", #"activate_1");
        }
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 2, eflags: 0x4
// Checksum 0x183c0039, Offset: 0x1198
// Size: 0x104
function private step_2_cleanup(var_4df52d26, var_c86ff890) {
    if (!var_4df52d26) {
        zm_unitrigger::unregister_unitrigger(level.var_4b8a9db3.s_unitrigger);
    }
    level.var_4b8a9db3.mdl_chest thread scene::play("p8_fxanim_zm_zod_kraken_chest_bundle", "open", level.var_4b8a9db3.mdl_chest);
    level.var_4b8a9db3.mdl_chest playsound(#"hash_6fa6fc673cdcf645");
    level.var_4b8a9db3.mdl_chest playloopsound(#"hash_326fef81e2be51bb", 2);
    level flag::set(#"hash_635fa9d7a8be6607");
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0x93e59b7f, Offset: 0x12a8
// Size: 0x2f4
function private step_3_setup(var_4df52d26) {
    level endon(#"end_game");
    if (!var_4df52d26) {
        level.var_5fb920d9 = 0;
        while (level.var_5fb920d9 < 3) {
            function_75c7018d();
            zm_sq_modules::function_b4f7eda8(level.var_4b8a9db3.script_noteworthy);
            level waittill(#"hash_17332cf9062484a6");
            zm_sq_modules::function_c39c525(level.var_4b8a9db3.script_noteworthy);
            wait 1;
            level.var_4b8a9db3.mdl_chest stoploopsound(1);
            level.var_4b8a9db3.mdl_chest thread scene::play("p8_fxanim_zm_zod_kraken_chest_bundle", "close", level.var_4b8a9db3.mdl_chest);
            wait 3;
            playfx(#"hash_6c0eb029adb5f6c6", level.var_4b8a9db3.mdl_chest.origin);
            if (level.var_5fb920d9 < 2) {
                level.var_4b8a9db3.mdl_chest delete();
                arrayremoveindex(level.a_s_chests, level.var_dcc30708);
                level.var_dcc30708 = randomint(level.a_s_chests.size);
                level.var_4b8a9db3 = level.a_s_chests[level.var_dcc30708];
                level.var_4b8a9db3 show_chest();
                level.var_4b8a9db3.mdl_chest thread scene::play("p8_fxanim_zm_zod_kraken_chest_bundle", "open", level.var_4b8a9db3.mdl_chest);
                level.var_4b8a9db3.mdl_chest playsound(#"hash_6fa6fc673cdcf645");
                level.var_4b8a9db3.mdl_chest playloopsound(#"hash_326fef81e2be51bb", 2);
                /#
                    iprintlnbold("<dev string:x30>");
                #/
            }
            level.var_5fb920d9++;
        }
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 2, eflags: 0x4
// Checksum 0x8210e24e, Offset: 0x15a8
// Size: 0x1b0
function private step_3_cleanup(var_4df52d26, var_c86ff890) {
    if (var_c86ff890) {
        zm_sq_modules::function_c39c525(level.var_4b8a9db3.script_noteworthy);
    }
    level.var_20a97c18 = randomint(level.var_67ddbc99.size);
    level.var_885e56a2 = struct::get(level.var_67ddbc99[level.var_20a97c18]);
    level.var_4b8a9db3 thread function_5dd20a99();
    /#
        iprintlnbold("<dev string:x4e>");
    #/
    var_ce3920 = getentarray("kraken_cleanup", "script_noteworthy");
    var_bd6c4218 = getent(level.var_885e56a2.target, "targetname");
    foreach (ent in var_ce3920) {
        if (ent !== var_bd6c4218) {
            ent delete();
        }
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0xfe8fb6de, Offset: 0x1760
// Size: 0x142
function private function_75c7018d() {
    a_e_players = getplayers();
    switch (a_e_players.size) {
    case 1:
        level.var_77ad5f2a = 10;
        level.var_553c5aea = 20;
        level.var_c34c2f3 = 30;
        break;
    case 2:
        level.var_77ad5f2a = 11;
        level.var_553c5aea = 22;
        level.var_c34c2f3 = 33;
        break;
    case 3:
        level.var_77ad5f2a = 13;
        level.var_553c5aea = 26;
        level.var_c34c2f3 = 40;
        break;
    case 4:
        level.var_77ad5f2a = 15;
        level.var_553c5aea = 31;
        level.var_c34c2f3 = 46;
        break;
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 2, eflags: 0x4
// Checksum 0x397dfd62, Offset: 0x18b0
// Size: 0x44
function private function_1ce0ded1(s_struct, ai_killed) {
    if (ai_killed istouching(s_struct.var_a0abc709)) {
        return 1;
    }
    return 0;
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 2, eflags: 0x4
// Checksum 0x52d49431, Offset: 0x1900
// Size: 0x23a
function private function_f4718d55(s_struct, ai_killed) {
    level.n_kill_count++;
    if (level.var_5fb920d9 == 0 && level.n_kill_count >= level.var_77ad5f2a || level.var_5fb920d9 == 1 && level.n_kill_count >= level.var_553c5aea || level.var_5fb920d9 == 2 && level.n_kill_count >= level.var_c34c2f3) {
        level.n_kill_count = 0;
        level notify(#"hash_17332cf9062484a6");
    }
    if (!(isdefined(level.var_4b8a9db3.b_vo_played) && level.var_4b8a9db3.b_vo_played)) {
        if (level.var_5fb920d9 == 1) {
            var_41750e29 = #"activate_2";
        } else if (level.var_5fb920d9 == 2) {
            var_41750e29 = #"activate_3";
        } else {
            return;
        }
        foreach (player in util::get_array_of_closest(level.var_4b8a9db3.origin, util::get_active_players(), undefined, undefined, 512)) {
            b_result = player zm_audio::create_and_play_dialog(#"treasure_chest", var_41750e29);
            if (b_result) {
                level.var_4b8a9db3.b_vo_played = 1;
                break;
            }
        }
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0x7a021176, Offset: 0x1b48
// Size: 0x84
function private step_4_setup(var_4df52d26) {
    level endon(#"end_game");
    if (!var_4df52d26) {
        trigger::wait_till(level.var_885e56a2.target);
        getent(level.var_885e56a2.target, "targetname") delete();
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 2, eflags: 0x4
// Checksum 0x95abf496, Offset: 0x1bd8
// Size: 0x14c
function private step_4_cleanup(var_4df52d26, var_c86ff890) {
    scene::add_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &spawn_tricannon);
    scene::add_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &function_30e68240, "done");
    level scene::play(level.var_885e56a2.target, "targetname");
    scene::remove_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &spawn_tricannon);
    zm_weapons::function_55d25350(level.w_tricannon_base);
    level clientfield::set("" + #"hash_16cc25b3f87f06ad", 1);
    level flag::set(#"hash_35ab49975b4cc894");
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x0
// Checksum 0x84564799, Offset: 0x1d30
// Size: 0x8c
function function_30e68240(a_ents) {
    wait 5;
    if (isdefined(a_ents[#"kraken_tentacle"])) {
        a_ents[#"kraken_tentacle"] delete();
    }
    scene::remove_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &function_30e68240, "done");
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0x571a8900, Offset: 0x1dc8
// Size: 0x28c
function private function_5dd20a99() {
    level endon(#"end_game");
    self.mdl_chest thread scene::play("p8_fxanim_zm_zod_kraken_chest_bundle", "close", self.mdl_chest);
    wait 3;
    v_offset = anglestoup(self.mdl_chest.angles) * 26;
    var_794adbd = util::spawn_model(level.var_11365f10[level.var_20a97c18], self.mdl_chest.origin + v_offset, self.mdl_chest.angles);
    if (level.var_11365f10[level.var_20a97c18] == #"p7_compass_vintage") {
        var_794adbd setscale(2);
    }
    var_794adbd rotate((0, 22, 0));
    var_794adbd clientfield::set("" + #"clue_fx", 1);
    self.mdl_chest thread scene::play("p8_fxanim_zm_zod_kraken_chest_bundle", "open", self.mdl_chest);
    level flag::wait_till(#"hash_2889330d50a4cc38");
    self.mdl_chest thread scene::play("p8_fxanim_zm_zod_kraken_chest_bundle", "close", self.mdl_chest);
    wait 3;
    playfx(#"hash_6c0eb029adb5f6c6", level.var_4b8a9db3.mdl_chest.origin);
    var_794adbd delete();
    self.mdl_chest delete();
    self struct::delete();
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0x80377e29, Offset: 0x2060
// Size: 0x1e4
function private spawn_tricannon(a_ents) {
    if (self.targetname !== #"offering_scene") {
        exploder::exploder(level.var_885e56a2.str_exploder);
        mdl_tricannon = a_ents[#"hash_3712f07fe0e1166c"];
        mdl_tricannon clientfield::set("" + #"despawn_fx", 1);
        mdl_tricannon waittill(#"kraken_dropped");
        mdl_tricannon playsound(#"hash_70efc268d0becb47");
        mdl_tricannon playloopsound(#"hash_61486fb02b77eed8", 2);
        s_unitrigger = level.var_885e56a2 zm_unitrigger::create(&function_f01981d, (64, 64, 72), &function_e0e67511);
        level waittill(#"hash_2889330d50a4cc38");
        exploder::stop_exploder(level.var_885e56a2.str_exploder);
        zm_unitrigger::unregister_unitrigger(s_unitrigger);
        mdl_tricannon stoploopsound(0.5);
        mdl_tricannon delete();
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0xafec37af, Offset: 0x2250
// Size: 0xc8
function private function_f01981d(e_player) {
    level endon(#"hash_2889330d50a4cc38", #"end_game");
    if (function_cd32f495(e_player)) {
        self setvisibletoplayer(e_player);
        self setcursorhint("HINT_WEAPON", level.w_tricannon_base);
        self sethintstring(#"hash_6a4c5538a960189d");
        return 1;
    }
    self setinvisibletoplayer(e_player);
    return 0;
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0xd2926d64, Offset: 0x2320
// Size: 0xfc
function private function_e0e67511() {
    level endon(#"end_game", #"hash_2889330d50a4cc38");
    self endon(#"kill_trigger");
    for (waitresult = self waittill(#"trigger"); !function_3c0c90a2(waitresult); waitresult = self waittill(#"trigger")) {
    }
    if (!level flag::get(#"hash_2889330d50a4cc38")) {
        waitresult.activator giveweapon(level.w_tricannon_base);
        level flag::set(#"hash_2889330d50a4cc38");
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0xac8326b0, Offset: 0x2428
// Size: 0x3a
function private function_3c0c90a2(waitresult) {
    if (function_cd32f495(waitresult.activator)) {
        return 1;
    }
    waitframe(1);
    return 0;
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0xb9abce1b, Offset: 0x2470
// Size: 0x76
function private function_cd32f495(e_player) {
    if (!zm_utility::is_player_valid(e_player, 0, 1) || !zm_utility::can_use(e_player, 1) || e_player has_tricannon()) {
        return 0;
    }
    return 1;
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0x9b15e89b, Offset: 0x24f0
// Size: 0x10c
function private function_9cf2b185() {
    level endon(#"end_game", #"hash_477e8ec5d0789334");
    self endon(#"disconnect");
    for (waitresult = self waittill(#"weapon_change"); waitresult.weapon != level.w_tricannon_base; waitresult = self waittill(#"weapon_change")) {
    }
    if (!isdefined(level.var_e9c490e2)) {
        level.var_e9c490e2 = 0;
    }
    callback::on_ai_killed(&function_3f679bfc);
    callback::remove_on_connect(&function_9cf2b185);
    level flag::set(#"hash_477e8ec5d0789334");
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x0
// Checksum 0xbc6d54d5, Offset: 0x2608
// Size: 0x11c
function function_3f903b89(e_player) {
    if (isalive(e_player)) {
        e_player zm_audio::create_and_play_dialog(#"distillation_kit", #"build");
    }
    s_table = struct::get(#"hash_6b46b9c1dd7e1bb");
    s_unitrigger = s_table zm_unitrigger::create(&function_6eef11bd, 64, &function_32c96ebf, 1);
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
    zm_lockdown_util::function_bdb49bee(s_unitrigger, "lockdown_stub_type_crafting_tables");
    level thread zm_crafting::function_4b55c808(#"zblueprint_zod_tricannon_upgrade");
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0xdeb4917d, Offset: 0x2730
// Size: 0x538
function private function_6eef11bd(e_player) {
    var_3fcce807 = e_player function_3217eb4c();
    if (e_player zm_utility::is_player_looking_at(self.origin, 0.5, 0) && isdefined(e_player.var_1abc4f35) && e_player.var_1abc4f35 != "" && isdefined(var_3fcce807)) {
        n_cost = function_e4fef621(var_3fcce807);
        switch (e_player.var_1abc4f35) {
        case #"decay":
            if (var_3fcce807.name == #"ww_tricannon_earth_t8" || var_3fcce807.name == #"ww_tricannon_earth_t8_upgraded") {
                if (zm_utility::is_standard()) {
                    self sethintstring(#"hash_7a93670a32eaa8cf");
                } else {
                    self sethintstring(#"hash_523a7a63472e8204", n_cost);
                }
            } else if (zm_utility::is_standard()) {
                self sethintstring(#"hash_46ac72784c5bf3f8");
            } else {
                self sethintstring(#"hash_353f3ec1f4fa0109", n_cost);
            }
            break;
        case #"plasma":
            if (var_3fcce807.name == #"ww_tricannon_fire_t8" || var_3fcce807.name == #"ww_tricannon_fire_t8_upgraded") {
                if (zm_utility::is_standard()) {
                    self sethintstring(#"hash_2b3bb217a51771eb");
                } else {
                    self sethintstring(#"hash_eb05b70f6927e88", n_cost);
                }
            } else if (zm_utility::is_standard()) {
                self sethintstring(#"hash_537338a5d8fb2aea");
            } else {
                self sethintstring(#"hash_739ddf7e1e7126a3", n_cost);
            }
            break;
        case #"purity":
            if (var_3fcce807.name == #"ww_tricannon_water_t8" || var_3fcce807.name == #"ww_tricannon_water_t8_upgraded") {
                if (zm_utility::is_standard()) {
                    self sethintstring(#"hash_1d35ea46da22acaa");
                } else {
                    self sethintstring(#"hash_34dfed25a796d563", n_cost);
                }
            } else if (zm_utility::is_standard()) {
                self sethintstring(#"hash_7217a104b05f83df");
            } else {
                self sethintstring(#"hash_126fd9abaad51c74", n_cost);
            }
            break;
        case #"radiance":
            if (var_3fcce807.name == #"ww_tricannon_air_t8" || var_3fcce807.name == #"ww_tricannon_air_t8_upgraded") {
                if (zm_utility::is_standard()) {
                    self sethintstring(#"hash_2b4ea12debb30fda");
                } else {
                    self sethintstring(#"hash_7028ec2236ab3e73", n_cost);
                }
            } else if (zm_utility::is_standard()) {
                self sethintstring(#"hash_3427b86de4fb527b");
            } else {
                self sethintstring(#"hash_3576a4d9b2baf4b8", n_cost);
            }
            break;
        }
        return 1;
    }
    self sethintstring("");
    return 0;
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0x6836a171, Offset: 0x2c70
// Size: 0x36
function private function_e4fef621(var_3fcce807) {
    if (function_9c2d5c41(var_3fcce807)) {
        return 6000;
    }
    return 3000;
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x0
// Checksum 0x47b941c0, Offset: 0x2cb0
// Size: 0x108
function function_32c96ebf() {
    level endon(#"end_game");
    while (true) {
        waitresult = self waittill(#"trigger");
        user = waitresult.activator;
        if (!zm_utility::can_use(user)) {
            continue;
        }
        if (!zm_utility::is_player_valid(user)) {
            continue;
        }
        n_cost = function_e4fef621(user function_3217eb4c());
        if (user zm_score::can_player_purchase(n_cost)) {
            level thread function_e0a073e7(user);
            user zm_score::minus_to_player_score(n_cost);
        }
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0xc01a271d, Offset: 0x2dc0
// Size: 0x26e
function private function_e0a073e7(e_player) {
    var_3fcce807 = e_player function_3217eb4c();
    if (isdefined(var_3fcce807)) {
        e_player takeweapon(var_3fcce807);
        switch (e_player.var_1abc4f35) {
        case #"decay":
            var_971b0dae = #"ww_tricannon_earth_t8";
            var_9961de7a = 2;
            break;
        case #"plasma":
            var_971b0dae = #"ww_tricannon_fire_t8";
            var_9961de7a = 3;
            break;
        case #"purity":
            var_971b0dae = #"ww_tricannon_water_t8";
            var_9961de7a = 1;
            break;
        case #"radiance":
            var_971b0dae = #"ww_tricannon_air_t8";
            var_9961de7a = 4;
            break;
        default:
            assert(0, "<dev string:x6c>");
            var_971b0dae = #"ww_tricannon_t8";
            break;
        }
        if (function_9c2d5c41(var_3fcce807)) {
            var_971b0dae += "_upgraded";
        }
        w_weapon = getweapon(var_971b0dae);
        e_player giveweapon(w_weapon);
        e_player function_54a16649();
        if (!isdefined(e_player.var_eed271c5)) {
            e_player.var_eed271c5 = [];
        } else if (!isarray(e_player.var_eed271c5)) {
            e_player.var_eed271c5 = array(e_player.var_eed271c5);
        }
        e_player.var_eed271c5[w_weapon] = var_9961de7a;
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0x2cf999a2, Offset: 0x3038
// Size: 0x20a
function private function_3f679bfc(params) {
    level endon(#"end_game");
    if (self.archetype == #"catalyst") {
        if (is_tricannon(params.weapon)) {
            if (level.var_e9c490e2 < 4 && randomint(100) <= 50) {
                level.var_e9c490e2++;
                switch (self.catalyst_type) {
                case 1:
                    level function_95657a2d(#"concentrated_decay", self.origin, self getcentroid());
                    break;
                case 3:
                    level function_95657a2d(#"concentrated_radiance", self.origin, self getcentroid());
                    break;
                case 2:
                    level function_95657a2d(#"concentrated_plasma", self.origin, self getcentroid());
                    break;
                case 4:
                    level function_95657a2d(#"concentrated_purity", self.origin, self getcentroid());
                    break;
                default:
                    break;
                }
            }
        }
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 3, eflags: 0x4
// Checksum 0xb42e561d, Offset: 0x3250
// Size: 0x2e4
function private function_95657a2d(str_drop, v_origin, v_spawn) {
    var_e9329c3d = util::spawn_model("tag_origin", v_spawn);
    var_e9329c3d notsolid();
    var_bc40b600 = spawn("trigger_radius_use", v_origin + (0, 0, 32), 0, 64, 72);
    var_bc40b600 setcursorhint("HINT_NOICON");
    switch (str_drop) {
    case #"concentrated_decay":
        var_bc40b600 sethintstring(#"hash_1fe854f6441b337e");
        var_e9329c3d setmodel("c_t8_zmb_concentrated_catalyst_heart");
        v_origin += (0, 0, 5);
        break;
    case #"concentrated_plasma":
        var_bc40b600 sethintstring(#"hash_1da4ec6fc5b6b9e6");
        var_e9329c3d setmodel("c_t8_zmb_concentrated_catalyst_skull");
        break;
    case #"concentrated_purity":
        var_bc40b600 sethintstring(#"hash_7ee0d1946efa3d21");
        var_e9329c3d setmodel("c_t8_zmb_concentrated_catalyst_foot");
        break;
    case #"concentrated_radiance":
        var_bc40b600 sethintstring(#"hash_1b1948d30c6b8ec9");
        var_e9329c3d setmodel("c_t8_zmb_concentrated_catalyst_hand");
        break;
    }
    var_e9329c3d thread function_3c093990(v_origin);
    var_bc40b600 triggerignoreteam();
    var_bc40b600 setvisibletoall();
    var_bc40b600.var_e9329c3d = var_e9329c3d;
    var_bc40b600.str_drop = str_drop;
    level thread function_1822440d(var_bc40b600);
    level thread function_3cdd29d(var_bc40b600);
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0x22ce2f0d, Offset: 0x3540
// Size: 0x18c
function private function_1822440d(t_trig) {
    level endon(#"end_game");
    t_trig endon(#"hash_cf18f85af2935e8");
    waitresult = t_trig waittill(#"trigger");
    e_player = waitresult.activator;
    switch (t_trig.str_drop) {
    case #"concentrated_decay":
        function_53b76ce3(e_player);
        break;
    case #"concentrated_plasma":
        function_f284dd11(e_player);
        break;
    case #"concentrated_purity":
        function_2ba8b254(e_player);
        break;
    case #"concentrated_radiance":
        function_c986900(e_player);
        break;
    }
    level.var_e9c490e2--;
    t_trig notify(#"picked_up");
    t_trig.var_e9329c3d delete();
    t_trig delete();
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0xadcfe5ff, Offset: 0x36d8
// Size: 0x9c
function private function_3cdd29d(t_trig) {
    level endon(#"end_game");
    t_trig endon(#"picked_up");
    wait 30;
    level.var_e9c490e2--;
    t_trig notify(#"hash_cf18f85af2935e8");
    t_trig.var_e9329c3d delete();
    t_trig delete();
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x0
// Checksum 0xe13bed1f, Offset: 0x3780
// Size: 0x242
function function_3c093990(v_origin) {
    self endon(#"death");
    self moveto(v_origin + (0, 0, 1), 0.5, 0.4);
    self waittill(#"movedone");
    wait randomfloat(2);
    for (n_wait = 3; true; n_wait = max(0.25, n_wait - 0.25)) {
        wait n_wait;
        n_move_x = randomfloatrange(0.1, 0.5);
        var_80b1884b = randomfloatrange(0.1, 0.5);
        var_ed535fbd = randomintrange(-180, 180);
        self moveto(self.origin + (n_move_x, var_80b1884b, 0), 0.15);
        self rotatevelocity((0, var_ed535fbd, 0), 0.15);
        self waittill(#"movedone");
        wait 0.25;
        var_ed535fbd = randomintrange(-180, 180);
        self moveto(self.origin - (n_move_x, var_80b1884b, 0), 0.15);
        self rotatevelocity((0, var_ed535fbd, 0), 0.15);
        self waittill(#"movedone");
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x0
// Checksum 0x3d2944e, Offset: 0x39d0
// Size: 0x11c
function function_53b76ce3(e_player) {
    e_player zm_audio::create_and_play_dialog(#"hash_522664a0781d402f", #"hash_4dad16d169c7d6f5");
    e_player.var_1abc4f35 = #"decay";
    if (!level.heldconcentratetext zm_zod_wonderweapon_quest::is_open(e_player)) {
        level.heldconcentratetext zm_zod_wonderweapon_quest::open(e_player, 1);
    }
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_decay(e_player, 1);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_plasma(e_player, 0);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_purity(e_player, 0);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_radiance(e_player, 0);
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x0
// Checksum 0xd1ef36e6, Offset: 0x3af8
// Size: 0x11c
function function_f284dd11(e_player) {
    e_player zm_audio::create_and_play_dialog(#"hash_522664a0781d402f", #"hash_10cdef8b8593408f");
    e_player.var_1abc4f35 = #"plasma";
    if (!level.heldconcentratetext zm_zod_wonderweapon_quest::is_open(e_player)) {
        level.heldconcentratetext zm_zod_wonderweapon_quest::open(e_player, 1);
    }
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_decay(e_player, 0);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_plasma(e_player, 1);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_purity(e_player, 0);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_radiance(e_player, 0);
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x0
// Checksum 0xead9d9ad, Offset: 0x3c20
// Size: 0x11c
function function_2ba8b254(e_player) {
    e_player zm_audio::create_and_play_dialog(#"hash_522664a0781d402f", #"hash_7307eb2ef69e7038");
    e_player.var_1abc4f35 = #"purity";
    if (!level.heldconcentratetext zm_zod_wonderweapon_quest::is_open(e_player)) {
        level.heldconcentratetext zm_zod_wonderweapon_quest::open(e_player, 1);
    }
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_decay(e_player, 0);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_plasma(e_player, 0);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_purity(e_player, 1);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_radiance(e_player, 0);
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x0
// Checksum 0xd0cbc485, Offset: 0x3d48
// Size: 0x11c
function function_c986900(e_player) {
    e_player zm_audio::create_and_play_dialog(#"hash_522664a0781d402f", #"hash_6912b4e5da008dc");
    e_player.var_1abc4f35 = #"radiance";
    if (!level.heldconcentratetext zm_zod_wonderweapon_quest::is_open(e_player)) {
        level.heldconcentratetext zm_zod_wonderweapon_quest::open(e_player, 1);
    }
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_decay(e_player, 0);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_plasma(e_player, 0);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_purity(e_player, 0);
    level.heldconcentratetext zm_zod_wonderweapon_quest::set_radiance(e_player, 1);
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0x41b1d6d1, Offset: 0x3e70
// Size: 0x4c
function private function_54a16649() {
    self.var_1abc4f35 = "";
    if (level.heldconcentratetext zm_zod_wonderweapon_quest::is_open(self)) {
        level.heldconcentratetext zm_zod_wonderweapon_quest::close(self);
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0xebaef091, Offset: 0x3ec8
// Size: 0x74
function private show_chest() {
    if (!isdefined(self.mdl_chest)) {
        self.mdl_chest = util::spawn_model(#"p8_fxanim_zm_zod_kraken_chest_mod", self.s_chest.origin, self.s_chest.angles);
        return;
    }
    self.mdl_chest show();
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0x96921efa, Offset: 0x3f48
// Size: 0x148
function private has_tricannon() {
    a_weapons = self getweaponslistprimaries();
    foreach (weapon in a_weapons) {
        switch (weapon.name) {
        case #"ww_tricannon_fire_t8":
        case #"ww_tricannon_earth_t8":
        case #"ww_tricannon_t8_upgraded":
        case #"ww_tricannon_air_t8_upgraded":
        case #"ww_tricannon_earth_t8_upgraded":
        case #"ww_tricannon_fire_t8_upgraded":
        case #"ww_tricannon_water_t8_upgraded":
        case #"ww_tricannon_water_t8":
        case #"ww_tricannon_t8":
        case #"ww_tricannon_air_t8":
            return true;
        }
    }
    return false;
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x4
// Checksum 0xcd2345e9, Offset: 0x4098
// Size: 0x148
function private function_3217eb4c() {
    a_weapons = self getweaponslistprimaries();
    foreach (weapon in a_weapons) {
        switch (weapon.name) {
        case #"ww_tricannon_fire_t8":
        case #"ww_tricannon_earth_t8":
        case #"ww_tricannon_t8_upgraded":
        case #"ww_tricannon_air_t8_upgraded":
        case #"ww_tricannon_earth_t8_upgraded":
        case #"ww_tricannon_fire_t8_upgraded":
        case #"ww_tricannon_water_t8_upgraded":
        case #"ww_tricannon_water_t8":
        case #"ww_tricannon_t8":
        case #"ww_tricannon_air_t8":
            return weapon;
        }
    }
    return undefined;
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0xffd15913, Offset: 0x41e8
// Size: 0x26
function private is_tricannon(weapon) {
    switch (weapon.name) {
    case #"ww_tricannon_fire_t8":
    case #"ww_tricannon_earth_t8":
    case #"ww_tricannon_t8_upgraded":
    case #"ww_tricannon_air_t8_upgraded":
    case #"ww_tricannon_earth_t8_upgraded":
    case #"ww_tricannon_fire_t8_upgraded":
    case #"ww_tricannon_water_t8_upgraded":
    case #"ww_tricannon_water_t8":
    case #"ww_tricannon_t8":
    case #"ww_tricannon_air_t8":
        return true;
    default:
        return false;
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x4
// Checksum 0x1239662b, Offset: 0x42d8
// Size: 0x26
function private function_9c2d5c41(weapon) {
    switch (weapon.name) {
    case #"ww_tricannon_t8_upgraded":
    case #"ww_tricannon_air_t8_upgraded":
    case #"ww_tricannon_earth_t8_upgraded":
    case #"ww_tricannon_fire_t8_upgraded":
    case #"ww_tricannon_water_t8_upgraded":
        return true;
    default:
        return false;
    }
}

