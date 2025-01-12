#using script_24c15fbbb838c794;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_objects_shared;
#using scripts\core_common\scene_player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;

#namespace scene;

// Namespace scene
// Method(s) 44 Total 148
class csceneplayer : csceneobject {

    var _e;
    var _func_get;
    var _func_get_active;
    var _n_streamer_req;
    var _o_scene;
    var _s;
    var _str_camera;
    var _str_current_anim;
    var _str_shot;
    var _str_team;
    var var_19cb700b;
    var var_5c4adc26;
    var var_b6160c2e;
    var var_d02edcb8;

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x8
    // Checksum 0xb9c5c46e, Offset: 0x2d8
    // Size: 0x4e
    constructor() {
        _func_get = &util::get_players;
        _func_get_active = &util::get_active_players;
        _n_streamer_req = -1;
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe026f2dd, Offset: 0x62e0
    // Size: 0x84
    function destroy_dev_info() {
        /#
            if (isdefined(level.hud_scene_dev_info1)) {
                level.hud_scene_dev_info1 destroy();
            }
            if (isdefined(level.hud_scene_dev_info2)) {
                level.hud_scene_dev_info2 destroy();
            }
            if (isdefined(level.hud_scene_dev_info3)) {
                level.hud_scene_dev_info3 destroy();
            }
        #/
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7bb2eb7d, Offset: 0x5ef0
    // Size: 0x3e4
    function display_dev_info() {
        /#
            if (isstring(_o_scene._s.devstate) && getdvarint(#"scr_show_shot_info_for_igcs", 0)) {
                if (!isdefined(level.hud_scene_dev_info1)) {
                    level.hud_scene_dev_info1 = newdebughudelem();
                }
                level.hud_scene_dev_info1.alignx = "<dev string:xfa>";
                level.hud_scene_dev_info1.aligny = "<dev string:x100>";
                level.hud_scene_dev_info1.horzalign = "<dev string:x107>";
                level.hud_scene_dev_info1.y = 400;
                level.hud_scene_dev_info1.fontscale = 1.3;
                level.hud_scene_dev_info1.color = (0.439216, 0.501961, 0.564706);
                level.hud_scene_dev_info1 settext("<dev string:x112>" + toupper(function_15979fa9(_o_scene._str_name)));
                if (!isdefined(level.hud_scene_dev_info2)) {
                    level.hud_scene_dev_info2 = newdebughudelem();
                }
                level.hud_scene_dev_info2.alignx = "<dev string:xfa>";
                level.hud_scene_dev_info2.aligny = "<dev string:x100>";
                level.hud_scene_dev_info2.horzalign = "<dev string:x107>";
                level.hud_scene_dev_info2.y = 420;
                level.hud_scene_dev_info2.fontscale = 1.3;
                level.hud_scene_dev_info2.color = (0.439216, 0.501961, 0.564706);
                level.hud_scene_dev_info2 settext("<dev string:x11a>" + function_15979fa9(_str_shot));
                if (!isdefined(level.hud_scene_dev_info3)) {
                    level.hud_scene_dev_info3 = newdebughudelem();
                }
                level.hud_scene_dev_info3.alignx = "<dev string:xfa>";
                level.hud_scene_dev_info3.aligny = "<dev string:x100>";
                level.hud_scene_dev_info3.horzalign = "<dev string:x107>";
                level.hud_scene_dev_info3.y = 440;
                level.hud_scene_dev_info3.fontscale = 1.3;
                level.hud_scene_dev_info3.color = (0.439216, 0.501961, 0.564706);
                var_3f8ddff0 = isdefined(var_b6160c2e.devstate) ? var_b6160c2e.devstate : _o_scene._s.devstate;
                level.hud_scene_dev_info3 settext("<dev string:x121>" + function_15979fa9(var_3f8ddff0));
                return;
            }
            destroy_dev_info();
        #/
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 3, eflags: 0x0
    // Checksum 0x87412a8d, Offset: 0x5cc0
    // Size: 0x228
    function animation_lookup(animation, ent = self._e, b_camera = 0) {
        if (isdefined(_s.var_dbcb4dde) && isdefined(level.heroes) && level.heroes.size) {
            n_shot = csceneobject::get_shot(_str_shot);
            foreach (e_hero in level.heroes) {
                e_specialist = e_hero;
                break;
            }
            var_6f5dfee0 = e_specialist.animname;
            if (isdefined(n_shot) && isdefined(_s.var_dbcb4dde[n_shot]) && isdefined(_s.var_dbcb4dde[n_shot][var_6f5dfee0])) {
                if (b_camera && isdefined(_s.var_dbcb4dde[n_shot][var_6f5dfee0].var_80fbd604)) {
                    return _s.var_dbcb4dde[n_shot][var_6f5dfee0].var_80fbd604;
                } else if (!b_camera && isdefined(_s.var_dbcb4dde[n_shot][var_6f5dfee0].var_121fe5f6)) {
                    return _s.var_dbcb4dde[n_shot][var_6f5dfee0].var_121fe5f6;
                }
            }
        }
        return animation;
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0xdd902164, Offset: 0x5ba0
    // Size: 0x114
    function function_18bf09f7() {
        if (csceneobject::is_shared_player()) {
            if (isdefined(_str_camera)) {
                return true;
            }
        } else if (csceneobject::function_d0e76675()) {
            if (isdefined(_str_camera)) {
                return true;
            }
            if (isdefined(_o_scene._a_objects)) {
                foreach (obj in _o_scene._a_objects) {
                    if (obj._s.type === "sharedplayer" && [[ obj ]]->function_18bf09f7()) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4d31368f, Offset: 0x5b70
    // Size: 0x24
    function stop_camera(player) {
        endcamanimscripted(player);
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0xeaf8d490, Offset: 0x5ae8
    // Size: 0x80
    function get_extracam_index(player) {
        var_47e3b63b = isdefined(var_b6160c2e.extracamindex) ? var_b6160c2e.extracamindex : _s.extracamindex;
        if (isdefined(var_47e3b63b)) {
            var_4d24d4ca = int(var_47e3b63b) - 1;
        }
        return var_4d24d4ca;
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 5, eflags: 0x0
    // Checksum 0x9191d4f3, Offset: 0x5960
    // Size: 0x17c
    function _camanimscripted(player, str_camera, v_origin, v_angles, n_start_time = 0) {
        player notify(#"camanimscripted");
        player endon(#"camanimscripted", #"disconnect");
        if (_o_scene._s scene::is_igc()) {
            player thread scene::scene_disable_player_stuff(_o_scene._s, _s);
        }
        var_3cc0d7dd = getcamanimtime(str_camera) * n_start_time;
        var_a1cb9aac = int(gettime() - var_3cc0d7dd);
        player dontinterpolate();
        camanimscripted(player, str_camera, var_a1cb9aac, v_origin, v_angles);
        wait_for_camera(str_camera, n_start_time);
        player dontinterpolate();
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0x7fdad1e6, Offset: 0x5818
    // Size: 0x140
    function play_camera_on_player(player, n_start_time) {
        if (!scene::check_team(player.team, _str_team)) {
            return;
        }
        player.current_scene = _o_scene._str_name;
        e_align = csceneobject::get_align_ent();
        v_origin = isdefined(e_align.origin) ? e_align.origin : (0, 0, 0);
        v_angles = isdefined(e_align.angles) ? e_align.angles : (0, 0, 0);
        self thread _camanimscripted(player, isdefined(player.var_42635dd2) ? player.var_42635dd2 : _str_camera, v_origin, v_angles, n_start_time);
        player.var_42635dd2 = undefined;
        on_play_anim(player);
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0xd9cd9e94, Offset: 0x55b0
    // Size: 0x25e
    function play_camera(animation, n_start_time = 0) {
        flagsys::set(#"camera_playing");
        if (csceneobject::is_shared_player()) {
            a_players = [[ _func_get ]](_o_scene._str_team);
            foreach (player in a_players) {
                _str_camera = animation_lookup(animation, player, 1);
                player.var_42635dd2 = _str_camera;
                thread play_camera_on_player(player, n_start_time);
            }
            wait_for_camera(_str_camera, n_start_time);
        } else {
            _str_camera = animation_lookup(animation, _e, 1);
            _e.var_42635dd2 = _str_camera;
            thread play_camera_on_player(_e, n_start_time);
            wait_for_camera(_str_camera, n_start_time);
        }
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                csceneobject::log(toupper(_s.type) + "<dev string:xe6>" + _str_camera + "<dev string:xf0>");
            }
        #/
        flagsys::clear(#"camera_playing");
        _str_camera = undefined;
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0xae4658e6, Offset: 0x54e8
    // Size: 0xbc
    function wait_for_camera(str_cam, n_start_time) {
        self endon(#"skip_camera_anims", _str_shot + "active");
        if (iscamanimlooping(str_cam)) {
            level waittill(#"forever");
            return;
        }
        var_5fb9d7f1 = float(getcamanimtime(str_cam)) / 1000;
        scene::wait_server_time(var_5fb9d7f1, n_start_time);
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf05a5f05, Offset: 0x5438
    // Size: 0xa6
    function function_d645c03b(player) {
        player endon(#"new_shot", #"disconnect");
        _o_scene waittilltimeout(0.1, #"scene_done", #"scene_stop", #"scene_skip_completed");
        player playerstreamerrequest("clear", player.var_1375be5);
        player.streamer_hint_playing = undefined;
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe67d8bbe, Offset: 0x5320
    // Size: 0x10c
    function function_ac8944a2(player) {
        player notify(#"hash_375ad02201949a8d");
        player endon(#"camanimscripted", #"hash_375ad02201949a8d", #"disconnect");
        _o_scene waittilltimeout(0.1, #"scene_done", #"scene_stop", #"scene_skip_completed");
        stop_camera(player);
        /#
            if (isdefined(_o_scene._b_testing) && _o_scene._b_testing) {
                p_host = util::gethostplayer();
                stop_camera(p_host);
            }
        #/
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7a90c1e4, Offset: 0x51d8
    // Size: 0x13a
    function function_fc6d1fe7(player) {
        if (isbot(player)) {
            return;
        }
        if (isdefined(var_b6160c2e.var_1e7c956)) {
            switch (var_b6160c2e.var_1e7c956) {
            case #"bank1":
                player clientfield::set_to_player("player_pbg_bank_scene_system", 0);
                break;
            case #"bank2":
                player clientfield::set_to_player("player_pbg_bank_scene_system", 1);
                break;
            case #"bank3":
                player clientfield::set_to_player("player_pbg_bank_scene_system", 2);
                break;
            case #"bank4":
                player clientfield::set_to_player("player_pbg_bank_scene_system", 3);
                break;
            }
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1ebe6181, Offset: 0x4d30
    // Size: 0x49c
    function _cleanup_player(player) {
        if (csceneobject::function_d0e76675() && player flagsys::get(#"shared_igc")) {
            return;
        }
        if (csceneobject::is_shared_player() && player flagsys::get(#"hash_7cddd51e45d3ff3e")) {
            return;
        }
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:xbf>");
            }
        #/
        player notify(#"hash_7ba9e3058f933eb");
        player.var_32218fc7 = undefined;
        player.scene_set_visible_time = level.time;
        player setvisibletoall();
        player val::reset(#"scene", "hide");
        player flagsys::clear(#"shared_igc");
        player flagsys::clear(#"scene");
        player flagsys::clear(#"scene_interactive_shot");
        player flagsys::clear(#"hash_2f30b24ec0e23830");
        player flagsys::clear(#"hash_e2ce599b208682a");
        player flagsys::clear(#"hash_f21f320f68c0457");
        player util::delay(0.1, "new_shot", &scene::set_igc_active, 0);
        player.var_dd686719 = undefined;
        player._scene_object = undefined;
        player.anim_debug_name = undefined;
        player.current_scene = undefined;
        player.scene_takedamage = undefined;
        player._scene_old_gun_removed = undefined;
        if (![[ _o_scene ]]->has_next_shot(_str_shot) || _o_scene._str_mode === "single") {
            player thread scene::scene_enable_player_stuff(_o_scene._s, _s, _o_scene._e_root);
            var_b05026dc = player getentitynumber() + 2;
            player util::delay_network_frames(var_b05026dc, "disconnect", &clientfield::set_to_player, "postfx_cateye", 0);
        }
        n_camera_tween_out = csceneobject::get_camera_tween_out();
        if (n_camera_tween_out > 0) {
            player startcameratween(n_camera_tween_out);
        }
        player allowstand(1);
        player allowcrouch(1);
        player allowprone(1);
        player sethighdetail(0);
        _reset_values(player);
        function_5d942562(player);
        thread function_d645c03b(player);
        thread function_ac8944a2(player);
        function_fc6d1fe7(player);
        /#
            if (player === level.host) {
                player util::delay(0.5, "<dev string:xdd>", &destroy_dev_info);
            }
        #/
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8b914c75, Offset: 0x4d08
    // Size: 0x1c
    function _cleanup() {
        _cleanup_player(_e);
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x996ef1eb, Offset: 0x4bd0
    // Size: 0x12c
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
    // Checksum 0x2dc8079d, Offset: 0x4b50
    // Size: 0x78
    function revive_player(player) {
        if (level.gameended) {
            return;
        }
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
    // Checksum 0xdf92bc08, Offset: 0x4ab8
    // Size: 0x8a
    function on_play_anim(player) {
        if (_n_streamer_req != -1 && !csceneobject::is_skipping_scene() && !(isdefined(player.streamer_hint_playing) && player.streamer_hint_playing)) {
            player playerstreamerrequest("play", player.var_1375be5);
            player.streamer_hint_playing = 1;
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x352e828f, Offset: 0x48a0
    // Size: 0x210
    function function_668ad4ad(player) {
        player notify(#"hash_feb654ece8faa3d");
        thread function_9dcfe1ec(player, 0);
        thread function_13709c53(player, 0);
        foreach (o_obj in _o_scene._a_objects) {
            if (isdefined(o_obj)) {
                var_76b10cd0 = o_obj._s.shots[csceneobject::get_shot(_str_shot)];
                if (o_obj != self && isdefined(var_76b10cd0.var_9dca1d18)) {
                    thread [[ o_obj ]]->_play_anim(var_76b10cd0.var_9dca1d18, 1, 0.2, 0, 0);
                }
            }
        }
        var_d4a597fe = _s.shots[csceneobject::get_shot(_str_shot)];
        if (isdefined(var_d4a597fe.var_9dca1d18)) {
            csceneobject::_play_anim(var_d4a597fe.var_9dca1d18, 1, 0.2, 0, 0);
        }
        _reset_values();
        player scene::set_igc_active(0);
        player kill();
        [[ _o_scene ]]->stop();
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7d2631a7, Offset: 0x46f0
    // Size: 0x1a4
    function function_1c40de55(player) {
        thread function_9dcfe1ec(player, 0);
        thread function_13709c53(player, 0);
        foreach (o_obj in _o_scene._a_objects) {
            if (isdefined(o_obj)) {
                var_76b10cd0 = o_obj._s.shots[csceneobject::get_shot(_str_shot)];
                if (o_obj != self && isdefined(var_76b10cd0.var_dc0c43ff)) {
                    thread [[ o_obj ]]->_play_anim(var_76b10cd0.var_dc0c43ff, 1, 0.2, 0, 0);
                }
            }
        }
        var_d4a597fe = _s.shots[csceneobject::get_shot(_str_shot)];
        if (isdefined(var_d4a597fe.var_dc0c43ff)) {
            csceneobject::_play_anim(var_d4a597fe.var_dc0c43ff, 1, 0.2, 0, 0);
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x9732a15, Offset: 0x4528
    // Size: 0x1bc
    function function_6d0488a5(player) {
        player notify(#"hash_feb654ece8faa3d");
        thread function_9dcfe1ec(player, 0);
        thread function_13709c53(player, 0);
        foreach (o_obj in _o_scene._a_objects) {
            if (isdefined(o_obj)) {
                var_76b10cd0 = o_obj._s.shots[csceneobject::get_shot(_str_shot)];
                if (o_obj != self && isdefined(var_76b10cd0.var_d4db3750)) {
                    thread [[ o_obj ]]->_play_anim(var_76b10cd0.var_d4db3750, 1, 0.2, 0, 0);
                }
            }
        }
        var_d4a597fe = _s.shots[csceneobject::get_shot(_str_shot)];
        if (isdefined(var_d4a597fe.var_d4db3750)) {
            csceneobject::_play_anim(var_d4a597fe.var_d4db3750, 1, 0.2, 0, 0);
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0x18f08f0b, Offset: 0x4450
    // Size: 0xd0
    function function_13709c53(player, b_enable = 1) {
        player endon(#"hash_1aa7e630a34bee50");
        if (b_enable) {
            while (isalive(player)) {
                player playrumbleonentity("damage_heavy");
                wait 0.1;
            }
            player stoprumble("damage_heavy");
            return;
        }
        player stoprumble("damage_heavy");
        player notify(#"hash_1aa7e630a34bee50");
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0x13293adc, Offset: 0x4378
    // Size: 0xd0
    function function_9dcfe1ec(player, b_enable = 1) {
        player endon(#"hash_3fdc27904c7ef691");
        if (b_enable) {
            while (isalive(player)) {
                player playrumbleonentity("damage_light");
                wait 0.3;
            }
            player stoprumble("damage_light");
            return;
        }
        player stoprumble("damage_light");
        player notify(#"hash_3fdc27904c7ef691");
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc98d35c6, Offset: 0x3db8
    // Size: 0x5b6
    function function_73e33d10(player) {
        player endon(#"hash_7ba9e3058f933eb", #"hash_feb654ece8faa3d", #"death");
        while (true) {
            s_waitresult = player waittill(#"hash_940a817baf9765e");
            if (!isdefined(s_waitresult.str_input)) {
                s_waitresult.str_input = "";
            }
            switch (s_waitresult.str_input) {
            case #"move_up":
            case #"move_down":
                if (s_waitresult.str_input == "move_up") {
                    if (player gamepadusedlast()) {
                        level.interactive_shot interactive_shot::set_text(player, #"hash_66ac13c66930481e");
                    } else {
                        level.interactive_shot interactive_shot::set_text(player, #"hash_2e61b9986055044e");
                    }
                } else if (player gamepadusedlast()) {
                    level.interactive_shot interactive_shot::set_text(player, #"hash_f7f3ef0446b4447");
                } else {
                    level.interactive_shot interactive_shot::set_text(player, #"hash_63aa233af2b054f1");
                }
                break;
            case #"move_right":
            case #"move_left":
                if (s_waitresult.str_input == "move_right") {
                    if (player gamepadusedlast()) {
                        level.interactive_shot interactive_shot::set_text(player, #"hash_b89e8fe23b5a6ff");
                    } else {
                        level.interactive_shot interactive_shot::set_text(player, #"hash_5cafbb3ef224b89");
                    }
                } else if (player gamepadusedlast()) {
                    level.interactive_shot interactive_shot::set_text(player, #"hash_43fe6cadb07b27b2");
                } else {
                    level.interactive_shot interactive_shot::set_text(player, #"hash_121d78dfceea3bf2");
                }
                break;
            case #"jump":
                level.interactive_shot interactive_shot::set_text(player, #"hash_5b57ca9476df902b");
                break;
            case #"stance":
                level.interactive_shot interactive_shot::set_text(player, #"hash_30214ec564c2c09b");
                break;
            case #"use":
                level.interactive_shot interactive_shot::set_text(player, #"hash_1c489083f5cdb3f6");
                break;
            case #"weapon_switch":
                level.interactive_shot interactive_shot::set_text(player, #"hash_5d8ce20bafb14fec");
                break;
            case #"sprint":
                level.interactive_shot interactive_shot::set_text(player, #"hash_6b873520c198df93");
                break;
            case #"melee":
                level.interactive_shot interactive_shot::set_text(player, #"hash_6c4731677fa269b1");
                break;
            case #"attack":
                break;
            case #"dpad_up":
                level.interactive_shot interactive_shot::set_text(player, #"hash_327b92f099f4b62e");
                break;
            case #"dpad_down":
                level.interactive_shot interactive_shot::set_text(player, #"hash_51f4288480f483f7");
                break;
            case #"dpad_left":
                level.interactive_shot interactive_shot::set_text(player, #"hash_2f8bb64325eeac62");
                break;
            case #"dpad_right":
                level.interactive_shot interactive_shot::set_text(player, #"hash_2c841879f1d933ef");
                break;
            default:
                level.interactive_shot interactive_shot::set_text(player, #"");
                break;
            }
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0xb8590c20, Offset: 0x3c68
    // Size: 0x148
    function function_f71d8454(player, var_29274d9) {
        if (!level.interactive_shot interactive_shot::is_open(player)) {
            level.interactive_shot interactive_shot::open(player);
        }
        thread function_73e33d10(player);
        player notify(#"hash_940a817baf9765e", {#str_input:var_29274d9});
        s_waitresult = player waittill(#"hash_7ba9e3058f933eb", #"hash_feb654ece8faa3d", #"death");
        if (isdefined(player) && level.interactive_shot interactive_shot::is_open(player)) {
            level.interactive_shot interactive_shot::close(player);
        }
        if (s_waitresult._notify == "death") {
            [[ _o_scene ]]->stop();
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 3, eflags: 0x0
    // Checksum 0x7246d75c, Offset: 0x3680
    // Size: 0x5da
    function check_input(player, var_e61f8576, var_7a31107a) {
        if (isbot(player) && function_3da82b85(player, var_e61f8576)) {
            if (player scene::function_18b2f103() && var_7a31107a) {
                if (player flagsys::get(#"hash_6ce14241f77af1e7")) {
                    return "combat";
                } else if (var_e61f8576.var_5de6d3f0 == "move_up" || var_e61f8576.var_5de6d3f0 == "move_right") {
                    if (player scene::function_4f904976()) {
                        return -1;
                    } else {
                        return 1;
                    }
                } else if (var_e61f8576.var_5de6d3f0 == "move_down" || var_e61f8576.var_5de6d3f0 == "move_left") {
                    if (player scene::function_4f904976()) {
                        return 1;
                    } else {
                        return -1;
                    }
                } else if (player scene::function_4f904976()) {
                    return 0;
                } else {
                    return 1;
                }
            } else if (var_e61f8576.var_5de6d3f0 == "move_up" || var_e61f8576.var_5de6d3f0 == "move_right" || var_e61f8576.var_5de6d3f0 == "move_down" || var_e61f8576.var_5de6d3f0 == "move_left") {
                return 0;
            } else {
                return 0;
            }
        }
        if (!level.interactive_shot interactive_shot::is_open(player)) {
            return 0;
        }
        if (player flagsys::get(#"hash_6ce14241f77af1e7") && !(isdefined(var_e61f8576.var_a0b8116f) && var_e61f8576.var_a0b8116f) && var_7a31107a) {
            return "combat";
        }
        switch (var_e61f8576.var_5de6d3f0) {
        case #"move_up":
        case #"move_down":
            v_movement = player getnormalizedmovement();
            return v_movement[0];
        case #"move_right":
        case #"move_left":
            v_movement = player getnormalizedmovement();
            return v_movement[1];
        case #"jump":
            return (player actionbuttonpressed() ? 1 : 0);
        case #"stance":
            return (player stancebuttonpressed() ? 1 : 0);
        case #"use":
            return (player usebuttonpressed() ? 1 : 0);
        case #"weapon_switch":
            return (player weaponswitchbuttonpressed() ? 1 : 0);
        case #"sprint":
            return (player sprintbuttonpressed() ? 1 : 0);
        case #"melee":
            return (player meleebuttonpressed() ? 1 : 0);
        case #"attack":
            return (!player flagsys::get(#"hash_6ce14241f77af1e7") && var_7a31107a ? 1 : 0);
        case #"dpad_up":
            return (player actionslotonebuttonpressed() ? 1 : 0);
        case #"dpad_down":
            return (player actionslottwobuttonpressed() ? 1 : 0);
        case #"dpad_left":
            return (player actionslotthreebuttonpressed() ? 1 : 0);
        case #"dpad_right":
            return (player actionslotfourbuttonpressed() ? 1 : 0);
        default:
            v_movement = player getnormalizedmovement();
            return v_movement[0];
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0xe8c3caeb, Offset: 0x33c0
    // Size: 0x2b2
    function function_3da82b85(player, var_e61f8576) {
        a_players = array::exclude(util::get_players(), player);
        foreach (player_other in a_players) {
            n_height_diff = abs(player_other.origin[2] - player.origin[2]);
            if (distancesquared(player.origin, player_other.origin) < 16384) {
                if (var_e61f8576.var_5de6d3f0 == "move_up" && player.origin[2] < player_other.origin[2]) {
                    return false;
                }
                if (var_e61f8576.var_5de6d3f0 == "move_down" && player.origin[2] > player_other.origin[2]) {
                    return false;
                }
                var_bdeb98e2 = 0;
                var_4676a8d1 = 0;
                var_c6584028 = vectordot(anglestoright(player.angles), vectornormalize(player.origin - player_other.origin));
                if (var_c6584028 > 0) {
                    var_bdeb98e2 = 1;
                } else {
                    var_4676a8d1 = 1;
                }
                if (var_e61f8576.var_5de6d3f0 == "move_left" && var_bdeb98e2 && n_height_diff < 32) {
                    return false;
                }
                if (var_e61f8576.var_5de6d3f0 == "move_right" && var_4676a8d1 && n_height_diff < 32) {
                    return false;
                }
            }
        }
        return true;
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd67e0ebd, Offset: 0x1ec8
    // Size: 0x14f0
    function function_91d1ac47(player) {
        player notify(#"hash_7ba9e3058f933eb");
        player endon(#"hash_7ba9e3058f933eb", #"death");
        b_movement = 1;
        var_9036cf32 = 0;
        var_7a31107a = 0;
        var_d02edcb8 = isdefined(var_d02edcb8) ? var_d02edcb8 : 0.0001;
        var_d02edcb8 = undefined;
        var_e61f8576 = _s.shots[csceneobject::get_shot(_str_shot)];
        player flagsys::set(#"scene_interactive_shot");
        player.player_anim_look_enabled = 1;
        player.player_anim_clamp_right = isdefined(player.player_anim_clamp_right) ? player.player_anim_clamp_right : 75;
        player.player_anim_clamp_left = isdefined(player.player_anim_clamp_left) ? player.player_anim_clamp_left : 75;
        player.player_anim_clamp_top = isdefined(player.player_anim_clamp_top) ? player.player_anim_clamp_top : 180;
        player.player_anim_clamp_bottom = isdefined(player.player_anim_clamp_bottom) ? player.player_anim_clamp_bottom : 60;
        player.var_32218fc7 = 1;
        thread function_f71d8454(player, var_e61f8576.var_5de6d3f0);
        _str_current_anim = csceneobject::get_animation_name(_str_shot);
        while (true) {
            result = check_input(player, var_e61f8576, var_7a31107a);
            if (result === "combat") {
                n_movement = undefined;
                b_pressed = undefined;
            } else if (isfloat(result)) {
                n_movement = result;
                b_pressed = undefined;
                if (abs(n_movement) < 0.5) {
                    n_movement = 0;
                }
            } else {
                n_movement = undefined;
                b_pressed = result;
            }
            foreach (o_obj in _o_scene._a_objects) {
                o_obj.var_19cb700b = [[ o_obj ]]->function_b2c8d8c2(var_e61f8576, n_movement, player);
                if (!isdefined(o_obj.var_19cb700b)) {
                    o_obj.var_19cb700b = isdefined(o_obj._str_current_anim) ? o_obj._str_current_anim : csceneobject::get_animation_name(_str_shot);
                    if (o_obj === self) {
                        var_cd7e10eb = 1;
                    }
                }
            }
            assert(isdefined(var_19cb700b), "<dev string:x4e>");
            if (isdefined(var_e61f8576.var_db1efa01) && var_e61f8576.var_db1efa01) {
                var_a922a65d = getanimlength(_str_current_anim);
                var_b11ea439 = isdefined(var_e61f8576.var_5b5c3006) ? var_e61f8576.var_5b5c3006 : var_a922a65d / 2;
                var_b11ea439 = math::clamp(var_b11ea439, 0, var_a922a65d);
                var_be7288a4 = var_a922a65d;
                b_pressed_button = 0;
                foreach (o_obj in _o_scene._a_objects) {
                    thread [[ o_obj ]]->_play_anim(o_obj._str_current_anim, 1, 0.2, undefined, 0);
                }
                thread function_9dcfe1ec(player, 1);
                while (var_b11ea439 > 0) {
                    var_b11ea439 -= float(function_f9f48566()) / 1000;
                    var_be7288a4 -= float(function_f9f48566()) / 1000;
                    b_result = check_input(player, var_e61f8576, var_7a31107a);
                    if (b_result) {
                        b_pressed_button = 1;
                        player notify(#"hash_feb654ece8faa3d");
                        while (var_b11ea439 > 0) {
                            waitframe(1);
                            var_b11ea439 -= float(function_f9f48566()) / 1000;
                        }
                        function_6d0488a5(player);
                        var_d02edcb8 = 1;
                        break;
                    }
                    waitframe(1);
                }
                if (!b_pressed_button) {
                    thread function_9dcfe1ec(player, 0);
                    thread function_13709c53(player, 1);
                    while (var_be7288a4 > 0) {
                        var_be7288a4 -= float(function_f9f48566()) / 1000;
                        b_result = check_input(player, var_e61f8576, var_7a31107a);
                        if (b_result) {
                            b_pressed_button = 1;
                            player notify(#"hash_feb654ece8faa3d");
                            while (var_be7288a4 > 0) {
                                waitframe(1);
                                var_be7288a4 -= float(function_f9f48566()) / 1000;
                            }
                            function_1c40de55(player);
                            var_d02edcb8 = 1;
                            break;
                        }
                        waitframe(1);
                    }
                }
                if (!b_pressed_button) {
                    thread function_668ad4ad(player);
                    return;
                }
            } else if (result === "combat" && !(isdefined(var_e61f8576.var_a0b8116f) && var_e61f8576.var_a0b8116f)) {
                if (isarray(player.var_3847bc0f) && player.var_3847bc0f.size) {
                    var_e9fa2b = arraygetclosest(player.origin, player.var_3847bc0f);
                    v_to_target = var_e9fa2b.origin - player.origin;
                    v_to_target = vectornormalize(v_to_target);
                    var_83150539 = vectortoangles(v_to_target);
                } else {
                    var_83150539 = player getplayerangles();
                }
                var_d9b8f5dc = player.origin;
                player animation::stop(0);
                util::wait_network_frame();
                var_490aea9d = 0;
                if (isdefined(var_b6160c2e.var_194f248a)) {
                    assert(isassetloaded("<dev string:x80>", var_b6160c2e.var_194f248a), "<dev string:x88>" + var_b6160c2e.var_194f248a + "<dev string:x97>");
                    var_490aea9d = player gestures::play_gesture(var_b6160c2e.var_194f248a, undefined, 0, 0);
                }
                e_player_link = util::spawn_model("tag_origin", var_d9b8f5dc, var_83150539);
                player playerlinktodelta(e_player_link, undefined, 1, player.player_anim_clamp_right, player.player_anim_clamp_left, player.player_anim_clamp_top, player.player_anim_clamp_bottom);
                if (isanimlooping(var_19cb700b)) {
                    var_b0b1156c = util::spawn_player_clone(player, var_19cb700b, csceneobject::get_align_ent(), 1);
                    var_b0b1156c setinvisibletoplayer(player);
                    player setinvisibletoall();
                }
                player notify(#"hash_feb654ece8faa3d");
                while (player flagsys::get(#"hash_6ce14241f77af1e7")) {
                    waitframe(1);
                }
                if (var_490aea9d) {
                    player stopgestureviewmodel(var_b6160c2e.var_194f248a, 1);
                }
                if (isdefined(e_player_link)) {
                    e_player_link delete();
                }
                if (isdefined(var_b0b1156c)) {
                    var_b0b1156c delete();
                }
                player setvisibletoall();
                foreach (o_obj in _o_scene._a_objects) {
                    thread [[ o_obj ]]->_play_anim(o_obj.var_19cb700b, 1, 0.2, var_d02edcb8, 0, 1);
                }
            } else if (isdefined(b_pressed) && b_pressed && function_3da82b85(player, var_e61f8576)) {
                player notify(#"hash_feb654ece8faa3d");
                foreach (o_obj in _o_scene._a_objects) {
                    if (isdefined(o_obj) && o_obj != self && isdefined(o_obj.var_19cb700b) && !var_9036cf32) {
                        thread [[ o_obj ]]->_play_anim(o_obj.var_19cb700b, 1, 0.2, var_d02edcb8);
                    }
                }
                if (!var_9036cf32) {
                    if (isanimlooping(var_19cb700b)) {
                        thread csceneobject::_play_anim(var_19cb700b, 1, 0.2, 0);
                    } else {
                        csceneobject::_play_anim(var_19cb700b, 1, 0.2, 0);
                    }
                }
                var_d02edcb8 = 1;
            } else if (isdefined(var_cd7e10eb) && var_cd7e10eb || n_movement === 0 && b_movement || !isdefined(n_movement) && !(isdefined(b_pressed) && b_pressed)) {
                b_movement = 0;
                var_cd7e10eb = undefined;
                foreach (o_obj in _o_scene._a_objects) {
                    if (isanimlooping(o_obj.var_19cb700b) && !var_9036cf32) {
                        var_9036cf32 = 1;
                        thread [[ o_obj ]]->_play_anim(o_obj.var_19cb700b, 1, 0.2);
                        continue;
                    }
                    if (!isanimlooping(o_obj.var_19cb700b)) {
                        thread [[ o_obj ]]->_play_anim(o_obj.var_19cb700b, 1, 0, var_d02edcb8, undefined, 1);
                    }
                }
                var_7a31107a = 1;
            } else if (isdefined(n_movement) && n_movement != 0) {
                b_movement = 1;
                n_anim_length = getanimlength(_str_current_anim);
                var_5735b8d2 = abs(n_movement);
                n_update_time = float(function_f9f48566()) / 1000 / n_anim_length;
                var_368626e3 = math::clamp(var_5735b8d2, 1, 1);
                if (csceneobject::function_4a013a61()) {
                    var_d02edcb8 -= n_update_time * var_368626e3;
                    var_9e296f0f = 1 - var_d02edcb8;
                } else {
                    var_d02edcb8 += n_update_time * var_368626e3;
                    var_9e296f0f = var_d02edcb8;
                }
                var_9e296f0f = math::clamp(var_9e296f0f, 0, 1);
                if (var_d02edcb8 <= 0 && csceneobject::function_4a013a61()) {
                    var_cd7e10eb = 1;
                } else {
                    if (animhasnotetrack(var_19cb700b, "interactive_shot_marker")) {
                        a_n_times = getnotetracktimes(var_19cb700b, "interactive_shot_marker");
                        foreach (n_time in a_n_times) {
                            if (n_time > var_9e296f0f) {
                                var_a2aae32f = n_time;
                                break;
                            }
                        }
                    }
                    if (isdefined(var_a2aae32f)) {
                        while (var_9e296f0f <= var_a2aae32f) {
                            foreach (o_obj in _o_scene._a_objects) {
                                thread [[ o_obj ]]->_play_anim(o_obj.var_19cb700b, 1, 0, var_9e296f0f);
                            }
                            waitframe(1);
                            var_d02edcb8 += n_update_time * var_368626e3;
                            var_9e296f0f = var_d02edcb8;
                        }
                        var_a2aae32f = undefined;
                    } else {
                        foreach (o_obj in _o_scene._a_objects) {
                            thread [[ o_obj ]]->_play_anim(o_obj.var_19cb700b, 1, 0, var_9e296f0f);
                        }
                    }
                }
            }
            if (var_d02edcb8 >= 1 || var_d02edcb8 <= 0 && csceneobject::function_4a013a61()) {
                if (csceneobject::function_4a013a61()) {
                    var_eae04066 = csceneobject::get_shot(_str_shot);
                    if (var_eae04066 > 0 && isdefined(_s.shots[var_eae04066 - 1]) && csceneobject::function_a00213f(var_eae04066 - 1) && !(isdefined(_s.shots[var_eae04066 - 1].var_52523e41) && _s.shots[var_eae04066 - 1].var_52523e41)) {
                        var_d02edcb8 = 1;
                        _o_scene.var_1b3d0016 = _s.shots[var_eae04066 - 1].name;
                        waitframe(1);
                    } else {
                        var_d02edcb8 = math::clamp(var_d02edcb8, 0, 1);
                        waitframe(1);
                        continue;
                    }
                }
                foreach (o_obj in _o_scene._a_objects) {
                    o_obj._b_active_anim = 0;
                    o_obj flagsys::clear(#"scene_interactive_shot_active");
                }
                return;
            }
            var_d02edcb8 = math::clamp(var_d02edcb8, 0, 1);
            waitframe(1);
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb849b966, Offset: 0x1d80
    // Size: 0x13a
    function function_4d6f7f4a(player) {
        if (isbot(player)) {
            return;
        }
        if (isdefined(var_b6160c2e.var_18f7d253)) {
            switch (var_b6160c2e.var_18f7d253) {
            case #"bank1":
                player clientfield::set_to_player("player_pbg_bank_scene_system", 0);
                break;
            case #"bank2":
                player clientfield::set_to_player("player_pbg_bank_scene_system", 1);
                break;
            case #"bank3":
                player clientfield::set_to_player("player_pbg_bank_scene_system", 2);
                break;
            case #"bank4":
                player clientfield::set_to_player("player_pbg_bank_scene_system", 3);
                break;
            }
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x468533a8, Offset: 0x1b28
    // Size: 0x24e
    function function_94daf53(player) {
        player.player_anim_look_enabled = !(isdefined(_s.lockview) && _s.lockview);
        player.player_anim_clamp_right = isdefined(isdefined(var_b6160c2e.viewclampright) ? var_b6160c2e.viewclampright : _s.viewclampright) ? isdefined(var_b6160c2e.viewclampright) ? var_b6160c2e.viewclampright : _s.viewclampright : 0;
        player.player_anim_clamp_left = isdefined(isdefined(var_b6160c2e.viewclampleft) ? var_b6160c2e.viewclampleft : _s.viewclampleft) ? isdefined(var_b6160c2e.viewclampleft) ? var_b6160c2e.viewclampleft : _s.viewclampleft : 0;
        player.player_anim_clamp_top = isdefined(isdefined(var_b6160c2e.viewclamptop) ? var_b6160c2e.viewclamptop : _s.viewclamptop) ? isdefined(var_b6160c2e.viewclamptop) ? var_b6160c2e.viewclamptop : _s.viewclamptop : 0;
        player.player_anim_clamp_bottom = isdefined(isdefined(var_b6160c2e.viewclampbottom) ? var_b6160c2e.viewclampbottom : _s.viewclampbottom) ? isdefined(var_b6160c2e.viewclampbottom) ? var_b6160c2e.viewclampbottom : _s.viewclampbottom : 0;
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0x3c78c0d, Offset: 0x1a98
    // Size: 0x84
    function function_a2cabd71(player, b_enable) {
        if (b_enable) {
            if (isdefined(player.var_ed004196) && player.var_ed004196) {
                player.var_ed004196 = undefined;
                player weapons::force_stowed_weapon_update();
            }
            return;
        }
        player.var_ed004196 = 1;
        player clearstowedweapon();
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x18a07232, Offset: 0x1980
    // Size: 0x10c
    function function_5d942562(player) {
        if (isdefined(player.var_a157cfb2)) {
            player takeweapon(player.var_a157cfb2);
            player val::reset(#"weapon_shot_specific", "take_weapons");
            player player::switch_to_primary_weapon(1);
            player.var_a157cfb2 = undefined;
        }
        if (isdefined(var_b6160c2e.hidestowedweapon) && var_b6160c2e.hidestowedweapon) {
            function_a2cabd71(player, 1);
        }
        if (!(isdefined(_s.dontreloadammo) && _s.dontreloadammo)) {
            player player::fill_current_clip();
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0x4d980d7d, Offset: 0x18a0
    // Size: 0xd2
    function function_bb6c102e(player, var_5bd1f215) {
        w_slot = player loadout::function_3d8b02a0(var_5bd1f215);
        var_1e8f26a0 = player getcurrentweapon();
        if (w_slot != var_1e8f26a0) {
            player val::set(#"weapon_shot_specific", "take_weapons", 1);
            player giveweapon(w_slot);
            player switchtoweaponimmediate(w_slot);
            player.var_a157cfb2 = w_slot;
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x32dd7f67, Offset: 0x13b0
    // Size: 0x4e4
    function function_294d5aff(player) {
        if ((!(isdefined(_s.removeweapon) && _s.removeweapon) || isdefined(_s.showweaponinfirstperson) && _s.showweaponinfirstperson) && !(isdefined(_s.disableprimaryweaponswitch) && _s.disableprimaryweaponswitch)) {
            player player::switch_to_primary_weapon(1);
        }
        if (isdefined(var_b6160c2e.var_b53651cf) && var_b6160c2e.var_b53651cf) {
            w_primary = player loadout::function_3d8b02a0("primary");
            var_4e1e6f09 = w_primary.rootweapon;
            w_secondary = player loadout::function_3d8b02a0("secondary");
            var_ad7115e1 = w_secondary.rootweapon;
            var_200466be = array(getweapon(#"ar_accurate_t8"), getweapon(#"ar_fastfire_t8"), getweapon(#"ar_stealth_t8"), getweapon(#"ar_damage_t8"), getweapon(#"ar_modular_t8"), getweapon(#"smg_handling_t8"), getweapon(#"smg_standard_t8"), getweapon(#"smg_accurate_t8"), getweapon(#"smg_fastfire_t8"), getweapon(#"smg_capacity_t8"), getweapon(#"lmg_heavy_t8"), getweapon(#"lmg_standard_t8"), getweapon(#"lmg_spray_t8"));
            arrayremovevalue(var_200466be, level.weaponnone);
            if (isinarray(var_200466be, var_4e1e6f09)) {
                function_bb6c102e(player, "primary");
            } else if (isinarray(var_200466be, var_ad7115e1)) {
                function_bb6c102e(player, "secondary");
            } else {
                a_weapon_options = player getweaponoptions(w_primary);
                player val::set(#"weapon_shot_specific", "take_weapons", 1);
                player giveweapon(getweapon(#"ar_accurate_t8"), a_weapon_options);
                player switchtoweaponimmediate(getweapon(#"ar_accurate_t8"), 1);
                player.var_a157cfb2 = getweapon(#"ar_accurate_t8");
            }
        }
        if (isdefined(var_b6160c2e.hidestowedweapon) && var_b6160c2e.hidestowedweapon) {
            function_a2cabd71(player, 0);
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf5b008b8, Offset: 0xa28
    // Size: 0x980
    function _prepare_player(player) {
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x30>");
            }
        #/
        player endon(#"death");
        player notify(#"new_shot");
        var_2691daee = scene::function_f589f84a(_o_scene._str_name, _str_shot) || isdefined(_o_scene.b_play_from_time) && _o_scene.b_play_from_time;
        function_4d6f7f4a(player);
        if (player.var_dd686719 === _o_scene._str_name) {
            return 0;
        }
        /#
            if (player === level.host && scene::check_team(player.team, _str_team)) {
                display_dev_info();
            }
        #/
        if (!(isdefined(_s.showhud) && _s.showhud) && !(isdefined(_s.allowdeath) && _s.allowdeath)) {
            player scene::set_igc_active(1);
        }
        _set_values(player);
        player sethighdetail(1);
        str_streamer_hint = _o_scene._a_streamer_hint[player.team];
        if (isdefined(str_streamer_hint)) {
            if (isdefined(player.var_9eddf64e) && player.var_9eddf64e != -1) {
                _n_streamer_req = player.var_9eddf64e;
            } else if (_n_streamer_req == -1) {
                _n_streamer_req = player playerstreamerrequest("set", str_streamer_hint);
                player.var_1375be5 = str_streamer_hint;
            }
            if (var_2691daee && _n_streamer_req != -1) {
                if (!(isdefined(level.scene_streamer_ignore[_o_scene._s.name]) && level.scene_streamer_ignore[_o_scene._s.name])) {
                    if (!(isdefined(_o_scene._s.ignorestreamer) && _o_scene._s.ignorestreamer) && !(isdefined(_o_scene._b_testing) && _o_scene._b_testing) && !scene::function_e1e106d2(_o_scene._s.name)) {
                        self endon(#"new_shot");
                        level util::streamer_wait(undefined, 0, getdvarint(#"hash_47b7504d8ac8d477", 30), player.team);
                    }
                }
            }
        }
        if (var_2691daee && [[ _o_scene ]]->is_scene_shared()) {
            player thread lui::screen_fade_in(0.5, undefined, "igc");
        }
        player.var_9eddf64e = undefined;
        if (player flagsys::get(#"mobile_armory_in_use")) {
            player flagsys::set(#"cancel_mobile_armory");
            player closemenu("mobile_armory_loadout");
            params = {#menu:"mobile_armory_loadout", #response:"cancel", #intpayload:0};
            player notify(#"menuresponse", params);
            player callback::callback(#"menu_response", params);
        }
        if (player flagsys::get(#"mobile_armory_begin_use")) {
            player val::reset(#"mobile_armory_use", "disable_weapons");
            player flagsys::clear(#"mobile_armory_begin_use");
        }
        if (getdvarint(#"scene_hide_player", 0) > 0) {
            player val::set(#"scene", "hide");
        }
        player._scene_object = self;
        player.var_dd686719 = _o_scene._str_name;
        player.var_2d7eda15 = player.var_dd686719;
        player.anim_debug_name = _s.name;
        if ([[ _o_scene ]]->is_scene_shared() && (var_2691daee || scene::function_e1e106d2(_o_scene._str_name)) && !csceneobject::is_skipping_scene()) {
            player thread scene::function_9987a727(_o_scene);
            if (var_2691daee && getdvarint(#"hash_44f3b54c25dfae3b", 0)) {
                player clientfield::set_to_player("postfx_cateye", 1);
            }
        }
        revive_player(player);
        player thread util::cleanup_fancycam();
        if (isdefined(player.hijacked_vehicle_entity)) {
            player.hijacked_vehicle_entity delete();
        } else if (isalive(player) && !(isdefined(_s.var_2cd693be) && _s.var_2cd693be) && player isinvehicle()) {
            vh_occupied = player getvehicleoccupied();
            n_seat = vh_occupied getoccupantseat(player);
            vh_occupied usevehicle(player, n_seat);
        }
        if (_o_scene._s scene::is_igc()) {
            player thread scene::scene_disable_player_stuff(_o_scene._s, _s);
        }
        if (isdefined(_s.var_4c0453af) && _s.var_4c0453af) {
        }
        function_94daf53(player);
        function_294d5aff(player);
        set_player_stance(player);
        player flagsys::set(#"scene");
        waitframe(0);
        if (csceneobject::function_a00213f(csceneobject::get_shot(_str_shot))) {
            thread function_91d1ac47(player);
        }
        player notify(#"scene_ready");
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0xaf969758, Offset: 0xa00
    // Size: 0x1c
    function _prepare() {
        _prepare_player(_e);
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7e25fa1e, Offset: 0x8d8
    // Size: 0x11c
    function _reset_values(ent = self._e) {
        csceneobject::reset_ent_val("takedamage", ent);
        csceneobject::reset_ent_val("ignoreme", ent);
        csceneobject::reset_ent_val("allowdeath", ent);
        csceneobject::reset_ent_val("take_weapons", ent);
        if (isbot(ent) && (csceneobject::function_1c059f9b(_str_shot) || _o_scene._str_mode === "single" || isdefined(_o_scene.scene_stopping) && _o_scene.scene_stopping)) {
            ent botreleasemanualcontrol();
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe3a470c8, Offset: 0x728
    // Size: 0x1a4
    function _set_values(ent = self._e) {
        if (!(isdefined(_s.takedamage) && _s.takedamage)) {
            ent setnormalhealth(1);
        }
        if (isdefined(ent.takedamage) && ent.takedamage && !ent getinvulnerability()) {
            csceneobject::set_ent_val("takedamage", isdefined(_s.takedamage) && _s.takedamage, ent);
        }
        csceneobject::set_ent_val("ignoreme", !(isdefined(_s.takedamage) && _s.takedamage), ent);
        csceneobject::set_ent_val("allowdeath", isdefined(_s.allowdeath) && _s.allowdeath, ent);
        csceneobject::set_ent_val("take_weapons", isdefined(_s.removeweapon) && _s.removeweapon, ent);
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0xef880f92, Offset: 0x610
    // Size: 0x10c
    function function_4c774cdb() {
        if (csceneobject::function_a00213f(csceneobject::get_shot(_str_shot))) {
            return;
        }
        self notify(#"hash_30095f69ee804b7e");
        self endon(#"hash_30095f69ee804b7e");
        _o_scene endon(#"scene_done", #"scene_stop", #"scene_skip_completed");
        s_waitresult = _e waittill(#"death");
        var_5c4adc26 = 1;
        _e notify(#"hash_6e7fd8207fd988c6", {#str_scene:_o_scene._str_name});
        csceneobject::function_2550967e();
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8486621a, Offset: 0x4c8
    // Size: 0x140
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
        csceneobject::restore_saved_ent();
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
    // Checksum 0x22c4ee5f, Offset: 0x3a0
    // Size: 0x11c
    function _stop(b_dont_clear_anim, b_finished) {
        if (isalive(_e)) {
            _e notify(#"scene_stop");
            stop_camera(_e);
            _e flagsys::clear(#"hash_7cddd51e45d3ff3e");
            if (!(isdefined(_s.diewhenfinished) && _s.diewhenfinished) || !b_finished) {
                _e animation::stop(0.2);
            }
            _e thread scene::scene_enable_player_stuff(_o_scene._s, _s, _o_scene._e_root);
        }
    }

    // Namespace csceneplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0x1bfb6b8b, Offset: 0x330
    // Size: 0x62
    function first_init(s_objdef, o_scene) {
        if (isdefined(o_scene._str_team)) {
            s_objdef.team = o_scene._str_team;
        }
        s_objdef.nospawn = 1;
        return csceneobject::first_init(s_objdef, o_scene);
    }

}

// Namespace scene
// Method(s) 8 Total 150
class cscenesharedplayer : csceneplayer, csceneobject {

    var _e;
    var _func_get;
    var _func_get_active;
    var _o_scene;
    var _s;
    var _str_current_anim;
    var _str_shot;
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
    // Checksum 0x4f9e89d5, Offset: 0x8fd0
    // Size: 0x88
    function _cleanup() {
        foreach (player in [[ _func_get ]](_str_team)) {
            csceneplayer::_cleanup_player(player);
        }
    }

    // Namespace cscenesharedplayer/scene_player_shared
    // Params 2, eflags: 0x0
    // Checksum 0xeee31d29, Offset: 0x8ed8
    // Size: 0xf0
    function _stop(b_dont_clear_anim, b_finished) {
        foreach (player in [[ _func_get ]](_str_team)) {
            csceneplayer::stop_camera(player);
            player animation::stop();
            player thread scene::scene_enable_player_stuff(_o_scene._s, _s, _o_scene._e_root);
        }
    }

    // Namespace cscenesharedplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0x61961fda, Offset: 0x8e00
    // Size: 0xd0
    function _set_visibility() {
        a_players = [[ _func_get ]](_str_team);
        foreach (player in a_players) {
            player show();
            if (!player flagsys::get(#"hash_7cddd51e45d3ff3e")) {
                player setinvisibletoall();
            }
        }
    }

    // Namespace cscenesharedplayer/scene_player_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5ae6299b, Offset: 0x8690
    // Size: 0x764
    function _play_shared_player_anim_for_player(player) {
        player endon(#"death");
        if (!scene::check_team(player.team, _str_team)) {
            return;
        }
        str_animation = player_animation;
        str_animation = animation_lookup(str_animation, player);
        csceneplayer::on_play_anim(player);
        /#
        #/
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x15f>" + player_animation);
            }
        #/
        player.current_scene = _o_scene._str_name;
        player flagsys::set(#"shared_igc");
        if (player flagsys::get(player_animation_notify)) {
            player flagsys::set(player_animation_notify + "_skip_init_clear");
        }
        player flagsys::set(player_animation_notify);
        if (isdefined(player getlinkedent())) {
            player unlink();
        }
        if (!(isdefined(_s.disabletransitionin) && _s.disabletransitionin)) {
            if (player != _e || getdvarint(#"scr_player1_postfx", 0)) {
                if (!isdefined(player.screen_fade_menus)) {
                    if (!(isdefined(level.chyron_text_active) && level.chyron_text_active)) {
                        if (!(isdefined(player.var_642340d4) && player.var_642340d4)) {
                            player.play_scene_transition_effect = 1;
                        }
                    }
                }
            }
        }
        csceneplayer::_prepare_player(player);
        n_time_passed = float(gettime() - player_start_time) / 1000;
        n_start_time = player_time_frac * player_animation_length;
        n_time_left = player_animation_length - n_time_passed - n_start_time;
        n_time_frac = 1 - n_time_left / player_animation_length;
        if (isdefined(_e) && player != _e) {
            player dontinterpolate();
            player setorigin(_e.origin);
            if (!isbot(player)) {
                player setplayerangles(_e getplayerangles());
            }
        }
        n_lerp = csceneobject::get_lerp_time();
        if (!csceneplayer::function_18bf09f7()) {
            csceneplayer::stop_camera(player);
            n_camera_tween = csceneobject::get_camera_tween();
            if (n_camera_tween > 0) {
                player startcameratween(n_camera_tween);
            }
        }
        if (n_time_frac < 1) {
            /#
                if (getdvarint(#"scene_hide_player", 0) > 0) {
                    player val::set(#"scene", "<dev string:x193>");
                }
                if (getdvarint(#"debug_scene", 0) > 0) {
                    printtoprightln("<dev string:x198>" + _s.name + "<dev string:x1dd>" + player_animation);
                }
            #/
            player_num = player getentitynumber();
            if (!isdefined(current_playing_anim)) {
                current_playing_anim[player_num] = [];
            }
            current_playing_anim[player_num] = str_animation;
            if (csceneobject::is_skipping_scene()) {
                thread csceneobject::skip_scene(1);
            }
            var_3bb6221f = csceneobject::function_f4286b3f();
            if (csceneobject::function_178eaec9()) {
                player val::set(#"scene_player", "freezecontrols", 1);
                csceneobject::function_54ad27ab();
                player val::reset(#"scene_player", "freezecontrols");
            } else {
                player animation::play(str_animation, player_align, player_tag, player_rate, 0, 0, n_lerp, n_time_frac, _s.showweaponinfirstperson, undefined, var_3bb6221f);
            }
            if (!player flagsys::get(player_animation_notify + "_skip_init_clear")) {
                player flagsys::clear(player_animation_notify);
            } else {
                player flagsys::clear(player_animation_notify + "_skip_init_clear");
            }
            if (!player isplayinganimscripted()) {
                current_playing_anim[player_num] = undefined;
            }
            /#
                if (getdvarint(#"debug_scene", 0) > 0) {
                    printtoprightln("<dev string:x1e1>" + _s.name + "<dev string:x229>" + player_animation);
                }
            #/
        }
    }

    // Namespace cscenesharedplayer/scene_player_shared
    // Params 4, eflags: 0x0
    // Checksum 0x54fd837e, Offset: 0x82a8
    // Size: 0x3e0
    function _play_anim(animation, n_rate, n_blend, n_time) {
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x129>" + animation);
            }
        #/
        _str_current_anim = animation;
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
            if (player flagsys::get(#"loadout_given") && player.sessionstate !== "spectator") {
                self thread _play_shared_player_anim_for_player(player);
                continue;
            }
            if (isdefined(player.initialloadoutgiven) && player.initialloadoutgiven) {
                csceneplayer::revive_player(player);
            }
        }
        _set_visibility();
        waittillframeend();
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
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                csceneobject::log(toupper(_s.type) + "<dev string:x152>" + _str_current_anim + "<dev string:xf0>");
            }
        #/
        thread [[ _o_scene ]]->_call_shot_funcs("players_done");
    }

    // Namespace cscenesharedplayer/scene_player_shared
    // Params 0, eflags: 0x0
    // Checksum 0xcb2fc49d, Offset: 0x81c0
    // Size: 0xdc
    function _prepare() {
        if (!csceneobject::function_ef717ad5(_str_shot)) {
            return;
        }
        a_players = [[ _func_get ]](_str_team);
        foreach (ent in a_players) {
            thread _prepare_player(ent);
        }
        _set_visibility();
        array::wait_till(a_players, "scene_ready");
    }

}

// Namespace scene
// Method(s) 2 Total 116
class cscenefakeplayer : csceneobject {

}

