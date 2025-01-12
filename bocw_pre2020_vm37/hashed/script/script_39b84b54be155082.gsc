#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_snowmobile;

// Namespace player_snowmobile/player_snowmobile
// Params 0, eflags: 0x6
// Checksum 0xb04b8b37, Offset: 0x110
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_snowmobile", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_snowmobile/player_snowmobile
// Params 0, eflags: 0x5 linked
// Checksum 0x33c8ffb4, Offset: 0x160
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("player_snowmobile", &function_13ea784);
}

// Namespace player_snowmobile/player_snowmobile
// Params 0, eflags: 0x5 linked
// Checksum 0x145efd89, Offset: 0x198
// Size: 0x92
function private function_13ea784() {
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_4099f945);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_dfba6306);
    self.var_93dc9da9 = "veh_atv_wall_imp";
    self.var_d6691161 = 200;
    self.var_5002d77c = 0.6;
}

// Namespace player_snowmobile/player_snowmobile
// Params 1, eflags: 0x5 linked
// Checksum 0x198275dc, Offset: 0x238
// Size: 0x268
function private function_f176e7d2(player) {
    player endon(#"death");
    self endon(#"death");
    player endon(#"exit_vehicle");
    self notify("1602d8377de55621");
    self endon("1602d8377de55621");
    while (true) {
        seatindex = self getoccupantseat(player);
        if (seatindex != 0 && seatindex != 6) {
            return;
        }
        speed = abs(self getspeedmph());
        if (speed >= 10) {
            var_9687e67e = array("front_right", "front_left", "back_right", "back_left");
            var_79ca7c96 = array("snow", "ice", "water", "none");
            var_118c8c16 = 0;
            foreach (wheel in var_9687e67e) {
                var_b0029690 = self getwheelsurface(wheel);
                if (!isinarray(var_79ca7c96, var_b0029690)) {
                    var_118c8c16++;
                }
            }
            if (var_118c8c16 > 0) {
                self dodamage(1 * var_118c8c16, self.origin);
            }
        }
        wait 1;
    }
}

// Namespace player_snowmobile/player_snowmobile
// Params 1, eflags: 0x5 linked
// Checksum 0xbf4341da, Offset: 0x4a8
// Size: 0x6c
function private function_4099f945(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
    if (eventstruct.seat_index === 0) {
        self thread function_f176e7d2(player);
    }
}

// Namespace player_snowmobile/player_snowmobile
// Params 1, eflags: 0x1 linked
// Checksum 0xa9126a3, Offset: 0x520
// Size: 0x6c
function function_dfba6306(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
    if (eventstruct.seat_index === 0) {
        self thread function_f176e7d2(player);
    }
}

