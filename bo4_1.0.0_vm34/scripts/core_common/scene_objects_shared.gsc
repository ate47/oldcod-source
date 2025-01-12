#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_actor_shared;
#using scripts\core_common\scene_model_shared;
#using scripts\core_common\scene_player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scene_vehicle_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace scene;

// Namespace scene
// Method(s) 116 Total 116
class csceneobject {

    var _b_active_anim;
    var _b_first_frame;
    var _e;
    var _func_get;
    var _n_blend;
    var _n_ent_num;
    var _o_scene;
    var _s;
    var _scene_object;
    var _str_current_anim;
    var _str_name;
    var _str_shot;
    var _str_team;
    var current_playing_anim;
    var health;
    var m_align;
    var m_tag;
    var var_19cb700b;
    var var_324720b7;
    var var_5c4adc26;
    var var_6f396d63;
    var var_b6160c2e;
    var var_ec724817;

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x8
    // Checksum 0x918aa54c, Offset: 0x868
    // Size: 0x26
    constructor() {
        _b_first_frame = 0;
        _b_active_anim = 0;
        _n_blend = 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x10
    // Checksum 0xdaca4102, Offset: 0x898
    // Size: 0x24
    destructor() {
        /#
            log("<dev string:x30>");
        #/
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x16e78331, Offset: 0x9ab8
    // Size: 0xa
    function get_ent() {
        return _e;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x1baf44a0, Offset: 0x99e8
    // Size: 0xc4
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
    // Checksum 0x7af25fe4, Offset: 0x9870
    // Size: 0x170
    function error(condition, str_msg) {
        if (condition) {
            str_msg = "[ " + _o_scene._str_name + " ][ " + (isdefined("unknown shot") ? "" + "unknown shot" : isdefined(_str_shot) ? "" + _str_shot : "") + " ] " + (isdefined("no name") ? "" + "no name" : isdefined(_s.name) ? "" + _s.name : "") + ": " + str_msg;
            if (isdefined(_o_scene._b_testing) && _o_scene._b_testing) {
                scene::error_on_screen(str_msg);
            } else {
                assertmsg(str_msg);
            }
            thread [[ _o_scene ]]->on_error();
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x13b5c595, Offset: 0x9790
    // Size: 0xd4
    function log(str_msg) {
        println(_o_scene._s.type + "<dev string:x1fc>" + function_15979fa9(_o_scene._str_name) + "<dev string:x1fe>" + (isdefined("<dev string:x203>") ? "<dev string:x202>" + "<dev string:x203>" : isdefined(_s.name) ? "<dev string:x202>" + _s.name : "<dev string:x202>") + "<dev string:x20b>" + str_msg);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6b63f8df, Offset: 0x9758
    // Size: 0x30
    function is_skipping_scene() {
        return isdefined([[ _o_scene ]]->is_skipping_scene()) && [[ _o_scene ]]->is_skipping_scene();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xaed2b21a, Offset: 0x9720
    // Size: 0x2c
    function skip_scene(b_wait_one_frame) {
        if (isdefined(b_wait_one_frame)) {
            waitframe(1);
        }
        skip_scene_shot_animations();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9dba4540, Offset: 0x96b0
    // Size: 0x66
    function skip_scene_shot_animations() {
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
    // Checksum 0xef91c83e, Offset: 0x94b0
    // Size: 0x1f4
    function skip_animation_on_server() {
        if (isdefined(current_playing_anim[_n_ent_num])) {
            if (is_shared_player()) {
                foreach (player in [[ _func_get ]](_str_team)) {
                    /#
                        if (getdvarint(#"debug_scene_skip", 0) > 0) {
                            printtoprightln("<dev string:x1d8>" + current_playing_anim[player getentitynumber()] + "<dev string:x16a>" + gettime(), (0.8, 0.8, 0.8));
                        }
                    #/
                    skip_anim_on_server(player, current_playing_anim[player getentitynumber()]);
                }
                return;
            }
            /#
                if (getdvarint(#"debug_scene_skip", 0) > 0) {
                    printtoprightln("<dev string:x1d8>" + current_playing_anim[_n_ent_num] + "<dev string:x16a>" + gettime(), (0.8, 0.8, 0.8));
                }
            #/
            skip_anim_on_server(_e, current_playing_anim[_n_ent_num]);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x42d38553, Offset: 0x92a8
    // Size: 0x1fc
    function skip_animation_on_client() {
        if (isdefined(current_playing_anim[_n_ent_num])) {
            if (is_shared_player()) {
                foreach (player in [[ _func_get ]](_str_team)) {
                    /#
                        if (getdvarint(#"debug_scene_skip", 0) > 0) {
                            printtoprightln("<dev string:x1b4>" + current_playing_anim[player getentitynumber()] + "<dev string:x16a>" + gettime(), (0.8, 0.8, 0.8));
                        }
                    #/
                    skip_anim_on_client(player, current_playing_anim[player getentitynumber()]);
                }
            } else {
                /#
                    if (getdvarint(#"debug_scene_skip", 0) > 0) {
                        printtoprightln("<dev string:x1b4>" + current_playing_anim[_n_ent_num] + "<dev string:x16a>" + gettime(), (0.8, 0.8, 0.8));
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
    // Checksum 0x67ac8eba, Offset: 0x91e0
    // Size: 0xbc
    function skip_anim_on_server(entity, anim_name) {
        if (!isdefined(anim_name)) {
            return;
        }
        if (!isdefined(entity)) {
            return;
        }
        if (!entity isplayinganimscripted() || _str_current_anim !== anim_name) {
            return;
        }
        if (isanimlooping(anim_name)) {
            entity animation::stop();
        } else {
            entity setanimtimebyname(anim_name, 1);
        }
        entity stopsounds();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xd62e11d1, Offset: 0x9160
    // Size: 0x74
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
        if (isanimlooping(anim_name)) {
            return;
        }
        entity clientfield::increment("player_scene_animation_skip");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf2bc5123, Offset: 0x9068
    // Size: 0xea
    function _should_skip_anim(animation) {
        if (!is_player() && !(isdefined(_s.keepwhileskipping) && _s.keepwhileskipping) && is_skipping_scene() && isdefined(_s.deletewhenfinished) && _s.deletewhenfinished) {
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
    // Checksum 0x54913ff2, Offset: 0x9010
    // Size: 0x4a
    function in_a_different_scene() {
        return isdefined(_e) && isdefined(_e.current_scene) && _e.current_scene != _o_scene._str_name;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xad4c010e, Offset: 0x8ea0
    // Size: 0x168
    function in_this_scene(ent) {
        foreach (obj in _o_scene._a_objects) {
            if (isplayer(ent)) {
                if (is_shared_player()) {
                    return false;
                }
                if (function_d0e76675() && !function_a6d827b1(ent)) {
                    return false;
                }
                if (obj._e === ent) {
                    return true;
                }
                continue;
            }
            if (function_dabaa774()) {
                return false;
            }
            if (function_d0c0e390() && !function_1b4dbcac(ent)) {
                return false;
            }
            if (obj._e === ent) {
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x330b45ed, Offset: 0x8e78
    // Size: 0x1c
    function is_vehicle() {
        return _s.type === "vehicle";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc6154bdb, Offset: 0x8e28
    // Size: 0x48
    function is_actor() {
        return _s.type === "actor" && !(isdefined(_s.var_b4f500cc) && _s.var_b4f500cc);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe5b90460, Offset: 0x8d78
    // Size: 0xa4
    function function_1b4dbcac(companion) {
        foreach (obj in _o_scene._a_objects) {
            if (obj._e === companion && [[ obj ]]->function_d0c0e390()) {
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x247d0e30, Offset: 0x8cc8
    // Size: 0xa4
    function function_a6d827b1(player) {
        foreach (obj in _o_scene._a_objects) {
            if (obj._e === player && [[ obj ]]->function_d0e76675()) {
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb602d052, Offset: 0x8c90
    // Size: 0x2e
    function function_d0c0e390() {
        return function_4f5dd9d2() && !function_dabaa774();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xaa15096, Offset: 0x8c60
    // Size: 0x24
    function function_dabaa774(str_team) {
        return _s.type === "sharedcompanion";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc41b1bcb, Offset: 0x8c28
    // Size: 0x2e
    function function_d0e76675() {
        return is_player() && !is_shared_player();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd835ca5d, Offset: 0x8c00
    // Size: 0x1c
    function is_shared_player() {
        return _s.type === "sharedplayer";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf7f9c758, Offset: 0x8bd8
    // Size: 0x1c
    function is_player_model() {
        return _s.type === "fakeplayer";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7a51d697, Offset: 0x8b90
    // Size: 0x3a
    function function_4f5dd9d2() {
        return _s.type === "companion" || _s.type === "sharedcompanion";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa0dc92e5, Offset: 0x8b48
    // Size: 0x3a
    function is_player() {
        return _s.type === "player" || _s.type === "sharedplayer";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x30237ce0, Offset: 0x8ab8
    // Size: 0x88
    function function_4eedd714() {
        var_3b59f6b = scene::_get_type_count("companion", _o_scene._str_name);
        var_297a70e0 = scene::_get_type_count("sharedcompanion", _o_scene._str_name);
        if (var_3b59f6b > 0 && var_297a70e0 > 0) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa8ed46c9, Offset: 0x8a28
    // Size: 0x88
    function function_cb347a4d() {
        var_3b59f6b = scene::_get_type_count("player", _o_scene._str_name);
        var_297a70e0 = scene::_get_type_count("sharedplayer", _o_scene._str_name);
        if (var_3b59f6b > 0 && var_297a70e0 > 0) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x156508f2, Offset: 0x89a0
    // Size: 0x7c
    function function_4df86c86() {
        if (_o_scene._str_mode === "init" && (isdefined(_s.var_b6ab29c5) && _s.var_b6ab29c5 || isdefined(_s.var_a2ef2507) && _s.var_a2ef2507)) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9408d309, Offset: 0x8918
    // Size: 0x7c
    function is_alive() {
        return isdefined(_e) && (!isai(_e) || isalive(_e)) && !(isdefined(_e.isdying) && _e.isdying);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa2ebdf28, Offset: 0x88e0
    // Size: 0x2c
    function function_5854c109() {
        return _o_scene._e_root.var_bd5791b1[_s.name];
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x859a19ad, Offset: 0x88b0
    // Size: 0x28
    function function_37103914() {
        return isdefined(_s.var_c1096750) && _s.var_c1096750;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xae551ff, Offset: 0x8800
    // Size: 0xa8
    function function_178eaec9() {
        if (isdefined(_o_scene._e_root.var_bd5791b1)) {
            a_str_keys = getarraykeys(_o_scene._e_root.var_bd5791b1);
            if (isdefined(_s.name) && isinarray(a_str_keys, hash(_s.name))) {
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa4f0fe18, Offset: 0x87a0
    // Size: 0x58
    function get_camera_tween_out() {
        n_camera_tween_out = isdefined(var_b6160c2e.cameratween) ? var_b6160c2e.cameratween : _s.cameratweenout;
        return isdefined(n_camera_tween_out) ? n_camera_tween_out : 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7430ae92, Offset: 0x8740
    // Size: 0x58
    function get_camera_tween() {
        n_camera_tween = isdefined(var_b6160c2e.cameratween) ? var_b6160c2e.cameratween : _s.cameratween;
        return isdefined(n_camera_tween) ? n_camera_tween : 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3b12d9af, Offset: 0x8708
    // Size: 0x2c
    function get_lerp_time() {
        return isdefined(_s.lerptime) ? _s.lerptime : 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x294109e0, Offset: 0x8650
    // Size: 0xae
    function regroup_invulnerability(e_player) {
        e_player endon(#"disconnect");
        e_player val::set(#"regroup", "ignoreme", 1);
        e_player.b_teleport_invulnerability = 1;
        e_player util::streamer_wait(undefined, 0, 7);
        e_player val::reset(#"regroup", "ignoreme");
        e_player.b_teleport_invulnerability = undefined;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x77c3fc33, Offset: 0x8488
    // Size: 0x1bc
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
    // Checksum 0x7c2cf165, Offset: 0x8330
    // Size: 0x14a
    function kill_ent() {
        if (isarray(level.heroes) && isinarray(level.heroes, _e)) {
            arrayremovevalue(level.heroes, _e, 1);
            _e notify(#"unmake_hero");
        }
        _e util::stop_magic_bullet_shield();
        _e.var_41d547be = 1;
        _e.skipdeath = 1;
        _e.allowdeath = 1;
        _e.skipscenedeath = 1;
        _e._scene_object = undefined;
        if (isplayer(_e)) {
            _e disableinvulnerability();
        }
        _e kill();
        _e.var_41d547be = undefined;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x80f724d1, Offset: 0x8320
    // Size: 0x4
    function _spawn_ent() {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd4820546, Offset: 0x80a0
    // Size: 0x274
    function spawn_ent() {
        flagsys::set(#"spawning");
        b_disable_throttle = isdefined(_o_scene._s.dontthrottle) && _o_scene._s.dontthrottle;
        if (!b_disable_throttle) {
            spawner::global_spawn_throttle();
        }
        if (isspawner(_e) && (is_actor() || is_vehicle())) {
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
            if (isdefined(_s.model) && isdefined(_o_scene._e_root)) {
                if (is_player_model()) {
                    _e = util::spawn_anim_player_model(_s.model, function_33de018f(), function_df0e1071());
                } else {
                    _e = util::spawn_anim_model(_s.model, function_33de018f(), function_df0e1071());
                }
            }
        }
        function_668b4a7();
        flagsys::clear(#"spawning");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa802e787, Offset: 0x8058
    // Size: 0x3e
    function function_df0e1071() {
        return isdefined(_o_scene._e_root.angles) ? _o_scene._e_root.angles : (0, 0, 0);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x14aee3ab, Offset: 0x8010
    // Size: 0x3e
    function function_33de018f() {
        return isdefined(_o_scene._e_root.origin) ? _o_scene._e_root.origin : (0, 0, 0);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe3336e69, Offset: 0x7ff8
    // Size: 0xc
    function on_play_anim(ent) {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa3a7be48, Offset: 0x7ef0
    // Size: 0x100
    function function_f4286b3f() {
        if (isarray(_s.var_3bb6221f) && !(isarray(_s.shots) && _s.shots.size > 1 && function_1c059f9b(_str_shot))) {
            n_shot = get_shot(_str_shot);
            if (isdefined(n_shot) && isdefined(_s.var_3bb6221f[n_shot]) && _s.var_3bb6221f[n_shot].size) {
                return _s.var_3bb6221f[n_shot];
            }
        }
        return undefined;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xca76c16f, Offset: 0x7e78
    // Size: 0x6c
    function function_c69ef640() {
        self endon(#"hash_456b12fb28128d17");
        var_8dd443d = var_ec724817;
        self waittill(#"death", #"scene_stop");
        if (isdefined(var_8dd443d)) {
            var_8dd443d delete();
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xda91c360, Offset: 0x7b70
    // Size: 0x2fc
    function function_54ad27ab() {
        s_start_spot = function_5854c109();
        if (!isdefined(s_start_spot.target)) {
            _e waittill(#"player_downed", #"death", #"scene_stop");
            return;
        }
        _e endon(#"death", #"scene_stop");
        s_current_struct = struct::get(s_start_spot.target);
        n_move_time = isdefined(s_start_spot.script_float) ? s_start_spot.script_float : 1;
        while (isdefined(s_current_struct)) {
            if (!isdefined(_e.var_6a3689f3)) {
                _e.var_ec724817 = util::spawn_model("tag_origin", _e.origin, _e.angles);
                _e linkto(_e.var_ec724817);
                _e thread function_c69ef640();
            }
            _e.var_ec724817 moveto(s_current_struct.origin, n_move_time);
            _e.var_ec724817 rotateto(s_current_struct.angles, n_move_time);
            _e.var_ec724817 waittill(#"movedone");
            if (isdefined(s_current_struct.script_float)) {
                n_move_time = s_current_struct.script_float;
            } else {
                n_move_time = 1;
            }
            if (isdefined(s_current_struct.target)) {
                s_current_struct = struct::get(s_current_struct.target);
                continue;
            }
            s_current_struct = undefined;
        }
        if (isdefined(_e.var_ec724817)) {
            _e.var_ec724817 delete();
        }
        _e unlink();
        _e animation::stop();
        _e notify(#"hash_456b12fb28128d17");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 6, eflags: 0x0
    // Checksum 0xe7f45f2a, Offset: 0x7298
    // Size: 0x8cc
    function _play_anim(animation, n_rate, n_blend, n_time, var_bca597a2, paused) {
        if (function_d0e76675() || function_d0c0e390() || _o_scene._s scene::is_igc() || _e.scene_spawned === _o_scene._s.name) {
            if (!isdefined(n_blend) || isdefined(n_blend) && n_blend == 0) {
                _e dontinterpolate();
            }
            _e flagsys::set(#"hash_7cddd51e45d3ff3e");
        }
        function_668b4a7();
        n_lerp = isdefined(var_bca597a2) ? var_bca597a2 : get_lerp_time();
        if (is_player() && !function_18bf09f7()) {
            endcamanimscripted(_e);
            n_camera_tween = get_camera_tween();
            if (n_camera_tween > 0) {
                _e startcameratween(n_camera_tween);
            }
        }
        if (![[ _o_scene ]]->has_next_shot()) {
            n_blend_out = isai(_e) ? 0.2 : 0;
        } else {
            n_blend_out = 0;
        }
        if (isdefined(_s.diewhenfinished) && _s.diewhenfinished || isdefined(var_b6160c2e.diewhenfinished) && var_b6160c2e.diewhenfinished) {
            n_blend_out = 0;
        }
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x13b>" + (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:x16a>" + animation);
            }
        #/
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                if (!isdefined(level.animation_played)) {
                    level.animation_played = [];
                    animation_played_name = (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:x16a>" + animation;
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
            thread skip_scene_shot_animations();
        }
        on_play_anim(_e);
        var_3bb6221f = function_f4286b3f();
        if (isdefined(_s.var_56033d71) && _s.var_56033d71) {
            b_unlink_after_completed = 0;
        }
        if (function_178eaec9()) {
            if (isactor(_e) && isassetloaded("xanim", "chicken_dance_placeholder_loop")) {
                _e thread animation::play(animation, _e, m_tag, n_rate, n_blend, n_blend_out, n_lerp, n_time, _s.showweaponinfirstperson, undefined, var_3bb6221f);
            }
            function_54ad27ab();
        } else if (isdefined(_s.issiege) && _s.issiege) {
            _e animation::play_siege(animation, n_rate);
        } else {
            _e animation::play(animation, m_align, m_tag, n_rate, n_blend, n_blend_out, n_lerp, n_time, _s.showweaponinfirstperson, b_unlink_after_completed, var_3bb6221f, paused);
        }
        if (isplayer(_e)) {
            _e flagsys::clear(#"hash_7cddd51e45d3ff3e");
        }
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                log(toupper(_s.type) + "<dev string:x16e>" + function_15979fa9(animation) + "<dev string:x17b>");
            }
        #/
        if (!isdefined(_e) || !_e isplayinganimscripted()) {
            current_playing_anim[_n_ent_num] = undefined;
        }
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                if (isdefined(level.animation_played)) {
                    for (i = 0; i < level.animation_played.size; i++) {
                        animation_played_name = (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:x16a>" + animation;
                        if (level.animation_played[i] == animation_played_name) {
                            arrayremovevalue(level.animation_played, animation_played_name);
                            i--;
                        }
                    }
                }
            }
        #/
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x185>" + (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:x16a>" + animation);
            }
        #/
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1c8063e1, Offset: 0x7100
    // Size: 0x18c
    function function_668b4a7() {
        if ((_o_scene._s scene::is_igc() || [[ _o_scene ]]->has_player()) && !(isdefined(_o_scene._b_testing) && _o_scene._b_testing)) {
            if (function_d0e76675() || function_d0c0e390()) {
                _e setvisibletoall();
                return;
            }
            if (!isplayer(_e)) {
                _e setinvisibletoall();
                if (_o_scene._str_team === "allies") {
                    _e setvisibletoallexceptteam("axis");
                    return;
                }
                if (_o_scene._str_team === "axis") {
                    _e setvisibletoallexceptteam("allies");
                    return;
                }
                _e setvisibletoall();
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbcd13a0, Offset: 0x6bc8
    // Size: 0x52e
    function update_alignment() {
        m_align = get_align_ent();
        m_tag = get_align_tag();
        var_1525d88b = (isdefined(_o_scene._s.var_20cc2970) ? _o_scene._s.var_20cc2970 : 0, isdefined(_o_scene._s.var_46cea3d9) ? _o_scene._s.var_46cea3d9 : 0, isdefined(_o_scene._s.var_6cd11e42) ? _o_scene._s.var_6cd11e42 : 0);
        var_a0828691 = (isdefined(_o_scene._s.var_f39d9ae) ? _o_scene._s.var_f39d9ae : 0, isdefined(_o_scene._s.var_353c5417) ? _o_scene._s.var_353c5417 : 0, isdefined(_o_scene._s.var_c334e4dc) ? _o_scene._s.var_c334e4dc : 0);
        var_ef8bac78 = (isdefined(_s.var_20cc2970) ? _s.var_20cc2970 : 0, isdefined(_s.var_46cea3d9) ? _s.var_46cea3d9 : 0, isdefined(_s.var_6cd11e42) ? _s.var_6cd11e42 : 0);
        var_cf9a266a = (isdefined(_s.var_f39d9ae) ? _s.var_f39d9ae : 0, isdefined(_s.var_353c5417) ? _s.var_353c5417 : 0, isdefined(_s.var_c334e4dc) ? _s.var_c334e4dc : 0);
        var_3fee17d3 = (isdefined(var_b6160c2e.var_20cc2970) ? var_b6160c2e.var_20cc2970 : 0, isdefined(var_b6160c2e.var_46cea3d9) ? var_b6160c2e.var_46cea3d9 : 0, isdefined(var_b6160c2e.var_6cd11e42) ? var_b6160c2e.var_6cd11e42 : 0);
        var_ea2f1d9 = (isdefined(var_b6160c2e.var_f39d9ae) ? var_b6160c2e.var_f39d9ae : 0, isdefined(var_b6160c2e.var_353c5417) ? var_b6160c2e.var_353c5417 : 0, isdefined(var_b6160c2e.var_c334e4dc) ? var_b6160c2e.var_c334e4dc : 0);
        if (var_3fee17d3 != (0, 0, 0)) {
            var_58e90f8 = var_3fee17d3;
        } else if (var_ef8bac78 != (0, 0, 0)) {
            var_58e90f8 = var_ef8bac78;
        } else {
            var_58e90f8 = var_1525d88b;
        }
        if (var_ea2f1d9 != (0, 0, 0)) {
            v_ang_offset = var_ea2f1d9;
        } else if (var_cf9a266a != (0, 0, 0)) {
            v_ang_offset = var_cf9a266a;
        } else {
            v_ang_offset = var_a0828691;
        }
        if (m_align == level) {
            m_align = (0, 0, 0) + var_58e90f8;
            m_tag = (0, 0, 0) + v_ang_offset;
            return;
        }
        if (!isentity(m_align) && (var_58e90f8 != (0, 0, 0) || v_ang_offset != (0, 0, 0))) {
            v_pos = m_align.origin + var_58e90f8;
            v_ang = m_align.angles + v_ang_offset;
            m_align = {#origin:v_pos, #angles:v_ang};
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 4, eflags: 0x0
    // Checksum 0x53c8c43e, Offset: 0x6640
    // Size: 0x57a
    function play_anim(animation, b_camera_anim = 0, var_a7fd2c23 = 0, n_start_time = 0) {
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                if (isdefined(_s.name)) {
                    printtoprightln("<dev string:x11f>" + _s.name);
                } else {
                    printtoprightln("<dev string:x11f>" + _s.model);
                }
            }
        #/
        if (!is_shared_player() && !function_dabaa774()) {
            animation = animation_lookup(animation, undefined, b_camera_anim);
        }
        _str_current_anim = animation;
        if (_should_skip_anim(animation)) {
            return;
        }
        if (_b_first_frame || var_a7fd2c23) {
            n_rate = 0;
        } else {
            n_rate = 1;
        }
        if (n_rate > 0) {
            _o_scene flagsys::wait_till(_str_shot + "go");
        }
        if (function_c9f9f038() && !function_eaf45a5c(var_b6160c2e) && _o_scene._str_mode !== "init") {
            _e notify(#"stop_tracking_damage_scene_ent");
        }
        if (is_alive()) {
            update_alignment();
            n_time = n_start_time;
            if (n_time != 0) {
                n_time = [[ _o_scene ]]->get_anim_relative_start_time(animation, n_time, b_camera_anim);
            }
            if (scene::function_3926939d(_o_scene._str_name)) {
                n_time = 0.99;
                _o_scene.n_start_time = 0.99;
            }
            if (function_178eaec9()) {
                _play_anim(animation, n_rate, _n_blend, n_time);
                _b_active_anim = 0;
                _dynamic_paths();
            } else if (var_a7fd2c23) {
                flagsys::set(#"scene_interactive_shot_active");
                n_rate = 0;
                n_time = 0;
                thread _play_anim(animation, n_rate, _n_blend, n_time);
                _b_active_anim = 1;
            } else if (b_camera_anim) {
                thread play_camera(_str_current_anim, n_time);
            } else if (_b_first_frame) {
                thread _play_anim(animation, n_rate, _n_blend, n_time);
                _b_first_frame = 0;
                _b_active_anim = 1;
            } else if (isanimlooping(animation)) {
                if (_str_shot === "init") {
                    thread _play_anim(animation, n_rate, _n_blend, n_time);
                    _b_active_anim = 1;
                } else {
                    if (function_1c059f9b(_str_shot)) {
                        if (isdefined(_o_scene._e_root)) {
                            _o_scene._e_root notify(#"scene_done", {#str_scenedef:_o_scene._str_name});
                        }
                        _e notify(#"scene_done", {#str_scenedef:_o_scene._str_name});
                    }
                    _play_anim(animation, n_rate, _n_blend, n_time);
                    _b_active_anim = 0;
                }
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
    // Checksum 0x1af4a7d, Offset: 0x64a0
    // Size: 0x194
    function animation_lookup(animation, ent = self._e, b_camera = 0) {
        if (isdefined(_s.var_dbcb4dde) && isdefined(level.heroes) && level.heroes.size) {
            n_shot = get_shot(_str_shot);
            foreach (e_hero in level.heroes) {
                e_specialist = e_hero;
                break;
            }
            var_6f5dfee0 = e_specialist.animname;
            if (isdefined(n_shot) && isdefined(_s.var_dbcb4dde[n_shot]) && isdefined(_s.var_dbcb4dde[n_shot][var_6f5dfee0])) {
                return _s.var_dbcb4dde[n_shot][var_6f5dfee0].var_121fe5f6;
            }
        }
        return animation;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4a70f309, Offset: 0x6450
    // Size: 0x44
    function function_4a013a61() {
        if (isdefined(var_b6160c2e.var_aa4578b3) && var_19cb700b === var_b6160c2e.var_aa4578b3) {
            return 1;
        }
        return 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 3, eflags: 0x0
    // Checksum 0xd5456173, Offset: 0x6340
    // Size: 0x102
    function function_b2c8d8c2(var_e61f8576, n_movement, player) {
        if (player adsbuttonpressed()) {
            return _str_current_anim;
        }
        if (var_e61f8576.var_5de6d3f0 == "move_up" || var_e61f8576.var_5de6d3f0 == "move_right") {
            if (n_movement >= 0) {
                return _str_current_anim;
            } else {
                return var_b6160c2e.var_aa4578b3;
            }
        } else if (var_e61f8576.var_5de6d3f0 == "move_down" || var_e61f8576.var_5de6d3f0 == "move_left") {
            if (n_movement <= 0) {
                return _str_current_anim;
            } else {
                return var_b6160c2e.var_aa4578b3;
            }
        }
        return _str_current_anim;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3b9f37cc, Offset: 0x6278
    // Size: 0xba
    function set_objective() {
        if (!isdefined(_e.script_objective)) {
            if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.script_objective)) {
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
    // Checksum 0xec33d9a0, Offset: 0x61a8
    // Size: 0xc6
    function restore_saved_ent() {
        if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.scene_ents) && !(isdefined(_o_scene._e_root.script_ignore_active_scene_check) && _o_scene._e_root.script_ignore_active_scene_check)) {
            if (isdefined(_o_scene._e_root.scene_ents[_str_name])) {
                _e = _o_scene._e_root.scene_ents[_str_name];
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x90a7a6df, Offset: 0x6188
    // Size: 0x12
    function get_orig_name() {
        return _s.name;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x90117835, Offset: 0x6110
    // Size: 0x6a
    function _assign_unique_name() {
        if (isdefined(_s.name)) {
            _str_name = _s.name;
            return;
        }
        _str_name = _o_scene._str_name + "_noname" + [[ _o_scene ]]->get_object_id();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x54dffa03, Offset: 0x5c68
    // Size: 0x49c
    function function_e6ca377e(s_shot, var_a5b96b53) {
        str_mod = var_a5b96b53.mod;
        str_damage_types = (!isdefined(_s.runsceneondmg0) || _s.runsceneondmg0 == "none" ? "" : _s.runsceneondmg0) + (!isdefined(_s.runsceneondmg1) || _s.runsceneondmg1 == "none" ? "" : _s.runsceneondmg1) + (!isdefined(_s.runsceneondmg2) || _s.runsceneondmg2 == "none" ? "" : _s.runsceneondmg2) + (!isdefined(_s.runsceneondmg3) || _s.runsceneondmg3 == "none" ? "" : _s.runsceneondmg3) + (!isdefined(_s.runsceneondmg4) || _s.runsceneondmg4 == "none" ? "" : _s.runsceneondmg4);
        switch (str_mod) {
        case #"mod_rifle_bullet":
        case #"mod_pistol_bullet":
            if (issubstr(str_damage_types, "bullet") || isdefined(s_shot.var_42b4d424) && s_shot.var_42b4d424 || isdefined(s_shot.var_42d6259d) && s_shot.var_42d6259d) {
                return true;
            }
            break;
        case #"mod_explosive":
        case #"mod_grenade":
        case #"mod_grenade_splash":
            if (issubstr(str_damage_types, "explosive") || isdefined(s_shot.var_d52e2a1) && s_shot.var_d52e2a1 || isdefined(s_shot.var_42d6259d) && s_shot.var_42d6259d) {
                return true;
            }
            break;
        case #"mod_projectile":
        case #"mod_projectile_splash":
            if (issubstr(str_damage_types, "projectile") || isdefined(s_shot.var_f86ed699) && s_shot.var_f86ed699 || isdefined(s_shot.var_42d6259d) && s_shot.var_42d6259d) {
                return true;
            }
            break;
        case #"mod_melee_weapon_butt":
        case #"mod_melee":
            if (issubstr(str_damage_types, "melee") || isdefined(s_shot.var_f7cc260) && s_shot.var_f7cc260 || isdefined(s_shot.var_42d6259d) && s_shot.var_42d6259d) {
                return true;
            }
            break;
        default:
            if (issubstr(str_damage_types, "all") || isdefined(s_shot.var_42d6259d) && s_shot.var_42d6259d) {
                return true;
            }
            break;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5911b6ad, Offset: 0x5b20
    // Size: 0x13a
    function function_eaf45a5c(s_shot) {
        if (isdefined(_s.runsceneondmg0) || isdefined(_s.runsceneondmg1) || isdefined(_s.runsceneondmg2) || isdefined(_s.runsceneondmg3) || isdefined(_s.runsceneondmg4)) {
            return true;
        }
        if (isdefined(s_shot.var_42d6259d) && s_shot.var_42d6259d || isdefined(s_shot.var_42b4d424) && s_shot.var_42b4d424 || isdefined(s_shot.var_d52e2a1) && s_shot.var_d52e2a1 || isdefined(s_shot.var_f86ed699) && s_shot.var_f86ed699 || isdefined(s_shot.var_f7cc260) && s_shot.var_f7cc260) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4c8e9eff, Offset: 0x5af0
    // Size: 0x24
    function function_c9f9f038() {
        if (isdefined(var_6f396d63) && var_6f396d63) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x93326ca0, Offset: 0x5888
    // Size: 0x25e
    function function_c9137cd3() {
        if (isdefined(_s.var_425427e8)) {
            _e.script_health = _s.var_425427e8;
            if (isdefined(_e.n_health)) {
                _e.n_health = _s.var_425427e8;
                _e.var_b0459205 = _e.n_health;
                if (!isdefined(_e.maxhealth)) {
                    _e.maxhealth = _e.n_health;
                }
            } else {
                _e.health = _s.var_425427e8;
                if (!isdefined(_e.maxhealth)) {
                    _e.maxhealth = _e.health;
                }
            }
        }
        if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.script_health)) {
            _e.script_health = _o_scene._e_root.script_health;
            if (isdefined(_e.n_health)) {
                _e.n_health = _e.script_health;
                _e.var_b0459205 = _e.script_health;
                _e.maxhealth = _e.n_health;
            } else {
                _e.health = _e.script_health;
                _e.maxhealth = _e.health;
            }
        }
        if (!isdefined(_e.maxhealth)) {
            _e.maxhealth = _e.health;
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x39de919, Offset: 0x55e8
    // Size: 0x298
    function function_1ab7cd3e(s_shot, var_a5b96b53) {
        _e notify(#"hash_b02076d93b34558");
        _e endon(#"hash_b02076d93b34558", #"delete", #"scene_stop");
        var_afdf4f45 = _e.var_afdf4f45;
        foreach (var_7a1b6206 in var_afdf4f45) {
            while (!var_7a1b6206) {
                waitframe(1);
            }
        }
        _e.var_324720b7 = 1;
        thread function_c0192b1b();
        if (isdefined(_e)) {
            _e notify(#"hash_18be12558bc58fe", {#str_shot:s_shot.name, #str_scene:_o_scene._str_name, #var_a5b96b53:var_a5b96b53, #var_672cd179:_str_name});
            _e.health = 0;
        }
        if (isdefined(_o_scene._e_root)) {
            _o_scene._e_root notify(#"hash_5bb6862842cacfe8", {#var_d59fe97e:_e, #var_672cd179:_str_name, #str_shot:s_shot.name, #var_a5b96b53:var_a5b96b53});
        }
        level notify(#"hash_4d265bbfcf0b6b4b", {#str_shot:s_shot.name, #str_scene:_o_scene._str_name});
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1a889223, Offset: 0x5440
    // Size: 0x19c
    function function_c0192b1b() {
        var_e00a4f57 = 1;
        foreach (o_obj in _o_scene._a_objects) {
            if (isdefined(o_obj._e) && !(isdefined(o_obj._e.var_324720b7) && o_obj._e.var_324720b7)) {
                var_e00a4f57 = 0;
                break;
            }
        }
        if (var_e00a4f57) {
            _o_scene.var_e775b0f8 = 1;
            foreach (o_obj in _o_scene._a_objects) {
                o_obj flagsys::clear(#"waiting_for_damage");
            }
            if (isdefined(_o_scene._e_root)) {
                _o_scene._e_root notify(#"hash_18be12558bc58fe");
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6b8e17c5, Offset: 0x5370
    // Size: 0xc2
    function function_f668379d() {
        if (isdefined(_e.var_afdf4f45)) {
            var_159edfa9 = 0;
            foreach (var_7a1b6206 in _e.var_afdf4f45) {
                if (var_7a1b6206) {
                    var_159edfa9++;
                    if (var_159edfa9 == _e.var_afdf4f45.size) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xcb987304, Offset: 0x4e80
    // Size: 0x4e4
    function function_aa802078(s_shot, var_a5b96b53) {
        if (!isdefined(_e)) {
            return false;
        }
        if (isdefined(_e.var_afdf4f45[s_shot.name]) && _e.var_afdf4f45[s_shot.name]) {
            return false;
        }
        if (!function_e6ca377e(s_shot, var_a5b96b53)) {
            return false;
        }
        var_2f2f5b9c = 0;
        if (!isdefined(s_shot.damagethreshold) && !(isdefined(s_shot.var_b74a1e0e) && s_shot.var_b74a1e0e)) {
            var_2f2f5b9c = 1;
        }
        if (var_2f2f5b9c) {
            var_e5b345b0 = 0;
            var_79936a8f = 0;
        } else {
            if (isdefined(s_shot.var_b74a1e0e) && s_shot.var_b74a1e0e) {
                s_shot.damagethreshold = 0;
            }
            if (isdefined(_e.n_health)) {
                n_current_health = _e.n_health;
            } else {
                n_current_health = _e.health;
            }
            if (n_current_health <= 0) {
                n_current_health = 0;
            }
            if (isdefined(_e.var_b0459205)) {
                var_b0459205 = _e.var_b0459205;
            } else {
                var_b0459205 = _e.maxhealth;
            }
            var_e5b345b0 = n_current_health / var_b0459205;
            var_79936a8f = s_shot.damagethreshold;
        }
        if (!(isdefined(_s.var_13d57954) && _s.var_13d57954)) {
            b_dead = var_e5b345b0 <= 0;
            var_a5b96b53.attacker util::show_hit_marker(b_dead);
        }
        if (var_e5b345b0 <= var_79936a8f) {
            _e.var_4c2f9749 = 1;
            _e notify(#"hash_4d265bbfcf0b6b4b", {#str_shot:s_shot.name, #str_scene:_o_scene._str_name, #var_a5b96b53:var_a5b96b53, #var_c21e5798:var_e5b345b0, #var_c2db5b64:var_79936a8f});
            level notify(#"hash_4d265bbfcf0b6b4b", {#e_damaged:_e, #str_shot:s_shot.name, #str_scene:_o_scene._str_name, #var_a5b96b53:var_a5b96b53, #var_c21e5798:var_e5b345b0, #var_c2db5b64:var_79936a8f});
            if (isdefined(_o_scene._e_root)) {
                _o_scene._e_root notify(#"hash_4d265bbfcf0b6b4b", {#e_damaged:_e, #str_shot:s_shot.name, #str_scene:_o_scene._str_name, #var_a5b96b53:var_a5b96b53, #var_c21e5798:var_e5b345b0, #var_c2db5b64:var_79936a8f});
            }
            _e.var_afdf4f45[s_shot.name] = 1;
            thread [[ _o_scene ]]->play(s_shot.name, undefined, undefined, "single");
            if (function_f668379d()) {
                _e setcandamage(0);
                thread function_1ab7cd3e(s_shot, var_a5b96b53);
            }
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf9fb3e4d, Offset: 0x4e08
    // Size: 0x6c
    function function_ff3fee08(str_notify) {
        if (str_notify == "stop_tracking_damage_scene_ent" || str_notify == "delete") {
            if (isdefined(_scene_object)) {
                var_324720b7 = 1;
                health = 0;
                _scene_object thread function_c0192b1b();
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5aa8d10b, Offset: 0x4ae8
    // Size: 0x316
    function function_99a4208d() {
        _e endoncallback(&function_ff3fee08, #"delete", #"scene_stop", #"stop_tracking_damage_scene_ent");
        _o_scene endon(#"scene_done", #"scene_stop", #"hash_42da41892ac54794");
        _e setcandamage(1);
        function_c9137cd3();
        _o_scene.var_c1c449de = 1;
        foreach (s_shot in _s.shots) {
            if (s_shot.name === "init") {
                _e.var_afdf4f45[s_shot.name] = 1;
                continue;
            }
            if (function_eaf45a5c(s_shot)) {
                _e.var_afdf4f45[s_shot.name] = 0;
            }
        }
        if (isdefined(_s.var_908a655e) && _s.var_908a655e) {
            _e util::function_e831de44();
        }
        while (true) {
            flagsys::set(#"waiting_for_damage");
            var_a5b96b53 = _e waittill(#"damage", #"death");
            if (!isdefined(_e)) {
                return;
            }
            if (isdefined(_e.n_health)) {
                waittillframeend();
            }
            foreach (s_shot in _s.shots) {
                function_aa802078(s_shot, var_a5b96b53);
            }
            if (isdefined(_e.var_324720b7) && _e.var_324720b7) {
                return;
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc777da68, Offset: 0x4a00
    // Size: 0xdc
    function get_align_tag() {
        n_shot = get_shot(_str_shot);
        if (isdefined(n_shot) && isdefined(_s.shots[n_shot].aligntargettag)) {
            return _s.shots[n_shot].aligntargettag;
        }
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
    // Checksum 0x8511884b, Offset: 0x47b0
    // Size: 0x246
    function get_align_ent() {
        e_align = undefined;
        if (isdefined(var_b6160c2e.aligntarget) && !(isdefined(var_b6160c2e.var_e6a75087) && var_b6160c2e.var_e6a75087)) {
            var_590588e0 = var_b6160c2e.aligntarget;
        } else if (isdefined(_s.aligntarget) && !(_s.aligntarget === _o_scene._s.aligntarget)) {
            var_590588e0 = _s.aligntarget;
        }
        if (isdefined(var_590588e0)) {
            a_scene_ents = [[ _o_scene ]]->get_ents();
            if (isdefined(a_scene_ents[var_590588e0])) {
                e_align = a_scene_ents[var_590588e0];
            } else {
                e_align = scene::get_existing_ent(var_590588e0, 0, 1);
            }
            if (!isdefined(e_align)) {
                str_msg = "Align target '" + (isdefined(var_590588e0) ? "" + var_590588e0 : "") + "' doesn't exist for scene object " + (isdefined(_str_name) ? "" + _str_name : "") + " in shot named " + (isdefined(_str_shot) ? "" + _str_shot : "");
                if (!warning(_o_scene._b_testing, str_msg)) {
                    error(getdvarint(#"scene_align_errors", 1), str_msg);
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
    // Checksum 0x80f724d1, Offset: 0x47a0
    // Size: 0x4
    function _cleanup() {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x3fe3498, Offset: 0x46d0
    // Size: 0xc4
    function function_138c8e6e(_e) {
        _e notify(#"cleanupdelete");
        _e endon(#"death", #"preparedelete", #"cleanupdelete");
        s_waitresult = _o_scene waittilltimeout(0.15, #"hash_60adeaccbb565546", #"scene_stop", #"scene_done", #"scene_skip_completed");
        _e thread scene::synced_delete();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x372df946, Offset: 0x45e0
    // Size: 0xe4
    function function_a7193b4b(_e) {
        _e notify(#"cleanuphide");
        _e endon(#"death", #"prepareshow", #"preparehide", #"cleanuphide");
        _o_scene waittilltimeout(0.15, #"hash_60adeaccbb565546", #"scene_stop", #"scene_done", #"scene_skip_completed");
        _e val::set(#"scene", "hide", 2);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2867b6d6, Offset: 0x42e0
    // Size: 0x2f4
    function function_4c533a8f() {
        if (!isdefined(_e) || !isdefined(var_b6160c2e)) {
            return;
        }
        if (isdefined(var_b6160c2e.var_ffff50ef)) {
            a_ents = getentarray(var_b6160c2e.var_ffff50ef, "targetname", 1);
            array::thread_all(a_ents, &val::set, #"script_hide", "hide", 1);
        } else if (isdefined(var_b6160c2e.var_dd24fc3e)) {
            a_ents = getentarray(var_b6160c2e.var_dd24fc3e, "targetname", 1);
            array::thread_all(a_ents, &val::reset, #"script_hide", "hide");
        }
        if (isdefined(var_b6160c2e.cleanupdelete) && var_b6160c2e.cleanupdelete && !isplayer(_e)) {
            thread function_138c8e6e(_e);
            return;
        }
        if (isdefined(var_b6160c2e.var_9d526525) && var_b6160c2e.var_9d526525 && _str_shot != "init") {
            _e connectpaths();
        } else if (isdefined(var_b6160c2e.var_bf20e513) && var_b6160c2e.var_bf20e513) {
            _e disconnectpaths(2, 1);
        }
        if (isdefined(var_b6160c2e.cleanuphide) && var_b6160c2e.cleanuphide) {
            thread function_a7193b4b(_e);
            return;
        }
        if (isdefined(var_b6160c2e.cleanupshow) && var_b6160c2e.cleanupshow) {
            _e notify(#"cleanupshow");
            _e val::reset(#"scene", "hide");
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6e158451, Offset: 0x3f68
    // Size: 0x36c
    function cleanup() {
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x107>" + (isdefined(_s.name) ? _s.name : _s.model));
            }
        #/
        if (isplayer(_e) && (function_cb347a4d() || function_4eedd714())) {
            _reset_values();
        }
        function_4c533a8f();
        if (isdefined(_e) && flagsys::get(_str_shot + "active") && !flagsys::get(#"waiting_for_damage")) {
            b_finished = flagsys::get(_str_shot + "finished");
            b_stopped = flagsys::get(_str_shot + "stopped");
            if (!isplayer(_e)) {
                _e sethighdetail(0);
                function_fd66997(_str_shot);
            }
            _cleanup();
            if (!isplayer(_e)) {
                _e._scene_object = undefined;
                _e.current_scene = undefined;
                _e.anim_debug_name = undefined;
                _e flagsys::clear(#"scene");
            }
            if (is_alive()) {
                _reset_values();
            }
        }
        if (isdefined(_e) && !isplayer(_e)) {
            _e flagsys::clear(#"hash_2f30b24ec0e23830");
            _e flagsys::clear(#"hash_e2ce599b208682a");
            _e flagsys::clear(#"hash_f21f320f68c0457");
        }
        flagsys::clear(_str_shot + "active");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4c5df202, Offset: 0x3ee8
    // Size: 0x74
    function _stop(b_dont_clear_anim = 0) {
        if (isalive(_e)) {
            _e notify(#"scene_stop");
            if (!b_dont_clear_anim) {
                _e animation::stop(0.2);
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x6a632b63, Offset: 0x3dc0
    // Size: 0x11c
    function stop(b_clear = 0, b_dont_clear_anim = 0) {
        self notify(#"new_shot");
        if (isdefined(_str_shot)) {
            flagsys::set(_str_shot + "stopped");
            if (b_clear) {
                if (isdefined(_e)) {
                    _e notify(#"scene_stop");
                    if (isplayer(_e)) {
                        _stop(b_dont_clear_anim);
                    } else {
                        _e delete();
                    }
                }
            } else {
                _stop(b_dont_clear_anim);
            }
            cleanup();
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc8cd5958, Offset: 0x3cf0
    // Size: 0xc4
    function function_91cefaa3() {
        if (isdefined(_e) && (isbot(_e) || isai(_e))) {
            if (isbot(_e)) {
                _e bot_util::function_3896525e(_e.origin, 1);
                return;
            }
            _e setgoal(_e.origin, 1);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9ecc6ac9, Offset: 0x3a60
    // Size: 0x284
    function scene_reach() {
        if (!isactor(_e) && !isbot(_e)) {
            return;
        }
        b_do_reach = (isdefined(_s.doreach) && _s.doreach || isdefined(var_b6160c2e.var_cb56f152) && var_b6160c2e.var_cb56f152 || isdefined(var_b6160c2e.var_48978d81) && var_b6160c2e.var_48978d81) && (!(isdefined(_o_scene._b_testing) && _o_scene._b_testing) || getdvarint(#"scene_test_with_reach", 0));
        if (b_do_reach) {
            str_animation = get_animation_name(_str_shot);
            _e val::reset(#"scene", "hide");
            if (isdefined(_s.disablearrivalinreach) && _s.disablearrivalinreach || isdefined(var_b6160c2e.var_48978d81) && var_b6160c2e.var_48978d81) {
                _e animation::reach(str_animation, get_align_ent(), get_align_tag(), 1);
            } else {
                _e animation::reach(str_animation, get_align_ent(), get_align_tag());
            }
            function_91cefaa3();
        }
        flagsys::set(_str_shot + "ready");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x72faa86e, Offset: 0x39d0
    // Size: 0x84
    function run_wait(wait_time) {
        wait_start_time = 0;
        while (wait_start_time < wait_time && !is_skipping_scene()) {
            wait_start_time += float(function_f9f48566()) / 1000;
            waitframe(1);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xdb21d13e, Offset: 0x3930
    // Size: 0x94
    function _dynamic_paths() {
        if (isdefined(_e) && isdefined(_s.dynamicpaths) && _s.dynamicpaths) {
            if (distance2dsquared(_e.origin, _e.scene_orig_origin) > 4) {
                _e disconnectpaths(2, 0);
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd5607a2b, Offset: 0x3870
    // Size: 0xb8
    function function_450f4047() {
        if (isdefined(_o_scene._a_objects)) {
            foreach (obj in _o_scene._a_objects) {
                if (isdefined(obj) && [[ obj ]]->is_player()) {
                    obj flagsys::wait_till_clear("camera_playing");
                }
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x11665e30, Offset: 0x3748
    // Size: 0x11c
    function function_e29566e2() {
        if (_b_first_frame) {
            return;
        }
        n_spacer_min = var_b6160c2e.spacermin;
        n_spacer_max = var_b6160c2e.spacermax;
        if (!is_skipping_scene() && (isdefined(n_spacer_min) || isdefined(n_spacer_max))) {
            if (isdefined(n_spacer_min) && isdefined(n_spacer_max)) {
                if (!error(n_spacer_min >= n_spacer_max, "Spacer Min value must be less than Spacer Max value!")) {
                    run_wait(randomfloatrange(n_spacer_min, n_spacer_max));
                }
                return;
            }
            if (isdefined(n_spacer_min)) {
                run_wait(n_spacer_min);
                return;
            }
            if (isdefined(n_spacer_max)) {
                run_wait(n_spacer_max);
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4e283636, Offset: 0x3708
    // Size: 0x36
    function function_90b68c4f() {
        _n_blend = isdefined(var_b6160c2e.blend) ? var_b6160c2e.blend : 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6860c53d, Offset: 0x3658
    // Size: 0xa6
    function function_e92dd0c5() {
        if (isdefined(_s.firstframe) && _s.firstframe && _o_scene._str_mode == "init" && isdefined(_e) && !(isdefined(_e.var_4c2f9749) && _e.var_4c2f9749)) {
            _b_first_frame = 1;
            return;
        }
        _b_first_frame = 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb5b97c04, Offset: 0x3618
    // Size: 0x34
    function function_9abcc54d() {
        function_e92dd0c5();
        function_90b68c4f();
        function_e29566e2();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xc95c77b7, Offset: 0x2b78
    // Size: 0xa94
    function play(str_shot = "play", n_start_time) {
        n_shot = get_shot(str_shot);
        if (!isdefined(n_shot) && !has_streamer_hint()) {
            flagsys::set(str_shot + "ready");
            flagsys::set(str_shot + "finished");
            function_fd66997(str_shot);
            return;
        }
        self notify(#"new_shot");
        self endon(#"new_shot");
        flagsys::set(str_shot + "active");
        if (!isdefined(_o_scene._a_active_shots)) {
            _o_scene._a_active_shots = [];
        } else if (!isarray(_o_scene._a_active_shots)) {
            _o_scene._a_active_shots = array(_o_scene._a_active_shots);
        }
        if (!isinarray(_o_scene._a_active_shots, str_shot)) {
            _o_scene._a_active_shots[_o_scene._a_active_shots.size] = str_shot;
        }
        if (isdefined(_str_shot)) {
            cleanup();
        }
        _str_shot = str_shot;
        var_b6160c2e = function_301cb3ea(_str_shot);
        flagsys::clear(_str_shot + "stopped");
        flagsys::clear(_str_shot + "finished");
        flagsys::clear(_str_shot + "ready");
        flagsys::set(_str_shot + "active");
        spawn();
        function_509dcd9c();
        if (!function_bb50ab9e(n_shot)) {
            waitframe(1);
        } else if (function_178eaec9()) {
            function_9abcc54d();
            play_anim("chicken_dance_placeholder_loop", 0, undefined, n_start_time);
        } else {
            var_66f4eae7 = function_f850028d(n_shot);
            function_9abcc54d();
            var_f2f29e4b = array("blend", "cameraswitcher", "anim");
            foreach (str_entry_type in var_f2f29e4b) {
                if (!is_alive() || function_4df86c86()) {
                    break;
                }
                foreach (n_entry in var_66f4eae7) {
                    entry = get_entry(n_shot, n_entry, str_entry_type);
                    if (isdefined(entry)) {
                        switch (str_entry_type) {
                        case #"cameraswitcher":
                            if (ishash(entry)) {
                                /#
                                    error(!isassetloaded("<dev string:x41>", entry), "<dev string:x46>" + function_15979fa9(entry) + "<dev string:x4c>");
                                #/
                            } else {
                                error(!isassetloaded("xcam", entry), "XCAM " + entry + " is not loaded! Being referenced in scene, but has been deleted or renamed");
                            }
                            var_a9fd0963 = 1;
                            play_anim(entry, 1, undefined, n_start_time);
                            break;
                        case #"anim":
                            if (isdefined(_s.issiege) && _s.issiege) {
                                if (ishash(entry)) {
                                    /#
                                        error(!isassetloaded("<dev string:x97>", entry), "<dev string:x9d>" + function_15979fa9(entry) + "<dev string:xa4>");
                                    #/
                                } else {
                                    error(!isassetloaded("sanim", entry), "SANIM " + entry + " is not loaded! Siege anim eing referenced in scene, but has been deleted or renamed");
                                }
                            } else if (ishash(entry)) {
                                /#
                                    error(!isassetloaded("<dev string:xfa>", entry), "<dev string:x100>" + function_15979fa9(entry) + "<dev string:x4c>");
                                #/
                            } else {
                                error(!isassetloaded("xanim", entry), "XANIM " + entry + " is not loaded! Being referenced in scene, but has been deleted or renamed");
                            }
                            var_a9fd0963 = 1;
                            play_anim(entry, 0, function_a00213f(n_shot), n_start_time);
                            break;
                        case #"blend":
                            _n_blend = entry;
                            break;
                        default:
                            error(1, "Bad timeline entry type '" + str_entry_type + "'.");
                            break;
                        }
                    }
                }
            }
            if (!(isdefined(var_a9fd0963) && var_a9fd0963)) {
                waitframe(1);
                if (function_1c059f9b(_str_shot)) {
                    _b_active_anim = 0;
                }
                if (is_player() && (function_4eedd714() || function_cb347a4d())) {
                    waitframe(4);
                }
            }
            var_a9fd0963 = 0;
        }
        function_51ce71b1();
        if (is_player() || function_4f5dd9d2()) {
            function_450f4047();
        }
        flagsys::wait_till_clear("scene_interactive_shot_active");
        if (!_o_scene._b_testing) {
            flagsys::wait_till_clear("waiting_for_damage");
        }
        if (isdefined(_o_scene.var_c1c449de) && _o_scene.var_c1c449de && isdefined(_o_scene.var_e775b0f8) && _o_scene.var_e775b0f8) {
            _o_scene flagsys::set(#"hash_42da41892ac54794");
        }
        if (is_alive()) {
            flagsys::set(_str_shot + "finished");
            if (isdefined(_s.diewhenfinished) && _s.diewhenfinished && function_1c059f9b(_str_shot) || isdefined(var_b6160c2e.diewhenfinished) && var_b6160c2e.diewhenfinished) {
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
    // Params 1, eflags: 0x0
    // Checksum 0x9d356806, Offset: 0x2a08
    // Size: 0x164
    function function_fd66997(str_shot) {
        if (isdefined(_e) && !isplayer(_e) && !(isdefined(_e.isdying) && _e.isdying) && isdefined(_s.deletewhenfinished) && _s.deletewhenfinished) {
            if (str_shot != "init" && function_1c059f9b(str_shot) && !function_c9f9f038()) {
                _e thread scene::synced_delete();
                return;
            }
            if (str_shot != "init" && function_c9f9f038() && isdefined(_o_scene.var_e775b0f8) && _o_scene.var_e775b0f8) {
                _e thread scene::synced_delete();
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x32936eb5, Offset: 0x26e8
    // Size: 0x314
    function function_2550967e() {
        if (isdefined(_o_scene._e_root)) {
            _o_scene._e_root notify(#"hash_4e8860ad89fcf927", {#var_d9da4dc5:_e, #str_scene:_o_scene._str_name});
        }
        if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.target)) {
            var_b4ed38d8 = getnode(_o_scene._e_root.target, "targetname");
            if (isdefined(var_b4ed38d8) && isdefined(var_b4ed38d8.interact_node) && var_b4ed38d8.interact_node) {
                var_b4ed38d8.var_dc2c452f = 1;
            }
        }
        if (isdefined(_s.var_88f9206) && _s.var_88f9206) {
            if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.scene_played)) {
                a_shots = scene::get_all_shot_names(_o_scene._str_name);
                foreach (str_shot in a_shots) {
                    _o_scene._e_root.scene_played[str_shot] = 1;
                }
            }
            if (isdefined(_o_scene._a_objects)) {
                foreach (obj in _o_scene._a_objects) {
                    if (isdefined(obj._e) && obj._s.type === "prop") {
                        obj._e stopanimscripted();
                        obj._e physicslaunch();
                    }
                }
            }
            thread [[ _o_scene ]]->stop();
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc059caa4, Offset: 0x2630
    // Size: 0xaa
    function function_f850028d(n_shot) {
        var_66f4eae7 = [];
        if (isdefined(_s.shots[n_shot]) && isdefined(_s.shots[n_shot].entry)) {
            var_66f4eae7 = getarraykeys(_s.shots[n_shot].entry);
            var_66f4eae7 = array::sort_by_value(var_66f4eae7, 1);
        }
        return var_66f4eae7;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf16e78aa, Offset: 0x25c0
    // Size: 0x62
    function function_8a70e719(n_shot) {
        if (isdefined(_s.shots[n_shot].entry)) {
            var_ce22599b = _s.shots[n_shot].entry.size;
        } else {
            var_ce22599b = 0;
        }
        return var_ce22599b;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x7b18702, Offset: 0x24b8
    // Size: 0xfa
    function find_entry(n_shot, str_entry_type) {
        if (isdefined(_s.shots[n_shot]) && isdefined(_s.shots[n_shot].entry)) {
            foreach (s_entry in _s.shots[n_shot].entry) {
                if (isdefined(s_entry.(str_entry_type))) {
                    entry = s_entry.(str_entry_type);
                    break;
                }
            }
        }
        return entry;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 3, eflags: 0x0
    // Checksum 0x267d22e1, Offset: 0x23c0
    // Size: 0xee
    function get_entry(n_shot, n_entry, str_entry_type) {
        if (isdefined(_s.shots[n_shot]) && isdefined(_s.shots[n_shot].entry) && isdefined(_s.shots[n_shot].entry[n_entry])) {
            if (isdefined(_s.shots[n_shot].entry[n_entry].(str_entry_type))) {
                entry = _s.shots[n_shot].entry[n_entry].(str_entry_type);
            }
        }
        return entry;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5085282c, Offset: 0x2360
    // Size: 0x52
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
    // Params 1, eflags: 0x0
    // Checksum 0xa08f01ea, Offset: 0x22f8
    // Size: 0x5c
    function function_a00213f(n_shot) {
        if (isdefined(n_shot)) {
            if (isdefined(_s.shots[n_shot].interactiveshot) && _s.shots[n_shot].interactiveshot) {
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa60030a3, Offset: 0x2298
    // Size: 0x54
    function function_bb50ab9e(n_shot) {
        if (isdefined(_s.shots[n_shot].disableshot) && _s.shots[n_shot].disableshot) {
            return false;
        }
        return true;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x38e5c3f5, Offset: 0x2240
    // Size: 0x4c
    function function_51ce71b1() {
        if (isdefined(_e) && isdefined(var_b6160c2e.var_3c905c80)) {
            _e setmodel(var_b6160c2e.var_3c905c80);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x30e01f63, Offset: 0x21e8
    // Size: 0x4c
    function function_509dcd9c() {
        if (isdefined(_e) && isdefined(var_b6160c2e.var_55495d64)) {
            _e setmodel(var_b6160c2e.var_55495d64);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x265cd607, Offset: 0x2150
    // Size: 0x90
    function function_301cb3ea(str_shot) {
        foreach (s_shot in _s.shots) {
            if (str_shot === s_shot.name) {
                return s_shot;
            }
        }
        return undefined;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6a1a9396, Offset: 0x20b8
    // Size: 0x90
    function get_shot(str_shot) {
        foreach (n_shot, s_shot in _s.shots) {
            if (str_shot === s_shot.name) {
                return n_shot;
            }
        }
        return undefined;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa752d8fa, Offset: 0x2070
    // Size: 0x3e
    function function_1c059f9b(str_shot) {
        return str_shot === _o_scene.var_80cc5e5f && _o_scene._str_mode !== "init";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc8702c65, Offset: 0x1fa0
    // Size: 0xc2
    function function_e8ecb5ad() {
        if (isdefined(_e)) {
            if (isarray(_e.var_d0df381)) {
                foreach (var_c5ca5090, var_d9eab69c in _e.var_d0df381) {
                    if (var_c5ca5090 === _str_shot && isdefined(var_d9eab69c)) {
                        return var_d9eab69c;
                    }
                }
            }
        }
        return undefined;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x46301f13, Offset: 0x1e98
    // Size: 0xfe
    function function_ef717ad5(_str_shot) {
        n_shot = get_shot(_str_shot);
        if (isdefined(n_shot) && isdefined(_s.shots[n_shot].entry)) {
            foreach (s_entry in _s.shots[n_shot].entry) {
                if (isdefined(s_entry.("anim")) || isdefined(s_entry.cameraswitcher)) {
                    return true;
                }
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2423dda0, Offset: 0x1d38
    // Size: 0x154
    function get_animation_name(_str_shot) {
        n_shot = get_shot(_str_shot);
        if (isdefined(n_shot) && isdefined(_s.shots[n_shot].entry)) {
            foreach (s_entry in _s.shots[n_shot].entry) {
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
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x80f724d1, Offset: 0x1d28
    // Size: 0x4
    function function_4c774cdb() {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x197f4c8c, Offset: 0x1b68
    // Size: 0x1b4
    function _prepare() {
        if (issentient(_e)) {
            if (isdefined(_s.overrideaicharacter) && _s.overrideaicharacter) {
                _e detachall();
                _e setmodel(_s.model);
            }
        } else if (_s.type === "actor") {
            if (!error(_e.classname !== "script_model", "makeFakeAI must be applied to a script_model")) {
                _e makefakeai();
            }
            if (!(isdefined(_s.removeweapon) && _s.removeweapon)) {
                _e animation::attach_weapon(getweapon(#"ar_accurate_t8"));
            }
        }
        set_objective();
        if (isdefined(_s.dynamicpaths) && _s.dynamicpaths) {
            _e disconnectpaths(2);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xea5bf607, Offset: 0x17b0
    // Size: 0x3ac
    function function_b7ad8af4() {
        if (!isdefined(_e) || !isdefined(var_b6160c2e)) {
            return;
        }
        if (isdefined(var_b6160c2e.var_9388a092)) {
            a_ents = getentarray(var_b6160c2e.var_9388a092, "targetname", 1);
            array::thread_all(a_ents, &val::set, #"script_hide", "hide", 1);
        } else if (isdefined(var_b6160c2e.var_264561fb)) {
            a_ents = getentarray(var_b6160c2e.var_264561fb, "targetname", 1);
            array::thread_all(a_ents, &val::reset, #"script_hide", "hide");
        }
        if (isdefined(var_b6160c2e.preparedelete) && var_b6160c2e.preparedelete && !isplayer(_e)) {
            _e notify(#"preparedelete");
            _e scene::synced_delete();
            return;
        }
        if (isdefined(var_b6160c2e.var_a0a0848c) && var_b6160c2e.var_a0a0848c && _str_shot != "init") {
            _e.scene_orig_origin = _e.origin;
            _e connectpaths();
        } else if (isdefined(var_b6160c2e.var_7568a8b8) && var_b6160c2e.var_7568a8b8) {
            _e disconnectpaths(2, 1);
        }
        if (isdefined(var_b6160c2e.preparehide) && var_b6160c2e.preparehide) {
            _e notify(#"preparehide");
            _e val::set(#"scene", "hide", 2);
            return;
        }
        if (isdefined(var_b6160c2e.prepareshow) && var_b6160c2e.prepareshow || isdefined(_o_scene._b_testing) && _o_scene._b_testing && _o_scene._str_mode === "single") {
            _e notify(#"prepareshow");
            _e val::reset(#"scene", "hide");
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x499afc5c, Offset: 0x1048
    // Size: 0x760
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
        var_b6160c2e = function_301cb3ea(_str_shot);
        if (isdefined(_s.dynamicpaths) && _s.dynamicpaths && _str_shot != "init") {
            _e.scene_orig_origin = _e.origin;
            _e connectpaths();
        }
        if (!isai(_e) && !isplayer(_e)) {
            if (!is_player()) {
                if (isdefined(var_b6160c2e)) {
                    var_b6160c2e.devstate = undefined;
                }
                if (is_player_model()) {
                    scene::prepare_player_model_anim(_e);
                } else {
                    scene::prepare_generic_model_anim(_e);
                }
            }
        }
        _set_values();
        _e.anim_debug_name = _s.name;
        _e.current_scene = _o_scene._str_name;
        _e flagsys::set(#"scene");
        if (_e.classname == "script_model") {
            if (isdefined(_o_scene._e_root.modelscale)) {
                _e setscale(_o_scene._e_root.modelscale);
            }
        }
        if (isdefined(_s.takedamage) && _s.takedamage) {
            foreach (s_shot in _s.shots) {
                if (function_eaf45a5c(s_shot) && !function_c9f9f038()) {
                    var_6f396d63 = 1;
                    _e.var_6f396d63 = 1;
                    thread function_99a4208d();
                    break;
                }
            }
        }
        if (_o_scene._s scene::is_igc() || [[ _o_scene ]]->has_player()) {
            if (!isplayer(_e)) {
                _e sethighdetail(1);
            }
        }
        _prepare();
        if (isdefined(_s.allowdeath) && _s.allowdeath) {
            thread function_4c774cdb();
        }
        if (function_178eaec9()) {
            s_start_spot = function_5854c109();
            if (isplayer(_e)) {
                _e setorigin(s_start_spot.origin);
                _e setplayerangles(s_start_spot.angles);
            } else if (isactor(_e)) {
                _e forceteleport(s_start_spot.origin, s_start_spot.angles);
            } else {
                _e.origin = s_start_spot.origin;
                _e.angles = s_start_spot.angles;
            }
        }
        function_b7ad8af4();
        scene_reach();
        if (isdefined(var_b6160c2e.var_f8864eb5) && var_b6160c2e.var_f8864eb5) {
            _e flagsys::set(#"hash_2f30b24ec0e23830");
        }
        if (isdefined(var_b6160c2e.var_aff1272b)) {
            if (var_b6160c2e.var_aff1272b == "friendly") {
                _e flagsys::set(#"hash_e2ce599b208682a");
            } else if (var_b6160c2e.var_aff1272b == "enemy") {
                _e flagsys::set(#"hash_f21f320f68c0457");
            }
        }
        flagsys::set(_str_shot + "ready");
        flagsys::clear(_str_shot + "finished");
        return 1;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3c5a2140, Offset: 0xea8
    // Size: 0x192
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
        if (!isdefined(_e) && (!(isdefined(_s.nospawn) && _s.nospawn) || isdefined(_o_scene._b_testing) && _o_scene._b_testing) || isspawner(_e)) {
            spawn_ent();
            if (isdefined(_e)) {
                _e dontinterpolate();
                _e.scene_spawned = _o_scene._s.name;
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xefb60407, Offset: 0xb88
    // Size: 0x314
    function spawn() {
        self endon(#"new_shot");
        b_skip = (is_actor() || is_vehicle()) && issubstr(_o_scene._str_mode, "noai");
        b_skip = b_skip || is_player() && issubstr(_o_scene._str_mode, "noplayers");
        b_skip = b_skip || !issubstr(_o_scene._str_mode, "single") && !issubstr(_o_scene._str_mode, "init") && !function_ef717ad5(_str_shot) && _str_shot !== "init" && !is_player() && !function_4f5dd9d2() && !function_37103914();
        b_skip = b_skip || function_4df86c86();
        b_skip = b_skip || isdefined(var_5c4adc26) && var_5c4adc26;
        if (!b_skip) {
            _spawn();
            error(!(isdefined(_s.nospawn) && _s.nospawn) && (!isdefined(_e) || isspawner(_e)), "Object failed to spawn or doesn't exist.");
            [[ _o_scene ]]->assign_ent(self, _e);
            if (isdefined(_e)) {
                prepare();
            } else if (isdefined(_s.nospawn) && _s.nospawn) {
                flagsys::set(_str_shot + "stopped");
            }
            return;
        }
        cleanup();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xe35c6963, Offset: 0xaf8
    // Size: 0x84
    function first_init(s_objdef, o_scene) {
        _s = s_objdef;
        _o_scene = o_scene;
        _assign_unique_name();
        if (isdefined(_s.team)) {
            _str_team = util::get_team_mapping(_s.team);
        }
        return self;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc716050, Offset: 0xa68
    // Size: 0x84
    function _reset_values(ent = self._e) {
        reset_ent_val("takedamage", ent);
        reset_ent_val("ignoreme", ent);
        reset_ent_val("allowdeath", ent);
        reset_ent_val("take_weapons", ent);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1e9f3537, Offset: 0x9c0
    // Size: 0x9c
    function _set_values(ent = self._e) {
        set_ent_val("takedamage", isdefined(_s.takedamage) && _s.takedamage, ent);
        set_ent_val("allowdeath", isdefined(_s.allowdeath) && _s.allowdeath, ent);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xc489d7d4, Offset: 0x948
    // Size: 0x6c
    function reset_ent_val(str_key, ent = self._e) {
        if (isdefined(ent)) {
            ent val::reset(_o_scene._str_name + ":" + _str_shot, str_key);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 3, eflags: 0x0
    // Checksum 0x934f90b3, Offset: 0x8c8
    // Size: 0x74
    function set_ent_val(str_key, value, ent = self._e) {
        if (isdefined(ent)) {
            ent val::set(_o_scene._str_name + ":" + _str_shot, str_key, value);
        }
    }

}

// Namespace scene
// Method(s) 72 Total 72
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
    var _str_team;
    var b_play_from_time;
    var b_player_scene;
    var camera_start_time;
    var camera_v_angles;
    var camera_v_origin;
    var n_frame_counter;
    var played_camera_anims;
    var scene_skip_completed;
    var scene_stopping;
    var skipping_scene;
    var var_1b3d0016;
    var var_25d67477;
    var var_4db0451e;
    var var_80cc5e5f;
    var var_8b4558ad;
    var var_c1c449de;
    var var_f8a0cb3c;

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x8
    // Checksum 0x46302663, Offset: 0xb0c0
    // Size: 0x66
    constructor() {
        _a_objects = [];
        _b_testing = 0;
        _n_object_id = 0;
        _str_mode = "";
        _a_streamer_hint = [];
        _a_active_shots = [];
        _a_request_times = [];
        _b_stopped = 0;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x10
    // Checksum 0x9421eac6, Offset: 0xb130
    // Size: 0x24
    destructor() {
        /#
            log("<dev string:x20e>");
        #/
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xb3fb51d8, Offset: 0x12410
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
    // Checksum 0x175053d6, Offset: 0x12350
    // Size: 0xb4
    function error(condition, str_msg) {
        if (condition) {
            if (_b_testing) {
                scene::error_on_screen(str_msg);
            } else {
                assertmsg(_s.type + "<dev string:x1fc>" + function_15979fa9(_str_name) + "<dev string:x47c>" + str_msg);
            }
            thread on_error();
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xbdd9cb12, Offset: 0x122e0
    // Size: 0x64
    function log(str_msg) {
        println(_s.type + "<dev string:x1fc>" + function_15979fa9(_str_name) + "<dev string:x47c>" + str_msg);
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x72cbf5c7, Offset: 0x122b0
    // Size: 0x24
    function remove_object(o_object) {
        arrayremovevalue(_a_objects, o_object);
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1be99915, Offset: 0x12230
    // Size: 0x76
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
    // Checksum 0x938c5168, Offset: 0x12198
    // Size: 0x8e
    function has_player() {
        if (!isdefined(_a_objects)) {
            return false;
        }
        foreach (obj in _a_objects) {
            if ([[ obj ]]->is_player()) {
                return true;
            }
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x647932b4, Offset: 0x120e0
    // Size: 0xae
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
    // Checksum 0x925538a2, Offset: 0x11dd8
    // Size: 0x2fe
    function finish_scene_skipping() {
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                printtoprightln("<dev string:x45c>" + gettime(), (1, 0, 0));
            }
        #/
        if (is_skipping_scene()) {
            /#
                if (getdvarint(#"debug_scene_skip", 0) > 0) {
                    printtoprightln("<dev string:x3b6>" + gettime());
                }
            #/
            if (getdvarint(#"scene_skip_no_fade", 0) == 0) {
                b_skip_fading = 0;
            } else {
                b_skip_fading = 1;
            }
            level util::streamer_wait(undefined, undefined, 10);
            foreach (player in util::get_players(_str_team)) {
                player clientfield::increment_to_player("player_scene_skip_completed");
                player val::reset(#"scene_skip", "freezecontrols");
                player val::reset(#"scene_skip", "takedamage");
                player stopsounds();
            }
            if (!(isdefined(b_skip_fading) && b_skip_fading)) {
                if (!(isdefined(level.level_ending) && level.level_ending) && is_skipping_player_scene()) {
                    foreach (player in util::get_players(_str_team)) {
                        player thread lui::screen_fade_in(1, "black", "scene_system");
                    }
                }
            }
            b_player_scene = undefined;
            skipping_scene = undefined;
            scene_skip_completed = 1;
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x42e8560e, Offset: 0x11648
    // Size: 0x788
    function skip_scene(var_1ab6e149, str_shot = self._a_active_shots[0]) {
        if (!(isdefined(var_1ab6e149) && var_1ab6e149) && isdefined(_s.disablesceneskipping) && _s.disablesceneskipping) {
            /#
                if (getdvarint(#"debug_scene_skip", 0) > 0) {
                    printtoprightln("<dev string:x36f>" + _s.name + "<dev string:x16a>" + gettime(), (1, 0, 0));
                }
            #/
            finish_scene_skipping();
            return;
        }
        if (!(isdefined(var_8b4558ad) && var_8b4558ad)) {
            var_8b4558ad = 1;
            _call_shot_funcs("skip_started");
        }
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                printtoprightln("<dev string:x3a1>" + _s.name + "<dev string:x16a>" + gettime(), (0, 1, 0));
            }
        #/
        if (!(isdefined(var_1ab6e149) && var_1ab6e149)) {
            if (is_skipping_player_scene()) {
                /#
                    if (getdvarint(#"debug_scene_skip", 0) > 0) {
                        printtoprightln("<dev string:x3b6>" + gettime());
                    }
                #/
                if (getdvarint(#"scene_skip_no_fade", 0) == 0) {
                    b_skip_fading = 0;
                } else {
                    b_skip_fading = 1;
                }
                foreach (player in util::get_players(_str_team)) {
                    player val::set(#"scene_skip", "freezecontrols", 1);
                    player val::set(#"scene_skip", "takedamage", 0);
                    if (!(isdefined(b_skip_fading) && b_skip_fading)) {
                        player thread lui::screen_fade_out(0, "black", "scene_system");
                    }
                }
                setpauseworld(0);
            }
        }
        if (!function_1c059f9b(str_shot)) {
            var_590bac22 = 1;
        } else {
            var_590bac22 = 0;
        }
        flagsys::wait_till(str_shot + "go");
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                printtoprightln("<dev string:x3d8>" + _s.name + "<dev string:x16a>" + gettime(), (0, 0, 1));
            }
        #/
        thread _skip_scene();
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                printtoprightln("<dev string:x3f5>" + gettime(), (0, 1, 0));
            }
        #/
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                if (isdefined(level.animation_played)) {
                    for (i = 0; i < level.animation_played.size; i++) {
                        printtoprightln("<dev string:x427>" + level.animation_played[i], (1, 0, 0), -1);
                    }
                }
            }
        #/
        wait_till_shot_finished(str_shot);
        self flagsys::set(#"shot_skip_completed");
        if (!var_590bac22) {
            if (is_skipping_scene()) {
                finish_scene_skipping();
            } else if (isdefined(skipping_scene) && skipping_scene) {
                skipping_scene = undefined;
            }
            /#
                if (getdvarint(#"debug_scene_skip", 0) > 0) {
                    printtoprightln("<dev string:x441>" + _s.name + "<dev string:x16a>" + gettime(), (1, 0.5, 0));
                }
            #/
            _call_shot_funcs("skip_completed");
            if (isdefined(_s.var_7763572c) && _s.var_7763572c && !scene::function_e1e106d2(_str_name)) {
                var_f8a0cb3c = 1;
                self notify(#"hash_63783193d9ac5bfc");
                thread play(var_80cc5e5f, undefined, undefined, "single");
            } else {
                _call_shot_funcs("done");
                flagsys::set(#"scene_skip_completed");
            }
            return;
        }
        if (is_skipping_player_scene()) {
            if (_s scene::is_igc()) {
                foreach (player in util::get_players(_str_team)) {
                    player stopsounds();
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2e13038, Offset: 0x11618
    // Size: 0x26
    function is_scene_shared() {
        if (_s scene::is_igc()) {
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x856c3dfc, Offset: 0x115f8
    // Size: 0x14
    function on_error() {
        stop();
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4fa33213, Offset: 0x11510
    // Size: 0xe0
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
    // Checksum 0x396aedb5, Offset: 0x11358
    // Size: 0x1ae
    function sync_with_other_scenes(str_shot) {
        if (!(isdefined(_s.dontsync) && _s.dontsync) && !is_skipping_scene()) {
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
    // Checksum 0xfec17b7a, Offset: 0x11240
    // Size: 0x10c
    function wait_till_objects_finished(str_shot, &array) {
        for (i = 0; i < array.size; i++) {
            obj = array[i];
            if (isdefined(obj) && !obj flagsys::get(str_shot + "finished") && obj flagsys::get(str_shot + "active") && !obj flagsys::get(str_shot + "stopped")) {
                obj waittill(str_shot + "finished", str_shot + "active", str_shot + "stopped");
                i = -1;
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6691903e, Offset: 0x11208
    // Size: 0x2c
    function wait_till_shot_finished(str_shot) {
        wait_till_objects_finished(str_shot, _a_objects);
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x48693eb8, Offset: 0x110f0
    // Size: 0x10c
    function wait_till_objects_ready(str_shot, &array) {
        for (i = 0; i < array.size; i++) {
            obj = array[i];
            if (isdefined(obj) && !obj flagsys::get(str_shot + "ready") && obj flagsys::get(str_shot + "active") && !obj flagsys::get(str_shot + "stopped")) {
                obj waittill(str_shot + "ready", str_shot + "active", str_shot + "stopped");
                i = -1;
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x64fd83b3, Offset: 0x10fa0
    // Size: 0x148
    function function_ba88e0c5() {
        foreach (obj in _a_objects) {
            if (isdefined(obj._e) && (isbot(obj._e) || isai(obj._e))) {
                if (isbot(obj._e)) {
                    obj._e bot_util::function_aed787dd();
                    obj._e bottakemanualcontrol();
                    continue;
                }
                if (issentient(obj._e)) {
                    obj._e clearforcedgoal();
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x16ae409c, Offset: 0x10e30
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
        function_ba88e0c5();
        if (isdefined(_s.igc) && _s.igc) {
            level flagsys::decrement("waitting_for_igc_ready");
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf1712b6, Offset: 0x10e00
    // Size: 0x28
    function is_looping() {
        return isdefined(_s.looping) && _s.looping;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd92ab2bb, Offset: 0x10c98
    // Size: 0x15a
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
                    error(getdvarint(#"scene_align_errors", 1), str_msg);
                }
            }
        } else if (isdefined(_e_root) && isdefined(_e_root.e_scene_link)) {
            e_align = _e_root.e_scene_link;
        }
        return e_align;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xccdad95f, Offset: 0x10c80
    // Size: 0xa
    function get_root() {
        return _e_root;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8c0dc6be, Offset: 0x10b48
    // Size: 0x130
    function get_ents() {
        a_ents = [];
        if (isdefined(_a_objects)) {
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
        }
        return a_ents;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x6f19574c, Offset: 0x10790
    // Size: 0x3b0
    function _call_shot_funcs(str_shot, b_waittill_go = 0) {
        self endon(str_shot);
        if (b_waittill_go) {
            flagsys::wait_till(str_shot + "go");
        }
        if (str_shot == "done") {
            level notify(_str_notify_name + "_done");
            self notify(#"scene_done");
            function_69b5901f();
        }
        if (str_shot == "stop") {
            self notify(#"scene_stop");
            function_69b5901f();
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
                if (_str_mode === "init" && handler.size > 2) {
                    continue;
                }
                func = handler[0];
                args = handler[1];
                util::function_e54ebad6(_e_root, func, a_ents, args);
            }
        }
        if (isdefined(level.var_26c1b074) && isdefined(level.var_26c1b074[_str_notify_name]) && isdefined(level.var_26c1b074[_str_notify_name][str_shot])) {
            foreach (handler in level.var_26c1b074[_str_notify_name][str_shot]) {
                if (_str_mode === "init" && handler.size > 2) {
                    continue;
                }
                func = handler[0];
                args = handler[1];
                util::single_thread_argarray(_e_root, func, args);
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x845abb3b, Offset: 0x104f8
    // Size: 0x28a
    function stop(b_clear = 0, b_finished = 0) {
        if (_b_stopped || is_skipping_scene()) {
            return;
        }
        /#
        #/
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
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x347>" + _s.name);
            }
            if (isdefined(_e_root) && isdefined(_e_root.last_scene_state_instance)) {
                if (!b_finished) {
                    level.last_scene_state[_str_name] = level.last_scene_state[_str_name] + "<dev string:x366>";
                    _e_root.last_scene_state_instance[_str_name] = _e_root.last_scene_state_instance[_str_name] + "<dev string:x366>";
                }
                if (!isdefined(_e_root.scriptbundlename)) {
                    _e_root notify(#"stop_debug_display");
                }
            }
        #/
        _b_stopped = 1;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xce6384bd, Offset: 0x104d0
    // Size: 0x1a
    function has_init_state() {
        return scene::has_init_state(_str_name);
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x646de832, Offset: 0x100d0
    // Size: 0x3f4
    function run_next(str_current_shot) {
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x310>" + gettime());
            }
        #/
        b_run_next_scene = 0;
        if (has_next_shot(str_current_shot)) {
            if (!_b_stopped) {
                var_18003a30 = is_skipping_scene();
                if (var_18003a30) {
                    var_d889333d = 0;
                    while (!flagsys::get(#"shot_skip_completed") || var_d889333d > 5) {
                        var_d889333d += float(function_f9f48566()) / 1000;
                        waitframe(1);
                    }
                    flagsys::clear(#"shot_skip_completed");
                }
                if (_s.scenetype == "fxanim" && _s.nextscenemode === "init") {
                    if (!error(!has_init_state(), "Scene can't init next scene '" + _s.nextscenebundle + "' because it doesn't have an init state.")) {
                        _e_root thread scene::init(_s.nextscenebundle);
                    }
                } else {
                    if (var_18003a30) {
                        if (is_skipping_player_scene()) {
                            _str_mode = "skip_scene_player";
                        } else {
                            _str_mode = "skip_scene";
                        }
                    } else {
                        b_run_next_scene = 1;
                    }
                    if (has_next_shot(str_current_shot)) {
                        if (isdefined(_s.nextscenebundle)) {
                            _e_root thread scene::play(_s.nextscenebundle, undefined, undefined, _b_testing, _str_mode);
                        } else {
                            var_f636bfe5 = get_next_shot(str_current_shot);
                            /#
                                if (getdvarint(#"debug_scene_skip", 0) > 0 && is_skipping_scene()) {
                                    printtoprightln("<dev string:x324>" + str_current_shot + "<dev string:x16a>" + gettime(), (1, 1, 0));
                                }
                            #/
                            switch (_s.scenetype) {
                            case #"scene":
                                thread play(var_f636bfe5, undefined, _b_testing, _str_mode);
                                break;
                            default:
                                thread play(var_f636bfe5, undefined, _b_testing, _str_mode);
                                break;
                            }
                        }
                    }
                }
            }
            return;
        }
        _call_shot_funcs("sequence_done");
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xea8c66b8, Offset: 0xffa8
    // Size: 0x11c
    function get_next_shot(str_current_shot) {
        var_c93f6cc = function_e8ecb5ad();
        if (isdefined(var_c93f6cc)) {
            return var_c93f6cc;
        }
        if (isdefined(var_1b3d0016)) {
            var_f636bfe5 = var_1b3d0016;
            var_1b3d0016 = undefined;
            return var_f636bfe5;
        }
        a_shots = scene::get_all_shot_names(_str_name);
        foreach (i, str_shot in a_shots) {
            if (str_shot === str_current_shot && isdefined(a_shots[i + 1])) {
                return a_shots[i + 1];
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xbf562f6a, Offset: 0xfe48
    // Size: 0x152
    function has_next_shot(str_current_shot = self._a_active_shots[0]) {
        if (isdefined(var_1b3d0016)) {
            return true;
        }
        if (isdefined(function_e8ecb5ad())) {
            return true;
        }
        if (str_current_shot === "init") {
            return false;
        }
        if (isdefined(_s.nextscenebundle)) {
            return true;
        }
        a_shots = scene::get_all_shot_names(_str_name);
        foreach (i, str_shot in a_shots) {
            if (str_shot === str_current_shot && isdefined(a_shots[i + 1]) && a_shots[i + 1] !== "init") {
                return true;
            }
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x136132f3, Offset: 0xfd98
    // Size: 0xa6
    function function_e8ecb5ad() {
        if (isdefined(_a_objects)) {
            foreach (obj in _a_objects) {
                if (isdefined([[ obj ]]->function_e8ecb5ad())) {
                    var_c93f6cc = [[ obj ]]->function_e8ecb5ad();
                    break;
                }
            }
        }
        return var_c93f6cc;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe967914a, Offset: 0xfd78
    // Size: 0x18
    function scene_skip_completed() {
        return isdefined(scene_skip_completed) && scene_skip_completed;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf473a0ed, Offset: 0xfd40
    // Size: 0x2e
    function is_skipping_player_scene() {
        return isdefined(b_player_scene) && b_player_scene || _str_mode == "skip_scene_player";
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2258ac9c, Offset: 0xfcc0
    // Size: 0x74
    function is_skipping_scene() {
        return (isdefined(skipping_scene) && skipping_scene || _str_mode == "skip_scene" || _str_mode == "skip_scene_player") && !(isdefined(_s.disablesceneskipping) && _s.disablesceneskipping);
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe7f71113, Offset: 0xfbc8
    // Size: 0xec
    function _stop_camera_anim_on_player(player) {
        player endon(#"disconnect");
        if (isstring(_s.cameraswitcher) || ishash(_s.cameraswitcher)) {
            player endon(#"new_camera_switcher");
            player dontinterpolate();
            endcamanimscripted(player);
            player thread scene::scene_enable_player_stuff(_s, undefined, _e_root);
            callback::remove_on_loadout(&_play_camera_anim_on_player_callback, self);
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf8b43325, Offset: 0xfb10
    // Size: 0xb0
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
    // Params 0, eflags: 0x0
    // Checksum 0x190afd80, Offset: 0xfab0
    // Size: 0x58
    function loop_camera_anim_to_set_up_for_capture() {
        level endon(#"stop_camera_anims");
        while (true) {
            _play_camera_anims();
            _wait_for_camera_animation(_s.cameraswitcher);
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 4, eflags: 0x0
    // Checksum 0xb73c7467, Offset: 0xf988
    // Size: 0x11c
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
    // Checksum 0x6e3b92f4, Offset: 0xf940
    // Size: 0x3c
    function _play_camera_anim_on_player_callback(player) {
        self thread _play_camera_anim_on_player(player, camera_v_origin, camera_v_angles, 1);
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x17cea227, Offset: 0xf7d8
    // Size: 0x15c
    function _play_camera_anims() {
        level endon(#"stop_camera_anims");
        e_align = get_align_ent();
        if (!isdefined(e_align)) {
            return;
        }
        v_origin = isdefined(e_align.origin) ? e_align.origin : (0, 0, 0);
        v_angles = isdefined(e_align.angles) ? e_align.angles : (0, 0, 0);
        if (isstring(_s.cameraswitcher) || ishash(_s.cameraswitcher)) {
            callback::on_loadout(&_play_camera_anim_on_player_callback, self);
            camera_v_origin = v_origin;
            camera_v_angles = v_angles;
            camera_start_time = gettime();
            array::thread_all_ents(level.players, &_play_camera_anim_on_player, v_origin, v_angles, 0);
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xfcf9cef, Offset: 0xf730
    // Size: 0x9c
    function _wait_for_camera_animation(str_cam, n_start_time) {
        self endon(#"skip_camera_anims");
        if (iscamanimlooping(str_cam)) {
            level waittill(#"forever");
            return;
        }
        scene::wait_server_time(float(getcamanimtime(str_cam)) / 1000, n_start_time);
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x78bca8c2, Offset: 0xf670
    // Size: 0xb8
    function function_69b5901f() {
        if (isdefined(_a_objects)) {
            foreach (obj in _a_objects) {
                if (isdefined(obj._e) && isbot(obj._e)) {
                    obj._e botreleasemanualcontrol();
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 4, eflags: 0x0
    // Checksum 0x1ac5a853, Offset: 0xdfc0
    // Size: 0x16a6
    function play(str_shot = "play", a_ents, b_testing = 0, str_mode = "") {
        function_8c27cc8a("cScene::play : " + _s.name);
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x29c>" + _s.name);
            }
        #/
        if (str_mode == "single_loop") {
            self notify(#"hash_27297a73bc597607");
        }
        self notify(str_shot + "start");
        self endon(str_shot + "start", #"hash_27297a73bc597607");
        if (_s scene::is_igc()) {
            level flagsys::increment("igc_active");
        }
        if (isdefined(_e_root) && isdefined(_e_root.script_teleport_location)) {
            _e_root teleport::function_8db85ae7();
        }
        if (str_mode == "skip_scene") {
            thread skip_scene(1, str_shot);
        } else if (str_mode == "skip_scene_player") {
            b_player_scene = 1;
            thread skip_scene(1, str_shot);
        }
        _b_testing = b_testing;
        _str_mode = str_mode;
        if (function_1c059f9b(str_shot)) {
            self notify(#"hash_63783193d9ac5bfc");
        }
        if (isdefined(_s.spectateonjoin) && _s.spectateonjoin) {
            level.scene_should_spectate_on_hot_join = 1;
        }
        assign_ents(a_ents);
        self thread sync_with_client_scene(str_shot, b_testing);
        if (issubstr(_str_mode, "play_from_time")) {
            args = strtok(_str_mode, ":");
            if (isdefined(args[1])) {
                var_3fedc2a9 = float(args[1]);
                var_25d67477 = scene::function_3dd10dad(_s, str_shot);
            }
            b_play_from_time = 1;
            _str_mode = "";
            if (issubstr(args[0], "noai")) {
                _str_mode += "noai";
            }
            if (issubstr(args[0], "noplayers")) {
                _str_mode += "noplayers";
            }
        }
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
        if (isdefined(_e_root)) {
            if (!isdefined(_e_root.scenes)) {
                _e_root.scenes = [];
            } else if (!isarray(_e_root.scenes)) {
                _e_root.scenes = array(_e_root.scenes);
            }
            if (!isinarray(_e_root.scenes, self)) {
                _e_root.scenes[_e_root.scenes.size] = self;
            }
        }
        flagsys::clear(str_shot + "ready");
        flagsys::clear(str_shot + "go");
        flagsys::clear(str_shot + "finished");
        set_request_time(str_shot);
        if (!(isdefined(_s.dontsync) && _s.dontsync) && !is_skipping_scene()) {
            add_to_sync_list(str_shot);
        }
        foreach (o_obj in _a_objects) {
            thread [[ o_obj ]]->play(str_shot, var_3fedc2a9);
        }
        /#
            thread function_c840e1e8(str_shot);
            level.last_scene_state[_str_name] = str_shot;
            if (isdefined(_e_root) && isdefined(_e_root.last_scene_state_instance)) {
                _e_root.last_scene_state_instance[_str_name] = str_shot;
                if (!isdefined(level.scene_roots)) {
                    level.scene_roots = [];
                } else if (!isarray(level.scene_roots)) {
                    level.scene_roots = array(level.scene_roots);
                }
                if (!isinarray(level.scene_roots, _e_root)) {
                    level.scene_roots[level.scene_roots.size] = _e_root;
                }
            }
        #/
        wait_till_shot_ready(str_shot);
        self notify(#"hash_60adeaccbb565546");
        remove_from_sync_list(str_shot);
        level flagsys::set(_str_notify_name + "_ready");
        if (isdefined(_e_root)) {
            _e_root flagsys::set(#"scene_ents_ready");
        }
        if (strstartswith(_str_mode, "capture") || _s scene::is_igc() && scene::function_a81ac58a(1)) {
            /#
                depth = getdvarstring(#"hash_3018c0b9207d1c", "<dev string:x2ac>");
                fps = getdvarstring(#"hash_51617678bebb961a", "<dev string:x2ae>");
                fmt = getdvarstring(#"hash_4bf15ae7a6fbf73c", "<dev string:x2b1>");
                if (issubstr(_str_mode, "<dev string:x2b5>") || getdvarint(#"hash_6a54249f0cc48945", 0) == 2 || scene::function_f589f84a(_str_name, str_shot)) {
                    if (issubstr(_str_mode, "<dev string:x2b5>") || getdvarint(#"hash_6a54249f0cc48945", 0) == 2) {
                        var_689ca24d = _str_name + "<dev string:x2bc>" + str_shot;
                    } else {
                        var_689ca24d = _str_name;
                    }
                    level flagsys::set(#"scene_menu_disable");
                    str_command = "<dev string:x2c3>" + depth + "<dev string:x1fc>" + fps + "<dev string:x1fc>" + fmt + "<dev string:x2da>" + _str_name + "<dev string:x1fc>" + var_689ca24d;
                    adddebugcommand("<dev string:x2e5>");
                    adddebugcommand(str_command);
                }
            #/
        }
        if (var_3fedc2a9 === 0) {
            self thread _play_camera_anims();
        }
        if (isdefined(_s.var_7763572c) && _s.var_7763572c && function_1c059f9b(str_shot) && !scene::function_e1e106d2(_str_name)) {
            if (!is_skipping_scene()) {
                thread _call_shot_funcs(str_shot, 1);
                var_4db0451e = undefined;
            }
        } else {
            thread _call_shot_funcs(str_shot, 1);
        }
        if (_s scene::is_igc()) {
            if (isstring(_s.cameraswitcher) || ishash(_s.cameraswitcher)) {
                _wait_for_camera_animation(_s.cameraswitcher, var_3fedc2a9);
            }
        }
        wait_till_shot_finished(str_shot);
        b_play_from_time = undefined;
        if (isdefined(_s.spectateonjoin) && _s.spectateonjoin) {
            level.scene_should_spectate_on_hot_join = undefined;
        }
        if (!(isdefined(var_4db0451e) && var_4db0451e) && (_str_mode != "init" && !(isdefined(var_c1c449de) && var_c1c449de) && function_1c059f9b(str_shot) || isdefined(var_c1c449de) && var_c1c449de && flagsys::get(#"hash_42da41892ac54794"))) {
            if (!is_skipping_scene()) {
                thread _call_shot_funcs("done");
            }
            var_4db0451e = 1;
            if (isdefined(var_f8a0cb3c) && var_f8a0cb3c) {
                self flagsys::set(#"scene_skip_completed");
            }
            if (isdefined(_e_root)) {
                _e_root notify(#"scene_done", {#scenedef:_str_notify_name});
                _e_root scene::function_bff20b0b();
            }
        }
        self notify(str_shot);
        if (issubstr(_str_mode, "single")) {
            self notify(#"hash_3168dab591a18b9b");
        }
        if (str_shot != "init" && _str_mode != "init" && !_b_stopped) {
            if ((is_looping() || _str_mode === "loop") && isdefined(var_4db0451e) && var_4db0451e || _str_mode === "single_loop") {
                var_4db0451e = undefined;
                if (has_init_state()) {
                    thread play("init", undefined, b_testing, str_mode);
                } else if (get_request_time(str_shot) < gettime()) {
                    if (_str_mode === "single_loop") {
                        var_42c66f70 = str_shot;
                    } else {
                        var_42c66f70 = scene::function_d0a1d87d(_str_name, str_mode);
                    }
                    thread play(var_42c66f70, undefined, b_testing, str_mode);
                }
            } else if (!issubstr(_str_mode, "single")) {
                thread run_next(str_shot);
            }
        }
        if (isdefined(_s.spectateonjoin) && _s.spectateonjoin) {
            level.scene_should_spectate_on_hot_join = undefined;
        }
        array::flagsys_wait_clear(_a_objects, str_shot + "active");
        if (!is_skipping_scene() || is_skipping_scene() && scene_skip_completed()) {
            arrayremovevalue(_a_active_shots, str_shot);
        }
        if (!_a_active_shots.size || is_skipping_scene() && scene_skip_completed()) {
            if (isdefined(level.active_scenes[_str_name])) {
                arrayremovevalue(level.active_scenes[_str_name], _e_root);
                if (level.active_scenes[_str_name].size == 0) {
                    level.active_scenes[_str_name] = undefined;
                }
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
                    /#
                        arrayremovevalue(level.scene_roots, _e_root);
                    #/
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
        /#
            if (strstartswith(_str_mode, "<dev string:x2f8>") || _s scene::is_igc() && scene::function_a81ac58a(1)) {
                conv = getdvarstring(#"hash_7b946c8966b56a8e", "<dev string:x2ac>");
                if (issubstr(_str_mode, "<dev string:x2b5>") || function_1c059f9b(str_shot) || getdvarint(#"hash_6a54249f0cc48945", 0) == 2) {
                    level flagsys::clear(#"scene_menu_disable");
                    adddebugcommand("<dev string:x300>" + conv);
                }
            }
        #/
        self notify(#"remove_callbacks");
    }

    // Namespace cscene/scene_objects_shared
    // Params 3, eflags: 0x0
    // Checksum 0xe07aa68b, Offset: 0xde80
    // Size: 0x136
    function get_anim_relative_start_time(animation, n_start_time, b_camera_anim = 0) {
        if (!isdefined(var_25d67477)) {
            return n_start_time;
        }
        if (b_camera_anim) {
            n_anim_length = float(getcamanimtime(animation)) / 1000;
            var_795bdfbf = iscamanimlooping(animation);
        } else {
            n_anim_length = getanimlength(animation);
            var_795bdfbf = isanimlooping(animation);
        }
        var_3bb77b98 = var_25d67477 / n_anim_length * n_start_time;
        if (var_795bdfbf) {
            if (var_3bb77b98 > 0.95) {
                var_3bb77b98 = 0.95;
            }
        } else if (var_3bb77b98 > 0.99) {
            var_3bb77b98 = 0.99;
        }
        return var_3bb77b98;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x70c75b61, Offset: 0xdca0
    // Size: 0x1d8
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
    // Checksum 0x81f48e08, Offset: 0xdc50
    // Size: 0x44
    function _is_ent_vehicle(ent, str_team) {
        return isvehicle(ent) || isvehiclespawner(ent);
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x571c467c, Offset: 0xdc00
    // Size: 0x44
    function _is_ent_actor(ent, str_team) {
        return isactor(ent) || isactorspawner(ent);
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xdb9edcd0, Offset: 0xdb80
    // Size: 0x78
    function _is_ent_companion(ent, str_team) {
        if (isarray(level.heroes) && isinarray(level.heroes, ent) && scene::check_team(ent.team, str_team)) {
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0xf0de9378, Offset: 0xdb28
    // Size: 0x4c
    function _is_ent_player(ent, str_team) {
        return isplayer(ent) && scene::check_team(ent.team, str_team);
    }

    // Namespace cscene/scene_objects_shared
    // Params 5, eflags: 0x0
    // Checksum 0x47622b3, Offset: 0xd9b0
    // Size: 0x16e
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
    // Checksum 0x7d3dab6d, Offset: 0xd5d0
    // Size: 0x3d6
    function _assign_ents_by_name(&a_objects, &a_ents) {
        if (a_ents.size) {
            foreach (str_name, e_ent in arraycopy(a_ents)) {
                foreach (i, o_obj in arraycopy(a_objects)) {
                    if (isdefined(o_obj._s.name)) {
                        if (isint(str_name) && (isdefined(o_obj._s.name) ? "" + o_obj._s.name : "") == (isdefined(str_name) ? "" + str_name : "") || !isint(str_name) && hash(o_obj._s.name) == str_name || e_ent.script_animname === (isdefined(o_obj._s.name) ? "" + o_obj._s.name : "") || e_ent.animname === (isdefined(o_obj._s.name) ? "" + o_obj._s.name : "") || e_ent.targetname === (isdefined(o_obj._s.name) ? "" + o_obj._s.name : "")) {
                            assign_ent(o_obj, e_ent);
                            arrayremovevalue(a_ents, e_ent, 1);
                            arrayremoveindex(a_objects, i);
                            break;
                        }
                    }
                }
            }
            /#
                foreach (i, ent in a_ents) {
                    error(isstring(i) || ishash(i), "<dev string:x27d>" + i + "<dev string:x299>");
                }
            #/
        }
        return a_ents.size;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x3a51d46b, Offset: 0xd540
    // Size: 0x82
    function assign_ent(o_obj, ent) {
        o_obj._e = ent;
        if (isdefined(_e_root)) {
            if (!isdefined(_e_root.scene_ents)) {
                _e_root.scene_ents = [];
            }
            _e_root.scene_ents[o_obj._str_name] = o_obj._e;
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe5132694, Offset: 0xd0d0
    // Size: 0x468
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
                    if (_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player, #"team3")) {
                        if (_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player)) {
                            if (_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion, "teama")) {
                                if (_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion, "teamb")) {
                                    if (_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion, #"team3")) {
                                        if (_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion)) {
                                            if (_assign_ents_by_type(a_objects, a_ents, "actor", &_is_ent_actor)) {
                                                if (_assign_ents_by_type(a_objects, a_ents, "fakeactor", &_is_ent_actor)) {
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
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x3cb1b82d, Offset: 0xcf20
    // Size: 0x1a4
    function sync_with_client_scene(str_shot, b_test_run = 0) {
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
                default:
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
                default:
                    n_val = 2;
                    break;
                }
            }
            level clientfield::set(_s.name, n_val);
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x42d2c014, Offset: 0xcf00
    // Size: 0x16
    function get_object_id() {
        _n_object_id++;
        return _n_object_id;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x93b733a4, Offset: 0xcd80
    // Size: 0x178
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
    // Checksum 0x8598a820, Offset: 0xcb90
    // Size: 0x1e2
    function new_object(str_type) {
        switch (str_type) {
        case #"prop":
            return new cscenemodel();
        case #"model":
            return new cscenemodel();
        case #"vehicle":
            return new cscenevehicle();
        case #"actor":
            return new csceneactor();
        case #"fakeactor":
            return new cscenefakeactor();
        case #"player":
            return new csceneplayer();
        case #"sharedplayer":
            return new cscenesharedplayer();
        case #"fakeplayer":
            return new cscenefakeplayer();
        case #"companion":
            return new cscenecompanion();
        case #"sharedcompanion":
            return new cscenesharedcompanion();
        default:
            error(0, "Unsupported object type '" + str_type + "'.");
            break;
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x88114c2c, Offset: 0xca60
    // Size: 0x124
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
    // Checksum 0xbf2954da, Offset: 0xc8d0
    // Size: 0x186
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
    // Checksum 0x2e9d440, Offset: 0xc8b0
    // Size: 0x18
    function get_request_time(str_shot) {
        return _a_request_times[str_shot];
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7c8deddb, Offset: 0xc888
    // Size: 0x1e
    function set_request_time(str_shot) {
        _a_request_times[str_shot] = gettime();
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x33ee1764, Offset: 0xc750
    // Size: 0x12c
    function function_71a1e3d(s_instance, s_obj) {
        if (_s.devstate === "placeholder" && isdefined(s_instance.target)) {
            var_492648c1 = struct::get_array(s_instance.target, "targetname");
            foreach (struct in var_492648c1) {
                if (isdefined(struct.script_animname) && tolower(struct.script_animname) === tolower(s_obj.name)) {
                    s_obj.var_c1096750 = 1;
                    return struct;
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x588bb115, Offset: 0xc678
    // Size: 0xca
    function function_6c1e56c1(s_obj) {
        str_type = tolower(s_obj.type);
        switch (str_type) {
        case #"specialist":
            str_type = "companion";
            break;
        case #"sharedspecialist":
            str_type = "sharedcompanion";
            break;
        default:
            break;
        }
        if (isdefined(s_obj.var_b4f500cc) && s_obj.var_b4f500cc) {
            str_type = "fakeactor";
        }
        return str_type;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb8cf89e2, Offset: 0xc5f0
    // Size: 0x7e
    function function_2d250cc6(s_obj) {
        if (s_obj.type === "player" || s_obj.type === "sharedplayer" || s_obj.type === "companion" || s_obj.type === "sharedcompanion") {
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7467163f, Offset: 0xc448
    // Size: 0x1a0
    function function_4dc29701(s_obj) {
        if (function_2d250cc6(s_obj) || isdefined(s_obj.var_c1096750) && s_obj.var_c1096750) {
            return;
        }
        if (isdefined(s_obj.shots)) {
            foreach (s_shot in s_obj.shots) {
                if (s_shot.name === "init") {
                    continue;
                }
                if (!isdefined(s_shot.entry) && !isdefined(s_shot.var_55495d64) && !isdefined(s_shot.var_3c905c80) && !isdefined(s_shot.cleanuphide) && !isdefined(s_shot.cleanupshow) && !isdefined(s_shot.cleanupdelete) && !isdefined(s_shot.var_9d526525) && !isdefined(s_shot.var_bf20e513)) {
                    arrayremovevalue(s_obj.shots, s_shot, 1);
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x84f69119, Offset: 0xc428
    // Size: 0x18
    function function_1c059f9b(str_shot) {
        return str_shot === var_80cc5e5f;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x9dad3d75, Offset: 0xc290
    // Size: 0x18a
    function function_554bddc2(var_a7c336ab, s_shot) {
        if (!isdefined(s_shot)) {
            return undefined;
        }
        if (isarray(s_shot.entry)) {
            foreach (s_entry in s_shot.entry) {
                if (isdefined(s_entry.cameraswitcher)) {
                    var_ef577702 = s_entry.cameraswitcher;
                }
            }
        }
        if (isarray(var_a7c336ab.entry)) {
            foreach (s_entry in var_a7c336ab.entry) {
                if (isdefined(s_entry.cameraswitcher)) {
                    var_80fbd604 = s_entry.cameraswitcher;
                }
            }
        }
        if (isdefined(var_80fbd604) && var_80fbd604 !== var_ef577702) {
            return var_80fbd604;
        }
        return undefined;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x1f9a8e6, Offset: 0xc0e8
    // Size: 0x19a
    function function_aad3f9b4(var_a7c336ab, s_shot) {
        if (!isdefined(s_shot)) {
            return undefined;
        }
        if (isarray(s_shot.entry)) {
            foreach (s_entry in s_shot.entry) {
                if (isdefined(s_entry.("anim"))) {
                    var_5c1b73c8 = s_entry.("anim");
                }
            }
        }
        if (isarray(var_a7c336ab.entry)) {
            foreach (s_entry in var_a7c336ab.entry) {
                if (isdefined(s_entry.("anim"))) {
                    var_121fe5f6 = s_entry.("anim");
                }
            }
        }
        if (isdefined(var_121fe5f6) && var_121fe5f6 !== var_5c1b73c8) {
            return var_121fe5f6;
        }
        return undefined;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x900ecb1c, Offset: 0xbd90
    // Size: 0x34a
    function function_1f1fee68(obj, var_90a08110) {
        if (!isdefined(var_90a08110.specialistname)) {
            return;
        }
        var_2345adf8 = array("vehicle", "prop", "actor");
        if (!isinarray(var_2345adf8, obj.type) && obj.type === var_90a08110.type || isinarray(var_2345adf8, obj.type) && obj.name === var_90a08110.name) {
            foreach (n_shot, var_a7c336ab in var_90a08110.shots) {
                var_6f5dfee0 = var_90a08110.specialistname;
                if (!isdefined(obj.var_dbcb4dde)) {
                    obj.var_dbcb4dde = [];
                }
                var_121fe5f6 = function_aad3f9b4(var_a7c336ab, obj.shots[n_shot]);
                if (var_90a08110.type == "sharedplayer" || var_90a08110.type == "player") {
                    var_80fbd604 = function_554bddc2(var_a7c336ab, obj.shots[n_shot]);
                }
                if (isdefined(var_121fe5f6)) {
                    if (!isdefined(obj.var_dbcb4dde[n_shot])) {
                        obj.var_dbcb4dde[n_shot] = [];
                    }
                    if (!isdefined(obj.var_dbcb4dde[n_shot][var_6f5dfee0])) {
                        obj.var_dbcb4dde[n_shot][var_6f5dfee0] = spawnstruct();
                    }
                    obj.var_dbcb4dde[n_shot][var_6f5dfee0].var_121fe5f6 = var_121fe5f6;
                }
                if (isdefined(var_80fbd604)) {
                    if (!isdefined(obj.var_dbcb4dde[n_shot])) {
                        obj.var_dbcb4dde[n_shot] = [];
                    }
                    if (!isdefined(obj.var_dbcb4dde[n_shot][var_6f5dfee0])) {
                        obj.var_dbcb4dde[n_shot][var_6f5dfee0] = spawnstruct();
                    }
                    obj.var_dbcb4dde[n_shot][var_6f5dfee0].var_80fbd604 = var_80fbd604;
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x0
    // Checksum 0x473cfdbd, Offset: 0xbc70
    // Size: 0x114
    function function_b4124768(obj, var_de63d86e) {
        if (isarray(var_de63d86e) && var_de63d86e.size) {
            foreach (var_c56c2a97 in var_de63d86e) {
                foreach (var_90a08110 in var_c56c2a97.objects) {
                    function_1f1fee68(obj, var_90a08110);
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 5, eflags: 0x0
    // Checksum 0xc5ada563, Offset: 0xb720
    // Size: 0x546
    function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run) {
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x26d>" + str_scenedef);
            }
        #/
        s_scenedef scene::function_ea9f6e24();
        s_scenedef.var_88029ab6 = scene::function_f80af16d(str_scenedef);
        var_80cc5e5f = s_scenedef.var_88029ab6;
        _s = s_scenedef;
        _str_name = str_scenedef;
        _b_testing = b_test_run;
        _str_team = util::get_team_mapping(_s.team);
        _a_streamer_hint[#"allies"] = isdefined(_s.var_eb92591f) ? _s.var_eb92591f : _s.streamerhintteama;
        _a_streamer_hint[#"axis"] = isdefined(_s.var_798ae9e4) ? _s.var_798ae9e4 : _s.streamerhintteamb;
        _str_notify_name = isstring(_s.malebundle) || ishash(_s.malebundle) ? _s.malebundle : _str_name;
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        var_de63d86e = scene::function_a5a6992f(_s);
        if (!error(a_ents.size > _s.objects.size, "Trying to use more entities than scene supports.")) {
            _e_root = e_align;
            a_objs = get_valid_object_defs();
            foreach (s_obj in a_objs) {
                s_obj.type = function_6c1e56c1(s_obj);
                if (isdefined(s_obj.name) && (_e_root.classname === "scriptbundle_scene" || _e_root.classname === "scriptbundle_fxanim") && isdefined(_e_root.target)) {
                    if (!isdefined(_e_root.var_bd5791b1)) {
                        _e_root.var_bd5791b1 = [];
                    }
                    _e_root.var_bd5791b1[s_obj.name] = function_71a1e3d(_e_root, s_obj);
                }
                function_b4124768(s_obj, var_de63d86e);
                function_4dc29701(s_obj);
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
                    level.last_scene_state[_str_name] = "<dev string:x202>";
                }
                if (!isdefined(_e_root.last_scene_state_instance[_str_name])) {
                    _e_root.last_scene_state_instance[_str_name] = "<dev string:x202>";
                }
            #/
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x82699b64, Offset: 0xb160
    // Size: 0x5b4
    function function_c840e1e8(str_shot) {
        /#
            self notify(#"hash_763a7354c3aaff58");
            self endon(#"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_763a7354c3aaff58");
            if (_b_testing) {
                var_bc5e7c16 = 0;
                var_425e77f3 = scene::function_a2174d35(_str_name);
                a_shots = scene::get_all_shot_names(_str_name, 1);
                foreach (str_shot_name in _s.a_str_shot_names) {
                    if (str_shot_name != str_shot) {
                        var_bc5e7c16 += ceil(scene::function_3dd10dad(_s, str_shot_name) * 30);
                        continue;
                    }
                    break;
                }
                n_frame_counter = var_bc5e7c16;
                while (true) {
                    if (getdvarint(#"hash_67caa056eba27a53", 0) == 0 || !isdefined(_a_objects)) {
                        waitframe(1);
                        continue;
                    }
                    v_pos = (1350, 195, 0);
                    var_e453c6e6 = var_425e77f3 * n_frame_counter / ceil(var_425e77f3 * 30);
                    var_92f9511c = "<dev string:x21e>" + n_frame_counter + "<dev string:x235>" + ceil(var_425e77f3 * 30) + "<dev string:x237>" + var_e453c6e6 + "<dev string:x235>" + var_425e77f3 + "<dev string:x247>";
                    debug2dtext(v_pos, var_92f9511c, undefined, undefined, undefined, 1, 0.8);
                    v_pos += (0, 20, 0) * 2;
                    foreach (obj in _a_objects) {
                        if (!isdefined(obj._e) || !isdefined(obj._str_current_anim)) {
                            continue;
                        }
                        if (str_shot !== obj._str_shot) {
                            continue;
                        }
                        animation = obj._str_current_anim;
                        if (!isdefined(animation) || !isassetloaded("<dev string:xfa>", animation)) {
                            continue;
                        }
                        var_11b4901b = getanimframecount(animation);
                        var_773d59c3 = ceil(obj._e getanimtime(animation) * var_11b4901b);
                        var_62f1cd48 = getanimlength(animation);
                        var_9e296f0f = obj._e getanimtime(animation) * var_62f1cd48;
                        var_3044e748 = obj._str_name + "<dev string:x24b>" + function_15979fa9(animation);
                        var_a24c5683 = "<dev string:x253>" + str_shot + "<dev string:x25a>" + var_773d59c3 + "<dev string:x235>" + var_11b4901b + "<dev string:x263>" + var_9e296f0f + "<dev string:x235>" + var_62f1cd48 + "<dev string:x247>";
                        debug2dtext(v_pos, var_3044e748, undefined, undefined, undefined, 1, 0.8);
                        v_pos += (0, 20, 0);
                        debug2dtext(v_pos, var_a24c5683, undefined, undefined, undefined, 1, 0.8);
                        v_pos += (0, 20, 0) * 1.25;
                        n_frame_counter = var_bc5e7c16 + var_773d59c3;
                    }
                    waitframe(1);
                }
            }
        #/
    }

}

// Namespace scene/scene_objects_shared
// Params 1, eflags: 0x0
// Checksum 0xcb7d357f, Offset: 0x7a8
// Size: 0x56
function prepare_player_model_anim(ent) {
    if (!(ent.animtree === "all_player")) {
        ent useanimtree("all_player");
        ent.animtree = "all_player";
    }
}

// Namespace scene/scene_objects_shared
// Params 1, eflags: 0x0
// Checksum 0x44512f8f, Offset: 0x808
// Size: 0x56
function prepare_generic_model_anim(ent) {
    if (!(ent.animtree === "generic")) {
        ent useanimtree("generic");
        ent.animtree = "generic";
    }
}

