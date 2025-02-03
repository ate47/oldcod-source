#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace supplypod;

// Namespace supplypod/supplypod
// Params 0, eflags: 0x6
// Checksum 0x7f7f0f80, Offset: 0xb0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"supplypod", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x4
// Checksum 0x1dae6b64, Offset: 0x100
// Size: 0x4c
function private preinit() {
    clientfield::register("scriptmover", "supplypod_placed", 1, 1, "int", &supplypod_placed, 0, 0);
}

// Namespace supplypod/supplypod
// Params 7, eflags: 0x4
// Checksum 0x73c82318, Offset: 0x158
// Size: 0xa4
function private supplypod_placed(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(bwastimejump);
    if (!isdefined(self)) {
        return;
    }
    self function_1f0c7136(4);
    self useanimtree("generic");
}

