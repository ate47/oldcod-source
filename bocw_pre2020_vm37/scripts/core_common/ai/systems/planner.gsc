#using scripts\core_common\ai\systems\planner_blackboard;

#namespace planner;

// Namespace planner/planner
// Params 2, eflags: 0x5 linked
// Checksum 0xfdf87885, Offset: 0xc0
// Size: 0x11c
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
// Params 1, eflags: 0x5 linked
// Checksum 0x7a7ab82, Offset: 0x1e8
// Size: 0x10a
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
// Params 1, eflags: 0x5 linked
// Checksum 0x2aec8a20, Offset: 0x300
// Size: 0xe8
function private _blackboardsreadmode(planner) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    foreach (blackboard in planner.blackboards) {
        plannerblackboard::setreadmode(blackboard);
    }
}

// Namespace planner/planner
// Params 1, eflags: 0x5 linked
// Checksum 0x6493b48e, Offset: 0x3f0
// Size: 0xe8
function private _blackboardsreadwritemode(planner) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    foreach (blackboard in planner.blackboards) {
        plannerblackboard::setreadwritemode(blackboard);
    }
}

// Namespace planner/planner
// Params 1, eflags: 0x5 linked
// Checksum 0xac1a867e, Offset: 0x4e0
// Size: 0x50
function private _initializeplannerfunctions(functype) {
    if (!isdefined(level._plannerscriptfunctions)) {
        level._plannerscriptfunctions = [];
    }
    if (!isdefined(level._plannerscriptfunctions[functype])) {
        level._plannerscriptfunctions[functype] = [];
    }
}

// Namespace planner/planner
// Params 1, eflags: 0x5 linked
// Checksum 0x3fa33592, Offset: 0x538
// Size: 0x1e
function private _plancalculateplanindex(planner) {
    return planner.plan.size - 1;
}

