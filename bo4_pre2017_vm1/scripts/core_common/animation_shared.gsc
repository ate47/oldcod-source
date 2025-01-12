#using scripts/core_common/ai_shared;
#using scripts/core_common/animation_debug_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/string_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace animation;

// Namespace animation/animation_shared
// Params 0, eflags: 0x2
// Checksum 0xf53954e9, Offset: 0x468
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("animation", &__init__, undefined, undefined);
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0x4909d1ad, Offset: 0x4a8
// Size: 0xe4
function __init__() {
    if (getdvarstring("debug_anim_shared", "") == "") {
        setdvar("debug_anim_shared", "");
    }
    setup_notetracks();
    callback::on_laststand(&reset_player);
    callback::on_bleedout(&reset_player);
    callback::on_player_killed(&reset_player);
    callback::on_spawned(&reset_player);
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0x72e2018a, Offset: 0x598
// Size: 0x4c
function reset_player() {
    flagsys::clear("firstframe");
    flagsys::clear("scripted_anim_this_frame");
    flagsys::clear("scriptedanim");
}

// Namespace animation/animation_shared
// Params 3, eflags: 0x0
// Checksum 0xf8af6edc, Offset: 0x5f0
// Size: 0x3c
function first_frame(animation, v_origin_or_ent, v_angles_or_tag) {
    self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0);
}

// Namespace animation/animation_shared
// Params 3, eflags: 0x0
// Checksum 0x42339c91, Offset: 0x638
// Size: 0x4c
function last_frame(animation, v_origin_or_ent, v_angles_or_tag) {
    self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0, 0, 0, 0, 1);
}

