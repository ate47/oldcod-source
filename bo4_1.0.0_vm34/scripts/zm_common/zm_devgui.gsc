#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\rat;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_turned;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_devgui;

/#

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x2
    // Checksum 0x2db30f3, Offset: 0x1a0
    // Size: 0x4c
    function autoexec __init__system__() {
        system::register(#"zm_devqui", &__init__, &__main__, undefined);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x576e9263, Offset: 0x1f8
    // Size: 0x25c
    function __init__() {
        setdvar(#"zombie_devgui", "<dev string:x30>");
        setdvar(#"scr_force_weapon", "<dev string:x30>");
        setdvar(#"scr_zombie_round", 1);
        setdvar(#"scr_zombie_dogs", 1);
        setdvar(#"scr_spawn_tesla", "<dev string:x30>");
        setdvar(#"scr_zombie_variant_type", -1);
        level.devgui_add_weapon = &devgui_add_weapon;
        level.devgui_add_ability = &devgui_add_ability;
        level thread zombie_devgui_think();
        thread zombie_weapon_devgui_think();
        thread function_315fab2d();
        thread function_b9a4c7a();
        thread devgui_zombie_healthbar();
        thread dev::devgui_test_chart_think();
        if (!isdefined(getdvar(#"scr_testscriptruntimeerror"))) {
            setdvar(#"scr_testscriptruntimeerror", "<dev string:x31>");
        }
        level thread dev::body_customization_devgui(0);
        thread testscriptruntimeerror();
        callback::on_connect(&player_on_connect);
        add_custom_devgui_callback(&function_737fb8e9);
        thread init_debug_center_screen();
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x3062a327, Offset: 0x460
    // Size: 0xac
    function __main__() {
        level thread zombie_devgui_player_commands();
        level thread zombie_devgui_validation_commands();
        level thread zombie_draw_traversals();
        level thread function_1d21f4f();
        level thread function_19959e80();
        level thread function_9de7b574();
        level thread function_7e1c8660();
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x8df8d65b, Offset: 0x518
    // Size: 0x8
    function zombie_devgui_player_commands() {
        
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x92e4515c, Offset: 0x528
    // Size: 0x44
    function player_on_connect() {
        level flag::wait_till("<dev string:x36>");
        wait 1;
        if (isdefined(self)) {
            zombie_devgui_player_menu(self);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xfb4a2b78, Offset: 0x578
    // Size: 0x44
    function zombie_devgui_player_menu_clear(playername) {
        rootclear = "<dev string:x4f>" + playername + "<dev string:x6c>";
        adddebugcommand(rootclear);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x7383dafb, Offset: 0x5c8
    // Size: 0xb4
    function function_9b9b2fe4(archetype, var_ea94c12a) {
        if (!isdefined(var_ea94c12a)) {
            var_ea94c12a = "<dev string:x30>";
        }
        displayname = archetype;
        if (isdefined(var_ea94c12a) && var_ea94c12a != "<dev string:x30>") {
            displayname = displayname + "<dev string:x70>" + var_ea94c12a;
        }
        adddebugcommand("<dev string:x72>" + displayname + "<dev string:x98>" + archetype + "<dev string:x70>" + var_ea94c12a + "<dev string:xc0>");
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x4
    // Checksum 0xd8b03a02, Offset: 0x688
    // Size: 0x394
    function private function_737fb8e9(cmd) {
        if (strstartswith(cmd, "<dev string:xc3>")) {
            player = level.players[0];
            direction = player getplayerangles();
            direction_vec = anglestoforward(direction);
            eye = player geteye();
            direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
            trace = bullettrace(eye, eye + direction_vec, 0, undefined);
            ai = undefined;
            ai_info = strreplace(cmd, "<dev string:xd7>", "<dev string:x30>");
            ai_info = strtok(ai_info, "<dev string:x70>");
            aitype = ai_info[0];
            if (ai_info.size > 1) {
                var_ea94c12a = ai_info[1];
            }
            spawners = getspawnerarray();
            foreach (spawner in spawners) {
                if (spawner.archetype === aitype && (!isdefined(var_ea94c12a) && !isdefined(spawner.var_ea94c12a) || spawner.var_ea94c12a === var_ea94c12a)) {
                    ai_spawner = spawner;
                    break;
                }
            }
            if (!isdefined(ai_spawner)) {
                iprintln("<dev string:xec>" + aitype);
                return;
            }
            ai_spawner.script_forcespawn = 1;
            ai = zombie_utility::spawn_zombie(ai_spawner, undefined, ai_spawner);
            if (isdefined(ai)) {
                wait 0.5;
                if (isvehicle(ai)) {
                    ai.origin = trace[#"position"];
                    ai function_3c8dce03(trace[#"position"]);
                    return;
                }
                ai forceteleport(trace[#"position"], player.angles + (0, 180, 0));
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xccf9b338, Offset: 0xa28
    // Size: 0x5c4
    function zombie_devgui_player_menu(player) {
        zombie_devgui_player_menu_clear(player.name);
        ip1 = player getentitynumber() + 1;
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x126>" + ip1 + "<dev string:x14f>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x159>" + ip1 + "<dev string:x184>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x191>" + ip1 + "<dev string:x1ba>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x1c8>" + ip1 + "<dev string:x1f5>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x200>" + ip1 + "<dev string:x22a>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x235>" + ip1 + "<dev string:x25f>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x26d>" + ip1 + "<dev string:x290>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x299>" + ip1 + "<dev string:x2be>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x2c9>" + ip1 + "<dev string:x2f2>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x301>" + ip1 + "<dev string:x32e>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x340>" + ip1 + "<dev string:x370>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x385>" + ip1 + "<dev string:x3b0>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x3be>" + ip1 + "<dev string:x3ea>");
        adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x3f6>" + ip1 + "<dev string:x423>");
        if (isdefined(level.charindexarray)) {
            for (i = 0; i < 4; i++) {
                ci = level.charindexarray[i];
                adddebugcommand("<dev string:x108>" + player.name + "<dev string:x122>" + ip1 + "<dev string:x430>" + ci + "<dev string:x44b>" + ci + 1 + "<dev string:x44d>" + ip1 + "<dev string:x469>" + ci + "<dev string:x6c>");
            }
        }
        if (isdefined(level.var_e26adf8d)) {
            level thread [[ level.var_e26adf8d ]](player, ip1);
        }
        self thread zombie_devgui_player_menu_clear_on_disconnect(player);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x79a92add, Offset: 0xff8
    // Size: 0x54
    function zombie_devgui_player_menu_clear_on_disconnect(player) {
        playername = player.name;
        player waittill(#"disconnect");
        zombie_devgui_player_menu_clear(playername);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa65df9d3, Offset: 0x1058
    // Size: 0x442
    function function_9de7b574() {
        while (true) {
            var_7663115f = getdvarint(#"hash_67d19b13a4ab8b94", 0);
            if (var_7663115f >= 0 && isdefined(level.zone_paths[var_7663115f])) {
                zone_paths = level.zone_paths[var_7663115f];
                foreach (var_afabe54f, zone_path in zone_paths) {
                    zone = level.zones[var_afabe54f];
                    print_origin = undefined;
                    if (isdefined(zone.nodes[0])) {
                        print_origin = zone.nodes[0].origin;
                    }
                    if (!isdefined(print_origin)) {
                        print_origin = zone.volumes[0].origin;
                    }
                    color = (1, 0, 0);
                    if (zone_path.cost < 4) {
                        color = (0, 1, 0);
                    } else if (zone_path.cost < 8) {
                        color = (1, 0.5, 0);
                    }
                    circle(print_origin, 30, color);
                    print3d(print_origin, function_15979fa9(var_afabe54f), color, 1, 0.5);
                    print3d(print_origin + (0, 0, -10), "<dev string:x476>" + zone_path.cost, color, 1, 0.5);
                    if (isdefined(zone_path.to_zone)) {
                        to_zone = level.zones[zone_path.to_zone];
                        if (isdefined(to_zone.nodes[0])) {
                            var_228e8bf = to_zone.nodes[0].origin;
                        }
                        if (!isdefined(var_228e8bf)) {
                            var_228e8bf = to_zone.volumes[0].origin;
                        }
                        line(print_origin, var_228e8bf, color, 0, 0);
                    }
                }
                foreach (zone_name, zone in level.zones) {
                    if (!isdefined(zone_paths[zone_name])) {
                        print_origin = undefined;
                        if (isdefined(zone.nodes[0])) {
                            print_origin = zone.nodes[0].origin;
                        }
                        if (!isdefined(print_origin)) {
                            print_origin = zone.volumes[0].origin;
                        }
                        print3d(print_origin, function_15979fa9(zone_name), (1, 0, 0), 1, 0.5);
                        circle(print_origin, 30, (1, 0, 0));
                        circle(print_origin, 35, (1, 0, 0));
                        circle(print_origin, 40, (1, 0, 0));
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x4cdfa01f, Offset: 0x14a8
    // Size: 0x1e0
    function zombie_devgui_validation_commands() {
        setdvar(#"validation_devgui_command", "<dev string:x30>");
        adddebugcommand("<dev string:x47c>");
        adddebugcommand("<dev string:x4c4>");
        adddebugcommand("<dev string:x511>");
        while (true) {
            cmd = getdvarstring(#"validation_devgui_command");
            if (cmd != "<dev string:x30>") {
                switch (cmd) {
                case #"spawner":
                    zombie_spawner_validation();
                    break;
                case #"zone_adj":
                    if (!isdefined(level.toggle_zone_adjacencies_validation)) {
                        level.toggle_zone_adjacencies_validation = 1;
                    } else {
                        level.toggle_zone_adjacencies_validation = !level.toggle_zone_adjacencies_validation;
                    }
                    thread zone_adjacencies_validation();
                    break;
                case #"zone_paths":
                    break;
                case #"pathing":
                    thread zombie_pathing_validation();
                default:
                    break;
                }
                setdvar(#"validation_devgui_command", "<dev string:x30>");
            }
            util::wait_network_frame();
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xe6e1cc2, Offset: 0x1690
    // Size: 0x1a2
    function function_25c1d5b() {
        spawners = getspawnerarray();
        var_37f06aae = [];
        foreach (spawner in spawners) {
            have_spawner = 0;
            foreach (unique_spawner in var_37f06aae) {
                if (spawner.classname === unique_spawner.classname) {
                    have_spawner = 1;
                    break;
                }
            }
            if (have_spawner) {
                continue;
            }
            if (!isdefined(var_37f06aae)) {
                var_37f06aae = [];
            } else if (!isarray(var_37f06aae)) {
                var_37f06aae = array(var_37f06aae);
            }
            if (!isinarray(var_37f06aae, spawner)) {
                var_37f06aae[var_37f06aae.size] = spawner;
            }
        }
        return var_37f06aae;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x62f0b0a2, Offset: 0x1840
    // Size: 0xd0
    function function_39c2df28(zone) {
        if (isdefined(zone.nodes)) {
            foreach (node in zone.nodes) {
                node_region = getnoderegion(node);
                if (!isdefined(node_region)) {
                    thread drawvalidation(node.origin, undefined, undefined, undefined, node);
                }
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x8761cb15, Offset: 0x1918
    // Size: 0x166
    function function_2420119a(zone, var_c7d0f49f) {
        if (!isdefined(zone.a_loc_types[#"wait_location"]) || zone.a_loc_types[#"wait_location"].size <= 0) {
            if (isdefined(var_c7d0f49f) && var_c7d0f49f) {
                level.validation_errors_count++;
                if (isdefined(zone.nodes) && zone.nodes.size > 0) {
                    origin = zone.nodes[0].origin + (0, 0, 32);
                } else {
                    origin = zone.volumes[0].origin;
                }
                thread drawvalidation(origin, zone.name);
                println("<dev string:x560>" + zone.name);
                iprintlnbold("<dev string:x560>" + zone.name);
            }
            return 0;
        }
        return 1;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 4, eflags: 0x0
    // Checksum 0x54235fab, Offset: 0x1a88
    // Size: 0x2f0
    function function_a6e4b305(zone, enemy, spawner, spawn_location) {
        if (!isdefined(zone.a_loc_types[spawn_location])) {
            return enemy;
        }
        foreach (spawn_point in zone.a_loc_types[spawn_location]) {
            if (!isdefined(enemy)) {
                enemy = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point);
            }
            spawn_point_origin = spawn_point.origin;
            if (isdefined(spawn_point.script_string) && spawn_point.script_string != "<dev string:x585>") {
                spawn_point_origin = enemy validate_to_board(spawn_point, spawn_point_origin);
            }
            if (!ispointonnavmesh(spawn_point_origin, enemy getpathfindingradius() + 1)) {
                new_spawn_point_origin = getclosestpointonnavmesh(spawn_point_origin, 64, enemy getpathfindingradius() + 1);
            } else {
                new_spawn_point_origin = spawn_point_origin;
            }
            var_b54212e = isdefined(spawn_point.script_noteworthy) && !issubstr(spawn_point.script_noteworthy, "<dev string:x590>");
            if (isdefined(var_b54212e) && var_b54212e && !isdefined(new_spawn_point_origin) && !(isdefined(spawn_point.var_4063c396) && spawn_point.var_4063c396)) {
                level.validation_errors_count++;
                thread drawvalidation(spawn_point_origin);
                println("<dev string:x5a5>" + spawn_point_origin);
                iprintlnbold("<dev string:x5de>" + spawn_point_origin);
                spawn_point.var_4063c396 = 1;
            }
            if (!isdefined(new_spawn_point_origin)) {
                continue;
            }
            ispath = enemy validate_to_wait_point(zone, new_spawn_point_origin, spawn_point);
        }
        return enemy;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x1d215cdc, Offset: 0x1d80
    // Size: 0x38e
    function zombie_spawner_validation() {
        level.validation_errors_count = 0;
        if (!isdefined(level.toggle_spawner_validation)) {
            level.toggle_spawner_validation = 1;
            zombie_devgui_open_sesame();
            spawners = function_25c1d5b();
            foreach (zone in level.zones) {
                function_39c2df28(zone);
                function_2420119a(zone, 1);
            }
            foreach (spawner in spawners) {
                if (!isdefined(spawner.aitype)) {
                    continue;
                }
                archetype = getarchetypefromclassname(spawner.aitype);
                if (!isdefined(archetype)) {
                    continue;
                }
                var_95e1567d = spawner ai::function_a0dbf10a().spawnlocations;
                if (!isdefined(var_95e1567d)) {
                    continue;
                }
                var_480b5f40 = 0;
                enemy = undefined;
                foreach (zone in level.zones) {
                    if (!function_2420119a(zone)) {
                        continue;
                    }
                    foreach (var_179c3f50 in var_95e1567d) {
                        enemy = function_a6e4b305(zone, enemy, spawner, var_179c3f50.spawnlocation);
                        if (isdefined(enemy)) {
                            var_480b5f40 = 1;
                        }
                    }
                }
                if (!var_480b5f40) {
                    iprintlnbold("<dev string:x618>" + spawner.aitype);
                }
            }
            println("<dev string:x643>" + level.validation_errors_count);
            iprintlnbold("<dev string:x643>" + level.validation_errors_count);
            level.validation_errors_count = undefined;
            return;
        }
        level.toggle_spawner_validation = !level.toggle_spawner_validation;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x30cc5de9, Offset: 0x2118
    // Size: 0x2c6
    function validate_to_board(spawn_point, spawn_point_origin_backup) {
        for (j = 0; j < level.exterior_goals.size; j++) {
            if (isdefined(level.exterior_goals[j].script_string) && level.exterior_goals[j].script_string == spawn_point.script_string) {
                node = level.exterior_goals[j];
                break;
            }
        }
        if (isdefined(node)) {
            ispath = self canpath(spawn_point.origin, node.origin);
            if (!ispath) {
                level.validation_errors_count++;
                thread drawvalidation(spawn_point_origin_backup, undefined, undefined, node.origin, undefined, self.archetype);
                if (isdefined(self.archetype)) {
                    println("<dev string:x66c>" + function_15979fa9(self.archetype) + "<dev string:x67a>" + spawn_point_origin_backup + "<dev string:x699>" + spawn_point.targetname);
                    iprintlnbold("<dev string:x66c>" + function_15979fa9(self.archetype) + "<dev string:x67a>" + spawn_point_origin_backup + "<dev string:x699>" + spawn_point.targetname);
                } else {
                    println("<dev string:x6b2>" + spawn_point_origin_backup + "<dev string:x699>" + spawn_point.targetname);
                    iprintlnbold("<dev string:x6b2>" + spawn_point_origin_backup + "<dev string:x699>" + spawn_point.targetname);
                }
            }
            nodeforward = anglestoforward(node.angles);
            nodeforward = vectornormalize(nodeforward);
            spawn_point_origin = node.origin + nodeforward * 100;
            return spawn_point_origin;
        }
        return spawn_point_origin_backup;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 3, eflags: 0x0
    // Checksum 0x1ae1e596, Offset: 0x23e8
    // Size: 0x2a8
    function validate_to_wait_point(zone, new_spawn_point_origin, spawn_point) {
        foreach (loc in zone.a_loc_types[#"wait_location"]) {
            if (isdefined(loc)) {
                wait_point = loc.origin;
                if (isdefined(wait_point)) {
                    new_wait_point = getclosestpointonnavmesh(wait_point, self getpathfindingradius(), 30);
                    if (isdefined(new_spawn_point_origin) && isdefined(new_wait_point)) {
                        ispath = self findpath(new_spawn_point_origin, new_wait_point);
                        if (ispath) {
                            return 1;
                        }
                        level.validation_errors_count++;
                        thread drawvalidation(new_spawn_point_origin, undefined, new_wait_point, undefined, undefined, self.archetype);
                        if (isdefined(self.archetype)) {
                            println("<dev string:x6e4>" + function_15979fa9(self.archetype) + "<dev string:x67a>" + new_spawn_point_origin + "<dev string:x6f1>" + spawn_point.targetname);
                            iprintlnbold("<dev string:x66c>" + function_15979fa9(self.archetype) + "<dev string:x67a>" + new_spawn_point_origin + "<dev string:x6f1>" + spawn_point.targetname);
                        } else {
                            println("<dev string:x6b2>" + new_spawn_point_origin + "<dev string:x6f1>" + spawn_point.targetname);
                            iprintlnbold("<dev string:x6b2>" + new_spawn_point_origin + "<dev string:x6f1>" + spawn_point.targetname);
                        }
                        return 0;
                    }
                }
            }
        }
        return 0;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 6, eflags: 0x0
    // Checksum 0x315af09, Offset: 0x2698
    // Size: 0x456
    function drawvalidation(origin, zone_name, nav_mesh_wait_point, boards_point, zone_node, archetype) {
        if (!isdefined(zone_name)) {
            zone_name = undefined;
        }
        if (!isdefined(nav_mesh_wait_point)) {
            nav_mesh_wait_point = undefined;
        }
        if (!isdefined(boards_point)) {
            boards_point = undefined;
        }
        if (!isdefined(zone_node)) {
            zone_node = undefined;
        }
        if (!isdefined(archetype)) {
            archetype = undefined;
        }
        if (isdefined(archetype)) {
            archetype = function_15979fa9(archetype);
        }
        while (true) {
            if (isdefined(level.toggle_spawner_validation) && level.toggle_spawner_validation) {
                if (!isdefined(origin)) {
                    break;
                }
                if (isdefined(zone_name)) {
                    circle(origin, 32, (1, 0, 0));
                    print3d(origin, "<dev string:x711>" + zone_name, (1, 1, 1), 1, 0.5);
                } else if (isdefined(nav_mesh_wait_point)) {
                    circle(origin, 32, (0, 0, 1));
                    if (isdefined(archetype)) {
                        print3d(origin, archetype + "<dev string:x72c>" + origin, (1, 1, 1), 1, 0.5);
                    } else {
                        print3d(origin, "<dev string:x74d>" + origin, (1, 1, 1), 1, 0.5);
                    }
                    line(origin, nav_mesh_wait_point, (1, 0, 0));
                    circle(nav_mesh_wait_point, 32, (1, 0, 0));
                    print3d(nav_mesh_wait_point, "<dev string:x774>" + nav_mesh_wait_point, (1, 1, 1), 1, 0.5);
                } else if (isdefined(boards_point)) {
                    circle(origin, 32, (0, 0, 1));
                    if (isdefined(archetype)) {
                        print3d(origin, archetype + "<dev string:x72c>" + origin, (1, 1, 1), 1, 0.5);
                    } else {
                        print3d(origin, "<dev string:x74d>" + origin, (1, 1, 1), 1, 0.5);
                    }
                    line(origin, boards_point, (1, 0, 0));
                    circle(boards_point, 32, (1, 0, 0));
                    print3d(boards_point, "<dev string:x784>" + boards_point, (1, 1, 1), 1, 0.5);
                } else if (isdefined(zone_node)) {
                    circle(origin, 32, (1, 0, 0));
                    print3d(origin, "<dev string:x793>" + (isdefined(zone_node.targetname) ? zone_node.targetname : "<dev string:x30>") + "<dev string:x79e>" + origin + "<dev string:x7a3>", (1, 1, 1), 1, 0.5);
                } else {
                    circle(origin, 32, (0, 0, 1));
                    print3d(origin, "<dev string:x7bb>" + origin, (1, 1, 1), 1, 0.5);
                }
            }
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb7752930, Offset: 0x2af8
    // Size: 0x2d2
    function zone_adjacencies_validation() {
        zombie_devgui_open_sesame();
        while (true) {
            if (isdefined(level.toggle_zone_adjacencies_validation) && level.toggle_zone_adjacencies_validation) {
                if (!isdefined(getplayers()[0].zone_name)) {
                    waitframe(1);
                    continue;
                }
                str_zone = getplayers()[0].zone_name;
                keys = getarraykeys(level.zones);
                offset = 0;
                foreach (key in keys) {
                    if (key === str_zone) {
                        draw_zone_adjacencies_validation(level.zones[key], 2, key);
                        continue;
                    }
                    if (isdefined(level.zones[str_zone].adjacent_zones[key])) {
                        if (level.zones[str_zone].adjacent_zones[key].is_connected) {
                            offset += 10;
                            draw_zone_adjacencies_validation(level.zones[key], 1, key, level.zones[str_zone], offset);
                        } else {
                            draw_zone_adjacencies_validation(level.zones[key], 0, key);
                        }
                        continue;
                    }
                    draw_zone_adjacencies_validation(level.zones[key], 0, key);
                }
                foreach (zone in level.zones) {
                    function_b2b017fc(level.zones, zone);
                }
            }
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 5, eflags: 0x0
    // Checksum 0x99fe07d7, Offset: 0x2dd8
    // Size: 0x294
    function draw_zone_adjacencies_validation(zone, status, name, current_zone, offset) {
        if (!isdefined(current_zone)) {
            current_zone = undefined;
        }
        if (!isdefined(offset)) {
            offset = 0;
        }
        if (!isdefined(zone.volumes[0]) && !isdefined(zone.nodes[0])) {
            return;
        }
        if (isdefined(zone.nodes[0])) {
            print_origin = zone.nodes[0].origin;
        }
        if (!isdefined(print_origin)) {
            print_origin = zone.volumes[0].origin;
        }
        if (status == 2) {
            circle(print_origin, 30, (0, 1, 0));
            print3d(print_origin, function_15979fa9(name), (0, 1, 0), 1, 0.5);
            return;
        }
        if (status == 1) {
            circle(print_origin, 30, (0, 0, 1));
            print3d(print_origin, function_15979fa9(name), (0, 0, 1), 1, 0.5);
            if (isdefined(current_zone.nodes[0])) {
                print_origin = current_zone.nodes[0].origin;
            }
            if (!isdefined(print_origin)) {
                print_origin = current_zone.volumes[0].origin;
            }
            print3d(print_origin + (0, 20, offset * -1), function_15979fa9(name), (0, 0, 1), 1, 0.5);
            return;
        }
        circle(print_origin, 30, (1, 0, 0));
        print3d(print_origin, function_15979fa9(name), (1, 0, 0), 1, 0.5);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x7515195d, Offset: 0x3078
    // Size: 0x1e8
    function function_b2b017fc(zones, zone) {
        if (!isdefined(zone.volumes[0]) && !isdefined(zone.nodes[0])) {
            return;
        }
        if (isdefined(zone.nodes[0])) {
            origin = zone.nodes[0].origin;
        }
        if (!isdefined(origin)) {
            origin = zone.volumes[0].origin;
        }
        foreach (var_643d75b7, adjacent in zone.adjacent_zones) {
            adjacent_zone = zones[var_643d75b7];
            if (adjacent_zone.nodes.size && isdefined(adjacent_zone.nodes[0].origin)) {
                var_421939f5 = adjacent_zone.nodes[0].origin;
            }
            if (!isdefined(var_421939f5)) {
                var_421939f5 = adjacent_zone.volumes[0].origin;
            }
            if (adjacent.is_connected) {
                line(origin, var_421939f5, (0, 1, 0), 0, 0);
                continue;
            }
            line(origin, var_421939f5, (1, 0, 0), 0, 0);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x36d1d27a, Offset: 0x3268
    // Size: 0x142
    function zombie_pathing_validation() {
        if (!isdefined(level.zombie_spawners[0])) {
            return;
        }
        if (!isdefined(level.zombie_pathing_validation)) {
            level.zombie_pathing_validation = 1;
        }
        zombie_devgui_open_sesame();
        setdvar(#"zombie_default_max", 0);
        zombie_devgui_goto_round(20);
        wait 2;
        spawner = level.zombie_spawners[0];
        slums_station = (808, -1856, 544);
        enemy = zombie_utility::spawn_zombie(spawner, spawner.targetname);
        wait 1;
        while (isdefined(enemy) && enemy.completed_emerging_into_playable_area !== 1) {
            waitframe(1);
        }
        if (isdefined(enemy)) {
            enemy forceteleport(slums_station);
            enemy.b_ignore_cleanup = 1;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 3, eflags: 0x0
    // Checksum 0x68794535, Offset: 0x33b8
    // Size: 0xdc
    function function_300fe60f(weapon_name, up, root) {
        rootslash = "<dev string:x30>";
        if (isdefined(root) && root.size) {
            rootslash = root + "<dev string:x7d2>";
        }
        uppath = "<dev string:x7d2>" + up;
        if (up.size < 1) {
            uppath = "<dev string:x30>";
        }
        cmd = "<dev string:x7d4>" + rootslash + weapon_name + uppath + "<dev string:x7f6>" + weapon_name + "<dev string:x6c>";
        adddebugcommand(cmd);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 3, eflags: 0x0
    // Checksum 0x6b5b22d5, Offset: 0x34a0
    // Size: 0xdc
    function devgui_add_weapon_entry(weapon_name, up, root) {
        rootslash = "<dev string:x30>";
        if (isdefined(root) && root.size) {
            rootslash = root + "<dev string:x7d2>";
        }
        uppath = "<dev string:x7d2>" + up;
        if (up.size < 1) {
            uppath = "<dev string:x30>";
        }
        cmd = "<dev string:x820>" + rootslash + weapon_name + uppath + "<dev string:x838>" + weapon_name + "<dev string:x6c>";
        adddebugcommand(cmd);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 3, eflags: 0x0
    // Checksum 0xf6b36cdf, Offset: 0x3588
    // Size: 0x3c
    function function_1567189b(weapon_name, up, root) {
        devgui_add_weapon_entry(weapon_name, up, root);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 7, eflags: 0x0
    // Checksum 0x619cce67, Offset: 0x35d0
    // Size: 0x1b4
    function devgui_add_weapon(weapon, upgrade, hint, cost, weaponvo, weaponvoresp, ammo_cost) {
        function_300fe60f(getweaponname(weapon), "<dev string:x30>", "<dev string:x30>");
        level endon(#"game_ended");
        util::waittill_can_add_debug_command();
        if (!isdefined(level.devgui_weapons_added)) {
            level.devgui_weapons_added = 0;
        }
        level.devgui_weapons_added++;
        if (zm_loadout::is_offhand_weapon(weapon) && !zm_loadout::is_melee_weapon(weapon)) {
            function_1567189b(getweaponname(weapon), "<dev string:x30>", "<dev string:x852>");
            return;
        }
        if (zm_loadout::is_melee_weapon(weapon)) {
            function_1567189b(getweaponname(weapon), "<dev string:x30>", "<dev string:x85a>");
            return;
        }
        function_1567189b(getweaponname(weapon), "<dev string:x30>", "<dev string:x30>");
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x83a2003, Offset: 0x3790
    // Size: 0x370
    function function_315fab2d() {
        level.zombie_devgui_gun = getdvarstring(#"hash_1c9225f4f6e82068");
        for (;;) {
            wait 0.1;
            cmd = getdvarstring(#"hash_1c9225f4f6e82068");
            if (isdefined(cmd) && cmd.size > 0) {
                level.zombie_devgui_gun = cmd;
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
                }
                setdvar(#"hash_1c9225f4f6e82068", "<dev string:x30>");
            }
            wait 0.1;
            cmd = getdvarstring(#"hash_1c9228f4f6e82581");
            if (isdefined(cmd) && cmd.size > 0) {
                level.zombie_devgui_gun = cmd;
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
                }
                setdvar(#"hash_1c9228f4f6e82581", "<dev string:x30>");
            }
            wait 0.1;
            cmd = getdvarstring(#"hash_1c9227f4f6e823ce");
            if (isdefined(cmd) && cmd.size > 0) {
                level.zombie_devgui_gun = cmd;
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
                }
                setdvar(#"hash_1c9227f4f6e823ce", "<dev string:x30>");
            }
            wait 0.1;
            cmd = getdvarstring(#"hash_1c922af4f6e828e7");
            if (isdefined(cmd) && cmd.size > 0) {
                level.zombie_devgui_gun = cmd;
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
                }
                setdvar(#"hash_1c922af4f6e828e7", "<dev string:x30>");
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd1becdaa, Offset: 0x3b08
    // Size: 0x1e8
    function zombie_weapon_devgui_think() {
        level.zombie_devgui_gun = getdvarstring(#"zombie_devgui_gun");
        level.var_a77e5044 = getdvarstring(#"hash_29afaae00915bd92");
        for (;;) {
            wait 0.25;
            cmd = getdvarstring(#"zombie_devgui_gun");
            if (isdefined(cmd) && cmd.size > 0) {
                level.zombie_devgui_gun = cmd;
                array::thread_all(getplayers(), &zombie_devgui_weapon_give, level.zombie_devgui_gun);
                setdvar(#"zombie_devgui_gun", "<dev string:x30>");
            }
            wait 0.25;
            att = getdvarstring(#"hash_29afaae00915bd92");
            if (isdefined(att) && att.size > 0) {
                level.var_a77e5044 = att;
                array::thread_all(getplayers(), &function_4e8e32dc, level.var_a77e5044);
                setdvar(#"hash_29afaae00915bd92", "<dev string:x30>");
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x5c5e96a3, Offset: 0x3cf8
    // Size: 0x94
    function zombie_devgui_weapon_give(weapon_name) {
        weapon = getweapon(weapon_name);
        if (zm_loadout::is_melee_weapon(weapon) && isdefined(zm_melee_weapon::find_melee_weapon(weapon))) {
            self zm_melee_weapon::award_melee_weapon(weapon_name);
            return;
        }
        self zm_weapons::weapon_give(weapon);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x7f9a22ae, Offset: 0x3d98
    // Size: 0x6c
    function function_4e8e32dc(attachment) {
        weapon = self getcurrentweapon();
        weapon = getweapon(weapon.rootweapon.name, attachment);
        self zm_weapons::weapon_give(weapon);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 5, eflags: 0x0
    // Checksum 0xbc6d5a98, Offset: 0x3e10
    // Size: 0x164
    function devgui_add_ability(name, upgrade_active_func, stat_name, stat_desired_value, game_end_reset_if_not_achieved) {
        online_game = sessionmodeisonlinegame();
        if (!online_game) {
            return;
        }
        if (!(isdefined(level.devgui_watch_abilities) && level.devgui_watch_abilities)) {
            cmd = "<dev string:x860>";
            adddebugcommand(cmd);
            cmd = "<dev string:x8ba>";
            adddebugcommand(cmd);
            level thread zombie_ability_devgui_think();
            level.devgui_watch_abilities = 1;
        }
        cmd = "<dev string:x912>" + name + "<dev string:x934>" + name + "<dev string:x6c>";
        adddebugcommand(cmd);
        cmd = "<dev string:x957>" + name + "<dev string:x97e>" + name + "<dev string:x6c>";
        adddebugcommand(cmd);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x5ef29806, Offset: 0x3f80
    // Size: 0x10
    function zombie_devgui_ability_give(name) {
        
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x654ae9fc, Offset: 0x3f98
    // Size: 0x10
    function zombie_devgui_ability_take(name) {
        
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb2447d24, Offset: 0x3fb0
    // Size: 0x208
    function zombie_ability_devgui_think() {
        level.zombie_devgui_give_ability = getdvarstring(#"zombie_devgui_give_ability");
        level.zombie_devgui_take_ability = getdvarstring(#"zombie_devgui_take_ability");
        for (;;) {
            wait 0.25;
            cmd = getdvarstring(#"zombie_devgui_give_ability");
            if (!isdefined(level.zombie_devgui_give_ability) || level.zombie_devgui_give_ability != cmd) {
                if (cmd == "<dev string:x9a1>") {
                    level flag::set("<dev string:x9aa>");
                } else if (cmd == "<dev string:x9bd>") {
                    level flag::clear("<dev string:x9aa>");
                } else {
                    level.zombie_devgui_give_ability = cmd;
                    array::thread_all(getplayers(), &zombie_devgui_ability_give, level.zombie_devgui_give_ability);
                }
            }
            wait 0.25;
            cmd = getdvarstring(#"zombie_devgui_take_ability");
            if (!isdefined(level.zombie_devgui_take_ability) || level.zombie_devgui_take_ability != cmd) {
                level.zombie_devgui_take_ability = cmd;
                array::thread_all(getplayers(), &zombie_devgui_ability_take, level.zombie_devgui_take_ability);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x659edf34, Offset: 0x41c0
    // Size: 0xf4
    function zombie_healthbar(pos, dsquared) {
        if (distancesquared(pos, self.origin) > dsquared) {
            return;
        }
        rate = 1;
        if (isdefined(self.maxhealth)) {
            rate = self.health / self.maxhealth;
        }
        color = (1 - rate, rate, 0);
        text = "<dev string:x30>" + int(self.health);
        print3d(self.origin + (0, 0, 0), text, color, 1, 0.5, 1);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xabfc45c1, Offset: 0x42c0
    // Size: 0x12a
    function devgui_zombie_healthbar() {
        while (true) {
            if (getdvarint(#"scr_zombie_healthbars", 0) == 1) {
                lp = getplayers()[0];
                zombies = getaispeciesarray("<dev string:x9c5>", "<dev string:x9c5>");
                if (isdefined(zombies)) {
                    foreach (zombie in zombies) {
                        zombie zombie_healthbar(lp.origin, 360000);
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa4d9fc70, Offset: 0x43f8
    // Size: 0x86
    function zombie_devgui_watch_input() {
        level flag::wait_till("<dev string:x36>");
        wait 1;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            players[i] thread watch_debug_input();
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x17a7b787, Offset: 0x4488
    // Size: 0x5c
    function damage_player() {
        self val::set(#"damage_player", "<dev string:x9c9>", 1);
        self dodamage(self.health / 2, self.origin);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc503ffa7, Offset: 0x44f0
    // Size: 0xb4
    function kill_player() {
        self val::set(#"kill_player", "<dev string:x9c9>", 1);
        death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
        self dodamage(self.health + 666, self.origin + death_from);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x5d0c4778, Offset: 0x45b0
    // Size: 0x54
    function force_drink() {
        wait 0.01;
        build_weapon = getweapon(#"zombie_builder");
        self giveandfireoffhand(build_weapon);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x4b791e62, Offset: 0x4610
    // Size: 0x1c
    function zombie_devgui_dpad_none() {
        self thread watch_debug_input();
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x1f549dd7, Offset: 0x4638
    // Size: 0x2c
    function zombie_devgui_dpad_death() {
        self thread watch_debug_input(&kill_player);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x1f84659a, Offset: 0x4670
    // Size: 0x2c
    function zombie_devgui_dpad_damage() {
        self thread watch_debug_input(&damage_player);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x8e56a570, Offset: 0x46a8
    // Size: 0x2c
    function zombie_devgui_dpad_changeweapon() {
        self thread watch_debug_input(&force_drink);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x31fd4daf, Offset: 0x46e0
    // Size: 0xc2
    function watch_debug_input(callback) {
        self endon(#"disconnect");
        self notify(#"watch_debug_input");
        self endon(#"watch_debug_input");
        level.devgui_dpad_watch = 0;
        if (isdefined(callback)) {
            level.devgui_dpad_watch = 1;
            for (;;) {
                if (self actionslottwobuttonpressed()) {
                    self thread [[ callback ]]();
                    while (self actionslottwobuttonpressed()) {
                        waitframe(1);
                    }
                }
                waitframe(1);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb3ef0ec, Offset: 0x47b0
    // Size: 0x3958
    function zombie_devgui_think() {
        level notify(#"zombie_devgui_think");
        level endon(#"zombie_devgui_think");
        for (;;) {
            cmd = getdvarstring(#"zombie_devgui");
            switch (cmd) {
            case #"money":
                players = getplayers();
                array::thread_all(players, &zombie_devgui_give_money);
                break;
            case #"player1_money":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_give_money();
                }
                break;
            case #"player2_money":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_give_money();
                }
                break;
            case #"player3_money":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_give_money();
                }
                break;
            case #"player4_money":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_give_money();
                }
                break;
            case #"moneydown":
                players = getplayers();
                array::thread_all(players, &zombie_devgui_take_money);
                break;
            case #"player1_moneydown":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_take_money();
                }
                break;
            case #"player2_moneydown":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_take_money();
                }
                break;
            case #"player3_moneydown":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_take_money();
                }
                break;
            case #"player4_moneydown":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_take_money();
                }
                break;
            case #"hash_59a96f9816430398":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_give_xp(1000);
                }
                break;
            case #"hash_423b4f1fbe6391dd":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_give_xp(1000);
                }
                break;
            case #"hash_50580bf75ed9e65e":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_give_xp(1000);
                }
                break;
            case #"hash_4e18caaf131ec443":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_give_xp(1000);
                }
                break;
            case #"hash_1dec476dd3df3678":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_give_xp(10000);
                }
                break;
            case #"hash_6e595ff08330f5b7":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_give_xp(10000);
                }
                break;
            case #"hash_5f82c3562c428cea":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_give_xp(10000);
                }
                break;
            case #"hash_52e4da7d7d47cf69":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_give_xp(10000);
                }
                break;
            case #"health":
                array::thread_all(getplayers(), &zombie_devgui_give_health);
                break;
            case #"player1_health":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_give_health();
                }
                break;
            case #"player2_health":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_give_health();
                }
                break;
            case #"player3_health":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_give_health();
                }
                break;
            case #"player4_health":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_give_health();
                }
                break;
            case #"minhealth":
                array::thread_all(getplayers(), &zombie_devgui_low_health);
                break;
            case #"player1_minhealth":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_low_health();
                }
                break;
            case #"player2_minhealth":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_low_health();
                }
                break;
            case #"player3_minhealth":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_low_health();
                }
                break;
            case #"player4_minhealth":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_low_health();
                }
                break;
            case #"ammo":
                array::thread_all(getplayers(), &zombie_devgui_toggle_ammo);
                break;
            case #"ignore":
                array::thread_all(getplayers(), &zombie_devgui_toggle_ignore);
                break;
            case #"player1_ignore":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_toggle_ignore();
                }
                break;
            case #"player2_ignore":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_toggle_ignore();
                }
                break;
            case #"player3_ignore":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_toggle_ignore();
                }
                break;
            case #"player4_ignore":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_toggle_ignore();
                }
                break;
            case #"invul_on":
                zombie_devgui_invulnerable(undefined, 1);
                break;
            case #"invul_off":
                zombie_devgui_invulnerable(undefined, 0);
                break;
            case #"player1_invul_on":
                zombie_devgui_invulnerable(0, 1);
                break;
            case #"player1_invul_off":
                zombie_devgui_invulnerable(0, 0);
                break;
            case #"player2_invul_on":
                zombie_devgui_invulnerable(1, 1);
                break;
            case #"player2_invul_off":
                zombie_devgui_invulnerable(1, 0);
                break;
            case #"player3_invul_on":
                zombie_devgui_invulnerable(2, 1);
                break;
            case #"player3_invul_off":
                zombie_devgui_invulnerable(2, 0);
                break;
            case #"player4_invul_on":
                zombie_devgui_invulnerable(3, 1);
                break;
            case #"player4_invul_off":
                zombie_devgui_invulnerable(3, 0);
                break;
            case #"revive_all":
                array::thread_all(getplayers(), &zombie_devgui_revive);
                break;
            case #"player1_revive":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_revive();
                }
                break;
            case #"player2_revive":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_revive();
                }
                break;
            case #"player3_revive":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_revive();
                }
                break;
            case #"player4_revive":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_revive();
                }
                break;
            case #"player1_kill":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_kill();
                }
                break;
            case #"player2_kill":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_kill();
                }
                break;
            case #"player3_kill":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_kill();
                }
                break;
            case #"player4_kill":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_kill();
                }
                break;
            case #"hash_14e1dd7c3a085d60":
                players = getplayers();
                players[0] thread zombie_force_char(1);
                break;
            case #"hash_14e1e07c3a086279":
                players = getplayers();
                players[0] thread zombie_force_char(2);
                break;
            case #"hash_14e1df7c3a0860c6":
                players = getplayers();
                players[0] thread zombie_force_char(3);
                break;
            case #"hash_14e1e27c3a0865df":
                players = getplayers();
                players[0] thread zombie_force_char(4);
                break;
            case #"hash_14e1e17c3a08642c":
                players = getplayers();
                players[0] thread zombie_force_char(5);
                break;
            case #"hash_14e1e47c3a086945":
                players = getplayers();
                players[0] thread zombie_force_char(6);
                break;
            case #"hash_14e1e37c3a086792":
                players = getplayers();
                players[0] thread zombie_force_char(7);
                break;
            case #"hash_14e1e67c3a086cab":
                players = getplayers();
                players[0] thread zombie_force_char(8);
                break;
            case #"hash_14e1e57c3a086af8":
                players = getplayers();
                players[0] thread zombie_force_char(9);
                break;
            case #"hash_428aa169c368ef0":
                players = getplayers();
                players[0] thread zombie_force_char(10);
                break;
            case #"hash_428ab169c3690a3":
                players = getplayers();
                players[0] thread zombie_force_char(11);
                break;
            case #"hash_428ac169c369256":
                players = getplayers();
                players[0] thread zombie_force_char(12);
                break;
            case #"hash_36ae46c01d2e5e1f":
                players = getplayers();
                players[1] thread zombie_force_char(1);
                break;
            case #"hash_36ae47c01d2e5fd2":
                players = getplayers();
                players[1] thread zombie_force_char(2);
                break;
            case #"hash_36ae48c01d2e6185":
                players = getplayers();
                players[1] thread zombie_force_char(3);
                break;
            case #"hash_36ae41c01d2e55a0":
                players = getplayers();
                players[1] thread zombie_force_char(4);
                break;
            case #"hash_36ae42c01d2e5753":
                players = getplayers();
                players[1] thread zombie_force_char(5);
                break;
            case #"hash_36ae43c01d2e5906":
                players = getplayers();
                players[1] thread zombie_force_char(6);
                break;
            case #"hash_36ae44c01d2e5ab9":
                players = getplayers();
                players[1] thread zombie_force_char(7);
                break;
            case #"hash_36ae4dc01d2e6a04":
                players = getplayers();
                players[1] thread zombie_force_char(8);
                break;
            case #"hash_36ae4ec01d2e6bb7":
                players = getplayers();
                players[1] thread zombie_force_char(9);
                break;
            case #"hash_1880677195ca09dd":
                players = getplayers();
                players[1] thread zombie_force_char(10);
                break;
            case #"hash_1880667195ca082a":
                players = getplayers();
                players[1] thread zombie_force_char(11);
                break;
            case #"hash_1880657195ca0677":
                players = getplayers();
                players[1] thread zombie_force_char(12);
                break;
            case #"hash_1e248d6a81641fee":
                players = getplayers();
                players[2] thread zombie_force_char(1);
                break;
            case #"hash_1e248c6a81641e3b":
                players = getplayers();
                players[2] thread zombie_force_char(2);
                break;
            case #"hash_1e248b6a81641c88":
                players = getplayers();
                players[2] thread zombie_force_char(3);
                break;
            case #"hash_1e24926a8164286d":
                players = getplayers();
                players[2] thread zombie_force_char(4);
                break;
            case #"hash_1e24916a816426ba":
                players = getplayers();
                players[2] thread zombie_force_char(5);
                break;
            case #"hash_1e24906a81642507":
                players = getplayers();
                players[2] thread zombie_force_char(6);
                break;
            case #"hash_1e248f6a81642354":
                players = getplayers();
                players[2] thread zombie_force_char(7);
                break;
            case #"hash_1e24866a81641409":
                players = getplayers();
                players[2] thread zombie_force_char(8);
                break;
            case #"hash_1e24856a81641256":
                players = getplayers();
                players[2] thread zombie_force_char(9);
                break;
            case #"hash_1c3c29f9dd22263a":
                players = getplayers();
                players[2] thread zombie_force_char(10);
                break;
            case #"hash_1c3c2af9dd2227ed":
                players = getplayers();
                players[2] thread zombie_force_char(11);
                break;
            case #"hash_1c3c27f9dd2222d4":
                players = getplayers();
                players[2] thread zombie_force_char(12);
                break;
            case #"hash_2bd7e2aa08c9a3d5":
                players = getplayers();
                players[3] thread zombie_force_char(1);
                break;
            case #"hash_2bd7dfaa08c99ebc":
                players = getplayers();
                players[3] thread zombie_force_char(2);
                break;
            case #"hash_2bd7e0aa08c9a06f":
                players = getplayers();
                players[3] thread zombie_force_char(3);
                break;
            case #"hash_2bd7ddaa08c99b56":
                players = getplayers();
                players[3] thread zombie_force_char(4);
                break;
            case #"hash_2bd7deaa08c99d09":
                players = getplayers();
                players[3] thread zombie_force_char(5);
                break;
            case #"hash_2bd7dbaa08c997f0":
                players = getplayers();
                players[3] thread zombie_force_char(6);
                break;
            case #"hash_2bd7dcaa08c999a3":
                players = getplayers();
                players[3] thread zombie_force_char(7);
                break;
            case #"hash_2bd7e9aa08c9afba":
                players = getplayers();
                players[3] thread zombie_force_char(8);
                break;
            case #"hash_2bd7eaaa08c9b16d":
                players = getplayers();
                players[3] thread zombie_force_char(9);
                break;
            case #"hash_497a0beceea17e1f":
                players = getplayers();
                players[3] thread zombie_force_char(10);
                break;
            case #"hash_497a0aeceea17c6c":
                players = getplayers();
                players[3] thread zombie_force_char(11);
                break;
            case #"hash_497a0deceea18185":
                players = getplayers();
                players[3] thread zombie_force_char(12);
                break;
            case #"hash_7f4d70c7ded8e94a":
                array::thread_all(getplayers(), &function_491277d6);
                break;
            case #"hash_505efa1825e2cb99":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread function_491277d6();
                }
                break;
            case #"hash_15233852e3dc3500":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread function_491277d6();
                }
                break;
            case #"hash_5cb5edc4858d92f7":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread function_491277d6();
                }
                break;
            case #"hash_6d57ff86c541a5fe":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread function_491277d6();
                }
                break;
            case #"hash_2c320318aed843b2":
                array::thread_all(getplayers(), &zm_laststand::function_7996dd34, 100);
                break;
            case #"hash_72783b08840a3ab7":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zm_laststand::function_7996dd34(100);
                }
                break;
            case #"hash_447712ef48d6ea0":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zm_laststand::function_7996dd34(100);
                }
                break;
            case #"hash_2a15f60adbba0cf5":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zm_laststand::function_7996dd34(100);
                }
                break;
            case #"hash_430eb4715f49a5fe":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zm_laststand::function_7996dd34(100);
                }
                break;
            case #"specialty_quickrevive":
                level.solo_lives_given = 0;
            case #"specialty_additionalprimaryweapon":
            case #"specialty_vultureaid":
            case #"specialty_doubletap2":
            case #"specialty_electriccherry":
            case #"specialty_phdflopper":
            case #"specialty_staminup":
            case #"specialty_fastmeleerecovery":
            case #"specialty_deadshot":
            case #"specialty_widowswine":
            case #"specialty_showonradar":
                zombie_devgui_give_perk(cmd);
                break;
            case #"wunderfizz_leaving":
                function_af69dfbe(cmd);
                break;
            case #"wunderfizz_arriving":
                function_3df1388a(cmd);
                break;
            case #"wunderfizz_vending":
                function_f976401d(cmd);
                break;
            case #"wunderfizz_idle":
                function_a888b17c(cmd);
                break;
            case #"hash_67d324a91b1fd821":
                function_7743668b(cmd);
                break;
            case #"wunderfizz_initial":
                function_7d8af9ea(cmd);
                break;
            case #"wunderfizz_away":
                function_7d8af9ea(cmd);
                break;
            case #"remove_perks":
                zombie_devgui_take_perks(cmd);
                break;
            case #"hash_6b0b935133015533":
                zombie_devgui_turn_player();
                break;
            case #"hash_39f82c9a86c0b7a":
                zombie_devgui_turn_player(0);
                break;
            case #"hash_1b4bec20084148b5":
                zombie_devgui_turn_player(1);
                break;
            case #"hash_4304d03597f4e69c":
                zombie_devgui_turn_player(2);
                break;
            case #"hash_1f41ab8e693af15f":
                zombie_devgui_turn_player(3);
                break;
            case #"bonus_points_team":
            case #"free_perk":
            case #"random_weapon":
            case #"extra_lives":
            case #"meat_stink":
            case #"tesla":
            case #"nuke":
            case #"pack_a_punch":
            case #"full_ammo":
            case #"bonfire_sale":
            case #"bonus_points_player":
            case #"empty_clip":
            case #"fire_sale":
            case #"lose_points_team":
            case #"double_points":
            case #"hero_weapon_power":
            case #"minigun":
            case #"zmarcade_key":
            case #"carpenter":
            case #"insta_kill":
            case #"lose_perk":
                zombie_devgui_give_powerup(cmd, 1);
                break;
            case #"next_insta_kill":
            case #"next_bonfire_sale":
            case #"next_empty_clip":
            case #"next_tesla":
            case #"next_minigun":
            case #"next_full_ammo":
            case #"next_bonus_points_player":
            case #"next_fire_sale":
            case #"next_lose_points_team":
            case #"next_double_points":
            case #"next_random_weapon":
            case #"next_bonus_points_team":
            case #"next_hero_weapon_power":
            case #"next_extra_lives":
            case #"next_nuke":
            case #"next_lose_perk":
            case #"next_pack_a_punch":
            case #"next_free_perk":
            case #"next_meat_stink":
            case #"next_carpenter":
            case #"next_zmarcade_key":
                zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
                break;
            case #"round":
                zombie_devgui_goto_round(getdvarint(#"scr_zombie_round", 0));
                break;
            case #"round_next":
                zombie_devgui_goto_round(level.round_number + 1);
                break;
            case #"round_prev":
                zombie_devgui_goto_round(level.round_number - 1);
                break;
            case #"chest_warp":
                array::thread_all(getplayers(), &function_4619dfa7);
                break;
            case #"pap_warp":
                array::thread_all(getplayers(), &function_6f73915f);
                break;
            case #"chest_move":
                if (isdefined(level.chest_accessed)) {
                    level notify(#"devgui_chest_end_monitor");
                    level.var_642d32dc = 1;
                }
                break;
            case #"chest_never_move":
                if (isdefined(level.chest_accessed)) {
                    level.var_642d32dc = 0;
                    level thread zombie_devgui_chest_never_move();
                }
                break;
            case #"chest":
                if (isdefined(level.zombie_weapons[getweapon(getdvarstring(#"scr_force_weapon"))])) {
                }
                break;
            case #"give_claymores":
                array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon(#"claymore"));
                break;
            case #"give_bouncingbetties":
                array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon(#"bouncingbetty"));
                break;
            case #"give_frags":
                array::thread_all(getplayers(), &zombie_devgui_give_frags);
                break;
            case #"give_sticky":
                array::thread_all(getplayers(), &zombie_devgui_give_sticky);
                break;
            case #"give_monkey":
                array::thread_all(getplayers(), &zombie_devgui_give_monkey);
                break;
            case #"give_bhb":
                array::thread_all(getplayers(), &zombie_devgui_give_bhb);
                break;
            case #"give_quantum":
                array::thread_all(getplayers(), &zombie_devgui_give_qed);
                break;
            case #"give_dolls":
                array::thread_all(getplayers(), &zombie_devgui_give_dolls);
                break;
            case #"give_emp_bomb":
                array::thread_all(getplayers(), &zombie_devgui_give_emp_bomb);
                break;
            case #"dog_round":
                zombie_devgui_dog_round(getdvarint(#"scr_zombie_dogs", 0));
                break;
            case #"dog_round_skip":
                zombie_devgui_dog_round_skip();
                break;
            case #"print_variables":
                zombie_devgui_dump_zombie_vars();
                break;
            case #"pack_current_weapon":
                zombie_devgui_pack_current_weapon();
                break;
            case #"hash_f9c9f7dd75a4047":
                function_9e5bfd9d();
                break;
            case #"hash_5605531ad17b5408":
                function_435ea700();
                break;
            case #"hash_2dde14d5c2960aea":
                function_525facc6();
                break;
            case #"hash_465e01a5b9f4f28e":
                function_935f6cc2();
                break;
            case #"hash_26abd478093a24d0":
                zombie_devgui_repack_current_weapon();
                break;
            case #"unpack_current_weapon":
                zombie_devgui_unpack_current_weapon();
                break;
            case #"hash_3c2b067b1510118c":
                function_2306f73c();
                break;
            case #"hash_769c6d03952dd107":
                function_5da1c3cd();
                break;
            case #"hash_68e9afed4aa9c0dd":
                function_6afc4c2f();
                break;
            case #"hash_3f4888627ed06269":
                function_9b4ea903();
                break;
            case #"hash_73ecd8731ecdf6b0":
                function_4d2e8278();
                break;
            case #"hash_49563ad3930e97e4":
                function_ce561484();
                break;
            case #"reopt_current_weapon":
                zombie_devgui_reopt_current_weapon();
                break;
            case #"weapon_take_all_fallback":
                zombie_devgui_take_weapons(1);
                break;
            case #"weapon_take_all":
                zombie_devgui_take_weapons(0);
                break;
            case #"weapon_take_current":
                zombie_devgui_take_weapon();
                break;
            case #"power_on":
                level flag::set("<dev string:x9d4>");
                level clientfield::set("<dev string:x9dd>", 0);
                power_trigs = getentarray("<dev string:x9ed>", "<dev string:x9fd>");
                foreach (trig in power_trigs) {
                    if (isdefined(trig.script_int)) {
                        level flag::set("<dev string:x9d4>" + trig.script_int);
                        level clientfield::set("<dev string:x9dd>", trig.script_int);
                    }
                }
                break;
            case #"power_off":
                level flag::clear("<dev string:x9d4>");
                level clientfield::set("<dev string:xa08>", 0);
                power_trigs = getentarray("<dev string:x9ed>", "<dev string:x9fd>");
                foreach (trig in power_trigs) {
                    if (isdefined(trig.script_int)) {
                        level flag::clear("<dev string:x9d4>" + trig.script_int);
                        level clientfield::set("<dev string:xa08>", trig.script_int);
                    }
                }
                break;
            case #"zombie_dpad_none":
                array::thread_all(getplayers(), &zombie_devgui_dpad_none);
                break;
            case #"zombie_dpad_damage":
                array::thread_all(getplayers(), &zombie_devgui_dpad_damage);
                break;
            case #"zombie_dpad_kill":
                array::thread_all(getplayers(), &zombie_devgui_dpad_death);
                break;
            case #"zombie_dpad_drink":
                array::thread_all(getplayers(), &zombie_devgui_dpad_changeweapon);
                break;
            case #"director_easy":
                zombie_devgui_director_easy();
                break;
            case #"open_sesame":
                zombie_devgui_open_sesame();
                break;
            case #"allow_fog":
                zombie_devgui_allow_fog();
                break;
            case #"disable_kill_thread_toggle":
                zombie_devgui_disable_kill_thread_toggle();
                break;
            case #"check_kill_thread_every_frame_toggle":
                zombie_devgui_check_kill_thread_every_frame_toggle();
                break;
            case #"kill_thread_test_mode_toggle":
                zombie_devgui_kill_thread_test_mode_toggle();
                break;
            case #"zombie_failsafe_debug_flush":
                level notify(#"zombie_failsafe_debug_flush");
                break;
            case #"rat_navmesh":
                level thread rat::derriesezombiespawnnavmeshtest(0, 0);
                break;
            case #"spawn":
                devgui_zombie_spawn();
                break;
            case #"spawn_dummy":
                function_d4729c29();
                break;
            case #"spawn_near":
                function_dbcd6ef5();
                break;
            case #"spawn_all":
                devgui_all_spawn();
                break;
            case #"crawler":
                devgui_make_crawler();
                break;
            case #"toggle_show_spawn_locations":
                devgui_toggle_show_spawn_locations();
                break;
            case #"toggle_show_exterior_goals":
                devgui_toggle_show_exterior_goals();
                break;
            case #"draw_traversals":
                zombie_devgui_draw_traversals();
                break;
            case #"dump_traversals":
                function_364ed1b9();
                break;
            case #"debug_hud":
                array::thread_all(getplayers(), &devgui_debug_hud);
                break;
            case #"reverse_carpenter":
                function_b61a1649();
                break;
            case #"keyline_always":
                zombie_devgui_keyline_always();
                break;
            case #"hash_1e51dfcdbebdf936":
                function_6aa9552a();
                break;
            case #"debug_counts":
                function_13d8ea87();
                break;
            case #"hash_604a84ea1690f781":
                thread function_1acc8e35();
                break;
            case #"hash_72a10718318ec7ff":
                function_eec2d58b();
                break;
            case #"debug_navmesh_zone":
                function_37c2486e();
                break;
            case #"hash_7fafc507d5398c0b":
                function_31d6844b();
                break;
            case #"hash_3ede275f03a4aa2b":
                function_37d3628f();
                break;
            case #"hash_74f6277a8a40911e":
                function_bb3eec88();
                break;
            case #"hash_3d647b897ae5dca6":
                function_53733668();
                break;
            case #"hash_3f826ccc785705ba":
                function_13a027d8();
                break;
            case #"hash_683b625d2ace3726":
                function_791ff6b0();
                break;
            case #"hash_3f9e70ff9f34194a":
                function_c71fc328();
                break;
            case 0:
                break;
            default:
                if (isdefined(level.custom_devgui)) {
                    if (isarray(level.custom_devgui)) {
                        foreach (devgui in level.custom_devgui) {
                            b_result = [[ devgui ]](cmd);
                            if (isdefined(b_result) && b_result) {
                                break;
                            }
                        }
                    } else {
                        [[ level.custom_devgui ]](cmd);
                    }
                }
                break;
            }
            setdvar(#"zombie_devgui", "<dev string:x30>");
            wait 0.5;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xf6b39027, Offset: 0x8110
    // Size: 0x172
    function add_custom_devgui_callback(callback) {
        if (isdefined(level.custom_devgui)) {
            if (!isarray(level.custom_devgui)) {
                cdgui = level.custom_devgui;
                level.custom_devgui = [];
                if (!isdefined(level.custom_devgui)) {
                    level.custom_devgui = [];
                } else if (!isarray(level.custom_devgui)) {
                    level.custom_devgui = array(level.custom_devgui);
                }
                level.custom_devgui[level.custom_devgui.size] = cdgui;
            }
        } else {
            level.custom_devgui = [];
        }
        if (!isdefined(level.custom_devgui)) {
            level.custom_devgui = [];
        } else if (!isarray(level.custom_devgui)) {
            level.custom_devgui = array(level.custom_devgui);
        }
        level.custom_devgui[level.custom_devgui.size] = callback;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x3a5cd2a6, Offset: 0x8290
    // Size: 0x64
    function devgui_all_spawn() {
        player = util::gethostplayer();
        bot::add_bots(3, player.team);
        wait 0.1;
        zombie_devgui_goto_round(8);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x7014aadd, Offset: 0x8300
    // Size: 0x3e
    function devgui_toggle_show_spawn_locations() {
        if (!isdefined(level.toggle_show_spawn_locations)) {
            level.toggle_show_spawn_locations = 1;
            return;
        }
        level.toggle_show_spawn_locations = !level.toggle_show_spawn_locations;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x833275ca, Offset: 0x8348
    // Size: 0x3e
    function devgui_toggle_show_exterior_goals() {
        if (!isdefined(level.toggle_show_exterior_goals)) {
            level.toggle_show_exterior_goals = 1;
            return;
        }
        level.toggle_show_exterior_goals = !level.toggle_show_exterior_goals;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x86b95f81, Offset: 0x8390
    // Size: 0x258
    function function_31d6844b() {
        level.var_e401f733 = !(isdefined(level.var_e401f733) && level.var_e401f733);
        if (level.var_e401f733) {
            foreach (player in level.players) {
                player setclientplayerpushamount(1);
            }
            foreach (ai in getaiteamarray(#"axis")) {
                ai pushplayer(1);
            }
            return;
        }
        foreach (player in level.players) {
            player setclientplayerpushamount(0);
        }
        foreach (ai in getaiteamarray(#"axis")) {
            ai pushplayer(0);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x7718812e, Offset: 0x85f0
    // Size: 0x1ea
    function devgui_zombie_spawn() {
        player = getplayers()[0];
        spawnername = undefined;
        spawnername = "<dev string:xa19>";
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        guy = undefined;
        spawners = getentarray(spawnername, "<dev string:xa28>");
        spawner = array::random(spawners);
        guy = zombie_utility::spawn_zombie(spawner);
        if (isdefined(guy)) {
            guy.script_string = "<dev string:x585>";
            wait 0.5;
            guy forceteleport(trace[#"position"], player.angles + (0, 180, 0));
        }
        return guy;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xbf0ac9bc, Offset: 0x87e8
    // Size: 0xdc
    function function_d4729c29() {
        player = getplayers()[0];
        forward = anglestoforward(player.angles);
        spawn = player.origin + forward * 25;
        guy = devgui_zombie_spawn();
        if (isdefined(guy)) {
            guy pathmode("<dev string:xa3a>");
            guy forceteleport(spawn, player.angles);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xfea1e388, Offset: 0x88d0
    // Size: 0xd4
    function function_dbcd6ef5() {
        player = getplayers()[0];
        forward = anglestoforward(player.angles);
        spawn = player.origin + forward * 100;
        guy = devgui_zombie_spawn();
        if (isdefined(guy)) {
            guy forceteleport(spawn, player.angles + (0, 180, 0));
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x3db818b1, Offset: 0x89b0
    // Size: 0x1d0
    function devgui_make_crawler() {
        zombies = zombie_utility::get_round_enemy_array();
        foreach (zombie in zombies) {
            gib_style = [];
            gib_style[gib_style.size] = "<dev string:xa44>";
            gib_style[gib_style.size] = "<dev string:xa4c>";
            gib_style[gib_style.size] = "<dev string:xa56>";
            gib_style = zombie_death::randomize_array(gib_style);
            zombie.a.gib_ref = gib_style[0];
            zombie zombie_utility::function_9c628842(1);
            zombie allowedstances("<dev string:xa5f>");
            zombie setphysparams(15, 0, 24);
            zombie allowpitchangle(1);
            zombie setpitchorient();
            health = zombie.health;
            health *= 0.1;
            zombie thread zombie_death::do_gib();
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x843eea6e, Offset: 0x8b88
    // Size: 0x3e4
    function zombie_devgui_open_sesame() {
        setdvar(#"zombie_unlock_all", 1);
        level flag::set("<dev string:x9d4>");
        level clientfield::set("<dev string:x9dd>", 0);
        power_trigs = getentarray("<dev string:x9ed>", "<dev string:x9fd>");
        foreach (trig in power_trigs) {
            if (isdefined(trig.script_int)) {
                level flag::set("<dev string:x9d4>" + trig.script_int);
                level clientfield::set("<dev string:x9dd>", trig.script_int);
            }
        }
        players = getplayers();
        array::thread_all(players, &zombie_devgui_give_money);
        zombie_doors = getentarray("<dev string:xa66>", "<dev string:x9fd>");
        for (i = 0; i < zombie_doors.size; i++) {
            if (!(isdefined(zombie_doors[i].has_been_opened) && zombie_doors[i].has_been_opened)) {
                zombie_doors[i] notify(#"trigger", {#activator:players[0]});
            }
            if (isdefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait) {
                zombie_doors[i] notify(#"power_on");
            }
            waitframe(1);
        }
        zombie_airlock_doors = getentarray("<dev string:xa72>", "<dev string:x9fd>");
        for (i = 0; i < zombie_airlock_doors.size; i++) {
            zombie_airlock_doors[i] notify(#"trigger", {#activator:players[0]});
            waitframe(1);
        }
        zombie_debris = getentarray("<dev string:xa85>", "<dev string:x9fd>");
        for (i = 0; i < zombie_debris.size; i++) {
            if (isdefined(zombie_debris[i])) {
                zombie_debris[i] notify(#"trigger", {#activator:players[0]});
            }
            waitframe(1);
        }
        level notify(#"open_sesame");
        wait 1;
        setdvar(#"zombie_unlock_all", 0);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xeecbc7bb, Offset: 0x8f78
    // Size: 0xa4
    function any_player_in_noclip() {
        foreach (player in getplayers()) {
            if (player isinmovemode("<dev string:xa93>", "<dev string:xa97>")) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa1ef8d41, Offset: 0x9028
    // Size: 0x168
    function diable_fog_in_noclip() {
        level.fog_disabled_in_noclip = 1;
        level endon(#"allowfoginnoclip");
        level flag::wait_till("<dev string:x36>");
        while (true) {
            while (!any_player_in_noclip()) {
                wait 1;
            }
            setdvar(#"scr_fog_disable", 1);
            setdvar(#"r_fog_disable", 1);
            if (isdefined(level.culldist)) {
                setculldist(0);
            }
            while (any_player_in_noclip()) {
                wait 1;
            }
            setdvar(#"scr_fog_disable", 0);
            setdvar(#"r_fog_disable", 0);
            if (isdefined(level.culldist)) {
                setculldist(level.culldist);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xbe0478ff, Offset: 0x9198
    // Size: 0xac
    function zombie_devgui_allow_fog() {
        if (isdefined(level.fog_disabled_in_noclip) && level.fog_disabled_in_noclip) {
            level notify(#"allowfoginnoclip");
            level.fog_disabled_in_noclip = 0;
            setdvar(#"scr_fog_disable", 0);
            setdvar(#"r_fog_disable", 0);
            return;
        }
        thread diable_fog_in_noclip();
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x25f8f57, Offset: 0x9250
    // Size: 0x9c
    function zombie_devgui_give_money() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        self zm_score::add_to_player_score(100000);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xcdbaf2ac, Offset: 0x92f8
    // Size: 0xbc
    function zombie_devgui_take_money() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        if (self.score > 100) {
            self zm_score::player_reduce_points("<dev string:xa9e>");
            return;
        }
        self zm_score::player_reduce_points("<dev string:xaa8>");
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xedc40b4d, Offset: 0x93c0
    // Size: 0xb4
    function zombie_devgui_give_xp(amount) {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self addrankxp("<dev string:xab1>", self.currentweapon, undefined, undefined, 1, amount / 50);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xeb043c37, Offset: 0x9480
    // Size: 0x174
    function zombie_devgui_turn_player(index) {
        players = getplayers();
        if (!isdefined(index) || index >= players.size) {
            player = players[0];
        } else {
            player = players[index];
        }
        assert(isdefined(player));
        assert(isplayer(player));
        assert(isalive(player));
        level.devcheater = 1;
        if (player hasperk(#"specialty_playeriszombie")) {
            println("<dev string:xab6>");
            player zm_turned::turn_to_human();
            return;
        }
        println("<dev string:xaca>");
        player zm_turned::turn_to_zombie();
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x35591040, Offset: 0x9600
    // Size: 0x1e4
    function function_4619dfa7() {
        entnum = self getentitynumber();
        chest = level.chests[level.chest_index];
        origin = chest.zbarrier.origin;
        forward = anglestoforward(chest.zbarrier.angles);
        right = anglestoright(chest.zbarrier.angles);
        var_d9191ee9 = vectortoangles(right);
        plorigin = origin - 48 * right;
        switch (entnum) {
        case 0:
            plorigin += 16 * right;
            break;
        case 1:
            plorigin += 16 * forward;
            break;
        case 2:
            plorigin -= 16 * right;
            break;
        case 3:
            plorigin -= 16 * forward;
            break;
        }
        self setorigin(plorigin);
        self setplayerangles(var_d9191ee9);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x417a3a63, Offset: 0x97f0
    // Size: 0x1fc
    function function_6f73915f() {
        entnum = self getentitynumber();
        paps = getentarray("<dev string:xadf>", "<dev string:x9fd>");
        pap = paps[0];
        if (!isdefined(pap)) {
            return;
        }
        origin = pap.origin;
        forward = anglestoforward(pap.angles);
        right = anglestoright(pap.angles);
        var_d9191ee9 = vectortoangles(right * -1);
        plorigin = origin + 72 * right;
        switch (entnum) {
        case 0:
            plorigin -= 16 * right;
            break;
        case 1:
            plorigin += 16 * forward;
            break;
        case 2:
            plorigin += 16 * right;
            break;
        case 3:
            plorigin -= 16 * forward;
            break;
        }
        self setorigin(plorigin);
        self setplayerangles(var_d9191ee9);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x98956fee, Offset: 0x99f8
    // Size: 0x2c
    function zombie_devgui_cool_jetgun() {
        if (isdefined(level.zm_devgui_jetgun_never_overheat)) {
            self thread [[ level.zm_devgui_jetgun_never_overheat ]]();
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb250dd90, Offset: 0x9a30
    // Size: 0x8e
    function zombie_devgui_preserve_turbines() {
        self endon(#"disconnect");
        self notify(#"preserve_turbines");
        self endon(#"preserve_turbines");
        if (!(isdefined(self.preserving_turbines) && self.preserving_turbines)) {
            self.preserving_turbines = 1;
            while (true) {
                self.turbine_health = 1200;
                wait 1;
            }
        }
        self.preserving_turbines = 0;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa4773f9, Offset: 0x9ac8
    // Size: 0x156
    function zombie_devgui_equipment_stays_healthy() {
        self endon(#"disconnect");
        self notify(#"preserve_equipment");
        self endon(#"preserve_equipment");
        if (!(isdefined(self.preserving_equipment) && self.preserving_equipment)) {
            self.preserving_equipment = 1;
            while (true) {
                self.equipment_damage = [];
                self.shielddamagetaken = 0;
                if (isdefined(level.destructible_equipment)) {
                    foreach (equip in level.destructible_equipment) {
                        if (isdefined(equip)) {
                            equip.shielddamagetaken = 0;
                            equip.damage = 0;
                            equip.headchopper_kills = 0;
                            equip.springpad_kills = 0;
                            equip.subwoofer_kills = 0;
                        }
                    }
                }
                wait 0.1;
            }
        }
        self.preserving_equipment = 0;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa53c914a, Offset: 0x9c28
    // Size: 0x12
    function zombie_devgui_disown_equipment() {
        self.deployed_equipment = [];
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x84355d74, Offset: 0x9c48
    // Size: 0xb4
    function zombie_devgui_equipment_give(equipment) {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (zm_equipment::is_included(equipment)) {
            self zm_equipment::buy(equipment);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xc07c56a5, Offset: 0x9d08
    // Size: 0x156
    function zombie_devgui_give_placeable_mine(weapon) {
        self endon(#"disconnect");
        self notify(#"give_planted_grenade_thread");
        self endon(#"give_planted_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (!zm_loadout::is_placeable_mine(weapon)) {
            return;
        }
        if (isdefined(self zm_loadout::get_player_placeable_mine())) {
            self takeweapon(self zm_loadout::get_player_placeable_mine());
        }
        self thread zm_placeable_mine::setup_for_player(weapon);
        while (true) {
            self givemaxammo(weapon);
            wait 1;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x1d062b63, Offset: 0x9e68
    // Size: 0x15e
    function zombie_devgui_give_claymores() {
        self endon(#"disconnect");
        self notify(#"give_planted_grenade_thread");
        self endon(#"give_planted_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_loadout::get_player_placeable_mine())) {
            self takeweapon(self zm_loadout::get_player_placeable_mine());
        }
        wpn_type = zm_placeable_mine::get_first_available();
        if (wpn_type != level.weaponnone) {
            self thread zm_placeable_mine::setup_for_player(wpn_type);
        }
        while (true) {
            self givemaxammo(wpn_type);
            wait 1;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xee8c25ee, Offset: 0x9fd0
    // Size: 0x156
    function zombie_devgui_give_lethal(weapon) {
        self endon(#"disconnect");
        self notify(#"give_lethal_grenade_thread");
        self endon(#"give_lethal_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_loadout::get_player_lethal_grenade())) {
            self takeweapon(self zm_loadout::get_player_lethal_grenade());
        }
        self giveweapon(weapon);
        self zm_loadout::set_player_lethal_grenade(weapon);
        while (true) {
            self givemaxammo(weapon);
            wait 1;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x74c7257f, Offset: 0xa130
    // Size: 0x3c
    function zombie_devgui_give_frags() {
        zombie_devgui_give_lethal(getweapon(#"eq_frag_grenade"));
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xba3d86af, Offset: 0xa178
    // Size: 0x3c
    function zombie_devgui_give_sticky() {
        zombie_devgui_give_lethal(getweapon(#"sticky_grenade"));
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x9951619d, Offset: 0xa1c0
    // Size: 0x15e
    function zombie_devgui_give_monkey() {
        self endon(#"disconnect");
        self notify(#"give_tactical_grenade_thread");
        self endon(#"give_tactical_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_loadout::get_player_tactical_grenade())) {
            self takeweapon(self zm_loadout::get_player_tactical_grenade());
        }
        if (isdefined(level.zombiemode_devgui_cymbal_monkey_give)) {
            self [[ level.zombiemode_devgui_cymbal_monkey_give ]]();
            while (true) {
                self givemaxammo(getweapon(#"cymbal_monkey"));
                wait 1;
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x5ba9b81c, Offset: 0xa328
    // Size: 0x146
    function zombie_devgui_give_bhb() {
        self endon(#"disconnect");
        self notify(#"give_tactical_grenade_thread");
        self endon(#"give_tactical_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_loadout::get_player_tactical_grenade())) {
            self takeweapon(self zm_loadout::get_player_tactical_grenade());
        }
        if (isdefined(level.var_ee99d38d)) {
            self [[ level.var_ee99d38d ]]();
            while (true) {
                self givemaxammo(level.w_black_hole_bomb);
                wait 1;
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x97d97aac, Offset: 0xa478
    // Size: 0x146
    function zombie_devgui_give_qed() {
        self endon(#"disconnect");
        self notify(#"give_tactical_grenade_thread");
        self endon(#"give_tactical_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_loadout::get_player_tactical_grenade())) {
            self takeweapon(self zm_loadout::get_player_tactical_grenade());
        }
        if (isdefined(level.var_3cddfdc)) {
            self [[ level.var_3cddfdc ]]();
            while (true) {
                self givemaxammo(level.w_quantum_bomb);
                wait 1;
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xe0f75668, Offset: 0xa5c8
    // Size: 0x146
    function zombie_devgui_give_dolls() {
        self endon(#"disconnect");
        self notify(#"give_tactical_grenade_thread");
        self endon(#"give_tactical_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_loadout::get_player_tactical_grenade())) {
            self takeweapon(self zm_loadout::get_player_tactical_grenade());
        }
        if (isdefined(level.var_c1f3b949)) {
            self [[ level.var_c1f3b949 ]]();
            while (true) {
                self givemaxammo(level.w_nesting_dolls);
                wait 1;
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc81b6557, Offset: 0xa718
    // Size: 0x15e
    function zombie_devgui_give_emp_bomb() {
        self endon(#"disconnect");
        self notify(#"give_tactical_grenade_thread");
        self endon(#"give_tactical_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_loadout::get_player_tactical_grenade())) {
            self takeweapon(self zm_loadout::get_player_tactical_grenade());
        }
        if (isdefined(level.var_af6671e1)) {
            self [[ level.var_af6671e1 ]]();
            while (true) {
                self givemaxammo(getweapon(#"emp_grenade"));
                wait 1;
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x4c39b782, Offset: 0xa880
    // Size: 0x104
    function zombie_devgui_invulnerable(playerindex, onoff) {
        players = getplayers();
        if (!isdefined(playerindex)) {
            for (i = 0; i < players.size; i++) {
                zombie_devgui_invulnerable(i, onoff);
            }
            return;
        }
        if (players.size > playerindex) {
            if (onoff) {
                players[playerindex] val::set(#"zombie_devgui", "<dev string:x9c9>", 0);
                return;
            }
            players[playerindex] val::reset(#"zombie_devgui", "<dev string:x9c9>");
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x27febdc9, Offset: 0xa990
    // Size: 0xac
    function zombie_force_char(n_char) {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self.characterindex = n_char;
        if (isdefined(level.givecustomcharacters)) {
            self [[ level.givecustomcharacters ]]();
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb7d325b2, Offset: 0xaa48
    // Size: 0x124
    function zombie_devgui_kill() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self val::set(#"devgui_kill", "<dev string:x9c9>", 1);
        death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
        self dodamage(self.health + 666, self.origin + death_from);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd5fa9247, Offset: 0xab78
    // Size: 0x2e8
    function zombie_devgui_toggle_ammo() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self notify(#"devgui_toggle_ammo");
        self endon(#"devgui_toggle_ammo");
        self.ammo4evah = !(isdefined(self.ammo4evah) && self.ammo4evah);
        while (isdefined(self) && self.ammo4evah) {
            if (!self zm_utility::is_drinking()) {
                weapon = self getcurrentweapon();
                if (weapon != level.weaponnone && weapon != level.weaponzmfists && !(isdefined(weapon.isflourishweapon) && weapon.isflourishweapon)) {
                    self setweaponoverheating(0, 0);
                    max = weapon.maxammo;
                    if (isdefined(max)) {
                        self setweaponammostock(weapon, max);
                    }
                    if (isdefined(self zm_loadout::get_player_tactical_grenade())) {
                        self givemaxammo(self zm_loadout::get_player_tactical_grenade());
                    }
                    if (isdefined(self zm_loadout::get_player_lethal_grenade())) {
                        self givemaxammo(self zm_loadout::get_player_lethal_grenade());
                    }
                }
                for (i = 0; i < 3; i++) {
                    if (isdefined(self._gadgets_player[i]) && self hasweapon(self._gadgets_player[i])) {
                        if (!self util::gadget_is_in_use(i) && self gadgetcharging(i)) {
                            self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
                        }
                    }
                }
            }
            wait 1;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x707617b5, Offset: 0xae68
    // Size: 0x134
    function zombie_devgui_toggle_ignore() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        if (!isdefined(self.devgui_ignoreme)) {
            self.devgui_ignoreme = 0;
        }
        self.devgui_ignoreme = !self.devgui_ignoreme;
        if (self.devgui_ignoreme) {
            self val::set(#"devgui", "<dev string:xaef>");
        } else {
            self val::reset(#"devgui", "<dev string:xaef>");
        }
        if (self.ignoreme) {
            setdvar(#"ai_showfailedpaths", 0);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xaa8703a0, Offset: 0xafa8
    // Size: 0x15e
    function zombie_devgui_revive() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self reviveplayer();
        self notify(#"stop_revive_trigger");
        if (isdefined(self.revivetrigger)) {
            self.revivetrigger delete();
            self.revivetrigger = undefined;
        }
        self allowjump(1);
        self val::reset(#"laststand", "<dev string:xaef>");
        self.laststand = undefined;
        self clientfield::set("<dev string:xaf8>", 0);
        self notify(#"player_revived", {#reviver:self});
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd7a18c46, Offset: 0xb110
    // Size: 0x12c
    function zombie_devgui_give_health() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self notify(#"devgui_health");
        self endon(#"devgui_health");
        self endon(#"disconnect");
        self endon(#"death");
        level.devcheater = 1;
        while (true) {
            self.maxhealth = 100000;
            self.health = 100000;
            self waittill(#"player_revived", #"perk_used", #"spawned_player");
            wait 2;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd3722ab, Offset: 0xb248
    // Size: 0x124
    function zombie_devgui_low_health() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self notify(#"devgui_health");
        self endon(#"devgui_health");
        self endon(#"disconnect");
        self endon(#"death");
        level.devcheater = 1;
        while (true) {
            self.maxhealth = 10;
            self.health = 10;
            self waittill(#"player_revived", #"perk_used", #"spawned_player");
            wait 2;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xb7688ba4, Offset: 0xb378
    // Size: 0x136
    function zombie_devgui_give_perk(perk) {
        vending_machines = zm_perks::get_perk_machines();
        level.devcheater = 1;
        if (vending_machines.size < 1) {
            return;
        }
        foreach (player in getplayers()) {
            for (i = 0; i < vending_machines.size; i++) {
                if (vending_machines[i].script_noteworthy == perk) {
                    vending_machines[i] notify(#"trigger", {#activator:player});
                    break;
                }
            }
            wait 1;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x1256049e, Offset: 0xb4b8
    // Size: 0x19e
    function zombie_devgui_take_perks(cmd) {
        vending_machines = zm_perks::get_perk_machines();
        perks = [];
        for (i = 0; i < vending_machines.size; i++) {
            perk = vending_machines[i].script_noteworthy;
            if (isdefined(self.perk_purchased) && self.perk_purchased == perk) {
                continue;
            }
            perks[perks.size] = perk;
        }
        foreach (player in getplayers()) {
            foreach (perk in perks) {
                perk_str = perk + "<dev string:xb05>";
                player notify(perk_str);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x4e56662c, Offset: 0xb660
    // Size: 0x34
    function function_af69dfbe(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xe91c723f, Offset: 0xb6a0
    // Size: 0x34
    function function_3df1388a(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xf0071911, Offset: 0xb6e0
    // Size: 0x34
    function function_f976401d(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xb5bc75c4, Offset: 0xb720
    // Size: 0x34
    function function_a888b17c(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x3f6e6642, Offset: 0xb760
    // Size: 0x34
    function function_7743668b(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x714b694e, Offset: 0xb7a0
    // Size: 0x34
    function function_7d8af9ea(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x23066c6e, Offset: 0xb7e0
    // Size: 0x34
    function function_c2cda548(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 3, eflags: 0x0
    // Checksum 0xc851841a, Offset: 0xb820
    // Size: 0x27c
    function zombie_devgui_give_powerup(powerup_name, now, origin) {
        player = getplayers()[0];
        found = 0;
        level.devcheater = 1;
        if (isdefined(now) && !now) {
            for (i = 0; i < level.zombie_powerup_array.size; i++) {
                if (level.zombie_powerup_array[i] == powerup_name) {
                    level.zombie_powerup_index = i;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                return;
            }
            level.zombie_devgui_power = 1;
            zombie_utility::set_zombie_var(#"zombie_drop_item", 1);
            level.powerup_drop_count = 0;
            return;
        }
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        if (!isdefined(level.zombie_powerups) || !isdefined(level.zombie_powerups[powerup_name])) {
            return;
        }
        if (isdefined(origin)) {
            level thread zm_powerups::specific_powerup_drop(powerup_name, origin);
            return;
        }
        level thread zm_powerups::specific_powerup_drop(powerup_name, trace[#"position"]);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x86e58e0b, Offset: 0xbaa8
    // Size: 0x20c
    function zombie_devgui_give_powerup_player(powerup_name, now) {
        player = self;
        found = 0;
        level.devcheater = 1;
        if (isdefined(now) && !now) {
            for (i = 0; i < level.zombie_powerup_array.size; i++) {
                if (level.zombie_powerup_array[i] == powerup_name) {
                    level.zombie_powerup_index = i;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                return;
            }
            level.zombie_devgui_power = 1;
            zombie_utility::set_zombie_var(#"zombie_drop_item", 1);
            level.powerup_drop_count = 0;
            return;
        }
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        level thread zm_powerups::specific_powerup_drop(powerup_name, trace[#"position"], undefined, undefined, player);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x5b169f3, Offset: 0xbcc0
    // Size: 0x19e
    function zombie_devgui_goto_round(target_round) {
        player = getplayers()[0];
        if (target_round < 1) {
            target_round = 1;
        }
        level.devcheater = 1;
        level.zombie_total = 0;
        level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), target_round);
        zm_round_logic::set_round_number(target_round - 1);
        level notify(#"kill_round");
        wait 1;
        zombies = getaiteamarray(level.zombie_team);
        if (isdefined(zombies)) {
            for (i = 0; i < zombies.size; i++) {
                if (isdefined(zombies[i].ignore_devgui_death) && zombies[i].ignore_devgui_death) {
                    continue;
                }
                zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x21056e43, Offset: 0xbe68
    // Size: 0x34
    function zombie_devgui_monkey_round() {
        if (isdefined(level.var_175c18a7)) {
            zombie_devgui_goto_round(level.var_175c18a7);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x71d9dc1f, Offset: 0xbea8
    // Size: 0x34
    function zombie_devgui_thief_round() {
        if (isdefined(level.var_a60cad7e)) {
            zombie_devgui_goto_round(level.var_a60cad7e);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x486532a0, Offset: 0xbee8
    // Size: 0xec
    function zombie_devgui_dog_round(num_dogs) {
        if (!isdefined(level.var_61c54e76) || !level.var_61c54e76) {
            return;
        }
        if (!isdefined(level.var_459c76d) || !level.var_459c76d) {
            return;
        }
        if (!isdefined(level.enemy_dog_spawns) || level.enemy_dog_spawns.size < 1) {
            return;
        }
        if (!level flag::get("<dev string:xb0b>")) {
            setdvar(#"force_dogs", num_dogs);
        }
        zombie_devgui_goto_round(level.round_number + 1);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x15be96d4, Offset: 0xbfe0
    // Size: 0x34
    function zombie_devgui_dog_round_skip() {
        if (isdefined(level.next_dog_round)) {
            zombie_devgui_goto_round(level.next_dog_round);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x937cf987, Offset: 0xc020
    // Size: 0xfc
    function zombie_devgui_dump_zombie_vars() {
        if (!isdefined(level.zombie_vars)) {
            return;
        }
        if (level.zombie_vars.size > 0) {
            println("<dev string:xb15>");
        } else {
            return;
        }
        var_names = getarraykeys(level.zombie_vars);
        for (i = 0; i < level.zombie_vars.size; i++) {
            key = var_names[i];
            println(key + "<dev string:xb30>" + zombie_utility::get_zombie_var(key));
        }
        println("<dev string:xb37>");
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x18277875, Offset: 0xc128
    // Size: 0x19e
    function zombie_devgui_pack_current_weapon() {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "<dev string:xb58>") {
                weap = players[i] getcurrentweapon();
                weapon = get_upgrade(weap.rootweapon);
                players[i] takeweapon(weap);
                weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
                players[i] thread aat::remove(weapon);
                players[i] zm_weapons::function_d13d5303(weapon);
                players[i] switchtoweapon(weapon);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x2a7cb05b, Offset: 0xc2d0
    // Size: 0x12e
    function zombie_devgui_repack_current_weapon() {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "<dev string:xb58>") {
                weap = players[i] getcurrentweapon();
                if (isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weap)) {
                    players[i] thread aat::acquire(weap);
                }
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xbbf443e5, Offset: 0xc408
    // Size: 0x176
    function zombie_devgui_unpack_current_weapon() {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "<dev string:xb58>") {
                weap = players[i] getcurrentweapon();
                weapon = zm_weapons::get_base_weapon(weap);
                players[i] takeweapon(weap);
                weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
                players[i] zm_weapons::function_d13d5303(weapon);
                players[i] switchtoweapon(weapon);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x912ad151, Offset: 0xc588
    // Size: 0x74
    function function_3ec0de8d(itemindex, xp) {
        if (!itemindex || !level.onlinegame) {
            return;
        }
        if (0 > xp) {
            xp = 0;
        }
        self stats::set_stat(#"weaponstats", itemindex, #"xp", xp);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x78792ed1, Offset: 0xc608
    // Size: 0xf6
    function function_949d6013(weapon) {
        gunlevels = [];
        table = popups::devgui_notif_getgunleveltablename();
        weapon_name = weapon.rootweapon.name;
        for (i = 0; i < 15; i++) {
            var_d4b6b0ab = tablelookup(table, 2, weapon_name, 0, i, 1);
            if ("<dev string:x30>" == var_d4b6b0ab) {
                break;
            }
            gunlevels[i] = int(var_d4b6b0ab);
        }
        return gunlevels;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x2dc84e34, Offset: 0xc708
    // Size: 0x88
    function function_718c64af(weapon, var_2e8a2b5e) {
        xp = 0;
        gunlevels = function_949d6013(weapon);
        if (gunlevels.size) {
            xp = gunlevels[gunlevels.size - 1];
            if (var_2e8a2b5e < gunlevels.size) {
                xp = gunlevels[var_2e8a2b5e];
            }
        }
        return xp;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x3aa3c996, Offset: 0xc798
    // Size: 0x64
    function function_e9906f08(weapon) {
        xp = 0;
        gunlevels = function_949d6013(weapon);
        if (gunlevels.size) {
            xp = gunlevels[gunlevels.size - 1];
        }
        return xp;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xea2f6eae, Offset: 0xc808
    // Size: 0x126
    function function_2306f73c() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                weapon = player getcurrentweapon();
                itemindex = getbaseweaponitemindex(weapon);
                var_2e8a2b5e = player getcurrentgunrank(itemindex);
                xp = function_718c64af(weapon, var_2e8a2b5e);
                player function_3ec0de8d(itemindex, xp);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6b5d0793, Offset: 0xc938
    // Size: 0x12e
    function function_5da1c3cd() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                weapon = player getcurrentweapon();
                itemindex = getbaseweaponitemindex(weapon);
                var_2e8a2b5e = player getcurrentgunrank(itemindex);
                xp = function_718c64af(weapon, var_2e8a2b5e);
                player function_3ec0de8d(itemindex, xp - 50);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x82fd591f, Offset: 0xca70
    // Size: 0x106
    function function_6afc4c2f() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                weapon = player getcurrentweapon();
                itemindex = getbaseweaponitemindex(weapon);
                xp = function_e9906f08(weapon);
                player function_3ec0de8d(itemindex, xp);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xfb6fa487, Offset: 0xcb80
    // Size: 0xe6
    function function_9b4ea903() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                weapon = player getcurrentweapon();
                itemindex = getbaseweaponitemindex(weapon);
                player function_3ec0de8d(itemindex, 0);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x365e9ed9, Offset: 0xcc70
    // Size: 0x148
    function function_4d2e8278() {
        players = getplayers();
        level.devcheater = 1;
        a_weapons = enumerateweapons("<dev string:xb62>");
        for (weapon_index = 0; weapon_index < a_weapons.size; weapon_index++) {
            weapon = a_weapons[weapon_index];
            itemindex = getbaseweaponitemindex(weapon);
            if (!itemindex) {
                continue;
            }
            xp = function_e9906f08(weapon);
            for (i = 0; i < players.size; i++) {
                player = players[i];
                if (!player laststand::player_is_in_laststand()) {
                    player function_3ec0de8d(itemindex, xp);
                }
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xdbfbe393, Offset: 0xcdc0
    // Size: 0x130
    function function_ce561484() {
        players = getplayers();
        level.devcheater = 1;
        a_weapons = enumerateweapons("<dev string:xb62>");
        for (weapon_index = 0; weapon_index < a_weapons.size; weapon_index++) {
            weapon = a_weapons[weapon_index];
            itemindex = getbaseweaponitemindex(weapon);
            if (!itemindex) {
                continue;
            }
            for (i = 0; i < players.size; i++) {
                player = players[i];
                if (!player laststand::player_is_in_laststand()) {
                    player function_3ec0de8d(itemindex, 0);
                }
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x17f110f9, Offset: 0xcef8
    // Size: 0x124
    function function_be6b95c4(xp) {
        if (self.pers[#"rankxp"] > xp) {
            self.pers[#"rank"] = 0;
            self setrank(0);
            self stats::set_stat(#"playerstatslist", #"rank", #"statvalue", 0);
        }
        self.pers[#"rankxp"] = xp;
        self rank::updaterank();
        self stats::set_stat(#"playerstatslist", #"rank", #"statvalue", self.pers[#"rank"]);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xe0b08b92, Offset: 0xd028
    // Size: 0x34
    function function_1a6e88f7(var_2e8a2b5e) {
        return int(rank::getrankinfominxp(var_2e8a2b5e));
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x7311d1bc, Offset: 0xd068
    // Size: 0x44
    function function_b207ef2e() {
        xp = 0;
        xp = function_1a6e88f7(level.ranktable.size - 1);
        return xp;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xe3fe7b11, Offset: 0xd0b8
    // Size: 0xde
    function function_9e5bfd9d() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                var_2e8a2b5e = player rank::getrank();
                xp = function_1a6e88f7(var_2e8a2b5e);
                player function_be6b95c4(xp);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xffa2ce3e, Offset: 0xd1a0
    // Size: 0xe6
    function function_435ea700() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                var_2e8a2b5e = player rank::getrank();
                xp = function_1a6e88f7(var_2e8a2b5e);
                player function_be6b95c4(xp - 50);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x18639c6f, Offset: 0xd290
    // Size: 0xbe
    function function_525facc6() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                xp = function_b207ef2e();
                player function_be6b95c4(xp);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc4bff2d7, Offset: 0xd358
    // Size: 0x9e
    function function_935f6cc2() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                player function_be6b95c4(0);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x5c1c2185, Offset: 0xd400
    // Size: 0x166
    function zombie_devgui_reopt_current_weapon() {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand()) {
                weapon = players[i] getcurrentweapon();
                if (isdefined(players[i].pack_a_punch_weapon_options)) {
                    players[i].pack_a_punch_weapon_options[weapon] = undefined;
                }
                players[i] takeweapon(weapon);
                weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
                players[i] zm_weapons::function_d13d5303(weapon);
                players[i] switchtoweapon(weapon);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd19f435d, Offset: 0xd570
    // Size: 0xe6
    function zombie_devgui_take_weapon() {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand()) {
                players[i] takeweapon(players[i] getcurrentweapon());
                players[i] zm_weapons::switch_back_primary_weapon(undefined);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x7b9de136, Offset: 0xd660
    // Size: 0xd6
    function zombie_devgui_take_weapons(give_fallback) {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand()) {
                players[i] takeallweapons();
                if (give_fallback) {
                    players[i] zm_weapons::give_fallback_weapon();
                }
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x7c38debf, Offset: 0xd740
    // Size: 0x7c
    function get_upgrade(weapon) {
        if (isdefined(level.zombie_weapons[weapon]) && isdefined(level.zombie_weapons[weapon].upgrade_name)) {
            return zm_weapons::get_upgrade_weapon(weapon, 0);
        }
        return zm_weapons::get_upgrade_weapon(weapon, 1);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x860d1ad, Offset: 0xd7c8
    // Size: 0x28
    function zombie_devgui_director_easy() {
        if (isdefined(level.var_fb47b57)) {
            [[ level.var_fb47b57 ]]();
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd1932d2e, Offset: 0xd7f8
    // Size: 0x48
    function zombie_devgui_chest_never_move() {
        level notify(#"devgui_chest_end_monitor");
        level endon(#"devgui_chest_end_monitor");
        for (;;) {
            level.chest_accessed = 0;
            wait 5;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xfe9a04b9, Offset: 0xd848
    // Size: 0x46
    function zombie_devgui_disable_kill_thread_toggle() {
        if (!(isdefined(level.disable_kill_thread) && level.disable_kill_thread)) {
            level.disable_kill_thread = 1;
            return;
        }
        level.disable_kill_thread = 0;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x782e2f1b, Offset: 0xd898
    // Size: 0x46
    function zombie_devgui_check_kill_thread_every_frame_toggle() {
        if (!(isdefined(level.check_kill_thread_every_frame) && level.check_kill_thread_every_frame)) {
            level.check_kill_thread_every_frame = 1;
            return;
        }
        level.check_kill_thread_every_frame = 0;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x1310c4d7, Offset: 0xd8e8
    // Size: 0x46
    function zombie_devgui_kill_thread_test_mode_toggle() {
        if (!(isdefined(level.kill_thread_test_mode) && level.kill_thread_test_mode)) {
            level.kill_thread_test_mode = 1;
            return;
        }
        level.kill_thread_test_mode = 0;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 5, eflags: 0x0
    // Checksum 0x7fe7e030, Offset: 0xd938
    // Size: 0x50e
    function showonespawnpoint(spawn_point, color, notification, height, print) {
        if (!isdefined(height) || height <= 0) {
            height = util::get_player_height();
        }
        if (!isdefined(print)) {
            print = spawn_point.classname;
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
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(b, c, color, 0, notification);
        thread lineuntilnotified(c, d, color, 0, notification);
        thread lineuntilnotified(d, a, color, 0, notification);
        thread lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
        a += (0, 0, height);
        b += (0, 0, height);
        c += (0, 0, height);
        d += (0, 0, height);
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(b, c, color, 0, notification);
        thread lineuntilnotified(c, d, color, 0, notification);
        thread lineuntilnotified(d, a, color, 0, notification);
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
        thread lineuntilnotified(center, a, color, 0, notification);
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(a, c, color, 0, notification);
        thread print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
        return;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 6, eflags: 0x0
    // Checksum 0x1a624d65, Offset: 0xde50
    // Size: 0x76
    function print3duntilnotified(origin, text, color, alpha, scale, notification) {
        level endon(notification);
        for (;;) {
            print3d(origin, text, color, alpha, scale);
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 5, eflags: 0x0
    // Checksum 0x2bfaba30, Offset: 0xded0
    // Size: 0x66
    function lineuntilnotified(start, end, color, depthtest, notification) {
        level endon(notification);
        for (;;) {
            line(start, end, color, depthtest);
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc85bc212, Offset: 0xdf40
    // Size: 0x2ec
    function devgui_debug_hud() {
        if (isdefined(self zm_loadout::get_player_lethal_grenade())) {
            self givemaxammo(self zm_loadout::get_player_lethal_grenade());
        }
        wpn_type = zm_placeable_mine::get_first_available();
        if (wpn_type != level.weaponnone) {
            self thread zm_placeable_mine::setup_for_player(wpn_type);
        }
        if (isdefined(level.zombiemode_devgui_cymbal_monkey_give)) {
            if (isdefined(self zm_loadout::get_player_tactical_grenade())) {
                self takeweapon(self zm_loadout::get_player_tactical_grenade());
            }
            self [[ level.zombiemode_devgui_cymbal_monkey_give ]]();
        } else if (isdefined(self zm_loadout::get_player_tactical_grenade())) {
            self givemaxammo(self zm_loadout::get_player_tactical_grenade());
        }
        if (isdefined(level.zombie_include_equipment) && !isdefined(self zm_equipment::get_player_equipment())) {
            equipment = getarraykeys(level.zombie_include_equipment);
            if (isdefined(equipment[0])) {
                self zombie_devgui_equipment_give(equipment[0]);
            }
        }
        for (i = 0; i < 10; i++) {
            zombie_devgui_give_powerup("<dev string:xb69>", 1, self.origin);
            wait 0.25;
        }
        zombie_devgui_give_powerup("<dev string:xb73>", 1, self.origin);
        wait 0.25;
        zombie_devgui_give_powerup("<dev string:xb7e>", 1, self.origin);
        wait 0.25;
        zombie_devgui_give_powerup("<dev string:xb8c>", 1, self.origin);
        wait 0.25;
        zombie_devgui_give_powerup("<dev string:xb96>", 1, self.origin);
        wait 0.25;
        zombie_devgui_give_powerup("<dev string:xb9e>", 1, self.origin);
        wait 0.25;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x86e7428, Offset: 0xe238
    // Size: 0x3e
    function zombie_devgui_draw_traversals() {
        if (!isdefined(level.toggle_draw_traversals)) {
            level.toggle_draw_traversals = 1;
            return;
        }
        level.toggle_draw_traversals = !level.toggle_draw_traversals;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x7f736b08, Offset: 0xe280
    // Size: 0x3e
    function zombie_devgui_keyline_always() {
        if (!isdefined(level.toggle_keyline_always)) {
            level.toggle_keyline_always = 1;
            return;
        }
        level.toggle_keyline_always = !level.toggle_keyline_always;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x2ab52761, Offset: 0xe2c8
    // Size: 0x94
    function function_6aa9552a() {
        if (level flag::get("<dev string:xbab>")) {
            level flag::clear("<dev string:xbab>");
            iprintln("<dev string:xbbf>");
            return;
        }
        level flag::set("<dev string:xbab>");
        iprintln("<dev string:xbd6>");
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd831670a, Offset: 0xe368
    // Size: 0x3e
    function function_13d8ea87() {
        if (!isdefined(level.var_c2a01768)) {
            level.var_c2a01768 = 1;
            return;
        }
        level.var_c2a01768 = !level.var_c2a01768;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x4fc68237, Offset: 0xe3b0
    // Size: 0x290
    function wait_for_zombie(crawler) {
        nodes = getallnodes();
        while (true) {
            ai = getactorarray();
            zombie = ai[0];
            if (isdefined(zombie)) {
                foreach (node in nodes) {
                    if (node.type == #"begin" || node.type == #"end" || node.type == #"bad node") {
                        if (isdefined(node.animscript)) {
                            zombie setblackboardattribute("<dev string:xbeb>", "<dev string:xbf3>");
                            zombie setblackboardattribute("<dev string:xbf9>", node.animscript);
                            table = "<dev string:xc09>";
                            if (isdefined(crawler) && crawler) {
                                table = "<dev string:xc19>";
                            }
                            if (isdefined(zombie.debug_traversal_ast)) {
                                table = zombie.debug_traversal_ast;
                            }
                            anim_results = zombie astsearch(table);
                            if (!isdefined(anim_results[#"animation"])) {
                                if (isdefined(crawler) && crawler) {
                                    node.bad_crawler_traverse = 1;
                                } else {
                                    node.bad_traverse = 1;
                                }
                                continue;
                            }
                            if (anim_results[#"animation"] == "<dev string:xc31>") {
                                teleport = 1;
                            }
                        }
                    }
                }
                break;
            }
            wait 0.25;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x956963e8, Offset: 0xe648
    // Size: 0x212
    function zombie_draw_traversals() {
        level thread wait_for_zombie();
        level thread wait_for_zombie(1);
        nodes = getallnodes();
        while (true) {
            if (isdefined(level.toggle_draw_traversals) && level.toggle_draw_traversals) {
                foreach (node in nodes) {
                    if (isdefined(node.animscript)) {
                        txt_color = (0, 0.8, 0.6);
                        circle_color = (1, 1, 1);
                        if (isdefined(node.bad_traverse) && node.bad_traverse) {
                            txt_color = (1, 0, 0);
                            circle_color = (1, 0, 0);
                        }
                        circle(node.origin, 16, circle_color);
                        print3d(node.origin, node.animscript, txt_color, 1, 0.5);
                        if (isdefined(node.bad_crawler_traverse) && node.bad_crawler_traverse) {
                            print3d(node.origin + (0, 0, -12), "<dev string:xc4a>", (1, 0, 0), 1, 0.5);
                        }
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd2b74904, Offset: 0xe868
    // Size: 0x1cc
    function function_364ed1b9() {
        nodes = getallnodes();
        var_242e809d = [];
        foreach (node in nodes) {
            if (isdefined(node.animscript) && node.animscript != "<dev string:x30>") {
                var_242e809d[node.animscript] = 1;
            }
        }
        var_d1e1ebcf = getarraykeys(var_242e809d);
        sortednames = array::sort_by_value(var_d1e1ebcf, 1);
        println("<dev string:xc62>");
        foreach (name in sortednames) {
            println("<dev string:xc7d>" + name);
        }
        println("<dev string:xc8a>");
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x1a783b67, Offset: 0xea40
    // Size: 0x1de
    function function_19959e80() {
        while (true) {
            if (isdefined(level.zones) && (getdvarint(#"zombiemode_debug_zones", 0) || getdvarint(#"hash_756b3f2accaa1678", 0))) {
                foreach (zone in level.zones) {
                    foreach (node in zone.nodes) {
                        node_region = getnoderegion(node);
                        var_d0eb264a = node.targetname;
                        if (isdefined(node_region)) {
                            var_d0eb264a = node_region + "<dev string:x44b>" + node.targetname;
                        }
                        print3d(node.origin + (0, 0, 12), var_d0eb264a, (0, 1, 0), 1, 1);
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xf6f6c2d2, Offset: 0xec28
    // Size: 0xde
    function function_37c2486e() {
        if (!isdefined(level.var_4822dd9)) {
            level.var_4822dd9 = 0;
        }
        foreach (player in level.players) {
            if (level.var_4822dd9) {
                player notify(#"hash_d592b5d81b7b3a7");
                continue;
            }
            player thread function_200006db();
        }
        level.var_4822dd9 = !level.var_4822dd9;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xda113d8c, Offset: 0xed10
    // Size: 0x3e
    function function_8203d089(notifyhash) {
        if (isdefined(self.var_e3d038c3)) {
            self.var_e3d038c3 destroy();
            self.var_e3d038c3 = undefined;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xcbe7cbbb, Offset: 0xed58
    // Size: 0x186
    function function_200006db() {
        self notify(#"hash_d592b5d81b7b3a7");
        self endoncallback(&function_8203d089, #"hash_d592b5d81b7b3a7", #"disconnect");
        while (true) {
            if (!isdefined(self.var_e3d038c3)) {
                self.var_e3d038c3 = newdebughudelem(self);
                self.var_e3d038c3.alignx = "<dev string:xca3>";
                self.var_e3d038c3.horzalign = "<dev string:xca3>";
                self.var_e3d038c3.aligny = "<dev string:xca8>";
                self.var_e3d038c3.vertalign = "<dev string:xcaf>";
                self.var_e3d038c3.color = (1, 1, 1);
                self.var_e3d038c3.alpha = 1;
            }
            debug_text = "<dev string:x30>";
            if (isdefined(self.cached_zone_volume)) {
                debug_text = "<dev string:xcb3>";
            } else if (isdefined(self.var_d87fc66f)) {
                debug_text = "<dev string:xce1>";
            }
            self.var_e3d038c3 settext(debug_text);
            self waittill(#"zone_change");
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x9a5bdede, Offset: 0xeee8
    // Size: 0x21e
    function function_1d21f4f() {
        while (true) {
            if (isdefined(level.var_c2a01768) && level.var_c2a01768) {
                if (!isdefined(level.var_ff15f442)) {
                    level.var_ff15f442 = newdebughudelem();
                    level.var_ff15f442.alignx = "<dev string:xca3>";
                    level.var_ff15f442.x = 2;
                    level.var_ff15f442.y = 160;
                    level.var_ff15f442.fontscale = 1.5;
                    level.var_ff15f442.color = (1, 1, 1);
                }
                zombie_count = zombie_utility::get_current_zombie_count();
                zombie_left = level.zombie_total;
                zombie_runners = 0;
                var_8cbe658b = zombie_utility::get_zombie_array();
                foreach (ai_zombie in var_8cbe658b) {
                    if (ai_zombie.zombie_move_speed == "<dev string:xd0b>") {
                        zombie_runners++;
                    }
                }
                level.var_ff15f442 settext("<dev string:xd0f>" + zombie_count + "<dev string:xd17>" + zombie_left + "<dev string:xd23>" + zombie_runners);
            } else if (isdefined(level.var_ff15f442)) {
                level.var_ff15f442 destroy();
            }
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x48643e57, Offset: 0xf110
    // Size: 0x24
    function testscriptruntimeerrorassert() {
        wait 1;
        assert(0);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x56ec94ea, Offset: 0xf140
    // Size: 0x44
    function testscriptruntimeerror2() {
        myundefined = "<dev string:xd2f>";
        if (myundefined == 1) {
            println("<dev string:xd34>");
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x7c8ef5b9, Offset: 0xf190
    // Size: 0x1c
    function testscriptruntimeerror1() {
        testscriptruntimeerror2();
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x437b5804, Offset: 0xf1b8
    // Size: 0xdc
    function testscriptruntimeerror() {
        wait 5;
        for (;;) {
            if (getdvarstring(#"scr_testscriptruntimeerror") != "<dev string:x31>") {
                break;
            }
            wait 1;
        }
        myerror = getdvarstring(#"scr_testscriptruntimeerror");
        setdvar(#"scr_testscriptruntimeerror", "<dev string:x31>");
        if (myerror == "<dev string:xd5a>") {
            testscriptruntimeerrorassert();
        } else {
            testscriptruntimeerror1();
        }
        thread testscriptruntimeerror();
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc49f2e18, Offset: 0xf2a0
    // Size: 0x27e
    function function_b61a1649() {
        barriers = struct::get_array("<dev string:xd61>", "<dev string:x9fd>");
        if (isdefined(level._additional_carpenter_nodes)) {
            barriers = arraycombine(barriers, level._additional_carpenter_nodes, 0, 0);
        }
        foreach (barrier in barriers) {
            if (isdefined(barrier.zbarrier)) {
                a_pieces = barrier.zbarrier getzbarrierpieceindicesinstate("<dev string:xd6f>");
                if (isdefined(a_pieces)) {
                    for (xx = 0; xx < a_pieces.size; xx++) {
                        chunk = a_pieces[xx];
                        barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
                        barrier.zbarrier.chunk_health[chunk] = 0;
                    }
                }
                for (x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++) {
                    barrier.zbarrier setzbarrierpiecestate(x, "<dev string:xd6f>");
                    barrier.zbarrier showzbarrierpiece(x);
                }
            }
            if (isdefined(barrier.clip)) {
                barrier.clip triggerenable(1);
                barrier.clip disconnectpaths();
            } else {
                zm_blockers::blocker_connect_paths(barrier.neg_start, barrier.neg_end);
            }
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x884eb027, Offset: 0xf528
    // Size: 0x8c
    function function_2fcc56bd() {
        var_9857308b = getdvarint(#"hash_1e8ebf0a767981dd", 0);
        return array(array(var_9857308b / 2, 30), array(var_9857308b - 1, 20));
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x19d5596c, Offset: 0xf5c0
    // Size: 0x264
    function function_1acc8e35() {
        self endon(#"hash_63ae1cb168b8e0d7");
        setdvar(#"cg_drawscriptusage", 1);
        var_9857308b = getdvarint(#"hash_1e8ebf0a767981dd", 0);
        timescale = getdvarint(#"hash_7438b7c847f3c0", 0);
        var_da0f3f6 = function_2fcc56bd();
        setdvar(#"runtime_time_scale", timescale);
        while (level.round_number < var_9857308b) {
            foreach (round_info in var_da0f3f6) {
                if (level.round_number < round_info[0]) {
                    wait round_info[1];
                    break;
                }
            }
            ai_enemies = getaiteamarray(#"axis");
            foreach (ai in ai_enemies) {
                ai kill();
            }
            adddebugcommand("<dev string:xd74>");
            wait 0.2;
        }
        setdvar(#"runtime_time_scale", 1);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6aac9c9a, Offset: 0xf830
    // Size: 0x44
    function function_eec2d58b() {
        self notify(#"hash_63ae1cb168b8e0d7");
        setdvar(#"runtime_time_scale", 1);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x67d6dd61, Offset: 0xf880
    // Size: 0x78
    function function_37d3628f() {
        level.var_83515f37 = !(isdefined(self.var_83515f37) && self.var_83515f37);
        if (isdefined(level.var_83515f37) && level.var_83515f37) {
            level thread function_105eef40();
            return;
        }
        level notify(#"hash_2876f101dd7375df");
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x43afc6fd, Offset: 0xf900
    // Size: 0x232
    function function_105eef40() {
        level endon(#"hash_2876f101dd7375df");
        while (true) {
            zombies = [];
            foreach (archetype in level.var_96b05454) {
                ai = getaiarchetypearray(archetype, level.zombie_team);
                if (ai.size) {
                    zombies = arraycombine(zombies, ai, 0, 0);
                }
            }
            foreach (zombie in zombies) {
                if (isdefined(zombie.need_closest_player) && zombie.need_closest_player) {
                    record3dtext("<dev string:xd8d>", zombie.origin + (0, 0, 72), (1, 0, 0));
                    continue;
                }
                record3dtext("<dev string:xda1>", zombie.origin + (0, 0, 72), (0, 1, 0));
                if (isdefined(zombie.var_bdbf35e5)) {
                    record3dtext(gettime() - zombie.var_bdbf35e5, zombie.origin + (0, 0, 54), (1, 1, 1));
                }
            }
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xdf0f7b14, Offset: 0xfb40
    // Size: 0x84
    function function_b9a4c7a() {
        adddebugcommand("<dev string:xdb5>");
        adddebugcommand("<dev string:xe04>");
        adddebugcommand("<dev string:xe4a>");
        adddebugcommand("<dev string:xe94>");
        level thread function_a08dc5ef();
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x61febb6b, Offset: 0xfbd0
    // Size: 0x298
    function function_a08dc5ef() {
        for (;;) {
            wait 0.25;
            cmd = getdvarint(#"hash_5b8785c3d6383b3a", 0);
            if (isdefined(cmd) && cmd == 1) {
                iprintlnbold("<dev string:xeda>");
                zm::function_9f624ae8();
                setdvar(#"hash_5b8785c3d6383b3a", 0);
            }
            cmd = getdvarstring(#"hash_2d9d21912cbffb75");
            if (isdefined(cmd) && cmd == 1) {
                iprintlnbold("<dev string:xef2>");
                level.gamedifficulty = 0;
                setdvar(#"hash_2d9d21912cbffb75", 0);
                setdvar(#"hash_5b8785c3d6383b3a", 1);
            }
            cmd = getdvarstring(#"hash_2b205a3ab882058c");
            if (isdefined(cmd) && cmd == 1) {
                iprintlnbold("<dev string:xef7>");
                level.gamedifficulty = 1;
                setdvar(#"hash_2b205a3ab882058c", 0);
                setdvar(#"hash_5b8785c3d6383b3a", 1);
            }
            cmd = getdvarstring(#"hash_393960bacf784966");
            if (isdefined(cmd) && cmd == 1) {
                iprintlnbold("<dev string:xefe>");
                level.gamedifficulty = 2;
                setdvar(#"hash_393960bacf784966", 0);
                setdvar(#"hash_5b8785c3d6383b3a", 1);
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x4
    // Checksum 0xc88d21a3, Offset: 0xfe70
    // Size: 0xae
    function private function_c409b190() {
        player = getplayers()[0];
        queryresult = positionquery_source_navigation(player.origin, 256, 512, 128, 20);
        if (isdefined(queryresult) && queryresult.data.size > 0) {
            return queryresult.data[0];
        }
        return {#origin:player.origin};
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x3002e3e6, Offset: 0xff28
    // Size: 0x116
    function private function_28604383() {
        player = getplayers()[0];
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, player);
        return {#origin:trace[#"position"]};
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x2a27d3a1, Offset: 0x10048
    // Size: 0xdc
    function spawn_archetype(spawner_name) {
        spawners = getspawnerarray(spawner_name, "<dev string:xa28>");
        spawn_point = function_28604383();
        if (spawners.size == 0) {
            iprintln("<dev string:xf03>" + spawner_name + "<dev string:xf07>");
            return;
        }
        entity = spawners[0] spawnfromspawner(0, 1);
        if (isdefined(entity)) {
            entity forceteleport(spawn_point.origin);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x64e32452, Offset: 0x10130
    // Size: 0xb8
    function kill_archetype(archetype) {
        enemies = getaiarchetypearray(archetype);
        foreach (enemy in enemies) {
            if (isalive(enemy)) {
                enemy kill();
            }
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc1d176ae, Offset: 0x101f0
    // Size: 0x244
    function function_491277d6() {
        level.devcheater = 1;
        if (!self laststand::player_is_in_laststand()) {
            self zm_perks::function_be078e24(4);
            var_55af42b6 = array::randomize(array(#"ar_accurate_t8", #"ar_fastfire_t8", #"ar_stealth_t8", #"ar_modular_t8", #"smg_capacity_t8", #"tr_powersemi_t8"));
            foreach (w_primary in self getweaponslistprimaries()) {
                self takeweapon(w_primary);
            }
            for (i = 0; i < zm_utility::get_player_weapon_limit(self); i++) {
                weapon = getweapon(var_55af42b6[i]);
                weapon = get_upgrade(weapon.rootweapon);
                weapon = self zm_weapons::give_build_kit_weapon(weapon);
                if (isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weapon)) {
                    self thread aat::acquire(weapon);
                }
            }
            self switchtoweapon(weapon);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6c655bbc, Offset: 0x10440
    // Size: 0x5a
    function function_53733668() {
        /#
            if (!isdefined(level.var_429bf677)) {
                level.var_429bf677 = 0;
            }
        #/
        if (!isdefined(level.var_429bf677)) {
            level.var_429bf677 = 1;
        }
        level.var_429bf677 = !level.var_429bf677;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x975effbb, Offset: 0x104a8
    // Size: 0x86
    function function_bb3eec88() {
        if (isdefined(level.var_2f74f9c1) && level.var_2f74f9c1) {
            level notify(#"hash_147174071dbfe31e");
        } else {
            level thread function_2d7b7db5();
        }
        level.var_2f74f9c1 = !(isdefined(level.var_2f74f9c1) && level.var_2f74f9c1);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xcb519a4f, Offset: 0x10538
    // Size: 0x286
    function function_2d7b7db5() {
        self notify("<invalid>");
        self endon("<invalid>");
        level endon(#"hash_147174071dbfe31e");
        while (true) {
            teststring = "<dev string:x30>";
            foreach (player in level.players) {
                teststring += "<dev string:xf1d>" + player getentitynumber() + "<dev string:xf27>";
                if (player.sessionstate == "<dev string:xb58>") {
                    teststring += "<dev string:xf2a>";
                    continue;
                }
                if (isdefined(level.var_c303b23b) && level.var_c303b23b) {
                    teststring += "<dev string:xf3d>";
                    continue;
                }
                if (player zm_player::in_life_brush()) {
                    teststring += "<dev string:xf59>";
                    continue;
                }
                if (player zm_player::in_kill_brush()) {
                    teststring += "<dev string:xf6b>";
                    continue;
                }
                if (!player zm_player::in_enabled_playable_area()) {
                    teststring += "<dev string:xf7d>";
                    continue;
                }
                if (isdefined(level.player_out_of_playable_area_override) && !(isdefined(player [[ level.player_out_of_playable_area_override ]]()) && player [[ level.player_out_of_playable_area_override ]]())) {
                    teststring += "<dev string:xfae>";
                    continue;
                }
                teststring += "<dev string:xfe4>";
            }
            debug2dtext((400, 100, 0), teststring, (1, 1, 0), undefined, (0, 0, 0), 0.75, 1, 1);
            waitframe(1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x92f95aa5, Offset: 0x107c8
    // Size: 0x32
    function function_13a027d8() {
        level.var_72a0f44 = !(isdefined(level.var_72a0f44) && level.var_72a0f44);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc1bca99a, Offset: 0x10808
    // Size: 0xa8
    function function_791ff6b0() {
        zombies = getaiarray();
        foreach (zombie in zombies) {
            zombie zombie_utility::setup_zombie_knockdown(level.players[0]);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd20fedae, Offset: 0x108b8
    // Size: 0x1b8
    function init_debug_center_screen() {
        waitframe(1);
        setdvar(#"debug_center_screen", 0);
        level flag::wait_till("<dev string:x36>");
        zero_idle_movement = 0;
        devgui_base = "<dev string:xfff>";
        adddebugcommand(devgui_base + "<dev string:x1013>" + "<dev string:x1040>" + "<dev string:x1054>");
        for (;;) {
            if (getdvarint(#"debug_center_screen", 0)) {
                if (!isdefined(level.center_screen_debug_hudelem_active) || level.center_screen_debug_hudelem_active == 0) {
                    thread debug_center_screen();
                    zero_idle_movement = getdvarint(#"zero_idle_movement", 0);
                    if (zero_idle_movement == 0) {
                        setdvar(#"zero_idle_movement", 1);
                        zero_idle_movement = 1;
                    }
                }
            } else {
                level notify(#"stop center screen debug");
                if (zero_idle_movement == 1) {
                    setdvar(#"zero_idle_movement", 0);
                    zero_idle_movement = 0;
                }
            }
            wait 0.5;
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x51b8e7a, Offset: 0x10a78
    // Size: 0x24a
    function debug_center_screen() {
        level.center_screen_debug_hudelem_active = 1;
        wait 0.1;
        level.center_screen_debug_hudelem1 = newdebughudelem(level.players[0]);
        level.center_screen_debug_hudelem1.alignx = "<dev string:x105c>";
        level.center_screen_debug_hudelem1.aligny = "<dev string:xca8>";
        level.center_screen_debug_hudelem1.fontscale = 1;
        level.center_screen_debug_hudelem1.alpha = 0.5;
        level.center_screen_debug_hudelem1.x = 320 - 1;
        level.center_screen_debug_hudelem1.y = 240;
        level.center_screen_debug_hudelem1 setshader("<dev string:x1063>", 1000, 1);
        level.center_screen_debug_hudelem2 = newdebughudelem(level.players[0]);
        level.center_screen_debug_hudelem2.alignx = "<dev string:x105c>";
        level.center_screen_debug_hudelem2.aligny = "<dev string:xca8>";
        level.center_screen_debug_hudelem2.fontscale = 1;
        level.center_screen_debug_hudelem2.alpha = 0.5;
        level.center_screen_debug_hudelem2.x = 320 - 1;
        level.center_screen_debug_hudelem2.y = 240;
        level.center_screen_debug_hudelem2 setshader("<dev string:x1063>", 1, 480);
        level waittill(#"stop center screen debug");
        level.center_screen_debug_hudelem1 destroy();
        level.center_screen_debug_hudelem2 destroy();
        level.center_screen_debug_hudelem_active = 0;
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x24f6c29c, Offset: 0x10cd0
    // Size: 0x270
    function function_7e1c8660() {
        self notify("<invalid>");
        self endon("<invalid>");
        function_1ca7946();
        setdvar(#"hash_46eec505e691414c", "<dev string:x30>");
        setdvar(#"hash_74f1952a0f93d08e", -1);
        while (true) {
            wait 0.1;
            var_eb9f930d = getdvar(#"hash_46eec505e691414c", "<dev string:x30>");
            var_619314e = getdvar(#"hash_74f1952a0f93d08e", -1);
            if (var_eb9f930d == "<dev string:x30>" && var_619314e == -1) {
                continue;
            }
            player = level.players[0];
            if (isplayer(player)) {
                if (var_eb9f930d != "<dev string:x30>") {
                    args = strtok(var_eb9f930d, "<dev string:x107a>");
                    level zm_ui_inventory::function_31a39683(args[0], int(args[1]), player);
                }
                if (var_619314e != -1) {
                    if (var_619314e > 0) {
                        player zm_ui_inventory::function_794e8679(#"hash_336cbe1bb6ff213");
                    } else {
                        player zm_ui_inventory::function_794e8679(#"");
                    }
                }
            }
            setdvar(#"hash_46eec505e691414c", "<dev string:x30>");
            setdvar(#"hash_74f1952a0f93d08e", -1);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x15a7af86, Offset: 0x10f48
    // Size: 0x21c
    function function_1ca7946() {
        while (!isdefined(level.var_c67b847b)) {
            wait 0.1;
        }
        path = "<dev string:x107c>";
        cmd = "<dev string:x108a>";
        keys = getarraykeys(level.var_c67b847b);
        foreach (key in keys) {
            mapping = level.var_c67b847b[key];
            num = pow(2, mapping.numbits);
            for (i = 0; i < num; i++) {
                cmdarg = function_15979fa9(key) + "<dev string:x107a>" + i;
                util::add_devgui(path + function_15979fa9(key) + "<dev string:x10ac>" + i, cmd + cmdarg);
            }
        }
        var_b925877a = "<dev string:x10b5>";
        cmd = "<dev string:x10d7>";
        util::add_devgui(var_b925877a + "<dev string:x10f9>", cmd + 1);
        util::add_devgui(var_b925877a + "<dev string:x110d>", cmd + 0);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x9299d691, Offset: 0x11170
    // Size: 0x8c
    function function_c71fc328() {
        if (!isdefined(level.var_10867251)) {
            level.var_10867251 = 0;
        }
        level.var_10867251 = !level.var_10867251;
        if (level.var_10867251) {
            callback::on_ai_damage(&function_5721082e);
            return;
        }
        callback::remove_on_ai_damage(&function_5721082e);
    }

    // Namespace zm_devgui/zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xa697a8d4, Offset: 0x11208
    // Size: 0x10c
    function function_5721082e(params) {
        damage = params.idamage;
        location = params.vpoint;
        target = self;
        smeansofdeath = params.smeansofdeath;
        if (smeansofdeath == "<dev string:x1122>" || smeansofdeath == "<dev string:x112e>") {
            location = self.origin + (0, 0, 60);
        }
        if (damage) {
            thread function_668acbda("<dev string:x107a>" + damage, (1, 1, 1), location, (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 2), 30);
        }
    }

    // Namespace zm_devgui/zm_devgui
    // Params 5, eflags: 0x0
    // Checksum 0x515f32a4, Offset: 0x11320
    // Size: 0xcc
    function function_668acbda(text, color, start, velocity, frames) {
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
