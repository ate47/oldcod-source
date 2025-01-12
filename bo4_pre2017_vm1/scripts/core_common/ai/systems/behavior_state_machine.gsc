#namespace behaviorstatemachine;

// Namespace behaviorstatemachine/behavior_state_machine
// Params 2, eflags: 0x0
// Checksum 0xa6dc5a60, Offset: 0x98
// Size: 0xca
function registerbsmscriptapiinternal(functionname, scriptfunction) {
    if (!isdefined(level._bsmscriptfunctions)) {
        level._bsmscriptfunctions = [];
    }
    functionname = tolower(functionname);
    assert(isdefined(scriptfunction) && isdefined(scriptfunction), "<dev string:x28>");
    assert(!isdefined(level._bsmscriptfunctions[functionname]), "<dev string:x85>");
    level._bsmscriptfunctions[functionname] = scriptfunction;
}

