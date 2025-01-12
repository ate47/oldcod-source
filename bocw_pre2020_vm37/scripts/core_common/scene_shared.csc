#using script_48adcbbbccee5e60;
#using script_64914218f744517b;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_debug_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scriptbundle_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapon_utils;

#namespace scene;

// Namespace scene
// Method(s) 30 Total 38
class cscene : cscriptbundlebase {

    var _a_active_shots;
    var _a_objects;
    var _e_root;
    var _n_object_id;
    var _s;
    var _str_mode;
    var _str_name;
    var _str_shot;
    var _testing;
    var n_start_time;
    var scene_stopped;
    var skipping_scene;
    var var_2e9fdf35;
    var var_b0ff34ce;

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x9 linked
    // Checksum 0x5684921f, Offset: 0x5ac0
    // Size: 0x3a
    constructor() {
        _n_object_id = 0;
        _str_mode = "";
        _a_active_shots = [];
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x13abba01, Offset: 0x7e88
    // Size: 0x34
    function wait_till_shot_ready() {
        if (isdefined(_a_objects)) {
            array::flag_wait(_a_objects, "ready");
        }
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe360b041, Offset: 0x7bc8
    // Size: 0x17a
    function get_ents() {
        a_ents = [];
        for (clientnum = 0; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(function_5c10bd79(clientnum))) {
                a_ents[clientnum] = [];
                foreach (o_obj in _a_objects) {
                    ent = [[ o_obj ]]->get_ent(clientnum);
                    if (isdefined(o_obj._s.name)) {
                        a_ents[clientnum][o_obj._s.name] = ent;
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
        }
        return a_ents;
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5c768a5e, Offset: 0x66b0
    // Size: 0x2e0
    function function_1013fc5b() {
        if (isstring(_s.cameraswitcher) || ishash(_s.cameraswitcher)) {
            a_players = getlocalplayers();
            foreach (player in a_players) {
                clientnum = player getlocalclientnumber();
                e_align = get_align_ent(clientnum);
                v_pos = isdefined(e_align.origin) ? e_align.origin : (0, 0, 0);
                v_ang = isdefined(e_align.angles) ? e_align.angles : (0, 0, 0);
                playmaincamxcam(clientnum, _s.cameraswitcher, 0, "", "", v_pos, v_ang);
            }
            if (iscamanimlooping(_s.cameraswitcher)) {
                self waittill(#"new_state");
            } else {
                n_cam_time = getcamanimtime(_s.cameraswitcher);
                self waittilltimeout(float(n_cam_time) / 1000, #"new_state");
            }
            a_players = getlocalplayers();
            foreach (player in a_players) {
                clientnum = player getlocalclientnumber();
                stopmaincamxcam(clientnum);
            }
        }
    }

    // Namespace cscene/scene_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3308be2c, Offset: 0x61b0
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

    // Namespace cscene/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x434f83d1, Offset: 0x5b28
    // Size: 0x192
    function new_object(str_type) {
        switch (str_type) {
        case #"prop":
            return new csceneobject();
        case #"model":
            return new csceneobject();
        case #"vehicle":
            return new csceneobject();
        case #"actor":
            return new csceneobject();
        case #"fakeactor":
            return new csceneobject();
        case #"player":
            return new csceneplayer();
        case #"sharedplayer":
            return new csceneplayer();
        case #"fakeplayer":
            return new csceneobject();
        default:
            cscriptbundlebase::error(0, "Unsupported object type '" + str_type + "'.");
            break;
        }
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x350ad7d, Offset: 0x7250
    // Size: 0xa
    function function_2ba44cd0() {
        return _str_shot;
    }

    // Namespace cscene/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xbde35a1b, Offset: 0x6538
    // Size: 0x14c
    function initialize(b_playing = 0) {
        self notify(#"new_state");
        self endon(#"new_state");
        _s scene::function_585fb738();
        if (get_valid_objects().size > 0) {
            level flag::set(_str_name + "_initialized");
            _str_mode = "init";
            foreach (o_obj in _a_objects) {
                thread [[ o_obj ]]->initialize();
            }
            if (!b_playing) {
                thread _call_state_funcs("init");
            }
        }
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x87170398, Offset: 0x7ef8
    // Size: 0xf2
    function get_valid_objects() {
        a_obj = [];
        foreach (obj in _a_objects) {
            if (obj._is_valid && ![[ obj ]]->in_a_different_scene()) {
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

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcf78b59d, Offset: 0x7df0
    // Size: 0x8
    function allows_multiple() {
        return true;
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2b2a23f6, Offset: 0x7ff8
    // Size: 0x14
    function on_error() {
        stop();
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb47a5a6b, Offset: 0x7d50
    // Size: 0xa
    function get_root() {
        return _e_root;
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbda1527e, Offset: 0x7ec8
    // Size: 0x24
    function function_6a55f153() {
        array::flag_wait(_a_objects, "done");
    }

    // Namespace cscene/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe2d27e4, Offset: 0x7d68
    // Size: 0x7a
    function get_align_ent(clientnum) {
        e_align = _e_root;
        if (isdefined(_s.aligntarget)) {
            e_gdt_align = scene::get_existing_ent(clientnum, _s.aligntarget);
            if (isdefined(e_gdt_align)) {
                e_align = e_gdt_align;
            }
        }
        return e_align;
    }

    // Namespace cscene/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xcf39519b, Offset: 0x6fc8
    // Size: 0x110
    function function_7a1288f1(str_shot) {
        if (!isdefined(_a_active_shots)) {
            _a_active_shots = [];
        } else if (!isarray(_a_active_shots)) {
            _a_active_shots = array(_a_active_shots);
        }
        if (!isinarray(_a_active_shots, str_shot)) {
            _a_active_shots[_a_active_shots.size] = str_shot;
        }
        if (isarray(level.inactive_scenes[_str_name])) {
            arrayremovevalue(level.inactive_scenes[_str_name], _e_root);
            if (level.inactive_scenes[_str_name].size == 0) {
                level.inactive_scenes[_str_name] = undefined;
            }
        }
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe7b090bb, Offset: 0x7e00
    // Size: 0x22
    function is_looping() {
        return is_true(_s.looping);
    }

    // Namespace cscene/scene_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x1fb71926, Offset: 0x73b8
    // Size: 0x35e
    function stop(b_clear = 0, b_finished = 0) {
        self notify(#"new_state");
        level flag::clear(_str_name + "_playing");
        level flag::clear(_str_name + "_initialized");
        _str_mode = "";
        thread _call_state_funcs("stop");
        scene_stopped = 1;
        foreach (o_obj in _a_objects) {
            if (isdefined(o_obj) && ![[ o_obj ]]->in_a_different_scene()) {
                thread [[ o_obj ]]->finish(b_clear, b_finished);
            }
        }
        self notify(#"stopped", {#is_finished:b_finished});
        if (isdefined(level.active_scenes[_str_name])) {
            arrayremovevalue(level.active_scenes[_str_name], _e_root);
            if (level.active_scenes[_str_name].size == 0) {
                level.active_scenes[_str_name] = undefined;
            }
        }
        if (isdefined(_e_root) && isdefined(_e_root.scenes)) {
            arrayremovevalue(_e_root.scenes, self);
            if (_e_root.scenes.size == 0) {
                _e_root.scenes = undefined;
            }
            _e_root notify(#"scene_done", {#scenedef:_str_name});
            if (isdefined(_e_root.scene_played)) {
                foreach (var_74f5d118 in _e_root.scene_played) {
                    var_74f5d118 = 1;
                }
            }
        }
        self notify(#"scene_done", {#scenedef:_str_name});
    }

    // Namespace cscene/scene_shared
    // Params 5, eflags: 0x1 linked
    // Checksum 0xdfa07a0d, Offset: 0x5cc8
    // Size: 0x4dc
    function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run) {
        cscriptbundlebase::init(str_scenedef, s_scenedef, b_test_run);
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        if (!cscriptbundlebase::error(a_ents.size > _s.objects.size, "Trying to use more entities than scene supports.")) {
            _e_root = e_align;
            if (!isdefined(level.inactive_scenes)) {
                level.inactive_scenes = [];
            }
            if (!isdefined(level.active_scenes[_str_name])) {
                level.active_scenes[_str_name] = [];
            } else if (!isarray(level.active_scenes[_str_name])) {
                level.active_scenes[_str_name] = array(level.active_scenes[_str_name]);
            }
            level.active_scenes[_str_name][level.active_scenes[_str_name].size] = _e_root;
            if (!isdefined(_e_root.scenes)) {
                _e_root.scenes = [];
            } else if (!isarray(_e_root.scenes)) {
                _e_root.scenes = array(_e_root.scenes);
            }
            _e_root.scenes[_e_root.scenes.size] = self;
            a_objs = get_valid_object_defs();
            foreach (var_8713eed1, e_ent in arraycopy(a_ents)) {
                foreach (i, s_obj in arraycopy(a_objs)) {
                    if (s_obj.name === (isdefined(var_8713eed1) ? "" + var_8713eed1 : "") || function_13804c36(e_ent, s_obj.name)) {
                        cscriptbundlebase::add_object([[ new_object(s_obj.type) ]]->first_init(s_obj, self, e_ent, _e_root.localclientnum));
                        arrayremoveindex(a_ents, var_8713eed1);
                        arrayremoveindex(a_objs, i);
                        break;
                    }
                }
            }
            foreach (s_obj in a_objs) {
                cscriptbundlebase::add_object([[ new_object(s_obj.type) ]]->first_init(s_obj, self, array::pop(a_ents), _e_root.localclientnum));
            }
            self thread initialize();
        }
    }

    // Namespace cscene/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb9606992, Offset: 0x6ea8
    // Size: 0x24
    function play_endon(*var_a27f7ab4) {
        function_ea4a6812(_str_shot);
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4d7c7873, Offset: 0x7720
    // Size: 0xaa
    function has_init_state() {
        b_has_init_state = 0;
        foreach (o_scene_object in _a_objects) {
            if ([[ o_scene_object ]]->has_init_state(_str_name)) {
                b_has_init_state = 1;
                break;
            }
        }
        return b_has_init_state;
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa8e770fb, Offset: 0x6390
    // Size: 0x19a
    function get_valid_object_defs() {
        a_obj_defs = [];
        foreach (s_obj in _s.objects) {
            if (_s.vmtype === "client" || s_obj.vmtype === "client") {
                if (isdefined(s_obj.name) || isdefined(s_obj.model) || isdefined(s_obj.initanim) || isdefined(s_obj.mainanim)) {
                    if (!is_true(s_obj.disabled) && scene::function_6f382548(s_obj, _s.name)) {
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

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x854cf863, Offset: 0x6690
    // Size: 0x16
    function get_object_id() {
        _n_object_id++;
        return _n_object_id;
    }

    // Namespace cscene/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x14ada865, Offset: 0x77d8
    // Size: 0x3e2
    function _call_state_funcs(str_state) {
        self endon(#"stopped");
        wait_till_shot_ready();
        if (str_state == "play") {
            waittillframeend();
        }
        level notify(_str_name + "_" + str_state);
        if (isdefined(level.scene_funcs) && isdefined(level.scene_funcs[_str_name]) && isdefined(level.scene_funcs[_str_name][str_state])) {
            a_all_ents = get_ents();
            foreach (clientnum, a_ents in a_all_ents) {
                foreach (handler in level.scene_funcs[_str_name][str_state]) {
                    func = handler[0];
                    args = handler[1];
                    switch (args.size) {
                    case 6:
                        _e_root thread [[ func ]](clientnum, a_ents, args[0], args[1], args[2], args[3], args[4], args[5]);
                        break;
                    case 5:
                        _e_root thread [[ func ]](clientnum, a_ents, args[0], args[1], args[2], args[3], args[4]);
                        break;
                    case 4:
                        _e_root thread [[ func ]](clientnum, a_ents, args[0], args[1], args[2], args[3]);
                        break;
                    case 3:
                        _e_root thread [[ func ]](clientnum, a_ents, args[0], args[1], args[2]);
                        break;
                    case 2:
                        _e_root thread [[ func ]](clientnum, a_ents, args[0], args[1]);
                        break;
                    case 1:
                        _e_root thread [[ func ]](clientnum, a_ents, args[0]);
                        break;
                    case 0:
                        _e_root thread [[ func ]](clientnum, a_ents);
                        break;
                    default:
                        assertmsg("<dev string:x158>");
                        break;
                    }
                }
            }
        }
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xfd94423b, Offset: 0x7268
    // Size: 0x144
    function get_next_shot() {
        if (_s.scenetype === "scene") {
            if (isdefined(var_2e9fdf35)) {
                var_1a15e649 = var_2e9fdf35;
                var_2e9fdf35 = undefined;
                return var_1a15e649;
            }
            a_shots = scene::get_all_shot_names(_str_name, _e_root);
            foreach (i, str_shot in a_shots) {
                if (str_shot === _a_active_shots[0] && isdefined(a_shots[i + 1])) {
                    return a_shots[i + 1];
                }
            }
            return;
        }
        if (_s.scenetype === "fxanim") {
        }
    }

    // Namespace cscene/scene_shared
    // Params 4, eflags: 0x1 linked
    // Checksum 0x3fe29369, Offset: 0x6998
    // Size: 0x504
    function play(str_shot = "play", b_testing = 0, str_mode = "", b_looping = undefined) {
        level endon(#"demo_jump");
        self notify(str_shot + "start");
        self endoncallback(&play_endon, str_shot + "start", #"new_state");
        if (issubstr(str_mode, "play_from_time")) {
            args = strtok(str_mode, ":");
            if (isdefined(args[1])) {
                var_79584e08 = float(args[1]);
            }
        }
        _testing = b_testing;
        _str_mode = str_mode;
        _str_shot = str_shot;
        if (get_valid_objects().size > 0) {
            foreach (o_obj in _a_objects) {
                thread [[ o_obj ]]->play(str_shot, var_79584e08, b_looping);
            }
            n_start_time = undefined;
            level flag::set(_str_name + "_playing");
            if (!scene::function_6a0b0afe(_str_mode)) {
                _str_mode = "play";
            }
            wait_till_shot_ready();
            function_7a1288f1(str_shot);
            thread function_1013fc5b();
            thread _call_state_funcs(str_shot);
            function_6a55f153();
            array::function_d77ef691(_a_objects, "done", "main_done");
            if (scene::function_b260bdcc(_str_name, str_shot)) {
                if (isdefined(_e_root)) {
                    _e_root notify(#"scene_done", {#scenedef:_str_name});
                }
                thread _call_state_funcs("done");
                var_b0ff34ce = 1;
            }
            if ((is_looping() || _str_mode == "loop") && is_true(var_b0ff34ce)) {
                var_b0ff34ce = undefined;
                if (has_init_state()) {
                    level flag::clear(_str_name + "_playing");
                    thread initialize();
                } else {
                    level flag::clear(_str_name + "_initialized");
                    var_689ecfec = scene::function_de6a7579(_str_name, str_mode, _e_root);
                    thread play(var_689ecfec, b_testing, str_mode, 1);
                }
            } else if (!scene::function_6a0b0afe(_str_mode)) {
                thread run_next(str_shot);
            } else {
                thread stop(0, 1);
            }
        } else {
            thread stop(0, 1);
        }
        function_ea4a6812(str_shot);
    }

    // Namespace cscene/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd497c77b, Offset: 0x6ed8
    // Size: 0xe4
    function run_next(str_current_shot) {
        var_1a15e649 = get_next_shot();
        function_ea4a6812(str_current_shot);
        if (isdefined(var_1a15e649)) {
            switch (_s.scenetype) {
            case #"scene":
                thread play(var_1a15e649, _testing, _str_mode);
                break;
            default:
                thread play(var_1a15e649, _testing, _str_mode);
                break;
            }
            return;
        }
        thread stop(0, 1);
    }

    // Namespace cscene/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x67b64fd1, Offset: 0x70e0
    // Size: 0x164
    function function_ea4a6812(str_shot) {
        arrayremovevalue(_a_active_shots, str_shot);
        if (_a_active_shots.size == 0) {
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
        }
    }

    // Namespace cscene/scene_shared
    // Params 3, eflags: 0x1 linked
    // Checksum 0xd4d895fe, Offset: 0x62f0
    // Size: 0x96
    function assign_ent(o_obj, ent, clientnum) {
        if (!isdefined(_e_root.scene_ents)) {
            _e_root.scene_ents = [];
        }
        if (!isdefined(_e_root.scene_ents[clientnum])) {
            _e_root.scene_ents[clientnum] = [];
        }
        _e_root.scene_ents[clientnum][o_obj._str_name] = ent;
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9c34f187, Offset: 0x7e30
    // Size: 0x4a
    function is_skipping_scene() {
        return is_true(skipping_scene) || _str_mode == "skip_scene" || _str_mode == "skip_scene_player";
    }

}

// Namespace scene
// Method(s) 7 Total 50
class csceneplayer : cscriptbundleobjectbase, csceneobject {

    var _e_array;
    var _n_clientnum;
    var _o_scene;
    var _str_shot;
    var var_55b4f21e;
    var var_8bba7189;

    // Namespace csceneplayer/scene_shared
    // Params 3, eflags: 0x1 linked
    // Checksum 0xe6992c76, Offset: 0xb00
    // Size: 0x2d8
    function _play_camera_anim(clientnum, animation, n_start_time = 0) {
        if (is_true(var_8bba7189)) {
            return;
        }
        var_8395d6f1 = csceneobject::get_lerp_time();
        var_8395d6f1 = int(var_8395d6f1 * 1000);
        align = csceneobject::get_align_ent(clientnum);
        tag = csceneobject::get_align_tag();
        if (align == level) {
            v_pos = (0, 0, 0);
            v_ang = (0, 0, 0);
        } else if (isentity(align)) {
            assert(isdefined(align.model), "<dev string:x60>" + (isdefined(animation) ? animation : "<dev string:x7c>") + "<dev string:x80>" + (isdefined(tag) ? tag : "<dev string:x8e>") + "<dev string:x9c>");
            v_pos = align;
            v_ang = isdefined(tag) ? tag : "tag_origin";
        } else {
            v_pos = align.origin;
            v_ang = align.angles;
        }
        var_380af598 = isdefined(var_55b4f21e.cameraswitchername) ? var_55b4f21e.cameraswitchername : "";
        var_57949b2d = n_start_time * getcamanimtime(animation);
        var_473877de = getservertime(clientnum) - var_57949b2d;
        if (isdefined(var_55b4f21e.var_ffc10b65)) {
            var_94f3822c = getent(clientnum, var_55b4f21e.var_ffc10b65, "targetname");
        }
        playmaincamxcam(clientnum, animation, var_8395d6f1, var_380af598, "", v_pos, v_ang, var_94f3822c, undefined, undefined, int(var_473877de));
        wait_for_camera(animation, var_57949b2d);
    }

    // Namespace csceneplayer/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xaa809c7b, Offset: 0x8b0
    // Size: 0xc4
    function initialize() {
        flag::clear(#"ready");
        flag::clear(#"done");
        flag::clear(#"main_done");
        self notify(#"new_state");
        self endon(#"new_state");
        self notify(#"init");
        waittillframeend();
        if (isdefined(_n_clientnum)) {
            _spawn(_n_clientnum);
        }
    }

    // Namespace csceneplayer/scene_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2a214961, Offset: 0xde0
    // Size: 0x11c
    function wait_for_camera(animation, var_57949b2d = 0) {
        self endon(#"skip_camera_anims");
        flag::set(#"camera_playing");
        /#
            thread function_87208d7e();
        #/
        if (iscamanimlooping(animation)) {
            self waittill(#"new_state");
        } else {
            n_cam_time = getcamanimtime(animation) - var_57949b2d;
            self waittilltimeout(float(n_cam_time) / 1000, #"new_state");
        }
        flag::clear(#"camera_playing");
    }

    // Namespace csceneplayer/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7c2e820f, Offset: 0xf08
    // Size: 0x1da
    function function_87208d7e() {
        /#
            level notify(#"hash_59d906960a825469");
            level endon(#"hash_59d906960a825469");
            self endon(#"new_state");
            _o_scene endon(#"stopped", #"new_state");
            while (true) {
                if (!getdvarint(#"scr_show_shot_info_for_igcs", 0) || !isdefined(_o_scene._str_name) || !isdefined(_o_scene._str_shot)) {
                    waitframe(1);
                    continue;
                }
                v_pos = (1350, 195, 0);
                var_c74251a4 = scene::function_8582657c(_o_scene._s, _str_shot);
                var_962ef8af = "<dev string:xd2>" + function_9e72a96(_o_scene._str_name) + "<dev string:xdd>" + _str_shot + "<dev string:xe8>" + var_c74251a4 + "<dev string:x106>" + var_c74251a4 * 30;
                debug2dtext(v_pos, var_962ef8af, undefined, undefined, undefined, 1, 0.8);
                v_pos += (0, 20, 0) * 2;
                waitframe(1);
            }
        #/
    }

    // Namespace csceneplayer/scene_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x79eee4a0, Offset: 0x980
    // Size: 0x174
    function _spawn(clientnum, b_hide = 1) {
        if (isdefined(_e_array[clientnum])) {
            var_d3395a10 = 1;
        } else {
            _e_array[clientnum] = function_5c10bd79(clientnum);
        }
        if (isdefined(level.var_762a4ab)) {
            if (!is_true(var_d3395a10)) {
                self [[ level.var_762a4ab ]](clientnum);
            }
            if (isdefined(_e_array[clientnum]) && !isplayer(_e_array[clientnum]) && _e_array[clientnum].model !== "" && b_hide && !is_true(_e_array[clientnum].var_463f8196)) {
                _e_array[clientnum] hide();
            }
        }
        flag::set(#"ready");
    }

}

// Namespace scene
// Method(s) 43 Total 47
class csceneobject : cscriptbundleobjectbase {

    var _b_first_frame;
    var _b_spawnonce_used;
    var _e_array;
    var _is_valid;
    var _n_blend;
    var _n_clientnum;
    var _o_scene;
    var _s;
    var _str_name;
    var _str_shot;
    var m_align;
    var m_tag;
    var var_55b4f21e;
    var var_84ca3312;

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x9 linked
    // Checksum 0x6a7c74bf, Offset: 0x1bd8
    // Size: 0x52
    constructor() {
        _b_spawnonce_used = 0;
        _is_valid = 1;
        _b_first_frame = 0;
        _n_blend = 0;
        var_84ca3312 = "linear";
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd5addfcc, Offset: 0x4f78
    // Size: 0x24
    function wait_till_shot_ready() {
        [[ scene() ]]->wait_till_shot_ready();
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc4c4c88d, Offset: 0x5080
    // Size: 0xda
    function in_a_different_scene() {
        if (isdefined(_n_clientnum)) {
            if (isdefined(_e_array[_n_clientnum]) && isdefined(_e_array[_n_clientnum].current_scene) && _e_array[_n_clientnum].current_scene != _o_scene._str_name) {
                return true;
            }
        } else if (isdefined(_e_array[0]) && isdefined(_e_array[0].current_scene) && _e_array[0].current_scene != _o_scene._str_name) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject/scene_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x22078d41, Offset: 0x45d8
    // Size: 0x1ce
    function function_9a43e31(clientnum, var_6410e385) {
        if (isdefined(level.var_696537bb) && (_s.type === #"fakeplayer" || _s.type === #"player")) {
            weapon = self [[ level.var_696537bb ]](clientnum);
        }
        if (!isdefined(weapon)) {
            return var_6410e385;
        }
        if (isdefined(var_55b4f21e.var_a190f06e) && weapons::ispunch(weapon)) {
            var_c4a23d1d = var_55b4f21e.var_a190f06e;
        } else if (isdefined(var_55b4f21e.var_bb64ee8c) && weapons::isnonbarehandsmelee(weapon)) {
            var_c4a23d1d = var_55b4f21e.var_bb64ee8c;
        } else if (isdefined(var_55b4f21e.var_51c09589) && is_true(weapon.isrocketlauncher)) {
            var_c4a23d1d = var_55b4f21e.var_51c09589;
        } else if (isdefined(var_55b4f21e.var_389b3f9b) && weapons::ispistol(weapon)) {
            var_c4a23d1d = var_55b4f21e.var_389b3f9b;
        }
        return isdefined(var_c4a23d1d) ? var_c4a23d1d : var_6410e385;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5b45f18c, Offset: 0x2db0
    // Size: 0x44
    function function_ee94f77(clientnum) {
        function_dd4f74e1(clientnum);
        function_587971b6();
        function_ebbbd00d();
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb8ff9e52, Offset: 0x24b0
    // Size: 0xba
    function function_1263065a(n_shot = 0) {
        var_5e0d27b8 = [];
        if (isdefined(_s.shots[n_shot]) && isdefined(_s.shots[n_shot].entry)) {
            var_5e0d27b8 = getarraykeys(_s.shots[n_shot].entry);
            var_5e0d27b8 = array::sort_by_value(var_5e0d27b8, 1);
        }
        return var_5e0d27b8;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x153c9f8e, Offset: 0x3f60
    // Size: 0x192
    function _cleanup(clientnum) {
        if (isdefined(_e_array[clientnum]) && isdefined(_e_array[clientnum].current_scene)) {
            _e_array[clientnum] flag::clear(_o_scene._str_name);
            _e_array[clientnum] sethighdetail(0);
            if (_e_array[clientnum].current_scene == _o_scene._str_name) {
                _e_array[clientnum] flag::clear(#"scene");
                _e_array[clientnum].finished_scene = _o_scene._str_name;
                _e_array[clientnum].current_scene = undefined;
            }
            function_fda037ff(clientnum);
        }
        if (clientnum === _n_clientnum || clientnum == 0) {
            if (isdefined(_o_scene) && is_true(_o_scene.scene_stopped)) {
                _o_scene = undefined;
            }
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 8, eflags: 0x1 linked
    // Checksum 0x471446a5, Offset: 0x4300
    // Size: 0x2ca
    function _play_anim(clientnum, animation, n_rate = 1, n_blend, var_b2e32ae2, str_siege_shot, loop, n_start_time) {
        _spawn(clientnum);
        if (is_alive(clientnum, 1)) {
            if (!is_true(_e_array[clientnum].var_463f8196)) {
                _e_array[clientnum] show();
            }
            if (is_true(_s.issiege)) {
                _e_array[clientnum] animation::play_siege(animation, str_siege_shot, n_rate, loop);
            } else {
                if (is_true(loop) && is_true(_s.var_69db1665)) {
                    n_start_time = undefined;
                }
                util::waitforclient(clientnum);
                animation = function_9a43e31(clientnum, animation);
                n_lerp_time = get_lerp_time();
                if (is_true(loop) && is_true(_s.var_9de1f44c)) {
                    _e_array[clientnum] animation::play(animation, _e_array[clientnum], m_tag, n_rate, n_blend, undefined, n_lerp_time, undefined, n_start_time, var_b2e32ae2, clientnum);
                } else {
                    update_alignment(clientnum);
                    _e_array[clientnum] animation::play(animation, m_align, m_tag, n_rate, n_blend, undefined, n_lerp_time, undefined, n_start_time, var_b2e32ae2, clientnum);
                }
            }
        } else {
            /#
                cscriptbundleobjectbase::log("<dev string:x123>" + animation + "<dev string:x140>");
            #/
        }
        _is_valid = is_alive(clientnum);
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x32b259f4, Offset: 0x1cb8
    // Size: 0xc4
    function restore_saved_ent(clientnum) {
        if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.scene_ents) && isdefined(_o_scene._e_root.scene_ents[clientnum])) {
            if (isdefined(_o_scene._e_root.scene_ents[clientnum][_str_name])) {
                _e_array[clientnum] = _o_scene._e_root.scene_ents[clientnum][_str_name];
            }
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x812ece55, Offset: 0x2578
    // Size: 0x56
    function run_wait(wait_time) {
        wait_start_time = 0;
        while (wait_start_time < wait_time && !is_skipping_scene()) {
            wait_start_time += 0.016;
            waitframe(1);
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xebcb5343, Offset: 0x4fd8
    // Size: 0x9a
    function is_alive(clientnum, var_7081273e = 0) {
        if (var_7081273e) {
            if (isplayer(_e_array[clientnum])) {
                return false;
            } else {
                return (isdefined(_e_array[clientnum]) && _e_array[clientnum].model !== "");
            }
        }
        return isdefined(_e_array[clientnum]);
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xedcdde6e, Offset: 0x1d88
    // Size: 0x364
    function initialize() {
        flag::clear(#"ready");
        flag::clear(#"done");
        flag::clear(#"main_done");
        self notify(#"new_state");
        self endon(#"new_state");
        self notify(#"init");
        waittillframeend();
        _str_shot = scene::function_de6a7579(_o_scene._str_name, "init", _o_scene._e_root);
        var_55b4f21e = function_730a4c60(_str_shot);
        cscriptbundleobjectbase::error(!isdefined(var_55b4f21e), "Shot struct is not defined for this object. Check and make sure that \"" + _str_shot + "\" is a valid shot name for this scene bundle");
        if (isdefined(_n_clientnum)) {
            _spawn(_n_clientnum, is_true(_s.firstframe) || isdefined(_s.initanim) || isdefined(_s.initanimloop));
        } else {
            _spawn(0, is_true(_s.firstframe) || isdefined(_s.initanim) || isdefined(_s.initanimloop));
            var_2d560016 = getmaxlocalclients();
            for (clientnum = 1; clientnum < var_2d560016; clientnum++) {
                if (isdefined(function_5c10bd79(clientnum))) {
                    _spawn(clientnum, is_true(_s.firstframe) || isdefined(_s.initanim) || isdefined(_s.initanimloop));
                }
            }
        }
        if (isdefined(_n_clientnum)) {
            thread initialize_per_client(_n_clientnum);
            return;
        }
        for (clientnum = 1; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(function_5c10bd79(clientnum))) {
                thread initialize_per_client(clientnum);
            }
        }
        initialize_per_client(0);
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5c841315, Offset: 0x3d60
    // Size: 0x1f4
    function function_4b3d4226(clientnum) {
        if (!isdefined(_e_array[clientnum]) || !isdefined(var_55b4f21e)) {
            return;
        }
        if (is_true(var_55b4f21e.preparedelete)) {
            _e_array[clientnum] delete();
            return;
        }
        if (isdefined(var_55b4f21e.var_3cd248f5)) {
            a_ents = getentarray(clientnum, var_55b4f21e.var_3cd248f5, "targetname");
            array::run_all(a_ents, &hide);
        } else if (isdefined(var_55b4f21e.var_b94164e)) {
            a_ents = getentarray(clientnum, var_55b4f21e.var_b94164e, "targetname");
            array::run_all(a_ents, &show);
        }
        if (!is_true(_e_array[clientnum].var_463f8196)) {
            if (is_true(var_55b4f21e.preparehide)) {
                _e_array[clientnum] hide();
                return;
            }
            if (is_true(var_55b4f21e.prepareshow)) {
                _e_array[clientnum] show();
            }
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc3ec38c3, Offset: 0x4ed8
    // Size: 0x98
    function function_54266b24() {
        foreach (obj in _o_scene._a_objects) {
            obj flag::wait_till_clear("camera_playing");
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf0b10e0d, Offset: 0x2e90
    // Size: 0x6e
    function function_587971b6() {
        _n_blend = isdefined(var_55b4f21e.blend) ? var_55b4f21e.blend : 0;
        var_84ca3312 = isdefined(var_55b4f21e.blendcurve) ? var_55b4f21e.blendcurve : "linear";
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4900c3db, Offset: 0x3748
    // Size: 0x58
    function get_lerp_time() {
        n_lerp_time = isdefined(var_55b4f21e.lerptime) ? var_55b4f21e.lerptime : _s.lerptime;
        return isdefined(n_lerp_time) ? n_lerp_time : 0;
    }

    // Namespace csceneobject/scene_shared
    // Params 3, eflags: 0x1 linked
    // Checksum 0xececf399, Offset: 0x3128
    // Size: 0x374
    function finish_per_client(clientnum, b_clear = 0, b_finished = 0) {
        if (!is_alive(clientnum)) {
            _cleanup(clientnum);
            _e_array[clientnum] = undefined;
            _is_valid = 0;
        }
        flag::set(#"ready");
        flag::set(#"done");
        if (isdefined(_e_array[clientnum])) {
            if (!b_finished) {
                _e_array[clientnum] stopsounds();
            }
            if (isdefined(_o_scene) && (isplayer(_e_array[clientnum]) || function_ec3fa8f5())) {
                if (scene::function_b260bdcc(_o_scene._str_name, _str_shot, _o_scene._e_root) || scene::function_6a0b0afe(_o_scene._str_mode) || b_clear) {
                    stopmaincamxcam(clientnum);
                }
            } else if (is_alive(clientnum) && (b_finished && is_true(_s.deletewhenfinished) || b_clear)) {
                _e_array[clientnum] delete();
            }
        } else if (_s.type === #"sharedplayer" || _s.type === #"player") {
            result = 0;
            if (isdefined(_o_scene) && isdefined(_o_scene._str_name) && isdefined(_o_scene._e_root) && isdefined(_str_shot)) {
                result = scene::function_b260bdcc(_o_scene._str_name, _str_shot, _o_scene._e_root) || scene::function_6a0b0afe(_o_scene._str_mode);
            }
            if (function_ec3fa8f5() && (result || b_clear)) {
                stopmaincamxcam(clientnum);
            }
        }
        _cleanup(clientnum);
    }

    // Namespace csceneobject/scene_shared
    // Params 3, eflags: 0x1 linked
    // Checksum 0x8f67841c, Offset: 0x2a78
    // Size: 0x32c
    function play_per_client(clientnum, n_start_time, b_looping = undefined) {
        self endon(#"new_state");
        util::waitforclient(clientnum);
        _spawn(clientnum);
        n_shot = get_shot(_str_shot);
        var_5e0d27b8 = function_1263065a(n_shot);
        function_ee94f77(clientnum);
        var_3f83c458 = array("blend", "cameraswitcher", "anim");
        foreach (str_entry_type in var_3f83c458) {
            if (!is_alive(clientnum)) {
                break;
            }
            foreach (n_entry in var_5e0d27b8) {
                entry = get_entry(n_shot, n_entry, str_entry_type);
                if (isdefined(entry)) {
                    switch (str_entry_type) {
                    case #"cameraswitcher":
                        thread _play_camera_anim(clientnum, entry, n_start_time);
                        break;
                    case #"anim":
                        _play_anim(clientnum, entry, 1, _n_blend, var_84ca3312, _s.mainshot, b_looping, n_start_time);
                        break;
                    case #"blend":
                        _n_blend = entry;
                        break;
                    default:
                        cscriptbundleobjectbase::error(1, "Bad timeline entry type '" + str_entry_type + "'.");
                        break;
                    }
                }
            }
        }
        function_54266b24();
        thread finish_per_client(clientnum, 0, 1);
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x35c0c137, Offset: 0x2248
    // Size: 0x3e
    function function_71b06874(n_shot) {
        if (is_true(_s.shots[n_shot].var_51093f2d)) {
            return false;
        }
        return true;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xdded0610, Offset: 0x21a0
    // Size: 0x9c
    function function_730a4c60(str_shot) {
        foreach (s_shot in _s.shots) {
            if (str_shot === s_shot.name) {
                return s_shot;
            }
        }
        return undefined;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7d861d50, Offset: 0x34a8
    // Size: 0x1c2
    function get_align_ent(clientnum) {
        e_align = undefined;
        n_shot = get_shot(_str_shot);
        if (isdefined(n_shot) && isdefined(_s.shots[n_shot].aligntarget)) {
            var_690ec5fb = _s.shots[n_shot].aligntarget;
        } else if (isdefined(_s.aligntarget) && _s.aligntarget !== _o_scene._s.aligntarget) {
            var_690ec5fb = _s.aligntarget;
        }
        if (isdefined(var_690ec5fb)) {
            a_scene_ents = [[ _o_scene ]]->get_ents();
            if (isdefined(a_scene_ents[clientnum][var_690ec5fb])) {
                e_align = a_scene_ents[clientnum][var_690ec5fb];
            } else {
                e_align = scene::get_existing_ent(clientnum, var_690ec5fb);
            }
            cscriptbundleobjectbase::error(!isdefined(e_align), "Align target '" + (isdefined(var_690ec5fb) ? "" + var_690ec5fb : "") + "' doesn't exist for scene object.");
        }
        if (!isdefined(e_align)) {
            e_align = [[ scene() ]]->get_align_ent(clientnum);
        }
        return e_align;
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5b8ad6a, Offset: 0x3678
    // Size: 0xa
    function scene() {
        return _o_scene;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9efcdd9e, Offset: 0x3b78
    // Size: 0x1da
    function _prepare(clientnum) {
        var_55b4f21e = function_730a4c60(_str_shot);
        if (!is_true(_s.issiege) && _e_array[clientnum].model !== "") {
            if (!_e_array[clientnum] hasanimtree()) {
                _e_array[clientnum] useanimtree("generic");
            }
        }
        _e_array[clientnum].anim_debug_name = _s.name;
        function_4b3d4226(clientnum);
        if (_o_scene._s scene::is_igc()) {
            _e_array[clientnum] sethighdetail(1);
        }
        _e_array[clientnum] flag::set(#"scene");
        _e_array[clientnum] flag::set(_o_scene._str_name);
        _e_array[clientnum].current_scene = _o_scene._str_name;
        _e_array[clientnum].finished_scene = undefined;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd6f59d6d, Offset: 0x2608
    // Size: 0x264
    function initialize_per_client(clientnum) {
        self endon(#"new_state");
        util::waitforclient(clientnum);
        n_shot = get_shot(_str_shot);
        _e_array[clientnum] show();
        function_ee94f77(clientnum);
        if (isdefined(_s.shots) && isdefined(_s.shots[n_shot]) && isarray(_s.shots[n_shot].entry)) {
            foreach (s_entry in _s.shots[n_shot].entry) {
                if (isdefined(s_entry.anim)) {
                    var_ad4f5efa = s_entry.anim;
                    if (_b_first_frame) {
                        _play_anim(clientnum, var_ad4f5efa, 0, undefined, _s.mainshot);
                        break;
                    }
                    if (isanimlooping(clientnum, var_ad4f5efa)) {
                        thread _play_anim(clientnum, var_ad4f5efa, 1, undefined, _s.mainshot);
                        continue;
                    }
                    _play_anim(clientnum, var_ad4f5efa, 1, undefined, _s.mainshot);
                }
            }
        }
        flag::set(#"ready");
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x85df07ef, Offset: 0x47b0
    // Size: 0x5de
    function update_alignment(clientnum) {
        m_align = get_align_ent(clientnum);
        m_tag = get_align_tag();
        var_cd4673f4 = is_true(_s.var_132e5621);
        var_2dd2901f = (isdefined(_o_scene._s.var_922b4fc5) ? _o_scene._s.var_922b4fc5 : 0, isdefined(_o_scene._s.var_3e692842) ? _o_scene._s.var_3e692842 : 0, isdefined(_o_scene._s.var_be60a82b) ? _o_scene._s.var_be60a82b : 0);
        var_acf1be3a = (isdefined(_o_scene._s.var_16999a5d) ? _o_scene._s.var_16999a5d : 0, isdefined(_o_scene._s.var_29563fd6) ? _o_scene._s.var_29563fd6 : 0, isdefined(_o_scene._s.var_eb00c330) ? _o_scene._s.var_eb00c330 : 0);
        var_24a7cd13 = (isdefined(_s.var_922b4fc5) ? _s.var_922b4fc5 : 0, isdefined(_s.var_3e692842) ? _s.var_3e692842 : 0, isdefined(_s.var_be60a82b) ? _s.var_be60a82b : 0);
        var_75cdf4bd = (isdefined(_s.var_16999a5d) ? _s.var_16999a5d : 0, isdefined(_s.var_29563fd6) ? _s.var_29563fd6 : 0, isdefined(_s.var_eb00c330) ? _s.var_eb00c330 : 0);
        var_2a3b0294 = (isdefined(var_55b4f21e.var_922b4fc5) ? var_55b4f21e.var_922b4fc5 : 0, isdefined(var_55b4f21e.var_3e692842) ? var_55b4f21e.var_3e692842 : 0, isdefined(var_55b4f21e.var_be60a82b) ? var_55b4f21e.var_be60a82b : 0);
        var_f3bd6699 = (isdefined(var_55b4f21e.var_16999a5d) ? var_55b4f21e.var_16999a5d : 0, isdefined(var_55b4f21e.var_29563fd6) ? var_55b4f21e.var_29563fd6 : 0, isdefined(var_55b4f21e.var_eb00c330) ? var_55b4f21e.var_eb00c330 : 0);
        if (var_2a3b0294 != (0, 0, 0)) {
            var_d3c21d73 = var_2a3b0294;
        } else if (var_24a7cd13 != (0, 0, 0)) {
            var_d3c21d73 = var_24a7cd13;
        } else {
            var_d3c21d73 = var_2dd2901f;
        }
        if (var_f3bd6699 != (0, 0, 0)) {
            v_ang_offset = var_f3bd6699;
        } else if (var_75cdf4bd != (0, 0, 0)) {
            v_ang_offset = var_75cdf4bd;
        } else {
            v_ang_offset = var_acf1be3a;
        }
        if (m_align == level) {
            m_align = (0, 0, 0) + var_d3c21d73;
            m_tag = (0, 0, 0) + v_ang_offset;
            return;
        }
        if (var_d3c21d73 != (0, 0, 0) || v_ang_offset != (0, 0, 0)) {
            v_pos = m_align.origin + var_d3c21d73;
            if (var_cd4673f4) {
                v_ang = _e_array[clientnum].angles;
            } else {
                v_ang = m_align.angles + v_ang_offset;
            }
            m_align = {#origin:v_pos, #angles:v_ang};
            return;
        }
        if (var_cd4673f4) {
            v_pos = m_align.origin;
            v_ang = _e_array[clientnum].angles;
            m_align = {#origin:v_pos, #angles:v_ang};
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 4, eflags: 0x1 linked
    // Checksum 0xdf78e144, Offset: 0x1c58
    // Size: 0x56
    function first_init(s_objdef, o_scene, e_ent, localclientnum) {
        cscriptbundleobjectbase::init(s_objdef, o_scene, e_ent, localclientnum);
        _assign_unique_name();
        return self;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc8fbbabd, Offset: 0x20f8
    // Size: 0x9c
    function get_shot(str_shot) {
        foreach (n_shot, s_shot in _s.shots) {
            if (str_shot === s_shot.name) {
                return n_shot;
            }
        }
        return undefined;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc3368f7e, Offset: 0x4fa8
    // Size: 0x22
    function has_init_state(str_scenedef) {
        return _s scene::_has_init_state(str_scenedef);
    }

    // Namespace csceneobject/scene_shared
    // Params 3, eflags: 0x1 linked
    // Checksum 0xe855ecbc, Offset: 0x2290
    // Size: 0xf2
    function get_entry(n_shot = 0, n_entry, str_entry_type) {
        if (isdefined(_s.shots[n_shot]) && isdefined(_s.shots[n_shot].entry) && isdefined(_s.shots[n_shot].entry[n_entry])) {
            if (isdefined(_s.shots[n_shot].entry[n_entry].(str_entry_type))) {
                entry = _s.shots[n_shot].entry[n_entry].(str_entry_type);
            }
        }
        return entry;
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc0911714, Offset: 0x3710
    // Size: 0xa
    function get_name() {
        return _str_name;
    }

    // Namespace csceneobject/scene_shared
    // Params 3, eflags: 0x1 linked
    // Checksum 0x894fea57, Offset: 0x2878
    // Size: 0x1f4
    function play(str_shot = "play", n_start_time, b_looping = undefined) {
        flag::clear(#"ready");
        flag::clear(#"done");
        flag::clear(#"main_done");
        self notify(#"new_state");
        self endon(#"new_state");
        self notify(#"play");
        waittillframeend();
        [[ _o_scene ]]->function_7a1288f1(str_shot);
        _str_shot = str_shot;
        var_55b4f21e = function_730a4c60(_str_shot);
        cscriptbundleobjectbase::error(!isdefined(var_55b4f21e), "Shot struct is not defined for this object. Check and make sure that \"" + _str_shot + "\" is a valid shot name for this scene bundle");
        if (isdefined(_n_clientnum)) {
            play_per_client(_n_clientnum, n_start_time, b_looping);
            return;
        }
        for (clientnum = 1; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(function_5c10bd79(clientnum))) {
                thread play_per_client(clientnum, n_start_time, b_looping);
            }
        }
        play_per_client(0, n_start_time, b_looping);
    }

    // Namespace csceneobject/scene_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa4e68265, Offset: 0x3028
    // Size: 0xf4
    function finish(b_clear = 0, b_finished = 0) {
        self notify(#"new_state");
        if (isdefined(_n_clientnum)) {
            finish_per_client(_n_clientnum, b_clear, b_finished);
            return;
        }
        for (clientnum = 1; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(function_5c10bd79(clientnum))) {
                finish_per_client(clientnum, b_clear, b_finished);
            }
        }
        finish_per_client(0, b_clear, b_finished);
    }

    // Namespace csceneobject/scene_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x240a40ce, Offset: 0x2390
    // Size: 0x118
    function find_entry(n_shot = 0, str_entry_type) {
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

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc854091c, Offset: 0x2e00
    // Size: 0x82
    function function_dd4f74e1(clientnum) {
        if (is_true(_s.firstframe) && _o_scene._str_mode == "init" && isdefined(_e_array[clientnum])) {
            _b_first_frame = 1;
            return;
        }
        _b_first_frame = 0;
    }

    // Namespace csceneobject/scene_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7293d216, Offset: 0x37a8
    // Size: 0x3c4
    function _spawn(clientnum, b_hide = 1) {
        restore_saved_ent(clientnum);
        if (!isdefined(_e_array[clientnum])) {
            b_allows_multiple = [[ scene() ]]->allows_multiple();
            _e_array[clientnum] = scene::get_existing_ent(clientnum, _str_name);
            if (!isdefined(_e_array[clientnum]) && isdefined(_s.name) && !b_allows_multiple) {
                _e_array[clientnum] = scene::get_existing_ent(clientnum, _s.name);
            }
            if (!isdefined(_e_array[clientnum]) && !is_true(_s.nospawn) && !_b_spawnonce_used && isdefined(_s.model)) {
                _e_align = get_align_ent(clientnum);
                _e_array[clientnum] = util::spawn_anim_model(clientnum, _s.model, _e_align.origin, _e_align.angles);
                cscriptbundleobjectbase::error(!isdefined(_e_array[clientnum]), "util::spawn_anim_model returned undefined");
                if (_s.type === #"fakeplayer" || _s.type === #"player") {
                    _e_array[clientnum] useanimtree("all_player");
                    _e_array[clientnum].animtree = "all_player";
                }
                if (isdefined(_e_array[clientnum])) {
                    if (b_hide && !is_true(_e_array[clientnum].var_463f8196)) {
                        _e_array[clientnum] hide();
                    }
                    _e_array[clientnum].scene_spawned = _o_scene._s.name;
                } else {
                    cscriptbundleobjectbase::error(!is_true(_s.nospawn), "No entity exists with matching name of scene object.");
                }
            }
        }
        if (isdefined(_e_array[clientnum])) {
            [[ _o_scene ]]->assign_ent(self, _e_array[clientnum], clientnum);
            _prepare(clientnum);
        }
        flag::set(#"ready");
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x647b223b, Offset: 0x2f08
    // Size: 0x114
    function function_ebbbd00d() {
        if (_b_first_frame) {
            return;
        }
        n_spacer_min = var_55b4f21e.spacermin;
        n_spacer_max = var_55b4f21e.spacermax;
        if (!is_skipping_scene() && (isdefined(n_spacer_min) || isdefined(n_spacer_max))) {
            if (isdefined(n_spacer_min) && isdefined(n_spacer_max)) {
                if (!cscriptbundleobjectbase::error(n_spacer_min >= n_spacer_max, "Spacer Min value must be less than Spacer Max value!")) {
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

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1df9f021, Offset: 0x4e10
    // Size: 0xbc
    function function_ec3fa8f5() {
        if (isarray(var_55b4f21e.entry)) {
            foreach (s_entry in var_55b4f21e.entry) {
                if (s_entry.var_71bac06 === "cameraswitcher") {
                    return true;
                }
            }
        }
        return false;
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1c05d31a, Offset: 0x3690
    // Size: 0x76
    function _assign_unique_name() {
        if (isdefined(_s.name)) {
            _str_name = _s.name;
            return;
        }
        _str_name = _o_scene._str_name + "_noname" + [[ scene() ]]->get_object_id();
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x99dbcdf5, Offset: 0x4d98
    // Size: 0x6c
    function get_align_tag() {
        if (isdefined(var_55b4f21e.aligntargettag)) {
            return var_55b4f21e.aligntargettag;
        }
        if (isdefined(_s.aligntargettag)) {
            return _s.aligntargettag;
        }
        return _o_scene._s.aligntargettag;
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7a35aa4d, Offset: 0x3728
    // Size: 0x12
    function get_orig_name() {
        return _s.name;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xdd329728, Offset: 0x4100
    // Size: 0x1f4
    function function_fda037ff(clientnum) {
        if (!isdefined(_e_array[clientnum]) || !isdefined(var_55b4f21e)) {
            return;
        }
        if (is_true(var_55b4f21e.cleanupdelete)) {
            _e_array[clientnum] delete();
            return;
        }
        if (isdefined(var_55b4f21e.var_39fd697b)) {
            a_ents = getentarray(clientnum, var_55b4f21e.var_39fd697b, "targetname");
            array::run_all(a_ents, &hide);
        } else if (isdefined(var_55b4f21e.var_4ceff7a6)) {
            a_ents = getentarray(clientnum, var_55b4f21e.var_4ceff7a6, "targetname");
            array::run_all(a_ents, &show);
        }
        if (!is_true(_e_array[clientnum].var_463f8196)) {
            if (is_true(var_55b4f21e.cleanuphide)) {
                _e_array[clientnum] hide();
                return;
            }
            if (is_true(var_55b4f21e.cleanupshow)) {
                _e_array[clientnum] show();
            }
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8cc50499, Offset: 0x25d8
    // Size: 0x22
    function is_skipping_scene() {
        return is_true([[ _o_scene ]]->is_skipping_scene());
    }

}

// Namespace scene/scene_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xde1bffb8, Offset: 0x6e8
// Size: 0x11c
function player_scene_animation_skip(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    anim_name = self getcurrentanimscriptedname();
    if (isdefined(anim_name) && anim_name != "") {
        if (!isanimlooping(bwastimejump, anim_name)) {
            /#
                if (getdvarint(#"debug_scene_skip", 0) > 0) {
                    printtoprightln("<dev string:x38>" + anim_name + "<dev string:x59>" + gettime(), (0.6, 0.6, 0.6));
                }
            #/
            self setanimtimebyname(anim_name, 1, 1);
        }
    }
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xd72d851, Offset: 0x810
// Size: 0x94
function player_scene_skip_completed(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    flushsubtitles(bwastimejump);
    setdvar(#"r_graphiccontentblur", 0);
    setdvar(#"r_makedark_enable", 0);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x86127324, Offset: 0x8820
// Size: 0xba
function get_existing_ent(clientnum, str_name) {
    e = getent(clientnum, str_name, "animname");
    if (!isdefined(e)) {
        e = getent(clientnum, str_name, "script_animname");
        if (!isdefined(e)) {
            e = getent(clientnum, str_name, "targetname");
            if (!isdefined(e)) {
                e = struct::get(str_name, "targetname");
            }
        }
    }
    return e;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x6
// Checksum 0xe21bed64, Offset: 0x88e8
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"scene", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x2211ab32, Offset: 0x8940
// Size: 0x4cc
function private function_70a657d8() {
    level.scenedefs = getscriptbundlenames("scene");
    level.active_scenes = [];
    level.var_1e798f4c = [];
    cp_skip_scene_menu::register();
    level.server_scenes = [];
    foreach (str_scenename in level.scenedefs) {
        s_scenedef = getscriptbundle(str_scenename);
        if (s_scenedef.vmtype === "server") {
            continue;
        }
        s_scenedef.editaction = undefined;
        s_scenedef.newobject = undefined;
        if (s_scenedef is_igc()) {
            level.server_scenes[s_scenedef.name] = s_scenedef;
            continue;
        }
        if (s_scenedef.vmtype === "both") {
            n_clientbits = getminbitcountfornum(3);
            /#
                n_clientbits = getminbitcountfornum(6);
            #/
            clientfield::register("world", s_scenedef.name, 1, n_clientbits, "int", &cf_server_sync, 0, 0);
        }
    }
    clientfield::register("toplayer", "postfx_igc", 1, 2, "counter", &postfx_igc, 0, 0);
    clientfield::register("world", "in_igc", 1, 4, "int", &in_igc, 0, 0);
    clientfield::register("toplayer", "postfx_cateye", 1, 1, "int", &postfx_cateye, 0, 0);
    clientfield::register("toplayer", "player_scene_skip_completed", 1, 2, "counter", &player_scene_skip_completed, 0, 0);
    clientfield::register("toplayer", "player_pbg_bank_scene_system", 1, getminbitcountfornum(3), "int", &player_pbg_bank_scene_system, 0, 0);
    clientfield::register("allplayers", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    clientfield::register("actor", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    clientfield::register("vehicle", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    clientfield::register("scriptmover", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    if (sessionmodeiscampaigngame()) {
        level.interactive_shot = interactive_shot::register();
    }
    callback::on_localclient_shutdown(&on_localplayer_shutdown);
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x309500d2, Offset: 0x8e18
// Size: 0x112
function player_pbg_bank_scene_system(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 0:
        setpbgactivebank(fieldname, 1);
        break;
    case 1:
        setpbgactivebank(fieldname, 2);
        break;
    case 2:
        setpbgactivebank(fieldname, 4);
        break;
    case 3:
        setpbgactivebank(fieldname, 8);
        break;
    }
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x117e33bf, Offset: 0x8f38
// Size: 0x234
function in_igc(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    player = function_5c10bd79(fieldname);
    n_entnum = player getentitynumber();
    b_igc_active = 0;
    if (bwastimejump & 1 << n_entnum) {
        b_igc_active = 1;
    }
    if (b_igc_active) {
        flushsubtitles(fieldname);
    }
    igcactive(fieldname, b_igc_active);
    level notify(#"igc_activated", {#b_active:b_igc_active});
    if (isarray(level.var_25e5c959)) {
        foreach (var_ed8205c6 in level.var_25e5c959) {
            a_players = getplayers(fieldname);
            foreach (player in a_players) {
                if (isdefined(player)) {
                    player thread [[ var_ed8205c6 ]](fieldname, b_igc_active);
                }
            }
        }
    }
    /#
    #/
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x5b631d6f, Offset: 0x9178
// Size: 0x88
function function_2e58158b(func_igc) {
    if (!isdefined(level.var_25e5c959)) {
        level.var_25e5c959 = [];
    } else if (!isarray(level.var_25e5c959)) {
        level.var_25e5c959 = array(level.var_25e5c959);
    }
    level.var_25e5c959[level.var_25e5c959.size] = func_igc;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x42fa0f58, Offset: 0x9208
// Size: 0x2c
function function_e78401d1(func_igc) {
    arrayremovevalue(level.var_25e5c959, func_igc);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x7dc3e253, Offset: 0x9240
// Size: 0xb4
function function_f9036ea7(b_enable) {
    if (!sessionmodeiscampaigngame()) {
        return;
    }
    if (b_enable) {
        if (!is_true(self.var_c7329df1)) {
            self.var_c7329df1 = 1;
            self postfx::playpostfxbundle("pstfx_catseye_cinematic");
        }
        return;
    }
    if (is_true(self.var_c7329df1)) {
        self.var_c7329df1 = undefined;
        self postfx::stoppostfxbundle("pstfx_catseye_cinematic");
    }
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xec4f80af, Offset: 0x9300
// Size: 0xb4
function postfx_cateye(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    player = function_5c10bd79(fieldname);
    level notify(#"sndlevelstartduck_shutoff");
    if (bwastimejump) {
        player function_f9036ea7(1);
        return;
    }
    player function_f9036ea7(0);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x5d66be36, Offset: 0x93c0
// Size: 0x82
function private on_localplayer_shutdown(localclientnum) {
    localplayer = self;
    codelocalplayer = function_5c10bd79(localclientnum);
    if (isdefined(localplayer) && isplayer(localplayer)) {
        if (isdefined(codelocalplayer)) {
            if (localplayer == codelocalplayer) {
                localplayer.postfx_igc_on = undefined;
                localplayer.pstfx_world_construction = 0;
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x2f39ab22, Offset: 0x9450
// Size: 0x6d6
function postfx_igc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (is_true(self.postfx_igc_on)) {
        return;
    }
    if (sessionmodeiszombiesgame()) {
        postfx_igc_zombies(localclientnum);
        return;
    }
    if (newval == 3) {
        self thread postfx_igc_short(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        return;
    }
    self.postfx_igc_on = 1;
    codeimagename = "postfx_igc_image" + localclientnum;
    createscenecodeimage(localclientnum, codeimagename);
    captureframe(localclientnum, codeimagename);
    n_hex = 0;
    b_streamer_wait = 1;
    for (i = 0; i < 2000; i += int(0.016 * 1000)) {
        st = float(i) / 1000;
        if (b_streamer_wait && st >= 0.65) {
            for (n_streamer_time_total = 0; !isstreamerready() && n_streamer_time_total < 5000; n_streamer_time_total += gettime() - n_streamer_time) {
                n_streamer_time = gettime();
                for (j = int(0.65 * 1000); j < 1150; j += int(0.016 * 1000)) {
                    jt = float(j) / 1000;
                    waitframe(1);
                }
                for (j = int(1.15 * 1000); j < 650; j -= int(0.016 * 1000)) {
                    jt = float(j) / 1000;
                    waitframe(1);
                }
            }
            b_streamer_wait = 0;
        }
        if (st <= 0.5) {
        } else if (st > 0.5 && st <= 0.85) {
        }
        if (newval == 2) {
            if (st > 1 && !is_true(self.pstfx_world_construction)) {
                self thread postfx::playpostfxbundle(#"pstfx_world_construction");
                self.pstfx_world_construction = 1;
            }
        }
        if (st > 0.5 && st <= 1) {
            n_hex = mapfloat(0.5, 1, 0, 1, st);
            if (st >= 0.8) {
            }
        } else if (st > 1 && st < 1.5) {
        }
        if (st > 0.65 && st <= 1.15) {
        } else if (st > 1.21 && st < 1.5) {
        }
        if (st > 1.21 && st <= 1.5) {
        } else if (st < 1.5) {
        }
        if (st > 1 && st <= 1.45) {
        } else if (st > 1.45 && st < 1.75) {
        } else if (st >= 1.75) {
        }
        if (st >= 1.75) {
            val = 1 - mapfloat(1.75, 2, 0, 1, st);
        }
        if (st >= 1.25) {
            val = 1 - mapfloat(1.25, 1.75, 0, 1, st);
        }
        if (st >= 1.75 && st < 2) {
        }
        if (st > 1) {
            outer_radii = mapfloat(1, 1.5, 0, 2000, st);
        }
        if (st > 1.15 && st < 1.85) {
        } else if (st >= 1.85) {
        }
        waitframe(1);
    }
    self.pstfx_world_construction = 0;
    freecodeimage(localclientnum, codeimagename);
    self.postfx_igc_on = undefined;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x116d8333, Offset: 0x9b30
// Size: 0x56
function postfx_igc_zombies(*localclientnum) {
    self lui::screen_fade_out(0, "black");
    waitframe(1);
    self lui::screen_fade_in(0.3);
    self.postfx_igc_on = undefined;
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x2b91157f, Offset: 0x9b90
// Size: 0x196
function postfx_igc_short(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    self.postfx_igc_on = 1;
    codeimagename = "postfx_igc_image" + bwastimejump;
    createscenecodeimage(bwastimejump, codeimagename);
    captureframe(bwastimejump, codeimagename);
    b_streamer_wait = 1;
    for (i = 0; i < 850; i += int(0.016 * 1000)) {
        st = float(i) / 1000;
        if (st <= 0.5) {
        } else if (st > 0.5 && st <= 0.85) {
        }
        waitframe(1);
    }
    freecodeimage(bwastimejump, codeimagename);
    self.postfx_igc_on = undefined;
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x9836a835, Offset: 0x9d30
// Size: 0x1ca
function cf_server_sync(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    switch (fieldname) {
    case 0:
        if (is_active(bwastimejump)) {
            level thread stop(bwastimejump);
        }
        break;
    case 1:
        level thread init(bwastimejump);
        break;
    case 2:
        level thread play(bwastimejump);
        break;
    }
    /#
        switch (fieldname) {
        case 3:
            if (is_active(bwastimejump)) {
                level thread stop(bwastimejump, 1, undefined, undefined, 1);
            }
            break;
        case 4:
            level thread init(bwastimejump, undefined, undefined, 1);
            break;
        case 5:
            level thread play(bwastimejump, undefined, undefined, 1);
            break;
        }
    #/
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xd949af6c, Offset: 0x9f08
// Size: 0x150
function remove_invalid_scene_objects(s_scenedef) {
    a_invalid_object_indexes = [];
    if (isdefined(s_scenedef.objects)) {
        foreach (i, s_object in s_scenedef.objects) {
            if (!isdefined(s_object.name) && !isdefined(s_object.model)) {
                if (!isdefined(a_invalid_object_indexes)) {
                    a_invalid_object_indexes = [];
                } else if (!isarray(a_invalid_object_indexes)) {
                    a_invalid_object_indexes = array(a_invalid_object_indexes);
                }
                a_invalid_object_indexes[a_invalid_object_indexes.size] = i;
            }
        }
    }
    for (i = a_invalid_object_indexes.size - 1; i >= 0; i--) {
        arrayremoveindex(s_scenedef.objects, a_invalid_object_indexes[i]);
    }
    return s_scenedef;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x4bdc3640, Offset: 0xa060
// Size: 0xce
function function_585fb738(str_scene, var_79fe29db) {
    if (isdefined(str_scene)) {
        s_bundle = getscriptbundle(str_scene);
    } else {
        s_bundle = self;
        str_scene = s_bundle.name;
    }
    if (is_true(s_bundle.igc)) {
        return;
    }
    if (function_7aa3d2c6(str_scene) || get_player_count(str_scene) || is_true(var_79fe29db)) {
        s_bundle.igc = 1;
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x119e8e1b, Offset: 0xa138
// Size: 0x1a
function is_igc() {
    return is_true(self.igc);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xa24473d0, Offset: 0xa160
// Size: 0x70
function function_9503138e(object = self) {
    if (object.classname === "scriptbundle_scene") {
        return true;
    }
    if (object.classname === "scriptbundle_fxanim") {
        return true;
    }
    if (object.variantname === "smart_object") {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x1ec21181, Offset: 0xa1d8
// Size: 0x36
function function_6a0b0afe(str_mode) {
    if (issubstr(str_mode, "single")) {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xa52f33d3, Offset: 0xa218
// Size: 0x538
function private postinit() {
    util::waitforallclients();
    if (isdefined(level.disablefxaniminsplitscreencount)) {
        if (isdefined(level.localplayers)) {
            if (level.localplayers.size >= level.disablefxaniminsplitscreencount) {
                return;
            }
        }
    }
    a_instances = arraycombine(struct::get_array("scriptbundle_scene", "classname"), struct::get_array("scriptbundle_fxanim", "classname"), 0, 0);
    a_instances = arraycombine(a_instances, struct::get_array("smart_object", "variantname"), 0, 0);
    foreach (s_instance in a_instances) {
        s_scenedef = getscriptbundle(s_instance.scriptbundlename);
        if (s_scenedef.vmtype !== "client") {
            continue;
        }
        if (isdefined(s_instance.scriptgroup_initscenes)) {
            trigs = getentarray(0, s_instance.scriptgroup_initscenes, "scriptgroup_initscenes");
            if (isdefined(trigs)) {
                foreach (trig in trigs) {
                    s_instance thread _trigger_init(trig);
                }
            }
        }
        if (isdefined(s_instance.scriptgroup_playscenes)) {
            trigs = getentarray(0, s_instance.scriptgroup_playscenes, "scriptgroup_playscenes");
            if (isdefined(trigs)) {
                foreach (trig in trigs) {
                    s_instance thread _trigger_play(trig);
                }
            }
        }
        if (isdefined(s_instance.scriptgroup_stopscenes)) {
            trigs = getentarray(0, s_instance.scriptgroup_stopscenes, "scriptgroup_stopscenes");
            if (isdefined(trigs)) {
                foreach (trig in trigs) {
                    s_instance thread _trigger_stop(trig);
                }
            }
        }
    }
    foreach (s_instance in a_instances) {
        s_scenedef = get_scenedef(s_instance.scriptbundlename);
        assert(isdefined(s_scenedef), "<dev string:x17f>" + s_instance.origin + "<dev string:x192>" + s_instance.scriptbundlename + "<dev string:x1aa>");
        if (s_scenedef.vmtype === "client") {
            if (isdefined(s_instance.spawnflags) && (s_instance.spawnflags & 2) == 2) {
                s_instance thread play();
                continue;
            }
            if (isdefined(s_instance.spawnflags) && (s_instance.spawnflags & 1) == 1) {
                s_instance thread init();
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xec4819c4, Offset: 0xa758
// Size: 0xb4
function _trigger_init(trig) {
    trig endon(#"death");
    s_waitresult = trig waittill(#"trigger");
    a_ents = [];
    if (get_player_count(self.scriptbundlename) > 0) {
        if (isplayer(s_waitresult.activator)) {
            a_ents[0] = s_waitresult.activator;
        }
    }
    self thread init(a_ents);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x802145a5, Offset: 0xa818
// Size: 0xe6
function _trigger_play(trig) {
    trig endon(#"death");
    do {
        s_waitresult = trig waittill(#"trigger");
        a_ents = [];
        if (get_player_count(self.scriptbundlename) > 0) {
            if (isplayer(s_waitresult.activator)) {
                a_ents[0] = s_waitresult.activator;
            }
        }
        self thread play(a_ents);
    } while (is_true(get_scenedef(self.scriptbundlename).looping));
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc8450daf, Offset: 0xa908
// Size: 0x54
function _trigger_stop(trig) {
    trig endon(#"death");
    trig waittill(#"trigger");
    self thread stop();
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x21 linked variadic
// Checksum 0x20158a09, Offset: 0xa968
// Size: 0x174
function add_scene_func(str_scenedef, func, var_e21c4c4c = "play", ...) {
    assert(isdefined(getscriptbundle(str_scenedef)), "<dev string:x1c3>" + function_9e72a96(str_scenedef) + "<dev string:x1aa>");
    var_e21c4c4c = tolower(var_e21c4c4c);
    if (!isdefined(level.scene_funcs)) {
        level.scene_funcs = [];
    }
    if (!isdefined(level.scene_funcs[str_scenedef])) {
        level.scene_funcs[str_scenedef] = [];
    }
    str_shot = function_c776e5bd(str_scenedef, var_e21c4c4c);
    if (!isdefined(level.scene_funcs[str_scenedef][str_shot])) {
        level.scene_funcs[str_scenedef][str_shot] = [];
    }
    array::add(level.scene_funcs[str_scenedef][str_shot], array(func, vararg), 0);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xe18da3ff, Offset: 0xaae8
// Size: 0x17c
function remove_scene_func(str_scenedef, func, var_e21c4c4c = "play") {
    assert(isdefined(getscriptbundle(str_scenedef)), "<dev string:x1f1>" + str_scenedef + "<dev string:x1aa>");
    var_e21c4c4c = tolower(var_e21c4c4c);
    if (!isdefined(level.scene_funcs)) {
        level.scene_funcs = [];
    }
    str_shot = function_c776e5bd(str_scenedef, var_e21c4c4c);
    if (isdefined(level.scene_funcs[str_scenedef]) && isdefined(level.scene_funcs[str_scenedef][str_shot])) {
        for (i = level.scene_funcs[str_scenedef][str_shot].size - 1; i >= 0; i--) {
            if (level.scene_funcs[str_scenedef][str_shot][i][0] == func) {
                arrayremoveindex(level.scene_funcs[str_scenedef][str_shot], i);
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x5 linked
// Checksum 0x10faa1f9, Offset: 0xac70
// Size: 0x92
function private function_c776e5bd(str_scenedef, str_state) {
    str_shot = str_state;
    if (str_state == "init") {
        str_shot = function_de6a7579(str_scenedef, "init");
    } else if (str_state == "play") {
        str_shot = function_de6a7579(str_scenedef, "play");
    }
    return str_shot;
}

// Namespace scene/scene_shared
// Params 5, eflags: 0x0
// Checksum 0x8fb2800, Offset: 0xad10
// Size: 0x168
function spawn(arg1, arg2, arg3, arg4, b_test_run) {
    str_scenedef = arg1;
    assert(isdefined(str_scenedef), "<dev string:x222>");
    if (isvec(arg2)) {
        v_origin = arg2;
        v_angles = arg3;
        a_ents = arg4;
    } else {
        a_ents = arg2;
        v_origin = arg3;
        v_angles = arg4;
    }
    s_instance = spawnstruct();
    s_instance.origin = isdefined(v_origin) ? v_origin : (0, 0, 0);
    s_instance.angles = isdefined(v_angles) ? v_angles : (0, 0, 0);
    s_instance.classname = "scriptbundle_scene";
    s_instance.scriptbundlename = str_scenedef;
    s_instance struct::init();
    s_instance init(str_scenedef, a_ents, undefined, b_test_run);
    return s_instance;
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x418ed627, Offset: 0xae80
// Size: 0x4c
function init(arg1, arg2, arg3, b_test_run) {
    self thread play(arg1, arg2, arg3, b_test_run, "init");
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xd8c9f247, Offset: 0xaed8
// Size: 0x88
function get_scenedef(str_scenedef) {
    s_scriptbundle = getscriptbundle(str_scenedef);
    assert(isdefined(s_scriptbundle) && isdefined(s_scriptbundle.objects), "<dev string:x250>" + function_9e72a96(str_scenedef) + "<dev string:x261>");
    return s_scriptbundle;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x834ab999, Offset: 0xaf68
// Size: 0x13a
function get_scenedefs(str_type = "scene") {
    a_scenedefs = [];
    foreach (str_scenedef in level.scenedefs) {
        s_scenedef = getscriptbundle(str_scenedef);
        if (s_scenedef.scenetype === str_type && s_scenedef.vmtype === "client") {
            if (!isdefined(a_scenedefs)) {
                a_scenedefs = [];
            } else if (!isarray(a_scenedefs)) {
                a_scenedefs = array(a_scenedefs);
            }
            a_scenedefs[a_scenedefs.size] = s_scenedef;
        }
    }
    return a_scenedefs;
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x1cb3307d, Offset: 0xb0b0
// Size: 0xa2
function function_8d8ec9b5(str_scenedef, a_str_shot_names, s_instance) {
    if (isdefined(s_instance)) {
        s_instance.a_str_shot_names = a_str_shot_names;
        s_instance.var_418c40ac = a_str_shot_names[a_str_shot_names.size - 1];
        return;
    }
    s_scenedef = get_scenedef(str_scenedef);
    s_scenedef.a_str_shot_names = a_str_shot_names;
    level.var_1e798f4c[str_scenedef] = a_str_shot_names;
    s_scenedef.var_418c40ac = a_str_shot_names[a_str_shot_names.size - 1];
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xd43f6be7, Offset: 0xb160
// Size: 0x328
function get_all_shot_names(str_scenedef, s_instance, var_8c4d2266 = 0) {
    if (isdefined(s_instance) && isdefined(s_instance.a_str_shot_names)) {
        a_shots = s_instance.a_str_shot_names;
        if (var_8c4d2266) {
            arrayremovevalue(a_shots, "init");
        }
        return a_shots;
    }
    if (isdefined(level.var_1e798f4c) && isdefined(level.var_1e798f4c[str_scenedef])) {
        a_shots = level.var_1e798f4c[str_scenedef];
        if (var_8c4d2266) {
            arrayremovevalue(a_shots, "init");
        }
        return a_shots;
    }
    s_scenedef = get_scenedef(str_scenedef);
    if (isdefined(s_scenedef.a_str_shot_names)) {
        a_shots = s_scenedef.a_str_shot_names;
        if (var_8c4d2266) {
            arrayremovevalue(a_shots, "init");
        }
        return s_scenedef.a_str_shot_names;
    }
    a_shots = [];
    foreach (s_object in s_scenedef.objects) {
        if (!is_true(s_object.disabled) && isdefined(s_object.shots)) {
            foreach (s_shot in s_object.shots) {
                if (!isdefined(a_shots)) {
                    a_shots = [];
                } else if (!isarray(a_shots)) {
                    a_shots = array(a_shots);
                }
                if (!isinarray(a_shots, s_shot.name)) {
                    a_shots[a_shots.size] = s_shot.name;
                }
            }
        }
    }
    s_scenedef.a_str_shot_names = a_shots;
    s_scenedef.var_418c40ac = a_shots[a_shots.size - 1];
    if (var_8c4d2266) {
        arrayremovevalue(a_shots, "init");
    }
    return a_shots;
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x834bb121, Offset: 0xb490
// Size: 0x84
function function_b260bdcc(str_scenedef, str_shot, s_instance) {
    var_418c40ac = function_c9770402(str_scenedef, s_instance);
    s_scenedef = get_scenedef(str_scenedef);
    if (str_shot !== "init" && str_shot === var_418c40ac) {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x122e7ee5, Offset: 0xb520
// Size: 0x126
function function_c9770402(str_scenedef, s_instance) {
    if (isdefined(s_instance) && isdefined(s_instance.var_418c40ac)) {
        return s_instance.var_418c40ac;
    }
    if (isdefined(level.var_1e798f4c) && isdefined(level.var_1e798f4c[str_scenedef])) {
        a_shots = level.var_1e798f4c[str_scenedef];
        return a_shots[a_shots.size - 1];
    }
    s_scenedef = get_scenedef(str_scenedef);
    if (isdefined(s_scenedef.str_final_bundle)) {
        return s_scenedef.str_final_bundle;
    }
    if (isdefined(s_scenedef.var_418c40ac)) {
        return s_scenedef.var_418c40ac;
    }
    a_shots = get_all_shot_names(str_scenedef, s_instance);
    s_scenedef.var_418c40ac = a_shots[a_shots.size - 1];
    return a_shots[a_shots.size - 1];
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x1195d845, Offset: 0xb650
// Size: 0x1d4
function _init_instance(str_scenedef = self.scriptbundlename, a_ents, b_test_run = 0) {
    s_bundle = get_scenedef(str_scenedef);
    if (!isdefined(s_bundle) || !function_6f382548(s_bundle, str_scenedef)) {
        return;
    }
    /#
        assert(isdefined(str_scenedef), "<dev string:x2d0>" + (isdefined(self.origin) ? self.origin : "<dev string:x2de>") + "<dev string:x2e7>");
        assert(isdefined(s_bundle), "<dev string:x2d0>" + (isdefined(self.origin) ? self.origin : "<dev string:x2de>") + "<dev string:x306>" + str_scenedef + "<dev string:x1aa>");
    #/
    o_scene = get_active_scene(str_scenedef);
    if (isdefined(o_scene)) {
        if (isdefined(self.scriptbundlename) && !b_test_run) {
            return o_scene;
        }
        thread [[ o_scene ]]->initialize(1);
    } else {
        o_scene = new cscene();
        [[ o_scene ]]->init(str_scenedef, s_bundle, self, a_ents, b_test_run);
    }
    return o_scene;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xbc11e70c, Offset: 0xb830
// Size: 0x1cc
function function_6f382548(struct, str_scene_name) {
    if (!isdefined(struct.disableinsplitscreen) || !(getdvarint(#"splitscreen_playercount", 1) > 1)) {
        return true;
    }
    if (struct.disableinsplitscreen == 2 && getdvarint(#"splitscreen_playercount", 1) > 1 || struct.disableinsplitscreen == 3 && getdvarint(#"splitscreen_playercount", 1) > 2 || struct.disableinsplitscreen == 4 && getdvarint(#"splitscreen_playercount", 1) > 3) {
        /#
            if (struct.type === "<dev string:x323>") {
                str_debug = "<dev string:x32c>" + function_9e72a96(str_scene_name) + "<dev string:x336>";
            } else {
                str_debug = "<dev string:x370>" + function_9e72a96(struct.name) + "<dev string:x381>" + str_scene_name + "<dev string:x38f>";
            }
            println(str_debug);
        #/
        return false;
    }
    return true;
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x74929876, Offset: 0xba08
// Size: 0x10e
function function_de6a7579(str_scenedef, str_mode, s_instance) {
    a_shots = get_all_shot_names(str_scenedef, s_instance);
    if (a_shots.size == 0) {
        return "play";
    } else if (str_mode !== "init") {
        if (a_shots[0] !== "init") {
            str_shot = a_shots[0];
        } else if (a_shots.size > 1) {
            str_shot = a_shots[1];
        }
    } else if (str_mode === "init") {
        if (isinarray(a_shots, "init")) {
            str_shot = "init";
        } else {
            str_shot = a_shots[0];
        }
    }
    if (!isdefined(str_shot)) {
        str_shot = "play";
    }
    return str_shot;
}

// Namespace scene/scene_shared
// Params 6, eflags: 0x1 linked
// Checksum 0xf73318c4, Offset: 0xbb20
// Size: 0xec
function play_from_time(arg1, arg2, arg3, n_time, var_c9d6bbb = 1, var_20dda4d1 = 0) {
    if (var_c9d6bbb) {
        str_mode = "play_from_time_normalized";
    } else {
        str_mode = "play_from_time_elapsed";
    }
    if ((function_d3e3e0c7(arg1) || function_d3e3e0c7(arg2)) && var_20dda4d1) {
        str_mode += "_single";
    }
    play(arg1, arg2, arg3, 0, str_mode, n_time);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xcefc76e8, Offset: 0xbc18
// Size: 0x9a
function function_d3e3e0c7(arg) {
    if (isstring(arg) && !isinarray(level.scenedefs, hash(arg)) && !isinarray(array("targetname", "script_noteworthy"), arg)) {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 5, eflags: 0x1 linked
// Checksum 0xaff0afb6, Offset: 0xbcc0
// Size: 0x19a
function function_d1abba8b(str_scenedef, str_shot, str_mode, n_time, var_5b51581a = 0) {
    var_8b21886e = spawnstruct();
    if (issubstr(str_mode, "play_from_time_normalized")) {
        if (var_5b51581a) {
            var_8b21886e.var_ef711d04 = str_shot;
            var_8b21886e.var_3486c904 = float(n_time);
            return var_8b21886e;
        } else {
            var_f3f679dd = float(n_time) * function_12479eba(str_scenedef);
        }
    } else if (issubstr(str_mode, "play_from_time_elapsed")) {
        if (var_5b51581a) {
            var_c74251a4 = function_8582657c(str_scenedef, str_shot);
            var_8b21886e.var_ef711d04 = str_shot;
            var_8b21886e.var_3486c904 = float(n_time) / var_c74251a4;
            return var_8b21886e;
        } else {
            var_f3f679dd = float(n_time);
        }
    }
    var_8b21886e = function_dde5f483(str_scenedef, var_f3f679dd);
    return var_8b21886e;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x4c548d52, Offset: 0xbe68
// Size: 0x21a
function function_1eab8670(obj, str_shot) {
    var_5a162d58 = 0;
    n_anim_length = 0;
    if (isdefined(obj.shots)) {
        foreach (s_shot in obj.shots) {
            if (is_true(s_shot.var_51093f2d)) {
                continue;
            }
            if (s_shot.name === str_shot && isdefined(s_shot.entry)) {
                foreach (s_entry in s_shot.entry) {
                    if (isdefined(s_entry.cameraswitcher)) {
                        var_5a162d58 += float(getcamanimtime(s_entry.cameraswitcher)) / 1000;
                        continue;
                    }
                    if (isdefined(s_entry.anim)) {
                        n_anim_length += getanimlength(s_entry.anim);
                    }
                }
                break;
            }
        }
    }
    n_length = max(var_5a162d58, n_anim_length);
    return n_length;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xfe4fcad, Offset: 0xc090
// Size: 0x23a
function function_dde5f483(str_scenedef, n_elapsed_time) {
    s_scenedef = get_scenedef(str_scenedef);
    a_shots = get_all_shot_names(str_scenedef, undefined, 1);
    var_7a2504a = 0;
    var_8b21886e = spawnstruct();
    foreach (str_shot in a_shots) {
        var_958bccd3 = 0;
        foreach (obj in s_scenedef.objects) {
            var_657b76cc = function_1eab8670(obj, str_shot);
            if (var_657b76cc > var_958bccd3) {
                var_958bccd3 = var_657b76cc;
            }
        }
        var_219aac3f = var_7a2504a;
        var_68790830 = var_219aac3f + var_958bccd3;
        if (n_elapsed_time >= var_219aac3f && n_elapsed_time < var_68790830) {
            var_8b21886e.var_ef711d04 = str_shot;
            var_8b21886e.var_3486c904 = (n_elapsed_time - var_219aac3f) / var_958bccd3;
            return var_8b21886e;
        }
        var_7a2504a += var_958bccd3;
    }
    var_8b21886e.var_ef711d04 = a_shots[a_shots.size - 1];
    var_8b21886e.var_3486c904 = 0.9;
    return var_8b21886e;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x7a2b7d7a, Offset: 0xc2d8
// Size: 0x126
function function_8582657c(var_b9a72490, str_shot) {
    if (isstring(var_b9a72490) || ishash(var_b9a72490)) {
        s_scenedef = get_scenedef(var_b9a72490);
    } else {
        s_scenedef = var_b9a72490;
    }
    var_a0c66830 = 0;
    foreach (obj in s_scenedef.objects) {
        var_657b76cc = function_1eab8670(obj, str_shot);
        if (var_657b76cc > var_a0c66830) {
            var_a0c66830 = var_657b76cc;
        }
    }
    return var_a0c66830;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xeaa744b2, Offset: 0xc408
// Size: 0xf8
function function_12479eba(str_scenedef) {
    s_scenedef = get_scenedef(str_scenedef);
    a_shots = get_all_shot_names(str_scenedef, undefined, 1);
    var_9d90ef8b = 0;
    foreach (str_shot in a_shots) {
        var_9d90ef8b += function_8582657c(s_scenedef, str_shot);
    }
    return var_9d90ef8b;
}

// Namespace scene/scene_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x61d3bc61, Offset: 0xc508
// Size: 0xca
function function_67e52759(str_scenedef, s_instance, var_8c4d2266, startsearch, var_62e8e2f0) {
    a_shots = get_all_shot_names(str_scenedef, s_instance, var_8c4d2266);
    if (isdefined(startsearch) || isdefined(var_62e8e2f0)) {
        a_shots = array::slice(a_shots, isdefined(startsearch) ? startsearch : 0, isdefined(var_62e8e2f0) ? var_62e8e2f0 : 2147483647);
    }
    s_shot = array::random(a_shots);
    return s_shot;
}

// Namespace scene/scene_shared
// Params 6, eflags: 0x1 linked
// Checksum 0xa097d653, Offset: 0xc5e0
// Size: 0x45c
function play(arg1, arg2, arg3, b_test_run = 0, str_mode = "", n_time) {
    s_tracker = spawnstruct();
    s_tracker.n_scene_count = 1;
    if (self == level) {
        a_instances = [];
        if (isstring(arg1) || ishash(arg1)) {
            if (isstring(arg1) && issubstr(arg1, ",")) {
                a_toks = strtok(arg1, ",");
                str_value = a_toks[0];
                str_key = a_toks[1];
                if (isstring(arg2)) {
                    str_shot = tolower(arg2);
                    a_ents = arg3;
                    var_5b51581a = 1;
                } else {
                    a_ents = arg2;
                }
            } else if (isinarray(level.scenedefs, hash(arg1))) {
                str_scenedef = arg1;
                var_583db6f0 = 1;
            } else {
                str_value = arg1;
                str_key = "targetname";
            }
            if (isstring(arg2)) {
                if (isinarray(array("targetname", "script_noteworthy"), arg2)) {
                    str_key = arg2;
                } else {
                    str_shot = tolower(arg2);
                    var_5b51581a = 1;
                }
                a_ents = arg3;
            } else {
                a_ents = arg2;
            }
            a_instances = _get_scene_instances(str_value, str_key, str_scenedef);
            if (a_instances.size) {
                s_tracker.n_scene_count = a_instances.size;
                foreach (s_instance in a_instances) {
                    if (isdefined(s_instance)) {
                        if (!is_true(var_583db6f0)) {
                            str_scenedef = s_instance.scriptbundlename;
                        }
                        if (!is_true(var_5b51581a)) {
                            str_shot = function_de6a7579(str_scenedef, str_mode, s_instance);
                        } else if (!issubstr(str_mode, "play_from_time")) {
                            str_mode = "single";
                        }
                        s_instance thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_shot, str_mode, n_time, var_5b51581a);
                    }
                }
            } else {
                _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode, n_time);
            }
        }
    } else {
        _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode, n_time);
    }
    function_c802b491(s_tracker, str_mode);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x5 linked
// Checksum 0xa5294acf, Offset: 0xca48
// Size: 0x84
function private function_c802b491(s_tracker, str_mode) {
    level endon(#"demo_jump");
    if (s_tracker.n_scene_count > 0 && !is_true(s_tracker.var_93ec5dde) && str_mode !== "init") {
        s_tracker waittill(#"scene_done");
    }
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x45b1b40a, Offset: 0xcad8
// Size: 0xba
function function_46546b5c(s_tracker, str_scenedef) {
    if (getdvarint(#"hash_862358d532e674c", 0) === 1) {
        var_41c1a1b7 = getscriptbundle(str_scenedef);
        if (is_true(var_41c1a1b7.var_2af733c9)) {
            /#
                iprintlnbold("<dev string:x3b8>" + str_scenedef);
            #/
            s_tracker.var_93ec5dde = 1;
            return true;
        }
    }
    return false;
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x13de60f3, Offset: 0xcba0
// Size: 0x28c
function _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run = 0, str_mode = "", n_time) {
    if (isstring(arg1) || ishash(arg1)) {
        if (isinarray(level.scenedefs, hash(arg1))) {
            str_scenedef = arg1;
            if (isstring(arg2)) {
                str_shot = arg2;
                a_ents = arg3;
            } else {
                a_ents = arg2;
            }
        } else {
            str_shot = arg1;
            a_ents = arg2;
        }
    } else if (isarray(arg1)) {
        str_scenedef = self.scriptbundlename;
        a_ents = arg1;
    } else {
        str_scenedef = self.scriptbundlename;
        if (isstring(arg2)) {
            str_shot = arg2;
            a_ents = arg3;
        }
    }
    s_tracker.n_scene_count = 1;
    if (!isdefined(str_shot) && isdefined(str_scenedef)) {
        str_shot = function_de6a7579(str_scenedef, str_mode, self);
    } else if (isdefined(str_shot)) {
        /#
            if (str_mode === "<dev string:x3d7>") {
                iprintlnbold("<dev string:x3df>");
                println("<dev string:x3df>");
            }
        #/
        if (str_mode !== "init" && !issubstr(str_mode, "play_from_time")) {
            str_mode = "single";
        }
        var_5b51581a = 1;
    }
    self thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_shot, str_mode, n_time, var_5b51581a);
}

// Namespace scene/scene_shared
// Params 8, eflags: 0x1 linked
// Checksum 0xbc369217, Offset: 0xce38
// Size: 0x3d8
function _play_instance(s_tracker, str_scenedef = self.scriptbundlename, a_ents, b_test_run, str_shot = "play", str_mode, n_time, var_5b51581a) {
    if (isdefined(n_time) && issubstr(str_mode, "play_from_time")) {
        var_8b21886e = function_d1abba8b(str_scenedef, str_shot, str_mode, n_time, var_5b51581a);
        str_shot = var_8b21886e.var_ef711d04;
        var_dd2b75b = var_8b21886e.var_3486c904;
        str_mode += ":" + var_dd2b75b;
    }
    if (str_mode === "init") {
        str_shot = function_de6a7579(str_scenedef, str_mode, self);
    }
    if (function_46546b5c(s_tracker, str_scenedef)) {
        waitframe(1);
        self notify(#"scene_done");
        return;
    }
    if (self.scriptbundlename === str_scenedef) {
        str_scenedef = self.scriptbundlename;
        if (!is_true(self.script_play_multiple)) {
            if (!isdefined(self.scene_played)) {
                self.scene_played = [];
            }
            if (is_true(self.scene_played[str_shot]) && !b_test_run) {
                waittillframeend();
                while (is_playing(str_scenedef)) {
                    waitframe(1);
                }
                println("<dev string:x41b>" + str_scenedef + "<dev string:x426>");
                s_tracker notify(#"scene_done");
                return;
            }
        }
        if (str_mode == "init") {
            self.scene_played[str_shot] = 0;
        } else {
            self.scene_played[str_shot] = 1;
        }
    }
    o_scene = _init_instance(str_scenedef, a_ents, b_test_run);
    /#
        function_8ee42bf(o_scene);
    #/
    if (str_mode != "init") {
        if (!is_true(self.var_135bd649)) {
            util::function_35840de8(self.script_delay);
        }
        if (isdefined(o_scene)) {
            thread [[ o_scene ]]->play(str_shot, b_test_run, str_mode);
            if (isdefined(o_scene._a_objects) && o_scene._a_objects.size) {
                o_scene waittill_instance_scene_done(str_scenedef);
            }
        }
        if (isdefined(self)) {
            if (isdefined(self.scriptbundlename) && is_true(get_scenedef(self.scriptbundlename).looping)) {
                self.scene_played[str_shot] = 0;
            }
        }
    }
    /#
        function_8ee42bf(o_scene);
    #/
    s_tracker.n_scene_count--;
    s_tracker notify(#"scene_done");
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x95f744c0, Offset: 0xd218
// Size: 0x3a
function private waittill_instance_scene_done(*str_scenedef) {
    level endon(#"demo_jump");
    self waittill(#"scene_done");
}

// Namespace scene/scene_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x6bdc6eb7, Offset: 0xd260
// Size: 0x2b4
function stop(arg1, arg2, arg3, b_cancel, b_no_assert = 0) {
    if (self == level) {
        if (isstring(arg1) || ishash(arg1)) {
            if (isstring(arg2)) {
                str_value = arg1;
                str_key = arg2;
                b_clear = arg3;
            } else {
                str_value = arg1;
                b_clear = arg2;
            }
            if (isdefined(str_key)) {
                a_instances = struct::get_array(str_value, str_key);
                assert(b_no_assert || a_instances.size, "<dev string:x499>" + str_key + "<dev string:x4ba>" + str_value + "<dev string:x4c1>");
                str_value = undefined;
            } else {
                a_instances = struct::get_array(str_value, "targetname");
                if (!a_instances.size) {
                    a_instances = get_active_scenes(str_value);
                } else {
                    str_value = undefined;
                }
            }
            foreach (s_instance in arraycopy(a_instances)) {
                if (isdefined(s_instance)) {
                    s_instance _stop_instance(b_clear, str_value, b_cancel);
                }
            }
        }
        return;
    }
    if (isstring(arg1) || ishash(arg1)) {
        _stop_instance(arg2, arg1, b_cancel);
        return;
    }
    _stop_instance(arg1, arg2, b_cancel);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x97e9f4bb, Offset: 0xd520
// Size: 0x100
function _stop_instance(b_clear = 0, str_scenedef, b_cancel = 0) {
    if (isdefined(self.scenes)) {
        foreach (o_scene in arraycopy(self.scenes)) {
            str_scene_name = o_scene._str_name;
            if (!isdefined(str_scenedef) || str_scene_name == str_scenedef) {
                thread [[ o_scene ]]->stop(b_clear, b_cancel);
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x95eb585f, Offset: 0xd628
// Size: 0x3c
function cancel(arg1, arg2, arg3) {
    stop(arg1, arg2, arg3, 1);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x3ba79ab2, Offset: 0xd670
// Size: 0x24c
function delete_scene_spawned_ents(localclientnum, arg1) {
    if (self == level) {
        a_instances = [];
        if (isstring(arg1) || ishash(arg1)) {
            if (isstring(arg1) && issubstr(arg1, ",")) {
                a_toks = strtok(arg1, ",");
                str_value = a_toks[0];
                str_key = a_toks[1];
            } else if (isinarray(level.scenedefs, hash(arg1))) {
                str_scenedef = arg1;
            } else {
                str_value = arg1;
                str_key = "targetname";
            }
            a_instances = _get_scene_instances(str_value, str_key, str_scenedef, 1);
            if (a_instances.size) {
                foreach (instance in a_instances) {
                    instance _delete_scene_spawned_ents(localclientnum, str_scenedef);
                }
            }
        }
        return;
    }
    if (isstring(arg1) || ishash(arg1)) {
        str_scenedef = arg1;
    }
    self _delete_scene_spawned_ents(localclientnum, str_scenedef);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xcacd5408, Offset: 0xd8c8
// Size: 0xf0
function _delete_scene_spawned_ents(localclientnum, *str_scene) {
    if (isarray(self.scene_ents) && isarray(self.scene_ents[str_scene])) {
        foreach (ent in self.scene_ents[str_scene]) {
            if (isdefined(ent) && isdefined(ent.scene_spawned)) {
                ent delete();
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x300f873d, Offset: 0xd9c0
// Size: 0xe4
function has_init_state(str_scenedef) {
    s_scenedef = get_scenedef(str_scenedef);
    foreach (s_obj in s_scenedef.objects) {
        if (!is_true(s_obj.disabled) && s_obj _has_init_state(str_scenedef)) {
            return true;
        }
    }
    return false;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x846eb24b, Offset: 0xdab0
// Size: 0x8c
function _has_init_state(str_scenedef) {
    return isinarray(get_all_shot_names(str_scenedef), "init") || is_true(self.spawnoninit) || isdefined(self.initanim) || isdefined(self.initanimloop) || is_true(self.firstframe);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x4ccffebb, Offset: 0xdb48
// Size: 0x22
function get_prop_count(str_scenedef) {
    return _get_type_count("prop", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x6ebf988d, Offset: 0xdb78
// Size: 0x22
function get_vehicle_count(str_scenedef) {
    return _get_type_count("vehicle", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x948aee06, Offset: 0xdba8
// Size: 0x22
function get_actor_count(str_scenedef) {
    return _get_type_count("actor", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xebc0b208, Offset: 0xdbd8
// Size: 0x22
function function_7aa3d2c6(str_scenedef) {
    return _get_type_count("sharedplayer", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xabea64b4, Offset: 0xdc08
// Size: 0x22
function get_player_count(str_scenedef) {
    return _get_type_count("player", str_scenedef);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xe83bbe2d, Offset: 0xdc38
// Size: 0x11c
function _get_type_count(str_type, str_scenedef) {
    s_scenedef = isdefined(str_scenedef) ? get_scenedef(str_scenedef) : get_scenedef(self.scriptbundlename);
    n_count = 0;
    foreach (s_obj in s_scenedef.objects) {
        if (isdefined(s_obj.type)) {
            if (tolower(s_obj.type) == tolower(str_type)) {
                n_count++;
            }
        }
    }
    return n_count;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x1a78cff4, Offset: 0xdd60
// Size: 0x4e
function is_active(str_scenedef) {
    if (self == level) {
        return (get_active_scenes(str_scenedef).size > 0);
    }
    return isdefined(get_active_scene(str_scenedef));
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x8a98a7a7, Offset: 0xddb8
// Size: 0x8c
function is_playing(str_scenedef) {
    if (self == level) {
        return level flag::get(str_scenedef + "_playing");
    } else {
        if (!isdefined(str_scenedef)) {
            str_scenedef = self.scriptbundlename;
        }
        o_scene = get_active_scene(str_scenedef);
        if (isdefined(o_scene)) {
            return (o_scene._str_mode === "play");
        }
    }
    return 0;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf4dab846, Offset: 0xde50
// Size: 0x108
function get_active_scenes(str_scenedef) {
    if (!isdefined(level.active_scenes)) {
        level.active_scenes = [];
    }
    if (isdefined(str_scenedef)) {
        return (isdefined(level.active_scenes[str_scenedef]) ? level.active_scenes[str_scenedef] : []);
    }
    a_active_scenes = [];
    foreach (str_scenedef, _ in level.active_scenes) {
        a_active_scenes = arraycombine(a_active_scenes, level.active_scenes[str_scenedef], 0, 0);
    }
    return a_active_scenes;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x70ba4faf, Offset: 0xdf60
// Size: 0xaa
function get_active_scene(str_scenedef) {
    if (isdefined(str_scenedef) && isdefined(self.scenes)) {
        foreach (o_scene in self.scenes) {
            if (o_scene._str_name == str_scenedef) {
                return o_scene;
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x66b28d12, Offset: 0xe018
// Size: 0x64
function is_capture_mode() {
    str_mode = getdvarstring(#"scene_menu_mode", "default");
    if (issubstr(str_mode, "capture")) {
        return 1;
    }
    return 0;
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x8da58b89, Offset: 0xe088
// Size: 0x19a
function _get_scene_instances(str_value, str_key = "targetname", str_scenedef, b_include_inactive = 0) {
    a_instances = [];
    if (isdefined(str_value)) {
        a_instances = struct::get_array(str_value, str_key);
        assert(a_instances.size, "<dev string:x499>" + str_key + "<dev string:x4ba>" + str_value + "<dev string:x4c1>");
    }
    if (isdefined(str_scenedef)) {
        a_instances_by_scenedef = struct::get_array(str_scenedef, "scriptbundlename");
        a_instances = arraycombine(a_instances_by_scenedef, a_instances, 0, 0);
        a_active_instances = get_active_scenes(str_scenedef);
        a_instances = arraycombine(a_active_instances, a_instances, 0, 0);
        if (b_include_inactive) {
            a_inactive_instances = get_inactive_scenes(str_scenedef);
            a_instances = arraycombine(a_inactive_instances, a_instances, 0, 0);
        }
    }
    return a_instances;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xe7dd972b, Offset: 0xe230
// Size: 0x108
function get_inactive_scenes(str_scenedef) {
    if (!isdefined(level.inactive_scenes)) {
        level.inactive_scenes = [];
    }
    if (isdefined(str_scenedef)) {
        return (isdefined(level.inactive_scenes[str_scenedef]) ? level.inactive_scenes[str_scenedef] : []);
    }
    a_scenes = [];
    foreach (str_scenedef, _ in level.inactive_scenes) {
        a_scenes = arraycombine(a_scenes, level.inactive_scenes[str_scenedef], 0, 0);
    }
    return a_scenes;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa73eddc9, Offset: 0xe340
// Size: 0x3a
function function_9730988a(str_scenedef, str_shotname) {
    return isinarray(get_all_shot_names(str_scenedef), str_shotname);
}

