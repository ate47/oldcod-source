#using script_1304295570304027;
#using script_5495f0bb06045dc7;
#using script_b9a55edd207e4ca;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace namespace_cf48051e;

// Namespace namespace_cf48051e/namespace_cf48051e
// Params 0, eflags: 0x6
// Checksum 0xea553c79, Offset: 0x90
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_112a74f076cda31", &function_62730899, undefined, undefined, #"territory");
}

// Namespace namespace_cf48051e/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x1765b568, Offset: 0xe0
// Size: 0x50
function event_handler[gametype_init] main(*eventstruct) {
    namespace_2938acdc::init();
    namespace_5c32f369::init();
    level.onstartgametype = &on_start_game_type;
    level.var_61d4f517 = 0;
}

// Namespace namespace_cf48051e/namespace_cf48051e
// Params 0, eflags: 0x0
// Checksum 0x1ae4207f, Offset: 0x138
// Size: 0x24
function on_start_game_type() {
    namespace_17baa64d::on_start_game_type();
    namespace_5c32f369::onstartgametype();
}

// Namespace namespace_cf48051e/namespace_cf48051e
// Params 0, eflags: 0x4
// Checksum 0x4e03994, Offset: 0x168
// Size: 0x4c
function private function_62730899() {
    if (isdefined(level.territory) && level.territory.name != "zoo") {
        namespace_2938acdc::function_4212369d();
    }
}

