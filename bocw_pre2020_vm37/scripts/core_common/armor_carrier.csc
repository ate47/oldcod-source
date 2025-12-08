#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace armor_carrier;

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x6
// Checksum 0x8b399ea4, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"armor_carrier", &preinit, undefined, undefined, undefined );
}

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x4
// Checksum 0xc15994d1, Offset: 0xe0
// Size: 0x54
function private preinit()
{
    clientfield::register_clientuimodel( "hudItems.armorPlateCount", #"hud_items", #"armorplatecount", 1, 3, "int", undefined, 0, 0 );
}

