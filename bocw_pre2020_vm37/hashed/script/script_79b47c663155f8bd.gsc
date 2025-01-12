#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_shared;

#namespace namespace_ffbf548b;

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 0, eflags: 0x1 linked
// Checksum 0x69bc05d0, Offset: 0xb0
// Size: 0x1f0
function function_70a657d8() {
    callback::on_start_gametype(&on_start_gametype);
    level.var_f5c1fb9d = [];
    /#
        botfill = getdvarint(#"botfill", 0);
        if (botfill > 0) {
            level.var_fa9f5bab = botfill;
            return;
        }
    #/
    foreach (team, teamstr in level.teams) {
        count = getgametypesetting("botmax" + teamstr);
        count = isdefined(getgametypesetting("bot_" + teamstr)) ? getgametypesetting("bot_" + teamstr) : count;
        /#
            if (!isdefined(count) || count == 0) {
                count = getdvarint("<dev string:x38>" + teamstr, 0);
                count = getdvarint("<dev string:x42>" + teamstr, count);
            }
        #/
        if (isdefined(count) && count > 0) {
            level.var_f5c1fb9d[team] = count;
        }
    }
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 0, eflags: 0x5 linked
// Checksum 0xb63b3dca, Offset: 0x2a8
// Size: 0x6c
function private on_start_gametype() {
    if (is_true(level.rankedmatch)) {
        return;
    }
    botsoak = getdvarint(#"sv_botsoak", 0);
    level thread function_31a989f7(!botsoak);
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 1, eflags: 0x5 linked
// Checksum 0x6ff573fc, Offset: 0x320
// Size: 0x16c
function private function_31a989f7(waitforplayers = 1) {
    level endon(#"game_ended");
    if (waitforplayers) {
        level flag::wait_till("all_players_connected");
    }
    waitframe(1);
    /#
        if (isdefined(level.var_fa9f5bab) && level.var_fa9f5bab > 0) {
            bot::add_bots(level.var_fa9f5bab);
            return;
        }
    #/
    if (level.teambased) {
        level thread function_bbeb8bbe();
        return;
    }
    var_8a291590 = 0;
    foreach (teamcount in level.var_f5c1fb9d) {
        var_8a291590 += teamcount;
    }
    level thread function_9bead880(var_8a291590);
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 0, eflags: 0x5 linked
// Checksum 0xab19e9f6, Offset: 0x498
// Size: 0x6e
function private function_bbeb8bbe() {
    level endon(#"game_ended", #"remove_bot");
    maxteamplayers = player::function_d36b6597();
    while (true) {
        function_38a06234(maxteamplayers);
        waitframe(1);
    }
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 1, eflags: 0x5 linked
// Checksum 0xe5e9946e, Offset: 0x510
// Size: 0x126
function private function_9bead880(var_8a291590) {
    level endon(#"game_ended", #"remove_bot");
    while (true) {
        players = getplayers();
        if (players.size < level.teams.size) {
            botcount = 0;
            foreach (player in players) {
                if (player istestclient()) {
                    botcount++;
                }
            }
            if (botcount < var_8a291590) {
                level bot::add_bot();
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 1, eflags: 0x5 linked
// Checksum 0xc1991cd1, Offset: 0x640
// Size: 0x212
function private function_38a06234(maxteamplayers = 0) {
    var_b4f40f83 = undefined;
    var_25bb1ac1 = undefined;
    foreach (team, str in level.teams) {
        count = level.var_f5c1fb9d[team];
        if (!isdefined(count)) {
            continue;
        }
        players = getplayers(team);
        if (maxteamplayers > 0 && players.size >= maxteamplayers) {
            continue;
        }
        if (isdefined(var_25bb1ac1) && players.size >= var_25bb1ac1) {
            continue;
        }
        var_e047c8ff = 0;
        foreach (player in players) {
            if (player istestclient()) {
                var_e047c8ff++;
            }
        }
        if (var_e047c8ff >= count) {
            continue;
        }
        var_b4f40f83 = team;
        var_25bb1ac1 = players.size;
    }
    if (!isdefined(var_b4f40f83)) {
        return false;
    }
    bot = bot::add_bot(var_b4f40f83);
    return isdefined(bot);
}

