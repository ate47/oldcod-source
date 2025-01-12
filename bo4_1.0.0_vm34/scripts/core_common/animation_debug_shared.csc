#using scripts\core_common\animation_shared;
#using scripts\core_common\flagsys_shared;

#namespace animation;

/#

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x2
    // Checksum 0xe8182106, Offset: 0x78
    // Size: 0x2a8
    function autoexec function_60a7c0fb() {
        setdvar(#"anim_debug", 0);
        setdvar(#"anim_debug_pause", 0);
        var_bdca3880 = 0;
        while (true) {
            b_anim_debug = getdvarint(#"anim_debug", 0) || getdvarint(#"anim_debug_pause", 0);
            if (b_anim_debug && !level flagsys::get("<dev string:x30>")) {
                level flagsys::set("<dev string:x30>");
                a_players = getlocalplayers();
                foreach (player in a_players) {
                    var_8ac4743c = player getlocalclientnumber();
                    a_ents = getentarray(var_8ac4743c, "<dev string:x3b>", "<dev string:x42>");
                    foreach (ent in a_ents) {
                        ent thread anim_info_render_thread(ent.var_5533d19a.animation, ent.var_5533d19a.v_origin_or_ent, ent.var_5533d19a.v_angles_or_tag);
                    }
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
    // Params 3, eflags: 0x0
    // Checksum 0x5e70e232, Offset: 0x328
    // Size: 0x526
    function anim_info_render_thread(animation, v_origin_or_ent, v_angles_or_tag) {
        self notify(#"_anim_info_render_thread_");
        self endon(#"_anim_info_render_thread_", #"death", #"scriptedanim");
        level endon(#"kill_anim_debug");
        while (true) {
            level flagsys::wait_till("<dev string:x30>");
            _init_frame();
            str_extra_info = "<dev string:x59>";
            color = (0, 1, 1);
            if (flagsys::get(#"firstframe")) {
                str_extra_info += "<dev string:x5a>";
            }
            var_62f1cd48 = getanimlength(animation);
            var_9e296f0f = self getanimtime(animation) * var_62f1cd48;
            str_extra_info += "<dev string:x68>" + var_9e296f0f + "<dev string:x74>" + var_62f1cd48 + "<dev string:x76>";
            s_pos = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
            self anim_origin_render(s_pos.origin, s_pos.angles);
            line(self.origin, s_pos.origin, color, 0.5, 1);
            sphere(s_pos.origin, 2, (0.3, 0.3, 0.3), 0.5, 1);
            if (!isvec(v_origin_or_ent) && v_origin_or_ent != self && v_origin_or_ent != level) {
                str_name = "<dev string:x7f>";
                if (isdefined(v_origin_or_ent.animname)) {
                    str_name = v_origin_or_ent.animname;
                } else if (isdefined(v_origin_or_ent.targetname)) {
                    str_name = v_origin_or_ent.targetname;
                }
                print3d(v_origin_or_ent.origin + (0, 0, 5), str_name, (0.3, 0.3, 0.3), 1, 0.15);
            }
            self anim_origin_render(self.origin, self.angles);
            str_name = "<dev string:x7f>";
            if (isdefined(self.anim_debug_name)) {
                str_name = self.anim_debug_name;
            } else if (isdefined(self.animname)) {
                str_name = self.animname;
            } else if (isdefined(self.targetname)) {
                str_name = self.targetname;
            }
            print3d(self.origin, self getentnum() + get_ent_type() + "<dev string:x87>" + str_name, color, 0.8, 0.3);
            print3d(self.origin - (0, 0, 5), "<dev string:x8e>" + function_15979fa9(animation), color, 0.8, 0.3);
            print3d(self.origin - (0, 0, 7), str_extra_info, color, 0.8, 0.15);
            render_tag("<dev string:xa2>", "<dev string:xb3>");
            render_tag("<dev string:xb9>", "<dev string:xc9>");
            render_tag("<dev string:xce>", "<dev string:xd9>");
            render_tag("<dev string:xe0>", "<dev string:xeb>");
            _reset_frame();
            waitframe(1);
        }
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x683ae6e8, Offset: 0x858
    // Size: 0x72
    function get_ent_type() {
        return "<dev string:xf2>" + (isdefined(isdefined(self.classname) ? self.classname : self.type) ? "<dev string:x59>" + (isdefined(self.classname) ? self.classname : self.type) : "<dev string:x59>") + "<dev string:xf4>";
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x19236f4b, Offset: 0x8d8
    // Size: 0x8
    function _init_frame() {
        
    }

    // Namespace animation/animation_debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbebc3aea, Offset: 0x8e8
    // Size: 0x12
    function _reset_frame() {
        self.v_centroid = undefined;
    }

    // Namespace animation/animation_debug_shared
    // Params 2, eflags: 0x0
    // Checksum 0xe854b57a, Offset: 0x908
    // Size: 0xcc
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
    // Checksum 0x837594b0, Offset: 0x9e0
    // Size: 0x174
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
