#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace namespace_81b8fd9;

// Namespace namespace_81b8fd9/namespace_81b8fd9
// Params 0, eflags: 0x2
// Checksum 0x81a06a87, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_5ca501b5a8e0f7f9", &__init__, undefined, undefined);
}

// Namespace namespace_81b8fd9/namespace_81b8fd9
// Params 0, eflags: 0x0
// Checksum 0x64d6f89e, Offset: 0xd8
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_2f8add191c45a722", &on_begin, &on_end);
}

// Namespace namespace_81b8fd9/namespace_81b8fd9
// Params 1, eflags: 0x4
// Checksum 0x6af72425, Offset: 0x140
// Size: 0x7c
function private on_begin(kill_count) {
    self.var_7ed24e24 = zm_trial::function_9b72fb1a(kill_count);
    self.var_58db52ff = 0;
    zm_trial_util::function_368f31a9(self.var_7ed24e24);
    zm_trial_util::function_ef967e48(self.var_58db52ff);
    level thread function_bb0fa718(self);
}

// Namespace namespace_81b8fd9/namespace_81b8fd9
// Params 1, eflags: 0x4
// Checksum 0xac13d63c, Offset: 0x1c8
// Size: 0x54
function private on_end(round_reset) {
    zm_trial_util::function_59861180();
    if (!round_reset) {
        if (self.var_58db52ff < self.var_7ed24e24) {
            zm_trial::fail(#"hash_729e15cd6b31df3");
        }
    }
}

// Namespace namespace_81b8fd9/namespace_81b8fd9
// Params 1, eflags: 0x4
// Checksum 0xe7dd7d47, Offset: 0x228
// Size: 0x80
function private function_bb0fa718(challenge) {
    level endon(#"hash_7646638df88a3656");
    while (challenge.var_58db52ff < challenge.var_7ed24e24) {
        level waittill(#"trap_kill");
        challenge.var_58db52ff++;
        zm_trial_util::function_ef967e48(challenge.var_58db52ff);
    }
}

// Namespace namespace_81b8fd9/namespace_81b8fd9
// Params 1, eflags: 0x4
// Checksum 0x4f8c23f8, Offset: 0x2b0
// Size: 0x126
function private function_35bc6718(challenge) {
    level endon(#"hash_7646638df88a3656");
    while (true) {
        assert(isdefined(challenge));
        end_round = 1;
        if (challenge.var_58db52ff < challenge.var_7ed24e24) {
            end_round = 0;
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

