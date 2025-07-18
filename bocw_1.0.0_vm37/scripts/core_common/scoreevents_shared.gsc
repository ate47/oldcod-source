#using scripts\abilities\ability_power;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\util_shared;

#namespace scoreevents;

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0xb6462f63, Offset: 0x160
// Size: 0xf2
function registerscoreeventcallback(callback, func) {
    if (!isdefined(level.scoreeventcallbacks)) {
        level.scoreeventcallbacks = [];
    }
    if (!isdefined(level.scoreeventcallbacks[callback])) {
        level.scoreeventcallbacks[callback] = [];
    }
    if (!isdefined(level.scoreeventcallbacks[callback])) {
        level.scoreeventcallbacks[callback] = [];
    } else if (!isarray(level.scoreeventcallbacks[callback])) {
        level.scoreeventcallbacks[callback] = array(level.scoreeventcallbacks[callback]);
    }
    level.scoreeventcallbacks[callback][level.scoreeventcallbacks[callback].size] = func;
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0xf040ac50, Offset: 0x260
// Size: 0xf2
function function_9677601b(callback, func) {
    if (!isdefined(level.var_8c00e05d)) {
        level.var_8c00e05d = [];
    }
    if (!isdefined(level.var_8c00e05d[callback])) {
        level.var_8c00e05d[callback] = [];
    }
    if (!isdefined(level.var_8c00e05d[callback])) {
        level.var_8c00e05d[callback] = [];
    } else if (!isarray(level.var_8c00e05d[callback])) {
        level.var_8c00e05d[callback] = array(level.var_8c00e05d[callback]);
    }
    level.var_8c00e05d[callback][level.var_8c00e05d[callback].size] = func;
}

// Namespace scoreevents/scoreevents_shared
// Params 4, eflags: 0x0
// Checksum 0xafeb718e, Offset: 0x360
// Size: 0xc0
function function_6f51d1e9(event, players, victim, weapon) {
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
// Params 7, eflags: 0x0
// Checksum 0x536f5503, Offset: 0x428
// Size: 0x638
function processscoreevent(event, player, victim, weapon, var_36f23f1f, var_dbaa74e2, var_28e349dc) {
    scoregiven = 0;
    if (is_true(victim.disablescoreevents)) {
        return scoregiven;
    }
    if (isdefined(level.scoreinfo[event]) && is_true(level.scoreinfo[event][#"is_deprecated"])) {
        return scoregiven;
    }
    if (is_true(level.disablescoreevents)) {
        return scoregiven;
    }
    if (!isplayer(player)) {
        return scoregiven;
    }
    pixbeginevent(#"");
    isscoreevent = 0;
    /#
        if (getdvarint(#"logscoreevents", 0) > 0) {
            if (!isdefined(level.var_10cd7193)) {
                level.var_10cd7193 = [];
            }
            eventstr = ishash(event) ? function_9e72a96(event) : event;
            if (!isdefined(level.var_10cd7193)) {
                level.var_10cd7193 = [];
            } else if (!isarray(level.var_10cd7193)) {
                level.var_10cd7193 = array(level.var_10cd7193);
            }
            level.var_10cd7193[level.var_10cd7193.size] = eventstr;
        }
    #/
    if (isdefined(level.challengesoneventreceived)) {
        player thread [[ level.challengesoneventreceived ]](event);
    }
    if (isdefined(level.var_6c0f31f5)) {
        profilestart();
        params = {};
        params.event = event;
        params.victim = victim;
        player [[ level.var_6c0f31f5 ]](params);
        profilestop();
    }
    if (isregisteredevent(event)) {
        if (isdefined(level.scoreongiveplayerscore) && !is_true(var_28e349dc)) {
            scoregiven = [[ level.scoreongiveplayerscore ]](event, player, victim, undefined, weapon, var_36f23f1f, var_dbaa74e2);
            if (scoregiven > 0) {
                player ability_power::power_gain_event_score(event, victim, scoregiven, weapon);
            }
        }
    }
    if (shouldaddrankxp(player) && (!isdefined(victim) || !is_true(victim.disable_score_events))) {
        pickedup = 0;
        if (isdefined(weapon) && isdefined(player.pickedupweapons) && isdefined(player.pickedupweapons[weapon])) {
            pickedup = 1;
        }
        xp_difficulty_multiplier = 1;
        if (isdefined(level.var_3426461d)) {
            xp_difficulty_multiplier = [[ level.var_3426461d ]]();
        }
        player addrankxp(event, weapon, player.class_num, pickedup, isscoreevent, xp_difficulty_multiplier);
        if (isdefined(event) && isdefined(weapon) && isdefined(level.scoreinfo[event])) {
            var_6d1793bb = level.scoreinfo[event][#"medalnamehash"];
            if (isdefined(var_6d1793bb)) {
                specialistindex = player getspecialistindex();
                medalname = function_dcad256c(specialistindex, currentsessionmode(), 0);
                if (medalname == var_6d1793bb) {
                    player.pers["ability_medal_count" + specialistindex] = (isdefined(player.pers["ability_medal_count" + specialistindex]) ? player.pers["ability_medal_count" + specialistindex] : 0) + 1;
                }
                medalname = function_dcad256c(specialistindex, currentsessionmode(), 1);
                if (medalname == var_6d1793bb) {
                    player.pers["equipment_medal_count" + specialistindex] = (isdefined(player.pers["equipment_medal_count" + specialistindex]) ? player.pers["equipment_medal_count" + specialistindex] : 0) + 1;
                }
            }
        }
    }
    profilestop();
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
// Params 2, eflags: 0x0
// Checksum 0x1be8901, Offset: 0xa68
// Size: 0x44
function doscoreeventcallback(callback, data) {
    function_e4171c51(callback, data);
    function_32358e67(callback, data);
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x4
// Checksum 0x37930cc2, Offset: 0xab8
// Size: 0x70
function private function_e4171c51(callback, data) {
    if (!isdefined(level.scoreeventcallbacks[callback])) {
        return;
    }
    for (i = 0; i < level.scoreeventcallbacks[callback].size; i++) {
        thread [[ level.scoreeventcallbacks[callback][i] ]](data);
    }
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x4
// Checksum 0x67634137, Offset: 0xb30
// Size: 0x70
function private function_32358e67(callback, data) {
    if (!isdefined(level.var_8c00e05d[callback])) {
        return;
    }
    for (i = 0; i < level.var_8c00e05d[callback].size; i++) {
        thread [[ level.var_8c00e05d[callback][i] ]](data);
    }
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0xf33cfe71, Offset: 0xba8
// Size: 0x15e
function shouldaddrankxp(player) {
    if (level.gametype == "fr") {
        return false;
    }
    if (level.gametype == "zclassic" && is_true(level.var_5164a0ca)) {
        return false;
    }
    if (is_true(level.var_4f654f3a)) {
        /#
            playername = "<dev string:x38>";
            if (isdefined(player) && isdefined(player.name)) {
                playername = player.name;
            }
            println("<dev string:x43>" + playername);
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
// Checksum 0x2ea63f8d, Offset: 0xd10
// Size: 0x9c
function uninterruptedobitfeedkills(attacker, weapon) {
    self endon(#"disconnect");
    wait 0.1;
    util::waittillslowprocessallowed();
    wait 0.1;
    if (isdefined(attacker)) {
        processscoreevent(#"uninterrupted_obit_feed_kills", attacker, self, weapon);
        attacker contracts::increment_contract(#"contract_mp_quad_feed");
    }
}

// Namespace scoreevents/scoreevents_shared
// Params 5, eflags: 0x0
// Checksum 0xaae8ea75, Offset: 0xdb8
// Size: 0x64
function function_c046c773(waitduration, event, player, victim, weapon) {
    self endon(#"disconnect");
    wait waitduration;
    processscoreevent(event, player, victim, weapon);
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x6377ccae, Offset: 0xe28
// Size: 0x30
function isregisteredevent(type) {
    if (isdefined(level.scoreinfo[type])) {
        return 1;
    }
    return 0;
}

// Namespace scoreevents/scoreevents_shared
// Params 0, eflags: 0x0
// Checksum 0xb9ac76c4, Offset: 0xe60
// Size: 0x4c
function decrementlastobituaryplayercountafterfade() {
    level endon(#"reset_obituary_count");
    wait 5;
    level.lastobituaryplayercount--;
    assert(level.lastobituaryplayercount >= 0);
}

// Namespace scoreevents/scoreevents_shared
// Params 0, eflags: 0x0
// Checksum 0x48740e08, Offset: 0xeb8
// Size: 0x122
function function_2b96d7dc() {
    if (!isdefined(level.var_d1455682)) {
        return undefined;
    }
    table_name = function_6a9e36d6();
    if (!isdefined(table_name)) {
        return undefined;
    }
    args = strtok(table_name, "\");
    if (args.size) {
        table_name = "";
        foreach (index, arg in args) {
            table_name += arg;
            if (index < args.size - 1) {
                table_name += "/";
            }
        }
    }
    return hash(table_name);
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x783daf48, Offset: 0xfe8
// Size: 0x228
function getscoreeventtablename(gametype) {
    table_name = function_2b96d7dc();
    if (isdefined(table_name) && is_true(isassetloaded("stringtable", table_name))) {
        return table_name;
    }
    if (!isdefined(gametype)) {
        gametype = "base";
    }
    prefix = #"gamedata/tables/mp/scoreinfo/mp_scoreinfo";
    if (sessionmodeiscampaigngame()) {
        prefix = #"gamedata/tables/cp/scoreinfo/cp_scoreinfo";
    } else if (sessionmodeiszombiesgame()) {
        prefix = #"gamedata/tables/zm/scoreinfo/zm_scoreinfo";
    } else if (sessionmodeiswarzonegame()) {
        prefix = #"gamedata/tables/wz/scoreinfo/wz_scoreinfo";
    }
    gametype = strreplace(gametype, "_hc", "");
    gametype = strreplace(gametype, "_cdl", "");
    gametype = strreplace(gametype, "_bb", "");
    tablename = prefix + "_" + gametype + ".csv";
    if (!is_true(isassetloaded("stringtable", tablename))) {
        tablename = prefix + "_base.csv";
    }
    if (is_true(isassetloaded("stringtable", tablename))) {
        return tablename;
    }
    return tablename;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x2268c381, Offset: 0x1218
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
    assert(scoreinfotableloaded, "<dev string:x72>" + function_9e72a96(getscoreeventtablename()));
    return scoreinfotableid;
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0xf6b62240, Offset: 0x1308
// Size: 0x1dc
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
// Checksum 0x597c9ff6, Offset: 0x14f0
// Size: 0x44
function register_hero_ability_kill_event(event_func) {
    if (!isdefined(level.hero_ability_kill_events)) {
        level.hero_ability_kill_events = [];
    }
    level.hero_ability_kill_events[level.hero_ability_kill_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x419436d2, Offset: 0x1540
// Size: 0x44
function register_hero_ability_multikill_event(event_func) {
    if (!isdefined(level.hero_ability_multikill_events)) {
        level.hero_ability_multikill_events = [];
    }
    level.hero_ability_multikill_events[level.hero_ability_multikill_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0x1f1bb3a9, Offset: 0x1590
// Size: 0x44
function register_hero_weapon_multikill_event(event_func) {
    if (!isdefined(level.hero_weapon_multikill_events)) {
        level.hero_weapon_multikill_events = [];
    }
    level.hero_weapon_multikill_events[level.hero_weapon_multikill_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 1, eflags: 0x0
// Checksum 0xcda900f2, Offset: 0x15e0
// Size: 0x44
function register_thief_shutdown_enemy_event(event_func) {
    if (!isdefined(level.thief_shutdown_enemy_events)) {
        level.thief_shutdown_enemy_events = [];
    }
    level.thief_shutdown_enemy_events[level.thief_shutdown_enemy_events.size] = event_func;
}

// Namespace scoreevents/scoreevents_shared
// Params 2, eflags: 0x0
// Checksum 0x65225d5e, Offset: 0x1630
// Size: 0xb2
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
// Checksum 0xe8b3ebd0, Offset: 0x16f0
// Size: 0xb2
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
// Checksum 0x348e644a, Offset: 0x17b0
// Size: 0xb2
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
// Checksum 0xf2b56b3d, Offset: 0x1870
// Size: 0x9c
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
// Checksum 0xdd2d8d8, Offset: 0x1918
// Size: 0x34
function function_dcdf1105() {
    self callback::add_callback(#"fully_healed", &player_fully_healed);
}

// Namespace scoreevents/scoreevents_shared
// Params 0, eflags: 0x0
// Checksum 0x86a71af, Offset: 0x1958
// Size: 0xe
function player_fully_healed() {
    self.var_ae639436 = undefined;
}

// Namespace scoreevents/scoreevents_shared
// Params 0, eflags: 0x0
// Checksum 0xf1555f31, Offset: 0x1970
// Size: 0x10
function player_spawned() {
    profilestart();
    self.var_ae639436 = undefined;
    profilestop();
}

// Namespace scoreevents/scoreevents_shared
// Params 3, eflags: 0x0
// Checksum 0x3618bc4c, Offset: 0x1988
// Size: 0xbc
function function_f40d64cc(attacker, vehicle, weapon) {
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

