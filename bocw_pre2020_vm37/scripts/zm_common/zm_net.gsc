#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace zm_net;

// Namespace zm_net/zm_net
// Params 2, eflags: 0x1 linked
// Checksum 0x26b10a9f, Offset: 0x70
// Size: 0x74
function network_choke_init(id, max) {
    if (!isdefined(level.zombie_network_choke_ids_max)) {
        level.zombie_network_choke_ids_max = [];
        level.zombie_network_choke_ids_count = [];
    }
    level.zombie_network_choke_ids_max[id] = max;
    level.zombie_network_choke_ids_count[id] = 0;
    level thread network_choke_thread(id);
}

// Namespace zm_net/zm_net
// Params 1, eflags: 0x1 linked
// Checksum 0x5f6fe70c, Offset: 0xf0
// Size: 0x48
function network_choke_thread(id) {
    while (true) {
        util::wait_network_frame();
        util::wait_network_frame();
        level.zombie_network_choke_ids_count[id] = 0;
    }
}

// Namespace zm_net/zm_net
// Params 1, eflags: 0x1 linked
// Checksum 0x52443970, Offset: 0x140
// Size: 0x2e
function network_choke_safe(id) {
    return level.zombie_network_choke_ids_count[id] < level.zombie_network_choke_ids_max[id];
}

// Namespace zm_net/zm_net
// Params 5, eflags: 0x1 linked
// Checksum 0x204f6ba, Offset: 0x178
// Size: 0xf0
function network_choke_action(id, choke_action, arg1, arg2, arg3) {
    assert(isdefined(level.zombie_network_choke_ids_max[id]), "<dev string:x38>" + id + "<dev string:x4b>");
    while (!network_choke_safe(id)) {
        waitframe(1);
    }
    level.zombie_network_choke_ids_count[id]++;
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

// Namespace zm_net/zm_net
// Params 1, eflags: 0x1 linked
// Checksum 0x1825698d, Offset: 0x270
// Size: 0x1c
function network_entity_valid(entity) {
    if (!isdefined(entity)) {
        return false;
    }
    return true;
}

// Namespace zm_net/zm_net
// Params 2, eflags: 0x1 linked
// Checksum 0xe77c9a41, Offset: 0x298
// Size: 0x7c
function network_safe_init(id, max) {
    if (!isdefined(level.zombie_network_choke_ids_max) || !isdefined(level.zombie_network_choke_ids_max[id])) {
        network_choke_init(id, max);
    }
    assert(max == level.zombie_network_choke_ids_max[id]);
}

// Namespace zm_net/zm_net
// Params 2, eflags: 0x1 linked
// Checksum 0x550ce232, Offset: 0x320
// Size: 0x2a
function _network_safe_spawn(classname, origin) {
    return spawn(classname, origin);
}

// Namespace zm_net/zm_net
// Params 4, eflags: 0x1 linked
// Checksum 0x767e065f, Offset: 0x358
// Size: 0x62
function network_safe_spawn(id, max, classname, origin) {
    network_safe_init(id, max);
    return network_choke_action(id, &_network_safe_spawn, classname, origin);
}

// Namespace zm_net/zm_net
// Params 3, eflags: 0x1 linked
// Checksum 0xa71848ad, Offset: 0x3c8
// Size: 0x4c
function _network_safe_play_fx_on_tag(fx, entity, tag) {
    if (network_entity_valid(entity)) {
        playfxontag(fx, entity, tag);
    }
}

// Namespace zm_net/zm_net
// Params 5, eflags: 0x1 linked
// Checksum 0x47c9efd0, Offset: 0x420
// Size: 0x6c
function network_safe_play_fx_on_tag(id, max, fx, entity, tag) {
    network_safe_init(id, max);
    network_choke_action(id, &_network_safe_play_fx_on_tag, fx, entity, tag);
}

