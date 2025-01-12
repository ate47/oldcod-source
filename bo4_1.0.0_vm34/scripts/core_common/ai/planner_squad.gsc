#using scripts\core_common\ai\strategic_command;
#using scripts\core_common\ai\systems\planner;
#using scripts\core_common\ai\systems\planner_blackboard;
#using scripts\core_common\bots\bot;

#namespace plannersquad;

// Namespace plannersquad/planner_squad
// Params 1, eflags: 0x4
// Checksum 0x1cad6f5c, Offset: 0x98
// Size: 0xf0
function private function_dd85d074(squad) {
    botentries = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    foreach (botinfo in botentries) {
        bot = botinfo[#"__unsafe__"][#"bot"];
        if (isdefined(bot) && isdefined(bot.bot)) {
            bot bot::clear_interact();
        }
    }
}

/#

    // Namespace plannersquad/planner_squad
    // Params 1, eflags: 0x4
    // Checksum 0xed4e29c8, Offset: 0x190
    // Size: 0xde8
    function private _debugsquad(squad) {
        if (!isdefined(level.__plannersquaddebug)) {
            level.__plannersquaddebug = [];
        }
        for (index = 0; index <= level.__plannersquaddebug.size; index++) {
            if (!isdefined(level.__plannersquaddebug[index]) || level.__plannersquaddebug[index].shutdown) {
                break;
            }
        }
        level.__plannersquaddebug[index] = squad;
        squadid = index + 1;
        while (isdefined(squad) && !squad.shutdown) {
            var_ccd272ef = 0;
            squadid = getdvarint(#"ai_debugsquad", 0);
            if (isdefined(squad.blackboard) && isdefined(squad.blackboard.values[#"doppelbots"])) {
                doppelbots = squad.blackboard.values[#"doppelbots"];
                foreach (doppelbot in doppelbots) {
                    if (doppelbot[#"entnum"] == squadid) {
                        var_ccd272ef = 1;
                        break;
                    }
                }
            }
            if (var_ccd272ef) {
                position = (0, 0, 0);
                xoffset = 200;
                yoffset = 10;
                textscale = 0.7;
                bots = plannersquadutility::getblackboardattribute(squad, "<dev string:x30>");
                bottext = "<dev string:x3b>";
                foreach (botentry in bots) {
                    bot = botentry[#"__unsafe__"][#"bot"];
                    if (strategiccommandutility::isvalidbot(bot)) {
                        bottext += "<dev string:x3c>" + bot getentitynumber() + "<dev string:x3c>" + bot.name;
                    }
                }
                team = plannersquadutility::getblackboardattribute(squad, "<dev string:x3e>");
                side = strategiccommandutility::function_d4dcfc8e(team);
                recordtext(side + bottext, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x43>", textscale);
                xoffset += 15;
                yoffset += 13;
                timing = "<dev string:x4e>" + squad.planstarttime + "<dev string:x55>" + squad.planfinishtime + "<dev string:x5f>" + int((squad.planfinishtime - squad.planstarttime) / float(function_f9f48566()) / 1000 * 1000 + 1) + "<dev string:x69>";
                recordtext(timing, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x43>", textscale);
                xoffset += 15;
                target = plannersquadutility::getblackboardattribute(squad, "<dev string:x6b>");
                if (isdefined(target)) {
                    var_59a4bd81 = target[#"strategy"];
                    if (isdefined(var_59a4bd81)) {
                        if (isdefined(var_59a4bd81.sdebug)) {
                            foreach (str in var_59a4bd81.sdebug) {
                                yoffset += 13;
                                recordtext(str, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x43>", textscale);
                            }
                            xoffset += 15;
                        }
                        var_5910f0d7 = function_a4535e7c(var_59a4bd81, "<dev string:x72>", array("<dev string:x7e>", "<dev string:x8f>", "<dev string:xa2>", "<dev string:xb8>", "<dev string:xcb>", "<dev string:xdd>", "<dev string:xed>", "<dev string:x104>"), position + (500, 10, 0), (1, 1, 1), "<dev string:x43>", textscale);
                        function_a4535e7c(var_59a4bd81, "<dev string:x11b>", array("<dev string:x127>", "<dev string:x138>", "<dev string:x14b>", "<dev string:x161>", "<dev string:x174>", "<dev string:x186>", "<dev string:x196>", "<dev string:x1ad>"), position + (500, 10 + var_5910f0d7, 0), (1, 1, 1), "<dev string:x43>", textscale);
                        targetpos = undefined;
                        targettrigger = undefined;
                        if (target[#"type"] == "<dev string:x1c4>") {
                            entity = target[#"__unsafe__"][#"entity"];
                            if (isdefined(entity)) {
                                targetpos = entity.origin;
                                object = target[#"__unsafe__"][#"object"];
                                if (isdefined(object)) {
                                    if (isdefined(object)) {
                                        targettrigger = object.trigger;
                                    }
                                }
                            }
                        } else if (target[#"type"] == "<dev string:x1cf>" || target[#"type"] == "<dev string:x1d7>") {
                            missioncomponent = target[#"__unsafe__"][#"mission_component"];
                            targetpos = missioncomponent.origin;
                            component = target[#"__unsafe__"][#"component"];
                            targettrigger = component.var_d9c3be3e;
                            if (isdefined(component.var_2b8386bb)) {
                                function_b83457e9(component.var_2b8386bb, (1, 0, 1), "<dev string:x43>");
                                recordline(targetpos, component.var_2b8386bb.origin, (1, 0, 1), "<dev string:x43>");
                                record3dtext("<dev string:x1de>", component.var_2b8386bb.origin, (1, 0, 1), "<dev string:x43>", textscale);
                            }
                        } else if (target[#"type"] == "<dev string:x1e9>") {
                            missioncomponent = target[#"__unsafe__"][#"mission_component"];
                            targetpos = missioncomponent.origin;
                            component = target[#"__unsafe__"][#"component"];
                            targettrigger = component.var_5065689f;
                        } else if (target[#"type"] == "<dev string:x1f5>") {
                            missioncomponent = target[#"__unsafe__"][#"mission_component"];
                            targetpos = missioncomponent.origin;
                            component = target[#"__unsafe__"][#"component"];
                            targettrigger = component.var_97666a87;
                        } else if (target[#"type"] == "<dev string:x1fa>") {
                            bundle = target[#"__unsafe__"][#"bundle"];
                            targetpos = bundle.var_f09fedbb.origin;
                        } else {
                            yoffset += 13;
                            recordtext("<dev string:x206>" + target[#"type"], position + (xoffset, yoffset, 0), (1, 0, 0), "<dev string:x43>", textscale);
                        }
                        if (isdefined(targetpos)) {
                            recordsphere(targetpos, 20, (1, 0, 1));
                            record3dtext("<dev string:x230>" + target[#"type"], targetpos + (0, 0, 21), (1, 0, 1), "<dev string:x43>", textscale);
                            if (isdefined(targettrigger)) {
                                function_b83457e9(targettrigger, (1, 0, 1), "<dev string:x43>");
                                recordline(targetpos, targettrigger.origin, (1, 0, 1), "<dev string:x43>");
                                record3dtext("<dev string:x238>", targettrigger.origin, (1, 0, 1), "<dev string:x43>", textscale);
                            }
                        } else {
                            yoffset += 13;
                            recordtext("<dev string:x246>", position + (xoffset, yoffset, 0), (1, 0, 0), "<dev string:x43>", textscale);
                        }
                    }
                } else {
                    yoffset += 13;
                    recordtext("<dev string:x259>", position + (xoffset, yoffset, 0), (1, 0, 0), "<dev string:x43>", textscale);
                }
                for (index = 0; index < squad.plan.size; index++) {
                    yoffset += 13;
                    recordtext(function_15979fa9(squad.plan[index].name), position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x43>", textscale);
                }
            }
            if (getdvarint(#"ai_debuggoldenpath", 0) == squadid) {
                escortpoi = plannersquadutility::getblackboardattribute(squad, "<dev string:x263>");
            }
            waitframe(1);
        }
    }

    // Namespace plannersquad/planner_squad
    // Params 7, eflags: 0x4
    // Checksum 0x414e6cdf, Offset: 0xf80
    // Size: 0x15c
    function private function_a4535e7c(strategy, header, fieldlist, position, color, channel, textscale) {
        xoffset = 0;
        yoffset = 0;
        recordtext(header, position, color, channel, textscale);
        xoffset += 15;
        foreach (field in fieldlist) {
            yoffset += 13;
            recordtext(field + "<dev string:x26e>" + strategy.(field), position + (xoffset, yoffset, 0), color, channel, textscale);
        }
        yoffset += 13;
        return yoffset;
    }

    // Namespace plannersquad/planner_squad
    // Params 3, eflags: 0x4
    // Checksum 0x743af5a, Offset: 0x10e8
    // Size: 0x1ac
    function private function_b83457e9(trigger, color, channel) {
        maxs = trigger getmaxs();
        mins = trigger getmins();
        if (issubstr(trigger.classname, "<dev string:x271>")) {
            radius = max(maxs[0], maxs[1]);
            top = trigger.origin + (0, 0, maxs[2]);
            bottom = trigger.origin + (0, 0, mins[2]);
            recordcircle(bottom, radius, color, channel);
            recordcircle(top, radius, color, channel);
            recordline(bottom, top, color, channel);
            return;
        }
        function_1e80dbe9(trigger.origin, mins, maxs, trigger.angles[0], color, channel);
    }

#/

// Namespace plannersquad/planner_squad
// Params 1, eflags: 0x4
// Checksum 0xdac749e4, Offset: 0x12a0
// Size: 0x2ce
function private _executeplan(squad) {
    assert(isdefined(squad));
    assert(isdefined(squad.plan), "<dev string:x278>");
    assert(isdefined(squad.plan.size), "<dev string:x2a7>");
    if (!isdefined(squad.currentplanindex)) {
        squad.currentplanindex = 0;
    }
    if (squad.actionstatus === 1) {
        squad.actionstatus = undefined;
        squad.currentplanindex++;
    }
    if (squad.currentplanindex >= squad.plan.size || squad.actionstatus === 2) {
        squad.plan = [];
        squad.actionstatus = undefined;
        squad.currentplanindex = undefined;
        return;
    }
    action = squad.plan[squad.currentplanindex];
    functions = plannerutility::getplanneractionfunctions(action.name);
    if (!isdefined(squad.actionstatus)) {
        if (isdefined(functions[#"initialize"])) {
            squad.actionstatus = [[ functions[#"initialize"] ]](squad.planner, action.params);
        } else {
            squad.actionstatus = 1;
        }
    }
    if (squad.actionstatus === 1 || squad.actionstatus === 3) {
        if (isdefined(functions[#"update"])) {
            squad.actionstatus = [[ functions[#"update"] ]](squad.planner, action.params);
        }
    }
    if (squad.actionstatus === 1) {
        if (isdefined(functions[#"terminate"])) {
            squad.actionstatus = [[ functions[#"terminate"] ]](squad.planner, action.params);
        }
    }
}

// Namespace plannersquad/planner_squad
// Params 1, eflags: 0x4
// Checksum 0x5b96bd93, Offset: 0x1578
// Size: 0xd4
function private function_1cb19036(squad) {
    botentries = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    if (!isdefined(botentries)) {
        return false;
    }
    foreach (botinfo in botentries) {
        if (isdefined(botinfo[#"__unsafe__"][#"bot"])) {
            return true;
        }
    }
    return false;
}

// Namespace plannersquad/planner_squad
// Params 1, eflags: 0x4
// Checksum 0x2465dbfa, Offset: 0x1658
// Size: 0x7a
function private _plan(squad) {
    planstarttime = gettime();
    squad.plan = planner::plan(squad.planner, squad.blackboard.values, squad.maxplannerframetime);
    squad.planstarttime = planstarttime;
    squad.planfinishtime = gettime();
}

// Namespace plannersquad/planner_squad
// Params 1, eflags: 0x4
// Checksum 0x81e54e12, Offset: 0x16e0
// Size: 0xde
function private _strategize(squad) {
    assert(isdefined(squad));
    assert(isdefined(squad.planner));
    squad.planning = 1;
    [[ level.strategic_command_throttle ]]->waitinqueue(squad);
    squad.lastupdatetime = gettime();
    if (function_1cb19036(squad)) {
        _plan(squad);
    } else {
        plannersquadutility::shutdown(squad);
    }
    squad.actionstatus = undefined;
    squad.currentplanindex = undefined;
    squad.planning = 0;
}

// Namespace plannersquad/planner_squad
// Params 1, eflags: 0x4
// Checksum 0xa40352cd, Offset: 0x17c8
// Size: 0xe6
function private _updateplanner(squad) {
    assert(isdefined(squad));
    while (isdefined(squad) && !squad.shutdown) {
        [[ level.strategic_command_throttle ]]->waitinqueue(squad);
        time = gettime();
        if ((squad.plan.size == 0 || time - squad.lastupdatetime > squad.updaterate) && !squad.planning) {
            squad thread _strategize(squad);
        }
        _executeplan(squad);
        waitframe(1);
    }
}

#namespace plannersquadutility;

// Namespace plannersquadutility/planner_squad
// Params 4, eflags: 0x0
// Checksum 0x686e2601, Offset: 0x18b8
// Size: 0x1f0
function createsquad(blackboard, planner, updaterate = float(function_f9f48566()) / 1000 * 100, maxplannerframetime = 2) {
    assert(isstruct(blackboard));
    assert(isstruct(planner));
    squad = spawnstruct();
    squad.actionstatus = undefined;
    squad.blackboard = blackboard;
    squad.createtime = gettime();
    squad.currentplanindex = undefined;
    squad.maxplannerframetime = maxplannerframetime;
    squad.plan = [];
    squad.planfinishtime = gettime();
    squad.planstarttime = gettime();
    squad.planner = planner;
    squad.lastupdatetime = 0;
    squad.planning = 0;
    squad.shutdown = 0;
    squad.updaterate = updaterate * 1000;
    plannerblackboard::clearundostack(squad.blackboard);
    /#
        squad thread plannersquad::_debugsquad(squad);
    #/
    squad thread plannersquad::_updateplanner(squad);
    return squad;
}

// Namespace plannersquadutility/planner_squad
// Params 2, eflags: 0x0
// Checksum 0xb22907be, Offset: 0x1ab0
// Size: 0x32
function getblackboardattribute(squad, attribute) {
    return plannerblackboard::getattribute(squad.blackboard, attribute);
}

// Namespace plannersquadutility/planner_squad
// Params 1, eflags: 0x0
// Checksum 0x6b7c573c, Offset: 0x1af0
// Size: 0x4c
function function_a0de8f40(squad) {
    assert(isstruct(squad));
    plannersquad::_strategize(squad);
}

// Namespace plannersquadutility/planner_squad
// Params 3, eflags: 0x0
// Checksum 0xd046a903, Offset: 0x1b48
// Size: 0x3a
function setblackboardattribute(squad, attribute, value) {
    return plannerblackboard::setattribute(squad.blackboard, attribute, value);
}

// Namespace plannersquadutility/planner_squad
// Params 1, eflags: 0x0
// Checksum 0x7d2276a4, Offset: 0x1b90
// Size: 0x34
function shutdown(squad) {
    squad.shutdown = 1;
    planner::cancel(squad.planner);
}

