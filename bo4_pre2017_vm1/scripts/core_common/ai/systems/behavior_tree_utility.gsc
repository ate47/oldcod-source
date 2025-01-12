#namespace namespace_f55a5e73;

// Namespace namespace_f55a5e73/behavior_tree_utility
// Params 3, eflags: 0x0
// Checksum 0xf89ea476, Offset: 0xd0
// Size: 0xf4
function function_2b3cf3b0(functionname, functionptr, allowedcallsperframe) {
    if (!isdefined(level._behaviortreescriptfunctions)) {
        level._behaviortreescriptfunctions = [];
    }
    functionname = tolower(functionname);
    assert(isdefined(functionname) && isdefined(functionptr), "<dev string:x28>");
    assert(!isdefined(level._behaviortreescriptfunctions[functionname]), "<dev string:x97>");
    level._behaviortreescriptfunctions[functionname] = functionptr;
    if (isdefined(allowedcallsperframe)) {
        registerlimitedbehaviortreeapi(functionname, allowedcallsperframe);
    }
}

// Namespace namespace_f55a5e73/behavior_tree_utility
// Params 4, eflags: 0x0
// Checksum 0x9621ca60, Offset: 0x1d0
// Size: 0x214
function function_d3aec141(actionname, startfuncptr, updatefuncptr, terminatefuncptr) {
    if (!isdefined(level._behaviortreeactions)) {
        level._behaviortreeactions = [];
    }
    actionname = tolower(actionname);
    assert(isstring(actionname), "<dev string:xf4>");
    assert(!isdefined(level._behaviortreeactions[actionname]), "<dev string:x13c>" + actionname + "<dev string:x172>");
    level._behaviortreeactions[actionname] = array();
    if (isdefined(startfuncptr)) {
        assert(isfunctionptr(startfuncptr), "<dev string:x18a>");
        level._behaviortreeactions[actionname]["bhtn_action_start"] = startfuncptr;
    }
    if (isdefined(updatefuncptr)) {
        assert(isfunctionptr(updatefuncptr), "<dev string:x1cc>");
        level._behaviortreeactions[actionname]["bhtn_action_update"] = updatefuncptr;
    }
    if (isdefined(terminatefuncptr)) {
        assert(isfunctionptr(terminatefuncptr), "<dev string:x20f>");
        level._behaviortreeactions[actionname]["bhtn_action_terminate"] = terminatefuncptr;
    }
}

#namespace behaviortreenetworkutility;

// Namespace behaviortreenetworkutility/behavior_tree_utility
// Params 3, eflags: 0x0
// Checksum 0x379e6016, Offset: 0x3f0
// Size: 0x3c
function registerbehaviortreescriptapi(functionname, functionptr, allowedcallsperframe) {
    namespace_f55a5e73::function_2b3cf3b0(functionname, functionptr, allowedcallsperframe);
}

// Namespace behaviortreenetworkutility/behavior_tree_utility
// Params 4, eflags: 0x0
// Checksum 0x55ba2abc, Offset: 0x438
// Size: 0x44
function registerbehaviortreeaction(actionname, startfuncptr, updatefuncptr, terminatefuncptr) {
    namespace_f55a5e73::function_d3aec141(actionname, startfuncptr, updatefuncptr, terminatefuncptr);
}

