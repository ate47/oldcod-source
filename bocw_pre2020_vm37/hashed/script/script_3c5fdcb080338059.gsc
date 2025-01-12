#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace namespace_ea9baedf;

// Namespace namespace_ea9baedf/namespace_ea9baedf
// Params 0, eflags: 0x6
// Checksum 0xe450d29d, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_c25f006b5e1726d", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_ea9baedf/namespace_ea9baedf
// Params 0, eflags: 0x4
// Checksum 0x34080f5c, Offset: 0xd8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_7735a2dc4298e55c", &on_begin, &on_end);
}

// Namespace namespace_ea9baedf/namespace_ea9baedf
// Params 1, eflags: 0x4
// Checksum 0xbd6a7992, Offset: 0x140
// Size: 0x184
function private on_begin(kill_count) {
    self.kill_count = zm_trial::function_5769f26a(kill_count);
    foreach (player in getplayers()) {
        player.var_c957540c = 0;
    }
    zm_spawner::register_zombie_death_event_callback(&function_138aec8e);
    zm_trial_util::function_c2cd0cba(self.kill_count);
    foreach (player in getplayers()) {
        player thread function_7f62f098(self);
    }
    level thread function_69c5df45(self);
}

// Namespace namespace_ea9baedf/namespace_ea9baedf
// Params 1, eflags: 0x4
// Checksum 0xe5c39d90, Offset: 0x2d0
// Size: 0x254
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player zm_trial_util::function_f3aacffb();
    }
    if (!round_reset) {
        var_57807cdc = [];
        foreach (player in getplayers()) {
            if (player.var_c957540c < self.kill_count) {
                array::add(var_57807cdc, player, 0);
            }
        }
        if (var_57807cdc.size == 1) {
            zm_trial::fail(#"hash_788ffc8d7448f05", var_57807cdc);
        } else if (var_57807cdc.size > 1) {
            zm_trial::fail(#"hash_2bf9eb58ed3ac518", var_57807cdc);
        }
    }
    foreach (player in getplayers()) {
        player.var_c957540c = undefined;
    }
    zm_spawner::deregister_zombie_death_event_callback(&function_138aec8e);
}

// Namespace namespace_ea9baedf/namespace_ea9baedf
// Params 1, eflags: 0x4
// Checksum 0x8a0001c7, Offset: 0x530
// Size: 0x9e
function private function_7f62f098(challenge) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    while (true) {
        var_96936cca = self.var_c957540c;
        if (var_96936cca < 0) {
            var_96936cca = 0;
        } else if (var_96936cca > challenge.kill_count) {
            var_96936cca = challenge.kill_count;
        }
        self zm_trial_util::function_2190356a(var_96936cca);
        waitframe(1);
    }
}

// Namespace namespace_ea9baedf/namespace_ea9baedf
// Params 1, eflags: 0x4
// Checksum 0x3296fa70, Offset: 0x5d8
// Size: 0x184
function private function_69c5df45(challenge) {
    level endon(#"hash_7646638df88a3656");
    while (true) {
        assert(isdefined(challenge));
        end_round = 1;
        foreach (player in getplayers()) {
            if (player.var_c957540c < challenge.kill_count) {
                end_round = 0;
            }
        }
        if (end_round) {
            enemies = getaiteamarray(level.zombie_team);
            if (isdefined(enemies)) {
                for (i = 0; i < enemies.size; i++) {
                    enemies[i] dodamage(enemies[i].health + 666, enemies[i].origin);
                }
            }
            level.zombie_total = 0;
            return;
        }
        waitframe(1);
    }
}

// Namespace namespace_ea9baedf/namespace_ea9baedf
// Params 1, eflags: 0x4
// Checksum 0xac394f35, Offset: 0x768
// Size: 0xd0
function private function_138aec8e(attacker) {
    if (is_true(self.nuked)) {
        foreach (player in getplayers()) {
            player.var_c957540c++;
        }
        return;
    }
    if (isplayer(attacker)) {
        attacker.var_c957540c++;
    }
}

