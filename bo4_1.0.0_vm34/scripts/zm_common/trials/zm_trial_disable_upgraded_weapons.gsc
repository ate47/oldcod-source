#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_disable_upgraded_weapons;

// Namespace zm_trial_disable_upgraded_weapons/zm_trial_disable_upgraded_weapons
// Params 0, eflags: 0x2
// Checksum 0xc0881597, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_disable_upgraded_weapons", &__init__, undefined, undefined);
}

// Namespace zm_trial_disable_upgraded_weapons/zm_trial_disable_upgraded_weapons
// Params 0, eflags: 0x0
// Checksum 0x3caea64, Offset: 0xd0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_7dd35595d2a7953a", &on_begin, &on_end);
}

// Namespace zm_trial_disable_upgraded_weapons/zm_trial_disable_upgraded_weapons
// Params 0, eflags: 0x4
// Checksum 0x612f81ed, Offset: 0x138
// Size: 0x1c4
function private on_begin() {
    assert(isdefined(level.zombie_weapons_upgraded));
    level.var_97ff67ee = [];
    foreach (upgraded_weapon in getarraykeys(level.zombie_weapons_upgraded)) {
        level.var_97ff67ee[upgraded_weapon.name] = upgraded_weapon;
    }
    foreach (player in getplayers()) {
        player function_e10dc163();
        player callback::function_c4f1b25e(&function_c4f1b25e);
        player zm_trial_util::function_f9e294e9(1);
        player callback::on_weapon_change(&zm_trial_util::function_2033328b);
    }
    zm_trial_util::function_5af41a8();
    level zm_trial::function_577f4821(1);
}

// Namespace zm_trial_disable_upgraded_weapons/zm_trial_disable_upgraded_weapons
// Params 1, eflags: 0x4
// Checksum 0xeb376681, Offset: 0x308
// Size: 0x1dc
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player callback::function_4c693f09(&function_c4f1b25e);
        player callback::remove_on_weapon_change(&zm_trial_util::function_2033328b);
        foreach (weapon in player getweaponslist(1)) {
            player unlockweapon(weapon);
            if (weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone) {
                player unlockweapon(weapon.dualwieldweapon);
            }
        }
        player zm_trial_util::function_f9e294e9(1);
    }
    level.var_97ff67ee = undefined;
    zm_trial_util::function_4662a26f();
    level zm_trial::function_577f4821(0);
}

// Namespace zm_trial_disable_upgraded_weapons/zm_trial_disable_upgraded_weapons
// Params 0, eflags: 0x0
// Checksum 0x4f0de0d4, Offset: 0x4f0
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_871c1f7f(#"hash_7dd35595d2a7953a");
    return isdefined(challenge);
}

// Namespace zm_trial_disable_upgraded_weapons/zm_trial_disable_upgraded_weapons
// Params 1, eflags: 0x4
// Checksum 0x247f2de6, Offset: 0x530
// Size: 0x24
function private function_c4f1b25e(eventstruct) {
    self function_e10dc163();
}

// Namespace zm_trial_disable_upgraded_weapons/zm_trial_disable_upgraded_weapons
// Params 0, eflags: 0x4
// Checksum 0x1c8fd0db, Offset: 0x560
// Size: 0x160
function private function_e10dc163() {
    assert(isdefined(level.var_97ff67ee));
    foreach (weapon in self getweaponslist(1)) {
        if (isdefined(level.var_97ff67ee[weapon.name])) {
            self lockweapon(weapon);
        } else {
            self unlockweapon(weapon);
        }
        if (weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone) {
            if (self function_8782fa47(weapon)) {
                self lockweapon(weapon.dualwieldweapon);
                continue;
            }
            self unlockweapon(weapon.dualwieldweapon);
        }
    }
}

