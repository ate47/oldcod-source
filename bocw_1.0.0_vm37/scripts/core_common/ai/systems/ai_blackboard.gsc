#namespace blackboard;

// Namespace blackboard/ai_blackboard
// Params 0, eflags: 0x2
// Checksum 0x9c85b188, Offset: 0x60
// Size: 0x14
function autoexec main() {
    _initializeblackboard();
}

// Namespace blackboard/ai_blackboard
// Params 0, eflags: 0x4
// Checksum 0x4fd45ccd, Offset: 0x80
// Size: 0x24
function private _initializeblackboard() {
    level.__ai_blackboard = [];
    level thread _updateevents();
}

// Namespace blackboard/ai_blackboard
// Params 0, eflags: 0x4
// Checksum 0x34893942, Offset: 0xb0
// Size: 0x1ae
function private _updateevents() {
    waittime = 1 * float(function_60d95f53()) / 1000;
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
// Checksum 0x791eaee7, Offset: 0x268
// Size: 0x1a2
function addblackboardevent(eventname, data, timetoliveinmillis) {
    /#
        assert(isstring(eventname) || ishash(eventname), "<dev string:x38>");
        assert(isdefined(data), "<dev string:x7e>");
        assert(isint(timetoliveinmillis) && timetoliveinmillis > 0, "<dev string:xb6>");
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
// Checksum 0x1ca5913b, Offset: 0x418
// Size: 0x34
function getblackboardevents(eventname) {
    if (isdefined(level.__ai_blackboard[eventname])) {
        return level.__ai_blackboard[eventname];
    }
    return [];
}

// Namespace blackboard/ai_blackboard
// Params 1, eflags: 0x0
// Checksum 0xdf4ed714, Offset: 0x458
// Size: 0x30
function removeblackboardevents(eventname) {
    if (isdefined(level.__ai_blackboard[eventname])) {
        level.__ai_blackboard[eventname] = undefined;
    }
}

