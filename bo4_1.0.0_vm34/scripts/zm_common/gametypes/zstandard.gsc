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
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_blockers;
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
// Checksum 0xaa6d5f22, Offset: 0x868
// Size: 0x6dc
function event_handler[gametype_init] main(eventstruct) {
    level.var_49197edc = zm_arcade_timer::register("zm_arcade_timer");
    level.var_bb57ff69 = zm_trial_timer::register("zm_trial_timer");
    level.var_6be65be5 = self_revive_visuals_rush::register("self_revive_visuals_rush");
    level.var_4737fa66 = [];
    level.var_ce8d9a15 = [];
    level.var_e53747c = gettime();
    callback::on_connect(&function_437f1e79);
    level flag::init("started_defend_area");
    zm_gametype::main();
    level.var_c4c4e7fb = 1;
    level.var_c8913274 = 0.5;
    level.var_1964f528 = 1.5;
    level.var_fd891dd9 = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level._game_module_custom_spawn_init_func = &zm_gametype::custom_spawn_init_func;
    level._game_module_stat_update_func = &zm_stats::survival_classic_custom_stat_update;
    level._round_start_func = &zm_round_logic::round_start;
    level.round_wait_func = &function_c8e64acb;
    level.round_think_func = &function_a9647030;
    level.round_start_custom_func = &function_920f9dd8;
    level.zombie_round_start_delay = 0;
    level.var_164af731 = &function_56967d2c;
    level.var_b43e213c = "run";
    level.var_1c2b792c = 1;
    level.var_b18a7d0 = &get_zombie_count_for_round;
    level.var_ff2185d3 = &function_fc0e3ee8;
    level.custom_door_buy_check = &function_cc59049e;
    level.var_b3ebdf6e = &function_cc59049e;
    level.var_de91b1b0 = &function_2008b9aa;
    level.var_20a032a1 = &function_2008b9aa;
    level.var_25f9107f = &function_2008b9aa;
    level.var_888148a6 = &function_640516ce;
    level.var_89df9d75 = &function_e269075d;
    level.var_f5d2de23 = &function_375d4f38;
    level.func_magicbox_update_prompt_use_override = &function_1789a55d;
    level.custom_generic_deny_vo_func = &function_4a022518;
    level.var_a3406d4 = &set_revive_count;
    level.var_444d6418 = 1;
    level.local_doors_stay_open = 1;
    level.var_690a4ac9 = 1;
    util::registernumlives(1, 100);
    function_b43ef6c6();
    level.var_c6562dd4 = [];
    level.var_63bc59b1 = 1;
    level.var_cc46bee = 1;
    level.var_467f35c8 = 1;
    level.var_5e6d7e5 = "zm_base_difficulty_zstandard";
    level.var_b71e6033 = 1;
    level.var_9f315b82 = 1;
    level.var_7cbb06a0 = 1;
    level.var_c8a9f67f = 1;
    level.player_starting_points = 0;
    level.var_481b1dce = 1;
    level.var_8602370c = [];
    level.var_af8efa7 = 1;
    zm_vo::function_1a6f1ed1(&function_6a74c3eb);
    for (i = 0; i < 4; i++) {
        clientfield::register("worlduimodel", "PlayerList.client" + i + ".playerIsDowned", 1, 1, "int");
        clientfield::register("worlduimodel", "PlayerList.client" + i + ".multiplier_count", 1, 8, "int");
        clientfield::register("worlduimodel", "PlayerList.client" + i + ".multiplier_blink", 1, 1, "int");
        clientfield::register("worlduimodel", "PlayerList.client" + i + ".self_revives", 1, 8, "int");
    }
    init_elixirs();
    init_talismans();
    init_pack_a_punch();
    init_magicbox();
    function_fb038b59();
    level thread function_d983e31c();
    thread function_b8a13674();
    callback::on_finalize_initialization(&finalize_clientfields);
    level._supress_survived_screen = 1;
    setscoreboardcolumns("score", "kills", "downs", "highest_multiplier", "headshots");
    /#
        level thread function_825a546e();
    #/
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x4
// Checksum 0x2261b469, Offset: 0xf50
// Size: 0x74
function private finalize_clientfields() {
    clientfield::register("toplayer", "zm_trials_timer", 1, getminbitcountfornum(300), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.gameStartTime", 1, 31, "int");
}

/#

    // Namespace zstandard/zstandard
    // Params 0, eflags: 0x0
    // Checksum 0xda81f2ab, Offset: 0xfd0
    // Size: 0x8c
    function function_825a546e() {
        zm_devgui::add_custom_devgui_callback(&function_3e888b38);
        adddebugcommand("<dev string:x30>");
        adddebugcommand("<dev string:x80>");
        adddebugcommand("<dev string:xd3>");
        adddebugcommand("<dev string:x118>");
    }

    // Namespace zstandard/zstandard
    // Params 1, eflags: 0x0
    // Checksum 0x723b39a0, Offset: 0x1068
    // Size: 0x1ca
    function function_3e888b38(cmd) {
        switch (cmd) {
        case #"hash_196a879b48e37805":
            if (zm_utility::function_587070e3()) {
                zm_utility::drop_key(level.players[0].origin);
            }
            break;
        case #"hash_2dd0872d741b071e":
            zm_devgui::zombie_devgui_give_powerup("<dev string:x174>", undefined, level.players[0].origin);
            break;
        case #"hash_745ce03c49ed332a":
            for (i = 0; i < 10; i++) {
                zm_devgui::zombie_devgui_give_powerup("<dev string:x174>", undefined, level.players[0].origin);
            }
            break;
        case #"hash_2a785bbd314ac393":
            if (isarray(level.var_ce8d9a15) && level.var_ce8d9a15.size) {
                iprintlnbold("<dev string:x188>" + level.var_ce8d9a15[0].origin);
                level.players[0] setorigin(level.var_ce8d9a15[0].origin);
            }
            break;
        default:
            break;
        }
    }

#/

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1240
// Size: 0x4
function function_6a74c3eb() {
    
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1250
// Size: 0x4
function init_elixirs() {
    
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1260
// Size: 0x4
function init_talismans() {
    
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x1925190d, Offset: 0x1270
// Size: 0xe8
function function_d983e31c() {
    level waittill(#"start_of_round");
    level waittill(#"start_of_round");
    var_3ff6b3bb = struct::get_array("s_bonus_point_locations", "script_noteworthy");
    var_3ff6b3bb = array::randomize(var_3ff6b3bb);
    foreach (s_loc in var_3ff6b3bb) {
        s_loc thread function_f669351e();
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x2fb0bf2f, Offset: 0x1360
// Size: 0x162
function function_f669351e() {
    if (isdefined(self.script_flag_wait)) {
        a_str_flags = util::create_flags_and_return_tokens(self.script_flag_wait);
        level flag::wait_till_any(a_str_flags);
    }
    if (isdefined(self.script_delay)) {
        wait self.script_delay;
    }
    if (isdefined(self.script_objective)) {
        wait 3;
        n_obj_id = gameobjects::get_next_obj_id();
        objective_add(n_obj_id, "active", self.origin, self.script_objective);
        function_eeba3a5c(n_obj_id, 1);
    }
    wait 10;
    if (isdefined(n_obj_id)) {
        gameobjects::release_obj_id(n_obj_id);
    }
    if (math::cointoss(75)) {
        wait randomfloatrange(1, 4);
        self.e_powerup = self zm_utility::function_965eb051(self.origin, isdefined(self.b_permanent) && self.b_permanent);
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xa5dd9a30, Offset: 0x14d0
// Size: 0x3a2
function function_ad24da26() {
    zm_hero_weapon::function_97942345("chakram", 50000);
    zm_hero_weapon::function_97942345("hammer", 50000);
    zm_hero_weapon::function_97942345("scepter", 50000);
    zm_hero_weapon::function_97942345("sword_pistol", 50000);
    zm_hero_weapon::function_97942345("gravityspikes", 50000);
    zm_hero_weapon::function_97942345("katana", 50000);
    zm_hero_weapon::function_97942345("minigun", 50000);
    zm_hero_weapon::function_97942345("flamethrower", 50000);
    zm_hero_weapon::function_e1170d9b("chakram", 20000, 20000, 20000);
    zm_hero_weapon::function_e1170d9b("hammer", 20000, 20000, 20000);
    zm_hero_weapon::function_e1170d9b("scepter", 20000, 20000, 20000);
    zm_hero_weapon::function_e1170d9b("sword_pistol", 20000, 20000, 20000);
    zm_hero_weapon::function_e1170d9b("gravityspikes", 20000, 20000, 20000);
    zm_hero_weapon::function_e1170d9b("katana", 20000, 20000, 20000);
    zm_hero_weapon::function_e1170d9b("minigun", 20000, 20000, 20000);
    zm_hero_weapon::function_e1170d9b("flamethrower", 20000, 20000, 20000);
    zm_hero_weapon::function_dceb0db8("chakram", 0, 150000, 300000);
    zm_hero_weapon::function_dceb0db8("hammer", 0, 150000, 300000);
    zm_hero_weapon::function_dceb0db8("scepter", 0, 150000, 300000);
    zm_hero_weapon::function_dceb0db8("sword_pistol", 0, 150000, 300000);
    zm_hero_weapon::function_dceb0db8("gravityspikes", 0, 150000, 300000);
    zm_hero_weapon::function_dceb0db8("katana", 0, 150000, 300000);
    zm_hero_weapon::function_dceb0db8("minigun", 0, 150000, 300000);
    zm_hero_weapon::function_dceb0db8("flamethrower", 0, 150000, 300000);
    level.var_12d4e9a9 = 1;
    level.var_3aa3170c = 1;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xf69aa7bb, Offset: 0x1880
// Size: 0x9c
function function_fb038b59() {
    callback::on_ai_killed(&function_6ff1e490);
    callback::on_ai_damage(&function_9f791904);
    level.var_6598035f = 0;
    level.bonus_points_powerup_override = &bonus_points_powerup_override;
    level thread function_5e8b84d4();
    level thread function_925bfe8();
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x1e513f7d, Offset: 0x1928
// Size: 0x536
function function_925bfe8() {
    level endon(#"end_game");
    waittillframeend();
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        if (level.players.size == 1) {
            wait 7;
            continue;
        }
        level.var_d1e37fc5 = [];
        foreach (player in level.players) {
            if (!isdefined(level.var_d1e37fc5)) {
                level.var_d1e37fc5 = [];
            } else if (!isarray(level.var_d1e37fc5)) {
                level.var_d1e37fc5 = array(level.var_d1e37fc5);
            }
            level.var_d1e37fc5[level.var_d1e37fc5.size] = player.score;
            if (!isdefined(player.var_fc7423eb)) {
                player.var_fc7423eb = 1;
            }
        }
        level.var_d1e37fc5 = array::sort_by_value(level.var_d1e37fc5);
        var_94be8175 = 1;
        var_e0ee1e68 = undefined;
        foreach (var_2ce944e0 in level.var_d1e37fc5) {
            if (!isdefined(var_e0ee1e68)) {
                var_e0ee1e68 = var_2ce944e0;
            }
            if (var_2ce944e0 != var_e0ee1e68) {
                var_94be8175++;
            } else {
                continue;
            }
            foreach (player in level.players) {
                if (player.score == var_2ce944e0) {
                    player.var_562a8ba3 = player.var_fc7423eb;
                    player.var_fc7423eb = var_94be8175;
                } else {
                    continue;
                }
                if (player.score > 0 && player.var_fc7423eb != player.var_562a8ba3) {
                    if (player.var_fc7423eb == 1) {
                        level thread zm_audio::sndannouncerplayvox("lead_gained", player);
                        continue;
                    }
                    if (player.var_562a8ba3 == 1) {
                        level thread zm_audio::sndannouncerplayvox("lead_lost", player);
                        continue;
                    }
                    if (level.players.size > 2 && player.var_562a8ba3 > 2 && player.var_fc7423eb == 2) {
                        level thread zm_audio::sndannouncerplayvox("second_place_gained", player);
                        continue;
                    }
                    if (level.players.size > 3 && player.var_562a8ba3 > 3 && player.var_fc7423eb == 3) {
                        level thread zm_audio::sndannouncerplayvox("third_place_gained", player);
                        continue;
                    }
                    if (level.players.size > 3 && player.var_562a8ba3 < 3 && player.var_fc7423eb == 3) {
                        level thread zm_audio::sndannouncerplayvox("dropped_to_third_place", player);
                        continue;
                    }
                    if (level.players.size > 2 && player.var_fc7423eb == level.players.size) {
                        level thread zm_audio::sndannouncerplayvox("dropped_to_last_place", player);
                    }
                }
            }
        }
        wait 7;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x80675331, Offset: 0x1e68
// Size: 0x368
function function_5e8b84d4() {
    level endon(#"end_game");
    waittillframeend();
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        if (level.players.size == 1) {
            waitframe(1);
            continue;
        }
        switch (level.players.size) {
        case 2:
            var_7203bb79 = 0.8;
            var_37e93945 = 0.7;
            var_c23aa47d = 0.6;
            var_bb373fb6 = 0.25;
            break;
        case 3:
            var_7203bb79 = 0.6;
            var_37e93945 = 0.5;
            var_c23aa47d = 0.4;
            var_bb373fb6 = 0.2;
            break;
        case 4:
        default:
            var_7203bb79 = 0.5;
            var_37e93945 = 0.4;
            var_c23aa47d = 0.3;
            var_bb373fb6 = 0.1;
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
                player.var_4a4b35fa = player.score_total / level.score_total;
            }
            if (player.var_4a4b35fa >= var_7203bb79) {
                player.var_d8b9e02e = 0.01;
                player.var_fd5e74b9 = 15 - 11.25;
            } else if (player.var_4a4b35fa >= var_37e93945) {
                player.var_d8b9e02e = 0.00875;
                player.var_fd5e74b9 = 15 - 7.5;
            } else if (player.var_4a4b35fa >= var_c23aa47d) {
                player.var_d8b9e02e = 0.0075;
                player.var_fd5e74b9 = 15 - 3.75;
            }
            if (player.var_4a4b35fa <= var_bb373fb6) {
            }
            if (player.var_fd5e74b9 <= 5) {
                player.var_fd5e74b9 = 6;
            }
        }
        wait 1;
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x5914a9c8, Offset: 0x21d8
// Size: 0x28
function bonus_points_powerup_override(player) {
    player function_a13a4362();
    return 50;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x9fe0ebb8, Offset: 0x2208
// Size: 0x20c
function function_9f791904(params) {
    if (!isdefined(self.maxhealth)) {
        /#
            iprintlnbold(self.archetype + "<dev string:x19b>");
        #/
        self.maxhealth = self.health;
        return;
    }
    if (isalive(self) && isdefined(self.var_29ed62b2) && isplayer(params.eattacker) && params.idamage < self.health) {
        switch (self.var_29ed62b2) {
        case #"heavy":
            var_be76110e = self.maxhealth * 0.33;
            break;
        case #"miniboss":
        case #"boss":
            var_be76110e = self.maxhealth * 0.1;
            break;
        default:
            return;
        }
        if (!isdefined(self.var_b5f846f3)) {
            self.var_b5f846f3 = 0;
        }
        if (!isdefined(self.var_70e61d38)) {
            self.var_70e61d38 = 0;
        }
        self.var_b5f846f3 += params.idamage;
        if (self.var_b5f846f3 >= var_be76110e) {
            self.var_b5f846f3 = 0;
            self.var_70e61d38++;
            level thread zm_utility::function_91e0af39(self.origin, math::clamp(self.var_70e61d38, 1, 3), 700, 1);
        }
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xc71c7e6e, Offset: 0x2420
// Size: 0x414
function function_6ff1e490(params) {
    level.var_6598035f++;
    switch (self.var_29ed62b2) {
    case #"basic":
        if (self.archetype === "catalyst") {
            var_c2ea7d7d = 2;
            playsoundatposition(#"hash_5755957467fab7c0", self.origin);
        }
        break;
    case #"heavy":
        var_c2ea7d7d = 5;
        playsoundatposition(#"hash_57559c7467fac3a5", self.origin);
        break;
    case #"miniboss":
        var_c2ea7d7d = 10;
        playsoundatposition(#"hash_612ef6ccaf0effeb", self.origin);
        break;
    case #"boss":
        var_c2ea7d7d = 15;
        break;
    }
    if (isdefined(var_c2ea7d7d)) {
        level thread zm_utility::function_91e0af39(self.origin, var_c2ea7d7d);
    }
    if (isdefined(params.einflictor) && isplayer(params.einflictor.activated_by_player)) {
        params.einflictor.activated_by_player notify(#"zm_arcade_kill", {#ai_killed:self, #params:params});
        return;
    }
    if (isplayer(params.einflictor)) {
        params.einflictor notify(#"zm_arcade_kill", {#ai_killed:self, #params:params});
        return;
    }
    if (isdefined(params.eattacker) && isplayer(params.eattacker.activated_by_player)) {
        params.eattacker.activated_by_player notify(#"zm_arcade_kill", {#ai_killed:self, #params:params});
        return;
    }
    if (isplayer(params.eattacker)) {
        params.eattacker notify(#"zm_arcade_kill", {#ai_killed:self, #params:params});
        return;
    }
    if (isdefined(self.nuked) && self.nuked) {
        foreach (player in level.activeplayers) {
            if (isarray(player.zombie_nuked) && isinarray(player.zombie_nuked, self)) {
                player notify(#"zm_arcade_kill", {#ai_killed:self, #params:params});
            }
        }
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x4a9bd00a, Offset: 0x2840
// Size: 0xbc
function function_437f1e79() {
    self.var_a528e45c = 0;
    self.var_c8d2079 = 0;
    self.highest_multiplier = 0;
    self.var_4a4b35fa = 0;
    self.var_d8b9e02e = 0.005;
    self.var_fd5e74b9 = 15;
    self.var_a42c73d5 = float(gettime()) / 1000;
    self thread function_27acd143();
    self thread function_9206f9e();
    self thread function_1bcc427b();
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xbe466d5c, Offset: 0x2908
// Size: 0x1f2
function function_a13a4362() {
    if (!isdefined(self.var_a528e45c)) {
        self.var_a528e45c = 0;
    }
    if (!isdefined(self.highest_multiplier)) {
        self.highest_multiplier = 0;
    }
    if (game.state === "postgame") {
        return;
    }
    self.var_a528e45c++;
    self.highest_multiplier = int(max(self.highest_multiplier, self.var_a528e45c + 1) + 0.5);
    self zm_stats::function_d6bca801("HIGHEST_MULTIPLIER", self.highest_multiplier);
    self zm_stats::function_d0a559ef("HIGHEST_MULTIPLIER", self.highest_multiplier);
    self zm_stats::function_366af690("HIGHEST_MULTIPLIER", self.highest_multiplier);
    switch (self.var_a528e45c) {
    case 20:
        n_index = randomintrangeinclusive(0, 4);
        level thread zm_audio::sndannouncerplayvox("multiplier_rising_" + n_index, self);
        break;
    case 50:
    case 75:
    case 100:
    case 125:
    case 150:
        self function_eadb71a3(self.var_a528e45c);
        break;
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xc7198fec, Offset: 0x2b08
// Size: 0x7c
function function_eadb71a3(n_multiplier) {
    var_731bd32 = "b_multiplier_" + n_multiplier;
    if (!(isdefined(self.(var_731bd32)) && self.(var_731bd32))) {
        level thread zm_audio::sndannouncerplayvox("multiplier_" + n_multiplier, self);
        self.(var_731bd32) = 1;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xf5f91a38, Offset: 0x2b90
// Size: 0x2e
function function_814c4bde() {
    self.var_499989d7 = undefined;
    self.var_c86ca500 = undefined;
    self.var_9379f4e1 = undefined;
    self.var_7156346 = undefined;
    self.var_502e0ec2 = undefined;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x8714dbda, Offset: 0x2bc8
// Size: 0x6e8
function function_9206f9e() {
    self endon(#"disconnect");
    level endon(#"end_game");
    str_extra_info = #"hash_4ba6bddb362745d9";
    level waittill(#"start_of_round");
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".multiplier_blink", 0);
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".multiplier_count", self.var_a528e45c + 1);
    while (true) {
        s_waitresult = self waittilltimeout(self.var_fd5e74b9, #"zm_arcade_kill", #"damage", #"bled_out", #"player_downed", #"bonus_points_player_grabbed", #"multiplier_timeout", #"hash_b696fc900429737", #"player_grabbed_key");
        clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".multiplier_blink", 0);
        str_extra_info = #"hash_4ba6bddb362745d9";
        switch (s_waitresult._notify) {
        case #"bonus_points_player_grabbed":
            var_1631c22 = float(gettime()) / 1000 - self.var_a42c73d5;
            self.var_a42c73d5 = float(gettime()) / 1000;
            break;
        case #"player_grabbed_key":
            self function_a13a4362();
            break;
        case #"zm_arcade_kill":
            self function_a13a4362();
            var_1631c22 = float(gettime()) / 1000 - self.var_a42c73d5;
            self.var_a42c73d5 = float(gettime()) / 1000;
            if (zm_utility::is_headshot(s_waitresult.params.weapon, s_waitresult.params.shitloc, s_waitresult.params.smeansofdeath)) {
                self.var_c8d2079++;
            } else if (isdefined(s_waitresult.ai_killed) && !(isdefined(s_waitresult.ai_killed.nuked) && s_waitresult.ai_killed.nuked)) {
                self.var_c8d2079 = 0;
            }
            break;
        case #"timeout":
            if (self.var_a528e45c > 0) {
                self thread function_b33ea761();
            }
            break;
        case #"multiplier_timeout":
        case #"damage":
            if (isdefined(s_waitresult.mod) && s_waitresult.mod != "MOD_FALLING" || s_waitresult._notify == "multiplier_timeout") {
                str_extra_info = #"hash_68f33faa5abddd73";
                if (s_waitresult._notify == "multiplier_timeout" && self.var_a528e45c > 0) {
                    var_5fb2cbac = self.var_a528e45c + 1;
                    if (var_5fb2cbac >= 150) {
                        var_3b6bf3ee = 4 / var_5fb2cbac;
                    } else if (var_5fb2cbac >= 100) {
                        var_3b6bf3ee = 3 / var_5fb2cbac;
                    } else if (var_5fb2cbac >= 50) {
                        var_3b6bf3ee = 2 / var_5fb2cbac;
                    } else {
                        var_3b6bf3ee = 1 / var_5fb2cbac;
                    }
                } else {
                    if (self.var_a528e45c > 0) {
                        zm_custom::function_c5892a26();
                    }
                    var_3b6bf3ee = (isdefined(s_waitresult.amount) ? s_waitresult.amount : 50) * self.var_d8b9e02e;
                    var_3b6bf3ee = math::clamp(var_3b6bf3ee, 0.1, 0.75);
                    if (self.var_a528e45c >= 30 && var_3b6bf3ee >= 0.25) {
                        self playsoundtoplayer(#"hash_d71dba92ab8897c", self);
                    }
                }
                self.var_a528e45c = int(self.var_a528e45c - max(ceil(self.var_a528e45c * var_3b6bf3ee), 1));
                self.var_c8d2079 = 0;
            }
            if (self.var_a528e45c <= 0 || self laststand::player_is_in_laststand()) {
                str_extra_info = #"hash_7b51f2f428fcb3c2";
                self.var_a528e45c = 0;
                self.var_c8d2079 = 0;
            }
            break;
        case #"player_downed":
        case #"bled_out":
            self.var_a528e45c = 0;
            self.var_c8d2079 = 0;
            break;
        default:
            break;
        }
        clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".multiplier_count", self.var_a528e45c + 1);
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xc6b40ec3, Offset: 0x32b8
// Size: 0x188
function function_b33ea761() {
    self notify(#"hash_18be4b1da8bbed9b");
    self endon(#"hash_18be4b1da8bbed9b", #"disconnect", #"zm_arcade_kill", #"damage", #"bled_out", #"player_downed", #"bonus_points_player_grabbed", #"hash_b696fc900429737", #"player_grabbed_key");
    level endon(#"end_game");
    if (self.var_a528e45c <= 0) {
        return;
    }
    util::wait_network_frame();
    self thread function_9e386630();
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".multiplier_blink", 1);
    util::wait_network_frame();
    wait 5;
    while (self.var_a528e45c > 0) {
        self playsoundtoplayer(#"hash_10a416158cd8fd3a", self);
        self notify(#"multiplier_timeout");
        wait 1;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x16005276, Offset: 0x3448
// Size: 0xe0
function function_9e386630() {
    self endon(#"hash_18be4b1da8bbed9b", #"disconnect", #"zm_arcade_kill", #"damage", #"bled_out", #"player_downed", #"bonus_points_player_grabbed", #"hash_b696fc900429737", #"player_grabbed_key", #"multiplier_timeout");
    while (true) {
        self playsoundtoplayer(#"hash_10a416158cd8fd3a", self);
        wait 0.55;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xad03486, Offset: 0x3530
// Size: 0x1ce
function function_27acd143() {
    self endon(#"disconnect");
    level endon(#"end_game");
    var_25c77abb = 1;
    var_393bc2bf = 0;
    var_c7345384 = 0;
    var_ed36cded = 0;
    while (true) {
        s_waitresult = self waittill(#"zm_arcade_kill", #"bonus_points_player_grabbed", #"player_grabbed_key");
        self function_f7aee264(s_waitresult._notify, s_waitresult.ai_killed, s_waitresult.params);
        self function_f8b96677();
        if (self.score >= 40000 * var_25c77abb) {
            var_d8301f0b = zm_laststand::function_d75050c0();
            self zm_laststand::function_7996dd34(var_d8301f0b + 1);
            self zm_utility::function_fc24c484(#"hash_3ac2171741b33fc9", #"hash_3d34018a57f83b7c");
            level thread zm_audio::sndannouncerplayvox("extra_life", self);
            if (var_25c77abb == 1) {
                var_25c77abb *= 4;
                continue;
            }
            var_25c77abb *= 2;
        }
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x236731fa, Offset: 0x3708
// Size: 0x13a
function function_f8b96677() {
    if (!(isdefined(self.var_bbcca74f) && self.var_bbcca74f) && self.score >= 1000000) {
        self zm_utility::giveachievement_wrapper("zm_rush_personal_score");
        self.var_bbcca74f = 1;
    }
    if (!(isdefined(level.var_bb5944d0) && level.var_bb5944d0) && level.players.size > 1 && level.score_total >= 2000000) {
        level zm_utility::giveachievement_wrapper("zm_rush_team_score", 1);
        level.var_bb5944d0 = 1;
    }
    if (!(isdefined(self.var_e9c7d8b1) && self.var_e9c7d8b1) && self.var_a528e45c >= 100) {
        self zm_utility::giveachievement_wrapper("zm_rush_multiplier_100");
        self.var_e9c7d8b1 = 1;
    }
}

// Namespace zstandard/zstandard
// Params 3, eflags: 0x0
// Checksum 0xd67ee03f, Offset: 0x3850
// Size: 0x1cc
function function_f7aee264(str_event, ai_killed, params) {
    self endon(#"disconnect", #"damage", #"player_downed", #"bled_out");
    waittillframeend();
    if (self.var_a528e45c < 2) {
        return;
    }
    var_1c996204 = 0;
    var_212a6cbd = zm_score::get_points_multiplier(self);
    if (str_event == "zm_arcade_kill") {
        if (isdefined(params) && zm_utility::is_headshot(params.weapon, params.shitloc, params.smeansofdeath)) {
            n_headshot_multiplier = 1;
        } else {
            n_headshot_multiplier = 1;
        }
        var_1c996204 = int(25 * self.var_a528e45c * var_212a6cbd * n_headshot_multiplier);
    } else if (str_event == "bonus_points_player_grabbed" || str_event == "player_grabbed_key") {
        var_1c996204 = int(50 * self.var_a528e45c * var_212a6cbd);
    }
    self zm_score::add_to_player_score(var_1c996204, 1, "multiplier_points");
    self function_5f6feb29(var_1c996204, str_event);
}

// Namespace zstandard/zstandard
// Params 3, eflags: 0x0
// Checksum 0x9c3bc924, Offset: 0x3a28
// Size: 0x1a8
function function_5f6feb29(var_1c996204, str_event, ai_killed) {
    if (str_event === "zm_arcade_kill") {
    } else if (str_event === "bonus_points_player_grabbed" || str_event === "player_grabbed_key") {
        self luinotifyevent(#"bonus_points_player_grabbed", 2, var_1c996204, self getentitynumber());
        return;
    }
    var_82317e94 = 70;
    var_9408b5ff = floor(var_1c996204 / var_82317e94);
    var_27cff49a = var_1c996204 % var_82317e94;
    var_579e9ceb = 10;
    while (var_82317e94 > 0 && var_579e9ceb > 0) {
        for (i = 0; i < var_9408b5ff; i++) {
            self zm_score::score_cf_increment_info("damage" + var_82317e94);
            var_579e9ceb--;
        }
        var_82317e94 -= 10;
        if (var_82317e94 <= 0) {
            break;
        }
        var_9408b5ff = floor(var_27cff49a / var_82317e94);
        var_27cff49a %= var_82317e94;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x7e14e69b, Offset: 0x3bd8
// Size: 0x36
function init_pack_a_punch() {
    level.var_a13971ab = &function_9acfedf;
    level.var_31a184e2 = &function_65675e87;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x8bcce14a, Offset: 0x3c18
// Size: 0x2c
function function_65675e87(player) {
    function_d1bc5551(player, "pap", 30000);
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xae5c02f2, Offset: 0x3c50
// Size: 0xb2
function function_9acfedf(player) {
    n_cooldown = function_e721bd1b(player, "pap");
    if (n_cooldown > 0) {
        self sethintstringforplayer(player, #"zombie/wallbuy_cooldown", n_cooldown);
        player.var_351ac6c7 = 1;
    } else {
        self sethintstringforplayer(player, #"hash_6c8cfa12133d4a58");
        player.var_351ac6c7 = undefined;
    }
    return true;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x7bdab3cd, Offset: 0x3d10
// Size: 0x48
function function_88f4a5a9(player) {
    n_cooldown = function_e721bd1b(player, "pap");
    if (n_cooldown > 0) {
        return false;
    }
    return true;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x5c16735e, Offset: 0x3d60
// Size: 0x7e
function init_magicbox() {
    setdvar(#"magic_chest_movable", 1);
    level.var_9760ce17 = &function_57110477;
    level.var_f3085ac4 = 10;
    level.var_2571eede = 7;
    level.custom_magic_box_do_weapon_rise = &function_984dc720;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x81ecb643, Offset: 0x3de8
// Size: 0x1a4
function function_984dc720() {
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
    self waittill(#"randomization_done");
    self setzbarrierpiecestate(3, "open");
    self setzbarrierpiecestate(4, "open");
    self hidezbarrierpiece(3);
    self hidezbarrierpiece(4);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x6848d951, Offset: 0x3f98
// Size: 0xb8
function function_b8a13674() {
    waittillframeend();
    level flag::wait_till("all_players_spawned");
    level.oob_timelimit_ms = 5000;
    level.func_get_delay_between_rounds = &get_delay_between_rounds;
    function_f162524b();
    function_d742558c();
    function_ad24da26();
    init_wallbuys();
    if (isdefined(level.var_cadc1211)) {
        level thread [[ level.var_cadc1211 ]]();
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xed99e819, Offset: 0x4058
// Size: 0x50
function function_dd5169ce(n_round_number) {
    var_1a93f22f = isdefined(level.var_1a93f22f) ? level.var_1a93f22f : 48;
    if (n_round_number >= var_1a93f22f) {
        return true;
    }
    return false;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x6a4366d1, Offset: 0x40b0
// Size: 0x6c
function function_f38e2a7c(n_round_number) {
    if (function_dd5169ce(n_round_number)) {
        var_cfd40668 = isdefined(level.var_25b0e43e) ? level.var_25b0e43e : 3;
        if (n_round_number % var_cfd40668 == 0) {
            return true;
        }
    }
    return false;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x5fe4d40d, Offset: 0x4128
// Size: 0x92
function get_delay_between_rounds() {
    if (function_f38e2a7c(level.round_number - 1)) {
        return 20;
    } else if (!function_dd5169ce(level.round_number - 1)) {
        if (zm_utility::function_d7fbfa94(level.round_number - 1)) {
            return 6;
        } else {
            return 1;
        }
    }
    return 8;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xd750fe20, Offset: 0x41c8
// Size: 0x3c
function set_revive_count() {
    self clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".self_revives", self.var_d692c624);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x4210
// Size: 0x4
function function_4a022518() {
    
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xeb6c72ea, Offset: 0x4220
// Size: 0x4b2
function function_56967d2c() {
    if (!isdefined(level.var_3319a3d5)) {
        level.var_3319a3d5 = 1;
    }
    if (level.round_number < level.var_3319a3d5) {
        return;
    }
    level endon(#"intermission", #"end_of_round", #"restart_round");
    /#
        level endon(#"kill_round");
    #/
    a_ai_zombies = zombie_utility::get_round_enemy_array();
    n_time = 0;
    while (a_ai_zombies.size > 0 || level.zombie_total > 0) {
        var_270ac2f8 = isdefined(level.var_d31a8aee) ? level.var_d31a8aee : 18;
        var_bcf73a0c = isdefined(level.var_28af0a) ? level.var_28af0a : 13;
        foreach (ai_zombie in a_ai_zombies) {
            if (level.round_number >= var_270ac2f8) {
                if (!(isdefined(ai_zombie.var_824d4e53) && ai_zombie.var_824d4e53)) {
                    ai_zombie.var_824d4e53 = 1;
                    if (ai_zombie.archetype === "brutus") {
                        ai_zombie thread zombie_utility::set_zombie_run_cycle("sprint");
                    } else {
                        ai_zombie thread zombie_utility::set_zombie_run_cycle("super_sprint");
                    }
                }
                continue;
            }
            if (level.round_number >= var_bcf73a0c || level.round_number % 5 == 0) {
                if (!(isdefined(ai_zombie.var_824d4e53) && ai_zombie.var_824d4e53)) {
                    ai_zombie.var_824d4e53 = 1;
                    ai_zombie thread zombie_utility::set_zombie_run_cycle("sprint");
                }
                continue;
            }
            if (level.players.size == 1 && a_ai_zombies.size <= 2 || level.players.size > 1 && a_ai_zombies.size <= 5) {
                if (!(isdefined(ai_zombie.var_824d4e53) && ai_zombie.var_824d4e53)) {
                    ai_zombie.var_824d4e53 = 1;
                    ai_zombie thread zombie_utility::set_zombie_run_cycle("sprint");
                }
                continue;
            }
            if (n_time >= 15 && !(isdefined(ai_zombie.var_fdc10147) && ai_zombie.var_fdc10147)) {
                ai_zombie.var_fdc10147 = 1;
                if (level.round_number <= 5) {
                    if (randomint(100) < 5) {
                        ai_zombie thread zombie_utility::set_zombie_run_cycle("sprint");
                    } else if (randomint(100) < 25) {
                        ai_zombie thread zombie_utility::set_zombie_run_cycle("run");
                    }
                    continue;
                }
                if (randomint(100) < 50) {
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
// Checksum 0x38e53581, Offset: 0x46e0
// Size: 0x10c
function function_9b4c30e() {
    level endon(#"end_game");
    if (isdefined(level.noroundnumber) && level.noroundnumber) {
        return;
    }
    if (!isdefined(level.doground_nomusic)) {
        level.doground_nomusic = 0;
    }
    if (level.first_round) {
        var_6dcdeb0e = 1;
        if (isdefined(level._custom_intro_vox)) {
            level thread [[ level._custom_intro_vox ]]();
        }
    } else {
        var_6dcdeb0e = 0;
    }
    if (var_6dcdeb0e) {
        if (isdefined(level.host_ended_game) && level.host_ended_game) {
            return;
        }
        wait 6.25;
        level notify(#"intro_hud_done");
        wait 3;
    }
    reportmtu(level.round_number);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x2d3fa95c, Offset: 0x47f8
// Size: 0xec
function function_e7d144a8() {
    foreach (var_e20da8ce in level.var_1c7ed52c) {
        foreach (t_trigger in var_e20da8ce) {
            t_trigger.locked = 1;
            level thread zm_unitrigger::unregister_unitrigger(t_trigger);
        }
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x9a0ed552, Offset: 0x48f0
// Size: 0xa2
function function_d742558c() {
    foreach (s_barricade in level.exterior_goals) {
        s_barricade.script_delay = float(function_f9f48566()) / 1000;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xe35ef635, Offset: 0x49a0
// Size: 0x1fa
function function_f162524b() {
    waitframe(1);
    a_e_items = getitemarray();
    foreach (e_item in a_e_items) {
        w_item = e_item.item;
        if (isdefined(w_item) && isdefined(w_item.craftitem) && w_item.craftitem) {
            e_player = array::random(level.players);
            zm_items::player_pick_up(e_player, w_item);
            e_item delete();
        }
    }
    foreach (a_s_crafting in level.var_1c7ed52c) {
        foreach (s_crafting in a_s_crafting) {
            s_crafting zm_crafting::function_c9b27eac();
        }
    }
    level.var_69baaca7 = 1;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xeb44a75a, Offset: 0x4ba8
// Size: 0x4ae
function init_powerups() {
    level.var_751b1aad = 1;
    if (zm_custom::function_5638f689(#"zmpowerupsislimitedround")) {
        zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", zm_custom::function_5638f689(#"zmpowerupslimitround"));
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
    zombie_utility::set_zombie_var(#"hash_4d2cc817490bcca", 8);
    zombie_utility::set_zombie_var(#"hash_4edd68174a79580", 14);
    level.var_bdd2f351 = randomintrange(zombie_utility::get_zombie_var(#"hash_4d2cc817490bcca"), zombie_utility::get_zombie_var(#"hash_4edd68174a79580"));
    zombie_utility::set_zombie_var(#"zombie_powerup_pack_a_punch_on", 0, undefined, undefined, 1);
    zombie_utility::set_zombie_var(#"zombie_powerup_pack_a_punch_time", 30, undefined, undefined, 1);
    zm_powerups::register_powerup("pack_a_punch", &namespace_78a08a38::function_5027931c);
    zm_powerups::add_zombie_powerup("pack_a_punch", "zombie_z_money_icon", #"zombie/powerup_pap", &zm_powerups::func_should_never_drop, 0, 0, 0, undefined, "powerup_pack_a_punch", "zombie_powerup_pack_a_punch_time", "zombie_powerup_pack_a_punch_on");
    zm_powerups::add_zombie_powerup("bonus_points_player", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
    zm_powerups::powerup_remove_from_regular_drops("hero_weapon_power");
    zm_powerups::powerup_remove_from_regular_drops("bonus_points_team");
    zm_powerups::powerup_remove_from_regular_drops("fire_sale");
    level thread function_5c54592();
    level.zombie_powerups[#"insta_kill"].func_should_drop_with_regular_powerups = &function_d212dac8;
    level.zombie_powerups[#"nuke"].func_should_drop_with_regular_powerups = &function_d212dac8;
    level.zombie_powerups[#"double_points"].func_should_drop_with_regular_powerups = &function_d212dac8;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x480020ba, Offset: 0x5060
// Size: 0x13e
function function_5c54592() {
    level flag::wait_till("start_zombie_round_logic");
    level.zombie_powerups[#"double_points"].only_affects_grabber = 1;
    level.zombie_powerups[#"insta_kill"].only_affects_grabber = 1;
    level.zombie_powerups[#"nuke"].only_affects_grabber = 1;
    level.zombie_powerups[#"carpenter"].only_affects_grabber = 1;
    level.zombie_powerups[#"fire_sale"].only_affects_grabber = 1;
    level.zombie_powerups[#"full_ammo"].only_affects_grabber = 1;
    level.powerup_fx_func = &function_c7d8dba7;
    level.var_bcdda478 = &function_3aa0b4aa;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x69837711, Offset: 0x51a8
// Size: 0x124
function function_3aa0b4aa() {
    if (self.powerup_name === #"bonus_points_player" || self.powerup_name === #"bonus_points_player_shared") {
        playfx(level._effect[#"powerup_grabbed_caution"], self.origin);
        return;
    }
    if (self.only_affects_grabber) {
        playfx(level._effect[#"powerup_grabbed_solo"], self.origin);
        return;
    }
    if (self.any_team) {
        playfx(level._effect[#"powerup_grabbed_caution"], self.origin);
        return;
    }
    playfx(level._effect[#"powerup_grabbed"], self.origin);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x160f0102, Offset: 0x52d8
// Size: 0x134
function function_c7d8dba7() {
    self endon(#"death");
    if (!isdefined(self)) {
        return;
    }
    if (self.only_affects_grabber) {
        if (self.powerup_name === #"bonus_points_player" || self.powerup_name === #"bonus_points_player_shared") {
            self clientfield::set("powerup_fx", 4);
        } else {
            self clientfield::set("powerup_fx", 2);
        }
        return;
    }
    if (self.any_team) {
        self clientfield::set("powerup_fx", 4);
        return;
    }
    if (self.zombie_grabbable) {
        self clientfield::set("powerup_fx", 3);
        return;
    }
    self clientfield::set("powerup_fx", 1);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x3301c337, Offset: 0x5418
// Size: 0x5c
function function_d212dac8() {
    a_ai_zombies = zombie_utility::get_round_enemy_array();
    if (a_ai_zombies.size == 0 && level.zombie_total == 0) {
        return false;
    }
    if (level.var_ce8d9a15.size) {
        return false;
    }
    return true;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x6ec5b138, Offset: 0x5480
// Size: 0x20
function function_80bef9e() {
    if (level.round_number <= 10) {
        return false;
    }
    return true;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x4db5d07f, Offset: 0x54a8
// Size: 0xb8
function init_wallbuys() {
    level.func_override_wallbuy_prompt = &function_9be1e30c;
    level.var_11e6fc03 = &function_49768455;
    foreach (s_wallbuy in level._spawned_wallbuys) {
        zm_unitrigger::function_7fcb11a8(s_wallbuy.trigger_stub, 0);
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x23991ae9, Offset: 0x5568
// Size: 0x2c
function function_e269075d() {
    zm_utility::add_zombie_hint("default_buy_debris", #"hash_4871b118fb4dfd6b");
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0xbc8b7907, Offset: 0x55a0
// Size: 0x6a
function function_6995c57f(var_9da7e1b8, str_name) {
    if (!isdefined(var_9da7e1b8.var_5418859a)) {
        return false;
    } else if (!isdefined(var_9da7e1b8.var_5418859a[str_name])) {
        return false;
    } else if (gettime() >= var_9da7e1b8.var_5418859a[str_name]) {
        return false;
    }
    return true;
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0x4d762972, Offset: 0x5618
// Size: 0x44
function function_375d4f38(e_player, var_def5c08f) {
    return function_6995c57f(e_player, var_def5c08f) || function_6995c57f(level, var_def5c08f);
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x4b73e35a, Offset: 0x5668
// Size: 0x94
function function_1789a55d(e_player) {
    n_cooldown = function_e721bd1b(e_player, "default_treasure_chest");
    if (n_cooldown > 0) {
        e_player.var_4d17ef23 = 1;
        self sethintstringforplayer(e_player, #"zombie/wallbuy_cooldown", n_cooldown);
        return true;
    } else {
        e_player.var_4d17ef23 = undefined;
    }
    return false;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xc4b0a05c, Offset: 0x5708
// Size: 0x2c
function function_49768455(e_player) {
    function_d1bc5551(e_player, self.clientfieldname, 0);
}

// Namespace zstandard/zstandard
// Params 3, eflags: 0x0
// Checksum 0x55aa8534, Offset: 0x5740
// Size: 0x56
function function_d1bc5551(var_9da7e1b8, str_name, n_time_ms) {
    if (!isdefined(var_9da7e1b8.var_5418859a)) {
        var_9da7e1b8.var_5418859a = [];
    }
    var_9da7e1b8.var_5418859a[str_name] = gettime() + n_time_ms;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xc2d1c0bd, Offset: 0x57a0
// Size: 0x9c
function function_57110477(e_player) {
    if (isdefined(e_player zombie_utility::get_zombie_var_player(#"zombie_powerup_fire_sale_on")) && e_player zombie_utility::get_zombie_var_player(#"zombie_powerup_fire_sale_on")) {
        function_d1bc5551(e_player, "default_treasure_chest", 0);
        return;
    }
    function_d1bc5551(e_player, "default_treasure_chest", 30000);
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0xd6db1011, Offset: 0x5848
// Size: 0x96
function function_e721bd1b(var_9da7e1b8, str_name) {
    if (isdefined(var_9da7e1b8.var_5418859a) && isdefined(var_9da7e1b8.var_5418859a[str_name])) {
        n_current_time = gettime();
        if (n_current_time < var_9da7e1b8.var_5418859a[str_name]) {
            return int((var_9da7e1b8.var_5418859a[str_name] - n_current_time) / 1000);
        }
    }
    return 0;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x430350bc, Offset: 0x58e8
// Size: 0x2c
function function_640516ce(str_perk) {
    return level._custom_perks[str_perk].hint_string + "_FREE";
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0x8ce4d851, Offset: 0x5920
// Size: 0x174
function function_9be1e30c(e_player, player_has_weapon) {
    var_aba65629 = function_e721bd1b(e_player, self.clientfieldname);
    var_305841af = function_e721bd1b(level, self.clientfieldname);
    var_310ea860 = int(max(var_aba65629, var_305841af));
    if (var_310ea860 > 0) {
        self sethintstringforplayer(e_player, #"zombie/wallbuy_cooldown", var_310ea860);
        return true;
    } else if (player_has_weapon) {
        if (self.stub.weapon !== getweapon("bowie_knife")) {
            self sethintstringforplayer(e_player, #"hash_1ee18bf56df7a29b");
            return true;
        }
    } else {
        self sethintstringforplayer(e_player, #"hash_3d1e4f7ac23674b5");
        return true;
    }
    return false;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xf29906e, Offset: 0x5aa0
// Size: 0x1a8
function function_cc59049e(e_door) {
    if (zm_utility::function_39616495() && zm_utility::function_73cac535(e_door) && !(isdefined(e_door.var_3a93fc14) && e_door.var_3a93fc14)) {
        zm_utility::function_df70544d();
        level notify(#"hash_4ffec9c5f552e6fc", {#e_door:e_door});
        playsoundatposition(#"hash_27dc220231c7b8b3", e_door.origin);
        return 1;
    }
    if (self == e_door && !(isdefined(e_door.var_3a93fc14) && e_door.var_3a93fc14)) {
        return 1;
    }
    zm_utility::play_sound_at_pos("no_purchase", e_door.origin);
    return 0;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x2ac14e69, Offset: 0x5c50
// Size: 0x28c
function function_2008b9aa(e_door) {
    e_door endon(#"death");
    if (zm_utility::function_39616495() && e_door.script_noteworthy !== "electric_door" && e_door.script_noteworthy !== "electric_buyable_door" && !(isdefined(e_door.var_3a93fc14) && e_door.var_3a93fc14)) {
        while (true) {
            if (zm_utility::function_73cac535(e_door)) {
                e_door sethintstring(#"hash_7960cdc72d34a2db");
            } else {
                e_door sethintstring(#"");
            }
            waitframe(1);
        }
        return;
    }
    if (e_door.script_noteworthy === "electric_door" || e_door.script_noteworthy === "electric_buyable_door" || isdefined(e_door.var_3a93fc14) && e_door.var_3a93fc14) {
        if (isdefined(level.var_4f18c7cc)) {
            e_door sethintstring(level.var_4f18c7cc);
        } else if (zm_utility::get_story() == 1) {
            e_door sethintstring(#"zombie/need_power");
        } else {
            e_door sethintstring(#"hash_3dc033ef1e67a5c0");
        }
        return;
    }
    var_d8c89be9 = function_3f400a26(e_door.target);
    if (isdefined(var_d8c89be9) && !e_door zm_utility::function_e8fc435c()) {
        e_door sethintstring(#"hash_5253833fcb69e672", var_d8c89be9);
        return;
    }
    e_door sethintstring(#"hash_17758d1de3b1fe6a");
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x753a421f, Offset: 0x5ee8
// Size: 0xe4
function function_762aca31(n_round) {
    var_2da5752 = n_round + 1;
    if (isdefined(level.var_ff0584fd[var_2da5752])) {
        foreach (var_93e98b98 in level.var_ff0584fd[var_2da5752]) {
            zm_utility::open_door(var_93e98b98);
        }
        if (n_round == level.round_number) {
            level zm_utility::function_d7a33664(#"hash_594b38c1356d221a");
        }
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x9b11c25d, Offset: 0x5fd8
// Size: 0xf4
function function_3f400a26(str_door_name) {
    if (isdefined(level.var_ff0584fd)) {
        foreach (index, var_b77ea47d in level.var_ff0584fd) {
            foreach (var_93e98b98 in var_b77ea47d) {
                if (var_93e98b98 == str_door_name) {
                    return index;
                }
            }
        }
    }
    return undefined;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x38d13790, Offset: 0x60d8
// Size: 0x1e
function onprecachegametype() {
    level.canplayersuicide = &zm_gametype::canplayersuicide;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x1f51a68, Offset: 0x6100
// Size: 0x19c
function onstartgametype() {
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
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x2097ab5c, Offset: 0x62a8
// Size: 0xa4
function function_b43ef6c6() {
    level.var_210e347b = 1;
    level.var_c8eb41dc = 1;
    callback::on_spawned(&function_1b87ea74);
    callback::on_laststand(&function_67ca285c);
    callback::on_revived(&function_e2986087);
    callback::on_connect(&function_9958c48d);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xeeda8ef5, Offset: 0x6358
// Size: 0x64
function function_9958c48d() {
    if (level flag::get("start_zombie_round_logic")) {
        self thread function_5bc4a86f(1);
        self thread zm_equipment::show_hint_text(#"hash_7ec10e89f0ae5fc4", 4);
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x807a66ef, Offset: 0x63c8
// Size: 0x12a
function function_1b87ea74() {
    self endon(#"disconnect");
    if (!isdefined(self.var_5f9b8b94)) {
        self.var_5f9b8b94 = 0;
    }
    level flag::wait_till("start_zombie_round_logic");
    waitframe(1);
    switch (self.var_5f9b8b94) {
    case 0:
        self zm_laststand::function_7996dd34(level.numlives);
        break;
    case 1:
        self zm_laststand::function_7996dd34(1);
        self thread function_a4e0d437();
        break;
    default:
        self zm_laststand::function_7996dd34(0);
        self thread function_a4e0d437();
        break;
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x438e1d8d, Offset: 0x6500
// Size: 0x2cc
function function_67ca285c() {
    self endoncallback(&function_91ec23e9, #"disconnect");
    waitframe(1);
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".playerIsDowned", 1);
    self function_814c4bde();
    self playsoundtoplayer(#"hash_5e980fdf2497d9a1", self);
    if (zm_laststand::function_d75050c0() > 0) {
        level thread zm_audio::sndannouncerplayvox("player_down", self);
        zm_utility::function_29616508();
        self.var_16664b09 = 1;
        self zm_laststand::function_edd56797();
        if (!level.var_6be65be5 self_revive_visuals_rush::is_open(self)) {
            level.var_6be65be5 self_revive_visuals_rush::open(self);
            for (i = 0; i < 5; i++) {
                level.var_6be65be5 self_revive_visuals_rush::set_revive_time(self, 5 - i);
                wait 1;
            }
        }
        self playsoundtoplayer(#"hash_1526662237d7780f", self);
        self zm_laststand::auto_revive();
        if (level.var_6be65be5 self_revive_visuals_rush::is_open(self)) {
            level.var_6be65be5 self_revive_visuals_rush::close(self);
        }
        zm_utility::function_6c8e0750();
        self.var_16664b09 = undefined;
        return;
    }
    if (level.players.size > 1 && zm_player::function_46ac3ba0(self)) {
        self thread function_5bc4a86f(0);
    }
    level thread zm_audio::sndannouncerplayvox("player_out", self);
    self.var_5f9b8b94++;
    self notify(#"bled_out");
    self globallogic_player::function_dd466180();
    self thread function_d2ed6730();
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xf2f6e5c2, Offset: 0x67d8
// Size: 0x34
function function_91ec23e9(str_notify) {
    if (isdefined(self.var_16664b09) && self.var_16664b09) {
        zm_utility::function_6c8e0750();
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x703241ff, Offset: 0x6818
// Size: 0x10c
function function_d2ed6730() {
    self zm_laststand::bleed_out();
    level thread zm_utility::play_sound_2d("zmb_rush_plr_dead_stinger");
    if (level.players.size > 1) {
        foreach (player in level.players) {
            if (player.sessionstate === "playing" && !zm_player::function_46ac3ba0(player)) {
                level thread zm_audio::sndannouncerplayvox("player_last_man_standing", player);
                break;
            }
        }
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x862ec7f3, Offset: 0x6930
// Size: 0x15c
function function_5bc4a86f(var_ed500ab6 = 0) {
    self notify(#"hash_7ee1d21962bb24f");
    self endoncallback(&function_eae0bb0e, #"disconnect", #"hash_7ee1d21962bb24f");
    level endoncallback(&function_eae0bb0e, #"end_game");
    self notify(#"end_healthregen");
    if (!var_ed500ab6) {
        return;
    }
    level.var_49197edc thread zm_arcade_timer::function_49fb9a81(self, 120, #"hash_5e3423d08973905", 1);
    wait 120;
    self notify(#"hash_387bb170e38042d5");
    self zm_player::spectator_respawn_player();
    self clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".playerIsDowned", 0);
    if (isdefined(level.var_e0541a13)) {
        self zm_utility::function_1cf2007e();
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xb02df0c5, Offset: 0x6a98
// Size: 0xd0
function function_eae0bb0e(var_e34146dc) {
    if (isplayer(self)) {
        level.var_49197edc zm_arcade_timer::function_7ccee86d(self);
        return;
    }
    foreach (player in level.players) {
        level.var_49197edc zm_arcade_timer::function_7ccee86d(player, 1);
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0xbe3d8ebb, Offset: 0x6b70
// Size: 0x216
function function_a4e0d437() {
    self endon(#"disconnect");
    level endoncallback(&function_1413cf6a, #"end_game");
    if (isdefined(level.host_ended_game) && level.host_ended_game) {
        return;
    }
    self thread function_c7c76d6a();
    self thread function_45e381a6();
    self val::set("zm_arcade", "takedamage", 0);
    self val::set("zm_arcade", "ignoreme", 1);
    self.var_77777c2d = 1;
    self clientfield::set_to_player("" + #"hash_321b58d22755af74", 1);
    self playsound(#"zmb_bgb_plainsight_start");
    self playloopsound(#"zmb_bgb_plainsight_loop", 1);
    wait 6;
    self stoploopsound(1);
    self playsound(#"zmb_bgb_plainsight_end");
    self clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);
    self val::reset("zm_arcade", "takedamage");
    self val::reset("zm_arcade", "ignoreme");
    self.var_77777c2d = undefined;
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xdfb61a4d, Offset: 0x6d90
// Size: 0xe2
function function_1413cf6a(str_notify) {
    foreach (player in level.players) {
        if (isdefined(player.var_77777c2d) && player.var_77777c2d) {
            player clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);
            player stoploopsound(1);
            player.var_77777c2d = undefined;
        }
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x1994626d, Offset: 0x6e80
// Size: 0xdc
function function_c7c76d6a() {
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
// Checksum 0xf82d54e1, Offset: 0x6f68
// Size: 0xac
function function_45e381a6() {
    a_ai_targets = getaispeciesarray(level.zombie_team, "all");
    a_ai_targets = arraysortclosest(a_ai_targets, self.origin, a_ai_targets.size, 0, 160);
    a_ai_targets = array::remove_dead(a_ai_targets);
    a_ai_targets = array::remove_undefined(a_ai_targets);
    array::thread_all(a_ai_targets, &zm_hero_weapon::function_2aaca7c6, self);
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x8d806226, Offset: 0x7020
// Size: 0x64
function function_e2986087(params) {
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + ".playerIsDowned", 0);
    if (zm_laststand::function_d75050c0() >= 0) {
        self thread function_a4e0d437();
    }
}

/#

    // Namespace zstandard/zstandard
    // Params 0, eflags: 0x0
    // Checksum 0x5d1620b9, Offset: 0x7090
    // Size: 0x8e
    function function_ca462011() {
        level notify(#"hash_4bbfbbe6ad7c9dab");
        level endon(#"end_game", #"hash_4bbfbbe6ad7c9dab");
        while (true) {
            debug2dtext((5, 250, 0), "<dev string:x1c5>" + level.round_number, undefined, undefined, undefined, 1);
            waitframe(1);
        }
    }

#/

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0xc6285b56, Offset: 0x7128
// Size: 0xd00
function function_a9647030(restart = 0) {
    println("<dev string:x1dd>");
    level endon(#"end_round_think");
    if (!(isdefined(restart) && restart)) {
        if (isdefined(level.var_b31c6007)) {
            [[ level.var_b31c6007 ]]();
        }
        if (!(isdefined(level.host_ended_game) && level.host_ended_game)) {
            players = getplayers();
            foreach (player in players) {
                player zm_stats::set_global_stat("rounds", level.round_number);
            }
        }
    }
    setroundsplayed(level.round_number);
    level.var_f6545288 = gettime();
    while (true) {
        zombie_utility::set_zombie_var("rebuild_barrier_cap_per_round", min(500, 50 * level.round_number));
        level.pro_tips_start_time = gettime();
        level.zombie_last_run_time = gettime();
        callback::callback(#"hash_6df5348c2fb9a509");
        /#
            level thread function_ca462011();
        #/
        if (isdefined(level.var_d58439a1)) {
            level thread zm_audio::function_3aef57a7();
            [[ level.var_d58439a1 ]]();
        } else {
            level thread zm_audio::function_3aef57a7();
            zm_round_logic::round_one_up();
        }
        if (level.round_number == 1) {
            n_index = randomintrangeinclusive(0, 4);
            level thread zm_audio::sndannouncerplayvox("game_start_" + n_index);
        }
        zm_powerups::powerup_round_start();
        players = getplayers();
        array::thread_all(players, &zm_blockers::rebuild_barrier_reward_reset);
        if (!(isdefined(level.headshots_only) && level.headshots_only) && !restart) {
            level thread zm_round_logic::award_grenades_for_survivors();
        }
        println("<dev string:x1f5>" + level.round_number + "<dev string:x20f>" + players.size);
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
        if (!(isdefined(level.var_95f84779) && level.var_95f84779)) {
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
        var_5f278dbe = isdefined(level.var_5f278dbe) ? level.var_5f278dbe : 15;
        if (level.round_number == var_5f278dbe) {
            zm_powerups::powerup_remove_from_regular_drops("nuke");
        }
        var_92aeb2a = isdefined(level.var_92aeb2a) ? level.var_92aeb2a : 20;
        if (level.round_number == var_92aeb2a) {
            level.var_3a431efe = 1;
            zm_powerups::powerup_remove_from_regular_drops("full_ammo");
        }
        if (level.round_number >= 15) {
            if (level.round_number % 2 == 0 && (level.players.size == 1 || level.players.size == 2) || level.round_number % 3 == 0 && level.players.size > 2) {
                level.var_b9008247 = "pack_a_punch";
            }
        }
        [[ level.round_wait_func ]]();
        if (!function_dd5169ce(level.round_number) && zm_utility::function_d7fbfa94(level.round_number) || function_f38e2a7c(level.round_number)) {
            if (!level flag::get("started_defend_area")) {
                util::playsoundonplayers(#"hash_2d1265adbba422cf");
            }
        }
        level thread zm_audio::function_a08f940c();
        level.first_round = 0;
        callback::callback(#"on_round_end");
        level notify(#"end_of_round");
        bb::logroundevent("end_of_round");
        uploadstats();
        if (isdefined(level.round_end_custom_logic)) {
            [[ level.round_end_custom_logic ]]();
        }
        if (zm_custom::function_5638f689(#"zmroundcap") == level.round_number && level.round_number != 0) {
            wait 3;
            zm_custom::function_c4cdc40c(#"zmroundcap");
            return;
        }
        if (int(level.round_number / 5) * 5 == level.round_number) {
            level clientfield::set("round_complete_time", int((level.time - level.n_gameplay_start_time + 500) / 1000));
            level clientfield::set("round_complete_num", level.round_number);
        }
        zm_round_logic::set_round_number(1 + zm_round_logic::get_round_number());
        setroundsplayed(zm_round_logic::get_round_number());
        for (n_round = 1; n_round <= level.round_number; n_round++) {
            if (zm_utility::function_39616495()) {
                continue;
            }
            function_762aca31(n_round);
        }
        zombie_utility::set_zombie_var("zombie_spawn_delay", [[ level.func_get_zombie_spawn_delay ]](zm_round_logic::get_round_number()));
        matchutctime = getutc();
        players = getplayers();
        foreach (player in players) {
            if (level.curr_gametype_affects_rank && zm_round_logic::get_round_number() > 3 + level.start_round) {
                player zm_stats::add_client_stat("weighted_rounds_played", zm_round_logic::get_round_number());
            }
            player zm_stats::set_global_stat("rounds", zm_round_logic::get_round_number());
            player zm_stats::update_playing_utc_time(matchutctime);
            player zm_utility::set_max_health(1);
            for (i = 0; i < 4; i++) {
                player.number_revives_per_round[i] = 0;
            }
            if (isalive(player) && player.sessionstate != "spectator" && !(isdefined(level.skip_alive_at_round_end_xp) && level.skip_alive_at_round_end_xp)) {
                player zm_stats::increment_challenge_stat("SURVIVALIST_SURVIVE_ROUNDS");
                player zm_callings::function_7cafbdd3(21);
                score_number = zm_round_logic::get_round_number() - 1;
                if (score_number < 1) {
                    score_number = 1;
                } else if (score_number > 20) {
                    score_number = 20;
                }
                scoreevents::processscoreevent("alive_at_round_end_" + score_number, player);
            }
        }
        level.round_number = zm_round_logic::get_round_number();
        level zm_round_logic::round_over();
        level notify(#"between_round_over");
        level.skip_alive_at_round_end_xp = 0;
        restart = 0;
    }
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x0
// Checksum 0x98e4c812, Offset: 0x7e30
// Size: 0x306
function function_c8e64acb(var_7a4e73dd = 120) {
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
            var_7a4e73dd = getdvarint(#"hash_1f243f823e1838d4", 0);
        }
    #/
    wait 1;
    /#
        level thread zm_round_logic::print_zombie_counts();
        level thread zm_round_logic::sndmusiconkillround();
    #/
    var_d75cb057 = gettime();
    while (true) {
        if (function_dd5169ce(level.round_number)) {
            var_377730f = function_f38e2a7c(level.round_number) && zombie_utility::get_current_zombie_count() > 0 || level.zombie_total > 0 || level.intermission;
        } else {
            var_377730f = zombie_utility::get_current_zombie_count() > 0 || level.zombie_total > 0 || level.intermission;
        }
        /#
            if (getdvarint(#"hash_19d726be121cfa2", 0)) {
                var_377730f = var_377730f && gettime() - var_d75cb057 < var_7a4e73dd;
            }
        #/
        if ((!var_377730f || level flag::get("end_round_wait")) && !level flag::get(#"infinite_round_spawning")) {
            return;
        }
        wait 1;
    }
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0x1285604d, Offset: 0x8140
// Size: 0xcc
function get_zombie_count_for_round(n_round, n_player_count) {
    if (!isdefined(level.var_c6562dd4) || !isdefined(level.var_c6562dd4[n_round]) || !isdefined(level.var_c6562dd4[n_round].n_count_total)) {
        return -1;
    }
    n_count_total = level.var_c6562dd4[n_round].n_count_total;
    return n_count_total + int(ceil(n_count_total * 0.1 * (n_player_count - 1)));
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0xed010a29, Offset: 0x8218
// Size: 0x76
function function_fc0e3ee8(n_round, n_player_count) {
    if (!isdefined(level.var_c6562dd4) || !isdefined(level.var_c6562dd4[n_round]) || !isdefined(level.var_c6562dd4[n_round].var_67be72a0)) {
        return -1;
    }
    return level.var_c6562dd4[n_round].var_67be72a0;
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x2a0ad390, Offset: 0x8298
// Size: 0xe0
function function_920f9dd8() {
    if (!isdefined(level.var_2557dd2a) || !isdefined(level.var_2557dd2a[level.round_number])) {
        return;
    }
    foreach (archetype, s_data in level.var_2557dd2a[level.round_number]) {
        if (archetype == "zombie") {
            continue;
        }
        s_data thread function_6fbfa156(archetype, level.players.size);
    }
}

// Namespace zstandard/zstandard
// Params 2, eflags: 0x0
// Checksum 0xc40360b1, Offset: 0x8380
// Size: 0x1ae
function function_6fbfa156(str_archetype, n_player_count) {
    level endon(#"end_game");
    n_count_total = self.n_count_total;
    if (n_player_count > 2) {
        n_count_total += int(ceil(n_count_total / 2));
    }
    for (i = 0; i < n_count_total; i++) {
        if (i == 0 && isdefined(self.var_2b02390e)) {
            wait self.var_2b02390e;
        }
        ai = undefined;
        while (!isdefined(ai)) {
            if (isdefined(self.var_32dcecaf)) {
                ai = [[ self.var_32dcecaf ]]();
            } else {
                zm_transform::function_5dbbf742(str_archetype);
                s_waitresult = level waittill(#"transformation_complete");
                if (s_waitresult.id === str_archetype) {
                    ai = s_waitresult.new_ai[0];
                }
            }
            waitframe(1);
        }
        zm_utility::function_5842b86c(str_archetype);
        if (isdefined(self.var_18a8b881)) {
            [[ self.var_18a8b881 ]]();
            continue;
        }
        util::wait_network_frame();
    }
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x4af4b3c3, Offset: 0x8538
// Size: 0xb0
function function_1bcc427b() {
    self endon(#"disconnect");
    while (true) {
        s_waitresult = self waittill(#"perk_bought");
        if (isdefined(s_waitresult.var_70221ebf) && isdefined(level.zmannouncervox[s_waitresult.var_70221ebf])) {
            level thread zm_audio::sndannouncerplayvox(s_waitresult.var_70221ebf, self);
            continue;
        }
        level thread zm_audio::sndannouncerplayvox("perk_generic", self);
    }
}

