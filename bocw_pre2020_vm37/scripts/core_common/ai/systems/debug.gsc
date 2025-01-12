#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace as_debug;

/#

    // Namespace as_debug/debug
    // Params 0, eflags: 0x6
    // Checksum 0x66b73922, Offset: 0x70
    // Size: 0x3c
    function private autoexec __init__system__() {
        system::register(#"as_debug", &function_70a657d8, undefined, undefined, undefined);
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x4
    // Checksum 0xe72cba84, Offset: 0xb8
    // Size: 0x34
    function private function_70a657d8() {
        util::init_dvar("<dev string:x38>", 0, &delete_all_ai_corpses);
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0x744ebf4d, Offset: 0xf8
    // Size: 0x4e
    function isdebugon() {
        return getdvarint(#"animdebug", 0) == 1 || level.animation.debugent === self;
    }

    // Namespace as_debug/debug
    // Params 4, eflags: 0x0
    // Checksum 0x282ab0b7, Offset: 0x150
    // Size: 0x62
    function drawdebuglineinternal(frompoint, topoint, color, durationframes) {
        for (i = 0; i < durationframes; i++) {
            line(frompoint, topoint, color);
            waitframe(1);
        }
    }

    // Namespace as_debug/debug
    // Params 4, eflags: 0x0
    // Checksum 0x4931cb51, Offset: 0x1c0
    // Size: 0x5c
    function drawdebugline(frompoint, topoint, color, durationframes) {
        if (isdebugon()) {
            thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
        }
    }

    // Namespace as_debug/debug
    // Params 4, eflags: 0x0
    // Checksum 0x12b597c6, Offset: 0x228
    // Size: 0x6a
    function debugline(frompoint, topoint, color, durationframes) {
        for (i = 0; i < durationframes * 20; i++) {
            line(frompoint, topoint, color);
            waitframe(1);
        }
    }

    // Namespace as_debug/debug
    // Params 4, eflags: 0x0
    // Checksum 0x35458083, Offset: 0x2a0
    // Size: 0x13c
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
    // Checksum 0xc6b52665, Offset: 0x3e8
    // Size: 0xa6
    function updatedebuginfo() {
        self endon(#"death");
        self.debuginfo = spawnstruct();
        self.debuginfo.enabled = getdvarint(#"ai_debuganimscript", 0) > 0;
        debugclearstate();
        while (true) {
            waitframe(1);
            updatedebuginfointernal();
            waitframe(1);
        }
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0x7f74b733, Offset: 0x498
    // Size: 0x10e
    function updatedebuginfointernal() {
        if (level.animation.debugent === self) {
            doinfo = 1;
            return;
        }
        doinfo = getdvarint(#"ai_debuganimscript", 0) > 0;
        if (doinfo) {
            ai_entnum = getdvarint(#"ai_debugentindex", 0);
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
    // Checksum 0x272ba290, Offset: 0x5b0
    // Size: 0x12c
    function drawdebugenttext(text, ent, color, channel) {
        assert(isdefined(ent));
        if (!getdvarint(#"recorder_enablerec", 0)) {
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
    // Checksum 0x1f1aaab4, Offset: 0x6e8
    // Size: 0x188
    function debugpushstate(statename, extrainfo) {
        if (!getdvarint(#"ai_debuganimscript", 0)) {
            return;
        }
        ai_entnum = getdvarint(#"ai_debugentindex", 0);
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
            state.extrainfo = extrainfo + "<dev string:x52>";
        }
        self.debuginfo.states[self.debuginfo.states.size] = state;
    }

    // Namespace as_debug/debug
    // Params 2, eflags: 0x0
    // Checksum 0x8220e1ca, Offset: 0x878
    // Size: 0x2e6
    function debugaddstateinfo(statename, extrainfo) {
        if (!getdvarint(#"ai_debuganimscript", 0)) {
            return;
        }
        ai_entnum = getdvarint(#"ai_debugentindex", 0);
        if (ai_entnum > -1 && ai_entnum != self getentitynumber()) {
            return;
        }
        assert(isdefined(self.debuginfo.states));
        if (isdefined(statename)) {
            for (i = self.debuginfo.states.size - 1; i >= 0; i--) {
                assert(isdefined(self.debuginfo.states[i]));
                if (self.debuginfo.states[i].statename == statename) {
                    if (!isdefined(self.debuginfo.states[i].extrainfo)) {
                        self.debuginfo.states[i].extrainfo = "<dev string:x57>";
                    }
                    self.debuginfo.states[i].extrainfo = self.debuginfo.states[i].extrainfo + extrainfo + "<dev string:x52>";
                    break;
                }
            }
            return;
        }
        if (self.debuginfo.states.size > 0) {
            lastindex = self.debuginfo.states.size - 1;
            assert(isdefined(self.debuginfo.states[lastindex]));
            if (!isdefined(self.debuginfo.states[lastindex].extrainfo)) {
                self.debuginfo.states[lastindex].extrainfo = "<dev string:x57>";
            }
            self.debuginfo.states[lastindex].extrainfo = self.debuginfo.states[lastindex].extrainfo + extrainfo + "<dev string:x52>";
        }
    }

    // Namespace as_debug/debug
    // Params 2, eflags: 0x0
    // Checksum 0x73eef946, Offset: 0xb68
    // Size: 0x334
    function debugpopstate(statename, exitreason) {
        if (!getdvarint(#"ai_debuganimscript", 0) || self.debuginfo.states.size <= 0) {
            return;
        }
        ai_entnum = getdvarint(#"ai_debugentindex", 0);
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
    // Checksum 0x566919da, Offset: 0xea8
    // Size: 0x3a
    function debugclearstate() {
        self.debuginfo.states = [];
        self.debuginfo.statelevel = 0;
        self.debuginfo.shouldclearonanimscriptchange = 0;
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0x265c3eb4, Offset: 0xef0
    // Size: 0x4a
    function debugshouldclearstate() {
        if (isdefined(self.debuginfo) && isdefined(self.debuginfo.shouldclearonanimscriptchange) && self.debuginfo.shouldclearonanimscriptchange) {
            return 1;
        }
        return 0;
    }

    // Namespace as_debug/debug
    // Params 0, eflags: 0x0
    // Checksum 0xc50daa06, Offset: 0xf48
    // Size: 0x96
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
    // Checksum 0x9a6cf29e, Offset: 0xfe8
    // Size: 0x56
    function indent(depth) {
        indent = "<dev string:x57>";
        for (i = 0; i < depth; i++) {
            indent += "<dev string:x52>";
        }
        return indent;
    }

    // Namespace as_debug/debug
    // Params 3, eflags: 0x0
    // Checksum 0x116c5fdf, Offset: 0x1048
    // Size: 0xcc
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
    // Checksum 0x4665effe, Offset: 0x1120
    // Size: 0x154
    function debugdrawweightedpoint(entity, point, weight, lowestvalue, highestvalue) {
        deltavalue = highestvalue - lowestvalue;
        halfdeltavalue = deltavalue / 2;
        midvalue = lowestvalue + deltavalue / 2;
        if (halfdeltavalue == 0) {
            halfdeltavalue = 1;
        }
        if (weight <= midvalue) {
            redcolor = 1 - abs((weight - lowestvalue) / halfdeltavalue);
            recordcircle(point, 2, (redcolor, 0, 0), "<dev string:x5b>", entity);
            return;
        }
        greencolor = 1 - abs((highestvalue - weight) / halfdeltavalue);
        recordcircle(point, 2, (0, greencolor, 0), "<dev string:x5b>", entity);
    }

    // Namespace as_debug/debug
    // Params 1, eflags: 0x0
    // Checksum 0xdabc31cb, Offset: 0x1280
    // Size: 0xfc
    function delete_all_ai_corpses(params) {
        if (params.value) {
            corpses = getcorpsearray();
            foreach (corpse in corpses) {
                if (isactorcorpse(corpse)) {
                    corpse delete();
                }
            }
            setdvar(#"debug_ai_clear_corpses", 0);
        }
    }

#/
