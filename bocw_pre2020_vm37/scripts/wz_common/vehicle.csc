#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace wz_vehicle;

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x6
// Checksum 0x2992d999, Offset: 0xd8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_vehicle", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x5 linked
// Checksum 0x8031410e, Offset: 0x120
// Size: 0xa4
function private function_70a657d8() {
    level._effect[#"plane_ambient"] = #"hash_3cb3a6fc9eb00337";
    level._effect[#"plane_ambient_high_alt"] = #"hash_3919b64dc762cab2";
    vehicle::function_2f97bc52("vehicle_t9_plane_flyable_prototype", &function_58e95b55);
    vehicle::function_cd2ede5("vehicle_t9_plane_flyable_prototype", &function_84f28fd9);
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x1 linked
// Checksum 0xc9326561, Offset: 0x1d0
// Size: 0x66
function function_58e95b55(localclientnum, vehicle) {
    if (!self function_21c0fa55()) {
        return;
    }
    vehicle thread function_c6d5a97d(localclientnum);
    if (!isdefined(vehicle.var_3a2e004d)) {
        vehicle.var_3a2e004d = [];
    }
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x1 linked
// Checksum 0xa6d83623, Offset: 0x240
// Size: 0x4c
function function_84f28fd9(localclientnum, vehicle) {
    if (!self function_21c0fa55()) {
        return;
    }
    vehicle thread function_c0119d33(localclientnum);
}

// Namespace wz_vehicle/vehicle
// Params 3, eflags: 0x1 linked
// Checksum 0xef147431, Offset: 0x298
// Size: 0x98
function function_7a5dc47e(localclientnum, height, fx) {
    self endon(#"death", #"hash_2a08d043fde0f8b1");
    while (true) {
        if (self.origin[2] < height) {
            self function_bc80c148(localclientnum, fx);
            self thread function_b57d31e4(localclientnum, height, fx);
            return;
        }
        wait 1;
    }
}

// Namespace wz_vehicle/vehicle
// Params 3, eflags: 0x1 linked
// Checksum 0xcedc6727, Offset: 0x338
// Size: 0xd8
function function_b57d31e4(localclientnum, height, fx) {
    self endon(#"death", #"hash_2a08d043fde0f8b1");
    while (true) {
        if (isdefined(self.var_3a2e004d[fx])) {
            return;
        }
        if (self.origin[2] > height + 100) {
            self.var_3a2e004d[fx] = util::playfxontag(localclientnum, level._effect[fx], self, "tag_origin");
            self thread function_7a5dc47e(localclientnum, 3000, fx);
            return;
        }
        wait 1;
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0xbac4e007, Offset: 0x418
// Size: 0x4c
function function_c6d5a97d(localclientnum) {
    function_b57d31e4(localclientnum, 3000, "plane_ambient");
    function_b57d31e4(localclientnum, 20000, "plane_ambient_high_alt");
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x1 linked
// Checksum 0xef6be016, Offset: 0x470
// Size: 0x5c
function function_bc80c148(localclientnum, fx) {
    if (isdefined(self.var_3a2e004d[fx])) {
        stopfx(localclientnum, self.var_3a2e004d[fx]);
        self.var_3a2e004d[fx] = undefined;
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0x5b0bdc6a, Offset: 0x4d8
// Size: 0x5c
function function_c0119d33(localclientnum) {
    self notify(#"hash_2a08d043fde0f8b1");
    function_bc80c148(localclientnum, "plane_ambient");
    function_bc80c148(localclientnum, "plane_ambient_high_alt");
}

