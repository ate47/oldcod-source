#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_b9a55edd207e4ca;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dogtags;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;

#namespace namespace_f2e23b4a;

// Namespace namespace_f2e23b4a/namespace_f2e23b4a
// Params 0, eflags: 0x6
// Checksum 0x2e719452, Offset: 0xe0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_112a74f076cda31", &function_62730899, undefined, undefined, #"territory");
}

// Namespace namespace_f2e23b4a/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x40c4cb52, Offset: 0x130
// Size: 0x8c
function event_handler[gametype_init] main(*eventstruct) {
    namespace_2938acdc::init();
    spawning::addsupportedspawnpointtype("tdm");
    callback::on_spawned(&on_player_spawned);
    level.var_61d4f517 = 1;
    level.var_febab1ea = #"conf_dogtags_hpc";
    level.var_e7b05b51 = 1;
}

// Namespace namespace_f2e23b4a/namespace_f2e23b4a
// Params 0, eflags: 0x4
// Checksum 0x4061683b, Offset: 0x1c8
// Size: 0xd4
function private function_62730899() {
    if (isdefined(level.territory) && level.territory.name != "zoo") {
        namespace_2938acdc::function_4212369d();
    }
    level.onstartgametype = &onstartgametype;
    player::function_cf3aa03d(&onplayerkilled);
    level.teamscoreperkillconfirmed = getgametypesetting(#"teamscoreperkillconfirmed");
    level.teamscoreperkilldenied = getgametypesetting(#"teamscoreperkilldenied");
}

// Namespace namespace_f2e23b4a/namespace_f2e23b4a
// Params 0, eflags: 0x0
// Checksum 0xa2ef4256, Offset: 0x2a8
// Size: 0x34
function onstartgametype() {
    dogtags::init();
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
    }
}

// Namespace namespace_f2e23b4a/namespace_f2e23b4a
// Params 1, eflags: 0x0
// Checksum 0xb2c50306, Offset: 0x2e8
// Size: 0xec
function function_79b13f76(attacker) {
    /#
        if (abs(level.mapcenter[2] + self.origin[2]) > 100000) {
            return;
        }
    #/
    numdogtags = 1;
    for (index = 0; index < numdogtags; index++) {
        posoffset = (randomintrange(-20, 20), randomintrange(-20, 20), 0) * index;
        level thread dogtags::spawn_dog_tag(self, attacker, &onuse, 0, posoffset);
    }
}

// Namespace namespace_f2e23b4a/namespace_f2e23b4a
// Params 9, eflags: 0x0
// Checksum 0x2162a0bd, Offset: 0x3e0
// Size: 0xfc
function onplayerkilled(*einflictor, attacker, *idamage, *smeansofdeath, weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration) {
    if (!isplayer(psoffsettime) || psoffsettime.team == self.team) {
        return;
    }
    if (!isdefined(killstreaks::get_killstreak_for_weapon(deathanimduration)) || is_true(level.killstreaksgivegamescore)) {
        psoffsettime globallogic_score::giveteamscoreforobjective(psoffsettime.team, level.teamscoreperkill);
    }
    function_79b13f76(psoffsettime);
}

// Namespace namespace_f2e23b4a/namespace_f2e23b4a
// Params 1, eflags: 0x0
// Checksum 0xe10b2efe, Offset: 0x4e8
// Size: 0x302
function onuse(player) {
    tacinsertboost = 0;
    var_5f50a7ed = 0;
    player.pers[#"objectives"]++;
    player.objectives = player.pers[#"objectives"];
    if (!util::function_fbce7263(player.team, self.victimteam)) {
        tacinsertboost = self.tacinsert;
        if (isdefined(self.attacker) && !util::function_fbce7263(self.attacker.team, self.attackerteam)) {
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
    if (isdefined(self.attacker) && util::function_fbce7263(self.attacker.team, player.team)) {
        self.attacker luinotifyevent(#"player_callout", 2, #"hash_75462478f6a06755", player.entnum);
    }
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

// Namespace namespace_f2e23b4a/namespace_f2e23b4a
// Params 0, eflags: 0x0
// Checksum 0x6c04bce4, Offset: 0x7f8
// Size: 0x62
function on_player_spawned() {
    self.usingobj = undefined;
    if (spawning::usestartspawns() && !level.ingraceperiod) {
        spawning::function_7a87efaa();
    }
    self.lastkillconfirmedtime = 0;
    self.lastkillconfirmedcount = 0;
}

