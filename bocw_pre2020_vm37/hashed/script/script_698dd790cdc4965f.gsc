#using script_35d3717bf2cbee8f;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace namespace_83dc3729;

// Namespace namespace_83dc3729/namespace_83dc3729
// Params 0, eflags: 0x6
// Checksum 0x3b682d30, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_491590ee8fe06753", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_83dc3729/namespace_83dc3729
// Params 0, eflags: 0x5 linked
// Checksum 0xc76520d0, Offset: 0xd0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_7dd35595d2a7953a", &on_begin, &on_end);
}

// Namespace namespace_83dc3729/namespace_83dc3729
// Params 0, eflags: 0x5 linked
// Checksum 0x5a512f4c, Offset: 0x138
// Size: 0x1dc
function private on_begin() {
    assert(isdefined(level.zombie_weapons_upgraded));
    level.var_af806901 = [];
    foreach (upgraded_weapon in getarraykeys(level.zombie_weapons_upgraded)) {
        level.var_af806901[upgraded_weapon.name] = upgraded_weapon;
    }
    foreach (player in getplayers()) {
        player function_6a8979c9();
        player callback::function_33f0ddd3(&function_33f0ddd3);
        player zm_trial_util::function_7dbb1712(1);
        player callback::on_weapon_change(&zm_trial_util::function_79518194);
    }
    zm_trial_util::function_eea26e56();
    level zm_trial::function_8e2a923(1);
}

// Namespace namespace_83dc3729/namespace_83dc3729
// Params 1, eflags: 0x5 linked
// Checksum 0x56c0b88f, Offset: 0x320
// Size: 0x1ec
function private on_end(*round_reset) {
    foreach (player in getplayers()) {
        player callback::function_824d206(&function_33f0ddd3);
        player callback::remove_on_weapon_change(&zm_trial_util::function_79518194);
        foreach (weapon in player getweaponslist(1)) {
            player unlockweapon(weapon);
            if (weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone) {
                player unlockweapon(weapon.dualwieldweapon);
            }
        }
        player zm_trial_util::function_7dbb1712(1);
    }
    level.var_af806901 = undefined;
    zm_trial_util::function_ef1fce77();
    level zm_trial::function_8e2a923(0);
}

// Namespace namespace_83dc3729/namespace_83dc3729
// Params 0, eflags: 0x1 linked
// Checksum 0xa26b6684, Offset: 0x518
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"hash_7dd35595d2a7953a");
    return isdefined(challenge);
}

// Namespace namespace_83dc3729/namespace_83dc3729
// Params 1, eflags: 0x5 linked
// Checksum 0xe7c11342, Offset: 0x558
// Size: 0x24
function private function_33f0ddd3(*eventstruct) {
    self function_6a8979c9();
}

// Namespace namespace_83dc3729/namespace_83dc3729
// Params 0, eflags: 0x5 linked
// Checksum 0xd4a1021, Offset: 0x588
// Size: 0x1c0
function private function_6a8979c9() {
    assert(isdefined(level.var_af806901));
    foreach (weapon in self getweaponslist(1)) {
        if (isdefined(level.var_af806901[weapon.name])) {
            self function_28602a03(weapon);
        } else if (!namespace_fc5170d1::is_active() || !isarray(level.var_3e2ac3b6) || !isdefined(level.var_3e2ac3b6[weapon.name])) {
            self unlockweapon(weapon);
        }
        if (weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone) {
            if (self function_635f9c02(weapon)) {
                self function_28602a03(weapon.dualwieldweapon);
                continue;
            }
            self unlockweapon(weapon.dualwieldweapon);
        }
    }
}

