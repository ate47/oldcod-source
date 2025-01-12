#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_debug_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\string_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\voice\voice;

#namespace animation;

// Namespace animation/animation_shared
// Params 0, eflags: 0x2
// Checksum 0xbbdc6fef, Offset: 0x2e0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"animation", &__init__, undefined, undefined);
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0xb920eaa1, Offset: 0x328
// Size: 0xf4
function __init__() {
    if (getdvarstring(#"debug_anim_shared", "") == "") {
        setdvar(#"debug_anim_shared", "");
    }
    setup_notetracks();
    callback::on_laststand(&reset_player);
    callback::on_bleedout(&reset_player);
    callback::on_player_killed(&reset_player);
    callback::on_spawned(&reset_player);
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0xa587194, Offset: 0x428
// Size: 0x64
function reset_player() {
    flagsys::clear(#"firstframe");
    flagsys::clear(#"scripted_anim_this_frame");
    flagsys::clear(#"scriptedanim");
}

// Namespace animation/animation_shared
// Params 3, eflags: 0x0
// Checksum 0x95c8ebae, Offset: 0x498
// Size: 0x3c
function first_frame(animation, v_origin_or_ent, v_angles_or_tag) {
    self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0);
}

// Namespace animation/animation_shared
// Params 3, eflags: 0x0
// Checksum 0x2c87a3e6, Offset: 0x4e0
// Size: 0x4c
function last_frame(animation, v_origin_or_ent, v_angles_or_tag) {
    self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0, 0, 0, 0, 1);
}

// Namespace animation/animation_shared
// Params 2, eflags: 0x0
// Checksum 0xecffbde3, Offset: 0x538
// Size: 0xf4
function play_siege(str_anim, n_rate = 1) {
    self notify(#"stop_siege_anim");
    self endon(#"death", #"scene_stop", #"stop_siege_anim");
    b_loop = function_54ae9b01(str_anim);
    self function_c644918b(str_anim, "default", n_rate, b_loop);
    if (b_loop) {
        self waittill(#"stop_siege_anim");
        return;
    }
    n_length = function_b6fdcf2f(str_anim);
    wait n_length;
}

// Namespace animation/animation_shared
// Params 12, eflags: 0x0
// Checksum 0x3f914495, Offset: 0x638
// Size: 0x172
function play(animation, v_origin_or_ent, v_angles_or_tag, n_rate = 1, n_blend_in = 0.2, n_blend_out = 0.2, n_lerp = 0, n_start_time = 0, b_show_player_firstperson_weapon = 0, b_unlink_after_completed = 1, var_3bb6221f, paused) {
    if (self isragdoll()) {
        return;
    }
    self endon(#"death", #"entering_last_stand");
    self thread _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed, var_3bb6221f, paused);
    if (n_rate > 0) {
        self waittill(#"scriptedanim");
    }
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0x116c575d, Offset: 0x7b8
// Size: 0x54
function stop(n_blend = 0.2) {
    flagsys::clear(#"scriptedanim");
    self stopanimscripted(n_blend);
}

/#

    // Namespace animation/animation_shared
    // Params 2, eflags: 0x0
    // Checksum 0x5326c258, Offset: 0x818
    // Size: 0x204
    function debug_print(str_animation, str_msg) {
        str_dvar = getdvarstring(#"debug_anim_shared", "<dev string:x30>");
        if (str_dvar != "<dev string:x30>") {
            if (!isstring(str_animation)) {
                str_animation = isdefined(function_15979fa9(str_animation)) ? "<dev string:x30>" + function_15979fa9(str_animation) : "<dev string:x30>";
            }
            b_print = 0;
            if (strisnumber(str_dvar)) {
                if (int(str_dvar) > 0) {
                    b_print = 1;
                }
            } else if (issubstr(str_animation, str_dvar) || isdefined(self.animname) && issubstr(self.animname, str_dvar)) {
                b_print = 1;
            }
            if (b_print) {
                printtoprightln(str_animation + "<dev string:x31>" + string::rjust(str_msg, 10) + "<dev string:x31>" + string::rjust("<dev string:x30>" + self getentitynumber(), 4) + "<dev string:x35>" + string::rjust("<dev string:x30>" + gettime(), 6) + "<dev string:x38>", (1, 1, 0), -1);
            }
        }
    }

#/

// Namespace animation/animation_shared
// Params 12, eflags: 0x0
// Checksum 0xc09d9da, Offset: 0xa28
// Size: 0x7e4
function _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed, var_3bb6221f, paused) {
    self notify(#"new_scripted_anim");
    self endoncallback(&function_be62823f, #"death", #"entering_last_stand", #"new_scripted_anim");
    /#
        debug_print(animation, "<dev string:x3a>");
    #/
    flagsys::set_val("firstframe", n_rate == 0 && !(isdefined(paused) && paused));
    flagsys::set(#"scripted_anim_this_frame");
    flagsys::set(#"scriptedanim");
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
        str_tag = v_angles_or_tag;
        v_origin = v_origin_or_ent gettagorigin(str_tag);
        v_angles = v_origin_or_ent gettagangles(str_tag);
        assert(isdefined(v_origin) && isdefined(v_angles), "<dev string:x42>" + function_15979fa9(animation) + "<dev string:x73>" + v_origin_or_ent getentitynumber() + "<dev string:x80>" + v_angles_or_tag + "<dev string:x8b>");
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
        } else if (isplayer(self)) {
            self setorigin(v_origin);
            self setplayerangles(v_angles);
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
            } else if (isplayer(self)) {
                self setorigin(prevorigin);
                self setplayerangles(prevangles);
            } else {
                self.origin = prevorigin;
                self.angles = prevangles;
            }
        }
    }
    self animscripted(animation, v_origin, v_angles, animation, "normal", undefined, n_rate, n_blend_in, n_lerp, n_start_time, 1, b_show_player_firstperson_weapon, var_3bb6221f, paused);
    if (isplayer(self)) {
        set_player_clamps();
    }
    /#
        self.var_6b16d178 = "<dev string:x8d>";
        self.var_5533d19a = {#animation:animation, #v_origin_or_ent:v_origin_or_ent, #v_angles_or_tag:v_angles_or_tag, #var_3bb6221f:var_3bb6221f};
        level flagsys::clear("<dev string:x94>");
    #/
    if (!isanimlooping(animation) && n_blend_out > 0 && n_rate > 0 && n_start_time < 1) {
        if (!animhasnotetrack(animation, "start_ragdoll")) {
            self thread _blend_out(animation, n_blend_out, n_rate, n_start_time);
        }
    }
    if (!flagsys::get(#"firstframe")) {
        self thread handle_notetracks(animation);
        if (getanimframecount(animation) > 1 || isanimlooping(animation)) {
            self waittillmatch({#notetrack:"end"}, animation);
        } else {
            waitframe(1);
        }
        if (b_link && isdefined(b_unlink_after_completed) && b_unlink_after_completed) {
            self unlink();
        }
        self.str_current_anim = undefined;
        self.var_6b16d178 = undefined;
        self.var_5533d19a = undefined;
        flagsys::clear(#"scriptedanim");
        flagsys::clear(#"firstframe");
        /#
            debug_print(animation, "<dev string:x9f>");
        #/
        waittillframeend();
        flagsys::clear(#"scripted_anim_this_frame");
    }
}

// Namespace animation/animation_shared
// Params 1, eflags: 0x0
// Checksum 0xb1eb4041, Offset: 0x1218
// Size: 0x3e
function function_be62823f(str_notify) {
    if (isdefined(self) && str_notify == "entering_last_stand") {
        self.var_6b16d178 = undefined;
        self.str_current_anim = undefined;
        self.var_5533d19a = undefined;
    }
}

// Namespace animation/animation_shared
// Params 4, eflags: 0x0
// Checksum 0xc4359e41, Offset: 0x1260
// Size: 0x162
function _blend_out(animation, n_blend, n_rate, n_start_time) {
    self endon(#"death", #"end", #"scriptedanim", #"new_scripted_anim");
    n_server_length = floor(getanimlength(animation) / float(function_f9f48566()) / 1000) * float(function_f9f48566()) / 1000;
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
// Checksum 0x2fbb99e8, Offset: 0x13d0
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
// Checksum 0x88a7ad8a, Offset: 0x1428
// Size: 0x1a6
function _get_align_pos(v_origin_or_ent = self.origin, v_angles_or_tag = isdefined(self.angles) ? self.angles : (0, 0, 0)) {
    s = spawnstruct();
    if (isvec(v_origin_or_ent)) {
        assert(isvec(v_angles_or_tag), "<dev string:xa5>");
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
// Checksum 0x830277a0, Offset: 0x15d8
// Size: 0x162
function teleport(animation, v_origin_or_ent, v_angles_or_tag, time = 0) {
    s = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
    v_pos = getstartorigin(s.origin, s.angles, animation, time);
    v_ang = getstartangles(s.origin, s.angles, animation, time);
    if (isactor(self)) {
        self forceteleport(v_pos, v_ang);
        return;
    }
    if (isplayer(self)) {
        self setorigin(v_pos);
        self setplayerangles(v_ang);
        return;
    }
    self.origin = v_pos;
    self.angles = v_ang;
}

// Namespace animation/animation_shared
// Params 4, eflags: 0x0
// Checksum 0xc7bc7899, Offset: 0x1748
// Size: 0xa4
function reach(animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals = 0) {
    self endon(#"death");
    s_tracker = spawnstruct();
    self thread _reach(s_tracker, animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals);
    s_tracker waittill(#"done");
}

// Namespace animation/animation_shared
// Params 5, eflags: 0x0
// Checksum 0x5a850aa4, Offset: 0x17f8
// Size: 0x3c6
function _reach(s_tracker, animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals = 0) {
    self endon(#"death");
    self notify(#"stop_going_to_node");
    self notify(#"new_anim_reach");
    flagsys::wait_till_clear("anim_reach");
    flagsys::set(#"anim_reach");
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
        self thread ai::force_goal(goal, 1, undefined, 0, 1);
        /#
            self thread debug_anim_reach();
        #/
        self waittill(#"goal", #"new_anim_reach", #"new_scripted_anim", #"stop_scripted_anim");
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
    flagsys::clear(#"anim_reach");
    s_tracker notify(#"done");
    self notify(#"reach_done");
}

/#

    // Namespace animation/animation_shared
    // Params 0, eflags: 0x0
    // Checksum 0x62c0639e, Offset: 0x1bc8
    // Size: 0xb6
    function debug_anim_reach() {
        self endon(#"death", #"goal", #"new_anim_reach", #"new_scripted_anim", #"stop_scripted_anim");
        while (true) {
            level flagsys::wait_till("<dev string:x94>");
            print3d(self.origin, "<dev string:xcb>", (1, 0, 0), 1, 1, 1);
            waitframe(1);
        }
    }

#/

// Namespace animation/animation_shared
// Params 7, eflags: 0x0
// Checksum 0x7f450da9, Offset: 0x1c88
// Size: 0xa2
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
// Checksum 0x3e9f6707, Offset: 0x1d38
// Size: 0xb4
function _do_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp) {
    self endon(#"new_death_anim");
    self waittill(#"death");
    if (isdefined(self) && !self isragdoll()) {
        self play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
    }
}

// Namespace animation/animation_shared
// Params 0, eflags: 0x0
// Checksum 0x47111f67, Offset: 0x1df8
// Size: 0x54
function set_player_clamps() {
    if (isdefined(self.player_anim_look_enabled) && self.player_anim_look_enabled) {
        self setviewclamp(self.player_anim_clamp_right, self.player_anim_clamp_left, self.player_anim_clamp_top, self.player_anim_clamp_bottom);
    }
}

// Namespace animation/animation_shared
// Params 2, eflags: 0x0
// Checksum 0x15ed06d6, Offset: 0x1e58
// Size: 0x7a
function add_notetrack_func(funcname, func) {
    if (!isdefined(level._animnotifyfuncs)) {
        level._animnotifyfuncs = [];
    }
    assert(!isdefined(level._animnotifyfuncs[funcname]), "<dev string:xd6>");
    level._animnotifyfuncs[funcname] = func;
}

// Namespace animation/animation_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0xd7ec1df4, Offset: 0x1ee0
// Size: 0x128
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
// Checksum 0x7932572f, Offset: 0x2010
// Size: 0x118
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
// Checksum 0x632d6be9, Offset: 0x2130
// Size: 0x3ec
function setup_notetracks() {
    add_notetrack_func("flag::set", &flagsys::set);
    add_notetrack_func("flag::clear", &flagsys::clear);
    add_notetrack_func("util::break_glass", &util::break_glass);
    add_notetrack_func("PhysicsLaunch", &function_9aafba73);
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
// Checksum 0x146e8f95, Offset: 0x2528
// Size: 0xce
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
// Checksum 0x2d8a3320, Offset: 0x2600
// Size: 0xe2
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
// Checksum 0x343f565, Offset: 0x26f0
// Size: 0xe2
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
// Checksum 0xeb7e9afd, Offset: 0x27e0
// Size: 0x74
function enable_headlook(b_on = 1) {
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
// Checksum 0x45e5c603, Offset: 0x2860
// Size: 0x7c
function enable_headlook_notorso(b_on = 1) {
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
// Checksum 0xccd72648, Offset: 0x28e8
// Size: 0x26
function is_valid_weapon(weaponobject) {
    return isdefined(weaponobject) && weaponobject != level.weaponnone;
}

// Namespace animation/animation_shared
// Params 2, eflags: 0x0
// Checksum 0xa6edd4b, Offset: 0x2918
// Size: 0x162
function attach_weapon(weaponobject, tag = "tag_weapon_right") {
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
        assert(isdefined(weaponobject.worldmodel));
        self attach(weaponobject.worldmodel, tag);
        self setentityweapon(weaponobject);
        self.gun_removed = undefined;
        self.last_item = weaponobject;
    }
}

// Namespace animation/animation_shared
// Params 2, eflags: 0x0
// Checksum 0x5c3e43a6, Offset: 0x2a88
// Size: 0xe2
function detach_weapon(weaponobject, tag = "tag_weapon_right") {
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
// Checksum 0xee79ecf6, Offset: 0x2b78
// Size: 0x154
function fire_weapon() {
    if (!isai(self)) {
        if (self.item != level.weaponnone) {
            v_start_pos = isdefined(self gettagorigin("tag_flash")) ? self gettagorigin("tag_flash") : self gettagorigin("tag_aim");
            v_start_ang = isdefined(self gettagangles("tag_flash")) ? self gettagangles("tag_flash") : self gettagangles("tag_aim");
            v_end_pos = v_start_pos + vectorscale(anglestoforward(v_start_ang), 100);
            magicbullet(self.item, v_start_pos, v_end_pos, self);
        }
    }
}

// Namespace animation/animation_shared
// Params 2, eflags: 0x0
// Checksum 0xacfb5c5d, Offset: 0x2cd8
// Size: 0x26c
function function_9aafba73(n_pulse = 100, bone) {
    assert(!issentient(self), "<dev string:xf9>");
    if (!isdefined(bone)) {
        bone = "tag_physics_pulse";
    }
    var_fc453910 = isdefined(self gettagorigin(bone)) ? self gettagorigin(bone) : self getcentroid();
    n_pulse = float(n_pulse);
    if (n_pulse == 0) {
        self physicslaunch(var_fc453910);
        return;
    }
    var_763d436e = self gettagangles(bone);
    var_ed1a05a7 = (0, 0, 100);
    color = (1, 0, 0);
    if (isdefined(var_763d436e)) {
        var_ed1a05a7 = vectorscale(anglestoforward(var_763d436e), n_pulse);
        color = (0, 1, 0);
    } else {
        x_dir = math::cointoss() ? 1 : -1;
        y_dir = math::cointoss() ? 1 : -1;
        z_dir = math::cointoss() ? 1 : -1;
        var_ed1a05a7 = vectorscale((x_dir, y_dir, z_dir), n_pulse);
        color = (1, 1, 0);
    }
    self physicslaunch(var_fc453910, var_ed1a05a7);
    /#
        util::draw_arrow_time(var_fc453910, var_fc453910 + var_ed1a05a7, color, 2);
    #/
}

