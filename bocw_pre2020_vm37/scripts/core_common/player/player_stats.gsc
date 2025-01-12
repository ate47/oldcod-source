#using scripts\core_common\util_shared;
#using scripts\weapons\weapons;

#namespace stats;

/#

    // Namespace stats/player_stats
    // Params 2, eflags: 0x0
    // Checksum 0xb37d5660, Offset: 0x80
    // Size: 0x104
    function function_d92cb558(result, vararg) {
        if (!isdefined(result)) {
            pathstr = ishash(vararg[0]) ? function_9e72a96(vararg[0]) : vararg[0];
            if (!isdefined(pathstr)) {
                return;
            }
            for (i = 1; i < vararg.size; i++) {
                pathstr = pathstr + "<dev string:x38>" + (ishash(vararg[i]) ? function_9e72a96(vararg[i]) : vararg[i]);
            }
            println("<dev string:x3d>" + pathstr);
        }
    }

#/

// Namespace stats/player_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x7530ff4b, Offset: 0x190
// Size: 0x16a
function function_f94325d3() {
    player = self;
    assert(isplayer(player), "<dev string:x5b>");
    if (sessionmodeiscampaigngame()) {
        return true;
    }
    if (sessionmodeiszombiesgame()) {
        if (level.gametype === #"doa") {
            return true;
        }
    }
    if (isbot(player) || is_true(level.disablestattracking) || !is_true(level.rankedmatch)) {
        return false;
    }
    if (sessionmodeiswarzonegame()) {
        if (getdvarint(#"scr_disable_merits", 0) == 1) {
            return false;
        }
        if (!isdefined(game.state) || game.state == "pregame") {
            return false;
        }
    }
    return true;
}

// Namespace stats/player_stats
// Params 0, eflags: 0x1 linked
// Checksum 0x532101a9, Offset: 0x308
// Size: 0xe
function function_8921af36() {
    return level.var_12323003;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x21 linked variadic
// Checksum 0xd26ffc33, Offset: 0x320
// Size: 0xce
function get_stat(...) {
    assert(vararg.size > 0);
    if (vararg.size == 0) {
        return 0;
    }
    result = 0;
    if (isdefined(self)) {
        assert(isplayer(self), "<dev string:x5b>");
        result = self readstat(vararg);
        /#
            function_d92cb558(result, vararg);
        #/
    }
    if (!isdefined(result)) {
        result = 0;
    }
    return result;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x21 linked variadic
// Checksum 0x1d3dd640, Offset: 0x3f8
// Size: 0xc0
function function_6d50f14b(...) {
    assert(vararg.size > 0);
    if (vararg.size == 0) {
        return 0;
    }
    result = 0;
    if (isdefined(self)) {
        assert(isplayer(self), "<dev string:x87>");
        result = self function_c3462d90(vararg);
        /#
            function_d92cb558(result, vararg);
        #/
    }
    return result;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x21 linked variadic
// Checksum 0xe949c2b4, Offset: 0x4c0
// Size: 0xc0
function function_ff8f4f17(...) {
    assert(vararg.size > 0);
    if (vararg.size == 0) {
        return 0;
    }
    result = 0;
    if (isdefined(self)) {
        assert(isplayer(self), "<dev string:xbb>");
        result = self function_24c32cb1(vararg);
        /#
            function_d92cb558(result, vararg);
        #/
    }
    return result;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x21 linked variadic
// Checksum 0x63e7a859, Offset: 0x588
// Size: 0x132
function set_stat(...) {
    assert(vararg.size > 1);
    if (vararg.size <= 1) {
        return 0;
    }
    if (!function_f94325d3()) {
        return 0;
    }
    result = 0;
    if (isdefined(self)) {
        assert(isplayer(self), "<dev string:xf1>");
        value = vararg[vararg.size - 1];
        arrayremoveindex(vararg, vararg.size - 1);
        result = self writestat(vararg, value);
        /#
            function_d92cb558(result, vararg);
        #/
    }
    return is_true(result);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x21 linked variadic
// Checksum 0xb1c53c15, Offset: 0x6c8
// Size: 0x152
function inc_stat(...) {
    assert(vararg.size > 1);
    if (vararg.size <= 1) {
        return;
    }
    if (!function_f94325d3()) {
        return;
    }
    player = self;
    assert(isplayer(player), "<dev string:xf1>");
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = player incrementstat(vararg, value);
    /#
        function_d92cb558(result, vararg);
    #/
    return is_true(result);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x5 linked
// Checksum 0x911f1a06, Offset: 0x828
// Size: 0x104
function private function_e6106f3b(statname, value) {
    self set_stat(#"playerstatsbygametype", function_8921af36(), statname, #"statvalue", value);
    self set_stat(#"playerstatsbygametype", function_8921af36(), statname, #"challengevalue", value);
    self set_stat(#"playerstatslist", statname, #"statvalue", value);
    self set_stat(#"playerstatslist", statname, #"challengevalue", value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x5 linked
// Checksum 0xffb8fdf4, Offset: 0x938
// Size: 0x70
function private function_1d354b96(statname, value) {
    var_44becfa9 = self inc_stat(#"playerstatslist", statname, #"statvalue", value);
    self addgametypestat(statname, value);
    return var_44becfa9;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x0
// Checksum 0x1c7e7e69, Offset: 0x9b0
// Size: 0x52
function function_ed81f25e(statname) {
    return self get_stat(#"playerstatsbygametype", util::get_gametype_name(), statname, #"statvalue");
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x4f5ba6e2, Offset: 0xa10
// Size: 0x7a
function function_baa25a23(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    if (sessionmodeiswarzonegame()) {
        function_e6106f3b(statname, value);
        return;
    }
    self addgametypestat(statname, value);
    return 1;
}

// Namespace stats/player_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xa6adcd9d, Offset: 0xa98
// Size: 0x7a
function function_d40764f3(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    if (sessionmodeiswarzonegame()) {
        return function_1d354b96(statname, value);
    }
    self addgametypestat(statname, value);
    return 1;
}

// Namespace stats/player_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x715ded41, Offset: 0xb20
// Size: 0x52
function function_7a850245(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    return self set_stat(#"afteractionreportstats", statname, value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x4800fe3a, Offset: 0xb80
// Size: 0x1fc
function function_62b271d8(statname, value) {
    if (!sessionmodeiswarzonegame()) {
        return;
    }
    teammates = getplayers(self.team);
    foreach (player in teammates) {
        if (!player function_f94325d3()) {
            continue;
        }
        teammatecount = get_stat(#"afteractionreportstats", #"teammatecount");
        if (!isdefined(teammatecount)) {
            return;
        }
        playerxuid = int(self getxuid(1));
        for (i = 0; i < teammatecount; i++) {
            var_bd8d01a8 = player get_stat(#"afteractionreportstats", #"teammates", i, #"xuid");
            if (var_bd8d01a8 === playerxuid) {
                player set_stat(#"afteractionreportstats", #"teammates", i, statname, value);
                break;
            }
        }
    }
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x4cedc715, Offset: 0xd88
// Size: 0x1fc
function function_b7f80d87(statname, value) {
    if (!sessionmodeiswarzonegame()) {
        return;
    }
    teammates = getplayers(self.team);
    foreach (player in teammates) {
        if (!player function_f94325d3()) {
            continue;
        }
        teammatecount = get_stat(#"afteractionreportstats", #"teammatecount");
        if (!isdefined(teammatecount)) {
            return;
        }
        playerxuid = int(self getxuid(1));
        for (i = 0; i < teammatecount; i++) {
            var_bd8d01a8 = player get_stat(#"afteractionreportstats", #"teammates", i, #"xuid");
            if (var_bd8d01a8 === playerxuid) {
                player inc_stat(#"afteractionreportstats", #"teammates", i, statname, value);
                break;
            }
        }
    }
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0xb4c4cac1, Offset: 0xf90
// Size: 0xe2
function function_81f5c0fe(statname, value) {
    if (!function_f94325d3() || sessionmodeiswarzonegame()) {
        return 0;
    }
    gametype = level.var_12323003;
    map = util::get_map_name();
    mapstats = gamemodeisarena() ? #"mapstatsarena" : #"mapstats";
    return self inc_stat(mapstats, map, #"permode", gametype, statname, value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x8845e7d2, Offset: 0x1080
// Size: 0x82
function set_stat_global(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    if (sessionmodeiswarzonegame()) {
        return function_e6106f3b(statname, value);
    }
    return self set_stat(#"playerstatslist", statname, #"statvalue", value);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xc3bb8a0b, Offset: 0x1110
// Size: 0x3a
function get_stat_global(statname) {
    return self get_stat(#"playerstatslist", statname, #"statvalue");
}

// Namespace stats/player_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xf78c079d, Offset: 0x1158
// Size: 0x5a
function set_stat_challenge(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    return self set_stat(#"playerstatslist", statname, #"challengevalue", value);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x1 linked
// Checksum 0xb73f9e57, Offset: 0x11c0
// Size: 0x3a
function get_stat_challenge(statname) {
    return self get_stat(#"playerstatslist", statname, #"challengevalue");
}

// Namespace stats/player_stats
// Params 1, eflags: 0x1 linked
// Checksum 0x436d49fa, Offset: 0x1208
// Size: 0x3a
function function_af5584ca(statname) {
    return self get_stat(#"playerstatslist", statname, #"challengetier");
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x50e2c3e6, Offset: 0x1250
// Size: 0x5a
function function_8e071909(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    return self set_stat(#"playerstatslist", statname, #"challengetier", value);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x0
// Checksum 0x5bda08a7, Offset: 0x12b8
// Size: 0x52
function function_878e75b7(statname) {
    return self get_stat(#"playerstatsbygametype", util::get_gametype_name(), statname, #"challengevalue");
}

// Namespace stats/player_stats
// Params 2, eflags: 0x1 linked
// Checksum 0xaebfa451, Offset: 0x1318
// Size: 0x82
function function_dad108fa(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    if (sessionmodeiswarzonegame()) {
        return function_1d354b96(statname, value);
    }
    return self inc_stat(#"playerstatslist", statname, #"statvalue", value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x1 linked
// Checksum 0x448cd41f, Offset: 0x13a8
// Size: 0x82
function function_bb7eedf0(statname, value) {
    if (sessionmodeiswarzonegame()) {
        return self function_1d354b96(statname, value);
    }
    setglobal = self function_dad108fa(statname, value);
    return self addgametypestat(statname, value);
}

// Namespace stats/player_stats
// Params 6, eflags: 0x1 linked
// Checksum 0x850b3440, Offset: 0x1438
// Size: 0x16a
function function_eec52333(weapon, statname, value, classnum, pickedup, forceads) {
    if (sessionmodeiswarzonegame() && game.state == "pregame") {
        return;
    }
    if (sessionmodeiszombiesgame() && level.zm_disable_recording_stats === 1) {
        return;
    }
    if (isdefined(level.var_b10e134d)) {
        [[ level.var_b10e134d ]](self, weapon, statname, value);
    }
    self addweaponstat(weapon, statname, value, classnum, pickedup, forceads);
    switch (statname) {
    case #"shots":
    case #"used":
        self function_f95ea9b6(weapon);
        break;
    case #"kills":
        if (weapon.var_ff0b00ba) {
            self function_dad108fa(#"kills_equipment", 1);
        }
        break;
    }
}

// Namespace stats/player_stats
// Params 3, eflags: 0x1 linked
// Checksum 0x2b15fefb, Offset: 0x15b0
// Size: 0x3c
function function_e24eec31(weapon, statname, value) {
    self function_eec52333(weapon, statname, value, undefined, undefined, undefined);
}

