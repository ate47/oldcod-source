#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_force_archetypes;

// Namespace zm_trial_force_archetypes/zm_trial_force_archetypes
// Params 0, eflags: 0x2
// Checksum 0x66004ec3, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_force_archetypes", &__init__, undefined, undefined);
}

// Namespace zm_trial_force_archetypes/zm_trial_force_archetypes
// Params 0, eflags: 0x0
// Checksum 0xdbf68514, Offset: 0xc8
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"force_archetypes", &on_begin, &on_end);
}

// Namespace zm_trial_force_archetypes/zm_trial_force_archetypes
// Params 4, eflags: 0x4
// Checksum 0xc81c875e, Offset: 0x130
// Size: 0xe6
function private on_begin(var_60341bc3, var_ee2cac88, var_142f26f1, var_d23b8afe) {
    archetypes = array::remove_undefined(array(var_60341bc3, var_ee2cac88, var_142f26f1, var_d23b8afe), 0);
    self.var_c1e8f4c1 = [];
    foreach (archetype in archetypes) {
        self.var_c1e8f4c1[archetype] = 1;
    }
}

// Namespace zm_trial_force_archetypes/zm_trial_force_archetypes
// Params 1, eflags: 0x4
// Checksum 0xe08348e2, Offset: 0x220
// Size: 0x16
function private on_end(round_reset) {
    self.var_c1e8f4c1 = undefined;
}

// Namespace zm_trial_force_archetypes/zm_trial_force_archetypes
// Params 1, eflags: 0x0
// Checksum 0x140443f3, Offset: 0x240
// Size: 0x56
function function_64eeba9b(archetype) {
    challenge = zm_trial::function_871c1f7f(#"force_archetypes");
    if (!isdefined(challenge)) {
        return false;
    }
    return isdefined(challenge.var_c1e8f4c1[archetype]);
}

