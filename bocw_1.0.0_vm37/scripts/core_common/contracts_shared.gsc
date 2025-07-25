#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace contracts;

// Namespace contracts/contracts_shared
// Params 0, eflags: 0x6
// Checksum 0x3646df30, Offset: 0x78
// Size: 0x2c
function private autoexec __init__system__() {
    system::register(#"contracts_shared", undefined, undefined, undefined, undefined);
}

// Namespace contracts/contracts_shared
// Params 0, eflags: 0x0
// Checksum 0x1b304588, Offset: 0xb0
// Size: 0x3c
function init_player_contract_events() {
    if (!isdefined(level.player_contract_events)) {
        level.player_contract_events = [];
    }
    if (!isdefined(level.contract_ids)) {
        level.contract_ids = [];
    }
}

// Namespace contracts/contracts_shared
// Params 3, eflags: 0x0
// Checksum 0xaee94fa7, Offset: 0xf8
// Size: 0xf8
function register_player_contract_event(event_name, event_func, max_param_count = 0) {
    if (!isdefined(level.player_contract_events[event_name])) {
        level.player_contract_events[event_name] = spawnstruct();
        level.player_contract_events[event_name].param_count = max_param_count;
        level.player_contract_events[event_name].events = [];
    }
    assert(max_param_count == level.player_contract_events[event_name].param_count);
    level.player_contract_events[event_name].events[level.player_contract_events[event_name].events.size] = event_func;
}

// Namespace contracts/contracts_shared
// Params 4, eflags: 0x0
// Checksum 0x52f2f2eb, Offset: 0x1f8
// Size: 0x35a
function player_contract_event(event_name, param1 = undefined, param2 = undefined, param3 = undefined) {
    if (!isdefined(level.player_contract_events[event_name])) {
        return;
    }
    param_count = isdefined(level.player_contract_events[event_name].param_count) ? level.player_contract_events[event_name].param_count : 0;
    switch (param_count) {
    case 0:
    default:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]]();
            }
        }
        break;
    case 1:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]](param1);
            }
        }
        break;
    case 2:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]](param1, param2);
            }
        }
        break;
    case 3:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]](param1, param2, param3);
            }
        }
        break;
    }
}

