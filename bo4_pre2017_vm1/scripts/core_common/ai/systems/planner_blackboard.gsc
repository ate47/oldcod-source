#namespace plannerblackboard;

/#

    // Namespace plannerblackboard/planner_blackboard
    // Params 0, eflags: 0x2
    // Checksum 0xa253ca07, Offset: 0x98
    // Size: 0x30
    function autoexec main() {
        level.__ai_debugplannerblackboard = getdvarint("<dev string:x28>");
    }

#/

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x0
// Checksum 0xb34ad0de, Offset: 0xd0
// Size: 0x4c
function clearundostack(blackboard) {
    /#
        assert(isstruct(blackboard));
    #/
    blackboard.undostack = [];
}

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x0
// Checksum 0x55c21d54, Offset: 0x128
// Size: 0x98
function create(&blackboardvalues) {
    /#
        assert(isarray(blackboardvalues));
    #/
    blackboard = spawnstruct();
    blackboard.undostack = [];
    blackboard.values = blackboardvalues;
    setreadmode(blackboard);
    return blackboard;
}

// Namespace plannerblackboard/planner_blackboard
// Params 2, eflags: 0x0
// Checksum 0x60554b10, Offset: 0x1c8
// Size: 0xc0
function getattribute(blackboard, attribute) {
    /#
        assert(isstruct(blackboard));
    #/
    /#
        assert(isstring(attribute));
    #/
    /#
        assert(isarray(blackboard.values));
    #/
    return blackboard.values[attribute];
}

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x0
// Checksum 0x16639aa1, Offset: 0x290
// Size: 0x84
function getundostacksize(blackboard) {
    /#
        assert(isstruct(blackboard));
    #/
    /#
        assert(isarray(blackboard.undostack));
    #/
    return blackboard.undostack.size;
}

// Namespace plannerblackboard/planner_blackboard
// Params 4, eflags: 0x0
// Checksum 0x295f09e1, Offset: 0x320
// Size: 0x2ee
function setattribute(blackboard, attribute, value, readonly) {
    if (!isdefined(readonly)) {
        readonly = 0;
    }
    /#
        assert(isstruct(blackboard));
    #/
    /#
        assert(isstring(attribute));
    #/
    /#
        assert(isarray(blackboard.values));
    #/
    /#
        assert(isarray(blackboard.undostack));
    #/
    /#
        assert(blackboard.mode === "<dev string:x42>");
    #/
    /#
        if (isdefined(level.__ai_debugplannerblackboard) && level.__ai_debugplannerblackboard > 0 && !readonly) {
            /#
                assert(!isstruct(value), "<dev string:x45>");
            #/
            if (isarray(value)) {
                foreach (entryvalue in value) {
                    /#
                        assert(!isstruct(entryvalue), "<dev string:x8d>");
                    #/
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
// Checksum 0xadb9bfd6, Offset: 0x618
// Size: 0x20
function setreadmode(blackboard) {
    blackboard.mode = "r";
}

// Namespace plannerblackboard/planner_blackboard
// Params 1, eflags: 0x0
// Checksum 0x92bcaa2d, Offset: 0x640
// Size: 0x20
function setreadwritemode(blackboard) {
    blackboard.mode = "rw";
}

// Namespace plannerblackboard/planner_blackboard
// Params 2, eflags: 0x0
// Checksum 0x124bb41, Offset: 0x668
// Size: 0x172
function undo(blackboard, stackindex) {
    /#
        assert(isstruct(blackboard));
    #/
    /#
        assert(isarray(blackboard.values));
    #/
    /#
        assert(isarray(blackboard.undostack));
    #/
    /#
        assert(stackindex < blackboard.undostack.size);
    #/
    for (index = blackboard.undostack.size - 1; index > stackindex; index--) {
        stackvalue = blackboard.undostack[index];
        blackboard.values[stackvalue.attribute] = stackvalue.value;
        blackboard.undostack[index] = undefined;
    }
}

