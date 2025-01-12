#using scripts\core_common\struct;
#using scripts\zm_common\zm_utility;

#namespace zm_server_throttle;

// Namespace zm_server_throttle/zm_server_throttle
// Params 2, eflags: 0x0
// Checksum 0x33e03552, Offset: 0x78
// Size: 0x84
function server_choke_init(id, max) {
    if (!isdefined(level.zombie_server_choke_ids_max)) {
        level.zombie_server_choke_ids_max = [];
        level.zombie_server_choke_ids_count = [];
    }
    level.zombie_server_choke_ids_max[id] = max;
    level.zombie_server_choke_ids_count[id] = 0;
    level thread server_choke_thread(id);
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 1, eflags: 0x0
// Checksum 0x9e55188d, Offset: 0x108
// Size: 0x32
function server_choke_thread(id) {
    while (true) {
        waitframe(1);
        level.zombie_server_choke_ids_count[id] = 0;
    }
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 1, eflags: 0x0
// Checksum 0xc4691752, Offset: 0x148
// Size: 0x2e
function server_choke_safe(id) {
    return level.zombie_server_choke_ids_count[id] < level.zombie_server_choke_ids_max[id];
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 5, eflags: 0x0
// Checksum 0xcc09ed3c, Offset: 0x180
// Size: 0xf8
function server_choke_action(id, choke_action, arg1, arg2, arg3) {
    assert(isdefined(level.zombie_server_choke_ids_max[id]), "<dev string:x30>" + id + "<dev string:x3f>");
    while (!server_choke_safe(id)) {
        waitframe(1);
    }
    level.zombie_server_choke_ids_count[id]++;
    if (!isdefined(arg1)) {
        return [[ choke_action ]]();
    }
    if (!isdefined(arg2)) {
        return [[ choke_action ]](arg1);
    }
    if (!isdefined(arg3)) {
        return [[ choke_action ]](arg1, arg2);
    }
    return [[ choke_action ]](arg1, arg2, arg3);
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 1, eflags: 0x0
// Checksum 0x190286d2, Offset: 0x280
// Size: 0x1c
function server_entity_valid(entity) {
    if (!isdefined(entity)) {
        return false;
    }
    return true;
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 2, eflags: 0x0
// Checksum 0xd3e89e68, Offset: 0x2a8
// Size: 0x7c
function server_safe_init(id, max) {
    if (!isdefined(level.zombie_server_choke_ids_max) || !isdefined(level.zombie_server_choke_ids_max[id])) {
        server_choke_init(id, max);
    }
    assert(max == level.zombie_server_choke_ids_max[id]);
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 1, eflags: 0x0
// Checksum 0xe0d5c4a1, Offset: 0x330
// Size: 0x22
function _server_safe_ground_trace(pos) {
    return zm_utility::groundpos(pos);
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 3, eflags: 0x0
// Checksum 0x5c80d4c7, Offset: 0x360
// Size: 0x52
function server_safe_ground_trace(id, max, origin) {
    server_safe_init(id, max);
    return server_choke_action(id, &_server_safe_ground_trace, origin);
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 1, eflags: 0x0
// Checksum 0x94dd59e7, Offset: 0x3c0
// Size: 0x22
function _server_safe_ground_trace_ignore_water(pos) {
    return zm_utility::groundpos_ignore_water(pos);
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 3, eflags: 0x0
// Checksum 0x627ccf6c, Offset: 0x3f0
// Size: 0x52
function server_safe_ground_trace_ignore_water(id, max, origin) {
    server_safe_init(id, max);
    return server_choke_action(id, &_server_safe_ground_trace_ignore_water, origin);
}

