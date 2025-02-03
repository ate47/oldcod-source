#using scripts\core_common\system_shared;
#using scripts\weapons\satchel_charge;

#namespace satchel_charge;

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x6
// Checksum 0x10bf77ad, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"satchel_charge", &preinit, undefined, undefined, undefined);
}

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x4
// Checksum 0xa0c3f4d0, Offset: 0xb8
// Size: 0x14
function private preinit() {
    init_shared();
}

