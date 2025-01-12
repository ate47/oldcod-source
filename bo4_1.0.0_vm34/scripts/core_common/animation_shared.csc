#using scripts\core_common\animation_debug_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\shaderanim_shared;
#using scripts\core_common\system_shared;

#namespace animation;

// Namespace animation/animation_shared
// Params 0, eflags: 0x2
// Checksum 0x947d8f6c, Offset: 0x250
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"animation", &__init__, undefined, undefined);
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0xc6c3a8b7, Offset: 0x298
// Size: 0xc4
function __init__() {
    clientfield::register("scriptmover", "cracks_on", 1, getminbitcountfornum(4), "int", &cf_cracks_on, 0, 0);
    clientfield::register("scriptmover", "cracks_off", 1, getminbitcountfornum(4), "int", &cf_cracks_off, 0, 0);
    setup_notetracks();
}

// Namespace animation/animation_shared
// Params 3, eflags: 0x0
// Checksum 0xbbbdca13, Offset: 0x368
// Size: 0x3c
function first_frame(animation, v_origin_or_ent, v_angles_or_tag) {
    self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0);
}

// Namespace animation/animation_shared
// Params 9, eflags: 0x0
// Checksum 0xd4f7c0de, Offset: 0x3b0
// Size: 0xfa
function play(animation, v_origin_or_ent, v_angles_or_tag, n_rate = 1, n_blend_in = 0.2, n_blend_out = 0.2, n_lerp, b_link = 0, n_start_time = 0) {
    self endon(#"death");
    self thread _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, b_link, n_start_time);
    self waittill(#"scriptedanim");
}

// Namespace animation/animation_shared
// Params 9, eflags: 0x0
// Checksum 0xfd2cb12d, Offset: 0x4b8
// Size: 0x484
function _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate = 1, n_blend_in = 0.2, n_blend_out = 0.2, n_lerp, b_link = 0, n_start_time) {
    self notify(#"new_scripted_anim");
    self endon(#"new_scripted_anim", #"death");
    flagsys::set_val("firstframe", n_rate == 0);
    flagsys::set(#"scripted_anim_this_frame");
    flagsys::set(#"scriptedanim");
    if (!isdefined(v_origin_or_ent)) {
        v_origin_or_ent = self;
    }
    if (isvec(v_origin_or_ent) && isvec(v_angles_or_tag)) {
        self animscripted("_anim_notify_", v_origin_or_ent, v_angles_or_tag, animation, n_blend_in, n_rate, n_start_time);
    } else {
        if (isstring(v_angles_or_tag)) {
            assert(isdefined(v_origin_or_ent.model), "<dev string:x30>" + animation + "<dev string:x49>" + v_angles_or_tag + "<dev string:x54>");
            v_pos = v_origin_or_ent gettagorigin(v_angles_or_tag);
            v_ang = v_origin_or_ent gettagangles(v_angles_or_tag);
            self.origin = v_pos;
            self.angles = v_ang;
            b_link = 1;
            self animscripted("_anim_notify_", self.origin, self.angles, animation, n_blend_in, n_rate, n_start_time);
        } else {
            v_angles = isdefined(v_origin_or_ent.angles) ? v_origin_or_ent.angles : (0, 0, 0);
            self animscripted("_anim_notify_", v_origin_or_ent.origin, v_angles, animation, n_blend_in, n_rate, n_start_time);
        }
        if (n_start_time > 0) {
            self setanimtimebyname(animation, n_start_time, 1);
        }
    }
    if (!b_link) {
        self unlink();
    }
    /#
        self.var_6b16d178 = "<dev string:x87>";
        self.var_5533d19a = {#animation:animation, #v_origin_or_ent:v_origin_or_ent, #v_angles_or_tag:v_angles_or_tag};
        level flagsys::clear("<dev string:x8e>");
    #/
    self thread handle_notetracks();
    self waittill_end();
    if (b_link) {
        self unlink();
    }
    flagsys::clear(#"scriptedanim");
    flagsys::clear(#"firstframe");
    self.var_6b16d178 = undefined;
    self.var_5533d19a = undefined;
    waittillframeend();
    flagsys::clear(#"scripted_anim_this_frame");
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x4
// Checksum 0x433b6111, Offset: 0x948
// Size: 0x4c
function private waittill_end() {
    level endon(#"demo_jump");
    self waittillmatch({#notetrack:"end"}, #"_anim_notify_");
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0x8e5cd112, Offset: 0x9a0
// Size: 0x4e
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
// Checksum 0xee2ce2bf, Offset: 0x9f8
// Size: 0x1a6
function _get_align_pos(v_origin_or_ent = self.origin, v_angles_or_tag = isdefined(self.angles) ? self.angles : (0, 0, 0)) {
    s = spawnstruct();
    if (isvec(v_origin_or_ent)) {
        assert(isvec(v_angles_or_tag), "<dev string:x99>");
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
// Checksum 0x11a5e462, Offset: 0xba8
// Size: 0x15a
function play_siege(str_anim, str_shot = "default", n_rate = 1, b_loop = 0) {
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
// Params 2, eflags: 0x0
// Checksum 0x700eb8c7, Offset: 0xd10
// Size: 0x7a
function add_notetrack_func(funcname, func) {
    if (!isdefined(level._animnotifyfuncs)) {
        level._animnotifyfuncs = [];
    }
    assert(!isdefined(level._animnotifyfuncs[funcname]), "<dev string:xbf>");
    level._animnotifyfuncs[funcname] = func;
}

// Namespace animation/animation_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x8b8550a7, Offset: 0xd98
// Size: 0x118
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
// Checksum 0x9fdf502f, Offset: 0xeb8
// Size: 0x2be
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
                assertmsg("<dev string:xe2>");
                break;
            }
        }
    }
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0x4ddbaa86, Offset: 0x1180
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
// Checksum 0xb1ef94e, Offset: 0x13b0
// Size: 0xce
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
// Params 1, eflags: 0x0
// Checksum 0x66a0faf4, Offset: 0x1488
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
// Params 1, eflags: 0x0
// Checksum 0x3d4ea6dc, Offset: 0x1578
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
// Params 7, eflags: 0x0
// Checksum 0xe5a8fb67, Offset: 0x1668
// Size: 0x1b2
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
// Checksum 0x10eaf1e6, Offset: 0x1828
// Size: 0x19a
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

