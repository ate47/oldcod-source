#using script_6b221588ece2c4aa;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\mp_common\util;
#using scripts\weapons\weaponobjects;

#namespace weaponobjects;

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x6
// Checksum 0x53ee9cea, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"weaponobjects", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x5 linked
// Checksum 0x4aee51c5, Offset: 0xf8
// Size: 0x34
function private function_70a657d8() {
    init_shared();
    callback::on_start_gametype(&start_gametype);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x1 linked
// Checksum 0x544533df, Offset: 0x138
// Size: 0x44
function start_gametype() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x188
// Size: 0x4
function on_player_spawned() {
    
}

