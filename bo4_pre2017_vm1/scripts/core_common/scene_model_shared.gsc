#using scripts/core_common/scene_objects_shared;

#namespace cscenemodel;

// Namespace cscenemodel/scene_model_shared
// Params 0, eflags: 0x0
// Checksum 0xa7d2b330, Offset: 0xd8
// Size: 0x14
function __constructor() {
    csceneobject::__constructor();
}

// Namespace cscenemodel/scene_model_shared
// Params 0, eflags: 0x0
// Checksum 0x1c6c464, Offset: 0xf8
// Size: 0x14
function __destructor() {
    csceneobject::__destructor();
}

#namespace scene;

// Namespace scene/scene_model_shared
// Params 0, eflags: 0x6
// Checksum 0x95819d1e, Offset: 0x118
// Size: 0xd76
function private autoexec cscenemodel() {
    classes.cscenemodel[0] = spawnstruct();
    classes.cscenemodel[0].__vtable[964891661] = &csceneobject::get_ent;
    classes.cscenemodel[0].__vtable[-162565429] = &csceneobject::warning;
    classes.cscenemodel[0].__vtable[-32002227] = &csceneobject::error;
    classes.cscenemodel[0].__vtable[1621988813] = &csceneobject::log;
    classes.cscenemodel[0].__vtable[-1402092568] = &csceneobject::is_skipping_scene;
    classes.cscenemodel[0].__vtable[-533039539] = &csceneobject::skip_scene;
    classes.cscenemodel[0].__vtable[-770581098] = &csceneobject::skip_scene_shot_animations;
    classes.cscenemodel[0].__vtable[1704417325] = &csceneobject::skip_animation_on_server;
    classes.cscenemodel[0].__vtable[-1456645503] = &csceneobject::skip_animation_on_client;
    classes.cscenemodel[0].__vtable[-1908648798] = &csceneobject::skip_anim_on_server;
    classes.cscenemodel[0].__vtable[74477678] = &csceneobject::skip_anim_on_client;
    classes.cscenemodel[0].__vtable[930261435] = &csceneobject::_should_skip_anim;
    classes.cscenemodel[0].__vtable[-1004716425] = &csceneobject::in_a_different_scene;
    classes.cscenemodel[0].__vtable[-1414114870] = &csceneobject::in_this_scene;
    classes.cscenemodel[0].__vtable[-1769748375] = &csceneobject::is_shared_player;
    classes.cscenemodel[0].__vtable[9120349] = &csceneobject::is_player_model;
    classes.cscenemodel[0].__vtable[1426764347] = &csceneobject::is_player;
    classes.cscenemodel[0].__vtable[-1924366689] = &csceneobject::is_alive;
    classes.cscenemodel[0].__vtable[-1404324058] = &csceneobject::get_camera_tween_out;
    classes.cscenemodel[0].__vtable[1796348751] = &csceneobject::get_camera_tween;
    classes.cscenemodel[0].__vtable[-1574922781] = &csceneobject::get_lerp_time;
    classes.cscenemodel[0].__vtable[-1725384325] = &csceneobject::regroup_invulnerability;
    classes.cscenemodel[0].__vtable[372641686] = &csceneobject::play_regroup_fx_for_scene;
    classes.cscenemodel[0].__vtable[287915791] = &csceneobject::kill_ent;
    classes.cscenemodel[0].__vtable[107987567] = &csceneobject::_spawn_ent;
    classes.cscenemodel[0].__vtable[-747054044] = &csceneobject::spawn_ent;
    classes.cscenemodel[0].__vtable[1607542740] = &csceneobject::_camanimscripted;
    classes.cscenemodel[0].__vtable[-1987452985] = &csceneobject::play_camera_on_player;
    classes.cscenemodel[0].__vtable[-1471221345] = &csceneobject::play_camera;
    classes.cscenemodel[0].__vtable[-577195284] = &csceneobject::wait_for_camera;
    classes.cscenemodel[0].__vtable[1486082317] = &csceneobject::on_play_anim;
    classes.cscenemodel[0].__vtable[-2057381235] = &csceneobject::function_855eda8d;
    classes.cscenemodel[0].__vtable[-1678741042] = &csceneobject::function_9bf071ce;
    classes.cscenemodel[0].__vtable[-1706684566] = &csceneobject::_play_anim;
    classes.cscenemodel[0].__vtable[2088392420] = &csceneobject::update_alignment;
    classes.cscenemodel[0].__vtable[667971789] = &csceneobject::play_anim;
    classes.cscenemodel[0].__vtable[-51014854] = &csceneobject::animation_lookup;
    classes.cscenemodel[0].__vtable[1056386707] = &csceneobject::set_objective;
    classes.cscenemodel[0].__vtable[-378881381] = &csceneobject::restore_saved_ent;
    classes.cscenemodel[0].__vtable[-1878563751] = &csceneobject::get_orig_name;
    classes.cscenemodel[0].__vtable[737108631] = &csceneobject::_assign_unique_name;
    classes.cscenemodel[0].__vtable[1811815105] = &csceneobject::function_6bfe1ac1;
    classes.cscenemodel[0].__vtable[-2100195004] = &csceneobject::get_align_tag;
    classes.cscenemodel[0].__vtable[1666938539] = &csceneobject::get_align_ent;
    classes.cscenemodel[0].__vtable[751796260] = &csceneobject::_cleanup;
    classes.cscenemodel[0].__vtable[853843291] = &csceneobject::cleanup;
    classes.cscenemodel[0].__vtable[-1984848424] = &csceneobject::_stop;
    classes.cscenemodel[0].__vtable[-51025227] = &csceneobject::stop;
    classes.cscenemodel[0].__vtable[1058608330] = &csceneobject::reach;
    classes.cscenemodel[0].__vtable[-18066874] = &csceneobject::function_feec5246;
    classes.cscenemodel[0].__vtable[202678480] = &csceneobject::run_wait;
    classes.cscenemodel[0].__vtable[466905210] = &csceneobject::_dynamic_paths;
    classes.cscenemodel[0].__vtable[1131512199] = &csceneobject::play;
    classes.cscenemodel[0].__vtable[-990458914] = &csceneobject::get_entry;
    classes.cscenemodel[0].__vtable[656836165] = &csceneobject::has_streamer_hint;
    classes.cscenemodel[0].__vtable[-1190741896] = &csceneobject::function_b906b878;
    classes.cscenemodel[0].__vtable[1911543614] = &csceneobject::get_shot;
    classes.cscenemodel[0].__vtable[-1957955334] = &csceneobject::get_animation_name;
    classes.cscenemodel[0].__vtable[-800750439] = &csceneobject::_prepare;
    classes.cscenemodel[0].__vtable[-325140770] = &csceneobject::prepare;
    classes.cscenemodel[0].__vtable[987150381] = &csceneobject::_spawn;
    classes.cscenemodel[0].__vtable[-1686119842] = &csceneobject::spawn;
    classes.cscenemodel[0].__vtable[-1191896790] = &csceneobject::first_init;
    classes.cscenemodel[0].__vtable[-359698846] = &csceneobject::_reset_values;
    classes.cscenemodel[0].__vtable[-1553926551] = &csceneobject::_set_values;
    classes.cscenemodel[0].__vtable[551404028] = &csceneobject::reset_ent_val;
    classes.cscenemodel[0].__vtable[1285561865] = &csceneobject::set_ent_val;
    classes.cscenemodel[0].__vtable[1606033458] = &csceneobject::__destructor;
    classes.cscenemodel[0].__vtable[-1690805083] = &csceneobject::__constructor;
    classes.cscenemodel[0].__vtable[1606033458] = &cscenemodel::__destructor;
    classes.cscenemodel[0].__vtable[-1690805083] = &cscenemodel::__constructor;
}

