#using scripts/core_common/ai/systems/planner_blackboard;
#using scripts/core_common/throttle_shared;

#namespace planner;

// Namespace planner/planner
// Params 0, eflags: 0x2
// Checksum 0xdc41cc30, Offset: 0x168
// Size: 0x40
function autoexec main() {
    level.var_75cf3b4f = 1;
    /#
        level.var_75cf3b4f = getdvarint("<dev string:x28>", 1);
    #/
}

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0xddfcb83d, Offset: 0x1b0
// Size: 0x13a
function private _blackboardsapplyundostate(planner, state) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isarray(planner.blackboards));
    #/
    foreach (key, blackboard in planner.blackboards) {
        if (isdefined(state[key])) {
            plannerblackboard::undo(blackboard, state[key]);
            continue;
        }
        planner.blackboards[key] = undefined;
    }
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0x55b6b800, Offset: 0x2f8
// Size: 0x126
function private _blackboardscalculateundostate(planner) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isarray(planner.blackboards));
    #/
    state = [];
    foreach (key, blackboard in planner.blackboards) {
        state[key] = plannerblackboard::getundostacksize(blackboard) - 1;
    }
    return state;
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0x28d5ad93, Offset: 0x428
// Size: 0x102
function private _blackboardsreadmode(planner) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isarray(planner.blackboards));
    #/
    foreach (blackboard in planner.blackboards) {
        plannerblackboard::setreadmode(blackboard);
    }
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0xa0fe3a75, Offset: 0x538
// Size: 0x102
function private _blackboardsreadwritemode(planner) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isarray(planner.blackboards));
    #/
    foreach (blackboard in planner.blackboards) {
        plannerblackboard::setreadwritemode(blackboard);
    }
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0x9267e7d2, Offset: 0x648
// Size: 0x56
function private _initializeplannerfunctions(functype) {
    if (!isdefined(level._plannerscriptfunctions)) {
        level._plannerscriptfunctions = [];
    }
    if (!isdefined(level._plannerscriptfunctions[functype])) {
        level._plannerscriptfunctions[functype] = [];
    }
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0x789b8c6, Offset: 0x6a8
// Size: 0x22
function private _plancalculateplanindex(planner) {
    return planner.plan.size - 1;
}

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0x3c277781, Offset: 0x6d8
// Size: 0x2c0
function private _planexpandaction(planner, action) {
    pixbeginevent(action.api);
    aiprofile_beginentry(action.api);
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isstruct(action));
    #/
    /#
        assert(action.type == "<dev string:x41>");
    #/
    /#
        assert(isarray(planner.plan));
    #/
    actionfuncs = plannerutility::getplanneractionfunctions(action.api);
    actioninfo = spawnstruct();
    actioninfo.name = action.api;
    if (isdefined(actionfuncs["Parameterize"])) {
        _blackboardsreadwritemode(planner);
        actioninfo.params = [[ actionfuncs["Parameterize"] ]](planner, action.constants);
        /#
            assert(isstruct(actioninfo.params), "<dev string:x48>" + action.api + "<dev string:x6e>");
        #/
        _blackboardsreadmode(planner);
    } else {
        actioninfo.params = spawnstruct();
    }
    planner.plan[planner.plan.size] = actioninfo;
    aiprofile_endentry();
    pixendevent();
    return true;
}

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0x5b4a952a, Offset: 0x9a0
// Size: 0x28c
function private function_dda58801(planner, node) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isstruct(node));
    #/
    if (planner.cancel) {
        return 0;
    }
    result = 0;
    switch (node.type) {
    case #"action":
        result = _planexpandaction(planner, node);
        break;
    case #"postcondition":
        result = _planexpandpostcondition(planner, node);
        break;
    case #"precondition":
        result = _planexpandprecondition(planner, node);
        break;
    case #"planner":
    case #"selector":
        result = function_b72b978e(planner, node);
        break;
    case #"sequence":
        result = function_81eb3e9e(planner, node);
        break;
    default:
        /#
            assert(0, "<dev string:x86>" + node.type + "<dev string:xae>");
        #/
        break;
    }
    if (getrealtime() - planner.planstarttime > planner.maxframetime) {
        aiprofile_endentry();
        pixendevent();
        waitframe(1);
        pixbeginevent(planner.name);
        aiprofile_beginentry(planner.name);
        planner.planstarttime = getrealtime();
    }
    return result;
}

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0xdf18724, Offset: 0xc38
// Size: 0x180
function private _planexpandpostcondition(planner, postcondition) {
    pixbeginevent(postcondition.api);
    aiprofile_beginentry(postcondition.api);
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isstruct(postcondition));
    #/
    /#
        assert(postcondition.type == "<dev string:xb0>");
    #/
    _blackboardsreadwritemode(planner);
    postconditionfunc = plannerutility::getplannerapifunction(postcondition.api);
    [[ postconditionfunc ]](planner, postcondition.constants);
    _blackboardsreadmode(planner);
    aiprofile_endentry();
    pixendevent();
    return true;
}

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0x142e045a, Offset: 0xdc0
// Size: 0x178
function private _planexpandprecondition(planner, precondition) {
    pixbeginevent(precondition.api);
    aiprofile_beginentry(precondition.api);
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isstruct(precondition));
    #/
    /#
        assert(precondition.type == "<dev string:xbe>");
    #/
    _blackboardsreadmode(planner);
    preconditionfunc = plannerutility::getplannerapifunction(precondition.api);
    result = [[ preconditionfunc ]](planner, precondition.constants);
    aiprofile_endentry();
    pixendevent();
    return result;
}

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0x897a462d, Offset: 0xf40
// Size: 0x1d8
function private function_81eb3e9e(planner, sequence) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isstruct(sequence));
    #/
    /#
        assert(sequence.type == "<dev string:xcb>");
    #/
    /#
        assert(sequence.children.size > 0);
    #/
    currentplanindex = _plancalculateplanindex(planner);
    var_1a7c51e9 = _blackboardscalculateundostate(planner);
    var_4169191b = 1;
    for (index = 0; index < sequence.children.size; index++) {
        var_4169191b &= function_dda58801(planner, sequence.children[index]);
        if (!var_4169191b) {
            break;
        }
    }
    if (!var_4169191b) {
        _undoplan(planner, currentplanindex);
        _blackboardsapplyundostate(planner, var_1a7c51e9);
    }
    return var_4169191b;
}

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0x21d41291, Offset: 0x1120
// Size: 0x1e2
function private function_b72b978e(planner, selector) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isstruct(selector));
    #/
    /#
        assert(selector.type == "<dev string:xd4>" || selector.type == "<dev string:xdd>");
    #/
    /#
        assert(selector.children.size > 0);
    #/
    currentplanindex = _plancalculateplanindex(planner);
    var_1a7c51e9 = _blackboardscalculateundostate(planner);
    var_4169191b = 1;
    for (index = 0; index < selector.children.size; index++) {
        var_4169191b = function_dda58801(planner, selector.children[index]);
        if (!var_4169191b) {
            _undoplan(planner, currentplanindex);
            _blackboardsapplyundostate(planner, var_1a7c51e9);
            continue;
        }
        break;
    }
    return var_4169191b;
}

