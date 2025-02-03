#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace perks;

// Namespace perks/perks
// Params 0, eflags: 0x6
// Checksum 0x657be4c0, Offset: 0xd8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"perks_shared", &preinit, undefined, undefined, undefined);
}

// Namespace perks/perks
// Params 0, eflags: 0x4
// Checksum 0x6aed9b01, Offset: 0x120
// Size: 0x114
function private preinit() {
    clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.tactical", #"hud_items", [#"hash_2f126bd99a74de8b", #"equipment", #"tactical"], 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.lethal", #"hud_items", [#"hash_2f126bd99a74de8b", #"equipment", #"lethal"], 1, 5, "float", undefined, 0, 0);
}

