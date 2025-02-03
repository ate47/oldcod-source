#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace bot_devgui;

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x6
// Checksum 0x46549c24, Offset: 0x4d0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"bot_devgui", &preinit, undefined, undefined, undefined);
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0xbee0530a, Offset: 0x518
// Size: 0x14c
function private preinit() {
    if (isshipbuild() || currentsessionmode() == 4 || currentsessionmode() == 2) {
        return;
    }
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_spawned(&on_player_spawned);
    callback::add_callback(#"hash_6efb8cec1ca372dc", &function_ac5215a9);
    callback::add_callback(#"hash_6280ac8ed281ce3c", &function_8d1480e9);
    /#
        level thread function_d3901b82();
    #/
    level thread devgui_loop();
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0xc87c65a4, Offset: 0x670
// Size: 0x34
function private on_player_connect() {
    if (!isbot(self)) {
        return;
    }
    self thread add_bot_devgui_menu();
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0xba9f260c, Offset: 0x6b0
// Size: 0x24
function private on_player_disconnect() {
    if (isdefined(self.bot)) {
        self thread clear_bot_devgui_menu();
    }
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0x10d3461d, Offset: 0x6e0
// Size: 0x8c
function private on_player_spawned() {
    if (!isbot(self)) {
        return;
    }
    if (getdvarint(#"bots_invulnerable", 0)) {
        self val::set(#"devgui", "takedamage", 0);
    }
    self function_78a14db2();
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0xf8479073, Offset: 0x778
// Size: 0x1c
function private function_ac5215a9() {
    self thread add_bot_devgui_menu();
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0x1d348b6b, Offset: 0x7a0
// Size: 0x1c
function private function_8d1480e9() {
    self thread clear_bot_devgui_menu();
}

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0x72575b4, Offset: 0x7c8
// Size: 0x728
function private function_40dbe923(dvarstr) {
    args = strtok(dvarstr, " ");
    host = util::gethostplayerforbots();
    switch (args[0]) {
    case #"spawn_enemy":
        level function_5aef57f5(host, #"enemy");
        break;
    case #"spawn_friendly":
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
    case #"ignoreall":
        level devgui_ignoreall(host, args[1], int(args[2]));
        break;
    case #"force_press_button":
        level devgui_force_button(host, args[1], int(args[2]), 0);
        break;
    case #"force_toggle_button":
        level devgui_force_button(host, args[1], int(args[2]), 1);
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
        level function_8bb94cab(host, args[1], "ability", #"special");
        break;
    case #"force_scorestreak":
        level function_9a65e59a(host, args[1]);
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

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0x940161dd, Offset: 0xef8
// Size: 0xb8
function private devgui_loop() {
    while (true) {
        waitframe(1);
        dvarstr = getdvarstring(#"devgui_bot", "");
        if (dvarstr == "") {
            continue;
        }
        println(dvarstr);
        setdvar(#"devgui_bot", "");
        self thread function_40dbe923(dvarstr);
    }
}

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0xbf07043c, Offset: 0xfb8
// Size: 0x1a6
function private function_9a819607(host, botarg) {
    if (strisnumber(botarg)) {
        ent = getentbynum(int(botarg));
        if (isbot(ent)) {
            return [ent];
        }
        return [];
    }
    if (botarg == "all") {
        return get_bots();
    }
    if (isdefined(level.teams[botarg])) {
        return function_a0f5b7f5(level.teams[botarg]);
    }
    if (isdefined(host)) {
        if (botarg == "friendly") {
            return host get_friendly_bots();
        }
        if (botarg == "enemy") {
            return host get_enemy_bots();
        }
    }
    if (botarg == "friendly") {
        return function_a0f5b7f5(#"allies");
    } else if (botarg == "enemy") {
        return function_a0f5b7f5(#"axis");
    }
    return [];
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x0
// Checksum 0xa3e14384, Offset: 0x1168
// Size: 0xc2
function get_bots() {
    players = getplayers();
    bots = [];
    foreach (player in players) {
        if (isbot(player)) {
            bots[bots.size] = player;
        }
    }
    return bots;
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x0
// Checksum 0x4d436902, Offset: 0x1238
// Size: 0xce
function get_friendly_bots() {
    players = getplayers(self.team);
    bots = [];
    foreach (player in players) {
        if (!isbot(player)) {
            continue;
        }
        bots[bots.size] = player;
    }
    return bots;
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x0
// Checksum 0xb12a3ba2, Offset: 0x1310
// Size: 0xea
function get_enemy_bots() {
    players = getplayers();
    bots = [];
    foreach (player in players) {
        if (!isbot(player)) {
            continue;
        }
        if (util::function_fbce7263(player.team, self.team)) {
            bots[bots.size] = player;
        }
    }
    return bots;
}

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x0
// Checksum 0xcf17e56a, Offset: 0x1408
// Size: 0xd6
function function_a0f5b7f5(team) {
    players = getplayers(team);
    bots = [];
    foreach (player in players) {
        if (!isbot(player)) {
            continue;
        }
        bots[bots.size] = player;
    }
    return bots;
}

/#

    // Namespace bot_devgui/bot_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x99f893, Offset: 0x14e8
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
                name = displayname + "<dev string:x38>" + assetname + "<dev string:x3e>";
                cmd = "<dev string:x43>" + name + "<dev string:x78>" + index + "<dev string:x7d>" + index + "<dev string:xac>";
                util::add_debug_command(cmd);
                cmd = "<dev string:xb1>" + name + "<dev string:x78>" + index + "<dev string:xe3>" + index + "<dev string:xac>";
                util::add_debug_command(cmd);
            }
        }
    }

#/

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0x7830cff3, Offset: 0x1710
// Size: 0x620
function private add_bot_devgui_menu() {
    self endon(#"disconnect");
    entnum = self getentitynumber();
    if (entnum >= 16) {
        return;
    }
    i = 0;
    self add_bot_devgui_cmd(entnum, "Ignore All:" + i + "/On", 0, "ignoreall", "1");
    self add_bot_devgui_cmd(entnum, "Ignore All:" + i + "/Off", 1, "ignoreall", "0");
    i++;
    self add_bot_devgui_cmd(entnum, "Set Target:" + i + "/From Crosshair", 0, "set_target", "crosshair");
    self add_bot_devgui_cmd(entnum, "Set Target:" + i + "/Attack Me", 1, "set_target", "me");
    self add_bot_devgui_cmd(entnum, "Set Target:" + i + "/Clear", 2, "set_target", "clear");
    i++;
    self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Force", 0, "goal", "force");
    self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Add Forced", 1, "goal", "add_forced");
    self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Clear Forced", 2, "goal", "clear");
    self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Radius", 3, "goal", "set");
    self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Region", 4, "goal", "set_region");
    self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Follow Me", 5, "goal", "me");
    i++;
    i++;
    if (!is_true(level.var_fa5cacde)) {
        self function_ade411a3(entnum, i);
        i++;
        self add_bot_devgui_cmd(entnum, "Force Aim:" + i + "/Copy Me", 0, "force_aim_copy");
        self add_bot_devgui_cmd(entnum, "Force Aim:" + i + "/Freeze ", 1, "force_aim_freeze");
        self add_bot_devgui_cmd(entnum, "Force Aim:" + i + "/Clear ", 2, "force_aim_clear");
        i++;
        self add_bot_devgui_cmd(entnum, "Force Use:" + i + "/Lethal", 0, "force_offhand_primary");
        self add_bot_devgui_cmd(entnum, "Force Use:" + i + "/Tactical", 1, "force_offhand_secondary");
        self add_bot_devgui_cmd(entnum, "Force Use:" + i + "/Field Upgrade", 2, "force_offhand_special");
        self add_bot_devgui_cmd(entnum, "Force Use:" + i + "/Inventory Scorestreak", 3, "force_scorestreak");
        i++;
    }
    self add_bot_devgui_cmd(entnum, "Invulnerable:" + i + "/On", 0, "invulnerable", "on");
    self add_bot_devgui_cmd(entnum, "Invulnerable:" + i + "/Off", 1, "invulnerable", "off");
    i++;
    self add_bot_devgui_cmd(entnum, "Warp to Crosshair", i, "warp");
    i++;
    self add_bot_devgui_cmd(entnum, "T-Pose", i, "tpose");
    i++;
    self add_bot_devgui_cmd(entnum, "Kill", i, "kill");
    i++;
    self add_bot_devgui_cmd(entnum, "Remove", i, "remove");
    i++;
}

// Namespace bot_devgui/bot_devgui
// Params 5, eflags: 0x4
// Checksum 0x346d400, Offset: 0x1d38
// Size: 0xe4
function private add_bot_devgui_cmd(entnum, path, sortkey, devguiarg, cmdargs = "") {
    cmd = "devgui_cmd \"Bots/" + entnum + " " + self.name + ":" + entnum + "/" + path + ":" + sortkey + "\" \"set devgui_bot " + devguiarg + " " + entnum + " " + cmdargs + "\"";
    util::add_debug_command(cmd);
}

// Namespace bot_devgui/bot_devgui
// Params 5, eflags: 0x4
// Checksum 0xba1b7381, Offset: 0x1e28
// Size: 0xdc
function private function_f105dc20(entnum, var_eeb5e4bd, buttonmenu, var_1e443b4, buttonbit) {
    self add_bot_devgui_cmd(entnum, "Force Button:" + var_eeb5e4bd + "/" + buttonmenu + ":" + var_1e443b4 + "/Press", 0, "force_press_button", buttonbit);
    self add_bot_devgui_cmd(entnum, "Force Button:" + var_eeb5e4bd + "/" + buttonmenu + ":" + var_1e443b4 + "/Toggle", 1, "force_toggle_button", buttonbit);
}

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0x60e38208, Offset: 0x1f10
// Size: 0x1ac
function private function_ade411a3(entnum, var_eeb5e4bd) {
    i = 0;
    self function_f105dc20(entnum, var_eeb5e4bd, "Fire", i, 0);
    i++;
    self function_f105dc20(entnum, var_eeb5e4bd, "Sprint", i, 1);
    i++;
    self function_f105dc20(entnum, var_eeb5e4bd, "ADS", i, 11);
    i++;
    self function_f105dc20(entnum, var_eeb5e4bd, "Jump", i, 10);
    i++;
    self function_f105dc20(entnum, var_eeb5e4bd, "Change Seat", i, 28);
    i++;
    self function_f105dc20(entnum, var_eeb5e4bd, "Use | Reload", i, 5);
    i++;
    self function_f105dc20(entnum, var_eeb5e4bd, "Melee", i, 2);
    i++;
    self add_bot_devgui_cmd(entnum, "Force Button:" + var_eeb5e4bd + "/Clear All", 500, "clear_forced_buttons");
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x0
// Checksum 0xae437b06, Offset: 0x20c8
// Size: 0x7c
function clear_bot_devgui_menu() {
    entnum = self getentitynumber();
    if (entnum >= 16) {
        return;
    }
    cmd = "devgui_remove \"Bots/" + entnum + " " + self.name + "\"";
    util::add_debug_command(cmd);
}

// Namespace bot_devgui/bot_devgui
// Params 3, eflags: 0x4
// Checksum 0x4747fdcb, Offset: 0x2150
// Size: 0xc4
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

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0x8c614a0d, Offset: 0x2220
// Size: 0x96
function private function_5aef57f5(host, botarg) {
    level endon(#"game_ended");
    team = function_881d3aa(host, botarg);
    if (!isdefined(team)) {
        return;
    }
    bot = bot::add_bot(team);
    bot.ignoreall = 1;
    bot.bot.var_261b9ab3 = 1;
}

// Namespace bot_devgui/bot_devgui
// Params 3, eflags: 0x4
// Checksum 0x65ea6b66, Offset: 0x22c0
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
    bots = function_bd48ef10(team, count, origin, spawnangles[1], roleindex);
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
    println("<dev string:x10f>" + botarg + "<dev string:x133>" + var_c6e7a9ca + "<dev string:x133>" + origin[0] + "<dev string:x133>" + origin[1] + "<dev string:x133>" + origin[2] + "<dev string:x133>" + spawnangles[1]);
}

// Namespace bot_devgui/bot_devgui
// Params 5, eflags: 0x4
// Checksum 0x11a9bf54, Offset: 0x2668
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
    bots = function_bd48ef10(team, count, origin, angle, roleindex);
}

// Namespace bot_devgui/bot_devgui
// Params 5, eflags: 0x4
// Checksum 0xd1efe538, Offset: 0x2808
// Size: 0x1aa
function private function_bd48ef10(team, count, origin, yaw, roleindex) {
    bots = [];
    if (!isdefined(bots)) {
        bots = [];
    } else if (!isarray(bots)) {
        bots = array(bots);
    }
    bots[bots.size] = self bot::add_fixed_spawn_bot(team, origin, yaw, roleindex);
    /#
        spiral = dev::function_a4ccb933(origin, yaw);
        for (i = 0; i < count - 1; i++) {
            dev::function_df0b6f84(spiral);
            origin = dev::function_98c05766(spiral);
            angle = dev::function_4783f10c(spiral);
            if (!isdefined(bots)) {
                bots = [];
            } else if (!isarray(bots)) {
                bots = array(bots);
            }
            bots[bots.size] = self bot::add_fixed_spawn_bot(team, origin, angle, roleindex);
        }
    #/
    return bots;
}

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0xd3e4a1fc, Offset: 0x29c0
// Size: 0xd2
function private function_881d3aa(host, botarg) {
    if (botarg == "all") {
        return #"none";
    }
    if (isdefined(level.teams[botarg])) {
        return level.teams[botarg];
    }
    friendlyteam = #"allies";
    if (isdefined(host) && host.team != #"spectator") {
        friendlyteam = host.team;
    }
    if (botarg == "friendly") {
        return friendlyteam;
    }
    return function_8dbb49c0(friendlyteam);
}

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0xa1aa8d9c, Offset: 0x2aa0
// Size: 0x100
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

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0x16e7c9fc, Offset: 0x2ba8
// Size: 0xb8
function private devgui_remove_bots(host, botarg) {
    bots = function_9a819607(host, botarg);
    foreach (bot in bots) {
        level thread bot::remove_bot(bot);
    }
}

// Namespace bot_devgui/bot_devgui
// Params 3, eflags: 0x4
// Checksum 0xfd264787, Offset: 0x2c68
// Size: 0xb6
function private devgui_ignoreall(host, botarg, cmdarg) {
    bots = function_9a819607(host, botarg);
    foreach (bot in bots) {
        bot.ignoreall = cmdarg;
    }
}

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0xffb306de, Offset: 0x2d28
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

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0xebc853ff, Offset: 0x2ec0
// Size: 0x132
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
    case #"add_forced":
        self function_93996ae6(botarg);
        return;
    case #"me":
        self set_goal_ent(botarg, self);
        return;
    case #"clear":
        self function_be8f790e(botarg);
        return;
    }
}

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0x17ffc268, Offset: 0x3000
// Size: 0x2d8
function private set_goal(botarg, force = 0) {
    trace = self eye_trace(1);
    pos = trace[#"position"];
    if (force) {
        pos = getclosestpointonnavmesh(pos, 16, 16);
        if (!isdefined(pos)) {
            return;
        }
    }
    bots = function_9a819607(self, botarg);
    vehicle = isvehicle(trace[#"entity"]) ? trace[#"entity"] : undefined;
    foreach (bot in bots) {
        bot notify(#"hash_7597caa242064632");
        bot botreleasemanualcontrol();
        bot setgoal(pos, force);
        bot.goalradius = 512;
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

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0xbb9a63f1, Offset: 0x32e0
// Size: 0x148
function private function_417ef9e7(botarg) {
    trace = self eye_trace(1);
    bots = function_9a819607(self, botarg);
    pos = trace[#"position"];
    point = getclosesttacpoint(pos);
    if (!isdefined(point)) {
        return;
    }
    foreach (bot in bots) {
        bot notify(#"hash_7597caa242064632");
        bot botreleasemanualcontrol();
        bot setgoal(point.region);
    }
}

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0x67ed0c8, Offset: 0x3430
// Size: 0x160
function private set_goal_ent(botarg, ent) {
    bots = function_9a819607(self, botarg);
    foreach (bot in bots) {
        bot notify(#"hash_7597caa242064632");
        bot botreleasemanualcontrol();
        bot setgoal(ent);
        bot.goalradius = 96;
        if (bot isinvehicle()) {
            vehicle = bot getvehicleoccupied();
            seatindex = vehicle getoccupantseat(bot);
            vehicle usevehicle(bot, seatindex);
        }
    }
}

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0xe4d27a82, Offset: 0x3598
// Size: 0xc0
function private function_be8f790e(botarg) {
    bots = function_9a819607(self, botarg);
    foreach (bot in bots) {
        bot notify(#"hash_7597caa242064632");
        bot clearforcedgoal();
    }
}

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0xb1a1289a, Offset: 0x3660
// Size: 0x1b8
function private function_93996ae6(botarg) {
    trace = self eye_trace(1);
    pos = trace[#"position"];
    pos = getclosestpointonnavmesh(pos, 16, 16);
    if (!isdefined(pos)) {
        return;
    }
    bots = function_9a819607(self, botarg);
    foreach (bot in bots) {
        goals = bot.bot.var_bdb21e1f;
        if (isdefined(goals)) {
            goals[goals.size] = pos;
            continue;
        }
        goals = [];
        bot.bot.var_bdb21e1f = goals;
        info = bot function_4794d6a3();
        if (info.goalforced) {
            goals[goals.size] = info.goalpos;
        }
        goals[goals.size] = pos;
        bot function_cc8c642a(goals);
    }
}

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0x61575ab4, Offset: 0x3820
// Size: 0xbc
function private function_cc8c642a(&goals) {
    self endoncallback(&function_bc3bbe26, #"death", #"hash_7597caa242064632");
    for (i = 0; true; i = (i + 1) % goals.size) {
        self setgoal(goals[i], 1);
        while (goals.size <= 1) {
            waitframe(1);
        }
        self waittill(#"goal");
    }
}

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0xd546e042, Offset: 0x38e8
// Size: 0x1a
function private function_bc3bbe26(*notifyhash) {
    self.bot.var_bdb21e1f = undefined;
}

// Namespace bot_devgui/bot_devgui
// Params 4, eflags: 0x4
// Checksum 0xaa145001, Offset: 0x3910
// Size: 0x140
function private devgui_force_button(host, botarg, cmdarg, toggle) {
    bots = function_9a819607(host, botarg);
    foreach (bot in bots) {
        if (!isdefined(bot.bot.var_458ddbc0)) {
            bot.bot.var_458ddbc0 = [];
        }
        forcebits = bot.bot.var_458ddbc0;
        if (toggle) {
            forcebits[cmdarg] = is_true(forcebits[cmdarg]) ? undefined : 1;
            continue;
        }
        forcebits[cmdarg] = 2;
    }
}

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0x5e0baed1, Offset: 0x3a58
// Size: 0xb6
function private function_baee1142(host, botarg) {
    bots = function_9a819607(host, botarg);
    foreach (bot in bots) {
        bot.bot.var_458ddbc0 = [];
    }
}

// Namespace bot_devgui/bot_devgui
// Params 4, eflags: 0x4
// Checksum 0x17b3a9eb, Offset: 0x3b18
// Size: 0x120
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

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0x87b255d7, Offset: 0x3c40
// Size: 0xd2
function private function_b24b9a1e(inventorytype, offhandslot) {
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        if (weapon.inventorytype == inventorytype && weapon.offhandslot == offhandslot) {
            return weapon;
        }
    }
    return undefined;
}

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0xa6a4fd6d, Offset: 0x3d20
// Size: 0xf8
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

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0x1c4dd341, Offset: 0x3e20
// Size: 0x1dc
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

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0x4249f6be, Offset: 0x4008
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

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0x8cbab8d8, Offset: 0x41b8
// Size: 0xb0
function private function_30f27f9f(botarg) {
    bots = function_9a819607(self, botarg);
    foreach (bot in bots) {
        bot thread function_2e08087e(self);
    }
}

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0x169c93c3, Offset: 0x4270
// Size: 0xce
function private function_b037d12d(botarg) {
    bots = function_9a819607(self, botarg);
    foreach (bot in bots) {
        bot notify(#"hash_1fc88ab5756d805");
        bot.bot.var_5efe88e4 = bot getplayerangles();
    }
}

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0xd8dd9d86, Offset: 0x4348
// Size: 0xbe
function private function_f419ffae(botarg) {
    bots = function_9a819607(self, botarg);
    foreach (bot in bots) {
        bot notify(#"hash_1fc88ab5756d805");
        bot.bot.var_5efe88e4 = undefined;
    }
}

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0x7869f78a, Offset: 0x4410
// Size: 0x11a
function private function_2e08087e(player) {
    self endon(#"death", #"disconnect", #"hash_1fc88ab5756d805", #"hash_6280ac8ed281ce3c");
    while (isdefined(player) && isalive(player)) {
        angles = player getplayerangles();
        yawoffset = getdvarint(#"hash_68c18f3309126669", 0) * 15;
        var_6cd5d6b6 = angles + (0, yawoffset, 0);
        self.bot.var_5efe88e4 = angleclamp180(var_6cd5d6b6);
        waitframe(1);
    }
    self.bot.var_5efe88e4 = undefined;
}

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x0
// Checksum 0xf09ae36, Offset: 0x4538
// Size: 0xe8
function devgui_tpose(host, botarg) {
    bots = function_9a819607(host, botarg);
    foreach (bot in bots) {
        setdvar(#"bg_boastenabled", 1);
        bot function_c6775cf9("dev_boast_tpose");
    }
}

// Namespace bot_devgui/bot_devgui
// Params 3, eflags: 0x4
// Checksum 0xa69c99dc, Offset: 0x4628
// Size: 0x118
function private devgui_invulnerable(host, botarg, cmdarg) {
    bots = function_9a819607(host, botarg);
    foreach (bot in bots) {
        if (cmdarg == "on") {
            bot val::set(#"devgui", "takedamage", 0);
            continue;
        }
        bot val::reset(#"devgui", "takedamage");
    }
}

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0x2e9af2eb, Offset: 0x4748
// Size: 0x140
function private devgui_kill_bots(host, botarg) {
    bots = function_9a819607(host, botarg);
    foreach (bot in bots) {
        if (!isalive(bot)) {
            continue;
        }
        bot val::set(#"devgui_kill", "takedamage", 1);
        bot dodamage(bot.health + 1000, bot.origin);
        bot val::reset(#"devgui_kill", "takedamage");
    }
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0x22822c00, Offset: 0x4890
// Size: 0x180
function private function_263ca697() {
    weapon = self getcurrentweapon();
    weaponoptions = self function_ade49959(weapon);
    var_e91aba42 = self function_8cbd254d(weapon);
    /#
        setdvar(#"bot_spawn_weapon", getweaponname(weapon.rootweapon));
        setdvar(#"hash_c6e51858c88a5ee", util::function_2146bd83(weapon));
    #/
    bots = get_bots();
    foreach (bot in bots) {
        bot function_35e77034(weapon, weaponoptions, var_e91aba42);
    }
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0xab7e3d4b, Offset: 0x4a18
// Size: 0xbc
function private function_78a14db2() {
    weapon = undefined;
    if (getdvarstring(#"bot_spawn_weapon", "") != "") {
        weapon = util::get_weapon_by_name(getdvarstring(#"bot_spawn_weapon"), getdvarstring(#"hash_c6e51858c88a5ee"));
        if (isdefined(weapon)) {
            self function_35e77034(weapon);
        }
    }
}

// Namespace bot_devgui/bot_devgui
// Params 3, eflags: 0x4
// Checksum 0x971bf9c7, Offset: 0x4ae0
// Size: 0xb4
function private function_35e77034(weapon, weaponoptions, var_e91aba42) {
    if (!isdefined(weapon) || weapon == level.weaponnone) {
        return;
    }
    self function_85e7342b();
    self giveweapon(weapon, weaponoptions, var_e91aba42);
    self givemaxammo(weapon);
    self switchtoweaponimmediate(weapon);
    self setspawnweapon(weapon);
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0x6200b976, Offset: 0x4ba0
// Size: 0xa8
function private function_85e7342b() {
    weapons = self getweaponslistprimaries();
    foreach (weapon in weapons) {
        self takeweapon(weapon);
    }
}

// Namespace bot_devgui/bot_devgui
// Params 2, eflags: 0x4
// Checksum 0x168349a9, Offset: 0x4c50
// Size: 0xea
function private eye_trace(hitents = 0, var_18daeece = 0) {
    angles = self getplayerangles();
    fwd = anglestoforward(angles);
    var_98b02a87 = self getplayerviewheight();
    eye = self.origin + (0, 0, var_98b02a87);
    end = eye + fwd * 8000;
    return bullettrace(eye, end, hitents, self, var_18daeece);
}

// Namespace bot_devgui/bot_devgui
// Params 0, eflags: 0x4
// Checksum 0xd08e4f6b, Offset: 0x4d48
// Size: 0x46
function private function_59842621() {
    trace = self eye_trace(1);
    targetentity = trace[#"entity"];
    return targetentity;
}

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0x78be607f, Offset: 0x4d98
// Size: 0x118
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

// Namespace bot_devgui/bot_devgui
// Params 1, eflags: 0x4
// Checksum 0x5cbefa42, Offset: 0x4eb8
// Size: 0xf8
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

