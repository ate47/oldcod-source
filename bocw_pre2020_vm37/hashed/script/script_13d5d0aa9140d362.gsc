#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_e51c1e80;

// Namespace namespace_e51c1e80/namespace_e51c1e80
// Params 1, eflags: 0x1 linked
// Checksum 0xf6742806, Offset: 0x208
// Size: 0xfc
function function_c772bd2c(destination) {
    level flag::set(#"hash_6559e11da1f3a7cf");
    if (isdefined(destination.a_vehicles)) {
        foreach (vehicle in destination.a_vehicles) {
            if (isdefined(vehicle)) {
                vehicle delete();
                util::wait_network_frame();
            }
        }
    }
    level flag::clear(#"hash_6559e11da1f3a7cf");
}

// Namespace namespace_e51c1e80/namespace_e51c1e80
// Params 1, eflags: 0x1 linked
// Checksum 0x7827260d, Offset: 0x310
// Size: 0x2f0
function spawn_vehicles(destination) {
    level flag::wait_till_clear(#"hash_6559e11da1f3a7cf");
    a_spawns = function_6465d1fa(destination);
    var_33ffcb09 = 0;
    foreach (spawn in a_spawns) {
        switch (spawn.targetname) {
        case #"mp_map_wide_fav_spawn":
            var_22e1dc7 = "vehicle_t9_mil_fav_light";
            break;
        case #"mp_map_wide_jetski_spawn":
            var_22e1dc7 = "veh_boct_mil_jetski";
            break;
        case #"mp_map_wide_motorcycle_spawn":
            var_22e1dc7 = "vehicle_motorcycle_mil_us_offroad";
            break;
        case #"mp_map_wide_pbr_spawn":
            var_22e1dc7 = "vehicle_boct_mil_boat_pbr";
            break;
        case #"mp_map_wide_snowmobile_spawn":
            var_22e1dc7 = "vehicle_t9_mil_snowmobile";
            break;
        case #"mp_map_wide_uaz_spawn":
            var_22e1dc7 = "vehicle_t9_mil_ru_truck_light_player";
            break;
        default:
            var_22e1dc7 = undefined;
            break;
        }
        if (isdefined(var_22e1dc7) && function_e0a22931(var_22e1dc7)) {
            vehicle = spawnvehicle(var_22e1dc7, spawn.origin, spawn.angles, "sr_vehicle");
            vehicle makevehicleusable();
            if (!isdefined(destination.a_vehicles)) {
                destination.a_vehicles = [];
            } else if (!isarray(destination.a_vehicles)) {
                destination.a_vehicles = array(destination.a_vehicles);
            }
            destination.a_vehicles[destination.a_vehicles.size] = vehicle;
            var_33ffcb09++;
            if (var_33ffcb09 > a_spawns.size / 2 || getvehiclearray().size > 50) {
                return;
            }
            util::wait_network_frame();
        }
    }
}

// Namespace namespace_e51c1e80/namespace_e51c1e80
// Params 1, eflags: 0x1 linked
// Checksum 0xf944fb6e, Offset: 0x608
// Size: 0x26a
function function_6465d1fa(destination) {
    triggers = [];
    if (!isdefined(destination.var_fe2612fe[#"hash_3460aae6bb799a99"])) {
        return [];
    }
    var_a91694c7 = function_de75fe06();
    foreach (struct in destination.var_fe2612fe[#"hash_3460aae6bb799a99"]) {
        triggers[triggers.size] = getent(struct.targetname, "target");
    }
    a_spawns = [];
    if (isarray(triggers)) {
        foreach (spawn in var_a91694c7) {
            var_dcb79cb0 = 0;
            foreach (trigger in triggers) {
                if (trigger istouching(spawn.origin)) {
                    var_dcb79cb0 = 1;
                    break;
                }
            }
            if (!var_dcb79cb0) {
                continue;
            }
            a_spawns[a_spawns.size] = spawn;
        }
    }
    return array::randomize(a_spawns);
}

// Namespace namespace_e51c1e80/namespace_e51c1e80
// Params 0, eflags: 0x5 linked
// Checksum 0xeeb9500, Offset: 0x880
// Size: 0x116
function private function_de75fe06() {
    var_a91694c7 = [];
    var_86c74be8 = array("mp_map_wide_fav_spawn", "mp_map_wide_jetski_spawn", "mp_map_wide_motorcycle_spawn", "mp_map_wide_pbr_spawn", "mp_map_wide_snowmobile_spawn", "mp_map_wide_uaz_spawn");
    foreach (str_targetname in var_86c74be8) {
        var_8919b491 = function_91b29d2a(str_targetname);
        if (isdefined(var_8919b491)) {
            var_a91694c7 = arraycombine(var_a91694c7, var_8919b491, 0, 0);
        }
    }
    return var_a91694c7;
}

