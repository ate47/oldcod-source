#using scripts\core_common\aat_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\trials\zm_trial_disable_upgraded_weapons;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_weapons;

#namespace zm_pap_util;

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 0, eflags: 0x0
// Checksum 0xc1102562, Offset: 0x178
// Size: 0x7e
function init_parameters() {
    if (!isdefined(level.pack_a_punch)) {
        level.pack_a_punch = spawnstruct();
        level.pack_a_punch.timeout = 15;
        level.pack_a_punch.interaction_height = 35;
        level.pack_a_punch.grabbable_by_anyone = 0;
        level.pack_a_punch.triggers = [];
    }
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 1, eflags: 0x0
// Checksum 0x5956a3ae, Offset: 0x200
// Size: 0x32
function set_timeout(n_timeout_s) {
    init_parameters();
    level.pack_a_punch.timeout = n_timeout_s;
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 1, eflags: 0x0
// Checksum 0x34b39f4b, Offset: 0x240
// Size: 0x32
function set_interaction_height(n_height) {
    init_parameters();
    level.pack_a_punch.interaction_height = n_height;
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 1, eflags: 0x0
// Checksum 0xe32e59e, Offset: 0x280
// Size: 0x32
function function_2d1a6d1e(n_width) {
    init_parameters();
    level.pack_a_punch.var_e5756dbf = n_width;
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 1, eflags: 0x0
// Checksum 0xc16fd644, Offset: 0x2c0
// Size: 0x32
function function_59b7969e(n_length) {
    init_parameters();
    level.pack_a_punch.var_d21f07a1 = n_length;
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 1, eflags: 0x0
// Checksum 0xc64b934d, Offset: 0x300
// Size: 0x32
function set_interaction_trigger_height(n_height) {
    init_parameters();
    level.pack_a_punch.interaction_trigger_height = n_height;
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 1, eflags: 0x0
// Checksum 0xbda40b61, Offset: 0x340
// Size: 0x32
function function_2ad8bbcd(n_offset) {
    init_parameters();
    level.pack_a_punch.var_2ad8bbcd = n_offset;
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 0, eflags: 0x0
// Checksum 0x63951116, Offset: 0x380
// Size: 0x2a
function set_grabbable_by_anyone() {
    init_parameters();
    level.pack_a_punch.grabbable_by_anyone = 1;
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 1, eflags: 0x0
// Checksum 0x6eda82c3, Offset: 0x3b8
// Size: 0x350
function update_hint_string(player) {
    pap_machine = self.stub.zbarrier;
    if (!pap_machine flag::get("pap_waiting_for_user")) {
        if (pap_machine.pack_player === player) {
            if (pap_machine flag::get("pap_offering_gun")) {
                var_42f4d1ba = player getcurrentweapon();
                if (var_42f4d1ba != level.weaponnone) {
                    self sethintstring(#"hash_51194149fb39a693");
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        } else {
            self sethintstring(#"hash_5b77a8f33d352c37");
            return true;
        }
    }
    if (pap_machine flag::get("pap_in_retrigger_delay") || !player player_use_can_pack_now(pap_machine) || player bgb::is_active(#"zm_bgb_ephemeral_enhancement")) {
        return false;
    }
    if (zm_trial_disable_buys::is_active() || zm_trial_disable_upgraded_weapons::is_active()) {
        return false;
    }
    var_41843d24 = player getcurrentweapon();
    current_cost = pap_machine function_3c579d8f(player, var_41843d24);
    if (isdefined(level.var_a13971ab)) {
        self [[ level.var_a13971ab ]](player);
    } else if (zm_weapons::is_weapon_upgraded(var_41843d24)) {
        if (isdefined(level.var_c4c4e7fb) && level.var_c4c4e7fb) {
            self sethintstring(#"hash_11c1749ce5b09c1f");
        } else if (isdefined(pap_machine.var_a8b34199) && pap_machine.var_a8b34199) {
            self sethintstring(#"hash_6cd48e5ddab079ed", current_cost);
        } else {
            self sethintstring(#"hash_673794817f9c09b4", current_cost);
        }
    } else if (isdefined(level.var_c4c4e7fb) && level.var_c4c4e7fb) {
        self sethintstring(#"hash_6c8cfa12133d4a58");
    } else {
        self sethintstring(#"zombie/perk_packapunch", current_cost);
    }
    return true;
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 3, eflags: 0x0
// Checksum 0xc916e803, Offset: 0x710
// Size: 0x130
function function_3c579d8f(player, weapon, b_weapon_supports_aat = zm_weapons::weapon_supports_aat(weapon) && zm_custom::function_5638f689(#"zmsuperpapenabled")) {
    var_ed7ab451 = self.cost;
    if (b_weapon_supports_aat) {
        var_ed7ab451 = self.var_ebe0c72f;
        if (isinarray(getarraykeys(player.aat), aat::get_nonalternate_weapon(weapon))) {
            var_ed7ab451 = self.var_2066a653;
        }
    }
    if (isdefined(player.talisman_weapon_reducepapcost) && player.talisman_weapon_reducepapcost) {
        var_ed7ab451 -= player.talisman_weapon_reducepapcost;
        assert(var_ed7ab451 > 0, "<dev string:x30>");
    }
    return var_ed7ab451;
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 12, eflags: 0x0
// Checksum 0x278d51c4, Offset: 0x848
// Size: 0x19a
function function_93293ac0(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return damage;
    }
    if (isplayer(attacker) && (isplayer(inflictor) || meansofdeath === "MOD_PROJECTILE" || meansofdeath === "MOD_PROJECTILE_SPLASH" || meansofdeath === "MOD_GRENADE" || meansofdeath === "MOD_GRENADE_SPLASH") && isdefined(weapon)) {
        if (isdefined(attacker.aat[weapon])) {
            damage *= 2;
        }
        if (isdefined(attacker.var_eed271c5) && isdefined(self.var_bf88f06b)) {
            damage = self [[ self.var_bf88f06b ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        }
    }
    return damage;
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 2, eflags: 0x4
// Checksum 0x1b60a3f0, Offset: 0x9f0
// Size: 0xfe
function private can_pack_weapon(weapon, pap_machine) {
    if (weapon.isriotshield) {
        return false;
    }
    if (!pap_machine flag::get("pap_waiting_for_user")) {
        return true;
    }
    if (!(isdefined(level.b_allow_idgun_pap) && level.b_allow_idgun_pap) && isdefined(level.idgun_weapons)) {
        if (isinarray(level.idgun_weapons, weapon)) {
            return false;
        }
    }
    weapon = self zm_weapons::get_nonalternate_weapon(weapon);
    if (!zm_weapons::is_weapon_or_base_included(weapon)) {
        return false;
    }
    if (!self zm_weapons::can_upgrade_weapon(weapon)) {
        return false;
    }
    return true;
}

// Namespace zm_pap_util/zm_pack_a_punch_util
// Params 1, eflags: 0x4
// Checksum 0xb46527af, Offset: 0xaf8
// Size: 0x122
function private player_use_can_pack_now(pap_machine) {
    if (self laststand::player_is_in_laststand() || isdefined(self.intermission) && self.intermission || self isthrowinggrenade()) {
        return false;
    }
    if (!self zm_magicbox::can_buy_weapon() || self bgb::is_enabled(#"zm_bgb_disorderly_combat")) {
        return false;
    }
    if (self zm_equipment::hacker_active()) {
        return false;
    }
    current_weapon = self getcurrentweapon();
    if (!self can_pack_weapon(current_weapon, pap_machine) && !zm_weapons::weapon_supports_aat(current_weapon)) {
        return false;
    }
    return true;
}

