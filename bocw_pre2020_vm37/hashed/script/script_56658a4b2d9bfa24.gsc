#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace namespace_1f0cb9eb;

/#

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x0
    // Checksum 0xc587c9a0, Offset: 0x98
    // Size: 0xfc
    function function_70a657d8() {
        callback::on_connect(&on_player_connect);
        callback::on_disconnect(&on_player_disconnect);
        callback::on_spawned(&on_player_spawned);
        callback::add_callback(#"hash_6efb8cec1ca372dc", &function_ac5215a9);
        callback::add_callback(#"hash_6280ac8ed281ce3c", &function_8d1480e9);
        level thread function_d3901b82();
        level thread devgui_loop();
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0x8ba72f82, Offset: 0x1a0
    // Size: 0x34
    function private on_player_connect() {
        if (!isbot(self)) {
            return;
        }
        self thread add_bot_devgui_menu();
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0xdde331ba, Offset: 0x1e0
    // Size: 0x2c
    function private on_player_disconnect() {
        if (isdefined(self.bot)) {
            self thread clear_bot_devgui_menu();
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0xdc330c7, Offset: 0x218
    // Size: 0x8c
    function private on_player_spawned() {
        if (!isbot(self)) {
            return;
        }
        if (getdvarint(#"bots_invulnerable", 0)) {
            self val::set(#"devgui", "<dev string:x38>", 0);
        }
        self function_78a14db2();
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0x5b457c59, Offset: 0x2b0
    // Size: 0x1c
    function private function_ac5215a9() {
        self thread add_bot_devgui_menu();
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0xd7f6af34, Offset: 0x2d8
    // Size: 0x1c
    function private function_8d1480e9() {
        self thread clear_bot_devgui_menu();
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x4
    // Checksum 0x8759db72, Offset: 0x300
    // Size: 0x850
    function private function_40dbe923(dvarstr) {
        args = strtok(dvarstr, "<dev string:x46>");
        host = util::gethostplayerforbots();
        switch (args[0]) {
        case #"spawn_enemy":
            level function_5aef57f5(host, #"enemy");
            break;
        case #"hash_49daf258a305851e":
            level function_5aef57f5(host, #"friendly");
            break;
        case #"add":
            level devgui_add_bots(host, args[1], int(args[2]));
            break;
        case #"remove":
            level devgui_remove_bots(host, args[1]);
            break;
        case #"kill":
            level devgui_kill_bots(host, args[1]);
            break;
        case #"invulnerable":
            level devgui_invulnerable(host, args[1], args[2]);
            break;
        case #"hash_42005f6bebb8df69":
            level function_66f4c396(host, args[1], int(args[2]));
            break;
        case #"ignoreall":
            level devgui_ignoreall(host, args[1], int(args[2]));
            break;
        case #"force_press_button":
            level function_6a4a272b(host, args[1], int(args[2]), 0);
            break;
        case #"force_toggle_button":
            level function_6a4a272b(host, args[1], int(args[2]), 1);
            break;
        case #"clear_forced_buttons":
            level function_baee1142(host, args[1]);
            break;
        case #"force_offhand_primary":
            level function_8bb94cab(host, args[1], #"offhand", #"lethal grenade");
            break;
        case #"force_offhand_secondary":
            level function_8bb94cab(host, args[1], #"offhand", #"tactical grenade");
            break;
        case #"force_offhand_special":
            level function_8bb94cab(host, args[1], "<dev string:x4b>", #"special");
            break;
        case #"force_scorestreak":
            level function_9a65e59a(host, args[1]);
            break;
        case #"sprint":
        case #"revive":
        case #"scorestreak":
        case #"swim":
        case #"specialoffhand":
        case #"secondaryoffhand":
        case #"slide":
        case #"primaryoffhand":
        case #"reload":
            level devgui_attribute(host, args[0], args[1], int(args[2]));
            break;
        case #"tpose":
            level devgui_tpose(host, args[1]);
            break;
        }
        if (isdefined(host)) {
            switch (args[0]) {
            case #"add_fixed_spawn":
                host devgui_add_fixed_spawn_bots(args[1], args[2], args[3]);
                break;
            case #"hash_218217dc7d667f07":
                host function_57d0759d(args[1], undefined, args[2], (float(args[3]), float(args[4]), float(args[5])), float(args[6]));
                break;
            case #"set_target":
                host devgui_set_target(args[1], args[2]);
                break;
            case #"goal":
                host devgui_goal(args[1], args[2]);
                break;
            case #"force_aim_copy":
                host function_30f27f9f(args[1]);
                break;
            case #"force_aim_freeze":
                host function_b037d12d(args[1]);
                break;
            case #"force_aim_clear":
                host function_f419ffae(args[1]);
                break;
            case #"hash_7d471b297adb925d":
                host function_263ca697();
                break;
            case #"warp":
                host function_fbdf36c1(args[1]);
                break;
            }
        }
        level notify(#"devgui_bot", {#host:host, #args:args});
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0xb15793de, Offset: 0xb58
    // Size: 0xb8
    function private devgui_loop() {
        while (true) {
            waitframe(1);
            dvarstr = getdvarstring(#"devgui_bot", "<dev string:x56>");
            if (dvarstr == "<dev string:x56>") {
                continue;
            }
            setdvar(#"devgui_bot", "<dev string:x56>");
            println(dvarstr);
            self thread function_40dbe923(dvarstr);
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0xfb409c4f, Offset: 0xc18
    // Size: 0x1a8
    function private function_9a819607(host, botarg) {
        if (strisnumber(botarg)) {
            ent = getentbynum(int(botarg));
            if (isbot(ent)) {
                return [ent];
            }
            return [];
        }
        if (botarg == "<dev string:x5a>") {
            return bot::get_bots();
        }
        if (isdefined(level.teams[botarg])) {
            return bot::function_a0f5b7f5(level.teams[botarg]);
        }
        if (isdefined(host)) {
            if (botarg == "<dev string:x61>") {
                return host bot::get_friendly_bots();
            }
            if (botarg == "<dev string:x6d>") {
                return host bot::get_enemy_bots();
            }
        }
        if (botarg == "<dev string:x61>") {
            return bot::function_a0f5b7f5(#"allies");
        } else if (botarg == "<dev string:x6d>") {
            return bot::function_a0f5b7f5(#"axis");
        }
        return [];
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0x6c610ba2, Offset: 0xdc8
    // Size: 0x220
    function private function_d3901b82() {
        level endon(#"game_ended");
        sessionmode = currentsessionmode();
        if (sessionmode != 4) {
            var_48c9cde3 = getallcharacterbodies(sessionmode);
            foreach (index in var_48c9cde3) {
                if (index == 0) {
                    continue;
                }
                displayname = makelocalizedstring(getcharacterdisplayname(index, sessionmode));
                assetname = function_9e72a96(getcharacterassetname(index, sessionmode));
                name = displayname + "<dev string:x76>" + assetname + "<dev string:x7c>";
                cmd = "<dev string:x81>" + name + "<dev string:xb6>" + index + "<dev string:xbb>" + index + "<dev string:xea>";
                util::add_debug_command(cmd);
                cmd = "<dev string:xef>" + name + "<dev string:xb6>" + index + "<dev string:x121>" + index + "<dev string:xea>";
                util::add_debug_command(cmd);
            }
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0xd8e305d7, Offset: 0xff0
    // Size: 0xe48
    function private add_bot_devgui_menu() {
        self endon(#"disconnect");
        entnum = self getentitynumber();
        if (entnum >= 16) {
            return;
        }
        i = 0;
        if (!is_true(level.var_fa5cacde)) {
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x15a>", 0, "<dev string:x168>", "<dev string:x174>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x179>", 1, "<dev string:x168>", "<dev string:x188>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x18d>", 0, function_9e72a96(#"primaryoffhand"), "<dev string:x174>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x19d>", 1, function_9e72a96(#"primaryoffhand"), "<dev string:x188>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x1ae>", 0, function_9e72a96(#"secondaryoffhand"), "<dev string:x174>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x1c0>", 1, function_9e72a96(#"secondaryoffhand"), "<dev string:x188>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x1d3>", 0, function_9e72a96(#"specialoffhand"), "<dev string:x174>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x1eb>", 1, function_9e72a96(#"specialoffhand"), "<dev string:x188>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x204>", 0, function_9e72a96(#"scorestreak"), "<dev string:x174>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x21a>", 1, function_9e72a96(#"scorestreak"), "<dev string:x188>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x231>", 0, function_9e72a96(#"reload"), "<dev string:x174>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x241>", 1, function_9e72a96(#"reload"), "<dev string:x188>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x252>", 0, function_9e72a96(#"revive"), "<dev string:x174>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x262>", 1, function_9e72a96(#"revive"), "<dev string:x188>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x273>", 0, function_9e72a96(#"sprint"), "<dev string:x174>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x283>", 1, function_9e72a96(#"sprint"), "<dev string:x188>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x294>", 0, function_9e72a96(#"slide"), "<dev string:x174>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x2a3>", 1, function_9e72a96(#"slide"), "<dev string:x188>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x2b3>", 0, function_9e72a96(#"swim"), "<dev string:x174>");
            self add_bot_devgui_cmd(entnum, "<dev string:x14d>" + i + "<dev string:x2c2>", 1, function_9e72a96(#"swim"), "<dev string:x188>");
            i++;
            self add_bot_devgui_cmd(entnum, "<dev string:x2d2>" + i + "<dev string:x2e1>", 0, "<dev string:x2e8>", "<dev string:x174>");
            self add_bot_devgui_cmd(entnum, "<dev string:x2d2>" + i + "<dev string:x2f5>", 1, "<dev string:x2e8>", "<dev string:x188>");
            i++;
            self add_bot_devgui_cmd(entnum, "<dev string:x2fd>" + i + "<dev string:x30c>", 0, "<dev string:x31f>", "<dev string:x32d>");
            self add_bot_devgui_cmd(entnum, "<dev string:x2fd>" + i + "<dev string:x33a>", 1, "<dev string:x31f>", "<dev string:x348>");
            self add_bot_devgui_cmd(entnum, "<dev string:x2fd>" + i + "<dev string:x34e>", 2, "<dev string:x31f>", "<dev string:x358>");
            i++;
            self add_bot_devgui_cmd(entnum, "<dev string:x361>" + i + "<dev string:x30c>", 0, "<dev string:x36e>", "<dev string:x376>");
            self add_bot_devgui_cmd(entnum, "<dev string:x361>" + i + "<dev string:x37d>", 2, "<dev string:x36e>", "<dev string:x397>");
            self add_bot_devgui_cmd(entnum, "<dev string:x361>" + i + "<dev string:x3a5>", 3, "<dev string:x36e>", "<dev string:x348>");
            i++;
            self add_bot_devgui_cmd(entnum, "<dev string:x3b3>" + i + "<dev string:x30c>", 0, "<dev string:x36e>", "<dev string:x3c7>");
            self add_bot_devgui_cmd(entnum, "<dev string:x3b3>" + i + "<dev string:x34e>", 1, "<dev string:x36e>", "<dev string:x358>");
            i++;
            self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + i + "<dev string:x3e1>", 0, "<dev string:x3f2>", 0);
            self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + i + "<dev string:x408>", 1, "<dev string:x41a>", 0);
            self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + i + "<dev string:x431>", 0, "<dev string:x3f2>", 11);
            self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + i + "<dev string:x441>", 1, "<dev string:x41a>", 11);
            self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + i + "<dev string:x452>", 0, "<dev string:x3f2>", 28);
            self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + i + "<dev string:x46a>", 1, "<dev string:x41a>", 28);
            self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + i + "<dev string:x483>", 0, "<dev string:x3f2>", 5);
            self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + i + "<dev string:x493>", 1, "<dev string:x41a>", 5);
            self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + i + "<dev string:x4a4>", 500, "<dev string:x4b2>");
            self function_ade411a3(entnum, i);
            i++;
            self add_bot_devgui_cmd(entnum, "<dev string:x4ca>" + i + "<dev string:x4d8>", 0, "<dev string:x4e4>");
            self add_bot_devgui_cmd(entnum, "<dev string:x4ca>" + i + "<dev string:x4f6>", 1, "<dev string:x502>");
            self add_bot_devgui_cmd(entnum, "<dev string:x4ca>" + i + "<dev string:x516>", 2, "<dev string:x521>");
            i++;
            self add_bot_devgui_cmd(entnum, "<dev string:x534>" + i + "<dev string:x542>", 0, "<dev string:x54d>");
            self add_bot_devgui_cmd(entnum, "<dev string:x534>" + i + "<dev string:x566>", 1, "<dev string:x573>");
            self add_bot_devgui_cmd(entnum, "<dev string:x534>" + i + "<dev string:x58e>", 2, "<dev string:x5a0>");
            self add_bot_devgui_cmd(entnum, "<dev string:x534>" + i + "<dev string:x5b9>", 3, "<dev string:x5d3>");
            i++;
        }
        self add_bot_devgui_cmd(entnum, "<dev string:x5e8>" + i + "<dev string:x2e1>", 0, "<dev string:x5f9>", "<dev string:x609>");
        self add_bot_devgui_cmd(entnum, "<dev string:x5e8>" + i + "<dev string:x2f5>", 1, "<dev string:x5f9>", "<dev string:x60f>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x616>", i, "<dev string:x62b>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x633>", i, "<dev string:x63d>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x646>", i, "<dev string:x64e>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x656>", i, "<dev string:x660>");
        i++;
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 5, eflags: 0x4
    // Checksum 0xb5ed65a1, Offset: 0x1e40
    // Size: 0xec
    function private add_bot_devgui_cmd(entnum, path, sortkey, devguiarg, cmdargs) {
        if (!isdefined(cmdargs)) {
            cmdargs = "<dev string:x56>";
        }
        cmd = "<dev string:x66a>" + entnum + "<dev string:x46>" + self.name + "<dev string:xb6>" + entnum + "<dev string:x67f>" + path + "<dev string:xb6>" + sortkey + "<dev string:x684>" + devguiarg + "<dev string:x46>" + entnum + "<dev string:x46>" + cmdargs + "<dev string:xea>";
        util::add_debug_command(cmd);
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 5, eflags: 0x4
    // Checksum 0x8e3e149, Offset: 0x1f38
    // Size: 0xdc
    function private function_f105dc20(entnum, var_eeb5e4bd, var_8a5cf3f4, var_1e443b4, buttonbit) {
        self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + var_eeb5e4bd + "<dev string:x67f>" + var_8a5cf3f4 + "<dev string:xb6>" + var_1e443b4 + "<dev string:x69a>", 0, "<dev string:x3f2>", buttonbit);
        self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + var_eeb5e4bd + "<dev string:x67f>" + var_8a5cf3f4 + "<dev string:xb6>" + var_1e443b4 + "<dev string:x6a4>", 1, "<dev string:x41a>", buttonbit);
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0xa51b59e4, Offset: 0x2020
    // Size: 0x11c
    function private function_ade411a3(entnum, var_eeb5e4bd) {
        i = 0;
        self function_f105dc20(entnum, var_eeb5e4bd, "<dev string:x6af>", i, 0);
        i++;
        self function_f105dc20(entnum, var_eeb5e4bd, "<dev string:x6b7>", i, 11);
        i++;
        self function_f105dc20(entnum, var_eeb5e4bd, "<dev string:x6be>", i, 10);
        i++;
        self function_f105dc20(entnum, var_eeb5e4bd, "<dev string:x6c6>", i, 28);
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x3d0>" + var_eeb5e4bd + "<dev string:x4a4>", 500, "<dev string:x4b2>");
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x0
    // Checksum 0x1249cba1, Offset: 0x2148
    // Size: 0x7c
    function clear_bot_devgui_menu() {
        entnum = self getentitynumber();
        if (entnum >= 16) {
            return;
        }
        cmd = "<dev string:x6d5>" + entnum + "<dev string:x46>" + self.name + "<dev string:xea>";
        util::add_debug_command(cmd);
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 3, eflags: 0x4
    // Checksum 0xa4293ccd, Offset: 0x21d0
    // Size: 0xcc
    function private devgui_add_bots(host, botarg, count) {
        team = function_881d3aa(host, botarg);
        if (!isdefined(team)) {
            return;
        }
        players = getplayers(team);
        max_players = player::function_d36b6597();
        if (players.size < max_players || max_players == 0) {
            level thread bot::add_bots(count, team);
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0xba71ba63, Offset: 0x22a8
    // Size: 0xa2
    function private function_5aef57f5(host, botarg) {
        level endon(#"game_ended");
        team = function_881d3aa(host, botarg);
        if (!isdefined(team)) {
            return;
        }
        bot = bot::add_bot(team);
        bot bot::allow_all(0);
        bot.bot.var_261b9ab3 = 1;
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 3, eflags: 0x4
    // Checksum 0x4e3dabdd, Offset: 0x2358
    // Size: 0x39c
    function private devgui_add_fixed_spawn_bots(botarg, var_b27e53da, countarg) {
        team = function_881d3aa(self, botarg);
        if (!isdefined(team)) {
            return;
        }
        if (!isdefined(countarg)) {
            countarg = 1;
        }
        var_c6e7a9ca = max(int(countarg), 1);
        count = var_c6e7a9ca;
        players = getplayers(team);
        max_players = player::function_d36b6597();
        if (max_players > 0) {
            count = min(count, max_players - players.size);
        }
        if (count <= 0) {
            return;
        }
        if (!isdefined(var_b27e53da)) {
            var_b27e53da = -1;
        }
        roleindex = int(var_b27e53da);
        trace = self eye_trace(0, 1);
        spawndir = self.origin - trace[#"position"];
        spawnangles = vectortoangles(spawndir);
        offset = (0, 0, 5);
        origin = trace[#"position"] + offset;
        bots = bot::function_bd48ef10(team, count, origin, spawnangles[1], roleindex);
        vehicle = trace[#"entity"];
        if (isvehicle(vehicle)) {
            pos = trace[#"position"];
            seatindex = vehicle function_eee09f16(pos);
            if (isdefined(seatindex)) {
                foreach (bot in bots) {
                    bot bot::function_bcc79b86(vehicle, seatindex);
                }
            }
        }
        println("<dev string:x6ed>" + botarg + "<dev string:x46>" + var_c6e7a9ca + "<dev string:x46>" + origin[0] + "<dev string:x46>" + origin[1] + "<dev string:x46>" + origin[2] + "<dev string:x46>" + spawnangles[1]);
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 5, eflags: 0x4
    // Checksum 0xb287701b, Offset: 0x2700
    // Size: 0x196
    function private function_57d0759d(botarg, var_b27e53da, countarg, origin, angle) {
        team = function_881d3aa(self, botarg);
        if (!isdefined(team)) {
            return;
        }
        if (!isdefined(countarg)) {
            countarg = 1;
        }
        count = max(int(countarg), 1);
        players = getplayers(team);
        max_players = player::function_d36b6597();
        if (max_players > 0) {
            count = min(count, max_players - players.size);
        }
        if (count <= 0) {
            return;
        }
        if (!isdefined(var_b27e53da)) {
            var_b27e53da = -1;
        }
        roleindex = int(var_b27e53da);
        offset = (0, 0, 5);
        origin += offset;
        bots = bot::function_bd48ef10(team, count, origin, angle, roleindex);
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0x55fc0e3c, Offset: 0x28a0
    // Size: 0xd4
    function private function_881d3aa(host, botarg) {
        if (botarg == "<dev string:x5a>") {
            return #"none";
        }
        if (isdefined(level.teams[botarg])) {
            return level.teams[botarg];
        }
        var_a70c469f = #"allies";
        if (isdefined(host) && host.team != #"spectator") {
            var_a70c469f = host.team;
        }
        if (botarg == "<dev string:x61>") {
            return var_a70c469f;
        }
        return function_8dbb49c0(var_a70c469f);
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x4
    // Checksum 0xb4d0f6a, Offset: 0x2980
    // Size: 0x10a
    function private function_8dbb49c0(ignoreteam) {
        assert(isdefined(ignoreteam));
        maxteamplayers = player::function_d36b6597();
        foreach (team, _ in level.teams) {
            if (team == ignoreteam) {
                continue;
            }
            players = getplayers(team);
            if (maxteamplayers > 0 && players.size < maxteamplayers) {
                return team;
            }
        }
        return undefined;
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0xa6223071, Offset: 0x2a98
    // Size: 0xc0
    function private devgui_remove_bots(host, botarg) {
        bots = function_9a819607(host, botarg);
        foreach (bot in bots) {
            level thread bot::remove_bot(bot);
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 3, eflags: 0x4
    // Checksum 0x8a5761c9, Offset: 0x2b60
    // Size: 0xbe
    function private devgui_ignoreall(host, botarg, cmdarg) {
        bots = function_9a819607(host, botarg);
        foreach (bot in bots) {
            bot.ignoreall = cmdarg;
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 3, eflags: 0x4
    // Checksum 0x55ca6472, Offset: 0x2c28
    // Size: 0xc8
    function private function_66f4c396(host, botarg, cmdarg) {
        bots = function_9a819607(host, botarg);
        foreach (bot in bots) {
            bot bot::allow_all(cmdarg);
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 4, eflags: 0x4
    // Checksum 0xc02ec8d6, Offset: 0x2cf8
    // Size: 0x134
    function private devgui_attribute(host, attribute, botarg, cmdarg) {
        bots = function_9a819607(host, botarg);
        foreach (bot in bots) {
            foreach (bot in bots) {
                bot ai::set_behavior_attribute(attribute, cmdarg);
            }
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0xa674d8df, Offset: 0x2e38
    // Size: 0x190
    function private devgui_set_target(botarg, cmdarg) {
        target = undefined;
        switch (cmdarg) {
        case #"crosshair":
            target = self function_59842621();
            break;
        case #"me":
            target = self;
            break;
        case #"clear":
            break;
        default:
            return;
        }
        bots = function_9a819607(self, botarg);
        foreach (bot in bots) {
            if (isdefined(target)) {
                if (target != bot) {
                    bot setentitytarget(target);
                    bot getperfectinfo(target, 1);
                }
                continue;
            }
            bot clearentitytarget();
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0xb6a92ece, Offset: 0x2fd0
    // Size: 0x10a
    function private devgui_goal(botarg, cmdarg) {
        switch (cmdarg) {
        case #"set":
            self set_goal(botarg, 0);
            return;
        case #"set_region":
            self function_417ef9e7(botarg);
            return;
        case #"force":
            self set_goal(botarg, 1);
            return;
        case #"me":
            self set_goal_ent(botarg, self);
            return;
        case #"clear":
            self function_be8f790e(botarg);
            return;
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0x777acac, Offset: 0x30e8
    // Size: 0x2d0
    function private set_goal(botarg, force) {
        if (!isdefined(force)) {
            force = 0;
        }
        trace = self eye_trace(1);
        bots = function_9a819607(self, botarg);
        pos = trace[#"position"];
        goal = isdefined(self bot::get_nearest_node(pos)) ? self bot::get_nearest_node(pos) : pos;
        vehicle = isvehicle(trace[#"entity"]) ? trace[#"entity"] : undefined;
        foreach (bot in bots) {
            bot ai::set_behavior_attribute("<dev string:x711>", "<dev string:x71c>");
            bot setgoal(goal, force);
            if (bot isinvehicle()) {
                currentvehicle = bot getvehicleoccupied();
                if (vehicle === currentvehicle) {
                    seatindex = vehicle function_d1409e38(pos);
                    if (!vehicle isvehicleseatoccupied(seatindex)) {
                        vehicle function_1090ca(bot, seatindex);
                    }
                } else {
                    var_c3eee21b = currentvehicle getoccupantseat(bot);
                    currentvehicle usevehicle(bot, var_c3eee21b);
                }
                continue;
            }
            if (isdefined(vehicle)) {
                seatindex = vehicle function_eee09f16(pos);
                if (isdefined(seatindex)) {
                    vehicle usevehicle(bot, seatindex);
                }
            }
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x4
    // Checksum 0xdb6a54a1, Offset: 0x33c0
    // Size: 0x120
    function private function_417ef9e7(botarg) {
        trace = self eye_trace(1);
        bots = function_9a819607(self, botarg);
        pos = trace[#"position"];
        point = getclosesttacpoint(pos);
        if (!isdefined(point)) {
            return;
        }
        foreach (bot in bots) {
            bot setgoal(point.region);
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x0
    // Checksum 0x70f3ca3e, Offset: 0x34e8
    // Size: 0x150
    function set_goal_ent(botarg, ent) {
        bots = function_9a819607(self, botarg);
        foreach (bot in bots) {
            bot ai::set_behavior_attribute("<dev string:x711>", "<dev string:x71c>");
            bot setgoal(ent);
            if (bot isinvehicle()) {
                vehicle = bot getvehicleoccupied();
                seatindex = vehicle getoccupantseat(bot);
                vehicle usevehicle(bot, seatindex);
            }
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x0
    // Checksum 0xd7a0eec, Offset: 0x3640
    // Size: 0xd8
    function function_be8f790e(botarg) {
        bots = function_9a819607(self, botarg);
        foreach (bot in bots) {
            bot ai::set_behavior_attribute("<dev string:x711>", "<dev string:x72a>");
            bot clearforcedgoal();
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 4, eflags: 0x4
    // Checksum 0x89fd7607, Offset: 0x3720
    // Size: 0x148
    function private function_6a4a272b(host, botarg, cmdarg, toggle) {
        bots = function_9a819607(host, botarg);
        foreach (bot in bots) {
            if (!isdefined(bot.bot.var_a0f96630)) {
                bot.bot.var_a0f96630 = [];
            }
            var_1f3b89f7 = bot.bot.var_a0f96630;
            if (toggle) {
                var_1f3b89f7[cmdarg] = is_true(var_1f3b89f7[cmdarg]) ? undefined : 1;
                continue;
            }
            var_1f3b89f7[cmdarg] = 2;
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0x7476bf86, Offset: 0x3870
    // Size: 0xbe
    function private function_baee1142(host, botarg) {
        bots = function_9a819607(host, botarg);
        foreach (bot in bots) {
            bot.bot.var_a0f96630 = [];
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x0
    // Checksum 0xc61a21cc, Offset: 0x3938
    // Size: 0x3b4
    function function_e4055765() {
        var_1f3b89f7 = self.bot.var_a0f96630;
        foreach (bit, val in var_1f3b89f7) {
            self bottapbutton(bit);
            if (val > 1) {
                var_1f3b89f7[bit] = undefined;
            }
        }
        if (getdvarint(#"bot_forcefire", 0)) {
            weapon = self getcurrentweapon();
            if (weapon.firetype == #"full auto" || weapon.firetype == #"auto burst" || weapon.firetype == #"minigun" || !self attackbuttonpressed()) {
                self bottapbutton(0);
                if (weapon.dualwieldweapon != level.weaponnone) {
                    self bottapbutton(11);
                }
            } else {
                self botreleasebutton(0);
                if (weapon.dualwieldweapon != level.weaponnone) {
                    self botreleasebutton(11);
                }
            }
        }
        if (getdvarint(#"bot_forcestand", 0)) {
            self botreleasebutton(9);
            self botreleasebutton(8);
            return;
        }
        if (getdvarint(#"bot_forcecrouch", 0)) {
            self bottapbutton(9);
            self botreleasebutton(8);
            return;
        }
        if (getdvarint(#"bot_forceprone", 0)) {
            self botreleasebutton(9);
            self bottapbutton(8);
            return;
        }
        if (getdvarint(#"hash_3049c8687f66a426", 0)) {
            self botreleasebutton(9);
            self botreleasebutton(8);
            if (self isonground() && !self jumpbuttonpressed()) {
                self bottapbutton(10);
            }
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 4, eflags: 0x4
    // Checksum 0xdffeecad, Offset: 0x3cf8
    // Size: 0x128
    function private function_8bb94cab(host, botarg, inventorytype, offhandslot) {
        bots = function_9a819607(host, botarg);
        foreach (bot in bots) {
            weapon = bot function_b24b9a1e(inventorytype, offhandslot);
            if (isdefined(weapon)) {
                bot givemaxammo(weapon);
                bot bot_action::function_d6318084(weapon);
                bot bot_action::function_32020adf(3);
            }
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0x8e91cce5, Offset: 0x3e28
    // Size: 0xd4
    function private function_b24b9a1e(inventorytype, offhandslot) {
        weapons = self getweaponslist();
        foreach (weapon in weapons) {
            if (weapon.inventorytype == inventorytype && weapon.offhandslot == offhandslot) {
                return weapon;
            }
        }
        return undefined;
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0x64d0a69a, Offset: 0x3f08
    // Size: 0x100
    function private function_9a65e59a(host, botarg) {
        bots = function_9a819607(host, botarg);
        foreach (bot in bots) {
            weapon = bot function_ef14f060();
            if (isdefined(weapon)) {
                bot bot_action::function_d6318084(weapon);
                bot bot_action::function_32020adf(3);
            }
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0xb371fa99, Offset: 0x4010
    // Size: 0x1de
    function private function_ef14f060() {
        weapons = self getweaponslist();
        foreach (weapon in weapons) {
            if (weapon.inventorytype != #"item" || self getweaponammoclip(weapon) <= 0) {
                continue;
            }
            foreach (name in self.killstreak) {
                if (weapon.name == name) {
                }
            }
            foreach (killstreak in level.killstreaks) {
                if (killstreak.weapon == weapon) {
                    return weapon;
                }
            }
        }
        return undefined;
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x4
    // Checksum 0x50cf067f, Offset: 0x41f8
    // Size: 0x1a8
    function private function_fbdf36c1(botarg) {
        bots = function_9a819607(self, botarg);
        yaw = absangleclamp360(self.angles[1] + 180);
        angle = (0, yaw, 0);
        trace = self eye_trace(1, 1);
        pos = trace[#"position"];
        foreach (bot in bots) {
            bot dontinterpolate();
            bot setplayerangles(angle);
            bot setorigin(pos);
            if (bot function_4794d6a3().goalforced) {
                bot setgoal(pos, 1);
            }
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x4
    // Checksum 0x89f28733, Offset: 0x43a8
    // Size: 0xb0
    function private function_30f27f9f(botarg) {
        bots = function_9a819607(self, botarg);
        foreach (bot in bots) {
            bot thread function_2e08087e(self);
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x4
    // Checksum 0x70d04262, Offset: 0x4460
    // Size: 0xce
    function private function_b037d12d(botarg) {
        bots = function_9a819607(self, botarg);
        foreach (bot in bots) {
            bot notify(#"hash_1fc88ab5756d805");
            bot.bot.var_ef842dc3 = bot getplayerangles();
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x4
    // Checksum 0x4a3905f3, Offset: 0x4538
    // Size: 0xbe
    function private function_f419ffae(botarg) {
        bots = function_9a819607(self, botarg);
        foreach (bot in bots) {
            bot notify(#"hash_1fc88ab5756d805");
            bot.bot.var_ef842dc3 = undefined;
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x4
    // Checksum 0x910a0b97, Offset: 0x4600
    // Size: 0x11a
    function private function_2e08087e(player) {
        self endon(#"death", #"disconnect", #"hash_1fc88ab5756d805", #"hash_6280ac8ed281ce3c");
        while (isdefined(player) && isalive(player)) {
            angles = player getplayerangles();
            yawoffset = getdvarint(#"hash_68c18f3309126669", 0) * 15;
            var_6cd5d6b6 = angles + (0, yawoffset, 0);
            self.bot.var_ef842dc3 = angleclamp180(var_6cd5d6b6);
            waitframe(1);
        }
        self.bot.var_ef842dc3 = undefined;
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x0
    // Checksum 0xa7b8189d, Offset: 0x4728
    // Size: 0x4a
    function function_c3d7f7d6() {
        if (!isdefined(self.bot.var_ef842dc3)) {
            return 0;
        }
        self botsetlookangles(self.bot.var_ef842dc3);
        return 1;
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x0
    // Checksum 0xf63a5e7, Offset: 0x4780
    // Size: 0xf0
    function devgui_tpose(host, botarg) {
        bots = function_9a819607(host, botarg);
        foreach (bot in bots) {
            setdvar(#"bg_boastenabled", 1);
            bot function_c6775cf9("<dev string:x737>");
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 3, eflags: 0x4
    // Checksum 0x96e58a7e, Offset: 0x4878
    // Size: 0x120
    function private devgui_invulnerable(host, botarg, cmdarg) {
        bots = function_9a819607(host, botarg);
        foreach (bot in bots) {
            if (cmdarg == "<dev string:x609>") {
                bot val::set(#"devgui", "<dev string:x38>", 0);
                continue;
            }
            bot val::reset(#"devgui", "<dev string:x38>");
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0x904d2cdf, Offset: 0x49a0
    // Size: 0x148
    function private devgui_kill_bots(host, botarg) {
        bots = function_9a819607(host, botarg);
        foreach (bot in bots) {
            if (!isalive(bot)) {
                continue;
            }
            bot val::set(#"devgui_kill", "<dev string:x38>", 1);
            bot dodamage(bot.health + 1000, bot.origin);
            bot val::reset(#"devgui_kill", "<dev string:x38>");
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0xe6e71faf, Offset: 0x4af0
    // Size: 0x138
    function private function_263ca697() {
        weapon = self getcurrentweapon();
        setdvar(#"bot_spawn_weapon", getweaponname(weapon.rootweapon));
        setdvar(#"hash_c6e51858c88a5ee", util::function_2146bd83(weapon));
        bots = bot::get_bots();
        foreach (bot in bots) {
            bot function_35e77034(weapon);
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0x4fb33b8, Offset: 0x4c30
    // Size: 0xbc
    function private function_78a14db2() {
        weapon = undefined;
        if (getdvarstring(#"bot_spawn_weapon", "<dev string:x56>") != "<dev string:x56>") {
            weapon = util::get_weapon_by_name(getdvarstring(#"bot_spawn_weapon"), getdvarstring(#"hash_c6e51858c88a5ee"));
            if (isdefined(weapon)) {
                self function_35e77034(weapon);
            }
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x4
    // Checksum 0xe6d483f2, Offset: 0x4cf8
    // Size: 0xa4
    function private function_35e77034(weapon) {
        if (!isdefined(weapon) || weapon == level.weaponnone) {
            return;
        }
        self function_85e7342b();
        self giveweapon(weapon);
        self givemaxammo(weapon);
        self switchtoweaponimmediate(weapon);
        self setspawnweapon(weapon);
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0x8db3fdac, Offset: 0x4da8
    // Size: 0xa8
    function private function_85e7342b() {
        weapons = self getweaponslistprimaries();
        foreach (weapon in weapons) {
            self takeweapon(weapon);
        }
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 2, eflags: 0x4
    // Checksum 0x631bde98, Offset: 0x4e58
    // Size: 0xf4
    function private eye_trace(hitents, var_18daeece) {
        if (!isdefined(hitents)) {
            hitents = 0;
        }
        if (!isdefined(var_18daeece)) {
            var_18daeece = 0;
        }
        angles = self getplayerangles();
        fwd = anglestoforward(angles);
        var_98b02a87 = self getplayerviewheight();
        eye = self.origin + (0, 0, var_98b02a87);
        end = eye + fwd * 8000;
        return bullettrace(eye, end, hitents, self, var_18daeece);
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 0, eflags: 0x4
    // Checksum 0xee404c8e, Offset: 0x4f58
    // Size: 0x50
    function private function_59842621() {
        trace = self eye_trace(1);
        targetentity = trace[#"entity"];
        return targetentity;
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x4
    // Checksum 0x8d0f335b, Offset: 0x4fb0
    // Size: 0x11a
    function private function_eee09f16(pos) {
        seatindex = undefined;
        var_d64c5caf = undefined;
        for (i = 0; i < 11; i++) {
            if (self function_dcef0ba1(i)) {
                var_3693c73b = self function_defc91b2(i);
                if (isdefined(var_3693c73b) && var_3693c73b >= 0 && !self isvehicleseatoccupied(i)) {
                    dist = distance(pos, self function_5051cc0c(i));
                    if (!isdefined(seatindex) || var_d64c5caf > dist) {
                        seatindex = i;
                        var_d64c5caf = dist;
                    }
                }
            }
        }
        return seatindex;
    }

    // Namespace namespace_1f0cb9eb/namespace_1f0cb9eb
    // Params 1, eflags: 0x4
    // Checksum 0x24f9e1be, Offset: 0x50d8
    // Size: 0xfa
    function private function_d1409e38(pos) {
        seatindex = undefined;
        var_d64c5caf = undefined;
        for (i = 0; i < 11; i++) {
            if (self function_dcef0ba1(i)) {
                var_3693c73b = self function_defc91b2(i);
                if (isdefined(var_3693c73b) && var_3693c73b >= 0) {
                    dist = distance(pos, self function_5051cc0c(i));
                    if (!isdefined(seatindex) || var_d64c5caf > dist) {
                        seatindex = i;
                        var_d64c5caf = dist;
                    }
                }
            }
        }
        return seatindex;
    }

#/
