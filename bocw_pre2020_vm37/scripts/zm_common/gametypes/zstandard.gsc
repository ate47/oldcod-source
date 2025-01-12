#using script_2595527427ea71eb;
#using script_3e8035573d5bf289;
#using script_4b0b3de126cf7c9a;
#using script_537b0d808c4cac25;
#using script_742a29771db74d6f;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_utility_zstandard;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zstandard;

// Namespace zstandard/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x5adc7817, Offset: 0x730
// Size: 0x69c
function event_handler[gametype_init] main(*eventstruct) {
    level.var_f5682bb8 = zm_arcade_timer::register();
    level.var_f995ece6 = zm_trial_timer::register();
    level.var_b9f167ba = self_revive_visuals_rush::register();
    level.var_26a5066b = [];
    level.var_eaaa1d75 = [];
    level.var_4498cb25 = gettime();
    callback::on_connect(&function_1bde57cc);
    level flag::init("started_defend_area");
    zm_gametype::main();
    level.var_e4e8d300 = 1;
    level.var_a3b71a00 = 0.5;
    level.var_fbca9d31 = 1.5;
    level.var_1ffedde8 = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level._game_module_custom_spawn_init_func = &zm_gametype::custom_spawn_init_func;
    level._game_module_stat_update_func = &zm_stats::survival_classic_custom_stat_update;
    level._round_start_func = &zm_round_logic::round_start;
    level.round_wait_func = &function_cab8ebff;
    level.round_think_func = &function_21669ebc;
    level.round_start_custom_func = &function_399fa32;
    level.zombie_round_start_delay = 0;
    level.var_d8d02d0e = &function_ac4cc1ba;
    level.var_d614a8b4 = 1;
    level.var_ef1a71b3 = &get_zombie_count_for_round;
    level.var_76859bbd = &function_1687c93;
    level.custom_door_buy_check = &function_7acf9d9b;
    level.var_2e93df96 = &function_7acf9d9b;
    level.var_d0b54199 = &function_b8839207;
    level.var_9093a47e = &function_b8839207;
    level.var_ddcd74c6 = &function_b8839207;
    level.var_256aa316 = &function_cded672a;
    level.var_c621179 = &function_7adb4617;
    level.var_236b9f7a = &function_37fe3e07;
    level.func_magicbox_update_prompt_use_override = &function_127f0ac5;
    level.custom_generic_deny_vo_func = &function_8d66c98c;
    level.var_c1fe3c83 = &set_revive_count;
    level.var_8c978b55 = &function_d679a241;
    level.var_a6f62e91 = &function_36f1c05b;
    level.var_932a1afb = &function_75ebd926;
    level.var_b0612462 = #"hash_44c1cc8f675c6316";
    level.var_1092025b = 1;
    level.local_doors_stay_open = 1;
    level.var_73d1e054 = 1;
    util::registernumlives(1, 100);
    function_6eeac3e();
    level.var_ea47b206 = [];
    level.var_958d7e38 = 1;
    level.var_78acec0a = 1;
    level.var_50dd0ec5 = 1;
    level.var_cd45ee9f = "zm_base_difficulty_zstandard";
    level.var_12351917 = 1;
    level.var_3e10516a = 1;
    level.var_81bce2c8 = 1;
    level.var_888f3e2 = 1;
    level.player_starting_points = 0;
    level.var_382a24b0 = 1;
    level.var_50f19868 = [];
    level.var_d3cfc0c0 = 1;
    zm_vo::function_d8e12055(&function_3b5fc043);
    level._custom_intro_vox = &intro_vox;
    for (i = 0; i < 5; i++) {
        clientfield::function_5b7d846d("PlayerList.client" + i + ".playerIsDowned", 1, 1, "int");
        clientfield::function_5b7d846d("PlayerList.client" + i + ".multiplier_count", 1, 12, "int");
        clientfield::function_5b7d846d("PlayerList.client" + i + ".multiplier_blink", 1, 1, "int");
        clientfield::function_5b7d846d("PlayerList.client" + i + ".self_revives", 1, 8, "int");
    }
    init_elixirs();
    init_talismans();
    init_pack_a_punch();
    init_magicbox();
    function_24a75fd1();
    level thread function_d717724e();
    thread function_e71942eb();
    finalize_clientfields();
    level._supress_survived_screen = 1;
    /#
        level thread function_6c2b3729();
    #/
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x4
// Checksum 0x55403b9c, Offset: 0xdd8
// Size: 0x6c
function private finalize_clientfields() {
    clientfield::register("toplayer", "zm_trials_timer", 1, getminbitcountfornum(540), "int");
    clientfield::function_5b7d846d("ZMHudGlobal.trials.gameStartTime", 1, 31, "int");
}

/#

    // Namespace zstandard/zstandard
    // Params 0, eflags: 0x0
    // Checksum 0x11041c0e, Offset: 0xe50
    // Size: 0x1f8
    function function_6c2b3729() {
        zm_devgui::add_custom_devgui_callback(&function_2f63dc81);
        adddebugcommand("<dev string:x38>");
        adddebugcommand("<dev string:x8b>");
        adddebugcommand("<dev string:xe1>");
        adddebugcommand("<dev string:x129>");
        waittillframeend();
        level flag::wait_till("<dev string:x188>");
        if (isdefined(level.a_s_defend_areas)) {
            var_f95f5bc7 = getarraykeys(level.a_s_defend_areas);
            foreach (var_355646ad in var_f95f5bc7) {
                str_name = function_9e72a96(var_355646ad);
                util::add_debug_command("<dev string:x1a4>" + str_name + "<dev string:x1ca>" + "<dev string:x1d9>" + str_name + "<dev string:x1ee>" + "<dev string:x1fd>");
                util::add_debug_command("<dev string:x1a4>" + str_name + "<dev string:x203>" + "<dev string:x1d9>" + str_name + "<dev string:x210>" + "<dev string:x1fd>");
            }
        }
    }

    // Namespace zstandard/zstandard
    // Params 1, eflags: 0x0
    // Checksum 0xf1e971b7, Offset: 0x1050
    // Size: 0x40a
    function function_2f63dc81(cmd) {
        switch (cmd) {
        case #"hash_196a879b48e37805":
            if (zm_utility::function_880bd896()) {
                zm_utility::drop_key(level.players[0].origin);
            }
            break;
        case #"hash_2dd0872d741b071e":
            zm_devgui::zombie_devgui_give_powerup("<dev string:x21d>", undefined, level.players[0].origin);
            break;
        case #"hash_745ce03c49ed332a":
            for (i = 0; i < 10; i++) {
                zm_devgui::zombie_devgui_give_powerup("<dev string:x21d>", undefined, level.players[0].origin);
            }
            break;
        case #"hash_2a785bbd314ac393":
            if (isarray(level.var_eaaa1d75) && level.var_eaaa1d75.size) {
                iprintlnbold("<dev string:x234>" + level.var_eaaa1d75[0].origin);
                level.players[0] setorigin(level.var_eaaa1d75[0].origin);
            }
            break;
        default:
            if (isdefined(level.a_s_defend_areas)) {
                var_f95f5bc7 = getarraykeys(level.a_s_defend_areas);
                var_5e62c213 = strtok(cmd, "<dev string:x24a>");
                str_name = var_5e62c213[0];
                var_19d45c79 = var_5e62c213[1];
                if (isinarray(var_f95f5bc7, hash(str_name))) {
                    if (var_19d45c79 === "<dev string:x24f>") {
                        iprintlnbold("<dev string:x25d>" + str_name + "<dev string:x26c>");
                        if (isdefined(level.var_35da2d77) && isdefined(level.var_9149f3ac)) {
                            zm_utility::function_b1f3be5c(level.var_35da2d77, level.var_9149f3ac);
                            level.var_35da2d77 = undefined;
                            level.var_9149f3ac = undefined;
                            util::wait_network_frame();
                        }
                        s_defend_area = zm_utility::function_a877cd10(str_name);
                        level.var_9149f3ac = s_defend_area.var_ed1db1a7;
                        level.var_35da2d77 = zm_utility::function_d7db256e(level.var_9149f3ac, #"hash_683cf7d37afcc3ae");
                    } else {
                        iprintlnbold("<dev string:x278>" + str_name + "<dev string:x285>");
                        s_defend_area = zm_utility::function_a877cd10(str_name);
                        zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 30);
                    }
                }
            }
            break;
        }
    }

#/

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1468
// Size: 0x4
function function_3b5fc043() {
    
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xd6123fe2, Offset: 0x1478
// Size: 0x44
function intro_vox() {
    level endon(#"end_game");
    wait 4;
    level thread zm_audio::sndannouncerplayvox(#"game_start");
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x14c8
// Size: 0x4
function init_elixirs() {
    
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x14d8
// Size: 0x4
function init_talismans() {
    
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x9efa8d2, Offset: 0x14e8
// Size: 0xf8
function function_d717724e() {
    level waittill(#"start_of_round");
    level waittill(#"start_of_round");
    var_42988ccc = struct::get_array("s_bonus_point_locations", "script_noteworthy");
    var_42988ccc = array::randomize(var_42988ccc);
    foreach (s_loc in var_42988ccc) {
        s_loc thread function_744ee8ce();
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x3e594c9a, Offset: 0x15e8
// Size: 0x1ba
function function_744ee8ce() {
    if (isdefined(self.script_flag_wait)) {
        a_str_flags = util::create_flags_and_return_tokens(self.script_flag_wait);
        level flag::wait_till_any(a_str_flags);
    }
    util::function_35840de8(self.script_delay);
    if (isdefined(self.script_objective)) {
        wait 3;
        n_obj_id = gameobjects::get_next_obj_id();
        objective_add(n_obj_id, "active", self.origin, self.script_objective);
        function_6da98133(n_obj_id);
    }
    wait 10;
    if (isdefined(n_obj_id)) {
        gameobjects::release_obj_id(n_obj_id);
    }
    var_ca20f133 = 0;
    if (level flag::get("solo_game")) {
        var_ca20f133 = math::cointoss(20);
    } else {
        var_ca20f133 = math::cointoss(75);
    }
    if (var_ca20f133) {
        wait randomfloatrange(1, 4);
        self.e_powerup = self zm_utility::function_ce46d95e(self.origin, is_true(self.b_permanent));
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x7352db58, Offset: 0x17b0
// Size: 0x3ac
function function_4a631b98() {
    switch (level.players.size) {
    case 1:
        var_fea19744 = 30000;
        var_f2f59fd7 = 20000;
        var_730a1ffe = 80000;
        var_714c3ae = 5000;
        var_f147981c = 5000;
        var_3853c97 = 5000;
        break;
    default:
        var_fea19744 = 10000;
        var_f2f59fd7 = 10000;
        var_730a1ffe = 45000;
        var_714c3ae = 5500;
        var_f147981c = 5500;
        var_3853c97 = 5500;
        break;
    }
    zm_hero_weapon::function_53cdfacf("chakram", var_fea19744);
    zm_hero_weapon::function_53cdfacf("hammer", var_fea19744);
    zm_hero_weapon::function_53cdfacf("scepter", var_fea19744);
    zm_hero_weapon::function_53cdfacf("sword_pistol", var_fea19744);
    zm_hero_weapon::function_53cdfacf("gravityspikes", var_fea19744);
    zm_hero_weapon::function_53cdfacf("katana", var_fea19744);
    zm_hero_weapon::function_53cdfacf("minigun", var_fea19744);
    zm_hero_weapon::function_53cdfacf("flamethrower", var_fea19744);
    zm_hero_weapon::function_5ccf482("chakram", var_714c3ae, var_f147981c, var_3853c97);
    zm_hero_weapon::function_5ccf482("hammer", var_714c3ae, var_f147981c, var_3853c97);
    zm_hero_weapon::function_5ccf482("scepter", var_714c3ae, var_f147981c, var_3853c97);
    zm_hero_weapon::function_5ccf482("sword_pistol", var_714c3ae, var_f147981c, var_3853c97);
    zm_hero_weapon::function_5ccf482("gravityspikes", var_714c3ae, var_f147981c, var_3853c97);
    zm_hero_weapon::function_5ccf482("katana", var_714c3ae, var_f147981c, var_3853c97);
    zm_hero_weapon::function_5ccf482("minigun", var_714c3ae, var_f147981c, var_3853c97);
    zm_hero_weapon::function_5ccf482("flamethrower", var_714c3ae, var_f147981c, var_3853c97);
    zm_hero_weapon::function_7a394ec4("chakram", 0, var_f2f59fd7, var_730a1ffe);
    zm_hero_weapon::function_7a394ec4("hammer", 0, var_f2f59fd7, var_730a1ffe);
    zm_hero_weapon::function_7a394ec4("scepter", 0, var_f2f59fd7, var_730a1ffe);
    zm_hero_weapon::function_7a394ec4("sword_pistol", 0, var_f2f59fd7, var_730a1ffe);
    zm_hero_weapon::function_7a394ec4("gravityspikes", 0, var_f2f59fd7, var_730a1ffe);
    zm_hero_weapon::function_7a394ec4("katana", 0, var_f2f59fd7, var_730a1ffe);
    zm_hero_weapon::function_7a394ec4("minigun", 0, var_f2f59fd7, var_730a1ffe);
    zm_hero_weapon::function_7a394ec4("flamethrower", 0, var_f2f59fd7, var_730a1ffe);
    level.var_f03084a6 = 1;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x8a945f73, Offset: 0x1b68
// Size: 0x94
function function_24a75fd1() {
    callback::on_ai_killed(&function_45a520db);
    callback::on_ai_damage(&function_e0c53cf);
    level.var_e01b92bb = 0;
    level.bonus_points_powerup_override = &bonus_points_powerup_override;
    level thread function_6be33257();
    level thread function_c7201cb9();
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xfbd1ba8e, Offset: 0x1c08
// Size: 0x36a
function function_c7201cb9() {
    level endon(#"end_game");
    waittillframeend();
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        if (getplayers().size == 1) {
            wait 7;
            continue;
        }
        zm_score::function_bc9de425();
        foreach (player in level.players) {
            if (player.score > 0 && player.var_9fc3ee66 != player.var_a8da9faf) {
                if (player.var_9fc3ee66 == 1) {
                    level thread zm_audio::sndannouncerplayvox(#"hash_72c41c0eef65bb72", player, undefined, undefined, 1, 1);
                    continue;
                }
                if (player.var_a8da9faf == 1) {
                    level thread zm_audio::sndannouncerplayvox(#"lead_lost", player, undefined, undefined, 1, 1);
                    continue;
                }
                if (level.players.size > 2 && player.var_a8da9faf > 2 && player.var_9fc3ee66 == 2) {
                    level thread zm_audio::sndannouncerplayvox(#"hash_784cbfe750be656c", player, undefined, undefined, 1, 1);
                    continue;
                }
                if (level.players.size > 3 && player.var_a8da9faf > 3 && player.var_9fc3ee66 == 3) {
                    level thread zm_audio::sndannouncerplayvox(#"hash_1cd6763f49f8b829", player, undefined, undefined, 1, 1);
                    continue;
                }
                if (level.players.size > 3 && player.var_a8da9faf < 3 && player.var_9fc3ee66 == 3) {
                    level thread zm_audio::sndannouncerplayvox(#"hash_207d901d1a9487e1", player, undefined, undefined, 1, 1);
                    continue;
                }
                if (level.players.size > 2 && player.var_9fc3ee66 == level.players.size) {
                    level thread zm_audio::sndannouncerplayvox(#"hash_15d8616ab0b6f870", player, undefined, undefined, 1, 1);
                }
            }
        }
        wait 7;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x92231d5, Offset: 0x1f80
// Size: 0x498
function function_6be33257() {
    level endon(#"end_game");
    waittillframeend();
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        if (level.players.size == 1) {
            player = level.players[0];
            if (player.var_7e008e0c >= 75) {
                player.var_cf914505 = 0.01;
                player.var_72b24dc2 = 15 - 11.25;
            } else if (level.players[0].var_7e008e0c >= 50) {
                player.var_cf914505 = 0.00875;
                player.var_72b24dc2 = 15 - 7.5;
            } else if (level.players[0].var_7e008e0c >= 25) {
                player.var_cf914505 = 0.0075;
                player.var_72b24dc2 = 15 - 3.75;
            } else {
                player.var_cf914505 = 0.005;
                player.var_72b24dc2 = 15;
            }
            if (player.var_72b24dc2 <= 5) {
                player.var_72b24dc2 = 6;
            }
            wait 1;
            continue;
        }
        switch (level.players.size) {
        case 2:
            var_94f7cc27 = 0.8;
            var_4fc077e3 = 0.7;
            var_924f4311 = 0.6;
            var_8863363a = 0.25;
            break;
        case 3:
            var_94f7cc27 = 0.6;
            var_4fc077e3 = 0.5;
            var_924f4311 = 0.4;
            var_8863363a = 0.2;
            break;
        case 4:
        default:
            var_94f7cc27 = 0.5;
            var_4fc077e3 = 0.4;
            var_924f4311 = 0.3;
            var_8863363a = 0.1;
            break;
        }
        foreach (player in level.players) {
            if (!isalive(player)) {
                continue;
            }
            if (player.score_total < 20000 || level.score_total <= 0) {
                continue;
            }
            if (level.score_total > 0) {
                player.var_4b6aee2b = player.score_total / level.score_total;
            }
            if (player.var_4b6aee2b >= var_94f7cc27) {
                player.var_cf914505 = 0.01;
                player.var_72b24dc2 = 15 - 11.25;
            } else if (player.var_4b6aee2b >= var_4fc077e3) {
                player.var_cf914505 = 0.00875;
                player.var_72b24dc2 = 15 - 7.5;
            } else if (player.var_4b6aee2b >= var_924f4311) {
                player.var_cf914505 = 0.0075;
                player.var_72b24dc2 = 15 - 3.75;
            } else {
                player.var_cf914505 = 0.005;
                player.var_72b24dc2 = 15;
            }
            if (player.var_4b6aee2b <= var_8863363a) {
            }
            if (player.var_72b24dc2 <= 5) {
                player.var_72b24dc2 = 6;
            }
        }
        wait 1;
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xd1bfadf9, Offset: 0x2420
// Size: 0x4a
function bonus_points_powerup_override(player) {
    player function_3450100a("bonus_points_player_grabbed");
    var_ab038cab = function_f41d8454();
    return var_ab038cab;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x51a09773, Offset: 0x2478
// Size: 0x284
function function_e0c53cf(params) {
    if (!isdefined(self.maxhealth)) {
        /#
            iprintlnbold(function_9e72a96(self.archetype) + "<dev string:x297>");
        #/
        self.maxhealth = self.health;
        return;
    }
    if (isalive(self) && isdefined(self.var_6f84b820) && (isplayer(params.eattacker) || isplayer(params.einflictor)) && params.idamage < self.health) {
        switch (self.var_6f84b820) {
        case #"special":
            var_3b210d82 = self.maxhealth * 0.2;
            break;
        case #"boss":
        case #"elite":
            var_3b210d82 = self.maxhealth * 0.1;
            break;
        default:
            return;
        }
        if (!isdefined(self.var_a5a58758)) {
            self.var_18acfe18 = 0;
            self.var_a5a58758 = 0;
            self.var_18acfe18 += params.idamage;
            var_487ba56d = function_c3a8f243(2);
            level thread zm_utility::function_6cb904e2(self.origin, var_487ba56d, 700, 1);
            return;
        }
        self.var_18acfe18 += params.idamage;
        if (self.var_18acfe18 >= var_3b210d82) {
            self.var_18acfe18 = 0;
            self.var_a5a58758++;
            var_487ba56d = function_c3a8f243(2);
            level thread zm_utility::function_6cb904e2(self.origin, var_487ba56d, 700, 1);
        }
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x7c48bc80, Offset: 0x2708
// Size: 0x96
function function_c3a8f243(_gen_zipline_traversal) {
    switch (level.players.size) {
    case 1:
        var_487ba56d = _gen_zipline_traversal / 0.5;
        break;
    case 2:
        var_487ba56d = _gen_zipline_traversal / 0.75;
        break;
    default:
        var_487ba56d = _gen_zipline_traversal;
        break;
    }
    return var_487ba56d;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xa60c9255, Offset: 0x27a8
// Size: 0x348
function function_45a520db(params) {
    level.var_e01b92bb++;
    if (isdefined(self.var_6f84b820)) {
        switch (self.var_6f84b820) {
        case #"special":
            var_487ba56d = 5;
            playsoundatposition(#"hash_57559c7467fac3a5", self.origin);
            break;
        case #"elite":
            var_487ba56d = 10;
            playsoundatposition(#"hash_612ef6ccaf0effeb", self.origin);
            break;
        case #"boss":
            var_487ba56d = 15;
            break;
        }
    }
    if (isdefined(var_487ba56d)) {
        level thread zm_utility::function_4a25b584(self.origin, var_487ba56d);
    }
    if (isdefined(params.einflictor) && isplayer(params.einflictor.activated_by_player)) {
        params.einflictor.activated_by_player function_261d5f79(params, self);
        return;
    }
    if (isplayer(params.einflictor)) {
        params.einflictor function_261d5f79(params, self);
        return;
    }
    if (isdefined(params.eattacker) && isplayer(params.eattacker.activated_by_player)) {
        params.eattacker.activated_by_player function_261d5f79(params, self);
        return;
    }
    if (isplayer(params.eattacker)) {
        params.eattacker function_261d5f79(params, self);
        return;
    }
    if (is_true(self.nuked)) {
        foreach (player in function_a1ef346b()) {
            if (isarray(player.zombie_nuked) && isinarray(player.zombie_nuked, self)) {
                player function_261d5f79(params, self);
            }
        }
    }
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0x778206c6, Offset: 0x2af8
// Size: 0x136
function function_261d5f79(params, ai_killed) {
    self function_3450100a("zm_arcade_kill", ai_killed, params);
    var_96d5f0e8 = float(gettime()) / 1000 - self.var_5d24f421;
    self.var_5d24f421 = float(gettime()) / 1000;
    if (ai_killed zm_utility::is_headshot(params.weapon, params.shitloc, params.smeansofdeath)) {
        self.var_30c56c16++;
    } else if (isdefined(ai_killed) && !is_true(ai_killed.nuked)) {
        self.var_30c56c16 = 0;
    }
    self notify(#"zm_arcade_kill", {#ai_killed:ai_killed, #params:params});
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x6f71e95e, Offset: 0x2c38
// Size: 0xbc
function function_1bde57cc() {
    self.var_7e008e0c = 0;
    self.var_30c56c16 = 0;
    self.highest_multiplier = 0;
    self.var_4b6aee2b = 0;
    self.var_cf914505 = 0.005;
    self.var_72b24dc2 = 15;
    self.var_5d24f421 = float(gettime()) / 1000;
    self thread function_c48750b();
    self thread function_e03ea502();
    self thread function_71e054d7();
}

// Namespace zstandard/zstandard
// Params 3, eflags: 0x0
// Checksum 0xe088c1a8, Offset: 0x2d00
// Size: 0x20c
function function_3450100a(str_event, ai_killed, params) {
    if (!isdefined(self.var_7e008e0c)) {
        self.var_7e008e0c = 0;
    }
    if (!isdefined(self.highest_multiplier)) {
        self.highest_multiplier = 0;
    }
    if (game.state === "postgame") {
        return;
    }
    self.var_7e008e0c++;
    self.highest_multiplier = int(max(self.highest_multiplier, self.var_7e008e0c + 1) + 0.5);
    self zm_stats::function_5d0e6000("HIGHEST_MULTIPLIER", self.highest_multiplier);
    self zm_stats::function_1b763e4("HIGHEST_MULTIPLIER", self.highest_multiplier);
    self zm_stats::function_69317807("HIGHEST_MULTIPLIER", self.highest_multiplier);
    var_43c39780 = self.var_7e008e0c + 1;
    switch (var_43c39780) {
    case 20:
        level thread zm_audio::sndannouncerplayvox(#"multiplier_rising", self);
        break;
    case 50:
    case 75:
    case 100:
    case 125:
    case 150:
        self function_2a5d7e30(var_43c39780);
        break;
    }
    self function_b8b6bc95(str_event, ai_killed, params);
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x2892dde2, Offset: 0x2f18
// Size: 0x84
function function_2a5d7e30(n_multiplier) {
    var_63efafed = "b_multiplier_" + n_multiplier;
    if (!is_true(self.(var_63efafed))) {
        level thread zm_audio::sndannouncerplayvox(#"multiplier_" + n_multiplier, self);
        self.(var_63efafed) = 1;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x6c5505ec, Offset: 0x2fa8
// Size: 0x2e
function function_10c7411b() {
    self.var_d7b779d2 = undefined;
    self.var_8414d8b6 = undefined;
    self.var_a41419e2 = undefined;
    self.var_36473c0a = undefined;
    self.var_558cd900 = undefined;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x88a9d4ed, Offset: 0x2fe0
// Size: 0x600
function function_e03ea502() {
    self endon(#"disconnect");
    level endon(#"end_game");
    str_extra_info = #"hash_4ba6bddb362745d9";
    level waittill(#"start_of_round");
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".multiplier_blink", 0);
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".multiplier_count", self.var_7e008e0c + 1);
    while (true) {
        s_waitresult = self waittilltimeout(self.var_72b24dc2, #"zm_arcade_kill", #"damage", #"bled_out", #"player_downed", #"bonus_points_player_grabbed", #"multiplier_timeout", #"hash_b696fc900429737", #"player_grabbed_key");
        clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".multiplier_blink", 0);
        str_extra_info = #"hash_4ba6bddb362745d9";
        switch (s_waitresult._notify) {
        case #"bonus_points_player_grabbed":
            var_96d5f0e8 = float(gettime()) / 1000 - self.var_5d24f421;
            self.var_5d24f421 = float(gettime()) / 1000;
            break;
        case #"player_grabbed_key":
            self function_3450100a("player_grabbed_key");
            break;
        case #"zm_arcade_kill":
            break;
        case #"timeout":
            if (self.var_7e008e0c > 0) {
                self thread function_c1ab015e();
            }
            break;
        case #"multiplier_timeout":
        case #"damage":
            if (isdefined(s_waitresult.mod) && s_waitresult.mod != "MOD_FALLING" || s_waitresult._notify == "multiplier_timeout") {
                str_extra_info = #"hash_68f33faa5abddd73";
                if (s_waitresult._notify == "multiplier_timeout" && self.var_7e008e0c > 0) {
                    var_210b3e4c = self.var_7e008e0c + 1;
                    if (var_210b3e4c >= 150) {
                        var_d866ecc6 = 4 / var_210b3e4c;
                    } else if (var_210b3e4c >= 100) {
                        var_d866ecc6 = 3 / var_210b3e4c;
                    } else if (var_210b3e4c >= 50) {
                        var_d866ecc6 = 2 / var_210b3e4c;
                    } else {
                        var_d866ecc6 = 1 / var_210b3e4c;
                    }
                } else {
                    if (self.var_7e008e0c > 0) {
                        zm_custom::function_db030433();
                    }
                    var_d866ecc6 = (isdefined(s_waitresult.amount) ? s_waitresult.amount : 50) * self.var_cf914505;
                    var_d866ecc6 = math::clamp(var_d866ecc6, 0, 0.75);
                    if (self.var_7e008e0c > 0 && !is_true(self.var_5288b14b)) {
                        self playsoundtoplayer(#"hash_d71dba92ab8897c", self);
                        self thread function_a097cde6();
                    }
                }
                var_51c596b = max(ceil(self.var_7e008e0c * var_d866ecc6), 1);
                self.var_7e008e0c = int(self.var_7e008e0c - var_51c596b);
                self.var_30c56c16 = 0;
            }
            if (self.var_7e008e0c <= 0 || self laststand::player_is_in_laststand()) {
                str_extra_info = #"hash_7b51f2f428fcb3c2";
                self.var_7e008e0c = 0;
                self.var_30c56c16 = 0;
            }
            break;
        case #"player_downed":
        case #"bled_out":
            self.var_7e008e0c = 0;
            self.var_30c56c16 = 0;
            break;
        default:
            break;
        }
        clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".multiplier_count", self.var_7e008e0c + 1);
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xe81d4ac4, Offset: 0x35e8
// Size: 0x3a
function function_a097cde6() {
    self endon(#"disconnect");
    self.var_5288b14b = 1;
    wait 0.5;
    self.var_5288b14b = undefined;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x5a3b6551, Offset: 0x3630
// Size: 0x188
function function_c1ab015e() {
    self notify(#"hash_18be4b1da8bbed9b");
    self endon(#"hash_18be4b1da8bbed9b", #"disconnect", #"zm_arcade_kill", #"damage", #"bled_out", #"player_downed", #"bonus_points_player_grabbed", #"hash_b696fc900429737", #"player_grabbed_key");
    level endon(#"end_game");
    if (self.var_7e008e0c <= 0) {
        return;
    }
    util::wait_network_frame();
    self thread tube_gruesome();
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".multiplier_blink", 1);
    util::wait_network_frame();
    wait 5;
    while (self.var_7e008e0c > 0) {
        self playsoundtoplayer(#"hash_10a416158cd8fd3a", self);
        self notify(#"multiplier_timeout");
        wait 1;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xe945bd93, Offset: 0x37c0
// Size: 0xe0
function tube_gruesome() {
    self endon(#"hash_18be4b1da8bbed9b", #"disconnect", #"zm_arcade_kill", #"damage", #"bled_out", #"player_downed", #"bonus_points_player_grabbed", #"hash_b696fc900429737", #"player_grabbed_key", #"multiplier_timeout");
    while (true) {
        self playsoundtoplayer(#"hash_11d338092fefba12", self);
        wait 0.55;
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x1e53bf69, Offset: 0x38a8
// Size: 0x74
function function_4e9a2af4(var_273349fe) {
    switch (var_273349fe) {
    case 1:
        return (var_273349fe * 5);
    case 5:
        return (var_273349fe * 3);
    default:
        break;
    }
    return var_273349fe * 2;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x8274251b, Offset: 0x3928
// Size: 0x14c
function function_c48750b() {
    self endon(#"disconnect");
    level endon(#"end_game");
    var_273349fe = 1;
    while (true) {
        s_waitresult = self waittill(#"earned_points");
        profilestart();
        self function_cd6476e(s_waitresult.n_points);
        if (self.score >= 20000 * var_273349fe) {
            var_7b2ac985 = zm_laststand::function_618fd37e();
            self zm_laststand::function_3d685b5f(var_7b2ac985 + 1);
            self zm_utility::function_846eb7dd(#"hash_3ac2171741b33fc9", #"hash_3d34018a57f83b7c");
            level thread zm_audio::sndannouncerplayvox(#"extra_life", self, undefined, undefined, 1);
            var_273349fe = function_4e9a2af4(var_273349fe);
        }
        profilestop();
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x945cb3c0, Offset: 0x3a80
// Size: 0x1d4
function function_cd6476e(var_16ef1c43) {
    self zm_stats::increment_challenge_stat(#"hash_47685630580f6b5f", var_16ef1c43);
    /#
        if (self zm_stats::get_client_stat(#"hash_47685630580f6b5f") >= 100000000) {
            self iprintlnbold("<dev string:x2c4>");
        }
    #/
    if (!is_true(self.var_121888ab) && self.score >= 250000) {
        self zm_utility::function_659819fa(#"zm_rush_personal_score");
        self.var_121888ab = 1;
    }
    if (!is_true(level.var_6d868f6e) && level.players.size > 1 && level.score_total >= 500000) {
        level zm_utility::function_659819fa(#"zm_rush_team_score", 1);
        level.var_6d868f6e = 1;
    }
    if (self.var_7e008e0c >= 100) {
        if (!is_true(self.var_b3381e0)) {
            self zm_utility::function_659819fa(#"zm_rush_multiplier_100");
            self.var_b3381e0 = 1;
        }
        self contracts::increment_zm_contract(#"contract_zm_rush_multiplier");
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x5f418e9b, Offset: 0x3c60
// Size: 0x4a
function function_d9bf8453() {
    switch (level.players.size) {
    case 1:
        return 10;
    default:
        return 10;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x8b16b54f, Offset: 0x3cb8
// Size: 0x4a
function function_f41d8454() {
    switch (level.players.size) {
    case 1:
        return 15;
    default:
        return 15;
    }
}

// Namespace zstandard/zstandard
// Params 3, eflags: 0x0
// Checksum 0x5b25c405, Offset: 0x3d10
// Size: 0x1fc
function function_b8b6bc95(str_event, ai_killed, params) {
    self endon(#"disconnect", #"damage", #"player_downed", #"bled_out");
    waittillframeend();
    if (self.var_7e008e0c < 2) {
        return;
    }
    var_f2c28d86 = 0;
    var_1716aec8 = zm_score::get_points_multiplier(self);
    if (str_event == "zm_arcade_kill") {
        if (isdefined(params) && ai_killed zm_utility::is_headshot(params.weapon, params.shitloc, params.smeansofdeath)) {
            n_headshot_multiplier = 1;
        } else {
            n_headshot_multiplier = 1;
        }
        var_93d11f0f = function_d9bf8453();
        var_f2c28d86 = int(var_93d11f0f * self.var_7e008e0c * var_1716aec8 * n_headshot_multiplier);
    } else if (str_event == "bonus_points_player_grabbed" || str_event == "player_grabbed_key") {
        var_ab038cab = function_f41d8454();
        var_f2c28d86 = int(var_ab038cab * self.var_7e008e0c * var_1716aec8);
    }
    self zm_score::add_to_player_score(var_f2c28d86, 1, "multiplier_points");
    self function_a79dd957(var_f2c28d86, str_event);
}

// Namespace zstandard/zstandard
// Params 3, eflags: 0x0
// Checksum 0x2ba4b6e2, Offset: 0x3f18
// Size: 0x19c
function function_a79dd957(var_f2c28d86, str_event, *ai_killed) {
    if (ai_killed === "zm_arcade_kill") {
    } else if (ai_killed === "bonus_points_player_grabbed" || ai_killed === "player_grabbed_key") {
        self luinotifyevent(#"bonus_points_player_grabbed", 2, str_event, self getentitynumber());
        return;
    }
    var_6d420b43 = 70;
    var_861aa403 = floor(str_event / var_6d420b43);
    var_21349718 = str_event % var_6d420b43;
    var_29cc1091 = 10;
    while (var_6d420b43 > 0 && var_29cc1091 > 0) {
        for (i = 0; i < var_861aa403; i++) {
            self zm_score::score_cf_increment_info("damage" + var_6d420b43);
            var_29cc1091--;
        }
        var_6d420b43 -= 10;
        if (var_6d420b43 <= 0) {
            break;
        }
        var_861aa403 = floor(var_21349718 / var_6d420b43);
        var_21349718 %= var_6d420b43;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xef9bf474, Offset: 0x40c0
// Size: 0x34
function init_pack_a_punch() {
    level.var_3e3d6409 = &function_10e451d7;
    level.var_c5b57b4 = &function_dead22f;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x7c11cd71, Offset: 0x4100
// Size: 0x2c
function function_dead22f(player) {
    function_51e47b48(player, "pap", 30000);
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x74c17ca2, Offset: 0x4138
// Size: 0xfa
function function_10e451d7(player) {
    n_cooldown = function_3e1c5dad(player, "pap");
    if (n_cooldown > 0) {
        self sethintstringforplayer(player, #"zombie/wallbuy_cooldown", n_cooldown);
        player.var_486c9d59 = 1;
    } else {
        if (player function_8b1a219a()) {
            self sethintstringforplayer(player, #"hash_12517f2f23bd1966");
        } else {
            self sethintstringforplayer(player, #"hash_6c8cfa12133d4a58");
        }
        player.var_486c9d59 = undefined;
    }
    return true;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x657e401d, Offset: 0x4240
// Size: 0x48
function function_83916805(player) {
    n_cooldown = function_3e1c5dad(player, "pap");
    if (n_cooldown > 0) {
        return false;
    }
    return true;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xc9d9f4a0, Offset: 0x4290
// Size: 0x7c
function init_magicbox() {
    setdvar(#"magic_chest_movable", 1);
    level.var_bb6907a4 = &function_51ed4d8b;
    level.var_3ba4b305 = 10;
    level.var_ad2674fe = 7;
    level.custom_magic_box_do_weapon_rise = &function_bfa1bab7;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xf4f6269a, Offset: 0x4318
// Size: 0x1c4
function function_bfa1bab7() {
    self endon(#"box_hacked_respin");
    self setzbarrierpiecestate(3, "closed");
    self setzbarrierpiecestate(4, "closed");
    util::wait_network_frame();
    self zbarrierpieceuseboxriselogic(3);
    self zbarrierpieceuseboxriselogic(4);
    self showzbarrierpiece(3);
    self showzbarrierpiece(4);
    self setzbarrierpiecestate(3, "opening", 0.25);
    self setzbarrierpiecestate(4, "opening", 0.25);
    self playsound(#"hash_59a4ec7cb3de7d13");
    self waittill(#"randomization_done");
    self setzbarrierpiecestate(3, "open");
    self setzbarrierpiecestate(4, "open");
    self hidezbarrierpiece(3);
    self hidezbarrierpiece(4);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x67f039e9, Offset: 0x44e8
// Size: 0xb0
function function_e71942eb() {
    waittillframeend();
    level flag::wait_till("all_players_spawned");
    level.oob_timelimit_ms = 5000;
    level.func_get_delay_between_rounds = &get_delay_between_rounds;
    function_9c062829();
    function_fe4381f8();
    function_4a631b98();
    init_wallbuys();
    if (isdefined(level.var_418e116c)) {
        level thread [[ level.var_418e116c ]]();
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xd4d74cf8, Offset: 0x45a0
// Size: 0x4c
function function_5a2c9b1c(n_round_number) {
    var_9ce09855 = isdefined(level.var_9ce09855) ? level.var_9ce09855 : 48;
    if (n_round_number >= var_9ce09855) {
        return true;
    }
    return false;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x539df4b8, Offset: 0x45f8
// Size: 0x68
function function_77ee3cd2(n_round_number) {
    if (function_5a2c9b1c(n_round_number)) {
        var_867b0c8 = isdefined(level.var_3ec2f3b6) ? level.var_3ec2f3b6 : 3;
        if (n_round_number % var_867b0c8 == 0) {
            return true;
        }
    }
    return false;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xe9597dc, Offset: 0x4668
// Size: 0x92
function get_delay_between_rounds() {
    if (function_77ee3cd2(level.round_number - 1)) {
        return 20;
    } else if (!function_5a2c9b1c(level.round_number - 1)) {
        if (zm_utility::function_e12de7f5(level.round_number - 1)) {
            return 6;
        } else {
            return 1;
        }
    }
    return 8;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x6f89f84c, Offset: 0x4708
// Size: 0x3c
function set_revive_count() {
    self clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".self_revives", self.var_72249004);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x4750
// Size: 0x4
function function_8d66c98c() {
    
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xc055fef3, Offset: 0x4760
// Size: 0x3fa
function function_ac4cc1ba() {
    if (!isdefined(level.var_cd8b6cd0)) {
        level.var_cd8b6cd0 = 1;
    }
    if (level.round_number < level.var_cd8b6cd0) {
        return;
    }
    level endon(#"intermission", #"end_of_round", #"restart_round");
    /#
        level endon(#"kill_round");
    #/
    a_ai_zombies = zombie_utility::get_round_enemy_array();
    n_time = 0;
    while (a_ai_zombies.size > 0 || level.zombie_total > 0) {
        var_f235658b = isdefined(level.var_d7853f35) ? level.var_d7853f35 : 25;
        var_6c499981 = isdefined(level.var_3f86fd35) ? level.var_3f86fd35 : 13;
        foreach (ai_zombie in a_ai_zombies) {
            if (level.round_number >= var_f235658b) {
                if (!is_true(ai_zombie.var_eceaa835)) {
                    ai_zombie.var_eceaa835 = 1;
                    if (ai_zombie.archetype === #"brutus") {
                        ai_zombie thread zombie_utility::set_zombie_run_cycle("sprint");
                    } else {
                        ai_zombie thread zombie_utility::set_zombie_run_cycle("super_sprint");
                    }
                }
                continue;
            }
            if (level.round_number >= var_6c499981) {
                if (!is_true(ai_zombie.var_eceaa835)) {
                    ai_zombie.var_eceaa835 = 1;
                    ai_zombie thread zombie_utility::set_zombie_run_cycle("sprint");
                }
                continue;
            }
            if (level.players.size == 1 && a_ai_zombies.size <= 2 || level.players.size > 1 && a_ai_zombies.size <= 5) {
                if (!is_true(ai_zombie.var_eceaa835)) {
                    ai_zombie.var_eceaa835 = 1;
                    ai_zombie thread zombie_utility::set_zombie_run_cycle("sprint");
                }
                continue;
            }
            if (n_time >= 30 && !is_true(ai_zombie.var_497d2f90)) {
                ai_zombie.var_497d2f90 = 1;
                if (math::cointoss(5)) {
                    ai_zombie thread zombie_utility::set_zombie_run_cycle("sprint");
                    continue;
                }
                ai_zombie thread zombie_utility::set_zombie_run_cycle("run");
            }
        }
        wait 1;
        n_time++;
        a_ai_zombies = zombie_utility::get_round_enemy_array();
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x7a763685, Offset: 0x4b68
// Size: 0x104
function function_cd83246f() {
    foreach (var_51958981 in level.var_4fe2f84d) {
        foreach (t_trigger in var_51958981) {
            t_trigger.locked = 1;
            level thread zm_unitrigger::unregister_unitrigger(t_trigger);
        }
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xfd1e2988, Offset: 0x4c78
// Size: 0xaa
function function_fe4381f8() {
    foreach (s_barricade in level.exterior_goals) {
        s_barricade.script_delay = float(function_60d95f53()) / 1000;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x50bdb14f, Offset: 0x4d30
// Size: 0x244
function function_9c062829() {
    waitframe(1);
    a_e_items = getitemarray();
    foreach (e_item in a_e_items) {
        w_item = e_item.item;
        if (isdefined(w_item) && is_true(w_item.craftitem)) {
            e_player = array::random(level.players);
            zm_items::player_pick_up(e_player, w_item);
            e_item delete();
        }
    }
    foreach (a_s_crafting in level.var_4fe2f84d) {
        foreach (s_crafting in a_s_crafting) {
            if (!is_true(s_crafting.var_95f72816)) {
                s_crafting zm_crafting::function_a187b293();
            }
        }
    }
    level.var_905507c3 = 1;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x17697630, Offset: 0x4f80
// Size: 0x50e
function init_powerups() {
    level.var_ec45f213 = 1;
    if (zm_custom::function_901b751c(#"zmpowerupsislimitedround")) {
        zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", zm_custom::function_901b751c(#"zmpowerupslimitround"));
    } else {
        zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 4);
    }
    zombie_utility::set_zombie_var(#"hash_604cac237ec8cd3", 4);
    zombie_utility::set_zombie_var(#"hash_8b7fc80184dc451", 7);
    zombie_utility::set_zombie_var(#"hash_604cbc237ec8e86", 5);
    zombie_utility::set_zombie_var(#"hash_8b7f980184dbf38", 8);
    zombie_utility::set_zombie_var(#"hash_604ccc237ec9039", 6);
    zombie_utility::set_zombie_var(#"hash_8b7fa80184dc0eb", 9);
    zombie_utility::set_zombie_var(#"hash_604cdc237ec91ec", 6);
    zombie_utility::set_zombie_var(#"hash_8b7ff80184dc96a", 10);
    zombie_utility::set_zombie_var(#"hash_604cec237ec939f", 6);
    zombie_utility::set_zombie_var(#"hash_8b80080184dcb1d", 10);
    zombie_utility::set_zombie_var(#"hash_4d2cc817490bcca", 8);
    zombie_utility::set_zombie_var(#"hash_4edd68174a79580", 14);
    level.zm_genesis_robot_pay_towardsreactswordstart = randomintrange(zombie_utility::function_d2dfacfd(#"hash_4d2cc817490bcca"), zombie_utility::function_d2dfacfd(#"hash_4edd68174a79580"));
    zm_powerups::add_zombie_powerup("bonus_points_player", #"p8_zm_powerup_rush_point", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
    zm_powerups::powerup_remove_from_regular_drops("hero_weapon_power");
    zm_powerups::powerup_remove_from_regular_drops("bonus_points_team");
    zm_powerups::powerup_remove_from_regular_drops("fire_sale");
    level thread function_9876ea1b();
    if (isdefined(level.zombie_powerups[#"insta_kill"])) {
        level.zombie_powerups[#"insta_kill"].func_should_drop_with_regular_powerups = &function_ca407bef;
    }
    if (isdefined(level.zombie_powerups[#"nuke"])) {
        level.zombie_powerups[#"nuke"].func_should_drop_with_regular_powerups = &function_ca407bef;
    }
    if (isdefined(level.zombie_powerups[#"double_points"])) {
        level.zombie_powerups[#"double_points"].func_should_drop_with_regular_powerups = &function_ca407bef;
    }
    level._custom_powerups[#"bonus_points_player"].setup_powerup = &function_705c5a95;
    level._custom_powerups[#"bonus_points_player_shared"].setup_powerup = &function_705c5a95;
    level._custom_powerups[#"bonus_points_team"].setup_powerup = &function_705c5a95;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x52ff979b, Offset: 0x5498
// Size: 0x24
function function_705c5a95() {
    self setmodel(#"p8_zm_powerup_rush_point");
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xbf54b558, Offset: 0x54c8
// Size: 0x1ec
function function_9876ea1b() {
    level flag::wait_till("start_zombie_round_logic");
    if (isdefined(level.zombie_powerups[#"double_points"])) {
        level.zombie_powerups[#"double_points"].only_affects_grabber = 1;
    }
    if (isdefined(level.zombie_powerups[#"insta_kill"])) {
        level.zombie_powerups[#"insta_kill"].only_affects_grabber = 1;
    }
    if (isdefined(level.zombie_powerups[#"nuke"])) {
        level.zombie_powerups[#"nuke"].only_affects_grabber = 1;
    }
    if (isdefined(level.zombie_powerups[#"carpenter"])) {
        level.zombie_powerups[#"carpenter"].only_affects_grabber = 1;
    }
    if (isdefined(level.zombie_powerups[#"fire_sale"])) {
        level.zombie_powerups[#"fire_sale"].only_affects_grabber = 1;
    }
    if (isdefined(level.zombie_powerups[#"full_ammo"])) {
        level.zombie_powerups[#"full_ammo"].only_affects_grabber = 1;
    }
    level.powerup_fx_func = &function_2778c01b;
    level.var_50b95271 = &function_f75f31d2;
    level.powerup_intro_fx_func = &function_c54c18db;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x5603c458, Offset: 0x56c0
// Size: 0x4c
function function_f75f31d2() {
    if (!isdefined(self)) {
        return;
    }
    var_f79dc259 = self function_5f4de70e();
    self function_17f8d14c("powerup_grabbed_fx", var_f79dc259);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xe820eaa3, Offset: 0x5718
// Size: 0x4c
function function_c54c18db() {
    if (!isdefined(self)) {
        return;
    }
    var_f79dc259 = self function_5f4de70e();
    self function_17f8d14c("powerup_intro_fx", var_f79dc259);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x540540a, Offset: 0x5770
// Size: 0x4c
function function_2778c01b() {
    if (!isdefined(self)) {
        return;
    }
    var_f79dc259 = self function_5f4de70e();
    self function_17f8d14c("powerup_fx", var_f79dc259);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x4
// Checksum 0x5f03d048, Offset: 0x57c8
// Size: 0x86
function private function_5f4de70e() {
    if (self.only_affects_grabber) {
        if (self.powerup_name === #"bonus_points_player" || self.powerup_name === #"bonus_points_player_shared") {
            return 4;
        } else {
            return 2;
        }
        return;
    }
    if (self.any_team) {
        return 4;
    }
    if (self.zombie_grabbable) {
        return 3;
    }
    return 1;
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x4
// Checksum 0x36bb2e11, Offset: 0x5858
// Size: 0x2c
function private function_17f8d14c(str_name, n_value) {
    self clientfield::set(str_name, n_value);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x3cb6b528, Offset: 0x5890
// Size: 0x5c
function function_ca407bef() {
    a_ai_zombies = zombie_utility::get_round_enemy_array();
    if (a_ai_zombies.size == 0 && level.zombie_total == 0) {
        return false;
    }
    if (level.var_eaaa1d75.size) {
        return false;
    }
    return true;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x20d31922, Offset: 0x58f8
// Size: 0x20
function function_95fb920d() {
    if (level.round_number <= 10) {
        return false;
    }
    return true;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x808c7513, Offset: 0x5920
// Size: 0xc0
function init_wallbuys() {
    level.func_override_wallbuy_prompt = &function_3d4fea64;
    level.var_db463b5 = &function_7a916f72;
    foreach (s_wallbuy in level._spawned_wallbuys) {
        zm_unitrigger::function_89380dda(s_wallbuy.trigger_stub, 0);
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xe0d8c8a9, Offset: 0x59e8
// Size: 0x2c
function function_7adb4617() {
    zm_utility::add_zombie_hint("default_buy_debris", #"hash_4871b118fb4dfd6b");
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0xe9c56b98, Offset: 0x5a20
// Size: 0x62
function function_2b580cd4(var_e5fb46a8, str_name) {
    if (!isdefined(var_e5fb46a8.var_bde53893)) {
        return false;
    } else if (!isdefined(var_e5fb46a8.var_bde53893[str_name])) {
        return false;
    } else if (gettime() >= var_e5fb46a8.var_bde53893[str_name]) {
        return false;
    }
    return true;
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0x3d9d437b, Offset: 0x5a90
// Size: 0x44
function function_37fe3e07(e_player, var_957235ca) {
    return function_2b580cd4(e_player, var_957235ca) || function_2b580cd4(level, var_957235ca);
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x27e37c81, Offset: 0x5ae0
// Size: 0x9c
function function_127f0ac5(e_player) {
    n_cooldown = function_3e1c5dad(e_player, "default_treasure_chest");
    if (n_cooldown > 0) {
        self.hint_string = undefined;
        e_player.var_838c00de = 1;
        self sethintstringforplayer(e_player, #"zombie/wallbuy_cooldown", n_cooldown);
        return true;
    } else {
        e_player.var_838c00de = undefined;
    }
    return false;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x34d23c34, Offset: 0x5b88
// Size: 0x34
function function_d679a241(player) {
    function_51e47b48(player, #"crafting_table", 120000);
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0xa9faa108, Offset: 0x5bc8
// Size: 0x44
function function_36f1c05b(e_player, var_29827302) {
    return function_2b580cd4(e_player, var_29827302) || function_2b580cd4(level, var_29827302);
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x6e6d83a9, Offset: 0x5c18
// Size: 0x232
function function_75ebd926(e_player) {
    n_cooldown = function_3e1c5dad(e_player, "crafting_table");
    if (n_cooldown > 0) {
        self.hint_string = #"zombie/wallbuy_cooldown";
        self.cost = n_cooldown;
        return true;
    } else if (is_true(self.blueprint.var_54a97edd.isriotshield) && isdefined(e_player.player_shield_reset_health) && is_true(e_player.var_d3345483) || !e_player zm_crafting::function_2d53738e(self.blueprint.var_54a97edd) && (is_true(self.blueprint.var_c028dcfe) && !e_player zm_crafting::function_48ce9379(self.blueprint.var_54a97edd) || is_true(level.var_905507c3))) {
        if (e_player function_8b1a219a()) {
            self.hint_string = isdefined(self.blueprint.var_abd9b2d0) ? self.blueprint.var_abd9b2d0 : #"hash_40987a3e6d86b097";
        } else {
            self.hint_string = isdefined(self.blueprint.var_abd9b2d0) ? self.blueprint.var_abd9b2d0 : #"hash_6573f011f996ab09";
        }
        self.cost = undefined;
        return true;
    } else {
        self.hint_string = #"hash_53fd856df9288be7";
        self.cost = undefined;
        return true;
    }
    return false;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xcf035f89, Offset: 0x5e58
// Size: 0x2c
function function_7a916f72(e_player) {
    function_51e47b48(e_player, self.clientfieldname, 0);
}

// Namespace zstandard/zstandard
// Params 3, eflags: 0x0
// Checksum 0xf9721bc, Offset: 0x5e90
// Size: 0x4c
function function_51e47b48(var_e5fb46a8, str_name, n_time_ms) {
    if (!isdefined(var_e5fb46a8.var_bde53893)) {
        var_e5fb46a8.var_bde53893 = [];
    }
    var_e5fb46a8.var_bde53893[str_name] = gettime() + n_time_ms;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xbe85d151, Offset: 0x5ee8
// Size: 0x84
function function_51ed4d8b(e_player) {
    if (is_true(e_player zombie_utility::function_73061b82(#"zombie_powerup_fire_sale_on"))) {
        function_51e47b48(e_player, "default_treasure_chest", 0);
        return;
    }
    function_51e47b48(e_player, "default_treasure_chest", 30000);
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0xbca966e7, Offset: 0x5f78
// Size: 0x86
function function_3e1c5dad(var_e5fb46a8, str_name) {
    if (isdefined(var_e5fb46a8.var_bde53893) && isdefined(var_e5fb46a8.var_bde53893[str_name])) {
        n_current_time = gettime();
        if (n_current_time < var_e5fb46a8.var_bde53893[str_name]) {
            return int((var_e5fb46a8.var_bde53893[str_name] - n_current_time) / 1000);
        }
    }
    return 0;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xb2f52872, Offset: 0x6008
// Size: 0x2c
function function_cded672a(str_perk) {
    return level._custom_perks[str_perk].hint_string + "_FREE";
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0x27779593, Offset: 0x6040
// Size: 0x1fc
function function_3d4fea64(e_player, player_has_weapon) {
    var_f84749aa = function_3e1c5dad(e_player, self.clientfieldname);
    var_f1d1c3e6 = function_3e1c5dad(level, self.clientfieldname);
    var_897c4321 = int(max(var_f84749aa, var_f1d1c3e6));
    if (var_897c4321 > 0) {
        self sethintstringforplayer(e_player, #"zombie/wallbuy_cooldown", var_897c4321);
        return true;
    } else if (player_has_weapon) {
        if (self.stub.weapon !== getweapon("bowie_knife")) {
            if (e_player function_8b1a219a()) {
                self sethintstringforplayer(e_player, #"hash_39d6b1ad0b94f111");
            } else {
                self sethintstringforplayer(e_player, #"hash_1ee18bf56df7a29b");
            }
            return true;
        }
    } else {
        if (e_player function_8b1a219a()) {
            self sethintstringforplayer(e_player, #"hash_124b395fc222642b");
        } else {
            self sethintstringforplayer(e_player, #"hash_3d1e4f7ac23674b5");
        }
        return true;
    }
    return false;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xb5b2a279, Offset: 0x6248
// Size: 0x1a0
function function_7acf9d9b(e_door) {
    if (zm_utility::function_e37823df() && zm_utility::function_5f8f4d1b(e_door) && !is_true(e_door.var_c947f134)) {
        zm_utility::function_1409b164();
        level notify(#"hash_4ffec9c5f552e6fc", {#e_door:e_door});
        playsoundatposition(#"hash_27dc220231c7b8b3", e_door.origin);
        return 1;
    }
    if (self == e_door && !is_true(e_door.var_c947f134)) {
        return 1;
    }
    zm_utility::play_sound_at_pos("no_purchase", e_door.origin);
    return 0;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xc434dc78, Offset: 0x63f0
// Size: 0x274
function function_b8839207(e_door) {
    e_door endon(#"death");
    if (zm_utility::function_e37823df() && e_door.script_noteworthy !== "electric_door" && e_door.script_noteworthy !== "electric_buyable_door" && !is_true(e_door.var_c947f134)) {
        while (true) {
            if (zm_utility::function_5f8f4d1b(e_door)) {
                e_door sethintstring(#"hash_7960cdc72d34a2db");
            } else {
                e_door sethintstring(#"");
            }
            waitframe(1);
        }
        return;
    }
    if (e_door.script_noteworthy === "electric_door" || e_door.script_noteworthy === "electric_buyable_door" || is_true(e_door.var_c947f134)) {
        if (isdefined(level.var_d5bd7049)) {
            e_door sethintstring(level.var_d5bd7049);
        } else if (zm_utility::get_story() == 1) {
            e_door sethintstring(#"zombie/need_power");
        } else {
            e_door sethintstring(#"hash_3dc033ef1e67a5c0");
        }
        return;
    }
    var_7c804894 = function_6a326935(e_door.target);
    if (isdefined(var_7c804894) && !e_door zm_utility::function_1a4d2910()) {
        e_door sethintstring(#"hash_5253833fcb69e672", var_7c804894);
        return;
    }
    e_door sethintstring(#"hash_17758d1de3b1fe6a");
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x19cbc58, Offset: 0x6670
// Size: 0xf4
function function_f6a30a49(n_round) {
    var_dbb764cd = n_round + 1;
    if (isdefined(level.var_5c3c0b68[var_dbb764cd])) {
        foreach (var_4cf63d49 in level.var_5c3c0b68[var_dbb764cd]) {
            zm_utility::open_door(var_4cf63d49);
        }
        if (n_round == level.round_number) {
            level zm_utility::function_7a35b1d7(#"hash_594b38c1356d221a");
        }
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x52be0f73, Offset: 0x6770
// Size: 0x10c
function function_6a326935(str_door_name) {
    if (isdefined(level.var_5c3c0b68)) {
        foreach (index, var_8048fc3c in level.var_5c3c0b68) {
            foreach (var_4cf63d49 in var_8048fc3c) {
                if (var_4cf63d49 == str_door_name) {
                    return index;
                }
            }
        }
    }
    return undefined;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xe71e89bb, Offset: 0x6888
// Size: 0x1c
function onprecachegametype() {
    level.canplayersuicide = &zm_gametype::canplayersuicide;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x401bf2b2, Offset: 0x68b0
// Size: 0x1fc
function onstartgametype() {
    zm_behavior::function_70a657d8();
    zm_cleanup::function_70a657d8();
    zm_spawner::init();
    zm_behavior::postinit();
    zm_cleanup::postinit();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    structs = struct::get_array("player_respawn_point", "targetname");
    foreach (struct in structs) {
        level.spawnmins = math::expand_mins(level.spawnmins, struct.origin);
        level.spawnmaxs = math::expand_maxs(level.spawnmaxs, struct.origin);
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    level.bgb[#"zm_bgb_near_death_experience"] = undefined;
    level.bgb[#"zm_bgb_phoenix_up"] = undefined;
    init_powerups();
    changeadvertisedstatus(0);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xbe7af1ae, Offset: 0x6ab8
// Size: 0xa4
function function_6eeac3e() {
    level.var_28bbd30a = 1;
    level.var_5b7d2700 = 1;
    callback::on_spawned(&function_dcba938b);
    callback::on_laststand(&function_3166e32b);
    callback::on_revived(&function_3928d86);
    callback::on_connect(&function_9c069101);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x44815262, Offset: 0x6b68
// Size: 0x64
function function_9c069101() {
    if (level flag::get("start_zombie_round_logic")) {
        self thread function_31094dd(1);
        self thread zm_equipment::show_hint_text(#"hash_7ec10e89f0ae5fc4", 4);
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xef69d7df, Offset: 0x6bd8
// Size: 0x12a
function function_dcba938b() {
    self endon(#"disconnect");
    if (!isdefined(self.var_4a24e8f0)) {
        self.var_4a24e8f0 = 0;
    }
    level flag::wait_till("start_zombie_round_logic");
    waitframe(1);
    switch (self.var_4a24e8f0) {
    case 0:
        self zm_laststand::function_3d685b5f(level.numlives);
        break;
    case 1:
        self zm_laststand::function_3d685b5f(1);
        self thread function_9850b18();
        break;
    default:
        self zm_laststand::function_3d685b5f(0);
        self thread function_9850b18();
        break;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x98b56dc5, Offset: 0x6d10
// Size: 0x2d4
function function_3166e32b() {
    self endoncallback(&function_8cc789b2, #"disconnect");
    waitframe(1);
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".playerIsDowned", 1);
    self function_10c7411b();
    self playsoundtoplayer(#"hash_5e980fdf2497d9a1", self);
    if (zm_laststand::function_618fd37e() > 0) {
        level thread zm_audio::sndannouncerplayvox(#"player_down", self);
        zm_utility::function_3e549e65();
        self.var_d6229296 = 1;
        self zm_laststand::function_409dc98e();
        if (!level.var_b9f167ba self_revive_visuals_rush::is_open(self)) {
            level.var_b9f167ba self_revive_visuals_rush::open(self);
            for (i = 0; i < 5; i++) {
                level.var_b9f167ba self_revive_visuals_rush::set_revive_time(self, 5 - i);
                wait 1;
            }
        }
        self playsoundtoplayer(#"hash_1526662237d7780f", self);
        self zm_laststand::auto_revive();
        if (level.var_b9f167ba self_revive_visuals_rush::is_open(self)) {
            level.var_b9f167ba self_revive_visuals_rush::close(self);
        }
        zm_utility::function_b7e5029f();
        self.var_d6229296 = undefined;
        return;
    }
    if (level.players.size > 1 && zm_player::function_3799b373(self)) {
        self thread function_31094dd(0);
    }
    level thread zm_audio::sndannouncerplayvox(#"player_out", self);
    self.var_4a24e8f0++;
    self notify(#"bled_out");
    self globallogic_player::function_b2873ebe();
    self thread function_d8816881();
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xfaca55c2, Offset: 0x6ff0
// Size: 0x3c
function function_8cc789b2(*str_notify) {
    if (is_true(self.var_d6229296)) {
        zm_utility::function_b7e5029f();
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x7304bb67, Offset: 0x7038
// Size: 0x124
function function_d8816881() {
    self zm_laststand::bleed_out();
    level thread zm_utility::play_sound_2d("zmb_rush_plr_dead_stinger");
    if (level.players.size > 1) {
        foreach (player in level.players) {
            if (player.sessionstate === "playing" && !zm_player::function_3799b373(player)) {
                level thread zm_audio::sndannouncerplayvox(#"player_last_man_standing", player, undefined, undefined, 1);
                break;
            }
        }
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xb8eb6c16, Offset: 0x7168
// Size: 0x164
function function_31094dd(var_a8903530 = 0) {
    self notify(#"hash_7ee1d21962bb24f");
    self endoncallback(&function_9438de5c, #"disconnect", #"hash_7ee1d21962bb24f");
    level endoncallback(&function_9438de5c, #"end_game");
    self.var_4d9b2bc3 = 0;
    self notify(#"end_healthregen");
    if (!var_a8903530) {
        return;
    }
    level.var_f5682bb8 thread zm_arcade_timer::function_88df772a(self, 120, #"hash_5e3423d08973905", 1);
    wait 120;
    self notify(#"hash_387bb170e38042d5");
    self zm_player::spectator_respawn_player();
    self clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".playerIsDowned", 0);
    if (isdefined(level.var_9149f3ac)) {
        self zm_utility::function_ac41a624();
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x40ebf10f, Offset: 0x72d8
// Size: 0xe0
function function_9438de5c(*var_c34665fc) {
    if (isplayer(self)) {
        level.var_f5682bb8 zm_arcade_timer::function_9bab3960(self);
        return;
    }
    foreach (player in level.players) {
        level.var_f5682bb8 zm_arcade_timer::function_9bab3960(player, 1);
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x7c12e039, Offset: 0x73c0
// Size: 0x216
function function_9850b18() {
    self endon(#"disconnect");
    level endoncallback(&function_4faf4020, #"end_game");
    if (is_true(level.host_ended_game)) {
        return;
    }
    self thread function_ae6cb441();
    self thread function_a76ea907();
    self val::set("zm_arcade", "takedamage", 0);
    self val::set("zm_arcade", "ignoreme", 1);
    self.var_800f306a = 1;
    self clientfield::set_to_player("" + #"hash_321b58d22755af74", 1);
    self playsound(#"zmb_bgb_plainsight_start");
    self playloopsound(#"zmb_bgb_plainsight_loop", 1);
    wait 6;
    self stoploopsound(1);
    self playsound(#"zmb_bgb_plainsight_end");
    self clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);
    self val::reset("zm_arcade", "takedamage");
    self val::reset("zm_arcade", "ignoreme");
    self.var_800f306a = undefined;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xf51ffcb8, Offset: 0x75e0
// Size: 0xf2
function function_4faf4020(*str_notify) {
    foreach (player in level.players) {
        if (is_true(player.var_800f306a)) {
            player clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);
            player stoploopsound(1);
            player.var_800f306a = undefined;
        }
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xda0bc61, Offset: 0x76e0
// Size: 0xdc
function function_ae6cb441() {
    self endon(#"disconnect");
    level endon(#"end_game");
    wait 0.25;
    w_current = self getcurrentweapon();
    n_stock_size = self getweaponammostock(w_current);
    n_clip_size = self getweaponammoclipsize(w_current);
    if (n_stock_size <= 0) {
        if (self hasweapon(w_current)) {
            self setweaponammoclip(w_current, n_clip_size);
        }
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xe90a645c, Offset: 0x77c8
// Size: 0xa4
function function_a76ea907() {
    a_ai_targets = getaispeciesarray(level.zombie_team, "all");
    a_ai_targets = arraysortclosest(a_ai_targets, self.origin, a_ai_targets.size, 0, 160);
    function_1eaaceab(a_ai_targets);
    arrayremovevalue(a_ai_targets, undefined);
    array::thread_all(a_ai_targets, &zm_hero_weapon::function_c2dea172, self);
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xdc3a3c01, Offset: 0x7878
// Size: 0x64
function function_3928d86(*params) {
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".playerIsDowned", 0);
    if (zm_laststand::function_618fd37e() >= 0) {
        self thread function_9850b18();
    }
}

/#

    // Namespace zstandard/zstandard
    // Params 0, eflags: 0x0
    // Checksum 0x1eb1e131, Offset: 0x78e8
    // Size: 0xbe
    function function_ec53cb2c() {
        level notify(#"hash_4bbfbbe6ad7c9dab");
        level endon(#"end_game", #"hash_4bbfbbe6ad7c9dab");
        if (!getdvarint(#"hash_5ae4497e02612bde", 1)) {
            return;
        }
        while (true) {
            debug2dtext((8, 250, 0), "<dev string:x2ed>" + level.round_number, undefined, undefined, undefined, 1);
            waitframe(1);
        }
    }

#/

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x1b7440b4, Offset: 0x79b0
// Size: 0xa62
function function_21669ebc(restart = 0) {
    println("<dev string:x308>");
    level endon(#"end_round_think");
    if (!is_true(restart)) {
        if (isdefined(level.var_12e11406)) {
            [[ level.var_12e11406 ]]();
        }
        if (!is_true(level.host_ended_game)) {
            players = getplayers();
            foreach (player in players) {
                player zm_stats::set_global_stat("rounds", level.round_number);
            }
        }
    }
    setroundsplayed(level.round_number);
    level.var_21e22beb = gettime();
    while (true) {
        zombie_utility::set_zombie_var("rebuild_barrier_cap_per_round", min(500, 50 * level.round_number));
        level.pro_tips_start_time = gettime();
        level.zombie_last_run_time = gettime();
        callback::callback(#"hash_6df5348c2fb9a509");
        /#
            level thread function_ec53cb2c();
        #/
        if (isdefined(level.var_fc735431)) {
            level thread zm_audio::function_4138a262();
            [[ level.var_fc735431 ]]();
        } else {
            level thread zm_audio::function_4138a262();
            zm_round_logic::round_one_up();
        }
        zm_powerups::powerup_round_start();
        players = getplayers();
        array::thread_all(players, &zm_blockers::rebuild_barrier_reward_reset);
        if (!is_true(level.headshots_only) && !restart) {
            level thread zm_round_logic::award_grenades_for_survivors();
        }
        println("<dev string:x323>" + level.round_number + "<dev string:x340>" + players.size);
        level.round_start_time = gettime();
        while (level.zm_loc_types[#"zombie_location"].size <= 0) {
            wait 0.1;
        }
        /#
            zkeys = getarraykeys(level.zones);
            for (i = 0; i < zkeys.size; i++) {
                zonename = zkeys[i];
                level.zones[zonename].round_spawn_count = 0;
            }
        #/
        if (!is_true(level.var_ab84adee)) {
            level thread zm_round_logic::round_timeout();
        }
        level thread [[ level.round_spawn_func ]]();
        level notify(#"start_of_round", {#n_round_number:level.round_number});
        recordnumzombierounds(level.round_number - 1);
        recordzombieroundstart();
        bb::logroundevent("start_of_round");
        players = getplayers();
        for (index = 0; index < players.size; index++) {
            players[index] zm_round_logic::recordroundstartstats();
        }
        if (isdefined(level.round_start_custom_func)) {
            [[ level.round_start_custom_func ]]();
        }
        var_ecdf38f = isdefined(level.var_ecdf38f) ? level.var_ecdf38f : 15;
        if (level.round_number == var_ecdf38f) {
            zm_powerups::powerup_remove_from_regular_drops("nuke");
        }
        var_55e562f9 = isdefined(level.var_55e562f9) ? level.var_55e562f9 : 20;
        if (level.round_number == var_55e562f9) {
            level.var_57352595 = 1;
            zm_powerups::powerup_remove_from_regular_drops("full_ammo");
        }
        [[ level.round_wait_func ]]();
        if (!function_5a2c9b1c(level.round_number) && zm_utility::function_e12de7f5(level.round_number) || function_77ee3cd2(level.round_number)) {
            if (!level flag::get("started_defend_area")) {
                util::playsoundonplayers(#"hash_2d1265adbba422cf");
            }
        }
        level thread zm_audio::function_d0f5602a();
        level.first_round = 0;
        callback::callback(#"on_round_end");
        level notify(#"end_of_round");
        bb::logroundevent("end_of_round");
        uploadstats();
        if (isdefined(level.round_end_custom_logic)) {
            [[ level.round_end_custom_logic ]]();
        }
        if (zm_custom::function_901b751c(#"zmroundcap") == level.round_number && level.round_number != 0) {
            level.var_458eec65 = 1;
            wait 3;
            zm_custom::function_9be9c072(#"zmroundcap");
            return;
        }
        if (int(level.round_number / 5) * 5 == level.round_number) {
            level clientfield::set("round_complete_time", int((level.time - level.n_gameplay_start_time + 500) / 1000));
            level clientfield::set("round_complete_num", level.round_number);
        }
        zm_round_logic::set_round_number(1 + zm_round_logic::get_round_number());
        setroundsplayed(zm_round_logic::get_round_number());
        for (n_round = 1; n_round <= level.round_number; n_round++) {
            if (zm_utility::function_e37823df()) {
                continue;
            }
            function_f6a30a49(n_round);
        }
        zombie_utility::set_zombie_var("zombie_spawn_delay", [[ level.func_get_zombie_spawn_delay ]](zm_round_logic::get_round_number()));
        matchutctime = getutc();
        foreach (player in level.players) {
            player zm_stats::update_playing_utc_time(matchutctime);
            player zm_stats::function_4dd876ad();
            player zm_utility::set_max_health(1);
            for (i = 0; i < 4; i++) {
                player.number_revives_per_round[i] = 0;
            }
        }
        level.round_number = zm_round_logic::get_round_number();
        level zm_round_logic::round_over();
        level notify(#"between_round_over");
        restart = 0;
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x8aefd1dd, Offset: 0x8420
// Size: 0x306
function function_cab8ebff(var_5707265b = 120) {
    level endon(#"restart_round");
    /#
        level endon(#"kill_round");
        if (getdvarint(#"zombie_rise_test", 0)) {
            level waittill(#"forever");
        }
    #/
    if (zm::cheat_enabled(2)) {
        level waittill(#"forever");
    }
    /#
        if (getdvarint(#"zombie_default_max", 0) == 0) {
            level waittill(#"forever");
        }
    #/
    /#
        if (getdvarint(#"hash_1f243f823e1838d4", 0)) {
            var_5707265b = getdvarint(#"hash_1f243f823e1838d4", 0);
        }
    #/
    wait 1;
    /#
        level thread zm_round_logic::print_zombie_counts();
        level thread zm_round_logic::sndmusiconkillround();
    #/
    var_fcf7225b = gettime();
    while (true) {
        if (function_5a2c9b1c(level.round_number)) {
            var_7e5b8365 = function_77ee3cd2(level.round_number) && zombie_utility::get_current_zombie_count() > 0 || level.zombie_total > 0 || level.intermission;
        } else {
            var_7e5b8365 = zombie_utility::get_current_zombie_count() > 0 || level.zombie_total > 0 || level.intermission;
        }
        /#
            if (getdvarint(#"hash_19d726be121cfa2", 0)) {
                var_7e5b8365 = var_7e5b8365 && gettime() - var_fcf7225b < var_5707265b;
            }
        #/
        if ((!var_7e5b8365 || level flag::get("end_round_wait")) && !level flag::get(#"infinite_round_spawning")) {
            return;
        }
        wait 1;
    }
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0x81cfc32b, Offset: 0x8730
// Size: 0xcc
function get_zombie_count_for_round(n_round, n_player_count) {
    if (!isdefined(level.var_ea47b206) || !isdefined(level.var_ea47b206[n_round]) || !isdefined(level.var_ea47b206[n_round].n_count_total)) {
        return -1;
    }
    n_count_total = level.var_ea47b206[n_round].n_count_total;
    return n_count_total + int(ceil(n_count_total * 0.1 * (n_player_count - 1)));
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0x41d2df7c, Offset: 0x8808
// Size: 0x76
function function_1687c93(n_round, *n_player_count) {
    if (!isdefined(level.var_ea47b206) || !isdefined(level.var_ea47b206[n_player_count]) || !isdefined(level.var_ea47b206[n_player_count].var_4f886dd2)) {
        return -1;
    }
    return level.var_ea47b206[n_player_count].var_4f886dd2;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x40933b93, Offset: 0x8888
// Size: 0xe8
function function_399fa32() {
    if (!isdefined(level.var_f944d22e) || !isdefined(level.var_f944d22e[level.round_number])) {
        return;
    }
    foreach (archetype, s_data in level.var_f944d22e[level.round_number]) {
        if (archetype == #"zombie") {
            continue;
        }
        s_data thread function_f26f8251(archetype, level.players.size);
    }
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0x844347d4, Offset: 0x8978
// Size: 0x1ac
function function_f26f8251(str_archetype, n_player_count) {
    level endon(#"end_game");
    n_count_total = self.n_count_total;
    if (n_player_count > 2) {
        n_count_total += int(ceil(n_count_total / 2));
    }
    for (i = 0; i < n_count_total; i++) {
        if (i == 0 && isdefined(self.var_37dc6df8)) {
            wait self.var_37dc6df8;
        }
        ai = undefined;
        while (!isdefined(ai)) {
            if (isdefined(self.var_8857c54d)) {
                ai = [[ self.var_8857c54d ]]();
            } else {
                zm_transform::function_bdd8aba6(str_archetype);
                s_waitresult = level waittill(#"transformation_complete");
                if (s_waitresult.id === str_archetype) {
                    ai = s_waitresult.var_944250d2[0];
                }
            }
            waitframe(1);
        }
        zm_utility::function_9b7bc715(str_archetype);
        if (isdefined(self.var_d58fab26)) {
            [[ self.var_d58fab26 ]]();
            continue;
        }
        util::wait_network_frame();
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x7189ca47, Offset: 0x8b30
// Size: 0xc0
function function_71e054d7() {
    self endon(#"disconnect");
    while (true) {
        s_waitresult = self waittill(#"perk_bought");
        if (isdefined(s_waitresult.var_16c042b8) && isdefined(level.zmannouncervox[s_waitresult.var_16c042b8])) {
            level thread zm_audio::sndannouncerplayvox(s_waitresult.var_16c042b8, self);
            continue;
        }
        level thread zm_audio::sndannouncerplayvox(#"perk_generic", self);
    }
}

