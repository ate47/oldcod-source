#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace zm_trial_forced_reload;

// Namespace zm_trial_forced_reload/zm_trial_forced_reload
// Params 0, eflags: 0x6
// Checksum 0xaf30b7dc, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_forced_reload", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_forced_reload/zm_trial_forced_reload
// Params 0, eflags: 0x4
// Checksum 0xaa73c1c5, Offset: 0x118
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"forced_reload", &on_begin, &on_end);
}

// Namespace zm_trial_forced_reload/zm_trial_forced_reload
// Params 0, eflags: 0x4
// Checksum 0xa6da7b15, Offset: 0x180
// Size: 0x13c
function private on_begin() {
    callback::on_weapon_fired(&on_weapon_fired);
    callback::function_33f0ddd3(&function_33f0ddd3);
    callback::on_weapon_change(&zm_trial_util::function_79518194);
    foreach (player in getplayers()) {
        player thread zm_trial_util::function_bf710271(1, 1, 1, 0, 1);
        player thread zm_trial_util::function_dc9ab223(1, 1);
    }
    level zm_trial::function_25ee130(1);
}

// Namespace zm_trial_forced_reload/zm_trial_forced_reload
// Params 1, eflags: 0x4
// Checksum 0x4f012481, Offset: 0x2c8
// Size: 0x124
function private on_end(*round_reset) {
    callback::remove_on_weapon_fired(&on_weapon_fired);
    callback::function_824d206(&function_33f0ddd3);
    callback::remove_on_weapon_change(&zm_trial_util::function_79518194);
    foreach (player in getplayers()) {
        player notify(#"hash_1fbfdb0105f48f89");
        player thread zm_trial_util::function_dc0859e();
    }
    level zm_trial::function_25ee130(0);
}

// Namespace zm_trial_forced_reload/zm_trial_forced_reload
// Params 1, eflags: 0x4
// Checksum 0x947c6f98, Offset: 0x3f8
// Size: 0x144
function private function_33f0ddd3(s_event) {
    if (s_event.event === "give_weapon") {
        if (zm_loadout::is_melee_weapon(s_event.weapon) || zm_loadout::is_lethal_grenade(s_event.weapon) || zm_loadout::is_tactical_grenade(s_event.weapon, 1)) {
            self function_28602a03(s_event.weapon, 1, 1);
            if (s_event.weapon.dualwieldweapon != level.weaponnone) {
                self function_28602a03(s_event.weapon.dualwieldweapon, 1, 1);
            }
            if (s_event.weapon.altweapon != level.weaponnone) {
                self function_28602a03(s_event.weapon.altweapon, 1, 1);
            }
        }
    }
}

// Namespace zm_trial_forced_reload/zm_trial_forced_reload
// Params 1, eflags: 0x4
// Checksum 0xa1858f5d, Offset: 0x548
// Size: 0x104
function private on_weapon_fired(params) {
    self notify("3a8478a97b3babfa");
    self endon("3a8478a97b3babfa");
    self endon(#"disconnect", #"hash_1fbfdb0105f48f89");
    n_clip_size = self getweaponammoclipsize(params.weapon);
    var_2cf11630 = self getweaponammoclip(params.weapon);
    if (n_clip_size > 1 && var_2cf11630 < n_clip_size) {
        if (params.weapon.isburstfire) {
            while (self isfiring()) {
                waitframe(1);
            }
        }
        self thread function_29ee24dd(params.weapon);
    }
}

// Namespace zm_trial_forced_reload/zm_trial_forced_reload
// Params 1, eflags: 0x4
// Checksum 0x166393cd, Offset: 0x658
// Size: 0x1ac
function private function_29ee24dd(weapon) {
    self endon(#"disconnect");
    self function_28602a03(weapon, 1, 1);
    self zm_trial_util::function_7dbb1712();
    n_clip_ammo = self getweaponammoclip(weapon);
    n_stock_ammo = self getweaponammostock(weapon);
    if (n_stock_ammo > 0) {
        while (true) {
            s_waitresult = self waittill(#"reload", #"zmb_max_ammo", #"hash_278526d0bbdb4ce7", #"hash_1fbfdb0105f48f89", #"player_downed", #"death");
            w_current = self getcurrentweapon();
            if (s_waitresult._notify == "reload" && weapon != w_current) {
                continue;
            }
            break;
        }
    }
    if (isdefined(self)) {
        self unlockweapon(weapon);
        self zm_trial_util::function_7dbb1712(1);
    }
}

