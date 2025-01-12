#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_use_magicbox;

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 0, eflags: 0x6
// Checksum 0x5013473c, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_use_magicbox", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 0, eflags: 0x4
// Checksum 0x78be917b, Offset: 0xd0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"use_magicbox", &on_begin, &on_end);
}

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 1, eflags: 0x4
// Checksum 0xaf116f9c, Offset: 0x138
// Size: 0x118
function private on_begin(var_519131bc = 1) {
    callback::function_b3c9adb7(&function_b3c9adb7);
    if (ishash(var_519131bc)) {
        level.var_519131bc = zm_trial::function_5769f26a(var_519131bc);
    } else {
        level.var_519131bc = var_519131bc;
    }
    foreach (player in getplayers()) {
        player thread function_1685cc9b();
    }
}

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 1, eflags: 0x4
// Checksum 0x3402dde2, Offset: 0x258
// Size: 0x1ec
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player zm_trial_util::function_f3aacffb();
    }
    if (!round_reset) {
        var_57807cdc = [];
        foreach (player in getplayers()) {
            if (player.var_8f30dd57 < level.var_519131bc) {
                array::add(var_57807cdc, player, 0);
            }
            player.var_8f30dd57 = undefined;
        }
        if (var_57807cdc.size == 1) {
            zm_trial::fail(#"hash_9c83a93f783b8e4", var_57807cdc);
        } else if (var_57807cdc.size > 1) {
            zm_trial::fail(#"hash_484dffbaa43c048d", var_57807cdc);
        }
    }
    level.var_519131bc = undefined;
    callback::function_342b2f6(&function_b3c9adb7);
}

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 0, eflags: 0x4
// Checksum 0x30dec5e1, Offset: 0x450
// Size: 0x110
function private function_1685cc9b() {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    var_fa5d7ea0 = 0;
    self.var_8f30dd57 = 0;
    var_6bec3070 = 0;
    self zm_trial_util::function_2190356a(self.var_8f30dd57);
    self zm_trial_util::function_c2cd0cba(level.var_519131bc);
    while (true) {
        self waittill(#"hash_b0cc77b1ab98c08");
        if (self.var_8f30dd57 == level.var_519131bc) {
            self zm_trial_util::function_63060af4(1);
            continue;
        }
        if (self.var_8f30dd57 < level.var_519131bc) {
            self zm_trial_util::function_2190356a(self.var_8f30dd57);
        }
    }
}

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 1, eflags: 0x4
// Checksum 0x3a720e13, Offset: 0x568
// Size: 0x3e
function private function_b3c9adb7(weapon) {
    self.var_8f30dd57++;
    self notify(#"hash_b0cc77b1ab98c08", {#weapon:weapon});
}