// Namespace planner/planner
// Params 3, eflags: 0x4
// Checksum 0x7cb9aaaf, Offset: 0x1310
// Size: 0x6c
function private _planfindnextsibling(planner, parentnodeentry, currentchildindex) {
    /#
        assert(isstruct(planner));
    #/
    return parentnodeentry.node.children[currentchildindex + 1];
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0x76ed819a, Offset: 0x1388
// Size: 0x50
function private _planstackhasnodes(planner) {
    /#
        assert(isstruct(planner));
    #/
    return planner.nodestack.size > 0;
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0x9065735b, Offset: 0x13e0
// Size: 0x9a
function private _planstackpeeknode(planner) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(planner.nodestack.size > 0);
    #/
    nodeentry = planner.nodestack[planner.nodestack.size - 1];
    return nodeentry;
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0xc7bb7e06, Offset: 0x1488
// Size: 0xbc
function private _planstackpopnode(planner) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(planner.nodestack.size > 0);
    #/
    nodeentry = planner.nodestack[planner.nodestack.size - 1];
    planner.nodestack[planner.nodestack.size - 1] = undefined;
    return nodeentry;
}

// Namespace planner/planner
// Params 3, eflags: 0x4
// Checksum 0x6a07c360, Offset: 0x1550
// Size: 0x146
function private _planstackpushnode(planner, node, childindex) {
    if (!isdefined(childindex)) {
        childindex = undefined;
    }
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isstruct(node));
    #/
    nodeentry = spawnstruct();
    nodeentry.childindex = isdefined(childindex) ? childindex : -1;
    nodeentry.node = node;
    nodeentry.planindex = _plancalculateplanindex(planner);
    nodeentry.undostate = _blackboardscalculateundostate(planner);
    planner.nodestack[planner.nodestack.size] = nodeentry;
}

