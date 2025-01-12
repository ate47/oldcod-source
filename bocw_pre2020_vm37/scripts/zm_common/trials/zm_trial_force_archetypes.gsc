#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_force_archetypes;

// Namespace zm_trial_force_archetypes/zm_trial_force_archetypes
// Params 0, eflags: 0x6
// Checksum 0x4906dca0, Offset: 0x78
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_force_archetypes", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_force_archetypes/zm_trial_force_archetypes
// Params 0, eflags: 0x4
// Checksum 0x1c7ff3be, Offset: 0xc0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"force_archetypes", &on_begin, &on_end);
}

// Namespace zm_trial_force_archetypes/zm_trial_force_archetypes
// Params 4, eflags: 0x4
// Checksum 0x76f47b97, Offset: 0x128
// Size: 0x104
function private on_begin(var_34259a50, var_1d00ec07, var_10cad39b, var_f9ab255c) {
    archetypes = [var_34259a50, var_1d00ec07, var_10cad39b, var_f9ab255c];
    arrayremovevalue(archetypes, undefined, 0);
    self.var_c54c0d81 = [];
    foreach (archetype in archetypes) {
        self.var_c54c0d81[archetype] = 1;
    }
}

// Namespace zm_trial_force_archetypes/zm_trial_force_archetypes
// Params 1, eflags: 0x4
// Checksum 0xe23d58d, Offset: 0x238
// Size: 0x16
function private on_end(*round_reset) {
    self.var_c54c0d81 = undefined;
}

// Namespace zm_trial_force_archetypes/zm_trial_force_archetypes
// Params 1, eflags: 0x0
// Checksum 0x9ac98e0f, Offset: 0x258
// Size: 0x52
function function_ff2a74e7(archetype) {
    challenge = zm_trial::function_a36e8c38(#"force_archetypes");
    if (!isdefined(challenge)) {
        return false;
    }
    return isdefined(challenge.var_c54c0d81[archetype]);
}

