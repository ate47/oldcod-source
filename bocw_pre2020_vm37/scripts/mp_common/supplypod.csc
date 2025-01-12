#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace supplypod;

// Namespace supplypod/supplypod
// Params 0, eflags: 0x6
// Checksum 0x3dfdbef9, Offset: 0xb0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"supplypod", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x5 linked
// Checksum 0xda712164, Offset: 0x100
// Size: 0x4c
function private function_70a657d8() {
    clientfield::register("scriptmover", "supplypod_placed", 1, 1, "int", &supplypod_placed, 0, 0);
}

// Namespace supplypod/supplypod
// Params 7, eflags: 0x5 linked
// Checksum 0x4fa1be4e, Offset: 0x158
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

