#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace namespace_eec4e09a;

// Namespace namespace_eec4e09a/namespace_eec4e09a
// Params 0, eflags: 0x2
// Checksum 0xc8ef875c, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_3887e77731340f48", &__init__, undefined, undefined);
}

// Namespace namespace_eec4e09a/namespace_eec4e09a
// Params 0, eflags: 0x0
// Checksum 0x76145278, Offset: 0xd0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_b143bd998abdd27", &on_begin, &on_end);
}

// Namespace namespace_eec4e09a/namespace_eec4e09a
// Params 0, eflags: 0x4
// Checksum 0x350113ca, Offset: 0x138
// Size: 0x90
function private on_begin() {
    foreach (player in getplayers()) {
        player callback::on_laststand(&on_player_laststand);
    }
}

// Namespace namespace_eec4e09a/namespace_eec4e09a
// Params 1, eflags: 0x4
// Checksum 0xf0f189e9, Offset: 0x1d0
// Size: 0x98
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player callback::remove_on_laststand(&on_player_laststand);
    }
}

// Namespace namespace_eec4e09a/namespace_eec4e09a
// Params 0, eflags: 0x4
// Checksum 0xa3847118, Offset: 0x270
// Size: 0x4c
function private on_player_laststand() {
    var_9fb91af5 = [];
    array::add(var_9fb91af5, self, 0);
    zm_trial::fail(#"hash_272fae998263208b", var_9fb91af5);
}

