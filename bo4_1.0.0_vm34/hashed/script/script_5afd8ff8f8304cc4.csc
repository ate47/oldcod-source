#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace namespace_3e2923d4;

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 0, eflags: 0x2
// Checksum 0x4e8048b1, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_7ceb08aa364e4596", &__init__, undefined, undefined);
}

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 0, eflags: 0x0
// Checksum 0xc9bd49c6, Offset: 0xc0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_250115340b2e27a5", &on_begin, &on_end);
}

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 2, eflags: 0x4
// Checksum 0x89f400ae, Offset: 0x128
// Size: 0x2e
function private on_begin(local_client_num, params) {
    level.var_b33aa896 = &function_1b6b4701;
}

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 1, eflags: 0x4
// Checksum 0x959cb5dc, Offset: 0x160
// Size: 0x16
function private on_end(local_client_num) {
    level.var_b33aa896 = undefined;
}

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 0, eflags: 0x0
// Checksum 0xf2deb4e7, Offset: 0x180
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_871c1f7f(#"hash_250115340b2e27a5");
    return isdefined(challenge);
}

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 3, eflags: 0x4
// Checksum 0xf95288b, Offset: 0x1c0
// Size: 0x44
function private function_1b6b4701(local_client_num, player, damage) {
    if (int(damage) <= 1) {
        return true;
    }
    return false;
}

