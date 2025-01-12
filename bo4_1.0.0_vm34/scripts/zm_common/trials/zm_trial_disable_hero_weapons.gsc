#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_disable_hero_weapons;

// Namespace zm_trial_disable_hero_weapons/zm_trial_disable_hero_weapons
// Params 0, eflags: 0x2
// Checksum 0x2c0fe3a4, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_disable_hero_weapons", &__init__, undefined, undefined);
}

// Namespace zm_trial_disable_hero_weapons/zm_trial_disable_hero_weapons
// Params 0, eflags: 0x0
// Checksum 0xf96539a8, Offset: 0xd0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_c2ef6223096d3ca", &on_begin, &on_end);
}

// Namespace zm_trial_disable_hero_weapons/zm_trial_disable_hero_weapons
// Params 0, eflags: 0x4
// Checksum 0xdac1b35c, Offset: 0x138
// Size: 0x2f4
function private on_begin() {
    weapon_names = array(#"hero_chakram_lv1", #"hero_chakram_lv2", #"hero_chakram_lv3", #"hero_chakram_lh_lv1", #"hero_chakram_lh_lv2", #"hero_chakram_lh_lv3", #"hero_hammer_lv1", #"hero_hammer_lv2", #"hero_hammer_lv3", #"hero_katana_t8_lv1", #"hero_katana_t8_lv2", #"hero_katana_t8_lv3", #"hero_scepter_lv1", #"hero_scepter_lv2", #"hero_scepter_lv3", #"hero_sword_pistol_lv1", #"hero_sword_pistol_lv2", #"hero_sword_pistol_lv3", #"hero_sword_pistol_lh_lv1", #"hero_sword_pistol_lh_lv2", #"hero_sword_pistol_lh_lv3");
    level.var_64d57aee = [];
    foreach (weapon_name in weapon_names) {
        weapon = getweapon(weapon_name);
        if (isdefined(weapon) && weapon != level.weaponnone) {
            level.var_64d57aee[weapon.name] = weapon;
        }
    }
    foreach (player in getplayers()) {
        player function_e10dc163();
        player callback::function_c4f1b25e(&function_c4f1b25e);
    }
    level zm_trial::function_987ca9a2(1);
}

// Namespace zm_trial_disable_hero_weapons/zm_trial_disable_hero_weapons
// Params 1, eflags: 0x4
// Checksum 0x3d9d4ed1, Offset: 0x438
// Size: 0x18c
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player callback::function_4c693f09(&function_c4f1b25e);
        foreach (weapon in player getweaponslist(1)) {
            player unlockweapon(weapon);
            if (weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone) {
                player unlockweapon(weapon.dualwieldweapon);
            }
        }
    }
    level.var_64d57aee = undefined;
    level zm_trial::function_987ca9a2(0);
}

// Namespace zm_trial_disable_hero_weapons/zm_trial_disable_hero_weapons
// Params 0, eflags: 0x0
// Checksum 0xc527d2fe, Offset: 0x5d0
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_871c1f7f(#"hash_c2ef6223096d3ca");
    return isdefined(challenge);
}

// Namespace zm_trial_disable_hero_weapons/zm_trial_disable_hero_weapons
// Params 1, eflags: 0x4
// Checksum 0xfb16420d, Offset: 0x610
// Size: 0x24
function private function_c4f1b25e(eventstruct) {
    self function_e10dc163();
}

// Namespace zm_trial_disable_hero_weapons/zm_trial_disable_hero_weapons
// Params 0, eflags: 0x4
// Checksum 0xbe91a5, Offset: 0x640
// Size: 0x170
function private function_e10dc163() {
    assert(isdefined(level.var_64d57aee));
    foreach (weapon in self getweaponslist(1)) {
        if (isdefined(level.var_64d57aee[weapon.name])) {
            self lockweapon(weapon);
        } else {
            self unlockweapon(weapon);
        }
        if (weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone) {
            if (isdefined(level.var_64d57aee[weapon.dualwieldweapon.name])) {
                self lockweapon(weapon.dualwieldweapon);
                continue;
            }
            self unlockweapon(weapon.dualwieldweapon);
        }
    }
}

