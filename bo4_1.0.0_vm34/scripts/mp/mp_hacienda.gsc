#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_hacienda_fx;
#using scripts\mp\mp_hacienda_sound;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\load;

#namespace mp_hacienda;

// Namespace mp_hacienda/level_init
// Params 1, eflags: 0x40
// Checksum 0x43004f2, Offset: 0x438
// Size: 0x1e4
function event_handler[level_init] main(eventstruct) {
    callback::on_game_playing(&on_game_playing);
    globallogic_spawn::function_4410852b((-429.554, -3255.01, 0.125), (0, 75.0092, 0), "allies", "tdm");
    globallogic_spawn::function_4410852b((10.2171, 3351, 68.3488), (0, -71.0046, 0), "axis", "tdm");
    globallogic_spawn::function_4410852b((-429.554, -3255.01, 0.125), (0, 75.0092, 0), "allies", "conf");
    globallogic_spawn::function_4410852b((10.2171, 3351, 68.3488), (0, -71.0046, 0), "axis", "conf");
    mp_hacienda_fx::main();
    mp_hacienda_sound::main();
    load::main();
    function_757ba09a();
    compass::setupminimap("");
    function_a272d512();
    function_7f4747f1();
    function_40ec5f72();
    function_aee53978();
}

// Namespace mp_hacienda/mp_hacienda
// Params 4, eflags: 0x0
// Checksum 0xe1a8a512, Offset: 0x628
// Size: 0x113c
function function_757ba09a(var_f6609e00 = [], start_point, new_point, new_angles) {
    var_f6609e00[var_f6609e00.size] = "mp_t8_spawn_point";
    var_f6609e00[var_f6609e00.size] = "mp_t8_spawn_point_axis";
    var_f6609e00[var_f6609e00.size] = "mp_t8_spawn_point_allies";
    spawning::move_spawn_point(var_f6609e00, (-546.139, -3481.69, 0.125), (-534.474, -3482.86, 0.125), (0, 69.0656, 0));
    spawning::move_spawn_point(var_f6609e00, (-383.911, -3489.13, 0.125), (-397.392, -3509.62, 0.125), (0, 71.9, 0));
    spawning::move_spawn_point(var_f6609e00, (-309.879, -3418.52, 0.125), (-324.36, -3368.87, 0.125), (0, 82.1338, 0));
    spawning::move_spawn_point(var_f6609e00, (-435.379, -3374.84, 0.125), (-440.747, -3413.26, 0.125), (0, 71.9879, 0));
    spawning::move_spawn_point(var_f6609e00, (-548.22, -3306.93, 0.125), (-526.751, -3321.21, 0.125), (0, 72.3779, 0));
    spawning::move_spawn_point(var_f6609e00, (212.683, 3366.46, 63.125), (69.4544, 3466.02, 64.125), (0, -89.9231, 0));
    spawning::move_spawn_point(var_f6609e00, (78.8858, 3360.62, 64.125), (168.958, 3465.17, 64.125), (0, -89.9231, 0));
    spawning::move_spawn_point(var_f6609e00, (284.396, 3459.02, 64.125), (242.564, 3534.59, 63.2592), (0, -89.9231, 0));
    spawning::move_spawn_point(var_f6609e00, (8.41355, 3459.46, 63.125), (50.4212, 3590.39, 69.4695), (0, -91.2085, 0));
    spawning::move_spawn_point(var_f6609e00, (151.055, 3459.27, 64.125), (142.03, 3589.88, 64.125), (0, -91.2085, 0));
    spawning::move_spawn_point(var_f6609e00, (769.134, 2468.06, 64.125), (777.415, 2469.6, 64.125), (0, -123.349, 0));
    spawning::move_spawn_point(var_f6609e00, (1389.02, 3192.58, 24.4723), (1389.01, 3192.79, 25.1975), (0, -123.333, 0));
    spawning::move_spawn_point(var_f6609e00, (886.965, 3555.9, 64.125), (862.841, 3576.13, 72.125), (0, -97.8223, 0));
    spawning::move_spawn_point(var_f6609e00, (608, 3588, 63.125), (608, 3536.36, 63.125), (0, -90, 0));
    spawning::move_spawn_point(var_f6609e00, (17, 3464, 63.125), (24.184, 3582.37, 72.125), (0, -80.6506, 0));
    spawning::move_spawn_point(var_f6609e00, (-600.519, 2544.93, 0.125), (-609.151, 2549.95, 0.068054), (0, -54.9207, 0));
    spawning::move_spawn_point(var_f6609e00, (17, 3464, 63.125), (24.184, 3582.37, 72.125), (0, -80.6506, 0));
    spawning::move_spawn_point(var_f6609e00, (619.563, 2480.12, 64.125), (620, 2480, 64.125), (0, -119.048, 0));
    spawning::move_spawn_point(var_f6609e00, (-435, 2560.36, 0.068054), (-433.95, 2552.03, 0.068054), (0, -64.281, 0));
    spawning::move_spawn_point(var_f6609e00, (-779, 2336, 0.068054), (-764.122, 2340.74, 0.068054), (0, -84.2706, 0));
    spawning::move_spawn_point(var_f6609e00, (-895.818, 2176.7, 9.81101), (-869.418, 2214.45, 4.14755), (0, -75.8276, 0));
    spawning::move_spawn_point(var_f6609e00, (-741.919, 2551.25, 0.125), (-744.43, 2554.39, 0.068054), (0, -57.9968, 0));
    spawning::move_spawn_point(var_f6609e00, (-666.546, 1908.79, 1.92571), (-675.435, 1909.59, 0.801074), (0, -94.5374, 0));
    spawning::move_spawn_point(var_f6609e00, (-715.329, 2061.15, 0.125), (-716.518, 2058.52, -1.83754), (0, -99.8547, 0));
    spawning::move_spawn_point(var_f6609e00, (-948.916, 2099.58, 8.66024), (-948.944, 2099.92, 9.65468), (0, -70.9991, 0));
    spawning::move_spawn_point(var_f6609e00, (-64.5078, 1876.98, 0.125), (-65.7078, 1878.68, 0.125), (0, -39.8694, 0));
    spawning::move_spawn_point(var_f6609e00, (1165, 2284.36, 0.125), (1180.43, 2272.66, 0.125), (0, -132.083, 0));
    spawning::move_spawn_point(var_f6609e00, (31, 1908.36, 0.125), (129.312, 1941.24, 0.125), (0, -76.9922, 0));
    spawning::move_spawn_point(var_f6609e00, (-573.695, -0.78398, 128.125), (-592.917, -7.05933, 128.125), (0, -71.4935, 0));
    spawning::move_spawn_point(var_f6609e00, (-612, 116.359, 0.125), (-608.502, 106.391, 0.125), (0, -32.9315, 0));
    spawning::move_spawn_point(var_f6609e00, (-1135.23, 492.917, 0.528695), (-1152.14, 487.013, 0.232549), (0, -50.7733, 0));
    spawning::move_spawn_point(var_f6609e00, (337, 1380.36, 128.125), (353.247, 1359.06, 128.125), (0, -119.674, 0));
    spawning::move_spawn_point(var_f6609e00, (-573.695, -0.78398, 128.125), (-592.917, -7.05933, 128.125), (0, -71.4935, 0));
    spawning::move_spawn_point(var_f6609e00, (118, -476.74, -7.22087), (118, -477, -7.875), (0, 133, 0));
    spawning::move_spawn_point(var_f6609e00, (-108, -479.44, -6.32088), (-109.317, -479, -2.707), (0, 47.005, 0));
    spawning::move_spawn_point(var_f6609e00, (-121, 494.64, -3.92088), (-121, 494.54, -2.62089), (0, -46.0052, 0));
    spawning::move_spawn_point(var_f6609e00, (125, 496.44, -3.32087), (125, 495.74, -2.2209), (0, -133, 0));
    spawning::move_spawn_point(var_f6609e00, (-50.5774, -929.196, 0.125), (-38.2797, -933.033, 0.125), (0, 88.385, 0));
    spawning::move_spawn_point(var_f6609e00, (1481.77, -646.804, 64.125), (1482, -647, 64.125), (0, 116.169, 0));
    spawning::move_spawn_point(var_f6609e00, (282.258, 3570.54, 63.125), (282.59, 3527.65, 64.125), (0, -87.8796, 0));
    spawning::move_spawn_point(var_f6609e00, (-61.2318, 2581.08, 0.125), (-67.1656, 2596.34, 0.125), (0, -84.9408, 0));
    spawning::move_spawn_point(var_f6609e00, (12.055, 3350.56, 63.125), (10.2171, 3351, 68.3488), (0, -71.0046, 0));
    spawning::move_spawn_point(var_f6609e00, (891.434, 3419.73, 63.125), (897.071, 3475.01, 64.5861), (0, -109.836, 0));
    spawning::move_spawn_point(var_f6609e00, (620.855, -2684, 2.62104), (620.997, -2684, 2.62884), (0, 66.0004, 0));
    spawning::move_spawn_point(var_f6609e00, (265.735, -2740.6, 0.125), (266, -2741, 0.125), (0, 102.634, 0));
    spawning::move_spawn_point(var_f6609e00, (343.366, -2670.09, 0.125), (327.229, -2690.31, 0.125), (0, 121.866, 0));
    spawning::move_spawn_point(var_f6609e00, (297.469, -3096.25, 0.125), (296.495, -3148.59, 0.125), (0, 100.415, 0));
    spawning::move_spawn_point(var_f6609e00, (-537.795, -2887.54, 0.125), (-538, -2888, 0.125), (0, 49.5758, 0));
    spawning::move_spawn_point(var_f6609e00, (-817.977, -2080.03, 4.40089), (-817.961, -2080.04, 4.66649), (0, 70.0049, 0));
    spawning::move_spawn_point(var_f6609e00, (-853.967, -2575.2, 0.125), (-854, -2575, -0.522339), (0, 59.0021, 0));
    spawning::move_spawn_point(var_f6609e00, (1137.21, -249.623, 64.375), (1137, -250, 64.375), (0, 132.792, 0));
}

