#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/system_shared;

#namespace as_debug;

/#

    // Namespace as_debug/debug
    // Params 0, eflags: 0x2
    // Checksum 0x79cf96d5, Offset: 0xd8
    // Size: 0x34
    function autoexec __init__sytem__() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0xb5eb2747, Offset: 0x118
    // Size: 0x1c
    function __init__() {
        level thread debugdvars();
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0xfd98a06a, Offset: 0x140
    // Size: 0x4e
    function debugdvars() {
        while (true) {
            if (getdvarint("<dev string:x31>", 0)) {
                delete_all_ai_corpses();
            }
            waitframe(1);
        }
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0x17abc4e1, Offset: 0x198
    // Size: 0x4c
    function isdebugon() {
        return isdefined(anim.debugent) && (getdvarint("<dev string:x48>") == 1 || anim.debugent == self);
    }

    // Namespace as_debug/debug
    // Params 4, eflags: 0x0
    // Checksum 0xc4a5436b, Offset: 0x1f0
    // Size: 0x74
    function drawdebuglineinternal(frompoint, topoint, color, durationframes) {
        for (i = 0; i < durationframes; i++) {
            line(frompoint, topoint, color);
            waitframe(1);
        }
    }

    // Namespace as_debug/debug
    // Params 4, eflags: 0x0
    // Checksum 0x2d2c17f2, Offset: 0x270
    // Size: 0x64
    function drawdebugline(frompoint, topoint, color, durationframes) {
        if (isdebugon()) {
            thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
        }
    }

    // Namespace as_debug/debug
    // Params 4, eflags: 0x0
    // Checksum 0x9c861f6f, Offset: 0x2e0
    // Size: 0x7c
    function debugline(frompoint, topoint, color, durationframes) {
        for (i = 0; i < durationframes * 20; i++) {
            line(frompoint, topoint, color);
            waitframe(1);
        }
    }

    // Namespace as_debug/debug
    // Params 4, eflags: 0x0
    // Checksum 0x5cc05a2e, Offset: 0x368
    // Size: 0x154
    function drawdebugcross(atpoint, radius, color, durationframes) {
        atpoint_high = atpoint + (0, 0, radius);
        atpoint_low = atpoint + (0, 0, -1 * radius);
        atpoint_left = atpoint + (0, radius, 0);
        atpoint_right = atpoint + (0, -1 * radius, 0);
        atpoint_forward = atpoint + (radius, 0, 0);
        atpoint_back = atpoint + (-1 * radius, 0, 0);
        thread debugline(atpoint_high, atpoint_low, color, durationframes);
        thread debugline(atpoint_left, atpoint_right, color, durationframes);
        thread debugline(atpoint_forward, atpoint_back, color, durationframes);
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0x9ee3525d, Offset: 0x4c8
    // Size: 0x96
    function updatedebuginfo() {
        self endon(#"death");
        self.debuginfo = spawnstruct();
        self.debuginfo.enabled = getdvarint("<dev string:x52>") > 0;
        debugclearstate();
        while (true) {
            waitframe(1);
            updatedebuginfointernal();
            waitframe(1);
        }
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0x3317b027, Offset: 0x568
    // Size: 0x110
    function updatedebuginfointernal() {
        if (isdefined(anim.debugent) && anim.debugent == self) {
            doinfo = 1;
            return;
        }
        doinfo = getdvarint("<dev string:x52>") > 0;
        if (doinfo) {
            ai_entnum = getdvarint("<dev string:x65>");
            if (ai_entnum > -1 && ai_entnum != self getentitynumber()) {
                doinfo = 0;
            }
        }
        if (!self.debuginfo.enabled && doinfo) {
            self.debuginfo.shouldclearonanimscriptchange = 1;
        }
        self.debuginfo.enabled = doinfo;
    }

    // Namespace as_debug/debug
    // Params 4, eflags: 0x0
    // Checksum 0x167bd32f, Offset: 0x680
    // Size: 0x144
    function drawdebugenttext(text, ent, color, channel) {
        assert(isdefined(ent));
        if (!getdvarint("<dev string:x76>")) {
            if (!isdefined(ent.debuganimscripttime) || gettime() > ent.debuganimscripttime) {
                ent.debuganimscriptlevel = 0;
                ent.debuganimscripttime = gettime();
            }
            indentlevel = vectorscale((0, 0, -10), ent.debuganimscriptlevel);
            print3d(self.origin + (0, 0, 70) + indentlevel, text, color);
            ent.debuganimscriptlevel++;
            return;
        }
        recordenttext(text, ent, color, channel);
    }

    // Namespace as_debug/debug
    // Params 2, eflags: 0x0
    // Checksum 0x279bc636, Offset: 0x7d0
    // Size: 0x1b2
    function debugpushstate(statename, extrainfo) {
        if (!getdvarint("<dev string:x52>")) {
            return;
        }
        ai_entnum = getdvarint("<dev string:x65>");
        if (ai_entnum > -1 && ai_entnum != self getentitynumber()) {
            return;
        }
        assert(isdefined(self.debuginfo.states));
        assert(isdefined(statename));
        state = spawnstruct();
        state.statename = statename;
        state.statelevel = self.debuginfo.statelevel;
        state.statetime = gettime();
        state.statevalid = 1;
        self.debuginfo.statelevel++;
        if (isdefined(extrainfo)) {
            state.extrainfo = extrainfo + "<dev string:x89>";
        }
        self.debuginfo.states[self.debuginfo.states.size] = state;
    }

    // Namespace as_debug/debug
    // Params 2, eflags: 0x0
    // Checksum 0x86a234f8, Offset: 0x990
    // Size: 0x310
    function debugaddstateinfo(statename, extrainfo) {
        if (!getdvarint("<dev string:x52>")) {
            return;
        }
        ai_entnum = getdvarint("<dev string:x65>");
        if (ai_entnum > -1 && ai_entnum != self getentitynumber()) {
            return;
        }
        assert(isdefined(self.debuginfo.states));
        if (isdefined(statename)) {
            for (i = self.debuginfo.states.size - 1; i >= 0; i--) {
                assert(isdefined(self.debuginfo.states[i]));
                if (self.debuginfo.states[i].statename == statename) {
                    if (!isdefined(self.debuginfo.states[i].extrainfo)) {
                        self.debuginfo.states[i].extrainfo = "<dev string:x8b>";
                    }
                    self.debuginfo.states[i].extrainfo = self.debuginfo.states[i].extrainfo + extrainfo + "<dev string:x89>";
                    break;
                }
            }
            return;
        }
        if (self.debuginfo.states.size > 0) {
            lastindex = self.debuginfo.states.size - 1;
            assert(isdefined(self.debuginfo.states[lastindex]));
            if (!isdefined(self.debuginfo.states[lastindex].extrainfo)) {
                self.debuginfo.states[lastindex].extrainfo = "<dev string:x8b>";
            }
            self.debuginfo.states[lastindex].extrainfo = self.debuginfo.states[lastindex].extrainfo + extrainfo + "<dev string:x89>";
        }
    }

    // Namespace as_debug/debug
    // Params 2, eflags: 0x0
    // Checksum 0xa1d71366, Offset: 0xca8
    // Size: 0x37a
    function debugpopstate(statename, exitreason) {
        if (!getdvarint("<dev string:x52>") || self.debuginfo.states.size <= 0) {
            return;
        }
        ai_entnum = getdvarint("<dev string:x65>");
        if (!isdefined(self) || !isalive(self)) {
            return;
        }
        if (ai_entnum > -1 && ai_entnum != self getentitynumber()) {
            return;
        }
        assert(isdefined(self.debuginfo.states));
        if (isdefined(statename)) {
            for (i = 0; i < self.debuginfo.states.size; i++) {
                if (self.debuginfo.states[i].statename == statename && self.debuginfo.states[i].statevalid) {
                    self.debuginfo.states[i].statevalid = 0;
                    self.debuginfo.states[i].exitreason = exitreason;
                    self.debuginfo.statelevel = self.debuginfo.states[i].statelevel;
                    for (j = i + 1; j < self.debuginfo.states.size && self.debuginfo.states[j].statelevel > self.debuginfo.states[i].statelevel; j++) {
                        self.debuginfo.states[j].statevalid = 0;
                    }
                    break;
                }
            }
            return;
        }
        for (i = self.debuginfo.states.size - 1; i >= 0; i--) {
            if (self.debuginfo.states[i].statevalid) {
                self.debuginfo.states[i].statevalid = 0;
                self.debuginfo.states[i].exitreason = exitreason;
                self.debuginfo.statelevel--;
                break;
            }
        }
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0x9837188e, Offset: 0x1030
    // Size: 0x44
    function debugclearstate() {
        self.debuginfo.states = [];
        self.debuginfo.statelevel = 0;
        self.debuginfo.shouldclearonanimscriptchange = 0;
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0x27d90065, Offset: 0x1080
    // Size: 0x50
    function debugshouldclearstate() {
        if (isdefined(self.debuginfo) && isdefined(self.debuginfo.shouldclearonanimscriptchange) && self.debuginfo.shouldclearonanimscriptchange) {
            return 1;
        }
        return 0;
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0xff852ce8, Offset: 0x10d8
    // Size: 0xb0
    function debugcleanstatestack() {
        newarray = [];
        for (i = 0; i < self.debuginfo.states.size; i++) {
            if (self.debuginfo.states[i].statevalid) {
                newarray[newarray.size] = self.debuginfo.states[i];
            }
        }
        self.debuginfo.states = newarray;
    }

    // Namespace as_debug/debug
    // Params 1, eflags: 0x0
    // Checksum 0xb754697c, Offset: 0x1190
    // Size: 0x66
    function indent(depth) {
        indent = "<dev string:x8b>";
        for (i = 0; i < depth; i++) {
            indent += "<dev string:x89>";
        }
        return indent;
    }

    // Namespace as_debug/debug
    // Params 3, eflags: 0x0
    // Checksum 0x5d1128b6, Offset: 0x1200
    // Size: 0x106
    function debugdrawweightedpoints(entity, points, weights) {
        lowestvalue = 0;
        highestvalue = 0;
        for (index = 0; index < points.size; index++) {
            if (weights[index] < lowestvalue) {
                lowestvalue = weights[index];
            }
            if (weights[index] > highestvalue) {
                highestvalue = weights[index];
            }
        }
        for (index = 0; index < points.size; index++) {
            debugdrawweightedpoint(entity, points[index], weights[index], lowestvalue, highestvalue);
        }
    }

    // Namespace as_debug/debug
    // Params 5, eflags: 0x0
    // Checksum 0xacfda432, Offset: 0x1310
    // Size: 0x174
    function debugdrawweightedpoint(entity, point, weight, lowestvalue, highestvalue) {
        deltavalue = highestvalue - lowestvalue;
        halfdeltavalue = deltavalue / 2;
        midvalue = lowestvalue + deltavalue / 2;
        if (halfdeltavalue == 0) {
            halfdeltavalue = 1;
        }
        if (weight <= midvalue) {
            redcolor = 1 - abs((weight - lowestvalue) / halfdeltavalue);
            recordcircle(point, 2, (redcolor, 0, 0), "<dev string:x8c>", entity);
            return;
        }
        greencolor = 1 - abs((highestvalue - weight) / halfdeltavalue);
        recordcircle(point, 2, (0, greencolor, 0), "<dev string:x8c>", entity);
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0x8910aa17, Offset: 0x1490
    // Size: 0xda
    function delete_all_ai_corpses() {
        setdvar("<dev string:x31>", 0);
        corpses = getcorpsearray();
        foreach (corpse in corpses) {
            if (isactorcorpse(corpse)) {
                corpse delete();
            }
        }
    }

#/
