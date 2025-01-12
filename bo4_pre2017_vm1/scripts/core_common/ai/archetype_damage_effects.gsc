#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/debug;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai/systems/shared;
#using scripts/core_common/ai_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/math_shared;

#namespace archetype_damage_effects;

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x2
// Checksum 0xfccbdb62, Offset: 0x248
// Size: 0xe4
function autoexec main() {
    clientfield::register("actor", "arch_actor_fire_fx", 1, 2, "int");
    clientfield::register("actor", "arch_actor_char", 1, 2, "int");
    callback::on_actor_damage(&onactordamagecallback);
    callback::on_vehicle_damage(&function_2bc18574);
    callback::on_actor_killed(&onactorkilledcallback);
    callback::on_vehicle_killed(&function_285b856c);
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x0
// Checksum 0xd17ebf5f, Offset: 0x338
// Size: 0x24
function onactordamagecallback(params) {
    onactordamage(params);
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x0
// Checksum 0x6544a0ea, Offset: 0x368
// Size: 0x24
function function_2bc18574(params) {
    function_ec419ed9(params);
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x0
// Checksum 0xc09114c0, Offset: 0x398
// Size: 0x76
function onactorkilledcallback(params) {
    onactorkilled();
    switch (self.archetype) {
    case #"human":
        function_696061ce();
        break;
    case #"robot":
        function_30a29e89();
        break;
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x0
// Checksum 0x927ea5eb, Offset: 0x418
// Size: 0x24
function function_285b856c(params) {
    function_b5c6dde1(params);
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x0
// Checksum 0x5a395570, Offset: 0x448
// Size: 0xc
function onactordamage(params) {
    
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x0
// Checksum 0xba71599, Offset: 0x460
// Size: 0x24
function function_ec419ed9(params) {
    function_b5c6dde1(params);
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x0
// Checksum 0x3cab77c5, Offset: 0x490
// Size: 0x8c
function onactorkilled() {
    if (isdefined(self.damagemod)) {
        if (self.damagemod == "MOD_BURNED") {
            if (isdefined(self.damageweapon) && isdefined(self.damageweapon.specialpain) && self.damageweapon.specialpain == 0) {
                self clientfield::set("arch_actor_fire_fx", 2);
            }
        }
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x528
// Size: 0x4
function function_696061ce() {
    
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x538
// Size: 0x4
function function_30a29e89() {
    
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x0
// Checksum 0x1816975a, Offset: 0x548
// Size: 0xc
function function_b5c6dde1(params) {
    
}

