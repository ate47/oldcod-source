#using script_69514c4c056c768;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\load_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace wz_russia;

// Namespace wz_russia/level_init
// Params 1, eflags: 0x40
// Checksum 0x7a60f3e, Offset: 0xa8
// Size: 0x20c
function event_handler[level_init] main(*eventstruct) {
    /#
        callback::on_vehicle_spawned(&debug_vehicle_spawn);
    #/
    load::main();
    /#
        level thread function_9cc59537();
        level thread function_7d81ab95();
    #/
    compass::setupminimap("");
    gametype = util::get_game_type();
    if (gametype == #"hash_3f4933426b864c8b") {
        level thread namespace_3d2704b3::start(array(4, 3, 3, 3), 20, array(60, 45, 20));
        level thread namespace_3d2704b3::start_vehicle(array(#"hash_3f1846088e98d9e3"), array(0, 1, 1, 1), 10, array(40, 30, 15));
    } else if (gametype == #"hash_5c983bd7bec0e36c") {
        level thread namespace_3d2704b3::start(3, 15, array(20, 20, 20));
    }
    if (gametype == #"survival") {
        setclearanceceiling(36);
    }
}

/#

    // Namespace wz_russia/wz_russia
    // Params 0, eflags: 0x0
    // Checksum 0x2447b797, Offset: 0x2c0
    // Size: 0x14be
    function function_9cc59537() {
        str_gametype = getdvarstring(#"g_gametype");
        if (!getdvarint(#"hash_68dcd0d52e11b957", 0)) {
            return;
        }
        var_55a05f87 = 0;
        var_cbc7aaf6 = 0;
        var_ebd66b56 = [];
        var_1d9375fc = struct::get_array("<dev string:x38>", "<dev string:x56>");
        foreach (group in var_1d9375fc) {
            group.debug_spawnpoints = [];
            var_f0179f4a = getdvarstring(#"hash_230734aeaaf8671", "<dev string:x63>");
            if (isstring(group.target) && (var_f0179f4a == "<dev string:x63>" || function_d72aa67e(var_f0179f4a, group.target))) {
                group.debug_spawnpoints = function_91b29d2a(group.target);
            }
        }
        var_7cb887a8 = [];
        level flag::wait_till("<dev string:x6a>");
        level.players[0] endon(#"disconnect");
        adddebugcommand("<dev string:x82>");
        do {
            waitframe(8);
            foreach (group in var_1d9375fc) {
                var_b91441dd = getscriptbundle(group.scriptbundlename);
                if (!isdefined(var_b91441dd) || is_true(var_b91441dd.vehiclespawner) || group.debug_spawnpoints.size == 0 || var_b91441dd.name === "<dev string:x8c>" || var_b91441dd.name === "<dev string:xaa>" || var_b91441dd.name === "<dev string:xce>") {
                    continue;
                } else if (var_b91441dd.name === "<dev string:xef>") {
                    var_df1e5fef = arraysortclosest(group.debug_spawnpoints, level.players[0].origin, 85, 1, getdvarint(#"hash_6ac8a75bc45c3633", 10000));
                    foreach (point in var_df1e5fef) {
                        sphere(point.origin, 16, (1, 1, 1), 1, 0, 16, 8);
                    }
                    continue;
                }
                spawn_points = arraysortclosest(group.debug_spawnpoints, level.players[0].origin, 85, 1, getdvarint(#"hash_6ac8a75bc45c3633", 10000));
                foreach (point in spawn_points) {
                    if (getdvarint(#"hash_7ae201bf5aee2017", 0)) {
                        var_4b82457c = distance2d(point.origin, level.players[0].origin);
                        n_radius = getdvarfloat(#"hash_69e2c57538bbcb9b", 0.015) * var_4b82457c;
                        if (n_radius > 128) {
                            n_radius = 128;
                        }
                        switch (var_b91441dd.name) {
                        case #"hash_102716229ce6474b":
                            color = (1, 1, 0);
                            break;
                        case #"hash_102715229ce64598":
                            color = (1, 0, 1);
                            break;
                        default:
                            color = (0, 1, 0);
                            break;
                        }
                        sphere(point.origin, n_radius, color, 1, 0, 16, 8);
                        continue;
                    }
                    if (level.players[0] util::is_player_looking_at(point.origin, 0.6, 0)) {
                        b_failed = 0;
                        var_47748885 = 28;
                        var_c5330f11 = 32;
                        v_color = (1, 0, 1);
                        if (isdefined(var_b91441dd.itemlist[0])) {
                            if (var_b91441dd.itemlist[0].var_a6762160 === "<dev string:x10e>" || var_b91441dd.itemlist[0].var_a6762160 === "<dev string:x125>" || var_b91441dd.itemlist[0].var_a6762160 === "<dev string:x132>" || var_b91441dd.itemlist[0].var_a6762160 === "<dev string:x13f>" || var_b91441dd.itemlist[0].var_a6762160 === "<dev string:x14c>" || var_b91441dd.itemlist[0].var_a6762160 === "<dev string:x159>") {
                                v_color = (1, 1, 0);
                                var_47748885 = 4;
                                var_c5330f11 = 4;
                            }
                        }
                        items = item_world::function_2e3efdda(point.origin, undefined, 1, var_47748885, -1, 1);
                        if (items.size > 0) {
                            v_color = (0, 1, 0);
                        }
                        n_radius = 4;
                        var_7cb887a8 = [];
                        var_3e832e74 = 360 / 8;
                        v_angles = point.angles;
                        var_c24ea284 = undefined;
                        var_4b82457c = distance2d(point.origin, level.players[0].origin);
                        var_24b0b1ea = var_b91441dd.var_7fb0967b;
                        if (isdefined(var_24b0b1ea)) {
                            if (items.size > 0) {
                                var_abc7e003 = item_world::function_2e3efdda(point.origin, undefined, 20, var_24b0b1ea, -1, 1);
                                var_abc7e003 = arraysortclosest(var_abc7e003, point.origin, 10, var_47748885);
                                foreach (item_type in var_b91441dd.itemlist) {
                                    foreach (var_d76a7255 in var_abc7e003) {
                                        if (item_type.var_a6762160 === var_d76a7255.var_a6762160.name && var_d76a7255.var_a6762160.name === items[0].var_a6762160.name) {
                                            print3d(point.origin + (0, 0, 18), item_type.var_a6762160 + "<dev string:x166>" + var_24b0b1ea, (1, 0.5, 0), 1, 0.3, 8);
                                            line(var_d76a7255.origin, point.origin, (1, 0.5, 0), 1, 0, 8);
                                        }
                                    }
                                }
                            }
                        }
                        if (is_true(var_b91441dd.supplystash)) {
                            n_depth = 18;
                            n_width = 24;
                            if (var_b91441dd.name === "<dev string:x8c>" || var_b91441dd.name === "<dev string:xaa>" || var_b91441dd.name === "<dev string:xce>") {
                                n_depth = 12;
                                n_width = 48;
                            }
                            var_7cb887a8[0] = point.origin + (0, 0, 16) + vectorscale(anglestoforward(v_angles), n_depth);
                            var_7cb887a8[1] = point.origin + (0, 0, 16) + vectorscale(anglestoforward(v_angles) * -1, n_depth);
                            var_7cb887a8[2] = point.origin + (0, 0, 16) + vectorscale(anglestoright(v_angles), n_width);
                            var_7cb887a8[3] = point.origin + (0, 0, 16) + vectorscale(anglestoright(v_angles) * -1, n_width);
                        } else {
                            for (i = 0; i < 8; i++) {
                                var_7cb887a8[i] = point.origin + (0, 0, 16) + vectorscale(anglestoforward(v_angles), var_47748885);
                                v_angles += (0, var_3e832e74, 0);
                            }
                        }
                        var_2e0e7774 = arraysortclosest(spawn_points, point.origin, 20, 1, var_c5330f11);
                        foreach (close in var_2e0e7774) {
                            if (bullettracepassed(point.origin + (0, 0, 16), close.origin, 0, level.players[0])) {
                                v_color = (0, 0, 1);
                                b_failed = 1;
                                line(close.origin, point.origin, v_color, 1, 0, 8);
                                circle(point.origin, var_c5330f11 / 2, v_color, 0, 1, 8);
                                print3d(point.origin + (0, 0, 24), sqrt(distancesquared(point.origin, close.origin)), v_color, 1, 0.3, 8);
                            }
                        }
                        if (is_true(var_b91441dd.supplystash)) {
                            var_47748885 = n_depth;
                            foreach (i, v_test in var_7cb887a8) {
                                if (i > 2) {
                                    var_47748885 = n_width;
                                }
                                a_trace = bullettrace(point.origin + (0, 0, 24), v_test, 0, level.players[0]);
                                if (distancesquared(a_trace[#"position"], point.origin + (0, 0, 24)) < var_47748885 * var_47748885 - 2 && !isdefined(a_trace[#"dynent"])) {
                                    v_color = (1, 0, 0);
                                    b_failed = 1;
                                    if (var_4b82457c < 256) {
                                        debugstar(a_trace[#"position"], 8, v_color);
                                    }
                                }
                            }
                            var_47748885 = 18;
                        } else {
                            foreach (v_test in var_7cb887a8) {
                                a_trace = bullettrace(point.origin + (0, 0, 16), v_test, 0, level.players[0]);
                                if (distancesquared(a_trace[#"position"], point.origin + (0, 0, 16)) < var_47748885 * var_47748885 - 3 && !isdefined(a_trace[#"dynent"])) {
                                    v_color = (1, 0, 0);
                                    b_failed = 1;
                                    if (var_4b82457c < 256) {
                                        debugstar(a_trace[#"position"], 8, v_color);
                                    }
                                }
                            }
                        }
                        if (true) {
                            n_radius = getdvarfloat(#"hash_69e2c57538bbcb9b", 0.015) * var_4b82457c;
                            if (n_radius > 32) {
                                n_radius = 32;
                            }
                        }
                        if (is_true(var_b91441dd.supplystash)) {
                            function_47351fa3(point.origin, point.angles, v_color, 8);
                        }
                        if (var_4b82457c > 212) {
                            sphere(point.origin, n_radius, v_color, 1, 0, 8, 8);
                        }
                        if (bullettracepassed(point.origin, level.players[0] geteye(), 0, level.players[0], var_c24ea284)) {
                            if (distancesquared(point.origin, level.players[0].origin) < 1000 * 1000) {
                                circle(point.origin, var_47748885, v_color, 0, 1, 8);
                            }
                            if (var_4b82457c < 512) {
                                print3d(point.origin, function_9e72a96(point.targetname), v_color, 1, 0.4, 8);
                                if (var_4b82457c < 256 && level.players[0] util::is_player_looking_at(point.origin, 0.87, 0)) {
                                    print3d(point.origin + (0, 0, 12), point.origin, v_color, 1, 0.3, 8);
                                }
                            }
                        }
                    }
                }
            }
        } while (getdvarint(#"hash_68dcd0d52e11b957", 0));
    }

    // Namespace wz_russia/wz_russia
    // Params 0, eflags: 0x0
    // Checksum 0xccdcf637, Offset: 0x1788
    // Size: 0xa66
    function function_7d81ab95() {
        if (!getdvarint(#"hash_e261a7df432e0bf", 0)) {
            return;
        }
        level flag::wait_till("<dev string:x6a>");
        level.players[0] endon(#"disconnect");
        do {
            waitframe(8);
            chests = struct::get_array("<dev string:x188>", "<dev string:x197>");
            chests = arraysortclosest(chests, level.players[0].origin, 85, 1, getdvarint(#"hash_6ac8a75bc45c3633", 10000));
            foreach (point in chests) {
                v_angles = point.angles;
                n_depth = 18 / 2;
                n_width = 24 / 2;
                var_47748885 = n_depth;
                var_3e832e74 = 360 / 8;
                var_4b82457c = distance2d(point.origin, level.players[0].origin);
                v_color = (0, 1, 0);
                if (!isdefined(point) || !level.players[0] util::is_player_looking_at(point.origin, 0.6, 0)) {
                    continue;
                }
                if (isdefined(point)) {
                    var_7cb887a8[0] = point.origin + (0, 0, 2) + vectorscale(anglestoforward(v_angles), n_depth);
                    var_7cb887a8[1] = point.origin + (0, 0, 2) + vectorscale(anglestoforward(v_angles) * -1, n_depth);
                    var_7cb887a8[2] = point.origin + (0, 0, 2) + vectorscale(anglestoright(v_angles), n_width);
                    var_7cb887a8[3] = point.origin + (0, 0, 2) + vectorscale(anglestoright(v_angles) * -1, n_width);
                    var_7cb887a8[4] = point.origin + (0, 0, 0) + vectorscale(anglestoup(v_angles) * -1, 10000);
                } else {
                    for (i = 0; i < 8; i++) {
                        var_7cb887a8[i] = point.origin + (0, 0, 2) + vectorscale(anglestoforward(v_angles), var_47748885);
                        v_angles += (0, var_3e832e74, 0);
                    }
                }
                if (isdefined(point)) {
                    var_47748885 = n_depth;
                    foreach (i, v_test in var_7cb887a8) {
                        if (i > 2 && i < 4) {
                            var_47748885 = n_width;
                        }
                        a_trace = bullettrace(point.origin + (0, 0, 2), v_test, 0, point);
                        dist = distancesquared(a_trace[#"position"], point.origin + (0, 0, 0));
                        clear = var_47748885 * var_47748885;
                        if (i == 4) {
                            var_47748885 = 2;
                            clear = var_47748885 * var_47748885;
                            if (dist > clear && !isdefined(a_trace[#"dynent"])) {
                                v_color = (1, 0, 0);
                                b_failed = 1;
                                if (var_4b82457c < 256) {
                                    debugstar(a_trace[#"position"], 8, v_color);
                                }
                            }
                            continue;
                        }
                        if (dist < clear && !isdefined(a_trace[#"dynent"])) {
                            v_color = (1, 0, 0);
                            b_failed = 1;
                            if (var_4b82457c < 256) {
                                debugstar(a_trace[#"position"], 8, v_color);
                            }
                        }
                    }
                    var_47748885 = 18;
                } else {
                    foreach (v_test in var_7cb887a8) {
                        a_trace = bullettrace(point.origin + (0, 0, 2), v_test, 0, level.players[0]);
                        if (distancesquared(a_trace[#"position"], point.origin + (0, 0, 2)) < var_47748885 * var_47748885 - 3 && !isdefined(a_trace[#"dynent"])) {
                            v_color = (1, 0, 0);
                            b_failed = 1;
                            if (var_4b82457c < 256) {
                                debugstar(a_trace[#"position"], 8, v_color);
                            }
                        }
                    }
                }
                if (true) {
                    n_radius = 0.04 * var_4b82457c;
                    if (n_radius > 32) {
                        n_radius = 32;
                    }
                }
                if (isdefined(point)) {
                    function_47351fa3(point.origin, point.angles, v_color, 8);
                }
                if (var_4b82457c > 212) {
                    sphere(point.origin, n_radius, v_color, 1, 0, 8, 8);
                }
                if (bullettracepassed(point.origin, level.players[0] geteye(), 0, level.players[0])) {
                    if (distancesquared(point.origin, level.players[0].origin) < 1000 * 1000) {
                        circle(point.origin, var_47748885, v_color, 0, 1, 8);
                    }
                    if (var_4b82457c < 512) {
                        print3d(point.origin, "<dev string:x188>", v_color, 1, 0.4, 8);
                        if (var_4b82457c < 256 && level.players[0] util::is_player_looking_at(point.origin, 0.87, 0)) {
                            print3d(point.origin + (0, 0, 12), point.origin, v_color, 1, 0.3, 8);
                        }
                    }
                }
            }
        } while (getdvarint(#"hash_e261a7df432e0bf", 0));
    }

    // Namespace wz_russia/wz_russia
    // Params 2, eflags: 0x0
    // Checksum 0x513a4d38, Offset: 0x21f8
    // Size: 0xbe
    function function_d72aa67e(str_list, str_name) {
        a_str_tok = strtok(str_list, "<dev string:x1a6>");
        foreach (tok in a_str_tok) {
            if (tok == str_name) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace wz_russia/wz_russia
    // Params 4, eflags: 0x0
    // Checksum 0x538a9f22, Offset: 0x22c0
    // Size: 0x314
    function function_47351fa3(org, ang, opcolor, frames) {
        if (!isdefined(frames)) {
            frames = 1;
        }
        forward = anglestoforward(ang);
        forwardfar = vectorscale(forward, 50);
        forwardclose = vectorscale(forward, 50 * 0.8);
        right = anglestoright(ang);
        left = anglestoright(ang) * -1;
        leftdraw = vectorscale(right, 50 * -0.2);
        rightdraw = vectorscale(right, 50 * 0.2);
        up = anglestoup(ang);
        right = vectorscale(right, 50);
        left = vectorscale(left, 50);
        up = vectorscale(up, 50);
        red = (0.9, 0.2, 0.2);
        green = (0.2, 0.9, 0.2);
        blue = (0.2, 0.2, 0.9);
        if (isdefined(opcolor)) {
            red = opcolor;
            green = opcolor;
            blue = opcolor;
        }
        line(org, org + forwardfar, red, 0.9, 0, frames);
        line(org + forwardfar, org + forwardclose + rightdraw, red, 0.9, 0, frames);
        line(org + forwardfar, org + forwardclose + leftdraw, red, 0.9, 0, frames);
        line(org, org + right, blue, 0.9, 0, frames);
        line(org, org + left, blue, 0.9, 0, frames);
        line(org, org + up, green, 0.9, 0, frames);
    }

    // Namespace wz_russia/wz_russia
    // Params 1, eflags: 0x0
    // Checksum 0x9f880487, Offset: 0x25e0
    // Size: 0x20e
    function function_5ef515a6(var_1d9375fc) {
        n_total = 0;
        foreach (group in var_1d9375fc) {
            n_total += group.debug_spawnpoints.size;
        }
        while (getdvarint(#"hash_4701ef1aeafb2f3", 0)) {
            var_bd9acc19 = 50;
            foreach (group in var_1d9375fc) {
                if (isstring(group.target)) {
                    var_bd9acc19 += 24;
                    debug2dtext((1300, var_bd9acc19, 0), group.target + "<dev string:x1ab>" + group.debug_spawnpoints.size, (1, 1, 1), 1, (0, 0, 0), 0.75);
                }
            }
            debug2dtext((1300, 50, 0), "<dev string:x1b1>" + n_total, (1, 1, 1));
            waitframe(1);
        }
    }

    // Namespace wz_russia/wz_russia
    // Params 7, eflags: 0x0
    // Checksum 0xbcf99cb4, Offset: 0x27f8
    // Size: 0x5ae
    function function_317da0a9(var_1d9375fc, group, point, var_9b62e326, var_cc2e4f94, n_z, n_dist) {
        b_failed = 0;
        b_close = 0;
        v_color = (0, 1, 0);
        var_7cb887a8 = [];
        var_3e832e74 = 360 / var_9b62e326;
        v_angles = point.angles;
        var_c24ea284 = undefined;
        if (isdefined(group.var_b91441dd) && is_true(group.var_b91441dd.vehiclespawner)) {
            return 1;
        }
        if (isdefined(group.var_b91441dd) && is_true(group.var_b91441dd.supplystash)) {
            if (isdefined(point.radius)) {
                var_cc2e4f94 = point.radius;
            }
        }
        for (i = 0; i < var_9b62e326; i++) {
            var_7cb887a8[i] = point.origin + (0, 0, n_z) + vectorscale(anglestoforward(v_angles), var_cc2e4f94);
            v_angles = point.angles + (0, var_3e832e74, 0);
        }
        var_7cb887a8[i + 1] = point.origin + (0, 0, n_z) + vectorscale(anglestoup(point.angles), var_cc2e4f94);
        foreach (group in var_1d9375fc) {
            if (isarray(group.debug_spawnpoints)) {
                var_2e0e7774 = arraysortclosest(group.debug_spawnpoints, point.origin, 20, 1, n_dist);
                foreach (close in var_2e0e7774) {
                    if (bullettracepassed(point.origin + (0, 0, n_z), close.origin, 0, level.players[0])) {
                        print("<dev string:x1bc>" + function_9e72a96(point.targetname) + "<dev string:x1d2>" + point.origin + "<dev string:x1da>" + close.origin + "<dev string:x1fd>");
                        b_close = 1;
                    }
                }
            }
        }
        foreach (v_test in var_7cb887a8) {
            a_trace = bullettrace(point.origin + (0, 0, n_z), v_test, 0, level.players[0]);
            if (isvehicle(a_trace[#"entity"])) {
                var_c24ea284 = a_trace[#"entity"];
                a_trace = bullettrace(point.origin + (0, 0, n_z), v_test, 0, var_c24ea284);
            }
            if (distancesquared(a_trace[#"position"], point.origin + (0, 0, n_z)) < var_cc2e4f94 * var_cc2e4f94 - 2) {
                b_failed = 1;
            }
        }
        if (b_failed) {
            print("<dev string:x1bc>" + function_9e72a96(point.targetname) + "<dev string:x1d2>" + point.origin + "<dev string:x202>" + "<dev string:x1fd>");
            return 0;
        } else if (b_close) {
            return 0;
        }
        return 1;
    }

    // Namespace wz_russia/wz_russia
    // Params 0, eflags: 0x0
    // Checksum 0x123f7fa9, Offset: 0x2db0
    // Size: 0x1c
    function debug_vehicle_spawn() {
        self thread function_f42944c7();
    }

    // Namespace wz_russia/wz_russia
    // Params 0, eflags: 0x0
    // Checksum 0x3642cbbb, Offset: 0x2dd8
    // Size: 0x41e
    function function_f42944c7() {
        if (!getdvarint(#"hash_57a9b32c8a8503f1", 0) || !self function_1221d304()) {
            return;
        }
        self endon(#"death");
        if (!isdefined(level.var_6eef6733)) {
            level.var_6eef6733 = [];
        }
        if (!isdefined(level.var_6eef6733[function_9e72a96(self.vehicletype)])) {
            level.var_6eef6733[function_9e72a96(self.vehicletype)] = [];
        }
        if (!isdefined(level.var_6eef6733[function_9e72a96(self.vehicletype)])) {
            level.var_6eef6733[function_9e72a96(self.vehicletype)] = [];
        } else if (!isarray(level.var_6eef6733[function_9e72a96(self.vehicletype)])) {
            level.var_6eef6733[function_9e72a96(self.vehicletype)] = array(level.var_6eef6733[function_9e72a96(self.vehicletype)]);
        }
        level.var_6eef6733[function_9e72a96(self.vehicletype)][level.var_6eef6733[function_9e72a96(self.vehicletype)].size] = self;
        v_spawn_pos = self.origin;
        level thread function_f567f0cd();
        level flag::wait_till("<dev string:x6a>");
        str_type = function_9e72a96(self.vehicletype);
        v_color = self function_b2775b52();
        while (getdvarint(#"hash_57a9b32c8a8503f1", 0)) {
            var_91d1913b = distance2d(level.players[0].origin, self.origin);
            n_radius = 0.015 * var_91d1913b;
            if (n_radius > 768) {
                n_radius = 768;
            }
            if (var_91d1913b > 768) {
                sphere(self.origin, n_radius, v_color);
                if (var_91d1913b < 2048) {
                    print3d(self.origin + (0, 0, 32), str_type, v_color);
                }
            }
            if (getdvarint(#"hash_491fd7f96bbc8909", 0) && distance2d(v_spawn_pos, self.origin) > 768) {
                line(v_spawn_pos, self.origin, v_color);
                circle(v_spawn_pos, 64, v_color, 0, 1);
            }
            waitframe(1);
        }
    }

    // Namespace wz_russia/wz_russia
    // Params 0, eflags: 0x0
    // Checksum 0x9cee5e8d, Offset: 0x3200
    // Size: 0x276
    function function_f567f0cd() {
        level notify(#"hash_79845fe0e187bb22");
        level endon(#"hash_79845fe0e187bb22");
        while (getdvarint(#"hash_57a9b32c8a8503f1", 0)) {
            n_total = 0;
            var_bd9acc19 = 176;
            foreach (var_f0ffe8b2 in level.var_6eef6733) {
                var_bd9acc19 += 24;
                n_total += var_f0ffe8b2.size;
                foreach (var_3ed342fe in var_f0ffe8b2) {
                    if (isvehicle(var_3ed342fe) && isdefined(var_f0ffe8b2) && isdefined(var_f0ffe8b2[0]) && isdefined(var_f0ffe8b2[0].vehicletype)) {
                        debug2dtext((810, var_bd9acc19, 0), function_9e72a96(var_f0ffe8b2[0].vehicletype) + "<dev string:x1ab>" + var_f0ffe8b2.size, var_3ed342fe function_b2775b52());
                        break;
                    }
                }
            }
            debug2dtext((810, 176, 0), "<dev string:x221>" + n_total, (1, 1, 1));
            waitframe(1);
        }
    }

    // Namespace wz_russia/wz_russia
    // Params 0, eflags: 0x0
    // Checksum 0xa42ed6e9, Offset: 0x3480
    // Size: 0x22e
    function function_1221d304() {
        a_str_types = array(#"veh_quad_player_wz_blk", #"hash_232abda4e81275f4", #"veh_quad_player_wz_grn", #"hash_2f8d60a5381870ee", #"veh_quad_player_wz_tan", #"veh_mil_ru_fav_heavy", #"vehicle_t9_mil_fav_light", #"hash_42b91f3544c1a9e1", #"vehicle_t9_mil_ru_heli_gunship_hind", #"hash_17e868e0ebf3c1d6", #"vehicle_motorcycle_mil_us_offroad", #"hash_1454b1a4e3718153", #"hash_5dcbfaf19cd0a753", #"hash_6c44467350659f2b", #"hash_2a6d38455e5f8c2b", #"vehicle_t9_mil_snowmobile", #"vehicle_t9_mil_ru_tank_t72", #"hash_2d32c08b862baa46", #"vehicle_t9_mil_ru_truck_light_player", #"hash_7ce4c7dc3df1418e", #"hash_51c4f4dc2591b475", #"hash_9bcbedbfbfe7661", #"hash_985b7e40ee02aa2", #"veh_boct_mil_jetski");
        foreach (str_type in a_str_types) {
            if (self.vehicletype == str_type) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace wz_russia/wz_russia
    // Params 0, eflags: 0x0
    // Checksum 0xd8ab0786, Offset: 0x36b8
    // Size: 0x21a
    function function_b2775b52() {
        switch (self.vehicletype) {
        case #"vehicle_t9_mil_ru_heli_gunship_hind":
            return (1, 0, 0);
        case #"hash_17e868e0ebf3c1d6":
            return (1, 0, 0);
        case #"hash_1454b1a4e3718153":
        case #"hash_2a6d38455e5f8c2b":
        case #"hash_5dcbfaf19cd0a753":
        case #"hash_6c44467350659f2b":
            return (1, 0, 0);
        case #"hash_9bcbedbfbfe7661":
        case #"hash_51c4f4dc2591b475":
        case #"veh_boct_mil_jetski":
        case #"hash_7ce4c7dc3df1418e":
            return (1, 1, 1);
        case #"veh_mil_ru_fav_heavy":
            return (1, 0.5, 0);
        case #"vehicle_t9_mil_ru_tank_t72":
            return (1, 1, 0);
        case #"vehicle_t9_mil_fav_light":
            return (0, 1, 0);
        case #"hash_42b91f3544c1a9e1":
            return (0, 1, 1);
        case #"hash_985b7e40ee02aa2":
        case #"hash_2d32c08b862baa46":
        case #"vehicle_t9_mil_ru_truck_light_player":
            return (0, 1, 1);
        case #"vehicle_t9_mil_snowmobile":
            return (0, 0, 1);
        case #"vehicle_motorcycle_mil_us_offroad":
            return (1, 0, 1);
        case #"veh_quad_player_wz_tan":
        case #"veh_quad_player_wz_blk":
        case #"hash_232abda4e81275f4":
        case #"hash_2f8d60a5381870ee":
        case #"veh_quad_player_wz_grn":
            return (1, 0, 1);
        default:
            return (0, 0, 0);
        }
    }

#/
