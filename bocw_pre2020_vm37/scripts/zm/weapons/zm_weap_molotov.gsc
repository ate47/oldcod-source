#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_equipment;

#namespace zm_weap_molotov;

// Namespace zm_weap_molotov/zm_weap_molotov
// Params 0, eflags: 0x6
// Checksum 0x5558c3cb, Offset: 0x90
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"molotov_zm", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_weap_molotov/zm_weap_molotov
// Params 0, eflags: 0x4
// Checksum 0xe6122685, Offset: 0xe8
// Size: 0x24
function private function_70a657d8() {
    zm::register_actor_damage_callback(&function_32766bb7);
}

// Namespace zm_weap_molotov/zm_weap_molotov
// Params 0, eflags: 0x4
// Checksum 0x48661ef2, Offset: 0x118
// Size: 0x54
function private postinit() {
    level._effect[#"hash_5dfe974bf370a5f4"] = #"zm_weapons/fx8_equip_mltv_fire_human_torso_loop_zm";
    level._effect[#"hash_31b6cc906e6d0ae0"] = #"hash_3937ef26298b6caf";
}

// Namespace zm_weap_molotov/zm_weap_molotov
// Params 12, eflags: 0x0
// Checksum 0x5411f00b, Offset: 0x178
// Size: 0x1e6
function function_32766bb7(*inflictor, *attacker, damage, *flags, meansofdeath, weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (isweapon(surfacetype)) {
        switch (surfacetype.name) {
        case #"molotov_fire_tall":
        case #"molotov_fire":
        case #"eq_molotov_extra":
        case #"molotov_fire_wall":
        case #"molotov_fire_small":
        case #"eq_molotov":
        case #"molotov_steam":
            if (boneindex === "MOD_GRENADE") {
                if (self.archetype == #"zombie" && psoffsettime <= self.health) {
                    return self.health;
                }
            }
            self.weapon_specific_fire_death_torso_fx = level._effect[#"hash_5dfe974bf370a5f4"];
            self.weapon_specific_fire_death_sm_fx = level._effect[#"hash_5dfe974bf370a5f4"];
            var_5d7b4163 = zm_equipment::function_379f6b5d(psoffsettime, 3, 0.3, 4, 14);
            return var_5d7b4163;
        }
    }
    return -1;
}

