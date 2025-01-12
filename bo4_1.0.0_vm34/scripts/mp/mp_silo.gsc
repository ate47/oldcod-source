#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_silo_fx;
#using scripts\mp\mp_silo_sound;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\load;

#namespace mp_silo;

// Namespace mp_silo/level_init
// Params 1, eflags: 0x40
// Checksum 0xd115acd2, Offset: 0x220
// Size: 0x254
function event_handler[level_init] main(eventstruct) {
    level.var_582c293f = -4271;
    level.var_217ed544 = -8002;
    level.var_857af82 = 5500;
    level.var_719a5529 = -4271;
    level.var_7a55d00e = -8002;
    level.var_2a5b90f0 = -4271;
    level.var_580f865b = -8002;
    level.var_1c64b02a = 1200;
    level.uav_z_offset = 1200;
    callback::on_game_playing(&on_game_playing);
    globallogic_spawn::function_4410852b((-6099.22, -4137.8, 208.836), (0, -88.0499, 0), "allies", "tdm");
    globallogic_spawn::function_4410852b((-5986, -11686, 59.5659), (0, 92.005, 0), "axis", "tdm");
    globallogic_spawn::function_4410852b((-6099.22, -4137.8, 208.836), (0, -88.0499, 0), "allies", "conf");
    globallogic_spawn::function_4410852b((-5986, -11686, 59.5659), (0, 92.005, 0), "axis", "conf");
    mp_silo_fx::main();
    mp_silo_sound::main();
    /#
        init_devgui();
    #/
    load::main();
    compass::setupminimap("");
    function_a272d512();
    level thread init_gameobjects();
}

// Namespace mp_silo/mp_silo
// Params 0, eflags: 0x0
// Checksum 0xd3228ba2, Offset: 0x480
// Size: 0x228
function init_gameobjects() {
    level.var_8de6057e = getent("silo_moving_catwalk", "targetname");
    level.var_e67fe1cc = 0;
    level.var_b4e7021a = 0;
    for (i = 0; i < 3; i++) {
        nodename = "bridge_up_trav_" + i;
        node = getnode(nodename, "targetname");
        linktraversal(node);
    }
    a_s_gameobjects = struct::get_array("elevator_push_button", "targetname");
    foreach (var_dcf4cbb0 in a_s_gameobjects) {
        var_dcf4cbb0.mdl_gameobject.b_auto_reenable = 0;
        var_dcf4cbb0.var_e1c07c4b = a_s_gameobjects;
        level thread function_bd373c6d(var_dcf4cbb0);
    }
    var_638ced7a = getentarray("elevator_rail_guide", "targetname");
    foreach (var_f4f2bffb in var_638ced7a) {
        var_f4f2bffb linkto(level.var_8de6057e);
    }
}

