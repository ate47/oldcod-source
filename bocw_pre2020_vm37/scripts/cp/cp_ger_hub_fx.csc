#using script_1cd690a97dfca36e;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_utility;

#namespace cp_ger_hub_fx;

// Namespace cp_ger_hub_fx/cp_ger_hub_fx
// Params 0, eflags: 0x6
// Checksum 0xa9e2f326, Offset: 0xb0
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"cp_ger_hub_fx", &_preload, &function_fa076c68, undefined, undefined );
}

// Namespace cp_ger_hub_fx/cp_ger_hub_fx
// Params 0, eflags: 0x4
// Checksum 0x65e4e564, Offset: 0x108
// Size: 0x34
function private _preload()
{
    if ( !isdefined( level._fx ) )
    {
        level._fx = {};
    }
    
    function_bc948200();
}

// Namespace cp_ger_hub_fx/cp_ger_hub_fx
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x148
// Size: 0x4
function private function_fa076c68()
{
    
}

// Namespace cp_ger_hub_fx/cp_ger_hub_fx
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x158
// Size: 0x4
function private function_bc948200()
{
    
}

