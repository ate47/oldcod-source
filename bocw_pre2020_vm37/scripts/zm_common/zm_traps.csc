#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace zm_traps;

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x6
// Checksum 0xaea80323, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_traps", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x5 linked
// Checksum 0xd32eca22, Offset: 0xe0
// Size: 0xe4
function private function_70a657d8() {
    s_traps_array = struct::get_array("zm_traps", "targetname");
    a_registered_traps = [];
    foreach (trap in s_traps_array) {
        if (isdefined(trap.script_noteworthy)) {
            if (!trap is_trap_registered(a_registered_traps)) {
                a_registered_traps[trap.script_noteworthy] = 1;
            }
        }
    }
}

// Namespace zm_traps/zm_traps
// Params 1, eflags: 0x1 linked
// Checksum 0xee729ebe, Offset: 0x1d0
// Size: 0x18
function is_trap_registered(a_registered_traps) {
    return isdefined(a_registered_traps[self.script_noteworthy]);
}

