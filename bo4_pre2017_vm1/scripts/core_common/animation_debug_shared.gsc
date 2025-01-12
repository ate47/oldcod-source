#using scripts/core_common/animation_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/util_shared;

#namespace animation;

/#

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x2
    // Checksum 0xe64cf79c, Offset: 0x120
    // Size: 0xce
    function autoexec __init__() {
        setdvar("<dev string:x28>", 0);
        setdvar("<dev string:x33>", 0);
        while (true) {
            anim_debug = getdvarint("<dev string:x28>", 0) || getdvarint("<dev string:x33>", 0);
            level flagsys::set_val("<dev string:x28>", anim_debug);
            if (!anim_debug) {
                level notify(#"kill_anim_debug");
            }
            waitframe(1);
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x8e9dd3dd, Offset: 0x1f8
    // Size: 0x34
    function is_anim_debugging(ent) {
        return isdefined(ent) && ent flagsys::get("<dev string:x44>");
    }

    // Namespace animation/animation_debug_shared
    // Params 7, eflags: 0x0
    // Checksum 0xd5db5747, Offset: 0x238
    // Size: 0x8de
    function anim_info_render_thread(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp) {
        self endon(#"death");
        self endon(#"scriptedanim");
        self notify(#"_anim_info_render_thread_");
        self endon(#"_anim_info_render_thread_");
        if (!isvec(v_origin_or_ent)) {
            v_origin_or_ent endon(#"death");
        }
        if (!isdefined(level.debug_ents_by_origin)) {
            level.debug_ents_by_origin = [];
        }
        str_origin = "<dev string:x51>" + floor(self.origin[0] / 10) * 10 + "<dev string:x52>" + floor(self.origin[1] / 10) * 10 + "<dev string:x52>" + floor(self.origin[2] / 10) * 10;
        if (!isdefined(level.debug_ents_by_origin[str_origin])) {
            level.debug_ents_by_origin[str_origin] = [];
        }
        array::filter(level.debug_ents_by_origin[str_origin], 0, &is_anim_debugging);
        array::add(level.debug_ents_by_origin[str_origin], self, 0);
        n_same_origin_index = array::find(level.debug_ents_by_origin[str_origin], self);
        recordent(self);
        while (true) {
            level flagsys::wait_till("<dev string:x28>");
            var_109b63b9 = 1;
            _init_frame();
            str_extra_info = "<dev string:x51>";
            color = (1, 1, 0);
            if (flagsys::get("<dev string:x54>")) {
                str_extra_info += "<dev string:x5f>";
            }
            s_pos = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
            self anim_origin_render(s_pos.origin, s_pos.angles, undefined, undefined, !var_109b63b9);
            if (var_109b63b9) {
                line(self.origin, s_pos.origin, color, 0.5, 1);
                sphere(s_pos.origin, 2, (0.3, 0.3, 0.3), 0.5, 1);
            }
            recordline(self.origin, s_pos.origin, color, "<dev string:x6d>");
            recordsphere(s_pos.origin, 2, (0.3, 0.3, 0.3), "<dev string:x6d>");
            if (v_origin_or_ent != self && !isvec(v_origin_or_ent) && v_origin_or_ent != level) {
                str_name = "<dev string:x7a>";
                if (isdefined(v_origin_or_ent.animname)) {
                    str_name = v_origin_or_ent.animname;
                } else if (isdefined(v_origin_or_ent.targetname)) {
                    str_name = v_origin_or_ent.targetname;
                }
                if (var_109b63b9) {
                    print3d(v_origin_or_ent.origin + (0, 0, 5), str_name, (0.3, 0.3, 0.3), 1, 0.15);
                }
                record3dtext(str_name, v_origin_or_ent.origin + (0, 0, 5), (0.3, 0.3, 0.3), "<dev string:x6d>");
            }
            self anim_origin_render(self.origin, self.angles, undefined, undefined, !var_109b63b9);
            str_name = "<dev string:x7a>";
            if (isdefined(self.anim_debug_name)) {
                str_name = self.anim_debug_name;
            } else if (isdefined(self.animname)) {
                str_name = self.animname;
            } else if (isdefined(self.targetname)) {
                str_name = self.targetname;
            }
            var_31308fb2 = self.origin - (0, 0, 15 * n_same_origin_index);
            if (var_109b63b9) {
                print3d(var_31308fb2, self getentnum() + get_ent_type() + "<dev string:x82>" + str_name, color, 0.8, 0.3);
                print3d(var_31308fb2 - (0, 0, 5), "<dev string:x8b>" + (isanimlooping(animation) ? "<dev string:x90>" : "<dev string:x98>") + animation, color, 0.8, 0.3);
                print3d(var_31308fb2 - (0, 0, 7), str_extra_info, color, 0.8, 0.15);
            }
            record3dtext(self getentnum() + get_ent_type() + "<dev string:x9b>" + str_name, var_31308fb2, color, "<dev string:x6d>");
            record3dtext("<dev string:xa2>" + animation, var_31308fb2 - (0, 0, 5), color, "<dev string:x6d>");
            record3dtext(str_extra_info, var_31308fb2 - (0, 0, 7), color, "<dev string:x6d>");
            render_tag("<dev string:xad>", "<dev string:xbe>", !var_109b63b9);
            render_tag("<dev string:xc4>", "<dev string:xd4>", !var_109b63b9);
            render_tag("<dev string:xd9>", "<dev string:xe4>", !var_109b63b9);
            render_tag("<dev string:xeb>", "<dev string:xf6>", !var_109b63b9);
            _reset_frame();
            waitframe(1);
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xcf46421e, Offset: 0xb20
    // Size: 0x96
    function get_ent_type() {
        if (isactor(self)) {
            return "<dev string:xfd>";
        }
        if (isvehicle(self)) {
            return "<dev string:x102>";
        }
        if (self util::function_4f5dd9d2()) {
            return "<dev string:x10c>";
        }
        return "<dev string:x118>" + self.classname + "<dev string:x11a>";
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xdb01eeab, Offset: 0xbc0
    // Size: 0x24
    function _init_frame() {
        self.v_centroid = self getcentroid();
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x61c932b9, Offset: 0xbf0
    // Size: 0x12
    function _reset_frame() {
        self.v_centroid = undefined;
    }

    // Namespace animation/animation_debug_shared
    // Params 3, eflags: 0x0
    // Checksum 0xd9b7f81b, Offset: 0xc10
    // Size: 0x154
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
            recordline(self.v_centroid, v_tag_org, (0.3, 0.3, 0.3), "<dev string:x6d>");
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 5, eflags: 0x0
    // Checksum 0x94907e58, Offset: 0xd70
    // Size: 0x25c
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
            recordline(org, originendpoint, (1, 0, 0), "<dev string:x6d>");
            recordline(org, originrightpoint, (0, 1, 0), "<dev string:x6d>");
            recordline(org, originuppoint, (0, 0, 1), "<dev string:x6d>");
            if (isdefined(str_label)) {
                if (!b_recorder_only) {
                    print3d(org, str_label, (1, 0.752941, 0.796078), 1, 0.05);
                }
                record3dtext(str_label, org, (1, 0.752941, 0.796078), "<dev string:x6d>");
            }
        }
    }

#/
