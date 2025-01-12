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
    // Params 0, eflags: 0x2
    // Checksum 0x653caf3f, Offset: 0xc0
    // Size: 0x3c
    function autoexec __init__system__() {
        system::register(#"rat", &__init__, undefined, undefined);
    }

    // Namespace rat/rat
    // Params 0, eflags: 0x0
    // Checksum 0xee429e2, Offset: 0x108
    // Size: 0x51c
    function __init__() {
        init();
        level.rat.common.gethostplayer = &util::gethostplayer;
        addratscriptcmd("<dev string:x30>", &derriesezombiespawnnavmeshtest);
        addratscriptcmd("<dev string:x44>", &function_8a98ff2f);
        addratscriptcmd("<dev string:x4d>", &function_6367c38b);
        addratscriptcmd("<dev string:x57>", &function_19b64bc5);
        addratscriptcmd("<dev string:x61>", &function_43088ede);
        addratscriptcmd("<dev string:x75>", &function_aae330b6);
        addratscriptcmd("<dev string:x88>", &function_52879387);
        addratscriptcmd("<dev string:x96>", &function_77bbd871);
        addratscriptcmd("<dev string:xa7>", &function_14d1939a);
        addratscriptcmd("<dev string:xbc>", &function_91f36fba);
        addratscriptcmd("<dev string:xcf>", &function_eb4d988d);
        addratscriptcmd("<dev string:xe4>", &function_595ee812);
        addratscriptcmd("<dev string:xf7>", &function_6e2fd298);
        addratscriptcmd("<dev string:x108>", &function_2ea188f1);
        addratscriptcmd("<dev string:x11f>", &function_c0d12b79);
        addratscriptcmd("<dev string:x134>", &function_33767cf0);
        addratscriptcmd("<dev string:x13f>", &function_c00814);
        addratscriptcmd("<dev string:x151>", &function_2e3a2a85);
        addratscriptcmd("<dev string:x163>", &function_e9239e10);
        addratscriptcmd("<dev string:x179>", &function_29675f42);
        addratscriptcmd("<dev string:x188>", &function_11ca5fd7);
        addratscriptcmd("<dev string:x19b>", &function_b7c170a0);
        addratscriptcmd("<dev string:x1ae>", &function_e7713cd);
        addratscriptcmd("<dev string:x1ca>", &function_8cd5c735);
        addratscriptcmd("<dev string:x1e3>", &function_a6b1cf6f);
        addratscriptcmd("<dev string:x1fe>", &function_a506ef55);
        addratscriptcmd("<dev string:x217>", &function_97a3f6a7);
        addratscriptcmd("<dev string:x226>", &function_4507f5b3);
        addratscriptcmd("<dev string:x23b>", &function_a2d55e7c);
        addratscriptcmd("<dev string:x253>", &function_39cca343);
        addratscriptcmd("<dev string:x26d>", &function_7841df2c);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x6a4728e2, Offset: 0x630
    // Size: 0x24
    function function_7841df2c(params) {
        return zm_trial::function_2a447e6c();
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x213223cf, Offset: 0x660
    // Size: 0x1a8
    function function_39cca343(params) {
        zombies = getaiarchetypearray("<dev string:x27e>", level.zombie_team);
        player = getplayer(params);
        forward = anglestoforward(player.angles);
        distance = 25;
        if (isdefined(params.distance)) {
            distance = float(params.distance);
        }
        spawn = player.origin + forward * distance;
        foreach (zombie in zombies) {
            zombie forceteleport(spawn, player.angles);
            if (isdefined(params.is_dummy) && params.is_dummy == 1) {
                zombie pathmode("<dev string:x285>");
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x2425924d, Offset: 0x810
    // Size: 0x3c
    function function_a2d55e7c(params) {
        zombie_utility::set_zombie_var(#"rebuild_barrier_cap_per_round", 2147483647);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x8a4845d, Offset: 0x858
    // Size: 0xf8
    function function_4507f5b3(params) {
        windows = level.exterior_goals;
        if (isdefined(windows)) {
            foreach (window in windows) {
                origin = window.origin;
                function_dd184abd(params._id, origin);
                angles = window.angles;
                function_dd184abd(params._id, angles);
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x64cfdf5f, Offset: 0x958
    // Size: 0x13c
    function function_e9239e10(params) {
        chests = level.chests;
        if (isdefined(chests)) {
            foreach (chest in chests) {
                if (chest.hidden == 0) {
                    origin = chest.origin;
                    function_dd184abd(params._id, origin);
                    angles = (chest.angles[0], chest.angles[1] - 90, chest.angles[2]);
                    function_dd184abd(params._id, angles);
                    break;
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x64bba2b8, Offset: 0xaa0
    // Size: 0x166
    function function_a506ef55(params) {
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            triggerstub = level._unitriggers.trigger_stubs[i];
            if (isdefined(triggerstub.script_noteworthy)) {
                if (triggerstub.script_noteworthy == "<dev string:x28f>" || triggerstub.script_noteworthy == "<dev string:x298>") {
                    origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
                    function_dd184abd(params._id, origin);
                    angles = (triggerstub.angles[0], triggerstub.angles[1], triggerstub.angles[2]);
                    function_dd184abd(params._id, angles);
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x9aa84474, Offset: 0xc10
    // Size: 0x3e
    function function_97a3f6a7(params) {
        host = util::gethostplayer();
        return isdefined(host.var_d7be0f57);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x51d7da53, Offset: 0xc58
    // Size: 0x1d4
    function function_11ca5fd7(params) {
        foreach (items in level.item_spawns) {
            foreach (item in items) {
                if (isdefined(item)) {
                    offset = (item.origin[0], item.origin[1], item.origin[2]);
                    function_dd184abd(params._id, offset);
                    forward = item.origin - offset;
                    angle = vectornormalize(forward);
                    angles = (item.angles[0], item.angles[1], item.angles[2]);
                    function_dd184abd(params._id, angles);
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xc362c6db, Offset: 0xe38
    // Size: 0x14e
    function function_e7713cd(params) {
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            triggerstub = level._unitriggers.trigger_stubs[i];
            if (isdefined(triggerstub.target)) {
                if (triggerstub.target == "<dev string:x2a1>") {
                    origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
                    function_dd184abd(params._id, origin);
                    angles = (triggerstub.angles[0], triggerstub.angles[1] + 180, triggerstub.angles[2]);
                    function_dd184abd(params._id, angles);
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xf3c03951, Offset: 0xf90
    // Size: 0x14e
    function function_8cd5c735(params) {
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            triggerstub = level._unitriggers.trigger_stubs[i];
            if (isdefined(triggerstub.target)) {
                if (triggerstub.target == "<dev string:x2ae>") {
                    origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
                    function_dd184abd(params._id, origin);
                    angles = (triggerstub.angles[0], triggerstub.angles[1] + 180, triggerstub.angles[2]);
                    function_dd184abd(params._id, angles);
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x3bad5e0d, Offset: 0x10e8
    // Size: 0x32
    function function_b7c170a0(params) {
        if (isdefined(level.item_inventory)) {
            return level.item_inventory.size;
        }
        return 0;
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x43ac3ac7, Offset: 0x1128
    // Size: 0x160
    function function_29675f42(params) {
        chunks = level.s_pap_quest.a_s_locations;
        if (isdefined(chunks)) {
            foreach (chunk in chunks) {
                origin = (chunk.origin[0], chunk.origin[1] - 40, chunk.origin[2] - 40);
                function_dd184abd(params._id, origin);
                angles = (chunk.angles[0], chunk.angles[1] + 180, chunk.angles[2]);
                function_dd184abd(params._id, angles);
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x88cfb948, Offset: 0x1290
    // Size: 0x24
    function function_a6b1cf6f(params) {
        return level.s_pap_quest.var_966c6a3f;
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xfd311629, Offset: 0x12c0
    // Size: 0x11a
    function function_2e3a2a85(params) {
        host = util::gethostplayer();
        skip = 0;
        if (isdefined(params.var_8d69353)) {
            if (params.var_8d69353 == "<dev string:x2b8>") {
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
    // Checksum 0x605d7386, Offset: 0x13e8
    // Size: 0x74
    function function_33767cf0(params) {
        if (isdefined(params.round)) {
            setdvar(#"scr_zombie_round", int(params.round));
            adddebugcommand("<dev string:x2bd>");
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x14ee3952, Offset: 0x1468
    // Size: 0x7c
    function function_c00814(params) {
        num = 3;
        if (isdefined(params.num)) {
            num = int(params.num);
        }
        if (num > 0) {
            adddebugcommand("<dev string:x2d1>" + num);
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x2c9a372d, Offset: 0x14f0
    // Size: 0x10
    function function_c0d12b79(params) {
        
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x623538e7, Offset: 0x1508
    // Size: 0x1f0
    function function_2ea188f1(params) {
        trigs = getentarray("<dev string:x2ee>", "<dev string:x2fe>");
        foreach (ent in trigs) {
            ent_parts = getentarray(ent.target, "<dev string:x2fe>");
            foreach (e in ent_parts) {
                if (isdefined(e.script_noteworthy) && e.script_noteworthy == "<dev string:x309>") {
                    master_switch = e;
                    function_dd184abd(params._id, master_switch.origin);
                    angles = (master_switch.angles[0], master_switch.angles[1], master_switch.angles[2]);
                    function_dd184abd(params._id, angles);
                    break;
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x2d9c5748, Offset: 0x1700
    // Size: 0x54
    function function_6e2fd298(params) {
        player = util::gethostplayer();
        if (isdefined(player)) {
            if (isdefined(player.perk_purchased)) {
                return player.perk_purchased;
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xa1d1ac9c, Offset: 0x1760
    // Size: 0x9e
    function function_eb4d988d(params) {
        zombie_doors = getentarray("<dev string:x317>", "<dev string:x2fe>");
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
    // Checksum 0x2d4c62f3, Offset: 0x1808
    // Size: 0x146
    function function_595ee812(params) {
        zombie_doors = getentarray("<dev string:x317>", "<dev string:x2fe>");
        if (isdefined(zombie_doors)) {
            for (i = 0; i < zombie_doors.size; i++) {
                door = zombie_doors[i];
                if (isdefined(door.script_noteworthy)) {
                    if (door.script_noteworthy == "<dev string:x323>" && door._door_open == 0) {
                        function_dd184abd(params._id, door.origin);
                        angles = (door.angles[0], door.angles[1] + 90, door.angles[2]);
                        function_dd184abd(params._id, angles);
                    }
                }
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xed4231c2, Offset: 0x1958
    // Size: 0x146
    function function_14d1939a(params) {
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            triggerstub = level._unitriggers.trigger_stubs[i];
            if (triggerstub.cursor_hint == "<dev string:x32b>") {
                origin = triggerstub zm_unitrigger::unitrigger_origin();
                origin = (origin[0], origin[1], origin[2] - 40);
                function_dd184abd(params._id, origin);
                angles = triggerstub.angles;
                angles = (angles[0], angles[1] - 90, angles[2]);
                function_dd184abd(params._id, angles);
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xbb77f0b0, Offset: 0x1aa8
    // Size: 0x12e
    function function_91f36fba(params) {
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            triggerstub = level._unitriggers.trigger_stubs[i];
            if (isdefined(triggerstub.hint_string) && triggerstub.hint_string == "<dev string:x337>") {
                origin = triggerstub zm_unitrigger::unitrigger_origin();
                function_dd184abd(params._id, origin);
                angles = triggerstub.angles;
                angles = (angles[0], angles[1] + 180, angles[2]);
                function_dd184abd(params._id, angles);
            }
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x1f6572a0, Offset: 0x1be0
    // Size: 0xe0
    function function_77bbd871(params) {
        a_e_players = getplayers();
        foreach (e_player in a_e_players) {
            if (isdefined(e_player.intermission) || e_player.sessionstate == "<dev string:x347>" || e_player.sessionstate == "<dev string:x351>") {
                continue;
            }
            return 1;
        }
        return 0;
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x38610b4f, Offset: 0x1cc8
    // Size: 0x34
    function function_6367c38b(params) {
        setdvar(#"zombie_cheat", 2);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x8667c6b1, Offset: 0x1d08
    // Size: 0x34
    function function_52879387(params) {
        setdvar(#"zombie_cheat", 0);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x32c1eea3, Offset: 0x1d48
    // Size: 0xfc
    function function_43088ede(params) {
        player = util::gethostplayer();
        forward = anglestoforward(player.angles);
        spawn = player.origin + forward * 10;
        zombie = zm_devgui::devgui_zombie_spawn();
        if (isdefined(zombie)) {
            zombie forceteleport(spawn, player.angles + (0, 180, 0));
            zombie pathmode("<dev string:x285>");
        }
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x4ece9df6, Offset: 0x1e50
    // Size: 0x24
    function function_aae330b6(params) {
        return zombie_utility::get_current_zombie_count();
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x3dcb6ab9, Offset: 0x1e80
    // Size: 0x3c
    function function_8a98ff2f(params) {
        player = util::gethostplayer();
        return player.score;
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x66dc2ca6, Offset: 0x1ec8
    // Size: 0x2e
    function function_19b64bc5(params) {
        if (isdefined(level.power_local_doors_globally)) {
            return 1;
        }
        return 0;
    }

    // Namespace rat/rat
    // Params 2, eflags: 0x0
    // Checksum 0x3674a668, Offset: 0x1f00
    // Size: 0x4bc
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
            errmsg = "<dev string:x35e>";
            for (i = 0; i < size; i++) {
                errmsg += "<dev string:x376>" + failed_spawn_origin[i] + "<dev string:x37f>" + failed_node_origin[i] + "<dev string:x388>";
            }
            for (i = 0; i < failed_attack_spot_size; i++) {
                errmsg += "<dev string:x376>" + failed_attack_spot_spawn_origin[i] + "<dev string:x38b>" + failed_attack_spot[i] + "<dev string:x388>";
            }
            if (size > 0 || failed_attack_spot_size > 0) {
                ratreportcommandresult(params._id, 0, errmsg);
                return;
            }
            ratreportcommandresult(params._id, 1);
        }
    }

#/
