#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\ai\zm_ai_blight_father;
#using scripts\zm\ai\zm_ai_catalyst;
#using scripts\zm\ai\zm_ai_stoker;
#using scripts\zm\zm_zodt8;
#using scripts\zm\zm_zodt8_sentinel_trial;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;

#namespace zodt8_eye;

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x2
// Checksum 0x6ed3c67e, Offset: 0x1018
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zodt8_boss", &__init__, undefined, undefined);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xb025efe2, Offset: 0x1060
// Size: 0xdc
function __init__() {
    init_clientfields();
    init_flags();
    init_steps();
    function_903df62d();
    function_8d058cad();
    init_boss();
    level thread function_d405d856();
    function_20865108();
    init_vo();
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            level thread function_91912a79();
        }
    #/
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x33fa09c6, Offset: 0x1148
// Size: 0x424
function init_clientfields() {
    clientfield::register("world", "engine_room_chillout_decals", 1, 1, "int");
    clientfield::register("world", "state_rooms_chillout_decals", 1, 1, "int");
    clientfield::register("world", "promenade_chillout_decals", 1, 1, "int");
    clientfield::register("world", "poop_deck_chillout_decals", 1, 1, "int");
    clientfield::register("scriptmover", "bs_bdy_fx_cf", 1, 2, "int");
    clientfield::register("scriptmover", "bs_bdy_dmg_fx_cf", 1, 3, "int");
    clientfield::register("scriptmover", "bs_dth_fx_cf", 1, 1, "counter");
    clientfield::register("scriptmover", "bs_spn_fx_cf", 1, 1, "int");
    clientfield::register("scriptmover", "bs_att_mst_tell_cf", 1, 1, "int");
    clientfield::register("scriptmover", "bs_att_mst_cf", 1, 1, "int");
    clientfield::register("scriptmover", "bs_att_bm_targ_ini_cf", 1, 1, "int");
    clientfield::register("scriptmover", "bs_att_bm_tell_cf", 1, 2, "int");
    clientfield::register("scriptmover", "bs_att_bm_tell_fx_cf", 1, 1, "int");
    clientfield::register("scriptmover", "bs_att_bm_cf", 1, 1, "int");
    clientfield::register("allplayers", "bs_att_bm_targ_hit_cf", 1, 1, "int");
    clientfield::register("toplayer", "bs_att_bm_targ_frz_fx_cf", 1, 1, "int");
    clientfield::register("scriptmover", "bs_att_blst_tll", 1, 1, "int");
    clientfield::register("scriptmover", "bs_att_blst", 1, 1, "int");
    clientfield::register("world", "in_engine_room", 1, 1, "int");
    clientfield::register("world", "bs_gr_fog_fx_cf", 1, 1, "int");
    clientfield::register("allplayers", "bs_player_ice_br_cf", 1, 1, "int");
    clientfield::register("allplayers", "bs_player_snow_cf", 1, 3, "int");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x54179c56, Offset: 0x1578
// Size: 0xc4
function init_flags() {
    level flag::init(#"boss_fight_started");
    level flag::init(#"hash_62b951a213a3945e");
    level flag::init(#"hash_bd3b222f6d8329d");
    level flag::init(#"hash_fa1fa6cc9b17c7c");
    level flag::init(#"hash_50113a36d2c6bb73");
    level flag::init(#"hash_25d8c88ff3f91ee5");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xa1425e28, Offset: 0x1648
// Size: 0x1e4
function init_steps() {
    zm_sq::register(#"boss_fight", #"step_1", #"hash_29b25d86ddeb7d44", &function_3134e59f, &function_29c1444c);
    zm_sq::register(#"boss_fight", #"step_2", #"hash_29b26086ddeb825d", &function_305ae690, &function_691a46fb);
    zm_sq::register(#"boss_fight", #"step_3", #"hash_29b25f86ddeb80aa", &function_acef5d29, &function_352ded42);
    zm_sq::register(#"boss_fight", #"step_4", #"hash_29b25a86ddeb782b", &function_76d33ac2, &function_30167689);
    zm_sq::register(#"boss_fight", #"step_5", #"hash_29b25986ddeb7678", &function_b7ad411b, &function_98e6d1d0);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x5ee0f730, Offset: 0x1838
// Size: 0xb8
function function_903df62d() {
    a_blockers = getentarray("bs_scr_bkr", "targetname");
    foreach (e_blocker in a_blockers) {
        e_blocker hide();
        e_blocker notsolid();
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x9a08e0a9, Offset: 0x18f8
// Size: 0xb8
function function_8d058cad() {
    a_blockers = getentarray("bs_att_bm_ai_blck", "targetname");
    foreach (e_blocker in a_blockers) {
        e_blocker hide();
        e_blocker notsolid();
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x6e454203, Offset: 0x19b8
// Size: 0x26c
function init_boss() {
    e_boss = getent("bs_bdy_mdl", "targetname");
    e_boss enablelinkto();
    e_boss notsolid();
    e_boss.e_damage = getent("bs_bdy_dmg", "targetname");
    e_boss.e_damage.takedamage = 1;
    e_boss.e_damage function_908a655e();
    e_boss.e_damage.var_29ed62b2 = #"boss";
    e_boss.e_damage enablelinkto();
    e_boss.e_damage linkto(e_boss);
    e_boss.e_damage notsolid();
    e_boss.var_3b84dee6 = getent("bs_att_fx_pt", "targetname");
    e_boss.var_3b84dee6 enablelinkto();
    e_boss.var_3b84dee6 linkto(e_boss);
    level.e_boss = e_boss;
    zm_utility::function_c8316536(#"hash_2cc0dfb628810e41", 0.5, 0.1);
    zm_utility::function_c8316536(#"hash_7d336706f2aeadab", 0, 60);
    zm_utility::function_c8316536(#"hash_532f7f688c86c9b1", 0, 2);
    zm_utility::function_c8316536(#"hash_2a290908eb355917", 0, 2);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x3b8f914b, Offset: 0x1c30
// Size: 0x8c
function function_d405d856() {
    wait 5;
    level flag::wait_till("start_zombie_round_logic");
    function_a23e0292("eng", 0);
    function_a23e0292("st", 0);
    function_a23e0292("pro", 0);
    function_a23e0292("pd", 0);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xb3c10fc, Offset: 0x1cc8
// Size: 0x23c
function function_20865108() {
    sp_blight_father = getent("zombie_spawner_blight_father", "targetname");
    zm_transform::function_17652056(sp_blight_father, #"hash_9ecf8085fb7a68f", &zm_ai_blight_father::function_652d2382, 5, undefined, undefined, "aib_vign_zm_zod_bltfthr_spawn_pre_split", "aib_vign_zm_zod_bltfthr_spawn_post_split");
    sp_catalyst = getent("zombie_spawn_1", "script_string");
    zm_transform::function_17652056(sp_catalyst, #"hash_7c89b1397a38e3ad", &zm_ai_utility::function_4f5236d3, 0, undefined, &function_fa3a18b0, "aib_vign_zm_zod_catalyst_corrosive_spawn_pre_split", "aib_vign_zm_zod_catalyst_corrosive_spawn_post_split");
    sp_catalyst = getent("zombie_spawn_2", "script_string");
    zm_transform::function_17652056(sp_catalyst, #"hash_7c89ae397a38de94", &zm_ai_utility::function_4f5236d3, 0, undefined, &function_fa3a18b0, "aib_vign_zm_zod_catalyst_water_spawn_pre_split", "aib_vign_zm_zod_catalyst_water_spawn_post_split");
    sp_catalyst = getent("zombie_spawn_3", "script_string");
    zm_transform::function_17652056(sp_catalyst, #"hash_7c89af397a38e047", &zm_ai_utility::function_4f5236d3, 0, undefined, &function_fa3a18b0, "aib_vign_zm_zod_catalyst_electric_spawn_pre_split", "aib_vign_zm_zod_catalyst_electric_spawn_post_split");
    sp_catalyst = getent("zombie_spawn_4", "script_string");
    zm_transform::function_17652056(sp_catalyst, #"hash_7c89ac397a38db2e", &zm_ai_utility::function_4f5236d3, 0, undefined, &function_fa3a18b0, "aib_vign_zm_zod_catalyst_plasma_spawn_pre_split", "aib_vign_zm_zod_catalyst_plasma_spawn_post_split");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x81eb2c6e, Offset: 0x1f10
// Size: 0x15b4
function init_vo() {
    level.var_b223ff19 = [];
    level.var_b223ff19[1] = [];
    if (!isdefined(level.var_b223ff19[1])) {
        level.var_b223ff19[1] = [];
    } else if (!isarray(level.var_b223ff19[1])) {
        level.var_b223ff19[1] = array(level.var_b223ff19[1]);
    }
    level.var_b223ff19[1][level.var_b223ff19[1].size] = "vox_plr_1_m_quest_boss_stage1_start_0";
    if (!isdefined(level.var_b223ff19[1])) {
        level.var_b223ff19[1] = [];
    } else if (!isarray(level.var_b223ff19[1])) {
        level.var_b223ff19[1] = array(level.var_b223ff19[1]);
    }
    level.var_b223ff19[1][level.var_b223ff19[1].size] = "vox_plr_4_m_quest_boss_stage1_start_1";
    if (!isdefined(level.var_b223ff19[1])) {
        level.var_b223ff19[1] = [];
    } else if (!isarray(level.var_b223ff19[1])) {
        level.var_b223ff19[1] = array(level.var_b223ff19[1]);
    }
    level.var_b223ff19[1][level.var_b223ff19[1].size] = "vox_plr_2_m_quest_boss_stage1_start_2";
    if (!isdefined(level.var_b223ff19[1])) {
        level.var_b223ff19[1] = [];
    } else if (!isarray(level.var_b223ff19[1])) {
        level.var_b223ff19[1] = array(level.var_b223ff19[1]);
    }
    level.var_b223ff19[1][level.var_b223ff19[1].size] = "vox_plr_3_m_quest_boss_stage1_start_3";
    level.var_b223ff19[2] = [];
    if (!isdefined(level.var_b223ff19[2])) {
        level.var_b223ff19[2] = [];
    } else if (!isarray(level.var_b223ff19[2])) {
        level.var_b223ff19[2] = array(level.var_b223ff19[2]);
    }
    level.var_b223ff19[2][level.var_b223ff19[2].size] = "vox_plr_1_m_quest_boss_stage2_start_0";
    if (!isdefined(level.var_b223ff19[2])) {
        level.var_b223ff19[2] = [];
    } else if (!isarray(level.var_b223ff19[2])) {
        level.var_b223ff19[2] = array(level.var_b223ff19[2]);
    }
    level.var_b223ff19[2][level.var_b223ff19[2].size] = "vox_plr_4_m_quest_boss_stage2_start_1";
    if (!isdefined(level.var_b223ff19[2])) {
        level.var_b223ff19[2] = [];
    } else if (!isarray(level.var_b223ff19[2])) {
        level.var_b223ff19[2] = array(level.var_b223ff19[2]);
    }
    level.var_b223ff19[2][level.var_b223ff19[2].size] = "vox_plr_3_m_quest_boss_stage2_start_2";
    if (!isdefined(level.var_b223ff19[2])) {
        level.var_b223ff19[2] = [];
    } else if (!isarray(level.var_b223ff19[2])) {
        level.var_b223ff19[2] = array(level.var_b223ff19[2]);
    }
    level.var_b223ff19[2][level.var_b223ff19[2].size] = "vox_plr_2_m_quest_boss_stage2_start_3";
    level.var_b223ff19[3] = [];
    if (!isdefined(level.var_b223ff19[3])) {
        level.var_b223ff19[3] = [];
    } else if (!isarray(level.var_b223ff19[3])) {
        level.var_b223ff19[3] = array(level.var_b223ff19[3]);
    }
    level.var_b223ff19[3][level.var_b223ff19[3].size] = "vox_plr_2_m_quest_boss_stage3_start_0";
    if (!isdefined(level.var_b223ff19[3])) {
        level.var_b223ff19[3] = [];
    } else if (!isarray(level.var_b223ff19[3])) {
        level.var_b223ff19[3] = array(level.var_b223ff19[3]);
    }
    level.var_b223ff19[3][level.var_b223ff19[3].size] = "vox_plr_4_m_quest_boss_stage3_start_1";
    if (!isdefined(level.var_b223ff19[3])) {
        level.var_b223ff19[3] = [];
    } else if (!isarray(level.var_b223ff19[3])) {
        level.var_b223ff19[3] = array(level.var_b223ff19[3]);
    }
    level.var_b223ff19[3][level.var_b223ff19[3].size] = "vox_plr_1_m_quest_boss_stage3_start_2";
    if (!isdefined(level.var_b223ff19[3])) {
        level.var_b223ff19[3] = [];
    } else if (!isarray(level.var_b223ff19[3])) {
        level.var_b223ff19[3] = array(level.var_b223ff19[3]);
    }
    level.var_b223ff19[3][level.var_b223ff19[3].size] = "vox_plr_3_m_quest_boss_stage3_start_3";
    level.var_b223ff19[4] = [];
    if (!isdefined(level.var_b223ff19[4])) {
        level.var_b223ff19[4] = [];
    } else if (!isarray(level.var_b223ff19[4])) {
        level.var_b223ff19[4] = array(level.var_b223ff19[4]);
    }
    level.var_b223ff19[4][level.var_b223ff19[4].size] = "vox_plr_1_m_quest_boss_stage4_start_0";
    if (!isdefined(level.var_b223ff19[4])) {
        level.var_b223ff19[4] = [];
    } else if (!isarray(level.var_b223ff19[4])) {
        level.var_b223ff19[4] = array(level.var_b223ff19[4]);
    }
    level.var_b223ff19[4][level.var_b223ff19[4].size] = "vox_plr_2_m_quest_boss_stage4_start_1";
    if (!isdefined(level.var_b223ff19[4])) {
        level.var_b223ff19[4] = [];
    } else if (!isarray(level.var_b223ff19[4])) {
        level.var_b223ff19[4] = array(level.var_b223ff19[4]);
    }
    level.var_b223ff19[4][level.var_b223ff19[4].size] = "vox_plr_3_m_quest_boss_stage4_start_2";
    if (!isdefined(level.var_b223ff19[4])) {
        level.var_b223ff19[4] = [];
    } else if (!isarray(level.var_b223ff19[4])) {
        level.var_b223ff19[4] = array(level.var_b223ff19[4]);
    }
    level.var_b223ff19[4][level.var_b223ff19[4].size] = "vox_plr_4_m_quest_boss_stage4_start_3";
    level.var_b223ff19[5] = [];
    if (!isdefined(level.var_b223ff19[5])) {
        level.var_b223ff19[5] = [];
    } else if (!isarray(level.var_b223ff19[5])) {
        level.var_b223ff19[5] = array(level.var_b223ff19[5]);
    }
    level.var_b223ff19[5][level.var_b223ff19[5].size] = "vox_plr_4_m_quest_boss_stage5_start_0";
    if (!isdefined(level.var_b223ff19[5])) {
        level.var_b223ff19[5] = [];
    } else if (!isarray(level.var_b223ff19[5])) {
        level.var_b223ff19[5] = array(level.var_b223ff19[5]);
    }
    level.var_b223ff19[5][level.var_b223ff19[5].size] = "vox_plr_3_m_quest_boss_stage5_start_1";
    if (!isdefined(level.var_b223ff19[5])) {
        level.var_b223ff19[5] = [];
    } else if (!isarray(level.var_b223ff19[5])) {
        level.var_b223ff19[5] = array(level.var_b223ff19[5]);
    }
    level.var_b223ff19[5][level.var_b223ff19[5].size] = "vox_plr_2_m_quest_boss_stage5_start_2";
    if (!isdefined(level.var_b223ff19[5])) {
        level.var_b223ff19[5] = [];
    } else if (!isarray(level.var_b223ff19[5])) {
        level.var_b223ff19[5] = array(level.var_b223ff19[5]);
    }
    level.var_b223ff19[5][level.var_b223ff19[5].size] = "vox_plr_1_m_quest_boss_stage5_start_3";
    level.var_e5b74911 = [];
    for (i = 1; i <= 4; i++) {
        level.var_e5b74911[i] = [];
        for (j = 0; j <= 2; j++) {
            if (!isdefined(level.var_e5b74911[i])) {
                level.var_e5b74911[i] = [];
            } else if (!isarray(level.var_e5b74911[i])) {
                level.var_e5b74911[i] = array(level.var_e5b74911[i]);
            }
            level.var_e5b74911[i][level.var_e5b74911[i].size] = "vox_plr_" + i + "_m_quest_boss_eye_nag_" + j;
        }
    }
    level.var_2d95f641 = [];
    for (i = 1; i <= 4; i++) {
        level.var_2d95f641[i] = [];
        for (j = 0; j <= 4; j++) {
            if (!isdefined(level.var_2d95f641[i])) {
                level.var_2d95f641[i] = [];
            } else if (!isarray(level.var_2d95f641[i])) {
                level.var_2d95f641[i] = array(level.var_2d95f641[i]);
            }
            level.var_2d95f641[i][level.var_2d95f641[i].size] = "vox_plr_" + i + "_m_quest_boss_direct_hit_nag_" + j;
        }
    }
    level.var_74b571f6 = [];
    for (i = 1; i <= 4; i++) {
        level.var_74b571f6[i] = [];
        for (j = 0; j <= 4; j++) {
            if (!isdefined(level.var_74b571f6[i])) {
                level.var_74b571f6[i] = [];
            } else if (!isarray(level.var_74b571f6[i])) {
                level.var_74b571f6[i] = array(level.var_74b571f6[i]);
            }
            level.var_74b571f6[i][level.var_74b571f6[i].size] = "vox_plr_" + i + "_m_quest_boss_beam_nag_" + j;
        }
    }
    level.var_a329114c = [];
    for (i = 1; i <= 4; i++) {
        level.var_a329114c[i] = [];
        for (j = 0; j <= 4; j++) {
            if (!isdefined(level.var_a329114c[i])) {
                level.var_a329114c[i] = [];
            } else if (!isarray(level.var_a329114c[i])) {
                level.var_a329114c[i] = array(level.var_a329114c[i]);
            }
            level.var_a329114c[i][level.var_a329114c[i].size] = "vox_plr_" + i + "_m_quest_boss_beam_freeze_" + j;
        }
    }
    level.var_f01a760b = [];
    for (i = 1; i <= 4; i++) {
        level.var_f01a760b[i] = [];
        for (j = 0; j <= 2; j++) {
            if (!isdefined(level.var_f01a760b[i])) {
                level.var_f01a760b[i] = [];
            } else if (!isarray(level.var_f01a760b[i])) {
                level.var_f01a760b[i] = array(level.var_f01a760b[i]);
            }
            level.var_f01a760b[i][level.var_f01a760b[i].size] = "vox_plr_" + i + "_m_quest_boss_serpeant_warning_" + j;
        }
    }
    level.var_bf51a9ae = [];
    for (i = 1; i <= 4; i++) {
        level.var_bf51a9ae[i] = [];
        for (j = 0; j <= 2; j++) {
            if (!isdefined(level.var_bf51a9ae[i])) {
                level.var_bf51a9ae[i] = [];
            } else if (!isarray(level.var_bf51a9ae[i])) {
                level.var_bf51a9ae[i] = array(level.var_bf51a9ae[i]);
            }
            level.var_bf51a9ae[i][level.var_bf51a9ae[i].size] = "vox_plr_" + i + "_m_quest_boss_serpeant_shield_" + j;
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x9fc1ed63, Offset: 0x34d0
// Size: 0x2cc
function function_3134e59f(var_758116d) {
    level flag::clear("spawn_zombies");
    level flag::clear("zombie_drop_powerups");
    level flag::set(#"disable_fast_travel");
    level flag::set("pause_round_timeout");
    level flag::set(#"boss_fight_started");
    level zm_bgb_anywhere_but_here::function_f9947cd5(0);
    level.custom_spawnplayer = &function_965689f4;
    level zodt8_sentinel::function_116a741(1);
    level.var_448a9237 = max(level.round_number, 25);
    zm_spawner::register_zombie_death_event_callback(&function_4d91933a);
    level.var_f83f8181 = 1;
    level notify(#"force_transformations");
    /#
        util::wait_network_frame();
        level notify(#"hash_fbdf766a8b47229");
    #/
    level thread zm_zodt8::change_water_height_aft(1);
    level.e_boss function_52d99647(#"hash_5cb4b66f5c4d8a30", #"hash_20f13c444f27a214");
    if (!var_758116d) {
        level thread function_fd1b93fc();
        level.e_boss function_effdf2fe(1, "pd");
        level thread function_8b6dc9a9();
        level thread function_f68d9309(10, 3);
        level thread function_cfabbf90(60, 1);
        level thread function_54e66529(2);
        var_d4d0fbf9 = [];
        level.e_boss function_487f95c9(var_d4d0fbf9, 0, -1);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x674facb4, Offset: 0x37a8
// Size: 0x5c
function function_29c1444c(var_758116d, ended_early) {
    level flag::set(#"hash_62b951a213a3945e");
    if (!var_758116d) {
        level.e_boss function_3e42849f(1);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x38dd6fc7, Offset: 0x3810
// Size: 0x18c
function function_305ae690(var_758116d) {
    if (!var_758116d) {
        level clientfield::set("in_engine_room", 1);
        level boss_teleport_players("eng");
        level thread function_fd1b93fc();
        level.e_boss function_effdf2fe(2, "eng");
        var_f7e6d955 = array(#"zone_boiler_room", #"zone_turbine_room");
        level thread function_8b6dc9a9(var_f7e6d955);
        level thread function_f68d9309(12, 4, var_f7e6d955);
        level thread function_cfabbf90(40, 2);
        level thread function_54e66529(2);
        var_d4d0fbf9 = array(&function_81f2410d);
        level.e_boss function_487f95c9(var_d4d0fbf9, 0, -1, 0);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x4274257a, Offset: 0x39a8
// Size: 0x7c
function function_691a46fb(var_758116d, ended_early) {
    level flag::set(#"hash_bd3b222f6d8329d");
    if (!var_758116d) {
        level.e_boss function_3e42849f(2);
        level clientfield::set("in_engine_room", 0);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x857f1c3d, Offset: 0x3a30
// Size: 0xf4
function function_acef5d29(var_758116d) {
    if (!var_758116d) {
        level boss_teleport_players("st");
        level thread function_fd1b93fc();
        level.e_boss function_effdf2fe(3, "st");
        level thread function_8b6dc9a9();
        level thread function_f68d9309(13);
        var_d4d0fbf9 = array(&function_4ed10ef9);
        level.e_boss function_487f95c9(var_d4d0fbf9, 8000, 36000);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0xd03df227, Offset: 0x3b30
// Size: 0x5c
function function_352ded42(var_758116d, ended_early) {
    level flag::set(#"hash_fa1fa6cc9b17c7c");
    if (!var_758116d) {
        level.e_boss function_3e42849f(3);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xc46f37b9, Offset: 0x3b98
// Size: 0x10c
function function_76d33ac2(var_758116d) {
    if (!var_758116d) {
        level boss_teleport_players("pro");
        level thread function_fd1b93fc();
        level.e_boss function_effdf2fe(4, "pro");
        level thread function_8b6dc9a9();
        level thread function_f68d9309(11);
        level thread function_a654ab6b(46);
        var_d4d0fbf9 = array(&function_338fe30e);
        level.e_boss function_487f95c9(var_d4d0fbf9, 13000, 35000);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x74a2217d, Offset: 0x3cb0
// Size: 0x5c
function function_30167689(var_758116d, ended_early) {
    level flag::set(#"hash_50113a36d2c6bb73");
    if (!var_758116d) {
        level.e_boss function_3e42849f(4);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x64dd7c81, Offset: 0x3d18
// Size: 0xfc
function function_b7ad411b(var_758116d) {
    level boss_teleport_players("pd");
    level thread function_fd1b93fc();
    level.e_boss function_effdf2fe(5, "pd");
    level thread function_8b6dc9a9();
    level thread function_f68d9309(9);
    level thread function_a654ab6b(35);
    var_d4d0fbf9 = array(&function_b7b56ce8);
    level.e_boss function_7dee7488(var_d4d0fbf9);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x448654ad, Offset: 0x3e20
// Size: 0xf4
function function_98e6d1d0(var_758116d, ended_early) {
    level flag::clear(#"boss_fight_started");
    level zm_bgb_anywhere_but_here::function_f9947cd5(1);
    level.custom_spawnplayer = undefined;
    level.var_f83f8181 = 0;
    zm_spawner::deregister_zombie_death_event_callback(&function_4d91933a);
    level.e_boss function_3e42849f(5);
    function_903df62d();
    level flag::set(#"hash_25d8c88ff3f91ee5");
    /#
        iprintlnbold("<dev string:x30>");
    #/
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x5f9e80e2, Offset: 0x3f20
// Size: 0x34
function function_965689f4() {
    self.spectator_respawn = level.var_fac841e1[self.characterindex];
    self zm_player::spectator_respawn();
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0xfd6bed12, Offset: 0x3f60
// Size: 0xe8
function function_92c61485(str_rumble, var_94f41436 = 0) {
    if (var_94f41436) {
        a_e_players = arraycopy(level.activeplayers);
    } else {
        a_e_players = arraycopy(level.players);
    }
    foreach (e_player in a_e_players) {
        e_player playrumbleonentity(str_rumble);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x5f3a5f5b, Offset: 0x4050
// Size: 0x184
function function_52d99647(str_mdl, str_scene) {
    if (isdefined(str_mdl)) {
        self setmodel(str_mdl);
    }
    if (isdefined(str_scene)) {
        self.str_scene = str_scene;
    }
    util::wait_network_frame();
    self clientfield::set("bs_bdy_fx_cf", 2);
    util::wait_network_frame();
    if (isdefined(self.var_589ff747) && self.var_589ff747) {
        self clientfield::set("bs_bdy_fx_cf", 0);
    } else {
        self clientfield::set("bs_bdy_fx_cf", 1);
    }
    if (isdefined(self.var_e0714879) && self.var_e0714879 > 0 && self.var_e0714879 <= 3) {
        util::wait_network_frame();
        self clientfield::set("bs_bdy_dmg_fx_cf", 0);
        util::wait_network_frame();
        self clientfield::set("bs_bdy_dmg_fx_cf", self.var_e0714879);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x6b95a4ea, Offset: 0x41e0
// Size: 0x43a
function function_a23e0292(str_loc, b_on) {
    switch (str_loc) {
    case #"eng":
        if (b_on) {
            exploder::exploder("fxexp_eng_rm_bossfight_water");
            exploder::exploder("fxexp_eng_rm_bossfight_water2");
            level clientfield::set("engine_room_chillout_decals", 0);
            var_ffc013b4 = getentarray("engine_room_chillout_ice", "targetname");
            foreach (var_55b837b8 in var_ffc013b4) {
                var_55b837b8 solid();
                var_55b837b8 show();
            }
            showmiscmodels("engine_room_chillout_misc_models_iced");
            hidemiscmodels("engine_room_chillout_misc_models_not_iced");
        } else {
            level clientfield::set("engine_room_chillout_decals", 1);
            var_ffc013b4 = getentarray("engine_room_chillout_ice", "targetname");
            foreach (var_55b837b8 in var_ffc013b4) {
                var_55b837b8 notsolid();
                var_55b837b8 hide();
            }
            showmiscmodels("engine_room_chillout_misc_models_not_iced");
            hidemiscmodels("engine_room_chillout_misc_models_iced");
        }
        break;
    case #"st":
        if (b_on) {
            level clientfield::set("state_rooms_chillout_decals", 0);
        } else {
            level clientfield::set("state_rooms_chillout_decals", 1);
        }
        break;
    case #"pro":
        if (b_on) {
            exploder::exploder("fxexp_starbd_prom_bossfight_water");
            level clientfield::set("promenade_chillout_decals", 0);
            showmiscmodels("promenade_chillout_props");
        } else {
            level clientfield::set("promenade_chillout_decals", 1);
            hidemiscmodels("promenade_chillout_props");
        }
        break;
    case #"pd":
        if (b_on) {
            exploder::exploder("fxexp_poopdeck_bossfight_water");
            level clientfield::set("poop_deck_chillout_decals", 0);
            showmiscmodels("poop_deck_chillout_props");
        } else {
            level clientfield::set("poop_deck_chillout_decals", 1);
            hidemiscmodels("poop_deck_chillout_props");
        }
        break;
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xb2970593, Offset: 0x4628
// Size: 0x74
function boss_teleport_players(str_loc) {
    level.var_fac841e1 = struct::get_array(str_loc, "script_teleport");
    level zodt8_sentinel::function_d6d7f516(str_loc, struct::get(#"boss_fight"));
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x6504a11, Offset: 0x46a8
// Size: 0x98
function function_13964136() {
    foreach (player in level.players) {
        if (player laststand::player_is_in_laststand()) {
            player thread zm_laststand::auto_revive(player);
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x8ba57f5e, Offset: 0x4748
// Size: 0x6e
function function_b8eaa0c0() {
    if (!isdefined(level.var_2b421938)) {
        level.var_2b421938 = zm_utility::get_number_of_valid_players();
        return;
    }
    if (level.var_2b421938 < zm_utility::get_number_of_valid_players()) {
        level.var_2b421938 = zm_utility::get_number_of_valid_players();
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x198f309a, Offset: 0x47c0
// Size: 0x74
function function_fd1b93fc() {
    self notify("35d0c71a3981dacb");
    self endon("35d0c71a3981dacb");
    level waittill(#"hash_38f29f9cb03586ea", #"intermission");
    zm_transform::function_204b0737();
    level zodt8_sentinel::function_116a741(1, 0, 0);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x9bc7acc8, Offset: 0x4840
// Size: 0x46e
function function_3f0fcd31(str_blocker, var_3c8a5de4) {
    a_blockers = getentarray(str_blocker, "script_blocker");
    v_rotation = (0, 25, 0);
    foreach (e_blocker in a_blockers) {
        if (var_3c8a5de4) {
            e_blocker solid();
            e_blocker show();
            if (isdefined(e_blocker.var_ce0c68db)) {
                v_angles = e_blocker.var_ce0c68db;
            } else {
                v_angles = (0, 0, 0);
            }
            mdl_fx = util::spawn_model(#"p8_zm_power_door_symbol_01", e_blocker.origin, v_angles);
            mdl_fx.objectid = "symbol_front_power";
            mdl_fx clientfield::set("" + #"blocker_fx", 1);
            e_blocker.a_mdl_fx = [];
            if (!isdefined(e_blocker.a_mdl_fx)) {
                e_blocker.a_mdl_fx = [];
            } else if (!isarray(e_blocker.a_mdl_fx)) {
                e_blocker.a_mdl_fx = array(e_blocker.a_mdl_fx);
            }
            e_blocker.a_mdl_fx[e_blocker.a_mdl_fx.size] = mdl_fx;
            a_s_fx = struct::get_array(str_blocker, "script_blocker_fx");
            foreach (s_fx in a_s_fx) {
                mdl_fx = util::spawn_model(#"p8_zm_power_door_symbol_01", s_fx.origin, s_fx.angles);
                mdl_fx.objectid = "symbol_front_power";
                mdl_fx clientfield::set("" + #"blocker_fx", 1);
                if (!isdefined(e_blocker.a_mdl_fx)) {
                    e_blocker.a_mdl_fx = [];
                } else if (!isarray(e_blocker.a_mdl_fx)) {
                    e_blocker.a_mdl_fx = array(e_blocker.a_mdl_fx);
                }
                e_blocker.a_mdl_fx[e_blocker.a_mdl_fx.size] = mdl_fx;
            }
            continue;
        }
        e_blocker notsolid();
        e_blocker hide();
        foreach (mdl_fx in e_blocker.a_mdl_fx) {
            mdl_fx thread zodt8_sentinel::function_e776d4af();
        }
        e_blocker.a_mdl_fx = undefined;
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xc778b2b, Offset: 0x4cb8
// Size: 0x282
function function_c2d5e80c(str_loc) {
    self.var_10953062 = struct::get("bs_pth_hld_" + str_loc, "targetname");
    if (!isdefined(self.var_10953062)) {
        self.var_10953062 = spawnstruct();
        self.var_10953062.targetname = "bs_pth_hld_" + str_loc;
        self.var_10953062.origin = (0, 0, -9999);
        self.var_10953062.angles = (0, 0, 0);
    }
    var_cadd225d = struct::get("bs_pth_st_" + str_loc, "targetname");
    if (!isdefined(var_cadd225d)) {
        var_cadd225d = self.var_10953062;
    }
    assert(isdefined(var_cadd225d));
    self.a_s_path = [];
    if (!isdefined(self.a_s_path)) {
        self.a_s_path = [];
    } else if (!isarray(self.a_s_path)) {
        self.a_s_path = array(self.a_s_path);
    }
    self.a_s_path[self.a_s_path.size] = var_cadd225d;
    self.n_path_start = 0;
    n_path_index = 0;
    while (isdefined(var_cadd225d.linkto)) {
        n_path_index++;
        var_cadd225d = struct::get(var_cadd225d.linkto, "linkname");
        if (!isdefined(self.a_s_path)) {
            self.a_s_path = [];
        } else if (!isarray(self.a_s_path)) {
            self.a_s_path = array(self.a_s_path);
        }
        self.a_s_path[self.a_s_path.size] = var_cadd225d;
        if (isdefined(var_cadd225d.var_6c2e6778) && var_cadd225d.var_6c2e6778) {
            self.n_path_start = n_path_index;
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x95d39506, Offset: 0x4f48
// Size: 0xb24
function function_effdf2fe(n_stage, str_loc) {
    level thread function_3f0fcd31("bs_blkr_stg_" + str_loc, 1);
    util::wait_network_frame(2);
    self function_8eef3b09();
    self function_c2d5e80c(str_loc);
    self function_f966c9c5(0);
    function_b8eaa0c0();
    self function_9633343c(str_loc);
    self function_52f97210(str_loc);
    /#
        iprintlnbold("<dev string:x3f>" + n_stage + "<dev string:x46>");
    #/
    switch (n_stage) {
    case 1:
        function_7ba78ed(1);
        wait 3;
        self function_4da14e26("event_low_impact", "pd");
        self playsound("zmb_eyeball_vox_intro_s1");
        level thread function_92c61485("zm_power_on_rumble");
        self scene::play(self.str_scene, "roar", self);
        self animation::stop(0);
        wait 2;
        level function_a2370e87(n_stage);
        wait 1;
        self function_e35fbd95();
        self boss_move(0, 0);
        util::wait_network_frame(4);
        self boss_leave();
        self.var_b4e2090 = 0;
        var_f7eb3b85 = struct::get("bs_pth_pd_s1_hold", "targetname");
        self.origin = var_f7eb3b85.origin;
        self.angles = var_f7eb3b85.angles;
        self boss_arrive();
        function_7ba78ed(0);
        break;
    case 2:
        function_7ba78ed(1);
        wait 3;
        self function_4da14e26("event_low_impact", "eng", 2);
        self thread scene::play(self.str_scene, "roar", self);
        self playsound("zmb_eyeball_vox_intro_s2");
        level thread function_92c61485("zm_power_on_rumble");
        function_a23e0292("eng", 1);
        wait 1;
        self clientfield::set("bs_att_mst_tell_cf", 1);
        level thread scene::play("p8_fxanim_zm_zod_engine_pistons_idle_01_bundle", "stop");
        level thread scene::play("p8_fxanim_zm_zod_engine_pistons_idle_02_bundle", "stop");
        wait 1;
        level function_a2370e87(n_stage);
        function_7ba78ed(1);
        break;
    case 3:
        function_7ba78ed(1);
        wait 3;
        self function_4da14e26("event_impact", "st");
        function_a23e0292("st", 1);
        self playsound("zmb_eyeball_vox_intro_s3");
        level thread function_92c61485("zm_power_on_rumble");
        self function_e35fbd95();
        level thread function_879e0fca(#"hash_3d4bd2fe6917117");
        self function_4ed10ef9(0, 1, 0);
        level thread function_879e0fca(#"hash_427e51433831be0b");
        self function_4ed10ef9(0, 1, 1);
        self function_242c0311();
        wait 2;
        level function_a2370e87(n_stage);
        function_7ba78ed(0);
        break;
    case 4:
        function_7ba78ed(1);
        self function_52d99647(#"hash_5cb4b96f5c4d8f49", #"hash_4b99d4a70e2e9bb");
        wait 3;
        self function_4da14e26("event_impact", "pro", 4);
        self playsound("zmb_eyeball_vox_intro_s4");
        self thread scene::play(self.str_scene, "roar", self);
        level thread function_92c61485("zm_power_on_rumble");
        self.var_e0714879 = 1;
        self clientfield::set("bs_bdy_dmg_fx_cf", self.var_e0714879);
        self clientfield::set("bs_att_mst_tell_cf", 1);
        wait 0.6;
        function_a23e0292("pro", 1);
        level thread function_23455415(#"hash_ec0631fce0e4d56");
        level thread function_23455415(#"hash_1ce6ad9a5fb75529");
        level thread function_23455415(#"hash_323aa475d2fb88c0");
        self clientfield::set("bs_att_mst_tell_cf", 0);
        wait 2;
        level function_a2370e87(n_stage);
        function_7ba78ed(0);
        break;
    case 5:
        function_7ba78ed(1);
        self function_52d99647(#"hash_5cb4b86f5c4d8d96", #"hash_3d6484e94dfc2a6a");
        wait 2;
        self function_4da14e26("event_high_impact", "pd", 5);
        self playsound("zmb_eyeball_vox_intro_s5");
        self thread scene::play(self.str_scene, "roar", self);
        level thread function_92c61485("zm_power_on_rumble");
        self.var_e0714879 = 1;
        self clientfield::set("bs_bdy_dmg_fx_cf", self.var_e0714879);
        a_iceberg = getentarray("forget_what_you_know", "targetname");
        foreach (mdl in a_iceberg) {
            mdl.origin -= (0, 0, 13800);
            mdl show();
            mdl.origin += (0, 0, 13800);
            mdl clientfield::set("" + #"hash_15b23de7589e61a", 1);
        }
        function_a23e0292("pd", 1);
        wait 2;
        level function_a2370e87(n_stage);
        wait 1;
        function_7ba78ed(0);
        break;
    }
    /#
        iprintlnbold("<dev string:x3f>" + n_stage + "<dev string:x55>");
    #/
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x465e3d34, Offset: 0x5a78
// Size: 0x88
function function_a2370e87(n_stage) {
    foreach (str_vo_line in level.var_b223ff19[n_stage]) {
        zm_vo::function_897246e4(str_vo_line);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 3, eflags: 0x0
// Checksum 0x19ad2f59, Offset: 0x5b08
// Size: 0x1e8
function function_4da14e26(var_c7829ece, str_loc, n_stage) {
    level thread scene::stop(#"p8_fxanim_zm_zod_skybox_bundle");
    level thread scene::play(#"p8_fxanim_zm_zod_skybox_bundle", var_c7829ece);
    level thread function_92c61485("zm_power_on_rumble");
    level thread zodt8_sentinel::function_c5097b43(1, 0);
    wait 0.5;
    self function_f3b9bb96(str_loc);
    self function_242c0311(1);
    level clientfield::set("bs_gr_fog_fx_cf", 1);
    if (isdefined(n_stage)) {
        switch (n_stage) {
        case 2:
            var_a1af3740 = 1;
            break;
        case 4:
            var_a1af3740 = 2;
            break;
        case 5:
            var_a1af3740 = 3;
            break;
        }
        foreach (e_player in level.players) {
            e_player clientfield::set("bs_player_snow_cf", var_a1af3740);
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xec24f6c7, Offset: 0x5cf8
// Size: 0x2c
function function_879e0fca(var_1629289c) {
    wait 2.5;
    level thread scene::play(var_1629289c);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x3182f522, Offset: 0x5d30
// Size: 0x24
function function_23455415(var_1629289c) {
    level thread scene::play(var_1629289c);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xf17c1d98, Offset: 0x5d60
// Size: 0x118
function function_7ba78ed(b_turn_on) {
    if (b_turn_on) {
        foreach (player in level.activeplayers) {
            player clientfield::set("bs_player_ice_br_cf", 1);
        }
        return;
    }
    foreach (player in level.players) {
        player clientfield::set("bs_player_ice_br_cf", 0);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x7400db, Offset: 0x5e80
// Size: 0x68c
function function_3e42849f(n_stage) {
    function_13964136();
    /#
        iprintlnbold("<dev string:x3f>" + n_stage + "<dev string:x65>");
    #/
    self function_f966c9c5(0);
    level thread function_92c61485("zm_power_on_rumble");
    switch (n_stage) {
    case 1:
        var_5a98da61 = "zmb_eyeball_vox_outro_s1";
        var_c7829ece = "event_low_impact";
        break;
    case 2:
        var_5a98da61 = "zmb_eyeball_vox_outro_s2";
        var_c7829ece = "event_impact";
        break;
    case 3:
        var_5a98da61 = "zmb_eyeball_vox_outro_s3";
        var_c7829ece = "event_impact";
        break;
    case 4:
        var_5a98da61 = "zmb_eyeball_vox_outro_s4";
        var_c7829ece = "event_high_impact";
        break;
    case 5:
        var_5a98da61 = "zmb_eyeball_vox_outro_s5";
        var_c7829ece = "event_high_impact";
        break;
    }
    self playsound(var_5a98da61);
    level thread scene::stop(#"p8_fxanim_zm_zod_skybox_bundle");
    level thread scene::play(#"p8_fxanim_zm_zod_skybox_bundle", var_c7829ece);
    self thread scene::play(self.str_scene, "pain", self);
    level thread function_92c61485("zm_power_on_rumble");
    n_wait = 0.6 * getanimlength(#"hash_24f221de31f87832");
    wait n_wait;
    if (n_stage != 5) {
        level thread zodt8_sentinel::function_c5097b43(1, 0);
        self boss_leave(1);
        self clientfield::set("bs_bdy_fx_cf", 2);
        wait 0.5;
        level clientfield::set("bs_gr_fog_fx_cf", 0);
        self clientfield::set("bs_bdy_dmg_fx_cf", 0);
        foreach (e_player in level.players) {
            e_player clientfield::set("bs_player_snow_cf", 0);
        }
        self.origin -= (0, 0, 9999);
        self boss_arrive();
        if (isdefined(self.var_e6d17ee7)) {
            array::remove_undefined(self.var_e6d17ee7);
            if (self.var_e6d17ee7.size > 0) {
                wait 5;
            }
        }
        wait 5;
    } else {
        level thread lui::screen_flash(0.33, 0.33, 0.33, 0.8, "white");
        level thread scene::stop(#"p8_fxanim_zm_zod_skybox_bundle");
        level thread scene::play(#"p8_fxanim_zm_zod_skybox_bundle", var_c7829ece);
        self setmodel(#"hash_379ac550d90d9b33");
        self clientfield::set("bs_bdy_fx_cf", 2);
        self clientfield::increment("bs_dth_fx_cf", 1);
        self scene::play(self.str_scene, "death", self);
        level thread zodt8_sentinel::function_c5097b43(1, 0);
        wait 0.5;
        level clientfield::set("bs_gr_fog_fx_cf", 0);
        self clientfield::set("bs_bdy_dmg_fx_cf", 0);
        foreach (e_player in level.players) {
            e_player clientfield::set("bs_player_snow_cf", 0);
        }
        util::wait_network_frame();
        self.e_damage delete();
        self.var_3b84dee6 delete();
        self delete();
        wait 8 - n_wait;
    }
    /#
        iprintlnbold("<dev string:x3f>" + n_stage + "<dev string:x74>");
    #/
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xd3edd850, Offset: 0x6518
// Size: 0x58
function function_54e66529(var_213c9ca0) {
    for (var_4a7545f1 = 0; var_4a7545f1 < var_213c9ca0; var_4a7545f1++) {
        level waittill(#"hash_3a4456148ade383a");
    }
    level notify(#"hash_38f29f9cb03586ea");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x3fea4a30, Offset: 0x6578
// Size: 0x10c
function function_321cceb4(a_str_vo, var_2daa701a) {
    if (isplayer(self)) {
        e_random_player = self;
    } else {
        e_random_player = array::random(level.activeplayers);
        if (!isdefined(e_random_player)) {
            return;
        }
    }
    n_char = e_random_player.characterindex;
    if (isdefined(var_2daa701a)) {
        a_str_vo = arraycombine(a_str_vo[n_char], var_2daa701a[n_char], 0, 0);
        str_vo_line = array::random(a_str_vo);
    } else {
        str_vo_line = array::random(a_str_vo[n_char]);
    }
    self thread zm_vo::function_897246e4(str_vo_line);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 4, eflags: 0x0
// Checksum 0xb85c62cf, Offset: 0x6690
// Size: 0x14c
function function_487f95c9(var_d4d0fbf9, var_32ab136b, var_a66005e4, var_fdaa3291 = 1) {
    level thread function_fa8e1486();
    var_778a73 = 0.5;
    foreach (player in level.activeplayers) {
        var_778a73 += 0.5;
    }
    self.var_32ab136b = var_778a73 * var_32ab136b;
    if (var_a66005e4 > 0) {
        self.var_a66005e4 = var_778a73 * var_a66005e4;
    } else {
        self.var_a66005e4 = -1;
    }
    if (var_d4d0fbf9.size > 0) {
        self thread function_46dd81fa(var_d4d0fbf9, var_fdaa3291);
    }
    level waittill(#"hash_38f29f9cb03586ea");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x44129c99, Offset: 0x67e8
// Size: 0x1c6
function function_f3b9bb96(str_loc) {
    self.var_e6d17ee7 = [];
    var_f00616e5 = struct::get("bs_pup_fa_" + str_loc, "targetname");
    var_a0aae6a3 = zm_powerups::specific_powerup_drop("full_ammo", var_f00616e5.origin, undefined, undefined, undefined, 1);
    if (!isdefined(self.var_e6d17ee7)) {
        self.var_e6d17ee7 = [];
    } else if (!isarray(self.var_e6d17ee7)) {
        self.var_e6d17ee7 = array(self.var_e6d17ee7);
    }
    self.var_e6d17ee7[self.var_e6d17ee7.size] = var_a0aae6a3;
    var_d5da5b0e = struct::get("bs_pup_crpn_" + str_loc, "targetname");
    e_carpenter = zm_powerups::specific_powerup_drop("carpenter", var_d5da5b0e.origin, undefined, undefined, undefined, 1);
    if (!isdefined(self.var_e6d17ee7)) {
        self.var_e6d17ee7 = [];
    } else if (!isarray(self.var_e6d17ee7)) {
        self.var_e6d17ee7 = array(self.var_e6d17ee7);
    }
    self.var_e6d17ee7[self.var_e6d17ee7.size] = e_carpenter;
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x777bc0b1, Offset: 0x69b8
// Size: 0x90
function function_8eef3b09() {
    if (!isdefined(self.var_e6d17ee7)) {
        return;
    }
    foreach (e_powerup in self.var_e6d17ee7) {
        if (isdefined(e_powerup)) {
            e_powerup delete();
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x4406f2dc, Offset: 0x6a50
// Size: 0x1d0
function function_9633343c(str_loc) {
    var_40d601ef = struct::get_array("bs_att_mst_" + str_loc, "targetname");
    if (var_40d601ef.size > 0) {
        self.var_eeeab0ec = [];
        var_40d601ef = array::sort_by_script_int(var_40d601ef, 1);
        var_483936c2 = 0;
        self.var_eeeab0ec[var_483936c2] = [];
        for (i = 0; i < var_40d601ef.size; i++) {
            if (!isdefined(self.var_eeeab0ec[var_483936c2])) {
                self.var_eeeab0ec[var_483936c2] = [];
            }
            if (!isdefined(self.var_eeeab0ec[var_483936c2])) {
                self.var_eeeab0ec[var_483936c2] = [];
            } else if (!isarray(self.var_eeeab0ec[var_483936c2])) {
                self.var_eeeab0ec[var_483936c2] = array(self.var_eeeab0ec[var_483936c2]);
            }
            self.var_eeeab0ec[var_483936c2][self.var_eeeab0ec[var_483936c2].size] = var_40d601ef[i];
            if (isdefined(var_40d601ef[i + 1])) {
                if (var_40d601ef[i].script_int != var_40d601ef[i + 1].script_int) {
                    var_483936c2++;
                }
            }
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x12ac1f26, Offset: 0x6c28
// Size: 0x2ea
function function_52f97210(str_loc, var_66a15e7d) {
    self.var_8121f810 = [];
    var_2b875e87 = struct::get_array("bs_att_bm_" + str_loc, "targetname");
    if (isdefined(var_66a15e7d)) {
        var_106a0414 = struct::get_array("bs_att_bm_" + var_66a15e7d, "targetname");
        var_2b875e87 = arraycombine(var_2b875e87, var_106a0414, 0, 0);
    }
    var_2b875e87 = array::filter(var_2b875e87, 0, &function_e4e6d1fc);
    if (var_2b875e87.size > 0) {
        var_2b875e87 = array::sort_by_script_int(var_2b875e87, 1);
        for (i = 0; i < var_2b875e87.size; i++) {
            var_cf874df4 = var_2b875e87[i];
            self.var_8121f810[i] = [];
            if (!isdefined(self.var_8121f810[i])) {
                self.var_8121f810[i] = [];
            } else if (!isarray(self.var_8121f810[i])) {
                self.var_8121f810[i] = array(self.var_8121f810[i]);
            }
            self.var_8121f810[i][self.var_8121f810[i].size] = var_cf874df4;
            while (isdefined(var_cf874df4.linkto)) {
                var_cf874df4 = struct::get(var_cf874df4.linkto, "linkname");
                if (!isdefined(self.var_8121f810[i])) {
                    self.var_8121f810[i] = [];
                } else if (!isarray(self.var_8121f810[i])) {
                    self.var_8121f810[i] = array(self.var_8121f810[i]);
                }
                self.var_8121f810[i][self.var_8121f810[i].size] = var_cf874df4;
            }
        }
    }
    self.var_d356d840 = getentarray("bs_att_bm_vol_" + str_loc, "targetname");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x98026c4d, Offset: 0x6f20
// Size: 0x1a
function function_e4e6d1fc(e_ent) {
    return !isdefined(e_ent.linkname);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x4bd47ca, Offset: 0x6f48
// Size: 0x608
function function_eda57e8b() {
    level endon(#"hash_38f29f9cb03586ea", #"intermission");
    self notify("40f1cf1250a7ad98");
    self endon("40f1cf1250a7ad98");
    var_f0d4bc0f = 0;
    self.var_b5f846f3 = 0;
    if (!isdefined(self.var_a66005e4) || self.var_a66005e4 <= 0) {
        var_2e289540 = 1;
    } else {
        var_2e289540 = 0;
        var_305fe75b = 3;
        if (!isdefined(self.var_e0714879)) {
            self.var_e0714879 = 0;
            var_305fe75b -= 1;
        }
        var_1cdc7e59 = self.var_a66005e4 / 4;
        if (!isdefined(self.var_a79abcae)) {
            self.var_a79abcae = var_1cdc7e59;
        }
    }
    while (true) {
        b_cancelled = 0;
        s_notify = self.e_damage waittill(#"damage");
        n_damage = s_notify.amount;
        w_weapon = s_notify.weapon;
        if (isdefined(w_weapon) && zm_weapons::is_wonder_weapon(w_weapon)) {
            n_damage *= 0.1;
        }
        if (isalive(s_notify.attacker) && isplayer(s_notify.attacker)) {
            s_notify.attacker util::show_hit_marker();
            if (s_notify.attacker hasperk(#"specialty_mod_awareness")) {
                n_damage = int(n_damage * 1.1);
            }
        }
        self.var_b5f846f3 += n_damage;
        if (isdefined(self.var_32ab136b) && self.var_32ab136b > 0 && self.var_b5f846f3 >= self.var_32ab136b) {
            /#
                iprintlnbold("<dev string:x84>");
            #/
            b_cancelled = 1;
            self function_f966c9c5(0);
            util::wait_network_frame();
        }
        if (!var_2e289540) {
            self.var_6078c272 += n_damage;
            if (self.var_e0714879 < var_305fe75b && self.var_6078c272 > self.var_a79abcae) {
                self.var_e0714879++;
                self.var_a79abcae += var_1cdc7e59;
                if (self.model == #"hash_5cb4b96f5c4d8f49" || self.model == #"hash_6df0aeb5fab34528") {
                    if (self.var_e0714879 == 2) {
                        self function_52d99647(#"hash_6df0aeb5fab34528", undefined);
                    } else {
                        self function_52d99647(undefined, #"hash_77cd4eee0982b98e");
                        self scene::play(self.str_scene, "break", self);
                        self clientfield::set("bs_bdy_dmg_fx_cf", self.var_e0714879);
                    }
                } else if (self.model == #"hash_5cb4b66f5c4d8a30" || self.model == #"hash_6df0b1b5fab34a41") {
                    if (self.var_e0714879 == 1) {
                        self function_52d99647(#"hash_6df0b1b5fab34a41", undefined);
                    } else {
                        self function_52d99647(undefined, #"hash_4bf39d7ab9166b7d");
                        self scene::play(self.str_scene, "break", self);
                        self clientfield::set("bs_bdy_dmg_fx_cf", self.var_e0714879);
                    }
                }
            }
            if (self.var_6078c272 >= self.var_a66005e4) {
                b_cancelled = 1;
                var_f0d4bc0f = 1;
            }
        }
        if (b_cancelled) {
            level notify(#"hash_14400d2bff068132");
            if (!var_f0d4bc0f) {
                function_321cceb4(level.var_2d95f641);
                playsoundatposition(#"hash_6040f3b85932670c", self.origin);
                self scene::play(self.str_scene, "pain", self);
                level thread function_92c61485("zm_power_on_rumble");
            } else {
                self.var_e0714879 = undefined;
                self.var_a79abcae = undefined;
                level notify(#"hash_38f29f9cb03586ea");
            }
            break;
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x3ae39aea, Offset: 0x7558
// Size: 0xa2
function function_f966c9c5(b_show) {
    if (isdefined(b_show) && b_show) {
        self clientfield::set("bs_bdy_fx_cf", 0);
        self.e_damage solid();
    } else {
        self clientfield::set("bs_bdy_fx_cf", 1);
        self.e_damage notsolid();
    }
    self.var_589ff747 = b_show;
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x5d55f48c, Offset: 0x7608
// Size: 0x17c
function function_7dee7488(var_d4d0fbf9) {
    level endon(#"intermission");
    level thread function_3f0fcd31("bs_blkr_stg_" + "pd", 1);
    level thread function_fa8e1486();
    self function_c2d5e80c("pd");
    var_778a73 = 0.5;
    foreach (player in level.activeplayers) {
        var_778a73 += 0.5;
    }
    self.var_f492e0d2 = var_778a73 * 10000;
    self.var_aa7cd5f0 = var_778a73 * 25000;
    self.var_5b81e49e = var_778a73 * 18000;
    self.var_3dd7a7ad = 0;
    self thread function_46dd81fa(var_d4d0fbf9);
    level waittill(#"hash_38f29f9cb03586ea");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xed1eb6bd, Offset: 0x7790
// Size: 0x35c
function function_c697768d() {
    level endon(#"hash_14400d2bff068132", #"intermission");
    self notify("34b8c045c8c09ad7");
    self endon("34b8c045c8c09ad7");
    self.var_b5f846f3 = 0;
    var_74d8f58f = 0;
    while (true) {
        b_cancelled = 0;
        s_notify = self.e_damage waittill(#"damage");
        n_damage = s_notify.amount;
        w_weapon = s_notify.weapon;
        if (isdefined(w_weapon) && zm_weapons::is_wonder_weapon(w_weapon)) {
            n_damage *= 0.1;
        }
        if (isalive(s_notify.attacker) && isplayer(s_notify.attacker)) {
            s_notify.attacker util::show_hit_marker();
            if (s_notify.attacker hasperk(#"specialty_mod_awareness")) {
                n_damage = int(n_damage * 1.1);
            }
        }
        self.var_b5f846f3 += n_damage;
        if (self.var_b5f846f3 >= self.var_f492e0d2) {
            /#
                iprintlnbold("<dev string:x95>");
            #/
            self function_f966c9c5(0);
            b_cancelled = 1;
            util::wait_network_frame();
        }
        self.var_6078c272 += n_damage;
        if (self.var_6078c272 >= self.var_aa7cd5f0) {
            /#
                iprintlnbold("<dev string:x95>");
            #/
            self.var_20c0ed6 = 1;
            self.var_6078c272 = 0;
            self function_f966c9c5(0);
            b_cancelled = 1;
            var_74d8f58f = 1;
        }
        if (b_cancelled) {
            level notify(#"hash_14400d2bff068132");
            if (!var_74d8f58f) {
                function_321cceb4(level.var_2d95f641);
                playsoundatposition(#"hash_6040f3b85932670c", self.origin);
                self scene::play(self.str_scene, "pain", self);
                level thread function_92c61485("zm_power_on_rumble");
            }
            break;
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x259f8d3f, Offset: 0x7af8
// Size: 0x378
function function_bf722d62() {
    level endon(#"hash_38f29f9cb03586ea");
    level endon(#"intermission");
    self.var_b5f846f3 = 0;
    var_7d2684c0 = 0;
    var_74d8f58f = 0;
    while (true) {
        s_notify = self.e_damage waittill(#"damage");
        n_damage = s_notify.amount;
        if (isalive(s_notify.attacker) && isplayer(s_notify.attacker)) {
            s_notify.attacker util::show_hit_marker();
            if (s_notify.attacker hasperk(#"specialty_mod_awareness")) {
                n_damage = int(n_damage * 1.1);
            }
        }
        self.var_b5f846f3 += n_damage;
        if (self.var_b5f846f3 >= self.var_5b81e49e) {
            /#
                iprintlnbold("<dev string:x84>");
            #/
            self function_f966c9c5(0);
            util::wait_network_frame();
            self.var_3dd7a7ad++;
            if (self.var_3dd7a7ad >= 3) {
                var_7d2684c0 = 1;
                var_74d8f58f = 0;
            }
            self clientfield::set("bs_att_blst_tll", 0);
            level notify(#"hash_14400d2bff068132");
            if (!var_74d8f58f) {
                self.var_e0714879++;
                self scene::play(self.str_scene, "pain", self);
                level thread function_92c61485("zm_power_on_rumble");
                playsoundatposition(#"hash_6040f3b85932670c", self.origin);
                if (self.var_e0714879 == 2) {
                    self function_52d99647(#"hash_6df0afb5fab346db", undefined);
                } else if (self.var_e0714879 == 3) {
                    self function_52d99647(undefined, #"hash_de59af503eb7003");
                    self scene::play(self.str_scene, "break", self);
                    self clientfield::set("bs_bdy_dmg_fx_cf", self.var_e0714879);
                }
            }
            if (var_7d2684c0) {
                level notify(#"hash_38f29f9cb03586ea");
            }
            break;
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0xa6177a53, Offset: 0x7e78
// Size: 0x150
function function_46dd81fa(var_d4d0fbf9, var_fdaa3291 = 1) {
    level endon(#"hash_38f29f9cb03586ea", #"intermission");
    self function_f966c9c5(0);
    self.var_6078c272 = 0;
    n_attack = 0;
    while (true) {
        if (!(isdefined(self.var_20c0ed6) && self.var_20c0ed6)) {
            wait randomfloatrange(9, 13);
        }
        if (var_fdaa3291 && !(isdefined(self.var_20c0ed6) && self.var_20c0ed6)) {
            self function_e35fbd95();
        }
        self function_eefcc673(var_d4d0fbf9, n_attack);
        if (n_attack + 1 >= var_d4d0fbf9.size) {
            n_attack = 0;
        } else {
            n_attack++;
        }
        if (var_fdaa3291) {
            self function_242c0311();
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x8ffca635, Offset: 0x7fd0
// Size: 0x13c
function boss_leave(var_ad88ac18 = 0) {
    self animation::stop(0);
    v_pos = self.origin;
    if (var_ad88ac18) {
        playsoundatposition(#"hash_e2ba9305b1dafc9", v_pos);
    } else {
        playsoundatposition(#"hash_1b108a99d8b8a77e", v_pos);
    }
    self clientfield::set("bs_bdy_fx_cf", 2);
    self clientfield::set("bs_bdy_dmg_fx_cf", 0);
    self clientfield::set("bs_spn_fx_cf", 0);
    self scene::play(self.str_scene, "leave", self);
    self animation::stop(0);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x9c889899, Offset: 0x8118
// Size: 0x194
function boss_arrive(var_e9d6a93b = 0) {
    util::wait_network_frame();
    v_pos = self.origin;
    if (var_e9d6a93b) {
        playsoundatposition(#"hash_732b71cd63845865", v_pos);
    } else {
        playsoundatposition(#"hash_241b296b37ac90bf", v_pos);
    }
    self clientfield::set("bs_spn_fx_cf", 1);
    self scene::play(self.str_scene, "arrive", self);
    self animation::stop(0);
    self clientfield::set("bs_bdy_fx_cf", 1);
    if (isdefined(self.var_e0714879) && self.var_e0714879 > 0) {
        util::wait_network_frame();
        self clientfield::set("bs_bdy_dmg_fx_cf", self.var_e0714879);
    }
    self thread scene::play(self.str_scene, "ilde", self);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x94e9a812, Offset: 0x82b8
// Size: 0x7c
function function_242c0311(var_e9d6a93b = 0) {
    self boss_leave();
    self.var_b4e2090 = 0;
    self.origin = self.var_10953062.origin;
    self.angles = self.var_10953062.angles;
    self boss_arrive(var_e9d6a93b);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xf77d8d29, Offset: 0x8340
// Size: 0x7c
function function_e35fbd95() {
    self boss_leave();
    self.var_b4e2090 = self.n_path_start;
    self.origin = self.a_s_path[self.var_b4e2090].origin;
    self.angles = self.a_s_path[self.var_b4e2090].angles;
    self boss_arrive();
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x2f22ad1b, Offset: 0x83c8
// Size: 0x210
function boss_move(var_b2165e30, var_37c722f = 1) {
    level endon(#"intermission");
    if (self.a_s_path.size == 1) {
        return;
    }
    if (self.var_b4e2090 == var_b2165e30) {
        return;
    }
    if (var_37c722f) {
        var_10406760 = 3;
    } else {
        var_10406760 = 2;
    }
    while (self.var_b4e2090 != var_b2165e30) {
        if (self.var_b4e2090 > var_b2165e30) {
            for (i = 1; i <= var_10406760; i++) {
                if (self.var_b4e2090 - i < var_b2165e30) {
                    break;
                }
                var_f3fbfa3 = i * -1;
            }
        } else {
            for (i = 1; i <= var_10406760; i++) {
                if (self.var_b4e2090 + i > var_b2165e30) {
                    break;
                }
                var_f3fbfa3 = i;
            }
        }
        self boss_leave();
        self.var_b4e2090 += var_f3fbfa3;
        self.origin = self.a_s_path[self.var_b4e2090].origin;
        self.angles = self.a_s_path[self.var_b4e2090].angles;
        self boss_arrive();
        if (self.var_b4e2090 != var_b2165e30) {
            if (!var_37c722f) {
                wait randomfloatrange(0.75, 1.25);
                continue;
            }
            util::wait_network_frame(4);
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x70716ce3, Offset: 0x85e0
// Size: 0xc4
function function_eefcc673(var_d4d0fbf9, n_attack) {
    level endon(#"intermission");
    if (isdefined(self.var_20c0ed6) && self.var_20c0ed6) {
        self.var_20c0ed6 = 0;
        self function_beac8212();
    } else {
        self [[ var_d4d0fbf9[n_attack] ]]();
    }
    level notify(#"hash_14400d2bff068132");
    self function_f966c9c5(0);
    /#
        iprintlnbold("<dev string:xac>");
    #/
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x992ecc39, Offset: 0x86b0
// Size: 0x44
function function_338fe30e() {
    level endon(#"intermission");
    self thread function_81f2410d();
    self function_4ed10ef9();
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x5ef3e844, Offset: 0x8700
// Size: 0x44
function function_b7b56ce8() {
    level endon(#"intermission");
    self thread function_81f2410d();
    self function_4ed10ef9(1);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xca6ff12c, Offset: 0x8750
// Size: 0x134
function function_81f2410d() {
    level endon(#"hash_14400d2bff068132", #"intermission");
    /#
        iprintlnbold("<dev string:xc1>");
    #/
    var_ab26d9de = array::random(self.var_eeeab0ec);
    self clientfield::set("bs_att_mst_tell_cf", 1);
    foreach (var_f24bc218 in var_ab26d9de) {
        self thread function_f837b146(var_f24bc218.origin);
        util::wait_network_frame();
    }
    wait 6;
    self clientfield::set("bs_att_mst_tell_cf", 0);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x194e3a71, Offset: 0x8890
// Size: 0x290
function function_f837b146(v_loc, n_time = 8) {
    level endon(#"intermission");
    e_target = util::spawn_model("tag_origin", v_loc);
    util::wait_network_frame();
    e_target clientfield::set("bs_att_mst_cf", 1);
    e_target thread function_3e87818();
    wait 1;
    for (n_time_passed = 0; n_time_passed <= n_time; n_time_passed += 0.1) {
        a_players = util::get_active_players();
        a_players = arraysortclosest(a_players, v_loc, undefined, undefined, 128);
        foreach (player in a_players) {
            player thread zm_utility::function_50a99546(#"hash_2cc0dfb628810e41");
        }
        a_ai_zombies = array::get_all_closest(v_loc, getaiarchetypearray("zombie"), undefined, undefined, 128);
        foreach (ai_zombie in a_ai_zombies) {
            if (!ai_zombie zm_ai_catalyst::function_b0fb0192()) {
                ai_zombie thread zm_ai_catalyst::function_ecf612de(0);
            }
        }
        wait 0.1;
    }
    level notify(#"hash_738991c86bf9f7c2");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x59900159, Offset: 0x8b28
// Size: 0x8c
function function_3e87818() {
    level waittill(#"hash_38f29f9cb03586ea", #"hash_738991c86bf9f7c2", #"intermission");
    self clientfield::set("bs_att_mst_cf", 0);
    util::wait_network_frame(4);
    self delete();
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 3, eflags: 0x0
// Checksum 0xe53b7129, Offset: 0x8bc0
// Size: 0x1c4
function function_4ed10ef9(var_91d6622a = 0, var_cb77840b = 0, var_17cdfad5) {
    level endon(#"hash_14400d2bff068132", #"intermission");
    /#
        iprintlnbold("<dev string:xce>");
    #/
    level thread function_796330a2();
    var_759b553c = [];
    if (isdefined(var_17cdfad5)) {
        n_path = var_17cdfad5;
    } else if (self.var_d356d840.size > 0) {
        n_path = self function_6e8ed851(self.var_d356d840);
    } else {
        n_path = randomint(self.var_8121f810.size);
    }
    var_759b553c = self.var_8121f810[n_path];
    level.e_boss thread function_1b77708c(n_path);
    var_b2165e30 = var_759b553c[0].script_int;
    self boss_move(var_b2165e30);
    if (var_91d6622a) {
        self thread function_c697768d();
    } else if (!var_cb77840b) {
        self thread function_eda57e8b();
    }
    self function_af99700(n_path, var_91d6622a, var_cb77840b);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x5b5cbfb5, Offset: 0x8d90
// Size: 0x1e6
function function_6e8ed851(a_vols) {
    a_vols = array::randomize(a_vols);
    var_baa4b6d4 = a_vols[0];
    var_9d40002e = 0;
    foreach (e_vol in a_vols) {
        var_1b5a0051 = var_9d40002e;
        var_9d40002e = 0;
        foreach (player in level.activeplayers) {
            if (player istouching(e_vol)) {
                var_9d40002e++;
            }
        }
        if (var_9d40002e > var_1b5a0051) {
            var_baa4b6d4 = e_vol;
        }
    }
    assert(isdefined(var_baa4b6d4.script_int));
    var_6c927fa1 = var_baa4b6d4.script_int;
    for (i = 0; i < self.var_8121f810.size; i++) {
        if (self.var_8121f810[i][0].script_int == var_6c927fa1) {
            return i;
        }
    }
    return 0;
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x15bc9c43, Offset: 0x8f80
// Size: 0x260
function function_1b77708c(n_path) {
    if (!isdefined(self.var_a317726)) {
        return;
    }
    var_1d735091 = [];
    var_d58d62cd = "bs_att_bm_ai_blck_" + self.var_a317726;
    a_e_blockers = array::sort_by_script_int(getentarray(var_d58d62cd, "script_blocker"), 1);
    foreach (e_blocker in a_e_blockers) {
        if (e_blocker.script_int == n_path) {
            if (!isdefined(var_1d735091)) {
                var_1d735091 = [];
            } else if (!isarray(var_1d735091)) {
                var_1d735091 = array(var_1d735091);
            }
            var_1d735091[var_1d735091.size] = e_blocker;
            e_blocker solid();
            e_blocker show();
            e_blocker disconnectpaths();
        }
    }
    level waittill(#"hash_38f29f9cb03586ea", #"hash_ba0b98df6573d80", #"intermission");
    if (isdefined(var_1d735091)) {
        foreach (e_blocker in var_1d735091) {
            e_blocker notsolid();
            e_blocker hide();
            e_blocker connectpaths();
        }
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xee46bde2, Offset: 0x91e8
// Size: 0xec
function function_796330a2() {
    level waittill(#"hash_38f29f9cb03586ea", #"hash_14400d2bff068132", #"hash_ba0b98df6573d80", #"intermission");
    level.e_boss function_f966c9c5(0);
    level.e_boss clientfield::set("bs_att_bm_tell_fx_cf", 0);
    level.e_boss.var_3b84dee6 clientfield::set("bs_att_bm_cf", 0);
    level.e_boss clientfield::set("bs_att_mst_tell_cf", 0);
    level.e_boss notify(#"hash_2bb8be6b846aed93");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0xcd2b1eff, Offset: 0x92e0
// Size: 0x10a
function function_c7a79720(v_loc, n_time) {
    level endon(#"hash_14400d2bff068132", #"intermission");
    if (!isdefined(level.var_362dc2f0)) {
        level.var_362dc2f0 = util::spawn_model("tag_origin", v_loc);
        util::wait_network_frame(4);
        level.var_362dc2f0 clientfield::set("bs_att_bm_targ_ini_cf", 1);
        util::wait_network_frame(4);
    }
    if (isdefined(n_time)) {
        level.var_362dc2f0 moveto(v_loc, n_time);
        wait n_time;
        return;
    }
    level.var_362dc2f0.origin = v_loc;
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 3, eflags: 0x0
// Checksum 0xd0628164, Offset: 0x93f8
// Size: 0x378
function function_af99700(n_path_id, var_91d6622a, var_cb77840b) {
    level endon(#"hash_14400d2bff068132", #"intermission");
    assert(isdefined(self.var_8121f810));
    v_loc = self.var_8121f810[n_path_id][0].origin;
    var_bdc0f958 = self.var_3b84dee6.origin;
    var_fa04bdf1 = vectortoangles(v_loc - self.origin);
    v_forward = anglestoforward(var_fa04bdf1);
    a_trace = beamtrace(var_bdc0f958, var_bdc0f958 + v_forward * 20000, 0, self.var_3b84dee6, 1, 1);
    var_fc46c711 = a_trace[#"position"];
    level function_c7a79720(var_fc46c711);
    self thread scene::play(self.str_scene, "charge", self);
    self.var_3b84dee6 clientfield::set("bs_att_bm_cf", 1);
    wait 1;
    self.var_3b84dee6 clientfield::set("bs_att_bm_tell_cf", 1);
    wait 0.4;
    self clientfield::set("bs_att_bm_tell_fx_cf", 1);
    wait 0.1;
    self.var_3b84dee6 clientfield::set("bs_att_bm_tell_cf", 2);
    self playsound(#"hash_2af120dbf3e870e8");
    self function_f966c9c5(1);
    function_321cceb4(level.var_e5b74911, level.var_74b571f6);
    /#
        self thread persistentdebugline(var_bdc0f958, level.var_362dc2f0);
        render_debug_sphere(var_bdc0f958, (1, 1, 0));
        render_debug_sphere(var_fc46c711, (1, 0, 0));
    #/
    if (var_91d6622a) {
        self thread function_5048834(1);
    } else if (var_cb77840b) {
        self thread function_5048834(0, 1);
    } else {
        self thread function_5048834(0);
    }
    self function_a23621e(n_path_id, var_91d6622a, var_cb77840b);
    level notify(#"hash_ba0b98df6573d80");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 3, eflags: 0x0
// Checksum 0x991c0a3e, Offset: 0x9778
// Size: 0x2be
function function_a23621e(var_2b760bf9, var_91d6622a, var_cb77840b) {
    level endon(#"hash_14400d2bff068132", #"intermission");
    var_c0a0abdc = [];
    var_fe93779c = 0;
    a_path = arraycopy(self.var_8121f810[var_2b760bf9]);
    var_fe7cb2a = a_path[0];
    while (isdefined(var_fe7cb2a.linkto)) {
        var_fb4552db = var_fe7cb2a.origin;
        var_fe7cb2a = struct::get(var_fe7cb2a.linkto, "linkname");
        n_dist = distance(var_fe7cb2a.origin, var_fb4552db);
        var_fe93779c += n_dist;
        if (!isdefined(var_c0a0abdc)) {
            var_c0a0abdc = [];
        } else if (!isarray(var_c0a0abdc)) {
            var_c0a0abdc = array(var_c0a0abdc);
        }
        var_c0a0abdc[var_c0a0abdc.size] = n_dist;
    }
    a_n_times = [];
    if (var_cb77840b) {
        n_total_time = 2;
    } else if (var_91d6622a) {
        n_total_time = 7.5;
    } else {
        n_total_time = 9;
    }
    for (i = 0; i < var_c0a0abdc.size; i++) {
        n_time = n_total_time * var_c0a0abdc[i] / var_fe93779c;
        if (!isdefined(a_n_times)) {
            a_n_times = [];
        } else if (!isarray(a_n_times)) {
            a_n_times = array(a_n_times);
        }
        a_n_times[a_n_times.size] = n_time;
    }
    for (i = 1; i < a_path.size; i++) {
        level function_c7a79720(a_path[i].origin, a_n_times[i - 1]);
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0xcdc82c9e, Offset: 0x9a40
// Size: 0xda8
function function_5048834(var_91d6622a, var_cb77840b = 0) {
    level endon(#"hash_14400d2bff068132", #"intermission");
    self endon(#"hash_2bb8be6b846aed93");
    while (true) {
        v_source = self.var_3b84dee6.origin;
        v_target = level.var_362dc2f0.origin;
        a_beamtrace = beamtrace(v_source, v_target, 0, self.var_3b84dee6, 1, 1);
        var_26eca2bd = distance(v_source, a_beamtrace[#"position"]);
        var_3c5b0268 = var_26eca2bd * var_26eca2bd;
        a_players = array::get_all_closest(v_source, level.players, undefined, undefined, var_26eca2bd);
        if (a_players.size <= 0) {
            foreach (player in level.players) {
                player notify(#"hash_27a44c71de4b4cb8");
                player.var_8b903e17 = 0;
            }
            util::wait_network_frame();
            continue;
        }
        var_c7c745e8 = [];
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_helmet";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_head";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_neck";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_spine_upper";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_spine_lower";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_shoulder_le";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_shoulder_ri";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_spine4";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "tag_aim";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_elbow_le";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_elbow_ri";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_wrist_le";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_wrist_ri";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_hiptwist_le";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_hiptwist_ri";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_knee_bulge_le";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_knee_bulge_ri";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_ankle_le";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_ankle_ri";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_ball_le";
        if (!isdefined(var_c7c745e8)) {
            var_c7c745e8 = [];
        } else if (!isarray(var_c7c745e8)) {
            var_c7c745e8 = array(var_c7c745e8);
        }
        var_c7c745e8[var_c7c745e8.size] = "j_ball_ri";
        var_ebc0bf73 = [];
        foreach (player in a_players) {
            if (zm_utility::is_player_valid(player) && !player issliding()) {
                var_fad52dd = player getcentroid();
                v_player_origin = player getorigin();
                var_e48bd4e5 = distancesquared(v_source, var_fad52dd);
                var_8cc0683a = distancesquared(v_source, v_player_origin);
                var_be5421ca = pointonsegmentnearesttopoint(v_source, v_target, var_fad52dd);
                var_10b3519f = pointonsegmentnearesttopoint(v_source, v_target, v_player_origin);
                b_is_valid_target = 0;
                if (distancesquared(var_fad52dd, var_be5421ca) <= 324 || distancesquared(v_player_origin, var_10b3519f) <= 324) {
                    b_is_valid_target = 1;
                } else {
                    foreach (str_tag in var_c7c745e8) {
                        v_hitloc = player gettagorigin(str_tag);
                        if (isdefined(v_hitloc)) {
                            var_c795686b = pointonsegmentnearesttopoint(v_source, v_target, v_hitloc);
                            temp_dist = distancesquared(v_hitloc, var_c795686b);
                            if (distancesquared(v_hitloc, var_c795686b) <= 324) {
                                b_is_valid_target = 1;
                                break;
                            }
                        }
                    }
                }
            }
            if (isdefined(b_is_valid_target) && b_is_valid_target) {
                if (!isdefined(var_ebc0bf73)) {
                    var_ebc0bf73 = [];
                } else if (!isarray(var_ebc0bf73)) {
                    var_ebc0bf73 = array(var_ebc0bf73);
                }
                var_ebc0bf73[var_ebc0bf73.size] = player;
            }
        }
        if (var_ebc0bf73.size > 0) {
            foreach (player in var_ebc0bf73) {
                if (!zm_utility::is_player_valid(player)) {
                    continue;
                }
                if (isdefined(player)) {
                    if (var_cb77840b) {
                        if (!(isdefined(player.var_c3044680) && player.var_c3044680)) {
                            player thread function_57f536eb();
                        }
                        util::wait_network_frame();
                        continue;
                    }
                    if (!(isdefined(player.var_8b903e17) && player.var_8b903e17)) {
                        player.var_8b903e17 = 1;
                        player thread function_98bedee5(var_91d6622a);
                    }
                    player thread function_18ff9008();
                }
            }
        }
        util::wait_network_frame();
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xa044e096, Offset: 0xa7f0
// Size: 0x76
function function_57f536eb() {
    self endon(#"entering_last_stand", #"disconnect", #"death");
    self.var_c3044680 = 1;
    self dodamage(25, self.origin);
    wait 2.5;
    self.var_c3044680 = 0;
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xa187df02, Offset: 0xa870
// Size: 0x66
function function_18ff9008() {
    self notify("7bbec8c9052c033");
    self endon("7bbec8c9052c033");
    wait 0.3;
    self.var_8b903e17 = 0;
    self clientfield::set("bs_att_bm_targ_hit_cf", 0);
    self notify(#"hash_27a44c71de4b4cb8");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xb32fe947, Offset: 0xa8e0
// Size: 0x278
function function_98bedee5(var_91d6622a) {
    level endon(#"hash_14400d2bff068132", #"intermission");
    self endon(#"hash_27a44c71de4b4cb8", #"disconnect");
    n_counter = 0;
    if (var_91d6622a) {
        n_wait = 0.2;
    } else {
        n_wait = 0.3;
    }
    while (!(isdefined(self.var_18aaed3b) && self.var_18aaed3b) && self.var_8b903e17 && zm_utility::is_player_valid(self)) {
        if (n_counter == 0 && !(isdefined(self.var_1144c92a) && self.var_1144c92a)) {
            self thread function_79ba9073();
            self dodamage(25, self.origin);
            self clientfield::set("bs_att_bm_targ_hit_cf", 1);
        } else {
            self dodamage(10, self.origin);
            self clientfield::set("bs_att_bm_targ_hit_cf", 1);
        }
        if (n_counter < 4) {
            if (var_91d6622a) {
                self thread zm_utility::function_50a99546(#"hash_2a290908eb355917", 1 - n_wait);
            } else {
                self thread zm_utility::function_50a99546(#"hash_532f7f688c86c9b1", 1 - n_wait);
            }
            wait n_wait;
            n_wait /= 2;
            n_counter++;
            continue;
        }
        if (!(isdefined(self.var_18aaed3b) && self.var_18aaed3b)) {
            self.var_18aaed3b = 1;
            self thread function_6526b95b();
            return;
        }
        wait n_wait;
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x5e6542f5, Offset: 0xab60
// Size: 0x6a
function function_79ba9073() {
    level endon(#"intermission");
    self notify("16a3dbb60c2c4e68");
    self endon("16a3dbb60c2c4e68");
    self endon(#"disconnect");
    self.var_1144c92a = 1;
    wait 2;
    self.var_1144c92a = 0;
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xc60461ef, Offset: 0xabd8
// Size: 0x17c
function function_6526b95b() {
    level endon(#"intermission");
    self notify("7909a31c9156f389");
    self endon("7909a31c9156f389");
    self endon(#"disconnect");
    self thread function_9292c5b();
    self thread zm_utility::function_50a99546(#"hash_7d336706f2aeadab");
    self clientfield::set("bs_att_bm_targ_hit_cf", 0);
    self clientfield::set_to_player("bs_att_bm_targ_frz_fx_cf", 1);
    self allowjump(0);
    self thread function_321cceb4(level.var_a329114c);
    self waittill(#"entering_last_stand", #"hash_14ed4d12ee0b5984");
    self thread zm_utility::function_50a99546(#"hash_7d336706f2aeadab", 1);
    self clientfield::set_to_player("bs_att_bm_targ_frz_fx_cf", 0);
    self allowjump(1);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xae269f83, Offset: 0xad60
// Size: 0xa2
function function_9292c5b() {
    level endon(#"intermission");
    self notify("13f1a5e1119a91dc");
    self endon("13f1a5e1119a91dc");
    self endon(#"disconnect", #"entering_last_stand");
    s_result = self waittill(#"weapon_melee", #"weapon_melee_power");
    self notify(#"hash_14ed4d12ee0b5984");
    self.var_18aaed3b = 0;
}

/#

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 2, eflags: 0x0
    // Checksum 0xbde5c4da, Offset: 0xae10
    // Size: 0x4c
    function render_debug_sphere(origin, color) {
        sphere(origin, 2, color, 0.75, 1, 10, 100);
    }

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 2, eflags: 0x0
    // Checksum 0x71f376ae, Offset: 0xae68
    // Size: 0xb0
    function persistentdebugline(start, end) {
        level endon(#"hash_14400d2bff068132", #"newdebugline");
        self endon(#"hash_27a44c71de4b4cb8");
        level notify(#"newdebugline");
        for (;;) {
            line(start, end.origin, (0.3, 1, 0), 1);
            util::wait_network_frame();
        }
    }

#/

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x1f57c0b4, Offset: 0xaf20
// Size: 0x5e8
function function_beac8212() {
    level endon(#"hash_14400d2bff068132", #"intermission");
    n_time_started = gettime() / 1000;
    n_time_elapsed = 0;
    var_5d40fd37 = 0;
    var_7300d9f5 = 0;
    var_32cb5378 = 0;
    var_92f4e730 = 0;
    var_94e16ec6 = 0;
    var_b6aa254 = 0;
    /#
        iprintlnbold("<dev string:xdb>");
    #/
    foreach (player in level.players) {
    }
    level thread function_710dc967();
    self function_242c0311();
    self thread function_bf722d62();
    self function_f966c9c5(1);
    self clientfield::set("bs_att_blst_tll", 1);
    self thread function_466a8b97();
    self playsound("zmb_eyeball_swrath_charge");
    self thread scene::play(self.str_scene, "charge_blast", self);
    while (n_time_elapsed < 15) {
        n_time_current = gettime() / 1000;
        n_time_elapsed = n_time_current - n_time_started;
        util::wait_network_frame();
        n_time_left = 15 - n_time_elapsed;
        if (!var_5d40fd37 && n_time_left <= 12) {
            var_5d40fd37 = 1;
            /#
                iprintlnbold("<dev string:xe9>");
            #/
            function_321cceb4(level.var_f01a760b);
            continue;
        }
        if (!var_7300d9f5 && n_time_left <= 10) {
            var_7300d9f5 = 1;
            /#
                iprintlnbold("<dev string:x105>");
            #/
            continue;
        }
        if (!var_32cb5378 && n_time_left <= 5) {
            var_32cb5378 = 1;
            /#
                iprintlnbold("<dev string:x121>");
            #/
            function_321cceb4(level.var_f01a760b);
            continue;
        }
        if (!var_92f4e730 && n_time_left <= 3) {
            var_92f4e730 = 1;
            /#
                iprintlnbold("<dev string:x13c>");
            #/
            continue;
        }
        if (!var_94e16ec6 && n_time_left <= 2) {
            var_94e16ec6 = 1;
            /#
                iprintlnbold("<dev string:x157>");
            #/
            continue;
        }
        if (!var_b6aa254 && n_time_left <= 1) {
            var_b6aa254 = 1;
            /#
                iprintlnbold("<dev string:x172>");
            #/
        }
    }
    self clientfield::set("bs_att_blst", 1);
    level thread lui::screen_flash(0.1, 0.3, 0.7, 0.16, "white");
    self playsound("zmb_eyeball_swrath_burst");
    var_68ef1eda = 0;
    a_players = array::randomize(level.activeplayers);
    foreach (player in a_players) {
        if (!(isdefined(player.hasriotshieldequipped) && player.hasriotshieldequipped)) {
            player dodamage(player.health + 666, player.origin);
            continue;
        }
        if (!var_68ef1eda) {
            if (isdefined(player)) {
                player function_321cceb4(level.var_bf51a9ae);
                var_68ef1eda = 1;
            }
        }
    }
    level notify(#"hash_2e4b6b86e99b024b");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xda720194, Offset: 0xb510
// Size: 0x174
function function_710dc967() {
    level endon(#"intermission");
    level.e_boss endon(#"death");
    level waittill(#"hash_38f29f9cb03586ea", #"hash_14400d2bff068132", #"hash_2e4b6b86e99b024b");
    level.e_boss clientfield::set("bs_att_blst_tll", 0);
    exploder::exploder_stop("fxexp_boss_eye_fog_overflow_blast");
    exploder::exploder_stop("fxexp_boss_eye_fog_a");
    exploder::exploder_stop("fxexp_boss_eye_fog_b");
    exploder::exploder_stop("fxexp_boss_eye_fog_c");
    level.e_boss function_f966c9c5(0);
    level.e_boss animation::stop(0);
    level.e_boss stopsound("zmb_eyeball_swrath_charge");
    wait 1;
    level.e_boss clientfield::set("bs_att_blst", 0);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x24ab5028, Offset: 0xb690
// Size: 0xec
function function_466a8b97() {
    level endon(#"hash_38f29f9cb03586ea", #"hash_14400d2bff068132", #"hash_2e4b6b86e99b024b", #"intermission");
    level.e_boss endon(#"death");
    wait 4;
    exploder::exploder("fxexp_boss_eye_fog_overflow_blast");
    wait 0.5;
    exploder::exploder("fxexp_boss_eye_fog_a");
    wait 0.5;
    exploder::exploder("fxexp_boss_eye_fog_b");
    wait 0.5;
    exploder::exploder("fxexp_boss_eye_fog_c");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xcc9dd316, Offset: 0xb788
// Size: 0xf8
function function_fa8e1486() {
    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
    while (true) {
        level notify(#"hash_6986218d09dc1cb2");
        util::wait_network_frame(randomintrange(1, 3));
        level function_b0208d33();
        level notify(#"hash_6b642d0b24b9ee12");
        util::wait_network_frame(randomintrange(1, 3));
        level function_b0208d33();
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x3bee0862, Offset: 0xb888
// Size: 0x24
function function_b0208d33() {
    level flag::wait_till_clear(#"hash_21921ed511559aa3");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x1283117a, Offset: 0xb8b8
// Size: 0x4e8
function function_8b6dc9a9(var_f7e6d955) {
    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
    n_round = level.var_448a9237;
    n_max_active_ai = 18 + level.var_2b421938;
    level.var_da7c30dc = 0;
    level.var_b7c30473 = 0;
    wait 2;
    level thread function_35e53930();
    s_zone = level.players[0] zm_utility::get_current_zone(1);
    a_s_spawnpoints = struct::get_array(s_zone.name + "_spawns");
    a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(s_zone.name + "_spawner"), 0, 0);
    var_bcfdcb5c = getarraykeys(s_zone.adjacent_zones);
    foreach (str_zone in var_bcfdcb5c) {
        if (isdefined(s_zone.adjacent_zones[str_zone]) && s_zone.adjacent_zones[str_zone].is_connected) {
            a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawns"), 0, 0);
            a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawner"), 0, 0);
        }
    }
    if (isdefined(var_f7e6d955)) {
        foreach (str_zone in var_f7e6d955) {
            a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawns"), 0, 0);
            a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawner"), 0, 0);
        }
    }
    a_s_spawnpoints = array::filter(a_s_spawnpoints, 0, &function_9a0efad6);
    var_240c92d2 = array::randomize(a_s_spawnpoints);
    n_index = 0;
    while (true) {
        while (getaiteamarray(level.zombie_team).size >= n_max_active_ai) {
            util::wait_network_frame();
        }
        spawner = array::random(level.zombie_spawners);
        s_spawnpoint = var_240c92d2[n_index];
        if (n_index + 1 >= var_240c92d2.size) {
            n_index = 0;
        } else {
            n_index++;
        }
        var_84a0beb8 = level.var_b7c30473;
        level waittill(#"hash_6986218d09dc1cb2");
        e_zombie = zombie_utility::spawn_zombie(spawner, spawner.targetname, s_spawnpoint, n_round);
        if (isdefined(e_zombie)) {
            level.var_b7c30473++;
        }
        util::wait_network_frame();
    }
    level notify(#"hash_71fd67248b9a37ca");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x43ec8a36, Offset: 0xbda8
// Size: 0x60
function function_4d91933a(e_attacker) {
    if (self.archetype !== "zombie") {
        return;
    }
    if (!isplayer(e_attacker)) {
        return;
    }
    if (isdefined(self.var_3059fa07) && self.var_3059fa07) {
        return;
    }
    level.var_da7c30dc++;
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x9cf0654a, Offset: 0xbe10
// Size: 0xe4
function function_9a0efad6(s_loc) {
    if (!isdefined(s_loc.script_noteworthy)) {
        return false;
    }
    if (s_loc.script_noteworthy === "spawn_location") {
        return true;
    }
    a_str_tokens = strtok(s_loc.script_noteworthy, " ");
    foreach (str_token in a_str_tokens) {
        if (str_token == "custom_spawner_entry") {
            return true;
        }
    }
    return false;
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x57acf1ea, Offset: 0xbf00
// Size: 0x146
function boss_cleanup_zombie() {
    level endon(#"intermission");
    a_ai_zombies = getaiarchetypearray("zombie", level.zombie_team);
    foreach (ai in a_ai_zombies) {
        if (!isalive(ai) || zm_utility::is_magic_bullet_shield_enabled(ai) || isdefined(ai.var_3059fa07) && ai.var_3059fa07) {
            util::wait_network_frame();
            continue;
        }
        ai kill();
        ai hide();
        level.var_b7c30473--;
        return;
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x5d10120d, Offset: 0xc050
// Size: 0x1bc
function function_35e53930() {
    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"hash_71fd67248b9a37ca", #"intermission");
    wait 5;
    var_2ab019b7 = array(#"hash_7c89b1397a38e3ad", #"hash_7c89ae397a38de94", #"hash_7c89af397a38e047", #"hash_7c89ac397a38db2e");
    level.var_9871cdf5 = 0;
    var_7d30dcc = 4 + level.var_2b421938;
    while (true) {
        if (getaiteamarray(level.zombie_team).size > 0 && level.var_9871cdf5 / getaiteamarray(level.zombie_team).size * 100 < var_7d30dcc) {
            var_4fef5b74 = 1;
        } else {
            var_4fef5b74 = 0;
        }
        var_61189662 = array::random(var_2ab019b7);
        if (var_4fef5b74 && !zm_transform::function_5836d278(var_61189662)) {
            zm_transform::function_5dbbf742(var_61189662);
            level.var_da7c30dc--;
        }
        wait 2;
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xd358ee57, Offset: 0xc218
// Size: 0x74
function function_fa3a18b0(n_health) {
    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
    self.b_ignore_cleanup = 1;
    level.var_9871cdf5++;
    level thread function_adb57dd2(self);
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x5e175a26, Offset: 0xc298
// Size: 0x78
function function_adb57dd2(ai) {
    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
    ai waittill(#"death");
    if (isdefined(level.var_9871cdf5)) {
        level.var_9871cdf5--;
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 3, eflags: 0x0
// Checksum 0x7e395295, Offset: 0xc318
// Size: 0x67c
function function_f68d9309(var_2b51c313, var_5dfeb717 = 0, var_f7e6d955) {
    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
    n_round = level.var_448a9237;
    var_7e3594be = 0;
    var_9d65d1da = 0;
    a_stokers = [];
    var_3285bc9e = int(ceil(var_2b51c313 + var_2b51c313 * 0.4 * level.var_2b421938));
    var_b4fcee85 = var_3285bc9e;
    n_max_active_ai = 18 + level.var_2b421938;
    var_f46b3adf = level.var_2b421938 + 1;
    ai_stoker = undefined;
    s_zone = level.players[0] zm_utility::get_current_zone(1);
    var_a5b6d3fe = struct::get_array(s_zone.name + "_spawns");
    var_a5b6d3fe = arraycombine(var_a5b6d3fe, struct::get_array(s_zone.name + "_spawner"), 0, 0);
    var_bcfdcb5c = getarraykeys(s_zone.adjacent_zones);
    foreach (str_zone in var_bcfdcb5c) {
        if (isdefined(s_zone.adjacent_zones[str_zone]) && s_zone.adjacent_zones[str_zone].is_connected) {
            var_a5b6d3fe = arraycombine(var_a5b6d3fe, struct::get_array(str_zone + "_spawns"), 0, 0);
            var_a5b6d3fe = arraycombine(var_a5b6d3fe, struct::get_array(str_zone + "_spawner"), 0, 0);
        }
    }
    if (isdefined(var_f7e6d955)) {
        foreach (str_zone in var_f7e6d955) {
            var_a5b6d3fe = arraycombine(var_a5b6d3fe, struct::get_array(str_zone + "_spawns"), 0, 0);
            var_a5b6d3fe = arraycombine(var_a5b6d3fe, struct::get_array(str_zone + "_spawner"), 0, 0);
        }
    }
    var_a5b6d3fe = array::filter(var_a5b6d3fe, 0, &function_b4e70c02);
    while (var_5dfeb717 == 0 || var_7e3594be < var_5dfeb717) {
        if (level.var_da7c30dc < var_b4fcee85) {
            util::wait_network_frame(5);
            continue;
        }
        var_a5b6d3fe = array::randomize(var_a5b6d3fe);
        var_45fc54f3 = 0;
        var_b4fcee85 += var_3285bc9e;
        while (a_stokers.size < var_f46b3adf) {
            while (!isdefined(ai_stoker)) {
                level waittill(#"hash_6b642d0b24b9ee12");
                ai_stoker = zm_ai_stoker::spawn_single(1, var_a5b6d3fe[var_45fc54f3], n_round);
            }
            if (!isdefined(a_stokers)) {
                a_stokers = [];
            } else if (!isarray(a_stokers)) {
                a_stokers = array(a_stokers);
            }
            a_stokers[a_stokers.size] = ai_stoker;
            var_9d65d1da++;
            while (getaiteamarray(level.zombie_team).size >= n_max_active_ai) {
                util::wait_network_frame();
                level boss_cleanup_zombie();
            }
            wait randomfloatrange(2, 4);
            ai_stoker = undefined;
            var_45fc54f3++;
        }
        function_526005d6(a_stokers, 0);
        if (a_stokers.size) {
            array::wait_till(a_stokers, "death");
        }
        function_526005d6(a_stokers, 0);
        if (a_stokers.size) {
            array::wait_till(a_stokers, "death");
        }
        if (var_5dfeb717 > 0) {
            var_7e3594be++;
            if (var_7e3594be >= var_5dfeb717) {
                break;
            }
        }
    }
    function_7651702d("stoker");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xbb54f744, Offset: 0xc9a0
// Size: 0x40
function function_b4e70c02(s_loc) {
    if (!isdefined(s_loc.script_noteworthy)) {
        return false;
    }
    if (s_loc.script_noteworthy === "stoker_location") {
        return true;
    }
    return false;
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0x2233c7d0, Offset: 0xc9e8
// Size: 0x21c
function function_cfabbf90(var_18fb265f, var_d8ad3e1e) {
    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
    var_e123b0c4 = struct::get_array(#"blightfather_spawn");
    var_d63b6b71 = level.var_2b421938;
    ai_blightfather = undefined;
    for (var_f58fcad5 = 0; var_f58fcad5 < var_d8ad3e1e; var_f58fcad5++) {
        wait randomfloatrange(20, 25);
        var_6876a33 = level.var_b7c30473 + var_18fb265f;
        while (level.var_b7c30473 <= var_6876a33) {
            util::wait_network_frame(2);
        }
        var_2ca64d96 = 0;
        while (var_2ca64d96 < var_d63b6b71) {
            zm_transform::function_5dbbf742(#"hash_9ecf8085fb7a68f");
            var_2ca64d96++;
            wait randomfloatrange(15, 20);
        }
        while (level.var_deb579ca[#"hash_9ecf8085fb7a68f"].var_39491bdc > 0) {
            util::wait_network_frame(2);
        }
        do {
            wait 2;
            a_ai_blightfather = getaiarchetypearray("blight_father");
        } while (a_ai_blightfather.size > 0);
    }
    function_7651702d("blight_father");
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x30c84fd4, Offset: 0xcc10
// Size: 0x270
function function_a654ab6b(var_18fb265f) {
    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
    var_e123b0c4 = struct::get_array(#"blightfather_spawn");
    var_d63b6b71 = level.var_2b421938;
    ai_blightfather = undefined;
    while (true) {
        wait randomfloatrange(20, 25);
        var_6876a33 = level.var_b7c30473 + var_18fb265f;
        while (level.var_b7c30473 <= var_6876a33) {
            util::wait_network_frame(2);
        }
        var_2ca64d96 = 0;
        while (var_2ca64d96 < var_d63b6b71) {
            zm_transform::function_5dbbf742(#"hash_9ecf8085fb7a68f");
            var_2ca64d96++;
            wait randomfloatrange(15, 20);
        }
        while (level.var_deb579ca[#"hash_9ecf8085fb7a68f"].var_39491bdc > 0) {
            wait 0.2;
        }
        a_ai_blightfather = getaiarchetypearray("blight_father");
        var_99ce6d32 = a_ai_blightfather.size;
        while (var_99ce6d32 > 0) {
            foreach (ai_blightfather in a_ai_blightfather) {
                if (!isalive(ai_blightfather)) {
                    var_99ce6d32--;
                }
            }
            wait 0.2;
        }
        util::wait_network_frame();
    }
}

// Namespace zodt8_eye/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x4e32e09, Offset: 0xce88
// Size: 0x11e
function function_7651702d(str_archetype) {
    level endon(#"intermission");
    util::delay_notify(600, #"hash_20ba9a0874996fda");
    while (true) {
        wait 0.5;
        b_wait = 0;
        a_ai = getaiarchetypearray(str_archetype);
        foreach (ai in a_ai) {
            if (isalive(ai)) {
                b_wait = 1;
                break;
            }
        }
        if (!b_wait) {
            level notify(#"hash_3a4456148ade383a");
            return;
        }
    }
}

/#

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 0, eflags: 0x0
    // Checksum 0x24adff58, Offset: 0xcfb0
    // Size: 0x1a4
    function function_91912a79() {
        if (!getdvarint(#"zm_debug_ee", 0)) {
            return;
        }
        zm_devgui::add_custom_devgui_callback(&function_60166ecf);
        adddebugcommand("<dev string:x18c>");
        adddebugcommand("<dev string:x1cb>");
        adddebugcommand("<dev string:x21c>");
        adddebugcommand("<dev string:x26d>");
        adddebugcommand("<dev string:x2be>");
        adddebugcommand("<dev string:x30f>");
        adddebugcommand("<dev string:x36d>");
        adddebugcommand("<dev string:x3bd>");
        adddebugcommand("<dev string:x40c>");
        adddebugcommand("<dev string:x45f>");
        adddebugcommand("<dev string:x4b1>");
        adddebugcommand("<dev string:x507>");
        adddebugcommand("<dev string:x55b>");
        adddebugcommand("<dev string:x5af>");
    }

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 1, eflags: 0x0
    // Checksum 0xc0472433, Offset: 0xd160
    // Size: 0x322
    function function_60166ecf(cmd) {
        switch (cmd) {
        case #"start_bf":
            level thread function_2428ea1c();
            return 1;
        case #"hash_1774efff8d070e0d":
            level thread function_2428ea1c(1);
            return 1;
        case #"hash_1774eeff8d070c5a":
            level thread function_2428ea1c(2);
            return 1;
        case #"hash_1774e9ff8d0703db":
            level thread function_2428ea1c(3);
            return 1;
        case #"hash_1774e8ff8d070228":
            level thread function_2428ea1c(4);
            return 1;
        case #"hash_56b003484b719b01":
            level.e_boss thread function_633e9d9b();
            return 1;
        case #"do_mst":
            level.e_boss thread function_edcf2e1();
            return 1;
        case #"do_bm":
            level.e_boss thread function_e2a2057c();
            return 1;
        case #"do_combo":
            level.e_boss thread function_685cf3ef();
            return 1;
        case #"do_blst":
            level.e_boss thread function_c4e0d808();
            return 1;
        case #"hash_42e3fa83d357e8e0":
            level.e_boss function_52d99647(#"hash_5cb4b66f5c4d8a30", #"hash_20f13c444f27a214");
            return 1;
        case #"hash_42e3fd83d357edf9":
            level.e_boss function_52d99647(#"hash_5cb4b96f5c4d8f49", #"hash_4b99d4a70e2e9bb");
            return 1;
        case #"hash_42e3fc83d357ec46":
            level.e_boss function_52d99647(#"hash_5cb4b86f5c4d8d96", #"hash_3d6484e94dfc2a6a");
            return 1;
        case #"hash_5dad3801740fa24a":
            level notify(#"hash_38f29f9cb03586ea");
            return 1;
        }
    }

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 1, eflags: 0x0
    // Checksum 0xd0e06be6, Offset: 0xd490
    // Size: 0xf4
    function function_2428ea1c(var_cd1389e4) {
        zm_devgui::zombie_devgui_open_sesame();
        if (!flag::get("<dev string:x607>")) {
            level.s_pap_quest.var_d6c419fd = 0;
            level flag::set("<dev string:x607>");
        }
        if (isdefined(var_cd1389e4)) {
            level._ee[#"boss_fight"].skip_to_step = var_cd1389e4;
        }
        zm_sq::start(#"boss_fight");
        level waittill(#"hash_fbdf766a8b47229");
        if (!isdefined(var_cd1389e4)) {
            level boss_teleport_players("<dev string:x61a>");
        }
    }

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 0, eflags: 0x0
    // Checksum 0xbf0deede, Offset: 0xd590
    // Size: 0xdc
    function function_633e9d9b() {
        if (isdefined(level.var_61e1b83d) && level.var_61e1b83d) {
            return;
        }
        self function_bf336979();
        var_759b553c = [];
        n_rand = randomint(self.var_8121f810.size);
        var_759b553c = self.var_8121f810[n_rand];
        var_b2165e30 = var_759b553c[0].script_int;
        util::wait_network_frame();
        self boss_move(var_b2165e30);
        self function_f57bfd14();
    }

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 0, eflags: 0x0
    // Checksum 0xf2f39267, Offset: 0xd678
    // Size: 0x6c
    function function_edcf2e1() {
        if (isdefined(level.var_61e1b83d) && level.var_61e1b83d) {
            return;
        }
        self function_bf336979();
        self function_81f2410d();
        self function_f57bfd14();
    }

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 0, eflags: 0x0
    // Checksum 0xb3ec00e1, Offset: 0xd6f0
    // Size: 0x6c
    function function_e2a2057c() {
        if (isdefined(level.var_61e1b83d) && level.var_61e1b83d) {
            return;
        }
        self function_bf336979();
        self function_4ed10ef9();
        self function_f57bfd14();
    }

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 0, eflags: 0x0
    // Checksum 0xfe986d6d, Offset: 0xd768
    // Size: 0x6c
    function function_685cf3ef() {
        if (isdefined(level.var_61e1b83d) && level.var_61e1b83d) {
            return;
        }
        self function_bf336979();
        self function_338fe30e();
        self function_f57bfd14();
    }

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 0, eflags: 0x0
    // Checksum 0xbc0820fa, Offset: 0xd7e0
    // Size: 0x74
    function function_c4e0d808() {
        if (isdefined(level.var_61e1b83d) && level.var_61e1b83d) {
            return;
        }
        self function_bf336979(1);
        self function_beac8212();
        self function_f57bfd14();
    }

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 1, eflags: 0x0
    // Checksum 0x3d9f78aa, Offset: 0xd860
    // Size: 0x204
    function function_bf336979(var_778dfaec) {
        if (!isdefined(var_778dfaec)) {
            var_778dfaec = 0;
        }
        /#
            iprintlnbold("<dev string:x61d>");
        #/
        level.var_61e1b83d = 1;
        if (!isdefined(self.var_10953062)) {
            self function_c2d5e80c("<dev string:x61a>");
        }
        if (!isdefined(self.var_eeeab0ec)) {
            self function_9633343c("<dev string:x61a>");
        }
        if (!isdefined(self.var_8121f810)) {
            self function_52f97210("<dev string:x61a>");
        }
        if (!isdefined(self.var_a66005e4)) {
            self.var_a66005e4 = -1;
        }
        if (!isdefined(self.var_32ab136b)) {
            self.var_32ab136b = 1000;
        }
        if (!isdefined(self.var_5b81e49e)) {
            self.var_5b81e49e = 1000;
        }
        if (!isdefined(self.var_3dd7a7ad)) {
            self.var_3dd7a7ad = 0;
        }
        if (!isdefined(self.str_scene)) {
            self function_52d99647(#"hash_5cb4b66f5c4d8a30", #"hash_20f13c444f27a214");
        }
        level clientfield::set("<dev string:x634>", 1);
        util::wait_network_frame();
        self function_242c0311();
        util::wait_network_frame();
        self function_f966c9c5(0);
        wait 4;
        if (!var_778dfaec) {
            self function_e35fbd95();
        }
    }

    // Namespace zodt8_eye/zm_zodt8_eye
    // Params 0, eflags: 0x0
    // Checksum 0xe61a164c, Offset: 0xda70
    // Size: 0xdc
    function function_f57bfd14() {
        self function_f966c9c5(0);
        wait 2;
        self function_242c0311();
        wait 3;
        self boss_leave();
        self.origin = (0, 0, 0);
        self.angles = (0, 0, 0);
        self boss_arrive();
        level.var_61e1b83d = 0;
        level clientfield::set("<dev string:x634>", 0);
        /#
            iprintlnbold("<dev string:x644>");
        #/
    }

#/
