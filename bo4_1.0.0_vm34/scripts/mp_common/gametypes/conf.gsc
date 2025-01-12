#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\gametypes\dogtags;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\hostmigration;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;

#namespace conf;

// Namespace conf/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xf1622769, Offset: 0x118
// Size: 0x224
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundswitch(0, 9);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    player::function_b0320e78(&onplayerkilled);
    level.overrideteamscore = 1;
    level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
    level.teamscoreperkillconfirmed = getgametypesetting(#"teamscoreperkillconfirmed");
    level.teamscoreperkilldenied = getgametypesetting(#"teamscoreperkilldenied");
    level.var_c9d3723c = &function_4fdb87a6;
    globallogic_audio::set_leader_gametype_dialog("startKillConfirmed", "hcCtartKillConfirmed", "gameBoost", "gameBoost");
}

// Namespace conf/conf
// Params 0, eflags: 0x0
// Checksum 0xc722a572, Offset: 0x348
// Size: 0xec
function function_4fdb87a6() {
    foreach (team, _ in level.teams) {
        spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
        spawning::add_spawn_points(team, "mp_tdm_spawn");
        spawning::add_start_spawn_points(team, spawning::gettdmstartspawnname(team));
    }
    spawning::updateallspawnpoints();
}

// Namespace conf/conf
// Params 0, eflags: 0x0
// Checksum 0xc41d4329, Offset: 0x440
// Size: 0x36
function onstartgametype() {
    dogtags::init();
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
    }
}

// Namespace conf/conf
// Params 9, eflags: 0x0
// Checksum 0xbb5737fd, Offset: 0x480
// Size: 0x11c
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!isplayer(attacker) || attacker.team == self.team) {
        return;
    }
    level thread dogtags::spawn_dog_tag(self, attacker, &onuse, 1);
    if (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore) {
        attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
    }
}

// Namespace conf/conf
// Params 1, eflags: 0x0
// Checksum 0x15c84bc, Offset: 0x5a8
// Size: 0x286
function onuse(player) {
    tacinsertboost = 0;
    player.pers[#"objectives"]++;
    player.objectives = player.pers[#"objectives"];
    if (player.team != self.attackerteam) {
        tacinsertboost = self.tacinsert;
        if (isdefined(self.attacker) && self.attacker.team == self.attackerteam) {
            self.attacker luinotifyevent(#"player_callout", 2, #"mp/kill_denied", player.entnum);
        }
        if (!tacinsertboost) {
            player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkilldenied);
        }
        return;
    }
    /#
        assert(isdefined(player.lastkillconfirmedtime));
        assert(isdefined(player.lastkillconfirmedcount));
    #/
    player.pers[#"killsconfirmed"]++;
    player.killsconfirmed = player.pers[#"killsconfirmed"];
    player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkillconfirmed);
    if (!tacinsertboost) {
        currenttime = gettime();
        if (player.lastkillconfirmedtime + 4000 > currenttime) {
            player.lastkillconfirmedcount++;
            if (player.lastkillconfirmedcount >= 3) {
                scoreevents::processscoreevent(#"kill_confirmed_multi", player, undefined, undefined);
                player.lastkillconfirmedcount = 0;
            }
        } else {
            player.lastkillconfirmedcount = 1;
        }
        player.lastkillconfirmedtime = currenttime;
    }
}

// Namespace conf/conf
// Params 1, eflags: 0x0
// Checksum 0xdf81cbe0, Offset: 0x838
// Size: 0x7c
function onspawnplayer(predictedspawn) {
    self.usingobj = undefined;
    if (level.usestartspawns && !level.ingraceperiod) {
        level.usestartspawns = 0;
    }
    self.lastkillconfirmedtime = 0;
    self.lastkillconfirmedcount = 0;
    spawning::onspawnplayer(predictedspawn);
    dogtags::on_spawn_player();
}