// Namespace mp_silo/mp_silo
// Params 1, eflags: 0x0
// Checksum 0xc914b6a8, Offset: 0x6b0
// Size: 0x96
function function_bd373c6d(var_dcf4cbb0) {
    level endon(#"game_ended");
    while (true) {
        waitresult = var_dcf4cbb0.mdl_gameobject waittill(#"gameobject_end_use_player");
        e_player = waitresult.player;
        var_dcf4cbb0 thread function_ff907446(1);
        waitframe(1);
    }
}

// Namespace mp_silo/mp_silo
// Params 1, eflags: 0x0
// Checksum 0xbed03bf7, Offset: 0x750
// Size: 0x512
function function_ff907446(var_d1373dd8) {
    if (level.var_e67fe1cc) {
        return;
    }
    array::thread_all(self.var_e1c07c4b, &gameobjects::disable_object, 1);
    exploder::exploder("fxexp_catwalk_off");
    exploder::stop_exploder("fxexp_catwalk_on");
    var_9a3e1862 = level.var_8de6057e.origin;
    var_9a3e1862 = (var_9a3e1862[0], var_9a3e1862[1] - 272, var_9a3e1862[2]);
    physicsexplosionsphere(var_9a3e1862, 287, 0, 0.1);
    if (level.var_b4e7021a) {
        for (i = 0; i < 3; i++) {
            nodename = "bridge_low_trav_" + i;
            node = getnode(nodename, "targetname");
            unlinktraversal(node);
        }
        level.var_e67fe1cc = 1;
        neworigin = level.var_8de6057e.origin + (0, 0, 128);
        level.var_8de6057e moveto(neworigin, 2.5);
        level.var_8de6057e playsound("amb_silo_elev_start");
        level.var_8de6057e playloopsound("amb_silo_elev_loop");
        level.var_8de6057e waittill(#"movedone");
        level.var_8de6057e stoploopsound();
        level.var_8de6057e playsound("amb_silo_elev_stop");
        level.var_b4e7021a = 0;
        for (i = 0; i < 3; i++) {
            nodename = "bridge_up_trav_" + i;
            node = getnode(nodename, "targetname");
            linktraversal(node);
        }
    } else {
        for (i = 0; i < 3; i++) {
            nodename = "bridge_up_trav_" + i;
            node = getnode(nodename, "targetname");
            unlinktraversal(node);
        }
        level.var_e67fe1cc = 1;
        neworigin = level.var_8de6057e.origin + (0, 0, -128);
        level.var_8de6057e moveto(neworigin, 2.5);
        level.var_8de6057e playsound("amb_silo_elev_start");
        level.var_8de6057e playloopsound("amb_silo_elev_loop");
        level.var_8de6057e waittill(#"movedone");
        level.var_8de6057e stoploopsound();
        level.var_8de6057e playsound("amb_silo_elev_stop");
        level.var_b4e7021a = 1;
        for (i = 0; i < 3; i++) {
            nodename = "bridge_low_trav_" + i;
            node = getnode(nodename, "targetname");
            linktraversal(node);
        }
    }
    wait 5;
    array::thread_all(self.var_e1c07c4b, &gameobjects::enable_object, 1);
    exploder::exploder("fxexp_catwalk_on");
    exploder::stop_exploder("fxexp_catwalk_off");
    level.var_e67fe1cc = 0;
}

// Namespace mp_silo/mp_silo
// Params 0, eflags: 0x0
// Checksum 0xa1cf9c5e, Offset: 0xc70
// Size: 0x34
function function_a272d512() {
    if (util::isfirstround()) {
        level scene::init(#"p8_fxanim_mp_silo_helicopter_crash_bundle");
    }
}

// Namespace mp_silo/mp_silo
// Params 0, eflags: 0x0
// Checksum 0x4220f96a, Offset: 0xcb0
// Size: 0x20c
function on_game_playing() {
    array::delete_all(getentarray("sun_block", "targetname"));
    level flag::wait_till("first_player_spawned");
    wait getdvarfloat(#"hash_205d729c5c415715", 0);
    exploder::exploder("fxexp_alarm_lights");
    exploder::exploder("fxexp_catwalk_on");
    if (util::isfirstround()) {
        level util::delay(0.4, undefined, &function_47e08ca9);
        level util::delay(3, undefined, &scene::play, #"p8_fxanim_mp_silo_missle_deploy_bundle");
        level util::delay(0.2, undefined, &scene::play, #"p8_fxanim_mp_silo_helicopter_crash_bundle");
        level notify(#"hash_771bf8874446d6f6");
        level notify(#"hash_388057c56b2acf4c");
        return;
    }
    exploder::exploder("fxexp_globe_fire");
    waitframe(4);
    level scene::skipto_end(#"p8_fxanim_mp_silo_missle_deploy_bundle", undefined, undefined, 1);
    level scene::skipto_end(#"p8_fxanim_mp_silo_helicopter_crash_bundle", undefined, undefined, 1);
}

// Namespace mp_silo/mp_silo
// Params 0, eflags: 0x0
// Checksum 0xf69d841, Offset: 0xec8
// Size: 0x54
function function_47e08ca9() {
    exploder::exploder("fxexp_globe_explosion");
    var_45fb3c83 = (-5555.25, -5398.75, 20);
    playrumbleonposition("mp_silo_globe_explosion", var_45fb3c83);
}

/#

    // Namespace mp_silo/mp_silo
    // Params 0, eflags: 0x0
    // Checksum 0xa8f22872, Offset: 0xf28
    // Size: 0x74
    function init_devgui() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x3e>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x7d>");
    }

#/
