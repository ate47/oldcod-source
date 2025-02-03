#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace status_effect_explosive_damage;

// Namespace status_effect_explosive_damage/status_effect_explosive_damage
// Params 0, eflags: 0x6
// Checksum 0x3880eb17, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effect_explosive_damage", &preinit, undefined, undefined, undefined);
}

// Namespace status_effect_explosive_damage/status_effect_explosive_damage
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xb8
// Size: 0x4
function private preinit() {
    
}

