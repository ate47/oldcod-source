#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_offshore_fx;
#using scripts\mp\mp_offshore_sound;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\load;

#namespace mp_offshore;

// Namespace mp_offshore/level_init
// Params 1, eflags: 0x40
// Checksum 0xce6c5372, Offset: 0x3a0
// Size: 0x204
function event_handler[level_init] main(eventstruct) {
    callback::on_game_playing(&on_game_playing);
    callback::on_end_game(&on_end_game);
    globallogic_spawn::function_4410852b((3832.74, 3226.42, 2.02905), (0, 234.811, 0), "allies", "tdm");
    globallogic_spawn::function_4410852b((2551.55, -2823.51, 53.9418), (0, 77.0031, 0), "axis", "tdm");
    globallogic_spawn::function_4410852b((3832.74, 3226.42, 2.02905), (0, 234.811, 0), "allies", "conf");
    globallogic_spawn::function_4410852b((2551.55, -2823.51, 53.9418), (0, 77.0031, 0), "axis", "conf");
    mp_offshore_fx::main();
    mp_offshore_sound::main();
    load::main();
    compass::setupminimap("");
    setdvar(#"phys_buoyancy", 1);
    setdvar(#"phys_ragdoll_buoyancy", 1);
}

// Namespace mp_offshore/mp_offshore
// Params 0, eflags: 0x0
// Checksum 0x919879f9, Offset: 0x5b0
// Size: 0xfc
function on_game_playing() {
    array::delete_all(getentarray("sun_block", "targetname"));
    wait getdvarfloat(#"hash_205d729c5c415715", 0);
    util::delay(0.2, undefined, &function_4c2f006);
    level thread function_a9d6128b();
    if (util::isfirstround()) {
        util::delay(0.5, undefined, &function_f306891);
        return;
    }
    exploder::exploder("fxexp_tower_fire");
}

// Namespace mp_offshore/mp_offshore
// Params 0, eflags: 0x0
// Checksum 0xec953138, Offset: 0x6b8
// Size: 0x106
function on_end_game() {
    if (!isdefined(level.var_f825fb3f)) {
        level.var_f825fb3f = [];
    }
    foreach (scene in level.var_f825fb3f) {
        foreach (bundle in struct::get_array(scene, "scriptbundlename")) {
            bundle.barrage = 0;
        }
    }
}

// Namespace mp_offshore/mp_offshore
// Params 0, eflags: 0x0
// Checksum 0xe5bc1652, Offset: 0x7c8
// Size: 0xc8
function function_4c2f006() {
    var_a489d64f = array("p8_fxanim_mp_seaside_parrots_orange_flock_01_bundle", "p8_fxanim_mp_seaside_parrots_orange_flock_02_bundle", "p8_fxanim_mp_seaside_parrots_scarlet_flock_01_bundle", "p8_fxanim_mp_seaside_parrots_scarlet_flock_02_bundle", "p8_fxanim_mp_seaside_parrots_yellow_flock_01_bundle", "p8_fxanim_mp_seaside_parrots_yellow_flock_02_bundle");
    foreach (str_scene in var_a489d64f) {
        level thread scene::play(str_scene);
    }
}

// Namespace mp_offshore/mp_offshore
// Params 0, eflags: 0x0
// Checksum 0x9279820d, Offset: 0x898
// Size: 0x110
function function_a9d6128b() {
    level.var_f825fb3f = array("p8_fxanim_mp_offshore_artillery_volley_01_bundle", "p8_fxanim_mp_offshore_artillery_volley_02_bundle", "p8_fxanim_mp_offshore_artillery_volley_03_bundle", "p8_fxanim_mp_offshore_artillery_volley_04_bundle", "p8_fxanim_mp_offshore_artillery_volley_05_bundle", "p8_fxanim_mp_offshore_artillery_volley_06_bundle");
    level.var_f825fb3f = array::randomize(level.var_f825fb3f);
    foreach (scene in level.var_f825fb3f) {
        array::thread_all(struct::get_array(scene, "scriptbundlename"), &function_e711650a);
    }
}

// Namespace mp_offshore/mp_offshore
// Params 0, eflags: 0x0
// Checksum 0xb7fea618, Offset: 0x9b0
// Size: 0x98
function function_e711650a() {
    self.script_play_multiple = 1;
    self.barrage = 1;
    wait randomfloatrange(1, 10);
    while (self.barrage) {
        self scene::play();
        wait randomfloatrange(10, 20);
    }
}

// Namespace mp_offshore/mp_offshore
// Params 0, eflags: 0x0
// Checksum 0xc9356afb, Offset: 0xa50
// Size: 0x54
function function_f306891() {
    exploder::exploder("fxexp_tower_explosion");
    var_45fb3c83 = (2407.75, -2045.5, 68);
    playrumbleonposition("mp_offshore_tower_explosion", var_45fb3c83);
}

