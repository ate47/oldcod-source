#using scripts\core_common\ai\planner_squad;
#using scripts\core_common\ai\planner_squad_utility;
#using scripts\core_common\ai\strategic_command;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\planner;
#using scripts\core_common\ai\systems\planner_blackboard;
#using scripts\core_common\bots\bot;
#using scripts\core_common\system_shared;

#namespace planner_zm_squad_utility;

// Namespace planner_zm_squad_utility/planner_zm_squad_utility
// Params 0, eflags: 0x2
// Checksum 0xdca1a2b6, Offset: 0xc8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"planner_zm_squad_utility", &namespace_cc602d22::__init__, undefined, undefined);
}

#namespace namespace_cc602d22;

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 0, eflags: 0x4
// Checksum 0x467050ce, Offset: 0x110
// Size: 0x324
function private __init__() {
    plannerutility::registerplannerapi(#"hash_711b9eb06d45dbbb", &function_adacc43e);
    plannerutility::registerplanneraction(#"hash_7590574799136eaf", &function_da58bd5e, &function_45919bed, &function_6661bfc0, &function_81f5da02);
    plannerutility::registerplanneraction(#"hash_31b1a32cd1190293", &function_59f8c213, &function_6cbb0436, &function_9907f63, &function_81f5da02);
    plannerutility::registerplanneraction(#"hash_552be54f85ea9d71", &function_dee08fed, &function_418d93ec, &function_4d526f05, &function_81f5da02);
    plannerutility::registerplanneraction(#"hash_74c3e478ecfaaeca", &function_9c4e68da, &function_45919bed, &function_6661bfc0, &function_81f5da02);
    plannerutility::registerplanneraction(#"hash_4a3f65a68af4f8af", &function_f897daab, &function_398ee27e, &function_ec1617bb, undefined);
    plannerutility::registerplanneraction(#"hash_6bda9193cf3ed07d", &function_ffc949a3, &function_e5987c86, &function_e97c05b3, &function_81f5da02);
    plannerutility::registerplanneraction(#"hash_13ea5298a7e5b3ef", &function_b69391d3, &function_63b2a7f6, &function_ac154f23, &function_81f5da02);
    plannerutility::registerplanneraction(#"hash_7e8d0cffd4b5daf5", &plannersquadutility::strategybotparam, &function_87521590, &function_cdb479c9, &function_81f5da02);
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x6de25650, Offset: 0x440
// Size: 0x2b0
function private function_13923d97(bot, path) {
    var_bc8f663 = 0;
    if (isdefined(path) && isdefined(path.pathpoints) && path.pathpoints.size > 0) {
        adjustedpath = [];
        segmentlength = 128;
        pathpointssize = path.pathpoints.size;
        currentdistance = 0;
        currentpoint = path.pathpoints[0];
        adjustedpath[adjustedpath.size] = currentpoint;
        for (index = 1; index < pathpointssize; index++) {
            nextpoint = path.pathpoints[index];
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
        adjustedpath[adjustedpath.size] = path.pathpoints[pathpointssize - 1];
        var_bc8f663 = 0;
        foreach (point in adjustedpath) {
            var_bc8f663 += pow(bot getenemiesinradius(point, 128).size, 1.5);
        }
    }
    return var_bc8f663;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x1ad4baee, Offset: 0x6f8
// Size: 0xa4
function private function_f816f767(weapon) {
    if (isdefined(weapon.firetype) && weapon.firetype == #"single shot") {
        if (weapon.clipsize < 20) {
            return 0.5;
        }
        return 0.8;
    } else if (weapon.firetype === "Burst") {
        if (weapon.clipsize < 20) {
            return 0.65;
        }
        return 0.8;
    }
    return 1;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 1, eflags: 0x4
// Checksum 0xe6b83874, Offset: 0x7a8
// Size: 0x10a
function private function_94f80d6b(weapon) {
    var_b2784763 = weapon.clipsize * weapon.firetime + weapon.reloadtime;
    if (isdefined(weapon.firetype) && weapon.firetype == #"single shot") {
        var_b2784763 += weapon.clipsize * 0.5;
    }
    if (var_b2784763 <= 0) {
        return 0;
    }
    var_95bdba1f = 1 / var_b2784763;
    var_c9cf6729 = weapon.clipsize * function_729d629b(weapon) * function_f816f767(weapon);
    damagepersecond = var_c9cf6729 * var_95bdba1f;
    return damagepersecond;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x2b9a6e72, Offset: 0x8c0
// Size: 0x16
function private function_729d629b(weapon) {
    return weapon.maxdamage;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x87b06db5, Offset: 0x8e0
// Size: 0x6a
function private function_48ddc8e5(bot) {
    currentweapon = bot getcurrentweapon();
    ammo = bot getammocount(currentweapon);
    return function_c222ea5a(bot, currentweapon, ammo);
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 3, eflags: 0x4
// Checksum 0xc274968d, Offset: 0x958
// Size: 0x126
function private function_c222ea5a(bot, weapon, ammo = undefined) {
    assert(isbot(bot));
    assert(isweapon(weapon));
    ammo = isdefined(ammo) ? ammo : weapon.maxammo + weapon.clipsize;
    var_d29ee4f7 = ammo * function_729d629b(weapon);
    damagepersecond = function_94f80d6b(weapon);
    if (damagepersecond <= 0 || var_d29ee4f7 <= 0) {
        return 0;
    }
    return damagepersecond * 2 + var_d29ee4f7 * 0.05;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 1, eflags: 0x4
// Checksum 0xdd41a5c3, Offset: 0xa88
// Size: 0x92
function private _paramshasbots(params) {
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x2d1c674, Offset: 0xb28
// Size: 0x1e2
function private function_7e779843(planner) {
    params = spawnstruct();
    params.bots = [];
    params.botpositions = [];
    params.var_941f4e90 = undefined;
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bot = botinfo[#"__unsafe__"][#"bot"];
        if (strategiccommandutility::isvalidbot(bot)) {
            botposition = getclosestpointonnavmesh(bot.origin, 200);
            if (isdefined(botposition)) {
                params.botpositions[params.botpositions.size] = botposition;
            }
            params.bots[params.bots.size] = bot;
            if (!isdefined(params.var_941f4e90) || bot.score < params.var_941f4e90) {
                params.var_941f4e90 = bot.score;
            }
        }
    }
    if (!isdefined(params.var_941f4e90)) {
        params.var_941f4e90 = 0;
    }
    return params;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x7beb335d, Offset: 0xd18
// Size: 0x6a
function private function_8a435150(bot) {
    if (isdefined(bot) && isbot(bot)) {
        bot setgoal(bot.origin);
        bot.goalradius = 512;
        bot.goalheight = 100;
    }
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xcb0bcf17, Offset: 0xd90
// Size: 0xc6
function private function_241b78d1(bot, altar) {
    assert(isbot(bot));
    assert(isstruct(altar));
    specialty = bot.var_871d24d3[altar.script_int];
    return isdefined(bot.var_dd533644) && isdefined(bot.var_dd533644[specialty]) && bot.var_dd533644[specialty] > 0;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x27f1b87a, Offset: 0xe60
// Size: 0x90
function private function_81f5da02(planner, params) {
    foreach (bot in params.bots) {
        function_8a435150(bot);
    }
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x4d5732d6, Offset: 0xef8
// Size: 0x18a
function private function_6cbb0436(planner, params) {
    if (!isdefined(params.altar) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            altar = params.altar[#"__unsafe__"][#"altar"];
            var_c401fc0f = getclosestpointonnavmesh(params.altar[#"origin"], 200, bot getpathfindingradius());
            bot bot::set_interact(altar);
            bot setgoal(var_c401fc0f);
            bot.goalradius = 512;
        }
    }
    return 1;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xe82871cd, Offset: 0x1090
// Size: 0xde
function private function_9907f63(planner, params) {
    if (!isdefined(params.altar) || !_paramshasbots(params)) {
        return 2;
    }
    altar = params.altar[#"__unsafe__"][#"altar"];
    if (!isdefined(altar) || function_241b78d1(params.bots[0], altar)) {
        params.bots[0] bot::clear_interact();
        return 2;
    }
    return 3;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x832f07f9, Offset: 0x1178
// Size: 0x66e
function private function_59f8c213(planner, constants) {
    assert(isint(constants[#"distance"]) || isfloat(constants[#"distance"]), "<dev string:x30>" + "<invalid>" + "<dev string:x6a>");
    assert(isint(constants[#"affordability"]) || isfloat(constants[#"affordability"]), "<dev string:x30>" + "<invalid>" + "<dev string:x92>");
    params = function_7e779843(planner);
    if (params.bots.size <= 0) {
        return params;
    }
    var_2a57d64b = [];
    distancesq = constants[#"distance"] * constants[#"distance"];
    altars = planner::getblackboardattribute(planner, #"zm_altars");
    if (!isdefined(altars)) {
        altars = [];
    }
    foreach (var_35e2ffb in altars) {
        if (isdefined(var_35e2ffb)) {
            altar = var_35e2ffb[#"__unsafe__"][#"altar"];
            if (function_241b78d1(params.bots[0], altar)) {
                continue;
            }
            perk = params.bots[0].var_871d24d3[altar.script_int];
            if (!isdefined(perk) || !isdefined(level._custom_perks) || !isdefined(level._custom_perks[perk])) {
                continue;
            }
            customperk = level._custom_perks[perk];
            cost = customperk.cost;
            if (isfunctionptr(level._custom_perks[perk].cost)) {
                cost = [[ level._custom_perks[perk].cost ]]();
            }
            if (cost > params.var_941f4e90 || cost / params.var_941f4e90 > constants[#"affordability"]) {
                continue;
            }
            closeenough = 1;
            foreach (botposition in params.botpositions) {
                if (distance2dsquared(var_35e2ffb[#"origin"], botposition) > distancesq) {
                    closeenough = 0;
                    break;
                }
            }
            if (closeenough) {
                var_2a57d64b[var_2a57d64b.size] = var_35e2ffb;
            }
        }
    }
    path = undefined;
    shortestpath = undefined;
    var_83f8c772 = undefined;
    foreach (var_35e2ffb in var_2a57d64b) {
        altar = var_35e2ffb[#"__unsafe__"][#"altar"];
        pathsegment = strategiccommandutility::function_b5a3d333(params.bots[0], altar);
        if (isdefined(pathsegment) && isdefined(pathsegment.status) && pathsegment.status == #"succeeded") {
            if (pathsegment.pathdistance > constants[#"distance"] * 2) {
                continue;
            }
            if (!isdefined(path) || pathsegment.pathdistance < shortestpath) {
                if (function_13923d97(params.bots[0], pathsegment) <= 4.5) {
                    path = pathsegment;
                    shortestpath = pathsegment.pathdistance;
                    var_83f8c772 = var_35e2ffb;
                }
            }
        }
    }
    if (isdefined(var_83f8c772)) {
        planner::setblackboardattribute(planner, #"hash_6f9d6de0fc2bd62e", array(var_83f8c772));
        params.altar = var_83f8c772;
    }
    return params;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xd40bbee2, Offset: 0x17f0
// Size: 0x18a
function private function_418d93ec(planner, params) {
    if (!isdefined(params.blocker) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            blocker = params.blocker[#"__unsafe__"][#"blocker"];
            var_7ea1ecb5 = getclosestpointonnavmesh(params.blocker[#"origin"], 200, bot getpathfindingradius());
            bot bot::set_interact(blocker);
            bot setgoal(var_7ea1ecb5);
            bot.goalradius = 512;
        }
    }
    return 1;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x739dc579, Offset: 0x1988
// Size: 0x59e
function private function_dee08fed(planner, constants) {
    assert(isint(constants[#"distance"]) || isfloat(constants[#"distance"]), "<dev string:x30>" + "<invalid>" + "<dev string:x6a>");
    assert(isint(constants[#"affordability"]) || isfloat(constants[#"affordability"]), "<dev string:x30>" + "<invalid>" + "<dev string:x92>");
    params = function_7e779843(planner);
    if (params.bots.size <= 0) {
        return params;
    }
    var_cd224ec5 = [];
    distancesq = constants[#"distance"] * constants[#"distance"];
    blockers = planner::getblackboardattribute(planner, #"zm_blockers");
    if (!isdefined(blockers)) {
        blockers = [];
    }
    foreach (var_3d6883e9 in blockers) {
        if (isdefined(var_3d6883e9) && var_3d6883e9[#"cost"] <= params.var_941f4e90 && var_3d6883e9[#"cost"] / params.var_941f4e90 <= constants[#"affordability"]) {
            closeenough = 1;
            foreach (botposition in params.botpositions) {
                if (distance2dsquared(var_3d6883e9[#"origin"], botposition) > distancesq) {
                    closeenough = 0;
                    break;
                }
            }
            if (closeenough) {
                var_cd224ec5[var_cd224ec5.size] = var_3d6883e9;
            }
        }
    }
    path = undefined;
    shortestpath = undefined;
    var_723e14a4 = undefined;
    foreach (var_3d6883e9 in var_cd224ec5) {
        blocker = var_3d6883e9[#"__unsafe__"][#"blocker"];
        if (!isdefined(blocker) || blocker._door_open === 1 || blocker.has_been_opened === 1) {
            continue;
        }
        pathsegment = strategiccommandutility::calculatepathtotrigger(params.bots[0], blocker);
        if (isdefined(pathsegment) && isdefined(pathsegment.status) && pathsegment.status == #"succeeded") {
            if (pathsegment.pathdistance > constants[#"distance"] * 2) {
                continue;
            }
            if (!isdefined(path) || pathsegment.pathdistance < shortestpath) {
                if (function_13923d97(params.bots[0], pathsegment) <= 4.5) {
                    path = pathsegment;
                    shortestpath = pathsegment.pathdistance;
                    var_723e14a4 = var_3d6883e9;
                }
            }
        }
    }
    if (isdefined(var_723e14a4)) {
        planner::setblackboardattribute(planner, #"zm_pathable_blockers", array(var_723e14a4));
        params.blocker = var_723e14a4;
    }
    return params;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x4bd5d4ee, Offset: 0x1f30
// Size: 0xc0
function private function_4d526f05(planner, params) {
    if (!isdefined(params.blocker) || !_paramshasbots(params)) {
        return 2;
    }
    blocker = params.blocker[#"__unsafe__"][#"blocker"];
    if (!isdefined(blocker) || blocker._door_open === 1 || blocker.has_been_opened === 1) {
        return 2;
    }
    return 3;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xd3889fb8, Offset: 0x1ff8
// Size: 0x18a
function private function_45919bed(planner, params) {
    if (!isdefined(params.chest) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            chest = params.chest[#"__unsafe__"][#"chest"];
            chestpos = getclosestpointonnavmesh(params.chest[#"origin"], 200, bot getpathfindingradius());
            bot bot::set_interact(chest);
            bot setgoal(chestpos);
            bot.goalradius = 512;
        }
    }
    return 1;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x3c0935ea, Offset: 0x2190
// Size: 0x5ae
function private function_9c4e68da(planner, constants) {
    assert(isint(constants[#"distance"]) || isfloat(constants[#"distance"]), "<dev string:x30>" + "<invalid>" + "<dev string:x6a>");
    assert(isint(constants[#"affordability"]) || isfloat(constants[#"affordability"]), "<dev string:x30>" + "<invalid>" + "<dev string:x92>");
    params = function_7e779843(planner);
    if (params.bots.size <= 0) {
        return params;
    }
    var_d647dfd2 = [];
    distancesq = constants[#"distance"] * constants[#"distance"];
    chests = planner::getblackboardattribute(planner, #"zm_chests");
    if (!isdefined(chests)) {
        chests = [];
    }
    foreach (var_3b3872f7 in chests) {
        if (isdefined(var_3b3872f7) && var_3b3872f7[#"cost"] <= params.var_941f4e90 && var_3b3872f7[#"cost"] / params.var_941f4e90 <= constants[#"affordability"]) {
            closeenough = 1;
            foreach (botposition in params.botpositions) {
                if (distance2dsquared(var_3b3872f7[#"origin"], botposition) > distancesq) {
                    closeenough = 0;
                    break;
                }
            }
            if (closeenough) {
                var_d647dfd2[var_d647dfd2.size] = var_3b3872f7;
            }
        }
    }
    path = undefined;
    shortestpath = undefined;
    var_6dbee871 = undefined;
    foreach (var_3b3872f7 in var_d647dfd2) {
        chest = var_3b3872f7[#"__unsafe__"][#"chest"];
        if (!isdefined(chest) || chest.hidden || isdefined(chest._box_open) && chest._box_open) {
            continue;
        }
        pathsegment = strategiccommandutility::function_b5a3d333(params.bots[0], chest.unitrigger_stub);
        if (isdefined(pathsegment) && isdefined(pathsegment.status) && pathsegment.status == #"succeeded") {
            if (pathsegment.pathdistance > constants[#"distance"] * 2) {
                continue;
            }
            if (!isdefined(path) || pathsegment.pathdistance < shortestpath) {
                if (function_13923d97(params.bots[0], pathsegment) <= 4.5) {
                    path = pathsegment;
                    shortestpath = pathsegment.pathdistance;
                    var_6dbee871 = var_3b3872f7;
                }
            }
        }
    }
    if (isdefined(var_6dbee871)) {
        planner::setblackboardattribute(planner, #"zm_pathable_chests", array(var_6dbee871));
        params.chest = var_6dbee871;
    }
    return params;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x0
// Checksum 0xf21326c9, Offset: 0x2748
// Size: 0x3c6
function function_da58bd5e(planner, constants) {
    params = function_7e779843(planner);
    if (params.bots.size <= 0) {
        return params;
    }
    var_d647dfd2 = [];
    chests = planner::getblackboardattribute(planner, #"zm_chests");
    if (!isdefined(chests)) {
        chests = [];
    }
    foreach (var_3b3872f7 in chests) {
        if (isdefined(var_3b3872f7)) {
            chest = var_3b3872f7[#"__unsafe__"][#"chest"];
            if (isdefined(chest.chest_user) && chest.chest_user === params.bots[0] && isdefined(chest._box_open) && chest._box_open && isdefined(chest.grab_weapon) && chest.grab_weapon.firetype !== "Single Shot") {
                var_d647dfd2[var_d647dfd2.size] = var_3b3872f7;
            }
        }
    }
    path = undefined;
    shortestpath = undefined;
    var_6dbee871 = undefined;
    foreach (var_3b3872f7 in var_d647dfd2) {
        chest = var_3b3872f7[#"__unsafe__"][#"chest"];
        if (!isdefined(chest) || chest.hidden) {
            continue;
        }
        pathsegment = strategiccommandutility::function_b5a3d333(params.bots[0], chest.unitrigger_stub);
        if (isdefined(pathsegment) && isdefined(pathsegment.status) && pathsegment.status == #"succeeded") {
            if (!isdefined(path) || pathsegment.pathdistance < shortestpath) {
                if (function_13923d97(params.bots[0], pathsegment) <= 4.5) {
                    path = pathsegment;
                    shortestpath = pathsegment.pathdistance;
                    var_6dbee871 = var_3b3872f7;
                }
            }
        }
    }
    if (isdefined(var_6dbee871)) {
        planner::setblackboardattribute(planner, #"zm_pathable_chests", array(var_6dbee871));
        params.chest = var_6dbee871;
    }
    return params;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xb549c111, Offset: 0x2b18
// Size: 0xa2
function private function_6661bfc0(planner, params) {
    if (!isdefined(params.chest) || !_paramshasbots(params)) {
        return 2;
    }
    chest = params.chest[#"__unsafe__"][#"chest"];
    if (!isdefined(chest) || chest.hidden) {
        return 2;
    }
    return 3;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x8a012aae, Offset: 0x2bc8
// Size: 0x54e
function private function_f897daab(planner, constants) {
    assert(isint(constants[#"distance"]) || isfloat(constants[#"distance"]), "<dev string:x30>" + "<invalid>" + "<dev string:x6a>");
    params = function_7e779843(planner);
    if (params.bots.size <= 0) {
        return params;
    }
    var_49c37c93 = [];
    distancesq = constants[#"distance"] * constants[#"distance"];
    powerups = planner::getblackboardattribute(planner, #"zm_powerups");
    if (!isdefined(powerups)) {
        powerups = [];
    }
    foreach (var_3d645607 in powerups) {
        closeenough = 1;
        powerup = var_3d645607[#"__unsafe__"][#"powerup"];
        if (!isdefined(powerup)) {
            continue;
        }
        foreach (botposition in params.botpositions) {
            if (distance2dsquared(powerup.origin, botposition) > distancesq) {
                closeenough = 0;
                break;
            }
        }
        if (closeenough) {
            var_49c37c93[var_49c37c93.size] = var_3d645607;
        }
    }
    path = undefined;
    shortestpath = undefined;
    var_d4b7ace2 = undefined;
    var_fe2dafd1 = 64;
    foreach (var_3d645607 in var_49c37c93) {
        powerup = var_3d645607[#"__unsafe__"][#"powerup"];
        poweruporigin = getclosestpointonnavmesh(powerup.origin, 200, params.bots[0] getpathfindingradius());
        if (!isdefined(poweruporigin)) {
            continue;
        }
        pointstruct = spawnstruct();
        pointstruct.origin = poweruporigin;
        pathsegment = strategiccommandutility::calculatepathtopoints(params.bots[0], array(pointstruct));
        if (isdefined(pathsegment) && isdefined(pathsegment.status) && pathsegment.status == #"succeeded") {
            if (pathsegment.pathdistance > constants[#"distance"] * 2) {
                continue;
            }
            if (!isdefined(path) || pathsegment.pathdistance < shortestpath) {
                if (function_13923d97(params.bots[0], pathsegment) <= 4.5) {
                    path = pathsegment;
                    shortestpath = pathsegment.pathdistance;
                    var_d4b7ace2 = var_3d645607;
                }
            }
        }
    }
    if (isdefined(var_d4b7ace2)) {
        planner::setblackboardattribute(planner, #"zm_pathable_powerups", array(var_d4b7ace2));
        params.powerup = var_d4b7ace2;
    }
    return params;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x1ddc1683, Offset: 0x3120
// Size: 0x192
function private function_398ee27e(planner, params) {
    if (!isdefined(params.powerup) || !_paramshasbots(params)) {
        return 2;
    }
    powerup = params.powerup[#"__unsafe__"][#"powerup"];
    if (!isdefined(powerup)) {
        return 2;
    }
    var_fe2dafd1 = 64;
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            var_7bf1cec3 = getclosestpointonnavmesh(powerup.origin, 200, bot getpathfindingradius());
            bot setgoal(var_7bf1cec3, 1);
            bot.goalradius = var_fe2dafd1 * 0.8;
        }
    }
    return 1;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x8541ad84, Offset: 0x32c0
// Size: 0xc6
function private function_ec1617bb(planner, params) {
    if (!isdefined(params.powerup) || !_paramshasbots(params)) {
        function_81f5da02(planner, params);
        return 2;
    }
    powerup = params.powerup[#"__unsafe__"][#"powerup"];
    if (!isdefined(powerup)) {
        function_81f5da02(planner, params);
        return 2;
    }
    return 3;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x7627a33a, Offset: 0x3390
// Size: 0x35e
function private function_ffc949a3(planner, constants) {
    assert(isint(constants[#"distance"]) || isfloat(constants[#"distance"]), "<dev string:x30>" + "<invalid>" + "<dev string:x6a>");
    params = function_7e779843(planner);
    if (params.bots.size <= 0) {
        return params;
    }
    var_a5b7f6dc = [];
    distancesq = constants[#"distance"] * constants[#"distance"];
    switches = planner::getblackboardattribute(planner, #"zm_switches");
    if (!isdefined(switches)) {
        switches = [];
    }
    path = undefined;
    shortestpath = undefined;
    var_97ca1d4e = undefined;
    foreach (var_8267f3e9 in switches) {
        switchent = var_8267f3e9[#"__unsafe__"][#"switch"];
        if (!isdefined(switchent)) {
            continue;
        }
        pathsegment = strategiccommandutility::calculatepathtotrigger(params.bots[0], switchent);
        if (isdefined(pathsegment) && isdefined(pathsegment.status) && pathsegment.status == #"succeeded") {
            if (pathsegment.pathdistance > constants[#"distance"] * 2) {
                continue;
            }
            if (!isdefined(path) || pathsegment.pathdistance < shortestpath) {
                if (function_13923d97(params.bots[0], pathsegment) <= 4.5) {
                    path = pathsegment;
                    shortestpath = pathsegment.pathdistance;
                    var_97ca1d4e = var_8267f3e9;
                }
            }
        }
    }
    if (isdefined(var_97ca1d4e)) {
        planner::setblackboardattribute(planner, #"zm_pathable_switches", array(var_97ca1d4e));
        params.var_2f80ea41 = var_97ca1d4e;
    }
    return params;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x86b01a8f, Offset: 0x36f8
// Size: 0x18a
function private function_e5987c86(planner, params) {
    if (!isdefined(params.var_2f80ea41) || !_paramshasbots(params)) {
        return 2;
    }
    switchent = params.var_2f80ea41[#"__unsafe__"][#"switch"];
    if (!isdefined(switchent)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            var_7e2012fd = getclosestpointonnavmesh(switchent.origin, 200, bot getpathfindingradius());
            bot bot::set_interact(switchent);
            bot setgoal(var_7e2012fd);
            bot.goalradius = 512;
        }
    }
    return 1;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xccc2898e, Offset: 0x3890
// Size: 0x90
function private function_e97c05b3(planner, params) {
    if (!isdefined(params.var_2f80ea41) || !_paramshasbots(params)) {
        return 2;
    }
    switchent = params.var_2f80ea41[#"__unsafe__"][#"switch"];
    if (!isdefined(switchent)) {
        return 2;
    }
    return 3;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xe83f8ebc, Offset: 0x3928
// Size: 0x18a
function private function_63b2a7f6(planner, params) {
    if (!isdefined(params.wallbuy) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            wallbuy = params.wallbuy[#"__unsafe__"][#"wallbuy"];
            var_53ae4a17 = getclosestpointonnavmesh(params.wallbuy[#"origin"], 200, bot getpathfindingradius());
            bot bot::set_interact(wallbuy);
            bot setgoal(var_53ae4a17);
            bot.goalradius = 512;
        }
    }
    return 1;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xc91a6bc, Offset: 0x3ac0
// Size: 0x86e
function private function_b69391d3(planner, constants) {
    assert(isint(constants[#"distance"]) || isfloat(constants[#"distance"]), "<dev string:x30>" + "<invalid>" + "<dev string:x6a>");
    assert(isint(constants[#"affordability"]) || isfloat(constants[#"affordability"]), "<dev string:x30>" + "<invalid>" + "<dev string:x92>");
    assert(isint(constants[#"hash_357612272d0dca05"]) || isfloat(constants[#"hash_357612272d0dca05"]), "<dev string:x30>" + "<invalid>" + "<dev string:x1ac>");
    var_5de8f535 = isdefined(constants[#"highcost"]) && constants[#"highcost"];
    var_14a5e540 = isdefined(constants[#"highrank"]) && constants[#"highrank"];
    if (var_14a5e540) {
        var_5de8f535 = 0;
    }
    params = function_7e779843(planner);
    if (params.bots.size <= 0) {
        return params;
    }
    var_5780716b = [];
    distancesq = constants[#"distance"] * constants[#"distance"];
    wallbuys = planner::getblackboardattribute(planner, #"zm_wallbuys");
    if (!isdefined(wallbuys)) {
        wallbuys = [];
    }
    foreach (var_4539a4f3 in wallbuys) {
        if (isdefined(var_4539a4f3) && var_4539a4f3[#"cost"] <= params.var_941f4e90 && var_4539a4f3[#"cost"] / params.var_941f4e90 <= constants[#"affordability"]) {
            closeenough = 1;
            foreach (botposition in params.botpositions) {
                if (distance2dsquared(var_4539a4f3[#"origin"], botposition) > distancesq) {
                    closeenough = 0;
                    break;
                }
            }
            if (closeenough) {
                var_5780716b[var_5780716b.size] = var_4539a4f3;
            }
        }
    }
    path = undefined;
    cost = 0;
    rank = -2147483647;
    shortestpath = undefined;
    var_29b04a3e = undefined;
    currentweaponrank = function_48ddc8e5(params.bots[0]);
    foreach (var_4539a4f3 in var_5780716b) {
        weapon = var_4539a4f3[#"weapon"];
        if (params.bots[0] getammocount(weapon) >= weapon.startammo * 0.5) {
            continue;
        }
        wallbuy = var_4539a4f3[#"__unsafe__"][#"wallbuy"];
        weaponrank = function_c222ea5a(params.bots[0], wallbuy.weapon);
        if (weaponrank - currentweaponrank < constants[#"hash_357612272d0dca05"]) {
            continue;
        }
        var_4fc5861e = params.bots[0] getpathfindingradius();
        var_53ae4a17 = getclosestpointonnavmesh(var_4539a4f3[#"origin"], 200, var_4fc5861e);
        if (isdefined(var_53ae4a17)) {
            pathsegment = generatenavmeshpath(var_53ae4a17, params.botpositions, params.bots[0]);
            if (isdefined(pathsegment) && isdefined(pathsegment.status) && pathsegment.status == #"succeeded") {
                if (pathsegment.pathdistance > constants[#"distance"] * 2) {
                    continue;
                }
                var_dcd69861 = !isdefined(path) || pathsegment.pathdistance < shortestpath;
                var_f9e32c6f = var_4539a4f3[#"cost"] > cost;
                var_420bd03a = weaponrank > rank;
                if (!isdefined(path) || var_5de8f535 && var_f9e32c6f || var_14a5e540 && var_420bd03a) {
                    if (function_13923d97(params.bots[0], pathsegment) <= 4.5) {
                        rank = weaponrank;
                        cost = var_4539a4f3[#"cost"];
                        path = pathsegment;
                        shortestpath = pathsegment.pathdistance;
                        var_29b04a3e = var_4539a4f3;
                    }
                }
            }
        }
    }
    if (isdefined(var_29b04a3e)) {
        planner::setblackboardattribute(planner, #"zm_pathable_wallbuys", array(var_29b04a3e));
        params.wallbuy = var_29b04a3e;
    }
    return params;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xa96b7a76, Offset: 0x4338
// Size: 0x4c
function private function_ac154f23(planner, params) {
    if (!isdefined(params.wallbuy) || !_paramshasbots(params)) {
        return 2;
    }
    return 3;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x6621a64d, Offset: 0x4390
// Size: 0xfa
function private function_adacc43e(planner, constants) {
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        bot = botinfo[#"__unsafe__"][#"bot"];
        if (!strategiccommandutility::isvalidbot(bot)) {
            continue;
        }
        if (bot getcurrentweapon().isgadget) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xd62ef0b4, Offset: 0x4498
// Size: 0xca
function private function_87521590(planner, params) {
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            bot bot::clear_interact();
            bot.goalradius = 512;
            bot.goalheight = 100;
        }
    }
    return true;
}

// Namespace namespace_cc602d22/planner_zm_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xad32e0b6, Offset: 0x4570
// Size: 0xd4
function private function_cdb479c9(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            bot setgoal(bot.origin);
        }
    }
    return 3;
}

