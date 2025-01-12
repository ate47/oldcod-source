#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_traps;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace zm_trial_headshots_only;

// Namespace zm_trial_headshots_only/zm_trial_headshots_only
// Params 0, eflags: 0x6
// Checksum 0xec0c81b2, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_headshots_only", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_headshots_only/zm_trial_headshots_only
// Params 0, eflags: 0x5 linked
// Checksum 0x164e336e, Offset: 0x118
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"headshots_only", &on_begin, &on_end);
}

// Namespace zm_trial_headshots_only/zm_trial_headshots_only
// Params 1, eflags: 0x5 linked
// Checksum 0x5d3123db, Offset: 0x180
// Size: 0x234
function private on_begin(*weapon_name) {
    level.var_b38bb71 = 1;
    level.var_ef0aada0 = 1;
    zm_traps::function_6966417b();
    foreach (player in getplayers()) {
        foreach (var_5a1e3e5b in level.hero_weapon) {
            foreach (w_hero in var_5a1e3e5b) {
                player function_28602a03(w_hero, 1, 1);
            }
        }
        player zm_trial_util::function_9bf8e274();
        player zm_trial_util::function_dc9ab223(1);
    }
    callback::function_33f0ddd3(&function_33f0ddd3);
    level zm_trial::function_44200d07(1);
    level zm_trial::function_cd75b690(1);
}

// Namespace zm_trial_headshots_only/zm_trial_headshots_only
// Params 1, eflags: 0x5 linked
// Checksum 0xef221234, Offset: 0x3c0
// Size: 0x2cc
function private on_end(*round_reset) {
    level.var_b38bb71 = 0;
    level.var_ef0aada0 = 0;
    zm_traps::function_9d0c9706();
    foreach (player in getplayers()) {
        foreach (var_5a1e3e5b in level.hero_weapon) {
            foreach (w_hero in var_5a1e3e5b) {
                player unlockweapon(w_hero);
            }
        }
        player zm_trial_util::function_73ff0096();
        foreach (w_equip in level.zombie_weapons) {
            if (w_equip.weapon_classname === "equipment") {
                player unlockweapon(w_equip.weapon);
            }
        }
        player zm_trial_util::function_dc9ab223(0);
    }
    callback::function_824d206(&function_33f0ddd3);
    level zm_trial::function_44200d07(0);
    level zm_trial::function_cd75b690(0);
}

// Namespace zm_trial_headshots_only/zm_trial_headshots_only
// Params 0, eflags: 0x1 linked
// Checksum 0x95b10b4e, Offset: 0x698
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"headshots_only");
    return isdefined(challenge);
}

// Namespace zm_trial_headshots_only/zm_trial_headshots_only
// Params 1, eflags: 0x5 linked
// Checksum 0x3548a20a, Offset: 0x6d8
// Size: 0x6c
function private function_33f0ddd3(s_event) {
    if (s_event.event === "give_weapon") {
        if (zm_loadout::function_59b0ef71("lethal_grenade", s_event.weapon)) {
            self function_28602a03(s_event.weapon, 1, 1);
        }
    }
}