// Namespace mp_hacienda/mp_hacienda
// Params 0, eflags: 0x0
// Checksum 0xd969d368, Offset: 0x1770
// Size: 0x154
function on_game_playing() {
    array::delete_all(getentarray("sun_block", "targetname"));
    wait getdvarfloat(#"hash_205d729c5c415715", 0.3);
    level util::delay(1, undefined, &scene::play, "aib_vign_mp_hacienda_tiger_pacing_01");
    if (util::isfirstround()) {
        level util::delay(getdvarfloat(#"hash_187afb4d5f703a4a", 0.2), undefined, &scene::play, "p8_fxanim_mp_hacienda_helicopter_flyover_bundle", "Shot 2");
        exploder::stop_exploder("fxexp_sprinklers");
        level util::delay(1.5, undefined, &exploder::exploder, "fxexp_sprinklers");
        return;
    }
    exploder::exploder("fxexp_heli_leaves_idle");
}

// Namespace mp_hacienda/mp_hacienda
// Params 0, eflags: 0x0
// Checksum 0xdba74158, Offset: 0x18d0
// Size: 0x5e
function function_a272d512() {
    waitframe(1);
    exploder::exploder("fxexp_sprinklers");
    if (util::isfirstround()) {
        level thread scene::play("p8_fxanim_mp_hacienda_helicopter_flyover_bundle", "Shot 1");
        return;
    }
}

// Namespace mp_hacienda/mp_hacienda
// Params 0, eflags: 0x0
// Checksum 0x6365b509, Offset: 0x1938
// Size: 0x2b4
function function_7f4747f1() {
    a_s_buttons = struct::get_array("car_platform_button");
    var_99727424 = getent("car_platform", "targetname");
    var_3f6d1e5 = getent("car_platform_clip", "targetname");
    var_287711aa = getentarray("car_platform", "script_linkto");
    var_81ea683b = getentarray("car_platform_panel", "script_interact_group");
    var_99727424.var_c42a21af = getnodearray("car_platform_traverse", "targetname");
    var_3f6d1e5 linkto(var_99727424);
    var_3f6d1e5 disconnectpaths();
    foreach (var_b0a376a4 in var_99727424.var_c42a21af) {
        linktraversal(var_b0a376a4);
    }
    foreach (s_button in a_s_buttons) {
        s_button.mdl_gameobject.a_s_buttons = a_s_buttons;
        s_button.mdl_gameobject.var_99727424 = var_99727424;
        s_button.mdl_gameobject.var_81ea683b = var_81ea683b;
        level thread function_82d2973e(s_button.mdl_gameobject.var_81ea683b);
        s_button.mdl_gameobject gameobjects::set_onuse_event(&function_a580d02c);
    }
    array::run_all(var_287711aa, &linkto, var_99727424);
}

// Namespace mp_hacienda/mp_hacienda
// Params 1, eflags: 0x0
// Checksum 0xe64202c6, Offset: 0x1bf8
// Size: 0x29c
function function_a580d02c(e_activator) {
    array::thread_all(self.a_s_buttons, &gameobjects::disable_object);
    level thread function_82d2973e(self.var_81ea683b, "busy");
    foreach (var_b0a376a4 in self.var_99727424.var_c42a21af) {
        unlinktraversal(var_b0a376a4);
    }
    self.var_99727424 rotateyaw(360, getdvarfloat(#"hash_42b74e55d98810b6", 20));
    self.var_99727424 playsound("amb_car_platform_start");
    self.var_99727424 playloopsound("amb_car_platform_loop", 0.5);
    self.var_99727424 waittill(#"rotatedone");
    self.var_99727424 playsound("amb_car_platform_stop");
    self.var_99727424 stoploopsound(0.5);
    foreach (var_b0a376a4 in self.var_99727424.var_c42a21af) {
        linktraversal(var_b0a376a4);
    }
    wait getdvarfloat(#"hash_1760dea2c00cbd93", 5);
    level thread function_82d2973e(self.var_81ea683b);
    array::thread_all(self.a_s_buttons, &gameobjects::enable_object);
}

// Namespace mp_hacienda/mp_hacienda
// Params 0, eflags: 0x0
// Checksum 0x21db9ce0, Offset: 0x1ea0
// Size: 0x150
function function_40ec5f72() {
    a_exploders = array("fxexp_top_fountain_01", "");
    a_s_buttons = struct::get_array("fountain_button");
    var_81ea683b = getentarray("fountain_button_panel", "script_interact_group");
    foreach (s_button in a_s_buttons) {
        s_button.mdl_gameobject.a_s_buttons = a_s_buttons;
        s_button.mdl_gameobject.var_81ea683b = var_81ea683b;
        level thread function_82d2973e(s_button.mdl_gameobject.var_81ea683b);
        s_button.mdl_gameobject gameobjects::set_onuse_event(&function_920c62b1);
    }
}

// Namespace mp_hacienda/mp_hacienda
// Params 1, eflags: 0x0
// Checksum 0x9c39dadf, Offset: 0x1ff8
// Size: 0x224
function function_920c62b1(e_activator) {
    a_exploders = array("fxexp_top_fountain_01", "fxexp_top_fountain_02", "fxexp_top_fountain_03", "fxexp_top_fountain_04", "fxexp_fountain_jet_01", "fxexp_fountain_jet_02", "fxexp_fountain_jet_03", "fxexp_fountain_jet_04", "fxexp_fountain_jet_05", "fxexp_fountain_jet_06", "fxexp_fountain_jet_07", "fxexp_fountain_jet_08");
    array::thread_all(self.a_s_buttons, &gameobjects::disable_object);
    level thread function_82d2973e(self.var_81ea683b, "busy");
    for (i = 0; i < 5; i++) {
        foreach (str_exploder in a_exploders) {
            util::delay(randomfloat(0.6), undefined, &exploder::exploder, str_exploder);
        }
        wait 1.4;
    }
    wait getdvarfloat(#"hash_3201af3906143d06", 5) + 0.6;
    level thread function_82d2973e(self.var_81ea683b);
    array::thread_all(self.a_s_buttons, &gameobjects::enable_object);
}

// Namespace mp_hacienda/mp_hacienda
// Params 0, eflags: 0x0
// Checksum 0x923b656b, Offset: 0x2228
// Size: 0x2c0
function function_aee53978() {
    a_s_buttons = struct::get_array("hidden_door_button");
    a_mdl_doors = getentarray("hidden_door", "targetname");
    var_81ea683b = getentarray("hidden_room", "script_interact_group");
    array::thread_all(a_mdl_doors, &function_9a01f62f);
    foreach (s_button in a_s_buttons) {
        s_button.mdl_gameobject.a_s_buttons = a_s_buttons;
        s_button.mdl_gameobject.a_mdl_doors = a_mdl_doors;
        s_button.mdl_gameobject.var_81ea683b = var_81ea683b;
        level thread function_82d2973e(s_button.mdl_gameobject.var_81ea683b);
        s_button.mdl_gameobject gameobjects::set_onuse_event(&function_22ff2c2c);
    }
    foreach (mdl_door in a_mdl_doors) {
        s_open = struct::get(mdl_door.target);
        mdl_door.v_forward = s_open.angles;
        mdl_door.v_close = mdl_door.origin;
        mdl_door.var_ee4758e4 = s_open.origin + vectorscale(anglestoforward(mdl_door.v_forward) * -1, 2);
        mdl_door.var_949d1308 = 1;
        mdl_door disconnectpaths();
        if (true) {
            mdl_door thread function_2ac2a57e();
        }
    }
}

// Namespace mp_hacienda/mp_hacienda
// Params 1, eflags: 0x0
// Checksum 0x9c367ba7, Offset: 0x24f0
// Size: 0x114
function function_22ff2c2c(e_activator) {
    array::thread_all(self.a_s_buttons, &gameobjects::disable_object);
    level thread function_82d2973e(self.var_81ea683b, "busy");
    array::thread_all(self.a_mdl_doors, &function_2ac2a57e);
    array::wait_till(self.a_mdl_doors, "hidden_door_moved");
    wait getdvarfloat(#"hash_5b883b04d5499fd6", 5);
    level thread function_82d2973e(self.var_81ea683b);
    array::thread_all(self.a_s_buttons, &gameobjects::enable_object);
}

// Namespace mp_hacienda/mp_hacienda
// Params 0, eflags: 0x0
// Checksum 0xa5beaea, Offset: 0x2610
// Size: 0x206
function function_2ac2a57e() {
    var_949d1308 = self.var_949d1308;
    if (var_949d1308) {
        v_moveto = self.var_ee4758e4;
        self.var_949d1308 = 0;
        self connectpaths();
    } else {
        v_moveto = self.v_close + vectorscale(anglestoforward(self.v_forward) * -1, 2);
        self.var_949d1308 = 1;
        self disconnectpaths();
    }
    if (var_949d1308) {
        var_dc17fcd3 = self.origin + vectorscale(anglestoforward(self.v_forward) * -1, 2);
        self moveto(var_dc17fcd3, 0.75);
        self waittill(#"movedone");
    }
    self thread function_4f8d1fe7();
    self moveto(v_moveto, 1.2);
    str_sound = "amb_stone_door_open";
    if (self.script_side === 2) {
        str_sound = "amb_wood_door_open";
    }
    self playsound(str_sound);
    self waittill(#"movedone");
    if (!var_949d1308) {
        self moveto(self.v_close, 0.75);
        self waittill(#"movedone");
    }
    self notify(#"hidden_door_moved");
}

// Namespace mp_hacienda/mp_hacienda
// Params 0, eflags: 0x0
// Checksum 0xbdf87597, Offset: 0x2820
// Size: 0x80
function function_9a01f62f() {
    self endon(#"death");
    self.var_67ba89f5 = [];
    while (true) {
        waitresult = self waittill(#"grenade_stuck");
        if (isdefined(waitresult.projectile)) {
            array::add(self.var_67ba89f5, waitresult.projectile);
        }
    }
}

// Namespace mp_hacienda/mp_hacienda
// Params 0, eflags: 0x0
// Checksum 0x513b9c31, Offset: 0x28a8
// Size: 0xb0
function function_4f8d1fe7() {
    if (!isdefined(self.var_b733ac06)) {
        return;
    }
    foreach (var_55e2e87a in self.var_b733ac06) {
        if (!isdefined(var_55e2e87a)) {
            continue;
        }
        var_55e2e87a dodamage(500, self.origin, undefined, undefined, undefined, "MOD_EXPLOSIVE");
    }
}

// Namespace mp_hacienda/mp_hacienda
// Params 2, eflags: 0x0
// Checksum 0x584b65a7, Offset: 0x2960
// Size: 0x170
function function_82d2973e(a_models, var_1f8a1e54 = "use") {
    foreach (var_f99738d2 in a_models) {
        if (var_f99738d2.var_c86a0f82 == var_1f8a1e54) {
            if (var_f99738d2 ishidden()) {
                var_f99738d2 show();
            }
        }
    }
    waitframe(3);
    foreach (var_38574c99 in a_models) {
        if (var_38574c99.var_c86a0f82 != var_1f8a1e54) {
            if (!var_38574c99 ishidden()) {
                var_38574c99 hide();
            }
        }
    }
}

/#

    // Namespace mp_hacienda/mp_hacienda
    // Params 0, eflags: 0x0
    // Checksum 0xc17d4b01, Offset: 0x2ad8
    // Size: 0x74
    function init_devgui() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x3e>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x7d>");
    }

#/
