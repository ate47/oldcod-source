#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;

#namespace hackable;

// Namespace hackable/hackable
// Params 0, eflags: 0x6
// Checksum 0x9aca5c3, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hackable", &init, undefined, undefined, undefined);
}

// Namespace hackable/hackable
// Params 0, eflags: 0x0
// Checksum 0x83efba9b, Offset: 0xb8
// Size: 0x20
function init() {
    if (!isdefined(level.hackable_items)) {
        level.hackable_items = [];
    }
}

// Namespace hackable/hackable
// Params 5, eflags: 0x0
// Checksum 0x2d8b4669, Offset: 0xe0
// Size: 0x222
function add_hackable_object(obj, test_callback, start_callback, fail_callback, complete_callback) {
    cleanup_hackable_objects();
    if (!isdefined(level.hackable_items)) {
        level.hackable_items = [];
    } else if (!isarray(level.hackable_items)) {
        level.hackable_items = array(level.hackable_items);
    }
    level.hackable_items[level.hackable_items.size] = obj;
    if (!isdefined(obj.hackable_distance_sq)) {
        obj.hackable_distance_sq = getdvarfloat(#"scr_hacker_default_distance", 0) * getdvarfloat(#"scr_hacker_default_distance", 0);
    }
    if (!isdefined(obj.hackable_angledot)) {
        obj.hackable_angledot = getdvarfloat(#"scr_hacker_default_angledot", 0);
    }
    if (!isdefined(obj.hackable_timeout)) {
        obj.hackable_timeout = getdvarfloat(#"scr_hacker_default_timeout", 0);
    }
    if (!isdefined(obj.hackable_progress_prompt)) {
        obj.hackable_progress_prompt = #"hash_7080e1304a0ce47d";
    }
    if (!isdefined(obj.hackable_cost_mult)) {
        obj.hackable_cost_mult = 1;
    }
    if (!isdefined(obj.hackable_hack_time)) {
        obj.hackable_hack_time = getdvarfloat(#"scr_hacker_default_hack_time", 0);
    }
    obj.hackable_test_callback = test_callback;
    obj.hackable_start_callback = start_callback;
    obj.hackable_fail_callback = fail_callback;
    obj.hackable_hacked_callback = complete_callback;
}

// Namespace hackable/hackable
// Params 1, eflags: 0x0
// Checksum 0x8b3c1709, Offset: 0x310
// Size: 0x3c
function remove_hackable_object(obj) {
    arrayremovevalue(level.hackable_items, obj);
    cleanup_hackable_objects();
}

// Namespace hackable/hackable
// Params 0, eflags: 0x0
// Checksum 0x2e29d0dd, Offset: 0x358
// Size: 0x34
function cleanup_hackable_objects() {
    level.hackable_items = array::filter(level.hackable_items, 0, &filter_deleted);
}

// Namespace hackable/hackable
// Params 1, eflags: 0x0
// Checksum 0xedbc8b84, Offset: 0x398
// Size: 0x10
function filter_deleted(val) {
    return isdefined(val);
}

// Namespace hackable/hackable
// Params 0, eflags: 0x0
// Checksum 0xe6f62328, Offset: 0x3b0
// Size: 0x156
function find_hackable_object() {
    cleanup_hackable_objects();
    candidates = [];
    origin = self.origin;
    forward = anglestoforward(self.angles);
    foreach (obj in level.hackable_items) {
        if (self is_object_hackable(obj, origin, forward)) {
            if (!isdefined(candidates)) {
                candidates = [];
            } else if (!isarray(candidates)) {
                candidates = array(candidates);
            }
            candidates[candidates.size] = obj;
        }
    }
    if (candidates.size > 0) {
        return arraygetclosest(self.origin, candidates);
    }
    return undefined;
}

// Namespace hackable/hackable
// Params 3, eflags: 0x0
// Checksum 0xf94c28c7, Offset: 0x510
// Size: 0xf4
function is_object_hackable(obj, origin, forward) {
    if (distancesquared(origin, obj.origin) < obj.hackable_distance_sq) {
        to_obj = obj.origin - origin;
        to_obj = (to_obj[0], to_obj[1], 0);
        to_obj = vectornormalize(to_obj);
        dot = vectordot(to_obj, forward);
        if (dot >= obj.hackable_angledot) {
            if (isdefined(obj.hackable_test_callback)) {
                return obj [[ obj.hackable_test_callback ]](self);
            }
            return 1;
        } else {
            /#
            #/
        }
    }
    return 0;
}

// Namespace hackable/hackable
// Params 1, eflags: 0x0
// Checksum 0xa592e63f, Offset: 0x610
// Size: 0x4c
function start_hacking_object(obj) {
    obj.hackable_being_hacked = 1;
    obj.hackable_hacked_amount = 0;
    if (isdefined(obj.hackable_start_callback)) {
        obj thread [[ obj.hackable_start_callback ]](self);
    }
}

// Namespace hackable/hackable
// Params 1, eflags: 0x0
// Checksum 0xe888e65f, Offset: 0x668
// Size: 0x60
function fail_hacking_object(obj) {
    if (isdefined(obj.hackable_fail_callback)) {
        obj thread [[ obj.hackable_fail_callback ]](self);
    }
    obj.hackable_hacked_amount = 0;
    obj.hackable_being_hacked = 0;
    obj notify(#"hackable_watch_timeout");
}

// Namespace hackable/hackable
// Params 1, eflags: 0x0
// Checksum 0x60f82fce, Offset: 0x6d0
// Size: 0x5e
function complete_hacking_object(obj) {
    obj notify(#"hackable_watch_timeout");
    if (isdefined(obj.hackable_hacked_callback)) {
        obj thread [[ obj.hackable_hacked_callback ]](self);
    }
    obj.hackable_hacked_amount = 0;
    obj.hackable_being_hacked = 0;
}

// Namespace hackable/hackable
// Params 2, eflags: 0x0
// Checksum 0xdc3dca2b, Offset: 0x738
// Size: 0x5c
function watch_timeout(obj, time) {
    obj notify(#"hackable_watch_timeout");
    obj endon(#"hackable_watch_timeout");
    wait time;
    if (isdefined(obj)) {
        fail_hacking_object(obj);
    }
}

// Namespace hackable/hackable
// Params 1, eflags: 0x0
// Checksum 0xb4a5a3d4, Offset: 0x7a0
// Size: 0x18a
function continue_hacking_object(obj) {
    origin = self.origin;
    forward = anglestoforward(self.angles);
    if (self is_object_hackable(obj, origin, forward)) {
        if (!is_true(obj.hackable_being_hacked)) {
            self start_hacking_object(obj);
        }
        if (isdefined(obj.hackable_timeout) && obj.hackable_timeout > 0) {
            self thread watch_timeout(obj, obj.hackable_timeout);
        }
        amt = 1 / 20 * obj.hackable_hack_time;
        obj.hackable_hacked_amount += amt;
        if (obj.hackable_hacked_amount > 1) {
            self complete_hacking_object(obj);
        }
        if (is_true(obj.hackable_being_hacked)) {
            return obj.hackable_hacked_amount;
        }
    }
    if (is_true(obj.hackable_being_hacked)) {
    }
    return -1;
}

