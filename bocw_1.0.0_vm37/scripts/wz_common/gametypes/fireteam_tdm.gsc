#using script_335d0650ed05d36d;
#using script_b9a55edd207e4ca;
#using scripts\core_common\death_circle;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace fireteam_tdm;

// Namespace fireteam_tdm/fireteam_tdm
// Params 0, eflags: 0x6
// Checksum 0x2e719452, Offset: 0x98
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_112a74f076cda31", &function_62730899, undefined, undefined, #"territory");
}

// Namespace fireteam_tdm/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xe8aeb520, Offset: 0xe8
// Size: 0x44
function event_handler[gametype_init] main(*eventstruct) {
    namespace_2938acdc::init();
    spawning::addsupportedspawnpointtype("tdm");
    level.var_61d4f517 = 1;
}

// Namespace fireteam_tdm/fireteam_tdm
// Params 0, eflags: 0x4
// Checksum 0xdf9b5647, Offset: 0x138
// Size: 0x4c
function private function_62730899() {
    if (isdefined(level.territory) && level.territory.name != "zoo") {
        namespace_2938acdc::function_4212369d();
    }
}

