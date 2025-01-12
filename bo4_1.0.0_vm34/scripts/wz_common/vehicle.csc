#using script_38dc72b5220a1a67;
#using script_40e017336a087343;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\driving_fx;

#namespace wz_vehicle;

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x2
// Checksum 0xf0fe3b7b, Offset: 0x120
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_vehicle", &__init__, undefined, undefined);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x0
// Checksum 0xc2b3607f, Offset: 0x168
// Size: 0xe6
function __init__() {
    vehicle::add_vehicletype_callback("player_atv", &function_91ac2519);
    vehicle::add_vehicletype_callback("cargo_truck_wz", &function_9301fa14);
    vehicle::add_vehicletype_callback("zodiac_boat_wz", &function_5573b382);
    vehicle::add_vehicletype_callback("helicopter_light", &function_605ac3ef);
    level.vehicleHealthBar = luielembar::register("vehicleHealthBar");
    level.vehicleHealthBarText = luielemtext::register("vehicleHealthBarText");
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0x52e043fd, Offset: 0x258
// Size: 0x2c
function private function_91ac2519(localclientnum, data) {
    self function_bf2fb2fe(1);
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0x9ad8d081, Offset: 0x290
// Size: 0x2c
function private function_9301fa14(localclientnum, data) {
    self function_bf2fb2fe(1);
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0x179d6aae, Offset: 0x2c8
// Size: 0x5e
function private function_5573b382(localclientnum, data) {
    setdvar(#"phys_buoyancy", 1);
    self.var_7683471e = &function_4d9829bd;
    self.var_b4927dfa = 0;
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0x3d0e9e34, Offset: 0x330
// Size: 0x5c
function private function_605ac3ef(localclientnum, data) {
    self.var_4887bfe6 = &function_e9fdd4c1;
    self.var_425b03d3 = &function_29813f74;
    self thread function_b398e79a(localclientnum);
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0xecd5ad27, Offset: 0x398
// Size: 0x104
function private function_29813f74(localclientnum, owner) {
    surfaces = [];
    if (isdefined(self.trace)) {
        if (self.trace[#"fraction"] != 1) {
            if (!isdefined(surfaces)) {
                surfaces = [];
            } else if (!isarray(surfaces)) {
                surfaces = array(surfaces);
            }
            if (!isinarray(surfaces, driving_fx::function_115b67a9(self.trace[#"surfacetype"]))) {
                surfaces[surfaces.size] = driving_fx::function_115b67a9(self.trace[#"surfacetype"]);
            }
        }
    }
    return surfaces;
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0x4854f73a, Offset: 0x4a8
// Size: 0x10a
function private function_4d9829bd(localclientnum, owner) {
    curtime = gettime();
    if (curtime < self.var_b4927dfa) {
        return self.var_99900bdc;
    }
    self.var_99900bdc = 0;
    if (isdefined(owner)) {
        self.var_b4927dfa = curtime + 500;
        cameraangles = owner getcamangles();
        if (isdefined(cameraangles)) {
            var_ddef42a7 = anglestoforward(cameraangles);
            var_a3dd2060 = anglestoforward(self.angles);
            dot = vectordot(var_ddef42a7, var_a3dd2060);
            if (dot > 0.993) {
                self.var_99900bdc = 1;
            }
        }
    }
    return self.var_99900bdc;
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0xcf8cbe2f, Offset: 0x5c0
// Size: 0x18
function private function_e9fdd4c1(localclientnum, owner) {
    return true;
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0xe8aa1452, Offset: 0x5e0
// Size: 0xc8
function private function_b398e79a(localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"enter_vehicle");
        user = waitresult.player;
        if (isdefined(user)) {
            if (self isdrivingvehicle(user) && user function_60dbc438()) {
                self thread function_13807c26(localclientnum);
                self thread heli_exit(localclientnum);
            }
        }
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0x9f30d4a3, Offset: 0x6b0
// Size: 0x6c
function private heli_exit(localclientnum) {
    self endon(#"death");
    self waittill(#"exit_vehicle");
    player = function_f97e7787(localclientnum);
    if (isdefined(player)) {
        player function_656609e4(localclientnum);
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0xeb3f63bf, Offset: 0x728
// Size: 0x46
function private function_656609e4(localclientnum) {
    if (isdefined(self.var_5d0ec112)) {
        self stoprumble(localclientnum, self.var_5d0ec112);
        self.var_5d0ec112 = undefined;
    }
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0x357401bd, Offset: 0x778
// Size: 0x84
function private function_56670db6(localclientnum, rumble) {
    if (!isdefined(self)) {
        return;
    }
    if (self.var_5d0ec112 === rumble) {
        return;
    }
    if (isdefined(self.var_5d0ec112)) {
        self function_656609e4(localclientnum);
    }
    self.var_5d0ec112 = rumble;
    self playrumblelooponentity(localclientnum, self.var_5d0ec112);
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0x24f18ac4, Offset: 0x808
// Size: 0x1d0
function private function_13807c26(localclientnum) {
    self notify("58770df6ab4db676");
    self endon("58770df6ab4db676");
    self endon(#"death");
    self endon(#"exit_vehicle");
    var_87a2fa1e = 210 * 210;
    offsetorigin = (0, 0, 210 * 2);
    while (true) {
        player = function_f97e7787(localclientnum);
        self.trace = bullettrace(self.origin, self.origin - offsetorigin, 0, self, 1);
        distsqr = distancesquared(self.origin, self.trace[#"position"]);
        if (isdefined(player)) {
            if (self.trace[#"fraction"] == 1) {
                player function_656609e4(localclientnum);
                wait 1;
                continue;
            }
            if (distsqr > var_87a2fa1e) {
                player function_656609e4(localclientnum);
                wait 0.2;
                continue;
            }
            player function_56670db6(localclientnum, "fallwind_loop_slow");
        }
        wait 0.2;
    }
}

