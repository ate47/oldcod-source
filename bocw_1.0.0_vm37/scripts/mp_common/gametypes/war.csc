#using script_6b50f4c9dd53e2dd;

#namespace war;

// Namespace war/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x88f7c836, Offset: 0x68
// Size: 0x24
function event_handler[gametype_init] main(eventstruct) {
    namespace_d03f485e::init_shared(eventstruct);
}

