#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace warmachine;

// Namespace warmachine/warmachine
// Params 0, eflags: 0x6
// Checksum 0x3968693c, Offset: 0x78
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"warmachine", &__init__, undefined, undefined, #"killstreaks");
}

// Namespace warmachine/warmachine
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xc8
// Size: 0x4
function __init__() {
    
}

