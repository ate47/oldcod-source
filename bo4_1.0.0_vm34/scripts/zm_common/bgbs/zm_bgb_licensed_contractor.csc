#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_licensed_contractor;

// Namespace zm_bgb_licensed_contractor/zm_bgb_licensed_contractor
// Params 0, eflags: 0x2
// Checksum 0xac6d80a8, Offset: 0x88
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_licensed_contractor", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_licensed_contractor/zm_bgb_licensed_contractor
// Params 0, eflags: 0x0
// Checksum 0xd2a655f0, Offset: 0xd8
// Size: 0x4c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_licensed_contractor", "activated");
}

