#using scripts/core_common/animation_debug_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/shaderanim_shared;
#using scripts/core_common/system_shared;

#namespace animation;

// Namespace animation/animation_shared
// Params 0, eflags: 0x2
// Checksum 0x17b5ac0d, Offset: 0x378
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("animation", &__init__, undefined, undefined);
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0x9dcdd55a, Offset: 0x3b8
// Size: 0xc4
function __init__() {
    clientfield::register("scriptmover", "cracks_on", 1, getminbitcountfornum(4), "int", &cf_cracks_on, 0, 0);
    clientfield::register("scriptmover", "cracks_off", 1, getminbitcountfornum(4), "int", &cf_cracks_off, 0, 0);
    setup_notetracks();
}

// Namespace animation/animation_shared
// Params 3, eflags: 0x0
// Checksum 0xb00caf9b, Offset: 0x488
// Size: 0x3c
function first_frame(animation, v_origin_or_ent, v_angles_or_tag) {
    self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0);
}

// Namespace animation/animation_shared
// Params 8, eflags: 0x0
// Checksum 0x478916b5, Offset: 0x4d0
// Size: 0xea
function play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, b_link) {
    if (!isdefined(n_rate)) {
        n_rate = 1;
    }
    if (!isdefined(n_blend_in)) {
        n_blend_in = 0.2;
    }
    if (!isdefined(n_blend_out)) {
        n_blend_out = 0.2;
    }
    if (!isdefined(b_link)) {
        b_link = 0;
    }
    self endon(#"death");
    self thread _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, b_link);
    self waittill("scriptedanim");
}

