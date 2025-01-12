#namespace footsteps;

// Namespace footsteps/footsteps_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x6206f4f2, Offset: 0x60
// Size: 0x94
function missing_ai_footstep_callback() {
    /#
        type = self.archetype;
        aitype = self._aitype;
        if (!isdefined(type)) {
            type = "<dev string:x38>";
        }
        if (!isdefined(self._aitype)) {
            aitype = "<dev string:x38>";
        }
        println("<dev string:x43>" + type + "<dev string:x55>" + aitype + "<dev string:xdc>");
    #/
}

// Namespace footsteps/footsteps_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x42428ee3, Offset: 0x100
// Size: 0x84
function registeraitypefootstepcb(archetype, callback) {
    if (!isdefined(level._footstepcbfuncs)) {
        level._footstepcbfuncs = [];
    }
    assert(!isdefined(level._footstepcbfuncs[archetype]), "<dev string:x10d>" + archetype + "<dev string:x11b>");
    level._footstepcbfuncs[archetype] = callback;
}

// Namespace footsteps/footsteps_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x4b7775fa, Offset: 0x190
// Size: 0xda
function playaifootstep(client_num, pos, surface, notetrack, bone) {
    if (!isdefined(self.archetype)) {
        println("<dev string:x14b>");
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

