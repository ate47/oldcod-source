#using scripts/core_common/animation_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/scene_actor_shared;
#using scripts/core_common/scene_objects_shared;

#namespace csceneactor;

// Namespace csceneactor/scene_actor_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1a0
// Size: 0x4
function _spawn_ent() {
    
}

// Namespace csceneactor/scene_actor_shared
// Params 0, eflags: 0x0
// Checksum 0x9db3fd42, Offset: 0x1b0
// Size: 0xe4
function _prepare() {
    if (isactor(self._e)) {
        thread track_goal();
        if (isdefined(self._s.lookatplayer) && self._s.lookatplayer) {
            self._e lookatentity(level.activeplayers[0]);
        }
        if (isdefined(self._s.skipdeathanim) && self._s.skipdeathanim) {
            self._e.var_100aa9aa = 1;
        }
    }
    thread on_death();
}

// Namespace csceneactor/scene_actor_shared
// Params 0, eflags: 0x0
// Checksum 0xdca5ec79, Offset: 0x2a0
// Size: 0x13c
function _cleanup() {
    if (isactor(self._e) && isalive(self._e)) {
        if (isdefined(self._s.delaymovementatend) && self._s.delaymovementatend) {
            self._e pathmode("move delayed", 1, randomfloatrange(2, 3));
        } else {
            self._e pathmode("move allowed");
        }
        if (isdefined(self._s.lookatplayer) && self._s.lookatplayer) {
            self._e lookatentity();
        }
        self._e.var_100aa9aa = undefined;
        set_goal();
    }
}

