#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace namespace_2ed67032;

// Namespace namespace_2ed67032/namespace_2ed67032
// Params 0, eflags: 0x6
// Checksum 0x8b399ea4, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_7aac5c09cf9461e3", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_2ed67032/namespace_2ed67032
// Params 0, eflags: 0x4
// Checksum 0xc15994d1, Offset: 0xe0
// Size: 0x54
function private function_70a657d8() {
    clientfield::register_clientuimodel("hudItems.armorPlateCount", #"hash_6f4b11a0bee9b73d", #"hash_7c65108f5dcd93ef", 1, 3, "int", undefined, 0, 0);
}

