#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace namespace_5f05fc73;

// Namespace namespace_5f05fc73/namespace_5f05fc73
// Params 0, eflags: 0x2
// Checksum 0xbb8876c9, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_62ed3e0f56513ba7", &__init__, undefined, undefined);
}

// Namespace namespace_5f05fc73/namespace_5f05fc73
// Params 0, eflags: 0x0
// Checksum 0xa1c61406, Offset: 0xf0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_2c07cbb8e8fd2060", &on_begin, &on_end);
}

// Namespace namespace_5f05fc73/namespace_5f05fc73
// Params 1, eflags: 0x4
// Checksum 0x54779afb, Offset: 0x158
// Size: 0x9c
function private on_begin(var_e46c0a20) {
    fasttravel_triggers = struct::get_array("fasttravel_trigger", "targetname");
    assert(isdefined(fasttravel_triggers));
    zm_trial_util::function_368f31a9(fasttravel_triggers.size);
    zm_trial_util::function_ef967e48(0);
    level thread function_a0f1b473();
}

// Namespace namespace_5f05fc73/namespace_5f05fc73
// Params 1, eflags: 0x4
// Checksum 0xfe57b54e, Offset: 0x200
// Size: 0xa4
function private on_end(round_reset) {
    zm_trial_util::function_59861180();
    if (!round_reset) {
        fasttravel_triggers = struct::get_array("fasttravel_trigger", "targetname");
        assert(isdefined(fasttravel_triggers));
        if (function_bc6e6ba6() < fasttravel_triggers.size) {
            zm_trial::fail(#"hash_6d65e724625758f1");
        }
    }
}

// Namespace namespace_5f05fc73/namespace_5f05fc73
// Params 0, eflags: 0x4
// Checksum 0xdf91630e, Offset: 0x2b0
// Size: 0xf2
function private function_bc6e6ba6() {
    fasttravel_triggers = struct::get_array("fasttravel_trigger", "targetname");
    assert(isdefined(fasttravel_triggers));
    count = 0;
    foreach (trigger in fasttravel_triggers) {
        if (isdefined(trigger.unitrigger_stub.used) && trigger.unitrigger_stub.used) {
            count++;
        }
    }
    return count;
}

// Namespace namespace_5f05fc73/namespace_5f05fc73
// Params 0, eflags: 0x4
// Checksum 0xd17d9e55, Offset: 0x3b0
// Size: 0x5e
function private function_a0f1b473() {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    while (true) {
        zm_trial_util::function_ef967e48(function_bc6e6ba6());
        waitframe(1);
    }
}

