#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace ai_puppeteer;

/#

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x6
    // Checksum 0x783e57e5, Offset: 0x78
    // Size: 0x3c
    function private autoexec __init__system__() {
        system::register(#"ai_puppeteer", &function_70a657d8, undefined, undefined, undefined);
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x4
    // Checksum 0x8abbec0f, Offset: 0xc0
    // Size: 0x1c
    function private function_70a657d8() {
        level thread ai_puppeteer_think();
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4853edc9, Offset: 0xe8
    // Size: 0x15a
    function ai_puppeteer_think() {
        while (true) {
            if (getdvar(#"debug_ai_puppeteer", 0) && !is_true(level.ai_puppeteer_active)) {
                level.ai_puppeteer_active = 1;
                level notify(#"kill ai puppeteer");
                if (!util::function_88c74107()) {
                    adddebugcommand("<dev string:x38>");
                }
                thread ai_puppeteer();
            } else if (!getdvar(#"debug_ai_puppeteer", 0) && is_true(level.ai_puppeteer_active)) {
                level.ai_puppeteer_active = 0;
                if (util::function_88c74107()) {
                    adddebugcommand("<dev string:x38>");
                }
                level notify(#"kill ai puppeteer");
            }
            waitframe(1);
        }
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0xfecb3759, Offset: 0x250
    // Size: 0x15c
    function ai_puppeteer() {
        player = undefined;
        while (!isplayer(player)) {
            player = getplayers()[0];
            waitframe(1);
        }
        ai_puppeteer_create_hud();
        level.ai_puppet_highlighting = 0;
        player thread ai_puppet_cursor_tracker();
        player thread ai_puppet_manager();
        player val::set(#"ai_puppeteer", "<dev string:x42>", 1);
        level waittill(#"kill ai puppeteer");
        player val::reset(#"ai_puppeteer", "<dev string:x42>");
        ai_puppet_release(1);
        if (isdefined(level.ai_puppet_target)) {
            level.ai_puppet_target delete();
        }
        ai_puppeteer_destroy_hud();
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0x15e36c, Offset: 0x3b8
    // Size: 0x1048
    function ai_puppet_manager() {
        level endon(#"kill ai puppeteer");
        self endon(#"death");
        while (true) {
            if (self buttonpressed("<dev string:x4e>")) {
                if (isdefined(level.ai_puppet)) {
                    if (isdefined(level.ai_puppet_target)) {
                        if (isai(level.ai_puppet_target)) {
                            self thread ai_puppeteer_highlight_ai(level.ai_puppet_target, (1, 0, 0));
                            level.ai_puppet clearentitytarget();
                            level.ai_puppet_target = undefined;
                        } else {
                            self thread ai_puppeteer_highlight_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglestoforward(self getplayerangles()), (1, 0, 0));
                            level.ai_puppet clearentitytarget();
                            level.ai_puppet_target delete();
                        }
                    } else if (isdefined(level.playercursorai)) {
                        if (level.playercursorai != level.ai_puppet) {
                            level.ai_puppet setentitytarget(level.playercursorai);
                            level.ai_puppet_target = level.playercursorai;
                            level.ai_puppet getperfectinfo(level.ai_puppet_target);
                            self thread ai_puppeteer_highlight_ai(level.playercursorai, (1, 0, 0));
                        }
                    } else {
                        level.ai_puppet_target = spawn("<dev string:x5f>", level.playercursor[#"position"]);
                        level.ai_puppet_target makesentient();
                        level.ai_puppet_target.health = 10000;
                        level.ai_puppet_target_normal = level.playercursor[#"normal"];
                        level.ai_puppet setentitytarget(level.ai_puppet_target);
                        self thread ai_puppeteer_highlight_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglestoforward(self getplayerangles()), (1, 0, 0));
                    }
                }
                wait 0.2;
            } else if (self buttonpressed("<dev string:x6f>")) {
                if (isdefined(level.ai_puppet)) {
                    if (isdefined(level.ai_puppet) && isusingnavvolume(level.ai_puppet)) {
                        var_8d9fdff6 = vectornormalize(level.playercursor[#"position"] - self.origin);
                        level.playercursor[#"position"] = self.origin + vectorscale(var_8d9fdff6, 1000);
                        level.playercursor[#"position"] = level.ai_puppet getclosestpointonnavvolume(level.playercursor[#"position"], 400);
                    }
                    if (isdefined(level.playercursorai) && level.playercursorai != level.ai_puppet) {
                        level.ai_puppet setgoal(level.playercursorai);
                        level.ai_puppet.goalradius = 64;
                        level.ai_puppet.goalheight = level.ai_puppet.goalradius;
                        if (isusingnavvolume(level.ai_puppet)) {
                            level.ai_puppet.goalradius = level.ai_puppet.radius;
                            level.ai_puppet.goalheight = level.ai_puppet.goalradius;
                        }
                        self thread ai_puppeteer_highlight_ai(level.playercursorai, (0, 1, 0));
                    } else if (isdefined(level.playercursornode)) {
                        level.ai_puppet setgoal(level.playercursornode);
                        self thread ai_puppeteer_highlight_node(level.playercursornode);
                    } else {
                        if (isdefined(level.ai_puppet.scriptenemy)) {
                            to_target = level.ai_puppet.scriptenemy.origin - level.ai_puppet.origin;
                        } else {
                            to_target = level.playercursor[#"position"] - level.ai_puppet.origin;
                        }
                        angles = vectortoangles(to_target);
                        level.ai_puppet setgoal(level.playercursor[#"position"]);
                        self thread ai_puppeteer_highlight_point(level.playercursor[#"position"], level.playercursor[#"normal"], anglestoforward(self getplayerangles()), (0, 1, 0));
                    }
                }
                wait 0.2;
            } else if (self buttonpressed("<dev string:x7b>") && self buttonpressed("<dev string:x87>")) {
                if (isdefined(level.ai_puppet)) {
                    if (isusingnavvolume(level.ai_puppet)) {
                        var_8d9fdff6 = vectornormalize(level.playercursor[#"position"] - self.origin);
                        level.playercursor[#"position"] = self.origin + vectorscale(var_8d9fdff6, 1000);
                        level.playercursor[#"position"] = level.ai_puppet getclosestpointonnavvolume(level.playercursor[#"position"], 400);
                    }
                    if (isdefined(level.playercursorai) && level.playercursorai != level.ai_puppet) {
                        level.ai_puppet setgoal(level.playercursorai);
                        level.ai_puppet.goalradius = 64;
                        level.ai_puppet.goalheight = level.ai_puppet.goalradius;
                        if (isusingnavvolume(level.ai_puppet)) {
                            level.ai_puppet.goalradius = level.ai_puppet.radius;
                            level.ai_puppet.goalheight = level.ai_puppet.goalradius;
                        }
                        self thread ai_puppeteer_highlight_ai(level.playercursorai, (0, 1, 0));
                    } else if (isdefined(level.playercursornode)) {
                        if (isusingnavvolume(level.ai_puppet)) {
                            level.ai_puppet.goalradius = level.ai_puppet.radius;
                            level.ai_puppet.goalheight = level.ai_puppet.goalradius;
                        }
                        level.ai_puppet setgoal(level.playercursornode, 1);
                        self thread ai_puppeteer_highlight_node(level.playercursornode);
                    } else {
                        if (isusingnavvolume(level.ai_puppet)) {
                            level.ai_puppet.goalradius = level.ai_puppet.radius;
                            level.ai_puppet.goalheight = level.ai_puppet.goalradius;
                        }
                        if (isdefined(level.ai_puppet.scriptenemy)) {
                            to_target = level.ai_puppet.scriptenemy.origin - level.ai_puppet.origin;
                        } else {
                            to_target = level.playercursor[#"position"] - level.ai_puppet.origin;
                        }
                        angles = vectortoangles(to_target);
                        level.ai_puppet setgoal(level.playercursor[#"position"], 1);
                        self thread ai_puppeteer_highlight_point(level.playercursor[#"position"], level.playercursor[#"normal"], anglestoforward(self getplayerangles()), (0, 1, 0));
                    }
                }
                wait 0.2;
            } else if (self buttonpressed("<dev string:x93>")) {
                if (isdefined(level.playercursorai)) {
                    if (isdefined(level.ai_puppet) && level.playercursorai == level.ai_puppet) {
                        ai_puppet_release(1);
                    } else {
                        if (isdefined(level.ai_puppet)) {
                            ai_puppet_release(0);
                        }
                        ai_puppet_set();
                        self thread ai_puppeteer_highlight_ai(level.ai_puppet, (0, 1, 1));
                    }
                }
                wait 0.2;
            } else if (self buttonpressed("<dev string:x87>")) {
                if (isdefined(level.ai_puppet)) {
                    level.ai_puppet clearforcedgoal();
                }
                wait 0.2;
            } else if (self util::stance_button_held()) {
                if (isdefined(level.ai_puppet)) {
                    level.ai_puppet forceteleport(level.playercursor[#"position"], level.ai_puppet.angles);
                }
                wait 0.2;
            }
            if (isdefined(level.ai_puppet)) {
                ai_puppeteer_render_ai(level.ai_puppet, (0, 1, 1));
                if (isdefined(level.ai_puppet.scriptenemy) && !level.ai_puppet_highlighting) {
                    if (isai(level.ai_puppet.scriptenemy)) {
                        ai_puppeteer_render_ai(level.ai_puppet.scriptenemy, (1, 0, 0));
                    } else if (isdefined(level.ai_puppet_target)) {
                        self thread ai_puppeteer_render_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglestoforward(self getplayerangles()), (1, 0, 0));
                    }
                }
            }
            if (isdefined(level.ai_puppet)) {
                if (self buttonpressed("<dev string:x9f>")) {
                    level.ai_puppet.goalradius += 64;
                    level.ai_puppet.goalheight = level.ai_puppet.goalradius;
                } else if (self buttonpressed("<dev string:xaa>")) {
                    radius = level.ai_puppet.goalradius - 64;
                    if (radius < 16) {
                        radius = 16;
                    }
                    if (isusingnavvolume(level.ai_puppet) && radius < level.ai_puppet.radius) {
                        radius = level.ai_puppet.radius;
                    }
                    level.ai_puppet.goalradius = radius;
                    level.ai_puppet.goalheight = level.ai_puppet.goalradius;
                } else if (self buttonpressed("<dev string:xb7>") || self buttonpressed("<dev string:xc4>")) {
                    level.ai_puppet.goalradius = 16;
                    if (isusingnavvolume(level.ai_puppet)) {
                        level.ai_puppet.goalradius = level.ai_puppet.radius;
                    }
                    level.ai_puppet.goalheight = level.ai_puppet.goalradius;
                }
            }
            if (isdefined(level.ai_puppet)) {
                level.ai_puppet.fixednode = 0;
            }
            waitframe(1);
        }
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4c143ad5, Offset: 0x1408
    // Size: 0x114
    function ai_puppet_set() {
        level.ai_puppet = level.playercursorai;
        level.ai_puppet.ispuppet = 1;
        level.ai_puppet.old_goalradius = level.ai_puppet.goalradius;
        level.ai_puppet.goalradius = 16;
        level.ai_puppet.goalheight = level.ai_puppet.goalradius;
        level.ai_puppet.disabletargetservice = 1;
        if (isusingnavvolume(level.ai_puppet)) {
            level.ai_puppet.goalradius = level.ai_puppet.radius;
            level.ai_puppet.goalheight = level.ai_puppet.goalradius;
        }
        level.ai_puppet stopanimscripted();
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 1, eflags: 0x0
    // Checksum 0x71c230b2, Offset: 0x1528
    // Size: 0x9a
    function ai_puppet_release(restore) {
        if (isdefined(level.ai_puppet)) {
            if (restore) {
                level.ai_puppet.goalradius = level.ai_puppet.old_goalradius;
                level.ai_puppet.ispuppet = 0;
                level.ai_puppet clearentitytarget();
                level.ai_puppet.disabletargetservice = 0;
            }
            level.ai_puppet = undefined;
        }
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7837c6ec, Offset: 0x15d0
    // Size: 0x41e
    function ai_puppet_cursor_tracker() {
        level endon(#"kill ai puppeteer");
        self endon(#"death");
        while (true) {
            forward = anglestoforward(self getplayerangles());
            forward_vector = vectorscale(forward, 4000);
            physicsbox = (10, 10, 10);
            playereye = self getplayercamerapos();
            level.playercursor = physicstrace(playereye, playereye + forward_vector, -1 * physicsbox, physicsbox, self, 64 | 2);
            level.playercursorai = undefined;
            level.playercursornode = undefined;
            cursorcolor = (0, 1, 1);
            hitent = level.playercursor[#"entity"];
            if (!isdefined(hitent)) {
                bullettrace = bullettrace(playereye, playereye + forward_vector, 1, self);
                hitent = bullettrace[#"entity"];
            }
            if (isdefined(hitent) && (isai(hitent) || isbot(hitent) || isvehicle(hitent))) {
                cursorcolor = (1, 0, 0);
                if (isdefined(level.ai_puppet) && level.ai_puppet != hitent) {
                    if (!level.ai_puppet_highlighting) {
                        ai_puppeteer_render_ai(hitent, cursorcolor);
                    }
                }
                level.playercursorai = hitent;
            } else if (isdefined(level.ai_puppet)) {
                nodes = getanynodearray(level.playercursor[#"position"], 24);
                if (nodes.size > 0) {
                    node = nodes[0];
                    if (node.type != #"path" && distancesquared(node.origin, level.playercursor[#"position"]) < 576) {
                        if (!level.ai_puppet_highlighting) {
                            ai_puppeteer_render_node(node, (0, 1, 1));
                        }
                        level.playercursornode = node;
                    }
                }
            }
            if (!level.ai_puppet_highlighting) {
                ai_puppeteer_render_point(level.playercursor[#"position"], level.playercursor[#"normal"], forward, cursorcolor);
                if (isdefined(level.playercursorai)) {
                    box(level.playercursorai.origin, (-15, -15, 0), (15, 15, 60), level.playercursorai.angles[1], cursorcolor, 1, 0, 1);
                }
            }
            waitframe(1);
        }
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5af072a5, Offset: 0x19f8
    // Size: 0x67c
    function ai_puppeteer_create_hud() {
        ypos = 170;
        level.puppeteer_hud_select = newdebughudelem();
        level.puppeteer_hud_select.x = 0;
        level.puppeteer_hud_select.y = ypos;
        level.puppeteer_hud_select.fontscale = 1;
        level.puppeteer_hud_select.alignx = "<dev string:xd2>";
        level.puppeteer_hud_select.horzalign = "<dev string:xd2>";
        level.puppeteer_hud_select.color = (0, 0, 1);
        ypos += 20;
        level.puppeteer_hud_goto = newdebughudelem();
        level.puppeteer_hud_goto.x = 0;
        level.puppeteer_hud_goto.y = ypos;
        level.puppeteer_hud_goto.fontscale = 1;
        level.puppeteer_hud_goto.alignx = "<dev string:xd2>";
        level.puppeteer_hud_goto.horzalign = "<dev string:xd2>";
        level.puppeteer_hud_goto.color = (0, 1, 0);
        ypos += 20;
        level.var_d87fff95 = newdebughudelem();
        level.var_d87fff95.x = 0;
        level.var_d87fff95.y = ypos;
        level.var_d87fff95.fontscale = 1;
        level.var_d87fff95.alignx = "<dev string:xd2>";
        level.var_d87fff95.horzalign = "<dev string:xd2>";
        level.var_d87fff95.color = (0, 1, 1);
        ypos += 20;
        level.var_b6a95fbe = newdebughudelem();
        level.var_b6a95fbe.x = 0;
        level.var_b6a95fbe.y = ypos;
        level.var_b6a95fbe.fontscale = 1;
        level.var_b6a95fbe.alignx = "<dev string:xd2>";
        level.var_b6a95fbe.horzalign = "<dev string:xd2>";
        level.var_b6a95fbe.color = (1, 0, 0);
        ypos += 20;
        level.puppeteer_hud_shoot = newdebughudelem();
        level.puppeteer_hud_shoot.x = 0;
        level.puppeteer_hud_shoot.y = ypos;
        level.puppeteer_hud_shoot.fontscale = 1;
        level.puppeteer_hud_shoot.alignx = "<dev string:xd2>";
        level.puppeteer_hud_shoot.horzalign = "<dev string:xd2>";
        level.puppeteer_hud_shoot.color = (1, 0, 1);
        ypos += 20;
        level.puppeteer_hud_teleport = newdebughudelem();
        level.puppeteer_hud_teleport.x = 0;
        level.puppeteer_hud_teleport.y = ypos;
        level.puppeteer_hud_teleport.fontscale = 1;
        level.puppeteer_hud_teleport.alignx = "<dev string:xd2>";
        level.puppeteer_hud_teleport.horzalign = "<dev string:xd2>";
        level.puppeteer_hud_teleport.color = (1, 1, 0);
        ypos += 20;
        level.var_33b22db3 = newdebughudelem();
        level.var_33b22db3.x = 0;
        level.var_33b22db3.y = ypos;
        level.var_33b22db3.fontscale = 1;
        level.var_33b22db3.alignx = "<dev string:xd2>";
        level.var_33b22db3.horzalign = "<dev string:xd2>";
        level.var_33b22db3.color = (1, 1, 1);
        if (level.orbis) {
            level.puppeteer_hud_select settext("<dev string:xda>");
            level.puppeteer_hud_goto settext("<dev string:xed>");
            level.var_d87fff95 settext("<dev string:xf9>");
            level.var_b6a95fbe settext("<dev string:x11a>");
            level.puppeteer_hud_shoot settext("<dev string:x13a>");
            level.puppeteer_hud_teleport settext("<dev string:x157>");
            level.var_33b22db3 settext("<dev string:x171>");
            return;
        }
        level.puppeteer_hud_select settext("<dev string:x192>");
        level.puppeteer_hud_goto settext("<dev string:x1a0>");
        level.var_d87fff95 settext("<dev string:x1ac>");
        level.var_b6a95fbe settext("<dev string:x1c1>");
        level.puppeteer_hud_shoot settext("<dev string:x13a>");
        level.puppeteer_hud_teleport settext("<dev string:x1da>");
        level.var_33b22db3 settext("<dev string:x171>");
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbbde9957, Offset: 0x2080
    // Size: 0xac
    function ai_puppeteer_destroy_hud() {
        if (isdefined(level.puppeteer_hud_select)) {
            level.puppeteer_hud_select destroy();
        }
        if (isdefined(level.puppeteer_hud_lookat)) {
            level.puppeteer_hud_lookat destroy();
        }
        if (isdefined(level.puppeteer_hud_goto)) {
            level.puppeteer_hud_goto destroy();
        }
        if (isdefined(level.puppeteer_hud_shoot)) {
            level.puppeteer_hud_shoot destroy();
        }
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 4, eflags: 0x0
    // Checksum 0xc023af6c, Offset: 0x2138
    // Size: 0x154
    function ai_puppeteer_render_point(point, normal, forward, color) {
        surface_vector = vectorcross(forward, normal);
        surface_vector = vectornormalize(surface_vector);
        line(point, point + vectorscale(surface_vector, 5), color, 1, 1);
        line(point, point + vectorscale(surface_vector, -5), color, 1, 1);
        surface_vector = vectorcross(normal, surface_vector);
        surface_vector = vectornormalize(surface_vector);
        line(point, point + vectorscale(surface_vector, 5), color, 1, 1);
        line(point, point + vectorscale(surface_vector, -5), color, 1, 1);
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 2, eflags: 0x0
    // Checksum 0x403b8777, Offset: 0x2298
    // Size: 0x104
    function ai_puppeteer_render_node(node, color) {
        print3d(node.origin, node.type, color, 1, 0.35);
        box(node.origin, (-16, -16, 0), (16, 16, 16), node.angles[1], color, 1, 1);
        nodeforward = anglestoforward(node.angles);
        nodeforward = vectorscale(nodeforward, 8);
        line(node.origin, node.origin + nodeforward, color, 1, 1);
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 2, eflags: 0x0
    // Checksum 0xcc32546c, Offset: 0x23a8
    // Size: 0x17c
    function ai_puppeteer_render_ai(ai, color) {
        if (isdefined(ai) && isdefined(ai.goalpos)) {
            if (isusingnavvolume(ai)) {
                circle(ai.goalpos + (0, 0, ai.goalheight / 2), ai.goalradius, color, 0, 1);
                circle(ai.goalpos + (0, 0, ai.goalheight * -1 / 2), ai.goalradius, color, 0, 1);
            } else {
                circle(ai.goalpos + (0, 0, 1), ai.goalradius, color, 0, 1);
            }
            circle(ai.origin + (0, 0, 1), ai getpathfindingradius(), (1, 0, 0), 0, 1);
            line(ai.goalpos, ai.origin, color, 1, 1);
        }
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 4, eflags: 0x0
    // Checksum 0x784c2899, Offset: 0x2530
    // Size: 0xd4
    function ai_puppeteer_highlight_point(point, normal, forward, color) {
        level endon(#"kill ai puppeteer");
        self endon(#"death");
        level.ai_puppet_highlighting = 1;
        timer = 0;
        while (timer < 0.7) {
            ai_puppeteer_render_point(point, normal, forward, color);
            timer += 0.15;
            wait 0.15;
        }
        level.ai_puppet_highlighting = 0;
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5e16bc3d, Offset: 0x2610
    // Size: 0xbc
    function ai_puppeteer_highlight_node(node) {
        level endon(#"kill ai puppeteer");
        self endon(#"death");
        level.ai_puppet_highlighting = 1;
        timer = 0;
        while (timer < 0.7) {
            ai_puppeteer_render_node(node, (0, 1, 0));
            timer += 0.15;
            wait 0.15;
        }
        level.ai_puppet_highlighting = 0;
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 2, eflags: 0x0
    // Checksum 0xb1ebd83b, Offset: 0x26d8
    // Size: 0xcc
    function ai_puppeteer_highlight_ai(ai, color) {
        level endon(#"kill ai puppeteer");
        self endon(#"death");
        level.ai_puppet_highlighting = 1;
        timer = 0;
        while (timer < 0.7 && isdefined(ai)) {
            ai_puppeteer_render_ai(ai, color);
            timer += 0.15;
            wait 0.15;
        }
        level.ai_puppet_highlighting = 0;
    }

#/
