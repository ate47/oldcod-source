#using scripts\core_common\callbacks_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;

#namespace wz_russia;

// Namespace wz_russia/level_init
// Params 1, eflags: 0x40
// Checksum 0x4de9659d, Offset: 0x88
// Size: 0x114
function event_handler[level_init] main(*eventstruct) {
    setsaveddvar(#"enable_global_wind", 1);
    setsaveddvar(#"wind_global_vector", "88 0 0");
    setsaveddvar(#"wind_global_low_altitude", 0);
    setsaveddvar(#"wind_global_hi_altitude", 10000);
    setsaveddvar(#"wind_global_low_strength_percent", 100);
    callback::on_gameplay_started(&on_gameplay_started);
    load::main();
    util::waitforclient(0);
}

// Namespace wz_russia/wz_russia
// Params 1, eflags: 0x1 linked
// Checksum 0x933f1e32, Offset: 0x1a8
// Size: 0x34
function on_gameplay_started(*localclientnum) {
    waitframe(1);
    util::function_8eb5d4b0(3500, 2.5);
}

