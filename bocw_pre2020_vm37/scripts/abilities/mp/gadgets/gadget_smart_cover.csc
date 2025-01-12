#using scripts\abilities\ability_player;
#using scripts\abilities\ability_power;
#using scripts\abilities\ability_util;
#using scripts\abilities\gadgets\gadget_smart_cover;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace smart_cover;

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x6
// Checksum 0x175ca1a8, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gadget_smart_cover", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x5 linked
// Checksum 0x3f429e57, Offset: 0xf0
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

