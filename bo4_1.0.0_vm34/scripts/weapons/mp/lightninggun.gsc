#using scripts\core_common\system_shared;
#using scripts\weapons\lightninggun;

#namespace lightninggun;

// Namespace lightninggun/lightninggun
// Params 0, eflags: 0x2
// Checksum 0xc239400b, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"lightninggun", &__init__, undefined, undefined);
}

// Namespace lightninggun/lightninggun
// Params 0, eflags: 0x0
// Checksum 0x9eabea75, Offset: 0xc0
// Size: 0x14
function __init__() {
    init_shared();
}

