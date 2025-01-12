#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace death_circle;

// Namespace death_circle/death_circle
// Params 0, eflags: 0x2
// Checksum 0xf9c9e70d, Offset: 0x218
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"death_circle", &__init__, undefined, undefined);
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x8ff430e5, Offset: 0x260
// Size: 0x18c
function __init__() {
    level.var_3b2d97c0 = isdefined(getgametypesetting(#"deathcircle")) && getgametypesetting(#"deathcircle");
    level.deathcircles = [];
    level.var_e4356ff1 = 0;
    /#
        level.deathcircletimescale = getdvarfloat(#"deathcircle_timescale", 1);
    #/
    if (!level.var_3b2d97c0) {
        return;
    }
    clientfield::register("scriptmover", "deathcircleflag", 1, 1, "int");
    clientfield::register("toplayer", "deathcircleeffects", 1, 2, "int");
    clientfield::register("allplayers", "outsidedeathcircle", 1, 1, "int");
    callback::on_game_playing(&start);
    /#
        level thread devgui_loop();
        level thread debug_loop();
    #/
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0xfb0a447, Offset: 0x3f8
// Size: 0x62
function function_cb0332a(delaysec) {
    assert(delaysec >= 0, "<invalid>" + "<dev string:x50>");
    /#
        delaysec /= level.deathcircletimescale;
    #/
    level.var_e4356ff1 = delaysec;
}

// Namespace death_circle/death_circle
// Params 7, eflags: 0x0
// Checksum 0x454a871, Offset: 0x468
// Size: 0xbe
function function_6ffbfc9a(origin, radius, damage, damageinterval, waitsec, scalesec, intensity) {
    assert(level.deathcircles.size == 0, "<invalid>" + "<dev string:x92>");
    circle = add_circle(origin, radius, damage, damageinterval, waitsec, scalesec, intensity);
    circle.initial = 1;
}

// Namespace death_circle/death_circle
// Params 9, eflags: 0x0
// Checksum 0xaca0d14b, Offset: 0x530
// Size: 0x1ea
function function_e07f33dc(var_fe01db73, mapwidth, mapheight, radius, damage, damageinterval, waitsec, scalesec, intensity) {
    assert(level.deathcircles.size > 0, "<invalid>" + "<dev string:xde>");
    halfwidth = mapwidth / 2;
    halfheight = mapheight / 2;
    lastcircle = level.deathcircles[level.deathcircles.size - 1];
    var_460f6a63 = lastcircle.radius * 0.01;
    maxlength = lastcircle.radius - radius;
    assert(var_460f6a63 < maxlength, "<invalid>" + "<dev string:x102>");
    origin = function_e316f067(lastcircle.origin, var_460f6a63, maxlength, var_fe01db73, halfwidth, halfheight);
    circle = add_circle(origin, radius, damage, damageinterval, waitsec, scalesec, intensity);
    /#
        circle.var_fe01db73 = var_fe01db73;
        circle.mapwidth = mapwidth;
        circle.mapheight = mapheight;
    #/
}

// Namespace death_circle/death_circle
// Params 6, eflags: 0x0
// Checksum 0x9137d855, Offset: 0x728
// Size: 0x17e
function function_d91772a3(radius, damage, damageinterval, waitsec, scalesec, intensity) {
    assert(level.deathcircles.size > 0, "<invalid>" + "<dev string:xde>");
    lastcircle = level.deathcircles[level.deathcircles.size - 1];
    var_460f6a63 = lastcircle.radius * 0.01;
    maxlength = lastcircle.radius - radius;
    assert(var_460f6a63 < maxlength, "<invalid>" + "<dev string:x102>");
    origin = function_e316f067(lastcircle.origin, var_460f6a63, maxlength, lastcircle.origin, maxlength, maxlength);
    circle = add_circle(origin, radius, damage, damageinterval, waitsec, scalesec, intensity);
}

// Namespace death_circle/death_circle
// Params 5, eflags: 0x0
// Checksum 0xa3f4dab7, Offset: 0x8b0
// Size: 0xd6
function function_73f148f2(damage, damageinterval, waitsec, scalesec, intensity) {
    assert(level.deathcircles.size > 0, "<invalid>" + "<dev string:xde>");
    lastcircle = level.deathcircles[level.deathcircles.size - 1];
    circle = add_circle(lastcircle.origin, 0, damage, damageinterval, waitsec, scalesec, intensity);
    circle.final = 1;
}

// Namespace death_circle/death_circle
// Params 6, eflags: 0x4
// Checksum 0xd912def4, Offset: 0x990
// Size: 0x2c4
function private function_e316f067(lastorigin, mindist, maxdist, var_c5f1124b, halfwidth, halfheight) {
    assert(mindist < maxdist);
    mindistsq = mindist * mindist;
    maxdistsq = maxdist * maxdist;
    right = var_c5f1124b[0] + halfwidth;
    left = var_c5f1124b[0] - halfwidth;
    top = var_c5f1124b[1] + halfheight;
    bottom = var_c5f1124b[1] - halfheight;
    var_81a773d1 = 0;
    while (true) {
        var_81a773d1++;
        x = lastorigin[0] + randomfloatrange(maxdist * -1, maxdist);
        y = lastorigin[1] + randomfloatrange(maxdist * -1, maxdist);
        origin = (x, y, 0);
        distsq = distance2dsquared(lastorigin, origin);
        if (distsq < mindistsq || distsq > maxdistsq) {
            continue;
        }
        if (var_81a773d1 >= 15) {
            return origin;
        }
        if (x > right || x < left || y > top || y < bottom) {
            continue;
        }
        trace = groundtrace(origin + (0, 0, 10000), origin + (0, 0, -10000), 0, undefined);
        if (trace[#"surfacetype"] == "water" || trace[#"surfacetype"] == "watershallow") {
            continue;
        }
        return origin;
    }
}

// Namespace death_circle/death_circle
// Params 7, eflags: 0x4
// Checksum 0xf9b08acf, Offset: 0xc60
// Size: 0x16a
function private add_circle(origin, radius, damage, damageinterval, waitsec, scalesec, intensity = 1) {
    assert(radius <= 150000, "<invalid>" + "<dev string:x196>" + radius + "<dev string:x1a0>" + 150000);
    /#
        waitsec /= level.deathcircletimescale;
        scalesec /= level.deathcircletimescale;
    #/
    circle = {#origin:origin, #radius:radius, #damage:damage, #damageinterval:damageinterval, #waitsec:waitsec, #scalesec:scalesec, #intensity:intensity};
    level.deathcircles[level.deathcircles.size] = circle;
    return circle;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0xc9a0e29e, Offset: 0xdd8
// Size: 0x2c
function function_9aaeec5b() {
    waitframe(1);
    level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 1);
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x4428a719, Offset: 0xe10
// Size: 0x88
function function_4ed71d24() {
    foreach (player in getplayers()) {
        player clientfield::set_player_uimodel("hudItems.distanceFromDeathCircle", 0);
    }
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x0
// Checksum 0xc3d94753, Offset: 0xea0
// Size: 0x1a2
function function_7f066e02(var_4d92fe4d, var_ef751d11) {
    level endoncallback(&function_4ed71d24, #"hash_12a8f2c59a67e4fc", #"hash_712ec7436297a2cd");
    var_b105505f = var_4d92fe4d.radius - var_ef751d11.radius;
    while (true) {
        foreach (player in getplayers()) {
            currentdistance = distance2d(var_ef751d11.origin, player.origin);
            var_8c16bafc = (min(max(var_ef751d11.radius, currentdistance), var_4d92fe4d.radius) - var_ef751d11.radius) / var_b105505f;
            player clientfield::set_player_uimodel("hudItems.distanceFromDeathCircle", 1 - var_8c16bafc);
        }
        waitframe(1);
    }
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x15d281cb, Offset: 0x1050
// Size: 0x694
function start() {
    level endoncallback(&cleanup_circle, #"game_ended", #"hash_12a8f2c59a67e4fc");
    if (!level.var_3b2d97c0 || level.deathcircles.size <= 0) {
        return;
    }
    /#
        testcircleradius = getdvarint(#"testcircleradius", 0);
        if (testcircleradius > 0) {
            level.deathcircles = [];
            level.var_e4356ff1 = 0;
            intensity = getdvarint(#"hash_16271dbe4d00b41e", 1);
            function_6ffbfc9a(level.mapcenter, testcircleradius, 0, 100, 100000, 1, intensity);
            level thread function_f9787744();
        }
    #/
    wait level.var_e4356ff1;
    initcircle = level.deathcircles[0];
    level.deathcircle = spawn("script_model", initcircle.origin);
    level.deathcircle setmodel("tag_origin");
    level.deathcircle setscale(initcircle.radius / 15000);
    level.deathcircle.radius = initcircle.radius;
    level.deathcircle clientfield::set("deathcircleflag", 1);
    level.deathcircle.damage = initcircle.damage;
    level.deathcircle.damageinterval = initcircle.damageinterval;
    level.deathcircle.intensity = initcircle.intensity;
    level thread function_24e0382a();
    circle = undefined;
    var_a46c7779 = undefined;
    level flagsys::set(#"hash_405e46788e83af41");
    for (i = 0; i < level.deathcircles.size; i++) {
        level.deathcircleindex = i;
        circle = level.deathcircles[i];
        nextcircle = level.deathcircles[i + 1];
        if (isdefined(nextcircle)) {
            level notify(#"hash_1ff3496c9049969");
            if (isdefined(level.var_9cf874df)) {
                [[ level.var_9cf874df ]]();
            }
            if (nextcircle.radius > 0) {
                if (!isdefined(var_a46c7779)) {
                    var_a46c7779 = spawn("script_model", nextcircle.origin);
                    var_a46c7779 setmodel("tag_origin");
                    var_a46c7779.team = #"neutral";
                    var_a46c7779 clientfield::set("deathcircleflag", 1);
                } else {
                    var_a46c7779 dontinterpolate();
                    var_a46c7779.origin = nextcircle.origin;
                }
                var_a46c7779 setscale(nextcircle.radius / 15000);
            } else if (isdefined(var_a46c7779)) {
                var_a46c7779 delete();
            }
            setmatchflag("bomb_timer_a", 1);
            setbombtimer("A", gettime() + 1000 + int(circle.waitsec * 1000));
            level clientfield::set_world_uimodel("hudItems.warzone.collapseProgress", 0);
            level thread function_7f066e02(circle, nextcircle);
            waitframe(1);
            function_9aaeec5b();
            level countdown(circle.waitsec, i);
            setmatchflag("bomb_timer_a", 0);
            level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 2);
            level.deathcircle.damage = circle.damage;
            level.deathcircle.damageinterval = circle.damageinterval;
            level.deathcircle.intensity = circle.intensity;
            level.deathcircle function_29c0c56e(circle.scalesec, nextcircle.radius, nextcircle.origin);
            level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 0);
            level notify(#"hash_712ec7436297a2cd");
            continue;
        }
        if (isdefined(var_a46c7779)) {
            var_a46c7779 delete();
        }
    }
    if (circle.radius <= 0) {
        level.deathcircle hide();
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0x44b09a7d, Offset: 0x16f0
// Size: 0x2c
function private cleanup_circle(notifyhash) {
    level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 0);
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x4
// Checksum 0xa4b08d30, Offset: 0x1728
// Size: 0x11c
function private countdown(waitsec, circleindex) {
    if (circleindex == 0) {
        voiceevent("warCircleDetectedFirst");
    } else if (circleindex + 2 >= level.deathcircles.size) {
        voiceevent("warCircleDetectedLast");
    } else {
        voiceevent("warCircleDetected");
    }
    if (waitsec > 15) {
        wait waitsec - 15;
        voiceevent("warCircleCollapseImminent");
        wait 15;
    } else {
        wait waitsec;
    }
    voiceevent("warCircleCollapseOccurring");
    playsoundatposition(#"hash_3fb30e7a85b2bf7e", (0, 0, 0));
}

// Namespace death_circle/death_circle
// Params 3, eflags: 0x4
// Checksum 0xb8e66454, Offset: 0x1850
// Size: 0x204
function private function_29c0c56e(scalesec, newradius, neworigin) {
    level endon(#"game_ended", #"hash_12a8f2c59a67e4fc");
    time = gettime();
    endtime = time + int(scalesec * 1000);
    level clientfield::set_world_uimodel("hudItems.warzone.collapseProgress", 0);
    self moveto(neworigin, scalesec);
    scaledelta = newradius - self.radius;
    frames = scalesec / float(function_f9f48566()) / 1000;
    framedelta = scaledelta / frames;
    progress = 0;
    var_fa5fc31b = 1 / frames;
    while (time < endtime) {
        self.radius += framedelta;
        if (self.radius <= 0) {
            break;
        }
        self setscale(self.radius / 15000);
        progress += var_fa5fc31b;
        level clientfield::set_world_uimodel("hudItems.warzone.collapseProgress", progress);
        waitframe(1);
        time = gettime();
    }
    level clientfield::set_world_uimodel("hudItems.warzone.collapseProgress", 1);
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x4
// Checksum 0xeffc32b1, Offset: 0x1a60
// Size: 0x370
function private function_24e0382a() {
    level endoncallback(&cleanup_feedback, #"game_ended", #"hash_12a8f2c59a67e4fc");
    var_ec8d3216 = gettime() + level.deathcircle.damageinterval * 1000;
    while (true) {
        radiussq = level.deathcircle.radius * level.deathcircle.radius;
        origin = level.deathcircle.origin;
        dodamage = gettime() >= var_ec8d3216;
        foreach (player in getplayers()) {
            if (!isalive(player)) {
                player function_159f305a(0);
                player clientfield::set("outsidedeathcircle", 0);
                player hide_effects();
                continue;
            }
            distsq = distance2dsquared(player.origin, origin);
            if (distsq > radiussq) {
                player function_159f305a(1);
                player clientfield::set("outsidedeathcircle", 1);
                player show_effects(level.deathcircle.intensity);
                if (dodamage) {
                    damage = level.deathcircle.damage;
                    if (player hasperk(#"specialty_outlander")) {
                        damage = int(ceil(damage * 0.75));
                    }
                    player dodamage(damage, origin, level.deathcircle, undefined, undefined, "MOD_DEATH_CIRCLE");
                }
                continue;
            }
            player function_159f305a(0);
            player clientfield::set("outsidedeathcircle", 0);
            player hide_effects();
        }
        if (dodamage) {
            var_ec8d3216 = gettime() + level.deathcircle.damageinterval * 1000;
        }
        util::wait_network_frame();
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0x794e950f, Offset: 0x1dd8
// Size: 0xa8
function private cleanup_feedback(notifyhash) {
    foreach (player in getplayers()) {
        player function_159f305a(0);
        player hide_effects();
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x388df661, Offset: 0x1e88
// Size: 0x2c
function show_effects(intensity) {
    self clientfield::set_to_player("deathcircleeffects", intensity);
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x30875c91, Offset: 0x1ec0
// Size: 0x24
function hide_effects() {
    self clientfield::set_to_player("deathcircleeffects", 0);
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x3d3dd2d7, Offset: 0x1ef0
// Size: 0x3da
function function_313433f() {
    if (!isdefined(level.deathcircle)) {
        return;
    }
    for (i = 0; i < level.deathcircles.size; i++) {
        assert(i < 14, "<dev string:x1d2>");
        circle = level.deathcircles[i];
        match_record::function_3fad861b(#"death_circle", i, #"origin", circle.origin);
        match_record::set_stat(#"death_circle", i, #"radius", circle.radius);
        match_record::set_stat(#"death_circle", i, #"damage", circle.damage);
        match_record::set_stat(#"death_circle", i, #"damage_interval", circle.damageinterval);
        match_record::set_stat(#"death_circle", i, #"wait_sec", circle.waitsec);
        match_record::set_stat(#"death_circle", i, #"scale_sec", circle.scalesec);
        match_record::set_stat(#"death_circle", i, #"final", 0);
        if (i == level.deathcircleindex) {
            i++;
            match_record::function_3fad861b(#"death_circle", i, #"origin", level.deathcircle.origin);
            match_record::set_stat(#"death_circle", i, #"radius", level.deathcircle.radius);
            match_record::set_stat(#"death_circle", i, #"damage", level.deathcircle.damage);
            match_record::set_stat(#"death_circle", i, #"damage_interval", level.deathcircle.damageinterval);
            match_record::set_stat(#"death_circle", i, #"wait_sec", circle.waitsec);
            match_record::set_stat(#"death_circle", i, #"scale_sec", circle.scalesec);
            match_record::set_stat(#"death_circle", i, #"final", 1);
            break;
        }
    }
}

/#

    // Namespace death_circle/death_circle
    // Params 0, eflags: 0x4
    // Checksum 0xec5a8a3a, Offset: 0x22d8
    // Size: 0x29e
    function private devgui_loop() {
        level endon(#"game_ended");
        while (!canadddebugcommand()) {
            waitframe(1);
        }
        adddebugcommand("<dev string:x209>");
        adddebugcommand("<dev string:x22a>");
        adddebugcommand("<dev string:x258>");
        adddebugcommand("<dev string:x282>");
        adddebugcommand("<dev string:x2a7>");
        if (getdvarint(#"testcircleradius", 0) > 0) {
            adddebugcommand("<dev string:x2ca>");
            adddebugcommand("<dev string:x313>");
        }
        adddebugcommand("<dev string:x362>");
        adddebugcommand("<dev string:x3a8>");
        adddebugcommand("<dev string:x3f8>");
        adddebugcommand("<dev string:x43c>");
        adddebugcommand("<dev string:x486>");
        while (true) {
            wait 0.25;
            dvarstr = getdvarstring(#"devgui_deathcircle", "<dev string:x4cc>");
            if (dvarstr == "<dev string:x4cc>") {
                continue;
            }
            setdvar(#"devgui_deathcircle", "<dev string:x4cc>");
            args = strtok(dvarstr, "<dev string:x4cd>");
            switch (args[0]) {
            case #"clear":
                devgui_clear();
                break;
            case #"shuffle":
                devgui_shuffle();
                break;
            }
        }
    }

    // Namespace death_circle/death_circle
    // Params 0, eflags: 0x4
    // Checksum 0x76a14a41, Offset: 0x2580
    // Size: 0x4c
    function private devgui_clear() {
        level notify(#"hash_12a8f2c59a67e4fc");
        if (isdefined(level.deathcircle)) {
            level.deathcircle delete();
        }
    }

    // Namespace death_circle/death_circle
    // Params 0, eflags: 0x4
    // Checksum 0x54a29d13, Offset: 0x25d8
    // Size: 0x2d8
    function private debug_loop() {
        level endon(#"game_ended");
        while (true) {
            if (getdvarint(#"deathcircle_debug", 0)) {
                var_bdc33e21 = getdvarint(#"hash_411ea20c685d88c1", 1);
                debugindex = getdvarint(#"hash_31a5138991bbbf63", -1);
                maxindex = level.deathcircles.size - 1;
                if (debugindex >= 0) {
                    circle = level.deathcircles[debugindex];
                    if (isdefined(circle)) {
                        color = circle_color(debugindex, maxindex);
                        draw_circle(circle, debugindex, var_bdc33e21, color);
                    }
                } else {
                    minimaporigins = getentarray("<dev string:x4cf>", "<dev string:x4de>");
                    foreach (minimaporigin in minimaporigins) {
                        sphere(minimaporigin.origin, 50 * var_bdc33e21, (0, 1, 1));
                        print3d(minimaporigin.origin, "<dev string:x4e9>", (1, 1, 1), 1, var_bdc33e21);
                    }
                    index = 0;
                    foreach (circle in level.deathcircles) {
                        color = circle_color(index, maxindex);
                        draw_circle(circle, index, var_bdc33e21, color);
                        index++;
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace death_circle/death_circle
    // Params 0, eflags: 0x4
    // Checksum 0xca099ced, Offset: 0x28b8
    // Size: 0xec
    function private function_f9787744() {
        level endon(#"game_ended");
        waitframe(1);
        while (isdefined(level.deathcircle)) {
            radius = getdvarint(#"testcircleradius", 0);
            intensity = getdvarint(#"hash_16271dbe4d00b41e", 1);
            level.deathcircle.radius = radius;
            level.deathcircle setscale(radius / 15000);
            level.deathcircle.intensity = intensity;
            waitframe(1);
        }
    }

    // Namespace death_circle/death_circle
    // Params 0, eflags: 0x4
    // Checksum 0x15f02b64, Offset: 0x29b0
    // Size: 0x268
    function private devgui_shuffle() {
        devgui_clear();
        circles = level.deathcircles;
        level.deathcircles = [];
        foreach (circle in circles) {
            if (isdefined(circle.initial) && circle.initial) {
                function_6ffbfc9a(circle.origin, circle.radius, circle.damage, circle.damageinterval, circle.waitsec, circle.scalesec);
                continue;
            }
            if (isdefined(circle.final) && circle.final) {
                function_73f148f2(circle.damage, circle.damageinterval, circle.waitsec, circle.scalesec);
                continue;
            }
            if (isdefined(circle.var_fe01db73) && isdefined(circle.mapwidth) && isdefined(circle.mapheight)) {
                function_e07f33dc(circle.var_fe01db73, circle.mapwidth, circle.mapheight, circle.radius, circle.damage, circle.damageinterval, circle.waitsec, circle.scalesec);
                continue;
            }
            function_d91772a3(circle.radius, circle.damage, circle.damageinterval, circle.waitsec, circle.scalesec);
        }
    }

    // Namespace death_circle/death_circle
    // Params 1, eflags: 0x4
    // Checksum 0x2aa0b4a, Offset: 0x2c20
    // Size: 0x2a2
    function private simulate(var_761814fa) {
        sim_count = 1000;
        var_f74c2437 = 100;
        assert(var_761814fa);
        var_4660b0c0 = [];
        for (i = 0; i < sim_count; i++) {
            devgui_shuffle();
            for (c = 0; c < level.deathcircles.size; c++) {
                circle = {#origin_x:level.deathcircles[c].origin[0], #origin_y:level.deathcircles[c].origin[1], #radius:level.deathcircles[c].radius, #index:c};
                if (!isdefined(var_4660b0c0)) {
                    var_4660b0c0 = [];
                } else if (!isarray(var_4660b0c0)) {
                    var_4660b0c0 = array(var_4660b0c0);
                }
                var_4660b0c0[var_4660b0c0.size] = circle;
            }
            if (var_4660b0c0.size + level.deathcircles.size >= var_f74c2437) {
                var_e1accece = {#var_35526508:var_761814fa};
                function_b1f6086c(#"hash_3a9b483e717d26be", #"info", var_e1accece, #"circles", var_4660b0c0);
                wait 1;
                var_4660b0c0 = [];
            }
        }
        if (var_4660b0c0.size >= 0) {
            var_e1accece = {#var_35526508:var_761814fa};
            function_b1f6086c(#"hash_3a9b483e717d26be", #"info", var_e1accece, #"circles", var_4660b0c0);
            wait 1;
        }
    }

    // Namespace death_circle/death_circle
    // Params 4, eflags: 0x4
    // Checksum 0xdbe4fb6f, Offset: 0x2ed0
    // Size: 0x594
    function private draw_circle(circle, index, var_bdc33e21, color) {
        var_ebc4c610 = 30 * var_bdc33e21;
        printoffset = (0, 0, -15 * var_bdc33e21);
        printorigin = circle.origin;
        print3d(printorigin, index, (1, 1, 1), 1, var_bdc33e21);
        printorigin += printoffset;
        print3d(printorigin, "<dev string:x4f8>" + circle.radius, (1, 1, 1), 1, var_bdc33e21);
        printorigin += printoffset;
        print3d(printorigin, "<dev string:x501>" + circle.damage, (1, 1, 1), 1, var_bdc33e21);
        printorigin += printoffset;
        print3d(printorigin, "<dev string:x50a>" + circle.damageinterval, (1, 1, 1), 1, var_bdc33e21);
        printorigin += printoffset;
        print3d(printorigin, "<dev string:x51c>" + (isdefined(circle.waitsec) ? circle.waitsec : 0), (1, 1, 1), 1, var_bdc33e21);
        printorigin += printoffset;
        print3d(printorigin, "<dev string:x527>" + (isdefined(circle.scalesec) ? circle.scalesec : 0), (1, 1, 1), 1, var_bdc33e21);
        printorigin += printoffset;
        sphere(circle.origin, var_ebc4c610, color);
        circle(circle.origin, circle.radius, color, 0, 1);
        if (isdefined(circle.var_fe01db73) && isdefined(circle.mapwidth) && isdefined(circle.mapheight)) {
            var_ebc4c610 = 20 * var_bdc33e21;
            halfwidth = circle.mapwidth / 2;
            halfheight = circle.mapheight / 2;
            var_4188eee3 = circle.var_fe01db73 + (halfwidth, halfheight, 0);
            var_ee14b719 = circle.var_fe01db73 + (halfwidth, halfheight * -1, 0);
            var_ff8b2366 = circle.var_fe01db73 + (halfwidth * -1, halfheight * -1, 0);
            var_3258ee54 = circle.var_fe01db73 + (halfwidth * -1, halfheight, 0);
            sphere(circle.var_fe01db73, var_ebc4c610, (1, 0, 1));
            print3d(circle.var_fe01db73, "<dev string:x533>", (1, 1, 1), 1, var_bdc33e21);
            sphere(var_4188eee3, var_ebc4c610, (1, 0, 1));
            print3d(var_4188eee3, "<dev string:x540>", (1, 1, 1), 1, var_bdc33e21);
            sphere(var_ee14b719, var_ebc4c610, (1, 0, 1));
            print3d(var_ee14b719, "<dev string:x543>", (1, 1, 1), 1, var_bdc33e21);
            sphere(var_ff8b2366, var_ebc4c610, (1, 0, 1));
            print3d(var_ff8b2366, "<dev string:x546>", (1, 1, 1), 1, var_bdc33e21);
            sphere(var_3258ee54, var_ebc4c610, (1, 0, 1));
            print3d(var_3258ee54, "<dev string:x549>", (1, 1, 1), 1, var_bdc33e21);
            line(var_4188eee3, var_ee14b719, (1, 0, 1));
            line(var_ee14b719, var_ff8b2366, (1, 0, 1));
            line(var_ff8b2366, var_3258ee54, (1, 0, 1));
            line(var_3258ee54, var_4188eee3, (1, 0, 1));
        }
    }

    // Namespace death_circle/death_circle
    // Params 2, eflags: 0x0
    // Checksum 0x1494d568, Offset: 0x3470
    // Size: 0x12c
    function circle_color(circleindex, maxindex) {
        colorscale = array((0, 1, 0), (1, 0.5, 0), (1, 1, 0), (1, 0, 0));
        if (circleindex >= maxindex) {
            return colorscale[colorscale.size - 1];
        } else if (circleindex <= 0) {
            return colorscale[0];
        }
        var_16c0bcef = circleindex * colorscale.size / maxindex;
        var_16c0bcef -= 1;
        colorindex = int(var_16c0bcef);
        colorfrac = var_16c0bcef - colorindex;
        utilitycolor = vectorlerp(colorscale[colorindex], colorscale[colorindex + 1], colorfrac);
        return utilitycolor;
    }

#/
