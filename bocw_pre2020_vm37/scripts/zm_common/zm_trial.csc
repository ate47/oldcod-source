#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace zm_trial;

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x6
// Checksum 0xf365b71, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x5 linked
// Checksum 0x7bf883dc, Offset: 0x128
// Size: 0x34
function private function_70a657d8() {
    if (!is_trial_mode()) {
        return;
    }
    level.var_c556bb2e = [];
    function_4dbf2663();
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x661b1daa, Offset: 0x168
// Size: 0x98
function function_d02ffd(name) {
    foreach (var_6d87ac05 in level.var_c556bb2e) {
        if (var_6d87ac05.name == name) {
            return var_6d87ac05;
        }
    }
    return undefined;
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x1 linked
// Checksum 0xe7296e1e, Offset: 0x208
// Size: 0x48
function function_ce2fdd3b(index) {
    if (isdefined(level.var_c556bb2e) && isdefined(level.var_c556bb2e[index])) {
        return level.var_c556bb2e[index];
    }
    return undefined;
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x1 linked
// Checksum 0x2a976f2, Offset: 0x258
// Size: 0x12
function is_trial_mode() {
    return zm_utility::is_trials();
}

// Namespace zm_trial/zm_trial
// Params 3, eflags: 0x1 linked
// Checksum 0xf695af7e, Offset: 0x278
// Size: 0xb8
function register_challenge(name, var_c5dd8620, var_bbcdbff5) {
    if (!isdefined(level.var_75e93a54)) {
        level.var_75e93a54 = [];
    }
    assert(!isdefined(level.var_75e93a54[name]));
    info = {#name:name, #var_c5dd8620:var_c5dd8620, #var_bbcdbff5:var_bbcdbff5};
    level.var_75e93a54[name] = info;
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x1 linked
// Checksum 0x2f10a4af, Offset: 0x338
// Size: 0xc0
function function_a36e8c38(name) {
    if (is_trial_mode() && isdefined(level.var_1420e3f6)) {
        foreach (active_challenge in level.var_1420e3f6.challenges) {
            if (active_challenge.name == name) {
                return active_challenge;
            }
        }
    }
    return undefined;
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x5 linked
// Checksum 0xbe4937d8, Offset: 0x400
// Size: 0x44c
function private function_4dbf2663() {
    var_3b363b7a = getgametypesetting(#"zmtrialsvariant");
    if (isdefined(var_3b363b7a) && var_3b363b7a > 0) {
        table = hash("gamedata/tables/zm/" + util::get_map_name() + "_trials_variant_" + var_3b363b7a + ".csv");
    } else {
        table = hash("gamedata/tables/zm/" + util::get_map_name() + "_trials.csv");
    }
    column_count = tablelookupcolumncount(table);
    var_e1617d73 = tablelookuprowcount(table);
    row = 0;
    while (row < var_e1617d73) {
        var_189d26ca = tablelookupcolumnforrow(table, row, 1);
        assert(!isdefined(function_d02ffd(var_189d26ca)));
        var_6d87ac05 = {#name:var_189d26ca, #rounds:[], #index:level.var_c556bb2e.size};
        level.var_c556bb2e[level.var_c556bb2e.size] = var_6d87ac05;
        do {
            row++;
            round = tablelookupcolumnforrow(table, row, 0);
            if (row < var_e1617d73 && round != 0) {
                round_index = round - 1;
                if (!isdefined(var_6d87ac05.rounds[round_index])) {
                    var_6d87ac05.rounds[round_index] = {};
                    round_info = var_6d87ac05.rounds[round_index];
                    round_info.name = tablelookupcolumnforrow(table, row, 1);
                    round_info.round = round;
                    round_info.name_str = tablelookupcolumnforrow(table, row, 2);
                    round_info.desc_str = tablelookupcolumnforrow(table, row, 3);
                    round_info.challenges = [];
                }
                assert(isdefined(var_6d87ac05.rounds[round_index]));
                round_info = var_6d87ac05.rounds[round_index];
                challenge_name = tablelookupcolumnforrow(table, row, 5);
                var_10a28798 = [];
                array::add(round_info.challenges, {#name:challenge_name, #row:row, #params:var_10a28798});
                for (i = 0; i < 8; i++) {
                    param = tablelookupcolumnforrow(table, row, 6 + i);
                    if (isdefined(param) && param != #"") {
                        var_10a28798[var_10a28798.size] = param;
                    }
                }
            }
        } while (row < var_e1617d73 && round != 0);
    }
    level.var_6d87ac05 = level.var_c556bb2e[0];
}

