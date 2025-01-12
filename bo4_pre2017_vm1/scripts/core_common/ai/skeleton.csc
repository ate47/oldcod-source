#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/system_shared;

#namespace skeleton;

// Namespace skeleton/skeleton
// Params 0, eflags: 0x2
// Checksum 0x53ae9323, Offset: 0x158
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("skeleton", &__init__, undefined, undefined);
}

// Namespace skeleton/skeleton
// Params 0, eflags: 0x2
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function autoexec precache() {
    
}

// Namespace skeleton/skeleton
// Params 0, eflags: 0x0
// Checksum 0x1c149baa, Offset: 0x1a8
// Size: 0x64
function __init__() {
    if (ai::shouldregisterclientfieldforarchetype("skeleton")) {
        clientfield::register("actor", "skeleton", 1, 1, "int", &zombieclientutils::zombiehandler, 0, 0);
    }
}

#namespace zombieclientutils;

// Namespace zombieclientutils/skeleton
// Params 7, eflags: 0x0
// Checksum 0x792efb91, Offset: 0x218
// Size: 0x184
function zombiehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && entity.archetype != "zombie") {
        return;
    }
    if (!isdefined(entity.initializedgibcallbacks) || !entity.initializedgibcallbacks) {
        entity.initializedgibcallbacks = 1;
        gibclientutils::addgibcallback(localclientnum, entity, 8, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, 16, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, 32, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, 128, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, 256, &_gibcallback);
    }
}

// Namespace zombieclientutils/skeleton
// Params 3, eflags: 0x4
// Checksum 0x4759a39d, Offset: 0x3a8
// Size: 0xa6
function private _gibcallback(localclientnum, entity, gibflag) {
    switch (gibflag) {
    case 8:
        playsound(0, "zmb_zombie_head_gib", self.origin);
        break;
    case 16:
    case 32:
    case 128:
    case 256:
        playsound(0, "zmb_death_gibs", self.origin);
        break;
    }
}

