#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace gadget_health_regen;

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x2
// Checksum 0x1aa5795a, Offset: 0x110
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_health_regen", &__init__, undefined, undefined);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0xb5e80ad6, Offset: 0x158
// Size: 0x194
function __init__() {
    ability_player::register_gadget_activation_callbacks(23, &gadget_health_regen_on, &gadget_health_regen_off);
    ability_player::register_gadget_possession_callbacks(23, &gadget_health_regen_on_give, &gadget_health_regen_on_take);
    clientfield::register("toplayer", "healthregen", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.healingActive", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.numHealthPickups", 1, 2, "int");
    callback::on_spawned(&on_player_spawned);
    callback::on_player_damage(&on_player_damage);
    callback::add_callback(#"on_status_effect", &on_status_effect);
    callback::add_callback(#"on_buff", &on_buff);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x0
// Checksum 0x35a9e54a, Offset: 0x2f8
// Size: 0x44
function on_status_effect(var_adce82d2) {
    if (isdefined(var_adce82d2.var_1b586231) && var_adce82d2.var_1b586231) {
        self function_9162f3b9();
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0xf97c8ead, Offset: 0x348
// Size: 0x1c
function on_buff() {
    self function_9162f3b9();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x0
// Checksum 0x8ffa514, Offset: 0x370
// Size: 0x8c
function gadget_health_regen_on_give(slot, weapon) {
    self.gadget_health_regen_slot = slot;
    self.gadget_health_regen_weapon = weapon;
    weapon.ignore_grenade = 1;
    if (isdefined(weapon) && weapon.maxheal) {
        self player::function_26fa96fc(weapon.maxheal);
        return;
    }
    self player::function_26fa96fc();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x0
// Checksum 0x12ab80b6, Offset: 0x408
// Size: 0x34
function gadget_health_regen_on_take(slot, weapon) {
    self.gadget_health_regen_slot = undefined;
    self player::function_26fa96fc();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0xec43229e, Offset: 0x448
// Size: 0x1c
function on_player_spawned() {
    self function_d36422b7();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x0
// Checksum 0xc18ad287, Offset: 0x470
// Size: 0xac
function function_7acf3667(slot, weapon) {
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        self clientfield::set_to_player("healthregen", 1);
    }
    self thread enable_healing_after_wait(slot, weapon, getdvarfloat(#"hash_57be38bf0a00809d", 0.01), 0.5);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x0
// Checksum 0xdae05a8e, Offset: 0x528
// Size: 0x6c
function gadget_health_regen_on(slot, weapon) {
    if (sessionmodeiswarzonegame()) {
        self.var_fd67e7c3 = gettime();
        self function_1d590050(slot, 1);
        return;
    }
    function_7acf3667(slot, weapon);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x0
// Checksum 0xdbd81424, Offset: 0x5a0
// Size: 0x106
function gadget_health_regen_off(slot, weapon) {
    if (!sessionmodeiswarzonegame()) {
        return;
    }
    if (isdefined(self.var_fd67e7c3)) {
        var_9b9e1d98 = 0;
        if (weapon.gadget_power_usage_rate > 0) {
            var_9b9e1d98 = weapon.gadget_powermax / weapon.gadget_power_usage_rate;
        }
        if (int(var_9b9e1d98 * 1000) + self.var_fd67e7c3 <= gettime() + function_f9f48566()) {
            function_7acf3667(slot, weapon);
        } else {
            self gadgetpowerset(slot, weapon.gadget_powermax);
        }
        self.var_fd67e7c3 = undefined;
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 4, eflags: 0x0
// Checksum 0x702eb016, Offset: 0x6b0
// Size: 0xd4
function enable_healing_after_wait(slot, weapon, wait_time, var_be771993) {
    self notify(#"healing_preamble");
    self.heal.var_856755e2 = gettime() + var_be771993;
    waitresult = self waittilltimeout(wait_time, #"death", #"disconnect", #"healing_disabled", #"healing_preamble");
    if (waitresult._notify != "timeout") {
        return;
    }
    self enable_healing(slot, weapon);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x0
// Checksum 0x94701209, Offset: 0x790
// Size: 0x36c
function enable_healing(slot, weapon) {
    self clientfield::set_player_uimodel("hudItems.healingActive", 1);
    if (isdefined(weapon) && weapon.maxheal) {
        self player::function_26fa96fc(weapon.maxheal);
    } else {
        self player::function_26fa96fc();
    }
    var_93dfabb3 = self.health;
    if (self.heal.enabled) {
        var_93dfabb3 = isdefined(self.heal.var_93dfabb3) ? self.heal.var_93dfabb3 : self.health;
    }
    self.heal.enabled = 1;
    if (weapon.heal) {
        max_health = self.maxhealth;
        if (weapon.maxheal) {
            max_health = weapon.maxheal;
        }
        self.heal.var_93dfabb3 = math::clamp(weapon.heal + var_93dfabb3, 0, max_health);
        if (self.heal.var_93dfabb3 == 0) {
            return;
        }
    } else {
        self.heal.var_93dfabb3 = 0;
    }
    if (weapon.var_5639cfc4 > 0) {
        heal_ammount = weapon.heal;
        if (heal_ammount <= 0 && isdefined(self.var_63f2cd6e)) {
            heal_ammount = self.var_63f2cd6e;
        }
        self.heal.rate = heal_ammount / float(weapon.var_5639cfc4) / 1000;
    } else {
        self.heal.rate = 0;
    }
    self function_53265cac(slot, 1);
    if (isdefined(level.var_f4a0626e)) {
        self [[ level.var_f4a0626e ]]();
    }
    if (isdefined(self.var_a304768d)) {
        foreach (se in self.var_a304768d) {
            params = se.var_2fcb5e92;
            if (params.var_f47a294f === 1) {
                status_effect::function_280d8ac0(params.setype, params.var_d20b8ed2);
            }
        }
    }
    self callback::add_callback(#"done_healing", &function_fab0bbe2);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x0
// Checksum 0x421b7e09, Offset: 0xb08
// Size: 0x12c
function function_d36422b7(slot) {
    self.heal.var_856755e2 = 0;
    if (!isdefined(slot)) {
        slot = ability_util::gadget_slot_for_type(23);
    }
    if (isdefined(slot)) {
        self function_53265cac(slot, 0);
        self function_1d590050(slot, 0);
    }
    if (is_healing()) {
        self clientfield::set_player_uimodel("hudItems.healingActive", 0);
        self.heal.enabled = 0;
        self notify(#"healing_disabled");
        self player::function_26fa96fc();
        if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
            self clientfield::set_to_player("healthregen", 0);
        }
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x861056, Offset: 0xc40
// Size: 0x12
function is_healing() {
    return self.heal.enabled;
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x52aeb643, Offset: 0xc60
// Size: 0x7c
function function_fab0bbe2() {
    if (isdefined(self)) {
        self.heal.var_856755e2 = 0;
        if (self is_healing()) {
            if (isdefined(level.var_d0e5eb94) && !isdefined(self.var_543e76ed)) {
                self [[ level.var_d0e5eb94 ]]();
            }
        }
        self function_d36422b7();
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x0
// Checksum 0xcc4107f8, Offset: 0xce8
// Size: 0xcc
function on_player_damage(params) {
    if (!isdefined(self.gadget_health_regen_slot)) {
        return;
    }
    if (!self is_healing()) {
        return;
    }
    attacker = params.eattacker;
    if (self function_ed38b81(attacker) == 0) {
        damage = params.idamage;
        self.heal.var_93dfabb3 = math::clamp(self.heal.var_93dfabb3 - damage, 0, self.maxhealth);
        return;
    }
    function_3559d8e7();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0xff981be3, Offset: 0xdc0
// Size: 0x34
function function_9162f3b9() {
    if (!isplayer(self)) {
        return;
    }
    self function_3559d8e7();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x4
// Checksum 0x9f64de2f, Offset: 0xe00
// Size: 0x34
function private function_3559d8e7() {
    if (self is_healing()) {
        self function_d36422b7();
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x4
// Checksum 0xb351fe88, Offset: 0xe40
// Size: 0x52
function private function_ed38b81(attacker) {
    if (gettime() < self.heal.var_856755e2) {
        return false;
    }
    if (isdefined(level.deathcircle) && level.deathcircle === attacker) {
        return false;
    }
    return true;
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0xe9816f99, Offset: 0xea0
// Size: 0x4a
function function_7209ea4e() {
    can_set = isdefined(self.gadget_health_regen_slot);
    if (!can_set || "ammo" == self.gadget_health_regen_weapon.gadget_powerusetype) {
        return 0;
    }
    return can_set;
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x2577af7e, Offset: 0xef8
// Size: 0x3c
function power_off() {
    if (self function_7209ea4e()) {
        self gadgetpowerset(self.gadget_health_regen_slot, 0);
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x13c268f8, Offset: 0xf40
// Size: 0x4c
function power_on() {
    if (self function_7209ea4e()) {
        self gadgetpowerset(self.gadget_health_regen_slot, self.gadget_health_regen_weapon.gadget_powermax);
    }
}