// Namespace animation/animation_shared
// Params 11, eflags: 0x0
// Checksum 0x6a087f52, Offset: 0x690
// Size: 0x16a
function play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed, var_3bb6221f) {
    if (!isdefined(n_rate)) {
        n_rate = 1;
    }
    if (!isdefined(n_blend_in)) {
        n_blend_in = 0.2;
    }
    if (!isdefined(n_blend_out)) {
        n_blend_out = 0.2;
    }
    if (!isdefined(n_lerp)) {
        n_lerp = 0;
    }
    if (!isdefined(n_start_time)) {
        n_start_time = 0;
    }
    if (!isdefined(b_show_player_firstperson_weapon)) {
        b_show_player_firstperson_weapon = 0;
    }
    if (!isdefined(b_unlink_after_completed)) {
        b_unlink_after_completed = 1;
    }
    if (self isragdoll()) {
        return;
    }
    self endon(#"death");
    self endon(#"entering_last_stand");
    self thread _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed, var_3bb6221f);
    self waittill("scriptedanim");
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0x9d64a7da, Offset: 0x808
// Size: 0x54
function stop(n_blend) {
    if (!isdefined(n_blend)) {
        n_blend = 0.2;
    }
    flagsys::clear("scriptedanim");
    self stopanimscripted(n_blend);
}

/#

    // Namespace animation/animation_shared
    // Params 2, eflags: 0x0
    // Checksum 0x6b001d82, Offset: 0x868
    // Size: 0x1b4
    function debug_print(str_animation, str_msg) {
        str_dvar = getdvarstring("<dev string:x28>", "<dev string:x3a>");
        if (str_dvar != "<dev string:x3a>") {
            b_print = 0;
            if (strisnumber(str_dvar)) {
                if (int(str_dvar) > 0) {
                    b_print = 1;
                }
            } else if (isdefined(self.animname) && (issubstr(str_animation, str_dvar) || issubstr(self.animname, str_dvar))) {
                b_print = 1;
            }
            if (b_print) {
                printtoprightln(str_animation + "<dev string:x3b>" + string::rjust(str_msg, 10) + "<dev string:x3b>" + string::rjust("<dev string:x3a>" + self getentitynumber(), 4) + "<dev string:x3f>" + string::rjust("<dev string:x3a>" + gettime(), 6) + "<dev string:x42>", (1, 1, 0), -1);
            }
        }
    }

#/

// Namespace animation/animation_shared
// Params 11, eflags: 0x0
// Checksum 0x6419697b, Offset: 0xa28
// Size: 0x6a4
function _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed, var_3bb6221f) {
    self endon(#"death", #"entering_last_stand");
    self notify(#"new_scripted_anim");
    self endon(#"new_scripted_anim");
    /#
        debug_print(animation, "<dev string:x44>");
    #/
    flagsys::set_val("firstframe", n_rate == 0);
    flagsys::set("scripted_anim_this_frame");
    flagsys::set("scriptedanim");
    if (!isdefined(v_origin_or_ent)) {
        v_origin_or_ent = self;
    }
    if (isvec(v_origin_or_ent)) {
        v_origin = v_origin_or_ent;
    } else {
        v_origin = isdefined(v_origin_or_ent.origin) ? v_origin_or_ent.origin : (0, 0, 0);
    }
    if (isvec(v_angles_or_tag)) {
        v_angles = v_angles_or_tag;
    } else if (isstring(v_angles_or_tag)) {
        /#
            assert(isdefined(v_origin_or_ent.model), "<dev string:x4c>" + animation + "<dev string:x65>" + v_angles_or_tag + "<dev string:x70>");
        #/
        str_tag = v_angles_or_tag;
        v_origin = v_origin_or_ent gettagorigin(str_tag);
        v_angles = v_origin_or_ent gettagangles(str_tag);
    } else {
        v_angles = isdefined(v_origin_or_ent.angles) ? v_origin_or_ent.angles : (0, 0, 0);
    }
    self.str_current_anim = animation;
    b_link = isentity(v_origin_or_ent);
    if (isdefined(self.n_script_anim_rate)) {
        n_rate = self.n_script_anim_rate;
    }
    if (n_lerp > 0) {
        prevorigin = self.origin;
        prevangles = self.angles;
    }
    if (b_link) {
        if (isactor(self)) {
            self forceteleport(v_origin, v_angles);
        } else {
            self.origin = v_origin;
            self.angles = v_angles;
        }
        if (v_origin_or_ent != self) {
            if (isstring(str_tag)) {
                self linkto(v_origin_or_ent, str_tag, (0, 0, 0), (0, 0, 0));
            } else {
                self linkto(v_origin_or_ent);
            }
        }
        if (n_lerp > 0) {
            if (isactor(self)) {
                self forceteleport(prevorigin, prevangles);
            } else {
                self.origin = prevorigin;
                self.angles = prevangles;
            }
        }
    }
    self animscripted(animation, v_origin, v_angles, animation, "normal", undefined, n_rate, n_blend_in, n_lerp, n_start_time, 1, b_show_player_firstperson_weapon, var_3bb6221f);
    if (isplayer(self)) {
        set_player_clamps();
    }
    /#
        self thread anim_info_render_thread(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
    #/
    if (!isanimlooping(animation) && n_blend_out > 0 && n_rate > 0 && n_start_time < 1) {
        if (!animhasnotetrack(animation, "start_ragdoll")) {
            self thread _blend_out(animation, n_blend_out, n_rate, n_start_time);
        }
    }
    self thread handle_notetracks(animation);
    if (getanimframecount(animation) > 1 || isanimlooping(animation)) {
        self waittillmatch({#notetrack:"end"}, animation);
    } else {
        waitframe(1);
    }
    if (isdefined(b_unlink_after_completed) && b_link && b_unlink_after_completed) {
        self unlink();
    }
    self.str_current_anim = undefined;
    flagsys::clear("scriptedanim");
    flagsys::clear("firstframe");
    /#
        debug_print(animation, "<dev string:xa3>");
    #/
    waittillframeend();
    flagsys::clear("scripted_anim_this_frame");
}

// Namespace animation/animation_shared
// Params 4, eflags: 0x0
// Checksum 0xea2ad277, Offset: 0x10d8
// Size: 0x11a
function _blend_out(animation, n_blend, n_rate, n_start_time) {
    self endon(#"death");
    self endon(#"end");
    self endon(#"scriptedanim");
    self endon(#"new_scripted_anim");
    n_server_length = floor(getanimlength(animation) / 0.05) * 0.05;
    while (true) {
        n_current_time = self getanimtime(animation) * n_server_length;
        n_time_left = n_server_length - n_current_time;
        if (n_time_left <= n_blend) {
            self stopanimscripted(n_blend);
            break;
        }
        waitframe(1);
    }
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0xea7d6991, Offset: 0x1200
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
// Checksum 0x8aa70325, Offset: 0x1268
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
        /#
            assert(isvec(v_angles_or_tag), "<dev string:xa9>");
        #/
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
// Checksum 0xbcda260c, Offset: 0x1450
// Size: 0x138
function teleport(animation, v_origin_or_ent, v_angles_or_tag, time) {
    if (!isdefined(time)) {
        time = 0;
    }
    s = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
    v_pos = getstartorigin(s.origin, s.angles, animation, time);
    v_ang = getstartangles(s.origin, s.angles, animation, time);
    if (isactor(self)) {
        self forceteleport(v_pos, v_ang);
        return;
    }
    self.origin = v_pos;
    self.angles = v_ang;
}

// Namespace animation/animation_shared
// Params 4, eflags: 0x0
// Checksum 0x5defaa79, Offset: 0x1590
// Size: 0x9c
function reach(animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals) {
    if (!isdefined(b_disable_arrivals)) {
        b_disable_arrivals = 0;
    }
    self endon(#"death");
    s_tracker = spawnstruct();
    self thread _reach(s_tracker, animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals);
    s_tracker waittill("done");
}

// Namespace animation/animation_shared
// Params 5, eflags: 0x0
// Checksum 0x753b0684, Offset: 0x1638
// Size: 0x382
function _reach(s_tracker, animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals) {
    if (!isdefined(b_disable_arrivals)) {
        b_disable_arrivals = 0;
    }
    self endon(#"death");
    self notify(#"stop_going_to_node");
    self notify(#"new_anim_reach");
    flagsys::wait_till_clear("anim_reach");
    flagsys::set("anim_reach");
    s = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
    goal = getstartorigin(s.origin, s.angles, animation);
    n_delta = distancesquared(goal, self.origin);
    if (n_delta > 16) {
        self stopanimscripted(0.2);
        if (b_disable_arrivals) {
            if (ai::has_behavior_attribute("disablearrivals")) {
                ai::set_behavior_attribute("disablearrivals", 1);
            }
            self.stopanimdistsq = 0.0001;
        }
        if (isdefined(self.archetype) && self.archetype == "robot") {
            ai::set_behavior_attribute("rogue_control_force_goal", goal);
        } else if (ai::has_behavior_attribute("vignette_mode") && !(isdefined(self.ignorevignettemodeforanimreach) && self.ignorevignettemodeforanimreach)) {
            ai::set_behavior_attribute("vignette_mode", "fast");
        }
        self thread ai::force_goal(goal, 15, 1, undefined, 0, 1);
        /#
            self thread debug_anim_reach();
        #/
        self waittill("goal", "new_anim_reach", "new_scripted_anim", "stop_scripted_anim");
        if (ai::has_behavior_attribute("disablearrivals")) {
            ai::set_behavior_attribute("disablearrivals", 0);
            self.stopanimdistsq = 0;
        }
    } else {
        waittillframeend();
    }
    if (!(isdefined(self.archetype) && self.archetype == "robot") && ai::has_behavior_attribute("vignette_mode")) {
        ai::set_behavior_attribute("vignette_mode", "off");
    }
    flagsys::clear("anim_reach");
    s_tracker notify(#"done");
    self notify(#"reach_done");
}

/#

    // Namespace animation/animation_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1de0d412, Offset: 0x19c8
    // Size: 0xa6
    function debug_anim_reach() {
        self endon(#"death");
        self endon(#"goal");
        self endon(#"new_anim_reach");
        self endon(#"new_scripted_anim");
        self endon(#"stop_scripted_anim");
        while (true) {
            level flagsys::wait_till("<dev string:xcf>");
            print3d(self.origin, "<dev string:xda>", (1, 0, 0), 1, 1, 1);
            waitframe(1);
        }
    }

#/

// Namespace animation/animation_shared
// Params 7, eflags: 0x0
// Checksum 0x380b8e95, Offset: 0x1a78
// Size: 0xa4
function set_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp) {
    self notify(#"new_death_anim");
    if (isdefined(animation)) {
        self.skipdeath = 1;
        self thread _do_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
        return;
    }
    self.skipdeath = 0;
}

// Namespace animation/animation_shared
// Params 7, eflags: 0x0
// Checksum 0xe301c12c, Offset: 0x1b28
// Size: 0xac
function _do_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp) {
    self endon(#"new_death_anim");
    self waittill("death");
    if (isdefined(self) && !self isragdoll()) {
        self play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
    }
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0x8ac3f00, Offset: 0x1be0
// Size: 0x5c
function set_player_clamps() {
    if (isdefined(self.player_anim_look_enabled) && self.player_anim_look_enabled) {
        self setviewclamp(self.player_anim_clamp_right, self.player_anim_clamp_left, self.player_anim_clamp_top, self.player_anim_clamp_bottom);
    }
}

// Namespace animation/animation_shared
// Params 2, eflags: 0x0
// Checksum 0xb3ef3118, Offset: 0x1c48
// Size: 0x82
function add_notetrack_func(funcname, func) {
    if (!isdefined(level._animnotifyfuncs)) {
        level._animnotifyfuncs = [];
    }
    /#
        assert(!isdefined(level._animnotifyfuncs[funcname]), "<dev string:xe5>");
    #/
    level._animnotifyfuncs[funcname] = func;
}

// Namespace animation/animation_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0x827dda7c, Offset: 0x1cd8
// Size: 0x144
function add_global_notetrack_handler(str_note, func, pass_notify_params, ...) {
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
    level._animnotetrackhandlers[str_note][level._animnotetrackhandlers[str_note].size] = array(func, pass_notify_params, vararg);
}

// Namespace animation/animation_shared
// Params 3, eflags: 0x0
// Checksum 0xc382a1c2, Offset: 0x1e28
// Size: 0x132
function call_notetrack_handler(str_note, param1, param2) {
    if (isdefined(level._animnotetrackhandlers[str_note])) {
        foreach (handler in level._animnotetrackhandlers[str_note]) {
            func = handler[0];
            passnotifyparams = handler[1];
            args = handler[2];
            if (passnotifyparams) {
                self [[ func ]](param1, param2);
                continue;
            }
            util::single_func_argarray(self, func, args);
        }
    }
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0xda082ab6, Offset: 0x1f68
// Size: 0x3c4
function setup_notetracks() {
    add_notetrack_func("flag::set", &flagsys::set);
    add_notetrack_func("flag::clear", &flagsys::clear);
    add_notetrack_func("util::break_glass", &util::break_glass);
    clientfield::register("scriptmover", "cracks_on", 1, getminbitcountfornum(4), "int");
    clientfield::register("scriptmover", "cracks_off", 1, getminbitcountfornum(4), "int");
    add_global_notetrack_handler("red_cracks_on", &cracks_on, 0, "red");
    add_global_notetrack_handler("green_cracks_on", &cracks_on, 0, "green");
    add_global_notetrack_handler("blue_cracks_on", &cracks_on, 0, "blue");
    add_global_notetrack_handler("all_cracks_on", &cracks_on, 0, "all");
    add_global_notetrack_handler("red_cracks_off", &cracks_off, 0, "red");
    add_global_notetrack_handler("green_cracks_off", &cracks_off, 0, "green");
    add_global_notetrack_handler("blue_cracks_off", &cracks_off, 0, "blue");
    add_global_notetrack_handler("all_cracks_off", &cracks_off, 0, "all");
    add_global_notetrack_handler("headlook_on", &enable_headlook, 0, 1);
    add_global_notetrack_handler("headlook_off", &enable_headlook, 0, 0);
    add_global_notetrack_handler("headlook_notorso_on", &enable_headlook_notorso, 0, 1);
    add_global_notetrack_handler("headlook_notorso_off", &enable_headlook_notorso, 0, 0);
    add_global_notetrack_handler("attach weapon", &attach_weapon, 1);
    add_global_notetrack_handler("detach weapon", &detach_weapon, 1);
    add_global_notetrack_handler("fire", &fire_weapon, 0);
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0x1be8e1a5, Offset: 0x2338
// Size: 0xc6
function handle_notetracks(animation) {
    self endon(#"death", #"new_scripted_anim");
    while (true) {
        waitresult = self waittill(animation);
        str_note = waitresult.notetrack;
        if (isdefined(str_note)) {
            if (str_note != "end" && str_note != "loop_end") {
                self thread call_notetrack_handler(str_note, waitresult.param1, waitresult.param2);
                continue;
            }
            return;
        }
    }
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0xdfeb1f74, Offset: 0x2408
// Size: 0xbe
function cracks_on(str_type) {
    switch (str_type) {
    case #"red":
        clientfield::set("cracks_on", 1);
        break;
    case #"green":
        clientfield::set("cracks_on", 3);
        break;
    case #"blue":
        clientfield::set("cracks_on", 2);
        break;
    case #"all":
        clientfield::set("cracks_on", 4);
        break;
    }
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0x925f0d4f, Offset: 0x24d0
// Size: 0xbe
function cracks_off(str_type) {
    switch (str_type) {
    case #"red":
        clientfield::set("cracks_off", 1);
        break;
    case #"green":
        clientfield::set("cracks_off", 3);
        break;
    case #"blue":
        clientfield::set("cracks_off", 2);
        break;
    case #"all":
        clientfield::set("cracks_off", 4);
        break;
    }
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0x7bcaec16, Offset: 0x2598
// Size: 0x7c
function enable_headlook(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (isactor(self)) {
        if (b_on) {
            self lookatentity(level.players[0]);
            return;
        }
        self lookatentity();
    }
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0xbd73c33d, Offset: 0x2620
// Size: 0x7c
function enable_headlook_notorso(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (isactor(self)) {
        if (b_on) {
            self lookatentity(level.players[0], 1);
            return;
        }
        self lookatentity();
    }
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0xd678b09f, Offset: 0x26a8
// Size: 0x28
function is_valid_weapon(weaponobject) {
    return isdefined(weaponobject) && weaponobject != level.weaponnone;
}

// Namespace animation/animation_shared
// Params 2, eflags: 0x0
// Checksum 0x837b50e9, Offset: 0x26d8
// Size: 0x18c
function attach_weapon(weaponobject, tag) {
    if (!isdefined(tag)) {
        tag = "tag_weapon_right";
    }
    if (isactor(self)) {
        if (is_valid_weapon(weaponobject)) {
            ai::gun_switchto(weaponobject.name, "right");
        } else {
            ai::gun_recall();
        }
        return;
    }
    if (!is_valid_weapon(weaponobject)) {
        weaponobject = self.last_item;
    }
    if (is_valid_weapon(weaponobject)) {
        if (self.item != level.weaponnone) {
            detach_weapon();
        }
        /#
            assert(isdefined(weaponobject.worldmodel));
        #/
        self attach(weaponobject.worldmodel, tag);
        self setentityweapon(weaponobject);
        self.gun_removed = undefined;
        self.last_item = weaponobject;
    }
}

// Namespace animation/animation_shared
// Params 2, eflags: 0x0
// Checksum 0x2ecc5ba9, Offset: 0x2870
// Size: 0xf4
function detach_weapon(weaponobject, tag) {
    if (!isdefined(tag)) {
        tag = "tag_weapon_right";
    }
    if (isactor(self)) {
        ai::gun_remove();
        return;
    }
    if (!is_valid_weapon(weaponobject)) {
        weaponobject = self.item;
    }
    if (is_valid_weapon(weaponobject)) {
        self detach(weaponobject.worldmodel, tag);
        self setentityweapon(level.weaponnone);
    }
    self.gun_removed = 1;
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0x5be32b78, Offset: 0x2970
// Size: 0xcc
function fire_weapon() {
    if (!isai(self)) {
        if (self.item != level.weaponnone) {
            startpos = self gettagorigin("tag_flash");
            endpos = startpos + vectorscale(anglestoforward(self gettagangles("tag_flash")), 100);
            magicbullet(self.item, startpos, endpos, self);
        }
    }
}

