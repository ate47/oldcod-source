#using scripts\core_common\struct;
#using scripts\zm_common\zm_utility;

#namespace zm_server_throttle;

// Namespace zm_server_throttle/zm_server_throttle
// Params 2, eflags: 0x1 linked
// Checksum 0x74661e90, Offset: 0x70
// Size: 0x74
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
// Params 1, eflags: 0x1 linked
// Checksum 0x8e70722c, Offset: 0xf0
// Size: 0x30
function server_choke_thread(id) {
    while (true) {
        waitframe(1);
        level.zombie_server_choke_ids_count[id] = 0;
    }
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 1, eflags: 0x1 linked
// Checksum 0x6d7a3193, Offset: 0x128
// Size: 0x2e
function server_choke_safe(id) {
    return level.zombie_server_choke_ids_count[id] < level.zombie_server_choke_ids_max[id];
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 5, eflags: 0x1 linked
// Checksum 0x202c39c6, Offset: 0x160
// Size: 0xf0
function server_choke_action(id, choke_action, arg1, arg2, arg3) {
    assert(isdefined(level.zombie_server_choke_ids_max[id]), "<dev string:x38>" + id + "<dev string:x4a>");
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
// Checksum 0xc8217de5, Offset: 0x258
// Size: 0x1c
function server_entity_valid(entity) {
    if (!isdefined(entity)) {
        return false;
    }
    return true;
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 2, eflags: 0x1 linked
// Checksum 0xe9398fe1, Offset: 0x280
// Size: 0x7c
function server_safe_init(id, max) {
    if (!isdefined(level.zombie_server_choke_ids_max) || !isdefined(level.zombie_server_choke_ids_max[id])) {
        server_choke_init(id, max);
    }
    assert(max == level.zombie_server_choke_ids_max[id]);
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 1, eflags: 0x1 linked
// Checksum 0x3a7f8c1a, Offset: 0x308
// Size: 0x22
function _server_safe_ground_trace(pos) {
    return zm_utility::groundpos(pos);
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 3, eflags: 0x1 linked
// Checksum 0x106b1995, Offset: 0x338
// Size: 0x52
function server_safe_ground_trace(id, max, origin) {
    server_safe_init(id, max);
    return server_choke_action(id, &_server_safe_ground_trace, origin);
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 1, eflags: 0x1 linked
// Checksum 0xe966d43a, Offset: 0x398
// Size: 0x22
function _server_safe_ground_trace_ignore_water(pos) {
    return zm_utility::groundpos_ignore_water(pos);
}

// Namespace zm_server_throttle/zm_server_throttle
// Params 3, eflags: 0x0
// Checksum 0x8a0cbc1a, Offset: 0x3c8
// Size: 0x52
function server_safe_ground_trace_ignore_water(id, max, origin) {
    server_safe_init(id, max);
    return server_choke_action(id, &_server_safe_ground_trace_ignore_water, origin);
}

