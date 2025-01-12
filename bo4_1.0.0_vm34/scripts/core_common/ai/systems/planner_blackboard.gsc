#namespace plannerblackboard;

/#

    // Namespace plannerblackboard/planner_blackboard
    // Params 0, eflags: 0x2
    // Checksum 0xf7a4a86f, Offset: 0x70
    // Size: 0x36
    function autoexec main() {
        level.__ai_debugplannerblackboard = getdvarint(#"ai_debugplannerblackboard", 0);
    }

#/

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x0
// Checksum 0xeec7c207, Offset: 0xb0
// Size: 0x42
function clearundostack(blackboard) {
    assert(isstruct(blackboard));
    blackboard.undostack = [];
}

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x0
// Checksum 0x41cccb7e, Offset: 0x100
// Size: 0x80
function create(&blackboardvalues) {
    assert(isarray(blackboardvalues));
    blackboard = spawnstruct();
    blackboard.undostack = [];
    blackboard.values = blackboardvalues;
    setreadmode(blackboard);
    return blackboard;
}

// Namespace plannerblackboard/planner_blackboard
// Params 2, eflags: 0x0
// Checksum 0x6c597f62, Offset: 0x188
// Size: 0xf8
function getattribute(blackboard, attribute) {
    assert(isstruct(blackboard));
    assert(isstring(attribute) || ishash(attribute));
    assert(isarray(blackboard.values));
    value = blackboard.values[attribute];
    if (isarray(value)) {
        return arraycopy(value);
    }
    return value;
}

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x0
// Checksum 0x430af99d, Offset: 0x288
// Size: 0x70
function getundostacksize(blackboard) {
    assert(isstruct(blackboard));
    assert(isarray(blackboard.undostack));
    return blackboard.undostack.size;
}

// Namespace plannerblackboard/planner_blackboard
// Params 4, eflags: 0x0
// Checksum 0xb6f3a1e8, Offset: 0x300
// Size: 0x2ba
function setattribute(blackboard, attribute, value, readonly = 0) {
    assert(isstruct(blackboard));
    assert(isstring(attribute) || ishash(attribute));
    assert(isarray(blackboard.values));
    assert(isarray(blackboard.undostack));
    assert(blackboard.mode === "<dev string:x30>");
    /#
        if (isdefined(level.__ai_debugplannerblackboard) && level.__ai_debugplannerblackboard > 0 && !readonly) {
            assert(!isstruct(value), "<dev string:x33>");
            if (isarray(value)) {
                foreach (entryvalue in value) {
                    assert(!isstruct(entryvalue), "<dev string:x7b>");
                }
            }
        }
    #/
    stackvalue = spawnstruct();
    stackvalue.attribute = attribute;
    stackvalue.value = blackboard.values[attribute];
    blackboard.undostack[blackboard.undostack.size] = stackvalue;
    blackboard.values[attribute] = value;
}

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x0
// Checksum 0x41910513, Offset: 0x5c8
// Size: 0x1e
function setreadmode(blackboard) {
    blackboard.mode = "r";
}

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x0
// Checksum 0x6ae686f2, Offset: 0x5f0
// Size: 0x1e
function setreadwritemode(blackboard) {
    blackboard.mode = "rw";
}

// Namespace plannerblackboard/planner_blackboard
// Params 2, eflags: 0x0
// Checksum 0x52a49e4f, Offset: 0x618
// Size: 0x15e
function undo(blackboard, stackindex) {
    assert(isstruct(blackboard));
    assert(isarray(blackboard.values));
    assert(isarray(blackboard.undostack));
    assert(stackindex < blackboard.undostack.size);
    for (index = blackboard.undostack.size - 1; index > stackindex; index--) {
        stackvalue = blackboard.undostack[index];
        blackboard.values[stackvalue.attribute] = stackvalue.value;
        arrayremoveindex(blackboard.undostack, index);
    }
}

