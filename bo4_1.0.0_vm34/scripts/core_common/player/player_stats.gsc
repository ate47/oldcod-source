#using scripts\core_common\util_shared;

#namespace stats;

/#

    // Namespace stats/player_stats
    // Params 2, eflags: 0x0
    // Checksum 0xd6bed16c, Offset: 0x70
    // Size: 0x124
    function function_d0a8636e(result, vararg) {
        if (!isdefined(result)) {
            pathstr = ishash(vararg[0]) ? function_15979fa9(vararg[0]) : vararg[0];
            if (!isdefined(pathstr)) {
                return;
            }
            for (i = 1; i < vararg.size; i++) {
                pathstr = pathstr + "<dev string:x30>" + (ishash(vararg[i]) ? function_15979fa9(vararg[i]) : vararg[i]);
            }
            println("<dev string:x32>" + pathstr);
        }
    }

#/

// Namespace stats/player_stats
// Params 0, eflags: 0x0
// Checksum 0x11113080, Offset: 0x1a0
// Size: 0xa6
function function_752728() {
    player = self;
    assert(isplayer(player), "<dev string:x4d>");
    if (isbot(player) || isdefined(level.disablestattracking) && level.disablestattracking || isdefined(level.nopersistence) && level.nopersistence) {
        return false;
    }
    return true;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x20 variadic
// Checksum 0x519a8eac, Offset: 0x250
// Size: 0xc0
function get_stat(...) {
    assert(vararg.size > 0);
    if (vararg.size == 0) {
        return undefined;
    }
    player = self;
    assert(isplayer(player), "<dev string:x4d>");
    result = player readstat(vararg);
    /#
        function_d0a8636e(result, vararg);
    #/
    return result;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x20 variadic
// Checksum 0x89b04cc0, Offset: 0x318
// Size: 0x11c
function set_stat(...) {
    assert(vararg.size > 1);
    if (vararg.size <= 1) {
        return;
    }
    if (!function_752728()) {
        return;
    }
    player = self;
    assert(isplayer(player), "<dev string:x76>");
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = player writestat(vararg, value);
    /#
        function_d0a8636e(result, vararg);
    #/
}

// Namespace stats/player_stats
// Params 1, eflags: 0x20 variadic
// Checksum 0x5da3deb3, Offset: 0x440
// Size: 0x11c
function inc_stat(...) {
    assert(vararg.size > 1);
    if (vararg.size <= 1) {
        return;
    }
    if (!function_752728()) {
        return;
    }
    player = self;
    assert(isplayer(player), "<dev string:x76>");
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = player incrementstat(vararg, value);
    /#
        function_d0a8636e(result, vararg);
    #/
}

// Namespace stats/player_stats
// Params 1, eflags: 0x0
// Checksum 0x97c63193, Offset: 0x568
// Size: 0x52
function function_3774f22d(statname) {
    return self get_stat(#"playerstatsbygametype", util::get_gametype_name(), statname, #"statvalue");
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x417fd71a, Offset: 0x5c8
// Size: 0x74
function function_a296ab19(statname, value) {
    if (!function_752728()) {
        return;
    }
    self set_stat(#"playerstatsbygametype", util::get_gametype_name(), statname, #"statvalue", value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0xcaa4c941, Offset: 0x648
// Size: 0x74
function function_5396eef9(statname, value) {
    if (!function_752728()) {
        return;
    }
    self inc_stat(#"playerstatsbygametype", util::get_gametype_name(), statname, #"statvalue", value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0xa595e79d, Offset: 0x6c8
// Size: 0x4c
function function_d7e9dd79(statname, value) {
    if (!function_752728()) {
        return;
    }
    self set_stat(#"afteractionreportstats", statname, value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0xb44d4686, Offset: 0x720
// Size: 0xa4
function function_93b148d7(statname, value) {
    if (!function_752728()) {
        return;
    }
    gametype = util::get_gametype_name();
    map = util::get_map_name();
    self inc_stat(#"mapstats", map, #"permode", gametype, statname, value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0xb29a8bea, Offset: 0x7d0
// Size: 0x84
function set_stat_global(statname, value) {
    if (!function_752728()) {
        return;
    }
    if (sessionmodeiswarzonegame()) {
        function_a296ab19(statname, value);
    }
    self set_stat(#"playerstatslist", statname, #"statvalue", value);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x0
// Checksum 0xae3bdae9, Offset: 0x860
// Size: 0x62
function get_stat_global(statname) {
    if (sessionmodeiswarzonegame()) {
        return function_3774f22d(statname);
    }
    return self get_stat(#"playerstatslist", statname, #"statvalue");
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x4f19a9da, Offset: 0x8d0
// Size: 0x84
function set_stat_challenge(statname, value) {
    if (!function_752728()) {
        return;
    }
    if (sessionmodeiswarzonegame()) {
        function_a296ab19(statname, value);
    }
    self set_stat(#"playerstatslist", statname, #"challengevalue", value);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x0
// Checksum 0xf60e501b, Offset: 0x960
// Size: 0x3a
function get_stat_challenge(statname) {
    return self get_stat(#"playerstatslist", statname, #"challengevalue");
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0xc3a8567, Offset: 0x9a8
// Size: 0x84
function function_b48aa4e(statname, value) {
    if (!function_752728()) {
        return;
    }
    if (sessionmodeiswarzonegame()) {
        function_5396eef9(statname, value);
    }
    self inc_stat(#"playerstatslist", statname, #"statvalue", value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0xc50b12a7, Offset: 0xa38
// Size: 0x5c
function function_2dabbec7(statname, value) {
    self function_b48aa4e(statname, value);
    if (!sessionmodeiswarzonegame()) {
        self function_5396eef9(statname, value);
    }
}

// Namespace stats/player_stats
// Params 6, eflags: 0x0
// Checksum 0x28a3a184, Offset: 0xaa0
// Size: 0x8c
function function_c8a05f4f(weapon, statname, value, classnum, pickedup, forceads) {
    if (isdefined(level.var_722f7267)) {
        [[ level.var_722f7267 ]](self, weapon, statname, value);
    }
    self addweaponstat(weapon, statname, value, classnum, pickedup, forceads);
}

// Namespace stats/player_stats
// Params 3, eflags: 0x0
// Checksum 0x36233eb2, Offset: 0xb38
// Size: 0x44
function function_4f10b697(weapon, statname, value) {
    self function_c8a05f4f(weapon, statname, value, undefined, undefined, undefined);
}

