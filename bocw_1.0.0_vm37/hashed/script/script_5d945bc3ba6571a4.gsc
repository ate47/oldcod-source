#using script_1cc417743d7c262d;
#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\core_common\dogtags;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\mp\killstreaks;
#using scripts\mp_common\bb;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\laststand;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;

#namespace namespace_bbf5d955;

// Namespace namespace_bbf5d955/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x98f206ba, Offset: 0x168
// Size: 0x1bc
function event_handler[gametype_init] main(*eventstruct) {
    globallogic::init();
    util::registerroundscorelimit(0, 10000);
    level.takelivesondeath = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundswitch = &onroundswitch;
    level.onendround = &onendround;
    level.laststandrevivehealth = getgametypesetting(#"laststandrevivehealth");
    level.laststandhealth = getgametypesetting(#"laststandhealth");
    level.laststandtimer = getgametypesetting(#"laststandtimer");
    player::function_cf3aa03d(&onplayerkilled);
    spawning::addsupportedspawnpointtype("tdm");
    if (getdvarint(#"hash_5795d85dc4b1b0d9", 0)) {
        level.var_49a15413 = getdvarint(#"hash_5795d85dc4b1b0d9", 0);
        level.scoremodifiercallback = &function_f9df98d3;
    }
}

// Namespace namespace_bbf5d955/namespace_bbf5d955
// Params 0, eflags: 0x0
// Checksum 0x3f43a2d7, Offset: 0x330
// Size: 0xac
function onstartgametype() {
    level.displayroundendtext = 0;
    level thread onscoreclosemusic();
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
        if (level.scoreroundwinbased) {
            globallogic_score::resetteamscores();
        }
    }
    if (is_true(level.droppedtagrespawn)) {
        level.numlives = 1;
    }
    laststand_mp::function_414115a0(level.laststandtimer, level.laststandhealth);
}

// Namespace namespace_bbf5d955/namespace_bbf5d955
// Params 1, eflags: 0x0
// Checksum 0x6315c1fd, Offset: 0x3e8
// Size: 0x7c
function onspawnplayer(predictedspawn) {
    self.usingobj = undefined;
    if (spawning::usestartspawns() && !level.ingraceperiod && !level.playerqueuedrespawn) {
        spawning::function_7a87efaa();
    }
    spawning::onspawnplayer(predictedspawn);
}

// Namespace namespace_bbf5d955/namespace_bbf5d955
// Params 0, eflags: 0x0
// Checksum 0xef0c719b, Offset: 0x470
// Size: 0x24
function onroundswitch() {
    gametype::on_round_switch();
    globallogic_score::function_9779ac61();
}

// Namespace namespace_bbf5d955/namespace_bbf5d955
// Params 1, eflags: 0x0
// Checksum 0xe392409e, Offset: 0x4a0
// Size: 0x24
function onendround(var_c1e98979) {
    function_e596b745(var_c1e98979);
}

// Namespace namespace_bbf5d955/namespace_bbf5d955
// Params 0, eflags: 0x0
// Checksum 0x1f08d756, Offset: 0x4d0
// Size: 0x19c
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

// Namespace namespace_bbf5d955/namespace_bbf5d955
// Params 9, eflags: 0x0
// Checksum 0xdfd4b2b8, Offset: 0x678
// Size: 0x214
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (smeansofdeath == "MOD_META") {
        return;
    }
    if (is_true(level.droppedtagrespawn)) {
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
    if (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || is_true(level.killstreaksgivegamescore)) {
        attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
        self globallogic_score::giveteamscoreforobjective(self.team, level.teamscoreperdeath * -1);
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperheadshot);
        }
    }
}

// Namespace namespace_bbf5d955/namespace_bbf5d955
// Params 1, eflags: 0x0
// Checksum 0x2210c095, Offset: 0x898
// Size: 0x104
function function_e596b745(var_c1e98979) {
    gamemodedata = spawnstruct();
    gamemodedata.remainingtime = max(0, globallogic_utils::gettimeremaining());
    switch (var_c1e98979) {
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
    bb::function_bf5cad4e(gamemodedata);
}

// Namespace namespace_bbf5d955/namespace_bbf5d955
// Params 2, eflags: 0x0
// Checksum 0x149c19f6, Offset: 0x9a8
// Size: 0x3e
function function_f9df98d3(type, value) {
    if (type === #"ekia") {
        return (value + level.var_49a15413);
    }
    return value;
}

