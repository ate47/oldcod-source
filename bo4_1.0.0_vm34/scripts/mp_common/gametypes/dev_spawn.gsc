#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\dev;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\util;

#namespace dev_spawn;

/#

    // Namespace dev_spawn/dev_spawn
    // Params 0, eflags: 0x0
    // Checksum 0x8086f743, Offset: 0x98
    // Size: 0x7c
    function function_446284cf() {
        callback::on_start_gametype(&on_start_gametype);
        setdvar(#"hash_4c1fd51cfe763a2", "<dev string:x30>");
        setdvar(#"hash_6d53bd520b4f7853", "<dev string:x38>");
    }

    // Namespace dev_spawn/dev_spawn
    // Params 0, eflags: 0x0
    // Checksum 0x60578ecb, Offset: 0x120
    // Size: 0x1c
    function on_start_gametype() {
        thread function_18330058();
    }

    // Namespace dev_spawn/dev_spawn
    // Params 0, eflags: 0x0
    // Checksum 0xe65246f6, Offset: 0x148
    // Size: 0x224
    function function_cb52ecae() {
        show_spawns = getdvarint(#"scr_showspawns", 0);
        show_start_spawns = getdvarint(#"scr_showstartspawns", 0);
        var_c3021560 = getdvarint(#"hash_42bc2c660a3d2ecd", 0);
        if (show_spawns >= 1) {
            show_spawns = 1;
        } else {
            show_spawns = 0;
        }
        if (show_start_spawns >= 1) {
            show_start_spawns = 1;
        } else {
            show_start_spawns = 0;
        }
        if (var_c3021560 >= 1) {
            var_c3021560 = 1;
        } else {
            var_c3021560 = 0;
        }
        if (!isdefined(level.show_spawns) || level.show_spawns != show_spawns) {
            level.show_spawns = show_spawns;
            setdvar(#"scr_showspawns", level.show_spawns);
            if (level.show_spawns) {
                showspawnpoints();
            } else {
                hidespawnpoints();
            }
        }
        if (!isdefined(level.var_c3021560) || level.var_c3021560 != var_c3021560) {
            level.var_c3021560 = var_c3021560;
            setdvar(#"hash_42bc2c660a3d2ecd", level.var_c3021560);
            if (level.var_c3021560) {
                function_f60dc5e();
                return;
            }
            function_4fab72b3();
        }
    }

    // Namespace dev_spawn/dev_spawn
    // Params 0, eflags: 0x0
    // Checksum 0xb4284823, Offset: 0x378
    // Size: 0x4d2
    function function_e55c6d0a() {
        if (!isdefined(level.var_d479ca5d)) {
            level.var_d479ca5d = [];
            level.var_d479ca5d[#"dm"] = "<dev string:x3c>";
            level.var_d479ca5d[#"ffa"] = "<dev string:x3c>";
            level.var_d479ca5d[#"dem"] = "<dev string:x40>";
            level.var_d479ca5d[#"demolition"] = "<dev string:x40>";
            level.var_d479ca5d[#"dom"] = "<dev string:x44>";
            level.var_d479ca5d[#"domination"] = "<dev string:x44>";
            level.var_d479ca5d[#"demolition_attacker_a"] = "<dev string:x48>";
            level.var_d479ca5d[#"demolition_attacker_b"] = "<dev string:x57>";
            level.var_d479ca5d[#"demolition_defender_a"] = "<dev string:x66>";
            level.var_d479ca5d[#"demolition_defender_b"] = "<dev string:x75>";
            level.var_d479ca5d[#"demolition_overtime"] = "<dev string:x84>";
            level.var_d479ca5d[#"demolition_remove_a"] = "<dev string:x91>";
            level.var_d479ca5d[#"demolition_remove_b"] = "<dev string:x9e>";
            level.var_d479ca5d[#"demolition_start_spawn"] = "<dev string:xab>";
            level.var_d479ca5d[#"domination_flag_a"] = "<dev string:xbb>";
            level.var_d479ca5d[#"domination_flag_b"] = "<dev string:xc6>";
            level.var_d479ca5d[#"domination_flag_c"] = "<dev string:xd1>";
            level.var_d479ca5d[#"ctf"] = "<dev string:xdc>";
            level.var_d479ca5d[#"frontline"] = "<dev string:xe0>";
            level.var_d479ca5d[#"gun"] = "<dev string:xea>";
            level.var_d479ca5d[#"koth"] = "<dev string:xed>";
            level.var_d479ca5d[#"infil"] = "<dev string:xf2>";
            level.var_d479ca5d[#"kc"] = "<dev string:xf8>";
            level.var_d479ca5d[#"sd"] = "<dev string:xfb>";
            level.var_d479ca5d[#"control"] = "<dev string:xfe>";
            level.var_d479ca5d[#"tdm"] = "<dev string:x106>";
            level.var_d479ca5d[#"clean"] = "<dev string:x10a>";
            level.var_d479ca5d[#"ct"] = "<dev string:x111>";
            level.var_d479ca5d[#"escort"] = "<dev string:x114>";
            level.var_d479ca5d[#"bounty"] = "<dev string:x11b>";
        }
    }

    // Namespace dev_spawn/dev_spawn
    // Params 0, eflags: 0x0
    // Checksum 0xef575a1c, Offset: 0x858
    // Size: 0xce
    function function_18330058() {
        while (true) {
            var_1f556083 = getdvarstring(#"scr_set_spawns");
            if (var_1f556083 != "<dev string:x122>") {
                function_e55c6d0a();
                var_ac873fbf = function_4e94e78e(var_1f556083);
                function_a0193795(var_ac873fbf);
                setdvar(#"scr_set_spawns", "<dev string:x122>");
            }
            wait 1;
        }
    }

    // Namespace dev_spawn/dev_spawn
    // Params 1, eflags: 0x0
    // Checksum 0x86f3c3de, Offset: 0x930
    // Size: 0xec
    function function_a0193795(var_ac873fbf) {
        hidespawnpoints();
        spawning::clear_spawn_points();
        globallogic_spawn::function_5e32e69a();
        foreach (spawnflag in var_ac873fbf) {
            globallogic_spawn::addsupportedspawnpointtype(spawnflag);
        }
        spawning::updateallspawnpoints();
        globallogic_spawn::addspawns();
        showspawnpoints();
    }

    // Namespace dev_spawn/dev_spawn
    // Params 1, eflags: 0x0
    // Checksum 0x61474d3b, Offset: 0xa28
    // Size: 0x1ba
    function function_4e94e78e(var_1f556083) {
        flagset = [];
        tokens = strtok(tolower(var_1f556083), "<dev string:x123>");
        foreach (token in tokens) {
            spawnflag = function_7067c671(token);
            if (isdefined(spawnflag)) {
                flagset[spawnflag] = 1;
            }
        }
        flags = [];
        foreach (flag, isset in flagset) {
            if (isset) {
                if (!isdefined(flags)) {
                    flags = [];
                } else if (!isarray(flags)) {
                    flags = array(flags);
                }
                flags[flags.size] = flag;
            }
        }
        return flags;
    }

    // Namespace dev_spawn/dev_spawn
    // Params 1, eflags: 0x0
    // Checksum 0x81591135, Offset: 0xbf0
    // Size: 0x22
    function function_7067c671(gametypestr) {
        return level.var_d479ca5d[gametypestr];
    }

    // Namespace dev_spawn/dev_spawn
    // Params 4, eflags: 0x0
    // Checksum 0x2f393e1c, Offset: 0xc20
    // Size: 0xf8
    function function_5d10fd95(var_66ea5e15, var_a49abd5a, actualteam, isstartspawn) {
        if (var_a49abd5a == "<dev string:x38>") {
            return 1;
        } else if (var_a49abd5a == "<dev string:x128>" && !isstartspawn) {
            return 0;
        } else if (isstartspawn && var_a49abd5a != "<dev string:x128>") {
            return 0;
        } else if (var_a49abd5a == "<dev string:x12e>" && var_66ea5e15 != #"any") {
            if (var_66ea5e15 == #"neutral" && isdefined(actualteam)) {
                return 0;
            }
            if (!(isdefined(actualteam) && actualteam == var_66ea5e15)) {
                return 0;
            }
        }
        return 1;
    }

    // Namespace dev_spawn/dev_spawn
    // Params 1, eflags: 0x0
    // Checksum 0xfb6ca23b, Offset: 0xd20
    // Size: 0x258
    function function_9e7c16bb(spawnlist) {
        level endon(#"hide_spawnpoints", #"hash_12bbc39c8f50f769");
        maxdistancesq = 1000000;
        hostplayer = util::gethostplayer();
        if (!isdefined(hostplayer)) {
            return;
        }
        while (true) {
            color = (1, 1, 1);
            var_66ea5e15 = getdvarstring(#"hash_4c1fd51cfe763a2");
            var_a49abd5a = getdvarstring(#"hash_6d53bd520b4f7853");
            level.var_c88d2e0d = [];
            for (spawn_point_index = 0; spawn_point_index < spawnlist.size; spawn_point_index++) {
                if (!function_5d10fd95(var_66ea5e15, var_a49abd5a, spawnlist[spawn_point_index].team, isdefined(spawnlist[spawn_point_index].var_7e38bf33) ? spawnlist[spawn_point_index].var_7e38bf33 : 0)) {
                    continue;
                }
                if (distancesquared(hostplayer.origin, spawnlist[spawn_point_index].origin) > maxdistancesq) {
                    continue;
                }
                if (!isdefined(level.var_c88d2e0d)) {
                    level.var_c88d2e0d = [];
                } else if (!isarray(level.var_c88d2e0d)) {
                    level.var_c88d2e0d = array(level.var_c88d2e0d);
                }
                level.var_c88d2e0d[level.var_c88d2e0d.size] = spawnlist[spawn_point_index];
                drawspawnpoint(spawnlist[spawn_point_index], color);
            }
            waitframe(1);
        }
    }

    // Namespace dev_spawn/dev_spawn
    // Params 0, eflags: 0x0
    // Checksum 0x40a0c335, Offset: 0xf80
    // Size: 0xec
    function showspawnpoints() {
        spawns = [];
        spawnpoints = arraycombine(level.spawnpoints, spawns, 0, 0);
        if (isdefined(level.spawn_start)) {
            foreach (startspawns in level.spawn_start) {
                spawnpoints = arraycombine(startspawns, spawnpoints, 0, 0);
            }
        }
        thread function_9e7c16bb(spawnpoints);
    }

    // Namespace dev_spawn/dev_spawn
    // Params 0, eflags: 0x0
    // Checksum 0x3e9faf3f, Offset: 0x1078
    // Size: 0x10c
    function function_f60dc5e() {
        if (!isdefined(level.spawnpoints)) {
            return;
        }
        color = (1, 1, 1);
        spawns = [];
        spawnpoints = arraycombine(level.allspawnpoints, spawns, 0, 0);
        if (isdefined(level.spawn_start)) {
            foreach (startspawns in level.spawn_start) {
                spawnpoints = arraycombine(startspawns, spawnpoints, 0, 0);
            }
        }
        thread function_9e7c16bb(spawnpoints);
    }

    // Namespace dev_spawn/dev_spawn
    // Params 0, eflags: 0x0
    // Checksum 0x4585a099, Offset: 0x1190
    // Size: 0x20
    function function_4fab72b3() {
        level notify(#"hash_12bbc39c8f50f769");
    }

    // Namespace dev_spawn/dev_spawn
    // Params 0, eflags: 0x0
    // Checksum 0xb77c758, Offset: 0x11b8
    // Size: 0x22
    function hidespawnpoints() {
        level notify(#"hide_spawnpoints");
        return;
    }

    // Namespace dev_spawn/dev_spawn
    // Params 0, eflags: 0x0
    // Checksum 0xf396f2c2, Offset: 0x11e8
    // Size: 0x2c2
    function showstartspawnpoints() {
        if (!isdefined(level.spawn_start)) {
            return;
        }
        if (level.teambased) {
            team_colors = [];
            team_colors[#"axis"] = (1, 0, 1);
            team_colors[#"allies"] = (0, 1, 1);
            team_colors[#"team3"] = (1, 1, 0);
            team_colors[#"team4"] = (0, 1, 0);
            team_colors[#"team5"] = (0, 0, 1);
            team_colors[#"team6"] = (1, 0.5, 0);
            team_colors[#"team7"] = (1, 0.752941, 0.796078);
            team_colors[#"team8"] = (0.545098, 0.270588, 0.0745098);
            foreach (key, color in team_colors) {
                if (!isdefined(level.spawn_start[key])) {
                    continue;
                }
                foreach (spawnpoint in level.spawn_start[key]) {
                    showonespawnpoint(spawnpoint, color, "<dev string:x133>");
                }
            }
            return;
        }
        color = (1, 0, 1);
        foreach (spawnpoint in level.spawn_start) {
            showonespawnpoint(spawnpoint, color, "<dev string:x133>");
        }
        return;
    }

    // Namespace dev_spawn/dev_spawn
    // Params 0, eflags: 0x0
    // Checksum 0x755e501a, Offset: 0x14b8
    // Size: 0x22
    function hidestartspawnpoints() {
        level notify(#"hide_startspawnpoints");
        return;
    }

    // Namespace dev_spawn/dev_spawn
    // Params 4, eflags: 0x0
    // Checksum 0x50ee4596, Offset: 0x14e8
    // Size: 0x544
    function drawspawnpoint(spawn_point, color, height, var_14a0f5be) {
        if (!isdefined(height) || height <= 0) {
            height = util::get_player_height();
        }
        if (!isdefined(var_14a0f5be)) {
            if (level.convert_spawns_to_structs) {
                var_14a0f5be = spawn_point.targetname;
            } else {
                var_14a0f5be = spawn_point.classname;
            }
        }
        depthtest = 0;
        center = spawn_point.origin;
        forward = anglestoforward(spawn_point.angles);
        right = anglestoright(spawn_point.angles);
        forward = vectorscale(forward, 16);
        right = vectorscale(right, 16);
        a = center + forward - right;
        b = center + forward + right;
        c = center - forward + right;
        d = center - forward - right;
        line(a, b, color, 0, depthtest);
        line(b, c, color, 0, depthtest);
        line(c, d, color, 0, depthtest);
        line(d, a, color, 0, depthtest);
        line(a, a + (0, 0, height), color, 0, depthtest);
        line(b, b + (0, 0, height), color, 0, depthtest);
        line(c, c + (0, 0, height), color, 0, depthtest);
        line(d, d + (0, 0, height), color, 0, depthtest);
        a += (0, 0, height);
        b += (0, 0, height);
        c += (0, 0, height);
        d += (0, 0, height);
        line(a, b, color, 0, depthtest);
        line(b, c, color, 0, depthtest);
        line(c, d, color, 0, depthtest);
        line(d, a, color, 0, depthtest);
        center += (0, 0, height / 2);
        arrow_forward = anglestoforward(spawn_point.angles);
        arrowhead_forward = anglestoforward(spawn_point.angles);
        arrowhead_right = anglestoright(spawn_point.angles);
        arrow_forward = vectorscale(arrow_forward, 32);
        arrowhead_forward = vectorscale(arrowhead_forward, 24);
        arrowhead_right = vectorscale(arrowhead_right, 8);
        a = center + arrow_forward;
        b = center + arrowhead_forward - arrowhead_right;
        c = center + arrowhead_forward + arrowhead_right;
        line(center, a, color, 0, depthtest);
        line(a, b, color, 0, depthtest);
        line(a, c, color, 0, depthtest);
        if (isdefined(var_14a0f5be) && var_14a0f5be != "<dev string:x122>") {
            print3d(spawn_point.origin + (0, 0, height), var_14a0f5be, color, 1, 1);
        }
    }

    // Namespace dev_spawn/dev_spawn
    // Params 5, eflags: 0x0
    // Checksum 0x56ebd51f, Offset: 0x1a38
    // Size: 0x54e
    function showonespawnpoint(spawn_point, color, notification, height, print) {
        if (!isdefined(height) || height <= 0) {
            height = util::get_player_height();
        }
        if (!isdefined(print)) {
            if (level.convert_spawns_to_structs) {
                print = spawn_point.targetname;
            } else {
                print = spawn_point.classname;
            }
        }
        center = spawn_point.origin;
        forward = anglestoforward(spawn_point.angles);
        right = anglestoright(spawn_point.angles);
        forward = vectorscale(forward, 16);
        right = vectorscale(right, 16);
        a = center + forward - right;
        b = center + forward + right;
        c = center - forward + right;
        d = center - forward - right;
        thread dev::lineuntilnotified(a, b, color, 0, notification);
        thread dev::lineuntilnotified(b, c, color, 0, notification);
        thread dev::lineuntilnotified(c, d, color, 0, notification);
        thread dev::lineuntilnotified(d, a, color, 0, notification);
        thread dev::lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
        thread dev::lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
        thread dev::lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
        thread dev::lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
        a += (0, 0, height);
        b += (0, 0, height);
        c += (0, 0, height);
        d += (0, 0, height);
        thread dev::lineuntilnotified(a, b, color, 0, notification);
        thread dev::lineuntilnotified(b, c, color, 0, notification);
        thread dev::lineuntilnotified(c, d, color, 0, notification);
        thread dev::lineuntilnotified(d, a, color, 0, notification);
        center += (0, 0, height / 2);
        arrow_forward = anglestoforward(spawn_point.angles);
        arrowhead_forward = anglestoforward(spawn_point.angles);
        arrowhead_right = anglestoright(spawn_point.angles);
        arrow_forward = vectorscale(arrow_forward, 32);
        arrowhead_forward = vectorscale(arrowhead_forward, 24);
        arrowhead_right = vectorscale(arrowhead_right, 8);
        a = center + arrow_forward;
        b = center + arrowhead_forward - arrowhead_right;
        c = center + arrowhead_forward + arrowhead_right;
        thread dev::lineuntilnotified(center, a, color, 0, notification);
        thread dev::lineuntilnotified(a, b, color, 0, notification);
        thread dev::lineuntilnotified(a, c, color, 0, notification);
        if (isdefined(print) && print != "<dev string:x122>") {
            thread dev::print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
        }
        return;
    }

#/
