#using scripts/core_common/scene_objects_shared;

#namespace cscenevehicle;

// Namespace cscenevehicle/scene_vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xb0d3db0d, Offset: 0xf0
// Size: 0xdc
function _spawn_ent() {
    if (isdefined(self._s.model)) {
        if (isassetloaded("vehicle", self._s.model)) {
            self._e = spawnvehicle(self._s.model, self._o_scene._e_root.origin, self._o_scene._e_root.angles);
            self._e useanimtree(#generic);
            self._e.animtree = "generic";
        }
    }
}

// Namespace cscenevehicle/scene_vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xa52c7e1, Offset: 0x1d8
// Size: 0x14
function __constructor() {
    csceneobject::__constructor();
}

// Namespace cscenevehicle/scene_vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xfe435830, Offset: 0x1f8
// Size: 0x14
function __destructor() {
    csceneobject::__destructor();
}

#namespace scene;

// Namespace scene/scene_vehicle_shared
// Params 0, eflags: 0x6
// Checksum 0x99ef7cd0, Offset: 0x218
// Size: 0xda6
function private autoexec cscenevehicle() {
    classes.cscenevehicle[0] = spawnstruct();
    classes.cscenevehicle[0].__vtable[964891661] = &csceneobject::get_ent;
    classes.cscenevehicle[0].__vtable[-162565429] = &csceneobject::warning;
    classes.cscenevehicle[0].__vtable[-32002227] = &csceneobject::error;
    classes.cscenevehicle[0].__vtable[1621988813] = &csceneobject::log;
    classes.cscenevehicle[0].__vtable[-1402092568] = &csceneobject::is_skipping_scene;
    classes.cscenevehicle[0].__vtable[-533039539] = &csceneobject::skip_scene;
    classes.cscenevehicle[0].__vtable[-770581098] = &csceneobject::skip_scene_shot_animations;
    classes.cscenevehicle[0].__vtable[1704417325] = &csceneobject::skip_animation_on_server;
    classes.cscenevehicle[0].__vtable[-1456645503] = &csceneobject::skip_animation_on_client;
    classes.cscenevehicle[0].__vtable[-1908648798] = &csceneobject::skip_anim_on_server;
    classes.cscenevehicle[0].__vtable[74477678] = &csceneobject::skip_anim_on_client;
    classes.cscenevehicle[0].__vtable[930261435] = &csceneobject::_should_skip_anim;
    classes.cscenevehicle[0].__vtable[-1004716425] = &csceneobject::in_a_different_scene;
    classes.cscenevehicle[0].__vtable[-1414114870] = &csceneobject::in_this_scene;
    classes.cscenevehicle[0].__vtable[-1769748375] = &csceneobject::is_shared_player;
    classes.cscenevehicle[0].__vtable[9120349] = &csceneobject::is_player_model;
    classes.cscenevehicle[0].__vtable[1426764347] = &csceneobject::is_player;
    classes.cscenevehicle[0].__vtable[-1924366689] = &csceneobject::is_alive;
    classes.cscenevehicle[0].__vtable[-1404324058] = &csceneobject::get_camera_tween_out;
    classes.cscenevehicle[0].__vtable[1796348751] = &csceneobject::get_camera_tween;
    classes.cscenevehicle[0].__vtable[-1574922781] = &csceneobject::get_lerp_time;
    classes.cscenevehicle[0].__vtable[-1725384325] = &csceneobject::regroup_invulnerability;
    classes.cscenevehicle[0].__vtable[372641686] = &csceneobject::play_regroup_fx_for_scene;
    classes.cscenevehicle[0].__vtable[287915791] = &csceneobject::kill_ent;
    classes.cscenevehicle[0].__vtable[107987567] = &csceneobject::_spawn_ent;
    classes.cscenevehicle[0].__vtable[-747054044] = &csceneobject::spawn_ent;
    classes.cscenevehicle[0].__vtable[1607542740] = &csceneobject::_camanimscripted;
    classes.cscenevehicle[0].__vtable[-1987452985] = &csceneobject::play_camera_on_player;
    classes.cscenevehicle[0].__vtable[-1471221345] = &csceneobject::play_camera;
    classes.cscenevehicle[0].__vtable[-577195284] = &csceneobject::wait_for_camera;
    classes.cscenevehicle[0].__vtable[1486082317] = &csceneobject::on_play_anim;
    classes.cscenevehicle[0].__vtable[-2057381235] = &csceneobject::function_855eda8d;
    classes.cscenevehicle[0].__vtable[-1678741042] = &csceneobject::function_9bf071ce;
    classes.cscenevehicle[0].__vtable[-1706684566] = &csceneobject::_play_anim;
    classes.cscenevehicle[0].__vtable[2088392420] = &csceneobject::update_alignment;
    classes.cscenevehicle[0].__vtable[667971789] = &csceneobject::play_anim;
    classes.cscenevehicle[0].__vtable[-51014854] = &csceneobject::animation_lookup;
    classes.cscenevehicle[0].__vtable[1056386707] = &csceneobject::set_objective;
    classes.cscenevehicle[0].__vtable[-378881381] = &csceneobject::restore_saved_ent;
    classes.cscenevehicle[0].__vtable[-1878563751] = &csceneobject::get_orig_name;
    classes.cscenevehicle[0].__vtable[737108631] = &csceneobject::_assign_unique_name;
    classes.cscenevehicle[0].__vtable[1811815105] = &csceneobject::function_6bfe1ac1;
    classes.cscenevehicle[0].__vtable[-2100195004] = &csceneobject::get_align_tag;
    classes.cscenevehicle[0].__vtable[1666938539] = &csceneobject::get_align_ent;
    classes.cscenevehicle[0].__vtable[751796260] = &csceneobject::_cleanup;
    classes.cscenevehicle[0].__vtable[853843291] = &csceneobject::cleanup;
    classes.cscenevehicle[0].__vtable[-1984848424] = &csceneobject::_stop;
    classes.cscenevehicle[0].__vtable[-51025227] = &csceneobject::stop;
    classes.cscenevehicle[0].__vtable[1058608330] = &csceneobject::reach;
    classes.cscenevehicle[0].__vtable[-18066874] = &csceneobject::function_feec5246;
    classes.cscenevehicle[0].__vtable[202678480] = &csceneobject::run_wait;
    classes.cscenevehicle[0].__vtable[466905210] = &csceneobject::_dynamic_paths;
    classes.cscenevehicle[0].__vtable[1131512199] = &csceneobject::play;
    classes.cscenevehicle[0].__vtable[-990458914] = &csceneobject::get_entry;
    classes.cscenevehicle[0].__vtable[656836165] = &csceneobject::has_streamer_hint;
    classes.cscenevehicle[0].__vtable[-1190741896] = &csceneobject::function_b906b878;
    classes.cscenevehicle[0].__vtable[1911543614] = &csceneobject::get_shot;
    classes.cscenevehicle[0].__vtable[-1957955334] = &csceneobject::get_animation_name;
    classes.cscenevehicle[0].__vtable[-800750439] = &csceneobject::_prepare;
    classes.cscenevehicle[0].__vtable[-325140770] = &csceneobject::prepare;
    classes.cscenevehicle[0].__vtable[987150381] = &csceneobject::_spawn;
    classes.cscenevehicle[0].__vtable[-1686119842] = &csceneobject::spawn;
    classes.cscenevehicle[0].__vtable[-1191896790] = &csceneobject::first_init;
    classes.cscenevehicle[0].__vtable[-359698846] = &csceneobject::_reset_values;
    classes.cscenevehicle[0].__vtable[-1553926551] = &csceneobject::_set_values;
    classes.cscenevehicle[0].__vtable[551404028] = &csceneobject::reset_ent_val;
    classes.cscenevehicle[0].__vtable[1285561865] = &csceneobject::set_ent_val;
    classes.cscenevehicle[0].__vtable[1606033458] = &csceneobject::__destructor;
    classes.cscenevehicle[0].__vtable[-1690805083] = &csceneobject::__constructor;
    classes.cscenevehicle[0].__vtable[1606033458] = &cscenevehicle::__destructor;
    classes.cscenevehicle[0].__vtable[-1690805083] = &cscenevehicle::__constructor;
    classes.cscenevehicle[0].__vtable[107987567] = &cscenevehicle::_spawn_ent;
}

