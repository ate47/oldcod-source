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
// Params 1, eflags: 0x0
// Checksum 0xb832dd17, Offset: 0xf0
// Size: 0xa2
function figure_out_friendly_fire(victim) {
    if (level.hardcoremode && level.friendlyfire > 0 && isdefined(victim) && victim.is_capturing_own_supply_drop === 1) {
        return 2;
    }
    if (killstreaks::is_ricochet_protected(victim)) {
        return 2;
    }
    if (isdefined(level.figure_out_gametype_friendly_fire)) {
        return [[ level.figure_out_gametype_friendly_fire ]](victim);
    }
    return level.friendlyfire;
}

// Namespace player/player_utils
// Params 0, eflags: 0x0
// Checksum 0x900ff9db, Offset: 0x1a0
// Size: 0xfc
function freeze_player_for_round_end() {
    self hud_message::clearlowermessage();
    if (!ispc()) {
        self closeingamemenu();
    }
    self val::set(#"freeze_player_for_round_end", "freezecontrols");
    self val::set(#"freeze_player_for_round_end", "disablegadgets");
    currentweapon = self getcurrentweapon();
    if (killstreaks::is_killstreak_weapon(currentweapon) && !currentweapon.iscarriedkillstreak) {
        self takeweapon(currentweapon);
    }
}

// Namespace player/player_utils
// Params 1, eflags: 0x0
// Checksum 0xeafdcd32, Offset: 0x2a8
// Size: 0xe4
function function_b0782357(team) {
    if (isdefined(level.takelivesondeath) && level.takelivesondeath) {
        teamid = "team" + level.teamindex[team];
        if (isdefined(level.var_1c4b75ec[team]) && level.var_1c4b75ec[team]) {
            clientfield::set_world_uimodel("hudItems." + teamid + ".livesCount", level.playerlives[team]);
            return;
        }
        clientfield::set_world_uimodel("hudItems." + teamid + ".livesCount", game.lives[team]);
    }
}

// Namespace player/player_utils
// Params 0, eflags: 0x0
// Checksum 0x2257f27b, Offset: 0x398
// Size: 0x6c
function function_8c628e44() {
    return self hasperk(#"specialty_stunprotection") || self hasperk(#"specialty_flashprotection") || self hasperk(#"specialty_proximityprotection");
}

// Namespace player/player_utils
// Params 2, eflags: 0x0
// Checksum 0xb220859f, Offset: 0x410
// Size: 0x64
function function_b0320e78(func, threaded = 1) {
    array::add(level.var_6e29ff90, {#callback:func, #threaded:threaded});
}

// Namespace player/player_utils
// Params 2, eflags: 0x0
// Checksum 0x44eb818d, Offset: 0x480
// Size: 0x64
function function_74c335a(func, threaded = 1) {
    array::add(level.var_66d37717, {#callback:func, #threaded:threaded});
}

