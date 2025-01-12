#using scripts\abilities\ability_gadgets;
#using scripts\abilities\ability_player;
#using scripts\abilities\ability_power;
#using scripts\abilities\ability_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace abilities;

// Namespace abilities/abilities
// Params 0, eflags: 0x6
// Checksum 0x7ad85ab7, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"abilities", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace abilities/abilities
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0xf8
// Size: 0x4
function private function_70a657d8() {
    
}

