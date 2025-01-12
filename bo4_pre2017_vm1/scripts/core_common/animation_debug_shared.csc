#using scripts/core_common/animation_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/util_shared;

#namespace animation;

/#

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x2
    // Checksum 0x635b0796, Offset: 0x100
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
    // Params 7, eflags: 0x0
    // Checksum 0x400f902a, Offset: 0x1d8
    // Size: 0x4f0
    function anim_info_render_thread(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp) {
        self endon(#"death");
        self endon(#"scriptedanim");
        self notify(#"_anim_info_render_thread_");
        self endon(#"_anim_info_render_thread_");
        while (true) {
            level flagsys::wait_till("<dev string:x28>");
            _init_frame();
            str_extra_info = "<dev string:x44>";
            color = (0, 1, 1);
            if (flagsys::get("<dev string:x45>")) {
                str_extra_info += "<dev string:x50>";
            }
            s_pos = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
            self anim_origin_render(s_pos.origin, s_pos.angles);
            line(self.origin, s_pos.origin, color, 0.5, 1);
            sphere(s_pos.origin, 2, (0.3, 0.3, 0.3), 0.5, 1);
            if (v_origin_or_ent != self && !isvec(v_origin_or_ent) && v_origin_or_ent != level) {
                str_name = "<dev string:x5e>";
                if (isdefined(v_origin_or_ent.animname)) {
                    str_name = v_origin_or_ent.animname;
                } else if (isdefined(v_origin_or_ent.targetname)) {
                    str_name = v_origin_or_ent.targetname;
                }
                print3d(v_origin_or_ent.origin + (0, 0, 5), str_name, (0.3, 0.3, 0.3), 1, 0.15);
            }
            self anim_origin_render(self.origin, self.angles);
            str_name = "<dev string:x5e>";
            if (isdefined(self.anim_debug_name)) {
                str_name = self.anim_debug_name;
            } else if (isdefined(self.animname)) {
                str_name = self.animname;
            } else if (isdefined(self.targetname)) {
                str_name = self.targetname;
            }
            print3d(self.origin, self getentnum() + get_ent_type() + "<dev string:x66>" + str_name, color, 0.8, 0.3);
            print3d(self.origin - (0, 0, 5), "<dev string:x6d>" + animation, color, 0.8, 0.3);
            print3d(self.origin - (0, 0, 7), str_extra_info, color, 0.8, 0.15);
            render_tag("<dev string:x78>", "<dev string:x89>");
            render_tag("<dev string:x8f>", "<dev string:x9f>");
            render_tag("<dev string:xa4>", "<dev string:xaf>");
            render_tag("<dev string:xb6>", "<dev string:xc1>");
            _reset_frame();
            wait 0.01;
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x627171e5, Offset: 0x6d0
    // Size: 0x3e
    function get_ent_type() {
        return "<dev string:xc8>" + (isdefined(self.classname) ? self.classname : "<dev string:x44>") + "<dev string:xca>";
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5a81bd12, Offset: 0x718
    // Size: 0x8
    function _init_frame() {
        
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1cf3d76c, Offset: 0x728
    // Size: 0x12
    function _reset_frame() {
        self.v_centroid = undefined;
    }

    // Namespace animation/animation_debug_shared
    // Params 2, eflags: 0x0
    // Checksum 0xf6220619, Offset: 0x748
    // Size: 0xec
    function render_tag(str_tag, str_label) {
        if (!isdefined(str_label)) {
            str_label = str_tag;
        }
        v_tag_org = self gettagorigin(str_tag);
        if (isdefined(v_tag_org)) {
            v_tag_ang = self gettagangles(str_tag);
            anim_origin_render(v_tag_org, v_tag_ang, 2, str_label);
            if (isdefined(self.v_centroid)) {
                line(self.v_centroid, v_tag_org, (0.3, 0.3, 0.3), 0.5, 1);
            }
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 4, eflags: 0x0
    // Checksum 0x1520c883, Offset: 0x840
    // Size: 0x18c
    function anim_origin_render(org, angles, line_length, str_label) {
        if (!isdefined(line_length)) {
            line_length = 6;
        }
        if (isdefined(org) && isdefined(angles)) {
            originendpoint = org + vectorscale(anglestoforward(angles), line_length);
            originrightpoint = org + vectorscale(anglestoright(angles), -1 * line_length);
            originuppoint = org + vectorscale(anglestoup(angles), line_length);
            line(org, originendpoint, (1, 0, 0));
            line(org, originrightpoint, (0, 1, 0));
            line(org, originuppoint, (0, 0, 1));
            if (isdefined(str_label)) {
                print3d(org, str_label, (1, 0.752941, 0.796078), 1, 0.05);
            }
        }
    }

#/
