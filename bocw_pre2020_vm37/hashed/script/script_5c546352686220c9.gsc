#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_2b492b5d;

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 0, eflags: 0x6
// Checksum 0x275824cc, Offset: 0xc8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_53bffc80a49d74a7", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 0, eflags: 0x5 linked
// Checksum 0x624b403d, Offset: 0x118
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("player_muscle", &function_610f61d4);
}

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 0, eflags: 0x5 linked
// Checksum 0x8c48a5b6, Offset: 0x150
// Size: 0xaa
function private function_610f61d4() {
    self setmovingplatformenabled(1, 0);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_b0a62896);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_d949f006);
    self.var_84fed14b = 40;
    self.var_d6691161 = 175;
    self.var_5d662124 = 2;
}

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 1, eflags: 0x5 linked
// Checksum 0x844bcb4, Offset: 0x208
// Size: 0x24
function private function_b0a62896(params) {
    self function_da0c353b(params);
}

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 1, eflags: 0x5 linked
// Checksum 0xaacdb853, Offset: 0x238
// Size: 0x24
function private function_d949f006(params) {
    self function_da0c353b(params);
}

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 1, eflags: 0x5 linked
// Checksum 0xd6f306a7, Offset: 0x268
// Size: 0x152
function private function_da0c353b(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
    if (!isalive(self)) {
        return;
    }
    if (eventstruct.seat_index === 0) {
        if (isdefined(getgametypesetting(#"hash_7695bdd7b20cdda")) ? getgametypesetting(#"hash_7695bdd7b20cdda") : 0) {
            if (is_true(self.var_8d120ff)) {
                return;
            }
            characterassetname = getcharacterassetname(player getcharacterbodytype(), currentsessionmode());
            if (characterassetname !== #"hash_15db91b18278dea9") {
                return;
            }
            self thread function_782a6e87();
            self.var_8d120ff = 1;
        }
    }
}

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 0, eflags: 0x5 linked
// Checksum 0x4e4ac1e5, Offset: 0x3c8
// Size: 0xc4
function private function_782a6e87() {
    self endon(#"death");
    oldhealth = self.health;
    self setvehicletype("veh_muscle_car_convertible_player_wz_replacer");
    util::wait_network_frame();
    self function_41b29ff0(#"hash_896eebec81ec647");
    util::wait_network_frame();
    damage = self.healthdefault - oldhealth;
    if (damage > 0) {
        self dodamage(damage, self.origin);
    }
}

