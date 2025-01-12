#using script_4ce5d94e8c797350;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\zm_common\zm_hud;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_silver_zones;

// Namespace zm_silver_zones/zm_silver_zones
// Params 0, eflags: 0x2
// Checksum 0x58f2eca7, Offset: 0x678
// Size: 0x24
function autoexec init() {
    callback::on_spawned(&function_29ec1ad7);
}

// Namespace zm_silver_zones/zm_silver_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x1ecbca56, Offset: 0x6a8
// Size: 0xb9c
function zone_init() {
    level flag::init("always_on");
    level flag::set("always_on");
    zm_zonemgr::zone_init("zone_proto_start");
    zm_zonemgr::add_adjacent_zone("zone_proto_start", "zone_proto_start2", "always_on", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_start", "zone_proto_interior_lower", "connect_start_to_proto_interior", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_start", "zone_power_tunnel", "connect_to_power_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_start2", "zone_power_tunnel", "connect_to_power_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_start2", "zone_proto_interior_cave", "connect_start_to_proto_cave", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_upstairs", "zone_proto_plane_exterior", "connect_upstairs_to_proto_plane_exterior", 0);
    zm_zonemgr::add_zone_flags("connect_upstairs_to_proto_plane_exterior", "connect_upstairs_to_roof");
    zm_zonemgr::add_zone_flags("connect_upstairs_to_proto_cave", "connect_upstairs_to_roof");
    zm_zonemgr::add_adjacent_zone("zone_proto_roof_plane", "zone_proto_plane_exterior", "connect_roof_to_plane", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_roof_plane", "zone_proto_roof_center", "connect_roof_center_to_roof", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_interior_cave", "zone_proto_upstairs", "connect_upstairs_to_proto_cave", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_interior_lower", "zone_proto_interior_cave", "connect_cave_to_proto_interior", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_interior_lower", "zone_proto_upstairs_2", "connect_interior_to_proto_upstairs_2", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_interior_lower", "zone_proto_exterior_rear", "connect_interior_to_proto_exterior_rear", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_upstairs_2", "zone_proto_upstairs", "connect_upstairs_2_to_proto_upstairs", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_upstairs_2", "zone_proto_exterior_rear", "connect_upstairs_2_to_proto_exterior_rear", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_upstairs_2", "zone_proto_roof_center", "connect_upstairs_2_to_roof", 0);
    zm_zonemgr::add_zone_flags("connect_interior_to_proto_upstairs_2", "connect_upstairs_2_to_roof");
    zm_zonemgr::add_zone_flags("connect_upstairs_2_to_proto_upstairs", "connect_upstairs_2_to_roof");
    zm_zonemgr::add_zone_flags("connect_upstairs_2_to_proto_exterior_rear", "connect_upstairs_2_to_roof");
    zm_zonemgr::add_adjacent_zone("zone_proto_roof_center", "zone_proto_exterior_rear", "connect_upstairs_2_to_proto_exterior_rear");
    zm_zonemgr::add_adjacent_zone("zone_proto_plane_exterior", "zone_proto_exterior_rear", "connect_plane_2_to_proto_front", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_plane_exterior", "zone_tunnel_interior", "connect_plane_to_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_plane_exterior", "zone_proto_plane_exterior2", "connect_plane_exterior", 0);
    zm_zonemgr::add_zone_flags("connect_upstairs_to_proto_plane_exterior", "connect_plane_exterior");
    zm_zonemgr::add_zone_flags("connect_roof_to_plane", "connect_plane_exterior");
    zm_zonemgr::add_zone_flags("connect_plane_2_to_proto_front", "connect_plane_exterior");
    zm_zonemgr::add_zone_flags("connect_plane_to_tunnel", "connect_plane_exterior");
    zm_zonemgr::add_adjacent_zone("zone_proto_exterior_rear2", "zone_tunnel_interior", "connect_proto_exterior_rear_to_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_proto_exterior_rear2", "zone_proto_exterior_rear", "connect_exterior_rear", 0);
    zm_zonemgr::add_zone_flags("connect_proto_exterior_rear_to_tunnel", "connect_exterior_rear");
    zm_zonemgr::add_zone_flags("connect_upstairs_2_to_proto_exterior_rear", "connect_exterior_rear");
    zm_zonemgr::add_zone_flags("connect_plane_2_to_proto_front", "connect_exterior_rear");
    zm_zonemgr::add_zone_flags("connect_upstairs_2_to_proto_exterior_rear", "connect_exterior_rear");
    zm_zonemgr::add_adjacent_zone("zone_tunnel_interior", "zone_power_room", "connect_tunnel_to_power_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_power_room", "zone_power_trans_north", "connect_power_trans_north_to_trans_north_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_power_room", "zone_power_trans_south", "connect_power_trans_south_to_trans_south_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_power_trans_north", "zone_trans_north", "connect_power_trans_north_to_trans_north_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_trans_north", "zone_center_upper_north", "connect_trans_north_to_center_upper_north_room", 0);
    zm_zonemgr::add_zone_flags("connect_power_trans_north_to_trans_north_room", "connect_medical_bay");
    zm_zonemgr::add_zone_flags("connect_trans_north_to_center_upper_north_room", "connect_medical_bay");
    zm_zonemgr::add_adjacent_zone("zone_center_upper_north", "zone_center_lower", "connect_center_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_center_upper_north", "zone_center_upper", "connect_center_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_power_trans_south", "zone_trans_south", "connect_power_trans_south_to_trans_south_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_trans_south", "zone_center_upper_west", "connect_trans_south_to_center_upper_west_room", 0);
    zm_zonemgr::add_zone_flags("connect_power_trans_south_to_trans_south_room", "connect_weapon_lab");
    zm_zonemgr::add_zone_flags("connect_trans_south_to_center_upper_west_room", "connect_weapon_lab");
    zm_zonemgr::add_adjacent_zone("zone_center_upper_west", "zone_center_lower", "connect_center_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_center_upper_west", "zone_center_upper", "connect_center_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_center_lower", "zone_center_upper", "connect_center_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_center_upper", "zone_power_tunnel", "connect_to_power_tunnel", 0);
    zm_zonemgr::add_zone_flags("connect_trans_north_to_center_upper_north_room", "connect_center_room");
    zm_zonemgr::add_zone_flags("connect_trans_south_to_center_upper_west_room", "connect_center_room");
    zm_zonemgr::add_zone_flags("connect_to_power_tunnel", "connect_center_room");
    zm_zonemgr::add_zone_flags("connect_proto_exterior_rear_to_tunnel", "connect_tunnel_to_power_room");
    zm_zonemgr::add_zone_flags("connect_plane_to_tunnel", "connect_tunnel_to_power_room");
    namespace_f0b43eb5::create_challenge(14, 90, "zone_proto_start", undefined, #"hash_5cee7e17aff44d7e");
    namespace_f0b43eb5::create_challenge(15, 90, "zone_proto_interior_lower", undefined, #"hash_5cee7e17aff44d7e");
    namespace_f0b43eb5::create_challenge(16, 90, "zone_proto_upstairs", undefined, #"hash_5cee7e17aff44d7e");
    namespace_f0b43eb5::create_challenge(18, 90, "zone_proto_roof_center", undefined, #"hash_5cee7e17aff44d7e");
    namespace_f0b43eb5::create_challenge(17, 90, "zone_power_tunnel", undefined, #"hash_5cee7e17aff44d7e");
    namespace_f0b43eb5::create_challenge(19, 90, "zone_trans_north", undefined, #"hash_3a546d517334011e");
    namespace_f0b43eb5::create_challenge(20, 90, "zone_proto_roof_center", undefined, #"hash_3a546d517334011e");
    namespace_f0b43eb5::create_challenge(21, 90, "zone_center_upper", undefined, #"hash_3a546d517334011e");
    namespace_f0b43eb5::create_challenge(22, 90, "zone_proto_exterior_rear", undefined, #"hash_3a546d517334011e");
    namespace_f0b43eb5::create_challenge(23, 90, "zone_power_room", undefined, #"hash_3a546d517334011e");
    namespace_f0b43eb5::create_challenge(1, 90, "zone_proto_start", undefined, #"hash_374955e0c82d6aa4");
    namespace_f0b43eb5::create_challenge(2, 90, "zone_proto_exterior_rear", undefined, #"hash_374955e0c82d6aa4");
    namespace_f0b43eb5::create_challenge(3, 90, "zone_proto_plane_exterior", undefined, #"hash_374955e0c82d6aa4");
    namespace_f0b43eb5::create_challenge(5, 90, "zone_tunnel_interior", undefined, #"hash_374955e0c82d6aa4");
    namespace_f0b43eb5::create_challenge(4, 90, "zone_trans_north", undefined, #"hash_374955e0c82d6aa4");
    namespace_f0b43eb5::create_challenge(6, 90, "zone_center_upper", undefined, #"hash_374955e0c82d6aa4");
    namespace_f0b43eb5::create_challenge(7, 90, "zone_trans_south", undefined, #"hash_374955e0c82d6aa4");
}

// Namespace zm_silver_zones/zm_silver_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x532778a3, Offset: 0x1250
// Size: 0x1c
function function_29ec1ad7() {
    self thread function_8e0b371();
}

// Namespace zm_silver_zones/zm_silver_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xf00ef55, Offset: 0x1278
// Size: 0xb8
function function_8e0b371() {
    self endon(#"disconnect");
    while (true) {
        if (isalive(self)) {
            str_location = function_ab7f70b9(self);
            self zm_hud::function_29780fb5(isdefined(str_location) ? str_location : #"");
        } else {
            self zm_hud::function_29780fb5(#"");
        }
        wait 0.5;
    }
}

// Namespace zm_silver_zones/zm_silver_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x3fa20431, Offset: 0x1338
// Size: 0x346
function function_ab7f70b9(e_player) {
    str_zone = e_player zm_zonemgr::get_player_zone();
    if (!isdefined(str_zone)) {
        return undefined;
    }
    switch (str_zone) {
    case #"zone_proto_start2":
    case #"zone_proto_start":
        var_601fee0 = #"hash_5dec24fd79fe88e4";
        break;
    case #"zone_proto_upstairs":
        var_601fee0 = #"hash_1883157e3a8c1bcf";
        break;
    case #"zone_proto_interior_cave":
        var_601fee0 = #"hash_3b12520037a181";
        break;
    case #"zone_proto_interior_lower":
        var_601fee0 = #"hash_48fcaccdc583f88a";
        break;
    case #"zone_proto_upstairs_2":
        var_601fee0 = #"hash_58e5493c26a40efd";
        break;
    case #"zone_proto_roof_center":
        var_601fee0 = #"hash_29459d2873e524e";
        break;
    case #"zone_proto_roof_plane":
        var_601fee0 = #"hash_29459d2873e524e";
        break;
    case #"zone_proto_plane_exterior":
    case #"zone_proto_plane_exterior2":
        var_601fee0 = #"hash_621ea24bd69a239";
        break;
    case #"zone_proto_exterior_rear":
    case #"zone_proto_exterior_rear2":
        var_601fee0 = #"hash_3b327c1463ec9f8d";
        break;
    case #"zone_tunnel_interior":
        var_601fee0 = #"hash_32b5142fe11acb26";
        break;
    case #"zone_power_room":
    case #"zone_power_trans_north":
    case #"zone_power_trans_south":
        var_601fee0 = #"hash_3f356cdd2bb6e576";
        break;
    case #"zone_trans_north":
        var_601fee0 = #"hash_3e51b8ba7a93fbe";
        break;
    case #"zone_trans_south":
        var_601fee0 = #"hash_7988e17f66389e69";
        break;
    case #"zone_center_upper_west":
    case #"zone_center_lower":
    case #"zone_center_upper_north":
    case #"zone_center_upper":
        var_601fee0 = #"hash_57edcb7278524c75";
        break;
    case #"zone_power_tunnel":
        var_601fee0 = #"hash_75f7127232f283bb";
        break;
    default:
        var_601fee0 = undefined;
        break;
    }
    return var_601fee0;
}

// Namespace zm_silver_zones/zm_silver_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x4a1d1fef, Offset: 0x1688
// Size: 0x326
function function_27028b8e(str_zone) {
    if (!isdefined(str_zone)) {
        return undefined;
    }
    switch (str_zone) {
    case #"zone_proto_start2":
    case #"zone_proto_start":
        var_601fee0 = #"hash_5dec24fd79fe88e4";
        break;
    case #"zone_proto_upstairs":
        var_601fee0 = #"hash_1883157e3a8c1bcf";
        break;
    case #"zone_proto_interior_cave":
        var_601fee0 = #"hash_3b12520037a181";
        break;
    case #"zone_proto_interior_lower":
        var_601fee0 = #"hash_48fcaccdc583f88a";
        break;
    case #"zone_proto_upstairs_2":
        var_601fee0 = #"hash_58e5493c26a40efd";
        break;
    case #"zone_proto_roof_center":
        var_601fee0 = #"hash_29459d2873e524e";
        break;
    case #"zone_proto_roof_plane":
        var_601fee0 = #"hash_29459d2873e524e";
        break;
    case #"zone_proto_plane_exterior":
    case #"zone_proto_plane_exterior2":
        var_601fee0 = #"hash_621ea24bd69a239";
        break;
    case #"zone_proto_exterior_rear":
    case #"zone_proto_exterior_rear2":
        var_601fee0 = #"hash_3b327c1463ec9f8d";
        break;
    case #"zone_tunnel_interior":
        var_601fee0 = #"hash_32b5142fe11acb26";
        break;
    case #"zone_power_room":
    case #"zone_power_trans_north":
    case #"zone_power_trans_south":
        var_601fee0 = #"hash_3f356cdd2bb6e576";
        break;
    case #"zone_trans_north":
        var_601fee0 = #"hash_3e51b8ba7a93fbe";
        break;
    case #"zone_trans_south":
        var_601fee0 = #"hash_7988e17f66389e69";
        break;
    case #"zone_center_upper_west":
    case #"zone_center_lower":
    case #"zone_center_upper_north":
    case #"zone_center_upper":
        var_601fee0 = #"hash_57edcb7278524c75";
        break;
    case #"zone_power_tunnel":
        var_601fee0 = #"hash_75f7127232f283bb";
        break;
    default:
        var_601fee0 = undefined;
        break;
    }
    return var_601fee0;
}

