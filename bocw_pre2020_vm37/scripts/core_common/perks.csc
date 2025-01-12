#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace perks;

// Namespace perks/perks
// Params 0, eflags: 0x6
// Checksum 0xac430e0e, Offset: 0xd8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_2af3fdb587243686", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace perks/perks
// Params 0, eflags: 0x5 linked
// Checksum 0xe8523c79, Offset: 0x120
// Size: 0x114
function private function_70a657d8() {
    clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.tactical", #"hash_6f4b11a0bee9b73d", [#"hash_2f126bd99a74de8b", #"equipment", #"tactical"], 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.lethal", #"hash_6f4b11a0bee9b73d", [#"hash_2f126bd99a74de8b", #"equipment", #"lethal"], 1, 5, "float", undefined, 0, 0);
}

