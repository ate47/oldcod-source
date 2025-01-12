#using scripts/core/core_frontend_fx;
#using scripts/core/core_frontend_sound;
#using scripts/core_common/multi_extracam;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;

#namespace core_frontend;

// Namespace core_frontend/level_init
// Params 1, eflags: 0x40
// Checksum 0x762f9a9c, Offset: 0x1a0
// Size: 0x44
function event_handler[level_init] main(eventstruct) {
    core_frontend_fx::main();
    core_frontend_sound::main();
    util::waitforclient(0);
}