// Namespace planner/planner
// Params 3, eflags: 0x4
// Checksum 0x48e3e8d6, Offset: 0x16a0
// Size: 0x2a0
function private _planpushvalidparent(planner, childnodeentry, result) {
    while (_planstackhasnodes(planner)) {
        parentnodeentry = _planstackpeeknode(planner);
        /#
            assert(isdefined(parentnodeentry));
        #/
        switch (parentnodeentry.node.type) {
        case #"sequence":
            if (result) {
                nextchildnode = _planfindnextsibling(planner, parentnodeentry, childnodeentry.childindex);
                if (isdefined(nextchildnode)) {
                    _planstackpushnode(planner, nextchildnode, childnodeentry.childindex + 1);
                    return 1;
                }
            } else {
                _undoplan(planner, parentnodeentry.planindex);
                _blackboardsapplyundostate(planner, parentnodeentry.undostate);
            }
            _planstackpopnode(planner);
            break;
        case #"planner":
        case #"selector":
            if (!result) {
                _undoplan(planner, parentnodeentry.planindex);
                _blackboardsapplyundostate(planner, parentnodeentry.undostate);
                nextchildnode = _planfindnextsibling(planner, parentnodeentry, childnodeentry.childindex);
                if (isdefined(nextchildnode)) {
                    _planstackpushnode(planner, nextchildnode, childnodeentry.childindex + 1);
                    return 1;
                }
            }
            _planstackpopnode(planner);
            break;
        default:
            _planstackpopnode(planner);
            break;
        }
        childnodeentry = parentnodeentry;
    }
    return result;
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0x67e1990d, Offset: 0x1948
// Size: 0x37c
function private _planprocessstack(planner) {
    /#
        assert(isstruct(planner));
    #/
    result = 1;
    for (waitedinthrottle = 0; _planstackhasnodes(planner); waitedinthrottle = 0) {
        if (!waitedinthrottle) {
            aiprofile_endentry();
            pixendevent();
            [[ level.strategic_command_throttle ]]->waitinqueue(planner);
            pixbeginevent(planner.name);
            aiprofile_beginentry(planner.name);
            planner.planstarttime = getrealtime();
            waitedinthrottle = 1;
        }
        nodeentry = _planstackpeeknode(planner);
        switch (nodeentry.node.type) {
        case #"action":
            result = _planexpandaction(planner, nodeentry.node);
            break;
        case #"postcondition":
            result = _planexpandpostcondition(planner, nodeentry.node);
            break;
        case #"precondition":
            result = _planexpandprecondition(planner, nodeentry.node);
            break;
        case #"planner":
        case #"selector":
        case #"sequence":
            _planstackpushnode(planner, nodeentry.node.children[0], 0);
            continue;
        default:
            /#
                assert(0, "<dev string:x86>" + nodeentry.node.type + "<dev string:xae>");
            #/
            break;
        }
        result = _planpushvalidparent(planner, nodeentry, result);
        if (getrealtime() - planner.planstarttime > planner.maxframetime) {
            aiprofile_endentry();
            pixendevent();
            waitframe(1);
            pixbeginevent(planner.name);
            aiprofile_beginentry(planner.name);
            planner.planstarttime = getrealtime();
        }
    }
}

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0xf8c17ccc, Offset: 0x1cd0
// Size: 0xfe
function private _undoplan(planner, planindex) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isarray(planner.plan));
    #/
    /#
        assert(planindex < planner.plan.size);
    #/
    for (index = planner.plan.size - 1; index > planindex && index >= 0; index--) {
        planner.plan[index] = undefined;
    }
}

