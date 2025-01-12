#using script_40fc784c60f9fa7b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_btr40;

// Namespace player_btr40/player_btr40
// Params 0, eflags: 0x6
// Checksum 0x4232c8ac, Offset: 0x98
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_btr40", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_btr40/player_btr40
// Params 0, eflags: 0x5 linked
// Checksum 0xb1b307f5, Offset: 0xe8
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("player_btr40", &function_a5a8e361);
}

// Namespace player_btr40/player_btr40
// Params 0, eflags: 0x5 linked
// Checksum 0xa8583ccb, Offset: 0x120
// Size: 0x194
function private function_a5a8e361() {
    self setmovingplatformenabled(1, 0);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_658070e);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_b3042635);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_32ff31aa);
    self.var_96c0f900 = [];
    self.var_96c0f900[1] = 1000;
    self.var_4ca92b57 = 30;
    self.var_57371c71 = 60;
    self.var_84fed14b = 40;
    self.var_d6691161 = 175;
    self.var_5d662124 = 2;
    self vehicle::toggle_control_bone_group(1, 1);
    self vehicle::toggle_control_bone_group(2, 1);
    self vehicle::toggle_control_bone_group(3, 1);
    self thread player_vehicle::function_5bce3f3a(1, 1000);
}

// Namespace player_btr40/player_btr40
// Params 1, eflags: 0x1 linked
// Checksum 0x6f9fb143, Offset: 0x2c0
// Size: 0x94
function function_658070e(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
    if (eventstruct.seat_index >= 1 && eventstruct.seat_index <= 4) {
        self vehicle::toggle_control_bone_group(eventstruct.seat_index - 1 + 1, 0);
    }
}

// Namespace player_btr40/player_btr40
// Params 1, eflags: 0x1 linked
// Checksum 0x941385da, Offset: 0x360
// Size: 0x7c
function function_b3042635(params) {
    eventstruct = params.eventstruct;
    if (eventstruct.seat_index >= 1 && eventstruct.seat_index <= 4) {
        self vehicle::toggle_control_bone_group(eventstruct.seat_index - 1 + 1, 1);
    }
}

// Namespace player_btr40/player_btr40
// Params 1, eflags: 0x1 linked
// Checksum 0xddf9ae78, Offset: 0x3e8
// Size: 0xec
function function_32ff31aa(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
    if (eventstruct.seat_index >= 1 && eventstruct.seat_index <= 4) {
        self vehicle::toggle_control_bone_group(eventstruct.seat_index - 1 + 1, 0);
    }
    if (eventstruct.old_seat_index >= 1 && eventstruct.old_seat_index <= 4) {
        self vehicle::toggle_control_bone_group(eventstruct.old_seat_index - 1 + 1, 1);
    }
}

