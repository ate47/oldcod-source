#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace namespace_a476311c;

// Namespace namespace_a476311c/namespace_a476311c
// Params 0, eflags: 0x6
// Checksum 0xeafdbb49, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_7ceb08aa364e4596", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_a476311c/namespace_a476311c
// Params 0, eflags: 0x4
// Checksum 0x26c3f239, Offset: 0xb8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_250115340b2e27a5", &on_begin, &on_end);
}

// Namespace namespace_a476311c/namespace_a476311c
// Params 2, eflags: 0x4
// Checksum 0xcd7cb05d, Offset: 0x120
// Size: 0x2c
function private on_begin(*local_client_num, *params) {
    level.var_7db2b064 = &function_ecc5a0b9;
}

// Namespace namespace_a476311c/namespace_a476311c
// Params 1, eflags: 0x4
// Checksum 0xe8772b01, Offset: 0x158
// Size: 0x16
function private on_end(*local_client_num) {
    level.var_7db2b064 = undefined;
}

// Namespace namespace_a476311c/namespace_a476311c
// Params 0, eflags: 0x0
// Checksum 0x1691c95e, Offset: 0x178
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"hash_250115340b2e27a5");
    return isdefined(challenge);
}

// Namespace namespace_a476311c/namespace_a476311c
// Params 3, eflags: 0x4
// Checksum 0xe3b8fd48, Offset: 0x1b8
// Size: 0x44
function private function_ecc5a0b9(*local_client_num, *player, damage) {
    if (int(damage) <= 1) {
        return true;
    }
    return false;
}

