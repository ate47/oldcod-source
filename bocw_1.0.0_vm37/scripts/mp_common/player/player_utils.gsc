#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\mp\killstreaks;
#using scripts\mp_common\util;

#namespace player;

// Namespace player/player_utils
// Params 2, eflags: 0x0
// Checksum 0x63ca565a, Offset: 0xf0
// Size: 0xfe
function figure_out_friendly_fire(victim, attacker) {
    if (level.hardcoremode && level.friendlyfire > 0 && isdefined(victim) && victim.is_capturing_own_supply_drop === 1) {
        return 2;
    }
    if (killstreaks::is_ricochet_protected(victim)) {
        return 2;
    }
    if (level.friendlyfire == 4 && isplayer(attacker)) {
        if (attacker.pers[#"teamkills_nostats"] < level.var_fe3ff9c1) {
            return 1;
        } else {
            return 2;
        }
    }
    if (isdefined(level.figure_out_gametype_friendly_fire)) {
        return [[ level.figure_out_gametype_friendly_fire ]](victim);
    }
    return level.friendlyfire;
}

// Namespace player/player_utils
// Params 0, eflags: 0x0
// Checksum 0x15cdd41f, Offset: 0x1f8
// Size: 0xc4
function freeze_player_for_round_end() {
    self hud_message::clearlowermessage();
    if (!self function_8b1a219a()) {
        self closeingamemenu();
    }
    function_7be72477(0);
    currentweapon = self getcurrentweapon();
    if (killstreaks::is_killstreak_weapon(currentweapon) && !currentweapon.iscarriedkillstreak) {
        self takeweapon(currentweapon);
    }
}

// Namespace player/player_utils
// Params 1, eflags: 0x0
// Checksum 0xf914eb30, Offset: 0x2c8
// Size: 0x19c
function function_a074b96f(enabled) {
    if (enabled) {
        if (!is_true(level.var_3d1e480e)) {
            if (is_true(getgametypesetting(#"hash_1b85ace023e616a1"))) {
                self val::function_4671dfff(#"spawn_player", 1);
            } else {
                self val::set(#"spawn_player", "freezecontrols");
                self val::set(#"spawn_player", "disablegadgets");
            }
        }
        return;
    }
    if (is_true(getgametypesetting(#"hash_1b85ace023e616a1"))) {
        self val::function_4671dfff(#"spawn_player", 0);
        return;
    }
    self val::reset(#"spawn_player", "freezecontrols");
    self val::reset(#"spawn_player", "disablegadgets");
}

// Namespace player/player_utils
// Params 1, eflags: 0x0
// Checksum 0x400545b1, Offset: 0x470
// Size: 0x17c
function function_7be72477(enabled) {
    if (enabled) {
        if (is_true(getgametypesetting(#"hash_16e0649caf2f76b5"))) {
            self val::function_5276aede(#"freeze_player_for_round_end", 1);
        } else {
            self val::set(#"freeze_player_for_round_end", "freezecontrols");
            self val::set(#"freeze_player_for_round_end", "disablegadgets");
        }
        return;
    }
    if (is_true(getgametypesetting(#"hash_16e0649caf2f76b5"))) {
        self val::function_5276aede(#"freeze_player_for_round_end", 0);
        return;
    }
    self val::reset(#"freeze_player_for_round_end", "freezecontrols");
    self val::reset(#"freeze_player_for_round_end", "disablegadgets");
}

// Namespace player/player_utils
// Params 1, eflags: 0x0
// Checksum 0x274d5709, Offset: 0x5f8
// Size: 0x11c
function function_c49fc862(team) {
    if (is_true(level.takelivesondeath) && is_true(level.teambased) && !is_true(level.var_a5f54d9f)) {
        teamid = "team" + level.teamindex[team];
        if (is_true(level.var_61952d8b[team])) {
            clientfield::set_world_uimodel("hudItems." + teamid + ".livesCount", level.playerlives[team]);
            return;
        }
        clientfield::set_world_uimodel("hudItems." + teamid + ".livesCount", game.lives[team]);
    }
}

// Namespace player/player_utils
// Params 0, eflags: 0x0
// Checksum 0x33a0bf44, Offset: 0x720
// Size: 0x22
function function_14e61d05() {
    return self hasperk(#"hash_5fef46715b368a6e");
}

// Namespace player/player_utils
// Params 2, eflags: 0x0
// Checksum 0xb5c7f7da, Offset: 0x750
// Size: 0x64
function function_cf3aa03d(func, threaded = 1) {
    array::add(level.var_da2045d0, {#callback:func, #threaded:threaded});
}

// Namespace player/player_utils
// Params 2, eflags: 0x0
// Checksum 0x7b931598, Offset: 0x7c0
// Size: 0x64
function function_3c5cc656(func, threaded = 1) {
    array::add(level.var_fa66fada, {#callback:func, #threaded:threaded});
}

