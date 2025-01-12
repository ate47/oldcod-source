#using script_2595527427ea71eb;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_timeout;

// Namespace zm_trial_timeout/zm_trial_timeout
// Params 0, eflags: 0x2
// Checksum 0xf9c92f96, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_timeout", &__init__, undefined, undefined);
}

// Namespace zm_trial_timeout/zm_trial_timeout
// Params 0, eflags: 0x0
// Checksum 0x7257795, Offset: 0xd0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"timeout", &on_begin, &on_end);
}

// Namespace zm_trial_timeout/zm_trial_timeout
// Params 7, eflags: 0x4
// Checksum 0x242faa06, Offset: 0x138
// Size: 0x17c
function private on_begin(timer_label, var_6640452e, grace_period, var_d6c0d66, var_8c5a3e3b, var_dc2d810, var_c611bf1d) {
    timer_value = 0;
    switch (getplayers().size) {
    case 1:
        timer_value = zm_trial::function_9b72fb1a(var_d6c0d66);
        break;
    case 2:
        timer_value = zm_trial::function_9b72fb1a(var_8c5a3e3b);
        break;
    case 3:
        timer_value = zm_trial::function_9b72fb1a(var_dc2d810);
        break;
    case 4:
        timer_value = zm_trial::function_9b72fb1a(var_c611bf1d);
        break;
    default:
        assert(0, "<dev string:x30>");
        break;
    }
    grace_period = zm_trial::function_9b72fb1a(grace_period);
    level thread function_952839fc(timer_label, grace_period, timer_value, var_6640452e);
}

// Namespace zm_trial_timeout/zm_trial_timeout
// Params 1, eflags: 0x4
// Checksum 0x9fdefcd5, Offset: 0x2c0
// Size: 0xc8
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        if (level.var_bb57ff69 zm_trial_timer::is_open(player)) {
            level.var_bb57ff69 zm_trial_timer::close(player);
            player zm_trial_util::stop_timer();
        }
    }
}

// Namespace zm_trial_timeout/zm_trial_timeout
// Params 4, eflags: 0x4
// Checksum 0xf193addf, Offset: 0x390
// Size: 0x11c
function private function_952839fc(timer_label, grace_period, timer_value, var_6640452e) {
    level endon(#"end_of_round");
    wait grace_period;
    foreach (player in getplayers()) {
        level.var_bb57ff69 zm_trial_timer::open(player);
        level.var_bb57ff69 zm_trial_timer::set_timer_text(player, timer_label);
        player zm_trial_util::start_timer(timer_value);
    }
    wait timer_value;
    zm_trial::fail(var_6640452e);
}

