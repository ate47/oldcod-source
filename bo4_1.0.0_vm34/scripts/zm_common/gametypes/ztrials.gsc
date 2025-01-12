#using script_3967f16b46959350;
#using script_3c5fdcb080338059;
#using script_444bc5b4fa0fe14f;
#using script_641353bdb463450d;
#using script_760b801e43fe3017;
#using script_7828033bc0ecda72;
#using script_7b843bf90a032750;
#using script_c65026898539e6d;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\trials\zm_trial_acquire_perks;
#using scripts\zm_common\trials\zm_trial_acquire_weapon;
#using scripts\zm_common\trials\zm_trial_crawlers_only;
#using scripts\zm_common\trials\zm_trial_damage_drains_points;
#using scripts\zm_common\trials\zm_trial_defend_area;
#using scripts\zm_common\trials\zm_trial_disable_bgbs;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\trials\zm_trial_disable_hero_weapons;
#using scripts\zm_common\trials\zm_trial_disable_hud;
#using scripts\zm_common\trials\zm_trial_disable_perks;
#using scripts\zm_common\trials\zm_trial_disable_upgraded_weapons;
#using scripts\zm_common\trials\zm_trial_force_archetypes;
#using scripts\zm_common\trials\zm_trial_give_reward;
#using scripts\zm_common\trials\zm_trial_headshots_only;
#using scripts\zm_common\trials\zm_trial_no_player_damage;
#using scripts\zm_common\trials\zm_trial_no_powerups;
#using scripts\zm_common\trials\zm_trial_open_all_doors;
#using scripts\zm_common\trials\zm_trial_reset_loadout;
#using scripts\zm_common\trials\zm_trial_restrict_loadout;
#using scripts\zm_common\trials\zm_trial_special_enemy;
#using scripts\zm_common\trials\zm_trial_sprinters_only;
#using scripts\zm_common\trials\zm_trial_survive;
#using scripts\zm_common\trials\zm_trial_timeout;
#using scripts\zm_common\trials\zm_trial_turn_on_power;
#using scripts\zm_common\trials\zm_trial_use_magicbox;
#using scripts\zm_common\trials\zm_trial_use_pack_a_punch;
#using scripts\zm_common\zm_game_module;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace ztrials;

