#using script_67ce8e728d8f37ba;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace mp_moscow;

// Namespace mp_moscow/level_init
// Params 1, eflags: 0x40
// Checksum 0xc3a77027, Offset: 0x140
// Size: 0xf4
function event_handler[level_init] main(*eventstruct) {
    namespace_66d6aa44::function_3f3466c9();
    killstreaks::function_257a5f13("straferun", 40);
    killstreaks::function_257a5f13("helicopter_comlink", 75);
    load::main();
    compass::setupminimap("");
    scene::function_497689f6(#"cin_mp_moscow_intro_cia", "intro_van_moscow", "tag_probe_attach", "prb_tn_mos_eu_van");
    scene::function_497689f6(#"cin_mp_moscow_intro_kgb", "helicopter", "tag_probe_attach", "prb_tn_mos_heli_light_cabin");
}

