#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\util;

#namespace contracts;

// Namespace contracts/contracts
// Params 0, eflags: 0x2
// Checksum 0x1e4cb652, Offset: 0x170
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"contracts", &__init__, undefined, undefined);
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x78e6179c, Offset: 0x1b8
// Size: 0x3c
function __init__() {
    callback::on_start_gametype(&start_gametype);
    /#
        level thread watch_contract_debug();
    #/
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x7eb68b85, Offset: 0x200
// Size: 0x2ac
function start_gametype() {
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    util::init_player_contract_events();
    waittillframeend();
    if (can_process_contracts()) {
        /#
            execdevgui("<dev string:x30>");
        #/
        challenges::registerchallengescallback("playerKilled", &contract_kills);
        challenges::registerchallengescallback("gameEnd", &function_ed438349);
        globallogic_score::registercontractwinevent(&contract_win);
        scoreevents::register_hero_ability_kill_event(&on_hero_ability_kill);
        scoreevents::register_hero_ability_multikill_event(&function_40a4d808);
        scoreevents::register_hero_weapon_multikill_event(&function_a997af9a);
        util::register_player_contract_event("score", &on_player_score, 1);
        util::register_player_contract_event("killstreak_score", &function_2ef87fc8, 2);
        util::register_player_contract_event("offender_kill", &function_88a1d86d);
        util::register_player_contract_event("defender_kill", &function_f14de7eb);
        util::register_player_contract_event("headshot", &on_headshot_kill);
        util::register_player_contract_event("killed_hero_ability_enemy", &function_f4746d43);
        util::register_player_contract_event("killed_hero_weapon_enemy", &function_62a41cad);
        util::register_player_contract_event("earned_specialist_ability_medal", &function_97ca91fe);
    }
    callback::on_connect(&on_player_connect);
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x456809c6, Offset: 0x4b8
// Size: 0x1c
function function_f4746d43() {
    self function_159cc09f(1014);
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0xe5818f3, Offset: 0x4e0
// Size: 0x1c
function function_62a41cad() {
    self function_159cc09f(1014);
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0xf2dae3bf, Offset: 0x508
// Size: 0x3c
function on_player_connect() {
    player = self;
    if (can_process_contracts()) {
        player setup_player_contracts();
    }
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0xc9c6c4b3, Offset: 0x550
// Size: 0x4a
function can_process_contracts() {
    if (getdvarint(#"contracts_enabled_mp", 1) == 0) {
        return 0;
    }
    return challenges::canprocesschallenges();
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x56ff08d5, Offset: 0x5a8
// Size: 0x26c
function setup_player_contracts() {
    player = self;
    player.pers[#"contracts"] = [];
    if (isbot(player)) {
        return;
    }
    var_2b0fb6af = tablelookuprowcount(#"gamedata/tables/mp/mp_contracttable.csv");
    if (!isdefined(var_2b0fb6af) || var_2b0fb6af == 0) {
        return;
    }
    for (slot = 0; slot < 10; slot++) {
        if (get_contract_stat(slot, "active") && !get_contract_stat(slot, "award_given")) {
            var_62d51442 = get_contract_stat(slot, "index");
            player.pers[#"contracts"][var_62d51442] = spawnstruct();
            player.pers[#"contracts"][var_62d51442].slot = slot;
            var_63cc7b72 = tablelookuprownum(#"gamedata/tables/mp/mp_contracttable.csv", 0, var_62d51442);
            player.pers[#"contracts"][var_62d51442].var_63cc7b72 = var_63cc7b72;
            player.pers[#"contracts"][var_62d51442].target_value = int(isdefined(tablelookupcolumnforrow(#"gamedata/tables/mp/mp_contracttable.csv", var_63cc7b72, 2)) ? tablelookupcolumnforrow(#"gamedata/tables/mp/mp_contracttable.csv", var_63cc7b72, 2) : 0);
        }
    }
}

/#

    // Namespace contracts/contracts
    // Params 0, eflags: 0x0
    // Checksum 0x94f6d6b3, Offset: 0x820
    // Size: 0x698
    function watch_contract_debug() {
        level notify(#"watch_contract_debug_singleton");
        level endon(#"watch_contract_debug_singleton");
        level endon(#"game_ended");
        while (true) {
            if (getdvarint(#"hash_2fec018b93258c2f", 0) > 0) {
                if (isdefined(level.players)) {
                    new_index = getdvarint(#"hash_7aae1c05f450e7fb", 0);
                    foreach (player in level.players) {
                        if (!isdefined(player)) {
                            continue;
                        }
                        if (isbot(player)) {
                            continue;
                        }
                        for (slot = 0; slot < 10; slot++) {
                            player function_4596db81(slot, "<dev string:x4e>", 0);
                        }
                        iprintln("<dev string:x55>" + player.name);
                        player setup_player_contracts();
                    }
                }
                setdvar(#"hash_2fec018b93258c2f", 0);
            }
            if (getdvarint(#"hash_7aae1c05f450e7fb", 0) > 0) {
                if (isdefined(level.players)) {
                    new_index = getdvarint(#"hash_7aae1c05f450e7fb", 0);
                    foreach (player in level.players) {
                        if (!isdefined(player)) {
                            continue;
                        }
                        if (isbot(player)) {
                            continue;
                        }
                        var_593adc20 = getdvarint(#"hash_31824b9ab099d33b", 9);
                        player function_4596db81(var_593adc20, "<dev string:x4e>", 1);
                        player function_4596db81(var_593adc20, "<dev string:x79>", new_index);
                        player function_4596db81(var_593adc20, "<dev string:x7f>", 0);
                        player function_4596db81(var_593adc20, "<dev string:x88>", 0);
                        player setup_player_contracts();
                        iprintln("<dev string:x94>" + var_593adc20 + "<dev string:xa3>" + new_index + "<dev string:xb8>" + player.name + "<dev string:xbe>");
                    }
                }
                setdvar(#"hash_7aae1c05f450e7fb", 0);
            }
            if (getdvarint(#"hash_666b1ad096c2e4ba", 0) > 0) {
                if (isdefined(level.players)) {
                    var_593adc20 = getdvarint(#"hash_31824b9ab099d33b", 9);
                    iprintln("<dev string:xd0>");
                    foreach (player in level.players) {
                        if (!isdefined(player)) {
                            continue;
                        }
                        if (isbot(player)) {
                            continue;
                        }
                        if (var_593adc20 >= 3) {
                            player function_4596db81(var_593adc20, "<dev string:x4e>", 0);
                            player setup_player_contracts();
                            iprintln("<dev string:x94>" + var_593adc20 + "<dev string:xe3>" + player.name);
                            continue;
                        }
                        iprintln("<dev string:x94>" + var_593adc20 + "<dev string:xf5>" + player.name);
                    }
                }
                setdvar(#"hash_666b1ad096c2e4ba", 0);
            }
            if (getdvarint(#"scr_contract_msg_front_end_only", 0) > 0) {
                iprintln("<dev string:x107>");
                setdvar(#"scr_contract_msg_front_end_only", 0);
            }
            if (getdvarint(#"scr_contract_msg_debug_on", 0) > 0) {
                iprintln("<dev string:x137>");
                setdvar(#"scr_contract_msg_debug_on", 0);
            }
            wait 0.5;
        }
    }

#/

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0x432f5197, Offset: 0xec0
// Size: 0xb8
function is_contract_active(challenge_index) {
    if (!isdefined(challenge_index)) {
        return false;
    }
    if (!isplayer(self)) {
        return false;
    }
    if (!isdefined(self.pers[#"contracts"])) {
        return false;
    }
    if (!isdefined(self.pers[#"contracts"][challenge_index])) {
        return false;
    }
    if (self.pers[#"contracts"][challenge_index].var_63cc7b72 == -1) {
        return false;
    }
    return true;
}

// Namespace contracts/contracts
// Params 2, eflags: 0x0
// Checksum 0x3836a188, Offset: 0xf80
// Size: 0x4c
function on_hero_ability_kill(ability, victimability) {
    player = self;
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x68f482c2, Offset: 0xfd8
// Size: 0x6c
function function_97ca91fe() {
    player = self;
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
    player function_159cc09f(1013);
    player function_159cc09f(3);
}

// Namespace contracts/contracts
// Params 2, eflags: 0x0
// Checksum 0x73f8f886, Offset: 0x1050
// Size: 0x4c
function function_40a4d808(killcount, ability) {
    player = self;
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
}

// Namespace contracts/contracts
// Params 2, eflags: 0x0
// Checksum 0x7a765f08, Offset: 0x10a8
// Size: 0x4c
function function_a997af9a(killcount, weapon) {
    player = self;
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0xc234bb69, Offset: 0x1100
// Size: 0x3c
function on_player_score(delta_score) {
    self function_159cc09f(1009, delta_score);
    self function_159cc09f(5, delta_score);
}

// Namespace contracts/contracts
// Params 2, eflags: 0x0
// Checksum 0xb5870078, Offset: 0x1148
// Size: 0x34
function function_2ef87fc8(delta_score, var_19f0ea25) {
    if (var_19f0ea25) {
        self function_159cc09f(1011, delta_score);
    }
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0x2a0a9f72, Offset: 0x1188
// Size: 0x38c
function contract_kills(data) {
    victim = data.victim;
    attacker = data.attacker;
    player = attacker;
    weapon = data.weapon;
    time = data.time;
    player function_159cc09f(1015);
    player function_159cc09f(4);
    if (weapon.isheroweapon === 1) {
        player function_159cc09f(1012);
        player function_159cc09f(7);
    }
    iskillstreak = isdefined(data.einflictor) && isdefined(data.einflictor.killstreakid);
    if (!iskillstreak && isdefined(level.iskillstreakweapon)) {
        iskillstreakweapon = [[ level.iskillstreakweapon ]](weapon);
    }
    if (iskillstreak || iskillstreakweapon === 1) {
        player function_159cc09f(1010);
        player function_159cc09f(8);
    }
    var_aedadde = weapon.statindex;
    if (player isitempurchased(var_aedadde)) {
        weaponclass = util::getweaponclass(weapon);
        switch (weaponclass) {
        case #"weapon_assault":
            player function_159cc09f(1019);
            break;
        case #"weapon_smg":
            player function_159cc09f(1020);
            break;
        case #"weapon_sniper":
            player function_159cc09f(1021);
            break;
        case #"weapon_lmg":
            player function_159cc09f(1022);
            break;
        case #"weapon_cqb":
            player function_159cc09f(1023);
            break;
        case #"weapon_pistol":
            player function_159cc09f(1024);
            break;
        default:
            break;
        }
        var_ae1dbd9f = player gettotalunlockedweaponattachments(weapon);
        if (var_ae1dbd9f >= 4) {
            player function_159cc09f(1025);
        }
    }
}

// Namespace contracts/contracts
// Params 2, eflags: 0x0
// Checksum 0xadc90905, Offset: 0x1520
// Size: 0x4c
function function_159cc09f(var_62d51442, delta) {
    if (self is_contract_active(var_62d51442)) {
        self function_393b42c0(var_62d51442, delta);
    }
}

// Namespace contracts/contracts
// Params 2, eflags: 0x0
// Checksum 0xa9b388f1, Offset: 0x1578
// Size: 0x4b4
function function_393b42c0(var_62d51442, delta = 1) {
    slot = self.pers[#"contracts"][var_62d51442].slot;
    target_value = self.pers[#"contracts"][var_62d51442].target_value;
    /#
        if (getdvarint(#"scr_contract_debug_multiplier", 0) > 0) {
            delta *= getdvarint(#"scr_contract_debug_multiplier", 1);
        }
    #/
    old_progress = get_contract_stat(slot, "progress");
    new_progress = old_progress + delta;
    if (new_progress > target_value) {
        new_progress = target_value;
    }
    if (new_progress != old_progress) {
        self function_4596db81(slot, "progress", new_progress);
    }
    just_completed = 0;
    if (old_progress < target_value && target_value <= new_progress) {
        just_completed = 1;
        event = #"hash_20ba407211eb6136";
        var_4836ff5c = 0;
        if (slot == 2) {
            event = #"hash_40363f99f3682006";
            var_4836ff5c = 1;
            self function_7f3b8f93(function_8020225b());
            self function_4596db81(2, "award_given", 1);
        } else if (slot == 0 || slot == 1) {
            var_33bbd9b0 = 1;
            if (slot == 1) {
                var_33bbd9b0 = 0;
            }
            foreach (var_38be1b03 in self.pers[#"contracts"]) {
                if (var_38be1b03.slot == var_33bbd9b0) {
                    if (var_38be1b03.target_value <= get_contract_stat(var_33bbd9b0, "progress")) {
                        var_4836ff5c = 1;
                        self function_7f3b8f93(function_ad00e83());
                        self function_4596db81(0, "award_given", 1);
                        self function_4596db81(1, "award_given", 1);
                    }
                    break;
                }
            }
        }
        /#
            var_593adc20 = getdvarint(#"hash_31824b9ab099d33b", 9);
            if (slot == var_593adc20) {
                if (var_62d51442 >= 1000 && var_62d51442 <= 2999) {
                    event = #"hash_40363f99f3682006";
                }
                var_4836ff5c = 1;
            }
        #/
        self luinotifyevent(event, 2, var_62d51442, var_4836ff5c);
    }
    /#
        if (getdvarint(#"scr_contract_debug", 0) > 0) {
            iprintln("<dev string:x94>" + slot + "<dev string:x15d>" + var_62d51442 + "<dev string:x16b>" + new_progress + "<dev string:x177>" + target_value);
        }
    #/
}

// Namespace contracts/contracts
// Params 2, eflags: 0x0
// Checksum 0x87b5bd19, Offset: 0x1a38
// Size: 0x3a
function get_contract_stat(slot, stat_name) {
    return self stats::get_stat(#"contracts", slot, stat_name);
}

// Namespace contracts/contracts
// Params 3, eflags: 0x0
// Checksum 0xda89a9f7, Offset: 0x1a80
// Size: 0x42
function function_4596db81(slot, stat_name, stat_value) {
    return self stats::set_stat(#"contracts", slot, stat_name, stat_value);
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0xf2c985f9, Offset: 0x1ad0
// Size: 0xb4
function function_7f3b8f93(amount) {
    if (!isdefined(self)) {
        return;
    }
    if (amount <= 0) {
        return;
    }
    current_amount = isdefined(self stats::get_stat(#"mp_loot_xp_due")) ? self stats::get_stat(#"mp_loot_xp_due") : 0;
    new_amount = current_amount + amount;
    self stats::set_stat(#"mp_loot_xp_due", new_amount);
}

// Namespace contracts/contracts
// Params 2, eflags: 0x0
// Checksum 0x68f7eb6d, Offset: 0x1b90
// Size: 0x19a
function get_hero_weapon_mask(attacker, weapon) {
    if (!isdefined(weapon)) {
        return 0;
    }
    switch (weapon.name) {
    case #"hero_minigun":
        return 1;
    case #"hero_flamethrower":
        return 2;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        return 4;
    case #"hero_firefly_swarm":
    case #"hero_chemicalgelgun":
        return 8;
    case #"hero_pineapple_grenade":
    case #"hero_pineapplegun":
        return 16;
    case #"hero_armblade":
        return 32;
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
    case #"hero_bowlauncher":
        return 64;
    case #"hero_gravityspikes":
        return 128;
    case #"hero_annihilator":
        return 256;
    default:
        return 0;
    }
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0x223cd117, Offset: 0x1d38
// Size: 0x11a
function get_hero_ability_mask(ability) {
    if (!isdefined(ability)) {
        return 0;
    }
    switch (ability.name) {
    case #"gadget_clone":
        return 1;
    case #"gadget_heat_wave":
        return 2;
    case #"gadget_resurrect":
        return 8;
    case #"gadget_armor":
        return 16;
    case #"gadget_camo":
        return 32;
    case #"gadget_vision_pulse":
        return 64;
    case #"gadget_speed_burst":
        return 128;
    case #"gadget_combat_efficiency":
        return 256;
    default:
        return 0;
    }
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0x6eb18613, Offset: 0x1e60
// Size: 0xc
function function_ed438349(data) {
    
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0xc297a22f, Offset: 0x1e78
// Size: 0xbc
function contract_win(winner) {
    winner function_159cc09f(1000);
    winner function_159cc09f(1);
    if (util::is_objective_game(level.gametype)) {
        winner function_159cc09f(2);
    }
    if (isarenamode()) {
        winner function_159cc09f(1001);
    }
    function_6bbf5440(winner);
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0x60b668c0, Offset: 0x1f40
// Size: 0x21a
function function_6bbf5440(winner) {
    switch (level.gametype) {
    case #"tdm":
        winner function_159cc09f(1002);
        break;
    case #"ball":
        winner function_159cc09f(1003);
        break;
    case #"escort":
        winner function_159cc09f(1004);
        break;
    case #"conf":
        winner function_159cc09f(1005);
        break;
    case #"sd":
        winner function_159cc09f(1006);
        break;
    case #"koth":
        winner function_159cc09f(1007);
        break;
    case #"dom":
        winner function_159cc09f(1008);
        break;
    case #"ctf":
        winner function_159cc09f(1026);
        break;
    case #"dem":
        winner function_159cc09f(1027);
        break;
    case #"dm":
        winner function_159cc09f(1028);
        break;
    default:
        break;
    }
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0xf93830e6, Offset: 0x2168
// Size: 0x34
function function_88a1d86d() {
    self function_159cc09f(1018);
    self function_159cc09f(6);
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0xa9176ede, Offset: 0x21a8
// Size: 0x34
function function_f14de7eb() {
    self function_159cc09f(1017);
    self function_159cc09f(6);
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0xb6128785, Offset: 0x21e8
// Size: 0x24
function on_headshot_kill() {
    self function_159cc09f(1016, 1);
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x26f8457c, Offset: 0x2218
// Size: 0x1de
function function_d27143cc() {
    player = self;
    if (!isdefined(player.pers[#"contracts"])) {
        return false;
    }
    var_fad2205f = 2;
    if (get_contract_stat(var_fad2205f, "active") && !get_contract_stat(var_fad2205f, "award_given")) {
        if (function_9771fff9(var_fad2205f)) {
            player function_4596db81(var_fad2205f, "award_given", 1);
        }
    }
    var_bfbff963 = 0;
    var_4db88a28 = 1;
    if (get_contract_stat(var_bfbff963, "active") && !get_contract_stat(var_bfbff963, "award_given") && get_contract_stat(var_4db88a28, "active") && !get_contract_stat(var_4db88a28, "award_given")) {
        if (function_9771fff9(var_bfbff963) && function_9771fff9(var_4db88a28)) {
            player function_4596db81(var_bfbff963, "award_given", 1);
            player function_4596db81(var_4db88a28, "award_given", 1);
        }
    }
    return false;
}

// Namespace contracts/contracts
// Params 1, eflags: 0x0
// Checksum 0xb5722ce3, Offset: 0x2400
// Size: 0xd8
function function_9771fff9(slot) {
    player = self;
    var_62d51442 = get_contract_stat(slot, "index");
    if (!isdefined(player.pers[#"contracts"][var_62d51442])) {
        return false;
    }
    progress = player get_contract_stat(slot, "progress");
    target_value = player.pers[#"contracts"][var_62d51442].target_value;
    return progress >= target_value;
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0xa9e84010, Offset: 0x24e0
// Size: 0x4c
function function_8020225b() {
    return getdvarint(#"daily_contract_cryptokey_reward_count", 10) * getdvarint(#"loot_cryptokeycost", 100);
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x5975b74d, Offset: 0x2538
// Size: 0x64
function function_ad00e83() {
    self function_84c79e8a();
    return getdvarint(#"weekly_contract_cryptokey_reward_count", 30) * getdvarint(#"loot_cryptokeycost", 100);
}

// Namespace contracts/contracts
// Params 0, eflags: 0x0
// Checksum 0x45a4e977, Offset: 0x25a8
// Size: 0x84
function function_84c79e8a() {
    contract_count = self stats::get_stat(#"hash_3540aca568b64a66");
    var_4099d2ec = getdvarint(#"weekly_contract_blackjack_contract_reward_count", 1);
    self stats::set_stat(#"hash_3540aca568b64a66", contract_count + var_4099d2ec);
}

