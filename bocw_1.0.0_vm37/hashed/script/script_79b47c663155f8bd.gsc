#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;

#namespace namespace_ffbf548b;

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 0, eflags: 0x0
// Checksum 0x9a5ed2d9, Offset: 0x98
// Size: 0x180
function preinit() {
    callback::on_start_gametype(&on_start_gametype);
    level.var_f5c1fb9d = [];
    level.var_8a530af5 = [];
    /#
        botfill = getdvarint(#"botfill", 0);
        if (botfill > 0) {
            level.var_fa9f5bab = botfill;
            return;
        }
    #/
    foreach (team, teamstr in level.teams) {
        autofill = getgametypesetting(#"hash_43e6eb8f9fd14f92" + teamstr, 0);
        level.var_8a530af5[team] = autofill;
        count = getdvarint(#"bot_" + teamstr, 0);
        level.var_f5c1fb9d[team] = count;
    }
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 0, eflags: 0x4
// Checksum 0x3316bbce, Offset: 0x220
// Size: 0x6c
function private on_start_gametype() {
    if (is_true(level.rankedmatch)) {
        return;
    }
    botsoak = getdvarint(#"sv_botsoak", 0);
    level thread function_31a989f7(!botsoak);
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 0, eflags: 0x4
// Checksum 0xafcae817, Offset: 0x298
// Size: 0x174
function private function_8958c312() {
    /#
        if (function_7373cc35()) {
            return;
        }
    #/
    if (level.teambased) {
        foreach (team in level.teams) {
            level.var_f5c1fb9d[team] = is_true(level.var_8a530af5[team]) ? getplayers(team).size : function_b16926ea(team).size;
        }
        return;
    }
    level.var_f5c1fb9d[#"allies"] = is_true(level.var_8a530af5[#"allies"]) ? getplayers().size : function_b16926ea().size;
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 0, eflags: 0x4
// Checksum 0x22fb4890, Offset: 0x418
// Size: 0xec
function private function_ba1ef25b() {
    if (level.teambased) {
        foreach (team in level.teams) {
            level.var_f5c1fb9d[team] = 6;
            level.var_8a530af5[team] = 1;
        }
        return;
    }
    level.var_f5c1fb9d[#"allies"] = 8;
    level.var_8a530af5[#"allies"] = 1;
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 1, eflags: 0x4
// Checksum 0x51c0286c, Offset: 0x510
// Size: 0x214
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
    if (is_true(getgametypesetting(#"hash_c6a2e6c3e86125a"))) {
        level function_ba1ef25b();
    } else {
        level function_8958c312();
    }
    if (level.teambased) {
        foreach (count in level.var_f5c1fb9d) {
            if (count > 0) {
                level thread function_bbeb8bbe();
                break;
            }
        }
        return;
    }
    var_8a291590 = isdefined(level.var_f5c1fb9d[#"allies"]) ? level.var_f5c1fb9d[#"allies"] : 0;
    if (var_8a291590 > 0) {
        level thread function_9bead880(var_8a291590);
    }
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 0, eflags: 0x4
// Checksum 0x5f9ef04d, Offset: 0x730
// Size: 0xde
function private function_bbeb8bbe() {
    level endon(#"game_ended", #"remove_bot");
    if (getgametypesetting(#"hash_c6a2e6c3e86125a") && level.teamcount > 0) {
        maxteamplayers = 12;
    }
    maxplayers = getdvarint(#"com_maxclients", 0);
    while (true) {
        if (getplayers().size < maxplayers) {
            function_38a06234();
        }
        waitframe(1);
    }
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 1, eflags: 0x4
// Checksum 0x12018e20, Offset: 0x818
// Size: 0xbe
function private function_9bead880(var_8a291590) {
    level endon(#"game_ended", #"remove_bot");
    while (true) {
        players = getplayers();
        bots = function_b16926ea();
        if (players.size < level.teams.size && bots.size < var_8a291590) {
            level bot::add_bot();
        }
        waitframe(1);
    }
}

// Namespace namespace_ffbf548b/namespace_ffbf548b
// Params 0, eflags: 0x4
// Checksum 0xc2cd31ee, Offset: 0x8e0
// Size: 0x18e
function private function_38a06234() {
    var_4ec52f78 = undefined;
    var_dd1b756e = undefined;
    foreach (team, count in level.var_f5c1fb9d) {
        if (!isdefined(count) || count <= 0) {
            continue;
        }
        players = getplayers(team);
        if (isdefined(var_dd1b756e) && players.size >= var_dd1b756e) {
            continue;
        }
        if (is_true(level.var_8a530af5[team]) && players.size >= count) {
            continue;
        }
        bots = function_b16926ea(team);
        if (bots.size >= count) {
            continue;
        }
        var_4ec52f78 = team;
        var_dd1b756e = players.size;
    }
    if (!isdefined(var_4ec52f78)) {
        return;
    }
    bot = bot::add_bot(var_4ec52f78);
}

