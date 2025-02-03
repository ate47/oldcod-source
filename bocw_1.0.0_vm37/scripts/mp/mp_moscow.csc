#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;

#namespace mp_moscow;

// Namespace mp_moscow/level_init
// Params 1, eflags: 0x40
// Checksum 0xd57ba71a, Offset: 0x90
// Size: 0x13c
function event_handler[level_init] main(*eventstruct) {
    setdvar(#"hash_59cffccc9729732f", -70);
    setsaveddvar(#"enable_global_wind", 1);
    setsaveddvar(#"wind_global_vector", "88 0 0");
    setsaveddvar(#"wind_global_low_altitude", 0);
    setsaveddvar(#"wind_global_hi_altitude", 10000);
    setsaveddvar(#"wind_global_low_strength_percent", 100);
    callback::on_gameplay_started(&on_gameplay_started);
    load::main();
    util::waitforclient(0);
}

// Namespace mp_moscow/mp_moscow
// Params 1, eflags: 0x0
// Checksum 0x81a828aa, Offset: 0x1d8
// Size: 0x2c
function on_gameplay_started(*localclientnum) {
    waitframe(1);
    util::function_8eb5d4b0(700, 1.5);
}

