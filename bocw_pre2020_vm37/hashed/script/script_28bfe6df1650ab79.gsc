#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace namespace_e01afe67;

// Namespace namespace_e01afe67/namespace_e01afe67
// Params 0, eflags: 0x6
// Checksum 0x2ad9f718, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_993ee8bedbddc19", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_e01afe67/namespace_e01afe67
// Params 0, eflags: 0x4
// Checksum 0x77f34c5, Offset: 0xd0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_27897abffa9137fc", &on_begin, &on_end);
}

// Namespace namespace_e01afe67/namespace_e01afe67
// Params 0, eflags: 0x4
// Checksum 0xf95aaa12, Offset: 0x138
// Size: 0x24
function private on_begin() {
    zm::register_actor_damage_callback(&height_check);
}

// Namespace namespace_e01afe67/namespace_e01afe67
// Params 1, eflags: 0x4
// Checksum 0xa422bd71, Offset: 0x168
// Size: 0x64
function private on_end(*round_reset) {
    if (isinarray(level.actor_damage_callbacks, &height_check)) {
        arrayremovevalue(level.actor_damage_callbacks, &height_check, 0);
    }
}

// Namespace namespace_e01afe67/namespace_e01afe67
// Params 0, eflags: 0x0
// Checksum 0xf41e0eb5, Offset: 0x1d8
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"hash_27897abffa9137fc");
    return isdefined(challenge);
}

// Namespace namespace_e01afe67/namespace_e01afe67
// Params 12, eflags: 0x4
// Checksum 0x27d96aae, Offset: 0x218
// Size: 0xb8
function private height_check(*inflictor, attacker, damage, *flags, *meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (isdefined(boneindex.origin) && isdefined(self.origin) && boneindex.origin[2] > self.origin[2] + 40) {
        return surfacetype;
    }
    return 0;
}

