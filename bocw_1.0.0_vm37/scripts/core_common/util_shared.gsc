#using script_3d703ef87a841fe4;
#using script_4194df57536e11ed;
#using script_51e19a6cd0b4d30f;
#using script_7f6cd71c43c45c57;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;

#namespace util;

// Namespace util/util_shared
// Params 0, eflags: 0x6
// Checksum 0xc9b6cd63, Offset: 0x390
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"util_shared", &preinit, undefined, &function_3cb7a62d, undefined);
}

// Namespace util/util_shared
// Params 0, eflags: 0x4
// Checksum 0x1901e72e, Offset: 0x3e0
// Size: 0x9c
function private preinit() {
    level.var_9fee970c = function_60d95f53();
    function_73fab74d();
    function_f9ce1d49();
    register_clientfields();
    namespace_1e38a8f6::init();
    /#
        function_5ac4dc99("<dev string:x38>", 0);
    #/
    /#
        function_5ac4dc99("<dev string:x4d>", 1);
    #/
}

// Namespace util/level_preinit
// Params 1, eflags: 0x44
// Checksum 0x1974a2e9, Offset: 0x488
// Size: 0x20
function private event_handler[level_preinit] function_95d3192c(eventstruct) {
    level.var_1c5d2bf4 = eventstruct.var_6dfed201;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x90150d01, Offset: 0x4b0
// Size: 0x64
function register_clientfields() {
    clientfield::register("world", "cf_team_mapping", 1, 1, "int");
    clientfield::register("world", "preload_frontend", 1, 1, "int");
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x43a1b572, Offset: 0x520
    // Size: 0xa4
    function error(msg) {
        println("<dev string:x64>", msg);
        if (!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame()) {
            waitframe(1);
        }
        if (getdvar(#"debug", 0)) {
            assertmsg("<dev string:x72>");
        }
    }

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd01fa58, Offset: 0x5d0
    // Size: 0x34
    function warning(msg) {
        println("<dev string:xa2>" + msg);
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0xef1f7879, Offset: 0x610
// Size: 0xc
function void(...) {
    
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x9f274bd9, Offset: 0x628
// Size: 0xea
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
// Checksum 0x604b5be3, Offset: 0x720
// Size: 0x54
function preload_frontend() {
    level clientfield::set("preload_frontend", 1);
    wait_network_frame();
    level clientfield::set("preload_frontend", 0);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x16e7e888, Offset: 0x780
// Size: 0x7e
function clear_streamer_hint() {
    if (isdefined(self.var_5cc1b17f)) {
        for (i = 0; i < self.var_5b9d3645; i++) {
            self.var_5cc1b17f[i] delete();
        }
    }
    self.var_5b9d3645 = 0;
    self.var_5cc1b17f = [];
    self notify(#"wait_clear_streamer_hint");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6cf1da18, Offset: 0x808
// Size: 0xb4
function function_f6847a11() {
    if (self == level) {
        foreach (player in getplayers()) {
            player clear_streamer_hint();
        }
    }
    self clear_streamer_hint();
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe061bdf1, Offset: 0x8c8
// Size: 0x54
function wait_clear_streamer_hint(lifetime) {
    self endon(#"wait_clear_streamer_hint");
    self waittilltimeout(lifetime, #"clear_streamer_hint");
    if (isdefined(self)) {
        self clear_streamer_hint();
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xdc79c1f6, Offset: 0x928
// Size: 0x4c
function function_35840de8(seconds) {
    if (isdefined(seconds) && float(seconds) > 0) {
        wait float(seconds);
    }
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0x5a440266, Offset: 0x980
// Size: 0x164
function create_streamer_hint(origin, angles, value, lifetime, lightstate, clear = 1) {
    if (clear) {
        function_f6847a11();
    }
    if (!isdefined(self.var_5cc1b17f)) {
        self.var_5cc1b17f = [];
        self.var_5b9d3645 = 0;
    }
    var_c1b815dc = createstreamerhint(origin, value, lightstate);
    self.var_5cc1b17f[self.var_5b9d3645] = var_c1b815dc;
    self.var_5b9d3645++;
    if (isdefined(angles)) {
        var_c1b815dc.angles = angles;
    }
    if (self != level) {
        var_c1b815dc setinvisibletoall();
        var_c1b815dc setvisibletoplayer(self);
    }
    var_c1b815dc setincludemeshes(1);
    self notify(#"wait_clear_streamer_hint");
    if (isdefined(lifetime) && lifetime > 0) {
        self thread wait_clear_streamer_hint(lifetime);
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xf19e7529, Offset: 0xaf0
// Size: 0xc2
function function_819c50c3(n_stream_request_id, str_scenedef) {
    if (isarray(self.var_16672042) && isdefined(self.var_16672042[str_scenedef])) {
        var_5a2f2554 = self.var_16672042[str_scenedef];
    } else {
        var_5a2f2554 = isdefined(n_stream_request_id) ? n_stream_request_id : self.var_ecd30af1;
    }
    if (isdefined(var_5a2f2554)) {
        if (var_5a2f2554 == -1) {
            return 1;
        }
        return self isstreamerready(var_5a2f2554);
    }
    return self isstreamerready();
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0xa37b0d85, Offset: 0xbc0
    // Size: 0x9a
    function function_20120d2a(n_stream_request_id, str_scenedef) {
        if (isdefined(str_scenedef)) {
            return ("<dev string:xb1>" + function_9e72a96(str_scenedef) + "<dev string:xb6>");
        }
        return "<dev string:xb1>" + (isdefined(isdefined(n_stream_request_id) ? n_stream_request_id : self.var_ecd30af1) ? isdefined(n_stream_request_id) ? n_stream_request_id : self.var_ecd30af1 : -1) + "<dev string:xb6>";
    }

#/

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x9d1644e8, Offset: 0xc68
// Size: 0x5dc
function streamer_wait(n_stream_request_id, n_wait_frames = 0, n_timeout = 15, str_team, str_scenedef) {
    /#
        var_62c78ae = getdvarint(#"hash_4eb9ff1768129046", 0);
        if (getdvarint(#"hash_6187089da5dd2a15", 1) != 0 && !is_true(var_62c78ae)) {
            waitframe(1);
            return;
        }
        reason = "<dev string:xbb>";
        request = "<dev string:xbb>";
        start = gettime();
        var_e1f110d9 = start + 5000;
    #/
    level flag::increment("streamer_waits");
    var_b737eb14 = 1;
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
                a_players = getplayers(str_team);
            } else {
                a_players = getplayers();
            }
            foreach (player in a_players) {
                if (!player function_819c50c3(n_stream_request_id, str_scenedef)) {
                    /#
                        request = "<dev string:xbf>" + player function_20120d2a(n_stream_request_id, str_scenedef);
                    #/
                    continue;
                }
                n_num_streamers_ready++;
            }
            if (n_timeout > 0 && gettime() > timeout) {
                /#
                    if (n_timeout > 5) {
                        iprintln("<dev string:xc9>");
                        debug2dtext((50, 50, 0), "<dev string:x121>", (1, 0, 0), 1, (0, 0, 0), 0, 2, 40);
                        reason = "<dev string:x135>" + request + "<dev string:x13b>" + n_timeout;
                    }
                #/
                break;
            }
            var_b737eb14 = n_num_streamers_ready < max(1, a_players.size);
            /#
                if (var_62c78ae > 1 && var_b737eb14 && gettime() > var_e1f110d9) {
                    iprintlnbold("<dev string:x148>" + request + "<dev string:x15b>");
                    var_e1f110d9 = gettime() + 5000;
                }
            #/
        } while (var_b737eb14);
        /#
            if (!var_b737eb14) {
                reason = request + "<dev string:x169>" + float(gettime() - start) / 1000;
            }
        #/
    } else {
        self endon(#"disconnect");
        /#
            request = "<dev string:x177>" + self function_20120d2a(n_stream_request_id, str_scenedef);
        #/
        var_b737eb14 = 1;
        do {
            wait_network_frame();
            if (n_timeout > 0 && gettime() > timeout) {
                /#
                    reason = "<dev string:x135>" + request + "<dev string:x13b>" + n_timeout;
                #/
                break;
            }
            if (self function_819c50c3(n_stream_request_id, str_scenedef)) {
                var_b737eb14 = 0;
            }
            /#
                if (var_62c78ae > 1 && var_b737eb14 && gettime() > var_e1f110d9) {
                    iprintlnbold("<dev string:x148>" + request + "<dev string:x15b>");
                    var_e1f110d9 = gettime() + 5000;
                }
            #/
        } while (var_b737eb14);
        /#
            if (!var_b737eb14) {
                reason = request + "<dev string:x169>" + float(gettime() - start) / 1000;
            }
        #/
    }
    /#
        if (var_62c78ae > 1) {
            iprintlnbold("<dev string:x148>" + reason);
        }
    #/
    level flag::decrement("streamer_waits");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x116fe919, Offset: 0x1250
// Size: 0x6e
function function_52d401ed() {
    if (isbot(self)) {
        return false;
    }
    if (is_true(self.hasspawned)) {
        return false;
    }
    if (gamestate::is_state(#"pregame")) {
        return false;
    }
    return true;
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x146bfeaf, Offset: 0x12c8
// Size: 0x1f6
function function_21678f2c(players, timeout = getdvarint(#"hash_6974ec4bbf3b9e97"), mintime = 2000, var_552f6263 = 0) {
    starttime = gettime();
    while (true) {
        nowtime = gettime();
        if (nowtime - starttime > timeout) {
            waittillframeend();
            return;
        }
        if (nowtime - starttime > mintime) {
            var_351d88ca = 1;
            foreach (player in players) {
                if (!isdefined(player)) {
                    continue;
                }
                if (var_552f6263 && isdefined(player.predicted_spawn_point)) {
                    player setorigin(player.predicted_spawn_point.origin);
                    player setplayerangles(player.predicted_spawn_point.angles);
                }
                if (!player isstreamerready(-1, 1)) {
                    var_351d88ca = 0;
                }
                player resetinactivitytimer();
            }
            if (var_351d88ca) {
                waittillframeend();
                return;
            }
        }
        waitframe(1);
    }
}

/#

    // Namespace util/util_shared
    // Params 3, eflags: 0x0
    // Checksum 0x9a6e1efb, Offset: 0x14c8
    // Size: 0x72
    function draw_debug_line(start, end, timer) {
        for (i = 0; i < timer * 20; i++) {
            line(start, end, (1, 1, 0.5));
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 6, eflags: 0x0
    // Checksum 0xfe325c99, Offset: 0x1548
    // Size: 0x94
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
    // Checksum 0xc0fc4866, Offset: 0x15e8
    // Size: 0xbc
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
    // Checksum 0xca73372f, Offset: 0x16b0
    // Size: 0xb4
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
    // Checksum 0x8682c011, Offset: 0x1770
    // Size: 0xd6
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
    // Checksum 0xd02ebc59, Offset: 0x1850
    // Size: 0x274
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
    // Checksum 0x4d28fdcc, Offset: 0x1ad0
    // Size: 0x1d4
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
    // Checksum 0xc5a0b1d6, Offset: 0x1cb0
    // Size: 0x1d6
    function debugorigin() {
        self notify(#"debug origin");
        self endon(#"debug origin", #"death");
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
    // Checksum 0xca08352b, Offset: 0x1e90
    // Size: 0xa6
    function draw_line_for_time(org1, org2, r, g, b, timer) {
        timer = gettime() + timer * 1000;
        while (gettime() < timer) {
            line(org1, org2, (r, g, b), 1);
            recordline(org1, org2, (1, 1, 1), "<dev string:x182>");
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 6, eflags: 0x0
    // Checksum 0x20cf9639, Offset: 0x1f40
    // Size: 0x14c
    function function_6844bea4(*radius1, radius2, time, color, origin, normal) {
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
// Checksum 0x53a89d8c, Offset: 0x2098
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
// Checksum 0x7150f9b8, Offset: 0x20d8
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
// Checksum 0xab4eab09, Offset: 0x2160
// Size: 0x80
function waittill_level_string(msg, ent, otherent) {
    otherent endon(#"death");
    ent endon(#"die");
    level waittill(msg);
    ent notify(#"returned", {#msg:msg});
}

// Namespace util/util_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0x3d1d8009, Offset: 0x21e8
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
// Params 1, eflags: 0x0
// Checksum 0x76857c04, Offset: 0x2290
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
// Checksum 0xd4d97958, Offset: 0x2348
// Size: 0x1a4
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
// Checksum 0x526cbea0, Offset: 0x24f8
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
// Checksum 0x4931edbd, Offset: 0x25b0
// Size: 0x1ba
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
// Checksum 0x26bf5170, Offset: 0x2778
// Size: 0x56
function _timeout(delay) {
    self endon(#"die");
    wait delay;
    self notify(#"returned", {#msg:"timeout"});
}

// Namespace util/util_shared
// Params 14, eflags: 0x0
// Checksum 0x40b8d7ff, Offset: 0x27d8
// Size: 0x14a
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
// Checksum 0x9734750e, Offset: 0x2930
// Size: 0x78
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
// Checksum 0xca77faf8, Offset: 0x29b0
// Size: 0x20
function isflashed() {
    if (!isdefined(self.flashendtime)) {
        return false;
    }
    return gettime() < self.flashendtime;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x1fb6fc1e, Offset: 0x29d8
// Size: 0x20
function isstunned() {
    if (!isdefined(self.flashendtime)) {
        return false;
    }
    return gettime() < self.flashendtime;
}

// Namespace util/util_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0xed91b15c, Offset: 0x2a00
// Size: 0x32
function single_func(entity, func, ...) {
    return _single_func(entity, func, vararg);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xdac8ca6c, Offset: 0x2a40
// Size: 0x32
function single_func_argarray(entity, func, a_vars) {
    return _single_func(entity, func, a_vars);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xf4270bc3, Offset: 0x2a80
// Size: 0x48a
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
        assertmsg("<dev string:x18c>");
        break;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe92e9535, Offset: 0x2f18
// Size: 0x64
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
// Checksum 0x51636077, Offset: 0x2f88
// Size: 0xae
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
// Checksum 0x545c6371, Offset: 0x3040
// Size: 0x5a
function call_func(s_func) {
    return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

// Namespace util/util_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x43cb28a4, Offset: 0x30a8
// Size: 0x3c
function single_thread(entity, func, ...) {
    _single_thread(entity, func, undefined, undefined, vararg);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x7553ec06, Offset: 0x30f0
// Size: 0x3c
function single_thread_argarray(entity, func, &a_vars) {
    _single_thread(entity, func, undefined, undefined, a_vars);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x42e49479, Offset: 0x3138
// Size: 0x44
function function_50f54b6f(entity, func, arg1, &a_vars) {
    _single_thread(entity, func, arg1, undefined, a_vars);
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x880ea779, Offset: 0x3188
// Size: 0x4c
function function_cf55c866(entity, func, arg1, arg2, &a_vars) {
    _single_thread(entity, func, arg1, arg2, a_vars);
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x55941fb0, Offset: 0x31e0
// Size: 0x85a
function _single_thread(entity, func, arg1, arg2, &a_vars) {
    _clean_up_arg_array(a_vars);
    assert(isfunctionptr(func), "<dev string:x19e>" + "<dev string:x1b6>");
    if (!isfunctionptr(func)) {
        return;
    }
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
            assertmsg("<dev string:x18c>");
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
            assertmsg("<dev string:x18c>");
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
        assertmsg("<dev string:x18c>");
        break;
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xfedb839, Offset: 0x3a48
// Size: 0xca
function script_delay() {
    n_time = gettime();
    self.var_653e059d = 1;
    function_35840de8(self.script_delay);
    n_min_delay = isdefined(self.script_delay_min) ? self.script_delay_min : 0;
    n_max_delay = isdefined(self.script_delay_max) ? self.script_delay_max : 0;
    if (n_max_delay > n_min_delay) {
        wait randomfloatrange(n_min_delay, n_max_delay);
    } else if (n_min_delay > 0) {
        wait n_min_delay;
    }
    if (isdefined(self)) {
        self.var_653e059d = undefined;
    }
    return gettime() - n_time;
}

// Namespace util/util_shared
// Params 8, eflags: 0x0
// Checksum 0x31bfc5c3, Offset: 0x3b20
// Size: 0xb4
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
// Checksum 0x23fd15af, Offset: 0x3be0
// Size: 0x78
function create_flags_and_return_tokens(flags) {
    tokens = strtok(flags, " ");
    for (i = 0; i < tokens.size; i++) {
        level trigger::function_ac2f203a(tokens[i]);
    }
    return tokens;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xcd8e3d42, Offset: 0x3c60
// Size: 0xb8
function function_aebdb74f(str_flags) {
    a_str_flags = strtok(str_flags, " ");
    foreach (str_flag in a_str_flags) {
        level flag::set(str_flag);
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf2c325b6, Offset: 0x3d20
    // Size: 0x68
    function fileprint_start(file) {
        filename = file;
        file = openfile(filename, "<dev string:x1d3>");
        level.fileprint = file;
        level.fileprintlinecount = 0;
        level.fileprint_filename = filename;
    }

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x79e5babb, Offset: 0x3d90
    // Size: 0x5c
    function fileprint_map_start(file) {
        file = "<dev string:x1dc>" + file + "<dev string:x1eb>";
        fileprint_start(file);
        level.fileprint_mapentcount = 0;
        fileprint_map_header(1);
    }

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0xdd046784, Offset: 0x3df8
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
// Checksum 0x6a0c6489, Offset: 0x3e70
// Size: 0xf4
function fileprint_map_header(binclude_blank_worldspawn = 0) {
    assert(isdefined(level.fileprint));
    /#
        fileprint_chk(level.fileprint, "<dev string:x1f3>");
        fileprint_chk(level.fileprint, "<dev string:x1fe>");
        fileprint_chk(level.fileprint, "<dev string:x21c>");
        if (!binclude_blank_worldspawn) {
            return;
        }
        fileprint_map_entity_start();
        fileprint_map_keypairprint("<dev string:x22f>", "<dev string:x23c>");
        fileprint_map_entity_end();
    #/
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0xcdbc3af, Offset: 0x3f70
    // Size: 0x7c
    function fileprint_map_keypairprint(key1, key2) {
        assert(isdefined(level.fileprint));
        fileprint_chk(level.fileprint, "<dev string:x24a>" + key1 + "<dev string:x24f>" + key2 + "<dev string:x24a>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6ca4dfe9, Offset: 0x3ff8
    // Size: 0xb8
    function fileprint_map_entity_start() {
        assert(!isdefined(level.fileprint_entitystart));
        level.fileprint_entitystart = 1;
        assert(isdefined(level.fileprint));
        fileprint_chk(level.fileprint, "<dev string:x256>" + level.fileprint_mapentcount);
        fileprint_chk(level.fileprint, "<dev string:x264>");
        level.fileprint_mapentcount++;
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7b3b9dd4, Offset: 0x40b8
    // Size: 0x74
    function fileprint_map_entity_end() {
        assert(isdefined(level.fileprint_entitystart));
        assert(isdefined(level.fileprint));
        level.fileprint_entitystart = undefined;
        fileprint_chk(level.fileprint, "<dev string:x269>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe9ee5efb, Offset: 0x4138
    // Size: 0x262
    function fileprint_end() {
        assert(!isdefined(level.fileprint_entitystart));
        saved = closefile(level.fileprint);
        if (saved != 1) {
            println("<dev string:x26e>");
            println("<dev string:x295>");
            println("<dev string:x29a>");
            println("<dev string:x2b0>" + level.fileprint_filename);
            println("<dev string:x2c4>");
            println("<dev string:x2fe>");
            println("<dev string:x33d>");
            println("<dev string:x37c>");
            println("<dev string:x3c5>");
            println("<dev string:x295>");
            println("<dev string:x3e2>");
            println("<dev string:x428>");
            println("<dev string:x46f>");
            println("<dev string:x4ae>");
            println("<dev string:x4f5>");
            println("<dev string:x535>");
            println("<dev string:x577>");
            println("<dev string:x295>");
            println("<dev string:x26e>");
            println("<dev string:x5bd>");
        }
        level.fileprint = undefined;
        level.fileprint_filename = undefined;
    }

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe6eebf98, Offset: 0x43a8
    // Size: 0x62
    function fileprint_radiant_vec(vector) {
        string = "<dev string:xbb>" + vector[0] + "<dev string:x295>" + vector[1] + "<dev string:x295>" + vector[2] + "<dev string:xbb>";
        return string;
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xcd2c959f, Offset: 0x4418
// Size: 0x8e
function death_notify_wrapper(attacker, damagetype) {
    level notify(#"face", {#face_notify:"death", #entity:self});
    self notify(#"death", {#attacker:attacker, #mod:damagetype});
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0x44a2193e, Offset: 0x44b0
// Size: 0x136
function damage_notify_wrapper(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags) {
    level notify(#"face", {#face_notify:"damage", #entity:self});
    self notify(#"damage", {#amount:damage, #attacker:attacker, #direction:direction_vec, #position:point, #mod:type, #model_name:modelname, #tag_name:tagname, #part_name:partname, #flags:idflags});
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x8764f866, Offset: 0x45f0
// Size: 0x5e
function explode_notify_wrapper() {
    level notify(#"face", {#face_notify:"explode", #entity:self});
    self notify(#"explode");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xddd16df2, Offset: 0x4658
// Size: 0x5e
function alert_notify_wrapper() {
    level notify(#"face", {#face_notify:"alert", #entity:self});
    self notify(#"alert");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6b433579, Offset: 0x46c0
// Size: 0x5e
function shoot_notify_wrapper() {
    level notify(#"face", {#face_notify:"shoot", #entity:self});
    self notify(#"shoot");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe6f5d3a3, Offset: 0x4728
// Size: 0x5e
function melee_notify_wrapper() {
    level notify(#"face", {#face_notify:"melee", #entity:self});
    self notify(#"melee");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x337cc1a9, Offset: 0x4790
// Size: 0xc
function isusabilityenabled() {
    return !self.disabledusability;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x34ea248b, Offset: 0x47a8
// Size: 0x24
function _disableusability() {
    self.disabledusability++;
    self disableusability();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb70dead8, Offset: 0x47d8
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
// Checksum 0xcdc17312, Offset: 0x4838
// Size: 0x24
function resetusability() {
    self.disabledusability = 0;
    self enableusability();
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x5ed696ad, Offset: 0x4868
// Size: 0xe2
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
// Checksum 0x422703a0, Offset: 0x4958
// Size: 0x74
function delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0x8cdb5fd8, Offset: 0x49d8
// Size: 0x11c
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
    if (iscodefunctionptr(func)) {
        single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
        return;
    }
    single_thread(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0x336f4104, Offset: 0x4b00
// Size: 0x74
function delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self thread _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0xa95038d8, Offset: 0x4b80
// Size: 0xa4
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
// Checksum 0x833571c4, Offset: 0x4c30
// Size: 0x44
function delay_notify(time_or_notify, str_notify, str_endon, arg1) {
    self thread _delay_notify(time_or_notify, str_notify, str_endon, arg1);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x1318442c, Offset: 0x4c80
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
// Checksum 0x66a26ae2, Offset: 0x4d28
// Size: 0x6c
function get_closest_player(org, team) {
    team = get_team_mapping(team);
    players = getplayers(team);
    return arraysort(players, org, 1, 1)[0];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x32c69208, Offset: 0x4da0
// Size: 0xea
function registerclientsys(ssysname) {
    if (!isdefined(level._clientsys)) {
        level._clientsys = [];
    }
    if (level._clientsys.size >= 32) {
        assertmsg("<dev string:x5ec>");
        return;
    }
    if (isdefined(level._clientsys[ssysname])) {
        assertmsg("<dev string:x610>" + ssysname);
        return;
    }
    level._clientsys[ssysname] = spawnstruct();
    level._clientsys[ssysname].sysid = clientsysregister(ssysname);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x6cde8fa5, Offset: 0x4e98
// Size: 0x10e
function setclientsysstate(ssysname, ssysstate, player) {
    if (!isdefined(level._clientsys)) {
        assertmsg("<dev string:x63b>");
        return;
    }
    if (!isdefined(level._clientsys[ssysname])) {
        assertmsg("<dev string:x67b>" + ssysname);
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
// Checksum 0x5c5bbaeb, Offset: 0x4fb0
// Size: 0xce
function getclientsysstate(ssysname) {
    if (!isdefined(level._clientsys)) {
        assertmsg("<dev string:x6af>");
        return "";
    }
    if (!isdefined(level._clientsys[ssysname])) {
        assertmsg("<dev string:x6f2>" + ssysname + "<dev string:x704>");
        return "";
    }
    if (isdefined(level._clientsys[ssysname].sysstate)) {
        return level._clientsys[ssysname].sysstate;
    }
    return "";
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe93d5209, Offset: 0x5088
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
// Checksum 0x27746b42, Offset: 0x5100
// Size: 0x46
function coopgame() {
    return sessionmodeissystemlink() || sessionmodeisonlinegame() || issplitscreen();
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x6e033800, Offset: 0x5150
// Size: 0x19e
function is_looking_at(ent_or_org, n_dot_range = 0.9, do_trace = 0, v_offset) {
    assert(isdefined(ent_or_org), "<dev string:x734>");
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
// Checksum 0xfae54bf7, Offset: 0x52f8
// Size: 0x4c
function get_eye() {
    if (isplayer(self)) {
        return self getplayercamerapos();
    }
    return self geteye();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x5d809256, Offset: 0x5350
// Size: 0x24
function is_ads() {
    return self playerads() > 0.5;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x35a41cf9, Offset: 0x5380
// Size: 0x2c
function function_e05fc3fb(isplaying) {
    self flag::set_val(#"hash_2b62b2990144ebf6", isplaying);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x65a08e01, Offset: 0x53b8
// Size: 0x22
function function_a1d6293() {
    return self flag::get(#"hash_2b62b2990144ebf6");
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x904205eb, Offset: 0x53e8
// Size: 0x146
function spawn_model(model_name, origin = (0, 0, 0), angles = (0, 0, 0), n_spawnflags = 0, b_throttle = 0) {
    while (true) {
        if (b_throttle) {
            spawner::global_spawn_throttle(4);
        }
        model = spawn("script_model", origin, n_spawnflags);
        if (isdefined(model)) {
            break;
        } else {
            println("<dev string:x76f>" + "<dev string:x784>" + model_name + "<dev string:x7a0>" + origin + "<dev string:x7af>" + angles);
        }
        waitframe(1);
    }
    model setmodel(model_name);
    model.angles = angles;
    return model;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0xd4652248, Offset: 0x5538
// Size: 0x8e
function spawn_anim_model(model_name, origin, angles, n_spawnflags = 0, b_throttle) {
    model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
    model useanimtree("generic");
    model.animtree = "generic";
    return model;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x9763f24a, Offset: 0x55d0
// Size: 0x8e
function spawn_anim_player_model(model_name, origin, angles, n_spawnflags = 0, b_throttle) {
    model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
    model useanimtree("all_player");
    model.animtree = "all_player";
    return model;
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xcf6536ff, Offset: 0x5668
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
// Checksum 0xc433c94b, Offset: 0x5720
// Size: 0x58
function waittill_player_not_looking_at(origin, dot, do_trace) {
    self endon(#"death");
    while (is_player_looking_at(origin, dot, do_trace)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x9703000d, Offset: 0x5780
// Size: 0x1b8
function is_player_looking_at(v_origin, n_dot = 0.7, b_do_trace = 1, e_ignore, var_c4943182) {
    assert(isplayer(self), "<dev string:x7bd>");
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
            return bullettracepassed(v_origin, v_eye, 0, e_ignore, var_c4943182);
        } else {
            return 1;
        }
    }
    return 0;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x444a4f19, Offset: 0x5940
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
// Checksum 0xb93b2e4c, Offset: 0x59c0
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
// Checksum 0xe2f71cf5, Offset: 0x5a50
// Size: 0x42
function new_timer(n_timer_length) {
    s_timer = spawnstruct();
    s_timer.n_time_created = gettime();
    s_timer.n_length = n_timer_length;
    return s_timer;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc9df4834, Offset: 0x5aa0
// Size: 0x20
function get_time() {
    t_now = gettime();
    return t_now - self.n_time_created;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x61e536c4, Offset: 0x5ac8
// Size: 0x34
function get_time_in_seconds() {
    return float(get_time()) / 1000;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x514783f2, Offset: 0x5b08
// Size: 0x4a
function get_time_frac(n_end_time = self.n_length) {
    return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe2fee654, Offset: 0x5b60
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
// Checksum 0x79e19819, Offset: 0x5bc0
// Size: 0x16
function is_time_left() {
    return get_time_left() != 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe43517a8, Offset: 0x5be0
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
// Checksum 0x636ecf73, Offset: 0x5c50
// Size: 0x36
function is_primary_damage(meansofdeath) {
    if (meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET") {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x7d38226a, Offset: 0x5c90
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
// Checksum 0x149fc9a5, Offset: 0x5cf0
// Size: 0xa4
function delete_on_death_or_notify(e_to_delete, str_notify, str_clientfield = undefined) {
    e_to_delete endon(#"death");
    self waittill(#"death", str_notify);
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
// Checksum 0x822f1db0, Offset: 0x5da0
// Size: 0xa8
function wait_till_not_touching(e_to_check, e_to_touch) {
    assert(isdefined(e_to_check), "<dev string:x7ee>");
    assert(isdefined(e_to_touch), "<dev string:x82f>");
    e_to_check endon(#"death");
    e_to_touch endon(#"death");
    while (e_to_check istouching(e_to_touch)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x84990c07, Offset: 0x5e50
// Size: 0xe4
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
// Checksum 0x590f3b04, Offset: 0x5f40
// Size: 0x134
function set_console_status() {
    if (!isdefined(level.console)) {
        level.console = getdvarstring(#"consolegame") == "true";
    } else {
        assert(level.console == getdvarstring(#"consolegame") == "<dev string:x870>", "<dev string:x878>");
    }
    if (!isdefined(level.xenon)) {
        level.xenon = getdvarstring(#"xenongame") == "true";
        return;
    }
    assert(level.xenon == getdvarstring(#"xenongame") == "<dev string:x870>", "<dev string:x89e>");
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x94bf2010, Offset: 0x6080
// Size: 0x14
function waittill_asset_loaded(*str_type, *str_name) {
    
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4e8d99cb, Offset: 0x60a0
// Size: 0x60
function function_e387bcd() {
    if (!isdefined(self)) {
        return false;
    }
    if (isdefined(self.script_wait)) {
        return true;
    }
    if (isdefined(self.script_wait_add)) {
        return true;
    }
    if (isdefined(self.script_wait_min)) {
        return true;
    }
    if (isdefined(self.script_wait_max)) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x19bcac9f, Offset: 0x6108
// Size: 0xbc
function function_4b93f9c2() {
    result = 0;
    if (isdefined(self.script_wait)) {
        result += self.script_wait;
    }
    n_min = isdefined(self.script_wait_min) ? self.script_wait_min : 0;
    n_max = isdefined(self.script_wait_max) ? self.script_wait_max : 0;
    if (n_max > n_min) {
        result += randomfloatrange(n_min, n_max);
    } else if (n_min > 0) {
        result += n_min;
    }
    return result;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe6ffd043, Offset: 0x61d0
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
// Params 2, eflags: 0x0
// Checksum 0x9f642e39, Offset: 0x6338
// Size: 0x34
function send_notify(msg, optional_param) {
    if (isdefined(optional_param)) {
        self notify(msg, optional_param);
        return;
    }
    self notify(msg);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x20241389, Offset: 0x6378
// Size: 0x20
function is_killstreaks_enabled() {
    return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb50f1e23, Offset: 0x63a0
// Size: 0x1e
function is_flashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xa95ac414, Offset: 0x63c8
// Size: 0x112
function magic_bullet_shield(ent = self) {
    ent val::set(#"magic_bullet_shield", "allowdeath", 0);
    ent.magic_bullet_shield = 1;
    /#
        ent notify(#"_stop_magic_bullet_shield_debug");
        level thread debug_magic_bullet_shield_death(ent);
    #/
    assert(isalive(ent), "<dev string:x8c2>");
    if (isai(ent)) {
        if (isactor(ent)) {
            ent bloodimpact("hero");
        }
        ent.attackeraccuracy = 0.1;
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5ea0f92a, Offset: 0x64e8
    // Size: 0x13c
    function debug_magic_bullet_shield_death(guy) {
        targetname = "<dev string:x901>";
        if (isdefined(guy.targetname)) {
            targetname = guy.targetname;
        }
        guy endon(#"stop_magic_bullet_shield", #"_stop_magic_bullet_shield_debug");
        wait_result = guy waittill(#"death");
        if (!is_true(level.var_5be43b2d) && getdvarint(#"enable_moving_paths", 0) && !is_true(guy.in_melee_death) && !is_true(guy.var_16735873)) {
            assert(!isdefined(guy), "<dev string:x909>" + targetname);
        }
    }

#/

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xbdd3ce28, Offset: 0x6630
// Size: 0x378
function spawn_player_clone(player, animname, s_align, var_df23b31f = 0) {
    playerclone = spawn("script_model", player.origin);
    playerclone.angles = player.angles;
    playerclone.var_8323de3e = 1;
    if (player function_390cb543()) {
        var_1749f1e8 = player function_92ea4100();
        if (isdefined(var_1749f1e8)) {
            playerclone setmodel(var_1749f1e8);
        }
        headmodel = player startquantity();
        if (isdefined(headmodel)) {
            playerclone attach(headmodel);
        }
    } else {
        var_41206ae3 = player function_5d23af5b();
        if (isdefined(var_41206ae3)) {
            playerclone setmodel(var_41206ae3);
        }
        headmodel = player startquantity();
        if (isdefined(headmodel) && !playerclone isattached(headmodel)) {
            playerclone attach(headmodel);
        }
        var_b4d88433 = player function_cde23658();
        if (isdefined(var_b4d88433) && !playerclone isattached(var_b4d88433)) {
            playerclone attach(var_b4d88433);
        }
        var_1749f1e8 = player function_92ea4100();
        if (isdefined(var_1749f1e8) && !playerclone isattached(var_1749f1e8)) {
            playerclone attach(var_1749f1e8);
        }
    }
    playerclone function_1fac41e4(player function_19124308());
    if (var_df23b31f) {
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
// Checksum 0x7576b604, Offset: 0x69b0
// Size: 0xc8
function stop_magic_bullet_shield(ent = self) {
    ent val::reset(#"magic_bullet_shield", "allowdeath");
    ent.magic_bullet_shield = undefined;
    if (isai(ent)) {
        if (isactor(ent)) {
            ent bloodimpact("normal");
            ent.allowdeath = 1;
        }
        ent.attackeraccuracy = 1;
    }
    ent notify(#"stop_magic_bullet_shield");
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x6dfb0b38, Offset: 0x6a80
// Size: 0x46
function get_rounds_won(team) {
    team = get_team_mapping(team);
    return game.stat[#"roundswon"][team];
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x2aee1149, Offset: 0x6ad0
// Size: 0x8c
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x994ac645, Offset: 0x6b68
// Size: 0xca
function has_tac_vis(target, var_2e4f087a) {
    if (isentity(target)) {
        target = target.origin;
    }
    tacpoint = getclosesttacpoint(self.origin);
    var_fe33f767 = 0;
    if (isdefined(tacpoint)) {
        var_fe33f767 = function_96c81b85(tacpoint, target);
    }
    if (var_fe33f767 && is_true(var_2e4f087a)) {
        var_fe33f767 = self point_in_fov(target);
    }
    return var_fe33f767;
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x7b6dea39, Offset: 0x6c40
// Size: 0xa2
function point_in_fov(origin, fov, checkpitch) {
    from_origin = self.origin;
    var_5e321cee = self.angles;
    if (isplayer(self) && is_true(checkpitch)) {
        var_5e321cee = self getplayerangles();
    }
    return function_aae7d83d(from_origin, var_5e321cee, origin, fov);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xaa1f85a8, Offset: 0x6cf0
// Size: 0xac
function function_aae7d83d(from_origin, var_5e321cee, origin, fov) {
    if (!isdefined(origin)) {
        return false;
    }
    if (!isdefined(fov)) {
        fov = 0.766;
    }
    forward = anglestoforward(var_5e321cee);
    normalvec = vectornormalize(origin - from_origin);
    dot = vectordot(forward, normalvec);
    return dot > fov;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe736d47d, Offset: 0x6da8
// Size: 0x14c
function button_held_think(which_button) {
    self endon(#"disconnect");
    if (!isdefined(self._holding_button)) {
        self._holding_button = [];
    }
    self._holding_button[which_button] = 0;
    time_started = 0;
    while (true) {
        usinggamepad = self gamepadusedlast();
        use_time = usinggamepad ? 250 : 0;
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
// Checksum 0x90e017bf, Offset: 0x6f00
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
// Checksum 0xa1987782, Offset: 0x6f58
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
// Checksum 0xf9df84dd, Offset: 0x6fb8
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
// Checksum 0xb9fe4f4a, Offset: 0x7018
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
// Checksum 0x7c86a4f, Offset: 0x7078
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
// Checksum 0x6ae0854d, Offset: 0x70d8
// Size: 0x28
function waittill_use_button_pressed() {
    while (!self usebuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x62cb1b3, Offset: 0x7108
// Size: 0x28
function waittill_use_button_held() {
    while (!self use_button_held()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x27ff7e56, Offset: 0x7138
// Size: 0x28
function waittill_stance_button_pressed() {
    while (!self stancebuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x31113afc, Offset: 0x7168
// Size: 0x28
function function_a29c8ab9() {
    while (!self jumpbuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x113600f0, Offset: 0x7198
// Size: 0x28
function waittill_stance_button_held() {
    while (!self stance_button_held()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x96926fc6, Offset: 0x71c8
// Size: 0x28
function waittill_attack_button_pressed() {
    while (!self attackbuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x9ee52279, Offset: 0x71f8
// Size: 0x28
function waittill_ads_button_pressed() {
    while (!self adsbuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa66d6021, Offset: 0x7228
// Size: 0x28
function waittill_vehicle_move_up_button_pressed() {
    while (!self vehiclemoveupbuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x189b4b80, Offset: 0x7258
// Size: 0xc8
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
    // Checksum 0xbbd8c2c3, Offset: 0x7328
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
    // Checksum 0xff430530, Offset: 0x7398
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
    // Checksum 0xb2467391, Offset: 0x7408
    // Size: 0x46
    function up_button_pressed() {
        return self buttonpressed("<dev string:x943>") || self buttonpressed("<dev string:x94e>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf1835ff4, Offset: 0x7458
    // Size: 0x28
    function waittill_up_button_pressed() {
        while (!self up_button_pressed()) {
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x207f5ad6, Offset: 0x7488
    // Size: 0x46
    function down_button_pressed() {
        return self buttonpressed("<dev string:x959>") || self buttonpressed("<dev string:x966>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x40cc7418, Offset: 0x74d8
    // Size: 0x28
    function waittill_down_button_pressed() {
        while (!self down_button_pressed()) {
            waitframe(1);
        }
    }

#/

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x74d3ac4d, Offset: 0x7508
// Size: 0x34
function ishacked() {
    return isdefined(self.hacked) && self.hacked || is_true(self.ishacked);
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x978a410e, Offset: 0x7548
// Size: 0x5c
function function_fbce7263(team_a, team_b) {
    if (team_a === team_b || function_9b7092ef(team_a, team_b)) {
        return false;
    }
    if (!isdefined(team_a) || !isdefined(team_b)) {
        return true;
    }
    return true;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xf390c91a, Offset: 0x75b0
// Size: 0x4a
function isenemyteam(team) {
    assert(isdefined(team));
    if (!isdefined(self)) {
        return 0;
    }
    return function_fbce7263(team, self.team);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe841c04a, Offset: 0x7608
// Size: 0x80
function isfriendlyplayer(player) {
    if (!isplayer(player) || !isdefined(self)) {
        return false;
    }
    if (level.teambased) {
        return !isenemyteam(player.team);
    } else if (player == self) {
        return true;
    }
    return true;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xa42eb8d0, Offset: 0x7690
// Size: 0x7c
function isenemyplayer(player) {
    if (!isplayer(player) || !isdefined(self)) {
        return 0;
    }
    if (level.teambased) {
        return isenemyteam(player.team);
    } else if (player == self) {
        return 0;
    }
    return 1;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x7eab598f, Offset: 0x7718
// Size: 0x2c
function waittillslowprocessallowed() {
    while (level.lastslowprocessframe == gettime()) {
        waitframe(1);
    }
    level.lastslowprocessframe = gettime();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6d6ecaca, Offset: 0x7750
// Size: 0x10
function function_1ea0b2ce() {
    level.lastslowprocessframe = gettime();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x49f65fe0, Offset: 0x7768
// Size: 0x38
function function_64ebd94d() {
    while (level.lastslowprocessframe + 3 * function_60d95f53() >= gettime()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x3734592c, Offset: 0x77a8
// Size: 0x12
function get_start_time() {
    return getmicrosecondsraw();
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0x7bf965c8, Offset: 0x77c8
    // Size: 0xc4
    function note_elapsed_time(start_time, label = "unspecified") {
        elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
        if (!isdefined(start_time)) {
            return;
        }
        elapsed_time *= 0.001;
        msg = label + "<dev string:x973>" + elapsed_time + "<dev string:x986>";
        profileprintln(msg);
        iprintln(msg);
    }

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0x34202c20, Offset: 0x7898
    // Size: 0xa4
    function function_d11b3582(var_43692bd4, label = "unspecified") {
        if (!isdefined(var_43692bd4)) {
            return;
        }
        elapsed_time = var_43692bd4 * 0.001;
        msg = label + "<dev string:x973>" + elapsed_time + "<dev string:x986>";
        profileprintln(msg);
        iprintln(msg);
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xb28e16b2, Offset: 0x7948
// Size: 0x92
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
    // Checksum 0x1e7494a2, Offset: 0x79e8
    // Size: 0x1b4
    function note_elapsed_times(&elapsed_time_array, label = "unspecified") {
        if (!isarray(elapsed_time_array)) {
            return;
        }
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
        }
        average_elapsed_time = total_elapsed_time / elapsed_time_array.size;
        msg = label + "<dev string:x98d>" + smallest_elapsed_time + "<dev string:x9ae>" + average_elapsed_time + "<dev string:x9ae>" + largest_elapsed_time + "<dev string:x986>";
        profileprintln(msg);
        iprintln(msg);
    }

    // Namespace util/util_shared
    // Params 4, eflags: 0x0
    // Checksum 0xb46306ec, Offset: 0x7ba8
    // Size: 0x144
    function function_53966f9c(&elapsed_time_array, label = "unspecified", var_5461755f = 10, var_fe4c69e3 = 100) {
        if (elapsed_time_array.size % var_5461755f == 0) {
            note_elapsed_times(elapsed_time_array, label);
        }
        if (elapsed_time_array.size >= var_fe4c69e3) {
            keys = getarraykeys(elapsed_time_array);
            foreach (key in keys) {
                elapsed_time_array[key] = undefined;
            }
            arrayremovevalue(elapsed_time_array, undefined);
        }
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x617f25ef, Offset: 0x7cf8
// Size: 0x6c
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
// Checksum 0x4fb9d602, Offset: 0x7d70
// Size: 0x7c
function note_raw_time(label = "unspecified") {
    now = getmicrosecondsraw();
    msg = "us = " + now + " -- " + label;
    profileprintln(msg);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x678daf57, Offset: 0x7df8
// Size: 0x4e
function mayapplyscreeneffect() {
    assert(isdefined(self));
    assert(isplayer(self));
    return !isdefined(self.viewlockedentity);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6f62bf58, Offset: 0x7e50
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
// Checksum 0x7ec7a8a6, Offset: 0x7ef8
// Size: 0x6e
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
// Checksum 0x1c6969fe, Offset: 0x7f70
// Size: 0x12c
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
// Checksum 0x733d5812, Offset: 0x80a8
// Size: 0x56
function function_56353fe9(weaponname) {
    weapon = getweapon(weaponname);
    if (!isdefined(weapon) || weapon == level.weaponnone) {
        return undefined;
    }
    return weapon;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb5840eaa, Offset: 0x8108
// Size: 0xc
function isusingremote() {
    return isdefined(self.usingremote);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x53bfe298, Offset: 0x8120
// Size: 0x18
function function_63d27d4e(remotename) {
    return self.usingremote === remotename;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x31574699, Offset: 0x8140
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
// Params 0, eflags: 0x0
// Checksum 0xa9090e7c, Offset: 0x8210
// Size: 0x56
function function_9a39538a() {
    if (isdefined(self.carryicon)) {
        self.carryicon.alpha = 1;
    }
    self.usingremote = undefined;
    self enableoffhandweapons();
    self.killstreak_delay_killcam = undefined;
    self notify(#"stopped_using_remote");
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x276a626f, Offset: 0x8270
// Size: 0x74
function deleteaftertime(time) {
    assert(isdefined(self));
    assert(isdefined(time));
    assert(time >= 0.05);
    self thread deleteaftertimethread(time);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x38d2416, Offset: 0x82f0
// Size: 0x3c
function deleteaftertimethread(time) {
    self endon(#"death");
    wait time;
    self delete();
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xa97a388e, Offset: 0x8338
// Size: 0x34
function waitfortime(time = 0) {
    if (time > 0) {
        wait time;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x6dd1d761, Offset: 0x8378
// Size: 0x7a
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
// Checksum 0xfa0b0e11, Offset: 0x8400
// Size: 0x54
function deleteaftertimeandnetworkframe(time) {
    assert(isdefined(self));
    waitfortimeandnetworkframe(time);
    self delete();
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0x496a3c2f, Offset: 0x8460
// Size: 0x8c
function orientedbox(pos, var_e1d2ab75, angles, color, depthtest, duration) {
    mins = var_e1d2ab75 * -0.5;
    maxs = var_e1d2ab75 * 0.5;
    /#
        box(pos, mins, maxs, angles, color, depthtest, duration);
    #/
}

/#

    // Namespace util/util_shared
    // Params 7, eflags: 0x0
    // Checksum 0x66d6f18e, Offset: 0x84f8
    // Size: 0x74
    function drawcylinder(pos, rad, height, duration, stop_notify, color, alpha) {
        if (!isdefined(duration)) {
            duration = 0;
        }
        level thread drawcylinder_think(pos, rad, height, duration, stop_notify, color, alpha);
    }

    // Namespace util/util_shared
    // Params 7, eflags: 0x0
    // Checksum 0xf4f05428, Offset: 0x8578
    // Size: 0x2de
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
// Checksum 0xeffe2b2c, Offset: 0x8860
// Size: 0x2e
function spawn_array_struct() {
    s = spawnstruct();
    s.a = [];
    return s;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa1f66ea9, Offset: 0x8898
// Size: 0xa8
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
// Checksum 0x967689b2, Offset: 0x8948
// Size: 0x5e
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
// Checksum 0x3310c20a, Offset: 0x89b0
// Size: 0x294
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
// Params 2, eflags: 0x0
// Checksum 0xc7015b80, Offset: 0x8c50
// Size: 0x194
function set_lighting_state(n_state, var_2f177f67 = 1) {
    self.var_564dda4 = self.lighting_state;
    if (isdefined(n_state)) {
        self.lighting_state = n_state;
    } else {
        self.lighting_state = level.lighting_state;
    }
    if (isdefined(self.lighting_state)) {
        if (self == level) {
            players = var_2f177f67 ? function_a1ef346b() : getplayers();
            foreach (player in players) {
                player set_lighting_state(level.lighting_state);
            }
            return;
        }
        if (isplayer(self)) {
            self setlightingstate(self.lighting_state);
            return;
        }
        assertmsg("<dev string:x9b5>");
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xd1df8b60, Offset: 0x8df0
// Size: 0x144
function set_sun_shadow_split_distance(f_distance) {
    if (isdefined(f_distance)) {
        self.sun_shadow_split_distance = f_distance;
    } else {
        self.sun_shadow_split_distance = level.sun_shadow_split_distance;
    }
    if (isdefined(self.sun_shadow_split_distance)) {
        if (self == level) {
            foreach (player in function_a1ef346b()) {
                player set_sun_shadow_split_distance(level.sun_shadow_split_distance);
            }
            return;
        }
        if (isplayer(self)) {
            self setsunshadowsplitdistance(self.sun_shadow_split_distance);
            return;
        }
        assertmsg("<dev string:x9ea>");
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x6a160e53, Offset: 0x8f40
// Size: 0x164
function function_7f49ffb7(var_bf01552a) {
    if (!isdefined(level.var_bf01552a)) {
        level.var_bf01552a = -1;
    }
    if (isdefined(var_bf01552a)) {
        self.var_bf01552a = var_bf01552a;
    } else {
        self.var_bf01552a = level.var_bf01552a;
    }
    if (isdefined(self.var_bf01552a)) {
        if (self == level) {
            foreach (player in function_a1ef346b()) {
                player function_7f49ffb7(level.var_bf01552a);
            }
            return;
        }
        if (isplayer(self)) {
            self function_61471b4a(self.var_bf01552a);
            return;
        }
        assertmsg("<dev string:xa2a>");
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xf40d5caa, Offset: 0x90b0
// Size: 0x54a
function auto_delete(n_mode = 1, n_min_time_alive = 0, n_dist_horizontal = 0, n_dist_vertical = 0) {
    if (!isentity(self)) {
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
        playerlist = getplayers();
        foreach (player in playerlist) {
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
        if (n_tests_passed == playerlist.size) {
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
// Params 2, eflags: 0x0
// Checksum 0x8b0c9b47, Offset: 0x9608
// Size: 0xa2
function get_weapon_by_name(weapon_name, var_2f3a032e) {
    split = [];
    if ("" != var_2f3a032e) {
        split = strtok(var_2f3a032e, "+");
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
// Checksum 0x252b16df, Offset: 0x96b8
// Size: 0x76
function function_2146bd83(weapon) {
    var_2f3a032e = "";
    for (i = 0; i < weapon.attachments.size; i++) {
        if (i) {
            var_2f3a032e += "+";
        }
        var_2f3a032e += weapon.attachments[i];
    }
    return var_2f3a032e;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x664e1a21, Offset: 0x9738
// Size: 0x6c
function function_4c1656d5() {
    if (sessionmodeiswarzonegame()) {
        return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
    }
    return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x924774c7, Offset: 0x97b0
// Size: 0x124
function function_16fb0a3b() {
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
// Checksum 0xf35ae11d, Offset: 0x98e0
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
// Checksum 0x5ed96602, Offset: 0x9958
// Size: 0x162
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
// Checksum 0xa0736287, Offset: 0x9ac8
// Size: 0x9a
function totalplayercount() {
    count = 0;
    foreach (team, _ in level.teams) {
        count += level.playercount[team];
    }
    return count;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x68fadee3, Offset: 0x9b70
// Size: 0x1a
function isrankenabled() {
    return is_true(level.rankenabled);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc6f34c3a, Offset: 0x9b98
// Size: 0x20
function isoneround() {
    if (level.roundlimit == 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x63e5faa5, Offset: 0x9bc0
// Size: 0x30
function isfirstround() {
    if (!isdefined(game.roundsplayed) || game.roundsplayed == 0) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x9946f8d1, Offset: 0x9bf8
// Size: 0x40
function islastround() {
    if (level.roundlimit > 1 && game.roundsplayed >= level.roundlimit - 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa86bfa87, Offset: 0x9c40
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
// Checksum 0xc8c1fded, Offset: 0x9d10
// Size: 0x34
function hitroundlimit() {
    if (level.roundlimit <= 0) {
        return false;
    }
    return getroundsplayed() >= level.roundlimit;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4f0b04f7, Offset: 0x9d50
// Size: 0x9c
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
// Checksum 0xef77c2d2, Offset: 0x9df8
// Size: 0xdc
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
// Checksum 0x7cd73736, Offset: 0x9ee0
// Size: 0xc8
function function_385658da() {
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
// Checksum 0x642f3c37, Offset: 0x9fb0
// Size: 0x76
function hitroundwinlimit() {
    if (!isdefined(level.roundwinlimit) || level.roundwinlimit <= 0) {
        return false;
    }
    if (anyteamhitroundwinlimit()) {
        return true;
    }
    if (anyteamhitroundlimitwithdraws()) {
        if (!function_385658da()) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xfc7eea24, Offset: 0xa030
// Size: 0xce
function hitscorelimit() {
    if (level.scoreroundwinbased) {
        return false;
    }
    if (level.scorelimit <= 0) {
        return false;
    }
    if (level.teambased) {
        if (teams::any_team_hit_score_limit()) {
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
// Checksum 0x219de531, Offset: 0xa108
// Size: 0x1e
function get_current_round_score_limit() {
    return level.roundscorelimit * (game.roundsplayed + 1);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4db5e98e, Offset: 0xa130
// Size: 0xbc
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
// Checksum 0xfb131145, Offset: 0xa1f8
// Size: 0xda
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
// Checksum 0x37521413, Offset: 0xa2e0
// Size: 0x46
function getroundswon(team) {
    team = get_team_mapping(team);
    return game.stat[#"roundswon"][team];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x5d8ddf7c, Offset: 0xa330
// Size: 0xe4
function getotherteamsroundswon(str_skip_team) {
    str_skip_team = get_team_mapping(str_skip_team);
    roundswon = 0;
    if (!isdefined(str_skip_team)) {
        return roundswon;
    }
    foreach (team, _ in level.teams) {
        if (team === str_skip_team) {
            continue;
        }
        roundswon += game.stat[#"roundswon"][team];
    }
    return roundswon;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x7fa85017, Offset: 0xa420
// Size: 0xe
function getroundsplayed() {
    return game.roundsplayed;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x8d607b7c, Offset: 0xa438
// Size: 0x36
function isroundbased() {
    if (level.roundlimit != 1 && level.roundwinlimit != 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf9971b09, Offset: 0xa478
// Size: 0x26
function getcurrentgamemode() {
    if (gamemodeisarena()) {
        return "leaguematch";
    }
    return "publicmatch";
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0x86d7d309, Offset: 0xa4a8
// Size: 0x186
function function_97cf7eb0(v_start, n_max_dist = 5000, n_ground_offset = 0, e_ignore, b_ignore_water = 0, b_ignore_glass = 0) {
    v_trace_start = v_start + (0, 0, 5);
    v_trace_end = v_trace_start + (0, 0, (n_max_dist + 5) * -1);
    a_trace = groundtrace(v_trace_start, v_trace_end, 0, e_ignore, b_ignore_water, b_ignore_glass);
    if (a_trace[#"surfacetype"] != "none") {
        return {#position:a_trace[#"position"] + (0, 0, n_ground_offset), #entity:a_trace[#"entity"]};
    }
    return {#position:v_start, #entity:a_trace[#"entity"]};
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0x62709a35, Offset: 0xa638
// Size: 0x92
function ground_position(v_start, n_max_dist = 5000, n_ground_offset = 0, e_ignore, b_ignore_water = 0, b_ignore_glass = 0) {
    return function_97cf7eb0(v_start, n_max_dist, n_ground_offset, e_ignore, b_ignore_water, b_ignore_glass).position;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x6ce585c5, Offset: 0xa6d8
// Size: 0x2a
function delayed_notify(str_notify, f_delay_seconds) {
    wait f_delay_seconds;
    if (isdefined(self)) {
        self notify(str_notify);
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x200452ed, Offset: 0xa710
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
// Checksum 0x6e163e2d, Offset: 0xa788
// Size: 0x20
function is_safehouse() {
    mapname = get_map_name();
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x9db495b0, Offset: 0xa7b0
// Size: 0x4a
function is_new_cp_map() {
    mapname = get_map_name();
    switch (mapname) {
    default:
        return 0;
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd4a8b153, Offset: 0xa808
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
    // Checksum 0x7ba5152e, Offset: 0xa878
    // Size: 0x158
    function queued_debug_commands() {
        self notify(#"queued_debug_commands");
        self endon(#"queued_debug_commands");
        if (!isdefined(level.dbg_cmd_queue)) {
            level.dbg_cmd_queue = [];
        }
        while (true) {
            waitframe(1);
            if (level.dbg_cmd_queue.size == 0) {
                level.dbg_cmd_queue = undefined;
                return;
            }
            trickle = 0;
            if (isdefined(level.players) && level.players.size > 1) {
                trickle = 1;
            }
            for (var_1085858 = 12; (!trickle || var_1085858 > 0) && canadddebugcommand() && level.dbg_cmd_queue.size > 0; var_1085858--) {
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
// Checksum 0x4bae4ebb, Offset: 0xa9d8
// Size: 0x42
function array_copy_if_array(any_var) {
    return isarray(any_var) ? arraycopy(any_var) : any_var;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe59afeab, Offset: 0xaa28
// Size: 0x62
function is_item_purchased(ref) {
    itemindex = getitemindexfromref(ref);
    return itemindex < 0 || itemindex >= 256 ? 0 : self isitempurchased(itemindex);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3df31554, Offset: 0xaa98
// Size: 0x3c
function has_purchased_perk_equipped(ref) {
    return self hasperk(ref) && self is_item_purchased(ref);
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xf3fd7b1, Offset: 0xaae0
// Size: 0x66
function has_purchased_perk_equipped_with_specific_stat(single_perk_ref, stats_table_ref) {
    if (isplayer(self)) {
        return (self hasperk(single_perk_ref) && self is_item_purchased(stats_table_ref));
    }
    return 0;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe96b039f, Offset: 0xab50
// Size: 0x22
function has_flak_jacket_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_flakjacket");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x2568b821, Offset: 0xab80
// Size: 0x32
function has_blind_eye_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_nottargetedbyairsupport", #"specialty_nottargetedbyairsupport|specialty_nokillstreakreticle");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6c2456da, Offset: 0xabc0
// Size: 0x22
function has_ghost_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_gpsjammer");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x2f0de161, Offset: 0xabf0
// Size: 0x32
function has_tactical_mask_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_stunprotection", #"specialty_stunprotection|specialty_flashprotection|specialty_proximityprotection");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xfa6caa41, Offset: 0xac30
// Size: 0x32
function has_hacker_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_showenemyequipment", #"specialty_showenemyequipment|specialty_showscorestreakicons|specialty_showenemyvehicles");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xfdc1039a, Offset: 0xac70
// Size: 0x32
function has_cold_blooded_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_nottargetedbyaitank", #"specialty_nottargetedbyaitank|specialty_nottargetedbyraps|specialty_nottargetedbysentry|specialty_nottargetedbyrobot|specialty_immunenvthermal");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc878d72d, Offset: 0xacb0
// Size: 0x32
function has_hard_wired_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_immunecounteruav", #"specialty_immunecounteruav|specialty_immuneemp|specialty_immunetriggerc4|specialty_immunetriggershock|specialty_immunetriggerbetty|specialty_sixthsensejammer|specialty_trackerjammer|specialty_immunesmoke");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa40dd297, Offset: 0xacf0
// Size: 0x32
function has_gung_ho_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_sprintfire", #"specialty_sprintfire|specialty_sprintgrenadelethal|specialty_sprintgrenadetactical|specialty_sprintequipment");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa6030063, Offset: 0xad30
// Size: 0x32
function has_fast_hands_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_fastweaponswitch", #"specialty_fastweaponswitch|specialty_sprintrecovery|specialty_sprintfirerecovery");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x604af399, Offset: 0xad70
// Size: 0x22
function has_scavenger_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_scavenger");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x5108749a, Offset: 0xada0
// Size: 0x32
function has_jetquiet_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat(#"specialty_jetquiet", #"specialty_jetnoradar|specialty_jetquiet");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf37b4fef, Offset: 0xade0
// Size: 0x22
function has_awareness_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_loudenemies");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x312114fd, Offset: 0xae10
// Size: 0x22
function has_ninja_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_quieter");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xbfeba9f7, Offset: 0xae40
// Size: 0x22
function has_toughness_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped(#"specialty_bulletflinch");
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x2d7025cb, Offset: 0xae70
// Size: 0x58
function str_strip_lh(str) {
    if (strendswith(str, "_lh")) {
        return getsubstr(str, 0, str.size - 3);
    }
    return str;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf784fb3a, Offset: 0xaed0
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
// Checksum 0x5a6351f, Offset: 0xb050
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
// Checksum 0xf3398e91, Offset: 0xb1d0
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
// Checksum 0x6500f586, Offset: 0xb350
// Size: 0x68
function getplayspacecenter() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
    }
    return (0, 0, 0);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xfd659540, Offset: 0xb3c0
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
// Checksum 0x73f95344, Offset: 0xb4a8
// Size: 0x8c
function getteammask(team) {
    team = get_team_mapping(team);
    if (!level.teambased || !isdefined(team) || !isdefined(level.spawnsystem.ispawn_teammask[team])) {
        return level.spawnsystem.var_c2989de;
    }
    return level.spawnsystem.ispawn_teammask[team];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x1025b1c1, Offset: 0xb540
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
    assertmsg("<dev string:xa64>" + team);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x9c23072f, Offset: 0xb5f8
// Size: 0xe0
function getotherteamsmask(str_skip_team) {
    str_skip_team = get_team_mapping(str_skip_team);
    mask = 0;
    if (!isdefined(str_skip_team)) {
        return mask;
    }
    foreach (team, _ in level.teams) {
        if (team === str_skip_team) {
            continue;
        }
        mask |= getteammask(team);
    }
    return mask;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4a409180, Offset: 0xb6e0
// Size: 0x20
function waittill_can_add_debug_command() {
    while (!canadddebugcommand()) {
        waitframe(1);
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4ade950, Offset: 0xb708
    // Size: 0x3c
    function add_debug_command(cmd) {
        waittill_can_add_debug_command();
        adddebugcommand(cmd);
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe65ba47a, Offset: 0xb750
// Size: 0x3e
function function_8e89351(player) {
    return isplayer(player) && !isbot(player);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x67d3d062, Offset: 0xb798
// Size: 0x22
function is_game_solo(*team) {
    return function_58385b58().size == 1;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x7628631c, Offset: 0xb7c8
// Size: 0x22
function is_game_coop(*team) {
    return function_58385b58().size > 1;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x45cc52a0, Offset: 0xb7f8
// Size: 0x28
function function_cfa8b8df(team) {
    return getplayers(team).size > 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xc14b7391, Offset: 0xb828
// Size: 0x28
function function_cda17472(team) {
    return function_58385b58(team).size > 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xd7faa2ef, Offset: 0xb858
// Size: 0x1c
function timesince(starttimeinmilliseconds) {
    return (gettime() - starttimeinmilliseconds) * 0.001;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x98a53e33, Offset: 0xb880
// Size: 0x1a
function cooldowninit() {
    if (!isdefined(self._cooldown)) {
        self._cooldown = [];
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xd99df535, Offset: 0xb8a8
// Size: 0x54
function cooldown(name, time_seconds) {
    cooldowninit();
    self._cooldown[name] = gettime() + int(time_seconds * 1000);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xfedbb55f, Offset: 0xb908
// Size: 0x50
function getcooldowntimeraw(name) {
    cooldowninit();
    if (!isdefined(self._cooldown[name])) {
        self._cooldown[name] = gettime() - 1;
    }
    return self._cooldown[name];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x87b97d9a, Offset: 0xb960
// Size: 0x40
function getcooldownleft(name) {
    cooldowninit();
    return (getcooldowntimeraw(name) - gettime()) * 0.001;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xe5b1de72, Offset: 0xb9a8
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
// Checksum 0x1e7d1ed9, Offset: 0xba30
// Size: 0x34
function clearcooldown(name) {
    cooldowninit();
    self._cooldown[name] = gettime() - 1;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xf5bc11a1, Offset: 0xba70
// Size: 0x6c
function addcooldowntime(name, time_seconds) {
    cooldowninit();
    self._cooldown[name] = getcooldowntimeraw(name) + int(time_seconds * 1000);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x994e9e63, Offset: 0xbae8
// Size: 0x94
function clearallcooldowns() {
    if (isdefined(self._cooldown)) {
        foreach (str_name, cooldown in self._cooldown) {
            self._cooldown[str_name] = gettime() - 1;
        }
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x4
// Checksum 0x27f5ab6b, Offset: 0xbb88
// Size: 0x64
function private function_4627b63d(alias) {
    assert(isdefined(level.team_mapping_alias));
    assert(isdefined(level.team_mapping_alias[alias]));
    return level.team_mapping_alias[alias];
}

// Namespace util/util_shared
// Params 0, eflags: 0x4
// Checksum 0xfebc8b42, Offset: 0xbbf8
// Size: 0xc4
function private function_3cb7a62d() {
    assert(isdefined(level.team_mapping));
    if (get_team_mapping("sidea") == #"allies" && get_team_mapping("sideb") == #"axis") {
        level clientfield::set("cf_team_mapping", 1);
        return;
    }
    level clientfield::set("cf_team_mapping", 0);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa1bb8741, Offset: 0xbcc8
// Size: 0x2b4
function function_73fab74d() {
    if (isdefined(level.var_1bbf77be)) {
        return;
    }
    if (!isdefined(level.team_mapping)) {
        level.team_mapping = [];
    }
    level.var_1bbf77be = 1;
    function_9db3109f(#"allies", #"allies");
    function_9db3109f(#"axis", #"axis");
    function_9db3109f(#"allies", #"cia");
    function_9db3109f(#"axis", #"kgb");
    function_9db3109f(#"team3", #"side3");
    function_d3e0802c(#"sidea", #"sideb");
    function_d3e0802c(#"teama", #"teamb");
    function_d3e0802c(#"attacker", #"defender");
    function_d3e0802c(#"attackers", #"defenders");
    function_d3e0802c(#"cia", #"kgb");
    function_c16f65a3(#"allies", #"axis");
    function_c16f65a3(#"team3", #"any");
    set_team_mapping(#"allies", #"axis");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xdb9dbb65, Offset: 0xbf88
// Size: 0x34
function function_f9ce1d49() {
    if (isdefined(level.var_fdf974de)) {
        return;
    }
    level.var_fdf974de = array();
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xb6b7e1ec, Offset: 0xbfc8
// Size: 0x2c
function function_d7e70327(var_23866d2) {
    array::add(level.var_fdf974de, var_23866d2);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x4b0f4406, Offset: 0xc000
// Size: 0xb0
function function_3d66774c(var_23866d2) {
    foreach (i, v in level.var_fdf974de) {
        if (array::function_460f3c24(v, var_23866d2)) {
            array::remove_index(i);
        }
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xd1f3e583, Offset: 0xc0b8
// Size: 0x13c
function function_9b7092ef(team1, team2, team3, team4) {
    if (!isdefined(team1) || !isdefined(team2)) {
        return false;
    }
    foreach (var_ef54b214 in level.var_fdf974de) {
        if (array::contains(var_ef54b214, team1)) {
            if (array::contains(var_ef54b214, team2)) {
                if (!isdefined(team3) || array::contains(var_ef54b214, team3)) {
                    if (!isdefined(team4) || array::contains(var_ef54b214, team4)) {
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
// Checksum 0x90f1f160, Offset: 0xc200
// Size: 0x38
function function_c77e4851(var_cdcc5ad6, var_f947dce) {
    level.team_mapping[0] = var_cdcc5ad6;
    level.team_mapping[1] = var_f947dce;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xade974d1, Offset: 0xc240
// Size: 0xfc
function set_team_mapping(var_b0dd114d, var_54495823) {
    var_b0dd114d = function_4627b63d(var_b0dd114d);
    var_54495823 = function_4627b63d(var_54495823);
    assert(var_b0dd114d != var_54495823, "<dev string:xa83>");
    game.attackers = var_b0dd114d;
    game.defenders = var_54495823;
    level.team_mapping[0] = var_b0dd114d;
    level.team_mapping[1] = var_54495823;
    if (clientfield::can_set()) {
        function_3cb7a62d();
    }
    flag::set(#"team_mapping_set");
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xa775a14c, Offset: 0xc348
// Size: 0x60
function function_d3e0802c(var_1dc5879e, var_128bf12b) {
    assert(var_1dc5879e != var_128bf12b, "<dev string:xad1>");
    level.var_af68e94e[var_1dc5879e] = 0;
    level.var_af68e94e[var_128bf12b] = 1;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xf8856743, Offset: 0xc3b0
// Size: 0x5c
function function_c16f65a3(enemy_a, enemy_b) {
    assert(enemy_a != enemy_b, "<dev string:xb1c>");
    level.team_enemy_mapping[enemy_a] = enemy_b;
    level.team_enemy_mapping[enemy_b] = enemy_a;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xcd6e82e3, Offset: 0xc418
// Size: 0x7c
function function_9db3109f(team, alias) {
    assert(team == #"allies" || team == #"axis" || team == #"team3");
    level.team_mapping_alias[alias] = team;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xfc438df2, Offset: 0xc4a0
// Size: 0xb2
function get_team_mapping(team) {
    assert(isdefined(level.team_mapping));
    assert(isdefined(level.var_af68e94e));
    if (isdefined(team)) {
        if (isdefined(level.var_af68e94e[team])) {
            return level.team_mapping[level.var_af68e94e[team]];
        } else if (isdefined(level.team_mapping_alias[team])) {
            return level.team_mapping_alias[team];
        }
    }
    return team;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x36e6ff1f, Offset: 0xc560
// Size: 0xc4
function function_310d70e2(team) {
    assert(isdefined(level.team_mapping));
    assert(isdefined(level.var_af68e94e));
    if (isdefined(team)) {
        if (team === level.team_mapping[level.var_af68e94e[#"sidea"]]) {
            return "sidea";
        } else if (team === level.team_mapping[level.var_af68e94e[#"sideb"]]) {
            return "sideb";
        }
    }
    return team;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x1b0a34, Offset: 0xc630
// Size: 0x34
function is_on_side(team) {
    return self getteam() === get_team_mapping(team);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xaae8ad26, Offset: 0xc670
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
// Checksum 0x6a84952d, Offset: 0xc6e0
// Size: 0x32
function get_game_type() {
    return tolower(getdvarstring(#"g_gametype"));
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb7e2faeb, Offset: 0xc720
// Size: 0x32
function get_map_name() {
    return tolower(getdvarstring(#"sv_mapname"));
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x68254198, Offset: 0xc760
// Size: 0x1c
function is_frontend_map() {
    return get_map_name() === "core_frontend";
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0x27079a9, Offset: 0xc788
    // Size: 0x54
    function add_devgui(menu_path, commands) {
        add_queued_debug_command("<dev string:xb60>" + menu_path + "<dev string:x24f>" + commands + "<dev string:xb70>");
    }

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6cff1169, Offset: 0xc7e8
    // Size: 0x3c
    function remove_devgui(menu_path) {
        add_queued_debug_command("<dev string:xb76>" + menu_path + "<dev string:xb70>");
    }

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0xe7dde5a6, Offset: 0xc830
    // Size: 0x54
    function function_3f749abc(menu_path, commands) {
        add_debug_command("<dev string:xb60>" + menu_path + "<dev string:x24f>" + commands + "<dev string:xb70>");
    }

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x192fbf57, Offset: 0xc890
    // Size: 0x3c
    function function_85c62761(menu_path) {
        add_debug_command("<dev string:xb76>" + menu_path + "<dev string:xb70>");
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x5c68c7e3, Offset: 0xc8d8
// Size: 0xba
function gadget_is_in_use(slot) {
    if (isdefined(self._gadgets_player) && isdefined(self._gadgets_player[slot])) {
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
// Checksum 0x12d16a30, Offset: 0xc9a0
// Size: 0xac
function function_72cbea07(player, weapon) {
    if (!isdefined(player.var_9c4683a0)) {
        return false;
    }
    foreach (var_e64f4a4a in player.var_9c4683a0) {
        if (var_e64f4a4a == weapon) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x9c3f8eda, Offset: 0xca58
// Size: 0x5c
function ghost_wait_show(wait_time = 0.1) {
    self endon(#"death");
    self ghost();
    wait wait_time;
    self show();
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x738154b3, Offset: 0xcac0
// Size: 0x124
function ghost_wait_show_to_player(player, wait_time = 0.1, self_endon_string1) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self.abort_ghost_wait_show_to_player = undefined;
    if (isdefined(player)) {
        player endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
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
// Checksum 0x1fc501b8, Offset: 0xcbf0
// Size: 0x124
function ghost_wait_show_to_others(player, wait_time = 0.1, self_endon_string1) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self.abort_ghost_wait_show_to_others = undefined;
    if (isdefined(player)) {
        player endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
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
// Checksum 0x2968620c, Offset: 0xcd20
// Size: 0x1ec
function show_hit_marker(var_554cb812 = 0, var_1ed250ec = 0) {
    if (isplayer(self)) {
        if (isdefined(self) && isdefined(self.hud_damagefeedback)) {
            /#
                currenttime = gettime();
                if ((isdefined(self.hud_damagefeedback.time) ? self.hud_damagefeedback.time : 0) != currenttime || !is_true(self.hud_damagefeedback.feedback_dead)) {
                    if (var_554cb812) {
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
            self thread _show_hit_marker(var_554cb812, var_1ed250ec);
        }
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x4
// Checksum 0xd36c2233, Offset: 0xcf18
// Size: 0xa0
function private _show_hit_marker(var_554cb812, var_1ed250ec) {
    self endon(#"death");
    if (!isdefined(self.var_9a94bf1)) {
        self.var_9a94bf1 = 0;
    }
    if (self.var_9a94bf1 < 5) {
        self.var_9a94bf1++;
        self playhitmarker(undefined, 5, undefined, var_554cb812, var_1ed250ec);
        wait_network_frame();
        self.var_9a94bf1--;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x876674c1, Offset: 0xcfc0
// Size: 0x9c
function function_5d36c37a(str_tag = "tag_aim_target") {
    if (!issentient(self) && !function_ffa5b184(self)) {
        if (isdefined(self gettagorigin(str_tag))) {
            self function_2baad8fc(str_tag);
            return;
        }
        self function_2baad8fc();
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x89a02eba, Offset: 0xd068
// Size: 0x34
function make_sentient() {
    if (!issentient(self)) {
        self makesentient();
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xef71fbe0, Offset: 0xd0a8
// Size: 0x3c
function function_f9af3d43(time) {
    self endon(#"death");
    wait time;
    self delete();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6f11f7d, Offset: 0xd0f0
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
// Checksum 0x5a023888, Offset: 0xd168
// Size: 0xe
function get_gametype_name() {
    return level.gametype;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x110304f9, Offset: 0xd180
// Size: 0x9c
function cleanup_fancycam() {
    self endon(#"disconnect");
    if (isplayer(self) && !isbot(self)) {
        wait_network_frame();
        self function_eb0dd56(0);
        wait_network_frame();
        self function_eb0dd56(0);
    }
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x23ad9c95, Offset: 0xd228
// Size: 0x9a
function init_dvar(str_dvar, default_val, func_callback) {
    function_5ac4dc99(str_dvar, default_val);
    if (isdefined(func_callback)) {
        function_cd140ee9(str_dvar, func_callback);
        level thread [[ func_callback ]]({#name:str_dvar, #value:getdvar(str_dvar)});
    }
}

/#

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x202440e0, Offset: 0xd2d0
    // Size: 0x64
    function debug_slow_heli_speed() {
        if (getdvarint(#"scr_slow_heli", 0) > 0) {
            self setspeed(getdvarint(#"scr_slow_heli", 0));
        }
    }

#/

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x8f5c2ab3, Offset: 0xd340
// Size: 0x94
function function_fb80e9ca() {
    n_timeout = 0;
    self flag::set(#"hash_157310a25dd4e508");
    if (isdefined(self.var_68d6a816)) {
        n_timeout = self.var_68d6a816;
    }
    flag::function_5f02becb(n_timeout);
    self script_delay();
    self flag::clear(#"hash_157310a25dd4e508");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x1cff1009, Offset: 0xd3e0
// Size: 0x34
function function_74f2b2e9() {
    return isdefined(self.script_flag_true) || isdefined(self.script_flag_false) || function_de0e7bbd();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe9d8d85f, Offset: 0xd420
// Size: 0x5a
function function_de0e7bbd() {
    return isdefined(self.script_delay) && self.script_delay > 0 || isdefined(self.script_delay_min) && self.script_delay_min > 0 || isdefined(self.script_delay_max) && self.script_delay_max > 0;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xbee088f7, Offset: 0xd488
// Size: 0x136
function function_d2dd4134(str_value, str_key) {
    a_targets = [];
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (isdefined(str_value)) {
        var_c747e345 = strtok(str_value, " ");
        foreach (var_2fd77a2f in var_c747e345) {
            a_targets = arraycombine(a_targets, getentarray(var_2fd77a2f, str_key), 0, 0);
            a_targets = arraycombine(a_targets, struct::get_array(var_2fd77a2f, str_key), 0, 0);
        }
    }
    return a_targets;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xd30bf09b, Offset: 0xd5c8
// Size: 0x146
function get_array(str_value, str_key = "targetname") {
    a_targets = function_d2dd4134(str_value, str_key);
    if (isdefined(str_value)) {
        var_c747e345 = strtok(str_value, " ");
        foreach (var_2fd77a2f in var_c747e345) {
            a_targets = arraycombine(a_targets, getvehiclenodearray(var_2fd77a2f, str_key), 0, 0);
            a_targets = arraycombine(a_targets, getnodearray(var_2fd77a2f, str_key), 0, 0);
        }
    }
    return a_targets;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x5d94b89e, Offset: 0xd718
// Size: 0x52
function function_a1281365(radius) {
    if (!isdefined(radius) || radius <= 0) {
        return 0;
    }
    return randomfloatrange(radius * -1, radius);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe1b57f31, Offset: 0xd778
// Size: 0x42
function function_8eb53136(radius) {
    if (!isdefined(radius) || radius <= 0) {
        return 0;
    }
    return randomintrangeinclusive(radius * -1, radius);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc8407d73, Offset: 0xd7c8
// Size: 0x28
function is_spectating() {
    if (self.sessionstate == #"spectator") {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xdae67f12, Offset: 0xd7f8
// Size: 0x7c
function function_8570168d() {
    /#
        if (getdvar(#"hash_49e94b7aefac4f49", 0)) {
            return true;
        }
    #/
    if (sessionmodeismultiplayergame()) {
        mode = function_bea73b01();
        if (mode == 4) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xcdbc17d4, Offset: 0xd880
// Size: 0x11a
function function_88c74107() {
    var_bf8813f9 = 0;
    if (self == level) {
        a_players = getplayers();
        var_bf8813f9 = 0;
        foreach (player in a_players) {
            if (player isinmovemode("ufo", "noclip")) {
                var_bf8813f9 = 1;
                break;
            }
        }
    } else if (self isinmovemode("ufo", "noclip")) {
        var_bf8813f9 = 1;
    }
    return var_bf8813f9;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x5ae9d60b, Offset: 0xd9a8
// Size: 0xea
function function_22bf0a4a() {
    profilestart();
    player = self;
    if (level.var_e6f2a0c9 === 1) {
        profilestop();
        return;
    }
    if (getdvarstring(#"loot_special_contract_bundle", "") != "community_galil_achievement") {
        profilestop();
        return;
    }
    if (!gamemodeismode(0) && !gamemodeisarena()) {
        profilestop();
        return;
    }
    if (level.var_903e2252 === 1) {
        profilestop();
        return;
    }
    if (!isdefined(player)) {
        profilestop();
        return;
    }
    if (!isplayer(player)) {
        profilestop();
        return;
    }
    level.var_e6f2a0c9 = 1;
    profilestop();
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x5439d4d7, Offset: 0xdaa0
// Size: 0x34
function time_has_passed(var_bdb4b0ca, seconds) {
    if (!isdefined(var_bdb4b0ca)) {
        return false;
    }
    return gettime() - var_bdb4b0ca >= seconds * 1000;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x239da9e7, Offset: 0xdae0
// Size: 0x86
function function_b5338ccb(value, deadzone) {
    assert(deadzone < 1);
    if (abs(value) < deadzone) {
        return 0;
    }
    return (value - deadzone * math::sign(value)) / (1 - deadzone);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xa3abc19b, Offset: 0xdb70
// Size: 0x9c
function function_63320ea1(vector, deadzone, var_edfc4672) {
    if (var_edfc4672) {
        return (function_b5338ccb(vector[0], deadzone), function_b5338ccb(vector[1], deadzone), 0);
    }
    return vectornormalize(vector) * function_b5338ccb(length(vector), deadzone);
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0xd3d5eb93, Offset: 0xdc18
// Size: 0xda
function function_stack(func, param1, param2, param3, param4, param5) {
    var_8fcb7549 = spawnstruct();
    var_5e1dc4fe = 0;
    if (isdefined(self.function_stack)) {
        var_5e1dc4fe = self.function_stack.size;
    }
    var_8fcb7549 thread function_stack_proc(self, func, param1, param2, param3, param4, param5);
    if (self.function_stack.size == var_5e1dc4fe) {
        return function_97194cc7();
    }
    return self function_stack_wait_finish(var_8fcb7549);
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x2f30a126, Offset: 0xdd00
// Size: 0x104
function function_stack_timeout(timeout, func, param1, param2, param3, param4, param5) {
    var_8fcb7549 = spawnstruct();
    var_8fcb7549 thread function_stack_proc(self, func, param1, param2, param3, param4, param5);
    result = undefined;
    if (!isdefined(var_8fcb7549.function_stack_func_begun)) {
        result = var_8fcb7549 waittilltimeout(timeout, #"function_stack_func_begun");
    }
    if (result._notify !== "timeout") {
        return self function_stack_wait_finish(var_8fcb7549);
    }
    var_8fcb7549 notify(#"death");
    return 0;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x11434160, Offset: 0xde10
// Size: 0x96
function function_stack_clear() {
    newstack = [];
    if (isdefined(self.function_stack[0]) && isdefined(self.function_stack[0].function_stack_func_begun)) {
        newstack[0] = self.function_stack[0];
    }
    self.function_stack = undefined;
    self notify(#"hash_1245c8bd71378f60");
    waittillframeend();
    if (!newstack.size) {
        return;
    }
    if (!newstack[0].function_stack_func_begun) {
        return;
    }
    self.function_stack = newstack;
}

// Namespace util/util_shared
// Params 1, eflags: 0x4
// Checksum 0x95bb3fce, Offset: 0xdeb0
// Size: 0x44
function private function_stack_wait(var_8fcb7549) {
    self endon(#"death");
    var_8fcb7549 waittill(#"function_done", #"death");
}

// Namespace util/util_shared
// Params 1, eflags: 0x4
// Checksum 0xd26cf62c, Offset: 0xdf00
// Size: 0x32
function private function_stack_wait_finish(var_8fcb7549) {
    function_stack_wait(var_8fcb7549);
    return function_97194cc7();
}

// Namespace util/util_shared
// Params 0, eflags: 0x4
// Checksum 0x5e59d1d0, Offset: 0xdf40
// Size: 0x4e
function private function_97194cc7() {
    if (!isdefined(self)) {
        return false;
    }
    if (!issentient(self)) {
        return true;
    }
    if (isalive(self)) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 7, eflags: 0x4
// Checksum 0xc8f57937, Offset: 0xdf98
// Size: 0x206
function private function_stack_proc(caller, func, param1, param2, param3, param4, param5) {
    self endon(#"death");
    if (!isdefined(caller.function_stack)) {
        caller.function_stack = [];
    }
    caller.function_stack[caller.function_stack.size] = self;
    self thread function_stack_self_death(caller);
    function_stack_caller_waits_for_turn(caller);
    if (isdefined(caller) && isdefined(caller.function_stack)) {
        self.function_stack_func_begun = 1;
        self notify(#"function_stack_func_begun");
        if (isdefined(param5)) {
            caller [[ func ]](param1, param2, param3, param4, param5);
        } else if (isdefined(param4)) {
            caller [[ func ]](param1, param2, param3, param4);
        } else if (isdefined(param3)) {
            caller [[ func ]](param1, param2, param3);
        } else if (isdefined(param2)) {
            caller [[ func ]](param1, param2);
        } else if (isdefined(param1)) {
            caller [[ func ]](param1);
        } else {
            caller [[ func ]]();
        }
        if (isdefined(caller) && isdefined(caller.function_stack)) {
            arrayremovevalue(caller.function_stack, self);
            caller notify(#"hash_2fee3acf75826af1");
        }
    }
    if (isdefined(self)) {
        self.function_stack_func_begun = 0;
        self notify(#"function_done");
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x4
// Checksum 0xa025ccd1, Offset: 0xe1a8
// Size: 0x68
function private function_stack_self_death(caller) {
    self endon(#"function_done");
    self waittill(#"death");
    if (isdefined(caller)) {
        arrayremovevalue(caller.function_stack, self);
        caller notify(#"hash_2fee3acf75826af1");
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x4
// Checksum 0x71acfd65, Offset: 0xe218
// Size: 0x78
function private function_stack_caller_waits_for_turn(caller) {
    caller endon(#"death");
    self endon(#"death");
    caller endon(#"hash_1245c8bd71378f60");
    while (caller.function_stack[0] != self) {
        caller waittill(#"hash_2fee3acf75826af1");
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x851d7a4d, Offset: 0xe298
// Size: 0x66
function get_links() {
    if (isdefined(self.linkto)) {
        return strtok(self.linkto, " ");
    }
    if (isdefined(self.script_linkto)) {
        return strtok(self.script_linkto, " ");
    }
    return [];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xbfc7b073, Offset: 0xe308
// Size: 0xf2
function get_linked_structs() {
    array = [];
    var_feebff9c = "linkname";
    if (isdefined(self.script_linkto)) {
        /#
            iprintlnbold("<dev string:xb89>");
        #/
        var_feebff9c = "script_linkName";
    }
    linknames = get_links();
    for (i = 0; i < linknames.size; i++) {
        structs = struct::get_array(linknames[i], var_feebff9c);
        if (structs.size > 0) {
            array = arraycombine(array, structs, 1, 0);
        }
    }
    return array;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x2908aca5, Offset: 0xe408
// Size: 0x136
function get_linked_ents() {
    array = [];
    var_feebff9c = "linkname";
    if (isdefined(self.script_linkto)) {
        /#
            iprintlnbold("<dev string:xb89>");
        #/
        var_feebff9c = "script_linkName";
    }
    linknames = [];
    linknames = get_links();
    foreach (name in linknames) {
        entities = getentarray(name, var_feebff9c);
        if (entities.size > 0) {
            array = arraycombine(array, entities, 1, 0);
        }
    }
    return array;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x9d32d89c, Offset: 0xe548
// Size: 0x62
function get_linked_ent() {
    array = get_linked_ents();
    assert(array.size == 1);
    assert(isdefined(array[0]));
    return array[0];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xdbb7bfbb, Offset: 0xe5b8
// Size: 0x136
function get_linked_nodes() {
    array = [];
    var_feebff9c = "linkname";
    if (isdefined(self.script_linkto)) {
        /#
            iprintlnbold("<dev string:xb89>");
        #/
        var_feebff9c = "script_linkName";
    }
    linknames = get_links();
    foreach (name in linknames) {
        entities = getnodearray(name, var_feebff9c);
        if (entities.size > 0) {
            array = arraycombine(array, entities, 1, 0);
        }
    }
    return array;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x6ef0a0af, Offset: 0xe6f8
// Size: 0x3c
function function_bfa9c188(targetname, state = 0) {
    level thread function_33fbb3e5(targetname, state);
}

// Namespace util/util_shared
// Params 2, eflags: 0x4
// Checksum 0x1173a667, Offset: 0xe740
// Size: 0x118
function private function_33fbb3e5(targetname, state) {
    self notify("_set_dynent_state_thread_" + targetname);
    self endon("_set_dynent_state_thread_" + targetname);
    wait_network_frame();
    a_dynents = getdynentarray(targetname, 1);
    if (isdefined(a_dynents) && isarray(a_dynents)) {
        foreach (dynent in a_dynents) {
            function_e2a06860(dynent, state);
        }
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x9c822ccb, Offset: 0xe860
// Size: 0x12a
function teleport(pos, v_ang) {
    if (isstruct(pos)) {
        v_pos = pos.origin;
        if (!isdefined(v_ang)) {
            v_ang = pos.angles;
        }
    } else {
        v_pos = pos;
    }
    if (isentity(self)) {
        self dontinterpolate();
    }
    if (isactor(self)) {
        self forceteleport(v_pos, v_ang);
        return;
    }
    if (isplayer(self)) {
        self setorigin(v_pos);
        self setplayerangles(v_ang);
        return;
    }
    self.origin = v_pos;
    self.angles = v_ang;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x399be337, Offset: 0xe998
// Size: 0xc4
function function_1690fd42(player, persistent) {
    assert(isplayer(player));
    if (is_true(persistent)) {
        thread function_d532c33b(player);
        return;
    }
    initial_black = lui::get_luimenu("InitialBlack");
    if (!initial_black initial_black::is_open(player)) {
        initial_black initial_black::open(player);
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x37b4c134, Offset: 0xea68
// Size: 0x6c
function function_cd98604b(player) {
    assert(isplayer(player));
    initial_black = lui::get_luimenu("InitialBlack");
    initial_black initial_black::close(player);
}

// Namespace util/util_shared
// Params 1, eflags: 0x4
// Checksum 0x88b6cb3e, Offset: 0xeae0
// Size: 0xf4
function private function_d532c33b(player) {
    player endon(#"death", #"disconnect");
    initial_black = lui::get_luimenu("InitialBlack");
    if (initial_black initial_black::is_open(player)) {
        initial_black initial_black::close(player);
        wait_network_frame(1);
    }
    initial_black initial_black::open(player, 1);
    /#
        initial_black initial_black::function_2eb3f6e8(player, getdvarint(#"hash_73c93e31e0d1ea8b", 0) == 0);
    #/
}

#namespace namespace_2e6206f9;

// Namespace namespace_2e6206f9/util_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x5b22d4bd, Offset: 0xebe0
// Size: 0x2d4
function register_callback(str_kvp, func, ...) {
    var_a12e87bd = hash(str_kvp);
    var_bcb861f = self.(str_kvp + "_target");
    if (isdefined(var_bcb861f)) {
        if (!isdefined(mission.var_232d57d8)) {
            mission.var_232d57d8 = [];
        }
        if (!isdefined(mission.var_232d57d8[var_a12e87bd])) {
            mission.var_232d57d8[var_a12e87bd] = [];
        }
        if (!isdefined(self.var_c18fbf49)) {
            self.var_c18fbf49 = [];
        }
        s_callback = {#func:func, #params:vararg};
        self.var_c18fbf49[var_a12e87bd] = s_callback;
        var_c747e345 = strtok(var_bcb861f, " ");
        foreach (var_5afcf8a3 in var_c747e345) {
            if (!isdefined(mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)])) {
                mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)] = [];
            } else if (!isarray(mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)])) {
                mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)] = array(mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)]);
            }
            mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)][mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)].size] = self;
        }
        self thread function_d608a743();
    }
}

// Namespace namespace_2e6206f9/util_shared
// Params 3, eflags: 0x0
// Checksum 0xf2c36ad9, Offset: 0xeec0
// Size: 0x2c4
function register_custom_callback(str_name, str_kvp, func) {
    var_ce100229 = hash(str_name);
    var_bcb861f = self.(str_kvp + "_target");
    if (isdefined(var_bcb861f)) {
        if (!isdefined(mission.var_232d57d8)) {
            mission.var_232d57d8 = [];
        }
        if (!isdefined(mission.var_232d57d8[var_ce100229])) {
            mission.var_232d57d8[var_ce100229] = [];
        }
        if (!isdefined(self.var_c18fbf49)) {
            self.var_c18fbf49 = [];
        }
        s_callback = {#func:func};
        self.var_c18fbf49[var_ce100229] = s_callback;
        var_c747e345 = strtok(var_bcb861f, " ");
        foreach (var_5afcf8a3 in var_c747e345) {
            if (!isdefined(mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)])) {
                mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)] = [];
            } else if (!isarray(mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)])) {
                mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)] = array(mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)]);
            }
            mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)][mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)].size] = self;
        }
        self thread function_d608a743();
    }
}

// Namespace namespace_2e6206f9/util_shared
// Params 0, eflags: 0x0
// Checksum 0x43c4011b, Offset: 0xf190
// Size: 0x140
function function_d608a743() {
    self notify(#"hash_29bf696e43d4a08b");
    self endon(#"hash_29bf696e43d4a08b", #"death");
    a_str_notifies = getarraykeys(self.var_c18fbf49);
    while (true) {
        s_result = self waittill(a_str_notifies);
        s_callback = self.var_c18fbf49[hash(s_result._notify)];
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

// Namespace namespace_2e6206f9/util_shared
// Params 2, eflags: 0x0
// Checksum 0xdb05190f, Offset: 0xf2d8
// Size: 0x226
function function_7ed1d198(str_kvp, str_name) {
    a_s_result = [];
    if (isdefined(mission.var_232d57d8)) {
        var_ce100229 = hash(isdefined(str_name) ? str_name : str_kvp);
        var_7ac3e82f = mission.var_232d57d8[var_ce100229];
        if (isdefined(var_7ac3e82f)) {
            var_bcb861f = self.(str_kvp + "_src");
            if (isdefined(var_bcb861f)) {
                var_c747e345 = strtok(var_bcb861f, " ");
                foreach (var_5afcf8a3 in var_c747e345) {
                    var_85c1bb33 = var_7ac3e82f[hash(var_5afcf8a3)];
                    if (isdefined(var_85c1bb33)) {
                        foreach (var_8507e893 in var_85c1bb33) {
                            if (!isdefined(a_s_result)) {
                                a_s_result = [];
                            } else if (!isarray(a_s_result)) {
                                a_s_result = array(a_s_result);
                            }
                            a_s_result[a_s_result.size] = var_8507e893;
                        }
                    }
                }
            }
        }
    }
    return a_s_result;
}

// Namespace namespace_2e6206f9/util_shared
// Params 1, eflags: 0x0
// Checksum 0x2be17828, Offset: 0xf508
// Size: 0xae
function callback(str_kvp) {
    var_e028d750 = function_7ed1d198(str_kvp);
    if (var_e028d750.size) {
        foreach (var_8507e893 in var_e028d750) {
            var_8507e893 notify(str_kvp);
        }
    }
}

// Namespace namespace_2e6206f9/util_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0xa19571c3, Offset: 0xf5c0
// Size: 0xce
function custom_callback(str_name, str_kvp, ...) {
    var_e028d750 = function_7ed1d198(str_kvp, str_name);
    if (var_e028d750.size) {
        foreach (var_8507e893 in var_e028d750) {
            var_8507e893 notify(str_name, {#params:vararg});
        }
    }
}

// Namespace namespace_2e6206f9/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe6878dda, Offset: 0xf698
// Size: 0x1e
function function_4da758bf() {
    self.var_c18fbf49 = undefined;
    self notify(#"hash_29bf696e43d4a08b");
}

// Namespace namespace_2e6206f9/util_shared
// Params 1, eflags: 0x0
// Checksum 0x832a807c, Offset: 0xf6c0
// Size: 0x3a
function function_61e8e3c8(str_kvp) {
    return util::get_array(self.(str_kvp + "_target"), str_kvp + "_src");
}

// Namespace namespace_2e6206f9/util_shared
// Params 1, eflags: 0x0
// Checksum 0x65728a20, Offset: 0xf708
// Size: 0x3a
function get_target_structs(str_kvp) {
    return util::get_array(self.(str_kvp + "_src"), str_kvp + "_target");
}

