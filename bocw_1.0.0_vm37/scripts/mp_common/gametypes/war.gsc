#using script_4acb48c9cb82bb51;

#namespace war;

// Namespace war/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x403e3c62, Offset: 0x68
// Size: 0x34
function event_handler[gametype_init] main(*eventstruct) {
    namespace_d03f485e::function_dc5b7ee6();
    level.onstartgametype = &onstartgametype;
}

// Namespace war/war
// Params 0, eflags: 0x0
// Checksum 0x4e93c17e, Offset: 0xa8
// Size: 0x14
function onstartgametype() {
    namespace_d03f485e::function_1804ad1c();
}

