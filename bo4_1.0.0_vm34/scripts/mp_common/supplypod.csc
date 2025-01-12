#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace supplypod;

// Namespace supplypod/supplypod
// Params 0, eflags: 0x2
// Checksum 0x65073a9d, Offset: 0xf0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"supplypod", &__init__, undefined, #"killstreaks");
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0x9e1793f1, Offset: 0x140
// Size: 0x84
function __init__() {
    clientfield::register("scriptmover", "supplypod_placed", 1, 1, "int", &supplypod_placed, 0, 0);
    clientfield::register("clientuimodel", "hudItems.goldenBullet", 1, 1, "int", undefined, 0, 0);
}

// Namespace supplypod/supplypod
// Params 7, eflags: 0x4
// Checksum 0xa5cc252d, Offset: 0x1d0
// Size: 0xac
function private supplypod_placed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    playtagfxset(localclientnum, "gadget_spawnbeacon_teamlight", self);
    self useanimtree("generic");
}

