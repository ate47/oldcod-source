#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;

#namespace dm;

// Namespace dm/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x4c277f6, Offset: 0x118
// Size: 0x234
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 0, 0, 1440);
    level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
    level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
    level.teamscoreperdeath = getgametypesetting(#"teamscoreperdeath");
    level.teamscoreperheadshot = getgametypesetting(#"teamscoreperheadshot");
    level.killstreaksgivegamescore = getgametypesetting(#"killstreaksgivegamescore");
    level.onstartgametype = &onstartgametype;
    player::function_b0320e78(&onplayerkilled);
    level.onspawnplayer = &onspawnplayer;
    level.var_c9d3723c = &function_4fdb87a6;
    globallogic_spawn::addsupportedspawnpointtype("ffa");
    globallogic_audio::set_leader_gametype_dialog("startFreeForAll", "hcStartFreeForAll", "gameBoost", "gameBoost");
}

// Namespace dm/dm
// Params 0, eflags: 0x0
// Checksum 0x60b94653, Offset: 0x358
// Size: 0xb4
function function_4fdb87a6() {
    foreach (team, _ in level.teams) {
        spawning::add_spawn_points(team, "mp_dm_spawn");
    }
    spawning::place_spawn_points("mp_dm_spawn_start");
    spawning::updateallspawnpoints();
}

// Namespace dm/dm
// Params 1, eflags: 0x0
// Checksum 0x2513963b, Offset: 0x418
// Size: 0xc
function setupteam(team) {
    
}

// Namespace dm/dm
// Params 0, eflags: 0x0
// Checksum 0x388ce857, Offset: 0x430
// Size: 0x64
function onstartgametype() {
    level.displayroundendtext = 0;
    level thread onscoreclosemusic();
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
    }
    globallogic_spawn::addspawns();
}

// Namespace dm/dm
// Params 1, eflags: 0x0
// Checksum 0xde0fee16, Offset: 0x4a0
// Size: 0x5c
function onendgame(var_c3d87d03) {
    player = round::function_2da88e92();
    if (isdefined(player)) {
        [[ level._setplayerscore ]](player, player [[ level._getplayerscore ]]() + 1);
    }
}

// Namespace dm/dm
// Params 0, eflags: 0x0
// Checksum 0x78eb4411, Offset: 0x508
// Size: 0xb0
function onscoreclosemusic() {
    while (!level.gameended) {
        scorelimit = level.scorelimit;
        scorethreshold = scorelimit * 0.9;
        for (i = 0; i < level.players.size; i++) {
            scorecheck = [[ level._getplayerscore ]](level.players[i]);
            if (scorecheck >= scorethreshold) {
                return;
            }
        }
        wait 0.5;
    }
}

// Namespace dm/dm
// Params 1, eflags: 0x0
// Checksum 0x99763c35, Offset: 0x5c0
// Size: 0x3c
function onspawnplayer(predictedspawn) {
    if (!level.inprematchperiod) {
        level.usestartspawns = 0;
    }
    spawning::onspawnplayer(predictedspawn);
}

// Namespace dm/dm
// Params 9, eflags: 0x0
// Checksum 0x79fddfa2, Offset: 0x608
// Size: 0x124
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!isplayer(attacker) || self == attacker) {
        return;
    }
    if (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore) {
        attacker globallogic_score::givepointstowin(level.teamscoreperkill);
        self globallogic_score::givepointstowin(level.teamscoreperdeath * -1);
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            attacker globallogic_score::givepointstowin(level.teamscoreperheadshot);
        }
    }
}

