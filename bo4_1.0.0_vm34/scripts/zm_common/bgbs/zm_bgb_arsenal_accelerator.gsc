#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_arsenal_accelerator;

// Namespace zm_bgb_arsenal_accelerator/zm_bgb_arsenal_accelerator
// Params 0, eflags: 0x2
// Checksum 0xdc36a80e, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_arsenal_accelerator", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_arsenal_accelerator/zm_bgb_arsenal_accelerator
// Params 0, eflags: 0x0
// Checksum 0xec6baa00, Offset: 0xd0
// Size: 0x74
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_arsenal_accelerator", "time", 300, &enable, &disable, undefined);
}

// Namespace zm_bgb_arsenal_accelerator/zm_bgb_arsenal_accelerator
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x150
// Size: 0x4
function enable() {
    
}

// Namespace zm_bgb_arsenal_accelerator/zm_bgb_arsenal_accelerator
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function disable() {
    
}

