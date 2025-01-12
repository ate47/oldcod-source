#namespace plannerblackboard;

/#

    // Namespace plannerblackboard/planner_blackboard
    // Params 0, eflags: 0x2
    // Checksum 0x646dd5, Offset: 0x70
    // Size: 0x34
    function autoexec main() {
        level.__ai_debugplannerblackboard = getdvarint(#"ai_debugplannerblackboard", 0);
    }

#/

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x1 linked
// Checksum 0xd67f0d6b, Offset: 0xb0
// Size: 0x3e
function clearundostack(blackboard) {
    assert(isstruct(blackboard));
    blackboard.undostack = [];
}

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x1 linked
// Checksum 0x618a60f6, Offset: 0xf8
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
// Params 2, eflags: 0x1 linked
// Checksum 0x28cc0fe5, Offset: 0x180
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
// Params 1, eflags: 0x1 linked
// Checksum 0xc676693d, Offset: 0x280
// Size: 0x70
function getundostacksize(blackboard) {
    assert(isstruct(blackboard));
    assert(isarray(blackboard.undostack));
    return blackboard.undostack.size;
}

// Namespace plannerblackboard/planner_blackboard
// Params 4, eflags: 0x1 linked
// Checksum 0x7591905, Offset: 0x2f8
// Size: 0x2ac
function setattribute(blackboard, attribute, value, readonly = 0) {
    assert(isstruct(blackboard));
    assert(isstring(attribute) || ishash(attribute));
    assert(isarray(blackboard.values));
    assert(isarray(blackboard.undostack));
    assert(blackboard.mode === "<dev string:x38>");
    /#
        if (isdefined(level.__ai_debugplannerblackboard) && level.__ai_debugplannerblackboard > 0 && !readonly) {
            assert(!isstruct(value), "<dev string:x3e>");
            if (isarray(value)) {
                foreach (entryvalue in value) {
                    assert(!isstruct(entryvalue), "<dev string:x89>");
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
// Params 1, eflags: 0x1 linked
// Checksum 0x118ad160, Offset: 0x5b0
// Size: 0x1a
function setreadmode(blackboard) {
    blackboard.mode = "r";
}

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x1 linked
// Checksum 0xb515f6e1, Offset: 0x5d8
// Size: 0x1a
function setreadwritemode(blackboard) {
    blackboard.mode = "rw";
}

// Namespace plannerblackboard/planner_blackboard
// Params 2, eflags: 0x1 linked
// Checksum 0xe85d2688, Offset: 0x600
// Size: 0x144
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

