#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace spawning;

/#

    // Namespace spawning/namespace_797605b0
    // Params 1, eflags: 0x0
    // Checksum 0x83f96dd9, Offset: 0xa8
    // Size: 0x20
    function function_a860c440(var_ef54e156) {
        level.var_c99a6ece = var_ef54e156;
    }

    // Namespace spawning/namespace_797605b0
    // Params 0, eflags: 0x0
    // Checksum 0xcb25c984, Offset: 0xd0
    // Size: 0x3c8
    function spawnpoint_debug() {
        a_spawnlists = getspawnlists();
        index = 0;
        foreach (s_list in a_spawnlists) {
            adddebugcommand("<dev string:x38>" + s_list + "<dev string:x66>" + index + "<dev string:x88>");
            index++;
        }
        adddebugcommand("<dev string:x38>" + "<dev string:x8d>" + "<dev string:x94>");
        adddebugcommand("<dev string:xba>");
        adddebugcommand("<dev string:x11c>");
        while (true) {
            spawnsystem_debug_command = getdvarstring(#"spawnsystem_debug_command");
            switch (spawnsystem_debug_command) {
            case #"next_best":
                selectedplayerindex = getdvarint(#"spawnsystem_debug_current_player", 0);
                foreach (player in level.players) {
                    if (player getentitynumber() == selectedplayerindex) {
                        selectedplayer = player;
                        break;
                    }
                }
                if (!isdefined(selectedplayer)) {
                    continue;
                }
                point_team = selectedplayer.pers[#"team"];
                influencer_team = selectedplayer.pers[#"team"];
                vis_team_mask = util::getotherteamsmask(selectedplayer.pers[#"team"]);
                nextbestspawnpoint = getbestspawnpoint(point_team, influencer_team, vis_team_mask, selectedplayer, 0);
                selectedplayer setorigin(nextbestspawnpoint[#"origin"]);
                selectedplayer setplayerangles(nextbestspawnpoint[#"angles"]);
                break;
            case #"refresh":
                level flag::set(#"spawnpoints_dirty");
                break;
            }
            setdvar(#"spawnsystem_debug_command", "<dev string:x175>");
            wait 0.5;
        }
    }

    // Namespace spawning/namespace_797605b0
    // Params 4, eflags: 0x0
    // Checksum 0xf11e68dc, Offset: 0x4a0
    // Size: 0x11c
    function function_df47057f(*team, label, var_2f64048d, spawnpoints) {
        if (!spawnpoints.size) {
            return;
        }
        var_2e980658 = spawnstruct();
        var_2e980658.name = label + var_2f64048d;
        var_2e980658.spawns = spawnpoints;
        if (!isdefined(level.var_94f4ca81.dataset)) {
            level.var_94f4ca81.dataset = [];
        } else if (!isarray(level.var_94f4ca81.dataset)) {
            level.var_94f4ca81.dataset = array(level.var_94f4ca81.dataset);
        }
        level.var_94f4ca81.dataset[level.var_94f4ca81.dataset.size] = var_2e980658;
    }

    // Namespace spawning/namespace_797605b0
    // Params 4, eflags: 0x0
    // Checksum 0xda03c285, Offset: 0x5c8
    // Size: 0x6c
    function function_25e7711a(list_type, team, label, var_2f64048d) {
        spawnpoints = function_82061144(list_type, team);
        function_df47057f(team, label, var_2f64048d, spawnpoints);
    }

    // Namespace spawning/namespace_797605b0
    // Params 0, eflags: 0x0
    // Checksum 0xc8345105, Offset: 0x640
    // Size: 0x8f6
    function function_48a6b85() {
        level endon(#"hash_47f3d9a9e91670d1");
        self endon(#"disconnect");
        dpad_left = 0;
        dpad_right = 0;
        dpad_up = 0;
        dpad_down = 0;
        if (!isdefined(level.var_94f4ca81)) {
            level.var_94f4ca81 = spawnstruct();
            level.var_94f4ca81.dataset = [];
            var_975467b9 = "<dev string:x179>";
            function_25e7711a("<dev string:x18d>", #"none", var_975467b9, "<dev string:x19c>");
            foreach (team, team_name in level.teams) {
                function_25e7711a("<dev string:x18d>", team, var_975467b9, team_name);
            }
            var_96a18257 = "<dev string:x1a4>";
            foreach (team, team_name in level.teams) {
                function_25e7711a("<dev string:x1b7>", team, var_96a18257, team_name);
            }
            if (isdefined(level.var_c99a6ece)) {
                [[ level.var_c99a6ece ]]();
            }
        }
        level.var_94f4ca81.var_89266507 = "<dev string:x1c6>";
        level.var_94f4ca81.var_1fde6598 = 0;
        level.var_94f4ca81.var_64799f7 = 0;
        var_f94a23 = 0;
        while (true) {
            self setactionslot(3, "<dev string:x175>");
            self setactionslot(4, "<dev string:x175>");
            if (!dpad_up && self buttonpressed("<dev string:x1ce>")) {
                level.var_94f4ca81.var_1fde6598++;
                if (level.var_94f4ca81.var_1fde6598 >= level.var_94f4ca81.dataset.size) {
                    level.var_94f4ca81.var_1fde6598 = 0;
                }
                level.var_94f4ca81.var_64799f7 = 0;
                dpad_up = 1;
                var_f94a23 = 1;
            } else if (!self buttonpressed("<dev string:x1ce>")) {
                dpad_up = 0;
            }
            if (!dpad_down && self buttonpressed("<dev string:x1d9>")) {
                level.var_94f4ca81.var_1fde6598--;
                if (level.var_94f4ca81.var_1fde6598 < 0) {
                    level.var_94f4ca81.var_1fde6598 = level.var_94f4ca81.dataset.size - 1;
                }
                level.var_94f4ca81.var_64799f7 = 0;
                var_f94a23 = 1;
                dpad_down = 1;
            } else if (!self buttonpressed("<dev string:x1d9>")) {
                dpad_down = 0;
            }
            if (!dpad_left && self buttonpressed("<dev string:x1e6>")) {
                while (true) {
                    level.var_94f4ca81.var_64799f7--;
                    if (level.var_94f4ca81.var_64799f7 < 0) {
                        level.var_94f4ca81.var_64799f7 = level.var_94f4ca81.dataset[level.var_94f4ca81.var_1fde6598].spawns.size - 1;
                    }
                    if (!is_true(level.var_94f4ca81.dataset[level.var_94f4ca81.var_1fde6598].spawns[level.var_94f4ca81.var_64799f7].ct)) {
                        break;
                    }
                }
                var_f94a23 = 1;
                dpad_left = 1;
            } else if (!self buttonpressed("<dev string:x1e6>")) {
                dpad_left = 0;
            }
            if (!dpad_right && self buttonpressed("<dev string:x1f3>")) {
                while (true) {
                    level.var_94f4ca81.var_64799f7++;
                    if (level.var_94f4ca81.var_64799f7 >= level.var_94f4ca81.dataset[level.var_94f4ca81.var_1fde6598].spawns.size) {
                        level.var_94f4ca81.var_64799f7 = 0;
                    }
                    if (!is_true(level.var_94f4ca81.dataset[level.var_94f4ca81.var_1fde6598].spawns[level.var_94f4ca81.var_64799f7].ct)) {
                        break;
                    }
                }
                var_f94a23 = 1;
                dpad_right = 1;
            } else if (!self buttonpressed("<dev string:x1f3>")) {
                dpad_right = 0;
            }
            if (var_f94a23 && level.var_94f4ca81.dataset[level.var_94f4ca81.var_1fde6598].spawns.size > 0) {
                origin = level.var_94f4ca81.dataset[level.var_94f4ca81.var_1fde6598].spawns[level.var_94f4ca81.var_64799f7].origin;
                angles = level.var_94f4ca81.dataset[level.var_94f4ca81.var_1fde6598].spawns[level.var_94f4ca81.var_64799f7].angles;
                println("<dev string:x201>" + level.var_94f4ca81.dataset[level.var_94f4ca81.var_1fde6598].name);
                self setorigin(origin);
                self setplayerangles(angles);
                var_f94a23 = 0;
            }
            debug2dtext((100, 750, 0), "<dev string:x224>" + level.var_94f4ca81.dataset[level.var_94f4ca81.var_1fde6598].name, (1, 0, 0));
            debug2dtext((100, 800, 0), "<dev string:x231>" + string(level.var_94f4ca81.var_64799f7) + "<dev string:x23c>" + string(level.var_94f4ca81.dataset[level.var_94f4ca81.var_1fde6598].spawns.size), (1, 0, 0));
            waitframe(1);
        }
    }

    // Namespace spawning/namespace_797605b0
    // Params 0, eflags: 0x0
    // Checksum 0x9284674a, Offset: 0xf40
    // Size: 0x2e6
    function devgui_spawn_think() {
        self notify(#"devgui_spawn_think");
        self endon(#"devgui_spawn_think");
        self endon(#"disconnect");
        dpad_left = 0;
        dpad_right = 0;
        dpad_up = 0;
        dpad_down = 0;
        for (;;) {
            self setactionslot(3, "<dev string:x175>");
            self setactionslot(4, "<dev string:x175>");
            if (!dpad_left && self buttonpressed("<dev string:x1e6>")) {
                setdvar(#"scr_playerwarp", "<dev string:x248>");
                dpad_left = 1;
            } else if (!self buttonpressed("<dev string:x1e6>")) {
                dpad_left = 0;
            }
            if (!dpad_right && self buttonpressed("<dev string:x1f3>")) {
                setdvar(#"scr_playerwarp", "<dev string:x256>");
                dpad_right = 1;
            } else if (!self buttonpressed("<dev string:x1f3>")) {
                dpad_right = 0;
            }
            if (!dpad_up && self buttonpressed("<dev string:x1ce>")) {
                setdvar(#"scr_playerwarp", "<dev string:x264>");
                dpad_up = 1;
            } else if (!self buttonpressed("<dev string:x1ce>")) {
                dpad_up = 0;
            }
            if (!dpad_down && self buttonpressed("<dev string:x1d9>")) {
                setdvar(#"scr_playerwarp", "<dev string:x278>");
                dpad_down = 1;
            } else if (!self buttonpressed("<dev string:x1d9>")) {
                dpad_down = 0;
            }
            waitframe(1);
        }
    }

#/
