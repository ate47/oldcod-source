#using script_64914218f744517b;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\filter_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_debug_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scriptbundle_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace scene;

// Namespace scene
// Method(s) 40 Total 44
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
    var var_b6160c2e;

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x8
    // Checksum 0xa7f50e09, Offset: 0x16d0
    // Size: 0x42
    constructor() {
        _b_spawnonce_used = 0;
        _is_valid = 1;
        _b_first_frame = 0;
        _n_blend = 0;
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4354a895, Offset: 0x4698
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
    // Params 1, eflags: 0x0
    // Checksum 0xe66be599, Offset: 0x4670
    // Size: 0x1a
    function is_alive(clientnum) {
        return isdefined(_e_array[clientnum]);
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x3feac7fc, Offset: 0x4640
    // Size: 0x22
    function has_init_state(str_scenedef) {
        return _s scene::_has_init_state(str_scenedef);
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x727bb2bc, Offset: 0x4610
    // Size: 0x24
    function wait_till_shot_ready() {
        [[ scene() ]]->wait_till_shot_ready();
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3a6a004e, Offset: 0x4580
    // Size: 0x88
    function function_2dc5ad41() {
        foreach (obj in _o_scene._a_objects) {
            obj flagsys::wait_till_clear("camera_playing");
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8d7a3779, Offset: 0x4508
    // Size: 0x6c
    function get_align_tag() {
        if (isdefined(var_b6160c2e.aligntargettag)) {
            return var_b6160c2e.aligntargettag;
        }
        if (isdefined(_s.aligntargettag)) {
            return _s.aligntargettag;
        }
        return _o_scene._s.aligntargettag;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x9888920e, Offset: 0x3f20
    // Size: 0x5de
    function update_alignment(clientnum) {
        m_align = get_align_ent(clientnum);
        m_tag = get_align_tag();
        var_e514333d = isdefined(_s.var_dd884586) && _s.var_dd884586;
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
        if (var_58e90f8 != (0, 0, 0) || v_ang_offset != (0, 0, 0)) {
            v_pos = m_align.origin + var_58e90f8;
            if (var_e514333d) {
                v_ang = _e_array[clientnum].angles;
            } else {
                v_ang = m_align.angles + v_ang_offset;
            }
            m_align = {#origin:v_pos, #angles:v_ang};
            return;
        }
        if (var_e514333d) {
            v_pos = m_align.origin;
            v_ang = _e_array[clientnum].angles;
            m_align = {#origin:v_pos, #angles:v_ang};
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 7, eflags: 0x0
    // Checksum 0x189290ac, Offset: 0x3c98
    // Size: 0x27a
    function _play_anim(clientnum, animation, n_rate = 1, n_blend, str_siege_shot, loop, n_start_time) {
        _spawn(clientnum);
        if (is_alive(clientnum)) {
            if (!(isdefined(_e_array[clientnum].var_33dc1533) && _e_array[clientnum].var_33dc1533)) {
                _e_array[clientnum] show();
            }
            if (isdefined(_s.issiege) && _s.issiege) {
                _e_array[clientnum] notify(#"end");
                _e_array[clientnum] animation::play_siege(animation, str_siege_shot, n_rate, loop);
            } else if (isdefined(loop) && loop && isdefined(_s.var_620eff18) && _s.var_620eff18) {
                _e_array[clientnum] animation::play(animation, _e_array[clientnum], m_tag, n_rate, n_blend, undefined, undefined, undefined, n_start_time);
            } else {
                update_alignment(clientnum);
                _e_array[clientnum] animation::play(animation, m_align, m_tag, n_rate, n_blend, undefined, undefined, undefined, n_start_time);
            }
        } else {
            /#
                cscriptbundleobjectbase::log("<dev string:xa9>" + animation + "<dev string:xc3>");
            #/
        }
        _is_valid = is_alive(clientnum);
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc429fcde, Offset: 0x3a78
    // Size: 0x214
    function function_4c533a8f(clientnum) {
        if (!isdefined(_e_array[clientnum]) || !isdefined(var_b6160c2e)) {
            return;
        }
        if (isdefined(var_b6160c2e.cleanupdelete) && var_b6160c2e.cleanupdelete) {
            _e_array[clientnum] delete();
            return;
        }
        if (isdefined(var_b6160c2e.var_ffff50ef)) {
            a_ents = getentarray(clientnum, var_b6160c2e.var_ffff50ef, "targetname");
            array::run_all(a_ents, &hide);
        } else if (isdefined(var_b6160c2e.var_dd24fc3e)) {
            a_ents = getentarray(clientnum, var_b6160c2e.var_dd24fc3e, "targetname");
            array::run_all(a_ents, &show);
        }
        if (!(isdefined(_e_array[clientnum].var_33dc1533) && _e_array[clientnum].var_33dc1533)) {
            if (isdefined(var_b6160c2e.cleanuphide) && var_b6160c2e.cleanuphide) {
                _e_array[clientnum] hide();
                return;
            }
            if (isdefined(var_b6160c2e.cleanupshow) && var_b6160c2e.cleanupshow) {
                _e_array[clientnum] show();
            }
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7d5f9a6a, Offset: 0x38d8
    // Size: 0x196
    function _cleanup(clientnum) {
        if (isdefined(_e_array[clientnum]) && isdefined(_e_array[clientnum].current_scene)) {
            _e_array[clientnum] flagsys::clear(_o_scene._str_name);
            _e_array[clientnum] sethighdetail(0);
            if (_e_array[clientnum].current_scene == _o_scene._str_name) {
                _e_array[clientnum] flagsys::clear(#"scene");
                _e_array[clientnum].finished_scene = _o_scene._str_name;
                _e_array[clientnum].current_scene = undefined;
            }
            function_4c533a8f(clientnum);
        }
        if (clientnum === _n_clientnum || clientnum == 0) {
            if (isdefined(_o_scene) && isdefined(_o_scene.scene_stopped) && _o_scene.scene_stopped) {
                _o_scene = undefined;
            }
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5e2d6b5a, Offset: 0x36b8
    // Size: 0x214
    function function_b7ad8af4(clientnum) {
        if (!isdefined(_e_array[clientnum]) || !isdefined(var_b6160c2e)) {
            return;
        }
        if (isdefined(var_b6160c2e.preparedelete) && var_b6160c2e.preparedelete) {
            _e_array[clientnum] delete();
            return;
        }
        if (isdefined(var_b6160c2e.var_9388a092)) {
            a_ents = getentarray(clientnum, var_b6160c2e.var_9388a092, "targetname");
            array::run_all(a_ents, &hide);
        } else if (isdefined(var_b6160c2e.var_264561fb)) {
            a_ents = getentarray(clientnum, var_b6160c2e.var_264561fb, "targetname");
            array::run_all(a_ents, &show);
        }
        if (!(isdefined(_e_array[clientnum].var_33dc1533) && _e_array[clientnum].var_33dc1533)) {
            if (isdefined(var_b6160c2e.preparehide) && var_b6160c2e.preparehide) {
                _e_array[clientnum] hide();
                return;
            }
            if (isdefined(var_b6160c2e.prepareshow) && var_b6160c2e.prepareshow) {
                _e_array[clientnum] show();
            }
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x8e5cc6c2, Offset: 0x34f0
    // Size: 0x1ba
    function _prepare(clientnum) {
        var_b6160c2e = function_301cb3ea(_str_shot);
        if (!(isdefined(_s.issiege) && _s.issiege)) {
            if (!_e_array[clientnum] hasanimtree()) {
                _e_array[clientnum] useanimtree("generic");
            }
        }
        _e_array[clientnum].anim_debug_name = _s.name;
        function_b7ad8af4(clientnum);
        if (_o_scene._s scene::is_igc()) {
            _e_array[clientnum] sethighdetail(1);
        }
        _e_array[clientnum] flagsys::set(#"scene");
        _e_array[clientnum] flagsys::set(_o_scene._str_name);
        _e_array[clientnum].current_scene = _o_scene._str_name;
        _e_array[clientnum].finished_scene = undefined;
    }

    // Namespace csceneobject/scene_shared
    // Params 2, eflags: 0x0
    // Checksum 0xc4e749c2, Offset: 0x3150
    // Size: 0x394
    function _spawn(clientnum, b_hide = 1) {
        restore_saved_ent(clientnum);
        if (!isdefined(_e_array[clientnum])) {
            b_allows_multiple = [[ scene() ]]->allows_multiple();
            _e_array[clientnum] = scene::get_existing_ent(clientnum, _str_name);
            if (!isdefined(_e_array[clientnum]) && isdefined(_s.name) && !b_allows_multiple) {
                _e_array[clientnum] = scene::get_existing_ent(clientnum, _s.name);
            }
            if (!isdefined(_e_array[clientnum]) && !(isdefined(_s.nospawn) && _s.nospawn) && !_b_spawnonce_used && isdefined(_s.model)) {
                _e_align = get_align_ent(clientnum);
                _e_array[clientnum] = util::spawn_anim_model(clientnum, _s.model, _e_align.origin, _e_align.angles);
                if (_s.type === "fakeplayer") {
                    _e_array[clientnum] useanimtree("all_player");
                    _e_array[clientnum].animtree = "all_player";
                }
                if (isdefined(_e_array[clientnum])) {
                    if (b_hide && !(isdefined(_e_array[clientnum].var_33dc1533) && _e_array[clientnum].var_33dc1533)) {
                        _e_array[clientnum] hide();
                    }
                    _e_array[clientnum].scene_spawned = _o_scene._s.name;
                } else {
                    cscriptbundleobjectbase::error(!(isdefined(_s.nospawn) && _s.nospawn), "No entity exists with matching name of scene object.");
                }
            }
        }
        if (isdefined(_e_array[clientnum])) {
            [[ _o_scene ]]->assign_ent(self, _e_array[clientnum], clientnum);
            _prepare(clientnum);
        }
        flagsys::set(#"ready");
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0xcaf81cca, Offset: 0x3130
    // Size: 0x12
    function get_orig_name() {
        return _s.name;
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x40b28805, Offset: 0x3118
    // Size: 0xa
    function get_name() {
        return _str_name;
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5927dd3b, Offset: 0x3098
    // Size: 0x76
    function _assign_unique_name() {
        if (isdefined(_s.name)) {
            _str_name = _s.name;
            return;
        }
        _str_name = _o_scene._str_name + "_noname" + [[ scene() ]]->get_object_id();
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x37900a9, Offset: 0x3080
    // Size: 0xa
    function scene() {
        return _o_scene;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0xcbbccc04, Offset: 0x2ea0
    // Size: 0x1d2
    function get_align_ent(clientnum) {
        e_align = undefined;
        n_shot = get_shot(_str_shot);
        if (isdefined(n_shot) && isdefined(_s.shots[n_shot].aligntarget)) {
            var_590588e0 = _s.shots[n_shot].aligntarget;
        } else if (isdefined(_s.aligntarget) && !(_s.aligntarget === _o_scene._s.aligntarget)) {
            var_590588e0 = _s.aligntarget;
        }
        if (isdefined(var_590588e0)) {
            a_scene_ents = [[ _o_scene ]]->get_ents();
            if (isdefined(a_scene_ents[clientnum][var_590588e0])) {
                e_align = a_scene_ents[clientnum][var_590588e0];
            } else {
                e_align = scene::get_existing_ent(clientnum, var_590588e0);
            }
            cscriptbundleobjectbase::error(!isdefined(e_align), "Align target '" + (isdefined(var_590588e0) ? "" + var_590588e0 : "") + "' doesn't exist for scene object.");
        }
        if (!isdefined(e_align)) {
            e_align = [[ scene() ]]->get_align_ent(clientnum);
        }
        return e_align;
    }

    // Namespace csceneobject/scene_shared
    // Params 3, eflags: 0x0
    // Checksum 0x3d1aa11e, Offset: 0x2c58
    // Size: 0x23c
    function finish_per_client(clientnum, b_clear = 0, b_finished = 0) {
        if (!is_alive(clientnum)) {
            _cleanup(clientnum);
            _e_array[clientnum] = undefined;
            _is_valid = 0;
        }
        flagsys::set(#"ready");
        flagsys::set(#"done");
        if (isdefined(_e_array[clientnum])) {
            if (!b_finished) {
                _e_array[clientnum] stopsounds();
            }
            if (_e_array[clientnum] isplayer() || _s.type === "sharedplayer" || _s.type === "player") {
                if (scene::function_1c059f9b(_o_scene._str_name, _str_shot, _o_scene._e_root) || b_clear) {
                    stopmaincamxcam(clientnum);
                }
            } else if (is_alive(clientnum) && (b_finished && isdefined(_s.deletewhenfinished) && _s.deletewhenfinished || b_clear)) {
                _e_array[clientnum] delete();
            }
        }
        _cleanup(clientnum);
    }

    // Namespace csceneobject/scene_shared
    // Params 2, eflags: 0x0
    // Checksum 0xc706f755, Offset: 0x2b50
    // Size: 0xfc
    function finish(b_clear = 0, b_finished = 0) {
        self notify(#"new_state");
        if (isdefined(_n_clientnum)) {
            finish_per_client(_n_clientnum, b_clear, b_finished);
            return;
        }
        for (clientnum = 1; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(function_f97e7787(clientnum))) {
                finish_per_client(clientnum, b_clear, b_finished);
            }
        }
        finish_per_client(0, b_clear, b_finished);
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x26140dd9, Offset: 0x2a28
    // Size: 0x11c
    function function_e29566e2() {
        if (_b_first_frame) {
            return;
        }
        n_spacer_min = var_b6160c2e.spacermin;
        n_spacer_max = var_b6160c2e.spacermax;
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
    // Params 0, eflags: 0x0
    // Checksum 0x7d6a994e, Offset: 0x29e8
    // Size: 0x36
    function function_90b68c4f() {
        _n_blend = isdefined(var_b6160c2e.blend) ? var_b6160c2e.blend : 0;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa79b4022, Offset: 0x2958
    // Size: 0x86
    function function_e92dd0c5(clientnum) {
        if (isdefined(_s.firstframe) && _s.firstframe && _o_scene._str_mode == "init" && isdefined(_e_array[clientnum])) {
            _b_first_frame = 1;
            return;
        }
        _b_first_frame = 0;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0xcd86f53, Offset: 0x2908
    // Size: 0x44
    function function_9abcc54d(clientnum) {
        function_e92dd0c5(clientnum);
        function_90b68c4f();
        function_e29566e2();
    }

    // Namespace csceneobject/scene_shared
    // Params 3, eflags: 0x0
    // Checksum 0xe32b5071, Offset: 0x25f8
    // Size: 0x304
    function play_per_client(clientnum, n_start_time, b_looping = undefined) {
        self endon(#"new_state");
        _spawn(clientnum);
        n_shot = get_shot(_str_shot);
        var_66f4eae7 = function_f850028d(n_shot);
        function_9abcc54d(clientnum);
        var_f2f29e4b = array("blend", "cameraswitcher", "anim");
        foreach (str_entry_type in var_f2f29e4b) {
            if (!is_alive(clientnum)) {
                break;
            }
            foreach (n_entry in var_66f4eae7) {
                entry = get_entry(n_shot, n_entry, str_entry_type);
                if (isdefined(entry)) {
                    switch (str_entry_type) {
                    case #"cameraswitcher":
                        thread _play_camera_anim(clientnum, entry, n_start_time);
                        break;
                    case #"anim":
                        _play_anim(clientnum, entry, 1, _n_blend, _s.mainshot, b_looping, n_start_time);
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
        function_2dc5ad41();
        thread finish_per_client(clientnum, 0, 1);
    }

    // Namespace csceneobject/scene_shared
    // Params 3, eflags: 0x0
    // Checksum 0x8e201d0, Offset: 0x2340
    // Size: 0x2ac
    function play(str_shot = "play", n_start_time, b_looping = undefined) {
        flagsys::clear(#"ready");
        flagsys::clear(#"done");
        flagsys::clear(#"main_done");
        self notify(#"new_state");
        self endon(#"new_state");
        self notify(#"play");
        waittillframeend();
        if (!isdefined(_o_scene._a_active_shots)) {
            _o_scene._a_active_shots = [];
        } else if (!isarray(_o_scene._a_active_shots)) {
            _o_scene._a_active_shots = array(_o_scene._a_active_shots);
        }
        if (!isinarray(_o_scene._a_active_shots, str_shot)) {
            _o_scene._a_active_shots[_o_scene._a_active_shots.size] = str_shot;
        }
        _str_shot = str_shot;
        var_b6160c2e = function_301cb3ea(_str_shot);
        cscriptbundleobjectbase::error(!isdefined(var_b6160c2e), "Shot struct is not defined for this object. Check and make sure that \"" + _str_shot + "\" is a valid shot name for this scene bundle");
        if (isdefined(_n_clientnum)) {
            play_per_client(_n_clientnum, n_start_time, b_looping);
            return;
        }
        for (clientnum = 1; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(function_f97e7787(clientnum))) {
                thread play_per_client(clientnum, n_start_time, b_looping);
            }
        }
        play_per_client(0, n_start_time, b_looping);
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x119acb9, Offset: 0x2130
    // Size: 0x204
    function initialize_per_client(clientnum) {
        self endon(#"new_state");
        n_shot = get_shot(_str_shot);
        _e_array[clientnum] show();
        function_9abcc54d(clientnum);
        foreach (s_entry in _s.shots[n_shot].entry) {
            if (isdefined(s_entry.("anim"))) {
                var_a32aeda5 = s_entry.("anim");
                if (_b_first_frame) {
                    _play_anim(clientnum, var_a32aeda5, 0, undefined, _s.mainshot);
                    break;
                }
                if (isanimlooping(clientnum, var_a32aeda5)) {
                    thread _play_anim(clientnum, var_a32aeda5, 1, undefined, _s.mainshot);
                    continue;
                }
                _play_anim(clientnum, var_a32aeda5, 1, undefined, _s.mainshot);
            }
        }
        flagsys::set(#"ready");
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa4e5f08b, Offset: 0x20f8
    // Size: 0x30
    function is_skipping_scene() {
        return isdefined([[ _o_scene ]]->is_skipping_scene()) && [[ _o_scene ]]->is_skipping_scene();
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0xca8c7d21, Offset: 0x2090
    // Size: 0x5e
    function run_wait(wait_time) {
        wait_start_time = 0;
        while (wait_start_time < wait_time && !is_skipping_scene()) {
            wait_start_time += 0.016;
            waitframe(1);
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7b6568ea, Offset: 0x1fc8
    // Size: 0xba
    function function_f850028d(n_shot = 0) {
        var_66f4eae7 = [];
        if (isdefined(_s.shots[n_shot]) && isdefined(_s.shots[n_shot].entry)) {
            var_66f4eae7 = getarraykeys(_s.shots[n_shot].entry);
            var_66f4eae7 = array::sort_by_value(var_66f4eae7, 1);
        }
        return var_66f4eae7;
    }

    // Namespace csceneobject/scene_shared
    // Params 2, eflags: 0x0
    // Checksum 0xb0d70842, Offset: 0x1eb0
    // Size: 0x10a
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
    // Params 3, eflags: 0x0
    // Checksum 0xc02f7184, Offset: 0x1da8
    // Size: 0xfe
    function get_entry(n_shot = 0, n_entry, str_entry_type) {
        if (isdefined(_s.shots[n_shot]) && isdefined(_s.shots[n_shot].entry) && isdefined(_s.shots[n_shot].entry[n_entry])) {
            if (isdefined(_s.shots[n_shot].entry[n_entry].(str_entry_type))) {
                entry = _s.shots[n_shot].entry[n_entry].(str_entry_type);
            }
        }
        return entry;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x8af83729, Offset: 0x1d48
    // Size: 0x54
    function function_bb50ab9e(n_shot) {
        if (isdefined(_s.shots[n_shot].disableshot) && _s.shots[n_shot].disableshot) {
            return false;
        }
        return true;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2ba49abf, Offset: 0x1cb0
    // Size: 0x90
    function function_301cb3ea(str_shot) {
        foreach (s_shot in _s.shots) {
            if (str_shot === s_shot.name) {
                return s_shot;
            }
        }
        return undefined;
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x48968985, Offset: 0x1c18
    // Size: 0x90
    function get_shot(str_shot) {
        foreach (n_shot, s_shot in _s.shots) {
            if (str_shot === s_shot.name) {
                return n_shot;
            }
        }
        return undefined;
    }

    // Namespace csceneobject/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x96a982b3, Offset: 0x1870
    // Size: 0x39c
    function initialize() {
        flagsys::clear(#"ready");
        flagsys::clear(#"done");
        flagsys::clear(#"main_done");
        self notify(#"new_state");
        self endon(#"new_state");
        self notify(#"init");
        waittillframeend();
        _str_shot = scene::function_d0a1d87d(_o_scene._str_name, "init", _o_scene._e_root);
        var_b6160c2e = function_301cb3ea(_str_shot);
        cscriptbundleobjectbase::error(!isdefined(var_b6160c2e), "Shot struct is not defined for this object. Check and make sure that \"" + _str_shot + "\" is a valid shot name for this scene bundle");
        if (isdefined(_n_clientnum)) {
            _spawn(_n_clientnum, isdefined(_s.firstframe) && _s.firstframe || isdefined(_s.initanim) || isdefined(_s.initanimloop));
        } else {
            _spawn(0, isdefined(_s.firstframe) && _s.firstframe || isdefined(_s.initanim) || isdefined(_s.initanimloop));
            var_bd709a67 = getmaxlocalclients();
            for (clientnum = 1; clientnum < var_bd709a67; clientnum++) {
                if (isdefined(function_f97e7787(clientnum))) {
                    if (isdefined(_s.spawnoninit) && _s.spawnoninit) {
                        _spawn(clientnum, isdefined(_s.firstframe) && _s.firstframe || isdefined(_s.initanim) || isdefined(_s.initanimloop));
                    }
                }
            }
        }
        if (isdefined(_n_clientnum)) {
            thread initialize_per_client(_n_clientnum);
            return;
        }
        for (clientnum = 1; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(function_f97e7787(clientnum))) {
                thread initialize_per_client(clientnum);
            }
        }
        initialize_per_client(0);
    }

    // Namespace csceneobject/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x8501a441, Offset: 0x17a0
    // Size: 0xc6
    function restore_saved_ent(clientnum) {
        if (isdefined(_o_scene._e_root) && isdefined(_o_scene._e_root.scene_ents) && isdefined(_o_scene._e_root.scene_ents[clientnum])) {
            if (isdefined(_o_scene._e_root.scene_ents[clientnum][_str_name])) {
                _e_array[clientnum] = _o_scene._e_root.scene_ents[clientnum][_str_name];
            }
        }
    }

    // Namespace csceneobject/scene_shared
    // Params 4, eflags: 0x0
    // Checksum 0x3b87f163, Offset: 0x1740
    // Size: 0x56
    function first_init(s_objdef, o_scene, e_ent, localclientnum) {
        cscriptbundleobjectbase::init(s_objdef, o_scene, e_ent, localclientnum);
        _assign_unique_name();
        return self;
    }

}

// Namespace scene
// Method(s) 6 Total 46
class csceneplayer : cscriptbundleobjectbase, csceneobject {

    var _e_array;
    var _n_clientnum;
    var _s;
    var var_b6160c2e;

    // Namespace csceneplayer/scene_shared
    // Params 2, eflags: 0x0
    // Checksum 0xf07dc478, Offset: 0xb90
    // Size: 0x104
    function wait_for_camera(animation, var_3cc0d7dd = 0) {
        self endon(#"skip_camera_anims");
        flagsys::set(#"camera_playing");
        if (iscamanimlooping(animation)) {
            self waittill(#"new_state");
        } else {
            n_cam_time = getcamanimtime(animation) - var_3cc0d7dd;
            self waittilltimeout(float(n_cam_time) / 1000, #"new_state");
        }
        flagsys::clear(#"camera_playing");
    }

    // Namespace csceneplayer/scene_shared
    // Params 3, eflags: 0x0
    // Checksum 0x1479a93d, Offset: 0x928
    // Size: 0x260
    function _play_camera_anim(clientnum, animation, n_start_time = 0) {
        var_ee41c05d = isdefined(_s.lerptime) ? _s.lerptime : 0;
        align = csceneobject::get_align_ent(clientnum);
        tag = csceneobject::get_align_tag();
        if (align == level) {
            v_pos = (0, 0, 0);
            v_ang = (0, 0, 0);
        } else if (isstring(tag)) {
            assert(isdefined(align.model), "<dev string:x52>" + animation + "<dev string:x6b>" + tag + "<dev string:x76>");
            v_pos = align gettagorigin(tag);
            v_ang = align gettagangles(tag);
        } else {
            v_pos = align.origin;
            v_ang = align.angles;
        }
        var_b1123b96 = isdefined(var_b6160c2e.cameraswitchername) ? var_b6160c2e.cameraswitchername : "";
        var_3cc0d7dd = n_start_time * getcamanimtime(animation);
        var_f7357fbc = getservertime(clientnum) - var_3cc0d7dd;
        playmaincamxcam(clientnum, animation, var_ee41c05d, var_b1123b96, "", v_pos, v_ang, undefined, undefined, undefined, int(var_f7357fbc));
        wait_for_camera(animation, var_3cc0d7dd);
    }

    // Namespace csceneplayer/scene_shared
    // Params 2, eflags: 0x0
    // Checksum 0x7bd6aa30, Offset: 0x8b0
    // Size: 0x6c
    function _spawn(clientnum, b_hide = 1) {
        _e_array[clientnum] = function_f97e7787(clientnum);
        flagsys::set(#"ready");
    }

    // Namespace csceneplayer/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x63aeee40, Offset: 0x7e0
    // Size: 0xc4
    function initialize() {
        flagsys::clear(#"ready");
        flagsys::clear(#"done");
        flagsys::clear(#"main_done");
        self notify(#"new_state");
        self endon(#"new_state");
        self notify(#"init");
        waittillframeend();
        if (isdefined(_n_clientnum)) {
            _spawn(_n_clientnum);
        }
    }

}

// Namespace scene
// Method(s) 26 Total 34
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
    var var_1b3d0016;
    var var_4db0451e;

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x8
    // Checksum 0x99120b98, Offset: 0x5050
    // Size: 0x3a
    constructor() {
        _n_object_id = 0;
        _str_mode = "";
        _a_active_shots = [];
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbc67ffed, Offset: 0x73d0
    // Size: 0x14
    function on_error() {
        stop();
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8dbce3b0, Offset: 0x72d8
    // Size: 0xf0
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
    // Params 0, eflags: 0x0
    // Checksum 0x5518b49a, Offset: 0x72a8
    // Size: 0x24
    function function_cdb116c6() {
        array::flagsys_wait(_a_objects, "done");
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc1cddca8, Offset: 0x7268
    // Size: 0x34
    function wait_till_shot_ready() {
        if (isdefined(_a_objects)) {
            array::flagsys_wait(_a_objects, "ready");
        }
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x50bae95e, Offset: 0x7218
    // Size: 0x46
    function is_skipping_scene() {
        return isdefined(skipping_scene) && skipping_scene || _str_mode == "skip_scene" || _str_mode == "skip_scene_player";
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8694cdb4, Offset: 0x71e8
    // Size: 0x28
    function is_looping() {
        return isdefined(_s.looping) && _s.looping;
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5482bdad, Offset: 0x71d8
    // Size: 0x8
    function allows_multiple() {
        return true;
    }

    // Namespace cscene/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0xab20ff3e, Offset: 0x7150
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
    // Params 0, eflags: 0x0
    // Checksum 0xaf2b7a61, Offset: 0x7138
    // Size: 0xa
    function get_root() {
        return _e_root;
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5563154, Offset: 0x6fa8
    // Size: 0x182
    function get_ents() {
        a_ents = [];
        for (clientnum = 0; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(function_f97e7787(clientnum))) {
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
    // Params 1, eflags: 0x0
    // Checksum 0x1f23eec9, Offset: 0x6b90
    // Size: 0x40a
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
                        assertmsg("<dev string:xd8>");
                        break;
                    }
                }
            }
        }
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x893ea4f0, Offset: 0x6ae8
    // Size: 0x9e
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
    // Params 2, eflags: 0x0
    // Checksum 0x11347ccb, Offset: 0x6790
    // Size: 0x34e
    function stop(b_clear = 0, b_finished = 0) {
        self notify(#"new_state");
        level flagsys::clear(_str_name + "_playing");
        level flagsys::clear(_str_name + "_initialized");
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
                foreach (var_7a1b6206 in _e_root.scene_played) {
                    var_7a1b6206 = 1;
                }
            }
        }
        self notify(#"scene_done", {#scenedef:_str_name});
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8632b50d, Offset: 0x6648
    // Size: 0x13c
    function get_next_shot() {
        if (_s.scenetype === "scene") {
            if (isdefined(var_1b3d0016)) {
                var_f636bfe5 = var_1b3d0016;
                var_1b3d0016 = undefined;
                return var_f636bfe5;
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
    // Params 0, eflags: 0x0
    // Checksum 0x34cc44a3, Offset: 0x6630
    // Size: 0xa
    function function_1faf391c() {
        return _str_shot;
    }

    // Namespace cscene/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x685d2a85, Offset: 0x6328
    // Size: 0x2fc
    function run_next(str_current_shot) {
        if (isdefined(_s.nextscenebundle) && _s.vmtype !== "both") {
            waitresult = self waittill(#"stopped");
            if (waitresult.is_finished) {
                if (_s.scenetype == "fxanim" && _s.nextscenemode === "init") {
                    if (!cscriptbundlebase::error(!has_init_state(), "Scene can't init next scene '" + _s.nextscenebundle + "' because it doesn't have an init state.")) {
                        if (allows_multiple()) {
                            _e_root thread scene::init(_s.nextscenebundle, get_ents());
                        } else {
                            _e_root thread scene::init(_s.nextscenebundle);
                        }
                    }
                } else if (allows_multiple()) {
                    _e_root thread scene::play(_s.nextscenebundle, get_ents());
                } else {
                    _e_root thread scene::play(_s.nextscenebundle);
                }
            }
            thread stop(0, 1);
            return;
        }
        var_f636bfe5 = get_next_shot();
        arrayremovevalue(_a_active_shots, str_current_shot);
        if (isdefined(var_f636bfe5)) {
            switch (_s.scenetype) {
            case #"scene":
                thread play(var_f636bfe5, _testing, _str_mode);
                break;
            default:
                thread play(var_f636bfe5, _testing, _str_mode);
                break;
            }
            return;
        }
        thread stop(0, 1);
    }

    // Namespace cscene/scene_shared
    // Params 4, eflags: 0x0
    // Checksum 0x1291e064, Offset: 0x5db8
    // Size: 0x564
    function play(str_shot = "play", b_testing = 0, str_mode = "", b_looping = undefined) {
        level endon(#"demo_jump");
        self notify(str_shot + "start");
        self endon(str_shot + "start", #"new_state");
        if (issubstr(str_mode, "play_from_time")) {
            args = strtok(str_mode, ":");
            if (isdefined(args[1])) {
                var_3fedc2a9 = float(args[1]);
            }
        }
        _testing = b_testing;
        _str_mode = str_mode;
        _str_shot = str_shot;
        if (get_valid_objects().size > 0) {
            foreach (o_obj in _a_objects) {
                thread [[ o_obj ]]->play(str_shot, var_3fedc2a9, b_looping);
            }
            n_start_time = undefined;
            level flagsys::set(_str_name + "_playing");
            _str_mode = "play";
            wait_till_shot_ready();
            if (!isdefined(_a_active_shots)) {
                _a_active_shots = [];
            } else if (!isarray(_a_active_shots)) {
                _a_active_shots = array(_a_active_shots);
            }
            if (!isinarray(_a_active_shots, str_shot)) {
                _a_active_shots[_a_active_shots.size] = str_shot;
            }
            thread function_70dbc7c1();
            thread _call_state_funcs(str_shot);
            function_cdb116c6();
            array::flagsys_wait_any_flag(_a_objects, "done", "main_done");
            if (scene::function_1c059f9b(_str_name, str_shot)) {
                if (isdefined(_e_root)) {
                    _e_root notify(#"scene_done", {#scenedef:_str_name});
                }
                thread _call_state_funcs("done");
                var_4db0451e = 1;
            }
            if ((is_looping() || _str_mode == "loop") && isdefined(var_4db0451e) && var_4db0451e) {
                var_4db0451e = undefined;
                if (has_init_state()) {
                    level flagsys::clear(_str_name + "_playing");
                    thread initialize();
                } else {
                    level flagsys::clear(_str_name + "_initialized");
                    var_42c66f70 = scene::function_d0a1d87d(_str_name, str_mode, _e_root);
                    thread play(var_42c66f70, b_testing, str_mode, 1);
                }
            } else if (!strendswith(_str_mode, "single")) {
                thread run_next(str_shot);
            } else {
                thread stop(0, 1);
            }
        } else {
            thread stop(0, 1);
        }
        arrayremovevalue(_a_active_shots, str_shot);
    }

    // Namespace cscene/scene_shared
    // Params 0, eflags: 0x0
    // Checksum 0x65baf2ad, Offset: 0x5ae8
    // Size: 0x2c8
    function function_70dbc7c1() {
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
    // Params 0, eflags: 0x0
    // Checksum 0x9cd02943, Offset: 0x5ac8
    // Size: 0x16
    function get_object_id() {
        _n_object_id++;
        return _n_object_id;
    }

    // Namespace cscene/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x180f4798, Offset: 0x5980
    // Size: 0x13c
    function initialize(b_playing = 0) {
        self notify(#"new_state");
        self endon(#"new_state");
        _s scene::function_ea9f6e24();
        if (get_valid_objects().size > 0) {
            level flagsys::set(_str_name + "_initialized");
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
    // Params 0, eflags: 0x0
    // Checksum 0xb45c3c39, Offset: 0x5800
    // Size: 0x178
    function get_valid_object_defs() {
        a_obj_defs = [];
        foreach (s_obj in _s.objects) {
            if (_s.vmtype === "client" || s_obj.vmtype === "client") {
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

    // Namespace cscene/scene_shared
    // Params 3, eflags: 0x0
    // Checksum 0x7248cec5, Offset: 0x5758
    // Size: 0xa0
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
    // Params 5, eflags: 0x0
    // Checksum 0x9c82201b, Offset: 0x52a8
    // Size: 0x4a4
    function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run) {
        cscriptbundlebase::init(str_scenedef, s_scenedef, b_test_run);
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        if (!cscriptbundlebase::error(a_ents.size > _s.objects.size, "Trying to use more entities than scene supports.")) {
            _e_root = e_align;
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
            foreach (str_name, e_ent in arraycopy(a_ents)) {
                foreach (i, s_obj in arraycopy(a_objs)) {
                    if (s_obj.name === (isdefined(str_name) ? "" + str_name : "")) {
                        cscriptbundlebase::add_object([[ new_object(s_obj.type) ]]->first_init(s_obj, self, e_ent, _e_root.localclientnum));
                        arrayremoveindex(a_ents, str_name);
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
    // Params 1, eflags: 0x0
    // Checksum 0x98825909, Offset: 0x50b8
    // Size: 0x1e2
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
        case #"companion":
            return new csceneplayer();
        case #"sharedcompanion":
            return new csceneplayer();
        default:
            cscriptbundlebase::error(0, "Unsupported object type '" + str_type + "'.");
            break;
        }
    }

}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0xaba6e51f, Offset: 0x618
// Size: 0x11c
function player_scene_animation_skip(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    anim_name = self getcurrentanimscriptedname();
    if (isdefined(anim_name) && anim_name != "") {
        if (!isanimlooping(localclientnum, anim_name)) {
            /#
                if (getdvarint(#"debug_scene_skip", 0) > 0) {
                    printtoprightln("<dev string:x30>" + anim_name + "<dev string:x4e>" + gettime(), (0.6, 0.6, 0.6));
                }
            #/
            self setanimtimebyname(anim_name, 1, 1);
        }
    }
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0xe02979cd, Offset: 0x740
// Size: 0x94
function player_scene_skip_completed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    flushsubtitles(localclientnum);
    setdvar(#"r_graphiccontentblur", 0);
    setdvar(#"r_makedark_enable", 0);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xdd8eb741, Offset: 0x7b40
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
// Params 0, eflags: 0x2
// Checksum 0xad422649, Offset: 0x7c08
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"scene", &__init__, &__main__, undefined);
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x9d3b3caf, Offset: 0x7c58
// Size: 0x4a4
function __init__() {
    level.scenedefs = getscriptbundlenames("scene");
    level.active_scenes = [];
    level.var_33cb0e4c = [];
    cp_skip_scene_menu::register("cp_skip_scene_menu");
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
    clientfield::register("world", "in_igc", 1, 12, "int", &in_igc, 0, 0);
    clientfield::register("toplayer", "postfx_cateye", 1, 1, "int", &postfx_cateye, 0, 0);
    clientfield::register("toplayer", "player_scene_skip_completed", 1, 2, "counter", &player_scene_skip_completed, 0, 0);
    clientfield::register("toplayer", "player_pbg_bank_scene_system", 1, getminbitcountfornum(3), "int", &player_pbg_bank_scene_system, 0, 0);
    clientfield::register("allplayers", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    clientfield::register("actor", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    clientfield::register("vehicle", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    clientfield::register("scriptmover", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    callback::on_localclient_shutdown(&on_localplayer_shutdown);
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0xf54a6b98, Offset: 0x8108
// Size: 0x112
function player_pbg_bank_scene_system(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        setpbgactivebank(localclientnum, 1);
        break;
    case 1:
        setpbgactivebank(localclientnum, 2);
        break;
    case 2:
        setpbgactivebank(localclientnum, 4);
        break;
    case 3:
        setpbgactivebank(localclientnum, 8);
        break;
    }
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0x539e9b54, Offset: 0x8228
// Size: 0x144
function in_igc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = function_f97e7787(localclientnum);
    n_entnum = player getentitynumber();
    b_igc_active = 0;
    if (newval & 1 << n_entnum) {
        b_igc_active = 1;
    }
    if (b_igc_active) {
        setsoundcontext("igc", "on");
    } else {
        setsoundcontext("igc", "");
    }
    igcactive(localclientnum, b_igc_active);
    level notify(#"igc_activated", {#b_active:b_igc_active});
    /#
    #/
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x58de5711, Offset: 0x8378
// Size: 0xac
function function_9601dfa3(b_enable) {
    if (!sessionmodeiscampaigngame()) {
        return;
    }
    if (b_enable) {
        if (!(isdefined(self.var_e0ed498e) && self.var_e0ed498e)) {
            self.var_e0ed498e = 1;
            self postfx::playpostfxbundle("pstfx_catseye_cinematic");
        }
        return;
    }
    if (isdefined(self.var_e0ed498e) && self.var_e0ed498e) {
        self.var_e0ed498e = undefined;
        self postfx::stoppostfxbundle("pstfx_catseye_cinematic");
    }
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0x79f8ab30, Offset: 0x8430
// Size: 0xb4
function postfx_cateye(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = function_f97e7787(localclientnum);
    level notify(#"sndlevelstartduck_shutoff");
    if (newval) {
        player function_9601dfa3(1);
        return;
    }
    player function_9601dfa3(0);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x4
// Checksum 0x605d9dc8, Offset: 0x84f0
// Size: 0xca
function private on_localplayer_shutdown(localclientnum) {
    localplayer = self;
    codelocalplayer = function_f97e7787(localclientnum);
    if (isdefined(localplayer) && isdefined(localplayer.localclientnum) && isdefined(codelocalplayer) && localplayer == codelocalplayer) {
        filter::disable_filter_base_frame_transition(localplayer, 5);
        filter::disable_filter_sprite_transition(localplayer, 5);
        filter::disable_filter_frame_transition(localplayer, 5);
        localplayer.postfx_igc_on = undefined;
        localplayer.pstfx_world_construction = 0;
    }
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0x52863402, Offset: 0x85c8
// Size: 0x10f6
function postfx_igc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (isdefined(self.postfx_igc_on) && self.postfx_igc_on) {
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
    filter::init_filter_base_frame_transition(self);
    filter::init_filter_sprite_transition(self);
    filter::init_filter_frame_transition(self);
    setfilterpasscodetexture(localclientnum, 5, 0, 0, codeimagename);
    setfilterpasscodetexture(localclientnum, 5, 1, 0, codeimagename);
    setfilterpasscodetexture(localclientnum, 5, 2, 0, codeimagename);
    filter::enable_filter_base_frame_transition(self, 5);
    filter::enable_filter_sprite_transition(self, 5);
    filter::enable_filter_frame_transition(self, 5);
    filter::set_filter_base_frame_transition_warp(self, 5, 1);
    filter::set_filter_base_frame_transition_boost(self, 5, 0.5);
    filter::set_filter_base_frame_transition_durden(self, 5, 1);
    filter::set_filter_base_frame_transition_durden_blur(self, 5, 1);
    filter::set_filter_sprite_transition_elapsed(self, 5, 0);
    filter::set_filter_sprite_transition_octogons(self, 5, 1);
    filter::set_filter_sprite_transition_blur(self, 5, 0);
    filter::set_filter_sprite_transition_boost(self, 5, 0);
    filter::set_filter_frame_transition_light_hexagons(self, 5, 0);
    filter::set_filter_frame_transition_heavy_hexagons(self, 5, 0);
    filter::set_filter_frame_transition_flare(self, 5, 0);
    filter::set_filter_frame_transition_blur(self, 5, 0);
    filter::set_filter_frame_transition_iris(self, 5, 0);
    filter::set_filter_frame_transition_saved_frame_reveal(self, 5, 0);
    filter::set_filter_frame_transition_warp(self, 5, 0);
    filter::set_filter_sprite_transition_move_radii(self, 5, 0, 0);
    filter::set_filter_base_frame_transition_warp(self, 5, 1);
    filter::set_filter_base_frame_transition_boost(self, 5, 1);
    n_hex = 0;
    b_streamer_wait = 1;
    for (i = 0; i < 2000; i += int(0.016 * 1000)) {
        st = float(i) / 1000;
        if (b_streamer_wait && st >= 0.65) {
            for (n_streamer_time_total = 0; !isstreamerready() && n_streamer_time_total < 5000; n_streamer_time_total += gettime() - n_streamer_time) {
                n_streamer_time = gettime();
                for (j = int(0.65 * 1000); j < 1150; j += int(0.016 * 1000)) {
                    jt = float(j) / 1000;
                    filter::set_filter_frame_transition_heavy_hexagons(self, 5, mapfloat(0.65, 1.15, 0, 1, jt));
                    waitframe(1);
                }
                for (j = int(1.15 * 1000); j < 650; j -= int(0.016 * 1000)) {
                    jt = float(j) / 1000;
                    filter::set_filter_frame_transition_heavy_hexagons(self, 5, mapfloat(0.65, 1.15, 0, 1, jt));
                    waitframe(1);
                }
            }
            b_streamer_wait = 0;
        }
        if (st <= 0.5) {
            filter::set_filter_frame_transition_iris(self, 5, mapfloat(0, 0.5, 0, 1, st));
        } else if (st > 0.5 && st <= 0.85) {
            filter::set_filter_frame_transition_iris(self, 5, 1 - mapfloat(0.5, 0.85, 0, 1, st));
        } else {
            filter::set_filter_frame_transition_iris(self, 5, 0);
        }
        if (newval == 2) {
            if (st > 1 && !(isdefined(self.pstfx_world_construction) && self.pstfx_world_construction)) {
                self thread postfx::playpostfxbundle(#"pstfx_world_construction");
                self.pstfx_world_construction = 1;
            }
        }
        if (st > 0.5 && st <= 1) {
            n_hex = mapfloat(0.5, 1, 0, 1, st);
            filter::set_filter_frame_transition_light_hexagons(self, 5, n_hex);
            if (st >= 0.8) {
                filter::set_filter_frame_transition_flare(self, 5, mapfloat(0.8, 1, 0, 1, st));
            }
        } else if (st > 1 && st < 1.5) {
            filter::set_filter_frame_transition_light_hexagons(self, 5, 1);
            filter::set_filter_frame_transition_flare(self, 5, 1);
        } else {
            filter::set_filter_frame_transition_light_hexagons(self, 5, 0);
            filter::set_filter_frame_transition_flare(self, 5, 0);
        }
        if (st > 0.65 && st <= 1.15) {
            filter::set_filter_frame_transition_heavy_hexagons(self, 5, mapfloat(0.65, 1.15, 0, 1, st));
        } else if (st > 1.21 && st < 1.5) {
            filter::set_filter_frame_transition_heavy_hexagons(self, 5, 1);
        } else {
            filter::set_filter_frame_transition_heavy_hexagons(self, 5, 0);
        }
        if (st > 1.21 && st <= 1.5) {
            filter::set_filter_frame_transition_blur(self, 5, mapfloat(1, 1.5, 0, 1, st));
            filter::set_filter_sprite_transition_boost(self, 5, mapfloat(1, 1.5, 0, 1, st));
            filter::set_filter_frame_transition_saved_frame_reveal(self, 5, mapfloat(1, 1.5, 0, 1, st));
            filter::set_filter_base_frame_transition_durden_blur(self, 5, 1 - mapfloat(1, 1.5, 0, 1, st));
            filter::set_filter_sprite_transition_blur(self, 5, mapfloat(1, 1.5, 0, 0.1, st));
        } else if (st > 1.5) {
            filter::set_filter_frame_transition_blur(self, 5, 1);
            filter::set_filter_sprite_transition_boost(self, 5, 1);
            filter::set_filter_frame_transition_saved_frame_reveal(self, 5, 1);
            filter::set_filter_base_frame_transition_durden_blur(self, 5, 0);
            filter::set_filter_sprite_transition_blur(self, 5, 0.1);
        }
        if (st > 1 && st <= 1.45) {
            filter::set_filter_base_frame_transition_boost(self, 5, mapfloat(1, 1.45, 0.5, 1, st));
        } else if (st > 1.45 && st < 1.75) {
            filter::set_filter_base_frame_transition_boost(self, 5, 1);
        } else if (st >= 1.75) {
            filter::set_filter_base_frame_transition_boost(self, 5, 1 - mapfloat(1.75, 2, 0, 1, st));
        }
        if (st >= 1.75) {
            val = 1 - mapfloat(1.75, 2, 0, 1, st);
            filter::set_filter_frame_transition_blur(self, 5, val);
            filter::set_filter_base_frame_transition_warp(self, 5, val);
        }
        if (st >= 1.25) {
            val = 1 - mapfloat(1.25, 1.75, 0, 1, st);
            filter::set_filter_sprite_transition_octogons(self, 5, val);
        }
        if (st >= 1.75 && st < 2) {
            filter::set_filter_base_frame_transition_durden(self, 5, 1 - mapfloat(1.75, 2, 0, 1, st));
        }
        if (st > 1) {
            filter::set_filter_sprite_transition_elapsed(self, 5, i - 1000);
            outer_radii = mapfloat(1, 1.5, 0, 2000, st);
            filter::set_filter_sprite_transition_move_radii(self, 5, outer_radii - 256, outer_radii);
        }
        if (st > 1.15 && st < 1.85) {
            filter::set_filter_frame_transition_warp(self, 5, -1 * mapfloat(1.15, 1.85, 0, 1, st));
        } else if (st >= 1.85) {
            filter::set_filter_frame_transition_warp(self, 5, -1 * (1 - mapfloat(1.85, 2, 0, 1, st)));
        }
        waitframe(1);
    }
    filter::disable_filter_base_frame_transition(self, 5);
    filter::disable_filter_sprite_transition(self, 5);
    filter::disable_filter_frame_transition(self, 5);
    self.pstfx_world_construction = 0;
    freecodeimage(localclientnum, codeimagename);
    self.postfx_igc_on = undefined;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xc0a46059, Offset: 0x96c8
// Size: 0x56
function postfx_igc_zombies(localclientnum) {
    lui::screen_fade_out(0, "black");
    waitframe(1);
    lui::screen_fade_in(0.3);
    self.postfx_igc_on = undefined;
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0xd5f384c6, Offset: 0x9728
// Size: 0x396
function postfx_igc_short(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self.postfx_igc_on = 1;
    codeimagename = "postfx_igc_image" + localclientnum;
    createscenecodeimage(localclientnum, codeimagename);
    captureframe(localclientnum, codeimagename);
    filter::init_filter_base_frame_transition(self);
    filter::init_filter_sprite_transition(self);
    filter::init_filter_frame_transition(self);
    setfilterpasscodetexture(localclientnum, 5, 0, 0, codeimagename);
    setfilterpasscodetexture(localclientnum, 5, 1, 0, codeimagename);
    setfilterpasscodetexture(localclientnum, 5, 2, 0, codeimagename);
    filter::enable_filter_base_frame_transition(self, 5);
    filter::enable_filter_sprite_transition(self, 5);
    filter::enable_filter_frame_transition(self, 5);
    filter::set_filter_frame_transition_iris(self, 5, 0);
    b_streamer_wait = 1;
    for (i = 0; i < 850; i += int(0.016 * 1000)) {
        st = float(i) / 1000;
        if (st <= 0.5) {
            filter::set_filter_frame_transition_iris(self, 5, mapfloat(0, 0.5, 0, 1, st));
        } else if (st > 0.5 && st <= 0.85) {
            filter::set_filter_frame_transition_iris(self, 5, 1 - mapfloat(0.5, 0.85, 0, 1, st));
        } else {
            filter::set_filter_frame_transition_iris(self, 5, 0);
        }
        waitframe(1);
    }
    filter::disable_filter_base_frame_transition(self, 5);
    filter::disable_filter_sprite_transition(self, 5);
    filter::disable_filter_frame_transition(self, 5);
    freecodeimage(localclientnum, codeimagename);
    self.postfx_igc_on = undefined;
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0xe6fb3c88, Offset: 0x9ac8
// Size: 0x1ca
function cf_server_sync(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        if (is_active(fieldname)) {
            level thread stop(fieldname);
        }
        break;
    case 1:
        level thread init(fieldname);
        break;
    case 2:
        level thread play(fieldname);
        break;
    }
    /#
        switch (newval) {
        case 3:
            if (is_active(fieldname)) {
                level thread stop(fieldname, 1, undefined, undefined, 1);
            }
            break;
        case 4:
            level thread init(fieldname, undefined, undefined, 1);
            break;
        case 5:
            level thread play(fieldname, undefined, undefined, 1);
            break;
        }
    #/
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x63d033bf, Offset: 0x9ca0
// Size: 0x15a
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
// Params 2, eflags: 0x0
// Checksum 0x4386e298, Offset: 0x9e08
// Size: 0xca
function function_ea9f6e24(str_scene, var_ca65f892) {
    if (isdefined(str_scene)) {
        s_bundle = getscriptbundle(str_scene);
    } else {
        s_bundle = self;
        str_scene = s_bundle.name;
    }
    if (isdefined(s_bundle.igc) && s_bundle.igc) {
        return;
    }
    if (function_9181f70f(str_scene) || get_player_count(str_scene) || isdefined(var_ca65f892) && var_ca65f892) {
        s_bundle.igc = 1;
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xad7f2ce3, Offset: 0x9ee0
// Size: 0x18
function is_igc() {
    return isdefined(self.igc) && self.igc;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x3fd997b8, Offset: 0x9f00
// Size: 0x4e0
function __main__() {
    waitframe(1);
    if (isdefined(level.disablefxaniminsplitscreencount)) {
        if (isdefined(level.localplayers)) {
            if (level.localplayers.size >= level.disablefxaniminsplitscreencount) {
                return;
            }
        }
    }
    a_instances = arraycombine(struct::get_array("scriptbundle_scene", "classname"), struct::get_array("scriptbundle_fxanim", "classname"), 0, 0);
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
        assert(isdefined(s_scenedef), "<dev string:xfc>" + s_instance.origin + "<dev string:x10c>" + s_instance.scriptbundlename + "<dev string:x121>");
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
// Params 1, eflags: 0x0
// Checksum 0xa57a1fa9, Offset: 0xa3e8
// Size: 0xbc
function _trigger_init(trig) {
    trig endon(#"death");
    s_waitresult = trig waittill(#"trigger");
    a_ents = [];
    if (get_player_count(self.scriptbundlename) > 0) {
        if (s_waitresult.activator isplayer()) {
            a_ents[0] = s_waitresult.activator;
        }
    }
    self thread init(a_ents);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x5cb19, Offset: 0xa4b0
// Size: 0x108
function _trigger_play(trig) {
    trig endon(#"death");
    do {
        s_waitresult = trig waittill(#"trigger");
        a_ents = [];
        if (get_player_count(self.scriptbundlename) > 0) {
            if (s_waitresult.activator isplayer()) {
                a_ents[0] = s_waitresult.activator;
            }
        }
        self thread play(a_ents);
    } while (isdefined(get_scenedef(self.scriptbundlename).looping) && get_scenedef(self.scriptbundlename).looping);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xdec3e6d8, Offset: 0xa5c0
// Size: 0x54
function _trigger_stop(trig) {
    trig endon(#"death");
    trig waittill(#"trigger");
    self thread stop();
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0x36a09bf0, Offset: 0xa620
// Size: 0x174
function add_scene_func(str_scenedef, func, var_f2be2307 = "play", ...) {
    assert(isdefined(getscriptbundle(str_scenedef)), "<dev string:x137>" + str_scenedef + "<dev string:x121>");
    var_f2be2307 = tolower(var_f2be2307);
    if (!isdefined(level.scene_funcs)) {
        level.scene_funcs = [];
    }
    if (!isdefined(level.scene_funcs[str_scenedef])) {
        level.scene_funcs[str_scenedef] = [];
    }
    str_shot = function_3017192a(str_scenedef, var_f2be2307);
    if (!isdefined(level.scene_funcs[str_scenedef][str_shot])) {
        level.scene_funcs[str_scenedef][str_shot] = [];
    }
    array::add(level.scene_funcs[str_scenedef][str_shot], array(func, vararg), 0);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x54d0fb1f, Offset: 0xa7a0
// Size: 0x18e
function remove_scene_func(str_scenedef, func, var_f2be2307 = "play") {
    assert(isdefined(getscriptbundle(str_scenedef)), "<dev string:x162>" + str_scenedef + "<dev string:x121>");
    var_f2be2307 = tolower(var_f2be2307);
    if (!isdefined(level.scene_funcs)) {
        level.scene_funcs = [];
    }
    str_shot = function_3017192a(str_scenedef, var_f2be2307);
    if (isdefined(level.scene_funcs[str_scenedef]) && isdefined(level.scene_funcs[str_scenedef][str_shot])) {
        for (i = level.scene_funcs[str_scenedef][str_shot].size - 1; i >= 0; i--) {
            if (level.scene_funcs[str_scenedef][str_shot][i][0] == func) {
                arrayremoveindex(level.scene_funcs[str_scenedef][str_shot], i);
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x4
// Checksum 0xd82fecf6, Offset: 0xa938
// Size: 0x92
function private function_3017192a(str_scenedef, str_state) {
    str_shot = str_state;
    if (str_state == "init") {
        str_shot = function_d0a1d87d(str_scenedef, "init");
    } else if (str_state == "play") {
        str_shot = function_d0a1d87d(str_scenedef, "play");
    }
    return str_shot;
}

// Namespace scene/scene_shared
// Params 5, eflags: 0x0
// Checksum 0x6df06ab7, Offset: 0xa9d8
// Size: 0x178
function spawn(arg1, arg2, arg3, arg4, b_test_run) {
    str_scenedef = arg1;
    assert(isdefined(str_scenedef), "<dev string:x190>");
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
// Params 4, eflags: 0x0
// Checksum 0x73106e77, Offset: 0xab58
// Size: 0x54
function init(arg1, arg2, arg3, b_test_run) {
    self thread play(arg1, arg2, arg3, b_test_run, "init");
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x851dfa8d, Offset: 0xabb8
// Size: 0xa2
function get_scenedef(str_scenedef) {
    s_scriptbundle = getscriptbundle(str_scenedef);
    assert(isdefined(s_scriptbundle) && isdefined(s_scriptbundle.objects), "<dev string:x1bb>" + function_15979fa9(str_scenedef) + "<dev string:x1c9>");
    s_scriptbundle = fixup_scenedef(s_scriptbundle);
    return s_scriptbundle;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x3280ef8b, Offset: 0xac68
// Size: 0x150
function get_scenedefs(str_type = "scene") {
    a_scenedefs = [];
    foreach (str_scenedef in level.scenedefs) {
        s_scenedef = getscriptbundle(str_scenedef);
        if (s_scenedef.scenetype === str_type && s_scenedef.vmtype === "client") {
            s_scenedef = fixup_scenedef(s_scenedef);
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
// Params 1, eflags: 0x0
// Checksum 0x91e63746, Offset: 0xadc0
// Size: 0x860
function fixup_scenedef(s_scenedef) {
    assert(isdefined(s_scenedef.objects), "<dev string:x235>");
    if (isdefined(s_scenedef.objects[0]) && isdefined(s_scenedef.objects[0].shots)) {
        return s_scenedef;
    }
    if (!isdefined(s_scenedef.ready_to_use)) {
        s_scenedef.ready_to_use = 1;
    } else {
        return s_scenedef;
    }
    a_invalid_object_indexes = [];
    foreach (i, s_object in s_scenedef.objects) {
        if (!isdefined(s_object.name) && !isdefined(s_object.model) && !(s_object.type === "player")) {
            if (!isdefined(a_invalid_object_indexes)) {
                a_invalid_object_indexes = [];
            } else if (!isarray(a_invalid_object_indexes)) {
                a_invalid_object_indexes = array(a_invalid_object_indexes);
            }
            a_invalid_object_indexes[a_invalid_object_indexes.size] = i;
        }
    }
    for (i = a_invalid_object_indexes.size - 1; i >= 0; i--) {
        arrayremoveindex(s_scenedef.objects, a_invalid_object_indexes[i]);
    }
    s_scenedef.editaction = undefined;
    s_scenedef.newobject = undefined;
    if (isstring(s_scenedef.femalebundle) || ishash(s_scenedef.femalebundle)) {
        s_female_bundle = struct::get_script_bundle("scene", s_scenedef.femalebundle);
        s_female_bundle.malebundle = s_scenedef.name;
        s_scenedef.s_female_bundle = s_female_bundle;
        s_female_bundle.s_male_bundle = s_scenedef;
    }
    if (isdefined(level.scene_sequence_names) && !isdefined(level.scene_sequence_names[s_scenedef.name])) {
        for (s_next_bundle = s_scenedef; isdefined(s_next_bundle); s_next_bundle = undefined) {
            level.scene_sequence_names[s_next_bundle.name] = s_scenedef.name;
            if (isdefined(s_next_bundle.nextscenebundle)) {
                s_next_bundle = getscriptbundle(s_next_bundle.nextscenebundle);
                continue;
            }
        }
    } else {
        level.scene_streamer_ignore[s_scenedef.name] = 1;
    }
    if (isstring(s_scenedef.nextscenebundle) || ishash(s_scenedef.nextscenebundle)) {
        s_next_bundle = s_scenedef;
        while (isdefined(s_next_bundle)) {
            if (isdefined(s_next_bundle.nextscenebundle)) {
                s_next_bundle = getscriptbundle(s_next_bundle.nextscenebundle);
            } else {
                s_next_bundle = undefined;
            }
            if (isdefined(s_next_bundle)) {
                s_scenedef.str_final_bundle = s_next_bundle.name;
            }
        }
        foreach (i, s_object in s_scenedef.objects) {
            if (s_object.type === "player") {
                s_object.disabletransitionout = 1;
            }
        }
        s_next_bundle = struct::get_script_bundle("scene", s_scenedef.nextscenebundle);
        s_scenedef.next_bundle = s_next_bundle;
        s_next_bundle.dontsync = 1;
        s_next_bundle.dontthrottle = 1;
        foreach (i, s_object in s_next_bundle.objects) {
            if (s_object.type === "player") {
                s_object.disabletransitionin = 1;
            }
            s_object.iscutscene = 1;
        }
        if (isdefined(s_next_bundle.femalebundle)) {
            s_next_female_bundle = struct::get_script_bundle("scene", s_next_bundle.femalebundle);
            if (isdefined(s_next_female_bundle)) {
                s_next_female_bundle.dontsync = 1;
                s_next_female_bundle.dontthrottle = 1;
                foreach (i, s_object in s_next_female_bundle.objects) {
                    if (s_object.type === "player") {
                        s_object.disabletransitionin = 1;
                    }
                    s_object.iscutscene = 1;
                }
            }
        }
    }
    foreach (i, s_object in s_scenedef.objects) {
        if (s_object.type === "player") {
            if (!isdefined(s_object.cameratween)) {
                s_object.cameratween = 0;
            }
            s_object.newplayermethod = 1;
            if (isdefined(s_object.sharedigc) && s_object.sharedigc) {
                s_object.type = "sharedplayer";
            }
        }
        if (s_object.type !== "player" && s_object.type !== "sharedplayer") {
            s_object.cameraswitcher = undefined;
        }
        s_object.player = undefined;
        if (s_object.type === "player model") {
            s_object.type = "fakeplayer";
        }
    }
    if (isstring(s_scenedef.cameraswitcher) || isstring(s_scenedef.extracamswitcher1) || isstring(s_scenedef.extracamswitcher2) || isstring(s_scenedef.extracamswitcher3) || isstring(s_scenedef.extracamswitcher4)) {
        s_scenedef.igc = 1;
    }
    convert_to_new_format(s_scenedef);
    return s_scenedef;
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0x220fba6, Offset: 0xb628
// Size: 0x1e4
function function_61cee5af(var_f0142d04, var_615a96f0, str_field, var_893cb0ac) {
    var_f0142d04--;
    var_615a96f0--;
    if (!isdefined(self.shots)) {
        self.shots = [];
    }
    if (!isdefined(self.shots[0])) {
        self.shots[0] = spawnstruct();
    }
    if (!isdefined(self.shots[0].entry)) {
        self.shots[0].entry = [];
    }
    if (!isdefined(self.shots[0].entry[0])) {
        self.shots[0].entry[0] = spawnstruct();
    }
    if (!isdefined(self.shots[var_f0142d04])) {
        self.shots[var_f0142d04] = spawnstruct();
        self.shots[var_f0142d04].entry = [];
        self.shots[var_f0142d04].entry[0] = spawnstruct();
    }
    if (!isdefined(self.shots[var_f0142d04].entry[var_615a96f0])) {
        self.shots[var_f0142d04].entry[var_615a96f0] = spawnstruct();
    }
    self.shots[var_f0142d04].entry[var_615a96f0].(str_field) = var_893cb0ac;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x616e8d27, Offset: 0xb818
// Size: 0x4a
function function_5abaf630(n_shot, str_shot_name) {
    n_shot--;
    if (isdefined(self.shots[n_shot])) {
        self.shots[n_shot].name = str_shot_name;
    }
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x4aa6dc8a, Offset: 0xb870
// Size: 0xf0
function function_1c62ac51(var_27c3bf38, str_field, var_893cb0ac) {
    if (isstruct(var_27c3bf38)) {
        var_27c3bf38.(str_field) = var_893cb0ac;
        return;
    }
    var_27c3bf38--;
    if (!isdefined(self.shots)) {
        self.shots = [];
    }
    if (!isdefined(self.shots[0])) {
        self.shots[0] = spawnstruct();
    }
    if (!isdefined(self.shots[var_27c3bf38])) {
        self.shots[var_27c3bf38] = spawnstruct();
    }
    self.shots[var_27c3bf38].(str_field) = var_893cb0ac;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xf06f532d, Offset: 0xb968
// Size: 0x802
function convert_to_new_format(s_scenedef) {
    foreach (s_object in s_scenedef.objects) {
        s_object.old_scene_version = 1;
        b_has_init = 0;
        b_has_main = 0;
        b_has_camera = 0;
        if (isdefined(s_object.firstframe) && s_object.firstframe) {
            b_has_init = 1;
            s_object function_61cee5af(1, 1, "anim", s_object.mainanim);
        } else {
            if (isdefined(s_object.initanim)) {
                b_has_init = 1;
                s_object function_61cee5af(1, 1, "anim", s_object.initanim);
            }
            if (isdefined(s_object.initanimloop)) {
                b_has_init = 1;
                s_object function_61cee5af(1, 2, "anim", s_object.initanimloop);
            }
            if (isdefined(s_object.spawnoninit) && s_object.spawnoninit) {
                b_has_init = 1;
            }
        }
        if (isdefined(s_object.cameraswitcher)) {
            b_has_main = 1;
            b_has_camera = 1;
            s_scenedef.igc = 1;
            if (b_has_init) {
                s_object function_61cee5af(2, 1, "cameraswitcher", s_object.cameraswitcher);
            } else {
                s_object function_61cee5af(1, 1, "cameraswitcher", s_object.cameraswitcher);
            }
        }
        if (!isdefined(s_object.mainblend)) {
            s_object.mainblend = 0.02;
        }
        b_has_main = 1;
        if (b_has_init) {
            if (b_has_camera) {
                s_object function_61cee5af(2, 2, "blend", s_object.mainblend);
            } else {
                s_object function_61cee5af(2, 1, "blend", s_object.mainblend);
            }
        } else if (b_has_camera) {
            s_object function_61cee5af(1, 2, "blend", s_object.mainblend);
        } else {
            s_object function_61cee5af(1, 1, "blend", s_object.mainblend);
        }
        if (isdefined(s_object.mainanim)) {
            b_has_main = 1;
            if (b_has_init) {
                if (b_has_camera) {
                    s_object function_61cee5af(2, 3, "anim", s_object.mainanim);
                } else {
                    s_object function_61cee5af(2, 2, "anim", s_object.mainanim);
                }
            } else if (b_has_camera) {
                s_object function_61cee5af(1, 3, "anim", s_object.mainanim);
            } else {
                s_object function_61cee5af(1, 2, "anim", s_object.mainanim);
            }
        }
        if (isdefined(s_object.endblend)) {
            b_has_main = 1;
            if (b_has_init) {
                s_object function_61cee5af(2, 3, "blend", s_object.endblend);
            } else {
                s_object function_61cee5af(1, 3, "blend", s_object.endblend);
            }
        }
        if (isdefined(s_object.endanim)) {
            b_has_main = 1;
            if (b_has_init) {
                s_object function_61cee5af(2, 4, "anim", s_object.endanim);
            } else {
                s_object function_61cee5af(1, 4, "anim", s_object.endanim);
            }
        }
        if (isdefined(s_object.endanimloop)) {
            b_has_main = 1;
            if (b_has_init) {
                s_object function_61cee5af(2, 5, "anim", s_object.endanimloop);
            } else {
                s_object function_61cee5af(1, 5, "anim", s_object.endanimloop);
            }
        }
        if (b_has_init) {
            s_object function_5abaf630(1, "init");
            var_be2bdbd0 = s_object.shots[0];
            if (isdefined(s_object.initdelaymin)) {
                s_object function_1c62ac51(var_be2bdbd0, "SpacerMin", s_object.initdelaymin);
            }
            if (isdefined(s_object.initdelaymax)) {
                s_object function_1c62ac51(var_be2bdbd0, "SpacerMax", s_object.initdelaymax);
            }
        }
        if (b_has_main) {
            if (b_has_init) {
                s_object function_5abaf630(2, "play");
                var_efcdd7f8 = s_object.shots[1];
            } else {
                s_object function_5abaf630(1, "play");
                var_efcdd7f8 = s_object.shots[0];
            }
            if (isdefined(s_object.maindelaymin)) {
                s_object function_1c62ac51(var_efcdd7f8, "SpacerMin", s_object.maindelaymin);
            }
            if (isdefined(s_object.maindelaymax)) {
                s_object function_1c62ac51(var_efcdd7f8, "SpacerMax", s_object.maindelaymax);
            }
        }
        s_object.initanim = undefined;
        s_object.initanimloop = undefined;
        s_object.mainblend = undefined;
        s_object.mainanim = undefined;
        s_object.endblend = undefined;
        s_object.endanim = undefined;
        s_object.endanimloop = undefined;
        s_object.initdelaymin = undefined;
        s_object.initdelaymax = undefined;
        s_object.maindelaymin = undefined;
        s_object.maindelaymax = undefined;
    }
    s_scenedef.old_scene_version = 1;
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xb8609604, Offset: 0xc178
// Size: 0xb2
function function_e94bf2b1(str_scenedef, a_str_shot_names, s_instance) {
    if (isdefined(s_instance)) {
        s_instance.a_str_shot_names = a_str_shot_names;
        s_instance.var_88029ab6 = a_str_shot_names[a_str_shot_names.size - 1];
        return;
    }
    s_scenedef = get_scenedef(str_scenedef);
    s_scenedef.a_str_shot_names = a_str_shot_names;
    level.var_33cb0e4c[str_scenedef] = a_str_shot_names;
    s_scenedef.var_88029ab6 = a_str_shot_names[a_str_shot_names.size - 1];
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xe8bae497, Offset: 0xc238
// Size: 0x330
function get_all_shot_names(str_scenedef, s_instance, var_eb7f8dae = 0) {
    if (isdefined(s_instance) && isdefined(s_instance.a_str_shot_names)) {
        a_shots = s_instance.a_str_shot_names;
        if (var_eb7f8dae) {
            arrayremovevalue(a_shots, "init");
        }
        return a_shots;
    }
    if (isdefined(level.var_33cb0e4c) && isdefined(level.var_33cb0e4c[str_scenedef])) {
        a_shots = level.var_33cb0e4c[str_scenedef];
        if (var_eb7f8dae) {
            arrayremovevalue(a_shots, "init");
        }
        return a_shots;
    }
    s_scenedef = get_scenedef(str_scenedef);
    if (isdefined(s_scenedef.a_str_shot_names)) {
        a_shots = s_scenedef.a_str_shot_names;
        if (var_eb7f8dae) {
            arrayremovevalue(a_shots, "init");
        }
        return s_scenedef.a_str_shot_names;
    }
    a_shots = [];
    foreach (s_object in s_scenedef.objects) {
        if (!(isdefined(s_object.disabled) && s_object.disabled) && isdefined(s_object.shots)) {
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
    s_scenedef.var_88029ab6 = a_shots[a_shots.size - 1];
    if (var_eb7f8dae) {
        arrayremovevalue(a_shots, "init");
    }
    return a_shots;
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x70128fe0, Offset: 0xc570
// Size: 0xbe
function function_1c059f9b(str_scenedef, str_shot, s_instance) {
    var_88029ab6 = function_f80af16d(str_scenedef, s_instance);
    s_scenedef = get_scenedef(str_scenedef);
    if (str_shot !== "init" && (str_shot === var_88029ab6 || isdefined(s_scenedef.old_scene_version) && s_scenedef.old_scene_version && str_shot === "play")) {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x61fc4e8b, Offset: 0xc638
// Size: 0x13c
function function_f80af16d(str_scenedef, s_instance) {
    if (isdefined(s_instance) && isdefined(s_instance.var_88029ab6)) {
        return s_instance.var_88029ab6;
    }
    if (isdefined(level.var_33cb0e4c) && isdefined(level.var_33cb0e4c[str_scenedef])) {
        a_shots = level.var_33cb0e4c[str_scenedef];
        return a_shots[a_shots.size - 1];
    }
    s_scenedef = get_scenedef(str_scenedef);
    if (isdefined(s_scenedef.str_final_bundle)) {
        return s_scenedef.str_final_bundle;
    }
    if (isdefined(s_scenedef.var_88029ab6)) {
        return s_scenedef.var_88029ab6;
    }
    a_shots = get_all_shot_names(str_scenedef, s_instance);
    s_scenedef.var_88029ab6 = a_shots[a_shots.size - 1];
    return a_shots[a_shots.size - 1];
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x24737c87, Offset: 0xc780
// Size: 0x1b8
function _init_instance(str_scenedef = self.scriptbundlename, a_ents, b_test_run = 0) {
    s_bundle = get_scenedef(str_scenedef);
    if (!isdefined(s_bundle)) {
        return undefined;
    }
    /#
        assert(isdefined(str_scenedef), "<dev string:x2ad>" + (isdefined(self.origin) ? self.origin : "<dev string:x2b8>") + "<dev string:x2be>");
        assert(isdefined(s_bundle), "<dev string:x2ad>" + (isdefined(self.origin) ? self.origin : "<dev string:x2b8>") + "<dev string:x2da>" + str_scenedef + "<dev string:x121>");
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
// Params 3, eflags: 0x0
// Checksum 0x3f61ed7e, Offset: 0xc940
// Size: 0x11a
function function_d0a1d87d(str_scenedef, str_mode, s_instance) {
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
// Params 5, eflags: 0x0
// Checksum 0x529973e3, Offset: 0xca68
// Size: 0x8c
function play_from_time(arg1, arg2, arg3, n_time, var_bd541d75 = 1) {
    if (var_bd541d75) {
        str_mode = "play_from_time_normalized";
    } else {
        str_mode = "play_from_time_elapsed";
    }
    play(arg1, arg2, arg3, 0, str_mode, n_time);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x3898eb6a, Offset: 0xcb00
// Size: 0xb2
function function_9ed8d5d0(str_scenedef, str_mode, n_time) {
    if (issubstr(str_mode, "play_from_time_normalized")) {
        var_e45dcfd1 = float(n_time) * function_a2174d35(str_scenedef);
    } else {
        var_e45dcfd1 = float(n_time);
    }
    var_e8b45933 = function_a2faed48(str_scenedef, var_e45dcfd1);
    return var_e8b45933;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x22b45f65, Offset: 0xcbc0
// Size: 0x1f2
function function_6e7a6390(obj, str_shot) {
    var_38bfdf38 = 0;
    n_anim_length = 0;
    if (isdefined(obj.shots)) {
        foreach (s_shot in obj.shots) {
            if (s_shot.name === str_shot && isdefined(s_shot.entry)) {
                foreach (s_entry in s_shot.entry) {
                    if (isdefined(s_entry.cameraswitcher)) {
                        var_38bfdf38 += float(getcamanimtime(s_entry.cameraswitcher)) / 1000;
                        continue;
                    }
                    if (isdefined(s_entry.("anim"))) {
                        n_anim_length += getanimlength(s_entry.("anim"));
                    }
                }
                break;
            }
        }
    }
    n_length = max(var_38bfdf38, n_anim_length);
    return n_length;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x4d6f9cad, Offset: 0xcdc0
// Size: 0x24a
function function_a2faed48(str_scenedef, n_elapsed_time) {
    s_scenedef = get_scenedef(str_scenedef);
    a_shots = get_all_shot_names(str_scenedef, undefined, 1);
    var_7006741a = 0;
    var_e8b45933 = spawnstruct();
    foreach (str_shot in a_shots) {
        var_6c51ddca = 0;
        foreach (obj in s_scenedef.objects) {
            var_aa251452 = function_6e7a6390(obj, str_shot);
            if (var_aa251452 > var_6c51ddca) {
                var_6c51ddca = var_aa251452;
            }
        }
        var_1d7b679d = var_7006741a;
        var_9fcbfb18 = var_1d7b679d + var_6c51ddca;
        if (n_elapsed_time >= var_1d7b679d && n_elapsed_time < var_9fcbfb18) {
            var_e8b45933.var_be0369b9 = str_shot;
            var_e8b45933.var_aacb0e72 = (n_elapsed_time - var_1d7b679d) / var_6c51ddca;
            return var_e8b45933;
        }
        var_7006741a += var_6c51ddca;
    }
    var_e8b45933.var_be0369b9 = a_shots[a_shots.size - 1];
    var_e8b45933.var_aacb0e72 = 0.9;
    return var_e8b45933;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x71f771f3, Offset: 0xd018
// Size: 0x122
function function_3dd10dad(var_a6cf02a8, str_shot) {
    if (isstring(var_a6cf02a8) || ishash(var_a6cf02a8)) {
        s_scenedef = get_scenedef(var_a6cf02a8);
    } else {
        s_scenedef = var_a6cf02a8;
    }
    var_25d67477 = 0;
    foreach (obj in s_scenedef.objects) {
        var_aa251452 = function_6e7a6390(obj, str_shot);
        if (var_aa251452 > var_25d67477) {
            var_25d67477 = var_aa251452;
        }
    }
    return var_25d67477;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x14805519, Offset: 0xd148
// Size: 0xe8
function function_a2174d35(str_scenedef) {
    s_scenedef = get_scenedef(str_scenedef);
    a_shots = get_all_shot_names(str_scenedef, undefined, 1);
    var_425e77f3 = 0;
    foreach (str_shot in a_shots) {
        var_425e77f3 += function_3dd10dad(s_scenedef, str_shot);
    }
    return var_425e77f3;
}

// Namespace scene/scene_shared
// Params 6, eflags: 0x0
// Checksum 0x1364b92d, Offset: 0xd238
// Size: 0x47c
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
                    var_4070d5c7 = 1;
                } else {
                    a_ents = arg2;
                }
            } else if (isinarray(level.scenedefs, hash(arg1))) {
                str_scenedef = arg1;
                var_f8dd026a = 1;
            } else {
                str_value = arg1;
                str_key = "targetname";
            }
            if (isstring(arg2)) {
                if (isinarray(array("targetname", "script_noteworthy"), arg2)) {
                    str_key = arg2;
                } else {
                    str_shot = tolower(arg2);
                    var_4070d5c7 = 1;
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
                        if (!(isdefined(var_f8dd026a) && var_f8dd026a)) {
                            str_scenedef = s_instance.scriptbundlename;
                        }
                        if (!(isdefined(var_4070d5c7) && var_4070d5c7)) {
                            str_shot = function_d0a1d87d(str_scenedef, str_mode, s_instance);
                        } else if (!issubstr(str_mode, "play_from_time")) {
                            str_mode = "single";
                        }
                        s_instance thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_shot, str_mode, n_time);
                    }
                }
            } else {
                _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode, n_time);
            }
        }
    } else {
        _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode, n_time);
    }
    function_326f3460(s_tracker, str_mode);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x4
// Checksum 0x4bd4ed40, Offset: 0xd6c0
// Size: 0x8c
function private function_326f3460(s_tracker, str_mode) {
    level endon(#"demo_jump");
    if (s_tracker.n_scene_count > 0 && !(isdefined(s_tracker.var_83092e7) && s_tracker.var_83092e7) && str_mode !== "init") {
        s_tracker waittill(#"scene_done");
    }
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x9e8efda7, Offset: 0xd758
// Size: 0xba
function function_e1e106d2(s_tracker, str_scenedef) {
    if (getdvarint(#"hash_862358d532e674c", 0) === 1) {
        var_1a9afd59 = getscriptbundle(str_scenedef);
        if (isdefined(var_1a9afd59.var_248e7d34) && var_1a9afd59.var_248e7d34) {
            /#
                iprintlnbold("<dev string:x2f4>" + str_scenedef);
            #/
            s_tracker.var_83092e7 = 1;
            return true;
        }
    }
    return false;
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0x9d9cf1fc, Offset: 0xd820
// Size: 0x22c
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
        str_shot = function_d0a1d87d(str_scenedef, str_mode, self);
    } else if (isdefined(str_shot) && !issubstr(str_mode, "play_from_time")) {
        str_mode = "single";
    }
    self thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_shot, str_mode, n_time);
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0x8535ee26, Offset: 0xda58
// Size: 0x3d0
function _play_instance(s_tracker, str_scenedef = self.scriptbundlename, a_ents, b_test_run, str_shot = "play", str_mode, n_time) {
    if (isdefined(n_time) && issubstr(str_mode, "play_from_time")) {
        var_e8b45933 = function_9ed8d5d0(str_scenedef, str_mode, n_time);
        str_shot = var_e8b45933.var_be0369b9;
        var_bed42e22 = var_e8b45933.var_aacb0e72;
        str_mode += ":" + var_bed42e22;
    }
    if (str_mode === "init") {
        str_shot = function_d0a1d87d(str_scenedef, str_mode, self);
    }
    if (function_e1e106d2(s_tracker, str_scenedef)) {
        waitframe(1);
        self notify(#"scene_done");
        return;
    }
    if (self.scriptbundlename === str_scenedef) {
        str_scenedef = self.scriptbundlename;
        if (!(isdefined(self.script_play_multiple) && self.script_play_multiple)) {
            if (!isdefined(self.scene_played)) {
                self.scene_played = [];
            }
            if (isdefined(self.scene_played[str_shot]) && self.scene_played[str_shot] && !b_test_run) {
                waittillframeend();
                while (is_playing(str_scenedef)) {
                    waitframe(1);
                }
                println("<dev string:x310>" + str_scenedef + "<dev string:x318>");
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
        function_6435e76d(o_scene);
    #/
    if (str_mode != "init") {
        if (isdefined(self.script_delay) && self.script_delay > 0) {
            wait self.script_delay;
        }
        if (isdefined(o_scene)) {
            thread [[ o_scene ]]->play(str_shot, b_test_run, str_mode);
        }
        o_scene waittill_instance_scene_done(str_scenedef);
        if (isdefined(self)) {
            if (isdefined(self.scriptbundlename) && isdefined(get_scenedef(self.scriptbundlename).looping) && get_scenedef(self.scriptbundlename).looping) {
                self.scene_played[str_shot] = 0;
            }
        }
    }
    /#
        function_6435e76d(o_scene);
    #/
    s_tracker.n_scene_count--;
    s_tracker notify(#"scene_done");
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x4
// Checksum 0xa944fac0, Offset: 0xde30
// Size: 0x3a
function private waittill_instance_scene_done(str_scenedef) {
    level endon(#"demo_jump");
    self waittill(#"scene_done");
}

// Namespace scene/scene_shared
// Params 5, eflags: 0x0
// Checksum 0x743338f6, Offset: 0xde78
// Size: 0x2ac
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
                assert(b_no_assert || a_instances.size, "<dev string:x388>" + str_key + "<dev string:x3a6>" + str_value + "<dev string:x3aa>");
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
// Params 3, eflags: 0x0
// Checksum 0x5a63da46, Offset: 0xe130
// Size: 0xfc
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
// Params 3, eflags: 0x0
// Checksum 0xb0974f62, Offset: 0xe238
// Size: 0x3c
function cancel(arg1, arg2, arg3) {
    stop(arg1, arg2, arg3, 1);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xbeb6d9be, Offset: 0xe280
// Size: 0xdc
function has_init_state(str_scenedef) {
    s_scenedef = get_scenedef(str_scenedef);
    foreach (s_obj in s_scenedef.objects) {
        if (!(isdefined(s_obj.disabled) && s_obj.disabled) && s_obj _has_init_state(str_scenedef)) {
            return true;
        }
    }
    return false;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x36fee458, Offset: 0xe368
// Size: 0x92
function _has_init_state(str_scenedef) {
    return isinarray(get_all_shot_names(str_scenedef), "init") || isdefined(self.spawnoninit) && self.spawnoninit || isdefined(self.initanim) || isdefined(self.initanimloop) || isdefined(self.firstframe) && self.firstframe;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xa0d57d7, Offset: 0xe408
// Size: 0x22
function get_prop_count(str_scenedef) {
    return _get_type_count("prop", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x77c56626, Offset: 0xe438
// Size: 0x22
function get_vehicle_count(str_scenedef) {
    return _get_type_count("vehicle", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x1e2d1b6e, Offset: 0xe468
// Size: 0x22
function get_actor_count(str_scenedef) {
    return _get_type_count("actor", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x335cc293, Offset: 0xe498
// Size: 0x22
function function_9181f70f(str_scenedef) {
    return _get_type_count("sharedplayer", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x510fa704, Offset: 0xe4c8
// Size: 0x22
function get_player_count(str_scenedef) {
    return _get_type_count("player", str_scenedef);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xde3821ec, Offset: 0xe4f8
// Size: 0x10e
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
// Params 1, eflags: 0x0
// Checksum 0x52b36a26, Offset: 0xe610
// Size: 0x4e
function is_active(str_scenedef) {
    if (self == level) {
        return (get_active_scenes(str_scenedef).size > 0);
    }
    return isdefined(get_active_scene(str_scenedef));
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x6cce217c, Offset: 0xe668
// Size: 0x90
function is_playing(str_scenedef) {
    if (self == level) {
        return level flagsys::get(str_scenedef + "_playing");
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
// Params 1, eflags: 0x0
// Checksum 0x416dffce, Offset: 0xe700
// Size: 0xf8
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
// Params 1, eflags: 0x0
// Checksum 0x69d693ec, Offset: 0xe800
// Size: 0x9e
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
// Checksum 0x371d77f2, Offset: 0xe8a8
// Size: 0x64
function is_capture_mode() {
    str_mode = getdvarstring(#"scene_menu_mode", "default");
    if (issubstr(str_mode, "capture")) {
        return 1;
    }
    return 0;
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0xad7887af, Offset: 0xe918
// Size: 0x19a
function _get_scene_instances(str_value, str_key = "targetname", str_scenedef, b_include_inactive = 0) {
    a_instances = [];
    if (isdefined(str_value)) {
        a_instances = struct::get_array(str_value, str_key);
        assert(a_instances.size, "<dev string:x388>" + str_key + "<dev string:x3a6>" + str_value + "<dev string:x3aa>");
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
// Params 1, eflags: 0x0
// Checksum 0x88e55420, Offset: 0xeac0
// Size: 0xf8
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
// Params 2, eflags: 0x0
// Checksum 0x9933302d, Offset: 0xebc0
// Size: 0x3a
function function_68180861(str_scenedef, str_shotname) {
    return isinarray(get_all_shot_names(str_scenedef), str_shotname);
}

