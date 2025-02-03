#using scripts\core_common\util_shared;
#using scripts\weapons\weapons;

#namespace stats;

/#

    // Namespace stats/player_stats
    // Params 2, eflags: 0x0
    // Checksum 0x8c673b98, Offset: 0x70
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
// Params 0, eflags: 0x0
// Checksum 0x316fca3, Offset: 0x180
// Size: 0xd0
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
    if (isbot(player) || is_true(level.disablestattracking)) {
        return false;
    }
    return true;
}

// Namespace stats/player_stats
// Params 0, eflags: 0x0
// Checksum 0x728eec4, Offset: 0x258
// Size: 0xe
function function_8921af36() {
    return level.var_12323003;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x20 variadic
// Checksum 0x3b8a2c6a, Offset: 0x270
// Size: 0xce
function get_stat(...) {
    assert(vararg.size > 0);
    if (vararg.size == 0) {
        return 0;
    }
    result = 0;
    if (isdefined(self)) {
        assert(isplayer(self), "<dev string:x5b>");
        result = self readstat(0, vararg);
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
// Params 1, eflags: 0x20 variadic
// Checksum 0x72b05a8f, Offset: 0x348
// Size: 0xc0
function function_e3eb9a8b(...) {
    assert(vararg.size > 0);
    if (vararg.size == 0) {
        return 0;
    }
    result = 0;
    if (isdefined(self)) {
        assert(isplayer(self), "<dev string:x87>");
        result = self readstat(1, vararg);
        /#
            function_d92cb558(result, vararg);
        #/
    }
    return result;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x20 variadic
// Checksum 0xee15e153, Offset: 0x410
// Size: 0xc0
function function_6d50f14b(...) {
    assert(vararg.size > 0);
    if (vararg.size == 0) {
        return 0;
    }
    result = 0;
    if (isdefined(self)) {
        assert(isplayer(self), "<dev string:xba>");
        result = self readstat(3, vararg);
        /#
            function_d92cb558(result, vararg);
        #/
    }
    return result;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x20 variadic
// Checksum 0xf51ac6ab, Offset: 0x4d8
// Size: 0xc0
function function_ff8f4f17(...) {
    assert(vararg.size > 0);
    if (vararg.size == 0) {
        return 0;
    }
    result = 0;
    if (isdefined(self)) {
        assert(isplayer(self), "<dev string:xee>");
        result = self readstat(4, vararg);
        /#
            function_d92cb558(result, vararg);
        #/
    }
    return result;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x20 variadic
// Checksum 0xa5af5641, Offset: 0x5a0
// Size: 0x13a
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
        assert(isplayer(self), "<dev string:x124>");
        value = vararg[vararg.size - 1];
        arrayremoveindex(vararg, vararg.size - 1);
        result = self writestat(0, vararg, value);
        /#
            function_d92cb558(result, vararg);
        #/
    }
    return is_true(result);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x20 variadic
// Checksum 0x36e13b30, Offset: 0x6e8
// Size: 0x13a
function function_505387a6(...) {
    assert(vararg.size > 1);
    if (vararg.size <= 1) {
        return 0;
    }
    if (!function_f94325d3()) {
        return 0;
    }
    result = 0;
    if (isdefined(self)) {
        assert(isplayer(self), "<dev string:x124>");
        value = vararg[vararg.size - 1];
        arrayremoveindex(vararg, vararg.size - 1);
        result = self writestat(1, vararg, value);
        /#
            function_d92cb558(result, vararg);
        #/
    }
    return is_true(result);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x20 variadic
// Checksum 0xb10a049c, Offset: 0x830
// Size: 0x15a
function inc_stat(...) {
    assert(vararg.size > 1);
    if (vararg.size <= 1) {
        return;
    }
    if (!function_f94325d3()) {
        return;
    }
    player = self;
    assert(isplayer(player), "<dev string:x124>");
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = player incrementstat(0, vararg, value);
    /#
        function_d92cb558(result, vararg);
    #/
    return is_true(result);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x20 variadic
// Checksum 0x9a81f3d4, Offset: 0x998
// Size: 0x15a
function function_f5859f81(...) {
    assert(vararg.size > 1);
    if (vararg.size <= 1) {
        return;
    }
    if (!function_f94325d3()) {
        return;
    }
    player = self;
    assert(isplayer(player), "<dev string:x124>");
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = player incrementstat(1, vararg, value);
    /#
        function_d92cb558(result, vararg);
    #/
    return is_true(result);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x4
// Checksum 0x81dae274, Offset: 0xb00
// Size: 0x104
function private function_e6106f3b(statname, value) {
    self set_stat(#"playerstatsbygametype", function_8921af36(), statname, #"statvalue", value);
    self set_stat(#"playerstatsbygametype", function_8921af36(), statname, #"challengevalue", value);
    self set_stat(#"playerstatslist", statname, #"statvalue", value);
    self set_stat(#"playerstatslist", statname, #"challengevalue", value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x4
// Checksum 0x32451de3, Offset: 0xc10
// Size: 0x70
function private function_1d354b96(statname, value) {
    var_44becfa9 = self inc_stat(#"playerstatslist", statname, #"statvalue", value);
    self addgametypestat(statname, value);
    return var_44becfa9;
}

// Namespace stats/player_stats
// Params 1, eflags: 0x0
// Checksum 0x78f5d418, Offset: 0xc88
// Size: 0x52
function function_ed81f25e(statname) {
    return self get_stat(#"playerstatsbygametype", util::get_gametype_name(), statname, #"statvalue");
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x5eaa1365, Offset: 0xce8
// Size: 0x48
function function_baa25a23(statname, value) {
    if (!function_f94325d3()) {
        return false;
    }
    self addgametypestat(statname, value);
    return true;
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0xe3acbb4d, Offset: 0xd38
// Size: 0x48
function function_d40764f3(statname, value) {
    if (!function_f94325d3()) {
        return false;
    }
    self addgametypestat(statname, value);
    return true;
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x156f2211, Offset: 0xd88
// Size: 0x52
function function_7a850245(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    return self set_stat(#"afteractionreportstats", statname, value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x1c7ea9e9, Offset: 0xde8
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
// Checksum 0x8d0face1, Offset: 0xff0
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
// Checksum 0x69d5fa47, Offset: 0x11f8
// Size: 0xca
function function_81f5c0fe(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    gametype = level.var_12323003;
    map = util::get_map_name();
    mapstats = gamemodeisarena() ? #"mapstatsarena" : #"mapstats";
    return self inc_stat(mapstats, map, #"permode", gametype, statname, value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0xbf536c0d, Offset: 0x12d0
// Size: 0xa2
function set_stat_global(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    if (sessionmodeiscampaigngame()) {
        return self function_505387a6(#"playerstatslist", statname, #"statvalue", value);
    }
    return self set_stat(#"playerstatslist", statname, #"statvalue", value);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x0
// Checksum 0xfe0394b5, Offset: 0x1380
// Size: 0x7a
function get_stat_global(statname) {
    if (sessionmodeiscampaigngame()) {
        return self function_e3eb9a8b(#"playerstatslist", statname, #"statvalue");
    }
    return self get_stat(#"playerstatslist", statname, #"statvalue");
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x4010d13b, Offset: 0x1408
// Size: 0x5a
function set_stat_challenge(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    return self set_stat(#"playerstatslist", statname, #"challengevalue", value);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x0
// Checksum 0xf27eaa33, Offset: 0x1470
// Size: 0x3a
function get_stat_challenge(statname) {
    return self get_stat(#"playerstatslist", statname, #"challengevalue");
}

// Namespace stats/player_stats
// Params 1, eflags: 0x0
// Checksum 0x355eebc9, Offset: 0x14b8
// Size: 0x3a
function function_af5584ca(statname) {
    return self get_stat(#"playerstatslist", statname, #"challengetier");
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x202afaed, Offset: 0x1500
// Size: 0x5a
function function_8e071909(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    return self set_stat(#"playerstatslist", statname, #"challengetier", value);
}

// Namespace stats/player_stats
// Params 1, eflags: 0x0
// Checksum 0x278ba264, Offset: 0x1568
// Size: 0x52
function function_878e75b7(statname) {
    return self get_stat(#"playerstatsbygametype", util::get_gametype_name(), statname, #"challengevalue");
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x6c66da4e, Offset: 0x15c8
// Size: 0xa2
function function_dad108fa(statname, value) {
    if (!function_f94325d3()) {
        return 0;
    }
    if (sessionmodeiscampaigngame()) {
        return self function_f5859f81(#"playerstatslist", statname, #"statvalue", value);
    }
    return self inc_stat(#"playerstatslist", statname, #"statvalue", value);
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x20c97e36, Offset: 0x1678
// Size: 0x52
function function_bb7eedf0(statname, value) {
    setglobal = self function_dad108fa(statname, value);
    return self addgametypestat(statname, value);
}

// Namespace stats/player_stats
// Params 6, eflags: 0x0
// Checksum 0x483ec3fa, Offset: 0x16d8
// Size: 0x13a
function function_eec52333(weapon, statname, value, classnum, pickedup, forceads) {
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
// Params 3, eflags: 0x0
// Checksum 0x76c7ed9f, Offset: 0x1820
// Size: 0x3c
function function_e24eec31(weapon, statname, value) {
    self function_eec52333(weapon, statname, value, undefined, undefined, undefined);
}

