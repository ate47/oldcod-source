#using scripts\core_common\gestures;
#using scripts\core_common\util_shared;

#namespace dev;

/#

    // Namespace dev/dev_shared
    // Params 5, eflags: 0x0
    // Checksum 0xa1eb6f33, Offset: 0x78
    // Size: 0xbc
    function debug_sphere(origin, radius, color, alpha, time) {
        if (!isdefined(time)) {
            time = 1000;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        sides = int(10 * (1 + int(radius) % 100));
        sphere(origin, radius, color, alpha, 1, sides, time);
    }

    // Namespace dev/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0xdf7b861c, Offset: 0x140
    // Size: 0x3e6
    function devgui_test_chart_think() {
        waitframe(1);
        old_val = getdvarint(#"scr_debug_test_chart", 0);
        scale = 120;
        for (;;) {
            val = getdvarint(#"scr_debug_test_chart", 0);
            if (old_val != val) {
                if (isdefined(level.test_chart_model)) {
                    level.test_chart_model delete();
                    level.test_chart_model = undefined;
                }
                if (val) {
                    player = getplayers()[0];
                    direction = player getplayerangles();
                    direction_vec = anglestoforward((0, direction[1], 0));
                    direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
                    level.test_chart_model = spawn("<dev string:x30>", player geteye() + direction_vec);
                    level.test_chart_model setmodel(#"test_chart_model");
                    level.test_chart_model.angles = (0, direction[1], 0) + (0, 90, 0);
                }
            }
            if (val) {
                player = getplayers()[0];
                if (val == 1) {
                    level.test_chart_model setmodel(#"test_chart_model");
                } else if (val == 2) {
                    level.test_chart_model setmodel(#"test_chart_model_2");
                } else if (val == 3) {
                    level.test_chart_model setmodel(#"test_chart_model_3");
                }
                direction = player getplayerangles();
                direction_vec = anglestoforward((0, direction[1], 0));
                direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
                level.test_chart_model.angles = (0, direction[1], 0) + (0, 90, 0);
                level.test_chart_model.origin = player geteye() + direction_vec;
                if (player meleebuttonpressed()) {
                    scale += 10;
                }
                if (player sprintbuttonpressed()) {
                    scale -= 10;
                }
            }
            old_val = val;
            waitframe(1);
        }
    }

    // Namespace dev/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0xec76ddcd, Offset: 0x530
    // Size: 0xad4
    function updateminimapsetting() {
        requiredmapaspectratio = getdvarfloat(#"scr_requiredmapaspectratio", 0);
        if (!isdefined(level.minimapheight)) {
            setdvar(#"scr_minimap_height", 0);
            level.minimapheight = 0;
        }
        minimapheight = getdvarfloat(#"scr_minimap_height", 0);
        if (minimapheight != level.minimapheight) {
            if (minimapheight <= 0) {
                util::gethostplayer() cameraactivate(0);
                level.minimapheight = minimapheight;
                level notify(#"end_draw_map_bounds");
            }
            if (minimapheight > 0) {
                level.minimapheight = minimapheight;
                players = getplayers();
                if (players.size > 0) {
                    player = util::gethostplayer();
                    corners = getentarray("<dev string:x3d>", "<dev string:x4c>");
                    if (corners.size == 2) {
                        viewpos = corners[0].origin + corners[1].origin;
                        viewpos = (viewpos[0] * 0.5, viewpos[1] * 0.5, viewpos[2] * 0.5);
                        level thread minimapwarn(corners);
                        maxcorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
                        mincorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
                        if (corners[1].origin[0] > corners[0].origin[0]) {
                            maxcorner = (corners[1].origin[0], maxcorner[1], maxcorner[2]);
                        } else {
                            mincorner = (corners[1].origin[0], mincorner[1], mincorner[2]);
                        }
                        if (corners[1].origin[1] > corners[0].origin[1]) {
                            maxcorner = (maxcorner[0], corners[1].origin[1], maxcorner[2]);
                        } else {
                            mincorner = (mincorner[0], corners[1].origin[1], mincorner[2]);
                        }
                        viewpostocorner = maxcorner - viewpos;
                        viewpos = (viewpos[0], viewpos[1], viewpos[2] + minimapheight);
                        northvector = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
                        eastvector = (northvector[1], 0 - northvector[0], 0);
                        disttotop = vectordot(northvector, viewpostocorner);
                        if (disttotop < 0) {
                            disttotop = 0 - disttotop;
                        }
                        disttoside = vectordot(eastvector, viewpostocorner);
                        if (disttoside < 0) {
                            disttoside = 0 - disttoside;
                        }
                        if (requiredmapaspectratio > 0) {
                            mapaspectratio = disttoside / disttotop;
                            if (mapaspectratio < requiredmapaspectratio) {
                                incr = requiredmapaspectratio / mapaspectratio;
                                disttoside *= incr;
                                addvec = vecscale(eastvector, vectordot(eastvector, maxcorner - viewpos) * (incr - 1));
                                mincorner -= addvec;
                                maxcorner += addvec;
                            } else {
                                incr = mapaspectratio / requiredmapaspectratio;
                                disttotop *= incr;
                                addvec = vecscale(northvector, vectordot(northvector, maxcorner - viewpos) * (incr - 1));
                                mincorner -= addvec;
                                maxcorner += addvec;
                            }
                        }
                        if (level.console) {
                            aspectratioguess = 1.77778;
                            angleside = 2 * atan(disttoside * 0.8 / minimapheight);
                            angletop = 2 * atan(disttotop * aspectratioguess * 0.8 / minimapheight);
                        } else {
                            aspectratioguess = 1.33333;
                            angleside = 2 * atan(disttoside / minimapheight);
                            angletop = 2 * atan(disttotop * aspectratioguess / minimapheight);
                        }
                        if (angleside > angletop) {
                            angle = angleside;
                        } else {
                            angle = angletop;
                        }
                        znear = minimapheight - 1000;
                        if (znear < 16) {
                            znear = 16;
                        }
                        if (znear > 10000) {
                            znear = 10000;
                        }
                        player camerasetposition(viewpos, (90, getnorthyaw(), 0));
                        player cameraactivate(1);
                        player takeallweapons();
                        setdvar(#"cg_drawgun", 0);
                        setdvar(#"cg_draw2d", 0);
                        setdvar(#"cg_drawfps", 0);
                        setdvar(#"fx_enable", 0);
                        setdvar(#"r_fog", 0);
                        setdvar(#"r_highloddist", 0);
                        setdvar(#"r_znear", znear);
                        setdvar(#"r_lodscalerigid", 0.1);
                        setdvar(#"cg_drawversion", 0);
                        setdvar(#"sm_enable", 1);
                        setdvar(#"player_view_pitch_down", 90);
                        setdvar(#"player_view_pitch_up", 0);
                        setdvar(#"cg_fov", angle);
                        setdvar(#"cg_drawminimap", 1);
                        setdvar(#"r_umbranumthreads", 1);
                        setdvar(#"r_umbradistancescale", 0.1);
                        setdvar(#"r_uselensfov", 0);
                        setdvar(#"hash_5ee9a4ac16993e50", 1);
                        setdvar(#"debug_show_viewpos", 0);
                        thread drawminimapbounds(viewpos, mincorner, maxcorner);
                    } else {
                        println("<dev string:x57>");
                    }
                    return;
                }
                setdvar(#"scr_minimap_height", 0);
            }
        }
    }

    // Namespace dev/dev_shared
    // Params 2, eflags: 0x0
    // Checksum 0xedff8b09, Offset: 0x1010
    // Size: 0x4a
    function vecscale(vec, scalar) {
        return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
    }

    // Namespace dev/dev_shared
    // Params 3, eflags: 0x0
    // Checksum 0xa286253a, Offset: 0x1068
    // Size: 0x396
    function drawminimapbounds(viewpos, mincorner, maxcorner) {
        level notify(#"end_draw_map_bounds");
        level endon(#"end_draw_map_bounds");
        viewheight = viewpos[2] - maxcorner[2];
        north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
        diaglen = length(mincorner - maxcorner);
        mincorneroffset = mincorner - viewpos;
        mincorneroffset = vectornormalize((mincorneroffset[0], mincorneroffset[1], 0));
        mincorner += vecscale(mincorneroffset, diaglen * 1 / 800);
        maxcorneroffset = maxcorner - viewpos;
        maxcorneroffset = vectornormalize((maxcorneroffset[0], maxcorneroffset[1], 0));
        maxcorner += vecscale(maxcorneroffset, diaglen * 1 / 800);
        diagonal = maxcorner - mincorner;
        side = vecscale(north, vectordot(diagonal, north));
        sidenorth = vecscale(north, abs(vectordot(diagonal, north)));
        corner0 = mincorner;
        corner1 = mincorner + side;
        corner2 = maxcorner;
        corner3 = maxcorner - side;
        toppos = vecscale(mincorner + maxcorner, 0.5) + vecscale(sidenorth, 0.51);
        textscale = diaglen * 0.003;
        while (true) {
            line(corner0, corner1);
            line(corner1, corner2);
            line(corner2, corner3);
            line(corner3, corner0);
            print3d(toppos, "<dev string:xa0>", (1, 1, 1), 1, textscale);
            waitframe(1);
        }
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1e1c403f, Offset: 0x1408
    // Size: 0x10
    function minimapwarn(corners) {
        
    }

    // Namespace dev/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9522922f, Offset: 0x1420
    // Size: 0x11e
    function function_6ed563ea() {
        host = util::gethostplayer();
        all_players = getplayers();
        var_b190c9fe = host getstance() == "<dev string:xad>";
        if (!isdefined(host) || var_b190c9fe) {
            return all_players;
        }
        all_players = arraysort(all_players, host.origin);
        players = [];
        if (all_players.size == 1 || host getstance() == "<dev string:xb3>") {
            players[0] = host;
        } else {
            players[0] = all_players[1];
        }
        return players;
    }

    // Namespace dev/dev_shared
    // Params 2, eflags: 0x0
    // Checksum 0xe9f72d42, Offset: 0x1548
    // Size: 0xc8
    function function_a148a031(bodytype, outfitindex) {
        players = function_6ed563ea();
        foreach (player in players) {
            player setcharacterbodytype(bodytype);
            player setcharacteroutfit(outfitindex);
        }
    }

    // Namespace dev/dev_shared
    // Params 4, eflags: 0x0
    // Checksum 0x8fcff9f6, Offset: 0x1618
    // Size: 0xc0
    function function_f535ec3f(bodytype, outfitindex, var_ca58417c, index) {
        players = function_6ed563ea();
        foreach (player in players) {
            player function_541d70d2(var_ca58417c, index);
        }
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0xad274016, Offset: 0x16e0
    // Size: 0x3ca
    function body_customization_process_command(character_index) {
        println("<dev string:xb9>" + character_index + "<dev string:xde>");
        split = strtok(character_index, "<dev string:xe0>");
        switch (split.size) {
        case 1:
            command0 = strtok(split[0], "<dev string:xe2>");
            bodytype = int(command0[1]);
            println("<dev string:xe4>" + bodytype + "<dev string:x120>");
            function_a148a031(bodytype, 0);
            break;
        case 2:
            command0 = strtok(split[0], "<dev string:xe2>");
            bodytype = int(command0[1]);
            command1 = strtok(split[1], "<dev string:xe2>");
            outfitindex = int(command1[1]);
            println("<dev string:xe4>" + bodytype + "<dev string:x122>" + outfitindex + "<dev string:x120>");
            function_a148a031(bodytype, outfitindex);
            break;
        case 3:
            command0 = strtok(split[0], "<dev string:xe2>");
            bodytype = int(command0[1]);
            command1 = strtok(split[1], "<dev string:xe2>");
            outfitindex = int(command1[1]);
            var_6d27f7ee = strtok(split[2], "<dev string:xe2>");
            var_ca58417c = var_6d27f7ee[0];
            index = int(var_6d27f7ee[1]);
            println("<dev string:x130>" + bodytype + "<dev string:x122>" + outfitindex + "<dev string:x163>" + var_ca58417c + "<dev string:x16a>" + index + "<dev string:x120>");
            function_f535ec3f(bodytype, outfitindex, var_ca58417c, index);
            break;
        default:
            break;
        }
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5265fc41, Offset: 0x1ab8
    // Size: 0x894
    function body_customization_populate(mode) {
        bodies = getallcharacterbodies(mode);
        body_customization_devgui_base = "<dev string:x16c>";
        foreach (playerbodytype in bodies) {
            body_name = makelocalizedstring(getcharacterdisplayname(playerbodytype, mode)) + "<dev string:x193>" + function_15979fa9(getcharacterassetname(playerbodytype, mode));
            util::add_debug_command(body_customization_devgui_base + body_name + "<dev string:x195>" + "<dev string:x19e>" + "<dev string:x1a6>" + "<dev string:x16a>" + "<dev string:x1b2>" + playerbodytype + "<dev string:x1bc>");
            var_c9ac868d = function_33f4b4b7(playerbodytype, mode);
            for (outfitindex = 0; outfitindex < var_c9ac868d; outfitindex++) {
                var_1858f9e4 = function_d066c3f3(playerbodytype, outfitindex, mode);
                var_96107a59 = makelocalizedstring(function_15979fa9(var_1858f9e4.var_115c89c));
                var_c1b6682c = (outfitindex > 10 ? "<dev string:x1c2>" : "<dev string:x1c0>") + outfitindex + "<dev string:x193>" + var_96107a59 + "<dev string:x193>" + function_15979fa9(var_1858f9e4.namehash);
                var_9f93dbc7 = body_customization_devgui_base + body_name + "<dev string:x1c3>" + var_c1b6682c;
                util::add_debug_command(var_9f93dbc7 + "<dev string:x195>" + "<dev string:x19e>" + "<dev string:x1a6>" + "<dev string:x16a>" + "<dev string:x1b2>" + playerbodytype + "<dev string:xe0>" + "<dev string:x1c5>" + outfitindex + "<dev string:x1bc>");
                for (index = 0; index < var_1858f9e4.var_c5e6c49b; index++) {
                    util::add_debug_command(var_9f93dbc7 + "<dev string:x1cd>" + index + "<dev string:x19e>" + "<dev string:x1a6>" + "<dev string:x16a>" + "<dev string:x1b2>" + playerbodytype + "<dev string:xe0>" + "<dev string:x1c5>" + outfitindex + "<dev string:xe0>" + "<dev string:x1da>" + index + "<dev string:x1bc>");
                }
                if (isdefined(var_1858f9e4.var_e2a5a6a)) {
                    for (index = 0; index < var_1858f9e4.var_e2a5a6a; index++) {
                        util::add_debug_command(var_9f93dbc7 + "<dev string:x1e0>" + index + "<dev string:x19e>" + "<dev string:x1a6>" + "<dev string:x16a>" + "<dev string:x1b2>" + playerbodytype + "<dev string:xe0>" + "<dev string:x1c5>" + outfitindex + "<dev string:xe0>" + "<dev string:x1f1>" + index + "<dev string:x1bc>");
                    }
                }
                for (index = 0; index < var_1858f9e4.var_d46fd781; index++) {
                    util::add_debug_command(var_9f93dbc7 + "<dev string:x1fb>" + index + "<dev string:x19e>" + "<dev string:x1a6>" + "<dev string:x16a>" + "<dev string:x1b2>" + playerbodytype + "<dev string:xe0>" + "<dev string:x1c5>" + outfitindex + "<dev string:xe0>" + "<dev string:x207>" + index + "<dev string:x1bc>");
                }
                if (isdefined(var_1858f9e4.var_41b881be)) {
                    for (index = 0; index < var_1858f9e4.var_41b881be; index++) {
                        util::add_debug_command(var_9f93dbc7 + "<dev string:x20d>" + index + "<dev string:x19e>" + "<dev string:x1a6>" + "<dev string:x16a>" + "<dev string:x1b2>" + playerbodytype + "<dev string:xe0>" + "<dev string:x1c5>" + outfitindex + "<dev string:xe0>" + "<dev string:x21c>" + index + "<dev string:x1bc>");
                    }
                }
                for (index = 0; index < var_1858f9e4.var_cfdf90b7; index++) {
                    util::add_debug_command(var_9f93dbc7 + "<dev string:x223>" + index + "<dev string:x19e>" + "<dev string:x1a6>" + "<dev string:x16a>" + "<dev string:x1b2>" + playerbodytype + "<dev string:xe0>" + "<dev string:x1c5>" + outfitindex + "<dev string:xe0>" + "<dev string:x22f>" + index + "<dev string:x1bc>");
                }
                for (index = 0; index < var_1858f9e4.var_8aaa3ec2; index++) {
                    util::add_debug_command(var_9f93dbc7 + "<dev string:x235>" + index + "<dev string:x19e>" + "<dev string:x1a6>" + "<dev string:x16a>" + "<dev string:x1b2>" + playerbodytype + "<dev string:xe0>" + "<dev string:x1c5>" + outfitindex + "<dev string:xe0>" + "<dev string:x248>" + index + "<dev string:x1bc>");
                }
                if (isdefined(var_1858f9e4.var_42f2a77f)) {
                    for (index = 0; index < var_1858f9e4.var_42f2a77f; index++) {
                        util::add_debug_command(var_9f93dbc7 + "<dev string:x251>" + index + "<dev string:x19e>" + "<dev string:x1a6>" + "<dev string:x16a>" + "<dev string:x1b2>" + playerbodytype + "<dev string:xe0>" + "<dev string:x1c5>" + outfitindex + "<dev string:xe0>" + "<dev string:x266>" + index + "<dev string:x1bc>");
                    }
                }
                if (isdefined(var_1858f9e4.var_948d3e98)) {
                    for (index = 0; index < var_1858f9e4.var_948d3e98; index++) {
                        util::add_debug_command(var_9f93dbc7 + "<dev string:x270>" + index + "<dev string:x19e>" + "<dev string:x1a6>" + "<dev string:x16a>" + "<dev string:x1b2>" + playerbodytype + "<dev string:xe0>" + "<dev string:x1c5>" + outfitindex + "<dev string:xe0>" + "<dev string:x27f>" + index + "<dev string:x1bc>");
                    }
                }
            }
        }
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe13548a6, Offset: 0x2358
    // Size: 0xa8
    function body_customization_devgui(mode) {
        body_customization_populate(mode);
        for (;;) {
            character_index = getdvarstring(#"char_devgui");
            if (character_index != "<dev string:x1c2>") {
                body_customization_process_command(character_index);
            }
            setdvar(#"char_devgui", "<dev string:x1c2>");
            wait 0.5;
        }
    }

    // Namespace dev/dev_shared
    // Params 2, eflags: 0x0
    // Checksum 0xb3f5b9c0, Offset: 0x2408
    // Size: 0xbc
    function add_perk_devgui(name, specialties) {
        perk_devgui_base = "<dev string:x286>";
        perk_name = name;
        test = perk_devgui_base + perk_name + "<dev string:x19e>" + "<dev string:x2aa>" + "<dev string:x16a>" + specialties + "<dev string:x1bc>";
        util::add_debug_command(perk_devgui_base + perk_name + "<dev string:x19e>" + "<dev string:x2aa>" + "<dev string:x16a>" + specialties + "<dev string:x1bc>");
    }

    // Namespace dev/dev_shared
    // Params 2, eflags: 0x0
    // Checksum 0xd5e56575, Offset: 0x24d0
    // Size: 0xcc
    function function_69a73201(name, postfix) {
        if (!isdefined(postfix)) {
            postfix = "<dev string:x1c2>";
        }
        if (!isdefined(name)) {
            return;
        }
        if (name == "<dev string:x1c2>") {
            return;
        }
        util::waittill_can_add_debug_command();
        talentname = "<dev string:x1c2>" + name + postfix;
        cmd = "<dev string:x2b7>" + "<dev string:x2bc>" + "<dev string:x16a>" + talentname;
        util::add_devgui("<dev string:x2cb>" + talentname, cmd);
    }

    // Namespace dev/dev_shared
    // Params 2, eflags: 0x0
    // Checksum 0x23b8a546, Offset: 0x25a8
    // Size: 0xdc
    function function_89d3cfb4(name, postfix) {
        if (!isdefined(postfix)) {
            postfix = "<dev string:x1c2>";
        }
        if (!isdefined(name)) {
            return;
        }
        if (name == "<dev string:x1c2>") {
            return;
        }
        util::waittill_can_add_debug_command();
        talentname = "<dev string:x2f8>" + getsubstr(name, 7) + postfix;
        cmd = "<dev string:x2b7>" + "<dev string:x2ff>" + "<dev string:x16a>" + talentname;
        util::add_devgui("<dev string:x30d>" + talentname, cmd);
    }

    // Namespace dev/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0xab187555, Offset: 0x2690
    // Size: 0x17c
    function function_4f857635() {
        gesture = getdvarstring(#"scr_givegesture");
        if (isdefined(gesture) && gesture != "<dev string:x1c2>") {
            foreach (player in level.players) {
                if (isbot(player)) {
                    continue;
                }
                player gestures::clear_gesture();
                player.loadoutgesture = getweapon(gesture);
                if (isdefined(player.loadoutgesture) && player.loadoutgesture != level.weaponnone) {
                    player gestures::give_gesture(player.loadoutgesture);
                }
            }
        }
        setdvar(#"scr_givegesture", "<dev string:x1c2>");
    }

    // Namespace dev/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9bf7243c, Offset: 0x2818
    // Size: 0x90
    function function_43a9e5a6() {
        for (;;) {
            gesture = getdvarstring(#"scr_givegesture");
            if (gesture != "<dev string:x1c2>") {
                function_4f857635();
            }
            setdvar(#"scr_givegesture", "<dev string:x1c2>");
            wait 0.5;
        }
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc06f7a2, Offset: 0x28b0
    // Size: 0xca
    function get_lookat_origin(player) {
        angles = player getplayerangles();
        forward = anglestoforward(angles);
        dir = vectorscale(forward, 8000);
        eye = player geteye();
        trace = bullettrace(eye, eye + dir, 0, undefined);
        return trace[#"position"];
    }

    // Namespace dev/dev_shared
    // Params 2, eflags: 0x0
    // Checksum 0x65ce1a55, Offset: 0x2988
    // Size: 0x6c
    function draw_pathnode(node, color) {
        if (!isdefined(color)) {
            color = (1, 0, 1);
        }
        box(node.origin, (-16, -16, 0), (16, 16, 16), 0, color, 1, 0, 1);
    }

    // Namespace dev/dev_shared
    // Params 2, eflags: 0x0
    // Checksum 0x8d13488d, Offset: 0x2a00
    // Size: 0x4e
    function draw_pathnode_think(node, color) {
        level endon(#"draw_pathnode_stop");
        for (;;) {
            draw_pathnode(node, color);
            waitframe(1);
        }
    }

    // Namespace dev/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb8ff112d, Offset: 0x2a58
    // Size: 0x20
    function draw_pathnodes_stop() {
        wait 5;
        level notify(#"draw_pathnode_stop");
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc2c6a070, Offset: 0x2a80
    // Size: 0x120
    function node_get(player) {
        for (;;) {
            waitframe(1);
            origin = get_lookat_origin(player);
            node = getnearestnode(origin);
            if (!isdefined(node)) {
                continue;
            }
            if (player buttonpressed("<dev string:x334>")) {
                return node;
            } else if (player buttonpressed("<dev string:x33d>")) {
                return undefined;
            }
            if (node.type == #"path") {
                draw_pathnode(node, (1, 0, 1));
                continue;
            }
            draw_pathnode(node, (0.85, 0.85, 0.1));
        }
    }

    // Namespace dev/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2dd071f7, Offset: 0x2ba8
    // Size: 0x1a6
    function dev_get_node_pair() {
        player = util::gethostplayer();
        start = undefined;
        while (!isdefined(start)) {
            start = node_get(player);
            if (player buttonpressed("<dev string:x33d>")) {
                level notify(#"draw_pathnode_stop");
                return undefined;
            }
        }
        level thread draw_pathnode_think(start, (0, 1, 0));
        while (player buttonpressed("<dev string:x334>")) {
            waitframe(1);
        }
        end = undefined;
        while (!isdefined(end)) {
            end = node_get(player);
            if (player buttonpressed("<dev string:x33d>")) {
                level notify(#"draw_pathnode_stop");
                return undefined;
            }
        }
        level thread draw_pathnode_think(end, (0, 1, 0));
        level thread draw_pathnodes_stop();
        array = [];
        array[0] = start;
        array[1] = end;
        return array;
    }

    // Namespace dev/dev_shared
    // Params 2, eflags: 0x0
    // Checksum 0x2da89439, Offset: 0x2d58
    // Size: 0x54
    function draw_point(origin, color) {
        if (!isdefined(color)) {
            color = (1, 0, 1);
        }
        sphere(origin, 16, color, 0.25, 0, 16, 1);
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4942385c, Offset: 0x2db8
    // Size: 0xa0
    function point_get(player) {
        for (;;) {
            waitframe(1);
            origin = get_lookat_origin(player);
            if (player buttonpressed("<dev string:x334>")) {
                return origin;
            } else if (player buttonpressed("<dev string:x33d>")) {
                return undefined;
            }
            draw_point(origin, (1, 0, 1));
        }
    }

    // Namespace dev/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0x85b5a6e6, Offset: 0x2e60
    // Size: 0xfc
    function dev_get_point_pair() {
        player = util::gethostplayer();
        start = undefined;
        points = [];
        while (!isdefined(start)) {
            start = point_get(player);
            if (!isdefined(start)) {
                return points;
            }
        }
        while (player buttonpressed("<dev string:x334>")) {
            waitframe(1);
        }
        end = undefined;
        while (!isdefined(end)) {
            end = point_get(player);
            if (!isdefined(end)) {
                return points;
            }
        }
        points[0] = start;
        points[1] = end;
        return points;
    }

#/
