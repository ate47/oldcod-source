#using scripts\core_common\ai\planner_squad;
#using scripts\core_common\ai\planner_squad_utility;
#using scripts\core_common\ai\region_utility;
#using scripts\core_common\ai\strategic_command;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\planner;
#using scripts\core_common\ai\systems\planner_blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;

#namespace planner_mp_squad_utility;

// Namespace planner_mp_squad_utility/planner_mp_squad_utility
// Params 0, eflags: 0x2
// Checksum 0x1c5eb825, Offset: 0x160
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"planner_mp_squad_utility", &namespace_19d2010a::__init__, undefined, undefined);
}

#namespace namespace_19d2010a;

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 0, eflags: 0x4
// Checksum 0xae8a8199, Offset: 0x1a8
// Size: 0x384
function private __init__() {
    plannerutility::registerplannerapi(#"hash_7cb07a568d6f4cdf", &function_ca39a354);
    plannerutility::registerplannerapi(#"hash_a478e9ff1c93f25", &function_a54fd948);
    plannerutility::registerplannerapi(#"hash_6d04a8beefdd8300", &function_77a078d7);
    plannerutility::registerplannerapi(#"hash_4e7f3e0ab96fb7d6", &function_6a5948bb);
    plannerutility::registerplannerapi(#"hash_390ec5fab1695fc5", &function_80d9abe4);
    plannerutility::registerplannerapi(#"hash_729fab3e03b8972e", &function_738ce59b);
    plannerutility::registerplannerapi(#"hash_22435468ace59f07", &function_d073f8e);
    plannerutility::registerplanneraction(#"hash_238cb2b85abe80de", &function_2be5f80, &function_27a8f307, &function_b7896166, undefined);
    plannerutility::registerplanneraction(#"hash_3fff1f031065f09f", &function_38e747d9, &function_b88d288, &function_84c1bc71, undefined);
    plannerutility::registerplanneraction(#"hash_1d498d2dc9db37d7", &function_f19527ff, &function_e0f50932, &function_8d63a11f, undefined);
    plannerutility::registerplanneraction(#"hash_62f0edcdb7d80d62", &function_d8007dce, &function_89b7b6f1, &function_5af2ecb4, undefined);
    plannerutility::registerplanneraction(#"hash_44fb55c97ea86435", &function_33aa4bfb, &function_eee4918e, &function_d6c3ca0b, undefined);
    plannerutility::registerplanneraction(#"hash_7390712ebfb3d2d3", &function_9d10e6e1, &function_6e94d2e0, &function_f5216c19, undefined);
    plannerutility::registerplanneraction(#"hash_49c4e40e3e0f7be0", &function_59b991ac, &function_2d84eed3, &function_f3b07c32, undefined);
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x40923aa7, Offset: 0x538
// Size: 0xc6
function private _paramshasbots(params) {
    foreach (bot in params.bots) {
        if (isdefined(bot) && isbot(bot) && ai::getaiattribute(bot, "control") === "commander") {
            return true;
        }
    }
    return false;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 1, eflags: 0x4
// Checksum 0x790f4f4e, Offset: 0x608
// Size: 0x6a
function private function_8a435150(bot) {
    if (isdefined(bot) && isbot(bot)) {
        bot setgoal(bot.origin);
        bot.goalradius = 128;
        bot.goalheight = 128;
    }
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xc89962e6, Offset: 0x680
// Size: 0x18e
function private function_eb88edc6(bot, gameobject) {
    botpos = getclosestpointonnavmesh(bot.origin, 120, bot getpathfindingradius() * 1.05);
    var_1d3e8542 = getclosestpointonnavmesh(gameobject.origin, 200);
    if (!isdefined(botpos) || !isdefined(var_1d3e8542)) {
        return gameobject.origin;
    }
    queryresult = positionquery_source_navigation(var_1d3e8542, 0, 200, 100, 16, bot);
    if (queryresult.data.size > 0) {
        for (i = 0; i < queryresult.data.size; i++) {
            pathsegment = generatenavmeshpath(botpos, queryresult.data[i].origin, bot);
            if (isdefined(pathsegment) && pathsegment.status === "succeeded") {
                return queryresult.data[i].origin;
            }
        }
    }
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xf30f7bd6, Offset: 0x818
// Size: 0x214
function private function_92fb4c56(params, goal) {
    var_8a638a60 = 0;
    for (i = 0; i < params.bots.size; i++) {
        bot = params.bots[i];
        if (strategiccommandutility::isvalidbot(bot)) {
            goalinfo = bot function_e9a79b0e();
            tpoint = getclosesttacpoint(bot.origin);
            if (!isdefined(tpoint) && isdefined(goalinfo.regionid) && !goalinfo.isatgoal) {
                continue;
            }
            region = -1;
            if (isdefined(tpoint)) {
                region = tpoint.region;
            }
            for (j = 0; j < params.var_efeffa5b[i].size; j++) {
                if (region === params.var_efeffa5b[i][j]) {
                    break;
                }
            }
            if (j < params.var_efeffa5b[i].size - 2) {
                bot setgoal(params.var_efeffa5b[i][j + 1]);
                continue;
            }
            bot setgoal(goal);
            var_8a638a60++;
        }
    }
    if (var_8a638a60 == params.bots.size) {
        return 1;
    }
    return 3;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x6475e8d6, Offset: 0xa38
// Size: 0x90
function private function_81f5da02(planner, params) {
    foreach (bot in params.bots) {
        function_8a435150(bot);
    }
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 1, eflags: 0x4
// Checksum 0xbd35899b, Offset: 0xad0
// Size: 0x10a
function private function_2cbb0384(params) {
    for (i = 0; i < params.bots.size; i++) {
        bot = params.bots[i];
        if (strategiccommandutility::isvalidbot(bot)) {
            goalinfo = bot function_e9a79b0e();
            if (isdefined(goalinfo.regionid) && !goalinfo.isatgoal) {
                continue;
            }
            region = params.regions[randomint(params.regions.size)];
            bot setgoal(region);
        }
    }
    return 3;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xde025e06, Offset: 0xbe8
// Size: 0xe8
function private function_ca39a354(planner, constants) {
    controlzones = planner::getblackboardattribute(planner, "mp_controlZones");
    if (!isarray(controlzones) || controlzones.size <= 0) {
        return false;
    }
    for (i = 0; i < controlzones.size; i++) {
        zone = controlzones[i][#"__unsafe__"][#"controlzone"];
        if (isdefined(zone) && isdefined(zone.gameobject)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x3006649c, Offset: 0xcd8
// Size: 0xfa
function private function_a54fd948(planner, constants) {
    domflags = planner::getblackboardattribute(planner, "mp_domFlags");
    if (!isarray(domflags) || domflags.size <= 0) {
        return false;
    }
    for (i = 0; i < domflags.size; i++) {
        domflag = domflags[i][#"__unsafe__"][#"domflag"];
        if (isdefined(domflag) && domflags[i][#"claimed"] == 0) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x2c6a5120, Offset: 0xde0
// Size: 0xe8
function private function_77a078d7(planner, constants) {
    kothzone = planner::getblackboardattribute(planner, "mp_kothZone");
    if (!isarray(kothzone) || kothzone.size <= 0) {
        return false;
    }
    zone = kothzone[0][#"__unsafe__"][#"kothzone"];
    if (isdefined(zone) && isdefined(zone.trig) && zone.trig istriggerenabled()) {
        return true;
    }
    return false;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x4b492876, Offset: 0xed0
// Size: 0xd0
function private function_6a5948bb(planner, constants) {
    sdbomb = planner::getblackboardattribute(planner, "mp_sdBomb");
    if (!isarray(sdbomb) || sdbomb.size <= 0) {
        return false;
    }
    bomb = sdbomb[0][#"__unsafe__"][#"sdbomb"];
    if (isdefined(bomb) && bomb.trigger istriggerenabled()) {
        return true;
    }
    return false;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x1ecd8e50, Offset: 0xfa8
// Size: 0xd6
function private function_80d9abe4(planner, constants) {
    bombzones = planner::getblackboardattribute(planner, "mp_sdBombZones");
    if (!isarray(bombzones) || bombzones.size <= 0) {
        return false;
    }
    for (i = 0; i < bombzones.size; i++) {
        zone = bombzones[i][#"__unsafe__"][#"sdbombzone"];
        if (isdefined(zone)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xae069d96, Offset: 0x1088
// Size: 0xb2
function private function_738ce59b(planner, constants) {
    defuseobj = planner::getblackboardattribute(planner, "mp_sdDefuseObj");
    if (!isarray(defuseobj) || defuseobj.size <= 0) {
        return false;
    }
    defuse = defuseobj[0][#"__unsafe__"][#"sddefuseobj"];
    if (isdefined(defuse)) {
        return true;
    }
    return false;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x216ea592, Offset: 0x1148
// Size: 0xe8
function private function_d073f8e(planner, constants) {
    bots = planner::getblackboardattribute(planner, "doppelbots");
    for (i = 0; i < bots.size; i++) {
        bot = bots[0][#"__unsafe__"][#"bot"];
        if (isdefined(bot.isbombcarrier) && bot.isbombcarrier || isdefined(level.multibomb) && level.multibomb) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xccff5ba3, Offset: 0x1238
// Size: 0x3e4
function private function_2be5f80(planner, constants) {
    params = spawnstruct();
    controlzone = planner::getblackboardattribute(planner, "mp_controlZones");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        if (!isdefined(bots)) {
            bots = [];
        } else if (!isarray(bots)) {
            bots = array(bots);
        }
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    params.controlzone = controlzone[0][#"__unsafe__"][#"controlzone"];
    params.var_9a17970 = planner::getblackboardattribute(planner, "mp_laneNum");
    params.var_c04a5638 = getclosesttacpoint(params.controlzone.gameobject.origin).region;
    if (isdefined(params.controlzone)) {
        if (isdefined(params.var_9a17970)) {
            params.var_efeffa5b = [];
            for (i = 0; i < bots.size; i++) {
                if (strategiccommandutility::isvalidbot(bots[i]) && isalive(bots[i]) && game.state == "playing") {
                    var_b5034f47 = getclosesttacpoint(bots[i].origin).region;
                    params.var_efeffa5b[i] = region_utility::function_e5e2785c(var_b5034f47, params.var_c04a5638, params.var_9a17970[0]);
                }
            }
        } else {
            foreach (bot in bots) {
                if (strategiccommandutility::isvalidbot(bot)) {
                    params.path = strategiccommandutility::calculatepathtoposition(bot, params.controlzone.gameobject.origin);
                    if (isdefined(params.path)) {
                        break;
                    }
                }
            }
        }
    }
    return params;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x475f2273, Offset: 0x1628
// Size: 0x4c
function private function_27a8f307(planner, params) {
    if (!isdefined(params.controlzone) || !_paramshasbots(params)) {
        return 2;
    }
    return 1;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x5c265a58, Offset: 0x1680
// Size: 0x142
function private function_b7896166(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    if (!isdefined(params.controlzone)) {
        return 2;
    }
    if (!isdefined(params.var_efeffa5b) || params.var_efeffa5b.size == 0) {
        foreach (bot in params.bots) {
            if (strategiccommandutility::isvalidbot(bot)) {
                bot setgoal(params.controlzone.trigger);
            }
        }
        return 3;
    }
    return function_92fb4c56(params, params.controlzone.trigger);
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x412d0c01, Offset: 0x17d0
// Size: 0x4ac
function private function_38e747d9(planner, constants) {
    params = spawnstruct();
    domflags = planner::getblackboardattribute(planner, "mp_domFlags");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        if (!isdefined(bots)) {
            bots = [];
        } else if (!isarray(bots)) {
            bots = array(bots);
        }
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    flagindex = 0;
    if (domflags.size > 1) {
        flagindex = randomint(2);
    }
    params.domflag = domflags[flagindex][#"__unsafe__"][#"domflag"];
    var_da26b02 = 0;
    while (params.domflag gameobjects::get_owner_team() === params.bots[0].team) {
        var_da26b02++;
        flagindex++;
        flagindex %= domflags.size;
        params.domflag = domflags[flagindex][#"__unsafe__"][#"domflag"];
        if (var_da26b02 >= 3) {
            break;
        }
    }
    params.var_9a17970 = planner::getblackboardattribute(planner, "mp_laneNum");
    params.var_c04a5638 = getclosesttacpoint(params.domflag.origin).region;
    if (isdefined(params.domflag)) {
        if (isdefined(params.var_9a17970)) {
            params.var_efeffa5b = [];
            for (i = 0; i < bots.size; i++) {
                if (strategiccommandutility::isvalidbot(bots[i]) && isalive(bots[i]) && game.state == "playing") {
                    var_b5034f47 = getclosesttacpoint(bots[i].origin).region;
                    params.var_efeffa5b[i] = region_utility::function_e5e2785c(var_b5034f47, params.var_c04a5638, params.var_9a17970[0]);
                }
            }
        } else {
            foreach (bot in bots) {
                if (strategiccommandutility::isvalidbot(bot)) {
                    params.path = strategiccommandutility::calculatepathtoposition(bot, params.domflag.origin);
                    if (isdefined(params.path)) {
                        break;
                    }
                }
            }
        }
    }
    return params;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x71d3aec7, Offset: 0x1c88
// Size: 0xec
function private function_b88d288(planner, params) {
    if (!isdefined(params.domflag) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            bot setgoal(params.domflag.trigger);
        }
    }
    return 1;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x3ba9eb35, Offset: 0x1d80
// Size: 0x142
function private function_84c1bc71(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    if (!isdefined(params.domflag)) {
        return 2;
    }
    if (!isdefined(params.var_efeffa5b) || params.var_efeffa5b.size == 0) {
        foreach (bot in params.bots) {
            if (strategiccommandutility::isvalidbot(bot)) {
                bot setgoal(params.domflag.trigger);
            }
        }
        return 3;
    }
    return function_92fb4c56(params, params.domflag.trigger);
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x3687e785, Offset: 0x1ed0
// Size: 0x3d4
function private function_f19527ff(planner, constants) {
    params = spawnstruct();
    kothzone = planner::getblackboardattribute(planner, "mp_kothZone");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        if (!isdefined(bots)) {
            bots = [];
        } else if (!isarray(bots)) {
            bots = array(bots);
        }
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    params.kothzone = kothzone[0][#"__unsafe__"][#"kothzone"];
    params.lanenum = planner::getblackboardattribute(planner, "mp_laneNum")[0];
    params.var_c04a5638 = getclosesttacpoint(params.kothzone.gameobject.origin).region;
    if (isdefined(params.kothzone)) {
        if (isdefined(params.lanenum)) {
            params.var_efeffa5b = [];
            for (i = 0; i < bots.size; i++) {
                if (strategiccommandutility::isvalidbot(bots[i]) && isalive(bots[i])) {
                    var_b5034f47 = getclosesttacpoint(bots[i].origin).region;
                    params.var_efeffa5b[i] = region_utility::function_e5e2785c(var_b5034f47, params.var_c04a5638, params.lanenum);
                }
            }
        } else {
            foreach (bot in bots) {
                if (strategiccommandutility::isvalidbot(bot)) {
                    params.path = strategiccommandutility::calculatepathtoposition(bot, params.kothzone.gameobject.origin);
                    if (isdefined(params.path)) {
                        break;
                    }
                }
            }
        }
    }
    return params;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x67b15b2a, Offset: 0x22b0
// Size: 0x4c
function private function_e0f50932(planner, params) {
    if (!isdefined(params.kothzone) || !_paramshasbots(params)) {
        return 2;
    }
    return 1;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x7542ba12, Offset: 0x2308
// Size: 0x142
function private function_8d63a11f(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    if (!isdefined(params.kothzone)) {
        return 2;
    }
    if (!isdefined(params.var_efeffa5b) || params.var_efeffa5b.size == 0) {
        foreach (bot in params.bots) {
            if (strategiccommandutility::isvalidbot(bot)) {
                bot setgoal(params.kothzone.trig);
            }
        }
        return 3;
    }
    return function_92fb4c56(params, params.kothzone.trig);
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x339b2e09, Offset: 0x2458
// Size: 0x264
function private function_d8007dce(planner, constants) {
    params = spawnstruct();
    sdbomb = planner::getblackboardattribute(planner, "mp_sdBomb");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        if (!isdefined(bots)) {
            bots = [];
        } else if (!isarray(bots)) {
            bots = array(bots);
        }
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    params.sdbomb = sdbomb[0][#"__unsafe__"][#"sdbomb"];
    if (isdefined(params.sdbomb)) {
        foreach (bot in bots) {
            if (strategiccommandutility::isvalidbot(bot)) {
                params.path = strategiccommandutility::calculatepathtoposition(bot, params.sdbomb.origin);
                if (isdefined(params.path)) {
                    break;
                }
            }
        }
    }
    return params;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xc083fb60, Offset: 0x26c8
// Size: 0x122
function private function_89b7b6f1(planner, params) {
    if (!isdefined(params.sdbomb) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            bot bot::clear_interact();
            goal = params.sdbomb.origin;
            bot setgoal(goal);
            bot.goalradius = 8;
        }
    }
    return 1;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x84422956, Offset: 0x27f8
// Size: 0xda
function private function_5af2ecb4(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    if (isdefined(params.sdbomb)) {
        if (isdefined(params.bots[0].isbombcarrier) && params.bots[0].isbombcarrier) {
            return 1;
        }
        if (!isdefined(params.sdbomb.trigger) || !params.sdbomb.trigger istriggerenabled()) {
            return 2;
        }
        return 3;
    }
    return 2;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xcd591ddf, Offset: 0x28e0
// Size: 0x264
function private function_33aa4bfb(planner, constants) {
    params = spawnstruct();
    sdbombzone = planner::getblackboardattribute(planner, "mp_sdBombZones");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        if (!isdefined(bots)) {
            bots = [];
        } else if (!isarray(bots)) {
            bots = array(bots);
        }
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    params.sdbombzone = sdbombzone[0][#"__unsafe__"][#"sdbombzone"];
    if (isdefined(params.sdbombzone)) {
        foreach (bot in bots) {
            if (strategiccommandutility::isvalidbot(bot)) {
                params.path = strategiccommandutility::calculatepathtoposition(bot, params.sdbombzone.origin);
                if (isdefined(params.path)) {
                    break;
                }
            }
        }
    }
    return params;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xd3d27dd, Offset: 0x2b50
// Size: 0x13c
function private function_eee4918e(planner, params) {
    if (!isdefined(params.sdbombzone) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            bot bot::clear_interact();
            goal = params.sdbombzone;
            bot setgoal(goal);
            bot.goalradius = 128;
            bot bot::set_interact(params.sdbombzone);
        }
    }
    return 1;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xd0d9a7fa, Offset: 0x2c98
// Size: 0x4e
function private function_d6c3ca0b(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    if (isdefined(params.sdbombzone)) {
        return 3;
    }
    return 2;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xb4eb01d2, Offset: 0x2cf0
// Size: 0x264
function private function_9d10e6e1(planner, constants) {
    params = spawnstruct();
    sddefuseobj = planner::getblackboardattribute(planner, "mp_sdDefuseObj");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        if (!isdefined(bots)) {
            bots = [];
        } else if (!isarray(bots)) {
            bots = array(bots);
        }
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    params.sddefuseobj = sddefuseobj[0][#"__unsafe__"][#"sddefuseobj"];
    if (isdefined(params.sddefuseobj)) {
        foreach (bot in bots) {
            if (strategiccommandutility::isvalidbot(bot)) {
                params.path = strategiccommandutility::calculatepathtoposition(bot, params.sddefuseobj.origin);
                if (isdefined(params.path)) {
                    break;
                }
            }
        }
    }
    return params;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x13ba603d, Offset: 0x2f60
// Size: 0x12c
function private function_6e94d2e0(planner, params) {
    if (!isdefined(params.sddefuseobj) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            bot bot::clear_interact();
            bot setgoal(params.sddefuseobj);
            bot.goalradius = 128;
            bot bot::set_interact(params.sddefuseobj);
        }
    }
    return 1;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x8bab4beb, Offset: 0x3098
// Size: 0x4e
function private function_f5216c19(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    if (isdefined(params.sddefuseobj)) {
        return 3;
    }
    return 2;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xebedec6b, Offset: 0x30f0
// Size: 0x43e
function private function_59b991ac(planner, constants) {
    params = spawnstruct();
    sdbombzone = planner::getblackboardattribute(planner, "mp_sdBombZones");
    bots = [];
    foreach (botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
        if (!isdefined(bots)) {
            bots = [];
        } else if (!isarray(bots)) {
            bots = array(bots);
        }
        bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
    }
    params.bots = bots;
    params.sdbombzone = sdbombzone[0][#"__unsafe__"][#"sdbombzone"];
    if (isdefined(params.sdbombzone)) {
        foreach (bot in bots) {
            if (strategiccommandutility::isvalidbot(bot)) {
                params.path = strategiccommandutility::calculatepathtoposition(bot, params.sdbombzone.origin);
                if (isdefined(params.path)) {
                    break;
                }
            }
        }
    }
    params.regions = [];
    if (!isdefined(params.regions)) {
        params.regions = [];
    } else if (!isarray(params.regions)) {
        params.regions = array(params.regions);
    }
    params.regions[params.regions.size] = getclosesttacpoint(params.sdbombzone.origin).region;
    var_e53d423f = function_ff3d61bd(params.regions[0]);
    foreach (neighbor in var_e53d423f.neighbors) {
        if (!isdefined(params.regions)) {
            params.regions = [];
        } else if (!isarray(params.regions)) {
            params.regions = array(params.regions);
        }
        params.regions[params.regions.size] = neighbor;
    }
    return params;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0xcb021763, Offset: 0x3538
// Size: 0xec
function private function_2d84eed3(planner, params) {
    if (!isdefined(params.sdbombzone) || !_paramshasbots(params)) {
        return 2;
    }
    foreach (bot in params.bots) {
        if (strategiccommandutility::isvalidbot(bot)) {
            bot setgoal(params.regions[0]);
        }
    }
    return 1;
}

// Namespace namespace_19d2010a/planner_mp_squad_utility
// Params 2, eflags: 0x4
// Checksum 0x44c3b577, Offset: 0x3630
// Size: 0x5a
function private function_f3b07c32(planner, params) {
    if (!_paramshasbots(params)) {
        return 2;
    }
    if (!isdefined(params.sdbombzone)) {
        return 2;
    }
    return function_2cbb0384(params);
}

