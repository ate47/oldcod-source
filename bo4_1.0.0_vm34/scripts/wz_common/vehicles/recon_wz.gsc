#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace recon_wz;

// Namespace recon_wz/recon_wz
// Params 0, eflags: 0x2
// Checksum 0xcdce298, Offset: 0x100
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"recon_wz", &__init__, undefined, undefined);
}

// Namespace recon_wz/recon_wz
// Params 0, eflags: 0x0
// Checksum 0xe1be47f, Offset: 0x148
// Size: 0xac
function __init__() {
    vehicle::add_main_callback("recon_wz", &function_ac658743);
    callback::on_vehicle_killed(&on_vehicle_killed);
    clientfield::register("toplayer", "recon_out_of_circle", 1, 5, "int");
    clientfield::register("toplayer", "recon_static_postfx", 1, 1, "int");
}

// Namespace recon_wz/recon_wz
// Params 0, eflags: 0x0
// Checksum 0x2c68ba87, Offset: 0x200
// Size: 0x4e
function function_ac658743() {
    self vehicle::toggle_sounds(1);
    self disabledriverfiring(1);
    self.ignore_death_jolt = 1;
    self.var_9c931473 = 1;
}

// Namespace recon_wz/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0xa44ce5b1, Offset: 0x258
// Size: 0xdc
function event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    vehicle = eventstruct.vehicle;
    if (!isdefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != "recon_wz") {
        return;
    }
    self clientfield::set_to_player("recon_static_postfx", 1);
    vehicle makevehicleusable();
    vehicle thread watchownerdisconnect(self);
    self thread function_48c20fc0(vehicle);
}

// Namespace recon_wz/recon_wz
// Params 1, eflags: 0x0
// Checksum 0x5d1cf50a, Offset: 0x340
// Size: 0x9c
function watchownerdisconnect(player) {
    self notify("559c5d7f4c50ca86");
    self endon("559c5d7f4c50ca86");
    self endon(#"death", #"exit_vehicle");
    player waittill(#"disconnect", #"death");
    self makevehicleunusable();
    self thread function_f07e956c();
}

// Namespace recon_wz/exit_vehicle
// Params 1, eflags: 0x40
// Checksum 0x2f87371d, Offset: 0x3e8
// Size: 0xf4
function event_handler[exit_vehicle] codecallback_vehicleexit(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    self clientfield::set_to_player("recon_out_of_circle", 0);
    vehicle = eventstruct.vehicle;
    if (!isdefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != "recon_wz") {
        return;
    }
    self clientfield::set_to_player("recon_static_postfx", 0);
    if (isalive(vehicle)) {
        vehicle makevehicleunusable();
        vehicle thread function_f07e956c();
    }
}

// Namespace recon_wz/recon_wz
// Params 1, eflags: 0x4
// Checksum 0xa02ae073, Offset: 0x4e8
// Size: 0x308
function private function_48c20fc0(vehicle) {
    self notify("1d4690110f6c9793");
    self endon("1d4690110f6c9793");
    self endon(#"death");
    self endon(#"disconnect");
    vehicle endon(#"death");
    vehicle endon(#"exit_vehicle");
    while (true) {
        if (vehicle function_eba7c157()) {
            vehicle dodamage(vehicle.health, vehicle.origin);
        } else {
            var_b144ab0e = distancesquared(self.origin, vehicle.origin);
            if (var_b144ab0e > 8000 * 8000) {
                vehicle usevehicle(self, 0);
            }
        }
        if (isdefined(level.deathcircle)) {
            if (distance2dsquared(vehicle.origin, level.deathcircle.origin) > level.deathcircle.radius * level.deathcircle.radius) {
                if (!isdefined(vehicle.var_1ce9c343)) {
                    vehicle.var_1ce9c343 = gettime();
                }
                var_a577b591 = gettime() - vehicle.var_1ce9c343;
                if (int(3 * 1000) <= var_a577b591) {
                    vehicle usevehicle(self, 0);
                    self clientfield::set_to_player("recon_out_of_circle", 0);
                }
                var_7d19c76b = min(var_a577b591, int(3 * 1000));
                var_7d19c76b /= int(3 * 1000);
                var_7d19c76b *= 31;
                self clientfield::set_to_player("recon_out_of_circle", int(var_7d19c76b));
                waitframe(1);
            } else {
                self clientfield::set_to_player("recon_out_of_circle", 0);
                vehicle.var_1ce9c343 = undefined;
                wait 0.5;
            }
            continue;
        }
        wait 0.1;
    }
}

// Namespace recon_wz/recon_wz
// Params 0, eflags: 0x4
// Checksum 0x92f10881, Offset: 0x7f8
// Size: 0x9c
function private function_f07e956c() {
    self notify("4c87d4d4dee1bcb8");
    self endon("4c87d4d4dee1bcb8");
    self endon(#"death");
    while (true) {
        speed = abs(self getspeedmph());
        if (speed < 0.1) {
            self notify(#"hash_363004a4e0ccc1f");
            return;
        }
        wait 0.1;
    }
}

// Namespace recon_wz/recon_wz
// Params 1, eflags: 0x4
// Checksum 0xf5ff8d29, Offset: 0x8a0
// Size: 0x8c
function private on_vehicle_killed(params) {
    if (!isdefined(self.scriptvehicletype) || self.scriptvehicletype != "recon_wz") {
        return;
    }
    wait 0.1;
    if (isdefined(self)) {
        self.var_dd8f3836 = 1;
        self ghost();
    }
    wait 2;
    if (isdefined(self)) {
        self delete();
    }
}

