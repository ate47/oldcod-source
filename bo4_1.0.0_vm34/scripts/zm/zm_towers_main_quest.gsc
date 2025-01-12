#using script_27a3bb6bb72e6f1a;
#using script_2c5daa95f8fec03c;
#using scripts\abilities\ability_util;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\weapons\zm_weap_crossbow;
#using scripts\zm\zm_towers;
#using scripts\zm\zm_towers_crowd;
#using scripts\zm\zm_towers_special_rounds;
#using scripts\zm_common\util\ai_gladiator_util;
#using scripts\zm_common\util\ai_tiger_util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_towers_main_quest;

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x2
// Checksum 0xe028ede5, Offset: 0x19b0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_towers_main_quest", &__init__, &__main__, undefined);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xbf20ce1a, Offset: 0x1a00
// Size: 0x24
function __init__() {
    callback::on_finalize_initialization(&init);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1a30
// Size: 0x4
function __main__() {
    
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x4a41078c, Offset: 0x1a40
// Size: 0x944
function init() {
    scene::add_scene_func(#"hash_18b88682c325ad3d", &function_cfdc5f4b, "play");
    scene::add_scene_func(#"hash_18b88682c325ad3d", &function_26f748a9, "done");
    scene::add_scene_func(#"hash_18b88682c325ad3d", &function_26f748a9, "stop");
    zm_towers_crowd::function_5c8e025a(0);
    zm_towers_crowd::function_5ff4429f(0);
    level function_72acb24e();
    level thread function_d2a9e0d7();
    level._zm_blocker_trigger_think_return_override = &function_8ba63bcd;
    function_66193f70();
    function_395bfa5a();
    function_88213d8();
    init_defend();
    level thread function_61f250e5();
    level thread key_glint();
    zm_sq::register(#"main_quest", #"hash_616226b026783ca3", #"hash_616226b026783ca3", &function_5b0aba29, &function_62b91242);
    zm_sq::register(#"hash_7848e22b4305215c", #"collect_charcoal", #"collect_charcoal", &collect_charcoal_setup, &collect_charcoal_cleanup);
    zm_sq::register(#"hash_39d41ab4004ca686", #"hash_1c34d1cbe7a35ae1", #"hash_1c34d1cbe7a35ae1", &function_abaee373, &function_55e783e8);
    zm_sq::register(#"hash_1da6434ce50c3713", #"collect_dung", #"collect_dung", &collect_dung_setup, &collect_dung_cleanup);
    zm_sq::register(#"main_quest", #"collect_ingredients", #"collect_ingredients", &collect_ingredients_setup, &collect_ingredients_cleanup);
    zm_sq::register(#"main_quest", #"mix_fertilizer", #"mix_fertilizer", &mix_fertilizer_setup, &mix_fertilizer_cleanup);
    zm_sq::register(#"main_quest", #"place_fertilizer", #"place_fertilizer", &place_fertilizer_setup, &place_fertilizer_cleanup);
    zm_sq::register(#"main_quest", #"hash_c165871a3fda034", #"hash_c165871a3fda034", &function_a63fdc98, &function_a421f4e3);
    zm_sq::register(#"main_quest", #"activate_bulls", #"activate_bulls", &activate_bulls_setup, &activate_bulls_cleanup);
    zm_sq::register(#"main_quest", #"activate_puzzle", #"activate_puzzle", &activate_puzzle_setup, &activate_puzzle_cleanup);
    zm_sq::register(#"main_quest", #"hash_1cf74a26bf73d769", #"hash_1cf74a26bf73d769", &function_7b5f8293, &function_e9b97508);
    zm_sq::register(#"main_quest", #"hash_73c85b5a7924fcfb", #"hash_73c85b5a7924fcfb", &function_b3ada319, &function_a7d9ed32);
    zm_sq::register(#"main_quest", #"activate_lightning_balls", #"activate_lightning_balls", &function_c292b8a4, &function_c1002047);
    zm_sq::register(#"main_quest", #"gladiator_round", #"gladiator_round", &gladiator_round_setup, &gladiator_round_cleanup);
    zm_sq::register(#"main_quest", #"maelstrom_completed", #"maelstrom_completed", &maelstrom_completed_setup, &maelstrom_completed_cleanup);
    zm_sq::register(#"main_quest", #"light_runes", #"light_runes", &light_runes_setup, &light_runes_cleanup);
    zm_sq::register(#"main_quest", #"pressure_plate", #"pressure_plate", &pressure_plate_setup, &pressure_plate_cleanup);
    zm_sq::register(#"main_quest", #"trilane_defend", #"trilane_defend", &trilane_defend_setup, &trilane_defend_cleanup, 1);
    zm_sq::start(#"main_quest", 1);
    t_zm_towers_boss_teleport = getent("t_zm_towers_boss_teleport", "targetname");
    if (getdvarint(#"zm_debug_ee", 0)) {
        level flag::wait_till("all_players_spawned");
        t_zm_towers_boss_teleport setinvisibletoall();
        level function_8945d1a2(t_zm_towers_boss_teleport);
        return;
    }
    t_zm_towers_boss_teleport delete();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x4a8ecdc5, Offset: 0x2390
// Size: 0x4c4
function function_72acb24e() {
    level flag::init(#"hash_4fd3d0c01f9b4c30");
    level flag::init(#"hash_23c79f4deefd8aa1");
    level flag::init(#"hash_7f6689c71e55e8ab");
    level flag::init(#"hash_4866241882c534b7");
    level flag::init(#"hash_34294ceb082c5d8f");
    level flag::init(#"hash_4f293396150d2c00");
    level flag::init(#"hash_353dcb95f778ad73");
    level flag::init(#"hash_37071af70fe7a9f2");
    level flag::init(#"collect_ingredients_completed");
    level flag::init(#"collect_charcoal_completed");
    level flag::init(#"hash_4c6ced4815715faf");
    level flag::init(#"collect_dung_completed");
    level flag::init(#"mix_fertilizer_completed");
    level flag::init(#"place_fertilizer_completed");
    level flag::init(#"hash_498204258011f15e");
    level flag::init(#"bull_heads_completed");
    level flag::init(#"hash_7136198009a72989");
    level flag::init(#"hash_36efad26d2c9c9cd");
    level flag::init(#"hash_e35ac19ee7b732c");
    level flag::init(#"hash_768860cb3ad76c68");
    level flag::init(#"hash_77bd156a70de5aa3");
    level flag::init(#"hash_3666dca19f0f98b3");
    level flag::init(#"hash_1d004da0a75202bc");
    level flag::init(#"hash_35bd62e100e54ab3");
    level flag::init(#"hash_4f15d2623e98015d");
    level flag::init(#"hash_5734e11875c30d69");
    level flag::init(#"hash_50e2bacfe0486f6a");
    level flag::init(#"hash_4f26632e308bd2e6");
    level flag::init(#"hash_415c59c3573153ff");
    level flag::init(#"hash_2c274140cd602e60");
    level flag::init(#"hash_5e49848f6ac0bc6b");
    level flag::init(#"hash_4feaeb49c7362da7");
    level flag::init(#"hash_403b629f7e5829ee");
    level flag::init(#"hash_20c92720a4602dc7");
    level flag::init(#"hash_cad6742c753621");
    level flag::init(#"hash_6b64093194524df3");
    level flag::init(#"hash_2bf040db75b1dac7");
    level flag::init(#"hash_277d03629ade12e8");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x38fdfdc7, Offset: 0x2860
// Size: 0x64
function function_5b0aba29(b_skipped) {
    if (b_skipped) {
        return;
    }
    waitframe(1);
    level flag::wait_till("zm_towers_pap_quest_completed");
    playsoundatposition(#"hash_6bc2c95bdaed3aed", (0, 0, 0));
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0xdd0591b6, Offset: 0x28d0
// Size: 0x1e
function function_62b91242(b_skipped, var_c86ff890) {
    if (b_skipped) {
        return;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x48f784d0, Offset: 0x28f8
// Size: 0x174
function function_66193f70() {
    level.var_f1bf35ea = {#n_wood:0, #var_d2f01e47:[], #n_charcoal:0, #var_210fed57:0, #var_1dc08b04:0, #n_dung:0};
    level.var_f1bf35ea.var_768a6c4d = array("danu_basement_to_bottom_floor", "danu_bottom_floor_to_top_floor", "connect_starting_area_to_danu_hallway", "connect_danu_tower", "connect_danu_basement_to_danu_ra_tunnel", "connect_danu_ra_bridge");
    a_mdl_pieces = getentarray("fertilizer_pieces", "script_noteworthy");
    array::run_all(a_mdl_pieces, &hide);
    mdl_glow = getent("fertilizer_hop", "targetname");
    mdl_glow hide();
    level scene::add_scene_func("p8_fxanim_zm_towers_odin_cauldron_chain_shackle_bundle", &function_b3e42f55, "play");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xf3f1c480, Offset: 0x2a78
// Size: 0x84
function function_b3e42f55(a_ents) {
    if (self.targetname === "s_fertilizer_dangle") {
        var_e6b5c33a = a_ents[#"prop 1"];
        mdl_wood = getent("mdl_fertilizer_component_1", "targetname");
        mdl_wood linkto(var_e6b5c33a, "shackle_attach_jnt");
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xf842fda5, Offset: 0x2b08
// Size: 0x114
function collect_charcoal_setup(b_skipped) {
    var_da66e9c0 = getentarray("t_fertilizer_tower", "targetname");
    array::thread_all(var_da66e9c0, &function_44429284);
    level clientfield::set("" + #"hash_445060dbbf244b04", 1);
    level clientfield::set("" + #"hash_a2fb645044ed12e", 1);
    level thread function_1b4b8693();
    level thread function_4a6cd6c0();
    level flag::wait_till(#"collect_charcoal_completed");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0xaf335d9f, Offset: 0x2c28
// Size: 0x34
function collect_charcoal_cleanup(b_skipped, var_c86ff890) {
    level flag::set(#"collect_charcoal_completed");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xf65ca687, Offset: 0x2c68
// Size: 0x44
function function_abaee373(b_skipped) {
    level thread function_3eb28fc0();
    level flag::wait_till(#"hash_4c6ced4815715faf");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0xed4af568, Offset: 0x2cb8
// Size: 0x34
function function_55e783e8(b_skipped, var_c86ff890) {
    level flag::set(#"hash_4c6ced4815715faf");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x2eb1a3a9, Offset: 0x2cf8
// Size: 0x44
function collect_dung_setup(b_skipped) {
    level thread function_48bbb17f();
    level flag::wait_till(#"collect_dung_completed");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x5043f205, Offset: 0x2d48
// Size: 0x34
function collect_dung_cleanup(b_skipped, var_c86ff890) {
    level flag::set(#"collect_dung_completed");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x346804df, Offset: 0x2d88
// Size: 0x104
function collect_ingredients_setup(b_skipped) {
    if (b_skipped) {
        level flag::set(#"collect_ingredients_completed");
        return;
    }
    zm_sq::start(#"hash_7848e22b4305215c");
    zm_sq::start(#"hash_39d41ab4004ca686");
    zm_sq::start(#"hash_1da6434ce50c3713");
    level flag::wait_till_all(array(#"collect_charcoal_completed", #"hash_4c6ced4815715faf", #"collect_dung_completed"));
    level flag::set(#"collect_ingredients_completed");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x8279a584, Offset: 0x2e98
// Size: 0x34
function collect_ingredients_cleanup(b_skipped, var_c86ff890) {
    level flag::set(#"collect_ingredients_completed");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x3f4a956c, Offset: 0x2ed8
// Size: 0x2a4
function function_1b4b8693() {
    level endon(#"end_game");
    var_c0998a88 = struct::get(#"hash_224dd0372d9a6eff");
    var_c0998a88 zm_unitrigger::create(&function_21fa46c7, (96, 180, 96), undefined, undefined, 1);
    var_af8f33f9 = getentarray("mdl_fertilizer_component_1", "targetname");
    while (true) {
        s_waitresult = var_c0998a88 waittill(#"trigger_activated");
        foreach (i, var_351830d9 in var_af8f33f9) {
            if (i >= 1) {
                break;
            }
            var_351830d9 show();
            var_351830d9 playsound(#"hash_59ed73d06252024c");
        }
        for (i = 0; i < level.var_f1bf35ea.n_wood; i++) {
            if (!isdefined(level.var_f1bf35ea.var_d2f01e47)) {
                level.var_f1bf35ea.var_d2f01e47 = [];
            } else if (!isarray(level.var_f1bf35ea.var_d2f01e47)) {
                level.var_f1bf35ea.var_d2f01e47 = array(level.var_f1bf35ea.var_d2f01e47);
            }
            level.var_f1bf35ea.var_d2f01e47[level.var_f1bf35ea.var_d2f01e47.size] = level.round_number;
        }
        level.var_f1bf35ea.n_wood = 0;
        if (level.var_f1bf35ea.var_d2f01e47.size >= 1) {
            var_c0998a88 zm_unitrigger::unregister_unitrigger(var_c0998a88.s_unitrigger);
            break;
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x9215bfaf, Offset: 0x3188
// Size: 0x42c
function function_4a6cd6c0() {
    level endon(#"end_game");
    if (getdvarint(#"zm_debug_ee", 0)) {
        var_4819e5af = 1;
    } else {
        var_4819e5af = 3;
    }
    var_af8f33f9 = getentarray("mdl_fertilizer_component_1", "targetname");
    while (true) {
        level waittill(#"end_of_round");
        var_c41a612f = 0;
        foreach (n_charcoal in level.var_f1bf35ea.var_d2f01e47) {
            mdl_wood = var_af8f33f9[var_c41a612f];
            if (var_4819e5af > 1) {
                if (level.round_number == n_charcoal + 1) {
                    mdl_wood clientfield::set("" + #"hash_c382c02584ba249", 1);
                }
                if (level.round_number == n_charcoal + 3) {
                    mdl_wood playsound(#"hash_5f8e33ac1c927130");
                    mdl_wood clientfield::set("" + #"hash_c382c02584ba249", 0);
                    mdl_wood clientfield::set("" + #"hash_273efcc293063e5e", 1);
                    mdl_wood thread function_26f857d5();
                }
            } else {
                mdl_wood setmodel(#"hash_4286272708c5e5c0");
            }
            if (level.round_number >= n_charcoal + var_4819e5af) {
                var_c41a612f++;
            }
        }
        if (var_c41a612f >= 1) {
            var_c0998a88 = struct::get(#"hash_224dd0372d9a6eff");
            e_player = var_c0998a88 zm_unitrigger::function_b7e350e6("", (96, 180, 96), 1);
            e_player zm_vo::vo_stop();
            e_player thread zm_vo::function_59635cc4("m_quest_collect_charcoal", 0, 0, 9999, 1);
            e_player playsound(#"hash_35c03e3efe6d4487");
            foreach (var_351830d9 in var_af8f33f9) {
                if (isdefined(var_351830d9)) {
                    var_351830d9 delete();
                }
            }
            level clientfield::set("" + #"hash_a2fb645044ed12e", 0);
            break;
        }
    }
    level flag::set(#"collect_charcoal_completed");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x226ce0c5, Offset: 0x35c0
// Size: 0x9c
function function_26f857d5() {
    self endon(#"death");
    wait 5;
    level clientfield::set("" + #"hash_445060dbbf244b04", 0);
    self setmodel(#"hash_4286272708c5e5c0");
    self clientfield::set("" + #"hash_273efcc293063e5e", 0);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xa29714fc, Offset: 0x3668
// Size: 0x30
function function_21fa46c7(e_player) {
    if (level.var_f1bf35ea.n_wood >= 1) {
        return true;
    }
    return false;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x278f66a2, Offset: 0x36a0
// Size: 0xa8
function function_44429284() {
    self endon(#"death", #"wood_dropped");
    level endon(#"end_game", #"wood_completed");
    while (true) {
        s_waitresult = level waittill(#"hash_27a9b4863f38ef7c");
        mdl_axe = s_waitresult.mdl_axe;
        mdl_axe thread function_e08d6131(self);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xb3835d0b, Offset: 0x3750
// Size: 0x3dc
function function_e08d6131(var_737f1cea) {
    while (isdefined(self)) {
        foreach (player in level.players) {
            if (self istouching(player)) {
                return;
            }
        }
        if (isdefined(self.var_848442e9) && self.var_848442e9 || isdefined(var_737f1cea.var_83e9ddc8) && var_737f1cea.var_83e9ddc8) {
            return;
        }
        if (self istouching(var_737f1cea)) {
            self.var_848442e9 = 1;
        }
        if (isdefined(self.var_848442e9) && self.var_848442e9) {
            var_312d5cf6 = getentarray(var_737f1cea.target, "targetname");
            var_5a478a7f = struct::get_array(var_737f1cea.target);
            mdl_wood = arraygetclosest(self.origin, var_312d5cf6);
            s_loc = arraygetclosest(self.origin, var_5a478a7f);
            mdl_wood show();
            mdl_wood setmodel(#"hash_4973461a43fcb56");
            mdl_wood clientfield::increment("" + #"hash_6ff3eb2dd0078a51");
            var_e3800300 = util::spawn_model(#"hash_77659f61538a4beb", mdl_wood.origin, mdl_wood.angles);
            var_e3800300 moveto(s_loc.origin, 0.5);
            var_737f1cea.var_83e9ddc8 = 1;
            var_737f1cea notify(#"wood_dropped");
            var_e3800300 waittill(#"movedone");
            var_e3800300 playsound(#"hash_119d4d341483b32c");
            var_22777f53 = s_loc zm_unitrigger::function_b7e350e6("", 96, 1);
            var_22777f53 zm_vo::vo_stop();
            var_22777f53 thread zm_vo::function_59635cc4("m_quest_collect_wood", 0, 0, 9999, 1);
            var_22777f53 playsound(#"hash_30b990837c062495");
            level.var_f1bf35ea.n_wood++;
            if (isdefined(var_e3800300)) {
                var_e3800300 delete();
            }
            if (level.var_f1bf35ea.n_wood >= 1) {
                level notify(#"wood_completed");
            }
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x2c7139a3, Offset: 0x3b38
// Size: 0x36c
function function_3eb28fc0() {
    level endon(#"end_game");
    var_768c948f = struct::get_array(#"hash_4617b99d3d90b7fc");
    s_skull = array::random(var_768c948f);
    var_53c8a482 = getent("mdl_fertilizer_component_2", "targetname");
    if (!isdefined(s_skull.radius)) {
        s_skull.radius = 160;
    }
    var_53c8a482.origin = s_skull.origin;
    var_53c8a482.angles = s_skull.angles;
    var_53c8a482 show();
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            level thread function_95f6d456(s_skull);
        }
    #/
    while (true) {
        s_waitresult = level waittill(#"hero_weapon_activated");
        if (distance(s_waitresult.e_player.origin, s_skull.origin) < s_skull.radius) {
            if (isdefined(s_skull.target)) {
                var_55472db6 = struct::get(s_skull.target);
                var_53c8a482 playsound(#"hash_67ab50b44ebf94a7");
                var_53c8a482 moveto(var_55472db6.origin, 0.5);
                var_53c8a482 rotateto(var_55472db6.angles, 0.5);
                var_53c8a482 waittill(#"movedone");
                var_53c8a482 playsound(#"hash_f210344da062582");
            }
            e_player = var_53c8a482 zm_unitrigger::function_b7e350e6("", 96, 1);
            e_player playsound(#"hash_1c2e8e92fd97011f");
            e_player zm_vo::vo_stop();
            e_player thread zm_vo::function_59635cc4("m_quest_collect_skull", 0, 0, 9999, 1);
            break;
        }
    }
    level notify(#"hash_3da6bb0f657559c0");
    level.var_f1bf35ea.var_210fed57++;
    var_53c8a482 delete();
    level thread function_ce24b10e();
}

/#

    // Namespace zm_towers_main_quest/zm_towers_main_quest
    // Params 1, eflags: 0x0
    // Checksum 0xb9a24d9c, Offset: 0x3eb0
    // Size: 0x86
    function function_95f6d456(s_skull) {
        level endon(#"end_game", #"hash_3da6bb0f657559c0", #"collect_ingredients_completed");
        while (true) {
            circle(s_skull.origin, 64, (0, 1, 0), 0, 1, 1);
            waitframe(1);
        }
    }

#/

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xc3c1a8b3, Offset: 0x3f40
// Size: 0x4cc
function function_ce24b10e() {
    self notify("452ffe41b3113539");
    self endon("452ffe41b3113539");
    level endon(#"end_game", #"hash_4c6ced4815715faf");
    if (level flag::get(#"hash_4c6ced4815715faf")) {
        return;
    }
    var_768c948f = struct::get_array(#"hash_439f49cad20fb09c");
    s_grinder = array::random(var_768c948f);
    mdl_grinder = getent("mdl_grinder", "targetname");
    mdl_grinder show();
    mdl_grinder.origin = s_grinder.origin;
    mdl_grinder.angles = s_grinder.angles;
    mdl_grinder hidepart("skull_jnt");
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            level thread function_6d2db2c7(mdl_grinder);
        }
    #/
    while (level.var_f1bf35ea.var_210fed57 == 0) {
        wait 1;
    }
    mdl_grinder zm_unitrigger::function_b7e350e6("", 96, 1);
    mdl_grinder playsound(#"hash_40a6a28923cf0f3e");
    mdl_grinder showpart("skull_jnt");
    mdl_grinder val::set(#"grinder", "takedamage", 1);
    mdl_grinder.health = 9999;
    while (true) {
        s_waitresult = mdl_grinder waittill(#"damage");
        mdl_grinder.health = 9999;
        if (isplayer(s_waitresult.attacker) && zm_weap_crossbow::is_crossbow_charged(s_waitresult.weapon, s_waitresult.attacker)) {
            if (level.var_f1bf35ea.var_1dc08b04 < 2) {
                mdl_grinder zm_weap_crossbow::function_592418cc(s_waitresult, #"p8_fxanim_zm_towers_grinder_bundle", "idle");
            } else {
                mdl_grinder zm_weap_crossbow::function_592418cc(s_waitresult, #"p8_fxanim_zm_towers_grinder_bundle", "completed");
            }
            if (zm_weap_crossbow::is_crossbow_upgraded(s_waitresult.weapon)) {
                level.var_f1bf35ea.var_1dc08b04 += 1.5;
            } else {
                level.var_f1bf35ea.var_1dc08b04 += 1;
            }
            if (level.var_f1bf35ea.var_1dc08b04 >= 3) {
                mdl_grinder hidepart("skull_jnt");
                e_player = mdl_grinder zm_unitrigger::function_b7e350e6("", 96, 1);
                e_player playsound(#"hash_4061dc3dc7f197ba");
                e_player zm_vo::vo_stop();
                e_player thread zm_vo::function_59635cc4("m_quest_collect_bone_dust", 0, 0, 9999, 1);
                mdl_grinder hidepart("tag_link_bone_dust");
                break;
            }
        }
    }
    level flag::set(#"hash_4c6ced4815715faf");
}

/#

    // Namespace zm_towers_main_quest/zm_towers_main_quest
    // Params 1, eflags: 0x0
    // Checksum 0xb21fc71, Offset: 0x4418
    // Size: 0x9e
    function function_6d2db2c7(mdl_grinder) {
        mdl_grinder endon(#"death");
        level endon(#"end_game", #"hash_4c6ced4815715faf", #"collect_ingredients_completed");
        while (true) {
            circle(mdl_grinder.origin, 32, (0, 1, 0), 0, 1, 1);
            waitframe(1);
        }
    }

#/

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x778e0b9b, Offset: 0x44c0
// Size: 0xf4
function function_48bbb17f() {
    level endon(#"end_game");
    while (true) {
        s_waitresult = level waittill(#"hash_694f58e8bc5dd48");
        level.var_f1bf35ea.n_dung++;
        e_player = s_waitresult.e_player;
        e_player zm_vo::vo_stop();
        e_player thread zm_vo::function_59635cc4("m_quest_collect_dung", 0, 0, 9999, 1);
        if (level.var_f1bf35ea.n_dung >= 1) {
            break;
        }
    }
    level flag::set(#"collect_dung_completed");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x14c7417c, Offset: 0x45c0
// Size: 0x294
function mix_fertilizer_setup(b_skipped) {
    level endon(#"end_game");
    if (b_skipped) {
        level flag::set(#"mix_fertilizer_completed");
        return;
    }
    var_6e60c1bf = struct::get(#"hash_44451a49b3653789");
    var_6e60c1bf zm_unitrigger::function_b7e350e6("", 96, 1);
    mdl_fertilizer = getent("mdl_pile", "targetname");
    mdl_fertilizer show();
    mdl_fertilizer playsound(#"hash_3cee8f860c831f0b");
    if (getdvarint(#"zm_debug_ee", 0)) {
        level waittill(#"end_of_round");
    } else {
        level waittill(#"start_of_round");
        level waittill(#"end_of_round");
    }
    mdl_fertilizer setmodel(#"hash_571dce3dbd970ee6");
    level clientfield::set("" + #"hash_5a3e1454226ef7a4", 1);
    e_player = mdl_fertilizer zm_unitrigger::function_b7e350e6("", 96, 1);
    e_player playsound(#"hash_338c802929e278d4");
    level clientfield::set("" + #"hash_5a3e1454226ef7a4", 0);
    mdl_fertilizer delete();
    e_player zm_vo::vo_stop();
    e_player thread zm_vo::function_59635cc4("m_quest_build_fertilizer", 0, 0, 9999, 1);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x47f7251, Offset: 0x4860
// Size: 0x34
function mix_fertilizer_cleanup(b_skipped, var_c86ff890) {
    level flag::set(#"mix_fertilizer_completed");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x344e61cc, Offset: 0x48a0
// Size: 0x364
function place_fertilizer_setup(b_skipped) {
    level endon(#"end_game");
    if (b_skipped) {
        level flag::set(#"place_fertilizer_completed");
        return;
    }
    var_352d62ab = struct::get(#"hash_3fda284f010e01fd");
    var_352d62ab zm_unitrigger::function_b7e350e6("", 96, 1);
    var_352d62ab.mdl_fertilizer = util::spawn_model(#"hash_571dce3dbd970ee6", var_352d62ab.origin, var_352d62ab.angles);
    var_352d62ab.mdl_fertilizer setscale(1);
    var_352d62ab.mdl_fertilizer clientfield::set("" + #"fertilizer_smell", 1);
    var_352d62ab.mdl_fertilizer playsound(#"hash_5d534ac036533040");
    if (getdvarint(#"zm_debug_ee", 0)) {
        level waittill(#"end_of_round");
    } else {
        level waittill(#"end_of_round");
        level waittill(#"end_of_round");
        level waittill(#"end_of_round");
    }
    var_352d62ab.mdl_fertilizer clientfield::set("" + #"fertilizer_smell", 0);
    var_352d62ab.mdl_fertilizer setmodel(#"hash_77ef8294c44076f1");
    var_352d62ab.mdl_fertilizer setscale(2.5);
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            level thread function_d488124d(var_352d62ab.mdl_fertilizer);
        }
    #/
    while (true) {
        s_waitresult = level waittill(#"plasmatic_burst");
        var_9a0ad813 = s_waitresult.var_a7f2bb60.origin;
        if (distance(var_352d62ab.origin, var_9a0ad813) <= 120) {
            var_352d62ab.mdl_fertilizer fertilizer_explosion();
            break;
        }
        waitframe(1);
    }
    wait 3;
    level flag::set(#"place_fertilizer_completed");
}

/#

    // Namespace zm_towers_main_quest/zm_towers_main_quest
    // Params 1, eflags: 0x0
    // Checksum 0x24c47d2f, Offset: 0x4c10
    // Size: 0x8e
    function function_d488124d(mdl_fertilizer) {
        mdl_fertilizer endon(#"death");
        level endon(#"end_game", #"place_fertilizer_completed");
        while (true) {
            circle(mdl_fertilizer.origin, 120, (1, 0, 0), 0, 1, 1);
            waitframe(1);
        }
    }

#/

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xf982e3fe, Offset: 0x4ca8
// Size: 0x44
function fertilizer_explosion() {
    level lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x23932e8f, Offset: 0x4cf8
// Size: 0xb4
function place_fertilizer_cleanup(b_skipped, var_c86ff890) {
    level flag::set(#"place_fertilizer_completed");
    mdl_glow = getent("fertilizer_hop", "targetname");
    mdl_glow show();
    mdl_glow playsound(#"hash_bde75843d826490");
    mdl_glow playloopsound(#"hash_63dcc2bd59631940");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x38ce634d, Offset: 0x4db8
// Size: 0x7c4
function function_a63fdc98(b_skipped) {
    if (b_skipped) {
        return;
    }
    function_e9c5a148();
    playsoundatposition(#"hash_c648800c55e1554", (0, 0, 0));
    level thread function_38f4a3b7();
    exploder::exploder("exp_danu_portal");
    array::thread_all(level.players, &val::set, #"chaos_teleport", "ignoreme", 1);
    wait 1;
    level.var_dcc8a45d = 1;
    function_bd5f6c56(0);
    level flag::set("pause_round_timeout");
    scene::add_scene_func(#"p8_fxanim_zm_towers_chaos_pustule_bundle", &function_8d2cace8, "init", 1);
    foreach (player in level.players) {
        player forcestreambundle(#"p8_fxanim_zm_towers_chaos_pustule_bundle");
    }
    var_2eb8dae8 = struct::get(#"hash_397165fe5f092f4");
    var_2eb8dae8 scene::init();
    level util::delay(2, undefined, &function_81fc64a2);
    level zm_utility::function_1a046290(1);
    level.var_cc46bee = 1;
    level notify(#"force_transformations");
    level.var_f83f8181 = 1;
    a_s_spawns = struct::get_array(#"hash_7d29cf21e3c8924a");
    level util::delay(6, undefined, &function_e988007a, a_s_spawns);
    level waittill(#"hash_4a0610c40e953981");
    level notify(#"hash_1958c9ee2f84d722");
    zm_transform::function_204b0737();
    function_3fc94d2a(array("danu_basement_to_bottom_floor"));
    level thread zm_audio::sndannouncerplayvox(#"hash_70f3ffdacf094858");
    level flag::set(#"hash_55461b9e82131f3");
    scene::remove_scene_func(#"p8_fxanim_zm_towers_chaos_pustule_bundle", &function_8d2cace8, "init");
    scene::add_scene_func(#"p8_fxanim_zm_towers_chaos_pustule_bundle", &function_8d2cace8, "init", 1);
    var_2eb8dae8 = struct::get(#"hash_7affc75e99913586");
    var_2eb8dae8 scene::init();
    a_s_spawns = struct::get_array(#"hash_3770024d403ec8f");
    level thread function_e988007a(a_s_spawns);
    level waittill(#"hash_4a0610c40e953981");
    level notify(#"hash_1958c9ee2f84d722");
    zm_transform::function_204b0737();
    function_3fc94d2a(array("danu_bottom_floor_to_top_floor"));
    level flag::set(#"hash_1596bce02bfee2fe");
    level thread zm_audio::sndannouncerplayvox(#"hash_5b34919a0ea0ac80");
    scene::remove_scene_func(#"p8_fxanim_zm_towers_chaos_pustule_bundle", &function_8d2cace8, "init");
    scene::add_scene_func(#"p8_fxanim_zm_towers_chaos_pustule_bundle", &function_8d2cace8, "init", 0);
    var_2eb8dae8 = struct::get(#"hash_5373280f2e2970d2");
    var_2eb8dae8 scene::init();
    a_s_spawns = struct::get_array(#"hash_7eb507df7ad5934f");
    level thread function_e988007a(a_s_spawns);
    level waittill(#"hash_4a0610c40e953981");
    playsoundatposition(#"hash_1fd377e4062391ab", (0, 0, 0));
    level notify(#"hash_1958c9ee2f84d722");
    zm_transform::function_204b0737();
    function_3fc94d2a(level.var_f1bf35ea.var_768a6c4d);
    level flag::clear("spawn_zombies");
    level thread zm_utility::function_1a046290(0);
    level util::delay(1, undefined, &teleport::team, #"s_teleport_end_decay", undefined, 1);
    level util::delay(1, undefined, &clientfield::set, "" + #"hash_3c58464f16d8a1be", 0);
    level flag::delay_set(6, "spawn_zombies");
    level flag::set(#"hash_498204258011f15e");
    level clientfield::set("" + #"hash_73088ea3053b96f1", 0);
    level thread function_3d42ce8a();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0xae33db1e, Offset: 0x5588
// Size: 0x3c
function function_8d2cace8(a_ents, var_cef90965) {
    a_ents[#"blight_blister"] thread function_fff83dc4(var_cef90965);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xd46cf1d8, Offset: 0x55d0
// Size: 0xfc
function function_38f4a3b7() {
    e_player = array::random(util::get_active_players());
    e_player zm_vo::vo_stop();
    e_player zm_vo::function_59635cc4("m_quest_chaos_realm_enter", 0, 0, 9999, 1);
    level zm_audio::sndannouncerplayvox(#"hash_bc10546af7f7b09");
    e_player = array::random(util::get_active_players());
    e_player zm_vo::vo_stop();
    e_player zm_vo::function_59635cc4("m_quest_chaos_realm_react", 0, 0, 9999, 1);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xe74ceb1, Offset: 0x56d8
// Size: 0x94
function function_3d42ce8a() {
    level zm_audio::sndannouncerplayvox(#"hash_3d5fccf222ba3ab6");
    e_player = array::random(util::get_active_players());
    e_player zm_vo::vo_stop();
    e_player zm_vo::function_59635cc4("m_quest_danu_complete", 0, 0, 9999, 1);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0xc8a1f6e2, Offset: 0x5778
// Size: 0x350
function function_a421f4e3(b_skipped, var_c86ff890) {
    if (b_skipped || var_c86ff890) {
        level flag::set("spawn_zombies");
    }
    if (var_c86ff890) {
        teleport::team("s_teleport_end_decay");
    }
    level.var_cc46bee = undefined;
    level.var_f83f8181 = undefined;
    level.var_9d42e617 = undefined;
    level.var_dcc8a45d = undefined;
    function_bd5f6c56(1);
    level flag::clear("pause_round_timeout");
    function_3fc94d2a(level.var_f1bf35ea.var_768a6c4d);
    level flag::set(#"hash_498204258011f15e");
    level flag::set(#"hash_23c79f4deefd8aa1");
    foreach (player in level.players) {
        player function_5094c112(#"p8_fxanim_zm_towers_chaos_pustule_bundle");
    }
    level clientfield::set("" + #"hash_3c58464f16d8a1be", 0);
    exploder::exploder("exp_danu_eyes");
    playsoundatposition(#"hash_6bc2c65bdaed35d4", (0, 0, 0));
    a_s_spawns = struct::get_array(#"player_respawn_point");
    var_1dfe9e5b = array("zone_danu_basement_decayed", "zone_danu_ground_floor_decayed", "zone_danu_top_floor_decayed");
    foreach (s_spawn in a_s_spawns) {
        if (isinarray(var_1dfe9e5b, s_spawn.script_noteworthy)) {
            a_s_player_spawns = struct::get_array(s_spawn.target);
            array::delete_all(a_s_player_spawns);
            s_spawn struct::delete();
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xb9b4eea1, Offset: 0x5ad0
// Size: 0x12c
function function_81fc64a2() {
    level clientfield::set("" + #"hash_3c58464f16d8a1be", 1);
    zm_zonemgr::enable_zone(#"zone_danu_basement_decayed");
    teleport::team("s_teleport_start_decay", undefined, 1);
    function_c8851a77(level.var_f1bf35ea.var_768a6c4d);
    exploder::stop_exploder("exp_danu_portal");
    array::thread_all(level.players, &val::reset, #"chaos_teleport", "ignoreme");
    level clientfield::set("" + #"hash_73088ea3053b96f1", 1);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xbcab2ab5, Offset: 0x5c08
// Size: 0x2b2
function function_e9c5a148() {
    level endon(#"end_game");
    trigger::wait_till("t_fertilizer_enter");
    var_dec3da61 = getent("t_fertilizer_enter", "targetname");
    var_dae06dd1 = 0;
    var_dec3da61 playsound(#"hash_668420a3544ac61a");
    var_7871dcdc = 13;
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            var_7871dcdc = 3;
        }
    #/
    while (true) {
        var_a8f89ed8 = 0;
        foreach (player in level.activeplayers) {
            if (!player istouching(var_dec3da61)) {
                var_a8f89ed8 = 1;
                break;
            }
        }
        if (level flag::get("special_round") || level flag::get(#"hash_4fd3d0c01f9b4c30")) {
            waitframe(1);
            continue;
        }
        if (var_a8f89ed8) {
            var_dae06dd1 = 0;
            level flag::set("spawn_zombies");
            waitframe(1);
            continue;
        }
        /#
            if (var_dae06dd1 > 0) {
                if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                    iprintlnbold("<dev string:x30>" + var_dae06dd1);
                    println("<dev string:x30>" + var_dae06dd1);
                }
            }
        #/
        wait 1;
        var_dae06dd1++;
        if (var_dae06dd1 == var_7871dcdc - 2) {
            level flag::clear("spawn_zombies");
        }
        if (var_dae06dd1 >= var_7871dcdc) {
            break;
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x691a8257, Offset: 0x5ec8
// Size: 0x76
function function_bd5f6c56(b_enable = 1) {
    if (b_enable) {
        level.var_2d4e3645 = level.var_939891e;
        level.var_939891e = undefined;
        return;
    }
    level.var_939891e = level.var_2d4e3645;
    level.var_2d4e3645 = &function_126e9ac1;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x19d8602b, Offset: 0x5f48
// Size: 0xe
function function_126e9ac1(var_881ff7f5) {
    return [];
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x706ce30e, Offset: 0x5f60
// Size: 0x22c
function function_e988007a(a_s_spawns) {
    level endon(#"end_game", #"hash_1958c9ee2f84d722", #"hash_498204258011f15e");
    var_a7b008aa = getspawnerarray("spawner_zm_zombie", "targetname")[0];
    var_3a646a31 = 0;
    while (true) {
        s_spawn = array::random(a_s_spawns);
        ai = undefined;
        while (!isdefined(ai)) {
            ai = zombie_utility::spawn_zombie(var_a7b008aa, "fertilizer_zombies", s_spawn, max(15, level.round_number));
            waitframe(1);
        }
        if (math::cointoss()) {
            ai.var_24c73ad5 = 1;
            zm_transform::function_78f90f3b(ai, "catalyst_corrosive");
            ai zombie_utility::set_zombie_run_cycle("super_sprint");
        } else {
            ai zombie_utility::set_zombie_run_cycle("sprint");
        }
        var_3a646a31++;
        a_ai_zombies = zombie_utility::get_round_enemy_array();
        n_max_zombies = min(24, level.players.size * 7);
        if (a_ai_zombies.size < n_max_zombies) {
            wait randomfloatrange(0.2, 0.5);
            continue;
        }
        if (var_3a646a31 > n_max_zombies) {
            var_3a646a31 = 0;
            wait 10;
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x3c727fc3, Offset: 0x6198
// Size: 0x550
function function_fff83dc4(var_cef90965 = 0) {
    self notify("5dcbd9579010c6f9");
    self endon("5dcbd9579010c6f9");
    level endon(#"end_game");
    self clientfield::set("rob_zm_prop_fade", 1);
    self val::set(#"blight_blister", "takedamage", 1);
    self val::set(#"blight_blister", "allowdeath", 1);
    if (level.players.size == 1) {
        self.health = 25000;
    } else {
        self.health = 30000 * level.players.size;
    }
    self.maxhealth = self.health;
    self.var_bc6bbe36 = 0;
    self.var_966943cd = 0;
    var_ce3a2da5 = arraygetclosest(self.origin, level.players);
    while (self.health > 0) {
        s_waitresult = self waittill(#"damage");
        if (isplayer(s_waitresult.attacker)) {
            if (self.health <= 0) {
                s_waitresult.attacker util::show_hit_marker(1);
            } else {
                s_waitresult.attacker util::show_hit_marker(0);
            }
            var_ce3a2da5 = s_waitresult.attacker;
        }
        if (!self.var_bc6bbe36 && self.health < self.maxhealth * 0.66) {
            self.var_bc6bbe36 = 1;
            self thread scene::play(#"p8_fxanim_zm_towers_chaos_pustule_bundle", "damage01", self);
        }
        if (!self.var_966943cd && self.health < self.maxhealth * 0.33) {
            self.var_966943cd = 1;
            self thread scene::play(#"p8_fxanim_zm_towers_chaos_pustule_bundle", "damage02", self);
        }
    }
    foreach (player in level.activeplayers) {
        if (distance(self.origin, player.origin) < 256) {
            player clientfield::set_to_player("blight_father_vomit_postfx_clientfield", 1);
            player util::delay(3, "disconnect", &clientfield::set_to_player, "blight_father_vomit_postfx_clientfield", 0);
        }
    }
    self clientfield::set("blight_father_chaos_missile_explosion_clientfield", 1);
    self val::reset(#"blight_blister", "takedamage");
    self val::reset(#"blight_blister", "allowdeath");
    self thread scene::play(#"p8_fxanim_zm_towers_chaos_pustule_bundle", "damage03", self);
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x44>");
            println("<dev string:x44>");
        }
    #/
    if (var_cef90965) {
        var_934b6e06 = groundtrace(var_ce3a2da5.origin + (0, 0, 8), var_ce3a2da5.origin + (0, 0, -100000), 0, var_ce3a2da5)[#"position"];
        level thread function_853f9fb7(self.origin, var_934b6e06);
    }
    level notify(#"hash_4a0610c40e953981");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x7346ff25, Offset: 0x66f0
// Size: 0x84
function function_853f9fb7(v_start, v_end) {
    e_powerup = zm_powerups::specific_powerup_drop("full_ammo", v_start - (0, 0, 40), undefined, undefined, undefined, 1);
    e_powerup moveto(v_end + (0, 0, 40), 1.5);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xe05568cb, Offset: 0x6780
// Size: 0x46e
function function_395bfa5a() {
    level.s_puzzle = spawnstruct();
    level.var_fbf9bd8e = getentarray("bull_head", "script_noteworthy");
    foreach (bull_head in level.var_fbf9bd8e) {
        bull_head hide();
        t_damage = getent(bull_head.target, "targetname");
        t_damage setinvisibletoall();
    }
    level.var_1fe9d182 = 0;
    level.var_5d9f148c = 0;
    level.var_ba7a0989 = struct::get("s_ra_destroyer_soul_collect_end", "targetname");
    level.var_dc494bf3 = array(#"spawner_zm_gladiator_marauder", #"spawner_zm_gladiator_destroyer", #"spawner_zm_blight_father", #"spawner_zm_catalyst_plasma", #"spawner_zm_catalyst_corrosive", #"spawner_zm_catalyst_water", #"spawner_zm_catalyst_electric", #"spawner_zm_tiger");
    level.var_89393fac = getentarray("zm_puzzle_rune_round1", "script_noteworthy");
    level.var_89393fac = array::sort_by_script_int(level.var_89393fac, 1);
    level.var_f407f612 = getent("mdl_ra_puzzle_activate_glyph1", "targetname");
    level.var_f407f612 hide();
    level.var_2709cb2a = 0;
    var_e3042885 = array("b", "c", "d", "m", "p", "r", "t", "w");
    foreach (var_1c0b22ae in level.var_89393fac) {
        var_1c0b22ae hide();
        foreach (var_c36977aa in var_e3042885) {
            var_1c0b22ae hidepart("tag_" + var_c36977aa + "_glyph");
            var_1c0b22ae hidepart("tag_" + var_c36977aa + "_glow");
        }
    }
    level.var_e634722 = getent("s_ra_laser_eyes_start", "targetname");
    level.var_10f4bd78 = getent("puzzle_complete_beam_start", "targetname");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xb70425f7, Offset: 0x6bf8
// Size: 0x374
function activate_bulls_setup(b_skipped) {
    level endon(#"bull_heads_completed");
    level clientfield::set("" + #"hash_57c08e5f4792690c", 1);
    if (b_skipped) {
        level.var_fbf9bd8e = array::randomize(level.var_fbf9bd8e);
        level.var_6b155580 = array(level.var_fbf9bd8e[0], level.var_fbf9bd8e[1], level.var_fbf9bd8e[2], level.var_fbf9bd8e[3]);
        return;
    }
    level.var_fbf9bd8e = array::randomize(level.var_fbf9bd8e);
    level.var_6b155580 = array(level.var_fbf9bd8e[0], level.var_fbf9bd8e[1], level.var_fbf9bd8e[2], level.var_fbf9bd8e[3]);
    foreach (var_ef82e8b7 in level.var_6b155580) {
        var_ef82e8b7 show();
        t_damage = getent(var_ef82e8b7.target, "targetname");
        t_damage setvisibletoall();
        t_damage thread function_4ce8918(var_ef82e8b7);
    }
    while (level.var_5d9f148c < 4) {
        level waittill(#"hash_6f1bcde6921bc480");
        level.var_5d9f148c++;
    }
    level.var_e634722 clientfield::set("ra_eyes_beam_fire", 1);
    wait 4;
    level.var_f407f612 show();
    level.var_2709cb2a = 1;
    level.var_f407f612 playsound(#"hash_708d124fb1b2203e");
    level.var_b381f147 = level.var_f407f612 zm_unitrigger::create(&function_9e519867, 64, &function_a0a36539);
    wait 2;
    level.var_e634722 clientfield::set("ra_eyes_beam_fire", 0);
    level flag::set(#"bull_heads_completed");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xdc7ef709, Offset: 0x6f78
// Size: 0x14c
function function_4ce8918(var_ef82e8b7) {
    level endon(#"end_game");
    self endon(#"death");
    while (true) {
        s_info = self waittill(#"damage");
        if (function_bada7b90(s_info.weapon)) {
            playfx(level._effect[#"brazier_fire"], var_ef82e8b7.origin);
            var_ef82e8b7 playsound(#"hash_419d268160428733");
            level.var_1fe9d182++;
            e_player = s_info.attacker;
            str_zone = e_player zm_utility::get_current_zone();
            spawn_ra_destroyer(var_ef82e8b7, str_zone);
            self delete();
            break;
        }
        continue;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xefaabc0e, Offset: 0x70d0
// Size: 0x72
function function_bada7b90(weapon) {
    switch (weapon.name) {
    case #"zhield_zword_dw":
        return 1;
    case #"zhield_zword_turret":
        return 1;
    default:
        return 0;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x31c6e293, Offset: 0x7150
// Size: 0x1c0
function spawn_ra_destroyer(var_ef82e8b7, str_zone = "") {
    a_s_spawns = struct::get_array(var_ef82e8b7.target);
    s_spawn = a_s_spawns[0];
    if (a_s_spawns.size > 1 && str_zone != "") {
        str_tower = "odin_ground";
        switch (str_zone) {
        case #"zone_odin_top_floor":
            str_tower = "odin_top";
            break;
        case #"zone_odin_zeus_bridge":
            str_tower = "zeus";
            break;
        }
        foreach (s_option in a_s_spawns) {
            if (s_option.var_8fa67519 === str_tower) {
                s_spawn = s_option;
                break;
            }
        }
    }
    ai_destroyer = undefined;
    while (!isdefined(ai_destroyer)) {
        ai_destroyer = zombie_gladiator_util::function_e8c77e88(1, "ranged", &function_b442a256, 1, s_spawn);
        waitframe(1);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x21134582, Offset: 0x7318
// Size: 0x45c
function function_b442a256(s_spot) {
    self endon(#"death");
    self val::set(#"hash_56df0defacc86bb7", "allowdeath", 0);
    self.var_da4cbdc4 = 1;
    self.no_powerups = 1;
    self.var_2e8cef76 = 1;
    self.ignore_round_spawn_failsafe = 1;
    self.b_ignore_cleanup = 1;
    self.ignore_enemy_count = 1;
    var_9549afb9 = int(self.health * 3);
    self.health = var_9549afb9;
    self.maxhealth = var_9549afb9;
    namespace_9088c704::initweakpoints(self, "c_t8_zmb_gladiator_dst_weakpoint_def");
    self ai::set_behavior_attribute("axe_throw", 0);
    self ai::set_behavior_attribute("run", 1);
    self thread zm_towers_special_rounds::function_36dc5475(s_spot);
    self clientfield::set("" + #"hash_233e31d0c2b47b1b", 1);
    self clientfield::set("" + #"hash_12dfb8249f8212d2", 1);
    self clientfield::set("" + #"hash_17e3041649954b9f", 1);
    self thread function_a48df2b9("left");
    self thread function_a48df2b9("right");
    if (isdefined(s_spot.var_b51e9cab)) {
        self waittill(#"hash_7ff69a201a93f099");
    }
    while (true) {
        var_3551d88 = self waittill(#"damage", #"both_arms_destroyed");
        if (var_3551d88._notify == "both_arms_destroyed" || self.health <= 1) {
            break;
        }
    }
    self playsound(#"wpn_scorpion_zombie_impact");
    self playloopsound(#"wpn_scorpion_zombie_lp");
    self thread scene::play("aib_t8_zm_gladiator_dth_ra_puzzle", self);
    wait 5;
    level thread function_8cecf395(self.origin);
    self playsound(#"wpn_scorpion_zombie_explode");
    self stoploopsound();
    self scene::stop("aib_t8_zm_gladiator_dth_ra_puzzle");
    self val::reset(#"hash_56df0defacc86bb7", "allowdeath");
    self clientfield::set("" + #"hash_233e31d0c2b47b1b", 0);
    self function_8ae5d2ce("left");
    self function_8ae5d2ce("right");
    gibserverutils::annihilate(self);
    if (isalive(self)) {
        self kill();
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xa4d4b04d, Offset: 0x7780
// Size: 0x7c
function function_8ae5d2ce(str_arm) {
    if (str_arm == "right") {
        str_clientfield = "" + #"hash_17e3041649954b9f";
    } else {
        str_clientfield = "" + #"hash_12dfb8249f8212d2";
    }
    self clientfield::set(str_clientfield, 0);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xceed77ab, Offset: 0x7808
// Size: 0xa4
function function_a48df2b9(str_arm) {
    self endon(#"death");
    if (str_arm == "right") {
        while (!isdefined(self.var_7a8c9af2)) {
            waitframe(1);
        }
        while (self.var_7a8c9af2) {
            waitframe(1);
        }
    } else {
        while (!isdefined(self.var_3d795b5f)) {
            waitframe(1);
        }
        while (self.var_3d795b5f) {
            waitframe(1);
        }
    }
    self function_8ae5d2ce(str_arm);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x36e4885d, Offset: 0x78b8
// Size: 0x1ec
function function_8cecf395(v_start) {
    var_7eca4bb4 = util::spawn_model("tag_origin", v_start + (0, 0, 58));
    var_625d9fa2 = struct::get("s_ra_destroyer_soul_collect_end", "targetname");
    var_7eca4bb4 clientfield::set("" + #"chaos_ball", 1);
    var_7eca4bb4 playsound(#"zmb_sq_souls_release");
    var_7eca4bb4 playloopsound(#"zmb_sq_souls_lp");
    wait 1.25;
    level thread zm_audio::sndannouncerplayvox(#"hash_1ea992aea58bdc19" + level.var_5d9f148c);
    var_7eca4bb4 moveto(var_625d9fa2.origin, 8, 1, 0.5);
    var_7eca4bb4 waittill(#"movedone");
    var_7eca4bb4 stoploopsound();
    var_7eca4bb4 playsound(#"zmb_sq_souls_impact");
    var_7eca4bb4 clientfield::set("" + #"chaos_ball", 0);
    level notify(#"hash_6f1bcde6921bc480");
    var_7eca4bb4 delete();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x3f5a35e6, Offset: 0x7ab0
// Size: 0x214
function activate_bulls_cleanup(b_skipped, var_c86ff890) {
    level clientfield::set("" + #"hash_57c08e5f4792690c", 0);
    if (b_skipped || var_c86ff890) {
        foreach (var_ef82e8b7 in level.var_6b155580) {
            var_ef82e8b7 show();
            waitframe(1);
            playfx(level._effect[#"brazier_fire"], var_ef82e8b7.origin);
        }
        level flag::set(#"bull_heads_completed");
        level.var_e634722 clientfield::set("ra_eyes_beam_fire", 1);
        wait 4;
        level.var_f407f612 show();
        level.var_2709cb2a = 1;
        level.var_f407f612 playsound(#"hash_708d124fb1b2203e");
        level.var_b381f147 = level.var_f407f612 zm_unitrigger::create(&function_9e519867, 64, &function_a0a36539);
        wait 2;
        level.var_e634722 clientfield::set("ra_eyes_beam_fire", 0);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xbf36fb6, Offset: 0x7cd0
// Size: 0x4c
function activate_puzzle_setup(b_skipped) {
    level endon(#"end_game");
    if (b_skipped) {
        return;
    }
    level flag::wait_till(#"hash_7f6689c71e55e8ab");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xfd580f45, Offset: 0x7d28
// Size: 0x804
function function_bab792c4() {
    level endon(#"hash_15f894886f3d6ede");
    function_bd5f6c56(0);
    level flag::set(#"hash_36efad26d2c9c9cd");
    level flag::set(#"hash_4f293396150d2c00");
    level function_b7e5de3b(1);
    level.var_f407f612 hide();
    level.var_2709cb2a = 0;
    level.var_f407f612 playsound(#"hash_5ded242bd1525a14");
    level flag::clear("spawn_zombies");
    level flag::set(#"pause_round_timeout");
    level zm_utility::function_1a046290(1);
    var_b80c9145 = getent("connect_ra_basement_to_danu_ra_tunnel", "script_flag");
    if (!(isdefined(var_b80c9145.has_been_opened) && var_b80c9145.has_been_opened)) {
        var_b80c9145 thread zm_blockers::door_opened();
    }
    var_9c84fc50 = getentarray("connect_danu_ra_bridge", "script_flag");
    foreach (t_door in var_9c84fc50) {
        if (!(isdefined(t_door.has_been_opened) && t_door.has_been_opened)) {
            t_door thread zm_blockers::door_opened();
        }
    }
    waitframe(1);
    playsoundatposition(#"hash_6f4dbc9a189140b9", (0, 0, 0));
    function_c8851a77(array("connect_danu_ra_bridge", "connect_starting_area_to_ra_hallway", "connect_ra_basement_to_danu_ra_tunnel"));
    function_6251040c();
    zm_blockers::function_53852af7("zm_towers_puzzle_drop_boards", "script_label", 1);
    level.var_95f27056 = function_e93acd47(level.var_dc494bf3);
    for (i = 0; i < level.var_89393fac.size; i++) {
        level.var_89393fac[i] function_d3c0767a(level.var_95f27056[i]);
    }
    level clientfield::set("" + #"hash_440f23773f551a48", 1);
    if (!level flag::exists(#"hash_2d534800e5276c41")) {
        level flag::init(#"hash_2d534800e5276c41");
        level flag::set(#"hash_2d534800e5276c41");
        level thread zm_audio::sndannouncerplayvox(#"hash_412f0a99d31887f");
    }
    wait 3;
    foreach (i, mdl_glyph in level.var_89393fac) {
        /#
            function_ac5772e7(level.var_95f27056[i]);
        #/
        mdl_glyph show();
        mdl_glyph playsound(#"hash_3a68c26240abda9b");
        wait 1.75;
        mdl_glyph hide();
        mdl_glyph playsound(#"hash_63661f92ceba62ea");
    }
    level clientfield::set("" + #"hash_440f23773f551a48", 0);
    level.var_8fd3c43a = 0;
    level zm_spawner::register_zombie_death_event_callback(&function_e0ab0352);
    a_s_spawns = struct::get_array("ra_puzzle_top_floor");
    level thread function_9eacfabf(a_s_spawns);
    zm_transform::function_bfc50dca(#"hash_7c02083c1e4c8ddd");
    level flag::wait_till(#"hash_e35ac19ee7b732c");
    level flag::clear(#"hash_36efad26d2c9c9cd");
    level flag::clear(#"hash_4f293396150d2c00");
    level notify(#"hash_5e0d8fb9b497a1f3");
    level zm_utility::function_1a046290(0, 1);
    function_3fc94d2a(array("connect_danu_ra_bridge", "connect_starting_area_to_ra_hallway", "connect_ra_basement_to_danu_ra_tunnel"));
    level function_52825b06();
    function_70f3f2d3();
    wait 1;
    level flag::set("spawn_zombies");
    level flag::clear(#"pause_round_timeout");
    function_bd5f6c56(1);
    level zm_spawner::deregister_zombie_death_event_callback(&function_e0ab0352);
    zm_transform::function_5eefd607(#"hash_7c02083c1e4c8ddd");
    level.var_e634722 clientfield::set("ra_eyes_beam_fire", 1);
    wait 4;
    level.var_f407f612 show();
    level.var_2709cb2a = 1;
    level.var_f407f612 playsound(#"hash_708d124fb1b2203e");
    wait 2;
    level.var_e634722 clientfield::set("ra_eyes_beam_fire", 0);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xb7d0dd08, Offset: 0x8538
// Size: 0x7a4
function function_2cbf01ff() {
    level endon(#"hash_1381e879a94f5081");
    function_bd5f6c56(0);
    level flag::set(#"hash_768860cb3ad76c68");
    level flag::set(#"hash_4f293396150d2c00");
    level function_b7e5de3b(1);
    foreach (var_1c0b22ae in level.var_89393fac) {
        var_1c0b22ae hide();
    }
    level.var_f407f612 hide();
    level.var_2709cb2a = 0;
    level.var_f407f612 playsound(#"hash_5ded242bd1525a14");
    level flag::clear("spawn_zombies");
    level flag::set(#"pause_round_timeout");
    zm_transform::function_bfc50dca(#"hash_7c02083c1e4c8ddd");
    level zm_utility::function_1a046290(1, 1);
    function_c8851a77(array("connect_danu_ra_bridge", "connect_starting_area_to_ra_hallway", "connect_ra_basement_to_danu_ra_tunnel"));
    function_6251040c();
    zm_blockers::function_53852af7("zm_towers_puzzle_drop_boards", "script_label", 1);
    level.var_9f192437 = function_e93acd47(level.var_dc494bf3);
    for (i = 0; i < level.var_89393fac.size; i++) {
        level.var_89393fac[i] function_d3c0767a(level.var_9f192437[i]);
    }
    level clientfield::set("" + #"hash_440f23773f551a48", 1);
    playsoundatposition(#"hash_6f4dbc9a189140b9", (0, 0, 0));
    wait 3;
    level.var_dc494bf3 = array(#"spawner_zm_gladiator_marauder", #"spawner_zm_gladiator_destroyer", #"spawner_zm_blight_father", #"spawner_zm_catalyst_plasma", #"spawner_zm_catalyst_corrosive", #"spawner_zm_catalyst_water", #"spawner_zm_catalyst_electric", #"spawner_zm_tiger");
    foreach (i, mdl_glyph in level.var_89393fac) {
        /#
            function_ac5772e7(level.var_9f192437[i]);
        #/
        mdl_glyph show();
        mdl_glyph playsound(#"hash_3a68c26240abda9b");
        wait 1.75;
        mdl_glyph hide();
        mdl_glyph playsound(#"hash_63661f92ceba62ea");
    }
    level clientfield::set("" + #"hash_440f23773f551a48", 0);
    level.var_8fd3c43a = 0;
    level zm_spawner::register_zombie_death_event_callback(&function_e0ab0352);
    a_s_spawns = struct::get_array("ra_puzzle_top_floor");
    level thread function_9eacfabf(a_s_spawns);
    level flag::wait_till(#"hash_77bd156a70de5aa3");
    level flag::clear(#"hash_768860cb3ad76c68");
    level flag::clear(#"hash_4f293396150d2c00");
    level notify(#"hash_5e0d8fb9b497a1f3");
    level zm_utility::function_1a046290(0);
    function_3fc94d2a(array("connect_danu_ra_bridge", "connect_starting_area_to_ra_hallway", "connect_ra_basement_to_danu_ra_tunnel"));
    level function_52825b06();
    function_70f3f2d3();
    wait 1;
    level thread function_56888707();
    level flag::set("spawn_zombies");
    level flag::clear(#"pause_round_timeout");
    function_bd5f6c56(1);
    level zm_spawner::deregister_zombie_death_event_callback(&function_e0ab0352);
    zm_transform::function_5eefd607(#"hash_7c02083c1e4c8ddd");
    level.var_10f4bd78 clientfield::set("ra_rooftop_eyes_beam_fire", 1);
    wait 10;
    function_cb00e8e9();
    wait 2;
    level.var_10f4bd78 clientfield::set("ra_rooftop_eyes_beam_fire", 0);
    level flag::set(#"hash_7f6689c71e55e8ab");
    zm_unitrigger::unregister_unitrigger(level.var_b381f147);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x96f93fcd, Offset: 0x8ce8
// Size: 0x94
function function_56888707() {
    level zm_audio::sndannouncerplayvox(#"hash_5719edb294612f4c");
    e_player = array::random(util::get_active_players());
    e_player zm_vo::vo_stop();
    e_player zm_vo::function_59635cc4("m_quest_ra_complete_resp", 0, 0, 9999, 1);
}

/#

    // Namespace zm_towers_main_quest/zm_towers_main_quest
    // Params 1, eflags: 0x4
    // Checksum 0x63359565, Offset: 0x8d88
    // Size: 0x164
    function private function_ac5772e7(str_key) {
        if (!getdvarint(#"zm_debug_ee", 0)) {
            return;
        }
        switch (str_key) {
        case #"spawner_zm_gladiator_marauder":
            str_ai = "<dev string:x5d>";
            break;
        case #"spawner_zm_gladiator_destroyer":
            str_ai = "<dev string:x66>";
            break;
        case #"spawner_zm_blight_father":
            str_ai = "<dev string:x70>";
            break;
        case #"spawner_zm_catalyst_plasma":
            str_ai = "<dev string:x7e>";
            break;
        case #"spawner_zm_catalyst_corrosive":
            str_ai = "<dev string:x85>";
            break;
        case #"spawner_zm_catalyst_water":
            str_ai = "<dev string:x8f>";
            break;
        case #"spawner_zm_catalyst_electric":
            str_ai = "<dev string:x96>";
            break;
        case #"spawner_zm_tiger":
            str_ai = "<dev string:x9f>";
            break;
        }
        iprintlnbold(str_ai);
    }

#/

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xd9295966, Offset: 0x8ef8
// Size: 0x204
function function_9e519867() {
    var_e6f71433 = getplayers();
    level.var_47ac12a8 = 0;
    var_8296ee71 = #"zone_ra_top_floor";
    if (zm_zonemgr::get_players_in_zone(var_8296ee71) == var_e6f71433.size && !level flag::get(#"hash_4f293396150d2c00") && isdefined(level.var_2709cb2a) && level.var_2709cb2a) {
        level.var_47ac12a8 = 1;
        return 1;
    }
    if (zm_zonemgr::get_players_in_zone(var_8296ee71) < var_e6f71433.size && !level flag::get(#"hash_4f293396150d2c00") && isdefined(level.var_2709cb2a) && level.var_2709cb2a) {
        level.var_47ac12a8 = 0;
        return 1;
    }
    if (level flag::get(#"hash_4f293396150d2c00") && level flag::get(#"hash_e35ac19ee7b732c") && !level flag::get(#"hash_768860cb3ad76c68") && !level flag::get(#"hash_77bd156a70de5aa3") && level.var_2709cb2a) {
        level.var_47ac12a8 = 1;
        return 1;
    }
    return 0;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xab4e4bca, Offset: 0x9108
// Size: 0x180
function function_a0a36539() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        if (level flag::get("special_round") || level flag::get(#"hash_4fd3d0c01f9b4c30")) {
            continue;
        }
        e_player = waitresult.activator;
        if (!zm_utility::can_use(e_player)) {
            continue;
        }
        if (isdefined(level.var_47ac12a8) && level.var_47ac12a8 && !level flag::get(#"hash_e35ac19ee7b732c")) {
            level function_bab792c4();
            continue;
        }
        if (isdefined(level.var_47ac12a8) && level.var_47ac12a8 && !level flag::get(#"hash_77bd156a70de5aa3")) {
            level function_2cbf01ff();
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x8e82b828, Offset: 0x9290
// Size: 0x54
function function_8ba63bcd(e_player) {
    if (level flag::exists(#"hash_4f293396150d2c00")) {
        return level flag::get(#"hash_4f293396150d2c00");
    }
    return 0;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x1c14490e, Offset: 0x92f0
// Size: 0x196
function function_9eacfabf(a_s_spawns) {
    level endon(#"end_game", #"hash_5e0d8fb9b497a1f3");
    var_a7b008aa = getspawnerarray("spawner_zm_zombie", "targetname")[0];
    level.var_6117c0c3 = 0;
    level function_407f65fa(a_s_spawns);
    while (true) {
        n_players = util::get_active_players().size;
        var_181858f6 = max(9, n_players * 5);
        s_spawn = array::random(a_s_spawns);
        ai = undefined;
        while (!isdefined(ai)) {
            ai = zombie_utility::spawn_zombie(var_a7b008aa, "ra_puzzle_add_zombies", s_spawn, level.round_number);
            ai.var_2cd0795a = 1;
            ai zombie_utility::set_zombie_run_cycle_override_value("sprint");
        }
        level.var_6117c0c3++;
        if (level.var_6117c0c3 < var_181858f6) {
            wait 0.5;
            continue;
        }
        wait 3;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x4d8317c4, Offset: 0x9490
// Size: 0x190
function function_407f65fa(a_s_spawns) {
    if (level flag::exists(#"hash_36efad26d2c9c9cd") && level flag::get(#"hash_36efad26d2c9c9cd")) {
        foreach (str_spawner in level.var_95f27056) {
            function_107aaf6(str_spawner, a_s_spawns);
        }
        return;
    }
    if (level flag::exists(#"hash_768860cb3ad76c68") && level flag::get(#"hash_768860cb3ad76c68")) {
        foreach (str_spawner in level.var_9f192437) {
            function_107aaf6(str_spawner, a_s_spawns);
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x4b916350, Offset: 0x9628
// Size: 0x85a
function function_107aaf6(str_spawner, a_s_spawns) {
    var_b28327e9 = struct::get_array(#"hash_3b52c5d77ba61fd3", "targetname");
    var_e1db1ac9 = array::random(var_b28327e9);
    s_spawn = array::random(a_s_spawns);
    switch (str_spawner) {
    case #"spawner_zm_gladiator_marauder":
        var_6f0b660b = getspawnerarray("zombie_spawner_marauder", "targetname")[0];
        ai = undefined;
        while (!isdefined(ai)) {
            ai = zombie_utility::spawn_zombie(var_6f0b660b, "ra_puzzle_answer_spawn", s_spawn, level.round_number);
            wait 0.5;
        }
        ai.var_2e8cef76 = 1;
        ai.ignore_round_spawn_failsafe = 1;
        ai.b_ignore_cleanup = 1;
        ai.ignore_enemy_count = 1;
        ai.var_2cd0795a = 1;
        break;
    case #"spawner_zm_gladiator_destroyer":
        var_6f0b660b = getspawnerarray("zombie_spawner_destroyer", "targetname")[0];
        ai = undefined;
        while (!isdefined(ai)) {
            ai = zombie_utility::spawn_zombie(var_6f0b660b, "ra_puzzle_answer_spawn", s_spawn, level.round_number);
            wait 0.5;
        }
        ai.var_2e8cef76 = 1;
        ai.ignore_round_spawn_failsafe = 1;
        ai.b_ignore_cleanup = 1;
        ai.ignore_enemy_count = 1;
        ai.var_2cd0795a = 1;
        break;
    case #"spawner_zm_tiger":
        var_6f0b660b = getspawnerarray("zombie_spawner_tiger", "targetname")[0];
        ai = undefined;
        while (!isdefined(ai)) {
            ai = zombie_utility::spawn_zombie(var_6f0b660b, "ra_puzzle_answer_spawn", s_spawn, level.round_number);
            wait 0.5;
        }
        ai.var_2e8cef76 = 1;
        ai.ignore_round_spawn_failsafe = 1;
        ai.b_ignore_cleanup = 1;
        ai.ignore_enemy_count = 1;
        ai.var_2cd0795a = 1;
        break;
    case #"spawner_zm_blight_father":
        ai = undefined;
        while (!isdefined(ai)) {
            ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], "ra_puzzle_answer_spawn", var_e1db1ac9, level.round_number);
            wait 0.5;
        }
        ai.var_2e8cef76 = 1;
        ai.ignore_round_spawn_failsafe = 1;
        ai.b_ignore_cleanup = 1;
        ai.ignore_enemy_count = 1;
        ai.var_2cd0795a = 1;
        while (zm_transform::function_5836d278("blight_father")) {
            waitframe(1);
        }
        zm_transform::function_3b866d7e(ai, "blight_father", &function_91551630);
        break;
    case #"spawner_zm_catalyst_plasma":
        ai = undefined;
        while (!isdefined(ai)) {
            ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], "ra_puzzle_answer_spawn", s_spawn, level.round_number);
            wait 0.5;
        }
        ai.var_2e8cef76 = 1;
        ai.ignore_round_spawn_failsafe = 1;
        ai.b_ignore_cleanup = 1;
        ai.ignore_enemy_count = 1;
        ai.var_2cd0795a = 1;
        while (zm_transform::function_5836d278("catalyst_plasma")) {
            waitframe(1);
        }
        zm_transform::function_3b866d7e(ai, "catalyst_plasma", &function_91551630);
        break;
    case #"spawner_zm_catalyst_corrosive":
        ai = undefined;
        while (!isdefined(ai)) {
            ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], "ra_puzzle_answer_spawn", s_spawn, level.round_number);
            wait 0.5;
        }
        ai.var_2e8cef76 = 1;
        ai.ignore_round_spawn_failsafe = 1;
        ai.b_ignore_cleanup = 1;
        ai.ignore_enemy_count = 1;
        ai.var_2cd0795a = 1;
        while (zm_transform::function_5836d278("catalyst_corrosive")) {
            waitframe(1);
        }
        zm_transform::function_3b866d7e(ai, "catalyst_corrosive", &function_91551630);
        break;
    case #"spawner_zm_catalyst_water":
        ai = undefined;
        while (!isdefined(ai)) {
            ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], "ra_puzzle_answer_spawn", var_e1db1ac9, level.round_number);
            wait 0.5;
        }
        ai.var_2e8cef76 = 1;
        ai.ignore_round_spawn_failsafe = 1;
        ai.b_ignore_cleanup = 1;
        ai.ignore_enemy_count = 1;
        ai.var_2cd0795a = 1;
        while (zm_transform::function_5836d278("catalyst_water")) {
            waitframe(1);
        }
        zm_transform::function_3b866d7e(ai, "catalyst_water", &function_91551630);
        break;
    case #"spawner_zm_catalyst_electric":
        ai = undefined;
        while (!isdefined(ai)) {
            ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], "ra_puzzle_answer_spawn", s_spawn, level.round_number);
            wait 0.5;
        }
        ai.var_2e8cef76 = 1;
        ai.ignore_round_spawn_failsafe = 1;
        ai.b_ignore_cleanup = 1;
        ai.ignore_enemy_count = 1;
        ai.var_2cd0795a = 1;
        while (zm_transform::function_5836d278("catalyst_electric")) {
            waitframe(1);
        }
        zm_transform::function_3b866d7e(ai, "catalyst_electric", &function_91551630);
        break;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xf31bb9b6, Offset: 0x9e90
// Size: 0x132
function function_91551630(ai) {
    if (isdefined(ai.var_ea94c12a) && ai.var_ea94c12a == "catalyst_plasma") {
        ai callback::function_1dea870d(#"on_ai_killed", &function_fc2edf25);
    } else if (ai.archetype === "blight_father") {
        var_4df7e1c1 = array(#"zone_ra_top_floor", #"zone_ra_ground_floor", #"zone_ra_basement");
        ai thread function_7e378484(var_4df7e1c1);
    }
    ai.var_2e8cef76 = 1;
    ai.ignore_round_spawn_failsafe = 1;
    ai.b_ignore_cleanup = 1;
    ai.ignore_enemy_count = 1;
    ai.var_2cd0795a = 1;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xff61d2a7, Offset: 0x9fd0
// Size: 0x12c
function function_fc2edf25(params) {
    if (!isplayer(params.eattacker)) {
        if (level flag::exists(#"hash_36efad26d2c9c9cd") && level flag::get(#"hash_36efad26d2c9c9cd")) {
            level notify(#"hash_15f894886f3d6ede");
            level.var_8fd3c43a = 0;
            level function_e8fe6ed1();
            return;
        }
        if (level flag::exists(#"hash_768860cb3ad76c68") && level flag::get(#"hash_768860cb3ad76c68")) {
            level notify(#"hash_1381e879a94f5081");
            level.var_8fd3c43a = 0;
            level function_f00e93a();
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xe09ded0d, Offset: 0xa108
// Size: 0x2a0
function function_e0ab0352(e_attacker) {
    if (!isplayer(e_attacker)) {
        return;
    }
    if (self.archetype == "zombie") {
        level.var_6117c0c3--;
        return;
    }
    if (level flag::exists(#"hash_36efad26d2c9c9cd") && level flag::get(#"hash_36efad26d2c9c9cd")) {
        if (level.var_8fd3c43a <= 3) {
            if (self.aitype == level.var_95f27056[level.var_8fd3c43a]) {
                level.var_89393fac[level.var_8fd3c43a] show();
                if (level.var_8fd3c43a == 3) {
                    level flag::set(#"hash_e35ac19ee7b732c");
                }
            } else {
                level notify(#"hash_15f894886f3d6ede");
                level.var_8fd3c43a = 0;
                level function_e8fe6ed1();
            }
        }
        level.var_8fd3c43a++;
        return;
    }
    if (level flag::exists(#"hash_768860cb3ad76c68") && level flag::get(#"hash_768860cb3ad76c68")) {
        if (level.var_8fd3c43a <= 3) {
            if (self.aitype == level.var_9f192437[level.var_8fd3c43a]) {
                level.var_89393fac[level.var_8fd3c43a] show();
                if (level.var_8fd3c43a == 3) {
                    level flag::set(#"hash_77bd156a70de5aa3");
                }
            } else {
                level notify(#"hash_1381e879a94f5081");
                level.var_8fd3c43a = 0;
                level function_f00e93a();
            }
        }
        level.var_8fd3c43a++;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x26022392, Offset: 0xa3b0
// Size: 0x354
function function_e8fe6ed1() {
    level endon(#"end_game");
    self notify("315502de65cc9035");
    self endon("315502de65cc9035");
    foreach (var_1c0b22ae in level.var_89393fac) {
        var_1c0b22ae hide();
    }
    level notify(#"hash_5e0d8fb9b497a1f3");
    level zm_spawner::deregister_zombie_death_event_callback(&function_e0ab0352);
    level zm_utility::function_1a046290(1);
    function_3fc94d2a(array("connect_danu_ra_bridge", "connect_starting_area_to_ra_hallway", "connect_ra_basement_to_danu_ra_tunnel"));
    level flag::set("spawn_zombies");
    level flag::clear(#"pause_round_timeout");
    if (level flag::exists(#"hash_36efad26d2c9c9cd") && level flag::get(#"hash_36efad26d2c9c9cd")) {
        level flag::clear(#"hash_36efad26d2c9c9cd");
        level flag::clear(#"hash_4f293396150d2c00");
    }
    function_70f3f2d3();
    level function_52825b06();
    zm_transform::function_5eefd607(#"hash_7c02083c1e4c8ddd");
    level.zombie_powerups[#"nuke"].func_should_drop_with_regular_powerups = &zm_powerups::func_should_always_drop;
    function_bd5f6c56(1);
    level waittill(#"start_of_round");
    level.var_e634722 clientfield::set("ra_eyes_beam_fire", 1);
    wait 4;
    level.var_f407f612 show();
    level.var_2709cb2a = 1;
    level.var_f407f612 playsound(#"hash_708d124fb1b2203e");
    wait 2;
    level.var_e634722 clientfield::set("ra_eyes_beam_fire", 0);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x429dd86e, Offset: 0xa710
// Size: 0x36c
function function_f00e93a() {
    level endon(#"end_game");
    self notify("78f3b43b3ce42392");
    self endon("78f3b43b3ce42392");
    foreach (var_1c0b22ae in level.var_89393fac) {
        var_1c0b22ae hide();
    }
    level notify(#"hash_5e0d8fb9b497a1f3");
    level zm_spawner::deregister_zombie_death_event_callback(&function_e0ab0352);
    level zm_utility::function_1a046290(0);
    level function_52825b06();
    function_3fc94d2a(array("connect_danu_ra_bridge", "connect_starting_area_to_ra_hallway", "connect_ra_basement_to_danu_ra_tunnel"));
    level flag::set("spawn_zombies");
    level flag::clear(#"pause_round_timeout");
    if (level flag::exists(#"hash_768860cb3ad76c68") && level flag::get(#"hash_768860cb3ad76c68")) {
        level flag::clear(#"hash_768860cb3ad76c68");
        level flag::clear(#"hash_4f293396150d2c00");
    }
    function_70f3f2d3();
    level function_52825b06();
    level.zombie_powerups[#"nuke"].func_should_drop_with_regular_powerups = &zm_powerups::func_should_always_drop;
    zm_transform::function_5eefd607(#"hash_7c02083c1e4c8ddd");
    function_bd5f6c56(1);
    level waittill(#"start_of_round");
    level.var_e634722 clientfield::set("ra_eyes_beam_fire", 1);
    wait 4;
    level.var_f407f612 show();
    level.var_2709cb2a = 1;
    level.var_f407f612 playsound(#"hash_708d124fb1b2203e");
    wait 2;
    level.var_e634722 clientfield::set("ra_eyes_beam_fire", 0);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xe6f0f084, Offset: 0xaa88
// Size: 0x100
function function_6251040c() {
    if (level flag::get(#"hash_7136198009a72989")) {
        return;
    }
    level flag::set(#"hash_7136198009a72989");
    level.no_board_repair = 1;
    level notify(#"stop_blocker_think");
    foreach (s_boards in level.exterior_goals) {
        if (isdefined(s_boards.unitrigger_stub)) {
            zm_unitrigger::unregister_unitrigger(s_boards.unitrigger_stub);
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x543918b2, Offset: 0xab90
// Size: 0x7c
function function_70f3f2d3() {
    if (!level flag::get(#"hash_7136198009a72989")) {
        return;
    }
    level flag::clear(#"hash_7136198009a72989");
    level.no_board_repair = undefined;
    array::thread_all(level.exterior_goals, &zm_blockers::blocker_think);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x41563a17, Offset: 0xac18
// Size: 0x9e
function function_e93acd47(a_array) {
    a_array = array::randomize(a_array);
    var_2eb1034 = array();
    var_2eb1034[0] = a_array[0];
    var_2eb1034[1] = a_array[1];
    var_2eb1034[2] = a_array[2];
    var_2eb1034[3] = a_array[3];
    return var_2eb1034;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x8eecd859, Offset: 0xacc0
// Size: 0x3aa
function function_d3c0767a(str_aitype) {
    var_e3042885 = array("b", "c", "d", "m", "p", "r", "t", "w");
    foreach (var_c36977aa in var_e3042885) {
        self hidepart("tag_" + var_c36977aa + "_glyph");
        self hidepart("tag_" + var_c36977aa + "_glow");
    }
    switch (str_aitype) {
    case #"spawner_zm_gladiator_marauder":
        self showpart("tag_m_glyph");
        self showpart("tag_m_glow");
        return self;
    case #"spawner_zm_gladiator_destroyer":
        self showpart("tag_d_glyph");
        self showpart("tag_d_glow");
        return self;
    case #"spawner_zm_blight_father":
        self showpart("tag_b_glyph");
        self showpart("tag_b_glow");
        return self;
    case #"spawner_zm_catalyst_plasma":
        self showpart("tag_p_glyph");
        self showpart("tag_p_glow");
        return self;
    case #"spawner_zm_catalyst_corrosive":
        self showpart("tag_c_glyph");
        self showpart("tag_c_glow");
        return self;
    case #"spawner_zm_catalyst_water":
        self showpart("tag_w_glyph");
        self showpart("tag_w_glow");
        return self;
    case #"spawner_zm_catalyst_electric":
        self showpart("tag_r_glyph");
        self showpart("tag_r_glow");
        return self;
    case #"spawner_zm_tiger":
        self showpart("tag_t_glyph");
        self showpart("tag_t_glow");
        return self;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x41eff5ec, Offset: 0xb078
// Size: 0x74
function activate_puzzle_cleanup(b_skipped, var_c86ff890) {
    exploder::exploder("exp_ra_eyes");
    level flag::set(#"hash_7f6689c71e55e8ab");
    playsoundatposition(#"hash_6bc2c75bdaed3787", (0, 0, 0));
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x626353f9, Offset: 0xb0f8
// Size: 0x204
function function_88213d8() {
    level.var_749f87ef = 0;
    level.var_516636d = 0;
    level.var_8be2f0b7 = 0;
    level.var_80975462 = 0;
    function_30bd4abf();
    a_mdl_holes = getentarray("mdl_maelstrom_emerge", "targetname");
    foreach (mdl_hole in a_mdl_holes) {
        mdl_hole hide();
    }
    var_99211142 = getentarray("t_maelstrom_sponge", "targetname");
    foreach (var_10b5cf33 in var_99211142) {
        var_b52b2d2a = getent(var_10b5cf33.target, "targetname");
        var_b52b2d2a hide();
    }
    a_mdl_spikes = getentarray("mdl_maelstrom_arc", "targetname");
    array::thread_all(a_mdl_spikes, &function_f90d9139);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x70ffae98, Offset: 0xb308
// Size: 0x3d4
function function_7b5f8293(b_skipped) {
    var_99211142 = getentarray("t_maelstrom_sponge", "targetname");
    array::thread_all(var_99211142, &function_24150c3b);
    level flag::set("connect_danu_ra_tunnels");
    level flag::set("connect_odin_zeus_tunnels");
    zm_zonemgr::enable_zone("zone_danu_tunnel");
    zm_zonemgr::enable_zone("zone_ra_tunnel");
    zm_zonemgr::enable_zone("zone_odin_tunnel");
    zm_zonemgr::enable_zone("zone_zeus_tunnel");
    zm_zonemgr::enable_zone("zone_cursed_room");
    zm_zonemgr::enable_zone("zone_fallen_hero");
    zm_zonemgr::enable_zone("zone_danu_ra_tunnel");
    zm_zonemgr::enable_zone("zone_odin_zeus_tunnel");
    if (b_skipped) {
        return;
    }
    function_cb00e8e9();
    s_loc = struct::get("s_maelstrom_initiate");
    e_player = s_loc zm_unitrigger::function_b7e350e6(&function_b8a274dc);
    if (isdefined(e_player)) {
        e_player clientfield::increment_to_player("" + #"maelstrom_initiate");
    }
    level clientfield::set("" + #"maelstrom_initiate_fx", 1);
    level flag::clear("spawn_zombies");
    level flag::set(#"pause_round_timeout");
    wait 2;
    level zm_utility::function_1a046290(1);
    wait 0.5;
    function_c8851a77(array("connect_danu_basement_to_danu_ra_tunnel", "connect_ra_basement_to_danu_ra_tunnel", "connect_odin_basement_to_odin_zeus_tunnel", "connect_zeus_basement_to_odin_zeus_tunnel", "pap_room_danu_ra_entrance", "pap_room_odin_zeus_entrance", "pap_room_body_pit_entrance", "pap_room_flooded_crypt_entrance"));
    teleport::team("teleport_maelstrom", undefined, 1);
    wait 1;
    level clientfield::set("" + #"hash_4e5e2b411c997804", 0);
    array::thread_all(level.players, &function_f85c8c56);
    wait 3;
    level flag::set("spawn_zombies");
    level flag::clear(#"pause_round_timeout");
    level flag::wait_till(#"hash_35bd62e100e54ab3");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x566656ce, Offset: 0xb6e8
// Size: 0x74
function function_f85c8c56() {
    self endon(#"death");
    if (zm_utility::is_player_valid(self, 0, 0)) {
        self zm_vo::vo_stop();
        self thread zm_vo::function_59635cc4("m_quest_catacomb_enter", 0, 0, 9999, 1);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0xb6f81046, Offset: 0xb768
// Size: 0xe4
function function_e9b97508(b_skipped, var_c86ff890) {
    level flag::set(#"hash_35bd62e100e54ab3");
    function_3fc94d2a(array("connect_danu_basement_to_danu_ra_tunnel", "connect_ra_basement_to_danu_ra_tunnel", "connect_odin_basement_to_odin_zeus_tunnel", "connect_zeus_basement_to_odin_zeus_tunnel", "pap_room_danu_ra_entrance", "pap_room_odin_zeus_entrance", "pap_room_body_pit_entrance", "pap_room_flooded_crypt_entrance"));
    if (b_skipped) {
        function_cb00e8e9();
        level clientfield::set("" + #"maelstrom_initiate_fx", 1);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x1441dcad, Offset: 0xb858
// Size: 0x6c
function function_30bd4abf() {
    var_c5872b75 = getent("mdl_maelstrom_initiate_on", "targetname");
    var_c5872b75.origin -= (0, 0, 2048);
    var_c5872b75 stoploopsound();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xecaf2b15, Offset: 0xb8d0
// Size: 0x134
function function_cb00e8e9() {
    if (level flag::get(#"hash_1d004da0a75202bc")) {
        return;
    }
    level clientfield::set("" + #"hash_4e5e2b411c997804", 1);
    level flag::set(#"hash_1d004da0a75202bc");
    var_d1fd368f = getent("mdl_maelstrom_initiate", "targetname");
    var_c5872b75 = getent("mdl_maelstrom_initiate_on", "targetname");
    var_c5872b75.origin += (0, 0, 2048);
    waitframe(1);
    var_c5872b75 playloopsound(#"hash_62bd783a0737ec6a");
    var_d1fd368f delete();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x6124f463, Offset: 0xba10
// Size: 0x17e
function function_b8a274dc(e_activator) {
    var_2fd02d41 = level flag::get("special_round") || level flag::get(#"hash_4fd3d0c01f9b4c30");
    var_e12f52f6 = e_activator zm_utility::is_player_looking_at(self.stub.related_parent.origin, 0.9, 0);
    var_4caa1e4a = 1;
    var_20358f43 = getent("e_challenge_center_stage", "targetname");
    foreach (e_player in util::get_active_players()) {
        if (!e_player istouching(var_20358f43)) {
            var_4caa1e4a = 0;
            break;
        }
    }
    return !var_2fd02d41 && var_4caa1e4a && var_e12f52f6;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xc7a7223, Offset: 0xbb98
// Size: 0x3ec
function function_24150c3b() {
    level endon(#"hash_35bd62e100e54ab3");
    var_b52b2d2a = getent(self.target, "targetname");
    str_scene = self.var_1a6fe82a;
    var_b52b2d2a thread function_2e9359d5(str_scene);
    var_b52b2d2a show();
    var_b52b2d2a flag::init(#"hash_2fcd8f57a30258bd");
    var_b52b2d2a flag::init(#"hash_2789af19411aa6bb");
    var_b52b2d2a.var_fa29d222 = [];
    var_b52b2d2a thread function_3a716c();
    b_rotated = 0;
    n_health = 8500;
    var_c1c93aba = 1416.67;
    while (!b_rotated) {
        s_waitresult = self waittill(#"damage");
        n_damage = s_waitresult.amount;
        var_b52b2d2a thread spin_crank(n_damage);
        if (n_health - n_damage < 0) {
            n_damage = n_health;
            n_health = 0;
        } else {
            n_health -= n_damage;
        }
        self thread function_65eadd1b(n_damage);
        var_b52b2d2a flag::set(#"hash_66eb0aa5f179e140");
        for (i = 1; i <= 6; i++) {
            n_threshold = 8500 - var_c1c93aba * i;
            switch (i) {
            case 1:
                str_flag = #"hash_66eb0da5f179e659";
                break;
            case 3:
                str_flag = #"hash_66eb0ca5f179e4a6";
                break;
            case 4:
                str_flag = #"hash_66eb0fa5f179e9bf";
                break;
            case 5:
                str_flag = #"hash_66eb0ea5f179e80c";
                break;
            case 6:
                str_flag = #"hash_66eb11a5f179ed25";
                break;
            }
            if (n_health <= n_threshold) {
                var_b52b2d2a flag::set(str_flag);
            }
        }
        if (n_health <= 0) {
            b_rotated = 1;
            break;
        }
    }
    var_b52b2d2a flag::set(#"hash_2789af19411aa6bb");
    var_b52b2d2a playsound(#"hash_75a2099e8df5a448");
    self thread function_9a7ad353();
    level.var_749f87ef++;
    if (level.var_749f87ef >= 4) {
        level flag::set(#"hash_35bd62e100e54ab3");
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xc30f6f3, Offset: 0xbf90
// Size: 0xae
function function_65eadd1b(n_damage) {
    n_percent = n_damage / 8500;
    var_61ad4a = 32 * n_percent;
    var_b52b2d2a = getent(self.target, "targetname");
    self.origin += (0, 0, var_61ad4a);
    var_b52b2d2a.origin += (0, 0, var_61ad4a);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xc079e6cb, Offset: 0xc048
// Size: 0x116
function spin_crank(n_damage) {
    self endon(#"death");
    if (n_damage < 200) {
        n_turns = 1;
    } else if (n_damage < 400) {
        n_turns = 4;
    } else if (n_damage < 800) {
        n_turns = 8;
    } else {
        n_turns = 16;
    }
    if (!isdefined(self.var_fa29d222)) {
        self.var_fa29d222 = [];
    } else if (!isarray(self.var_fa29d222)) {
        self.var_fa29d222 = array(self.var_fa29d222);
    }
    if (!isinarray(self.var_fa29d222, n_turns)) {
        self.var_fa29d222[self.var_fa29d222.size] = n_turns;
    }
    self notify(#"spin_crank");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xaa70abda, Offset: 0xc168
// Size: 0xe4
function function_9a7ad353() {
    var_b52b2d2a = getent(self.target, "targetname");
    var_b52b2d2a flag::wait_till_clear(#"hash_2fcd8f57a30258bd");
    wait 1;
    var_b52b2d2a playsound(#"hash_10735a219a00f9f8");
    var_b52b2d2a movez(160, 4);
    var_b52b2d2a waittill(#"movedone");
    var_b52b2d2a delete();
    self delete();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x86927ed3, Offset: 0xc258
// Size: 0x1a0
function function_3a716c() {
    self endon(#"death");
    while (!self flag::get(#"hash_2789af19411aa6bb")) {
        s_waitresult = self waittill(#"spin_crank", #"hash_2789af19411aa6bb");
        if (s_waitresult._notify == #"spin_crank") {
            self flag::set(#"hash_2fcd8f57a30258bd");
            while (self.var_fa29d222.size > 0) {
                n_turns = self.var_fa29d222[0];
                arrayremoveindex(self.var_fa29d222, 0);
                for (i = 0; i < n_turns; i++) {
                    v_angles = self.angles + (0, 90, 0);
                    self rotateto(v_angles, 0.1);
                    self waittill(#"rotatedone");
                }
            }
            self flag::clear(#"hash_2fcd8f57a30258bd");
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x9e0ef5d2, Offset: 0xc400
// Size: 0x264
function function_2e9359d5(str_scene) {
    self endon(#"death");
    self flag::init(#"hash_66eb0aa5f179e140");
    self flag::init(#"hash_66eb0da5f179e659");
    self flag::init(#"hash_66eb0ca5f179e4a6");
    self flag::init(#"hash_66eb0fa5f179e9bf");
    self flag::init(#"hash_66eb0ea5f179e80c");
    self flag::init(#"hash_66eb11a5f179ed25");
    self flag::wait_till(#"hash_66eb0aa5f179e140");
    level scene::play(str_scene, "shot 1");
    self flag::wait_till(#"hash_66eb0da5f179e659");
    level scene::play(str_scene, "shot 2");
    self flag::wait_till(#"hash_66eb0ca5f179e4a6");
    level scene::play(str_scene, "shot 3");
    self flag::wait_till(#"hash_66eb0fa5f179e9bf");
    level scene::play(str_scene, "shot 4");
    self flag::wait_till(#"hash_66eb0ea5f179e80c");
    level scene::play(str_scene, "shot 5");
    self flag::wait_till(#"hash_66eb11a5f179ed25");
    level scene::play(str_scene, "shot 6");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xaa300e37, Offset: 0xc670
// Size: 0x29c
function function_b3ada319(b_skipped) {
    a_mdl_holes = getentarray("mdl_maelstrom_emerge", "targetname");
    foreach (mdl_hole in a_mdl_holes) {
        mdl_hole show();
    }
    a_mdl_spikes = getentarray("mdl_maelstrom_arc", "targetname");
    foreach (mdl_spike in a_mdl_spikes) {
        mdl_spike solid();
        mdl_spike show();
        mdl_spike.var_406f4ba2 = 0;
        mdl_spike flag::init(#"hash_6865328fef54bb82");
    }
    if (b_skipped) {
        return;
    }
    level thread zm_audio::sndannouncerplayvox(#"hash_73183fb7534361f");
    callback::on_ai_spawned(&function_7da617f);
    array::thread_all(zombie_utility::get_zombie_array(), &function_7da617f);
    callback::on_ai_killed(&function_7b47aee8);
    level flag::wait_till(#"hash_4f15d2623e98015d");
    callback::remove_on_ai_killed(&function_7b47aee8);
    array::thread_all(zombie_utility::get_zombie_array(), &function_d347470);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x440956fc, Offset: 0xc918
// Size: 0x34
function function_a7d9ed32(b_skipped, var_c86ff890) {
    level flag::set(#"hash_4f15d2623e98015d");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x6b3931cb, Offset: 0xc958
// Size: 0xa4
function function_f90d9139() {
    self endon(#"death");
    self hide();
    self notsolid();
    var_196fa1b6 = struct::get(self.target);
    self.var_8fc94ea1 = var_196fa1b6.origin;
    self.var_7e7ee26f = var_196fa1b6.angles;
    var_196fa1b6 struct::delete();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x25adba88, Offset: 0xca08
// Size: 0x2c0
function function_7da617f(s_params) {
    self notify("692dc2fa12f2aabc");
    self endon("692dc2fa12f2aabc");
    self endoncallback(&function_d347470, #"death");
    level endon(#"hash_4f15d2623e98015d");
    if (self.archetype !== "zombie") {
        return;
    }
    a_mdl_spikes = getentarray("mdl_maelstrom_arc", "targetname");
    while (true) {
        var_e10e2a59 = 0;
        while (!var_e10e2a59) {
            var_b97d84ac = arraysortclosest(a_mdl_spikes, self.origin, undefined, 0, 300);
            foreach (var_929c03cc in var_b97d84ac) {
                if (!var_929c03cc flag::get(#"hash_6865328fef54bb82")) {
                    var_e10e2a59 = 1;
                    break;
                }
            }
            if (var_e10e2a59) {
                break;
            }
            waitframe(1);
        }
        self clientfield::set("" + #"hash_451db92b932d90bf", 1);
        self.var_72b0f6e2 = 1;
        while (var_e10e2a59) {
            var_e10e2a59 = 0;
            var_b97d84ac = arraysortclosest(a_mdl_spikes, self.origin, undefined, 0, 300);
            foreach (var_929c03cc in var_b97d84ac) {
                if (!var_929c03cc flag::get(#"hash_6865328fef54bb82")) {
                    var_e10e2a59 = 1;
                    break;
                }
            }
            if (!var_e10e2a59) {
                break;
            }
            waitframe(1);
        }
        self function_d347470();
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x2f48b503, Offset: 0xccd0
// Size: 0x56
function function_d347470(notifyhash) {
    if (isdefined(self.var_72b0f6e2) && self.var_72b0f6e2) {
        self clientfield::set("" + #"hash_451db92b932d90bf", 0);
        self.var_72b0f6e2 = 0;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x8242801f, Offset: 0xcd30
// Size: 0x52c
function function_7b47aee8(s_params) {
    v_origin = self.origin;
    v_fx_origin = self gettagorigin("J_SpineUpper");
    str_zone = self zm_utility::get_current_zone();
    str_archetype = self.archetype;
    var_7bf29b5e = self.var_ea94c12a;
    var_204eace3 = self.var_e17bf10a;
    e_player = s_params.eattacker;
    w_weapon = s_params.weapon;
    if (!isplayer(e_player)) {
        return;
    }
    s_aat = e_player aat::getaatonweapon(w_weapon);
    str_aat = "";
    if (isdefined(s_aat) && isdefined(s_aat.name)) {
        str_aat = s_aat.name;
    }
    var_5b469765 = array("zone_starting_area_center", "zone_starting_area_danu", "zone_starting_area_ra", "zone_starting_area_odin", "zone_starting_area_zeus");
    if (!isdefined(v_origin) || isdefined(str_zone) && !isinarray(var_5b469765, str_zone)) {
        return;
    }
    a_mdl_spikes = getentarray("mdl_maelstrom_arc", "targetname");
    a_mdl_spikes = arraysortclosest(a_mdl_spikes, v_origin, undefined, 0, 300);
    if (a_mdl_spikes.size == 0) {
        return;
    }
    mdl_spike = a_mdl_spikes[0];
    if (mdl_spike flag::get(#"hash_6865328fef54bb82") || (str_archetype == "blight_father" || str_archetype == "gladiator") && str_aat !== "zm_aat_kill_o_watt") {
        return;
    }
    var_4ec65ffe = 0;
    b_charged = 0;
    n_charges = 1;
    switch (str_archetype) {
    case #"blight_father":
        var_4ec65ffe = 1;
        v_fx_origin = v_origin;
        n_charges = 9;
        break;
    case #"gladiator":
        var_4ec65ffe = 1;
        n_charges = 5;
        break;
    }
    if (!var_4ec65ffe && !(isdefined(var_204eace3) && var_204eace3) && var_7bf29b5e !== "catalyst_electric") {
        return;
    }
    n_total = mdl_spike.var_406f4ba2 + n_charges;
    if (n_total >= 9) {
        mdl_spike flag::set(#"hash_6865328fef54bb82");
        b_charged = 1;
        if (n_total > 9) {
            n_charges = 9 - mdl_spike.var_406f4ba2;
        }
    }
    mdl_spike.var_406f4ba2 += n_charges;
    for (i = 0; i < n_charges; i++) {
        level thread function_5668ee2b(v_fx_origin, mdl_spike);
        if (i + 1 < n_charges) {
            wait 0.5;
        }
    }
    if (b_charged) {
        mdl_spike.var_32bc8f01 = util::spawn_model("tag_origin", mdl_spike.var_8fc94ea1, mdl_spike.var_7e7ee26f);
        mdl_spike.var_32bc8f01 clientfield::set("" + #"hash_1814d4cc1867739c", 1);
        mdl_spike thread function_67100247();
        level.var_516636d++;
        if (level.var_516636d >= 4) {
            level.var_f909e2b0 = mdl_spike;
            level flag::set(#"hash_4f15d2623e98015d");
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0xd1ff1440, Offset: 0xd268
// Size: 0x11c
function function_5668ee2b(v_origin, mdl_spike) {
    params = level.var_fbb1e329;
    v_destination = mdl_spike.var_8fc94ea1;
    mdl_fx = util::spawn_model("tag_origin", v_origin);
    mdl_fx clientfield::set("" + #"maelstrom_conduct", 1);
    mdl_fx moveto(v_destination, params.arc_travel_time);
    mdl_fx waittill(#"movedone");
    mdl_fx clientfield::set("" + #"maelstrom_conduct", 0);
    mdl_fx delete();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xfe75ef65, Offset: 0xd390
// Size: 0x7c
function function_67100247() {
    self endon(#"hash_67ca6bbad6cdefae");
    var_58736229 = getent(self.var_4fa4a70a, "script_maelstrom_arc_name");
    var_58736229 flag::wait_till(#"hash_6865328fef54bb82");
    exploder::exploder(self.var_9b53d4d4);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x23e9637f, Offset: 0xd418
// Size: 0x28c
function function_c292b8a4(b_skipped) {
    if (b_skipped) {
        return;
    }
    disable_challenges();
    wait 2;
    mdl_spike = level.var_f909e2b0;
    if (!isdefined(mdl_spike)) {
        mdl_spike = getent("danu_ra", "script_maelstrom_arc_name");
    }
    for (i = 0; i < 4; i++) {
        mdl_spike notify(#"hash_67ca6bbad6cdefae");
        if (isdefined(mdl_spike.var_32bc8f01)) {
            mdl_spike.var_32bc8f01 clientfield::set("" + #"hash_1814d4cc1867739c", 0);
            mdl_spike.var_32bc8f01 delete();
            exploder::stop_exploder(mdl_spike.var_9b53d4d4);
        }
        mdl_spike thread function_f0974896();
        if (i + 1 < 4) {
            wait 1;
            mdl_spike = getent(mdl_spike.var_4fa4a70a, "script_maelstrom_arc_name");
        }
    }
    level flag::wait_till(#"hash_5734e11875c30d69");
    a_s_balls = struct::get_array("s_maelstrom_float");
    foreach (s_ball in a_s_balls) {
        s_ball zm_unitrigger::create(&function_5c8f3db4);
        s_ball thread function_11faa7bb();
    }
    level thread function_3cfd2a16();
    level flag::wait_till(#"hash_50e2bacfe0486f6a");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0xb49b11fc, Offset: 0xd6b0
// Size: 0xb8
function function_c1002047(b_skipped, var_c86ff890) {
    if (b_skipped) {
        return;
    }
    a_s_balls = struct::get_array("s_maelstrom_float");
    foreach (s_ball in a_s_balls) {
        zm_unitrigger::unregister_unitrigger(s_ball.s_unitrigger);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xe9ae4dda, Offset: 0xd770
// Size: 0x1d2
function disable_challenges() {
    level flag::set(#"hash_4f26632e308bd2e6");
    foreach (t_trigger in level.var_41e21193) {
        t_trigger.origin -= (0, 0, 2048);
    }
    a_str_structs = array("danu_brazier", "ra_brazier", "odin_brazier", "zeus_brazier");
    foreach (str_struct in a_str_structs) {
        s_struct = struct::get(str_struct);
        s_struct.origin -= (0, 0, 2048);
        mdl_reward = s_struct.mdl_reward;
        if (isdefined(mdl_reward)) {
            mdl_reward.origin -= (0, 0, 2048);
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x5b8e9b6, Offset: 0xd950
// Size: 0x1fa
function enable_challenges() {
    if (!level flag::get(#"hash_4f26632e308bd2e6")) {
        return;
    }
    level flag::clear(#"hash_4f26632e308bd2e6");
    foreach (t_trigger in level.var_41e21193) {
        t_trigger.origin += (0, 0, 2048);
    }
    a_str_structs = array("danu_brazier", "ra_brazier", "odin_brazier", "zeus_brazier");
    foreach (str_struct in a_str_structs) {
        s_struct = struct::get(str_struct);
        s_struct.origin += (0, 0, 2048);
        mdl_reward = s_struct.mdl_reward;
        if (isdefined(mdl_reward)) {
            mdl_reward.origin += (0, 0, 2048);
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xc4bd232d, Offset: 0xdb58
// Size: 0x124
function function_f0974896() {
    exploder::exploder(self.var_10d5a6aa);
    s_ball = struct::get(self.var_b45fe54a, "script_maelstrom_float");
    mdl_fx = util::spawn_model("tag_origin", s_ball.origin, s_ball.angles);
    mdl_fx clientfield::set("" + #"hash_1814d4cc1867739c", 1);
    s_ball.var_732a6c72 = mdl_fx;
    level.var_8be2f0b7++;
    if (level.var_8be2f0b7 >= 4) {
        level flag::set(#"hash_5734e11875c30d69");
    }
    wait 0.25;
    exploder::stop_exploder(self.var_10d5a6aa);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x41cd0dfa, Offset: 0xdc88
// Size: 0xa8
function function_5c8f3db4(e_player) {
    var_b56ce5b9 = e_player zm_utility::is_player_looking_at(self.stub.related_parent.origin, 0.9, 0);
    var_2fd02d41 = level flag::get("special_round") || level flag::get(#"hash_4fd3d0c01f9b4c30");
    return !var_2fd02d41 && var_b56ce5b9;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x8c8dbf31, Offset: 0xdd38
// Size: 0x58
function function_95b331e3() {
    level endon(#"hash_50e2bacfe0486f6a");
    self.var_732a6c72 clientfield::set("" + #"hash_314d3a2e542805c0", 1);
    level.var_80975462++;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x8aa20650, Offset: 0xdd98
// Size: 0x68
function function_c2b0b178() {
    level endon(#"hash_50e2bacfe0486f6a");
    self.var_732a6c72 clientfield::set("" + #"hash_314d3a2e542805c0", 0);
    if (level.var_80975462 > 0) {
        level.var_80975462--;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x4980336c, Offset: 0xde08
// Size: 0x64
function function_3cfd2a16() {
    level endon(#"end_game");
    while (level.var_80975462 < util::get_active_players().size) {
        waitframe(1);
    }
    level flag::set(#"hash_50e2bacfe0486f6a");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x2c6211f4, Offset: 0xde78
// Size: 0x18c
function function_11faa7bb() {
    level endon(#"hash_50e2bacfe0486f6a");
    self function_c2b0b178();
    b_activated = 0;
    while (!b_activated) {
        s_waitresult = self waittill(#"trigger_activated");
        e_player = s_waitresult.e_who;
        if (isdefined(e_player)) {
            if (!e_player flag::exists(#"hash_4bd231b62155d251")) {
                e_player flag::init(#"hash_4bd231b62155d251");
            }
            if (!e_player flag::get(#"hash_4bd231b62155d251")) {
                self function_95b331e3();
                e_player flag::set(#"hash_4bd231b62155d251");
                e_player thread function_eb639547(self);
                e_player thread function_ea4f2e34(self);
                e_player clientfield::increment_to_player("" + #"maelstrom_initiate");
                b_activated = 1;
                break;
            }
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x39387239, Offset: 0xe010
// Size: 0x8c
function function_eb639547(t_ball) {
    level endon(#"hash_50e2bacfe0486f6a");
    self endon(#"hash_352d2def925390c7");
    self waittill(#"death");
    if (isdefined(self)) {
        self flag::clear(#"hash_4bd231b62155d251");
    }
    t_ball thread function_11faa7bb();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xe3066e8b, Offset: 0xe0a8
// Size: 0xd4
function function_ea4f2e34(t_ball) {
    level endon(#"hash_50e2bacfe0486f6a");
    self endon(#"death");
    vol_center = getent("e_challenge_center_stage", "targetname");
    while (self istouching(vol_center)) {
        waitframe(1);
    }
    self flag::clear(#"hash_4bd231b62155d251");
    self notify(#"hash_352d2def925390c7");
    t_ball thread function_11faa7bb();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x7caece61, Offset: 0xe188
// Size: 0x28c
function gladiator_round_setup(b_skipped) {
    if (b_skipped) {
        return;
    }
    level flag::clear("spawn_zombies");
    level flag::set(#"pause_round_timeout");
    var_747edd8 = array("connect_starting_area_to_danu_hallway", "connect_starting_area_to_ra_hallway", "connect_starting_area_to_odin_hallway", "connect_starting_area_to_zeus_hallway");
    foreach (str_doors in var_747edd8) {
        a_t_door = getentarray(str_doors, "script_flag");
        foreach (t_door in a_t_door) {
            if (!(isdefined(t_door.has_been_opened) && t_door.has_been_opened)) {
                t_door thread zm_blockers::door_opened();
            }
        }
    }
    waitframe(1);
    function_c8851a77(var_747edd8);
    level.var_1127c786 = struct::get_array("s_maelstrom_spawn_east");
    level.var_c39f5d20 = struct::get_array("s_maelstrom_spawn_west");
    function_c3638e74();
    level.var_bbba763c = 5;
    level.var_886ac991 = 15;
    level.var_34e54c84 = 25;
    level.var_2538a119 = 35;
    level.var_667445db = 0;
    callback::on_ai_killed(&function_2ad287b8);
    function_23526d38();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x5500b470, Offset: 0xe420
// Size: 0x224
function gladiator_round_cleanup(b_skipped, var_c86ff890) {
    level flag::set(#"hash_403b629f7e5829ee");
    function_3fc94d2a(array("connect_starting_area_to_danu_hallway", "connect_starting_area_to_ra_hallway", "connect_starting_area_to_odin_hallway", "connect_starting_area_to_zeus_hallway"));
    exploder::exploder("exp_zeus_eyes");
    if (b_skipped) {
        return;
    }
    level thread function_2f54ca5f();
    callback::remove_on_ai_killed(&function_2ad287b8);
    if (!level flag::get("special_round")) {
        level notify(#"hash_7b9245ff51f3d4f7");
        level thread zm_towers_special_rounds::function_5c9925c8(1);
    }
    callback::remove_on_spawned(&function_5f37cba8);
    foreach (e_player in level.players) {
        e_player clientfield::set_to_player("" + #"maelstrom_storm", 0);
    }
    level thread zm_towers_special_rounds::function_77e74840();
    wait 1;
    level flag::set("spawn_zombies");
    level flag::clear(#"pause_round_timeout");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x6d30b576, Offset: 0xe650
// Size: 0x1ec
function function_c3638e74() {
    function_ddab9e83();
    wait 1;
    enable_challenges();
    level zm_utility::function_1a046290(1);
    level thread function_29bb8292();
    wait 3;
    foreach (e_player in util::get_active_players()) {
        w_hero_weapon = e_player.var_c332c9d4;
        if (isdefined(w_hero_weapon)) {
            e_player ability_util::function_aa8c40c1(w_hero_weapon);
            if (!e_player gadgetisactive(level.var_97b2d700) && !e_player function_49de461b(level.var_97b2d700)) {
                e_player switchtoweaponimmediate(w_hero_weapon, 1);
            }
        }
    }
    callback::on_spawned(&function_5f37cba8);
    array::thread_all(level.players, &function_5f37cba8);
    level thread function_f0d8df62();
    wait 1;
    level thread zm_towers_special_rounds::function_85c80649(1);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x9fedccc3, Offset: 0xe848
// Size: 0x94
function function_f0d8df62() {
    level zm_audio::sndannouncerplayvox(#"hash_6211a32e1a9f23fa");
    e_player = array::random(util::get_active_players());
    e_player zm_vo::vo_stop();
    e_player zm_vo::function_59635cc4("m_quest_gladiator_round_resp", 0, 0, 9999, 1);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x3b8128be, Offset: 0xe8e8
// Size: 0x94
function function_2f54ca5f() {
    level zm_audio::sndannouncerplayvox(#"hash_42bbe4989b9a4cbe");
    e_player = array::random(util::get_active_players());
    e_player zm_vo::vo_stop();
    e_player zm_vo::function_59635cc4("m_quest_zeus_complete_resp", 0, 0, 9999, 1);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xecdf21a4, Offset: 0xe988
// Size: 0x310
function function_ddab9e83() {
    a_s_balls = struct::get_array("s_maelstrom_float");
    foreach (s_ball in a_s_balls) {
        if (!isdefined(s_ball.var_732a6c72)) {
            mdl_fx = util::spawn_model("tag_origin", s_ball.origin, s_ball.angles);
            s_ball.var_732a6c72 = mdl_fx;
            mdl_fx clientfield::set("" + #"hash_1814d4cc1867739c", 1);
        }
        s_ball function_95b331e3();
    }
    wait 2;
    foreach (e_player in level.players) {
        e_player playsoundtoplayer("wpn_hammer_bolt_fire", e_player);
    }
    foreach (s_ball in a_s_balls) {
        s_ball.var_732a6c72 clientfield::increment("" + #"maelstrom_discharge");
    }
    wait 1;
    foreach (s_ball in a_s_balls) {
        s_ball.var_732a6c72 clientfield::set("" + #"hash_1814d4cc1867739c", 0);
        s_ball.var_732a6c72 clientfield::set("" + #"hash_314d3a2e542805c0", 0);
        s_ball.var_732a6c72 delete();
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x18b105a8, Offset: 0xeca0
// Size: 0xbc
function function_5f37cba8(s_params) {
    self endon(#"death");
    if (self flag::exists(#"hash_47f07946ddff1f32")) {
        return;
    }
    self flag::init(#"hash_47f07946ddff1f32");
    self flag::set(#"hash_47f07946ddff1f32");
    self clientfield::set_to_player("" + #"maelstrom_storm", 1);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x6cf4d9f7, Offset: 0xed68
// Size: 0x16e
function function_29bb8292() {
    for (i = 0; i < 4; i++) {
        e_trap = level.var_b5e9f473[i];
        e_trap namespace_1f60eead::function_9b6c33f6();
    }
    level flag::wait_till(#"hash_415c59c3573153ff");
    level.var_1802c149 = 2;
    level.var_e262664 = 2;
    level thread function_bf1de0e6();
    level flag::wait_till(#"hash_2c274140cd602e60");
    level.var_1802c149 = 1;
    level flag::wait_till(#"hash_5e49848f6ac0bc6b");
    level.var_1802c149 = 0.5;
    level flag::wait_till(#"hash_403b629f7e5829ee");
    for (i = 0; i < 4; i++) {
        e_trap = level.var_b5e9f473[i];
        e_trap namespace_1f60eead::function_9b6c33f6();
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xf47271dd, Offset: 0xeee0
// Size: 0x86
function function_bf1de0e6() {
    level endon(#"hash_403b629f7e5829ee");
    while (true) {
        for (i = 0; i < 4; i++) {
            e_trap = level.var_b5e9f473[i];
            e_trap thread function_5fb8faad();
            wait level.var_1802c149;
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x4e39a4fa, Offset: 0xef70
// Size: 0xfc
function function_5fb8faad() {
    level endon(#"hash_403b629f7e5829ee");
    if (!self flag::exists(#"hash_17d1c634991f8734")) {
        self flag::init(#"hash_17d1c634991f8734");
    }
    if (self flag::get(#"hash_17d1c634991f8734")) {
        return;
    }
    self flag::set(#"hash_17d1c634991f8734");
    self thread namespace_1f60eead::function_d94bfe17(10);
    wait level.var_e262664;
    self namespace_1f60eead::function_9b6c33f6();
    self flag::clear(#"hash_17d1c634991f8734");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x1f114458, Offset: 0xf078
// Size: 0x45c
function function_23526d38() {
    level.var_2a3d322f = [];
    level.var_c5ddf9e6 = 8;
    level.var_8eb22ec0 = 8;
    level.var_6194f075 = 8;
    level thread function_4b078b9b("s_maelstrom_tunnel_spawn_east");
    level thread function_4b078b9b("s_maelstrom_tunnel_spawn_west");
    level flag::wait_till(#"hash_415c59c3573153ff");
    n_random_wait = randomfloatrange(2, 3);
    wait n_random_wait;
    level.var_c5ddf9e6 = 4;
    level thread function_fa7bb48c("s_maelstrom_hallway_spawn_danu_ra");
    level thread function_fa7bb48c("s_maelstrom_hallway_spawn_odin_zeus");
    foreach (e_player in level.players) {
        e_player clientfield::increment_to_player("" + #"hash_182c03ff2a21c07c");
    }
    level flag::wait_till(#"hash_2c274140cd602e60");
    n_random_wait = randomfloatrange(2, 3);
    wait n_random_wait;
    level.var_8eb22ec0 = 4;
    level thread function_57f8b92d();
    foreach (e_player in level.players) {
        e_player clientfield::increment_to_player("" + #"hash_182c03ff2a21c07c");
    }
    level flag::wait_till(#"hash_5e49848f6ac0bc6b");
    n_random_wait = randomfloatrange(2, 3);
    wait n_random_wait;
    level.var_c5ddf9e6 = 1;
    level.var_8eb22ec0 = 1;
    level.var_6194f075 = 1;
    foreach (e_player in level.players) {
        e_player clientfield::increment_to_player("" + #"hash_182c03ff2a21c07c");
    }
    wait 30;
    level flag::wait_till(#"hash_4feaeb49c7362da7");
    level flag::set(#"hash_403b629f7e5829ee");
    wait 1;
    level zm_utility::function_1a046290(0);
    while (level.var_2a3d322f.size > 0) {
        level.var_2a3d322f = array::remove_dead(level.var_2a3d322f);
        waitframe(1);
    }
    wait 1;
    function_f16e3412();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x903aa6e0, Offset: 0xf4e0
// Size: 0x26c
function function_4b078b9b(str_spawn) {
    level endon(#"end_game", #"hash_403b629f7e5829ee");
    a_s_spawns = struct::get_array(str_spawn);
    var_9f0f4beb = min(1 + level.players.size, 3);
    var_bb458617 = array(#"destroyer", #"marauder", #"tiger");
    a_ai_spawned = [];
    while (true) {
        a_ai_spawned = array::remove_dead(a_ai_spawned);
        n_spawned = a_ai_spawned.size;
        if (getaiarray().size < 24 && a_ai_spawned.size < var_9f0f4beb) {
            n_to_spawn = var_9f0f4beb - n_spawned;
            for (i = 0; i < n_to_spawn; i++) {
                if (getaiarray().size < 24) {
                    str_enemy = array::random(var_bb458617);
                    ai_enemy = function_ccab1de2(str_enemy, a_s_spawns);
                    if (!isdefined(a_ai_spawned)) {
                        a_ai_spawned = [];
                    } else if (!isarray(a_ai_spawned)) {
                        a_ai_spawned = array(a_ai_spawned);
                    }
                    a_ai_spawned[a_ai_spawned.size] = ai_enemy;
                }
                if (i < n_to_spawn - 1) {
                    n_random_wait = randomfloatrange(2, 3);
                    wait n_random_wait;
                }
            }
        }
        wait level.var_c5ddf9e6;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x7bd9c2e7, Offset: 0xf758
// Size: 0x2d0
function function_fa7bb48c(str_spawn) {
    level endon(#"end_game", #"hash_403b629f7e5829ee");
    a_s_spawns = struct::get_array(str_spawn);
    n_players = level.players.size;
    var_9f0f4beb = min(2 + level.players.size, 4);
    var_bb458617 = array(#"destroyer", #"marauder");
    a_ai_spawned = [];
    while (true) {
        a_ai_spawned = array::remove_dead(a_ai_spawned);
        n_spawned = a_ai_spawned.size;
        if (getaiarray().size < 24 && n_spawned < var_9f0f4beb) {
            n_available = var_9f0f4beb - n_spawned;
            if (n_available - 2 >= 0) {
                n_to_spawn = 2;
            } else {
                for (i = 1; i <= n_available; i++) {
                    n_option = 2 - i;
                    if (n_available - n_option >= 0) {
                        n_to_spawn = n_option;
                        break;
                    }
                }
            }
            for (i = 0; i < n_to_spawn; i++) {
                if (getaiarray().size < 24) {
                    str_enemy = array::random(var_bb458617);
                    ai_enemy = function_ccab1de2(str_enemy, a_s_spawns);
                    if (!isdefined(a_ai_spawned)) {
                        a_ai_spawned = [];
                    } else if (!isarray(a_ai_spawned)) {
                        a_ai_spawned = array(a_ai_spawned);
                    }
                    a_ai_spawned[a_ai_spawned.size] = ai_enemy;
                }
                if (i < n_to_spawn - 1) {
                    wait 1;
                }
            }
        }
        wait level.var_8eb22ec0;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xbe8fc70e, Offset: 0xfa30
// Size: 0x310
function function_57f8b92d() {
    level endon(#"end_game", #"hash_403b629f7e5829ee");
    var_37d6e093 = struct::get_array("starting_area_center_spawns");
    var_78b68557 = [];
    foreach (s_spawn in var_37d6e093) {
        if (s_spawn.script_noteworthy === "tiger_location") {
            if (!isdefined(var_78b68557)) {
                var_78b68557 = [];
            } else if (!isarray(var_78b68557)) {
                var_78b68557 = array(var_78b68557);
            }
            var_78b68557[var_78b68557.size] = s_spawn;
        }
    }
    a_s_remaining = array::randomize(var_78b68557);
    var_87ddaefd = 7 + level.players.size;
    a_ai_spawned = [];
    while (true) {
        a_ai_spawned = array::remove_dead(a_ai_spawned);
        n_spawned = a_ai_spawned.size;
        if (getaiarray().size < 24 && n_spawned < var_87ddaefd) {
            n_to_spawn = var_87ddaefd - n_spawned;
            for (i = 0; i < n_to_spawn; i++) {
                if (getaiarray().size < 24) {
                    if (a_s_remaining.size == 0) {
                        a_s_remaining = array::randomize(var_78b68557);
                    }
                    s_spawn = a_s_remaining[0];
                    arrayremoveindex(a_s_remaining, 0);
                    ai_tiger = function_ccab1de2(#"tiger", s_spawn);
                    if (!isdefined(a_ai_spawned)) {
                        a_ai_spawned = [];
                    } else if (!isarray(a_ai_spawned)) {
                        a_ai_spawned = array(a_ai_spawned);
                    }
                    a_ai_spawned[a_ai_spawned.size] = ai_tiger;
                }
                if (i < n_to_spawn - 1) {
                    wait 1;
                }
            }
        }
        wait level.var_6194f075;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x1f3d84ff, Offset: 0xfd48
// Size: 0x2a2
function function_ccab1de2(str_enemy, a_s_spawns) {
    if (!isdefined(a_s_spawns)) {
        a_s_spawns = [];
    } else if (!isarray(a_s_spawns)) {
        a_s_spawns = array(a_s_spawns);
    }
    s_spawn = array::random(a_s_spawns);
    ai_enemy = undefined;
    while (!isdefined(ai_enemy)) {
        switch (str_enemy) {
        case #"marauder":
            ai_enemy = zombie_gladiator_util::function_993ddc19(undefined, s_spawn, "melee");
            break;
        case #"destroyer":
            ai_enemy = zombie_gladiator_util::function_993ddc19(undefined, s_spawn, "ranged");
            break;
        case #"tiger":
            ai_enemy = zombie_tiger_util::spawn_single(1, s_spawn);
            break;
        }
        if (isdefined(ai_enemy)) {
            ai_enemy.no_powerups = 1;
            ai_enemy.ignore_round_spawn_failsafe = 1;
            ai_enemy.b_ignore_cleanup = 1;
            ai_enemy.ignore_enemy_count = 1;
            ai_enemy.completed_emerging_into_playable_area = 1;
            ai_enemy notify(#"completed_emerging_into_playable_area");
            if (str_enemy == #"tiger") {
                ai_enemy ai::set_behavior_attribute("sprint", 1);
            } else {
                ai_enemy ai::set_behavior_attribute("run", 1);
            }
            if (!isdefined(level.var_2a3d322f)) {
                level.var_2a3d322f = [];
            } else if (!isarray(level.var_2a3d322f)) {
                level.var_2a3d322f = array(level.var_2a3d322f);
            }
            level.var_2a3d322f[level.var_2a3d322f.size] = ai_enemy;
            return ai_enemy;
        }
        waitframe(1);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xffe060cf, Offset: 0xfff8
// Size: 0x22c
function function_2ad287b8(s_params) {
    e_attacker = s_params.eattacker;
    self clientfield::increment("" + #"maelstrom_death");
    foreach (e_player in level.players) {
        e_player playsoundtoplayer("wpn_hammer_bolt_fire", e_player);
    }
    if (isplayer(e_attacker)) {
        w_hero_weapon = e_attacker.var_c332c9d4;
        if (isdefined(w_hero_weapon)) {
            e_attacker ability_util::function_aa8c40c1(w_hero_weapon);
        }
    }
    arrayremovevalue(level.var_2a3d322f, self);
    level.var_667445db++;
    if (level.var_667445db >= level.var_bbba763c) {
        level flag::set(#"hash_415c59c3573153ff");
    }
    if (level.var_667445db >= level.var_886ac991) {
        level flag::set(#"hash_2c274140cd602e60");
    }
    if (level.var_667445db >= level.var_34e54c84) {
        level flag::set(#"hash_5e49848f6ac0bc6b");
    }
    if (level.var_667445db >= level.var_2538a119) {
        level flag::set(#"hash_4feaeb49c7362da7");
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xf1c3be38, Offset: 0x10230
// Size: 0x94
function function_b5d1e91(v_origin) {
    if (!isdefined(v_origin)) {
        return;
    }
    var_b5552075 = util::spawn_model("p8_zm_vapor_altar_zeus_lightning_bolt_01", v_origin + (0, 0, 32), (270, 0, 0));
    var_b5552075 setscale(7);
    wait 0.25;
    var_b5552075 delete();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x8f789b80, Offset: 0x102d0
// Size: 0x3f0
function function_f16e3412() {
    params = level.var_fbb1e329;
    n_travel_time = params.arc_travel_time;
    a_mdl_fx = [];
    v_start = (0, 0, 2048);
    v_end = (0, 0, 256);
    for (i = 0; i < 3; i++) {
        mdl_fx = util::spawn_model("tag_origin", v_start);
        mdl_fx clientfield::set("" + #"maelstrom_conduct", 1);
        mdl_fx moveto(v_end, n_travel_time);
        if (!isdefined(a_mdl_fx)) {
            a_mdl_fx = [];
        } else if (!isarray(a_mdl_fx)) {
            a_mdl_fx = array(a_mdl_fx);
        }
        a_mdl_fx[a_mdl_fx.size] = mdl_fx;
    }
    a_mdl_fx[0] waittilltimeout(n_travel_time, #"movedone");
    foreach (e_player in level.players) {
        e_player clientfield::set_to_player("" + #"maelstrom_ending", 1);
    }
    foreach (i, mdl_fx in a_mdl_fx) {
        n_x = 1024;
        n_y = 1024;
        switch (i) {
        case 1:
            n_x *= -1;
            break;
        case 2:
            n_x = 0;
            n_y *= -1;
            break;
        }
        v_end = (n_x, n_y, -256);
        mdl_fx moveto(v_end, n_travel_time);
    }
    a_mdl_fx[0] waittilltimeout(n_travel_time, #"movedone");
    foreach (mdl_fx in a_mdl_fx) {
        mdl_fx clientfield::set("" + #"maelstrom_conduct", 0);
        mdl_fx delete();
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xb916e07c, Offset: 0x106c8
// Size: 0xc
function maelstrom_completed_setup(b_skipped) {
    
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0xadce5c89, Offset: 0x106e0
// Size: 0x34
function maelstrom_completed_cleanup(b_skipped, var_c86ff890) {
    level flag::set(#"hash_4866241882c534b7");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xd923ca1d, Offset: 0x10720
// Size: 0x164
function init_defend() {
    level.var_df1caa96 = getentarray("skillshot_1", "targetname");
    level.var_df1caa96 = arraycombine(level.var_df1caa96, getentarray("skillshot_2", "targetname"), 0, 0);
    level.var_df1caa96 = arraycombine(level.var_df1caa96, getentarray("skillshot_3", "targetname"), 0, 0);
    var_627738ce = getent("defend_gate_l", "targetname");
    var_dd68d580 = getent("defend_gate_r", "targetname");
    var_627738ce hide();
    var_dd68d580 hide();
    array::thread_all(level.var_df1caa96, &init_rune);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xef597026, Offset: 0x10890
// Size: 0x84
function light_runes_setup(b_skipped) {
    level endon(#"end_game");
    array::thread_all(level.var_df1caa96, &function_e8c65b9f);
    level thread function_2871bbf5();
    level flag::wait_till(#"hash_20c92720a4602dc7");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x25a4db29, Offset: 0x10920
// Size: 0x4a
function light_runes_cleanup(b_skipped, var_c86ff890) {
    level flag::clear(#"hash_cad6742c753621");
    level.var_7ad329fe = undefined;
    level.var_df1caa96 = undefined;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0xd02fc709, Offset: 0x10978
// Size: 0x12a
function private init_rune() {
    self hide();
    self.t_trig = getent(self.target, "targetname");
    self.b_active = 1;
    self.s_anchor = struct::get(self.target);
    level.var_7ad329fe = 0;
    a_set = getentarray(self.targetname, "targetname");
    foreach (e_rune in a_set) {
        if (e_rune.script_int == self.script_int + 1) {
            self.e_next = e_rune;
            break;
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0xac408371, Offset: 0x10ab0
// Size: 0x268
function private function_e8c65b9f() {
    level endon(#"end_game");
    self show();
    self hidepart("tag_glow");
    while (self.b_active) {
        waitresult = self.t_trig waittill(#"charge_hit");
        if (self function_e869b4ec(waitresult.position, waitresult.direction, waitresult.attacker)) {
            for (e_rune = self; isdefined(e_rune); e_rune = e_rune.e_next) {
                e_rune thread function_9c6c2fdd(1);
            }
            level.var_7ad329fe++;
            level thread function_27c5fc6a(level.var_7ad329fe);
            if (level.var_7ad329fe == 3) {
                level flag::set(#"hash_20c92720a4602dc7");
                /#
                    foreach (e_player in level.players) {
                        e_player.var_45a5c867 = array();
                        e_player.var_b213abee = array();
                    }
                #/
                e_player = waitresult.attacker;
                e_player zm_vo::vo_stop();
                e_player thread zm_vo::function_59635cc4("m_quest_water_resp", 1, 0, 9999, 1);
            }
            continue;
        }
        self thread function_9c6c2fdd(0);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x4
// Checksum 0x55988a0c, Offset: 0x10d20
// Size: 0x9c
function private function_9c6c2fdd(b_complete) {
    self showpart("tag_glow");
    if (b_complete) {
        self.b_active = 0;
        level thread function_e944e19c();
        level flag::wait_till(#"hash_20c92720a4602dc7");
        return;
    }
    wait 2;
    self hidepart("tag_glow");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0xdf0385a1, Offset: 0x10dc8
// Size: 0x64
function private function_e944e19c() {
    e_gate = getent("aqueduct_door", "targetname");
    e_gate moveto(e_gate.origin + (0, 0, 10), 3);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x4
// Checksum 0x2266dc2b, Offset: 0x10e38
// Size: 0xda
function private function_27c5fc6a(n_count) {
    switch (n_count) {
    case 1:
        exploder::exploder("exp_aqueduct_1");
        break;
    case 2:
        exploder::exploder("exp_aqueduct_2");
        exploder::kill_exploder("exp_aqueduct_1");
        break;
    case 3:
        exploder::exploder("exp_aqueduct_3");
        exploder::kill_exploder("exp_aqueduct_2");
        break;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 3, eflags: 0x4
// Checksum 0xfa6df737, Offset: 0x10f20
// Size: 0x26e
function private function_e869b4ec(v_pos, v_dir, e_player) {
    s_line = spawnstruct();
    s_line.v_from = v_pos;
    s_line.v_to = s_line.v_from + v_dir * 3000;
    s_result = self function_dc4a5ea5(s_line.v_from, s_line.v_to, v_dir);
    /#
        e_player.var_45a5c867 = array();
        e_player.var_b213abee = array();
        if (!isdefined(e_player.var_45a5c867)) {
            e_player.var_45a5c867 = [];
        } else if (!isarray(e_player.var_45a5c867)) {
            e_player.var_45a5c867 = array(e_player.var_45a5c867);
        }
        if (!isinarray(e_player.var_45a5c867, s_line)) {
            e_player.var_45a5c867[e_player.var_45a5c867.size] = s_line;
        }
        if (!(isdefined(e_player.b_drawing) && e_player.b_drawing)) {
            e_player thread function_e858dde();
            e_player.b_drawing = 1;
        }
        e_player.var_45a5c867 = arraycombine(e_player.var_45a5c867, s_result.a_s_lines, 0, 0);
        e_player.var_b213abee = arraycombine(e_player.var_b213abee, s_result.a_v_points, 0, 0);
        e_player notify(#"start_draw");
    #/
    if (s_result.a_v_points.size == 3) {
        return true;
    }
    return false;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 3, eflags: 0x4
// Checksum 0x5246795e, Offset: 0x11198
// Size: 0x384
function private function_dc4a5ea5(v_start, v_end, v_heading) {
    a_v_points = array();
    a_s_lines = array();
    var_482f223e = (0, 0, 0);
    if (!isdefined(a_v_points)) {
        a_v_points = [];
    } else if (!isarray(a_v_points)) {
        a_v_points = array(a_v_points);
    }
    if (!isinarray(a_v_points, v_start)) {
        a_v_points[a_v_points.size] = v_start;
    }
    if (isdefined(self.e_next)) {
        var_af7e5935 = self.e_next;
        v_heading = function_afb80e6(v_heading, var_af7e5935);
        v_end = v_start + v_heading * 3000;
    }
    while (var_482f223e !== v_start) {
        var_482f223e = v_start;
        if (isdefined(var_af7e5935)) {
            var_49d3359d = bullettrace(v_start, v_end, 0, self);
            if (isdefined(var_49d3359d[#"position"])) {
                v_start = var_49d3359d[#"position"] + v_heading * 1;
                if (distancesquared(var_49d3359d[#"position"], var_af7e5935.s_anchor.origin) < 1600) {
                    v_heading = function_afb80e6(v_heading, var_af7e5935);
                    v_end = v_start + v_heading * 3000;
                    var_af7e5935 = var_af7e5935.e_next;
                    if (!isdefined(a_v_points)) {
                        a_v_points = [];
                    } else if (!isarray(a_v_points)) {
                        a_v_points = array(a_v_points);
                    }
                    if (!isinarray(a_v_points, v_start)) {
                        a_v_points[a_v_points.size] = v_start;
                    }
                }
            }
        }
    }
    for (i = 0; i < a_v_points.size - 1; i++) {
        s_line = {#v_from:a_v_points[i], #v_to:a_v_points[i + 1]};
        if (!isdefined(a_s_lines)) {
            a_s_lines = [];
        } else if (!isarray(a_s_lines)) {
            a_s_lines = array(a_s_lines);
        }
        if (!isinarray(a_s_lines, s_line)) {
            a_s_lines[a_s_lines.size] = s_line;
        }
    }
    return {#a_v_points:a_v_points, #a_s_lines:a_s_lines};
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x4
// Checksum 0x17cab8ef, Offset: 0x11528
// Size: 0xa2
function private function_afb80e6(v_dir, e_rune) {
    if (!isdefined(e_rune.e_next)) {
        return v_dir;
    }
    var_8c101c06 = vectornormalize(e_rune.e_next.s_anchor.origin - e_rune.s_anchor.origin);
    var_a47b32d1 = vectorlerp(v_dir, var_8c101c06, 0.38);
    return var_a47b32d1;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x4c71b304, Offset: 0x115d8
// Size: 0x1d8
function private function_2871bbf5() {
    level endon(#"end_game");
    level flag::set(#"hash_cad6742c753621");
    while (level flag::get(#"hash_cad6742c753621")) {
        s_result = level waittill(#"xbow_hit");
        v_pos = s_result.position;
        e_player = s_result.player;
        foreach (e_rune in level.var_df1caa96) {
            v_dist = distancesquared(v_pos, e_rune.s_anchor.origin);
            if (v_dist < 1600) {
                v_dir = vectornormalize(v_pos - e_player geteye());
                e_rune.t_trig notify(#"charge_hit", {#position:v_pos, #attacker:e_player, #direction:v_dir});
            }
        }
    }
}

/#

    // Namespace zm_towers_main_quest/zm_towers_main_quest
    // Params 0, eflags: 0x4
    // Checksum 0xa2bfd209, Offset: 0x117b8
    // Size: 0x15a
    function private function_e858dde() {
        self waittill(#"start_draw");
        while (!level flag::get(#"hash_20c92720a4602dc7")) {
            foreach (s_line in self.var_45a5c867) {
                line(s_line.v_from, s_line.v_to, (0, 0, 1));
            }
            foreach (v_sphere in self.var_b213abee) {
                sphere(v_sphere, 2, (1, 0, 0));
            }
            waitframe(1);
        }
    }

#/

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x4456fe7c, Offset: 0x11920
// Size: 0x4c
function pressure_plate_setup(b_skipped) {
    var_699d3546 = getent("defend_pplate_trig", "targetname");
    var_699d3546 function_6616fb70();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0xb9d4ef40, Offset: 0x11978
// Size: 0x14
function pressure_plate_cleanup(b_skipped, var_c86ff890) {
    
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x8be09a6, Offset: 0x11998
// Size: 0x28e
function private function_6616fb70() {
    level endon(#"end_game");
    b_active = 1;
    self.a_e_players = array();
    for (var_74a8cf96 = 0; b_active; var_74a8cf96 = 0) {
        waitresult = self waittill(#"trigger");
        if (level flag::get("special_round") || level flag::get(#"hash_4fd3d0c01f9b4c30")) {
            waitframe(1);
            continue;
        }
        e_player = waitresult.activator;
        if (!isinarray(self.a_e_players, e_player)) {
            self playsound(#"hash_72a17706cb2656cd");
        }
        waitframe(1);
        self.a_e_players = array();
        foreach (player in level.players) {
            if (player istouching(self)) {
                if (!isdefined(self.a_e_players)) {
                    self.a_e_players = [];
                } else if (!isarray(self.a_e_players)) {
                    self.a_e_players = array(self.a_e_players);
                }
                if (!isinarray(self.a_e_players, player)) {
                    self.a_e_players[self.a_e_players.size] = player;
                }
            }
        }
        if (self.a_e_players.size == level.players.size) {
            var_74a8cf96 += 0.1;
            if (var_74a8cf96 > 6) {
                b_active = 0;
            }
            continue;
        }
    }
}

/#

    // Namespace zm_towers_main_quest/zm_towers_main_quest
    // Params 0, eflags: 0x4
    // Checksum 0x94443d3c, Offset: 0x11c30
    // Size: 0x208
    function private debug_spawns() {
        level endon(#"stop_debug_spawn");
        level flag::wait_till(#"hash_2bf040db75b1dac7");
        v_test = getent("<dev string:xa5>", "<dev string:xb2>");
        while (true) {
            s_result = level waittill(#"trilane_debug");
            if (isdefined(s_result.ai) && isdefined(s_result.spawn.origin) && s_result.ai istouching(v_test)) {
                if (!isdefined(level.var_ba84878f)) {
                    level.var_ba84878f = array();
                }
                if (!isdefined(level.var_ba84878f)) {
                    level.var_ba84878f = [];
                } else if (!isarray(level.var_ba84878f)) {
                    level.var_ba84878f = array(level.var_ba84878f);
                }
                if (!isinarray(level.var_ba84878f, s_result.spawn.origin)) {
                    level.var_ba84878f[level.var_ba84878f.size] = s_result.spawn.origin;
                }
                iprintlnbold("<dev string:xbd>" + s_result.spawn.origin);
            }
        }
    }

    // Namespace zm_towers_main_quest/weapon_fired
    // Params 1, eflags: 0x40
    // Checksum 0xced6aeb5, Offset: 0x11e40
    // Size: 0x1b4
    function event_handler[weapon_fired] debug_trilane(event_struct) {
        if (!getdvarint(#"zm_debug_ee", 0) || !getdvarint(#"zm_debug_trilane", 0) >= 1 || !self zm_zonemgr::entity_in_zone("<dev string:xda>", 0)) {
            return;
        }
        setdvar(#"zm_debug_trilane", 0);
        level thread debug_spawns();
        level trilane_defend_setup(1);
        level flag::clear(#"hash_20c92720a4602dc7");
        level flag::clear(#"hash_cad6742c753621");
        level flag::clear(#"hash_6b64093194524df3");
        level flag::clear(#"hash_2bf040db75b1dac7");
        level flag::clear(#"hash_277d03629ade12e8");
        level notify(#"stop_debug_spawn");
        setdvar(#"zm_debug_trilane", 1);
    }

#/

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x93ceb110, Offset: 0x12000
// Size: 0x324
function trilane_defend_setup(b_skipped) {
    level endon(#"end_game");
    var_d6ac774e = level.var_372a5b91;
    level.var_372a5b91 = 0;
    level.var_72cfa0d6 = 0;
    level.var_418e5516 = array();
    level.var_f33fe6e9 = array();
    level.var_b9430b31 = array();
    level flag::clear("spawn_zombies");
    level flag::clear("zombie_drop_powerups");
    level flag::set(#"pause_round_timeout");
    level flag::set(#"hash_4f293396150d2c00");
    function_bd5f6c56(0);
    level zm_utility::function_1a046290(1);
    level function_e846bb2d();
    level thread zm_audio::sndannouncerplayvox(#"hash_24e22336a0d988d0");
    wait 2;
    level thread function_28da48d3();
    level thread defend_timer();
    level thread function_47d13f17();
    level thread function_e2a3b7ed();
    level flag::wait_till(#"hash_6b64093194524df3");
    wait 1;
    level zm_utility::function_1a046290(0);
    level flag::set("spawn_zombies");
    level flag::set("zombie_drop_powerups");
    level flag::clear(#"pause_round_timeout");
    level thread function_16be1e6a();
    level flag::clear(#"hash_4f293396150d2c00");
    wait 2;
    level.var_372a5b91 = var_d6ac774e;
    function_bd5f6c56(1);
    level flag::set(#"hash_34294ceb082c5d8f");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x9b39525d, Offset: 0x12330
// Size: 0x9c
function trilane_defend_cleanup(b_skipped, var_c86ff890) {
    level.var_72cfa0d6 = undefined;
    level.var_418e5516 = undefined;
    level.var_f33fe6e9 = undefined;
    level.var_b9430b31 = undefined;
    level.var_bab5a452 = undefined;
    level.var_231e0deb = undefined;
    level.var_5d4ce22c = undefined;
    level flag::set(#"hash_37071af70fe7a9f2");
    exploder::exploder("exp_odin_eyes");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x9e6f5879, Offset: 0x123d8
// Size: 0x1b4
function private function_e846bb2d() {
    e_l_door = getent("zm_gate_l", "targetname");
    var_627738ce = getent("defend_gate_l", "targetname");
    e_l_door linkto(var_627738ce);
    e_r_door = getent("zm_gate_r", "targetname");
    var_dd68d580 = getent("defend_gate_r", "targetname");
    e_r_door linkto(var_dd68d580);
    var_627738ce rotateto(var_627738ce.angles + (0, 85, 0), 1);
    var_dd68d580 rotateto(var_dd68d580.angles - (0, 70, 0), 1);
    wait 1.5;
    level thread lui::screen_flash(0.5, 2.5, 4, 1, "white");
    wait 0.1;
    function_c8851a77(array("defend_trilane_door"));
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0xdf717f75, Offset: 0x12598
// Size: 0xf4
function private function_16be1e6a() {
    var_627738ce = getent("defend_gate_l", "targetname");
    var_dd68d580 = getent("defend_gate_r", "targetname");
    var_627738ce rotateto(var_627738ce.angles - (0, 85, 0), 1);
    var_dd68d580 rotateto(var_dd68d580.angles + (0, 70, 0), 1);
    wait 1.5;
    function_3fc94d2a(array("defend_trilane_door"));
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x13b199fb, Offset: 0x12698
// Size: 0x1fc
function private defend_timer() {
    level endon(#"end_game");
    level flag::set(#"hash_2bf040db75b1dac7");
    n_total_time = 300;
    var_b8033794 = 0;
    var_ecc4576a = 0;
    while (level.var_72cfa0d6 <= n_total_time) {
        wait 0.1;
        level.var_72cfa0d6 += 0.1;
        if (isdefined(level.var_418e5516[0]) && level.var_72cfa0d6 >= level.var_418e5516[0].time) {
            level notify(#"hash_54e0394dae6dd7");
        }
        if (isdefined(level.var_f33fe6e9[0]) && level.var_72cfa0d6 >= level.var_f33fe6e9[0].time) {
            level notify(#"hash_68337916c80885b2");
        }
        if (!var_b8033794 && level.var_72cfa0d6 >= 90) {
            function_dbb322f8();
            var_b8033794 = 1;
            wait 3;
            continue;
        }
        if (!var_ecc4576a && level.var_72cfa0d6 >= 180) {
            function_dbb322f8();
            var_ecc4576a = 1;
            wait 3;
        }
    }
    function_dbb322f8();
    level flag::set(#"hash_277d03629ade12e8");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xbc615d89, Offset: 0x128a0
// Size: 0x94
function key_glint() {
    level endon(#"end_game");
    level flag::wait_till("all_players_spawned");
    mdl_key = getent("defend_key_model", "targetname");
    mdl_key clientfield::set("" + #"hash_23ba00d2f804acc2", 1);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x31ec0e5b, Offset: 0x12940
// Size: 0x13c
function private function_28da48d3() {
    level endon(#"end_game");
    level flag::wait_till(#"hash_2bf040db75b1dac7");
    n_total_time = 300;
    mdl_key = getent("defend_key_model", "targetname");
    mdl_key movez(87, n_total_time);
    mdl_water = getent("defend_key_water", "targetname");
    mdl_water movez(87, n_total_time);
    while (level.var_72cfa0d6 <= n_total_time) {
        wait 1;
    }
    level flag::wait_till(#"hash_277d03629ade12e8");
    level thread function_6f6e55ab();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x33c0ffea, Offset: 0x12a88
// Size: 0x18c
function private function_6f6e55ab() {
    level endon(#"end_game");
    s_key = struct::get("defend_key_loc");
    s_key zm_unitrigger::create(&function_c933b130, (96, 180, 96));
    e_key = getent("defend_key_model", "targetname");
    s_waitresult = s_key waittill(#"trigger_activated");
    e_key clientfield::set("" + #"hash_23ba00d2f804acc2", 0);
    e_key hide();
    level flag::set(#"hash_6b64093194524df3");
    e_player = s_waitresult.e_who;
    e_player zm_vo::vo_stop();
    e_player zm_vo::function_59635cc4("m_quest_key_pickup", 0, 0, 9999, 1);
    level thread function_5eafa113();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xc599f210, Offset: 0x12c20
// Size: 0x94
function function_5eafa113() {
    level zm_audio::sndannouncerplayvox(#"hash_41d25c641d7c8484");
    e_player = array::random(util::get_active_players());
    e_player zm_vo::vo_stop();
    e_player zm_vo::function_59635cc4("m_quest_odin_complete_resp", 0, 0, 9999, 1);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x4
// Checksum 0x104c87a6, Offset: 0x12cc0
// Size: 0x36
function private function_c933b130(e_player) {
    if (!level flag::get(#"hash_6b64093194524df3")) {
        return true;
    }
    return false;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0xfdaf7d4d, Offset: 0x12d00
// Size: 0x2d50
function private function_e2a3b7ed() {
    level endon(#"end_game");
    level.var_bab5a452 = struct::get_array("defend_trilane_01");
    level.var_231e0deb = struct::get_array("defend_trilane_02");
    level.var_5d4ce22c = struct::get_array("defend_trilane_03");
    var_1d90bd37 = 9;
    var_ab894dfc = 9;
    var_d18bc865 = 9.23077;
    level.var_418e5516 = array({#time:0, #archetype:#"normal", #quantity:1, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37 * 1.5, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:4}, {#time:var_1d90bd37 * 2, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37 * 3, #archetype:#"plasma", #quantity:1, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37 * 3, #archetype:#"plasma", #quantity:2, #lanes:array(1, 2, 3), #minplayers:3}, {#time:var_1d90bd37 * 4, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37 * 4, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:2}, {#time:var_1d90bd37 * 4, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:4}, {#time:var_1d90bd37 * 5, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37 * 5, #archetype:#"tiger", #quantity:1, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37 * 5, #archetype:#"tiger", #quantity:1, #lanes:array(1, 2, 3), #minplayers:3}, {#time:var_1d90bd37 * 6, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37 * 6, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:3}, {#time:var_1d90bd37 * 7, #archetype:#"plasma", #quantity:1, #lanes:array(1, 3), #minplayers:1}, {#time:var_1d90bd37 * 7, #archetype:#"plasma", #quantity:2, #lanes:array(1, 2, 3), #minplayers:3}, {#time:var_1d90bd37 * 7.5, #archetype:#"plasma", #quantity:1, #lanes:array(1, 2, 3), #minplayers:4}, {#time:var_1d90bd37 * 7.5, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37 * 8, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37 * 8, #archetype:#"tiger", #quantity:3, #lanes:array(2), #minplayers:1}, {#time:var_1d90bd37 * 8, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:3}, {#time:var_1d90bd37 * 8, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:4}, {#time:var_1d90bd37 * 9, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37 * 9, #archetype:#"tiger", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:var_1d90bd37 * 9, #archetype:#"tiger", #quantity:2, #lanes:array(1, 2, 3), #minplayers:3}, {#time:90 + var_ab894dfc, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:90 + var_ab894dfc * 2, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:90 + var_ab894dfc * 3, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:3}, {#time:90 + var_ab894dfc * 4, #archetype:#"corrosive", #quantity:1, #lanes:array(1, 2, 3), #minplayers:1}, {#time:90 + var_ab894dfc * 4, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:4}, {#time:90 + var_ab894dfc * 4, #archetype:#"plasma", #quantity:2, #lanes:array(1, 2, 3), #minplayers:3}, {#time:90 + var_ab894dfc * 5, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:90 + var_ab894dfc * 5, #archetype:#"glad_m", #quantity:1, #lanes:array(1, 2, 3), #minplayers:1}, {#time:90 + var_ab894dfc * 5, #archetype:#"glad_m", #quantity:1, #lanes:array(1, 2, 3), #minplayers:3}, {#time:90 + var_ab894dfc * 6, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:1}, {#time:90 + var_ab894dfc * 7, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:1}, {#time:90 + var_ab894dfc * 7, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:4}, {#time:90 + var_ab894dfc * 7, #archetype:#"corrosive", #quantity:1, #lanes:array(1, 2, 3), #minplayers:2}, {#time:90 + var_ab894dfc * 7, #archetype:#"corrosive", #quantity:2, #lanes:array(1, 2, 3), #minplayers:4}, {#time:90 + var_ab894dfc * 7, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:3}, {#time:90 + var_ab894dfc * 8, #archetype:#"glad_m", #quantity:1, #lanes:array(1, 2, 3), #minplayers:3}, {#time:90 + var_ab894dfc * 9, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:90 + var_ab894dfc * 9, #archetype:#"glad_r", #quantity:1, #lanes:array(1, 2, 3), #minplayers:1}, {#time:90 + var_ab894dfc * 9, #archetype:#"glad_r", #quantity:1, #lanes:array(1, 2, 3), #minplayers:2}, {#time:90 + var_ab894dfc * 9, #archetype:#"glad_r", #quantity:1, #lanes:array(1, 2, 3), #minplayers:4}, {#time:180 + var_d18bc865, #archetype:#"tiger", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 2, #archetype:#"tiger", #quantity:3, #lanes:array(1, 2, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 2.5, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:4}, {#time:180 + var_d18bc865 * 3, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:2}, {#time:180 + var_d18bc865 * 3, #archetype:#"tiger", #quantity:2, #lanes:array(1, 3), #minplayers:3}, {#time:180 + var_d18bc865 * 4, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 4, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:2}, {#time:180 + var_d18bc865 * 5, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:3}, {#time:180 + var_d18bc865 * 5, #archetype:#"glad_m", #quantity:1, #lanes:array(1, 2, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 5, #archetype:#"glad_r", #quantity:1, #lanes:array(1, 2, 3), #minplayers:3}, {#time:180 + var_d18bc865 * 6, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 6, #archetype:#"plasma", #quantity:1, #lanes:array(1, 2, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 7, #archetype:#"tiger", #quantity:2, #lanes:array(1, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 7, #archetype:#"normal", #quantity:2, #lanes:array(1, 2, 3), #minplayers:4}, {#time:180 + var_d18bc865 * 8, #archetype:#"tiger", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 8.5, #archetype:#"tiger", #quantity:2, #lanes:array(2), #minplayers:1}, {#time:180 + var_d18bc865 * 9, #archetype:#"glad_m", #quantity:2, #lanes:array(1, 2, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 9, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:4}, {#time:180 + var_d18bc865 * 9, #archetype:#"glad_m", #quantity:1, #lanes:array(1, 2, 3), #minplayers:3}, {#time:180 + var_d18bc865 * 9, #archetype:#"glad_r", #quantity:2, #lanes:array(2), #minplayers:1}, {#time:180 + var_d18bc865 * 10, #archetype:#"normal", #quantity:3, #lanes:array(1, 2, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 10, #archetype:#"corrosive", #quantity:1, #lanes:array(1, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 10, #archetype:#"tiger", #quantity:3, #lanes:array(2), #minplayers:1}, {#time:180 + var_d18bc865 * 10, #archetype:#"glad_m", #quantity:2, #lanes:array(2), #minplayers:2}, {#time:180 + var_d18bc865 * 10, #archetype:#"glad_r", #quantity:2, #lanes:array(1, 3), #minplayers:4}, {#time:180 + var_d18bc865 * 11, #archetype:#"normal", #quantity:4, #lanes:array(1, 2, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 11, #archetype:#"blight", #quantity:1, #lanes:array(1), #minplayers:1}, {#time:180 + var_d18bc865 * 11, #archetype:#"blight", #quantity:1, #lanes:array(3), #minplayers:2}, {#time:180 + var_d18bc865 * 11.5, #archetype:#"blight", #quantity:1, #lanes:array(3), #minplayers:4}, {#time:180 + var_d18bc865 * 12, #archetype:#"normal", #quantity:4, #lanes:array(1, 2, 3), #minplayers:1}, {#time:180 + var_d18bc865 * 12.5, #archetype:#"normal", #quantity:4, #lanes:array(1, 2, 3), #minplayers:3});
    while (!level flag::get(#"hash_277d03629ade12e8")) {
        level waittill(#"hash_54e0394dae6dd7");
        var_c4b0f01c = array::pop_front(level.var_418e5516, 0);
        level thread defend_spawn(var_c4b0f01c);
        if (!level.var_418e5516.size) {
            level flag::wait_till(#"hash_277d03629ade12e8");
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x4
// Checksum 0x5f821920, Offset: 0x15a58
// Size: 0x5ac
function private defend_spawn(var_e424b183) {
    if (level.players.size < var_e424b183.minplayers) {
        return;
    }
    foreach (n_lane in var_e424b183.lanes) {
        switch (n_lane) {
        case 1:
            var_c908420d = level.var_bab5a452;
            break;
        case 2:
            var_c908420d = level.var_231e0deb;
            break;
        case 3:
            var_c908420d = level.var_5d4ce22c;
            break;
        default:
            return;
        }
        for (i = 0; i < var_e424b183.quantity; i++) {
            while (level.ai[#"axis"].size >= 24) {
                level.var_72cfa0d6 -= 0.1;
                waitframe(1);
            }
            var_7db52b72 = array::random(var_c908420d);
            switch (var_e424b183.archetype) {
            case #"normal":
                for (ai = undefined; !isdefined(ai); ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], "defend_trilane_fill", var_7db52b72, level.round_number + 8)) {
                    wait 0.5;
                }
                break;
            case #"plasma":
                ai = undefined;
                while (!isdefined(ai)) {
                    ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], "defend_trilane_spawn", var_7db52b72, level.round_number + 8);
                    wait 0.5;
                }
                while (zm_transform::function_5836d278("catalyst_plasma")) {
                    waitframe(1);
                }
                zm_transform::function_3b866d7e(ai, "catalyst_plasma");
                break;
            case #"corrosive":
                ai = undefined;
                while (!isdefined(ai)) {
                    ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], "defend_trilane_spawn", var_7db52b72, level.round_number + 8);
                    wait 0.5;
                }
                while (zm_transform::function_5836d278("catalyst_corrosive")) {
                    waitframe(1);
                }
                zm_transform::function_3b866d7e(ai, "catalyst_corrosive");
                break;
            case #"glad_m":
                zombie_gladiator_util::function_e8c77e88(1, "melee", undefined, 1, var_7db52b72);
                break;
            case #"glad_r":
                zombie_gladiator_util::function_e8c77e88(1, "ranged", undefined, 1, var_7db52b72);
                break;
            case #"blight":
                ai = undefined;
                while (!isdefined(ai)) {
                    ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], "defend_trilane_spawn", var_7db52b72, level.round_number);
                    wait 0.5;
                }
                while (zm_transform::function_5836d278("blight_father")) {
                    waitframe(1);
                }
                zm_transform::function_3b866d7e(ai, "blight_father", &function_af0559b9);
                break;
            case #"tiger":
                var_6f0b660b = getspawnerarray("zombie_spawner_tiger", "targetname")[0];
                ai = undefined;
                while (!isdefined(ai)) {
                    ai = zombie_utility::spawn_zombie(var_6f0b660b, "defend_trilane_spawn", var_7db52b72, level.round_number);
                    wait 0.5;
                }
                break;
            default:
                return;
            }
        }
        /#
            wait 1;
            if (isdefined(ai)) {
                level notify(#"trilane_debug", {#ai:ai, #spawn:var_7db52b72});
            }
        #/
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x76e9a952, Offset: 0x16010
// Size: 0x1a8
function private function_47d13f17() {
    level endon(#"end_game");
    level.var_f33fe6e9 = array({#time:95, #powerup:"hero_weapon_power", #delay:&function_dbb322f8}, {#time:185, #powerup:"full_ammo", #delay:&function_dbb322f8});
    s_loc = struct::get(#"hash_74b68c7b7af8e368");
    while (!level flag::get(#"hash_277d03629ade12e8")) {
        level waittill(#"hash_68337916c80885b2");
        var_c4b0f01c = array::pop_front(level.var_f33fe6e9, 0);
        if (isdefined(var_c4b0f01c.delay)) {
            level [[ var_c4b0f01c.delay ]]();
        }
        level thread zm_powerups::specific_powerup_drop(var_c4b0f01c.powerup, s_loc.origin);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x4
// Checksum 0x70242bd1, Offset: 0x161c0
// Size: 0x64
function private function_af0559b9(ai) {
    ai endon(#"death");
    ai function_7e378484(array("zone_body_pit"), array("defend_notongue_vol"));
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0xdaadd7e1, Offset: 0x16230
// Size: 0x150
function private function_dbb322f8() {
    level endon(#"end_game");
    while (level.ai[#"axis"].size) {
        for (i = 0; i < level.ai[#"axis"].size; i++) {
            ai_enemy = level.ai[#"axis"][i];
            if (!ai_enemy zm_zonemgr::entity_in_zone("zone_body_pit")) {
                if (!isdefined(ai_enemy.var_7ddba3e1)) {
                    ai_enemy.var_7ddba3e1 = 0;
                }
                ai_enemy.var_7ddba3e1 += 0.01;
                if (ai_enemy.var_7ddba3e1 > 12 && isdefined(ai_enemy.allowdeath) && ai_enemy.allowdeath) {
                    ai_enemy kill();
                }
            }
        }
        waitframe(1);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xd4aff70d, Offset: 0x16388
// Size: 0x12c
function function_8945d1a2(e_trig) {
    level endon(#"end_game");
    if (getdvarint(#"zm_debug_boss", 0) >= 1) {
        level flag::set(#"hash_37071af70fe7a9f2");
    }
    level flag::wait_till(#"hash_37071af70fe7a9f2");
    foreach (player in getplayers()) {
        e_trig setvisibletoplayer(player);
    }
    level function_947f4778(e_trig);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x7f5e1c40, Offset: 0x164c0
// Size: 0x3f4
function function_947f4778(e_trig) {
    level endon(#"end_game");
    var_ac039fba = 0;
    b_teleported = 0;
    level.boss_entry_tower_remains = getent("boss_entry_tower_remains", "targetname");
    level.boss_entry_tower_remains hide();
    entrance_tower_collision = getent("entrance_tower_collision", "targetname");
    entrance_tower_collision disconnectpaths();
    scene::init("p8_fxanim_zm_towers_boss_arena_gate_destroy_bundle");
    var_235204bb = getdvar(#"hash_3065419bcba97739", 0);
    if (!var_235204bb) {
        while (!b_teleported) {
            while (!var_ac039fba) {
                e_trig waittill(#"touch");
                var_e6f71433 = getplayers();
                var_628ee53f = 0;
                foreach (e_player in var_e6f71433) {
                    if (e_player istouching(e_trig)) {
                        var_628ee53f++;
                    }
                }
                if (var_628ee53f == var_e6f71433.size) {
                    var_ac039fba = 1;
                    continue;
                }
                var_ac039fba = 0;
            }
            level thread zm_audio::function_709246c9(#"m_quest", #"open_gate", undefined, 1);
            e_trig waittill(#"trigger");
            var_e6f71433 = getplayers();
            var_628ee53f = 0;
            foreach (e_player in var_e6f71433) {
                if (e_player istouching(e_trig)) {
                    var_628ee53f++;
                }
            }
            if (var_628ee53f == var_e6f71433.size) {
                b_teleported = 1;
            }
        }
    }
    level scene::init("boss_battle_tempo", "targetname");
    var_c727155c = struct::get_array("s_zm_towers_port_to_boss", "targetname");
    var_e6f71433 = getplayers();
    for (i = 0; i < var_e6f71433.size; i++) {
        var_e6f71433[i] setorigin(var_c727155c[i].origin);
        var_e6f71433[i] setplayerangles(var_c727155c[i].angles);
    }
    level thread boss_fight();
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x680ba013, Offset: 0x168c0
// Size: 0xe4
function function_e3a37444() {
    tower = struct::get("entrance_tower", "targetname");
    entrance_tower_collision = getent("entrance_tower_collision", "targetname");
    if (isdefined(entrance_tower_collision)) {
        entrance_tower_collision connectpaths();
        entrance_tower_collision delete();
    }
    if (isdefined(tower)) {
        tower thread scene::play();
        wait scene::function_a2174d35(#"p8_fxanim_zm_towers_boss_arena_tower_entrance_bundle");
        level.boss_entry_tower_remains show();
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xa5a37260, Offset: 0x169b0
// Size: 0x48
function function_2272ba33() {
    t_tower = getent("gate_2_flesh_tower", "script_string");
    if (isdefined(t_tower)) {
        t_tower notify(#"tower_boss_scripted_trigger_tower");
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x77dec15c, Offset: 0x16a00
// Size: 0xe28
function boss_fight() {
    level endon(#"end_game");
    level flag::set(#"hash_672bacab1faa8415");
    zm_towers_crowd::function_77f68f25(0);
    zm_towers_crowd::function_5ff4429f(1);
    level.var_dcc8a45d = 1;
    array::thread_all(level.players, &zm_towers_crowd::function_d3d3dcf0, 0, 1);
    zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 6);
    level flag::set(#"hash_4f293396150d2c00");
    level function_b7e5de3b(1, 0);
    var_cf2fc775 = zm_round_spawning::function_e7543004();
    if (isdefined(var_cf2fc775)) {
        zm_round_spawning::function_238c1e66(var_cf2fc775.n_round);
    }
    level thread function_905ad30f();
    function_bd5f6c56(0);
    level flag::clear("spawn_zombies");
    level flag::set("pause_round_timeout");
    if (!getdvar(#"hash_2b64162aa40fe2bb", 0)) {
        function_55e952af();
        zm_round_spawning::function_c615ce5b(&function_f7a159be);
        zm_round_spawning::function_1707d338(&function_fd81cf2a);
        level.var_372a5b91 = 0;
        level.var_ae2b7a0b = arraycopy(level.var_6945ba47);
    }
    level zm_utility::function_1a046290(1);
    foreach (player in level.players) {
        player clientfield::set_to_player("snd_crowd_react", 11);
    }
    zm_zonemgr::enable_zone("zone_boss_battle");
    level thread function_7d33221e();
    var_235204bb = getdvar(#"hash_3065419bcba97739", 0);
    if (!var_235204bb) {
        wait 8;
    }
    if (getdvar(#"hash_2b64162aa40fe2bb", 0)) {
        scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 1");
        scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 2");
        scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 3");
    } else {
        level thread function_a6f11fca();
        level waittill(#"hash_12768f75609d32ca");
    }
    level clientfield::set("crowd_react_boss", 0);
    if (!var_235204bb) {
        wait 6;
    }
    level.var_372a5b91 = 15;
    var_bce751d0 = struct::get("towers_boss_location_1", "script_noteworthy");
    sp_spawner = getent("zombie_towers_boss_spawner", "script_noteworthy");
    level thread function_aa8faae8();
    level thread function_41e0034a();
    level thread function_5007476d(#"hash_4b701378fdc308f", "m_quest", "spear_warn");
    level thread function_5007476d(#"hash_5c38f322b9e6a58d", "m_quest", "missle_warn");
    level thread function_5007476d(#"hash_1a3fb5566689f319", "m_quest", "missle_track");
    level thread function_5007476d(#"hash_1580cd3b2c801f46", "m_quest", "charge_warn");
    level thread function_5007476d(#"towers_boss_ground_attack", "m_quest", "shockwave_warn");
    level thread function_7de8f93();
    level thread function_e2813db8(125, level.var_41f6af22, "m_quest", "armor_nag");
    level thread function_e2813db8(187, level.var_5ed2dc7e, "m_quest", "basket_nag");
    level thread function_e2813db8(211, level.var_41f6af22, "m_quest", "heart_nag");
    array::thread_all(level.players, &function_916aa01);
    trigger::wait_till("large_gate_l_trigger", "targetname");
    e_elephant = spawner::simple_spawn_single(sp_spawner, &function_45ea368c, var_bce751d0, #"hash_266f53fb994e6120");
    while (!isdefined(e_elephant.ai.riders) || e_elephant.ai.riders.size < 2) {
        wait 0.1;
    }
    level util::delay(2, undefined, &clientfield::set, "crowd_react_boss", 1);
    level.var_e04e0ed7 = 1;
    animation::add_global_notetrack_handler("tower_contact", &function_e3a37444, 0);
    scene::play(#"aib_vign_cust_zm_twrs_ent_hllpht_00", array(e_elephant));
    e_elephant notify(#"entrace_done");
    level thread function_b9974d6a();
    wait 2;
    function_f3ca49ac();
    if (!getdvar(#"hash_2b64162aa40fe2bb", 0)) {
        level flag::set("spawn_zombies");
        level flag::set(#"infinite_round_spawning");
    }
    callback::remove_on_ai_killed(&function_3e487f8d);
    e_elephant waittill(#"death");
    foreach (player in level.players) {
        player clientfield::set_to_player("snd_crowd_react", 13);
    }
    level flag::clear("spawn_zombies");
    wait 1;
    level zm_utility::function_1a046290(0);
    level thread function_802e7219();
    wait 15;
    function_f3ca49ac();
    wait 2;
    trigger::wait_till("large_gate_r_trigger", "targetname");
    level notify(#"hash_5d826e11ebe4b6e7");
    level.var_4fc87c7d = 1;
    var_1372448b = struct::get("towers_boss_location_2", "script_noteworthy");
    sp_spawner = getent("zombie_towers_boss2_spawner", "script_noteworthy");
    e_elephant = spawner::simple_spawn_single(sp_spawner, &function_45ea368c, var_1372448b, #"hash_266f56fb994e6639");
    while (!isdefined(e_elephant.ai.riders) || e_elephant.ai.riders.size < 4) {
        wait 0.1;
    }
    foreach (player in level.players) {
        player clientfield::set_to_player("snd_crowd_react", 12);
    }
    animation::add_global_notetrack_handler("tower_contact_2", &function_2272ba33, 0);
    level scene::play("p8_fxanim_zm_towers_boss_arena_gate_destroy_bundle", "shot 1");
    e_elephant notify(#"hash_6537a2364ba9dcb3");
    level thread scene::play("p8_fxanim_zm_towers_boss_arena_gate_destroy_bundle", "shot 2");
    scene::play(#"aib_vign_cust_zm_twrs_ent_hllpht_01", array(e_elephant));
    e_elephant notify(#"entrace_done");
    level.var_e04e0ed7 = 2;
    level thread function_c5f12160();
    wait 2;
    if (!getdvar(#"hash_2b64162aa40fe2bb", 0)) {
        level flag::set("spawn_zombies");
        level flag::set(#"infinite_round_spawning");
    }
    e_elephant waittill(#"death");
    foreach (player in level.players) {
        player clientfield::set_to_player("snd_crowd_react", 13);
    }
    level flag::clear("spawn_zombies");
    level flag::clear(#"infinite_round_spawning");
    level notify(#"boss_battle_done");
    wait 1;
    level zm_utility::function_1a046290(1);
    function_e3462e37();
    level flag::set(#"hash_501ce29ccfa96f4a");
    level zm_towers::setup_end_igc();
    level scene::play(#"hash_18b88682c325ad3d");
    level notify(#"end_game");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x4ddd5848, Offset: 0x17830
// Size: 0x18c
function function_cfdc5f4b(a_ents) {
    zm_towers_crowd::function_5c8e025a(1);
    zm_towers_crowd::function_77f68f25(0);
    zm_towers_crowd::function_5ff4429f(0);
    array::thread_all(level.players, &zm_towers_crowd::function_d3d3dcf0, 0, 1);
    a_ai_zombies = getaiarray();
    foreach (ai in a_ai_zombies) {
        if (isalive(ai)) {
            util::stop_magic_bullet_shield(ai);
            ai.allowdeath = 1;
            ai kill();
        }
    }
    level flag::clear("spawn_zombies");
    level thread scene::play("special_round_drummers", "targetname");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xc29d1c94, Offset: 0x179c8
// Size: 0x9c
function function_26f748a9(a_ents) {
    level flag::set("spawn_zombies");
    zm_towers_crowd::function_77f68f25(1);
    zm_towers_crowd::function_5c8e025a(0);
    zm_towers_crowd::function_5ff4429f(0);
    level scene::stop("special_round_drummers", "targetname");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x6e009a18, Offset: 0x17a70
// Size: 0x50
function private function_f3ca49ac() {
    target_round = zm_round_logic::get_round_number() + 1;
    zm_round_logic::set_round_number(target_round - 1);
    level notify(#"kill_round");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x505b4982, Offset: 0x17ac8
// Size: 0x7c
function private function_55e952af() {
    zm_round_spawning::function_c9b9ab96("blight_father");
    zm_round_spawning::function_c9b9ab96("catalyst");
    zm_round_spawning::function_c9b9ab96("gladiator_destroyer");
    zm_round_spawning::function_c9b9ab96("gladiator_marauder");
    zm_round_spawning::function_c9b9ab96("tiger");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xf9473f70, Offset: 0x17b50
// Size: 0x10
function function_f7a159be(n_points) {
    return 1600;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xab4ec8a, Offset: 0x17b68
// Size: 0x86
function function_fd81cf2a(var_5694ff35) {
    var_5694ff35[#"blight_father"] = 1;
    var_5694ff35[#"catalyst"] = 6;
    var_5694ff35[#"gladiator_destroyer"] = 1;
    var_5694ff35[#"gladiator_marauder"] = 1;
    var_5694ff35[#"tiger"] = 3;
    return var_5694ff35;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x115e78bf, Offset: 0x17bf8
// Size: 0x684
function function_a6f11fca() {
    level endon(#"hash_12768f75609d32ca");
    level.var_2425c58 = randomintrangeinclusive(9, 20);
    var_787629cc = array();
    var_bf8a2d4b = array();
    var_787629cc[0] = getent("hell_gate_1_l", "targetname");
    var_787629cc[1] = getent("hell_gate_1_m", "targetname");
    var_787629cc[2] = getent("hell_gate_1_h", "targetname");
    var_bf8a2d4b[0] = getent("hell_gate_2_l", "targetname");
    var_bf8a2d4b[1] = getent("hell_gate_2_m", "targetname");
    var_bf8a2d4b[2] = getent("hell_gate_2_h", "targetname");
    switch (level.players.size) {
    case 1:
    default:
        n_wait_amount = 2.5;
        break;
    case 2:
        n_wait_amount = 1.66667;
        break;
    case 3:
        n_wait_amount = 1.25;
        break;
    case 4:
        n_wait_amount = 0.833333;
        break;
    }
    level thread function_b09ee5e0();
    wait 10;
    callback::on_ai_killed(&function_3e487f8d);
    level clientfield::set("crowd_react_boss", 1);
    foreach (player in level.players) {
        player clientfield::set_to_player("snd_crowd_react", 12);
    }
    level thread scene::play("boss_battle_tempo", "targetname");
    level thread function_2e24dda8();
    function_784a5133();
    a_s_spawners = struct::get_array("boss_battle_spawns");
    a_s_spawners = arraycombine(a_s_spawners, struct::get_array("boss_temp_gate_tele", "targetname"), 0, 0);
    while (true) {
        if (level.ai[#"axis"].size < 18) {
            if (level flag::get(#"hash_353dcb95f778ad73")) {
                n_toggle = randomintrangeinclusive(0, 2);
            } else {
                n_toggle = randomintrangeinclusive(0, 1);
            }
            switch (n_toggle) {
            case 0:
                var_7db52b72 = array::random(a_s_spawners);
                level thread zombie_gladiator_util::function_e8c77e88(1, "melee", &function_66b4a104, 1, var_7db52b72);
                break;
            case 1:
                var_7db52b72 = array::random(a_s_spawners);
                level thread zombie_gladiator_util::function_e8c77e88(1, "ranged", &function_66b4a104, 1, var_7db52b72);
                break;
            case 2:
                for (i = 0; i < 3; i++) {
                    var_7db52b72 = function_551ca162(a_s_spawners, "tiger_location");
                    var_6f0b660b = getspawnerarray("zombie_spawner_tiger", "targetname")[0];
                    ai = undefined;
                    while (!isdefined(ai)) {
                        ai = zombie_utility::spawn_zombie(var_6f0b660b, "boss_filler", var_7db52b72, level.round_number);
                        waitframe(1);
                    }
                    ai function_66b4a104(var_7db52b72);
                    wait 0.5;
                    s_teleport = array::random(struct::get_array("boss_temp_gate_tele", "targetname"));
                    ai forceteleport(s_teleport.origin);
                }
                break;
            default:
                break;
            }
        }
        wait n_wait_amount;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x89d6bea9, Offset: 0x18288
// Size: 0x1ce
function function_784a5133() {
    a_s_spawners = struct::get_array("boss_battle_spawns");
    for (i = 0; i < 18; i++) {
        if (level.ai[#"axis"].size < 24) {
            switch (math::cointoss(33)) {
            case 0:
                var_7db52b72 = function_551ca162(a_s_spawners, "gladiator_location");
                var_7db52b72 = array::random(struct::get_array("boss_temp_gate_tele", "targetname"));
                level thread zombie_gladiator_util::function_e8c77e88(1, "melee", &function_66b4a104, 1, var_7db52b72);
                break;
            case 1:
                var_7db52b72 = array::random(struct::get_array("boss_temp_gate_tele", "targetname"));
                level thread zombie_gladiator_util::function_e8c77e88(1, "ranged", &function_66b4a104, 1, var_7db52b72);
                break;
            default:
                break;
            }
        }
        wait 0.5;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x74a92203, Offset: 0x18460
// Size: 0xa2
function function_3e487f8d(s_params) {
    e_attacker = s_params.eattacker;
    v_origin = self.origin;
    if (!isplayer(e_attacker)) {
        return;
    }
    level.var_2425c58--;
    if (level.var_2425c58 == 0) {
        zm_powerups::specific_powerup_drop("full_ammo", v_origin, undefined, undefined, undefined, 1);
        level.var_2425c58 = 20;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0x10080a2f, Offset: 0x18510
// Size: 0xc
function function_66b4a104(s_spawnloc) {
    
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x35018328, Offset: 0x18528
// Size: 0xae
function function_551ca162(a_s_spawners, str_noteworthy) {
    a_s_spawners = array::randomize(a_s_spawners);
    foreach (s_spawner in a_s_spawners) {
        if (s_spawner.script_noteworthy === str_noteworthy) {
            return s_spawner;
        }
    }
    return a_s_spawners[0];
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x62f458d9, Offset: 0x185e0
// Size: 0x100
function function_b09ee5e0() {
    level endon(#"hash_12768f75609d32ca", #"end_game");
    exploder::exploder("fxexp_boss_arena_gas_gate_1");
    exploder::exploder("fxexp_boss_arena_gas_gate_2");
    scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 1");
    wait 50;
    scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 2");
    level flag::set(#"hash_353dcb95f778ad73");
    wait 50;
    scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 3");
    level notify(#"hash_12768f75609d32ca");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xbe3eda9d, Offset: 0x186e8
// Size: 0x1e
function function_b2be4034() {
    return level.ai[#"axis"].size;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x56d46fc8, Offset: 0x18710
// Size: 0x8a
function function_45ea368c(s_spawn, phase) {
    self endon(#"death");
    self.ai.phase = phase;
    self forceteleport(s_spawn.origin, s_spawn.angles);
    level.e_elephant = self;
    self.instakill_func = &zm_powerups::function_ef67590f;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x7cdfab4f, Offset: 0x187a8
// Size: 0x200
function private function_905ad30f() {
    level endon(#"end_game");
    t_spawn = getent("tiger_obelisk_trig", "targetname");
    a_s_entrances = struct::get_array("tiger_boss_obelisk_scene", "targetname");
    while (true) {
        waitresult = t_spawn waittill(#"trigger");
        if (!a_s_entrances.size) {
            a_s_entrances = struct::get_array("tiger_boss_obelisk_scene", "targetname");
        }
        array::randomize(a_s_entrances);
        if (isdefined(waitresult.activator) && isdefined(waitresult.activator.archetype) && waitresult.activator.archetype === "tiger" && !(isdefined(waitresult.activator.b_entered) && waitresult.activator.b_entered)) {
            waitresult.activator.b_entered = 1;
            s_scene = array::pop(a_s_entrances);
            e_gate = getent(s_scene.target, "targetname");
            e_gate thread function_81bd3ed6();
            s_scene thread scene::play(waitresult.activator);
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xff2ab7ee, Offset: 0x189b0
// Size: 0xc4
function function_81bd3ed6() {
    v_amount = vectorscale(self.script_vector, 1);
    self moveto(self.origin + v_amount, 0.5);
    self playsound(#"hash_75a2099e8df5a448");
    wait 2.5;
    v_amount = vectorscale(self.script_vector, -1);
    self moveto(self.origin + v_amount, 0.5);
    self playsound(#"hash_40e8e3be1a559184");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x8e169deb, Offset: 0x18a80
// Size: 0x184
function private function_7d33221e() {
    var_210d17c2 = getentarray("towers_boss_tower_trigger", "targetname");
    var_3b40b228 = 0;
    var_c5592d36 = 40;
    foreach (var_f24a5933 in var_210d17c2) {
        var_f24a5933 thread function_1cf2bcb4();
        /#
            recordent(var_f24a5933);
        #/
        var_836b5f83 = "towers_boss_tower_badplace_" + var_3b40b228;
        var_f24a5933.badplace_name = var_836b5f83;
        badplace_box(var_836b5f83, 0, groundtrace(var_f24a5933.origin + (0, 0, 8), var_f24a5933.origin + (0, 0, -100000), 0, var_f24a5933)[#"position"], var_c5592d36, "all");
        var_3b40b228++;
        waitframe(1);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x4
// Checksum 0x6a509ca8, Offset: 0x18c10
// Size: 0x184
function private function_1cf2bcb4() {
    self.b_exploded = 0;
    e_clip = getent(self.target, "targetname");
    while (!self.b_exploded) {
        waitresult = self waittill(#"trigger", #"tower_boss_scripted_trigger_tower");
        shouldexplode = isdefined(waitresult.activator) && isdefined(waitresult.activator.archetype) && waitresult.activator.archetype === "elephant";
        if (shouldexplode || waitresult._notify == "tower_boss_scripted_trigger_tower") {
            e_clip delete();
            fx_tower = struct::get(self.target, "targetname");
            fx_tower scene::play();
            self.b_exploded = 1;
            if (isdefined(self.badplace_name)) {
                badplace_delete(self.badplace_name);
            }
            break;
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xe7ba73d, Offset: 0x18da0
// Size: 0xaa
function function_916aa01() {
    level endon(#"end_game", #"boss_battle_done");
    for (b_success = 0; !b_success; b_success = self zm_audio::create_and_play_dialog(#"m_quest", #"spear_warn")) {
        waitresult = self waittill(#"aoe_damage");
        if (waitresult.str_source == "zm_aoe_spear") {
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x444f26a2, Offset: 0x18e58
// Size: 0x44
function function_2e24dda8() {
    zm_audio::sndannouncerplayvox(#"hash_43b0860b33146764");
    zm_audio::function_709246c9("m_quest", "fury_start");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x34f75811, Offset: 0x18ea8
// Size: 0x1e4
function function_b9974d6a() {
    level zm_audio::sndannouncerplayvox(#"hash_c8182d04e7f43c9");
    level zm_audio::function_709246c9("m_quest", "fury_arrive");
    var_a03aa924 = [];
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_1_m_quest_fury_arrive_resp_0";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_3_m_quest_fury_arrive_resp_1";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_2_m_quest_fury_arrive_resp_2";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_4_m_quest_fury_arrive_resp_3";
    zm_vo::function_2426269b();
    zm_vo::function_7aa5324a(var_a03aa924);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x5e275c10, Offset: 0x19098
// Size: 0x1b4
function function_7de8f93() {
    level waittill(#"hash_634700dd42db02d8");
    var_a03aa924 = [];
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_1_m_quest_fury_change_resp_0";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_3_m_quest_fury_change_resp_1";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_2_m_quest_fury_change_resp_2";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_4_m_quest_fury_change_resp_3";
    zm_vo::function_2426269b();
    zm_vo::function_7aa5324a(var_a03aa924);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x655517f4, Offset: 0x19258
// Size: 0x3ec
function function_802e7219() {
    level zm_audio::sndannouncerplayvox(#"hash_77080de04389f4df");
    level zm_audio::function_709246c9("m_quest", "fury_kill");
    var_a03aa924 = [];
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_4_m_quest_stage_2_transition_0";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_2_m_quest_stage_2_transition_1";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_1_m_quest_stage_2_transition_2";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_3_m_quest_stage_2_transition_3";
    zm_vo::function_2426269b();
    zm_vo::function_7aa5324a(var_a03aa924);
    level zm_audio::sndannouncerplayvox(#"hash_1b8dd2e5977116cb");
    level waittill(#"hash_5d826e11ebe4b6e7");
    level zm_audio::sndannouncerplayvox(#"hash_436d318af3fd771f");
    level zm_audio::function_709246c9("m_quest", "wrath_arrive");
    var_4171ea53 = [];
    if (!isdefined(var_4171ea53)) {
        var_4171ea53 = [];
    } else if (!isarray(var_4171ea53)) {
        var_4171ea53 = array(var_4171ea53);
    }
    var_4171ea53[var_4171ea53.size] = "vox_plr_2_m_quest_wrath_arrive_resp_0";
    if (!isdefined(var_4171ea53)) {
        var_4171ea53 = [];
    } else if (!isarray(var_4171ea53)) {
        var_4171ea53 = array(var_4171ea53);
    }
    var_4171ea53[var_4171ea53.size] = "vox_plr_3_m_quest_wrath_arrive_resp_1";
    if (!isdefined(var_4171ea53)) {
        var_4171ea53 = [];
    } else if (!isarray(var_4171ea53)) {
        var_4171ea53 = array(var_4171ea53);
    }
    var_4171ea53[var_4171ea53.size] = "vox_plr_4_m_quest_wrath_arrive_resp_2";
    if (!isdefined(var_4171ea53)) {
        var_4171ea53 = [];
    } else if (!isarray(var_4171ea53)) {
        var_4171ea53 = array(var_4171ea53);
    }
    var_4171ea53[var_4171ea53.size] = "vox_plr_1_m_quest_wrath_arrive_resp_3";
    zm_vo::function_7aa5324a(var_4171ea53);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xdb0894d6, Offset: 0x19650
// Size: 0x1b4
function function_c5f12160() {
    level waittill(#"hash_634700dd42db02d8");
    var_a03aa924 = [];
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_2_m_quest_wrath_change_resp_0";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_1_m_quest_wrath_change_resp_1";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_3_m_quest_wrath_change_resp_2";
    if (!isdefined(var_a03aa924)) {
        var_a03aa924 = [];
    } else if (!isarray(var_a03aa924)) {
        var_a03aa924 = array(var_a03aa924);
    }
    var_a03aa924[var_a03aa924.size] = "vox_plr_4_m_quest_wrath_change_resp_3";
    zm_vo::function_2426269b();
    zm_vo::function_7aa5324a(var_a03aa924);
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xce67d2f1, Offset: 0x19810
// Size: 0x44
function function_e3462e37() {
    level zm_audio::sndannouncerplayvox(#"hash_7e9eb52954a81d6e");
    level zm_audio::sndannouncerplayvox(#"hash_7e9eb42954a81bbb");
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 4, eflags: 0x0
// Checksum 0xb7fdb1cf, Offset: 0x19860
// Size: 0x90
function function_e2813db8(var_d15b1ac6, var_3b49c7ea, n_stage, var_41750e29) {
    level endon(#"end_game", #"boss_battle_done");
    while (true) {
        wait var_d15b1ac6;
        if (isdefined(var_3b49c7ea) && var_3b49c7ea) {
            continue;
        }
        zm_audio::function_709246c9("m_quest", var_41750e29);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 3, eflags: 0x0
// Checksum 0xdf5e29, Offset: 0x198f8
// Size: 0x82
function function_5007476d(str_notify, var_42ea1049, var_68ec8ab2) {
    level endon(#"end_game", #"boss_battle_done");
    for (b_success = 0; !b_success; b_success = zm_audio::function_709246c9(var_42ea1049, var_68ec8ab2)) {
        level waittill(str_notify);
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xf523df87, Offset: 0x19988
// Size: 0x72
function function_41e0034a() {
    level endon(#"end_game", #"boss_battle_done");
    while (true) {
        level waittill(#"hash_3aa3137f1bf70773");
        level.var_41f6af22 = 1;
        wait 30;
        level.var_41f6af22 = 0;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xbfee83cb, Offset: 0x19a08
// Size: 0x72
function function_aa8faae8() {
    level endon(#"end_game", #"boss_battle_done");
    while (true) {
        level waittill(#"basket_hit");
        level.var_5ed2dc7e = 1;
        wait 30;
        level.var_5ed2dc7e = 0;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0xc8a39c3d, Offset: 0x19a88
// Size: 0x634
function function_61f250e5() {
    a_t_doors = getentarray("zombie_door", "targetname");
    var_5c8c2f2c = getentarray("mdl_turn_back", "targetname");
    a_e_doors = arraycombine(a_t_doors, var_5c8c2f2c, 0, 0);
    foreach (e_door in a_e_doors) {
        e_door.var_5aa348e7 = [];
        e_door.var_6b6d313b = [];
        a_e_symbols = [];
        a_e_parts = getentarray(e_door.target, "targetname");
        foreach (e_part in a_e_parts) {
            if (e_part.objectid === "symbol_front" || e_part.objectid === "symbol_front_power" || e_part.objectid === "symbol_back" || e_part.objectid === "symbol_back_power") {
                if (!isdefined(a_e_symbols)) {
                    a_e_symbols = [];
                } else if (!isarray(a_e_symbols)) {
                    a_e_symbols = array(a_e_symbols);
                }
                if (!isinarray(a_e_symbols, e_part)) {
                    a_e_symbols[a_e_symbols.size] = e_part;
                }
            }
        }
        a_s_symbols = struct::get_array(e_door.target);
        a_e_symbols = arraycombine(a_e_symbols, a_s_symbols, 0, 0);
        a_e_symbols = arraysortclosest(a_e_symbols, e_door.origin, 2);
        foreach (e_symbol in a_e_symbols) {
            switch (e_symbol.objectid) {
            case #"symbol_front_power":
            case #"symbol_front":
                var_90394d1c = array(e_symbol.origin, e_symbol.angles);
                if (!isdefined(e_door.var_5aa348e7)) {
                    e_door.var_5aa348e7 = [];
                } else if (!isarray(e_door.var_5aa348e7)) {
                    e_door.var_5aa348e7 = array(e_door.var_5aa348e7);
                }
                e_door.var_5aa348e7[e_door.var_5aa348e7.size] = var_90394d1c;
                break;
            case #"symbol_back":
            case #"symbol_back_power":
                var_90394d1c = array(e_symbol.origin, e_symbol.angles);
                if (!isdefined(e_door.var_6b6d313b)) {
                    e_door.var_6b6d313b = [];
                } else if (!isarray(e_door.var_6b6d313b)) {
                    e_door.var_6b6d313b = array(e_door.var_6b6d313b);
                }
                e_door.var_6b6d313b[e_door.var_6b6d313b.size] = var_90394d1c;
                break;
            }
        }
        var_c419d6dc = e_door.var_2c3efa12;
        if (isdefined(var_c419d6dc)) {
            var_4f500d24 = getent(var_c419d6dc, "targetname");
            var_4f500d24.origin -= (0, 0, 2048);
            e_door.var_c4f74b57 = var_4f500d24;
            continue;
        }
        e_door.var_db05d3c0 = 1;
        e_door.origin -= (0, 0, 2048);
        foreach (s_symbol in a_s_symbols) {
            s_symbol struct::delete();
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xca43c94e, Offset: 0x1a0c8
// Size: 0x9c2
function function_c8851a77(a_str_script_flags) {
    if (!isdefined(a_str_script_flags)) {
        a_str_script_flags = [];
    } else if (!isarray(a_str_script_flags)) {
        a_str_script_flags = array(a_str_script_flags);
    }
    foreach (str_script_flag in a_str_script_flags) {
        a_t_doors = getentarray(str_script_flag, "script_flag");
        foreach (t_door in a_t_doors) {
            if (isdefined(t_door.var_9171375c) && t_door.var_9171375c) {
                continue;
            }
            t_door.var_9171375c = 1;
            if (isdefined(t_door.var_db05d3c0) && t_door.var_db05d3c0) {
                mdl_clip = t_door;
                mdl_clip.origin += (0, 0, 2048);
                mdl_clip.var_7296c028 = [];
                var_fe774b7 = mdl_clip.var_5aa348e7;
                var_1eb24d2b = mdl_clip.var_6b6d313b;
                foreach (var_63bf4738 in var_fe774b7) {
                    v_origin = var_63bf4738[0];
                    v_angles = var_63bf4738[1];
                    mdl_symbol = util::spawn_model("p8_zm_power_door_symbol_01", v_origin, v_angles);
                    mdl_symbol clientfield::set("power_door_ambient_fx", 1);
                    if (!isdefined(mdl_clip.var_7296c028)) {
                        mdl_clip.var_7296c028 = [];
                    } else if (!isarray(mdl_clip.var_7296c028)) {
                        mdl_clip.var_7296c028 = array(mdl_clip.var_7296c028);
                    }
                    mdl_clip.var_7296c028[mdl_clip.var_7296c028.size] = mdl_symbol;
                }
                foreach (var_63bf4738 in var_1eb24d2b) {
                    v_origin = var_63bf4738[0];
                    v_angles = var_63bf4738[1];
                    mdl_symbol = util::spawn_model("p8_zm_power_door_symbol_01", v_origin, v_angles);
                    mdl_symbol clientfield::set("power_door_ambient_fx", 1);
                    if (!isdefined(mdl_clip.var_7296c028)) {
                        mdl_clip.var_7296c028 = [];
                    } else if (!isarray(mdl_clip.var_7296c028)) {
                        mdl_clip.var_7296c028 = array(mdl_clip.var_7296c028);
                    }
                    mdl_clip.var_7296c028[mdl_clip.var_7296c028.size] = mdl_symbol;
                }
                continue;
            }
            if (!(isdefined(t_door.has_been_opened) && t_door.has_been_opened)) {
                t_door.origin -= (0, 0, 2048);
                a_mdl_parts = getentarray(t_door.target, "targetname");
                var_f8b1d4c1 = [];
                foreach (mdl_part in a_mdl_parts) {
                    switch (mdl_part.objectid) {
                    case #"symbol_back":
                    case #"symbol_front":
                        if (!(isdefined(mdl_part.var_cd83c586) && mdl_part.var_cd83c586)) {
                            var_2e6e7057 = util::spawn_model("p8_zm_power_door_symbol_01", mdl_part.origin, mdl_part.angles);
                            var_2e6e7057 clientfield::set("power_door_ambient_fx", 1);
                            mdl_part clientfield::set("doorbuy_ambient_fx", 0);
                            mdl_part.origin -= (0, 0, 2048);
                            if (!isdefined(var_f8b1d4c1)) {
                                var_f8b1d4c1 = [];
                            } else if (!isarray(var_f8b1d4c1)) {
                                var_f8b1d4c1 = array(var_f8b1d4c1);
                            }
                            var_f8b1d4c1[var_f8b1d4c1.size] = var_2e6e7057;
                            mdl_part.var_cd83c586 = 1;
                        }
                        break;
                    }
                }
                t_door.var_7296c028 = var_f8b1d4c1;
                continue;
            }
            t_door.var_c4f74b57.origin += (0, 0, 2048);
            t_door.var_7296c028 = [];
            var_fe774b7 = t_door.var_5aa348e7;
            var_1eb24d2b = t_door.var_6b6d313b;
            foreach (var_63bf4738 in var_fe774b7) {
                v_origin = var_63bf4738[0];
                v_angles = var_63bf4738[1];
                mdl_symbol = util::spawn_model("p8_zm_power_door_symbol_01", v_origin, v_angles);
                mdl_symbol clientfield::set("power_door_ambient_fx", 1);
                if (!isdefined(t_door.var_7296c028)) {
                    t_door.var_7296c028 = [];
                } else if (!isarray(t_door.var_7296c028)) {
                    t_door.var_7296c028 = array(t_door.var_7296c028);
                }
                t_door.var_7296c028[t_door.var_7296c028.size] = mdl_symbol;
            }
            foreach (var_63bf4738 in var_1eb24d2b) {
                v_origin = var_63bf4738[0];
                v_angles = var_63bf4738[1];
                mdl_symbol = util::spawn_model("p8_zm_power_door_symbol_01", v_origin, v_angles);
                mdl_symbol clientfield::set("power_door_ambient_fx", 1);
                if (!isdefined(t_door.var_7296c028)) {
                    t_door.var_7296c028 = [];
                } else if (!isarray(t_door.var_7296c028)) {
                    t_door.var_7296c028 = array(t_door.var_7296c028);
                }
                t_door.var_7296c028[t_door.var_7296c028.size] = mdl_symbol;
            }
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 1, eflags: 0x0
// Checksum 0xba694ceb, Offset: 0x1aa98
// Size: 0x578
function function_3fc94d2a(a_str_script_flags) {
    if (!isdefined(a_str_script_flags)) {
        a_str_script_flags = [];
    } else if (!isarray(a_str_script_flags)) {
        a_str_script_flags = array(a_str_script_flags);
    }
    foreach (str_script_flag in a_str_script_flags) {
        a_t_doors = getentarray(str_script_flag, "script_flag");
        foreach (t_door in a_t_doors) {
            if (!(isdefined(t_door.var_9171375c) && t_door.var_9171375c)) {
                continue;
            }
            t_door.var_9171375c = 0;
            if (isdefined(t_door.var_db05d3c0) && t_door.var_db05d3c0) {
                mdl_clip = t_door;
                mdl_clip.origin -= (0, 0, 2048);
                var_f8b1d4c1 = mdl_clip.var_7296c028;
                foreach (var_d55a5d8e in var_f8b1d4c1) {
                    var_d55a5d8e clientfield::set("power_door_ambient_fx", 0);
                    var_d55a5d8e delete();
                }
                continue;
            }
            if (!(isdefined(t_door.has_been_opened) && t_door.has_been_opened)) {
                t_door.origin += (0, 0, 2048);
                var_f8b1d4c1 = t_door.var_7296c028;
                foreach (var_d55a5d8e in var_f8b1d4c1) {
                    var_d55a5d8e clientfield::set("power_door_ambient_fx", 0);
                    var_d55a5d8e delete();
                }
                a_mdl_parts = getentarray(t_door.target, "targetname");
                foreach (mdl_part in a_mdl_parts) {
                    switch (mdl_part.objectid) {
                    case #"symbol_back":
                    case #"symbol_front":
                        if (isdefined(mdl_part.var_cd83c586) && mdl_part.var_cd83c586) {
                            mdl_part.origin += (0, 0, 2048);
                            waitframe(1);
                            mdl_part clientfield::set("doorbuy_ambient_fx", 1);
                            mdl_part.var_cd83c586 = 0;
                        }
                        break;
                    }
                }
                continue;
            }
            t_door.var_c4f74b57.origin -= (0, 0, 2048);
            foreach (mdl_symbol in t_door.var_7296c028) {
                mdl_symbol clientfield::set("power_door_ambient_fx", 0);
                mdl_symbol delete();
            }
        }
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0x7ee2cd5c, Offset: 0x1b018
// Size: 0x210
function function_7e378484(var_4df7e1c1, var_dd503b20 = array()) {
    level endon(#"end_game");
    self endon(#"death");
    if (!level flag::get(#"hash_4f293396150d2c00")) {
        return;
    }
    while (true) {
        b_enable = 1;
        foreach (str_zone in var_4df7e1c1) {
            if (self zm_zonemgr::entity_in_zone(str_zone, 0)) {
                foreach (v_exclusion in var_dd503b20) {
                    e_vol = getent(v_exclusion, "targetname");
                    if (self istouching(e_vol)) {
                        b_enable = 0;
                    }
                }
                continue;
            }
            b_enable = 0;
        }
        if (b_enable) {
            self ai::set_behavior_attribute("tongue_grab_enabled", 1);
        } else {
            self ai::set_behavior_attribute("tongue_grab_enabled", 0);
        }
        wait 0.5;
    }
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 2, eflags: 0x0
// Checksum 0xac13cfcd, Offset: 0x1b230
// Size: 0xd6
function function_b7e5de3b(var_859d7279 = 1, var_64bbcfa = 1) {
    if (var_859d7279) {
        level.zombie_powerups[#"nuke"].func_should_drop_with_regular_powerups = &function_272bc80b;
    }
    if (var_64bbcfa) {
        level.zombie_powerups[#"carpenter"].func_should_drop_with_regular_powerups = &function_272bc80b;
    }
    level.zombie_powerups[#"fire_sale"].func_should_drop_with_regular_powerups = &function_272bc80b;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x2b178e88, Offset: 0x1b310
// Size: 0x56
function function_272bc80b() {
    if (level flag::exists(#"hash_4f293396150d2c00") && level flag::get(#"hash_4f293396150d2c00")) {
        return 0;
    }
    return 1;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x70ec2ed, Offset: 0x1b370
// Size: 0x96
function function_52825b06() {
    level.zombie_powerups[#"nuke"].func_should_drop_with_regular_powerups = &zm_powerups::func_should_always_drop;
    level.zombie_powerups[#"fire_sale"].func_should_drop_with_regular_powerups = &zm_powerups::func_should_always_drop;
    level.zombie_powerups[#"carpenter"].func_should_drop_with_regular_powerups = &zm_powerups::func_should_always_drop;
}

// Namespace zm_towers_main_quest/zm_towers_main_quest
// Params 0, eflags: 0x0
// Checksum 0x63e97891, Offset: 0x1b410
// Size: 0x108
function function_d2a9e0d7() {
    level endon(#"end_game");
    while (true) {
        level waittill(#"end_of_round");
        var_2fd02d41 = 0;
        var_cf2fc775 = zm_round_spawning::function_e7543004(1);
        if (isdefined(var_cf2fc775)) {
            var_b54144f2 = var_cf2fc775.n_round;
            if (isdefined(var_b54144f2) && level.round_number == var_b54144f2) {
                var_2fd02d41 = 1;
            }
        }
        if (var_2fd02d41) {
            level flag::set(#"hash_4fd3d0c01f9b4c30");
            continue;
        }
        level flag::clear(#"hash_4fd3d0c01f9b4c30");
    }
}

