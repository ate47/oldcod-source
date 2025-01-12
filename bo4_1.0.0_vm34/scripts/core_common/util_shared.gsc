#using script_51e19a6cd0b4d30f;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;

#namespace util;

// Namespace util/util_shared
// Params 0, eflags: 0x2
// Checksum 0xe9e1c23a, Offset: 0x2c8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"util_shared", &__init__, &__main__, undefined);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x7974607d, Offset: 0x318
// Size: 0x64
function __init__() {
    level.var_b5db3a4 = function_f9f48566();
    function_2b9d78e6();
    function_758636aa();
    register_clientfields();
    namespace_fe84c968::init();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x2aa26625, Offset: 0x388
// Size: 0x2c
function __main__() {
    system::wait_till("all");
    function_4fd63077();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4ba6e29a, Offset: 0x3c0
// Size: 0x64
function register_clientfields() {
    clientfield::register("world", "cf_team_mapping", 1, 1, "int");
    clientfield::register("world", "preload_frontend", 1, 1, "int");
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa2845391, Offset: 0x430
    // Size: 0xa4
    function error(msg) {
        println("<dev string:x30>", msg);
        if (!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame()) {
            waitframe(1);
        }
        if (getdvar(#"debug", 0)) {
            assertmsg("<dev string:x3b>");
        }
    }

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7907f33f, Offset: 0x4e0
    // Size: 0x34
    function warning(msg) {
        println("<dev string:x68>" + msg);
    }

#/

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x5f5a3bda, Offset: 0x520
// Size: 0x2c
function empty(a, b, c, d, e) {
    
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xb96bc6df, Offset: 0x558
// Size: 0xf6
function wait_network_frame(n_count = 1) {
    if (numremoteclients()) {
        for (i = 0; i < n_count; i++) {
            snapshot_ids = getsnapshotindexarray();
            acked = undefined;
            for (n_tries = 0; !isdefined(acked) && n_tries < 5; n_tries++) {
                level waittill(#"snapacknowledged");
                acked = snapshotacknowledged(snapshot_ids);
            }
        }
        return;
    }
    wait 0.1 * n_count;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xbc1c8b28, Offset: 0x658
// Size: 0x54
function preload_frontend() {
    level clientfield::set("preload_frontend", 1);
    wait_network_frame();
    level clientfield::set("preload_frontend", 0);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x260f7c4e, Offset: 0x6b8
// Size: 0x46
function clear_streamer_hint() {
    if (isdefined(self.streamer_hint)) {
        self.streamer_hint delete();
        self.streamer_hint = undefined;
    }
    self notify(#"wait_clear_streamer_hint");
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xfd43d064, Offset: 0x708
// Size: 0x44
function wait_clear_streamer_hint(lifetime) {
    self endon(#"wait_clear_streamer_hint");
    wait lifetime;
    if (isdefined(self)) {
        self clear_streamer_hint();
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x80e21597, Offset: 0x758
// Size: 0x19c
function create_streamer_hint(origin, angles, value, lifetime) {
    if (self == level) {
        foreach (player in getplayers()) {
            player clear_streamer_hint();
        }
    }
    self clear_streamer_hint();
    self.streamer_hint = createstreamerhint(origin, value);
    if (isdefined(angles)) {
        self.streamer_hint.angles = angles;
    }
    if (self != level) {
        self.streamer_hint setinvisibletoall();
        self.streamer_hint setvisibletoplayer(self);
    }
    self.streamer_hint setincludemeshes(1);
    self notify(#"wait_clear_streamer_hint");
    if (isdefined(lifetime) && lifetime > 0) {
        self thread wait_clear_streamer_hint(lifetime);
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x26cb2f85, Offset: 0x900
// Size: 0x2c8
function streamer_wait(n_stream_request_id, n_wait_frames = 0, n_timeout = 15, str_team) {
    /#
        if (getdvarint(#"cg_drawfps", 1) != 0) {
            n_timeout = 1;
        }
    #/
    if (n_wait_frames > 0) {
        wait_network_frame(n_wait_frames);
    }
    timeout = gettime() + int(n_timeout * 1000);
    if (self == level) {
        n_num_streamers_ready = 0;
        do {
            wait_network_frame();
            n_num_streamers_ready = 0;
            if (isdefined(str_team)) {
                a_players = get_players(str_team);
            } else {
                a_players = getplayers();
            }
            foreach (player in a_players) {
                if (isdefined(n_stream_request_id) ? player isstreamerready(n_stream_request_id) : player isstreamerready()) {
                    n_num_streamers_ready++;
                }
            }
            if (n_timeout > 0 && gettime() > timeout) {
                /#
                    if (n_timeout > 5) {
                        iprintln("<dev string:x74>");
                    }
                #/
                break;
            }
        } while (n_num_streamers_ready < max(1, a_players.size));
        return;
    }
    self endon(#"disconnect");
    do {
        wait_network_frame();
        if (n_timeout > 0 && gettime() > timeout) {
            break;
        }
    } while (!(isdefined(n_stream_request_id) ? self isstreamerready(n_stream_request_id) : self isstreamerready()));
}

/#

    // Namespace util/util_shared
    // Params 3, eflags: 0x0
    // Checksum 0x8eca5f75, Offset: 0xbd0
    // Size: 0x7c
    function draw_debug_line(start, end, timer) {
        for (i = 0; i < timer * 20; i++) {
            line(start, end, (1, 1, 0.5));
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 6, eflags: 0x0
    // Checksum 0x867f97b9, Offset: 0xc58
    // Size: 0x9c
    function debug_line(start, end, color, alpha, depthtest, duration) {
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        if (!isdefined(depthtest)) {
            depthtest = 0;
        }
        if (!isdefined(duration)) {
            duration = 100;
        }
        line(start, end, color, alpha, depthtest, duration);
    }

    // Namespace util/util_shared
    // Params 8, eflags: 0x0
    // Checksum 0xf9810a2, Offset: 0xd00
    // Size: 0xc4
    function debug_spherical_cone(origin, domeapex, angle, slices, color, alpha, depthtest, duration) {
        if (!isdefined(slices)) {
            slices = 10;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        if (!isdefined(depthtest)) {
            depthtest = 0;
        }
        if (!isdefined(duration)) {
            duration = 100;
        }
        sphericalcone(origin, domeapex, angle, slices, color, alpha, depthtest, duration);
    }

    // Namespace util/util_shared
    // Params 5, eflags: 0x0
    // Checksum 0x8f7a244d, Offset: 0xdd0
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

    // Namespace util/util_shared
    // Params 5, eflags: 0x0
    // Checksum 0x61926119, Offset: 0xe98
    // Size: 0xec
    function plot_points(plotpoints, r, g, b, timer) {
        lastpoint = plotpoints[0];
        if (!isdefined(r)) {
            r = 1;
        }
        if (!isdefined(g)) {
            g = 1;
        }
        if (!isdefined(b)) {
            b = 1;
        }
        if (!isdefined(timer)) {
            timer = 0.05;
        }
        for (i = 1; i < plotpoints.size; i++) {
            thread draw_line_for_time(lastpoint, plotpoints[i], r, g, b, timer);
            lastpoint = plotpoints[i];
        }
    }

    // Namespace util/util_shared
    // Params 4, eflags: 0x0
    // Checksum 0xca7cd329, Offset: 0xf90
    // Size: 0x2ac
    function draw_arrow_time(start, end, color, timer) {
        level endon(#"newpath");
        pts = [];
        angles = vectortoangles(start - end);
        right = anglestoright(angles);
        forward = anglestoforward(angles);
        up = anglestoup(angles);
        dist = distance(start, end);
        arrow = [];
        arrow[0] = start;
        arrow[1] = start + vectorscale(right, dist * 0.1) + vectorscale(forward, dist * -0.1);
        arrow[2] = end;
        arrow[3] = start + vectorscale(right, dist * -1 * 0.1) + vectorscale(forward, dist * -0.1);
        arrow[4] = start;
        arrow[5] = start + vectorscale(up, dist * 0.1) + vectorscale(forward, dist * -0.1);
        arrow[6] = end;
        arrow[7] = start + vectorscale(up, dist * -1 * 0.1) + vectorscale(forward, dist * -0.1);
        arrow[8] = start;
        r = color[0];
        g = color[1];
        b = color[2];
        plot_points(arrow, r, g, b, timer);
    }

    // Namespace util/util_shared
    // Params 3, eflags: 0x0
    // Checksum 0x27b18761, Offset: 0x1248
    // Size: 0x1f6
    function draw_arrow(start, end, color) {
        level endon(#"newpath");
        pts = [];
        angles = vectortoangles(start - end);
        right = anglestoright(angles);
        forward = anglestoforward(angles);
        dist = distance(start, end);
        arrow = [];
        arrow[0] = start;
        arrow[1] = start + vectorscale(right, dist * 0.05) + vectorscale(forward, dist * -0.2);
        arrow[2] = end;
        arrow[3] = start + vectorscale(right, dist * -1 * 0.05) + vectorscale(forward, dist * -0.2);
        for (p = 0; p < 4; p++) {
            nextpoint = p + 1;
            if (nextpoint >= 4) {
                nextpoint = 0;
            }
            line(arrow[p], arrow[nextpoint], color, 1);
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x76e7352a, Offset: 0x1448
    // Size: 0x1d6
    function debugorigin() {
        self notify(#"debug origin");
        self endon(#"debug origin");
        self endon(#"death");
        for (;;) {
            forward = anglestoforward(self.angles);
            forwardfar = vectorscale(forward, 30);
            forwardclose = vectorscale(forward, 20);
            right = anglestoright(self.angles);
            left = vectorscale(right, -10);
            right = vectorscale(right, 10);
            line(self.origin, self.origin + forwardfar, (0.9, 0.7, 0.6), 0.9);
            line(self.origin + forwardfar, self.origin + forwardclose + right, (0.9, 0.7, 0.6), 0.9);
            line(self.origin + forwardfar, self.origin + forwardclose + left, (0.9, 0.7, 0.6), 0.9);
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 6, eflags: 0x0
    // Checksum 0x163a7e1d, Offset: 0x1628
    // Size: 0xb6
    function draw_line_for_time(org1, org2, r, g, b, timer) {
        timer = gettime() + timer * 1000;
        while (gettime() < timer) {
            line(org1, org2, (r, g, b), 1);
            recordline(org1, org2, (1, 1, 1), "<dev string:xc9>");
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 6, eflags: 0x0
    // Checksum 0x51cff63e, Offset: 0x16e8
    // Size: 0x16c
    function function_60e3cc9(radius1, radius2, time, color, origin, normal) {
        if (!isdefined(color)) {
            color = (0, 1, 0);
        }
        circleres = 6;
        circleinc = 360 / circleres;
        circleres++;
        plotpoints = [];
        rad = 0;
        radius = radius2;
        angletoplayer = vectortoangles(normal);
        for (i = 0; i < circleres; i++) {
            plotpoints[plotpoints.size] = origin + vectorscale(anglestoforward(angletoplayer + (rad, 90, 0)), radius);
            rad += circleinc;
        }
        plot_points(plotpoints, color[0], color[1], color[2], time);
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xde4801f, Offset: 0x1860
// Size: 0x36
function track(spot_to_track) {
    if (isdefined(self.current_target)) {
        if (spot_to_track == self.current_target) {
            return;
        }
    }
    self.current_target = spot_to_track;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x6100f5a5, Offset: 0x18a0
// Size: 0x80
function waittill_string(msg, ent) {
    if (msg != "death") {
        self endon(#"death");
    }
    ent endon(#"die");
    self waittill(msg);
    ent notify(#"returned", {#msg:msg});
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x5d535748, Offset: 0x1928
// Size: 0x80
function waittill_level_string(msg, ent, otherent) {
    otherent endon(#"death");
    ent endon(#"die");
    level waittill(msg);
    ent notify(#"returned", {#msg:msg});
}

// Namespace util/util_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0x1495dc4e, Offset: 0x19b0
// Size: 0x9c
function waittill_multiple(...) {
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    for (i = 0; i < vararg.size; i++) {
        self thread _waitlogic(s_tracker, vararg[i]);
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill(#"waitlogic_finished");
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x32801e91, Offset: 0x1a58
// Size: 0x2a
function waittill_either(msg1, msg2) {
    self endon(msg1);
    self waittill(msg2);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x4053e383, Offset: 0x1a90
// Size: 0xac
function break_glass(n_radius = 50) {
    n_radius = float(n_radius);
    if (n_radius == -1) {
        v_origin_offset = (0, 0, 0);
        n_radius = 100;
    } else {
        v_origin_offset = (0, 0, 40);
    }
    glassradiusdamage(self.origin + v_origin_offset, n_radius, 500, 500);
}

// Namespace util/util_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0xbc1cb4d, Offset: 0x1b48
// Size: 0x1c4
function waittill_multiple_ents(...) {
    a_ents = [];
    a_notifies = [];
    for (i = 0; i < vararg.size; i++) {
        if (i % 2) {
            if (!isdefined(a_notifies)) {
                a_notifies = [];
            } else if (!isarray(a_notifies)) {
                a_notifies = array(a_notifies);
            }
            a_notifies[a_notifies.size] = vararg[i];
            continue;
        }
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        a_ents[a_ents.size] = vararg[i];
    }
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    for (i = 0; i < a_ents.size; i++) {
        ent = a_ents[i];
        if (isdefined(ent)) {
            ent thread _waitlogic(s_tracker, a_notifies[i]);
        }
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill(#"waitlogic_finished");
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xc7a378d2, Offset: 0x1d18
// Size: 0xb0
function _waitlogic(s_tracker, notifies) {
    s_tracker._wait_count++;
    if (!isdefined(notifies)) {
        notifies = [];
    } else if (!isarray(notifies)) {
        notifies = array(notifies);
    }
    notifies[notifies.size] = "death";
    self waittill(notifies);
    s_tracker._wait_count--;
    if (s_tracker._wait_count == 0) {
        s_tracker notify(#"waitlogic_finished");
    }
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x7a1283ba, Offset: 0x1dd0
// Size: 0x1b2
function waittill_level_any_timeout(n_timeout, otherent, string1, string2, string3, string4, string5) {
    otherent endon(#"death");
    ent = spawnstruct();
    if (isdefined(string1)) {
        level thread waittill_level_string(string1, ent, otherent);
    }
    if (isdefined(string2)) {
        level thread waittill_level_string(string2, ent, otherent);
    }
    if (isdefined(string3)) {
        level thread waittill_level_string(string3, ent, otherent);
    }
    if (isdefined(string4)) {
        level thread waittill_level_string(string4, ent, otherent);
    }
    if (isdefined(string5)) {
        level thread waittill_level_string(string5, ent, otherent);
    }
    if (isdefined(otherent)) {
        otherent thread waittill_string("death", ent);
    }
    ent thread _timeout(n_timeout);
    waitresult = ent waittill(#"returned");
    ent notify(#"die");
    return waitresult.msg;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x6a71c308, Offset: 0x1f90
// Size: 0x56
function _timeout(delay) {
    self endon(#"die");
    wait delay;
    self notify(#"returned", {#msg:"timeout"});
}

// Namespace util/util_shared
// Params 14, eflags: 0x0
// Checksum 0x276dd335, Offset: 0x1ff0
// Size: 0x166
function waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
    assert(isdefined(ent1));
    assert(isdefined(string1));
    if (isdefined(ent2) && isdefined(string2)) {
        ent2 endon(string2);
    }
    if (isdefined(ent3) && isdefined(string3)) {
        ent3 endon(string3);
    }
    if (isdefined(ent4) && isdefined(string4)) {
        ent4 endon(string4);
    }
    if (isdefined(ent5) && isdefined(string5)) {
        ent5 endon(string5);
    }
    if (isdefined(ent6) && isdefined(string6)) {
        ent6 endon(string6);
    }
    if (isdefined(ent7) && isdefined(string7)) {
        ent7 endon(string7);
    }
    ent1 waittill(string1);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x4be7fe4b, Offset: 0x2160
// Size: 0x80
function waittill_any_ents_two(ent1, string1, ent2, string2) {
    assert(isdefined(ent1));
    assert(isdefined(string1));
    if (isdefined(ent2) && isdefined(string2)) {
        ent2 endon(string2);
    }
    ent1 waittill(string1);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4825cecb, Offset: 0x21e8
// Size: 0x20
function isflashed() {
    if (!isdefined(self.flashendtime)) {
        return false;
    }
    return gettime() < self.flashendtime;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xff2d4258, Offset: 0x2210
// Size: 0x20
function isstunned() {
    if (!isdefined(self.flashendtime)) {
        return false;
    }
    return gettime() < self.flashendtime;
}

// Namespace util/util_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0xf76e1772, Offset: 0x2238
// Size: 0x3a
function single_func(entity, func, ...) {
    return _single_func(entity, func, vararg);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x27706a5c, Offset: 0x2280
// Size: 0x3a
function single_func_argarray(entity, func, a_vars) {
    return _single_func(entity, func, a_vars);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xe4459015, Offset: 0x22c8
// Size: 0x53a
function _single_func(entity, func, a_vars) {
    _clean_up_arg_array(a_vars);
    switch (a_vars.size) {
    case 8:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
        }
        break;
    case 7:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
        }
        break;
    case 6:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
        }
        break;
    case 5:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
        }
        break;
    case 4:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
        }
        break;
    case 3:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2]);
        }
        break;
    case 2:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1]);
        }
        break;
    case 1:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0]);
        } else {
            return [[ func ]](a_vars[0]);
        }
        break;
    case 0:
        if (isdefined(entity)) {
            return entity [[ func ]]();
        } else {
            return [[ func ]]();
        }
        break;
    default:
        assertmsg("<dev string:xd0>");
        break;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xa427b7c9, Offset: 0x2810
// Size: 0x6e
function _clean_up_arg_array(&a_vars) {
    for (i = a_vars.size - 1; i >= 0; i--) {
        if (a_vars[i] === undefined) {
            arrayremoveindex(a_vars, i, 0);
            continue;
        }
        break;
    }
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x4faf399b, Offset: 0x2888
// Size: 0xca
function new_func(func, arg1, arg2, arg3, arg4, arg5, arg6) {
    s_func = spawnstruct();
    s_func.func = func;
    s_func.arg1 = arg1;
    s_func.arg2 = arg2;
    s_func.arg3 = arg3;
    s_func.arg4 = arg4;
    s_func.arg5 = arg5;
    s_func.arg6 = arg6;
    return s_func;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x59cc729d, Offset: 0x2960
// Size: 0x72
function call_func(s_func) {
    return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

// Namespace util/util_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x82e082b1, Offset: 0x29e0
// Size: 0x3c
function single_thread(entity, func, ...) {
    _single_thread(entity, func, undefined, undefined, vararg);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x88ad53b2, Offset: 0x2a28
// Size: 0x3c
function single_thread_argarray(entity, func, &a_vars) {
    _single_thread(entity, func, undefined, undefined, a_vars);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xa989f3d8, Offset: 0x2a70
// Size: 0x44
function function_e54ebad6(entity, func, arg1, &a_vars) {
    _single_thread(entity, func, arg1, undefined, a_vars);
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x7cd148e3, Offset: 0x2ac0
// Size: 0x54
function function_b51353f(entity, func, arg1, arg2, &a_vars) {
    _single_thread(entity, func, arg1, arg2, a_vars);
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x9f16520a, Offset: 0x2b20
// Size: 0x95a
function _single_thread(entity, func, arg1, arg2, &a_vars) {
    _clean_up_arg_array(a_vars);
    if (isdefined(arg2)) {
        switch (a_vars.size) {
        case 8:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
            break;
        case 7:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
            break;
        case 6:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
            break;
        case 5:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
            break;
        case 4:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
            break;
        case 3:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2]);
            break;
        case 2:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1]);
            break;
        case 1:
            entity thread [[ func ]](arg1, arg2, a_vars[0]);
            break;
        case 0:
            entity thread [[ func ]](arg1, arg2);
            break;
        default:
            assertmsg("<dev string:xd0>");
            break;
        }
        return;
    }
    if (isdefined(arg1)) {
        switch (a_vars.size) {
        case 8:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
            break;
        case 7:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
            break;
        case 6:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
            break;
        case 5:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
            break;
        case 4:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
            break;
        case 3:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2]);
            break;
        case 2:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1]);
            break;
        case 1:
            entity thread [[ func ]](arg1, a_vars[0]);
            break;
        case 0:
            entity thread [[ func ]](arg1);
            break;
        default:
            assertmsg("<dev string:xd0>");
            break;
        }
        return;
    }
    switch (a_vars.size) {
    case 8:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
        break;
    case 7:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
        break;
    case 6:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
        break;
    case 5:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
        break;
    case 4:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
        break;
    case 3:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2]);
        break;
    case 2:
        entity thread [[ func ]](a_vars[0], a_vars[1]);
        break;
    case 1:
        entity thread [[ func ]](a_vars[0]);
        break;
    case 0:
        entity thread [[ func ]]();
        break;
    default:
        assertmsg("<dev string:xd0>");
        break;
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x678e0ca4, Offset: 0x3488
// Size: 0xca
function script_delay() {
    n_time = gettime();
    self.var_98c1e121 = 1;
    if (isdefined(self.script_delay)) {
        wait self.script_delay;
    }
    n_min_delay = isdefined(self.script_delay_min) ? self.script_delay_min : 0;
    n_max_delay = isdefined(self.script_delay_max) ? self.script_delay_max : 0;
    if (n_max_delay > n_min_delay) {
        wait randomfloatrange(n_min_delay, n_max_delay);
    } else if (n_min_delay > 0) {
        wait n_min_delay;
    }
    self.var_98c1e121 = undefined;
    return gettime() - n_time;
}

// Namespace util/util_shared
// Params 8, eflags: 0x0
// Checksum 0x516adc71, Offset: 0x3560
// Size: 0xcc
function timeout(n_time, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    if (isdefined(n_time)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s delay_notify(n_time, "timeout");
    }
    single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3c0eeb96, Offset: 0x3638
// Size: 0x82
function create_flags_and_return_tokens(flags) {
    tokens = strtok(flags, " ");
    for (i = 0; i < tokens.size; i++) {
        level trigger::function_97c49a71(tokens[i]);
    }
    return tokens;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xc34bc894, Offset: 0x36c8
// Size: 0xb0
function function_e59544c3(str_flags) {
    a_str_flags = strtok(str_flags, " ");
    foreach (str_flag in a_str_flags) {
        level flag::set(str_flag);
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x75f7913f, Offset: 0x3780
    // Size: 0x6a
    function fileprint_start(file) {
        filename = file;
        file = openfile(filename, "<dev string:xdf>");
        level.fileprint = file;
        level.fileprintlinecount = 0;
        level.fileprint_filename = filename;
    }

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6d6b22fb, Offset: 0x37f8
    // Size: 0x64
    function fileprint_map_start(file) {
        file = "<dev string:xe5>" + file + "<dev string:xf1>";
        fileprint_start(file);
        level.fileprint_mapentcount = 0;
        fileprint_map_header(1);
    }

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0xfe8e6ba8, Offset: 0x3868
    // Size: 0x6c
    function fileprint_chk(file, str) {
        level.fileprintlinecount++;
        if (level.fileprintlinecount > 400) {
            waitframe(1);
            level.fileprintlinecount++;
            level.fileprintlinecount = 0;
        }
        fprintln(file, str);
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xafd7c765, Offset: 0x38e0
// Size: 0xf4
function fileprint_map_header(binclude_blank_worldspawn = 0) {
    assert(isdefined(level.fileprint));
    /#
        fileprint_chk(level.fileprint, "<dev string:xf6>");
        fileprint_chk(level.fileprint, "<dev string:xfe>");
        fileprint_chk(level.fileprint, "<dev string:x119>");
        if (!binclude_blank_worldspawn) {
            return;
        }
        fileprint_map_entity_start();
        fileprint_map_keypairprint("<dev string:x129>", "<dev string:x133>");
        fileprint_map_entity_end();
    #/
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0xa70993c9, Offset: 0x39e0
    // Size: 0x7c
    function fileprint_map_keypairprint(key1, key2) {
        assert(isdefined(level.fileprint));
        fileprint_chk(level.fileprint, "<dev string:x13e>" + key1 + "<dev string:x140>" + key2 + "<dev string:x13e>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x13cc619c, Offset: 0x3a68
    // Size: 0xb8
    function fileprint_map_entity_start() {
        assert(!isdefined(level.fileprint_entitystart));
        level.fileprint_entitystart = 1;
        assert(isdefined(level.fileprint));
        fileprint_chk(level.fileprint, "<dev string:x144>" + level.fileprint_mapentcount);
        fileprint_chk(level.fileprint, "<dev string:x14f>");
        level.fileprint_mapentcount++;
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1a908188, Offset: 0x3b28
    // Size: 0x74
    function fileprint_map_entity_end() {
        assert(isdefined(level.fileprint_entitystart));
        assert(isdefined(level.fileprint));
        level.fileprint_entitystart = undefined;
        fileprint_chk(level.fileprint, "<dev string:x151>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xaea7cfc3, Offset: 0x3ba8
    // Size: 0x262
    function fileprint_end() {
        assert(!isdefined(level.fileprint_entitystart));
        saved = closefile(level.fileprint);
        if (saved != 1) {
            println("<dev string:x153>");
            println("<dev string:x177>");
            println("<dev string:x179>");
            println("<dev string:x18c>" + level.fileprint_filename);
            println("<dev string:x19d>");
            println("<dev string:x1d4>");
            println("<dev string:x210>");
            println("<dev string:x24c>");
            println("<dev string:x292>");
            println("<dev string:x177>");
            println("<dev string:x2ac>");
            println("<dev string:x2ef>");
            println("<dev string:x333>");
            println("<dev string:x36f>");
            println("<dev string:x3b3>");
            println("<dev string:x3f0>");
            println("<dev string:x42f>");
            println("<dev string:x177>");
            println("<dev string:x153>");
            println("<dev string:x472>");
        }
        level.fileprint = undefined;
        level.fileprint_filename = undefined;
    }

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc42be8f9, Offset: 0x3e18
    // Size: 0x62
    function fileprint_radiant_vec(vector) {
        string = "<dev string:x49e>" + vector[0] + "<dev string:x177>" + vector[1] + "<dev string:x177>" + vector[2] + "<dev string:x49e>";
        return string;
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xf98a14c, Offset: 0x3e88
// Size: 0x8e
function death_notify_wrapper(attacker, damagetype) {
    level notify(#"face", {#face_notify:"death", #entity:self});
    self notify(#"death", {#attacker:attacker, #mod:damagetype});
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0x1f881d56, Offset: 0x3f20
// Size: 0x136
function damage_notify_wrapper(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags) {
    level notify(#"face", {#face_notify:"damage", #entity:self});
    self notify(#"damage", {#amount:damage, #attacker:attacker, #direction:direction_vec, #position:point, #mod:type, #model_name:modelname, #tag_name:tagname, #part_name:partname, #flags:idflags});
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf89eb05b, Offset: 0x4060
// Size: 0x5e
function explode_notify_wrapper() {
    level notify(#"face", {#face_notify:"explode", #entity:self});
    self notify(#"explode");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa6fcd9c6, Offset: 0x40c8
// Size: 0x5e
function alert_notify_wrapper() {
    level notify(#"face", {#face_notify:"alert", #entity:self});
    self notify(#"alert");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc366343b, Offset: 0x4130
// Size: 0x5e
function shoot_notify_wrapper() {
    level notify(#"face", {#face_notify:"shoot", #entity:self});
    self notify(#"shoot");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf3a61015, Offset: 0x4198
// Size: 0x5e
function melee_notify_wrapper() {
    level notify(#"face", {#face_notify:"melee", #entity:self});
    self notify(#"melee");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x727610b8, Offset: 0x4200
// Size: 0xc
function isusabilityenabled() {
    return !self.disabledusability;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x258431d4, Offset: 0x4218
// Size: 0x24
function _disableusability() {
    self.disabledusability++;
    self disableusability();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xfe8b06b5, Offset: 0x4248
// Size: 0x54
function _enableusability() {
    self.disabledusability--;
    assert(self.disabledusability >= 0);
    if (!self.disabledusability) {
        self enableusability();
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xad56a278, Offset: 0x42a8
// Size: 0x24
function resetusability() {
    self.disabledusability = 0;
    self enableusability();
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x2970900, Offset: 0x42d8
// Size: 0xea
function orient_to_normal(normal) {
    hor_normal = (normal[0], normal[1], 0);
    hor_length = length(hor_normal);
    if (!hor_length) {
        return (0, 0, 0);
    }
    hor_dir = vectornormalize(hor_normal);
    neg_height = normal[2] * -1;
    tangent = (hor_dir[0] * neg_height, hor_dir[1] * neg_height, hor_length);
    plant_angle = vectortoangles(tangent);
    return plant_angle;
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0x69aebd12, Offset: 0x43d0
// Size: 0x84
function delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0x2171f79, Offset: 0x4460
// Size: 0xe4
function _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (ishash(time_or_notify) || isstring(time_or_notify)) {
        self waittill(time_or_notify);
    } else {
        wait time_or_notify;
    }
    single_thread(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0xd212febb, Offset: 0x4550
// Size: 0x84
function delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self thread _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0xce591f96, Offset: 0x45e0
// Size: 0xb4
function _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    wait_network_frame(n_frames);
    single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xb4748262, Offset: 0x46a0
// Size: 0x44
function delay_notify(time_or_notify, str_notify, str_endon, arg1) {
    self thread _delay_notify(time_or_notify, str_notify, str_endon, arg1);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x7b1a2483, Offset: 0x46f0
// Size: 0x9a
function _delay_notify(time_or_notify, str_notify, str_endon, arg1) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (ishash(time_or_notify) || isstring(time_or_notify)) {
        self waittill(time_or_notify);
    } else {
        wait time_or_notify;
    }
    self notify(str_notify, arg1);
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x7e545af3, Offset: 0x4798
// Size: 0x74
function get_closest_player(org, team) {
    team = get_team_mapping(team);
    players = getplayers(team);
    return arraysort(players, org, 1, 1)[0];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xf9ff8953, Offset: 0x4818
// Size: 0xf2
function registerclientsys(ssysname) {
    if (!isdefined(level._clientsys)) {
        level._clientsys = [];
    }
    if (level._clientsys.size >= 32) {
        assertmsg("<dev string:x49f>");
        return;
    }
    if (isdefined(level._clientsys[ssysname])) {
        assertmsg("<dev string:x4c0>" + ssysname);
        return;
    }
    level._clientsys[ssysname] = spawnstruct();
    level._clientsys[ssysname].sysid = clientsysregister(ssysname);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xed77cd7f, Offset: 0x4918
// Size: 0x112
function setclientsysstate(ssysname, ssysstate, player) {
    if (!isdefined(level._clientsys)) {
        assertmsg("<dev string:x4e8>");
        return;
    }
    if (!isdefined(level._clientsys[ssysname])) {
        assertmsg("<dev string:x525>" + ssysname);
        return;
    }
    if (isdefined(player)) {
        player clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
        return;
    }
    clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
    level._clientsys[ssysname].sysstate = ssysstate;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x42f53bc5, Offset: 0x4a38
// Size: 0xce
function getclientsysstate(ssysname) {
    if (!isdefined(level._clientsys)) {
        assertmsg("<dev string:x556>");
        return "";
    }
    if (!isdefined(level._clientsys[ssysname])) {
        assertmsg("<dev string:x596>" + ssysname + "<dev string:x5a5>");
        return "";
    }
    if (isdefined(level._clientsys[ssysname].sysstate)) {
        return level._clientsys[ssysname].sysstate;
    }
    return "";
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xf61e76d5, Offset: 0x4b10
// Size: 0x6c
function clientnotify(event) {
    if (level.clientscripts) {
        if (isplayer(self)) {
            setclientsysstate("levelNotify", event, self);
            return;
        }
        setclientsysstate("levelNotify", event);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb46c7b4d, Offset: 0x4b88
// Size: 0x46
function coopgame() {
    return sessionmodeissystemlink() || sessionmodeisonlinegame() || issplitscreen();
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x58a6a3f6, Offset: 0x4bd8
// Size: 0x1a6
function is_looking_at(ent_or_org, n_dot_range = 0.9, do_trace = 0, v_offset) {
    assert(isdefined(ent_or_org), "<dev string:x5d2>");
    v_point = isvec(ent_or_org) ? ent_or_org : ent_or_org.origin;
    if (isvec(v_offset)) {
        v_point += v_offset;
    }
    b_can_see = 0;
    b_use_tag_eye = 0;
    if (isplayer(self) || isai(self)) {
        b_use_tag_eye = 1;
    }
    n_dot = self math::get_dot_direction(v_point, 0, 1, "forward", b_use_tag_eye);
    if (n_dot > n_dot_range) {
        if (do_trace) {
            v_eye = self get_eye();
            b_can_see = sighttracepassed(v_eye, v_point, 0, ent_or_org);
        } else {
            b_can_see = 1;
        }
    }
    return b_can_see;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa5761c0c, Offset: 0x4d88
// Size: 0x4c
function get_eye() {
    if (isplayer(self)) {
        return self getplayercamerapos();
    }
    return self geteye();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x60c24ce6, Offset: 0x4de0
// Size: 0x24
function is_ads() {
    return self playerads() > 0.5;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x126bb94b, Offset: 0x4e10
// Size: 0xce
function spawn_model(model_name, origin, angles, n_spawnflags = 0, b_throttle = 0) {
    if (b_throttle) {
        spawner::global_spawn_throttle(4);
    }
    if (!isdefined(origin)) {
        origin = (0, 0, 0);
    }
    model = spawn("script_model", origin, n_spawnflags);
    model setmodel(model_name);
    if (isdefined(angles)) {
        model.angles = angles;
    }
    return model;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0xebc29094, Offset: 0x4ee8
// Size: 0x9a
function spawn_anim_model(model_name, origin, angles, n_spawnflags = 0, b_throttle) {
    model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
    model useanimtree("generic");
    model.animtree = "generic";
    return model;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x45b20ab4, Offset: 0x4f90
// Size: 0x9a
function spawn_anim_player_model(model_name, origin, angles, n_spawnflags = 0, b_throttle) {
    model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
    model useanimtree("all_player");
    model.animtree = "all_player";
    return model;
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x1663a2f, Offset: 0x5038
// Size: 0xb0
function waittill_player_looking_at(origin, arc_angle_degrees = 90, do_trace, e_ignore) {
    self endon(#"death");
    arc_angle_degrees = absangleclamp360(arc_angle_degrees);
    dot = cos(arc_angle_degrees * 0.5);
    while (!is_player_looking_at(origin, dot, do_trace, e_ignore)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x8226382, Offset: 0x50f0
// Size: 0x58
function waittill_player_not_looking_at(origin, dot, do_trace) {
    self endon(#"death");
    while (is_player_looking_at(origin, dot, do_trace)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x28c4777c, Offset: 0x5150
// Size: 0x1b8
function is_player_looking_at(v_origin, n_dot = 0.7, b_do_trace = 1, e_ignore) {
    assert(isplayer(self), "<dev string:x60a>");
    if (isdefined(self.hijacked_vehicle_entity)) {
        v_eye = self.hijacked_vehicle_entity gettagorigin("tag_driver");
        v_view = anglestoforward(self.hijacked_vehicle_entity gettagangles("tag_driver"));
    } else {
        v_eye = self get_eye();
        v_view = anglestoforward(self getplayerangles());
    }
    v_delta = vectornormalize(v_origin - v_eye);
    n_new_dot = vectordot(v_delta, v_view);
    if (n_new_dot >= n_dot) {
        if (b_do_trace) {
            return bullettracepassed(v_origin, v_eye, 0, e_ignore);
        } else {
            return 1;
        }
    }
    return 0;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0xbb1ede69, Offset: 0x5310
// Size: 0x76
function wait_endon(waittime, endonstring, endonstring2, endonstring3, endonstring4) {
    self endon(endonstring);
    if (isdefined(endonstring2)) {
        self endon(endonstring2);
    }
    if (isdefined(endonstring3)) {
        self endon(endonstring3);
    }
    if (isdefined(endonstring4)) {
        self endon(endonstring4);
    }
    wait waittime;
    return true;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x610840d0, Offset: 0x5390
// Size: 0x84
function waittillendonthreaded(waitcondition, callback, endcondition1, endcondition2, endcondition3) {
    if (isdefined(endcondition1)) {
        self endon(endcondition1);
    }
    if (isdefined(endcondition2)) {
        self endon(endcondition2);
    }
    if (isdefined(endcondition3)) {
        self endon(endcondition3);
    }
    self waittill(waitcondition);
    if (isdefined(callback)) {
        [[ callback ]](waitcondition);
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x629aa597, Offset: 0x5420
// Size: 0x46
function new_timer(n_timer_length) {
    s_timer = spawnstruct();
    s_timer.n_time_created = gettime();
    s_timer.n_length = n_timer_length;
    return s_timer;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x1320b208, Offset: 0x5470
// Size: 0x20
function get_time() {
    t_now = gettime();
    return t_now - self.n_time_created;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xfd993e85, Offset: 0x5498
// Size: 0x34
function get_time_in_seconds() {
    return float(get_time()) / 1000;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x8d59c2cb, Offset: 0x54d8
// Size: 0x4a
function get_time_frac(n_end_time = self.n_length) {
    return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xcee9e362, Offset: 0x5530
// Size: 0x58
function get_time_left() {
    if (isdefined(self.n_length)) {
        n_current_time = get_time_in_seconds();
        return max(self.n_length - n_current_time, 0);
    }
    return -1;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf28f1c72, Offset: 0x5590
// Size: 0x16
function is_time_left() {
    return get_time_left() != 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x4c75139a, Offset: 0x55b0
// Size: 0x62
function timer_wait(n_wait) {
    if (isdefined(self.n_length)) {
        n_wait = min(n_wait, get_time_left());
    }
    wait n_wait;
    n_current_time = get_time_in_seconds();
    return n_current_time;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe855f787, Offset: 0x5620
// Size: 0x36
function is_primary_damage(meansofdeath) {
    if (meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET") {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x72fbc8a4, Offset: 0x5660
// Size: 0x54
function delete_on_death(ent) {
    ent endon(#"death");
    self waittill(#"death");
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x4459cb47, Offset: 0x56c0
// Size: 0xb4
function delete_on_death_or_notify(e_to_delete, str_notify, str_clientfield = undefined) {
    e_to_delete endon(#"death");
    self waittill_either("death", str_notify);
    if (isdefined(e_to_delete)) {
        if (isdefined(str_clientfield)) {
            e_to_delete clientfield::set(str_clientfield, 0);
            wait 0.1;
        }
        e_to_delete delete();
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xff0bc56a, Offset: 0x5780
// Size: 0xa8
function wait_till_not_touching(e_to_check, e_to_touch) {
    assert(isdefined(e_to_check), "<dev string:x638>");
    assert(isdefined(e_to_touch), "<dev string:x676>");
    e_to_check endon(#"death");
    e_to_touch endon(#"death");
    while (e_to_check istouching(e_to_touch)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x7e94929, Offset: 0x5830
// Size: 0xd4
function any_player_is_touching(ent, team) {
    team = get_team_mapping(team);
    foreach (player in getplayers(team)) {
        if (isalive(player) && player istouching(ent)) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x3dd58d1b, Offset: 0x5910
// Size: 0x124
function set_console_status() {
    if (!isdefined(level.console)) {
        level.console = getdvarstring(#"consolegame") == "true";
    } else {
        assert(level.console == getdvarstring(#"consolegame") == "<dev string:x6b4>", "<dev string:x6b9>");
    }
    if (!isdefined(level.consolexenon)) {
        level.xenon = getdvarstring(#"xenongame") == "true";
        return;
    }
    assert(level.xenon == getdvarstring(#"xenongame") == "<dev string:x6b4>", "<dev string:x6dc>");
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x93264acc, Offset: 0x5a40
// Size: 0x14
function waittill_asset_loaded(str_type, str_name) {
    
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x580bc971, Offset: 0x5a60
// Size: 0x15a
function script_wait() {
    n_time = gettime();
    if (isdefined(self.script_wait)) {
        wait self.script_wait;
        if (isdefined(self.script_wait_add)) {
            self.script_wait += self.script_wait_add;
        }
    }
    n_min = isdefined(self.script_wait_min) ? self.script_wait_min : 0;
    n_max = isdefined(self.script_wait_max) ? self.script_wait_max : 0;
    if (n_max > n_min) {
        wait randomfloatrange(n_min, n_max);
        self.script_wait_min += isdefined(self.script_wait_add) ? self.script_wait_add : 0;
        self.script_wait_max += isdefined(self.script_wait_add) ? self.script_wait_add : 0;
    } else if (n_min > 0) {
        wait n_min;
        self.script_wait_min += isdefined(self.script_wait_add) ? self.script_wait_add : 0;
    }
    return gettime() - n_time;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x544eb786, Offset: 0x5bc8
// Size: 0x20
function is_killstreaks_enabled() {
    return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x7009b251, Offset: 0x5bf0
// Size: 0x1e
function is_flashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x6bc9f21b, Offset: 0x5c18
// Size: 0x116
function magic_bullet_shield(ent = self) {
    ent val::set(#"magic_bullet_shield", "allowdeath", 0);
    ent.magic_bullet_shield = 1;
    /#
        ent notify(#"_stop_magic_bullet_shield_debug");
        level thread debug_magic_bullet_shield_death(ent);
    #/
    assert(isalive(ent), "<dev string:x6fd>");
    if (isai(ent)) {
        if (isactor(ent)) {
            ent bloodimpact("hero");
        }
        ent.attackeraccuracy = 0.1;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3da1a235, Offset: 0x5d38
// Size: 0xac
function debug_magic_bullet_shield_death(guy) {
    targetname = "none";
    if (isdefined(guy.targetname)) {
        targetname = guy.targetname;
    }
    guy endon(#"stop_magic_bullet_shield");
    guy endon(#"_stop_magic_bullet_shield_debug");
    guy waittill(#"death");
    assert(!isdefined(guy), "<dev string:x739>" + targetname);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xc7478bd0, Offset: 0x5df0
// Size: 0x328
function spawn_player_clone(player, animname, s_align, var_ffd42d22 = 0) {
    playerclone = spawn("script_model", player.origin);
    playerclone.angles = player.angles;
    if (player function_7cc69e51()) {
        var_30f28185 = player function_fb7ff145();
        if (isdefined(var_30f28185)) {
            playerclone setmodel(var_30f28185);
        }
        headmodel = player function_48b6673e();
        if (isdefined(headmodel)) {
            playerclone attach(headmodel);
        }
    } else {
        var_b6982d63 = player function_dd025223();
        if (isdefined(var_b6982d63)) {
            playerclone setmodel(var_b6982d63);
        }
        headmodel = player function_48b6673e();
        if (isdefined(headmodel)) {
            playerclone attach(headmodel);
        }
        var_eb59dd61 = player function_2d8b2021();
        if (isdefined(var_eb59dd61)) {
            playerclone attach(var_eb59dd61);
        }
        var_30f28185 = player function_fb7ff145();
        if (isdefined(var_30f28185)) {
            playerclone attach(var_30f28185);
        }
    }
    playerclone setbodyrenderoptionspacked(player getcharacterbodyrenderoptions());
    if (var_ffd42d22) {
        playerclone animation::attach_weapon(player getcurrentweapon());
    }
    playerclone useanimtree("all_player");
    if (isdefined(animname)) {
        if (isdefined(s_align)) {
            playerclone thread animation::play(animname, s_align);
        } else {
            playerclone thread animation::play(animname, playerclone.origin, playerclone.angles);
        }
    }
    playerclone.health = 100;
    playerclone setowner(player);
    playerclone.team = player.team;
    playerclone solid();
    return playerclone;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x9748a631, Offset: 0x6120
// Size: 0xc0
function stop_magic_bullet_shield(ent = self) {
    ent val::reset(#"magic_bullet_shield", "allowdeath");
    ent.magic_bullet_shield = undefined;
    if (isai(ent)) {
        if (isactor(ent)) {
            ent bloodimpact("normal");
        }
        ent.attackeraccuracy = 1;
    }
    ent notify(#"stop_magic_bullet_shield");
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x17df8de0, Offset: 0x61e8
// Size: 0x46
function get_rounds_won(team) {
    team = get_team_mapping(team);
    return game.stat[#"roundswon"][team];
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x394635f2, Offset: 0x6238
// Size: 0x90
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x81b588a4, Offset: 0x62d0
// Size: 0x16a
function button_held_think(which_button) {
    self endon(#"disconnect");
    if (!isdefined(self._holding_button)) {
        self._holding_button = [];
    }
    self._holding_button[which_button] = 0;
    time_started = 0;
    while (true) {
        usinggamepad = self gamepadusedlast();
        use_time = ispc() && !usinggamepad ? 0 : 250;
        if (self._holding_button[which_button]) {
            if (!self [[ level._button_funcs[which_button] ]]()) {
                self._holding_button[which_button] = 0;
            }
        } else if (self [[ level._button_funcs[which_button] ]]()) {
            if (time_started == 0) {
                time_started = gettime();
            }
            if (gettime() - time_started > use_time) {
                self._holding_button[which_button] = 1;
            }
        } else if (time_started != 0) {
            time_started = 0;
        }
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x7b4d796d, Offset: 0x6448
// Size: 0x4c
function use_button_held() {
    init_button_wrappers();
    if (!isdefined(self._use_button_think_threaded)) {
        self thread button_held_think(0);
        self._use_button_think_threaded = 1;
    }
    return self._holding_button[0];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x46f1ed01, Offset: 0x64a0
// Size: 0x58
function stance_button_held() {
    init_button_wrappers();
    if (!isdefined(self._stance_button_think_threaded)) {
        self thread button_held_think(1);
        self._stance_button_think_threaded = 1;
    }
    return self._holding_button[1];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xd1675cc5, Offset: 0x6500
// Size: 0x58
function ads_button_held() {
    init_button_wrappers();
    if (!isdefined(self._ads_button_think_threaded)) {
        self thread button_held_think(2);
        self._ads_button_think_threaded = 1;
    }
    return self._holding_button[2];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x51d748b, Offset: 0x6560
// Size: 0x58
function attack_button_held() {
    init_button_wrappers();
    if (!isdefined(self._attack_button_think_threaded)) {
        self thread button_held_think(3);
        self._attack_button_think_threaded = 1;
    }
    return self._holding_button[3];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x2a30d023, Offset: 0x65c0
// Size: 0x58
function button_right_held() {
    init_button_wrappers();
    if (!isdefined(self._dpad_right_button_think_threaded)) {
        self thread button_held_think(6);
        self._dpad_right_button_think_threaded = 1;
    }
    return self._holding_button[6];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x46de5728, Offset: 0x6620
// Size: 0x28
function waittill_use_button_pressed() {
    while (!self usebuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x589c67e1, Offset: 0x6650
// Size: 0x28
function waittill_use_button_held() {
    while (!self use_button_held()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x18fbb794, Offset: 0x6680
// Size: 0x28
function waittill_stance_button_pressed() {
    while (!self stancebuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x1221b585, Offset: 0x66b0
// Size: 0x28
function waittill_stance_button_held() {
    while (!self stance_button_held()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x43ea8b8a, Offset: 0x66e0
// Size: 0x28
function waittill_attack_button_pressed() {
    while (!self attackbuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x44a2a87b, Offset: 0x6710
// Size: 0x28
function waittill_ads_button_pressed() {
    while (!self adsbuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x5e77291, Offset: 0x6740
// Size: 0x28
function waittill_vehicle_move_up_button_pressed() {
    while (!self vehiclemoveupbuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa6779f51, Offset: 0x6770
// Size: 0xfe
function init_button_wrappers() {
    if (!isdefined(level._button_funcs)) {
        level._button_funcs[0] = &usebuttonpressed;
        level._button_funcs[2] = &adsbuttonpressed;
        level._button_funcs[3] = &attackbuttonpressed;
        level._button_funcs[1] = &stancebuttonpressed;
        level._button_funcs[6] = &actionslotfourbuttonpressed;
        /#
            level._button_funcs[4] = &up_button_pressed;
            level._button_funcs[5] = &down_button_pressed;
        #/
    }
}

/#

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xeb8f1d95, Offset: 0x6878
    // Size: 0x62
    function up_button_held() {
        init_button_wrappers();
        if (!isdefined(self._up_button_think_threaded)) {
            self thread button_held_think(4);
            self._up_button_think_threaded = 1;
        }
        return self._holding_button[4];
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5f6f6589, Offset: 0x68e8
    // Size: 0x62
    function down_button_held() {
        init_button_wrappers();
        if (!isdefined(self._down_button_think_threaded)) {
            self thread button_held_think(5);
            self._down_button_think_threaded = 1;
        }
        return self._holding_button[5];
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe8c4959d, Offset: 0x6958
    // Size: 0x46
    function up_button_pressed() {
        return self buttonpressed("<dev string:x770>") || self buttonpressed("<dev string:x778>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x13d69383, Offset: 0x69a8
    // Size: 0x28
    function waittill_up_button_pressed() {
        while (!self up_button_pressed()) {
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf9188f08, Offset: 0x69d8
    // Size: 0x46
    function down_button_pressed() {
        return self buttonpressed("<dev string:x780>") || self buttonpressed("<dev string:x78a>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xacc4a7a8, Offset: 0x6a28
    // Size: 0x28
    function waittill_down_button_pressed() {
        while (!self down_button_pressed()) {
            waitframe(1);
        }
    }

#/

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6b27d602, Offset: 0x6a58
// Size: 0x18
function ishacked() {
    return isdefined(self.hacked) && self.hacked;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x85366a, Offset: 0x6a78
// Size: 0xac
function isenemyplayer(player) {
    assert(isdefined(player));
    if (!isplayer(player)) {
        return false;
    }
    if (level.teambased) {
        if (player.team == self.team || function_baf4e8ea(player.team, self.team)) {
            return false;
        }
    } else if (player == self) {
        return false;
    }
    return true;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xfe870c3e, Offset: 0x6b30
// Size: 0x2e
function waittillslowprocessallowed() {
    while (level.lastslowprocessframe == gettime()) {
        waitframe(1);
    }
    level.lastslowprocessframe = gettime();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x3541a79d, Offset: 0x6b68
// Size: 0x12
function get_start_time() {
    return getmicrosecondsraw();
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0xf8484b8b, Offset: 0x6b88
    // Size: 0xec
    function note_elapsed_time(start_time, label = "unspecified") {
        elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
        if (!isdefined(start_time)) {
            return;
        }
        elapsed_time *= 0.001;
        if (!level.orbis) {
            elapsed_time = int(elapsed_time);
        }
        msg = label + "<dev string:x794>" + elapsed_time + "<dev string:x7a4>";
        profileprintln(msg);
        iprintln(msg);
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x7057d2e5, Offset: 0x6c80
// Size: 0x98
function record_elapsed_time(start_time, &elapsed_time_array) {
    elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
    if (!isdefined(elapsed_time_array)) {
        elapsed_time_array = [];
    } else if (!isarray(elapsed_time_array)) {
        elapsed_time_array = array(elapsed_time_array);
    }
    elapsed_time_array[elapsed_time_array.size] = elapsed_time;
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0x6c739bb1, Offset: 0x6d20
    // Size: 0x284
    function note_elapsed_times(&elapsed_time_array, label = "unspecified") {
        if (!isarray(elapsed_time_array)) {
            return;
        }
        msg = label + "<dev string:x7a8>" + elapsed_time_array.size;
        profileprintln(msg);
        if (elapsed_time_array.size == 0) {
            return;
        }
        total_elapsed_time = 0;
        smallest_elapsed_time = 2147483647;
        largest_elapsed_time = 0;
        foreach (elapsed_time in elapsed_time_array) {
            elapsed_time *= 0.001;
            total_elapsed_time += elapsed_time;
            if (elapsed_time < smallest_elapsed_time) {
                smallest_elapsed_time = elapsed_time;
            }
            if (elapsed_time > largest_elapsed_time) {
                largest_elapsed_time = elapsed_time;
            }
            if (!level.orbis) {
                elapsed_time = int(elapsed_time);
            }
            msg = label + "<dev string:x794>" + elapsed_time + "<dev string:x7a4>";
            profileprintln(msg);
        }
        average_elapsed_time = total_elapsed_time / elapsed_time_array.size;
        msg = label + "<dev string:x7b3>" + average_elapsed_time + "<dev string:x7a4>";
        profileprintln(msg);
        iprintln(msg);
        msg = label + "<dev string:x7cb>" + largest_elapsed_time + "<dev string:x7a4>";
        profileprintln(msg);
        msg = label + "<dev string:x7e3>" + smallest_elapsed_time + "<dev string:x7a4>";
        profileprintln(msg);
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x241504c9, Offset: 0x6fb0
// Size: 0x70
function get_elapsed_time(start_time, end_time = getmicrosecondsraw()) {
    if (!isdefined(start_time)) {
        return undefined;
    }
    elapsed_time = end_time - start_time;
    if (elapsed_time < 0) {
        elapsed_time += -2147483648;
    }
    return elapsed_time;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x686faa4a, Offset: 0x7028
// Size: 0x7c
function note_raw_time(label = "unspecified") {
    now = getmicrosecondsraw();
    msg = "us = " + now + " -- " + label;
    profileprintln(msg);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe3ad7b29, Offset: 0x70b0
// Size: 0x4e
function mayapplyscreeneffect() {
    assert(isdefined(self));
    assert(isplayer(self));
    return !isdefined(self.viewlockedentity);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x8cd6184a, Offset: 0x7108
// Size: 0x9e
function waittillnotmoving() {
    if (self ishacked()) {
        waitframe(1);
        return;
    }
    if (self.classname == "grenade") {
        self waittill(#"stationary");
        return;
    }
    for (prevorigin = self.origin; true; prevorigin = self.origin) {
        wait 0.15;
        if (self.origin == prevorigin) {
            break;
        }
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xfc4f3ed4, Offset: 0x71b0
// Size: 0x66
function waittillrollingornotmoving() {
    if (self ishacked()) {
        waitframe(1);
        return "stationary";
    }
    movestate = self waittill(#"stationary", #"rolling");
    return movestate._notify;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xa3ffd574, Offset: 0x7220
// Size: 0x142
function getweaponclass(weapon) {
    if (weapon == level.weaponnone) {
        return undefined;
    }
    if (!weapon.isvalid) {
        return undefined;
    }
    if (!isdefined(level.weaponclassarray)) {
        level.weaponclassarray = [];
    }
    if (isdefined(level.weaponclassarray[weapon.name])) {
        return level.weaponclassarray[weapon.name];
    }
    baseweaponparam = weapons::getbaseweapon(weapon);
    baseweaponindex = getbaseweaponitemindex(baseweaponparam);
    weaponclass = #"";
    weaponinfo = getunlockableiteminfofromindex(baseweaponindex, 1);
    if (isdefined(weaponinfo)) {
        weaponclass = weaponinfo.itemgroupname;
    }
    level.weaponclassarray[weapon.name] = weaponclass;
    return weaponclass;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x54d75072, Offset: 0x7370
// Size: 0x56
function function_260ac520(weaponname) {
    weapon = getweapon(weaponname);
    if (!isdefined(weapon) || weapon == level.weaponnone) {
        return undefined;
    }
    return weapon;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x366fb176, Offset: 0x73d0
// Size: 0xc
function isusingremote() {
    return isdefined(self.usingremote);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xa48b6adb, Offset: 0x73e8
// Size: 0x18
function function_27255f5d(remotename) {
    return self.usingremote === remotename;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x462ee677, Offset: 0x7408
// Size: 0xc6
function setusingremote(remotename, set_killstreak_delay_killcam = !sessionmodeiszombiesgame()) {
    if (isdefined(self.carryicon)) {
        self.carryicon.alpha = 0;
    }
    assert(!self isusingremote());
    self.usingremote = remotename;
    if (set_killstreak_delay_killcam) {
        self.killstreak_delay_killcam = remotename;
    }
    self disableoffhandweapons();
    self notify(#"using_remote");
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x959ffe54, Offset: 0x74d8
// Size: 0x74
function deleteaftertime(time) {
    assert(isdefined(self));
    assert(isdefined(time));
    assert(time >= 0.05);
    self thread deleteaftertimethread(time);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x36ea5dde, Offset: 0x7558
// Size: 0x3c
function deleteaftertimethread(time) {
    self endon(#"death");
    wait time;
    self delete();
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xb50509bb, Offset: 0x75a0
// Size: 0x34
function waitfortime(time = 0) {
    if (time > 0) {
        wait time;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xf493d36f, Offset: 0x75e0
// Size: 0x7e
function waitfortimeandnetworkframe(time = 0) {
    start_time_ms = gettime();
    wait_network_frame();
    elapsed_time = (gettime() - start_time_ms) * 0.001;
    remaining_time = time - elapsed_time;
    if (remaining_time > 0) {
        wait remaining_time;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x90e137c8, Offset: 0x7668
// Size: 0x54
function deleteaftertimeandnetworkframe(time) {
    assert(isdefined(self));
    waitfortimeandnetworkframe(time);
    self delete();
}

/#

    // Namespace util/util_shared
    // Params 7, eflags: 0x0
    // Checksum 0x235c5eed, Offset: 0x76c8
    // Size: 0x7c
    function drawcylinder(pos, rad, height, duration, stop_notify, color, alpha) {
        if (!isdefined(duration)) {
            duration = 0;
        }
        level thread drawcylinder_think(pos, rad, height, duration, stop_notify, color, alpha);
    }

    // Namespace util/util_shared
    // Params 7, eflags: 0x0
    // Checksum 0x4f93dd21, Offset: 0x7750
    // Size: 0x2f8
    function drawcylinder_think(pos, rad, height, seconds, stop_notify, color, alpha) {
        if (isdefined(stop_notify)) {
            level endon(stop_notify);
        }
        stop_time = gettime() + int(seconds * 1000);
        currad = rad;
        curheight = height;
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        for (;;) {
            if (seconds > 0 && stop_time <= gettime()) {
                return;
            }
            for (r = 0; r < 20; r++) {
                theta = r / 20 * 360;
                theta2 = (r + 1) / 20 * 360;
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, alpha);
                line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, alpha);
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, alpha);
            }
            waitframe(1);
        }
    }

#/

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6e52e988, Offset: 0x7a50
// Size: 0x2e
function spawn_array_struct() {
    s = spawnstruct();
    s.a = [];
    return s;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xac5936e0, Offset: 0x7a88
// Size: 0x98
function gethostplayer() {
    players = getplayers();
    foreach (player in players) {
        if (player ishost()) {
            return player;
        }
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x10a02f29, Offset: 0x7b28
// Size: 0x6c
function gethostplayerforbots() {
    players = getplayers();
    for (index = 0; index < players.size; index++) {
        if (players[index] ishostforbots()) {
            return players[index];
        }
    }
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0xa83e2cd2, Offset: 0x7ba0
// Size: 0x2f0
function get_array_of_closest(org, array, excluders = [], max = array.size, maxdist) {
    maxdists2rd = undefined;
    if (isdefined(maxdist)) {
        maxdists2rd = maxdist * maxdist;
    }
    dist = [];
    index = [];
    for (i = 0; i < array.size; i++) {
        if (!isdefined(array[i])) {
            continue;
        }
        if (isinarray(excluders, array[i])) {
            continue;
        }
        if (isvec(array[i])) {
            length = distancesquared(org, array[i]);
        } else {
            length = distancesquared(org, array[i].origin);
        }
        if (isdefined(maxdists2rd) && maxdists2rd < length) {
            continue;
        }
        dist[dist.size] = length;
        index[index.size] = i;
    }
    for (;;) {
        change = 0;
        for (i = 0; i < dist.size - 1; i++) {
            if (dist[i] <= dist[i + 1]) {
                continue;
            }
            change = 1;
            temp = dist[i];
            dist[i] = dist[i + 1];
            dist[i + 1] = temp;
            temp = index[i];
            index[i] = index[i + 1];
            index[i + 1] = temp;
        }
        if (!change) {
            break;
        }
    }
    newarray = [];
    if (max > dist.size) {
        max = dist.size;
    }
    for (i = 0; i < max; i++) {
        newarray[i] = array[index[i]];
    }
    return newarray;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x5d781acd, Offset: 0x7e98
// Size: 0x13c
function set_lighting_state(n_state) {
    if (isdefined(n_state)) {
        self.lighting_state = n_state;
    } else {
        self.lighting_state = level.lighting_state;
    }
    if (isdefined(self.lighting_state)) {
        if (self == level) {
            if (isdefined(level.activeplayers)) {
                foreach (player in level.activeplayers) {
                    player set_lighting_state(level.lighting_state);
                }
            }
            return;
        }
        if (isplayer(self)) {
            self setlightingstate(self.lighting_state);
            return;
        }
        assertmsg("<dev string:x7fc>");
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xa2ca1dab, Offset: 0x7fe0
// Size: 0x13c
function set_sun_shadow_split_distance(f_distance) {
    if (isdefined(f_distance)) {
        self.sun_shadow_split_distance = f_distance;
    } else {
        self.sun_shadow_split_distance = level.sun_shadow_split_distance;
    }
    if (isdefined(self.sun_shadow_split_distance)) {
        if (self == level) {
            if (isdefined(level.activeplayers)) {
                foreach (player in level.activeplayers) {
                    player set_sun_shadow_split_distance(level.sun_shadow_split_distance);
                }
            }
            return;
        }
        if (isplayer(self)) {
            self setsunshadowsplitdistance(self.sun_shadow_split_distance);
            return;
        }
        assertmsg("<dev string:x82e>");
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xe5fb68e7, Offset: 0x8128
// Size: 0x52a
function auto_delete(n_mode = 1, n_min_time_alive = 0, n_dist_horizontal = 0, n_dist_vertical = 0) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death", #"hash_375a9d48dd6a9427");
    self notify(#"__auto_delete__");
    self endon(#"__auto_delete__");
    level flag::wait_till("all_players_spawned");
    if (isdefined(level.heroes) && isinarray(level.heroes, self)) {
        return;
    }
    if (isplayer(self)) {
        return;
    }
    if (n_mode & 16 || n_mode == 1 || n_mode == 8) {
        n_mode |= 2;
        n_mode |= 4;
    }
    n_think_time = 1;
    n_tests_to_do = 2;
    n_dot_check = 0;
    if (n_mode & 16) {
        n_think_time = 0.2;
        n_tests_to_do = 1;
        n_dot_check = 0.4;
    }
    n_test_count = 0;
    n_dist_horizontal_sq = n_dist_horizontal * n_dist_horizontal;
    while (true) {
        do {
            wait randomfloatrange(n_think_time - n_think_time / 3, n_think_time + n_think_time / 3);
        } while (isdefined(self.birthtime) && float(gettime() - self.birthtime) / 1000 < n_min_time_alive);
        n_tests_passed = 0;
        foreach (player in level.players) {
            if (isbot(player)) {
                n_tests_passed++;
                continue;
            }
            if (n_dist_horizontal && distance2dsquared(self.origin, player.origin) < n_dist_horizontal_sq) {
                continue;
            }
            if (n_dist_vertical && abs(self.origin[2] - player.origin[2]) < n_dist_vertical) {
                continue;
            }
            v_eye = player getplayercamerapos();
            b_behind = 0;
            if (n_mode & 2) {
                v_facing = anglestoforward(player getplayerangles());
                v_to_ent = vectornormalize(self.origin - v_eye);
                n_dot = vectordot(v_facing, v_to_ent);
                if (n_dot < n_dot_check) {
                    b_behind = 1;
                    if (!(n_mode & 1)) {
                        n_tests_passed++;
                        continue;
                    }
                }
            }
            if (n_mode & 4) {
                if (!self sightconetrace(v_eye, isdefined(player getvehicleoccupied()) ? player getvehicleoccupied() : player)) {
                    if (b_behind || !(n_mode & 1)) {
                        n_tests_passed++;
                    }
                }
            }
        }
        if (n_tests_passed == level.players.size) {
            n_test_count++;
            if (n_test_count < n_tests_to_do) {
                continue;
            }
            self notify(#"_disable_reinforcement");
            self delete();
            continue;
        }
        n_test_count = 0;
    }
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x90f15b28, Offset: 0x8660
// Size: 0x436
function query_ents(&a_kvps_match, b_match_all = 1, &a_kvps_ingnore, b_ignore_spawners = 0, b_match_substrings = 0) {
    a_ret = [];
    if (b_match_substrings) {
        a_all_ents = arraycombine(getentarray(), level.struct, 0, 0);
        b_first = 1;
        foreach (v in a_kvps_match) {
            a_ents = _query_ents_by_substring_helper(a_all_ents, v.value, v.key, b_ignore_spawners);
            if (b_first) {
                a_ret = a_ents;
                b_first = 0;
                continue;
            }
            if (b_match_all) {
                a_ret = arrayintersect(a_ret, a_ents);
                continue;
            }
            a_ret = arraycombine(a_ret, a_ents, 0, 0);
        }
        if (isdefined(a_kvps_ingnore)) {
            foreach (k, v in a_kvps_ingnore) {
                a_ents = _query_ents_by_substring_helper(a_all_ents, v, k, b_ignore_spawners);
                a_ret = array::exclude(a_ret, a_ents);
            }
        }
    } else {
        b_first = 1;
        foreach (v in a_kvps_match) {
            a_ents = arraycombine(getentarray(v.value, v.key, b_ignore_spawners), struct::get_array(v.value, v.key), 0, 0);
            if (b_first) {
                a_ret = a_ents;
                b_first = 0;
                continue;
            }
            if (b_match_all) {
                a_ret = arrayintersect(a_ret, a_ents);
                continue;
            }
            a_ret = arraycombine(a_ret, a_ents, 0, 0);
        }
        if (isdefined(a_kvps_ingnore)) {
            foreach (k, v in a_kvps_ingnore) {
                a_ents = arraycombine(getentarray(v, k, b_ignore_spawners), struct::get_array(v, k), 0, 0);
                a_ret = array::exclude(a_ret, a_ents);
            }
        }
    }
    return a_ret;
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x33ac0911, Offset: 0x8aa0
// Size: 0x170
function _query_ents_by_substring_helper(&a_ents, str_value, str_key = "targetname", b_ignore_spawners = 0) {
    a_ret = [];
    foreach (ent in a_ents) {
        if (b_ignore_spawners && isspawner(ent)) {
            continue;
        }
        if (isstring(ent.(str_key)) && issubstr(ent.(str_key), str_value)) {
            if (!isdefined(a_ret)) {
                a_ret = [];
            } else if (!isarray(a_ret)) {
                a_ret = array(a_ret);
            }
            a_ret[a_ret.size] = ent;
        }
    }
    return a_ret;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xc4dbd795, Offset: 0x8c18
// Size: 0xa2
function get_weapon_by_name(weapon_name, var_63d2be95) {
    split = [];
    if ("" != var_63d2be95) {
        split = strtok(var_63d2be95, "+");
    }
    if (split.size) {
        weapon = getweapon(weapon_name, split);
    } else {
        weapon = getweapon(weapon_name);
    }
    return weapon;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xb95382b, Offset: 0x8cc8
// Size: 0x80
function function_e819f6ec(weapon) {
    var_63d2be95 = "";
    for (i = 0; i < weapon.attachments.size; i++) {
        if (!i) {
            var_63d2be95 += "+";
        }
        var_63d2be95 += weapon.attachments[i];
    }
    return var_63d2be95;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x7727bd0c, Offset: 0x8d50
// Size: 0x6c
function function_d27ced7f() {
    if (sessionmodeiswarzonegame()) {
        return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
    }
    return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc840a15a, Offset: 0x8dc8
// Size: 0x124
function function_1a1c8e97() {
    if (sessionmodeiswarzonegame()) {
        if (getdvarint(#"hash_23a1d3a9139af42b", 0) > 0) {
            return getdvarfloat(#"hash_608e7bb0e9517884", 250);
        } else {
            return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
        }
        return;
    }
    if (getdvarint(#"hash_23fac9a913e70c03", 0) > 0) {
        return getdvarfloat(#"hash_606c79b0e9348eb8", 250);
    }
    return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc682abdd, Offset: 0x8ef8
// Size: 0x6a
function is_female() {
    gender = self getplayergendertype(currentsessionmode());
    b_female = 0;
    if (isdefined(gender) && gender == "female") {
        b_female = 1;
    }
    return b_female;
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0xa97b7b60, Offset: 0x8f70
// Size: 0x168
function positionquery_pointarray(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent) {
    if (isdefined(reachableby_ent)) {
        queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent);
    } else {
        queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing);
    }
    pointarray = [];
    foreach (pointstruct in queryresult.data) {
        if (!isdefined(pointarray)) {
            pointarray = [];
        } else if (!isarray(pointarray)) {
            pointarray = array(pointarray);
        }
        pointarray[pointarray.size] = pointstruct.origin;
    }
    return pointarray;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x531d9f0a, Offset: 0x90e0
// Size: 0x92
function totalplayercount() {
    count = 0;
    foreach (team, _ in level.teams) {
        count += level.playercount[team];
    }
    return count;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x832d0c1b, Offset: 0x9180
// Size: 0x20
function isrankenabled() {
    return isdefined(level.rankenabled) && level.rankenabled;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x8f52a4c8, Offset: 0x91a8
// Size: 0x20
function isoneround() {
    if (level.roundlimit == 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x59198c21, Offset: 0x91d0
// Size: 0x1e
function isfirstround() {
    if (game.roundsplayed == 0) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x21355596, Offset: 0x91f8
// Size: 0x40
function islastround() {
    if (level.roundlimit > 1 && game.roundsplayed >= level.roundlimit - 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x676eef60, Offset: 0x9240
// Size: 0xc8
function waslastround() {
    if (level.forcedend) {
        return true;
    }
    if (isdefined(level.nextroundisovertime)) {
        if (level.nextroundisovertime) {
            level.nextroundisovertime = 1;
            return false;
        } else if (isdefined(game.overtime_round) && game.overtime_round > 0) {
            return true;
        }
    }
    if (hitroundlimit() || hitscorelimit() || hitroundwinlimit()) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xaea6bad4, Offset: 0x9310
// Size: 0x34
function hitroundlimit() {
    if (level.roundlimit <= 0) {
        return false;
    }
    return getroundsplayed() >= level.roundlimit;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xda355567, Offset: 0x9350
// Size: 0x94
function anyteamhitroundwinlimit() {
    foreach (team, _ in level.teams) {
        if (getroundswon(team) >= level.roundwinlimit) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4dd4e2c8, Offset: 0x93f0
// Size: 0xcc
function anyteamhitroundlimitwithdraws() {
    tie_wins = game.stat[#"roundswon"][#"tie"];
    foreach (team, _ in level.teams) {
        if (getroundswon(team) + tie_wins >= level.roundwinlimit) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x575798e8, Offset: 0x94c8
// Size: 0xbc
function function_9c2c33c9() {
    count = 0;
    foreach (team, _ in level.teams) {
        wins = getroundswon(team);
        if (!isdefined(count)) {
            count = wins;
            continue;
        }
        if (wins != count) {
            return false;
        }
    }
    return true;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xdfba37c3, Offset: 0x9590
// Size: 0x76
function hitroundwinlimit() {
    if (!isdefined(level.roundwinlimit) || level.roundwinlimit <= 0) {
        return false;
    }
    if (anyteamhitroundwinlimit()) {
        return true;
    }
    if (anyteamhitroundlimitwithdraws()) {
        if (!function_9c2c33c9()) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xbdfa113f, Offset: 0x9610
// Size: 0x98
function any_team_hit_score_limit() {
    foreach (team, _ in level.teams) {
        if (game.stat[#"teamscores"][team] >= level.scorelimit) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x423f8a66, Offset: 0x96b0
// Size: 0xd0
function hitscorelimit() {
    if (level.scoreroundwinbased) {
        return false;
    }
    if (level.scorelimit <= 0) {
        return false;
    }
    if (level.teambased) {
        if (any_team_hit_score_limit()) {
            return true;
        }
    } else {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isdefined(player.pointstowin) && player.pointstowin >= level.scorelimit) {
                return true;
            }
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa0a3592c, Offset: 0x9788
// Size: 0x1e
function get_current_round_score_limit() {
    return level.roundscorelimit * (game.roundsplayed + 1);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xebd82178, Offset: 0x97b0
// Size: 0xac
function any_team_hit_round_score_limit() {
    round_score_limit = get_current_round_score_limit();
    foreach (team, _ in level.teams) {
        if (game.stat[#"teamscores"][team] >= round_score_limit) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4ea17ebe, Offset: 0x9868
// Size: 0xdc
function hitroundscorelimit() {
    if (level.roundscorelimit <= 0) {
        return false;
    }
    if (level.teambased) {
        if (any_team_hit_round_score_limit()) {
            return true;
        }
    } else {
        roundscorelimit = get_current_round_score_limit();
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isdefined(player.pointstowin) && player.pointstowin >= roundscorelimit) {
                return true;
            }
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xaddf490a, Offset: 0x9950
// Size: 0x46
function getroundswon(team) {
    team = get_team_mapping(team);
    return game.stat[#"roundswon"][team];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xf7c3051a, Offset: 0x99a0
// Size: 0xd4
function getotherteamsroundswon(str_skip_team) {
    str_skip_team = get_team_mapping(str_skip_team);
    roundswon = 0;
    foreach (team, _ in level.teams) {
        if (team == str_skip_team) {
            continue;
        }
        roundswon += game.stat[#"roundswon"][team];
    }
    return roundswon;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x8ea63cab, Offset: 0x9a80
// Size: 0xe
function getroundsplayed() {
    return game.roundsplayed;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4be683b2, Offset: 0x9a98
// Size: 0x36
function isroundbased() {
    if (level.roundlimit != 1 && level.roundwinlimit != 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x68c37e69, Offset: 0x9ad8
// Size: 0x2e
function getcurrentgamemode() {
    if (gamemodeismode(6)) {
        return "leaguematch";
    }
    return "publicmatch";
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0x6da72cd8, Offset: 0x9b10
// Size: 0x138
function ground_position(v_start, n_max_dist = 5000, n_ground_offset = 0, e_ignore, b_ignore_water = 0, b_ignore_glass = 0) {
    v_trace_start = v_start + (0, 0, 5);
    v_trace_end = v_trace_start + (0, 0, (n_max_dist + 5) * -1);
    a_trace = groundtrace(v_trace_start, v_trace_end, 0, e_ignore, b_ignore_water, b_ignore_glass);
    if (a_trace[#"surfacetype"] != "none") {
        return (a_trace[#"position"] + (0, 0, n_ground_offset));
    }
    return v_start;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xfb88875e, Offset: 0x9c50
// Size: 0x2a
function delayed_notify(str_notify, f_delay_seconds) {
    wait f_delay_seconds;
    if (isdefined(self)) {
        self notify(str_notify);
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xda7d901c, Offset: 0x9c88
// Size: 0x6c
function delayed_delete(f_delay_seconds) {
    assert(isentity(self));
    wait f_delay_seconds;
    if (isdefined(self) && isentity(self)) {
        self delete();
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x16a7b44c, Offset: 0x9d00
// Size: 0x20
function is_safehouse() {
    mapname = get_map_name();
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x813fff36, Offset: 0x9d28
// Size: 0x2c
function is_new_cp_map() {
    mapname = get_map_name();
    switch (mapname) {
    default:
        return false;
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc770d666, Offset: 0x9d80
    // Size: 0x64
    function add_queued_debug_command(cmd) {
        if (!isdefined(level.dbg_cmd_queue)) {
            level thread queued_debug_commands();
        }
        if (isdefined(level.dbg_cmd_queue)) {
            array::push(level.dbg_cmd_queue, cmd);
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2105102d, Offset: 0x9df0
    // Size: 0x17a
    function queued_debug_commands() {
        self notify(#"queued_debug_commands");
        self endon(#"queued_debug_commands");
        if (!isdefined(level.dbg_cmd_queue)) {
            level.dbg_cmd_queue = [];
        }
        while (true) {
            waitframe(1);
            if (!isdefined(game.state)) {
                continue;
            }
            if (game.state == "<dev string:x86b>") {
                continue;
            }
            if (level.dbg_cmd_queue.size == 0) {
                level.dbg_cmd_queue = undefined;
                return;
            }
            trickle = 0;
            if (level.players.size > 1) {
                trickle = 1;
            }
            for (var_474d84f3 = 12; (!trickle || var_474d84f3 > 0) && canadddebugcommand() && level.dbg_cmd_queue.size > 0; var_474d84f3--) {
                cmd = array::pop_front(level.dbg_cmd_queue, 0);
                adddebugcommand(cmd);
                if (trickle) {
                }
            }
        }
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x48a354bb, Offset: 0x9f78
// Size: 0x42
function array_copy_if_array(any_var) {
    return isarray(any_var) ? arraycopy(any_var) : any_var;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xd90ef42c, Offset: 0x9fc8
// Size: 0x62
function is_item_purchased(ref) {
    itemindex = getitemindexfromref(ref);
    return itemindex < 0 || itemindex >= 256 ? 0 : self isitempurchased(itemindex);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x6f7d46d4, Offset: 0xa038
// Size: 0x3c
function has_purchased_perk_equipped(ref) {
    return self hasperk(ref) && self is_item_purchased(ref);
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x30b0b074, Offset: 0xa080
// Size: 0x66
function has_purchased_perk_equipped_with_specific_stat(single_perk_ref, stats_table_ref) {
    if (isplayer(self)) {
        return (self hasperk(single_perk_ref) && self is_item_purchased(stats_table_ref));
    }
    return 0;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x59ac8414, Offset: 0xa0f0
// Size: 0x22
function has_flak_jacket_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_flakjacket");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xcb406d78, Offset: 0xa120
// Size: 0x32
function has_blind_eye_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_nottargetedbyairsupport", #"specialty_nottargetedbyairsupport|specialty_nokillstreakreticle");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xba4e5c59, Offset: 0xa160
// Size: 0x22
function has_ghost_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_gpsjammer");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6723d55b, Offset: 0xa190
// Size: 0x32
function has_tactical_mask_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_stunprotection", #"specialty_stunprotection|specialty_flashprotection|specialty_proximityprotection");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6d00e4c3, Offset: 0xa1d0
// Size: 0x32
function has_hacker_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_showenemyequipment", #"specialty_showenemyequipment|specialty_showscorestreakicons|specialty_showenemyvehicles");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x85aac4c7, Offset: 0xa210
// Size: 0x32
function has_cold_blooded_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_nottargetedbyaitank", #"specialty_nottargetedbyaitank|specialty_nottargetedbyraps|specialty_nottargetedbysentry|specialty_nottargetedbyrobot|specialty_immunenvthermal");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6bc0880b, Offset: 0xa250
// Size: 0x32
function has_hard_wired_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_immunecounteruav", #"specialty_immunecounteruav|specialty_immuneemp|specialty_immunetriggerc4|specialty_immunetriggershock|specialty_immunetriggerbetty|specialty_sixthsensejammer|specialty_trackerjammer|specialty_immunesmoke");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa5a49e51, Offset: 0xa290
// Size: 0x32
function has_gung_ho_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_sprintfire", #"specialty_sprintfire|specialty_sprintgrenadelethal|specialty_sprintgrenadetactical|specialty_sprintequipment");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb9f2c26b, Offset: 0xa2d0
// Size: 0x32
function has_fast_hands_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_fastweaponswitch", #"specialty_fastweaponswitch|specialty_sprintrecovery|specialty_sprintfirerecovery");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x711481e8, Offset: 0xa310
// Size: 0x22
function has_scavenger_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_scavenger");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa48561b5, Offset: 0xa340
// Size: 0x32
function has_jetquiet_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_jetquiet", #"specialty_jetnoradar|specialty_jetquiet");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6023e138, Offset: 0xa380
// Size: 0x22
function has_awareness_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_loudenemies");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x308eb59f, Offset: 0xa3b0
// Size: 0x22
function has_ninja_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_quieter");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc401e72f, Offset: 0xa3e0
// Size: 0x22
function has_toughness_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_bulletflinch");
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe1af6d8d, Offset: 0xa410
// Size: 0x58
function str_strip_lh(str) {
    if (strendswith(str, "_lh")) {
        return getsubstr(str, 0, str.size - 3);
    }
    return str;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6dbf0392, Offset: 0xa470
// Size: 0x176
function trackwallrunningdistance() {
    self endon(#"disconnect");
    self.movementtracking.wallrunning = spawnstruct();
    self.movementtracking.wallrunning.distance = 0;
    self.movementtracking.wallrunning.count = 0;
    self.movementtracking.wallrunning.time = 0;
    while (true) {
        self waittill(#"wallrun_begin");
        startpos = self.origin;
        starttime = gettime();
        self.movementtracking.wallrunning.count++;
        self waittill(#"wallrun_end");
        self.movementtracking.wallrunning.distance += distance(startpos, self.origin);
        self.movementtracking.wallrunning.time += gettime() - starttime;
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x97833896, Offset: 0xa5f0
// Size: 0x176
function tracksprintdistance() {
    self endon(#"disconnect");
    self.movementtracking.sprinting = spawnstruct();
    self.movementtracking.sprinting.distance = 0;
    self.movementtracking.sprinting.count = 0;
    self.movementtracking.sprinting.time = 0;
    while (true) {
        self waittill(#"sprint_begin");
        startpos = self.origin;
        starttime = gettime();
        self.movementtracking.sprinting.count++;
        self waittill(#"sprint_end");
        self.movementtracking.sprinting.distance += distance(startpos, self.origin);
        self.movementtracking.sprinting.time += gettime() - starttime;
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb9ea63e9, Offset: 0xa770
// Size: 0x176
function trackdoublejumpdistance() {
    self endon(#"disconnect");
    self.movementtracking.doublejump = spawnstruct();
    self.movementtracking.doublejump.distance = 0;
    self.movementtracking.doublejump.count = 0;
    self.movementtracking.doublejump.time = 0;
    while (true) {
        self waittill(#"doublejump_begin");
        startpos = self.origin;
        starttime = gettime();
        self.movementtracking.doublejump.count++;
        self waittill(#"doublejump_end");
        self.movementtracking.doublejump.distance += distance(startpos, self.origin);
        self.movementtracking.doublejump.time += gettime() - starttime;
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x48ed1a93, Offset: 0xa8f0
// Size: 0x70
function getplayspacecenter() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
    }
    return (0, 0, 0);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf7bc243e, Offset: 0xa968
// Size: 0xde
function getplayspacemaxwidth() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        x = abs(minimaporigins[0].origin[0] - minimaporigins[1].origin[0]);
        y = abs(minimaporigins[0].origin[1] - minimaporigins[1].origin[1]);
        return max(x, y);
    }
    return 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3eca1b6b, Offset: 0xaa50
// Size: 0x8c
function getteammask(team) {
    team = get_team_mapping(team);
    if (!level.teambased || !isdefined(team) || !isdefined(level.spawnsystem.ispawn_teammask[team])) {
        return level.spawnsystem.ispawn_teammask_free;
    }
    return level.spawnsystem.ispawn_teammask[team];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3517fbbd, Offset: 0xaae8
// Size: 0xac
function getotherteam(team) {
    team = get_team_mapping(team);
    if (team == #"allies") {
        return #"axis";
    } else if (team == #"axis") {
        return #"allies";
    } else {
        return #"allies";
    }
    assertmsg("<dev string:x873>" + team);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x9dcd15f9, Offset: 0xaba0
// Size: 0xc8
function getotherteamsmask(str_skip_team) {
    str_skip_team = get_team_mapping(str_skip_team);
    mask = 0;
    foreach (team, _ in level.teams) {
        if (team == str_skip_team) {
            continue;
        }
        mask |= getteammask(team);
    }
    return mask;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf8e931f7, Offset: 0xac70
// Size: 0x20
function waittill_can_add_debug_command() {
    while (!canadddebugcommand()) {
        waitframe(1);
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa96ec034, Offset: 0xac98
    // Size: 0x3c
    function add_debug_command(cmd) {
        waittill_can_add_debug_command();
        adddebugcommand(cmd);
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xa4f053be, Offset: 0xace0
// Size: 0x13e
function get_players(team = #"any") {
    if (team == #"any") {
        return arraycopy(level.players);
    }
    assert(isdefined(level.teams[team]), "<dev string:x88f>" + function_15979fa9(team) + "<dev string:x891>");
    players = [];
    foreach (player in level.players) {
        if (player.team == team) {
            players[players.size] = player;
        }
    }
    return players;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xdc83e62b, Offset: 0xae28
// Size: 0x15c
function get_active_players(team = #"any") {
    if (team == #"any") {
        return arraycopy(level.activeplayers);
    }
    assert(isdefined(level.teams[team]), "<dev string:x88f>" + function_15979fa9(team) + "<dev string:x891>");
    players = [];
    foreach (player in level.activeplayers) {
        if (!isdefined(player)) {
            continue;
        }
        if (isdefined(player.team) && player.team == team) {
            players[players.size] = player;
        }
    }
    return players;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xb914a6e9, Offset: 0xaf90
// Size: 0x160
function function_8260dc36(team = #"any") {
    players = get_active_players();
    if (team == #"any") {
        return players;
    }
    assert(isdefined(level.teams[team]), "<dev string:x88f>" + function_15979fa9(team) + "<dev string:x891>");
    enemies = [];
    foreach (player in players) {
        if (isdefined(player) && isdefined(player.team) && player.team != team) {
            enemies[enemies.size] = player;
        }
    }
    return enemies;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xdfdaee39, Offset: 0xb0f8
// Size: 0xe0
function get_human_players(team = #"any") {
    players = get_players(team);
    humanplayers = [];
    foreach (player in players) {
        if (!isbot(player)) {
            humanplayers[humanplayers.size] = player;
        }
    }
    return humanplayers;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x9e316ef4, Offset: 0xb1e0
// Size: 0x4c
function function_30b386cd(player) {
    return isdefined(player) && !isbot(player) && isinarray(level.players, player);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xd10a670f, Offset: 0xb238
// Size: 0xe0
function get_bot_players(team = #"any") {
    players = get_players(team);
    botplayers = [];
    foreach (player in players) {
        if (isbot(player)) {
            botplayers[botplayers.size] = player;
        }
    }
    return botplayers;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x1b293da0, Offset: 0xb320
// Size: 0x52
function is_game_solo(team = #"any") {
    humanplayers = get_human_players(team);
    return humanplayers.size == 1;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x4987abd, Offset: 0xb380
// Size: 0x52
function is_game_coop(team = #"any") {
    humanplayers = get_human_players(team);
    return humanplayers.size > 1;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xd84c30e5, Offset: 0xb3e0
// Size: 0x38
function function_de2a2058(team) {
    players = get_players(team);
    return players.size > 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x5fa2226a, Offset: 0xb420
// Size: 0x38
function function_f23f4e8a(team) {
    players = get_human_players(team);
    return players.size > 0;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x146ede40, Offset: 0xb460
// Size: 0x156
function function_5b5d076d() {
    level flag::wait_till("all_players_spawned");
    foreach (var_809bbc12 in array(#"battery", #"firebreak", #"nomad", #"outrider", #"prophet", #"reaper", #"ruin", #"seraph", #"spectre")) {
        if (isdefined(self.("script_require_specialist_" + var_809bbc12)) && self.("script_require_specialist_" + var_809bbc12)) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x8a3f8c62, Offset: 0xb5c0
// Size: 0x1c
function timesince(starttimeinmilliseconds) {
    return (gettime() - starttimeinmilliseconds) * 0.001;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc59aebe8, Offset: 0xb5e8
// Size: 0x1a
function cooldowninit() {
    if (!isdefined(self._cooldown)) {
        self._cooldown = [];
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x9a9c6b66, Offset: 0xb610
// Size: 0x56
function cooldown(name, time_seconds) {
    cooldowninit();
    self._cooldown[name] = gettime() + int(time_seconds * 1000);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x470db1d9, Offset: 0xb670
// Size: 0x54
function getcooldowntimeraw(name) {
    cooldowninit();
    if (!isdefined(self._cooldown[name])) {
        self._cooldown[name] = gettime() - 1;
    }
    return self._cooldown[name];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x5b624232, Offset: 0xb6d0
// Size: 0x40
function getcooldownleft(name) {
    cooldowninit();
    return (getcooldowntimeraw(name) - gettime()) * 0.001;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xb2853ffc, Offset: 0xb718
// Size: 0x7c
function iscooldownready(name, timeforward_seconds) {
    cooldowninit();
    if (!isdefined(timeforward_seconds)) {
        timeforward_seconds = 0;
    }
    cooldownreadytime = self._cooldown[name];
    return !isdefined(cooldownreadytime) || gettime() + int(timeforward_seconds * 1000) > cooldownreadytime;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xb95d4460, Offset: 0xb7a0
// Size: 0x36
function clearcooldown(name) {
    cooldowninit();
    self._cooldown[name] = gettime() - 1;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xc6dcf398, Offset: 0xb7e0
// Size: 0x6e
function addcooldowntime(name, time_seconds) {
    cooldowninit();
    self._cooldown[name] = getcooldowntimeraw(name) + int(time_seconds * 1000);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa148ad45, Offset: 0xb858
// Size: 0x8a
function clearallcooldowns() {
    if (isdefined(self._cooldown)) {
        foreach (str_name, cooldown in self._cooldown) {
            self._cooldown[str_name] = gettime() - 1;
        }
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x4
// Checksum 0xec633c0e, Offset: 0xb8f0
// Size: 0x64
function private function_386cfa4(alias) {
    assert(isdefined(level.team_mapping_alias));
    assert(isdefined(level.team_mapping_alias[alias]));
    return level.team_mapping_alias[alias];
}

// Namespace util/util_shared
// Params 0, eflags: 0x4
// Checksum 0x34466176, Offset: 0xb960
// Size: 0xc4
function private function_4fd63077() {
    assert(isdefined(level.team_mapping));
    if (get_team_mapping("sidea") == #"allies" && get_team_mapping("sideb") == #"axis") {
        level clientfield::set("cf_team_mapping", 1);
        return;
    }
    level clientfield::set("cf_team_mapping", 0);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x29e6a370, Offset: 0xba30
// Size: 0x22c
function function_2b9d78e6() {
    if (isdefined(level.var_c5eb0f1)) {
        return;
    }
    level.var_c5eb0f1 = 1;
    function_5331c807(#"allies", #"allies");
    function_5331c807(#"axis", #"axis");
    function_5331c807(#"allies", "wun");
    function_5331c807(#"axis", "fpa");
    function_5331c807(#"team3", "side3");
    function_3db0cd78("sidea", "sideb");
    function_3db0cd78("teama", "teamb");
    function_3db0cd78("attacker", "defender");
    function_3db0cd78("attackers", "defenders");
    function_3db0cd78("wun", "fpa");
    function_6fa1120c(#"allies", #"axis");
    function_6fa1120c(#"team3", #"any");
    set_team_mapping(#"allies", #"axis");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf1733c7e, Offset: 0xbc68
// Size: 0x36
function function_758636aa() {
    if (isdefined(level.var_84bfc86f)) {
        return;
    }
    level.var_84bfc86f = array();
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x48f6dde8, Offset: 0xbca8
// Size: 0x2c
function function_e49386ac(var_1613d201) {
    array::add(level.var_84bfc86f, var_1613d201);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3045f669, Offset: 0xbce0
// Size: 0xa0
function function_be2b9049(var_1613d201) {
    foreach (i, v in level.var_84bfc86f) {
        if (array::function_c4488d38(v, var_1613d201)) {
            array::remove_index(i);
        }
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x8001a098, Offset: 0xbd88
// Size: 0x12c
function function_baf4e8ea(team1, team2, team3, team4) {
    if (!isdefined(team1) || !isdefined(team2)) {
        return false;
    }
    foreach (var_1ef319dd in level.var_84bfc86f) {
        if (array::contains(var_1ef319dd, team1)) {
            if (array::contains(var_1ef319dd, team2)) {
                if (!isdefined(team3) || array::contains(var_1ef319dd, team3)) {
                    if (!isdefined(team4) || array::contains(var_1ef319dd, team4)) {
                        return true;
                    }
                }
            }
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xabd2f49e, Offset: 0xbec0
// Size: 0x104
function set_team_mapping(var_8c2b7b49, var_b22df5b2) {
    var_8c2b7b49 = function_386cfa4(var_8c2b7b49);
    var_b22df5b2 = function_386cfa4(var_b22df5b2);
    assert(var_8c2b7b49 != var_b22df5b2, "<dev string:x8ac>");
    level.team_mapping[0] = var_8c2b7b49;
    level.team_mapping[1] = var_b22df5b2;
    flagsys::set(#"team_mapping_set");
    game.attackers = var_8c2b7b49;
    game.defenders = var_b22df5b2;
    if (clientfield::can_set()) {
        function_4fd63077();
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x25b54a86, Offset: 0xbfd0
// Size: 0x6a
function function_3db0cd78(var_f2715b71, var_1873d5da) {
    assert(var_f2715b71 != var_1873d5da, "<dev string:x8f7>");
    level.var_2448f475[var_f2715b71] = 0;
    level.var_2448f475[var_1873d5da] = 1;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x1b97d085, Offset: 0xc048
// Size: 0x6a
function function_6fa1120c(enemy_a, enemy_b) {
    assert(enemy_a != enemy_b, "<dev string:x93f>");
    level.team_enemy_mapping[enemy_a] = enemy_b;
    level.team_enemy_mapping[enemy_b] = enemy_a;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xd3982da5, Offset: 0xc0c0
// Size: 0x82
function function_5331c807(team, alias) {
    assert(team == #"allies" || team == #"axis" || team == #"team3");
    level.team_mapping_alias[alias] = team;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xc5646df9, Offset: 0xc150
// Size: 0xb2
function get_team_mapping(team) {
    assert(isdefined(level.team_mapping));
    assert(isdefined(level.var_2448f475));
    if (isdefined(team)) {
        if (isdefined(level.var_2448f475[team])) {
            return level.team_mapping[level.var_2448f475[team]];
        } else if (isdefined(level.team_mapping_alias[team])) {
            return level.team_mapping_alias[team];
        }
    }
    return team;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x1c48a662, Offset: 0xc210
// Size: 0xc4
function function_f8419fe4(team) {
    assert(isdefined(level.team_mapping));
    assert(isdefined(level.var_2448f475));
    if (isdefined(team)) {
        if (team === level.team_mapping[level.var_2448f475[#"sidea"]]) {
            return "sidea";
        } else if (team === level.team_mapping[level.var_2448f475[#"sideb"]]) {
            return "sideb";
        }
    }
    return team;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xfe78f2db, Offset: 0xc2e0
// Size: 0x34
function is_on_side(team) {
    return self getteam() === get_team_mapping(team);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x794e8067, Offset: 0xc320
// Size: 0x62
function get_enemy_team(team) {
    team = get_team_mapping(team);
    if (!isdefined(team)) {
        return undefined;
    }
    if (isdefined(level.team_enemy_mapping[team])) {
        return level.team_enemy_mapping[team];
    }
    return #"none";
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x75931b71, Offset: 0xc390
// Size: 0x32
function get_game_type() {
    return tolower(getdvarstring(#"g_gametype"));
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x13850229, Offset: 0xc3d0
// Size: 0x32
function get_map_name() {
    return tolower(getdvarstring(#"sv_mapname"));
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4466b163, Offset: 0xc410
// Size: 0x1c
function is_frontend_map() {
    return get_map_name() === "core_frontend";
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0x89998a7f, Offset: 0xc438
    // Size: 0x54
    function add_devgui(menu_path, commands) {
        add_queued_debug_command("<dev string:x980>" + menu_path + "<dev string:x140>" + commands + "<dev string:x98d>");
    }

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4cce742d, Offset: 0xc498
    // Size: 0x3c
    function remove_devgui(menu_path) {
        add_queued_debug_command("<dev string:x990>" + menu_path + "<dev string:x98d>");
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x8f1f92a7, Offset: 0xc4e0
// Size: 0xb2
function gadget_is_in_use(slot) {
    if (isdefined(self._gadgets_player[slot])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
            if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse)) {
                return self [[ level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse ]](slot);
            }
        }
    }
    return self gadgetisactive(slot);
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xe04dcf2d, Offset: 0xc5a0
// Size: 0xa2
function function_dd149434(player, weapon) {
    if (!isdefined(player.var_8e6e2908)) {
        return false;
    }
    foreach (var_5437f60d in player.var_8e6e2908) {
        if (var_5437f60d == weapon) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x4d19a00c, Offset: 0xc650
// Size: 0x5c
function ghost_wait_show(wait_time = 0.1) {
    self endon(#"death");
    self ghost();
    wait wait_time;
    self show();
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x76b0c25d, Offset: 0xc6b8
// Size: 0x13c
function ghost_wait_show_to_player(player, wait_time = 0.1, self_endon_string1) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self.abort_ghost_wait_show_to_player = undefined;
    if (isdefined(player)) {
        player endon(#"death");
        player endon(#"disconnect");
        player endon(#"joined_team");
        player endon(#"joined_spectators");
    }
    if (isdefined(self_endon_string1)) {
        self endon(self_endon_string1);
    }
    self ghost();
    self setinvisibletoall();
    self setvisibletoplayer(player);
    wait wait_time;
    if (!isdefined(self.abort_ghost_wait_show_to_player)) {
        self showtoplayer(player);
    }
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x4a894dbb, Offset: 0xc800
// Size: 0x13c
function ghost_wait_show_to_others(player, wait_time = 0.1, self_endon_string1) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self.abort_ghost_wait_show_to_others = undefined;
    if (isdefined(player)) {
        player endon(#"death");
        player endon(#"disconnect");
        player endon(#"joined_team");
        player endon(#"joined_spectators");
    }
    if (isdefined(self_endon_string1)) {
        self endon(self_endon_string1);
    }
    self ghost();
    self setinvisibletoplayer(player);
    wait wait_time;
    if (!isdefined(self.abort_ghost_wait_show_to_others)) {
        self show();
        self setinvisibletoplayer(player);
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x574f15ab, Offset: 0xc948
// Size: 0x1f4
function show_hit_marker(var_2ade5525 = 0, var_33044945 = 0) {
    if (isplayer(self)) {
        if (isdefined(self) && isdefined(self.hud_damagefeedback)) {
            /#
                currenttime = gettime();
                if ((isdefined(self.hud_damagefeedback.time) ? self.hud_damagefeedback.time : 0) != currenttime || !(isdefined(self.hud_damagefeedback.feedback_dead) && self.hud_damagefeedback.feedback_dead)) {
                    if (var_2ade5525) {
                        self.hud_damagefeedback setshader(#"damage_feedback_glow_orange", 24, 48);
                        self.hud_damagefeedback.feedback_dead = 1;
                    } else {
                        self.hud_damagefeedback setshader(#"damage_feedback", 24, 48);
                        self.hud_damagefeedback.feedback_dead = 0;
                    }
                    self.hud_damagefeedback.alpha = 1;
                    self.hud_damagefeedback fadeovertime(1);
                    self.hud_damagefeedback.alpha = 0;
                    self.hud_damagefeedback.time = currenttime;
                }
            #/
            return;
        }
        if (isdefined(self) && !isdefined(self.hud_damagefeedback)) {
            self thread _show_hit_marker(var_2ade5525, var_33044945);
        }
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x4
// Checksum 0xd6afc63, Offset: 0xcb48
// Size: 0xa0
function private _show_hit_marker(var_2ade5525, var_33044945) {
    self endon(#"death");
    if (!isdefined(self.var_a1e66c6d)) {
        self.var_a1e66c6d = 0;
    }
    if (self.var_a1e66c6d < 5) {
        self.var_a1e66c6d++;
        self playhitmarker(undefined, 5, undefined, var_2ade5525, var_33044945);
        wait_network_frame();
        self.var_a1e66c6d--;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x1adcaf8f, Offset: 0xcbf0
// Size: 0x9c
function function_e831de44(str_tag = "tag_aim_target") {
    if (!issentient(self) && !function_a5354464(self)) {
        if (isdefined(self gettagorigin(str_tag))) {
            self function_908a655e(str_tag);
            return;
        }
        self function_908a655e();
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb88ff66d, Offset: 0xcc98
// Size: 0x34
function make_sentient() {
    if (!issentient(self)) {
        self makesentient();
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x1bcc1a37, Offset: 0xccd8
// Size: 0x3c
function function_a8daf6be(time) {
    self endon(#"death");
    wait time;
    self delete();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb813842c, Offset: 0xcd20
// Size: 0x6c
function is_party_gamemode() {
    switch (level.gametype) {
    case #"sas":
    case #"oic":
    case #"shrp":
    case #"gun":
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf2e11d18, Offset: 0xcd98
// Size: 0x9e
function get_gametype_name() {
    if (!isdefined(level.var_ddcbfa19)) {
        if (isdefined(level.hardcoremode) && level.hardcoremode && is_party_gamemode() == 0) {
            prefix = "HC";
        } else {
            prefix = "";
        }
        level.var_ddcbfa19 = tolower(prefix + level.gametype);
    }
    return level.var_ddcbfa19;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa1419af0, Offset: 0xce40
// Size: 0x9c
function cleanup_fancycam() {
    self endon(#"disconnect");
    if (isplayer(self) && !isbot(self)) {
        wait_network_frame();
        self function_dd566421(0);
        wait_network_frame();
        self function_dd566421(0);
    }
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xe22e7b89, Offset: 0xcee8
// Size: 0x82
function set_dvar_if_unset(dvar, value, reset = 0) {
    if (reset || getdvarstring(dvar) == "") {
        setdvar(dvar, value);
        return value;
    }
    return getdvarstring(dvar);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x90a658d1, Offset: 0xcf78
// Size: 0x82
function set_dvar_float_if_unset(dvar, value, reset = 0) {
    if (reset || getdvarstring(dvar) == "") {
        setdvar(dvar, value);
    }
    return getdvarfloat(dvar, 0);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x1b08b784, Offset: 0xd008
// Size: 0x9a
function set_dvar_int_if_unset(dvar, value, reset = 0) {
    if (reset || getdvarstring(dvar) == "") {
        setdvar(dvar, value);
        return int(value);
    }
    return getdvarint(dvar, 0);
}

/#

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2c436070, Offset: 0xd0b0
    // Size: 0x64
    function debug_slow_heli_speed() {
        if (getdvarint(#"scr_slow_heli", 0) > 0) {
            self setspeed(getdvarint(#"scr_slow_heli", 0));
        }
    }

#/

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x402823c9, Offset: 0xd120
// Size: 0x94
function function_25ed2811() {
    n_timeout = 0;
    self flagsys::set(#"hash_157310a25dd4e508");
    if (isdefined(self.var_2747bc91)) {
        n_timeout = self.var_2747bc91;
    }
    flag::function_6814c108(n_timeout);
    self script_delay();
    self flagsys::clear(#"hash_157310a25dd4e508");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb35461bf, Offset: 0xd1c0
// Size: 0x7a
function function_43cfec92() {
    return isdefined(self.script_flag_true) || isdefined(self.script_flag_false) || isdefined(self.script_delay) && self.script_delay > 0 || isdefined(self.script_delay_min) && self.script_delay_min > 0 || isdefined(self.script_delay_max) && self.script_delay_max > 0;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x3aad3764, Offset: 0xd248
// Size: 0x126
function function_bb3bbd09(str_value, str_key) {
    a_targets = [];
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (isdefined(str_value)) {
        var_6297099b = strtok(str_value, " ");
        foreach (var_b846d770 in var_6297099b) {
            a_targets = arraycombine(a_targets, getentarray(var_b846d770, str_key), 0, 0);
            a_targets = arraycombine(a_targets, struct::get_array(var_b846d770, str_key), 0, 0);
        }
    }
    return a_targets;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x96be22b2, Offset: 0xd378
// Size: 0x136
function get_array(str_value, str_key = "targetname") {
    a_targets = function_bb3bbd09(str_value, str_key);
    if (isdefined(str_value)) {
        var_6297099b = strtok(str_value, " ");
        foreach (var_b846d770 in var_6297099b) {
            a_targets = arraycombine(a_targets, getvehiclenodearray(var_b846d770, str_key), 0, 0);
            a_targets = arraycombine(a_targets, getnodearray(var_b846d770, str_key), 0, 0);
        }
    }
    return a_targets;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x7157f86f, Offset: 0xd4b8
// Size: 0x52
function function_1e539051(radius) {
    if (!isdefined(radius) || radius <= 0) {
        return 0;
    }
    return randomfloatrange(radius * -1, radius);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x42b8c7b7, Offset: 0xd518
// Size: 0x42
function function_fd5e0b(radius) {
    if (!isdefined(radius) || radius <= 0) {
        return 0;
    }
    return randomintrangeinclusive(radius * -1, radius);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xd56a49ec, Offset: 0xd568
// Size: 0x28
function is_spectating() {
    if (self.sessionstate == #"spectator") {
        return true;
    }
    return false;
}

#namespace namespace_8955127e;

// Namespace namespace_8955127e/util_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x5f44ded9, Offset: 0xd598
// Size: 0x2dc
function register_callback(str_kvp, func, ...) {
    var_997c524c = hash(str_kvp);
    var_7c5c9398 = self.(str_kvp + "_target");
    if (isdefined(var_7c5c9398)) {
        if (!isdefined(mission.var_f5e797df)) {
            mission.var_f5e797df = [];
        }
        if (!isdefined(mission.var_f5e797df[var_997c524c])) {
            mission.var_f5e797df[var_997c524c] = [];
        }
        if (!isdefined(self.var_5bab0a85)) {
            self.var_5bab0a85 = [];
        }
        s_callback = {#func:func, #params:vararg};
        self.var_5bab0a85[var_997c524c] = s_callback;
        var_6297099b = strtok(var_7c5c9398, " ");
        foreach (var_d3c879d0 in var_6297099b) {
            if (!isdefined(mission.var_f5e797df[var_997c524c][hash(var_d3c879d0)])) {
                mission.var_f5e797df[var_997c524c][hash(var_d3c879d0)] = [];
            } else if (!isarray(mission.var_f5e797df[var_997c524c][hash(var_d3c879d0)])) {
                mission.var_f5e797df[var_997c524c][hash(var_d3c879d0)] = array(mission.var_f5e797df[var_997c524c][hash(var_d3c879d0)]);
            }
            mission.var_f5e797df[var_997c524c][hash(var_d3c879d0)][mission.var_f5e797df[var_997c524c][hash(var_d3c879d0)].size] = self;
        }
        self thread function_8f0756da();
    }
}

// Namespace namespace_8955127e/util_shared
// Params 3, eflags: 0x0
// Checksum 0xe8bb6d0c, Offset: 0xd880
// Size: 0x2cc
function register_custom_callback(str_name, str_kvp, func) {
    var_94e9a57a = hash(str_name);
    var_7c5c9398 = self.(str_kvp + "_target");
    if (isdefined(var_7c5c9398)) {
        if (!isdefined(mission.var_f5e797df)) {
            mission.var_f5e797df = [];
        }
        if (!isdefined(mission.var_f5e797df[var_94e9a57a])) {
            mission.var_f5e797df[var_94e9a57a] = [];
        }
        if (!isdefined(self.var_5bab0a85)) {
            self.var_5bab0a85 = [];
        }
        s_callback = {#func:func};
        self.var_5bab0a85[var_94e9a57a] = s_callback;
        var_6297099b = strtok(var_7c5c9398, " ");
        foreach (var_d3c879d0 in var_6297099b) {
            if (!isdefined(mission.var_f5e797df[var_94e9a57a][hash(var_d3c879d0)])) {
                mission.var_f5e797df[var_94e9a57a][hash(var_d3c879d0)] = [];
            } else if (!isarray(mission.var_f5e797df[var_94e9a57a][hash(var_d3c879d0)])) {
                mission.var_f5e797df[var_94e9a57a][hash(var_d3c879d0)] = array(mission.var_f5e797df[var_94e9a57a][hash(var_d3c879d0)]);
            }
            mission.var_f5e797df[var_94e9a57a][hash(var_d3c879d0)][mission.var_f5e797df[var_94e9a57a][hash(var_d3c879d0)].size] = self;
        }
        self thread function_8f0756da();
    }
}

// Namespace namespace_8955127e/util_shared
// Params 0, eflags: 0x0
// Checksum 0xbed19614, Offset: 0xdb58
// Size: 0x148
function function_8f0756da() {
    self notify(#"hash_29bf696e43d4a08b");
    self endon(#"hash_29bf696e43d4a08b", #"death");
    a_str_notifies = getarraykeys(self.var_5bab0a85);
    while (true) {
        s_result = self waittill(a_str_notifies);
        s_callback = self.var_5bab0a85[hash(s_result._notify)];
        if (isdefined(s_callback.params)) {
            util::single_thread_argarray(self, s_callback.func, s_callback.params);
            continue;
        }
        if (isdefined(s_result.params)) {
            util::single_thread_argarray(self, s_callback.func, s_result.params);
            continue;
        }
        util::single_thread_argarray(self, s_callback.func);
    }
}

// Namespace namespace_8955127e/util_shared
// Params 2, eflags: 0x0
// Checksum 0xd2006a1e, Offset: 0xdca8
// Size: 0x20c
function function_e9536da8(str_kvp, str_name) {
    a_s_result = [];
    if (isdefined(mission.var_f5e797df)) {
        var_94e9a57a = hash(isdefined(str_name) ? str_name : str_kvp);
        var_6131f498 = mission.var_f5e797df[var_94e9a57a];
        if (isdefined(var_6131f498)) {
            var_7c5c9398 = self.(str_kvp + "_src");
            if (isdefined(var_7c5c9398)) {
                var_6297099b = strtok(var_7c5c9398, " ");
                foreach (var_d3c879d0 in var_6297099b) {
                    var_df885dd5 = var_6131f498[hash(var_d3c879d0)];
                    if (isdefined(var_df885dd5)) {
                        foreach (var_a3e064b5 in var_df885dd5) {
                            if (!isdefined(a_s_result)) {
                                a_s_result = [];
                            } else if (!isarray(a_s_result)) {
                                a_s_result = array(a_s_result);
                            }
                            a_s_result[a_s_result.size] = var_a3e064b5;
                        }
                    }
                }
            }
        }
    }
    return a_s_result;
}

// Namespace namespace_8955127e/util_shared
// Params 1, eflags: 0x0
// Checksum 0xc8071f65, Offset: 0xdec0
// Size: 0xa0
function callback(str_kvp) {
    var_a58eb924 = function_e9536da8(str_kvp);
    if (var_a58eb924.size) {
        foreach (var_a3e064b5 in var_a58eb924) {
            var_a3e064b5 notify(str_kvp);
        }
    }
}

// Namespace namespace_8955127e/util_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0xce6289f2, Offset: 0xdf68
// Size: 0xca
function custom_callback(str_name, str_kvp, ...) {
    var_a58eb924 = function_e9536da8(str_kvp, str_name);
    if (var_a58eb924.size) {
        foreach (var_a3e064b5 in var_a58eb924) {
            var_a3e064b5 notify(str_name, {#params:vararg});
        }
    }
}

// Namespace namespace_8955127e/util_shared
// Params 0, eflags: 0x0
// Checksum 0x83c6fa71, Offset: 0xe040
// Size: 0x1e
function function_b1bfe502() {
    self.var_5bab0a85 = undefined;
    self notify(#"hash_29bf696e43d4a08b");
}

// Namespace namespace_8955127e/util_shared
// Params 1, eflags: 0x0
// Checksum 0x8dac7c93, Offset: 0xe068
// Size: 0x3a
function function_4d0b5c9a(str_kvp) {
    return util::get_array(self.(str_kvp + "_target"), str_kvp + "_src");
}

// Namespace namespace_8955127e/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3232847f, Offset: 0xe0b0
// Size: 0x3a
function get_target_structs(str_kvp) {
    return util::get_array(self.(str_kvp + "_src"), str_kvp + "_target");
}

