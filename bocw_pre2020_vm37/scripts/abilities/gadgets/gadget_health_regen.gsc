#using script_4a1e83805671ae57;
#using script_725554a59d6a75b9;
#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace gadget_health_regen;

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x6
// Checksum 0xb2c2602a, Offset: 0x138
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gadget_health_regen", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x5 linked
// Checksum 0x4c59c362, Offset: 0x180
// Size: 0x264
function private function_70a657d8() {
    ability_player::register_gadget_activation_callbacks(23, &gadget_health_regen_on, &gadget_health_regen_off);
    ability_player::register_gadget_possession_callbacks(23, &gadget_health_regen_on_give, &gadget_health_regen_on_take);
    clientfield::register("toplayer", "healthregen", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.healingActive", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.numHealthPickups", 1, 2, "int");
    callback::on_spawned(&on_player_spawned);
    callback::on_player_damage(&on_player_damage);
    callback::add_callback(#"on_status_effect", &on_status_effect);
    callback::add_callback(#"on_buff", &on_buff);
    callback::add_callback(#"on_ai_killed", &function_3a6741ee);
    level.var_3a536ce3 = getweapon(#"hash_5768c7fdf2dc422e");
    if (!isdefined(level.var_f71267dc)) {
        level.var_f71267dc = &function_b5b7d60e;
    }
    if (!isdefined(level.var_11e731d7)) {
        level.var_11e731d7 = &function_582035b1;
    }
    assert(level.var_3a536ce3.name != "<dev string:x38>", "<dev string:x40>");
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x1 linked
// Checksum 0xb274da5f, Offset: 0x3f0
// Size: 0x3c
function on_status_effect(var_756fda07) {
    if (is_true(var_756fda07.var_29f71617)) {
        self function_aba28004();
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0x3f9650c5, Offset: 0x438
// Size: 0x1c
function on_buff() {
    self function_aba28004();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x1 linked
// Checksum 0x1290eeae, Offset: 0x460
// Size: 0x84
function gadget_health_regen_on_give(slot, weapon) {
    self.gadget_health_regen_slot = slot;
    self.gadget_health_regen_weapon = weapon;
    weapon.ignore_grenade = 1;
    if (isdefined(weapon) && weapon.maxheal) {
        self player::function_9080887a(weapon.maxheal);
        return;
    }
    self player::function_9080887a();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x1 linked
// Checksum 0xb5b27bc8, Offset: 0x4f0
// Size: 0x34
function gadget_health_regen_on_take(*slot, *weapon) {
    self.gadget_health_regen_slot = undefined;
    self player::function_9080887a();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0x74787d3e, Offset: 0x530
// Size: 0xdc
function on_player_spawned() {
    self function_d91a057d();
    if (isdefined(level.var_c018953f)) {
        if (!level.var_c018953f stim_count::is_open(self)) {
            level.var_c018953f stim_count::open(self, 1);
        }
    }
    /#
        if (getdvarint(#"hash_4a424b02130fa0c0", 0) > 0) {
            stim_count = getdvarint(#"hash_4a424b02130fa0c0", 0);
            self function_6eef7f4f(stim_count);
        }
    #/
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x1 linked
// Checksum 0x79647e7e, Offset: 0x618
// Size: 0x64
function function_6eef7f4f(stim_count) {
    stim_count = math::clamp(stim_count, 0, 9);
    self.var_f2a5bd01 = stim_count;
    if (isdefined(level.var_c018953f)) {
        level.var_c018953f stim_count::function_6eef7f4f(self, stim_count);
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0x4237796a, Offset: 0x688
// Size: 0x24
function function_36ac3c21() {
    self clientfield::set_to_player("healthregen", 1);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0x8400b28b, Offset: 0x6b8
// Size: 0x3c
function function_ddfdddb1() {
    self clientfield::set_to_player("healthregen", 1);
    battlechatter::function_30146e82(self);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0xce4c4982, Offset: 0x700
// Size: 0x24
function function_1e02d458() {
    self clientfield::set_player_uimodel("hudItems.healingActive", 1);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0x67ac5e87, Offset: 0x730
// Size: 0xbc
function heal_end() {
    if (!isdefined(self) || !isdefined(self.heal)) {
        return;
    }
    self.heal.var_a1cac2f1 = 0;
    self.heal.enabled = 0;
    self.heal.var_bc840360 = 0;
    self notify(#"healing_disabled");
    self player::function_9080887a();
    self clientfield::set_player_uimodel("hudItems.healingActive", 0);
    self clientfield::set_to_player("healthregen", 0);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0xe523ce59, Offset: 0x7f8
// Size: 0xb6
function function_a1a8b5e5() {
    modifier = 1;
    if (self function_6c32d092(#"hash_545c9b658d1fa741") || self function_6c32d092(#"hash_26d9975f2a7349b4") || self function_6c32d092(#"hash_509c37578f2b8f77") || self function_6c32d092(#"hash_799d5b4c447f17e2")) {
        modifier = 0.5;
    }
    return modifier;
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x1 linked
// Checksum 0xcb5ab1fb, Offset: 0x8b8
// Size: 0xfe
function function_ef6c7869(now) {
    if (self.laststand === 1) {
        return;
    }
    var_337562a8 = isdefined(self.var_337562a8) ? self.var_337562a8 : level.var_3a536ce3;
    var_f60dece = function_a1a8b5e5();
    total_time = [[ level.var_11e731d7 ]](var_337562a8) * var_f60dece;
    if (now - self.lastdamagetime < total_time) {
        return;
    }
    profilestart();
    self function_36ac3c21();
    self thread enable_healing_after_wait(undefined, var_337562a8, getdvarfloat(#"hash_57be38bf0a00809d", 0), 0.5, self);
    profilestop();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x1 linked
// Checksum 0xb04f3f4f, Offset: 0x9c0
// Size: 0xd4
function function_34daf34a(slot, weapon) {
    if (self gadgetsdisabled()) {
        return;
    }
    if (weapon === getweapon(#"gadget_health_regen_squad")) {
        self function_bc0ce7d5(slot, weapon);
        return;
    }
    self function_ddfdddb1();
    self thread enable_healing_after_wait(slot, weapon, getdvarfloat(#"hash_57be38bf0a00809d", 0), 0.5, self);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x1 linked
// Checksum 0x85f71682, Offset: 0xaa0
// Size: 0x12e
function function_bc0ce7d5(slot, weapon) {
    var_1594ab5 = self function_941ed5d6();
    for (i = 0; i < 4; i++) {
        if (isalive(var_1594ab5[i])) {
            profilestart();
            if (is_true(var_1594ab5[i].laststand)) {
                if (isdefined(var_1594ab5[i].var_84c0402e)) {
                    var_1594ab5[i].bleedout_time = var_1594ab5[i].var_84c0402e;
                }
            } else {
                var_1594ab5[i] function_ddfdddb1();
                var_1594ab5[i] thread enable_healing_after_wait(slot, weapon, getdvarfloat(#"hash_57be38bf0a00809d", 0), 0.5, self);
            }
            profilestop();
        }
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0xa969400c, Offset: 0xbd8
// Size: 0x5a
function function_941ed5d6() {
    if (isdefined(self.team)) {
        var_1594ab5 = getplayers(self.team, self.origin, 1500);
    } else {
        var_1594ab5 = array(self);
    }
    return var_1594ab5;
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x1 linked
// Checksum 0xa9c1086a, Offset: 0xc40
// Size: 0x66
function function_aa2c622b(weapon) {
    return weapon.name === #"gadget_health_regen" || weapon.name === #"gadget_medicalinjectiongun" || weapon.name === #"hash_788c96e19cc7a46e";
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x1 linked
// Checksum 0xe605767d, Offset: 0xcb0
// Size: 0x6c
function gadget_health_regen_on(slot, weapon) {
    if (sessionmodeiswarzonegame() && !function_aa2c622b(weapon)) {
        self.var_eedfcc6e = gettime();
        return;
    }
    function_34daf34a(slot, weapon);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x1 linked
// Checksum 0xe6f2007c, Offset: 0xd28
// Size: 0x126
function gadget_health_regen_off(slot, weapon) {
    if (!sessionmodeiswarzonegame() && !function_aa2c622b(weapon)) {
        return;
    }
    if (isdefined(self.var_eedfcc6e)) {
        var_d9dbb072 = 0;
        usage_rate = self function_c1b7eefa(weapon);
        if (usage_rate > 0) {
            var_d9dbb072 = weapon.gadget_powermax / usage_rate;
        }
        if (int(var_d9dbb072 * 1000) + self.var_eedfcc6e <= gettime() + 100) {
            function_34daf34a(slot, weapon);
        } else {
            self gadgetpowerset(slot, weapon.gadget_powermax);
        }
        self.var_eedfcc6e = undefined;
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 5, eflags: 0x1 linked
// Checksum 0x1ef92b02, Offset: 0xe58
// Size: 0xe4
function enable_healing_after_wait(slot, weapon, wait_time, var_5818bd22, player) {
    self notify(#"healing_preamble");
    self.heal.var_a1cac2f1 = gettime() + var_5818bd22;
    waitresult = self waittilltimeout(wait_time, #"death", #"disconnect", #"healing_disabled", #"healing_preamble");
    if (waitresult._notify != "timeout") {
        return;
    }
    self enable_healing(slot, weapon, player);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 3, eflags: 0x1 linked
// Checksum 0x14a04da0, Offset: 0xf48
// Size: 0x5ac
function enable_healing(slot, weapon, player) {
    if (!isdefined(self)) {
        return;
    }
    if (self gadgetsdisabled()) {
        return;
    }
    self function_1e02d458();
    if (isdefined(weapon) && weapon.maxheal) {
        self player::function_9080887a(weapon.maxheal);
    } else {
        self player::function_9080887a();
    }
    if (isdefined(self.var_9cd2c51d)) {
        if (!self.heal.enabled) {
            self.var_9cd2c51d.var_c54af9a9 = gettime();
            self.var_9cd2c51d.var_6e219f3c = self.health;
        }
    }
    var_bc840360 = self.health;
    if (self.heal.enabled) {
        if (isdefined(self.heal.var_bc840360) && self.heal.var_bc840360 > 0) {
            var_bc840360 = self.heal.var_bc840360;
        }
    }
    if (weapon.heal) {
        max_health = self.maxhealth;
        if (weapon.maxheal && !getdvarint(#"hash_573a1edd4b4143e4", 0)) {
            max_health = weapon.maxheal;
        }
        self.heal.var_bc840360 = math::clamp(weapon.heal + var_bc840360, 0, max_health);
        if (self.heal.var_bc840360 == 0) {
            return;
        }
    } else {
        self.heal.var_bc840360 = 0;
    }
    var_b16fafc9 = 0;
    if (!self.heal.enabled) {
        if (self secondaryoffhandbuttonpressed()) {
            if (isdefined(self.var_f2a5bd01) && self.var_f2a5bd01 > 0) {
                self function_6eef7f4f(self.var_f2a5bd01 - 1);
                var_b16fafc9 = 1;
                self playrumbleonentity("stim_heal");
            }
        }
    }
    var_4465ef1e = player [[ level.var_f71267dc ]](var_b16fafc9, weapon);
    if (var_4465ef1e > 0) {
        heal_amount = weapon.heal;
        if (heal_amount <= 0 && isdefined(self.var_66cb03ad)) {
            heal_amount = self.var_66cb03ad;
        }
        self.heal.rate = heal_amount / float(var_4465ef1e) / 1000;
        self.heal.heal_amount = heal_amount;
        self.heal.var_4e6c244d = weapon.var_db003065;
    } else {
        self.heal.rate = 0;
    }
    if (isdefined(slot)) {
        self function_820a63e9(slot, 1);
    }
    if (isdefined(level.var_d3b4a4db) && self === player) {
        self [[ level.var_d3b4a4db ]](var_b16fafc9);
    }
    if (isdefined(self.var_121392a1)) {
        foreach (se in self.var_121392a1) {
            params = se.var_4f6b79a4;
            if (params.var_abac379d === 1) {
                status_effect::function_408158ef(params.setype, params.var_18d16a6b);
            }
        }
    }
    was_enabled = self.heal.enabled;
    self.heal.enabled = 1;
    if (getdvarint(#"hash_7f9cfdea69a18091", 1) == 1) {
        if (!was_enabled) {
            self.heal.var_f37a08a8 = gettime();
            self.heal.var_fa57541f = self.health;
        }
    }
    self callback::function_d8abfc3d(#"done_healing", &function_4e449209);
    if (isdefined(self.health) && isdefined(self.var_66cb03ad) && self.health >= self.var_66cb03ad) {
        self function_4e449209();
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x1 linked
// Checksum 0x582353b1, Offset: 0x1500
// Size: 0x4a
function function_b5b7d60e(var_b16fafc9, weapon) {
    return var_b16fafc9 ? self function_442af617(weapon) : self function_89a98197(weapon);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x1 linked
// Checksum 0xc1f46b33, Offset: 0x1558
// Size: 0x16
function function_582035b1(var_337562a8) {
    return var_337562a8.var_5b053313;
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x1 linked
// Checksum 0xb04017d7, Offset: 0x1578
// Size: 0x7c
function function_d91a057d(slot = ability_util::gadget_slot_for_type(23)) {
    if (isdefined(slot)) {
        self function_820a63e9(slot, 0);
    }
    if (is_healing()) {
        self heal_end();
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0x7135d5f3, Offset: 0x1600
// Size: 0x3c
function is_healing() {
    return isdefined(self) && isdefined(self.heal) && is_true(self.heal.enabled);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0x163a6fb2, Offset: 0x1648
// Size: 0xe4
function function_4e449209() {
    self endon(#"disconnect");
    if (isdefined(self)) {
        self.heal.var_a1cac2f1 = 0;
        if (isdefined(level.var_d9ae19f0)) {
            level [[ level.var_d9ae19f0 ]](self);
        }
        self callback::function_52ac9652(#"done_healing", &function_4e449209);
        if (self is_healing()) {
            if (!isdefined(self.var_c443b227)) {
                self thread battlechatter::function_78c16252();
            }
        }
        self function_d91a057d();
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x1 linked
// Checksum 0x18bb6901, Offset: 0x1738
// Size: 0xc4
function on_player_damage(params) {
    if (!self is_healing()) {
        return;
    }
    attacker = params.eattacker;
    if (self function_dafd9cd(attacker) == 0) {
        damage = params.idamage;
        self.heal.var_bc840360 = math::clamp(self.heal.var_bc840360 - damage, 0, self.heal.var_bc840360);
        return;
    }
    function_18e0320b();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0x34258efd, Offset: 0x1808
// Size: 0x34
function function_aba28004() {
    if (!isplayer(self)) {
        return;
    }
    self function_18e0320b();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x5 linked
// Checksum 0xdb7eb540, Offset: 0x1848
// Size: 0x34
function private function_18e0320b() {
    if (self is_healing()) {
        self function_d91a057d();
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x5 linked
// Checksum 0x66166435, Offset: 0x1888
// Size: 0x52
function private function_dafd9cd(attacker) {
    if (gettime() < self.heal.var_a1cac2f1) {
        return false;
    }
    if (isdefined(level.deathcircle) && level.deathcircle === attacker) {
        return false;
    }
    return true;
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x1 linked
// Checksum 0xe9ad7ee8, Offset: 0x18e8
// Size: 0x4a
function function_831bf182() {
    can_set = isdefined(self.gadget_health_regen_slot);
    if (!can_set || "ammo" == self.gadget_health_regen_weapon.gadget_powerusetype) {
        return 0;
    }
    return can_set;
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x46cdd5ab, Offset: 0x1940
// Size: 0x3c
function power_off() {
    if (self function_831bf182()) {
        self gadgetpowerset(self.gadget_health_regen_slot, 0);
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0xb34c9e8c, Offset: 0x1988
// Size: 0x4c
function power_on() {
    if (self function_831bf182()) {
        self gadgetpowerset(self.gadget_health_regen_slot, self.gadget_health_regen_weapon.gadget_powermax);
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x1 linked
// Checksum 0x63d59cdf, Offset: 0x19e0
// Size: 0x1c4
function function_3a6741ee(params) {
    attacker = params.eattacker;
    if (!isplayer(attacker)) {
        return;
    }
    player = attacker;
    if (player function_831bf182() == 0) {
        return;
    }
    var_312418a2 = getweapon(#"gadget_health_regen");
    var_d1c7ac6d = var_312418a2.var_4db0917a;
    if (!isdefined(var_d1c7ac6d) || var_d1c7ac6d == 0) {
        return;
    }
    assert(isdefined(player) && isdefined(player.gadget_health_regen_slot));
    assert(isdefined(player.gadget_health_regen_weapon) && isdefined(player) && isdefined(player.gadget_health_regen_weapon.gadget_powermax));
    gadgetslot = player.gadget_health_regen_slot;
    var_5d74fac3 = player.gadget_health_regen_weapon.gadget_powermax;
    var_db3ef30b = player gadgetpowerget(gadgetslot);
    var_d4a51b2 = var_db3ef30b + var_d1c7ac6d;
    if (var_d4a51b2 < 0) {
        var_d4a51b2 = 0;
    } else if (var_d4a51b2 > var_5d74fac3) {
        var_d4a51b2 = var_5d74fac3;
    }
    player gadgetpowerset(gadgetslot, var_d4a51b2);
}

