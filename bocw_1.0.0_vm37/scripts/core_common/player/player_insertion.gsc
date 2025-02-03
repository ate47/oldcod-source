#using script_1cc417743d7c262d;
#using script_305d57cf0618009d;
#using script_6e9b46ba8331f1f;
#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot_insertion;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_free_fall;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace player_insertion;

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x6
// Checksum 0x52995e01, Offset: 0x848
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player_insertion", &preinit, undefined, undefined, undefined);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x4
// Checksum 0x7c0aecf9, Offset: 0x890
// Size: 0x4cc
function private preinit() {
    if (level.var_f2814a96 !== 0 && level.var_f2814a96 !== 2) {
        return;
    }
    var_1194a9a5 = struct::get_array("infil_spawn", "targetname");
    /#
        if (var_1194a9a5.size == 0) {
            var_1194a9a5 = struct::get_array("<dev string:x38>", "<dev string:x4a>");
        }
    #/
    level.insertions = [];
    var_3bc28449 = max(isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1, 1);
    assert(var_3bc28449 > 0 && var_3bc28449 <= 2);
    for (index = 0; index < var_3bc28449; index++) {
        insertion = {#index:index, #allowed:1, #spawnpoints:var_1194a9a5, #players:[]};
        level.insertions[level.insertions.size] = insertion;
        callback::on_finalize_initialization(&on_finalize_initialization, insertion);
    }
    level.insertion = level.insertions[0];
    clientfield::register("vehicle", "infiltration_transport", 1, 1, "int");
    clientfield::register("vehicle", "infiltration_landing_gear", 1, 1, "int");
    clientfield::register("toplayer", "infiltration_jump_warning", 1, 1, "int");
    clientfield::register("toplayer", "infiltration_final_warning", 1, 1, "int");
    clientfield::register("toplayer", "inside_infiltration_vehicle", 1, 1, "int");
    clientfield::register("world", "infiltration_compass", 1, 2, "int");
    clientfield::register("scriptmover", "infiltration_ent", 1, 2, "int");
    clientfield::register("scriptmover", "infiltration_plane", 1, 2, "int");
    clientfield::register("scriptmover", "infiltration_camera", 1, 3, "int");
    clientfield::register("scriptmover", "infiltration_jump_point", 1, 2, "int");
    clientfield::register("scriptmover", "infiltration_force_drop_point", 1, 2, "int");
    clientfield::register("toplayer", "heatblurpostfx", 1, 1, "int");
    namespace_b9471dc1::register_clientfields();
    /#
        level thread function_943c98fb(level.insertion);
    #/
    if (!isdefined(level.var_8367fa0f)) {
        level.var_8367fa0f = 2;
    }
    if (!isdefined(level.var_ab0cc070)) {
        level.var_ab0cc070 = 2;
    }
    if (!isdefined(level.var_b28c6a29)) {
        level.var_b28c6a29 = 5;
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x4
// Checksum 0xe130d2c7, Offset: 0xd68
// Size: 0x2fc
function private on_finalize_initialization() {
    if (level.deathcircle.enabled) {
        level flag::wait_till(#"hash_43bac6444a9b65f3");
    }
    level.var_c7f8ccf6 = isdefined(level.var_427d6976.("insertionSpeed")) ? level.var_427d6976.("insertionSpeed") : 100;
    /#
        level.var_c7f8ccf6 = getdvarfloat(#"hash_51db9b26f6097296", level.var_c7f8ccf6);
    #/
    insertion = self;
    assert(isstruct(insertion));
    waitframe(1);
    /#
        if (getdvarint(#"scr_disable_infiltration", 0)) {
            return;
        }
        var_6024133d = getentarray("<dev string:x58>", "<dev string:x4a>");
        if (var_6024133d.size == 0) {
            return;
        }
    #/
    var_3bc28449 = isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1;
    offsetdistance = isdefined(getgametypesetting(#"hash_75a36f7e4a81c93")) ? getgametypesetting(#"hash_75a36f7e4a81c93") : 0;
    if (var_3bc28449 > 0 && insertion.index > 0) {
        var_df4f7099 = level.insertions[0];
        var_df4f7099 flag::wait_till(#"hash_4e5fc66b9144a5c8");
        function_d53a8c5b(insertion, var_df4f7099.fly_over_point, var_df4f7099.var_59526dd5 - 180, offsetdistance);
        return;
    }
    var_7ed8b321 = function_9ed051a4();
    var_684dfce3 = function_da0c552e();
    function_d53a8c5b(insertion, var_7ed8b321, var_684dfce3, offsetdistance);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xada1e650, Offset: 0x1070
// Size: 0x1f4
function function_abd3bc1a(insertion) {
    if (!isalive(self)) {
        return;
    }
    self flag::clear(#"hash_224cb97b8f682317");
    self flag::clear(#"hash_287397edba8966f9");
    self val::set(#"player_insertion", "freezecontrols", 1);
    self val::set(#"player_insertion", "disablegadgets", 1);
    self val::set(#"player_insertion", "show_hud", 0);
    self val::set(#"player_insertion", "show_weapon_hud", 0);
    self clientfield::set_world_uimodel("hudItems.skydiveAltimeterHeight", int(insertion.start_point[2]));
    self clientfield::set_world_uimodel("hudItems.skydiveAltimeterSeaHeight", isdefined(level.var_427d6976.("altimeterSeaHeight")) ? level.var_427d6976.("altimeterSeaHeight") : 0);
    self death_circle::function_b57e3cde(1);
    if (isbot(self)) {
        self bot_insertion::function_9699dc95();
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xa1a26279, Offset: 0x1270
// Size: 0x7c
function function_7a4c1517() {
    self val::reset(#"player_insertion", "freezecontrols");
    self val::reset(#"player_insertion", "disablegadgets");
    self val::reset(#"player_insertion", "show_hud");
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x5668361, Offset: 0x12f8
// Size: 0x64
function function_b9a53f50() {
    if (!self function_8b1a219a()) {
        self val::set(#"player_insertion", "freezecontrols_allowlook", 1);
    }
    self disableweapons();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x1f9c4928, Offset: 0x1368
// Size: 0x5c
function function_3354a054() {
    if (!self function_8b1a219a()) {
        self val::reset(#"player_insertion", "freezecontrols_allowlook");
    }
    self enableweapons();
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0x904f683e, Offset: 0x13d0
// Size: 0x170
function private function_bc824660(insertion) {
    assert(isstruct(insertion));
    foreach (heli in insertion.var_41091905) {
        if (isdefined(heli)) {
            heli setspeedimmediate(level.var_c7f8ccf6 + 20);
        }
    }
    foreach (heli in insertion.var_dfaba736) {
        if (isdefined(heli)) {
            heli setspeedimmediate(level.var_c7f8ccf6 + 20);
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x3b7b05d4, Offset: 0x1548
// Size: 0xd8
function function_948ac812(insertion) {
    assert(isstruct(insertion));
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        player function_abd3bc1a(insertion);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x60c577f, Offset: 0x1628
// Size: 0x31c
function function_8dcd8623() {
    assert(isarray(level.insertions));
    /#
        if (getdvarint(#"scr_disable_infiltration", 0)) {
            level.var_bde3d03 = undefined;
            level flag::set(#"hash_60fcdd11812a0134");
            level flag::set(#"insertion_teleport_completed");
            level flag::set(#"insertion_begin_completed");
            return;
        }
        while (getplayers().size == 0) {
            wait 0.5;
        }
    #/
    level flag::set(#"spawning_allowed");
    level flag::clear(#"hash_60fcdd11812a0134");
    level flag::clear(#"insertion_teleport_completed");
    level flag::clear(#"insertion_begin_completed");
    for (index = 0; index < level.insertions.size; index++) {
        insertion = level.insertions[index];
        if (!is_true(insertion.allowed)) {
            return;
        }
        var_7eb8f61a = isdefined(getgametypesetting(#"wzplayerinsertiontypeindex")) ? getgametypesetting(#"wzplayerinsertiontypeindex") : 0;
        switch (var_7eb8f61a) {
        case 0:
            level thread function_82c73974(insertion);
            break;
        case 1:
            namespace_b9471dc1::function_51c5f95f(insertion);
            break;
        case 2:
            function_35742117(insertion);
            break;
        case 3:
            level thread function_51b480e0(insertion);
            break;
        }
    }
    level flag::wait_till(#"insertion_begin_completed");
}

// Namespace player_insertion/player_insertion
// Params 3, eflags: 0x0
// Checksum 0x37bdf366, Offset: 0x1950
// Size: 0x254
function function_daaba5b0(insertion, var_3e6673cb, var_cf46aa72) {
    function_a21d9dc(insertion);
    foreach (player in insertion.players) {
        player function_8b8a321a(0);
    }
    fadeouttime = level.var_8367fa0f;
    blacktime = level.var_ab0cc070;
    fadeintime = level.var_b28c6a29;
    insertion thread function_1b105d5b(insertion, fadeouttime, blacktime, fadeintime, 1);
    wait fadeouttime + 0.1;
    level callback::add_callback(#"hash_774be40ec06d5212", &function_bcde1e07, insertion);
    insertion thread globallogic_audio::function_85818e24("matchstart");
    insertion thread function_a4deb676();
    insertion flag::set(#"hash_122f326d72f4c884");
    level [[ var_3e6673cb ]](insertion, var_cf46aa72);
    function_dd34168c(insertion, #"insertion_teleport_completed");
    var_1cd8bd13 = blacktime + fadeintime + 0.5;
    insertion flag::wait_till_timeout(var_1cd8bd13, #"insertion_presentation_completed");
    function_dd34168c(insertion, #"insertion_begin_completed");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x56df6180, Offset: 0x1bb0
// Size: 0x5c
function function_82c73974(insertion) {
    assert(isstruct(insertion));
    function_daaba5b0(insertion, &function_e59d879f, 1);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x4cc33ab7, Offset: 0x1c18
// Size: 0x54
function function_51b480e0(insertion) {
    assert(isstruct(insertion));
    function_daaba5b0(insertion, &function_7341cc88, 0);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x870b62fe, Offset: 0x1c78
// Size: 0x470
function function_35742117(insertion) {
    assert(isstruct(insertion));
    function_a21d9dc(insertion);
    fadeouttime = level.var_8367fa0f;
    foreach (player in insertion.players) {
        player val::set(#"player_insertion", "freezecontrols", 1);
        player val::set(#"player_insertion", "disablegadgets", 1);
    }
    insertion thread function_1b105d5b(insertion, fadeouttime, 5, 5, 0);
    wait fadeouttime + 0.1;
    level thread function_a4deb676();
    insertion flag::set(#"hash_122f326d72f4c884");
    function_dd34168c(insertion, #"hash_60fcdd11812a0134");
    function_dd34168c(insertion, #"insertion_teleport_completed");
    level callback::callback(#"hash_774be40ec06d5212");
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (!isalive(player)) {
            continue;
        }
        player setorigin(player.resurrect_origin);
        player setplayerangles(player.resurrect_angles);
        level callback::callback(#"hash_74b19f5972b0ee52", {#player:player});
    }
    function_dd34168c(insertion, #"insertion_begin_completed");
    wait 5 + fadeouttime / 3;
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (!isalive(player)) {
            continue;
        }
        player val::reset(#"player_insertion", "freezecontrols");
        player val::reset(#"player_insertion", "disablegadgets");
        player clientfield::set_to_player("realtime_multiplay", 1);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xfa8cb453, Offset: 0x20f0
// Size: 0x34
function function_bcde1e07() {
    insertion = self;
    callback::remove_on_spawned(&function_80c60f66, insertion);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0x776b3b44, Offset: 0x2130
// Size: 0x194
function private function_c62b5591(insertion) {
    assert(isstruct(insertion));
    if (!isdefined(insertion.cameraent)) {
        insertion.cameraent = [];
    }
    var_163b0077 = 0;
    foreach (i, plane in insertion.var_41091905) {
        if (self islinkedto(plane)) {
            if (isdefined(insertion.cameraent[i])) {
                insertion.cameraent[i] setvisibletoplayer(self);
            }
            var_163b0077 = 1;
            break;
        }
    }
    if (!var_163b0077 && insertion.var_41091905.size > 0) {
        if (isdefined(insertion.cameraent[insertion.var_41091905.size])) {
            insertion.cameraent[insertion.var_41091905.size] setvisibletoplayer(self);
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0xe6702135, Offset: 0x22d0
// Size: 0x60
function function_57fe9b21(*insertion, origin) {
    camera = spawn("script_model", origin);
    camera.targetname = "insertion_camera";
    camera setinvisibletoall();
    return camera;
}

// Namespace player_insertion/player_insertion
// Params 4, eflags: 0x0
// Checksum 0xcb66f07b, Offset: 0x2338
// Size: 0xd00
function function_ca5b6591(insertion, *startorigin, endorigin, var_872f085f) {
    assert(isstruct(startorigin));
    self notify("65b306160c991ffd");
    self endon("65b306160c991ffd");
    startorigin.cameraent = [];
    flightdirection = anglestoforward(var_872f085f);
    var_1978c281 = isdefined(level.var_427d6976.("insertionCameraFollowPitch")) ? level.var_427d6976.("insertionCameraFollowPitch") : 35;
    var_8b5e86f4 = (var_1978c281, var_872f085f[1], var_872f085f[2]);
    var_65537f6d = anglestoforward(var_8b5e86f4);
    follow_offset = isdefined(level.var_427d6976.("insertionCameraFollowDistance")) ? level.var_427d6976.("insertionCameraFollowDistance") : 1600;
    camera_offset = follow_offset * -1 * var_65537f6d + flightdirection * level.var_c7f8ccf6 * 17.6 * 3;
    for (index = 0; index <= startorigin.var_41091905.size; index++) {
        plane = startorigin.var_41091905[index];
        if (!isdefined(plane)) {
            plane = startorigin.var_41091905[0];
        }
        if (isdefined(startorigin.cameraent[index])) {
            startorigin.cameraent[index] delete();
        }
        var_c5f933e4 = plane.origin + vectorscale(flightdirection, -400) + (0, 0, 225);
        startorigin.cameraent[index] = function_57fe9b21(startorigin, var_c5f933e4);
        startorigin.cameraent[index].angles = var_8b5e86f4;
        startorigin.cameraent[index] clientfield::set("infiltration_camera", function_1e4302d0(1, startorigin.index));
    }
    function_a5fd9aa8(startorigin);
    foreach (player in startorigin.players) {
        player function_c62b5591(startorigin);
        player show_postfx();
    }
    foreach (player in startorigin.otherplayers) {
        player function_c62b5591(startorigin);
    }
    if (getgametypesetting(#"wzplayerinsertiontypeindex") == 3) {
        var_5960815d = 9;
    } else {
        var_5960815d = 12.95;
    }
    var_1b6a3e44 = [];
    for (index = 0; index <= startorigin.var_41091905.size; index++) {
        plane = startorigin.var_41091905[index];
        if (!isdefined(plane)) {
            plane = startorigin.var_41091905[0];
        }
        var_f945990b = plane.origin + vectorscale(flightdirection, -400) + (0, 0, 225);
        targetpos = var_f945990b + flightdirection * level.var_c7f8ccf6 * 17.6 * var_5960815d;
        if (isdefined(startorigin.cameraent[index])) {
            startorigin.cameraent[index] moveto(targetpos, var_5960815d);
            startorigin.cameraent[index] rotateto((var_872f085f[0] + var_1978c281, var_872f085f[1], var_872f085f[2]), var_5960815d, 1, 1);
        }
    }
    function_a5fd9aa8(startorigin);
    if (getgametypesetting(#"wzplayerinsertiontypeindex") != 3) {
        wait 3.75;
        foreach (player in startorigin.players) {
            player playrumbleonentity(#"infiltration_rumble");
        }
        wait 1;
        function_a5fd9aa8(startorigin);
        foreach (player in startorigin.players) {
            player playrumbleonentity(#"hash_233b436a07cd091a");
        }
        wait 0.2;
        function_a5fd9aa8(startorigin);
        foreach (player in startorigin.players) {
            player playrumbleonentity(#"infiltration_rumble");
        }
        wait 2;
        function_a5fd9aa8(startorigin);
        foreach (player in startorigin.players) {
            if (!isdefined(player)) {
                continue;
            }
            player playrumbleonentity(#"hash_62ba49f452a20378");
        }
        wait 2;
    }
    startorigin callback::callback(#"hash_1634199a59f10727");
    if (getgametypesetting(#"wzplayerinsertiontypeindex") == 3) {
        wait 5;
    }
    wait 4;
    for (index = 0; index <= startorigin.var_41091905.size; index++) {
        finaltargetpos = endorigin + vectorscale(flightdirection, -400) + (0, 0, 225);
        timetotarget = distance(finaltargetpos, targetpos) / level.var_c7f8ccf6 * 17.6;
        if (isdefined(startorigin.cameraent[index])) {
            startorigin.cameraent[index] moveto(finaltargetpos, timetotarget);
        }
    }
    startorigin flag::wait_till_timeout(0.05, #"insertion_presentation_completed");
    function_a5fd9aa8(startorigin);
    foreach (player in startorigin.players) {
        if (!isdefined(player)) {
            continue;
        }
        player setplayerangles((var_872f085f[0] + var_1978c281, var_872f085f[1], var_872f085f[2]));
    }
    waitframe(2);
    for (index = 0; index <= startorigin.var_41091905.size; index++) {
        if (isdefined(startorigin.cameraent[index])) {
            startorigin.cameraent[index] clientfield::set("infiltration_plane", function_1e4302d0(1, startorigin.index));
        }
    }
    for (index = 0; index < startorigin.var_41091905.size; index++) {
        if (isdefined(startorigin.cameraent[index])) {
            startorigin.cameraent[index] clientfield::set("infiltration_camera", function_1e4302d0(2, startorigin.index));
        }
    }
    startorigin thread function_bc824660(startorigin);
    for (index = 0; index <= startorigin.var_41091905.size; index++) {
        if (isdefined(startorigin.cameraent[index])) {
            finaltargetpos = endorigin + vectorscale(flightdirection, -400) + (0, 0, 225);
            timetotarget = distance(finaltargetpos, targetpos) / (level.var_c7f8ccf6 + 20) * 17.6;
            startorigin.cameraent[index] moveto(finaltargetpos, timetotarget);
        }
    }
    function_a5fd9aa8(startorigin);
    foreach (player in startorigin.players) {
        if (!isalive(player)) {
            continue;
        }
        player function_7a4c1517();
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xcce0dc4f, Offset: 0x3040
// Size: 0x134
function function_77132caf() {
    self unlink();
    self setstance("stand");
    self function_4feecc32();
    center = death_circle::function_b980b4ca();
    radius = death_circle::function_f8dae197() * 0.85;
    if (radius == 0) {
        radius = 500;
    }
    spawn_point = rotatepoint((radius, 0, 0), (0, randomint(360), 0));
    self setorigin(center + spawn_point + (0, 0, 30000));
    self start_freefall((0, 0, 0), 0);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x7f609565, Offset: 0x3180
// Size: 0xb0
function function_c4f5c468(insertion) {
    assert(isstruct(insertion));
    teammask = getteammask(self.team);
    for (teamindex = 0; teammask > 1; teamindex++) {
        teammask >>= 1;
    }
    planeindex = teamindex % insertion.var_41091905.size;
    return insertion.var_41091905[planeindex];
}

// Namespace player_insertion/player_insertion
// Params 3, eflags: 0x0
// Checksum 0xe6516f2d, Offset: 0x3238
// Size: 0x39c
function function_f795bf83(insertion, vehicle, yaw) {
    assert(isstruct(insertion));
    if (!isdefined(self) || !isentity(self)) {
        return;
    }
    self endon(#"disconnect");
    if (!isdefined(vehicle)) {
        self function_77132caf();
        return;
    }
    self notify(#"insertion_starting");
    if (!isdefined(insertion.passengercount)) {
        insertion.passengercount = 0;
    }
    insertion.passengercount++;
    self stopanimscripted();
    self unlink();
    self setstance("stand");
    self function_648c1f6(vehicle, undefined, 0, 180, 180, 85, 85);
    self gadget_health_regen::function_7993d50e();
    self.health = self.spawnhealth;
    self cameraactivate(1);
    self setclientthirdperson(1);
    self setplayerangles((0, yaw, 0));
    self dontinterpolate();
    self ghost();
    self notsolid();
    self.var_df1a9210 = util::spawn_player_clone(self);
    self.var_df1a9210 ghost();
    self.var_df1a9210 setinvisibletoall();
    self.var_df1a9210 showtoplayer(self);
    self.var_df1a9210 notsolid();
    self.var_df1a9210 thread function_247d349b(self);
    self.var_df1a9210 thread animation::play(#"hash_44cba2d3b8774422", vehicle, "tag_player_spawn");
    self thread status_effect::function_6519f95f();
    self val::set(#"player_insertion", "disable_oob", 1);
    self clientfield::set_to_player("inside_infiltration_vehicle", 1);
    self clientfield::set_player_uimodel("hudItems.showReinsertionPassengerCount", 0);
    level thread function_2e54d73e(insertion, self, vehicle);
    self thread function_5b3ac9f2(vehicle);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xdb40f926, Offset: 0x35e0
// Size: 0x4c
function function_247d349b(player) {
    self endon(#"death");
    player waittill(#"death");
    self delete();
}

/#

    // Namespace player_insertion/player_insertion
    // Params 3, eflags: 0x4
    // Checksum 0xe3d91241, Offset: 0x3638
    // Size: 0x2ca
    function private function_7d880672(original_origin, var_9f8395cb, refly) {
        self notify("<dev string:x66>");
        self endon("<dev string:x66>");
        self endon(#"disconnect");
        origin = self.origin;
        origin = (original_origin[0], original_origin[1], function_70dd0500());
        self setorigin(origin);
        self dontinterpolate();
        var_cc56f8da = 0;
        var_cc56f8da = getdvarint(#"hash_380d8ae5bfc8f45b", 1);
        switch (var_cc56f8da) {
        case 0:
        default:
            var_59526dd5 = 0;
            break;
        case 1:
            var_59526dd5 = var_9f8395cb;
            break;
        case 2:
            var_59526dd5 = randomint(360);
            break;
        }
        var_872f085f = (0, var_59526dd5, 0);
        self setplayerangles(var_872f085f);
        direction = anglestoforward(var_872f085f);
        vectornormalize(direction);
        if (refly > 2) {
            speed = 1000;
            velocity = direction * speed;
            self player_free_fall::function_7705a7fc(2, velocity);
        }
        if (refly % 2 == 0) {
            while (true) {
                waitframe(1);
                if (self isonground() || self.origin[2] < -5000) {
                    while (self isonground() && self.origin[2] > -5000) {
                        waitframe(1);
                    }
                    self thread function_7d880672(original_origin, var_9f8395cb, refly);
                    return;
                }
            }
        }
    }

#/

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x4030180a, Offset: 0x3910
// Size: 0x184
function function_80c60f66(player) {
    insertion = self;
    assert(isstruct(insertion));
    for (index = 0; index < level.insertions.size; index++) {
        var_18310f7e = level.insertions[index];
        if (insertion == var_18310f7e) {
            var_18310f7e.players[var_18310f7e.players.size] = player;
            continue;
        }
        var_18310f7e.otherplayers[var_18310f7e.otherplayers.size] = player;
        player function_c62b5591(var_18310f7e);
    }
    player function_abd3bc1a(insertion);
    plane = player function_c4f5c468(insertion);
    player function_f795bf83(insertion, plane, insertion.leadplane.angles[1]);
    player function_c62b5591(insertion);
    player show_postfx();
}

/#

    // Namespace player_insertion/player_insertion
    // Params 0, eflags: 0x0
    // Checksum 0xbdc65c3, Offset: 0x3aa0
    // Size: 0x102
    function function_88c53de8() {
        refly = getdvarint(#"hash_1632f4021ab7a921", 0);
        if (refly) {
            players = getplayers();
            foreach (player in players) {
                player thread function_7d880672(player.origin, player.angles[1], refly);
            }
            return 1;
        }
        return 0;
    }

#/

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x4
// Checksum 0x42806388, Offset: 0x3bb0
// Size: 0x8f8
function private function_e59d879f(insertion, var_cf46aa72) {
    assert(isstruct(insertion));
    /#
        if (function_88c53de8()) {
            return;
        }
    #/
    function_948ac812(insertion);
    bot_insertion::function_24ca8ecf(insertion);
    vehiclespawns = [#"vehicle_t9_mil_air_transport_hpc_intro":"vehicle_t9_mil_air_transport_hpc_intro", #"vehicle_t8_mil_helicopter_transport_dark_wz_infiltration":"vehicle_t8_mil_helicopter_transport_dark_wz_infiltration", #"vehicle_t8_mil_helicopter_gunship_wz_infiltration":"vehicle_t8_mil_helicopter_gunship_wz_infiltration", #"vehicle_t8_mil_helicopter_light_transport_wz_infil":"vehicle_t8_mil_helicopter_light_transport_wz_infil"];
    if (vehiclespawns.size == 0) {
        return 0;
    }
    spawner::global_spawn_throttle(1);
    if (true) {
        var_69f4f44c = "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration";
    } else {
        var_69f4f44c = "vehicle_t9_mil_air_transport_hpc_intro";
    }
    startpoint = insertion.start_point;
    endpoint = insertion.end_point;
    var_872f085f = insertion.var_f253731f;
    var_37362e08 = insertion.var_37362e08;
    var_7743b329 = insertion.var_7743b329;
    insertion.leadplane = spawnvehicle(var_69f4f44c, startpoint, var_872f085f, "insertion_plane");
    insertion.leadplane.takedamage = 0;
    insertion.passengercount = 0;
    insertion.var_ef5094f9 = undefined;
    insertion.var_dfaba736 = [];
    insertion.var_27d17f06 = [];
    insertion.var_41091905 = [];
    if (!isdefined(insertion.var_41091905)) {
        insertion.var_41091905 = [];
    } else if (!isarray(insertion.var_41091905)) {
        insertion.var_41091905 = array(insertion.var_41091905);
    }
    insertion.var_41091905[insertion.var_41091905.size] = insertion.leadplane;
    if (true) {
        insertion.var_dfaba736 = [];
        insertion thread function_45b56b0a(insertion, startpoint, endpoint, var_872f085f, vehiclespawns);
        if (var_cf46aa72) {
            insertion thread function_f87ddcf0(insertion, startpoint, endpoint, var_872f085f, vehiclespawns);
        }
        s_formation = function_d9dfa25();
        for (i = 0; i < s_formation.var_c85ebc15; i++) {
            spawner::global_spawn_throttle(1);
            rotatedstart = startpoint + rotatepoint(s_formation.var_86cb4eb8[i], var_872f085f);
            var_4875d958 = vehiclespawns[s_formation.var_f5cff63[i]];
            vehicle = spawnvehicle(var_4875d958, rotatedstart, var_872f085f, "insertion_secondary");
            if (isdefined(vehicle)) {
                vehicle notsolid();
                vehicle.takedamage = 0;
                vehicle.startorigin = rotatedstart;
                if (!isdefined(insertion.var_dfaba736)) {
                    insertion.var_dfaba736 = [];
                } else if (!isarray(insertion.var_dfaba736)) {
                    insertion.var_dfaba736 = array(insertion.var_dfaba736);
                }
                insertion.var_dfaba736[insertion.var_dfaba736.size] = vehicle;
                if (s_formation.var_f5cff63[i] == "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration") {
                    if (!isdefined(insertion.var_41091905)) {
                        insertion.var_41091905 = [];
                    } else if (!isarray(insertion.var_41091905)) {
                        insertion.var_41091905 = array(insertion.var_41091905);
                    }
                    insertion.var_41091905[insertion.var_41091905.size] = vehicle;
                }
                if (i == s_formation.var_84f704f) {
                    insertion.var_ef5094f9 = vehicle;
                    vehicle.forwardoffset = s_formation.var_86cb4eb8[i][0];
                }
            }
        }
        if (!isdefined(insertion.var_ef5094f9)) {
            insertion.var_ef5094f9 = insertion.leadplane;
            insertion.var_ef5094f9.startorigin = startpoint;
            insertion.var_ef5094f9.endorigin = endpoint;
            insertion.var_ef5094f9.forwardoffset = 0;
        }
        for (i = 0; i < s_formation.var_c85ebc15; i++) {
            if (!isdefined(insertion.var_dfaba736[i])) {
                continue;
            }
            rotatedend = endpoint + rotatepoint(s_formation.var_86cb4eb8[i], var_872f085f);
            insertion.var_dfaba736[i].endorigin = rotatedend;
            insertion.var_dfaba736[i] setneargoalnotifydist(512);
            insertion.var_dfaba736[i] thread function_ea6a4f96(insertion.var_dfaba736[i].startorigin, rotatedend, var_872f085f, s_formation.hoverparams[i], s_formation.var_86255b48[i]);
        }
    } else {
        insertion.var_ef5094f9 = insertion.leadplane;
        insertion.var_ef5094f9.startorigin = startpoint;
        insertion.var_ef5094f9.endorigin = endpoint;
        insertion.var_ef5094f9.forwardoffset = 0;
    }
    insertion.leadplane setneargoalnotifydist(512);
    var_913594d7 = (0, 16, 16);
    insertion.leadplane thread function_ea6a4f96(startpoint, endpoint, var_872f085f, var_913594d7, 2);
    callback::on_spawned(&function_80c60f66, insertion);
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (isalive(player)) {
            plane = player function_c4f5c468(insertion);
            player function_f795bf83(insertion, plane, var_872f085f[1]);
        }
    }
    insertion thread function_afdad0c8(insertion, insertion.leadplane, startpoint, endpoint, var_7743b329);
    insertion thread function_6da3daa0(insertion, insertion.var_ef5094f9, insertion.var_ef5094f9.startorigin, insertion.var_ef5094f9.endorigin, var_37362e08 + insertion.var_ef5094f9.forwardoffset);
    insertion thread function_ca5b6591(insertion, startpoint, endpoint, var_872f085f);
    return 1;
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x4
// Checksum 0xf1cad0be, Offset: 0x44b0
// Size: 0x4a8
function private function_7341cc88(insertion, *var_cf46aa72) {
    assert(isstruct(var_cf46aa72));
    /#
        if (function_88c53de8()) {
            return;
        }
    #/
    function_948ac812(var_cf46aa72);
    bot_insertion::function_24ca8ecf(var_cf46aa72);
    vehiclespawns = ["vehicle_t9_mil_air_transport_hpc_intro"];
    if (vehiclespawns.size == 0) {
        return 0;
    }
    spawner::global_spawn_throttle(1);
    var_69f4f44c = "vehicle_t9_mil_air_transport_hpc_intro";
    startpoint = var_cf46aa72.start_point;
    endpoint = var_cf46aa72.end_point;
    var_872f085f = var_cf46aa72.var_f253731f;
    var_37362e08 = var_cf46aa72.var_37362e08;
    var_7743b329 = var_cf46aa72.var_7743b329;
    var_cf46aa72.leadplane = spawnvehicle(var_69f4f44c, startpoint, var_872f085f, "insertion_plane");
    var_cf46aa72.leadplane.takedamage = 0;
    var_cf46aa72.passengercount = 0;
    var_cf46aa72.var_ef5094f9 = undefined;
    var_cf46aa72.var_dfaba736 = [];
    var_cf46aa72.var_27d17f06 = [];
    var_cf46aa72.var_41091905 = [];
    if (!isdefined(var_cf46aa72.var_41091905)) {
        var_cf46aa72.var_41091905 = [];
    } else if (!isarray(var_cf46aa72.var_41091905)) {
        var_cf46aa72.var_41091905 = array(var_cf46aa72.var_41091905);
    }
    var_cf46aa72.var_41091905[var_cf46aa72.var_41091905.size] = var_cf46aa72.leadplane;
    level thread function_663e35b8();
    var_cf46aa72.var_ef5094f9 = var_cf46aa72.leadplane;
    var_cf46aa72.var_ef5094f9.startorigin = startpoint;
    var_cf46aa72.var_ef5094f9.endorigin = endpoint;
    var_cf46aa72.var_ef5094f9.forwardoffset = 0;
    var_cf46aa72.leadplane setneargoalnotifydist(512);
    var_913594d7 = (0, 16, 16);
    var_cf46aa72.leadplane thread function_ea6a4f96(startpoint, endpoint, var_872f085f, var_913594d7, 2);
    callback::on_spawned(&function_80c60f66, var_cf46aa72);
    function_a5fd9aa8(var_cf46aa72);
    foreach (player in var_cf46aa72.players) {
        if (isalive(player)) {
            plane = player function_c4f5c468(var_cf46aa72);
            player function_f795bf83(var_cf46aa72, plane, var_872f085f[1]);
        }
    }
    var_cf46aa72 thread function_afdad0c8(var_cf46aa72, var_cf46aa72.leadplane, startpoint, endpoint, var_7743b329);
    var_cf46aa72 thread function_6da3daa0(var_cf46aa72, var_cf46aa72.var_ef5094f9, var_cf46aa72.var_ef5094f9.startorigin, var_cf46aa72.var_ef5094f9.endorigin, var_37362e08 + var_cf46aa72.var_ef5094f9.forwardoffset);
    var_cf46aa72 thread function_ca5b6591(var_cf46aa72, startpoint, endpoint, var_872f085f);
    return 1;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x911d5b97, Offset: 0x4960
// Size: 0x20
function function_663e35b8() {
    wait 4;
    level notify(#"formation_start");
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x61939bc7, Offset: 0x4988
// Size: 0x8c
function function_43cc81fc() {
    s_formation = {#var_c85ebc15:0, #var_f5cff63:[], #var_86cb4eb8:[], #hoverparams:[], #var_86255b48:[], #var_84f704f:0, #alignment:"center"};
    return s_formation;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x9fdf74fe, Offset: 0x4a20
// Size: 0xa76
function function_d9dfa25() {
    a_formations = [];
    s_formation = {#var_c85ebc15:5, #var_f5cff63:array("vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration"), #var_86cb4eb8:array((2750, -550, 0), (2000, -1200, 0), (1500, 750, 0), (500, 1500, 0), (-900, -700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_86255b48:array(2, 2, 2, 2, 2), #var_84f704f:4, #alignment:"left"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    s_formation = {#var_c85ebc15:5, #var_f5cff63:array("vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration"), #var_86cb4eb8:array((2750, 550, 0), (2000, 1200, 0), (1500, -750, 0), (500, -1500, 0), (-900, 700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_86255b48:array(2, 2, 2, 2, 2), #var_84f704f:4, #alignment:"right"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    s_formation = {#var_c85ebc15:5, #var_f5cff63:array("vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration"), #var_86cb4eb8:array((2750, -900, 0), (2000, 100, 0), (1250, 1100, 0), (500, 2100, 0), (-900, -700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_86255b48:array(2, 2, 2, 2, 2), #var_84f704f:4, #alignment:"left"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    s_formation = {#var_c85ebc15:5, #var_f5cff63:array("vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration"), #var_86cb4eb8:array((2750, 900, 0), (2000, -100, 0), (1500, -1100, 0), (500, -2100, 0), (-900, 700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_86255b48:array(2, 2, 2, 2, 2), #var_84f704f:4, #alignment:"right"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    /#
        index = getdvarint(#"hash_5293cadde39a7ceb", -1);
        if (index > -1) {
            if (isdefined(a_formations[index])) {
                return a_formations[index];
            }
        }
    #/
    var_86cb4eb8[#"left"] = array((1200, -2300, 0), (-200, -2300, 0), (-1600, -2300, 0), (-3000, -2300, 0));
    var_86cb4eb8[#"right"] = array((1200, 2300, 0), (-200, 2300, 0), (-1600, 2300, 0), (-3000, 2300, 0));
    var_5637e595 = {#var_c85ebc15:4, #var_f5cff63:array("vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration", "vehicle_t8_mil_helicopter_gunship_wz_infiltration"), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192)), #var_86255b48:array(2, 2, 2, 2)};
    s_formation = array::random(a_formations);
    s_formation.var_c85ebc15 += var_5637e595.var_c85ebc15;
    s_formation.var_f5cff63 = arraycombine(s_formation.var_f5cff63, var_5637e595.var_f5cff63, 1, 0);
    s_formation.var_86cb4eb8 = arraycombine(s_formation.var_86cb4eb8, var_86cb4eb8[s_formation.alignment], 1, 0);
    s_formation.hoverparams = arraycombine(s_formation.hoverparams, var_5637e595.hoverparams, 1, 0);
    s_formation.var_86255b48 = arraycombine(s_formation.var_86255b48, var_5637e595.var_86255b48, 1, 0);
    return s_formation;
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x0
// Checksum 0x80e3f39a, Offset: 0x54a0
// Size: 0x206
function function_45b56b0a(insertion, startpoint, endpoint, var_872f085f, vehiclespawns) {
    offset = (500, -50, 600);
    goaloffset = (0, 0, -400);
    rotatedstart = startpoint + rotatepoint(offset, var_872f085f);
    var_31e5487a = vehiclespawns[#"vehicle_t8_mil_helicopter_light_transport_wz_infil"];
    insertion.var_933bdcf2 = spawnvehicle(var_31e5487a, rotatedstart, var_872f085f, "insertion_presentation");
    if (!isdefined(insertion.var_933bdcf2)) {
        assert(0);
        return;
    }
    insertion.var_933bdcf2.startorigin = rotatedstart;
    rotatedend = endpoint + rotatepoint(goaloffset, var_872f085f);
    insertion.var_933bdcf2.endorigin = rotatedend;
    wait 0.5;
    insertion.var_933bdcf2 setrotorspeed(1);
    insertion.var_933bdcf2 setspeedimmediate(level.var_c7f8ccf6 + 20);
    insertion.var_933bdcf2 setneargoalnotifydist(512);
    insertion.var_933bdcf2 vehlookat(rotatedend);
    insertion.var_933bdcf2 function_a57c34b7(rotatedend, 0, 0);
    insertion.var_933bdcf2.takedamage = 0;
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x0
// Checksum 0x8c28a6c8, Offset: 0x56b0
// Size: 0x33c
function function_f87ddcf0(insertion, startpoint, endpoint, var_872f085f, vehiclespawns) {
    offset = array((500, -100, 800), (500, 100, 800));
    goaloffset = array((0, 60000, -10000), (0, -60000, -10000));
    var_5b967418 = array("vehicle_t8_mil_helicopter_light_transport_wz_infil", "vehicle_t8_mil_helicopter_light_transport_wz_infil");
    insertion.var_27d17f06 = [];
    for (i = 0; i < 2; i++) {
        waitframe(1);
        rotatedstart = startpoint + rotatepoint(offset[i], var_872f085f);
        var_31e5487a = vehiclespawns[var_5b967418[i]];
        vehicle = spawnvehicle(var_31e5487a, rotatedstart, var_872f085f, "insertion_presentation");
        vehicle.origin = rotatedstart;
        vehicle.angles = var_872f085f;
        vehicle.startorigin = rotatedstart;
        if (!isdefined(insertion.var_27d17f06)) {
            insertion.var_27d17f06 = [];
        } else if (!isarray(insertion.var_27d17f06)) {
            insertion.var_27d17f06 = array(insertion.var_27d17f06);
        }
        insertion.var_27d17f06[insertion.var_27d17f06.size] = vehicle;
        waitframe(1);
    }
    for (i = 0; i < 2; i++) {
        rotatedend = endpoint + rotatepoint(goaloffset[i], var_872f085f);
        insertion.var_27d17f06[i].endorigin = rotatedend;
        insertion.var_27d17f06[i] setrotorspeed(1);
        insertion.var_27d17f06[i] setspeedimmediate(2);
        insertion.var_27d17f06[i] setneargoalnotifydist(512);
        insertion.var_27d17f06[i].takedamage = 0;
        insertion.var_27d17f06[i] thread function_700e474f(insertion.var_27d17f06[i].startorigin, rotatedend, var_872f085f, goaloffset[i][1], i);
    }
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x0
// Checksum 0x7373782e, Offset: 0x59f8
// Size: 0x34c
function function_700e474f(startorigin, endorigin, var_872f085f, goal, index) {
    self endon(#"death");
    dist = distance2d(endorigin, startorigin) / 3;
    offset = (dist / 2, math::sign(goal) * 1000, -1000);
    firstgoal = startorigin + rotatepoint(offset, var_872f085f);
    offset = (dist / 2, math::sign(goal) * 1000, -1000);
    var_9fa20618 = firstgoal + rotatepoint(offset, var_872f085f);
    /#
        if (getdvarint(#"hash_5bbd3d044e1ec1b8", 0)) {
            self thread function_84898b3f(firstgoal, var_9fa20618, endorigin, index);
        }
    #/
    wait 0.25;
    self setrotorspeed(1);
    self setspeedimmediate(2);
    self vehlookat(firstgoal);
    self function_a57c34b7(firstgoal, 0, 0);
    if (index > 0) {
        wait 0.75;
    }
    self setspeedimmediate(level.var_c7f8ccf6 - 30);
    self thread function_71da60d1();
    self waittill(#"goal", #"near_goal");
    self vehlookat(var_9fa20618);
    self function_a57c34b7(var_9fa20618, 0, 0);
    self waittill(#"goal", #"near_goal");
    self vehlookat(endorigin);
    self function_a57c34b7(endorigin, 0, 0);
    self setspeed(level.var_c7f8ccf6 + level.var_c7f8ccf6 * 0.66667);
    self waittill(#"goal", #"near_goal");
    self deletedelay();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xe98d87ba, Offset: 0x5d50
// Size: 0x3c
function function_71da60d1() {
    wait 4;
    level notify(#"formation_start");
    self setspeed(level.var_c7f8ccf6);
}

/#

    // Namespace player_insertion/player_insertion
    // Params 4, eflags: 0x0
    // Checksum 0x98b1aef2, Offset: 0x5d98
    // Size: 0x116
    function function_84898b3f(firstgoal, var_9fa20618, endorigin, index) {
        self endon(#"death");
        while (getdvarint(#"hash_5bbd3d044e1ec1b8", 0)) {
            color = index < 0 ? (0, 0, 1) : (1, 0, 0);
            sphere(firstgoal, 700, color);
            sphere(var_9fa20618, 700, color);
            sphere(endorigin, 700, color);
            line(firstgoal, var_9fa20618, color);
            line(var_9fa20618, endorigin, color);
            waitframe(1);
        }
    }

#/

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x0
// Checksum 0xf0ae1651, Offset: 0x5eb8
// Size: 0x214
function function_ea6a4f96(startorigin, endorigin, var_872f085f, offsetvec, var_35c96bb3) {
    self endon(#"death");
    self setspeedimmediate(level.var_c7f8ccf6);
    self setrotorspeed(1);
    self function_a57c34b7(endorigin, 0, 0);
    level waittill(#"formation_start");
    if (true) {
        direction = anglestoforward(var_872f085f);
        distance = distance(endorigin, startorigin);
        var_27dfb385 = int(distance) / 5000;
        remainingdist = int(distance) % 5000;
        for (i = 1; i <= var_27dfb385; i++) {
            self pathvariableoffset(offsetvec * (var_27dfb385 - i + 1), var_35c96bb3);
            self function_85635daf(startorigin, distance, i * 5000 / distance);
        }
        if (remainingdist > 0) {
            self pathvariableoffset(offsetvec, var_35c96bb3);
        }
    }
    self waittill(#"goal", #"near_goal");
    self deletedelay();
}

/#

    // Namespace player_insertion/player_insertion
    // Params 0, eflags: 0x4
    // Checksum 0x571ea500, Offset: 0x60d8
    // Size: 0xd8
    function private function_63793dbe() {
        time = getdvarfloat(#"hash_102dc944a54c88d9", 0);
        if (time) {
            wait time;
            foreach (player in function_a1ef346b()) {
                player flag::set(#"hash_224cb97b8f682317");
            }
        }
    }

#/

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x4
// Checksum 0xf2bb7b03, Offset: 0x61b8
// Size: 0x5b4
function private function_afdad0c8(insertion, plane, startpoint, endpoint, var_671fc488) {
    assert(isstruct(insertion));
    self notify("18f7a03b100c0647");
    self endon("18f7a03b100c0647");
    plane endon(#"death");
    foreach (vehicle in insertion.var_41091905) {
        vehicle clientfield::set("infiltration_landing_gear", 1);
        vehicle setrotorspeed(1);
    }
    var_5d59bc67 = 17.6 * level.var_c7f8ccf6;
    var_5e24c814 = 5 * var_5d59bc67;
    total_distance = distance(startpoint, endpoint);
    assert(total_distance > var_671fc488);
    assert(var_671fc488 - var_5e24c814 > 0);
    assert(total_distance > var_671fc488 - var_5e24c814);
    var_f26cf241 = (var_671fc488 - var_5e24c814) / total_distance;
    end_t = var_671fc488 / total_distance;
    /#
        level thread function_63793dbe();
    #/
    plane function_85635daf(startpoint, total_distance, var_f26cf241);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (is_true(player.var_97b0977)) {
            continue;
        }
        player clientfield::set_to_player("infiltration_final_warning", 1);
    }
    plane function_85635daf(startpoint, total_distance, end_t);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    level callback::callback(#"hash_774be40ec06d5212");
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        player flag::set(#"hash_224cb97b8f682317");
    }
    function_dd34168c(insertion, #"hash_60fcdd11812a0134");
    wait 1;
    for (index = 0; index <= insertion.var_41091905.size; index++) {
        if (isdefined(insertion.cameraent[index])) {
            insertion.cameraent[index] delete();
        }
    }
    if (isdefined(insertion.var_b686c9d)) {
        insertion.var_b686c9d delete();
    }
    if (isdefined(insertion.var_d908905e)) {
        insertion.var_d908905e delete();
    }
    if (isdefined(insertion.infilteament)) {
        insertion.infilteament delete();
    }
    wait 5;
    currentvalue = level clientfield::get("infiltration_compass");
    newvalue = ~(1 << insertion.index) & currentvalue;
    level clientfield::set("infiltration_compass", newvalue);
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x4
// Checksum 0x911c5e98, Offset: 0x6778
// Size: 0x2ec
function private function_6da3daa0(insertion, plane, startpoint, endpoint, var_6a694ed8) {
    assert(isstruct(insertion));
    self notify("b4c15e1db4802d8");
    self endon("b4c15e1db4802d8");
    plane endon(#"death");
    var_5d59bc67 = 17.6 * level.var_c7f8ccf6;
    var_7cd0d619 = 0.6 * var_5d59bc67;
    total_distance = distance(startpoint, endpoint);
    assert(total_distance > var_6a694ed8);
    assert(var_6a694ed8 - var_7cd0d619 > 0);
    assert(total_distance > var_6a694ed8 - var_7cd0d619);
    cargo_t = (var_6a694ed8 - var_7cd0d619) / total_distance;
    start_t = var_6a694ed8 / total_distance;
    plane function_85635daf(startpoint, total_distance, cargo_t);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    insertion thread function_d11a5f0c(insertion);
    plane function_85635daf(startpoint, total_distance, start_t);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        player flag::set(#"hash_287397edba8966f9");
    }
    wait 2;
    insertion callback::callback(#"hash_20fcd06900f62558");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xe2cf91ef, Offset: 0x6a70
// Size: 0x118
function function_bc16f3b4(insertion) {
    assert(isstruct(insertion));
    self clientfield::set("infiltration_transport", 1);
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (player islinkedto(self)) {
            player clientfield::set_to_player("infiltration_jump_warning", 1);
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xce3cde3a, Offset: 0x6b90
// Size: 0x218
function function_d11a5f0c(insertion) {
    assert(isstruct(insertion));
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        player.var_97b0977 = 0;
    }
    foreach (vehicle in insertion.var_41091905) {
        vehicle function_bc16f3b4(insertion);
        wait randomfloatrange(0.5, 1);
    }
    function_a5fd9aa8(insertion);
    foreach (player in insertion.players) {
        if (isdefined(player)) {
            player clientfield::set_to_player("realtime_multiplay", 1);
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xae397d2a, Offset: 0x6db0
// Size: 0x170
function function_b80277f7() {
    if (isbot(self)) {
        self bot_insertion::function_a4f516ef();
        return;
    }
    while (true) {
        waitframe(1);
        if (self flag::get(#"hash_287397edba8966f9") && isdefined(level.insertionpassenger) && isdefined(level.var_f3320ad2) && isdefined(level.var_a3c0d635) && isdefined(level.var_ce84dde9) && !level.insertionpassenger [[ level.var_a3c0d635 ]](self)) {
            level.insertionpassenger [[ level.var_f3320ad2 ]](self);
            level.insertionpassenger [[ level.var_ce84dde9 ]](self, level.insertion.passengercount);
        }
        if (self flag::get(#"hash_224cb97b8f682317") || self flag::get(#"hash_287397edba8966f9") && self jumpbuttonpressed()) {
            return;
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xa7dfc7f, Offset: 0x6f28
// Size: 0xbc
function function_1c06c249(plane) {
    if (isplayer(self) && isdefined(plane)) {
        self match_record::function_ded5f5b6(#"hash_1657e02fb5073e4a", plane.origin);
        self match_record::set_player_stat(#"hash_16618233fdac5c29", gettime());
        self match_record::set_player_stat(#"hash_63b95d780b2bd355", self flag::get(#"hash_224cb97b8f682317"));
    }
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0xacd99972, Offset: 0x6ff0
// Size: 0xfc
function function_25facefd(count, *ignore_player) {
    if (isdefined(level.insertionpassenger) && isdefined(level.var_a3c0d635) && isdefined(level.var_ce84dde9)) {
        foreach (player in getplayers()) {
            if (level.insertionpassenger [[ level.var_a3c0d635 ]](player)) {
                level.insertionpassenger [[ level.var_ce84dde9 ]](player, ignore_player);
            }
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 3, eflags: 0x0
// Checksum 0xf7095578, Offset: 0x70f8
// Size: 0xcc
function function_2e54d73e(insertion, passenger, vehicle) {
    assert(isstruct(insertion));
    if (isdefined(vehicle)) {
        vehicle endon(#"death");
    }
    waitresult = passenger waittill(#"disconnect", #"player_jumped");
    if (isdefined(insertion.passengercount)) {
        insertion.passengercount--;
        function_25facefd(insertion.passengercount);
    }
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x4
// Checksum 0xb180976a, Offset: 0x71d0
// Size: 0xbc
function private function_ced05c63(note, payload) {
    teammates = getplayers(self.team);
    foreach (player in teammates) {
        if (player == self) {
            continue;
        }
        player notify(note, payload);
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0x4f658f98, Offset: 0x7298
// Size: 0x12c
function private function_8ab37f3b(aircraft) {
    friendlies = getplayers(self.team);
    var_d603dbcf = 1;
    foreach (friendly in friendlies) {
        if (friendly == self) {
            continue;
        }
        if (friendly islinkedto(aircraft)) {
            aircraft playsoundtoplayer(#"hash_30b8de3aeaf8d338", friendly);
            var_d603dbcf = 0;
        }
    }
    if (var_d603dbcf) {
        self playsoundtoplayer(#"hash_2181506039f121cb", self);
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x55fb4838, Offset: 0x73d0
// Size: 0x264
function function_5b3ac9f2(aircraft) {
    self notify("2e6ce054cf413d69");
    self endon("2e6ce054cf413d69");
    self endon(#"death");
    self function_b9a53f50();
    self function_b80277f7();
    self function_ced05c63(#"hash_3a41cbe85bdb81e1", {#player:self});
    self function_8ab37f3b(aircraft);
    self function_1c06c249(aircraft);
    self startcameratween(1);
    self thread function_eac07dca(aircraft);
    util::wait_network_frame();
    self cameraactivate(0);
    self setclientthirdperson(0);
    self function_598b7862(aircraft);
    self death_circle::function_b57e3cde(0);
    self clientfield::set_to_player("inside_infiltration_vehicle", 0);
    if (isdefined(level.insertionpassenger) && isdefined(level.var_81b39a59)) {
        level.insertionpassenger [[ level.var_81b39a59 ]](self);
    }
    self hide_postfx();
    self stoprumble(#"hash_233b436a07cd091a");
    self val::reset(#"player_insertion", "show_weapon_hud");
    level callback::callback(#"hash_74b19f5972b0ee52", {#player:self});
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xae19be19, Offset: 0x7640
// Size: 0x2d4
function function_598b7862(aircraft) {
    self endon(#"death");
    self unlink();
    self setorigin(self.var_df1a9210.origin);
    self playerlinkto(self.var_df1a9210);
    planeforward = anglestoforward(aircraft.angles);
    planeright = anglestoright(aircraft.angles);
    playerforward = anglestoforward(self getplayerangles());
    forwarddot = vectordot(planeforward, playerforward);
    if (forwarddot > 0.707107) {
        if (math::cointoss()) {
            anim = #"hash_49be5b5409a97147";
        } else {
            anim = #"hash_49be415409a94519";
        }
    } else if (forwarddot < -0.707107) {
        anim = #"hash_d6c9fa8235b69f8";
    } else {
        rightdot = vectordot(planeright, playerforward);
        if (rightdot > 0) {
            anim = #"hash_46c65ea54508f35f";
        } else {
            anim = #"hash_46c674a5450918c1";
        }
    }
    self playsoundtoplayer(#"hash_214da797e3f63ec5", self);
    self.var_df1a9210 animation::play(anim, aircraft, "tag_player_spawn");
    self unlink();
    self setorigin(self.var_df1a9210.origin - (0, 0, 150));
    self show();
    self solid();
    self.var_df1a9210 delete();
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xb195310a, Offset: 0x7920
// Size: 0x144
function function_eac07dca(aircraft) {
    self notify("4109d7c007d03912");
    self endon("4109d7c007d03912");
    self endon(#"disconnect");
    self notify(#"player_jumped");
    self function_3354a054();
    self hud_message::clearlowermessage();
    self val::set(#"player_insertion", "disable_oob", 0);
    velocity = function_2b41b403(aircraft getvelocity());
    level callback::callback(#"hash_259e3bcba73a2f14", {#player:self});
    var_a91303da = 2;
    self function_ed4c9a32(var_a91303da, 0, undefined, velocity, 0);
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0x7723a00f, Offset: 0x7a70
// Size: 0x10c
function start_freefall(velocity, *height) {
    self function_8a945c0e(0);
    self callback::function_d8abfc3d(#"freefall", &function_3b9bcf85);
    self player_free_fall::function_7705a7fc(0, height);
    self playsoundtoplayer(#"hash_214da797e3f63ec5", self);
    self.var_97b0977 = 1;
    self hud_message::clearlowermessage();
    self val::set(#"player_insertion", "disable_oob", 0);
    self function_3354a054();
    self thread function_712f9f52();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x4b65eae6, Offset: 0x7b88
// Size: 0x6e
function function_4630bf0a() {
    if (isplayer(self)) {
        self match_record::function_ded5f5b6(#"hash_7d9d379ecba10793", self.origin);
        self match_record::set_player_stat(#"hash_1469faf3180d8b7a", gettime());
        self.var_37ef8626 = gettime();
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x830b50c6, Offset: 0x7c00
// Size: 0x104
function function_4eb0c560() {
    self clientfield::set_player_uimodel("hudItems.skydiveAltimeterVisible", 0);
    self val::reset(#"player_insertion", "disablegadgets");
    self val::reset(#"player_insertion", "show_hud");
    self val::reset(#"player_insertion", "show_weapon_hud");
    if (is_true(level.spawnsystem.deathcirclerespawn) || isdefined(level.waverespawndelay) && level.waverespawndelay > 0) {
        self clientfield::set_player_uimodel("hudItems.showReinsertionPassengerCount", 1);
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x7b999d41, Offset: 0x7d10
// Size: 0x5c
function function_3b9bcf85(args) {
    if (!is_true(args.freefall) && !is_true(args.var_695a7111)) {
        function_4eb0c560();
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xfcd4f09, Offset: 0x7d78
// Size: 0x1c
function function_916470ec(*args) {
    function_4eb0c560();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x703580d5, Offset: 0x7da0
// Size: 0xfc
function function_4feecc32() {
    self setclientthirdperson(0);
    self show();
    self solid();
    self val::reset(#"player_insertion", "takedamage");
    self val::reset(#"warzonestaging", "takedamage");
    self death_circle::function_b57e3cde(0);
    self val::set(#"player_insertion", "disable_oob", 0);
    self clientfield::set_to_player("realtime_multiplay", 1);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xf2388888, Offset: 0x7ea8
// Size: 0xbc
function function_712f9f52() {
    self endon(#"death");
    if (is_true(level.var_7abaaef1)) {
        callback::function_d8abfc3d(#"parachute", &function_66c91693);
    } else {
        callback::function_d8abfc3d(#"skydive_end", &function_f99c2453);
    }
    callback::on_death(&function_916470ec);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0xf4968ba7, Offset: 0x7f70
// Size: 0x5c
function private function_f99c2453(*params) {
    self clientfield::set_player_uimodel("hudItems.skydiveAltimeterVisible", 0);
    self callback::function_52ac9652(#"skydive_end", &function_f99c2453);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x809578cf, Offset: 0x7fd8
// Size: 0x94
function function_66c91693(eventstruct) {
    if (!eventstruct.parachute) {
        self function_4630bf0a();
        function_916470ec(self);
        self callback::function_52ac9652(#"parachute", &function_66c91693);
        self callback::remove_on_death(&function_916470ec);
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0x177bfa3a, Offset: 0x8078
// Size: 0x98
function private function_d7f18e8f(players) {
    foreach (player in players) {
        if (!isbot(player)) {
            return player;
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x75a1e9db, Offset: 0x8118
// Size: 0x86
function function_6660c1f() {
    if (!isdefined(level.insertions)) {
        return false;
    }
    for (index = 0; index < level.insertions.size; index++) {
        insertion = level.insertions[index];
        if (insertion flag::get(#"hash_60fcdd11812a0134")) {
            return false;
        }
    }
    return true;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x13a3d5, Offset: 0x81a8
// Size: 0x76
function function_e5d4df1c() {
    for (index = 0; index < level.insertions.size; index++) {
        insertion = level.insertions[index];
        if (insertion flag::get(#"hash_122f326d72f4c884")) {
            return true;
        }
    }
    return false;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xa49bcec1, Offset: 0x8228
// Size: 0xea
function function_a4deb676() {
    a_start_buttons = getentarray("game_start_button", "script_noteworthy");
    array::delete_all(a_start_buttons);
    if (isdefined(level.var_63460f40)) {
        foreach (object in level.var_63460f40) {
            object gameobjects::destroy_object(1);
        }
        level.var_63460f40 = undefined;
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x9b369ef4, Offset: 0x8320
// Size: 0x24
function show_postfx() {
    self clientfield::set_to_player("heatblurpostfx", 1);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xa2049c62, Offset: 0x8350
// Size: 0x24
function hide_postfx() {
    self clientfield::set_to_player("heatblurpostfx", 0);
}

/#

    // Namespace player_insertion/player_insertion
    // Params 1, eflags: 0x4
    // Checksum 0x50654809, Offset: 0x8380
    // Size: 0x2a0
    function private function_943c98fb(insertion) {
        assert(isstruct(insertion));
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x7a>" + mapname + "<dev string:x8b>");
        waitframe(1);
        adddebugcommand("<dev string:x7a>" + mapname + "<dev string:xde>");
        waitframe(1);
        adddebugcommand("<dev string:x7a>" + mapname + "<dev string:x12d>");
        waitframe(1);
        adddebugcommand("<dev string:x7a>" + mapname + "<dev string:x186>");
        waitframe(1);
        adddebugcommand("<dev string:x7a>" + mapname + "<dev string:x1de>");
        while (true) {
            waitframe(1);
            string = getdvarstring(#"hash_683dafe2da41b42e", "<dev string:x236>");
            start_insertion = 0;
            switch (string) {
            case #"start_insertion":
                start_insertion = 1;
                break;
            case #"repath_flight":
                insertion on_finalize_initialization();
            default:
                break;
            }
            if (start_insertion) {
                level function_8dcd8623();
            }
            setdvar(#"hash_683dafe2da41b42e", "<dev string:x236>");
            if (getdvarint(#"hash_5566ccc7de522a4a", 0)) {
                setdvar(#"hash_5566ccc7de522a4a", 0);
                level thread namespace_b9471dc1::function_4910c182(insertion);
            }
        }
    }

#/

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x77b4e15d, Offset: 0x8628
// Size: 0x3f4
function function_bc144896() {
    var_f91e1d86 = 256;
    var_15e03744 = 0;
    var_eb0cb2e8 = 1;
    var_ceb87008 = 0.5;
    var_ec878a03 = 0;
    var_345d6bc2 = 0;
    var_56e391f5 = 5000;
    var_387d8ced = 10;
    var_84d65252 = 2;
    var_82a96275 = 10000;
    var_9fc10c55 = 7500;
    var_708b2fe0 = -2;
    function_5ac4dc99("scr_parachute_redeploy_min_height", var_f91e1d86);
    function_5ac4dc99("scr_parachute_redeploy_input_type", var_15e03744);
    function_5ac4dc99("scr_parachute_auto_kick_map_center", (0, 0, 0));
    function_5ac4dc99("scr_parachute_camera_transition_mode", 2);
    function_5ac4dc99("scr_parachute_FFSM_enabled", 1);
    function_5ac4dc99("scr_parachute_hint_enabled", var_eb0cb2e8);
    function_5ac4dc99("scr_parachute_hint_zdrop", var_ceb87008);
    function_5ac4dc99("scr_parachute_hint_zoffset", var_ec878a03);
    function_5ac4dc99("scr_parachute_hint_zvelscale", var_345d6bc2);
    function_5ac4dc99("scr_parachute_hint_zlimit", var_56e391f5);
    function_5ac4dc99("scr_parachute_hint_xyvelscale_high", var_387d8ced);
    function_5ac4dc99("scr_parachute_hint_xyvelscale_low", var_84d65252);
    function_5ac4dc99("scr_parachute_hint_xyvelscale_maxheight", var_82a96275);
    function_5ac4dc99("scr_parachute_hint_xylimit", var_9fc10c55);
    function_5ac4dc99("scr_parachute_hint_falling_xyratio", var_708b2fe0);
    level.parachutecancutautodeploy = getdvarint(#"hash_66102f189c07f6f", 1);
    level.parachutecancutparachute = getdvarint(#"hash_432959289606da80", 1);
    level.parachuteinitfinished = 1;
    level.activeparachuters = [];
    if (!isdefined(level.dontshootwhileparachuting)) {
        level.dontshootwhileparachuting = 1;
    }
    if (!isdefined(level.freefallstartcb)) {
        level.freefallstartcb = &function_435d1356;
    }
    if (!isdefined(level.parachuteopencb)) {
        level.parachuteopencb = &function_2f112556;
    }
    if (!isdefined(level.parachutecompletecb)) {
        level.parachutecompletecb = &function_a4f5dbf9;
    }
    if (!isdefined(level.parachutetakeweaponscb)) {
        level.parachutetakeweaponscb = &function_e5b1d4c7;
    }
    if (!isdefined(level.parachuterestoreweaponscb)) {
        level.parachuterestoreweaponscb = &function_750cef68;
    }
    if (!isdefined(level.parachuteprelaststandfunc)) {
        level.parachuteprelaststandfunc = &function_9e7ff546;
    }
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x0
// Checksum 0x273f4ce2, Offset: 0x8a28
// Size: 0x3d2
function function_ed4c9a32(falltime, popinstant, var_921a1f7e, startingvelocity, takeweapons) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"freefallfromplanestatemachine");
    self endon(#"freefallfromplanestatemachine");
    player = self;
    player.var_97b0977 = 1;
    player.ffsm_state = 1;
    player.ffsm_nextstreamhinttime = 0;
    player ffsm_introsetup(falltime, popinstant, var_921a1f7e, startingvelocity, takeweapons);
    player ffsm_skydive_stateenter();
    var_d5dd0ca5 = 2000;
    starttime = gettime();
    while (true) {
        if (player isskydiving() || starttime + var_d5dd0ca5 < gettime() || player function_b9370594()) {
            break;
        }
        waitframe(1);
    }
    self setisinfilskydive(0);
    while (true) {
        if (player isinfreefall() && player.ffsm_state != 1) {
            player ffsm_skydive_stateenter();
            player.ffsm_state = 1;
        }
        if (player isparachuting() && player.ffsm_state != 2) {
            player ffsm_parachuteopen_stateenter();
            player.ffsm_state = 2;
        }
        if (!player isskydiving() && player.ffsm_state != 3 && player.ffsm_state != 4 && player.ffsm_state != 6 || player.ffsm_state == 5) {
            player ffsm_landed_stateenter();
            if (player.ffsm_state != 5) {
                player.ffsm_state = 3;
            } else {
                assert(player.ffsm_state == 5);
                player.ffsm_state = 6;
            }
        }
        var_a58af056 = is_true(player.inlaststand);
        bisland = player isonground() && (player.ffsm_state == 3 || player function_b9370594());
        var_91d1c5fd = !isalive(player);
        if (var_a58af056 || bisland || var_91d1c5fd) {
            player ffsm_onground_stateenter();
            player.ffsm_state = undefined;
            player.ffsm_isgulagrespawn = undefined;
            player.ffsm_nextstreamhinttime = undefined;
            return;
        }
        waitframe(1);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xd80273ee, Offset: 0x8e08
// Size: 0x30
function function_b9370594() {
    return isdefined(self.ffsm_state) && (self.ffsm_state == 5 || self.ffsm_state == 6);
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x0
// Checksum 0xa82bbe55, Offset: 0x8e40
// Size: 0x1f0
function ffsm_introsetup(falltime, popinstant, *var_921a1f7e, startingvelocity, takeweapons) {
    /#
        if (getdvarint(#"hash_517fa3f3ae2f8e77", 0) == 1) {
            self thread function_c3c0b24b();
        }
    #/
    self function_8cf53a19();
    if (!is_true(level.parachuteinitfinished)) {
        function_bc144896();
    }
    var_e5fc45d3 = 4;
    if (!isdefined(popinstant)) {
        popinstant = var_e5fc45d3;
    }
    if (!isdefined(takeweapons)) {
        takeweapons = 1;
    }
    self [[ level.freefallstartcb ]]();
    if (isdefined(startingvelocity)) {
        self setvelocity(startingvelocity);
    }
    self function_b02c52b();
    self setisinfilskydive(1);
    if (getdvarint(#"scr_parachute_camera_transition_mode", 1) != 2) {
        self function_41170420(1);
    }
    if (is_true(var_921a1f7e)) {
        self thread player_free_fall::function_2979b1be(0);
    } else {
        self thread player_free_fall::function_2979b1be(popinstant);
    }
    self [[ level.parachuterestoreweaponscb ]]();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xa3bf9c8e, Offset: 0x9038
// Size: 0x24
function ffsm_skydive_stateenter() {
    self clientfield::set_player_uimodel("hudItems.skydiveAltimeterVisible", 1);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xac7c9613, Offset: 0x9068
// Size: 0x48
function ffsm_parachuteopen_stateenter() {
    self notify(#"freefall_complete");
    if (!is_true(level.dontshootwhileparachuting)) {
        self [[ level.parachuteopencb ]]();
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xd50dbd0f, Offset: 0x90b8
// Size: 0xde
function ffsm_landed_stateenter(*var_991bab43) {
    self.ignorefalldamagetime = gettime() + 5000;
    if (is_true(self.delayswaploadout)) {
        self.delayswaploadout = 0;
    }
    if (is_true(level.dontshootwhileparachuting)) {
        self [[ level.parachutecompletecb ]]();
    }
    self notify(#"parachute_landed");
    self function_41170420(0);
    if (!self function_b9370594()) {
        self function_8b8a321a(1);
    }
    self notify(#"parachute_complete");
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x4c92e51e, Offset: 0x91a0
// Size: 0x50
function ffsm_onground_stateenter() {
    function_4eb0c560();
    self thread function_71205442();
    if (isdefined(level.onfirstlandcallback)) {
        self [[ level.onfirstlandcallback ]](self);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x91f8
// Size: 0x4
function function_71205442() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x5c716a0e, Offset: 0x9208
// Size: 0x1c
function function_435d1356() {
    self disableusability();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x9230
// Size: 0x4
function function_2f112556() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x58f2334e, Offset: 0x9240
// Size: 0x4a
function function_a4f5dbf9() {
    self enableusability();
    if (isdefined(level.modespecificparachutecompletecb)) {
        self [[ level.modespecificparachutecompletecb ]]();
    }
    self.jumptype = undefined;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x9298
// Size: 0x4
function function_e5b1d4c7() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x92a8
// Size: 0x4
function function_750cef68() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x92b8
// Size: 0x4
function function_7c164b8f() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x92c8
// Size: 0x4
function function_7e55f28b() {
    
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xb004bc56, Offset: 0x92d8
// Size: 0x72
function function_9e7ff546() {
    player = self;
    if (isdefined(player.ffsm_state) && (player.ffsm_state == 1 || player.ffsm_state == 2)) {
        player ffsm_landed_stateenter();
        player.ffsm_state = 3;
    }
}

/#

    // Namespace player_insertion/player_insertion
    // Params 4, eflags: 0x0
    // Checksum 0x7ab3a389, Offset: 0x9358
    // Size: 0xb2
    function draw_line(start, end, drawtimeseconds, color) {
        drawframes = int(drawtimeseconds / float(function_60d95f53()) / 1000);
        for (frame = 0; frame < drawframes; frame++) {
            line(start, end, color);
            waitframe(1);
        }
    }

    // Namespace player_insertion/player_insertion
    // Params 4, eflags: 0x0
    // Checksum 0x461aca4e, Offset: 0x9418
    // Size: 0x19a
    function draw_angles(origin, angles, var_753aae30, scalar) {
        if (!isdefined(scalar)) {
            scalar = 1;
        }
        drawframes = int(var_753aae30 / float(function_60d95f53()) / 1000);
        for (frame = 0; frame < drawframes; frame++) {
            fwd = anglestoforward(angles);
            right = anglestoright(angles);
            up = anglestoup(angles);
            line(origin, origin + fwd * 12 * scalar, (1, 0, 0));
            line(origin, origin + right * 12 * scalar, (0, 1, 0));
            line(origin, origin + up * 12 * scalar, (0, 0, 1));
            waitframe(1);
        }
    }

    // Namespace player_insertion/player_insertion
    // Params 0, eflags: 0x0
    // Checksum 0x1fc818a0, Offset: 0x95c0
    // Size: 0xfe
    function function_c3c0b24b() {
        self endon(#"death", #"disconnect");
        self endon(#"parachute_complete");
        while (true) {
            thread draw_angles(self.origin, self.angles, 0.05, 5);
            velocity = self getvelocity();
            mag = length(velocity);
            thread draw_line(self.origin, self.origin + vectornormalize(velocity) * mag, 0.05, (1, 0, 1));
            waitframe(1);
        }
    }

#/
