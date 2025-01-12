#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_squad;
#using scripts\core_common\ai\strategic_command;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\planner;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;

#namespace planner_commander_utility;

// Namespace planner_commander_utility/planner_commander_utility
// Params 0, eflags: 0x2
// Checksum 0x63b8b15, Offset: 0x490
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"planner_commander_utility", &plannercommanderutility::__init__, undefined, undefined);
}

#namespace plannercommanderutility;

// Namespace plannercommanderutility/planner_commander_utility
// Params 0, eflags: 0x4
// Checksum 0x4bfd74e7, Offset: 0x4d8
// Size: 0x12b4
function private __init__() {
    plannerutility::registerplannerapi(#"hash_3032cc0c39eec160", &function_fc993775);
    plannerutility::registerplannerapi(#"hash_27cb7425e82f36b2", &function_e45fa99f);
    plannerutility::registerplannerapi(#"commanderblackboardvalueistrue", &strategyblackboardvalueistrue);
    plannerutility::registerplannerapi(#"hash_758a5e038102521d", &function_99a7eee);
    plannerutility::registerplannerapi(#"commanderhasatleastxassaultobjects", &strategyhasatleastxassaultobjects);
    plannerutility::registerplannerapi(#"commanderhasatleastxdefendobjects", &strategyhasatleastxdefendobjects);
    plannerutility::registerplannerapi(#"commanderhasatleastxobjectives", &strategyhasatleastxobjectives);
    plannerutility::registerplannerapi(#"commanderhasatleastxplayers", &strategyhasatleastxplayers);
    plannerutility::registerplannerapi(#"commanderhasatleastxpriorityassaultobjects", &strategyhasatleastxpriorityassaultobjects);
    plannerutility::registerplannerapi(#"commanderhasatleastxprioritydefendobjects", &strategyhasatleastxprioritydefendobjects);
    plannerutility::registerplannerapi(#"commanderhasatleastxunassignedbots", &strategyhasatleastxunassignedbots);
    plannerutility::registerplannerapi(#"commanderhasatleastxunclaimedassaultobjects", &strategyhasatleastxunclaimedassaultobjects);
    plannerutility::registerplannerapi(#"commanderhasatleastxunclaimeddefendobjects", &strategyhasatleastxunclaimeddefendobjects);
    plannerutility::registerplannerapi(#"commanderhasatleastxunclaimedpriorityassaultobjects", &strategyhasatleastxunclaimedpriorityassaultobjects);
    plannerutility::registerplannerapi(#"commanderhasatleastxunclaimedprioritydefendobjects", &strategyhasatleastxunclaimedprioritydefendobjects);
    plannerutility::registerplannerapi(#"commanderhasforcegoal", &strategyhasforcegoal);
    plannerutility::registerplannerapi(#"hash_3328412ef57ec24f", &function_71a13dd8);
    plannerutility::registerplannerapi(#"commandershouldrushprogress", &strategyshouldrushprogress);
    plannerutility::registerplannerapi(#"commandershouldthrottleprogress", &strategyshouldthrottleprogress);
    plannerutility::registerplanneraction(#"hash_665ea68c4244269", &function_cee982dd, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_38a4c999135f3595", &function_34051425, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_30d4da4336523524", &function_547c9d94, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_5a63edd39e17c7fa", &function_ee08993c, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderendplan", undefined, undefined, undefined, undefined);
    plannerutility::registerplannerapi(#"commanderincrementblackboardvalue", &strategyincrementblackboardvalue);
    plannerutility::registerplannerapi(#"hash_1e2223a7ca7420d2", &function_fe0f88d9);
    plannerutility::registerplannerapi(#"hash_63fe7d4f2c2b7232", &function_7e124699);
    plannerutility::registerplannerapi(#"commandersetblackboardvalue", &strategysetblackboardvalue);
    plannerutility::registerplannerapi(#"hash_757f8311986da567", &function_6f449666);
    plannerutility::registerplannerapi(#"hash_b0021da8974ba24", &function_9b521767);
    plannerutility::registerplannerapi(#"commandersquadhaspathableescort", &strategysquadhaspathableescort);
    plannerutility::registerplannerapi(#"commandersquadhaspathableobject", &strategysquadhaspathableobject);
    plannerutility::registerplannerapi(#"commandersquadhaspathableobjective", &strategysquadhaspathableobjective);
    plannerutility::registerplannerapi(#"commandersquadhaspathableunclaimedobject", &strategysquadhaspathableunclaimedobject);
    plannerutility::registerplannerapi(#"commandersquadcopyblackboardvalue", &strategysquadcopyblackboardvalue);
    plannerutility::registerplannerapi(#"hash_405fef7ef4724a61", &function_678f7daa);
    plannerutility::registerplannerapi(#"commandersquadsortescortpoi", &strategysquadsortescortpoi);
    plannerutility::registerplanneraction(#"commandersquadassignforcegoal", &strategysquadassignforcegoalparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadassignpathableescort", &strategysquadassignpathableescortparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadassignpathableobject", &strategysquadassignpathableobjectparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadassignpathableobjective", &strategysquadassignpathableobjectiveparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadassignpathableunclaimedobject", &strategysquadassignpathableunclaimedobjectparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_58798fbbe44b7ef0", &function_123fc038, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadassignwander", &strategysquadassignwanderparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_5cd436bbd4c1e857", &function_7ffc79f3, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadcalculatepathableobjectives", &strategysquadcalculatepathableobjectivesparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadcalculatepathableplayers", &strategysquadcalculatepathableplayersparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadclaimobject", &strategysquadclaimobjectparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_544ff9246bf758e2", &function_ba0d4cd4, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"hash_4da9a3c5542078a", &function_24c0462a, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadcreateofsizex", &strategysquadcreateofsizexparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadorder", &strategysquadorderparam, undefined, undefined, undefined);
    plannerutility::registerplannerapi(#"commandersquadescorthasnomainguard", &strategysquadescorthasnomainguard);
    plannerutility::registerplannerapi(#"commandersquadescorthasnorearguard", &strategysquadescorthasnorearguard);
    plannerutility::registerplannerapi(#"commandersquadescorthasnovanguard", &strategysquadescorthasnovanguard);
    plannerutility::registerplanneraction(#"commandersquadescortcalculatepathablepoi", &strategysquadescortcalculatepathablepoiparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadassignmainguard", &strategysquadescortassignmainguardparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadassignrearguard", &strategysquadescortassignrearguardparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commandersquadassignvanguard", &strategysquadescortassignvanguardparam, undefined, undefined, undefined);
    plannerutility::registerplannerapi(#"commanderpathinghascalculatedpaths", &strategypathinghascalculatedpaths);
    plannerutility::registerplannerapi(#"commanderpathinghascalculatedpathablepath", &strategypathinghascalculatedpathablepath);
    plannerutility::registerplannerapi(#"commanderpathinghasnorequestpoints", &strategypathinghasnorequestpoints);
    plannerutility::registerplannerapi(#"commanderpathinghasrequestpoints", &strategypathinghasrequestpoints);
    plannerutility::registerplannerapi(#"commanderpathinghasunprocessedgameobjects", &strategypathinghasunprocessedgameobjects);
    plannerutility::registerplannerapi(#"commanderpathinghasunprocessedobjectives", &strategypathinghasunprocessedobjectives);
    plannerutility::registerplannerapi(#"commanderpathinghasunprocessedrequestpoints", &strategypathinghasunprocessedrequestpoints);
    plannerutility::registerplannerapi(#"commanderpathinghasunreachablepath", &strategypathinghasunreachablepath);
    plannerutility::registerplanneraction(#"commanderpathingaddassaultgameobjects", &strategypathingaddassaultgameobjectsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderpathingadddefendgameobjects", &strategypathingadddefendgameobjectsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderpathingaddobjectives", &strategypathingaddobjectivesparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderpathingaddsquadbots", &strategypathingaddsquadbotsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderpathingaddsquadescorts", &strategypathingaddsquadescortsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderpathingaddtosquadcalculatedgameobjects", &strategypathingaddtosquadcalculatedgameobjectsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderpathingaddtosquadcalculatedobjectives", &strategypathingaddtosquadcalculatedobjectivesparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderpathingcalculatepathtorequestedpoints", &strategypathingcalculatepathtorequestedpointsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderpathingcalculategameobjectrequestpoints", &strategypathingcalculategameobjectrequestpointsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderpathingcalculategameobjectpathability", &strategypathingcalculategameobjectpathabilityparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderpathingcalculateobjectiverequestpoints", &strategypathingcalculateobjectiverequestpointsparam, undefined, undefined, undefined);
    plannerutility::registerplanneraction(#"commanderpathingcalculateobjectivepathability", &strategypathingcalculateobjectivepathabilityparam, undefined, undefined, undefined);
    registerutilityapi("commanderScoreBotChain", &function_f2b8eca9);
    registerutilityapi("commanderScoreBotPresence", &utilityscorebotpresence);
    registerutilityapi("commanderScoreBotVehiclePresence", &function_9e2f025d);
    registerutilityapi("commanderScoreEscortPathing", &utilityscoreescortpathing);
    registerutilityapi("commanderScoreForceGoal", &utilityscoreforcegoal);
    registerutilityapi("commanderScoreGameobjectPathing", &utilityscoregameobjectpathing);
    registerutilityapi("commanderScoreGameobjectPriority", &utilityscoregameobjectpriority);
    registerutilityapi("commanderScoreGameobjectsValidity", &utilityscoregameobjectsvalidity);
    registerutilityapi("commanderScoreNoTarget", &function_596f41f9);
    registerutilityapi("commanderScoreProgressThrottling", &utilityscoreprogressthrottling);
    registerutilityapi("commanderScoreTarget", &function_81dbff50);
    registerutilityapi("commanderScoreTeam", &function_bb9f87ec);
    registerutilityapi("commanderScoreViableEscort", &utilityscoreviableescort);
    registerdaemonapi("daemonClients", &daemonupdateclients);
    registerdaemonapi("daemonGameobjects", &daemonupdategameobjects);
    registerdaemonapi("daemonGameplayBundles", &function_ada1bbe5);
    registerdaemonapi("daemonMissionComponents", &function_f7ef697c);
    registerdaemonapi("daemonObjectives", &daemonupdateobjective);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x86c8a90c, Offset: 0x1798
// Size: 0x188
function private _assignsquadunclaimeddefendgameobjectparam(planner, squadindex) {
    defendobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
    validobjects = [];
    defendobject = undefined;
    foreach (gameobject in defendobjects) {
        if (!gameobject[#"claimed"]) {
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
// Checksum 0x38c5a26, Offset: 0x1928
// Size: 0xe4
function private _assignsquadassaultgameobjectparam(planner, squadindex) {
    assaultobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");
    if (assaultobjects.size > 0) {
        doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
        centroid = _calculatebotscentroid(doppelbots);
        assaultobject = _calculateclosestgameobject(centroid, assaultobjects);
        planner::setblackboardattribute(planner, "gameobjects", array(assaultobject), squadindex);
    }
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x60cbbe60, Offset: 0x1a18
// Size: 0xe4
function private _assignsquaddefendgameobjectparam(planner, squadindex) {
    defendobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
    if (defendobjects.size > 0) {
        doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
        centroid = _calculatebotscentroid(doppelbots);
        defendobject = _calculateclosestgameobject(centroid, defendobjects);
        planner::setblackboardattribute(planner, "gameobjects", array(defendobject), squadindex);
    }
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x9c06612c, Offset: 0x1b08
// Size: 0x22
function private _calculatealliedteams(team) {
    return array(team);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x4141a8a8, Offset: 0x1b38
// Size: 0xe0
function private _calculatebotscentroid(doppelbots) {
    assert(isarray(doppelbots));
    centroid = (0, 0, 0);
    foreach (doppelbot in doppelbots) {
        centroid += doppelbot[#"origin"];
    }
    if (doppelbots.size > 0) {
        return (centroid / doppelbots.size);
    }
    return centroid;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x24a48a9e, Offset: 0x1c20
// Size: 0x146
function private _calculateclosestgameobject(position, gameobjects) {
    assert(isvec(position));
    assert(isarray(gameobjects));
    if (gameobjects.size <= 0) {
        return undefined;
    }
    closest = gameobjects[0];
    distancesq = distancesquared(position, closest[#"origin"]);
    for (index = 1; index < gameobjects.size; index++) {
        newdistancesq = distancesquared(position, gameobjects[index][#"origin"]);
        if (newdistancesq < distancesq) {
            closest = gameobjects[index];
            distancesq = newdistancesq;
        }
    }
    return closest;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xe561e2f3, Offset: 0x1d70
// Size: 0x2da
function private function_adc61b50(doppelbots, components) {
    assert(isarray(doppelbots));
    assert(isarray(components));
    var_59d25210 = array();
    if (doppelbots.size <= 0 || components.size <= 0) {
        return var_59d25210;
    }
    for (componentindex = 0; componentindex < components.size; componentindex++) {
        component = components[componentindex][#"__unsafe__"][#"component"];
        if (!isdefined(component)) {
            continue;
        }
        chained = 0;
        for (botindex = 0; botindex < doppelbots.size; botindex++) {
            bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
            if (!strategiccommandutility::isvalidbot(bot) || !isdefined(bot.var_9b5f4d)) {
                break;
            }
            if (bot isinvehicle()) {
                break;
            }
            foreach (crumb in bot.var_9b5f4d) {
                teaminfo = crumb.var_3395ed1f[bot.team];
                if (!isdefined(teaminfo)) {
                    continue;
                }
                if (component.var_958b8bc5 === teaminfo.var_7053cd41) {
                    chained = 1;
                }
            }
        }
        if (chained) {
            var_e4e47259 = array();
            var_e4e47259[#"component"] = components[componentindex];
            var_59d25210[var_59d25210.size] = var_e4e47259;
        }
    }
    return var_59d25210;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x330fce6c, Offset: 0x2058
// Size: 0x3a4
function private _calculateallpathablegameobjects(planner, doppelbots, gameobjects) {
    assert(isarray(doppelbots));
    assert(isarray(gameobjects));
    pathablegameobjects = [];
    if (gameobjects.size <= 0) {
        return pathablegameobjects;
    }
    if (doppelbots.size <= 0) {
        return pathablegameobjects;
    }
    for (gameobjectindex = 0; gameobjectindex < gameobjects.size; gameobjectindex++) {
        gameobject = gameobjects[gameobjectindex][#"__unsafe__"][#"object"];
        if (!isdefined(gameobject)) {
            continue;
        }
        pathable = 1;
        longestpath = 0;
        for (botindex = 0; botindex < doppelbots.size; botindex++) {
            bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
            if (!strategiccommandutility::isvalidbot(bot)) {
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
            path[#"distance"] = longestpath;
            path[#"gameobject"] = gameobjects[gameobjectindex];
            pathablegameobjects[pathablegameobjects.size] = path;
        }
        if (getrealtime() - planner.planstarttime > planner.maxframetime) {
            var_a72acced = planner.api;
            planner.api = undefined;
            aiprofile_endentry();
            pixendevent();
            aiprofile_endentry();
            pixendevent();
            waitframe(1);
            [[ level.strategic_command_throttle ]]->waitinqueue(planner);
            pixbeginevent(planner.name);
            aiprofile_beginentry(planner.name);
            planner.api = var_a72acced;
            pixbeginevent(var_a72acced);
            aiprofile_beginentry(var_a72acced);
            planner.planstarttime = getrealtime();
        }
    }
    return pathablegameobjects;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x7d4bffcf, Offset: 0x2408
// Size: 0x40c
function private function_f2b71bc3(planner, doppelbots, bundles) {
    assert(isarray(doppelbots));
    assert(isarray(bundles));
    pathablebundles = [];
    if (bundles.size <= 0) {
        return pathablebundles;
    }
    if (doppelbots.size <= 0) {
        return pathablebundles;
    }
    for (bundleindex = 0; bundleindex < bundles.size; bundleindex++) {
        bundle = bundles[bundleindex][#"__unsafe__"][#"bundle"];
        if (!isdefined(bundle)) {
            continue;
        }
        escort = undefined;
        switch (bundle.m_str_type) {
        case #"escortbiped":
            escort = bundle.var_f09fedbb;
            break;
        default:
            break;
        }
        if (!isdefined(escort)) {
            continue;
        }
        pathable = 1;
        longestpath = 0;
        for (botindex = 0; botindex < doppelbots.size; botindex++) {
            bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
            if (!strategiccommandutility::isvalidbot(bot)) {
                pathable = 0;
                break;
            }
            path = strategiccommandutility::calculatepathtoposition(bot, escort.origin);
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
            path[#"distance"] = longestpath;
            path[#"bundle"] = bundles[bundleindex];
            pathablebundles[pathablebundles.size] = path;
        }
        if (getrealtime() - planner.planstarttime > planner.maxframetime) {
            var_a72acced = planner.api;
            planner.api = undefined;
            aiprofile_endentry();
            pixendevent();
            aiprofile_endentry();
            pixendevent();
            waitframe(1);
            [[ level.strategic_command_throttle ]]->waitinqueue(planner);
            pixbeginevent(planner.name);
            aiprofile_beginentry(planner.name);
            planner.api = var_a72acced;
            pixbeginevent(var_a72acced);
            aiprofile_beginentry(var_a72acced);
            planner.planstarttime = getrealtime();
        }
    }
    return pathablebundles;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x8670f26, Offset: 0x2820
// Size: 0x52c
function private function_b588943c(planner, doppelbots, components) {
    assert(isarray(doppelbots));
    assert(isarray(components));
    pathablecomponents = [];
    if (components.size <= 0) {
        return pathablecomponents;
    }
    if (doppelbots.size <= 0) {
        return pathablecomponents;
    }
    var_b93ef44b = 0;
    for (botindex = 0; botindex < doppelbots.size; botindex++) {
        if (doppelbots[botindex][#"type"] == "air") {
            var_b93ef44b = 1;
            break;
        }
    }
    var_7dcd64b2 = 0;
    for (botindex = 0; botindex < doppelbots.size; botindex++) {
        if (doppelbots[botindex][#"type"] == "ground") {
            var_7dcd64b2 = 1;
            break;
        }
    }
    for (componentindex = 0; componentindex < components.size; componentindex++) {
        component = components[componentindex][#"__unsafe__"][#"component"];
        if (!isdefined(component)) {
            continue;
        }
        trigger = undefined;
        switch (component.m_str_type) {
        case #"goto":
            break;
        case #"destroy":
        case #"defend":
            trigger = var_b93ef44b ? component.var_2b8386bb : component.var_d9c3be3e;
            break;
        case #"capturearea":
            trigger = component.var_5065689f;
            break;
        default:
            break;
        }
        if (!isdefined(trigger)) {
            continue;
        }
        pathable = 1;
        longestpath = 0;
        for (botindex = 0; botindex < doppelbots.size; botindex++) {
            bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
            if (!strategiccommandutility::isvalidbot(bot)) {
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
            path[#"distance"] = longestpath;
            path[#"objective"] = components[componentindex];
            pathablecomponents[pathablecomponents.size] = path;
        }
        if (getrealtime() - planner.planstarttime > planner.maxframetime) {
            var_a72acced = planner.api;
            planner.api = undefined;
            aiprofile_endentry();
            pixendevent();
            aiprofile_endentry();
            pixendevent();
            waitframe(1);
            [[ level.strategic_command_throttle ]]->waitinqueue(planner);
            pixbeginevent(planner.name);
            aiprofile_beginentry(planner.name);
            planner.api = var_a72acced;
            pixbeginevent(var_a72acced);
            aiprofile_beginentry(var_a72acced);
            planner.planstarttime = getrealtime();
        }
    }
    return pathablecomponents;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x6c3a47b1, Offset: 0x2d58
// Size: 0x34a
function private function_d9293ee1(doppelbots, entities) {
    assert(isarray(doppelbots));
    assert(isarray(entities));
    var_393a7ea1 = [];
    if (entities.size <= 0) {
        return var_393a7ea1;
    }
    if (doppelbots.size <= 0) {
        return var_393a7ea1;
    }
    for (entityindex = 0; entityindex < entities.size; entityindex++) {
        entity = entities[entityindex][#"__unsafe__"][#"entity"];
        if (!isdefined(entity)) {
            continue;
        }
        var_415df451 = getclosestpointonnavmesh(entity.origin, 200);
        pathable = 1;
        longestpath = 0;
        for (botindex = 0; botindex < doppelbots.size; botindex++) {
            bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
            position = getclosestpointonnavmesh(bot.origin, 120, bot getpathfindingradius() * 1.05);
            if (!isdefined(position) || !isdefined(var_415df451)) {
                pathable = 0;
                break;
            }
            if (!strategiccommandutility::isvalidbot(bot)) {
                pathable = 0;
                break;
            }
            queryresult = positionquery_source_navigation(var_415df451, 0, 120, 60, 16, bot, 16);
            if (queryresult.data.size > 0) {
                path = _calculatepositionquerypath(queryresult, position, bot);
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
            path[#"distance"] = longestpath;
            path[#"entity"] = entities[entityindex];
            var_393a7ea1[var_393a7ea1.size] = path;
        }
    }
    return var_393a7ea1;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x66121542, Offset: 0x30b0
// Size: 0x26a
function private _calculateallpathableobjectives(doppelbots, objectives) {
    assert(isarray(doppelbots));
    assert(isarray(objectives));
    pathableobjectives = [];
    if (objectives.size <= 0) {
        return pathableobjectives;
    }
    if (doppelbots.size <= 0) {
        return pathableobjectives;
    }
    for (objectiveindex = 0; objectiveindex < objectives.size; objectiveindex++) {
        trigger = objectives[objectiveindex][#"__unsafe__"][#"trigger"];
        if (!isdefined(trigger)) {
            continue;
        }
        pathable = 1;
        longestpath = 0;
        for (botindex = 0; botindex < doppelbots.size; botindex++) {
            bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
            if (!strategiccommandutility::isvalidbot(bot)) {
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
            path[#"distance"] = longestpath;
            path[#"objective"] = objectives[objectiveindex];
            pathableobjectives[pathableobjectives.size] = path;
        }
    }
    return pathableobjectives;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x8632f6e5, Offset: 0x3328
// Size: 0x3da
function private _calculateallpathableclients(doppelbots, clients) {
    assert(isarray(doppelbots));
    assert(isarray(clients));
    pathableclients = [];
    if (clients.size <= 0) {
        return pathableclients;
    }
    if (doppelbots.size <= 0) {
        return pathableclients;
    }
    for (clientindex = 0; clientindex < clients.size; clientindex++) {
        player = clients[clientindex][#"__unsafe__"][#"player"];
        if (!isdefined(player) || player isinmovemode("ufo", "noclip") || player.sessionstate !== "playing") {
            continue;
        }
        var_e47dcd71 = strategiccommandutility::function_d5770bb4(player);
        clientposition = getclosestpointonnavmesh(player.origin, 200);
        pathable = 1;
        longestpath = 0;
        for (botindex = 0; botindex < doppelbots.size; botindex++) {
            bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
            if (!strategiccommandutility::isvalidbot(bot)) {
                pathable = 0;
                break;
            }
            var_1c9d709f = strategiccommandutility::function_d5770bb4(bot);
            if (var_1c9d709f != var_e47dcd71) {
                pathable = 0;
                break;
            }
            position = getclosestpointonnavmesh(bot.origin, 120, bot getpathfindingradius() * 1.05);
            if (!isdefined(position) || !isdefined(clientposition)) {
                pathable = 0;
                break;
            }
            queryresult = positionquery_source_navigation(clientposition, 0, 120, 60, 16, bot, 16);
            if (queryresult.data.size > 0) {
                path = _calculatepositionquerypath(queryresult, position, bot);
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
            path[#"distance"] = longestpath;
            path[#"player"] = clients[clientindex];
            pathableclients[pathableclients.size] = path;
        }
    }
    return pathableclients;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x427a1fde, Offset: 0x3710
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

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x6a077892, Offset: 0x3890
// Size: 0x12e
function private _calculateprioritygameobjects(gameobjects, prioritygameobjectidentifiers) {
    prioritygameobjects = [];
    foreach (gameobjectentry in gameobjects) {
        identifier = gameobjectentry[#"identifier"];
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
// Checksum 0x5f966fa7, Offset: 0x39c8
// Size: 0x1dc
function private _updatehistoricalgameobjects(commander) {
    destroyedgameobjecttotal = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault_destroyed");
    assaultobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault");
    gameobjecttotal = 0;
    if (isarray(assaultobjects)) {
        foreach (assaultobjectentry in assaultobjects) {
            if (!isdefined(assaultobjectentry)) {
                continue;
            }
            if (assaultobjectentry[#"identifier"] === "carry_object") {
                continue;
            }
            gameobject = assaultobjectentry[#"__unsafe__"][#"object"];
            if (!isdefined(gameobject) || !isdefined(gameobject.trigger) || !gameobject.trigger istriggerenabled()) {
                destroyedgameobjecttotal++;
                continue;
            }
            gameobjecttotal++;
        }
    }
    gameobjecttotal += destroyedgameobjecttotal;
    blackboard::setstructblackboardattribute(commander, #"gameobjects_assault_destroyed", destroyedgameobjecttotal);
    blackboard::setstructblackboardattribute(commander, #"gameobjects_assault_total", gameobjecttotal);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0xc342f671, Offset: 0x3bb0
// Size: 0x46c
function private daemonupdateclients(commander) {
    team = blackboard::getstructblackboardattribute(commander, #"team");
    clients = getplayers(team);
    doppelbots = [];
    players = [];
    vehicles = [];
    foreach (client in clients) {
        cachedclient = array();
        cachedclient[#"origin"] = client.origin;
        cachedclient[#"entnum"] = client getentitynumber();
        cachedclient[#"escortmainguard"] = array();
        cachedclient[#"escortrearguard"] = array();
        cachedclient[#"escortvanguard"] = array();
        if (strategiccommandutility::isvalidbot(client)) {
            if (!isdefined(cachedclient[#"__unsafe__"])) {
                cachedclient[#"__unsafe__"] = array();
            }
            cachedclient[#"__unsafe__"][#"bot"] = client;
            if (client isinvehicle()) {
                if (strategiccommandutility::function_fe34c4b4(client)) {
                    vehicle = client getvehicleoccupied();
                    if (!isdefined(cachedclient[#"__unsafe__"])) {
                        cachedclient[#"__unsafe__"] = array();
                    }
                    cachedclient[#"__unsafe__"][#"vehicle"] = vehicle;
                    cachedclient[#"type"] = strategiccommandutility::function_8d3bd065(vehicle);
                    vehicles[vehicles.size] = cachedclient;
                }
            } else {
                cachedclient[#"type"] = "bot";
                doppelbots[doppelbots.size] = cachedclient;
            }
            continue;
        }
        if (strategiccommandutility::isvalidplayer(client)) {
            if (!isdefined(cachedclient[#"__unsafe__"])) {
                cachedclient[#"__unsafe__"] = array();
            }
            cachedclient[#"__unsafe__"][#"player"] = client;
            players[players.size] = cachedclient;
        }
    }
    blackboard::setstructblackboardattribute(commander, #"bot_vehicles", vehicles);
    blackboard::setstructblackboardattribute(commander, #"doppelbots", doppelbots);
    blackboard::setstructblackboardattribute(commander, #"players", players);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x4ec4b502, Offset: 0x4028
// Size: 0x6d4
function private daemonupdategameobjects(commander) {
    if (isdefined(level.a_gameobjects)) {
        commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
        var_d19899a0 = strategiccommandutility::function_d4dcfc8e(commanderteam);
        var_a7e2c93f = tolower(var_d19899a0);
        gameobjects = array();
        var_e7bda876 = arraycopy(level.a_gameobjects);
        var_61d215df = array();
        excluded = blackboard::getstructblackboardattribute(commander, #"gameobjects_exclude");
        excludedmap = array();
        foreach (excludename in excluded) {
            excludedmap[excludename] = 1;
        }
        restrict = blackboard::getstructblackboardattribute(commander, #"gameobjects_restrict");
        var_89fbc755 = array();
        foreach (var_8f5f76fc in restrict) {
            var_89fbc755[var_8f5f76fc] = 1;
        }
        for (gameobjectindex = 0; gameobjectindex < var_e7bda876.size; gameobjectindex++) {
            gameobject = var_e7bda876[gameobjectindex];
            if (!isdefined(gameobject) || !isdefined(gameobject.trigger)) {
                continue;
            }
            if (gameobject.type === "GenericObject") {
                continue;
            }
            if (!gameobject.trigger istriggerenabled()) {
                continue;
            }
            if (!(gameobject.team == commanderteam || gameobject.team == var_a7e2c93f || gameobject.absolute_visible_and_interact_team === commanderteam || gameobject.team == #"free")) {
                continue;
            }
            identifier = gameobject gameobjects::get_identifier();
            if (var_89fbc755.size > 0) {
                if (!isdefined(identifier) || !isdefined(var_89fbc755[identifier])) {
                    continue;
                }
            }
            if (isdefined(identifier) && isdefined(excludedmap[identifier])) {
                continue;
            }
            if (isdefined(gameobject.var_ac8552f4)) {
                continue;
            }
            cachedgameobject = array();
            cachedgameobject[#"strategy"] = strategiccommandutility::function_e9bbf61c(var_a7e2c93f, undefined, undefined, gameobject);
            if (strategiccommandutility::function_81fe17e9(cachedgameobject[#"strategy"])) {
                continue;
            }
            cachedgameobject[#"claimed"] = 0;
            cachedgameobject[#"type"] = "gameobject";
            if (!isdefined(cachedgameobject[#"__unsafe__"])) {
                cachedgameobject[#"__unsafe__"] = array();
            }
            cachedgameobject[#"__unsafe__"][#"object"] = gameobject;
            if (!isdefined(cachedgameobject[#"__unsafe__"])) {
                cachedgameobject[#"__unsafe__"] = array();
            }
            cachedgameobject[#"__unsafe__"][#"entity"] = gameobject.e_object;
            if (isdefined(identifier) && (identifier == "air_vehicle" || identifier == "ground_vehicle")) {
                var_61d215df[var_61d215df.size] = cachedgameobject;
            } else {
                gameobjects[gameobjects.size] = cachedgameobject;
            }
            if (getrealtime() - commander.var_d602d17c > commander.var_48f45ba7) {
                aiprofile_endentry();
                pixendevent();
                [[ level.strategic_command_throttle ]]->waitinqueue(commander);
                commander.var_d602d17c = getrealtime();
                pixbeginevent("daemonGameobjects");
                aiprofile_beginentry("daemonGameobjects");
            }
        }
        blackboard::setstructblackboardattribute(commander, #"gameobjects", gameobjects);
        blackboard::setstructblackboardattribute(commander, #"gameobjects_vehicles", var_61d215df);
    }
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x21731f11, Offset: 0x4708
// Size: 0x364
function private function_ada1bbe5(commander) {
    if (isdefined(level.var_e426a9cd)) {
        commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
        var_d19899a0 = strategiccommandutility::function_d4dcfc8e(commanderteam);
        var_a7e2c93f = tolower(var_d19899a0);
        bundles = array();
        foreach (gameplay in level.var_e426a9cd) {
            if (!strategiccommandutility::function_8c503eb0(gameplay, var_d19899a0)) {
                continue;
            }
            gpbundle = gameplay.o_gpbundle;
            type = gameplay.classname;
            var_2d2d6c6e = array();
            switch (type) {
            case #"hash_1c67b29f3576b10d":
                var_2d2d6c6e[#"type"] = "escortbiped";
                break;
            default:
                continue;
            }
            var_2d2d6c6e[#"strategy"] = strategiccommandutility::function_e9bbf61c(var_a7e2c93f, gpbundle.m_s_bundle);
            if (!isdefined(var_2d2d6c6e[#"__unsafe__"])) {
                var_2d2d6c6e[#"__unsafe__"] = array();
            }
            var_2d2d6c6e[#"__unsafe__"][#"bundle"] = gpbundle;
            bundles[bundles.size] = var_2d2d6c6e;
            if (getrealtime() - commander.var_d602d17c > commander.var_48f45ba7) {
                aiprofile_endentry();
                pixendevent();
                [[ level.strategic_command_throttle ]]->waitinqueue(commander);
                commander.var_d602d17c = getrealtime();
                pixbeginevent("daemonMissionComponents");
                aiprofile_beginentry("daemonMissionComponents");
            }
        }
        blackboard::setstructblackboardattribute(commander, #"gpbundles", bundles);
    }
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x4c5d6afc, Offset: 0x4a78
// Size: 0x688
function private function_f7ef697c(commander) {
    if (isdefined(level.var_76ffb58b) && level flagsys::get(#"hash_3a3d68ab491e1985")) {
        commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
        var_d19899a0 = strategiccommandutility::function_d4dcfc8e(commanderteam);
        var_a7e2c93f = tolower(var_d19899a0);
        components = array();
        var_3b104821 = array();
        var_3b104821[#"hash_f5c6c6aa7dc0f6d"] = array();
        var_3b104821[#"hash_6e9081699001bcd9"] = array();
        var_3b104821[#"hash_3bf68fbcb5c53b6c"] = array();
        var_3b104821[#"hash_4984fd4b0ba666a2"] = array();
        foreach (missioncomponent in level.var_76ffb58b) {
            if (!strategiccommandutility::function_ee65cade(missioncomponent, commanderteam)) {
                continue;
            }
            component = missioncomponent.var_a06b4dbd;
            type = missioncomponent.scriptbundlename;
            var_f6c3b9fc = array();
            switch (type) {
            case #"hash_f5c6c6aa7dc0f6d":
                var_f6c3b9fc[#"type"] = "defend";
                break;
            case #"hash_6e9081699001bcd9":
                var_f6c3b9fc[#"type"] = "destroy";
                break;
            case #"hash_3bf68fbcb5c53b6c":
                var_f6c3b9fc[#"type"] = "capturearea";
                break;
            case #"hash_4984fd4b0ba666a2":
                if (isdefined(component.var_97666a87) || isdefined(component.var_b65fc035)) {
                    var_f6c3b9fc[#"type"] = "goto";
                } else {
                    println("<dev string:x30>" + missioncomponent.origin + "<dev string:x53>");
                    continue;
                }
                break;
            default:
                continue;
            }
            var_f6c3b9fc[#"strategy"] = strategiccommandutility::function_e9bbf61c(var_a7e2c93f, undefined, missioncomponent);
            if (strategiccommandutility::function_81fe17e9(var_f6c3b9fc[#"strategy"])) {
                continue;
            }
            if (!isdefined(var_f6c3b9fc[#"__unsafe__"])) {
                var_f6c3b9fc[#"__unsafe__"] = array();
            }
            var_f6c3b9fc[#"__unsafe__"][#"mission_component"] = missioncomponent;
            if (!isdefined(var_f6c3b9fc[#"__unsafe__"])) {
                var_f6c3b9fc[#"__unsafe__"] = array();
            }
            var_f6c3b9fc[#"__unsafe__"][#"component"] = component;
            components[components.size] = var_f6c3b9fc;
            arraysize = var_3b104821[type].size;
            var_3b104821[type][arraysize] = var_f6c3b9fc;
            if (getrealtime() - commander.var_d602d17c > commander.var_48f45ba7) {
                aiprofile_endentry();
                pixendevent();
                [[ level.strategic_command_throttle ]]->waitinqueue(commander);
                commander.var_d602d17c = getrealtime();
                pixbeginevent("daemonMissionComponents");
                aiprofile_beginentry("daemonMissionComponents");
            }
        }
        blackboard::setstructblackboardattribute(commander, #"missioncomponents", components);
        foreach (componenttype, componentarray in var_3b104821) {
            blackboard::setstructblackboardattribute(commander, componenttype, componentarray);
        }
    }
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x9dc00026, Offset: 0x5108
// Size: 0x794
function private daemonupdateobjective(commander) {
    if (isdefined(level.a_objectives)) {
        commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
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
                        cachedobjective[#"entnum"] = playerentitynumber;
                        cachedobjective[#"id"] = objectiveid;
                        cachedobjective[#"origin"] = objective_position(objectiveid);
                        if (!isdefined(cachedobjective[#"__unsafe__"])) {
                            cachedobjective[#"__unsafe__"] = array();
                        }
                        cachedobjective[#"__unsafe__"][#"trigger"] = undefined;
                        if (isdefined(player.a_t_breadcrumbs)) {
                            cachedobjective[#"breadcrumbs"] = player.a_t_breadcrumbs.size;
                            for (index = 0; index < player.a_t_breadcrumbs.size; index++) {
                                if (player.t_current_active_breadcrumb == player.a_t_breadcrumbs[index]) {
                                    cachedobjective[#"currentbreadcrumb"] = index;
                                    cachedobjective[#"triggermax"] = player.t_current_active_breadcrumb.maxs;
                                    cachedobjective[#"triggermin"] = player.t_current_active_breadcrumb.mins;
                                    cachedobjective[#"radius"] = player.t_current_active_breadcrumb.radius;
                                    if (!isdefined(cachedobjective[#"__unsafe__"])) {
                                        cachedobjective[#"__unsafe__"] = array();
                                    }
                                    cachedobjective[#"__unsafe__"][#"trigger"] = player.t_current_active_breadcrumb;
                                    break;
                                }
                            }
                        } else {
                            cachedobjective[#"breadcrumbs"] = 0;
                            cachedobjective[#"currentbreadcrumb"] = 0;
                        }
                        if (currentbreadcrumb <= cachedobjective[#"currentbreadcrumb"]) {
                            currentbreadcrumb = cachedobjective[#"currentbreadcrumb"];
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
                            if (isdefined(target) && (isstruct(target) || isentity(target)) && isdefined(target.origin)) {
                                cachedobjective = array();
                                cachedobjective[#"id"] = objectiveid;
                                cachedobjective[#"origin"] = target.origin;
                                if (!isdefined(cachedobjective[#"__unsafe__"])) {
                                    cachedobjective[#"__unsafe__"] = array();
                                }
                                cachedobjective[#"__unsafe__"][#"trigger"] = undefined;
                            }
                        }
                    }
                }
            }
        }
        blackboard::setstructblackboardattribute(commander, #"objectives", objectives);
    }
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x2b8078dc, Offset: 0x58a8
// Size: 0xf6
function function_fc993775(planner, constants) {
    assert(isstring(constants[#"key"]) || ishash(constants[#"key"]), "<dev string:x70>" + "<invalid>" + "<dev string:xba>");
    attribute = planner::getblackboardattribute(planner, constants[#"key"]);
    if (isdefined(attribute) && isarray(attribute)) {
        return (attribute.size > 0);
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x39eb587b, Offset: 0x59a8
// Size: 0xbc
function private function_e45fa99f(planner, constants) {
    assert(isstring(constants[#"key"]) || ishash(constants[#"key"]), "<dev string:x70>" + "<invalid>" + "<dev string:xba>");
    return isdefined(planner::getblackboardattribute(planner, constants[#"key"]));
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xa5222d17, Offset: 0x5a70
// Size: 0xc0
function private strategyblackboardvalueistrue(planner, constants) {
    assert(isstring(constants[#"key"]) || ishash(constants[#"key"]), "<dev string:x70>" + "<invalid>" + "<dev string:xba>");
    return planner::getblackboardattribute(planner, constants[#"key"]) == 1;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x533fa225, Offset: 0x5b38
// Size: 0x20e
function private function_99a7eee(planner, constants) {
    assert(isstring(constants[#"focus"]) || ishash(constants[#"focus"]), "<dev string:x70>" + "<invalid>" + "<dev string:xba>");
    target = planner::getblackboardattribute(planner, #"current_target");
    assert(isdefined(target));
    if (!isdefined(target)) {
        return false;
    }
    strategy = target[#"strategy"];
    assert(isstruct(strategy));
    if (!isstruct(strategy)) {
        return false;
    }
    var_e8483153 = strategiccommandutility::function_be0f2866(constants[#"focus"]);
    targetfocus = strategy.("doppelbotsfocus");
    foreach (focus in var_e8483153) {
        if (targetfocus == focus) {
            return true;
        }
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xd0f5e80d, Offset: 0x5d50
// Size: 0x242
function private function_cee982dd(planner, constant) {
    planner::setblackboardattribute(planner, #"current_target", undefined);
    targets = planner::getblackboardattribute(planner, #"targets");
    assert(isarray(targets));
    if (!isarray(targets)) {
        return spawnstruct();
    }
    priorities = array(#"hash_179ccf9d7cfd1e31", #"hash_254689c549346d57", #"hash_4bd86f050b36e1f6", #"hash_19c0ac460bdb9928", #"hash_160b01bbcd78c723", #"hash_c045a5aa4ac7c1d", #"hash_47fd3da20e90cd01", #"hash_64fc5c612a94639c", #"(-4) unimportant");
    assert(isarray(priorities));
    foreach (priority in priorities) {
        if (targets[priority].size > 0) {
            planner::setblackboardattribute(planner, #"current_target", targets[priority][0]);
            break;
        }
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xdc3ef2ef, Offset: 0x5fa0
// Size: 0x5aa
function private function_34051425(planner, constant) {
    target = planner::getblackboardattribute(planner, #"current_target");
    validsquads = planner::getblackboardattribute(planner, #"valid_squads");
    if (getdvarint(#"hash_6cad7fcde98d23ee", 0)) {
        var_b545aa99 = array();
        if (!isdefined(target) || !isarray(validsquads) || validsquads.size <= 0) {
            planner::setblackboardattribute(planner, #"hash_1a25f2c4feaf60cf", var_b545aa99);
            return spawnstruct();
        }
        gameobject = target[#"__unsafe__"][#"object"];
        if (isdefined(gameobject)) {
            foreach (squad in validsquads) {
                pathablegameobjects = _calculateallpathablegameobjects(planner, squad, array(target));
                if (pathablegameobjects.size > 0) {
                    var_f5bb0966 = array();
                    var_f5bb0966[#"squad"] = squad;
                    var_f5bb0966[#"pathablegameobjects"] = pathablegameobjects;
                    var_b545aa99[var_b545aa99.size] = var_f5bb0966;
                }
            }
        }
        component = target[#"__unsafe__"][#"component"];
        if (isdefined(component)) {
            foreach (squad in validsquads) {
                pathablecomponents = function_b588943c(planner, squad, array(target));
                if (pathablecomponents.size > 0) {
                    var_f5bb0966 = array();
                    var_f5bb0966[#"squad"] = squad;
                    var_f5bb0966[#"pathablecomponents"] = pathablecomponents;
                    var_b545aa99[var_b545aa99.size] = var_f5bb0966;
                }
            }
        }
        bundle = target[#"__unsafe__"][#"bundle"];
        if (isdefined(bundle)) {
            foreach (squad in validsquads) {
                pathablebundles = function_f2b71bc3(planner, squad, array(target));
                if (pathablebundles.size > 0) {
                    var_f5bb0966 = array();
                    var_f5bb0966[#"squad"] = squad;
                    var_f5bb0966[#"pathablebundles"] = pathablebundles;
                    var_b545aa99[var_b545aa99.size] = var_f5bb0966;
                }
            }
        }
        planner::setblackboardattribute(planner, #"hash_1a25f2c4feaf60cf", var_b545aa99);
    } else {
        var_b545aa99 = array();
        foreach (squad in validsquads) {
            var_f5bb0966 = array();
            var_f5bb0966[#"squad"] = squad;
            var_b545aa99[var_b545aa99.size] = var_f5bb0966;
        }
        planner::setblackboardattribute(planner, #"hash_1a25f2c4feaf60cf", var_b545aa99);
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x86fa1e81, Offset: 0x6558
// Size: 0x472
function private function_547c9d94(planner, constant) {
    possiblesquads = planner::getblackboardattribute(planner, #"possible_squads");
    target = planner::getblackboardattribute(planner, #"current_target");
    var_ccdac8cb = 0;
    if (target[#"type"] == "gameobject") {
        object = target[#"__unsafe__"][#"object"];
        if (isdefined(object) && isarray(object.keyobject) && object.keyobject.size > 0) {
            var_ccdac8cb = 1;
        }
    }
    players = planner::getblackboardattribute(planner, #"players");
    hasplayers = players.size > 0;
    var_a783bfd0 = !hasplayers || target[#"strategy"].("doppelbotsinteractions") == #"first come first served";
    var_6c07bf8b = !hasplayers || target[#"strategy"].("companionsinteractions") == #"first come first served";
    airvehicles = strategiccommandutility::function_e83d46e6(target[#"strategy"]);
    groundvehicles = strategiccommandutility::function_5306537b(target[#"strategy"]);
    var_7cfe5e9e = groundvehicles;
    validsquads = [];
    foreach (squad in possiblesquads) {
        foreach (member in squad) {
            bot = member[#"__unsafe__"][#"bot"];
            if (!isdefined(bot)) {
                break;
            }
            if (!var_a783bfd0) {
                continue;
            }
            if (var_ccdac8cb && !bot gameobjects::has_key_object(object)) {
                continue;
            }
            if (airvehicles && member[#"type"] == "air") {
                validsquads[validsquads.size] = squad;
                break;
            }
            if (groundvehicles && member[#"type"] == "ground") {
                validsquads[validsquads.size] = squad;
                break;
            }
            if (var_7cfe5e9e && member[#"type"] == "bot") {
                validsquads[validsquads.size] = squad;
                break;
            }
        }
    }
    planner::setblackboardattribute(planner, #"valid_squads", validsquads);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x66cba8c7, Offset: 0x69d8
// Size: 0x2aa
function private function_ee08993c(planner, constant) {
    target = planner::getblackboardattribute(planner, #"current_target");
    assert(isdefined(target));
    if (!isdefined(target)) {
        return spawnstruct();
    }
    strategy = target[#"strategy"];
    assert(isstruct(strategy));
    if (!isstruct(strategy)) {
        return spawnstruct();
    }
    distribution = strategy.("doppelbotsdistribution");
    priority = strategy.("doppelbotspriority");
    targets = planner::getblackboardattribute(planner, #"targets");
    assert(isarray(targets));
    if (!isarray(targets)) {
        return spawnstruct();
    }
    switch (distribution) {
    case #"evenly":
        arrayremoveindex(targets[priority], 0);
        targets[priority][targets.size] = target;
        break;
    case #"greedy":
        break;
    case #"uniquely":
        arrayremoveindex(targets[priority], 0);
        break;
    default:
        assert(0);
        break;
    }
    planner::setblackboardattribute(planner, #"targets", targets);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x6299e1ab, Offset: 0x6c90
// Size: 0x2b2
function private function_7ffc79f3(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    target = planner::getblackboardattribute(planner, "target", squadindex);
    bundle = target[#"__unsafe__"][#"bundle"];
    if (!isdefined(bundle)) {
        return spawnstruct();
    }
    team = planner::getblackboardattribute(planner, #"team");
    if (!strategiccommandutility::function_db159321(bundle, team)) {
        return spawnstruct();
    }
    switch (bundle.m_str_type) {
    case #"escortbiped":
        entity = bundle.var_f09fedbb;
        break;
    }
    if (!isdefined(entity)) {
        return spawnstruct();
    }
    var_e8b57df4 = [];
    if (!isdefined(var_e8b57df4[#"__unsafe__"])) {
        var_e8b57df4[#"__unsafe__"] = array();
    }
    var_e8b57df4[#"__unsafe__"][#"entity"] = entity;
    entities = array(var_e8b57df4);
    pathableescorts = function_d9293ee1(doppelbots, entities);
    planner::setblackboardattribute(planner, "pathable_escorts", pathableescorts, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xf81d00b8, Offset: 0x6f50
// Size: 0x10a
function private strategysquadcalculatepathableobjectivesparam(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    objectives = planner::getblackboardattribute(planner, #"objectives");
    pathableobjectives = _calculateallpathableobjectives(doppelbots, objectives);
    planner::setblackboardattribute(planner, "pathable_objectives", pathableobjectives, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xa88e4730, Offset: 0x7068
// Size: 0x10a
function private strategysquadcalculatepathableplayersparam(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    players = planner::getblackboardattribute(planner, #"players");
    pathableescorts = _calculateallpathableclients(doppelbots, players);
    planner::setblackboardattribute(planner, "pathable_escorts", pathableescorts, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x1f2d434f, Offset: 0x7180
// Size: 0xf4
function private strategyincrementblackboardvalue(planner, constants) {
    assert(isarray(constants));
    assert(isstring(constants[#"name"]) || ishash(constants[#"name"]));
    planner::setblackboardattribute(planner, constants[#"name"], planner::getblackboardattribute(planner, constants[#"name"]) + 1);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xa3be0d08, Offset: 0x7280
// Size: 0x354
function private function_fe0f88d9(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex > 0, "<dev string:x1d3>");
    currentsquad = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    possiblesquads = planner::getblackboardattribute(planner, #"possible_squads");
    for (i = 0; i < possiblesquads.size; i++) {
        var_1f1fc245 = 1;
        foreach (possiblemember in possiblesquads[i]) {
            var_ed954c2f = 0;
            foreach (currentmember in currentsquad) {
                if (possiblemember[#"entnum"] == currentmember[#"entnum"]) {
                    var_ed954c2f = 1;
                    break;
                }
            }
            if (!var_ed954c2f) {
                var_1f1fc245 = 0;
                break;
            }
        }
        if (var_1f1fc245) {
            arrayremoveindex(possiblesquads, i);
            break;
        }
    }
    planner::setblackboardattribute(planner, #"possible_squads", possiblesquads);
    idlebots = array();
    for (squadindex = 0; squadindex < possiblesquads.size; squadindex++) {
        squad = possiblesquads[squadindex];
        for (memberindex = 0; memberindex < squad.size; memberindex++) {
            idlebots[idlebots.size] = squad[memberindex];
        }
    }
    /#
        var_b33f0012 = planner::getblackboardattribute(planner, #"idle_doppelbots").size;
        assert(var_b33f0012 > idlebots.size, "<dev string:x212>");
    #/
    planner::setblackboardattribute(planner, #"idle_doppelbots", idlebots);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x795f393a, Offset: 0x75e0
// Size: 0x1c4
function private function_7e124699(planner, constants) {
    targets = planner::getblackboardattribute(planner, #"targets");
    priorities = array(#"hash_179ccf9d7cfd1e31", #"hash_254689c549346d57", #"hash_4bd86f050b36e1f6", #"hash_19c0ac460bdb9928", #"hash_160b01bbcd78c723", #"hash_c045a5aa4ac7c1d", #"hash_47fd3da20e90cd01", #"hash_64fc5c612a94639c", #"(-4) unimportant");
    assert(isarray(priorities));
    foreach (priority in priorities) {
        if (targets[priority].size > 0) {
            arrayremoveindex(targets[priority], 0);
            break;
        }
    }
    planner::setblackboardattribute(planner, #"targets", targets);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x76578154, Offset: 0x77b0
// Size: 0xdc
function private strategysetblackboardvalue(planner, constants) {
    assert(isarray(constants));
    assert(isstring(constants[#"name"]) || ishash(constants[#"name"]));
    planner::setblackboardattribute(planner, constants[#"name"], constants[#"value"]);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x5c291a6f, Offset: 0x7898
// Size: 0xe4
function private function_6f449666(planner, constants) {
    assert(isarray(constants));
    assert(isstring(constants[#"name"]) || ishash(constants[#"name"]));
    planner::setblackboardattribute(planner, constants[#"name"], array());
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xdafae11f, Offset: 0x7988
// Size: 0x1de
function private strategyshouldrushprogress(planner, constant) {
    if (planner::getblackboardattribute(planner, #"allow_progress_throttling") === 1) {
        enemycommander = planner::getblackboardattribute(planner, #"throttling_enemy_commander");
        if (!isdefined(enemycommander)) {
            return 0;
        }
        lowerbound = planner::getblackboardattribute(planner, #"throttling_lower_bound");
        upperbound = planner::getblackboardattribute(planner, #"throttling_upper_bound");
        destroyedassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_destroyed");
        totalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects");
        if (!isdefined(totalassaults)) {
            totalassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_total");
        }
        enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_destroyed");
        enemytotalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects_enemy");
        if (!isdefined(enemytotalassaults)) {
            enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_total");
        }
        return strategiccommandutility::calculateprogressrushing(lowerbound, upperbound, destroyedassaults, totalassaults, enemydestroyedassaults, enemytotalassaults);
    }
    return 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xc76a84e1, Offset: 0x7b70
// Size: 0x1de
function private strategyshouldthrottleprogress(planner, constant) {
    if (planner::getblackboardattribute(planner, #"allow_progress_throttling") === 1) {
        enemycommander = planner::getblackboardattribute(planner, #"throttling_enemy_commander");
        if (!isdefined(enemycommander)) {
            return 0;
        }
        lowerbound = planner::getblackboardattribute(planner, #"throttling_lower_bound");
        upperbound = planner::getblackboardattribute(planner, #"throttling_upper_bound");
        destroyedassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_destroyed");
        totalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects");
        if (!isdefined(totalassaults)) {
            totalassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_total");
        }
        enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_destroyed");
        enemytotalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects_enemy");
        if (!isdefined(enemytotalassaults)) {
            enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_total");
        }
        return strategiccommandutility::calculateprogressthrottling(lowerbound, upperbound, destroyedassaults, totalassaults, enemydestroyedassaults, enemytotalassaults);
    }
    return 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x8e07f7f9, Offset: 0x7d58
// Size: 0x122
function private strategysquadorderparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    assert(isstring(constants[#"order"]) || ishash(constants[#"order"]), "<dev string:x70>" + "<invalid>" + "<dev string:x275>");
    planner::setblackboardattribute(planner, "order", constants[#"order"], squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x2cfe426c, Offset: 0x7e88
// Size: 0xc2
function private strategysquadassignforcegoalparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x29b>");
    forcegoal = planner::getblackboardattribute(planner, #"force_goal");
    planner::setblackboardattribute(planner, "force_goal", forcegoal, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x80656320, Offset: 0x7f58
// Size: 0x26a
function private strategysquadassignpathableescortparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x2e2>");
    pathableescorts = planner::getblackboardattribute(planner, "pathable_escorts", squadindex);
    if (!isarray(pathableescorts) || pathableescorts.size <= 0) {
        return spawnstruct();
    }
    shortestpath = pathableescorts[0][#"distance"];
    types = array("player", "entity");
    foreach (type in types) {
        if (isdefined(pathableescorts[0][type])) {
            escort = pathableescorts[0][type];
            for (index = 1; index < pathableescorts.size; index++) {
                pathableescort = pathableescorts[index];
                if (pathableescort[#"distance"] < shortestpath) {
                    shortestpath = pathableescort[#"distance"];
                    escort = pathableescort[type];
                }
            }
            planner::setblackboardattribute(planner, "escorts", array(escort), squadindex);
        }
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xfd91959, Offset: 0x81d0
// Size: 0x2c2
function private strategysquadassignpathableobjectparam(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x326>");
    pathablegameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
    prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
    gameobject = undefined;
    foreach (priorityname in prioritynames) {
        foreach (pathablegameobject in pathablegameobjects) {
            if (pathablegameobject[#"gameobject"][#"identifier"] === priorityname) {
                gameobject = pathablegameobject[#"gameobject"];
                break;
            }
        }
    }
    if (!isdefined(gameobject)) {
        shortestpath = pathablegameobjects[0][#"distance"];
        gameobject = pathablegameobjects[0][#"gameobject"];
        for (index = 1; index < pathablegameobjects.size; index++) {
            pathablegameobject = pathablegameobjects[index];
            if (pathablegameobject[#"distance"] < shortestpath) {
                shortestpath = pathablegameobject[#"distance"];
                gameobject = pathablegameobject[#"gameobject"];
            }
        }
    }
    planner::setblackboardattribute(planner, "gameobjects", array(gameobject), squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x365e400d, Offset: 0x84a0
// Size: 0x192
function private strategysquadassignpathableobjectiveparam(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    pathableobjectives = planner::getblackboardattribute(planner, "pathable_objectives", squadindex);
    shortestpath = pathableobjectives[0][#"distance"];
    objective = pathableobjectives[0][#"objective"];
    for (index = 1; index < pathableobjectives.size; index++) {
        pathableobjective = pathableobjectives[index];
        if (pathableobjective[#"distance"] < shortestpath) {
            shortestpath = pathableobjective[#"distance"];
            objective = pathableobjective[#"objective"];
        }
    }
    planner::setblackboardattribute(planner, "objectives", array(objective), squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x841a5397, Offset: 0x8640
// Size: 0x32a
function private strategysquadassignpathableunclaimedobjectparam(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    pathablegameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
    prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
    gameobject = undefined;
    foreach (priorityname in prioritynames) {
        foreach (pathablegameobject in pathablegameobjects) {
            if (!pathablegameobject[#"gameobject"][#"claimed"] && pathablegameobject[#"gameobject"][#"identifier"] === priorityname) {
                gameobject = pathablegameobject[#"gameobject"];
                break;
            }
        }
    }
    if (!isdefined(gameobject)) {
        shortestpath = undefined;
        foreach (pathablegameobject in pathablegameobjects) {
            if (!pathablegameobject[#"gameobject"][#"claimed"] && (!isdefined(shortestpath) || pathablegameobject[#"distance"] < shortestpath)) {
                shortestpath = pathablegameobject[#"distance"];
                gameobject = pathablegameobject[#"gameobject"];
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
// Checksum 0x7dd68bf4, Offset: 0x8978
// Size: 0xda
function private function_123fc038(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x36d>");
    currenttarget = planner::getblackboardattribute(planner, #"current_target");
    assert(isdefined(currenttarget), "<dev string:x3b0>");
    planner::setblackboardattribute(planner, "target", currenttarget, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x8fc6f887, Offset: 0x8a60
// Size: 0x9a
function private strategysquadassignwanderparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    planner::setblackboardattribute(planner, "order", "order_wander", squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x935fae82, Offset: 0x8b08
// Size: 0x142
function private strategysquadclaimobjectparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    gameobjects = planner::getblackboardattribute(planner, "gameobjects", squadindex);
    assert(gameobjects.size > 0, "<dev string:x3fe>");
    foreach (gameobject in gameobjects) {
        gameobject[#"claimed"] = 1;
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x15110bec, Offset: 0x8c58
// Size: 0x1c4
function private strategysquadcopyblackboardvalue(planner, constants) {
    assert(isstring(constants[#"from"]) || ishash(constants[#"from"]), "<dev string:x70>" + "<invalid>" + "<dev string:x48a>");
    assert(isstring(constants[#"to"]) || ishash(constants[#"to"]), "<dev string:x70>" + "<invalid>" + "<dev string:x4b9>");
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    value = planner::getblackboardattribute(planner, constants[#"from"], squadindex);
    planner::setblackboardattribute(planner, constants[#"to"], value, squadindex);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x1678f56a, Offset: 0x8e28
// Size: 0x1c4
function private function_678f7daa(planner, constants) {
    assert(isstring(constants[#"from"]) || ishash(constants[#"from"]), "<dev string:x70>" + "<invalid>" + "<dev string:x48a>");
    assert(isstring(constants[#"to"]) || ishash(constants[#"to"]), "<dev string:x70>" + "<invalid>" + "<dev string:x4b9>");
    value = planner::getblackboardattribute(planner, constants[#"from"]);
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    planner::setblackboardattribute(planner, constants[#"to"], value, squadindex);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xc6debfd6, Offset: 0x8ff8
// Size: 0x42
function private function_ba0d4cd4(planner, constants) {
    return function_5446c99e(planner, constants, constants[#"key"]);
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xee8a5fcd, Offset: 0x9048
// Size: 0x3a
function private function_24c0462a(planner, constants) {
    return function_5446c99e(planner, constants, #"hash_1a25f2c4feaf60cf");
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0xb7665077, Offset: 0x9090
// Size: 0x2c2
function private function_5446c99e(planner, constants, var_4c2b55f1) {
    squads = planner::getblackboardattribute(planner, var_4c2b55f1);
    assert(isarray(squads));
    assert(squads.size > 0, "<dev string:x522>" + var_4c2b55f1 + "<dev string:x555>");
    if (!isarray(squads)) {
        return spawnstruct();
    }
    var_6dc1f1ef = squads[0];
    var_5da7059a = array();
    foreach (botentry in var_6dc1f1ef[#"squad"]) {
        bot = botentry[#"__unsafe__"][#"bot"];
        if (!isdefined(bot)) {
            continue;
        }
        var_5da7059a[bot getentitynumber()] = 1;
    }
    squadindex = planner::createsubblackboard(planner);
    assert(squadindex <= 17, "<dev string:x557>");
    planner::setblackboardattribute(planner, #"current_squad", squadindex);
    planner::setblackboardattribute(planner, "doppelbots", var_6dc1f1ef[#"squad"], squadindex);
    team = planner::getblackboardattribute(planner, #"team");
    planner::setblackboardattribute(planner, "team", team, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x9a988c21, Offset: 0x9360
// Size: 0x2c2
function private strategysquadcreateofsizexparam(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    doppelbots = planner::getblackboardattribute(planner, #"idle_doppelbots");
    assert(doppelbots.size >= constants[#"amount"], "<dev string:x603>" + constants[#"amount"] + "<dev string:x62b>");
    enlisteddoppelbots = array();
    idledoppelbots = array();
    for (index = 0; index < constants[#"amount"]; index++) {
        enlisteddoppelbots[enlisteddoppelbots.size] = doppelbots[index];
    }
    for (index = constants[#"amount"]; index < doppelbots.size; index++) {
        idledoppelbots[idledoppelbots.size] = doppelbots[index];
    }
    planner::setblackboardattribute(planner, #"idle_doppelbots", idledoppelbots);
    squadindex = planner::createsubblackboard(planner);
    assert(squadindex <= 17, "<dev string:x557>");
    planner::setblackboardattribute(planner, #"current_squad", squadindex);
    planner::setblackboardattribute(planner, "doppelbots", enlisteddoppelbots, squadindex);
    team = planner::getblackboardattribute(planner, #"team");
    planner::setblackboardattribute(planner, "team", team, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x2958b6aa, Offset: 0x9630
// Size: 0x1ba
function private strategysquadescortassignmainguardparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    foreach (escort in escorts) {
        escort[#"escortmainguard"] = arraycombine(escort[#"escortmainguard"], squadbots, 1, 0);
    }
    planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
    planner::setblackboardattribute(planner, "order", "order_escort_mainguard", squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x5e3459e7, Offset: 0x97f8
// Size: 0x1ba
function private strategysquadescortassignrearguardparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    foreach (escort in escorts) {
        escort[#"escortrearguard"] = arraycombine(escort[#"escortrearguard"], squadbots, 1, 0);
    }
    planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
    planner::setblackboardattribute(planner, "order", "order_escort_rearguard", squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xd58fdd1b, Offset: 0x99c0
// Size: 0x1ba
function private strategysquadescortassignvanguardparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    foreach (escort in escorts) {
        escort[#"escortvanguard"] = arraycombine(escort[#"escortvanguard"], squadbots, 1, 0);
    }
    planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
    planner::setblackboardattribute(planner, "order", "order_escort_vanguard", squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x5cc71a90, Offset: 0x9b88
// Size: 0x11a
function private strategysquadescortcalculatepathablepoiparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    assert(isarray(escorts) && escorts.size > 0, "<dev string:x63e>");
    escortpoi = array();
    planner::setblackboardattribute(planner, "escort_poi", escortpoi, squadindex);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x7ffd46f7, Offset: 0x9cb0
// Size: 0x10e
function private strategysquadescorthasnomainguard(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    foreach (escort in escorts) {
        if (escort[#"escortmainguard"].size > 0) {
            return true;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x25b0f256, Offset: 0x9dc8
// Size: 0x10c
function private strategysquadescorthasnorearguard(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    foreach (escort in escorts) {
        if (escort[#"escortrearguard"].size > 0) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x98c69673, Offset: 0x9ee0
// Size: 0x10c
function private strategysquadescorthasnovanguard(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    foreach (escort in escorts) {
        if (escort[#"escortvanguard"].size > 0) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x6ba544df, Offset: 0x9ff8
// Size: 0x19c
function private strategysquadsortescortpoi(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    escortpois = planner::getblackboardattribute(planner, "escort_poi", squadindex);
    if (escortpois.size > 0) {
        for (index = 0; index < escortpois.size; index++) {
            closestindex = index;
            for (innerindex = index + 1; innerindex < escortpois.size; innerindex++) {
                if (escortpois[innerindex][#"distance"] < escortpois[closestindex][#"distance"]) {
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
// Checksum 0x577112c, Offset: 0xa1a0
// Size: 0x146
function private function_9b521767(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    assert(isstring(constants[#"key"]) || ishash(constants[#"key"]), "<dev string:x70>" + "<invalid>" + "<dev string:xba>");
    attribute = planner::getblackboardattribute(planner, constants[#"key"], squadindex);
    if (isdefined(attribute) && isarray(attribute)) {
        return (attribute.size > 0);
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xbbf20931, Offset: 0xa2f0
// Size: 0x98
function private strategysquadhaspathableescort(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    escorts = planner::getblackboardattribute(planner, "pathable_escorts", squadindex);
    return escorts.size > 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xdc0b03b3, Offset: 0xa390
// Size: 0xa2
function private strategysquadhaspathableobject(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    gameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
    return isdefined(gameobjects) && gameobjects.size > 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xaaac2bdf, Offset: 0xa440
// Size: 0x98
function private strategysquadhaspathableobjective(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    objectives = planner::getblackboardattribute(planner, "pathable_objectives", squadindex);
    return objectives.size > 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x5e485dd1, Offset: 0xa4e0
// Size: 0xee
function private strategysquadhaspathableunclaimedobject(planner, constant) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x183>");
    gameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
    for (index = 0; index < gameobjects.size; index++) {
        if (!gameobjects[index][#"gameobject"][#"claimed"]) {
            return true;
        }
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x3c22fecd, Offset: 0xa5d8
// Size: 0xa2
function private strategyhasatleastxassaultobjects(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    return planner::getblackboardattribute(planner, #"gameobjects_assault").size >= constants[#"amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x95b34996, Offset: 0xa688
// Size: 0xa2
function private strategyhasatleastxdefendobjects(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    return planner::getblackboardattribute(planner, #"gameobjects_defend").size >= constants[#"amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xe94d7dc3, Offset: 0xa738
// Size: 0xa2
function private strategyhasatleastxobjectives(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    return planner::getblackboardattribute(planner, #"objectives").size >= constants[#"amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xc860f355, Offset: 0xa7e8
// Size: 0xa2
function private strategyhasatleastxplayers(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    return planner::getblackboardattribute(planner, #"players").size >= constants[#"amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xb7659914, Offset: 0xa898
// Size: 0x21e
function private strategyhasatleastxpriorityassaultobjects(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    if (strategyhasatleastxassaultobjects(planner, constants)) {
        prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
        prioritymap = [];
        foreach (priorityname in prioritynames) {
            prioritymap[priorityname] = 1;
        }
        priorityobjects = 0;
        gameobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");
        foreach (gameobject in gameobjects) {
            if (isdefined(gameobject[#"identifier"]) && isdefined(prioritymap[gameobject[#"identifier"]])) {
                priorityobjects++;
            }
        }
        return (priorityobjects >= constants[#"amount"]);
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x30f3b982, Offset: 0xaac0
// Size: 0x21e
function private strategyhasatleastxprioritydefendobjects(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    if (strategyhasatleastxassaultobjects(planner, constants)) {
        prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
        prioritymap = [];
        foreach (priorityname in prioritynames) {
            prioritymap[priorityname] = 1;
        }
        priorityobjects = 0;
        gameobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
        foreach (gameobject in gameobjects) {
            if (isdefined(gameobject[#"identifier"]) && isdefined(prioritymap[gameobject[#"identifier"]])) {
                priorityobjects++;
            }
        }
        return (priorityobjects >= constants[#"amount"]);
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xabad8742, Offset: 0xace8
// Size: 0xa2
function private strategyhasatleastxunassignedbots(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    return planner::getblackboardattribute(planner, #"idle_doppelbots").size >= constants[#"amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x30e81076, Offset: 0xad98
// Size: 0x13a
function strategyhasatleastxunclaimedassaultobjects(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    unclaimedobjects = 0;
    gameobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");
    foreach (gameobject in gameobjects) {
        if (!gameobject[#"claimed"]) {
            unclaimedobjects++;
        }
    }
    return unclaimedobjects >= constants[#"amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x99e65c8b, Offset: 0xaee0
// Size: 0x13a
function strategyhasatleastxunclaimeddefendobjects(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    unclaimedobjects = 0;
    gameobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
    foreach (gameobject in gameobjects) {
        if (!gameobject[#"claimed"]) {
            unclaimedobjects++;
        }
    }
    return unclaimedobjects >= constants[#"amount"];
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x7a11cc43, Offset: 0xb028
// Size: 0x236
function strategyhasatleastxunclaimedpriorityassaultobjects(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    if (strategyhasatleastxassaultobjects(planner, constants)) {
        prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
        prioritymap = [];
        foreach (priorityname in prioritynames) {
            prioritymap[priorityname] = 1;
        }
        priorityobjects = 0;
        gameobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");
        foreach (gameobject in gameobjects) {
            if (isdefined(gameobject[#"identifier"]) && isdefined(prioritymap[gameobject[#"identifier"]]) && !gameobject[#"claimed"]) {
                priorityobjects++;
            }
        }
        return (priorityobjects >= constants[#"amount"]);
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x47739283, Offset: 0xb268
// Size: 0x236
function strategyhasatleastxunclaimedprioritydefendobjects(planner, constants) {
    assert(isint(constants[#"amount"]), "<dev string:x70>" + "<invalid>" + "<dev string:x5dc>");
    if (strategyhasatleastxassaultobjects(planner, constants)) {
        prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
        prioritymap = [];
        foreach (priorityname in prioritynames) {
            prioritymap[priorityname] = 1;
        }
        priorityobjects = 0;
        gameobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
        foreach (gameobject in gameobjects) {
            if (isdefined(gameobject[#"identifier"]) && isdefined(prioritymap[gameobject[#"identifier"]]) && !gameobject[#"claimed"]) {
                priorityobjects++;
            }
        }
        return (priorityobjects >= constants[#"amount"]);
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0xf3b58a05, Offset: 0xb4a8
// Size: 0x34
function strategyhasforcegoal(planner, constants) {
    return isdefined(planner::getblackboardattribute(planner, #"force_goal"));
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x0
// Checksum 0x7fc3299d, Offset: 0xb4e8
// Size: 0x1dc
function function_71a13dd8(planner, constants) {
    targets = planner::getblackboardattribute(planner, #"targets");
    assert(isarray(targets));
    if (!isarray(targets)) {
        return false;
    }
    priorities = array(#"hash_179ccf9d7cfd1e31", #"hash_254689c549346d57", #"hash_4bd86f050b36e1f6", #"hash_19c0ac460bdb9928", #"hash_160b01bbcd78c723", #"hash_c045a5aa4ac7c1d", #"hash_47fd3da20e90cd01", #"hash_64fc5c612a94639c", #"(-4) unimportant");
    assert(isarray(priorities));
    foreach (priority in priorities) {
        if (targets[priority].size > 0) {
            return true;
        }
    }
    return false;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x856d157a, Offset: 0xb6d0
// Size: 0x38
function private strategypathinghascalculatedpaths(planner, constants) {
    return planner::getblackboardattribute(planner, #"pathing_calculated_paths").size > 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x44ee75c4, Offset: 0xb710
// Size: 0xae
function private strategypathinghascalculatedpathablepath(planner, constants) {
    bots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
    botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
    calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
    return calculatedpaths.size >= bots.size && botindex >= bots.size;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x902a060d, Offset: 0xb7c8
// Size: 0x38
function private strategypathinghasnorequestpoints(planner, constants) {
    return planner::getblackboardattribute(planner, #"pathing_requested_points").size <= 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x58adf94b, Offset: 0xb808
// Size: 0x38
function private strategypathinghasrequestpoints(planner, constants) {
    return planner::getblackboardattribute(planner, #"pathing_requested_points").size > 0;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xb33045e8, Offset: 0xb848
// Size: 0x72
function private strategypathinghasunprocessedgameobjects(planner, constants) {
    requestedgameobjects = planner::getblackboardattribute(planner, #"pathing_requested_gameobjects");
    gameobjectindex = planner::getblackboardattribute(planner, #"pathing_current_gameobject_index");
    return gameobjectindex < requestedgameobjects.size;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xb9e0ca7e, Offset: 0xb8c8
// Size: 0x72
function private strategypathinghasunprocessedobjectives(planner, constants) {
    requestedobjectives = planner::getblackboardattribute(planner, #"pathing_requested_objectives");
    objectiveindex = planner::getblackboardattribute(planner, #"pathing_current_objective_index");
    return objectiveindex < requestedobjectives.size;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x24525310, Offset: 0xb948
// Size: 0xd4
function private strategypathinghasunprocessedrequestpoints(planner, constants) {
    requestedpoints = planner::getblackboardattribute(planner, #"pathing_requested_points");
    bots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
    pointindex = planner::getblackboardattribute(planner, #"pathing_current_point_index");
    botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
    return pointindex < requestedpoints.size && botindex < bots.size;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xe0e10500, Offset: 0xba28
// Size: 0x72
function private strategypathinghasunreachablepath(planner, constants) {
    botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
    calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
    return botindex > calculatedpaths.size;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xb93ec4cd, Offset: 0xbaa8
// Size: 0x72
function private strategypathingaddassaultgameobjectsparam(planner, constants) {
    assaultobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");
    planner::setblackboardattribute(planner, #"pathing_requested_gameobjects", assaultobjects);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x3553dbd, Offset: 0xbb28
// Size: 0x72
function private strategypathingadddefendgameobjectsparam(planner, constants) {
    defendobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
    planner::setblackboardattribute(planner, #"pathing_requested_gameobjects", defendobjects);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x7012644e, Offset: 0xbba8
// Size: 0x72
function private strategypathingaddobjectivesparam(planner, constants) {
    objectives = planner::getblackboardattribute(planner, #"objectives");
    planner::setblackboardattribute(planner, #"pathing_requested_objectives", objectives);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x62b6a19b, Offset: 0xbc28
// Size: 0xc2
function private strategypathingaddsquadbotsparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x99f>");
    doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    planner::setblackboardattribute(planner, #"pathing_requested_bots", doppelbots);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x33a2156f, Offset: 0xbcf8
// Size: 0x19a
function private strategypathingaddsquadescortsparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x99f>");
    escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
    for (index = 0; index < escorts.size; index++) {
        player = escorts[index][#"__unsafe__"][#"player"];
        if (!isdefined(escorts[index][#"__unsafe__"])) {
            escorts[index][#"__unsafe__"] = array();
        }
        escorts[index][#"__unsafe__"][#"bot"] = player;
    }
    planner::setblackboardattribute(planner, #"pathing_requested_bots", escorts);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xad6ee94a, Offset: 0xbea0
// Size: 0x142
function private strategypathingaddtosquadcalculatedgameobjectsparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x99f>");
    calculatedgameobjects = planner::getblackboardattribute(planner, #"pathing_calculated_gameobjects");
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
// Checksum 0xc9c666ad, Offset: 0xbff0
// Size: 0x142
function private strategypathingaddtosquadcalculatedobjectivesparam(planner, constants) {
    squadindex = planner::getblackboardattribute(planner, #"current_squad");
    assert(squadindex >= 0, "<dev string:x99f>");
    calculatedobjectives = planner::getblackboardattribute(planner, #"pathing_calculated_objectives");
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
// Checksum 0xe03acaf6, Offset: 0xc140
// Size: 0x332
function private strategypathingcalculatepathtorequestedpointsparam(planner, constants) {
    requestedpoints = planner::getblackboardattribute(planner, #"pathing_requested_points");
    bots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
    pointindex = planner::getblackboardattribute(planner, #"pathing_current_point_index");
    botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
    assert(bots.size > 0);
    assert(requestedpoints.size > 0);
    assert(pointindex < requestedpoints.size);
    assert(botindex < bots.size);
    if (bots.size > 0 && requestedpoints.size > 0 && pointindex < requestedpoints.size && botindex < bots.size) {
        bot = bots[botindex][#"__unsafe__"][#"bot"];
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
            calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
            calculatedpaths[calculatedpaths.size] = path;
            planner::setblackboardattribute(planner, #"pathing_calculated_paths", calculatedpaths, undefined, 1);
        }
        if (isdefined(path) || pointindex >= requestedpoints.size) {
            pointindex = 0;
            botindex++;
        }
        planner::setblackboardattribute(planner, #"pathing_current_point_index", pointindex);
        planner::setblackboardattribute(planner, #"pathing_current_bot_index", botindex);
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0x84dec4e5, Offset: 0xc480
// Size: 0x1c2
function private strategypathingcalculategameobjectrequestpointsparam(planner, constants) {
    requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
    requestedgameobjects = planner::getblackboardattribute(planner, #"pathing_requested_gameobjects");
    gameobjectindex = planner::getblackboardattribute(planner, #"pathing_current_gameobject_index");
    if (requestedbots.size <= 0 || requestedgameobjects.size <= 0) {
        return spawnstruct();
    }
    requestedbot = requestedbots[0];
    bot = requestedbot[#"__unsafe__"][#"bot"];
    gameobject = requestedgameobjects[gameobjectindex][#"__unsafe__"][#"object"];
    requestedpoints = array();
    if (strategiccommandutility::isvalidbotorplayer(bot) && isdefined(gameobject)) {
        requestedpoints = strategiccommandutility::querypointsaroundgameobject(bot, gameobject);
    }
    planner::setblackboardattribute(planner, #"pathing_requested_points", requestedpoints);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xfe031980, Offset: 0xc650
// Size: 0x1c2
function private strategypathingcalculateobjectiverequestpointsparam(planner, constants) {
    requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
    requestedobjectives = planner::getblackboardattribute(planner, #"pathing_requested_objectives");
    objectiveindex = planner::getblackboardattribute(planner, #"pathing_current_objective_index");
    if (requestedbots.size <= 0 || requestedobjectives.size <= 0) {
        return spawnstruct();
    }
    requestedbot = requestedbots[0];
    bot = requestedbot[#"__unsafe__"][#"bot"];
    trigger = requestedobjectives[objectiveindex][#"__unsafe__"][#"trigger"];
    requestedpoints = array();
    if (strategiccommandutility::isvalidbotorplayer(bot) && isdefined(trigger)) {
        requestedpoints = strategiccommandutility::querypointsinsidetrigger(bot, trigger);
    }
    planner::setblackboardattribute(planner, #"pathing_requested_points", requestedpoints);
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xc33e9dbe, Offset: 0xc820
// Size: 0x1f2
function private strategypathingcalculateobjectivepathabilityparam(planner, constants) {
    requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
    requestedobjectives = planner::getblackboardattribute(planner, #"pathing_requested_objectives");
    objectiveindex = planner::getblackboardattribute(planner, #"pathing_current_objective_index");
    calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
    if (requestedbots.size == calculatedpaths.size) {
        longestpath = 0;
        for (index = 0; index < calculatedpaths.size; index++) {
            if (calculatedpaths[index].pathdistance > longestpath) {
                longestpath = calculatedpaths[index].pathdistance;
            }
        }
        objectiveentry = array();
        objectiveentry[#"distance"] = longestpath;
        objectiveentry[#"objective"] = requestedobjectives[objectiveindex];
        calculatedobjectives = planner::getblackboardattribute(planner, #"pathing_calculated_objectives");
        calculatedobjectives[calculatedobjectives.size] = objectiveentry;
        planner::setblackboardattribute(planner, #"pathing_calculated_objectives", calculatedobjectives);
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 2, eflags: 0x4
// Checksum 0xe14b6b13, Offset: 0xca20
// Size: 0x1f2
function private strategypathingcalculategameobjectpathabilityparam(planner, constants) {
    requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
    requestedgameobjects = planner::getblackboardattribute(planner, #"pathing_requested_gameobjects");
    gameobjectindex = planner::getblackboardattribute(planner, #"pathing_current_gameobject_index");
    calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
    if (requestedbots.size == calculatedpaths.size) {
        longestpath = 0;
        for (index = 0; index < calculatedpaths.size; index++) {
            if (calculatedpaths[index].pathdistance > longestpath) {
                longestpath = calculatedpaths[index].pathdistance;
            }
        }
        gameobjectentry = array();
        gameobjectentry[#"distance"] = longestpath;
        gameobjectentry[#"gameobject"] = requestedgameobjects[gameobjectindex];
        calculatedgameobjects = planner::getblackboardattribute(planner, #"pathing_calculated_gameobjects");
        calculatedgameobjects[calculatedgameobjects.size] = gameobjectentry;
        planner::setblackboardattribute(planner, #"pathing_calculated_gameobjects", calculatedgameobjects);
    }
    return spawnstruct();
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x6673f113, Offset: 0xcc20
// Size: 0x166
function private function_f2b8eca9(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    order = plannersquadutility::getblackboardattribute(squad, "order");
    if (isdefined(doppelbots) && doppelbots.size > 0 && isdefined(order)) {
        foreach (botentry in doppelbots) {
            bot = botentry[#"__unsafe__"][#"bot"];
            if (isdefined(bot) && order == "follow_chain" && bot isinvehicle()) {
                return false;
            }
        }
        return true;
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x47498e30, Offset: 0xcd90
// Size: 0x116
function private utilityscorebotpresence(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    if (isdefined(doppelbots) && doppelbots.size > 0) {
        foreach (botentry in doppelbots) {
            bot = botentry[#"__unsafe__"][#"bot"];
            if (!strategiccommandutility::isvalidbot(bot)) {
                return false;
            }
        }
        return true;
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x96ee1cf6, Offset: 0xceb0
// Size: 0x18e
function private function_9e2f025d(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    if (isdefined(doppelbots) && doppelbots.size > 0) {
        foreach (botentry in doppelbots) {
            bot = botentry[#"__unsafe__"][#"bot"];
            if (!isdefined(bot)) {
                return false;
            }
            if (bot isinvehicle() && botentry[#"type"] == "bot") {
                return false;
            } else if (!bot isinvehicle() && botentry[#"type"] != "bot") {
                return false;
            }
            if (!strategiccommandutility::function_fe34c4b4(bot)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x84b9bece, Offset: 0xd048
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
    if (!blackboard::getstructblackboardattribute(commander, #"allow_escort")) {
        return false;
    }
    if (_calculateallpathableclients(doppelbots, escorts).size < escorts.size) {
        return false;
    }
    if (isdefined(escortpoi) && escortpoi.size > 0) {
        return false;
    } else {
        assaultgameobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault");
        defendgameobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_defend");
        objectives = blackboard::getstructblackboardattribute(commander, #"objectives");
        if (assaultgameobjects.size > 0 || defendgameobjects.size > 0 || objectives.size > 0) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x0
// Checksum 0x9a91ddd4, Offset: 0xd250
// Size: 0xae
function utilityscoreforcegoal(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    squadforcegoal = plannersquadutility::getblackboardattribute(squad, "force_goal");
    forcegoal = blackboard::getstructblackboardattribute(commander, #"force_goal");
    if (forcegoal !== squadforcegoal) {
        return false;
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x1eddb5ce, Offset: 0xd308
// Size: 0x172
function private utilityscoregameobjectpathing(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    if (!isdefined(doppelbots) || doppelbots.size <= 0) {
        return true;
    }
    foreach (botentry in doppelbots) {
        bot = botentry[#"__unsafe__"][#"bot"];
        if (!strategiccommandutility::isvalidbot(bot)) {
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
// Checksum 0xbb799f92, Offset: 0xd488
// Size: 0x42a
function private utilityscoregameobjectpriority(commander, squad, constants) {
    priorityidentifiers = constants[#"priority"];
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
    assaultobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault");
    defendobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_defend");
    activeidentifiers = [];
    currentsquadassignedpriority = 0;
    if (isarray(assaultobjects)) {
        prioritygameobjects = _calculateprioritygameobjects(assaultobjects, priorityidentifiers);
        foreach (gameobjectentry in prioritygameobjects) {
            activeidentifiers[gameobjectentry[#"identifier"]] = 1;
        }
    }
    if (isarray(defendobjects)) {
        prioritygameobjects = _calculateprioritygameobjects(defendobjects, priorityidentifiers);
        foreach (gameobjectentry in prioritygameobjects) {
            activeidentifiers[gameobjectentry[#"identifier"]] = 1;
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
                    activeidentifiers[gameobjectentry[#"identifier"]] = 0;
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
// Checksum 0xc1da6ba5, Offset: 0xd8c0
// Size: 0x132
function private utilityscoregameobjectsvalidity(commander, squad, constants) {
    gameobjects = plannersquadutility::getblackboardattribute(squad, "gameobjects");
    if (!isdefined(gameobjects)) {
        return true;
    }
    foreach (gameobjectentry in gameobjects) {
        gameobject = gameobjectentry[#"__unsafe__"][#"object"];
        if (!isdefined(gameobject) || isdefined(gameobject.trigger) && !gameobject.trigger istriggerenabled()) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x19e7ee21, Offset: 0xda00
// Size: 0x5a
function private function_596f41f9(commander, squad, constants) {
    target = plannersquadutility::getblackboardattribute(squad, "target");
    if (!isdefined(target)) {
        return false;
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0xbe9be475, Offset: 0xda68
// Size: 0x242
function private utilityscoreprogressthrottling(commander, squad, constants) {
    if (blackboard::getstructblackboardattribute(commander, #"allow_progress_throttling") === 1) {
        enemycommander = blackboard::getstructblackboardattribute(commander, #"throttling_enemy_commander");
        if (!isdefined(enemycommander)) {
            return false;
        }
        lowerbound = blackboard::getstructblackboardattribute(commander, #"throttling_lower_bound");
        upperbound = blackboard::getstructblackboardattribute(commander, #"throttling_upper_bound");
        destroyedassaults = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault_destroyed");
        totalassaults = blackboard::getstructblackboardattribute(commander, #"throttling_total_gameobjects");
        if (!isdefined(totalassaults)) {
            totalassaults = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault_total");
        }
        enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_destroyed");
        enemytotalassaults = blackboard::getstructblackboardattribute(commander, #"throttling_total_gameobjects_enemy");
        if (!isdefined(enemytotalassaults)) {
            enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_total");
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
// Checksum 0x1e4dec80, Offset: 0xdcb8
// Size: 0x21a
function private function_81dbff50(commander, squad, constants) {
    var_cf62fc4e = plannersquadutility::getblackboardattribute(squad, "target");
    if (!isdefined(var_cf62fc4e)) {
        return true;
    }
    if (var_cf62fc4e[#"type"] === "gameobject") {
        gameobject = var_cf62fc4e[#"__unsafe__"][#"object"];
        if (!isdefined(gameobject) || isdefined(gameobject.trigger) && !gameobject.trigger istriggerenabled()) {
            return false;
        }
    } else if (var_cf62fc4e[#"type"] === "destroy" || var_cf62fc4e[#"type"] === "defend") {
        return false;
    } else if (var_cf62fc4e[#"type"] === "capturearea") {
        return false;
    } else if (var_cf62fc4e[#"type"] === "destroy" || var_cf62fc4e[#"type"] === "goto") {
        missioncomponent = var_cf62fc4e[#"__unsafe__"][#"mission_component"];
        commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
        if (!strategiccommandutility::function_ee65cade(missioncomponent, commanderteam)) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0xa35192f2, Offset: 0xdee0
// Size: 0x10e
function private function_bb9f87ec(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    team = blackboard::getstructblackboardattribute(commander, #"team");
    if (!isdefined(doppelbots) || !isdefined(team)) {
        return true;
    }
    for (botindex = 0; botindex < doppelbots.size; botindex++) {
        bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
        if (isdefined(bot) && bot.team != team) {
            return false;
        }
    }
    return true;
}

// Namespace plannercommanderutility/planner_commander_utility
// Params 3, eflags: 0x4
// Checksum 0xbe99598e, Offset: 0xdff8
// Size: 0x12e
function private utilityscoreviableescort(commander, squad, constants) {
    doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    escorts = plannersquadutility::getblackboardattribute(squad, "escorts");
    players = blackboard::getstructblackboardattribute(commander, #"players");
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

