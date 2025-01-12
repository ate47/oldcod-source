#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/init;
#using scripts/core_common/array_shared;
#using scripts/core_common/colors_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;

#namespace ai_puppeteer;

// Namespace ai_puppeteer/ai_puppeteer_shared
// Params 0, eflags: 0x2
// Checksum 0x2fcb2b65, Offset: 0x1c8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("ai_puppeteer", &__init__, undefined, undefined);
}

// Namespace ai_puppeteer/ai_puppeteer_shared
// Params 0, eflags: 0x0
// Checksum 0xfaff6e06, Offset: 0x208
// Size: 0x1c
function __init__() {
    /#
        level thread ai_puppeteer_think();
    #/
}

/#

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0x22c80973, Offset: 0x230
    // Size: 0x13e
    function ai_puppeteer_think() {
        while (true) {
            if (!isdefined(level.ai_puppeteer_active) || getdvarstring("<dev string:x28>") == "<dev string:x3b>" && level.ai_puppeteer_active == 0) {
                level.ai_puppeteer_active = 1;
                level notify(#"hash_23dbb5b");
                adddebugcommand("<dev string:x3d>");
                thread ai_puppeteer();
            } else if (getdvarstring("<dev string:x28>") == "<dev string:x44>" && isdefined(level.ai_puppeteer_active) && level.ai_puppeteer_active == 1) {
                level.ai_puppeteer_active = 0;
                adddebugcommand("<dev string:x3d>");
                level notify(#"hash_23dbb5b");
            }
            waitframe(1);
        }
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0x94ada2b2, Offset: 0x378
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
        player val::set("<dev string:x46>", "<dev string:x53>", 1);
        level waittill("<dev string:x5c>");
        player val::reset("<dev string:x46>", "<dev string:x53>");
        ai_puppet_release(1);
        if (isdefined(level.ai_puppet_target)) {
            level.ai_puppet_target delete();
        }
        ai_puppeteer_destroy_hud();
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3838e8a2, Offset: 0x4e0
    // Size: 0xd82
    function ai_puppet_manager() {
        level endon(#"hash_23dbb5b");
        self endon(#"death");
        while (true) {
            if (isdefined(level.playercursor["<dev string:x6e>"]) && isdefined(level.ai_puppet) && isdefined(level.ai_puppet.debuglookatenabled) && level.ai_puppet.debuglookatenabled == 1) {
                level.ai_puppet lookatpos(level.playercursor["<dev string:x6e>"]);
            }
            if (self buttonpressed("<dev string:x77>") && self buttonpressed("<dev string:x85>")) {
                if (isdefined(level.ai_puppet)) {
                    level.ai_puppet forceteleport(level.playercursor["<dev string:x6e>"], level.ai_puppet.angles);
                }
                wait 0.2;
            } else if (self buttonpressed("<dev string:x77>")) {
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
                        level.ai_puppet_target = spawn("<dev string:x93>", level.playercursor["<dev string:x6e>"]);
                        level.ai_puppet_target_normal = level.playercursor["<dev string:xa0>"];
                        level.ai_puppet setentitytarget(level.ai_puppet_target);
                        self thread ai_puppeteer_highlight_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglestoforward(self getplayerangles()), (1, 0, 0));
                    }
                }
                wait 0.2;
            } else if (self buttonpressed("<dev string:xa7>")) {
                if (isdefined(level.ai_puppet)) {
                    if (isdefined(level.playercursorai) && level.playercursorai != level.ai_puppet) {
                        level.ai_puppet setgoal(level.playercursorai);
                        level.ai_puppet.goalradius = 64;
                        self thread ai_puppeteer_highlight_ai(level.playercursorai, (0, 1, 0));
                    } else if (isdefined(level.playercursornode)) {
                        level.ai_puppet setgoal(level.playercursornode);
                        self thread ai_puppeteer_highlight_node(level.playercursornode);
                    } else {
                        if (isdefined(level.ai_puppet.scriptenemy)) {
                            to_target = level.ai_puppet.scriptenemy.origin - level.ai_puppet.origin;
                        } else {
                            to_target = level.playercursor["<dev string:x6e>"] - level.ai_puppet.origin;
                        }
                        angles = vectortoangles(to_target);
                        level.ai_puppet setgoal(level.playercursor["<dev string:x6e>"]);
                        self thread ai_puppeteer_highlight_point(level.playercursor["<dev string:x6e>"], level.playercursor["<dev string:xa0>"], anglestoforward(self getplayerangles()), (0, 1, 0));
                    }
                }
                wait 0.2;
            } else if (self buttonpressed("<dev string:xb0>") && self buttonpressed("<dev string:xb9>")) {
                if (isdefined(level.ai_puppet)) {
                    if (isdefined(level.playercursorai) && level.playercursorai != level.ai_puppet) {
                        level.ai_puppet setgoal(level.playercursorai);
                        level.ai_puppet.goalradius = 64;
                        self thread ai_puppeteer_highlight_ai(level.playercursorai, (0, 1, 0));
                    } else if (isdefined(level.playercursornode)) {
                        level.ai_puppet setgoal(level.playercursornode, 1);
                        self thread ai_puppeteer_highlight_node(level.playercursornode);
                    } else {
                        if (isdefined(level.ai_puppet.scriptenemy)) {
                            to_target = level.ai_puppet.scriptenemy.origin - level.ai_puppet.origin;
                        } else {
                            to_target = level.playercursor["<dev string:x6e>"] - level.ai_puppet.origin;
                        }
                        angles = vectortoangles(to_target);
                        level.ai_puppet setgoal(level.playercursor["<dev string:x6e>"], 1);
                        self thread ai_puppeteer_highlight_point(level.playercursor["<dev string:x6e>"], level.playercursor["<dev string:xa0>"], anglestoforward(self getplayerangles()), (0, 1, 0));
                    }
                }
                wait 0.2;
            } else if (self buttonpressed("<dev string:xc2>")) {
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
            } else if (self buttonpressed("<dev string:xb9>")) {
                if (isdefined(level.ai_puppet)) {
                    level.ai_puppet clearforcedgoal();
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
                if (self buttonpressed("<dev string:xcb>")) {
                    level.ai_puppet.goalradius += 64;
                } else if (self buttonpressed("<dev string:xd3>")) {
                    radius = level.ai_puppet.goalradius - 64;
                    if (radius < 16) {
                        radius = 16;
                    }
                    level.ai_puppet.goalradius = radius;
                } else if (self buttonpressed("<dev string:xdd>")) {
                    level.ai_puppet.goalradius = 16;
                }
            }
            if (isdefined(level.ai_puppet)) {
                if (getdvarstring("<dev string:xe7>") == "<dev string:x3b>") {
                    level.ai_puppet.fixednode = 1;
                    ai_puppeteer_render_ai(level.ai_puppet, (1, 1, 1));
                } else {
                    level.ai_puppet.fixednode = 0;
                }
            }
            waitframe(1);
        }
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa384046, Offset: 0x1270
    // Size: 0x94
    function ai_puppet_set() {
        level.ai_puppet = level.playercursorai;
        level.ai_puppet.ispuppet = 1;
        level.ai_puppet.old_goalradius = level.ai_puppet.goalradius;
        level.ai_puppet.goalradius = 16;
        level.ai_puppet stopanimscripted();
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 1, eflags: 0x0
    // Checksum 0x17dca6e6, Offset: 0x1310
    // Size: 0x8e
    function ai_puppet_release(restore) {
        if (isdefined(level.ai_puppet)) {
            if (restore) {
                level.ai_puppet.goalradius = level.ai_puppet.old_goalradius;
                level.ai_puppet.ispuppet = 0;
                level.ai_puppet clearentitytarget();
            }
            level.ai_puppet = undefined;
        }
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2e855db5, Offset: 0x13a8
    // Size: 0x326
    function ai_puppet_cursor_tracker() {
        level endon(#"hash_23dbb5b");
        self endon(#"death");
        while (true) {
            forward = anglestoforward(self getplayerangles());
            forward_vector = vectorscale(forward, 4000);
            level.playercursor = physicstrace(self geteye(), self geteye() + forward_vector, (0, 0, 0), (0, 0, 0), self, 8);
            level.playercursorai = undefined;
            level.playercursornode = undefined;
            cursorcolor = (0, 1, 1);
            hitent = level.playercursor["<dev string:x104>"];
            if (isai(hitent) || isdefined(hitent) && hitent isbot()) {
                cursorcolor = (1, 0, 0);
                if (isdefined(level.ai_puppet) && level.ai_puppet != hitent) {
                    if (!level.ai_puppet_highlighting) {
                        ai_puppeteer_render_ai(hitent, cursorcolor);
                    }
                }
                level.playercursorai = hitent;
            } else if (isdefined(level.ai_puppet)) {
                nodes = getanynodearray(level.playercursor["<dev string:x6e>"], 24);
                if (nodes.size > 0) {
                    node = nodes[0];
                    if (node.type != "<dev string:x10b>" && distancesquared(node.origin, level.playercursor["<dev string:x6e>"]) < 576) {
                        if (!level.ai_puppet_highlighting) {
                            ai_puppeteer_render_node(node, (0, 1, 1));
                        }
                        level.playercursornode = node;
                    }
                }
            }
            if (!level.ai_puppet_highlighting) {
                ai_puppeteer_render_point(level.playercursor["<dev string:x6e>"], level.playercursor["<dev string:xa0>"], forward, cursorcolor);
            }
            waitframe(1);
        }
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc127a412, Offset: 0x16d8
    // Size: 0x46c
    function ai_puppeteer_create_hud() {
        /#
            level.puppeteer_hud_select = newdebughudelem();
            level.puppeteer_hud_select.x = 0;
            level.puppeteer_hud_select.y = 180;
            level.puppeteer_hud_select.fontscale = 1;
            level.puppeteer_hud_select.alignx = "<dev string:x110>";
            level.puppeteer_hud_select.horzalign = "<dev string:x110>";
            level.puppeteer_hud_select.color = (0, 0, 1);
            level.puppeteer_hud_goto = newdebughudelem();
            level.puppeteer_hud_goto.x = 0;
            level.puppeteer_hud_goto.y = 200;
            level.puppeteer_hud_goto.fontscale = 1;
            level.puppeteer_hud_goto.alignx = "<dev string:x110>";
            level.puppeteer_hud_goto.horzalign = "<dev string:x110>";
            level.puppeteer_hud_goto.color = (0, 1, 0);
            level.puppeteer_hud_lookat = newdebughudelem();
            level.puppeteer_hud_lookat.x = 0;
            level.puppeteer_hud_lookat.y = 220;
            level.puppeteer_hud_lookat.fontscale = 1;
            level.puppeteer_hud_lookat.alignx = "<dev string:x110>";
            level.puppeteer_hud_lookat.horzalign = "<dev string:x110>";
            level.puppeteer_hud_lookat.color = (0, 1, 1);
            level.puppeteer_hud_shoot = newdebughudelem();
            level.puppeteer_hud_shoot.x = 0;
            level.puppeteer_hud_shoot.y = 240;
            level.puppeteer_hud_shoot.fontscale = 1;
            level.puppeteer_hud_shoot.alignx = "<dev string:x110>";
            level.puppeteer_hud_shoot.horzalign = "<dev string:x110>";
            level.puppeteer_hud_shoot.color = (1, 1, 1);
            level.puppeteer_hud_teleport = newdebughudelem();
            level.puppeteer_hud_teleport.x = 0;
            level.puppeteer_hud_teleport.y = 260;
            level.puppeteer_hud_teleport.fontscale = 1;
            level.puppeteer_hud_teleport.alignx = "<dev string:x110>";
            level.puppeteer_hud_teleport.horzalign = "<dev string:x110>";
            level.puppeteer_hud_teleport.color = (1, 0, 0);
            level.puppeteer_hud_select settext("<dev string:x115>");
            level.puppeteer_hud_goto settext("<dev string:x13d>");
            level.puppeteer_hud_lookat settext("<dev string:x148>");
            level.puppeteer_hud_shoot settext("<dev string:x171>");
            level.puppeteer_hud_teleport settext("<dev string:x183>");
        #/
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 0, eflags: 0x0
    // Checksum 0x591f8e7, Offset: 0x1b50
    // Size: 0xc4
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
    // Checksum 0x78f788b2, Offset: 0x1c20
    // Size: 0x164
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
    // Checksum 0x4b3c41df, Offset: 0x1d90
    // Size: 0x124
    function ai_puppeteer_render_node(node, color) {
        print3d(node.origin, node.type, color, 1, 0.35);
        box(node.origin, (-16, -16, 0), (16, 16, 16), node.angles[1], color, 1, 1);
        nodeforward = anglestoforward(node.angles);
        nodeforward = vectorscale(nodeforward, 8);
        line(node.origin, node.origin + nodeforward, color, 1, 1);
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 2, eflags: 0x0
    // Checksum 0x5ad0a3ad, Offset: 0x1ec0
    // Size: 0xcc
    function ai_puppeteer_render_ai(ai, color) {
        circle(ai.goalpos + (0, 0, 1), ai.goalradius, color, 0, 1);
        circle(ai.origin + (0, 0, 1), ai getpathfindingradius(), (1, 0, 0), 0, 1);
        line(ai.goalpos, ai.origin, color, 1, 1);
    }

    // Namespace ai_puppeteer/ai_puppeteer_shared
    // Params 4, eflags: 0x0
    // Checksum 0xe2c24019, Offset: 0x1f98
    // Size: 0xd4
    function ai_puppeteer_highlight_point(point, normal, forward, color) {
        level endon(#"hash_23dbb5b");
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
    // Checksum 0x914597ae, Offset: 0x2078
    // Size: 0xb4
    function ai_puppeteer_highlight_node(node) {
        level endon(#"hash_23dbb5b");
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
    // Checksum 0x41d074e8, Offset: 0x2138
    // Size: 0xcc
    function ai_puppeteer_highlight_ai(ai, color) {
        level endon(#"hash_23dbb5b");
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
