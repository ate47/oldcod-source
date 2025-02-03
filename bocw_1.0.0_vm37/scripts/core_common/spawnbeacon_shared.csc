#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace spawn_beacon;

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x461ab6f1, Offset: 0x100
// Size: 0x14
function init_shared() {
    setupclientfields();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x6b5a8efa, Offset: 0x120
// Size: 0xbc
function setupclientfields() {
    clientfield::register("scriptmover", "spawnbeacon_placed", 1, 1, "int", &spawnbeacon_placed, 0, 0);
    clientfield::register_clientuimodel("hudItems.spawnbeacon.active", #"hud_items", [#"spawnbeacon", #"active"], 1, 1, "int", undefined, 0, 0);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 7, eflags: 0x4
// Checksum 0xafbb37d4, Offset: 0x1e8
// Size: 0xe4
function private spawnbeacon_placed(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(bwastimejump);
    if (!isdefined(self)) {
        return;
    }
    playtagfxset(bwastimejump, "gadget_spawnbeacon_teamlight", self);
    self useanimtree("generic");
    self setanimrestart("o_spawn_beacon_deploy", 1, 0, 1);
}

