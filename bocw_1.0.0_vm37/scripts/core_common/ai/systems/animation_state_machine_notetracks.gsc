#namespace animationstatenetwork;

// Namespace animationstatenetwork/animation_state_machine_notetracks
// Params 0, eflags: 0x2
// Checksum 0xe7225207, Offset: 0x60
// Size: 0x10
function autoexec initnotetrackhandler() {
    level._notetrack_handler = [];
}

// Namespace animationstatenetwork/runnotetrackhandler
// Params 1, eflags: 0x44
// Checksum 0x2b3c2646, Offset: 0x78
// Size: 0x8c
function private event_handler[runnotetrackhandler] runnotetrackhandler(eventstruct) {
    assert(isarray(eventstruct.notetracks));
    for (index = 0; index < eventstruct.notetracks.size; index++) {
        handlenotetrack(eventstruct.entity, eventstruct.notetracks[index]);
    }
}

// Namespace animationstatenetwork/animation_state_machine_notetracks
// Params 2, eflags: 0x4
// Checksum 0xc8adbcc0, Offset: 0x110
// Size: 0x84
function private handlenotetrack(entity, notetrack) {
    notetrackhandler = level._notetrack_handler[notetrack];
    if (!isdefined(notetrackhandler)) {
        return;
    }
    if (isfunctionptr(notetrackhandler)) {
        [[ notetrackhandler ]](entity);
        return;
    }
    entity setblackboardattribute(notetrackhandler.blackboardattributename, notetrackhandler.blackboardvalue);
}

// Namespace animationstatenetwork/animation_state_machine_notetracks
// Params 2, eflags: 0x0
// Checksum 0x90a2775d, Offset: 0x1a0
// Size: 0xc4
function registernotetrackhandlerfunction(notetrackname, notetrackfuncptr) {
    assert(isstring(notetrackname), "<dev string:x38>");
    assert(isfunctionptr(notetrackfuncptr), "<dev string:x74>");
    assert(!isdefined(level._notetrack_handler[notetrackname]), "<dev string:xbf>" + notetrackname + "<dev string:xe5>");
    level._notetrack_handler[notetrackname] = notetrackfuncptr;
}

// Namespace animationstatenetwork/animation_state_machine_notetracks
// Params 3, eflags: 0x0
// Checksum 0x5c294622, Offset: 0x270
// Size: 0x5c
function registerblackboardnotetrackhandler(notetrackname, blackboardattributename, blackboardvalue) {
    notetrackhandler = spawnstruct();
    notetrackhandler.blackboardattributename = blackboardattributename;
    notetrackhandler.blackboardvalue = blackboardvalue;
    level._notetrack_handler[notetrackname] = notetrackhandler;
}

