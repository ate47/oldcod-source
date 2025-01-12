#namespace blackboard;

// Namespace blackboard/ai_blackboard
// Params 0, eflags: 0x2
// Checksum 0x7f387d99, Offset: 0x90
// Size: 0x14
function autoexec main() {
    _initializeblackboard();
}

// Namespace blackboard/ai_blackboard
// Params 0, eflags: 0x4
// Checksum 0x6c180111, Offset: 0xb0
// Size: 0x2c
function private _initializeblackboard() {
    level.__ai_blackboard = [];
    level thread _updateevents();
}

// Namespace blackboard/ai_blackboard
// Params 0, eflags: 0x4
// Checksum 0x711347b1, Offset: 0xe8
// Size: 0x196
function private _updateevents() {
    waittime = 0.05;
    updatemillis = waittime * 1000;
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
// Checksum 0xdb3ff67b, Offset: 0x288
// Size: 0x1cc
function addblackboardevent(eventname, data, timetoliveinmillis) {
    /#
        /#
            assert(isstring(eventname), "<dev string:x28>");
        #/
        /#
            assert(isdefined(data), "<dev string:x6b>");
        #/
        /#
            assert(isint(timetoliveinmillis) && timetoliveinmillis > 0, "<dev string:xa0>");
        #/
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
// Checksum 0xe0b9531d, Offset: 0x460
// Size: 0x38
function getblackboardevents(eventname) {
    if (isdefined(level.__ai_blackboard[eventname])) {
        return level.__ai_blackboard[eventname];
    }
    return [];
}

// Namespace blackboard/ai_blackboard
// Params 1, eflags: 0x0
// Checksum 0x198f68ac, Offset: 0x4a0
// Size: 0x34
function removeblackboardevents(eventname) {
    if (isdefined(level.__ai_blackboard[eventname])) {
        level.__ai_blackboard[eventname] = undefined;
    }
}

