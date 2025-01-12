#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_frenetic_fx;
#using scripts\mp\mp_frenetic_sound;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\load;

#namespace mp_frenetic;

// Namespace mp_frenetic/level_init
// Params 1, eflags: 0x40
// Checksum 0x27df760a, Offset: 0x1f8
// Size: 0x23c
function event_handler[level_init] main(eventstruct) {
    level.var_582c293f = 828;
    level.var_217ed544 = -3294;
    level.var_857af82 = 4500;
    level.var_719a5529 = 585;
    level.var_7a55d00e = -3316;
    level.var_2a5b90f0 = 585;
    level.var_580f865b = -3316;
    level.uav_z_offset = 800;
    callback::on_game_playing(&on_game_playing);
    globallogic_spawn::function_4410852b((765.163, -3147.5, 218.125), (0, 95.202, 0), "allies", "tdm");
    globallogic_spawn::function_4410852b((696.907, 3068.41, 218.125), (0, -93.2355, 0), "axis", "tdm");
    globallogic_spawn::function_4410852b((765.163, -3147.5, 218.125), (0, 95.202, 0), "allies", "conf");
    globallogic_spawn::function_4410852b((696.907, 3068.41, 218.125), (0, -93.2355, 0), "axis", "conf");
    mp_frenetic_fx::main();
    mp_frenetic_sound::main();
    load::main();
    compass::setupminimap("");
    function_a272d512();
    level thread function_d13c5975();
}

// Namespace mp_frenetic/mp_frenetic
// Params 0, eflags: 0x0
// Checksum 0x49bb259c, Offset: 0x440
// Size: 0x76
function function_d13c5975() {
    var_ff28117a = getentarray("rotate_model", "targetname");
    if (isdefined(var_ff28117a)) {
        for (i = 0; i < var_ff28117a.size; i++) {
            var_ff28117a[i] thread rotate();
        }
    }
}

// Namespace mp_frenetic/mp_frenetic
// Params 0, eflags: 0x0
// Checksum 0x7e1e075e, Offset: 0x4c0
// Size: 0xe2
function rotate() {
    if (!isdefined(self.speed)) {
        self.speed = 0.5;
    }
    while (true) {
        if (self.script_noteworthy == "z") {
            self rotateyaw(360, self.speed);
        } else if (self.script_noteworthy == "x") {
            self rotateroll(360, self.speed);
        } else if (self.script_noteworthy == "y") {
            self rotatepitch(360, self.speed);
        }
        wait self.speed - 0.1;
    }
}

// Namespace mp_frenetic/mp_frenetic
// Params 0, eflags: 0x0
// Checksum 0x171db48, Offset: 0x5b0
// Size: 0x1d4
function on_game_playing() {
    array::delete_all(getentarray("sun_block", "targetname"));
    wait getdvarfloat(#"hash_205d729c5c415715", 0.5);
    if (util::isfirstround()) {
        level scene::add_scene_func(#"p8_fxanim_mp_frenetic_flyaway_tarp_bundle", &function_4e0990b0);
        level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_bundle");
        level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_delay_01_bundle");
        level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_delay_02_bundle");
        level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_delay_03_bundle");
        level thread scene::play(#"p8_fxanim_mp_frenetic_vines_01_bundle");
        level thread scene::play(#"p8_fxanim_mp_frenetic_vines_02_bundle");
        level thread scene::play(#"p8_fxanim_mp_frenetic_vines_03_bundle");
        level thread scene::play(#"p8_fxanim_mp_frenetic_rock_slide_bundle");
        level thread scene::play(#"p8_fxanim_mp_frenetic_flyaway_tarp_bundle");
        return;
    }
    exploder::exploder("fxexp_wind_constant");
}

// Namespace mp_frenetic/mp_frenetic
// Params 1, eflags: 0x0
// Checksum 0x13ab1a2a, Offset: 0x790
// Size: 0xe4
function function_4e0990b0(a_ents) {
    if (isdefined(a_ents[#"prop 1"])) {
        var_575a4d41 = a_ents[#"prop 1"] gettagorigin("tarp_06_jnt") + (0, 0, -8);
        a_ents[#"prop 1"] endon(#"death");
        a_ents[#"prop 1"] waittill(#"physics_pulse");
        physicsexplosionsphere(var_575a4d41, 1024, 1, 1);
    }
}

// Namespace mp_frenetic/mp_frenetic
// Params 0, eflags: 0x0
// Checksum 0xba88a96c, Offset: 0x880
// Size: 0x33c
function function_a272d512() {
    if (util::isfirstround()) {
        level thread scene::init(#"p8_fxanim_mp_frenetic_flyaway_tarp_bundle");
        level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_bundle");
        level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_delay_01_bundle");
        level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_delay_02_bundle");
        level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_delay_03_bundle");
        level thread scene::init(#"p8_fxanim_mp_frenetic_vines_01_bundle");
        level thread scene::init(#"p8_fxanim_mp_frenetic_vines_02_bundle");
        level thread scene::init(#"p8_fxanim_mp_frenetic_vines_03_bundle");
        level thread scene::init(#"p8_fxanim_mp_frenetic_rock_slide_bundle");
        return;
    }
    array::thread_all(struct::get_array("p8_fxanim_mp_frenetic_solar_panels_bundle", "scriptbundlename"), &scene::play, #"p8_fxanim_mp_frenetic_solar_panels_idle_bundle");
    array::thread_all(struct::get_array("p8_fxanim_mp_frenetic_solar_panels_delay_01_bundle", "scriptbundlename"), &scene::play, #"p8_fxanim_mp_frenetic_solar_panels_delay_01_idle_bundle");
    array::thread_all(struct::get_array("p8_fxanim_mp_frenetic_solar_panels_delay_02_bundle", "scriptbundlename"), &scene::play, #"p8_fxanim_mp_frenetic_solar_panels_delay_02_idle_bundle");
    array::thread_all(struct::get_array("p8_fxanim_mp_frenetic_solar_panels_delay_03_bundle", "scriptbundlename"), &scene::play, #"p8_fxanim_mp_frenetic_solar_panels_delay_03_idle_bundle");
    level thread scene::skipto_end(#"p8_fxanim_mp_frenetic_vines_01_bundle", undefined, undefined, 1);
    level thread scene::skipto_end(#"p8_fxanim_mp_frenetic_vines_02_bundle", undefined, undefined, 1);
    level thread scene::skipto_end(#"p8_fxanim_mp_frenetic_vines_03_bundle", undefined, undefined, 1);
    level thread scene::skipto_end(#"p8_fxanim_mp_frenetic_rock_slide_bundle", undefined, undefined, 1);
    level thread scene::skipto_end(#"p8_fxanim_mp_frenetic_flyaway_tarp_bundle", undefined, undefined, 1);
}

