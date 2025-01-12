#using script_22a36cbdf7e3bd31;
#using script_2c5f2d4e7aa698c4;
#using script_2c6e6e28dd66dcc4;
#using script_5fb8da2731850d9e;
#using script_60793766a26de8df;
#using script_6243781aa5394e62;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\weapons\zm_weap_cymbal_monkey;
#using scripts\zm\zm_silver_main_quest;
#using scripts\zm\zm_silver_pap_quest;
#using scripts\zm\zm_silver_sound;
#using scripts\zm\zm_silver_util;
#using scripts\zm\zm_silver_ww_quest;

#namespace zm_silver;

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x2
// Checksum 0x5a503f05, Offset: 0x300
// Size: 0x24
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.var_5470be1c = 1;
}

// Namespace zm_silver/level_init
// Params 1, eflags: 0x40
// Checksum 0xd5f971f7, Offset: 0x330
// Size: 0x1bc
function event_handler[level_init] main(*eventstruct) {
    clientfield::register_clientuimodel("player_lives", #"zm_hud", #"player_lives", 1, 2, "int", undefined, 0, 0);
    setsoundcontext("dark_aether", "inactive");
    level.setupcustomcharacterexerts = &setup_personality_character_exerts;
    setdvar(#"player_shallowwaterwadescale", 1);
    setdvar(#"player_waistwaterwadescale", 1);
    setdvar(#"player_deepwaterwadescale", 1);
    setsaveddvar(#"hash_3fce2eb907ebae19", 1);
    zm_silver_pap_quest::init_clientfield();
    zm_silver_ww_quest::init();
    zm_silver_main_quest::init();
    zm_silver_util::init();
    zm_silver_sound::init();
    namespace_45690bb8::init();
    load::main();
    util::waitforclient(0);
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0x728f931e, Offset: 0x4f8
// Size: 0x282
function setup_personality_character_exerts() {
    level.exert_sounds[1][#"playerbreathinsound"] = "vox_plr_1_exert_sniper_hold";
    level.exert_sounds[2][#"playerbreathinsound"] = "vox_plr_2_exert_sniper_hold";
    level.exert_sounds[3][#"playerbreathinsound"] = "vox_plr_3_exert_sniper_hold";
    level.exert_sounds[4][#"playerbreathinsound"] = "vox_plr_4_exert_sniper_hold";
    level.exert_sounds[1][#"playerbreathoutsound"] = "vox_plr_1_exert_sniper_exhale";
    level.exert_sounds[2][#"playerbreathoutsound"] = "vox_plr_2_exert_sniper_exhale";
    level.exert_sounds[3][#"playerbreathoutsound"] = "vox_plr_3_exert_sniper_exhale";
    level.exert_sounds[4][#"playerbreathoutsound"] = "vox_plr_4_exert_sniper_exhale";
    level.exert_sounds[1][#"playerbreathgaspsound"] = "vox_plr_1_exert_sniper_gasp";
    level.exert_sounds[2][#"playerbreathgaspsound"] = "vox_plr_2_exert_sniper_gasp";
    level.exert_sounds[3][#"playerbreathgaspsound"] = "vox_plr_3_exert_sniper_gasp";
    level.exert_sounds[4][#"playerbreathgaspsound"] = "vox_plr_4_exert_sniper_gasp";
    level.exert_sounds[1][#"meleeswipesoundplayer"] = "vox_plr_1_exert_punch_give";
    level.exert_sounds[2][#"meleeswipesoundplayer"] = "vox_plr_2_exert_punch_give";
    level.exert_sounds[3][#"meleeswipesoundplayer"] = "vox_plr_3_exert_punch_give";
    level.exert_sounds[4][#"meleeswipesoundplayer"] = "vox_plr_4_exert_punch_give";
}

