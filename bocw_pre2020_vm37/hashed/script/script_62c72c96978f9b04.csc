#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_fasttravel;

#namespace namespace_dbb31ff3;

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 0, eflags: 0x6
// Checksum 0x4f5ee66d, Offset: 0xa0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_7bb41176a4b58056", &function_70a657d8, undefined, &finalize, undefined);
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 0, eflags: 0x5 linked
// Checksum 0x825302bd, Offset: 0xf0
// Size: 0x5c
function private function_70a657d8() {
    clientfield::register("toplayer", "" + #"hash_5616eb8cc6b9c498", 1, 1, "counter", &function_595556d0, 0, 0);
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x158
// Size: 0x4
function private finalize() {
    
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 7, eflags: 0x1 linked
// Checksum 0x28cc1eb7, Offset: 0x168
// Size: 0x74
function function_595556d0(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    wait 3;
    self postfx::playpostfxbundle(#"hash_7fbc9bc489aea188");
}

