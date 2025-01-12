#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_repair_boards;

// Namespace zm_trial_repair_boards/zm_trial_repair_boards
// Params 0, eflags: 0x6
// Checksum 0x74661536, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_repair_boards", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_repair_boards/zm_trial_repair_boards
// Params 0, eflags: 0x4
// Checksum 0xf4733110, Offset: 0xd0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"repair_boards", &on_begin, &on_end);
}

// Namespace zm_trial_repair_boards/zm_trial_repair_boards
// Params 5, eflags: 0x4
// Checksum 0x28befa7e, Offset: 0x138
// Size: 0x1f4
function private on_begin(var_60bdad5f, var_36c3cc24, var_4ee27b15, var_3bc46181, var_1f6e1e99) {
    switch (level.players.size) {
    case 1:
        self.var_28433a54 = zm_trial::function_5769f26a(var_36c3cc24);
        break;
    case 2:
        self.var_28433a54 = zm_trial::function_5769f26a(var_4ee27b15);
        break;
    case 3:
        self.var_28433a54 = zm_trial::function_5769f26a(var_3bc46181);
        break;
    case 4:
        self.var_28433a54 = zm_trial::function_5769f26a(var_1f6e1e99);
        break;
    }
    self.var_358e6a29 = self.var_28433a54;
    self.var_e6e7a65d = isdefined(zombie_utility::function_d2dfacfd(#"rebuild_barrier_cap_per_round")) ? zombie_utility::function_d2dfacfd(#"rebuild_barrier_cap_per_round") : 0;
    zombie_utility::set_zombie_var(#"rebuild_barrier_cap_per_round", self.var_28433a54);
    self.var_a84ac7c8 = var_60bdad5f;
    zm_trial_util::function_2976fa44(self.var_358e6a29);
    zm_trial_util::function_dace284(0);
    self thread function_738e3a43();
}

// Namespace zm_trial_repair_boards/zm_trial_repair_boards
// Params 1, eflags: 0x4
// Checksum 0x78d30b7e, Offset: 0x338
// Size: 0x74
function private on_end(round_reset) {
    if (!round_reset) {
        if (self.var_28433a54 > 0) {
            zm_trial::fail(self.var_a84ac7c8);
        }
    }
    zm_trial_util::function_f3dbeda7();
    zombie_utility::set_zombie_var(#"rebuild_barrier_cap_per_round", self.var_e6e7a65d);
}

// Namespace zm_trial_repair_boards/zm_trial_repair_boards
// Params 0, eflags: 0x4
// Checksum 0x17d64acf, Offset: 0x3b8
// Size: 0x188
function private function_738e3a43() {
    level endon(#"hash_7646638df88a3656");
    var_812095a3 = 0;
    while (self.var_28433a54) {
        waitresult = level waittill(#"rebuild_board");
        var_c7ff10eb = 0;
        var_812095a3++;
        if (var_812095a3 >= 5) {
            var_c7ff10eb = 1;
            var_812095a3 = 0;
        }
        if (self.var_358e6a29 > zombie_utility::function_d2dfacfd(#"rebuild_barrier_cap_per_round")) {
            self.var_e6e7a65d = zombie_utility::function_d2dfacfd(#"rebuild_barrier_cap_per_round");
            zombie_utility::set_zombie_var(#"rebuild_barrier_cap_per_round", self.var_358e6a29);
        }
        if (isdefined(waitresult.points)) {
            self.var_28433a54 -= waitresult.points;
        }
        self.var_28433a54 = math::clamp(self.var_28433a54, 0, 1000);
        zm_trial_util::function_dace284(int(self.var_358e6a29 - self.var_28433a54));
    }
}

