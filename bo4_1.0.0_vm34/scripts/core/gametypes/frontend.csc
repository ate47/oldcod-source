#using scripts\core\gametypes\frontend_draft;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\character_customization;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\custom_class;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapon_customization_icon;
#using scripts\mp_common\devgui;

#namespace frontend;

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x1a26b5f5, Offset: 0xe40
// Size: 0x9e
function function_5241dd9e(var_312d7285, mode) {
    var_62c33e14 = getplayerroletemplatecount(mode);
    for (i = 0; i < var_62c33e14; i++) {
        var_2bc575bc = function_b9650e7f(i, mode);
        if (isdefined(var_2bc575bc) && var_2bc575bc == var_312d7285) {
            return i;
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x10184100, Offset: 0xee8
// Size: 0x52
function function_10aa245(var_914fe276, var_93860d34 = 0) {
    if (!isdefined(var_914fe276)) {
        return undefined;
    }
    switch (var_93860d34) {
    case 1:
        return var_914fe276.arenalobbyscenes;
    case 0:
    default:
        return var_914fe276.lobbyscenes;
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x376e08e3, Offset: 0xf80
// Size: 0xb8
function function_d2bcc303(character_index, session_mode) {
    if (session_mode == 4) {
        return false;
    }
    if (!function_fab05cb7(character_index, session_mode)) {
        return false;
    }
    fields = getcharacterfields(character_index, session_mode);
    if (!isdefined(fields)) {
        return false;
    }
    scenes = function_10aa245(fields, session_mode);
    if (!isdefined(scenes) || scenes.size == 0) {
        return false;
    }
    return true;
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x1a1fa961, Offset: 0x1040
// Size: 0x1f8
function function_7784420f(xuid, session_mode) {
    if (!isdefined(level.var_cfcb4080)) {
        level.var_cfcb4080 = [];
    }
    character_index = undefined;
    if (function_be0f36e(xuid) && level.var_dc72aa65[level.var_47f97253].mode == session_mode && function_d2bcc303(level.var_dc72aa65[level.var_47f97253].role_index, session_mode)) {
        character_index = level.var_dc72aa65[level.var_47f97253].role_index;
    } else if (isdefined(level.var_cfcb4080[xuid])) {
        character_index = level.var_cfcb4080[xuid];
    } else {
        var_62c33e14 = getplayerroletemplatecount(session_mode);
        attempts = 0;
        while (true) {
            character_index = randomint(var_62c33e14);
            if (function_d2bcc303(character_index, session_mode)) {
                break;
            }
            attempts++;
            if (attempts > 3) {
                character_index = undefined;
                for (ci = 0; ci < var_62c33e14; ci++) {
                    if (function_d2bcc303(ci, session_mode)) {
                        character_index = ci;
                        break;
                    }
                }
                break;
            }
        }
    }
    level.var_cfcb4080[xuid] = character_index;
    return level.var_cfcb4080[xuid];
}

// Namespace frontend/frontend
// Params 4, eflags: 0x0
// Checksum 0xefd7fb3d, Offset: 0x1240
// Size: 0x17a
function function_5358fd8a(scene_name, prt, mode, fields) {
    var_45910e43 = function_5241dd9e(prt, mode);
    if (isdefined(var_45910e43)) {
        var_67ecabcd = {#scene:scene_name, #prt:prt, #var_3620f1e9:!(isdefined(fields.var_c3458f20) && fields.var_c3458f20), #role_index:var_45910e43, #list_index:level.var_dc72aa65.size, #mode:mode, #fields:fields};
        if (!isdefined(level.var_dc72aa65)) {
            level.var_dc72aa65 = [];
        } else if (!isarray(level.var_dc72aa65)) {
            level.var_dc72aa65 = array(level.var_dc72aa65);
        }
        level.var_dc72aa65[level.var_dc72aa65.size] = var_67ecabcd;
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x920f44e0, Offset: 0x13c8
// Size: 0x10e
function function_62b584b1(mode) {
    for (index = 0; index < getplayerroletemplatecount(mode); index++) {
        fields = getcharacterfields(index, mode);
        if (isdefined(fields) && isdefined(fields.var_addf9725)) {
            scene_def = struct::get_script_bundle("scene", fields.var_addf9725);
            if (isdefined(scene_def)) {
                var_66d06440 = function_b9650e7f(index, mode);
                /#
                    var_66d06440 = function_15979fa9(var_66d06440);
                #/
                function_5358fd8a(fields.var_addf9725, var_66d06440, mode, fields);
            }
        }
    }
}

// Namespace frontend/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x3c3f630d, Offset: 0x14e0
// Size: 0x18c
function event_handler[gametype_init] main(eventstruct) {
    draft::init();
    level.callbackentityspawned = &entityspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.orbis = getdvarstring(#"orbisgame") == "true";
    level.durango = getdvarstring(#"durangogame") == "true";
    customclass::init();
    clientfield::register("scriptmover", "dni_eyes", 1, 1, "int", &dni_eyes, 0, 0);
    level.var_dc72aa65 = array();
    function_62b584b1(1);
    function_62b584b1(0);
    level thread blackscreen_watcher();
    setstreamerrequest(1, "core_frontend");
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xae6af769, Offset: 0x1678
// Size: 0x1c70
function setupclientmenus(localclientnum) {
    lui::initmenudata(localclientnum);
    lui::createcustomcameramenu("Main", localclientnum, &lobby_main, 1, undefined, &function_19a46ac6);
    lui::createcustomcameramenu("LobbyInspection", localclientnum, &handle_inspect_player, 0, &start_character_rotating_any, &end_character_rotating_any);
    lui::linktocustomcharacter("LobbyInspection", localclientnum, "inspection_character");
    lui::createcustomcameramenu("SinglePlayerInspection", localclientnum, &handle_inspect_player, 0, &start_character_rotating_any, &end_character_rotating_any);
    lui::linktocustomcharacter("SinglePlayerInspection", localclientnum, "inspection_character");
    lui::createcustomcameramenu("ChooseTaunts", localclientnum, &choose_taunts_camera_watch, 0);
    lui::addmenuexploders("ChooseTaunts", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("ChooseTaunts", localclientnum, "character_customization");
    lui::createcameramenu("ChooseFaction", localclientnum, "spawn_char_custom", "ui_cam_character_customization", "cam_helmet", undefined, undefined, undefined, 1000);
    lui::createcustomcameramenu("Paintshop", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("Paintshop", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("Gunsmith", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("Gunsmith", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("Community", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("Community", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_Paintjobs", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_Paintjobs", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_Variants", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_Variants", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_Emblems", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_Emblems", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_CategorySelector", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_CategorySelector", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("GroupHeadquarters", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("GroupHeadquarters", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MediaManager", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MediaManager", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcameramenu("WeaponBuildKits", localclientnum, "zm_weapon_position", "ui_cam_cac_specialist", "cam_specialist", undefined, undefined, undefined);
    lui::addmenuexploders("WeaponBuildKits", localclientnum, array("zm_weapon_kick", "zm_weapon_room"));
    lui::createcameramenu("CombatRecordWeaponsZM", localclientnum, "zm_weapon_position", "ui_cam_cac_specialist", "cam_specialist", undefined, undefined, undefined);
    lui::addmenuexploders("CombatRecordWeaponsZM", localclientnum, array("zm_weapon_kick", "zm_weapon_room"));
    lui::createcameramenu("BubblegumBuffs", localclientnum, "loadout_camera", "c_fe_zm_megachew_vign_camera_2", "c_fe_zm_megachew_vign_camera_2", undefined, undefined, undefined);
    lui::addmenuexploders("BubblegumBuffs", localclientnum, array("zm_gum_kick", "zm_gum_room", "zm_gumball_room_2"));
    lui::createcameramenu("BubblegumPacks", localclientnum, "loadout_camera", "c_fe_zm_megachew_vign_camera_2", "c_fe_zm_megachew_vign_camera_2");
    lui::addmenuexploders("BubblegumPacks", localclientnum, array("zm_gum_kick", "zm_gum_room", "zm_gumball_room_2"));
    lui::createcustomcameramenu("BubblegumPackEdit", localclientnum, undefined, undefined, undefined, undefined);
    lui::addmenuexploders("BubblegumPackEdit", localclientnum, array("zm_weapon_kick", "zm_weapon_room", "zm_gumball_room_3"));
    lui::createcustomcameramenu("BubblegumBuffSelect", localclientnum, undefined, undefined, undefined, undefined);
    lui::addmenuexploders("BubblegumBuffSelect", localclientnum, array("zm_weapon_kick", "zm_weapon_room", "zm_gumball_room_3"));
    lui::createcustomcameramenu("CombatRecordBubblegumBuffs", localclientnum, undefined, undefined, undefined, undefined);
    lui::addmenuexploders("CombatRecordBubblegumBuffs", localclientnum, array("zm_weapon_kick", "zm_weapon_room", "zm_gumball_room_3"));
    lui::createcameramenu("MegaChewFactory", localclientnum, "zm_gum_position", "c_fe_zm_megachew_vign_camera", "default", undefined, undefined, undefined);
    lui::addmenuexploders("MegaChewFactory", localclientnum, array("zm_gum_kick", "zm_gum_room"));
    lui::createcustomcameramenu("Pregame_Main", localclientnum, &lobby_main, 1);
    lui::createcameramenu("BlackMarket", localclientnum, "mp_frontend_blackmarket", "ui_cam_frontend_blackmarket", "cam_mpmain", undefined, &function_2c510839, &function_68a00f67);
    lui::createcustomcameramenu("CombatRecordWeapons", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("CombatRecordWeapons", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("CombatRecordEquipment", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("CombatRecordEquipment", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("CombatRecordCybercore", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("CombatRecordCybercore", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("CombatRecordCollectibles", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("CombatRecordCollectibles", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcameramenu("CombatRecordSpecialists", localclientnum, "spawn_char_cac_choose", "ui_cam_cac_specialist", "cam_specialist", undefined, &open_choose_class, &close_choose_class);
    lui::addmenuexploders("CombatRecordSpecialists", localclientnum, array("char_customization", "lights_paintshop", "weapon_kick", "char_custom_bg"));
    lui::linktocustomcharacter("CombatRecordSpecialists", localclientnum, "character_customization");
    if (getdvarint(#"ui_enablecacscene", 0) != 0) {
        lui::createcustomcameramenu("DirectorLoadouts", localclientnum, &function_a9e98345, 0, undefined, &function_ec2a050c);
    } else {
        lui::createcameramenu("MPCustomizeClassMenu", localclientnum, "cac_specialist_angle", "ui_cam_loadout_character", "");
        lui::addmenuexploders("MPCustomizeClassMenu", localclientnum, array("fxexp_loadouts"));
    }
    lui::createcustomcameramenu("AAR_T8_MP", localclientnum, &function_d7ec80eb, 1, undefined, &function_a2179c92);
    lui::linktocustomcharacter("AAR_T8_MP", localclientnum, "aar_character");
    lui::createcustomcameramenu("AAR_T8_WZ", localclientnum, &function_d7ec80eb, 1, undefined, &function_a2179c92);
    lui::linktocustomcharacter("AAR_T8_WZ", localclientnum, "aar_character");
    lui::createcameramenu("Social_Main", localclientnum, "tag_align_frontend_background", "ui_scene_cam_background");
    lui::createcameramenu("SupportSelection", localclientnum, "tag_align_frontend_background", "ui_scene_cam_background");
    lui::createcameramenu("MPSpecialistHUB", localclientnum, "tag_align_frontend_background", "ui_scene_cam_background");
    lui::createcameramenu("MPSpecialistHUBWeapons", localclientnum, "tag_align_frontend_background", "ui_scene_cam_background");
    lui::createcameramenu("EmblemSelect", localclientnum, "tag_align_frontend_background", "ui_scene_cam_background");
    lui::createcameramenu("Store", localclientnum, "tag_align_frontend_background", "ui_scene_cam_background");
    lui::createcameramenu("Store_DLC", localclientnum, "tag_align_frontend_background", "ui_scene_cam_background");
    lui::createcameramenu("DirectorFindGame", localclientnum, "tag_align_frontend_background", "ui_scene_cam_background");
    lui::createcustomcameramenu("MPSpecialistHUBInspect", localclientnum, &function_f626f96d, 1, &start_character_rotating, &end_character_rotating);
    lui::linktocustomcharacter("MPSpecialistHUBInspect", localclientnum, "specialist_customization");
    lui::createcustomcameramenu("PersonalizeCharacter", localclientnum, &function_ec5b5add, 1, &start_character_rotating, &end_character_rotating);
    lui::linktocustomcharacter("PersonalizeCharacter", localclientnum, "specialist_customization");
    lui::createcameramenu("MPSpecialistHUBGestures", localclientnum, "cac_specialist_angle", "ui_cam_loadout_character");
    lui::linktocustomcharacter("MPSpecialistHUBGestures", localclientnum, "specialist_customization");
    lui::createcameramenu("MPSpecialistHUBTags", localclientnum, "tag_align_frontend_background", "ui_scene_cam_background");
    scene::add_scene_func("scene_frontend_t8_zombies", &function_796822db, "init");
    scene::add_scene_func("scene_frontend_t8_zombies", &function_5eddae57, "play");
    level.var_adcca7fa = spawnstruct();
    level.var_adcca7fa.var_5b1ac1f4 = array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
    level.var_adcca7fa.var_c30bde32 = array("blue", "green", "grey", "orange", "purple", "white");
    level.var_adcca7fa.var_c94a6f4b = getent(localclientnum, "tube_liquid_01", "targetname");
    level.var_adcca7fa.var_57430010 = getent(localclientnum, "tube_liquid_02", "targetname");
    level.var_adcca7fa.var_7d457a79 = getent(localclientnum, "tube_liquid_03", "targetname");
    level.var_adcca7fa.var_3b51de86 = getent(localclientnum, "tube_liquid_04", "targetname");
    level.var_adcca7fa.var_a6c55f44 = array(#"p8_zm_elixir_aftertaste_ui", #"p8_zm_elixir_alchemical_antithesis_ui", #"p8_zm_elixir_always_done_swiftly_ui", #"p8_zm_elixir_anti_entrapment_ui", #"p8_zm_elixir_anywhere_but_here_ui", #"p8_zm_elixir_arsenal_accelerator_ui", #"p8_zm_elixir_blood_debt_ui", #"hash_1a7c490a566d667", #"p8_zm_elixir_burned_out_ui", #"p8_zm_elixir_cache_back_ui", #"hash_58b3b4e50c5ad8b5", #"p8_zm_elixir_ctrl_z_ui", #"hash_5e08e862c962617a", #"p8_zm_elixir_dead_of_nuclear_winter_ui", #"p8_zm_elixir_equip_mint_ui", #"p8_zm_elixir_extra_credit_ui", #"p8_zm_elixir_free_fire_ui", #"p8_zm_elixir_head_scan_ui", #"p8_zm_elixir_immolation_liquidation_ui", #"p8_zm_elixir_in_plain_sight_ui", #"p8_zm_elixir_join_the_party_ui", #"p8_zm_elixir_kill_joy_ui", #"p8_zm_elixir_licensed_contractor_ui", #"p8_zm_elixir_newtonian_negation_ui", #"p8_zm_elixir_now_you_see_me_ui", #"p8_zm_elixir_nowhere_but_there_ui", #"hash_65291a8ef0716ac6", #"p8_zm_elixir_point_drops_ui", #"p8_zm_elixir_pop_shocks_ui", #"p8_zm_elixir_power_keg_ui", #"hash_7b8c2e9a197a1cbb", #"p8_zm_elixir_shields_up_ui", #"p8_zm_elixir_stock_option_ui", #"p8_zm_elixir_sword_flay_ui", #"p8_zm_elixir_temporal_gift_ui", #"p8_zm_elixir_undead_man_walking_ui", #"p8_zm_elixir_wall_power_ui", #"p8_zm_elixir_wall_to_wall_savings_ui", #"p8_zm_elixir_whos_keeping_score_ui");
    scene::add_scene_func(#"p8_fxanim_core_frontend_zm_lab_bottles_bundle", &function_3ea8722b, "play");
    scene::add_scene_func(#"p8_fxanim_core_frontend_zm_lab_bottles_bundle", &function_358448d, "done");
    level.var_adcca7fa.a_str_talismans = array(#"p8_zm_talisman_box_guarantee_box_only", #"p8_zm_talisman_box_guarantee_lmg", #"hash_199da03ac6e12953", #"p8_zm_talisman_coagulant", #"p8_zm_talisman_extra_claymore", #"p8_zm_talisman_extra_frag", #"p8_zm_talisman_extra_mini_turret", #"p8_zm_talisman_extra_molotov", #"p8_zm_talisman_extra_semtex", #"p8_zm_talisman_hero_weapon_lvl3", #"p8_zm_talisman_impatient", #"p8_zm_talisman_pap_cost", #"p8_zm_talisman_perk_mod_single", #"hash_27dae06ec588c817", #"hash_27dae16ec588c9ca", #"hash_27dae26ec588cb7d", #"hash_27dadb6ec588bf98", #"p8_zm_talisman_perk_vapor_permanent_1", #"p8_zm_talisman_perk_vapor_permanent_2", #"p8_zm_talisman_perk_vapor_permanent_3", #"p8_zm_talisman_perk_vapor_permanent_4", #"hash_22e20f33489f2582", #"hash_22e20e33489f23cf", #"hash_22e20d33489f221c", #"hash_22e20c33489f2069", #"p8_zm_talisman_shield_durability_legendary", #"p8_zm_talisman_shield_durability_rare", #"p8_zm_talisman_shield_price", #"p8_zm_talisman_spec_weapon_duration", #"p8_zm_talisman_spec_weapon_lvl2", #"hash_14e3ae5974c15925", #"p8_zm_talisman_start_weapon_ar", #"p8_zm_talisman_start_weapon_lmg", #"p8_zm_talisman_start_weapon_monkey", #"p8_zm_talisman_start_weapon_smg");
    scene::add_scene_func(#"p8_fxanim_core_frontend_zm_lab_talisman_press_bundle", &function_1eff3080, "talisman_press_tease");
    scene::add_scene_func(#"p8_fxanim_core_frontend_zm_lab_talisman_press_bundle", &function_1eff3080, "talisman_press_create");
    scene::add_scene_func(#"p8_fxanim_core_frontend_zm_lab_talisman_press_bundle", &function_bd9f0302, "done");
    scene::add_scene_func(#"p8_fxanim_core_frontend_zm_lab_talisman_press_bundle", &function_bd9f0302, "stop");
    scene::add_scene_func(#"hash_1db0a73041154601", &function_521035d4, "mixer_idle", "mixer_idle");
    scene::add_scene_func(#"hash_1db0a73041154601", &function_521035d4, "mixer_activate", "mixer_activate");
    a_str_shots = scene::get_all_shot_names(#"p8_fxanim_core_frontend_zm_lab_centrifuge_bundle");
    foreach (str_shot in a_str_shots) {
        scene::add_scene_func(#"p8_fxanim_core_frontend_zm_lab_centrifuge_bundle", &function_9c0e0481, str_shot, str_shot);
    }
    a_str_shots = scene::get_all_shot_names(#"p8_fxanim_core_frontend_zm_lab_flask_globs_01_to_03_bundle");
    foreach (str_shot in a_str_shots) {
        scene::add_scene_func(#"p8_fxanim_core_frontend_zm_lab_flask_globs_01_to_03_bundle", &function_5d6f70b9, str_shot, str_shot);
    }
    a_str_shots = scene::get_all_shot_names(#"p8_fxanim_core_frontend_zm_lab_flask_globs_04_to_06_bundle");
    foreach (str_shot in a_str_shots) {
        scene::add_scene_func(#"p8_fxanim_core_frontend_zm_lab_flask_globs_04_to_06_bundle", &function_5d6f70b9, str_shot, str_shot);
    }
    a_str_shots = scene::get_all_shot_names(#"p8_fxanim_core_frontend_zm_lab_flask_globs_07_to_09_bundle");
    foreach (str_shot in a_str_shots) {
        scene::add_scene_func(#"p8_fxanim_core_frontend_zm_lab_flask_globs_07_to_09_bundle", &function_5d6f70b9, str_shot, str_shot);
    }
    a_str_shots = scene::get_all_shot_names(#"p8_fxanim_core_frontend_zm_lab_flask_globs_10_bundle");
    foreach (str_shot in a_str_shots) {
        scene::add_scene_func(#"p8_fxanim_core_frontend_zm_lab_flask_globs_10_bundle", &function_5d6f70b9, str_shot, str_shot);
    }
}

// Namespace frontend/frontend
// Params 7, eflags: 0x0
// Checksum 0x30150bc, Offset: 0x32f0
// Size: 0x8c
function dni_eyes(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, newval, 0, 0);
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x7022c5f3, Offset: 0x3388
// Size: 0x160
function blackscreen_watcher() {
    blackscreenuimodel = createuimodel(getglobaluimodel(), "hideWorldForStreamer");
    setuimodelvalue(blackscreenuimodel, 1);
    while (true) {
        waitresult = level waittill(#"streamer_change");
        var_5a840c8a = waitresult.var_5a840c8a;
        setuimodelvalue(blackscreenuimodel, 1);
        wait 0.1;
        while (true) {
            charready = 1;
            if (isdefined(var_5a840c8a)) {
                charready = [[ var_5a840c8a ]]->is_streamed();
            }
            sceneready = getstreamerrequestprogress(0) >= 100;
            if (charready && sceneready) {
                break;
            }
            wait 0.1;
        }
        setuimodelvalue(blackscreenuimodel, 0);
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x69b3a017, Offset: 0x34f0
// Size: 0x78
function streamer_change(hint, var_5a840c8a) {
    if (isdefined(hint)) {
        setstreamerrequest(0, hint);
    } else {
        clearstreamerrequest(0);
    }
    level notify(#"streamer_change", {#var_5a840c8a:var_5a840c8a});
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x173563e6, Offset: 0x3570
// Size: 0x120
function handle_inspect_player(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    level thread scene::play("scene_frontend_inspection_camera", "inspection_full");
    level thread function_ea7e6a46(menu_name, localclientnum);
    level thread function_7cd96625(localclientnum, menu_name);
    while (true) {
        waitresult = level waittill(#"inspect_player");
        assert(isdefined(waitresult.xuid));
        level update_inspection_character(localclientnum, waitresult.xuid, menu_name);
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xeb3c1a0f, Offset: 0x3698
// Size: 0x5c
function function_ea7e6a46(menu_name, localclientnum) {
    level waittill(menu_name + "_closed");
    level thread scene::stop("scene_frontend_inspection_camera");
    level.var_102967cc hide();
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x3473a7ed, Offset: 0x3700
// Size: 0x308
function update_inspection_character(localclientnum, xuid, menu_name) {
    self notify("72e681a97294ff44");
    self endon("72e681a97294ff44");
    var_5a840c8a = lui::getcharacterdataformenu(menu_name, localclientnum);
    var_52a60d51 = getcharactercustomizationforxuid(localclientnum, xuid);
    if (!isdefined(var_52a60d51)) {
        [[ var_5a840c8a ]]->function_abb62848(1);
        [[ var_5a840c8a ]]->function_43f376f0(1);
        params = spawnstruct();
        params.anim_name = #"pb_cac_main_lobby_idle";
        [[ var_5a840c8a ]]->update(params);
        for (iterations = 0; !isdefined(var_52a60d51) && iterations < 15; iterations++) {
            wait 1;
            var_52a60d51 = getcharactercustomizationforxuid(localclientnum, xuid);
        }
    }
    if (!isdefined(var_52a60d51) || !function_d2bcc303(var_52a60d51.charactertype, var_52a60d51.charactermode)) {
        session_mode = 1;
        character_index = function_7784420f(xuid, session_mode);
        if (isdefined(character_index)) {
            level.var_cfcb4080[xuid] = character_index;
            fields = getcharacterfields(character_index, session_mode);
        }
    } else {
        fields = getcharacterfields(var_52a60d51.charactertype, var_52a60d51.charactermode);
    }
    var_7ab7d6f2 = undefined;
    if (isdefined(fields)) {
        var_7ab7d6f2 = fields.var_c5bbe0ab;
    }
    if (isdefined(var_7ab7d6f2)) {
        [[ var_5a840c8a ]]->function_abb62848(0);
        [[ var_5a840c8a ]]->function_43f376f0(0);
        params = spawnstruct();
        params.scene = var_7ab7d6f2;
        if (isdefined(var_52a60d51)) {
            [[ var_5a840c8a ]]->function_1a1fd7cd(var_52a60d51);
        } else {
            [[ var_5a840c8a ]]->set_character_mode(session_mode);
            [[ var_5a840c8a ]]->set_character_index(character_index);
            [[ var_5a840c8a ]]->function_44330d1b();
        }
        [[ var_5a840c8a ]]->update(params);
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x875bdb15, Offset: 0x3a10
// Size: 0x110
function function_7cd96625(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    while (true) {
        waitresult = level waittill(#"hash_6d381d5ecca233c6");
        assert(isdefined(waitresult.weapon));
        assert(isdefined(waitresult.attachments));
        assert(isdefined(waitresult.camoindex));
        assert(isdefined(waitresult.paintjobslot));
        level function_67f3bfcc(localclientnum, waitresult, 1);
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xe96e592c, Offset: 0x3b28
// Size: 0x23c
function function_67f3bfcc(localclientnum, weaponinfo, should_update_weapon_options = 1) {
    newweaponstring = weaponinfo.weapon;
    var_d80099a1 = weaponinfo.attachments;
    current_weapon = getweapon(newweaponstring, strtok(var_d80099a1, "+"));
    if (isdefined(current_weapon) && isdefined(level.var_102967cc)) {
        level.var_102967cc show();
        level thread scene::stop("scene_frontend_inspection_weapon");
        wait 0.1;
        if (isdefined(current_weapon.frontendmodel)) {
            level.var_102967cc useweaponmodel(current_weapon, current_weapon.frontendmodel);
        } else {
            level.var_102967cc useweaponmodel(current_weapon);
        }
        if (should_update_weapon_options) {
            level.var_102967cc setweaponrenderoptions(weaponinfo.camoindex, 0, 0, 0, 0, 0);
        }
        level.var_102967cc.targetname = "customized_inspection_weapon";
        level.var_102967cc useanimtree("generic");
        level.var_102967cc animation::play(#"hash_3689442490c2e5dd", struct::get("tag_align_inspection_weapon1"));
        level thread scene::play("scene_frontend_inspection_weapon", "inspection_weapon_full");
        level.var_102967cc show();
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xd1ce5056, Offset: 0x3d70
// Size: 0x13e
function function_d113791d(localclientnum) {
    while (true) {
        waitresult = level waittill(#"hash_3e968760e0f9aa05");
        var_3e41c4fd = function_34a9827b(waitresult.mode, waitresult.character_index);
        if (isdefined(var_3e41c4fd) && level.var_25019003 != var_3e41c4fd) {
            if (isdefined(level.var_4dc241f2)) {
                function_5094c112(level.var_4dc241f2);
            }
            level.var_1df60f21 = 1;
            level.var_25019003 = var_3e41c4fd;
            level.var_4dc241f2 = level.var_dc72aa65[var_3e41c4fd].scene;
            forcestreambundle(level.var_4dc241f2, 8, 4);
            if (isdefined(waitresult.var_3825d85) && waitresult.var_3825d85) {
                level.var_47f97253 = var_3e41c4fd;
            }
        }
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xaa038a30, Offset: 0x3eb8
// Size: 0x58
function function_a8b0b007(localclientnum) {
    while (true) {
        waitresult = level waittill(#"hash_40011191172b036c");
        level thread function_a75951a6(localclientnum, waitresult);
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x1c0669f5, Offset: 0x3f18
// Size: 0x11c
function function_a75951a6(localclientnum, data) {
    level endon(#"disconnect");
    level endon(#"hash_40011191172b036c");
    if (data.index == -1) {
        data.index = level.var_47f97253;
    }
    if (level.var_25019003 != data.index) {
        if (isdefined(level.var_4dc241f2)) {
            level thread scene::stop(level.var_4dc241f2, 1);
        }
        level.var_4dc241f2 = level.var_dc72aa65[data.index].scene;
        level.var_25019003 = data.index;
        function_4177666a(localclientnum, 1, 1);
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xe716c1f3, Offset: 0x4040
// Size: 0xc
function entityspawned(localclientnum) {
    
}

/#

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0xa66c0762, Offset: 0x4058
    // Size: 0x20c
    function function_28e71d0d(localclientnum) {
        var_46fbf49a = "<dev string:x30>";
        var_9a0d3595 = -1;
        foreach (i, scene in level.var_dc72aa65) {
            var_97558a63 = var_46fbf49a + scene.prt;
            adddebugcommand(localclientnum, "<dev string:x41>" + var_97558a63 + "<dev string:x4e>" + i + "<dev string:x71>");
        }
        while (true) {
            wait 0.1;
            var_a7486375 = getdvarint(#"hash_563d2a49168a665c", -1);
            if (var_a7486375 != var_9a0d3595) {
                level.var_4dc241f2 = level.var_dc72aa65[var_a7486375].scene;
                level.var_25019003 = var_a7486375;
                level.var_47f97253 = var_a7486375;
                level thread function_4177666a(localclientnum, 1, 1);
                var_9a0d3595 = var_a7486375;
                if (level.var_dc72aa65[var_a7486375].scene == #"scene_frontend_zm_elixir_lab") {
                    level thread function_48bd3f9c();
                    continue;
                }
                level notify(#"hash_79bbc4f96a28b094");
            }
        }
    }

    // Namespace frontend/frontend
    // Params 0, eflags: 0x0
    // Checksum 0x25895967, Offset: 0x4270
    // Size: 0x1a8
    function function_48bd3f9c() {
        level notify(#"hash_79bbc4f96a28b094");
        level endoncallback(&function_e595b0f7, #"end_controller_pulse", #"hash_79bbc4f96a28b094");
        level scene::init(#"p8_fxanim_core_frontend_zm_lab_centrifuge_bundle");
        level scene::init(#"hash_1db0a73041154601");
        level scene::init(#"p8_fxanim_core_frontend_zm_lab_talisman_press_bundle");
        level thread scene::play(#"hash_1db0a73041154601", "<dev string:x74>");
        wait 3;
        while (true) {
            for (i = 0; i < 3; i++) {
                function_87b9b61c(array::random(level.var_adcca7fa.var_c30bde32), array::random(level.var_adcca7fa.var_5b1ac1f4));
                wait 4;
            }
            level.var_39790349 = 1;
            function_1f167cc1();
            level.var_39790349 = undefined;
            wait 3;
        }
    }

    // Namespace frontend/frontend
    // Params 0, eflags: 0x0
    // Checksum 0x60a0c4a, Offset: 0x4420
    // Size: 0x6b6
    function function_89e5af26() {
        self notify("<invalid>");
        self endon("<invalid>");
        level endon(#"end_controller_pulse", #"hash_79bbc4f96a28b094");
        while (true) {
            if (isdefined(level.var_39790349) && level.var_39790349) {
                debug2dtext((50, 140, 0), "<dev string:x90>", (1, 1, 1), 1, (0, 0, 0), 1, 1, 1);
            } else {
                debug2dtext((50, 140, 0), "<dev string:x99>", (1, 1, 1), 1, (0, 0, 0), 1, 1, 1);
            }
            debug2dtext((50, 160, 0), "<dev string:xaa>" + level.var_adcca7fa.var_678b8ffc, (1, 1, 1), 1, (0, 0, 0), 1, 1, 1);
            switch (level.var_adcca7fa.var_a6ec7315) {
            case #"blue":
                debug2dtext((50, 190, 0), "<dev string:xbc>" + level.var_adcca7fa.var_a6ec7315, (0, 0, 1), 1, (0, 0, 0), 1, 1, 1);
                break;
            case #"green":
                debug2dtext((50, 190, 0), "<dev string:xbc>" + level.var_adcca7fa.var_a6ec7315, (0, 1, 0), 1, (0, 0, 0), 1, 1, 1);
                break;
            case #"grey":
                debug2dtext((50, 190, 0), "<dev string:xbc>" + level.var_adcca7fa.var_a6ec7315, (0.75, 0.75, 0.75), 1, (0, 0, 0), 1, 1, 1);
                break;
            case #"orange":
                debug2dtext((50, 190, 0), "<dev string:xbc>" + level.var_adcca7fa.var_a6ec7315, (1, 0.5, 0), 1, (0, 0, 0), 1, 1, 1);
                break;
            case #"purple":
                debug2dtext((50, 190, 0), "<dev string:xbc>" + level.var_adcca7fa.var_a6ec7315, (1, 0, 1), 1, (0, 0, 0), 1, 1, 1);
                break;
            case #"white":
                debug2dtext((50, 190, 0), "<dev string:xbc>" + level.var_adcca7fa.var_a6ec7315, (1, 1, 1), 1, (0, 0, 0), 1, 1, 1);
                break;
            }
            debug2dtext((50, 210, 0), "<dev string:xc4>" + level.var_adcca7fa.var_afcde812, (1, 1, 1), 1, (0, 0, 0), 1, 1, 1);
            if (isdefined(level.var_39790349) && level.var_39790349) {
                var_9b6618f6 = isdefined(level.var_adcca7fa.var_efba2f7c) ? level.var_adcca7fa.var_efba2f7c : "<dev string:xd1>";
                var_75639e8d = isdefined(level.var_adcca7fa.var_61c19eb7) ? level.var_adcca7fa.var_61c19eb7 : "<dev string:xd1>";
                var_4f612424 = isdefined(level.var_adcca7fa.var_3bbf244e) ? level.var_adcca7fa.var_3bbf244e : "<dev string:xd1>";
                str_talisman = isdefined(level.var_adcca7fa.var_38f1ab0e) ? level.var_adcca7fa.var_38f1ab0e : "<dev string:xd1>";
                debug2dtext((50, 230, 0), "<dev string:xd2>" + function_15979fa9(var_9b6618f6), (1, 1, 1), 1, (0, 0, 0), 1, 1, 1);
                debug2dtext((50, 250, 0), "<dev string:xdc>" + function_15979fa9(var_75639e8d), (1, 1, 1), 1, (0, 0, 0), 1, 1, 1);
                debug2dtext((50, 270, 0), "<dev string:xe6>" + function_15979fa9(var_4f612424), (1, 1, 1), 1, (0, 0, 0), 1, 1, 1);
                debug2dtext((50, 290, 0), "<dev string:xf0>" + function_15979fa9(str_talisman), (1, 1, 1), 1, (0, 0, 0), 1, 1, 1);
            }
            waitframe(1);
        }
    }

#/

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x1e05505f, Offset: 0x4ae0
// Size: 0xc4
function function_e595b0f7(str_notify) {
    level scene::stop(#"p8_fxanim_core_frontend_zm_lab_centrifuge_bundle", 1);
    level scene::stop(#"hash_1db0a73041154601", 1);
    level scene::stop(#"p8_fxanim_core_frontend_zm_lab_talisman_press_bundle", 1);
    if (isdefined(level.var_adcca7fa.var_df78923e)) {
        level scene::stop(level.var_adcca7fa.var_df78923e, 1);
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xac17e7d3, Offset: 0x4bb0
// Size: 0x46c
function function_87b9b61c(var_a7ce86a3, var_ec5ef2d4) {
    level scene::stop(#"p8_fxanim_core_frontend_zm_lab_centrifuge_bundle");
    if (isdefined(level.var_adcca7fa.var_df78923e)) {
        level scene::stop(level.var_adcca7fa.var_df78923e, 1);
    }
    level.var_adcca7fa.var_a6ec7315 = var_a7ce86a3;
    level.var_adcca7fa.var_afcde812 = var_ec5ef2d4;
    level.var_adcca7fa.var_678b8ffc = "cent_show_" + var_a7ce86a3;
    switch (var_ec5ef2d4) {
    case 1:
        level.var_adcca7fa.var_df78923e = #"p8_fxanim_core_frontend_zm_lab_flask_globs_01_to_03_bundle";
        level.var_adcca7fa.var_9ecd55c8 = "state1";
        break;
    case 2:
        level.var_adcca7fa.var_df78923e = #"p8_fxanim_core_frontend_zm_lab_flask_globs_01_to_03_bundle";
        level.var_adcca7fa.var_9ecd55c8 = "state2";
        break;
    case 3:
        level.var_adcca7fa.var_df78923e = #"p8_fxanim_core_frontend_zm_lab_flask_globs_01_to_03_bundle";
        level.var_adcca7fa.var_9ecd55c8 = "state3";
        break;
    case 4:
        level.var_adcca7fa.var_df78923e = #"p8_fxanim_core_frontend_zm_lab_flask_globs_04_to_06_bundle";
        level.var_adcca7fa.var_9ecd55c8 = "state4";
        break;
    case 5:
        level.var_adcca7fa.var_df78923e = #"p8_fxanim_core_frontend_zm_lab_flask_globs_04_to_06_bundle";
        level.var_adcca7fa.var_9ecd55c8 = "state5";
        break;
    case 6:
        level.var_adcca7fa.var_df78923e = #"p8_fxanim_core_frontend_zm_lab_flask_globs_04_to_06_bundle";
        level.var_adcca7fa.var_9ecd55c8 = "state6";
        break;
    case 7:
        level.var_adcca7fa.var_df78923e = #"p8_fxanim_core_frontend_zm_lab_flask_globs_07_to_09_bundle";
        level.var_adcca7fa.var_9ecd55c8 = "state7";
        break;
    case 8:
        level.var_adcca7fa.var_df78923e = #"p8_fxanim_core_frontend_zm_lab_flask_globs_07_to_09_bundle";
        level.var_adcca7fa.var_9ecd55c8 = "state8";
        break;
    case 9:
        level.var_adcca7fa.var_df78923e = #"p8_fxanim_core_frontend_zm_lab_flask_globs_07_to_09_bundle";
        level.var_adcca7fa.var_9ecd55c8 = "state9";
        break;
    case 10:
        level.var_adcca7fa.var_df78923e = #"p8_fxanim_core_frontend_zm_lab_flask_globs_10_bundle";
        level.var_adcca7fa.var_9ecd55c8 = "state10";
        break;
    }
    level thread scene::play(#"p8_fxanim_core_frontend_zm_lab_centrifuge_bundle", level.var_adcca7fa.var_678b8ffc);
    level thread scene::play(level.var_adcca7fa.var_df78923e, level.var_adcca7fa.var_9ecd55c8 + "_idle");
    if (math::cointoss()) {
        level thread scene::play(#"p8_fxanim_core_frontend_zm_lab_talisman_press_bundle", "talisman_press_tease");
    }
    /#
        level thread function_89e5af26();
    #/
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x8808d6a4, Offset: 0x5028
// Size: 0x46
function function_edb6a74a(var_7c0ad10f) {
    level.var_adcca7fa.var_678b8ffc = "cent_spin_" + level.var_adcca7fa.var_a6ec7315;
    return level.var_adcca7fa.var_678b8ffc;
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xd6a146f5, Offset: 0x5078
// Size: 0x102a
function function_9a96560c(str_color, var_5a14e637 = 1, b_reverse = 0) {
    switch (level.var_adcca7fa.var_a6ec7315) {
    case #"blue":
        switch (var_5a14e637) {
        case 1:
            if (b_reverse) {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"hash_60ccae857beb8ae1");
            } else {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"hash_29a5ce73c6bf3ac");
            }
            break;
        case 2:
            if (b_reverse) {
                level.var_adcca7fa.var_57430010 setmodel(#"hash_11c83d817b60498c");
            } else {
                level.var_adcca7fa.var_57430010 setmodel(#"hash_4033d5fb1fadc119");
            }
            break;
        case 3:
            if (b_reverse) {
                level.var_adcca7fa.var_7d457a79 setmodel(#"hash_5ccd1678233c03af");
            } else {
                level.var_adcca7fa.var_7d457a79 setmodel(#"hash_52baaa23b54d34e6");
            }
            break;
        case 4:
            if (b_reverse) {
                level.var_adcca7fa.var_3b51de86 setmodel(#"hash_229a1cb6d3a4dc6a");
            } else {
                level.var_adcca7fa.var_3b51de86 setmodel(#"hash_6c58833a718fb41b");
            }
            break;
        case 5:
            if (b_reverse) {
                level.var_adcca7fa.var_a974a30e = #"hash_64ad50c7505f5115";
            } else {
                level.var_adcca7fa.var_a974a30e = #"hash_3393a3c72130d0e8";
            }
            break;
        }
        break;
    case #"green":
        switch (var_5a14e637) {
        case 1:
            if (b_reverse) {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"hash_46ed11b2404fdcd3");
            } else {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"hash_29a5ee73c6bf712");
            }
            break;
        case 2:
            if (b_reverse) {
                level.var_adcca7fa.var_57430010 setmodel(#"hash_5b48f45c2d56ed32");
            } else {
                level.var_adcca7fa.var_57430010 setmodel(#"hash_4033d3fb1fadbdb3");
            }
            break;
        case 3:
            if (b_reverse) {
                level.var_adcca7fa.var_7d457a79 setmodel(#"hash_7fbfb6545dc3031d");
            } else {
                level.var_adcca7fa.var_7d457a79 setmodel(#"hash_52baa823b54d3180");
            }
            break;
        case 4:
            if (b_reverse) {
                level.var_adcca7fa.var_3b51de86 setmodel(#"hash_215d65d10e60c0e4");
            } else {
                level.var_adcca7fa.var_3b51de86 setmodel(#"hash_6c58853a718fb781");
            }
            break;
        case 5:
            if (b_reverse) {
                level.var_adcca7fa.var_a974a30e = #"hash_79d12aeef148bc67";
            } else {
                level.var_adcca7fa.var_a974a30e = #"hash_3393a5c72130d44e";
            }
            break;
        }
        break;
    case #"grey":
        switch (var_5a14e637) {
        case 1:
            if (b_reverse) {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"hash_7aec5fc850532e52");
            } else {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"hash_29a59e73c6bee93");
            }
            break;
        case 2:
            if (b_reverse) {
                level.var_adcca7fa.var_57430010 setmodel(#"hash_7312841f03a5c9b3");
            } else {
                level.var_adcca7fa.var_57430010 setmodel(#"hash_4033d8fb1fadc632");
            }
            break;
        case 3:
            if (b_reverse) {
                level.var_adcca7fa.var_7d457a79 setmodel(#"hash_4f4e3fc18357f850");
            } else {
                level.var_adcca7fa.var_7d457a79 setmodel(#"hash_52baaf23b54d3d65");
            }
            break;
        case 4:
            if (b_reverse) {
                level.var_adcca7fa.var_3b51de86 setmodel(#"hash_7939ac2a29e69a99");
            } else {
                level.var_adcca7fa.var_3b51de86 setmodel(#"hash_6c58863a718fb934");
            }
            break;
        case 5:
            if (b_reverse) {
                level.var_adcca7fa.var_a974a30e = #"hash_39ee482beec4e0ae";
            } else {
                level.var_adcca7fa.var_a974a30e = #"hash_3393a8c72130d967";
            }
            break;
        }
        break;
    case #"orange":
        switch (var_5a14e637) {
        case 1:
            if (b_reverse) {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"hash_63405dc0a847d13d");
            } else {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"hash_29a58e73c6bece0");
            }
            break;
        case 2:
            if (b_reverse) {
                level.var_adcca7fa.var_57430010 setmodel(#"hash_65a17e506f52d2d0");
            } else {
                level.var_adcca7fa.var_57430010 setmodel(#"hash_4033d9fb1fadc7e5");
            }
            break;
        case 3:
            if (b_reverse) {
                level.var_adcca7fa.var_7d457a79 setmodel(#"hash_5cbf459017aaef33");
            } else {
                level.var_adcca7fa.var_7d457a79 setmodel(#"hash_52baae23b54d3bb2");
            }
            break;
        case 4:
            if (b_reverse) {
                level.var_adcca7fa.var_3b51de86 setmodel(#"hash_6e0875283eaef22e");
            } else {
                level.var_adcca7fa.var_3b51de86 setmodel(#"hash_6c58873a718fbae7");
            }
            break;
        case 5:
            if (b_reverse) {
                level.var_adcca7fa.var_a974a30e = #"hash_451f7f2dd9fc8919";
            } else {
                level.var_adcca7fa.var_a974a30e = #"hash_3393a7c72130d7b4";
            }
            break;
        }
        break;
    case #"purple":
        switch (var_5a14e637) {
        case 1:
            if (b_reverse) {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"hash_505ae05e4e559fb6");
            } else {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"hash_29a5de73c6bf55f");
            }
            break;
        case 2:
            if (b_reverse) {
                level.var_adcca7fa.var_57430010 setmodel(#"hash_732055070f36de2f");
            } else {
                level.var_adcca7fa.var_57430010 setmodel(#"hash_4033d4fb1fadbf66");
            }
            break;
        case 3:
            if (b_reverse) {
                level.var_adcca7fa.var_7d457a79 setmodel(#"hash_7b74fef28f656f0c");
            } else {
                level.var_adcca7fa.var_7d457a79 setmodel(#"hash_52baab23b54d3699");
            }
            break;
        case 4:
            if (b_reverse) {
                level.var_adcca7fa.var_3b51de86 setmodel(#"hash_18c77dc3a0496295");
            } else {
                level.var_adcca7fa.var_3b51de86 setmodel(#"hash_6c58823a718fb268");
            }
            break;
        case 5:
            if (b_reverse) {
                level.var_adcca7fa.var_a974a30e = #"hash_6e7fefba83bacaea";
            } else {
                level.var_adcca7fa.var_a974a30e = #"hash_3393a4c72130d29b";
            }
            break;
        }
        break;
    case #"white":
    default:
        switch (var_5a14e637) {
        case 1:
            if (b_reverse) {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"p8_zm_lab_tube_01_liquid_01_reverse");
            } else {
                level.var_adcca7fa.var_c94a6f4b setmodel(#"p8_zm_lab_tube_01_liquid_01");
            }
            break;
        case 2:
            if (b_reverse) {
                level.var_adcca7fa.var_57430010 setmodel(#"hash_70a7be98cc2dc041");
            } else {
                level.var_adcca7fa.var_57430010 setmodel(#"p8_zm_lab_tube_02_liquid_01");
            }
            break;
        case 3:
            if (b_reverse) {
                level.var_adcca7fa.var_7d457a79 setmodel(#"hash_409289ef3cbfab16");
            } else {
                level.var_adcca7fa.var_7d457a79 setmodel(#"p8_zm_lab_tube_03_liquid_01");
            }
            break;
        case 4:
            if (b_reverse) {
                level.var_adcca7fa.var_3b51de86 setmodel(#"hash_7fd651c3f31543eb");
            } else {
                level.var_adcca7fa.var_3b51de86 setmodel(#"p8_zm_lab_tube_04_liquid_01");
            }
            break;
        case 5:
            if (b_reverse) {
                level.var_adcca7fa.var_a974a30e = #"hash_42e91ba310a11808";
            } else {
                level.var_adcca7fa.var_a974a30e = #"hash_3393aac72130dccd";
            }
            break;
        }
        break;
    }
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x81e347df, Offset: 0x60b0
// Size: 0x554
function function_1f167cc1() {
    function_9a96560c(level.var_adcca7fa.var_678b8ffc, 1, 0);
    level.var_adcca7fa.var_c94a6f4b thread function_9af21180(#"hash_7a5f18ac9f947db6");
    util::delay(1, undefined, &function_9a96560c, level.var_adcca7fa.var_678b8ffc, 1, 1);
    level.var_adcca7fa.var_c94a6f4b util::delay(1, undefined, &function_9af21180, #"hash_280599d592def31f", 1);
    str_shot = function_edb6a74a(level.var_adcca7fa.var_678b8ffc);
    level scene::play(level.var_adcca7fa.var_df78923e, level.var_adcca7fa.var_9ecd55c8 + "_exit");
    level thread scene::play(#"p8_fxanim_core_frontend_zm_lab_centrifuge_bundle", str_shot);
    function_9a96560c(level.var_adcca7fa.var_678b8ffc, 2, 0);
    function_9a96560c(level.var_adcca7fa.var_678b8ffc, 3, 0);
    function_9a96560c(level.var_adcca7fa.var_678b8ffc, 4, 0);
    level.var_adcca7fa.var_57430010 util::delay(3, undefined, &function_9af21180, #"hash_7a5f17ac9f947c03");
    level.var_adcca7fa.var_7d457a79 util::delay(3, undefined, &function_9af21180, #"hash_7a5f16ac9f947a50");
    level.var_adcca7fa.var_3b51de86 util::delay(3, undefined, &function_9af21180, #"hash_7a5f1dac9f948635");
    util::delay(4, undefined, &function_9a96560c, level.var_adcca7fa.var_678b8ffc, 2, 1);
    util::delay(4, undefined, &function_9a96560c, level.var_adcca7fa.var_678b8ffc, 3, 1);
    util::delay(4, undefined, &function_9a96560c, level.var_adcca7fa.var_678b8ffc, 4, 1);
    level.var_adcca7fa.var_57430010 util::delay(6, undefined, &function_9af21180, #"hash_4a48a6b5570aa9e2", 1);
    level.var_adcca7fa.var_7d457a79 util::delay(6, undefined, &function_9af21180, #"hash_542e9d3c3064230d", 1);
    level.var_adcca7fa.var_3b51de86 util::delay(6, undefined, &function_9af21180, #"hash_ba484d5a33251c0", 1);
    wait 4;
    level util::delay(0.35, undefined, &scene::play, #"p8_fxanim_core_frontend_zm_lab_talisman_press_bundle", "talisman_press_create");
    level scene::play(#"hash_1db0a73041154601", "mixer_activate");
    level util::delay(#"hash_628ffcc3fa427e54", undefined, &scene::play, #"hash_1db0a73041154601", "mixer_idle");
    level scene::play(#"p8_fxanim_core_frontend_zm_lab_bottles_bundle");
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x4dfae3e8, Offset: 0x6610
// Size: 0x354
function function_1eff3080(localclientnum, a_ents) {
    if (isdefined(a_ents[#"talisman"].var_fbd9a2d8)) {
        a_ents[#"talisman"].var_fbd9a2d8 delete();
    }
    if (isdefined(a_ents[#"talisman"].var_3c6ff1f0)) {
        a_ents[#"talisman"].var_3c6ff1f0 delete();
    }
    a_ents[#"talisman"].var_fbd9a2d8 = util::spawn_model(localclientnum, "tag_origin", a_ents[#"talisman"] gettagorigin("link_talisman_ui_large_jnt"), a_ents[#"talisman"] gettagangles("link_talisman_ui_large_jnt"));
    a_ents[#"talisman"].var_3c6ff1f0 = util::spawn_model(localclientnum, "tag_origin", a_ents[#"talisman"] gettagorigin("link_talisman_ui_small_jnt"), a_ents[#"talisman"] gettagangles("link_talisman_ui_small_jnt"));
    a_ents[#"talisman"].var_fbd9a2d8 setscale(0.8);
    a_ents[#"talisman"].var_3c6ff1f0 setscale(0.5);
    a_ents[#"talisman"].var_fbd9a2d8 linkto(a_ents[#"talisman"], "link_talisman_ui_large_jnt");
    a_ents[#"talisman"].var_3c6ff1f0 linkto(a_ents[#"talisman"], "link_talisman_ui_small_jnt");
    level.var_adcca7fa.var_38f1ab0e = array::random(level.var_adcca7fa.a_str_talismans);
    a_ents[#"talisman"].var_fbd9a2d8 setmodel(level.var_adcca7fa.var_38f1ab0e);
    a_ents[#"talisman"].var_3c6ff1f0 setmodel(level.var_adcca7fa.var_38f1ab0e);
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x8d241239, Offset: 0x6970
// Size: 0xa4
function function_bd9f0302(localclientnum, a_ents) {
    if (isdefined(a_ents[#"talisman"].var_fbd9a2d8)) {
        a_ents[#"talisman"].var_fbd9a2d8 delete();
    }
    if (isdefined(a_ents[#"talisman"].var_3c6ff1f0)) {
        a_ents[#"talisman"].var_3c6ff1f0 delete();
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x23e27e94, Offset: 0x6a20
// Size: 0xcac
function function_3ea8722b(localclientnum, a_ents) {
    function_9a96560c(level.var_adcca7fa.var_678b8ffc, 5, 0);
    a_ents[#"bottle1"].mdl_bottle = util::spawn_model(localclientnum, "tag_origin", a_ents[#"bottle1"] gettagorigin("bottle_01_link_jnt"), a_ents[#"bottle1"] gettagangles("bottle_01_link_jnt"));
    a_ents[#"bottle1"].mdl_tube = util::spawn_model(localclientnum, level.var_adcca7fa.var_a974a30e, a_ents[#"bottle1"] gettagorigin("bottle_01_link_jnt"), a_ents[#"bottle1"] gettagangles("bottle_01_link_jnt"));
    a_ents[#"bottle1"].var_79488a88 = util::spawn_model(localclientnum, #"p8_zm_elixir_bottle_plain_sight_lid", a_ents[#"bottle1"] gettagorigin("bottlecap_01_link_jnt"), a_ents[#"bottle1"] gettagangles("bottlecap_01_link_jnt"));
    a_ents[#"bottle2"].mdl_bottle = util::spawn_model(localclientnum, "tag_origin", a_ents[#"bottle2"] gettagorigin("bottle_02_link_jnt"), a_ents[#"bottle2"] gettagangles("bottle_02_link_jnt"));
    a_ents[#"bottle2"].mdl_tube = util::spawn_model(localclientnum, level.var_adcca7fa.var_a974a30e, a_ents[#"bottle2"] gettagorigin("bottle_02_link_jnt"), a_ents[#"bottle2"] gettagangles("bottle_02_link_jnt"));
    a_ents[#"bottle2"].var_79488a88 = util::spawn_model(localclientnum, #"p8_zm_elixir_bottle_plain_sight_lid", a_ents[#"bottle2"] gettagorigin("bottlecap_02_link_jnt"), a_ents[#"bottle2"] gettagangles("bottlecap_02_link_jnt"));
    a_ents[#"bottle3"].mdl_bottle = util::spawn_model(localclientnum, "tag_origin", a_ents[#"bottle3"] gettagorigin("bottle_03_link_jnt"), a_ents[#"bottle3"] gettagangles("bottle_03_link_jnt"));
    a_ents[#"bottle3"].mdl_tube = util::spawn_model(localclientnum, level.var_adcca7fa.var_a974a30e, a_ents[#"bottle3"] gettagorigin("bottle_03_link_jnt"), a_ents[#"bottle3"] gettagangles("bottle_03_link_jnt"));
    a_ents[#"bottle3"].var_79488a88 = util::spawn_model(localclientnum, #"p8_zm_elixir_bottle_plain_sight_lid", a_ents[#"bottle3"] gettagorigin("bottlecap_03_link_jnt"), a_ents[#"bottle3"] gettagangles("bottlecap_03_link_jnt"));
    a_ents[#"bottle1"].mdl_bottle linkto(a_ents[#"bottle1"], "bottle_01_link_jnt");
    a_ents[#"bottle2"].mdl_bottle linkto(a_ents[#"bottle2"], "bottle_02_link_jnt");
    a_ents[#"bottle3"].mdl_bottle linkto(a_ents[#"bottle3"], "bottle_03_link_jnt");
    a_ents[#"bottle1"].mdl_tube linkto(a_ents[#"bottle1"], "bottle_01_link_jnt");
    a_ents[#"bottle2"].mdl_tube linkto(a_ents[#"bottle2"], "bottle_02_link_jnt");
    a_ents[#"bottle3"].mdl_tube linkto(a_ents[#"bottle3"], "bottle_03_link_jnt");
    a_ents[#"bottle1"].var_79488a88 linkto(a_ents[#"bottle1"], "bottlecap_01_link_jnt");
    a_ents[#"bottle2"].var_79488a88 linkto(a_ents[#"bottle2"], "bottlecap_02_link_jnt");
    a_ents[#"bottle3"].var_79488a88 linkto(a_ents[#"bottle3"], "bottlecap_03_link_jnt");
    var_1c4dc869 = arraycopy(level.var_adcca7fa.var_a6c55f44);
    level.var_adcca7fa.var_efba2f7c = array::random(var_1c4dc869);
    arrayremovevalue(var_1c4dc869, level.var_adcca7fa.var_efba2f7c);
    level.var_adcca7fa.var_61c19eb7 = array::random(var_1c4dc869);
    arrayremovevalue(var_1c4dc869, level.var_adcca7fa.var_61c19eb7);
    level.var_adcca7fa.var_3bbf244e = array::random(var_1c4dc869);
    arrayremovevalue(var_1c4dc869, level.var_adcca7fa.var_3bbf244e);
    a_ents[#"bottle1"].mdl_bottle setmodel(level.var_adcca7fa.var_efba2f7c);
    a_ents[#"bottle2"].mdl_bottle setmodel(level.var_adcca7fa.var_61c19eb7);
    a_ents[#"bottle3"].mdl_bottle setmodel(level.var_adcca7fa.var_3bbf244e);
    wait 0.25;
    a_ents[#"bottle1"].mdl_tube util::delay(0, undefined, &function_9af21180, #"hash_7a5f1cac9f948482");
    wait 0.15;
    a_ents[#"bottle2"].mdl_tube util::delay(0, undefined, &function_9af21180, #"hash_7a5f1cac9f948482");
    wait 0.15;
    a_ents[#"bottle3"].mdl_tube util::delay(0, undefined, &function_9af21180, #"hash_7a5f1cac9f948482");
    wait 1;
    util::delay(0, undefined, &function_9a96560c, level.var_adcca7fa.var_678b8ffc, 5, 1);
    wait 0.25;
    a_ents[#"bottle1"].mdl_tube thread util::delay(0, undefined, &function_9af21180, #"hash_3f81452487037fa3", 1);
    wait 0.1;
    a_ents[#"bottle2"].mdl_tube thread util::delay(0, undefined, &function_9af21180, #"hash_3f81452487037fa3", 1);
    wait 0.1;
    a_ents[#"bottle3"].mdl_tube thread util::delay(0, undefined, &function_9af21180, #"hash_3f81452487037fa3", 1);
    wait 1;
    a_ents[#"bottle1"].mdl_bottle thread function_9af21180(#"hash_772e420e766fbc4e");
    a_ents[#"bottle2"].mdl_bottle thread function_9af21180(#"hash_772e420e766fbc4e");
    a_ents[#"bottle3"].mdl_bottle thread function_9af21180(#"hash_772e420e766fbc4e");
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xb9846fa8, Offset: 0x76d8
// Size: 0x2de
function function_358448d(localclientnum, a_ents) {
    if (isdefined(a_ents[#"bottle1"].mdl_bottle)) {
        a_ents[#"bottle1"].mdl_bottle delete();
    }
    if (isdefined(a_ents[#"bottle2"].mdl_bottle)) {
        a_ents[#"bottle2"].mdl_bottle delete();
    }
    if (isdefined(a_ents[#"bottle3"].mdl_bottle)) {
        a_ents[#"bottle3"].mdl_bottle delete();
    }
    if (isdefined(a_ents[#"bottle1"].mdl_tube)) {
        a_ents[#"bottle1"].mdl_tube delete();
    }
    if (isdefined(a_ents[#"bottle2"].mdl_tube)) {
        a_ents[#"bottle2"].mdl_tube delete();
    }
    if (isdefined(a_ents[#"bottle3"].mdl_tube)) {
        a_ents[#"bottle3"].mdl_tube delete();
    }
    if (isdefined(a_ents[#"bottle1"].var_79488a88)) {
        a_ents[#"bottle1"].var_79488a88 delete();
    }
    if (isdefined(a_ents[#"bottle2"].var_79488a88)) {
        a_ents[#"bottle2"].var_79488a88 delete();
    }
    if (isdefined(a_ents[#"bottle3"].var_79488a88)) {
        a_ents[#"bottle3"].var_79488a88 delete();
    }
    level.var_adcca7fa.var_efba2f7c = undefined;
    level.var_adcca7fa.var_61c19eb7 = undefined;
    level.var_adcca7fa.var_3bbf244e = undefined;
    level.var_adcca7fa.var_38f1ab0e = undefined;
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xe2de818e, Offset: 0x79c0
// Size: 0x1c
function function_5d6f70b9(localclientnum, a_ents, str_current_shot) {
    
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x20cae1c6, Offset: 0x79e8
// Size: 0x84
function function_9c0e0481(localclientnum, a_ents, str_shot) {
    if (isstring(str_shot) && issubstr(str_shot, "spin")) {
        a_ents[#"centrifuge"] thread function_e5811646();
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xf6b41cde, Offset: 0x7a78
// Size: 0x70
function function_521035d4(localclientnum, a_ents, str_shot) {
    if (str_shot == "mixer_activate") {
        a_ents[#"hash_177182345b2ca631"] thread function_e5811646();
        return;
    }
    level notify(#"hash_333aed9939c9fe17");
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xc1dfc99c, Offset: 0x7af0
// Size: 0x2d0
function function_e5811646(var_1979b2b5 = 1) {
    self notify(#"hash_333aed9939c9fe17");
    self endon(#"hash_333aed9939c9fe17", #"death");
    level endon(#"hash_333aed9939c9fe17");
    self playrenderoverridebundle(#"hash_4927e34f3960e031");
    var_46fe0c10 = array(-1, 0, 0.25, 1, 1.5, 2, 3, 5);
    var_953d7dd4 = array::random(var_46fe0c10);
    var_8039fba7 = array::random(array::exclude(var_46fe0c10, var_953d7dd4));
    while (true) {
        self function_98a01e4c(#"hash_4927e34f3960e031", "Brightness", 1);
        self function_98a01e4c(#"hash_4927e34f3960e031", "Alpha", 1);
        var_5c19739a = gettime();
        n_time_end = gettime() + int(var_1979b2b5 * 1000);
        n_timer = var_5c19739a;
        while (n_timer < n_time_end) {
            n_timer = gettime();
            if (n_timer >= n_time_end) {
                self function_98a01e4c(#"hash_4927e34f3960e031", "Tint", var_8039fba7);
                break;
            } else {
                var_577bab63 = mapfloat(var_5c19739a, n_time_end, var_953d7dd4, var_8039fba7, n_timer);
                self function_98a01e4c(#"hash_4927e34f3960e031", "Tint", var_577bab63);
            }
            waitframe(1);
        }
        var_953d7dd4 = var_8039fba7;
        var_8039fba7 = array::random(array::exclude(var_46fe0c10, var_953d7dd4));
        waitframe(1);
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x298c5a16, Offset: 0x7dc8
// Size: 0x22e
function function_9af21180(var_138efeb6 = #"hash_7a5f18ac9f947db6", b_reverse = 0, n_total_time = 1) {
    self notify("798c058119c65fa0");
    self endon("798c058119c65fa0");
    self endon(#"death");
    if (isdefined(self.var_ac17ec60)) {
        self stoprenderoverridebundle(self.var_ac17ec60);
    }
    self playrenderoverridebundle(var_138efeb6);
    self.var_ac17ec60 = var_138efeb6;
    n_start_time = gettime();
    n_end_time = gettime() + int(n_total_time * 1000);
    n_timer = gettime();
    while (n_timer < n_end_time) {
        n_timer = gettime();
        if (n_timer >= n_end_time) {
            if (b_reverse) {
                self function_98a01e4c(var_138efeb6, "Threshold", 0);
            } else {
                self function_98a01e4c(var_138efeb6, "Threshold", 1);
            }
            break;
        } else {
            var_804fd459 = mapfloat(n_start_time, n_end_time, 0, 1, n_timer);
            if (b_reverse) {
                self function_98a01e4c(var_138efeb6, "Threshold", 1 - var_804fd459);
            } else {
                self function_98a01e4c(var_138efeb6, "Threshold", var_804fd459);
            }
        }
        waitframe(1);
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x23b010dc, Offset: 0x8000
// Size: 0x16
function function_e436650a(entry) {
    return entry.var_3620f1e9;
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xe7790914, Offset: 0x8020
// Size: 0x24
function function_4d684d12(entry, session_mode) {
    return entry.mode === session_mode;
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x6169e800, Offset: 0x8050
// Size: 0x104
function function_34a9827b(mode, index) {
    selectable = array::filter(level.var_dc72aa65, 0, &function_e436650a);
    selectable = array::filter(level.var_dc72aa65, 0, &function_e436650a);
    foreach (var_fe3c7eaa in selectable) {
        if (var_fe3c7eaa.mode == mode && var_fe3c7eaa.role_index == index) {
            return var_fe3c7eaa.list_index;
        }
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x56dfb781, Offset: 0x8160
// Size: 0x2fc
function function_b31492b8(localclientnum) {
    var_666d472b = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_666d472b.targetname = "frozen_moment_character";
    level.frozen_moment_character = character_customization::function_9de1b403(var_666d472b, localclientnum, 1);
    selectable = array::filter(level.var_dc72aa65, 0, &function_e436650a);
    if (selectable.size == 0) {
        println("<dev string:xfb>");
        selectable = level.var_dc72aa65;
    }
    level.var_25019003 = 0;
    level.var_47f97253 = level.var_25019003;
    level.var_4dc241f2 = level.var_dc72aa65[level.var_25019003].scene;
    var_cd679009 = {#initialized:0};
    while (!var_cd679009.initialized) {
        var_cd679009 = function_59bb1845(localclientnum);
        wait 0.1;
    }
    level.var_25019003 = function_34a9827b(var_cd679009.mode, var_cd679009.index);
    if (!isdefined(level.var_25019003)) {
        character_mode = 1;
        var_4105a7d = array::filter(selectable, 0, &function_4d684d12, character_mode);
        var_30d82ff4 = var_4105a7d[randomint(var_4105a7d.size)];
        level.var_25019003 = var_30d82ff4.list_index;
    }
    /#
        level.var_25019003 = getdvarint(#"hash_563d2a49168a665c", level.var_25019003);
    #/
    level.var_47f97253 = level.var_25019003;
    level.var_4dc241f2 = level.var_dc72aa65[level.var_25019003].scene;
    forcestreambundle(level.var_4dc241f2, 8, 4);
    /#
        level thread function_28e71d0d(localclientnum);
    #/
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x11ddf3ec, Offset: 0x8468
// Size: 0x74
function function_3d603ca6(localclientnum) {
    level.var_102967cc = util::spawn_model(localclientnum, #"wpn_t8_ar_accurate_prop_animate", (0, 0, 0), (0, 0, 0));
    level.var_102967cc.targetname = "customized_inspection_weapon";
    level.var_102967cc hide();
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xbfbdb717, Offset: 0x84e8
// Size: 0x326
function localclientconnect(localclientnum) {
    println("<dev string:x14f>" + localclientnum);
    var_f6d3e16e = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_f6d3e16e.targetname = "__masked_char";
    var_c2517e63 = character_customization::function_9de1b403(var_f6d3e16e, localclientnum, 0);
    [[ var_c2517e63 ]]->function_abb62848(1);
    [[ var_c2517e63 ]]->update();
    level.specialist_customization = function_896c408e(localclientnum, "updateSpecialistCustomization");
    level thread scene::play("scene_frontend_inspection_weapon", "inspection_weapon_full");
    function_3d603ca6(localclientnum);
    setupclientmenus(localclientnum);
    level thread function_7c3a0545(localclientnum);
    function_b31492b8(localclientnum);
    if (isdefined(level.charactercustomizationsetup)) {
        [[ level.charactercustomizationsetup ]](localclientnum);
    }
    if (isdefined(level.weaponcustomizationiconsetup)) {
        [[ level.weaponcustomizationiconsetup ]](localclientnum);
    }
    callback::callback(#"on_localclient_connect", localclientnum);
    customclass::localclientconnect(localclientnum);
    level thread function_d113791d(localclientnum);
    level thread function_a8b0b007(localclientnum);
    customclass::hide_paintshop_bg(localclientnum);
    globalmodel = getglobaluimodel();
    roommodel = createuimodel(globalmodel, "lobbyRoot.room");
    room = getuimodelvalue(roommodel);
    postfx::setfrontendstreamingoverlay(localclientnum, "frontend", 1);
    level.frontendclientconnected = 1;
    level notify("menu_change" + localclientnum, {#menu:"Main", #status:"opened", #state:room});
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x8818
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x8828
// Size: 0x4
function onstartgametype() {
    
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xc01ba2d1, Offset: 0x8838
// Size: 0x44
function open_choose_class(localclientnum, menu_data) {
    level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "choose_class_closed" + localclientnum);
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xe5df29f0, Offset: 0x8888
// Size: 0x5a
function close_choose_class(localclientnum, menu_data) {
    enablefrontendlockedweaponoverlay(localclientnum, 0);
    enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
    level notify("choose_class_closed" + localclientnum);
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x309eceae, Offset: 0x88f0
// Size: 0x240
function function_a9e98345(localclientnum, menu_name, state) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    level thread scene::play("scene_frontend_loadout_mp", "edit");
    while (true) {
        waitresult = level waittill(#"hash_13a0d87236767b43");
        if (waitresult.type == "update_weapon") {
            slot = waitresult.slot;
            ent = getent(localclientnum, "loadout_" + slot, "targetname");
            if (isdefined(ent)) {
                newweapon = getweapon(waitresult.weaponnamehash, strtok(waitresult.attachments, "+"));
                ent setmodel(newweapon.worldmodel);
            }
            continue;
        }
        if (waitresult.type == "update_skill") {
            slot = waitresult.slot;
            ent = getent(localclientnum, "loadout_" + slot, "targetname");
            if (isdefined(ent)) {
            }
            continue;
        }
        if (waitresult.type == "update_shot") {
            shot = isdefined(waitresult.shot) ? waitresult.shot : "edit";
            level thread scene::play("scene_frontend_loadout_mp", shot);
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x34b83b0, Offset: 0x8b38
// Size: 0x34
function function_ec2a050c(localclientnum, menu_data) {
    level thread scene::stop("scene_frontend_loadout_mp");
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xed8159fc, Offset: 0x8b78
// Size: 0x96
function function_a7232976(var_5a840c8a, waitresult, params) {
    fields = [[ var_5a840c8a ]]->function_c35b901();
    if (isdefined(fields)) {
        params.scene = fields.var_77331602;
        params.var_40b25178 = 1;
        params.var_4cc8f4b3 = 1;
        params.scene_target = struct::get("cac_specialist");
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x6825a89b, Offset: 0x8c18
// Size: 0x104
function function_896c408e(localclientnum, notifyname) {
    var_16a64ca2 = struct::get("cac_specialist");
    if (isdefined(var_16a64ca2)) {
        var_5c0f65bd = util::spawn_model(localclientnum, "tag_origin", var_16a64ca2.origin, var_16a64ca2.angles);
        var_5c0f65bd.targetname = "specialist_customization";
        var_bd3c32ba = character_customization::function_9de1b403(var_5c0f65bd, localclientnum, 0);
        [[ var_bd3c32ba ]]->set_character_mode(1);
        level thread character_customization::updateeventthread(localclientnum, var_bd3c32ba, notifyname, &function_a7232976);
        return var_bd3c32ba;
    }
    return undefined;
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x92070a11, Offset: 0x8d28
// Size: 0x2a4
function function_da5b7e64(localclientnum, type) {
    level endon(#"hash_585ecc4772eb0ddc");
    level endon(#"hash_7bd5bee7fbd340ab");
    level endon(#"disconnect");
    level endon(#"blackmarket_closed");
    var_c596068f = 0.5;
    var_e6a2a338 = 0.01;
    if (level.var_d4e5097e != "") {
        exploder::stop_exploder(level.var_d4e5097e);
    }
    wait var_e6a2a338;
    var_ba01c642 = 0;
    if (type == "common") {
        var_ba01c642 = 0;
        level.var_d4e5097e = "exploder_blackmarket_crate_common";
    } else if (type == "rare") {
        var_ba01c642 = 1;
        level.var_d4e5097e = "exploder_blackmarket_crate_rare";
    } else if (type == "legendary") {
        var_ba01c642 = 2;
        level.var_d4e5097e = "exploder_blackmarket_crate_legendary";
    } else if (type == "epic") {
        var_ba01c642 = 3;
        level.var_d4e5097e = "exploder_blackmarket_crate_epic";
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, var_ba01c642, 0);
    wait var_c596068f - var_e6a2a338;
    if (type != "common") {
        playsound(localclientnum, #"hash_2d5a00011b9f7e77");
    }
    exploder::exploder(level.var_d4e5097e);
    self clearanim(#"hash_17eef0e1ca1dbc48", 0);
    self animation::play(#"hash_314039b16253653e", undefined, undefined, 1, 0, 0, 0, 0);
    self animation::play(#"hash_17eef0e1ca1dbc48", undefined, undefined, 1, 0, 0, 0, 0);
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x43684864, Offset: 0x8fd8
// Size: 0x3d2
function function_b26afc1b(localclientnum) {
    level notify(#"hash_7bd5bee7fbd340ab");
    level endon(#"hash_7bd5bee7fbd340ab");
    level endon(#"disconnect");
    level endon(#"blackmarket_closed");
    camera_ent = struct::get("mp_frontend_blackmarket");
    crate = getent(localclientnum, "mp_frontend_blackmarket_crate", "targetname");
    crate useanimtree("generic");
    crate clearanim(#"hash_17eef0e1ca1dbc48", 0);
    crate mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
    if (level.var_d4e5097e != "") {
        exploder::stop_exploder(level.var_d4e5097e);
        level.var_d4e5097e = "";
    }
    while (true) {
        waitresult = level waittill(#"blackmarket");
        param1 = waitresult.param1;
        param2 = waitresult.param2;
        if (param1 == "crate_camera") {
            playmaincamxcam(localclientnum, "ui_cam_frontend_crate_in", 0, "cam_crate_in", "", camera_ent.origin, camera_ent.angles);
            crate thread function_da5b7e64(localclientnum, param2);
            continue;
        }
        if (param1 == "normal_camera") {
            level notify(#"hash_585ecc4772eb0ddc");
            crate clearanim(#"hash_17eef0e1ca1dbc48", 0);
            crate mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
            if (level.var_d4e5097e != "") {
                exploder::stop_exploder(level.var_d4e5097e);
                level.var_d4e5097e = "";
            }
            playmaincamxcam(localclientnum, "ui_cam_frontend_blackmarket", 0, "cam_mpmain", "", camera_ent.origin, camera_ent.angles);
            continue;
        }
        if (param1 == "cycle_start") {
            level.var_ad2380a3 = crate playloopsound(#"hash_60985f07da86b4f");
            continue;
        }
        if (param1 == "cycle_stop" && isdefined(level.var_ad2380a3)) {
            crate stoploopsound(level.var_ad2380a3);
            level.var_ad2380a3 = undefined;
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xa17f928, Offset: 0x93b8
// Size: 0xec
function function_2c510839(localclientnum, menu_data) {
    level.var_d4e5097e = "";
    streamer_change("core_frontend_blackmarket");
    setdvar(#"r_volumetric_lighting_upsample_depth_threshold", 0.001);
    setdvar(#"r_volumetric_lighting_blur_depth_threshold", 1300);
    setdvar(#"r_volumetric_lighting_lights_skip_samples", 0);
    setdvar(#"r_volumetric_lighting_max_spot_samples", 40);
    level thread function_b26afc1b(localclientnum);
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x83d540db, Offset: 0x94b0
// Size: 0x130
function function_68a00f67(localclientnum, menu_data) {
    setdvar(#"r_volumetric_lighting_upsample_depth_threshold", 0.01);
    setdvar(#"r_volumetric_lighting_blur_depth_threshold", 2000);
    setdvar(#"r_volumetric_lighting_lights_skip_samples", 1);
    setdvar(#"r_volumetric_lighting_max_spot_samples", 8);
    if (isdefined(level.var_ad2380a3)) {
        crate = getent(localclientnum, "mp_frontend_blackmarket_crate", "targetname");
        crate stoploopsound(level.var_ad2380a3);
        level.var_ad2380a3 = undefined;
    }
    level notify(#"blackmarket_closed");
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xc12a06f, Offset: 0x95e8
// Size: 0x64
function open_character_menu(localclientnum, menu_data) {
    character_ent = getent(localclientnum, menu_data.target_name, "targetname");
    if (isdefined(character_ent)) {
        character_ent show();
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xa656210b, Offset: 0x9658
// Size: 0x64
function close_character_menu(localclientnum, menu_data) {
    character_ent = getent(localclientnum, menu_data.target_name, "targetname");
    if (isdefined(character_ent)) {
        character_ent hide();
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x6765b105, Offset: 0x96c8
// Size: 0x5e
function start_character_rotating_any(localclientnum, menu_data) {
    maxlocalclient = getmaxlocalclients();
    while (localclientnum < maxlocalclient) {
        start_character_rotating(localclientnum, menu_data);
        localclientnum++;
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x72957a82, Offset: 0x9730
// Size: 0x5e
function end_character_rotating_any(localclientnum, menu_data) {
    maxlocalclient = getmaxlocalclients();
    while (localclientnum < maxlocalclient) {
        end_character_rotating(localclientnum, menu_data);
        localclientnum++;
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x20cab123, Offset: 0x9798
// Size: 0x44
function start_character_rotating(localclientnum, menu_data) {
    level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "end_character_rotating" + localclientnum);
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xa9840807, Offset: 0x97e8
// Size: 0x2a
function end_character_rotating(localclientnum, menu_data) {
    level notify("end_character_rotating" + localclientnum);
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xfb55d9f8, Offset: 0x9820
// Size: 0xd0
function open_choose_head_menu(localclientnum, menu_data) {
    [[ menu_data.custom_character ]]->set_show_helmets(0);
    [[ menu_data.custom_character ]]->function_73b050c4(1);
    [[ menu_data.custom_character ]]->set_character_mode(2);
    [[ menu_data.custom_character ]]->function_94936fb3();
    [[ menu_data.custom_character ]]->function_fd80d28b();
    [[ menu_data.custom_character ]]->update();
    start_character_rotating(localclientnum, menu_data);
    level notify(#"begin_personalizing_hero");
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x9345fe28, Offset: 0x98f8
// Size: 0xd8
function close_choose_head_menu(localclientnum, menu_data) {
    if (!isdefined(menu_data.custom_character.charactermode) || menu_data.custom_character.charactermode == 4) {
        menu_data.custom_character.charactermode = currentsessionmode();
    }
    [[ menu_data.custom_character ]]->set_show_helmets(1);
    [[ menu_data.custom_character ]]->function_73b050c4(0);
    end_character_rotating(localclientnum, menu_data);
    level notify(#"done_personalizing_hero");
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x628daa5a, Offset: 0x99d8
// Size: 0x1f0
function personalize_characters_watch(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    s_cam = struct::get("personalizeHero_camera", "targetname");
    assert(isdefined(s_cam));
    for (animtime = 0; true; animtime = 300) {
        waitresult = level waittill("camera_change" + localclientnum);
        pose = waitresult.pose;
        if (pose === "exploring") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", animtime, "cam_preview", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (pose === "inspecting_helmet") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", animtime, "cam_helmet", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (pose === "inspecting_body") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", animtime, "cam_select", "", s_cam.origin, s_cam.angles);
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xf609fbe6, Offset: 0x9bd0
// Size: 0x2c8
function function_d9b146ec(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    s_cam = struct::get("spawn_char_custom", "targetname");
    assert(isdefined(s_cam));
    playmaincamxcam(localclientnum, "ui_cam_character_customization", 0, "cam_helmet", "", s_cam.origin, s_cam.angles);
    while (true) {
        waitresult = level waittill("choose_face_camera_change" + localclientnum);
        region = waitresult.param1;
        if (region === "face") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_helmet", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (region === "eyes") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_eyes", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (region === "ears") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_ears", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (region === "nose") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_nose", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (region === "mouth") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_mouth", "", s_cam.origin, s_cam.angles);
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xf5aacfd8, Offset: 0x9ea0
// Size: 0x1ac
function choose_taunts_camera_watch(localclientnum, menu_name) {
    s_cam = struct::get("personalizeHero_camera", "targetname");
    assert(isdefined(s_cam));
    playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_topscorers", "", s_cam.origin, s_cam.angles);
    var_5a840c8a = lui::getcharacterdataformenu(menu_name, localclientnum);
    [[ var_5a840c8a ]]->function_4c9d5ac7(1, (0, 112, 0));
    level waittill(menu_name + "_closed");
    params = spawnstruct();
    params.anim_name = #"pb_cac_main_lobby_idle";
    [[ var_5a840c8a ]]->update(params);
    [[ var_5a840c8a ]]->function_4c9d5ac7(0, undefined);
    playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_preview", "", s_cam.origin, s_cam.angles);
    wait 3;
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x70895527, Offset: 0xa058
// Size: 0x100
function function_fc59720d(var_43447889, var_93860d34) {
    if (isdefined(var_43447889) && isdefined(var_43447889[var_93860d34])) {
        foreach (object in var_43447889[var_93860d34]) {
            var_cec5d4a0 = [[ object.character ]]->function_e5bdd4ae();
            if (isdefined(var_cec5d4a0) && isdefined(var_cec5d4a0.entnummodel)) {
                setuimodelvalue(var_cec5d4a0.entnummodel, [[ object.character ]]->function_295fce60());
            }
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xed58f76d, Offset: 0xa160
// Size: 0xf0
function function_65660fa2(var_43447889, var_93860d34) {
    if (isdefined(var_43447889) && isdefined(var_43447889[var_93860d34])) {
        foreach (object in var_43447889[var_93860d34]) {
            var_cec5d4a0 = [[ object.character ]]->function_e5bdd4ae();
            if (isdefined(var_cec5d4a0) && isdefined(var_cec5d4a0.entnummodel)) {
                setuimodelvalue(var_cec5d4a0.entnummodel, -1);
            }
        }
    }
}

// Namespace frontend/frontend
// Params 5, eflags: 0x0
// Checksum 0x2b6f9c23, Offset: 0xa258
// Size: 0x49c
function function_a36cfb42(localclientnum, xuid, ccobject, index, var_93860d34) {
    level endon(#"lobby_change");
    [[ ccobject ]]->show_model();
    [[ ccobject ]]->set_xuid(xuid);
    [[ ccobject ]]->function_abb62848(1);
    [[ ccobject ]]->function_43f376f0(1);
    session_mode = 1;
    var_ae1e51ff = function_7784420f(xuid, session_mode);
    if ([[ ccobject ]]->get_character_index() != var_ae1e51ff) {
        var_66c74d2d = undefined;
        var_6add4614 = getcharacterfields(var_ae1e51ff, session_mode);
        if (isdefined(var_6add4614)) {
            default_scenes = function_10aa245(var_6add4614, var_93860d34);
            if (isdefined(default_scenes)) {
                var_66c74d2d = default_scenes[index % default_scenes.size].scene;
            }
        }
        var_9f33aa46 = spawnstruct();
        if (isdefined(var_66c74d2d)) {
            var_9f33aa46.scene = var_66c74d2d;
            var_9f33aa46.scene_target = self;
            var_9f33aa46.var_573638fb = 1;
        } else {
            var_9f33aa46.anim_name = #"pb_cac_main_lobby_idle";
        }
        [[ ccobject ]]->update(var_9f33aa46);
    }
    var_52a60d51 = getcharactercustomizationforxuid(localclientnum, xuid);
    if (!isdefined(var_52a60d51)) {
        for (iterations = 0; !isdefined(var_52a60d51) && iterations < 15; iterations++) {
            wait 1;
            var_52a60d51 = getcharactercustomizationforxuid(localclientnum, xuid);
        }
    }
    if (!isdefined(var_52a60d51) || var_52a60d51.charactermode != currentsessionmode() || !function_d2bcc303(var_52a60d51.charactertype, var_52a60d51.charactermode)) {
        var_52a60d51 = undefined;
        if (!function_be0f36e(xuid)) {
            character_index = function_7784420f(xuid, session_mode);
            if (isdefined(character_index)) {
                fields = getcharacterfields(character_index, session_mode);
            }
        }
    } else {
        fields = getcharacterfields(var_52a60d51.charactertype, var_52a60d51.charactermode);
    }
    var_7ab7d6f2 = undefined;
    if (isdefined(fields)) {
        scenes = function_10aa245(fields, var_93860d34);
        if (isdefined(scenes)) {
            var_7ab7d6f2 = scenes[index % scenes.size].scene;
        }
    }
    if (isdefined(var_7ab7d6f2)) {
        [[ ccobject ]]->function_abb62848(0);
        params = spawnstruct();
        params.scene = var_7ab7d6f2;
        params.scene_target = self;
        params.var_573638fb = 1;
        params.var_40b25178 = 1;
        if (isdefined(var_52a60d51)) {
            [[ ccobject ]]->function_1a1fd7cd(var_52a60d51);
        } else {
            [[ ccobject ]]->set_character_mode(session_mode);
            [[ ccobject ]]->set_character_index(character_index);
            [[ ccobject ]]->function_44330d1b();
        }
        [[ ccobject ]]->update(params);
    }
    draft::function_e19ab3c8(ccobject, index, var_93860d34);
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xba8cbc08, Offset: 0xa700
// Size: 0x1a8
function function_d8803886(localclientnum, &var_c480f6a0, var_191ae2d4) {
    for (i = 0; true; i++) {
        target = struct::get(var_191ae2d4 + i);
        if (!isdefined(target)) {
            break;
        }
        charactermodel = util::spawn_model(localclientnum, "tag_origin", target.origin, target.angles);
        charactermodel.targetname = var_191ae2d4 + "character_" + i;
        var_2b429f8d = character_customization::function_9de1b403(charactermodel, localclientnum, 0);
        var_ea38759f = {#target:target, #character:var_2b429f8d, #scene_name:undefined};
        if (!isdefined(var_c480f6a0)) {
            var_c480f6a0 = [];
        } else if (!isarray(var_c480f6a0)) {
            var_c480f6a0 = array(var_c480f6a0);
        }
        var_c480f6a0[var_c480f6a0.size] = var_ea38759f;
    }
    assert(i > 0);
    return i;
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x7bc072b1, Offset: 0xa8b0
// Size: 0x31e
function function_7c3a0545(localclientnum) {
    level endon(#"disconnect");
    var_8f2de166 = createuimodel(getglobaluimodel(), "LobbyClientPose");
    level.var_4f98753c = [[], []];
    var_aa73ba34 = function_d8803886(localclientnum, level.var_4f98753c[0], "lobby_player_");
    var_aa73ba34 = max(function_d8803886(localclientnum, level.var_4f98753c[1], "arena_player_"), var_aa73ba34);
    while (true) {
        waitresult = level waittill(#"lobby_change");
        var_83f73eb7 = function_d4b161e8(1);
        if (waitresult.var_37f84002 || waitresult.var_66968720) {
            for (i = 0; i < var_aa73ba34; i++) {
                if (i < var_83f73eb7.size) {
                    setuimodelvalue(createuimodel(var_8f2de166, i), var_83f73eb7[i]);
                    foreach (var_93860d34, character_array in level.var_4f98753c) {
                        var_ebf5ac16 = i > character_array.size ? undefined : character_array[i];
                        if (isdefined(var_ebf5ac16)) {
                            var_ebf5ac16.target thread function_a36cfb42(localclientnum, var_83f73eb7[i], var_ebf5ac16.character, i, var_93860d34);
                        }
                    }
                    continue;
                }
                foreach (var_93860d34, character_array in level.var_4f98753c) {
                    var_ebf5ac16 = i > character_array.size ? undefined : character_array[i];
                    if (isdefined(var_ebf5ac16)) {
                        [[ var_ebf5ac16.character ]]->hide_model();
                    }
                }
            }
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xc7e7287, Offset: 0xabd8
// Size: 0x10c
function function_d027c965(localclientnum, play) {
    var_6de7ddf8 = struct::get("lobby_align_tag");
    if (isdefined(var_6de7ddf8)) {
        if (play) {
            var_6de7ddf8.var_5f3609c7 = 1;
            function_fc59720d(level.var_4f98753c, 0);
            var_6de7ddf8 thread scene::play("scene_frontend_lobby_team");
            return;
        }
        if (!play && isdefined(var_6de7ddf8.var_5f3609c7) && var_6de7ddf8.var_5f3609c7) {
            var_6de7ddf8.var_5f3609c7 = 0;
            function_65660fa2(level.var_4f98753c, 0);
            var_6de7ddf8 thread scene::stop("scene_frontend_lobby_team", 1);
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xbc1e84eb, Offset: 0xacf0
// Size: 0x114
function function_951c6d2c(localclientnum, play) {
    var_6de7ddf8 = struct::get("arena_align_tag");
    if (isdefined(var_6de7ddf8)) {
        if (play) {
            var_6de7ddf8.var_5f3609c7 = 1;
            function_fc59720d(level.var_4f98753c, 1);
            var_6de7ddf8 thread scene::play("scene_frontend_arena_team");
            return;
        }
        if (!play && isdefined(var_6de7ddf8.var_5f3609c7) && var_6de7ddf8.var_5f3609c7) {
            var_6de7ddf8.var_5f3609c7 = 0;
            function_65660fa2(level.var_4f98753c, 1);
            var_6de7ddf8 thread scene::stop("scene_frontend_arena_team", 1);
        }
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x3c754fa5, Offset: 0xae10
// Size: 0xc4
function toggle_postfx(localclientnum, on_off, postfx) {
    player = function_f97e7787(localclientnum);
    if (on_off && !player postfx::function_7348f3a5(postfx)) {
        player postfx::playpostfxbundle(postfx);
        return;
    }
    if (!on_off && player postfx::function_7348f3a5(postfx)) {
        player postfx::stoppostfxbundle(postfx);
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xa1f5b37a, Offset: 0xaee0
// Size: 0x4c6
function lobby_main(localclientnum, menu_name, state) {
    level endon(menu_name + "_closed");
    setpbgactivebank(localclientnum, 1);
    if (state !== level.lastlobbystate) {
        if (level.lastlobbystate === #"lobby_pose") {
            function_d027c965(localclientnum, 0);
        } else if (level.lastlobbystate === #"arena_pose") {
            function_951c6d2c(localclientnum, 0);
        } else if (level.lastlobbystate === "warzone" || level.lastlobbystate === "zombie") {
            level notify(#"positiondraft_close", {#localclientnum:localclientnum});
        }
    }
    camera_ent = struct::get("tag_align_frozen");
    lut_index = 3;
    if (isdefined(camera_ent)) {
        var_7749877b = 0;
        if (!isdefined(state) || state == "room2") {
            lut_index = 2;
            var_7749877b = 1;
            /#
                update_room2_devgui(localclientnum);
            #/
        } else if (state == "room1") {
            setallcontrollerslightbarcolor((1, 0.4, 0));
            level thread pulse_controller_color();
            var_7749877b = 1;
        } else if (state == "room3") {
            var_7749877b = 1;
        } else if (state == "matchmaking") {
            var_7749877b = 1;
        } else if (state == #"lobby_pose") {
            level notify(#"lobby_change", {#var_37f84002:1});
            function_d027c965(localclientnum, 1);
        } else if (state == #"arena_pose") {
            level notify(#"lobby_change", {#var_37f84002:1});
            function_951c6d2c(localclientnum, 1);
        } else if (state == "warzone" || state == "zombie") {
            if (!(isdefined(level.draftactive) && level.draftactive)) {
                level notify(#"positiondraft_open", {#localclientnum:localclientnum});
            } else {
                level notify(#"hash_8946580b1303e30", {#localclientnum:localclientnum});
            }
        } else if (state == "mode_select") {
            var_7749877b = 1;
        } else {
            var_7749877b = 1;
        }
        level thread function_4177666a(localclientnum, var_7749877b, level.var_1df60f21);
        level.var_1df60f21 = 0;
        toggle_postfx(localclientnum, var_7749877b, #"hash_50a4ae6595f15cb0");
        toggle_postfx(localclientnum, !var_7749877b, #"hash_e1c80e52b24b46b");
    }
    if (!isdefined(state) || state != "room1") {
        setallcontrollerslightbarcolor();
        level notify(#"end_controller_pulse");
    }
    level.lastlobbystate = state;
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xc694068a, Offset: 0xb3b0
// Size: 0x84
function function_19a46ac6(localclientnum, menu_data) {
    level thread function_4177666a(localclientnum, 0);
    toggle_postfx(localclientnum, 0, #"hash_50a4ae6595f15cb0");
    toggle_postfx(localclientnum, 0, #"hash_e1c80e52b24b46b");
}

/#

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0x5b883570, Offset: 0xb440
    // Size: 0x2c
    function update_room2_devgui(localclientnum) {
        level thread mp_devgui::remove_mp_contracts_devgui(localclientnum);
    }

    // Namespace frontend/frontend
    // Params 2, eflags: 0x0
    // Checksum 0x5cb14a3a, Offset: 0xb478
    // Size: 0x74
    function update_mp_lobby_room_devgui(localclientnum, state) {
        if (state == "<dev string:x17c>" || state == "<dev string:x186>") {
            level thread mp_devgui::create_mp_contracts_devgui(localclientnum);
            return;
        }
        level mp_devgui::remove_mp_contracts_devgui(localclientnum);
    }

#/

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0xcd765afe, Offset: 0xb4f8
// Size: 0xca
function pulse_controller_color() {
    level endon(#"end_controller_pulse");
    delta_t = -0.01;
    t = 1;
    while (true) {
        setallcontrollerslightbarcolor((1 * t, 0.2 * t, 0));
        t += delta_t;
        if (t < 0.2 || t > 0.99) {
            delta_t *= -1;
        }
        waitframe(1);
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x2b5773fe, Offset: 0xb5d0
// Size: 0x3a4
function function_4177666a(localclientnum, play, forceupdate) {
    self notify("6cb6cc5a325bee45");
    self endon("6cb6cc5a325bee45");
    player = function_f97e7787(localclientnum);
    if (play && (!isdefined(level.var_bed49527) || isdefined(forceupdate) && forceupdate)) {
        if (isdefined(level.var_4dc241f2) && !forcestreambundle(level.var_4dc241f2, -1, -1)) {
            stopmaincamxcam(localclientnum);
        }
        function_f32200b3(localclientnum, level.var_dc72aa65[level.var_47f97253].role_index, level.var_dc72aa65[level.var_47f97253].mode);
        [[ level.frozen_moment_character ]]->set_character_mode(level.var_dc72aa65[level.var_47f97253].mode);
        [[ level.frozen_moment_character ]]->set_character_index(level.var_dc72aa65[level.var_47f97253].role_index);
        [[ level.frozen_moment_character ]]->function_fd80d28b();
        params = {#scene:level.var_4dc241f2, #var_40b25178:1, #var_4cc8f4b3:1, #var_c921b849:1};
        [[ level.frozen_moment_character ]]->update(params);
        level.var_bed49527 = level.var_4dc241f2;
        if (!(isdefined(level.lastlobbystate) && level.lastlobbystate == "matchmaking")) {
            fbc = getuimodel(getglobaluimodel(), "lobbyRoot.fullscreenBlackCount");
            setuimodelvalue(fbc, 1);
        }
        function_76f195d9(localclientnum, isdefined(level.var_dc72aa65[level.var_47f97253].fields.var_a105ca5e) ? level.var_dc72aa65[level.var_47f97253].fields.var_a105ca5e : 0, 1);
        function_5094c112(level.var_4dc241f2);
        return;
    }
    if (!play && isdefined(level.var_bed49527)) {
        [[ level.frozen_moment_character ]]->function_4f7c691e();
        fbc = getuimodel(getglobaluimodel(), "lobbyRoot.fullscreenBlackCount");
        setuimodelvalue(fbc, 0);
        level.var_bed49527 = undefined;
        function_76f195d9(localclientnum, 0, 1);
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xb17f0c9e, Offset: 0xb980
// Size: 0x12e
function function_f626f96d(localclientnum, menu_name, state) {
    var_5a840c8a = lui::getcharacterdataformenu(menu_name, localclientnum);
    [[ var_5a840c8a ]]->show_model();
    camera_ent = struct::get("cac_specialist_angle");
    playmaincamxcam(localclientnum, "ui_cam_loadout_character", 0, "", "", camera_ent.origin, camera_ent.angles);
    if (isdefined(state)) {
        [[ var_5a840c8a ]]->set_character_index(state);
        level notify("updateSpecialistCustomization" + localclientnum, {#event_name:"changeHero", #character_index:state, #mode:currentsessionmode()});
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xc980faf3, Offset: 0xbab8
// Size: 0xb4
function function_ec5b5add(localclientnum, menu_name, state) {
    var_5a840c8a = lui::getcharacterdataformenu(menu_name, localclientnum);
    [[ var_5a840c8a ]]->show_model();
    camera_ent = struct::get("cac_specialist_angle");
    playmaincamxcam(localclientnum, "ui_cam_loadout_character", 0, "", "", camera_ent.origin, camera_ent.angles);
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xd93438a9, Offset: 0xbb78
// Size: 0x334
function function_d7ec80eb(localclientnum, menu_name, state) {
    var_5a840c8a = lui::getcharacterdataformenu(menu_name, localclientnum);
    if (state === "character") {
        [[ var_5a840c8a ]]->show_model();
    } else {
        [[ var_5a840c8a ]]->hide_model();
    }
    var_8ebd3497 = createuimodel(getuimodelforcontroller(localclientnum), "AAR.clientNum");
    clientnum = getuimodelvalue(var_8ebd3497);
    var_6d779635 = getuimodel(getglobaluimodel(), "Clients." + clientnum + ".scoreboard.characterIndex");
    session_mode = currentsessionmode();
    character_index = getuimodelvalue(var_6d779635);
    var_62c33e14 = getplayerroletemplatecount(session_mode);
    attempts = 0;
    while (true) {
        if (!isdefined(character_index)) {
            character_index = 0;
        }
        if (function_fab05cb7(character_index, session_mode)) {
            break;
        }
        attempts++;
        if (attempts > 3) {
            character_index = undefined;
            for (ci = 0; ci < var_62c33e14; ci++) {
                if (function_fab05cb7(ci, session_mode)) {
                    character_index = ci;
                    break;
                }
            }
            break;
        }
    }
    assert(character_index);
    fields = getcharacterfields(character_index, session_mode);
    if (isdefined(fields) && isdefined(fields.var_2db98985)) {
        level.var_6259b006 = fields.var_2db98985;
    } else {
        level.var_6259b006 = "scene_frontend_aar";
    }
    if (!level scene::is_playing(level.var_6259b006)) {
        [[ var_5a840c8a ]]->set_character_mode(session_mode);
        [[ var_5a840c8a ]]->set_character_index(character_index);
        [[ var_5a840c8a ]]->function_44330d1b();
        [[ var_5a840c8a ]]->update(undefined);
        level thread scene::play(level.var_6259b006);
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xb9a518f3, Offset: 0xbeb8
// Size: 0x4e
function function_a2179c92(localclientnum, menu_name) {
    if (isdefined(level.var_6259b006)) {
        level thread scene::stop(level.var_6259b006);
        level.var_6259b006 = undefined;
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x2717fd53, Offset: 0xbf10
// Size: 0xb0
function function_796822db(localclientnum, entities) {
    foreach (ent in entities) {
        if (isdefined(ent) && isdefined(ent.model)) {
            ent playrenderoverridebundle(#"rob_zm_eyes_red");
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x91fa9f19, Offset: 0xbfc8
// Size: 0x54
function function_5eddae57(localclientnum, entities) {
    lut_index = randomintrange(3, 6);
    setlutscriptindex(localclientnum, lut_index, 1);
}

