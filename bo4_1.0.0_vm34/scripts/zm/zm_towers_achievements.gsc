#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\zm\weapons\zm_weap_crossbow;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_towers_achievements;

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 0, eflags: 0x0
// Checksum 0xaf6b1a9f, Offset: 0x220
// Size: 0x1fc
function init() {
    level flag::init(#"hash_672bacab1faa8415");
    level flag::init(#"hash_501ce29ccfa96f4a");
    level flag::init(#"hash_6efaa75e1959aa0f");
    callback::on_connect(&function_895b4e2a);
    callback::on_connect(&function_9e6c2af6);
    callback::on_ai_killed(&function_187a73e7);
    callback::on_ai_killed(&function_2f924d2f);
    callback::on_ai_killed(&function_e8cb98c);
    level.gib_on_damage = &function_b49c2b2f;
    level thread function_732ddf29();
    level thread function_d0c0abeb();
    level thread function_a2b16287();
    level flag::wait_till("all_players_spawned");
    array::thread_all(level.players, &function_895b4e2a);
    array::thread_all(level.players, &function_9e6c2af6);
    array::thread_all(level.players, &function_a25f89eb);
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 0, eflags: 0x0
// Checksum 0x891a4ea9, Offset: 0x428
// Size: 0xc4
function function_a25f89eb() {
    level endon(#"end_game");
    self endon(#"disconnect");
    while (!self flag::exists(#"flag_player_completed_all_challenges")) {
        wait 1;
    }
    self flag::wait_till(#"flag_player_completed_all_challenges");
    self zm_utility::giveachievement_wrapper("zm_towers_challenges");
    /#
        self debug_notification("<dev string:x30>");
    #/
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 0, eflags: 0x0
// Checksum 0x1b2a5d56, Offset: 0x4f8
// Size: 0xdc
function function_895b4e2a() {
    self notify("17a7311070f95927");
    self endon("17a7311070f95927");
    level endon(#"end_game");
    self endon(#"disconnect");
    while (true) {
        s_waitresult = self waittill(#"weapon_change");
        w_weapon = s_waitresult.weapon;
        if (zm_weap_crossbow::is_crossbow_upgraded(w_weapon)) {
            break;
        }
    }
    self zm_utility::giveachievement_wrapper("zm_towers_get_ww");
    /#
        self debug_notification("<dev string:x38>");
    #/
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 1, eflags: 0x0
// Checksum 0xc63ec168, Offset: 0x5e0
// Size: 0x17c
function function_187a73e7(s_params) {
    e_attacker = s_params.eattacker;
    if (isdefined(e_attacker.activated_by_player)) {
        e_activator = e_attacker.activated_by_player;
        if (!isplayer(e_activator)) {
            return;
        }
    }
    if (!isdefined(e_attacker._trap_type)) {
        return;
    }
    if (e_attacker._trap_type != "hellpool") {
        return;
    }
    switch (e_attacker.script_string) {
    case #"hash_7ebf57684b9746dc":
        var_f9299402 = "towers_acid_trap_built_ra";
        break;
    case #"hash_7eae57684b88d3a9":
        var_f9299402 = "towers_acid_trap_built_danu";
        break;
    case #"hash_7ebf49684b972f12":
        var_f9299402 = "towers_acid_trap_built_odin";
        break;
    case #"hash_7eae45684b88b513":
        var_f9299402 = "towers_acid_trap_built_zeus";
        break;
    default:
        return;
    }
    e_activator zm_stats::increment_client_stat(var_f9299402, 1);
    e_activator thread function_39fb3b21();
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 0, eflags: 0x0
// Checksum 0x539f9db9, Offset: 0x768
// Size: 0xec
function function_39fb3b21() {
    b_ra = self zm_stats::get_client_stat("towers_acid_trap_built_ra");
    b_danu = self zm_stats::get_client_stat("towers_acid_trap_built_danu");
    b_odin = self zm_stats::get_client_stat("towers_acid_trap_built_odin");
    b_zeus = self zm_stats::get_client_stat("towers_acid_trap_built_zeus");
    if (b_ra && b_danu && b_odin && b_zeus) {
        self zm_utility::giveachievement_wrapper("zm_towers_trap_build");
    }
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 1, eflags: 0x0
// Checksum 0x63f48a4d, Offset: 0x860
// Size: 0x154
function function_2f924d2f(s_params) {
    e_player = s_params.eattacker;
    if (!isplayer(e_player)) {
        return;
    }
    e_projectile = function_ce837804(s_params);
    if (!isdefined(e_projectile)) {
        return;
    }
    if (!isdefined(e_projectile.var_349ec3b9)) {
        e_projectile.var_349ec3b9 = 0;
    }
    e_projectile.var_349ec3b9++;
    if (e_projectile.var_349ec3b9 >= 9 && !e_player flag::exists(#"hash_599401a7cc5b8a84")) {
        e_player flag::init(#"hash_599401a7cc5b8a84");
        e_player flag::set(#"hash_599401a7cc5b8a84");
        e_player zm_utility::giveachievement_wrapper("zm_towers_ww_kills");
        /#
            e_player debug_notification("<dev string:x4a>");
        #/
    }
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 1, eflags: 0x0
// Checksum 0xe84121e3, Offset: 0x9c0
// Size: 0xe0
function function_ce837804(s_params) {
    e_projectile = s_params.einflictor;
    w_weapon = s_params.weapon;
    if (!isdefined(w_weapon) || !zm_weap_crossbow::is_crossbow(w_weapon) || zm_weap_crossbow::is_crossbow_charged(w_weapon)) {
        return undefined;
    }
    if (!isdefined(e_projectile)) {
        return undefined;
    }
    var_adb5cffd = e_projectile.weapon;
    if (!isdefined(var_adb5cffd) || !zm_weap_crossbow::is_crossbow(var_adb5cffd) || zm_weap_crossbow::is_crossbow_charged(var_adb5cffd)) {
        return undefined;
    }
    return e_projectile;
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 1, eflags: 0x0
// Checksum 0x5743da7, Offset: 0xaa8
// Size: 0x12c
function function_e8cb98c(s_params) {
    if (self.archetype !== "tiger") {
        return;
    }
    var_4169a5c8 = self.var_7e95e0f5;
    if (!isdefined(var_4169a5c8) || var_4169a5c8.archetype !== "tiger") {
        return;
    }
    e_player = var_4169a5c8.var_fcc82858;
    if (isplayer(e_player) && !e_player flag::exists(#"hash_4969e1eae9bf556f")) {
        e_player flag::init(#"hash_4969e1eae9bf556f");
        e_player flag::set(#"hash_4969e1eae9bf556f");
        e_player zm_utility::giveachievement_wrapper("zm_towers_kitty_kitty");
        /#
            e_player debug_notification("<dev string:x5e>");
        #/
    }
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 1, eflags: 0x0
// Checksum 0x1c02adf1, Offset: 0xbe0
// Size: 0x13c
function function_b49c2b2f(e_attacker) {
    if (!isplayer(e_attacker) || e_attacker zm_zonemgr::get_player_zone() !== "zone_body_pit") {
        return;
    }
    if (!isdefined(e_attacker.var_34bb8246)) {
        e_attacker.var_34bb8246 = 0;
    }
    e_attacker.var_34bb8246++;
    if (e_attacker.var_34bb8246 >= 13 && !e_attacker flag::exists(#"hash_2086e93d2f58efce")) {
        e_attacker flag::init(#"hash_2086e93d2f58efce");
        e_attacker flag::set(#"hash_2086e93d2f58efce");
        e_attacker zm_utility::giveachievement_wrapper("zm_towers_dismember");
        /#
            e_attacker debug_notification("<dev string:x70>");
        #/
    }
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 0, eflags: 0x0
// Checksum 0xbe4c485b, Offset: 0xd28
// Size: 0x118
function function_d0c0abeb() {
    level endon(#"end_game");
    level flag::wait_till(#"hash_672bacab1faa8415");
    a_e_players = level.players;
    level flag::wait_till(#"hash_501ce29ccfa96f4a");
    foreach (e_player in a_e_players) {
        if (isdefined(e_player)) {
            e_player zm_utility::giveachievement_wrapper("zm_towers_boss_kill");
            /#
                e_player debug_notification("<dev string:x83>");
            #/
        }
    }
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 0, eflags: 0x0
// Checksum 0x82c06817, Offset: 0xe48
// Size: 0x74
function function_732ddf29() {
    level endon(#"end_game");
    level waittill(#"door_opened");
    level flag::set(#"hash_6efaa75e1959aa0f");
    callback::remove_on_connect(&function_9e6c2af6);
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 0, eflags: 0x0
// Checksum 0x7dd071da, Offset: 0xec8
// Size: 0x124
function function_9e6c2af6() {
    self notify("23f2832be313247b");
    self endon("23f2832be313247b");
    level endon(#"door_opened", #"end_game", #"hash_6efaa75e1959aa0f");
    self endon(#"death");
    if (level.round_number > 1 || level flag::get(#"hash_6efaa75e1959aa0f")) {
        return;
    }
    while (true) {
        level waittill(#"end_of_round");
        if (level.round_number >= 20) {
            break;
        }
    }
    self zm_utility::giveachievement_wrapper("zm_towers_arena_survive");
    /#
        self debug_notification("<dev string:x95>");
    #/
}

// Namespace zm_towers_achievements/zm_towers_achievements
// Params 0, eflags: 0x0
// Checksum 0x3915e049, Offset: 0xff8
// Size: 0x1a8
function function_a2b16287() {
    level endon(#"end_game");
    if (zm_custom::function_5638f689(#"zmpapenabled") == 2) {
        return;
    }
    if (!level flag::exists(#"hash_76692d6669cb0500")) {
        level flag::init(#"hash_76692d6669cb0500");
    }
    level waittill(#"start_of_round");
    a_e_players = level.players;
    level flag::wait_till_timeout(300, #"hash_76692d6669cb0500");
    if (level flag::get(#"hash_76692d6669cb0500")) {
        foreach (e_player in a_e_players) {
            if (isdefined(e_player)) {
                e_player zm_utility::giveachievement_wrapper("zm_towers_fast_pap");
                /#
                    e_player debug_notification("<dev string:xaa>");
                #/
            }
        }
    }
}

/#

    // Namespace zm_towers_achievements/zm_towers_achievements
    // Params 1, eflags: 0x4
    // Checksum 0xc6f41d5d, Offset: 0x11a8
    // Size: 0x74
    function private debug_notification(var_f9299402) {
        if (!isdefined(var_f9299402)) {
            var_f9299402 = "<dev string:xbd>";
        }
        self endon(#"death");
        str_name = self.name;
        if (!isdefined(str_name)) {
            return;
        }
        iprintln(str_name + "<dev string:xbe>" + var_f9299402);
    }

#/
