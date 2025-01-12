#using scripts\core_common\system_shared;

#namespace voice_events;

// Namespace voice_events/voice_events
// Params 0, eflags: 0x2
// Checksum 0x4970bf52, Offset: 0x70
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"voice_events", &__init__, undefined, undefined);
}

// Namespace voice_events/voice_events
// Params 0, eflags: 0x0
// Checksum 0xee3252bf, Offset: 0xb8
// Size: 0x2a
function __init__() {
    level.var_75d4a794 = [];
    level.var_b67e5d65 = [];
    level.var_735d157 = [];
}

// Namespace voice_events/voice_events
// Params 2, eflags: 0x0
// Checksum 0xafc760ea, Offset: 0xf0
// Size: 0xb8
function register_handler(event, handlerfunc) {
    assert(isdefined(event), "<dev string:x30>");
    assert(isfunctionptr(handlerfunc), "<dev string:x52>");
    funcs = level.var_75d4a794[event];
    if (!isdefined(funcs)) {
        funcs = [];
        level.var_75d4a794[event] = funcs;
    }
    funcs[funcs.size] = handlerfunc;
}

// Namespace voice_events/voice_events
// Params 4, eflags: 0x0
// Checksum 0x996245c3, Offset: 0x1b0
// Size: 0x1ae
function function_7fb9c33f(event, handlerfunc, priority = 0, var_c64b6330 = undefined) {
    assert(isdefined(event), "<dev string:x30>");
    assert(isfunctionptr(handlerfunc), "<dev string:x52>");
    assert(isint(priority) || isfloat(priority), "<dev string:x83>");
    assert(!isdefined(var_c64b6330) || isfunctionptr(var_c64b6330), "<dev string:x9d>");
    assert(!isdefined(level.var_b67e5d65[event]), "<dev string:xcf>" + event);
    handler = {#handlerfunc:handlerfunc, #priority:priority, #var_c64b6330:var_c64b6330};
    level.var_b67e5d65[event] = handler;
}

// Namespace voice_events/voice_events
// Params 1, eflags: 0x0
// Checksum 0xfce88502, Offset: 0x368
// Size: 0xc4
function create_queue(queuename) {
    assert(isdefined(queuename), "<dev string:xf9>");
    assert(!isdefined(level.var_735d157[queuename]), "<dev string:x13c>" + queuename);
    if (!isdefined(queuename) || isdefined(level.var_735d157[queuename])) {
        return;
    }
    queue = [];
    level.var_735d157[queuename] = queue;
    level thread function_42fa09e6(queue);
}

// Namespace voice_events/voice_events
// Params 5, eflags: 0x0
// Checksum 0xaaa997d2, Offset: 0x438
// Size: 0x28c
function queue_event(queuename, event, handlerfunc, priority = 0, params = undefined) {
    assert(isdefined(queuename), "<dev string:x170>");
    assert(isdefined(level.var_735d157[queuename]), "<dev string:x1b2>" + queuename);
    assert(isdefined(event), "<dev string:x1e2>");
    assert(isfunctionptr(handlerfunc), "<dev string:x220>");
    assert(isint(priority) || isfloat(priority), "<dev string:x26d>");
    assert(!isdefined(params) || isstruct(params), "<dev string:x2a3>");
    queue = level.var_735d157[queuename];
    if (!isdefined(queue) || !isdefined(event) || !isfunctionptr(handlerfunc)) {
        return;
    }
    if (!isint(priority) && !isfloat(priority)) {
        return;
    }
    item = spawnstruct();
    item.context = self;
    item.time = gettime();
    item.event = event;
    item.priority = priority;
    item.handlerfunc = handlerfunc;
    item.params = params;
    queue_item(queue, item);
}

// Namespace voice_events/voice_events
// Params 2, eflags: 0x0
// Checksum 0xbd9c6589, Offset: 0x6d0
// Size: 0x230
function function_cd5f0529(event, params) {
    funcs = level.var_75d4a794[event];
    if (isdefined(funcs)) {
        foreach (func in funcs) {
            self thread [[ func ]](event, params);
        }
    }
    handler = level.var_b67e5d65[event];
    if (!isdefined(handler)) {
        return;
    }
    var_c64b6330 = handler.var_c64b6330;
    foreach (name, queue in level.var_735d157) {
        item = spawnstruct();
        item.context = self;
        item.time = gettime();
        item.priority = handler.priority;
        item.event = event;
        item.handlerfunc = handler.handlerfunc;
        if (isstruct(params)) {
            item.params = structcopy(params);
        }
        if (!isdefined(var_c64b6330) || self [[ var_c64b6330 ]](name, queue, item)) {
            queue_item(queue, item);
        }
    }
}

// Namespace voice_events/voice_events
// Params 2, eflags: 0x4
// Checksum 0xf7feaa07, Offset: 0x908
// Size: 0x7c
function private queue_item(&queue, item) {
    for (i = 0; i < queue.size; i++) {
        if (queue[i].priority < item.priority) {
            break;
        }
    }
    arrayinsert(queue, item, i);
}

// Namespace voice_events/voice_events
// Params 1, eflags: 0x4
// Checksum 0x5a4e30ff, Offset: 0x990
// Size: 0xba
function private function_42fa09e6(&queue) {
    level endon(#"game_ended");
    while (true) {
        while (queue.size > 0) {
            item = queue[0];
            arrayremoveindex(queue, 0);
            if (!isdefined(item.context)) {
                continue;
            }
            item.context [[ item.handlerfunc ]](item.event, item.params);
        }
        waitframe(1);
    }
}

