#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_acquire_weapon;

// Namespace zm_trial_acquire_weapon/zm_trial_acquire_weapon
// Params 0, eflags: 0x2
// Checksum 0xd779e081, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_acquire_weapon", &__init__, undefined, undefined);
}

// Namespace zm_trial_acquire_weapon/zm_trial_acquire_weapon
// Params 0, eflags: 0x0
// Checksum 0x6a4ae452, Offset: 0xe0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"acquire_weapon", &on_begin, &on_end);
}

// Namespace zm_trial_acquire_weapon/zm_trial_acquire_weapon
// Params 1, eflags: 0x4
// Checksum 0xcb793653, Offset: 0x148
// Size: 0x4a0
function private on_begin(weapon_name) {
    if (weapon_name == #"hero_lv3_weapon") {
        hero_lv3_weapons = array(#"hero_chakram_lv3", #"hero_hammer_lv3", #"hero_scepter_lv3", #"hero_sword_pistol_lv3");
        level.var_e9834d36 = [];
        foreach (var_111df8b2 in hero_lv3_weapons) {
            if (!isdefined(level.var_e9834d36)) {
                level.var_e9834d36 = [];
            } else if (!isarray(level.var_e9834d36)) {
                level.var_e9834d36 = array(level.var_e9834d36);
            }
            if (!isinarray(level.var_e9834d36, getweapon(var_111df8b2))) {
                level.var_e9834d36[level.var_e9834d36.size] = getweapon(var_111df8b2);
            }
        }
    } else if (weapon_name == #"upgraded_weapon") {
        assert(isdefined(level.zombie_weapons_upgraded));
        level.var_e9834d36 = [];
        foreach (weapon in getarraykeys(level.zombie_weapons_upgraded)) {
            if (weapon != level.weaponnone) {
                if (!isdefined(level.var_e9834d36)) {
                    level.var_e9834d36 = [];
                } else if (!isarray(level.var_e9834d36)) {
                    level.var_e9834d36 = array(level.var_e9834d36);
                }
                if (!isinarray(level.var_e9834d36, weapon)) {
                    level.var_e9834d36[level.var_e9834d36.size] = weapon;
                }
            }
        }
    } else {
        level.var_e9834d36 = array(getweapon(weapon_name));
    }
    /#
        assert(isdefined(level.var_e9834d36));
        foreach (weapon in level.var_e9834d36) {
            assert(isdefined(weapon));
            assert(weapon != level.weaponnone);
        }
    #/
    foreach (player in getplayers()) {
        player thread function_3892746b();
    }
}

// Namespace zm_trial_acquire_weapon/zm_trial_acquire_weapon
// Params 1, eflags: 0x4
// Checksum 0xe59ac88f, Offset: 0x5f0
// Size: 0x27a
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player zm_trial_util::function_fccd8386();
    }
    assert(isdefined(level.var_e9834d36));
    assert(isdefined(level.var_e9834d36.size > 0));
    if (!round_reset) {
        var_9fb91af5 = [];
        foreach (player in getplayers()) {
            assert(isdefined(player.var_b4c8435f));
            if (!player.var_b4c8435f) {
                array::add(var_9fb91af5, player, 0);
            }
        }
        if (var_9fb91af5.size == 1) {
            zm_trial::fail(#"hash_753fe45bee19e131", var_9fb91af5);
        } else if (var_9fb91af5.size > 1) {
            zm_trial::fail(#"hash_3539a53b7cf9ea2", var_9fb91af5);
        }
    }
    foreach (player in getplayers()) {
        player.var_b4c8435f = undefined;
    }
    level.var_e9834d36 = undefined;
}

// Namespace zm_trial_acquire_weapon/zm_trial_acquire_weapon
// Params 0, eflags: 0x4
// Checksum 0x4a3016bd, Offset: 0x878
// Size: 0xa6
function private function_4bb1e9bd() {
    if (self.sessionstate != "spectator") {
        self.var_b4c8435f = 0;
        foreach (weapon in level.var_e9834d36) {
            if (self hasweapon(weapon)) {
                self.var_b4c8435f = 1;
            }
        }
    }
}

// Namespace zm_trial_acquire_weapon/zm_trial_acquire_weapon
// Params 0, eflags: 0x4
// Checksum 0x29afa956, Offset: 0x928
// Size: 0x96
function private function_3892746b() {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    self.var_b4c8435f = 0;
    while (true) {
        self function_4bb1e9bd();
        if (self.var_b4c8435f) {
            self zm_trial_util::function_9eca2595(1);
        } else {
            self zm_trial_util::function_9eca2595(0);
        }
        waitframe(1);
    }
}

