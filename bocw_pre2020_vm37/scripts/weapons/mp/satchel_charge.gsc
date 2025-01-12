#using scripts\core_common\system_shared;
#using scripts\weapons\satchel_charge;

#namespace satchel_charge;

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x6
// Checksum 0xd9879d63, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"satchel_charge", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x5 linked
// Checksum 0x3f429e57, Offset: 0xb8
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

