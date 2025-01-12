#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_in_plain_sight;

// Namespace zm_bgb_in_plain_sight/zm_bgb_in_plain_sight
// Params 0, eflags: 0x2
// Checksum 0x1036869c, Offset: 0xc0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_in_plain_sight", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_in_plain_sight/zm_bgb_in_plain_sight
// Params 0, eflags: 0x0
// Checksum 0xc447e39d, Offset: 0x110
// Size: 0xcc
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_in_plain_sight", "activated");
    visionset_mgr::register_visionset_info("zm_bgb_in_plain_sight", 1, 31, undefined, "zm_bgb_in_plain_sight");
    clientfield::register("toplayer", "" + #"hash_321b58d22755af74", 1, 1, "int", &function_4a05bc42, 0, 0);
}

// Namespace zm_bgb_in_plain_sight/zm_bgb_in_plain_sight
// Params 7, eflags: 0x0
// Checksum 0xc9af50fa, Offset: 0x1e8
// Size: 0x94
function function_4a05bc42(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self thread postfx::playpostfxbundle(#"hash_1e8cc5b28385a579");
        return;
    }
    self postfx::stoppostfxbundle(#"hash_1e8cc5b28385a579");
}

