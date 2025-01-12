#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;

#namespace zm_weap_molotov;

// Namespace zm_weap_molotov/zm_weap_molotov
// Params 0, eflags: 0x2
// Checksum 0x49365021, Offset: 0x98
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"molotov_zm", &__init__, &__main__, undefined);
}

// Namespace zm_weap_molotov/zm_weap_molotov
// Params 0, eflags: 0x0
// Checksum 0xd52f29c, Offset: 0xe8
// Size: 0x24
function __init__() {
    zm::register_actor_damage_callback(&function_568fd3c5);
}

// Namespace zm_weap_molotov/zm_weap_molotov
// Params 0, eflags: 0x0
// Checksum 0x6082ef47, Offset: 0x118
// Size: 0x62
function __main__() {
    level._effect[#"hash_5dfe974bf370a5f4"] = #"zm_weapons/fx8_equip_mltv_fire_human_torso_loop_zm";
    level._effect[#"hash_31b6cc906e6d0ae0"] = #"hash_3937ef26298b6caf";
}

// Namespace zm_weap_molotov/zm_weap_molotov
// Params 12, eflags: 0x0
// Checksum 0xcc73e0eb, Offset: 0x188
// Size: 0x1fe
function function_568fd3c5(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isweapon(weapon)) {
        switch (weapon.name) {
        case #"molotov_fire_tall":
        case #"molotov_fire":
        case #"molotov_fire_wall":
        case #"molotov_fire_small":
        case #"eq_molotov":
        case #"molotov_steam":
            if (meansofdeath === "MOD_GRENADE") {
                if (self.archetype == "zombie" && damage <= self.health) {
                    return self.health;
                }
            }
            self.weapon_specific_fire_death_torso_fx = level._effect[#"hash_5dfe974bf370a5f4"];
            self.weapon_specific_fire_death_sm_fx = level._effect[#"hash_5dfe974bf370a5f4"];
            n_base_damage = damage * 3;
            var_da89a776 = n_base_damage + n_base_damage * 0.3 * math::clamp(level.round_number - 4, 1, 14);
            return var_da89a776;
        }
    }
    return -1;
}

