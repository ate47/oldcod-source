#using scripts/core_common/animation_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/laststand_shared;
#using scripts/core_common/player_shared;
#using scripts/core_common/scene_objects_shared;
#using scripts/core_common/scene_player_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/util_shared;

#namespace csceneplayer;

// Namespace csceneplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x71c9beba, Offset: 0x448
// Size: 0x54
function __constructor() {
    csceneobject::__constructor();
    self._func_get = &util::get_players;
    self._func_get_active = &util::get_active_players;
    self._n_streamer_req = -1;
}

// Namespace csceneplayer/scene_player_shared
// Params 2, eflags: 0x0
// Checksum 0x94562774, Offset: 0x4a8
// Size: 0x42
function first_init(s_objdef, o_scene) {
    s_objdef.nospawn = 1;
    return csceneobject::first_init(s_objdef, o_scene);
}

// Namespace csceneplayer/scene_player_shared
// Params 2, eflags: 0x0
// Checksum 0x869be8be, Offset: 0x4f8
// Size: 0x84
function _stop(b_dont_clear_anim, b_finished) {
    if (isalive(self._e)) {
        if (!(isdefined(self._s.diewhenfinished) && self._s.diewhenfinished) || !b_finished) {
            self._e stopanimscripted(0.2);
        }
    }
}

// Namespace csceneplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x1ef0d9f5, Offset: 0x588
// Size: 0x14c
function _spawn() {
    /#
        if (isdefined(self._o_scene._b_testing) && self._o_scene._b_testing && csceneobject::is_player()) {
            p_host = util::gethostplayer();
            if (!csceneobject::in_this_scene(p_host)) {
                self._e = p_host;
                return;
            }
        }
    #/
    if (!isdefined(self._e)) {
        foreach (ent in [[ self._func_get ]](self._str_team)) {
            if (!csceneobject::in_this_scene(ent)) {
                self._e = ent;
                return;
            }
        }
    }
}

// Namespace csceneplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x30a9a765, Offset: 0x6e0
// Size: 0x1c
function _prepare() {
    _prepare_player(self._e);
}