// Namespace contracts/contracts_shared
// Params 2, eflags: 0x0
// Checksum 0x9d7dadeb, Offset: 0x560
// Size: 0x3a
function get_contract_stat(slot, stat_name) {
    return self stats::get_stat(#"contracts", slot, stat_name);
}

// Namespace contracts/contracts_shared
// Params 1, eflags: 0x0
// Checksum 0x1b538408, Offset: 0x5a8
// Size: 0x224
function function_d17bcd3c(slot) {
    player = self;
    var_5ceb23d0 = spawnstruct();
    var_5ceb23d0.var_38280f2f = #"hash_6a1133003efe7380";
    var_5ceb23d0.var_59cb904f = 0;
    var_5ceb23d0.var_c3e2bb05 = 0;
    var_38280f2f = player stats::function_ff8f4f17(#"loot_contracts", slot, #"contracthash");
    if (!getdvarint(#"hash_d233413e805fbd0", 0)) {
        var_38280f2f = hash(var_38280f2f);
    }
    if (var_38280f2f != #"") {
        var_5ceb23d0.var_38280f2f = var_38280f2f;
        var_5ceb23d0.target_value = player stats::function_ff8f4f17(#"loot_contracts", slot, #"target");
        var_5ceb23d0.var_59cb904f = player stats::function_ff8f4f17(#"loot_contracts", slot, #"progress");
        var_5ceb23d0.var_c3e2bb05 = player stats::function_ff8f4f17(#"loot_contracts", slot, #"contractgamemode");
        var_5ceb23d0.xp = player stats::function_ff8f4f17(#"loot_contracts", slot, #"xp");
        level.contract_ids[var_38280f2f] = player stats::function_ff8f4f17(#"loot_contracts", slot, #"contractid");
    }
    return var_5ceb23d0;
}

// Namespace contracts/contracts_shared
// Params 1, eflags: 0x0
// Checksum 0x7ee80e54, Offset: 0x7d8
// Size: 0xf0
function function_de4ff5a(slot) {
    player = self;
    var_38280f2f = player stats::function_ff8f4f17(#"loot_contracts", slot, #"contracthash");
    if (!getdvarint(#"hash_d233413e805fbd0", 0)) {
        var_38280f2f = hash(var_38280f2f);
    }
    if (var_38280f2f != #"") {
        level.contract_ids[var_38280f2f] = player stats::function_ff8f4f17(#"loot_contracts", slot, #"contractid");
    }
}

// Namespace contracts/contracts_shared
// Params 2, eflags: 0x0
// Checksum 0x8274c67c, Offset: 0x8d0
// Size: 0x22e
function setup_player_contracts(max_contract_slots, var_1b3f5772) {
    player = self;
    if (isdefined(player.pers[#"contracts"])) {
        for (slot = 0; slot < max_contract_slots; slot++) {
            player function_de4ff5a(slot);
        }
        return;
    }
    if (isbot(player)) {
        return;
    }
    if (!isdefined(var_1b3f5772)) {
        var_1b3f5772 = &function_d17bcd3c;
    }
    if (!isdefined(player.pers[#"contracts"])) {
        player.pers[#"contracts"] = [];
    }
    player.pers[#"hash_5651f00c6c1790a4"] = self stats::get_stat_global(#"time_played_total");
    for (slot = 0; slot < max_contract_slots; slot++) {
        var_5ceb23d0 = player [[ var_1b3f5772 ]](slot);
        if (!isdefined(var_5ceb23d0)) {
            continue;
        }
        if (!isstruct(var_5ceb23d0)) {
            continue;
        }
        var_38280f2f = var_5ceb23d0.var_38280f2f;
        if (var_38280f2f == #"hash_6a1133003efe7380") {
            continue;
        }
        if (isdefined(level.var_c3e2bb05) && isdefined(var_5ceb23d0.var_c3e2bb05) && level.var_c3e2bb05 != var_5ceb23d0.var_c3e2bb05 && var_5ceb23d0.var_c3e2bb05 != 5) {
            continue;
        }
        var_5ceb23d0.var_38280f2f = undefined;
        var_5ceb23d0.var_c3e2bb05 = undefined;
        player.pers[#"contracts"][var_38280f2f] = var_5ceb23d0;
    }
}

// Namespace contracts/contracts_shared
// Params 1, eflags: 0x0
// Checksum 0x82170a75, Offset: 0xb08
// Size: 0x84
function is_contract_active(var_38280f2f) {
    if (!isdefined(var_38280f2f)) {
        return false;
    }
    if (!isplayer(self)) {
        return false;
    }
    if (!isdefined(self.pers[#"contracts"])) {
        return false;
    }
    if (!isdefined(self.pers[#"contracts"][var_38280f2f])) {
        return false;
    }
    return true;
}

// Namespace contracts/contracts_shared
// Params 2, eflags: 0x0
// Checksum 0x7d8ba380, Offset: 0xb98
// Size: 0x58
function increment_contract(var_38280f2f, delta = 1) {
    if (self is_contract_active(var_38280f2f)) {
        self [[ level.var_79a93566 ]](var_38280f2f, delta);
    }
}

/#

    // Namespace contracts/contracts_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7b2bd059, Offset: 0xbf8
    // Size: 0xfe
    function function_5e1c4d33(var_5ceb23d0) {
        player = self;
        if (isbot(player)) {
            return;
        }
        if (!isdefined(player.pers[#"contracts"])) {
            player.pers[#"contracts"] = [];
        }
        if (!isstruct(var_5ceb23d0)) {
            return;
        }
        var_38280f2f = var_5ceb23d0.var_38280f2f;
        if (var_38280f2f == #"hash_6a1133003efe7380") {
            player.pers[#"contracts"][var_38280f2f] = undefined;
            return;
        }
        var_5ceb23d0.var_38280f2f = undefined;
        player.pers[#"contracts"][var_38280f2f] = var_5ceb23d0;
    }

    // Namespace contracts/contracts_shared
    // Params 2, eflags: 0x0
    // Checksum 0xb39ca5b4, Offset: 0xd00
    // Size: 0xec
    function function_e07e542b(var_1d89ece6, var_300afbc8) {
        level thread watch_contract_debug(var_300afbc8);
        function_a781ee84(var_1d89ece6);
        util::function_3f749abc(var_1d89ece6 + "<dev string:x38>", "<dev string:x57>");
        util::function_3f749abc(var_1d89ece6 + "<dev string:x78>", "<dev string:x9b>");
        util::function_3f749abc(var_1d89ece6 + "<dev string:xc0>", "<dev string:xcc>");
        util::function_3f749abc(var_1d89ece6 + "<dev string:xe8>", "<dev string:xf5>");
    }

    // Namespace contracts/contracts_shared
    // Params 1, eflags: 0x0
    // Checksum 0xffefbe23, Offset: 0xdf8
    // Size: 0x12c
    function function_a781ee84(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:x111>";
        var_c8d599b5 = "<dev string:x13b>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:x161>", var_c8d599b5 + 2);
        util::function_3f749abc(var_78a6fb52 + "<dev string:x168>", var_c8d599b5 + 5);
        util::function_3f749abc(var_78a6fb52 + "<dev string:x16f>", var_c8d599b5 + 10);
        util::function_3f749abc(var_78a6fb52 + "<dev string:x177>", var_c8d599b5 + 100);
        util::function_3f749abc(var_78a6fb52 + "<dev string:x180>", var_c8d599b5 + 1000);
        util::function_3f749abc(var_78a6fb52 + "<dev string:x18a>", var_c8d599b5 + 0);
    }

    // Namespace contracts/contracts_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd101b84, Offset: 0xf30
    // Size: 0x84
    function watch_contract_debug(var_300afbc8) {
        level notify(#"watch_contract_debug_singleton");
        level endon(#"watch_contract_debug_singleton", #"game_ended");
        while (true) {
            profilestart();
            function_33bab9aa();
            if (isdefined(var_300afbc8)) {
                [[ var_300afbc8 ]]();
            }
            profilestop();
            wait 0.5;
        }
    }

    // Namespace contracts/contracts_shared
    // Params 0, eflags: 0x0
    // Checksum 0x42337cf5, Offset: 0xfc0
    // Size: 0x554
    function function_33bab9aa() {
        if (getdvarint(#"hash_7c0db43f4c0bff69", 0) > 0) {
            if (isdefined(level.players)) {
                foreach (player in level.players) {
                    if (!isdefined(player)) {
                        continue;
                    }
                    if (isbot(player)) {
                        continue;
                    }
                    if (isdefined(player.pers) && isdefined(player.pers[#"contracts"])) {
                        player.pers[#"contracts"] = undefined;
                    }
                    iprintln("<dev string:x194>" + player.name);
                }
            }
            setdvar(#"hash_7c0db43f4c0bff69", 0);
        }
        if (getdvarint(#"hash_23bd356dbd92a9e2", 0) > 0) {
            if (isdefined(level.players)) {
                foreach (player in level.players) {
                    if (!isdefined(player)) {
                        continue;
                    }
                    if (isbot(player)) {
                        continue;
                    }
                    if (isdefined(player.pers) && isdefined(player.pers[#"contracts"])) {
                        player function_78083139();
                    }
                    iprintln("<dev string:x1bd>" + player.name);
                }
            }
            setdvar(#"hash_23bd356dbd92a9e2", 0);
        }
        if (getdvarstring(#"hash_4e7103a8bd2b97f6", "<dev string:x1e4>") != "<dev string:x1e4>") {
            if (isdefined(level.players)) {
                var_f029d0d7 = getdvarstring(#"hash_4e7103a8bd2b97f6", "<dev string:x1e4>");
                foreach (player in level.players) {
                    if (!isdefined(player)) {
                        continue;
                    }
                    if (isbot(player)) {
                        continue;
                    }
                    var_61525c00 = spawnstruct();
                    var_61525c00.var_38280f2f = hash(var_f029d0d7);
                    var_61525c00.target_value = 8;
                    var_61525c00.var_59cb904f = 0;
                    player function_5e1c4d33(var_61525c00);
                    iprintln("<dev string:x1e8>" + var_f029d0d7 + "<dev string:x200>" + player.name + "<dev string:x209>");
                }
            }
            setdvar(#"hash_4e7103a8bd2b97f6", "<dev string:x1e4>");
        }
        if (getdvarint(#"scr_contract_msg_front_end_only", 0) > 0) {
            iprintln("<dev string:x21e>");
            setdvar(#"scr_contract_msg_front_end_only", 0);
        }
        if (getdvarint(#"scr_contract_msg_debug_on", 0) > 0) {
            iprintln("<dev string:x251>");
            setdvar(#"scr_contract_msg_debug_on", 0);
        }
    }

#/

// Namespace contracts/contracts_shared
// Params 0, eflags: 0x0
// Checksum 0xafec4f5a, Offset: 0x1520
// Size: 0xa0
function function_d3fba20e() {
    players = getplayers();
    foreach (player in players) {
        player function_78083139();
    }
}

// Namespace contracts/contracts_shared
// Params 0, eflags: 0x0
// Checksum 0x9c4689b7, Offset: 0x15c8
// Size: 0x56a
function function_78083139() {
    player = self;
    if (!isplayer(player)) {
        return;
    }
    if (isbot(player)) {
        return;
    }
    if (!isdefined(player.pers)) {
        return;
    }
    if (!isdefined(player.pers[#"contracts"])) {
        return;
    }
    foreach (var_38280f2f, var_5ceb23d0 in player.pers[#"contracts"]) {
        if (isdefined(var_5ceb23d0.current_value)) {
            delta = var_5ceb23d0.current_value - var_5ceb23d0.var_59cb904f;
        } else {
            delta = 0;
        }
        var_4b67585c = 0;
        var_2de8a050 = 0;
        if (!isdefined(var_5ceb23d0.var_1bd1ecbb)) {
            var_5ceb23d0.var_1bd1ecbb = 0;
        }
        if (!isdefined(var_5ceb23d0.var_c7d05ecd)) {
            var_5ceb23d0.var_c7d05ecd = 0;
        }
        if (isdefined(var_5ceb23d0.var_be5bf249)) {
            var_4b67585c = var_5ceb23d0.var_be5bf249 - var_5ceb23d0.var_1bd1ecbb;
            var_2de8a050 = var_5ceb23d0.var_be5bf249 - var_5ceb23d0.var_c7d05ecd;
        } else {
            if (sessionmodeiszombiesgame()) {
                var_ad6e6421 = player.pers[#"time_played_total"];
                var_5463bb33 = var_ad6e6421;
            } else {
                var_ad6e6421 = undefined;
                if (isdefined(level.var_f202fa67) && [[ level.var_f202fa67 ]](var_38280f2f)) {
                    if (isdefined(player.var_c619a827)) {
                        var_ad6e6421 = player.var_c619a827 - player.pers[#"hash_5651f00c6c1790a4"];
                    }
                } else if (!isdefined(level.var_e3551fe4) || ![[ level.var_e3551fe4 ]](var_38280f2f)) {
                    if (isdefined(player.var_56bd2c02)) {
                        var_ad6e6421 = player.var_56bd2c02 - player.pers[#"hash_5651f00c6c1790a4"];
                    }
                }
                time_played_total = player stats::get_stat_global(#"time_played_total");
                var_9d12108c = isdefined(self.team) && isdefined(self.timeplayed[self.team]) ? self.timeplayed[self.team] : 0;
                var_5463bb33 = time_played_total - player.pers[#"hash_5651f00c6c1790a4"] + var_9d12108c;
                if (!isdefined(var_ad6e6421)) {
                    var_ad6e6421 = var_5463bb33;
                }
            }
            var_4b67585c = var_ad6e6421 - var_5ceb23d0.var_1bd1ecbb;
            var_2de8a050 = var_5463bb33 - var_5ceb23d0.var_c7d05ecd;
        }
        if (delta <= 0 && var_4b67585c <= 0 && var_2de8a050 <= 0) {
            continue;
        }
        if (var_4b67585c < 0) {
            var_4b67585c = 0;
        }
        if (var_2de8a050 < 0) {
            var_2de8a050 = 0;
        }
        var_9224acc = 0;
        if (isdefined(var_5ceb23d0.current_value)) {
            if (var_5ceb23d0.current_value >= var_5ceb23d0.target_value) {
                var_9224acc = 1;
            }
        }
        /#
            if (getdvarint(#"scr_contract_debug", 0) > 0) {
                var_7b6acdb1 = var_9224acc ? "<dev string:x27a>" : "<dev string:x1e4>";
                iprintln("<dev string:x28b>" + function_9e72a96(var_38280f2f) + "<dev string:x29a>" + delta + "<dev string:x2a9>" + var_4b67585c + "<dev string:x2ca>" + var_2de8a050 + var_7b6acdb1);
            }
        #/
        flags = player function_507247e8(var_9224acc);
        function_d8c98325(var_38280f2f, delta, flags, var_4b67585c, var_2de8a050);
        if (isdefined(var_5ceb23d0.current_value)) {
            var_5ceb23d0.var_59cb904f = var_5ceb23d0.current_value;
        }
        var_5ceb23d0.var_1bd1ecbb += var_4b67585c;
        var_5ceb23d0.var_c7d05ecd += var_2de8a050;
    }
}

// Namespace contracts/contracts_shared
// Params 5, eflags: 0x0
// Checksum 0x466d18e9, Offset: 0x1b40
// Size: 0x7e
function function_d8c98325(var_38280f2f, *delta, *flags, *var_4b67585c, *var_2de8a050) {
    player = self;
    if (var_2de8a050 != #"") {
        var_ae857992 = getdvarint(#"hash_60d812bef0f782fb", 4);
    }
}

// Namespace contracts/contracts_shared
// Params 1, eflags: 0x0
// Checksum 0x9820322f, Offset: 0x1bc8
// Size: 0x16c
function function_507247e8(var_9224acc) {
    player = self;
    flags = 0;
    xpscale = player getxpscale();
    if (xpscale > 1) {
        flags |= 1;
    }
    lootxpscale = player function_c52bcf79();
    if (sessionmodeiszombiesgame()) {
        if (max(lootxpscale, float(getdvarint(#"hash_1624faaee3c04f09", 1))) > 1) {
            flags |= 2;
        }
    } else if (lootxpscale > 1) {
        flags |= 2;
    }
    if (var_9224acc) {
        flags |= 8;
    }
    if (getdvarint(#"lootcontracts_daily_tier_skip", 0) != 0) {
        flags |= 16;
    }
    return flags;
}

