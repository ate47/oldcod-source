#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_talisman;
#using scripts\zm_common\zm_utility;

#namespace zm_talisman_impatient;

// Namespace zm_talisman_impatient/zm_talisman_impatient
// Params 0, eflags: 0x2
// Checksum 0x66cce731, Offset: 0xe8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_talisman_impatient", &__init__, undefined, undefined);
}

// Namespace zm_talisman_impatient/zm_talisman_impatient
// Params 0, eflags: 0x0
// Checksum 0x4157b3ee, Offset: 0x130
// Size: 0x2c
function __init__() {
    zm_talisman::register_talisman("talisman_impatient", &activate_talisman);
}

// Namespace zm_talisman_impatient/zm_talisman_impatient
// Params 0, eflags: 0x0
// Checksum 0xd418d646, Offset: 0x168
// Size: 0x58
function activate_talisman() {
    self endon(#"disconnect");
    self.var_4113b441 = 0;
    while (true) {
        self waittill(#"bled_out");
        self thread special_revive();
    }
}

// Namespace zm_talisman_impatient/zm_talisman_impatient
// Params 0, eflags: 0x0
// Checksum 0x9c5fa006, Offset: 0x1c8
// Size: 0x134
function special_revive() {
    self endon(#"disconnect", #"end_of_round");
    if (self.var_4113b441 == zm_round_logic::get_round_number()) {
        return;
    }
    if (level.zombie_total <= 3) {
        wait 1;
    }
    n_target_kills = level.zombie_player_killed_count + 100;
    while (level.zombie_player_killed_count < n_target_kills && level.zombie_total >= 3) {
        waitframe(1);
    }
    self.var_4113b441 = zm_round_logic::get_round_number();
    self zm_player::spectator_respawn_player();
    self val::set(#"talisman_impatient", "ignoreme");
    wait 5;
    self val::reset(#"talisman_impatient", "ignoreme");
}

