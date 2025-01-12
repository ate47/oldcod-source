#using scripts\core_common\system_shared;
#using scripts\weapons\bouncingbetty;

#namespace bouncingbetty;

// Namespace bouncingbetty/zm_weap_bouncingbetty
// Params 0, eflags: 0x6
// Checksum 0x421a607f, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"bouncingbetty", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace bouncingbetty/zm_weap_bouncingbetty
// Params 0, eflags: 0x4
// Checksum 0x3f429e57, Offset: 0xb8
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

