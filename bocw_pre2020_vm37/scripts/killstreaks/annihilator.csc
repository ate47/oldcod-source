#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace annihilator;

// Namespace annihilator/annihilator
// Params 0, eflags: 0x6
// Checksum 0x5523eef7, Offset: 0x78
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"annihilator", &__init__, undefined, undefined, #"killstreaks");
}

// Namespace annihilator/annihilator
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xc8
// Size: 0x4
function __init__() {
    
}

