#using scripts\abilities\ability_power;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\util_shared;

#namespace scoreevents;

// Namespace scoreevents/scoreevents_shared
// Params 4, eflags: 0x0
// Checksum 0xadfdd00c, Offset: 0x100
// Size: 0xb8
function function_2c6f1417(event, players, victim, weapon) {
    if (!isdefined(players)) {
        return;
    }
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        processscoreevent(event, player, victim, weapon);
    }
}

// Namespace scoreevents/scoreevents_shared
// Params 5, eflags: 0x0
// Checksum 0xe9f2faef, Offset: 0x1c0
// Size: 0x75c
function processscoreevent(event, player, victim, weapon, var_2547ae45) {
    scoregiven = 0;
    if (sessionmodeiswarzonegame()) {
        return scoregiven;
    }
    if (isdefined(level.scoreinfo[event]) && isdefined(level.scoreinfo[event][#"is_deprecated"]) && level.scoreinfo[event][#"is_deprecated"]) {
        return scoregiven;
    }
    if (isdefined(level.disablescoreevents) && level.disablescoreevents) {
        return scoregiven;
    }
    if (!isplayer(player)) {
        return scoregiven;
    }
    pixbeginevent(#"processscoreevent");
    isscoreevent = 0;
    /#
        if (getdvarint(#"logscoreevents", 0) > 0) {
            if (!isdefined(level.var_ce007bc4)) {
                level.var_ce007bc4 = [];
            }
            eventstr = ishash(event) ? function_15979fa9(event) : event;
            if (!isdefined(level.var_ce007bc4)) {
                level.var_ce007bc4 = [];
            } else if (!isarray(level.var_ce007bc4)) {
                level.var_ce007bc4 = array(level.var_ce007bc4);
            }
            level.var_ce007bc4[level.var_ce007bc4.size] = eventstr;
        }
    #/
    if (isdefined(level.challengesoneventreceived)) {
        player thread [[ level.challengesoneventreceived ]](event);
    }
    if (isdefined(level.var_a9a13a28)) {
        profilestart();
        params = {};
        params.event = event;
        params.victim = victim;
        player [[ level.var_a9a13a28 ]](params);
        profilestop();
    }
    if (isregisteredevent(event) && (!sessionmodeiszombiesgame() || level.onlinegame)) {
        if (isdefined(level.scoreongiveplayerscore)) {
            scoregiven = [[ level.scoreongiveplayerscore ]](event, player, victim, undefined, weapon, var_2547ae45);
            var_3b9e9b13 = player rank::function_cb58556(event);
            isscoreevent = scoregiven > 0 || var_3b9e9b13 > 0;
            if (isscoreevent) {
                player ability_power::power_gain_event_score(event, victim, scoregiven, weapon);
            }
            if (isdefined(level.var_a79368c1) && var_3b9e9b13 > 0) {
                player thread [[ level.var_a79368c1 ]](var_3b9e9b13);
            }
        }
    }
    if (shouldaddrankxp(player) && (!isdefined(victim) || !(isdefined(victim.disable_score_events) && victim.disable_score_events))) {
        pickedup = 0;
        if (isdefined(weapon) && isdefined(player.pickedupweapons) && isdefined(player.pickedupweapons[weapon])) {
            pickedup = 1;
        }
        xp_difficulty_multiplier = 1;
        if (isdefined(level.var_b5bdb0b1)) {
            xp_difficulty_multiplier = [[ level.var_b5bdb0b1 ]]();
        }
        player addrankxp(event, weapon, player.class_num, pickedup, isscoreevent, xp_difficulty_multiplier);
        if (isdefined(event) && isdefined(weapon) && isdefined(level.scoreinfo[event])) {
            if (isdefined(level.scoreinfo[event][#"medalnamehash"])) {
                specialistindex = player getspecialistindex();
                medalname = function_a0abf104(specialistindex, currentsessionmode(), 0);
                if (isdefined(medalname) && hash(medalname) == level.scoreinfo[event][#"medalnamehash"]) {
                    player.ability_medal_count = (isdefined(player.ability_medal_count) ? player.ability_medal_count : 0) + 1;
                    player.pers["ability_medal_count" + specialistindex] = player.ability_medal_count;
                }
                medalname = function_a0abf104(specialistindex, currentsessionmode(), 1);
                if (isdefined(medalname) && hash(medalname) == level.scoreinfo[event][#"medalnamehash"]) {
                    player.equipment_medal_count = (isdefined(player.equipment_medal_count) ? player.equipment_medal_count : 0) + 1;
                    player.pers["equipment_medal_count" + specialistindex] = player.equipment_medal_count;
                }
            }
        }
    }
    pixendevent();
    if (sessionmodeiscampaigngame() && isdefined(xp_difficulty_multiplier)) {
        if (isdefined(victim) && isdefined(victim.team)) {
            if (victim.team == #"axis" || victim.team == #"team3") {
                scoregiven *= xp_difficulty_multiplier;
            }
        }
    }
    return scoregiven;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0xcf6e2b67, Offset: 0x928
// Size: 0x132
function shouldaddrankxp(player) {
    if (level.gametype == "fr") {
        return false;
    }
    if (isdefined(level.var_c9225931) && level.var_c9225931) {
        /#
            playername = "<dev string:x30>";
            if (isdefined(player) && isdefined(player.name)) {
                playername = player.name;
            }
            println("<dev string:x38>" + playername);
        #/
        return false;
    }
    if (!isdefined(level.rankcap) || level.rankcap == 0) {
        return true;
    }
    if (player.pers[#"plevel"] > 0 || player.pers[#"rank"] > level.rankcap) {
        return false;
    }
    return true;
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0xa4f7a4a6, Offset: 0xa68
// Size: 0x74
function uninterruptedobitfeedkills(attacker, weapon) {
    self endon(#"disconnect");
    wait 0.1;
    util::waittillslowprocessallowed();
    wait 0.1;
    processscoreevent(#"uninterrupted_obit_feed_kills", attacker, self, weapon);
}

// Namespace scoreevents/scoreevents_shared
// Params 5, eflags: 0x0
// Checksum 0x3f81057a, Offset: 0xae8
// Size: 0x64
function function_4b1ed963(waitduration, event, player, victim, weapon) {
    self endon(#"disconnect");
    wait waitduration;
    processscoreevent(event, player, victim, weapon);
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x5fc24534, Offset: 0xb58
// Size: 0x30
function isregisteredevent(type) {
    if (isdefined(level.scoreinfo[type])) {
        return 1;
    }
    return 0;
}

// Namespace scoreevents/scoreevents_shared
// Params 0, eflags: 0x0
// Checksum 0xd72d90b7, Offset: 0xb90
// Size: 0x4c
function decrementlastobituaryplayercountafterfade() {
    level endon(#"reset_obituary_count");
    wait 5;
    level.lastobituaryplayercount--;
    assert(level.lastobituaryplayercount >= 0);
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x7ed9611b, Offset: 0xbe8
// Size: 0x104
function getscoreeventtablename(gametype = "base") {
    prefix = #"gamedata/tables/mp/scoreinfo/mp_scoreinfo";
    if (sessionmodeiscampaigngame()) {
        prefix = #"gamedata/tables/cp/scoreinfo/cp_scoreinfo";
    } else if (sessionmodeiszombiesgame()) {
        prefix = #"gamedata/tables/zm/scoreinfo/zm_scoreinfo";
    }
    tablename = prefix + "_" + gametype + ".csv";
    if (!(isdefined(isassetloaded("stringtable", tablename)) && isassetloaded("stringtable", tablename))) {
        tablename = prefix + "_base.csv";
    }
    return tablename;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0xd7d63668, Offset: 0xcf8
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
    assert(scoreinfotableloaded, "<dev string:x64>" + function_15979fa9(getscoreeventtablename()));
    return scoreinfotableid;
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0xef9fedf7, Offset: 0xde8
// Size: 0x1ec
function givecratecapturemedal(crate, capturer) {
    if (isdefined(crate.owner) && isplayer(crate.owner)) {
        if (level.teambased) {
            if (capturer.team != crate.owner.team) {
                crate.owner playlocalsound(#"mpl_crate_enemy_steals");
                if (!isdefined(crate.hacker)) {
                    processscoreevent(#"capture_enemy_crate", capturer, undefined, undefined);
                }
            } else if (isdefined(crate.owner) && capturer != crate.owner) {
                crate.owner playlocalsound(#"mpl_crate_friendly_steals");
                if (!isdefined(crate.hacker)) {
                    level.globalsharepackages++;
                    processscoreevent(#"share_care_package", crate.owner, undefined, undefined);
                }
            }
            return;
        }
        if (capturer != crate.owner) {
            crate.owner playlocalsound(#"mpl_crate_enemy_steals");
            if (!isdefined(crate.hacker)) {
                processscoreevent(#"capture_enemy_crate", capturer, undefined, undefined);
            }
        }
    }
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0xe7d36e73, Offset: 0xfe0
// Size: 0x46
function register_hero_ability_kill_event(event_func) {
    if (!isdefined(level.hero_ability_kill_events)) {
        level.hero_ability_kill_events = [];
    }
    level.hero_ability_kill_events[level.hero_ability_kill_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0xd99ff9b5, Offset: 0x1030
// Size: 0x46
function register_hero_ability_multikill_event(event_func) {
    if (!isdefined(level.hero_ability_multikill_events)) {
        level.hero_ability_multikill_events = [];
    }
    level.hero_ability_multikill_events[level.hero_ability_multikill_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0xf01a15f0, Offset: 0x1080
// Size: 0x46
function register_hero_weapon_multikill_event(event_func) {
    if (!isdefined(level.hero_weapon_multikill_events)) {
        level.hero_weapon_multikill_events = [];
    }
    level.hero_weapon_multikill_events[level.hero_weapon_multikill_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0xf4bae32a, Offset: 0x10d0
// Size: 0x46
function register_thief_shutdown_enemy_event(event_func) {
    if (!isdefined(level.thief_shutdown_enemy_events)) {
        level.thief_shutdown_enemy_events = [];
    }
    level.thief_shutdown_enemy_events[level.thief_shutdown_enemy_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0x3c1565b9, Offset: 0x1120
// Size: 0xa4
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
// Checksum 0x5ce59d0f, Offset: 0x11d0
// Size: 0xa4
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
// Checksum 0xc8a93292, Offset: 0x1280
// Size: 0xa4
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
// Checksum 0x86179300, Offset: 0x1330
// Size: 0x8e
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

// Namespace scoreevents/scoreevents_shared
// Params 0, eflags: 0x0
// Checksum 0x65c9b231, Offset: 0x13c8
// Size: 0x34
function function_546914f() {
    self callback::add_callback(#"fully_healed", &player_fully_healed);
}

// Namespace scoreevents/scoreevents_shared
// Params 0, eflags: 0x0
// Checksum 0x492b8d9d, Offset: 0x1408
// Size: 0xe
function player_fully_healed() {
    self.var_8ecca966 = undefined;
}

// Namespace scoreevents/scoreevents_shared
// Params 0, eflags: 0x0
// Checksum 0xa9ad8167, Offset: 0x1420
// Size: 0x10
function player_spawned() {
    profilestart();
    self.var_8ecca966 = undefined;
    profilestop();
}

// Namespace scoreevents/scoreevents_shared
// Params 3, eflags: 0x0
// Checksum 0xc0180a15, Offset: 0x1438
// Size: 0xc4
function function_fc0510f4(attacker, vehicle, weapon) {
    if (!isdefined(weapon)) {
        return;
    }
    switch (weapon.statname) {
    case #"ultimate_turret":
        event = "automated_turret_vehicle_destruction";
        break;
    default:
        return;
    }
    victim = isdefined(vehicle) ? vehicle.owner : undefined;
    processscoreevent(event, attacker, victim, weapon);
}

