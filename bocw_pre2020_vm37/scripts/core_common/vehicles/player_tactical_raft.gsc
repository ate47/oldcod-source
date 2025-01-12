#using script_40fc784c60f9fa7b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_tactical_raft;

// Namespace player_tactical_raft/player_tactical_raft
// Params 0, eflags: 0x6
// Checksum 0x1da33f5a, Offset: 0x118
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_tactical_raft", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_tactical_raft/player_tactical_raft
// Params 0, eflags: 0x5 linked
// Checksum 0x965bcf27, Offset: 0x168
// Size: 0x54
function private function_70a657d8() {
    vehicle::add_main_callback("tactical_raft_wz", &function_9941dc42);
    setdvar(#"phys_buoyancy", 1);
}

// Namespace player_tactical_raft/player_tactical_raft
// Params 0, eflags: 0x5 linked
// Checksum 0xbf733f92, Offset: 0x1c8
// Size: 0xbc
function private function_9941dc42() {
    self setmovingplatformenabled(1, 0);
    self.var_93dc9da9 = "veh_zodiac_wall_imp";
    callback::function_d8abfc3d(#"hash_80ab24b716412e1", &function_a41bd019);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_a5838bb7);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_6d4de854);
}

// Namespace player_tactical_raft/player_tactical_raft
// Params 1, eflags: 0x5 linked
// Checksum 0x735e7771, Offset: 0x290
// Size: 0x74
function private function_c0c61ba1(player) {
    if (isalive(self)) {
        self showpart("tag_motor_steer_animate", "", 1);
    }
    player detach("veh_t8_mil_boat_tactical_raft_outboard_motor_attach", "TAG_WEAPON_LEFT");
}

// Namespace player_tactical_raft/player_tactical_raft
// Params 1, eflags: 0x5 linked
// Checksum 0x1395392b, Offset: 0x310
// Size: 0x74
function private function_e81bb047(player) {
    player attach("veh_t8_mil_boat_tactical_raft_outboard_motor_attach", "TAG_WEAPON_LEFT");
    if (isalive(self)) {
        self hidepart("tag_motor_steer_animate", "", 1);
    }
}

// Namespace player_tactical_raft/player_tactical_raft
// Params 1, eflags: 0x5 linked
// Checksum 0x2d720836, Offset: 0x390
// Size: 0x2c
function private function_6d4de854(params) {
    self function_c0c61ba1(params.player);
}

// Namespace player_tactical_raft/player_tactical_raft
// Params 1, eflags: 0x5 linked
// Checksum 0xdb6cb515, Offset: 0x3c8
// Size: 0x44
function private function_a5838bb7(params) {
    self function_e81bb047(params.player);
    self thread player_vehicle::function_e8e41bbb();
}

// Namespace player_tactical_raft/player_tactical_raft
// Params 1, eflags: 0x5 linked
// Checksum 0xdd570245, Offset: 0x418
// Size: 0x4c
function private function_a41bd019(params) {
    self function_c0c61ba1(params.player);
    self function_e81bb047(params.player);
}

