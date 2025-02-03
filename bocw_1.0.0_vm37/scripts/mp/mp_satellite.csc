#using scripts\core_common\callbacks_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;

#namespace mp_satellite;

// Namespace mp_satellite/level_init
// Params 1, eflags: 0x40
// Checksum 0x322437a0, Offset: 0x98
// Size: 0x214
function event_handler[level_init] main(*eventstruct) {
    function_11e3e877(#"surface_enter", #"hash_591f9167b6a7ea8b");
    function_11e3e877(#"hash_6be5853fe57d01b0", #"hash_1f2ced241c9e45bb");
    function_11e3e877(#"hash_6251d9bc015e4542", #"hash_4e8bc503c06e62e3");
    function_11e3e877(#"hash_6a2ccf46147cb7d8", #"hash_eb2febf62337433");
    setdvar(#"hash_59cffccc9729732f", -70);
    setsaveddvar(#"enable_global_wind", 1);
    setsaveddvar(#"wind_global_vector", "88 0 0");
    setsaveddvar(#"wind_global_low_altitude", 0);
    setsaveddvar(#"wind_global_hi_altitude", 10000);
    setsaveddvar(#"wind_global_low_strength_percent", 100);
    callback::on_gameplay_started(&on_gameplay_started);
    load::main();
    level thread function_e5a1065e();
    util::waitforclient(0);
}

// Namespace mp_satellite/mp_satellite
// Params 1, eflags: 0x0
// Checksum 0x9759190a, Offset: 0x2b8
// Size: 0x64
function on_gameplay_started(*localclientnum) {
    waitframe(1);
    util::function_8eb5d4b0(500, 2);
    level notify(#"hash_6ce45f8471d15231");
    level thread scene::play(#"hash_5657eeda4a6d163f");
}

// Namespace mp_satellite/mp_satellite
// Params 0, eflags: 0x0
// Checksum 0x7c4fc2d3, Offset: 0x328
// Size: 0x174
function function_e5a1065e() {
    level endon(#"hash_6ce45f8471d15231");
    while (true) {
        level waittill(#"hash_67b3195af66ed4eb");
        foreach (player in getlocalplayers()) {
            player postfx::playpostfxbundle(#"hash_4a3eee8916342bd9");
        }
        level waittill(#"hash_240db290be3c7f0f");
        foreach (player in getlocalplayers()) {
            player postfx::exitpostfxbundle(#"hash_4a3eee8916342bd9");
        }
    }
}

