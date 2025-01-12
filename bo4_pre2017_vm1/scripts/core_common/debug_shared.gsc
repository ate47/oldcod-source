#using scripts/core_common/flag_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace debug;

/#

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x2
    // Checksum 0xa8125f8c, Offset: 0xf0
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc214a024, Offset: 0x130
    // Size: 0x34
    function __init__() {
        level thread debug_draw_tuning_sphere();
        level thread devgui_debug_key_value();
    }

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xfd1adc68, Offset: 0x170
    // Size: 0x3a8
    function devgui_debug_key_value() {
        a_keys = array("<dev string:x2e>", "<dev string:x35>", "<dev string:x47>", "<dev string:x52>", "<dev string:x60>", "<dev string:x6b>", "<dev string:x72>");
        setdvar("<dev string:x77>", "<dev string:x87>");
        setdvar("<dev string:x89>", 2000);
        adddebugcommand("<dev string:x9e>");
        adddebugcommand("<dev string:xee>");
        foreach (str_key in a_keys) {
            adddebugcommand("<dev string:x138>" + str_key + "<dev string:x168>" + str_key + "<dev string:x180>");
        }
        var_3f641bd0 = "<dev string:x183>";
        level flag::wait_till("<dev string:x184>");
        while (true) {
            var_3f641bd0 = getdvarstring("<dev string:x77>");
            if (var_3f641bd0 != "<dev string:x87>") {
                a_ents = getentarray();
                foreach (ent in a_ents) {
                    n_draw_dist = getdvarint("<dev string:x89>");
                    n_draw_dist_sq = n_draw_dist * n_draw_dist;
                    n_dist_sq = distancesquared(ent.origin, level.players[0].origin);
                    if (n_dist_sq <= n_draw_dist_sq) {
                        n_scale = mapfloat(0, 6250000, 0.5, 5, n_dist_sq);
                        ent thread debug_key_value(var_3f641bd0, undefined, n_scale);
                        continue;
                    }
                    ent notify(#"debug_key_value");
                }
            } else {
                level notify(#"debug_key_value");
            }
            wait randomfloatrange(0.133333, 0.266667);
        }
    }

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0xaa60b908, Offset: 0x520
    // Size: 0x248
    function debug_draw_tuning_sphere() {
        n_sphere_radius = 0;
        v_text_position = (0, 0, 0);
        n_text_scale = 1;
        while (true) {
            n_sphere_radius = getdvarfloat("<dev string:x199>", 0);
            while (n_sphere_radius >= 1) {
                players = getplayers();
                if (isdefined(players[0])) {
                    n_sphere_radius = getdvarfloat("<dev string:x199>", 0);
                    circle(players[0].origin, n_sphere_radius, (1, 0, 0), 0, 1, 16);
                    n_text_scale = sqrt(n_sphere_radius * 2.5) / 2;
                    vforward = anglestoforward(players[0].angles);
                    v_text_position = players[0].origin + vforward * n_sphere_radius;
                    sides = int(10 * (1 + int(n_text_scale) % 100));
                    sphere(v_text_position, n_text_scale, (1, 0, 0), 1, 1, sides, 16);
                    print3d(v_text_position + (0, 0, 20), n_sphere_radius, (1, 0, 0), 1, n_text_scale / 14, 16);
                }
                waitframe(1);
            }
            wait 1;
        }
    }

    // Namespace debug/debug_shared
    // Params 3, eflags: 0x0
    // Checksum 0xf07f154, Offset: 0x770
    // Size: 0x146
    function debug_key_value(str_key, n_time, n_scale) {
        if (!isdefined(n_scale)) {
            n_scale = 1;
        }
        level endon(#"debug_key_value");
        self notify(#"debug_key_value");
        self endon(#"debug_key_value");
        self endon(#"death");
        if (isdefined(str_key)) {
            if (isdefined(n_time)) {
                __s = spawnstruct();
                __s endon(#"timeout");
                __s util::delay_notify(n_time, "<dev string:x1b5>");
            }
            while (true) {
                value = self.(str_key);
                if (isdefined(value)) {
                    print3d(self.origin, isdefined(value) ? "<dev string:x183>" + value : "<dev string:x183>", (0, 0, 1), 1, n_scale, 1);
                }
                waitframe(1);
            }
        }
    }

#/
