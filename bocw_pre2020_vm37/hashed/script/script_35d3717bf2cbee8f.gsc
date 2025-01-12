#using script_698dd790cdc4965f;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace namespace_fc5170d1;

// Namespace namespace_fc5170d1/namespace_fc5170d1
// Params 0, eflags: 0x6
// Checksum 0x688ec83f, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_388ce832b10c2f83", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_fc5170d1/namespace_fc5170d1
// Params 0, eflags: 0x5 linked
// Checksum 0xd4b534a9, Offset: 0xd0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_c2ef6223096d3ca", &on_begin, &on_end);
}

// Namespace namespace_fc5170d1/namespace_fc5170d1
// Params 0, eflags: 0x5 linked
// Checksum 0x8398dc71, Offset: 0x138
// Size: 0x31c
function private on_begin() {
    weapon_names = array(#"hero_chakram_lv1", #"hero_chakram_lv2", #"hero_chakram_lv3", #"hero_chakram_lh_lv1", #"hero_chakram_lh_lv2", #"hero_chakram_lh_lv3", #"hero_hammer_lv1", #"hero_hammer_lv2", #"hero_hammer_lv3", #"hero_katana_t8_lv1", #"hero_katana_t8_lv2", #"hero_katana_t8_lv3", #"hero_scepter_lv1", #"hero_scepter_lv2", #"hero_scepter_lv3", #"hero_sword_pistol_lv1", #"hero_sword_pistol_lv2", #"hero_sword_pistol_lv3", #"hero_sword_pistol_lh_lv1", #"hero_sword_pistol_lh_lv2", #"hero_sword_pistol_lh_lv3");
    level.var_3e2ac3b6 = [];
    foreach (weapon_name in weapon_names) {
        weapon = getweapon(weapon_name);
        if (isdefined(weapon) && weapon != level.weaponnone) {
            level.var_3e2ac3b6[weapon.name] = weapon;
        }
    }
    foreach (player in getplayers()) {
        player function_6a8979c9();
        player callback::function_33f0ddd3(&function_33f0ddd3);
        player zm_trial_util::function_9bf8e274();
    }
    level zm_trial::function_44200d07(1);
}

// Namespace namespace_fc5170d1/namespace_fc5170d1
// Params 1, eflags: 0x5 linked
// Checksum 0xa9197207, Offset: 0x460
// Size: 0x1b4
function private on_end(*round_reset) {
    foreach (player in getplayers()) {
        player callback::function_824d206(&function_33f0ddd3);
        foreach (weapon in player getweaponslist(1)) {
            player unlockweapon(weapon);
            if (weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone) {
                player unlockweapon(weapon.dualwieldweapon);
            }
        }
        player zm_trial_util::function_73ff0096();
    }
    level.var_3e2ac3b6 = undefined;
    level zm_trial::function_44200d07(0);
}

// Namespace namespace_fc5170d1/namespace_fc5170d1
// Params 0, eflags: 0x1 linked
// Checksum 0x888cec91, Offset: 0x620
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"hash_c2ef6223096d3ca");
    return isdefined(challenge);
}

// Namespace namespace_fc5170d1/namespace_fc5170d1
// Params 1, eflags: 0x5 linked
// Checksum 0xefe96c74, Offset: 0x660
// Size: 0x24
function private function_33f0ddd3(*eventstruct) {
    self function_6a8979c9();
}

// Namespace namespace_fc5170d1/namespace_fc5170d1
// Params 0, eflags: 0x5 linked
// Checksum 0x730bb926, Offset: 0x690
// Size: 0x1c0
function private function_6a8979c9() {
    assert(isdefined(level.var_3e2ac3b6));
    foreach (weapon in self getweaponslist(1)) {
        if (isdefined(level.var_3e2ac3b6[weapon.name])) {
            self function_28602a03(weapon);
        } else if (!namespace_83dc3729::is_active() || !isarray(level.var_af806901) || !isdefined(level.var_af806901[weapon.name])) {
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

