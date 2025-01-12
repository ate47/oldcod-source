#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace weaponobjects;

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x6
// Checksum 0x53ee9cea, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"weaponobjects", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x5 linked
// Checksum 0x3f429e57, Offset: 0xe0
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

