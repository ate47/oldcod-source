#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_explosive_damage;

// Namespace status_effect_explosive_damage/status_effect_explosive_damage
// Params 0, eflags: 0x6
// Checksum 0x3204215c, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effect_explosive_damage", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace status_effect_explosive_damage/status_effect_explosive_damage
// Params 0, eflags: 0x5 linked
// Checksum 0xd2a0cff6, Offset: 0xe0
// Size: 0x2c
function private function_70a657d8() {
    status_effect::function_6f4eaf88(getstatuseffect("explosive_damage"));
}

