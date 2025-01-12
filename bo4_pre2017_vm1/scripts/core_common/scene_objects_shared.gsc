#using scripts/core_common/ai_shared;
#using scripts/core_common/animation_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/laststand_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/player_shared;
#using scripts/core_common/scene_actor_shared;
#using scripts/core_common/scene_debug_shared;
#using scripts/core_common/scene_model_shared;
#using scripts/core_common/scene_player_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/scene_vehicle_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;

#namespace scene;

// Namespace scene
// Method(s) 69 Total 69
class csceneobject {

    var _b_active_anim;
    var _b_first_frame;
    var _b_set_goal;
    var _e;
    var _n_blend;
    var _n_ent_num;
    var _o_scene;
    var _s;
    var _str_camera;
    var _str_current_anim;
    var _str_name;
    var _str_shot;
    var _str_team;
    var camera_start_time;
    var current_playing_anim;
    var m_align;
    var m_tag;
    var var_2b1650fa;

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf09f4b8a, Offset: 0x5de0
    // Size: 0xe
    function get_ent() {
        return _e;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x9d9b8bf3, Offset: 0x5d08
    // Size: 0xcc
    function warning(condition, str_msg) {
        if (condition) {
            str_msg = "[ " + _o_scene._str_name + " ] " + (isdefined("no name") ? "" + "no name" : isdefined(_s.name) ? "" + _s.name : "") + ": " + str_msg;
            level scene::warning_on_screen(str_msg);
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xbcaf46d8, Offset: 0x5bd0
    // Size: 0x130
    function error(condition, str_msg) {
        if (condition) {
            str_msg = "[ " + _o_scene._str_name + " ] " + (isdefined("no name") ? "" + "no name" : isdefined(_s.name) ? "" + _s.name : "") + ": " + str_msg;
            if (isdefined(_o_scene._b_testing) && _o_scene._b_testing) {
                scene::error_on_screen(str_msg);
            } else {
                /#
                    assertmsg(str_msg);
                #/
            }
            thread [[ _o_scene ]]->on_error();
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd5c5e75a, Offset: 0x5af8
    // Size: 0xcc
    function log(str_msg) {
        /#
            println(_o_scene._s.type + "<dev string:x134>" + _o_scene._str_name + "<dev string:x136>" + (isdefined("<dev string:x13b>") ? "<dev string:x13a>" + "<dev string:x13b>" : isdefined(_s.name) ? "<dev string:x13a>" + _s.name : "<dev string:x13a>") + "<dev string:x143>" + str_msg);
        #/
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x11fb0837, Offset: 0x5ac0
    // Size: 0x2e
    function is_skipping_scene() {
        return isdefined([[ _o_scene ]]->is_skipping_scene()) && [[ _o_scene ]]->is_skipping_scene();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd3111260, Offset: 0x5a58
    // Size: 0x60
    function skip_scene(b_wait_one_frame) {
        if (isdefined(b_wait_one_frame)) {
            waitframe(1);
        }
        while (flagsys::get(_str_shot + "active")) {
            skip_scene_shot_animations(1);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc52068fb, Offset: 0x59c8
    // Size: 0x82
    function skip_scene_shot_animations(b_wait_one_frame) {
        if (isdefined(b_wait_one_frame)) {
            waitframe(1);
        }
        if (isdefined(current_playing_anim) && isdefined(current_playing_anim[_n_ent_num])) {
            if (skip_animation_on_client()) {
                waitframe(1);
            }
            skip_animation_on_server();
        }
        self notify(#"skip_camera_anims");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6c08bb33, Offset: 0x57c0
    // Size: 0x1fc
    function skip_animation_on_server() {
        if (isdefined(current_playing_anim[_n_ent_num])) {
            if (is_shared_player()) {
                foreach (player in level.players) {
                    /#
                        if (getdvarint("<dev string:xac>") > 0) {
                            printtoprightln("<dev string:x110>" + current_playing_anim[player getentitynumber()] + "<dev string:xa8>" + gettime(), (0.8, 0.8, 0.8));
                        }
                    #/
                    skip_anim_on_server(player, current_playing_anim[player getentitynumber()]);
                }
                return;
            }
            /#
                if (getdvarint("<dev string:xac>") > 0) {
                    printtoprightln("<dev string:x110>" + current_playing_anim[_n_ent_num] + "<dev string:xa8>" + gettime(), (0.8, 0.8, 0.8));
                }
            #/
            skip_anim_on_server(_e, current_playing_anim[_n_ent_num]);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x776c6ff, Offset: 0x55b0
    // Size: 0x204
    function skip_animation_on_client() {
        if (isdefined(current_playing_anim[_n_ent_num])) {
            if (is_shared_player()) {
                foreach (player in level.players) {
                    /#
                        if (getdvarint("<dev string:xac>") > 0) {
                            printtoprightln("<dev string:xec>" + current_playing_anim[player getentitynumber()] + "<dev string:xa8>" + gettime(), (0.8, 0.8, 0.8));
                        }
                    #/
                    skip_anim_on_client(player, current_playing_anim[player getentitynumber()]);
                }
            } else {
                /#
                    if (getdvarint("<dev string:xac>") > 0) {
                        printtoprightln("<dev string:xec>" + current_playing_anim[_n_ent_num] + "<dev string:xa8>" + gettime(), (0.8, 0.8, 0.8));
                    }
                #/
                skip_anim_on_client(_e, current_playing_anim[_n_ent_num]);
            }
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xc25115c1, Offset: 0x54e8
    // Size: 0xbc
    function skip_anim_on_server(entity, anim_name) {
        if (!isdefined(anim_name)) {
            return;
        }
        if (!isdefined(entity)) {
            return;
        }
        if (!entity isplayinganimscripted()) {
            return;
        }
        is_looping = isanimlooping(anim_name);
        if (is_looping) {
            entity animation::stop();
        } else {
            entity setanimtimebyname(anim_name, 1);
        }
        entity stopsounds();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x64aff66e, Offset: 0x5450
    // Size: 0x8c
    function skip_anim_on_client(entity, anim_name) {
        if (!isdefined(anim_name)) {
            return;
        }
        if (!isdefined(entity)) {
            return;
        }
        if (!entity isplayinganimscripted()) {
            return;
        }
        is_looping = isanimlooping(anim_name);
        if (is_looping) {
            return;
        }
        entity clientfield::increment("player_scene_animation_skip");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x693ac107, Offset: 0x5338
    // Size: 0x10e
    function _should_skip_anim(animation) {
        if (isdefined(_s.deletewhenfinished) && !is_player() && !(isdefined(_s.keepwhileskipping) && _s.keepwhileskipping) && is_skipping_scene() && _s.deletewhenfinished) {
            if (!animhasimportantnotifies(animation)) {
                if (!isspawner(_e)) {
                    e = scene::get_existing_ent(_str_name);
                    if (isdefined(e)) {
                        return false;
                    }
                }
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7c8b2280, Offset: 0x52e0
    // Size: 0x50
    function in_a_different_scene() {
        return isdefined(_e) && isdefined(_e.current_scene) && _e.current_scene != _o_scene._str_name;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf9bf6564, Offset: 0x5230
    // Size: 0xa6
    function in_this_scene(ent) {
        foreach (obj in _o_scene._a_objects) {
            if (obj._e === ent) {
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa489aeb3, Offset: 0x5208
    // Size: 0x20
    function is_shared_player() {
        return _s.type === "sharedplayer";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd3b317a1, Offset: 0x51e0
    // Size: 0x20
    function is_player_model() {
        return _s.type === "fakeplayer";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x41ea5a9c, Offset: 0x5198
    // Size: 0x40
    function is_player() {
        return _s.type === "player" || _s.type === "sharedplayer";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3ad5ea6f, Offset: 0x5118
    // Size: 0x78
    function is_alive() {
        return (!isai(_e) || isdefined(_e) && isalive(_e)) && !(isdefined(_e.isdying) && _e.isdying);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1cc525f1, Offset: 0x50d8
    // Size: 0x34
    function get_camera_tween_out() {
        return isdefined(_s.cameratweenout) ? _s.cameratweenout : 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3fa28b62, Offset: 0x5098
    // Size: 0x34
    function get_camera_tween() {
        return isdefined(_s.cameratween) ? _s.cameratween : 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8a10e167, Offset: 0x5008
    // Size: 0x82
    function get_lerp_time() {
        if (isplayer(_e)) {
            return (isdefined(_s.lerptime) ? _s.lerptime : 0);
        }
        return isdefined(_s.entitylerptime) ? _s.entitylerptime : 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x710cb97c, Offset: 0x4f50
    // Size: 0xaa
    function regroup_invulnerability(e_player) {
        e_player endon(#"disconnect");
        e_player val::set("regroup", "ignoreme", 1);
        e_player.b_teleport_invulnerability = 1;
        e_player util::streamer_wait(undefined, 0, 7);
        e_player val::reset("regroup", "ignoreme");
        e_player.b_teleport_invulnerability = undefined;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2c0a47ca, Offset: 0x4d58
    // Size: 0x1ec
    function play_regroup_fx_for_scene(e_player) {
        align = get_align_ent();
        v_origin = align.origin;
        v_angles = align.angles;
        tag = get_align_tag();
        if (isdefined(tag)) {
            v_origin = align gettagorigin(tag);
            v_angles = align gettagangles(tag);
        }
        v_start = getstartorigin(v_origin, v_angles, _s.mainanim);
        n_dist_sq = distancesquared(e_player.origin, v_start);
        if ((n_dist_sq > 250000 || isdefined(e_player.hijacked_vehicle_entity)) && !(isdefined(e_player.force_short_scene_transition_effect) && e_player.force_short_scene_transition_effect)) {
            self thread regroup_invulnerability(e_player);
            e_player clientfield::increment_to_player("postfx_igc", 1);
        } else {
            e_player clientfield::increment_to_player("postfx_igc", 3);
        }
        util::wait_network_frame();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd16c2b88, Offset: 0x4cb8
    // Size: 0x94
    function kill_ent() {
        _e util::stop_magic_bullet_shield();
        _e.skipdeath = 1;
        _e.allowdeath = 1;
        _e.skipscenedeath = 1;
        _e._scene_object = undefined;
        _e kill();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x80f724d1, Offset: 0x4ca8
    // Size: 0x4
    function _spawn_ent() {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x80d48ada, Offset: 0x4a58
    // Size: 0x244
    function spawn_ent() {
        flagsys::set("spawning");
        b_disable_throttle = isdefined(_o_scene._s.dontthrottle) && _o_scene._s.dontthrottle;
        if (!b_disable_throttle) {
            spawner::global_spawn_throttle();
        }
        if (isspawner(_e)) {
            /#
                if (_o_scene._b_testing) {
                    _e.count++;
                }
            #/
            if (!error(_e.count < 1, "Trying to spawn AI for scene with spawner count < 1")) {
                _e = _e spawner::spawn(1);
            }
        } else {
            _spawn_ent();
        }
        if (!isdefined(_e)) {
            if (isdefined(_s.model)) {
                if (is_player_model()) {
                    _e = util::spawn_anim_player_model(_s.model, _o_scene._e_root.origin, _o_scene._e_root.angles);
                } else {
                    _e = util::spawn_anim_model(_s.model, _o_scene._e_root.origin, _o_scene._e_root.angles);
                }
            }
        }
        flagsys::clear("spawning");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 4, eflags: 0x0
    // Checksum 0xc5158fe1, Offset: 0x4900
    // Size: 0x14c
    function _camanimscripted(player, str_anim, v_origin, v_angles) {
        player notify(#"camanimscripted");
        player endon(#"camanimscripted");
        player dontinterpolate();
        player thread scene::scene_disable_player_stuff(_o_scene._s, _s);
        camanimscripted(player, str_anim, camera_start_time, v_origin, v_angles);
        wait_for_camera(str_anim, _o_scene.n_start_time);
        player dontinterpolate();
        endcamanimscripted(player);
        player thread scene::scene_enable_player_stuff(_o_scene._s, _s, _o_scene._e_root);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xfc499371, Offset: 0x4788
    // Size: 0x170
    function play_camera_on_player(player) {
        if (is_shared_player() && (player == _e || scene::check_team(player.team, _str_team))) {
            player.current_scene = _o_scene._str_name;
            e_align = [[ _o_scene ]]->get_align_ent();
            v_origin = isdefined(e_align.origin) ? e_align.origin : (0, 0, 0);
            v_angles = isdefined(e_align.angles) ? e_align.angles : (0, 0, 0);
            str_anim = animation_lookup(_str_camera, player, 1);
            self thread _camanimscripted(player, str_anim, v_origin, v_angles);
            on_play_anim(player);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd0a47aa1, Offset: 0x45c0
    // Size: 0x1bc
    function play_camera(animation) {
        flagsys::set("camera_playing");
        _str_camera = animation;
        if (is_shared_player()) {
            callback::on_loadout(&play_camera_on_player, self);
        }
        camera_start_time = gettime();
        foreach (player in level.players) {
            self thread play_camera_on_player(player);
        }
        str_anim = animation_lookup(_str_camera, _e, 1);
        wait_for_camera(str_anim, _o_scene.n_start_time);
        flagsys::clear("camera_playing");
        _str_camera = undefined;
        if (is_shared_player()) {
            callback::remove_on_loadout(&play_camera_on_player, self);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xe3eb03cd, Offset: 0x4500
    // Size: 0xb4
    function wait_for_camera(str_cam, n_start_time) {
        self endon(#"skip_camera_anims");
        self endon(_str_shot + "active");
        if (iscamanimlooping(str_cam)) {
            level waittill("forever");
            return;
        }
        n_cam_time = getcamanimtime(str_cam);
        scene::wait_server_time(n_cam_time / 1000, n_start_time);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xda26a119, Offset: 0x44e8
    // Size: 0xc
    function on_play_anim(ent) {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xc020377a, Offset: 0x4228
    // Size: 0x2b4
    function function_855eda8d(ent, var_febea063) {
        var_3bb6221f = undefined;
        if (getdvarint("scr_scene_player_perspectives") > 0) {
            if (ent util::is_companion()) {
                var_fe2f60d6 = _o_scene.var_c8269f35;
                if (function_9bf071ce(var_fe2f60d6, ent.team)) {
                    var_c85c7af7 = ent.owner getentitynumber();
                }
            } else if (isplayer(ent) && !ent util::is_companion()) {
                var_fe2f60d6 = _o_scene.var_51bc3a4;
                if (function_9bf071ce(var_fe2f60d6, ent.team)) {
                    var_c85c7af7 = ent getentitynumber();
                }
            }
            if (isdefined(var_c85c7af7)) {
                a_players = util::get_players();
                foreach (player in a_players) {
                    var_9f2107df = player getentitynumber();
                    if (var_9f2107df == var_c85c7af7) {
                        var_3bb6221f[var_9f2107df] = var_fe2f60d6[ent.team]["primary"];
                        continue;
                    }
                    if (ent.team == player.team && ent != player) {
                        var_3bb6221f[var_9f2107df] = var_fe2f60d6[ent.team]["secondary"];
                        continue;
                    }
                    var_3bb6221f[var_9f2107df] = var_febea063;
                }
            }
        }
        return var_3bb6221f;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x81bc38fe, Offset: 0x41b8
    // Size: 0x68
    function function_9bf071ce(var_fe2f60d6, str_team) {
        if (isdefined(var_fe2f60d6) && isdefined(var_fe2f60d6[str_team]) && isdefined(var_fe2f60d6[str_team]["primary"]) && isdefined(var_fe2f60d6[str_team]["secondary"])) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 4, eflags: 0x0
    // Checksum 0x857456d5, Offset: 0x3b58
    // Size: 0x654
    function _play_anim(animation, n_rate, n_blend, n_time) {
        if (_o_scene._s scene::is_igc() || _e.scene_spawned === _o_scene._s.name) {
            _e dontinterpolate();
            _e show();
        }
        n_lerp = get_lerp_time();
        if (isplayer(_e) && !_o_scene._s scene::is_igc()) {
            n_camera_tween = get_camera_tween();
            if (n_camera_tween > 0) {
                _e startcameratween(n_camera_tween);
            }
        }
        if (![[ _o_scene ]]->function_cc8737c()) {
            n_blend_out = isai(_e) ? 0.2 : 0;
        } else {
            n_blend_out = 0;
        }
        if (isdefined(_s.diewhenfinished) && _s.diewhenfinished) {
            n_blend_out = 0;
        }
        /#
            if (getdvarint("<dev string:x39>") > 0) {
                printtoprightln("<dev string:x79>" + (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:xa8>" + animation);
            }
        #/
        /#
            if (getdvarint("<dev string:xac>") > 0) {
                if (!isdefined(level.animation_played)) {
                    level.animation_played = [];
                    animation_played_name = (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:xa8>" + animation;
                    if (!isdefined(level.animation_played)) {
                        level.animation_played = [];
                    } else if (!isarray(level.animation_played)) {
                        level.animation_played = array(level.animation_played);
                    }
                    level.animation_played[level.animation_played.size] = animation_played_name;
                }
            }
        #/
        current_playing_anim[_n_ent_num] = animation;
        if (is_skipping_scene() && n_rate != 0) {
            thread skip_scene_shot_animations(1);
        }
        on_play_anim(_e);
        var_3bb6221f = function_855eda8d(_e, animation);
        _e animation::play(animation, m_align, m_tag, n_rate, n_blend, n_blend_out, n_lerp, n_time, _s.showweaponinfirstperson, undefined, var_3bb6221f);
        if (!isdefined(_e) || !_e isplayinganimscripted()) {
            current_playing_anim[_n_ent_num] = undefined;
        }
        /#
            if (getdvarint("<dev string:xac>") > 0) {
                if (isdefined(level.animation_played)) {
                    for (i = 0; i < level.animation_played.size; i++) {
                        animation_played_name = (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:xa8>" + animation;
                        if (level.animation_played[i] == animation_played_name) {
                            arrayremovevalue(level.animation_played, animation_played_name);
                            i--;
                        }
                    }
                }
            }
        #/
        /#
            if (getdvarint("<dev string:x39>") > 0) {
                printtoprightln("<dev string:xbd>" + (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:xa8>" + animation);
            }
        #/
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3caf3ea9, Offset: 0x3ae8
    // Size: 0x68
    function update_alignment() {
        m_align = get_align_ent();
        m_tag = get_align_tag();
        if (m_align == level) {
            m_align = (0, 0, 0);
            m_tag = (0, 0, 0);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x5660acd9, Offset: 0x3808
    // Size: 0x2d4
    function play_anim(animation, b_camera_anim) {
        if (!isdefined(b_camera_anim)) {
            b_camera_anim = 0;
        }
        /#
            if (getdvarint("<dev string:x39>") > 0) {
                if (isdefined(_s.name)) {
                    printtoprightln("<dev string:x5d>" + _s.name);
                } else {
                    printtoprightln("<dev string:x5d>" + _s.model);
                }
            }
        #/
        if (_should_skip_anim(animation)) {
            return;
        }
        _str_current_anim = animation;
        animation = animation_lookup(_str_current_anim, undefined, b_camera_anim);
        n_rate = _b_first_frame ? 0 : 1;
        if (n_rate > 0) {
            _o_scene flagsys::wait_till(_str_shot + "go");
        }
        if (is_alive()) {
            update_alignment();
            n_time = 0;
            if (_o_scene.n_start_time !== 0) {
                n_time = [[ _o_scene ]]->get_anim_relative_start_time(animation, _o_scene.n_start_time);
            }
            if (b_camera_anim) {
                self thread play_camera(_str_current_anim);
            } else if (_b_first_frame || isanimlooping(animation)) {
                thread _play_anim(animation, n_rate, _n_blend, n_time);
                _b_first_frame = 0;
                _b_active_anim = 1;
            } else {
                _play_anim(animation, n_rate, _n_blend, n_time);
                _b_active_anim = 0;
                _dynamic_paths();
            }
            _blend = 0;
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 3, eflags: 0x0
    // Checksum 0xb9d2b3ab, Offset: 0x37c8
    // Size: 0x38
    function animation_lookup(animation, ent, b_camera) {
        if (!isdefined(ent)) {
            ent = _e;
        }
        return animation;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf3828c87, Offset: 0x3708
    // Size: 0xb8
    function set_objective() {
        if (!isdefined(_e.script_objective)) {
            if (isdefined(_o_scene._e_root.script_objective)) {
                _e.script_objective = _o_scene._e_root.script_objective;
                return;
            }
            if (isdefined(_o_scene._s.script_objective)) {
                _e.script_objective = _o_scene._s.script_objective;
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa398286f, Offset: 0x3680
    // Size: 0x7c
    function restore_saved_ent() {
        if (isdefined(_o_scene._e_root.scene_ents)) {
            if (isdefined(_o_scene._e_root.scene_ents[_str_name])) {
                _e = _o_scene._e_root.scene_ents[_str_name];
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xadcde2ee, Offset: 0x3660
    // Size: 0x16
    function get_orig_name() {
        return _s.name;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa3921721, Offset: 0x35e0
    // Size: 0x78
    function _assign_unique_name() {
        if (isdefined(_s.name)) {
            _str_name = _s.name;
            return;
        }
        _str_name = _o_scene._str_name + "_noname" + [[ _o_scene ]]->get_object_id();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3bd0e73e, Offset: 0x3228
    // Size: 0x3b0
    function function_6bfe1ac1() {
        self endon(#"new_shot");
        self endon(_str_shot + "active");
        str_damage_types = (!isdefined(_s.runsceneondmg0) || _s.runsceneondmg0 == "none" ? "" : _s.runsceneondmg0) + (!isdefined(_s.runsceneondmg1) || _s.runsceneondmg1 == "none" ? "" : _s.runsceneondmg1) + (!isdefined(_s.runsceneondmg2) || _s.runsceneondmg2 == "none" ? "" : _s.runsceneondmg2) + (!isdefined(_s.runsceneondmg3) || _s.runsceneondmg3 == "none" ? "" : _s.runsceneondmg3) + (!isdefined(_s.runsceneondmg4) || _s.runsceneondmg4 == "none" ? "" : _s.runsceneondmg4);
        if (str_damage_types != "") {
            var_81c6c482 = 0;
            flagsys::set("waitting_for_damage");
            while (!var_81c6c482) {
                waitresult = _e waittill("damage");
                str_mod = waitresult.mod;
                switch (str_mod) {
                case #"mod_pistol_bullet":
                case #"mod_rifle_bullet":
                    if (issubstr(str_damage_types, "bullet")) {
                        var_81c6c482 = 1;
                    }
                    break;
                case #"mod_explosive":
                case #"mod_grenade":
                case #"mod_grenade_splash":
                    if (issubstr(str_damage_types, "explosive")) {
                        var_81c6c482 = 1;
                    }
                    break;
                case #"mod_projectile":
                case #"mod_projectile_splash":
                    if (issubstr(str_damage_types, "projectile")) {
                        var_81c6c482 = 1;
                    }
                    break;
                case #"mod_melee":
                    if (issubstr(str_damage_types, "melee")) {
                        var_81c6c482 = 1;
                    }
                    break;
                default:
                    if (issubstr(str_damage_types, "all")) {
                        var_81c6c482 = 1;
                    }
                    break;
                }
            }
            thread [[ _o_scene ]]->play();
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe8ab0234, Offset: 0x31a0
    // Size: 0x7c
    function get_align_tag() {
        if (isdefined(_s.aligntargettag)) {
            return _s.aligntargettag;
        }
        if (isdefined(_o_scene._e_root.e_scene_link)) {
            return "tag_origin";
        }
        return _o_scene._s.aligntargettag;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8e4b6865, Offset: 0x2fc0
    // Size: 0x1d4
    function get_align_ent() {
        e_align = undefined;
        if (isdefined(_s.aligntarget) && !(_s.aligntarget === _o_scene._s.aligntarget)) {
            a_scene_ents = [[ _o_scene ]]->get_ents();
            if (isdefined(a_scene_ents[_s.aligntarget])) {
                e_align = a_scene_ents[_s.aligntarget];
            } else {
                e_align = scene::get_existing_ent(_s.aligntarget, 0, 1);
            }
            if (!isdefined(e_align)) {
                str_msg = "Align target '" + (isdefined(_s.aligntarget) ? "" + _s.aligntarget : "") + "' doesn't exist for scene object.";
                if (!warning(_o_scene._b_testing, str_msg)) {
                    error(getdvarint("scene_align_errors", 1), str_msg);
                }
            }
        }
        if (!isdefined(e_align)) {
            e_align = [[ _o_scene ]]->get_align_ent();
        }
        return e_align;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x80f724d1, Offset: 0x2fb0
    // Size: 0x4
    function _cleanup() {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x36d7c472, Offset: 0x2d58
    // Size: 0x24c
    function cleanup() {
        /#
            if (getdvarint("<dev string:x39>") > 0) {
                printtoprightln("<dev string:x45>" + (isdefined(_s.name) ? _s.name : _s.model));
            }
        #/
        if (isdefined(_e) && flagsys::get(_str_shot + "active")) {
            b_finished = flagsys::get(_str_shot + "finished");
            b_stopped = flagsys::get(_str_shot + "stopped");
            if (!isplayer(_e)) {
                _e sethighdetail(0);
                if (isdefined(_s.deletewhenfinished) && _s.deletewhenfinished) {
                    _e thread scene::synced_delete();
                }
            }
            _cleanup();
            _e._scene_object = undefined;
            _e.current_scene = undefined;
            _e.anim_debug_name = undefined;
            _e flagsys::clear("scene");
            if (is_alive()) {
                _reset_values();
            }
        }
        flagsys::clear(_str_shot + "active");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x15cff564, Offset: 0x2ce8
    // Size: 0x64
    function _stop(b_dont_clear_anim) {
        if (!isdefined(b_dont_clear_anim)) {
            b_dont_clear_anim = 0;
        }
        if (isalive(_e)) {
            if (!b_dont_clear_anim) {
                _e stopanimscripted(0.2);
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x95a26593, Offset: 0x2c08
    // Size: 0xd4
    function stop(b_clear, b_dont_clear_anim) {
        if (!isdefined(b_clear)) {
            b_clear = 0;
        }
        if (!isdefined(b_dont_clear_anim)) {
            b_dont_clear_anim = 0;
        }
        self notify(#"new_shot");
        if (isdefined(_str_shot)) {
            flagsys::set(_str_shot + "stopped");
            if (b_clear) {
                if (isdefined(_e)) {
                    _e delete();
                }
            } else {
                _stop(b_dont_clear_anim);
            }
            cleanup();
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x707da421, Offset: 0x2a10
    // Size: 0x1ec
    function reach(str_animation, str_shot) {
        if (!isdefined(str_shot)) {
            str_shot = "play";
        }
        if (!isactor(_e) && !_e isbot() || !isdefined(str_animation)) {
            return;
        }
        b_do_reach = !(isdefined(_o_scene._b_testing) && _o_scene._b_testing) || isdefined(_s.doreach) && _s.doreach && getdvarint("scene_test_with_reach", 0);
        if (b_do_reach) {
            _e show();
            if (isdefined(_s.disablearrivalinreach) && _s.disablearrivalinreach) {
                _e animation::reach(str_animation, get_align_ent(), get_align_tag(), 1);
            } else {
                _e animation::reach(str_animation, get_align_ent(), get_align_tag());
            }
        }
        flagsys::set(str_shot + "ready");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa9a0e9de, Offset: 0x2828
    // Size: 0x1da
    function function_feec5246(str_command) {
        switch (str_command) {
        case #"delete":
            _e delete();
            break;
        case #"hide":
            _e hide();
            break;
        case #"ghost":
            _e ghost();
            break;
        case #"show":
            _e show();
            break;
        case #"hash_c82037b3":
            break;
        case #"hash_daab236a":
            break;
        case #"hash_c4beeee6":
            _b_first_frame = 1;
            break;
        case #"hash_120e4a3a":
            break;
        case #"hash_2ea61692":
            break;
        case #"hash_8c343903":
            break;
        case #"hash_c49b568b":
            break;
        case #"hash_267e687f":
            break;
        case #"hash_1593fdad":
            break;
        case #"hash_63a6a7b3":
            _e disconnectpaths(2, 0);
            break;
        case #"hash_fa5fd489":
            _e connectpaths();
            break;
        case #"hash_6b6e25ad":
            var_2b1650fa = undefined;
            break;
        default:
            error(1, "Unkown command '" + str_command + "'.");
            break;
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf1351afc, Offset: 0x27c0
    // Size: 0x5c
    function run_wait(wait_time) {
        wait_start_time = 0;
        while (wait_start_time < wait_time && !is_skipping_scene()) {
            wait_start_time += 0.05;
            waitframe(1);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1c6ffbee, Offset: 0x2718
    // Size: 0x9c
    function _dynamic_paths() {
        if (isdefined(_s.dynamicpaths) && isdefined(_e) && _s.dynamicpaths) {
            if (distance2dsquared(_e.origin, _e.scene_orig_origin) > 4) {
                _e disconnectpaths(2, 0);
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x18130693, Offset: 0x2048
    // Size: 0x6c4
    function play(str_shot) {
        if (!isdefined(str_shot)) {
            str_shot = "play";
        }
        n_shot = get_shot(str_shot);
        if (!isdefined(n_shot) && !has_streamer_hint()) {
            flagsys::set(str_shot + "ready");
            flagsys::set(str_shot + "finished");
            return;
        }
        self notify(#"new_shot");
        self endon(#"new_shot");
        if (isdefined(_str_shot)) {
            cleanup();
        }
        _str_shot = str_shot;
        flagsys::clear(_str_shot + "stopped");
        flagsys::clear(_str_shot + "finished");
        flagsys::clear(_str_shot + "ready");
        flagsys::set(_str_shot + "active");
        spawn();
        function_b906b878();
        for (n_entry = 1; n_entry <= 32; n_entry++) {
            if (!is_alive()) {
                continue;
            }
            str_entry_type = "";
            foreach (str_entry_type in array("anim", "animation", "blend", "spacermin", "spacermax", "cameraswitcher", "command")) {
                entry = get_entry(n_shot, n_entry, str_entry_type);
                if (isdefined(entry)) {
                    break;
                }
            }
            if (isdefined(entry)) {
                switch (str_entry_type) {
                case #"cameraswitcher":
                    play_anim(entry, 1);
                    break;
                case #"anim":
                case #"animation":
                    play_anim(entry);
                    break;
                case #"deathanim":
                    var_2b1650fa = entry;
                    break;
                case #"blend":
                    _n_blend = entry;
                    break;
                case #"spacermin":
                    if (!is_skipping_scene()) {
                        n_spacer_max = _s.("shot" + n_shot + "_entry" + n_entry + "_spacermax");
                        if (!isdefined(n_spacer_max) || n_spacer_max == entry) {
                            run_wait(entry);
                        } else if (!error(n_spacer_max < entry, "ERROR")) {
                            run_wait(randomfloatrange(entry, n_spacer_max));
                        }
                    }
                    break;
                case #"spacermax":
                    if (!is_skipping_scene()) {
                        n_spacer_min = _s.("shot" + n_shot + "_entry" + n_entry + "_spacermin");
                        if (!isdefined(n_spacer_min) || n_spacer_min == entry) {
                            run_wait(entry);
                        } else if (!error(n_spacer_min > entry, "ERROR")) {
                            run_wait(randomfloatrange(n_spacer_min, entry));
                        }
                    }
                    break;
                case #"command":
                    function_feec5246(entry);
                    break;
                default:
                    error(1, "Bad timeline entry type '" + str_entry_type + "'.");
                    break;
                }
            }
        }
        flagsys::wait_till_clear("camera_playing");
        flagsys::wait_till_clear("waitting_for_damage");
        if (is_alive()) {
            flagsys::set(_str_shot + "finished");
            if (isdefined(_s.diewhenfinished) && _s.diewhenfinished && _str_shot == "play") {
                kill_ent();
            }
        } else {
            flagsys::set(_str_shot + "stopped");
        }
        if (!_b_active_anim) {
            cleanup();
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 3, eflags: 0x0
    // Checksum 0xe287d09a, Offset: 0x1f20
    // Size: 0x11c
    function get_entry(n_shot, n_entry, str_entry_type) {
        if (isarray(_s.shots) && isdefined(_s.shots[n_shot]) && isdefined(_s.shots[n_shot].entry[n_entry - 1])) {
            entry = _s.shots[n_shot].entry[n_entry - 1].(str_entry_type);
        } else {
            entry = _s.("shot" + n_shot + "_entry" + n_entry + "_" + str_entry_type);
        }
        return entry;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2081dc85, Offset: 0x1ec0
    // Size: 0x56
    function has_streamer_hint() {
        if (is_player()) {
            if (isdefined(_o_scene.var_52537cf6)) {
                if (isdefined(_o_scene.var_52537cf6[_str_team])) {
                    return true;
                }
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xeada3996, Offset: 0x1e90
    // Size: 0x28
    function function_b906b878() {
        var_2b1650fa = undefined;
        _b_first_frame = 0;
        _n_blend = 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x9e2c5d1d, Offset: 0x1cd8
    // Size: 0x1ae
    function get_shot(str_shot) {
        if (isarray(_s.shots)) {
            foreach (n_shot, s_shot in _s.shots) {
                foreach (s_entry in s_shot.entry) {
                    if (str_shot == "play") {
                        return n_shot;
                    }
                }
            }
        }
        for (n_shot = 1; n_shot <= 32; n_shot++) {
            str_shot_name = _s.("shot" + n_shot + "_name");
            if (isdefined(str_shot_name)) {
                if (str_shot_name === str_shot) {
                    return n_shot;
                }
                continue;
            }
            break;
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe3f998b5, Offset: 0x1ad0
    // Size: 0x1fc
    function get_animation_name(_str_shot) {
        n_shot = get_shot(_str_shot);
        if (isarray(_s.shots)) {
            foreach (n_entry, s_entry in _s.shots[n_shot].entry) {
                if (isdefined(s_entry.animation)) {
                    str_animation = animation_lookup(s_entry.animation, undefined, 0);
                    return str_animation;
                }
                if (isdefined(s_entry.("anim"))) {
                    str_animation = animation_lookup(s_entry.("anim"), undefined, 0);
                    return str_animation;
                }
            }
        }
        for (n_entry = 1; n_entry <= 32; n_entry++) {
            var_b7b64218 = _s.("shot" + n_shot + "_entry" + n_entry + "_animation");
            if (isdefined(var_b7b64218)) {
                str_animation = animation_lookup(var_b7b64218, undefined, 0);
                return str_animation;
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x80f724d1, Offset: 0x1ac0
    // Size: 0x4
    function _prepare() {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xaa9462a9, Offset: 0x1440
    // Size: 0x678
    function prepare() {
        _e endon(#"death");
        if (isdefined(_e._scene_object) && _e._scene_object != self) {
            [[ _e._scene_object ]]->cleanup();
        }
        if (!is_alive()) {
            return;
        }
        _n_ent_num = _e getentitynumber();
        if (_e.health < 1) {
            _e.health = 1;
        }
        /#
            log(_str_shot);
        #/
        _e._scene_object = self;
        if (isdefined(_s.dynamicpaths) && _s.dynamicpaths && _str_shot == "play") {
            _e.scene_orig_origin = _e.origin;
            _e connectpaths();
        }
        if (!isai(_e) && !isplayer(_e)) {
            if (!is_player()) {
                if (is_player_model()) {
                    scene::prepare_player_model_anim(_e);
                } else {
                    scene::prepare_generic_model_anim(_e);
                }
            }
        }
        _set_values();
        if (!is_player()) {
            if (issentient(_e)) {
                if (isdefined(_s.overrideaicharacter) && _s.overrideaicharacter) {
                    _e detachall();
                    _e setmodel(_s.model);
                }
            } else if (_s.type === "actor") {
                _e makefakeai();
                if (!(isdefined(_s.removeweapon) && _s.removeweapon)) {
                    _e animation::attach_weapon(getweapon("ar_standard"));
                }
            }
            set_objective();
            if (isdefined(_s.dynamicpaths) && _s.dynamicpaths) {
                _e disconnectpaths(2, 0);
            }
        }
        _e.anim_debug_name = _s.name;
        _e.current_scene = _o_scene._str_name;
        _e flagsys::set("scene");
        if (_e.classname == "script_model") {
            if (isdefined(_o_scene._e_root.modelscale)) {
                _e setscale(_o_scene._e_root.modelscale);
            }
        }
        [[ _o_scene ]]->function_a2014270(self, _e);
        flagsys::clear("waitting_for_damage");
        if (isdefined(_e.takedamage) && _e.takedamage) {
            if (_str_shot == "init") {
                thread function_6bfe1ac1();
            }
        }
        if (isdefined(_o_scene._s.igc) && _o_scene._s.igc || [[ _o_scene ]]->has_player()) {
            if (!isplayer(_e)) {
                _e sethighdetail(1);
            }
        }
        _prepare();
        str_animation = get_animation_name(_str_shot);
        reach(str_animation, _str_shot);
        flagsys::set(_str_shot + "ready");
        flagsys::clear(_str_shot + "finished");
        return 1;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7fe7ddca, Offset: 0x1288
    // Size: 0x1b0
    function _spawn() {
        restore_saved_ent();
        if (!isdefined(_e)) {
            if (isdefined(_s.name)) {
                _e = scene::get_existing_ent(_s.name);
            }
        }
        if (isdefined(_e)) {
            if (isdefined(_e.isdying) && _e.isdying) {
                _e delete();
            }
        }
        if (isdefined(_o_scene._b_testing) && (!(isdefined(_s.nospawn) && _s.nospawn) || !isdefined(_e) && _o_scene._b_testing) || isspawner(_e)) {
            spawn_ent();
            if (isdefined(_e)) {
                _e dontinterpolate();
                _e.scene_spawned = _o_scene._s.name;
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6a6f564, Offset: 0x10d8
    // Size: 0x1a4
    function spawn() {
        self endon(#"new_shot");
        b_skip = _s.type === "actor" && issubstr(_o_scene._str_mode, "noai");
        b_skip = _s.type === "player" && (b_skip || issubstr(_o_scene._str_mode, "noplayers"));
        if (!b_skip) {
            _spawn();
            error(!isdefined(_e) || !(isdefined(_s.nospawn) && _s.nospawn) && isspawner(_e), "Object failed to spawn or doesn't exist.");
            [[ _o_scene ]]->assign_ent(self, _e);
            if (isdefined(_e)) {
                prepare();
            }
            return;
        }
        cleanup();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x3386ae0a, Offset: 0xf68
    // Size: 0x164
    function first_init(s_objdef, o_scene) {
        _s = s_objdef;
        _o_scene = o_scene;
        _assign_unique_name();
        if (isdefined(_s.team)) {
            _str_team = util::get_team_mapping(_s.team);
            s_scenedef = scene::get_scenedef(_o_scene._str_name);
            if (isdefined(s_scenedef.var_51bc3a4) && !isdefined(_o_scene.var_51bc3a4)) {
                _o_scene.var_51bc3a4 = s_scenedef.var_51bc3a4;
                s_scenedef.var_51bc3a4 = undefined;
            }
            if (isdefined(s_scenedef.var_c8269f35) && !isdefined(_o_scene.var_c8269f35)) {
                _o_scene.var_c8269f35 = s_scenedef.var_c8269f35;
                s_scenedef.var_c8269f35 = undefined;
            }
        }
        return self;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd8dc5397, Offset: 0xeb8
    // Size: 0xa4
    function _reset_values(ent) {
        if (!isdefined(ent)) {
            ent = _e;
        }
        reset_ent_val("takedamage", ent);
        reset_ent_val("ignoreme", ent);
        reset_ent_val("allowdeath", ent);
        reset_ent_val("take_weapons", ent);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa380627, Offset: 0xd08
    // Size: 0x1a4
    function _set_values(ent) {
        if (!isdefined(ent)) {
            ent = _e;
        }
        set_ent_val("takedamage", isdefined(_s.takedamage) && _s.takedamage, ent);
        if (isplayer(ent)) {
            set_ent_val("ignoreme", !(isdefined(_s.takedamage) && _s.takedamage), ent);
        } else {
            set_ent_val("ignoreme", !(isdefined(_s.attackme) && _s.attackme), ent);
        }
        set_ent_val("allowdeath", isdefined(_s.allowdeath) && _s.allowdeath, ent);
        set_ent_val("take_weapons", isdefined(_s.removeweapon) && _s.removeweapon, ent);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x1cc76461, Offset: 0xc80
    // Size: 0x7c
    function reset_ent_val(str_key, ent) {
        if (!isdefined(ent)) {
            ent = _e;
        }
        if (isdefined(ent)) {
            ent val::reset(_o_scene._str_name + ":" + _str_shot, str_key);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 3, eflags: 0x0
    // Checksum 0xfb0721ba, Offset: 0xbf0
    // Size: 0x84
    function set_ent_val(str_key, value, ent) {
        if (!isdefined(ent)) {
            ent = _e;
        }
        if (isdefined(ent)) {
            ent val::set(_o_scene._str_name + ":" + _str_shot, str_key, value);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xec5bc0a1, Offset: 0xbc0
    // Size: 0x24
    function __destructor() {
        /#
            log("<dev string:x28>");
        #/
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xff913a5d, Offset: 0xb80
    // Size: 0x38
    function __constructor() {
        _b_set_goal = 1;
        _b_first_frame = 0;
        _b_active_anim = 0;
        _n_blend = 0;
    }

}

// Namespace scene
// Method(s) 64 Total 64
class cscene {

    var _a_active_shots;
    var _a_objects;
    var _a_request_times;
    var _a_streamer_hint;
    var _b_stopped;
    var _b_testing;
    var _e_root;
    var _n_object_id;
    var _s;
    var _str_mode;
    var _str_name;
    var _str_notify_name;
    var b_player_scene;
    var camera_start_time;
    var camera_v_angles;
    var camera_v_origin;
    var n_start_time;
    var played_camera_anims;
    var scene_stopping;
    var skipping_scene;
    var var_24424892;

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xdf9206e5, Offset: 0xcf58
    // Size: 0x64
    function warning(condition, str_msg) {
        if (condition) {
            if (_b_testing) {
                level scene::warning_on_screen("[ " + _str_name + " ]: " + str_msg);
            }
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x83f0cb04, Offset: 0xcea0
    // Size: 0xac
    function error(condition, str_msg) {
        if (condition) {
            if (_b_testing) {
                scene::error_on_screen(str_msg);
            } else {
                /#
                    assertmsg(_s.type + "<dev string:x134>" + _str_name + "<dev string:x396>" + str_msg);
                #/
            }
            thread on_error();
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2a4b116f, Offset: 0xce40
    // Size: 0x54
    function log(str_msg) {
        /#
            println(_s.type + "<dev string:x134>" + _str_name + "<dev string:x396>" + str_msg);
        #/
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb29c1987, Offset: 0xce08
    // Size: 0x2c
    function remove_object(o_object) {
        arrayremovevalue(_a_objects, o_object);
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xeb873c08, Offset: 0xcd70
    // Size: 0x8a
    function add_object(o_object) {
        if (!isdefined(_a_objects)) {
            _a_objects = [];
        } else if (!isarray(_a_objects)) {
            _a_objects = array(_a_objects);
        }
        _a_objects[_a_objects.size] = o_object;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x13c8f126, Offset: 0xccc0
    // Size: 0xa2
    function has_player() {
        foreach (obj in _a_objects) {
            if (obj._s.type === "player") {
                return true;
            }
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x7d0eb922, Offset: 0xcbc8
    // Size: 0xec
    function function_a2014270(var_ac574b2f, entity) {
        if (self === var_ac574b2f) {
            if (!is_skipping_scene()) {
                function_e74f18c9(1);
            }
            return;
        }
        if (isplayer(entity)) {
            if (!(isdefined(_s.disablesceneskipping) && _s.disablesceneskipping) && !is_skipping_scene()) {
                if ([[ var_ac574b2f ]]->is_shared_player() || _s scene::is_igc()) {
                    function_e74f18c9(1);
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xca7051df, Offset: 0xc750
    // Size: 0x470
    function function_e74f18c9(b_started) {
        if (isdefined(b_started) && b_started) {
            scene::function_f69c7a83();
            if (isdefined(level.var_a1d36213)) {
                return;
            }
            level.var_d2c98f2 = [];
            if (!isdefined(level.var_d2c98f2)) {
                level.var_d2c98f2 = [];
            } else if (!isarray(level.var_d2c98f2)) {
                level.var_d2c98f2 = array(level.var_d2c98f2);
            }
            level.var_d2c98f2[level.var_d2c98f2.size] = _s.name;
            _s.var_ab895d81 = 1;
            if (isdefined(_s.s_female_bundle)) {
                if (!isdefined(level.var_d2c98f2)) {
                    level.var_d2c98f2 = [];
                } else if (!isarray(level.var_d2c98f2)) {
                    level.var_d2c98f2 = array(level.var_d2c98f2);
                }
                level.var_d2c98f2[level.var_d2c98f2.size] = _s.s_female_bundle.name;
            }
            if (isstring(_s.nextscenebundle)) {
                var_701c98e6 = scene::get_scenedef(_s.nextscenebundle);
                while (true) {
                    if (!isdefined(level.var_d2c98f2)) {
                        level.var_d2c98f2 = [];
                    } else if (!isarray(level.var_d2c98f2)) {
                        level.var_d2c98f2 = array(level.var_d2c98f2);
                    }
                    level.var_d2c98f2[level.var_d2c98f2.size] = var_701c98e6.name;
                    if (isdefined(var_701c98e6.s_female_bundle)) {
                        if (!isdefined(level.var_d2c98f2)) {
                            level.var_d2c98f2 = [];
                        } else if (!isarray(level.var_d2c98f2)) {
                            level.var_d2c98f2 = array(level.var_d2c98f2);
                        }
                        level.var_d2c98f2[level.var_d2c98f2.size] = var_701c98e6.s_female_bundle.name;
                    }
                    if (isstring(var_701c98e6.nextscenebundle)) {
                        var_701c98e6 = scene::get_scenedef(var_701c98e6.nextscenebundle);
                        continue;
                    }
                    break;
                }
            }
            level.var_a1d36213 = 1;
            function_c54dbcf9();
            level notify(#"hash_1c353a4f");
            return;
        }
        if (!isdefined(level.var_a1d36213)) {
            return;
        }
        if (function_e308028()) {
            level.var_d2c98f2 = [];
            level.var_a1d36213 = undefined;
            function_c54dbcf9();
            level notify(#"hash_14c06c0c", {#scene:_s.name});
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7a4ee175, Offset: 0xc700
    // Size: 0x42
    function function_c54dbcf9() {
        if (function_e308028()) {
            level.var_e0ec1056 = _s.name;
            return;
        }
        level.var_e0ec1056 = undefined;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3937d92c, Offset: 0xc6b0
    // Size: 0x42
    function function_e308028() {
        return isdefined(level.var_a1d36213) && array::contains(level.var_d2c98f2, _s.name);
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x49184a28, Offset: 0xc628
    // Size: 0x7e
    function function_58e414c3() {
        if (isdefined(level.var_cd66d9d1) && !(isdefined(_s.disablesceneskipping) && _s.disablesceneskipping) && array::contains(level.var_109c74a6, _s.name)) {
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3d3bf5d4, Offset: 0xc568
    // Size: 0xb6
    function _skip_scene() {
        self endon(#"stopped");
        if (isdefined(_a_objects)) {
            foreach (o_scene_object in _a_objects) {
                [[ o_scene_object ]]->skip_scene(1);
            }
        }
        self notify(#"skip_camera_anims");
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc08354d4, Offset: 0xc300
    // Size: 0x25c
    function finish_scene_skipping() {
        /#
            if (getdvarint("<dev string:xac>") > 0) {
                printtoprightln("<dev string:x376>" + gettime(), (1, 0, 0));
            }
        #/
        if (isdefined(level.var_cd66d9d1)) {
            foreach (player in level.players) {
                player clientfield::increment_to_player("player_scene_skip_completed");
                player val::reset("scene_skip", "freezecontrols");
                player stopsounds();
            }
            b_player_scene = undefined;
            skipping_scene = undefined;
            level.var_cd66d9d1 = undefined;
            level.var_109c74a6 = undefined;
            function_e74f18c9(0);
            level notify(#"hash_e14d7c6c");
            /#
                if (getdvarint("<dev string:xac>") > 0) {
                    printtoprightln("<dev string:x2bd>" + gettime());
                }
            #/
            /#
                if (getdvarint("<dev string:x2df>") == 0) {
                    b_skip_fading = 0;
                } else {
                    b_skip_fading = 1;
                }
            #/
            if (!(isdefined(b_skip_fading) && b_skip_fading)) {
                if (!(isdefined(level.level_ending) && level.level_ending)) {
                    level thread lui::screen_fade(1, 0, 1, "black", 0, "scene_system");
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4f4f9d32, Offset: 0xbb18
    // Size: 0x7da
    function skip_scene(var_55a89816) {
        if (isdefined(_s.disablesceneskipping) && isdefined(var_55a89816) && var_55a89816 && _s.disablesceneskipping) {
            /#
                if (getdvarint("<dev string:xac>") > 0) {
                    printtoprightln("<dev string:x276>" + _s.name + "<dev string:xa8>" + gettime(), (1, 0, 0));
                }
            #/
            finish_scene_skipping();
            return;
        }
        /#
            if (getdvarint("<dev string:xac>") > 0) {
                printtoprightln("<dev string:x2a8>" + _s.name + "<dev string:xa8>" + gettime(), (0, 1, 0));
            }
        #/
        str_shot = _a_active_shots[0];
        if (!(isdefined(var_55a89816) && var_55a89816)) {
            if (is_skipping_player_scene()) {
                /#
                    if (getdvarint("<dev string:xac>") > 0) {
                        printtoprightln("<dev string:x2bd>" + gettime());
                    }
                #/
                /#
                    if (getdvarint("<dev string:x2df>") == 0) {
                        b_skip_fading = 0;
                    } else {
                        b_skip_fading = 1;
                    }
                #/
                if (!(isdefined(b_skip_fading) && b_skip_fading)) {
                    foreach (player in level.players) {
                        player val::set("scene_skip", "freezecontrols", 1);
                    }
                    level.var_840fdf22 = 1;
                    level thread lui::screen_fade(1, 1, 0, "black", 0, "scene_system");
                    wait 1;
                    level.var_840fdf22 = undefined;
                }
                setpauseworld(0);
            }
            while (isdefined(level.var_840fdf22) && level.var_840fdf22) {
                waitframe(1);
            }
        }
        if (isdefined(_s.nextscenebundle)) {
            var_eb2cccdb = 1;
        } else {
            var_eb2cccdb = 0;
        }
        while (!isdefined(str_shot)) {
            str_shot = _a_active_shots[0];
            waitframe(1);
        }
        while (isdefined(str_shot) && flagsys::get(str_shot + "active") && !flagsys::get(str_shot + "go")) {
            waitframe(1);
        }
        /#
            if (getdvarint("<dev string:xac>") > 0) {
                printtoprightln("<dev string:x2f2>" + _s.name + "<dev string:xa8>" + gettime(), (0, 0, 1));
            }
        #/
        _call_shot_funcs("skip_started");
        thread _skip_scene();
        /#
            if (getdvarint("<dev string:xac>") > 0) {
                printtoprightln("<dev string:x30f>" + gettime(), (0, 1, 0));
            }
        #/
        /#
            if (getdvarint("<dev string:xac>") > 0) {
                if (isdefined(level.animation_played)) {
                    for (i = 0; i < level.animation_played.size; i++) {
                        printtoprightln("<dev string:x341>" + level.animation_played[i], (1, 0, 0), -1);
                    }
                }
            }
        #/
        var_aa786a73 = gettime() + 4000;
        while (isdefined(str_shot) && flagsys::get(str_shot + "play")) {
            if (gettime() >= var_aa786a73) {
                break;
            }
            waitframe(1);
        }
        /#
            if (getdvarint("<dev string:xac>") > 0) {
                printtoprightln("<dev string:x35b>" + _s.name + "<dev string:xa8>" + gettime(), (1, 0.5, 0));
            }
        #/
        _call_shot_funcs("skip_completed");
        self flagsys::set("scene_skip_completed");
        if (!var_eb2cccdb) {
            if (is_skipping_player_scene()) {
                if (isdefined(level.var_109c74a6)) {
                    var_84f532ce = gettime() + 4000;
                    while (level.var_109c74a6.size > 0 && gettime() < var_84f532ce) {
                        waitframe(1);
                    }
                }
                finish_scene_skipping();
            } else if (isdefined(skipping_scene) && skipping_scene) {
                skipping_scene = undefined;
                if (isdefined(level.var_109c74a6)) {
                    arrayremovevalue(level.var_109c74a6, _s.name);
                }
            }
            return;
        }
        if (is_skipping_player_scene()) {
            if (_s scene::is_igc()) {
                foreach (player in level.players) {
                    player stopsounds();
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xfa4e5df4, Offset: 0xba00
    // Size: 0x110
    function is_scene_shared() {
        if (!(isdefined(_s.skip_scene) && _s.skip_scene) && !_s scene::is_igc()) {
            foreach (o_scene_object in _a_objects) {
                if ([[ o_scene_object ]]->is_alive() && [[ o_scene_object ]]->is_shared_player()) {
                    var_ce0c77d5 = 1;
                }
            }
            if (!isdefined(var_ce0c77d5)) {
                return false;
            }
        }
        return true;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2ae0fffd, Offset: 0xb9e0
    // Size: 0x14
    function on_error() {
        stop();
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd7f39f55, Offset: 0xb8d8
    // Size: 0xfc
    function get_valid_objects() {
        a_obj = [];
        foreach (obj in _a_objects) {
            if ([[ obj ]]->is_alive()) {
                if (!isdefined(a_obj)) {
                    a_obj = [];
                } else if (!isarray(a_obj)) {
                    a_obj = array(a_obj);
                }
                a_obj[a_obj.size] = obj;
            }
        }
        return a_obj;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd597f404, Offset: 0xb710
    // Size: 0x1c0
    function sync_with_other_scenes(str_shot) {
        if (!(isdefined(_s.dontsync) && _s.dontsync)) {
            n_request_time = get_request_time(str_shot);
            if (isdefined(level.scene_sync_list) && isarray(level.scene_sync_list[n_request_time])) {
                a_scene_requests = level.scene_sync_list[n_request_time];
                for (i = 0; i < a_scene_requests.size; i++) {
                    a_scene_request = a_scene_requests[i];
                    o_scene = a_scene_request.o_scene;
                    str_flag = a_scene_request.str_shot + "ready";
                    if (isdefined(a_scene_request) && !(isdefined(o_scene._s.dontsync) && o_scene._s.dontsync) && !o_scene flagsys::get(str_flag)) {
                        o_scene flagsys::wait_till(str_flag);
                        i = -1;
                    }
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x6ab3d15f, Offset: 0xb620
    // Size: 0xe8
    function wait_till_objects_finished(str_shot, &array) {
        for (i = 0; i < array.size; i++) {
            obj = array[i];
            if (isdefined(obj) && !obj flagsys::get(str_shot + "finished") && obj flagsys::get(str_shot + "active")) {
                obj util::waittill_either(str_shot + "finished", str_shot + "active");
                i = -1;
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4d082b74, Offset: 0xb5e8
    // Size: 0x2c
    function wait_till_shot_finished(str_shot) {
        wait_till_objects_finished(str_shot, _a_objects);
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x9b72c04f, Offset: 0xb4f8
    // Size: 0xe8
    function wait_till_objects_ready(str_shot, &array) {
        for (i = 0; i < array.size; i++) {
            obj = array[i];
            if (isdefined(obj) && !obj flagsys::get(str_shot + "ready") && obj flagsys::get(str_shot + "active")) {
                obj util::waittill_either(str_shot + "ready", str_shot + "active");
                i = -1;
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x6f9602b7, Offset: 0xb388
    // Size: 0x164
    function wait_till_shot_ready(str_shot, o_exclude) {
        a_objects = [];
        if (isdefined(o_exclude)) {
            a_objects = array::exclude(_a_objects, o_exclude);
        } else {
            a_objects = _a_objects;
        }
        if (isdefined(_s.igc) && _s.igc) {
            level flagsys::increment("waitting_for_igc_ready");
        }
        wait_till_objects_ready(str_shot, a_objects);
        flagsys::set(str_shot + "ready");
        sync_with_other_scenes(str_shot);
        flagsys::set(str_shot + "go");
        if (isdefined(_s.igc) && _s.igc) {
            level flagsys::decrement("waitting_for_igc_ready");
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa7780003, Offset: 0xb350
    // Size: 0x2e
    function is_looping() {
        return isdefined(_s.looping) && _s.looping;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1d3b4fed, Offset: 0xb1d8
    // Size: 0x16c
    function get_align_ent() {
        e_align = _e_root;
        if (isdefined(_s.aligntarget)) {
            e_gdt_align = scene::get_existing_ent(_s.aligntarget, 0, 1);
            if (isdefined(e_gdt_align)) {
                e_align = e_gdt_align;
            }
            if (!isdefined(e_gdt_align)) {
                str_msg = "Align target '" + (isdefined(_s.aligntarget) ? "" + _s.aligntarget : "") + "' doesn't exist for scene.";
                if (!warning(_b_testing, str_msg)) {
                    error(getdvarint("scene_align_errors", 1), str_msg);
                }
            }
        } else if (isdefined(_e_root.e_scene_link)) {
            e_align = _e_root.e_scene_link;
        }
        return e_align;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc73dfa5d, Offset: 0xb1c0
    // Size: 0xe
    function get_root() {
        return _e_root;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x601a3bbd, Offset: 0xb070
    // Size: 0x144
    function get_ents() {
        a_ents = [];
        foreach (o_obj in _a_objects) {
            ent = [[ o_obj ]]->get_ent();
            if (isdefined(o_obj._s.name)) {
                a_ents[o_obj._s.name] = ent;
                continue;
            }
            if (!isdefined(a_ents)) {
                a_ents = [];
            } else if (!isarray(a_ents)) {
                a_ents = array(a_ents);
            }
            a_ents[a_ents.size] = ent;
        }
        return a_ents;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x97699c94, Offset: 0xac08
    // Size: 0x460
    function _call_shot_funcs(str_shot, b_waittill_go) {
        if (!isdefined(b_waittill_go)) {
            b_waittill_go = 0;
        }
        self endon(str_shot);
        if (b_waittill_go) {
            flagsys::wait_till(str_shot + "go");
        }
        if (str_shot == "play") {
            _call_shot_funcs("init");
        }
        if (str_shot == "done") {
            level notify(_str_notify_name + "_done");
        }
        level notify(_str_notify_name + "_" + str_shot);
        if (str_shot == "sequence_done") {
            if (isdefined(level.scene_sequence_names[_s.name])) {
                level notify(level.scene_sequence_names[_s.name] + "_sequence_done");
            }
        }
        if (isdefined(level.scene_funcs) && isdefined(level.scene_funcs[_str_notify_name]) && isdefined(level.scene_funcs[_str_notify_name][str_shot])) {
            a_ents = get_ents();
            foreach (handler in level.scene_funcs[_str_notify_name][str_shot]) {
                func = handler[0];
                args = handler[1];
                switch (args.size) {
                case 6:
                    _e_root thread [[ func ]](a_ents, args[0], args[1], args[2], args[3], args[4], args[5]);
                    break;
                case 5:
                    _e_root thread [[ func ]](a_ents, args[0], args[1], args[2], args[3], args[4]);
                    break;
                case 4:
                    _e_root thread [[ func ]](a_ents, args[0], args[1], args[2], args[3]);
                    break;
                case 3:
                    _e_root thread [[ func ]](a_ents, args[0], args[1], args[2]);
                    break;
                case 2:
                    _e_root thread [[ func ]](a_ents, args[0], args[1]);
                    break;
                case 1:
                    _e_root thread [[ func ]](a_ents, args[0]);
                    break;
                case 0:
                    _e_root thread [[ func ]](a_ents);
                    break;
                default:
                    /#
                        assertmsg("<dev string:x252>");
                    #/
                    break;
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x6bc3e614, Offset: 0xa8f8
    // Size: 0x308
    function stop(b_clear, b_finished) {
        if (!isdefined(b_clear)) {
            b_clear = 0;
        }
        if (!isdefined(b_finished)) {
            b_finished = 0;
        }
        if (_b_stopped) {
            return;
        }
        /#
        #/
        /#
            if (strstartswith(_str_mode, "<dev string:x211>")) {
                adddebugcommand("<dev string:x219>");
            }
        #/
        if (!is_skipping_scene()) {
            if (!isdefined(_s.nextscenebundle) && function_e308028()) {
                function_e74f18c9(0);
            }
        }
        self thread sync_with_client_scene("stop", b_clear);
        thread _call_shot_funcs("stop");
        scene_stopping = 1;
        if (isdefined(_a_objects) && !b_finished) {
            foreach (o_obj in _a_objects) {
                if (isdefined(o_obj) && ![[ o_obj ]]->in_a_different_scene()) {
                    thread [[ o_obj ]]->stop(b_clear);
                }
            }
        }
        self thread _stop_camera_anims();
        /#
            if (getdvarint("<dev string:x39>") > 0) {
                printtoprightln("<dev string:x22a>" + _s.name);
            }
            if (!b_finished) {
                level.last_scene_state[_str_name] = level.last_scene_state[_str_name] + "<dev string:x249>";
                _e_root.last_scene_state_instance[_str_name] = _e_root.last_scene_state_instance[_str_name] + "<dev string:x249>";
            }
            if (!isdefined(_e_root.scriptbundlename)) {
                _e_root notify(#"stop_debug_display");
            }
        #/
        _b_stopped = 1;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbc6e8b0e, Offset: 0xa8d0
    // Size: 0x1a
    function has_init_state() {
        return scene::has_init_state(_str_name);
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb8cbfdeb, Offset: 0xa4e8
    // Size: 0x3dc
    function run_next() {
        /#
            if (getdvarint("<dev string:x39>") > 0) {
                printtoprightln("<dev string:x1d9>" + gettime());
            }
        #/
        b_run_next_scene = 0;
        if (isdefined(_s.nextscenebundle)) {
            if (!_b_stopped) {
                b_skip_scene = is_skipping_scene();
                if (b_skip_scene) {
                    var_3b22337e = 0;
                    while (!flagsys::get("scene_skip_completed") || var_3b22337e > 5000) {
                        var_3b22337e += 0.05;
                        waitframe(1);
                    }
                    flagsys::clear("scene_skip_completed");
                    /#
                        if (getdvarint("<dev string:xac>") > 0) {
                            printtoprightln("<dev string:x1ed>" + _s.nextscenebundle + "<dev string:xa8>" + gettime(), (1, 1, 0));
                        }
                    #/
                }
                /#
                    if (getdvarint("<dev string:xac>") > 0) {
                        printtoprightln("<dev string:x1d9>" + _s.nextscenebundle + "<dev string:xa8>" + gettime(), (1, 0, 0));
                    }
                #/
                if (_s.scenetype == "fxanim" && _s.nextscenemode === "init") {
                    if (!error(!has_init_state(), "Scene can't init next scene '" + _s.nextscenebundle + "' because it doesn't have an init state.")) {
                        _e_root thread scene::init(_s.nextscenebundle);
                    }
                } else {
                    if (b_skip_scene) {
                        if (is_skipping_player_scene()) {
                            _str_mode = "skip_scene_player";
                        } else {
                            _str_mode = "skip_scene";
                        }
                    } else {
                        b_run_next_scene = 1;
                    }
                    _e_root thread scene::play(_s.nextscenebundle, undefined, undefined, _b_testing, _str_mode);
                }
            }
        } else {
            _call_shot_funcs("sequence_done");
        }
        if (!(isdefined(b_run_next_scene) && b_run_next_scene)) {
            if (!is_skipping_scene()) {
                if (function_e308028()) {
                    function_e74f18c9(0);
                }
                return;
            }
            if (isdefined(level.var_109c74a6)) {
                arrayremovevalue(level.var_109c74a6, _s.name);
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa3d94dbc, Offset: 0xa4c8
    // Size: 0x18
    function function_cc8737c() {
        return isdefined(_s.nextscenebundle);
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x55a2d6fe, Offset: 0xa458
    // Size: 0x64
    function is_skipping_player_scene() {
        return (isdefined(b_player_scene) && b_player_scene || _str_mode == "skip_scene_player") && !array::contains(level.var_109c74a6, _s.name);
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x74c4b3ee, Offset: 0xa3d0
    // Size: 0x7c
    function is_skipping_scene() {
        return (isdefined(skipping_scene) && skipping_scene || _str_mode == "skip_scene" || _str_mode == "skip_scene_player") && !(isdefined(_s.disablesceneskipping) && _s.disablesceneskipping);
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x72aca11b, Offset: 0xa208
    // Size: 0x1bc
    function _stop_camera_anim_on_player(player) {
        player endon(#"disconnect");
        if (isstring(_s.cameraswitcher)) {
            player endon(#"new_camera_switcher");
            player dontinterpolate();
            endcamanimscripted(player);
            player thread scene::scene_enable_player_stuff(_s, undefined, _e_root);
            callback::remove_on_loadout(&_play_camera_anim_on_player_callback, self);
        }
        if (isstring(_s.extracamswitcher1)) {
            endextracamanimscripted(player, 0);
        }
        if (isstring(_s.extracamswitcher2)) {
            endextracamanimscripted(player, 1);
        }
        if (isstring(_s.extracamswitcher3)) {
            endextracamanimscripted(player, 2);
        }
        if (isstring(_s.extracamswitcher4)) {
            endextracamanimscripted(player, 3);
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbee979d6, Offset: 0xa138
    // Size: 0xc2
    function _stop_camera_anims() {
        if (!(isdefined(played_camera_anims) && played_camera_anims)) {
            return;
        }
        level notify(#"stop_camera_anims");
        foreach (player in getplayers()) {
            self thread _stop_camera_anim_on_player(player);
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 5, eflags: 0x0
    // Checksum 0x4ff17140, Offset: 0xa0c8
    // Size: 0x64
    function function_db4c202(player, n_index, var_907b78ac, v_origin, v_angles) {
        played_camera_anims = 1;
        extracamanimscripted(player, n_index, var_907b78ac, gettime(), v_origin, v_angles);
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc8eca84e, Offset: 0xa070
    // Size: 0x50
    function loop_camera_anim_to_set_up_for_capture() {
        level endon(#"stop_camera_anims");
        while (true) {
            _play_camera_anims();
            _wait_for_camera_animation(_s.cameraswitcher);
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 4, eflags: 0x0
    // Checksum 0xdc6b94f9, Offset: 0x9f30
    // Size: 0x134
    function _play_camera_anim_on_player(player, v_origin, v_angles, ignore_initial_notetracks) {
        player notify(#"new_camera_switcher");
        player dontinterpolate();
        player thread scene::scene_disable_player_stuff(_s);
        played_camera_anims = 1;
        n_start_time = camera_start_time;
        if (!isdefined(_s.cameraswitchergraphiccontents) || ismature(player)) {
            camanimscripted(player, _s.cameraswitcher, n_start_time, v_origin, v_angles);
            return;
        }
        camanimscripted(player, _s.cameraswitchergraphiccontents, n_start_time, v_origin, v_angles);
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd28b149, Offset: 0x9ee8
    // Size: 0x3c
    function _play_camera_anim_on_player_callback(player) {
        self thread _play_camera_anim_on_player(player, camera_v_origin, camera_v_angles, 1);
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5b7c8a6d, Offset: 0x9bf0
    // Size: 0x2ec
    function _play_camera_anims() {
        level endon(#"stop_camera_anims");
        e_align = get_align_ent();
        v_origin = isdefined(e_align.origin) ? e_align.origin : (0, 0, 0);
        v_angles = isdefined(e_align.angles) ? e_align.angles : (0, 0, 0);
        if (isstring(_s.cameraswitcher)) {
            callback::on_loadout(&_play_camera_anim_on_player_callback, self);
            camera_v_origin = v_origin;
            camera_v_angles = v_angles;
            camera_start_time = gettime();
            array::thread_all_ents(level.players, &_play_camera_anim_on_player, v_origin, v_angles, 0);
        }
        if (isstring(_s.extracamswitcher1)) {
            array::thread_all_ents(level.players, &function_db4c202, 0, _s.extracamswitcher1, v_origin, v_angles);
        }
        if (isstring(_s.extracamswitcher2)) {
            array::thread_all_ents(level.players, &function_db4c202, 1, _s.extracamswitcher2, v_origin, v_angles);
        }
        if (isstring(_s.extracamswitcher3)) {
            array::thread_all_ents(level.players, &function_db4c202, 2, _s.extracamswitcher3, v_origin, v_angles);
        }
        if (isstring(_s.extracamswitcher4)) {
            array::thread_all_ents(level.players, &function_db4c202, 3, _s.extracamswitcher4, v_origin, v_angles);
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xa2aa83e3, Offset: 0x9b60
    // Size: 0x84
    function _wait_for_camera_animation(str_cam, n_start_time) {
        self endon(#"skip_camera_anims");
        if (iscamanimlooping(str_cam)) {
            level waittill("forever");
            return;
        }
        scene::wait_server_time(getcamanimtime(str_cam) / 1000, n_start_time);
    }

    // Namespace cscene/scene_objects_shared
    // Params 4, eflags: 0x0
    // Checksum 0x2f775ee, Offset: 0x85a0
    // Size: 0x15b2
    function play(str_shot, a_ents, b_testing, str_mode) {
        if (!isdefined(str_shot)) {
            str_shot = "play";
        }
        if (!isdefined(b_testing)) {
            b_testing = 0;
        }
        if (!isdefined(str_mode)) {
            str_mode = "";
        }
        /#
            if (getdvarint("<dev string:x39>") > 0) {
                printtoprightln("<dev string:x185>" + _s.name);
            }
        #/
        self notify(str_shot + "start");
        self endon(str_shot + "start");
        if (isdefined(_s.igc) && _s.igc) {
            level flagsys::increment("igc_active");
        }
        if (str_mode == "skip_scene") {
            thread skip_scene(1);
        } else if (str_mode == "skip_scene_player") {
            b_player_scene = 1;
            thread skip_scene(1);
        } else if (!is_skipping_scene() && function_e308028() && !is_scene_shared()) {
            function_e74f18c9(0);
        }
        function_c54dbcf9();
        _b_testing = b_testing;
        _str_mode = str_mode;
        if (isdefined(_s.spectateonjoin) && _s.spectateonjoin) {
            level.scene_should_spectate_on_hot_join = 1;
        }
        assign_ents(a_ents);
        if (strstartswith(_str_mode, "capture")) {
            var_25ac9a87 = level.players[0];
            v_origin = get_align_ent().origin;
            if (!isdefined(var_25ac9a87.var_5de38e4)) {
                var_25ac9a87.var_5de38e4 = util::spawn_model("tag_origin", v_origin);
                var_25ac9a87 setorigin(v_origin);
                var_25ac9a87 linkto(level.players[0].var_5de38e4);
            } else {
                var_25ac9a87.var_5de38e4.origin = v_origin;
            }
            wait 15;
            thread _stop_camera_anims();
        }
        self thread sync_with_client_scene(str_shot, b_testing);
        n_start_time = 0;
        if (issubstr(str_mode, "skipto")) {
            args = strtok(str_mode, ":");
            if (isdefined(args[1])) {
                n_start_time = float(args[1]);
            } else {
                n_start_time = 0.95;
            }
            var_24424892 = 0;
            foreach (s_obj in _a_objects) {
                if (isdefined(s_obj._s.mainanim)) {
                    anim_length = getanimlength(s_obj._s.mainanim);
                    if (anim_length > var_24424892) {
                        var_24424892 = anim_length;
                    }
                }
            }
        }
        _b_stopped = 0;
        if (!isdefined(level.active_scenes[_str_name])) {
            level.active_scenes[_str_name] = [];
        } else if (!isarray(level.active_scenes[_str_name])) {
            level.active_scenes[_str_name] = array(level.active_scenes[_str_name]);
        }
        if (!isinarray(level.active_scenes[_str_name], _e_root)) {
            level.active_scenes[_str_name][level.active_scenes[_str_name].size] = _e_root;
        }
        if (!isdefined(level.inactive_scenes[_str_name])) {
            level.inactive_scenes[_str_name] = [];
        } else if (!isarray(level.inactive_scenes[_str_name])) {
            level.inactive_scenes[_str_name] = array(level.inactive_scenes[_str_name]);
        }
        if (!isinarray(level.inactive_scenes[_str_name], _e_root)) {
            level.inactive_scenes[_str_name][level.inactive_scenes[_str_name].size] = _e_root;
        }
        if (!isdefined(_a_active_shots)) {
            _a_active_shots = [];
        } else if (!isarray(_a_active_shots)) {
            _a_active_shots = array(_a_active_shots);
        }
        if (!isinarray(_a_active_shots, str_shot)) {
            _a_active_shots[_a_active_shots.size] = str_shot;
        }
        if (!isdefined(_e_root.scenes)) {
            _e_root.scenes = [];
        } else if (!isarray(_e_root.scenes)) {
            _e_root.scenes = array(_e_root.scenes);
        }
        if (!isinarray(_e_root.scenes, self)) {
            _e_root.scenes[_e_root.scenes.size] = self;
        }
        flagsys::clear(str_shot + "ready");
        flagsys::clear(str_shot + "go");
        flagsys::clear(str_shot + "finished");
        set_request_time(str_shot);
        if (!(isdefined(_s.dontsync) && _s.dontsync)) {
            add_to_sync_list(str_shot);
        }
        foreach (o_obj in _a_objects) {
            thread [[ o_obj ]]->play(str_shot);
        }
        /#
            level.last_scene_state[_str_name] = str_shot;
            _e_root.last_scene_state_instance[_str_name] = str_shot;
            if (!isdefined(level.scene_roots)) {
                level.scene_roots = [];
            } else if (!isarray(level.scene_roots)) {
                level.scene_roots = array(level.scene_roots);
            }
            if (!isinarray(level.scene_roots, _e_root)) {
                level.scene_roots[level.scene_roots.size] = _e_root;
            }
        #/
        wait_till_shot_ready(str_shot);
        remove_from_sync_list(str_shot);
        level flagsys::set(_str_notify_name + "_ready");
        if (strstartswith(_str_mode, "capture")) {
            /#
                adddebugcommand("<dev string:x195>" + _str_name + "<dev string:x134>" + _str_name);
            #/
        }
        if (n_start_time == 0) {
            self thread _play_camera_anims();
        }
        thread _call_shot_funcs(str_shot, 1);
        if (_s scene::is_igc()) {
            if (!(isdefined(_s.disablesceneskipping) && _s.disablesceneskipping)) {
                function_a2014270(self);
            }
            if (isstring(_s.cameraswitcher)) {
                _wait_for_camera_animation(_s.cameraswitcher, n_start_time);
            } else if (isstring(_s.extracamswitcher1)) {
                _wait_for_camera_animation(_s.extracamswitcher1, n_start_time);
            } else if (isstring(_s.extracamswitcher2)) {
                _wait_for_camera_animation(_s.extracamswitcher2, n_start_time);
            } else if (isstring(_s.extracamswitcher3)) {
                _wait_for_camera_animation(_s.extracamswitcher3, n_start_time);
            } else if (isstring(_s.extracamswitcher4)) {
                _wait_for_camera_animation(_s.extracamswitcher4, n_start_time);
            }
            foreach (o_obj in _a_objects) {
                /#
                    if (getdvarint("<dev string:x39>") > 0) {
                        printtoprightln("<dev string:x1c3>" + (isdefined(o_obj._s.name) ? o_obj._s.name : o_obj._s.model));
                    }
                #/
                thread [[ o_obj ]]->stop(0, isdefined(o_obj._s.var_323df155) && o_obj._s.var_323df155);
            }
            if (!(isdefined(_s.var_ea1477ee) && _s.var_ea1477ee)) {
                _stop_camera_anims();
            }
            if (isdefined(_s.spectateonjoin) && _s.spectateonjoin) {
                level.scene_should_spectate_on_hot_join = undefined;
            }
        }
        wait_till_shot_finished(str_shot);
        if (isdefined(_s.spectateonjoin) && _s.spectateonjoin) {
            level.scene_should_spectate_on_hot_join = undefined;
        }
        if (str_shot == "play") {
            thread _call_shot_funcs("done");
            if (isdefined(_e_root)) {
                _e_root notify(#"scene_done", {#scenedef:_str_notify_name});
            }
        }
        self notify(str_shot);
        if (str_shot != "init") {
            if (is_looping() || strendswith(_str_mode, "loop")) {
                if (has_init_state()) {
                    thread play("init", undefined, b_testing, str_mode);
                } else if (get_request_time(str_shot) < gettime()) {
                    thread play(str_shot, undefined, b_testing, str_mode);
                }
            } else if (!strendswith(_str_mode, "single")) {
                thread run_next();
            } else if (!is_skipping_scene()) {
                if (function_e308028()) {
                    function_e74f18c9(0);
                }
            } else if (isdefined(level.var_109c74a6)) {
                arrayremovevalue(level.var_109c74a6, _s.name);
            }
        }
        if (isdefined(_s.spectateonjoin) && _s.spectateonjoin) {
            level.scene_should_spectate_on_hot_join = undefined;
        }
        array::flagsys_wait_clear(_a_objects, str_shot + "active");
        arrayremovevalue(_a_active_shots, str_shot);
        if (!_a_active_shots.size) {
            arrayremovevalue(level.active_scenes[_str_name], _e_root);
            if (level.active_scenes[_str_name].size == 0) {
                level.active_scenes[_str_name] = undefined;
            }
            if (!isdefined(level.inactive_scenes[_str_name])) {
                level.inactive_scenes[_str_name] = [];
            } else if (!isarray(level.inactive_scenes[_str_name])) {
                level.inactive_scenes[_str_name] = array(level.inactive_scenes[_str_name]);
            }
            if (!isinarray(level.inactive_scenes[_str_name], _e_root)) {
                level.inactive_scenes[_str_name][level.inactive_scenes[_str_name].size] = _e_root;
            }
            if (isdefined(_e_root)) {
                arrayremovevalue(_e_root.scenes, self);
                if (_e_root.scenes.size == 0) {
                    _e_root.scenes = undefined;
                }
            }
            foreach (obj in _a_objects) {
                obj notify(#"death");
            }
            _a_objects = undefined;
            if (isdefined(_s.igc) && _s.igc) {
                level flagsys::decrement("igc_active");
            }
        }
        self notify(#"remove_callbacks");
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa402b1c1, Offset: 0x8590
    // Size: 0x6
    function function_7731633d() {
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x260076d1, Offset: 0x8480
    // Size: 0x104
    function get_anim_relative_start_time(animation, n_time) {
        if (!isdefined(n_start_time) || n_start_time == 0 || !isdefined(var_24424892) || var_24424892 == 0) {
            return n_time;
        }
        anim_length = getanimlength(animation);
        is_looping = isanimlooping(animation);
        n_time = var_24424892 / anim_length * n_time;
        if (is_looping) {
            if (n_time > 0.95) {
                n_time = 0.95;
            }
        } else if (n_time > 0.99) {
            n_time = 0.99;
        }
        return n_time;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xdcc1c78, Offset: 0x8258
    // Size: 0x21c
    function get_objects(type, str_team) {
        a_ret = [];
        foreach (obj in _a_objects) {
            if (isarray(type)) {
                if (isinarray(type, obj._s.type)) {
                    if (scene::check_team(obj._s.team, str_team)) {
                        if (!isdefined(a_ret)) {
                            a_ret = [];
                        } else if (!isarray(a_ret)) {
                            a_ret = array(a_ret);
                        }
                        a_ret[a_ret.size] = obj;
                    }
                }
                continue;
            }
            if (obj._s.type == type) {
                if (scene::check_team(obj._s.team, str_team)) {
                    if (!isdefined(a_ret)) {
                        a_ret = [];
                    } else if (!isarray(a_ret)) {
                        a_ret = array(a_ret);
                    }
                    a_ret[a_ret.size] = obj;
                }
            }
        }
        return a_ret;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x81191f7, Offset: 0x8208
    // Size: 0x42
    function _is_ent_vehicle(ent, str_team) {
        return isvehicle(ent) || isvehiclespawner(ent);
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x550ba929, Offset: 0x81b8
    // Size: 0x42
    function _is_ent_actor(ent, str_team) {
        return isactor(ent) || isactorspawner(ent);
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x76ffa53b, Offset: 0x8158
    // Size: 0x52
    function _is_ent_companion(ent, str_team) {
        return ent util::is_companion() && scene::check_team(ent.team, str_team);
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x1d033256, Offset: 0x80e0
    // Size: 0x6a
    function _is_ent_player(ent, str_team) {
        return isplayer(ent) && !ent util::is_companion() && scene::check_team(ent.team, str_team);
    }

    // Namespace cscene/scene_objects_shared
    // Params 5, eflags: 0x0
    // Checksum 0xd5f491b8, Offset: 0x7f40
    // Size: 0x198
    function _assign_ents_by_type(&a_objects, &a_ents, str_type, func_test, str_team) {
        if (a_ents.size) {
            a_objects_of_type = get_objects(str_type, str_team);
            if (a_objects_of_type.size) {
                foreach (ent in arraycopy(a_ents)) {
                    if (isdefined(func_test) && [[ func_test ]](ent, str_team)) {
                        obj = array::pop_front(a_objects_of_type);
                        if (isdefined(obj)) {
                            assign_ent(obj, ent);
                            arrayremovevalue(a_ents, ent, 1);
                            arrayremovevalue(a_objects, obj);
                            continue;
                        }
                        break;
                    }
                }
            }
        }
        return a_ents.size;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xd1dfde83, Offset: 0x7c90
    // Size: 0x2a8
    function _assign_ents_by_name(&a_objects, &a_ents) {
        if (a_ents.size) {
            foreach (str_name, e_ent in arraycopy(a_ents)) {
                foreach (i, o_obj in arraycopy(a_objects)) {
                    if (isdefined(o_obj._s.name) && (isdefined(o_obj._s.name) ? "" + o_obj._s.name : "") == tolower(isdefined(str_name) ? "" + str_name : "")) {
                        assign_ent(o_obj, e_ent);
                        arrayremoveindex(a_ents, str_name, 1);
                        arrayremoveindex(a_objects, i);
                        break;
                    }
                }
            }
            /#
                foreach (i, ent in a_ents) {
                    error(isstring(i), "<dev string:x166>" + i + "<dev string:x182>");
                }
            #/
        }
        return a_ents.size;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x24e33e, Offset: 0x7bc8
    // Size: 0xba
    function assign_ent(o_obj, ent) {
        if (!isdefined(_e_root.scene_ents)) {
            _e_root.scene_ents = [];
        }
        o_obj._e = ent;
        _e_root.scene_ents[_str_name][o_obj._str_name] = o_obj._e;
        _e_root.scene_ents[o_obj._str_name] = o_obj._e;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7f9ac11b, Offset: 0x7758
    // Size: 0x462
    function assign_ents(a_ents) {
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        a_objects = arraycopy(_a_objects);
        if (_assign_ents_by_name(a_objects, a_ents)) {
            if (_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player, "teama")) {
                if (_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player, "teamb")) {
                    if (_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player, "team3")) {
                        if (_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player)) {
                            if (_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion, "teama")) {
                                if (_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion, "teamb")) {
                                    if (_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion, "team3")) {
                                        if (_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion)) {
                                            if (_assign_ents_by_type(a_objects, a_ents, "actor", &_is_ent_actor)) {
                                                if (_assign_ents_by_type(a_objects, a_ents, "vehicle", &_is_ent_vehicle)) {
                                                    if (_assign_ents_by_type(a_objects, a_ents, "model")) {
                                                        foreach (e_ent in a_ents) {
                                                            o_obj = array::pop(a_objects);
                                                            if (!error(!isdefined(o_obj), "No scene object to assign entity too.  You might have passed in more than the scene supports.")) {
                                                                assign_ent(o_obj, e_ent);
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xf8696563, Offset: 0x75c8
    // Size: 0x184
    function sync_with_client_scene(str_shot, b_test_run) {
        if (!isdefined(b_test_run)) {
            b_test_run = 0;
        }
        if (_s.vmtype === "both" && !_s scene::is_igc()) {
            self endon(str_shot + "finished");
            flagsys::wait_till(str_shot + "go");
            n_val = undefined;
            if (b_test_run) {
                switch (str_shot) {
                case #"stop":
                    n_val = 3;
                    break;
                case #"init":
                    n_val = 4;
                    break;
                case #"play":
                    n_val = 5;
                    break;
                }
            } else {
                switch (str_shot) {
                case #"stop":
                    n_val = 0;
                    break;
                case #"init":
                    n_val = 1;
                    break;
                case #"play":
                    n_val = 2;
                    break;
                }
            }
            level clientfield::set(_s.name, n_val);
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3c9b2cd1, Offset: 0x75a0
    // Size: 0x1a
    function get_object_id() {
        _n_object_id++;
        return _n_object_id;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb97ca2af, Offset: 0x73f8
    // Size: 0x19c
    function get_valid_object_defs() {
        a_obj_defs = [];
        foreach (s_obj in _s.objects) {
            if (_s.vmtype !== "client" && s_obj.vmtype !== "client") {
                if (isdefined(s_obj.name) || isdefined(s_obj.model) || isdefined(s_obj.initanim) || isdefined(s_obj.mainanim)) {
                    if (!(isdefined(s_obj.disabled) && s_obj.disabled)) {
                        if (!isdefined(a_obj_defs)) {
                            a_obj_defs = [];
                        } else if (!isarray(a_obj_defs)) {
                            a_obj_defs = array(a_obj_defs);
                        }
                        a_obj_defs[a_obj_defs.size] = s_obj;
                    }
                }
            }
        }
        return a_obj_defs;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x736804fe, Offset: 0x7280
    // Size: 0x16a
    function new_object(str_type) {
        switch (str_type) {
        case #"model":
            [[ new cscenemodel ]]->__constructor();
            return <error pop>;
        case #"vehicle":
            [[ new cscenevehicle ]]->__constructor();
            return <error pop>;
        case #"actor":
            [[ new csceneactor ]]->__constructor();
            return <error pop>;
        case #"fakeactor":
            [[ new cscenefakeactor ]]->__constructor();
            return <error pop>;
        case #"player":
            [[ new csceneplayer ]]->__constructor();
            return <error pop>;
        case #"sharedplayer":
            [[ new cscenesharedplayer ]]->__constructor();
            return <error pop>;
        case #"fakeplayer":
            [[ new cscenefakeplayer ]]->__constructor();
            return <error pop>;
        case #"companion":
            [[ new cscenecompanion ]]->__constructor();
            return <error pop>;
        case #"sharedcompanion":
            [[ new cscenesharedcompanion ]]->__constructor();
            return <error pop>;
        default:
            error(0, "Unsupported object type '" + str_type + "'.");
            break;
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x17f6a500, Offset: 0x7140
    // Size: 0x138
    function remove_from_sync_list(str_shot) {
        n_request_time = get_request_time(str_shot);
        if (isdefined(level.scene_sync_list) && isdefined(level.scene_sync_list[n_request_time])) {
            for (i = level.scene_sync_list[n_request_time].size - 1; i >= 0; i--) {
                s_scene_request = level.scene_sync_list[n_request_time][i];
                if (s_scene_request.o_scene == self && s_scene_request.str_shot == str_shot) {
                    arrayremoveindex(level.scene_sync_list[n_request_time], i);
                }
            }
            if (!level.scene_sync_list[n_request_time].size) {
                level.scene_sync_list[n_request_time] = undefined;
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe8567afe, Offset: 0x6f78
    // Size: 0x1be
    function add_to_sync_list(str_shot) {
        if (!isdefined(level.scene_sync_list)) {
            level.scene_sync_list = [];
        }
        remove_from_sync_list(str_shot);
        s_scene_request = spawnstruct();
        s_scene_request.o_scene = self;
        s_scene_request.str_shot = str_shot;
        if (!isdefined(level.scene_sync_list[get_request_time(str_shot)])) {
            level.scene_sync_list[get_request_time(str_shot)] = [];
        } else if (!isarray(level.scene_sync_list[get_request_time(str_shot)])) {
            level.scene_sync_list[get_request_time(str_shot)] = array(level.scene_sync_list[get_request_time(str_shot)]);
        }
        level.scene_sync_list[get_request_time(str_shot)][level.scene_sync_list[get_request_time(str_shot)].size] = s_scene_request;
        waittillframeend();
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf28bc985, Offset: 0x6f50
    // Size: 0x1c
    function get_request_time(str_shot) {
        return _a_request_times[str_shot];
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1e454a9c, Offset: 0x6f28
    // Size: 0x1e
    function set_request_time(str_shot) {
        _a_request_times[str_shot] = gettime();
    }

    // Namespace cscene/scene_objects_shared
    // Params 5, eflags: 0x0
    // Checksum 0x833bf62a, Offset: 0x6bb8
    // Size: 0x366
    function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run) {
        /#
            if (getdvarint("<dev string:x39>") > 0) {
                printtoprightln("<dev string:x156>" + str_scenedef);
            }
        #/
        _s = s_scenedef;
        _str_name = str_scenedef;
        _b_testing = b_test_run;
        _a_streamer_hint["allies"] = _s.streamerhintteama;
        _a_streamer_hint["axis"] = _s.streamerhintteamb;
        _str_notify_name = isstring(_s.malebundle) ? _s.malebundle : _str_name;
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        if (!error(a_ents.size > _s.objects.size, "Trying to use more entities than scene supports.")) {
            _e_root = e_align;
            a_objs = get_valid_object_defs();
            foreach (s_obj in a_objs) {
                add_object([[ new_object(s_obj.type) ]]->first_init(s_obj, self));
            }
            /#
                if (!isdefined(level.last_scene_state)) {
                    level.last_scene_state = [];
                }
                if (!isdefined(_e_root.last_scene_state_instance)) {
                    _e_root.last_scene_state_instance = [];
                }
                if (!isdefined(level.last_scene_state[_str_name])) {
                    level.last_scene_state[_str_name] = "<dev string:x13a>";
                }
                if (!isdefined(_e_root.last_scene_state_instance[_str_name])) {
                    _e_root.last_scene_state_instance[_str_name] = "<dev string:x13a>";
                }
            #/
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x75144853, Offset: 0x6b88
    // Size: 0x24
    function __destructor() {
        /#
            log("<dev string:x146>");
        #/
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x389d6e85, Offset: 0x6b18
    // Size: 0x68
    function __constructor() {
        _a_objects = [];
        _b_testing = 0;
        _n_object_id = 0;
        _str_mode = "";
        _a_streamer_hint = [];
        _a_active_shots = [];
        _a_request_times = [];
        _b_stopped = 0;
    }

}

// Namespace scene/scene_objects_shared
// Params 1, eflags: 0x0
// Checksum 0xd7c82ecb, Offset: 0xac0
// Size: 0x58
function prepare_player_model_anim(ent) {
    if (!(ent.animtree === "all_player")) {
        ent useanimtree(#all_player);
        ent.animtree = "all_player";
    }
}

// Namespace scene/scene_objects_shared
// Params 1, eflags: 0x0
// Checksum 0x812013e9, Offset: 0xb20
// Size: 0x58
function prepare_generic_model_anim(ent) {
    if (!(ent.animtree === "generic")) {
        ent useanimtree(#generic);
        ent.animtree = "generic";
    }
}