// Namespace animation/animation_shared
// Params 8, eflags: 0x0
// Checksum 0xbc71c3c5, Offset: 0x5c8
// Size: 0x404
function _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, b_link) {
    if (!isdefined(n_rate)) {
        n_rate = 1;
    }
    if (!isdefined(n_blend_in)) {
        n_blend_in = 0.2;
    }
    if (!isdefined(n_blend_out)) {
        n_blend_out = 0.2;
    }
    if (!isdefined(b_link)) {
        b_link = 0;
    }
    self endon(#"death");
    self notify(#"new_scripted_anim");
    self endon(#"new_scripted_anim");
    flagsys::set_val("firstframe", n_rate == 0);
    flagsys::set("scripted_anim_this_frame");
    flagsys::set("scriptedanim");
    if (!isdefined(v_origin_or_ent)) {
        v_origin_or_ent = self;
    }
    if (isvec(v_origin_or_ent) && isvec(v_angles_or_tag)) {
        self animscripted("_anim_notify_", v_origin_or_ent, v_angles_or_tag, animation, n_blend_in, n_rate);
    } else if (isstring(v_angles_or_tag)) {
        assert(isdefined(v_origin_or_ent.model), "<dev string:x28>" + animation + "<dev string:x41>" + v_angles_or_tag + "<dev string:x4c>");
        v_pos = v_origin_or_ent gettagorigin(v_angles_or_tag);
        v_ang = v_origin_or_ent gettagangles(v_angles_or_tag);
        self.origin = v_pos;
        self.angles = v_ang;
        b_link = 1;
        self animscripted("_anim_notify_", self.origin, self.angles, animation, n_blend_in, n_rate);
    } else {
        v_angles = isdefined(v_origin_or_ent.angles) ? v_origin_or_ent.angles : (0, 0, 0);
        self animscripted("_anim_notify_", v_origin_or_ent.origin, v_angles, animation, n_blend_in, n_rate);
    }
    if (!b_link) {
        self unlink();
    }
    /#
        self thread anim_info_render_thread(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
    #/
    self thread handle_notetracks();
    self waittill_end();
    if (b_link) {
        self unlink();
    }
    flagsys::clear("scriptedanim");
    flagsys::clear("firstframe");
    waittillframeend();
    flagsys::clear("scripted_anim_this_frame");
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x4
// Checksum 0xdbb22d3c, Offset: 0x9d8
// Size: 0x34
function private waittill_end() {
    level endon(#"demo_jump");
    self waittillmatch({#notetrack:"end"}, "_anim_notify_");
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0x7ba67591, Offset: 0xa18
// Size: 0x5c
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
// Checksum 0x90cc8da6, Offset: 0xa80
// Size: 0x1e0
function _get_align_pos(v_origin_or_ent, v_angles_or_tag) {
    if (!isdefined(v_origin_or_ent)) {
        v_origin_or_ent = self.origin;
    }
    if (!isdefined(v_angles_or_tag)) {
        v_angles_or_tag = isdefined(self.angles) ? self.angles : (0, 0, 0);
    }
    s = spawnstruct();
    if (isvec(v_origin_or_ent)) {
        assert(isvec(v_angles_or_tag), "<dev string:x7f>");
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
// Params 4, eflags: 0x0
// Checksum 0x136b431b, Offset: 0xc68
// Size: 0x162
function play_siege(str_anim, str_shot, n_rate, b_loop) {
    if (!isdefined(str_shot)) {
        str_shot = "default";
    }
    if (!isdefined(n_rate)) {
        n_rate = 1;
    }
    if (!isdefined(b_loop)) {
        b_loop = 0;
    }
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
    self waittill("end");
}

// Namespace animation/animation_shared
// Params 2, eflags: 0x0
// Checksum 0x89187b52, Offset: 0xdd8
// Size: 0x82
function add_notetrack_func(funcname, func) {
    if (!isdefined(level._animnotifyfuncs)) {
        level._animnotifyfuncs = [];
    }
    assert(!isdefined(level._animnotifyfuncs[funcname]), "<dev string:xa5>");
    level._animnotifyfuncs[funcname] = func;
}

// Namespace animation/animation_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0xcd590552, Offset: 0xe68
// Size: 0x13c
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
// Params 1, eflags: 0x0
// Checksum 0xf9577366, Offset: 0xfb0
// Size: 0x290
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
                assertmsg("<dev string:xc8>");
                break;
            }
        }
    }
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0xbce1c778, Offset: 0x1248
// Size: 0x224
function setup_notetracks() {
    add_notetrack_func("flag::set", &flag::set);
    add_notetrack_func("flag::clear", &flag::clear);
    add_notetrack_func("postfx::PlayPostFxBundle", &postfx::playpostfxbundle);
    add_notetrack_func("postfx::StopPostFxBundle", &postfx::stoppostfxbundle);
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
// Params 0, eflags: 0x0
// Checksum 0x12330f9b, Offset: 0x1478
// Size: 0x9e
function handle_notetracks() {
    level endon(#"demo_jump");
    self endon(#"death");
    while (true) {
        waitresult = self waittill("_anim_notify_");
        str_note = waitresult.notetrack;
        if (str_note != "end" && str_note != "loop_end") {
            self thread call_notetrack_handler(str_note);
            continue;
        }
        return;
    }
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0x1bd67d3e, Offset: 0x1520
// Size: 0xd6
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
// Params 1, eflags: 0x0
// Checksum 0xb4641d27, Offset: 0x1600
// Size: 0xd6
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
// Params 7, eflags: 0x0
// Checksum 0x2928cac5, Offset: 0x16e0
// Size: 0x192
function cf_cracks_on(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 3, 0, 1);
        break;
    case 3:
        shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 3, 0, 1);
        break;
    case 2:
        shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 3, 0, 1);
        break;
    case 4:
        shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 3, 0, 1);
        shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 3, 0, 1);
        shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 3, 0, 1);
        break;
    }
}

// Namespace animation/animation_shared
// Params 7, eflags: 0x0
// Checksum 0x1c29f891, Offset: 0x1880
// Size: 0x17a
function cf_cracks_off(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 0, 1, 0);
        break;
    case 3:
        shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 0, 1, 0);
        break;
    case 2:
        shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 0, 1, 0);
        break;
    case 4:
        shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 0, 1, 0);
        shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 0, 1, 0);
        shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 0, 1, 0);
        break;
    }
}

