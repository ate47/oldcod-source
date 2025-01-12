#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_anti_entrapment;

// Namespace zm_bgb_anti_entrapment/zm_bgb_anti_entrapment
// Params 0, eflags: 0x2
// Checksum 0x5729c86a, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_bgb_anti_entrapment", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_anti_entrapment/zm_bgb_anti_entrapment
// Params 0, eflags: 0x0
// Checksum 0x8dd036fa, Offset: 0xd0
// Size: 0x74
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_anti_entrapment", "time", 30, &enable, &disable, undefined, undefined);
}

// Namespace zm_bgb_anti_entrapment/zm_bgb_anti_entrapment
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x150
// Size: 0x4
function enable() {
    
}

// Namespace zm_bgb_anti_entrapment/zm_bgb_anti_entrapment
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function disable() {
    
}
