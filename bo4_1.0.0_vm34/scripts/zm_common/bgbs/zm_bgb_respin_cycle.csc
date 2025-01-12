#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_respin_cycle;

// Namespace zm_bgb_respin_cycle/zm_bgb_respin_cycle
// Params 0, eflags: 0x2
// Checksum 0x773378f2, Offset: 0xd8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_respin_cycle", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_respin_cycle/zm_bgb_respin_cycle
// Params 0, eflags: 0x0
// Checksum 0xeb3b4aa3, Offset: 0x128
// Size: 0xb2
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_respin_cycle", "activated");
    clientfield::register("zbarrier", "zm_bgb_respin_cycle", 1, 1, "counter", &function_74ecbbd7, 0, 0);
    level._effect["zm_bgb_respin_cycle"] = "zombie/fx_bgb_respin_cycle_box_flash_zmb";
}

// Namespace zm_bgb_respin_cycle/zm_bgb_respin_cycle
// Params 7, eflags: 0x0
// Checksum 0x2e6a57f2, Offset: 0x1e8
// Size: 0x9c
function function_74ecbbd7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect["zm_bgb_respin_cycle"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
}

