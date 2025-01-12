#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_suv;

// Namespace player_suv/player_suv
// Params 0, eflags: 0x6
// Checksum 0xd1785dcb, Offset: 0x88
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_suv", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_suv/player_suv
// Params 0, eflags: 0x5 linked
// Checksum 0xa4b92cdb, Offset: 0xd8
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("player_suv", &function_79500af5);
}

// Namespace player_suv/player_suv
// Params 0, eflags: 0x5 linked
// Checksum 0xbeaf3779, Offset: 0x110
// Size: 0xaa
function private function_79500af5() {
    self setmovingplatformenabled(1, 0);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_1592c29e);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_67e1a636);
    self.var_84fed14b = 40;
    self.var_d6691161 = 175;
    self.var_5d662124 = 2;
}

// Namespace player_suv/player_suv
// Params 1, eflags: 0x1 linked
// Checksum 0x26a6e584, Offset: 0x1c8
// Size: 0x8c
function function_1592c29e(params) {
    player = params.player;
    if (!isdefined(player)) {
        return;
    }
    if (function_3238d10d(self.origin)) {
        playsoundatposition(#"hash_7a0942da55ff521d", self.origin);
    }
    self vehicle::toggle_control_bone_group(1, 1);
}

// Namespace player_suv/player_suv
// Params 1, eflags: 0x1 linked
// Checksum 0x79da1f64, Offset: 0x260
// Size: 0xdc
function function_67e1a636(params) {
    player = params.player;
    if (!isdefined(player)) {
        return;
    }
    if (!isalive(self)) {
        return;
    }
    occupants = self getvehoccupants();
    if (!isdefined(occupants) || occupants.size == 0) {
        if (function_3238d10d(self.origin)) {
            playsoundatposition(#"hash_7a0942da55ff521d", self.origin);
        }
        self vehicle::toggle_control_bone_group(1, 0);
    }
}