// Namespace planner/planner
// Params 2, eflags: 0x5 linked
// Checksum 0xfe4a063c, Offset: 0x560
// Size: 0x280
function private _planexpandaction(planner, action) {
    planner.api = action.api;
    pixbeginevent(action.api);
    aiprofile_beginentry(action.api);
    assert(isstruct(planner));
    assert(isstruct(action));
    assert(action.type == "<dev string:x38>");
    assert(isarray(planner.plan));
    actionfuncs = plannerutility::getplanneractionfunctions(action.api);
    actioninfo = spawnstruct();
    actioninfo.name = action.api;
    if (isdefined(actionfuncs[#"parameterize"])) {
        _blackboardsreadwritemode(planner);
        actioninfo.params = [[ actionfuncs[#"parameterize"] ]](planner, action.constants);
        assert(isstruct(actioninfo.params), "<dev string:x42>" + action.api + "<dev string:x6b>");
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
// Params 2, eflags: 0x5 linked
// Checksum 0xc1669991, Offset: 0x7e8
// Size: 0x170
function private _planexpandpostcondition(planner, postcondition) {
    planner.api = postcondition.api;
    pixbeginevent(postcondition.api);
    aiprofile_beginentry(postcondition.api);
    assert(isstruct(planner));
    assert(isstruct(postcondition));
    assert(postcondition.type == "<dev string:x86>");
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
// Params 2, eflags: 0x5 linked
// Checksum 0x8d7ca4f, Offset: 0x960
// Size: 0x160
function private _planexpandprecondition(planner, precondition) {
    planner.api = precondition.api;
    pixbeginevent(precondition.api);
    aiprofile_beginentry(precondition.api);
    assert(isstruct(planner));
    assert(isstruct(precondition));
    assert(precondition.type == "<dev string:x97>");
    _blackboardsreadmode(planner);
    preconditionfunc = plannerutility::getplannerapifunction(precondition.api);
    result = [[ preconditionfunc ]](planner, precondition.constants);
    planner.api = undefined;
    aiprofile_endentry();
    pixendevent();
    return result;
}

// Namespace planner/planner
// Params 3, eflags: 0x5 linked
// Checksum 0xd5f4b73a, Offset: 0xac8
// Size: 0x60
function private _planfindnextsibling(planner, parentnodeentry, currentchildindex) {
    assert(isstruct(planner));
    return parentnodeentry.node.children[currentchildindex + 1];
}

// Namespace planner/planner
// Params 1, eflags: 0x5 linked
// Checksum 0x6b99d69d, Offset: 0xb30
// Size: 0x44
function private _planstackhasnodes(planner) {
    assert(isstruct(planner));
    return planner.nodestack.size > 0;
}

// Namespace planner/planner
// Params 1, eflags: 0x5 linked
// Checksum 0xb075c617, Offset: 0xb80
// Size: 0x88
function private _planstackpeeknode(planner) {
    assert(isstruct(planner));
    assert(planner.nodestack.size > 0);
    nodeentry = planner.nodestack[planner.nodestack.size - 1];
    return nodeentry;
}

// Namespace planner/planner
// Params 1, eflags: 0x5 linked
// Checksum 0xd2ff2d6c, Offset: 0xc10
// Size: 0xa4
function private _planstackpopnode(planner) {
    assert(isstruct(planner));
    assert(planner.nodestack.size > 0);
    nodeentry = planner.nodestack[planner.nodestack.size - 1];
    planner.nodestack[planner.nodestack.size - 1] = undefined;
    return nodeentry;
}

// Namespace planner/planner
// Params 3, eflags: 0x5 linked
// Checksum 0xa01c1cd5, Offset: 0xcc0
// Size: 0x10c
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
// Params 3, eflags: 0x5 linked
// Checksum 0x7239ea41, Offset: 0xdd8
// Size: 0x272
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
// Params 1, eflags: 0x5 linked
// Checksum 0x9a6c0faa, Offset: 0x1058
// Size: 0x23a
function private _planprocessstack(planner) {
    assert(isstruct(planner));
    result = 1;
    waitedinthrottle = 0;
    while (_planstackhasnodes(planner)) {
        planner.planstarttime = getrealtime();
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
            assert(0, "<dev string:xa7>" + nodeentry.node.type + "<dev string:xd2>");
            break;
        }
        result = _planpushvalidparent(planner, nodeentry, result);
    }
}

// Namespace planner/planner
// Params 2, eflags: 0x5 linked
// Checksum 0x7db834b1, Offset: 0x12a0
// Size: 0xe0
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
// Checksum 0xf46cc10, Offset: 0x1388
// Size: 0x58
function addaction(parent, actionname, constants) {
    node = createaction(actionname, constants);
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 2, eflags: 0x1 linked
// Checksum 0xf0a62ee0, Offset: 0x13e8
// Size: 0xac
function addchild(parent, node) {
    assert(isstruct(parent));
    assert(isstruct(node));
    assert(isarray(parent.children));
    parent.children[parent.children.size] = node;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0x2e8c87e4, Offset: 0x14a0
// Size: 0x2c
function addgoto(parent, gotonode) {
    addchild(parent, gotonode);
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x500e77d4, Offset: 0x14d8
// Size: 0x40
function addselector(parent) {
    node = createselector();
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x4e0dfe67, Offset: 0x1520
// Size: 0x40
function addsequence(parent) {
    node = createsequence();
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 3, eflags: 0x0
// Checksum 0x4e0db6f8, Offset: 0x1568
// Size: 0x58
function addpostcondition(parent, functionname, constants) {
    node = createpostcondition(functionname, constants);
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 3, eflags: 0x0
// Checksum 0x49729640, Offset: 0x15c8
// Size: 0x58
function addprecondition(parent, functionname, constants) {
    node = createprecondition(functionname, constants);
    addchild(parent, node);
    return node;
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x44651485, Offset: 0x1628
// Size: 0x42
function cancel(planner) {
    assert(isstruct(planner));
    planner.cancel = 1;
}

// Namespace planner/planner
// Params 2, eflags: 0x1 linked
// Checksum 0x7221af31, Offset: 0x1678
// Size: 0xba
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
// Params 1, eflags: 0x1 linked
// Checksum 0x6a79c9ee, Offset: 0x1740
// Size: 0xbc
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
// Params 2, eflags: 0x1 linked
// Checksum 0xbe111995, Offset: 0x1808
// Size: 0x11a
function createpostcondition(functionname, constants) {
    assert(ishash(functionname));
    assert(!isdefined(constants) || isarray(constants));
    assert(isfunctionptr(plannerutility::getplannerapifunction(functionname)), "<dev string:xd7>" + function_9e72a96(functionname) + "<dev string:xe6>");
    node = spawnstruct();
    node.type = "postcondition";
    node.api = functionname;
    node.constants = constants;
    return node;
}

// Namespace planner/planner
// Params 2, eflags: 0x1 linked
// Checksum 0x3332f10f, Offset: 0x1930
// Size: 0x11a
function createprecondition(functionname, constants) {
    assert(ishash(functionname));
    assert(!isdefined(constants) || isarray(constants));
    assert(isfunctionptr(plannerutility::getplannerapifunction(functionname)), "<dev string:xd7>" + function_9e72a96(functionname) + "<dev string:xe6>");
    node = spawnstruct();
    node.type = "precondition";
    node.api = functionname;
    node.constants = constants;
    return node;
}

// Namespace planner/planner
// Params 0, eflags: 0x1 linked
// Checksum 0xbfafdf0c, Offset: 0x1a58
// Size: 0x3e
function createselector() {
    node = spawnstruct();
    node.children = [];
    node.type = "selector";
    return node;
}

// Namespace planner/planner
// Params 0, eflags: 0x1 linked
// Checksum 0x63ac90c0, Offset: 0x1aa0
// Size: 0x3e
function createsequence() {
    node = spawnstruct();
    node.children = [];
    node.type = "sequence";
    return node;
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x26b6b754, Offset: 0x1ae8
// Size: 0xd0
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
// Checksum 0xcdf1ad78, Offset: 0x1bc0
// Size: 0x11a
function getblackboardattribute(planner, attribute, blackboardindex = 0) {
    assert(isstruct(planner));
    assert(isstring(attribute) || ishash(attribute));
    assert(isarray(planner.blackboards));
    assert(isstruct(planner.blackboards[blackboardindex]));
    return plannerblackboard::getattribute(planner.blackboards[blackboardindex], attribute);
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0x2de79299, Offset: 0x1ce8
// Size: 0xb6
function getblackboardvalues(planner, blackboardindex) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    assert(isstruct(planner.blackboards[blackboardindex]));
    return planner.blackboards[blackboardindex].values;
}

// Namespace planner/planner
// Params 2, eflags: 0x0
// Checksum 0x6f179b5f, Offset: 0x1da8
// Size: 0xa8
function getsubblackboard(planner, blackboardindex) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    assert(blackboardindex > 0 && blackboardindex < planner.blackboards.size);
    return planner.blackboards[blackboardindex];
}

// Namespace planner/planner
// Params 5, eflags: 0x0
// Checksum 0x80f14bc6, Offset: 0x1e58
// Size: 0x276
function plan(planner, blackboardvalues, maxframetime = 3, starttime = undefined, var_302e19d3 = 0) {
    pixbeginevent(planner.name);
    aiprofile_beginentry(planner.name);
    assert(isstruct(planner));
    assert(isarray(blackboardvalues));
    planner.cancel = 0;
    planner.maxframetime = maxframetime;
    planner.plan = [];
    planner.planning = 1;
    planner.planstarttime = starttime;
    if (!isdefined(planner.planstarttime)) {
        planner.planstarttime = getrealtime();
    }
    if (!var_302e19d3) {
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
    // Checksum 0x2faa7315, Offset: 0x20d8
    // Size: 0xdc
    function printplanner(planner, filename) {
        assert(isstruct(planner));
        file = openfile(filename, "<dev string:x104>");
        printid = randomint(2147483647);
        _printplannernode(file, planner, 0, printid);
        _printclearprintid(planner);
        closefile(file);
    }

    // Namespace planner/planner
    // Params 1, eflags: 0x4
    // Checksum 0x3d52c41d, Offset: 0x21c0
    // Size: 0x8c
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
    // Checksum 0x63934810, Offset: 0x2258
    // Size: 0x24e
    function private function_3af5bab0(node) {
        text = node.type;
        if (isdefined(node.name)) {
            text += "<dev string:x10d>" + node.name;
        }
        if (isdefined(node.api)) {
            text += "<dev string:x10d>" + node.api;
        }
        if (isdefined(node.constants)) {
            text += "<dev string:x10d>";
            first = 1;
            foreach (key, value in node.constants) {
                if (!first) {
                    text += "<dev string:x112>";
                }
                if (isint(value) || isfloat(value)) {
                    text += key + "<dev string:x118>" + value;
                } else if (isstring(value)) {
                    text += key + "<dev string:x11e>" + value + "<dev string:xd2>";
                } else if (isarray(value)) {
                    text += key + "<dev string:x125>";
                } else if (!isdefined(value)) {
                    text += key + "<dev string:x135>";
                }
                first = 0;
            }
        }
        if (isdefined(node.name) || isdefined(node.api)) {
            text += "<dev string:x144>";
        }
        return text;
    }

    // Namespace planner/planner
    // Params 4, eflags: 0x4
    // Checksum 0x1ea32431, Offset: 0x24b0
    // Size: 0x1a4
    function private _printplannernode(file, plannernode, indent, printid) {
        assert(isstruct(plannernode));
        indentspace = "<dev string:x149>";
        for (index = 0; index < indent; index++) {
            indentspace += "<dev string:x14d>";
        }
        text = "<dev string:x149>";
        if (plannernode.printid === printid) {
            text += "<dev string:x155>";
            text += function_3af5bab0(plannernode);
            fprintln(file, indentspace + text);
            return;
        }
        plannernode.printid = printid;
        text = function_3af5bab0(plannernode);
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
// Checksum 0x5687685e, Offset: 0x2660
// Size: 0x144
function setblackboardattribute(planner, attribute, value, blackboardindex = 0, readonly = 0) {
    assert(isstruct(planner));
    assert(isstring(attribute) || ishash(attribute));
    assert(isarray(planner.blackboards));
    assert(isstruct(planner.blackboards[blackboardindex]));
    plannerblackboard::setattribute(planner.blackboards[blackboardindex], attribute, value, readonly);
}

// Namespace planner/planner
// Params 1, eflags: 0x0
// Checksum 0x6f1a0897, Offset: 0x27b0
// Size: 0x76
function subblackboardcount(planner) {
    assert(isstruct(planner));
    assert(isarray(planner.blackboards));
    return planner.blackboards.size - 1;
}

#namespace plannerutility;

// Namespace plannerutility/planner
// Params 1, eflags: 0x0
// Checksum 0xb54f61d7, Offset: 0x2830
// Size: 0x45c
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
// Params 1, eflags: 0x1 linked
// Checksum 0x4c03e233, Offset: 0x2c98
// Size: 0xbe
function getplannerapifunction(functionname) {
    assert(ishash(functionname) && functionname != "<dev string:x149>", "<dev string:x160>");
    assert(isdefined(level._plannerscriptfunctions[#"api"][functionname]), "<dev string:x19b>" + function_9e72a96(functionname) + "<dev string:x1bb>");
    return level._plannerscriptfunctions[#"api"][functionname];
}

// Namespace plannerutility/planner
// Params 1, eflags: 0x1 linked
// Checksum 0xf3720335, Offset: 0x2d60
// Size: 0xbe
function getplanneractionfunctions(actionname) {
    assert(ishash(actionname) && actionname != "<dev string:x149>", "<dev string:x1d4>");
    assert(isdefined(level._plannerscriptfunctions[#"action"][actionname]), "<dev string:x20d>" + function_9e72a96(actionname) + "<dev string:x1bb>");
    return level._plannerscriptfunctions[#"action"][actionname];
}

// Namespace plannerutility/planner
// Params 2, eflags: 0x0
// Checksum 0x446aa92a, Offset: 0x2e28
// Size: 0x12e
function registerplannerapi(functionname, functionptr) {
    assert(ishash(functionname) && functionname != "<dev string:x149>", "<dev string:x22b>");
    assert(isfunctionptr(functionptr), "<dev string:x26b>" + function_9e72a96(functionname) + "<dev string:x29b>");
    planner::_initializeplannerfunctions(#"api");
    assert(!isdefined(level._plannerscriptfunctions[#"api"][functionname]), "<dev string:x19b>" + functionname + "<dev string:x2bd>");
    level._plannerscriptfunctions[#"api"][functionname] = functionptr;
}

// Namespace plannerutility/planner
// Params 5, eflags: 0x0
// Checksum 0x52d3ed39, Offset: 0x2f60
// Size: 0x220
function registerplanneraction(actionname, paramfuncptr, initializefuncptr, updatefuncptr, terminatefuncptr) {
    assert(ishash(actionname) && actionname != "<dev string:x149>", "<dev string:x2d4>");
    planner::_initializeplannerfunctions("Action");
    assert(!isdefined(level._plannerscriptfunctions[#"action"][actionname]), "<dev string:x20d>" + function_9e72a96(actionname) + "<dev string:x2bd>");
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

