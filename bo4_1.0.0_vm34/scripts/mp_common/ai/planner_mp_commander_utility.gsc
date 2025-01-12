#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_squad;
#using scripts\core_common\ai\region_utility;
#using scripts\core_common\ai\strategic_command;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\planner;
#using scripts\core_common\ai\systems\planner_blackboard;
#using scripts\core_common\bots\bot;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace planner_mp_commander_utility;

// Namespace planner_mp_commander_utility/planner_mp_commander_utility
// Params 0, eflags: 0x2
// Checksum 0xee3caa46, Offset: 0x2c8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"planner_mp_commander_utility", &namespace_12aca6a::__init__, undefined, undefined);
}

#namespace namespace_12aca6a;

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 0, eflags: 0x4
// Checksum 0x5fc7f41c, Offset: 0x310
// Size: 0x70c
function private __init__() {
    plannercommanderutility::registerdaemonapi("daemonControlZones", &function_48a74de8);
    plannercommanderutility::registerdaemonapi("daemonDomFlags", &function_b167c605);
    plannercommanderutility::registerdaemonapi("daemonKothZone", &function_165f9e6e);
    plannercommanderutility::registerdaemonapi("daemonSdBomb", &function_2ffcdb7);
    plannercommanderutility::registerdaemonapi("daemonSdBombZones", &function_dc2762cc);
    plannercommanderutility::registerdaemonapi("daemonSdDefuseObj", &function_c8ab1900);
    plannercommanderutility::registerutilityapi("commanderScoreAge", &function_262087c);
    plannercommanderutility::registerutilityapi("commanderScoreAlive", &function_40859aba);
    plannercommanderutility::registerutilityapi("commanderScoreControlZones", &function_794f6ce8);
    plannercommanderutility::registerutilityapi("commanderScoreDomFlags", &function_321429de);
    plannercommanderutility::registerutilityapi("commanderScoreKothZone", &function_992ce3bb);
    plannerutility::registerplannerapi(#"hash_6130077bb861d4fa", &function_f3286a1f);
    plannerutility::registerplannerapi(#"hash_23ede7441ff7e15f", &function_3352782);
    plannerutility::registerplannerapi(#"hash_9d5448e604895e", &function_fdfa6bf5);
    plannerutility::registerplannerapi(#"hash_58f852e4b26d4080", &function_d0a81d9d);
    plannerutility::registerplannerapi(#"hash_6c55a3eed50ed047", &function_8f11b970);
    plannerutility::registerplannerapi(#"hash_654106abca773945", &function_1d192562);
    plannerutility::registerplannerapi(#"hash_783f83ce7a2dc41b", &function_515c1d6a);
    plannerutility::registerplannerapi(#"hash_19dd182b96412bae", &function_31241e1);
    plannerutility::registerplannerapi(#"hash_72014ae7e091d06f", &function_e663718);
    plannerutility::registerplanneraction(#"hash_5c39c15c20a4b033", &function_6b914631, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_5ad6d3a6bb956fb1", &function_f645a4cb, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_6a957e932b7f93aa", &function_d9a44ede, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_746e217e5d63efc2", &function_a9c18a78, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_303c3d6d6bfcc25b", &function_c668efcb, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_4a587832fd66b314", &function_96f0d920, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_4d82b95b9c45bb53", &function_ba87f63d, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_494fab5e2093d5b", &function_99ae07bf, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_506b5e12327f16f4", &function_a93436e2, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_67ba42774c6db6a6", &function_6facc980, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_6b51afb697e53d12", &function_7590d990, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_4c584e62f0069dfa", &function_cd9327cc, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_3eb5ac2692fce4e7", &function_7d130e9f, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_60a8773a51426c27", &function_870b3d1a, undefined, undefined, undefined);
    plannerutility::registerplannerapi(#"hash_3df2466d38b695da", &function_bceb1935);
    plannerutility::registerplannerapi(#"hash_2d8246b9d8badd2e", &function_17e02ed5);
    plannerutility::registerplannerapi(#"hash_10cfd447c35656ef", &function_99d2231a);
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x91475ead, Offset: 0xa28
// Size: 0x174
function private _calculatepositionquerypath(queryresult, position, entity) {
    path = undefined;
    longestpath = 0;
    if (queryresult.data.size > 0) {
        for (index = 0; index < queryresult.data.size; index += 16) {
            goalpoints = [];
            for (goalindex = index; goalindex - index < 16 && goalindex < queryresult.data.size; goalindex++) {
                goalpoints[goalpoints.size] = queryresult.data[goalindex].origin;
            }
            pathsegment = generatenavmeshpath(position, goalpoints, entity);
            if (isdefined(pathsegment) && pathsegment.status === "succeeded") {
                if (pathsegment.pathdistance > longestpath) {
                    path = pathsegment;
                    longestpath = pathsegment.pathdistance;
                }
            }
        }
    }
    return path;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 4, eflags: 0x4
// Checksum 0x1555878d, Offset: 0xba8
// Size: 0x39e
function private function_e7f5cb64(bots, var_343f4f7c, bbkey, claimed = undefined) {
    assert(isarray(bots));
    assert(isarray(var_343f4f7c));
    var_b570831d = [];
    if (bots.size <= 0 || var_343f4f7c.size <= 0) {
        return var_b570831d;
    }
    for (i = 0; i < var_343f4f7c.size; i++) {
        var_e20292bd = var_343f4f7c[i][#"__unsafe__"][bbkey];
        if (!isdefined(var_e20292bd)) {
            continue;
        }
        if (isdefined(claimed) && var_343f4f7c[i][#"claimed"] != claimed) {
            continue;
        }
        navpos = getclosestpointonnavmesh(var_e20292bd.origin, 200);
        if (isdefined(navpos)) {
            pathable = 1;
            distance = 0;
            for (botindex = 0; botindex < bots.size; botindex++) {
                bot = bots[botindex][#"__unsafe__"][#"bot"];
                if (!strategiccommandutility::isvalidbot(bot)) {
                    continue;
                }
                position = getclosestpointonnavmesh(bot.origin, 120, 1.2 * bot getpathfindingradius());
                if (!isdefined(position)) {
                    pathable = 0;
                    continue;
                }
                queryresult = positionquery_source_navigation(navpos, 0, 120, 60, 16, bot, 16);
                if (queryresult.data.size > 0) {
                    path = _calculatepositionquerypath(queryresult, position, bot);
                    if (!isdefined(path)) {
                        pathable = 0;
                        break;
                    }
                    if (path.pathdistance > distance) {
                        distance = path.pathdistance;
                    }
                }
            }
            if (pathable) {
                path = [];
                path[bbkey] = var_343f4f7c[i];
                path[#"distance"] = distance;
                if (!isdefined(var_b570831d)) {
                    var_b570831d = [];
                } else if (!isarray(var_b570831d)) {
                    var_b570831d = array(var_b570831d);
                }
                var_b570831d[var_b570831d.size] = path;
            }
        }
    }
    return var_b570831d;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x9cededc8, Offset: 0xf50
// Size: 0xa8
function private function_eba8d604(gameobject, defending_team) {
    teamkeys = getarraykeys(gameobject.numtouching);
    for (i = 0; i < gameobject.numtouching.size; i++) {
        team = teamkeys[i];
        if (team == defending_team) {
            continue;
        }
        if (gameobject.numtouching[team] > 0) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x84134fec, Offset: 0x1000
// Size: 0x2dc
function private function_48a74de8(commander) {
    if (!isdefined(level.zones)) {
        return;
    }
    commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
    controlzones = [];
    var_61f58c3a = arraycopy(level.zones);
    foreach (zone in var_61f58c3a) {
        if (!isdefined(zone) || !isdefined(zone.trigger) || !zone.trigger istriggerenabled()) {
            continue;
        }
        var_97601b90 = [];
        var_97601b90[#"origin"] = zone.origin;
        if (!isdefined(var_97601b90[#"__unsafe__"])) {
            var_97601b90[#"__unsafe__"] = array();
        }
        var_97601b90[#"__unsafe__"][#"controlzone"] = zone;
        if (!isdefined(controlzones)) {
            controlzones = [];
        } else if (!isarray(controlzones)) {
            controlzones = array(controlzones);
        }
        controlzones[controlzones.size] = var_97601b90;
        if (getrealtime() - commander.var_d602d17c > commander.var_48f45ba7) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.var_d602d17c = getrealtime();
            pixbeginevent("daemonControlZones");
            aiprofile_beginentry("daemonControlZones");
        }
    }
    blackboard::setstructblackboardattribute(commander, "mp_controlZones", controlzones);
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x295f099, Offset: 0x12e8
// Size: 0x334
function private function_b167c605(commander) {
    if (!isdefined(level.domflags)) {
        return;
    }
    commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
    domflags = [];
    var_d0b2eeb3 = arraycopy(level.domflags);
    foreach (domflag in var_d0b2eeb3) {
        if (!isdefined(domflag) || !isdefined(domflag.trigger)) {
            continue;
        }
        if (!domflag.trigger istriggerenabled()) {
            continue;
        }
        var_3262dd8f = [];
        var_3262dd8f[#"origin"] = domflag.origin;
        var_3262dd8f[#"radius"] = domflag.levelflag.radius;
        var_3262dd8f[#"claimed"] = commanderteam == domflag gameobjects::get_owner_team();
        if (!isdefined(var_3262dd8f[#"__unsafe__"])) {
            var_3262dd8f[#"__unsafe__"] = array();
        }
        var_3262dd8f[#"__unsafe__"][#"domflag"] = domflag;
        if (!isdefined(domflags)) {
            domflags = [];
        } else if (!isarray(domflags)) {
            domflags = array(domflags);
        }
        domflags[domflags.size] = var_3262dd8f;
        if (getrealtime() - commander.var_d602d17c > commander.var_48f45ba7) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.var_d602d17c = getrealtime();
            pixbeginevent("daemonDomFlags");
            aiprofile_beginentry("daemonDomFlags");
        }
    }
    blackboard::setstructblackboardattribute(commander, "mp_domFlags", domflags);
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 1, eflags: 0x4
// Checksum 0xa4f72a6f, Offset: 0x1628
// Size: 0x174
function private function_165f9e6e(commander) {
    if (!isdefined(level.zone)) {
        return;
    }
    commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
    zone = [];
    cachedzone = [];
    cachedzone[#"origin"] = level.zone.origin;
    if (!isdefined(cachedzone[#"__unsafe__"])) {
        cachedzone[#"__unsafe__"] = array();
    }
    cachedzone[#"__unsafe__"][#"kothzone"] = level.zone;
    if (!isdefined(zone)) {
        zone = [];
    } else if (!isarray(zone)) {
        zone = array(zone);
    }
    zone[zone.size] = cachedzone;
    blackboard::setstructblackboardattribute(commander, "mp_kothZone", zone);
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x73640b3a, Offset: 0x17a8
// Size: 0x174
function private function_2ffcdb7(commander) {
    if (!isdefined(level.sdbomb)) {
        return;
    }
    commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
    bomb = [];
    var_335929c3 = [];
    var_335929c3[#"origin"] = level.sdbomb.origin;
    if (!isdefined(var_335929c3[#"__unsafe__"])) {
        var_335929c3[#"__unsafe__"] = array();
    }
    var_335929c3[#"__unsafe__"][#"sdbomb"] = level.sdbomb;
    if (!isdefined(bomb)) {
        bomb = [];
    } else if (!isarray(bomb)) {
        bomb = array(bomb);
    }
    bomb[bomb.size] = var_335929c3;
    blackboard::setstructblackboardattribute(commander, "mp_sdBomb", bomb);
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x71fd71c3, Offset: 0x1928
// Size: 0x34c
function private function_dc2762cc(commander) {
    if (!isdefined(level.bombzones) || !isarray(level.bombzones) || level.bombzones.size <= 0) {
        return;
    }
    commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
    bombzones = [];
    var_2661b1bd = arraycopy(level.bombzones);
    foreach (bombzone in var_2661b1bd) {
        if (!isdefined(bombzone) || !isdefined(bombzone.trigger)) {
            continue;
        }
        if (!bombzone.trigger istriggerenabled()) {
            continue;
        }
        var_1e39e81 = [];
        var_1e39e81[#"origin"] = bombzone.origin;
        var_1e39e81[#"planted"] = bombzone gameobjects::get_flags(1);
        if (!isdefined(var_1e39e81[#"__unsafe__"])) {
            var_1e39e81[#"__unsafe__"] = array();
        }
        var_1e39e81[#"__unsafe__"][#"sdbombzone"] = bombzone;
        if (!isdefined(bombzones)) {
            bombzones = [];
        } else if (!isarray(bombzones)) {
            bombzones = array(bombzones);
        }
        bombzones[bombzones.size] = var_1e39e81;
        if (getrealtime() - commander.var_d602d17c > commander.var_48f45ba7) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.var_d602d17c = getrealtime();
            pixbeginevent("daemonSdBombZones");
            aiprofile_beginentry("daemonSdBombZones");
        }
    }
    blackboard::setstructblackboardattribute(commander, "mp_sdBombZones", bombzones);
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 1, eflags: 0x4
// Checksum 0xf5fd152e, Offset: 0x1c80
// Size: 0x174
function private function_c8ab1900(commander) {
    if (!isdefined(level.defuseobject)) {
        return;
    }
    commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
    defuseobj = [];
    var_1f31c0a4 = [];
    var_1f31c0a4[#"origin"] = level.defuseobject.origin;
    if (!isdefined(var_1f31c0a4[#"__unsafe__"])) {
        var_1f31c0a4[#"__unsafe__"] = array();
    }
    var_1f31c0a4[#"__unsafe__"][#"sddefuseobj"] = level.defuseobject;
    if (!isdefined(defuseobj)) {
        defuseobj = [];
    } else if (!isarray(defuseobj)) {
        defuseobj = array(defuseobj);
    }
    defuseobj[defuseobj.size] = var_1f31c0a4;
    blackboard::setstructblackboardattribute(commander, "mp_sdDefuseObj", defuseobj);
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x95b52391, Offset: 0x1e00
// Size: 0x9a
function private function_262087c(commander, squad, constants) {
    assert(isdefined(constants[#"maxage"]), "<dev string:x30>" + "<invalid>" + "<dev string:x67>");
    if (gettime() > squad.createtime + constants[#"maxage"]) {
        return false;
    }
    return true;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x61b3f8f9, Offset: 0x1ea8
// Size: 0xda
function private function_40859aba(commander, squad, constants) {
    bots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    if (!isdefined(bots)) {
        return false;
    }
    for (botindex = 0; botindex < bots.size; botindex++) {
        bot = bots[botindex][#"__unsafe__"][#"bot"];
        if (!isdefined(bot)) {
            return false;
        }
        if (!isalive(bot)) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x4454e224, Offset: 0x1f90
// Size: 0xee
function private function_794f6ce8(commander, squad, constants) {
    controlzones = plannersquadutility::getblackboardattribute(squad, "mp_controlZones");
    if (isdefined(controlzones) && controlzones.size > 0) {
        for (i = 0; i < controlzones.size; i++) {
            zone = controlzones[i][#"__unsafe__"][#"controlzone"];
            if (!zone.gameobject.trigger istriggerenabled()) {
                return false;
            }
        }
        return true;
    }
    return false;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x818ec4ca, Offset: 0x2088
// Size: 0x14e
function private function_321429de(commander, squad, constants) {
    domflags = plannersquadutility::getblackboardattribute(squad, "mp_domFlags");
    squadteam = plannersquadutility::getblackboardattribute(squad, "team");
    if (isdefined(domflags) && domflags.size > 0) {
        foreach (domflag in domflags) {
            object = domflag[#"__unsafe__"][#"domflag"];
            if (hash(squadteam) !== object gameobjects::get_owner_team()) {
                return true;
            }
        }
        return false;
    }
    return true;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 3, eflags: 0x4
// Checksum 0xbc45afd2, Offset: 0x21e0
// Size: 0xc6
function private function_992ce3bb(commander, squad, constants) {
    kothzone = plannersquadutility::getblackboardattribute(squad, "mp_kothZone");
    if (isdefined(kothzone) && kothzone.size > 0) {
        zone = kothzone[0][#"__unsafe__"][#"kothzone"];
        if (zone.gameobject.trigger istriggerenabled()) {
            return true;
        }
        return false;
    }
    return false;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x45c76998, Offset: 0x22b0
// Size: 0x1a2
function private function_f3286a1f(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    commanderteam = planner::getblackboardattribute(planner, #"team");
    assert(squadindex >= 0, "<dev string:x96>");
    controlzones = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);
    foreach (controlzone in controlzones) {
        zone = controlzone[#"controlzone"][#"__unsafe__"][#"controlzone"];
        if (!isdefined(zone) || !isdefined(zone.gameobject)) {
            continue;
        }
        if (function_eba8d604(zone.gameobject, commanderteam)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xd85d667, Offset: 0x2460
// Size: 0x98
function private function_3352782(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x96>");
    controlzones = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);
    return controlzones.size > 0;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xa328c92b, Offset: 0x2500
// Size: 0x98
function private function_fdfa6bf5(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x96>");
    domflags = planner::getblackboardattribute(planner, "mp_pathable_domFlags", squadindex);
    return domflags.size > 0;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x10074c26, Offset: 0x25a0
// Size: 0x98
function private function_d0a81d9d(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x96>");
    kothzone = planner::getblackboardattribute(planner, "mp_pathable_kothZone", squadindex);
    return kothzone.size > 0;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x1f0922c2, Offset: 0x2640
// Size: 0xa2
function private function_8f11b970(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x96>");
    bomb = planner::getblackboardattribute(planner, "mp_pathable_sdBomb", squadindex);
    return isdefined(bomb) && bomb.size > 0;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x3afab0e, Offset: 0x26f0
// Size: 0xa2
function private function_1d192562(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x96>");
    zones = planner::getblackboardattribute(planner, "mp_pathable_sdBombZones", squadindex);
    return isdefined(zones) && zones.size > 0;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x29c05b08, Offset: 0x27a0
// Size: 0x138
function private function_515c1d6a(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x96>");
    bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    for (i = 0; i < bots.size; i++) {
        bot = bots[0][#"__unsafe__"][#"bot"];
        if (isdefined(bot.isbombcarrier) && bot.isbombcarrier || isdefined(level.multibomb) && level.multibomb) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x8d0638e8, Offset: 0x28e0
// Size: 0xa2
function private function_31241e1(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x96>");
    var_86700285 = planner::getblackboardattribute(planner, "mp_pathable_sdDefuseObj", squadindex);
    return isdefined(var_86700285) && var_86700285.size > 0;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x7c5b2137, Offset: 0x2990
// Size: 0x26
function private function_e663718(planner, constants) {
    return region_utility::function_46a6789c() > 0;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x34b0be20, Offset: 0x29c0
// Size: 0x112
function private function_6b914631(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x96>");
    bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    controlzones = planner::getblackboardattribute(planner, "mp_controlZones");
    var_88e29b54 = function_e7f5cb64(bots, controlzones, "controlZone");
    planner::setblackboardattribute(planner, "mp_pathable_controlZones", var_88e29b54, squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x1a043b0a, Offset: 0x2ae0
// Size: 0x3da
function private function_f645a4cb(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    commanderteam = planner::getblackboardattribute(planner, #"team");
    assert(squadindex >= 0, "<dev string:xe6>");
    var_88e29b54 = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);
    if (!isarray(var_88e29b54) || var_88e29b54.size <= 0) {
        return spawnstruct();
    }
    var_d0ccad6a = [];
    foreach (var_30a679c5 in var_88e29b54) {
        zone = var_30a679c5[#"controlzone"][#"__unsafe__"][#"controlzone"];
        if (!isdefined(zone) || !isdefined(zone.gameobject)) {
            continue;
        }
        if (function_eba8d604(zone.gameobject, commanderteam)) {
            if (!isdefined(var_d0ccad6a)) {
                var_d0ccad6a = [];
            } else if (!isarray(var_d0ccad6a)) {
                var_d0ccad6a = array(var_d0ccad6a);
            }
            var_d0ccad6a[var_d0ccad6a.size] = var_30a679c5;
        }
    }
    if (var_d0ccad6a.size < 1) {
        if (!isdefined(var_d0ccad6a)) {
            var_d0ccad6a = [];
        } else if (!isarray(var_d0ccad6a)) {
            var_d0ccad6a = array(var_d0ccad6a);
        }
        var_d0ccad6a[var_d0ccad6a.size] = var_88e29b54[0][#"controlzone"][#"__unsafe__"][#"controlzone"];
    }
    shortestpath = var_d0ccad6a[0][#"distance"];
    controlzone = var_d0ccad6a[0][#"controlzone"];
    for (i = 1; i < var_d0ccad6a.size; i++) {
        if (var_d0ccad6a[i][#"distance"] < shortestpath) {
            shortestpath = var_d0ccad6a[i][#"distance"];
            controlzone = var_d0ccad6a[i][#"controlzone"];
        }
    }
    planner::setblackboardattribute(planner, "mp_controlZones", array(controlzone), squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x236ef994, Offset: 0x2ec8
// Size: 0x1e2
function private function_d9a44ede(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:xe6>");
    var_88e29b54 = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);
    if (!isarray(var_88e29b54) || var_88e29b54.size <= 0) {
        return spawnstruct();
    }
    shortestpath = var_88e29b54[0][#"distance"];
    controlzone = var_88e29b54[0][#"controlzone"];
    for (i = 1; i < var_88e29b54.size; i++) {
        var_30a679c5 = var_88e29b54[i];
        if (var_30a679c5[#"distance"] < shortestpath) {
            shortestpath = var_88e29b54[i][#"distance"];
            controlzone = var_88e29b54[i][#"controlzone"];
        }
    }
    planner::setblackboardattribute(planner, "mp_controlZones", array(controlzone), squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xe23e689, Offset: 0x30b8
// Size: 0x11a
function private function_a9c18a78(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x96>");
    bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    domflags = planner::getblackboardattribute(planner, "mp_domFlags");
    pathabledomflags = function_e7f5cb64(bots, domflags, "domFlag", 0);
    planner::setblackboardattribute(planner, "mp_pathable_domFlags", pathabledomflags, squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x704fafe5, Offset: 0x31e0
// Size: 0x39a
function private function_c668efcb(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:xe6>");
    pathabledomflags = planner::getblackboardattribute(planner, "mp_pathable_domFlags", squadindex);
    if (!isarray(pathabledomflags) || pathabledomflags.size <= 0) {
        return spawnstruct();
    }
    domflags = [];
    shortestpath = pathabledomflags[0][#"distance"];
    longestpath = pathabledomflags[0][#"distance"];
    var_14365e77 = 0;
    var_dcaf85fd = 0;
    for (i = 1; i < pathabledomflags.size; i++) {
        pathabledomflag = pathabledomflags[i];
        if (pathabledomflag[#"distance"] < shortestpath) {
            shortestpath = pathabledomflags[i][#"distance"];
            var_14365e77 = i;
            continue;
        }
        if (pathabledomflag[#"distance"] > longestpath) {
            longestpath = pathabledomflags[i][#"distance"];
            var_dcaf85fd = i;
        }
    }
    if (!isdefined(domflags)) {
        domflags = [];
    } else if (!isarray(domflags)) {
        domflags = array(domflags);
    }
    domflags[domflags.size] = pathabledomflags[var_14365e77][#"domflag"];
    for (i = 0; i < pathabledomflags.size; i++) {
        if (i == var_14365e77 || i == var_dcaf85fd) {
            continue;
        }
        if (!isdefined(domflags)) {
            domflags = [];
        } else if (!isarray(domflags)) {
            domflags = array(domflags);
        }
        domflags[domflags.size] = pathabledomflags[i][#"domflag"];
    }
    if (!isdefined(domflags)) {
        domflags = [];
    } else if (!isarray(domflags)) {
        domflags = array(domflags);
    }
    domflags[domflags.size] = pathabledomflags[var_dcaf85fd][#"domflag"];
    planner::setblackboardattribute(planner, "mp_domFlags", domflags, squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xce39088, Offset: 0x3588
// Size: 0x112
function private function_96f0d920(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x96>");
    bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    kothzone = planner::getblackboardattribute(planner, "mp_kothZone");
    pathablekothzone = function_e7f5cb64(bots, kothzone, "kothZone");
    planner::setblackboardattribute(planner, "mp_pathable_kothZone", pathablekothzone, squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xe3c7db9c, Offset: 0x36a8
// Size: 0x122
function private function_ba87f63d(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:xe6>");
    pathablekothzone = planner::getblackboardattribute(planner, "mp_pathable_kothZone", squadindex);
    if (!isarray(pathablekothzone) || pathablekothzone.size <= 0) {
        return spawnstruct();
    }
    planner::setblackboardattribute(planner, "mp_kothZone", array(pathablekothzone[0][#"kothzone"]), squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x9a0aba16, Offset: 0x37d8
// Size: 0x192
function private function_99ae07bf(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:xe6>");
    bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    sdbomb = planner::getblackboardattribute(planner, "mp_sdBomb");
    if (!isdefined(sdbomb)) {
        return spawnstruct();
    }
    bomb = sdbomb[0][#"__unsafe__"][#"sdbomb"];
    if (isdefined(bomb) && isdefined(bomb.carrier)) {
        var_c8dca990 = [];
    } else {
        var_c8dca990 = function_e7f5cb64(bots, sdbomb, "sdBomb");
    }
    planner::setblackboardattribute(planner, "mp_pathable_sdBomb", var_c8dca990, squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x1e2ab46f, Offset: 0x3978
// Size: 0x122
function private function_a93436e2(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:xe6>");
    pathablesdbomb = planner::getblackboardattribute(planner, "mp_pathable_sdBomb", squadindex);
    if (!isarray(pathablesdbomb) || pathablesdbomb.size <= 0) {
        return spawnstruct();
    }
    planner::setblackboardattribute(planner, "mp_sdBomb", array(pathablesdbomb[0][#"sdbomb"]), squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x64e2f660, Offset: 0x3aa8
// Size: 0x12a
function private function_6facc980(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:xe6>");
    bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    bombzones = planner::getblackboardattribute(planner, "mp_sdBombZones");
    if (isdefined(bots) && isdefined(bombzones)) {
        var_fa8d90cd = function_e7f5cb64(bots, bombzones, "sdBombZone");
        planner::setblackboardattribute(planner, "mp_pathable_sdBombZones", var_fa8d90cd, squadindex);
    }
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xb1982f75, Offset: 0x3be0
// Size: 0x16a
function private function_7590d990(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:xe6>");
    bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    var_fa8d90cd = planner::getblackboardattribute(planner, "mp_pathable_sdBombZones", squadindex);
    if (!isarray(var_fa8d90cd) || var_fa8d90cd.size <= 0) {
        return spawnstruct();
    }
    zoneindex = randomint(var_fa8d90cd.size);
    planner::setblackboardattribute(planner, "mp_sdBombZones", array(var_fa8d90cd[zoneindex][#"sdbombzone"]), squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xc939076a, Offset: 0x3d58
// Size: 0x132
function private function_cd9327cc(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:xe6>");
    bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    defuseobj = planner::getblackboardattribute(planner, "mp_sdDefuseObj");
    if (!isdefined(defuseobj)) {
        return spawnstruct();
    }
    var_ca3f8381 = function_e7f5cb64(bots, defuseobj, "sdDefuseObj");
    planner::setblackboardattribute(planner, "mp_pathable_sdDefuseObj", var_ca3f8381, squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x3d25fcc9, Offset: 0x3e98
// Size: 0x14a
function private function_7d130e9f(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:xe6>");
    bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    var_ca3f8381 = planner::getblackboardattribute(planner, "mp_pathable_sdDefuseObj", squadindex);
    if (!isarray(var_ca3f8381) || var_ca3f8381.size <= 0) {
        return spawnstruct();
    }
    planner::setblackboardattribute(planner, "mp_sdDefuseObj", array(var_ca3f8381[0][#"sddefuseobj"]), squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x1db11dc8, Offset: 0x3ff0
// Size: 0xd2
function private function_870b3d1a(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:xe6>");
    numlanes = region_utility::function_46a6789c();
    lanenum = squadindex % numlanes;
    planner::setblackboardattribute(planner, "mp_laneNum", array(lanenum), squadindex);
    return spawnstruct();
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x41c73be1, Offset: 0x40d0
// Size: 0x4c
function private function_bceb1935(planner, constants) {
    commanderteam = planner::getblackboardattribute(planner, #"team");
    return commanderteam == game.attackers;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x8a259280, Offset: 0x4128
// Size: 0x4c
function private function_17e02ed5(planner, constants) {
    commanderteam = planner::getblackboardattribute(planner, #"team");
    return commanderteam == game.defenders;
}

// Namespace namespace_12aca6a/planner_mp_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x3560f40d, Offset: 0x4180
// Size: 0x30
function private function_99d2231a(planner, constants) {
    return isdefined(level.bombplanted) && level.bombplanted;
}

