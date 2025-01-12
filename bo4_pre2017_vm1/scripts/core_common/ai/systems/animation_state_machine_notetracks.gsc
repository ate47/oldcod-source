#using scripts/core_common/ai/systems/blackboard;

#namespace animationstatenetwork;

// Namespace animationstatenetwork/animation_state_machine_notetracks
// Params 0, eflags: 0x2
// Checksum 0x48a43720, Offset: 0xd0
// Size: 0x14
function autoexec initnotetrackhandler() {
    level._notetrack_handler = [];
}

// Namespace animationstatenetwork/runnotetrackhandler
// Params 1, eflags: 0x44
// Checksum 0x3d8a562b, Offset: 0xf0
// Size: 0xae
function private event_handler[runnotetrackhandler] runnotetrackhandler(eventstruct) {
    assert(isarray(eventstruct.notetracks));
    for (index = 0; index < eventstruct.notetracks.size; index++) {
        handlenotetrack(eventstruct.entity, eventstruct.notetracks[index]);
    }
}

// Namespace animationstatenetwork/animation_state_machine_notetracks
// Params 2, eflags: 0x4
// Checksum 0x2c4b0b0d, Offset: 0x1a8
// Size: 0x9c
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
// Checksum 0x90cfe6bb, Offset: 0x250
// Size: 0xda
function registernotetrackhandlerfunction(notetrackname, notetrackfuncptr) {
    assert(isstring(notetrackname), "<dev string:x28>");
    assert(isfunctionptr(notetrackfuncptr), "<dev string:x61>");
    assert(!isdefined(level._notetrack_handler[notetrackname]), "<dev string:xa9>" + notetrackname + "<dev string:xcc>");
    level._notetrack_handler[notetrackname] = notetrackfuncptr;
}

// Namespace animationstatenetwork/animation_state_machine_notetracks
// Params 3, eflags: 0x0
// Checksum 0x63b32898, Offset: 0x338
// Size: 0x76
function registerblackboardnotetrackhandler(notetrackname, blackboardattributename, blackboardvalue) {
    notetrackhandler = spawnstruct();
    notetrackhandler.blackboardattributename = blackboardattributename;
    notetrackhandler.blackboardvalue = blackboardvalue;
    level._notetrack_handler[notetrackname] = notetrackhandler;
}

