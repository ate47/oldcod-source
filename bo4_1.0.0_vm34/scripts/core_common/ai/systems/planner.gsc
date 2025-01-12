#using scripts\core_common\ai\systems\planner_blackboard;

#namespace planner;

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0x24668655, Offset: 0xb8
// Size: 0x114
function private _blackboardsapplyundostate(planner, state) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
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
// Checksum 0xe42f886b, Offset: 0x1d8
// Size: 0x104
function private _blackboardscalculateundostate(planner) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    state = [];
    foreach (key, blackboard in planner.blackboards) {
        state[key] = plannerblackboard::getundostacksize(blackboard) - 1;
    }
    return state;
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0x5e7a78a7, Offset: 0x2e8
// Size: 0xe0
function private _blackboardsreadmode(planner) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    foreach (blackboard in planner.blackboards) {
        plannerblackboard::setreadmode(blackboard);
    }
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0x2dcf0620, Offset: 0x3d0
// Size: 0xe0
function private _blackboardsreadwritemode(planner) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    foreach (blackboard in planner.blackboards) {
        plannerblackboard::setreadwritemode(blackboard);
    }
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0xb3b24223, Offset: 0x4b8
// Size: 0x52
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
// Checksum 0x27ed95bf, Offset: 0x518
// Size: 0x1e
function private _plancalculateplanindex(planner) {
    return planner.plan.size - 1;
}

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0x514ee56, Offset: 0x540
// Size: 0x298
function private _planexpandaction(planner, action) {
    planner.api = action.api;
    pixbeginevent(action.api);
    aiprofile_beginentry(action.api);
    assert(isstruct(planner));
    assert(isstruct(action));
    assert(action.type == "<dev string:x30>");
    assert(isarray(planner.plan));
    actionfuncs = plannerutility::getplanneractionfunctions(action.api);
    actioninfo = spawnstruct();
    actioninfo.name = action.api;
    if (isdefined(actionfuncs[#"parameterize"])) {
        _blackboardsreadwritemode(planner);
        actioninfo.params = [[ actionfuncs[#"parameterize"] ]](planner, action.constants);
        assert(isstruct(actioninfo.params), "<dev string:x37>" + action.api + "<dev string:x5d>");
        _blackboardsreadmode(planner);
    } else {
        actioninfo.params = spawnstruct();
    }
    planner.plan[planner.plan.size] = actioninfo;
    planner.api = undefined;
    aiprofile_endentry();
    pixendevent();
    return true;
}

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0xfc6f8324, Offset: 0x7e0
// Size: 0x170
function private _planexpandpostcondition(planner, postcondition) {
    planner.api = postcondition.api;
    pixbeginevent(postcondition.api);
    aiprofile_beginentry(postcondition.api);
    assert(isstruct(planner));
    assert(isstruct(postcondition));
    assert(postcondition.type == "<dev string:x75>");
    _blackboardsreadwritemode(planner);
    postconditionfunc = plannerutility::getplannerapifunction(postcondition.api);
    [[ postconditionfunc ]](planner, postcondition.constants);
    _blackboardsreadmode(planner);
    planner.api = undefined;
    aiprofile_endentry();
    pixendevent();
    return true;
}

// Namespace planner/planner
// Params 2, eflags: 0x4
// Checksum 0xc00b0de4, Offset: 0x958
// Size: 0x168
function private _planexpandprecondition(planner, precondition) {
    planner.api = precondition.api;
    pixbeginevent(precondition.api);
    aiprofile_beginentry(precondition.api);
    assert(isstruct(planner));
    assert(isstruct(precondition));
    assert(precondition.type == "<dev string:x83>");
    _blackboardsreadmode(planner);
    preconditionfunc = plannerutility::getplannerapifunction(precondition.api);
    result = [[ preconditionfunc ]](planner, precondition.constants);
    planner.api = undefined;
    aiprofile_endentry();
    pixendevent();
    return result;
}

// Namespace planner/planner
// Params 3, eflags: 0x4
// Checksum 0x87a2dde5, Offset: 0xac8
// Size: 0x64
function private _planfindnextsibling(planner, parentnodeentry, currentchildindex) {
    assert(isstruct(planner));
    return parentnodeentry.node.children[currentchildindex + 1];
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0xa3f78e86, Offset: 0xb38
// Size: 0x44
function private _planstackhasnodes(planner) {
    assert(isstruct(planner));
    return planner.nodestack.size > 0;
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0x6afe11a5, Offset: 0xb88
// Size: 0x8c
function private _planstackpeeknode(planner) {
    assert(isstruct(planner));
    assert(planner.nodestack.size > 0);
    nodeentry = planner.nodestack[planner.nodestack.size - 1];
    return nodeentry;
}

// Namespace planner/planner
// Params 1, eflags: 0x4
// Checksum 0x1b894bd8, Offset: 0xc20
// Size: 0xac
function private _planstackpopnode(planner) {
    assert(isstruct(planner));
    assert(planner.nodestack.size > 0);
    nodeentry = planner.nodestack[planner.nodestack.size - 1];
    planner.nodestack[planner.nodestack.size - 1] = undefined;
    return nodeentry;
}

// Namespace planner/planner
// Params 3, eflags: 0x4
// Checksum 0x31f4a9d1, Offset: 0xcd8
// Size: 0x126
function private _planstackpushnode(planner, node, childindex = undefined) {
    assert(isstruct(planner));
    assert(isstruct(node));
    nodeentry = spawnstruct();
    nodeentry.childindex = isdefined(childindex) ? childindex : -1;
    nodeentry.node = node;
    nodeentry.planindex = _plancalculateplanindex(planner);
    nodeentry.undostate = _blackboardscalculateundostate(planner);
    planner.nodestack[planner.nodestack.size] = nodeentry;
}

// Namespace planner/planner
// Params 3, eflags: 0x4
// Checksum 0xf1995d18, Offset: 0xe08
// Size: 0x28a
function private _planpushvalidparent(planner, childnodeentry, result) {
    while (_planstackhasnodes(planner)) {
        parentnodeentry = _planstackpeeknode(planner);
        assert(isdefined(parentnodeentry));
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
        case #"selector":
        case #"planner":
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
// Checksum 0x72c1b31, Offset: 0x10a0
// Size: 0x370
function private _planprocessstack(planner) {
    assert(isstruct(planner));
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
        case #"selector":
        case #"sequence":
        case #"planner":
            _planstackpushnode(planner, nodeentry.node.children[0], 0);
            continue;
        default:
            assert(0, "<dev string:x90>" + nodeentry.node.type + "<dev string:xb8>");
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
// Checksum 0x10c1ec36, Offset: 0x1418
// Size: 0xea
function private _undoplan(planner, planindex) {
    assert(isstruct(planner));
    assert(isarray(planner.plan));
    assert(planindex < planner.plan.size);
    for (index = planner.plan.size - 1; index > planindex && index >= 0; index--) {
        planner.plan[index] = undefined;
    }
}

// Namespace planner/planner
// Params 3, eflags: 0x0
// Checksum 0xf3169507, Offset: 0x1510
// Size: 0x58
function addaction(parent, actionname, constants) {
    node = createaction(actionname, constants);
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0x6c02327, Offset: 0x1570
// Size: 0xb2
function addchild(parent, node) {
    assert(isstruct(parent));
    assert(isstruct(node));
    assert(isarray(parent.children));
    parent.children[parent.children.size] = node;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0xcb01a467, Offset: 0x1630
// Size: 0x2c
function addgoto(parent, gotonode) {
    addchild(parent, gotonode);
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x9fc91e60, Offset: 0x1668
// Size: 0x40
function addselector(parent) {
    node = createselector();
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0xf5f5b43d, Offset: 0x16b0
// Size: 0x40
function addsequence(parent) {
    node = createsequence();
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 3, eflags: 0x0
// Checksum 0x33ba7704, Offset: 0x16f8
// Size: 0x58
function addpostcondition(parent, functionname, constants) {
    node = createpostcondition(functionname, constants);
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 3, eflags: 0x0
// Checksum 0x54e80bd6, Offset: 0x1758
// Size: 0x58
function addprecondition(parent, functionname, constants) {
    node = createprecondition(functionname, constants);
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0xe0953f9c, Offset: 0x17b8
// Size: 0x42
function cancel(planner) {
    assert(isstruct(planner));
    planner.cancel = 1;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0xbe4c3a84, Offset: 0x1808
// Size: 0xc6
function createaction(actionname, constants) {
    assert(!isdefined(constants) || isarray(constants));
    assert(ishash(actionname));
    node = spawnstruct();
    node.type = "action";
    node.api = actionname;
    node.constants = constants;
    return node;
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0xff7ba163, Offset: 0x18d8
// Size: 0xc6
function createplanner(name) {
    assert(ishash(name));
    planner = spawnstruct();
    planner.cancel = 0;
    planner.children = [];
    planner.name = name;
    planner.planning = 0;
    planner.type = "planner";
    planner.blackboards = [];
    planner.blackboards[0] = plannerblackboard::create([]);
    return planner;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0xdc7ddab0, Offset: 0x19a8
// Size: 0x126
function createpostcondition(functionname, constants) {
    assert(ishash(functionname));
    assert(!isdefined(constants) || isarray(constants));
    assert(isfunctionptr(plannerutility::getplannerapifunction(functionname)), "<dev string:xba>" + function_15979fa9(functionname) + "<dev string:xc6>");
    node = spawnstruct();
    node.type = "postcondition";
    node.api = functionname;
    node.constants = constants;
    return node;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0xa65325a9, Offset: 0x1ad8
// Size: 0x126
function createprecondition(functionname, constants) {
    assert(ishash(functionname));
    assert(!isdefined(constants) || isarray(constants));
    assert(isfunctionptr(plannerutility::getplannerapifunction(functionname)), "<dev string:xba>" + function_15979fa9(functionname) + "<dev string:xc6>");
    node = spawnstruct();
    node.type = "precondition";
    node.api = functionname;
    node.constants = constants;
    return node;
}

// Namespace planner/planner
// Params 0, eflags: 0x0
// Checksum 0xa79d80b7, Offset: 0x1c08
// Size: 0x42
function createselector() {
    node = spawnstruct();
    node.children = [];
    node.type = "selector";
    return node;
}

// Namespace planner/planner
// Params 0, eflags: 0x0
// Checksum 0xc4cea78, Offset: 0x1c58
// Size: 0x42
function createsequence() {
    node = spawnstruct();
    node.children = [];
    node.type = "sequence";
    return node;
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x5f6ec4f4, Offset: 0x1ca8
// Size: 0xd8
function createsubblackboard(planner) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    newblackboardindex = planner.blackboards.size;
    defaultvalues = [];
    planner.blackboards[newblackboardindex] = plannerblackboard::create(defaultvalues);
    plannerblackboard::setreadwritemode(planner.blackboards[newblackboardindex]);
    return newblackboardindex;
}

// Namespace planner/planner
// Params 3, eflags: 0x0
// Checksum 0x53186be3, Offset: 0x1d88
// Size: 0x122
function getblackboardattribute(planner, attribute, blackboardindex = 0) {
    assert(isstruct(planner));
    assert(isstring(attribute) || ishash(attribute));
    assert(isarray(planner.blackboards));
    assert(isstruct(planner.blackboards[blackboardindex]));
    return plannerblackboard::getattribute(planner.blackboards[blackboardindex], attribute);
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0x12a69c12, Offset: 0x1eb8
// Size: 0xba
function getblackboardvalues(planner, blackboardindex) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    assert(isstruct(planner.blackboards[blackboardindex]));
    return planner.blackboards[blackboardindex].values;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0x4717c514, Offset: 0x1f80
// Size: 0xb4
function getsubblackboard(planner, blackboardindex) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    assert(blackboardindex > 0 && blackboardindex < planner.blackboards.size);
    return planner.blackboards[blackboardindex];
}

// Namespace planner/planner
// Params 5, eflags: 0x0
// Checksum 0x9d76ac42, Offset: 0x2040
// Size: 0x2fe
function plan(planner, blackboardvalues, maxframetime = 3, starttime = undefined, var_47807be5 = 0) {
    pixbeginevent(planner.name);
    aiprofile_beginentry(planner.name);
    assert(isstruct(planner));
    assert(isarray(blackboardvalues));
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
    planner.planstarttime = starttime;
    if (!isdefined(planner.planstarttime)) {
        planner.planstarttime = getrealtime();
    }
    if (!var_47807be5) {
        planner.blackboards = [];
        planner.blackboards[0] = plannerblackboard::create(blackboardvalues);
    }
    planner.nodestack = [];
    _planstackpushnode(planner, planner);
    _planprocessstack(planner);
    planner.nodestack = [];
    planner.planning = 0;
    foreach (subblackboard in planner.blackboards) {
        plannerblackboard::clearundostack(subblackboard);
    }
    aiprofile_endentry();
    pixendevent();
    return planner.plan;
}

/#

    // Namespace planner/planner
    // Params 2, eflags: 0x0
    // Checksum 0xabdf73f, Offset: 0x2348
    // Size: 0xdc
    function printplanner(planner, filename) {
        assert(isstruct(planner));
        file = openfile(filename, "<dev string:xe1>");
        printid = randomint(2147483647);
        _printplannernode(file, planner, 0, printid);
        _printclearprintid(planner);
        closefile(file);
    }

    // Namespace planner/planner
    // Params 1, eflags: 0x4
    // Checksum 0xceda1985, Offset: 0x2430
    // Size: 0x96
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
    // Params 1, eflags: 0x4
    // Checksum 0x14885769, Offset: 0x24d0
    // Size: 0x256
    function private function_abb9c170(node) {
        text = node.type;
        if (isdefined(node.name)) {
            text += "<dev string:xe7>" + node.name;
        }
        if (isdefined(node.api)) {
            text += "<dev string:xe7>" + node.api;
        }
        if (isdefined(node.constants)) {
            text += "<dev string:xe7>";
            first = 1;
            foreach (key, value in node.constants) {
                if (!first) {
                    text += "<dev string:xe9>";
                }
                if (isint(value) || isfloat(value)) {
                    text += key + "<dev string:xec>" + value;
                } else if (isstring(value)) {
                    text += key + "<dev string:xef>" + value + "<dev string:xb8>";
                } else if (isarray(value)) {
                    text += key + "<dev string:xf3>";
                } else if (!isdefined(value)) {
                    text += key + "<dev string:x100>";
                }
                first = 0;
            }
        }
        if (isdefined(node.name) || isdefined(node.api)) {
            text += "<dev string:x10c>";
        }
        return text;
    }

    // Namespace planner/planner
    // Params 4, eflags: 0x4
    // Checksum 0xd1b3800b, Offset: 0x2730
    // Size: 0x1be
    function private _printplannernode(file, plannernode, indent, printid) {
        assert(isstruct(plannernode));
        indentspace = "<dev string:x10e>";
        for (index = 0; index < indent; index++) {
            indentspace += "<dev string:x10f>";
        }
        text = "<dev string:x10e>";
        if (plannernode.printid === printid) {
            text += "<dev string:x114>";
            text += function_abb9c170(plannernode);
            fprintln(file, indentspace + text);
            return;
        }
        plannernode.printid = printid;
        text = function_abb9c170(plannernode);
        fprintln(file, indentspace + text);
        if (isdefined(plannernode.children)) {
            for (index = 0; index < plannernode.children.size; index++) {
                _printplannernode(file, plannernode.children[index], indent + 1, printid);
            }
        }
    }

#/

// Namespace planner/planner
// Params 5, eflags: 0x0
// Checksum 0x40ccd02a, Offset: 0x28f8
// Size: 0x14c
function setblackboardattribute(planner, attribute, value, blackboardindex = 0, readonly = 0) {
    assert(isstruct(planner));
    assert(isstring(attribute) || ishash(attribute));
    assert(isarray(planner.blackboards));
    assert(isstruct(planner.blackboards[blackboardindex]));
    plannerblackboard::setattribute(planner.blackboards[blackboardindex], attribute, value, readonly);
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x2ddef8a7, Offset: 0x2a50
// Size: 0x76
function subblackboardcount(planner) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    return planner.blackboards.size - 1;
}

#namespace plannerutility;

// Namespace plannerutility/planner
// Params 1, eflags: 0x0
// Checksum 0x81b30343, Offset: 0x2ad0
// Size: 0x4aa
function createplannerfromasset(assetname) {
    htnasset = gethierarchicaltasknetwork(assetname);
    if (isdefined(htnasset) && htnasset.nodes.size > 0) {
        plannernodes = [];
        if (htnasset.nodes.size >= 1) {
            node = htnasset.nodes[0];
            plannernodes[0] = planner::createplanner(node.name);
        }
        for (nodeindex = 1; nodeindex < htnasset.nodes.size; nodeindex++) {
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
            if (!isdefined(htnnode.childindexes) || htnnode.type == #"goto") {
                continue;
            }
            for (childindex = 0; childindex < htnnode.childindexes.size; childindex++) {
                assert(htnnode.childindexes[childindex] < plannernodes.size);
                childnum = htnnode.childindexes[childindex];
                childnode = plannernodes[childnum];
                for (htnchildnode = htnasset.nodes[childnum]; htnchildnode.type === #"goto"; htnchildnode = htnasset.nodes[childnum]) {
                    assert(isdefined(htnchildnode.childindexes));
                    assert(htnchildnode.childindexes.size == 1);
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
// Checksum 0x33e3c3a4, Offset: 0x2f88
// Size: 0xbe
function getplannerapifunction(functionname) {
    assert(ishash(functionname) && functionname != "<dev string:x10e>", "<dev string:x11c>");
    assert(isdefined(level._plannerscriptfunctions[#"api"][functionname]), "<dev string:x154>" + function_15979fa9(functionname) + "<dev string:x171>");
    return level._plannerscriptfunctions[#"api"][functionname];
}

// Namespace plannerutility/planner
// Params 1, eflags: 0x0
// Checksum 0x7733ee69, Offset: 0x3050
// Size: 0xbe
function getplanneractionfunctions(actionname) {
    assert(ishash(actionname) && actionname != "<dev string:x10e>", "<dev string:x187>");
    assert(isdefined(level._plannerscriptfunctions[#"action"][actionname]), "<dev string:x1bd>" + function_15979fa9(actionname) + "<dev string:x171>");
    return level._plannerscriptfunctions[#"action"][actionname];
}

// Namespace plannerutility/planner
// Params 2, eflags: 0x0
// Checksum 0x1ac78e88, Offset: 0x3118
// Size: 0x13c
function registerplannerapi(functionname, functionptr) {
    assert(ishash(functionname) && functionname != "<dev string:x10e>", "<dev string:x1d8>");
    assert(isfunctionptr(functionptr), "<dev string:x215>" + function_15979fa9(functionname) + "<dev string:x242>");
    planner::_initializeplannerfunctions(#"api");
    assert(!isdefined(level._plannerscriptfunctions[#"api"][functionname]), "<dev string:x154>" + functionname + "<dev string:x261>");
    level._plannerscriptfunctions[#"api"][functionname] = functionptr;
}

// Namespace plannerutility/planner
// Params 5, eflags: 0x0
// Checksum 0xe2ff1129, Offset: 0x3260
// Size: 0x246
function registerplanneraction(actionname, paramfuncptr, initializefuncptr, updatefuncptr, terminatefuncptr) {
    assert(ishash(actionname) && actionname != "<dev string:x10e>", "<dev string:x275>");
    planner::_initializeplannerfunctions("Action");
    assert(!isdefined(level._plannerscriptfunctions[#"action"][actionname]), "<dev string:x1bd>" + function_15979fa9(actionname) + "<dev string:x261>");
    level._plannerscriptfunctions[#"action"][actionname] = [];
    if (isfunctionptr(paramfuncptr)) {
        level._plannerscriptfunctions[#"action"][actionname][#"parameterize"] = paramfuncptr;
    }
    if (isfunctionptr(initializefuncptr)) {
        level._plannerscriptfunctions[#"action"][actionname][#"initialize"] = initializefuncptr;
    }
    if (isfunctionptr(updatefuncptr)) {
        level._plannerscriptfunctions[#"action"][actionname][#"update"] = updatefuncptr;
    }
    if (isfunctionptr(terminatefuncptr)) {
        level._plannerscriptfunctions[#"action"][actionname][#"terminate"] = terminatefuncptr;
    }
}

