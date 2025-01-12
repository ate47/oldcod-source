#using scripts\core_common\array_shared;

#namespace match_record;

/#

    // Namespace match_record/match_record
    // Params 2, eflags: 0x0
    // Checksum 0x9208e160, Offset: 0x68
    // Size: 0x38
    function function_d92cb558(result, *vararg) {
        pathstr = "<dev string:x38>";
        if (isdefined(vararg)) {
        }
        return pathstr;
    }

#/

// Namespace match_record/match_record
// Params 1, eflags: 0x21 linked variadic
// Checksum 0x2691d7a1, Offset: 0xa8
// Size: 0x80
function get_stat(...) {
    assert(vararg.size > 0);
    if (vararg.size == 0) {
        return undefined;
    }
    result = readmatchstat(vararg);
    /#
        function_d92cb558(result, vararg);
    #/
    return result;
}

// Namespace match_record/match_record
// Params 1, eflags: 0x21 linked variadic
// Checksum 0x15d3996d, Offset: 0x130
// Size: 0xc0
function set_stat(...) {
    assert(vararg.size > 1);
    if (vararg.size <= 1) {
        return;
    }
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = writematchstat(vararg, value);
    /#
        function_d92cb558(result, vararg);
    #/
    return result;
}

// Namespace match_record/match_record
// Params 1, eflags: 0x21 linked variadic
// Checksum 0x1eba33a3, Offset: 0x1f8
// Size: 0x14c
function function_7a93acec(...) {
    vec = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    vec_0 = set_stat(vararg, 0, int(vec[0]));
    vec_1 = set_stat(vararg, 1, int(vec[1]));
    vec_2 = set_stat(vararg, 2, int(vec[2]));
    return is_true(vec_0) && is_true(vec_1) && is_true(vec_2);
}

// Namespace match_record/match_record
// Params 1, eflags: 0x21 linked variadic
// Checksum 0xfc1a6316, Offset: 0x350
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
        function_d92cb558(result, vararg);
    #/
    return result;
}

// Namespace match_record/match_record
// Params 0, eflags: 0x0
// Checksum 0xd7012ab3, Offset: 0x418
// Size: 0x70
function get_player_index() {
    player = self;
    assert(isplayer(player));
    if (isplayer(player) && isdefined(player.clientid)) {
        return player.clientid;
    }
}

// Namespace match_record/match_record
// Params 1, eflags: 0x21 linked variadic
// Checksum 0x212af82e, Offset: 0x490
// Size: 0x8c
function get_player_stat(...) {
    player = self;
    assert(isplayer(player));
    if (isplayer(player)) {
        return get_stat(#"players", player.clientid, vararg);
    }
}

// Namespace match_record/match_record
// Params 1, eflags: 0x21 linked variadic
// Checksum 0xeedda5a1, Offset: 0x528
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
// Params 1, eflags: 0x21 linked variadic
// Checksum 0xc3bc278b, Offset: 0x600
// Size: 0x19e
function function_ded5f5b6(...) {
    player = self;
    assert(isplayer(player));
    if (isplayer(player)) {
        vec = vararg[vararg.size - 1];
        arrayremoveindex(vararg, vararg.size - 1);
        vec_0 = set_player_stat(vararg, 0, int(vec[0]));
        vec_1 = set_player_stat(vararg, 1, int(vec[1]));
        vec_2 = set_player_stat(vararg, 2, int(vec[2]));
        return (is_true(vec_0) && is_true(vec_1) && is_true(vec_2));
    }
}

// Namespace match_record/match_record
// Params 1, eflags: 0x21 linked variadic
// Checksum 0x7f423722, Offset: 0x7a8
// Size: 0xcc
function function_34800eec(...) {
    player = self;
    assert(isplayer(player));
    if (isplayer(player)) {
        value = vararg[vararg.size - 1];
        arrayremoveindex(vararg, vararg.size - 1);
        return inc_stat(#"players", player.clientid, vararg, value);
    }
}

