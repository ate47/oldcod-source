#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_open_all_doors;

// Namespace zm_trial_open_all_doors/zm_trial_open_all_doors
// Params 0, eflags: 0x2
// Checksum 0xcb9f4eb2, Offset: 0xb0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_open_all_doors", &__init__, undefined, undefined);
}

// Namespace zm_trial_open_all_doors/zm_trial_open_all_doors
// Params 0, eflags: 0x0
// Checksum 0x10183665, Offset: 0xf8
// Size: 0xec
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zombie_doors = getentarray("zombie_door", "targetname");
    zombie_debris = getentarray("zombie_debris", "targetname");
    level.var_2f816067 = function_3055d723(zombie_doors);
    level.var_b85336ee = function_3055d723(zombie_debris);
    zm_trial::register_challenge(#"open_all_doors", &on_begin, &on_end);
}

// Namespace zm_trial_open_all_doors/zm_trial_open_all_doors
// Params 0, eflags: 0x4
// Checksum 0xee053fc8, Offset: 0x1f0
// Size: 0x5c
function private on_begin() {
    level thread function_e6659756();
    zm_trial_util::function_368f31a9(level.var_2f816067 + level.var_b85336ee);
    zm_trial_util::function_ef967e48(0);
}

// Namespace zm_trial_open_all_doors/zm_trial_open_all_doors
// Params 1, eflags: 0x4
// Checksum 0x7e48dd9a, Offset: 0x258
// Size: 0xe4
function private on_end(round_reset) {
    zm_trial_util::function_59861180();
    if (!round_reset) {
        zombie_doors = getentarray("zombie_door", "targetname");
        zombie_debris = getentarray("zombie_debris", "targetname");
        var_64245d0d = function_4f6b3c38(zombie_doors, zombie_debris);
        var_b7b9c28c = level.var_2f816067 + level.var_b85336ee;
        if (var_64245d0d < var_b7b9c28c) {
            zm_trial::fail(#"hash_2c31c30f3d0b0484");
        }
    }
}

// Namespace zm_trial_open_all_doors/zm_trial_open_all_doors
// Params 1, eflags: 0x4
// Checksum 0x20c79310, Offset: 0x348
// Size: 0xc0
function private function_3055d723(ents) {
    ents = array::remove_undefined(ents, 0);
    unique = [];
    foreach (ent in ents) {
        if (isdefined(ent.target)) {
            unique[ent.target] = 1;
        }
    }
    return unique.size;
}

// Namespace zm_trial_open_all_doors/zm_trial_open_all_doors
// Params 2, eflags: 0x4
// Checksum 0xeaea96fc, Offset: 0x410
// Size: 0x122
function private function_4f6b3c38(door_ents, debris_ents) {
    var_7a471dc = [];
    foreach (door_ent in door_ents) {
        if (isdefined(door_ent.target) && isdefined(door_ent.has_been_opened) && door_ent.has_been_opened) {
            var_7a471dc[door_ent.target] = 1;
        }
    }
    var_64245d0d = var_7a471dc.size;
    var_c3e227ca = function_3055d723(debris_ents);
    var_86201353 = level.var_b85336ee - var_c3e227ca;
    return var_64245d0d + var_86201353;
}

// Namespace zm_trial_open_all_doors/zm_trial_open_all_doors
// Params 0, eflags: 0x4
// Checksum 0xbb5104fd, Offset: 0x540
// Size: 0xc6
function private function_e6659756() {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    zombie_doors = getentarray("zombie_door", "targetname");
    zombie_debris = getentarray("zombie_debris", "targetname");
    while (true) {
        var_64245d0d = function_4f6b3c38(zombie_doors, zombie_debris);
        zm_trial_util::function_ef967e48(var_64245d0d);
        waitframe(1);
    }
}

