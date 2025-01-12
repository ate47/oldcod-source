#namespace footsteps;

// Namespace footsteps/footsteps_shared
// Params 0, eflags: 0x0
// Checksum 0x955d1f4a, Offset: 0x68
// Size: 0x64
function missing_ai_footstep_callback() {
    /#
        type = self.archetype;
        if (!isdefined(type)) {
            type = "<dev string:x30>";
        }
        println("<dev string:x38>" + type + "<dev string:x47>" + self._aitype + "<dev string:xcb>");
    #/
}

// Namespace footsteps/footsteps_shared
// Params 2, eflags: 0x0
// Checksum 0x8cff35ce, Offset: 0xd8
// Size: 0x8a
function registeraitypefootstepcb(archetype, callback) {
    if (!isdefined(level._footstepcbfuncs)) {
        level._footstepcbfuncs = [];
    }
    assert(!isdefined(level._footstepcbfuncs[archetype]), "<dev string:xf9>" + archetype + "<dev string:x104>");
    level._footstepcbfuncs[archetype] = callback;
}

// Namespace footsteps/footsteps_shared
// Params 5, eflags: 0x0
// Checksum 0xa75aed84, Offset: 0x170
// Size: 0xe2
function playaifootstep(client_num, pos, surface, notetrack, bone) {
    if (!isdefined(self.archetype)) {
        println("<dev string:x131>");
        footstepdoeverything();
        return;
    }
    if (!isdefined(level._footstepcbfuncs) || !isdefined(level._footstepcbfuncs[self.archetype])) {
        self missing_ai_footstep_callback();
        footstepdoeverything();
        return;
    }
    [[ level._footstepcbfuncs[self.archetype] ]](client_num, pos, surface, notetrack, bone);
}

