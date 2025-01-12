#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace contracts;

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x6
// Checksum 0x4aff9b44, Offset: 0xf0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"contracts", &function_70a657d8, undefined, &finalize_init, undefined);
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x5 linked
// Checksum 0x76028f2f, Offset: 0x140
// Size: 0x34
function private function_70a657d8() {
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    init_player_contract_events();
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x5 linked
// Checksum 0x89db9a0c, Offset: 0x180
// Size: 0xe4
function private finalize_init() {
    if (can_process_contracts()) {
        callback::on_connect(&on_player_connect);
        callback::function_74872db6(&function_74872db6);
        callback::on_round_end(&on_round_end);
        zm_player::function_a827358a(&function_8968a076);
        level.var_79a93566 = &function_902ef0de;
        level.var_c3e2bb05 = 3;
        /#
            level thread devgui_setup();
            level.var_b4ef4d73 = 1;
        #/
    }
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xbe3e37ed, Offset: 0x270
// Size: 0x1a4
function on_player_connect() {
    self setup_player_contracts(3, &registerpower_grid_displaycontrolrobotmelee);
    self.shlocalh = 0;
    self.var_45ce0c21 = 0;
    if (self is_contract_active(#"contract_zm_no_pap") || is_true(level.var_b4ef4d73)) {
        self thread function_677a89c8();
    }
    if (self is_contract_active(#"contract_zm_perks") || is_true(level.var_b4ef4d73)) {
        self thread function_30dc9a23();
    }
    if (self is_contract_active(#"contract_zm_same_shield") || is_true(level.var_b4ef4d73)) {
        self thread function_9d5cd9ee();
    }
    if (self is_contract_active(#"contract_zm_same_location") || is_true(level.var_b4ef4d73)) {
        self thread function_51db541e();
    }
}

// Namespace contracts/zm_contracts
// Params 10, eflags: 0x1 linked
// Checksum 0xf9f7390f, Offset: 0x420
// Size: 0x6a
function function_8968a076(*einflictor, *eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime) {
    if (psoffsettime > 0) {
        self.shlocalh = 0;
    }
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xa58840b4, Offset: 0x498
// Size: 0x1cc
function function_74872db6() {
    if (level.round_number == 20) {
        foreach (e_player in getplayers()) {
            if (!is_true(e_player.var_bd1368a8)) {
                e_player increment_zm_contract(#"contract_zm_no_pap", 1, #"zstandard");
            }
        }
        level notify(#"hash_786860db94bcc0f3");
    }
    if (level.round_number == 30) {
        foreach (e_player in getplayers()) {
            e_player increment_zm_contract(#"contract_zm_rounds", 1, #"zstandard");
        }
        callback::function_50fdac80(&function_74872db6);
    }
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x2ac2af5, Offset: 0x670
// Size: 0x248
function on_round_end() {
    switch (level.script) {
    case #"zm_zodt8":
        var_c5440c34 = #"contract_zm_zodt8_rounds";
        break;
    case #"zm_towers":
        var_c5440c34 = #"contract_zm_towers_rounds";
        break;
    case #"zm_escape":
        var_c5440c34 = #"contract_zm_escape_rounds";
        break;
    case #"zm_office":
        var_c5440c34 = #"contract_zm_office_rounds";
        break;
    case #"zm_mansion":
        var_c5440c34 = #"contract_zm_mansion_rounds";
        break;
    case #"zm_red":
        var_c5440c34 = #"contract_zm_red_rounds";
        break;
    }
    switch (level.var_837aa533) {
    case #"zclassic":
        var_fc80b645 = #"contract_zm_classic_rounds";
        break;
    case #"ztrials":
        var_fc80b645 = #"contract_zm_gauntlet_rounds";
        break;
    }
    foreach (e_player in getplayers()) {
        if (isdefined(var_c5440c34)) {
            e_player increment_zm_contract(var_c5440c34, 1, #"zstandard");
        }
        if (isdefined(var_fc80b645)) {
            e_player increment_zm_contract(var_fc80b645, 1);
        }
    }
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xff07e3eb, Offset: 0x8c0
// Size: 0xc0
function can_process_contracts() {
    if (getdvarint(#"contracts_enabled", 0) == 0) {
        return false;
    }
    if (getdvarint(#"contracts_enabled_zm", 1) == 0) {
        return false;
    }
    /#
        if (getdvarint(#"scr_debug_challenges", 0)) {
            return true;
        }
    #/
    if (!level.onlinegame || is_true(level.var_aa2d5655)) {
        return false;
    }
    return true;
}

// Namespace contracts/zm_contracts
// Params 3, eflags: 0x1 linked
// Checksum 0x88abed6d, Offset: 0x988
// Size: 0x14c
function increment_zm_contract(var_38280f2f, delta = 1, var_86024473) {
    if (!can_process_contracts() || !self is_contract_active(var_38280f2f)) {
        return;
    }
    if (isdefined(var_86024473)) {
        if (!isdefined(var_86024473)) {
            var_86024473 = [];
        } else if (!isarray(var_86024473)) {
            var_86024473 = array(var_86024473);
        }
        foreach (var_86603201 in var_86024473) {
            if (var_86603201 == util::get_game_type()) {
                return;
            }
        }
    }
    self function_902ef0de(var_38280f2f, delta);
}

// Namespace contracts/zm_contracts
// Params 2, eflags: 0x5 linked
// Checksum 0x71ab1982, Offset: 0xae0
// Size: 0x34c
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
        self.pers[#"contracts"][var_38280f2f].var_be5bf249 = self.pers[#"time_played_total"];
        if (isdefined(level.contract_ids[var_38280f2f])) {
            zm_stats::function_ea5b4947(0);
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

// Namespace contracts/zm_contracts
// Params 1, eflags: 0x1 linked
// Checksum 0x5cf77892, Offset: 0xe38
// Size: 0x22
function registerpower_grid_displaycontrolrobotmelee(slot) {
    return function_d17bcd3c(slot);
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x6b433c22, Offset: 0xe68
// Size: 0x2c
function function_4a56b14d() {
    if (!can_process_contracts()) {
        return;
    }
    function_d3fba20e();
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xe32815a3, Offset: 0xea0
// Size: 0x84
function function_dff4c02f() {
    if (!can_process_contracts() || !self is_contract_active(#"hash_38b41a1f3105c462")) {
        return;
    }
    self.shlocalh++;
    if (self.shlocalh == 100) {
        self increment_zm_contract(#"hash_38b41a1f3105c462");
    }
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xd87d85d5, Offset: 0xf30
// Size: 0x94
function function_ac03f21e() {
    if (!can_process_contracts() || !self is_contract_active(#"contract_zm_single_special")) {
        return;
    }
    if (self.var_72d6f15d !== 2) {
        return;
    }
    self.var_45ce0c21++;
    if (self.var_45ce0c21 == 25) {
        self increment_zm_contract(#"contract_zm_single_special");
    }
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xe09b1bd4, Offset: 0xfd0
// Size: 0x98
function function_677a89c8() {
    level endon(#"hash_786860db94bcc0f3");
    self endon(#"disconnect");
    while (true) {
        s_notify = self waittill(#"weapon_change");
        w_current = s_notify.weapon;
        if (zm_weapons::is_weapon_upgraded(w_current)) {
            self.var_bd1368a8 = 1;
            return;
        }
    }
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x2fa3ba6a, Offset: 0x1070
// Size: 0xfa
function function_30dc9a23() {
    self endoncallback(&function_1729afac, #"disconnect", #"perk_vapor_lost");
    var_c16ab86f = 0;
    while (true) {
        level waittill(#"start_of_round");
        if (!self zm_perks::function_9a0e9d65()) {
            var_c16ab86f = 0;
            continue;
        }
        level waittill(#"end_of_round");
        if (self zm_perks::function_9a0e9d65()) {
            var_c16ab86f++;
        } else {
            var_c16ab86f = 0;
        }
        if (var_c16ab86f >= 5) {
            self increment_zm_contract(#"contract_zm_perks");
            return;
        }
    }
}

// Namespace contracts/zm_contracts
// Params 1, eflags: 0x1 linked
// Checksum 0xd6ab0475, Offset: 0x1178
// Size: 0x44
function function_1729afac(var_c34665fc) {
    self endon(#"disconnect");
    if (var_c34665fc == "perk_vapor_lost") {
        waittillframeend();
        self thread function_30dc9a23();
    }
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x370aa289, Offset: 0x11c8
// Size: 0xfa
function function_9d5cd9ee() {
    self endoncallback(&function_1395d508, #"disconnect", #"destroy_riotshield");
    var_c16ab86f = 0;
    while (true) {
        level waittill(#"start_of_round");
        if (!is_true(self.hasriotshield)) {
            var_c16ab86f = 0;
            continue;
        }
        level waittill(#"end_of_round");
        if (is_true(self.hasriotshield)) {
            var_c16ab86f++;
        } else {
            var_c16ab86f = 0;
        }
        if (var_c16ab86f >= 10) {
            self increment_zm_contract(#"contract_zm_same_shield");
            return;
        }
    }
}

// Namespace contracts/zm_contracts
// Params 1, eflags: 0x1 linked
// Checksum 0x4ecf121f, Offset: 0x12d0
// Size: 0x44
function function_1395d508(var_c34665fc) {
    self endon(#"disconnect");
    if (var_c34665fc == "destroy_riotshield") {
        waittillframeend();
        self thread function_9d5cd9ee();
    }
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xf03e01af, Offset: 0x1320
// Size: 0xdc
function function_51db541e() {
    self endon(#"disconnect");
    var_c16ab86f = 0;
    while (true) {
        level waittill(#"start_of_round");
        if (!isdefined(self.var_5417136)) {
            continue;
        }
        if (!isdefined(self.var_42a6fc40)) {
            self.var_42a6fc40 = self.var_5417136;
            var_c16ab86f = 0;
            self thread function_1d4fae71();
        } else {
            var_c16ab86f++;
        }
        if (var_c16ab86f >= 10) {
            self increment_zm_contract(#"contract_zm_same_location");
            self notify(#"hash_4bf9f2755fe74a0d");
            return;
        }
    }
}

// Namespace contracts/zm_contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x62a76417, Offset: 0x1408
// Size: 0x72
function function_1d4fae71() {
    self endon(#"disconnect", #"hash_4bf9f2755fe74a0d");
    while (true) {
        if (!isalive(self) || self.var_42a6fc40 != self.var_5417136) {
            self.var_42a6fc40 = undefined;
            return;
        }
        waitframe(1);
    }
}

/#

    // Namespace contracts/zm_contracts
    // Params 0, eflags: 0x0
    // Checksum 0x1729b01e, Offset: 0x1488
    // Size: 0x54
    function devgui_setup() {
        devgui_base = "<dev string:x6e>";
        wait 3;
        function_e07e542b(devgui_base, undefined);
        function_295a8005(devgui_base);
    }

    // Namespace contracts/zm_contracts
    // Params 1, eflags: 0x0
    // Checksum 0xef7d569e, Offset: 0x14e8
    // Size: 0x91c
    function function_295a8005(var_1d89ece6) {
        var_bbd68476 = var_1d89ece6 + "<dev string:x7f>";
        var_c8d599b5 = "<dev string:x88>";
        var_86418430 = var_bbd68476 + "<dev string:xc5>";
        util::function_3f749abc(var_86418430 + "<dev string:xcf>", var_c8d599b5 + "<dev string:xdf>");
        util::function_3f749abc(var_86418430 + "<dev string:xfb>", var_c8d599b5 + "<dev string:x10e>");
        util::function_3f749abc(var_86418430 + "<dev string:x129>", var_c8d599b5 + "<dev string:x13c>");
        util::function_3f749abc(var_86418430 + "<dev string:x15b>", var_c8d599b5 + "<dev string:x16d>");
        util::function_3f749abc(var_86418430 + "<dev string:x186>", var_c8d599b5 + "<dev string:x18f>");
        util::function_3f749abc(var_86418430 + "<dev string:x1a4>", var_c8d599b5 + "<dev string:x1b0>");
        util::function_3f749abc(var_86418430 + "<dev string:x1c8>", var_c8d599b5 + "<dev string:x1d5>");
        util::function_3f749abc(var_86418430 + "<dev string:x1ee>", var_c8d599b5 + "<dev string:x1fe>");
        util::function_3f749abc(var_86418430 + "<dev string:x21a>", var_c8d599b5 + "<dev string:x22b>");
        util::function_3f749abc(var_86418430 + "<dev string:x248>", var_c8d599b5 + "<dev string:x255>");
        util::function_3f749abc(var_86418430 + "<dev string:x26e>", var_c8d599b5 + "<dev string:x27e>");
        util::function_3f749abc(var_86418430 + "<dev string:x29a>", var_c8d599b5 + "<dev string:x2a6>");
        util::function_3f749abc(var_86418430 + "<dev string:x2be>", var_c8d599b5 + "<dev string:x2cd>");
        util::function_3f749abc(var_86418430 + "<dev string:x2e8>", var_c8d599b5 + "<dev string:x2fe>");
        util::function_3f749abc(var_86418430 + "<dev string:x31a>", var_c8d599b5 + "<dev string:x332>");
        util::function_3f749abc(var_86418430 + "<dev string:x356>", var_c8d599b5 + "<dev string:x367>");
        util::function_3f749abc(var_86418430 + "<dev string:x384>", var_c8d599b5 + "<dev string:x393>");
        util::function_3f749abc(var_86418430 + "<dev string:x3ae>", var_c8d599b5 + "<dev string:x3c5>");
        util::function_3f749abc(var_86418430 + "<dev string:x3e8>", var_c8d599b5 + "<dev string:x3f6>");
        util::function_3f749abc(var_86418430 + "<dev string:x410>", var_c8d599b5 + "<dev string:x422>");
        util::function_3f749abc(var_86418430 + "<dev string:x440>", var_c8d599b5 + "<dev string:x450>");
        util::function_3f749abc(var_86418430 + "<dev string:x46c>", var_c8d599b5 + "<dev string:x47e>");
        var_86418430 = var_bbd68476 + "<dev string:x49c>";
        util::function_3f749abc(var_86418430 + "<dev string:x4af>", var_c8d599b5 + "<dev string:x4ca>");
        util::function_3f749abc(var_86418430 + "<dev string:x4eb>", var_c8d599b5 + "<dev string:x518>");
        var_86418430 = var_bbd68476 + "<dev string:x536>";
        util::function_3f749abc(var_86418430 + "<dev string:x544>", var_c8d599b5 + "<dev string:x554>");
        util::function_3f749abc(var_86418430 + "<dev string:x569>", var_c8d599b5 + "<dev string:x57e>");
        util::function_3f749abc(var_86418430 + "<dev string:x59a>", var_c8d599b5 + "<dev string:x5ae>");
        util::function_3f749abc(var_86418430 + "<dev string:x5c6>", var_c8d599b5 + "<dev string:x5d9>");
        util::function_3f749abc(var_86418430 + "<dev string:x5f1>", var_c8d599b5 + "<dev string:x603>");
        var_86418430 = var_bbd68476 + "<dev string:x621>";
        util::function_3f749abc(var_86418430 + "<dev string:x62c>", var_c8d599b5 + "<dev string:x63d>");
        util::function_3f749abc(var_86418430 + "<dev string:x653>", var_c8d599b5 + "<dev string:x677>");
        util::function_3f749abc(var_86418430 + "<dev string:x68c>", var_c8d599b5 + "<dev string:x6a3>");
        util::function_3f749abc(var_86418430 + "<dev string:x6b9>", var_c8d599b5 + "<dev string:x6de>");
        util::function_3f749abc(var_86418430 + "<dev string:x6f9>", var_c8d599b5 + "<dev string:x71a>");
        util::function_3f749abc(var_86418430 + "<dev string:x737>", var_c8d599b5 + "<dev string:x749>");
        var_86418430 = var_bbd68476 + "<dev string:x767>";
        util::function_3f749abc(var_86418430 + "<dev string:x772>", var_c8d599b5 + "<dev string:x783>");
        util::function_3f749abc(var_86418430 + "<dev string:x7a0>", var_c8d599b5 + "<dev string:x7b0>");
        var_86418430 = var_bbd68476 + "<dev string:x7cc>";
        util::function_3f749abc(var_86418430 + "<dev string:x7d9>", var_c8d599b5 + "<dev string:x7e9>");
        util::function_3f749abc(var_86418430 + "<dev string:x808>", var_c8d599b5 + "<dev string:x823>");
        util::function_3f749abc(var_86418430 + "<dev string:x842>", var_c8d599b5 + "<dev string:x855>");
        var_86418430 = var_bbd68476 + "<dev string:x874>";
        util::function_3f749abc(var_86418430 + "<dev string:x87d>", var_c8d599b5 + "<dev string:x896>");
        util::function_3f749abc(var_86418430 + "<dev string:x8b3>", var_c8d599b5 + "<dev string:x8ba>");
        util::function_3f749abc(var_86418430 + "<dev string:x8b3>", var_c8d599b5 + "<dev string:x8d3>");
        util::function_3f749abc(var_86418430 + "<dev string:x8ed>", var_c8d599b5 + "<dev string:x8ff>");
        var_86418430 = var_bbd68476 + "<dev string:x91e>";
        util::function_3f749abc(var_86418430 + "<dev string:x927>", var_c8d599b5 + "<dev string:x937>");
        util::function_3f749abc(var_86418430 + "<dev string:x953>", var_c8d599b5 + "<dev string:x964>");
        util::function_3f749abc(var_86418430 + "<dev string:x981>", var_c8d599b5 + "<dev string:x992>");
        util::function_3f749abc(var_86418430 + "<dev string:x9af>", var_c8d599b5 + "<dev string:x9c0>");
        util::function_3f749abc(var_86418430 + "<dev string:x9dd>", var_c8d599b5 + "<dev string:x9ef>");
        util::function_3f749abc(var_86418430 + "<dev string:xa0d>", var_c8d599b5 + "<dev string:xa1b>");
        var_86418430 = var_bbd68476 + "<dev string:xa35>";
        util::function_3f749abc(var_86418430 + "<dev string:xa3e>", var_c8d599b5 + "<dev string:xa4a>");
        util::function_3f749abc(var_86418430 + "<dev string:xa62>", var_c8d599b5 + "<dev string:xa74>");
        util::function_3f749abc(var_86418430 + "<dev string:xa8c>", var_c8d599b5 + "<dev string:xa9b>");
    }

#/
