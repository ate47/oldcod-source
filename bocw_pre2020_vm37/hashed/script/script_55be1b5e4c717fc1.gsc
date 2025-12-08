#using scripts\core_common\system_shared;
#using scripts\cp_common\gamedifficulty;

#namespace gadget_health_regen;

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x6
// Checksum 0x180a38d0, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_282f48d36d893e20", &preinit, undefined, undefined, undefined );
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x4
// Checksum 0x6d837379, Offset: 0xb8
// Size: 0x34
function private preinit()
{
    level.var_f71267dc = &function_71343595;
    level.var_11e731d7 = &function_3211c56a;
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2
// Checksum 0x64aa8ff0, Offset: 0xf8
// Size: 0x42
function function_71343595( *var_b16fafc9, *weapon )
{
    return int( gamedifficulty::function_b5b7d60e() * 1000 );
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1
// Checksum 0x4a26c4e9, Offset: 0x148
// Size: 0x3a
function function_3211c56a( *var_337562a8 )
{
    return int( gamedifficulty::function_5151f9d0() * 1000 );
}