// Namespace ztrials/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x6e4ea3e0, Offset: 0x270
// Size: 0x19c
function event_handler[gametype_init] main(eventstruct) {
    zm_gametype::main();
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level._game_module_custom_spawn_init_func = &zm_gametype::custom_spawn_init_func;
    level._game_module_stat_update_func = &zm_stats::survival_classic_custom_stat_update;
    level._round_start_func = &zm_round_logic::round_start;
    level.var_63f29efd = &function_8dcf71e0;
    level.var_de91b1b0 = &function_2008b9aa;
    level.var_20a032a1 = &function_2008b9aa;
    level.round_end_custom_logic = &function_58bdb444;
    level.round_number = 0;
    level.trial_strikes = 0;
    level flag::init(#"ztrial", 1);
    callback::on_connect(&function_f1cf8f43);
    level._supress_survived_screen = 1;
    setscoreboardcolumns("score", "kills", "downs", "revives", "headshots");
}

// Namespace ztrials/level_init
// Params 1, eflags: 0x40
// Checksum 0x319a432c, Offset: 0x418
// Size: 0xfc
function event_handler[level_init] levelinit(eventstruct) {
    var_9f99900f = "";
    /#
        var_9f99900f = getdvarstring(#"ztrial_name");
    #/
    if (var_9f99900f == "") {
        var_9f99900f = util::get_map_name() + "_default";
    }
    assert(var_9f99900f != "<dev string:x30>");
    level.var_f0a67892 = zm_trial::function_29ac39b6(var_9f99900f);
    assert(isdefined(level.var_f0a67892));
    /#
        function_8e331214();
    #/
}

// Namespace ztrials/ztrials
// Params 0, eflags: 0x0
// Checksum 0x866c8419, Offset: 0x520
// Size: 0x1e
function onprecachegametype() {
    level.canplayersuicide = &zm_gametype::canplayersuicide;
}

// Namespace ztrials/ztrials
// Params 0, eflags: 0x0
// Checksum 0xf769def6, Offset: 0x548
// Size: 0x16c
function onstartgametype() {
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    structs = struct::get_array("player_respawn_point", "targetname");
    foreach (struct in structs) {
        level.spawnmins = math::expand_mins(level.spawnmins, struct.origin);
        level.spawnmaxs = math::expand_maxs(level.spawnmaxs, struct.origin);
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    changeadvertisedstatus(0);
}

// Namespace ztrials/ztrials
// Params 0, eflags: 0x4
// Checksum 0xb4dfe372, Offset: 0x6c0
// Size: 0x44
function private function_f1cf8f43() {
    level flag::wait_till("start_zombie_round_logic");
    waitframe(1);
    self zm_laststand::function_7996dd34(0);
}

// Namespace ztrials/ztrials
// Params 1, eflags: 0x4
// Checksum 0xe4a2eeb7, Offset: 0x710
// Size: 0x216
function private function_8dcf71e0(player) {
    if (player hasperk(#"specialty_berserker") && !(isdefined(player.var_7684df5b) && player.var_7684df5b)) {
        return true;
    }
    if (level flag::get("round_reset")) {
        return true;
    }
    var_9fb91af5 = [];
    foreach (player in getplayers()) {
        array::add(var_9fb91af5, player, 0);
    }
    if (var_9fb91af5.size > 1) {
        zm_trial::fail(#"hash_60e5e8df8709ad64", var_9fb91af5);
    } else if (var_9fb91af5.size == 1) {
        zm_trial::fail(#"hash_272fae998263208b", var_9fb91af5);
    } else {
        array::add(var_9fb91af5, player, 0);
        zm_trial::fail(#"hash_272fae998263208b", var_9fb91af5);
    }
    if (level flag::get("round_reset")) {
        return true;
    }
    assert(level flag::get(#"trial_failed"));
    return false;
}

// Namespace ztrials/ztrials
// Params 0, eflags: 0x4
// Checksum 0xc0551c0e, Offset: 0x930
// Size: 0xf4
function private function_58bdb444() {
    assert(isdefined(level.var_f0a67892));
    if (!level flag::get("round_reset") && level.round_number >= level.var_f0a67892.rounds.size) {
        level thread zm_trial::function_2abe2c44();
    }
    if (!level flag::get("round_reset") && !level flag::get(#"trial_failed")) {
        zm_trial_util::function_5b5c3c53(1);
        wait 3;
    }
}

// Namespace ztrials/ztrials
// Params 2, eflags: 0x4
// Checksum 0xc78df87e, Offset: 0xa30
// Size: 0xd6
function private function_2008b9aa(e_door, n_cost) {
    e_door notify(#"hash_42c191c31ed08a4");
    e_door endon(#"hash_42c191c31ed08a4");
    e_door endon(#"death");
    while (true) {
        if (n_cost > 0 && zm_trial_disable_buys::is_active()) {
            e_door sethintstring(#"hash_55d25caf8f7bbb2f");
        } else {
            e_door zm_utility::set_hint_string(self, "default_buy_door", n_cost);
        }
        waitframe(1);
    }
}

/#

    // Namespace ztrials/ztrials
    // Params 0, eflags: 0x4
    // Checksum 0x1aab69e, Offset: 0xb10
    // Size: 0x106
    function private complete_current_round() {
        level.devcheater = 1;
        level.zombie_total = 0;
        level notify(#"kill_round");
        wait 1;
        zombies = getaiteamarray(level.zombie_team);
        if (isdefined(zombies)) {
            for (i = 0; i < zombies.size; i++) {
                if (isdefined(zombies[i].ignore_devgui_death) && zombies[i].ignore_devgui_death) {
                    continue;
                }
                zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
            }
        }
    }

    // Namespace ztrials/ztrials
    // Params 1, eflags: 0x4
    // Checksum 0xa3a8b0c, Offset: 0xc20
    // Size: 0x198
    function private function_528c90c7(medal) {
        round = undefined;
        switch (medal) {
        case #"gold":
            round = 30;
            break;
        case #"silver":
            round = 20;
            break;
        case #"bronze":
            round = 10;
            break;
        default:
            assert(0);
            break;
        }
        assert(isdefined(round));
        round_info = level.var_f0a67892.rounds[round - 1];
        assert(isdefined(round_info));
        for (i = 0; i < round_info.challenges.size; i++) {
            challenge = round_info.challenges[i];
            if (challenge.name == #"give_reward") {
                return challenge;
            }
        }
        assert(0);
        return undefined;
    }

    // Namespace ztrials/ztrials
    // Params 0, eflags: 0x4
    // Checksum 0x5478a58c, Offset: 0xdc0
    // Size: 0x7de
    function private function_8e331214() {
        assert(isdefined(level.var_f0a67892));
        foreach (round_info in level.var_f0a67892.rounds) {
            adddebugcommand("<dev string:x31>" + round_info.round + "<dev string:x52>" + function_15979fa9(round_info.name) + "<dev string:x54>" + round_info.round + "<dev string:x56>" + round_info.round + "<dev string:x76>");
        }
        for (i = 0; i <= 3; i++) {
            adddebugcommand("<dev string:x79>" + i + "<dev string:x9c>" + i + "<dev string:x76>");
        }
        adddebugcommand("<dev string:xbe>");
        adddebugcommand("<dev string:x10a>");
        adddebugcommand("<dev string:x14e>");
        adddebugcommand("<dev string:x1a7>");
        adddebugcommand("<dev string:x1fa>");
        adddebugcommand("<dev string:x251>");
        while (true) {
            string = getdvarstring(#"hash_57e97658cd1d89e2", "<dev string:x30>");
            cmd = strtok(string, "<dev string:x2a8>");
            if (cmd.size > 0) {
                round_number = int(cmd[0]);
                if (isdefined(level.var_f277a2d8)) {
                    [[ level.var_f277a2d8 ]](round_number);
                }
                level thread zm_game_module::zombie_goto_round(round_number);
                setdvar(#"hash_57e97658cd1d89e2", "<dev string:x30>");
            }
            string = getdvarstring(#"hash_25a4cfc19b09ae41", "<dev string:x30>");
            cmd = strtok(string, "<dev string:x2a8>");
            if (cmd.size > 0) {
                strikes = int(cmd[0]);
                if (strikes == 3) {
                    zm_trial::function_c5280bd8(strikes - 1);
                    zm_trial::fail();
                } else {
                    zm_trial::function_c5280bd8(strikes);
                }
                setdvar(#"hash_25a4cfc19b09ae41", "<dev string:x30>");
            }
            string = getdvarstring(#"hash_2446ebd1d15f0dab", "<dev string:x30>");
            cmd = strtok(string, "<dev string:x2a8>");
            if (cmd.size > 0) {
                complete_current_round();
                setdvar(#"hash_2446ebd1d15f0dab", "<dev string:x30>");
            }
            string = getdvarstring(#"hash_5a32209acb1f54a0", "<dev string:x30>");
            cmd = strtok(string, "<dev string:x2a8>");
            if (cmd.size > 0) {
                zm_trial::fail();
                setdvar(#"hash_5a32209acb1f54a0", "<dev string:x30>");
            }
            string = getdvarstring(#"hash_1576c65ebdf43de0", "<dev string:x30>");
            cmd = strtok(string, "<dev string:x2a8>");
            if (cmd.size > 0) {
                foreach (player in getplayers()) {
                    player zm_stats::function_5cf52256("<dev string:x2aa>", 0);
                    player zm_stats::function_5cf52256("<dev string:x2c3>", 0);
                    player zm_stats::function_5cf52256("<dev string:x2dc>", 0);
                }
                level.var_58858a0f = [];
                setdvar(#"hash_1576c65ebdf43de0", "<dev string:x30>");
            }
            string = getdvarstring(#"hash_2f6ef50454652bf2", "<dev string:x30>");
            cmd = strtok(string, "<dev string:x2a8>");
            if (cmd.size > 0) {
                challenge = function_528c90c7(cmd[0]);
                foreach (player in getplayers()) {
                    player luinotifyevent(#"hash_8d33c3be569f08", 1, challenge.row);
                    stat_name = challenge.params[1];
                    curr_time = gettime();
                    player zm_stats::function_5cf52256(stat_name, curr_time);
                }
                setdvar(#"hash_2f6ef50454652bf2", "<dev string:x30>");
            }
            waitframe(1);
        }
    }

#/
