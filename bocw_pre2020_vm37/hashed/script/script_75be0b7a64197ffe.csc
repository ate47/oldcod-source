#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace namespace_2c949ef8;

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x80
// Size: 0x4
function init() {
    
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 7, eflags: 0x0
// Checksum 0xc0b4f754, Offset: 0x90
// Size: 0xac
function function_ac525f72(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    self endon(#"death", #"disconnect");
    self postfx::playpostfxbundle(#"hash_66a9fee7028a1e13");
    wait 8;
    self postfx::exitpostfxbundle(#"hash_66a9fee7028a1e13");
}

