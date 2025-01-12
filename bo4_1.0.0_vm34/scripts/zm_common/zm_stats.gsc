#using scripts\core_common\match_record;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_weapons;

#namespace zm_stats;

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x2
// Checksum 0xc08b6885, Offset: 0xe38
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_stats", &__init__, undefined, undefined);
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x0
// Checksum 0x55d9fbed, Offset: 0xe80
// Size: 0x4e
function __init__() {
    level.player_stats_init = &player_stats_init;
    level.add_client_stat = &add_client_stat;
    level.increment_client_stat = &increment_client_stat;
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x0
// Checksum 0xe50732ba, Offset: 0xed8
// Size: 0x1534
function player_stats_init() {
    self globallogic_score::initpersstat("kills", 0);
    self globallogic_score::initpersstat("wonder_weapon_kills", 0);
    self globallogic_score::initpersstat("suicides", 0);
    self globallogic_score::initpersstat("downs", 0);
    self.downs = self globallogic_score::getpersstat("downs");
    self globallogic_score::initpersstat("revives", 0);
    self.revives = self globallogic_score::getpersstat("revives");
    self globallogic_score::initpersstat("perks_drank", 0);
    self globallogic_score::initpersstat("bgbs_chewed", 0);
    self globallogic_score::initpersstat("headshots", 0);
    self globallogic_score::initpersstat("special_weapon_used", 0);
    self globallogic_score::initpersstat("special_weapon_uses", 0);
    self globallogic_score::initpersstat("bgb_tokens_gained_this_game", 0);
    self globallogic_score::initpersstat("melee_kills", 0);
    self globallogic_score::initpersstat("grenade_kills", 0);
    self globallogic_score::initpersstat("doors_purchased", 0);
    self globallogic_score::initpersstat("distance_traveled", 0);
    self.distance_traveled = self globallogic_score::getpersstat("distance_traveled");
    self globallogic_score::initpersstat("total_shots", 0);
    self.total_shots = self globallogic_score::getpersstat("total_shots");
    self globallogic_score::initpersstat("hits", 0);
    self.hits = self globallogic_score::getpersstat("hits");
    self globallogic_score::initpersstat("hits_taken", 0);
    self globallogic_score::initpersstat("misses", 0);
    self.misses = self globallogic_score::getpersstat("misses");
    self globallogic_score::initpersstat("deaths", 0);
    self.deaths = self globallogic_score::getpersstat("deaths");
    self globallogic_score::initpersstat("boards", 0);
    self globallogic_score::initpersstat("failed_revives", 0);
    self globallogic_score::initpersstat("sacrifices", 0);
    self globallogic_score::initpersstat("failed_sacrifices", 0);
    self globallogic_score::initpersstat("drops", 0);
    self globallogic_score::initpersstat("nuke_pickedup", 0);
    self globallogic_score::initpersstat("insta_kill_pickedup", 0);
    self globallogic_score::initpersstat("full_ammo_pickedup", 0);
    self globallogic_score::initpersstat("double_points_pickedup", 0);
    self globallogic_score::initpersstat("meat_stink_pickedup", 0);
    self globallogic_score::initpersstat("carpenter_pickedup", 0);
    self globallogic_score::initpersstat("fire_sale_pickedup", 0);
    self globallogic_score::initpersstat("minigun_pickedup", 0);
    self globallogic_score::initpersstat("island_seed_pickedup", 0);
    self globallogic_score::initpersstat("hero_weapon_power_pickedup", 0);
    self globallogic_score::initpersstat("pack_a_punch_pickedup", 0);
    self globallogic_score::initpersstat("extra_lives_pickedup", 0);
    self globallogic_score::initpersstat("zmarcade_key_pickedup", 0);
    self globallogic_score::initpersstat("shield_charge_pickedup", 0);
    self globallogic_score::initpersstat("dung_pickedup", 0);
    self globallogic_score::initpersstat("bonus_points_team_pickedup", 0);
    self globallogic_score::initpersstat("ww_grenade_pickedup", 0);
    self globallogic_score::initpersstat("use_magicbox", 0);
    self globallogic_score::initpersstat("grabbed_from_magicbox", 0);
    self globallogic_score::initpersstat("use_perk_random", 0);
    self globallogic_score::initpersstat("grabbed_from_perk_random", 0);
    self globallogic_score::initpersstat("use_pap", 0);
    self globallogic_score::initpersstat("pap_weapon_grabbed", 0);
    self globallogic_score::initpersstat("pap_weapon_not_grabbed", 0);
    self globallogic_score::initpersstat("specialty_armorvest_drank", 0);
    self globallogic_score::initpersstat("specialty_quickrevive_drank", 0);
    self globallogic_score::initpersstat("specialty_fastreload_drank", 0);
    self globallogic_score::initpersstat("specialty_additionalprimaryweapon_drank", 0);
    self globallogic_score::initpersstat("specialty_staminup_drank", 0);
    self globallogic_score::initpersstat("specialty_doubletap2_drank", 0);
    self globallogic_score::initpersstat("specialty_widowswine_drank", 0);
    self globallogic_score::initpersstat("specialty_deadshot_drank", 0);
    self globallogic_score::initpersstat("specialty_electriccherry_drank", 0);
    self globallogic_score::initpersstat("specialty_awareness_drank", 0);
    self globallogic_score::initpersstat("specialty_berserker_drank", 0);
    self globallogic_score::initpersstat("specialty_camper_drank", 0);
    self globallogic_score::initpersstat("specialty_cooldown_drank", 0);
    self globallogic_score::initpersstat("specialty_extraammo_drank", 0);
    self globallogic_score::initpersstat("specialty_mystery_drank", 0);
    self globallogic_score::initpersstat("specialty_phdflopper_drank", 0);
    self globallogic_score::initpersstat("specialty_shield_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_armorvest_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_quickrevive_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_fastreload_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_doubletap2_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_staminup_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_deadshot_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_additionalprimaryweapon_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_electriccherry_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_widowswine_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_cooldown_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_phdflopper_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_camper_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_extraammo_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_awareness_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_berserker_drank", 0);
    self globallogic_score::initpersstat("specialty_mod_shield_drank", 0);
    self globallogic_score::initpersstat("claymores_planted", 0);
    self globallogic_score::initpersstat("claymores_pickedup", 0);
    self globallogic_score::initpersstat("bouncingbetty_planted", 0);
    self globallogic_score::initpersstat("bouncingbetty_pickedup", 0);
    self globallogic_score::initpersstat("bouncingbetty_devil_planted", 0);
    self globallogic_score::initpersstat("bouncingbetty_devil_pickedup", 0);
    self globallogic_score::initpersstat("bouncingbetty_holly_planted", 0);
    self globallogic_score::initpersstat("bouncingbetty_holly_pickedup", 0);
    self globallogic_score::initpersstat("ballistic_knives_pickedup", 0);
    self globallogic_score::initpersstat("wallbuy_weapons_purchased", 0);
    self globallogic_score::initpersstat("ammo_purchased", 0);
    self globallogic_score::initpersstat("upgraded_ammo_purchased", 0);
    self globallogic_score::initpersstat("shields_purchased", 0);
    self globallogic_score::initpersstat("power_turnedon", 0);
    self globallogic_score::initpersstat("power_turnedoff", 0);
    self globallogic_score::initpersstat("planted_buildables_pickedup", 0);
    self globallogic_score::initpersstat("buildables_built", 0);
    self globallogic_score::initpersstat("time_played_total", 0);
    self globallogic_score::initpersstat("weighted_rounds_played", 0);
    self globallogic_score::initpersstat("zspiders_killed", 0);
    self globallogic_score::initpersstat("zthrashers_killed", 0);
    self globallogic_score::initpersstat("zraps_killed", 0);
    self globallogic_score::initpersstat("zwasp_killed", 0);
    self globallogic_score::initpersstat("zsentinel_killed", 0);
    self globallogic_score::initpersstat("zraz_killed", 0);
    self globallogic_score::initpersstat("zdog_rounds_finished", 0);
    self globallogic_score::initpersstat("zdog_rounds_lost", 0);
    self globallogic_score::initpersstat("killed_by_zdog", 0);
    self globallogic_score::initpersstat("killed_by_blightfather", 0);
    self globallogic_score::initpersstat("killed_by_brutus", 0);
    self globallogic_score::initpersstat("killed_by_gladiator", 0);
    self globallogic_score::initpersstat("killed_by_tiger", 0);
    self globallogic_score::initpersstat("killed_by_catalyst", 0);
    self globallogic_score::initpersstat("killed_by_catalyst_electric", 0);
    self globallogic_score::initpersstat("killed_by_catalyst_water", 0);
    self globallogic_score::initpersstat("killed_by_catalyst_plasma", 0);
    self globallogic_score::initpersstat("killed_by_catalyst_corrosive", 0);
    self globallogic_score::initpersstat("killed_by_hellhound", 0);
    self globallogic_score::initpersstat("killed_by_nova_crawler", 0);
    self globallogic_score::initpersstat("blightfathers_killed", 0);
    self globallogic_score::initpersstat("brutuses_killed", 0);
    self globallogic_score::initpersstat("gladiators_killed", 0);
    self globallogic_score::initpersstat("tigers_killed", 0);
    self globallogic_score::initpersstat("catalysts_killed", 0);
    self globallogic_score::initpersstat("catalyst_electrics_killed", 0);
    self globallogic_score::initpersstat("catalyst_waters_killed", 0);
    self globallogic_score::initpersstat("catalyst_plasmas_killed", 0);
    self globallogic_score::initpersstat("catalyst_corrosives_killed", 0);
    self globallogic_score::initpersstat("hellhounds_killed", 0);
    self globallogic_score::initpersstat("nova_crawlers_killed", 0);
    self globallogic_score::initpersstat("zdogs_killed", 0);
    self globallogic_score::initpersstat("cheat_too_many_weapons", 0);
    self globallogic_score::initpersstat("cheat_out_of_playable", 0);
    self globallogic_score::initpersstat("cheat_too_friendly", 0);
    self globallogic_score::initpersstat("cheat_total", 0);
    self globallogic_score::initpersstat("castle_tram_token_pickedup", 0);
    self globallogic_score::initpersstat("prison_tomahawk_acquired", 0);
    self globallogic_score::initpersstat("prison_brutus_killed", 0);
    self globallogic_score::initpersstat("prison_ee_spoon_acquired", 0);
    self globallogic_score::initpersstat("prison_fan_trap_used", 0);
    self globallogic_score::initpersstat("prison_acid_trap_used", 0);
    self globallogic_score::initpersstat("prison_spinning_trap_used", 0);
    self globallogic_score::initpersstat("towers_acid_trap_built_ra", 0);
    self globallogic_score::initpersstat("towers_acid_trap_built_danu", 0);
    self globallogic_score::initpersstat("towers_acid_trap_built_odin", 0);
    self globallogic_score::initpersstat("towers_acid_trap_built_zeus", 0);
    self globallogic_score::initpersstat("total_points", 0);
    self globallogic_score::initpersstat("rounds", 0);
    if (level.resetplayerscoreeveryround) {
        self.pers[#"score"] = 0;
    }
    self.pers[#"score"] = level.player_starting_points;
    self.score = self.pers[#"score"];
    self incrementplayerstat("score", self.score);
    self add_map_stat("score", self.score);
    self.bgb_tokens_gained_this_game = 0;
    self globallogic_score::initpersstat("zteam", 0);
    if (isdefined(level.var_7a4e6515)) {
        [[ level.var_7a4e6515 ]]();
    }
    if (!isdefined(self.stats_this_frame)) {
        self.stats_this_frame = [];
    }
    self globallogic_score::initpersstat("ZM_DAILY_CHALLENGE_INGAME_TIME", 1, 1);
    self add_global_stat("ZM_DAILY_CHALLENGE_GAMES_PLAYED", 1);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0xeaaed364, Offset: 0x2418
// Size: 0x886
function update_players_stats_at_match_end(players) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    game_mode = util::get_game_type();
    game_mode_group = level.scr_zm_ui_gametype_group;
    map_location_name = level.scr_zm_map_start_location;
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
        player stats::function_b48aa4e(#"distance_traveled", distance);
        player incrementplayerstat("time_played_total", player.pers[#"time_played_total"]);
        player add_map_stat("time_played_total", player.pers[#"time_played_total"]);
        recordplayermatchend(player);
        recordplayerstats(player, "present_at_end", 1);
        player zm_weapons::updateweapontimingszm(newtime);
        if (isdefined(level._game_module_stat_update_func)) {
            player [[ level._game_module_stat_update_func ]]();
        }
        old_high_score = player get_global_stat("score");
        if (player.score_total > old_high_score) {
            player set_global_stat("score", player.score_total);
        }
        player function_c31d0a24("TOTAL_POINTS", player.score_total);
        player function_d0a559ef("HIGHEST_SCORE", player.score_total);
        player function_d0a559ef("HIGHEST_TEAM_SCORE", level.score_total);
        set_match_stat("TEAM_SCORE", level.score_total);
        player set_global_stat("total_points", player.score_total);
        player set_global_stat("rounds", level.round_number);
        player set_global_stat("bgb_tokens_gained_this_game", player.bgb_tokens_gained_this_game);
        total_rounds_survived = level.round_number - 1;
        if (zm_trial::is_trial_mode() && isdefined(level.var_fa7b2e86) && level.var_fa7b2e86) {
            total_rounds_survived = level.round_number;
        }
        player function_bda9bc47("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
        player function_bda9bc47("HIGHEST_ROUND_REACHED", level.round_number);
        if (level.onlinegame) {
            player highwater_global_stat("HIGHEST_ROUND_REACHED", level.round_number);
            player highwater_map_stat("HIGHEST_ROUND_REACHED", level.round_number);
            player function_7e1bdc2c("HIGHEST_ROUND_REACHED", level.round_number);
            player function_d0a559ef("HIGHEST_ROUND_REACHED", level.round_number);
            player function_ad16be8b("HIGHEST_ROUND_REACHED", level.round_number);
            player add_global_stat("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
            player add_map_stat("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
            player function_c31d0a24("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
            player function_99e45227("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
            player function_15100103("TOTAL_ROUNDS_SURVIVED", total_rounds_survived);
            player add_global_stat("TOTAL_GAMES_PLAYED", 1);
            player add_map_stat("TOTAL_GAMES_PLAYED", 1);
            player function_c31d0a24("TOTAL_GAMES_PLAYED", 1);
            player function_99e45227("TOTAL_GAMES_PLAYED", 1);
            player function_15100103("TOTAL_GAMES_PLAYED", 1);
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
// Params 1, eflags: 0x0
// Checksum 0xc3434d48, Offset: 0x2ca8
// Size: 0x1bc
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
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2e70
// Size: 0x4
function survival_classic_custom_stat_update() {
    
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2e80
// Size: 0x4
function grief_custom_stat_update() {
    
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x6101d7a9, Offset: 0x2e90
// Size: 0x3a
function get_global_stat(stat_name) {
    return self stats::get_stat(#"playerstatslist", stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x97bc9403, Offset: 0x2ed8
// Size: 0x6c
function set_global_stat(stat_name, value) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::set_stat(#"playerstatslist", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xd0fd1d37, Offset: 0x2f50
// Size: 0x6c
function add_global_stat(stat_name, value) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::inc_stat(#"playerstatslist", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0xfc761d5c, Offset: 0x2fc8
// Size: 0x64
function increment_global_stat(stat_name) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::inc_stat(#"playerstatslist", stat_name, #"statvalue", 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x9edcc201, Offset: 0x3038
// Size: 0x44
function highwater_global_stat(stat_name, value) {
    if (value > get_global_stat(stat_name)) {
        set_global_stat(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x877b0ab3, Offset: 0x3088
// Size: 0x3a
function get_client_stat(stat_name) {
    return self stats::get_stat(#"playerstatslist", stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 3, eflags: 0x0
// Checksum 0x1d1e0da8, Offset: 0x30d0
// Size: 0x82
function add_client_stat(stat_name, stat_value, include_gametype) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    if (!isdefined(include_gametype)) {
        include_gametype = 1;
    }
    self globallogic_score::incpersstat(stat_name, stat_value, 0, include_gametype);
    self.stats_this_frame[stat_name] = 1;
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0xadfcdce5, Offset: 0x3160
// Size: 0x4c
function increment_player_stat(stat_name) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self incrementplayerstat(stat_name, 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x8cad6beb, Offset: 0x31b8
// Size: 0x54
function increment_root_stat(stat_name, stat_value) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::inc_stat(stat_name, stat_value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xf2c5f6b3, Offset: 0x3218
// Size: 0x54
function increment_client_stat(stat_name, include_gametype) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    add_client_stat(stat_name, 1, include_gametype);
}

// Namespace zm_stats/zm_stats
// Params 3, eflags: 0x0
// Checksum 0x12c80ce2, Offset: 0x3278
// Size: 0x9a
function set_client_stat(stat_name, stat_value, include_gametype) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    current_stat_count = self globallogic_score::getpersstat(stat_name);
    self globallogic_score::incpersstat(stat_name, stat_value - current_stat_count, 0, include_gametype);
    self.stats_this_frame[stat_name] = 1;
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xd73b9c3, Offset: 0x3320
// Size: 0x92
function zero_client_stat(stat_name, include_gametype) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    current_stat_count = self globallogic_score::getpersstat(stat_name);
    self globallogic_score::incpersstat(stat_name, current_stat_count * -1, 0, include_gametype);
    self.stats_this_frame[stat_name] = 1;
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0xf2b89018, Offset: 0x33c0
// Size: 0x52
function get_map_stat(stat_name) {
    return self stats::get_stat(#"playerstatsbymap", level.script, #"stats", stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xf04bc26b, Offset: 0x3420
// Size: 0x94
function set_map_stat(stat_name, value) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::set_stat(#"playerstatsbymap", level.script, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x93d6bb52, Offset: 0x34c0
// Size: 0x94
function add_map_stat(stat_name, value) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::inc_stat(#"playerstatsbymap", level.script, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0xbc23ddf7, Offset: 0x3560
// Size: 0x8c
function increment_map_stat(stat_name) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::inc_stat(#"playerstatsbymap", level.script, #"stats", stat_name, #"statvalue", 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xae419a0, Offset: 0x35f8
// Size: 0x44
function highwater_map_stat(stat_name, value) {
    if (value > get_map_stat(stat_name)) {
        set_map_stat(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0xfbb0f1a7, Offset: 0x3648
// Size: 0x6c
function increment_map_cheat_stat(stat_name) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::inc_stat(#"playerstatsbymap", level.script, #"cheats", stat_name, 1);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x6bb8d0f6, Offset: 0x36c0
// Size: 0x7a
function function_70732c35(stat_name) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return 0;
    }
    return stats::get_stat(#"playerstatsbygametype", level.gametype, stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x77e71354, Offset: 0x3748
// Size: 0x84
function function_e0d64181(stat_name, value) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    stats::set_stat(#"playerstatsbygametype", level.gametype, stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x10b91026, Offset: 0x37d8
// Size: 0x84
function function_c31d0a24(stat_name, value) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    stats::inc_stat(#"playerstatsbygametype", level.gametype, stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0xb2dedc99, Offset: 0x3868
// Size: 0x7c
function function_ac5a5f82(stat_name) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    stats::inc_stat(#"playerstatsbygametype", level.gametype, stat_name, #"statvalue", 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x23992ad4, Offset: 0x38f0
// Size: 0x44
function function_7e1bdc2c(stat_name, value) {
    if (value > function_70732c35(stat_name)) {
        function_e0d64181(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0xfb242f2b, Offset: 0x3940
// Size: 0xa2
function function_35dc4c8a(stat_name) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return 0;
    }
    return stats::get_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"stats", stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xfdca392a, Offset: 0x39f0
// Size: 0xac
function function_5cf52256(stat_name, value) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    stats::set_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xcdcc58d9, Offset: 0x3aa8
// Size: 0xac
function function_99e45227(stat_name, value) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    stats::inc_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0xeee1a433, Offset: 0x3b60
// Size: 0xa4
function function_ed968b89(stat_name) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    stats::inc_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"stats", stat_name, #"statvalue", 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xb38246e3, Offset: 0x3c10
// Size: 0x44
function function_d0a559ef(stat_name, value) {
    if (value > function_35dc4c8a(stat_name)) {
        function_5cf52256(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x6a2e4c3, Offset: 0x3c60
// Size: 0xba
function function_531fb194(stat_name) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return 0;
    }
    return stats::get_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"hash_413b4abc26595b34", level.gamedifficulty, #"stats", stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x87d4b09a, Offset: 0x3d28
// Size: 0xc4
function function_513afc50(stat_name, value) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    stats::set_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"hash_413b4abc26595b34", level.gamedifficulty, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x7108d7f7, Offset: 0x3df8
// Size: 0xc4
function function_15100103(stat_name, value) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    stats::inc_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"hash_413b4abc26595b34", level.gamedifficulty, #"stats", stat_name, #"statvalue", value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0xb7923464, Offset: 0x3ec8
// Size: 0xbc
function function_5d6859c1(stat_name) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    stats::inc_stat(#"playerstatsbymap", level.script, #"hash_74e26ca9652802fb", level.gametype, #"hash_413b4abc26595b34", level.gamedifficulty, #"stats", stat_name, #"statvalue", 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xb985ccd, Offset: 0x3f90
// Size: 0x44
function function_ad16be8b(stat_name, value) {
    if (value > function_531fb194(stat_name)) {
        function_513afc50(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x1a7861e7, Offset: 0x3fe0
// Size: 0x74
function increment_challenge_stat(stat_name, amount = 1) {
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::function_b48aa4e(stat_name, amount);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x5dd03fc1, Offset: 0x4060
// Size: 0x42
function get_match_stat(stat_name) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return 0;
    }
    return match_record::get_stat(stat_name);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xe5280da7, Offset: 0x40b0
// Size: 0x4c
function set_match_stat(stat_name, value) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    match_record::set_stat(stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xb92cf54a, Offset: 0x4108
// Size: 0x4c
function add_match_stat(stat_name, value) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    match_record::inc_stat(stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x52d38237, Offset: 0x4160
// Size: 0x4c
function increment_match_stat(stat_name) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    match_record::inc_stat(stat_name, 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x4fe53850, Offset: 0x41b8
// Size: 0x44
function function_8034552d(stat_name, value) {
    if (value > get_match_stat(stat_name)) {
        set_match_stat(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x78a4e748, Offset: 0x4208
// Size: 0x42
function function_aae8d25c(stat_name) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return 0;
    }
    return self match_record::get_player_stat(stat_name);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x985b4986, Offset: 0x4258
// Size: 0x54
function function_1c5a4678(stat_name, value) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self match_record::set_player_stat(stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xfc4d5381, Offset: 0x42b8
// Size: 0x54
function function_4463d769(stat_name, value) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self match_record::function_dfe977ee(stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0xbf21e083, Offset: 0x4318
// Size: 0x4c
function function_e597bf67(stat_name) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self match_record::function_dfe977ee(stat_name, 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x656c8bf0, Offset: 0x4370
// Size: 0x4c
function function_d6bca801(stat_name, value) {
    if (value > self function_aae8d25c(stat_name)) {
        self function_1c5a4678(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x3b1cb8d7, Offset: 0x43c8
// Size: 0x52
function function_febe937b(stat_name) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return 0;
    }
    return self stats::get_stat(#"afteractionreportstats", stat_name);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x45472ab0, Offset: 0x4428
// Size: 0x5c
function function_bda9bc47(stat_name, value) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::set_stat(#"afteractionreportstats", stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x79332463, Offset: 0x4490
// Size: 0x5c
function function_9c7350f8(stat_name, value) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::inc_stat(#"afteractionreportstats", stat_name, value);
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x74726fab, Offset: 0x44f8
// Size: 0x54
function function_bda05622(stat_name) {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::inc_stat(#"afteractionreportstats", stat_name, 1);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0xd168cab1, Offset: 0x4558
// Size: 0x4c
function function_366af690(stat_name, value) {
    if (value > self function_febe937b(stat_name)) {
        self function_bda9bc47(stat_name, value);
    }
}

// Namespace zm_stats/zm_stats
// Params 4, eflags: 0x0
// Checksum 0xbf7ca9f7, Offset: 0x45b0
// Size: 0x944
function handle_death(einflictor, eattacker, weapon, smeansofdeath) {
    entity = self;
    if (isplayer(entity) && isdefined(eattacker.archetype)) {
        switch (eattacker.archetype) {
        case #"blight_father":
            entity increment_client_stat("killed_by_blightfather");
            entity increment_player_stat("killed_by_blightfather");
            break;
        case #"brutus":
            entity increment_client_stat("killed_by_brutus");
            entity increment_player_stat("killed_by_brutus");
            break;
        case #"gladiator":
            entity increment_client_stat("killed_by_gladiator");
            entity increment_player_stat("killed_by_gladiator");
            break;
        case #"tiger":
            entity increment_client_stat("killed_by_tiger");
            entity increment_player_stat("killed_by_tiger");
            break;
        case #"catalyst":
            entity increment_client_stat("killed_by_catalyst");
            entity increment_player_stat("killed_by_catalyst");
            switch (eattacker.var_ea94c12a) {
            case #"catalyst_electric":
                entity increment_client_stat("killed_by_catalyst_electric");
                entity increment_player_stat("killed_by_catalyst_electric");
                break;
            case #"catalyst_water":
                entity increment_client_stat("killed_by_catalyst_water");
                entity increment_player_stat("killed_by_catalyst_water");
                break;
            case #"catalyst_plasma":
                entity increment_client_stat("killed_by_catalyst_plasma");
                entity increment_player_stat("killed_by_catalyst_plasma");
                break;
            case #"catalyst_corrosive":
                entity increment_client_stat("killed_by_catalyst_corrosive");
                entity increment_player_stat("killed_by_catalyst_corrosive");
                break;
            }
            break;
        case #"hellhound":
            entity increment_client_stat("killed_by_hellhound");
            entity increment_player_stat("killed_by_hellhound");
            break;
        case #"nova_crawler":
            entity increment_client_stat("killed_by_nova_crawler");
            entity increment_player_stat("killed_by_nova_crawler");
            break;
        case #"zombie_dog":
            entity increment_client_stat("killed_by_zdog");
            entity increment_player_stat("killed_by_zdog");
            break;
        }
        return;
    }
    if (isplayer(eattacker)) {
        if (isdefined(entity.archetype)) {
            switch (entity.archetype) {
            case #"blight_father":
                eattacker increment_client_stat("blightfathers_killed");
                eattacker increment_player_stat("blightfathers_killed");
                break;
            case #"brutus":
                eattacker increment_client_stat("brutuses_killed");
                eattacker increment_player_stat("brutuses_killed");
                break;
            case #"gladiator":
                eattacker increment_client_stat("gladiators_killed");
                eattacker increment_player_stat("gladiators_killed");
                break;
            case #"tiger":
                eattacker increment_client_stat("tigers_killed");
                eattacker increment_player_stat("tigers_killed");
                break;
            case #"catalyst":
                eattacker increment_client_stat("catalysts_killed");
                eattacker increment_player_stat("catalysts_killed");
                switch (entity.var_ea94c12a) {
                case #"catalyst_electric":
                    eattacker increment_client_stat("catalyst_electrics_killed");
                    eattacker increment_player_stat("catalyst_electrics_killed");
                    break;
                case #"catalyst_water":
                    eattacker increment_client_stat("catalyst_waters_killed");
                    eattacker increment_player_stat("catalyst_waters_killed");
                    break;
                case #"catalyst_plasma":
                    eattacker increment_client_stat("catalyst_plasmas_killed");
                    eattacker increment_player_stat("catalyst_plasmas_killed");
                    break;
                case #"catalyst_corrosive":
                    eattacker increment_client_stat("catalyst_corrosives_killed");
                    eattacker increment_player_stat("catalyst_corrosives_killed");
                    break;
                }
                break;
            case #"hellhound":
                eattacker increment_client_stat("hellhounds_killed");
                eattacker increment_player_stat("hellhounds_killed");
                break;
            case #"nova_crawler":
                eattacker increment_client_stat("nova_crawlers_killed");
                eattacker increment_player_stat("nova_crawlers_killed");
                break;
            case #"zombie_dog":
                eattacker increment_client_stat("zdogs_killed");
                eattacker increment_player_stat("zdogs_killed");
                break;
            }
        }
        if (zm_weapons::is_wonder_weapon(weapon)) {
            eattacker increment_client_stat("wonder_weapon_kills");
            eattacker increment_player_stat("wonder_weapon_kills");
        }
        if (isdefined(einflictor) && isdefined(einflictor.turret) && isdefined(einflictor.turret.item)) {
            eattacker stats::function_4f10b697(einflictor.turret.item, #"kills", 1);
        }
    }
}

// Namespace zm_stats/zm_stats
// Params 1, eflags: 0x0
// Checksum 0x8609d8bd, Offset: 0x4f00
// Size: 0x7c
function track_craftables_pickedup(craftable) {
    player = self;
    if (isdefined(craftable.isriotshield) && craftable.isriotshield) {
        player increment_client_stat("shields_purchased");
        player increment_player_stat("shields_purchased");
    }
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x0
// Checksum 0x485db516, Offset: 0x4f88
// Size: 0xb6
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
// Params 0, eflags: 0x0
// Checksum 0x5397eba, Offset: 0x5048
// Size: 0x12
function get_stat_round_number() {
    return zm_round_logic::get_round_number();
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x0
// Checksum 0xe5c11497, Offset: 0x5068
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
// Params 0, eflags: 0x0
// Checksum 0x8dd4bffd, Offset: 0x50e8
// Size: 0x25fc
function update_global_counters_on_match_end() {
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
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
    hellhounds_killed = 0;
    killed_by_hellhound = 0;
    nova_crawlers_killed = 0;
    killed_by_nova_crawler = 0;
    specialty_armorvest_drank = 0;
    specialty_quickrevive_drank = 0;
    specialty_fastreload_drank = 0;
    specialty_additionalprimaryweapon_drank = 0;
    specialty_staminup_drank = 0;
    specialty_doubletap2_drank = 0;
    specialty_widowswine_drank = 0;
    specialty_deadshot_drank = 0;
    specialty_awareness_drank = 0;
    specialty_berserker_drank = 0;
    specialty_camper_drank = 0;
    specialty_cooldown_drank = 0;
    specialty_extraammo_drank = 0;
    specialty_mystery_drank = 0;
    specialty_phdflopper_drank = 0;
    specialty_shield_drank = 0;
    specialty_mod_armorvest_drank = 0;
    specialty_mod_quickrevive_drank = 0;
    specialty_mod_fastreload_drank = 0;
    specialty_mod_doubletap2_drank = 0;
    specialty_mod_staminup_drank = 0;
    specialty_mod_deadshot_drank = 0;
    specialty_mod_additionalprimaryweapon_drank = 0;
    specialty_mod_electriccherry_drank = 0;
    specialty_mod_widowswine_drank = 0;
    specialty_mod_cooldown_drank = 0;
    specialty_mod_phdflopper_drank = 0;
    specialty_mod_camper_drank = 0;
    specialty_mod_extraammo_drank = 0;
    specialty_mod_awareness_drank = 0;
    specialty_mod_berserker_drank = 0;
    specialty_mod_shield_drank = 0;
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
        specialty_berserker_drank += player.pers[#"specialty_berserker_drank"];
        specialty_camper_drank += player.pers[#"specialty_camper_drank"];
        specialty_cooldown_drank += player.pers[#"specialty_cooldown_drank"];
        specialty_extraammo_drank += player.pers[#"specialty_extraammo_drank"];
        specialty_mystery_drank += player.pers[#"specialty_mystery_drank"];
        specialty_phdflopper_drank += player.pers[#"specialty_phdflopper_drank"];
        specialty_shield_drank += player.pers[#"specialty_shield_drank"];
        specialty_mod_armorvest_drank += player.pers[#"specialty_mod_armorvest_drank"];
        specialty_mod_quickrevive_drank += player.pers[#"specialty_mod_quickrevive_drank"];
        specialty_mod_fastreload_drank += player.pers[#"specialty_mod_fastreload_drank"];
        specialty_mod_doubletap2_drank += player.pers[#"specialty_mod_doubletap2_drank"];
        specialty_mod_staminup_drank += player.pers[#"specialty_mod_staminup_drank"];
        specialty_mod_deadshot_drank += player.pers[#"specialty_mod_deadshot_drank"];
        specialty_mod_additionalprimaryweapon_drank += player.pers[#"specialty_mod_additionalprimaryweapon_drank"];
        specialty_mod_electriccherry_drank += player.pers[#"specialty_mod_electriccherry_drank"];
        specialty_mod_widowswine_drank += player.pers[#"specialty_mod_widowswine_drank"];
        specialty_mod_cooldown_drank += player.pers[#"specialty_mod_cooldown_drank"];
        specialty_mod_phdflopper_drank += player.pers[#"specialty_mod_phdflopper_drank"];
        specialty_mod_camper_drank += player.pers[#"specialty_mod_camper_drank"];
        specialty_mod_extraammo_drank += player.pers[#"specialty_mod_extraammo_drank"];
        specialty_mod_awareness_drank += player.pers[#"specialty_mod_awareness_drank"];
        specialty_mod_berserker_drank += player.pers[#"specialty_mod_berserker_drank"];
        specialty_mod_shield_drank += player.pers[#"specialty_mod_shield_drank"];
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
        hellhounds_killed += player.pers[#"hellhounds_killed"];
        killed_by_hellhound += player.pers[#"killed_by_hellhound"];
        nova_crawlers_killed += player.pers[#"nova_crawlers_killed"];
        killed_by_nova_crawler += player.pers[#"killed_by_nova_crawler"];
    }
    game_mode = util::get_game_type();
    incrementcounter(#"hash_1a07dc8b20d2aba7" + game_mode, 1);
    incrementcounter(#"hash_7e8014c44a6f0cda", 1);
    if ("zclassic" == game_mode) {
        incrementcounter(#"hash_62afce8a7ab245ff" + level.script, 1);
    }
    incrementcounter(#"hash_547cf67917688a36", level.global_zombies_killed);
    incrementcounter(#"hash_2abf99ba4e77eb0b", kills);
    incrementcounter(#"hash_59ecbe56324f4b3d", level.zombie_trap_killed_count);
    incrementcounter(#"hash_409ea3753157517a", headshots);
    incrementcounter(#"hash_772c4d358fb7d9b2", suicides);
    incrementcounter(#"hash_5130e840d0bae263", wonder_weapon_kills);
    incrementcounter(#"hash_5237cd43d3700eff", melee_kills);
    incrementcounter(#"hash_14efb0201c8fe060", downs);
    incrementcounter(#"hash_69044be321b80668", deaths);
    incrementcounter(#"hash_7a3ae2006f514977", revives);
    incrementcounter(#"hash_73b50abf0f1e2555", perks_drank);
    incrementcounter(#"hash_11289841e6de6a0e", specialty_armorvest_drank);
    incrementcounter(#"hash_75d691e59f143c1d", specialty_quickrevive_drank);
    incrementcounter(#"hash_52f544a3cfe8d1ec", specialty_fastreload_drank);
    incrementcounter(#"hash_7b0bb4729c2dd756", specialty_additionalprimaryweapon_drank);
    incrementcounter(#"hash_489e4642bf993c6c", specialty_staminup_drank);
    incrementcounter(#"hash_127e66eb279221fb", specialty_doubletap2_drank);
    incrementcounter(#"hash_693de45b7f99abe5", specialty_widowswine_drank);
    incrementcounter(#"hash_26dfb764dfe8539d", specialty_deadshot_drank);
    incrementcounter(#"hash_2dac22d18f3cd976", specialty_awareness_drank);
    incrementcounter(#"hash_765370a86077fcd6", specialty_berserker_drank);
    incrementcounter(#"hash_331aa46b88fe4c8d", specialty_camper_drank);
    incrementcounter(#"hash_442efecc02da3f92", specialty_cooldown_drank);
    incrementcounter(#"hash_5e29ca4b463510d3", specialty_extraammo_drank);
    incrementcounter(#"hash_3c522f8497f5ca2a", specialty_mystery_drank);
    incrementcounter(#"hash_4757df064c15f87b", specialty_phdflopper_drank);
    incrementcounter(#"hash_44bdc3de66cabbe6", specialty_shield_drank);
    incrementcounter(#"hash_16c094366ca36e81", specialty_mod_armorvest_drank);
    incrementcounter(#"hash_1d8886afb659c8a2", specialty_mod_quickrevive_drank);
    incrementcounter(#"hash_2919e6f2ee61cfa1", specialty_mod_fastreload_drank);
    incrementcounter(#"hash_1859541247d24c6", specialty_mod_doubletap2_drank);
    incrementcounter(#"hash_7451da9688244fc1", specialty_mod_staminup_drank);
    incrementcounter(#"hash_6551d4b754fef044", specialty_mod_deadshot_drank);
    incrementcounter(#"hash_2fd9ed71ed636dd", specialty_mod_additionalprimaryweapon_drank);
    incrementcounter(#"hash_46668c17c0bc102c", specialty_mod_electriccherry_drank);
    incrementcounter(#"hash_53100bc3fd069694", specialty_mod_widowswine_drank);
    incrementcounter(#"hash_52c6da9f8d885ddb", specialty_mod_cooldown_drank);
    incrementcounter(#"hash_77fe39895ea9e666", specialty_mod_phdflopper_drank);
    incrementcounter(#"hash_eb8cebb74705c28", specialty_mod_camper_drank);
    incrementcounter(#"hash_6048aa113125834c", specialty_mod_extraammo_drank);
    incrementcounter(#"hash_258033e39ec71e1", specialty_mod_awareness_drank);
    incrementcounter(#"hash_3d5f29420c50cd8d", specialty_mod_berserker_drank);
    incrementcounter(#"hash_6612553cf60cb757", specialty_mod_shield_drank);
    incrementcounter(#"hash_3be4aa860b81cb08", int(distance_traveled));
    incrementcounter(#"hash_1234e6124669031e", doors_purchased);
    incrementcounter(#"hash_247207e91632f7e2", boards);
    incrementcounter(#"hash_3e55e656e54ed371", sacrifices);
    incrementcounter(#"hash_55e89fc6becb3a37", drops);
    incrementcounter(#"hash_6788c52217bbfd3", nuke_pickedup);
    incrementcounter(#"hash_3f6a40afae943450", insta_kill_pickedup);
    incrementcounter(#"hash_b04f9860f8d8dbc", full_ammo_pickedup);
    incrementcounter(#"hash_2729cc7555459e67", double_points_pickedup);
    incrementcounter(#"hash_1cb7b4b6c34dad97", double_points_pickedup);
    incrementcounter(#"hash_2933268a09096d58", carpenter_pickedup);
    incrementcounter(#"hash_7aca895339b25c16", fire_sale_pickedup);
    incrementcounter(#"hash_365dc258051fcfb1", minigun_pickedup);
    incrementcounter(#"hash_1f03ab84bd7e916d", island_seed_pickedup);
    incrementcounter(#"hash_6403c4cc86e2ea49", hero_weapon_power_pickedup);
    incrementcounter(#"hash_14c8b49d08c77e6a", pack_a_punch_pickedup);
    incrementcounter(#"hash_3be2d1ae0ac726f2", extra_lives_pickedup);
    incrementcounter(#"hash_127c387ee3fe25c3", zmarcade_key_pickedup);
    incrementcounter(#"hash_23fc261ef3bc22fe", shield_charge_pickedup);
    incrementcounter(#"hash_5450344226d184bc", dung_pickedup);
    incrementcounter(#"hash_2855cc6c6b72fd3f", zombie_blood_pickedup);
    incrementcounter(#"hash_41287ef229bed083", use_magicbox);
    incrementcounter(#"hash_653d09ef282db07e", grabbed_from_magicbox);
    incrementcounter(#"hash_1c8a16d6e2030eb3", use_perk_random);
    incrementcounter(#"hash_56ae8c3b5d2829bc", grabbed_from_perk_random);
    incrementcounter(#"hash_2aa0472ca2270d8", use_pap);
    incrementcounter(#"hash_6e6ed86e5187af0b", pap_weapon_grabbed);
    incrementcounter(#"hash_769646a233a3f42f", claymores_planted);
    incrementcounter(#"hash_4407d50417122f30", claymores_pickedup);
    incrementcounter(#"hash_76d92abb9ad637a3", ballistic_knives_pickedup);
    incrementcounter(#"hash_64e836fae02a3a09", wallbuy_weapons_purchased);
    incrementcounter(#"hash_34c17b99db362f46", power_turnedon);
    incrementcounter(#"hash_5b0f566f7d292ca8", power_turnedoff);
    incrementcounter(#"hash_7258e739e90aceb9", planted_buildables_pickedup);
    incrementcounter(#"hash_48b579e61d3bfe25", buildables_built);
    incrementcounter(#"hash_5f1c55e84346f57b", ammo_purchased);
    incrementcounter(#"hash_669027ddc26c699c", upgraded_ammo_purchased);
    incrementcounter(#"hash_2e44c1aa44d294ad", shields_purchased);
    incrementcounter(#"hash_46888f2c01a7a8a9", total_shots);
    incrementcounter(#"hash_419b701192872fd8", time_played);
    incrementcounter(#"hash_1437277e759fb6a0", cheat_too_friendly);
    incrementcounter(#"hash_243339141dd9ea5e", cheat_too_many_weapons);
    incrementcounter(#"hash_4243423078fedcb", cheat_out_of_playable_area);
    incrementcounter(#"hash_5c44e4a3c0fe999c", cheat_total);
    incrementcounter(#"hash_6ba3659e3f51625c", blightfathers_killed);
    incrementcounter(#"hash_6ebf1a6ef5fc37d3", killed_by_blightfather);
    incrementcounter(#"hash_27197a7d1884d88a", brutuses_killed);
    incrementcounter(#"hash_433b9afa3166584a", killed_by_brutus);
    incrementcounter(#"hash_6355596133d4f7cb", gladiators_killed);
    incrementcounter(#"hash_481e106ee212bf0", killed_by_gladiator);
    incrementcounter(#"hash_4d447c525be39601", tigers_killed);
    incrementcounter(#"hash_50cb6a73e138696a", killed_by_tiger);
    incrementcounter(#"hash_3efcecd3b218ced7", catalysts_killed);
    incrementcounter(#"hash_640549d1fbbc276c", killed_by_catalyst);
    incrementcounter(#"hash_72d58fa88979a3d1", catalyst_electrics_killed);
    incrementcounter(#"hash_41f2958087943572", killed_by_catalyst_electric);
    incrementcounter(#"hash_280482af0280b5cf", catalyst_waters_killed);
    incrementcounter(#"hash_378d19b5bd92db64", killed_by_catalyst_water);
    incrementcounter(#"hash_7da42070a91beeb4", catalyst_plasmas_killed);
    incrementcounter(#"hash_3106573a7bf4d003", killed_by_catalyst_plasma);
    incrementcounter(#"hash_3960bb66d49099c6", catalyst_corrosives_killed);
    incrementcounter(#"hash_70ecbbf84e849999", killed_by_catalyst_corrosive);
    incrementcounter(#"hash_60fa9d2c89b2cecd", hellhounds_killed);
    incrementcounter(#"hash_3e4c4d5b5b004d6e", killed_by_hellhound);
    incrementcounter(#"hash_57b50870b7034965", nova_crawlers_killed);
    incrementcounter(#"hash_2384520752bf29fe", killed_by_nova_crawler);
}

// Namespace zm_stats/zm_stats
// Params 2, eflags: 0x0
// Checksum 0x26f48408, Offset: 0x76f0
// Size: 0x3a
function get_specific_stat(stat_category, stat_name) {
    return self stats::get_stat(stat_category, stat_name, #"statvalue");
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x0
// Checksum 0xe97282d7, Offset: 0x7738
// Size: 0xbc
function initializematchstats() {
    if (!level.onlinegame || !gamemodeismode(0)) {
        return;
    }
    self.pers[#"lasthighestscore"] = self stats::get_stat(#"higheststats", #"highest_score");
    currgametype = level.gametype;
    self gamehistorystartmatch(getgametypeenumfromname(currgametype, 0));
}

// Namespace zm_stats/zm_stats
// Params 0, eflags: 0x0
// Checksum 0x75911cee, Offset: 0x7800
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
// Params 0, eflags: 0x0
// Checksum 0xfcd70eb3, Offset: 0x7880
// Size: 0x54
function uploadstatssoon() {
    self notify(#"upload_stats_soon");
    self endon(#"upload_stats_soon");
    self endon(#"disconnect");
    wait 1;
    uploadstats(self);
}

