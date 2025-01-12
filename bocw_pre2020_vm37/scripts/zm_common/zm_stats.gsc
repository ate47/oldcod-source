#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_challenges;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_stats;

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x6
// Checksum 0x2cbb038e, Offset: 0x9c0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_stats", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x5 linked
// Checksum 0xf7dac6d2, Offset: 0xa08
// Size: 0xdc
function private function_70a657d8() {
    level.player_stats_init = &player_stats_init;
    level.add_client_stat = &add_client_stat;
    level.increment_client_stat = &increment_client_stat;
    level.var_4e390265 = &function_7741345e;
    if (!level.rankedmatch) {
        level.zm_disable_recording_stats = 1;
    }
    if (!getdvarint(#"hash_83577689a2e58b3", 0)) {
        setdvar(#"hash_83577689a2e58b3", 180);
    }
    function_a8758411();
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x7d187b35, Offset: 0xaf0
// Size: 0xbc
function function_a8758411() {
    if (getdvarint(#"hash_27ff853067d7c38c", 0)) {
        var_821f7fa0 = getdvarint(#"zm_active_event_calling", 0);
        if (var_821f7fa0) {
            function_94335f4a(var_821f7fa0);
        }
        var_a4aebab9 = getdvarint(#"zm_active_daily_calling", 0);
        if (var_a4aebab9) {
            function_e8c496dd(var_a4aebab9);
        }
    }
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x50620fd3, Offset: 0xbb8
// Size: 0x1914
function player_stats_init() {
    self globallogic_score::initpersstat(#"kills", 0);
    self globallogic_score::initpersstat(#"wonder_weapon_kills", 0);
    self globallogic_score::initpersstat(#"suicides", 0);
    self.suicides = self globallogic_score::getpersstat(#"suicides");
    self globallogic_score::initpersstat(#"downs", 0);
    self.downs = self globallogic_score::getpersstat(#"downs");
    self globallogic_score::initpersstat(#"revives", 0);
    self.revives = self globallogic_score::getpersstat(#"revives");
    self globallogic_score::initpersstat(#"perks_drank", 0);
    self globallogic_score::initpersstat(#"bgbs_chewed", 0);
    self globallogic_score::initpersstat(#"headshots", 0);
    self globallogic_score::initpersstat(#"special_weapon_used", 0);
    self globallogic_score::initpersstat(#"melee_kills", 0);
    self globallogic_score::initpersstat(#"grenade_kills", 0);
    self globallogic_score::initpersstat(#"doors_purchased", 0);
    self globallogic_score::initpersstat(#"distance_traveled", 0);
    self.distance_traveled = self globallogic_score::getpersstat(#"distance_traveled");
    self globallogic_score::initpersstat(#"total_shots", 0);
    self.total_shots = self globallogic_score::getpersstat(#"total_shots");
    self globallogic_score::initpersstat(#"hits", 0);
    self.hits = self globallogic_score::getpersstat(#"hits");
    self globallogic_score::initpersstat(#"hits_taken", 0);
    self globallogic_score::initpersstat(#"misses", 0);
    self.misses = self globallogic_score::getpersstat(#"misses");
    self globallogic_score::initpersstat(#"deaths", 0);
    self.deaths = self globallogic_score::getpersstat(#"deaths");
    self globallogic_score::initpersstat(#"boards", 0);
    self globallogic_score::initpersstat(#"failed_revives", 0);
    self globallogic_score::initpersstat(#"sacrifices", 0);
    self globallogic_score::initpersstat(#"failed_sacrifices", 0);
    self globallogic_score::initpersstat(#"drops", 0);
    self globallogic_score::initpersstat(#"nuke_pickedup", 0);
    self globallogic_score::initpersstat(#"insta_kill_pickedup", 0);
    self globallogic_score::initpersstat(#"full_ammo_pickedup", 0);
    self globallogic_score::initpersstat(#"double_points_pickedup", 0);
    self globallogic_score::initpersstat(#"meat_stink_pickedup", 0);
    self globallogic_score::initpersstat(#"carpenter_pickedup", 0);
    self globallogic_score::initpersstat(#"fire_sale_pickedup", 0);
    self globallogic_score::initpersstat(#"hash_27399de28b76c5c6", 0);
    self globallogic_score::initpersstat(#"minigun_pickedup", 0);
    self globallogic_score::initpersstat(#"island_seed_pickedup", 0);
    self globallogic_score::initpersstat(#"hero_weapon_power_pickedup", 0);
    self globallogic_score::initpersstat(#"pack_a_punch_pickedup", 0);
    self globallogic_score::initpersstat(#"extra_lives_pickedup", 0);
    self globallogic_score::initpersstat(#"zmarcade_key_pickedup", 0);
    self globallogic_score::initpersstat(#"shield_charge_pickedup", 0);
    self globallogic_score::initpersstat(#"dung_pickedup", 0);
    self globallogic_score::initpersstat(#"bonus_points_team_pickedup", 0);
    self globallogic_score::initpersstat(#"ww_grenade_pickedup", 0);
    self globallogic_score::initpersstat(#"use_magicbox", 0);
    self globallogic_score::initpersstat(#"grabbed_from_magicbox", 0);
    self globallogic_score::initpersstat(#"use_perk_random", 0);
    self globallogic_score::initpersstat(#"grabbed_from_perk_random", 0);
    self globallogic_score::initpersstat(#"use_pap", 0);
    self globallogic_score::initpersstat(#"pap_weapon_grabbed", 0);
    self globallogic_score::initpersstat(#"pap_weapon_not_grabbed", 0);
    self globallogic_score::initpersstat(#"specialty_armorvest_drank", 0);
    self globallogic_score::initpersstat(#"specialty_quickrevive_drank", 0);
    self globallogic_score::initpersstat(#"specialty_fastreload_drank", 0);
    self globallogic_score::initpersstat(#"specialty_additionalprimaryweapon_drank", 0);
    self globallogic_score::initpersstat(#"specialty_staminup_drank", 0);
    self globallogic_score::initpersstat(#"specialty_doubletap2_drank", 0);
    self globallogic_score::initpersstat(#"specialty_widowswine_drank", 0);
    self globallogic_score::initpersstat(#"specialty_deadshot_drank", 0);
    self globallogic_score::initpersstat(#"specialty_electriccherry_drank", 0);
    self globallogic_score::initpersstat(#"specialty_awareness_drank", 0);
    self globallogic_score::initpersstat(#"hash_583ff5f66fd10104", 0);
    self globallogic_score::initpersstat(#"hash_3cbaa7dc09e06bb7", 0);
    self globallogic_score::initpersstat(#"specialty_cooldown_drank", 0);
    self globallogic_score::initpersstat(#"specialty_etherealrazor_drank", 0);
    self globallogic_score::initpersstat(#"specialty_extraammo_drank", 0);
    self globallogic_score::initpersstat(#"hash_3c548389d8524d38", 0);
    self globallogic_score::initpersstat(#"specialty_phdflopper_drank", 0);
    self globallogic_score::initpersstat(#"specialty_shield_drank", 0);
    self globallogic_score::initpersstat(#"specialty_zombshell_drank", 0);
    self globallogic_score::initpersstat(#"specialty_wolf_protector_drank", 0);
    self globallogic_score::initpersstat(#"hash_3d9b732ca303132b", 0);
    self globallogic_score::initpersstat(#"hash_48288866afddc0d4", 0);
    self globallogic_score::initpersstat(#"hash_1dc1fbd3fd2fe493", 0);
    self globallogic_score::initpersstat(#"hash_49cc8e6486122824", 0);
    self globallogic_score::initpersstat(#"hash_382854bc103fd553", 0);
    self globallogic_score::initpersstat(#"hash_4419d00a9f04f866", 0);
    self globallogic_score::initpersstat(#"hash_5a42a4d4accf00bf", 0);
    self globallogic_score::initpersstat(#"hash_dd2dc50d66eb166", 0);
    self globallogic_score::initpersstat(#"hash_79d41974c40c126e", 0);
    self globallogic_score::initpersstat(#"hash_5c9c943cd0cffc65", 0);
    self globallogic_score::initpersstat(#"hash_7d98fe4413e871a4", 0);
    self globallogic_score::initpersstat(#"hash_402bebef02213c02", 0);
    self globallogic_score::initpersstat(#"hash_2a63229e9bf23baa", 0);
    self globallogic_score::initpersstat(#"hash_41476f0bb1f7c683", 0);
    self globallogic_score::initpersstat(#"hash_254f75482929079b", 0);
    self globallogic_score::initpersstat(#"hash_3bd6bf00e8c71a5d", 0);
    self globallogic_score::initpersstat(#"hash_310ed4181d9aeddc", 0);
    self globallogic_score::initpersstat(#"hash_6505f09a128cba8d", 0);
    self globallogic_score::initpersstat(#"claymores_planted", 0);
    self globallogic_score::initpersstat(#"claymores_pickedup", 0);
    self globallogic_score::initpersstat(#"bouncingbetty_planted", 0);
    self globallogic_score::initpersstat(#"bouncingbetty_pickedup", 0);
    self globallogic_score::initpersstat(#"bouncingbetty_devil_planted", 0);
    self globallogic_score::initpersstat(#"bouncingbetty_devil_pickedup", 0);
    self globallogic_score::initpersstat(#"bouncingbetty_holly_planted", 0);
    self globallogic_score::initpersstat(#"bouncingbetty_holly_pickedup", 0);
    self globallogic_score::initpersstat(#"ballistic_knives_pickedup", 0);
    self globallogic_score::initpersstat(#"wallbuy_weapons_purchased", 0);
    self globallogic_score::initpersstat(#"ammo_purchased", 0);
    self globallogic_score::initpersstat(#"upgraded_ammo_purchased", 0);
    self globallogic_score::initpersstat(#"shields_purchased", 0);
    self globallogic_score::initpersstat(#"power_turnedon", 0);
    self globallogic_score::initpersstat(#"power_turnedoff", 0);
    self globallogic_score::initpersstat(#"planted_buildables_pickedup", 0);
    self globallogic_score::initpersstat(#"buildables_built", 0);
    self globallogic_score::initpersstat(#"time_played_total", 0);
    self globallogic_score::initpersstat(#"weighted_rounds_played", 0);
    self globallogic_score::initpersstat(#"zspiders_killed", 0);
    self globallogic_score::initpersstat(#"zthrashers_killed", 0);
    self globallogic_score::initpersstat(#"zraps_killed", 0);
    self globallogic_score::initpersstat(#"zwasp_killed", 0);
    self globallogic_score::initpersstat(#"zsentinel_killed", 0);
    self globallogic_score::initpersstat(#"zraz_killed", 0);
    self globallogic_score::initpersstat(#"zdog_rounds_finished", 0);
    self globallogic_score::initpersstat(#"zdog_rounds_lost", 0);
    self globallogic_score::initpersstat(#"killed_by_zdog", 0);
    self globallogic_score::initpersstat(#"killed_by_blightfather", 0);
    self globallogic_score::initpersstat(#"killed_by_brutus", 0);
    self globallogic_score::initpersstat(#"killed_by_gladiator", 0);
    self globallogic_score::initpersstat(#"killed_by_stoker", 0);
    self globallogic_score::initpersstat(#"killed_by_tiger", 0);
    self globallogic_score::initpersstat(#"killed_by_catalyst", 0);
    self globallogic_score::initpersstat(#"killed_by_catalyst_electric", 0);
    self globallogic_score::initpersstat(#"killed_by_catalyst_water", 0);
    self globallogic_score::initpersstat(#"killed_by_catalyst_plasma", 0);
    self globallogic_score::initpersstat(#"killed_by_catalyst_corrosive", 0);
    self globallogic_score::initpersstat(#"killed_by_nova_crawler", 0);
    self globallogic_score::initpersstat(#"killed_by_werewolf", 0);
    self globallogic_score::initpersstat(#"killed_by_nosferatu", 0);
    self globallogic_score::initpersstat(#"killed_by_crimson_nosferatu", 0);
    self globallogic_score::initpersstat(#"blightfathers_killed", 0);
    self globallogic_score::initpersstat(#"brutuses_killed", 0);
    self globallogic_score::initpersstat(#"gladiators_killed", 0);
    self globallogic_score::initpersstat(#"stokers_killed", 0);
    self globallogic_score::initpersstat(#"tigers_killed", 0);
    self globallogic_score::initpersstat(#"catalysts_killed", 0);
    self globallogic_score::initpersstat(#"catalyst_electrics_killed", 0);
    self globallogic_score::initpersstat(#"catalyst_waters_killed", 0);
    self globallogic_score::initpersstat(#"catalyst_plasmas_killed", 0);
    self globallogic_score::initpersstat(#"catalyst_corrosives_killed", 0);
    self globallogic_score::initpersstat(#"nova_crawlers_killed", 0);
    self globallogic_score::initpersstat(#"zdogs_killed", 0);
    self globallogic_score::initpersstat(#"werewolves_killed", 0);
    self globallogic_score::initpersstat(#"nosferatus_killed", 0);
    self globallogic_score::initpersstat(#"crimson_nosferatus_killed", 0);
    self globallogic_score::initpersstat(#"bats_killed", 0);
    self globallogic_score::initpersstat(#"cheat_too_many_weapons", 0);
    self globallogic_score::initpersstat(#"cheat_out_of_playable", 0);
    self globallogic_score::initpersstat(#"cheat_too_friendly", 0);
    self globallogic_score::initpersstat(#"cheat_total", 0);
    self globallogic_score::initpersstat(#"castle_tram_token_pickedup", 0);
    self globallogic_score::initpersstat(#"prison_tomahawk_acquired", 0);
    self globallogic_score::initpersstat(#"prison_brutus_killed", 0);
    self globallogic_score::initpersstat(#"prison_ee_spoon_acquired", 0);
    self globallogic_score::initpersstat(#"prison_fan_trap_used", 0);
    self globallogic_score::initpersstat(#"prison_acid_trap_used", 0);
    self globallogic_score::initpersstat(#"prison_spinning_trap_used", 0);
    self globallogic_score::initpersstat(#"towers_acid_trap_built_ra", 0);
    self globallogic_score::initpersstat(#"towers_acid_trap_built_danu", 0);
    self globallogic_score::initpersstat(#"towers_acid_trap_built_odin", 0);
    self globallogic_score::initpersstat(#"towers_acid_trap_built_zeus", 0);
    self globallogic_score::initpersstat(#"total_points", 0);
    self globallogic_score::initpersstat(#"rounds", 0);
    if (level.resetplayerscoreeveryround) {
        self.pers[#"score"] = 0;
    }
    self.pers[#"score"] = level.player_starting_points;
    self.score = self.pers[#"score"];
    self incrementplayerstat("score", self.score);
    self add_map_stat("score", self.score);
    self globallogic_score::initpersstat(#"zteam", 0);
    if (isdefined(level.var_4b5a61cf)) {
        [[ level.var_4b5a61cf ]]();
    }
    if (!isdefined(self.stats_this_frame)) {
        self.stats_this_frame = [];
    }
    self globallogic_score::initpersstat(#"zm_daily_challenge_ingame_time", 1, 1);
    self add_global_stat("ZM_DAILY_CHALLENGE_GAMES_PLAYED", 1);
    if (isdefined(level.var_1aa5a6d6)) {
        self stats::set_stat(#"hash_1c539a1b16b48b16", level.var_1aa5a6d6);
    } else {
        self stats::set_stat(#"hash_1c539a1b16b48b16", 0);
    }
    if (getdvarint(#"hash_27ff853067d7c38c", 0)) {
        var_87b499fb = self stats::get_stat(#"hash_18e3320ccf4091e5", #"hash_487f0fce798b3a4b");
        var_8962d9b1 = isdefined(level.var_d479261a) ? level.var_d479261a : 0;
        self stats::set_stat(#"hash_18e3320ccf4091e5", #"hash_487f0fce798b3a4b", var_8962d9b1);
        var_327c034e = self stats::get_stat(#"hash_18e3320ccf4091e5", #"calling_timestamp");
        var_d0ad64e3 = getutc();
        var_222b02a1 = var_d0ad64e3 - var_327c034e;
        var_ee21b34b = 86400;
        if (var_87b499fb !== var_8962d9b1 || var_327c034e == 0 || var_222b02a1 > var_ee21b34b) {
            self stats::set_stat(#"hash_18e3320ccf4091e5", #"progress", 0);
            self stats::set_stat(#"hash_18e3320ccf4091e5", #"calling_timestamp", var_d0ad64e3);
        }
    }
    if (getdvarint(#"hash_11da02ca40639de5", 0)) {
        self zm_callings::function_f3393d6a();
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0x2387c1f0, Offset: 0x24d8
// Size: 0xadc
function update_players_stats_at_match_end(players) {
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (isbot(player)) {
            continue;
        }
        player function_9daadcaa("total_points", player.score_total);
        player function_9daadcaa("HIGHEST_ROUND_REACHED", level.round_number);
    }
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    game_mode = util::get_game_type();
    game_mode_group = level.scr_zm_ui_gametype_group;
    map_location_name = level.scr_zm_map_start_location;
    zm_score::function_bc9de425();
    if (map_location_name == "") {
        map_location_name = "default";
    }
    recordmatchsummaryzombieendgamedata(game_mode_group, game_mode, map_location_name, level.round_number);
    newtime = gettime();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (isbot(player)) {
            continue;
        }
        distance = player get_stat_distance_traveled();
        player stats::function_dad108fa(#"distance_traveled", distance);
        player incrementplayerstat("time_played_total", player.pers[#"time_played_total"]);
        player add_map_stat("time_played_total", player.pers[#"time_played_total"]);
        recordplayermatchend(player);
        recordplayerstats(player, "present_at_end", 1);
        player zm_weapons::updateweapontimingszm(newtime);
        if (isdefined(level._game_module_stat_update_func)) {
            player [[ level._game_module_stat_update_func ]]();
        }
        if (isdefined(player.score_total)) {
            old_high_score = player get_global_stat("score");
            if (!isdefined(old_high_score) || player.score_total > old_high_score) {
                player set_global_stat("score", player.score_total);
            }
            player function_ab006044("TOTAL_POINTS", player.score_total);
            player function_1b763e4("HIGHEST_SCORE", player.score_total);
            player set_global_stat("total_points", player.score_total);
        }
        player function_1b763e4("HIGHEST_TEAM_SCORE", level.score_total);
        set_match_stat("TEAM_SCORE", level.score_total);
        player function_9daadcaa("team_score", level.score_total);
        player set_global_stat("rounds", level.round_number);
        player function_9daadcaa("rounds", level.round_number);
        total_rounds_survived = level.round_number - 1;
        if (zm_trial::is_trial_mode() && is_true(level.var_7fe57c6b)) {
            total_rounds_survived = level.round_number;
            player zm_challenges::function_bf0be8f1();
        }
        player function_9daadcaa("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
        if (level.onlinegame) {
            player highwater_global_stat("HIGHEST_ROUND_REACHED", level.round_number);
            player highwater_map_stat("HIGHEST_ROUND_REACHED", level.round_number);
            player function_d4e0d242("HIGHEST_ROUND_REACHED", level.round_number);
            player function_1b763e4("HIGHEST_ROUND_REACHED", level.round_number);
            player function_e8bfebb("HIGHEST_ROUND_REACHED", level.round_number);
            player function_1b763e4("MOST_KILLS", player.kills);
            player function_e8bfebb("MOST_KILLS", player.kills);
            player function_1b763e4("MOST_HEADSHOTS", player.headshots);
            player function_e8bfebb("MOST_HEADSHOTS", player.headshots);
            player function_f7885b2b("HIGHEST_ROUND_REACHED", level.round_number);
            player function_f7885b2b("MOST_KILLS", player.kills);
            player function_f7885b2b("MOST_HEADSHOTS", player.headshots);
            player add_global_stat("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
            player add_map_stat("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
            player function_ab006044("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
            player function_a6efb963("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
            player function_9288c79b("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
            player add_global_stat("TOTAL_GAMES_PLAYED", 1);
            player add_map_stat("TOTAL_GAMES_PLAYED", 1);
            player function_ab006044("TOTAL_GAMES_PLAYED", 1);
            player function_a6efb963("TOTAL_GAMES_PLAYED", 1);
            player function_9288c79b("TOTAL_GAMES_PLAYED", 1);
            if (zm_utility::is_standard() && level.var_5caadd40 > 1) {
                player contracts::increment_zm_contract(#"contract_zm_rush_games");
                if (player.var_9fc3ee66 === 1) {
                    player function_7bc347f6("RUSH_FIRST_PLACE_FINISHES");
                    player function_f1a1191d("RUSH_FIRST_PLACE_FINISHES");
                    player contracts::increment_zm_contract(#"contract_zm_rush_wins");
                }
            }
        }
        if (gamemodeismode(0)) {
            player gamehistoryfinishmatch(4, 0, 0, 0, 0, 0);
            if (isdefined(player.pers[#"matchesplayedstatstracked"])) {
                gamemode = util::getcurrentgamemode();
                player globallogic::incrementmatchcompletionstat(gamemode, "played", "completed");
                if (isdefined(player.pers[#"matcheshostedstatstracked"])) {
                    player globallogic::incrementmatchcompletionstat(gamemode, "hosted", "completed");
                    player.pers[#"matcheshostedstatstracked"] = undefined;
                }
                player.pers[#"matchesplayedstatstracked"] = undefined;
            }
        }
        if (!isdefined(player.pers[#"previous_distance_traveled"])) {
            player.pers[#"previous_distance_traveled"] = 0;
        }
        distancethisround = int(player.pers[#"distance_traveled"] - player.pers[#"previous_distance_traveled"]);
        player.pers[#"previous_distance_traveled"] = player.pers[#"distance_traveled"];
        player incrementplayerstat("distance_traveled", distancethisround);
    }
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x7fb318c1, Offset: 0x2fc0
// Size: 0x27c
function function_4dd876ad() {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats) || isbot(self)) {
        return;
    }
    self highwater_global_stat("HIGHEST_ROUND_REACHED", level.round_number);
    self highwater_map_stat("HIGHEST_ROUND_REACHED", level.round_number);
    self function_d4e0d242("HIGHEST_ROUND_REACHED", level.round_number);
    self function_1b763e4("HIGHEST_ROUND_REACHED", level.round_number);
    self function_e8bfebb("HIGHEST_ROUND_REACHED", level.round_number);
    self function_1b763e4("MOST_KILLS", self.kills);
    self function_e8bfebb("MOST_KILLS", self.kills);
    self function_1b763e4("MOST_HEADSHOTS", self.headshots);
    self function_e8bfebb("MOST_HEADSHOTS", self.headshots);
    self function_f7885b2b("HIGHEST_ROUND_REACHED", level.round_number);
    self function_f7885b2b("MOST_KILLS", self.kills);
    self function_f7885b2b("MOST_HEADSHOTS", self.headshots);
    self function_1b763e4("HIGHEST_SCORE", self.score_total);
    self function_1b763e4("HIGHEST_TEAM_SCORE", level.score_total);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xef008420, Offset: 0x3248
// Size: 0x1ac
function update_playing_utc_time(matchendutctime) {
    current_days = int(matchendutctime / 86400);
    last_days = self get_global_stat("TIMESTAMPLASTDAY1");
    last_days = int(last_days / 86400);
    diff_days = current_days - last_days;
    timestamp_name = "";
    if (diff_days > 0) {
        for (i = 5; i > diff_days; i--) {
            timestamp_name = "TIMESTAMPLASTDAY" + i - diff_days;
            timestamp_name_to = "TIMESTAMPLASTDAY" + i;
            timestamp_value = self get_global_stat(timestamp_name);
            self set_global_stat(timestamp_name_to, timestamp_value);
        }
        for (i = 2; i <= diff_days && i < 6; i++) {
            timestamp_name = "TIMESTAMPLASTDAY" + i;
            self set_global_stat(timestamp_name, 0);
        }
        self set_global_stat("TIMESTAMPLASTDAY1", matchendutctime);
    }
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x3400
// Size: 0x4
function survival_classic_custom_stat_update() {
    
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3410
// Size: 0x4
function grief_custom_stat_update() {
    
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xe606f79f, Offset: 0x3420
// Size: 0x3a
function get_global_stat(stat_name) {
    return self stats::get_stat(#"playerstatslist", stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x73c456fa, Offset: 0x3468
// Size: 0xe4
function set_global_stat(stat_name, value) {
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    self stats::set_stat(#"playerstatslist", stat_name, #"statvalue", value);
    /#
        var_ba1fb8c1 = self stats::get_stat(#"playerstatslist", stat_name, #"statvalue");
        println("<dev string:x38>" + self.entity_num + "<dev string:x43>" + stat_name + "<dev string:x48>" + var_ba1fb8c1);
    #/
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x60afc065, Offset: 0x3558
// Size: 0x64
function add_global_stat(stat_name, value) {
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    self stats::inc_stat(#"playerstatslist", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xf760d6f6, Offset: 0x35c8
// Size: 0x5c
function increment_global_stat(stat_name) {
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    self stats::inc_stat(#"playerstatslist", stat_name, #"statvalue", 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x936abc48, Offset: 0x3630
// Size: 0x44
function highwater_global_stat(stat_name, value) {
    if (value > get_global_stat(stat_name)) {
        set_global_stat(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x6d3c0aa1, Offset: 0x3680
// Size: 0x3a
function get_client_stat(stat_name) {
    return self stats::get_stat(#"playerstatslist", stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 3, eflags: 0x1 linked
// Checksum 0xfb459332, Offset: 0x36c8
// Size: 0xa8
function add_client_stat(stat_name, stat_value, include_gametype) {
    if (is_true(level.zm_disable_recording_stats) || !isarray(self.pers)) {
        return;
    }
    if (!isdefined(include_gametype)) {
        include_gametype = 1;
    }
    self globallogic_score::incpersstat(hash(stat_name), stat_value, 0, include_gametype);
    self.stats_this_frame[stat_name] = 1;
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xed246247, Offset: 0x3778
// Size: 0x44
function increment_player_stat(stat_name) {
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    self incrementplayerstat(stat_name, 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xe207a12c, Offset: 0x37c8
// Size: 0x4c
function increment_root_stat(stat_name, stat_value) {
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    self stats::inc_stat(stat_name, stat_value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x9f76cddd, Offset: 0x3820
// Size: 0x4c
function increment_client_stat(stat_name, include_gametype) {
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    add_client_stat(stat_name, 1, include_gametype);
}

// Namespace zm_stats/zm_stats
// Params 3, eflags: 0x0
// Checksum 0xb0d02a26, Offset: 0x3878
// Size: 0xb8
function set_client_stat(stat_name, stat_value, include_gametype) {
    if (is_true(level.zm_disable_recording_stats) || !isarray(self.pers)) {
        return;
    }
    current_stat_count = self globallogic_score::getpersstat(stat_name);
    self globallogic_score::incpersstat(hash(stat_name), stat_value - current_stat_count, 0, include_gametype);
    self.stats_this_frame[stat_name] = 1;
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x20d80629, Offset: 0x3938
// Size: 0xb8
function zero_client_stat(stat_name, include_gametype) {
    if (is_true(level.zm_disable_recording_stats) || !isarray(self.pers)) {
        return;
    }
    current_stat_count = self globallogic_score::getpersstat(stat_name);
    self globallogic_score::incpersstat(hash(stat_name), current_stat_count * -1, 0, include_gametype);
    self.stats_this_frame[stat_name] = 1;
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0x7c8eb88a, Offset: 0x39f8
// Size: 0x52
function get_map_stat(stat_name) {
    return self stats::get_stat(#"playerstatsbymap", level.script, #"stats", stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x1265fa03, Offset: 0x3a58
// Size: 0x8c
function set_map_stat(stat_name, value) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    self stats::set_stat(#"playerstatsbymap", level.script, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x7ccd61d5, Offset: 0x3af0
// Size: 0x8c
function add_map_stat(stat_name, value) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    self stats::inc_stat(#"playerstatsbymap", level.script, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xf99fa80a, Offset: 0x3b88
// Size: 0x84
function increment_map_stat(stat_name) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    self stats::inc_stat(#"playerstatsbymap", level.script, #"stats", stat_name, #"statvalue", 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x2b7a743f, Offset: 0x3c18
// Size: 0x44
function highwater_map_stat(stat_name, value) {
    if (value > get_map_stat(stat_name)) {
        set_map_stat(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0x50b100e2, Offset: 0x3c68
// Size: 0x6c
function increment_map_cheat_stat(stat_name) {
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    self stats::inc_stat(#"playerstatsbymap", level.script, #"cheats", stat_name, 1);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0x50104904, Offset: 0x3ce0
// Size: 0x72
function function_56ec2437(stat_name) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return 0;
    }
    return stats::get_stat(#"playerstatsbygametype", level.gametype, stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xd975464a, Offset: 0x3d60
// Size: 0x7c
function function_4d4e2a78(stat_name, value) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    stats::set_stat(#"playerstatsbygametype", level.gametype, stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x5e51d800, Offset: 0x3de8
// Size: 0x7c
function function_ab006044(stat_name, value) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    stats::inc_stat(#"playerstatsbygametype", level.gametype, stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0x1bb1f414, Offset: 0x3e70
// Size: 0x74
function function_7bc347f6(stat_name) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    stats::inc_stat(#"playerstatsbygametype", level.gametype, stat_name, #"statvalue", 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xc2e38200, Offset: 0x3ef0
// Size: 0x44
function function_d4e0d242(stat_name, value) {
    if (value > function_56ec2437(stat_name)) {
        function_4d4e2a78(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0x1c496401, Offset: 0x3f40
// Size: 0x9a
function function_b1520544(stat_name) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return 0;
    }
    return stats::get_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"stats", stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x6f0d9d34, Offset: 0x3fe8
// Size: 0xa4
function function_49469f35(stat_name, value) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    stats::set_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x305d4f0d, Offset: 0x4098
// Size: 0xa4
function function_a6efb963(stat_name, value) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    stats::inc_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xd529efbc, Offset: 0x4148
// Size: 0x9c
function function_f1a1191d(stat_name) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    stats::inc_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"stats", stat_name, #"statvalue", 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xa9b9985c, Offset: 0x41f0
// Size: 0x74
function function_1b763e4(stat_name, value) {
    if (!isdefined(value)) {
        return;
    }
    if (!isdefined(stat_name)) {
        return;
    }
    current = function_b1520544(stat_name);
    if (!isdefined(current)) {
        return;
    }
    if (value > current) {
        function_49469f35(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xd24d28a5, Offset: 0x4270
// Size: 0xb2
function function_523fee8d(stat_name) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return 0;
    }
    return stats::get_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"hash_413b4abc26595b34", level.gamedifficulty, #"stats", stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x842797a, Offset: 0x4330
// Size: 0xbc
function function_7866854a(stat_name, value) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    stats::set_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"hash_413b4abc26595b34", level.gamedifficulty, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x6bc3c407, Offset: 0x43f8
// Size: 0xbc
function function_9288c79b(stat_name, value) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    stats::inc_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"hash_413b4abc26595b34", level.gamedifficulty, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xb5ed71f3, Offset: 0x44c0
// Size: 0xb4
function function_2726a7c2(stat_name) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    stats::inc_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"hash_413b4abc26595b34", level.gamedifficulty, #"stats", stat_name, #"statvalue", 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x627e9549, Offset: 0x4580
// Size: 0x44
function function_e8bfebb(stat_name, value) {
    if (value > function_523fee8d(stat_name)) {
        function_7866854a(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 3, eflags: 0x1 linked
// Checksum 0x5fe59cd3, Offset: 0x45d0
// Size: 0x94
function function_366b6fb9(stat_name, value, var_48038375 = 0) {
    var_cbd5530c = function_523fee8d(stat_name);
    if (value < var_cbd5530c || value > 0 && var_cbd5530c == 0 && !var_48038375) {
        function_7866854a(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xb5e50e11, Offset: 0x4670
// Size: 0xca
function function_8e274b32(stat_name) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats) || !zm_utility::is_trials()) {
        return 0;
    }
    assert(isdefined(level.var_6d87ac05) && isdefined(level.var_6d87ac05.name));
    return stats::get_stat(#"hash_5abf25946ab0ce9a", level.var_6d87ac05.name, stat_name);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xa9ba275e, Offset: 0x4748
// Size: 0xd4
function function_a05b3b23(stat_name, value) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats) || !zm_utility::is_trials()) {
        return;
    }
    assert(isdefined(level.var_6d87ac05) && isdefined(level.var_6d87ac05.name), "<dev string:x5a>");
    stats::set_stat(#"hash_5abf25946ab0ce9a", level.var_6d87ac05.name, stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xa5181433, Offset: 0x4828
// Size: 0xcc
function registerchand_grow_(stat_name) {
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats) || !zm_utility::is_trials()) {
        return;
    }
    assert(isdefined(level.var_6d87ac05) && isdefined(level.var_6d87ac05.name), "<dev string:xac>");
    stats::inc_stat(#"hash_5abf25946ab0ce9a", level.var_6d87ac05.name, stat_name, 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xa7fb5417, Offset: 0x4900
// Size: 0x44
function function_f7885b2b(stat_name, n_value) {
    if (n_value > function_8e274b32(stat_name)) {
        function_a05b3b23(stat_name, n_value);
    }
}

// Namespace zm_stats/zm_stats
// Params 3, eflags: 0x0
// Checksum 0x9dd8e582, Offset: 0x4950
// Size: 0x94
function function_31931250(stat_name, n_value, var_48038375 = 0) {
    var_cbd5530c = function_8e274b32(stat_name);
    if (n_value < var_cbd5530c || n_value > 0 && var_cbd5530c == 0 && !var_48038375) {
        function_a05b3b23(stat_name, n_value);
    }
}

// Namespace zm_stats/zm_stats
// Params 3, eflags: 0x1 linked
// Checksum 0xf224a26a, Offset: 0x49f0
// Size: 0x1a4
function increment_challenge_stat(stat_name, amount = 1, var_b68b08b1 = 0) {
    assert(ishash(stat_name), "<dev string:xf7>");
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats) || var_b68b08b1 && zm_utility::is_standard()) {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    self stats::function_dad108fa(stat_name, amount);
    /#
        var_ba1fb8c1 = self stats::get_stat_global(stat_name);
        if (isdefined(self.entity_num)) {
            println("<dev string:x38>" + self.entity_num + "<dev string:x43>" + function_9e72a96(stat_name) + "<dev string:x48>" + var_ba1fb8c1);
            return;
        }
        println("<dev string:x38>" + function_9e72a96(stat_name) + "<dev string:x48>" + var_ba1fb8c1);
    #/
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0x79e694aa, Offset: 0x4ba0
// Size: 0x3a
function get_match_stat(stat_name) {
    if (is_true(level.zm_disable_recording_stats)) {
        return 0;
    }
    return match_record::get_stat(stat_name);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x2e1ddeaf, Offset: 0x4be8
// Size: 0x4c
function set_match_stat(stat_name, value) {
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    match_record::set_stat(stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x52a0b2ec, Offset: 0x4c40
// Size: 0x4c
function add_match_stat(stat_name, value) {
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    match_record::inc_stat(stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x604afe22, Offset: 0x4c98
// Size: 0x44
function increment_match_stat(stat_name) {
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    match_record::inc_stat(stat_name, 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xb707ad29, Offset: 0x4ce8
// Size: 0x44
function function_57febe39(stat_name, value) {
    if (value > get_match_stat(stat_name)) {
        set_match_stat(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xc13bed9f, Offset: 0x4d38
// Size: 0x42
function function_529e1302(stat_name) {
    if (is_true(level.zm_disable_recording_stats)) {
        return 0;
    }
    return self match_record::get_player_stat(stat_name);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xfa4ff270, Offset: 0x4d88
// Size: 0x6c
function function_ae547e45(stat_name, value) {
    if (is_true(level.zm_disable_recording_stats) && !issubstr(stat_name, "boas_")) {
        return;
    }
    self match_record::set_player_stat(stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xda6cb7c, Offset: 0x4e00
// Size: 0x6c
function function_301c4be2(stat_name, value) {
    if (is_true(level.zm_disable_recording_stats) && !issubstr(stat_name, "boas_")) {
        return;
    }
    self match_record::function_34800eec(stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0x8df89561, Offset: 0x4e78
// Size: 0x6c
function function_8f10788e(stat_name) {
    if (is_true(level.zm_disable_recording_stats) && !issubstr(stat_name, "boas_")) {
        return;
    }
    self match_record::function_34800eec(stat_name, 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xb22d1810, Offset: 0x4ef0
// Size: 0x64
function function_5d0e6000(stat_name, value) {
    var_cbd5530c = self function_529e1302(stat_name);
    if (!isdefined(var_cbd5530c)) {
        return;
    }
    if (value > var_cbd5530c) {
        self function_ae547e45(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xa6130009, Offset: 0x4f60
// Size: 0x2a
function function_e4358abd(stat_name) {
    return self stats::get_stat(#"afteractionreportstats", stat_name);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xa3373ca5, Offset: 0x4f98
// Size: 0x3c
function function_9daadcaa(stat_name, value) {
    self stats::set_stat(#"afteractionreportstats", stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xf52091b7, Offset: 0x4fe0
// Size: 0x3c
function function_96087e7(stat_name, value) {
    self stats::inc_stat(#"afteractionreportstats", stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xcae1cb7e, Offset: 0x5028
// Size: 0x34
function function_3468f864(stat_name) {
    self stats::inc_stat(#"afteractionreportstats", stat_name, 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xb69f225, Offset: 0x5068
// Size: 0x4c
function function_69317807(stat_name, value) {
    if (value > self function_e4358abd(stat_name)) {
        self function_9daadcaa(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 4, eflags: 0x1 linked
// Checksum 0xf800df04, Offset: 0x50c0
// Size: 0xf84
function handle_death(einflictor, eattacker, weapon, *smeansofdeath) {
    entity = self;
    if (isplayer(entity) && isdefined(weapon.archetype)) {
        switch (weapon.archetype) {
        case #"blight_father":
            entity increment_client_stat("killed_by_blightfather");
            entity increment_player_stat("killed_by_blightfather");
            entity function_8f10788e("boas_killed_by_blightfather");
            break;
        case #"brutus":
            entity increment_client_stat("killed_by_brutus");
            entity increment_player_stat("killed_by_brutus");
            entity function_8f10788e("boas_killed_by_brutus");
            break;
        case #"gladiator":
            entity increment_client_stat("killed_by_gladiator");
            entity increment_player_stat("killed_by_gladiator");
            entity function_8f10788e("boas_killed_by_gladiator");
            break;
        case #"stoker":
            entity increment_client_stat("killed_by_stoker");
            entity increment_player_stat("killed_by_stoker");
            entity function_8f10788e("boas_killed_by_stoker");
            break;
        case #"tiger":
            entity increment_client_stat("killed_by_tiger");
            entity increment_player_stat("killed_by_tiger");
            entity function_8f10788e("boas_killed_by_tiger");
            break;
        case #"catalyst":
            entity increment_client_stat("killed_by_catalyst");
            entity increment_player_stat("killed_by_catalyst");
            entity function_8f10788e("boas_killed_by_catalyst");
            switch (weapon.var_9fde8624) {
            case #"catalyst_electric":
                entity increment_client_stat("killed_by_catalyst_electric");
                entity increment_player_stat("killed_by_catalyst_electric");
                entity function_8f10788e("boas_killed_by_catalyst_electric");
                break;
            case #"catalyst_water":
                entity increment_client_stat("killed_by_catalyst_water");
                entity increment_player_stat("killed_by_catalyst_water");
                entity function_8f10788e("boas_killed_by_catalyst_water");
                break;
            case #"catalyst_plasma":
                entity increment_client_stat("killed_by_catalyst_plasma");
                entity increment_player_stat("killed_by_catalyst_plasma");
                entity function_8f10788e("boas_killed_by_catalyst_plasma");
                break;
            case #"catalyst_corrosive":
                entity increment_client_stat("killed_by_catalyst_corrosive");
                entity increment_player_stat("killed_by_catalyst_corrosive");
                entity function_8f10788e("boas_killed_by_catalyst_corrosive");
                break;
            }
            break;
        case #"nova_crawler":
            entity increment_client_stat("killed_by_nova_crawler");
            entity increment_player_stat("killed_by_nova_crawler");
            entity function_8f10788e("boas_killed_by_nova_crawler");
            break;
        case #"zombie_dog":
            entity increment_client_stat("killed_by_zdog");
            entity increment_player_stat("killed_by_zdog");
            entity function_8f10788e("boas_killed_by_zdog");
            break;
        case #"nosferatu":
            if (weapon.var_9fde8624 === #"crimson_nosferatu") {
                entity increment_client_stat("killed_by_crimson_nosferatu");
                entity increment_player_stat("killed_by_crimson_nosferatu");
                entity function_8f10788e("boas_killed_by_crimson_nosferatu");
            } else {
                entity increment_client_stat("killed_by_nosferatu");
                entity increment_player_stat("killed_by_nosferatu");
                entity function_8f10788e("boas_killed_by_nosferatu");
            }
            break;
        case #"werewolf":
            entity increment_client_stat("killed_by_werewolf");
            entity increment_player_stat("killed_by_werewolf");
            entity function_8f10788e("boas_killed_by_werewolf");
            break;
        }
        return;
    }
    if (isplayer(weapon)) {
        if (isdefined(entity.archetype)) {
            switch (entity.archetype) {
            case #"blight_father":
                weapon increment_client_stat("blightfathers_killed");
                weapon increment_player_stat("blightfathers_killed");
                weapon function_8f10788e("boas_blightfathers_killed");
                break;
            case #"brutus":
                weapon increment_client_stat("brutuses_killed");
                weapon increment_player_stat("brutuses_killed");
                weapon function_8f10788e("boas_brutuses_killed");
                break;
            case #"gladiator":
                weapon increment_client_stat("gladiators_killed");
                weapon increment_player_stat("gladiators_killed");
                weapon function_8f10788e("boas_gladiators_killed");
                break;
            case #"stoker":
                weapon increment_client_stat("stokers_killed");
                weapon increment_player_stat("stokers_killed");
                weapon function_8f10788e("boas_stokers_killed");
                break;
            case #"tiger":
                weapon increment_client_stat("tigers_killed");
                weapon increment_player_stat("tigers_killed");
                weapon function_8f10788e("boas_tigers_killed");
                break;
            case #"catalyst":
                weapon increment_client_stat("catalysts_killed");
                weapon increment_player_stat("catalysts_killed");
                weapon function_8f10788e("boas_catalysts_killed");
                switch (entity.var_9fde8624) {
                case #"catalyst_electric":
                    weapon increment_client_stat("catalyst_electrics_killed");
                    weapon increment_player_stat("catalyst_electrics_killed");
                    weapon function_8f10788e("boas_catalyst_electrics_killed");
                    break;
                case #"catalyst_water":
                    weapon increment_client_stat("catalyst_waters_killed");
                    weapon increment_player_stat("catalyst_waters_killed");
                    weapon function_8f10788e("boas_catalyst_waters_killed");
                    break;
                case #"catalyst_plasma":
                    weapon increment_client_stat("catalyst_plasmas_killed");
                    weapon increment_player_stat("catalyst_plasmas_killed");
                    weapon function_8f10788e("boas_catalyst_plasmas_killed");
                    break;
                case #"catalyst_corrosive":
                    weapon increment_client_stat("catalyst_corrosives_killed");
                    weapon increment_player_stat("catalyst_corrosives_killed");
                    weapon function_8f10788e("boas_catalyst_corrosives_killed");
                    break;
                }
                break;
            case #"nova_crawler":
                weapon increment_client_stat("nova_crawlers_killed");
                weapon increment_player_stat("nova_crawlers_killed");
                weapon function_8f10788e("boas_nova_crawlers_killed");
                break;
            case #"zombie_dog":
                weapon increment_client_stat("zdogs_killed");
                weapon increment_player_stat("zdogs_killed");
                weapon function_8f10788e("boas_zdogs_killed");
                break;
            case #"nosferatu":
                if (entity.var_9fde8624 === #"crimson_nosferatu") {
                    weapon increment_client_stat("crimson_nosferatus_killed");
                    weapon increment_player_stat("crimson_nosferatus_killed");
                    weapon function_8f10788e("boas_crimson_nosferatus_killed");
                } else {
                    weapon increment_client_stat("nosferatus_killed");
                    weapon increment_player_stat("nosferatus_killed");
                    weapon function_8f10788e("boas_nosferatus_killed");
                }
                break;
            case #"werewolf":
                weapon increment_client_stat("werewolves_killed");
                weapon increment_player_stat("werewolves_killed");
                weapon function_8f10788e("boas_werewolves_killed");
                break;
            case #"bat":
                weapon increment_client_stat("bats_killed");
                weapon increment_player_stat("bats_killed");
                weapon function_8f10788e("boas_bats_killed");
                break;
            }
        }
        if (zm_weapons::is_wonder_weapon(smeansofdeath)) {
            weapon increment_client_stat("wonder_weapon_kills");
            weapon increment_player_stat("wonder_weapon_kills");
            weapon function_8f10788e("boas_wonder_weapon_kills");
        }
        if (isdefined(eattacker) && isdefined(eattacker.turret) && isdefined(eattacker.turret.item)) {
            weapon stats::function_e24eec31(eattacker.turret.item, #"kills", 1);
        }
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xe250d10c, Offset: 0x6050
// Size: 0x94
function track_craftables_pickedup(craftable) {
    player = self;
    if (is_true(craftable.isriotshield)) {
        player increment_client_stat("shields_purchased");
        player increment_player_stat("shields_purchased");
        player function_8f10788e("boas_shields_purchased");
    }
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x89c0450a, Offset: 0x60f0
// Size: 0xb4
function get_stat_distance_traveled() {
    miles = int(self.pers[#"distance_traveled"] / 63360);
    remainder = self.pers[#"distance_traveled"] / 63360 - miles;
    if (miles < 1 && remainder < 0.5) {
        miles = 1;
    } else if (remainder >= 0.5) {
        miles++;
    }
    return miles;
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0xe083d31b, Offset: 0x61b0
// Size: 0x12
function get_stat_round_number() {
    return zm_round_logic::get_round_number();
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x0
// Checksum 0x38d9d48e, Offset: 0x61d0
// Size: 0x76
function get_stat_combined_rank_value_survival_classic() {
    rounds = get_stat_round_number();
    kills = self.pers[#"kills"];
    if (rounds > 99) {
        rounds = 99;
    }
    result = rounds * 10000000 + kills;
    return result;
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0xe0b2a4f, Offset: 0x6250
// Size: 0x1616
function update_global_counters_on_match_end() {
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    deaths = 0;
    kills = 0;
    melee_kills = 0;
    wonder_weapon_kills = 0;
    headshots = 0;
    suicides = 0;
    downs = 0;
    revives = 0;
    perks_drank = 0;
    doors_purchased = 0;
    distance_traveled = 0;
    total_shots = 0;
    boards = 0;
    sacrifices = 0;
    drops = 0;
    nuke_pickedup = 0;
    insta_kill_pickedup = 0;
    full_ammo_pickedup = 0;
    double_points_pickedup = 0;
    meat_stink_pickedup = 0;
    carpenter_pickedup = 0;
    fire_sale_pickedup = 0;
    var_d61f06ce = 0;
    minigun_pickedup = 0;
    island_seed_pickedup = 0;
    hero_weapon_power_pickedup = 0;
    pack_a_punch_pickedup = 0;
    extra_lives_pickedup = 0;
    zmarcade_key_pickedup = 0;
    shield_charge_pickedup = 0;
    dung_pickedup = 0;
    bonus_points_team_pickedup = 0;
    ww_grenade_pickedup = 0;
    zombie_blood_pickedup = 0;
    use_magicbox = 0;
    grabbed_from_magicbox = 0;
    use_perk_random = 0;
    grabbed_from_perk_random = 0;
    use_pap = 0;
    pap_weapon_grabbed = 0;
    blightfathers_killed = 0;
    killed_by_blightfather = 0;
    brutuses_killed = 0;
    killed_by_brutus = 0;
    gladiators_killed = 0;
    killed_by_gladiator = 0;
    stokers_killed = 0;
    killed_by_stoker = 0;
    tigers_killed = 0;
    killed_by_tiger = 0;
    catalysts_killed = 0;
    killed_by_catalyst = 0;
    catalyst_electrics_killed = 0;
    killed_by_catalyst_electric = 0;
    catalyst_waters_killed = 0;
    killed_by_catalyst_water = 0;
    catalyst_plasmas_killed = 0;
    killed_by_catalyst_plasma = 0;
    catalyst_corrosives_killed = 0;
    killed_by_catalyst_corrosive = 0;
    nova_crawlers_killed = 0;
    killed_by_nova_crawler = 0;
    werewolves_killed = 0;
    killed_by_werewolf = 0;
    nosferatus_killed = 0;
    killed_by_nosferatu = 0;
    crimson_nosferatus_killed = 0;
    killed_by_crimson_nosferatu = 0;
    bats_killed = 0;
    specialty_armorvest_drank = 0;
    specialty_quickrevive_drank = 0;
    specialty_fastreload_drank = 0;
    specialty_additionalprimaryweapon_drank = 0;
    specialty_staminup_drank = 0;
    specialty_doubletap2_drank = 0;
    specialty_widowswine_drank = 0;
    specialty_deadshot_drank = 0;
    specialty_awareness_drank = 0;
    var_fe5dcda2 = 0;
    var_48fd5671 = 0;
    specialty_cooldown_drank = 0;
    specialty_extraammo_drank = 0;
    var_a73cd9fe = 0;
    specialty_phdflopper_drank = 0;
    specialty_shield_drank = 0;
    specialty_etherealrazor_drank = 0;
    var_b972d467 = 0;
    var_16a0e615 = 0;
    var_46c7e904 = 0;
    var_1e13347b = 0;
    var_c56462cf = 0;
    var_f6b5833a = 0;
    var_e984eacc = 0;
    var_aea053fa = 0;
    var_eb45709f = 0;
    var_33a5b509 = 0;
    var_ac975a7f = 0;
    var_8405e59d = 0;
    var_2ecaa90f = 0;
    var_4454cfa3 = 0;
    var_f512508c = 0;
    var_6f5b5ff = 0;
    claymores_planted = 0;
    claymores_pickedup = 0;
    bouncingbetty_planted = 0;
    ballistic_knives_pickedup = 0;
    wallbuy_weapons_purchased = 0;
    power_turnedon = 0;
    power_turnedoff = 0;
    planted_buildables_pickedup = 0;
    ammo_purchased = 0;
    upgraded_ammo_purchased = 0;
    shields_purchased = 0;
    buildables_built = 0;
    time_played = 0;
    cheat_too_many_weapons = 0;
    cheat_out_of_playable_area = 0;
    cheat_too_friendly = 0;
    cheat_total = 0;
    players = getplayers();
    foreach (player in players) {
        deaths += player.pers[#"deaths"];
        kills += player.pers[#"kills"];
        wonder_weapon_kills += player.pers[#"wonder_weapon_kills"];
        headshots += player.pers[#"headshots"];
        suicides += player.pers[#"suicides"];
        melee_kills += player.pers[#"melee_kills"];
        downs += player.pers[#"downs"];
        revives += player.pers[#"revives"];
        perks_drank += player.pers[#"perks_drank"];
        specialty_armorvest_drank += player.pers[#"specialty_armorvest_drank"];
        specialty_quickrevive_drank += player.pers[#"specialty_quickrevive_drank"];
        specialty_fastreload_drank += player.pers[#"specialty_fastreload_drank"];
        specialty_additionalprimaryweapon_drank += player.pers[#"specialty_additionalprimaryweapon_drank"];
        specialty_staminup_drank += player.pers[#"specialty_staminup_drank"];
        specialty_doubletap2_drank += player.pers[#"specialty_doubletap2_drank"];
        specialty_widowswine_drank += player.pers[#"specialty_widowswine_drank"];
        specialty_deadshot_drank += player.pers[#"specialty_deadshot_drank"];
        specialty_awareness_drank += player.pers[#"specialty_awareness_drank"];
        var_fe5dcda2 += player.pers[#"hash_583ff5f66fd10104"];
        var_48fd5671 += player.pers[#"hash_3cbaa7dc09e06bb7"];
        specialty_cooldown_drank += player.pers[#"specialty_cooldown_drank"];
        specialty_extraammo_drank += player.pers[#"specialty_extraammo_drank"];
        var_a73cd9fe += player.pers[#"hash_3c548389d8524d38"];
        specialty_phdflopper_drank += player.pers[#"specialty_phdflopper_drank"];
        specialty_shield_drank += player.pers[#"specialty_shield_drank"];
        specialty_etherealrazor_drank += player.pers[#"specialty_etherealrazor_drank"];
        var_b972d467 += player.pers[#"hash_3d9b732ca303132b"];
        var_16a0e615 += player.pers[#"hash_48288866afddc0d4"];
        var_46c7e904 += player.pers[#"hash_1dc1fbd3fd2fe493"];
        var_1e13347b += player.pers[#"hash_49cc8e6486122824"];
        var_c56462cf += player.pers[#"hash_382854bc103fd553"];
        var_f6b5833a += player.pers[#"hash_4419d00a9f04f866"];
        var_e984eacc += player.pers[#"hash_5a42a4d4accf00bf"];
        var_aea053fa += player.pers[#"hash_dd2dc50d66eb166"];
        var_eb45709f += player.pers[#"hash_79d41974c40c126e"];
        var_33a5b509 += player.pers[#"hash_5c9c943cd0cffc65"];
        var_ac975a7f += player.pers[#"hash_7d98fe4413e871a4"];
        var_8405e59d += player.pers[#"hash_402bebef02213c02"];
        var_2ecaa90f += player.pers[#"hash_2a63229e9bf23baa"];
        var_4454cfa3 += player.pers[#"hash_41476f0bb1f7c683"];
        var_f512508c += player.pers[#"hash_254f75482929079b"];
        var_6f5b5ff += player.pers[#"hash_3bd6bf00e8c71a5d"];
        doors_purchased += player.pers[#"doors_purchased"];
        distance_traveled += player get_stat_distance_traveled();
        boards += player.pers[#"boards"];
        sacrifices += player.pers[#"sacrifices"];
        drops += player.pers[#"drops"];
        nuke_pickedup += player.pers[#"nuke_pickedup"];
        insta_kill_pickedup += player.pers[#"insta_kill_pickedup"];
        full_ammo_pickedup += player.pers[#"full_ammo_pickedup"];
        double_points_pickedup += player.pers[#"double_points_pickedup"];
        meat_stink_pickedup += player.pers[#"meat_stink_pickedup"];
        carpenter_pickedup += player.pers[#"carpenter_pickedup"];
        fire_sale_pickedup += player.pers[#"fire_sale_pickedup"];
        var_d61f06ce += player.pers[#"hash_27399de28b76c5c6"];
        minigun_pickedup += player.pers[#"minigun_pickedup"];
        island_seed_pickedup += player.pers[#"island_seed_pickedup"];
        hero_weapon_power_pickedup += player.pers[#"hero_weapon_power_pickedup"];
        pack_a_punch_pickedup += player.pers[#"pack_a_punch_pickedup"];
        extra_lives_pickedup += player.pers[#"extra_lives_pickedup"];
        zmarcade_key_pickedup += player.pers[#"zmarcade_key_pickedup"];
        shield_charge_pickedup += player.pers[#"shield_charge_pickedup"];
        dung_pickedup += player.pers[#"dung_pickedup"];
        bonus_points_team_pickedup += player.pers[#"bonus_points_team_pickedup"];
        ww_grenade_pickedup += player.pers[#"ww_grenade_pickedup"];
        use_magicbox += player.pers[#"use_magicbox"];
        grabbed_from_magicbox += player.pers[#"grabbed_from_magicbox"];
        use_perk_random += player.pers[#"use_perk_random"];
        grabbed_from_perk_random += player.pers[#"grabbed_from_perk_random"];
        use_pap += player.pers[#"use_pap"];
        pap_weapon_grabbed += player.pers[#"pap_weapon_grabbed"];
        claymores_planted += player.pers[#"claymores_planted"];
        claymores_pickedup += player.pers[#"claymores_pickedup"];
        bouncingbetty_planted += player.pers[#"bouncingbetty_planted"];
        ballistic_knives_pickedup += player.pers[#"ballistic_knives_pickedup"];
        wallbuy_weapons_purchased += player.pers[#"wallbuy_weapons_purchased"];
        power_turnedon += player.pers[#"power_turnedon"];
        power_turnedoff += player.pers[#"power_turnedoff"];
        planted_buildables_pickedup += player.pers[#"planted_buildables_pickedup"];
        buildables_built += player.pers[#"buildables_built"];
        ammo_purchased += player.pers[#"ammo_purchased"];
        upgraded_ammo_purchased += player.pers[#"upgraded_ammo_purchased"];
        shields_purchased += player.pers[#"shields_purchased"];
        if (!isdefined(player.total_shots)) {
            player.total_shots = 0;
        }
        total_shots += player.total_shots;
        time_played += player.pers[#"time_played_total"];
        cheat_too_many_weapons += player.pers[#"cheat_too_many_weapons"];
        cheat_out_of_playable_area += player.pers[#"cheat_out_of_playable"];
        cheat_too_friendly += player.pers[#"cheat_too_friendly"];
        cheat_total += player.pers[#"cheat_total"];
        blightfathers_killed += player.pers[#"blightfathers_killed"];
        killed_by_blightfather += player.pers[#"killed_by_blightfather"];
        brutuses_killed += player.pers[#"brutuses_killed"];
        killed_by_brutus += player.pers[#"killed_by_brutus"];
        gladiators_killed += player.pers[#"gladiators_killed"];
        killed_by_gladiator += player.pers[#"killed_by_gladiator"];
        stokers_killed += player.pers[#"stokers_killed"];
        killed_by_stoker += player.pers[#"killed_by_stoker"];
        tigers_killed += player.pers[#"tigers_killed"];
        killed_by_tiger += player.pers[#"killed_by_tiger"];
        catalysts_killed += player.pers[#"catalysts_killed"];
        killed_by_catalyst += player.pers[#"killed_by_catalyst"];
        catalyst_electrics_killed += player.pers[#"catalyst_electrics_killed"];
        killed_by_catalyst_electric += player.pers[#"killed_by_catalyst_electric"];
        catalyst_waters_killed += player.pers[#"catalyst_waters_killed"];
        killed_by_catalyst_water += player.pers[#"killed_by_catalyst_water"];
        catalyst_plasmas_killed += player.pers[#"catalyst_plasmas_killed"];
        killed_by_catalyst_plasma += player.pers[#"killed_by_catalyst_plasma"];
        catalyst_corrosives_killed += player.pers[#"catalyst_corrosives_killed"];
        killed_by_catalyst_corrosive += player.pers[#"killed_by_catalyst_corrosive"];
        nova_crawlers_killed += player.pers[#"nova_crawlers_killed"];
        killed_by_nova_crawler += player.pers[#"killed_by_nova_crawler"];
        werewolves_killed += player.pers[#"werewolves_killed"];
        killed_by_werewolf += player.pers[#"killed_by_werewolf"];
        nosferatus_killed += player.pers[#"nosferatus_killed"];
        killed_by_nosferatu += player.pers[#"killed_by_nosferatu"];
        crimson_nosferatus_killed += player.pers[#"crimson_nosferatus_killed"];
        killed_by_crimson_nosferatu += player.pers[#"killed_by_crimson_nosferatu"];
        bats_killed += player.pers[#"bats_killed"];
    }
    game_mode = util::get_game_type();
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x65ce3ae0, Offset: 0x7870
// Size: 0x3a
function get_specific_stat(stat_category, stat_name) {
    return self stats::get_stat(stat_category, stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x4b1be4dd, Offset: 0x78b8
// Size: 0xd4
function initializematchstats() {
    if (!level.onlinegame || !gamemodeismode(0) || zm_utility::is_survival()) {
        return;
    }
    self.pers[#"lasthighestscore"] = self stats::get_stat(#"higheststats", #"highest_score");
    currgametype = level.gametype;
    self gamehistorystartmatch(getgametypeenumfromname(currgametype, 0));
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x495d78e5, Offset: 0x7998
// Size: 0x74
function adjustrecentstats() {
    /#
        if (getdvarint(#"scr_writeconfigstrings", 0) == 1 || getdvarint(#"scr_hostmigrationtest", 0) == 1) {
            return;
        }
    #/
    initializematchstats();
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x939b3ca0, Offset: 0x7a18
// Size: 0x54
function uploadstatssoon() {
    self notify(#"upload_stats_soon");
    self endon(#"upload_stats_soon");
    self endon(#"disconnect");
    wait 1;
    uploadstats(self);
}

// Namespace zm_stats/zm_stats
// Params 4, eflags: 0x1 linked
// Checksum 0x4b4c31db, Offset: 0x7a78
// Size: 0x84
function function_7741345e(player, *w_current, n_shots_fired, n_hits) {
    if (isdefined(n_shots_fired)) {
        w_current function_301c4be2("boas_total_shots", n_shots_fired);
    }
    if (isdefined(n_hits) && n_hits > 0) {
        w_current function_301c4be2("boas_hits", n_hits);
    }
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x1ead1ea8, Offset: 0x7b08
// Size: 0x90
function function_b14863c1() {
    level endon(#"end_game");
    level thread function_cb8a5c29();
    level thread function_c5f9ea85();
    while (true) {
        wait getdvar(#"hash_83577689a2e58b3", 180);
        function_ea5b4947();
    }
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x4862e76e, Offset: 0x7ba0
// Size: 0xaa
function function_cb8a5c29() {
    while (true) {
        s_result = level waittilltimeout(60, #"hash_3fdaafe712252cf5", #"trap_kill");
        if (s_result._notify == "timeout") {
            level.var_b8cbd9e6 = 1;
            level waittill(#"hash_3fdaafe712252cf5", #"trap_kill");
            level.var_b8cbd9e6 = undefined;
        }
    }
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0xf70e9eb0, Offset: 0x7c58
// Size: 0x16c
function function_c5f9ea85() {
    level notify(#"hash_e3b3a7b31bbf19e");
    level endon(#"hash_e3b3a7b31bbf19e", #"end_game");
    foreach (player in level.players) {
        player.var_78c18942 = 0;
    }
    while (true) {
        wait 1;
        if (!is_true(level.var_b8cbd9e6)) {
            foreach (player in level.players) {
                if (!isdefined(player.var_78c18942)) {
                    player.var_78c18942 = 0;
                }
                player.var_78c18942++;
            }
        }
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xdf2db478, Offset: 0x7dd0
// Size: 0x3a4
function function_ea5b4947(b_end_game = 0) {
    if (!sessionmodeisonlinegame() || zm_utility::is_tutorial()) {
        return;
    }
    players = getplayers();
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        if (!isbot(player) && isdefined(player.var_78c18942) && player.var_78c18942 > 0) {
            var_83b23c0c = max(player function_c52bcf79(), float(getdvarint(#"hash_1624faaee3c04f09", 1)));
            var_78c18942 = player.var_78c18942 * var_83b23c0c;
            println("<dev string:x114>" + player.name + "<dev string:x127>" + player.var_78c18942 + "<dev string:x143>" + var_78c18942);
        }
        if (isdefined(player.bgb_pack) && isarray(player.bgb_pack)) {
            foreach (bgb in player.bgb_pack) {
                if (!isdefined(player.bgb_stats) || !isdefined(player.bgb_stats[bgb]) || !player.bgb_stats[bgb].bgb_used_this_game) {
                    continue;
                }
                player reportlootconsume(bgb, player.bgb_stats[bgb].bgb_used_this_game);
                player.bgb_stats[bgb].var_c2a984f0 = player.bgb_stats[bgb].var_c2a984f0 - player.bgb_stats[bgb].bgb_used_this_game;
                player.bgb_stats[bgb].bgb_used_this_game = 0;
            }
        }
        player util::function_22bf0a4a();
    }
    if (!b_end_game) {
        level thread function_c5f9ea85();
    }
    contracts::function_4a56b14d();
    uploadstats();
    function_f4f6d8a1();
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xa5a9fc86, Offset: 0x8180
// Size: 0x264
function function_94335f4a(var_1aa5a6d6) {
    level.var_1aa5a6d6 = var_1aa5a6d6;
    level.var_ad5d54b = [];
    for (n_row = 0; true; n_row++) {
        n_event = tablelookupcolumnforrow(#"gamedata/stats/zm/zm_event_callings.csv", n_row, 0);
        if (!isdefined(n_event) || n_event > var_1aa5a6d6) {
            return;
        }
        if (n_event == var_1aa5a6d6) {
            if (!isdefined(level.var_6ad5a223)) {
                level.var_6ad5a223 = tablelookupcolumnforrow(#"gamedata/stats/zm/zm_event_callings.csv", n_row, 1);
            }
            n_tier = tablelookupcolumnforrow(#"gamedata/stats/zm/zm_event_callings.csv", n_row, 2);
            var_e226ec4f = tablelookupcolumnforrow(#"gamedata/stats/zm/zm_event_callings.csv", n_row, 3);
            var_ad971622 = tablelookupcolumnforrow(#"gamedata/stats/zm/zm_event_callings.csv", n_row, 4);
            n_xp = tablelookupcolumnforrow(#"gamedata/stats/zm/zm_event_callings.csv", n_row, 6);
            var_1f2bdb95 = tablelookupcolumnforrow(#"gamedata/stats/zm/zm_event_callings.csv", n_row, 7);
            /#
                var_6530064b = getdvarint(#"hash_74a04bcc32a59d68", 0);
                if (var_6530064b) {
                    var_e226ec4f = var_6530064b;
                }
            #/
            level.var_ad5d54b[n_tier] = {#var_e226ec4f:var_e226ec4f, #var_ad971622:var_ad971622, #n_xp:n_xp, #var_1f2bdb95:var_1f2bdb95};
        }
    }
}

// Namespace zm_stats/zm_stats
// Params 3, eflags: 0x1 linked
// Checksum 0xf4135c65, Offset: 0x83f0
// Size: 0x468
function function_c0c6ab19(var_ad971622, n_value = 1, var_b68b08b1 = 0) {
    assert(ishash(var_ad971622), "<dev string:x15b>");
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats) || var_b68b08b1 && zm_utility::is_standard()) {
        return;
    }
    /#
        n_value *= getdvarint(#"hash_56e2a9e5690e0373", 1);
    #/
    if (getdvarint(#"hash_27ff853067d7c38c", 0) && getdvarint(#"zm_active_event_calling", 0) && isdefined(level.var_ad5d54b)) {
        s_event_calling_task = level.var_ad5d54b[self function_3e561f63()];
        if (isdefined(s_event_calling_task) && s_event_calling_task.var_ad971622 == var_ad971622) {
            self function_7f377150(s_event_calling_task, n_value);
        }
    }
    if (getdvarint(#"hash_27ff853067d7c38c", 0) && getdvarint(#"zm_active_daily_calling", 0)) {
        /#
            if (getdvar(#"hash_acdd08b365cb62f", 0)) {
                var_a4aebab9 = getdvarint(#"zm_active_daily_calling", 0);
                if (var_a4aebab9) {
                    function_e8c496dd(var_a4aebab9);
                }
                var_87b499fb = self stats::get_stat(#"hash_18e3320ccf4091e5", #"hash_487f0fce798b3a4b");
                var_8962d9b1 = isdefined(level.var_d479261a) ? level.var_d479261a : 0;
                self stats::set_stat(#"hash_18e3320ccf4091e5", #"hash_487f0fce798b3a4b", var_8962d9b1);
                if (var_87b499fb !== var_8962d9b1) {
                    self stats::set_stat(#"hash_18e3320ccf4091e5", #"progress", 0);
                }
            }
        #/
        if (isdefined(level.s_daily_calling_task) && level.s_daily_calling_task.var_ad971622 == var_ad971622) {
            self function_55109709(level.s_daily_calling_task, n_value);
        }
    }
    if (getdvarint(#"hash_11da02ca40639de5", 0)) {
        if (isdefined(self.var_96d6f6d1)) {
            foreach (var_4c74afc1 in self.var_96d6f6d1) {
                if (var_4c74afc1.var_ad971622 == var_ad971622) {
                    self zm_callings::function_4368582a(var_4c74afc1, n_value);
                }
            }
        }
    }
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x1 linked
// Checksum 0xd350085d, Offset: 0x8860
// Size: 0x38
function function_3e561f63() {
    return self stats::get_stat(#"hash_3b52e51401f0229c", level.var_6ad5a223, "tierCompleted") + 1;
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xa7aaf148, Offset: 0x88a0
// Size: 0x314
function function_7f377150(s_event_calling_task, n_value = 1) {
    var_e4edaaf0 = self stats::get_stat(#"hash_3b52e51401f0229c", level.var_6ad5a223, #"progress");
    if (var_e4edaaf0 < s_event_calling_task.var_e226ec4f) {
        if (var_e4edaaf0 + n_value >= s_event_calling_task.var_e226ec4f) {
            self luinotifyevent(#"zombie_callings_notification", 4, 0, level.var_1aa5a6d6, self function_3e561f63(), self getentitynumber());
            self stats::set_stat(#"hash_3b52e51401f0229c", level.var_6ad5a223, #"progress", 0);
            self stats::inc_stat(#"hash_3b52e51401f0229c", level.var_6ad5a223, #"tiercompleted", 1);
            self addrankxpvalue("event_calling_task", s_event_calling_task.n_xp);
            self stats::set_stat(#"hash_3b52e51401f0229c", level.var_6ad5a223, s_event_calling_task.var_1f2bdb95, 1);
            uploadstats(self);
            println(function_9e72a96(level.var_6ad5a223) + "<dev string:x181>" + self stats::get_stat(#"hash_3b52e51401f0229c", level.var_6ad5a223, "<dev string:x193>") + "<dev string:x1a4>" + function_9e72a96(s_event_calling_task.var_ad971622));
            return;
        }
        /#
            progress = var_e4edaaf0 + n_value;
            target = s_event_calling_task.var_e226ec4f;
            iprintln(self.name + "<dev string:x1b4>" + function_9e72a96(s_event_calling_task.var_ad971622) + "<dev string:x1ce>" + progress + "<dev string:x1e1>" + target);
        #/
        self stats::inc_stat(#"hash_3b52e51401f0229c", level.var_6ad5a223, #"progress", n_value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0x629a9e9d, Offset: 0x8bc0
// Size: 0x188
function function_e8c496dd(var_d479261a) {
    level.var_d479261a = var_d479261a;
    var_314051a1 = getscriptbundle(#"t8_callings_settings");
    if (isdefined(var_314051a1.dailyschedule) && isdefined(var_314051a1.dailyschedule[var_d479261a])) {
        task = var_314051a1.dailyschedule[var_d479261a];
        taskinfo = getscriptbundle(task.task);
        if (isdefined(taskinfo.callingtask)) {
            var_341c004b = undefined;
            for (i = 0; i < var_314051a1.tasklist.size; i++) {
                if (var_314051a1.tasklist[i].task == task.task) {
                    var_341c004b = i;
                    break;
                }
            }
            if (isdefined(var_341c004b)) {
                level.s_daily_calling_task = {#var_e226ec4f:taskinfo.dailytarget, #var_ad971622:taskinfo.callingtask, #n_xp:task.xp, #var_de86e878:var_341c004b};
            }
        }
    }
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x30a979ac, Offset: 0x8d50
// Size: 0x304
function function_55109709(s_daily_calling_task, n_value = 1) {
    var_e4edaaf0 = self stats::get_stat(#"hash_18e3320ccf4091e5", #"progress");
    if (isdefined(var_e4edaaf0) && isdefined(s_daily_calling_task) && isdefined(s_daily_calling_task.var_e226ec4f) && var_e4edaaf0 < s_daily_calling_task.var_e226ec4f) {
        if (var_e4edaaf0 + n_value >= s_daily_calling_task.var_e226ec4f) {
            self stats::set_stat(#"hash_18e3320ccf4091e5", #"progress", s_daily_calling_task.var_e226ec4f);
            self luinotifyevent(#"zombie_callings_notification", 3, 1, s_daily_calling_task.var_de86e878, self getentitynumber());
            self addrankxpvalue("daily_calling_task", s_daily_calling_task.n_xp);
            var_ae857992 = getdvarint(#"hash_60d812bef0f782fb", 2);
            uploadstats(self);
            self function_4835d26a();
            println("<dev string:x1e6>" + function_9e72a96(s_daily_calling_task.var_ad971622));
            /#
                iprintln(self.name + "<dev string:x203>" + function_9e72a96(s_daily_calling_task.var_ad971622) + "<dev string:x215>" + s_daily_calling_task.n_xp + "<dev string:x22e>");
            #/
            return;
        }
        /#
            progress = var_e4edaaf0 + n_value;
            target = s_daily_calling_task.var_e226ec4f;
            iprintln(self.name + "<dev string:x203>" + function_9e72a96(s_daily_calling_task.var_ad971622) + "<dev string:x1ce>" + progress + "<dev string:x1e1>" + target);
        #/
        self stats::inc_stat(#"hash_18e3320ccf4091e5", #"progress", n_value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xef2cd7fb, Offset: 0x9060
// Size: 0x2a
function function_12b698fa(statname) {
    return self stats::function_6d50f14b(#"hash_1b24e5b336f5ae8d", statname);
}

