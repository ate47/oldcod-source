#using scripts/core_common/ai/planner_squad;
#using scripts/core_common/ai/strategic_command;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;
#using scripts/core_common/ai/systems/planner_blackboard;
#using scripts/core_common/ai_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/flag_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/system_shared;

#namespace planner_squad_utility;

// Namespace planner_squad_utility/planner_squad_utility
// Params 0, eflags: 0x2
// Checksum 0xbd64584d, Offset: 0x5a0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("planner_squad_utility", &plannersquadutility::__init__, undefined, undefined);
}

#namespace plannersquadutility;

// Namespace plannersquadutility/planner_squad_utility
// Params 0, eflags: 0x4
// Checksum 0x1091c891, Offset: 0x5e0
// Size: 0x4a4
function private __init__() {
    plannerutility::registerplannerapi("squadHasAttackObject", &strategyhasattackobject);
    plannerutility::registerplannerapi("squadHasBelowXAmmo", &strategyhasbelowxammounsafe);
    plannerutility::registerplannerapi("squadHasBlackboardValue", &strategyhasblackboardvalue);
    plannerutility::registerplannerapi("squadHasDefendObject", &strategyhasdefendobject);
    plannerutility::registerplannerapi("squadHasEscort", &strategyhasescort);
    plannerutility::registerplannerapi("squadHasEscortPOI", &strategyhasescortpoi);
    plannerutility::registerplannerapi("squadHasForceGoal", &strategyhasforcegoal);
    plannerutility::registerplannerapi("squadHasObjective", &strategyhasobjective);
    plannerutility::registerplannerapi("squadHasPathableAmmoCache", &strategyhaspathableammocache);
    plannerutility::registerplanneraction("squadClearAreaToAttackObject", &strategyclearareaobjectparam, &strategyclearareatoobjectinit, &strategyclearareatoattackobjectupdate, undefined);
    plannerutility::registerplanneraction("squadClearAreaToDefendObject", &strategyclearareaobjectparam, &strategyclearareatoobjectinit, &strategyclearareatodefendobjectupdate, undefined);
    plannerutility::registerplanneraction("squadClearAreaToEscort", &strategyclearareatoescortparam, &strategyclearareatoescortinit, &strategyclearareatoescortupdate, undefined);
    plannerutility::registerplanneraction("squadClearAreaToGoldenPath", &strategyclearareatogoldenpathparam, &strategyclearareatogoldenpathinit, &strategyclearareatogoldenpathupdate, undefined);
    plannerutility::registerplanneraction("squadClearAreaToObjective", &strategyclearareaobjectiveparam, &strategyclearareatoobjectiveinit, &strategyclearareatoobjectiveupdate, undefined);
    plannerutility::registerplanneraction("squadRushAttackObject", &strategybotobjectparam, &strategyrushattackobjectinit, &strategyrushattackobjectupdate, undefined);
    plannerutility::registerplanneraction("squadRushCloserThanXAmmoCache", &strategyrushammocacheparam, &strategyrushammocacheinit, &strategyrushammocacheupdate, undefined);
    plannerutility::registerplanneraction("squadRushDefendObject", &strategybotobjectparam, &strategyrushdefendobjectinit, &strategyrushdefendobjectupdate, undefined);
    plannerutility::registerplanneraction("squadRushForceGoal", &strategybotgoalparam, &strategyrushforcegoalinit, &strategyrushforcegoalupdate, undefined);
    plannerutility::registerplanneraction("squadRushObjective", &strategyrushobjectiveparam, &strategyrushobjectiveinit, &strategyrushobjectiveupdate, undefined);
    plannerutility::registerplanneraction("squadWander", &strategybotparam, &strategywanderinit, &strategywanderupdate, undefined);
    plannerutility::registerplanneraction("squadEndPlan", undefined, undefined, undefined, undefined);
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x71bf80a5, Offset: 0xa90
// Size: 0x1b4
function private _assigngameobject(bot, gameobject) {
    if (isdefined(bot) && bot isbot() && isdefined(gameobject) && !bot.goalforced && bot bot::get_commander()) {
        bot.goalradius = 512;
        if (isdefined(gameobject.e_object) && isvehicle(gameobject.e_object)) {
            bot setgoal(gameobject.e_object);
        } else if (isdefined(gameobject.trigger)) {
            _setgoalpoint(bot, gameobject.trigger.origin);
        } else {
            _setgoalpoint(bot, gameobject.origin);
        }
        if (gameobject.type == "use" || gameobject.type == "useObject" || gameobject.type == "carryObject") {
            bot bot::set_objective(gameobject);
        }
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x4b1db484, Offset: 0xc50
// Size: 0x44
function private _cleargameobject(bot) {
    if (isdefined(bot) && bot isbot()) {
        bot bot::set_objective(undefined);
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x9c522fcb, Offset: 0xca0
// Size: 0x2ac
function private _calculateadjustedpathsegments(params) {
    params.adjustedpath = [];
    params.adjustedpathsegment = 0;
    if (isdefined(params.path) && isdefined(params.path.pathpoints) && params.path.pathpoints.size > 0) {
        adjustedpath = [];
        radius = 256;
        diameter = radius * 2;
        pathpointssize = params.path.pathpoints.size;
        currentdistance = 0;
        currentpoint = params.path.pathpoints[0];
        adjustedpath[adjustedpath.size] = currentpoint;
        for (index = 1; index < pathpointssize; index++) {
            nextpoint = params.path.pathpoints[index];
            distancetonextpoint = distance2d(currentpoint, nextpoint);
            totaldistance = currentdistance + distancetonextpoint;
            if (totaldistance < diameter) {
                currentdistance += distancetonextpoint;
                currentpoint = nextpoint;
                continue;
            }
            if (totaldistance >= diameter) {
                distancetonextadjusted = diameter - currentdistance;
                ratiotonextadjusted = distancetonextadjusted / distancetonextpoint;
                currentpoint = lerpvector(currentpoint, nextpoint, ratiotonextadjusted);
                adjustedpath[adjustedpath.size] = currentpoint;
                currentdistance = 0;
                index--;
            }
        }
        adjustedpath[adjustedpath.size] = params.path.pathpoints[pathpointssize - 1];
        params.adjustedpath = adjustedpath;
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x2f5facb8, Offset: 0xf58
// Size: 0x364
function private _debugadjustedpath(params) {
    if (getdvarint("ai_debugSquadAreas")) {
        bot = undefined;
        foreach (bot in params.bots) {
            if (isdefined(bot) && bot isbot()) {
                break;
            }
        }
        for (index = 1; index < params.adjustedpath.size; index++) {
            start = params.adjustedpath[index - 1];
            end = params.adjustedpath[index];
            center = start + (end - start) * 0.5;
            /#
                recordline(start, end, (1, 0.5, 0), "<dev string:x28>");
                recordcircle(center, 256, (1, 0, 0), "<dev string:x28>");
            #/
            if (isdefined(bot)) {
                offset = 10;
                pointdanger = _evaluatepointdanger(bot, center, 128, 128 * 6);
                /#
                    record3dtext(pointdanger.inner, center, (1, 0, 0), "<dev string:x28>");
                    record3dtext(pointdanger.outer, center + (0, 0, offset), (1, 0.5, 0), "<dev string:x28>");
                #/
            }
        }
        currentpathsegment = params.adjustedpathsegment;
        if (isdefined(currentpathsegment) && isarray(params.adjustedpath) && currentpathsegment < params.adjustedpath.size - 2) {
            currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
            /#
                recordsphere(currentcenter, 10, (0, 1, 0));
            #/
        }
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0xcf6b2ffa, Offset: 0x12c8
// Size: 0x6a0
function private _evaluateadjustedpath(params) {
    if (params.adjustedpath.size <= 0) {
        return;
    }
    bot = undefined;
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            break;
        }
    }
    currentpathsegment = params.adjustedpathsegment;
    if (currentpathsegment > 0) {
        previouscenter = (params.adjustedpath[currentpathsegment - 1] + params.adjustedpath[currentpathsegment]) / 2;
        previouspointdanger = _evaluatepointdanger(bot, previouscenter, 128, 128 * 6);
    }
    currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
    currentpointdanger = _evaluatepointdanger(bot, currentcenter, 128, 128 * 6);
    if (currentpathsegment < params.adjustedpath.size - 2) {
        nextcenter = (params.adjustedpath[currentpathsegment + 1] + params.adjustedpath[currentpathsegment + 2]) / 2;
        nextpointdanger = _evaluatepointdanger(bot, nextcenter, 128, 128 * 6);
    }
    injured = 0;
    foreach (bot in params.bots) {
        if (_isinjured(bot)) {
            injured = 1;
            break;
        }
    }
    reachedcurrent = 0;
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            if (distance2dsquared(bot.origin, currentcenter) <= 256 * 1.5 * 256 * 1.5) {
                reachedcurrent = 1;
                break;
            }
        }
    }
    if (reachedcurrent) {
        if (injured) {
            if (isdefined(previouspointdanger) && previouspointdanger.inner < currentpointdanger.inner && previouspointdanger.outer > 15) {
                params.adjustedpathsegment--;
            }
            return;
        }
        if (currentpointdanger.outer <= 50 && currentpointdanger.inner <= 15) {
            if (isdefined(nextpointdanger) && nextpointdanger.inner <= 15) {
                params.adjustedpathsegment++;
            }
        }
        if (currentpathsegment == params.adjustedpathsegment) {
            foreach (bot in params.bots) {
                if (!isdefined(bot.enemy) || isdefined(bot) && bot isbot() && isalive(bot) && !bot haspath() && !bot cansee(bot.enemy)) {
                    params.adjustedpathsegment++;
                    break;
                }
            }
        }
        if (currentpathsegment == params.adjustedpathsegment) {
            if (currentpointdanger.inner > 15) {
                if (isdefined(previouspointdanger) && previouspointdanger.inner < currentpointdanger.inner && previouspointdanger.outer > 15) {
                    params.adjustedpathsegment--;
                }
            }
        }
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 4, eflags: 0x4
// Checksum 0x9427dec, Offset: 0x1970
// Size: 0xa4
function private _evaluatepointdanger(bot, center, inner, outer) {
    pointdanger = spawnstruct();
    pointdanger.inner = tacticalinfluencergetthreatscore(center, inner, bot.team);
    pointdanger.outer = tacticalinfluencergetthreatscore(center, outer, bot.team);
    return pointdanger;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x5cb3842d, Offset: 0x1a20
// Size: 0x7c
function private _isinjured(bot) {
    if (isdefined(bot) && bot isbot() && isdefined(bot.health) && isdefined(bot.maxhealth)) {
        return (bot.health / bot.maxhealth <= 0.8);
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x64c3222b, Offset: 0x1aa8
// Size: 0xac
function private _paramshasbots(params) {
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            return true;
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xaeab2c50, Offset: 0x1b60
// Size: 0xcc
function private _setgoalpoint(bot, point) {
    if (isdefined(bot) && bot isbot() && isvec(point) && !bot.goalforced && bot bot::get_commander()) {
        navmeshpoint = getclosestpointonnavmesh(point, 200);
        if (!isdefined(navmeshpoint)) {
            navmeshpoint = point;
        }
        bot setgoal(navmeshpoint);
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xdce3dee3, Offset: 0x1c38
// Size: 0x12c
function private strategybotgoalparam(planner, constants) {
    params = spawnstruct();
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo["__unsafe__"]["bot"];
    }
    params.bots = bots;
    params.goal = planner::getblackboardattribute(planner, "force_goal");
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xe5d49b3d, Offset: 0x1d70
// Size: 0x26a
function private strategybotobjectparam(planner, constants) {
    params = spawnstruct();
    objects = planner::getblackboardattribute(planner, "gameobjects");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo["__unsafe__"]["bot"];
    }
    params.bots = bots;
    params.object = objects[0]["__unsafe__"]["object"];
    params.order = planner::getblackboardattribute(planner, "order");
    if (isdefined(params.object)) {
        foreach (bot in bots) {
            if (isdefined(bot) && bot isbot()) {
                params.path = strategiccommandutility::calculatepathtogameobject(bot, params.object);
                if (isdefined(params.path)) {
                    break;
                }
            }
        }
    }
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xb69d5566, Offset: 0x1fe8
// Size: 0x100
function private strategybotparam(planner, constants) {
    params = spawnstruct();
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo["__unsafe__"]["bot"];
    }
    params.bots = bots;
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x222573e8, Offset: 0x20f0
// Size: 0x4c
function private strategyclearareaobjectiveparam(planner, constants) {
    params = strategyrushobjectiveparam(planner, constants);
    params.adjustedpath = [];
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xb9de4c7a, Offset: 0x2148
// Size: 0x4c
function private strategyclearareaobjectparam(planner, constants) {
    params = strategybotobjectparam(planner, constants);
    params.adjustedpath = [];
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x418cddc3, Offset: 0x21a0
// Size: 0x6a
function private strategyclearareatoescortinit(planner, params) {
    _calculateadjustedpathsegments(params);
    if (!isdefined(params.escort) || !_paramshasbots(params)) {
        return 2;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x425788c7, Offset: 0x2218
// Size: 0x4c
function private strategyclearareatoescortparam(planner, constants) {
    params = strategyrushescortparam(planner, constants);
    params.adjustedpath = [];
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x7251eded, Offset: 0x2270
// Size: 0x78
function private strategyclearareatogoldenpathinit(planner, params) {
    _calculateadjustedpathsegments(params);
    if (!_paramshasbots(params)) {
        if (!isdefined(params.goldengameobject) && !isdefined(params.goldenobjective)) {
            return 2;
        }
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x1e70413d, Offset: 0x22f0
// Size: 0x304
function private strategyclearareatogoldenpathparam(planner, constants) {
    params = spawnstruct();
    escortpoi = planner::getblackboardattribute(planner, "escort_poi");
    escorts = planner::getblackboardattribute(planner, "escorts");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo["__unsafe__"]["bot"];
    }
    params.bots = bots;
    params.escort = escorts[0]["__unsafe__"]["player"];
    params.goldenpathdistance = escortpoi[0]["distance"];
    params.goldengameobject = escortpoi[0]["gameobject"];
    params.goldenobjective = escortpoi[0]["objective"];
    if (isdefined(params.goldengameobject)) {
        gameobject = params.goldengameobject["__unsafe__"]["object"];
        if (isdefined(params.escort) && isdefined(gameobject)) {
            params.path = strategiccommandutility::calculatepathtogameobject(params.escort, gameobject);
        }
    }
    if (isdefined(params.goldenobjective)) {
        trigger = params.goldenobjective["__unsafe__"]["trigger"];
        if (isdefined(params.escort) && isdefined(trigger)) {
            params.path = strategiccommandutility::calculatepathtoobjective(params.escort, trigger);
        }
    }
    params.adjustedpath = [];
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xa4d35e72, Offset: 0x2600
// Size: 0x282
function private strategyclearareatogoldenpathupdate(planner, params) {
    /#
        _debugadjustedpath(params);
    #/
    if (!isdefined(params.escort) || !_paramshasbots(params)) {
        return 2;
    }
    escort = params.escort;
    if (!isdefined(escort)) {
        return 2;
    }
    if (!isdefined(escort)) {
        return 2;
    }
    currentpathsegment = 0;
    currentcenter = undefined;
    if (params.adjustedpath.size > 1) {
        params.adjustedpathsegment = 1;
        params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
        currentpathsegment = params.adjustedpathsegment;
        currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
    }
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            _cleargameobject(bot);
            _setgoalpoint(bot, currentcenter);
            bot.goalradius = 256;
        }
    }
    return 3;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x78618c71, Offset: 0x2890
// Size: 0x6a
function private strategyclearareatoobjectinit(planner, params) {
    _calculateadjustedpathsegments(params);
    if (!isdefined(params.object) || !_paramshasbots(params)) {
        return 2;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xb2f0df5f, Offset: 0x2908
// Size: 0x6a
function private strategyclearareatoobjectiveinit(planner, params) {
    _calculateadjustedpathsegments(params);
    if (!isdefined(params.objective) || !_paramshasbots(params)) {
        return 2;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xdc67499d, Offset: 0x2980
// Size: 0x338
function private strategyclearareatoattackobjectupdate(planner, params) {
    /#
        _debugadjustedpath(params);
    #/
    if (!isdefined(params.object) || !_paramshasbots(params)) {
        return 2;
    }
    currentpathsegment = 0;
    currentcenter = undefined;
    if (params.adjustedpath.size > 1) {
        _evaluateadjustedpath(params);
        params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
        currentpathsegment = params.adjustedpathsegment;
        currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
    }
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            if (currentpathsegment >= params.adjustedpath.size - 2) {
                if (!isdefined(params.order) || params.order == "order_attack") {
                    _assigngameobject(bot, params.object);
                } else {
                    _setgoalpoint(bot, params.object.origin);
                    bot.goalradius = 256;
                }
                continue;
            }
            _cleargameobject(bot);
            bot.goalradius = 256;
            _setgoalpoint(bot, currentcenter);
        }
    }
    if (params.object.trigger istriggerenabled()) {
        return 3;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x41b45d14, Offset: 0x2cc0
// Size: 0x2d8
function private strategyclearareatodefendobjectupdate(planner, params) {
    /#
        _debugadjustedpath(params);
    #/
    if (!isdefined(params.object) || !_paramshasbots(params)) {
        return 2;
    }
    currentpathsegment = 0;
    currentcenter = undefined;
    if (params.adjustedpath.size > 1) {
        _evaluateadjustedpath(params);
        params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
        currentpathsegment = params.adjustedpathsegment;
        currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
    }
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            _cleargameobject(bot);
            if (currentpathsegment >= params.adjustedpath.size - 2) {
                _setgoalpoint(bot, params.object.origin);
                bot.goalradius = 256;
                continue;
            }
            _setgoalpoint(bot, currentcenter);
            bot.goalradius = 256;
        }
    }
    if (params.object.trigger istriggerenabled()) {
        return 3;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x9a055e8, Offset: 0x2fa0
// Size: 0x2fa
function private strategyclearareatoescortupdate(planner, params) {
    /#
        _debugadjustedpath(params);
    #/
    if (!isdefined(params.escort) || !_paramshasbots(params)) {
        return 2;
    }
    escort = params.escort;
    if (!isdefined(escort)) {
        return 2;
    }
    currentpathsegment = 0;
    currentcenter = undefined;
    if (params.adjustedpath.size > 1) {
        _evaluateadjustedpath(params);
        params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
        currentpathsegment = params.adjustedpathsegment;
        currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
    }
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            _cleargameobject(bot);
            if (currentpathsegment >= params.adjustedpath.size - 2) {
                if (!bot isingoal(escort.origin)) {
                    _setgoalpoint(bot, escort.origin);
                    bot.goalradius = 256;
                }
                continue;
            }
            _setgoalpoint(bot, currentcenter);
            bot.goalradius = 256;
        }
    }
    return 3;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x5b9087f5, Offset: 0x32a8
// Size: 0x342
function private strategyclearareatoobjectiveupdate(planner, params) {
    /#
        _debugadjustedpath(params);
    #/
    if (!isdefined(params.objective) || !_paramshasbots(params)) {
        return 2;
    }
    currentpathsegment = 0;
    currentcenter = undefined;
    if (params.adjustedpath.size > 1) {
        _evaluateadjustedpath(params);
        params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
        currentpathsegment = params.adjustedpathsegment;
        currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
    }
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            _cleargameobject(bot);
            if (currentpathsegment >= params.adjustedpath.size - 2) {
                _setgoalpoint(bot, params.objective["origin"]);
                bot.goalradius = 256;
                if (isdefined(params.objective["radius"])) {
                    bot.goalradius = params.objective["radius"];
                }
                continue;
            }
            _setgoalpoint(bot, currentcenter);
            bot.goalradius = 256;
        }
    }
    if (isdefined(params.objective) && objective_state(params.objective["id"]) == "active") {
        return 3;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x54380, Offset: 0x35f8
// Size: 0x11a
function private strategyhasattackobject(planner, constants) {
    team = planner::getblackboardattribute(planner, "team");
    objects = planner::getblackboardattribute(planner, "gameobjects");
    if (isdefined(objects)) {
        foreach (object in objects) {
            if (object["team"] == team || object["team"] == "any") {
                return true;
            }
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xbcdb39df, Offset: 0x3720
// Size: 0x60
function private strategyhasescort(planner, constants) {
    escorts = planner::getblackboardattribute(planner, "escorts");
    return isarray(escorts) && escorts.size > 0;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x987c5566, Offset: 0x3788
// Size: 0x60
function private strategyhasescortpoi(planner, constants) {
    escortpoi = planner::getblackboardattribute(planner, "escort_poi");
    return isarray(escortpoi) && escortpoi.size > 0;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x8e46c432, Offset: 0x37f0
// Size: 0x34
function private strategyhasforcegoal(planner, constants) {
    return isdefined(planner::getblackboardattribute(planner, "force_goal"));
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xdee669ff, Offset: 0x3830
// Size: 0x27e
function private strategyhasbelowxammounsafe(planner, constants) {
    assert(isfloat(constants["<dev string:x33>"]), "<dev string:x3b>" + "plannersquadutility::strategyhasbelowxammounsafe" + "<dev string:x47>");
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bot = botinfo["__unsafe__"]["bot"];
        if (!isdefined(bot) || !bot isbot()) {
            continue;
        }
        weapons = bot getweaponslistprimaries();
        foreach (weapon in weapons) {
            if (isdefined(weapon) && weapon.name != "none") {
                currentammo = bot getammocount(weapon);
                maxammo = weapon.maxammo;
                if (isdefined(maxammo) && maxammo > 0) {
                    ammofraction = currentammo / maxammo;
                    if (ammofraction < constants["percent"]) {
                        return true;
                    }
                }
            }
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xa9e4514f, Offset: 0x3ab8
// Size: 0xc2
function private strategyhasblackboardvalue(planner, constants) {
    assert(isarray(constants));
    assert(isstring(constants["<dev string:x6f>"]));
    value = planner::getblackboardattribute(planner, constants["name"]);
    return value == constants["value"];
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x729ee193, Offset: 0x3b88
// Size: 0x11a
function private strategyhasdefendobject(planner, constants) {
    team = planner::getblackboardattribute(planner, "team");
    objects = planner::getblackboardattribute(planner, "gameobjects");
    if (isdefined(objects)) {
        foreach (object in objects) {
            if (object["team"] != team && object["team"] != "any") {
                return true;
            }
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xa195e920, Offset: 0x3cb0
// Size: 0x116
function private strategyhasobjective(planner, constants) {
    team = planner::getblackboardattribute(planner, "team");
    objects = planner::getblackboardattribute(planner, "objectives");
    if (isdefined(objects)) {
        foreach (object in objects) {
            if (objective_state(object["id"]) == "active") {
                return true;
            }
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x5250479, Offset: 0x3dd0
// Size: 0x54
function private strategyhaspathableammocache(planner, constants) {
    ammocaches = planner::getblackboardattribute(planner, "pathable_ammo_caches");
    return isdefined(ammocaches) && ammocaches.size > 0;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xf3dbb011, Offset: 0x3e30
// Size: 0x14e
function private strategyrushammocacheinit(planner, params) {
    if (!isdefined(params.ammo) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            _setgoalpoint(bot, params.ammo.origin);
            bot.goalradius = 256;
            _assigngameobject(bot, params.ammo);
        }
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x70cc3ecd, Offset: 0x3f88
// Size: 0x564
function private strategyrushammocacheparam(planner, constants) {
    assert(isint(constants["<dev string:x74>"]), "<dev string:x3b>" + "plannersquadutility::strategyrushammocacheparam" + "<dev string:x7d>");
    params = spawnstruct();
    params.bots = [];
    botpositions = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bot = botinfo["__unsafe__"]["bot"];
        if (isdefined(bot) && bot isbot()) {
            botposition = getclosestpointonnavmesh(botinfo["origin"], 200);
            if (isdefined(botposition)) {
                botpositions[botpositions.size] = botposition;
            }
            params.bots[params.bots.size] = bot;
        }
    }
    possiblecaches = [];
    distancesq = constants["distance"] * constants["distance"];
    foreach (gameobject in level.a_gameobjects) {
        if (isdefined(gameobject) && gameobject gameobjects::get_identifier() === "ammo_cache") {
            closeenough = 1;
            foreach (botposition in botpositions) {
                if (distance2dsquared(gameobject.origin, botposition) > distancesq) {
                    closeenough = 0;
                    break;
                }
            }
            if (closeenough) {
                possiblecaches[possiblecaches.size] = gameobject;
            }
        }
    }
    path = undefined;
    shortestpath = undefined;
    closestammocache = undefined;
    foreach (ammocache in possiblecaches) {
        ammocachepos = getclosestpointonnavmesh(ammocache.origin, 200);
        if (isdefined(ammocachepos)) {
            pathsegment = generatenavmeshpath(ammocachepos, botpositions);
            if (isdefined(pathsegment) && pathsegment.status === "succeeded") {
                if (pathsegment.pathdistance > constants["distance"]) {
                    continue;
                }
                if (!isdefined(path) || pathsegment.pathdistance < shortestpath) {
                    path = pathsegment;
                    shortestpath = pathsegment.pathdistance;
                    closestammocache = ammocache;
                }
            }
        }
    }
    if (isdefined(closestammocache)) {
        planner::setblackboardattribute(planner, "pathable_ammo_caches", array(closestammocache));
        params.ammo = closestammocache;
    }
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xf1d9a19e, Offset: 0x44f8
// Size: 0x80
function private strategyrushammocacheupdate(planner, params) {
    if (!isdefined(params.ammo) || !_paramshasbots(params)) {
        return 2;
    }
    if (params.ammo.trigger istriggerenabled()) {
        return 3;
    }
    return 2;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x4f2526ce, Offset: 0x4580
// Size: 0xee
function private strategyrushattackobjectinit(planner, params) {
    if (!isdefined(params.object) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        _assigngameobject(bot, params.object);
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x56c43b3e, Offset: 0x4678
// Size: 0x80
function private strategyrushattackobjectupdate(planner, params) {
    if (!isdefined(params.object) || !_paramshasbots(params)) {
        return 2;
    }
    if (params.object.trigger istriggerenabled()) {
        return 3;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xc27f3d60, Offset: 0x4700
// Size: 0x13a
function private strategyrushdefendobjectinit(planner, params) {
    if (!isdefined(params.object) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            _cleargameobject(bot);
            _setgoalpoint(bot, params.object.origin);
            bot.goalradius = 256;
        }
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x6b082a94, Offset: 0x4848
// Size: 0x80
function private strategyrushdefendobjectupdate(planner, params) {
    if (!isdefined(params.object) || !_paramshasbots(params)) {
        return 2;
    }
    if (params.object.trigger istriggerenabled()) {
        return 3;
    }
    return 2;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xe16ed4b3, Offset: 0x48d0
// Size: 0x24a
function private strategyrushescortparam(planner, constants) {
    params = spawnstruct();
    escorts = planner::getblackboardattribute(planner, "escorts");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo["__unsafe__"]["bot"];
    }
    params.bots = bots;
    params.escort = escorts[0]["__unsafe__"]["player"];
    if (isdefined(params.escort)) {
        foreach (bot in bots) {
            if (isdefined(bot) && bot isbot()) {
                params.path = strategiccommandutility::calculatepathtoposition(bot, params.escort.origin);
                if (isdefined(params.path)) {
                    break;
                }
            }
        }
    }
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x780abf19, Offset: 0x4b28
// Size: 0x11e
function private strategyrushforcegoalinit(planner, params) {
    if (!isdefined(params.goal) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            _cleargameobject(bot);
            bot setgoal(params.goal);
        }
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xffc96927, Offset: 0x4c50
// Size: 0x52
function private strategyrushforcegoalupdate(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    if (isdefined(params.goal)) {
        return 3;
    }
    return 2;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xb600b5f9, Offset: 0x4cb0
// Size: 0x182
function private strategyrushobjectiveinit(planner, params) {
    if (!isdefined(params.objective) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            _cleargameobject(bot);
            _setgoalpoint(bot, params.objective["origin"]);
            bot.goalradius = 256;
            if (isdefined(params.objective["radius"])) {
                bot.goalradius = params.objective["radius"];
            }
        }
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xe54dcbdf, Offset: 0x4e40
// Size: 0x34a
function private strategyrushobjectiveparam(planner, constants) {
    params = spawnstruct();
    objectives = planner::getblackboardattribute(planner, "objectives");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo["__unsafe__"]["bot"];
    }
    params.bots = bots;
    params.objective = objectives[0];
    if (isdefined(params.objective)) {
        trigger = params.objective["__unsafe__"]["trigger"];
        if (isdefined(trigger)) {
            foreach (bot in bots) {
                if (isdefined(bot) && bot isbot()) {
                    params.path = strategiccommandutility::calculatepathtotrigger(bot, trigger);
                    if (isdefined(params.path)) {
                        break;
                    }
                }
            }
        } else {
            foreach (bot in bots) {
                if (isdefined(bot) && bot isbot()) {
                    params.path = strategiccommandutility::calculatepathtoposition(bot, objective_position(params.objective["id"]));
                    if (isdefined(params.path)) {
                        break;
                    }
                }
            }
        }
    }
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xb2dde287, Offset: 0x5198
// Size: 0x8a
function private strategyrushobjectiveupdate(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    if (isdefined(params.objective) && objective_state(params.objective["id"]) == "active") {
        return 3;
    }
    return 2;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x9c1ea488, Offset: 0x5230
// Size: 0xda
function private strategywanderinit(planner, params) {
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            _cleargameobject(bot);
            bot.goalradius = 128;
        }
    }
    return true;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x1a591950, Offset: 0x5318
// Size: 0x256
function private strategywanderupdate(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (isdefined(bot) && bot isbot()) {
            if (!isdefined(bot._wander_update_time)) {
                bot._wander_update_time = 0;
            }
            if (bot._wander_update_time + 3000 < gettime() || bot isingoal(bot.origin)) {
                searchradius = 1024;
                forward = anglestoforward(bot getangles());
                forwardpos = bot.origin + forward * searchradius;
                cylinder = ai::t_cylinder(bot.origin, searchradius, searchradius);
                points = tacticalquery("stratcom_tacquery_wander", bot.origin, cylinder, forwardpos, bot);
                if (points.size > 0) {
                    _setgoalpoint(bot, points[0].origin);
                    bot._wander_update_time = gettime();
                }
            }
        }
    }
    return 3;
}

