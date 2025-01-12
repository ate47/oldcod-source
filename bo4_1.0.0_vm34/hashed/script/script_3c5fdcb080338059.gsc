#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace namespace_cb676f19;

// Namespace namespace_cb676f19/namespace_cb676f19
// Params 0, eflags: 0x2
// Checksum 0x61ef5183, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_c25f006b5e1726d", &__init__, undefined, undefined);
}

// Namespace namespace_cb676f19/namespace_cb676f19
// Params 0, eflags: 0x0
// Checksum 0xcc460879, Offset: 0xe0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_7735a2dc4298e55c", &on_begin, &on_end);
}

// Namespace namespace_cb676f19/namespace_cb676f19
// Params 1, eflags: 0x4
// Checksum 0x4f4e8930, Offset: 0x148
// Size: 0x174
function private on_begin(kill_count) {
    self.kill_count = zm_trial::function_9b72fb1a(kill_count);
    foreach (player in getplayers()) {
        player.var_bf9fb961 = 0;
    }
    zm_spawner::register_zombie_death_event_callback(&function_db6decae);
    zm_trial_util::function_530f0033(self.kill_count);
    foreach (player in getplayers()) {
        player thread function_e358c9ba(self);
    }
    level thread function_35bc6718(self);
}

// Namespace namespace_cb676f19/namespace_cb676f19
// Params 1, eflags: 0x4
// Checksum 0x7da9794c, Offset: 0x2c8
// Size: 0x22c
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player zm_trial_util::function_fccd8386();
    }
    if (!round_reset) {
        var_9fb91af5 = [];
        foreach (player in getplayers()) {
            if (player.var_bf9fb961 < self.kill_count) {
                array::add(var_9fb91af5, player, 0);
            }
        }
        if (var_9fb91af5.size == 1) {
            zm_trial::fail(#"hash_788ffc8d7448f05", var_9fb91af5);
        } else if (var_9fb91af5.size > 1) {
            zm_trial::fail(#"hash_2bf9eb58ed3ac518", var_9fb91af5);
        }
    }
    foreach (player in getplayers()) {
        player.var_bf9fb961 = undefined;
    }
    zm_spawner::deregister_zombie_death_event_callback(&function_db6decae);
}

// Namespace namespace_cb676f19/namespace_cb676f19
// Params 1, eflags: 0x4
// Checksum 0xb1b4fab, Offset: 0x500
// Size: 0xa6
function private function_e358c9ba(challenge) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    while (true) {
        var_15ebf219 = self.var_bf9fb961;
        if (var_15ebf219 < 0) {
            var_15ebf219 = 0;
        } else if (var_15ebf219 > challenge.kill_count) {
            var_15ebf219 = challenge.kill_count;
        }
        self zm_trial_util::function_fb5ea4e6(var_15ebf219);
        waitframe(1);
    }
}

// Namespace namespace_cb676f19/namespace_cb676f19
// Params 1, eflags: 0x4
// Checksum 0xd884e48b, Offset: 0x5b0
// Size: 0x18e
function private function_35bc6718(challenge) {
    level endon(#"hash_7646638df88a3656");
    while (true) {
        assert(isdefined(challenge));
        end_round = 1;
        foreach (player in getplayers()) {
            if (player.var_bf9fb961 < challenge.kill_count) {
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

// Namespace namespace_cb676f19/namespace_cb676f19
// Params 1, eflags: 0x4
// Checksum 0x6c118f56, Offset: 0x748
// Size: 0xbc
function private function_db6decae(attacker) {
    if (isdefined(self.nuked) && self.nuked) {
        foreach (player in getplayers()) {
            player.var_bf9fb961++;
        }
        return;
    }
    if (isplayer(attacker)) {
        attacker.var_bf9fb961++;
    }
}

