#using scripts\core_common\ai\strategic_command;
#using scripts\core_common\ai\systems\planner;
#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_chain;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace planner_squad_utility;

// Namespace planner_squad_utility/planner_squad_utility
// Params 0, eflags: 0x2
// Checksum 0x9bfaa557, Offset: 0x1a0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"planner_squad_utility", &plannersquadutility::__init__, undefined, undefined);
}

#namespace plannersquadutility;

// Namespace plannersquadutility/planner_squad_utility
// Params 0, eflags: 0x4
// Checksum 0xd31f63e4, Offset: 0x1e8
// Size: 0x82c
function private __init__() {
    plannerutility::registerplannerapi(#"hash_5414bc90f9b0a9a4", &function_fc993775);
    plannerutility::registerplannerapi(#"hash_4a94655debb4ee2f", &function_bf7c447e);
    plannerutility::registerplannerapi(#"squadhasattackobject", &strategyhasattackobject);
    plannerutility::registerplannerapi(#"squadhasbelowxammo", &strategyhasbelowxammounsafe);
    plannerutility::registerplannerapi(#"squadhasblackboardvalue", &strategyhasblackboardvalue);
    plannerutility::registerplannerapi(#"squadhasdefendobject", &strategyhasdefendobject);
    plannerutility::registerplannerapi(#"squadhasescort", &strategyhasescort);
    plannerutility::registerplannerapi(#"squadhasescortpoi", &strategyhasescortpoi);
    plannerutility::registerplannerapi(#"squadhasforcegoal", &strategyhasforcegoal);
    plannerutility::registerplannerapi(#"squadhasobjective", &strategyhasobjective);
    plannerutility::registerplannerapi(#"hash_3e9c87665dfef699", &function_1cdf2c86);
    plannerutility::registerplannerapi(#"hash_5dfbc649e2cdd6aa", &function_5bae5471);
    plannerutility::registerplannerapi(#"squadhaspathableammocache", &strategyhaspathableammocache);
    plannerutility::registerplannerapi(#"hash_2b8bf371fba6de6a", &function_bdb0cbe9);
    plannerutility::registerplannerapi(#"hash_3ed9287b5cc1ec2c", &function_9bc3a68f);
    plannerutility::registerplannerapi(#"hash_5678bc75fd7c0675", &function_8405010c);
    plannerutility::registerplanneraction(#"hash_186a23f9ca83351f", &strategyclearareaobjectparam, &strategyclearareatoobjectinit, &strategyclearareatoattackobjectupdate, undefined);
    plannerutility::registerplanneraction(#"squadclearareatoattackobject", &strategyclearareaobjectparam, &strategyclearareatoobjectinit, &strategyclearareatoattackobjectupdate, undefined);
    plannerutility::registerplanneraction(#"hash_553b7b133c2aee64", &strategyclearareatogoldenpathparam, &strategyclearareatogoldenpathinit, &function_5e4fcb68, undefined);
    plannerutility::registerplanneraction(#"squadclearareatodefendobject", &strategyclearareaobjectparam, &strategyclearareatoobjectinit, &strategyclearareatodefendobjectupdate, undefined);
    plannerutility::registerplanneraction(#"squadclearareatoescort", &strategyclearareatoescortparam, &strategyclearareatoescortinit, &strategyclearareatoescortupdate, undefined);
    plannerutility::registerplanneraction(#"squadclearareatogoldenpath", &strategyclearareatogoldenpathparam, &strategyclearareatogoldenpathinit, &strategyclearareatogoldenpathupdate, undefined);
    plannerutility::registerplanneraction(#"squadclearareatoobjective", &strategyclearareaobjectiveparam, &strategyclearareatoobjectiveinit, &strategyclearareatoobjectiveupdate, undefined);
    plannerutility::registerplanneraction(#"hash_12d15145a12cf7ed", &strategybotobjectparam, &function_8eeb4602, &function_2e38242f, undefined);
    plannerutility::registerplanneraction(#"hash_23810516f86c60f", &strategybotparam, &function_92c678c2, &function_cf4953ef, undefined);
    plannerutility::registerplanneraction(#"squadrushattackobject", &strategybotobjectparam, &strategyrushattackobjectinit, &strategyrushattackobjectupdate, undefined);
    plannerutility::registerplanneraction(#"squadrushcloserthanxammocache", &strategyrushammocacheparam, &strategyrushammocacheinit, &strategyrushammocacheupdate, undefined);
    plannerutility::registerplanneraction(#"squadrushdefendobject", &strategybotobjectparam, &strategyrushdefendobjectinit, &strategyrushdefendobjectupdate, undefined);
    plannerutility::registerplanneraction(#"hash_7c1f27a774d46b97", &strategyclearareatoescortparam, &function_1675af4a, &function_40fe6867, undefined);
    plannerutility::registerplanneraction(#"squadrushforcegoal", &strategybotgoalparam, &strategyrushforcegoalinit, &strategyrushforcegoalupdate, undefined);
    plannerutility::registerplanneraction(#"squadrushobjective", &strategyrushobjectiveparam, &strategyrushobjectiveinit, &strategyrushobjectiveupdate, undefined);
    plannerutility::registerplanneraction(#"squadwander", &strategybotparam, &strategywanderinit, &strategywanderupdate, undefined);
    plannerutility::registerplanneraction(#"squadendplan", undefined, undefined, undefined, undefined);
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x861ce9fb, Offset: 0xa20
// Size: 0x1cc
function private _assigngameobject(bot, gameobject) {
    if (isdefined(bot) && isalive(bot) && isdefined(gameobject) && bot bot::function_68d6034a()) {
        bot.goalradius = 512;
        if (isdefined(gameobject.e_object) && isvehicle(gameobject.e_object)) {
            bot setgoal(gameobject.e_object);
        } else if (isdefined(gameobject.trigger)) {
            _setgoalpoint(bot, gameobject.trigger.origin);
        } else {
            _setgoalpoint(bot, gameobject.origin);
        }
        if (gameobject.type == "use" || gameobject.type == "useObject" || gameobject.type == "carryObject") {
            if (!isdefined(bot.owner) || isbot(bot.owner) || !strategiccommandutility::isvalidplayer(bot.owner)) {
                bot bot::set_interact(gameobject);
            }
        }
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x238edd18, Offset: 0xbf8
// Size: 0x6c
function private _cleargameobject(bot) {
    if (strategiccommandutility::isvalidbot(bot)) {
        if (!isdefined(bot.owner) || isbot(bot.owner)) {
            bot bot::clear_interact();
        }
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0xe4d51694, Offset: 0xc70
// Size: 0x376
function private _calculateadjustedpathsegments(params) {
    params.adjustedpath = [];
    params.adjustedpathsegment = 0;
    if (isdefined(params.path) && isdefined(params.path.pathpoints) && params.path.pathpoints.size > 0) {
        adjustedpath = [];
        radius = function_fdd68f12(params.bots);
        segmentlength = radius * 1.5;
        pathpointssize = params.path.pathpoints.size;
        currentdistance = 0;
        currentpoint = params.path.pathpoints[0];
        adjustedpath[adjustedpath.size] = currentpoint;
        for (index = 1; index < pathpointssize; index++) {
            nextpoint = params.path.pathpoints[index];
            distancetonextpoint = distance2d(currentpoint, nextpoint);
            totaldistance = currentdistance + distancetonextpoint;
            if (totaldistance < segmentlength) {
                currentdistance += distancetonextpoint;
                currentpoint = nextpoint;
                continue;
            }
            if (totaldistance >= segmentlength) {
                distancetonextadjusted = segmentlength - currentdistance;
                ratiotonextadjusted = distancetonextadjusted / distancetonextpoint;
                currentpoint = lerpvector(currentpoint, nextpoint, ratiotonextadjusted);
                adjustedpath[adjustedpath.size] = currentpoint;
                currentdistance = 0;
                index--;
            }
        }
        adjustedpath[adjustedpath.size] = params.path.pathpoints[pathpointssize - 1];
        params.adjustedpath = adjustedpath;
        params.fallback = params.adjustedpath[0];
        if (params.adjustedpath.size >= 2) {
            direction = params.adjustedpath[1] - params.adjustedpath[0];
            direction = vectornormalize(direction);
            fallback = params.adjustedpath[0] - direction * 256;
            fallback = getclosestpointonnavmesh(fallback, 256);
            if (isdefined(fallback)) {
                if (tracepassedonnavmesh(params.adjustedpath[0], fallback)) {
                    params.fallback = fallback;
                }
            }
        }
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x7052a16c, Offset: 0xff0
// Size: 0x98
function private function_fdd68f12(bots) {
    foreach (bot in bots) {
        if (isdefined(bot) && bot isinvehicle()) {
            return 640;
        }
    }
    return 256;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x634159ee, Offset: 0x1090
// Size: 0xac
function private function_f1f3a22f(bots) {
    foreach (bot in bots) {
        if (isdefined(bot) && bot isinvehicle()) {
            return (256 / 2 * 2.5);
        }
    }
    return 256 / 2;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x9027c825, Offset: 0x1148
// Size: 0xb0
function private function_e6e448d1(bots) {
    foreach (bot in bots) {
        if (isdefined(bot) && bot isinvehicle()) {
            return (256 * 1.5 * 2.5);
        }
    }
    return 256 * 1.5;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x1622da97, Offset: 0x1200
// Size: 0xbc
function private function_e16427fe(bots) {
    foreach (bot in bots) {
        if (isdefined(bot) && bot isinvehicle()) {
            return (256 / 2 * 6 * 2.5);
        }
    }
    return 256 / 2 * 6;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x43e57cc7, Offset: 0x12c8
// Size: 0x39c
function private _debugadjustedpath(params) {
    if (getdvarint(#"ai_debugsquadareas", 0)) {
        bot = undefined;
        foreach (bot in params.bots) {
            if (strategiccommandutility::isvalidbot(bot)) {
                break;
            }
        }
        innerradius = function_f1f3a22f(params.bots);
        outerradius = function_e16427fe(params.bots);
        for (index = 1; index < params.adjustedpath.size; index++) {
            start = params.adjustedpath[index - 1];
            end = params.adjustedpath[index];
            center = start + (end - start) * 0.5;
            /#
                recordline(start, end, (1, 0.5, 0), "<dev string:x30>");
                recordcircle(center, function_fdd68f12(params.bots), (1, 0, 0), "<dev string:x30>");
            #/
            if (isdefined(bot)) {
                offset = 10;
                pointdanger = _evaluatepointdanger(bot, center, innerradius, outerradius);
                /#
                    record3dtext("<dev string:x3b>" + pointdanger.inner, center, (1, 0, 0), "<dev string:x30>");
                    record3dtext("<dev string:x42>" + pointdanger.outer, center + (0, 0, offset), (1, 0.5, 0), "<dev string:x30>");
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
// Checksum 0x822633e3, Offset: 0x1670
// Size: 0x624
function private _evaluateadjustedpath(params) {
    if (params.adjustedpath.size <= 0) {
        return;
    }
    bot = undefined;
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            break;
        }
    }
    currentpathsegment = params.adjustedpathsegment;
    innerradius = function_f1f3a22f(params.bots);
    outerradius = function_e16427fe(params.bots);
    if (currentpathsegment > 0) {
        previouscenter = (params.adjustedpath[currentpathsegment - 1] + params.adjustedpath[currentpathsegment]) / 2;
        previouspointdanger = _evaluatepointdanger(bot, previouscenter, innerradius, outerradius);
    }
    currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
    currentpointdanger = _evaluatepointdanger(bot, currentcenter, innerradius, outerradius);
    if (currentpathsegment < params.adjustedpath.size - 2) {
        nextcenter = (params.adjustedpath[currentpathsegment + 1] + params.adjustedpath[currentpathsegment + 2]) / 2;
        nextpointdanger = _evaluatepointdanger(bot, nextcenter, innerradius, outerradius);
    }
    injured = 0;
    foreach (bot in params.bots) {
        if (_isinjured(bot)) {
            injured = 1;
            break;
        }
    }
    reachedcurrent = 0;
    var_a1c02ec7 = function_e6e448d1(params.bots);
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            if (distance2dsquared(bot.origin, currentcenter) <= var_a1c02ec7 * var_a1c02ec7) {
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
                if (strategiccommandutility::isvalidbot(bot) && isalive(bot) && !bot haspath() && (!isdefined(bot.enemy) || !bot cansee(bot.enemy))) {
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
// Checksum 0xc0c47e41, Offset: 0x1ca0
// Size: 0xa2
function private _evaluatepointdanger(bot, center, inner, outer) {
    pointdanger = spawnstruct();
    pointdanger.inner = tacticalinfluencergetthreatscore(center, inner, bot.team);
    pointdanger.outer = tacticalinfluencergetthreatscore(center, outer, bot.team);
    return pointdanger;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0xa903f60e, Offset: 0x1d50
// Size: 0xb6
function private _isinjured(bot) {
    if (strategiccommandutility::isvalidbot(bot) && isdefined(bot.health) && isdefined(bot.maxhealth)) {
        tacstate = bot bot::function_9dca972f();
        if (isdefined(tacstate)) {
            return (bot.health / bot.maxhealth <= (isdefined(tacstate.var_b7baa2a0) ? tacstate.var_b7baa2a0 : 0));
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 1, eflags: 0x4
// Checksum 0xaf630a72, Offset: 0x1e10
// Size: 0x92
function private _paramshasbots(params) {
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            return true;
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 3, eflags: 0x4
// Checksum 0xf652913a, Offset: 0x1eb0
// Size: 0x17e
function private _setgoalpoint(bot, point, likelyenemyposition) {
    if (isdefined(bot) && isalive(bot) && isvec(point) && bot bot::function_68d6034a()) {
        if (bot isinvehicle()) {
            vehicle = bot getvehicleoccupied();
            seatnum = vehicle getoccupantseat(bot);
            if (seatnum == 0) {
                vehicle setgoal(point);
            }
            return;
        }
        navmeshpoint = getclosestpointonnavmesh(point, 200);
        if (!isdefined(navmeshpoint)) {
            navmeshpoint = point;
        }
        bot setgoal(navmeshpoint);
        if (isdefined(likelyenemyposition) && isvec(likelyenemyposition)) {
            bot.var_e13b45f4 = likelyenemyposition;
            return;
        }
        bot.var_e13b45f4 = undefined;
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 3, eflags: 0x4
// Checksum 0x1d7787d0, Offset: 0x2038
// Size: 0xf6
function private function_4f739ba7(bot, trigger, likelyenemyposition) {
    if (isdefined(bot) && isdefined(trigger) && bot bot::function_68d6034a()) {
        if (bot isinvehicle()) {
            vehicle = bot getvehicleoccupied();
            vehicle setgoal(trigger);
            return;
        }
        bot setgoal(trigger);
        if (isdefined(likelyenemyposition) && isvec(likelyenemyposition)) {
            bot.var_e13b45f4 = likelyenemyposition;
            return;
        }
        bot.var_e13b45f4 = undefined;
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 3, eflags: 0x4
// Checksum 0x4bff9cee, Offset: 0x2138
// Size: 0x6e
function private function_8d0acaf8(adjustedpath, currentpathsegment, var_6c067ead) {
    for (i = var_6c067ead; i >= 0; i--) {
        lookaheadpoint = adjustedpath[currentpathsegment + var_6c067ead];
        if (isdefined(lookaheadpoint)) {
            return lookaheadpoint;
        }
    }
    return undefined;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x7fa8d3e2, Offset: 0x21b0
// Size: 0x11a
function private strategybotgoalparam(planner, constants) {
    params = spawnstruct();
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    params.goal = planner::getblackboardattribute(planner, "force_goal");
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x3e8d0691, Offset: 0x22d8
// Size: 0x454
function private strategybotobjectparam(planner, constants) {
    params = spawnstruct();
    objects = planner::getblackboardattribute(planner, "gameobjects");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    params.order = planner::getblackboardattribute(planner, "order");
    if (isdefined(objects) && isarray(objects)) {
        params.object = objects[0][#"__unsafe__"][#"object"];
    }
    target = planner::getblackboardattribute(planner, "target");
    if (isdefined(target)) {
        params.bundle = target[#"__unsafe__"][#"bundle"];
        params.component = target[#"__unsafe__"][#"component"];
        params.object = target[#"__unsafe__"][#"object"];
    }
    if (isdefined(params.object)) {
        foreach (bot in bots) {
            params.path = strategiccommandutility::calculatepathtogameobject(bot, params.object);
            if (isdefined(params.path)) {
                break;
            }
        }
    }
    if (isdefined(params.component)) {
        foreach (bot in bots) {
            params.path = strategiccommandutility::function_a8875aa2(bot, params.component);
            if (isdefined(params.path)) {
                break;
            }
        }
    }
    if (isdefined(params.bundle)) {
        foreach (bot in bots) {
            params.path = strategiccommandutility::function_92a57941(bot, params.bundle);
            if (isdefined(params.path)) {
                break;
            }
        }
    }
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x0
// Checksum 0xeaf0a5f3, Offset: 0x2738
// Size: 0xf6
function strategybotparam(planner, constants) {
    params = spawnstruct();
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x9d6daf6f, Offset: 0x2838
// Size: 0x46
function private strategyclearareaobjectiveparam(planner, constants) {
    params = strategyrushobjectiveparam(planner, constants);
    params.adjustedpath = [];
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x5cf7569, Offset: 0x2888
// Size: 0x46
function private strategyclearareaobjectparam(planner, constants) {
    params = strategybotobjectparam(planner, constants);
    params.adjustedpath = [];
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xc1785a7d, Offset: 0x28d8
// Size: 0x64
function private strategyclearareatoescortinit(planner, params) {
    _calculateadjustedpathsegments(params);
    if (!isdefined(params.escort) || !_paramshasbots(params)) {
        return 2;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x673c8167, Offset: 0x2948
// Size: 0x46
function private strategyclearareatoescortparam(planner, constants) {
    params = strategyrushescortparam(planner, constants);
    params.adjustedpath = [];
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x7eaae17f, Offset: 0x2998
// Size: 0x7a
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
// Checksum 0x599953e0, Offset: 0x2a20
// Size: 0x456
function private strategyclearareatogoldenpathparam(planner, constants) {
    params = spawnstruct();
    target = planner::getblackboardattribute(planner, "target");
    escortpoi = planner::getblackboardattribute(planner, "escort_poi");
    escorts = planner::getblackboardattribute(planner, "escorts");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    params.escort = escorts[0][#"__unsafe__"][constants[#"escortkey"]];
    if (isdefined(target)) {
        params.var_e58fb00e = target[#"__unsafe__"][#"bundle"];
        params.var_14988313 = target[#"__unsafe__"][#"component"];
        params.goldengameobject = target;
    }
    if (isdefined(escortpoi)) {
        params.goldenpathdistance = escortpoi[0][#"distance"];
        params.goldengameobject = escortpoi[0][#"gameobject"];
        params.goldenobjective = escortpoi[0][#"objective"];
    }
    if (isdefined(params.var_e58fb00e)) {
        if (isdefined(params.escort)) {
            params.path = strategiccommandutility::function_92a57941(params.escort, params.var_e58fb00e);
        }
    }
    if (isdefined(params.var_14988313)) {
        if (isdefined(params.escort)) {
            params.path = strategiccommandutility::function_a8875aa2(params.escort, params.var_14988313);
        }
    }
    if (isdefined(params.goldengameobject)) {
        gameobject = params.goldengameobject[#"__unsafe__"][#"object"];
        if (isdefined(params.escort) && isdefined(gameobject)) {
            params.path = strategiccommandutility::calculatepathtogameobject(params.escort, gameobject);
        }
    }
    if (isdefined(params.goldenobjective)) {
        trigger = params.goldenobjective[#"__unsafe__"][#"trigger"];
        if (isdefined(params.escort) && isdefined(trigger)) {
            params.path = strategiccommandutility::calculatepathtoobjective(params.escort, trigger);
        }
    }
    params.adjustedpath = [];
    return params;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xa008643d, Offset: 0x2e80
// Size: 0x16e
function private function_5e4fcb68(planner, params) {
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
    if (!isdefined(params.fallback)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _setgoalpoint(bot, params.fallback, function_8d0acaf8(params.adjustedpath, 0, 3));
            bot.goalradius = 256;
        }
    }
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x3f0b2690, Offset: 0x2ff8
// Size: 0x282
function private strategyclearareatogoldenpathupdate(planner, params) {
    /#
        _debugadjustedpath(params);
    #/
    if (!isdefined(params.escort) || !_paramshasbots(params)) {
        return 2;
    }
    if (params.adjustedpath.size <= 0) {
        return 2;
    }
    escort = params.escort;
    currentpathsegment = 0;
    currentcenter = undefined;
    if (params.adjustedpath.size > 1) {
        params.adjustedpathsegment = 1;
        params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
        currentpathsegment = params.adjustedpathsegment;
        currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
    }
    var_3809f8a5 = function_fdd68f12(params.bots);
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _cleargameobject(bot);
            _setgoalpoint(bot, currentcenter, function_8d0acaf8(params.adjustedpath, currentpathsegment, 3));
            bot.goalradius = var_3809f8a5;
        }
    }
    return 3;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x88b3904e, Offset: 0x3288
// Size: 0x90
function private strategyclearareatoobjectinit(planner, params) {
    _calculateadjustedpathsegments(params);
    if (!isdefined(params.object) && !isdefined(params.component) && !isdefined(params.bundle)) {
        return 2;
    }
    if (!_paramshasbots(params)) {
        return 2;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xf139898a, Offset: 0x3320
// Size: 0x64
function private strategyclearareatoobjectiveinit(planner, params) {
    _calculateadjustedpathsegments(params);
    if (!isdefined(params.objective) || !_paramshasbots(params)) {
        return 2;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x53164dd4, Offset: 0x3390
// Size: 0x69a
function private strategyclearareatoattackobjectupdate(planner, params) {
    /#
        _debugadjustedpath(params);
    #/
    if (!isdefined(params.object) && !isdefined(params.component) && !isdefined(params.bundle)) {
        return 2;
    }
    if (!_paramshasbots(params)) {
        return 2;
    }
    entity = undefined;
    trigger = undefined;
    if (isdefined(params.object)) {
        trigger = params.object.trigger;
    } else if (isdefined(params.component)) {
        foreach (bot in params.bots) {
            if (!isdefined(bot)) {
                continue;
            }
            trigger = strategiccommandutility::function_b684ed38(bot, params.component);
        }
    } else if (isdefined(params.bundle)) {
        switch (params.bundle.m_str_type) {
        case #"escortbiped":
            entity = params.bundle.var_f09fedbb;
            break;
        }
    }
    if (!isdefined(trigger) && !isdefined(entity)) {
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
    var_3809f8a5 = function_fdd68f12(params.bots);
    foreach (bot in params.bots) {
        if (!strategiccommandutility::isvalidbot(bot)) {
            continue;
        }
        if (currentpathsegment >= params.adjustedpath.size - 2) {
            if (!isdefined(params.order) || params.order == "order_attack") {
                if (isdefined(params.object) && params.object.triggertype == "use") {
                    _assigngameobject(bot, params.object);
                } else if (isdefined(trigger)) {
                    function_4f739ba7(bot, trigger, function_8d0acaf8(params.adjustedpath, currentpathsegment, 3));
                } else {
                    _setgoalpoint(bot, entity.origin, function_8d0acaf8(params.adjustedpath, currentpathsegment, 3));
                }
            } else {
                if (isdefined(params.object)) {
                    _setgoalpoint(bot, params.object.origin, function_8d0acaf8(params.adjustedpath, currentpathsegment, 3));
                } else if (isdefined(trigger)) {
                    _setgoalpoint(bot, trigger.origin, function_8d0acaf8(params.adjustedpath, currentpathsegment, 3));
                } else {
                    _setgoalpoint(bot, entity.origin, function_8d0acaf8(params.adjustedpath, currentpathsegment, 3));
                }
                bot.goalradius = 512;
            }
            continue;
        }
        _cleargameobject(bot);
        bot.goalradius = var_3809f8a5;
        _setgoalpoint(bot, currentcenter, function_8d0acaf8(params.adjustedpath, currentpathsegment, 3));
    }
    if (isdefined(params.object) && params.object.trigger istriggerenabled()) {
        return 3;
    } else if (isdefined(params.component)) {
        return 3;
    } else if (isdefined(params.bundle)) {
        return 3;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xf263f77, Offset: 0x3a38
// Size: 0x2d0
function private strategyclearareatodefendobjectupdate(planner, params) {
    /#
        _debugadjustedpath(params);
    #/
    if (!isdefined(params.object) || !isdefined(params.object.trigger) || !_paramshasbots(params)) {
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
    var_3809f8a5 = function_fdd68f12(params.bots);
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _cleargameobject(bot);
            if (currentpathsegment >= params.adjustedpath.size - 2) {
                _setgoalpoint(bot, params.object.origin);
                bot.goalradius = 512;
                continue;
            }
            _setgoalpoint(bot, currentcenter);
            bot.goalradius = var_3809f8a5;
        }
    }
    if (params.object.trigger istriggerenabled()) {
        return 3;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xaff27472, Offset: 0x3d10
// Size: 0x2c2
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
    var_3809f8a5 = function_fdd68f12(params.bots);
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _cleargameobject(bot);
            if (currentpathsegment >= params.adjustedpath.size - 2) {
                if (!bot isingoal(escort.origin)) {
                    _setgoalpoint(bot, escort.origin);
                    bot.goalradius = 512;
                }
                continue;
            }
            _setgoalpoint(bot, currentcenter);
            bot.goalradius = var_3809f8a5;
        }
    }
    return 3;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x58c6f62d, Offset: 0x3fe0
// Size: 0x3b4
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
    var_3809f8a5 = function_fdd68f12(params.bots);
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _cleargameobject(bot);
            if (currentpathsegment >= params.adjustedpath.size - 2) {
                trigger = params.objective[#"__unsafe__"][#"trigger"];
                if (isdefined(trigger)) {
                    function_4f739ba7(bot, trigger);
                } else {
                    _setgoalpoint(bot, params.objective[#"origin"]);
                    bot.goalradius = 512;
                }
                if (isdefined(params.objective[#"radius"])) {
                    bot.goalradius = params.objective[#"radius"];
                }
                continue;
            }
            _setgoalpoint(bot, currentcenter, function_8d0acaf8(params.adjustedpath, currentpathsegment, 3));
            bot.goalradius = var_3809f8a5;
        }
    }
    if (isdefined(params.objective) && objective_state(params.objective[#"id"]) == "active") {
        return 3;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x2039b416, Offset: 0x43a0
// Size: 0x13a
function private strategyhasattackobject(planner, constants) {
    team = planner::getblackboardattribute(planner, "team");
    objects = planner::getblackboardattribute(planner, "gameobjects");
    if (isdefined(objects)) {
        foreach (object in objects) {
            if (object[#"team"] == team || object[#"team"] == #"any" || object[#"team"] == "free") {
                return true;
            }
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xc598f62e, Offset: 0x44e8
// Size: 0x13e
function private strategyhasescort(planner, constants) {
    escorts = planner::getblackboardattribute(planner, "escorts");
    if (!isarray(escorts) || escorts.size <= 0) {
        return false;
    }
    escortkey = constants[#"key"];
    if (!isstring(escortkey) && !ishash(escortkey) || escortkey == "") {
        return true;
    }
    for (i = 0; i < escorts.size; i++) {
        escort = escorts[i][#"__unsafe__"][escortkey];
        if (isdefined(escort)) {
            return true;
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x1cf0fdcf, Offset: 0x4630
// Size: 0x62
function private strategyhasescortpoi(planner, constants) {
    escortpoi = planner::getblackboardattribute(planner, "escort_poi");
    return isarray(escortpoi) && escortpoi.size > 0;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xd9f42434, Offset: 0x46a0
// Size: 0x34
function private strategyhasforcegoal(planner, constants) {
    return isdefined(planner::getblackboardattribute(planner, "force_goal"));
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x88061899, Offset: 0x46e0
// Size: 0xf6
function private function_fc993775(planner, constants) {
    assert(isstring(constants[#"key"]) || ishash(constants[#"key"]), "<dev string:x49>" + "<invalid>" + "<dev string:x8f>");
    attribute = planner::getblackboardattribute(planner, constants[#"key"]);
    if (isdefined(attribute) && isarray(attribute)) {
        return (attribute.size > 0);
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xf0d2181, Offset: 0x47e0
// Size: 0x25a
function private function_bf7c447e(planner, constants) {
    assert(isfloat(constants[#"percent"]), "<dev string:x49>" + "<invalid>" + "<dev string:xe7>");
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bot = botinfo[#"__unsafe__"][#"bot"];
        if (!strategiccommandutility::isvalidbot(bot)) {
            continue;
        }
        weapons = bot getweaponslistprimaries();
        foreach (weapon in weapons) {
            if (isdefined(weapon) && weapon.name != "none") {
                currentammo = bot getammocount(weapon);
                maxammo = weapon.maxammo;
                if (isdefined(maxammo) && maxammo > 0) {
                    ammofraction = currentammo / maxammo;
                    if (ammofraction >= constants[#"percent"]) {
                        return false;
                    }
                }
            }
        }
        return true;
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xe2241ba5, Offset: 0x4a48
// Size: 0x254
function private strategyhasbelowxammounsafe(planner, constants) {
    assert(isfloat(constants[#"percent"]), "<dev string:x49>" + "<invalid>" + "<dev string:xe7>");
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bot = botinfo[#"__unsafe__"][#"bot"];
        if (!strategiccommandutility::isvalidbot(bot)) {
            continue;
        }
        weapons = bot getweaponslistprimaries();
        foreach (weapon in weapons) {
            if (isdefined(weapon) && weapon.name != "none") {
                currentammo = bot getammocount(weapon);
                maxammo = weapon.maxammo;
                if (isdefined(maxammo) && maxammo > 0) {
                    ammofraction = currentammo / maxammo;
                    if (ammofraction < constants[#"percent"]) {
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
// Checksum 0x57341a9b, Offset: 0x4ca8
// Size: 0xf2
function private strategyhasblackboardvalue(planner, constants) {
    assert(isarray(constants));
    assert(isstring(constants[#"name"]) || ishash(constants[#"name"]));
    value = planner::getblackboardattribute(planner, constants[#"name"]);
    return value == constants[#"value"];
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xa2477136, Offset: 0x4da8
// Size: 0x13a
function private strategyhasdefendobject(planner, constants) {
    team = planner::getblackboardattribute(planner, "team");
    objects = planner::getblackboardattribute(planner, "gameobjects");
    if (isdefined(objects)) {
        foreach (object in objects) {
            if (object[#"team"] != team && object[#"team"] != #"any" && object[#"team"] != "free") {
                return true;
            }
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x6f5eb960, Offset: 0x4ef0
// Size: 0x10c
function private strategyhasobjective(planner, constants) {
    team = planner::getblackboardattribute(planner, "team");
    objects = planner::getblackboardattribute(planner, "objectives");
    if (isdefined(objects)) {
        foreach (object in objects) {
            if (objective_state(object[#"id"]) == "active") {
                return true;
            }
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xa66014cb, Offset: 0x5008
// Size: 0x5a
function private function_1cdf2c86(planner, constants) {
    order = planner::getblackboardattribute(planner, "order");
    return order === constants[#"order"];
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x47fe9150, Offset: 0x5070
// Size: 0x114
function private function_5bae5471(planner, constants) {
    team = planner::getblackboardattribute(planner, "team");
    target = planner::getblackboardattribute(planner, "target");
    if (isdefined(target)) {
        switch (target[#"type"]) {
        case #"gameobject":
            return true;
        case #"goto":
            return true;
        case #"destroy":
            return true;
        case #"defend":
            return true;
        case #"capturearea":
            return true;
        case #"escortbiped":
            return true;
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x6054669, Offset: 0x5190
// Size: 0x52
function private strategyhaspathableammocache(planner, constants) {
    ammocaches = planner::getblackboardattribute(planner, "pathable_ammo_caches");
    return isdefined(ammocaches) && ammocaches.size > 0;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x29b4463a, Offset: 0x51f0
// Size: 0x11c
function private strategyrushammocacheinit(planner, params) {
    if (!isdefined(params.ammo) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _setgoalpoint(bot, params.ammo.origin);
            bot.goalradius = 512;
            _assigngameobject(bot, params.ammo);
        }
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x1cae3402, Offset: 0x5318
// Size: 0x1f8
function private function_bdb0cbe9(planner, constants) {
    assert(isfloat(constants[#"percent"]), "<dev string:x49>" + "<invalid>" + "<dev string:xe7>");
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bot = botinfo[#"__unsafe__"][#"bot"];
        if (!strategiccommandutility::isvalidbot(bot)) {
            continue;
        }
        weapon = bot getcurrentweapon();
        if (isdefined(weapon) && weapon.name != "none") {
            currentammo = bot getammocount(weapon);
            maxammo = weapon.maxammo;
            if (isdefined(maxammo) && maxammo > 0) {
                ammofraction = currentammo / maxammo;
                if (ammofraction < constants[#"percent"]) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xc9de9017, Offset: 0x5518
// Size: 0x38
function private function_8eeb4602(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xc52cfe43, Offset: 0x5558
// Size: 0x440
function private function_2e38242f(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (!isalive(bot) || !strategiccommandutility::isvalidbot(bot) || !isdefined(bot.var_9b5f4d) || !bot.var_9b5f4d.size > 0 || bot bot_chain::function_3a0e73ad()) {
            continue;
        }
        goalinfo = bot function_e9a79b0e();
        if (goalinfo.goalforced) {
            continue;
        }
        crumb = bot.var_9b5f4d[0];
        botnum = bot getentitynumber();
        if (isdefined(crumb.var_bf93d636) && isdefined(crumb.var_bf93d636[botnum])) {
            continue;
        }
        if (isdefined(crumb.target)) {
            var_b2dfa01c = struct::get_array(crumb.target, "targetname");
            botchains = [];
            foreach (var_23fd7edd in var_b2dfa01c) {
                if (var_23fd7edd.variantname === "bot_chain") {
                    botchains[botchains.size] = var_23fd7edd;
                }
            }
            if (botchains.size > 0) {
                bot thread bot_chain::function_92ea793e(botchains[randomint(botchains.size)]);
                if (!isdefined(crumb.var_bf93d636)) {
                    crumb.var_bf93d636 = [];
                } else if (!isarray(crumb.var_bf93d636)) {
                    crumb.var_bf93d636 = array(crumb.var_bf93d636);
                }
                crumb.var_bf93d636[botnum] = 1;
                continue;
            }
        }
        component = crumb.var_a06b4dbd;
        targetvol = undefined;
        if (isdefined(component)) {
            if (isdefined(component.var_d9c3be3e)) {
                targetvol = component.var_d9c3be3e;
            } else if (isdefined(component.e_objective) && isdefined(component.e_objective.mdl_gameobject)) {
                targetvol = component.e_objective.mdl_gameobject.trigger;
            }
        } else if (isdefined(crumb.trigger)) {
            targetvol = crumb.trigger;
        }
        if (isdefined(targetvol)) {
            bot setgoal(targetvol);
        }
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x87231224, Offset: 0x59a0
// Size: 0xba
function private function_92c678c2(planner, params) {
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _cleargameobject(bot);
            bot.goalradius = 256;
        }
    }
    return true;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x46dad62d, Offset: 0x5a68
// Size: 0xe2
function private function_cf4953ef(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _setgoalpoint(bot, bot.origin);
            bot.goalradius = 256;
        }
    }
    return 3;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x7489c3ff, Offset: 0x5b58
// Size: 0x51e
function private strategyrushammocacheparam(planner, constants) {
    assert(isint(constants[#"distance"]) || isfloat(constants[#"distance"]), "<dev string:x49>" + "<invalid>" + "<dev string:x1a8>");
    params = spawnstruct();
    params.bots = [];
    botpositions = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bot = botinfo[#"__unsafe__"][#"bot"];
        if (strategiccommandutility::isvalidbot(bot)) {
            botposition = getclosestpointonnavmesh(botinfo[#"origin"], 200);
            if (isdefined(botposition)) {
                botpositions[botpositions.size] = botposition;
            }
            params.bots[params.bots.size] = bot;
        }
    }
    possiblecaches = [];
    distancesq = constants[#"distance"] * constants[#"distance"];
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
                if (pathsegment.pathdistance > constants[#"distance"]) {
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
// Checksum 0xf64e548f, Offset: 0x6080
// Size: 0x14a
function private strategyrushammocacheupdate(planner, params) {
    if (!isdefined(params.ammo) || !_paramshasbots(params)) {
        return 2;
    }
    if (params.ammo.trigger istriggerenabled()) {
        foreach (bot in params.bots) {
            if (strategiccommandutility::isvalidbot(bot)) {
                _setgoalpoint(bot, params.ammo.origin);
                bot.goalradius = 512;
                _assigngameobject(bot, params.ammo);
            }
        }
        return 3;
    }
    return 2;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x87bcd83a, Offset: 0x61d8
// Size: 0x114
function private strategyrushattackobjectinit(planner, params) {
    if (!isdefined(params.object) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (params.object.triggertype == "proximity") {
            function_4f739ba7(bot, params.object.trigger);
            continue;
        }
        _assigngameobject(bot, params.object);
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xdf1260cd, Offset: 0x62f8
// Size: 0x78
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
// Checksum 0x90e8f366, Offset: 0x6378
// Size: 0x112
function private strategyrushdefendobjectinit(planner, params) {
    if (!isdefined(params.object) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _cleargameobject(bot);
            _setgoalpoint(bot, params.object.origin);
            bot.goalradius = 512;
        }
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xba7bb7d9, Offset: 0x6498
// Size: 0x78
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
// Checksum 0x7e969331, Offset: 0x6518
// Size: 0x224
function private strategyrushescortparam(planner, constants) {
    params = spawnstruct();
    escorts = planner::getblackboardattribute(planner, "escorts");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    params.escort = escorts[0][#"__unsafe__"][#"player"];
    if (isdefined(params.escort)) {
        foreach (bot in bots) {
            if (strategiccommandutility::isvalidbot(bot)) {
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
// Checksum 0x23104eb4, Offset: 0x6748
// Size: 0x10a
function private function_1675af4a(planner, params) {
    if (!isdefined(params.escort) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            bot bot::clear_interact();
            bot setgoal(params.escort);
            bot.goalradius = 512;
        }
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x29b7d07a, Offset: 0x6860
// Size: 0x4e
function private function_40fe6867(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    if (isdefined(params.escort)) {
        return 3;
    }
    return 2;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x22bd10fa, Offset: 0x68b8
// Size: 0xfc
function private strategyrushforcegoalinit(planner, params) {
    if (!isdefined(params.goal) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _cleargameobject(bot);
            bot setgoal(params.goal);
        }
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xf161cb60, Offset: 0x69c0
// Size: 0x4e
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
// Checksum 0xec563c86, Offset: 0x6a18
// Size: 0x162
function private strategyrushobjectiveinit(planner, params) {
    if (!isdefined(params.objective) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _cleargameobject(bot);
            _setgoalpoint(bot, params.objective[#"origin"]);
            bot.goalradius = 512;
            if (isdefined(params.objective[#"radius"])) {
                bot.goalradius = params.objective[#"radius"];
            }
        }
    }
    return 1;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x63d07edd, Offset: 0x6b88
// Size: 0x304
function private strategyrushobjectiveparam(planner, constants) {
    params = spawnstruct();
    objectives = planner::getblackboardattribute(planner, "objectives");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    params.objective = objectives[0];
    if (isdefined(params.objective)) {
        trigger = params.objective[#"__unsafe__"][#"trigger"];
        if (isdefined(trigger)) {
            foreach (bot in bots) {
                if (strategiccommandutility::isvalidbot(bot)) {
                    params.path = strategiccommandutility::calculatepathtotrigger(bot, trigger);
                    if (isdefined(params.path)) {
                        break;
                    }
                }
            }
        } else {
            foreach (bot in bots) {
                if (strategiccommandutility::isvalidbot(bot)) {
                    params.path = strategiccommandutility::calculatepathtoposition(bot, objective_position(params.objective[#"id"]));
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
// Checksum 0x863eaf1a, Offset: 0x6e98
// Size: 0x8c
function private strategyrushobjectiveupdate(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    if (isdefined(params.objective) && objective_state(params.objective[#"id"]) == "active") {
        return 3;
    }
    return 2;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x415672cc, Offset: 0x6f30
// Size: 0x282
function private function_9bc3a68f(planner, constants) {
    assert(isarray(constants));
    assert(isstring(constants[#"focus"]) || ishash(constants[#"focus"]));
    target = planner::getblackboardattribute(planner, "target");
    if (isdefined(target)) {
        var_59a4bd81 = target[#"strategy"];
        var_581ce9c3 = strategiccommandutility::function_be0f2866(constants[#"focus"]);
        squadbots = planner::getblackboardattribute(planner, "doppelbots");
        if (isstruct(var_59a4bd81)) {
            foreach (botinfo in squadbots) {
                bot = botinfo[#"__unsafe__"][#"bot"];
                var_199f6661 = "doppelbotsfocus";
                foreach (focus in var_581ce9c3) {
                    if (var_59a4bd81.(var_199f6661) == focus) {
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
// Checksum 0x980101df, Offset: 0x71c0
// Size: 0x148
function private function_8405010c(planner, constants) {
    assert(isarray(constants));
    assert(isstring(constants[#"tactics"]) || ishash(constants[#"tactics"]));
    var_1083d424 = constants[#"tactics"];
    target = planner::getblackboardattribute(planner, "target");
    if (isdefined(target)) {
        var_59a4bd81 = target[#"strategy"];
        if (isstruct(var_59a4bd81)) {
            return (var_59a4bd81.("doppelbotstactics") == var_1083d424);
        }
    }
    return false;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x9e27ff1a, Offset: 0x7310
// Size: 0xba
function private strategywanderinit(planner, params) {
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            _cleargameobject(bot);
            bot.goalradius = 128;
        }
    }
    return true;
}

// Namespace plannersquadutility/planner_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x1d16d03b, Offset: 0x73d8
// Size: 0x24a
function private strategywanderupdate(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            if (!isdefined(bot._wander_update_time)) {
                bot._wander_update_time = 0;
            }
            if (bot._wander_update_time + 3000 < gettime() || bot isingoal(bot.origin)) {
                searchradius = 1024;
                navmeshpoint = getclosestpointonnavmesh(bot.origin, 200);
                if (isdefined(navmeshpoint)) {
                    forward = anglestoforward(bot getangles());
                    forwardpos = bot.origin + forward * searchradius;
                    cylinder = ai::t_cylinder(bot.origin, searchradius, searchradius);
                    points = tacticalquery(#"stratcom_tacquery_wander", navmeshpoint, cylinder, forwardpos, bot);
                    if (points.size > 0) {
                        _setgoalpoint(bot, points[0].origin);
                        bot._wander_update_time = gettime();
                    }
                }
            }
        }
    }
    return 3;
}

