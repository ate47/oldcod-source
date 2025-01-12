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
    // Params 0, eflags: 0x2
    // Checksum 0x2472646c, Offset: 0xb8
    // Size: 0x4c
    function autoexec __init__system__() {
        system::register(#"zdraw", &__init__, &__main__, undefined);
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x0
    // Checksum 0x8c223912, Offset: 0x110
    // Size: 0x9c
    function __init__() {
        setdvar(#"zdraw", "<dev string:x30>");
        level.zdraw = spawnstruct();
        function_3e630288();
        function_aa8545fe();
        function_404ac348();
        level thread function_41fec76e();
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x0
    // Checksum 0x1fb46bf6, Offset: 0x1b8
    // Size: 0x8
    function __main__() {
        
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x0
    // Checksum 0xe9844b5e, Offset: 0x1c8
    // Size: 0x46e
    function function_3e630288() {
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
    // Checksum 0x9f02fe31, Offset: 0x640
    // Size: 0x22e
    function function_aa8545fe() {
        level.zdraw.commands = [];
        level.zdraw.commands[#"color"] = &function_5ef6cf9b;
        level.zdraw.commands[#"alpha"] = &function_eae4114a;
        level.zdraw.commands[#"duration"] = &function_f2f3c18e;
        level.zdraw.commands[#"seconds"] = &function_8f04ad79;
        level.zdraw.commands[#"scale"] = &function_a13efe1c;
        level.zdraw.commands[#"radius"] = &function_b3b92edc;
        level.zdraw.commands[#"sides"] = &function_8c2ca616;
        level.zdraw.commands[#"text"] = &function_3145e33f;
        level.zdraw.commands[#"star"] = &function_f36ec3d2;
        level.zdraw.commands[#"sphere"] = &function_7bdd3089;
        level.zdraw.commands[#"line"] = &function_be7cf134;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x0
    // Checksum 0xd62e57c1, Offset: 0x878
    // Size: 0xf2
    function function_404ac348() {
        level.zdraw.color = level.zdraw.colors[#"default"];
        level.zdraw.alpha = 1;
        level.zdraw.scale = 1;
        level.zdraw.duration = int(1 * 62.5);
        level.zdraw.radius = 8;
        level.zdraw.sides = 10;
        level.zdraw.var_5f3c7817 = (0, 0, 0);
        level.zdraw.var_922ae5d = 0;
        level.zdraw.var_c1953771 = "<dev string:x30>";
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 0, eflags: 0x0
    // Checksum 0x5356afb5, Offset: 0x978
    // Size: 0xf8
    function function_41fec76e() {
        level notify(#"hash_79dc2eb04ee1da22");
        level endon(#"hash_79dc2eb04ee1da22");
        for (;;) {
            cmd = getdvarstring(#"zdraw");
            if (cmd.size) {
                function_404ac348();
                params = strtok(cmd, "<dev string:x31>");
                function_4282fd75(params, 0, 1);
                setdvar(#"zdraw", "<dev string:x30>");
            }
            wait 0.5;
        }
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 3, eflags: 0x0
    // Checksum 0x81970415, Offset: 0xa78
    // Size: 0xdc
    function function_4282fd75(var_859cfb21, startat, toplevel) {
        if (!isdefined(toplevel)) {
            toplevel = 0;
        }
        while (isdefined(var_859cfb21[startat])) {
            if (isdefined(level.zdraw.commands[var_859cfb21[startat]])) {
                startat = [[ level.zdraw.commands[var_859cfb21[startat]] ]](var_859cfb21, startat + 1);
                continue;
            }
            if (isdefined(toplevel) && toplevel) {
                function_c69caf7e("<dev string:x35>" + var_859cfb21[startat]);
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xeacdea8a, Offset: 0xb60
    // Size: 0x15e
    function function_7bdd3089(var_859cfb21, startat) {
        while (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                var_b78d9698 = function_36371547(var_859cfb21, startat);
                if (var_b78d9698 > startat) {
                    startat = var_b78d9698;
                    center = level.zdraw.var_5f3c7817;
                    sphere(center, level.zdraw.radius, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.sides, level.zdraw.duration);
                    level.zdraw.var_5f3c7817 = (0, 0, 0);
                }
                continue;
            }
            var_b78d9698 = function_4282fd75(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x71670f36, Offset: 0xcc8
    // Size: 0x126
    function function_f36ec3d2(var_859cfb21, startat) {
        while (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                var_b78d9698 = function_36371547(var_859cfb21, startat);
                if (var_b78d9698 > startat) {
                    startat = var_b78d9698;
                    center = level.zdraw.var_5f3c7817;
                    debugstar(center, level.zdraw.duration, level.zdraw.color);
                    level.zdraw.var_5f3c7817 = (0, 0, 0);
                }
                continue;
            }
            var_b78d9698 = function_4282fd75(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x314bb158, Offset: 0xdf8
    // Size: 0x186
    function function_be7cf134(var_859cfb21, startat) {
        level.zdraw.linestart = undefined;
        while (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                var_b78d9698 = function_36371547(var_859cfb21, startat);
                if (var_b78d9698 > startat) {
                    startat = var_b78d9698;
                    lineend = level.zdraw.var_5f3c7817;
                    if (isdefined(level.zdraw.linestart)) {
                        line(level.zdraw.linestart, lineend, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.duration);
                    }
                    level.zdraw.linestart = lineend;
                    level.zdraw.var_5f3c7817 = (0, 0, 0);
                }
                continue;
            }
            var_b78d9698 = function_4282fd75(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x69e92a00, Offset: 0xf88
    // Size: 0x1de
    function function_3145e33f(var_859cfb21, startat) {
        level.zdraw.text = "<dev string:x30>";
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_ce50bae5(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.text = level.zdraw.var_c1953771;
                level.zdraw.var_c1953771 = "<dev string:x30>";
            }
        }
        while (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                var_b78d9698 = function_36371547(var_859cfb21, startat);
                if (var_b78d9698 > startat) {
                    startat = var_b78d9698;
                    center = level.zdraw.var_5f3c7817;
                    print3d(center, level.zdraw.text, level.zdraw.color, level.zdraw.alpha, level.zdraw.scale, level.zdraw.duration);
                    level.zdraw.var_5f3c7817 = (0, 0, 0);
                }
                continue;
            }
            var_b78d9698 = function_4282fd75(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x5e81063d, Offset: 0x1170
    // Size: 0x170
    function function_5ef6cf9b(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                var_b78d9698 = function_36371547(var_859cfb21, startat);
                if (var_b78d9698 > startat) {
                    startat = var_b78d9698;
                    level.zdraw.color = level.zdraw.var_5f3c7817;
                    level.zdraw.var_5f3c7817 = (0, 0, 0);
                } else {
                    level.zdraw.color = (1, 1, 1);
                }
            } else {
                if (isdefined(level.zdraw.colors[var_859cfb21[startat]])) {
                    level.zdraw.color = level.zdraw.colors[var_859cfb21[startat]];
                } else {
                    level.zdraw.color = (1, 1, 1);
                    function_c69caf7e("<dev string:x4b>" + var_859cfb21[startat]);
                }
                startat += 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xda44406e, Offset: 0x12e8
    // Size: 0xb4
    function function_eae4114a(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.alpha = level.zdraw.var_922ae5d;
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.alpha = 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x33f2243a, Offset: 0x13a8
    // Size: 0xb4
    function function_a13efe1c(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.scale = level.zdraw.var_922ae5d;
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.scale = 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xd936f084, Offset: 0x1468
    // Size: 0xe0
    function function_f2f3c18e(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.duration = int(level.zdraw.var_922ae5d);
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.duration = int(1 * 62.5);
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xe00b8ae9, Offset: 0x1550
    // Size: 0xe8
    function function_8f04ad79(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.duration = int(62.5 * level.zdraw.var_922ae5d);
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.duration = int(1 * 62.5);
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x8e14d369, Offset: 0x1640
    // Size: 0xb4
    function function_b3b92edc(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.radius = level.zdraw.var_922ae5d;
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.radius = 8;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0xb37b170b, Offset: 0x1700
    // Size: 0xc4
    function function_8c2ca616(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.sides = int(level.zdraw.var_922ae5d);
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.sides = 10;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 1, eflags: 0x0
    // Checksum 0x8c09035e, Offset: 0x17d0
    // Size: 0x86
    function function_c0fb9425(param) {
        if (isdefined(param) && (isint(param) || isfloat(param) || isstring(param) && strisnumber(param))) {
            return 1;
        }
        return 0;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x7fa61d3c, Offset: 0x1860
    // Size: 0x258
    function function_36371547(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.var_5f3c7817 = (level.zdraw.var_922ae5d, level.zdraw.var_5f3c7817[1], level.zdraw.var_5f3c7817[2]);
                level.zdraw.var_922ae5d = 0;
            } else {
                function_c69caf7e("<dev string:x5f>");
                return startat;
            }
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.var_5f3c7817 = (level.zdraw.var_5f3c7817[0], level.zdraw.var_922ae5d, level.zdraw.var_5f3c7817[2]);
                level.zdraw.var_922ae5d = 0;
            } else {
                function_c69caf7e("<dev string:x5f>");
                return startat;
            }
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.var_5f3c7817 = (level.zdraw.var_5f3c7817[0], level.zdraw.var_5f3c7817[1], level.zdraw.var_922ae5d);
                level.zdraw.var_922ae5d = 0;
            } else {
                function_c69caf7e("<dev string:x5f>");
                return startat;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x49a7aac2, Offset: 0x1ac0
    // Size: 0x86
    function function_33acda19(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                level.zdraw.var_922ae5d = float(var_859cfb21[startat]);
                startat += 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 2, eflags: 0x0
    // Checksum 0x3c6f097, Offset: 0x1b50
    // Size: 0x56
    function function_ce50bae5(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            level.zdraw.var_c1953771 = var_859cfb21[startat];
            startat += 1;
        }
        return startat;
    }

    // Namespace zm_zdraw/zm_zdraw
    // Params 1, eflags: 0x0
    // Checksum 0x22de9d69, Offset: 0x1bb0
    // Size: 0x34
    function function_c69caf7e(msg) {
        println("<dev string:x82>" + msg);
    }

#/
