#namespace blackboard;

// Namespace blackboard/ai_blackboard
// Params 0, eflags: 0x2
// Checksum 0x8928b28b, Offset: 0x68
// Size: 0x14
function autoexec main() {
    _initializeblackboard();
}

// Namespace blackboard/ai_blackboard
// Params 0, eflags: 0x4
// Checksum 0x3779773b, Offset: 0x88
// Size: 0x2c
function private _initializeblackboard() {
    level.__ai_blackboard = [];
    level thread _updateevents();
}

// Namespace blackboard/ai_blackboard
// Params 0, eflags: 0x4
// Checksum 0x1b5ce464, Offset: 0xc0
// Size: 0x1a4
function private _updateevents() {
    waittime = 1 * float(function_f9f48566()) / 1000;
    updatemillis = int(waittime * 1000);
    while (true) {
        foreach (eventname, events in level.__ai_blackboard) {
            liveevents = [];
            foreach (event in events) {
                event.ttl -= updatemillis;
                if (event.ttl > 0) {
                    liveevents[liveevents.size] = event;
                }
            }
            level.__ai_blackboard[eventname] = liveevents;
        }
        wait waittime;
    }
}

// Namespace blackboard/ai_blackboard
// Params 3, eflags: 0x0
// Checksum 0x39b78f44, Offset: 0x270
// Size: 0x1a0
function addblackboardevent(eventname, data, timetoliveinmillis) {
    /#
        assert(isstring(eventname), "<dev string:x30>");
        assert(isdefined(data), "<dev string:x73>");
        assert(isint(timetoliveinmillis) && timetoliveinmillis > 0, "<dev string:xa8>");
    #/
    event = spawnstruct();
    event.data = data;
    event.timestamp = gettime();
    event.ttl = timetoliveinmillis;
    if (!isdefined(level.__ai_blackboard[eventname])) {
        level.__ai_blackboard[eventname] = [];
    } else if (!isarray(level.__ai_blackboard[eventname])) {
        level.__ai_blackboard[eventname] = array(level.__ai_blackboard[eventname]);
    }
    level.__ai_blackboard[eventname][level.__ai_blackboard[eventname].size] = event;
}

// Namespace blackboard/ai_blackboard
// Params 1, eflags: 0x0
// Checksum 0xfb954d85, Offset: 0x418
// Size: 0x34
function getblackboardevents(eventname) {
    if (isdefined(level.__ai_blackboard[eventname])) {
        return level.__ai_blackboard[eventname];
    }
    return [];
}

// Namespace blackboard/ai_blackboard
// Params 1, eflags: 0x0
// Checksum 0x61a70bfe, Offset: 0x458
// Size: 0x34
function removeblackboardevents(eventname) {
    if (isdefined(level.__ai_blackboard[eventname])) {
        level.__ai_blackboard[eventname] = undefined;
    }
}

