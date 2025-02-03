#using script_1cc417743d7c262d;
#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;

#namespace dm;

// Namespace dm/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x516df875, Offset: 0xe8
// Size: 0xdc
function event_handler[gametype_init] main(*eventstruct) {
    globallogic::init();
    level.onstartgametype = &onstartgametype;
    player::function_cf3aa03d(&onplayerkilled);
    level.onspawnplayer = &onspawnplayer;
    level.onendgame = &onendgame;
    spawning::addsupportedspawnpointtype("ffa");
    spawning::function_32b97d1b(&spawning::function_90dee50d);
    spawning::function_adbbb58a(&spawning::function_c24e290c);
}

// Namespace dm/dm
// Params 1, eflags: 0x0
// Checksum 0x3f2f65f7, Offset: 0x1d0
// Size: 0xc
function setupteam(*team) {
    
}

// Namespace dm/dm
// Params 0, eflags: 0x0
// Checksum 0x38c11ae4, Offset: 0x1e8
// Size: 0x44
function onstartgametype() {
    level.displayroundendtext = 0;
    level thread onscoreclosemusic();
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
    }
}

// Namespace dm/dm
// Params 1, eflags: 0x0
// Checksum 0x5d8c6d86, Offset: 0x238
// Size: 0x74
function onendgame(*var_c1e98979) {
    player = round::function_b5f4c9d8();
    if (isdefined(player)) {
        [[ level._setplayerscore ]](player, [[ level._getplayerscore ]](player) + 1);
    }
    match::set_winner(player);
}

// Namespace dm/dm
// Params 0, eflags: 0x0
// Checksum 0x692c8067, Offset: 0x2b8
// Size: 0xac
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
// Checksum 0x2115de5a, Offset: 0x370
// Size: 0x44
function onspawnplayer(predictedspawn) {
    if (!level.inprematchperiod) {
        spawning::function_7a87efaa();
    }
    spawning::onspawnplayer(predictedspawn);
}

// Namespace dm/dm
// Params 9, eflags: 0x0
// Checksum 0xa21cb35a, Offset: 0x3c0
// Size: 0x11c
function onplayerkilled(*einflictor, attacker, *idamage, smeansofdeath, weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration) {
    if (!isplayer(shitloc) || self == shitloc) {
        return;
    }
    if (!isdefined(killstreaks::get_killstreak_for_weapon(deathanimduration)) || is_true(level.killstreaksgivegamescore)) {
        shitloc globallogic_score::givepointstowin(level.teamscoreperkill);
        self globallogic_score::givepointstowin(level.teamscoreperdeath * -1);
        if (psoffsettime == "MOD_HEAD_SHOT") {
            shitloc globallogic_score::givepointstowin(level.teamscoreperheadshot);
        }
    }
}

