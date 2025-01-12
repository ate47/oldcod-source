#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_restrict_loadout;

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 0, eflags: 0x2
// Checksum 0x548a1516, Offset: 0x118
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_restrict_loadout", &__init__, undefined, undefined);
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 0, eflags: 0x0
// Checksum 0xe277f2bd, Offset: 0x160
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"restrict_loadout", &on_begin, &on_end);
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 1, eflags: 0x4
// Checksum 0x5e628ff0, Offset: 0x1c8
// Size: 0x6a
function private is_weapon_allowed(weapon) {
    assert(weapon != level.weaponnone);
    if (weapon.isperkbottle) {
        return true;
    }
    if (isdefined(level.var_e0d3dc6c[weapon.name])) {
        return true;
    }
    return false;
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 0, eflags: 0x4
// Checksum 0x66eb3807, Offset: 0x240
// Size: 0x160
function private function_e10dc163() {
    assert(isdefined(level.var_e0d3dc6c));
    foreach (weapon in self getweaponslist(1)) {
        if (is_weapon_allowed(weapon)) {
            self unlockweapon(weapon);
        } else {
            self lockweapon(weapon);
        }
        if (weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone) {
            if (is_weapon_allowed(weapon.dualwieldweapon)) {
                self unlockweapon(weapon.dualwieldweapon);
                continue;
            }
            self lockweapon(weapon.dualwieldweapon);
        }
    }
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 1, eflags: 0x4
// Checksum 0xc435114, Offset: 0x3a8
// Size: 0x24
function private function_c4f1b25e(eventstruct) {
    self function_e10dc163();
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 0, eflags: 0x4
// Checksum 0x1dca1719, Offset: 0x3d8
// Size: 0xb6
function private function_7d4f50d7() {
    if (isdefined(self._gadgets_player)) {
        for (i = 0; i < 3; i++) {
            if (isdefined(self._gadgets_player[i]) && self hasweapon(self._gadgets_player[i]) && is_weapon_allowed(self._gadgets_player[i])) {
                self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
            }
        }
    }
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 1, eflags: 0x4
// Checksum 0x896e7568, Offset: 0x498
// Size: 0x700
function private on_begin(var_6e3ab546) {
    self.var_6e3ab546 = var_6e3ab546;
    var_3a1ecc19 = [];
    var_687c8e0b = undefined;
    objective_origin = undefined;
    switch (var_6e3ab546) {
    case #"equipment":
        var_3a1ecc19 = array(#"eq_acid_bomb", #"eq_acid_bomb_extra", #"homunculus", #"tomahawk_t8", #"tomahawk_t8_upgraded", #"claymore", #"claymore_extra", #"eq_molotov", #"eq_molotov_extra", #"eq_frag_grenade", #"eq_frag_grenade_extra", #"eq_wraith_fire", #"eq_wraith_fire_extra", #"mini_turret", #"proximity_grenade", #"sticky_grenade", #"sticky_grenade_extra");
        level zm_trial::function_577f4821(1);
        level zm_trial::function_987ca9a2(1);
        break;
    case #"melee":
        var_3a1ecc19 = array(#"knife", #"knife_widows_wine", #"bowie_knife", #"bowie_knife_widows_wine");
        level zm_trial::function_373bbacc(1);
        break;
    case #"leveraction":
        var_3a1ecc19 = array(#"tr_leveraction_t8", #"tr_leveraction_t8_upgraded");
        var_687c8e0b = "objective_zm_trials_leveraction_destination";
        objective_struct = struct::get("tr_leveraction_t8", "zombie_weapon_upgrade");
        objective_origin = objective_struct.origin;
        level zm_trial::function_373bbacc(1);
        break;
    case #"hash_33380540d3ae5004":
        var_3a1ecc19 = array(#"shotgun_pump_t8", #"shotgun_pump_t8_upgraded");
        level zm_trial::function_373bbacc(1);
        break;
    case #"burst_pistol":
        var_3a1ecc19 = array(#"pistol_burst_t8", #"pistol_burst_t8_upgraded");
        var_687c8e0b = "objective_zm_trials_leveraction_destination";
        objective_struct = struct::get("pistol_burst_t8", "zombie_weapon_upgrade");
        objective_origin = objective_struct.origin;
        level zm_trial::function_373bbacc(1);
        break;
    default:
        assert(0, "<dev string:x30>" + var_6e3ab546);
        break;
    }
    foreach (name in var_3a1ecc19) {
        weapon = getweapon(name);
        if (isdefined(weapon) && weapon != level.weaponnone) {
            level.var_e0d3dc6c[name] = weapon;
        }
    }
    foreach (player in getplayers()) {
        player function_e10dc163();
        player callback::function_c4f1b25e(&function_c4f1b25e);
        player zm_trial_util::function_f9e294e9(1);
        player callback::on_weapon_change(&zm_trial_util::function_2033328b);
    }
    self function_dfb47c0f();
    assert(!isdefined(self.objective_id));
    if (isdefined(var_687c8e0b)) {
        assert(isdefined(objective_origin));
        self.objective_id = gameobjects::get_next_obj_id();
        objective_add(self.objective_id, "active", objective_origin, var_687c8e0b);
        function_eeba3a5c(self.objective_id, 1);
        foreach (player in getplayers()) {
            player thread monitor_objective(self);
        }
    }
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 1, eflags: 0x4
// Checksum 0x1d7f2001, Offset: 0xba0
// Size: 0x29c
function private on_end(round_reset) {
    if (isdefined(self.objective_id)) {
        gameobjects::release_obj_id(self.objective_id);
        self.objective_id = undefined;
    }
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
    if (round_reset && self.var_6e3ab546 == #"equipment") {
        foreach (player in getplayers()) {
            player function_7d4f50d7();
        }
    }
    level.var_e0d3dc6c = undefined;
    level zm_trial::function_373bbacc(0);
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 0, eflags: 0x0
// Checksum 0x31df0496, Offset: 0xe48
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_871c1f7f(#"restrict_loadout");
    return isdefined(challenge);
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 0, eflags: 0x4
// Checksum 0x3119c69a, Offset: 0xe88
// Size: 0x6c
function private disable_offhand_weapons() {
    self endon(#"disconnect");
    was_enabled = self offhandweaponsenabled();
    self disableoffhandweapons();
    wait 1;
    if (was_enabled) {
        self enableoffhandweapons();
    }
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 0, eflags: 0x4
// Checksum 0x8c9c19c3, Offset: 0xf00
// Size: 0x144
function private function_dfb47c0f() {
    if (self.var_6e3ab546 != #"equipment") {
        foreach (player in getplayers()) {
            player thread disable_offhand_weapons();
            if (isdefined(player.mini_turrets)) {
                foreach (mini_turret in player.mini_turrets) {
                    mini_turret dodamage(mini_turret.health + 100, mini_turret.origin);
                }
            }
        }
    }
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 0, eflags: 0x4
// Checksum 0x8708431, Offset: 0x1050
// Size: 0xaa
function private function_46c5e0cd() {
    assert(isdefined(level.var_e0d3dc6c));
    foreach (weapon in level.var_e0d3dc6c) {
        if (self hasweapon(weapon)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_trial_restrict_loadout/zm_trial_restrict_loadout
// Params 1, eflags: 0x4
// Checksum 0x3aabdc, Offset: 0x1108
// Size: 0xe6
function private monitor_objective(challenge) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    objective_setinvisibletoplayer(challenge.objective_id, self);
    wait 12;
    while (true) {
        assert(isdefined(challenge.objective_id));
        if (self function_46c5e0cd()) {
            objective_setinvisibletoplayer(challenge.objective_id, self);
        } else {
            objective_setvisibletoplayer(challenge.objective_id, self);
        }
        waitframe(1);
    }
}

