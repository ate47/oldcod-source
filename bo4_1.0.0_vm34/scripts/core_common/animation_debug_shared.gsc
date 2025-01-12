#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flagsys_shared;

#namespace animation;

/#

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x2
    // Checksum 0x5c8d7bbd, Offset: 0x80
    // Size: 0x228
    function autoexec function_60a7c0fb() {
        setdvar(#"anim_debug", 0);
        setdvar(#"anim_debug_pause", 0);
        var_bdca3880 = 0;
        while (true) {
            b_anim_debug = getdvarint(#"anim_debug", 0) || getdvarint(#"anim_debug_pause", 0);
            if (b_anim_debug && !level flagsys::get("<dev string:x30>")) {
                level flagsys::set("<dev string:x30>");
                a_ents = getentarray("<dev string:x3b>", "<dev string:x42>", 1);
                foreach (ent in a_ents) {
                    ent thread anim_info_render_thread(ent.var_5533d19a.animation, ent.var_5533d19a.v_origin_or_ent, ent.var_5533d19a.v_angles_or_tag, ent.var_5533d19a.var_3bb6221f);
                }
                var_bdca3880 = 1;
            } else if (!b_anim_debug) {
                level notify(#"kill_anim_debug");
                var_bdca3880 = 0;
            }
            waitframe(1);
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x9208d19f, Offset: 0x2b0
    // Size: 0x3e
    function is_anim_debugging(ent) {
        return isdefined(ent) && ent flagsys::get(#"scriptedanim");
    }

    // Namespace animation/animation_debug_shared
    // Params 4, eflags: 0x0
    // Checksum 0x56933857, Offset: 0x2f8
    // Size: 0xa96
    function anim_info_render_thread(animation, v_origin_or_ent, v_angles_or_tag, var_3bb6221f) {
        self notify(#"_anim_info_render_thread_");
        self endon(#"_anim_info_render_thread_", #"death", #"scriptedanim");
        level endon(#"kill_anim_debug");
        if (!isvec(v_origin_or_ent)) {
            v_origin_or_ent endon(#"death");
        }
        if (!isdefined(level.debug_ents_by_origin)) {
            level.debug_ents_by_origin = [];
        }
        str_origin = "<dev string:x59>" + floor(self.origin[0] / 10) * 10 + "<dev string:x5a>" + floor(self.origin[1] / 10) * 10 + "<dev string:x5a>" + floor(self.origin[2] / 10) * 10;
        if (!isdefined(level.debug_ents_by_origin[str_origin])) {
            level.debug_ents_by_origin[str_origin] = [];
        }
        array::filter(level.debug_ents_by_origin[str_origin], 0, &is_anim_debugging);
        array::add(level.debug_ents_by_origin[str_origin], self, 0);
        n_same_origin_index = array::find(level.debug_ents_by_origin[str_origin], self);
        recordent(self);
        while (true) {
            _init_frame();
            str_extra_info = "<dev string:x59>";
            color = (1, 1, 0);
            if (flagsys::get(#"firstframe")) {
                str_extra_info += "<dev string:x5c>";
            }
            var_11b4901b = getanimframecount(animation);
            var_773d59c3 = self getanimtime(animation) * var_11b4901b;
            var_62f1cd48 = getanimlength(animation);
            var_9e296f0f = self getanimtime(animation) * var_62f1cd48;
            str_extra_info += "<dev string:x6a>" + var_9e296f0f + "<dev string:x76>" + var_62f1cd48 + "<dev string:x78>" + var_773d59c3 + "<dev string:x76>" + var_11b4901b + "<dev string:x89>";
            if (isarray(var_3bb6221f) && var_3bb6221f.size) {
                var_ccccdd8b = "<dev string:x59>";
                foreach (var_382c276e, str_anim in var_3bb6221f) {
                    var_ccccdd8b += "<dev string:x8b>" + var_382c276e + "<dev string:x93>" + str_anim;
                }
            }
            s_pos = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
            self anim_origin_render(s_pos.origin, s_pos.angles, undefined, undefined, !true);
            if (true) {
                line(self.origin, s_pos.origin, color, 0.5, 1);
                sphere(s_pos.origin, 2, (0.3, 0.3, 0.3), 0.5, 1);
            }
            recordline(self.origin, s_pos.origin, color, "<dev string:xa4>");
            recordsphere(s_pos.origin, 2, (0.3, 0.3, 0.3), "<dev string:xa4>");
            if (!isvec(v_origin_or_ent) && v_origin_or_ent != self && v_origin_or_ent != level) {
                str_name = "<dev string:xb1>";
                if (isdefined(v_origin_or_ent.animname)) {
                    str_name = v_origin_or_ent.animname;
                } else if (isdefined(v_origin_or_ent.targetname)) {
                    str_name = v_origin_or_ent.targetname;
                }
                if (true) {
                    print3d(v_origin_or_ent.origin + (0, 0, 5), str_name, (0.3, 0.3, 0.3), 1, 0.15);
                }
                record3dtext(str_name, v_origin_or_ent.origin + (0, 0, 5), (0.3, 0.3, 0.3), "<dev string:xa4>");
            }
            self anim_origin_render(self.origin, self.angles, undefined, undefined, !true);
            str_name = "<dev string:xb1>";
            if (isdefined(self.anim_debug_name)) {
                str_name = self.anim_debug_name;
            } else if (isdefined(self.animname)) {
                str_name = self.animname;
            } else if (isdefined(self.targetname)) {
                str_name = self.targetname;
            }
            var_31308fb2 = self.origin - (0, 0, 15 * n_same_origin_index);
            if (true) {
                print3d(var_31308fb2, self getentnum() + get_ent_type() + "<dev string:xb9>" + str_name, color, 0.8, 0.3);
                print3d(var_31308fb2 - (0, 0, 5), "<dev string:xc2>" + (isanimlooping(animation) ? "<dev string:xc7>" : "<dev string:xcf>") + function_15979fa9(animation), color, 0.8, 0.3);
                print3d(var_31308fb2 - (0, 0, 11), str_extra_info, color, 0.8, 0.3);
                if (isdefined(var_ccccdd8b)) {
                    print3d(var_31308fb2 - (0, 0, 13), var_ccccdd8b, color, 0.8, 0.15);
                }
            }
            record3dtext(self getentnum() + get_ent_type() + "<dev string:xd2>" + str_name, var_31308fb2, color, "<dev string:xa4>");
            record3dtext("<dev string:xd9>" + animation, var_31308fb2 - (0, 0, 5), color, "<dev string:xa4>");
            record3dtext(str_extra_info, var_31308fb2 - (0, 0, 7), color, "<dev string:xa4>");
            render_tag("<dev string:xe4>", "<dev string:xf5>", !true);
            render_tag("<dev string:xfb>", "<dev string:x10b>", !true);
            render_tag("<dev string:x110>", "<dev string:x11b>", !true);
            render_tag("<dev string:x122>", "<dev string:x12d>", !true);
            render_tag("<dev string:x134>", "<dev string:x13e>", !true);
            render_tag("<dev string:x144>", "<dev string:x14c>", !true);
            _reset_frame();
            waitframe(1);
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x88707a8a, Offset: 0xd98
    // Size: 0x6e
    function get_ent_type() {
        if (isactor(self)) {
            return "<dev string:x150>";
        }
        if (isvehicle(self)) {
            return "<dev string:x155>";
        }
        return "<dev string:x15f>" + self.classname + "<dev string:x161>";
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xae090914, Offset: 0xe10
    // Size: 0x22
    function _init_frame() {
        self.v_centroid = self getcentroid();
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf2da6115, Offset: 0xe40
    // Size: 0x12
    function _reset_frame() {
        self.v_centroid = undefined;
    }

    // Namespace animation/animation_debug_shared
    // Params 3, eflags: 0x0
    // Checksum 0xc37e46da, Offset: 0xe60
    // Size: 0x13c
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
            recordline(self.v_centroid, v_tag_org, (0.3, 0.3, 0.3), "<dev string:xa4>");
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 5, eflags: 0x0
    // Checksum 0x3e4a4b45, Offset: 0xfa8
    // Size: 0x244
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
            recordline(org, originendpoint, (1, 0, 0), "<dev string:xa4>");
            recordline(org, originrightpoint, (0, 1, 0), "<dev string:xa4>");
            recordline(org, originuppoint, (0, 0, 1), "<dev string:xa4>");
            if (isdefined(str_label)) {
                if (!b_recorder_only) {
                    print3d(org, str_label, (1, 0.752941, 0.796078), 1, 0.05);
                }
                record3dtext(str_label, org, (1, 0.752941, 0.796078), "<dev string:xa4>");
            }
        }
    }

#/
