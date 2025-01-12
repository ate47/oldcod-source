#using scripts\core_common\struct;

#namespace zodt8_sound;

// Namespace zodt8_sound/zm_zodt8_sound
// Params 0, eflags: 0x0
// Checksum 0x19c2ea0f, Offset: 0x78
// Size: 0x1e
function main() {
    level.var_e4e95db = &function_e4e95db;
}

// Namespace zodt8_sound/zm_zodt8_sound
// Params 1, eflags: 0x0
// Checksum 0x8bfe63ee, Offset: 0xa0
// Size: 0xee
function function_e4e95db(str_weapon_name) {
    if (!isdefined(str_weapon_name)) {
        return undefined;
    }
    str_weapon = undefined;
    switch (str_weapon_name) {
    case #"ww_tricannon_fire_t8":
    case #"ww_tricannon_earth_t8":
    case #"ww_tricannon_t8_upgraded":
    case #"ww_tricannon_air_t8_upgraded":
    case #"ww_tricannon_earth_t8_upgraded":
    case #"ww_tricannon_fire_t8_upgraded":
    case #"ww_tricannon_water_t8_upgraded":
    case #"ww_tricannon_water_t8":
    case #"ww_tricannon_t8":
    case #"ww_tricannon_air_t8":
        str_weapon = "wonder";
        break;
    }
    return str_weapon;
}

