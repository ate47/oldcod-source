#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_utility;

#namespace zm_zdraw;

/#

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x6
    // Checksum 0x39354a83, Offset: 0xb0
    // Size: 0x4c
    function private autoexec __init__system__() {
        system::register(#"zdraw", &function_70a657d8, &postinit, undefined, undefined);
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x4
    // Checksum 0x9c1c4ec4, Offset: 0x108
    // Size: 0x94
    function private function_70a657d8() {
        setdvar(#"zdraw", "<dev string:x38>");
        level.zdraw = spawnstruct();
        function_c9f70832();
        function_99bd35ec();
        function_b36498d3();
        level thread function_c78d9e67();
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x4
    // Checksum 0x7d9c1db0, Offset: 0x1a8
    // Size: 0x8
    function private postinit() {
        
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x0
    // Checksum 0xc65f2dea, Offset: 0x1b8
    // Size: 0x3d4
    function function_c9f70832() {
        level.zdraw.colors = [];
        level.zdraw.colors[#"red"] = (1, 0, 0);
        level.zdraw.colors[#"green"] = (0, 1, 0);
        level.zdraw.colors[#"blue"] = (0, 0, 1);
        level.zdraw.colors[#"yellow"] = (1, 1, 0);
        level.zdraw.colors[#"orange"] = (1, 0.5, 0);
        level.zdraw.colors[#"cyan"] = (0, 1, 1);
        level.zdraw.colors[#"purple"] = (1, 0, 1);
        level.zdraw.colors[#"black"] = (0, 0, 0);
        level.zdraw.colors[#"white"] = (1, 1, 1);
        level.zdraw.colors[#"grey"] = (0.75, 0.75, 0.75);
        level.zdraw.colors[#"gray1"] = (0.1, 0.1, 0.1);
        level.zdraw.colors[#"gray2"] = (0.2, 0.2, 0.2);
        level.zdraw.colors[#"gray3"] = (0.3, 0.3, 0.3);
        level.zdraw.colors[#"gray4"] = (0.4, 0.4, 0.4);
        level.zdraw.colors[#"gray5"] = (0.5, 0.5, 0.5);
        level.zdraw.colors[#"gray6"] = (0.6, 0.6, 0.6);
        level.zdraw.colors[#"gray7"] = (0.7, 0.7, 0.7);
        level.zdraw.colors[#"gray8"] = (0.8, 0.8, 0.8);
        level.zdraw.colors[#"gray9"] = (0.9, 0.9, 0.9);
        level.zdraw.colors[#"slate"] = (0.439216, 0.501961, 0.564706);
        level.zdraw.colors[#"pink"] = (1, 0.752941, 0.796078);
        level.zdraw.colors[#"olive"] = (0.501961, 0.501961, 0);
        level.zdraw.colors[#"brown"] = (0.545098, 0.270588, 0.0745098);
        level.zdraw.colors[#"default"] = (1, 1, 1);
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x0
    // Checksum 0xb7d3dfd2, Offset: 0x598
    // Size: 0x22c
    function function_99bd35ec() {
        level.zdraw.commands = [];
        level.zdraw.commands[#"color"] = &function_54389019;
        level.zdraw.commands[#"alpha"] = &function_82f2d020;
        level.zdraw.commands[#"duration"] = &function_cb18c560;
        level.zdraw.commands[#"seconds"] = &function_82201799;
        level.zdraw.commands[#"scale"] = &function_f7176625;
        level.zdraw.commands[#"radius"] = &function_a026f442;
        level.zdraw.commands[#"sides"] = &function_912c8db9;
        level.zdraw.commands[#"text"] = &function_b5cdeec6;
        level.zdraw.commands[#"star"] = &function_da7503f4;
        level.zdraw.commands[#"sphere"] = &function_3a2c5c6b;
        level.zdraw.commands[#"line"] = &function_25fd7d2a;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x0
    // Checksum 0xce82d459, Offset: 0x7d0
    // Size: 0xf2
    function function_b36498d3() {
        level.zdraw.color = level.zdraw.colors[#"default"];
        level.zdraw.alpha = 1;
        level.zdraw.scale = 1;
        level.zdraw.duration = int(1 * 62.5);
        level.zdraw.radius = 8;
        level.zdraw.sides = 10;
        level.zdraw.var_eeef5e89 = (0, 0, 0);
        level.zdraw.var_f78505a1 = 0;
        level.zdraw.var_d15c03f8 = "<dev string:x38>";
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x0
    // Checksum 0x82db5d9b, Offset: 0x8d0
    // Size: 0xf8
    function function_c78d9e67() {
        level notify(#"hash_79dc2eb04ee1da22");
        level endon(#"hash_79dc2eb04ee1da22");
        for (;;) {
            cmd = getdvarstring(#"zdraw");
            if (cmd.size) {
                function_b36498d3();
                params = strtok(cmd, "<dev string:x3c>");
                function_cd7ed6c5(params, 0, 1);
                setdvar(#"zdraw", "<dev string:x38>");
            }
            wait 0.5;
        }
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 3, eflags: 0x0
    // Checksum 0x1c76c7d6, Offset: 0x9d0
    // Size: 0xd4
    function function_cd7ed6c5(var_a99ac828, startat, toplevel) {
        if (!isdefined(toplevel)) {
            toplevel = 0;
        }
        while (isdefined(var_a99ac828[startat])) {
            if (isdefined(level.zdraw.commands[var_a99ac828[startat]])) {
                startat = [[ level.zdraw.commands[var_a99ac828[startat]] ]](var_a99ac828, startat + 1);
                continue;
            }
            if (is_true(toplevel)) {
                function_96c207f("<dev string:x43>" + var_a99ac828[startat]);
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xf887ca14, Offset: 0xab0
    // Size: 0x14a
    function function_3a2c5c6b(var_a99ac828, startat) {
        while (isdefined(var_a99ac828[startat])) {
            if (function_b0f457f2(var_a99ac828[startat])) {
                var_769ff4d7 = function_b59acc83(var_a99ac828, startat);
                if (var_769ff4d7 > startat) {
                    startat = var_769ff4d7;
                    center = level.zdraw.var_eeef5e89;
                    sphere(center, level.zdraw.radius, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.sides, level.zdraw.duration);
                    level.zdraw.var_eeef5e89 = (0, 0, 0);
                }
                continue;
            }
            var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xae40ca3f, Offset: 0xc08
    // Size: 0x11a
    function function_da7503f4(var_a99ac828, startat) {
        while (isdefined(var_a99ac828[startat])) {
            if (function_b0f457f2(var_a99ac828[startat])) {
                var_769ff4d7 = function_b59acc83(var_a99ac828, startat);
                if (var_769ff4d7 > startat) {
                    startat = var_769ff4d7;
                    center = level.zdraw.var_eeef5e89;
                    debugstar(center, level.zdraw.duration, level.zdraw.color);
                    level.zdraw.var_eeef5e89 = (0, 0, 0);
                }
                continue;
            }
            var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xab1ea1c6, Offset: 0xd30
    // Size: 0x17a
    function function_25fd7d2a(var_a99ac828, startat) {
        level.zdraw.linestart = undefined;
        while (isdefined(var_a99ac828[startat])) {
            if (function_b0f457f2(var_a99ac828[startat])) {
                var_769ff4d7 = function_b59acc83(var_a99ac828, startat);
                if (var_769ff4d7 > startat) {
                    startat = var_769ff4d7;
                    lineend = level.zdraw.var_eeef5e89;
                    if (isdefined(level.zdraw.linestart)) {
                        line(level.zdraw.linestart, lineend, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.duration);
                    }
                    level.zdraw.linestart = lineend;
                    level.zdraw.var_eeef5e89 = (0, 0, 0);
                }
                continue;
            }
            var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x9443f239, Offset: 0xeb8
    // Size: 0x1d2
    function function_b5cdeec6(var_a99ac828, startat) {
        level.zdraw.text = "<dev string:x38>";
        if (isdefined(var_a99ac828[startat])) {
            var_769ff4d7 = function_7bf700e4(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                level.zdraw.text = level.zdraw.var_d15c03f8;
                level.zdraw.var_d15c03f8 = "<dev string:x38>";
            }
        }
        while (isdefined(var_a99ac828[startat])) {
            if (function_b0f457f2(var_a99ac828[startat])) {
                var_769ff4d7 = function_b59acc83(var_a99ac828, startat);
                if (var_769ff4d7 > startat) {
                    startat = var_769ff4d7;
                    center = level.zdraw.var_eeef5e89;
                    print3d(center, level.zdraw.text, level.zdraw.color, level.zdraw.alpha, level.zdraw.scale, level.zdraw.duration);
                    level.zdraw.var_eeef5e89 = (0, 0, 0);
                }
                continue;
            }
            var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xedde99fd, Offset: 0x1098
    // Size: 0x158
    function function_54389019(var_a99ac828, startat) {
        if (isdefined(var_a99ac828[startat])) {
            if (function_b0f457f2(var_a99ac828[startat])) {
                var_769ff4d7 = function_b59acc83(var_a99ac828, startat);
                if (var_769ff4d7 > startat) {
                    startat = var_769ff4d7;
                    level.zdraw.color = level.zdraw.var_eeef5e89;
                    level.zdraw.var_eeef5e89 = (0, 0, 0);
                } else {
                    level.zdraw.color = (1, 1, 1);
                }
            } else {
                if (isdefined(level.zdraw.colors[var_a99ac828[startat]])) {
                    level.zdraw.color = level.zdraw.colors[var_a99ac828[startat]];
                } else {
                    level.zdraw.color = (1, 1, 1);
                    function_96c207f("<dev string:x5c>" + var_a99ac828[startat]);
                }
                startat += 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x88372f4a, Offset: 0x11f8
    // Size: 0xa8
    function function_82f2d020(var_a99ac828, startat) {
        if (isdefined(var_a99ac828[startat])) {
            var_769ff4d7 = revive_getdvar(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                level.zdraw.alpha = level.zdraw.var_f78505a1;
                level.zdraw.var_f78505a1 = 0;
            } else {
                level.zdraw.alpha = 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xd061bd84, Offset: 0x12a8
    // Size: 0xa8
    function function_f7176625(var_a99ac828, startat) {
        if (isdefined(var_a99ac828[startat])) {
            var_769ff4d7 = revive_getdvar(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                level.zdraw.scale = level.zdraw.var_f78505a1;
                level.zdraw.var_f78505a1 = 0;
            } else {
                level.zdraw.scale = 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xd1ff3176, Offset: 0x1358
    // Size: 0xd8
    function function_cb18c560(var_a99ac828, startat) {
        if (isdefined(var_a99ac828[startat])) {
            var_769ff4d7 = revive_getdvar(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                level.zdraw.duration = int(level.zdraw.var_f78505a1);
                level.zdraw.var_f78505a1 = 0;
            } else {
                level.zdraw.duration = int(1 * 62.5);
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x447b5809, Offset: 0x1438
    // Size: 0xe0
    function function_82201799(var_a99ac828, startat) {
        if (isdefined(var_a99ac828[startat])) {
            var_769ff4d7 = revive_getdvar(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                level.zdraw.duration = int(62.5 * level.zdraw.var_f78505a1);
                level.zdraw.var_f78505a1 = 0;
            } else {
                level.zdraw.duration = int(1 * 62.5);
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x1a4c54e9, Offset: 0x1520
    // Size: 0xa8
    function function_a026f442(var_a99ac828, startat) {
        if (isdefined(var_a99ac828[startat])) {
            var_769ff4d7 = revive_getdvar(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                level.zdraw.radius = level.zdraw.var_f78505a1;
                level.zdraw.var_f78505a1 = 0;
            } else {
                level.zdraw.radius = 8;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xf058b39e, Offset: 0x15d0
    // Size: 0xbc
    function function_912c8db9(var_a99ac828, startat) {
        if (isdefined(var_a99ac828[startat])) {
            var_769ff4d7 = revive_getdvar(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                level.zdraw.sides = int(level.zdraw.var_f78505a1);
                level.zdraw.var_f78505a1 = 0;
            } else {
                level.zdraw.sides = 10;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 1, eflags: 0x0
    // Checksum 0x8ed331c1, Offset: 0x1698
    // Size: 0x86
    function function_b0f457f2(param) {
        if (isdefined(param) && (isint(param) || isfloat(param) || isstring(param) && strisnumber(param))) {
            return 1;
        }
        return 0;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xbd9bc3a6, Offset: 0x1728
    // Size: 0x248
    function function_b59acc83(var_a99ac828, startat) {
        if (isdefined(var_a99ac828[startat])) {
            var_769ff4d7 = revive_getdvar(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                level.zdraw.var_eeef5e89 = (level.zdraw.var_f78505a1, level.zdraw.var_eeef5e89[1], level.zdraw.var_eeef5e89[2]);
                level.zdraw.var_f78505a1 = 0;
            } else {
                function_96c207f("<dev string:x73>");
                return startat;
            }
            var_769ff4d7 = revive_getdvar(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                level.zdraw.var_eeef5e89 = (level.zdraw.var_eeef5e89[0], level.zdraw.var_f78505a1, level.zdraw.var_eeef5e89[2]);
                level.zdraw.var_f78505a1 = 0;
            } else {
                function_96c207f("<dev string:x73>");
                return startat;
            }
            var_769ff4d7 = revive_getdvar(var_a99ac828, startat);
            if (var_769ff4d7 > startat) {
                startat = var_769ff4d7;
                level.zdraw.var_eeef5e89 = (level.zdraw.var_eeef5e89[0], level.zdraw.var_eeef5e89[1], level.zdraw.var_f78505a1);
                level.zdraw.var_f78505a1 = 0;
            } else {
                function_96c207f("<dev string:x73>");
                return startat;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x710b7701, Offset: 0x1978
    // Size: 0x76
    function revive_getdvar(var_a99ac828, startat) {
        if (isdefined(var_a99ac828[startat])) {
            if (function_b0f457f2(var_a99ac828[startat])) {
                level.zdraw.var_f78505a1 = float(var_a99ac828[startat]);
                startat += 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xcd5633b9, Offset: 0x19f8
    // Size: 0x4e
    function function_7bf700e4(var_a99ac828, startat) {
        if (isdefined(var_a99ac828[startat])) {
            level.zdraw.var_d15c03f8 = var_a99ac828[startat];
            startat += 1;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 1, eflags: 0x0
    // Checksum 0x249957e4, Offset: 0x1a50
    // Size: 0x34
    function function_96c207f(msg) {
        println("<dev string:x99>" + msg);
    }

#/