// Namespace csceneactor/scene_actor_shared
// Params 0, eflags: 0x0
// Checksum 0xbf5afd6a, Offset: 0x3e8
// Size: 0x54
function track_goal() {
    self endon(self._str_shot + "active");
    self._e endon(#"death");
    self._e waittill("goal_changed");
    self._b_set_goal = 0;
}

// Namespace csceneactor/scene_actor_shared
// Params 0, eflags: 0x0
// Checksum 0x3bd4573d, Offset: 0x448
// Size: 0x114
function set_goal() {
    if (!(self._e.scene_spawned === self._o_scene._s.name && isdefined(self._e.target))) {
        if (!isdefined(self._e.script_forcecolor)) {
            if (!self._e flagsys::get("anim_reach")) {
                if (isdefined(self._e.scenegoal)) {
                    self._e setgoal(self._e.scenegoal);
                    self._e.scenegoal = undefined;
                    return;
                }
                if (self._b_set_goal) {
                    self._e setgoal(self._e.origin);
                }
            }
        }
    }
}

// Namespace csceneactor/scene_actor_shared
// Params 0, eflags: 0x0
// Checksum 0x5f18e56f, Offset: 0x568
// Size: 0x8c
function on_death() {
    self endon(self._str_shot + "active");
    self._e waittill("death");
    if (isdefined(self._e) && !(isdefined(self._e.skipscenedeath) && self._e.skipscenedeath)) {
        self thread do_death_anims();
    }
}

// Namespace csceneactor/scene_actor_shared
// Params 0, eflags: 0x0
// Checksum 0xe42413d4, Offset: 0x600
// Size: 0xcc
function do_death_anims() {
    ent = self._e;
    if (isdefined(self.var_2b1650fa) && !(isdefined(ent.var_100aa9aa) && ent.var_100aa9aa)) {
        ent.skipdeath = 1;
        ent animation::play(self.var_2b1650fa, ent, undefined, 1, 0.2, 0);
        return;
    }
    ent stopanimscripted();
    ent startragdoll();
}

// Namespace csceneactor/scene_actor_shared
// Params 0, eflags: 0x0
// Checksum 0x1b1850ed, Offset: 0x6d8
// Size: 0x14
function __constructor() {
    csceneobject::__constructor();
}

// Namespace csceneactor/scene_actor_shared
// Params 0, eflags: 0x0
// Checksum 0x61c1296, Offset: 0x6f8
// Size: 0x14
function __destructor() {
    csceneobject::__destructor();
}

#namespace scene;

// Namespace scene/scene_actor_shared
// Params 0, eflags: 0x6
// Checksum 0xd089f790, Offset: 0x718
// Size: 0xec6
function private autoexec csceneactor() {
    classes.csceneactor[0] = spawnstruct();
    classes.csceneactor[0].__vtable[964891661] = &csceneobject::get_ent;
    classes.csceneactor[0].__vtable[-162565429] = &csceneobject::warning;
    classes.csceneactor[0].__vtable[-32002227] = &csceneobject::error;
    classes.csceneactor[0].__vtable[1621988813] = &csceneobject::log;
    classes.csceneactor[0].__vtable[-1402092568] = &csceneobject::is_skipping_scene;
    classes.csceneactor[0].__vtable[-533039539] = &csceneobject::skip_scene;
    classes.csceneactor[0].__vtable[-770581098] = &csceneobject::skip_scene_shot_animations;
    classes.csceneactor[0].__vtable[1704417325] = &csceneobject::skip_animation_on_server;
    classes.csceneactor[0].__vtable[-1456645503] = &csceneobject::skip_animation_on_client;
    classes.csceneactor[0].__vtable[-1908648798] = &csceneobject::skip_anim_on_server;
    classes.csceneactor[0].__vtable[74477678] = &csceneobject::skip_anim_on_client;
    classes.csceneactor[0].__vtable[930261435] = &csceneobject::_should_skip_anim;
    classes.csceneactor[0].__vtable[-1004716425] = &csceneobject::in_a_different_scene;
    classes.csceneactor[0].__vtable[-1414114870] = &csceneobject::in_this_scene;
    classes.csceneactor[0].__vtable[-1769748375] = &csceneobject::is_shared_player;
    classes.csceneactor[0].__vtable[9120349] = &csceneobject::is_player_model;
    classes.csceneactor[0].__vtable[1426764347] = &csceneobject::is_player;
    classes.csceneactor[0].__vtable[-1924366689] = &csceneobject::is_alive;
    classes.csceneactor[0].__vtable[-1404324058] = &csceneobject::get_camera_tween_out;
    classes.csceneactor[0].__vtable[1796348751] = &csceneobject::get_camera_tween;
    classes.csceneactor[0].__vtable[-1574922781] = &csceneobject::get_lerp_time;
    classes.csceneactor[0].__vtable[-1725384325] = &csceneobject::regroup_invulnerability;
    classes.csceneactor[0].__vtable[372641686] = &csceneobject::play_regroup_fx_for_scene;
    classes.csceneactor[0].__vtable[287915791] = &csceneobject::kill_ent;
    classes.csceneactor[0].__vtable[107987567] = &csceneobject::_spawn_ent;
    classes.csceneactor[0].__vtable[-747054044] = &csceneobject::spawn_ent;
    classes.csceneactor[0].__vtable[1607542740] = &csceneobject::_camanimscripted;
    classes.csceneactor[0].__vtable[-1987452985] = &csceneobject::play_camera_on_player;
    classes.csceneactor[0].__vtable[-1471221345] = &csceneobject::play_camera;
    classes.csceneactor[0].__vtable[-577195284] = &csceneobject::wait_for_camera;
    classes.csceneactor[0].__vtable[1486082317] = &csceneobject::on_play_anim;
    classes.csceneactor[0].__vtable[-2057381235] = &csceneobject::function_855eda8d;
    classes.csceneactor[0].__vtable[-1678741042] = &csceneobject::function_9bf071ce;
    classes.csceneactor[0].__vtable[-1706684566] = &csceneobject::_play_anim;
    classes.csceneactor[0].__vtable[2088392420] = &csceneobject::update_alignment;
    classes.csceneactor[0].__vtable[667971789] = &csceneobject::play_anim;
    classes.csceneactor[0].__vtable[-51014854] = &csceneobject::animation_lookup;
    classes.csceneactor[0].__vtable[1056386707] = &csceneobject::set_objective;
    classes.csceneactor[0].__vtable[-378881381] = &csceneobject::restore_saved_ent;
    classes.csceneactor[0].__vtable[-1878563751] = &csceneobject::get_orig_name;
    classes.csceneactor[0].__vtable[737108631] = &csceneobject::_assign_unique_name;
    classes.csceneactor[0].__vtable[1811815105] = &csceneobject::function_6bfe1ac1;
    classes.csceneactor[0].__vtable[-2100195004] = &csceneobject::get_align_tag;
    classes.csceneactor[0].__vtable[1666938539] = &csceneobject::get_align_ent;
    classes.csceneactor[0].__vtable[751796260] = &csceneobject::_cleanup;
    classes.csceneactor[0].__vtable[853843291] = &csceneobject::cleanup;
    classes.csceneactor[0].__vtable[-1984848424] = &csceneobject::_stop;
    classes.csceneactor[0].__vtable[-51025227] = &csceneobject::stop;
    classes.csceneactor[0].__vtable[1058608330] = &csceneobject::reach;
    classes.csceneactor[0].__vtable[-18066874] = &csceneobject::function_feec5246;
    classes.csceneactor[0].__vtable[202678480] = &csceneobject::run_wait;
    classes.csceneactor[0].__vtable[466905210] = &csceneobject::_dynamic_paths;
    classes.csceneactor[0].__vtable[1131512199] = &csceneobject::play;
    classes.csceneactor[0].__vtable[-990458914] = &csceneobject::get_entry;
    classes.csceneactor[0].__vtable[656836165] = &csceneobject::has_streamer_hint;
    classes.csceneactor[0].__vtable[-1190741896] = &csceneobject::function_b906b878;
    classes.csceneactor[0].__vtable[1911543614] = &csceneobject::get_shot;
    classes.csceneactor[0].__vtable[-1957955334] = &csceneobject::get_animation_name;
    classes.csceneactor[0].__vtable[-800750439] = &csceneobject::_prepare;
    classes.csceneactor[0].__vtable[-325140770] = &csceneobject::prepare;
    classes.csceneactor[0].__vtable[987150381] = &csceneobject::_spawn;
    classes.csceneactor[0].__vtable[-1686119842] = &csceneobject::spawn;
    classes.csceneactor[0].__vtable[-1191896790] = &csceneobject::first_init;
    classes.csceneactor[0].__vtable[-359698846] = &csceneobject::_reset_values;
    classes.csceneactor[0].__vtable[-1553926551] = &csceneobject::_set_values;
    classes.csceneactor[0].__vtable[551404028] = &csceneobject::reset_ent_val;
    classes.csceneactor[0].__vtable[1285561865] = &csceneobject::set_ent_val;
    classes.csceneactor[0].__vtable[1606033458] = &csceneobject::__destructor;
    classes.csceneactor[0].__vtable[-1690805083] = &csceneobject::__constructor;
    classes.csceneactor[0].__vtable[1606033458] = &csceneactor::__destructor;
    classes.csceneactor[0].__vtable[-1690805083] = &csceneactor::__constructor;
    classes.csceneactor[0].__vtable[-480064742] = &csceneactor::do_death_anims;
    classes.csceneactor[0].__vtable[208071881] = &csceneactor::on_death;
    classes.csceneactor[0].__vtable[-1865159357] = &csceneactor::set_goal;
    classes.csceneactor[0].__vtable[522469748] = &csceneactor::track_goal;
    classes.csceneactor[0].__vtable[751796260] = &csceneactor::_cleanup;
    classes.csceneactor[0].__vtable[-800750439] = &csceneactor::_prepare;
    classes.csceneactor[0].__vtable[107987567] = &csceneactor::_spawn_ent;
}

#namespace cscenefakeactor;

// Namespace cscenefakeactor/scene_actor_shared
// Params 0, eflags: 0x0
// Checksum 0xbdf18c73, Offset: 0x15e8
// Size: 0x14
function __constructor() {
    csceneactor::__constructor();
}

// Namespace cscenefakeactor/scene_actor_shared
// Params 0, eflags: 0x0
// Checksum 0xac37cb5d, Offset: 0x1608
// Size: 0x14
function __destructor() {
    csceneactor::__destructor();
}

#namespace scene;

// Namespace scene/scene_actor_shared
// Params 0, eflags: 0x6
// Checksum 0xd9460da2, Offset: 0x1628
// Size: 0xf26
function private autoexec cscenefakeactor() {
    classes.cscenefakeactor[0] = spawnstruct();
    classes.cscenefakeactor[0].__vtable[964891661] = &csceneobject::get_ent;
    classes.cscenefakeactor[0].__vtable[-162565429] = &csceneobject::warning;
    classes.cscenefakeactor[0].__vtable[-32002227] = &csceneobject::error;
    classes.cscenefakeactor[0].__vtable[1621988813] = &csceneobject::log;
    classes.cscenefakeactor[0].__vtable[-1402092568] = &csceneobject::is_skipping_scene;
    classes.cscenefakeactor[0].__vtable[-533039539] = &csceneobject::skip_scene;
    classes.cscenefakeactor[0].__vtable[-770581098] = &csceneobject::skip_scene_shot_animations;
    classes.cscenefakeactor[0].__vtable[1704417325] = &csceneobject::skip_animation_on_server;
    classes.cscenefakeactor[0].__vtable[-1456645503] = &csceneobject::skip_animation_on_client;
    classes.cscenefakeactor[0].__vtable[-1908648798] = &csceneobject::skip_anim_on_server;
    classes.cscenefakeactor[0].__vtable[74477678] = &csceneobject::skip_anim_on_client;
    classes.cscenefakeactor[0].__vtable[930261435] = &csceneobject::_should_skip_anim;
    classes.cscenefakeactor[0].__vtable[-1004716425] = &csceneobject::in_a_different_scene;
    classes.cscenefakeactor[0].__vtable[-1414114870] = &csceneobject::in_this_scene;
    classes.cscenefakeactor[0].__vtable[-1769748375] = &csceneobject::is_shared_player;
    classes.cscenefakeactor[0].__vtable[9120349] = &csceneobject::is_player_model;
    classes.cscenefakeactor[0].__vtable[1426764347] = &csceneobject::is_player;
    classes.cscenefakeactor[0].__vtable[-1924366689] = &csceneobject::is_alive;
    classes.cscenefakeactor[0].__vtable[-1404324058] = &csceneobject::get_camera_tween_out;
    classes.cscenefakeactor[0].__vtable[1796348751] = &csceneobject::get_camera_tween;
    classes.cscenefakeactor[0].__vtable[-1574922781] = &csceneobject::get_lerp_time;
    classes.cscenefakeactor[0].__vtable[-1725384325] = &csceneobject::regroup_invulnerability;
    classes.cscenefakeactor[0].__vtable[372641686] = &csceneobject::play_regroup_fx_for_scene;
    classes.cscenefakeactor[0].__vtable[287915791] = &csceneobject::kill_ent;
    classes.cscenefakeactor[0].__vtable[107987567] = &csceneobject::_spawn_ent;
    classes.cscenefakeactor[0].__vtable[-747054044] = &csceneobject::spawn_ent;
    classes.cscenefakeactor[0].__vtable[1607542740] = &csceneobject::_camanimscripted;
    classes.cscenefakeactor[0].__vtable[-1987452985] = &csceneobject::play_camera_on_player;
    classes.cscenefakeactor[0].__vtable[-1471221345] = &csceneobject::play_camera;
    classes.cscenefakeactor[0].__vtable[-577195284] = &csceneobject::wait_for_camera;
    classes.cscenefakeactor[0].__vtable[1486082317] = &csceneobject::on_play_anim;
    classes.cscenefakeactor[0].__vtable[-2057381235] = &csceneobject::function_855eda8d;
    classes.cscenefakeactor[0].__vtable[-1678741042] = &csceneobject::function_9bf071ce;
    classes.cscenefakeactor[0].__vtable[-1706684566] = &csceneobject::_play_anim;
    classes.cscenefakeactor[0].__vtable[2088392420] = &csceneobject::update_alignment;
    classes.cscenefakeactor[0].__vtable[667971789] = &csceneobject::play_anim;
    classes.cscenefakeactor[0].__vtable[-51014854] = &csceneobject::animation_lookup;
    classes.cscenefakeactor[0].__vtable[1056386707] = &csceneobject::set_objective;
    classes.cscenefakeactor[0].__vtable[-378881381] = &csceneobject::restore_saved_ent;
    classes.cscenefakeactor[0].__vtable[-1878563751] = &csceneobject::get_orig_name;
    classes.cscenefakeactor[0].__vtable[737108631] = &csceneobject::_assign_unique_name;
    classes.cscenefakeactor[0].__vtable[1811815105] = &csceneobject::function_6bfe1ac1;
    classes.cscenefakeactor[0].__vtable[-2100195004] = &csceneobject::get_align_tag;
    classes.cscenefakeactor[0].__vtable[1666938539] = &csceneobject::get_align_ent;
    classes.cscenefakeactor[0].__vtable[751796260] = &csceneobject::_cleanup;
    classes.cscenefakeactor[0].__vtable[853843291] = &csceneobject::cleanup;
    classes.cscenefakeactor[0].__vtable[-1984848424] = &csceneobject::_stop;
    classes.cscenefakeactor[0].__vtable[-51025227] = &csceneobject::stop;
    classes.cscenefakeactor[0].__vtable[1058608330] = &csceneobject::reach;
    classes.cscenefakeactor[0].__vtable[-18066874] = &csceneobject::function_feec5246;
    classes.cscenefakeactor[0].__vtable[202678480] = &csceneobject::run_wait;
    classes.cscenefakeactor[0].__vtable[466905210] = &csceneobject::_dynamic_paths;
    classes.cscenefakeactor[0].__vtable[1131512199] = &csceneobject::play;
    classes.cscenefakeactor[0].__vtable[-990458914] = &csceneobject::get_entry;
    classes.cscenefakeactor[0].__vtable[656836165] = &csceneobject::has_streamer_hint;
    classes.cscenefakeactor[0].__vtable[-1190741896] = &csceneobject::function_b906b878;
    classes.cscenefakeactor[0].__vtable[1911543614] = &csceneobject::get_shot;
    classes.cscenefakeactor[0].__vtable[-1957955334] = &csceneobject::get_animation_name;
    classes.cscenefakeactor[0].__vtable[-800750439] = &csceneobject::_prepare;
    classes.cscenefakeactor[0].__vtable[-325140770] = &csceneobject::prepare;
    classes.cscenefakeactor[0].__vtable[987150381] = &csceneobject::_spawn;
    classes.cscenefakeactor[0].__vtable[-1686119842] = &csceneobject::spawn;
    classes.cscenefakeactor[0].__vtable[-1191896790] = &csceneobject::first_init;
    classes.cscenefakeactor[0].__vtable[-359698846] = &csceneobject::_reset_values;
    classes.cscenefakeactor[0].__vtable[-1553926551] = &csceneobject::_set_values;
    classes.cscenefakeactor[0].__vtable[551404028] = &csceneobject::reset_ent_val;
    classes.cscenefakeactor[0].__vtable[1285561865] = &csceneobject::set_ent_val;
    classes.cscenefakeactor[0].__vtable[1606033458] = &csceneobject::__destructor;
    classes.cscenefakeactor[0].__vtable[-1690805083] = &csceneobject::__constructor;
    classes.cscenefakeactor[0].__vtable[1606033458] = &csceneactor::__destructor;
    classes.cscenefakeactor[0].__vtable[-1690805083] = &csceneactor::__constructor;
    classes.cscenefakeactor[0].__vtable[-480064742] = &csceneactor::do_death_anims;
    classes.cscenefakeactor[0].__vtable[208071881] = &csceneactor::on_death;
    classes.cscenefakeactor[0].__vtable[-1865159357] = &csceneactor::set_goal;
    classes.cscenefakeactor[0].__vtable[522469748] = &csceneactor::track_goal;
    classes.cscenefakeactor[0].__vtable[751796260] = &csceneactor::_cleanup;
    classes.cscenefakeactor[0].__vtable[-800750439] = &csceneactor::_prepare;
    classes.cscenefakeactor[0].__vtable[107987567] = &csceneactor::_spawn_ent;
    classes.cscenefakeactor[0].__vtable[1606033458] = &cscenefakeactor::__destructor;
    classes.cscenefakeactor[0].__vtable[-1690805083] = &cscenefakeactor::__constructor;
}

