#using scripts/core_common/clientfield_shared;
#using scripts/core_common/system_shared;

#namespace player;

// Namespace player/player_shared
// Params 0, eflags: 0x2
// Checksum 0x40ac0a38, Offset: 0x108
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("player", &__init__, undefined, undefined);
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0xe46b94f0, Offset: 0x148
// Size: 0x4c
function __init__() {
    clientfield::register("world", "gameplay_started", 4000, 1, "int", &gameplay_started_callback, 0, 1);
}

// Namespace player/player_shared
// Params 7, eflags: 0x0
// Checksum 0x48553e7d, Offset: 0x1a0
// Size: 0x5c
function gameplay_started_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setdvar("cg_isGameplayActive", newval);
}

