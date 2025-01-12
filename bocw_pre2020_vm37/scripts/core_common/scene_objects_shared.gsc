#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
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
// Method(s) 106 Total 106
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
    var var_1f97724a;
    var var_2a306f8a;
    var var_4819ae76;
    var var_55b4f21e;
    var var_84ca3312;
    var var_acbd43ee;
    var var_efc540b6;
    var var_f4b34dc1;

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x9 linked
    // Checksum 0xde86d644, Offset: 0x8c0
    // Size: 0x36
    constructor() {
        _b_first_frame = 0;
        _b_active_anim = 0;
        _n_blend = 0;
        var_84ca3312 = "linear";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x11 linked
    // Checksum 0xb27c835b, Offset: 0x900
    // Size: 0x24
    destructor() {
        /#
            log("<dev string:x38>");
        #/
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x234cf33f, Offset: 0x8468
    // Size: 0x46
    function is_actor() {
        return _s.type === "actor" && !is_true(_s.var_615b1f16);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcffdb4e7, Offset: 0x8630
    // Size: 0x4a
    function in_a_different_scene() {
        return isdefined(_e) && isdefined(_e.current_scene) && _e.current_scene != _o_scene._str_name;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x80f724d1, Offset: 0x1d40
    // Size: 0x4
    function function_d09b043() {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf3b155af, Offset: 0x3478
    // Size: 0x34
    function function_ee94f77() {
        function_dd4f74e1();
        function_587971b6();
        function_ebbbd00d();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xfe0d43ef, Offset: 0x51c8
    // Size: 0xce
    function function_1205d1f0() {
        if (isdefined(_e.var_5b7900ec)) {
            var_50b24637 = 0;
            foreach (var_74f5d118 in _e.var_5b7900ec) {
                if (var_74f5d118) {
                    var_50b24637++;
                    if (var_50b24637 == _e.var_5b7900ec.size) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf7e0f91f, Offset: 0x5a78
    // Size: 0x224
    function function_128f0294(s_shot, var_37fa9b04) {
        str_mod = var_37fa9b04.mod;
        switch (str_mod) {
        case #"mod_rifle_bullet":
        case #"mod_pistol_bullet":
            if (is_true(s_shot.var_163ca9fa) || is_true(s_shot.var_b3dddfd3)) {
                return true;
            }
            break;
        case #"mod_explosive":
        case #"mod_grenade":
        case #"mod_grenade_splash":
            if (is_true(s_shot.var_dbd0fa6f) || is_true(s_shot.var_b3dddfd3)) {
                return true;
            }
            break;
        case #"mod_projectile":
        case #"mod_projectile_splash":
            if (is_true(s_shot.var_650063ca) || is_true(s_shot.var_b3dddfd3)) {
                return true;
            }
            break;
        case #"mod_melee_weapon_butt":
        case #"mod_melee":
            if (is_true(s_shot.var_efd784b6) || is_true(s_shot.var_b3dddfd3)) {
                return true;
            }
            break;
        default:
            if (is_true(s_shot.var_b3dddfd3)) {
                return true;
            }
            break;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xfe909a1, Offset: 0x4948
    // Size: 0x32c
    function function_14f96d6b() {
        _e endoncallback(&function_20f309bf, #"delete", #"scene_stop", #"stop_tracking_damage_scene_ent");
        _o_scene endon(#"scene_done", #"scene_stop", #"hash_42da41892ac54794");
        _e setcandamage(1);
        function_23575fad();
        _o_scene.var_2bc31f02 = 1;
        foreach (s_shot in _s.shots) {
            if (s_shot.name === "init") {
                _e.var_5b7900ec[s_shot.name] = 1;
                continue;
            }
            if (function_f12c5e67(s_shot)) {
                _e.var_5b7900ec[s_shot.name] = 0;
            }
        }
        if (is_true(_s.var_2baad8fc)) {
            _e util::function_5d36c37a();
        }
        while (true) {
            flag::set(#"waiting_for_damage");
            var_37fa9b04 = _e waittill(#"damage", #"death");
            if (!isdefined(_e)) {
                return;
            }
            if (isdefined(_e.n_health)) {
                waittillframeend();
            }
            foreach (s_shot in _s.shots) {
                function_72f549e0(s_shot, var_37fa9b04);
            }
            if (is_true(_e.var_4819ae76)) {
                return;
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x80f724d1, Offset: 0x7de0
    // Size: 0x4
    function _spawn_ent() {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x4781eb70, Offset: 0x8ec0
    // Size: 0x168
    function error(condition, str_msg) {
        if (condition) {
            str_msg = "[ " + _o_scene._str_name + " ][ " + (isdefined("unknown shot") ? "" + "unknown shot" : isdefined(_str_shot) ? "" + _str_shot : "") + " ] " + (isdefined("no name") ? "" + "no name" : isdefined(_s.name) ? "" + _s.name : "") + ": " + str_msg;
            if (is_true(_o_scene._b_testing)) {
                /#
                    scene::error_on_screen(str_msg);
                #/
            } else {
                assertmsg(str_msg);
            }
            thread [[ _o_scene ]]->on_error();
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6aedd70d, Offset: 0x3ec0
    // Size: 0x27c
    function cleanup() {
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x20b>" + (isdefined(_s.name) ? _s.name : _s.model));
            }
        #/
        function_fda037ff();
        if (flag::get(_str_shot + "active") && !flag::get(#"waiting_for_damage")) {
            b_finished = flag::get(_str_shot + "finished");
            b_stopped = flag::get(_str_shot + "stopped");
            if (isdefined(_e) && !isplayer(_e)) {
                _e sethighdetail(0);
                function_638ad737(_str_shot);
            }
            _cleanup();
            if (isdefined(_e) && !isplayer(_e)) {
                _e._scene_object = undefined;
                _e.current_scene = undefined;
                _e.anim_debug_name = undefined;
                _e flag::clear(#"scene");
            }
            if (is_alive()) {
                _reset_values();
            }
        }
        flag::clear(_str_shot + "active");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9ee0d46, Offset: 0x23f0
    // Size: 0x304
    function function_1e19d813() {
        if (isdefined(_o_scene._e_root)) {
            _o_scene._e_root notify(#"hash_4e8860ad89fcf927", {#var_fbd6d50c:_e, #str_scene:_o_scene._str_name});
        }
        if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.target)) {
            var_c17a3b30 = getnode(_o_scene._e_root.target, "targetname");
            if (isdefined(var_c17a3b30) && is_true(var_c17a3b30.interact_node)) {
                var_c17a3b30.var_31c05612 = 1;
            }
        }
        if (is_true(_s.var_d318cc2c)) {
            if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.scene_played)) {
                foreach (str_shot in _o_scene.var_5a2219f0) {
                    _o_scene._e_root.scene_played[str_shot] = 1;
                }
            }
            if (isdefined(_o_scene._a_objects)) {
                foreach (obj in _o_scene._a_objects) {
                    if (isdefined(obj._e) && obj._s.type === "prop") {
                        obj._e animation::stop();
                        [[ obj ]]->function_2f4c1d30(obj._e);
                    }
                }
            }
            thread [[ _o_scene ]]->stop();
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3c6565a1, Offset: 0x4520
    // Size: 0xd4
    function function_2035b6d6(_e) {
        _e notify(#"cleanupdelete");
        _e endon(#"death", #"preparedelete", #"cleanupdelete");
        s_waitresult = _o_scene waittilltimeout(0.15, #"hash_60adeaccbb565546", #"scene_stop", #"scene_done", #"scene_skip_completed");
        _e thread scene::synced_delete(_o_scene._str_name);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x58ffabb, Offset: 0x8328
    // Size: 0x1c
    function function_209522a0() {
        return _s.type === "playeroutfit";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x80f724d1, Offset: 0x4600
    // Size: 0x4
    function _cleanup() {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x36f62215, Offset: 0x4c80
    // Size: 0x6c
    function function_20f309bf(str_notify) {
        if (str_notify == "stop_tracking_damage_scene_ent" || str_notify == "delete") {
            if (isdefined(_scene_object)) {
                var_4819ae76 = 1;
                health = 0;
                _scene_object thread function_ea176ba9();
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 7, eflags: 0x1 linked
    // Checksum 0xbc71f53e, Offset: 0x6fc8
    // Size: 0x76c
    function _play_anim(animation, n_rate, n_blend, var_b2e32ae2, n_time, var_7d32b2c6, paused) {
        n_lerp = isdefined(var_7d32b2c6) ? var_7d32b2c6 : get_lerp_time();
        if (_e.scene_spawned === _o_scene._s.name || _o_scene._s scene::is_igc()) {
            if (n_lerp == 0) {
                _e dontinterpolate();
            }
            _e flag::set(#"hash_7cddd51e45d3ff3e");
        }
        function_a04fb5f4();
        if (![[ _o_scene ]]->has_next_shot() && !function_27898329(animation)) {
            n_blend_out = isai(_e) ? 0.2 : 0;
        } else {
            n_blend_out = 0;
        }
        if (is_true(_s.diewhenfinished) || is_true(var_55b4f21e.diewhenfinished)) {
            n_blend_out = 0;
        }
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x245>" + (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:x277>" + animation);
            }
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                if (!isdefined(level.animation_played)) {
                    level.animation_played = [];
                    animation_played_name = (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:x277>" + animation;
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
        if (is_true(_s.var_69aabff2)) {
            b_unlink_after_completed = 0;
        }
        if (function_5c2a9efa()) {
            if (isactor(_e) && isassetloaded("xanim", "chicken_dance_placeholder_loop")) {
                _e thread animation::play(animation, _e, m_tag, n_rate, n_blend, n_blend_out, n_lerp, n_time, _s.showweaponinfirstperson);
            }
            function_5c082667();
        } else if (is_true(_s.issiege)) {
            _e animation::play_siege(animation, n_rate);
        } else {
            _e animation::play(animation, m_align, m_tag, n_rate, n_blend, n_blend_out, n_lerp, n_time, _s.showweaponinfirstperson, b_unlink_after_completed, var_f4b34dc1, paused, undefined, var_b2e32ae2, _s.showviewmodel);
            var_f4b34dc1 = undefined;
        }
        if (!isdefined(_e) || !_e isplayinganimscripted()) {
            current_playing_anim[_n_ent_num] = undefined;
        }
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                log(toupper(_s.type) + "<dev string:x27e>" + function_9e72a96(animation) + "<dev string:x28e>");
                printtoprightln("<dev string:x29b>" + (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:x277>" + animation);
            }
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                if (isdefined(level.animation_played)) {
                    for (i = 0; i < level.animation_played.size; i++) {
                        animation_played_name = (isdefined(_s.name) ? _s.name : _s.model) + "<dev string:x277>" + animation;
                        if (level.animation_played[i] == animation_played_name) {
                            arrayremovevalue(level.animation_played, animation_played_name);
                            i--;
                        }
                    }
                }
            }
        #/
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9edf21aa, Offset: 0x5e00
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
    // Params 0, eflags: 0x1 linked
    // Checksum 0xfd5888c6, Offset: 0x5728
    // Size: 0x25e
    function function_23575fad() {
        if (isdefined(_s.var_873368a8)) {
            _e.script_health = _s.var_873368a8;
            if (isdefined(_e.n_health)) {
                _e.n_health = _s.var_873368a8;
                _e.var_f2ca854b = _e.n_health;
                if (!isdefined(_e.maxhealth)) {
                    _e.maxhealth = _e.n_health;
                }
            } else {
                _e.health = _s.var_873368a8;
                if (!isdefined(_e.maxhealth)) {
                    _e.maxhealth = _e.health;
                }
            }
        }
        if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.script_health)) {
            _e.script_health = _o_scene._e_root.script_health;
            if (isdefined(_e.n_health)) {
                _e.n_health = _e.script_health;
                _e.var_f2ca854b = _e.script_health;
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
    // Params 0, eflags: 0x1 linked
    // Checksum 0x841360d6, Offset: 0x5d40
    // Size: 0xb6
    function restore_saved_ent() {
        if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.scene_ents) && !is_true(_o_scene._e_root.script_ignore_active_scene_check)) {
            if (isdefined(_o_scene._e_root.scene_ents[_str_name])) {
                _e = _o_scene._e_root.scene_ents[_str_name];
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1ea3a4ee, Offset: 0x20b0
    // Size: 0x3e
    function function_24f8cfb5(str_shot) {
        return str_shot === _o_scene.var_232738b3 && _o_scene._str_mode !== "init";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x61bae6c1, Offset: 0x1fb0
    // Size: 0xf6
    function function_27898329(str_current_anim) {
        if (isarray(var_55b4f21e.entry) && var_55b4f21e.entry.size > 1) {
            for (i = 0; i < var_55b4f21e.entry.size; i++) {
                if (var_55b4f21e.entry[i].anim === str_current_anim && isdefined(var_55b4f21e.entry[i + 1]) && isdefined(var_55b4f21e.entry[i + 1].anim)) {
                    return true;
                }
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa7515b1f, Offset: 0x8af8
    // Size: 0x204
    function skip_animation_on_server() {
        if (isdefined(current_playing_anim[_n_ent_num])) {
            if (is_shared_player()) {
                foreach (player in [[ _func_get ]](_str_team)) {
                    /#
                        if (getdvarint(#"debug_scene_skip", 0) > 0) {
                            printtoprightln("<dev string:x2f4>" + current_playing_anim[player getentitynumber()] + "<dev string:x277>" + gettime(), (0.8, 0.8, 0.8));
                        }
                    #/
                    skip_anim_on_server(player, current_playing_anim[player getentitynumber()]);
                }
                return;
            }
            /#
                if (getdvarint(#"debug_scene_skip", 0) > 0) {
                    printtoprightln("<dev string:x2f4>" + current_playing_anim[_n_ent_num] + "<dev string:x277>" + gettime(), (0.8, 0.8, 0.8));
                }
            #/
            skip_anim_on_server(_e, current_playing_anim[_n_ent_num]);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x96483620, Offset: 0x3860
    // Size: 0x7c
    function run_wait(wait_time) {
        wait_start_time = 0;
        while (wait_start_time < wait_time && !is_skipping_scene()) {
            wait_start_time += float(function_60d95f53()) / 1000;
            waitframe(1);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x30a2708f, Offset: 0x8118
    // Size: 0xa6
    function is_alive() {
        if (is_true(function_4de466fd())) {
            return true;
        }
        return isdefined(_e) && (!isai(_e) || isalive(_e)) && !is_true(_e.isdying);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x327e76f5, Offset: 0x2700
    // Size: 0xd4
    function function_2f4c1d30(ent = self._e) {
        v_force = (isdefined(_s.var_9ecb812d) ? _s.var_9ecb812d : 0, isdefined(_s.var_7bd2bb58) ? _s.var_7bd2bb58 : 0, isdefined(_s.var_6e141fdb) ? _s.var_6e141fdb : 0);
        if (v_force != (0, 0, 0)) {
            ent physicslaunch(ent.origin, v_force);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 3, eflags: 0x1 linked
    // Checksum 0xd1f03b81, Offset: 0x5ec8
    // Size: 0x102
    function function_376c9d87(var_ec50a0d3, n_movement, player) {
        if (player adsbuttonpressed()) {
            return _str_current_anim;
        }
        if (var_ec50a0d3.var_9532f6db == "move_up" || var_ec50a0d3.var_9532f6db == "move_right") {
            if (n_movement >= 0) {
                return _str_current_anim;
            } else {
                return var_55b4f21e.var_33a3e73c;
            }
        } else if (var_ec50a0d3.var_9532f6db == "move_down" || var_ec50a0d3.var_9532f6db == "move_left") {
            if (n_movement <= 0) {
                return _str_current_anim;
            } else {
                return var_55b4f21e.var_33a3e73c;
            }
        }
        return _str_current_anim;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x174069e8, Offset: 0x36f0
    // Size: 0xc8
    function function_37c00617() {
        if (isdefined(_o_scene._a_objects)) {
            foreach (obj in _o_scene._a_objects) {
                if (isdefined(obj) && [[ obj ]]->is_player()) {
                    obj flag::wait_till_clear("camera_playing");
                }
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8e73b4c2, Offset: 0x8218
    // Size: 0x72
    function function_3919a776() {
        if (_o_scene._str_mode === "init" && (is_true(_s.var_686939) || is_true(_s.var_f9a5853f))) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 3, eflags: 0x1 linked
    // Checksum 0x7825f9bc, Offset: 0x6028
    // Size: 0x20
    function animation_lookup(animation, *ent, *b_camera) {
        return b_camera;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x68c32b66, Offset: 0x80e0
    // Size: 0x2c
    function function_3e22944e() {
        return _o_scene._e_root.var_1505fed6[_s.name];
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb01e6445, Offset: 0x3a90
    // Size: 0x194
    function function_47bd9bac(actor, str_shot) {
        assert(isactor(actor));
        assert(isstring(str_shot));
        actor endon(#"death");
        str_animation = get_animation_name(str_shot);
        n_shot = get_shot(str_shot);
        s_shot = _s.shots[n_shot];
        if (!isdefined(s_shot)) {
            return;
        }
        disablearrivals = is_true(_s.disablearrivalinreach) || is_true(s_shot.var_1956ecbb);
        if (s_shot.var_ea2f9e66 === "moving") {
            disablearrivals = 1;
        }
        actor animation::reach(str_animation, get_align_ent(), get_align_tag(), disablearrivals, undefined, s_shot.var_8d3cc141);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe068bc86, Offset: 0x80b0
    // Size: 0x22
    function function_48382a1c() {
        return is_true(_s.var_50f52c5b);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x43af41bc, Offset: 0x1800
    // Size: 0x38c
    function function_4b3d4226() {
        if (!isdefined(var_55b4f21e)) {
            return;
        }
        if (isdefined(var_55b4f21e.var_3cd248f5)) {
            a_ents = getentarray(var_55b4f21e.var_3cd248f5, "targetname", 1);
            array::thread_all(a_ents, &val::set, #"script_hide", "hide", 1);
        } else if (isdefined(var_55b4f21e.var_b94164e)) {
            a_ents = getentarray(var_55b4f21e.var_b94164e, "targetname", 1);
            array::thread_all(a_ents, &val::reset, #"script_hide", "hide");
        }
        if (!isdefined(_e)) {
            return;
        }
        if (is_true(var_55b4f21e.preparedelete) && !isplayer(_e)) {
            _e notify(#"preparedelete");
            _e scene::synced_delete(_o_scene._str_name);
            return;
        }
        if (is_true(var_55b4f21e.var_7e4647c3) && _str_shot != "init") {
            _e.scene_orig_origin = _e.origin;
            _e connectpaths();
        } else if (is_true(var_55b4f21e.var_6d2f3193)) {
            _e disconnectpaths(2, 1);
        }
        if (is_true(var_55b4f21e.preparehide)) {
            _e notify(#"preparehide");
            _e val::set(#"scene", "hide", 2);
            return;
        }
        if (is_true(var_55b4f21e.prepareshow) || is_true(_o_scene._b_testing) && scene::function_6a0b0afe(_o_scene._str_mode)) {
            _e notify(#"prepareshow");
            _e val::reset(#"scene", "hide");
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x28cc3fe5, Offset: 0x81c8
    // Size: 0x44
    function function_4de466fd() {
        return is_true(_s.ignorealivecheck) || is_true(_e.ignorealivecheck);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 3, eflags: 0x1 linked
    // Checksum 0xa51d761b, Offset: 0x930
    // Size: 0x74
    function set_ent_val(str_key, value, ent = self._e) {
        if (isdefined(ent)) {
            ent val::set(_o_scene._str_name + ":" + _str_shot, str_key, value);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x44b6cc51, Offset: 0x8378
    // Size: 0x2e
    function function_527113ae() {
        return is_player() && !is_shared_player();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x58e315de, Offset: 0xa28
    // Size: 0x9c
    function _set_values(ent = self._e) {
        set_ent_val("takedamage", is_true(_s.takedamage), ent);
        set_ent_val("allowdeath", is_true(_s.allowdeath), ent);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xaf259add, Offset: 0x3558
    // Size: 0x6e
    function function_587971b6() {
        _n_blend = isdefined(var_55b4f21e.blend) ? var_55b4f21e.blend : 0;
        var_84ca3312 = isdefined(var_55b4f21e.blendcurve) ? var_55b4f21e.blendcurve : "linear";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbe85066e, Offset: 0x7f90
    // Size: 0x58
    function get_lerp_time() {
        n_lerp_time = isdefined(var_55b4f21e.lerptime) ? var_55b4f21e.lerptime : _s.lerptime;
        return isdefined(n_lerp_time) ? n_lerp_time : 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd589de33, Offset: 0x7740
    // Size: 0x2fc
    function function_5c082667() {
        s_start_spot = function_3e22944e();
        if (!isdefined(s_start_spot.target)) {
            _e waittill(#"player_downed", #"death", #"scene_stop");
            return;
        }
        _e endon(#"death", #"scene_stop");
        s_current_struct = struct::get(s_start_spot.target);
        n_move_time = isdefined(s_start_spot.script_float) ? s_start_spot.script_float : 1;
        while (isdefined(s_current_struct)) {
            if (!isdefined(_e.var_645ab05a)) {
                _e.var_acbd43ee = util::spawn_model("tag_origin", _e.origin, _e.angles);
                _e linkto(_e.var_acbd43ee);
                _e thread function_98561e95();
            }
            _e.var_acbd43ee moveto(s_current_struct.origin, n_move_time);
            _e.var_acbd43ee rotateto(s_current_struct.angles, n_move_time);
            _e.var_acbd43ee waittill(#"movedone");
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
        if (isdefined(_e.var_acbd43ee)) {
            _e.var_acbd43ee delete();
        }
        _e unlink();
        _e animation::stop();
        _e notify(#"hash_456b12fb28128d17");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdcdb0583, Offset: 0x7ff0
    // Size: 0xb8
    function function_5c2a9efa() {
        if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.var_1505fed6)) {
            a_str_keys = getarraykeys(_o_scene._e_root.var_1505fed6);
            if (isdefined(_s.name) && isinarray(a_str_keys, hash(_s.name))) {
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x74306fae, Offset: 0x38e8
    // Size: 0x19c
    function scene_reach() {
        if (!isactor(_e) && !isbot(_e)) {
            return;
        }
        b_do_reach = (is_true(_s.doreach) || is_true(var_55b4f21e.var_a8e01b92) || is_true(var_55b4f21e.var_1956ecbb)) && (!is_true(_o_scene._b_testing) || getdvarint(#"scene_test_with_reach", 0));
        if (b_do_reach) {
            self val::reset(#"scene", "hide");
            function_47bd9bac(_e, var_55b4f21e.name);
            function_9e4b3920();
        }
        flag::set(_str_shot + "ready");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5bbbd535, Offset: 0x27e0
    // Size: 0x174
    function function_638ad737(str_shot) {
        if (isdefined(_e) && !isplayer(_e) && !is_true(_e.isdying) && is_true(_s.deletewhenfinished)) {
            if (str_shot != "init" && function_b260bdcc(str_shot) && !function_b52254e6()) {
                _e thread scene::synced_delete(_o_scene._str_name);
                return;
            }
            if (str_shot != "init" && function_b52254e6() && is_true(_o_scene.var_d84cc502)) {
                _e thread scene::synced_delete(_o_scene._str_name);
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9e355c3f, Offset: 0x8508
    // Size: 0x120
    function in_this_scene(ent) {
        foreach (obj in _o_scene._a_objects) {
            if (isplayer(ent)) {
                if (is_shared_player()) {
                    return false;
                }
                if (function_527113ae() && !function_71b7c9e3(ent)) {
                    return false;
                }
                if (obj._e === ent) {
                    return true;
                }
                continue;
            }
            if (obj._e === ent) {
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x693e1b9e, Offset: 0x88e0
    // Size: 0x20c
    function skip_animation_on_client() {
        if (isdefined(current_playing_anim[_n_ent_num])) {
            if (is_shared_player()) {
                foreach (player in [[ _func_get ]](_str_team)) {
                    /#
                        if (getdvarint(#"debug_scene_skip", 0) > 0) {
                            printtoprightln("<dev string:x2cd>" + current_playing_anim[player getentitynumber()] + "<dev string:x277>" + gettime(), (0.8, 0.8, 0.8));
                        }
                    #/
                    skip_anim_on_client(player, current_playing_anim[player getentitynumber()]);
                }
            } else {
                /#
                    if (getdvarint(#"debug_scene_skip", 0) > 0) {
                        printtoprightln("<dev string:x2cd>" + current_playing_anim[_n_ent_num] + "<dev string:x277>" + gettime(), (0.8, 0.8, 0.8));
                    }
                #/
                skip_anim_on_client(_e, current_playing_anim[_n_ent_num]);
            }
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xea827eed, Offset: 0x83b0
    // Size: 0xb0
    function function_71b7c9e3(player) {
        foreach (obj in _o_scene._a_objects) {
            if (obj._e === player && [[ obj ]]->function_527113ae()) {
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xc1298f5e, Offset: 0x4cf8
    // Size: 0x4c4
    function function_72f549e0(s_shot, var_37fa9b04) {
        if (!isdefined(_e)) {
            return false;
        }
        if (is_true(_e.var_5b7900ec[s_shot.name])) {
            return false;
        }
        if (!function_128f0294(s_shot, var_37fa9b04)) {
            return false;
        }
        var_f506eca3 = 0;
        if (!isdefined(s_shot.damagethreshold) && !is_true(s_shot.var_132c9791)) {
            var_f506eca3 = 1;
        }
        if (var_f506eca3) {
            var_f2059ab8 = 0;
            var_520e99b5 = 0;
        } else {
            if (is_true(s_shot.var_132c9791)) {
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
            if (isdefined(_e.var_f2ca854b)) {
                var_f2ca854b = _e.var_f2ca854b;
            } else {
                var_f2ca854b = _e.maxhealth;
            }
            var_f2059ab8 = n_current_health / var_f2ca854b;
            var_520e99b5 = s_shot.damagethreshold;
        }
        if (!is_true(_s.var_a1c5c678)) {
            b_dead = var_f2059ab8 <= 0;
            if (isdefined(var_37fa9b04.attacker)) {
                var_37fa9b04.attacker util::show_hit_marker(b_dead);
            }
        }
        if (var_f2059ab8 <= var_520e99b5) {
            _e.var_68ade67d = 1;
            _e notify(#"hash_4d265bbfcf0b6b4b", {#str_shot:s_shot.name, #str_scene:_o_scene._str_name, #var_37fa9b04:var_37fa9b04, #var_859dbb7c:var_f2059ab8, #var_d2b5cb6a:var_520e99b5});
            level notify(#"hash_4d265bbfcf0b6b4b", {#var_f2dfc31f:_e, #str_shot:s_shot.name, #str_scene:_o_scene._str_name, #var_37fa9b04:var_37fa9b04, #var_859dbb7c:var_f2059ab8, #var_d2b5cb6a:var_520e99b5});
            if (isdefined(_o_scene._e_root)) {
                _o_scene._e_root notify(#"hash_4d265bbfcf0b6b4b", {#var_f2dfc31f:_e, #str_shot:s_shot.name, #str_scene:_o_scene._str_name, #var_37fa9b04:var_37fa9b04, #var_859dbb7c:var_f2059ab8, #var_d2b5cb6a:var_520e99b5});
            }
            _e.var_5b7900ec[s_shot.name] = 1;
            thread [[ _o_scene ]]->play(s_shot.name, undefined, undefined, "single");
            if (function_1205d1f0()) {
                _e setcandamage(0);
                thread function_b485ee21(s_shot, var_37fa9b04);
            }
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb5f96dd1, Offset: 0x21e8
    // Size: 0x9c
    function function_730a4c60(str_shot) {
        foreach (s_shot in _s.shots) {
            if (str_shot === s_shot.name) {
                return s_shot;
            }
        }
        return undefined;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd81a155d, Offset: 0x4610
    // Size: 0x24e
    function get_align_ent() {
        e_align = undefined;
        if (isdefined(var_55b4f21e.aligntarget) && !is_true(var_55b4f21e.var_ab59a015)) {
            var_690ec5fb = var_55b4f21e.aligntarget;
        } else if (isdefined(_s.aligntarget) && _s.aligntarget !== _o_scene._s.aligntarget) {
            var_690ec5fb = _s.aligntarget;
        }
        if (isdefined(var_690ec5fb)) {
            a_scene_ents = [[ _o_scene ]]->get_ents();
            if (isdefined(a_scene_ents[var_690ec5fb])) {
                e_align = a_scene_ents[var_690ec5fb];
            } else {
                e_align = scene::get_existing_ent(var_690ec5fb, 0, 1, _o_scene._str_name);
            }
            if (!isdefined(e_align)) {
                str_msg = "Align target '" + (isdefined(var_690ec5fb) ? "" + var_690ec5fb : "") + "' doesn't exist for scene object " + (isdefined(_str_name) ? "" + _str_name : "") + " in shot named " + (isdefined(_str_shot) ? "" + _str_shot : "");
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
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7c85ad95, Offset: 0x8d78
    // Size: 0x2c
    function skip_scene(b_wait_one_frame) {
        if (isdefined(b_wait_one_frame)) {
            waitframe(1);
        }
        skip_scene_shot_animations();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x25f4895f, Offset: 0x9030
    // Size: 0xc4
    function warning(condition, str_msg) {
        if (condition) {
            str_msg = "[ " + _o_scene._str_name + " ] " + (isdefined("no name") ? "" + "no name" : isdefined(_s.name) ? "" + _s.name : "") + ": " + str_msg;
            /#
                scene::warning_on_screen(str_msg);
            #/
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcbf6e582, Offset: 0x8d08
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
    // Params 4, eflags: 0x1 linked
    // Checksum 0xca0fdd6a, Offset: 0x6050
    // Size: 0x6e2
    function play_anim(animation, b_camera_anim = 0, var_e052b59a = 0, n_start_time = 0) {
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                if (isdefined(_s.name)) {
                    printtoprightln("<dev string:x226>" + _s.name);
                } else {
                    printtoprightln("<dev string:x226>" + _s.model);
                }
            }
        #/
        if (_b_first_frame || var_e052b59a) {
            n_rate = 0;
        } else {
            n_rate = 1;
        }
        if (n_rate > 0) {
            _o_scene flag::wait_till(_str_shot + "go");
        }
        if (!is_shared_player()) {
            animation = animation_lookup(animation, undefined, b_camera_anim);
        }
        if (b_camera_anim) {
            _str_camera = animation;
        } else {
            _str_current_anim = animation;
        }
        if (_should_skip_anim(animation)) {
            return;
        }
        if (function_b52254e6() && !function_f12c5e67(var_55b4f21e) && _o_scene._str_mode !== "init") {
            _e notify(#"stop_tracking_damage_scene_ent");
        }
        if (is_alive()) {
            update_alignment();
            n_time = n_start_time;
            if (n_time != 0) {
                n_time = [[ _o_scene ]]->get_anim_relative_start_time(animation, n_time, b_camera_anim);
            }
            if (scene::function_a63b9bca(_o_scene._str_name)) {
                n_time = 0.99;
                _o_scene.n_start_time = 0.99;
            }
            if (isactor(_e) && isdefined(var_55b4f21e.var_bd5fe690) && _e ai::has_behavior_attribute("demeanor")) {
                _e ai::set_behavior_attribute("demeanor", var_55b4f21e.var_bd5fe690);
            }
            if (function_5c2a9efa()) {
                _play_anim(animation, n_rate, _n_blend, var_84ca3312, n_time);
                _b_active_anim = 0;
                _dynamic_paths();
            } else if (var_e052b59a) {
                flag::set(#"scene_interactive_shot_active");
                n_rate = 0;
                n_time = 0;
                thread _play_anim(animation, n_rate, _n_blend, var_84ca3312, n_time);
                _b_active_anim = 1;
            } else if (b_camera_anim) {
                thread play_camera(_str_camera, n_time);
            } else if (_b_first_frame) {
                thread _play_anim(animation, n_rate, _n_blend, var_84ca3312, n_time);
                _b_first_frame = 0;
                _b_active_anim = 1;
            } else if (isanimlooping(animation)) {
                if (_str_shot === "init" || scene::function_6a0b0afe(_o_scene._str_mode)) {
                    thread _play_anim(animation, n_rate, _n_blend, var_84ca3312, n_time);
                    _b_active_anim = 1;
                } else {
                    if (function_b260bdcc(_str_shot)) {
                        if (isdefined(_o_scene._e_root)) {
                            _o_scene._e_root notify(#"scene_done", {#str_scenedef:_o_scene._str_name});
                        }
                        _e notify(#"scene_done", {#str_scenedef:_o_scene._str_name});
                    }
                    _play_anim(animation, n_rate, _n_blend, var_84ca3312, n_time);
                    _b_active_anim = 0;
                }
            } else {
                _play_anim(animation, n_rate, _n_blend, var_84ca3312, n_time);
                _b_active_anim = 0;
                _dynamic_paths();
            }
            if (is_alive() && isactor(_e)) {
                if (isdefined(var_55b4f21e.var_2d86d11f)) {
                    var_179fae19 = _e function_8536906e(var_55b4f21e.var_2d86d11f);
                    _e asmrequestsubstate(var_179fae19);
                    _e function_af554597(animation);
                }
            }
            _blend = 0;
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3f917721, Offset: 0x3e28
    // Size: 0x8c
    function _stop(b_dont_clear_anim = 0) {
        if (isalive(_e)) {
            _e notify(#"scene_stop");
            if (!b_dont_clear_anim) {
                _e animation::stop(0.2);
                function_2f4c1d30(_e);
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x45d07155, Offset: 0x6740
    // Size: 0x1f6
    function function_8536906e(var_2d86d11f) {
        if (!isdefined(level.var_66c9b8dc)) {
            level.var_66c9b8dc = [];
            level.var_66c9b8dc[#"moving"][#"patrol"] = "move@patrol";
            level.var_66c9b8dc[#"moving"][#"alert"] = "move@alert";
            level.var_66c9b8dc[#"moving"][#"cqb"] = "move@cqb_locomotion";
            level.var_66c9b8dc[#"moving"][#"combat"] = "move@locomotion";
            level.var_66c9b8dc[#"idle"][#"patrol"] = "idle@patrol";
            level.var_66c9b8dc[#"idle"][#"alert"] = "idle@alert";
            level.var_66c9b8dc[#"idle"][#"cqb"] = "idle@exposed";
            level.var_66c9b8dc[#"idle"][#"combat"] = "idle@exposed";
        }
        if (ai::has_behavior_attribute("demeanor")) {
            var_5207b7a8 = ai::get_behavior_attribute("demeanor");
            return level.var_66c9b8dc[var_2d86d11f][var_5207b7a8];
        }
        return "idle@exposed";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa326120f, Offset: 0x1b98
    // Size: 0x19c
    function _prepare() {
        if (issentient(_e)) {
            if (is_true(_s.overrideaicharacter)) {
                _e detachall();
                _e setmodel(_s.model);
            }
        } else if (_s.type === "actor") {
            if (!error(_e.classname !== "script_model", "makeFakeAI must be applied to a script_model")) {
                _e makefakeai();
            }
            if (!is_true(_s.removeweapon)) {
                _e animation::attach_weapon(getweapon(#"ar_accurate_t9"));
            }
        }
        set_objective();
        if (is_true(_s.dynamicpaths)) {
            _e disconnectpaths(2);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf4c0b893, Offset: 0x3d00
    // Size: 0x11c
    function stop(b_clear = 0, b_dont_clear_anim = 0) {
        self notify(#"new_shot");
        if (isdefined(_str_shot)) {
            flag::set(_str_shot + "stopped");
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
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7c78073e, Offset: 0xc40
    // Size: 0x37c
    function spawn() {
        self endon(#"new_shot");
        b_skip = !function_e0df299e(_str_shot) && _o_scene._str_mode !== "init" && !scene::function_6a0b0afe(_o_scene._str_mode) && _str_shot !== "init" && !is_player() && !function_48382a1c();
        b_skip = b_skip || function_3919a776();
        b_skip = b_skip || is_true(var_1f97724a);
        b_skip = b_skip || (is_actor() || is_vehicle()) && issubstr(_o_scene._str_mode, "noai");
        b_skip = b_skip || is_player() && issubstr(_o_scene._str_mode, "noplayers");
        b_skip = b_skip || is_player() && !function_209522a0() && !function_e0df299e(_str_shot) && _o_scene._str_mode !== "init" && scene::function_6a0b0afe(_o_scene._str_mode);
        if (!b_skip) {
            _spawn();
            error(!is_true(_s.nospawn) && (!isdefined(_e) || isspawner(_e)), "Object failed to spawn or doesn't exist.");
            [[ _o_scene ]]->assign_ent(self, _e);
            if (isdefined(_e)) {
                prepare();
            } else if (is_true(_s.nospawn)) {
                flag::set(_str_shot + "stopped");
            }
            return;
        }
        cleanup();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd516cd44, Offset: 0x6940
    // Size: 0x4d6
    function update_alignment() {
        m_align = get_align_ent();
        m_tag = get_align_tag();
        var_2dd2901f = (isdefined(_o_scene._s.var_922b4fc5) ? _o_scene._s.var_922b4fc5 : 0, isdefined(_o_scene._s.var_3e692842) ? _o_scene._s.var_3e692842 : 0, isdefined(_o_scene._s.var_be60a82b) ? _o_scene._s.var_be60a82b : 0);
        var_acf1be3a = (isdefined(_o_scene._s.var_16999a5d) ? _o_scene._s.var_16999a5d : 0, isdefined(_o_scene._s.var_29563fd6) ? _o_scene._s.var_29563fd6 : 0, isdefined(_o_scene._s.var_eb00c330) ? _o_scene._s.var_eb00c330 : 0);
        var_24a7cd13 = (isdefined(_s.var_922b4fc5) ? _s.var_922b4fc5 : 0, isdefined(_s.var_3e692842) ? _s.var_3e692842 : 0, isdefined(_s.var_be60a82b) ? _s.var_be60a82b : 0);
        var_75cdf4bd = (isdefined(_s.var_16999a5d) ? _s.var_16999a5d : 0, isdefined(_s.var_29563fd6) ? _s.var_29563fd6 : 0, isdefined(_s.var_eb00c330) ? _s.var_eb00c330 : 0);
        var_2a3b0294 = (isdefined(var_55b4f21e.var_922b4fc5) ? var_55b4f21e.var_922b4fc5 : 0, isdefined(var_55b4f21e.var_3e692842) ? var_55b4f21e.var_3e692842 : 0, isdefined(var_55b4f21e.var_be60a82b) ? var_55b4f21e.var_be60a82b : 0);
        var_f3bd6699 = (isdefined(var_55b4f21e.var_16999a5d) ? var_55b4f21e.var_16999a5d : 0, isdefined(var_55b4f21e.var_29563fd6) ? var_55b4f21e.var_29563fd6 : 0, isdefined(var_55b4f21e.var_eb00c330) ? var_55b4f21e.var_eb00c330 : 0);
        var_d3c21d73 = var_2dd2901f + var_2a3b0294 + var_24a7cd13;
        v_ang_offset = var_acf1be3a + var_f3bd6699 + var_75cdf4bd;
        if (m_align == level) {
            m_align = (0, 0, 0) + var_d3c21d73;
            m_tag = (0, 0, 0) + v_ang_offset;
            return;
        }
        if (!isentity(m_align) && (var_d3c21d73 != (0, 0, 0) || v_ang_offset != (0, 0, 0))) {
            v_pos = m_align.origin + var_d3c21d73;
            v_ang = m_align.angles + v_ang_offset;
            m_align = {#origin:v_pos, #angles:v_ang};
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8116e767, Offset: 0xb60
    // Size: 0xd4
    function first_init(s_objdef, o_scene) {
        _s = s_objdef;
        _o_scene = o_scene;
        _assign_unique_name();
        if (isdefined(_s.team)) {
            _str_team = util::get_team_mapping(_s.team);
        }
        if (is_true(_s.var_1af33af1) && !isdefined(_o_scene.var_58e5d094)) {
            _o_scene.var_58e5d094 = self;
        }
        return self;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbcee06b5, Offset: 0x37c0
    // Size: 0x94
    function _dynamic_paths() {
        if (isdefined(_e) && is_true(_s.dynamicpaths)) {
            if (distance2dsquared(_e.origin, _e.scene_orig_origin) > 4) {
                _e disconnectpaths(2, 0);
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9d177f7f, Offset: 0x7a48
    // Size: 0x6c
    function function_98561e95() {
        self endon(#"hash_456b12fb28128d17");
        var_9f5994d7 = var_acbd43ee;
        self waittill(#"death", #"scene_stop");
        if (isdefined(var_9f5994d7)) {
            var_9f5994d7 delete();
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xba5b2ca4, Offset: 0x4418
    // Size: 0xfc
    function function_9960f8f0(_e) {
        _e notify(#"cleanuphide");
        _e endon(#"death", #"prepareshow", #"preparehide", #"cleanuphide");
        if (_o_scene._str_mode !== "init") {
            _o_scene waittilltimeout(0.15, #"hash_60adeaccbb565546", #"scene_stop", #"scene_done", #"scene_skip_completed");
        }
        _e val::set(#"scene", "hide", 2);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8f2fa779, Offset: 0x84e0
    // Size: 0x1c
    function function_9a6b1e3f() {
        return _s.type === "prop";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8215c101, Offset: 0x8350
    // Size: 0x1c
    function is_shared_player() {
        return _s.type === "sharedplayer";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8265575b, Offset: 0x1170
    // Size: 0x688
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
        var_55b4f21e = function_730a4c60(_str_shot);
        if (is_true(_s.dynamicpaths) && _str_shot != "init") {
            _e.scene_orig_origin = _e.origin;
            _e connectpaths();
        }
        if (!isai(_e) && !isplayer(_e)) {
            if (!is_player()) {
                if (isdefined(var_55b4f21e)) {
                    var_55b4f21e.devstate = undefined;
                }
                if (is_player_model()) {
                    scene::prepare_player_model_anim(_e);
                } else {
                    scene::prepare_generic_model_anim(_e);
                }
            }
        }
        if (!is_player()) {
            _set_values();
            _e.anim_debug_name = _s.name;
            _e.current_scene = _o_scene._str_name;
            _e flag::set(#"scene");
        }
        if (_e.classname == "script_model") {
            if (isdefined(_o_scene._e_root.modelscale)) {
                _e setscale(_o_scene._e_root.modelscale);
            }
        }
        if (is_true(_s.takedamage)) {
            foreach (s_shot in _s.shots) {
                if (function_9a6b1e3f() && function_f12c5e67(s_shot) && !function_b52254e6()) {
                    var_2a306f8a = 1;
                    _e.var_2a306f8a = 1;
                    thread function_14f96d6b();
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
        if (is_true(_s.allowdeath)) {
            thread function_d09b043();
        }
        if (function_5c2a9efa()) {
            s_start_spot = function_3e22944e();
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
        function_4b3d4226();
        scene_reach();
        flag::set(_str_shot + "ready");
        flag::clear(_str_shot + "finished");
        return 1;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x46a24a68, Offset: 0x3c30
    // Size: 0xc4
    function function_9e4b3920() {
        if (isdefined(_e) && (isbot(_e) || isai(_e))) {
            if (isbot(_e)) {
                _e bot_util::function_23cbc6c1(_e.origin, 1);
                return;
            }
            _e setgoal(_e.origin, 1);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3cc50b8f, Offset: 0x22e8
    // Size: 0x4c
    function function_9ec459a2() {
        if (isdefined(var_55b4f21e.var_64c0ee5a) && isdefined(_e)) {
            _e setmodel(var_55b4f21e.var_64c0ee5a);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd45e2a6c, Offset: 0x2140
    // Size: 0x9c
    function get_shot(str_shot) {
        foreach (n_shot, s_shot in _s.shots) {
            if (str_shot === s_shot.name) {
                return n_shot;
            }
        }
        return undefined;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3b7e4f0b, Offset: 0x6e20
    // Size: 0x19c
    function function_a04fb5f4() {
        if (_o_scene._s scene::is_igc() || [[ _o_scene ]]->has_player()) {
            if (function_527113ae()) {
                _e setvisibletoall();
                return;
            }
            if (!isplayer(_e)) {
                _e setinvisibletoall();
                if (_o_scene._str_team === "any" || is_true(_o_scene._b_testing)) {
                    _e setvisibletoall();
                    return;
                }
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
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7ac6f423, Offset: 0x5fd8
    // Size: 0x44
    function function_a808aac7() {
        if (isdefined(var_55b4f21e.var_33a3e73c) && var_efc540b6 === var_55b4f21e.var_33a3e73c) {
            return 1;
        }
        return 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x46288604, Offset: 0x84b8
    // Size: 0x1c
    function is_vehicle() {
        return _s.type === "vehicle";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xe14a779c, Offset: 0x8818
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
    // Params 1, eflags: 0x1 linked
    // Checksum 0x931fb2e9, Offset: 0x20f8
    // Size: 0x3e
    function function_b260bdcc(str_shot) {
        return str_shot === _o_scene.var_355308d8 && _o_scene._str_mode !== "init";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x10fe72eb, Offset: 0x5480
    // Size: 0x2a0
    function function_b485ee21(s_shot, var_37fa9b04) {
        _e notify(#"hash_b02076d93b34558");
        _e endon(#"hash_b02076d93b34558", #"delete", #"scene_stop");
        var_5b7900ec = _e.var_5b7900ec;
        foreach (var_74f5d118 in var_5b7900ec) {
            while (!var_74f5d118) {
                waitframe(1);
            }
        }
        _e.var_4819ae76 = 1;
        thread function_ea176ba9();
        if (isdefined(_e)) {
            _e notify(#"hash_18be12558bc58fe", {#str_shot:s_shot.name, #str_scene:_o_scene._str_name, #var_37fa9b04:var_37fa9b04, #var_5cd2f3ce:_str_name});
            _e.health = 0;
        }
        if (isdefined(_o_scene._e_root)) {
            _o_scene._e_root notify(#"hash_5bb6862842cacfe8", {#var_b551c535:_e, #var_5cd2f3ce:_str_name, #str_shot:s_shot.name, #var_37fa9b04:var_37fa9b04});
        }
        level notify(#"hash_4d265bbfcf0b6b4b", {#str_shot:s_shot.name, #str_scene:_o_scene._str_name});
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7f6edda6, Offset: 0x5990
    // Size: 0x26
    function function_b52254e6() {
        if (is_true(var_2a306f8a)) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x42b81e09, Offset: 0x1d50
    // Size: 0x144
    function get_animation_name(_str_shot, var_b8995d3f = 0) {
        n_shot = get_shot(_str_shot);
        if (isdefined(n_shot) && isdefined(_s.shots[n_shot].entry)) {
            foreach (s_entry in _s.shots[n_shot].entry) {
                if (isdefined(s_entry.anim)) {
                    if (var_b8995d3f) {
                        str_animation = s_entry.anim;
                    } else {
                        str_animation = animation_lookup(s_entry.anim, undefined, 0);
                    }
                    return str_animation;
                }
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x90c3b2cb, Offset: 0x8688
    // Size: 0x102
    function _should_skip_anim(animation) {
        if (is_true(_s.deletewhenfinished) && is_skipping_scene() && !is_player() && !is_true(_s.keepwhileskipping)) {
            if (!animhasimportantnotifies(animation)) {
                if (!isspawner(_e)) {
                    e = scene::get_existing_ent(_str_name, undefined, undefined, _o_scene._str_name);
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
    // Params 2, eflags: 0x1 linked
    // Checksum 0xc1e5dd73, Offset: 0x2960
    // Size: 0xb0c
    function play(str_shot = "play", n_start_time) {
        n_shot = get_shot(str_shot);
        if (!isdefined(n_shot) && !has_streamer_hint()) {
            /#
                if (level flag::get("<dev string:x4c>")) {
                    var_320710a9 = "<dev string:x5a>" + str_shot + "<dev string:x65>" + _str_name + "<dev string:x77>" + function_9e72a96(_o_scene._str_name);
                    iprintln(var_320710a9);
                    println(var_320710a9);
                }
            #/
            flag::set(str_shot + "ready");
            flag::set(str_shot + "finished");
            function_638ad737(str_shot);
            return;
        }
        self notify(#"new_shot");
        self endon(#"new_shot");
        flag::set(str_shot + "active");
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
        var_55b4f21e = _s.shots[n_shot];
        flag::clear(_str_shot + "stopped");
        flag::clear(_str_shot + "finished");
        flag::clear(_str_shot + "ready");
        flag::set(_str_shot + "active");
        spawn();
        function_f0e3e344();
        if (is_true(var_55b4f21e.var_51093f2d)) {
            waitframe(1);
        } else if (function_5c2a9efa()) {
            function_ee94f77();
            play_anim("chicken_dance_placeholder_loop", 0, undefined, n_start_time);
        } else {
            var_e1c809d = var_55b4f21e.entry;
            function_ee94f77();
            if (is_player()) {
                var_3f83c458 = array("cameraswitcher", "anim");
            } else {
                var_3f83c458 = array("anim");
            }
            foreach (str_entry_type in var_3f83c458) {
                if (!is_alive() || function_3919a776() || !isarray(var_e1c809d)) {
                    break;
                }
                foreach (s_entry in var_e1c809d) {
                    entry = s_entry.(str_entry_type);
                    if (isdefined(entry)) {
                        switch (str_entry_type) {
                        case #"cameraswitcher":
                            /#
                                if (ishash(entry)) {
                                    error(!isassetloaded("<dev string:xb2>", entry), "<dev string:xba>" + function_9e72a96(entry) + "<dev string:xc3>");
                                } else {
                                    error(!isassetloaded("<dev string:xb2>", entry), "<dev string:xba>" + entry + "<dev string:xc3>");
                                }
                            #/
                            var_aa49b05f = 1;
                            play_anim(entry, 1, undefined, n_start_time);
                            break;
                        case #"anim":
                            /#
                                if (is_true(_s.issiege)) {
                                    if (ishash(entry)) {
                                        error(!isassetloaded("<dev string:x111>", entry), "<dev string:x11a>" + function_9e72a96(entry) + "<dev string:x124>");
                                    } else {
                                        error(!isassetloaded("<dev string:x111>", entry), "<dev string:x11a>" + entry + "<dev string:x17d>");
                                    }
                                } else if (ishash(entry)) {
                                    error(!isassetloaded("<dev string:x1d5>", entry), "<dev string:x1de>" + function_9e72a96(entry) + "<dev string:xc3>");
                                } else {
                                    error(!isassetloaded("<dev string:x1d5>", entry), "<dev string:x1de>" + entry + "<dev string:xc3>");
                                }
                            #/
                            var_aa49b05f = 1;
                            play_anim(entry, 0, is_true(var_55b4f21e.interactiveshot), n_start_time);
                            break;
                        default:
                            /#
                                error(1, "<dev string:x1e8>" + str_entry_type + "<dev string:x205>");
                            #/
                            break;
                        }
                    }
                }
            }
            if (!is_true(var_aa49b05f)) {
                waitframe(1);
                if (function_b260bdcc(_str_shot)) {
                    _b_active_anim = 0;
                }
            }
            var_aa49b05f = 0;
        }
        function_9ec459a2();
        if (is_player()) {
            function_37c00617();
        }
        flag::wait_till_clear("scene_interactive_shot_active");
        if (!_o_scene._b_testing) {
            flag::wait_till_clear("waiting_for_damage");
        }
        if (is_true(_o_scene.var_2bc31f02) && is_true(_o_scene.var_d84cc502)) {
            _o_scene flag::set(#"hash_42da41892ac54794");
        }
        if (is_alive()) {
            flag::set(_str_shot + "finished");
            if (is_true(_s.diewhenfinished) && function_b260bdcc(_str_shot) || is_true(var_55b4f21e.diewhenfinished)) {
                kill_ent();
            }
        } else {
            flag::set(_str_shot + "stopped");
        }
        if (!_b_active_anim) {
            cleanup();
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x21400dee, Offset: 0x2390
    // Size: 0x58
    function has_streamer_hint() {
        if (is_player() && isdefined(_o_scene._a_streamer_hint) && isdefined(_o_scene._a_streamer_hint[_str_team])) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9fc14c6b, Offset: 0x7ad8
    // Size: 0x3e
    function function_d2039b28() {
        return isdefined(_o_scene._e_root.origin) ? _o_scene._e_root.origin : (0, 0, 0);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa784384b, Offset: 0x8de0
    // Size: 0xd4
    function log(str_msg) {
        println(_o_scene._s.type + "<dev string:x31b>" + function_9e72a96(_o_scene._str_name) + "<dev string:x320>" + (isdefined("<dev string:x32b>") ? "<dev string:x327>" + "<dev string:x32b>" : isdefined(_s.name) ? "<dev string:x327>" + _s.name : "<dev string:x327>") + "<dev string:x336>" + str_msg);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x162a7980, Offset: 0x8298
    // Size: 0x5a
    function is_player() {
        return _s.type === "player" || _s.type === "sharedplayer" || _s.type === "playeroutfit";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x822624a8, Offset: 0x8300
    // Size: 0x1c
    function is_player_model() {
        return _s.type === "fakeplayer";
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3f7ed271, Offset: 0x7b68
    // Size: 0x26c
    function spawn_ent() {
        flag::set(#"spawning");
        b_disable_throttle = is_true(_o_scene._s.dontthrottle);
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
                    _e = util::spawn_anim_player_model(_s.model, function_d2039b28(), function_f9936b53());
                } else {
                    _e = util::spawn_anim_model(_s.model, function_d2039b28(), function_f9936b53());
                }
            }
        }
        function_a04fb5f4();
        flag::clear(#"spawning");
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x41bfa390, Offset: 0x34b8
    // Size: 0x96
    function function_dd4f74e1() {
        if (is_true(_s.firstframe) && _o_scene._str_mode == "init" && isdefined(_e) && !is_true(_e.var_68ade67d)) {
            _b_first_frame = 1;
            return;
        }
        _b_first_frame = 0;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2f6f9106, Offset: 0x1ea0
    // Size: 0x106
    function function_e0df299e(_str_shot) {
        n_shot = get_shot(_str_shot);
        if (isdefined(n_shot) && isdefined(_s.shots[n_shot].entry)) {
            foreach (s_entry in _s.shots[n_shot].entry) {
                if (isdefined(s_entry.anim) || isdefined(s_entry.cameraswitcher)) {
                    return true;
                }
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x31662075, Offset: 0x2340
    // Size: 0x46
    function function_e91c94b9(n_shot) {
        if (isdefined(n_shot)) {
            if (is_true(_s.shots[n_shot].interactiveshot)) {
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x719acb3e, Offset: 0x52a0
    // Size: 0x1d4
    function function_ea176ba9() {
        var_d705d1a8 = 1;
        if (isdefined(_o_scene._a_objects)) {
            foreach (o_obj in _o_scene._a_objects) {
                if (isdefined(o_obj._e) && !is_true(o_obj._e.var_4819ae76)) {
                    var_d705d1a8 = 0;
                    break;
                }
            }
        }
        if (var_d705d1a8) {
            _o_scene.var_d84cc502 = 1;
            if (isdefined(_o_scene._a_objects)) {
                foreach (o_obj in _o_scene._a_objects) {
                    o_obj flag::clear(#"waiting_for_damage");
                }
            }
            if (isdefined(_o_scene._e_root)) {
                _o_scene._e_root notify(#"hash_18be12558bc58fe");
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1d5eff25, Offset: 0xfc8
    // Size: 0x19a
    function _spawn() {
        restore_saved_ent();
        if (!isdefined(_e)) {
            if (isdefined(_s.name)) {
                _e = scene::get_existing_ent(_s.name, undefined, undefined, _o_scene._str_name);
            }
        }
        if (isdefined(_e)) {
            if (is_true(_e.isdying)) {
                _e delete();
            }
        }
        if (!isdefined(_e) && (!is_true(_s.nospawn) || is_true(_o_scene._b_testing)) || isspawner(_e)) {
            spawn_ent();
            if (isdefined(_e)) {
                _e dontinterpolate();
                _e.scene_spawned = _o_scene._s.name;
            }
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf3d8a249, Offset: 0x35d0
    // Size: 0x114
    function function_ebbbd00d() {
        if (_b_first_frame) {
            return;
        }
        n_spacer_min = var_55b4f21e.spacermin;
        n_spacer_max = var_55b4f21e.spacermax;
        if ((isdefined(n_spacer_min) || isdefined(n_spacer_max)) && !is_skipping_scene()) {
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
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb640ef0, Offset: 0x5ca8
    // Size: 0x6a
    function _assign_unique_name() {
        if (isdefined(_s.name)) {
            _str_name = _s.name;
            return;
        }
        _str_name = _o_scene._str_name + "_noname" + [[ _o_scene ]]->get_object_id();
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf3f17e56, Offset: 0x2290
    // Size: 0x4c
    function function_f0e3e344() {
        if (isdefined(var_55b4f21e.var_1c7fbd6b) && isdefined(_e)) {
            _e setmodel(var_55b4f21e.var_1c7fbd6b);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5f43a001, Offset: 0x59c0
    // Size: 0xb0
    function function_f12c5e67(s_shot) {
        if (is_true(s_shot.var_b3dddfd3) || is_true(s_shot.var_163ca9fa) || is_true(s_shot.var_dbd0fa6f) || is_true(s_shot.var_650063ca) || is_true(s_shot.var_efd784b6)) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf156aa8a, Offset: 0x7df0
    // Size: 0x192
    function kill_ent() {
        if (!isdefined(_e)) {
            return;
        }
        if (is_true(function_4de466fd())) {
            _e.health = 0;
            return;
        }
        if (isarray(level.heroes) && isinarray(level.heroes, _e)) {
            arrayremovevalue(level.heroes, _e, 1);
            _e notify(#"unmake_hero");
        }
        _e util::stop_magic_bullet_shield();
        _e.var_7136e83 = 1;
        _e.skipdeath = 1;
        _e.allowdeath = 1;
        _e.skipscenedeath = 1;
        _e._scene_object = undefined;
        if (isplayer(_e)) {
            _e disableinvulnerability();
        }
        _e kill();
        _e.var_7136e83 = undefined;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x71d8ca89, Offset: 0xad0
    // Size: 0x84
    function _reset_values(ent = self._e) {
        reset_ent_val("takedamage", ent);
        reset_ent_val("ignoreme", ent);
        reset_ent_val("allowdeath", ent);
        reset_ent_val("take_weapons", ent);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7216737a, Offset: 0x7ac0
    // Size: 0xc
    function on_play_anim(*ent) {
        
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2ab9e7ff, Offset: 0x8798
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
    // Params 0, eflags: 0x1 linked
    // Checksum 0x42bf4c20, Offset: 0x7b20
    // Size: 0x3e
    function function_f9936b53() {
        return isdefined(_o_scene._e_root.angles) ? _o_scene._e_root.angles : (0, 0, 0);
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x967efb92, Offset: 0x4868
    // Size: 0xd8
    function get_align_tag() {
        if (isdefined(var_55b4f21e.aligntargettag) && !is_true(var_55b4f21e.var_ab59a015)) {
            return var_55b4f21e.aligntargettag;
        }
        if (isdefined(_s.aligntargettag)) {
            return _s.aligntargettag;
        }
        if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.e_scene_link)) {
            return "tag_origin";
        }
        return _o_scene._s.aligntargettag;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x52b788e7, Offset: 0x9b0
    // Size: 0x6c
    function reset_ent_val(str_key, ent = self._e) {
        if (isdefined(ent)) {
            ent val::reset(_o_scene._str_name + ":" + _str_shot, str_key);
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x604c995f, Offset: 0x5d20
    // Size: 0x12
    function get_orig_name() {
        return _s.name;
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x557b91d2, Offset: 0x4148
    // Size: 0x2c4
    function function_fda037ff() {
        if (!isdefined(var_55b4f21e)) {
            return;
        }
        if (isdefined(var_55b4f21e.var_39fd697b)) {
            a_ents = getentarray(var_55b4f21e.var_39fd697b, "targetname", 1);
            array::thread_all(a_ents, &val::set, #"script_hide", "hide", 1);
        } else if (isdefined(var_55b4f21e.var_4ceff7a6)) {
            a_ents = getentarray(var_55b4f21e.var_4ceff7a6, "targetname", 1);
            array::thread_all(a_ents, &val::reset, #"script_hide", "hide");
        }
        if (!isdefined(_e)) {
            return;
        }
        if (is_true(var_55b4f21e.cleanupdelete) && !isplayer(_e)) {
            thread function_2035b6d6(_e);
            return;
        }
        if (is_true(var_55b4f21e.var_3ea5d95f) && _str_shot != "init") {
            _e connectpaths();
        } else if (is_true(var_55b4f21e.var_8645db22)) {
            _e disconnectpaths(2, 1);
        }
        if (is_true(var_55b4f21e.cleanuphide)) {
            thread function_9960f8f0(_e);
            return;
        }
        if (is_true(var_55b4f21e.cleanupshow)) {
            _e notify(#"cleanupshow");
            _e val::reset(#"scene", "hide");
        }
    }

    // Namespace csceneobject/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3354afc3, Offset: 0x8db0
    // Size: 0x22
    function is_skipping_scene() {
        return is_true([[ _o_scene ]]->is_skipping_scene());
    }

}

// Namespace scene
// Method(s) 63 Total 63
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
    var n_frame_counter;
    var scene_skip_completed;
    var scene_stopping;
    var skipping_scene;
    var var_232738b3;
    var var_2bc31f02;
    var var_2e9fdf35;
    var var_355308d8;
    var var_486885a7;
    var var_58e5d094;
    var var_5a2219f0;
    var var_753367d;
    var var_a0c66830;
    var var_b0ff34ce;

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x9 linked
    // Checksum 0xbd1d17e7, Offset: 0xa508
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
    // Params 0, eflags: 0x11 linked
    // Checksum 0x3db46114, Offset: 0xa578
    // Size: 0x24
    destructor() {
        /#
            log("<dev string:x33c>");
        #/
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x4f31c7ea, Offset: 0xf4e0
    // Size: 0x154
    function wait_till_shot_ready(str_shot, o_exclude) {
        a_objects = [];
        if (isdefined(o_exclude)) {
            a_objects = array::exclude(_a_objects, o_exclude);
        } else {
            a_objects = _a_objects;
        }
        if (is_true(_s.igc)) {
            level flag::increment("waitting_for_igc_ready");
        }
        wait_till_objects_ready(str_shot, a_objects);
        flag::set(str_shot + "ready");
        sync_with_other_scenes(str_shot);
        flag::set(str_shot + "go");
        function_9a5f92e7();
        if (is_true(_s.igc)) {
            level flag::decrement("waitting_for_igc_ready");
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xaee5d5f2, Offset: 0xc6b8
    // Size: 0x4c
    function _is_ent_player(ent, str_team) {
        return isplayer(ent) && scene::check_team(ent.team, str_team);
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa23e1d1c, Offset: 0xb298
    // Size: 0x5e
    function function_85ed339(s_obj) {
        str_type = tolower(s_obj.type);
        if (is_true(s_obj.var_615b1f16)) {
            str_type = "fakeactor";
        }
        return str_type;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7a9fc54d, Offset: 0xc760
    // Size: 0x44
    function _is_ent_vehicle(ent, *str_team) {
        return isvehicle(str_team) || isvehiclespawner(str_team);
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x782d20c8, Offset: 0xf1f8
    // Size: 0x122
    function get_ents() {
        a_ents = [];
        if (isdefined(_a_objects)) {
            foreach (o_obj in _a_objects) {
                if (isdefined(o_obj._s.name)) {
                    a_ents[o_obj._s.name] = o_obj._e;
                    continue;
                }
                if (!isdefined(a_ents)) {
                    a_ents = [];
                } else if (!isarray(a_ents)) {
                    a_ents = array(a_ents);
                }
                a_ents[a_ents.size] = o_obj._e;
            }
        }
        return a_ents;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb7f162a2, Offset: 0xb480
    // Size: 0x170
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
    // Params 2, eflags: 0x1 linked
    // Checksum 0x896d07d2, Offset: 0xf798
    // Size: 0x102
    function wait_till_objects_ready(str_shot, &array) {
        for (i = 0; i < array.size; i++) {
            obj = array[i];
            if (isdefined(obj) && !obj flag::get(str_shot + "ready") && obj flag::get(str_shot + "active") && !obj flag::get(str_shot + "stopped")) {
                obj waittill(str_shot + "ready", str_shot + "active", str_shot + "stopped");
                i = -1;
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x6337b0f0, Offset: 0xc340
    // Size: 0x138
    function function_13804c36(ent, var_3b0de5fa) {
        if (ent.script_animname === var_3b0de5fa || isstring(ent.script_animname) && tolower(ent.script_animname) === var_3b0de5fa) {
            return true;
        }
        if (ent.animname === var_3b0de5fa || isstring(ent.animname) && tolower(ent.animname) === var_3b0de5fa) {
            return true;
        }
        if (ent.targetname === var_3b0de5fa || isstring(ent.targetname) && tolower(ent.targetname) === var_3b0de5fa) {
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x34d80689, Offset: 0xc710
    // Size: 0x44
    function _is_ent_actor(ent, *str_team) {
        return isactor(str_team) || isactorspawner(str_team);
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa1ea6f5, Offset: 0x10b00
    // Size: 0xc4
    function error(condition, str_msg) {
        if (condition) {
            if (_b_testing) {
                /#
                    scene::error_on_screen(str_msg);
                #/
            } else {
                assertmsg(_s.type + "<dev string:x31b>" + function_9e72a96(_str_name) + "<dev string:x60b>" + function_9e72a96(str_msg));
            }
            thread on_error();
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x4715e8a6, Offset: 0xe668
    // Size: 0x10a
    function has_next_shot(str_current_shot = self._a_active_shots[0]) {
        if (isdefined(var_2e9fdf35)) {
            return true;
        }
        if (str_current_shot === "init") {
            return false;
        }
        foreach (i, str_shot in var_5a2219f0) {
            if (str_shot === str_current_shot && isdefined(var_5a2219f0[i + 1]) && var_5a2219f0[i + 1] !== "init") {
                return true;
            }
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x990054f5, Offset: 0xb060
    // Size: 0x18
    function function_24f8cfb5(str_shot) {
        return str_shot === var_232738b3;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7fd6c99b, Offset: 0xb718
    // Size: 0x1ba
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
        case #"playeroutfit":
            return new class_6572d7cd();
        case #"player":
            return new csceneplayer();
        case #"sharedplayer":
            return new cscenesharedplayer();
        case #"fakeplayer":
            return new cscenefakeplayer();
        default:
            error(0, "Unsupported object type '" + str_type + "'.");
            break;
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x47b9f7c2, Offset: 0xbfa0
    // Size: 0x396
    function _assign_ents_by_name(&a_objects, &a_ents) {
        if (a_ents.size) {
            var_90bf7b4c = [];
            foreach (i, o_obj in a_objects) {
                obj_name = isdefined(o_obj._s.name) ? "" + o_obj._s.name : "";
                if (obj_name != "") {
                    var_f9347ad1 = undefined;
                    foreach (str_name, e_ent in a_ents) {
                        if (isint(str_name) && obj_name == (isdefined(str_name) ? "" + str_name : "") || !isint(str_name) && hash(obj_name) == str_name || function_13804c36(e_ent, obj_name)) {
                            assign_ent(o_obj, e_ent);
                            var_f9347ad1 = str_name;
                            var_90bf7b4c[var_90bf7b4c.size] = i;
                            break;
                        }
                    }
                    if (isdefined(var_f9347ad1)) {
                        arrayremoveindex(a_ents, var_f9347ad1, 1);
                    }
                }
            }
            foreach (index in var_90bf7b4c) {
                arrayremoveindex(a_objects, index, 1);
            }
            /#
                foreach (i, ent in a_ents) {
                    error(isstring(i) || ishash(i), "<dev string:x3c9>" + i + "<dev string:x205>");
                }
            #/
        }
        return a_ents.size;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd08ff4ac, Offset: 0xe4b8
    // Size: 0xc8
    function function_3e22b6ac() {
        if (isdefined(_a_objects)) {
            foreach (obj in _a_objects) {
                if (isdefined(obj._e) && isbot(obj._e)) {
                    obj._e botreleasemanualcontrol();
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa915c09d, Offset: 0xe640
    // Size: 0x1a
    function scene_skip_completed() {
        return is_true(scene_skip_completed);
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x80ad669, Offset: 0xa5a8
    // Size: 0x5b8
    function function_4412dc65(str_shot) {
        /#
            self notify(#"hash_763a7354c3aaff58");
            self endon(#"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_763a7354c3aaff58");
            if (_b_testing) {
                var_82bbc872 = 0;
                var_9d90ef8b = scene::function_12479eba(_str_name);
                a_shots = scene::get_all_shot_names(_str_name, 1);
                foreach (str_shot_name in _s.a_str_shot_names) {
                    if (str_shot_name != str_shot) {
                        var_82bbc872 += ceil(scene::function_8582657c(_s, str_shot_name) * 30);
                        continue;
                    }
                    break;
                }
                n_frame_counter = var_82bbc872;
                while (true) {
                    if (getdvarint(#"hash_67caa056eba27a53", 0) == 0 || !isdefined(_a_objects)) {
                        waitframe(1);
                        continue;
                    }
                    v_pos = (1350, 195, 0);
                    var_204b44d3 = var_9d90ef8b * n_frame_counter / ceil(var_9d90ef8b * 30);
                    var_962ef8af = "<dev string:x34f>" + n_frame_counter + "<dev string:x369>" + ceil(var_9d90ef8b * 30) + "<dev string:x36e>" + var_204b44d3 + "<dev string:x369>" + var_9d90ef8b + "<dev string:x381>";
                    debug2dtext(v_pos, var_962ef8af, undefined, undefined, undefined, 1, 0.8);
                    v_pos += (0, 20, 0) * 2;
                    foreach (obj in _a_objects) {
                        if (!isdefined(obj._e) || !isdefined(obj._str_current_anim)) {
                            continue;
                        }
                        if (str_shot !== obj._str_shot) {
                            continue;
                        }
                        animation = obj._str_current_anim;
                        if (!isdefined(animation) || !isassetloaded("<dev string:x1d5>", animation)) {
                            continue;
                        }
                        var_13edeb1f = getanimframecount(animation);
                        var_7b160393 = ceil(obj._e getanimtime(animation) * var_13edeb1f);
                        var_958054e5 = getanimlength(animation);
                        var_f667af2f = obj._e getanimtime(animation) * var_958054e5;
                        var_2e63fccd = obj._str_name + "<dev string:x388>" + function_9e72a96(animation);
                        var_1cae5962 = "<dev string:x393>" + str_shot + "<dev string:x39d>" + var_7b160393 + "<dev string:x369>" + var_13edeb1f + "<dev string:x3a9>" + var_f667af2f + "<dev string:x369>" + var_958054e5 + "<dev string:x381>";
                        debug2dtext(v_pos, var_2e63fccd, undefined, undefined, undefined, 1, 0.8);
                        v_pos += (0, 20, 0);
                        debug2dtext(v_pos, var_1cae5962, undefined, undefined, undefined, 1, 0.8);
                        v_pos += (0, 20, 0) * 1.25;
                        n_frame_counter = var_82bbc872 + var_7b160393;
                    }
                    waitframe(1);
                }
            }
        #/
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x39c9cee8, Offset: 0xf9f0
    // Size: 0x18c
    function sync_with_other_scenes(str_shot) {
        if (!is_true(_s.dontsync) && !is_skipping_scene()) {
            n_request_time = get_request_time(str_shot);
            if (isdefined(level.scene_sync_list) && isarray(level.scene_sync_list[n_request_time])) {
                a_scene_requests = level.scene_sync_list[n_request_time];
                for (i = 0; i < a_scene_requests.size; i++) {
                    a_scene_request = a_scene_requests[i];
                    o_scene = a_scene_request.o_scene;
                    str_flag = a_scene_request.str_shot + "ready";
                    if (isdefined(a_scene_request) && !is_true(o_scene._s.dontsync) && !o_scene flag::get(str_flag)) {
                        o_scene flag::wait_till(str_flag);
                        i = -1;
                    }
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x65ad91a8, Offset: 0xb438
    // Size: 0x1c
    function set_request_time(str_shot) {
        _a_request_times[str_shot] = gettime();
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x499d6270, Offset: 0xb0a0
    // Size: 0x1a0
    function function_4f12fd77(s_obj) {
        if (is_player(s_obj) || is_true(s_obj.var_50f52c5b)) {
            return;
        }
        if (isdefined(s_obj.shots)) {
            foreach (s_shot in s_obj.shots) {
                if (s_shot.name === "init") {
                    continue;
                }
                if (!isdefined(s_shot.entry) && !isdefined(s_shot.var_1c7fbd6b) && !isdefined(s_shot.var_64c0ee5a) && !isdefined(s_shot.cleanuphide) && !isdefined(s_shot.cleanupshow) && !isdefined(s_shot.cleanupdelete) && !isdefined(s_shot.var_3ea5d95f) && !isdefined(s_shot.var_8645db22)) {
                    arrayremovevalue(s_obj.shots, s_shot, 1);
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3d1b8ded, Offset: 0xb300
    // Size: 0x130
    function function_558aaa66(s_instance, s_obj) {
        if (_s.devstate === "placeholder" && isdefined(s_instance.target)) {
            var_1bdb1cc6 = struct::get_array(s_instance.target, "targetname");
            foreach (struct in var_1bdb1cc6) {
                if (isdefined(struct.script_animname) && tolower(struct.script_animname) === tolower(s_obj.name)) {
                    s_obj.var_50f52c5b = 1;
                    return struct;
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5fe64efc, Offset: 0x10870
    // Size: 0xbe
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
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3388d3e2, Offset: 0x109e0
    // Size: 0x74
    function add_object(o_object) {
        if (!isdefined(_a_objects)) {
            _a_objects = [];
        } else if (!isarray(_a_objects)) {
            _a_objects = array(_a_objects);
        }
        _a_objects[_a_objects.size] = o_object;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x63e971cf, Offset: 0xfb88
    // Size: 0xe2
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
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe03b2151, Offset: 0xfc78
    // Size: 0x14
    function on_error() {
        stop();
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xaaa499c7, Offset: 0xf328
    // Size: 0xa
    function get_root() {
        return _e_root;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x85d4f2db, Offset: 0x10a60
    // Size: 0x24
    function remove_object(o_object) {
        arrayremovevalue(_a_objects, o_object);
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6cf9d5b2, Offset: 0xf340
    // Size: 0x162
    function get_align_ent() {
        e_align = _e_root;
        if (isdefined(_s.aligntarget)) {
            e_gdt_align = scene::get_existing_ent(_s.aligntarget, 0, 1, _str_name);
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
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5ed1fd15, Offset: 0xfcc8
    // Size: 0x810
    function skip_scene(var_11843b70, str_shot = self._a_active_shots[0]) {
        if (!is_true(var_11843b70) && is_true(_s.disablesceneskipping)) {
            /#
                if (getdvarint(#"debug_scene_skip", 0) > 0) {
                    printtoprightln("<dev string:x4e6>" + _s.name + "<dev string:x277>" + gettime(), (1, 0, 0));
                }
            #/
            finish_scene_skipping();
            return;
        }
        if (!is_true(var_486885a7)) {
            var_486885a7 = 1;
            _call_shot_funcs("skip_started");
        }
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                printtoprightln("<dev string:x51b>" + _s.name + "<dev string:x277>" + gettime(), (0, 1, 0));
            }
        #/
        if (!is_true(var_11843b70)) {
            if (is_skipping_player_scene()) {
                /#
                    if (getdvarint(#"debug_scene_skip", 0) > 0) {
                        printtoprightln("<dev string:x533>" + gettime());
                    }
                #/
                if (getdvarint(#"scene_skip_no_fade", 0) == 0) {
                    b_skip_fading = 0;
                } else {
                    b_skip_fading = 1;
                }
                foreach (player in getplayers(_str_team)) {
                    player val::set(#"scene_skip", "freezecontrols", 1);
                    player val::set(#"scene_skip", "takedamage", 0);
                    player val::set(#"scene_skip", "ignoreme", 1);
                    player val::set(#"scene_skip", "ignoreall", 1);
                    if (!is_true(b_skip_fading)) {
                        player thread lui::screen_fade_out(0, "black", "scene_system");
                    }
                }
                setpauseworld(0);
            }
        }
        if (!function_b260bdcc(str_shot)) {
            var_f6688aea = 1;
        } else {
            var_f6688aea = 0;
        }
        flag::wait_till(str_shot + "go");
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                printtoprightln("<dev string:x558>" + _s.name + "<dev string:x277>" + gettime(), (0, 0, 1));
            }
        #/
        thread _skip_scene();
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                printtoprightln("<dev string:x578>" + gettime(), (0, 1, 0));
            }
        #/
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                if (isdefined(level.animation_played)) {
                    for (i = 0; i < level.animation_played.size; i++) {
                        printtoprightln("<dev string:x5ad>" + level.animation_played[i], (1, 0, 0), -1);
                    }
                }
            }
        #/
        wait_till_shot_finished(str_shot);
        self flag::set(#"shot_skip_completed");
        if (!var_f6688aea) {
            if (is_skipping_scene()) {
                finish_scene_skipping();
            } else if (is_true(skipping_scene)) {
                skipping_scene = undefined;
            }
            /#
                if (getdvarint(#"debug_scene_skip", 0) > 0) {
                    printtoprightln("<dev string:x5ca>" + _s.name + "<dev string:x277>" + gettime(), (1, 0.5, 0));
                }
            #/
            _call_shot_funcs("skip_completed");
            if (is_true(_s.var_e3b54868) && !scene::function_46546b5c(_str_name)) {
                var_753367d = 1;
                self notify(#"hash_63783193d9ac5bfc");
                thread play(var_355308d8, undefined, undefined, "single");
            } else {
                _call_shot_funcs("done");
                flag::set(#"scene_skip_completed");
            }
            return;
        }
        if (is_skipping_player_scene()) {
            if (_s scene::is_igc()) {
                foreach (player in getplayers(_str_team)) {
                    player stopsounds();
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9d55ca53, Offset: 0xf4b0
    // Size: 0x22
    function is_looping() {
        return is_true(_s.looping);
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf82a0aca, Offset: 0x10bd0
    // Size: 0x64
    function warning(condition, str_msg) {
        if (condition) {
            if (_b_testing) {
                /#
                    scene::warning_on_screen("<dev string:x611>" + _str_name + "<dev string:x617>" + str_msg);
                #/
            }
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1201241d, Offset: 0xf8a8
    // Size: 0x2c
    function wait_till_shot_finished(str_shot) {
        wait_till_objects_finished(str_shot, _a_objects);
    }

    // Namespace cscene/scene_objects_shared
    // Params 5, eflags: 0x1 linked
    // Checksum 0x3f19c9aa, Offset: 0xc480
    // Size: 0x22e
    function _assign_ents_by_type(&a_objects, &a_ents, str_type, func_test, str_team) {
        if (!error(!isdefined(func_test), "_assign_ents_by_type called without specifying a func_test")) {
            if (a_ents.size) {
                a_objects_of_type = get_objects(str_type, str_team);
                if (a_objects_of_type.size) {
                    var_aa70ce62 = [];
                    foreach (str_name, ent in a_ents) {
                        if ([[ func_test ]](ent, str_team)) {
                            index = getfirstarraykey(a_objects_of_type);
                            obj = array::pop_front(a_objects_of_type);
                            if (isdefined(obj)) {
                                assign_ent(obj, ent);
                                var_aa70ce62[var_aa70ce62.size] = str_name;
                                arrayremoveindex(a_objects, index, 1);
                                continue;
                            }
                            break;
                        }
                    }
                    foreach (key in var_aa70ce62) {
                        arrayremoveindex(a_ents, key, 1);
                    }
                }
            }
        }
        return a_ents.size;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb837d12d, Offset: 0xebb0
    // Size: 0x26a
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
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x4b8>" + _s.name);
            }
            if (isdefined(_e_root) && isdefined(_e_root.last_scene_state_instance)) {
                if (!b_finished) {
                    level.last_scene_state[_str_name] = level.last_scene_state[_str_name] + "<dev string:x4da>";
                    _e_root.last_scene_state_instance[_str_name] = _e_root.last_scene_state_instance[_str_name] + "<dev string:x4da>";
                }
                if (!isdefined(_e_root.scriptbundlename)) {
                    _e_root notify(#"stop_debug_display");
                }
            }
        #/
        _b_stopped = 1;
    }

    // Namespace cscene/scene_objects_shared
    // Params 5, eflags: 0x1 linked
    // Checksum 0x7f90a976, Offset: 0xab68
    // Size: 0x4f0
    function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run) {
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x3b6>" + str_scenedef);
            }
        #/
        s_scenedef scene::function_585fb738();
        s_scenedef.var_418c40ac = scene::function_c9770402(str_scenedef);
        var_355308d8 = s_scenedef.var_418c40ac;
        var_232738b3 = scene::function_c3a1b36a(str_scenedef);
        var_5a2219f0 = scene::get_all_shot_names(str_scenedef);
        _s = s_scenedef;
        _str_name = str_scenedef;
        _b_testing = b_test_run;
        _str_team = util::get_team_mapping(_s.team);
        var_2924e369 = util::get_team_mapping("sidea");
        var_3b6e87fc = util::get_team_mapping("sideb");
        _a_streamer_hint[var_2924e369] = _s.var_a6da2039;
        _a_streamer_hint[var_3b6e87fc] = _s.var_991a84ba;
        _str_notify_name = isstring(_s.malebundle) || ishash(_s.malebundle) ? _s.malebundle : _str_name;
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        if (!error(a_ents.size > _s.objects.size, "Trying to use more entities than scene supports.")) {
            _e_root = e_align;
            a_objs = get_valid_object_defs();
            foreach (s_obj in a_objs) {
                s_obj.type = function_85ed339(s_obj);
                if (isdefined(s_obj.name) && _e_root scene::function_9503138e() && isdefined(_e_root.target)) {
                    if (!isdefined(_e_root.var_1505fed6)) {
                        _e_root.var_1505fed6 = [];
                    }
                    _e_root.var_1505fed6[s_obj.name] = function_558aaa66(_e_root, s_obj);
                }
                function_4f12fd77(s_obj);
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
                    level.last_scene_state[_str_name] = "<dev string:x327>";
                }
                if (!isdefined(_e_root.last_scene_state_instance[_str_name])) {
                    _e_root.last_scene_state_instance[_str_name] = "<dev string:x327>";
                }
            #/
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x22c349e3, Offset: 0xfc98
    // Size: 0x26
    function is_scene_shared() {
        if (_s scene::is_igc()) {
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7d406fea, Offset: 0xf640
    // Size: 0x150
    function function_9a5f92e7() {
        foreach (obj in _a_objects) {
            if (isdefined(obj._e) && (isbot(obj._e) || isai(obj._e))) {
                if (isbot(obj._e)) {
                    obj._e bot_util::function_33834a13();
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
    // Params 1, eflags: 0x1 linked
    // Checksum 0xff1462e3, Offset: 0xbc18
    // Size: 0x300
    function assign_ents(a_ents) {
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        arrayremovevalue(a_ents, undefined, 1);
        a_objects = arraycopy(_a_objects);
        if (_assign_ents_by_name(a_objects, a_ents)) {
            if (_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player, "sidea")) {
                if (_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player, "sideb")) {
                    if (_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player, #"team3")) {
                        if (_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player)) {
                            if (_assign_ents_by_type(a_objects, a_ents, "actor", &_is_ent_actor)) {
                                if (_assign_ents_by_type(a_objects, a_ents, "fakeactor", &_is_ent_actor)) {
                                    if (_assign_ents_by_type(a_objects, a_ents, "vehicle", &_is_ent_vehicle)) {
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

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x50ca7ee5, Offset: 0x104e0
    // Size: 0x386
    function finish_scene_skipping() {
        /#
            if (getdvarint(#"debug_scene_skip", 0) > 0) {
                printtoprightln("<dev string:x5e8>" + gettime(), (1, 0, 0));
            }
        #/
        if (is_skipping_scene()) {
            /#
                if (getdvarint(#"debug_scene_skip", 0) > 0) {
                    printtoprightln("<dev string:x533>" + gettime());
                }
            #/
            if (getdvarint(#"scene_skip_no_fade", 0) == 0) {
                b_skip_fading = 0;
            } else {
                b_skip_fading = 1;
            }
            function_f4b4e39f(0);
            level util::streamer_wait(undefined, undefined, 10);
            foreach (player in getplayers(_str_team)) {
                player clientfield::increment_to_player("player_scene_skip_completed");
                player val::reset(#"scene_skip", "freezecontrols");
                player val::reset(#"scene_skip", "takedamage");
                player val::reset(#"scene_skip", "ignoreme");
                player val::reset(#"scene_skip", "ignoreall");
                player stopsounds();
            }
            if (!is_true(b_skip_fading)) {
                if (!is_true(level.level_ending) && is_skipping_player_scene()) {
                    foreach (player in getplayers(_str_team)) {
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
    // Params 2, eflags: 0x1 linked
    // Checksum 0x36e04018, Offset: 0xba68
    // Size: 0x1a4
    function sync_with_client_scene(str_shot, b_test_run = 0) {
        if (_s.vmtype === "both" && !_s scene::is_igc()) {
            self endon(str_shot + "finished");
            flag::wait_till(str_shot + "go");
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
    // Params 3, eflags: 0x1 linked
    // Checksum 0x75e92069, Offset: 0xc960
    // Size: 0x136
    function get_anim_relative_start_time(animation, n_start_time, b_camera_anim = 0) {
        if (!isdefined(var_a0c66830)) {
            return n_start_time;
        }
        if (b_camera_anim) {
            n_anim_length = float(getcamanimtime(animation)) / 1000;
            var_e2483c7 = iscamanimlooping(animation);
        } else {
            n_anim_length = getanimlength(animation);
            var_e2483c7 = isanimlooping(animation);
        }
        var_68219fcf = var_a0c66830 / n_anim_length * n_start_time;
        if (var_e2483c7) {
            if (var_68219fcf > 0.95) {
                var_68219fcf = 0.95;
            }
        } else if (var_68219fcf > 0.99) {
            var_68219fcf = 0.99;
        }
        return var_68219fcf;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe272bdb5, Offset: 0xe450
    // Size: 0x5e
    function function_ab0c6edb() {
        self endon(#"death", #"scene_stop", #"scene_done", #"scene_skip_completed");
        waitframe(1);
        self notify(#"hash_60adeaccbb565546");
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x439b2de7, Offset: 0xeb88
    // Size: 0x1a
    function has_init_state() {
        return scene::has_init_state(_str_name);
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe9c358f7, Offset: 0xb080
    // Size: 0x18
    function function_b260bdcc(str_shot) {
        return str_shot === var_355308d8;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5e23ba28, Offset: 0xb8e0
    // Size: 0x15c
    function get_valid_object_defs() {
        a_obj_defs = [];
        foreach (s_obj in _s.objects) {
            if (_s.vmtype !== "client" && s_obj.vmtype !== "client") {
                if (isdefined(s_obj.name) || isdefined(s_obj.model) || isdefined(s_obj.initanim) || isdefined(s_obj.mainanim)) {
                    if (!is_true(s_obj.disabled) && scene::function_6f382548(s_obj, _s.name)) {
                        a_obj_defs[a_obj_defs.size] = s_obj;
                    }
                }
            }
        }
        return a_obj_defs;
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x92b797d0, Offset: 0xc7b0
    // Size: 0x1a8
    function get_objects(type, str_team) {
        a_ret = [];
        if (isarray(type)) {
            foreach (idx, obj in _a_objects) {
                if (isinarray(type, obj._s.type)) {
                    if (scene::check_team(obj._s.team, str_team)) {
                        a_ret[idx] = obj;
                    }
                }
            }
        } else {
            foreach (idx, obj in _a_objects) {
                if (obj._s.type == type) {
                    if (scene::check_team(obj._s.team, str_team)) {
                        a_ret[idx] = obj;
                    }
                }
            }
        }
        return a_ret;
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x151865cb, Offset: 0xe600
    // Size: 0x32
    function is_skipping_player_scene() {
        return is_true(b_player_scene) || _str_mode == "skip_scene_player";
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x66f1d275, Offset: 0xba48
    // Size: 0x16
    function get_object_id() {
        _n_object_id++;
        return _n_object_id;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x257f174a, Offset: 0xb460
    // Size: 0x18
    function get_request_time(str_shot) {
        return _a_request_times[str_shot];
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x4039843c, Offset: 0xf8e0
    // Size: 0x102
    function wait_till_objects_finished(str_shot, &array) {
        for (i = 0; i < array.size; i++) {
            obj = array[i];
            if (isdefined(obj) && !obj flag::get(str_shot + "finished") && obj flag::get(str_shot + "active") && !obj flag::get(str_shot + "stopped")) {
                obj waittill(str_shot + "finished", str_shot + "active", str_shot + "stopped");
                i = -1;
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb0719cd1, Offset: 0xe780
    // Size: 0xe6
    function get_next_shot(str_current_shot) {
        if (isdefined(var_2e9fdf35)) {
            var_1a15e649 = var_2e9fdf35;
            var_2e9fdf35 = undefined;
            return var_1a15e649;
        }
        foreach (i, str_shot in var_5a2219f0) {
            if (str_shot === str_current_shot && isdefined(var_5a2219f0[i + 1])) {
                return var_5a2219f0[i + 1];
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 4, eflags: 0x1 linked
    // Checksum 0x8caf8d5, Offset: 0xcaa0
    // Size: 0x16ae
    function play(str_shot = "play", a_ents, b_testing = 0, str_mode = "") {
        function_2ddeb362("cScene::play : " + _s.name);
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x3e8>" + _s.name);
            }
        #/
        if (str_mode == "single_loop") {
            self notify(#"hash_27297a73bc597607");
        }
        self notify(str_shot + "start");
        self endon(str_shot + "start", #"hash_27297a73bc597607");
        if (_s scene::is_igc()) {
            function_f4b4e39f(1);
            callback::on_spawned(&function_e6945023, self);
        }
        if (isdefined(_e_root) && isdefined(_e_root.script_teleport_location)) {
            _e_root teleport::function_ff8a7a3();
        }
        if (str_mode == "skip_scene") {
            thread skip_scene(1, str_shot);
        } else if (str_mode == "skip_scene_player") {
            b_player_scene = 1;
            thread skip_scene(1, str_shot);
        }
        _b_testing = b_testing;
        _str_mode = str_mode;
        if (function_b260bdcc(str_shot)) {
            self notify(#"hash_63783193d9ac5bfc");
        }
        if (is_true(_s.spectateonjoin)) {
            level.scene_should_spectate_on_hot_join = 1;
        }
        assign_ents(a_ents);
        self thread sync_with_client_scene(str_shot, b_testing);
        if (issubstr(_str_mode, "play_from_time")) {
            args = strtok(_str_mode, ":");
            if (isdefined(args[1])) {
                var_79584e08 = float(args[1]);
                var_a0c66830 = scene::function_8582657c(_s, str_shot);
            }
            b_play_from_time = 1;
            if (!scene::function_6a0b0afe(_str_mode)) {
                _str_mode = "";
            }
            if (issubstr(args[0], "noai")) {
                _str_mode += "_noai";
            }
            if (issubstr(args[0], "noplayers")) {
                _str_mode += "_noplayers";
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
        arrayremovevalue(level.active_scenes[_str_name], undefined);
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
        flag::clear(str_shot + "ready");
        flag::clear(str_shot + "go");
        flag::clear(str_shot + "finished");
        set_request_time(str_shot);
        if (!is_true(_s.dontsync) && !is_skipping_scene()) {
            add_to_sync_list(str_shot);
        }
        foreach (o_obj in _a_objects) {
            thread [[ o_obj ]]->play(str_shot, var_79584e08);
        }
        /#
            thread function_4412dc65(str_shot);
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
        self thread function_ab0c6edb();
        remove_from_sync_list(str_shot);
        level flag::set(_str_notify_name + "_ready");
        if (isdefined(_e_root)) {
            _e_root flag::set(#"scene_ents_ready");
        }
        if (strstartswith(_str_mode, "capture") || _s scene::is_igc() && scene::function_a4dedc63(1)) {
            /#
                depth = getdvarstring(#"hash_3018c0b9207d1c", "<dev string:x3fb>");
                fps = getdvarstring(#"hash_51617678bebb961a", "<dev string:x400>");
                fmt = getdvarstring(#"hash_4bf15ae7a6fbf73c", "<dev string:x406>");
                if (scene::function_6a0b0afe(_str_mode) || getdvarint(#"hash_6a54249f0cc48945", 0) == 2 || scene::function_24f8cfb5(_str_name, str_shot) || _str_mode === "<dev string:x40d>") {
                    if (scene::function_6a0b0afe(_str_mode) || getdvarint(#"hash_6a54249f0cc48945", 0) == 2) {
                        var_3a6bcf6e = _str_name + "<dev string:x415>" + str_shot;
                    } else {
                        var_3a6bcf6e = _str_name;
                    }
                    level flag::set(#"scene_menu_disable");
                    str_command = "<dev string:x41f>" + depth + "<dev string:x31b>" + fps + "<dev string:x31b>" + fmt + "<dev string:x439>" + _str_name + "<dev string:x31b>" + var_3a6bcf6e;
                    adddebugcommand("<dev string:x447>");
                    adddebugcommand(str_command);
                }
            #/
        }
        if (is_true(_s.var_e3b54868) && function_b260bdcc(str_shot) && !scene::function_46546b5c(_str_name)) {
            if (!is_skipping_scene()) {
                thread _call_shot_funcs(str_shot, 1);
                var_b0ff34ce = undefined;
            }
        } else {
            thread _call_shot_funcs(str_shot, 1);
        }
        wait_till_shot_finished(str_shot);
        b_play_from_time = undefined;
        if (is_true(_s.spectateonjoin)) {
            level.scene_should_spectate_on_hot_join = undefined;
        }
        if (!is_true(var_b0ff34ce) && (_str_mode != "init" && !is_true(var_2bc31f02) && function_b260bdcc(str_shot) || is_true(var_2bc31f02) && flag::get(#"hash_42da41892ac54794"))) {
            if (!is_skipping_scene()) {
                thread _call_shot_funcs("done");
            }
            var_b0ff34ce = 1;
            if (is_true(var_753367d)) {
                self flag::set(#"scene_skip_completed");
            }
            if (isdefined(_e_root)) {
                _e_root notify(#"scene_done", {#scenedef:_str_notify_name});
                _e_root scene::function_6f9a9e07();
            }
        }
        self notify(str_shot);
        if (scene::function_6a0b0afe(_str_mode)) {
            self notify(#"hash_3168dab591a18b9b");
        }
        if (str_shot != "init" && _str_mode != "init" && !_b_stopped && !is_true(scene_stopping)) {
            if ((is_looping() || _str_mode === "loop") && is_true(var_b0ff34ce) || _str_mode === "single_loop") {
                var_b0ff34ce = undefined;
                if (has_init_state() && _str_mode !== "single_loop") {
                    thread play("init", undefined, b_testing, str_mode);
                } else if (get_request_time(str_shot) < gettime()) {
                    if (_str_mode === "single_loop") {
                        var_689ecfec = str_shot;
                    } else {
                        var_689ecfec = scene::function_de6a7579(_str_name, str_mode);
                    }
                    thread play(var_689ecfec, undefined, b_testing, str_mode);
                }
            } else if (!scene::function_6a0b0afe(_str_mode)) {
                thread run_next(str_shot);
            }
        }
        if (is_true(_s.spectateonjoin)) {
            level.scene_should_spectate_on_hot_join = undefined;
        }
        array::flag_wait_clear(_a_objects, str_shot + "active");
        if (!is_skipping_scene() || is_skipping_scene() && scene_skip_completed()) {
            arrayremovevalue(_a_active_shots, str_shot);
        }
        if (!_a_active_shots.size || is_skipping_scene() && scene_skip_completed()) {
            if (isdefined(level.active_scenes[_str_name])) {
                arrayremovevalue(level.active_scenes[_str_name], _e_root);
                arrayremovevalue(level.active_scenes[_str_name], undefined);
                if (level.active_scenes[_str_name].size == 0) {
                    level.active_scenes[_str_name] = undefined;
                }
                arrayremovevalue(level.active_scenes, undefined, 1);
            }
            if (!isdefined(level.inactive_scenes[_str_name])) {
                level.inactive_scenes[_str_name] = [];
            } else if (!isarray(level.inactive_scenes[_str_name])) {
                level.inactive_scenes[_str_name] = array(level.inactive_scenes[_str_name]);
            }
            if (!isinarray(level.inactive_scenes[_str_name], _e_root)) {
                level.inactive_scenes[_str_name][level.inactive_scenes[_str_name].size] = _e_root;
            }
            arrayremovevalue(level.inactive_scenes[_str_name], undefined);
            arrayremovevalue(level.inactive_scenes, undefined, 1);
            if (isdefined(_e_root)) {
                arrayremovevalue(_e_root.scenes, self);
                if (_e_root.scenes.size == 0) {
                    _e_root.scenes = undefined;
                    /#
                        arrayremovevalue(level.scene_roots, _e_root);
                    #/
                }
                if (isstruct(_e_root) && !isdefined(_e_root.scriptbundlename) && isarray(level.inactive_scenes[_str_name])) {
                    arrayremovevalue(level.inactive_scenes[_str_name], _e_root);
                    if (level.inactive_scenes[_str_name].size == 0) {
                        level.inactive_scenes[_str_name] = undefined;
                    }
                }
            }
            /#
                arrayremovevalue(level.scene_roots, undefined);
            #/
            foreach (obj in _a_objects) {
                obj notify(#"death");
            }
            _a_objects = undefined;
            var_58e5d094 = undefined;
            if (isdefined(_s) && _s scene::is_igc()) {
                function_f4b4e39f(0);
                callback::remove_on_spawned(&function_e6945023, self);
            }
        }
        /#
            if (strstartswith(_str_mode, "<dev string:x45d>") || _s scene::is_igc() && scene::function_a4dedc63(1)) {
                conv = getdvarstring(#"hash_7b946c8966b56a8e", "<dev string:x3fb>");
                if (scene::function_6a0b0afe(_str_mode) || function_b260bdcc(str_shot) || getdvarint(#"hash_6a54249f0cc48945", 0) == 2) {
                    level flag::clear(#"scene_menu_disable");
                    adddebugcommand("<dev string:x468>" + conv);
                }
            }
        #/
        self notify(#"remove_callbacks");
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3f52b49c, Offset: 0xb5f8
    // Size: 0x118
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
    // Params 1, eflags: 0x1 linked
    // Checksum 0x543269d4, Offset: 0xe870
    // Size: 0x30c
    function run_next(str_current_shot) {
        /#
            if (getdvarint(#"debug_scene", 0) > 0) {
                printtoprightln("<dev string:x47b>" + gettime());
            }
        #/
        b_run_next_scene = 0;
        if (has_next_shot(str_current_shot)) {
            if (!_b_stopped && !is_true(scene_stopping)) {
                var_8b188654 = is_skipping_scene();
                if (var_8b188654) {
                    var_43cf9254 = 0;
                    while (!flag::get(#"shot_skip_completed") || var_43cf9254 > 5) {
                        var_43cf9254 += float(function_60d95f53()) / 1000;
                        waitframe(1);
                    }
                    flag::clear(#"shot_skip_completed");
                }
                if (var_8b188654) {
                    if (is_skipping_player_scene()) {
                        _str_mode = "skip_scene_player";
                    } else {
                        _str_mode = "skip_scene";
                    }
                } else {
                    b_run_next_scene = 1;
                }
                if (has_next_shot(str_current_shot)) {
                    var_1a15e649 = get_next_shot(str_current_shot);
                    /#
                        if (getdvarint(#"debug_scene_skip", 0) > 0 && is_skipping_scene()) {
                            printtoprightln("<dev string:x492>" + str_current_shot + "<dev string:x277>" + gettime(), (1, 1, 0));
                        }
                    #/
                    switch (_s.scenetype) {
                    case #"scene":
                        thread play(var_1a15e649, undefined, _b_testing, _str_mode);
                        break;
                    default:
                        thread play(var_1a15e649, undefined, _b_testing, _str_mode);
                        break;
                    }
                }
            }
            return;
        }
        _call_shot_funcs("sequence_done");
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf453d656, Offset: 0x10a90
    // Size: 0x64
    function log(str_msg) {
        println(_s.type + "<dev string:x31b>" + function_9e72a96(_str_name) + "<dev string:x60b>" + str_msg);
    }

    // Namespace cscene/scene_objects_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa5aafbb1, Offset: 0x10938
    // Size: 0x9a
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
    // Params 1, eflags: 0x1 linked
    // Checksum 0x63e02d31, Offset: 0xb248
    // Size: 0x46
    function is_player(s_obj) {
        if (s_obj.type === "player" || s_obj.type === "sharedplayer") {
            return true;
        }
        return false;
    }

    // Namespace cscene/scene_objects_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe208b5ab, Offset: 0xe158
    // Size: 0x2ea
    function function_e6945023(player) {
        if (is_true(level.var_23e297bc)) {
            return;
        }
        if (scene::check_team(player.team, _str_team)) {
            foreach (obj in _a_objects) {
                if (isplayer(obj._e) && isdefined(obj._e.str_current_anim)) {
                    var_f667af2f = obj._e getanimtime(obj._e.str_current_anim);
                    str_shot = obj._str_shot;
                    break;
                }
            }
            if (isdefined(str_shot) && isdefined(var_f667af2f)) {
                foreach (obj in _a_objects) {
                    if (![[ obj ]]->function_e0df299e(str_shot)) {
                        continue;
                    }
                    if ([[ obj ]]->is_shared_player() || [[ obj ]]->function_527113ae() && !isplayer(obj._e)) {
                        if (is_true(obj._e.var_20ed0b0c)) {
                            obj._e delete();
                        }
                        if (!isdefined(obj._e)) {
                            obj._e = player;
                        }
                        player endon(#"disconnect");
                        player dontinterpolate();
                        player ghost();
                        thread [[ obj ]]->play(str_shot, var_f667af2f);
                        waitframe(3);
                        player show();
                        return;
                    }
                }
            }
        }
    }

    // Namespace cscene/scene_objects_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5405c79b, Offset: 0xee28
    // Size: 0x3c8
    function _call_shot_funcs(str_shot, b_waittill_go = 0) {
        self endon(str_shot);
        if (b_waittill_go) {
            flag::wait_till(str_shot + "go");
        }
        if (str_shot == "done") {
            level notify(_str_notify_name + "_done");
            self notify(#"scene_done");
            function_3e22b6ac();
        }
        if (str_shot == "stop") {
            self notify(#"scene_stop");
            function_3e22b6ac();
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
                util::function_50f54b6f(_e_root, func, a_ents, args);
            }
        }
        if (isdefined(level.var_4247a0d6) && isdefined(level.var_4247a0d6[_str_notify_name]) && isdefined(level.var_4247a0d6[_str_notify_name][str_shot])) {
            foreach (handler in level.var_4247a0d6[_str_notify_name][str_shot]) {
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
    // Params 2, eflags: 0x1 linked
    // Checksum 0x95160fea, Offset: 0xbf20
    // Size: 0x78
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
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1c428791, Offset: 0xe588
    // Size: 0x6e
    function is_skipping_scene() {
        return (is_true(skipping_scene) || _str_mode == "skip_scene" || _str_mode == "skip_scene_player") && !is_true(_s.disablesceneskipping);
    }

}

// Namespace scene/scene_objects_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x8f3f839, Offset: 0x800
// Size: 0x52
function prepare_player_model_anim(ent) {
    if (ent.animtree !== "all_player") {
        ent useanimtree("all_player");
        ent.animtree = "all_player";
    }
}

// Namespace scene/scene_objects_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x8b7884f9, Offset: 0x860
// Size: 0x52
function prepare_generic_model_anim(ent) {
    if (ent.animtree !== "generic") {
        ent useanimtree("generic");
        ent.animtree = "generic";
    }
}

