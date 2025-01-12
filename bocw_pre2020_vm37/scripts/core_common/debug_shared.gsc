#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace debug;

/#

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x6
    // Checksum 0xae9ae3f2, Offset: 0x80
    // Size: 0x3c
    function private autoexec __init__system__() {
        system::register(#"debug", &function_70a657d8, undefined, undefined, undefined);
    }

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x4
    // Checksum 0x57df50de, Offset: 0xc8
    // Size: 0xac
    function private function_70a657d8() {
        level thread debug_draw_tuning_sphere();
        level thread devgui_debug_key_value();
        level thread function_e648ca7c();
        callback::on_loadout(&on_loadout);
        /#
            if (getdvarint(#"hash_2bf322fc226fa167", 0)) {
                adddebugcommand("<dev string:x38>");
            }
        #/
    }

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x4
    // Checksum 0xe751473a, Offset: 0x180
    // Size: 0x23a
    function private function_ddca74dd() {
        weaponname = getdvar(#"hash_136a06446fceeaa5", "<dev string:x5f>");
        if (weaponname != "<dev string:x5f>") {
            waitframe(1);
            split = strtok(weaponname, "<dev string:x63>");
            switch (split.size) {
            case 1:
            default:
                weapon = getweapon(split[0]);
                break;
            case 2:
                weapon = getweapon(split[0], split[1]);
                break;
            case 3:
                weapon = getweapon(split[0], split[1], split[2]);
                break;
            case 4:
                weapon = getweapon(split[0], split[1], split[2], split[3]);
                break;
            case 5:
                weapon = getweapon(split[0], split[1], split[2], split[3], split[4]);
                break;
            }
            if (weapon != level.weaponnone) {
                self giveweapon(weapon);
                self switchtoweapon(weapon);
                self.spawnweapon = weapon;
            }
        }
    }

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x4
    // Checksum 0xf8e72fa6, Offset: 0x3c8
    // Size: 0x1c
    function private on_loadout() {
        self function_ddca74dd();
    }

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x29a2d4ef, Offset: 0x3f0
    // Size: 0x3f0
    function devgui_debug_key_value() {
        a_keys = array("<dev string:x68>", "<dev string:x72>", "<dev string:x7e>", "<dev string:x8b>", "<dev string:xa0>", "<dev string:xae>", "<dev string:xbf>", "<dev string:xcd>", "<dev string:xd7>");
        setdvar(#"debug_key_value", 0);
        setdvar(#"debug_key_value_dist", 2000);
        adddebugcommand("<dev string:xdf>");
        adddebugcommand("<dev string:x132>");
        foreach (str_key in a_keys) {
            adddebugcommand("<dev string:x17f>" + str_key + "<dev string:x1b2>" + str_key + "<dev string:x1cd>");
        }
        while (!flag::exists("<dev string:x1d3>")) {
            util::wait_network_frame();
        }
        level flag::wait_till("<dev string:x1d3>");
        while (true) {
            debug_key_value = getdvar(#"debug_key_value", 0);
            if (debug_key_value != 0) {
                a_ents = getentarray();
                foreach (ent in a_ents) {
                    n_draw_dist = getdvarint(#"debug_key_value_dist", 0);
                    n_draw_dist_sq = n_draw_dist * n_draw_dist;
                    n_dist_sq = distancesquared(ent.origin, level.players[0].origin);
                    if (n_dist_sq <= n_draw_dist_sq) {
                        n_scale = mapfloat(0, 6250000, 0.5, 5, n_dist_sq);
                        ent thread debug_key_value(string(debug_key_value), undefined, n_scale);
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
    // Checksum 0x7512286e, Offset: 0x7e8
    // Size: 0x228
    function debug_draw_tuning_sphere() {
        n_sphere_radius = 0;
        v_text_position = (0, 0, 0);
        n_text_scale = 1;
        while (true) {
            n_sphere_radius = getdvarfloat(#"debug_measure_sphere_radius", 0);
            while (n_sphere_radius >= 1) {
                players = getplayers();
                if (isdefined(players[0])) {
                    n_sphere_radius = getdvarfloat(#"debug_measure_sphere_radius", 0);
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
    // Checksum 0x300a2812, Offset: 0xa18
    // Size: 0x14e
    function debug_key_value(str_key, n_time, n_scale) {
        if (!isdefined(n_scale)) {
            n_scale = 1;
        }
        level endon(#"debug_key_value");
        self notify(#"debug_key_value");
        self endon(#"debug_key_value", #"death");
        if (isdefined(str_key)) {
            if (isdefined(n_time)) {
                __s = spawnstruct();
                __s endon(#"timeout");
                __s util::delay_notify(n_time, "<dev string:x1eb>");
            }
            while (true) {
                value = self.(str_key);
                if (isdefined(value)) {
                    print3d(self.origin, isdefined(value) ? "<dev string:x5f>" + value : "<dev string:x5f>", (0, 0, 1), 1, n_scale, 1);
                }
                waitframe(1);
            }
        }
    }

    // Namespace debug/debug_shared
    // Params 4, eflags: 0x0
    // Checksum 0x30f42d94, Offset: 0xb70
    // Size: 0x62
    function drawdebuglineinternal(frompoint, topoint, color, durationframes) {
        for (i = 0; i < durationframes; i++) {
            line(frompoint, topoint, color);
            waitframe(1);
        }
    }

    // Namespace debug/debug_shared
    // Params 4, eflags: 0x0
    // Checksum 0x9ae94e4f, Offset: 0xbe0
    // Size: 0x8a
    function drawdebugenttoentinternal(ent1, ent2, color, durationframes) {
        for (i = 0; i < durationframes; i++) {
            if (!isdefined(ent1) || !isdefined(ent2)) {
                return;
            }
            line(ent1.origin, ent2.origin, color);
            waitframe(1);
        }
    }

    // Namespace debug/debug_shared
    // Params 4, eflags: 0x0
    // Checksum 0x446e6357, Offset: 0xc78
    // Size: 0x44
    function drawdebugline(frompoint, topoint, color, durationframes) {
        thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
    }

    // Namespace debug/debug_shared
    // Params 4, eflags: 0x0
    // Checksum 0xc0de7cc3, Offset: 0xcc8
    // Size: 0x44
    function drawdebuglineenttoent(ent1, ent2, color, durationframes) {
        thread drawdebugenttoentinternal(ent1, ent2, color, durationframes);
    }

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4c3142b5, Offset: 0xd18
    // Size: 0x5c
    function function_e648ca7c() {
        setdvar(#"hash_b8d10baa344fcbd", 0);
        function_cd140ee9(#"hash_b8d10baa344fcbd", &function_68f58e51);
    }

    // Namespace debug/debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5b262177, Offset: 0xd80
    // Size: 0x34
    function function_68f58e51(params) {
        level.var_77e1430c = params.value;
        function_c0767f67();
    }

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1e2bb293, Offset: 0xdc0
    // Size: 0x4c
    function function_1b531660() {
        if (!isdefined(level.var_77e1430c)) {
            level.var_77e1430c = 0;
        }
        level.var_77e1430c = !level.var_77e1430c;
        function_c0767f67();
    }

    // Namespace debug/debug_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9bbf48e2, Offset: 0xe18
    // Size: 0x13c
    function function_c0767f67() {
        if (!isdefined(level.var_77e1430c)) {
            level.var_77e1430c = 0;
        }
        if (level.var_77e1430c) {
            callback::on_player_damage(&function_e7321799);
            callback::on_actor_damage(&function_e7321799);
            callback::on_vehicle_damage(&function_e7321799);
            callback::function_9d78f548(&function_e7321799);
            return;
        }
        callback::remove_on_player_damage(&function_e7321799);
        callback::remove_on_actor_damage(&function_e7321799);
        callback::remove_on_vehicle_damage(&function_e7321799);
        callback::function_f125b93a(&function_e7321799);
    }

    // Namespace debug/debug_shared
    // Params 1, eflags: 0x0
    // Checksum 0x83a5b804, Offset: 0xf60
    // Size: 0x10c
    function function_e7321799(params) {
        damage = params.idamage;
        location = params.vpoint;
        target = self;
        smeansofdeath = params.smeansofdeath;
        if (smeansofdeath == "<dev string:x1f6>" || smeansofdeath == "<dev string:x205>") {
            location = self.origin + (0, 0, 60);
        }
        if (damage) {
            thread function_2cde0af9("<dev string:x63>" + damage, (1, 1, 1), location, (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 2), 30);
        }
    }

    // Namespace debug/debug_shared
    // Params 5, eflags: 0x0
    // Checksum 0x768980dc, Offset: 0x1078
    // Size: 0xbe
    function function_2cde0af9(text, color, start, velocity, frames) {
        location = start;
        alpha = 1;
        for (i = 0; i < frames; i++) {
            print3d(location, text, color, alpha, 0.6, 1);
            location += velocity;
            alpha -= 1 / frames * 2;
            waitframe(1);
        }
    }

#/
