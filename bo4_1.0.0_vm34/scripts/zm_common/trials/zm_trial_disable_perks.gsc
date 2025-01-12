#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_disable_perks;

// Namespace zm_trial_disable_perks/zm_trial_disable_perks
// Params 0, eflags: 0x2
// Checksum 0xaf46b5d, Offset: 0xb0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_disable_perks", &__init__, undefined, undefined);
}

// Namespace zm_trial_disable_perks/zm_trial_disable_perks
// Params 0, eflags: 0x0
// Checksum 0xe704a617, Offset: 0xf8
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"disable_perks", &on_begin, &on_end);
}

// Namespace zm_trial_disable_perks/zm_trial_disable_perks
// Params 0, eflags: 0x4
// Checksum 0xa9a994b8, Offset: 0x160
// Size: 0xec
function private on_begin() {
    level zm_trial::function_e6903c38(1);
    assert(isdefined(level.var_3d574fc8));
    foreach (player in getplayers()) {
        player function_4ddd6e98();
        player.var_a28b87 = player zm_trial_util::function_afc1efee(0);
    }
    zm_trial_util::function_8d6f6c09();
}

// Namespace zm_trial_disable_perks/zm_trial_disable_perks
// Params 1, eflags: 0x4
// Checksum 0xbc6cf511, Offset: 0x258
// Size: 0x104
function private on_end(round_reset) {
    level zm_trial::function_e6903c38(0);
    foreach (player in getplayers()) {
        assert(isdefined(player.var_a28b87));
        player zm_trial_util::function_e023e6a5(player.var_a28b87);
        player function_38652e3e();
        player.var_a28b87 = undefined;
    }
    zm_trial_util::function_46e52c6b();
}

// Namespace zm_trial_disable_perks/zm_trial_disable_perks
// Params 0, eflags: 0x0
// Checksum 0x5631a7da, Offset: 0x368
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_871c1f7f(#"disable_perks");
    return isdefined(challenge);
}

// Namespace zm_trial_disable_perks/zm_trial_disable_perks
// Params 1, eflags: 0x0
// Checksum 0xece9b385, Offset: 0x3a8
// Size: 0xde
function lose_perk(perk) {
    if (!is_active()) {
        return false;
    }
    slot = self zm_perks::function_ec1dff78(perk);
    assert(slot != -1);
    assert(isdefined(self.var_a28b87));
    if (self.var_a28b87.var_d9b8b0f4[slot]) {
        arrayremovevalue(self.var_83ef9ace, perk, 0);
        self.var_a28b87.var_d9b8b0f4[slot] = 0;
        return true;
    }
    return false;
}

// Namespace zm_trial_disable_perks/zm_trial_disable_perks
// Params 0, eflags: 0x4
// Checksum 0x2d65ca70, Offset: 0x490
// Size: 0x3a
function private function_4ddd6e98() {
    self player::generate_weapon_data();
    self.var_a0082e0b = self._generated_weapons;
    self._generated_current_weapon = undefined;
    self._generated_weapons = undefined;
}

// Namespace zm_trial_disable_perks/zm_trial_disable_perks
// Params 0, eflags: 0x4
// Checksum 0x4ed7b977, Offset: 0x4d8
// Size: 0x1c6
function private function_38652e3e() {
    assert(isdefined(self.var_a0082e0b));
    if (isinarray(self.var_ee217989, #"specialty_additionalprimaryweapon") && isdefined(self.var_a28b87.additional_primary_weapon) && !self hasweapon(self.var_a28b87.additional_primary_weapon)) {
        var_eee55a33 = undefined;
        foreach (weapondata in self.var_a0082e0b) {
            weapon = util::get_weapon_by_name(weapondata[#"weapon"], weapondata[#"attachments"]);
            if (weapon == self.var_a28b87.additional_primary_weapon) {
                var_eee55a33 = weapondata;
                break;
            }
        }
        assert(isdefined(var_eee55a33));
        self player::weapondata_give(var_eee55a33);
        self zm_trial_util::function_93ced8f4(self.var_a28b87);
    }
    self.var_a0082e0b = undefined;
}

