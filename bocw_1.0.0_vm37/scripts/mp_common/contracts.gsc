#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\util;

#namespace contracts;

// Namespace contracts/contracts
// Params 0, eflags: 0x6
// Checksum 0xdd65e55b, Offset: 0xf8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"contracts", &preinit, undefined, &finalize_init, undefined);
}

// Namespace contracts/contracts
// Params 0, eflags: 0x4
// Checksum 0xdf46ae0f, Offset: 0x148
// Size: 0x34
function private preinit() {
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    init_player_contract_events();
}

// Namespace contracts/contracts
// Params 0, eflags: 0x4
// Checksum 0x4a858d92, Offset: 0x188
// Size: 0x1dc
function private finalize_init() {
    callback::on_connect(&on_player_connect);
    if (can_process_contracts()) {
        register_player_contract_event(#"headshot", &on_headshot_kill);
        register_player_contract_event(#"air_assault_total_kills", &function_a0045e6a);
        register_player_contract_event(#"hash_10b0c56ae630070d", &function_8af6a5a);
        challenges::registerchallengescallback("playerKilled", &contract_kills);
        challenges::registerchallengescallback("gameEnd", &function_a4c8ce2a);
        globallogic_score::registercontractwinevent(&contract_win);
        register_player_contract_event(#"ekia", &on_ekia, 1);
        register_player_contract_event(#"objective_ekia", &on_objective_ekia);
        level.var_79a93566 = &function_902ef0de;
        level.var_c3e2bb05 = 1;
        /#
            thread devgui_setup();
        #/
    }
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0xbf567c1, Offset: 0x370
// Size: 0x3c
function on_player_connect() {
    if (can_process_contracts()) {
        self setup_player_contracts(3, &function_90a854d2);
    }
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0xd0a7fadb, Offset: 0x3b8
// Size: 0xa2
function can_process_contracts() {
    if (getdvarint(#"contracts_enabled", 0) == 0) {
        return 0;
    }
    if (getdvarint(#"contracts_enabled_mp", 1) == 0) {
        return 0;
    }
    if (!sessionmodeismultiplayergame()) {
        return 0;
    }
    if (level.var_73e51905 === 1) {
        return 0;
    }
    return challenges::canprocesschallenges();
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0xb56cefa9, Offset: 0x468
// Size: 0x262
function contract_kills(data) {
    victim = data.victim;
    attacker = data.attacker;
    player = attacker;
    weapon = data.weapon;
    time = data.time;
    iskillstreak = isdefined(data.einflictor) && isdefined(data.einflictor.killstreakid);
    if (!iskillstreak && isdefined(level.iskillstreakweapon)) {
        iskillstreakweapon = [[ level.iskillstreakweapon ]](weapon);
    }
    if (iskillstreak || iskillstreakweapon === 1) {
        switch (weapon.statname) {
        case #"dart":
            player function_fd9fb79b(#"contract_mp_dart_kills");
            break;
        case #"ac130":
            player function_fd9fb79b(#"contract_mp_gunship_kills");
            break;
        case #"recon_car":
            player function_fd9fb79b(#"contract_mp_rcxd_kills");
            break;
        case #"planemortar":
            player function_fd9fb79b(#"contract_mp_lightning_strike");
            break;
        case #"remote_missile":
            player function_fd9fb79b(#"contract_mp_hellstorm_kills");
            break;
        case #"ai_tank_marker":
            player function_fd9fb79b(#"contract_mp_mantis_kills");
            break;
        default:
            break;
        }
    }
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0x339fe847, Offset: 0x6d8
// Size: 0x3e4
function on_ekia(weapon) {
    player = self;
    if (level.hardcoremode) {
        player function_fd9fb79b(#"contract_mp_hardcore_ekia");
    }
    var_6b9aa5a0 = undefined;
    weaponclass = util::getweaponclass(weapon);
    if (!isdefined(weaponclass)) {
        weaponclass = #"unspecified";
    }
    switch (weaponclass) {
    case #"weapon_assault":
        var_6b9aa5a0 = #"hash_1005918e22a7865b";
        break;
    case #"weapon_lmg":
        var_6b9aa5a0 = #"hash_151c8e7a35e1e380";
        break;
    case #"weapon_pistol":
        var_6b9aa5a0 = #"hash_250c2d8ef2261723";
        break;
    case #"weapon_cqb":
        var_6b9aa5a0 = #"hash_5262d5b92e0fdc2";
        break;
    case #"weapon_smg":
        var_6b9aa5a0 = #"hash_2173bc0bfcbdf90f";
        break;
    case #"weapon_sniper":
        var_6b9aa5a0 = #"hash_21762ab1513fddf";
        break;
    case #"weapon_tactical":
        var_6b9aa5a0 = #"hash_1a4fe101c7aab2d";
        break;
    default:
        break;
    }
    if (isdefined(var_6b9aa5a0)) {
        player function_fd9fb79b(var_6b9aa5a0);
    }
    var_8a4cfbd = 0;
    if (weapon.var_76ce72e8) {
        scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
        var_8a4cfbd = isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
    }
    if (var_8a4cfbd) {
        player increment_contract(#"hash_6b52fb637a3c29cb");
    } else if (weapon.issignatureweapon) {
        player increment_contract(#"hash_31a6484e36a0a20f");
    }
    var_29d5cadd = player gettotalunlockedweaponattachments(weapon);
    loadout_primary_weapon = player loadout::function_18a77b37("primary");
    loadout_secondary_weapon = player loadout::function_18a77b37("secondary");
    if (var_29d5cadd >= 3) {
        if (loadout_primary_weapon === weapon) {
            player function_fd9fb79b(#"contract_mp_attachments3_primary_ekia");
        } else if (loadout_secondary_weapon === weapon) {
            player function_fd9fb79b(#"hash_264228bd931f8deb");
        }
    }
    if (var_29d5cadd >= 5) {
        if (loadout_primary_weapon === weapon) {
            player function_fd9fb79b(#"hash_d18e3651f508489");
            return;
        }
        if (loadout_secondary_weapon === weapon) {
            player function_fd9fb79b(#"hash_469703d9a67cf0dd");
        }
    }
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x768c813b, Offset: 0xac8
// Size: 0x24
function on_objective_ekia() {
    self increment_contract(#"contract_mp_objective_ekia");
}

// Namespace contracts/contracts
// Params 2, eflags: 0x0
// Checksum 0x93f7df6, Offset: 0xaf8
// Size: 0x5c
function function_fd9fb79b(var_38280f2f, delta = 1) {
    if (self is_contract_active(var_38280f2f)) {
        self function_902ef0de(var_38280f2f, delta);
    }
}

// Namespace contracts/contracts
// Params 2, eflags: 0x4
// Checksum 0x52bb63bd, Offset: 0xb60
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

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0x5a367605, Offset: 0xf18
// Size: 0x1c2
function function_90a854d2(slot) {
    /#
        if (getdvarint(#"hash_657185da33fd5f8", 0) > 0) {
            var_38280f2f = #"hash_6a1133003efe7380";
            switch (slot) {
            case 0:
                return {#var_38280f2f:#"contract_mp_headshot", #contract_id:10011, #target_value:100, #var_59cb904f:98};
            case 1:
                return {#var_38280f2f:#"hash_2173bc0bfcbdf90f", #contract_id:10004, #target_value:200, #var_59cb904f:195};
            case 2:
                return {#var_38280f2f:#"hash_250c2d8ef2261723", #contract_id:10009, #target_value:50, #var_59cb904f:48};
            default:
                break;
            }
            return undefined;
        }
    #/
    return function_d17bcd3c(slot);
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0x597ae6f0, Offset: 0x10e8
// Size: 0x6c
function function_a4c8ce2a(data) {
    if (!isdefined(data)) {
        return;
    }
    player = data.player;
    if (!isplayer(player)) {
        return;
    }
    player function_c5958b54();
    player function_78083139();
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0x2e6f2b04, Offset: 0x1160
// Size: 0x2c
function contract_win(winner) {
    winner function_fd9fb79b(#"contract_mp_match_wins");
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x1d81db7a, Offset: 0x1198
// Size: 0x44c
function function_c5958b54() {
    var_c421e6b = undefined;
    switch (level.gametype) {
    case #"ball":
    case #"ball_hc":
        var_c421e6b = #"contract_mp_play_uplink";
        break;
    case #"bounty":
    case #"bounty_hc":
        var_c421e6b = #"contract_mp_play_heist";
        break;
    case #"conf_hc":
    case #"conf":
        var_c421e6b = #"hash_2156d88add08f25f";
        break;
    case #"control":
    case #"control_hc":
        var_c421e6b = #"contract_mp_play_control";
        break;
    case #"ctf":
    case #"ctf_hc":
        var_c421e6b = #"hash_42b7ebc5926b0008";
        break;
    case #"dem":
    case #"dem_hc":
        var_c421e6b = #"contract_mp_play_demolition";
        break;
    case #"dm":
    case #"dm_hc":
        var_c421e6b = #"hash_5dbf89f59ac323e3";
        break;
    case #"dom":
    case #"dom_hc":
        var_c421e6b = #"contract_mp_play_domination";
        break;
    case #"escort":
    case #"escort_hc":
        var_c421e6b = #"contract_mp_play_safeguard";
        break;
    case #"gun":
    case #"gun_hc":
        var_c421e6b = #"hash_f916a0b9718fb8";
        break;
    case #"infect_hc":
    case #"infect":
        var_c421e6b = #"contract_mp_play_infection";
        break;
    case #"koth":
    case #"koth_hc":
        var_c421e6b = #"contract_mp_play_hardpoint";
        break;
    case #"prop_hc":
    case #"prop":
        var_c421e6b = #"contract_mp_play_prop_hunt";
        break;
    case #"sas_hc":
    case #"sas":
        var_c421e6b = #"contract_mp_play_sticks_and_stones";
        break;
    case #"sd":
    case #"sd_hc":
        var_c421e6b = #"contract_mp_play_search";
        break;
    case #"tdm":
        var_c421e6b = #"contract_mp_play_team_deathmatch";
        break;
    case #"tdm_hc":
        var_c421e6b = #"contract_mp_play_hardcore_team_deathmatch";
        break;
    default:
        break;
    }
    if (isdefined(var_c421e6b)) {
        self function_fd9fb79b(var_c421e6b);
        self function_fd9fb79b(#"contract_mp_play_public_match_games");
    }
    if (globallogic_utils::function_308e3379()) {
        self function_fd9fb79b(#"hash_1ffdd36f8bcda97d");
    }
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x8cd9850a, Offset: 0x15f0
// Size: 0x54
function on_headshot_kill() {
    if (level.hardcoremode) {
        self function_fd9fb79b(#"contract_mp_headshots_hardcore");
    }
    self function_fd9fb79b(#"contract_mp_headshot");
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x18185163, Offset: 0x1650
// Size: 0x24
function function_a0045e6a() {
    self function_fd9fb79b(#"hash_5903b7c9559be1e");
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0xd99a359b, Offset: 0x1680
// Size: 0x24
function function_8af6a5a() {
    self function_fd9fb79b(#"hash_31951837e7c9b9ef");
}

/#

    // Namespace contracts/contracts
    // Params 0, eflags: 0x0
    // Checksum 0x72d9e06, Offset: 0x16b0
    // Size: 0xe4
    function devgui_setup() {
        devgui_base = "<dev string:x6e>";
        wait 3;
        function_e07e542b(devgui_base, undefined);
        function_17a92a99(devgui_base);
        function_b308be00(devgui_base);
        function_b8984e1a(devgui_base);
        function_1379e87e(devgui_base);
        function_50a60581(devgui_base);
        function_ef925b75(devgui_base);
        function_d1de9a1b(devgui_base);
    }

    // Namespace contracts/contracts
    // Params 1, eflags: 0x0
    // Checksum 0x898ea04f, Offset: 0x17a0
    // Size: 0x35c
    function function_17a92a99(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:x7f>";
        var_c8d599b5 = "<dev string:x94>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:xd1>", var_c8d599b5 + "<dev string:xee>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x117>", var_c8d599b5 + "<dev string:x130>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x155>", var_c8d599b5 + "<dev string:x171>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x199>", var_c8d599b5 + "<dev string:x1ab>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x1c3>", var_c8d599b5 + "<dev string:x1d4>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x1f1>", var_c8d599b5 + "<dev string:x20c>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x22e>", var_c8d599b5 + "<dev string:x23e>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x263>", var_c8d599b5 + "<dev string:x273>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x298>", var_c8d599b5 + "<dev string:x2aa>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x2c2>", var_c8d599b5 + "<dev string:x2d4>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x2ec>", var_c8d599b5 + "<dev string:x307>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x326>", var_c8d599b5 + "<dev string:x333>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x34c>", var_c8d599b5 + "<dev string:x363>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x386>", var_c8d599b5 + "<dev string:x3a7>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x3c8>", var_c8d599b5 + "<dev string:x3da>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x3f2>", var_c8d599b5 + "<dev string:x406>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x423>", var_c8d599b5 + "<dev string:x435>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x453>", var_c8d599b5 + "<dev string:x467>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x481>", var_c8d599b5 + "<dev string:x49d>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x4c0>", var_c8d599b5 + "<dev string:x4db>");
    }

    // Namespace contracts/contracts
    // Params 1, eflags: 0x0
    // Checksum 0xdf808d5, Offset: 0x1b08
    // Size: 0x12c
    function function_b308be00(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:x4f4>";
        var_c8d599b5 = "<dev string:x94>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:x50c>", var_c8d599b5 + "<dev string:x52b>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x550>", var_c8d599b5 + "<dev string:x563>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x582>", var_c8d599b5 + "<dev string:x599>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x5b1>", var_c8d599b5 + "<dev string:x5c5>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x5e5>", var_c8d599b5 + "<dev string:x5f5>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x611>", var_c8d599b5 + "<dev string:x628>");
    }

    // Namespace contracts/contracts
    // Params 1, eflags: 0x0
    // Checksum 0xd03b46ed, Offset: 0x1c40
    // Size: 0x154
    function function_b8984e1a(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:x64b>";
        var_c8d599b5 = "<dev string:x94>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:x665>", var_c8d599b5 + "<dev string:x677>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x695>", var_c8d599b5 + "<dev string:x6aa>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x6c9>", var_c8d599b5 + "<dev string:x6d3>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x6f5>", var_c8d599b5 + "<dev string:x700>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x71f>", var_c8d599b5 + "<dev string:x731>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x750>", var_c8d599b5 + "<dev string:x75a>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x77c>", var_c8d599b5 + "<dev string:x78e>");
    }

    // Namespace contracts/contracts
    // Params 1, eflags: 0x0
    // Checksum 0x1602d0d2, Offset: 0x1da0
    // Size: 0x104
    function function_1379e87e(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:x7b2>";
        var_c8d599b5 = "<dev string:x94>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:x7cc>", var_c8d599b5 + "<dev string:x7ed>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x819>", var_c8d599b5 + "<dev string:x83d>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x86c>", var_c8d599b5 + "<dev string:x883>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x8a6>", var_c8d599b5 + "<dev string:x8c0>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x8f9>", var_c8d599b5 + "<dev string:x90f>");
    }

    // Namespace contracts/contracts
    // Params 1, eflags: 0x0
    // Checksum 0x58638339, Offset: 0x1eb0
    // Size: 0x36c
    function function_50a60581(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:x93b>";
        var_c8d599b5 = "<dev string:x94>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:x95f>", var_c8d599b5 + #"contract_mp_match_wins");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x973>", var_c8d599b5 + #"contract_mp_play_uplink");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x982>", var_c8d599b5 + #"contract_mp_play_heist");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x990>", var_c8d599b5 + #"hash_2156d88add08f25f");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x9a5>", var_c8d599b5 + #"hash_42b7ebc5926b0008");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x9be>", var_c8d599b5 + #"contract_mp_play_demolition");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x9d1>", var_c8d599b5 + #"hash_5dbf89f59ac323e3");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x9e6>", var_c8d599b5 + #"contract_mp_play_domination");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x9f9>", var_c8d599b5 + #"contract_mp_play_safeguard");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xa0b>", var_c8d599b5 + #"hash_f916a0b9718fb8");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xa1c>", var_c8d599b5 + #"contract_mp_play_infected");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xa2d>", var_c8d599b5 + #"contract_mp_play_hardpoint");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xa3f>", var_c8d599b5 + #"contract_mp_play_prop_hunt");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xa51>", var_c8d599b5 + #"contract_mp_play_sticks_and_stones");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xa6b>", var_c8d599b5 + #"contract_mp_play_search");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xa86>", var_c8d599b5 + #"contract_mp_play_team_deathmatch");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xa9f>", var_c8d599b5 + #"contract_mp_play_hardcore_team_deathmatch");
    }

    // Namespace contracts/contracts
    // Params 1, eflags: 0x0
    // Checksum 0xd736dde8, Offset: 0x2228
    // Size: 0xb4
    function function_ef925b75(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:xac1>";
        var_c8d599b5 = "<dev string:x94>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:xad9>", var_c8d599b5 + "<dev string:xaef>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xb10>", var_c8d599b5 + "<dev string:xb20>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xb3c>", var_c8d599b5 + "<dev string:xb4e>");
    }

    // Namespace contracts/contracts
    // Params 1, eflags: 0x0
    // Checksum 0x97b4a5a8, Offset: 0x22e8
    // Size: 0xdc
    function function_d1de9a1b(var_1d89ece6) {
        var_78a6fb52 = var_1d89ece6 + "<dev string:xb6c>";
        var_c8d599b5 = "<dev string:x94>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:xb85>", var_c8d599b5 + "<dev string:xba4>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xbd0>", var_c8d599b5 + "<dev string:xbf2>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xc21>", var_c8d599b5 + "<dev string:xc3b>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xc61>", var_c8d599b5 + "<dev string:xc7e>");
    }

#/
