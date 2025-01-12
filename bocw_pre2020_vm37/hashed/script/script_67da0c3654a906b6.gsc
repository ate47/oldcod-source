#using scripts\core_common\callbacks_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace namespace_6c76c1da;

// Namespace namespace_6c76c1da/namespace_6c76c1da
// Params 0, eflags: 0x6
// Checksum 0x312f2d96, Offset: 0xc0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_442b60ca31422a3c", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_6c76c1da/namespace_6c76c1da
// Params 0, eflags: 0x4
// Checksum 0x6e4240b0, Offset: 0x108
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_5124770c13a75bab", &on_begin, &on_end);
}

// Namespace namespace_6c76c1da/namespace_6c76c1da
// Params 3, eflags: 0x4
// Checksum 0x99736cb9, Offset: 0x170
// Size: 0x160
function private on_begin(var_93fc795f, var_a7c52900, var_c8a36f90) {
    var_a7c52900 = zm_trial::function_5769f26a(var_a7c52900);
    level.var_1c8f9eba = var_c8a36f90;
    wait 6;
    foreach (player in getplayers()) {
        if (isdefined(var_c8a36f90)) {
            switch (var_c8a36f90) {
            case #"prone_random":
                player thread function_9c988cd8(var_93fc795f, var_a7c52900, 1);
                break;
            case #"crouch":
                player thread function_9c988cd8(var_93fc795f, var_a7c52900, 0);
                break;
            }
            continue;
        }
        player thread movement_watcher(var_93fc795f, var_a7c52900);
    }
}

// Namespace namespace_6c76c1da/namespace_6c76c1da
// Params 1, eflags: 0x4
// Checksum 0x7cc5b537, Offset: 0x2d8
// Size: 0x16
function private on_end(*round_reset) {
    level.var_1c8f9eba = undefined;
}

// Namespace namespace_6c76c1da/namespace_6c76c1da
// Params 0, eflags: 0x0
// Checksum 0x927501b3, Offset: 0x2f8
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"hash_5124770c13a75bab");
    return isdefined(challenge);
}

// Namespace namespace_6c76c1da/namespace_6c76c1da
// Params 2, eflags: 0x4
// Checksum 0xe7f09ccd, Offset: 0x338
// Size: 0x136
function private movement_watcher(var_93fc795f, var_98de1f93) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    while (true) {
        var_197c85d1 = self getvelocity();
        var_9b7f7d9b = length(var_197c85d1);
        if (isalive(self) && !self laststand::player_is_in_laststand() && !self issprinting()) {
            self function_6b13a114(var_93fc795f, var_98de1f93);
            if (var_9b7f7d9b == 0) {
                n_wait_time = 0.25;
            } else {
                n_wait_time = max(0.5, var_9b7f7d9b / 190);
            }
            wait n_wait_time;
        }
        waitframe(1);
    }
}

// Namespace namespace_6c76c1da/namespace_6c76c1da
// Params 2, eflags: 0x4
// Checksum 0x867e513a, Offset: 0x478
// Size: 0x94
function private function_6b13a114(var_93fc795f, var_a7c52900) {
    self playsoundtoplayer(#"hash_6df374d848ba6a60", self);
    if (var_93fc795f === "health") {
        self dodamage(var_a7c52900, self.origin);
        return;
    }
    if (var_93fc795f === "points") {
        self zm_score::minus_to_player_score(var_a7c52900, 1);
    }
}

// Namespace namespace_6c76c1da/namespace_6c76c1da
// Params 0, eflags: 0x4
// Checksum 0x820d5c09, Offset: 0x518
// Size: 0x1d4
function private function_26f124d8() {
    if (!isdefined(level.var_1c8f9eba)) {
        return true;
    }
    switch (level.var_1c8f9eba) {
    case #"ads":
        var_389b3ef1 = self playerads();
        if (self adsbuttonpressed() && var_389b3ef1 > 0) {
            return true;
        }
        return false;
    case #"jump":
        if (self zm_utility::is_jumping()) {
            return true;
        }
        return false;
    case #"slide":
        if (self issliding()) {
            return true;
        }
        return false;
    case #"crouch":
        if (self getstance() === "crouch") {
            return true;
        }
        return false;
    case #"prone_random":
    case #"prone":
        if (self getstance() === "prone") {
            return true;
        }
        return false;
    case #"movement":
    default:
        v_velocity = self getvelocity();
        if (length(v_velocity) != 0) {
            return true;
        }
        return false;
    }
    return false;
}

// Namespace namespace_6c76c1da/namespace_6c76c1da
// Params 3, eflags: 0x4
// Checksum 0x546bdc9d, Offset: 0x6f8
// Size: 0x10a
function private function_9c988cd8(var_93fc795f, var_98de1f93, var_e898f976 = 0) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    if (!var_e898f976) {
        wait 12;
    }
    while (true) {
        if (var_e898f976) {
            wait randomfloatrange(10, 25);
        } else {
            waitframe(1);
        }
        while (isalive(self) && !self laststand::player_is_in_laststand() && !self function_26f124d8()) {
            self function_6b13a114(var_93fc795f, var_98de1f93);
            wait 1;
        }
    }
}

