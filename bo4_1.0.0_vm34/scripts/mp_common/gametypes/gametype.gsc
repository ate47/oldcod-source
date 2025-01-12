#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;

#namespace gametype;

// Namespace gametype/gametype
// Params 0, eflags: 0x0
// Checksum 0x1c8ddb78, Offset: 0xe8
// Size: 0x156
function init() {
    bundle = function_5cadb094();
    level.var_b77eff6f = bundle;
    level.var_97a6063f = 0;
    if (!isdefined(bundle)) {
        return;
    }
    level.teambased = isgametypeteambased();
    setvisiblescoreboardcolumns(bundle.scoreboard_1, bundle.scoreboard_2, bundle.scoreboard_3, bundle.scoreboard_4, bundle.scoreboard_5, bundle.var_8e072e84, bundle.var_b409a8ed, bundle.var_72160cfa, "ability_medal_count", "equipment_medal_count");
    globallogic_audio::set_leader_gametype_dialog(bundle.var_995fea4d, bundle.var_57c1be72, bundle.var_642bc01, bundle.var_b22ab71b);
    if (!isdefined(game.switchedsides)) {
        game.switchedsides = 0;
    }
    level.onroundswitch = &on_round_switch;
}

// Namespace gametype/gametype
// Params 0, eflags: 0x0
// Checksum 0x8b78349e, Offset: 0x248
// Size: 0x7c
function on_start_game_type() {
    bundle = level.var_b77eff6f;
    if (!isdefined(bundle)) {
        return;
    }
    function_db49aa83();
    util::function_bbca659b();
    if (!util::isoneround() && level.scoreroundwinbased) {
        globallogic_score::resetteamscores();
    }
}

// Namespace gametype/gametype
// Params 0, eflags: 0x0
// Checksum 0x1b044d07, Offset: 0x2d0
// Size: 0x7c
function on_round_switch() {
    bundle = level.var_b77eff6f;
    if (!isdefined(bundle)) {
        return;
    }
    if (isdefined(level.var_b77eff6f.switchsides) && level.var_b77eff6f.switchsides) {
        game.switchedsides = !game.switchedsides;
        userspawnselection::onroundchange();
    }
}

// Namespace gametype/gametype
// Params 1, eflags: 0x4
// Checksum 0xc2c96d02, Offset: 0x358
// Size: 0x20
function private function_c039b345(value) {
    if (!isdefined(value)) {
        return "";
    }
    return value;
}

// Namespace gametype/gametype
// Params 10, eflags: 0x0
// Checksum 0x3dd27706, Offset: 0x380
// Size: 0x1ec
function setvisiblescoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10) {
    col1 = function_c039b345(col1);
    col2 = function_c039b345(col2);
    col3 = function_c039b345(col3);
    col4 = function_c039b345(col4);
    col5 = function_c039b345(col5);
    col6 = function_c039b345(col6);
    col7 = function_c039b345(col7);
    col8 = function_c039b345(col8);
    col9 = function_c039b345(col9);
    col10 = function_c039b345(col10);
    if (!level.rankedmatch) {
        setscoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10, "sbtimeplayed", "shotshit", "shotsmissed", "victory");
        return;
    }
    setscoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10);
}

// Namespace gametype/gametype
// Params 0, eflags: 0x0
// Checksum 0x33b4443c, Offset: 0x578
// Size: 0x8c
function function_db49aa83() {
    if (isdefined(level.var_b77eff6f.switchsides) && level.var_b77eff6f.switchsides && game.switchedsides) {
        util::set_team_mapping(game.defenders, game.attackers);
        return;
    }
    util::set_team_mapping(game.attackers, game.defenders);
}

