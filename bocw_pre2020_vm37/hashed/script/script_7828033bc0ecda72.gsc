#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace namespace_7499819f;

// Namespace namespace_7499819f/namespace_7499819f
// Params 0, eflags: 0x6
// Checksum 0x89d71e59, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_3887e77731340f48", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_7499819f/namespace_7499819f
// Params 0, eflags: 0x4
// Checksum 0x872aa784, Offset: 0xc8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_b143bd998abdd27", &on_begin, &on_end);
}

// Namespace namespace_7499819f/namespace_7499819f
// Params 0, eflags: 0x4
// Checksum 0x6895207e, Offset: 0x130
// Size: 0x98
function private on_begin() {
    foreach (player in getplayers()) {
        player callback::on_laststand(&on_player_laststand);
    }
}

// Namespace namespace_7499819f/namespace_7499819f
// Params 1, eflags: 0x4
// Checksum 0xa826153c, Offset: 0x1d0
// Size: 0xa0
function private on_end(*round_reset) {
    foreach (player in getplayers()) {
        player callback::remove_on_laststand(&on_player_laststand);
    }
}

// Namespace namespace_7499819f/namespace_7499819f
// Params 0, eflags: 0x4
// Checksum 0x1d9a7b60, Offset: 0x278
// Size: 0x4c
function private on_player_laststand() {
    var_57807cdc = [];
    array::add(var_57807cdc, self, 0);
    zm_trial::fail(#"hash_272fae998263208b", var_57807cdc);
}

