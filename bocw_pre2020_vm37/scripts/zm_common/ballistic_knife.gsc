#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\weapons\ballistic_knife;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_player;

#namespace ballistic_knife;

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x6
// Checksum 0x393c412d, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"ballistic_knife", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x4
// Checksum 0x3f429e57, Offset: 0x100
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

