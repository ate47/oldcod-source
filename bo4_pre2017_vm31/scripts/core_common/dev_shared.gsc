#using scripts/core_common/array_shared;
#using scripts/core_common/colors_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace dev;

/#

    // Namespace dev/dev_shared
    // Params 5, eflags: 0x0
    // Checksum 0xbda7e6c8, Offset: 0x180
    // Size: 0xcc
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
    // Checksum 0x3ef275de, Offset: 0x258
    // Size: 0xac4
    function updateminimapsetting() {
        requiredmapaspectratio = getdvarfloat("<dev string:x28>");
        if (!isdefined(level.minimapheight)) {
            setdvar("<dev string:x43>", "<dev string:x56>");
            level.minimapheight = 0;
        }
        minimapheight = getdvarfloat("<dev string:x43>");
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
                    corners = getentarray("<dev string:x58>", "<dev string:x67>");
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
                        setdvar("<dev string:x72>", 0);
                        setdvar("<dev string:x7d>", 0);
                        setdvar("<dev string:x87>", 0);
                        setdvar("<dev string:x92>", 0);
                        setdvar("<dev string:x9c>", 0);
                        setdvar("<dev string:xa2>", 0);
                        setdvar("<dev string:xb0>", znear);
                        setdvar("<dev string:xb8>", 0.1);
                        setdvar("<dev string:xc8>", 0);
                        setdvar("<dev string:xd7>", 1);
                        setdvar("<dev string:xe1>", 90);
                        setdvar("<dev string:xf8>", 0);
                        setdvar("<dev string:x10d>", angle);
                        setdvar("<dev string:x114>", 1);
                        setdvar("<dev string:x123>", 1);
                        setdvar("<dev string:x135>", 0.1);
                        setdvar("<dev string:x14a>", 0);
                        setdvar("<dev string:x157>", "<dev string:x56>");
                        thread drawminimapbounds(viewpos, mincorner, maxcorner);
                    } else {
                        println("<dev string:x16a>");
                    }
                    return;
                }
                setdvar("<dev string:x43>", "<dev string:x56>");
            }
        }
    }

    // Namespace dev/dev_shared
    // Params 2, eflags: 0x0
    // Checksum 0xc5269e54, Offset: 0xd28
    // Size: 0x4a
    function vecscale(vec, scalar) {
        return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
    }

    // Namespace dev/dev_shared
    // Params 3, eflags: 0x0
    // Checksum 0x4704c5dc, Offset: 0xd80
    // Size: 0x3c6
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
            print3d(toppos, "<dev string:x1b3>", (1, 1, 1), 1, textscale);
            waitframe(1);
        }
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb144b68, Offset: 0x1150
    // Size: 0x1e6
    function minimapwarn(corners) {
        threshold = 10;
        width = abs(corners[0].origin[0] - corners[1].origin[0]);
        width = int(width);
        height = abs(corners[0].origin[1] - corners[1].origin[1]);
        height = int(height);
        if (abs(width - height) > threshold) {
            for (;;) {
                iprintln("<dev string:x1c0>" + width + "<dev string:x1f9>" + height + "<dev string:x203>");
                if (height > width) {
                    scale = height / width;
                    iprintln("<dev string:x206>" + scale + "<dev string:x237>");
                } else {
                    scale = width / height;
                    iprintln("<dev string:x206>" + scale + "<dev string:x259>");
                }
                wait 10;
            }
        }
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc361eaa2, Offset: 0x1340
    // Size: 0xaa
    function function_dfab5e4f(var_9a65c47f) {
        foreach (player in getplayers()) {
            player setcharacterhelmetstyle(var_9a65c47f);
        }
    }

    // Namespace dev/dev_shared
    // Params 2, eflags: 0x0
    // Checksum 0xa34178de, Offset: 0x13f8
    // Size: 0xca
    function function_5fcfe5a4(character_index, body_index) {
        foreach (player in getplayers()) {
            player setcharacterbodytype(character_index);
            player setcharacterbodystyle(body_index);
        }
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6a1f66d8, Offset: 0x14d0
    // Size: 0x21e
    function body_customization_process_command(character_index) {
        split = strtok(character_index, "<dev string:x27b>");
        switch (split.size) {
        case 1:
        default:
            command0 = strtok(split[0], "<dev string:x27d>");
            character_index = int(command0[1]);
            body_index = 0;
            var_9a65c47f = 0;
            function_dfab5e4f(var_9a65c47f);
            function_5fcfe5a4(character_index, body_index);
            break;
        case 2:
            command0 = strtok(split[0], "<dev string:x27d>");
            character_index = int(command0[1]);
            command1 = strtok(split[1], "<dev string:x27d>");
            if (command1[0] == "<dev string:x27f>") {
                body_index = int(command1[1]);
                function_5fcfe5a4(character_index, body_index);
            } else if (command1[0] == "<dev string:x289>") {
                var_9a65c47f = int(command1[1]);
                function_dfab5e4f(var_9a65c47f);
            }
            break;
        }
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0x28807c62, Offset: 0x16f8
    // Size: 0x2cc
    function body_customization_populate(mode) {
        bodies = getallcharacterbodies(mode);
        body_customization_devgui_base = "<dev string:x290>";
        foreach (playerbodytype in bodies) {
            body_name = makelocalizedstring(getcharacterdisplayname(playerbodytype, mode)) + "<dev string:x2b7>" + getcharacterassetname(playerbodytype, mode) + "<dev string:x2ba>";
            adddebugcommand(body_customization_devgui_base + body_name + "<dev string:x2bc>" + "<dev string:x2c5>" + "<dev string:x2cd>" + "<dev string:x2d9>" + "<dev string:x2db>" + playerbodytype + "<dev string:x2e5>");
            for (i = 0; i < getcharacterbodymodelcount(playerbodytype, mode); i++) {
                adddebugcommand(body_customization_devgui_base + body_name + "<dev string:x2e9>" + i + "<dev string:x2c5>" + "<dev string:x2cd>" + "<dev string:x2d9>" + "<dev string:x2db>" + playerbodytype + "<dev string:x27b>" + "<dev string:x2fc>" + i + "<dev string:x2e5>");
            }
            for (i = 0; i < getcharacterhelmetmodelcount(playerbodytype, mode); i++) {
                adddebugcommand(body_customization_devgui_base + body_name + "<dev string:x307>" + i + "<dev string:x2c5>" + "<dev string:x2cd>" + "<dev string:x2d9>" + "<dev string:x2db>" + playerbodytype + "<dev string:x27b>" + "<dev string:x318>" + i + "<dev string:x2e5>");
            }
        }
    }

    // Namespace dev/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc5ccd120, Offset: 0x19d0
    // Size: 0x98
    function body_customization_devgui(mode) {
        body_customization_populate(mode);
        for (;;) {
            character_index = getdvarstring("<dev string:x2cd>");
            if (character_index != "<dev string:x320>") {
                body_customization_process_command(character_index);
            }
            setdvar("<dev string:x2cd>", "<dev string:x320>");
            wait 0.5;
        }
    }

    // Namespace dev/dev_shared
    // Params 2, eflags: 0x0
    // Checksum 0xea669421, Offset: 0x1a70
    // Size: 0xdc
    function add_perk_devgui(name, specialties) {
        perk_devgui_base = "<dev string:x321>";
        perk_name = makelocalizedstring(name);
        test = perk_devgui_base + perk_name + "<dev string:x2c5>" + "<dev string:x345>" + "<dev string:x2d9>" + specialties + "<dev string:x2e5>";
        adddebugcommand(perk_devgui_base + perk_name + "<dev string:x2c5>" + "<dev string:x345>" + "<dev string:x2d9>" + specialties + "<dev string:x2e5>");
    }

#/
