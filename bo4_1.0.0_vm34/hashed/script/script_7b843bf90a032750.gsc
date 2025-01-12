#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;

#namespace namespace_3e2923d4;

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 0, eflags: 0x2
// Checksum 0xbf88ace2, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_7ceb08aa364e4596", &__init__, undefined, undefined);
}

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 0, eflags: 0x0
// Checksum 0xb79ea77e, Offset: 0xf0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_250115340b2e27a5", &on_begin, &on_end);
}

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 0, eflags: 0x4
// Checksum 0xeff52003, Offset: 0x158
// Size: 0x64
function private on_begin() {
    self.var_b24ec34a = 20;
    self.var_985130e4 = 1;
    self.var_a5ad3a56 = 0.25;
    self thread function_9425076();
    zm_spawner::register_zombie_death_event_callback(&function_db6decae);
}

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 1, eflags: 0x4
// Checksum 0xe514b6f3, Offset: 0x1c8
// Size: 0x2c
function private on_end(round_reset) {
    zm_spawner::deregister_zombie_death_event_callback(&function_db6decae);
}

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 0, eflags: 0x4
// Checksum 0x6c287b57, Offset: 0x200
// Size: 0x1f0
function private function_9425076() {
    level endon(#"hash_7646638df88a3656");
    delay = zm_round_logic::get_delay_between_rounds();
    wait delay;
    while (true) {
        foreach (player in getplayers()) {
            /#
                if (isgodmode(player) || player isinmovemode("<dev string:x30>", "<dev string:x37>")) {
                    continue;
                }
            #/
            if (player.health > 0 && !player laststand::player_is_in_laststand() && !(isdefined(player.var_e99541c5) && player.var_e99541c5)) {
                if (player.health <= self.var_985130e4) {
                    if (zm_utility::is_magic_bullet_shield_enabled(player)) {
                        player util::stop_magic_bullet_shield();
                    }
                    player dodamage(player.health + 1000, player.origin);
                    continue;
                }
                player.health -= self.var_985130e4;
            }
        }
        wait self.var_a5ad3a56;
    }
}

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 0, eflags: 0x4
// Checksum 0xb2ba2e68, Offset: 0x3f8
// Size: 0xd2
function private function_2791f701() {
    challenge = zm_trial::function_871c1f7f(#"hash_250115340b2e27a5");
    assert(isdefined(challenge));
    new_health = self.health + challenge.var_b24ec34a;
    self.health = int(math::clamp(floor(new_health), 0, max(self.maxhealth, self.var_63f2cd6e)));
}

// Namespace namespace_3e2923d4/namespace_3e2923d4
// Params 1, eflags: 0x4
// Checksum 0xce8089d9, Offset: 0x4d8
// Size: 0xcc
function private function_db6decae(attacker) {
    if (isdefined(self.nuked) && self.nuked) {
        foreach (player in getplayers()) {
            player function_2791f701();
        }
        return;
    }
    if (isplayer(attacker)) {
        attacker function_2791f701();
    }
}

