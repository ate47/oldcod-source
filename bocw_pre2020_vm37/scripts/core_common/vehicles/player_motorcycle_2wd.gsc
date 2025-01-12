#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_motorcycle_2wd;

// Namespace player_motorcycle_2wd/player_motorcycle_2wd
// Params 0, eflags: 0x6
// Checksum 0x2e032b7a, Offset: 0xa8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_motorcycle_2wd", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_motorcycle_2wd/player_motorcycle_2wd
// Params 0, eflags: 0x5 linked
// Checksum 0x6ea9fd29, Offset: 0xf8
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("player_motorcycle_2wd", &function_9835edf5);
}

// Namespace player_motorcycle_2wd/player_motorcycle_2wd
// Params 0, eflags: 0x5 linked
// Checksum 0x3f61e54a, Offset: 0x130
// Size: 0x10c
function private function_9835edf5() {
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_d0a9a026);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_e1f72671);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_177abcbb);
    callback::function_d8abfc3d(#"hash_551381cffdc79048", &function_8ba31952);
    self.var_d6691161 = 200;
    self.var_5002d77c = 0.6;
    self.var_a195943 = 1;
    self vehicle::toggle_control_bone_group(1, 1);
}

// Namespace player_motorcycle_2wd/player_motorcycle_2wd
// Params 1, eflags: 0x5 linked
// Checksum 0xfc9567f3, Offset: 0x248
// Size: 0x1a4
function private function_e1f72671(params) {
    occupants = self getvehoccupants();
    if (!isdefined(occupants) || occupants.size == 0) {
        self notify(#"hash_7d134b21d3606f90");
        if (lengthsquared(self.velocity) > function_a3f6cdac(200)) {
            var_6ceae60 = (0, -5, 0);
            var_99d6b963 = rotatepoint(var_6ceae60, self.angles);
            var_63c1fd8 = (-25 + randomfloat(30), 0, -22 + randomfloat(5));
            self launchvehicle(var_99d6b963, var_63c1fd8, 1, 1);
        } else {
            self vehicle::toggle_control_bone_group(1, 1);
        }
        return;
    }
    if (isdefined(occupants) && occupants.size >= 0 && params.eventstruct.seat_index === 0) {
        function_164c8246();
    }
}

// Namespace player_motorcycle_2wd/player_motorcycle_2wd
// Params 1, eflags: 0x5 linked
// Checksum 0x2668209, Offset: 0x3f8
// Size: 0x3c
function private function_d0a9a026(params) {
    if (params.eventstruct.seat_index === 0) {
        function_8892a46e();
    }
}

// Namespace player_motorcycle_2wd/player_motorcycle_2wd
// Params 1, eflags: 0x1 linked
// Checksum 0x9a4a7246, Offset: 0x440
// Size: 0x6c
function function_177abcbb(params) {
    if (isalive(self)) {
        if (params.eventstruct.seat_index === 0) {
            function_8892a46e();
            return;
        }
        function_164c8246();
    }
}

// Namespace player_motorcycle_2wd/player_motorcycle_2wd
// Params 0, eflags: 0x5 linked
// Checksum 0xd89a1508, Offset: 0x4b8
// Size: 0x4e
function private function_8892a46e() {
    self launchvehicle((0, 0, 0), (0, 0, 0), 0, 2);
    self vehicle::toggle_control_bone_group(1, 0);
    self notify(#"hash_7d134b21d3606f90");
}

// Namespace player_motorcycle_2wd/player_motorcycle_2wd
// Params 0, eflags: 0x5 linked
// Checksum 0xbef01b8d, Offset: 0x510
// Size: 0x6c
function private function_164c8246() {
    if (lengthsquared(self.velocity) > function_a3f6cdac(200)) {
        self thread function_45cb4291();
        return;
    }
    self vehicle::toggle_control_bone_group(1, 1);
}

// Namespace player_motorcycle_2wd/player_motorcycle_2wd
// Params 0, eflags: 0x5 linked
// Checksum 0x23abfd57, Offset: 0x588
// Size: 0xc0
function private function_45cb4291() {
    self notify("2189ba4a2289f9ca");
    self endon("2189ba4a2289f9ca");
    self endon(#"death", #"hash_7d134b21d3606f90");
    while (true) {
        wait 1;
        if (isalive(self)) {
            if (lengthsquared(self.velocity) <= function_a3f6cdac(200)) {
                self vehicle::toggle_control_bone_group(1, 1);
                return;
            }
            continue;
        }
        return;
    }
}

// Namespace player_motorcycle_2wd/player_motorcycle_2wd
// Params 1, eflags: 0x5 linked
// Checksum 0xb979c4d1, Offset: 0x650
// Size: 0x84
function private function_8ba31952(*params) {
    if (!isalive(self)) {
        return;
    }
    occupants = self getvehoccupants();
    if (!isdefined(occupants) || occupants.size == 0) {
        self launchvehicle((0, 0, 0), (0, 0, 0), 0, 1);
    }
}

