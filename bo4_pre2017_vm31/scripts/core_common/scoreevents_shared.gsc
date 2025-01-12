#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/gameskill_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace scoreevents;

// Namespace scoreevents/scoreevents_shared
// Params 4, eflags: 0x0
// Checksum 0xadf40ded, Offset: 0x2e8
// Size: 0x378
function processscoreevent(event, player, victim, weapon) {
    pixbeginevent("processScoreEvent");
    scoregiven = 0;
    if (!isplayer(player)) {
        assertmsg("<dev string:x28>" + event);
        return scoregiven;
    }
    isscoreevent = 0;
    if (isdefined(level.challengesoneventreceived)) {
        player thread [[ level.challengesoneventreceived ]](event);
    }
    if (!sessionmodeiszombiesgame() || isregisteredevent(event) && level.onlinegame) {
        if (isdefined(level.scoreongiveplayerscore)) {
            scoregiven = [[ level.scoreongiveplayerscore ]](event, player, victim, undefined, weapon);
            isscoreevent = scoregiven > 0;
            if (isscoreevent) {
                player ability_power::power_gain_event_score(event, victim, scoregiven, weapon);
            }
            if (isdefined(level.var_8da5706a) && function_5b01418c(player)) {
                [[ level.var_8da5706a ]](event, player, victim, weapon);
            }
        }
    }
    if (shouldaddrankxp(player) && isdefined(victim) && !(isdefined(victim.disable_score_events) && victim.disable_score_events)) {
        pickedup = 0;
        if (isdefined(weapon) && isdefined(player.pickedupweapons) && isdefined(player.pickedupweapons[weapon])) {
            pickedup = 1;
        }
        if (sessionmodeiscampaigngame()) {
            xp_difficulty_multiplier = player gameskill::function_684ec97e();
        } else {
            xp_difficulty_multiplier = 1;
        }
        player addrankxp(event, weapon, player.class_num, pickedup, isscoreevent, xp_difficulty_multiplier);
    }
    pixendevent();
    if (sessionmodeiscampaigngame() && isdefined(xp_difficulty_multiplier)) {
        if (isdefined(victim) && isdefined(victim.team)) {
            if (victim.team == "axis" || victim.team == "team3") {
                scoregiven *= xp_difficulty_multiplier;
            }
        }
    }
    return scoregiven;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x8082c35a, Offset: 0x668
// Size: 0x9c
function shouldaddrankxp(player) {
    if (level.gametype == "fr") {
        return false;
    }
    if (!isdefined(level.rankcap) || level.rankcap == 0) {
        return true;
    }
    if (player.pers["plevel"] > 0 || player.pers["rank"] > level.rankcap) {
        return false;
    }
    return true;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x45529a0b, Offset: 0x710
// Size: 0x44
function function_5b01418c(player) {
    if (player.pers["lpSystem"].lplevel >= level.var_d6d75559) {
        return false;
    }
    return true;
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0x13bbd671, Offset: 0x760
// Size: 0x64
function uninterruptedobitfeedkills(attacker, weapon) {
    self endon(#"disconnect");
    wait 0.1;
    util::waittillslowprocessallowed();
    wait 0.1;
    processscoreevent("uninterrupted_obit_feed_kills", attacker, self, weapon);
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0xe1782174, Offset: 0x7d0
// Size: 0x30
function isregisteredevent(type) {
    if (isdefined(level.scoreinfo[type])) {
        return 1;
    }
    return 0;
}

// Namespace scoreevents/scoreevents_shared
// Params 0, eflags: 0x0
// Checksum 0x51538c80, Offset: 0x808
// Size: 0x4c
function decrementlastobituaryplayercountafterfade() {
    level endon(#"reset_obituary_count");
    wait 5;
    level.lastobituaryplayercount--;
    assert(level.lastobituaryplayercount >= 0);
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0xd855281, Offset: 0x860
// Size: 0x106
function getscoreeventtablename(gametype) {
    if (!isdefined(gametype)) {
        gametype = "base";
    }
    prefix = "gamedata/tables/mp/scoreinfo/mp_scoreinfo";
    if (sessionmodeiscampaigngame()) {
        prefix = "gamedata/tables/cp/scoreinfo/cp_scoreinfo";
    } else if (sessionmodeiszombiesgame()) {
        prefix = "gamedata/tables/zm/scoreinfo/zm_scoreinfo";
    }
    tablename = prefix + "_" + gametype + ".csv";
    if (!(isdefined(isassetloaded("stringtable", tablename)) && isassetloaded("stringtable", tablename))) {
        tablename = prefix + "_base.csv";
    }
    return tablename;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0xad6db616, Offset: 0x970
// Size: 0xe8
function getscoreeventtableid(gametype) {
    scoreinfotableloaded = 0;
    tablename = getscoreeventtablename(gametype);
    scoreinfotableid = tablelookupfindcoreasset(tablename);
    if (!isdefined(scoreinfotableid)) {
        tablelookupfindcoreasset(getscoreeventtablename("base"));
    }
    if (isdefined(scoreinfotableid)) {
        scoreinfotableloaded = 1;
    }
    assert(scoreinfotableloaded, "<dev string:x58>" + getscoreeventtablename());
    return scoreinfotableid;
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0xef4f16eb, Offset: 0xa60
// Size: 0x1e4
function givecratecapturemedal(crate, capturer) {
    if (isdefined(crate.owner) && isplayer(crate.owner)) {
        if (level.teambased) {
            if (capturer.team != crate.owner.team) {
                crate.owner playlocalsound("mpl_crate_enemy_steals");
                if (!isdefined(crate.hacker)) {
                    processscoreevent("capture_enemy_crate", capturer);
                }
            } else if (isdefined(crate.owner) && capturer != crate.owner) {
                crate.owner playlocalsound("mpl_crate_friendly_steals");
                if (!isdefined(crate.hacker)) {
                    level.globalsharepackages++;
                    processscoreevent("share_care_package", crate.owner);
                }
            }
            return;
        }
        if (capturer != crate.owner) {
            crate.owner playlocalsound("mpl_crate_enemy_steals");
            if (!isdefined(crate.hacker)) {
                processscoreevent("capture_enemy_crate", capturer);
            }
        }
    }
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x61aecae2, Offset: 0xc50
// Size: 0x4a
function register_hero_ability_kill_event(event_func) {
    if (!isdefined(level.hero_ability_kill_events)) {
        level.hero_ability_kill_events = [];
    }
    level.hero_ability_kill_events[level.hero_ability_kill_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x181b8d58, Offset: 0xca8
// Size: 0x4a
function register_hero_ability_multikill_event(event_func) {
    if (!isdefined(level.hero_ability_multikill_events)) {
        level.hero_ability_multikill_events = [];
    }
    level.hero_ability_multikill_events[level.hero_ability_multikill_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x53c7c90f, Offset: 0xd00
// Size: 0x4a
function register_hero_weapon_multikill_event(event_func) {
    if (!isdefined(level.hero_weapon_multikill_events)) {
        level.hero_weapon_multikill_events = [];
    }
    level.hero_weapon_multikill_events[level.hero_weapon_multikill_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x9221c7c8, Offset: 0xd58
// Size: 0x4a
function register_thief_shutdown_enemy_event(event_func) {
    if (!isdefined(level.thief_shutdown_enemy_events)) {
        level.thief_shutdown_enemy_events = [];
    }
    level.thief_shutdown_enemy_events[level.thief_shutdown_enemy_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0xbcdedfc1, Offset: 0xdb0
// Size: 0xbc
function hero_ability_kill_event(ability, victim_ability) {
    if (!isdefined(level.hero_ability_kill_events)) {
        return;
    }
    foreach (event_func in level.hero_ability_kill_events) {
        if (isdefined(event_func)) {
            self [[ event_func ]](ability, victim_ability);
        }
    }
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0xf7e377c, Offset: 0xe78
// Size: 0xbc
function hero_ability_multikill_event(killcount, ability) {
    if (!isdefined(level.hero_ability_multikill_events)) {
        return;
    }
    foreach (event_func in level.hero_ability_multikill_events) {
        if (isdefined(event_func)) {
            self [[ event_func ]](killcount, ability);
        }
    }
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0x1e4f6b93, Offset: 0xf40
// Size: 0xbc
function hero_weapon_multikill_event(killcount, weapon) {
    if (!isdefined(level.hero_weapon_multikill_events)) {
        return;
    }
    foreach (event_func in level.hero_weapon_multikill_events) {
        if (isdefined(event_func)) {
            self [[ event_func ]](killcount, weapon);
        }
    }
}

// Namespace scoreevents/scoreevents_shared
// Params 0, eflags: 0x0
// Checksum 0xeadfa4e4, Offset: 0x1008
// Size: 0xa4
function thief_shutdown_enemy_event() {
    if (!isdefined(level.thief_shutdown_enemy_event)) {
        return;
    }
    foreach (event_func in level.thief_shutdown_enemy_event) {
        if (isdefined(event_func)) {
            self [[ event_func ]]();
        }
    }
}