// Namespace planner/planner
// Params 3, eflags: 0x0
// Checksum 0xfb3b39be, Offset: 0x1dd8
// Size: 0x60
function addaction(parent, actionname, constants) {
    node = createaction(actionname, constants);
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0xff9b8ae3, Offset: 0x1e40
// Size: 0xd2
function addchild(parent, node) {
    /#
        assert(isstruct(parent));
    #/
    /#
        assert(isstruct(node));
    #/
    /#
        assert(isarray(parent.children));
    #/
    parent.children[parent.children.size] = node;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0xe673e7e7, Offset: 0x1f20
// Size: 0x2c
function addgoto(parent, gotonode) {
    addchild(parent, gotonode);
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0xd21642ad, Offset: 0x1f58
// Size: 0x48
function addselector(parent) {
    node = createselector();
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x7b2e1970, Offset: 0x1fa8
// Size: 0x48
function addsequence(parent) {
    node = createsequence();
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 3, eflags: 0x0
// Checksum 0x1442268e, Offset: 0x1ff8
// Size: 0x60
function addpostcondition(parent, functionname, constants) {
    node = createpostcondition(functionname, constants);
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 3, eflags: 0x0
// Checksum 0x30f138a4, Offset: 0x2060
// Size: 0x60
function addprecondition(parent, functionname, constants) {
    node = createprecondition(functionname, constants);
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x556aebf1, Offset: 0x20c8
// Size: 0x50
function cancel(planner) {
    /#
        assert(isstruct(planner));
    #/
    planner.cancel = 1;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0xcb0802af, Offset: 0x2120
// Size: 0xa8
function createaction(actionname, constants) {
    /#
        assert(!isdefined(constants) || isarray(constants));
    #/
    node = spawnstruct();
    node.type = "action";
    node.api = actionname;
    node.constants = constants;
    return node;
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0xf194323a, Offset: 0x21d0
// Size: 0x84
function createplanner(name) {
    planner = spawnstruct();
    planner.cancel = 0;
    planner.children = [];
    planner.name = name;
    planner.planning = 0;
    planner.type = "planner";
    return planner;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0xc3eab335, Offset: 0x2260
// Size: 0x100
function createpostcondition(functionname, constants) {
    /#
        assert(!isdefined(constants) || isarray(constants));
    #/
    /#
        assert(isfunctionptr(plannerutility::getplannerapifunction(functionname)), "<dev string:xe5>" + functionname + "<dev string:xf1>");
    #/
    node = spawnstruct();
    node.type = "postcondition";
    node.api = functionname;
    node.constants = constants;
    return node;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0x633dfe8b, Offset: 0x2368
// Size: 0x100
function createprecondition(functionname, constants) {
    /#
        assert(!isdefined(constants) || isarray(constants));
    #/
    /#
        assert(isfunctionptr(plannerutility::getplannerapifunction(functionname)), "<dev string:xe5>" + functionname + "<dev string:xf1>");
    #/
    node = spawnstruct();
    node.type = "precondition";
    node.api = functionname;
    node.constants = constants;
    return node;
}

// Namespace planner/planner
// Params 0, eflags: 0x0
// Checksum 0xe37ccb39, Offset: 0x2470
// Size: 0x48
function createselector() {
    node = spawnstruct();
    node.children = [];
    node.type = "selector";
    return node;
}

// Namespace planner/planner
// Params 0, eflags: 0x0
// Checksum 0x7c2d7d0a, Offset: 0x24c0
// Size: 0x48
function createsequence() {
    node = spawnstruct();
    node.children = [];
    node.type = "sequence";
    return node;
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x43dac133, Offset: 0x2510
// Size: 0xf8
function createsubblackboard(planner) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isarray(planner.blackboards));
    #/
    newblackboardindex = planner.blackboards.size;
    defaultvalues = [];
    planner.blackboards[newblackboardindex] = plannerblackboard::create(defaultvalues);
    plannerblackboard::setreadwritemode(planner.blackboards[newblackboardindex]);
    return newblackboardindex;
}

// Namespace planner/planner
// Params 3, eflags: 0x0
// Checksum 0x1bf1f5b0, Offset: 0x2610
// Size: 0x12a
function getblackboardattribute(planner, attribute, blackboardindex) {
    if (!isdefined(blackboardindex)) {
        blackboardindex = 0;
    }
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isstring(attribute));
    #/
    /#
        assert(isarray(planner.blackboards));
    #/
    /#
        assert(isstruct(planner.blackboards[blackboardindex]));
    #/
    return plannerblackboard::getattribute(planner.blackboards[blackboardindex], attribute);
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0x82d01073, Offset: 0x2748
// Size: 0xda
function getblackboardvalues(planner, blackboardindex) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isarray(planner.blackboards));
    #/
    /#
        assert(isstruct(planner.blackboards[blackboardindex]));
    #/
    return planner.blackboards[blackboardindex].values;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0x3ac0ceb3, Offset: 0x2830
// Size: 0xc8
function getsubblackboard(planner, blackboardindex) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isarray(planner.blackboards));
    #/
    /#
        assert(blackboardindex > 0 && blackboardindex < planner.blackboards.size);
    #/
    return planner.blackboards[blackboardindex];
}

// Namespace planner/planner
// Params 3, eflags: 0x0
// Checksum 0xb1a1c337, Offset: 0x2900
// Size: 0x2c2
function plan(planner, blackboardvalues, maxframetime) {
    if (!isdefined(maxframetime)) {
        maxframetime = 3;
    }
    pixbeginevent(planner.name);
    aiprofile_beginentry(planner.name);
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isarray(blackboardvalues));
    #/
    while (planner.planning) {
        cancel(planner);
        aiprofile_endentry();
        pixendevent();
        waitframe(1);
        pixbeginevent(planner.name);
        aiprofile_beginentry(planner.name);
    }
    planner.cancel = 0;
    planner.maxframetime = maxframetime;
    planner.plan = [];
    planner.planning = 1;
    planner.planstarttime = getrealtime();
    planner.blackboards = [];
    planner.blackboards[0] = plannerblackboard::create(blackboardvalues);
    planner.nodestack = [];
    if (isdefined(level.var_75cf3b4f) && level.var_75cf3b4f > 0) {
        _planstackpushnode(planner, planner);
        _planprocessstack(planner);
    } else {
        function_dda58801(planner, planner);
    }
    planner.planning = 0;
    aiprofile_endentry();
    pixendevent();
    return planner.plan;
}

/#

    // Namespace planner/planner
    // Params 2, eflags: 0x0
    // Checksum 0x3ee6eee, Offset: 0x2bd0
    // Size: 0xec
    function printplanner(planner, filename) {
        /#
            assert(isstruct(planner));
        #/
        file = openfile(filename, "<dev string:x10c>");
        printid = randomint(2147483647);
        _printplannernode(file, planner, 0, printid);
        _printclearprintid(planner);
        closefile(file);
    }

#/

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0xfa7025cc, Offset: 0x2cc8
// Size: 0xa6
function private _printclearprintid(plannernode) {
    plannernode.printid = undefined;
    if (isdefined(plannernode.children)) {
        for (index = 0; index < plannernode.children.size; index++) {
            if (isdefined(plannernode.children[index].printid)) {
                _printclearprintid(plannernode.children[index]);
            }
        }
    }
}

// Namespace planner/planner
// Params 4, eflags: 0x4
// Checksum 0x1a3e955a, Offset: 0x2d78
// Size: 0x2ce
function private _printplannernode(file, plannernode, indent, printid) {
    /#
        assert(isstruct(plannernode));
    #/
    indentspace = "";
    for (index = 0; index < indent; index++) {
        indentspace += "    ";
    }
    text = "";
    if (plannernode.printid === printid) {
        text += "GOTO - " + plannernode.type;
        if (isdefined(plannernode.name)) {
            text += "(" + plannernode.name + ")";
        }
        if (isdefined(plannernode.api)) {
            text += "(" + plannernode.api + ")";
        }
        /#
            fprintln(file, indentspace + text);
        #/
        return;
    }
    plannernode.printid = printid;
    text = plannernode.type;
    if (isdefined(plannernode.name)) {
        text += "(" + plannernode.name + ")";
    }
    if (isdefined(plannernode.api)) {
        text += "(" + plannernode.api + ")";
    }
    /#
        fprintln(file, indentspace + text);
    #/
    if (isdefined(plannernode.children)) {
        for (index = 0; index < plannernode.children.size; index++) {
            _printplannernode(file, plannernode.children[index], indent + 1, printid);
        }
    }
}

// Namespace planner/planner
// Params 5, eflags: 0x0
// Checksum 0x40cda88c, Offset: 0x3050
// Size: 0x154
function setblackboardattribute(planner, attribute, value, blackboardindex, readonly) {
    if (!isdefined(blackboardindex)) {
        blackboardindex = 0;
    }
    if (!isdefined(readonly)) {
        readonly = 0;
    }
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isstring(attribute));
    #/
    /#
        assert(isarray(planner.blackboards));
    #/
    /#
        assert(isstruct(planner.blackboards[blackboardindex]));
    #/
    plannerblackboard::setattribute(planner.blackboards[blackboardindex], attribute, value, readonly);
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x32c40572, Offset: 0x31b0
// Size: 0x8a
function subblackboardcount(planner) {
    /#
        assert(isstruct(planner));
    #/
    /#
        assert(isarray(planner.blackboards));
    #/
    return planner.blackboards.size - 1;
}

#namespace plannerutility;

// Namespace plannerutility/planner
// Params 1, eflags: 0x0
// Checksum 0x29737afb, Offset: 0x3248
// Size: 0x46a
function createplannerfromasset(assetname) {
    htnasset = gethierarchicaltasknetwork(assetname);
    if (isdefined(htnasset) && htnasset.nodes.size > 0) {
        plannernodes = [];
        for (nodeindex = 0; nodeindex < htnasset.nodes.size; nodeindex++) {
            node = htnasset.nodes[nodeindex];
            switch (node.type) {
            case #"action":
                plannernodes[nodeindex] = planner::createaction(node.name, node.constants);
                break;
            case #"postcondition":
                plannernodes[nodeindex] = planner::createpostcondition(node.name, node.constants);
                break;
            case #"precondition":
                plannernodes[nodeindex] = planner::createprecondition(node.name, node.constants);
                break;
            case #"planner":
                plannernodes[nodeindex] = planner::createplanner(node.name);
                break;
            case #"selector":
                plannernodes[nodeindex] = planner::createselector();
                break;
            case #"sequence":
                plannernodes[nodeindex] = planner::createsequence();
                break;
            case #"goto":
                plannernodes[nodeindex] = spawnstruct();
                break;
            }
        }
        for (nodeindex = 0; nodeindex < htnasset.nodes.size; nodeindex++) {
            parentnode = plannernodes[nodeindex];
            htnnode = htnasset.nodes[nodeindex];
            if (!isdefined(htnnode.childindexes) || htnnode.type == "goto") {
                continue;
            }
            for (childindex = 0; childindex < htnnode.childindexes.size; childindex++) {
                /#
                    assert(htnnode.childindexes[childindex] < plannernodes.size);
                #/
                childnum = htnnode.childindexes[childindex];
                childnode = plannernodes[childnum];
                for (htnchildnode = htnasset.nodes[childnum]; htnchildnode.type === "goto"; htnchildnode = htnasset.nodes[childnum]) {
                    /#
                        assert(isdefined(htnchildnode.childindexes));
                    #/
                    /#
                        assert(htnchildnode.childindexes.size == 1);
                    #/
                    childnum = htnchildnode.childindexes[0];
                    childnode = plannernodes[childnum];
                }
                planner::addchild(parentnode, childnode);
            }
        }
        return plannernodes[0];
    }
}

// Namespace plannerutility/planner
// Params 1, eflags: 0x0
// Checksum 0x916955f, Offset: 0x36c0
// Size: 0xd6
function getplannerapifunction(functionname) {
    /#
        assert(isstring(functionname) && functionname != "<dev string:x112>", "<dev string:x113>");
    #/
    functionname = tolower(functionname);
    /#
        assert(isdefined(level._plannerscriptfunctions["<dev string:x146>"][functionname]), "<dev string:x14a>" + functionname + "<dev string:x167>");
    #/
    return level._plannerscriptfunctions["Api"][functionname];
}

// Namespace plannerutility/planner
// Params 1, eflags: 0x0
// Checksum 0x3268ab91, Offset: 0x37a0
// Size: 0xd6
function getplanneractionfunctions(actionname) {
    /#
        assert(isstring(actionname) && actionname != "<dev string:x112>", "<dev string:x17d>");
    #/
    actionname = tolower(actionname);
    /#
        assert(isdefined(level._plannerscriptfunctions["<dev string:x1ae>"][actionname]), "<dev string:x1b5>" + actionname + "<dev string:x167>");
    #/
    return level._plannerscriptfunctions["Action"][actionname];
}

// Namespace plannerutility/planner
// Params 2, eflags: 0x0
// Checksum 0xf28f093, Offset: 0x3880
// Size: 0x13c
function registerplannerapi(functionname, functionptr) {
    /#
        assert(isstring(functionname) && functionname != "<dev string:x112>", "<dev string:x1d0>");
    #/
    /#
        assert(isfunctionptr(functionptr), "<dev string:x208>" + functionname + "<dev string:x235>");
    #/
    functionname = tolower(functionname);
    planner::_initializeplannerfunctions("Api");
    /#
        assert(!isdefined(level._plannerscriptfunctions["<dev string:x146>"][functionname]), "<dev string:x14a>" + functionname + "<dev string:x254>");
    #/
    level._plannerscriptfunctions["Api"][functionname] = functionptr;
}

// Namespace plannerutility/planner
// Params 5, eflags: 0x0
// Checksum 0x1441d923, Offset: 0x39c8
// Size: 0x232
function registerplanneraction(actionname, paramfuncptr, initializefuncptr, updatefuncptr, terminatefuncptr) {
    /#
        assert(isstring(actionname) && actionname != "<dev string:x112>", "<dev string:x268>");
    #/
    actionname = tolower(actionname);
    planner::_initializeplannerfunctions("Action");
    /#
        assert(!isdefined(level._plannerscriptfunctions["<dev string:x1ae>"][actionname]), "<dev string:x1b5>" + actionname + "<dev string:x254>");
    #/
    level._plannerscriptfunctions["Action"][actionname] = [];
    if (isfunctionptr(paramfuncptr)) {
        level._plannerscriptfunctions["Action"][actionname]["Parameterize"] = paramfuncptr;
    }
    if (isfunctionptr(initializefuncptr)) {
        level._plannerscriptfunctions["Action"][actionname]["Initialize"] = initializefuncptr;
    }
    if (isfunctionptr(updatefuncptr)) {
        level._plannerscriptfunctions["Action"][actionname]["Update"] = updatefuncptr;
    }
    if (isfunctionptr(terminatefuncptr)) {
        level._plannerscriptfunctions["Action"][actionname]["Terminate"] = terminatefuncptr;
    }
}

