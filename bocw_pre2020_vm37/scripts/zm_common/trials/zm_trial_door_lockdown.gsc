#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace zm_trial_door_lockdown;

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 0, eflags: 0x6
// Checksum 0x36b182f6, Offset: 0x140
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_door_lockdown", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 0, eflags: 0x4
// Checksum 0xb9b567a3, Offset: 0x188
// Size: 0x9c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    clientfield::register("scriptmover", "" + #"zm_trial_door_lockdown", 16000, 1, "int");
    zm_trial::register_challenge(#"door_lockdown", &on_begin, &on_end);
}

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 0, eflags: 0x4
// Checksum 0xfc6c8496, Offset: 0x230
// Size: 0xcc
function private on_begin() {
    function_58fc4e38(8);
    level flag::set(#"disable_fast_travel");
    var_57ba058f = getentarray("gondola_call_trigger", "targetname");
    var_9ce0aba1 = getentarray("gondola_move_trigger", "targetname");
    array::run_all(var_57ba058f, &setinvisibletoall);
    array::run_all(var_9ce0aba1, &setinvisibletoall);
}

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 1, eflags: 0x4
// Checksum 0x24ff5dc8, Offset: 0x308
// Size: 0xcc
function private on_end(*round_reset) {
    level flag::clear(#"disable_fast_travel");
    var_57ba058f = getentarray("gondola_call_trigger", "targetname");
    var_9ce0aba1 = getentarray("gondola_move_trigger", "targetname");
    array::run_all(var_57ba058f, &setvisibletoall);
    array::run_all(var_9ce0aba1, &setvisibletoall);
    function_92f23ef0();
}

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 0, eflags: 0x0
// Checksum 0x283c4de1, Offset: 0x3e0
// Size: 0x32
function is_active() {
    s_challenge = zm_trial::function_a36e8c38(#"door_lockdown");
    return isdefined(s_challenge);
}

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 1, eflags: 0x0
// Checksum 0xdad9136d, Offset: 0x420
// Size: 0x190
function function_58fc4e38(n_delay = 0) {
    level endon(#"hash_7646638df88a3656");
    wait n_delay;
    a_s_blockers = struct::get_array("trials_door_lockdown_clip");
    foreach (s_blocker in a_s_blockers) {
        if (!isdefined(s_blocker.mdl_blocker)) {
            s_blocker.mdl_blocker = util::spawn_model(isdefined(s_blocker.model) ? s_blocker.model : #"collision_player_wall_128x128x10", s_blocker.origin, s_blocker.angles);
        }
        s_blocker.mdl_blocker ghost();
        util::wait_network_frame();
        s_blocker.mdl_blocker clientfield::set("" + #"zm_trial_door_lockdown", 1);
    }
}

// Namespace zm_trial_door_lockdown/zm_trial_door_lockdown
// Params 1, eflags: 0x0
// Checksum 0xbee03aa7, Offset: 0x5b8
// Size: 0x130
function function_92f23ef0(n_delay = 0) {
    level endon(#"hash_7646638df88a3656");
    wait n_delay;
    a_s_blockers = struct::get_array("trials_door_lockdown_clip");
    foreach (s_blocker in a_s_blockers) {
        if (isdefined(s_blocker.mdl_blocker)) {
            s_blocker.mdl_blocker clientfield::set("" + #"zm_trial_door_lockdown", 0);
            util::wait_network_frame();
            s_blocker.mdl_blocker delete();
        }
    }
}

