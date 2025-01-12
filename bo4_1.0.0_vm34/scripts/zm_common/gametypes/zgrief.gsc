#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_stats;

#namespace zgrief;

// Namespace zgrief/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x8359dafe, Offset: 0x100
// Size: 0x144
function event_handler[gametype_init] main(eventstruct) {
    zm_gametype::main();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    level.forceallallies = 0;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.ontimelimit = &ontimelimit;
    level.onscorelimit = &onscorelimit;
    level._game_module_custom_spawn_init_func = &zm_gametype::custom_spawn_init_func;
    level._game_module_stat_update_func = &zm_stats::survival_classic_custom_stat_update;
    level._round_start_func = &zm_round_logic::round_start;
    zm_player::register_player_damage_callback(&playerdamagecallback);
    callback::on_spawned(&onplayerspawned);
}

// Namespace zgrief/zgrief
// Params 0, eflags: 0x0
// Checksum 0x6bdf6156, Offset: 0x250
// Size: 0x1e
function onprecachegametype() {
    level.canplayersuicide = &zm_gametype::canplayersuicide;
}

// Namespace zgrief/zgrief
// Params 0, eflags: 0x0
// Checksum 0x41eaa700, Offset: 0x278
// Size: 0x154
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
}

// Namespace zgrief/zgrief
// Params 0, eflags: 0x0
// Checksum 0x3cebb1a9, Offset: 0x3d8
// Size: 0xac
function ontimelimit() {
    winner = globallogic::determineteamwinnerbygamestat("teamScores");
    globallogic_utils::logteamwinstring("time limit", winner);
    setdvar(#"ui_text_endreason", game.strings[#"time_limit_reached"]);
    thread globallogic::endgame(winner, game.strings[#"time_limit_reached"]);
}

// Namespace zgrief/zgrief
// Params 0, eflags: 0x0
// Checksum 0x1874a69, Offset: 0x490
// Size: 0xac
function onscorelimit() {
    winner = globallogic::determineteamwinnerbygamestat("teamScores");
    globallogic_utils::logteamwinstring("scorelimit", winner);
    setdvar(#"ui_text_endreason", game.strings[#"score_limit_reached"]);
    thread globallogic::endgame(winner, game.strings[#"score_limit_reached"]);
}

// Namespace zgrief/zgrief
// Params 10, eflags: 0x0
// Checksum 0x6c24b568, Offset: 0x548
// Size: 0x80
function playerdamagecallback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(eattacker) && isplayer(eattacker)) {
        return 0;
    }
    return idamage;
}

// Namespace zgrief/zgrief
// Params 0, eflags: 0x0
// Checksum 0x4d17f198, Offset: 0x5d0
// Size: 0xd0
function onplayerspawned() {
    self function_cf2b7f4f(1);
    foreach (player in getplayers()) {
        if (player != self) {
            self setignoreent(player, 1);
            player setignoreent(self, 1);
        }
    }
}