// Namespace csceneplayer/scene_player_shared
// Params 1, eflags: 0x0
// Checksum 0x75236d9c, Offset: 0x708
// Size: 0x720
function _prepare_player(player) {
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            printtoprightln("<dev string:x34>");
        }
    #/
    if (player.var_dd686719 === self._o_scene._str_name) {
        return 0;
    }
    player notify(#"hash_d4777ee8");
    if (player == level.host && scene::check_team(player.team, self._str_team)) {
        display_dev_info();
    }
    str_streamer_hint = self._o_scene._a_streamer_hint[player.team];
    if (isdefined(str_streamer_hint)) {
        if (self._n_streamer_req == -1) {
            self._n_streamer_req = player playerstreamerrequest("set", str_streamer_hint);
            player.var_1375be5 = str_streamer_hint;
        }
        if (self._str_shot != "init" && self._n_streamer_req != -1) {
            if (!(isdefined(level.scene_streamer_ignore[self._s.name]) && level.scene_streamer_ignore[self._s.name])) {
                if (!(isdefined(self._o_scene._s.ignorestreamer) && self._o_scene._s.ignorestreamer)) {
                    player util::streamer_wait(self._n_streamer_req, 0, 5);
                }
            }
        }
    }
    if (!(isdefined(self._s.showhud) && self._s.showhud)) {
        player scene::set_igc_active(1);
    }
    [[ self ]]->_set_values(player);
    player sethighdetail(1);
    if (player flagsys::get("mobile_armory_in_use")) {
        player flagsys::set("cancel_mobile_armory");
        player closemenu("ChooseClass_InGame");
        player notify(#"menuresponse", {#menu:"ChooseClass_InGame", #response:"cancel"});
    }
    if (player flagsys::get("mobile_armory_begin_use")) {
        player util::function_ee182f5d();
        player flagsys::clear("mobile_armory_begin_use");
    }
    if (getdvarint("scene_hide_player") > 0) {
        player hide();
    }
    player.var_dd686719 = self._o_scene._str_name;
    if (isdefined(player.hijacked_vehicle_entity)) {
        player.hijacked_vehicle_entity delete();
    } else if (player isinvehicle()) {
        vh_occupied = player getvehicleoccupied();
        n_seat = vh_occupied getoccupantseat(player);
        vh_occupied usevehicle(player, n_seat);
    }
    revive_player(player);
    player thread scene::scene_disable_player_stuff(self._o_scene._s, self._s);
    if (isdefined(self._s.var_4c0453af) && self._s.var_4c0453af) {
    }
    player.player_anim_look_enabled = !(isdefined(self._s.lockview) && self._s.lockview);
    player.player_anim_clamp_right = isdefined(self._s.viewclampright) ? self._s.viewclampright : 0;
    player.player_anim_clamp_left = isdefined(self._s.viewclampleft) ? self._s.viewclampleft : 0;
    player.player_anim_clamp_top = isdefined(self._s.viewclampbottom) ? self._s.viewclampbottom : 0;
    player.player_anim_clamp_bottom = isdefined(self._s.viewclampbottom) ? self._s.viewclampbottom : 0;
    if (isdefined(self._s.showweaponinfirstperson) && (!(isdefined(self._s.removeweapon) && self._s.removeweapon) || self._s.showweaponinfirstperson) && !(isdefined(self._s.disableprimaryweaponswitch) && self._s.disableprimaryweaponswitch)) {
        player player::switch_to_primary_weapon(1);
    }
    set_player_stance(player);
    waitframe(0);
    player notify(#"scene_ready");
}

// Namespace csceneplayer/scene_player_shared
// Params 1, eflags: 0x0
// Checksum 0x5882bb24, Offset: 0xe30
// Size: 0xa0
function on_play_anim(player) {
    if (self._n_streamer_req != -1 && !csceneobject::is_skipping_scene() && !(isdefined(player.streamer_hint_playing) && player.streamer_hint_playing)) {
        player playerstreamerrequest("play", player.var_1375be5);
        player.streamer_hint_playing = 1;
    }
}

// Namespace csceneplayer/scene_player_shared
// Params 1, eflags: 0x0
// Checksum 0x905c50e0, Offset: 0xed8
// Size: 0x6c
function revive_player(player) {
    if (player.sessionstate === "spectator") {
        player thread [[ level.spawnplayer ]]();
        return;
    }
    if (player laststand::player_is_in_laststand()) {
        player notify(#"auto_revive");
    }
}

// Namespace csceneplayer/scene_player_shared
// Params 1, eflags: 0x0
// Checksum 0x4435df97, Offset: 0xf50
// Size: 0x134
function set_player_stance(player) {
    if (self._s.playerstance === "crouch") {
        player allowstand(0);
        player allowcrouch(1);
        player allowprone(0);
        return;
    }
    if (self._s.playerstance === "prone") {
        player allowstand(0);
        player allowcrouch(0);
        player allowprone(1);
        return;
    }
    player allowstand(1);
    player allowcrouch(0);
    player allowprone(0);
}

// Namespace csceneplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x5b1ac022, Offset: 0x1090
// Size: 0x1c
function _cleanup() {
    _cleanup_player(self._e);
}

// Namespace csceneplayer/scene_player_shared
// Params 1, eflags: 0x0
// Checksum 0x8b76d4d6, Offset: 0x10b8
// Size: 0x37c
function _cleanup_player(player) {
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            printtoprightln("<dev string:x52>");
        }
    #/
    player.scene_set_visible_time = level.time;
    player setvisibletoall();
    player flagsys::clear("shared_igc");
    player flagsys::clear("scene");
    if (!(isdefined(self._s.showhud) && self._s.showhud)) {
        player util::delay(0.1, "new_scene", &scene::set_igc_active, 0);
    }
    player.var_dd686719 = undefined;
    player.scene_takedamage = undefined;
    player._scene_old_gun_removed = undefined;
    player thread scene::scene_enable_player_stuff(self._o_scene._s, self._s, self._o_scene._e_root);
    if (![[ self._o_scene ]]->function_cc8737c()) {
        if ([[ self._o_scene ]]->function_7731633d()) {
            if (!csceneobject::is_skipping_scene() && [[ self._o_scene ]]->function_e308028()) {
                [[ self._o_scene ]]->function_5a3cff18(0);
            }
            self._o_scene thread cscene::_stop_camera_anim_on_player(player);
        } else if (self._o_scene._s scene::is_igc()) {
            self._o_scene thread cscene::_stop_camera_anim_on_player(player);
        }
    }
    n_camera_tween_out = csceneobject::get_camera_tween_out();
    if (n_camera_tween_out > 0) {
        player startcameratween(n_camera_tween_out);
    }
    if (!(isdefined(self._s.dontreloadammo) && self._s.dontreloadammo)) {
        player player::fill_current_clip();
    }
    player allowstand(1);
    player allowcrouch(1);
    player allowprone(1);
    player sethighdetail(0);
    [[ self ]]->_reset_values(player);
    thread function_54ff37f7(player);
    destroy_dev_info();
}

// Namespace csceneplayer/scene_player_shared
// Params 1, eflags: 0x0
// Checksum 0x582218bc, Offset: 0x1440
// Size: 0x5a
function function_54ff37f7(player) {
    player endon(#"hash_d4777ee8");
    waitframe(5);
    player playerstreamerrequest("clear", player.var_1375be5);
    player.streamer_hint_playing = undefined;
}

// Namespace csceneplayer/scene_player_shared
// Params 3, eflags: 0x0
// Checksum 0xa4c49783, Offset: 0x14a8
// Size: 0x31a
function animation_lookup(str_anim, ent, b_camera) {
    if (!isdefined(ent)) {
        ent = self._e;
    }
    if (!isdefined(b_camera)) {
        b_camera = 0;
    }
    bundle = getscriptbundle(str_anim);
    if (isdefined(bundle) && bundle.type === "companion_anim") {
        if (isplayer(ent)) {
            if (ent util::function_4f5dd9d2()) {
                var_a71713a9 = ent;
                e_player = var_a71713a9.owner;
            } else {
                var_a71713a9 = ent.companion;
                e_player = ent;
            }
        }
        str_name = var_a71713a9 util::function_89423e7e("default");
        var_c49143cb = isdefined(e_player.var_9468bf4f) ? e_player.var_9468bf4f : "neutral";
        if (var_c49143cb == "neutral") {
            var_c49143cb = "nuetral";
        }
        if (var_c49143cb == "positive") {
            var_c49143cb = "good";
        } else if (var_c49143cb == "negative") {
            var_c49143cb = "bad";
        }
        if (b_camera) {
            str_anim = bundle.(str_name + "_xcam_" + var_c49143cb);
            if (!isdefined(str_anim)) {
                str_anim = bundle.var_9219ba46;
            }
        } else {
            if (self._s.type == "player" || self._s.type == "sharedplayer") {
                str_type = "player";
            } else if (self._s.type == "companion" || self._s.type == "sharedcompanion") {
                str_type = "companion";
            }
            str_anim = bundle.(str_name + "_anim_" + var_c49143cb + "_" + str_type);
            if (!isdefined(str_anim)) {
                str_anim = bundle.("default_anim_nuetral_" + str_type);
            }
        }
    }
    return str_anim;
}

// Namespace csceneplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0xcf098aed, Offset: 0x17d0
// Size: 0x3fc
function display_dev_info() {
    if (isstring(self._o_scene._s.devstate) && getdvarint("scr_show_shot_info_for_igcs", 0)) {
        if (!isdefined(level.hud_scene_dev_info1)) {
            level.hud_scene_dev_info1 = newhudelem();
            level.hud_scene_dev_info1.alignx = "right";
            level.hud_scene_dev_info1.aligny = "bottom";
            level.hud_scene_dev_info1.horzalign = "user_right";
            level.hud_scene_dev_info1.y = 400;
            level.hud_scene_dev_info1.fontscale = 1.3;
            level.hud_scene_dev_info1.color = (0.439216, 0.501961, 0.564706);
            level.hud_scene_dev_info1 settext("SCENE: " + toupper(self._o_scene._s.name));
        }
        if (!isdefined(level.hud_scene_dev_info2)) {
            level.hud_scene_dev_info2 = newhudelem();
            level.hud_scene_dev_info2.alignx = "right";
            level.hud_scene_dev_info2.aligny = "bottom";
            level.hud_scene_dev_info2.horzalign = "user_right";
            level.hud_scene_dev_info2.y = 420;
            level.hud_scene_dev_info2.fontscale = 1.3;
            level.hud_scene_dev_info2.color = (0.439216, 0.501961, 0.564706);
        }
        level.hud_scene_dev_info2 settext("SHOT: " + toupper(self._o_scene._s.name));
        if (!isdefined(level.hud_scene_dev_info3)) {
            level.hud_scene_dev_info3 = newhudelem();
            level.hud_scene_dev_info3.alignx = "right";
            level.hud_scene_dev_info3.aligny = "bottom";
            level.hud_scene_dev_info3.horzalign = "user_right";
            level.hud_scene_dev_info3.y = 440;
            level.hud_scene_dev_info3.fontscale = 1.3;
            level.hud_scene_dev_info3.color = (0.439216, 0.501961, 0.564706);
            level.hud_scene_dev_info3 settext("STATE: " + toupper(self._o_scene._s.devstate));
        }
        return;
    }
    destroy_dev_info();
}

// Namespace csceneplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x13370e30, Offset: 0x1bd8
// Size: 0x94
function destroy_dev_info() {
    if (isdefined(level.hud_scene_dev_info1)) {
        level.hud_scene_dev_info1 destroy();
    }
    if (isdefined(level.hud_scene_dev_info2)) {
        level.hud_scene_dev_info2 destroy();
    }
    if (isdefined(level.hud_scene_dev_info3)) {
        level.hud_scene_dev_info3 destroy();
    }
}

// Namespace csceneplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x4f590f6f, Offset: 0x1c78
// Size: 0x14
function __destructor() {
    csceneobject::__destructor();
}

#namespace scene;

// Namespace scene/scene_player_shared
// Params 0, eflags: 0x6
// Checksum 0x4125a057, Offset: 0x1c98
// Size: 0x1016
function private autoexec csceneplayer() {
    classes.csceneplayer[0] = spawnstruct();
    classes.csceneplayer[0].__vtable[964891661] = &csceneobject::get_ent;
    classes.csceneplayer[0].__vtable[-162565429] = &csceneobject::warning;
    classes.csceneplayer[0].__vtable[-32002227] = &csceneobject::error;
    classes.csceneplayer[0].__vtable[1621988813] = &csceneobject::log;
    classes.csceneplayer[0].__vtable[-1402092568] = &csceneobject::is_skipping_scene;
    classes.csceneplayer[0].__vtable[-533039539] = &csceneobject::skip_scene;
    classes.csceneplayer[0].__vtable[-770581098] = &csceneobject::skip_scene_shot_animations;
    classes.csceneplayer[0].__vtable[1704417325] = &csceneobject::skip_animation_on_server;
    classes.csceneplayer[0].__vtable[-1456645503] = &csceneobject::skip_animation_on_client;
    classes.csceneplayer[0].__vtable[-1908648798] = &csceneobject::skip_anim_on_server;
    classes.csceneplayer[0].__vtable[74477678] = &csceneobject::skip_anim_on_client;
    classes.csceneplayer[0].__vtable[930261435] = &csceneobject::_should_skip_anim;
    classes.csceneplayer[0].__vtable[-1004716425] = &csceneobject::in_a_different_scene;
    classes.csceneplayer[0].__vtable[-1414114870] = &csceneobject::in_this_scene;
    classes.csceneplayer[0].__vtable[-1769748375] = &csceneobject::is_shared_player;
    classes.csceneplayer[0].__vtable[9120349] = &csceneobject::is_player_model;
    classes.csceneplayer[0].__vtable[1426764347] = &csceneobject::is_player;
    classes.csceneplayer[0].__vtable[-1924366689] = &csceneobject::is_alive;
    classes.csceneplayer[0].__vtable[-1404324058] = &csceneobject::get_camera_tween_out;
    classes.csceneplayer[0].__vtable[1796348751] = &csceneobject::get_camera_tween;
    classes.csceneplayer[0].__vtable[-1574922781] = &csceneobject::get_lerp_time;
    classes.csceneplayer[0].__vtable[-1725384325] = &csceneobject::regroup_invulnerability;
    classes.csceneplayer[0].__vtable[372641686] = &csceneobject::play_regroup_fx_for_scene;
    classes.csceneplayer[0].__vtable[287915791] = &csceneobject::kill_ent;
    classes.csceneplayer[0].__vtable[107987567] = &csceneobject::_spawn_ent;
    classes.csceneplayer[0].__vtable[-747054044] = &csceneobject::spawn_ent;
    classes.csceneplayer[0].__vtable[1607542740] = &csceneobject::_camanimscripted;
    classes.csceneplayer[0].__vtable[-1987452985] = &csceneobject::play_camera_on_player;
    classes.csceneplayer[0].__vtable[-1471221345] = &csceneobject::play_camera;
    classes.csceneplayer[0].__vtable[-577195284] = &csceneobject::wait_for_camera;
    classes.csceneplayer[0].__vtable[1486082317] = &csceneobject::on_play_anim;
    classes.csceneplayer[0].__vtable[-2057381235] = &csceneobject::function_855eda8d;
    classes.csceneplayer[0].__vtable[-1678741042] = &csceneobject::function_9bf071ce;
    classes.csceneplayer[0].__vtable[-1706684566] = &csceneobject::_play_anim;
    classes.csceneplayer[0].__vtable[2088392420] = &csceneobject::update_alignment;
    classes.csceneplayer[0].__vtable[667971789] = &csceneobject::play_anim;
    classes.csceneplayer[0].__vtable[-51014854] = &csceneobject::animation_lookup;
    classes.csceneplayer[0].__vtable[1056386707] = &csceneobject::set_objective;
    classes.csceneplayer[0].__vtable[-378881381] = &csceneobject::restore_saved_ent;
    classes.csceneplayer[0].__vtable[-1878563751] = &csceneobject::get_orig_name;
    classes.csceneplayer[0].__vtable[737108631] = &csceneobject::_assign_unique_name;
    classes.csceneplayer[0].__vtable[1811815105] = &csceneobject::function_6bfe1ac1;
    classes.csceneplayer[0].__vtable[-2100195004] = &csceneobject::get_align_tag;
    classes.csceneplayer[0].__vtable[1666938539] = &csceneobject::get_align_ent;
    classes.csceneplayer[0].__vtable[751796260] = &csceneobject::_cleanup;
    classes.csceneplayer[0].__vtable[853843291] = &csceneobject::cleanup;
    classes.csceneplayer[0].__vtable[-1984848424] = &csceneobject::_stop;
    classes.csceneplayer[0].__vtable[-51025227] = &csceneobject::stop;
    classes.csceneplayer[0].__vtable[1058608330] = &csceneobject::reach;
    classes.csceneplayer[0].__vtable[-18066874] = &csceneobject::function_feec5246;
    classes.csceneplayer[0].__vtable[202678480] = &csceneobject::run_wait;
    classes.csceneplayer[0].__vtable[466905210] = &csceneobject::_dynamic_paths;
    classes.csceneplayer[0].__vtable[1131512199] = &csceneobject::play;
    classes.csceneplayer[0].__vtable[-990458914] = &csceneobject::get_entry;
    classes.csceneplayer[0].__vtable[656836165] = &csceneobject::has_streamer_hint;
    classes.csceneplayer[0].__vtable[-1190741896] = &csceneobject::function_b906b878;
    classes.csceneplayer[0].__vtable[1911543614] = &csceneobject::get_shot;
    classes.csceneplayer[0].__vtable[-1957955334] = &csceneobject::get_animation_name;
    classes.csceneplayer[0].__vtable[-800750439] = &csceneobject::_prepare;
    classes.csceneplayer[0].__vtable[-325140770] = &csceneobject::prepare;
    classes.csceneplayer[0].__vtable[987150381] = &csceneobject::_spawn;
    classes.csceneplayer[0].__vtable[-1686119842] = &csceneobject::spawn;
    classes.csceneplayer[0].__vtable[-1191896790] = &csceneobject::first_init;
    classes.csceneplayer[0].__vtable[-359698846] = &csceneobject::_reset_values;
    classes.csceneplayer[0].__vtable[-1553926551] = &csceneobject::_set_values;
    classes.csceneplayer[0].__vtable[551404028] = &csceneobject::reset_ent_val;
    classes.csceneplayer[0].__vtable[1285561865] = &csceneobject::set_ent_val;
    classes.csceneplayer[0].__vtable[1606033458] = &csceneobject::__destructor;
    classes.csceneplayer[0].__vtable[-1690805083] = &csceneobject::__constructor;
    classes.csceneplayer[0].__vtable[1606033458] = &csceneplayer::__destructor;
    classes.csceneplayer[0].__vtable[-2083104676] = &csceneplayer::destroy_dev_info;
    classes.csceneplayer[0].__vtable[2077358244] = &csceneplayer::display_dev_info;
    classes.csceneplayer[0].__vtable[-51014854] = &csceneplayer::animation_lookup;
    classes.csceneplayer[0].__vtable[1426012151] = &csceneplayer::function_54ff37f7;
    classes.csceneplayer[0].__vtable[-756866436] = &csceneplayer::_cleanup_player;
    classes.csceneplayer[0].__vtable[751796260] = &csceneplayer::_cleanup;
    classes.csceneplayer[0].__vtable[-165058024] = &csceneplayer::set_player_stance;
    classes.csceneplayer[0].__vtable[724938382] = &csceneplayer::revive_player;
    classes.csceneplayer[0].__vtable[1486082317] = &csceneplayer::on_play_anim;
    classes.csceneplayer[0].__vtable[1573351179] = &csceneplayer::_prepare_player;
    classes.csceneplayer[0].__vtable[-800750439] = &csceneplayer::_prepare;
    classes.csceneplayer[0].__vtable[987150381] = &csceneplayer::_spawn;
    classes.csceneplayer[0].__vtable[-1984848424] = &csceneplayer::_stop;
    classes.csceneplayer[0].__vtable[-1191896790] = &csceneplayer::first_init;
    classes.csceneplayer[0].__vtable[-1690805083] = &csceneplayer::__constructor;
}

#namespace cscenesharedplayer;

// Namespace cscenesharedplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0xc60f8132, Offset: 0x2cb8
// Size: 0xd4
function _prepare() {
    a_players = [[ self._func_get ]](self._str_team);
    foreach (ent in a_players) {
        thread [[ self ]]->_prepare_player(ent);
    }
    [[ self ]]->_set_visibility();
    array::wait_till(a_players, "scene_ready");
}

// Namespace cscenesharedplayer/scene_player_shared
// Params 4, eflags: 0x0
// Checksum 0x725e0fc9, Offset: 0x2d98
// Size: 0x3d0
function _play_anim(animation, n_rate, n_blend, n_time) {
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            printtoprightln("<dev string:x70>" + animation);
        }
    #/
    self.player_animation = animation;
    self.player_animation_notify = animation + "_notify";
    self.player_animation_length = getanimlength(animation);
    self.player_align = self.m_align;
    self.player_tag = self.m_tag;
    self.player_rate = n_rate;
    self.player_time_frac = n_time;
    self.player_start_time = gettime();
    a_players = [[ self._func_get ]](self._str_team);
    /#
        if (isdefined(self._e) && !isinarray(a_players, self._e)) {
            arrayinsert(a_players, self._e, 0);
        }
    #/
    foreach (player in a_players) {
        if (player flagsys::get("loadout_given") && player.sessionstate !== "spectator") {
            self thread _play_shared_player_anim_for_player(player);
            continue;
        }
        if (isdefined(player.initialloadoutgiven) && player.initialloadoutgiven) {
            csceneplayer::revive_player(player);
        }
    }
    waittillframeend();
    callback::on_loadout(&_play_shared_player_anim_for_player, self);
    do {
        b_playing = 0;
        foreach (player in [[ self._func_get_active ]](self._str_team)) {
            if (isdefined(player) && player flagsys::get(self.player_animation_notify)) {
                b_playing = 1;
                player flagsys::wait_till_clear(self.player_animation_notify);
                break;
            }
        }
    } while (b_playing);
    callback::remove_on_loadout(&_play_shared_player_anim_for_player, self);
    thread [[ self._o_scene ]]->_call_shot_funcs("players_done");
}

// Namespace cscenesharedplayer/scene_player_shared
// Params 1, eflags: 0x0
// Checksum 0xd63a3729, Offset: 0x3170
// Size: 0x6ec
function _play_shared_player_anim_for_player(player) {
    if (!scene::check_team(player.team, self._str_team) && player != self._e) {
        return;
    }
    player endon(#"death");
    csceneplayer::on_play_anim(player);
    /#
    #/
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            printtoprightln("<dev string:x99>" + self.player_animation);
        }
    #/
    player.current_scene = self._o_scene._str_name;
    player flagsys::set("shared_igc");
    if (player flagsys::get(self.player_animation_notify)) {
        player flagsys::set(self.player_animation_notify + "_skip_init_clear");
    }
    player flagsys::set(self.player_animation_notify);
    if (isdefined(player getlinkedent())) {
        player unlink();
    }
    if (!(isdefined(self._s.disabletransitionin) && self._s.disabletransitionin)) {
        if (player != self._e || getdvarint("scr_player1_postfx", 0)) {
            if (!isdefined(player.screen_fade_menus)) {
                if (!(isdefined(level.chyron_text_active) && level.chyron_text_active)) {
                    if (!(isdefined(player.var_6c56bb) && player.var_6c56bb)) {
                        player.play_scene_transition_effect = 1;
                    }
                }
            }
        }
    }
    csceneplayer::_prepare_player(player);
    n_time_passed = (gettime() - self.player_start_time) / 1000;
    n_start_time = self.player_time_frac * self.player_animation_length;
    n_time_left = self.player_animation_length - n_time_passed - n_start_time;
    n_time_frac = 1 - n_time_left / self.player_animation_length;
    if (isdefined(self._e) && player != self._e) {
        player dontinterpolate();
        player setorigin(self._e.origin);
        if (!player isbot()) {
            player setplayerangles(self._e getplayerangles());
        }
    }
    n_lerp = csceneobject::get_lerp_time();
    if (!self._o_scene._s scene::is_igc()) {
        n_camera_tween = csceneobject::get_camera_tween();
        if (n_camera_tween > 0) {
            player startcameratween(n_camera_tween);
        }
    }
    if (n_time_frac < 1) {
        /#
            if (getdvarint("<dev string:xcd>") > 0) {
                player hide();
            }
            if (getdvarint("<dev string:x28>") > 0) {
                printtoprightln("<dev string:xdf>" + self._s.name + "<dev string:x124>" + self.player_animation);
            }
        #/
        str_animation = self.player_animation;
        str_animation = [[ self ]]->animation_lookup(self._str_current_anim, player);
        player_num = player getentitynumber();
        if (!isdefined(self.current_playing_anim)) {
            self.current_playing_anim[player_num] = [];
        }
        self.current_playing_anim[player_num] = str_animation;
        if (csceneobject::is_skipping_scene()) {
            thread csceneobject::skip_scene(1);
        }
        player animation::play(str_animation, self.player_align, self.player_tag, self.player_rate, 0, 0, n_lerp, n_time_frac, self._s.showweaponinfirstperson);
        if (!player flagsys::get(self.player_animation_notify + "_skip_init_clear")) {
            player flagsys::clear(self.player_animation_notify);
        } else {
            player flagsys::clear(self.player_animation_notify + "_skip_init_clear");
        }
        if (!player isplayinganimscripted()) {
            self.current_playing_anim[player_num] = undefined;
        }
        /#
            if (getdvarint("<dev string:x28>") > 0) {
                printtoprightln("<dev string:x128>" + self._s.name + "<dev string:x170>" + self.player_animation);
            }
        #/
    }
}

// Namespace cscenesharedplayer/scene_player_shared
// Params 1, eflags: 0x0
// Checksum 0xef8d7f9a, Offset: 0x3868
// Size: 0x280
function _set_visibility(player) {
    a_players = [[ self._func_get ]](self._str_team);
    foreach (player in a_players) {
        player setinvisibletoall();
    }
    foreach (player in getplayers()) {
        if (isdefined(player.owner)) {
            player setvisibletoplayer(player.owner);
        }
    }
    if (self._str_team != "any") {
        foreach (str_team in level.teams) {
            if (str_team != self._str_team) {
                foreach (player in getplayers(str_team)) {
                    a_players[0] setvisibletoplayer(player);
                }
            }
        }
    }
}

// Namespace cscenesharedplayer/scene_player_shared
// Params 2, eflags: 0x0
// Checksum 0x1b03fc0c, Offset: 0x3af0
// Size: 0xb2
function _stop(b_dont_clear_anim, b_finished) {
    foreach (player in [[ self._func_get ]](self._str_team)) {
        player stopanimscripted(0.2);
    }
}

// Namespace cscenesharedplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0xf8398977, Offset: 0x3bb0
// Size: 0x9a
function _cleanup() {
    foreach (player in [[ self._func_get ]](self._str_team)) {
        csceneplayer::_cleanup_player(player);
    }
}

// Namespace cscenesharedplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x103a54bb, Offset: 0x3c58
// Size: 0x14
function __constructor() {
    csceneplayer::__constructor();
}

// Namespace cscenesharedplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x5c046643, Offset: 0x3c78
// Size: 0x14
function __destructor() {
    csceneplayer::__destructor();
}

#namespace scene;

// Namespace scene/scene_player_shared
// Params 0, eflags: 0x6
// Checksum 0x122ecc96, Offset: 0x3c98
// Size: 0x1196
function private autoexec cscenesharedplayer() {
    classes.cscenesharedplayer[0] = spawnstruct();
    classes.cscenesharedplayer[0].__vtable[964891661] = &csceneobject::get_ent;
    classes.cscenesharedplayer[0].__vtable[-162565429] = &csceneobject::warning;
    classes.cscenesharedplayer[0].__vtable[-32002227] = &csceneobject::error;
    classes.cscenesharedplayer[0].__vtable[1621988813] = &csceneobject::log;
    classes.cscenesharedplayer[0].__vtable[-1402092568] = &csceneobject::is_skipping_scene;
    classes.cscenesharedplayer[0].__vtable[-533039539] = &csceneobject::skip_scene;
    classes.cscenesharedplayer[0].__vtable[-770581098] = &csceneobject::skip_scene_shot_animations;
    classes.cscenesharedplayer[0].__vtable[1704417325] = &csceneobject::skip_animation_on_server;
    classes.cscenesharedplayer[0].__vtable[-1456645503] = &csceneobject::skip_animation_on_client;
    classes.cscenesharedplayer[0].__vtable[-1908648798] = &csceneobject::skip_anim_on_server;
    classes.cscenesharedplayer[0].__vtable[74477678] = &csceneobject::skip_anim_on_client;
    classes.cscenesharedplayer[0].__vtable[930261435] = &csceneobject::_should_skip_anim;
    classes.cscenesharedplayer[0].__vtable[-1004716425] = &csceneobject::in_a_different_scene;
    classes.cscenesharedplayer[0].__vtable[-1414114870] = &csceneobject::in_this_scene;
    classes.cscenesharedplayer[0].__vtable[-1769748375] = &csceneobject::is_shared_player;
    classes.cscenesharedplayer[0].__vtable[9120349] = &csceneobject::is_player_model;
    classes.cscenesharedplayer[0].__vtable[1426764347] = &csceneobject::is_player;
    classes.cscenesharedplayer[0].__vtable[-1924366689] = &csceneobject::is_alive;
    classes.cscenesharedplayer[0].__vtable[-1404324058] = &csceneobject::get_camera_tween_out;
    classes.cscenesharedplayer[0].__vtable[1796348751] = &csceneobject::get_camera_tween;
    classes.cscenesharedplayer[0].__vtable[-1574922781] = &csceneobject::get_lerp_time;
    classes.cscenesharedplayer[0].__vtable[-1725384325] = &csceneobject::regroup_invulnerability;
    classes.cscenesharedplayer[0].__vtable[372641686] = &csceneobject::play_regroup_fx_for_scene;
    classes.cscenesharedplayer[0].__vtable[287915791] = &csceneobject::kill_ent;
    classes.cscenesharedplayer[0].__vtable[107987567] = &csceneobject::_spawn_ent;
    classes.cscenesharedplayer[0].__vtable[-747054044] = &csceneobject::spawn_ent;
    classes.cscenesharedplayer[0].__vtable[1607542740] = &csceneobject::_camanimscripted;
    classes.cscenesharedplayer[0].__vtable[-1987452985] = &csceneobject::play_camera_on_player;
    classes.cscenesharedplayer[0].__vtable[-1471221345] = &csceneobject::play_camera;
    classes.cscenesharedplayer[0].__vtable[-577195284] = &csceneobject::wait_for_camera;
    classes.cscenesharedplayer[0].__vtable[1486082317] = &csceneobject::on_play_anim;
    classes.cscenesharedplayer[0].__vtable[-2057381235] = &csceneobject::function_855eda8d;
    classes.cscenesharedplayer[0].__vtable[-1678741042] = &csceneobject::function_9bf071ce;
    classes.cscenesharedplayer[0].__vtable[-1706684566] = &csceneobject::_play_anim;
    classes.cscenesharedplayer[0].__vtable[2088392420] = &csceneobject::update_alignment;
    classes.cscenesharedplayer[0].__vtable[667971789] = &csceneobject::play_anim;
    classes.cscenesharedplayer[0].__vtable[-51014854] = &csceneobject::animation_lookup;
    classes.cscenesharedplayer[0].__vtable[1056386707] = &csceneobject::set_objective;
    classes.cscenesharedplayer[0].__vtable[-378881381] = &csceneobject::restore_saved_ent;
    classes.cscenesharedplayer[0].__vtable[-1878563751] = &csceneobject::get_orig_name;
    classes.cscenesharedplayer[0].__vtable[737108631] = &csceneobject::_assign_unique_name;
    classes.cscenesharedplayer[0].__vtable[1811815105] = &csceneobject::function_6bfe1ac1;
    classes.cscenesharedplayer[0].__vtable[-2100195004] = &csceneobject::get_align_tag;
    classes.cscenesharedplayer[0].__vtable[1666938539] = &csceneobject::get_align_ent;
    classes.cscenesharedplayer[0].__vtable[751796260] = &csceneobject::_cleanup;
    classes.cscenesharedplayer[0].__vtable[853843291] = &csceneobject::cleanup;
    classes.cscenesharedplayer[0].__vtable[-1984848424] = &csceneobject::_stop;
    classes.cscenesharedplayer[0].__vtable[-51025227] = &csceneobject::stop;
    classes.cscenesharedplayer[0].__vtable[1058608330] = &csceneobject::reach;
    classes.cscenesharedplayer[0].__vtable[-18066874] = &csceneobject::function_feec5246;
    classes.cscenesharedplayer[0].__vtable[202678480] = &csceneobject::run_wait;
    classes.cscenesharedplayer[0].__vtable[466905210] = &csceneobject::_dynamic_paths;
    classes.cscenesharedplayer[0].__vtable[1131512199] = &csceneobject::play;
    classes.cscenesharedplayer[0].__vtable[-990458914] = &csceneobject::get_entry;
    classes.cscenesharedplayer[0].__vtable[656836165] = &csceneobject::has_streamer_hint;
    classes.cscenesharedplayer[0].__vtable[-1190741896] = &csceneobject::function_b906b878;
    classes.cscenesharedplayer[0].__vtable[1911543614] = &csceneobject::get_shot;
    classes.cscenesharedplayer[0].__vtable[-1957955334] = &csceneobject::get_animation_name;
    classes.cscenesharedplayer[0].__vtable[-800750439] = &csceneobject::_prepare;
    classes.cscenesharedplayer[0].__vtable[-325140770] = &csceneobject::prepare;
    classes.cscenesharedplayer[0].__vtable[987150381] = &csceneobject::_spawn;
    classes.cscenesharedplayer[0].__vtable[-1686119842] = &csceneobject::spawn;
    classes.cscenesharedplayer[0].__vtable[-1191896790] = &csceneobject::first_init;
    classes.cscenesharedplayer[0].__vtable[-359698846] = &csceneobject::_reset_values;
    classes.cscenesharedplayer[0].__vtable[-1553926551] = &csceneobject::_set_values;
    classes.cscenesharedplayer[0].__vtable[551404028] = &csceneobject::reset_ent_val;
    classes.cscenesharedplayer[0].__vtable[1285561865] = &csceneobject::set_ent_val;
    classes.cscenesharedplayer[0].__vtable[1606033458] = &csceneobject::__destructor;
    classes.cscenesharedplayer[0].__vtable[-1690805083] = &csceneobject::__constructor;
    classes.cscenesharedplayer[0].__vtable[1606033458] = &csceneplayer::__destructor;
    classes.cscenesharedplayer[0].__vtable[-2083104676] = &csceneplayer::destroy_dev_info;
    classes.cscenesharedplayer[0].__vtable[2077358244] = &csceneplayer::display_dev_info;
    classes.cscenesharedplayer[0].__vtable[-51014854] = &csceneplayer::animation_lookup;
    classes.cscenesharedplayer[0].__vtable[1426012151] = &csceneplayer::function_54ff37f7;
    classes.cscenesharedplayer[0].__vtable[-756866436] = &csceneplayer::_cleanup_player;
    classes.cscenesharedplayer[0].__vtable[751796260] = &csceneplayer::_cleanup;
    classes.cscenesharedplayer[0].__vtable[-165058024] = &csceneplayer::set_player_stance;
    classes.cscenesharedplayer[0].__vtable[724938382] = &csceneplayer::revive_player;
    classes.cscenesharedplayer[0].__vtable[1486082317] = &csceneplayer::on_play_anim;
    classes.cscenesharedplayer[0].__vtable[1573351179] = &csceneplayer::_prepare_player;
    classes.cscenesharedplayer[0].__vtable[-800750439] = &csceneplayer::_prepare;
    classes.cscenesharedplayer[0].__vtable[987150381] = &csceneplayer::_spawn;
    classes.cscenesharedplayer[0].__vtable[-1984848424] = &csceneplayer::_stop;
    classes.cscenesharedplayer[0].__vtable[-1191896790] = &csceneplayer::first_init;
    classes.cscenesharedplayer[0].__vtable[-1690805083] = &csceneplayer::__constructor;
    classes.cscenesharedplayer[0].__vtable[1606033458] = &cscenesharedplayer::__destructor;
    classes.cscenesharedplayer[0].__vtable[-1690805083] = &cscenesharedplayer::__constructor;
    classes.cscenesharedplayer[0].__vtable[751796260] = &cscenesharedplayer::_cleanup;
    classes.cscenesharedplayer[0].__vtable[-1984848424] = &cscenesharedplayer::_stop;
    classes.cscenesharedplayer[0].__vtable[1139080151] = &cscenesharedplayer::_set_visibility;
    classes.cscenesharedplayer[0].__vtable[1466913678] = &cscenesharedplayer::_play_shared_player_anim_for_player;
    classes.cscenesharedplayer[0].__vtable[-1706684566] = &cscenesharedplayer::_play_anim;
    classes.cscenesharedplayer[0].__vtable[-800750439] = &cscenesharedplayer::_prepare;
}

#namespace cscenefakeplayer;

// Namespace cscenefakeplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0xfa9a1168, Offset: 0x4e38
// Size: 0x14
function __constructor() {
    csceneobject::__constructor();
}

// Namespace cscenefakeplayer/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x4d3e6497, Offset: 0x4e58
// Size: 0x14
function __destructor() {
    csceneobject::__destructor();
}

#namespace scene;

// Namespace scene/scene_player_shared
// Params 0, eflags: 0x6
// Checksum 0x48e8dd5e, Offset: 0x4e78
// Size: 0xd76
function private autoexec cscenefakeplayer() {
    classes.cscenefakeplayer[0] = spawnstruct();
    classes.cscenefakeplayer[0].__vtable[964891661] = &csceneobject::get_ent;
    classes.cscenefakeplayer[0].__vtable[-162565429] = &csceneobject::warning;
    classes.cscenefakeplayer[0].__vtable[-32002227] = &csceneobject::error;
    classes.cscenefakeplayer[0].__vtable[1621988813] = &csceneobject::log;
    classes.cscenefakeplayer[0].__vtable[-1402092568] = &csceneobject::is_skipping_scene;
    classes.cscenefakeplayer[0].__vtable[-533039539] = &csceneobject::skip_scene;
    classes.cscenefakeplayer[0].__vtable[-770581098] = &csceneobject::skip_scene_shot_animations;
    classes.cscenefakeplayer[0].__vtable[1704417325] = &csceneobject::skip_animation_on_server;
    classes.cscenefakeplayer[0].__vtable[-1456645503] = &csceneobject::skip_animation_on_client;
    classes.cscenefakeplayer[0].__vtable[-1908648798] = &csceneobject::skip_anim_on_server;
    classes.cscenefakeplayer[0].__vtable[74477678] = &csceneobject::skip_anim_on_client;
    classes.cscenefakeplayer[0].__vtable[930261435] = &csceneobject::_should_skip_anim;
    classes.cscenefakeplayer[0].__vtable[-1004716425] = &csceneobject::in_a_different_scene;
    classes.cscenefakeplayer[0].__vtable[-1414114870] = &csceneobject::in_this_scene;
    classes.cscenefakeplayer[0].__vtable[-1769748375] = &csceneobject::is_shared_player;
    classes.cscenefakeplayer[0].__vtable[9120349] = &csceneobject::is_player_model;
    classes.cscenefakeplayer[0].__vtable[1426764347] = &csceneobject::is_player;
    classes.cscenefakeplayer[0].__vtable[-1924366689] = &csceneobject::is_alive;
    classes.cscenefakeplayer[0].__vtable[-1404324058] = &csceneobject::get_camera_tween_out;
    classes.cscenefakeplayer[0].__vtable[1796348751] = &csceneobject::get_camera_tween;
    classes.cscenefakeplayer[0].__vtable[-1574922781] = &csceneobject::get_lerp_time;
    classes.cscenefakeplayer[0].__vtable[-1725384325] = &csceneobject::regroup_invulnerability;
    classes.cscenefakeplayer[0].__vtable[372641686] = &csceneobject::play_regroup_fx_for_scene;
    classes.cscenefakeplayer[0].__vtable[287915791] = &csceneobject::kill_ent;
    classes.cscenefakeplayer[0].__vtable[107987567] = &csceneobject::_spawn_ent;
    classes.cscenefakeplayer[0].__vtable[-747054044] = &csceneobject::spawn_ent;
    classes.cscenefakeplayer[0].__vtable[1607542740] = &csceneobject::_camanimscripted;
    classes.cscenefakeplayer[0].__vtable[-1987452985] = &csceneobject::play_camera_on_player;
    classes.cscenefakeplayer[0].__vtable[-1471221345] = &csceneobject::play_camera;
    classes.cscenefakeplayer[0].__vtable[-577195284] = &csceneobject::wait_for_camera;
    classes.cscenefakeplayer[0].__vtable[1486082317] = &csceneobject::on_play_anim;
    classes.cscenefakeplayer[0].__vtable[-2057381235] = &csceneobject::function_855eda8d;
    classes.cscenefakeplayer[0].__vtable[-1678741042] = &csceneobject::function_9bf071ce;
    classes.cscenefakeplayer[0].__vtable[-1706684566] = &csceneobject::_play_anim;
    classes.cscenefakeplayer[0].__vtable[2088392420] = &csceneobject::update_alignment;
    classes.cscenefakeplayer[0].__vtable[667971789] = &csceneobject::play_anim;
    classes.cscenefakeplayer[0].__vtable[-51014854] = &csceneobject::animation_lookup;
    classes.cscenefakeplayer[0].__vtable[1056386707] = &csceneobject::set_objective;
    classes.cscenefakeplayer[0].__vtable[-378881381] = &csceneobject::restore_saved_ent;
    classes.cscenefakeplayer[0].__vtable[-1878563751] = &csceneobject::get_orig_name;
    classes.cscenefakeplayer[0].__vtable[737108631] = &csceneobject::_assign_unique_name;
    classes.cscenefakeplayer[0].__vtable[1811815105] = &csceneobject::function_6bfe1ac1;
    classes.cscenefakeplayer[0].__vtable[-2100195004] = &csceneobject::get_align_tag;
    classes.cscenefakeplayer[0].__vtable[1666938539] = &csceneobject::get_align_ent;
    classes.cscenefakeplayer[0].__vtable[751796260] = &csceneobject::_cleanup;
    classes.cscenefakeplayer[0].__vtable[853843291] = &csceneobject::cleanup;
    classes.cscenefakeplayer[0].__vtable[-1984848424] = &csceneobject::_stop;
    classes.cscenefakeplayer[0].__vtable[-51025227] = &csceneobject::stop;
    classes.cscenefakeplayer[0].__vtable[1058608330] = &csceneobject::reach;
    classes.cscenefakeplayer[0].__vtable[-18066874] = &csceneobject::function_feec5246;
    classes.cscenefakeplayer[0].__vtable[202678480] = &csceneobject::run_wait;
    classes.cscenefakeplayer[0].__vtable[466905210] = &csceneobject::_dynamic_paths;
    classes.cscenefakeplayer[0].__vtable[1131512199] = &csceneobject::play;
    classes.cscenefakeplayer[0].__vtable[-990458914] = &csceneobject::get_entry;
    classes.cscenefakeplayer[0].__vtable[656836165] = &csceneobject::has_streamer_hint;
    classes.cscenefakeplayer[0].__vtable[-1190741896] = &csceneobject::function_b906b878;
    classes.cscenefakeplayer[0].__vtable[1911543614] = &csceneobject::get_shot;
    classes.cscenefakeplayer[0].__vtable[-1957955334] = &csceneobject::get_animation_name;
    classes.cscenefakeplayer[0].__vtable[-800750439] = &csceneobject::_prepare;
    classes.cscenefakeplayer[0].__vtable[-325140770] = &csceneobject::prepare;
    classes.cscenefakeplayer[0].__vtable[987150381] = &csceneobject::_spawn;
    classes.cscenefakeplayer[0].__vtable[-1686119842] = &csceneobject::spawn;
    classes.cscenefakeplayer[0].__vtable[-1191896790] = &csceneobject::first_init;
    classes.cscenefakeplayer[0].__vtable[-359698846] = &csceneobject::_reset_values;
    classes.cscenefakeplayer[0].__vtable[-1553926551] = &csceneobject::_set_values;
    classes.cscenefakeplayer[0].__vtable[551404028] = &csceneobject::reset_ent_val;
    classes.cscenefakeplayer[0].__vtable[1285561865] = &csceneobject::set_ent_val;
    classes.cscenefakeplayer[0].__vtable[1606033458] = &csceneobject::__destructor;
    classes.cscenefakeplayer[0].__vtable[-1690805083] = &csceneobject::__constructor;
    classes.cscenefakeplayer[0].__vtable[1606033458] = &cscenefakeplayer::__destructor;
    classes.cscenefakeplayer[0].__vtable[-1690805083] = &cscenefakeplayer::__constructor;
}

#namespace cscenecompanion;

// Namespace cscenecompanion/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0xf16c062b, Offset: 0x5bf8
// Size: 0x44
function __constructor() {
    csceneplayer::__constructor();
    self._func_get = &util::function_bb1c6fbf;
    self._func_get_active = &util::function_12a66d92;
}

// Namespace cscenecompanion/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x2d5db734, Offset: 0x5c48
// Size: 0x14
function __destructor() {
    csceneplayer::__destructor();
}

#namespace scene;

// Namespace scene/scene_player_shared
// Params 0, eflags: 0x6
// Checksum 0x1db5d3a7, Offset: 0x5c68
// Size: 0x1076
function private autoexec cscenecompanion() {
    classes.cscenecompanion[0] = spawnstruct();
    classes.cscenecompanion[0].__vtable[964891661] = &csceneobject::get_ent;
    classes.cscenecompanion[0].__vtable[-162565429] = &csceneobject::warning;
    classes.cscenecompanion[0].__vtable[-32002227] = &csceneobject::error;
    classes.cscenecompanion[0].__vtable[1621988813] = &csceneobject::log;
    classes.cscenecompanion[0].__vtable[-1402092568] = &csceneobject::is_skipping_scene;
    classes.cscenecompanion[0].__vtable[-533039539] = &csceneobject::skip_scene;
    classes.cscenecompanion[0].__vtable[-770581098] = &csceneobject::skip_scene_shot_animations;
    classes.cscenecompanion[0].__vtable[1704417325] = &csceneobject::skip_animation_on_server;
    classes.cscenecompanion[0].__vtable[-1456645503] = &csceneobject::skip_animation_on_client;
    classes.cscenecompanion[0].__vtable[-1908648798] = &csceneobject::skip_anim_on_server;
    classes.cscenecompanion[0].__vtable[74477678] = &csceneobject::skip_anim_on_client;
    classes.cscenecompanion[0].__vtable[930261435] = &csceneobject::_should_skip_anim;
    classes.cscenecompanion[0].__vtable[-1004716425] = &csceneobject::in_a_different_scene;
    classes.cscenecompanion[0].__vtable[-1414114870] = &csceneobject::in_this_scene;
    classes.cscenecompanion[0].__vtable[-1769748375] = &csceneobject::is_shared_player;
    classes.cscenecompanion[0].__vtable[9120349] = &csceneobject::is_player_model;
    classes.cscenecompanion[0].__vtable[1426764347] = &csceneobject::is_player;
    classes.cscenecompanion[0].__vtable[-1924366689] = &csceneobject::is_alive;
    classes.cscenecompanion[0].__vtable[-1404324058] = &csceneobject::get_camera_tween_out;
    classes.cscenecompanion[0].__vtable[1796348751] = &csceneobject::get_camera_tween;
    classes.cscenecompanion[0].__vtable[-1574922781] = &csceneobject::get_lerp_time;
    classes.cscenecompanion[0].__vtable[-1725384325] = &csceneobject::regroup_invulnerability;
    classes.cscenecompanion[0].__vtable[372641686] = &csceneobject::play_regroup_fx_for_scene;
    classes.cscenecompanion[0].__vtable[287915791] = &csceneobject::kill_ent;
    classes.cscenecompanion[0].__vtable[107987567] = &csceneobject::_spawn_ent;
    classes.cscenecompanion[0].__vtable[-747054044] = &csceneobject::spawn_ent;
    classes.cscenecompanion[0].__vtable[1607542740] = &csceneobject::_camanimscripted;
    classes.cscenecompanion[0].__vtable[-1987452985] = &csceneobject::play_camera_on_player;
    classes.cscenecompanion[0].__vtable[-1471221345] = &csceneobject::play_camera;
    classes.cscenecompanion[0].__vtable[-577195284] = &csceneobject::wait_for_camera;
    classes.cscenecompanion[0].__vtable[1486082317] = &csceneobject::on_play_anim;
    classes.cscenecompanion[0].__vtable[-2057381235] = &csceneobject::function_855eda8d;
    classes.cscenecompanion[0].__vtable[-1678741042] = &csceneobject::function_9bf071ce;
    classes.cscenecompanion[0].__vtable[-1706684566] = &csceneobject::_play_anim;
    classes.cscenecompanion[0].__vtable[2088392420] = &csceneobject::update_alignment;
    classes.cscenecompanion[0].__vtable[667971789] = &csceneobject::play_anim;
    classes.cscenecompanion[0].__vtable[-51014854] = &csceneobject::animation_lookup;
    classes.cscenecompanion[0].__vtable[1056386707] = &csceneobject::set_objective;
    classes.cscenecompanion[0].__vtable[-378881381] = &csceneobject::restore_saved_ent;
    classes.cscenecompanion[0].__vtable[-1878563751] = &csceneobject::get_orig_name;
    classes.cscenecompanion[0].__vtable[737108631] = &csceneobject::_assign_unique_name;
    classes.cscenecompanion[0].__vtable[1811815105] = &csceneobject::function_6bfe1ac1;
    classes.cscenecompanion[0].__vtable[-2100195004] = &csceneobject::get_align_tag;
    classes.cscenecompanion[0].__vtable[1666938539] = &csceneobject::get_align_ent;
    classes.cscenecompanion[0].__vtable[751796260] = &csceneobject::_cleanup;
    classes.cscenecompanion[0].__vtable[853843291] = &csceneobject::cleanup;
    classes.cscenecompanion[0].__vtable[-1984848424] = &csceneobject::_stop;
    classes.cscenecompanion[0].__vtable[-51025227] = &csceneobject::stop;
    classes.cscenecompanion[0].__vtable[1058608330] = &csceneobject::reach;
    classes.cscenecompanion[0].__vtable[-18066874] = &csceneobject::function_feec5246;
    classes.cscenecompanion[0].__vtable[202678480] = &csceneobject::run_wait;
    classes.cscenecompanion[0].__vtable[466905210] = &csceneobject::_dynamic_paths;
    classes.cscenecompanion[0].__vtable[1131512199] = &csceneobject::play;
    classes.cscenecompanion[0].__vtable[-990458914] = &csceneobject::get_entry;
    classes.cscenecompanion[0].__vtable[656836165] = &csceneobject::has_streamer_hint;
    classes.cscenecompanion[0].__vtable[-1190741896] = &csceneobject::function_b906b878;
    classes.cscenecompanion[0].__vtable[1911543614] = &csceneobject::get_shot;
    classes.cscenecompanion[0].__vtable[-1957955334] = &csceneobject::get_animation_name;
    classes.cscenecompanion[0].__vtable[-800750439] = &csceneobject::_prepare;
    classes.cscenecompanion[0].__vtable[-325140770] = &csceneobject::prepare;
    classes.cscenecompanion[0].__vtable[987150381] = &csceneobject::_spawn;
    classes.cscenecompanion[0].__vtable[-1686119842] = &csceneobject::spawn;
    classes.cscenecompanion[0].__vtable[-1191896790] = &csceneobject::first_init;
    classes.cscenecompanion[0].__vtable[-359698846] = &csceneobject::_reset_values;
    classes.cscenecompanion[0].__vtable[-1553926551] = &csceneobject::_set_values;
    classes.cscenecompanion[0].__vtable[551404028] = &csceneobject::reset_ent_val;
    classes.cscenecompanion[0].__vtable[1285561865] = &csceneobject::set_ent_val;
    classes.cscenecompanion[0].__vtable[1606033458] = &csceneobject::__destructor;
    classes.cscenecompanion[0].__vtable[-1690805083] = &csceneobject::__constructor;
    classes.cscenecompanion[0].__vtable[1606033458] = &csceneplayer::__destructor;
    classes.cscenecompanion[0].__vtable[-2083104676] = &csceneplayer::destroy_dev_info;
    classes.cscenecompanion[0].__vtable[2077358244] = &csceneplayer::display_dev_info;
    classes.cscenecompanion[0].__vtable[-51014854] = &csceneplayer::animation_lookup;
    classes.cscenecompanion[0].__vtable[1426012151] = &csceneplayer::function_54ff37f7;
    classes.cscenecompanion[0].__vtable[-756866436] = &csceneplayer::_cleanup_player;
    classes.cscenecompanion[0].__vtable[751796260] = &csceneplayer::_cleanup;
    classes.cscenecompanion[0].__vtable[-165058024] = &csceneplayer::set_player_stance;
    classes.cscenecompanion[0].__vtable[724938382] = &csceneplayer::revive_player;
    classes.cscenecompanion[0].__vtable[1486082317] = &csceneplayer::on_play_anim;
    classes.cscenecompanion[0].__vtable[1573351179] = &csceneplayer::_prepare_player;
    classes.cscenecompanion[0].__vtable[-800750439] = &csceneplayer::_prepare;
    classes.cscenecompanion[0].__vtable[987150381] = &csceneplayer::_spawn;
    classes.cscenecompanion[0].__vtable[-1984848424] = &csceneplayer::_stop;
    classes.cscenecompanion[0].__vtable[-1191896790] = &csceneplayer::first_init;
    classes.cscenecompanion[0].__vtable[-1690805083] = &csceneplayer::__constructor;
    classes.cscenecompanion[0].__vtable[1606033458] = &cscenecompanion::__destructor;
    classes.cscenecompanion[0].__vtable[-1690805083] = &cscenecompanion::__constructor;
}

#namespace cscenesharedcompanion;

// Namespace cscenesharedcompanion/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x72e33ff1, Offset: 0x6ce8
// Size: 0x44
function __constructor() {
    cscenesharedplayer::__constructor();
    self._func_get = &util::function_bb1c6fbf;
    self._func_get_active = &util::function_12a66d92;
}

// Namespace cscenesharedcompanion/scene_player_shared
// Params 0, eflags: 0x0
// Checksum 0x359cdd5e, Offset: 0x6d38
// Size: 0x14
function __destructor() {
    cscenesharedplayer::__destructor();
}

#namespace scene;

// Namespace scene/scene_player_shared
// Params 0, eflags: 0x6
// Checksum 0xfd00f40a, Offset: 0x6d58
// Size: 0x11f6
function private autoexec cscenesharedcompanion() {
    classes.cscenesharedcompanion[0] = spawnstruct();
    classes.cscenesharedcompanion[0].__vtable[964891661] = &csceneobject::get_ent;
    classes.cscenesharedcompanion[0].__vtable[-162565429] = &csceneobject::warning;
    classes.cscenesharedcompanion[0].__vtable[-32002227] = &csceneobject::error;
    classes.cscenesharedcompanion[0].__vtable[1621988813] = &csceneobject::log;
    classes.cscenesharedcompanion[0].__vtable[-1402092568] = &csceneobject::is_skipping_scene;
    classes.cscenesharedcompanion[0].__vtable[-533039539] = &csceneobject::skip_scene;
    classes.cscenesharedcompanion[0].__vtable[-770581098] = &csceneobject::skip_scene_shot_animations;
    classes.cscenesharedcompanion[0].__vtable[1704417325] = &csceneobject::skip_animation_on_server;
    classes.cscenesharedcompanion[0].__vtable[-1456645503] = &csceneobject::skip_animation_on_client;
    classes.cscenesharedcompanion[0].__vtable[-1908648798] = &csceneobject::skip_anim_on_server;
    classes.cscenesharedcompanion[0].__vtable[74477678] = &csceneobject::skip_anim_on_client;
    classes.cscenesharedcompanion[0].__vtable[930261435] = &csceneobject::_should_skip_anim;
    classes.cscenesharedcompanion[0].__vtable[-1004716425] = &csceneobject::in_a_different_scene;
    classes.cscenesharedcompanion[0].__vtable[-1414114870] = &csceneobject::in_this_scene;
    classes.cscenesharedcompanion[0].__vtable[-1769748375] = &csceneobject::is_shared_player;
    classes.cscenesharedcompanion[0].__vtable[9120349] = &csceneobject::is_player_model;
    classes.cscenesharedcompanion[0].__vtable[1426764347] = &csceneobject::is_player;
    classes.cscenesharedcompanion[0].__vtable[-1924366689] = &csceneobject::is_alive;
    classes.cscenesharedcompanion[0].__vtable[-1404324058] = &csceneobject::get_camera_tween_out;
    classes.cscenesharedcompanion[0].__vtable[1796348751] = &csceneobject::get_camera_tween;
    classes.cscenesharedcompanion[0].__vtable[-1574922781] = &csceneobject::get_lerp_time;
    classes.cscenesharedcompanion[0].__vtable[-1725384325] = &csceneobject::regroup_invulnerability;
    classes.cscenesharedcompanion[0].__vtable[372641686] = &csceneobject::play_regroup_fx_for_scene;
    classes.cscenesharedcompanion[0].__vtable[287915791] = &csceneobject::kill_ent;
    classes.cscenesharedcompanion[0].__vtable[107987567] = &csceneobject::_spawn_ent;
    classes.cscenesharedcompanion[0].__vtable[-747054044] = &csceneobject::spawn_ent;
    classes.cscenesharedcompanion[0].__vtable[1607542740] = &csceneobject::_camanimscripted;
    classes.cscenesharedcompanion[0].__vtable[-1987452985] = &csceneobject::play_camera_on_player;
    classes.cscenesharedcompanion[0].__vtable[-1471221345] = &csceneobject::play_camera;
    classes.cscenesharedcompanion[0].__vtable[-577195284] = &csceneobject::wait_for_camera;
    classes.cscenesharedcompanion[0].__vtable[1486082317] = &csceneobject::on_play_anim;
    classes.cscenesharedcompanion[0].__vtable[-2057381235] = &csceneobject::function_855eda8d;
    classes.cscenesharedcompanion[0].__vtable[-1678741042] = &csceneobject::function_9bf071ce;
    classes.cscenesharedcompanion[0].__vtable[-1706684566] = &csceneobject::_play_anim;
    classes.cscenesharedcompanion[0].__vtable[2088392420] = &csceneobject::update_alignment;
    classes.cscenesharedcompanion[0].__vtable[667971789] = &csceneobject::play_anim;
    classes.cscenesharedcompanion[0].__vtable[-51014854] = &csceneobject::animation_lookup;
    classes.cscenesharedcompanion[0].__vtable[1056386707] = &csceneobject::set_objective;
    classes.cscenesharedcompanion[0].__vtable[-378881381] = &csceneobject::restore_saved_ent;
    classes.cscenesharedcompanion[0].__vtable[-1878563751] = &csceneobject::get_orig_name;
    classes.cscenesharedcompanion[0].__vtable[737108631] = &csceneobject::_assign_unique_name;
    classes.cscenesharedcompanion[0].__vtable[1811815105] = &csceneobject::function_6bfe1ac1;
    classes.cscenesharedcompanion[0].__vtable[-2100195004] = &csceneobject::get_align_tag;
    classes.cscenesharedcompanion[0].__vtable[1666938539] = &csceneobject::get_align_ent;
    classes.cscenesharedcompanion[0].__vtable[751796260] = &csceneobject::_cleanup;
    classes.cscenesharedcompanion[0].__vtable[853843291] = &csceneobject::cleanup;
    classes.cscenesharedcompanion[0].__vtable[-1984848424] = &csceneobject::_stop;
    classes.cscenesharedcompanion[0].__vtable[-51025227] = &csceneobject::stop;
    classes.cscenesharedcompanion[0].__vtable[1058608330] = &csceneobject::reach;
    classes.cscenesharedcompanion[0].__vtable[-18066874] = &csceneobject::function_feec5246;
    classes.cscenesharedcompanion[0].__vtable[202678480] = &csceneobject::run_wait;
    classes.cscenesharedcompanion[0].__vtable[466905210] = &csceneobject::_dynamic_paths;
    classes.cscenesharedcompanion[0].__vtable[1131512199] = &csceneobject::play;
    classes.cscenesharedcompanion[0].__vtable[-990458914] = &csceneobject::get_entry;
    classes.cscenesharedcompanion[0].__vtable[656836165] = &csceneobject::has_streamer_hint;
    classes.cscenesharedcompanion[0].__vtable[-1190741896] = &csceneobject::function_b906b878;
    classes.cscenesharedcompanion[0].__vtable[1911543614] = &csceneobject::get_shot;
    classes.cscenesharedcompanion[0].__vtable[-1957955334] = &csceneobject::get_animation_name;
    classes.cscenesharedcompanion[0].__vtable[-800750439] = &csceneobject::_prepare;
    classes.cscenesharedcompanion[0].__vtable[-325140770] = &csceneobject::prepare;
    classes.cscenesharedcompanion[0].__vtable[987150381] = &csceneobject::_spawn;
    classes.cscenesharedcompanion[0].__vtable[-1686119842] = &csceneobject::spawn;
    classes.cscenesharedcompanion[0].__vtable[-1191896790] = &csceneobject::first_init;
    classes.cscenesharedcompanion[0].__vtable[-359698846] = &csceneobject::_reset_values;
    classes.cscenesharedcompanion[0].__vtable[-1553926551] = &csceneobject::_set_values;
    classes.cscenesharedcompanion[0].__vtable[551404028] = &csceneobject::reset_ent_val;
    classes.cscenesharedcompanion[0].__vtable[1285561865] = &csceneobject::set_ent_val;
    classes.cscenesharedcompanion[0].__vtable[1606033458] = &csceneobject::__destructor;
    classes.cscenesharedcompanion[0].__vtable[-1690805083] = &csceneobject::__constructor;
    classes.cscenesharedcompanion[0].__vtable[1606033458] = &csceneplayer::__destructor;
    classes.cscenesharedcompanion[0].__vtable[-2083104676] = &csceneplayer::destroy_dev_info;
    classes.cscenesharedcompanion[0].__vtable[2077358244] = &csceneplayer::display_dev_info;
    classes.cscenesharedcompanion[0].__vtable[-51014854] = &csceneplayer::animation_lookup;
    classes.cscenesharedcompanion[0].__vtable[1426012151] = &csceneplayer::function_54ff37f7;
    classes.cscenesharedcompanion[0].__vtable[-756866436] = &csceneplayer::_cleanup_player;
    classes.cscenesharedcompanion[0].__vtable[751796260] = &csceneplayer::_cleanup;
    classes.cscenesharedcompanion[0].__vtable[-165058024] = &csceneplayer::set_player_stance;
    classes.cscenesharedcompanion[0].__vtable[724938382] = &csceneplayer::revive_player;
    classes.cscenesharedcompanion[0].__vtable[1486082317] = &csceneplayer::on_play_anim;
    classes.cscenesharedcompanion[0].__vtable[1573351179] = &csceneplayer::_prepare_player;
    classes.cscenesharedcompanion[0].__vtable[-800750439] = &csceneplayer::_prepare;
    classes.cscenesharedcompanion[0].__vtable[987150381] = &csceneplayer::_spawn;
    classes.cscenesharedcompanion[0].__vtable[-1984848424] = &csceneplayer::_stop;
    classes.cscenesharedcompanion[0].__vtable[-1191896790] = &csceneplayer::first_init;
    classes.cscenesharedcompanion[0].__vtable[-1690805083] = &csceneplayer::__constructor;
    classes.cscenesharedcompanion[0].__vtable[1606033458] = &cscenesharedplayer::__destructor;
    classes.cscenesharedcompanion[0].__vtable[-1690805083] = &cscenesharedplayer::__constructor;
    classes.cscenesharedcompanion[0].__vtable[751796260] = &cscenesharedplayer::_cleanup;
    classes.cscenesharedcompanion[0].__vtable[-1984848424] = &cscenesharedplayer::_stop;
    classes.cscenesharedcompanion[0].__vtable[1139080151] = &cscenesharedplayer::_set_visibility;
    classes.cscenesharedcompanion[0].__vtable[1466913678] = &cscenesharedplayer::_play_shared_player_anim_for_player;
    classes.cscenesharedcompanion[0].__vtable[-1706684566] = &cscenesharedplayer::_play_anim;
    classes.cscenesharedcompanion[0].__vtable[-800750439] = &cscenesharedplayer::_prepare;
    classes.cscenesharedcompanion[0].__vtable[1606033458] = &cscenesharedcompanion::__destructor;
    classes.cscenesharedcompanion[0].__vtable[-1690805083] = &cscenesharedcompanion::__constructor;
}

