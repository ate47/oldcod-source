#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_sedan;

// Namespace player_sedan/player_sedan
// Params 0, eflags: 0x6
// Checksum 0x97b0e2bf, Offset: 0x90
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_sedan", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_sedan/player_sedan
// Params 0, eflags: 0x5 linked
// Checksum 0x7eb4431f, Offset: 0xe0
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("player_sedan", &function_3ca3e81e);
}

// Namespace player_sedan/player_sedan
// Params 0, eflags: 0x5 linked
// Checksum 0xeda83352, Offset: 0x118
// Size: 0x4a
function private function_3ca3e81e() {
    self setmovingplatformenabled(1, 0);
    self.var_84fed14b = 40;
    self.var_d6691161 = 175;
    self.var_5d662124 = 2;
}

