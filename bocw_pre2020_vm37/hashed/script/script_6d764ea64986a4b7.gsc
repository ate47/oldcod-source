#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_b56cd47a;

// Namespace namespace_b56cd47a/namespace_b56cd47a
// Params 0, eflags: 0x6
// Checksum 0x6296e59a, Offset: 0xf0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_49a55071662411a3", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace namespace_b56cd47a/namespace_b56cd47a
// Params 0, eflags: 0x5 linked
// Checksum 0x5495dac2, Offset: 0x140
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("cargo_truck_wz", &function_8278ed00);
}

// Namespace namespace_b56cd47a/namespace_b56cd47a
// Params 0, eflags: 0x5 linked
// Checksum 0xde82a31f, Offset: 0x178
// Size: 0xc2
function private function_8278ed00() {
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_ea9787a8);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_d6b61fcc);
    self.var_93dc9da9 = "veh_truck_wall_imp";
    self.var_4ca92b57 = 30;
    self.var_57371c71 = 60;
    self.var_84fed14b = 30;
    self.var_d6691161 = 150;
    self.var_5d662124 = 2;
}

// Namespace namespace_b56cd47a/namespace_b56cd47a
// Params 1, eflags: 0x5 linked
// Checksum 0x624363e2, Offset: 0x248
// Size: 0x94
function private function_ea9787a8(params) {
    player = params.player;
    seatindex = params.eventstruct.seat_index;
    if (seatindex == 0) {
        playfxontag("vehicle/fx8_exhaust_truck_cargo_startup_os", self, "tag_fx_exhaust");
        if (isdefined(player)) {
            player playrumbleonentity("jet_rumble");
        }
    }
}

// Namespace namespace_b56cd47a/namespace_b56cd47a
// Params 1, eflags: 0x5 linked
// Checksum 0x10cc0336, Offset: 0x2e8
// Size: 0x94
function private function_d6b61fcc(params) {
    player = params.player;
    seatindex = params.eventstruct.seat_index;
    if (seatindex == 0) {
        playfxontag("vehicle/fx8_exhaust_truck_cargo_startup_os", self, "tag_fx_exhaust");
        if (isdefined(player)) {
            player playrumbleonentity("jet_rumble");
        }
    }
}

