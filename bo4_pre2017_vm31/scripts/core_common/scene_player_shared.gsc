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

#namespace scene;

// Namespace scene
// Method(s) 2 Total 76
class cscenecompanion : csceneplayer, csceneobject {

    var _func_get;
    var _func_get_active;

    // Namespace cscenecompanion/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf16c062b, Offset: 0x5bf8
    // Size: 0x44
    function constructor() {
        _func_get = &util::function_bb1c6fbf;
        _func_get_active = &util::function_12a66d92;
    }

}

// Namespace scene
// Method(s) 16 Total 76
class csceneplayer : csceneobject {

    var _e;
    var _func_get;
    var _func_get_active;
    var _n_streamer_req;
    var _o_scene;
    var _s;
    var _str_shot;
    var _str_team;

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0x71c9beba, Offset: 0x448
    // Size: 0x54
    function constructor() {
        _func_get = &util::get_players;
        _func_get_active = &util::get_active_players;
        _n_streamer_req = -1;
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
    // Checksum 0xcf098aed, Offset: 0x17d0
    // Size: 0x3fc
    function display_dev_info() {
        if (isstring(_o_scene._s.devstate) && getdvarint("scr_show_shot_info_for_igcs", 0)) {
            if (!isdefined(level.hud_scene_dev_info1)) {
                level.hud_scene_dev_info1 = newhudelem();
                level.hud_scene_dev_info1.alignx = "right";
                level.hud_scene_dev_info1.aligny = "bottom";
                level.hud_scene_dev_info1.horzalign = "user_right";
                level.hud_scene_dev_info1.y = 400;
                level.hud_scene_dev_info1.fontscale = 1.3;
                level.hud_scene_dev_info1.color = (0.439216, 0.501961, 0.564706);
                level.hud_scene_dev_info1 settext("SCENE: " + toupper(_o_scene._s.name));
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
            level.hud_scene_dev_info2 settext("SHOT: " + toupper(_o_scene._s.name));
            if (!isdefined(level.hud_scene_dev_info3)) {
                level.hud_scene_dev_info3 = newhudelem();
                level.hud_scene_dev_info3.alignx = "right";
                level.hud_scene_dev_info3.aligny = "bottom";
                level.hud_scene_dev_info3.horzalign = "user_right";
                level.hud_scene_dev_info3.y = 440;
                level.hud_scene_dev_info3.fontscale = 1.3;
                level.hud_scene_dev_info3.color = (0.439216, 0.501961, 0.564706);
                level.hud_scene_dev_info3 settext("STATE: " + toupper(_o_scene._s.devstate));
            }
            return;
        }
        destroy_dev_info();
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 3, eflags: 0x0
    // Checksum 0xa4c49783, Offset: 0x14a8
    // Size: 0x31a
    function animation_lookup(str_anim, ent, b_camera) {
        if (!isdefined(ent)) {
            ent = _e;
        }
        if (!isdefined(b_camera)) {
            b_camera = 0;
        }
        bundle = getscriptbundle(str_anim);
        if (isdefined(bundle) && bundle.type === "companion_anim") {
            if (isplayer(ent)) {
                if (ent util::is_companion()) {
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
                if (_s.type == "player" || _s.type == "sharedplayer") {
                    str_type = "player";
                } else if (_s.type == "companion" || _s.type == "sharedcompanion") {
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
    // Params 1, eflags: 0x0
    // Checksum 0x582218bc, Offset: 0x1440
    // Size: 0x5a
    function function_54ff37f7(player) {
        player endon(#"new_scene");
        waitframe(5);
        player playerstreamerrequest("clear", player.var_1375be5);
        player.streamer_hint_playing = undefined;
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
        if (!(isdefined(_s.showhud) && _s.showhud)) {
            player util::delay(0.1, "new_scene", &scene::set_igc_active, 0);
        }
        player.var_dd686719 = undefined;
        player.scene_takedamage = undefined;
        player._scene_old_gun_removed = undefined;
        player thread scene::scene_enable_player_stuff(_o_scene._s, _s, _o_scene._e_root);
        if (![[ _o_scene ]]->function_cc8737c()) {
            if ([[ _o_scene ]]->function_7731633d()) {
                if (!csceneobject::is_skipping_scene() && [[ _o_scene ]]->function_e308028()) {
                    [[ _o_scene ]]->function_5a3cff18(0);
                }
                _o_scene thread cscene::_stop_camera_anim_on_player(player);
            } else if (_o_scene._s scene::is_igc()) {
                _o_scene thread cscene::_stop_camera_anim_on_player(player);
            }
        }
        n_camera_tween_out = csceneobject::get_camera_tween_out();
        if (n_camera_tween_out > 0) {
            player startcameratween(n_camera_tween_out);
        }
        if (!(isdefined(_s.dontreloadammo) && _s.dontreloadammo)) {
            player player::fill_current_clip();
        }
        player allowstand(1);
        player allowcrouch(1);
        player allowprone(1);
        player sethighdetail(0);
        _reset_values(player);
        thread function_54ff37f7(player);
        destroy_dev_info();
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5b1ac022, Offset: 0x1090
    // Size: 0x1c
    function _cleanup() {
        _cleanup_player(_e);
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4435df97, Offset: 0xf50
    // Size: 0x134
    function set_player_stance(player) {
        if (_s.playerstance === "crouch") {
            player allowstand(0);
            player allowcrouch(1);
            player allowprone(0);
            return;
        }
        if (_s.playerstance === "prone") {
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
    // Checksum 0x5882bb24, Offset: 0xe30
    // Size: 0xa0
    function on_play_anim(player) {
        if (_n_streamer_req != -1 && !csceneobject::is_skipping_scene() && !(isdefined(player.streamer_hint_playing) && player.streamer_hint_playing)) {
            player playerstreamerrequest("play", player.var_1375be5);
            player.streamer_hint_playing = 1;
        }
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
        if (player.var_dd686719 === _o_scene._str_name) {
            return 0;
        }
        player notify(#"new_scene");
        if (player == level.host && scene::check_team(player.team, _str_team)) {
            display_dev_info();
        }
        str_streamer_hint = _o_scene._a_streamer_hint[player.team];
        if (isdefined(str_streamer_hint)) {
            if (_n_streamer_req == -1) {
                _n_streamer_req = player playerstreamerrequest("set", str_streamer_hint);
                player.var_1375be5 = str_streamer_hint;
            }
            if (_str_shot != "init" && _n_streamer_req != -1) {
                if (!(isdefined(level.scene_streamer_ignore[_s.name]) && level.scene_streamer_ignore[_s.name])) {
                    if (!(isdefined(_o_scene._s.ignorestreamer) && _o_scene._s.ignorestreamer)) {
                        player util::streamer_wait(_n_streamer_req, 0, 5);
                    }
                }
            }
        }
        if (!(isdefined(_s.showhud) && _s.showhud)) {
            player scene::set_igc_active(1);
        }
        _set_values(player);
        player sethighdetail(1);
        if (player flagsys::get("mobile_armory_in_use")) {
            player flagsys::set("cancel_mobile_armory");
            player closemenu("ChooseClass_InGame");
            player notify(#"menuresponse", {#menu:"ChooseClass_InGame", #response:"cancel"});
        }
        if (player flagsys::get("mobile_armory_begin_use")) {
            player util::_enableweapon();
            player flagsys::clear("mobile_armory_begin_use");
        }
        if (getdvarint("scene_hide_player") > 0) {
            player hide();
        }
        player.var_dd686719 = _o_scene._str_name;
        if (isdefined(player.hijacked_vehicle_entity)) {
            player.hijacked_vehicle_entity delete();
        } else if (player isinvehicle()) {
            vh_occupied = player getvehicleoccupied();
            n_seat = vh_occupied getoccupantseat(player);
            vh_occupied usevehicle(player, n_seat);
        }
        revive_player(player);
        player thread scene::scene_disable_player_stuff(_o_scene._s, _s);
        if (isdefined(_s.var_4c0453af) && _s.var_4c0453af) {
        }
        player.player_anim_look_enabled = !(isdefined(_s.lockview) && _s.lockview);
        player.player_anim_clamp_right = isdefined(_s.viewclampright) ? _s.viewclampright : 0;
        player.player_anim_clamp_left = isdefined(_s.viewclampleft) ? _s.viewclampleft : 0;
        player.player_anim_clamp_top = isdefined(_s.viewclampbottom) ? _s.viewclampbottom : 0;
        player.player_anim_clamp_bottom = isdefined(_s.viewclampbottom) ? _s.viewclampbottom : 0;
        if (isdefined(_s.showweaponinfirstperson) && (!(isdefined(_s.removeweapon) && _s.removeweapon) || _s.showweaponinfirstperson) && !(isdefined(_s.disableprimaryweaponswitch) && _s.disableprimaryweaponswitch)) {
            player player::switch_to_primary_weapon(1);
        }
        set_player_stance(player);
        waitframe(0);
        player notify(#"scene_ready");
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0x30a9a765, Offset: 0x6e0
    // Size: 0x1c
    function _prepare() {
        _prepare_player(_e);
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1ef0d9f5, Offset: 0x588
    // Size: 0x14c
    function _spawn() {
        /#
            if (isdefined(_o_scene._b_testing) && _o_scene._b_testing && csceneobject::is_player()) {
                p_host = util::gethostplayer();
                if (!csceneobject::in_this_scene(p_host)) {
                    _e = p_host;
                    return;
                }
            }
        #/
        if (!isdefined(_e)) {
            foreach (ent in [[ _func_get ]](_str_team)) {
                if (!csceneobject::in_this_scene(ent)) {
                    _e = ent;
                    return;
                }
            }
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0x869be8be, Offset: 0x4f8
    // Size: 0x84
    function _stop(b_dont_clear_anim, b_finished) {
        if (isalive(_e)) {
            if (!(isdefined(_s.diewhenfinished) && _s.diewhenfinished) || !b_finished) {
                _e stopanimscripted(0.2);
            }
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0x94562774, Offset: 0x4a8
    // Size: 0x42
    function first_init(s_objdef, o_scene) {
        s_objdef.nospawn = 1;
        return csceneobject::first_init(s_objdef, o_scene);
    }

}

// Namespace scene
// Method(s) 8 Total 78
class cscenesharedplayer : csceneplayer, csceneobject {

    var _e;
    var _func_get;
    var _func_get_active;
    var _o_scene;
    var _s;
    var _str_current_anim;
    var _str_team;
    var current_playing_anim;
    var m_align;
    var m_tag;
    var player_align;
    var player_animation;
    var player_animation_length;
    var player_animation_notify;
    var player_rate;
    var player_start_time;
    var player_tag;
    var player_time_frac;

    // Namespace cscenesharedplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf8398977, Offset: 0x3bb0
    // Size: 0x9a
    function _cleanup() {
        foreach (player in [[ _func_get ]](_str_team)) {
            csceneplayer::_cleanup_player(player);
        }
    }

    // Namespace cscenesharedplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0x1b03fc0c, Offset: 0x3af0
    // Size: 0xb2
    function _stop(b_dont_clear_anim, b_finished) {
        foreach (player in [[ _func_get ]](_str_team)) {
            player stopanimscripted(0.2);
        }
    }

    // Namespace cscenesharedplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0xef8d7f9a, Offset: 0x3868
    // Size: 0x280
    function _set_visibility(player) {
        a_players = [[ _func_get ]](_str_team);
        foreach (player in a_players) {
            player setinvisibletoall();
        }
        foreach (player in getplayers()) {
            if (isdefined(player.owner)) {
                player setvisibletoplayer(player.owner);
            }
        }
        if (_str_team != "any") {
            foreach (str_team in level.teams) {
                if (str_team != _str_team) {
                    foreach (player in getplayers(str_team)) {
                        a_players[0] setvisibletoplayer(player);
                    }
                }
            }
        }
    }

    // Namespace cscenesharedplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd63a3729, Offset: 0x3170
    // Size: 0x6ec
    function _play_shared_player_anim_for_player(player) {
        if (!scene::check_team(player.team, _str_team) && player != _e) {
            return;
        }
        player endon(#"death");
        csceneplayer::on_play_anim(player);
        /#
        #/
        /#
            if (getdvarint("<dev string:x28>") > 0) {
                printtoprightln("<dev string:x99>" + player_animation);
            }
        #/
        player.current_scene = _o_scene._str_name;
        player flagsys::set("shared_igc");
        if (player flagsys::get(player_animation_notify)) {
            player flagsys::set(player_animation_notify + "_skip_init_clear");
        }
        player flagsys::set(player_animation_notify);
        if (isdefined(player getlinkedent())) {
            player unlink();
        }
        if (!(isdefined(_s.disabletransitionin) && _s.disabletransitionin)) {
            if (player != _e || getdvarint("scr_player1_postfx", 0)) {
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
        n_time_passed = (gettime() - player_start_time) / 1000;
        n_start_time = player_time_frac * player_animation_length;
        n_time_left = player_animation_length - n_time_passed - n_start_time;
        n_time_frac = 1 - n_time_left / player_animation_length;
        if (isdefined(_e) && player != _e) {
            player dontinterpolate();
            player setorigin(_e.origin);
            if (!player isbot()) {
                player setplayerangles(_e getplayerangles());
            }
        }
        n_lerp = csceneobject::get_lerp_time();
        if (!_o_scene._s scene::is_igc()) {
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
                    printtoprightln("<dev string:xdf>" + _s.name + "<dev string:x124>" + player_animation);
                }
            #/
            str_animation = player_animation;
            str_animation = animation_lookup(_str_current_anim, player);
            player_num = player getentitynumber();
            if (!isdefined(current_playing_anim)) {
                current_playing_anim[player_num] = [];
            }
            current_playing_anim[player_num] = str_animation;
            if (csceneobject::is_skipping_scene()) {
                thread csceneobject::skip_scene(1);
            }
            player animation::play(str_animation, player_align, player_tag, player_rate, 0, 0, n_lerp, n_time_frac, _s.showweaponinfirstperson);
            if (!player flagsys::get(player_animation_notify + "_skip_init_clear")) {
                player flagsys::clear(player_animation_notify);
            } else {
                player flagsys::clear(player_animation_notify + "_skip_init_clear");
            }
            if (!player isplayinganimscripted()) {
                current_playing_anim[player_num] = undefined;
            }
            /#
                if (getdvarint("<dev string:x28>") > 0) {
                    printtoprightln("<dev string:x128>" + _s.name + "<dev string:x170>" + player_animation);
                }
            #/
        }
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
        player_animation = animation;
        player_animation_notify = animation + "_notify";
        player_animation_length = getanimlength(animation);
        player_align = m_align;
        player_tag = m_tag;
        player_rate = n_rate;
        player_time_frac = n_time;
        player_start_time = gettime();
        a_players = [[ _func_get ]](_str_team);
        /#
            if (isdefined(_e) && !isinarray(a_players, _e)) {
                arrayinsert(a_players, _e, 0);
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
            foreach (player in [[ _func_get_active ]](_str_team)) {
                if (isdefined(player) && player flagsys::get(player_animation_notify)) {
                    b_playing = 1;
                    player flagsys::wait_till_clear(player_animation_notify);
                    break;
                }
            }
        } while (b_playing);
        callback::remove_on_loadout(&_play_shared_player_anim_for_player, self);
        thread [[ _o_scene ]]->_call_shot_funcs("players_done");
    }

    // Namespace cscenesharedplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc60f8132, Offset: 0x2cb8
    // Size: 0xd4
    function _prepare() {
        a_players = [[ _func_get ]](_str_team);
        foreach (ent in a_players) {
            thread _prepare_player(ent);
        }
        _set_visibility();
        array::wait_till(a_players, "scene_ready");
    }

}

// Namespace scene
// Method(s) 2 Total 69
class cscenefakeplayer : csceneobject {

}

// Namespace scene
// Method(s) 2 Total 78
class cscenesharedcompanion : csceneplayer, cscenesharedplayer, csceneobject {

    var _func_get;
    var _func_get_active;

    // Namespace cscenesharedcompanion/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0x72e33ff1, Offset: 0x6ce8
    // Size: 0x44
    function constructor() {
        _func_get = &util::function_bb1c6fbf;
        _func_get_active = &util::function_12a66d92;
    }

}

