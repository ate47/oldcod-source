#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_now_you_see_me;

// Namespace zm_bgb_now_you_see_me/zm_bgb_now_you_see_me
// Params 0, eflags: 0x2
// Checksum 0xf6e6143f, Offset: 0xd8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_now_you_see_me", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_now_you_see_me/zm_bgb_now_you_see_me
// Params 0, eflags: 0x0
// Checksum 0x4dc859b2, Offset: 0x128
// Size: 0xcc
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_now_you_see_me", "activated");
    visionset_mgr::register_visionset_info("zm_bgb_now_you_see_me", 1, 31, undefined, "zm_bgb_in_plain_sight");
    clientfield::register("toplayer", "" + #"hash_18be2b4b3936ee1f", 1, 1, "int", &function_b06654cb, 0, 0);
}

// Namespace zm_bgb_now_you_see_me/zm_bgb_now_you_see_me
// Params 7, eflags: 0x0
// Checksum 0xe876ea0, Offset: 0x200
// Size: 0x94
function function_b06654cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self thread postfx::playpostfxbundle(#"hash_129cb5a3537b76f4");
        return;
    }
    self postfx::stoppostfxbundle(#"hash_129cb5a3537b76f4");
}

