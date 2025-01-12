#namespace behaviorstatemachine;

// Namespace behaviorstatemachine/behavior_state_machine
// Params 2, eflags: 0x0
// Checksum 0xc8ec235c, Offset: 0x68
// Size: 0xa2
function registerbsmscriptapiinternal(functionname, scriptfunction) {
    if (!isdefined(level._bsmscriptfunctions)) {
        level._bsmscriptfunctions = [];
    }
    assert(isdefined(scriptfunction) && isdefined(scriptfunction), "<dev string:x30>");
    assert(!isdefined(level._bsmscriptfunctions[functionname]), "<dev string:x8d>");
    level._bsmscriptfunctions[functionname] = scriptfunction;
}

