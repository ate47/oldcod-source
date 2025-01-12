#using scripts/core_common/ai/planner_commander_interface;
#using scripts/core_common/ai/planner_squad;
#using scripts/core_common/ai/strategic_command;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;
#using scripts/core_common/ai/systems/planner_blackboard;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/system_shared;

#namespace planner_commander;

// Namespace planner_commander/planner_commander
// Params 0, eflags: 0x2
// Checksum 0xe65a803, Offset: 0x578
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("planner_commander", &plannercommander::__init__, undefined, undefined);
}

#namespace plannercommander;

// Namespace plannercommander/planner_commander
// Params 0, eflags: 0x4
// Checksum 0x13c8ab37, Offset: 0x5b8
// Size: 0x64
function private __init__() {
    commanderinterface::registercommanderinterfaceattributes();
    if (!isdefined(level.daemon_throttle)) {
        level.daemon_throttle = new throttle();
        [[ level.daemon_throttle ]]->initialize(1, 0.05);
    }
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x155691cb, Offset: 0x628
// Size: 0x3c
function private _cancelstrategize(commander) {
    commander.cancel = 1;
    planner::cancel(commander.planner);
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xd580b7d1, Offset: 0x670
// Size: 0x148
function private _cloneblackboard(commander) {
    pixbeginevent("commanderCloneBlackboard");
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
// Params 1, eflags: 0x4
// Checksum 0xb9ed1d22, Offset: 0x7c0
// Size: 0x120
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
// Checksum 0xf150bac4, Offset: 0x8e8
// Size: 0x730
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
        if (getdvarint("ai_debugCommander") == commanderid) {
            offset = 30;
            position = (0, 0, 0);
            xoffset = 0;
            yoffset = 10;
            textscale = 0.7;
            team = blackboard::getstructblackboardattribute(commander, "team");
            /#
                recordtext(commander.planner.name + "<dev string:x28>" + team + "<dev string:x2f>" + commander.planstarttime + "<dev string:x38>" + commander.planfinishtime + "<dev string:x42>" + int((commander.planfinishtime - commander.planstarttime) / 50 + 1) + "<dev string:x4c>", position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x4e>", textscale);
            #/
            xoffset += 15;
            for (index = 0; index < commander.plan.size; index++) {
                yoffset += 13;
                /#
                    recordtext(commander.plan[index].name, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x4e>", textscale);
                #/
            }
            attackgameobjects = blackboard::getstructblackboardattribute(commander, "gameobjects_assault");
            for (index = 0; index < attackgameobjects.size; index++) {
                /#
                    if (isdefined(attackgameobjects[index]["<dev string:x59>"])) {
                        record3dtext(attackgameobjects[index]["<dev string:x59>"], attackgameobjects[index]["<dev string:x64>"] + (0, 0, offset), (1, 0, 0), "<dev string:x4e>");
                    }
                    recordsphere(attackgameobjects[index]["<dev string:x64>"], 20, (1, 0, 0));
                #/
            }
            defendgameobjects = blackboard::getstructblackboardattribute(commander, "gameobjects_defend");
            for (index = 0; index < defendgameobjects.size; index++) {
                /#
                    if (isdefined(defendgameobjects[index]["<dev string:x59>"])) {
                        record3dtext(defendgameobjects[index]["<dev string:x59>"], defendgameobjects[index]["<dev string:x64>"] + (0, 0, offset), (1, 0.5, 0), "<dev string:x4e>");
                    }
                    recordsphere(defendgameobjects[index]["<dev string:x64>"], 20, (1, 0.5, 0));
                #/
            }
            objectives = blackboard::getstructblackboardattribute(commander, "objectives");
            for (index = 0; index < objectives.size; index++) {
                /#
                    recordsphere(objectives[index]["<dev string:x64>"], 20, (0, 0, 1));
                #/
            }
            excluded = blackboard::getstructblackboardattribute(commander, "gameobjects_exclude");
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
                                record3dtext(identifier, gameobject.origin + (0, 0, offset), (1, 1, 0), "<dev string:x4e>");
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
// Checksum 0x69bc94f8, Offset: 0x1020
// Size: 0x66
function private _disbandallsquads(commander) {
    for (index = 0; index < commander.squads.size; index++) {
        plannersquadutility::shutdown(commander.squads[index]);
    }
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x3d6a1d0c, Offset: 0x1090
// Size: 0x6b4
function private _disbandsquads(commander) {
    pixbeginevent("commanderDisbandSquads");
    aiprofile_beginentry("commanderDisbandSquads");
    fitsquads = [];
    unfitsquads = [];
    for (index = 0; index < commander.squads.size; index++) {
        if (commander.squadsfitness[index] >= 0.3) {
            fitsquads[fitsquads.size] = commander.squads[index];
        } else {
            unfitsquads[unfitsquads.size] = commander.squads[index];
            plannersquadutility::shutdown(commander.squads[index]);
        }
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
    commander.squads = fitsquads;
    fitbots = [];
    for (index = 0; index < fitsquads.size; index++) {
        botentries = plannersquadutility::getblackboardattribute(fitsquads[index], "doppelbots");
        foreach (botentry in botentries) {
            bot = botentry["__unsafe__"]["bot"];
            if (isdefined(bot) && bot isbot()) {
                fitbots[bot getentitynumber()] = bot;
            }
        }
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
    doppelbots = blackboard::getstructblackboardattribute(commander, "doppelbots");
    idlebots = [];
    foreach (botentry in doppelbots) {
        bot = botentry["__unsafe__"]["bot"];
        if (isdefined(bot) && bot isbot() && !isdefined(fitbots[bot getentitynumber()])) {
            idlebots[idlebots.size] = botentry;
        }
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
    blackboard::setstructblackboardattribute(commander, "idle_doppelbots", idlebots);
    aiprofile_endentry();
    pixendevent();
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0xb0fc4af0, Offset: 0x1750
// Size: 0x326
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
        assert(score >= 0 && score <= 1, "<dev string:x6b>" + evaluatorentry[0] + "<dev string:x88>" + 0 + "<dev string:xb5>" + 1 + "<dev string:xb8>");
        scores[evaluatorentry[0]] = score;
        aiprofile_endentry();
        pixendevent();
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
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
// Checksum 0xa2563a01, Offset: 0x1a80
// Size: 0x116
function private _evaluatesquads(commander) {
    commander.squadsfitness = [];
    for (index = 0; index < commander.squads.size; index++) {
        commander.squadsfitness[index] = _evaluatefitness(commander, commander.squads[index]);
        if (getrealtime() - commander.strategizestarttime > commander.maxframetime) {
            [[ level.strategic_command_throttle ]]->waitinqueue(commander);
            commander.strategizestarttime = getrealtime();
        }
        if (commander.cancel) {
            return;
        }
    }
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0x99e73d38, Offset: 0x1ba0
// Size: 0x3ec
function private _initializeblackboard(commander, team) {
    blackboard::createblackboardforentity(commander);
    blackboard::registerblackboardattribute(commander, "doppelbots", array(), undefined);
    blackboard::registerblackboardattribute(commander, "gameobjects_assault", array(), undefined);
    blackboard::registerblackboardattribute(commander, "gameobjects_assault_destroyed", 0, undefined);
    blackboard::registerblackboardattribute(commander, "gameobjects_assault_total", 0, undefined);
    blackboard::registerblackboardattribute(commander, "gameobjects_defend", array(), undefined);
    blackboard::registerblackboardattribute(commander, "idle_doppelbots", array(), undefined);
    blackboard::registerblackboardattribute(commander, "objectives", array(), undefined);
    blackboard::registerblackboardattribute(commander, "players", team, undefined);
    blackboard::registerblackboardattribute(commander, "allow_escort", 1, undefined);
    blackboard::registerblackboardattribute(commander, "allow_golden_path", 1, undefined);
    blackboard::registerblackboardattribute(commander, "allow_progress_throttling", 0, undefined);
    blackboard::registerblackboardattribute(commander, "gameobjects_exclude", array(), undefined);
    blackboard::registerblackboardattribute(commander, "gameobjects_force_attack", array(), undefined);
    blackboard::registerblackboardattribute(commander, "gameobjects_force_defend", array(), undefined);
    blackboard::registerblackboardattribute(commander, "gameobjects_priority", array(), undefined);
    blackboard::registerblackboardattribute(commander, "team", team, undefined);
    blackboard::registerblackboardattribute(commander, "throttling_total_gameobjects", undefined, undefined);
    blackboard::registerblackboardattribute(commander, "throttling_total_gameobjects_enemy", undefined, undefined);
    blackboard::registerblackboardattribute(commander, "throttling_enemy_commander", undefined, undefined);
    blackboard::registerblackboardattribute(commander, "throttling_lower_bound", undefined, undefined);
    blackboard::registerblackboardattribute(commander, "throttling_upper_bound", undefined, undefined);
    blackboard::registerblackboardattribute(commander, "pathing_calculated_paths", array(), undefined);
    blackboard::registerblackboardattribute(commander, "pathing_requested_bots", array(), undefined);
    blackboard::registerblackboardattribute(commander, "pathing_requested_points", array(), undefined);
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x9196a40a, Offset: 0x1f98
// Size: 0x56
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
// Checksum 0x381b8987, Offset: 0x1ff8
// Size: 0x64
function private _initializedaemons(commander) {
    assert(!isdefined(commander.daemons), "<dev string:xbb>");
    commander.daemons = [];
    commander thread _updateblackboarddaemons(commander);
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x121a4085, Offset: 0x2068
// Size: 0x1c
function private _initializesquads(commander) {
    commander.squads = [];
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xa5774889, Offset: 0x2090
// Size: 0x56
function private _initializeutilityfunctions(functype) {
    if (!isdefined(level._squadutilityscriptfunctions)) {
        level._squadutilityscriptfunctions = [];
    }
    if (!isdefined(level._squadutilityscriptfunctions[functype])) {
        level._squadutilityscriptfunctions[functype] = [];
    }
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0x438dfc34, Offset: 0x20f0
// Size: 0xa0
function private _plan(commander, &blackboard) {
    planstarttime = gettime();
    commander.plan = planner::plan(commander.planner, blackboard, commander.maxframetime);
    commander.planstarttime = planstarttime;
    commander.planfinishtime = gettime();
    commander.strategizestarttime = getrealtime();
}

// Namespace plannercommander/planner_commander
// Params 2, eflags: 0x4
// Checksum 0x869b37cd, Offset: 0x2198
// Size: 0x4f4
function private _reclaimescortparameters(commander, &blackboard) {
    pixbeginevent("commanderReclaimEscortParameters");
    aiprofile_beginentry("commanderReclaimEscortParameters");
    assert(isstruct(commander));
    assert(isarray(blackboard));
    players = blackboard["players"];
    for (index = 0; index < commander.squads.size; index++) {
        escorts = plannersquadutility::getblackboardattribute(commander.squads[index], "escorts");
        order = plannersquadutility::getblackboardattribute(commander.squads[index], "order");
        squadbots = plannersquadutility::getblackboardattribute(commander.squads[index], "doppelbots");
        if (!isdefined(escorts) || escorts.size <= 0 || !isdefined(order)) {
            continue;
        }
        foreach (escort in escorts) {
            foreach (player in players) {
                if (!isdefined(player["entnum"]) || !isdefined(escort["entnum"]) || player["entnum"] !== escort["entnum"]) {
                    continue;
                }
                switch (order) {
                case #"order_escort_mainguard":
                    player["escortMainguard"] = arraycombine(player["escortMainguard"], squadbots, 1, 0);
                    break;
                case #"order_escort_rearguard":
                    player["escortRearguard"] = arraycombine(player["escortRearguard"], squadbots, 1, 0);
                    break;
                case #"order_escort_vanguard":
                    player["escortVanguard"] = arraycombine(player["escortVanguard"], squadbots, 1, 0);
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
// Checksum 0xbf1ed832, Offset: 0x2698
// Size: 0x4bc
function private _reclaimgameobjects(commander, &blackboard) {
    pixbeginevent("commanderReclaimGameobjects");
    aiprofile_beginentry("commanderReclaimGameobjects");
    assert(isstruct(commander));
    assert(isarray(blackboard));
    assaultobjects = blackboard["gameobjects_assault"];
    defendobjects = blackboard["gameobjects_defend"];
    for (index = 0; index < commander.squads.size; index++) {
        gameobjects = plannersquadutility::getblackboardattribute(commander.squads[index], "gameobjects");
        if (isarray(gameobjects)) {
            foreach (gameobjectentry in gameobjects) {
                if (gameobjectentry["claimed"]) {
                    gameobject = gameobjectentry["__unsafe__"]["object"];
                    if (isdefined(gameobject)) {
                        foreach (assaultobjectentry in assaultobjects) {
                            assaultgameobject = assaultobjectentry["__unsafe__"]["object"];
                            if (assaultgameobject === gameobject) {
                                assaultobjectentry["claimed"] = 1;
                            }
                        }
                        foreach (defendobjectentry in defendobjects) {
                            defendgameobject = defendobjectentry["__unsafe__"]["object"];
                            if (defendgameobject === gameobject) {
                                defendobjectentry["claimed"] = 1;
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
            pixbeginevent("commanderReclaimGameobjects");
            aiprofile_beginentry("commanderReclaimGameobjects");
        }
        if (commander.cancel) {
            aiprofile_endentry();
            pixendevent();
            return;
        }
    }
    blackboard["gameobjects_assault"] = assaultobjects;
    blackboard["gameobjects_defend"] = defendobjects;
    aiprofile_endentry();
    pixendevent();
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xc075c018, Offset: 0x2b60
// Size: 0x1c4
function private _strategize(commander) {
    assert(isdefined(commander));
    assert(isdefined(commander.planner));
    commander.cancel = 0;
    commander.lastupdatetime = gettime();
    commander.strategizestarttime = getrealtime();
    _evaluatesquads(commander);
    if (commander.cancel) {
        return;
    }
    _disbandsquads(commander);
    if (commander.cancel) {
        return;
    }
    if (blackboard::getstructblackboardattribute(commander, "idle_doppelbots").size == 0) {
        return;
    }
    blackboard = _cloneblackboard(commander);
    if (commander.cancel) {
        return;
    }
    _reclaimgameobjects(commander, blackboard);
    _reclaimescortparameters(commander, blackboard);
    if (commander.cancel) {
        return;
    }
    _plan(commander, blackboard);
    if (commander.cancel) {
        return;
    }
    _createsquads(commander);
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0xd430f653, Offset: 0x2d30
// Size: 0x1e4
function private _updateblackboarddaemons(commander) {
    assert(isdefined(commander));
    assert(isarray(commander.daemons));
    while (isdefined(commander) && !commander.shutdown) {
        time = gettime();
        foreach (daemonname, daemonjob in commander.daemons) {
            if (time - daemonjob.lastupdatetime > daemonjob.updaterate) {
                pixbeginevent(daemonname);
                aiprofile_beginentry(daemonname);
                [[ daemonjob.func ]](commander);
                daemonjob.lastupdatetime = time;
                aiprofile_endentry();
                pixendevent();
                [[ level.daemon_throttle ]]->waitinqueue(commander);
            }
        }
        [[ level.daemon_throttle ]]->waitinqueue(commander);
    }
}

// Namespace plannercommander/planner_commander
// Params 1, eflags: 0x4
// Checksum 0x2245579d, Offset: 0x2f20
// Size: 0xbc
function private _updateplanner(commander) {
    assert(isdefined(commander));
    while (isdefined(commander) && !commander.shutdown) {
        time = gettime();
        if (time - commander.lastupdatetime > commander.updaterate) {
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
// Checksum 0x960947a6, Offset: 0x2fe8
// Size: 0x12a
function adddaemon(commander, daemonname, updaterate) {
    if (!isdefined(updaterate)) {
        updaterate = 0.5;
    }
    assert(isstruct(commander));
    assert(!isdefined(commander.daemons[daemonname]), "<dev string:xf3>" + daemonname + "<dev string:x106>");
    daemonjob = spawnstruct();
    daemonjob.func = getdaemonapifunction(daemonname);
    daemonjob.lastupdatetime = 0;
    daemonjob.updaterate = updaterate * 1000;
    commander.daemons[daemonname] = daemonjob;
}

// Namespace plannercommanderutility/planner_commander
// Params 3, eflags: 0x0
// Checksum 0x8eb45776, Offset: 0x3120
// Size: 0xc2
function addsquadevaluator(commander, evaluatorname, constants) {
    if (!isdefined(constants)) {
        constants = [];
    }
    assert(isstruct(commander));
    assert(isstring(evaluatorname));
    commander.squadevaluators[commander.squadevaluators.size] = array(evaluatorname, constants);
}

// Namespace plannercommanderutility/planner_commander
// Params 7, eflags: 0x0
// Checksum 0x9f872517, Offset: 0x31f0
// Size: 0x358
function createcommander(team, commanderplanner, squadplanner, commanderupdaterate, squadupdaterate, commandermaxframetime, squadmaxplannerframetime) {
    if (!isdefined(commanderupdaterate)) {
        commanderupdaterate = 10;
    }
    if (!isdefined(squadupdaterate)) {
        squadupdaterate = 5;
    }
    if (!isdefined(commandermaxframetime)) {
        commandermaxframetime = 3;
    }
    if (!isdefined(squadmaxplannerframetime)) {
        squadmaxplannerframetime = 2;
    }
    assert(isstring(team));
    assert(isstruct(commanderplanner));
    assert(isstruct(squadplanner));
    assert(commandermaxframetime > 0);
    assert(squadmaxplannerframetime > 0);
    commander = spawnstruct();
    ai::createinterfaceforentity(commander);
    commander.archetype = "commander";
    commander.cancel = 0;
    commander.lastupdatetime = gettime();
    commander.maxframetime = commandermaxframetime;
    commander.plan = [];
    commander.planfinishtime = gettime();
    commander.planstarttime = gettime();
    commander.planner = commanderplanner;
    commander.squads = [];
    commander.squadsfitness = [];
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
    #/
    commander thread plannercommander::_updateplanner(commander);
    return commander;
}

// Namespace plannercommanderutility/planner_commander
// Params 1, eflags: 0x0
// Checksum 0xf18c39d9, Offset: 0x3550
// Size: 0x64
function forcereplan(commander) {
    assert(isstruct(commander));
    plannercommander::_cancelstrategize(commander);
    commander.lastupdatetime = 0;
}

// Namespace plannercommanderutility/planner_commander
// Params 6, eflags: 0x0
// Checksum 0xd908e341, Offset: 0x35c0
// Size: 0x204
function initializeenemythrottle(commander, enemycommander, upperbound, lowerbound, totalgameobjects, totalgameobjectsenemy) {
    if (!isdefined(totalgameobjects)) {
        totalgameobjects = undefined;
    }
    if (!isdefined(totalgameobjectsenemy)) {
        totalgameobjectsenemy = undefined;
    }
    assert(isstruct(commander));
    assert(isstruct(enemycommander));
    assert(upperbound >= -1 && upperbound <= 1);
    assert(lowerbound >= -1 && lowerbound <= 1);
    assert(lowerbound <= upperbound);
    blackboard::setstructblackboardattribute(commander, "allow_progress_throttling", 1);
    blackboard::setstructblackboardattribute(commander, "throttling_enemy_commander", enemycommander);
    blackboard::setstructblackboardattribute(commander, "throttling_lower_bound", lowerbound);
    blackboard::setstructblackboardattribute(commander, "throttling_upper_bound", upperbound);
    blackboard::setstructblackboardattribute(commander, "throttling_total_gameobjects", totalgameobjects);
    blackboard::setstructblackboardattribute(commander, "throttling_total_gameobjects_enemy", totalgameobjectsenemy);
}

// Namespace plannercommanderutility/planner_commander
// Params 1, eflags: 0x0
// Checksum 0x921e8925, Offset: 0x37d0
// Size: 0xb6
function getdaemonapifunction(functionname) {
    assert(isstring(functionname) && functionname != "<dev string:x12d>", "<dev string:x12e>");
    assert(isdefined(level._daemonscriptfunctions["<dev string:x169>"][functionname]), "<dev string:x16d>" + functionname + "<dev string:x192>");
    return level._daemonscriptfunctions["Api"][functionname];
}

// Namespace plannercommanderutility/planner_commander
// Params 1, eflags: 0x0
// Checksum 0xe2a8f6c6, Offset: 0x3890
// Size: 0xb6
function getutilityapifunction(functionname) {
    assert(isstring(functionname) && functionname != "<dev string:x12d>", "<dev string:x1a8>");
    assert(isdefined(level._squadutilityscriptfunctions["<dev string:x169>"][functionname]), "<dev string:x1e1>" + functionname + "<dev string:x192>");
    return level._squadutilityscriptfunctions["Api"][functionname];
}

// Namespace plannercommanderutility/planner_commander
// Params 2, eflags: 0x0
// Checksum 0x91eaa681, Offset: 0x3950
// Size: 0x114
function registerdaemonapi(functionname, functionptr) {
    assert(isstring(functionname) && functionname != "<dev string:x12d>", "<dev string:x204>");
    assert(isfunctionptr(functionptr), "<dev string:x244>");
    plannercommander::_initializedaemonfunctions("Api");
    assert(!isdefined(level._daemonscriptfunctions["<dev string:x169>"][functionname]), "<dev string:x16d>" + functionname + "<dev string:x284>");
    level._daemonscriptfunctions["Api"][functionname] = functionptr;
}

// Namespace plannercommanderutility/planner_commander
// Params 2, eflags: 0x0
// Checksum 0x516abad2, Offset: 0x3a70
// Size: 0x114
function registerutilityapi(functionname, functionptr) {
    assert(isstring(functionname) && functionname != "<dev string:x12d>", "<dev string:x298>");
    assert(isfunctionptr(functionptr), "<dev string:x2d6>");
    plannercommander::_initializeutilityfunctions("Api");
    assert(!isdefined(level._squadutilityscriptfunctions["<dev string:x169>"][functionname]), "<dev string:x1e1>" + functionname + "<dev string:x284>");
    level._squadutilityscriptfunctions["Api"][functionname] = functionptr;
}

// Namespace plannercommanderutility/planner_commander
// Params 4, eflags: 0x0
// Checksum 0xa84a7a95, Offset: 0x3b90
// Size: 0x74
function setforcegoalattribute(commander, attribute, oldvalue, value) {
    assert(isstruct(commander));
    blackboard::setstructblackboardattribute(commander, "force_goal", value);
}

// Namespace plannercommanderutility/planner_commander
// Params 4, eflags: 0x0
// Checksum 0xf55658ca, Offset: 0x3c10
// Size: 0x74
function setgoldenpathattribute(commander, attribute, oldvalue, value) {
    assert(isstruct(commander));
    blackboard::setstructblackboardattribute(commander, "allow_golden_path", value);
}

// Namespace plannercommanderutility/planner_commander
// Params 1, eflags: 0x0
// Checksum 0x7bb24c19, Offset: 0x3c90
// Size: 0x6c
function shutdowncommander(commander) {
    assert(isstruct(commander));
    commander.shutdown = 1;
    planner::cancel(commander.planner);
}

