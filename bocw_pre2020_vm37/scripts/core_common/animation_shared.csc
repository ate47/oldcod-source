#using script_274952f8a08d7ad0;
#using scripts\core_common\animation_debug_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\shaderanim_shared;
#using scripts\core_common\system_shared;

#namespace animation;

// Namespace animation/animation_shared
// Params 0, eflags: 0x6
// Checksum 0x7d25b1c3, Offset: 0x310
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"animation", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xdd5d2b6b, Offset: 0x358
// Size: 0xc4
function private function_70a657d8() {
    clientfield::register("scriptmover", "cracks_on", 1, getminbitcountfornum(4), "int", &cf_cracks_on, 0, 0);
    clientfield::register("scriptmover", "cracks_off", 1, getminbitcountfornum(4), "int", &cf_cracks_off, 0, 0);
    setup_notetracks();
}

// Namespace animation/animation_shared
// Params 3, eflags: 0x0
// Checksum 0x638e571b, Offset: 0x428
// Size: 0x3c
function first_frame(animation, v_origin_or_ent, v_angles_or_tag) {
    self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0);
}

// Namespace animation/animation_shared
// Params 11, eflags: 0x1 linked
// Checksum 0x68a742da, Offset: 0x470
// Size: 0x122
function play(animation, v_origin_or_ent, v_angles_or_tag, n_rate = 1, n_blend_in = 0.2, n_blend_out = 0.2, n_lerp, b_link = 0, n_start_time = 0, var_b2e32ae2 = "linear", localclientnum = 0) {
    self endon(#"death");
    self thread _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, b_link, n_start_time, var_b2e32ae2, localclientnum);
    self waittill(#"scriptedanim");
}

// Namespace animation/animation_shared
// Params 11, eflags: 0x1 linked
// Checksum 0x17c48f63, Offset: 0x5a0
// Size: 0x54c
function _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, *n_blend_out = 1, *n_lerp = 0.2, b_link = 0, n_start_time, var_b2e32ae2, localclientnum) {
    if (!isdefined(self)) {
        return;
    }
    self notify(#"new_scripted_anim");
    self endon(#"new_scripted_anim", #"death");
    if (!isdefined(self.model) || self.model == #"") {
        assertmsg("<dev string:x38>" + self.origin);
        return;
    }
    flag::set_val("firstframe", n_blend_out == 0);
    flag::set(#"scripted_anim_this_frame");
    flag::set(#"scriptedanim");
    if (!isdefined(n_rate)) {
        n_rate = self;
    }
    n_start_time = math::clamp(n_start_time, 0, 1);
    if (isvec(n_rate) && isvec(n_blend_in)) {
        self animscripted("_anim_notify_", n_rate, n_blend_in, v_angles_or_tag, n_lerp, n_blend_out, n_start_time, var_b2e32ae2);
    } else {
        if (isstring(n_blend_in)) {
            assert(isdefined(n_rate.model), "<dev string:x76>" + v_angles_or_tag + "<dev string:x92>" + n_blend_in + "<dev string:xa0>");
            v_pos = n_rate gettagorigin(n_blend_in);
            v_ang = n_rate gettagangles(n_blend_in);
            self.origin = v_pos;
            self.angles = v_ang;
            b_link = 1;
            self animscripted("_anim_notify_", self.origin, self.angles, v_angles_or_tag, n_lerp, n_blend_out, n_start_time, var_b2e32ae2);
        } else {
            v_angles = isdefined(n_rate.angles) ? n_rate.angles : (0, 0, 0);
            v_origin = isdefined(n_rate.origin) ? n_rate.origin : (0, 0, 0);
            self animscripted("_anim_notify_", v_origin, v_angles, v_angles_or_tag, n_lerp, n_blend_out, n_start_time, var_b2e32ae2);
        }
        if (n_start_time > 0 && (!isanimlooping(localclientnum, v_angles_or_tag) || n_start_time < 1)) {
            self setanimtimebyname(v_angles_or_tag, n_start_time, 1);
        }
    }
    if (!b_link) {
        self unlink();
    }
    /#
        self.var_80c69db6 = "<dev string:xd6>";
        self.var_6c4bb19 = {#animation:v_angles_or_tag, #v_origin_or_ent:n_rate, #v_angles_or_tag:n_blend_in};
        if (level flag::get("<dev string:xe0>")) {
            self thread anim_info_render_thread();
        }
    #/
    self thread handle_notetracks();
    self waittill_end();
    if (b_link) {
        self unlink();
    }
    flag::clear(#"scriptedanim");
    flag::clear(#"firstframe");
    self.var_80c69db6 = undefined;
    self.var_6c4bb19 = undefined;
    waittillframeend();
    flag::clear(#"scripted_anim_this_frame");
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xaf8a3d65, Offset: 0xaf8
// Size: 0x4c
function private waittill_end() {
    level endon(#"demo_jump");
    self waittillmatch({#notetrack:"end"}, #"_anim_notify_");
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x72b62598, Offset: 0xb50
// Size: 0x4a
function _get_align_ent(e_align) {
    e = self;
    if (isdefined(e_align)) {
        e = e_align;
    }
    if (!isdefined(e.angles)) {
        e.angles = (0, 0, 0);
    }
    return e;
}

// Namespace animation/animation_shared
// Params 2, eflags: 0x0
// Checksum 0x56e7edf0, Offset: 0xba8
// Size: 0x186
function _get_align_pos(v_origin_or_ent = self.origin, v_angles_or_tag = isdefined(self.angles) ? self.angles : (0, 0, 0)) {
    s = spawnstruct();
    if (isvec(v_origin_or_ent)) {
        assert(isvec(v_angles_or_tag), "<dev string:xee>");
        s.origin = v_origin_or_ent;
        s.angles = v_angles_or_tag;
    } else {
        e_align = _get_align_ent(v_origin_or_ent);
        if (isstring(v_angles_or_tag)) {
            s.origin = e_align gettagorigin(v_angles_or_tag);
            s.angles = e_align gettagangles(v_angles_or_tag);
        } else {
            s.origin = e_align.origin;
            s.angles = e_align.angles;
        }
    }
    if (!isdefined(s.angles)) {
        s.angles = (0, 0, 0);
    }
    return s;
}

// Namespace animation/animation_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x2ed10d68, Offset: 0xd38
// Size: 0x16a
function play_siege(str_anim, str_shot = "default", n_rate = 1, b_loop = 0) {
    self notify(#"end");
    level endon(#"demo_jump");
    self endon(#"death");
    if (!isdefined(str_shot)) {
        str_shot = "default";
    }
    if (n_rate == 0) {
        self siegecmd("set_anim", str_anim, "set_shot", str_shot, "pause", "goto_start");
    } else {
        self siegecmd("set_anim", str_anim, "set_shot", str_shot, "unpause", "set_playback_speed", n_rate, "send_end_events", 1, b_loop ? "loop" : "unloop");
    }
    self waittill(#"end");
}

// Namespace animation/animation_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x15d1d7de, Offset: 0xeb0
// Size: 0x74
function add_notetrack_func(funcname, func) {
    if (!isdefined(level._animnotifyfuncs)) {
        level._animnotifyfuncs = [];
    }
    assert(!isdefined(level._animnotifyfuncs[funcname]), "<dev string:x117>");
    level._animnotifyfuncs[funcname] = func;
}

// Namespace animation/animation_shared
// Params 3, eflags: 0x21 linked variadic
// Checksum 0xfd58f75f, Offset: 0xf30
// Size: 0x112
function add_global_notetrack_handler(str_note, func, ...) {
    if (!isdefined(level._animnotetrackhandlers)) {
        level._animnotetrackhandlers = [];
    }
    if (!isdefined(level._animnotetrackhandlers[str_note])) {
        level._animnotetrackhandlers[str_note] = [];
    }
    if (!isdefined(level._animnotetrackhandlers[str_note])) {
        level._animnotetrackhandlers[str_note] = [];
    } else if (!isarray(level._animnotetrackhandlers[str_note])) {
        level._animnotetrackhandlers[str_note] = array(level._animnotetrackhandlers[str_note]);
    }
    level._animnotetrackhandlers[str_note][level._animnotetrackhandlers[str_note].size] = array(func, vararg);
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x504e219d, Offset: 0x1050
// Size: 0x29e
function call_notetrack_handler(str_note) {
    if (isdefined(level._animnotetrackhandlers) && isdefined(level._animnotetrackhandlers[str_note])) {
        foreach (handler in level._animnotetrackhandlers[str_note]) {
            func = handler[0];
            args = handler[1];
            switch (args.size) {
            case 6:
                self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5]);
                break;
            case 5:
                self [[ func ]](args[0], args[1], args[2], args[3], args[4]);
                break;
            case 4:
                self [[ func ]](args[0], args[1], args[2], args[3]);
                break;
            case 3:
                self [[ func ]](args[0], args[1], args[2]);
                break;
            case 2:
                self [[ func ]](args[0], args[1]);
                break;
            case 1:
                self [[ func ]](args[0]);
                break;
            case 0:
                self [[ func ]]();
                break;
            default:
                assertmsg("<dev string:x13d>");
                break;
            }
        }
    }
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x31242af0, Offset: 0x12f8
// Size: 0x274
function setup_notetracks() {
    add_notetrack_func("flag::set", &flag::set);
    add_notetrack_func("flag::clear", &flag::clear);
    add_notetrack_func("postfx::PlayPostFxBundle", &postfx::playpostfxbundle);
    add_notetrack_func("postfx::StopPostFxBundle", &postfx::stoppostfxbundle);
    add_notetrack_func("cinematicMotion::SpeedModifierClient", &cinematicmotion::function_bd8097ae);
    add_notetrack_func("cinematicMotion::OverrideClient", &cinematicmotion::function_8152b11);
    add_global_notetrack_handler("red_cracks_on", &cracks_on, "red");
    add_global_notetrack_handler("green_cracks_on", &cracks_on, "green");
    add_global_notetrack_handler("blue_cracks_on", &cracks_on, "blue");
    add_global_notetrack_handler("all_cracks_on", &cracks_on, "all");
    add_global_notetrack_handler("red_cracks_off", &cracks_off, "red");
    add_global_notetrack_handler("green_cracks_off", &cracks_off, "green");
    add_global_notetrack_handler("blue_cracks_off", &cracks_off, "blue");
    add_global_notetrack_handler("all_cracks_off", &cracks_off, "all");
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x27417c59, Offset: 0x1578
// Size: 0xd6
function handle_notetracks() {
    self notify(#"handle_notetracks");
    level endon(#"demo_jump");
    self endon(#"handle_notetracks", #"death");
    while (true) {
        waitresult = self waittill(#"_anim_notify_");
        str_note = waitresult.notetrack;
        if (str_note != "end" && str_note != "loop_end") {
            self thread call_notetrack_handler(str_note);
            continue;
        }
        return;
    }
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc323c263, Offset: 0x1658
// Size: 0xe2
function cracks_on(str_type) {
    switch (str_type) {
    case #"red":
        cf_cracks_on(self.localclientnum, 0, 1);
        break;
    case #"green":
        cf_cracks_on(self.localclientnum, 0, 3);
        break;
    case #"blue":
        cf_cracks_on(self.localclientnum, 0, 2);
        break;
    case #"all":
        cf_cracks_on(self.localclientnum, 0, 4);
        break;
    }
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x235df55e, Offset: 0x1748
// Size: 0xe2
function cracks_off(str_type) {
    switch (str_type) {
    case #"red":
        cf_cracks_off(self.localclientnum, 0, 1);
        break;
    case #"green":
        cf_cracks_off(self.localclientnum, 0, 3);
        break;
    case #"blue":
        cf_cracks_off(self.localclientnum, 0, 2);
        break;
    case #"all":
        cf_cracks_off(self.localclientnum, 0, 4);
        break;
    }
}

// Namespace animation/animation_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x51f4bd4a, Offset: 0x1838
// Size: 0x1b2
function cf_cracks_on(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 1:
        shaderanim::animate_crack(fieldname, "scriptVector1", 0, 3, 0, 1);
        break;
    case 3:
        shaderanim::animate_crack(fieldname, "scriptVector2", 0, 3, 0, 1);
        break;
    case 2:
        shaderanim::animate_crack(fieldname, "scriptVector3", 0, 3, 0, 1);
        break;
    case 4:
        shaderanim::animate_crack(fieldname, "scriptVector1", 0, 3, 0, 1);
        shaderanim::animate_crack(fieldname, "scriptVector2", 0, 3, 0, 1);
        shaderanim::animate_crack(fieldname, "scriptVector3", 0, 3, 0, 1);
        break;
    }
}

// Namespace animation/animation_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x51b3f1bd, Offset: 0x19f8
// Size: 0x19a
function cf_cracks_off(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 1:
        shaderanim::animate_crack(fieldname, "scriptVector1", 0, 0, 1, 0);
        break;
    case 3:
        shaderanim::animate_crack(fieldname, "scriptVector2", 0, 0, 1, 0);
        break;
    case 2:
        shaderanim::animate_crack(fieldname, "scriptVector3", 0, 0, 1, 0);
        break;
    case 4:
        shaderanim::animate_crack(fieldname, "scriptVector1", 0, 0, 1, 0);
        shaderanim::animate_crack(fieldname, "scriptVector2", 0, 0, 1, 0);
        shaderanim::animate_crack(fieldname, "scriptVector3", 0, 0, 1, 0);
        break;
    }
}

