#namespace animationstatenetwork;

// Namespace animationstatenetwork/animation_state_machine_notetracks
// Params 0, eflags: 0x2
// Checksum 0xe2a94e90, Offset: 0x68
// Size: 0x12
function autoexec initnotetrackhandler() {
    level._notetrack_handler = [];
}

// Namespace animationstatenetwork/runnotetrackhandler
// Params 1, eflags: 0x44
// Checksum 0xf3d38db7, Offset: 0x88
// Size: 0x96
function private event_handler[runnotetrackhandler] runnotetrackhandler(eventstruct) {
    assert(isarray(eventstruct.notetracks));
    for (index = 0; index < eventstruct.notetracks.size; index++) {
        handlenotetrack(eventstruct.entity, eventstruct.notetracks[index]);
    }
}

// Namespace animationstatenetwork/animation_state_machine_notetracks
// Params 2, eflags: 0x4
// Checksum 0x35b6ecd8, Offset: 0x128
// Size: 0x8c
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
// Checksum 0x6fa479f3, Offset: 0x1c0
// Size: 0xca
function registernotetrackhandlerfunction(notetrackname, notetrackfuncptr) {
    assert(isstring(notetrackname), "<dev string:x30>");
    assert(isfunctionptr(notetrackfuncptr), "<dev string:x69>");
    assert(!isdefined(level._notetrack_handler[notetrackname]), "<dev string:xb1>" + notetrackname + "<dev string:xd4>");
    level._notetrack_handler[notetrackname] = notetrackfuncptr;
}

// Namespace animationstatenetwork/animation_state_machine_notetracks
// Params 3, eflags: 0x0
// Checksum 0xf2395ffb, Offset: 0x298
// Size: 0x6e
function registerblackboardnotetrackhandler(notetrackname, blackboardattributename, blackboardvalue) {
    notetrackhandler = spawnstruct();
    notetrackhandler.blackboardattributename = blackboardattributename;
    notetrackhandler.blackboardvalue = blackboardvalue;
    level._notetrack_handler[notetrackname] = notetrackhandler;
}

