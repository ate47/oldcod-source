#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_slums2_fx;
#using scripts\mp\mp_slums2_sound;
#using scripts\mp_common\load;

#namespace mp_slums2;

// Namespace mp_slums2/level_init
// Params 1, eflags: 0x40
// Checksum 0xd90f2abf, Offset: 0x98
// Size: 0x14c
function event_handler[level_init] main(eventstruct) {
    setsaveddvar(#"enable_global_wind", 1);
    setsaveddvar(#"wind_global_vector", "88 0 0");
    setsaveddvar(#"wind_global_low_altitude", 0);
    setsaveddvar(#"wind_global_hi_altitude", 10000);
    setsaveddvar(#"wind_global_low_strength_percent", 100);
    level.draftxcam = #"ui_cam_draft_common";
    level.var_a49d0b27 = #"hash_12263e5d70551bf9";
    mp_slums2_fx::main();
    mp_slums2_sound::main();
    load::main();
    util::waitforclient(0);
}

