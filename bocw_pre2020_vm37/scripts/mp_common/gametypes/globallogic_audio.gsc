#using script_1cc417743d7c262d;
#using script_396f7d71538c9677;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\map;
#using scripts\core_common\music_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\round;

#namespace globallogic_audio;

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x6
// Checksum 0xd72d4a45, Offset: 0x4f8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_410d0d4132d5f263", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x5 linked
// Checksum 0x3b44dfca, Offset: 0x540
// Size: 0x11c
function private function_70a657d8() {
    callback::on_start_gametype(&init);
    callback::on_joined_team(&on_joined_team);
    if (util::get_gametype_name() === "survival") {
        level.var_bc01f047 = "srtaacom";
        level.var_7ee6af9f = "srcommander";
    } else {
        level.var_bc01f047 = "mptaacom";
        level.var_7ee6af9f = "mpcommander";
    }
    level.playleaderdialogonplayer = &leader_dialog_on_player;
    level.var_57e2bc08 = &leader_dialog;
    level.playequipmentdestroyedonplayer = &play_equipment_destroyed_on_player;
    level.playequipmenthackedonplayer = &play_equipment_hacked_on_player;
    level.var_daaa6db3 = &function_4fb91bc7;
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xbebda629, Offset: 0x668
// Size: 0x40c
function init() {
    level.multipledialogkeys = [];
    level.multipledialogkeys[#"enemyaitank"] = "enemyAiTankMultiple";
    level.multipledialogkeys[#"enemysupplydrop"] = "enemySupplyDropMultiple";
    level.multipledialogkeys[#"enemycombatrobot"] = "enemyCombatRobotMultiple";
    level.multipledialogkeys[#"enemycounteruav"] = "enemyCounterUavMultiple";
    level.multipledialogkeys[#"enemydart"] = "enemyDartMultiple";
    level.multipledialogkeys[#"enemyemp"] = "enemyEmpMultiple";
    level.multipledialogkeys[#"enemymicrowaveturret"] = "enemyMicrowaveTurretMultiple";
    level.multipledialogkeys[#"enemyrcbomb"] = "enemyRcBombMultiple";
    level.multipledialogkeys[#"enemyplanemortar"] = "enemyPlaneMortarMultiple";
    level.multipledialogkeys[#"enemyhelicoptergunner"] = "enemyHelicopterGunnerMultiple";
    level.multipledialogkeys[#"enemyraps"] = "enemyRapsMultiple";
    level.multipledialogkeys[#"enemydronestrike"] = "enemyDroneStrikeMultiple";
    level.multipledialogkeys[#"enemyturret"] = "enemyTurretMultiple";
    level.multipledialogkeys[#"enemyhelicopter"] = "enemyHelicopterMultiple";
    level.multipledialogkeys[#"enemyuav"] = "enemyUavMultiple";
    level.multipledialogkeys[#"enemysatellite"] = "enemySatelliteMultiple";
    level.multipledialogkeys[#"friendlyaitank"] = "";
    level.multipledialogkeys[#"friendlysupplydrop"] = "";
    level.multipledialogkeys[#"friendlycombatrobot"] = "";
    level.multipledialogkeys[#"friendlycounteruav"] = "";
    level.multipledialogkeys[#"friendlydart"] = "";
    level.multipledialogkeys[#"friendlyemp"] = "";
    level.multipledialogkeys[#"friendlymicrowaveturret"] = "";
    level.multipledialogkeys[#"friendlyrcbomb"] = "";
    level.multipledialogkeys[#"friendlyplanemortar"] = "";
    level.multipledialogkeys[#"friendlyhelicoptergunner"] = "";
    level.multipledialogkeys[#"friendlyraps"] = "";
    level.multipledialogkeys[#"friendlydronestrike"] = "";
    level.multipledialogkeys[#"friendlyturret"] = "";
    level.multipledialogkeys[#"friendlyhelicopter"] = "";
    level.multipledialogkeys[#"friendlyuav"] = "";
    level.multipledialogkeys[#"friendlysatellite"] = "";
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xc2bedf88, Offset: 0xa80
// Size: 0x138
function set_blops_dialog() {
    if (isdefined(level.var_462ca9bb)) {
        self.pers[level.var_bc01f047] = level.var_462ca9bb;
    } else {
        self.pers[level.var_bc01f047] = level.var_bc01f047 === "mptaacom" ? "blops_taacom" : "sr_taacom";
    }
    if (isdefined(level.var_e2f95698)) {
        self.pers[level.var_7ee6af9f] = level.var_e2f95698;
        return;
    }
    if (level.var_7ee6af9f === "mpcommander") {
        var_c6f373a5 = map::get_script_bundle();
        if (isdefined(var_c6f373a5.var_12b3ac1e)) {
            self.pers[level.var_7ee6af9f] = var_c6f373a5.var_12b3ac1e;
        } else {
            self.pers[level.var_7ee6af9f] = "blops_commander";
        }
        return;
    }
    self.pers[level.var_7ee6af9f] = "sr_commander";
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x6482aaae, Offset: 0xbc0
// Size: 0xdc
function set_cdp_dialog() {
    if (isdefined(level.var_2d24ff8d)) {
        self.pers[level.var_bc01f047] = level.var_2d24ff8d;
    } else {
        self.pers[level.var_bc01f047] = "cdp_taacom";
    }
    if (isdefined(level.var_e2f95698)) {
        self.pers[level.var_7ee6af9f] = level.var_e2f95698;
        return;
    }
    var_c6f373a5 = map::get_script_bundle();
    if (isdefined(var_c6f373a5.var_52290afc)) {
        self.pers[level.var_7ee6af9f] = var_c6f373a5.var_52290afc;
        return;
    }
    self.pers[level.var_7ee6af9f] = "cdp_commander";
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x8e201a09, Offset: 0xca8
// Size: 0x24c
function on_joined_team(*params) {
    self endon(#"disconnect");
    teammask = getteammask(self.team);
    for (teamindex = 0; teammask > 1; teamindex++) {
        teammask >>= 1;
    }
    if (teamindex % 2) {
        self set_blops_dialog();
    } else {
        self set_cdp_dialog();
    }
    self flush_dialog();
    if (!is_true(level.inprematchperiod) && !is_true(self.pers[#"playedgamemode"]) && isdefined(level.leaderdialog)) {
        if (level.hardcoremode) {
            if (globallogic_utils::function_308e3379()) {
                self leader_dialog_on_player(level.leaderdialog.var_d04b3734, undefined, undefined, undefined, 1);
            } else {
                self leader_dialog_on_player(level.leaderdialog.starthcgamedialog, undefined, undefined, undefined, 1);
            }
        } else if (globallogic_utils::function_308e3379()) {
            self leader_dialog_on_player(level.leaderdialog.var_f6fda321, undefined, undefined, undefined, 1);
        } else {
            self leader_dialog_on_player(level.leaderdialog.startgamedialog, undefined, undefined, undefined, 1);
        }
        self.pers[#"playedgamemode"] = 1;
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xa8df6891, Offset: 0xf00
// Size: 0x174
function announcercontroller() {
    level endon(#"game_ended");
    level waittill(#"match_ending_soon");
    if (util::islastround() || util::isoneround()) {
        if (level.teambased) {
            if (!announce_team_is_winning()) {
                leader_dialog("min_draw");
            }
        }
        level waittill(#"match_ending_very_soon");
        foreach (team, _ in level.teams) {
            leader_dialog("roundTimeWarning", team);
        }
        return;
    }
    level waittill(#"match_ending_vox");
    leader_dialog("roundTimeWarning");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x9d659acb, Offset: 0x1080
// Size: 0x1f4
function function_1f89b047() {
    if (!isdefined(game.outcome.var_3c5fdf73)) {
        return;
    }
    var_f743e210 = 0;
    if (game.outcome.var_3c5fdf73.size > 1) {
        var_cdf943df = undefined;
        for (index = game.outcome.var_3c5fdf73.size - 2; index >= 0; index--) {
            if (!isdefined(var_cdf943df)) {
                var_cdf943df = game.outcome.var_3c5fdf73[index].team;
            }
            if (var_cdf943df != game.outcome.var_3c5fdf73[index].team) {
                break;
            }
            var_f743e210++;
        }
    }
    var_d70a4dd2 = game.outcome.var_3c5fdf73[game.outcome.var_3c5fdf73.size - 1].team;
    var_b66d2861 = 0;
    if (var_d70a4dd2 === var_cdf943df) {
        var_f743e210++;
    } else if (var_f743e210 > 1) {
        var_b66d2861 = 1;
    }
    if (is_true(var_b66d2861)) {
        leader_dialog("announceStreakBreaker", var_d70a4dd2);
        return;
    }
    if (var_f743e210 >= 3 && var_f743e210 <= 8) {
        dialogkey = "announceStreak_" + (isdefined(var_f743e210) ? "" + var_f743e210 : "");
        leader_dialog(dialogkey, var_d70a4dd2);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xa20ead94, Offset: 0x1280
// Size: 0x3c
function function_5e0a6842() {
    level thread set_music_on_team("roundend_finish");
    leader_dialog("roundSwitchSides");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x1a9714cf, Offset: 0x12c8
// Size: 0x1c
function function_dfd17bd3() {
    leader_dialog("roundHalftime");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xddabcd31, Offset: 0x12f0
// Size: 0xc8
function announce_team_is_winning() {
    foreach (team, _ in level.teams) {
        if (is_team_winning(team)) {
            leader_dialog("gameWinning", team);
            leader_dialog_for_other_teams("gameLosing", team);
            return true;
        }
    }
    return false;
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x1ee10cfd, Offset: 0x13c0
// Size: 0x1e4
function announce_round_winner(delay) {
    if (delay > 0) {
        wait delay;
    }
    winner = round::get_winner();
    if (!isdefined(winner) || isplayer(winner)) {
        return;
    }
    if (isdefined(level.teams[winner])) {
        if (level.gametype === "bounty" && round::function_3624d032() === 1) {
            leader_dialog("bountyRoundEncourageWon", winner);
            leader_dialog_for_other_teams("bountyRoundEncourageLost", winner);
        } else {
            leader_dialog("roundEncourageWon", winner);
            leader_dialog_for_other_teams("roundEncourageLost", winner);
        }
        return;
    }
    foreach (team, _ in level.teams) {
        if (isdefined(level.teampostfix[team])) {
            thread sound::play_on_players("mus_round_draw" + "_" + level.teampostfix[team]);
        }
    }
    leader_dialog("roundDraw");
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x69315a23, Offset: 0x15b0
// Size: 0xe4
function announce_game_winner(outcome) {
    wait battlechatter::mpdialog_value("announceWinnerDelay", 0);
    if (level.teambased) {
        if (outcome::get_flag(outcome, "tie") || !match::function_c10174e7()) {
            leader_dialog("gameDraw");
            return;
        }
        leader_dialog("gameWin", outcome::get_winner(outcome));
        leader_dialog_for_other_teams("gameLoss", outcome::get_winner(outcome));
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xc4c2ff9d, Offset: 0x16a0
// Size: 0xc
function function_57678746(*outcome) {
    
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x2ba98609, Offset: 0x16b8
// Size: 0x6a
function get_round_switch_dialog(switchtype) {
    switch (switchtype) {
    case 2:
        return "roundHalftime";
    case 4:
        return "roundOvertime";
    default:
        return "roundSwitchSides";
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x6d33f8b, Offset: 0x1730
// Size: 0x7c
function sndmusicfunctions() {
    level thread function_13bcae23();
    level thread function_913f483f();
    level thread function_c13cee9b();
    level thread sndmusichalfway();
    level thread sndmusictimelimitwatcher();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x8aec908b, Offset: 0x17b8
// Size: 0x94
function sndmusicsetrandomizer() {
    if (isdefined(level.var_30783ca9)) {
        level thread [[ level.var_30783ca9 ]]();
        return;
    }
    if (game.roundsplayed == 0) {
        game.musicset = 3;
        if (game.musicset <= 9) {
            game.musicset = "0" + game.musicset;
        }
        game.musicset = "_" + game.musicset;
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x5c4c6630, Offset: 0x1858
// Size: 0x90
function function_c13cee9b() {
    level endon(#"game_ended", #"match_ending_very_soon", #"hash_15b8b6edc4ed3032");
    waitresult = level waittill(#"match_ending_soon");
    if (waitresult.event === "score") {
        wait 10;
        level notify(#"hash_15b8b6edc4ed3032");
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x1d47e2ab, Offset: 0x18f0
// Size: 0x110
function function_13bcae23() {
    level endon(#"game_ended", #"hash_5473f958d5ea84dc");
    var_ffe73385 = 0;
    if (isdefined(level.gametype) && level.gametype == "sd") {
        var_ffe73385 = 1;
    }
    while (true) {
        s_waitresult = level waittill(#"hash_15b8b6edc4ed3032");
        if (!is_true(s_waitresult.var_7090bf53)) {
            level notify(#"hash_d50c83061fcd561");
        }
        if (var_ffe73385) {
            level thread set_music_on_team("timeout_loop_quiet");
            continue;
        }
        level thread set_music_on_team("timeout_loop");
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x2ac294c3, Offset: 0x1a08
// Size: 0x90
function function_913f483f() {
    level endon(#"game_ended", #"hash_d50c83061fcd561");
    while (true) {
        s_waitresult = level waittill(#"hash_28434e94a8844dc5");
        if (isdefined(s_waitresult.n_delay)) {
            wait s_waitresult.n_delay;
        }
        level thread set_music_on_team("none");
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x80f69b9a, Offset: 0x1aa0
// Size: 0x9c
function sndmusichalfway() {
    level endon(#"game_ended", #"match_ending_soon", #"match_ending_very_soon", #"hash_15b8b6edc4ed3032");
    if (level.gametype === "sd") {
        return;
    }
    level waittill(#"sndmusichalfway");
    level thread set_music_on_team("underscore");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x5d16baf8, Offset: 0x1b48
// Size: 0x10c
function sndmusictimelimitwatcher() {
    level endon(#"game_ended", #"match_ending_soon", #"match_ending_very_soon", #"sndmusichalfway");
    if (!isdefined(level.timelimit) || level.timelimit == 0) {
        return;
    }
    halfway = level.timelimit * 60 * 0.5;
    if (halfway <= 100) {
        return;
    }
    while (true) {
        timeleft = float(globallogic_utils::gettimeremaining()) / 1000;
        if (timeleft <= halfway) {
            level notify(#"sndmusichalfway");
            return;
        }
        wait 2;
    }
}

