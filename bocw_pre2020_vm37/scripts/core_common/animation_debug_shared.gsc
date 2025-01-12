#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;

#namespace animation;

// Namespace animation/animation_debug_shared
// Params 0, eflags: 0x6
// Checksum 0xf7322c22, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_26dee29e21290041", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace animation/animation_debug_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x6f50faf0, Offset: 0xc8
// Size: 0x1c
function function_70a657d8() {
    /#
        thread init();
    #/
}

/#

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xce3e3ef9, Offset: 0xf0
    // Size: 0x1ac
    function init() {
        flag::init_dvar(#"anim_debug");
        flag::init_dvar(#"anim_debug_pause");
        for (;;) {
            level flag::wait_till_any([#"anim_debug", #"anim_debug_pause"]);
            waitframe(1);
            a_ents = getentarray("<dev string:x38>", "<dev string:x42>", 1);
            foreach (ent in a_ents) {
                ent thread anim_info_render_thread();
            }
            level flag::wait_till_clear_all([#"anim_debug", #"anim_debug_pause"]);
            level notify(#"kill_anim_debug");
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5e17630a, Offset: 0x2a8
    // Size: 0x3e
    function is_anim_debugging(ent) {
        return isdefined(ent) && ent flag::get(#"scriptedanim");
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe81a5da1, Offset: 0x2f0
    // Size: 0xd06
    function anim_info_render_thread() {
        animation = self.var_6c4bb19.animation;
        v_origin_or_ent = self.var_6c4bb19.v_origin_or_ent;
        v_angles_or_tag = self.var_6c4bb19.v_angles_or_tag;
        var_f4b34dc1 = self.var_6c4bb19.var_f4b34dc1;
        self notify(#"_anim_info_render_thread_");
        self endon(#"_anim_info_render_thread_", #"death", #"scriptedanim");
        level endon(#"kill_anim_debug");
        if (!isdefined(v_origin_or_ent)) {
            v_origin_or_ent = self.origin;
        }
        if (!isvec(v_origin_or_ent)) {
            v_origin_or_ent endon(#"death");
        }
        if (!isdefined(level.debug_ents_by_origin)) {
            level.debug_ents_by_origin = [];
        }
        str_origin = "<dev string:x5c>" + floor(self.origin[0] / 10) * 10 + "<dev string:x60>" + floor(self.origin[1] / 10) * 10 + "<dev string:x60>" + floor(self.origin[2] / 10) * 10;
        if (!isdefined(level.debug_ents_by_origin[str_origin])) {
            level.debug_ents_by_origin[str_origin] = [];
        }
        array::filter(level.debug_ents_by_origin[str_origin], 0, &is_anim_debugging);
        array::add(level.debug_ents_by_origin[str_origin], self, 0);
        n_same_origin_index = array::find(level.debug_ents_by_origin[str_origin], self);
        recordent(self);
        while (true) {
            _init_frame();
            str_extra_info = "<dev string:x5c>";
            color = (1, 1, 0);
            if (flag::get(#"firstframe")) {
                str_extra_info += "<dev string:x65>";
            }
            var_13edeb1f = getanimframecount(animation);
            var_7b160393 = self getanimtime(animation) * var_13edeb1f;
            var_958054e5 = getanimlength(animation);
            var_f667af2f = self getanimtime(animation) * var_958054e5;
            str_extra_info += "<dev string:x76>" + var_f667af2f + "<dev string:x85>" + var_958054e5 + "<dev string:x8a>" + var_7b160393 + "<dev string:x85>" + var_13edeb1f + "<dev string:x9e>";
            if (isarray(var_f4b34dc1) && var_f4b34dc1.size) {
                var_1c56a327 = "<dev string:x5c>";
                foreach (var_21c1ba1, str_anim in var_f4b34dc1) {
                    var_1c56a327 += "<dev string:xa3>" + var_21c1ba1 + "<dev string:xae>" + function_9e72a96(str_anim) + "<dev string:xc2>";
                }
            }
            s_pos = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
            self anim_origin_render(s_pos.origin, s_pos.angles, undefined, undefined, !true);
            if (true) {
                line(self.origin, s_pos.origin, color, 0.5, 1);
                sphere(s_pos.origin, 2, (0.3, 0.3, 0.3), 0.5, 1);
            }
            recordline(self.origin, s_pos.origin, color, "<dev string:xc7>");
            recordsphere(s_pos.origin, 2, (0.3, 0.3, 0.3), "<dev string:xc7>");
            if (!isvec(v_origin_or_ent) && v_origin_or_ent != self && v_origin_or_ent != level) {
                str_name = "<dev string:xd7>";
                if (isdefined(v_origin_or_ent.animname)) {
                    str_name = v_origin_or_ent.animname;
                } else if (isdefined(v_origin_or_ent.targetname)) {
                    str_name = v_origin_or_ent.targetname;
                }
                if (true) {
                    print3d(v_origin_or_ent.origin + (0, 0, 5), str_name, (0.3, 0.3, 0.3), 1, 0.15);
                }
                record3dtext(str_name, v_origin_or_ent.origin + (0, 0, 5), (0.3, 0.3, 0.3), "<dev string:xc7>");
            }
            self anim_origin_render(self.origin, self.angles, undefined, undefined, !true);
            str_name = "<dev string:xd7>";
            if (isdefined(self.anim_debug_name)) {
                str_name = self.anim_debug_name;
            } else if (isdefined(self.animname)) {
                str_name = self.animname;
            } else if (isdefined(self.targetname)) {
                str_name = self.targetname;
            }
            maso_they_don_t_see_us_ye_ = self.origin - (0, 0, 15 * n_same_origin_index);
            if (true) {
                print3d(maso_they_don_t_see_us_ye_, self getentnum() + get_ent_type() + "<dev string:xe2>" + str_name, color, 0.8, 0.3);
                print3d(maso_they_don_t_see_us_ye_ - (0, 0, 5), "<dev string:xee>" + (isanimlooping(animation) ? "<dev string:xf6>" : "<dev string:x101>") + function_9e72a96(animation), color, 0.8, 0.3);
                print3d(maso_they_don_t_see_us_ye_ - (0, 0, 11), str_extra_info, color, 0.8, 0.3);
                if (isdefined(var_1c56a327)) {
                    print3d(maso_they_don_t_see_us_ye_ - (0, 0, 17), var_1c56a327, color, 0.8, 0.15);
                }
            }
            record3dtext(self getentnum() + get_ent_type() + "<dev string:x107>" + str_name, maso_they_don_t_see_us_ye_, color, "<dev string:xc7>");
            record3dtext("<dev string:x111>" + animation, maso_they_don_t_see_us_ye_ - (0, 0, 5), color, "<dev string:xc7>");
            record3dtext(str_extra_info, maso_they_don_t_see_us_ye_ - (0, 0, 7), color, "<dev string:xc7>");
            render_tag("<dev string:x11f>", "<dev string:x133>", !true);
            render_tag("<dev string:x13c>", "<dev string:x14f>", !true);
            render_tag("<dev string:x157>", "<dev string:x165>", !true);
            render_tag("<dev string:x16f>", "<dev string:x17d>", !true);
            render_tag("<dev string:x187>", "<dev string:x194>", !true);
            render_tag("<dev string:x19d>", "<dev string:x1a8>", !true);
            render_tag("<dev string:x1af>", "<dev string:x1af>", !true);
            render_tag("<dev string:x1bb>", "<dev string:x1bb>", !true);
            render_tag("<dev string:x1c7>", "<dev string:x1d3>", !true);
            render_tag("<dev string:x1d3>", "<dev string:x1df>", !true);
            render_tag("<dev string:x1df>", "<dev string:x1eb>", !true);
            render_tag("<dev string:x1f7>", "<dev string:x1f7>", !true);
            render_tag("<dev string:x203>", "<dev string:x203>", !true);
            render_tag("<dev string:x20f>", "<dev string:x20f>", !true);
            render_tag("<dev string:x21b>", "<dev string:x21b>", !true);
            render_tag("<dev string:x228>", "<dev string:x228>", !true);
            render_tag("<dev string:x235>", "<dev string:x235>", !true);
            render_tag("<dev string:x242>", "<dev string:x242>", !true);
            render_tag("<dev string:x24f>", "<dev string:x24f>", !true);
            render_tag("<dev string:x25c>", "<dev string:x25c>", !true);
            _reset_frame();
            waitframe(1);
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x87e71216, Offset: 0x1000
    // Size: 0x6e
    function get_ent_type() {
        if (isactor(self)) {
            return "<dev string:x269>";
        }
        if (isvehicle(self)) {
            return "<dev string:x271>";
        }
        return "<dev string:x27e>" + self.classname + "<dev string:x283>";
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2f0225c7, Offset: 0x1078
    // Size: 0x22
    function _init_frame() {
        self.v_centroid = self getcentroid();
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x605a2bf0, Offset: 0x10a8
    // Size: 0x12
    function _reset_frame() {
        self.v_centroid = undefined;
    }

    // Namespace animation/animation_debug_shared
    // Params 3, eflags: 0x0
    // Checksum 0x500a0490, Offset: 0x10c8
    // Size: 0x134
    function render_tag(str_tag, str_label, b_recorder_only) {
        if (!isdefined(str_label)) {
            str_label = str_tag;
        }
        if (!isdefined(self.v_centroid)) {
            self.v_centroid = self getcentroid();
        }
        v_tag_org = self gettagorigin(str_tag);
        if (isdefined(v_tag_org)) {
            v_tag_ang = self gettagangles(str_tag);
            anim_origin_render(v_tag_org, v_tag_ang, 2, str_label, b_recorder_only);
            if (!b_recorder_only) {
                line(self.v_centroid, v_tag_org, (0.3, 0.3, 0.3), 0.5, 1);
            }
            recordline(self.v_centroid, v_tag_org, (0.3, 0.3, 0.3), "<dev string:xc7>");
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 5, eflags: 0x0
    // Checksum 0xe34714c7, Offset: 0x1208
    // Size: 0x20c
    function anim_origin_render(org, angles, line_length, str_label, b_recorder_only) {
        if (!isdefined(line_length)) {
            line_length = 6;
        }
        if (isdefined(org) && isdefined(angles)) {
            originendpoint = org + vectorscale(anglestoforward(angles), line_length);
            originrightpoint = org + vectorscale(anglestoright(angles), -1 * line_length);
            originuppoint = org + vectorscale(anglestoup(angles), line_length);
            if (!b_recorder_only) {
                line(org, originendpoint, (1, 0, 0));
                line(org, originrightpoint, (0, 1, 0));
                line(org, originuppoint, (0, 0, 1));
            }
            recordline(org, originendpoint, (1, 0, 0), "<dev string:xc7>");
            recordline(org, originrightpoint, (0, 1, 0), "<dev string:xc7>");
            recordline(org, originuppoint, (0, 0, 1), "<dev string:xc7>");
            if (isdefined(str_label)) {
                if (!b_recorder_only) {
                    print3d(org, str_label, (1, 0.752941, 0.796078), 1, 0.05);
                }
                record3dtext(str_label, org, (1, 0.752941, 0.796078), "<dev string:xc7>");
            }
        }
    }

#/
