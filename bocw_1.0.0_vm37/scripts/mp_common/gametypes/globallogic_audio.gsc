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
// Checksum 0x2df8e389, Offset: 0x530
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_410d0d4132d5f263", &preinit, undefined, undefined, undefined);
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x4
// Checksum 0x6a2c70a5, Offset: 0x578
// Size: 0x11c
function private preinit() {
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
// Params 0, eflags: 0x0
// Checksum 0x5a5d665b, Offset: 0x6a0
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
// Params 0, eflags: 0x0
// Checksum 0x22c83ef7, Offset: 0xab8
// Size: 0x188
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
        factionlist = map::function_596f8772();
        faction = getscriptbundle(isdefined(factionlist.faction[1].var_d2446fa0) ? factionlist.faction[1].var_d2446fa0 : #"");
        self.pers[level.var_7ee6af9f] = isdefined(faction.var_ccc3e5ba) ? faction.var_ccc3e5ba : "blops_commander";
        return;
    }
    self.pers[level.var_7ee6af9f] = "sr_commander";
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xe6260f5b, Offset: 0xc48
// Size: 0x12c
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
    factionlist = map::function_596f8772();
    faction = getscriptbundle(isdefined(factionlist.faction[2].var_d2446fa0) ? factionlist.faction[2].var_d2446fa0 : #"");
    self.pers[level.var_7ee6af9f] = isdefined(faction.var_ccc3e5ba) ? faction.var_ccc3e5ba : "cdp_commander";
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0xbd85472c, Offset: 0xd80
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
// Params 0, eflags: 0x0
// Checksum 0x2530ea43, Offset: 0xfd8
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
// Params 0, eflags: 0x0
// Checksum 0xa14db52, Offset: 0x1158
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
// Params 0, eflags: 0x0
// Checksum 0x953d6d74, Offset: 0x1358
// Size: 0x3c
function function_5e0a6842() {
    level thread set_music_on_team("roundend_finish");
    leader_dialog("roundSwitchSides");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xb956f0e9, Offset: 0x13a0
// Size: 0x1c
function function_dfd17bd3() {
    leader_dialog("roundHalftime");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x18803cb8, Offset: 0x13c8
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
// Params 1, eflags: 0x0
// Checksum 0x349baa39, Offset: 0x1498
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
// Params 1, eflags: 0x0
// Checksum 0xcf33a0b3, Offset: 0x1688
// Size: 0xe4
function announce_game_winner(outcome) {
    wait battlechatter::mpdialog_value("announceWinnerDelay", 0);
    if (level.teambased) {
        if (outcome::get_flag(outcome, "tie") || !match::function_c10174e7()) {
            leader_dialog("gameDraw");
            return;
        }
        leader_dialog("gameWon", outcome::get_winner(outcome));
        leader_dialog_for_other_teams("gameLost", outcome::get_winner(outcome));
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x3995fe44, Offset: 0x1778
// Size: 0xc
function function_57678746(*outcome) {
    
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x60e8aa07, Offset: 0x1790
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
// Params 0, eflags: 0x0
// Checksum 0x438ee8ae, Offset: 0x1808
// Size: 0xac
function sndmusicfunctions() {
    if (!is_true(level.var_34842a14)) {
        level thread function_13bcae23();
        level thread function_913f483f();
        level thread function_c13cee9b();
    }
    if (!is_true(level.var_ce802423)) {
        level thread sndmusichalfway();
        level thread sndmusictimelimitwatcher();
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xa9e51c1d, Offset: 0x18c0
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
// Params 0, eflags: 0x0
// Checksum 0x90f240ad, Offset: 0x1960
// Size: 0xa0
function function_c13cee9b() {
    level endon(#"game_ended", #"match_ending_very_soon", #"hash_15b8b6edc4ed3032");
    waitresult = level waittill(#"match_ending_soon");
    if (waitresult.event === "score") {
        level notify(#"hash_15b8b6edc4ed3032", {#var_7090bf53:1});
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x5c8499ef, Offset: 0x1a08
// Size: 0x104
function function_13bcae23() {
    level endon(#"game_ended", #"hash_5473f958d5ea84dc");
    var_ffe73385 = 0;
    if (isdefined(level.gametype) && level.gametype == "sd") {
        var_ffe73385 = 1;
    }
    s_waitresult = level waittill(#"hash_15b8b6edc4ed3032");
    if (!is_true(s_waitresult.var_7090bf53)) {
        level notify(#"hash_d50c83061fcd561");
    }
    if (var_ffe73385) {
        level thread set_music_on_team("timeout_loop_quiet");
        return;
    }
    level thread set_music_on_team("timeout_loop");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x54f7b98f, Offset: 0x1b18
// Size: 0x84
function function_913f483f() {
    level endon(#"game_ended", #"hash_d50c83061fcd561");
    s_waitresult = level waittill(#"hash_28434e94a8844dc5");
    if (isdefined(s_waitresult.n_delay)) {
        wait s_waitresult.n_delay;
    }
    level thread set_music_on_team("none");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xe67b0ccb, Offset: 0x1ba8
// Size: 0x94
function sndmusichalfway() {
    level endon(#"game_ended", #"match_ending_soon", #"match_ending_very_soon", #"hash_15b8b6edc4ed3032");
    str_gametype = level.gametype;
    level waittill(#"sndmusichalfway");
    level thread set_music_on_team("underscore");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xe2e2a920, Offset: 0x1c48
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

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x6f504a59, Offset: 0x1d60
// Size: 0x1a0
function function_91d557d3(outcome) {
    if (outcome::get_flag(outcome, "tie") || !match::function_c10174e7()) {
        level thread set_music_global("matchend_draw");
        return;
    }
    if (level.teambased) {
        level thread set_music_on_team("matchend_win", outcome::get_winner(outcome));
        level thread function_89fe8163("matchend_lose", outcome::get_winner(outcome));
        return;
    }
    foreach (player in level.players) {
        if (player === outcome::get_winner(outcome)) {
            player thread set_music_on_player("matchend_win");
            continue;
        }
        player thread set_music_on_player("matchend_lose");
    }
}

