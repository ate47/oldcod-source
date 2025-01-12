#using scripts/core_common/compass;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp/mp_ethiopia_fx;
#using scripts/mp/mp_ethiopia_sound;
#using scripts/mp_common/load;
#using scripts/mp_common/util;

#namespace mp_ethiopia;

// Namespace mp_ethiopia/Level_Init
// Params 1, eflags: 0x40
// Checksum 0xaf2ce15d, Offset: 0x208
// Size: 0x414
function event_handler[Level_Init] main(eventstruct) {
    precache();
    mp_ethiopia_fx::main();
    mp_ethiopia_sound::main();
    level.add_raps_drop_locations = &add_raps_drop_locations;
    load::main();
    compass::setupminimap("compass_map_mp_ethiopia");
    spawncollision("collision_clip_256x256x256", "collider", (-129.888, -1884.61, 661.629), (0, -7, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-129.888, -1875.59, 827.62), (0, -7, 0));
    spawncollision("collision_clip_256x256x256", "collider", (193, -1635, 611.5), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (193, -1635, 733.5), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (193, -1635, 857), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (193, -1635, 979), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 611.5), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 733.5), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 857), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 979), (0, 0, 0));
    spawncollision("collision_nosight_wall_512x512x10", "collider", (1953.84, -762.342, 16), (0, 12, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-1040, -1338.5, 73.5), (4, 10, 0));
    setdvar("bot_maxmantleheight", 135);
    level.cleandepositpoints = array((301.869, 278.255, -218.677), (241.91, -1226.31, 37.6831), (1353.01, -116.183, -66.9346), (-294.319, -2288.04, 10.5979), (-114.583, -1179.11, -207.36));
    level spawnkilltrigger();
}

// Namespace mp_ethiopia/mp_ethiopia
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x628
// Size: 0x4
function precache() {
    
}

// Namespace mp_ethiopia/mp_ethiopia
// Params 1, eflags: 0x0
// Checksum 0x48dc64bf, Offset: 0x638
// Size: 0x1ac
function add_raps_drop_locations(&var_ef2e1e06) {
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (350, 650, -222);
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (-100, 420, -223);
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (2900, -140, -23);
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (-690, -850, 26);
}

// Namespace mp_ethiopia/mp_ethiopia
// Params 0, eflags: 0x0
// Checksum 0x9573a789, Offset: 0x7f0
// Size: 0x5c
function spawnkilltrigger() {
    trigger = spawn("trigger_radius", (-993.5, -1327.5, 0.5), 0, 50, 300);
    trigger thread watchkilltrigger();
}

// Namespace mp_ethiopia/mp_ethiopia
// Params 0, eflags: 0x0
// Checksum 0x37ed4f5, Offset: 0x858
// Size: 0x98
function watchkilltrigger() {
    level endon(#"game_ended");
    trigger = self;
    while (true) {
        waitresult = trigger waittill("trigger");
        waitresult.activator dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
    }
}

