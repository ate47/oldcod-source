#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_shoot_from_location;

// Namespace zm_trial_shoot_from_location/zm_trial_shoot_from_location
// Params 0, eflags: 0x6
// Checksum 0x79e501ea, Offset: 0x110
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_shoot_from_location", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_shoot_from_location/zm_trial_shoot_from_location
// Params 0, eflags: 0x4
// Checksum 0x858d23b9, Offset: 0x158
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"shoot_from_location", &on_begin, &on_end);
}

// Namespace zm_trial_shoot_from_location/zm_trial_shoot_from_location
// Params 0, eflags: 0x4
// Checksum 0x77202917, Offset: 0x1c0
// Size: 0x258
function private on_begin() {
    if (util::get_map_name() == "zm_office") {
        elevator1 = getent("elevator1", "targetname");
        elevator2 = getent("elevator2", "targetname");
        elevator1.cost = 0;
        elevator2.cost = 0;
        trigger1 = getent(elevator1.targetname + "_buy", "script_noteworthy");
        trigger2 = getent(elevator2.targetname + "_buy", "script_noteworthy");
        trigger1 sethintstring(level.var_31560d97, elevator1.cost);
        trigger2 sethintstring(level.var_31560d97, elevator2.cost);
    }
    str_targetname = "trials_shoot_from_location";
    level.var_7f31a12d = getentarray(str_targetname, "targetname");
    assert(level.var_7f31a12d.size, "<dev string:x38>");
    callback::function_33f0ddd3(&function_33f0ddd3);
    foreach (player in getplayers()) {
        player thread function_3658663();
    }
}

// Namespace zm_trial_shoot_from_location/zm_trial_shoot_from_location
// Params 1, eflags: 0x4
// Checksum 0xc949794, Offset: 0x420
// Size: 0x20a
function private on_end(*round_reset) {
    callback::function_824d206(&function_33f0ddd3);
    if (util::get_map_name() == "zm_office") {
        elevator1 = getent("elevator1", "targetname");
        elevator2 = getent("elevator2", "targetname");
        elevator1.cost = 500;
        elevator2.cost = 500;
        trigger1 = getent(elevator1.targetname + "_buy", "script_noteworthy");
        trigger2 = getent(elevator2.targetname + "_buy", "script_noteworthy");
        trigger1 sethintstring(level.var_31560d97, elevator1.cost);
        trigger2 sethintstring(level.var_31560d97, elevator2.cost);
    }
    foreach (player in getplayers()) {
        player thread zm_trial_util::function_dc0859e();
    }
    level.var_7f31a12d = undefined;
}

// Namespace zm_trial_shoot_from_location/zm_trial_shoot_from_location
// Params 0, eflags: 0x4
// Checksum 0x63ffeda5, Offset: 0x638
// Size: 0x156
function private function_3658663() {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    var_407eb07 = 0;
    while (true) {
        var_f2b6fe6e = 0;
        foreach (var_3953f2a9 in level.var_7f31a12d) {
            if (self istouching(var_3953f2a9)) {
                var_f2b6fe6e = 1;
                break;
            }
        }
        if (var_f2b6fe6e && var_407eb07) {
            self zm_trial_util::function_dc0859e();
            var_407eb07 = 0;
        } else if (!var_f2b6fe6e && !var_407eb07) {
            self zm_trial_util::function_bf710271();
            var_407eb07 = 1;
        }
        waitframe(1);
    }
}

// Namespace zm_trial_shoot_from_location/zm_trial_shoot_from_location
// Params 1, eflags: 0x4
// Checksum 0x925e115, Offset: 0x798
// Size: 0x11c
function private function_33f0ddd3(s_event) {
    if (s_event.event === "give_weapon") {
        var_f2b6fe6e = 0;
        foreach (var_3953f2a9 in level.var_7f31a12d) {
            if (self istouching(var_3953f2a9)) {
                var_f2b6fe6e = 1;
                break;
            }
        }
        if (!var_f2b6fe6e && !zm_loadout::function_2ff6913(s_event.weapon)) {
            self function_28602a03(s_event.weapon, 1, 1);
        }
    }
}

