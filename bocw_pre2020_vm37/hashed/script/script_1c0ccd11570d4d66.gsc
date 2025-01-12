#using script_40fc784c60f9fa7b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_fav;

// Namespace player_fav/player_fav
// Params 0, eflags: 0x6
// Checksum 0xd37d5693, Offset: 0x98
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_fav", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_fav/player_fav
// Params 0, eflags: 0x5 linked
// Checksum 0x5bfb139, Offset: 0xe8
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("player_fav", &function_bd3b5229);
}

// Namespace player_fav/player_fav
// Params 0, eflags: 0x5 linked
// Checksum 0x3e06255f, Offset: 0x120
// Size: 0x13c
function private function_bd3b5229() {
    self setmovingplatformenabled(1, 0);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_1d4618ca);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_c4c18caf);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_79f2b4cf);
    self.var_96c0f900 = [];
    self.var_96c0f900[1] = 1000;
    self.var_4ca92b57 = 30;
    self.var_57371c71 = 60;
    self.var_84fed14b = 40;
    self.var_d6691161 = 175;
    self.var_5d662124 = 2;
    self thread player_vehicle::function_5bce3f3a(1, 1000);
}

// Namespace player_fav/player_fav
// Params 1, eflags: 0x1 linked
// Checksum 0xcb6b3933, Offset: 0x268
// Size: 0x40
function function_1d4618ca(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
}

// Namespace player_fav/player_fav
// Params 1, eflags: 0x1 linked
// Checksum 0xd982d085, Offset: 0x2b0
// Size: 0xc
function function_c4c18caf(*params) {
    
}

// Namespace player_fav/player_fav
// Params 1, eflags: 0x1 linked
// Checksum 0x62b19313, Offset: 0x2c8
// Size: 0x40
function function_79f2b4cf(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
}

