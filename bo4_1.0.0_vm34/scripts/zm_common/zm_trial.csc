#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial;

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x2
// Checksum 0x71550922, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial", &__init__, undefined, undefined);
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x0
// Checksum 0xc82887f2, Offset: 0xd8
// Size: 0x3c
function __init__() {
    if (!is_trial_mode()) {
        return;
    }
    level.var_e096cfb3 = [];
    function_333f194f();
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x8aaa6aa6, Offset: 0x120
// Size: 0x8c
function function_29ac39b6(name) {
    foreach (var_f0a67892 in level.var_e096cfb3) {
        if (var_f0a67892.name == name) {
            return var_f0a67892;
        }
    }
    return undefined;
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0xc9e183af, Offset: 0x1b8
// Size: 0x48
function function_9e924db7(index) {
    if (isdefined(level.var_e096cfb3) && isdefined(level.var_e096cfb3[index])) {
        return level.var_e096cfb3[index];
    }
    return undefined;
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x0
// Checksum 0xcb7a3407, Offset: 0x208
// Size: 0x22
function is_trial_mode() {
    return level flag::exists(#"ztrial");
}

// Namespace zm_trial/zm_trial
// Params 3, eflags: 0x0
// Checksum 0xaf5ecebf, Offset: 0x238
// Size: 0xbe
function register_challenge(name, var_5f7c5b3, var_640416df) {
    if (!isdefined(level.var_e63b8d85)) {
        level.var_e63b8d85 = [];
    }
    assert(!isdefined(level.var_e63b8d85[name]));
    info = {#name:name, #var_5f7c5b3:var_5f7c5b3, #var_640416df:var_640416df};
    level.var_e63b8d85[name] = info;
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x564ed384, Offset: 0x300
// Size: 0xb4
function function_871c1f7f(name) {
    if (is_trial_mode() && isdefined(level.var_a790dc75)) {
        foreach (active_challenge in level.var_a790dc75.challenges) {
            if (active_challenge.name == name) {
                return active_challenge;
            }
        }
    }
    return undefined;
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x4
// Checksum 0x78953733, Offset: 0x3c0
// Size: 0x416
function private function_333f194f() {
    table = #"hash_25cc5a6f4fbdfbd9";
    column_count = tablelookupcolumncount(table);
    var_2b0fb6af = tablelookuprowcount(table);
    row = 0;
    while (row < var_2b0fb6af) {
        var_9f99900f = tablelookupcolumnforrow(table, row, 1);
        assert(!isdefined(function_29ac39b6(var_9f99900f)));
        var_f0a67892 = {#name:var_9f99900f, #rounds:[], #index:level.var_e096cfb3.size};
        level.var_e096cfb3[level.var_e096cfb3.size] = var_f0a67892;
        do {
            row++;
            round = tablelookupcolumnforrow(table, row, 0);
            if (row < var_2b0fb6af && round != 0) {
                round_index = round - 1;
                if (!isdefined(var_f0a67892.rounds[round_index])) {
                    var_f0a67892.rounds[round_index] = {};
                    round_info = var_f0a67892.rounds[round_index];
                    round_info.name = tablelookupcolumnforrow(table, row, 1);
                    round_info.round = round;
                    round_info.name_str = tablelookupcolumnforrow(table, row, 2);
                    round_info.desc_str = tablelookupcolumnforrow(table, row, 3);
                    round_info.var_f45cb194 = tablelookupcolumnforrow(table, row, 4);
                    round_info.challenges = [];
                }
                assert(isdefined(var_f0a67892.rounds[round_index]));
                round_info = var_f0a67892.rounds[round_index];
                challenge_name = tablelookupcolumnforrow(table, row, 5);
                var_61365c91 = [];
                array::add(round_info.challenges, {#name:challenge_name, #row:row, #params:var_61365c91});
                for (i = 0; i < 8; i++) {
                    param = tablelookupcolumnforrow(table, row, 6 + i);
                    if (isdefined(param) && param != #"") {
                        var_61365c91[var_61365c91.size] = param;
                    }
                }
            }
        } while (row < var_2b0fb6af && round != 0);
    }
    level.var_f0a67892 = level.var_e096cfb3[0];
}

