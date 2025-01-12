#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\mp\killstreaks;
#using scripts\mp_common\bb;
#using scripts\mp_common\gametypes\dogtags;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;

#namespace tdm;

// Namespace tdm/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x8b3f4a99, Offset: 0x178
// Size: 0x294
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
    level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
    level.teamscoreperdeath = getgametypesetting(#"teamscoreperdeath");
    level.teamscoreperheadshot = getgametypesetting(#"teamscoreperheadshot");
    level.killstreaksgivegamescore = getgametypesetting(#"killstreaksgivegamescore");
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundswitch = &onroundswitch;
    level.onendround = &onendround;
    level.var_c9d3723c = &function_4fdb87a6;
    player::function_b0320e78(&onplayerkilled);
    globallogic_audio::set_leader_gametype_dialog("startTeamDeathmatch", "hcStartTeamDeathmatch", "gameBoost", "gameBoost");
    globallogic_spawn::addsupportedspawnpointtype("tdm");
}

// Namespace tdm/tdm
// Params 0, eflags: 0x0
// Checksum 0x59e34d37, Offset: 0x418
// Size: 0xec
function function_4fdb87a6() {
    foreach (team, _ in level.teams) {
        spawning::add_spawn_points(team, "mp_tdm_spawn");
        spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
        spawning::add_start_spawn_points(team, spawning::gettdmstartspawnname(team));
    }
    spawning::updateallspawnpoints();
}

// Namespace tdm/tdm
// Params 0, eflags: 0x0
// Checksum 0xde4e188, Offset: 0x510
// Size: 0x9a
function onstartgametype() {
    level.displayroundendtext = 0;
    level thread onscoreclosemusic();
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
        if (level.scoreroundwinbased) {
            globallogic_score::resetteamscores();
        }
    }
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        level.numlives = 1;
    }
}

// Namespace tdm/tdm
// Params 1, eflags: 0x0
// Checksum 0x16960193, Offset: 0x5b8
// Size: 0x64
function onspawnplayer(predictedspawn) {
    self.usingobj = undefined;
    if (level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn) {
        level.usestartspawns = 0;
    }
    spawning::onspawnplayer(predictedspawn);
}

// Namespace tdm/tdm
// Params 0, eflags: 0x0
// Checksum 0xd0fe0e80, Offset: 0x628
// Size: 0x24
function onroundswitch() {
    gametype::on_round_switch();
    globallogic_score::updateteamscorebyroundswon();
}

// Namespace tdm/tdm
// Params 1, eflags: 0x0
// Checksum 0xe2b933b6, Offset: 0x658
// Size: 0x24
function onendround(var_c3d87d03) {
    function_cb1bba14(var_c3d87d03);
}

// Namespace tdm/tdm
// Params 0, eflags: 0x0
// Checksum 0x5d5c9481, Offset: 0x688
// Size: 0x1a4
function onscoreclosemusic() {
    teamscores = [];
    while (!level.gameended) {
        scorelimit = level.scorelimit;
        scorethreshold = scorelimit * 0.1;
        scorethresholdstart = abs(scorelimit - scorethreshold);
        scorelimitcheck = scorelimit - 10;
        topscore = 0;
        runnerupscore = 0;
        foreach (team, _ in level.teams) {
            score = [[ level._getteamscore ]](team);
            if (score > topscore) {
                runnerupscore = topscore;
                topscore = score;
                continue;
            }
            if (score > runnerupscore) {
                runnerupscore = score;
            }
        }
        scoredif = topscore - runnerupscore;
        if (topscore >= scorelimit * 0.5) {
            level notify(#"sndmusichalfway");
            return;
        }
        wait 1;
    }
}

// Namespace tdm/tdm
// Params 9, eflags: 0x0
// Checksum 0x1923bd20, Offset: 0x838
// Size: 0x224
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (smeansofdeath == "MOD_META") {
        return;
    }
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        thread dogtags::checkallowspectating();
        should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
        if (should_spawn_tags) {
            level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
        }
    }
    if (isplayer(attacker) == 0 || attacker.team == self.team) {
        return;
    }
    if (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore) {
        attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
        self globallogic_score::giveteamscoreforobjective(self.team, level.teamscoreperdeath * -1);
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperheadshot);
        }
    }
}

// Namespace tdm/tdm
// Params 1, eflags: 0x0
// Checksum 0x7bcb60c, Offset: 0xa68
// Size: 0x114
function function_cb1bba14(var_c3d87d03) {
    gamemodedata = spawnstruct();
    gamemodedata.remainingtime = max(0, globallogic_utils::gettimeremaining());
    switch (var_c3d87d03) {
    case 2:
        gamemodedata.wintype = "time_limit_reached";
        break;
    case 3:
        gamemodedata.wintype = "score_limit_reached";
        break;
    case 9:
    case 10:
    default:
        gamemodedata.wintype = "NA";
        break;
    }
    bb::function_a4648ef4(gamemodedata);
}

