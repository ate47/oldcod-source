#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;

#namespace archetype_damage_effects;

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x2
// Checksum 0x9a8b2afe, Offset: 0xc0
// Size: 0xa4
function autoexec main() {
    clientfield::register("actor", "arch_actor_fire_fx", 1, 2, "int");
    clientfield::register("actor", "arch_actor_char", 1, 2, "int");
    callback::on_actor_damage(&onactordamagecallback);
    callback::on_actor_killed(&onactorkilledcallback);
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x0
// Checksum 0xc50b5a17, Offset: 0x170
// Size: 0x24
function onactordamagecallback(params) {
    onactordamage(params);
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x0
// Checksum 0xfc6cf141, Offset: 0x1a0
// Size: 0x1c
function onactorkilledcallback(params) {
    onactorkilled();
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x4
// Checksum 0xce1a120f, Offset: 0x1c8
// Size: 0xb6
function private function_f064befa() {
    self endon(#"death");
    if (isdefined(self.var_2528abc5) && self.var_2528abc5) {
        return;
    }
    self clientfield::set("arch_actor_fire_fx", 1);
    self.var_2528abc5 = 1;
    wait isdefined(self.var_95f5f66f / 1000) ? self.var_95f5f66f / 1000 : 3;
    self clientfield::set("arch_actor_fire_fx", 0);
    self.var_2528abc5 = 0;
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x4
// Checksum 0x3da4b0e2, Offset: 0x288
// Size: 0x2c
function private function_5db39db6() {
    if (self.var_a38dd6f === "fire") {
        self thread function_f064befa();
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x0
// Checksum 0x11d7aead, Offset: 0x2c0
// Size: 0x104
function onactordamage(params) {
    self.var_a38dd6f = undefined;
    self.var_95f5f66f = 0;
    if (isdefined(params.weapon) && isdefined(params.weapon.var_ff65a347)) {
        var_31083b17 = aiutility::function_df7f9ded(self, getscriptbundle(params.weapon.var_ff65a347));
        if (isdefined(var_31083b17)) {
            self.var_a38dd6f = var_31083b17.effecttype;
            if (!isdefined(var_31083b17.var_78c9fb8c) || !var_31083b17.var_78c9fb8c) {
                self.var_95f5f66f = var_31083b17.duration * 1000;
            }
        }
        self function_5db39db6();
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x0
// Checksum 0x2ec55532, Offset: 0x3d0
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

