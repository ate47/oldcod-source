#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;
#using scripts/core_common/ai/systems/planner_blackboard;
#using scripts/core_common/system_shared;

#namespace planner_squad;

// Namespace planner_squad/planner_squad
// Params 0, eflags: 0x2
// Checksum 0xfcd5757b, Offset: 0x1c8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("planner_squad", &plannersquad::__init__, undefined, undefined);
}

#namespace plannersquad;

// Namespace plannersquad/planner_squad
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x208
// Size: 0x4
function private __init__() {
    
}

// Namespace plannersquad/planner_squad
// Params 1, eflags: 0x4
// Checksum 0xf9347440, Offset: 0x218
// Size: 0x43a
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
        if (getdvarint("ai_debugSquad") == squadid) {
            position = (0, 0, 0);
            xoffset = 0;
            yoffset = 10;
            textscale = 0.7;
            bots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
            bottext = " ";
            foreach (botentry in bots) {
                bot = botentry["__unsafe__"]["bot"];
                if (isdefined(bot) && bot isbot()) {
                    bottext += bot.name + " ";
                }
            }
            timing = "start(" + squad.planstarttime + ") finish(" + squad.planfinishtime + ") frames(" + int((squad.planfinishtime - squad.planstarttime) / 50 + 1) + ")";
            /#
                recordtext(squad.planner.name + bottext + timing, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x28>", textscale);
            #/
            xoffset += 15;
            for (index = 0; index < squad.plan.size; index++) {
                yoffset += 13;
                /#
                    recordtext(squad.plan[index].name, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x28>", textscale);
                #/
            }
        }
        if (getdvarint("ai_debugGoldenPath") == squadid) {
            escortpoi = plannersquadutility::getblackboardattribute(squad, "escort_poi");
        }
        waitframe(1);
    }
}

// Namespace plannersquad/planner_squad
// Params 1, eflags: 0x4
// Checksum 0x60c8e9d0, Offset: 0x660
// Size: 0x304
function private _executeplan(squad) {
    assert(isdefined(squad));
    assert(isdefined(squad.plan), "<dev string:x33>");
    assert(isdefined(squad.plan.size), "<dev string:x62>");
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
        if (isdefined(functions["Initialize"])) {
            squad.actionstatus = [[ functions["Initialize"] ]](squad.planner, action.params);
        } else {
            squad.actionstatus = 1;
        }
    }
    if (squad.actionstatus === 1 || squad.actionstatus === 3) {
        if (isdefined(functions["Update"])) {
            squad.actionstatus = [[ functions["Update"] ]](squad.planner, action.params);
        }
    }
    if (squad.actionstatus === 1) {
        if (isdefined(functions["Terminate"])) {
            squad.actionstatus = [[ functions["Terminate"] ]](squad.planner, action.params);
        }
    }
}

// Namespace plannersquad/planner_squad
// Params 1, eflags: 0x4
// Checksum 0x3b1a1089, Offset: 0x970
// Size: 0x8c
function private _plan(squad) {
    planstarttime = gettime();
    squad.plan = planner::plan(squad.planner, squad.blackboard.values, squad.maxplannerframetime);
    squad.planstarttime = planstarttime;
    squad.planfinishtime = gettime();
}

// Namespace plannersquad/planner_squad
// Params 1, eflags: 0x4
// Checksum 0x69c84fd6, Offset: 0xa08
// Size: 0x96
function private _strategize(squad) {
    assert(isdefined(squad));
    assert(isdefined(squad.planner));
    squad.lastupdatetime = gettime();
    _plan(squad);
    squad.actionstatus = undefined;
    squad.currentplanindex = undefined;
}

// Namespace plannersquad/planner_squad
// Params 1, eflags: 0x4
// Checksum 0x249d4955, Offset: 0xaa8
// Size: 0xce
function private _updateplanner(squad) {
    assert(isdefined(squad));
    while (isdefined(squad) && !squad.shutdown) {
        time = gettime();
        if (squad.plan.size == 0 || time - squad.lastupdatetime > squad.updaterate) {
            _strategize(squad);
        }
        _executeplan(squad);
        waitframe(1);
    }
}

#namespace plannersquadutility;

// Namespace plannersquadutility/planner_squad
// Params 4, eflags: 0x0
// Checksum 0xf54ef071, Offset: 0xb80
// Size: 0x1e0
function createsquad(blackboard, planner, updaterate, maxplannerframetime) {
    if (!isdefined(updaterate)) {
        updaterate = 5;
    }
    if (!isdefined(maxplannerframetime)) {
        maxplannerframetime = 2;
    }
    assert(isstruct(blackboard));
    assert(isstruct(planner));
    squad = spawnstruct();
    squad.actionstatus = undefined;
    squad.blackboard = blackboard;
    squad.currentplanindex = undefined;
    squad.maxplannerframetime = maxplannerframetime;
    squad.plan = [];
    squad.planfinishtime = gettime();
    squad.planstarttime = gettime();
    squad.planner = planner;
    squad.lastupdatetime = 0;
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
// Checksum 0x424cb4e, Offset: 0xd68
// Size: 0x32
function getblackboardattribute(squad, attribute) {
    return plannerblackboard::getattribute(squad.blackboard, attribute);
}

// Namespace plannersquadutility/planner_squad
// Params 1, eflags: 0x0
// Checksum 0x362b9649, Offset: 0xda8
// Size: 0x54
function forcereplan(squad) {
    assert(isstruct(squad));
    plannersquad::_strategize(squad);
}

// Namespace plannersquadutility/planner_squad
// Params 3, eflags: 0x0
// Checksum 0xf03efe76, Offset: 0xe08
// Size: 0x42
function setblackboardattribute(squad, attribute, value) {
    return plannerblackboard::setattribute(squad.blackboard, attribute, value);
}

// Namespace plannersquadutility/planner_squad
// Params 1, eflags: 0x0
// Checksum 0xeb3ea86, Offset: 0xe58
// Size: 0x3c
function shutdown(squad) {
    squad.shutdown = 1;
    planner::cancel(squad.planner);
}

