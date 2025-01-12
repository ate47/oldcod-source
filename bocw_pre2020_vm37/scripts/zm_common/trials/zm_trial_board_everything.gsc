#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace zm_trial_board_everything;

// Namespace zm_trial_board_everything/zm_trial_board_everything
// Params 0, eflags: 0x6
// Checksum 0xc6dda7d5, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_board_everything", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_board_everything/zm_trial_board_everything
// Params 0, eflags: 0x4
// Checksum 0xf1b6de1, Offset: 0xf0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"board_everything", &on_begin, &on_end);
}

// Namespace zm_trial_board_everything/zm_trial_board_everything
// Params 0, eflags: 0x4
// Checksum 0x46aeb63b, Offset: 0x158
// Size: 0x34
function private on_begin() {
    zm_powerups::function_74b8ec6b("carpenter");
    level thread function_4172344e();
}

// Namespace zm_trial_board_everything/zm_trial_board_everything
// Params 1, eflags: 0x4
// Checksum 0x5714ea1a, Offset: 0x198
// Size: 0x8c
function private on_end(round_reset) {
    if (!round_reset && level.var_3de460b1 < level.var_70135c38) {
        zm_trial::fail(#"hash_e0fa688fb248886");
    }
    level.var_3de460b1 = undefined;
    level.var_70135c38 = undefined;
    zm_trial_util::function_f3dbeda7();
    zm_powerups::function_41cedb05("carpenter");
}

// Namespace zm_trial_board_everything/zm_trial_board_everything
// Params 0, eflags: 0x0
// Checksum 0x3cc20396, Offset: 0x230
// Size: 0x192
function function_4172344e() {
    level endon(#"hash_7646638df88a3656");
    while (true) {
        level.var_70135c38 = level.exterior_goals.size;
        level.var_3de460b1 = 0;
        foreach (s_barrier in level.exterior_goals) {
            if (zm_utility::all_chunks_intact(s_barrier, s_barrier.barrier_chunks) || zm_utility::no_valid_repairable_boards(s_barrier, s_barrier.barrier_chunks)) {
                level.var_3de460b1++;
            }
        }
        zm_trial_util::function_2976fa44(level.var_70135c38);
        zm_trial_util::function_dace284(level.var_3de460b1, 1);
        s_waitresult = level waittill(#"zombie_board_tear", #"board_repaired", #"carpenter_finished");
    }
}

