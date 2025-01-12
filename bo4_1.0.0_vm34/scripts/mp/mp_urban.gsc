#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\doors_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_urban_fx;
#using scripts\mp\mp_urban_sound;
#using scripts\mp_common\load;

#namespace mp_urban;

// Namespace mp_urban/level_init
// Params 1, eflags: 0x40
// Checksum 0x1d97efd3, Offset: 0x188
// Size: 0xbc
function event_handler[level_init] main(eventstruct) {
    callback::on_game_playing(&on_game_playing);
    callback::on_end_game(&on_end_game);
    mp_urban_fx::main();
    mp_urban_sound::main();
    /#
        init_devgui();
    #/
    load::main();
    compass::setupminimap("");
    function_a272d512();
}

// Namespace mp_urban/mp_urban
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x250
// Size: 0x4
function precache() {
    
}

// Namespace mp_urban/mp_urban
// Params 0, eflags: 0x0
// Checksum 0x1a88550, Offset: 0x260
// Size: 0x17c
function on_game_playing() {
    array::delete_all(getentarray("sun_block", "targetname"));
    if (getdvarint(#"hash_1ee1f013d124a26a", 0)) {
        function_e284b6f1();
    }
    wait getdvarfloat(#"hash_205d729c5c415715", 0.3);
    if (getdvarint(#"hash_1ee1f013d124a26a", 1)) {
        var_1a84f2e0 = struct::get("p8_fxanim_mp_urban_remote_tank_armor_test_bundle", "scriptbundlename");
        if (isdefined(var_1a84f2e0)) {
            var_1a84f2e0 thread function_96c33b1f();
        }
        var_f1538660 = struct::get("p8_fxanim_mp_urban_vehicle_testing_bundle", "scriptbundlename");
        if (isdefined(var_f1538660)) {
            var_f1538660 thread function_49fd4f38();
        }
        if (util::isfirstround()) {
            level thread scene::play(#"p8_fxanim_mp_urban_flyover_bundle");
        }
    }
}

// Namespace mp_urban/mp_urban
// Params 0, eflags: 0x0
// Checksum 0x9c0cb1aa, Offset: 0x3e8
// Size: 0x112
function on_end_game() {
    if (!isdefined(level.var_2437389c)) {
        level.var_2437389c = [];
    }
    foreach (scene in level.var_2437389c) {
        scene.barrage = 0;
    }
    var_1a84f2e0 = struct::get("p8_fxanim_mp_urban_remote_tank_armor_test_bundle", "scriptbundlename");
    if (isdefined(var_1a84f2e0)) {
        var_1a84f2e0.var_b0d07d98 = 0;
    }
    var_f1538660 = struct::get("p8_fxanim_mp_urban_vehicle_testing_bundle", "scriptbundlename");
    if (isdefined(var_f1538660)) {
        var_f1538660.var_b0d07d98 = 0;
    }
}

// Namespace mp_urban/mp_urban
// Params 0, eflags: 0x0
// Checksum 0x5c6edd66, Offset: 0x508
// Size: 0x14c
function function_a272d512() {
    if (getdvarint(#"hash_1ee1f013d124a26a", 1)) {
        level util::delay(0.3, undefined, &scene::play, #"p8_fxanim_mp_urban_vehicle_testing_bundle", "Shot 1");
        if (util::isfirstround()) {
            level thread scene::play(#"p8_fxanim_mp_urban_building_open_bundle");
            level thread scene::play(#"p8_fxanim_mp_urban_remote_tank_armor_test_bundle", "start_drop");
            level thread scene::play(#"p8_fxanim_mp_urban_remote_tank_walk_test_bundle");
            return;
        }
        level thread scene::skipto_end(#"p8_fxanim_mp_urban_building_open_bundle");
        level thread scene::skipto_end(#"p8_fxanim_mp_urban_flyover_bundle");
        level thread scene::play(#"p8_fxanim_mp_urban_remote_tank_walk_test_bundle", "Shot 2");
    }
}

// Namespace mp_urban/mp_urban
// Params 0, eflags: 0x0
// Checksum 0x4aebd67c, Offset: 0x660
// Size: 0x54
function function_e284b6f1() {
    level.var_2437389c = struct::get_array("p8_fxanim_mp_urban_artillery_fire_bundle", "scriptbundlename");
    array::thread_all(level.var_2437389c, &function_688fb48d);
}

// Namespace mp_urban/mp_urban
// Params 0, eflags: 0x0
// Checksum 0x98cec650, Offset: 0x6c0
// Size: 0xb0
function function_688fb48d() {
    self.script_play_multiple = 1;
    self.barrage = 1;
    wait randomfloatrange(8, 35);
    i = 0;
    while (self.barrage) {
        self scene::play();
        i++;
        if (i == 2) {
            self.barrage = 0;
            break;
        }
        wait randomfloatrange(45, 200);
    }
}

// Namespace mp_urban/mp_urban
// Params 0, eflags: 0x0
// Checksum 0x4ba1d83d, Offset: 0x778
// Size: 0x156
function function_96c33b1f() {
    self.var_b0d07d98 = 1;
    for (n_shot = array::random(array(2, 4, 6, 8)); self.var_b0d07d98; n_shot++) {
        n_attacks = randomintrange(1, 3);
        for (i = 0; i < n_attacks; i++) {
            self scene::play(self.scriptbundlename, "Shot " + n_shot);
        }
        n_shot++;
        self scene::play(self.scriptbundlename, "Shot " + n_shot);
        if (n_shot == 9) {
            n_shot = 1;
            self scene::play(self.scriptbundlename, "Shot " + n_shot);
        }
    }
}

// Namespace mp_urban/mp_urban
// Params 0, eflags: 0x0
// Checksum 0x943f229e, Offset: 0x8d8
// Size: 0xae
function function_49fd4f38() {
    self.var_b0d07d98 = 1;
    for (i = 0; i < 3; i++) {
        if (!self.var_b0d07d98) {
            return;
        }
        wait 180;
        self scene::play(self.scriptbundlename, "Shot 2");
        self scene::play(self.scriptbundlename, "Shot 1");
    }
}

/#

    // Namespace mp_urban/mp_urban
    // Params 0, eflags: 0x0
    // Checksum 0x37d6b5a7, Offset: 0x990
    // Size: 0x9c
    function init_devgui() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x3e>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x77>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:xb6>");
    }

#/
