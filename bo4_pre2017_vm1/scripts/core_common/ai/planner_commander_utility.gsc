#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_squad;
#using scripts/core_common/ai/strategic_command;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;
#using scripts/core_common/ai/systems/planner_blackboard;
#using scripts/core_common/bots/bot;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace planner_commander_utility;

// Namespace planner_commander_utility/planner_commander_utility
// Params 0, eflags: 0x2
// Checksum 0xe99cbebd, Offset: 0x1510
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("planner_commander_utility", &plannercommanderutility::__init__, undefined, undefined);
}

#namespace plannercommanderutility;

// Namespace plannercommanderutility/planner_commander_utility
// Params 0, eflags: 0x4
// Checksum 0x6fa0d228, Offset: 0x1550
// Size: 0xc64
function private __init__() {
    plannerutility::registerplannerapi("commanderBlackboardValueIsTrue", &strategyblackboardvalueistrue);
    plannerutility::registerplannerapi("commanderHasAtLeastXAssaultObjects", &strategyhasatleastxassaultobjects);
    plannerutility::registerplannerapi("commanderHasAtLeastXDefendObjects", &strategyhasatleastxdefendobjects);
    plannerutility::registerplannerapi("commanderHasAtLeastXObjectives", &strategyhasatleastxobjectives);
    plannerutility::registerplannerapi("commanderHasAtLeastXPlayers", &strategyhasatleastxplayers);
    plannerutility::registerplannerapi("commanderHasAtLeastXPriorityAssaultObjects", &strategyhasatleastxpriorityassaultobjects);
    plannerutility::registerplannerapi("commanderHasAtLeastXPriorityDefendObjects", &strategyhasatleastxprioritydefendobjects);
    plannerutility::registerplannerapi("commanderHasAtLeastXUnassignedBots", &strategyhasatleastxunassignedbots);
    plannerutility::registerplannerapi("commanderHasAtLeastXUnclaimedAssaultObjects", &strategyhasatleastxunclaimedassaultobjects);
    plannerutility::registerplannerapi("commanderHasAtLeastXUnclaimedDefendObjects", &strategyhasatleastxunclaimeddefendobjects);
    plannerutility::registerplannerapi("commanderHasAtLeastXUnclaimedPriorityAssaultObjects", &strategyhasatleastxunclaimedpriorityassaultobjects);
    plannerutility::registerplannerapi("commanderHasAtLeastXUnclaimedPriorityDefendObjects", &strategyhasatleastxunclaimedprioritydefendobjects);
    plannerutility::registerplannerapi("commanderHasForceGoal", &strategyhasforcegoal);
    plannerutility::registerplannerapi("commanderShouldRushProgress", &strategyshouldrushprogress);
    plannerutility::registerplannerapi("commanderShouldThrottleProgress", &strategyshouldthrottleprogress);
    plannerutility::registerplanneraction("commanderEndPlan", undefined, undefined, undefined, undefined);
    plannerutility::registerplannerapi("commanderIncrementBlackboardValue", &strategyincrementblackboardvalue);
    plannerutility::registerplannerapi("commanderSetBlackboardValue", &strategysetblackboardvalue);
    plannerutility::registerplannerapi("commanderSquadHasPathableEscort", &strategysquadhaspathableescort);
    plannerutility::registerplannerapi("commanderSquadHasPathableObject", &strategysquadhaspathableobject);
    plannerutility::registerplannerapi("commanderSquadHasPathableObjective", &strategysquadhaspathableobjective);
    plannerutility::registerplannerapi("commanderSquadHasPathableUnclaimedObject", &strategysquadhaspathableunclaimedobject);
    plannerutility::registerplannerapi("commanderSquadCopyBlackboardValue", &strategysquadcopyblackboardvalue);
    plannerutility::registerplannerapi("commanderSquadSortEscortPOI", &strategysquadsortescortpoi);
    plannerutility::registerplanneraction("commanderSquadAssignForceGoal", &strategysquadassignforcegoalparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadAssignPathableEscort", &strategysquadassignpathableescortparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadAssignPathableObject", &strategysquadassignpathableobjectparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadAssignPathableObjective", &strategysquadassignpathableobjectiveparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadAssignPathableUnclaimedObject", &strategysquadassignpathableunclaimedobjectparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadAssignWander", &strategysquadassignwanderparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadCalculatePathableObjectives", &strategysquadcalculatepathableobjectivesparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadCalculatePathablePlayers", &strategysquadcalculatepathableplayersparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadClaimObject", &strategysquadclaimobjectparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadCreateOfSizeX", &strategysquadcreateofsizexparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadOrder", &strategysquadorderparam, undefined, undefined, undefined);
    plannerutility::registerplannerapi("commanderSquadEscortHasNoMainguard", &strategysquadescorthasnomainguard);
    plannerutility::registerplannerapi("commanderSquadEscortHasNoRearguard", &strategysquadescorthasnorearguard);
    plannerutility::registerplannerapi("commanderSquadEscortHasNoVanguard", &strategysquadescorthasnovanguard);
    plannerutility::registerplanneraction("commanderSquadEscortCalculatePathablePOI", &strategysquadescortcalculatepathablepoiparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadAssignMainguard", &strategysquadescortassignmainguardparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadAssignRearguard", &strategysquadescortassignrearguardparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderSquadAssignVanguard", &strategysquadescortassignvanguardparam, undefined, undefined, undefined);
    plannerutility::registerplannerapi("commanderPathingHasCalculatedPaths", &strategypathinghascalculatedpaths);
    plannerutility::registerplannerapi("commanderPathingHasCalculatedPathablePath", &strategypathinghascalculatedpathablepath);
    plannerutility::registerplannerapi("commanderPathingHasNoRequestPoints", &strategypathinghasnorequestpoints);
    plannerutility::registerplannerapi("commanderPathingHasRequestPoints", &strategypathinghasrequestpoints);
    plannerutility::registerplannerapi("commanderPathingHasUnprocessedGameobjects", &strategypathinghasunprocessedgameobjects);
    plannerutility::registerplannerapi("commanderPathingHasUnprocessedObjectives", &strategypathinghasunprocessedobjectives);
    plannerutility::registerplannerapi("commanderPathingHasUnprocessedRequestPoints", &strategypathinghasunprocessedrequestpoints);
    plannerutility::registerplannerapi("commanderPathingHasUnreachablePath", &strategypathinghasunreachablepath);
    plannerutility::registerplanneraction("commanderPathingAddAssaultGameobjects", &strategypathingaddassaultgameobjectsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderPathingAddDefendGameobjects", &strategypathingadddefendgameobjectsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderPathingAddObjectives", &strategypathingaddobjectivesparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderPathingAddSquadBots", &strategypathingaddsquadbotsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderPathingAddSquadEscorts", &strategypathingaddsquadescortsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderPathingAddToSquadCalculatedGameobjects", &strategypathingaddtosquadcalculatedgameobjectsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderPathingAddToSquadCalculatedObjectives", &strategypathingaddtosquadcalculatedobjectivesparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderPathingCalculatePathToRequestedPoints", &strategypathingcalculatepathtorequestedpointsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderPathingCalculateGameobjectRequestPoints", &strategypathingcalculategameobjectrequestpointsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderPathingCalculateGameobjectPathability", &strategypathingcalculategameobjectpathabilityparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderPathingCalculateObjectiveRequestPoints", &strategypathingcalculateobjectiverequestpointsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction("commanderPathingCalculateObjectivePathability", &strategypathingcalculateobjectivepathabilityparam, undefined, undefined, undefined);
    registerutilityapi("commanderScoreBotPresence", &utilityscorebotpresence);
    registerutilityapi("commanderScoreEscortPathing", &utilityscoreescortpathing);
    registerutilityapi("commanderScoreForceGoal", &utilityscoreforcegoal);
    registerutilityapi("commanderScoreGameobjectPathing", &utilityscoregameobjectpathing);
    registerutilityapi("commanderScoreGameobjectPriority", &utilityscoregameobjectpriority);
    registerutilityapi("commanderScoreGameobjectsValidity", &utilityscoregameobjectsvalidity);
    registerutilityapi("commanderScoreNoEscortOrGameobject", &utilityscorenoescortorgameobject);
    registerutilityapi("commanderScoreProgressThrottling", &utilityscoreprogressthrottling);
    registerutilityapi("commanderScoreViableEscort", &utilityscoreviableescort);
    registerdaemonapi("daemonClients", &daemonupdateclients);
    registerdaemonapi("daemonGameobjects", &daemonupdategameobjects);
    registerdaemonapi("daemonObjectives", &daemonupdateobjective);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x90e24c08, Offset: 0x21c0
// Size: 0x1a8
function private _assignsquadunclaimeddefendgameobjectparam(planner, squadindex) {
    defendobjects = planner::getblackboardattribute(planner, "gameobjects_defend");
    validobjects = [];
    defendobject = undefined;
    foreach (gameobject in defendobjects) {
        if (!gameobject["claimed"]) {
            validobjects[validobjects.size] = gameobject;
        }
    }
    if (validobjects.size > 0) {
        doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
        centroid = _calculatebotscentroid(doppelbots);
        defendobject = _calculateclosestgameobject(centroid, validobjects);
    }
    if (isdefined(defendobject)) {
        planner::setblackboardattribute(planner, "gameobjects", array(defendobject), squadindex);
    }
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x18752ca1, Offset: 0x2370
// Size: 0xf4
function private _assignsquadassaultgameobjectparam(planner, squadindex) {
    assaultobjects = planner::getblackboardattribute(planner, "gameobjects_assault");
    if (assaultobjects.size > 0) {
        doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
        centroid = _calculatebotscentroid(doppelbots);
        assaultobject = _calculateclosestgameobject(centroid, assaultobjects);
        planner::setblackboardattribute(planner, "gameobjects", array(assaultobject), squadindex);
    }
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xeb6adf6a, Offset: 0x2470
// Size: 0xf4
function private _assignsquaddefendgameobjectparam(planner, squadindex) {
    defendobjects = planner::getblackboardattribute(planner, "gameobjects_defend");
    if (defendobjects.size > 0) {
        doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
        centroid = _calculatebotscentroid(doppelbots);
        defendobject = _calculateclosestgameobject(centroid, defendobjects);
        planner::setblackboardattribute(planner, "gameobjects", array(defendobject), squadindex);
    }
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x1a0ff629, Offset: 0x2570
// Size: 0x22
function private _calculatealliedteams(team) {
    return array(team);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x1084486c, Offset: 0x25a0
// Size: 0xf6
function private _calculatebotscentroid(doppelbots) {
    /#
        assert(isarray(doppelbots));
    #/
    centroid = (0, 0, 0);
    foreach (doppelbot in doppelbots) {
        centroid += doppelbot["origin"];
    }
    if (doppelbots.size > 0) {
        return (centroid / doppelbots.size);
    }
    return centroid;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x3e0fc72a, Offset: 0x26a0
// Size: 0x15e
function private _calculateclosestgameobject(position, gameobjects) {
    /#
        assert(isvec(position));
    #/
    /#
        assert(isarray(gameobjects));
    #/
    if (gameobjects.size <= 0) {
        return undefined;
    }
    closest = gameobjects[0];
    distancesq = distancesquared(position, closest["origin"]);
    for (index = 1; index < gameobjects.size; index++) {
        newdistancesq = distancesquared(position, gameobjects[index]["origin"]);
        if (newdistancesq < distancesq) {
            closest = gameobjects[index];
            distancesq = newdistancesq;
        }
    }
    return closest;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0xe100940f, Offset: 0x2808
// Size: 0xe8
function private _calculateenemyteams(team) {
    enemyteams = [];
    foreach (individualteam in array("any", "allies", "axis", "team3")) {
        if (individualteam != team && individualteam != "any") {
            enemyteams[enemyteams.size] = individualteam;
        }
    }
    return enemyteams;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xfff813ef, Offset: 0x28f8
// Size: 0x27a
function private _calculateallpathablegameobjects(doppelbots, gameobjects) {
    /#
        assert(isarray(doppelbots));
    #/
    /#
        assert(isarray(gameobjects));
    #/
    pathablegameobjects = [];
    if (gameobjects.size <= 0) {
        return pathablegameobjects;
    }
    if (doppelbots.size <= 0) {
        return pathablegameobjects;
    }
    for (gameobjectindex = 0; gameobjectindex < gameobjects.size; gameobjectindex++) {
        gameobject = gameobjects[gameobjectindex]["__unsafe__"]["object"];
        if (!isdefined(gameobject)) {
            continue;
        }
        pathable = 1;
        longestpath = 0;
        for (botindex = 0; botindex < doppelbots.size; botindex++) {
            bot = doppelbots[botindex]["__unsafe__"]["bot"];
            if (!isdefined(bot) || !bot isbot()) {
                pathable = 0;
                break;
            }
            path = strategiccommandutility::calculatepathtogameobject(bot, gameobject);
            if (!isdefined(path)) {
                pathable = 0;
                break;
            }
            if (path.pathdistance > longestpath) {
                longestpath = path.pathdistance;
            }
        }
        if (pathable) {
            path = array();
            path["distance"] = longestpath;
            path["gameobject"] = gameobjects[gameobjectindex];
            pathablegameobjects[pathablegameobjects.size] = path;
        }
    }
    return pathablegameobjects;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xf5d12958, Offset: 0x2b80
// Size: 0x27a
function private _calculateallpathableobjectives(doppelbots, objectives) {
    /#
        assert(isarray(doppelbots));
    #/
    /#
        assert(isarray(objectives));
    #/
    pathableobjectives = [];
    if (objectives.size <= 0) {
        return pathableobjectives;
    }
    if (doppelbots.size <= 0) {
        return pathableobjectives;
    }
    for (objectiveindex = 0; objectiveindex < objectives.size; objectiveindex++) {
        trigger = objectives[objectiveindex]["__unsafe__"]["trigger"];
        if (!isdefined(trigger)) {
            continue;
        }
        pathable = 1;
        longestpath = 0;
        for (botindex = 0; botindex < doppelbots.size; botindex++) {
            bot = doppelbots[botindex]["__unsafe__"]["bot"];
            if (!isdefined(bot) || !bot isbot()) {
                pathable = 0;
                break;
            }
            path = strategiccommandutility::calculatepathtoobjective(bot, trigger);
            if (!isdefined(path)) {
                pathable = 0;
                break;
            }
            if (path.pathdistance > longestpath) {
                longestpath = path.pathdistance;
            }
        }
        if (pathable) {
            path = array();
            path["distance"] = longestpath;
            path["objective"] = objectives[objectiveindex];
            pathableobjectives[pathableobjectives.size] = path;
        }
    }
    return pathableobjectives;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x2bff2504, Offset: 0x2e08
// Size: 0x39a
function private _calculateallpathableclients(doppelbots, clients) {
    /#
        assert(isarray(doppelbots));
    #/
    /#
        assert(isarray(clients));
    #/
    pathableclients = [];
    if (clients.size <= 0) {
        return pathableclients;
    }
    if (doppelbots.size <= 0) {
        return pathableclients;
    }
    for (clientindex = 0; clientindex < clients.size; clientindex++) {
        player = clients[clientindex]["__unsafe__"]["player"];
        if (!isdefined(player) || player isinmovemode("ufo", "noclip") || player.sessionstate !== "playing") {
            continue;
        }
        clientposition = getclosestpointonnavmesh(player.origin, 200);
        pathable = 1;
        longestpath = 0;
        for (botindex = 0; botindex < doppelbots.size; botindex++) {
            position = getclosestpointonnavmesh(doppelbots[botindex]["origin"], 120);
            if (!isdefined(position) || !isdefined(clientposition)) {
                pathable = 0;
                break;
            }
            bot = doppelbots[botindex]["__unsafe__"]["bot"];
            if (!isdefined(bot) || !bot isbot()) {
                pathable = 0;
                break;
            }
            queryresult = positionquery_source_navigation(clientposition, 0, 120, 60, 16, bot, 16);
            if (queryresult.data.size > 0) {
                path = _calculatepositionquerypath(queryresult, position);
                if (!isdefined(path)) {
                    pathable = 0;
                    break;
                }
                if (path.pathdistance > longestpath) {
                    longestpath = path.pathdistance;
                }
            }
        }
        if (pathable) {
            path = array();
            path["distance"] = longestpath;
            path["player"] = clients[clientindex];
            pathableclients[pathableclients.size] = path;
        }
    }
    return pathableclients;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x3b177280, Offset: 0x31b0
// Size: 0x190
function private _calculatepositionquerypath(queryresult, position) {
    path = undefined;
    longestpath = 0;
    if (queryresult.data.size > 0) {
        for (index = 0; index < queryresult.data.size; index += 16) {
            goalpoints = [];
            for (goalindex = index; goalindex - index < 16 && goalindex < queryresult.data.size; goalindex++) {
                goalpoints[goalpoints.size] = queryresult.data[goalindex].origin;
            }
            pathsegment = generatenavmeshpath(position, goalpoints);
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

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x87c30582, Offset: 0x3348
// Size: 0x14c
function private _calculateprioritygameobjects(gameobjects, prioritygameobjectidentifiers) {
    prioritygameobjects = [];
    foreach (gameobjectentry in gameobjects) {
        identifier = gameobjectentry["identifier"];
        if (!isdefined(identifier)) {
            continue;
        }
        foreach (priorityidentifier in prioritygameobjectidentifiers) {
            if (identifier == priorityidentifier) {
                prioritygameobjects[prioritygameobjects.size] = gameobjectentry;
            }
        }
    }
    return prioritygameobjects;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0xc3d5536, Offset: 0x34a0
// Size: 0x1e4
function private _updatehistoricalgameobjects(commander) {
    destroyedgameobjecttotal = blackboard::getstructblackboardattribute(commander, "gameobjects_assault_destroyed");
    assaultobjects = blackboard::getstructblackboardattribute(commander, "gameobjects_assault");
    gameobjecttotal = 0;
    if (isarray(assaultobjects)) {
        foreach (assaultobjectentry in assaultobjects) {
            if (!isdefined(assaultobjectentry)) {
                continue;
            }
            if (assaultobjectentry["identifier"] === "carry_object") {
                continue;
            }
            gameobject = assaultobjectentry["__unsafe__"]["object"];
            if (!isdefined(gameobject) || !isdefined(gameobject.trigger) || !gameobject.trigger istriggerenabled()) {
                destroyedgameobjecttotal++;
                continue;
            }
            gameobjecttotal++;
        }
    }
    gameobjecttotal += destroyedgameobjecttotal;
    blackboard::setstructblackboardattribute(commander, "gameobjects_assault_destroyed", destroyedgameobjecttotal);
    blackboard::setstructblackboardattribute(commander, "gameobjects_assault_total", gameobjecttotal);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0xc56c7846, Offset: 0x3690
// Size: 0x344
function private daemonupdateclients(commander) {
    team = blackboard::getstructblackboardattribute(commander, "team");
    clients = getplayers(team);
    doppelbots = [];
    players = [];
    foreach (client in clients) {
        cachedclient = array();
        cachedclient["origin"] = client.origin;
        cachedclient["entnum"] = client getentitynumber();
        cachedclient["escortMainguard"] = array();
        cachedclient["escortRearguard"] = array();
        cachedclient["escortVanguard"] = array();
        if (client isbot() && !client util::is_companion()) {
            if (!isdefined(cachedclient["__unsafe__"])) {
                cachedclient["__unsafe__"] = array();
            }
            cachedclient["__unsafe__"]["bot"] = client;
            doppelbots[doppelbots.size] = cachedclient;
        }
        if (!client isbot() && isplayer(client) && !client isinmovemode("ufo", "noclip")) {
            if (!isdefined(cachedclient["__unsafe__"])) {
                cachedclient["__unsafe__"] = array();
            }
            cachedclient["__unsafe__"]["player"] = client;
            players[players.size] = cachedclient;
        }
    }
    blackboard::setstructblackboardattribute(commander, "doppelbots", doppelbots);
    blackboard::setstructblackboardattribute(commander, "players", players);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x11b1e432, Offset: 0x39e0
// Size: 0x744
function private daemonupdategameobjects(commander) {
    _updatehistoricalgameobjects(commander);
    if (isdefined(level.a_gameobjects)) {
        excluded = blackboard::getstructblackboardattribute(commander, "gameobjects_exclude");
        excludedmap = array();
        foreach (excludename in excluded) {
            excludedmap[excludename] = 1;
        }
        forceattack = blackboard::getstructblackboardattribute(commander, "gameobjects_force_attack");
        forceattackmap = array();
        foreach (forceattackname in forceattack) {
            forceattackmap[forceattackname] = 1;
        }
        forcedefend = blackboard::getstructblackboardattribute(commander, "gameobjects_force_defend");
        forcedefendmap = array();
        foreach (forcedefendname in forcedefend) {
            forcedefendmap[forcedefendname] = 1;
        }
        team = blackboard::getstructblackboardattribute(commander, "team");
        gameobjecttypes = array();
        gameobjecttypes["gameobjects_assault"] = array();
        gameobjecttypes["gameobjects_defend"] = array();
        foreach (gameobject in level.a_gameobjects) {
            if (!isdefined(gameobject) || !isdefined(gameobject.trigger)) {
                continue;
            }
            if (!gameobject.trigger istriggerenabled()) {
                continue;
            }
            identifier = gameobject gameobjects::get_identifier();
            if (isdefined(identifier) && isdefined(excludedmap[identifier])) {
                continue;
            }
            cachedgameobject = array();
            if (isdefined(identifier) && (strategiccommandutility::canattackgameobject(team, gameobject) || isdefined(forceattackmap[identifier]))) {
                assaultobjects = gameobjecttypes["gameobjects_assault"].size;
                gameobjecttypes["gameobjects_assault"][assaultobjects] = cachedgameobject;
            } else if (isdefined(identifier) && (strategiccommandutility::candefendgameobject(team, gameobject) || isdefined(forcedefendmap[identifier]))) {
                defendobjects = gameobjecttypes["gameobjects_defend"].size;
                gameobjecttypes["gameobjects_defend"][defendobjects] = cachedgameobject;
            } else {
                continue;
            }
            cachedgameobject["claimed"] = 0;
            cachedgameobject["identifier"] = identifier;
            cachedgameobject["type"] = gameobject.type;
            cachedgameobject["interactteam"] = gameobject.interactteam;
            cachedgameobject["ownerteam"] = gameobject.ownerteam;
            cachedgameobject["radius"] = gameobject.trigger.radius;
            cachedgameobject["team"] = gameobject.team;
            cachedgameobject["triggerMax"] = gameobject.trigger.maxs;
            cachedgameobject["triggerMin"] = gameobject.trigger.mins;
            cachedgameobject["origin"] = gameobject.trigger.origin;
            if (!isdefined(cachedgameobject["__unsafe__"])) {
                cachedgameobject["__unsafe__"] = array();
            }
            cachedgameobject["__unsafe__"]["object"] = gameobject;
            if (!isdefined(cachedgameobject["__unsafe__"])) {
                cachedgameobject["__unsafe__"] = array();
            }
            cachedgameobject["__unsafe__"]["entity"] = gameobject.e_object;
        }
        blackboard::setstructblackboardattribute(commander, "gameobjects_assault", gameobjecttypes["gameobjects_assault"]);
        blackboard::setstructblackboardattribute(commander, "gameobjects_defend", gameobjecttypes["gameobjects_defend"]);
    }
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0xa0ea4b2, Offset: 0x4130
// Size: 0x724
function private daemonupdateobjective(commander) {
    if (isdefined(level.a_objectives)) {
        commanderteam = blackboard::getstructblackboardattribute(commander, "team");
        objectives = array();
        foreach (objective in level.a_objectives) {
            if (isdefined(objective.m_done) && objective.m_done) {
                continue;
            }
            if (isdefined(objective.m_str_team) && objective.m_str_team != commanderteam) {
                continue;
            }
            if (isdefined(objective.m_a_player_game_obj) && objective.m_a_player_game_obj.size > 0) {
                currentbreadcrumb = 0;
                furthestobjective = undefined;
                teamplayers = getplayers(commanderteam);
                foreach (player in teamplayers) {
                    playerentitynumber = player getentitynumber();
                    objectiveid = objective.m_a_player_game_obj[playerentitynumber];
                    if (isdefined(objectiveid) && objective_state(objectiveid) == "active") {
                        cachedobjective = array();
                        cachedobjective["entNum"] = playerentitynumber;
                        cachedobjective["id"] = objectiveid;
                        cachedobjective["origin"] = objective_position(objectiveid);
                        if (!isdefined(cachedobjective["__unsafe__"])) {
                            cachedobjective["__unsafe__"] = array();
                        }
                        cachedobjective["__unsafe__"]["trigger"] = undefined;
                        if (isdefined(player.a_t_breadcrumbs)) {
                            cachedobjective["breadcrumbs"] = player.a_t_breadcrumbs.size;
                            for (index = 0; index < player.a_t_breadcrumbs.size; index++) {
                                if (player.t_current_active_breadcrumb == player.a_t_breadcrumbs[index]) {
                                    cachedobjective["currentBreadcrumb"] = index;
                                    cachedobjective["triggerMax"] = player.t_current_active_breadcrumb.maxs;
                                    cachedobjective["triggerMin"] = player.t_current_active_breadcrumb.mins;
                                    cachedobjective["radius"] = player.t_current_active_breadcrumb.radius;
                                    if (!isdefined(cachedobjective["__unsafe__"])) {
                                        cachedobjective["__unsafe__"] = array();
                                    }
                                    cachedobjective["__unsafe__"]["trigger"] = player.t_current_active_breadcrumb;
                                    break;
                                }
                            }
                        } else {
                            cachedobjective["breadcrumbs"] = 0;
                            cachedobjective["currentBreadcrumb"] = 0;
                        }
                        if (currentbreadcrumb <= cachedobjective["currentBreadcrumb"]) {
                            currentbreadcrumb = cachedobjective["currentBreadcrumb"];
                            furthestobjective = cachedobjective;
                        }
                    }
                }
                if (isdefined(furthestobjective)) {
                    objectives[objectives.size] = furthestobjective;
                }
                continue;
            }
            if (isdefined(objective.m_a_targets) && objective.m_a_targets.size > 0) {
                foreach (objectiveid in objective.m_a_game_obj) {
                    if (isdefined(objectiveid) && objective_state(objectiveid) == "active") {
                        foreach (target in objective.m_a_targets) {
                            if (isdefined(target) && isdefined(target.origin)) {
                                cachedobjective = array();
                                cachedobjective["id"] = objectiveid;
                                cachedobjective["origin"] = target.origin;
                                if (!isdefined(cachedobjective["__unsafe__"])) {
                                    cachedobjective["__unsafe__"] = array();
                                }
                                cachedobjective["__unsafe__"]["trigger"] = undefined;
                            }
                        }
                    }
                }
            }
        }
        blackboard::setstructblackboardattribute(commander, "objectives", objectives);
    }
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xff143c, Offset: 0x4860
// Size: 0x90
function private strategyblackboardvalueistrue(planner, constants) {
    /#
        assert(isstring(constants["<dev string:x28>"]), "<dev string:x2c>" + "plannercommanderutility::strategyblackboardvalueistrue" + "<dev string:x38>");
    #/
    return planner::getblackboardattribute(planner, constants["key"]) == 1;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x80a1a963, Offset: 0x48f8
// Size: 0x112
function private strategysquadcalculatepathableobjectivesparam(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    objectives = planner::getblackboardattribute(planner, "objectives");
    pathableobjectives = _calculateallpathableobjectives(doppelbots, objectives);
    planner::setblackboardattribute(planner, "pathable_objectives", pathableobjectives, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x2e1354b9, Offset: 0x4a18
// Size: 0x112
function private strategysquadcalculatepathableplayersparam(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    players = planner::getblackboardattribute(planner, "players");
    pathableescorts = _calculateallpathableclients(doppelbots, players);
    planner::setblackboardattribute(planner, "pathable_escorts", pathableescorts, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x657a5640, Offset: 0x4b38
// Size: 0xcc
function strategyincrementblackboardvalue(planner, constants) {
    /#
        assert(isarray(constants));
    #/
    /#
        assert(isstring(constants["<dev string:xac>"]));
    #/
    planner::setblackboardattribute(planner, constants["name"], planner::getblackboardattribute(planner, constants["name"]) + 1);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x146b3352, Offset: 0x4c10
// Size: 0xac
function strategysetblackboardvalue(planner, constants) {
    /#
        assert(isarray(constants));
    #/
    /#
        assert(isstring(constants["<dev string:xac>"]));
    #/
    planner::setblackboardattribute(planner, constants["name"], constants["value"]);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x1225b683, Offset: 0x4cc8
// Size: 0x1e6
function strategyshouldrushprogress(planner, constant) {
    if (planner::getblackboardattribute(planner, "allow_progress_throttling") === 1) {
        enemycommander = planner::getblackboardattribute(planner, "throttling_enemy_commander");
        if (!isdefined(enemycommander)) {
            return 0;
        }
        lowerbound = planner::getblackboardattribute(planner, "throttling_lower_bound");
        upperbound = planner::getblackboardattribute(planner, "throttling_upper_bound");
        destroyedassaults = planner::getblackboardattribute(planner, "gameobjects_assault_destroyed");
        totalassaults = planner::getblackboardattribute(planner, "throttling_total_gameobjects");
        if (!isdefined(totalassaults)) {
            totalassaults = planner::getblackboardattribute(planner, "gameobjects_assault_total");
        }
        enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, "gameobjects_assault_destroyed");
        enemytotalassaults = planner::getblackboardattribute(planner, "throttling_total_gameobjects_enemy");
        if (!isdefined(enemytotalassaults)) {
            enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, "gameobjects_assault_total");
        }
        return strategiccommandutility::calculateprogressrushing(lowerbound, upperbound, destroyedassaults, totalassaults, enemydestroyedassaults, enemytotalassaults);
    }
    return 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x51898df3, Offset: 0x4eb8
// Size: 0x1e6
function strategyshouldthrottleprogress(planner, constant) {
    if (planner::getblackboardattribute(planner, "allow_progress_throttling") === 1) {
        enemycommander = planner::getblackboardattribute(planner, "throttling_enemy_commander");
        if (!isdefined(enemycommander)) {
            return 0;
        }
        lowerbound = planner::getblackboardattribute(planner, "throttling_lower_bound");
        upperbound = planner::getblackboardattribute(planner, "throttling_upper_bound");
        destroyedassaults = planner::getblackboardattribute(planner, "gameobjects_assault_destroyed");
        totalassaults = planner::getblackboardattribute(planner, "throttling_total_gameobjects");
        if (!isdefined(totalassaults)) {
            totalassaults = planner::getblackboardattribute(planner, "gameobjects_assault_total");
        }
        enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, "gameobjects_assault_destroyed");
        enemytotalassaults = planner::getblackboardattribute(planner, "throttling_total_gameobjects_enemy");
        if (!isdefined(enemytotalassaults)) {
            enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, "gameobjects_assault_total");
        }
        return strategiccommandutility::calculateprogressthrottling(lowerbound, upperbound, destroyedassaults, totalassaults, enemydestroyedassaults, enemytotalassaults);
    }
    return 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x24e86c1a, Offset: 0x50a8
// Size: 0xf2
function strategysquadorderparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    /#
        assert(isstring(constants["<dev string:xb1>"]), "<dev string:x2c>" + "plannercommanderutility::strategysquadorderparam" + "<dev string:xb7>");
    #/
    planner::setblackboardattribute(planner, "order", constants["order"], squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x75c51a0f, Offset: 0x51a8
// Size: 0xc2
function strategysquadassignforcegoalparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    forcegoal = planner::getblackboardattribute(planner, "force_goal");
    planner::setblackboardattribute(planner, "force_goal", forcegoal, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x3e3f202f, Offset: 0x5278
// Size: 0x192
function strategysquadassignpathableescortparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    pathableescorts = planner::getblackboardattribute(planner, "pathable_escorts", squadindex);
    shortestpath = pathableescorts[0]["distance"];
    player = pathableescorts[0]["player"];
    for (index = 1; index < pathableescorts.size; index++) {
        pathableescort = pathableescorts[index];
        if (pathableescort["distance"] < shortestpath) {
            shortestpath = pathableescort["distance"];
            player = pathableescort["player"];
        }
    }
    planner::setblackboardattribute(planner, "escorts", array(player), squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xa476b99a, Offset: 0x5418
// Size: 0x2da
function private strategysquadassignpathableobjectparam(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    pathablegameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
    prioritynames = planner::getblackboardattribute(planner, "gameobjects_priority");
    gameobject = undefined;
    foreach (priorityname in prioritynames) {
        foreach (pathablegameobject in pathablegameobjects) {
            if (pathablegameobject["gameobject"]["identifier"] === priorityname) {
                gameobject = pathablegameobject["gameobject"];
                break;
            }
        }
    }
    if (!isdefined(gameobject)) {
        shortestpath = pathablegameobjects[0]["distance"];
        gameobject = pathablegameobjects[0]["gameobject"];
        for (index = 1; index < pathablegameobjects.size; index++) {
            pathablegameobject = pathablegameobjects[index];
            if (pathablegameobject["distance"] < shortestpath) {
                shortestpath = pathablegameobject["distance"];
                gameobject = pathablegameobject["gameobject"];
            }
        }
    }
    planner::setblackboardattribute(planner, "gameobjects", array(gameobject), squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x42b939d, Offset: 0x5700
// Size: 0x192
function private strategysquadassignpathableobjectiveparam(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    pathableobjectives = planner::getblackboardattribute(planner, "pathable_objectives", squadindex);
    shortestpath = pathableobjectives[0]["distance"];
    objective = pathableobjectives[0]["objective"];
    for (index = 1; index < pathableobjectives.size; index++) {
        pathableobjective = pathableobjectives[index];
        if (pathableobjective["distance"] < shortestpath) {
            shortestpath = pathableobjective["distance"];
            objective = pathableobjective["objective"];
        }
    }
    planner::setblackboardattribute(planner, "objectives", array(objective), squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xbcceaa00, Offset: 0x58a0
// Size: 0x32a
function private strategysquadassignpathableunclaimedobjectparam(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    pathablegameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
    prioritynames = planner::getblackboardattribute(planner, "gameobjects_priority");
    gameobject = undefined;
    foreach (priorityname in prioritynames) {
        foreach (pathablegameobject in pathablegameobjects) {
            if (!pathablegameobject["gameobject"]["claimed"] && pathablegameobject["gameobject"]["identifier"] === priorityname) {
                gameobject = pathablegameobject["gameobject"];
                break;
            }
        }
    }
    if (!isdefined(gameobject)) {
        shortestpath = undefined;
        foreach (pathablegameobject in pathablegameobjects) {
            if (!isdefined(shortestpath) || !pathablegameobject["gameobject"]["claimed"] && pathablegameobject["distance"] < shortestpath) {
                shortestpath = pathablegameobject["distance"];
                gameobject = pathablegameobject["gameobject"];
            }
        }
    }
    if (isdefined(gameobject)) {
        planner::setblackboardattribute(planner, "gameobjects", array(gameobject), squadindex);
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xca849c8d, Offset: 0x5bd8
// Size: 0x9a
function private strategysquadassignwanderparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    planner::setblackboardattribute(planner, "order", "order_wander", squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x647e5eff, Offset: 0x5c80
// Size: 0x14a
function private strategysquadclaimobjectparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    gameobjects = planner::getblackboardattribute(planner, "gameobjects", squadindex);
    /#
        assert(gameobjects.size > 0, "<dev string:xdd>");
    #/
    foreach (gameobject in gameobjects) {
        gameobject["claimed"] = 1;
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x82ad1e4f, Offset: 0x5dd8
// Size: 0x164
function private strategysquadcopyblackboardvalue(planner, constants) {
    /#
        assert(isstring(constants["<dev string:x12f>"]), "<dev string:x2c>" + "plannercommanderutility::strategysquadcopyblackboardvalue" + "<dev string:x134>");
    #/
    /#
        assert(isstring(constants["<dev string:x163>"]), "<dev string:x2c>" + "plannercommanderutility::strategysquadcopyblackboardvalue" + "<dev string:x166>");
    #/
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    value = planner::getblackboardattribute(planner, constants["from"], squadindex);
    planner::setblackboardattribute(planner, constants["to"], value, squadindex);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x70700837, Offset: 0x5f48
// Size: 0x292
function private strategysquadcreateofsizexparam(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategysquadcreateofsizexparam" + "<dev string:x19a>");
    #/
    doppelbots = planner::getblackboardattribute(planner, "idle_doppelbots");
    /#
        assert(doppelbots.size >= constants["<dev string:x193>"], "<dev string:x1c1>" + constants["<dev string:x193>"] + "<dev string:x1e9>");
    #/
    enlisteddoppelbots = array();
    idledoppelbots = array();
    for (index = 0; index < constants["amount"]; index++) {
        enlisteddoppelbots[enlisteddoppelbots.size] = doppelbots[index];
    }
    for (index = constants["amount"]; index < doppelbots.size; index++) {
        idledoppelbots[idledoppelbots.size] = doppelbots[index];
    }
    planner::setblackboardattribute(planner, "idle_doppelbots", idledoppelbots);
    squadindex = planner::createsubblackboard(planner);
    planner::setblackboardattribute(planner, "current_squad", squadindex);
    planner::setblackboardattribute(planner, "doppelbots", enlisteddoppelbots, squadindex);
    team = planner::getblackboardattribute(planner, "team");
    planner::setblackboardattribute(planner, "team", team, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xb638a0a0, Offset: 0x61e8
// Size: 0x1c2
function private strategysquadescortassignmainguardparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    foreach (escort in escorts) {
        escort["escortMainguard"] = arraycombine(escort["escortMainguard"], squadbots, 1, 0);
    }
    planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
    planner::setblackboardattribute(planner, "order", "order_escort_mainguard", squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x5ad0f5be, Offset: 0x63b8
// Size: 0x1c2
function private strategysquadescortassignrearguardparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    foreach (escort in escorts) {
        escort["escortRearguard"] = arraycombine(escort["escortRearguard"], squadbots, 1, 0);
    }
    planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
    planner::setblackboardattribute(planner, "order", "order_escort_rearguard", squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xebb4567d, Offset: 0x6588
// Size: 0x1c2
function private strategysquadescortassignvanguardparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    foreach (escort in escorts) {
        escort["escortVanguard"] = arraycombine(escort["escortVanguard"], squadbots, 1, 0);
    }
    planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
    planner::setblackboardattribute(planner, "order", "order_escort_vanguard", squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xa9dfc425, Offset: 0x6758
// Size: 0x122
function private strategysquadescortcalculatepathablepoiparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    /#
        assert(isarray(escorts) && escorts.size > 0, "<dev string:x1fc>");
    #/
    escortpoi = array();
    planner::setblackboardattribute(planner, "escort_poi", escortpoi, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xf44fcf58, Offset: 0x6888
// Size: 0x11e
function private strategysquadescorthasnomainguard(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    foreach (escort in escorts) {
        if (escort["escortMainguard"].size > 0) {
            return true;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xb0ebc3b1, Offset: 0x69b0
// Size: 0x11c
function private strategysquadescorthasnorearguard(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    foreach (escort in escorts) {
        if (escort["escortRearguard"].size > 0) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xf19d3877, Offset: 0x6ad8
// Size: 0x11c
function private strategysquadescorthasnovanguard(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    foreach (escort in escorts) {
        if (escort["escortVanguard"].size > 0) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x2f3e412d, Offset: 0x6c00
// Size: 0x1a4
function private strategysquadsortescortpoi(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    escortpois = planner::getblackboardattribute(planner, "escort_poi", squadindex);
    if (escortpois.size > 0) {
        for (index = 0; index < escortpois.size; index++) {
            closestindex = index;
            for (innerindex = index + 1; innerindex < escortpois.size; innerindex++) {
                if (escortpois[innerindex]["distance"] < escortpois[closestindex]["distance"]) {
                    closestindex = innerindex;
                }
            }
            temp = escortpois[index];
            escortpois[index] = escortpois[closestindex];
            escortpois[closestindex] = temp;
        }
    }
    planner::setblackboardattribute(planner, "escort_poi", escortpois, squadindex);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x9c10aef2, Offset: 0x6db0
// Size: 0x9a
function private strategysquadhaspathableescort(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    escorts = planner::getblackboardattribute(planner, "pathable_escorts", squadindex);
    return escorts.size > 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xbace9520, Offset: 0x6e58
// Size: 0xa4
function private strategysquadhaspathableobject(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    gameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
    return isdefined(gameobjects) && gameobjects.size > 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x2a5a9f0, Offset: 0x6f08
// Size: 0x9a
function private strategysquadhaspathableobjective(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    objectives = planner::getblackboardattribute(planner, "pathable_objectives", squadindex);
    return objectives.size > 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x7733e7a6, Offset: 0x6fb0
// Size: 0xe2
function private strategysquadhaspathableunclaimedobject(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x5c>");
    #/
    gameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
    for (index = 0; index < gameobjects.size; index++) {
        if (!gameobjects[index]["gameobject"]["claimed"]) {
            return true;
        }
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x1547d06e, Offset: 0x70a0
// Size: 0x92
function private strategyhasatleastxassaultobjects(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategyhasatleastxassaultobjects" + "<dev string:x19a>");
    #/
    return planner::getblackboardattribute(planner, "gameobjects_assault").size >= constants["amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xaa492b8c, Offset: 0x7140
// Size: 0x92
function private strategyhasatleastxdefendobjects(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategyhasatleastxdefendobjects" + "<dev string:x19a>");
    #/
    return planner::getblackboardattribute(planner, "gameobjects_defend").size >= constants["amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x8ca7a225, Offset: 0x71e0
// Size: 0x92
function private strategyhasatleastxobjectives(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategyhasatleastxobjectives" + "<dev string:x19a>");
    #/
    return planner::getblackboardattribute(planner, "objectives").size >= constants["amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x463719af, Offset: 0x7280
// Size: 0x92
function private strategyhasatleastxplayers(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategyhasatleastxplayers" + "<dev string:x19a>");
    #/
    return planner::getblackboardattribute(planner, "players").size >= constants["amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xcc774620, Offset: 0x7320
// Size: 0x226
function private strategyhasatleastxpriorityassaultobjects(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategyhasatleastxpriorityassaultobjects" + "<dev string:x19a>");
    #/
    if (strategyhasatleastxassaultobjects(planner, constants)) {
        prioritynames = planner::getblackboardattribute(planner, "gameobjects_priority");
        prioritymap = [];
        foreach (priorityname in prioritynames) {
            prioritymap[priorityname] = 1;
        }
        priorityobjects = 0;
        gameobjects = planner::getblackboardattribute(planner, "gameobjects_assault");
        foreach (gameobject in gameobjects) {
            if (isdefined(gameobject["identifier"]) && isdefined(prioritymap[gameobject["identifier"]])) {
                priorityobjects++;
            }
        }
        return (priorityobjects >= constants["amount"]);
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xbc9a095d, Offset: 0x7550
// Size: 0x226
function private strategyhasatleastxprioritydefendobjects(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategyhasatleastxprioritydefendobjects" + "<dev string:x19a>");
    #/
    if (strategyhasatleastxassaultobjects(planner, constants)) {
        prioritynames = planner::getblackboardattribute(planner, "gameobjects_priority");
        prioritymap = [];
        foreach (priorityname in prioritynames) {
            prioritymap[priorityname] = 1;
        }
        priorityobjects = 0;
        gameobjects = planner::getblackboardattribute(planner, "gameobjects_defend");
        foreach (gameobject in gameobjects) {
            if (isdefined(gameobject["identifier"]) && isdefined(prioritymap[gameobject["identifier"]])) {
                priorityobjects++;
            }
        }
        return (priorityobjects >= constants["amount"]);
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x69154321, Offset: 0x7780
// Size: 0x92
function private strategyhasatleastxunassignedbots(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategyhasatleastxunassignedbots" + "<dev string:x19a>");
    #/
    return planner::getblackboardattribute(planner, "idle_doppelbots").size >= constants["amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x64ed87aa, Offset: 0x7820
// Size: 0x136
function strategyhasatleastxunclaimedassaultobjects(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategyhasatleastxunclaimedassaultobjects" + "<dev string:x19a>");
    #/
    unclaimedobjects = 0;
    gameobjects = planner::getblackboardattribute(planner, "gameobjects_assault");
    foreach (gameobject in gameobjects) {
        if (!gameobject["claimed"]) {
            unclaimedobjects++;
        }
    }
    return unclaimedobjects >= constants["amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x237af3ff, Offset: 0x7960
// Size: 0x136
function strategyhasatleastxunclaimeddefendobjects(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategyhasatleastxunclaimeddefendobjects" + "<dev string:x19a>");
    #/
    unclaimedobjects = 0;
    gameobjects = planner::getblackboardattribute(planner, "gameobjects_defend");
    foreach (gameobject in gameobjects) {
        if (!gameobject["claimed"]) {
            unclaimedobjects++;
        }
    }
    return unclaimedobjects >= constants["amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0xf496bb70, Offset: 0x7aa0
// Size: 0x23a
function strategyhasatleastxunclaimedpriorityassaultobjects(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategyhasatleastxunclaimedpriorityassaultobjects" + "<dev string:x19a>");
    #/
    if (strategyhasatleastxassaultobjects(planner, constants)) {
        prioritynames = planner::getblackboardattribute(planner, "gameobjects_priority");
        prioritymap = [];
        foreach (priorityname in prioritynames) {
            prioritymap[priorityname] = 1;
        }
        priorityobjects = 0;
        gameobjects = planner::getblackboardattribute(planner, "gameobjects_assault");
        foreach (gameobject in gameobjects) {
            if (isdefined(gameobject["identifier"]) && isdefined(prioritymap[gameobject["identifier"]]) && !gameobject["claimed"]) {
                priorityobjects++;
            }
        }
        return (priorityobjects >= constants["amount"]);
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x148a5425, Offset: 0x7ce8
// Size: 0x23a
function strategyhasatleastxunclaimedprioritydefendobjects(planner, constants) {
    /#
        assert(isint(constants["<dev string:x193>"]), "<dev string:x2c>" + "plannercommanderutility::strategyhasatleastxunclaimedprioritydefendobjects" + "<dev string:x19a>");
    #/
    if (strategyhasatleastxassaultobjects(planner, constants)) {
        prioritynames = planner::getblackboardattribute(planner, "gameobjects_priority");
        prioritymap = [];
        foreach (priorityname in prioritynames) {
            prioritymap[priorityname] = 1;
        }
        priorityobjects = 0;
        gameobjects = planner::getblackboardattribute(planner, "gameobjects_defend");
        foreach (gameobject in gameobjects) {
            if (isdefined(gameobject["identifier"]) && isdefined(prioritymap[gameobject["identifier"]]) && !gameobject["claimed"]) {
                priorityobjects++;
            }
        }
        return (priorityobjects >= constants["amount"]);
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x7754cb84, Offset: 0x7f30
// Size: 0x34
function strategyhasforcegoal(planner, constants) {
    return isdefined(planner::getblackboardattribute(planner, "force_goal"));
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x4b25a887, Offset: 0x7f70
// Size: 0x38
function private strategypathinghascalculatedpaths(planner, constants) {
    return planner::getblackboardattribute(planner, "pathing_calculated_paths").size > 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xe396eed0, Offset: 0x7fb0
// Size: 0xae
function private strategypathinghascalculatedpathablepath(planner, constants) {
    bots = planner::getblackboardattribute(planner, "pathing_requested_bots");
    botindex = planner::getblackboardattribute(planner, "pathing_current_bot_index");
    calculatedpaths = planner::getblackboardattribute(planner, "pathing_calculated_paths");
    return calculatedpaths.size >= bots.size && botindex >= bots.size;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x9dd184a7, Offset: 0x8068
// Size: 0x38
function private strategypathinghasnorequestpoints(planner, constants) {
    return planner::getblackboardattribute(planner, "pathing_requested_points").size <= 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x2ba4365e, Offset: 0x80a8
// Size: 0x38
function private strategypathinghasrequestpoints(planner, constants) {
    return planner::getblackboardattribute(planner, "pathing_requested_points").size > 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x2c22cbfc, Offset: 0x80e8
// Size: 0x74
function private strategypathinghasunprocessedgameobjects(planner, constants) {
    requestedgameobjects = planner::getblackboardattribute(planner, "pathing_requested_gameobjects");
    gameobjectindex = planner::getblackboardattribute(planner, "pathing_current_gameobject_index");
    return gameobjectindex < requestedgameobjects.size;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xaf729445, Offset: 0x8168
// Size: 0x74
function private strategypathinghasunprocessedobjectives(planner, constants) {
    requestedobjectives = planner::getblackboardattribute(planner, "pathing_requested_objectives");
    objectiveindex = planner::getblackboardattribute(planner, "pathing_current_objective_index");
    return objectiveindex < requestedobjectives.size;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xe43e9df8, Offset: 0x81e8
// Size: 0xd4
function private strategypathinghasunprocessedrequestpoints(planner, constants) {
    requestedpoints = planner::getblackboardattribute(planner, "pathing_requested_points");
    bots = planner::getblackboardattribute(planner, "pathing_requested_bots");
    pointindex = planner::getblackboardattribute(planner, "pathing_current_point_index");
    botindex = planner::getblackboardattribute(planner, "pathing_current_bot_index");
    return pointindex < requestedpoints.size && botindex < bots.size;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x9495aa3b, Offset: 0x82c8
// Size: 0x74
function private strategypathinghasunreachablepath(planner, constants) {
    botindex = planner::getblackboardattribute(planner, "pathing_current_bot_index");
    calculatedpaths = planner::getblackboardattribute(planner, "pathing_calculated_paths");
    return botindex > calculatedpaths.size;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xee07c5a5, Offset: 0x8348
// Size: 0x72
function private strategypathingaddassaultgameobjectsparam(planner, constants) {
    assaultobjects = planner::getblackboardattribute(planner, "gameobjects_assault");
    planner::setblackboardattribute(planner, "pathing_requested_gameobjects", assaultobjects);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x4a43247a, Offset: 0x83c8
// Size: 0x72
function private strategypathingadddefendgameobjectsparam(planner, constants) {
    defendobjects = planner::getblackboardattribute(planner, "gameobjects_defend");
    planner::setblackboardattribute(planner, "pathing_requested_gameobjects", defendobjects);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xdfd9fd0f, Offset: 0x8448
// Size: 0x72
function private strategypathingaddobjectivesparam(planner, constants) {
    objectives = planner::getblackboardattribute(planner, "objectives");
    planner::setblackboardattribute(planner, "pathing_requested_objectives", objectives);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x530cdcf5, Offset: 0x84c8
// Size: 0xc2
function private strategypathingaddsquadbotsparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x25c>");
    #/
    doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    planner::setblackboardattribute(planner, "pathing_requested_bots", doppelbots);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xb1963d6b, Offset: 0x8598
// Size: 0x172
function private strategypathingaddsquadescortsparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x25c>");
    #/
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    for (index = 0; index < escorts.size; index++) {
        player = escorts[index]["__unsafe__"]["player"];
        if (!isdefined(escorts[index]["__unsafe__"])) {
            escorts[index]["__unsafe__"] = array();
        }
        escorts[index]["__unsafe__"]["bot"] = player;
    }
    planner::setblackboardattribute(planner, "pathing_requested_bots", escorts);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xa4318fda, Offset: 0x8718
// Size: 0x14a
function private strategypathingaddtosquadcalculatedgameobjectsparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x25c>");
    #/
    calculatedgameobjects = planner::getblackboardattribute(planner, "pathing_calculated_gameobjects");
    gameobjects = planner::getblackboardattribute(planner, "gameobjects", squadindex);
    if (!isdefined(gameobjects)) {
        gameobjects = array();
    }
    if (isdefined(calculatedgameobjects) && calculatedgameobjects.size > 0) {
        gameobjects = arraycombine(gameobjects, calculatedgameobjects, 0, 0);
    }
    planner::setblackboardattribute(planner, "pathable_gameobjects", gameobjects, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x71b2958a, Offset: 0x8870
// Size: 0x14a
function private strategypathingaddtosquadcalculatedobjectivesparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, "current_squad");
    /#
        assert(squadindex >= 0, "<dev string:x25c>");
    #/
    calculatedobjectives = planner::getblackboardattribute(planner, "pathing_calculated_objectives");
    objectives = planner::getblackboardattribute(planner, "objectives", squadindex);
    if (!isdefined(objectives)) {
        objectives = array();
    }
    if (isdefined(calculatedobjectives) && calculatedobjectives.size > 0) {
        objectives = arraycombine(objectives, calculatedobjectives, 0, 0);
    }
    planner::setblackboardattribute(planner, "pathable_objectives", objectives, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x36ebe512, Offset: 0x89c8
// Size: 0x332
function private strategypathingcalculatepathtorequestedpointsparam(planner, constants) {
    requestedpoints = planner::getblackboardattribute(planner, "pathing_requested_points");
    bots = planner::getblackboardattribute(planner, "pathing_requested_bots");
    pointindex = planner::getblackboardattribute(planner, "pathing_current_point_index");
    botindex = planner::getblackboardattribute(planner, "pathing_current_bot_index");
    /#
        assert(bots.size > 0);
    #/
    /#
        assert(requestedpoints.size > 0);
    #/
    /#
        assert(pointindex < requestedpoints.size);
    #/
    /#
        assert(botindex < bots.size);
    #/
    if (bots.size > 0 && requestedpoints.size > 0 && pointindex < requestedpoints.size && botindex < bots.size) {
        bot = bots[botindex]["__unsafe__"]["bot"];
        goalpoints = array();
        startindex = pointindex;
        index = 0;
        while (pointindex < requestedpoints.size && index < 16) {
            goalpoints[goalpoints.size] = requestedpoints[pointindex];
            index++;
            pointindex++;
        }
        path = strategiccommandutility::calculatepathtopoints(bot, goalpoints);
        if (isdefined(path)) {
            calculatedpaths = planner::getblackboardattribute(planner, "pathing_calculated_paths");
            calculatedpaths[calculatedpaths.size] = path;
            planner::setblackboardattribute(planner, "pathing_calculated_paths", calculatedpaths, undefined, 1);
        }
        if (isdefined(path) || pointindex >= requestedpoints.size) {
            pointindex = 0;
            botindex++;
        }
        planner::setblackboardattribute(planner, "pathing_current_point_index", pointindex);
        planner::setblackboardattribute(planner, "pathing_current_bot_index", botindex);
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x6aefb19b, Offset: 0x8d08
// Size: 0x1b2
function private strategypathingcalculategameobjectrequestpointsparam(planner, constants) {
    requestedbots = planner::getblackboardattribute(planner, "pathing_requested_bots");
    requestedgameobjects = planner::getblackboardattribute(planner, "pathing_requested_gameobjects");
    gameobjectindex = planner::getblackboardattribute(planner, "pathing_current_gameobject_index");
    if (requestedbots.size <= 0 || requestedgameobjects.size <= 0) {
        return spawnstruct();
    }
    requestedbot = requestedbots[0];
    bot = requestedbot["__unsafe__"]["bot"];
    gameobject = requestedgameobjects[gameobjectindex]["__unsafe__"]["object"];
    requestedpoints = array();
    if (strategiccommandutility::isvalidbotorplayer(bot) && isdefined(gameobject)) {
        requestedpoints = strategiccommandutility::querypointsaroundgameobject(bot, gameobject);
    }
    planner::setblackboardattribute(planner, "pathing_requested_points", requestedpoints);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xf58c4619, Offset: 0x8ec8
// Size: 0x1b2
function private strategypathingcalculateobjectiverequestpointsparam(planner, constants) {
    requestedbots = planner::getblackboardattribute(planner, "pathing_requested_bots");
    requestedobjectives = planner::getblackboardattribute(planner, "pathing_requested_objectives");
    objectiveindex = planner::getblackboardattribute(planner, "pathing_current_objective_index");
    if (requestedbots.size <= 0 || requestedobjectives.size <= 0) {
        return spawnstruct();
    }
    requestedbot = requestedbots[0];
    bot = requestedbot["__unsafe__"]["bot"];
    trigger = requestedobjectives[objectiveindex]["__unsafe__"]["trigger"];
    requestedpoints = array();
    if (strategiccommandutility::isvalidbotorplayer(bot) && isdefined(trigger)) {
        requestedpoints = strategiccommandutility::querypointsinsidetrigger(bot, trigger);
    }
    planner::setblackboardattribute(planner, "pathing_requested_points", requestedpoints);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xcddd41f3, Offset: 0x9088
// Size: 0x1ea
function private strategypathingcalculateobjectivepathabilityparam(planner, constants) {
    requestedbots = planner::getblackboardattribute(planner, "pathing_requested_bots");
    requestedobjectives = planner::getblackboardattribute(planner, "pathing_requested_objectives");
    objectiveindex = planner::getblackboardattribute(planner, "pathing_current_objective_index");
    calculatedpaths = planner::getblackboardattribute(planner, "pathing_calculated_paths");
    if (requestedbots.size == calculatedpaths.size) {
        longestpath = 0;
        for (index = 0; index < calculatedpaths.size; index++) {
            if (calculatedpaths[index].pathdistance > longestpath) {
                longestpath = calculatedpaths[index].pathdistance;
            }
        }
        objectiveentry = array();
        objectiveentry["distance"] = longestpath;
        objectiveentry["objective"] = requestedobjectives[objectiveindex];
        calculatedobjectives = planner::getblackboardattribute(planner, "pathing_calculated_objectives");
        calculatedobjectives[calculatedobjectives.size] = objectiveentry;
        planner::setblackboardattribute(planner, "pathing_calculated_objectives", calculatedobjectives);
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x8470829c, Offset: 0x9280
// Size: 0x1ea
function private strategypathingcalculategameobjectpathabilityparam(planner, constants) {
    requestedbots = planner::getblackboardattribute(planner, "pathing_requested_bots");
    requestedgameobjects = planner::getblackboardattribute(planner, "pathing_requested_gameobjects");
    gameobjectindex = planner::getblackboardattribute(planner, "pathing_current_gameobject_index");
    calculatedpaths = planner::getblackboardattribute(planner, "pathing_calculated_paths");
    if (requestedbots.size == calculatedpaths.size) {
        longestpath = 0;
        for (index = 0; index < calculatedpaths.size; index++) {
            if (calculatedpaths[index].pathdistance > longestpath) {
                longestpath = calculatedpaths[index].pathdistance;
            }
        }
        gameobjectentry = array();
        gameobjectentry["distance"] = longestpath;
        gameobjectentry["gameobject"] = requestedgameobjects[gameobjectindex];
        calculatedgameobjects = planner::getblackboardattribute(planner, "pathing_calculated_gameobjects");
        calculatedgameobjects[calculatedgameobjects.size] = gameobjectentry;
        planner::setblackboardattribute(planner, "pathing_calculated_gameobjects", calculatedgameobjects);
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x532d9ae0, Offset: 0x9478
// Size: 0x126
function private utilityscorebotpresence(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    if (isdefined(doppelbots) && doppelbots.size > 0) {
        foreach (botentry in doppelbots) {
            bot = botentry["__unsafe__"]["bot"];
            if (!isdefined(bot) || !bot isbot()) {
                return false;
            }
        }
        return true;
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0xdc8d5551, Offset: 0x95a8
// Size: 0x1fe
function private utilityscoreescortpathing(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    escorts = plannersquadutility::getblackboardattribute(squad, "escorts");
    escortpoi = plannersquadutility::getblackboardattribute(squad, "escort_poi");
    if (!isdefined(doppelbots) || doppelbots.size <= 0) {
        return true;
    }
    if (!isdefined(escorts) || escorts.size <= 0) {
        return true;
    }
    if (!blackboard::getstructblackboardattribute(commander, "allow_escort")) {
        return false;
    }
    if (_calculateallpathableclients(doppelbots, escorts).size < escorts.size) {
        return false;
    }
    if (isdefined(escortpoi) && escortpoi.size > 0) {
        return false;
    } else {
        assaultgameobjects = blackboard::getstructblackboardattribute(commander, "gameobjects_assault");
        defendgameobjects = blackboard::getstructblackboardattribute(commander, "gameobjects_defend");
        objectives = blackboard::getstructblackboardattribute(commander, "objectives");
        if (assaultgameobjects.size > 0 || defendgameobjects.size > 0 || objectives.size > 0) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x0
// Checksum 0xf782dbd2, Offset: 0x97b0
// Size: 0xb2
function utilityscoreforcegoal(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    squadforcegoal = plannersquadutility::getblackboardattribute(squad, "force_goal");
    forcegoal = blackboard::getstructblackboardattribute(commander, "force_goal");
    if (forcegoal !== squadforcegoal) {
        return false;
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0xff3107a3, Offset: 0x9870
// Size: 0x192
function private utilityscoregameobjectpathing(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    if (!isdefined(doppelbots) || doppelbots.size <= 0) {
        return true;
    }
    foreach (botentry in doppelbots) {
        bot = botentry["__unsafe__"]["bot"];
        if (!isdefined(bot) || !bot isbot()) {
            continue;
        }
        if (isalive(bot) && !bot isingoal(bot.origin) && !bot haspath()) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x220f22da, Offset: 0x9a10
// Size: 0x48e
function private utilityscoregameobjectpriority(commander, squad, constants) {
    priorityidentifiers = constants["priority"];
    if (!isdefined(priorityidentifiers) || priorityidentifiers.size <= 0) {
        return true;
    }
    squadobjects = plannersquadutility::getblackboardattribute(squad, "gameobjects");
    if (isdefined(squadobjects)) {
        prioritygameobjects = _calculateprioritygameobjects(squadobjects, priorityidentifiers);
        if (prioritygameobjects.size > 0) {
            return true;
        }
    }
    assaultobjects = blackboard::getstructblackboardattribute(commander, "gameobjects_assault");
    defendobjects = blackboard::getstructblackboardattribute(commander, "gameobjects_defend");
    activeidentifiers = [];
    currentsquadassignedpriority = 0;
    if (isarray(assaultobjects)) {
        prioritygameobjects = _calculateprioritygameobjects(assaultobjects, priorityidentifiers);
        foreach (gameobjectentry in prioritygameobjects) {
            activeidentifiers[gameobjectentry["identifier"]] = 1;
        }
    }
    if (isarray(defendobjects)) {
        prioritygameobjects = _calculateprioritygameobjects(defendobjects, priorityidentifiers);
        foreach (gameobjectentry in prioritygameobjects) {
            activeidentifiers[gameobjectentry["identifier"]] = 1;
        }
    }
    if (activeidentifiers.size > 0) {
        foreach (currentsquad in commander.squads) {
            if (currentsquad == squad) {
                continue;
            }
            squadobjects = plannersquadutility::getblackboardattribute(currentsquad, "gameobjects");
            if (isdefined(squadobjects)) {
                prioritygameobjects = _calculateprioritygameobjects(squadobjects, priorityidentifiers);
                foreach (gameobjectentry in prioritygameobjects) {
                    activeidentifiers[gameobjectentry["identifier"]] = 0;
                }
            }
        }
    }
    foreach (value in activeidentifiers) {
        if (value) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x4f243ba5, Offset: 0x9ea8
// Size: 0x13a
function private utilityscoregameobjectsvalidity(commander, squad, constants) {
    gameobjects = plannersquadutility::getblackboardattribute(squad, "gameobjects");
    if (!isdefined(gameobjects)) {
        return true;
    }
    foreach (gameobjectentry in gameobjects) {
        gameobject = gameobjectentry["__unsafe__"]["object"];
        if (isdefined(gameobject.trigger) && (!isdefined(gameobject) || !gameobject.trigger istriggerenabled())) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x51028910, Offset: 0x9ff0
// Size: 0x92
function private utilityscorenoescortorgameobject(commander, squad, constants) {
    escorts = plannersquadutility::getblackboardattribute(squad, "escorts");
    gameobjects = plannersquadutility::getblackboardattribute(squad, "gameobjects");
    if (!isdefined(escorts) && !isdefined(gameobjects)) {
        return false;
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0xd0b6efaf, Offset: 0xa090
// Size: 0x24a
function private utilityscoreprogressthrottling(commander, squad, constants) {
    if (blackboard::getstructblackboardattribute(commander, "allow_progress_throttling") === 1) {
        enemycommander = blackboard::getstructblackboardattribute(commander, "throttling_enemy_commander");
        if (!isdefined(enemycommander)) {
            return false;
        }
        lowerbound = blackboard::getstructblackboardattribute(commander, "throttling_lower_bound");
        upperbound = blackboard::getstructblackboardattribute(commander, "throttling_upper_bound");
        destroyedassaults = blackboard::getstructblackboardattribute(commander, "gameobjects_assault_destroyed");
        totalassaults = blackboard::getstructblackboardattribute(commander, "throttling_total_gameobjects");
        if (!isdefined(totalassaults)) {
            totalassaults = blackboard::getstructblackboardattribute(commander, "gameobjects_assault_total");
        }
        enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, "gameobjects_assault_destroyed");
        enemytotalassaults = blackboard::getstructblackboardattribute(commander, "throttling_total_gameobjects_enemy");
        if (!isdefined(enemytotalassaults)) {
            enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, "gameobjects_assault_total");
        }
        order = plannersquadutility::getblackboardattribute(squad, "order");
        if (strategiccommandutility::calculateprogressthrottling(lowerbound, upperbound, destroyedassaults, totalassaults, enemydestroyedassaults, enemytotalassaults)) {
            if (order === "order_attack") {
                return false;
            }
        } else if (order === "order_attack_surround") {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x2025a28d, Offset: 0xa2e8
// Size: 0x12e
function private utilityscoreviableescort(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    escorts = plannersquadutility::getblackboardattribute(squad, "escorts");
    players = blackboard::getstructblackboardattribute(commander, "players");
    if (isdefined(escorts) && escorts.size > 0) {
        return true;
    }
    if (!isdefined(doppelbots) || doppelbots.size <= 0) {
        return true;
    }
    if (!isdefined(players) || players.size <= 0) {
        return true;
    }
    if (_calculateallpathableclients(doppelbots, players).size > 0) {
        return false;
    }
    return true;
}

