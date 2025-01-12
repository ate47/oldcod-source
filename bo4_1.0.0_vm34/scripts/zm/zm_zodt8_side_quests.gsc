#using scripts\core_common\aat_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm\zm_zodt8_pap_quest;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace namespace_7890c038;

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xe6b8889b, Offset: 0x500
// Size: 0xe4
function init() {
    init_fx();
    init_clientfields();
    init_flags();
    init_quests();
    level thread function_4582f49c();
    function_31b116ab();
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        function_ebbe283e();
        function_93ea6657();
        return;
    }
    level thread function_5aa4560b();
    level thread function_30f24459();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5f0
// Size: 0x4
function init_fx() {
    
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x12b2563b, Offset: 0x600
// Size: 0x304
function init_clientfields() {
    clientfield::register("scriptmover", "" + #"hash_7876f33937c8a764", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"safe_fx", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"flare_fx", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_2042191a7fc75994", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_2ec182fecae80e80", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_7b3de02b6d3084ab", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"portal_pass", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_1cf8b9339139c50d", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"car_fx", 1, 1, "int");
    clientfield::register("world", "" + #"hash_1166237b92466ac9", 1, 1, "int");
    clientfield::register("world", "" + #"fireworks_fx", 1, 2, "counter");
    clientfield::register("world", "" + #"crash_fx", 1, 1, "int");
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x25f7a4c, Offset: 0x910
// Size: 0xe4
function init_flags() {
    level flag::init(#"hash_2aaea7cd22f44712");
    level flag::init(#"hash_3799c8bb28e2f2f");
    level flag::init(#"activate_sea_walkers");
    level flag::init(#"hash_480b6b675a3076ec");
    level flag::init(#"hash_525ff2b2a2f7d97a");
    level flag::init(#"hash_f244999377a9081");
    level flag::init(#"hash_598d4e6af1cf4c39");
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xb7ae90f0, Offset: 0xa00
// Size: 0x6dc
function init_quests() {
    zm_sq::register(#"hash_634eee6c99fa32d6", #"step_1", #"hash_33e48ffbaa9e7729", &function_a9aff7d1, &function_b0ac4bea);
    zm_sq::register(#"hash_634eee6c99fa32d6", #"step_2", #"hash_33e48cfbaa9e7210", &function_9de248be, &function_7f9003cd);
    zm_sq::register(#"hash_634eee6c99fa32d6", #"step_3", #"hash_33e48dfbaa9e73c3", &function_6bf81ae7, &function_b2713d4);
    zm_sq::register(#"hash_634eee6c99fa32d6", #"step_4", #"hash_33e492fbaa9e7c42", &function_d6ecafa4, &function_e79c6f47);
    zm_sq::register(#"sea_walkers", #"step_1", #"sea_walkers_step_1", &sea_walkers_setup, &sea_walkers_cleanup);
    zm_sq::register(#"vomit_blade", #"step_1", #"vomit_blade_step_1", &vomit_blade_setup, &vomit_blade_cleanup);
    zm_sq::register(#"fishy_offering", #"step_1", #"hash_189536bc9c5850f1", &fishy_offering_step_1_setup, &fishy_offering_step_1_cleanup);
    zm_sq::register(#"fishy_offering", #"step_2", #"hash_189533bc9c584bd8", &fishy_offering_step_2_setup, &fishy_offering_step_2_cleanup);
    zm_sq::register(#"portal_pass", #"step_1", #"portal_pass_step_1", &portal_pass_step_1_setup, &portal_pass_step_1_cleanup);
    zm_sq::register(#"portal_pass", #"step_2", #"portal_pass_step_2", &portal_pass_step_2_setup, &portal_pass_step_2_cleanup);
    zm_sq::register(#"hash_68677a02650cad00", #"step_1", #"hash_4ba91dee7d31240b", &function_9df1908d, &function_c0d20e5e);
    zm_sq::register(#"hash_68677a02650cad00", #"step_2", #"hash_4ba91eee7d3125be", &function_dab43e6a, &function_c4fb8111);
    zm_sq::register(#"ships_engineer", #"step_1", #"ships_engineer_step_1", &ships_engineer_1_setup, &ships_engineer_1_cleanup);
    zm_sq::register(#"ships_engineer", #"step_2", #"ships_engineer_step_2", &ships_engineer_2_setup, &ships_engineer_2_cleanup);
    zm_sq::register(#"ships_engineer", #"step_3", #"ships_engineer_step_3", &ships_engineer_3_setup, &ships_engineer_3_cleanup);
    callback::on_disconnect(&on_disconnect);
    if (getdvarint(#"zm_ee_enabled", 0)) {
        level thread fireworks_show();
    }
    zm_sq::start(#"hash_634eee6c99fa32d6");
    zm_sq::start(#"sea_walkers");
    zm_sq::start(#"vomit_blade");
    zm_sq::start(#"fishy_offering");
    zm_sq::start(#"portal_pass");
    zm_sq::start(#"hash_68677a02650cad00");
    zm_sq::start(#"ships_engineer");
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xba13f6bb, Offset: 0x10e8
// Size: 0x74
function ships_engineer_1_setup(var_4df52d26) {
    if (!getdvarint(#"zm_debug_ee", 0)) {
        level waittill(#"pap_quest_complete");
    } else {
        level waittill(#"start_zombie_round_logic");
    }
    if (!var_4df52d26) {
        function_12a22bb2();
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x3a19689, Offset: 0x1168
// Size: 0x3c
function ships_engineer_1_cleanup(var_4df52d26, var_c86ff890) {
    if (var_4df52d26 || var_c86ff890) {
        level thread function_745b6765();
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x4dde8871, Offset: 0x11b0
// Size: 0xdc
function function_12a22bb2() {
    a_triggers = getentarray("ship_damage_watcher", "targetname");
    array::thread_all(a_triggers, &function_639594b2);
    array::wait_till(a_triggers, "trigger");
    level thread function_745b6765();
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x30>");
            println("<dev string:x30>");
        }
    #/
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x195f3864, Offset: 0x1298
// Size: 0x134
function function_639594b2() {
    s_fx = struct::get(self.target);
    self waittill(#"trigger", #"death");
    mdl_fx = util::spawn_model("tag_origin", s_fx.origin, (300, 180, 0));
    mdl_fx clientfield::set("" + #"hash_1cf8b9339139c50d", 1);
    level thread util::delete_on_death_or_notify(mdl_fx, #"hash_3a873ffa3efcd0cb", "" + #"hash_1cf8b9339139c50d");
    s_fx struct::delete();
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x883728f5, Offset: 0x13d8
// Size: 0x74
function ships_engineer_2_setup(var_4df52d26) {
    if (!var_4df52d26) {
        level thread function_7443c9be();
        level flag::wait_till(#"hash_f244999377a9081");
        return;
    }
    level flag::set(#"hash_f244999377a9081");
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0xdfa34bb6, Offset: 0x1458
// Size: 0x44
function ships_engineer_2_cleanup(var_4df52d26, var_c86ff890) {
    if (var_4df52d26 || var_c86ff890) {
        level flag::set(#"hash_f244999377a9081");
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xd989dcc3, Offset: 0x14a8
// Size: 0x286
function function_7443c9be() {
    level endon(#"hash_3a873ffa3efcd0cb");
    a_s_valves = array::randomize(struct::get_array(#"hash_7d0aef696381d47a"));
    var_ae07671b = [];
    for (i = 0; i < 6; i++) {
        var_ae07671b[i] = a_s_valves[i];
        exploder::exploder("exp_engine_warning_light_" + a_s_valves[i].script_int);
        /#
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                debugstar(a_s_valves[i].origin, 9999);
            }
        #/
    }
    while (true) {
        b_complete = 1;
        foreach (s_valve in a_s_valves) {
            if (isinarray(var_ae07671b, s_valve)) {
                if (!(isdefined(s_valve.mdl_valve.var_66b6d4bc) && s_valve.mdl_valve.var_66b6d4bc)) {
                    b_complete = 0;
                    break;
                }
                continue;
            }
            if (isdefined(s_valve.mdl_valve.var_66b6d4bc) && s_valve.mdl_valve.var_66b6d4bc) {
                b_complete = 0;
                break;
            }
        }
        if (b_complete) {
            level flag::set(#"hash_f244999377a9081");
        } else {
            level flag::clear(#"hash_f244999377a9081");
        }
        wait 1;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x8e97cbc3, Offset: 0x1738
// Size: 0x34
function ships_engineer_3_setup(var_4df52d26) {
    if (!var_4df52d26) {
        level flag::wait_till(#"hash_598d4e6af1cf4c39");
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x3fae2f7b, Offset: 0x1778
// Size: 0x54
function ships_engineer_3_cleanup(var_4df52d26, var_c86ff890) {
    level flag::set(#"hash_f244999377a9081");
    level flag::set(#"hash_598d4e6af1cf4c39");
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xfdf7d8ac, Offset: 0x17d8
// Size: 0x1de
function function_c3982d28(b_on = 1) {
    n_current = level.s_pap_quest.var_d6c419fd;
    for (i = 0; i < level.s_pap_quest.a_s_locations.size; i++) {
        level.s_pap_quest.var_d6c419fd = i;
        level.pap_machine = level.s_pap_quest.a_s_locations[i].unitrigger_stub.pap_machine;
        level.pap_machine.var_a8b34199 = b_on;
        if (b_on) {
            level.pap_machine.var_2066a653 = 5000;
            if (i !== n_current) {
                zodt8_pap_quest::function_29c316c0();
            }
            continue;
        }
        level.pap_machine.var_2066a653 = 2500;
        level.s_pap_quest.var_a58aed48 = level.s_pap_quest.a_s_locations[i];
        zodt8_pap_quest::function_2187d93b();
    }
    if (!b_on) {
        level.var_543d4469 = 1;
        level.s_pap_quest.var_d6c419fd = randomint(level.s_pap_quest.a_s_locations.size - 1);
        zodt8_pap_quest::function_29c316c0();
        level.var_543d4469 = 0;
        level.var_52e58148 = 0;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xd46d2088, Offset: 0x19c0
// Size: 0x22c
function function_30f24459() {
    mdl_lever = getent("break_the_glass", "targetname");
    s_trigger = spawnstruct();
    s_trigger.origin = mdl_lever.origin - (0, 0, 16);
    s_trigger zm_unitrigger::create();
    while (true) {
        waitresult = s_trigger waittill(#"trigger_activated");
        e_player = waitresult.e_who;
        mdl_lever rotatepitch(-120, 0.666);
        mdl_lever waittill(#"rotatedone");
        if (level flag::get(#"hash_f244999377a9081")) {
            level flag::set(#"hash_598d4e6af1cf4c39");
            if (isdefined(e_player)) {
                e_player zm_audio::create_and_play_dialog(#"engine_room", #"alarm");
            }
            break;
        }
        wait 5;
        mdl_lever rotatepitch(120, 3);
        mdl_lever waittill(#"rotatedone");
    }
    zm_unitrigger::unregister_unitrigger(s_trigger);
    s_trigger struct::delete();
    level clientfield::set("" + #"hash_1166237b92466ac9", 1);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x3dc7a1a6, Offset: 0x1bf8
// Size: 0x4e4
function function_745b6765() {
    var_252db9f0 = scene::get_active_scenes(#"p8_fxanim_zm_zod_engine_pistons_idle_01_bundle")[0].scene_ents;
    var_9735292b = scene::get_active_scenes(#"p8_fxanim_zm_zod_engine_pistons_idle_02_bundle")[0].scene_ents;
    var_f2a84ce6 = scene::get_active_scenes(#"p8_fxanim_zm_zod_engine_propeller_shafts_01_idle_bundle")[0].scene_ents;
    var_cca5d27d = scene::get_active_scenes(#"p8_fxanim_zm_zod_engine_propeller_shafts_02_idle_bundle")[0].scene_ents;
    scene::stop(#"p8_fxanim_zm_zod_engine_pistons_idle_01_bundle");
    scene::stop(#"p8_fxanim_zm_zod_engine_pistons_idle_02_bundle");
    scene::stop(#"p8_fxanim_zm_zod_engine_propeller_shafts_01_idle_bundle");
    scene::stop(#"p8_fxanim_zm_zod_engine_propeller_shafts_02_idle_bundle");
    level thread scene::play(#"p8_fxanim_zm_zod_skybox_bundle", "event_impact");
    level flag::wait_till(#"hash_598d4e6af1cf4c39");
    level.var_9b1767c1 = level.round_number + randomintrange(3, 5);
    for (i = 1; i <= 12; i++) {
        exploder::stop_exploder("exp_engine_warning_light_" + i);
    }
    exploder::exploder("exp_lgt_switchboard_gameplay");
    exploder::exploder("exp_lgt_switchboard_warning_redflash");
    exploder::exploder("exp_lgt_engine_warning_redflash");
    wait 1.5;
    level thread scene::play(#"p8_fxanim_zm_zod_engine_pistons_full_speed_01_bundle", var_252db9f0);
    level thread scene::play(#"p8_fxanim_zm_zod_engine_pistons_full_speed_02_bundle", var_9735292b);
    level thread scene::play(#"p8_fxanim_zm_zod_engine_propeller_shafts_01_fullspeed_bundle", var_f2a84ce6);
    level thread scene::play(#"p8_fxanim_zm_zod_engine_propeller_shafts_02_fullspeed_bundle", var_cca5d27d);
    level thread scene::play(#"p8_fxanim_zm_zod_skybox_bundle", "event_impact");
    level thread function_c3982d28();
    wait 30;
    level waittill(#"end_of_round");
    level waittill(#"start_of_round");
    exploder::stop_exploder("exp_lgt_switchboard_gameplay");
    exploder::stop_exploder("exp_lgt_switchboard_warning_redflash");
    exploder::stop_exploder("exp_lgt_engine_warning_redflash");
    scene::stop(#"p8_fxanim_zm_zod_engine_pistons_full_speed_01_bundle");
    scene::stop(#"p8_fxanim_zm_zod_engine_pistons_full_speed_02_bundle");
    scene::stop(#"p8_fxanim_zm_zod_engine_propeller_shafts_01_fullspeed_bundle");
    scene::stop(#"p8_fxanim_zm_zod_engine_propeller_shafts_02_fullspeed_bundle");
    level thread scene::play(#"p8_fxanim_zm_zod_engine_pistons_idle_01_bundle", var_252db9f0);
    level thread scene::play(#"p8_fxanim_zm_zod_engine_pistons_idle_02_bundle", var_9735292b);
    level thread scene::play(#"p8_fxanim_zm_zod_engine_propeller_shafts_01_idle_bundle", var_f2a84ce6);
    level thread scene::play(#"p8_fxanim_zm_zod_engine_propeller_shafts_02_idle_bundle", var_cca5d27d);
    level flag::clear(#"hash_598d4e6af1cf4c39");
    level thread function_c3982d28(0);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xc73df101, Offset: 0x20e8
// Size: 0x138
function function_5aa4560b() {
    level waittill(#"start_zombie_round_logic");
    a_mdl_valves = getentarray("belinskis_ghost", "targetname");
    a_s_locs = struct::get_array(#"hash_7d0aef696381d47a");
    foreach (s_loc in a_s_locs) {
        s_loc.in_zone = #"zone_engine";
        s_loc.mdl_valve = arraygetclosest(s_loc.origin, a_mdl_valves);
        s_loc zm_unitrigger::create("", 64, &function_a2ff146f);
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x20a3dd67, Offset: 0x2228
// Size: 0x18e
function function_a2ff146f() {
    self endon(#"death");
    function_3d250f19(self, 0.3);
    var_cf38d6ea = self.stub.related_parent;
    mdl_valve = var_cf38d6ea.mdl_valve;
    if (isdefined(mdl_valve.var_66b6d4bc) && mdl_valve.var_66b6d4bc) {
        n_mod = -1;
    } else {
        n_mod = 1;
    }
    if (var_cf38d6ea.script_int == 7 && !(isdefined(var_cf38d6ea.var_db6b5264) && var_cf38d6ea.var_db6b5264)) {
        self thread function_ef420d0e();
    }
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (!zm_utility::can_use(e_player)) {
            continue;
        }
        mdl_valve thread function_d793f372(n_mod);
        mdl_valve waittill(#"hash_21146570fad885f3");
        n_mod *= -1;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x3522257, Offset: 0x23c0
// Size: 0xe6
function function_d793f372(n_mod) {
    self rotatevelocity((20 * n_mod, 180 * n_mod, -20), 0.5);
    self waittill(#"rotatedone");
    self rotatevelocity((20 * n_mod, 180 * n_mod, 20), 0.5);
    self waittill(#"rotatedone");
    if (isdefined(self.var_66b6d4bc) && self.var_66b6d4bc) {
        self.var_66b6d4bc = 0;
    } else {
        self.var_66b6d4bc = 1;
    }
    self notify(#"hash_21146570fad885f3");
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x57d82bec, Offset: 0x24b0
// Size: 0xfc
function function_ef420d0e() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (!zm_utility::can_use(e_player)) {
            continue;
        }
        self.stub.related_parent.var_db6b5264 = 1;
        e_hand = getent("engine_room_arm", "targetname");
        if (isdefined(e_hand)) {
            e_hand physicslaunch(e_hand.origin, (0, 0, 1));
            wait 2;
            e_hand delete();
        }
        break;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x8c8c7d4f, Offset: 0x25b8
// Size: 0x84
function portal_pass_step_1_setup(var_758116d) {
    if (!var_758116d) {
        level flag::wait_till(#"pap_quest_complete");
        level.var_2782e65b = array::random(struct::get_array(#"hash_6e83252a55036eb5"));
        function_e53c984c();
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0xff4ed845, Offset: 0x2648
// Size: 0x7c
function portal_pass_step_1_cleanup(var_758116d, ended_early) {
    if (var_758116d || ended_early) {
        level.var_2782e65b = array::random(struct::get_array(#"hash_6e83252a55036eb5"));
        level thread function_b5e33d62();
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x3568c2f, Offset: 0x26d0
// Size: 0x28c
function function_e53c984c() {
    trigger = spawn("trigger_damage", level.var_2782e65b.origin, 0, 16, 16);
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            debugstar(level.var_2782e65b.origin, 50000, (1, 0.5, 0));
        }
    #/
    while (true) {
        s_result = trigger waittill(#"damage");
        var_4f6c321c = 0;
        if (isdefined(s_result.attacker) && isdefined(s_result.attacker.aat)) {
            var_3caea74a = getarraykeys(s_result.attacker.aat);
            if (isdefined(var_3caea74a)) {
                foreach (w_aat in var_3caea74a) {
                    if (w_aat === s_result.attacker getcurrentweapon()) {
                        var_4f6c321c = 1;
                        break;
                    }
                }
            }
        }
        if (isdefined(var_4f6c321c) && var_4f6c321c) {
            level.var_348602a3 = s_result.attacker;
            break;
        }
    }
    trigger delete();
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x41>");
            println("<dev string:x41>");
        }
    #/
    level thread function_b5e33d62();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xb6e89f9f, Offset: 0x2968
// Size: 0x2c
function portal_pass_step_2_setup(var_758116d) {
    if (!var_758116d) {
        level waittill(#"hash_3fe51713857b3c4");
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x1415de0c, Offset: 0x29a0
// Size: 0x42
function portal_pass_step_2_cleanup(var_758116d, ended_early) {
    if (ended_early) {
        function_823f11d();
    }
    level.var_2782e65b = undefined;
    level.var_348602a3 = undefined;
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xf7311b0e, Offset: 0x29f0
// Size: 0x56c
function function_b5e33d62() {
    if (!isdefined(level.var_348602a3)) {
        level.var_348602a3 = util::get_active_players()[0];
    }
    var_b0c8f5cd = util::spawn_model("tag_origin", level.var_2782e65b.origin + (0, 12, -2), level.var_2782e65b.angles);
    var_b0c8f5cd clientfield::set("" + #"portal_pass", 1);
    s_moveto = struct::get(level.var_2782e65b.target);
    wait 3;
    while (isdefined(s_moveto)) {
        if (!isdefined(s_moveto.n_time)) {
            s_moveto.n_time = 2;
        }
        var_b0c8f5cd moveto(s_moveto.origin, s_moveto.n_time);
        var_b0c8f5cd waittill(#"movedone");
        if (isdefined(s_moveto.script_teleport) && isalive(level.var_348602a3)) {
            s_moveto = struct::get(s_moveto.script_teleport);
            if (s_moveto.targetname === #"hash_a7644632e1952ad") {
                v_offset = (128, 0, 64);
                b_rail = 1;
            } else {
                v_offset = (20, 0, 60);
                var_b0c8f5cd clientfield::set("" + #"portal_pass", 2);
            }
            var_b0c8f5cd hide();
            s_result = level.var_348602a3 waittilltimeout(3.5, #"fasttravel_bought", #"disconnect");
            var_b0c8f5cd show();
            if (s_result._notify === #"fasttravel_bought" && isalive(level.var_348602a3)) {
                var_b0c8f5cd linkto(level.var_348602a3, "tag_origin", v_offset, (0, 90, 0));
                level.var_348602a3 waittill(#"fasttravel_over", #"disconnect");
                if (isdefined(b_rail) && b_rail) {
                    var_b0c8f5cd clientfield::set("" + #"portal_pass", 0);
                }
                util::wait_network_frame();
                var_b0c8f5cd unlink();
                var_b0c8f5cd.origin = level.var_348602a3.origin + (0, 0, 32);
                var_b0c8f5cd clientfield::set("" + #"portal_pass", 1);
                var_b0c8f5cd moveto(s_moveto.origin, 0.75);
                var_b0c8f5cd waittill(#"movedone");
            } else {
                function_217fa7a(var_b0c8f5cd);
                return;
            }
        }
        if (s_moveto.var_ef8c14b !== 1) {
            wait randomfloatrange(1, 2);
            if (!isalive(level.var_348602a3) || isdefined(level.var_348602a3) && distancesquared(level.var_348602a3.origin, var_b0c8f5cd.origin) > 65536) {
                function_217fa7a(var_b0c8f5cd);
                return;
            }
        }
        s_moveto = struct::get(s_moveto.target);
    }
    level notify(#"hash_3fe51713857b3c4");
    function_823f11d(var_b0c8f5cd);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x35667208, Offset: 0x2f68
// Size: 0xc4
function function_217fa7a(var_b0c8f5cd) {
    var_b0c8f5cd delete();
    level.var_348602a3 = undefined;
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x58>");
            println("<dev string:x58>");
        }
    #/
    level waittill(#"end_of_round", #"start_of_round");
    level thread function_e53c984c();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x7293ad3b, Offset: 0x3038
// Size: 0x254
function function_823f11d(var_ee385422) {
    self notify("5c4c6c3f3a615a70");
    self endon("5c4c6c3f3a615a70");
    s_loc = struct::get(#"hash_2b406c6248d8f47b");
    if (!isdefined(var_ee385422)) {
        var_ee385422 = util::spawn_model("tag_origin", s_loc.origin, s_loc.angles);
        var_ee385422 clientfield::set("" + #"portal_pass", 1);
    }
    var_ee385422 clientfield::set("" + #"portal_pass", 2);
    s_loc zm_unitrigger::function_b7e350e6();
    var_ee385422 clientfield::set("" + #"portal_pass", 0);
    foreach (player in util::get_active_players()) {
        player thread function_da434b51();
    }
    callback::on_connect(&function_da434b51);
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x77>");
            println("<dev string:x77>");
        }
    #/
    wait 5;
    var_ee385422 delete();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x6c5429e0, Offset: 0x3298
// Size: 0xee
function function_da434b51() {
    self endon(#"disconnect");
    self.var_9dcfe945 = 0;
    var_10645cae = 0;
    for (n_current_round = level.round_number; true; n_current_round = level.round_number) {
        s_result = level waittill(#"fasttravel_bought");
        if (s_result.player === self) {
            var_10645cae++;
            if (var_10645cae < 3) {
                continue;
            } else {
                self.var_9dcfe945 = undefined;
            }
        } else {
            continue;
        }
        level waittill(#"end_of_round");
        self.var_9dcfe945 = 0;
        var_10645cae = 0;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x9a7aca57, Offset: 0x3390
// Size: 0x458
function fishy_offering_step_1_setup(var_758116d) {
    a_spots = array::randomize(struct::get_array(#"hash_152bb6bdedef598a"));
    e_fish = getent("dead_offering", "targetname");
    e_fish val::set(#"fishy_offering", "takedamage", 1);
    e_fish val::set(#"fishy_offering", "allowdeath", 0);
    foreach (spot in a_spots) {
        e_fish.origin = spot.origin;
        e_fish.angles = spot.angles;
        wait 1;
        e_fish show();
        while (true) {
            s_result = e_fish waittill(#"damage");
            if (isplayer(s_result.attacker) && (util::getweaponclass(s_result.weapon) === #"weapon_sniper" || util::getweaponclass(s_result.weapon) === #"weapon_tactical")) {
                s_result.attacker util::show_hit_marker();
                s_landing = struct::get(spot.target);
                var_3bcc5fde = 360 / s_landing.n_move_time;
                var_309084e4 = 270 / s_landing.n_move_time;
                e_fish moveto(s_landing.origin, s_landing.n_move_time, s_landing.n_move_time * 0.5, 0.1);
                e_fish rotatevelocity((var_3bcc5fde, var_3bcc5fde, var_309084e4), s_landing.n_move_time);
                e_fish waittill(#"movedone");
                if (s_landing.var_4bcfa85 === 1 && level flag::get(#"water_drained_aft")) {
                    fx::play(#"hash_708765aa3f48456d", s_landing.origin + (0, 0, 20), (270, 180, 180));
                }
                s_landing.origin += (0, 0, 48);
                e_activator = s_landing zm_unitrigger::function_b7e350e6();
                e_activator zm_audio::create_and_play_dialog(#"fish", #"retrieve_first");
                s_landing struct::delete();
                e_fish hide();
                break;
            }
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x93831138, Offset: 0x37f0
// Size: 0x5c
function fishy_offering_step_1_cleanup(var_758116d, ended_early) {
    e_fish = getent("dead_offering", "targetname");
    if (isdefined(e_fish)) {
        e_fish delete();
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xf8b5d139, Offset: 0x3858
// Size: 0x174
function fishy_offering_step_2_setup(var_758116d) {
    s_trigger = struct::get(#"hash_693bda099c0710af");
    e_activator = s_trigger zm_unitrigger::function_b7e350e6();
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x8d>");
            println("<dev string:x8d>");
        }
    #/
    showmiscmodels("dead_offering");
    s_scene = struct::get(s_trigger.target);
    scene::add_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &function_b30d3738);
    s_scene scene::play();
    if (isalive(e_activator)) {
        e_activator zm_audio::create_and_play_dialog(#"fish", #"reward_comp");
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x5281ac95, Offset: 0x39d8
// Size: 0x14
function fishy_offering_step_2_cleanup(var_758116d, ended_early) {
    
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x62f54d20, Offset: 0x39f8
// Size: 0x14c
function function_b30d3738(a_ents) {
    if (self.targetname === #"offering_scene") {
        scene::remove_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &function_b30d3738);
        mdl_kraken = a_ents[#"hash_3712f07fe0e1166c"];
        mdl_kraken hide();
        wait 1.5;
        zm_powerups::specific_powerup_drop(#"free_perk", struct::get(#"hash_693bda099c0710af").origin + (0, 0, 16), undefined, undefined, undefined, 1);
        if (isdefined(mdl_kraken)) {
            mdl_kraken delete();
        }
        function_4582f49c();
        hidemiscmodels("dead_start");
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x89c3e233, Offset: 0x3b50
// Size: 0x3c
function function_4582f49c() {
    level flag::wait_till(#"water_initialized");
    hidemiscmodels("dead_offering");
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x30fd542a, Offset: 0x3b98
// Size: 0x12c
function sea_walkers_setup(var_758116d) {
    level.var_499428f9 = [];
    a_mdls = getentarray("underwater_objects", "script_noteworthy");
    foreach (mdl in a_mdls) {
        mdl thread function_731013c2();
    }
    level waittill(#"power_on");
    struct::get(#"hash_7de555271928a1f4") zm_unitrigger::create(undefined, undefined, &function_456eef10);
    level flag::wait_till(#"activate_sea_walkers");
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x9346c72f, Offset: 0x3cd0
// Size: 0x14
function sea_walkers_cleanup(var_758116d, ended_early) {
    
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xd1cb4530, Offset: 0x3cf0
// Size: 0x542
function function_731013c2() {
    self val::set(#"sea_walkers", "takedamage", 1);
    self val::set(#"sea_walkers", "allowdeath", 1);
    s_landing = struct::get(self.target);
    while (true) {
        s_result = self waittill(#"damage");
        if (isplayer(s_result.attacker)) {
            s_result.attacker util::show_hit_marker();
            if (s_landing.targetname === #"hash_79a6bca2dc90a00a") {
                v_offset = (0, 0, -6);
                var_390575e7 = (s_landing.angles[0] - self.angles[0]) / s_landing.n_move_time;
                var_f349014c = (s_landing.angles[1] - self.angles[1]) / s_landing.n_move_time;
                var_84df5b3d = (s_landing.angles[2] - self.angles[2]) / s_landing.n_move_time;
            } else {
                v_offset = (0, 0, 0);
                var_390575e7 = (s_landing.angles[0] - self.angles[0] + 360) / s_landing.n_move_time;
                var_f349014c = (s_landing.angles[1] - self.angles[1] + 360) / s_landing.n_move_time;
                var_84df5b3d = (s_landing.angles[2] - self.angles[2] + 360) / s_landing.n_move_time;
            }
            if (s_landing.targetname === #"post_end") {
                var_f349014c = (s_landing.angles[1] - self.angles[1]) / s_landing.n_move_time;
                var_84df5b3d = (s_landing.angles[2] - self.angles[2]) / s_landing.n_move_time;
            }
            self moveto(s_landing.origin + v_offset, s_landing.n_move_time, s_landing.n_move_time * 0.5, 0.1);
            self rotatevelocity((var_390575e7, var_f349014c, var_84df5b3d), s_landing.n_move_time);
            self waittill(#"movedone");
            if (isdefined(s_landing.target)) {
                str_targetname = s_landing.target;
                s_landing struct::delete();
                s_landing = struct::get(str_targetname);
                self.angles -= (360, 360, 360);
                continue;
            }
            s_landing.origin += (0, 0, 32);
            s_landing zm_unitrigger::function_b7e350e6();
            s_loc = struct::get(self.targetname + "_final");
            if (!isdefined(level.var_499428f9)) {
                level.var_499428f9 = [];
            } else if (!isarray(level.var_499428f9)) {
                level.var_499428f9 = array(level.var_499428f9);
            }
            level.var_499428f9[level.var_499428f9.size] = self;
            self hide();
            self.origin = s_loc.origin;
            self.angles = s_loc.angles;
            s_landing struct::delete();
            s_loc struct::delete();
            return;
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xae9bd4e8, Offset: 0x4240
// Size: 0x1c0
function function_456eef10() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (!zm_utility::can_use(e_player) || level flag::get(#"hash_480b6b675a3076ec")) {
            continue;
        }
        foreach (var_4c424457 in level.var_499428f9) {
            var_4c424457 show();
        }
        if (level flag::get(#"boss_fight_started") && !level flag::get(#"hash_25d8c88ff3f91ee5")) {
            continue;
        }
        if (level.var_499428f9.size >= 3 && (!isdefined(level.var_157e4db3) || level.var_157e4db3 + 9 <= level.round_number)) {
            level thread function_f237a472();
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x81087b34, Offset: 0x4408
// Size: 0x134
function function_f237a472() {
    level flag::set(#"hash_480b6b675a3076ec");
    var_2340e13a = struct::get(#"floaters_fx");
    playrumbleonposition("grenade_rumble", var_2340e13a.origin);
    level waittill(#"start_of_round");
    level flag::set(#"activate_sea_walkers");
    exploder::exploder("exp_eye_glow");
    level.var_157e4db3 = level.round_number;
    level waittill(#"end_of_round");
    level flag::clear(#"activate_sea_walkers");
    level flag::clear(#"hash_480b6b675a3076ec");
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xb346789d, Offset: 0x4548
// Size: 0xa0
function function_ebbe283e() {
    a_mdls = getentarray("underwater_objects", "script_noteworthy");
    foreach (mdl in a_mdls) {
        mdl hide();
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xb15d1fd7, Offset: 0x45f0
// Size: 0xcc
function function_a9aff7d1(var_4df52d26) {
    level.var_5b78a1a8 = getent("mdl_sf_cr", "targetname");
    function_784f900f();
    if (!var_4df52d26) {
        var_f0ecc1e1 = struct::get(level.var_5b78a1a8.target);
        var_4a2986ab = getent(level.var_5b78a1a8.target, "targetname");
        level.var_5b78a1a8 function_78f8c5ad(var_4a2986ab, var_f0ecc1e1);
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x727bdf9f, Offset: 0x46c8
// Size: 0x7a
function function_b0ac4bea(var_4df52d26, var_c86ff890) {
    if (var_c86ff890) {
        if (isdefined(level.var_5b78a1a8.s_unitrigger)) {
            zm_unitrigger::unregister_unitrigger(level.var_5b78a1a8.s_unitrigger);
        }
        level.var_5b78a1a8 hide();
        level.var_afd110b = 1;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x29e43be6, Offset: 0x4750
// Size: 0x202
function function_78f8c5ad(var_4a2986ab, var_f0ecc1e1) {
    self endon(#"death");
    var_4a2986ab function_26dc3063();
    n_move_time = var_f0ecc1e1.var_534e2438;
    self moveto(var_f0ecc1e1.origin, n_move_time, n_move_time);
    self rotateto(var_f0ecc1e1.angles, n_move_time);
    self waittill(#"movedone");
    self playsound(#"hash_6df06ef021cd1a4");
    s_unitrigger = self zm_unitrigger::create();
    zm_unitrigger::function_3fc5694(s_unitrigger, s_unitrigger.origin + (0, 0, 32), s_unitrigger.angles);
    e_activator = self waittill(#"trigger_activated");
    if (isalive(e_activator)) {
        e_activator zm_audio::create_and_play_dialog(#"safecracker", #"pick_up");
    }
    self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
    self hide();
    self playsound(#"hash_54d18476ea0d7d0d");
    level.var_afd110b = 1;
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x1ef72aac, Offset: 0x4960
// Size: 0xcc
function function_26dc3063() {
    w_shield = getweapon(#"zhield_dw");
    for (var_5515fb65 = 1; var_5515fb65; var_5515fb65 = 0) {
        waitresult = self waittill(#"damage", #"death");
        if (waitresult._notify == "death") {
            return;
        }
        if (waitresult.weapon == w_shield && waitresult.mod == #"mod_melee") {
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x4a0cfd10, Offset: 0x4a38
// Size: 0x278
function function_9de248be(var_4df52d26) {
    if (!var_4df52d26) {
        while (level flag::get(#"hash_2aaea7cd22f44712") == 0) {
            level.var_51cbc551 = 0;
            level.var_ca69a9c1 = 0;
            foreach (s_safe in level.a_s_safes) {
                s_safe thread function_2fad55eb();
            }
            level waittill(#"hash_543e0c29db385264");
            if (level.var_ca69a9c1 == 4) {
                level flag::set(#"hash_2aaea7cd22f44712");
                continue;
            }
            level waittill(#"start_of_round");
            foreach (mdl_bone in level.a_mdl_bones) {
                mdl_bone.origin = mdl_bone.original_origin;
                mdl_bone.angles = mdl_bone.original_angles;
                mdl_bone.b_taken = 0;
            }
            foreach (s_safe in level.a_s_safes) {
                s_safe.var_8cf273a9 clientfield::set("" + #"safe_fx", 0);
                s_safe.mdl_bone = undefined;
            }
            function_d7314431();
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x6de701bf, Offset: 0x4cb8
// Size: 0x120
function function_7f9003cd(var_4df52d26, var_c86ff890) {
    foreach (s_safe in level.a_s_safes) {
        if (isdefined(s_safe.var_4a2986ab)) {
            s_safe.var_4a2986ab delete();
        }
    }
    foreach (mdl_bone in level.a_mdl_bones) {
        if (isdefined(mdl_bone)) {
            mdl_bone delete();
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xf7e0856f, Offset: 0x4de0
// Size: 0xa0
function function_93ea6657() {
    var_c390c936 = getentarray("mdl_bone", "targetname");
    foreach (mdl_bone in var_c390c936) {
        mdl_bone delete();
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x612521e9, Offset: 0x4e88
// Size: 0x1aa
function function_784f900f() {
    level.a_mdl_bones = array::randomize(getentarray("mdl_bone", "targetname"));
    foreach (mdl_bone in level.a_mdl_bones) {
        mdl_bone bone_init();
        mdl_bone thread function_177759f6();
    }
    level.a_s_safes = array::randomize(struct::get_array(#"s_safe"));
    foreach (s_safe in level.a_s_safes) {
        s_safe safe_init();
    }
    function_d7314431();
    level.var_afd110b = 0;
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xda2a730b, Offset: 0x5040
// Size: 0x1ba
function function_d7314431() {
    var_eda15de4 = array(4250, 2340, 1404, 1912);
    for (i = 0; i < 4; i++) {
        n_index = randomint(var_eda15de4.size);
        var_6b681475 = var_eda15de4[n_index];
        arrayremoveindex(var_eda15de4, n_index);
        level.a_s_safes[i].var_6b681475 = var_6b681475;
        level.a_mdl_bones[i].var_6b681475 = var_6b681475;
        foreach (var_36e03974 in level.a_mdl_bones[i].var_72b5207) {
            if (var_36e03974.var_64f75ce0 == var_6b681475) {
                var_36e03974.mdl_number = util::spawn_model(var_36e03974.model, var_36e03974.origin, var_36e03974.angles);
                var_36e03974.mdl_number setscale(0.1);
            }
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x9a11b5c9, Offset: 0x5208
// Size: 0xc6
function bone_init() {
    self.original_origin = self.origin;
    self.original_angles = self.angles;
    self.var_72b5207 = [];
    a_structs = struct::get_array(self.target);
    foreach (struct in a_structs) {
        self.var_72b5207[self.var_72b5207.size] = struct;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xe11974f0, Offset: 0x52d8
// Size: 0x204
function function_177759f6() {
    s_unitrigger = self zm_unitrigger::create();
    zm_unitrigger::function_7fcb11a8(s_unitrigger);
    self.b_taken = 0;
    while (level flag::get(#"hash_2aaea7cd22f44712") == 0) {
        waitresult = self waittill(#"trigger_activated", #"death");
        if (waitresult._notify == "death") {
            break;
        }
        e_player = waitresult.e_who;
        if (isdefined(e_player.mdl_bone)) {
            if (e_player.mdl_bone == self) {
                self.origin = self.original_origin;
                self.angles = self.original_angles;
                self show();
                e_player.mdl_bone = undefined;
                self.b_taken = 0;
            }
            continue;
        }
        if (!self.b_taken) {
            self hide();
            self playsound(#"hash_3c18e9f6d0adb140");
            e_player.mdl_bone = self;
            self.b_taken = 1;
            /#
                if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                    iprintlnbold(self.var_6b681475);
                    println(self.var_6b681475);
                }
            #/
        }
    }
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xc865b968, Offset: 0x54e8
// Size: 0x1f6
function safe_init() {
    self.var_72b5207 = [];
    a_structs = struct::get_array(self.target);
    foreach (struct in a_structs) {
        switch (struct.script_noteworthy) {
        case #"hash_64d97c9325649850":
            self.var_72b5207[self.var_72b5207.size] = struct;
            break;
        case #"hash_238372761f11df6b":
            self.var_f0ecc1e1 = struct;
            break;
        case #"hash_1a561aa9a8506230":
            self.var_e51ec3d6 = struct;
            break;
        }
    }
    a_ents = getentarray(self.target, "targetname");
    foreach (ent in a_ents) {
        if (ent getentitytype() == 6) {
            self.var_8cf273a9 = ent;
            continue;
        }
        if (ent getentitytype() == 20) {
            self.var_4a2986ab = ent;
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x7c4751cc, Offset: 0x56e8
// Size: 0x8ec
function function_2fad55eb() {
    s_unitrigger = self zm_unitrigger::create();
    zm_unitrigger::function_3fc5694(s_unitrigger, self.origin + (0, 0, 32));
    self.var_949d1308 = 1;
    while (!isdefined(self.mdl_bone)) {
        waitresult = self waittill(#"trigger_activated");
        e_player = waitresult.e_who;
        if (self.var_949d1308) {
            if (level.var_afd110b) {
                level.var_5b78a1a8.origin = self.origin;
                level.var_5b78a1a8.angles = self.angles;
                level.var_5b78a1a8 linkto(self.var_8cf273a9);
                level.var_5b78a1a8 show();
                playsoundatposition(#"hash_674add1cacda8f0a", level.var_5b78a1a8.origin);
                level.var_5b78a1a8 playloopsound(#"hash_648b3ad720f4123", 0.1);
                wait 2;
                playsoundatposition(#"hash_d47a6b375de9091", level.var_5b78a1a8.origin);
                level.var_5b78a1a8 stoploopsound(0.05);
                foreach (var_36e03974 in self.var_72b5207) {
                    if (var_36e03974.var_64f75ce0 === self.var_6b681475) {
                        var_36e03974.mdl_number = util::spawn_model(var_36e03974.model, var_36e03974.origin, var_36e03974.angles);
                        var_36e03974.mdl_number setscale(0.25);
                        var_36e03974.mdl_number linkto(self.var_8cf273a9);
                    }
                }
                /#
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold(self.var_6b681475);
                        println(self.var_6b681475);
                    }
                #/
                wait 1;
                self.var_8cf273a9 rotateyaw(90, 0.25, 0.25);
                self.var_8cf273a9 playsound(#"zmb_safe_open");
                self.var_8cf273a9 waittill(#"rotatedone");
                self.var_8cf273a9 playloopsound(#"hash_11a6234e1396e816");
                level.var_afd110b = 0;
                self.var_949d1308 = 0;
                if (isalive(e_player)) {
                    e_player zm_audio::create_and_play_dialog(#"safe", #"unlock");
                }
            }
            continue;
        }
        if (isdefined(e_player.mdl_bone)) {
            switch (e_player.mdl_bone.script_noteworthy) {
            case #"hash_5ad0ab56d2f3de45":
            case #"hash_5bc743a34601a467":
                v_dest = self.var_e51ec3d6.origin;
                e_player.mdl_bone.angles = self.var_e51ec3d6.angles;
                break;
            case #"hash_722b90f757b1aa44":
                v_dest = self.var_e51ec3d6.origin + (0, 0, 0.5);
                e_player.mdl_bone.angles = self.var_e51ec3d6.angles;
                break;
            case #"hash_6ff7ee89f7487974":
                v_dest = self.var_e51ec3d6.origin + (0, 0, 1);
                e_player.mdl_bone.angles = self.var_e51ec3d6.angles + (0, -45, -90);
                break;
            }
            v_forward = anglestoforward(self.var_e51ec3d6.angles);
            e_player.mdl_bone.origin = v_dest + v_forward * 16;
            e_player.mdl_bone show();
            e_player.mdl_bone moveto(v_dest, 1.5, 1);
            e_player.mdl_bone playsound(#"hash_383e684a50e2025f");
            e_player.mdl_bone waittill(#"movedone");
            wait 1;
            self.var_8cf273a9 rotateyaw(-90, 0.25, 0.25);
            self.var_8cf273a9 playsound(#"hash_1a6dadbf4537bb61");
            self.var_8cf273a9 stoploopsound(0.5);
            self.var_8cf273a9 waittill(#"rotatedone");
            level.var_5b78a1a8 unlink();
            foreach (var_36e03974 in self.var_72b5207) {
                if (isdefined(var_36e03974.mdl_number)) {
                    var_36e03974.mdl_number delete();
                }
            }
            self.mdl_bone = e_player.mdl_bone;
            e_player.mdl_bone = undefined;
        }
    }
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
    self.var_8cf273a9 clientfield::set("" + #"safe_fx", 1);
    level.var_51cbc551++;
    if (level.var_51cbc551 == 4) {
        level notify(#"hash_543e0c29db385264");
    }
    if (self.mdl_bone.var_6b681475 == self.var_6b681475) {
        level.var_ca69a9c1++;
    }
    waitframe(1);
    if (level flag::get(#"hash_2aaea7cd22f44712") == 0) {
        level.var_5b78a1a8 thread function_78f8c5ad(self.var_4a2986ab, self.var_f0ecc1e1);
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xf67f073d, Offset: 0x5fe0
// Size: 0x72
function on_disconnect() {
    mdl_bone = self.mdl_bone;
    if (isdefined(mdl_bone)) {
        mdl_bone.origin = mdl_bone.original_origin;
        mdl_bone.angles = mdl_bone.original_angles;
        mdl_bone show();
        mdl_bone.b_taken = 0;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xeb794ed3, Offset: 0x6060
// Size: 0x15c
function function_6bf81ae7(var_4df52d26) {
    if (isdefined(level.var_5b78a1a8)) {
        level.var_5b78a1a8 thread util::function_a8daf6be(30);
    }
    if (!var_4df52d26) {
        while (!isdefined(level.var_f25c1c2a[#"zblueprint_shield_dual_wield"]) || level.var_f25c1c2a[#"zblueprint_shield_dual_wield"].completed !== 1) {
            /#
                if (getdvarint(#"zm_debug_ee", 0)) {
                    break;
                }
            #/
            wait 3;
        }
        function_d1551ed6();
        s_loc = struct::get(#"hash_43dc57b8641ea004");
        s_loc zm_unitrigger::create(undefined, undefined, &zm_unitrigger::function_d59c1914);
        s_loc thread function_8ab7324();
        level flag::wait_till(#"hash_3799c8bb28e2f2f");
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x286fbd00, Offset: 0x61c8
// Size: 0x14
function function_b2713d4(var_4df52d26, var_c86ff890) {
    
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x86ae841a, Offset: 0x61e8
// Size: 0xac
function function_31b116ab() {
    s_loc = struct::get(#"hash_43dc57b8641ea004");
    level.var_bf5d7534 = getent(s_loc.target, "targetname");
    level.var_bf5d7534 hide();
    getent("portal_block", "targetname") hide();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x74f95985, Offset: 0x62a0
// Size: 0x130
function function_d1551ed6() {
    level.var_bf5d7534.origin += (0, 0, 100 * -1);
    waitframe(0);
    e_block = getent("portal_block", "targetname");
    e_block show();
    e_block moveto(e_block.origin + (0, 0, 12), 1);
    level.var_bf5d7534 show();
    level.var_bf5d7534 moveto(level.var_bf5d7534.origin + (0, 0, 100), 5);
    level.var_bf5d7534 waittill(#"movedone");
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x754baa31, Offset: 0x63d8
// Size: 0x3b6
function function_8ab7324() {
    mdl_car = getent(level.var_bf5d7534.var_a12a72b3, "targetname");
    v_origin = mdl_car.origin;
    v_angles = mdl_car.angles;
    e_portal = getent("portal_block", "targetname");
    while (true) {
        waitresult = self waittill(#"trigger_activated");
        e_player = waitresult.e_who;
        if (!zm_utility::can_use(e_player)) {
            continue;
        }
        e_player util::delay(2, "death", &zm_audio::create_and_play_dialog, #"skeleton_car", #"interact");
        exploder::exploder("exp_bubbles_sink");
        mdl_car moveto(mdl_car.origin + (0, 0, -128), 9);
        mdl_car playsound(#"hash_3749463f3dab5c50");
        mdl_car playloopsound(#"hash_6ab30aa83cfad114", 0.1);
        level.var_bf5d7534 moveto(level.var_bf5d7534.origin + (0, 0, -128), 9);
        mdl_car waittill(#"movedone");
        mdl_car stoploopsound(0.1);
        mdl_car.angles = (0, 0, 0);
        mdl_car.var_6c047702 = array(#"red", #"green", #"blue");
        exploder::stop_exploder("exp_bubbles_sink");
        wait 5;
        function_ef796dbc(mdl_car);
        if (!level flag::get(#"hash_3799c8bb28e2f2f")) {
            level waittill(#"end_of_round");
            mdl_car.origin = v_origin + (0, 0, -128);
            mdl_car.angles = v_angles;
            mdl_car moveto(mdl_car.origin - (0, 0, -128), 9);
            level.var_bf5d7534 moveto(level.var_bf5d7534.origin - (0, 0, -128), 9);
            mdl_car waittill(#"movedone");
            continue;
        }
        return;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x26137f94, Offset: 0x6798
// Size: 0x37c
function function_ef796dbc(mdl_car) {
    n_start_round = level.round_number;
    veh_car = spawner::simple_spawn_single(getent("veh_fasttravel_cam", "targetname"));
    mdl_car.origin = veh_car.origin;
    mdl_car linkto(veh_car);
    nd_start = getvehiclenode("jones_start_node", "targetname");
    mdl_car clientfield::set("" + #"car_fx", 1);
    while (n_start_round + 3 > level.round_number && !level flag::get(#"hash_3799c8bb28e2f2f")) {
        /#
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x9f>");
                println("<dev string:x9f>");
            }
        #/
        mdl_car playsound(#"hash_785ac4e15d8585c4");
        mdl_car.var_15570acb = 1;
        mdl_car playloopsound(#"hash_58eb809a42974bb0", 0.1);
        veh_car vehicle::get_on_and_go_path(nd_start);
        mdl_car stoploopsound(0.1);
        mdl_car notify(#"reached_end_node");
        mdl_car.var_15570acb = 0;
        level waittill(#"start_of_round");
        if (!isdefined(mdl_car.var_6c047702)) {
            mdl_car.var_6c047702 = array(#"red", #"green", #"blue");
        }
    }
    mdl_car notify(#"car_reset");
    mdl_car clientfield::set("" + #"car_fx", 0);
    mdl_car unlink();
    veh_car delete();
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:xb5>");
            println("<dev string:xb5>");
        }
    #/
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x82b00a4d, Offset: 0x6b20
// Size: 0x44
function function_d6ecafa4(var_4df52d26) {
    if (!var_4df52d26) {
        function_daaaacdd();
        function_e76fd13();
        function_8dac83d6();
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x608d9154, Offset: 0x6b70
// Size: 0x7c
function function_e79c6f47(var_4df52d26, var_c86ff890) {
    if (isdefined(level.var_bf5d7534)) {
        level.var_bf5d7534 delete();
        level.var_bf5d7534 = undefined;
    }
    getent("portal_block", "targetname") delete();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x1726248f, Offset: 0x6bf8
// Size: 0x44
function function_69def1c9() {
    level waittill(#"hash_4c84b8326097daf6");
    wait 4;
    playsoundatposition(#"hash_5515ce05a0767859", (0, 0, 0));
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x1c238ba8, Offset: 0x6c48
// Size: 0x1f4
function function_daaaacdd() {
    level thread function_69def1c9();
    mdl_car = getent(level.var_bf5d7534.var_a12a72b3, "targetname");
    if (isdefined(mdl_car) && isdefined(mdl_car.var_15570acb) && mdl_car.var_15570acb) {
        mdl_car waittill(#"reached_end_node");
    }
    level clientfield::set("" + #"crash_fx", 1);
    mdl_car playsound(#"hash_7beb8c1c8eed903d");
    wait 0.5;
    v_loc = struct::get(#"hash_27613769597daaf0").origin;
    foreach (player in util::get_active_players()) {
        if (player util::is_looking_at(v_loc)) {
            b_vo_played = player zm_audio::create_and_play_dialog(#"car", #"crash");
            if (b_vo_played) {
                return;
            }
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x394dfb6b, Offset: 0x6e48
// Size: 0x194
function function_e76fd13() {
    s_loc = struct::get(#"hash_27613769597daaf0");
    mdl_shield = util::spawn_model(#"p8_zm_zod_ice_chunk_lrg_01", s_loc.origin);
    mdl_shield clientfield::set("" + #"hash_7b3de02b6d3084ab", 1);
    var_5ac337c6 = spawner::simple_spawn_single(getent("veh_fasttravel_cam", "targetname"));
    mdl_shield.origin = var_5ac337c6.origin;
    mdl_shield linkto(var_5ac337c6);
    nd_start = getvehiclenode("shield_start_spot", "targetname");
    var_5ac337c6 vehicle::get_on_and_go_path(nd_start);
    mdl_shield playsound(#"hash_4e75eec96f7ea36a");
    mdl_shield delete();
    var_5ac337c6 delete();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xfafbe8d, Offset: 0x6fe8
// Size: 0x27c
function function_8dac83d6() {
    exploder::exploder("exp_lgt_crafting_alt");
    mdl_shield = getent("shield_model", "targetname");
    if (isdefined(mdl_shield)) {
        mdl_shield clientfield::set("" + #"hash_2ec182fecae80e80", 1);
    }
    var_61be8cac = level.var_1c7ed52c[#"zblueprint_shield_dual_wield"];
    foreach (struct in var_61be8cac) {
        if (struct.script_noteworthy === #"shield_table") {
            var_6e6cce91 = zm_crafting::function_ad17f25(#"hash_125de658ffc6703c");
            struct.craftfoundry = var_6e6cce91;
            struct.blueprint = var_6e6cce91;
            break;
        }
    }
    foreach (player in util::get_active_players()) {
        player aat::acquire(getweapon(#"zhield_frost_dw"), "zm_aat_frostbite");
        player thread function_19374ae2();
    }
    callback::on_connect(&function_99794997);
    callback::on_spawned(&function_19374ae2);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x611ec98e, Offset: 0x7270
// Size: 0xbe
function function_19374ae2() {
    w_frost_shield = getweapon(#"zhield_frost_dw");
    while (true) {
        s_result = self waittill(#"hash_77d44943fb143b18", #"death");
        if (s_result._notify === #"hash_77d44943fb143b18" && s_result.weapon === w_frost_shield) {
            self aat::acquire(w_frost_shield, "zm_aat_frostbite");
            continue;
        }
        return;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xea71126c, Offset: 0x7338
// Size: 0x74
function function_99794997() {
    while (isdefined(self) && self util::is_spectating()) {
        wait 1;
    }
    if (isdefined(self)) {
        self aat::acquire(getweapon(#"zhield_frost_dw"), "zm_aat_frostbite");
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xe6653acc, Offset: 0x73b8
// Size: 0x2c4
function fireworks_show() {
    level endon(#"end_game");
    level.a_s_launchers = struct::get_array(#"s_launcher");
    foreach (s_launcher in level.a_s_launchers) {
        s_launcher.var_6d77f62c = struct::get(s_launcher.target);
        s_launcher flag::init(#"hash_2078d5bf94139877");
        s_unitrigger = s_launcher zm_unitrigger::create(undefined, undefined, &use_launcher);
        zm_unitrigger::function_3fc5694(s_unitrigger, s_unitrigger.origin + (0, 0, 32));
        zm_unitrigger::function_7fcb11a8(s_unitrigger);
    }
    level.var_6ebdcb3e = struct::get_array(#"hash_4f342e0539cf25df");
    level.var_782ce0df = struct::get_array(#"hash_499aa18783aee42a");
    level.var_82f8032 = array(#"red", #"green", #"blue");
    while (true) {
        level waittill(#"start_of_round");
        foreach (s_launcher in level.a_s_launchers) {
            s_launcher flag::clear(#"hash_2078d5bf94139877");
        }
        while (level.var_82f8032.size > 0) {
            function_4988e31c();
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x9a79f66a, Offset: 0x7688
// Size: 0x1b4
function function_4988e31c() {
    n_index = randomint(level.var_6ebdcb3e.size);
    var_f5950967 = level.var_6ebdcb3e[n_index];
    arrayremoveindex(level.var_6ebdcb3e, n_index);
    n_index = randomint(level.var_82f8032.size);
    str_color = level.var_82f8032[n_index];
    arrayremoveindex(level.var_82f8032, n_index);
    mdl_flare = init_flare(var_f5950967.origin + (0, 0, -8), var_f5950967.angles, str_color);
    mdl_flare moveto(var_f5950967.origin, 0.2);
    mdl_flare waittill(#"movedone");
    n_index = randomint(level.var_782ce0df.size);
    var_cce2dbc = level.var_782ce0df[n_index];
    arrayremoveindex(level.var_782ce0df, n_index);
    mdl_flare thread function_afa5f864(var_f5950967, var_cce2dbc);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 3, eflags: 0x0
// Checksum 0x88302194, Offset: 0x7848
// Size: 0x178
function init_flare(v_origin, v_angles, str_color) {
    switch (str_color) {
    case #"green":
        str_model = #"hash_4b39204d5b5304a";
        break;
    case #"blue":
        str_model = #"hash_8d291e1ec7d99af";
        break;
    default:
        str_model = #"p8_zm_zod_lifeboat_equipment_flare";
        break;
    }
    mdl_flare = util::spawn_model(str_model, v_origin, v_angles);
    mdl_flare setscale(0.8);
    mdl_flare val::set(#"mdl_flare", "allowdeath", 0);
    mdl_flare val::set(#"mdl_flare", "takedamage", 1);
    mdl_flare.str_color = str_color;
    mdl_flare flag::init(#"hash_2078d5bf94139877");
    return mdl_flare;
}

/#

    // Namespace namespace_7890c038/zm_zodt8_side_quests
    // Params 1, eflags: 0x0
    // Checksum 0x6fc61b53, Offset: 0x79c8
    // Size: 0x114
    function give_flare(str_color) {
        foreach (player in util::get_active_players()) {
            mdl_flare = init_flare((0, 0, 0), (0, 0, 0), str_color);
            player.mdl_flare = mdl_flare;
        }
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold(str_color + "<dev string:xbf>");
            println(str_color + "<dev string:xbf>");
        }
    }

#/

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0xac1f7912, Offset: 0x7ae8
// Size: 0x462
function function_afa5f864(var_f5950967, var_cce2dbc) {
    level endon(#"end_game");
    self endon(#"death");
    waitresult = self waittill(#"damage");
    if (isplayer(waitresult.attacker)) {
        waitresult.attacker util::show_hit_marker();
    }
    self moveto(self.origin + (0, 0, 8), 0.35);
    self playsound(#"hash_33fa1a9c8d819b09");
    self waittill(#"movedone");
    self hide();
    wait randomintrange(5, 10);
    self.origin = var_cce2dbc.origin;
    self.angles = var_cce2dbc.angles;
    self show();
    s_dest = struct::get(var_cce2dbc.target);
    self moveto(s_dest.origin, 0.35);
    self playsound(#"hash_43c5172452b852a5");
    self waittill(#"movedone");
    s_unitrigger = s_dest zm_unitrigger::create(&use_flare, 128);
    zm_unitrigger::function_7fcb11a8(s_unitrigger);
    waitresult = s_dest waittill(#"trigger_activated");
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
    level.var_6ebdcb3e[level.var_6ebdcb3e.size] = var_f5950967;
    level.var_782ce0df[level.var_782ce0df.size] = var_cce2dbc;
    /#
        switch (self.str_color) {
        case #"red":
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:xdb>");
                println("<dev string:xdb>");
            }
            break;
        case #"green":
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:xef>");
                println("<dev string:xef>");
            }
            break;
        case #"blue":
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x105>");
                println("<dev string:x105>");
            }
            break;
        }
    #/
    self playsound(#"hash_bf7d2ff0e430576");
    self hide();
    waitresult.e_who.mdl_flare = self;
    level.var_82f8032[level.var_82f8032.size] = self.str_color;
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x44588f19, Offset: 0x7f58
// Size: 0x48
function use_flare(e_player) {
    if (!zm_utility::can_use(e_player) || isdefined(e_player.mdl_flare)) {
        return 0;
    }
    return 1;
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xd58304bb, Offset: 0x7fa8
// Size: 0x1c2
function use_launcher() {
    level endon(#"end_game");
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (zm_utility::can_use(e_player) && isdefined(e_player.mdl_flare)) {
            mdl_flare = e_player.mdl_flare;
            struct = self.stub.related_parent;
            mdl_flare setscale(1.1);
            mdl_flare.origin = struct.origin;
            mdl_flare.angles = struct.angles;
            mdl_flare show();
            if (isdefined(struct.mdl_flare)) {
                struct.mdl_flare delete();
            }
            struct.mdl_flare = mdl_flare;
            mdl_flare.s_launcher = struct;
            playsoundatposition(#"hash_1cedcfe708cf2627", mdl_flare.s_launcher.origin);
            mdl_flare thread function_3c3fb9c3();
            e_player.mdl_flare = undefined;
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x68838cc6, Offset: 0x8178
// Size: 0x2aa
function function_3c3fb9c3() {
    level endon(#"end_game");
    self endoncallback(&function_8fde469f, #"death");
    v_offset = (0, 0, -8);
    self.trigger = spawn("trigger_damage", self.origin + v_offset, 0, 2.5, 24.5);
    while (true) {
        waitresult = self.trigger waittill(#"trigger");
        if (isplayer(waitresult.activator)) {
            self.s_launcher flag::set(#"hash_2078d5bf94139877");
            var_6833bc36 = 0;
            foreach (s_launcher in level.a_s_launchers) {
                if (s_launcher flag::get(#"hash_2078d5bf94139877")) {
                    var_6833bc36++;
                }
            }
            if (var_6833bc36 == 4 && level.var_dc2b72d4 !== 1) {
                level.var_dc2b72d4 = 1;
                foreach (s_launcher in level.a_s_launchers) {
                    level thread function_bbb7a4bd(s_launcher.mdl_flare);
                }
                level thread function_41e0447d();
            } else {
                level thread function_bbb7a4bd(self);
            }
            self.trigger delete();
            return;
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x2abbf97b, Offset: 0x8430
// Size: 0x3c
function function_8fde469f(s_result) {
    if (isdefined(self) && isdefined(self.trigger)) {
        self.trigger delete();
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xd6ae980b, Offset: 0x8478
// Size: 0x1fc
function function_bbb7a4bd(mdl_flare) {
    mdl_flare endon(#"hash_714cd031b5f28ab8", #"death");
    var_81dbb8b5 = init_flare(mdl_flare.origin, mdl_flare.angles, mdl_flare.str_color);
    mdl_flare.s_launcher.mdl_flare = var_81dbb8b5;
    var_81dbb8b5.s_launcher = mdl_flare.s_launcher;
    var_81dbb8b5 setscale(1.1);
    var_81dbb8b5 hide();
    var_81dbb8b5 thread function_f4c6308d();
    if (mdl_flare ishidden()) {
        mdl_flare show();
    }
    mdl_flare moveto(mdl_flare.s_launcher.var_6d77f62c.origin, 2);
    mdl_flare playsound(#"hash_7cccfcd334265ea5");
    mdl_flare thread function_fb559c95();
    mdl_flare flare_fx(mdl_flare.str_color);
    mdl_flare playsound(#"hash_3abb70f0e8764ecc");
    mdl_flare ghost();
    wait 5;
    mdl_flare delete();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xff6a7223, Offset: 0x8680
// Size: 0x3bc
function function_fb559c95() {
    if (isdefined(level.var_bf5d7534)) {
        mdl_car = getent(level.var_bf5d7534.var_a12a72b3, "targetname");
    } else {
        return;
    }
    while (isdefined(self) && isdefined(mdl_car)) {
        if (self istouching(mdl_car) || getdvarint(#"hash_7919e37cd5d57659", 0)) {
            self notify(#"hash_714cd031b5f28ab8");
            self.origin = mdl_car.origin;
            self linkto(mdl_car);
            switch (self.str_color) {
            case #"red":
                self clientfield::set("" + #"hash_2042191a7fc75994", 1);
                break;
            case #"green":
                self clientfield::set("" + #"hash_2042191a7fc75994", 2);
                break;
            case #"blue":
                self clientfield::set("" + #"hash_2042191a7fc75994", 3);
                break;
            }
            if (isdefined(mdl_car.var_6c047702) && mdl_car.var_6c047702[0] === self.str_color) {
                arrayremoveindex(mdl_car.var_6c047702, 0);
                /#
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x11a>" + self.str_color);
                        println("<dev string:x11a>" + self.str_color);
                    }
                #/
                self playsound(#"hash_5a8158d766d5258b");
                if (!mdl_car.var_6c047702.size) {
                    level flag::set(#"hash_3799c8bb28e2f2f");
                }
            } else {
                mdl_car.var_6c047702 = undefined;
                self playsound(#"hash_1ecef41176c39335");
                /#
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x12e>");
                        println("<dev string:x12e>");
                    }
                #/
            }
            break;
        }
        waitframe(1);
    }
    if (isdefined(mdl_car)) {
        mdl_car waittill(#"car_reset", #"death");
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x47cb359, Offset: 0x8a48
// Size: 0x74
function function_f4c6308d() {
    level endon(#"end_game");
    self endon(#"death");
    wait 30 - 2;
    self show();
    self function_3c3fb9c3();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x5f3155d3, Offset: 0x8ac8
// Size: 0x12c
function flare_fx(str_color) {
    level endon(#"end_game");
    switch (str_color) {
    case #"red":
        self clientfield::set("" + #"flare_fx", 1);
        break;
    case #"green":
        self clientfield::set("" + #"flare_fx", 2);
        break;
    case #"blue":
        self clientfield::set("" + #"flare_fx", 3);
        break;
    }
    wait 2;
    self clientfield::set("" + #"flare_fx", 0);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xf724ec9a, Offset: 0x8c00
// Size: 0x1ae
function function_41e0447d() {
    level endon(#"end_game");
    wait 2;
    exploder::exploder("fx_exp_flare_vista_red_white_blue");
    var_172e52ba = [];
    foreach (s_launcher in level.a_s_launchers) {
        if (isdefined(s_launcher.mdl_flare)) {
            var_172e52ba[var_172e52ba.size] = s_launcher.mdl_flare.str_color;
        }
    }
    level thread fireworks_vo();
    for (i = 0; i < 50; i++) {
        str_color = var_172e52ba[randomint(var_172e52ba.size)];
        fireworks_fx(str_color);
        wait randomfloatrange(0.1, 0.25);
    }
    level waittill(#"start_of_round");
    level.var_dc2b72d4 = undefined;
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x19e28629, Offset: 0x8db8
// Size: 0x170
function fireworks_vo() {
    a_players = util::get_active_players();
    a_zones = array("zone_forecastle_upper", "zone_forecastle_lower", "zone_fore_deck", "zone_poop_deck", "zone_poop_deck_lower", "zone_mid_deck", "zone_fore_deck", "zone_sun_deck_stbd", "zone_sun_deck_port", "zone_aft_deck_lower", "zone_aft_deck");
    foreach (player in a_players) {
        if (isdefined(player)) {
            if (player zm_zonemgr::is_player_in_zone(a_zones)) {
                b_result = player zm_audio::create_and_play_dialog(#"fireworks", #"react");
                if (b_result) {
                    wait randomintrange(3, 6);
                }
            }
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xf5d4677f, Offset: 0x8f30
// Size: 0xfa
function fireworks_fx(str_color) {
    switch (str_color) {
    case #"red":
        level clientfield::increment("" + #"fireworks_fx", 1);
        break;
    case #"green":
        level clientfield::increment("" + #"fireworks_fx", 2);
        break;
    case #"blue":
        level clientfield::increment("" + #"fireworks_fx", 3);
        break;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x408cbab7, Offset: 0x9038
// Size: 0xbc
function vomit_blade_setup(var_4df52d26) {
    zm_melee_weapon::init(#"hash_6a9069969e6fa287", "bowie_flourish", "knife_ballistic_bowie", "knife_ballistic_bowie_upgraded", undefined, "bowie_upgrade", undefined, "bowie", undefined);
    zm_melee_weapon::set_fallback_weapon(#"bowie_knife", "zombie_fists_bowie");
    zm_loadout::register_melee_weapon_for_level(#"hash_6a9069969e6fa287");
    callback::on_ai_damage(&function_77adb47);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0x9433b969, Offset: 0x9100
// Size: 0x5c
function vomit_blade_cleanup(var_4df52d26, var_c86ff890) {
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            level flag::set(#"hash_525ff2b2a2f7d97a");
        }
    #/
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x78aabfd5, Offset: 0x9168
// Size: 0x344
function function_52d006a7(params) {
    if (isalive(self) && self.archetype === "zombie" && params.weapon === getweapon(#"hash_6a9069969e6fa287")) {
        player = params.eattacker;
        if (isalive(player) && isplayer(player)) {
            var_85e492e3 = randomintrange(20000, 30000);
            n_time = gettime();
            if (isdefined(player.var_e8c227e6) && player.var_e8c227e6 + var_85e492e3 > n_time) {
                return;
            }
            player util::delay(0.5, "death", &zm_audio::create_and_play_dialog, #"vomit_knife", #"attack");
            player.var_e8c227e6 = n_time;
            self ai::stun();
            v_origin = self gettagorigin("tag_eye");
            v_angles = self gettagangles("tag_eye");
            var_db08b883 = anglestoup(v_angles);
            v_down = v_origin + var_db08b883 * -5;
            mdl_fx = util::spawn_model("tag_origin", v_origin, v_angles);
            mdl_fx linkto(self, "tag_eye", v_down - v_origin, (60, 0, 90));
            mdl_fx clientfield::set("" + #"hash_7876f33937c8a764", 1);
            while (isdefined(self) && self ai::is_stunned()) {
                waitframe(1);
            }
            if (isdefined(self)) {
                self kill(self.origin, player, player, getweapon(#"hash_6a9069969e6fa287"));
            }
            wait 1;
            mdl_fx delete();
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xe8356f86, Offset: 0x94b8
// Size: 0x2bc
function function_77adb47(params) {
    if (level flag::get(#"hash_525ff2b2a2f7d97a")) {
        self thread function_52d006a7(params);
    }
    if (isdefined(self) && self.archetype === "blight_father") {
        w_bowie = getweapon(#"bowie_knife");
        if (params.weapon === w_bowie) {
            player = params.eattacker;
            if (isalive(player) && isplayer(player)) {
                if (!isdefined(self.var_cadcc636)) {
                    self.var_cadcc636 = [];
                } else if (!isarray(self.var_cadcc636)) {
                    self.var_cadcc636 = array(self.var_cadcc636);
                }
                self.var_cadcc636[self.var_cadcc636.size] = player;
                if (!isdefined(player.var_b71262dc)) {
                    player.var_b71262dc = 0;
                }
                player.var_b71262dc++;
                if (player.var_b71262dc >= 9 && !player hasweapon(getweapon(#"hash_6a9069969e6fa287"))) {
                    /#
                        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                            iprintlnbold("<dev string:x143>");
                            println("<dev string:x143>");
                        }
                    #/
                    player zm_melee_weapon::award_melee_weapon(#"hash_6a9069969e6fa287");
                    level flag::set(#"hash_525ff2b2a2f7d97a");
                    player util::delay(0.5, "death", &zm_audio::create_and_play_dialog, #"vomit_knife", #"mod_react");
                }
            }
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xbc7e879e, Offset: 0x9780
// Size: 0x1cc
function function_9df1908d(var_4df52d26) {
    a_s_pianos = struct::get_array(#"ivory_number");
    foreach (s_piano in a_s_pianos) {
        s_piano thread function_1ab86e9a();
    }
    var_478d6140 = getentarray("sheet_sound_place", "targetname");
    foreach (var_134245e9 in var_478d6140) {
        var_134245e9 thread function_f4188f7b();
    }
    level waittill(#"start_of_round");
    level thread function_dab43e6a();
    util::waittill_multiple_ents(a_s_pianos[0], #"hash_2de28171d87b35cf", a_s_pianos[1], #"hash_2de28171d87b35cf", a_s_pianos[2], #"hash_2de28171d87b35cf");
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x88fd9692, Offset: 0x9958
// Size: 0x10c
function function_f4188f7b() {
    self endon(#"death");
    s_unitrigger = self zm_unitrigger::create(undefined, 48, &function_2af41f2f);
    if (isdefined(self.target)) {
        s_trigger_pos = struct::get(self.target);
        zm_unitrigger::function_3fc5694(s_unitrigger, s_trigger_pos.origin, s_unitrigger.angles);
    }
    zm_unitrigger::function_7fcb11a8(s_unitrigger);
    self waittill(#"hash_3c52547927852e33");
    self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
    self delete();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x59e9abdf, Offset: 0x9a70
// Size: 0xc8
function function_2af41f2f() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (isdefined(e_player.var_50d3a7cc)) {
            continue;
        }
        e_player.var_50d3a7cc = self.stub.related_parent.script_int;
        self.stub.related_parent notify(#"hash_3c52547927852e33", {#e_who:e_player});
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x4cd7026d, Offset: 0x9b40
// Size: 0xc4
function function_1ab86e9a() {
    self.t_damage = getent(self.target, "targetname");
    self.var_b35bfb22 = getent(self.t_damage.target, "targetname");
    self.var_b35bfb22 hide();
    self.var_fd25c400 = 0;
    s_unitrigger = self zm_unitrigger::create(undefined, undefined, &function_1e73da9a);
    zm_unitrigger::function_7fcb11a8(s_unitrigger);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x26c076c2, Offset: 0x9c10
// Size: 0x232
function function_1e73da9a() {
    self endon(#"death");
    s_piano = self.stub.related_parent;
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        var_4f345e6d = undefined;
        var_3c6064c8 = 0;
        if (isdefined(s_piano.var_50d3a7cc)) {
            s_piano.var_b35bfb22 hide();
            if (s_piano.var_50d3a7cc == s_piano.script_int) {
                s_piano.var_fd25c400 = 0;
            }
            var_4f345e6d = s_piano.var_50d3a7cc;
            s_piano.var_50d3a7cc = undefined;
            s_piano notify(#"hash_44c21ffb9cd24f2f");
            if (isdefined(e_player.var_50d3a7cc)) {
                wait 0.3;
            } else {
                e_player.var_50d3a7cc = var_4f345e6d;
                var_3c6064c8 = 1;
            }
        }
        if (!var_3c6064c8 && !isdefined(s_piano.var_50d3a7cc) && isdefined(e_player.var_50d3a7cc)) {
            s_piano.var_b35bfb22 function_8063fbe9(e_player.var_50d3a7cc);
            s_piano.var_b35bfb22 show();
            s_piano notify(#"hash_2624818b23ab83dc");
            s_piano.var_50d3a7cc = e_player.var_50d3a7cc;
            e_player.var_50d3a7cc = isdefined(var_4f345e6d) ? var_4f345e6d : undefined;
            if (s_piano.var_50d3a7cc == s_piano.script_int) {
                s_piano.var_fd25c400 = 1;
            }
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xa58278cf, Offset: 0x9e50
// Size: 0xc2
function function_8063fbe9(var_b49ff3e8) {
    switch (var_b49ff3e8) {
    case 0:
        self setmodel(#"p8_zm_zod_music_sheet_03");
        break;
    case 1:
        self setmodel(#"p8_zm_zod_music_sheet_01");
        break;
    case 2:
        self setmodel(#"p8_zm_zod_music_sheet_04");
        break;
    }
}

/#

    // Namespace namespace_7890c038/zm_zodt8_side_quests
    // Params 2, eflags: 0x0
    // Checksum 0xd08ea4a3, Offset: 0x9f20
    // Size: 0xa0
    function function_7b574cda(str_text, str_endon) {
        level endon(#"end_of_round", #"start_of_round");
        if (isdefined(str_endon)) {
            self endon(str_endon);
        }
        while (true) {
            print3d(self.origin, function_15979fa9(str_text), (1, 1, 0), 1, 1, 30);
            wait 0.5;
        }
    }

#/

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0xa0d6e3bd, Offset: 0x9fc8
// Size: 0x1a8
function function_c0d20e5e(var_4df52d26, var_c86ff890) {
    a_s_pianos = struct::get_array(#"ivory_number");
    foreach (s_piano in a_s_pianos) {
        s_piano.var_b35bfb22 show();
        s_piano.var_fd25c400 = 1;
        s_piano notify(#"hash_2624818b23ab83dc");
    }
    var_478d6140 = getentarray("sheet_sound_place", "targetname");
    foreach (var_134245e9 in var_478d6140) {
        if (isdefined(var_134245e9.s_unitrigger)) {
            zm_unitrigger::unregister_unitrigger(var_134245e9.s_unitrigger);
            var_134245e9 delete();
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xf76acc40, Offset: 0xa178
// Size: 0x110
function function_dab43e6a(var_4df52d26) {
    if (!(isdefined(level.var_272b3e45) && level.var_272b3e45)) {
        level.var_272b3e45 = 1;
        a_s_pianos = struct::get_array(#"ivory_number");
        while (true) {
            foreach (s_piano in a_s_pianos) {
                s_piano thread function_66672e94();
            }
            level thread function_d84c7db6();
            level waittill(#"end_of_round");
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x21360744, Offset: 0xa290
// Size: 0x320
function function_66672e94() {
    level endon(#"end_of_round", #"end_game");
    if (!isdefined(self.t_damage)) {
        self.t_damage = getent(self.target, "targetname");
        self.t_damage makesentient();
    }
    exploder::stop_exploder(self.script_exploder);
    self.var_ea2eab43 = 0;
    if (!isdefined(self.var_50d3a7cc)) {
        self waittill(#"hash_2624818b23ab83dc");
    }
    self endoncallback(&function_66672e94, #"hash_44c21ffb9cd24f2f");
    while (true) {
        waitresult = self.t_damage waittill(#"damage");
        if (waitresult.mod !== #"mod_melee" || !isplayer(waitresult.attacker)) {
            continue;
        }
        if (isdefined(waitresult.weapon) && waitresult.weapon.gadget_type === 11) {
            if (isdefined(self.var_fd25c400) && self.var_fd25c400) {
                /#
                    iprintlnbold("<dev string:x159>");
                #/
                waitresult.attacker util::delay(3, "death", &zm_audio::create_and_play_dialog, #"hash_68677a02650cad00", #"correct_tune");
                if (!(isdefined(self.var_ea2eab43) && self.var_ea2eab43)) {
                    self.var_ea2eab43 = 1;
                    self notify(#"hash_2de28171d87b35cf");
                    level notify(#"hash_55934fc4dddbd12" + self.script_int + "_on");
                    exploder::exploder(self.script_exploder);
                    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
                }
                continue;
            }
            /#
                iprintlnbold("<dev string:x169>");
            #/
            waitresult.attacker util::delay(3, "death", &zm_audio::create_and_play_dialog, #"hash_68677a02650cad00", #"wrong_tune");
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xbc8e262f, Offset: 0xa5b8
// Size: 0x74
function function_d84c7db6() {
    level endon(#"end_of_round");
    level util::waittill_multiple(#"hash_78e09697a7953a96", #"hash_527cb89f45b995cb", #"hash_235cb6873829de38");
    level thread function_f0bcc27c();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x72fb5af9, Offset: 0xa638
// Size: 0x2b4
function function_f0bcc27c(str_notify) {
    level endon(#"end_of_round");
    if (str_notify === #"moving_chest_now") {
        level flag::wait_till_clear(#"moving_chest_now");
    }
    while (isdefined(level.var_e63b7591) && level.var_e63b7591) {
        wait 0.1;
    }
    level endoncallback(&function_f0bcc27c, #"moving_chest_now");
    var_13196734 = level.chests[level.chest_index].zbarrier;
    var_182f7d27 = vectornormalize(anglestoright(var_13196734.angles)) * -28;
    level.var_7f573cb2 = spawn("trigger_damage_new", var_13196734.origin + var_182f7d27 + (0, 0, 24), 0, 48, 48);
    level thread util::delete_on_death_or_notify(level.var_7f573cb2, #"end_of_round");
    level.var_7f573cb2 usetriggerrequirelookat(1);
    while (true) {
        waitresult = level.var_7f573cb2 waittill(#"damage");
        if (waitresult.mod !== #"mod_melee" || var_13196734.state === "open" || !isplayer(waitresult.attacker)) {
            continue;
        }
        if (isdefined(waitresult.weapon) && waitresult.weapon.gadget_type === 11) {
            var_13196734 thread function_daa4e0cd();
            while (isdefined(level.var_e63b7591) && level.var_e63b7591) {
                wait 0.1;
            }
        }
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xce1c0a31, Offset: 0xa8f8
// Size: 0xca
function function_daa4e0cd() {
    level.var_e63b7591 = 1;
    level.customrandomweaponweights = &function_b43ee557;
    self.owner.zombie_cost = 10;
    level waittilltimeout(20, #"moving_chest_now");
    while (isdefined(self.owner.weapon_out) && self.owner.weapon_out) {
        waitframe(1);
    }
    level.var_e63b7591 = 0;
    level.customrandomweaponweights = undefined;
    self.owner.zombie_cost = self.owner.old_cost;
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0xd9481f81, Offset: 0xa9d0
// Size: 0x2c8
function function_b43ee557(a_keys) {
    switch (self.var_4dcf5f7f) {
    case 0:
        a_str_hero_weapons = array(#"hero_chakram_lv1", #"hero_hammer_lv1", #"hero_scepter_lv1", #"hero_sword_pistol_lv1");
        break;
    case 1:
        a_str_hero_weapons = array(#"hero_chakram_lv2", #"hero_hammer_lv2", #"hero_scepter_lv2", #"hero_sword_pistol_lv2");
        break;
    case 2:
        a_str_hero_weapons = array(#"hero_chakram_lv3", #"hero_hammer_lv3", #"hero_scepter_lv3", #"hero_sword_pistol_lv3");
        break;
    default:
        a_str_hero_weapons = array(#"hero_chakram_lv1", #"hero_hammer_lv1", #"hero_scepter_lv1", #"hero_sword_pistol_lv1");
        break;
    }
    a_str_hero_weapons = array::exclude(a_str_hero_weapons, self.var_c332c9d4.name);
    var_87cad744 = array::random(a_str_hero_weapons);
    var_6d69e2f2 = getweapon(var_87cad744);
    zm_weapons::include_zombie_weapon(var_87cad744, 1);
    zm_weapons::add_zombie_weapon(var_87cad744, "", "", 0, undefined, undefined, 0, "", 0, 0, "");
    level thread function_25277002(var_6d69e2f2);
    arrayinsert(a_keys, var_6d69e2f2, 0);
    return a_keys;
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 1, eflags: 0x0
// Checksum 0x7cc84ca0, Offset: 0xaca0
// Size: 0x6c
function function_25277002(var_af3b7731) {
    while (isdefined(level.chests[level.chest_index].weapon_out) && level.chests[level.chest_index].weapon_out) {
        waitframe(1);
    }
    zm_weapons::function_503fb052(var_af3b7731);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 2, eflags: 0x0
// Checksum 0xc97d9a06, Offset: 0xad18
// Size: 0x14
function function_c4fb8111(var_4df52d26, var_c86ff890) {
    
}

