#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\util;

#namespace contracts;

// Namespace contracts/cwl_contracts
// Params 0, eflags: 0x6
// Checksum 0x1bdc0cd, Offset: 0xb8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"cwl_contracts", &preinit, undefined, &finalize_init, undefined);
}

// Namespace contracts/cwl_contracts
// Params 0, eflags: 0x4
// Checksum 0xdf46ae0f, Offset: 0x108
// Size: 0x34
function private preinit() {
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    init_player_contract_events();
}

// Namespace contracts/cwl_contracts
// Params 0, eflags: 0x4
// Checksum 0x291c8461, Offset: 0x148
// Size: 0x1a4
function private finalize_init() {
    callback::on_connect(&on_player_connect);
    if (can_process_contracts()) {
        challenges::registerchallengescallback("gameEnd", &function_a4c8ce2a);
        globallogic_score::registercontractwinevent(&contract_win);
        register_player_contract_event(#"score", &on_player_score, 2);
        register_player_contract_event(#"ekia", &on_ekia, 1);
        register_player_contract_event(#"objective_ekia", &on_objective_ekia);
        register_player_contract_event(#"damagedone", &on_damagedone, 1);
        level.var_79a93566 = &function_902ef0de;
        level.var_c3e2bb05 = 2;
        function_7364a587();
        /#
            thread devgui_setup();
        #/
    }
}

// Namespace contracts/cwl_contracts
// Params 0, eflags: 0x0
// Checksum 0xabaadb1f, Offset: 0x2f8
// Size: 0x356
function function_7364a587() {
    level.var_9d6b3096 = [];
    level.var_9d6b3096[#"hash_35a6541d081acef5"] = spawnstruct();
    level.var_9d6b3096[#"hash_594c4ab1d31aa150"] = spawnstruct();
    level.var_9d6b3096[#"hash_5fd7317230bb0fac"] = spawnstruct();
    level.var_9d6b3096[#"hash_35a6541d081acef5"].var_9dd75c18 = 3000;
    level.var_9d6b3096[#"hash_594c4ab1d31aa150"].var_9dd75c18 = 2500;
    level.var_9d6b3096[#"hash_5fd7317230bb0fac"].var_9dd75c18 = 500;
    level.var_9d6b3096[#"hash_35a6541d081acef5"].var_9a5a8dcf = 4000;
    level.var_9d6b3096[#"hash_594c4ab1d31aa150"].var_9a5a8dcf = 3000;
    level.var_9d6b3096[#"hash_5fd7317230bb0fac"].var_9a5a8dcf = 1000;
    level.var_9d6b3096[#"hash_35a6541d081acef5"].var_f703cb6c = 20;
    level.var_9d6b3096[#"hash_594c4ab1d31aa150"].var_f703cb6c = 15;
    level.var_9d6b3096[#"hash_5fd7317230bb0fac"].var_f703cb6c = 3;
    level.var_9d6b3096[#"hash_35a6541d081acef5"].var_39027dc7 = 30;
    level.var_9d6b3096[#"hash_594c4ab1d31aa150"].var_39027dc7 = 25;
    level.var_9d6b3096[#"hash_5fd7317230bb0fac"].var_39027dc7 = 7;
    level.var_9d6b3096[#"hash_35a6541d081acef5"].var_81bbb381 = 3500;
    level.var_9d6b3096[#"hash_594c4ab1d31aa150"].var_81bbb381 = 2500;
    level.var_9d6b3096[#"hash_5fd7317230bb0fac"].var_81bbb381 = 500;
    level.var_9d6b3096[#"hash_35a6541d081acef5"].var_9037b57b = 15;
    level.var_9d6b3096[#"hash_594c4ab1d31aa150"].var_9037b57b = 10;
    level.var_9d6b3096[#"hash_5fd7317230bb0fac"].var_9037b57b = 1;
}

// Namespace contracts/cwl_contracts
// Params 0, eflags: 0x0
// Checksum 0xa6746d8c, Offset: 0x658
// Size: 0x3c
function on_player_connect() {
    if (can_process_contracts()) {
        self setup_player_contracts(3, &function_1fd13839);
    }
}

// Namespace contracts/cwl_contracts
// Params 0, eflags: 0x0
// Checksum 0x7460b704, Offset: 0x6a0
// Size: 0xba
function can_process_contracts() {
    if (getdvarint(#"contracts_enabled", 0) == 0) {
        return 0;
    }
    if (getdvarint(#"hash_332424e6c4a080d8", 1) == 0) {
        return 0;
    }
    if (!sessionmodeismultiplayergame()) {
        return 0;
    }
    if (level.var_73e51905 !== 1) {
        return 0;
    }
    if (level.arenamatch !== 1) {
        return 0;
    }
    return challenges::canprocesschallenges();
}

// Namespace contracts/cwl_contracts
// Params 2, eflags: 0x0
// Checksum 0xaa66d812, Offset: 0x768
// Size: 0x114
function on_player_score(new_score, delta_score) {
    gametype = level.gametype;
    if (!isdefined(level.var_9d6b3096[gametype])) {
        return;
    }
    player = self;
    old_score = new_score - delta_score;
    target_value = level.var_9d6b3096[gametype].var_9dd75c18;
    if (old_score < target_value) {
        if (new_score >= target_value) {
            player function_ccf82192(#"contract_wl_score_per_mode");
        }
        return;
    }
    var_2c74fba6 = level.var_9d6b3096[gametype].var_9a5a8dcf;
    if (old_score < var_2c74fba6 && new_score >= var_2c74fba6) {
        player function_ccf82192(#"hash_1075c38287814aa0");
    }
}

// Namespace contracts/cwl_contracts
// Params 1, eflags: 0x0
// Checksum 0x8789eb55, Offset: 0x888
// Size: 0xe4
function on_ekia(*weapon) {
    gametype = level.gametype;
    if (!isdefined(level.var_9d6b3096[gametype])) {
        return;
    }
    player = self;
    var_350027d1 = player.pers[#"ekia"];
    if (var_350027d1 == level.var_9d6b3096[gametype].var_f703cb6c) {
        player function_ccf82192(#"hash_1d1b3fe36f24b6ac");
        return;
    }
    if (var_350027d1 == level.var_9d6b3096[gametype].var_39027dc7) {
        player function_ccf82192(#"hash_63e1c91ddca36b58");
    }
}

// Namespace contracts/cwl_contracts
// Params 0, eflags: 0x0
// Checksum 0x43bc82f5, Offset: 0x978
// Size: 0xa4
function on_objective_ekia() {
    gametype = level.gametype;
    if (!isdefined(level.var_9d6b3096[gametype])) {
        return;
    }
    player = self;
    objective_ekia = player.pers[#"objectiveekia"] + 1;
    if (objective_ekia == level.var_9d6b3096[gametype].var_9037b57b) {
        player function_ccf82192(#"hash_518ce6f8a5567a08");
    }
}

// Namespace contracts/cwl_contracts
// Params 1, eflags: 0x0
// Checksum 0x693958e8, Offset: 0xa28
// Size: 0xf4
function on_damagedone(damagedone) {
    player = self;
    if (player is_contract_active(#"hash_783240d7e11018c9")) {
        gametype = level.gametype;
        if (!isdefined(level.var_9d6b3096[gametype])) {
            return;
        }
        var_2e0944a3 = self.pers[#"damagedone"];
        var_5f607191 = var_2e0944a3 - damagedone;
        target_value = level.var_9d6b3096[gametype].var_81bbb381;
        if (var_5f607191 < target_value && var_2e0944a3 >= target_value) {
            player function_ccf82192(#"hash_783240d7e11018c9");
        }
    }
}

// Namespace contracts/cwl_contracts
// Params 2, eflags: 0x0
// Checksum 0xe4260e41, Offset: 0xb28
// Size: 0x5c
function function_ccf82192(var_38280f2f, delta = 1) {
    if (self is_contract_active(var_38280f2f)) {
        self function_902ef0de(var_38280f2f, delta);
    }
}

// Namespace contracts/cwl_contracts
// Params 2, eflags: 0x4
// Checksum 0xf25a7425, Offset: 0xb90
// Size: 0x3ac
function private function_902ef0de(var_38280f2f, delta) {
    /#
        if (getdvarint(#"scr_contract_debug_multiplier", 0) > 0) {
            delta *= getdvarint(#"scr_contract_debug_multiplier", 1);
        }
    #/
    if (delta <= 0) {
        return;
    }
    target_value = self.pers[#"contracts"][var_38280f2f].target_value;
    old_progress = isdefined(self.pers[#"contracts"][var_38280f2f].current_value) ? self.pers[#"contracts"][var_38280f2f].current_value : self.pers[#"contracts"][var_38280f2f].var_59cb904f;
    if (old_progress == target_value) {
        return;
    }
    new_progress = int(old_progress + delta);
    if (new_progress > target_value) {
        new_progress = target_value;
    }
    if (new_progress != old_progress) {
        self.pers[#"contracts"][var_38280f2f].current_value = new_progress;
        if (isdefined(level.contract_ids[var_38280f2f])) {
            self luinotifyevent(#"hash_4b04b1cb4b3498d0", 2, level.contract_ids[var_38280f2f], new_progress);
        }
    }
    if (old_progress < target_value && target_value <= new_progress) {
        var_9d12108c = isdefined(self.team) && isdefined(self.timeplayed[self.team]) ? self.timeplayed[self.team] : 0;
        self.pers[#"contracts"][var_38280f2f].var_be5bf249 = self stats::get_stat_global(#"time_played_total") - self.pers[#"hash_5651f00c6c1790a4"] + var_9d12108c;
        if (isdefined(level.contract_ids[var_38280f2f])) {
            self luinotifyevent(#"hash_1739c4bd5baf83bc", 1, level.contract_ids[var_38280f2f]);
        }
    }
    /#
        if (getdvarint(#"scr_contract_debug", 0) > 0) {
            iprintln(function_9e72a96(var_38280f2f) + "<dev string:x38>" + new_progress + "<dev string:x47>" + target_value);
            if (old_progress < target_value && target_value <= new_progress) {
                iprintln(function_9e72a96(var_38280f2f) + "<dev string:x4c>");
            }
        }
    #/
}

// Namespace contracts/cwl_contracts
// Params 1, eflags: 0x0
// Checksum 0x25d453c8, Offset: 0xf48
// Size: 0x22
function function_1fd13839(slot) {
    return function_d17bcd3c(slot);
}

// Namespace contracts/cwl_contracts
// Params 1, eflags: 0x0
// Checksum 0x489d7095, Offset: 0xf78
// Size: 0x1fc
function function_a4c8ce2a(data) {
    if (!isdefined(data)) {
        return;
    }
    player = data.player;
    if (!isplayer(player)) {
        return;
    }
    player function_ccf82192(#"contract_wl_play_games");
    team = player.team;
    if (isdefined(level.placement[team]) && player.score > 0) {
        last_check = min(level.placement.size, 3);
        for (i = 0; i < last_check; i++) {
            if (level.placement[team][i] == player) {
                player increment_contract(#"contract_wl_top_3_team");
                break;
            }
        }
    }
    arenaslot = arenagetslot();
    var_67d27328 = player stats::get_stat(#"arenastats", arenaslot, #"leagueplaystats", #"hash_36cd820c1ff6c16b");
    if (var_67d27328 > 0) {
        player increment_contract(#"hash_35e52e40ab6d1223", var_67d27328);
        player increment_contract(#"hash_421c3b5196a40f99", var_67d27328);
    }
    player function_78083139();
}

// Namespace contracts/cwl_contracts
// Params 1, eflags: 0x0
// Checksum 0xb6003ded, Offset: 0x1180
// Size: 0xe4
function contract_win(winner) {
    winner function_ccf82192(#"contract_wl_win_games");
    winner function_ccf82192(#"hash_2809e14b0f3b4c5e");
    var_283195f2 = winner stats::get_stat_global(#"hash_56a0e77eea02664d");
    if (var_283195f2 > 0) {
        if (var_283195f2 % 4 == 0) {
            winner function_ccf82192(#"contract_wl_win_streak_hard");
        }
        if (var_283195f2 % 2 == 0) {
            winner function_ccf82192(#"hash_4a14b348f01ad76d");
        }
    }
}

/#

    // Namespace contracts/cwl_contracts
    // Params 0, eflags: 0x0
    // Checksum 0x182761ee, Offset: 0x1270
    // Size: 0x9c
    function devgui_setup() {
        devgui_base = "<dev string:x6e>";
        wait 3;
        function_e07e542b(devgui_base, undefined);
        function_17a92a99(devgui_base);
        function_7f05e018(devgui_base);
        function_ef925b75(devgui_base);
        function_295a8005(devgui_base);
    }

    // Namespace contracts/cwl_contracts
    // Params 1, eflags: 0x0
    // Checksum 0xf7a2c05d, Offset: 0x1318
    // Size: 0x1f4
    function function_17a92a99(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:x83>";
        var_c8d599b5 = "<dev string:x98>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:xd5>", var_c8d599b5 + "<dev string:xe6>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x103>", var_c8d599b5 + "<dev string:x119>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x13b>", var_c8d599b5 + "<dev string:x155>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x17a>", var_c8d599b5 + "<dev string:x196>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x1b9>", var_c8d599b5 + "<dev string:x1dc>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x1f6>", var_c8d599b5 + "<dev string:x20c>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x22e>", var_c8d599b5 + "<dev string:x244>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x25f>", var_c8d599b5 + "<dev string:x274>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x28e>", var_c8d599b5 + "<dev string:x2ae>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x2d3>", var_c8d599b5 + "<dev string:x2f3>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x318>", var_c8d599b5 + "<dev string:x32b>");
    }

    // Namespace contracts/cwl_contracts
    // Params 1, eflags: 0x0
    // Checksum 0x78e47177, Offset: 0x1518
    // Size: 0x12c
    function function_7f05e018(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:x34a>";
        var_c8d599b5 = "<dev string:x98>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:x360>", var_c8d599b5 + "<dev string:x368>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x381>", var_c8d599b5 + "<dev string:x38e>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x3ac>", var_c8d599b5 + "<dev string:x3ba>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x3d4>", var_c8d599b5 + "<dev string:x3e8>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x407>", var_c8d599b5 + "<dev string:x418>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x439>", var_c8d599b5 + "<dev string:x44f>");
    }

    // Namespace contracts/cwl_contracts
    // Params 1, eflags: 0x0
    // Checksum 0x8a08161b, Offset: 0x1650
    // Size: 0xb4
    function function_ef925b75(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:x475>";
        var_c8d599b5 = "<dev string:x98>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:x48d>", var_c8d599b5 + "<dev string:x49f>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x4bd>", var_c8d599b5 + "<dev string:x4d4>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x4f7>", var_c8d599b5 + "<dev string:x512>");
    }

    // Namespace contracts/cwl_contracts
    // Params 1, eflags: 0x0
    // Checksum 0x56c6f85, Offset: 0x1710
    // Size: 0x8c
    function function_295a8005(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:x539>";
        var_c8d599b5 = "<dev string:x98>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:x54c>", var_c8d599b5 + "<dev string:x55e>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x578>", var_c8d599b5 + "<dev string:x58d>");
    }

#/
