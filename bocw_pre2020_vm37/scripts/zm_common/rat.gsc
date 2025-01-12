#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace rat;

/#

    // Namespace rat/rat
    // Params 0, eflags: 0x6
    // Checksum 0x6de931e1, Offset: 0xb8
    // Size: 0x3c
    function private autoexec __init__system__() {
        system::register(#"rat", &function_70a657d8, undefined, undefined, undefined);
    }

    // Namespace rat/rat
    // Params 0, eflags: 0x4
    // Checksum 0xfcd9a5c0, Offset: 0x100
    // Size: 0x544
    function private function_70a657d8() {
        init();
        level.rat.common.gethostplayer = &util::gethostplayer;
        addratscriptcmd("<dev string:x38>", &derriesezombiespawnnavmeshtest);
        addratscriptcmd("<dev string:x4f>", &function_b8181e0d);
        addratscriptcmd("<dev string:x5b>", &function_38d6a592);
        addratscriptcmd("<dev string:x68>", &function_ff8061ca);
        addratscriptcmd("<dev string:x75>", &function_1428d95e);
        addratscriptcmd("<dev string:x8c>", &function_63a39134);
        addratscriptcmd("<dev string:xa2>", &function_26a15f4d);
        addratscriptcmd("<dev string:xb3>", &function_3d37c034);
        addratscriptcmd("<dev string:xc7>", &function_7a11ca68);
        addratscriptcmd("<dev string:xdf>", &function_782c6850);
        addratscriptcmd("<dev string:xf5>", &function_125e2d8d);
        addratscriptcmd("<dev string:x10d>", &function_e7dffcf9);
        addratscriptcmd("<dev string:x123>", &function_c3aa7d01);
        addratscriptcmd("<dev string:x137>", &function_684f2efb);
        addratscriptcmd("<dev string:x151>", &function_123195b9);
        addratscriptcmd("<dev string:x169>", &function_c79c0501);
        addratscriptcmd("<dev string:x177>", &function_3bbff2c5);
        addratscriptcmd("<dev string:x18c>", &function_ea4b3f00);
        addratscriptcmd("<dev string:x1a1>", &function_8f340c78);
        addratscriptcmd("<dev string:x1ba>", &function_1bd3da0f);
        addratscriptcmd("<dev string:x1cc>", &function_6ea9a113);
        addratscriptcmd("<dev string:x1e2>", &function_e2143adf);
        addratscriptcmd("<dev string:x1f8>", &function_ff8f5737);
        addratscriptcmd("<dev string:x217>", &function_5b9ddfdb);
        addratscriptcmd("<dev string:x233>", &function_d49caa1a);
        addratscriptcmd("<dev string:x251>", &function_d52c7fc3);
        addratscriptcmd("<dev string:x26d>", &function_d87f9fe1);
        addratscriptcmd("<dev string:x27f>", &function_94ac25d9);
        addratscriptcmd("<dev string:x297>", &function_a6f7ea4a);
        addratscriptcmd("<dev string:x2b2>", &function_303319e9);
        addratscriptcmd("<dev string:x2cf>", &function_d71d4f64);
        addratscriptcmd("<dev string:x2e7>", &function_e1bdc812);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x5ec19cca, Offset: 0x650
    // Size: 0x24
    function function_e1bdc812(*params) {
        return zm_trial::function_ba9853db();
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x8ffee20b, Offset: 0x680
    // Size: 0x278
    function function_303319e9(params) {
        zombies = getaiarchetypearray("<dev string:x2fb>", level.zombie_team);
        player = getplayer(params);
        forward = anglestoforward(player.angles);
        distance = 31;
        if (isdefined(params.distance)) {
            distance = float(params.distance);
        }
        spawn = player.origin + forward * distance;
        foreach (zombie in zombies) {
            zombie forceteleport(spawn, player.angles);
            if (isdefined(params.is_dummy) && params.is_dummy == 1) {
                if (!isdefined(zombie.ignore_player)) {
                    zombie.ignore_player = [];
                } else if (!isarray(zombie.ignore_player)) {
                    zombie.ignore_player = array(zombie.ignore_player);
                }
                zombie.ignore_player[zombie.ignore_player.size] = player;
                zombie.var_67faa700 = 1;
                zombie.ignoremelee = 1;
                zombie.ignore_round_spawn_failsafe = 1;
                zombie pathmode("<dev string:x305>");
                zombie orientmode("<dev string:x312>", player.angles[1]);
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xc2c83400, Offset: 0x900
    // Size: 0xf0
    function function_d71d4f64(params) {
        zombies = getaiarchetypearray("<dev string:x2fb>", level.zombie_team);
        foreach (zombie in zombies) {
            function_55e20e75(params._id, zombie.origin);
            function_55e20e75(params._id, zombie.angles);
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xe59991d1, Offset: 0x9f8
    // Size: 0x3c
    function function_a6f7ea4a(*params) {
        zombie_utility::set_zombie_var(#"rebuild_barrier_cap_per_round", 2147483647);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x49ff258e, Offset: 0xa40
    // Size: 0xf8
    function function_94ac25d9(params) {
        windows = level.exterior_goals;
        if (isdefined(windows)) {
            foreach (window in windows) {
                origin = window.origin;
                function_55e20e75(params._id, origin);
                angles = window.angles;
                function_55e20e75(params._id, angles);
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x167dcfe2, Offset: 0xb40
    // Size: 0x13c
    function function_8f340c78(params) {
        chests = level.chests;
        if (isdefined(chests)) {
            foreach (chest in chests) {
                if (chest.hidden == 0) {
                    origin = chest.origin;
                    function_55e20e75(params._id, origin);
                    angles = (chest.angles[0], chest.angles[1] - 90, chest.angles[2]);
                    function_55e20e75(params._id, angles);
                    break;
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x4ed127e5, Offset: 0xc88
    // Size: 0x154
    function function_d52c7fc3(params) {
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            triggerstub = level._unitriggers.trigger_stubs[i];
            if (isdefined(triggerstub.script_noteworthy)) {
                if (triggerstub.script_noteworthy == "<dev string:x320>" || triggerstub.script_noteworthy == "<dev string:x32c>") {
                    origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
                    function_55e20e75(params._id, origin);
                    angles = (triggerstub.angles[0], triggerstub.angles[1], triggerstub.angles[2]);
                    function_55e20e75(params._id, angles);
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x864ad81c, Offset: 0xde8
    // Size: 0x3a
    function function_d87f9fe1(*params) {
        host = util::gethostplayer();
        return isdefined(host.var_4e90ce0c);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x6e8127d4, Offset: 0xe30
    // Size: 0x1dc
    function function_6ea9a113(params) {
        foreach (items in level.item_spawns) {
            foreach (item in items) {
                if (isdefined(item)) {
                    offset = (item.origin[0], item.origin[1], item.origin[2]);
                    function_55e20e75(params._id, offset);
                    forward = item.origin - offset;
                    angle = vectornormalize(forward);
                    angles = (item.angles[0], item.angles[1], item.angles[2]);
                    function_55e20e75(params._id, angles);
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x9bb85e48, Offset: 0x1018
    // Size: 0x144
    function function_ff8f5737(params) {
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            triggerstub = level._unitriggers.trigger_stubs[i];
            if (isdefined(triggerstub.target)) {
                if (triggerstub.target == "<dev string:x338>") {
                    origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
                    function_55e20e75(params._id, origin);
                    angles = (triggerstub.angles[0], triggerstub.angles[1] + 180, triggerstub.angles[2]);
                    function_55e20e75(params._id, angles);
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xf00253f3, Offset: 0x1168
    // Size: 0x144
    function function_5b9ddfdb(params) {
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            triggerstub = level._unitriggers.trigger_stubs[i];
            if (isdefined(triggerstub.target)) {
                if (triggerstub.target == "<dev string:x348>") {
                    origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
                    function_55e20e75(params._id, origin);
                    angles = (triggerstub.angles[0], triggerstub.angles[1] + 180, triggerstub.angles[2]);
                    function_55e20e75(params._id, angles);
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x59054900, Offset: 0x12b8
    // Size: 0x32
    function function_e2143adf(*params) {
        if (isdefined(level.item_inventory)) {
            return level.item_inventory.size;
        }
        return 0;
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xafd38084, Offset: 0x12f8
    // Size: 0x160
    function function_1bd3da0f(params) {
        chunks = level.s_pap_quest.a_s_locations;
        if (isdefined(chunks)) {
            foreach (chunk in chunks) {
                origin = (chunk.origin[0], chunk.origin[1] - 40, chunk.origin[2] - 40);
                function_55e20e75(params._id, origin);
                angles = (chunk.angles[0], chunk.angles[1] + 180, chunk.angles[2]);
                function_55e20e75(params._id, angles);
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x13cceceb, Offset: 0x1460
    // Size: 0x24
    function function_d49caa1a(*params) {
        return level.s_pap_quest.var_be6e6f65;
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xde990ddb, Offset: 0x1490
    // Size: 0x122
    function function_ea4b3f00(params) {
        host = util::gethostplayer();
        skip = 0;
        if (isdefined(params.var_f870f386)) {
            if (params.var_f870f386 == "<dev string:x355>") {
                skip = 1;
            }
        }
        players = getplayers();
        foreach (player in players) {
            if (skip) {
                if (player != host) {
                    player enableinvulnerability();
                }
                continue;
            }
            skip = 0;
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xfd0168b0, Offset: 0x15c0
    // Size: 0x74
    function function_c79c0501(params) {
        if (isdefined(params.round)) {
            setdvar(#"scr_zombie_round", int(params.round));
            adddebugcommand("<dev string:x35d>");
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xacdd2404, Offset: 0x1640
    // Size: 0x7c
    function function_3bbff2c5(params) {
        num = 3;
        if (isdefined(params.num)) {
            num = int(params.num);
        }
        if (num > 0) {
            adddebugcommand("<dev string:x374>" + num);
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x18b20703, Offset: 0x16c8
    // Size: 0x10
    function function_123195b9(*params) {
        
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x23d89311, Offset: 0x16e0
    // Size: 0x1f8
    function function_684f2efb(params) {
        trigs = getentarray("<dev string:x394>", "<dev string:x3a7>");
        foreach (ent in trigs) {
            ent_parts = getentarray(ent.target, "<dev string:x3a7>");
            foreach (e in ent_parts) {
                if (isdefined(e.script_noteworthy) && e.script_noteworthy == "<dev string:x3b5>") {
                    master_switch = e;
                    function_55e20e75(params._id, master_switch.origin);
                    angles = (master_switch.angles[0], master_switch.angles[1], master_switch.angles[2]);
                    function_55e20e75(params._id, angles);
                    break;
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xe1dd424, Offset: 0x18e0
    // Size: 0x50
    function function_c3aa7d01(*params) {
        player = util::gethostplayer();
        if (isdefined(player)) {
            if (isdefined(player.perk_purchased)) {
                return player.perk_purchased;
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x71912680, Offset: 0x1938
    // Size: 0x92
    function function_125e2d8d(*params) {
        zombie_doors = getentarray("<dev string:x3c6>", "<dev string:x3a7>");
        count = 0;
        if (isdefined(zombie_doors)) {
            for (i = 0; i < zombie_doors.size; i++) {
                if (isdefined(zombie_doors[i].purchaser)) {
                    count++;
                }
            }
        }
        return count;
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xcb796e7c, Offset: 0x19d8
    // Size: 0x134
    function function_e7dffcf9(params) {
        zombie_doors = getentarray("<dev string:x3c6>", "<dev string:x3a7>");
        if (isdefined(zombie_doors)) {
            for (i = 0; i < zombie_doors.size; i++) {
                door = zombie_doors[i];
                if (isdefined(door.script_noteworthy)) {
                    if (door.script_noteworthy == "<dev string:x3d5>" && door._door_open == 0) {
                        function_55e20e75(params._id, door.origin);
                        angles = (door.angles[0], door.angles[1] + 90, door.angles[2]);
                        function_55e20e75(params._id, angles);
                    }
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x8c6f278b, Offset: 0x1b18
    // Size: 0x134
    function function_7a11ca68(params) {
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            triggerstub = level._unitriggers.trigger_stubs[i];
            if (triggerstub.cursor_hint == "<dev string:x3e0>") {
                origin = triggerstub zm_unitrigger::unitrigger_origin();
                origin = (origin[0], origin[1], origin[2] - 40);
                function_55e20e75(params._id, origin);
                angles = triggerstub.angles;
                angles = (angles[0], angles[1] - 90, angles[2]);
                function_55e20e75(params._id, angles);
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x8df4988e, Offset: 0x1c58
    // Size: 0x124
    function function_782c6850(params) {
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            triggerstub = level._unitriggers.trigger_stubs[i];
            if (isdefined(triggerstub.hint_string) && triggerstub.hint_string == "<dev string:x3ef>") {
                origin = triggerstub zm_unitrigger::unitrigger_origin();
                function_55e20e75(params._id, origin);
                angles = triggerstub.angles;
                angles = (angles[0], angles[1] + 180, angles[2]);
                function_55e20e75(params._id, angles);
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x928fda85, Offset: 0x1d88
    // Size: 0xe8
    function function_3d37c034(*params) {
        a_e_players = getplayers();
        foreach (e_player in a_e_players) {
            if (isdefined(e_player.intermission) || e_player.sessionstate == "<dev string:x402>" || e_player.sessionstate == "<dev string:x40f>") {
                continue;
            }
            return 1;
        }
        return 0;
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x117439c5, Offset: 0x1e78
    // Size: 0x34
    function function_38d6a592(*params) {
        setdvar(#"zombie_cheat", 2);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x8dde90fa, Offset: 0x1eb8
    // Size: 0x34
    function function_26a15f4d(*params) {
        setdvar(#"zombie_cheat", 0);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xab6c21d5, Offset: 0x1ef8
    // Size: 0xec
    function function_1428d95e(*params) {
        player = util::gethostplayer();
        forward = anglestoforward(player.angles);
        spawn = player.origin + forward * 10;
        zombie = zm_devgui::devgui_zombie_spawn();
        if (isdefined(zombie)) {
            zombie forceteleport(spawn, player.angles + (0, 180, 0));
            zombie pathmode("<dev string:x305>");
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x6ecc90e, Offset: 0x1ff0
    // Size: 0x24
    function function_63a39134(*params) {
        return zombie_utility::get_current_zombie_count();
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x5fb42314, Offset: 0x2020
    // Size: 0x38
    function function_b8181e0d(*params) {
        player = util::gethostplayer();
        return player.score;
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x8b58d03a, Offset: 0x2060
    // Size: 0x2e
    function function_ff8061ca(*params) {
        if (isdefined(level.power_local_doors_globally)) {
            return 1;
        }
        return 0;
    }

    // Namespace rat/rat
    // Params 2, eflags: 0x0
    // Checksum 0xd88f777b, Offset: 0x2098
    // Size: 0x474
    function derriesezombiespawnnavmeshtest(params, inrat) {
        if (!isdefined(inrat)) {
            inrat = 1;
        }
        if (inrat) {
            wait 10;
        }
        enemy = zm_devgui::devgui_zombie_spawn();
        enemy.is_rat_test = 1;
        failed_spawn_origin = [];
        failed_node_origin = [];
        failed_attack_spot_spawn_origin = [];
        failed_attack_spot = [];
        size = 0;
        failed_attack_spot_size = 0;
        wait 0.2;
        foreach (zone in level.zones) {
            foreach (loc in zone.a_loc_types[#"zombie_location"]) {
                angles = (0, 0, 0);
                enemy forceteleport(loc.origin, angles);
                wait 0.2;
                node = undefined;
                for (j = 0; j < level.exterior_goals.size; j++) {
                    if (isdefined(level.exterior_goals[j].script_string) && level.exterior_goals[j].script_string == loc.script_string) {
                        node = level.exterior_goals[j];
                    }
                }
                if (isdefined(node)) {
                    ispath = enemy setgoal(node.origin);
                    if (!ispath) {
                        failed_spawn_origin[size] = loc.origin;
                        failed_node_origin[size] = node.origin;
                        size++;
                    }
                    wait 0.2;
                    for (j = 0; j < node.attack_spots.size; j++) {
                        isattackpath = enemy setgoal(node.attack_spots[j]);
                        if (!isattackpath) {
                            failed_attack_spot_spawn_origin[failed_attack_spot_size] = loc.origin;
                            failed_attack_spot[failed_attack_spot_size] = node.attack_spots[j];
                            failed_attack_spot_size++;
                        }
                        wait 0.2;
                    }
                }
            }
        }
        if (inrat) {
            errmsg = "<dev string:x41f>";
            for (i = 0; i < size; i++) {
                errmsg += "<dev string:x43a>" + failed_spawn_origin[i] + "<dev string:x446>" + failed_node_origin[i] + "<dev string:x452>";
            }
            for (i = 0; i < failed_attack_spot_size; i++) {
                errmsg += "<dev string:x43a>" + failed_attack_spot_spawn_origin[i] + "<dev string:x458>" + failed_attack_spot[i] + "<dev string:x452>";
            }
            if (size > 0 || failed_attack_spot_size > 0) {
                ratreportcommandresult(params._id, 0, errmsg);
                return;
            }
            ratreportcommandresult(params._id, 1);
        }
    }

#/
