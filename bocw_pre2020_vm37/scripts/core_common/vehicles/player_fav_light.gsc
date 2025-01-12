#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_fav_light;

// Namespace player_fav_light/player_fav_light
// Params 0, eflags: 0x6
// Checksum 0x29b83cf8, Offset: 0xa0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_fav_light", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_fav_light/player_fav_light
// Params 0, eflags: 0x5 linked
// Checksum 0x9934779a, Offset: 0xf0
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("player_fav_light", &function_6e6e0d52);
}

// Namespace player_fav_light/player_fav_light
// Params 0, eflags: 0x5 linked
// Checksum 0xaa4d5f57, Offset: 0x128
// Size: 0xcc
function private function_6e6e0d52() {
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_1d4618ca);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_79f2b4cf);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_c4c18caf);
    self.var_d6691161 = 200;
    self.var_5002d77c = 0.6;
    self vehicle::toggle_control_bone_group(2, 1);
}

// Namespace player_fav_light/player_fav_light
// Params 1, eflags: 0x1 linked
// Checksum 0x466f6ed0, Offset: 0x200
// Size: 0x9c
function function_1d4618ca(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
    if (eventstruct.seat_index == 0) {
        self vehicle::toggle_control_bone_group(1, 1);
        return;
    }
    if (eventstruct.seat_index == 1) {
        self vehicle::toggle_control_bone_group(2, 0);
    }
}

// Namespace player_fav_light/player_fav_light
// Params 1, eflags: 0x1 linked
// Checksum 0x414a61cc, Offset: 0x2a8
// Size: 0x9c
function function_79f2b4cf(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
    if (eventstruct.seat_index == 1) {
        self vehicle::toggle_control_bone_group(2, 0);
        return;
    }
    if (eventstruct.seat_index == 0) {
        self vehicle::toggle_control_bone_group(2, 1);
    }
}

// Namespace player_fav_light/player_fav_light
// Params 1, eflags: 0x1 linked
// Checksum 0x4fe8e3bc, Offset: 0x350
// Size: 0xe4
function function_c4c18caf(params) {
    player = params.player;
    if (!isdefined(player)) {
        return;
    }
    if (!isalive(self)) {
        return;
    }
    eventstruct = params.eventstruct;
    if (eventstruct.seat_index == 1) {
        self vehicle::toggle_control_bone_group(2, 1);
    }
    occupants = self getvehoccupants();
    if (!isdefined(occupants) || occupants.size == 0) {
        self vehicle::toggle_control_bone_group(1, 0);
    }
}

