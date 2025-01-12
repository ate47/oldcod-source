#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace namespace_901adecc;

// Namespace namespace_901adecc/namespace_901adecc
// Params 0, eflags: 0x6
// Checksum 0x113d2c7a, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_5e733914ebbc17f7", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_901adecc/namespace_901adecc
// Params 0, eflags: 0x4
// Checksum 0x5bb2d2ca, Offset: 0xc8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_293a2fd65ffe0222", &on_begin, &on_end);
}

// Namespace namespace_901adecc/namespace_901adecc
// Params 0, eflags: 0x4
// Checksum 0xd0545183, Offset: 0x130
// Size: 0x98
function private on_begin() {
    foreach (player in getplayers()) {
        player callback::on_player_damage(&on_player_damage);
    }
}

// Namespace namespace_901adecc/namespace_901adecc
// Params 1, eflags: 0x4
// Checksum 0x123bc3fa, Offset: 0x1d0
// Size: 0xa0
function private on_end(*round_reset) {
    foreach (player in getplayers()) {
        player callback::remove_on_player_damage(&on_player_damage);
    }
}

// Namespace namespace_901adecc/namespace_901adecc
// Params 1, eflags: 0x4
// Checksum 0x5ddb606b, Offset: 0x278
// Size: 0xc4
function private on_player_damage(params) {
    if ((isai(params.eattacker) || isai(params.einflictor)) && (params.idamage > 0 || isdefined(self.armor) && self.armor > 0)) {
        var_57807cdc = [];
        array::add(var_57807cdc, self, 0);
        zm_trial::fail(#"hash_41122a695bc6065d", var_57807cdc);
    }
}

