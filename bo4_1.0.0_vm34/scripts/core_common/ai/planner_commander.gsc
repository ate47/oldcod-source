#using scripts\core_common\ai\commander_util;
#using scripts\core_common\ai\planner_commander_interface;
#using scripts\core_common\ai\planner_squad;
#using scripts\core_common\ai\strategic_command;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\planner;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;

#namespace planner_commander;

// Namespace planner_commander/planner_commander
// Params 0, eflags: 0x2
// Checksum 0xfcc69ab6, Offset: 0x218
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"planner_commander", &plannercommander::__init__, undefined, undefined);
}

#namespace plannercommander;

// Namespace plannercommander/planner_commander
// Params 0, eflags: 0x2
// Checksum 0x80f724d1, Offset: 0x260
// Size: 0x4
function autoexec main() {
    
}

// Namespace plannercommander/planner_commander
// Params 0, eflags: 0x4
// Checksum 0x28eaf5f5, Offset: 0x270
// Size: 0x84
function private __init__() {
    commanderinterface::registercommanderinterfaceattributes();
    if (!isdefined(level.strategic_command_throttle)) {
        level.strategic_command_throttle = new throttle();
        [[ level.strategic_command_throttle ]]->initialize(1, float(function_f9f48566()) / 1000);
    }
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x1b44fbe4, Offset: 0x300
// Size: 0x34
function private _cancelstrategize(commander) {
    commander.cancel = 1;
    planner::cancel(commander.planner);
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xeed99b3c, Offset: 0x340
// Size: 0x140
function private _cloneblackboard(commander) {
    pixbeginevent(#"commandercloneblackboard");
    aiprofile_beginentry("commanderCloneBlackboard");
    blackboard = blackboard::cloneblackboardfromstruct(commander);
    if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
        aiprofile_endentry();
        pixendevent();
        [[ level.strategic_command_throttle ]]->waitinqueue(commander);
        commander.strategizestarttime = getrealtime();
        pixbeginevent("commanderCloneBlackboard");
        aiprofile_beginentry("commanderCloneBlackboard");
    }
    aiprofile_endentry();
    pixendevent();
    return blackboard;
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0xe9ca2082, Offset: 0x488
// Size: 0x1b4
function private function_f37b2227(commander, &blackboard) {
    pixbeginevent(#"commanderconstructtargetlist");
    aiprofile_beginentry("commanderConstructTargetList");
    assert(isstruct(commander));
    assert(isarray(blackboard));
    possiblesquads = array();
    idlebots = blackboard[#"idle_doppelbots"];
    foreach (idlebot in idlebots) {
        squad = array();
        squad[squad.size] = idlebot;
        possiblesquads[possiblesquads.size] = squad;
    }
    blackboard[#"possible_squads"] = possiblesquads;
    aiprofile_endentry();
    pixendevent();
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0xbe5db4ac, Offset: 0x648
// Size: 0x774
function private function_e248c4f0(commander, &blackboard) {
    pixbeginevent(#"commanderconstructtargetlist");
    aiprofile_beginentry("commanderConstructTargetList");
    assert(isstruct(commander));
    assert(isarray(blackboard));
    targets = array();
    priorities = array(#"hash_179ccf9d7cfd1e31", #"hash_254689c549346d57", #"hash_4bd86f050b36e1f6", #"hash_19c0ac460bdb9928", #"hash_160b01bbcd78c723", #"hash_c045a5aa4ac7c1d", #"hash_47fd3da20e90cd01", #"hash_64fc5c612a94639c", #"(-4) unimportant");
    foreach (priority in priorities) {
        targets[priority] = array();
    }
    gameobjects = blackboard[#"gameobjects"];
    blackboard[#"gameobjects"] = undefined;
    foreach (gameobject in gameobjects) {
        priority = gameobject[#"strategy"].("doppelbotspriority");
        targetsize = targets[priority].size;
        targets[priority][targetsize] = gameobject;
    }
    if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
        aiprofile_endentry();
        pixendevent();
        [[ level.strategic_command_throttle ]]->waitinqueue(commander);
        commander.strategizestarttime = getrealtime();
        pixbeginevent("commanderConstructTargetList");
        aiprofile_beginentry("commanderConstructTargetList");
    }
    if (commander.cancel) {
        aiprofile_endentry();
        pixendevent();
        return;
    }
    missioncomponents = blackboard[#"missioncomponents"];
    blackboard[#"missioncomponents"] = undefined;
    foreach (component in missioncomponents) {
        priority = component[#"strategy"].("doppelbotspriority");
        targetsize = targets[priority].size;
        targets[priority][targetsize] = component;
    }
    if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
        aiprofile_endentry();
        pixendevent();
        [[ level.strategic_command_throttle ]]->waitinqueue(commander);
        commander.strategizestarttime = getrealtime();
        pixbeginevent("commanderConstructTargetList");
        aiprofile_beginentry("commanderConstructTargetList");
    }
    if (commander.cancel) {
        aiprofile_endentry();
        pixendevent();
        return;
    }
    gpbundles = blackboard[#"gpbundles"];
    blackboard[#"gpbundles"] = undefined;
    foreach (bundle in gpbundles) {
        priority = bundle[#"strategy"].("doppelbotspriority");
        targetsize = targets[priority].size;
        targets[priority][targetsize] = bundle;
    }
    if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
        aiprofile_endentry();
        pixendevent();
        [[ level.strategic_command_throttle ]]->waitinqueue(commander);
        commander.strategizestarttime = getrealtime();
        pixbeginevent("commanderConstructTargetList");
        aiprofile_beginentry("commanderConstructTargetList");
    }
    if (commander.cancel) {
        aiprofile_endentry();
        pixendevent();
        return;
    }
    blackboard[#"targets"] = targets;
    commander.var_b851105b = targets.size;
    aiprofile_endentry();
    pixendevent();
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x7337762a, Offset: 0xdc8
// Size: 0xf8
function private _createsquads(commander) {
    newsquadcount = planner::subblackboardcount(commander.planner);
    for (index = 1; index <= newsquadcount; index++) {
        [[ level.strategic_command_throttle ]]->waitinqueue(commander);
        if (commander.cancel) {
            return;
        }
        newsquad = plannersquadutility::createsquad(planner::getsubblackboard(commander.planner, index), commander.squadplanner, commander.squadupdaterate, commander.squadmaxplannerframetime);
        commander.squads[commander.squads.size] = newsquad;
    }
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x4689bdcc, Offset: 0xec8
// Size: 0x8a0
function private _debugcommander(commander) {
    if (!isdefined(level.__plannercommanderdebug)) {
        level.__plannercommanderdebug = [];
    }
    for (index = 0; index <= level.__plannercommanderdebug.size; index++) {
        if (!isdefined(level.__plannercommanderdebug[index]) || level.__plannercommanderdebug[index].shutdown) {
            break;
        }
    }
    level.__plannercommanderdebug[index] = commander;
    commanderid = index + 1;
    while (isdefined(commander) && !commander.shutdown) {
        if (getdvarint(#"ai_debugcommander", 0) == commanderid) {
            offset = 30;
            position = (0, 0, 0);
            xoffset = 0;
            yoffset = 200;
            textscale = 0.7;
            team = blackboard::getstructblackboardattribute(commander, #"team");
            /#
                if (commander.pause) {
                    recordtext(function_15979fa9(commander.planner.name) + "<dev string:x30>" + function_15979fa9(team) + "<dev string:x37>", position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x40>", textscale);
                    waitframe(1);
                    continue;
                }
                recordtext(function_15979fa9(commander.planner.name) + "<dev string:x30>" + function_15979fa9(team) + "<dev string:x4b>" + commander.planstarttime + "<dev string:x54>" + commander.planfinishtime + "<dev string:x5e>" + int((commander.planfinishtime - commander.planstarttime) / int(float(function_f9f48566()) / 1000 * 1000) + 1) + "<dev string:x68>", position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x40>", textscale);
            #/
            xoffset += 15;
            /#
                side = strategiccommandutility::function_d4dcfc8e(team);
                var_ada9f02a = strategiccommandutility::function_4736e93(side);
                if (!isdefined(var_ada9f02a)) {
                    var_ada9f02a = #"default_strategicbundle";
                }
                yoffset += 13;
                recordtext("<dev string:x6a>" + var_ada9f02a, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x40>", textscale);
            #/
            for (index = 0; index < commander.plan.size; index++) {
                yoffset += 13;
                /#
                    recordtext(function_15979fa9(commander.plan[index].name), position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x40>", textscale);
                #/
            }
            attackgameobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault");
            for (index = 0; index < attackgameobjects.size; index++) {
                /#
                    if (isdefined(attackgameobjects[index][#"identifier"])) {
                        record3dtext(attackgameobjects[index][#"identifier"], attackgameobjects[index][#"origin"] + (0, 0, offset), (1, 0, 0), "<dev string:x40>");
                    }
                    recordsphere(attackgameobjects[index][#"origin"], 20, (1, 0, 0));
                #/
            }
            defendgameobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_defend");
            for (index = 0; index < defendgameobjects.size; index++) {
                /#
                    if (isdefined(defendgameobjects[index][#"identifier"])) {
                        record3dtext(defendgameobjects[index][#"identifier"], defendgameobjects[index][#"origin"] + (0, 0, offset), (1, 0.5, 0), "<dev string:x40>");
                    }
                    recordsphere(defendgameobjects[index][#"origin"], 20, (1, 0.5, 0));
                #/
            }
            objectives = blackboard::getstructblackboardattribute(commander, #"objectives");
            for (index = 0; index < objectives.size; index++) {
                /#
                    recordsphere(objectives[index][#"origin"], 20, (0, 0, 1));
                #/
            }
            excluded = blackboard::getstructblackboardattribute(commander, #"gameobjects_exclude");
            excludedmap = [];
            foreach (excludename in excluded) {
                excludedmap[excludename] = 1;
            }
            if (excludedmap.size > 0) {
                if (isdefined(level.a_gameobjects)) {
                    for (index = 0; index < level.a_gameobjects.size; index++) {
                        gameobject = level.a_gameobjects[index];
                        identifier = gameobject gameobjects::get_identifier();
                        if (isdefined(identifier) && isdefined(excludedmap[identifier])) {
                            /#
                                record3dtext(identifier, gameobject.origin + (0, 0, offset), (1, 1, 0), "<dev string:x40>");
                                recordsphere(gameobject.origin, 20, (1, 1, 0));
                            #/
                        }
                    }
                }
            }
        }
        waitframe(1);
    }
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xffe9d60e, Offset: 0x1770
// Size: 0xf6
function private function_926326a5(commander) {
    team = blackboard::getstructblackboardattribute(commander, #"team");
    pause = 1;
    while (isdefined(commander) && !commander.shutdown) {
        if (getdvarint(#"hash_3335f636d26687d3", 0)) {
            if (pause) {
                commander_util::pause_commander(team);
                pause = 0;
            } else {
                commander_util::function_c48843ab(team);
                pause = 1;
            }
        }
        setdvar(#"hash_3335f636d26687d3", 0);
        waitframe(1);
    }
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xcff9f4ea, Offset: 0x1870
// Size: 0x6a
function private _disbandallsquads(commander) {
    for (index = 0; index < commander.squads.size; index++) {
        plannersquadutility::shutdown(commander.squads[index]);
    }
    commander.squads = [];
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xa7d8d33e, Offset: 0x18e8
// Size: 0x1cc
function private _disbandsquads(commander) {
    pixbeginevent(#"commanderdisbandsquads");
    aiprofile_beginentry("commanderDisbandSquads");
    for (index = 0; index < commander.var_400021fe.size; index++) {
        plannersquadutility::shutdown(commander.var_400021fe[index]);
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
            pixbeginevent("commanderDisbandSquads");
            aiprofile_beginentry("commanderDisbandSquads");
        }
        if (commander.cancel) {
            aiprofile_endentry();
            pixendevent();
            return;
        }
    }
    commander.squads = commander.squadsfit;
    commander.squadsfit = [];
    commander.var_400021fe = [];
    aiprofile_endentry();
    pixendevent();
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0xa2743c12, Offset: 0x1ac0
// Size: 0x332
function private _evaluatefitness(commander, squad) {
    assert(isstruct(squad));
    if (commander.squadevaluators.size == 0) {
        return 0;
    }
    scores = [];
    foreach (evaluatorentry in commander.squadevaluators) {
        assert(isarray(evaluatorentry));
        pixbeginevent(evaluatorentry[0]);
        aiprofile_beginentry(evaluatorentry[0]);
        evaluatorfunc = plannercommanderutility::getutilityapifunction(evaluatorentry[0]);
        score = [[ evaluatorfunc ]](commander, squad, evaluatorentry[1]);
        assert(score >= 0 && score <= 1, "<dev string:x7d>" + evaluatorentry[0] + "<dev string:x9a>" + 0 + "<dev string:xc7>" + 1 + "<dev string:xca>");
        scores[evaluatorentry[0]] = score;
        aiprofile_endentry();
        pixendevent();
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
            pixbeginevent("commanderEvaluateSquads");
            aiprofile_beginentry("commanderEvaluateSquads");
        }
    }
    fitness = 1;
    foreach (score in scores) {
        fitness *= score;
    }
    return fitness;
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x504be810, Offset: 0x1e00
// Size: 0x1c4
function private _evaluatesquads(commander) {
    pixbeginevent(#"commanderevaluatesquads");
    aiprofile_beginentry("commanderEvaluateSquads");
    commander.squadsfitness = [];
    for (index = 0; index < commander.squads.size; index++) {
        commander.squadsfitness[index] = _evaluatefitness(commander, commander.squads[index]);
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
            pixbeginevent("commanderEvaluateSquads");
            aiprofile_beginentry("commanderEvaluateSquads");
        }
        if (commander.cancel) {
            aiprofile_endentry();
            pixendevent();
            return;
        }
    }
    aiprofile_endentry();
    pixendevent();
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0x2c692022, Offset: 0x1fd0
// Size: 0x74c
function private _initializeblackboard(commander, team) {
    blackboard::createblackboardforentity(commander);
    blackboard::registerblackboardattribute(commander, #"doppelbots", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"gameobjects_assault", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"gameobjects_assault_destroyed", 0, undefined);
    blackboard::registerblackboardattribute(commander, #"gameobjects_assault_total", 0, undefined);
    blackboard::registerblackboardattribute(commander, #"gameobjects_defend", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"idle_doppelbots", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"objectives", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"players", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"bot_vehicles", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"allow_escort", 1, undefined);
    blackboard::registerblackboardattribute(commander, #"allow_golden_path", 1, undefined);
    blackboard::registerblackboardattribute(commander, #"allow_progress_throttling", 0, undefined);
    blackboard::registerblackboardattribute(commander, #"gameobjects_exclude", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"gameobjects_force_attack", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"gameobjects_force_defend", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"gameobjects_priority", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"gameobjects_restrict", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"team", team, undefined);
    blackboard::registerblackboardattribute(commander, #"throttling_total_gameobjects", undefined, undefined);
    blackboard::registerblackboardattribute(commander, #"throttling_total_gameobjects_enemy", undefined, undefined);
    blackboard::registerblackboardattribute(commander, #"throttling_enemy_commander", undefined, undefined);
    blackboard::registerblackboardattribute(commander, #"throttling_lower_bound", undefined, undefined);
    blackboard::registerblackboardattribute(commander, #"throttling_upper_bound", undefined, undefined);
    blackboard::registerblackboardattribute(commander, #"pathing_calculated_paths", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"pathing_requested_bots", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"pathing_requested_points", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"hash_f5c6c6aa7dc0f6d", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"hash_6e9081699001bcd9", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"hash_4984fd4b0ba666a2", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"missioncomponents", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"gameobjects", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"gameobjects_vehicles", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"targets", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"entities", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"gpbundles", array(), undefined);
    blackboard::registerblackboardattribute(commander, #"current_squad", -1, undefined);
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x44d6abac, Offset: 0x2728
// Size: 0x52
function private _initializedaemonfunctions(functype) {
    if (!isdefined(level._daemonscriptfunctions)) {
        level._daemonscriptfunctions = [];
    }
    if (!isdefined(level._daemonscriptfunctions[functype])) {
        level._daemonscriptfunctions[functype] = [];
    }
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x6f4d79ac, Offset: 0x2788
// Size: 0x64
function private _initializedaemons(commander) {
    assert(!isdefined(commander.daemons), "<dev string:xcd>");
    commander.daemons = [];
    commander thread _updateblackboarddaemons(commander);
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x88ca270b, Offset: 0x27f8
// Size: 0x1a
function private _initializesquads(commander) {
    commander.squads = [];
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xf18e8e6e, Offset: 0x2820
// Size: 0x52
function private _initializeutilityfunctions(functype) {
    if (!isdefined(level._squadutilityscriptfunctions)) {
        level._squadutilityscriptfunctions = [];
    }
    if (!isdefined(level._squadutilityscriptfunctions[functype])) {
        level._squadutilityscriptfunctions[functype] = [];
    }
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xdb20e206, Offset: 0x2880
// Size: 0x478
function private function_ab2a2bd2(commander) {
    pixbeginevent(#"commanderorphanbotcount");
    aiprofile_beginentry("commanderOrphanBotCount");
    var_e1079ed7 = [];
    for (index = 0; index < commander.squads.size; index++) {
        botentries = plannersquadutility::getblackboardattribute(commander.squads[index], "doppelbots");
        foreach (botentry in botentries) {
            bot = botentry[#"__unsafe__"][#"bot"];
            if (strategiccommandutility::isvalidbot(bot)) {
                var_e1079ed7[bot getentitynumber()] = bot;
            }
        }
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
            pixbeginevent("commanderOrphanBotCount");
            aiprofile_beginentry("commanderOrphanBotCount");
        }
        if (commander.cancel) {
            aiprofile_endentry();
            pixendevent();
            return;
        }
    }
    doppelbots = blackboard::getstructblackboardattribute(commander, #"doppelbots");
    var_bea1cb53 = 0;
    if (doppelbots.size > var_e1079ed7.size) {
        foreach (botentry in doppelbots) {
            bot = botentry[#"__unsafe__"][#"bot"];
            if (strategiccommandutility::isvalidbot(bot) && !isdefined(var_e1079ed7[bot getentitynumber()])) {
                var_bea1cb53++;
            }
            if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
                aiprofile_endentry();
                pixendevent();
                [[ level.strategic_command_throttle ]]->waitinqueue(commander);
                commander.strategizestarttime = getrealtime();
                pixbeginevent("commanderOrphanBotCount");
                aiprofile_beginentry("commanderOrphanBotCount");
            }
            if (commander.cancel) {
                aiprofile_endentry();
                pixendevent();
                return;
            }
        }
    }
    aiprofile_endentry();
    pixendevent();
    return var_bea1cb53;
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0x348e9bcd, Offset: 0x2d00
// Size: 0x166
function private _plan(commander, &blackboard) {
    planstarttime = gettime();
    var_85930410 = [];
    var_2d50f157 = 0;
    do {
        var_f640b86f = planner::plan(commander.planner, blackboard, commander.maxframetime, commander.strategizestarttime, var_2d50f157);
        var_85930410 = arraycombine(var_85930410, var_f640b86f, 0, 0);
        var_2d50f157 = 1;
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
        }
    } while (planner::getblackboardattribute(commander.planner, #"idle_doppelbots").size > 0);
    commander.plan = var_85930410;
    commander.planstarttime = planstarttime;
    commander.planfinishtime = gettime();
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0xdd7e72aa, Offset: 0x2e70
// Size: 0x51c
function private _reclaimescortparameters(commander, &blackboard) {
    pixbeginevent(#"commanderreclaimescortparameters");
    aiprofile_beginentry("commanderReclaimEscortParameters");
    assert(isstruct(commander));
    assert(isarray(blackboard));
    players = blackboard[#"players"];
    for (index = 0; index < commander.squads.size; index++) {
        escorts = plannersquadutility::getblackboardattribute(commander.squads[index], "escorts");
        order = plannersquadutility::getblackboardattribute(commander.squads[index], "order");
        squadbots = plannersquadutility::getblackboardattribute(commander.squads[index], "doppelbots");
        if (!isdefined(escorts) || escorts.size <= 0 || !isdefined(order)) {
            continue;
        }
        foreach (escort in escorts) {
            foreach (player in players) {
                if (!isdefined(player[#"entnum"]) || !isdefined(escort[#"entnum"]) || player[#"entnum"] !== escort[#"entnum"]) {
                    continue;
                }
                switch (order) {
                case #"order_escort_mainguard":
                    player[#"escortmainguard"] = arraycombine(player[#"escortmainguard"], squadbots, 1, 0);
                    break;
                case #"order_escort_rearguard":
                    player[#"escortrearguard"] = arraycombine(player[#"escortrearguard"], squadbots, 1, 0);
                    break;
                case #"order_escort_vanguard":
                    player[#"escortvanguard"] = arraycombine(player[#"escortvanguard"], squadbots, 1, 0);
                    break;
                }
            }
            if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
                aiprofile_endentry();
                pixendevent();
                [[ level.strategic_command_throttle ]]->waitinqueue(commander);
                commander.strategizestarttime = getrealtime();
                pixbeginevent("commanderReclaimEscortParameters");
                aiprofile_beginentry("commanderReclaimEscortParameters");
            }
            if (commander.cancel) {
                aiprofile_endentry();
                pixendevent();
                return;
            }
        }
    }
    aiprofile_endentry();
    pixendevent();
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0x4c1d86ef, Offset: 0x3398
// Size: 0x45c
function private function_725f2c65(commander, &blackboard) {
    pixbeginevent(#"commanderreclaimtargets");
    aiprofile_beginentry("commanderReclaimTargets");
    assert(isstruct(commander));
    assert(isarray(blackboard));
    targets = blackboard[#"targets"];
    for (index = 0; index < commander.squads.size; index++) {
        gameobjects = plannersquadutility::getblackboardattribute(commander.squads[index], "gameobjects");
        if (isarray(gameobjects)) {
            foreach (gameobjectentry in gameobjects) {
                if (gameobjectentry[#"claimed"]) {
                    strategy = gameobjectentry[#"strategy"];
                    gameobject = gameobjectentry[#"__unsafe__"][#"object"];
                    if (isdefined(gameobject)) {
                        priority = strategy.("doppelbotspriority");
                        assert(isstring(priority));
                        if (!isstring(priority)) {
                            continue;
                        }
                        foreach (var_1a4c8ece in targets[priority]) {
                            if (var_1a4c8ece[#"type"] === "gameobject" && var_1a4c8ece[#"__unsafe__"][#"object"] == gameobject) {
                                var_1a4c8ece[#"claimed"] = 1;
                            }
                        }
                    }
                }
            }
        }
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
            pixbeginevent("commanderReclaimTargets");
            aiprofile_beginentry("commanderReclaimTargets");
        }
        if (commander.cancel) {
            aiprofile_endentry();
            pixendevent();
            return;
        }
    }
    blackboard[#"targets"] = targets;
    aiprofile_endentry();
    pixendevent();
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xbf2e16d8, Offset: 0x3800
// Size: 0x7f4
function private function_d3dc5a9c(commander) {
    pixbeginevent(#"commanderreclaimsquads");
    aiprofile_beginentry("commanderReclaimSquads");
    fitsquads = [];
    unfitsquads = [];
    for (index = 0; index < commander.squads.size; index++) {
        if (commander.squadsfitness[index] >= 0.3) {
            fitsquads[fitsquads.size] = commander.squads[index];
        } else {
            unfitsquads[unfitsquads.size] = commander.squads[index];
        }
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
            pixbeginevent("commanderReclaimSquads");
            aiprofile_beginentry("commanderReclaimSquads");
        }
        if (commander.cancel) {
            aiprofile_endentry();
            pixendevent();
            return;
        }
    }
    commander.squadsfit = fitsquads;
    commander.var_400021fe = unfitsquads;
    fitbots = [];
    for (index = 0; index < fitsquads.size; index++) {
        botentries = plannersquadutility::getblackboardattribute(fitsquads[index], "doppelbots");
        foreach (botentry in botentries) {
            bot = botentry[#"__unsafe__"][#"bot"];
            if (strategiccommandutility::isvalidbot(bot)) {
                fitbots[bot getentitynumber()] = bot;
            }
        }
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
            pixbeginevent("commanderReclaimSquads");
            aiprofile_beginentry("commanderReclaimSquads");
        }
        if (commander.cancel) {
            aiprofile_endentry();
            pixendevent();
            return;
        }
    }
    idlebots = [];
    doppelbots = blackboard::getstructblackboardattribute(commander, #"doppelbots");
    foreach (botentry in doppelbots) {
        bot = botentry[#"__unsafe__"][#"bot"];
        if (strategiccommandutility::isvalidbot(bot) && !isdefined(fitbots[bot getentitynumber()])) {
            idlebots[idlebots.size] = botentry;
        }
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
            pixbeginevent("commanderReclaimSquads");
            aiprofile_beginentry("commanderReclaimSquads");
        }
        if (commander.cancel) {
            aiprofile_endentry();
            pixendevent();
            return;
        }
    }
    var_49a5de9b = blackboard::getstructblackboardattribute(commander, #"bot_vehicles");
    foreach (var_13c64df0 in var_49a5de9b) {
        bot = var_13c64df0[#"__unsafe__"][#"bot"];
        if (strategiccommandutility::isvalidbot(bot) && !isdefined(fitbots[bot getentitynumber()])) {
            idlebots[idlebots.size] = var_13c64df0;
        }
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
            pixbeginevent("commanderReclaimSquads");
            aiprofile_beginentry("commanderReclaimSquads");
        }
        if (commander.cancel) {
            aiprofile_endentry();
            pixendevent();
            return;
        }
    }
    blackboard::setstructblackboardattribute(commander, #"idle_doppelbots", idlebots);
    aiprofile_endentry();
    pixendevent();
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0x1dd673a9, Offset: 0x4000
// Size: 0x3cc
function private function_6b374aa3(commander, &blackboard) {
    pixbeginevent(#"commandersorttargetlist");
    aiprofile_beginentry("commanderSortTargetList");
    priorities = array("escortbiped", "destroy", "capturearea", "defend", "goto", "gameobject");
    targets = blackboard[#"targets"];
    foreach (priority, var_6ea9fa71 in targets) {
        sortedtargets = associativearray("gameobject", [], "goto", [], "escortbiped", [], "destroy", [], "defend", [], "capturearea", []);
        foreach (target in var_6ea9fa71) {
            size = sortedtargets[target[#"type"]].size;
            sortedtargets[target[#"type"]][size] = target;
        }
        combined = [];
        foreach (prioritykey in priorities) {
            combined = arraycombine(combined, sortedtargets[prioritykey], 0, 0);
        }
        targets[priority] = combined;
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
            pixbeginevent("commanderSortTargetList");
            aiprofile_beginentry("commanderSortTargetList");
        }
        if (commander.cancel) {
            aiprofile_endentry();
            pixendevent();
            return;
        }
    }
    blackboard[#"targets"] = targets;
    aiprofile_endentry();
    pixendevent();
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x9f96fce9, Offset: 0x43d8
// Size: 0x224
function private _strategize(commander) {
    assert(isdefined(commander));
    assert(isdefined(commander.planner));
    [[ level.strategic_command_throttle ]]->waitinqueue(commander);
    commander.cancel = 0;
    commander.lastupdatetime = gettime();
    commander.strategizestarttime = getrealtime();
    _evaluatesquads(commander);
    if (commander.cancel) {
        return;
    }
    function_d3dc5a9c(commander);
    if (commander.cancel) {
        return;
    }
    if (blackboard::getstructblackboardattribute(commander, #"idle_doppelbots").size == 0) {
        _disbandsquads(commander);
        return;
    }
    blackboard = _cloneblackboard(commander);
    if (commander.cancel) {
        return;
    }
    function_e248c4f0(commander, blackboard);
    function_6b374aa3(commander, blackboard);
    function_725f2c65(commander, blackboard);
    function_f37b2227(commander, blackboard);
    if (commander.cancel) {
        return;
    }
    _plan(commander, blackboard);
    if (commander.cancel) {
        return;
    }
    _disbandsquads(commander);
    _createsquads(commander);
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xc60f576c, Offset: 0x4608
// Size: 0x1f4
function private _updateblackboarddaemons(commander) {
    assert(isdefined(commander));
    assert(isarray(commander.daemons));
    var_bc043c9c = spawnstruct();
    while (isdefined(commander) && !commander.shutdown) {
        if (commander.pause) {
            waitframe(1);
            continue;
        }
        [[ level.strategic_command_throttle ]]->waitinqueue(var_bc043c9c);
        foreach (daemonjob in commander.daemons) {
            if (gettime() - daemonjob.lastupdatetime > daemonjob.updaterate) {
                [[ level.strategic_command_throttle ]]->waitinqueue(daemonjob);
                commander.var_d602d17c = getrealtime();
                pixbeginevent(daemonjob.daemonname);
                aiprofile_beginentry(daemonjob.daemonname);
                [[ daemonjob.func ]](commander);
                daemonjob.lastupdatetime = gettime();
                aiprofile_endentry();
                pixendevent();
            }
        }
    }
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xa66f1521, Offset: 0x4808
// Size: 0x10c
function private _updateplanner(commander) {
    assert(isdefined(commander));
    while (isdefined(commander) && !commander.shutdown) {
        if (commander.pause) {
            _disbandallsquads(commander);
            waitframe(1);
            continue;
        }
        time = gettime();
        var_54add5d5 = time - commander.lastupdatetime > commander.updaterate;
        if (var_54add5d5 || function_ab2a2bd2(commander) > 0) {
            _strategize(commander);
        }
        waitframe(1);
    }
    if (isdefined(commander)) {
        _disbandallsquads(commander);
    }
}

#namespace plannercommanderutility;

// Namespace plannercommanderutility/planner_commander
// Params 3, eflags: 0x0
// Checksum 0x36160750, Offset: 0x4920
// Size: 0x14e
function adddaemon(commander, daemonname, updaterate = float(function_f9f48566()) / 1000 * 10) {
    assert(isstruct(commander));
    assert(!isdefined(commander.daemons[daemonname]), "<dev string:x105>" + daemonname + "<dev string:x118>");
    daemonjob = spawnstruct();
    daemonjob.func = getdaemonapifunction(daemonname);
    daemonjob.daemonname = daemonname;
    daemonjob.lastupdatetime = 0;
    daemonjob.updaterate = updaterate * 1000;
    commander.daemons[daemonname] = daemonjob;
}

// Namespace plannercommanderutility/planner_commander
// Params 3, eflags: 0x0
// Checksum 0x8ff146, Offset: 0x4a78
// Size: 0xc6
function addsquadevaluator(commander, evaluatorname, constants = []) {
    assert(isstruct(commander));
    assert(isstring(evaluatorname) || ishash(evaluatorname));
    commander.squadevaluators[commander.squadevaluators.size] = array(evaluatorname, constants);
}

// Namespace plannercommanderutility/planner_commander
// Params 7, eflags: 0x0
// Checksum 0x806d53d4, Offset: 0x4b48
// Size: 0x436
function createcommander(team, commanderplanner, squadplanner, commanderupdaterate = float(function_f9f48566()) / 1000 * 40, squadupdaterate = float(function_f9f48566()) / 1000 * 100, commandermaxframetime = 2, squadmaxplannerframetime = 2) {
    assert(isstruct(commanderplanner));
    assert(isstruct(squadplanner));
    assert(commandermaxframetime > 0);
    assert(squadmaxplannerframetime > 0);
    commander = spawnstruct();
    ai::createinterfaceforentity(commander);
    commander.archetype = hash("commander");
    commander.cancel = 0;
    commander.var_48f45ba7 = commandermaxframetime;
    commander.var_d602d17c = getrealtime();
    commander.var_b851105b = 0;
    commander.lastupdatetime = gettime();
    commander.maxframetime = commandermaxframetime;
    commander.pause = 0;
    commander.plan = [];
    commander.planfinishtime = gettime();
    commander.planstarttime = gettime();
    commander.planner = commanderplanner;
    commander.squads = [];
    commander.squadsfit = [];
    commander.squadsfitness = [];
    commander.var_400021fe = [];
    commander.shutdown = 0;
    commander.squadevaluators = [];
    commander.strategizestarttime = getrealtime();
    commander.updaterate = commanderupdaterate * 1000;
    commander.squadmaxplannerframetime = squadmaxplannerframetime;
    commander.squadplanner = squadplanner;
    commander.squadupdaterate = squadupdaterate;
    plannercommander::_initializeblackboard(commander, team);
    plannercommander::_initializedaemons(commander);
    plannercommander::_initializesquads(commander);
    /#
        commander thread plannercommander::_debugcommander(commander);
        commander thread plannercommander::function_926326a5(commander);
    #/
    commander thread plannercommander::_updateplanner(commander);
    if (!isdefined(level.var_1166849)) {
        level.var_1166849 = [];
    } else if (!isarray(level.var_1166849)) {
        level.var_1166849 = array(level.var_1166849);
    }
    level.var_1166849[level.var_1166849.size] = commander;
    return commander;
}

// Namespace plannercommanderutility/planner_commander
// Params 1, eflags: 0x0
// Checksum 0x5755f7b9, Offset: 0x4f88
// Size: 0x5a
function function_a0de8f40(commander) {
    assert(isstruct(commander));
    plannercommander::_cancelstrategize(commander);
    commander.lastupdatetime = 0;
}

// Namespace plannercommanderutility/planner_commander
// Params 6, eflags: 0x0
// Checksum 0x2412405f, Offset: 0x4ff0
// Size: 0x1ec
function initializeenemythrottle(commander, enemycommander, upperbound, lowerbound, totalgameobjects = undefined, totalgameobjectsenemy = undefined) {
    assert(isstruct(commander));
    assert(isstruct(enemycommander));
    assert(upperbound >= -1 && upperbound <= 1);
    assert(lowerbound >= -1 && lowerbound <= 1);
    assert(lowerbound <= upperbound);
    blackboard::setstructblackboardattribute(commander, #"allow_progress_throttling", 1);
    blackboard::setstructblackboardattribute(commander, #"throttling_enemy_commander", enemycommander);
    blackboard::setstructblackboardattribute(commander, #"throttling_lower_bound", lowerbound);
    blackboard::setstructblackboardattribute(commander, #"throttling_upper_bound", upperbound);
    blackboard::setstructblackboardattribute(commander, #"throttling_total_gameobjects", totalgameobjects);
    blackboard::setstructblackboardattribute(commander, #"throttling_total_gameobjects_enemy", totalgameobjectsenemy);
}

// Namespace plannercommanderutility/planner_commander
// Params 1, eflags: 0x0
// Checksum 0xac8b8411, Offset: 0x51e8
// Size: 0xce
function getdaemonapifunction(functionname) {
    assert((isstring(functionname) || ishash(functionname)) && functionname != "<dev string:x13f>", "<dev string:x140>");
    assert(isdefined(level._daemonscriptfunctions[#"api"][functionname]), "<dev string:x17b>" + functionname + "<dev string:x1a0>");
    return level._daemonscriptfunctions[#"api"][functionname];
}

// Namespace plannercommanderutility/planner_commander
// Params 1, eflags: 0x0
// Checksum 0x3db3dafb, Offset: 0x52c0
// Size: 0xce
function getutilityapifunction(functionname) {
    assert((isstring(functionname) || ishash(functionname)) && functionname != "<dev string:x13f>", "<dev string:x1b6>");
    assert(isdefined(level._squadutilityscriptfunctions[#"api"][functionname]), "<dev string:x1ef>" + functionname + "<dev string:x1a0>");
    return level._squadutilityscriptfunctions[#"api"][functionname];
}

// Namespace plannercommanderutility/planner_commander
// Params 1, eflags: 0x0
// Checksum 0xcc43a386, Offset: 0x5398
// Size: 0xa2
function pausecommander(commander) {
    assert(isstruct(commander));
    if (!commander.pause) {
        /#
            team = blackboard::getstructblackboardattribute(commander, #"team");
            iprintlnbold("<dev string:x212>" + team + "<dev string:x68>");
        #/
        commander.pause = 1;
    }
}

// Namespace plannercommanderutility/planner_commander
// Params 2, eflags: 0x0
// Checksum 0x7491af1e, Offset: 0x5448
// Size: 0x134
function registerdaemonapi(functionname, functionptr) {
    assert((isstring(functionname) || ishash(functionname)) && functionname != "<dev string:x13f>", "<dev string:x229>");
    assert(isfunctionptr(functionptr), "<dev string:x269>");
    plannercommander::_initializedaemonfunctions(#"api");
    assert(!isdefined(level._daemonscriptfunctions[#"api"][functionname]), "<dev string:x17b>" + functionname + "<dev string:x2a9>");
    level._daemonscriptfunctions[#"api"][functionname] = functionptr;
}

// Namespace plannercommanderutility/planner_commander
// Params 2, eflags: 0x0
// Checksum 0xf6e495a0, Offset: 0x5588
// Size: 0x134
function registerutilityapi(functionname, functionptr) {
    assert((isstring(functionname) || ishash(functionname)) && functionname != "<dev string:x13f>", "<dev string:x2bd>");
    assert(isfunctionptr(functionptr), "<dev string:x2fb>");
    plannercommander::_initializeutilityfunctions(#"api");
    assert(!isdefined(level._squadutilityscriptfunctions[#"api"][functionname]), "<dev string:x1ef>" + functionname + "<dev string:x2a9>");
    level._squadutilityscriptfunctions[#"api"][functionname] = functionptr;
}

// Namespace plannercommanderutility/planner_commander
// Params 1, eflags: 0x0
// Checksum 0x7970192a, Offset: 0x56c8
// Size: 0xb2
function function_3c8472ea(commander) {
    assert(isstruct(commander));
    if (commander.pause) {
        /#
            team = blackboard::getstructblackboardattribute(commander, #"team");
            iprintlnbold("<dev string:x339>" + function_15979fa9(team) + "<dev string:x68>");
        #/
        commander.pause = 0;
    }
}

// Namespace plannercommanderutility/planner_commander
// Params 4, eflags: 0x0
// Checksum 0xafd8a07a, Offset: 0x5788
// Size: 0x6c
function setforcegoalattribute(commander, attribute, oldvalue, value) {
    assert(isstruct(commander));
    blackboard::setstructblackboardattribute(commander, #"force_goal", value);
}

// Namespace plannercommanderutility/planner_commander
// Params 4, eflags: 0x0
// Checksum 0x76354a29, Offset: 0x5800
// Size: 0x6c
function setgoldenpathattribute(commander, attribute, oldvalue, value) {
    assert(isstruct(commander));
    blackboard::setstructblackboardattribute(commander, #"allow_golden_path", value);
}

// Namespace plannercommanderutility/planner_commander
// Params 1, eflags: 0x0
// Checksum 0xd3ead14d, Offset: 0x5878
// Size: 0x5c
function shutdowncommander(commander) {
    assert(isstruct(commander));
    commander.shutdown = 1;
    planner::cancel(commander.planner);
}

