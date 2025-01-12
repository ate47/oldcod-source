#using script_47d08d7129406c5a;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_heavy_helicopter;

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 0, eflags: 0x6
// Checksum 0x123ca246, Offset: 0xd0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_heavy_helicopter", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 0, eflags: 0x5 linked
// Checksum 0x44eb66a8, Offset: 0x120
// Size: 0xec
function private function_70a657d8() {
    clientfield::register("toplayer", "hind_gunner_postfx_active", 1, 1, "int");
    vehicle::add_main_callback("helicopter_heavy", &function_8220feb0);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_8f37f11);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &change_seat);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_1ec626d7);
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 0, eflags: 0x5 linked
// Checksum 0xebf8072a, Offset: 0x218
// Size: 0x14
function private function_8220feb0() {
    namespace_c8fb02a7::function_a01726dd();
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 1, eflags: 0x1 linked
// Checksum 0xfc3666a3, Offset: 0x238
// Size: 0xa4
function function_8f37f11(params) {
    self endon(#"death");
    if (isalive(self)) {
        if (isdefined(params.player)) {
            enter_seat = params.eventstruct.seat_index;
            if (namespace_c8fb02a7::function_9ffa5fd(undefined, enter_seat)) {
                self function_6ffe1aa7(params.player, undefined, enter_seat);
            }
        }
    }
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 1, eflags: 0x1 linked
// Checksum 0x85be2407, Offset: 0x2e8
// Size: 0x2c
function function_1ec626d7(params) {
    params.player clientfield::set_to_player("hind_gunner_postfx_active", 0);
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 1, eflags: 0x1 linked
// Checksum 0xe76affa8, Offset: 0x320
// Size: 0xbc
function change_seat(params) {
    self endon(#"death");
    if (isalive(self)) {
        if (isdefined(params.player)) {
            enter_seat = params.eventstruct.seat_index;
            exit_seat = params.eventstruct.old_seat_index;
            if (namespace_c8fb02a7::function_9ffa5fd(exit_seat, enter_seat)) {
                self function_6ffe1aa7(params.player, exit_seat, enter_seat);
            }
        }
    }
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 3, eflags: 0x1 linked
// Checksum 0x7c6aee5d, Offset: 0x3e8
// Size: 0xc4
function function_6ffe1aa7(player, var_92eb9b7d, var_6d872cea) {
    if (!(var_92eb9b7d === 1 || var_6d872cea === 1)) {
        return;
    }
    tweentime = self function_ff1bf59c(var_92eb9b7d, var_6d872cea);
    wait tweentime;
    if (var_6d872cea === 1) {
        player clientfield::set_to_player("hind_gunner_postfx_active", 1);
        return;
    }
    if (var_92eb9b7d === 1) {
        player clientfield::set_to_player("hind_gunner_postfx_active", 0);
    }
}

