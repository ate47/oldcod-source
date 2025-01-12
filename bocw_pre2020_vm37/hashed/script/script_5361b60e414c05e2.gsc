#using script_335d0650ed05d36d;
#using script_69514c4c056c768;
#using script_b9a55edd207e4ca;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace fireteam_elimination;

// Namespace fireteam_elimination/fireteam_elimination
// Params 0, eflags: 0x6
// Checksum 0x827ed18b, Offset: 0xd0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_112a74f076cda31", &function_62730899, undefined, undefined, #"territory");
}

// Namespace fireteam_elimination/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xeafa5aa, Offset: 0x120
// Size: 0x114
function event_handler[gametype_init] main(*eventstruct) {
    namespace_2938acdc::init();
    spawning::addsupportedspawnpointtype("tdm");
    level.var_61d4f517 = 1;
    level.takelivesondeath = 1;
    teamcount = getgametypesetting(#"teamcount");
    for (i = 3; i <= teamcount; i++) {
        clientfield::function_5b7d846d("hudItems.team" + i + ".livesCount", 1, 8, "int");
        clientfield::function_5b7d846d("hudItems.team" + i + ".noRespawnsLeft", 1, 1, "int");
    }
}

// Namespace fireteam_elimination/fireteam_elimination
// Params 0, eflags: 0x4
// Checksum 0x5b6e25f7, Offset: 0x240
// Size: 0x64
function private function_62730899() {
    if (isdefined(level.territory) && level.territory.name != "zoo") {
        level thread namespace_3d2704b3::function_add63876(#"vehicle_t9_mil_ru_tank_t72", 2147483647, 240, 320);
    }
}

