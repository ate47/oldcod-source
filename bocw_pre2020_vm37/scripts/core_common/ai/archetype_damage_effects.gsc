#using script_3819e7a1427df6d2;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;

#namespace archetype_damage_effects;

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x2
// Checksum 0xe82e70d8, Offset: 0xc8
// Size: 0xa4
function autoexec main() {
    clientfield::register("actor", "arch_actor_fire_fx", 1, 2, "int");
    clientfield::register("actor", "arch_actor_char", 1, 2, "int");
    callback::on_actor_damage(&onactordamagecallback);
    callback::on_actor_killed(&onactorkilledcallback);
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x1 linked
// Checksum 0xded319cb, Offset: 0x178
// Size: 0x24
function onactordamagecallback(params) {
    onactordamage(params);
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x1 linked
// Checksum 0xbad31834, Offset: 0x1a8
// Size: 0x1c
function onactorkilledcallback(*params) {
    onactorkilled();
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x5 linked
// Checksum 0x2950f791, Offset: 0x1d0
// Size: 0xbe
function private function_6fedb40d() {
    self endon(#"death");
    if (is_true(self.var_73c36602)) {
        return;
    }
    self clientfield::set("arch_actor_fire_fx", 1);
    self.var_73c36602 = 1;
    wait isdefined(self.var_ab2486b4 / 1000) ? self.var_ab2486b4 / 1000 : 3;
    self clientfield::set("arch_actor_fire_fx", 0);
    self.var_73c36602 = 0;
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x5 linked
// Checksum 0x205bb9c9, Offset: 0x298
// Size: 0x2c
function private function_6eb1fbde() {
    if (self.var_40543c03 === "fire") {
        self thread function_6fedb40d();
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x1 linked
// Checksum 0x985b7bb0, Offset: 0x2d0
// Size: 0xec
function onactordamage(params) {
    self.var_40543c03 = undefined;
    self.var_ab2486b4 = 0;
    if (isdefined(params.weapon) && isdefined(params.weapon.var_8456d4d)) {
        var_8d93b9c8 = aiutility::function_e2010f4c(self, getscriptbundle(params.weapon.var_8456d4d));
        if (isdefined(var_8d93b9c8)) {
            self.var_40543c03 = var_8d93b9c8.effecttype;
            if (!isdefined(var_8d93b9c8.var_4badc00f) || !var_8d93b9c8.var_4badc00f) {
                self.var_ab2486b4 = var_8d93b9c8.duration * 1000;
            }
        }
        self function_6eb1fbde();
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x1 linked
// Checksum 0x211481a2, Offset: 0x3c8
// Size: 0x84
function onactorkilled() {
    if (isdefined(self.damagemod)) {
        if (self.damagemod == "MOD_BURNED") {
            if (isdefined(self.damageweapon) && isdefined(self.damageweapon.specialpain) && self.damageweapon.specialpain == 0) {
                self clientfield::set("arch_actor_fire_fx", 2);
            }
        }
    }
}

