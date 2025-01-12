#using scripts/core/core_frontend_fx;
#using scripts/core/core_frontend_sound;
#using scripts/core_common/math_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace core_frontend;

// Namespace core_frontend/Level_Init
// Params 1, eflags: 0x40
// Checksum 0x9253402c, Offset: 0x160
// Size: 0x74
function event_handler[Level_Init] main(eventstruct) {
    precache();
    setmapcenter((0, 0, 0));
    core_frontend_fx::main();
    core_frontend_sound::main();
    setdvar("compassmaxrange", "2100");
}

// Namespace core_frontend/core_frontend
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1e0
// Size: 0x4
function precache() {
    
}

