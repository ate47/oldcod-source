#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_atv;

// Namespace player_atv/player_atv
// Params 0, eflags: 0x6
// Checksum 0x6028410a, Offset: 0x98
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_atv", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_atv/player_atv
// Params 0, eflags: 0x5 linked
// Checksum 0x6bebd931, Offset: 0xe8
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("player_atv", &function_500291c4);
}

// Namespace player_atv/player_atv
// Params 0, eflags: 0x5 linked
// Checksum 0x49fc3ee6, Offset: 0x120
// Size: 0x32
function private function_500291c4() {
    self.var_93dc9da9 = "veh_atv_wall_imp";
    self.var_d6691161 = 200;
    self.var_5002d77c = 0.6;
}

