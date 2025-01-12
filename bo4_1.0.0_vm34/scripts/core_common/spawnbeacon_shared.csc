#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace spawn_beacon;

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x58b188ff, Offset: 0x128
// Size: 0x14
function init_shared() {
    setupclientfields();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xb302c6e7, Offset: 0x148
// Size: 0xbc
function setupclientfields() {
    clientfield::register("scriptmover", "spawnbeacon_placed", 1, 1, "int", &spawnbeacon_placed, 0, 0);
    clientfield::register("clientuimodel", "hudItems.spawnbeacon.cooldownPenalty", 1, 6, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.spawnbeacon.active", 1, 1, "int", undefined, 0, 0);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 7, eflags: 0x4
// Checksum 0x65732c8c, Offset: 0x210
// Size: 0xe4
function private spawnbeacon_placed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    playtagfxset(localclientnum, "gadget_spawnbeacon_teamlight", self);
    self useanimtree("generic");
    self setanimrestart("o_spawn_beacon_deploy", 1, 0, 1);
}

