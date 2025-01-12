#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_uaz;

// Namespace player_uaz/player_uaz
// Params 0, eflags: 0x6
// Checksum 0xc0377c72, Offset: 0x88
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_uaz", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_uaz/player_uaz
// Params 0, eflags: 0x5 linked
// Checksum 0xd2024b7c, Offset: 0xd8
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("player_uaz", &function_bc02ac38);
}

// Namespace player_uaz/player_uaz
// Params 0, eflags: 0x5 linked
// Checksum 0x6e28ce69, Offset: 0x110
// Size: 0xaa
function private function_bc02ac38() {
    self setmovingplatformenabled(1, 0);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_5433bc44);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_b6eaa74f);
    self.var_84fed14b = 40;
    self.var_d6691161 = 175;
    self.var_5d662124 = 2;
}

// Namespace player_uaz/player_uaz
// Params 1, eflags: 0x1 linked
// Checksum 0x5ef484cb, Offset: 0x1c8
// Size: 0x8c
function function_5433bc44(params) {
    player = params.player;
    if (!isdefined(player)) {
        return;
    }
    if (function_3238d10d(self.origin)) {
        playsoundatposition(#"hash_6f19455867d72b7f", self.origin);
    }
    self vehicle::toggle_control_bone_group(1, 1);
}

// Namespace player_uaz/player_uaz
// Params 1, eflags: 0x1 linked
// Checksum 0x8ddfbe2f, Offset: 0x260
// Size: 0xdc
function function_b6eaa74f(params) {
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
            playsoundatposition(#"hash_6f19455867d72b7f", self.origin);
        }
        self vehicle::toggle_control_bone_group(1, 0);
    }
}

