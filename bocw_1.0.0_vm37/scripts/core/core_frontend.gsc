#using scripts\core\core_frontend_fx;
#using scripts\core\core_frontend_sound;

#namespace core_frontend;

// Namespace core_frontend/level_init
// Params 1, eflags: 0x40
// Checksum 0x6a5a7c96, Offset: 0x70
// Size: 0x6a
function event_handler[level_init] main(*eventstruct) {
    precache();
    setmapcenter((0, 0, 0));
    core_frontend_fx::main();
    core_frontend_sound::main();
    world.playerroles = undefined;
    world.var_8c7b4214 = undefined;
}

// Namespace core_frontend/core_frontend
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xe8
// Size: 0x4
function precache() {
    
}

