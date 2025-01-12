#using scripts\core_common\hud_message_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\teams\teams;

#namespace hud_message;

// Namespace hud_message/hud_message
// Params 0, eflags: 0x0
// Checksum 0x48d11467, Offset: 0xb0
// Size: 0x7e4
function init() {
    game.strings[#"draw"] = #"hash_18114ebf7e352c55";
    game.strings[#"round_draw"] = #"hash_68d9a667406d9e2e";
    game.strings[#"round_win"] = #"hash_3f72c8cf61961fb2";
    game.strings[#"round_loss"] = #"hash_70e6b03f0ea9b11d";
    game.strings[#"victory"] = #"hash_31e1e88e88ba263f";
    game.strings[#"defeat"] = #"hash_141c79e0a2e1383e";
    game.strings[#"game_over"] = #"hash_ddc319addc8bcb2";
    game.strings[#"halftime"] = #"hash_4403919077b48aaf";
    game.strings[#"overtime"] = #"hash_19d325d8d1bfd3de";
    game.strings[#"roundend"] = #"hash_62af47ae5592dbf8";
    game.strings[#"intermission"] = #"hash_24bb668f17a9cc67";
    game.strings[#"match_bonus"] = #"mp/match_bonus_is";
    game.strings[#"codpoints_match_bonus"] = #"mp_codpoints_match_bonus_is";
    game.strings[#"join_in_progress_loss"] = #"hash_78659165510b8525";
    game.strings[#"cod_caster_team_wins"] = #"mp/wins";
    game.strings[#"cod_caster_team_eliminated"] = #"mp/team_eliminated";
    game.strings[#"tie"] = #"mp/match_tie";
    game.strings[#"round_draw"] = #"mp/round_draw";
    game.strings[#"enemies_eliminated"] = #"hash_3191d03a1c0615ad";
    game.strings[#"team_eliminated"] = #"hash_5ebfcbc4ad2769b6";
    game.strings[#"score_limit_reached"] = #"mp/score_limit_reached";
    game.strings[#"round_score_limit_reached"] = #"mp/score_limit_reached";
    game.strings[#"round_limit_reached"] = #"mp/round_limit_reached";
    game.strings[#"time_limit_reached"] = #"mp/time_limit_reached";
    game.strings[#"players_forfeited"] = #"mp/players_forfeited";
    game.strings[#"other_teams_forfeited"] = #"mp_other_teams_forfeited";
    game.strings[#"host_sucks"] = #"mp/host_sucks";
    game.strings[#"host_ended"] = #"hash_cd63faed592da03";
    game.strings[#"game_ended"] = #"mp/ended_game";
    level.var_4d8b6071 = [];
    function_cc857065(0, game.strings[#"tie"]);
    function_402fbbd3(1, game.strings[#"victory"], game.strings[#"defeat"]);
    function_cc857065(2, game.strings[#"time_limit_reached"]);
    function_402fbbd3(3, game.strings[#"score_limit_reached"], game.strings[#"score_limit_reached"]);
    function_402fbbd3(4, game.strings[#"round_score_limit_reached"], game.strings[#"round_score_limit_reached"]);
    function_402fbbd3(5, game.strings[#"round_limit_reached"], game.strings[#"round_limit_reached"]);
    function_402fbbd3(6, game.strings[#"enemies_eliminated"], game.strings[#"team_eliminated"]);
    function_cc857065(8, game.strings[#"game_ended"]);
    function_858ef465(9, game.strings[#"host_ended"], game.strings[#"game_ended"]);
    function_cc857065(10, game.strings[#"host_sucks"]);
}

// Namespace hud_message/hud_message
// Params 1, eflags: 0x4
// Checksum 0xeccc40af, Offset: 0x8a0
// Size: 0xa8
function private function_2b247181(winner) {
    if (!isdefined(self.pers[#"team"])) {
        return false;
    }
    team = self.pers[#"team"];
    if (team != #"spectator" && (!isdefined(team) || !isdefined(level.teams[team]))) {
        team = #"allies";
    }
    return winner == team;
}

// Namespace hud_message/hud_message
// Params 2, eflags: 0x4
// Checksum 0x925428f3, Offset: 0x950
// Size: 0x152
function private function_b0f3ab3b(outcome, result) {
    if (outcome::get_flag(outcome, "tie")) {
        result.var_5f49c61d = game.strings[#"tie"];
    } else if (outcome::is_winner(outcome, self)) {
        result.var_5f49c61d = game.strings[#"victory"];
    } else {
        result.var_5f49c61d = game.strings[#"defeat"];
        if (isdefined(level.enddefeatreasontext)) {
            result.var_5f49c61d = level.enddefeatreasontext;
        }
        if ((level.rankedmatch || level.leaguematch) && self.pers[#"latejoin"] === 1) {
            result.var_5f49c61d = game.strings[#"join_in_progress_loss"];
        }
    }
    result.var_e6e64c7 = 1;
    return result;
}

// Namespace hud_message/hud_message
// Params 1, eflags: 0x0
// Checksum 0xc8425b80, Offset: 0xab0
// Size: 0x1e
function function_ff0a3abc(var_c3d87d03) {
    switch (var_c3d87d03) {
    case 0:
    case 8:
    case 9:
    case 10:
        return true;
    default:
        return false;
    }
}

// Namespace hud_message/hud_message
// Params 1, eflags: 0x4
// Checksum 0xf3f8f632, Offset: 0xb38
// Size: 0x4e
function private function_b441f74e(game_end) {
    if (game_end) {
        return game.strings[#"draw"];
    }
    return game.strings[#"round_draw"];
}

// Namespace hud_message/hud_message
// Params 4, eflags: 0x0
// Checksum 0xb6a927f3, Offset: 0xb90
// Size: 0x2d2
function function_75c92765(var_a9bcb48, var_c3d87d03, game_end, outcome) {
    result = structcopy(outcome);
    result.var_fc7b3e26 = undefined;
    result.var_a9bcb48 = var_a9bcb48;
    result.var_5f49c61d = "";
    result.var_e6e64c7 = 0;
    if (level.teambased) {
        result.var_9fa4388e = teams::getteamindex(result.team);
        if (function_ff0a3abc(var_c3d87d03)) {
            result.var_5f49c61d = function_b441f74e(game_end);
            result.var_fc7b3e26 = 0;
        } else if (var_a9bcb48 == 2) {
            result.var_5f49c61d = game.strings[#"halftime"];
            result.var_fc7b3e26 = 1;
        } else if (var_a9bcb48 == 3) {
            result.var_5f49c61d = game.strings[#"intermission"];
            result.var_fc7b3e26 = 1;
        } else if (var_a9bcb48 == 4) {
            result.var_5f49c61d = game.strings[#"overtime"];
            result.var_fc7b3e26 = 1;
        } else {
            if (outcome::get_flag(outcome, "tie")) {
                result.var_5f49c61d = function_b441f74e(game_end);
            }
            result.var_fc7b3e26 = !game_end && !util::isoneround() && !util::waslastround();
        }
    } else {
        result.var_9fa4388e = 0;
        if (!util::isoneround() && game_end) {
            result.var_5f49c61d = game.strings[#"game_over"];
        } else {
            result.var_5f49c61d = game.strings[#"defeat"];
            result.var_e6e64c7 = 1;
        }
    }
    return result;
}

// Namespace hud_message/hud_message
// Params 0, eflags: 0x4
// Checksum 0xe11060bf, Offset: 0xe70
// Size: 0x78
function private function_c4544781() {
    if (isdefined(self.pers[#"totalmatchbonus"])) {
        bonus = ceil(self.pers[#"totalmatchbonus"] * level.xpscale);
        if (bonus > 0) {
            return bonus;
        }
    }
    return 0;
}

// Namespace hud_message/hud_message
// Params 1, eflags: 0x0
// Checksum 0x6777fff8, Offset: 0xef0
// Size: 0x814
function teamoutcomenotify(outcome) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    team = self.pers[#"team"];
    if (team != #"spectator" && (!isdefined(team) || !isdefined(level.teams[team]))) {
        team = #"allies";
    }
    self endon(#"reset_outcome");
    matchbonus = function_c4544781();
    winnerenum = outcome.var_9fa4388e;
    winner = outcome.team;
    var_5f49c61d = outcome.var_5f49c61d;
    var_fc7b3e26 = outcome.var_fc7b3e26;
    if (!isdefined(winner)) {
        return;
    }
    outcometext = function_fd9ce7ff(self, outcome);
    if ((level.gametype == "ctf" || level.gametype == "escort" || level.gametype == "ball") && overtime::is_overtime_round()) {
        if (outcome::get_flag(outcome, "overtime")) {
            if (isdefined(game.overtime_first_winner)) {
                winner = game.overtime_first_winner;
            }
            if (!outcome::get_flag(outcome, "tie")) {
                winningtime = game.overtime_time_to_beat[level.gametype];
            }
        } else {
            if (isdefined(game.overtime_first_winner) && game.overtime_first_winner == "tie") {
                winningtime = game.overtime_best_time[level.gametype];
            } else {
                winningtime = undefined;
                if (outcome::get_flag(outcome, "tie") && isdefined(game.overtime_first_winner)) {
                    if (game.overtime_first_winner == #"allies") {
                        winnerenum = 1;
                    } else if (game.overtime_first_winner == #"axis") {
                        winnerenum = 2;
                    }
                }
                if (isdefined(game.overtime_time_to_beat[level.gametype])) {
                    winningtime = game.overtime_time_to_beat[level.gametype];
                }
                if (isdefined(game.overtime_best_time[level.gametype]) && (!isdefined(winningtime) || winningtime > game.overtime_best_time[level.gametype])) {
                    if (game.overtime_first_winner !== winner) {
                        losingtime = winningtime;
                    }
                    winningtime = game.overtime_best_time[level.gametype];
                    if (outcome::set_flag(outcome, "tie")) {
                        winningtime = 0;
                    }
                }
            }
            if (level.gametype == "escort" && outcome::get_flag(outcome, "tie")) {
                winnerenum = 0;
                if (!(isdefined(level.finalgameend) && level.finalgameend)) {
                    if (game.defenders == team) {
                        outcometext = game.strings[#"round_win"];
                    } else {
                        outcometext = game.strings[#"round_loss"];
                    }
                }
            }
        }
        if (!isdefined(winningtime)) {
            winningtime = 0;
        }
        if (!isdefined(losingtime)) {
            losingtime = 0;
        }
        if (winningtime == 0 && losingtime == 0) {
            winnerenum = 0;
        }
        if (team == #"spectator" && outcome.var_e6e64c7) {
            outcometext = game.strings[#"cod_caster_team_wins"];
            var_fc7b3e26 = 0;
        }
        self luinotifyevent(#"show_outcome", 7, var_5f49c61d, outcometext, int(matchbonus), winnerenum, var_fc7b3e26, int(float(winningtime) / 1000), int(float(losingtime) / 1000));
        return;
    }
    if (level.gametype == "ball" && !outcome::get_flag(outcome, "tie") && game.roundsplayed < level.roundlimit && isdefined(game.round_time_to_beat) && !overtime::is_overtime_round()) {
        winningtime = game.round_time_to_beat;
        if (!isdefined(losingtime)) {
            losingtime = 0;
        }
        if (team == #"spectator" && outcome.var_e6e64c7) {
            var_5f49c61d = game.strings[#"cod_caster_team_wins"];
            var_fc7b3e26 = 0;
        }
        self luinotifyevent(#"show_outcome", 7, var_5f49c61d, outcometext, int(matchbonus), winnerenum, var_fc7b3e26, int(float(winningtime) / 1000), int(float(losingtime) / 1000));
        return;
    }
    if (team == #"spectator" && outcome.var_e6e64c7) {
        if (outcome.var_c3d87d03 == 6) {
            var_5f49c61d = game.strings[#"cod_caster_team_eliminated"];
        }
        var_5f49c61d = game.strings[#"cod_caster_team_wins"];
        var_fc7b3e26 = 0;
    }
    self luinotifyevent(#"show_outcome", 5, var_5f49c61d, outcometext, int(matchbonus), winnerenum, var_fc7b3e26);
    if (var_fc7b3e26 && game.roundsplayed < level.roundlimit) {
        self luinotifyevent(#"hash_84895967cf4425c");
        wait 1;
    }
}

// Namespace hud_message/hud_message
// Params 1, eflags: 0x0
// Checksum 0x177463f3, Offset: 0x1710
// Size: 0x1bc
function outcomenotify(outcome) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    self endon(#"reset_outcome");
    players = level.placement[#"all"];
    numclients = players.size;
    matchbonus = function_c4544781();
    outcometext = function_fd9ce7ff(self, outcome);
    team = self.pers[#"team"];
    if (isdefined(team) && team == #"spectator" && outcome.var_e6e64c7) {
        outcometext = game.strings[#"cod_caster_team_wins"];
        self luinotifyevent(#"show_outcome", 5, outcome.var_5f49c61d, outcometext, matchbonus, outcome::get_winner(outcome), 0);
        return;
    }
    self luinotifyevent(#"show_outcome", 4, outcome.var_5f49c61d, outcometext, matchbonus, numclients);
}

// Namespace hud_message/hud_message
// Params 0, eflags: 0x0
// Checksum 0xd275f56b, Offset: 0x18d8
// Size: 0x2c
function hide_outcome() {
    self luinotifyevent(#"pre_killcam_transition", 1, 0);
}

// Namespace hud_message/hud_message
// Params 5, eflags: 0x4
// Checksum 0x91ffa5fc, Offset: 0x1910
// Size: 0x96
function private function_dcc14bb9(var_c3d87d03, winner_text, loser_text, var_4ae243fb, var_90b616a9) {
    level.var_4d8b6071[var_c3d87d03] = {#type:var_c3d87d03, #winner_text:winner_text, #loser_text:loser_text, #var_d2d37397:var_4ae243fb, #var_fec91155:var_90b616a9};
}

// Namespace hud_message/hud_message
// Params 3, eflags: 0x0
// Checksum 0xbaf53d59, Offset: 0x19b0
// Size: 0x44
function function_858ef465(var_c3d87d03, var_ccaee527, var_e209a9b4) {
    function_dcc14bb9(var_c3d87d03, var_ccaee527, var_ccaee527, var_e209a9b4, var_e209a9b4);
}

// Namespace hud_message/hud_message
// Params 2, eflags: 0x0
// Checksum 0xea6cd14c, Offset: 0x1a00
// Size: 0x4c
function function_cc857065(var_c3d87d03, var_ccaee527) {
    function_dcc14bb9(var_c3d87d03, var_ccaee527, var_ccaee527, #"", #"");
}

// Namespace hud_message/hud_message
// Params 3, eflags: 0x0
// Checksum 0x6a622e82, Offset: 0x1a58
// Size: 0x54
function function_402fbbd3(var_c3d87d03, winner_text, loser_text) {
    function_dcc14bb9(var_c3d87d03, winner_text, loser_text, #"", #"");
}

// Namespace hud_message/hud_message
// Params 2, eflags: 0x0
// Checksum 0x787e55fa, Offset: 0x1ab8
// Size: 0xee
function function_fd9ce7ff(player, outcome) {
    assert(isdefined(level.var_4d8b6071[outcome.var_c3d87d03]));
    if (outcome::get_flag(outcome, "tie") && !function_ff0a3abc(outcome.var_c3d87d03)) {
        return game.strings[#"tie"];
    }
    if (outcome::is_winner(outcome, player)) {
        return level.var_4d8b6071[outcome.var_c3d87d03].winner_text;
    }
    return level.var_4d8b6071[outcome.var_c3d87d03].loser_text;
}

