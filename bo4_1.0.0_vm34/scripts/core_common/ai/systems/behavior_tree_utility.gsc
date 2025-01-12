#namespace behaviortreenetworkutility;

// Namespace behaviortreenetworkutility/behavior_tree_utility
// Params 3, eflags: 0x0
// Checksum 0x8d615620, Offset: 0x68
// Size: 0xcc
function registerbehaviortreescriptapi(functionname, functionptr, allowedcallsperframe) {
    if (!isdefined(level._behaviortreescriptfunctions)) {
        level._behaviortreescriptfunctions = [];
    }
    assert(isdefined(functionname) && isdefined(functionptr), "<dev string:x30>");
    assert(!isdefined(level._behaviortreescriptfunctions[functionname]), "<dev string:x9f>");
    level._behaviortreescriptfunctions[functionname] = functionptr;
    if (isdefined(allowedcallsperframe)) {
        registerlimitedbehaviortreeapi(functionname, allowedcallsperframe);
    }
}

// Namespace behaviortreenetworkutility/behavior_tree_utility
// Params 4, eflags: 0x0
// Checksum 0x70e425e, Offset: 0x140
// Size: 0x1e0
function registerbehaviortreeaction(actionname, startfuncptr, updatefuncptr, terminatefuncptr) {
    if (!isdefined(level._behaviortreeactions)) {
        level._behaviortreeactions = [];
    }
    assert(isdefined(actionname), "<dev string:xfc>");
    assert(!isdefined(level._behaviortreeactions[actionname]), "<dev string:x143>" + actionname + "<dev string:x179>");
    level._behaviortreeactions[actionname] = array();
    if (isdefined(startfuncptr)) {
        assert(isfunctionptr(startfuncptr), "<dev string:x191>");
        level._behaviortreeactions[actionname][#"bhtn_action_start"] = startfuncptr;
    }
    if (isdefined(updatefuncptr)) {
        assert(isfunctionptr(updatefuncptr), "<dev string:x1d3>");
        level._behaviortreeactions[actionname][#"bhtn_action_update"] = updatefuncptr;
    }
    if (isdefined(terminatefuncptr)) {
        assert(isfunctionptr(terminatefuncptr), "<dev string:x216>");
        level._behaviortreeactions[actionname][#"bhtn_action_terminate"] = terminatefuncptr;
    }
}

