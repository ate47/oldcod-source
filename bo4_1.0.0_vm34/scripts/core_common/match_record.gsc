#using scripts\core_common\array_shared;

#namespace match_record;

/#

    // Namespace match_record/match_record
    // Params 2, eflags: 0x0
    // Checksum 0xf3248b23, Offset: 0x70
    // Size: 0x132
    function function_d0a8636e(result, vararg) {
        pathstr = "<dev string:x30>";
        if (!isdefined(result)) {
            for (i = 0; i < vararg.size; i++) {
                if (isarray(vararg[i])) {
                    pathstr = pathstr + "<dev string:x31>" + function_d0a8636e(result, vararg[i]);
                    continue;
                }
                pathstr = pathstr + "<dev string:x31>" + (ishash(vararg[i]) ? function_15979fa9(vararg[i]) : vararg[i]);
            }
            println("<dev string:x33>" + pathstr);
        }
        return pathstr;
    }

#/

// Namespace match_record/match_record
// Params 1, eflags: 0x20 variadic
// Checksum 0xcdc3f497, Offset: 0x1b0
// Size: 0x80
function get_stat(...) {
    assert(vararg.size > 0);
    if (vararg.size == 0) {
        return undefined;
    }
    result = readmatchstat(vararg);
    /#
        function_d0a8636e(result, vararg);
    #/
    return result;
}

// Namespace match_record/match_record
// Params 1, eflags: 0x20 variadic
// Checksum 0xccd7fb3e, Offset: 0x238
// Size: 0xd8
function set_stat(...) {
    assert(vararg.size > 1);
    if (vararg.size <= 1) {
        return;
    }
    if (isbot(self)) {
        return;
    }
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = writematchstat(vararg, value);
    /#
        function_d0a8636e(result, vararg);
    #/
    return result;
}

// Namespace match_record/match_record
// Params 1, eflags: 0x20 variadic
// Checksum 0x71a3651a, Offset: 0x318
// Size: 0x144
function function_3fad861b(...) {
    vec = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    vec_0 = set_stat(vararg, 0, int(vec[0]));
    vec_1 = set_stat(vararg, 1, int(vec[1]));
    vec_2 = set_stat(vararg, 2, int(vec[2]));
    return isdefined(vec_0) && vec_0 && isdefined(vec_1) && vec_1 && isdefined(vec_2) && vec_2;
}

// Namespace match_record/match_record
// Params 1, eflags: 0x20 variadic
// Checksum 0x2bf809a1, Offset: 0x468
// Size: 0xc0
function inc_stat(...) {
    assert(vararg.size > 1);
    if (vararg.size <= 1) {
        return;
    }
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = incrementmatchstat(vararg, value);
    /#
        function_d0a8636e(result, vararg);
    #/
    return result;
}

// Namespace match_record/match_record
// Params 1, eflags: 0x20 variadic
// Checksum 0x97a4aa5, Offset: 0x530
// Size: 0x8c
function get_player_stat(...) {
    player = self;
    assert(isplayer(player));
    if (isplayer(player)) {
        return get_stat(#"players", player.clientid, vararg);
    }
}

// Namespace match_record/match_record
// Params 1, eflags: 0x20 variadic
// Checksum 0x61a5ed7b, Offset: 0x5c8
// Size: 0xcc
function set_player_stat(...) {
    player = self;
    assert(isplayer(player));
    if (isplayer(player)) {
        value = vararg[vararg.size - 1];
        arrayremoveindex(vararg, vararg.size - 1);
        return set_stat(#"players", player.clientid, vararg, value);
    }
}

// Namespace match_record/match_record
// Params 1, eflags: 0x20 variadic
// Checksum 0xe573b52b, Offset: 0x6a0
// Size: 0x196
function function_de67a991(...) {
    player = self;
    assert(isplayer(player));
    if (isplayer(player)) {
        vec = vararg[vararg.size - 1];
        arrayremoveindex(vararg, vararg.size - 1);
        vec_0 = set_player_stat(vararg, 0, int(vec[0]));
        vec_1 = set_player_stat(vararg, 1, int(vec[1]));
        vec_2 = set_player_stat(vararg, 2, int(vec[2]));
        return (isdefined(vec_0) && vec_0 && isdefined(vec_1) && vec_1 && isdefined(vec_2) && vec_2);
    }
}

// Namespace match_record/match_record
// Params 1, eflags: 0x20 variadic
// Checksum 0xc0a5c8c2, Offset: 0x840
// Size: 0xcc
function function_dfe977ee(...) {
    player = self;
    assert(isplayer(player));
    if (isplayer(player)) {
        value = vararg[vararg.size - 1];
        arrayremoveindex(vararg, vararg.size - 1);
        return inc_stat(#"players", player.clientid, vararg, value);
    }
}

