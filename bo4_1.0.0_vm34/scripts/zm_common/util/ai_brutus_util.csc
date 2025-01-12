#using scripts\core_common\ai\archetype_brutus;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm\ai\zm_ai_brutus;

#namespace zombie_brutus_util;

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x2
// Checksum 0x7f38a5e4, Offset: 0xd0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zombie_brutus_util", &__init__, undefined, undefined);
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x5cbbeb9d, Offset: 0x118
// Size: 0x4c
function __init__() {
    clientfield::register("actor", "brutus_lock_down", 1, 1, "int", &function_3d83eeec, 0, 0);
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 7, eflags: 0x0
// Checksum 0xe09d115a, Offset: 0x170
// Size: 0xbc
function function_3d83eeec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (bwasdemojump) {
        return;
    }
    if (bnewent) {
        println("<dev string:x30>");
    }
    if (binitialsnap) {
        println("<dev string:x3d>");
    }
    playrumbleonposition(localclientnum, "explosion_generic", self.origin);
}

