#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_door_lockdown;

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 0, eflags: 0x6
// Checksum 0x538bf884, Offset: 0x128
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_door_lockdown", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 0, eflags: 0x4
// Checksum 0x9e73cd5d, Offset: 0x170
// Size: 0x10c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    clientfield::register("scriptmover", "" + #"zm_trial_door_lockdown", 16000, 1, "int", &zm_trial_door_lockdown, 0, 0);
    level._effect[#"hash_351debe7af1f588b"] = "maps/zm_escape/fx8_flame_wall_64x64";
    level._effect[#"hash_257bf4ae70b5a852"] = "maps/zm_escape/fx8_flame_wall_128x128";
    level._effect[#"hash_3ea271ae7eb7fdce"] = "maps/zm_escape/fx8_flame_wall_256x256";
    zm_trial::register_challenge(#"door_lockdown", &on_begin, &on_end);
}

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 2, eflags: 0x4
// Checksum 0x9b638c09, Offset: 0x288
// Size: 0x14
function private on_begin(*localclientnum, *a_params) {
    
}

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 1, eflags: 0x4
// Checksum 0x3f61b338, Offset: 0x2a8
// Size: 0xc
function private on_end(*localclientnum) {
    
}

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 7, eflags: 0x4
// Checksum 0x654d867a, Offset: 0x2c0
// Size: 0x1b6
function private zm_trial_door_lockdown(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        v_forward = anglestoforward(self.angles);
        switch (self.model) {
        case #"collision_player_wall_64x64x10":
            var_b1e1a2db = level._effect[#"hash_351debe7af1f588b"];
            break;
        case #"collision_player_wall_128x128x10":
            var_b1e1a2db = level._effect[#"hash_257bf4ae70b5a852"];
            break;
        case #"collision_player_wall_256x256x10":
            var_b1e1a2db = level._effect[#"hash_3ea271ae7eb7fdce"];
            break;
        default:
            var_b1e1a2db = level._effect[#"hash_257bf4ae70b5a852"];
            break;
        }
        self.var_958e3374 = playfx(fieldname, var_b1e1a2db, self.origin - (0, 0, 48), v_forward);
        return;
    }
    if (isdefined(self.var_958e3374)) {
        stopfx(fieldname, self.var_958e3374);
        self.var_958e3374 = undefined;
    }
}

