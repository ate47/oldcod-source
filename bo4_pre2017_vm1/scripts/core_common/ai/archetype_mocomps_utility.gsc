#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/animation_state_machine_mocomp;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;

#namespace archetype_mocomps_utility;

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 0, eflags: 0x2
// Checksum 0x25e3b271, Offset: 0x368
// Size: 0x13c
function autoexec registerdefaultanimationmocomps() {
    animationstatenetwork::registeranimationmocomp("adjust_to_cover", &mocompadjusttocoverinit, &mocompadjusttocoverupdate, &mocompadjusttocoverterminate);
    animationstatenetwork::registeranimationmocomp("locomotion_explosion_death", &mocomplocoexplosioninit, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_flank_stand", &mocompflankstandinit, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_traversal_procedural", &mocomptraversalproceduralinit, &mocomptraversalproceduralpivotupdate, &mocomptraversalproceduralpivotterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_traversal_procedural_pivot", &mocomptraversalproceduralpivotinit, &mocomptraversalproceduralpivotupdate, &mocomptraversalproceduralpivotterminate);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 6, eflags: 0x4
// Checksum 0xa41905a7, Offset: 0x4b0
// Size: 0x42e
function private drawtraversal(traversal, entity, animation, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (getdvarint("ai_debugVolumeTool") <= 1) {
        return;
    }
    /#
        recordsphere(traversal.startposition, 2, (1, 0.5, 0), "<dev string:x28>", entity);
        recordsphere(traversal.endposition, 2, (1, 0.5, 0), "<dev string:x28>", entity);
    #/
    animlength = getanimlength(animation);
    currentposition = traversal.startposition;
    nextposition = currentposition;
    segments = 0;
    for (segmenttime = 0; segmenttime <= animlength; segmenttime += 0.05) {
        nexttime = segmenttime + 0.05;
        if (nexttime > animlength) {
            nexttime = animlength;
        }
        movedelta = getmovedelta(animation, segmenttime / animlength, nexttime / animlength);
        nextposition = currentposition + rotatepoint(movedelta, traversal.startangles);
        /#
            recordline(currentposition, nextposition, (1, 0.5, 0), "<dev string:x28>", entity);
        #/
        currentposition = nextposition;
    }
    /#
        recordsphere(nextposition, 2, (1, 0, 0), "<dev string:x28>", entity);
    #/
    if (isdefined(traversal.mantlenode)) {
        edgepoints = getnodeedge(traversal.mantlenode);
        for (index = 1; index < edgepoints.size; index++) {
            /#
                recordline(edgepoints[index - 1], edgepoints[index], (1, 0, 0), "<dev string:x28>", entity);
            #/
        }
    }
    edgepoints = getnodeedge(traversal.startnode);
    for (index = 1; index < edgepoints.size; index++) {
        /#
            recordline(edgepoints[index - 1], edgepoints[index], (1, 0, 0), "<dev string:x28>", entity);
        #/
    }
    edgepoints = getnodeedge(traversal.endnode);
    for (index = 1; index < edgepoints.size; index++) {
        /#
            recordline(edgepoints[index - 1], edgepoints[index], (1, 0, 0), "<dev string:x28>", entity);
        #/
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 6, eflags: 0x4
// Checksum 0x46fc6751, Offset: 0x8e8
// Size: 0x3f6
function private drawtraversalsection(section, entity, animation, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (getdvarint("ai_debugVolumeTool") <= 1) {
        return;
    }
    /#
        recordsphere(section.startposition, 2, (1, 0.5, 0), "<dev string:x28>", entity);
        recordsphere(section.endposition, 2, (1, 0.5, 0), "<dev string:x28>", entity);
        recordsphere(section.mocompstartposition, 2, (0, 1, 0), "<dev string:x28>", entity);
        recordsphere(section.adjustedmocompendposition, 2, (0, 1, 0), "<dev string:x28>", entity);
    #/
    animlength = getanimlength(animation);
    currentposition = section.startposition;
    nextposition = currentposition;
    segments = 0;
    deltatoendtotal = (0, 0, 0);
    for (segmenttime = section.starttime; segmenttime <= section.endtime; segmenttime += 0.05) {
        nexttime = segmenttime + 0.05;
        if (nexttime > section.endtime) {
            nexttime = section.endtime;
        }
        movedelta = getmovedelta(animation, segmenttime / animlength, nexttime / animlength);
        nextposition = currentposition + rotatepoint(movedelta, section.startangles);
        if (nexttime >= section.mocompstarttime && lengthsquared(deltatoendtotal) < lengthsquared(section.deltatoendposition)) {
            adjusteddeltaperframe = section.adjusteddeltaperframe;
            deltatoendtotal += adjusteddeltaperframe;
            if (lengthsquared(deltatoendtotal) > lengthsquared(section.deltatoendposition)) {
                adjusteddeltaperframe -= deltatoendtotal - section.deltatoendposition;
            }
            nextposition += adjusteddeltaperframe;
            /#
                recordline(currentposition, nextposition, (0, 1, 0), "<dev string:x28>", entity);
            #/
        } else {
            /#
                recordline(currentposition, nextposition, (1, 0.5, 0), "<dev string:x28>", entity);
            #/
        }
        currentposition = nextposition;
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 8, eflags: 0x4
// Checksum 0xbfa5d905, Offset: 0xce8
// Size: 0x7b0
function private calculatetraveralsection(entity, traversal, animation, starttime, endtime, startposition, endposition, startangles) {
    /#
        assert(endtime >= starttime);
    #/
    animlength = getanimlength(animation);
    section = spawnstruct();
    section.starttime = starttime;
    section.starttimenormalized = section.starttime / animlength;
    section.endtime = endtime;
    section.length = section.endtime - section.starttime;
    section.startangles = startangles;
    section.startposition = startposition;
    section.endposition = endposition;
    section.mocompstarttime = starttime;
    starttimes = getnotetracktimes(animation, "start_procedural");
    if (isdefined(starttimes) && starttimes.size > 0) {
        for (index = 0; index < starttimes.size; index++) {
            mocomptime = starttimes[index] * animlength;
            if (mocomptime >= starttime && mocomptime <= endtime) {
                section.mocompstarttime = mocomptime;
            }
        }
    }
    section.mocompendtime = endtime;
    endtimes = getnotetracktimes(animation, "stop_procedural");
    if (isdefined(endtimes) && endtimes.size > 0) {
        for (index = 0; index < endtimes.size; index++) {
            mocomptime = endtimes[index] * animlength;
            if (mocomptime >= starttime && mocomptime <= endtime) {
                section.mocompendtime = mocomptime;
            }
        }
    }
    section.mocomptimelength = section.mocompendtime - section.mocompstarttime;
    section.mocomptimeinframes = floor(section.mocomptimelength / 0.05);
    movedelta = getmovedelta(animation, section.starttimenormalized, section.mocompstarttime / animlength);
    section.mocompstartposition = section.startposition + rotatepoint(movedelta, section.startangles);
    movedelta = getmovedelta(animation, section.starttimenormalized, section.mocompendtime / animlength);
    section.mocompendposition = section.startposition + rotatepoint(movedelta, section.startangles);
    section.animationendposition = section.startposition + rotatepoint(getmovedelta(animation, section.starttimenormalized, section.endtime / animlength), section.startangles);
    section.deltatoendposition = section.endposition - section.animationendposition;
    section.deltatoendmocompposition = section.mocompendposition - section.mocompstartposition;
    section.adjustedmocompendposition = section.mocompendposition + section.deltatoendposition;
    section.adjusteddeltaperframe = section.deltatoendposition / section.mocomptimeinframes;
    section.deltatoendmocomplength = length(section.deltatoendmocompposition);
    section.deltatoendmocomplengthdesired = length(section.deltatoendposition + section.deltatoendmocompposition);
    section.deltatoendmocompmultiplier = section.deltatoendmocomplength / section.deltatoendmocomplengthdesired;
    section.deltatoendmocompmultiplier = max(0.01, float(int(section.deltatoendmocompmultiplier * 10)) / 10);
    section.deltatoendtotal = (0, 0, 0);
    if (isdefined(traversal.pivotorigin) && isdefined(traversal.pivottime)) {
        startposition = section.startposition;
        endposition = section.endposition;
        if (section.starttime < traversal.pivottime) {
            endposition = traversal.pivotorigin;
        } else {
            startposition = traversal.pivotorigin;
        }
        if ((endposition - startposition)[2] <= 0 && section.deltatoendmocompmultiplier < 1) {
            section.deltatoendmocompmultiplier = 1;
        }
    } else if ((section.endposition - section.startposition)[2] <= 0 && section.deltatoendmocompmultiplier < 1) {
        section.deltatoendmocompmultiplier = 1;
    }
    return section;
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 3, eflags: 0x0
// Checksum 0x174821ae, Offset: 0x14a0
// Size: 0x5b0
function calculatepivotoriginfromedge(entity, mantlenode, traversalstart) {
    /#
        assert(isvec(traversalstart));
    #/
    mantlepoints = getnodeedge(mantlenode);
    mantlestart = undefined;
    mantleend = undefined;
    if (mantlepoints.size > 0) {
        /#
            assert(isarray(mantlepoints));
        #/
        /#
            assert(mantlepoints.size >= 2);
        #/
        mantlestart = mantlepoints[0];
        mantleend = mantlepoints[mantlepoints.size - 1];
    } else {
        right = anglestoright(mantlenode.angles);
        extents = mantlenode.aabb_extents;
        mantlestart = mantlenode.origin - right * extents[1];
        mantleend = mantlenode.origin + right * extents[1];
    }
    mantlestartproj = mantlestart;
    mantleendproj = (mantleend[0], mantleend[1], mantlestartproj[2]);
    traversalstartproj = (traversalstart[0], traversalstart[1], mantlestartproj[2]);
    tomantleendproj = mantleendproj - mantlestartproj;
    totraversalproj = traversalstartproj - mantlestartproj;
    mantleoriginproj = mantlestartproj + vectorprojection(totraversalproj, tomantleendproj);
    if (mantlepoints.size > 0) {
        mantleedgelength = length(mantleendproj - mantlestartproj);
        time = length(mantleoriginproj - mantlestartproj) / mantleedgelength;
        mantleorigin = mantlepoints[0];
        for (index = 1; index < mantlepoints.size; index++) {
            endpoint = mantlepoints[index];
            endpointproj = (endpoint[0], endpoint[1], mantlestartproj[2]);
            endpointtime = length(endpointproj - mantlestartproj) / mantleedgelength;
            if (endpointtime > time) {
                startpoint = mantlepoints[index - 1];
                startpointproj = (startpoint[0], startpoint[1], mantlestartproj[2]);
                startpointtime = length(startpointproj - mantlestartproj) / mantleedgelength;
                timedelta = time - startpointtime;
                mantleorigin = startpoint + (endpoint - startpoint) * timedelta / (endpointtime - startpointtime);
                break;
            }
        }
    } else {
        mantleorigin = physicstraceex(mantleoriginproj + (0, 0, mantlenode.aabb_extents[2]), mantleoriginproj - (0, 0, mantlenode.aabb_extents[2]), (0, 0, 0), (0, 0, 0), entity)["position"];
    }
    /#
        recordline(mantleoriginproj, mantleendproj, (0, 0, 1), "<dev string:x28>", entity);
        recordline(mantlestartproj, traversalstartproj, (0, 0, 1), "<dev string:x28>", entity);
        recordline(traversalstartproj, mantleoriginproj, (0, 0, 1), "<dev string:x28>", entity);
        recordline(mantlestart, mantleend, (1, 0, 0), "<dev string:x28>", entity);
        recordline(mantlestart, mantleoriginproj, (1, 0, 0), "<dev string:x28>", entity);
        recordline(mantleoriginproj, mantleorigin, (1, 0, 0), "<dev string:x28>", entity);
    #/
    return mantleorigin;
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0x29b5c49e, Offset: 0x1a58
// Size: 0x504
function private mocomptraversalproceduralinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    traversal = spawnstruct();
    traversal.startnode = entity.traversestartnode;
    traversal.endnode = entity.traverseendnode;
    traversal.initialanimationrate = 1;
    traversal.animlength = getanimlength(mocompanim);
    traversal.actualanimlength = traversal.animlength - mocompanimblendouttime;
    traversal.startposition = entity.origin;
    traversal.adjustedendposition = entity.traversalendpos;
    traversal.traversalforward = traversal.adjustedendposition - traversal.startposition;
    traversal.traversalforward = (traversal.traversalforward[0], traversal.traversalforward[1], 0);
    traversal.startangles = vectortoangles(traversal.traversalforward);
    traversal.endposition = traversal.startposition + rotatepoint(getmovedelta(mocompanim, 0, traversal.actualanimlength / traversal.animlength), traversal.startangles);
    if (isdefined(traversal.endnode.script_linkname)) {
        traversal.endnodeparent = getent(traversal.endnode.script_linkname, "targetname");
        if (isdefined(traversal.endnodeparent)) {
            traversal.origincontents = entity setcontents(8192);
            traversal.lastendnodeparentorigin = traversal.endnodeparent.origin;
            traversal.adjustedendposition = physicstraceex(entity.traversalendpos + (0, 0, 24), entity.traversalendpos - (0, 0, 24), (0, 0, 0), (0, 0, 0), entity)["position"];
        }
    }
    traversal.sections = [];
    traversal.sections[traversal.sections.size] = calculatetraveralsection(entity, traversal, mocompanim, 0, traversal.actualanimlength, traversal.startposition, traversal.adjustedendposition, traversal.startangles);
    traversal.lastanimtime = 0;
    entity.traversal = traversal;
    entity setrepairpaths(0);
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity.lasttraversalanimation = mocompanim;
    entity.lasttraversalblendout = mocompanimblendouttime;
    entity.lasttraversalstartpos = traversal.startposition;
    entity.lasttraversalendpos = traversal.adjustedendposition;
    entity.lasttraversalpivot = undefined;
    entity orientmode("face angle", traversal.startangles[1]);
    entity animmode("angle deltas noclip", 0);
    mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0x34df00af, Offset: 0x1f68
// Size: 0x88c
function private mocomptraversalproceduralpivotinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    traversal = spawnstruct();
    traversal.startnode = entity.traversestartnode;
    traversal.endnode = entity.traverseendnode;
    traversal.mantlenode = entity.traversemantlenode;
    traversal.initialanimationrate = 1;
    traversal.animlength = getanimlength(mocompanim);
    traversal.actualanimlength = traversal.animlength - mocompanimblendouttime;
    traversal.startposition = entity.origin;
    traversal.adjustedendposition = entity.traversalendpos;
    traversal.traversalforward = traversal.adjustedendposition - traversal.startposition;
    traversal.traversalforward = (traversal.traversalforward[0], traversal.traversalforward[1], 0);
    traversal.startangles = vectortoangles(traversal.traversalforward);
    traversal.endposition = traversal.startposition + rotatepoint(getmovedelta(mocompanim, 0, traversal.actualanimlength / traversal.animlength), traversal.startangles);
    if (isdefined(traversal.endnode.script_linkname)) {
        traversal.endnodeparent = getent(traversal.endnode.script_linkname, "targetname");
        if (isdefined(traversal.endnodeparent)) {
            traversal.origincontents = entity setcontents(8192);
            traversal.lastendnodeparentorigin = traversal.endnodeparent.origin;
            traversal.adjustedendposition = physicstraceex(entity.traversalendpos + (0, 0, 24), entity.traversalendpos - (0, 0, 24), (0, 0, 0), (0, 0, 0), entity)["position"];
        }
    }
    pivottimes = getnotetracktimes(mocompanim, "pivot_procedural");
    traversal.pivottime = traversal.actualanimlength / 2;
    if (isdefined(pivottimes) && pivottimes.size > 0) {
        traversal.pivottime = pivottimes[0] * traversal.animlength;
    }
    traversal.pivottime = floor(traversal.pivottime / 0.05) * 0.05;
    traversal.pivotorigin = calculatepivotoriginfromedge(entity, traversal.mantlenode, traversal.startposition);
    pivottagorigin = getanimtagorigin(mocompanim, 0, "tag_sync");
    animpivotorigin = traversal.pivotorigin;
    if (lengthsquared(pivottagorigin) > 0) {
        animpivotorigin = rotatepoint(pivottagorigin, traversal.startangles) + traversal.startposition;
    }
    pivotoffset = traversal.pivotorigin - animpivotorigin;
    pivotorigin = traversal.startposition + rotatepoint(getmovedelta(mocompanim, 0, traversal.pivottime / traversal.animlength), traversal.startangles) + pivotoffset;
    /#
        if (getdvarint("<dev string:x33>") > 1) {
            recordsphere(animpivotorigin, 2, (0, 0, 1), "<dev string:x28>", entity);
            recordline(traversal.pivotorigin, animpivotorigin, (1, 0, 0), "<dev string:x28>", entity);
            recordsphere(traversal.pivotorigin, 2, (1, 0, 0), "<dev string:x28>", entity);
        }
    #/
    traversal.sections = [];
    traversal.sections[traversal.sections.size] = calculatetraveralsection(entity, traversal, mocompanim, 0, traversal.pivottime, traversal.startposition, pivotorigin, traversal.startangles);
    traversal.sections[traversal.sections.size] = calculatetraveralsection(entity, traversal, mocompanim, traversal.pivottime, traversal.actualanimlength, pivotorigin, traversal.adjustedendposition, traversal.startangles);
    if (traversal.sections[0].deltatoendmocompmultiplier != 1) {
        traversal.sections[1].deltatoendmocompmultiplier = 1;
    }
    traversal.lastanimtime = 0;
    entity.traversal = traversal;
    entity setrepairpaths(0);
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity.lasttraversalanimation = mocompanim;
    entity.lasttraversalblendout = mocompanimblendouttime;
    entity.lasttraversalstartpos = traversal.startposition;
    entity.lasttraversalendpos = traversal.adjustedendposition;
    entity.lasttraversalpivot = traversal.pivotorigin;
    entity animmode("angle deltas noclip", 0);
    mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0x7ce77d5b, Offset: 0x2800
// Size: 0x54c
function private mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (!isalive(entity)) {
        return;
    }
    traversal = entity.traversal;
    /#
        drawtraversal(traversal, entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
        for (index = 0; index < traversal.sections.size; index++) {
            drawtraversalsection(traversal.sections[index], entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
        }
    #/
    traversal = entity.traversal;
    /#
        assert(isdefined(traversal));
    #/
    animationrate = traversal.initialanimationrate;
    adjusteddeltaperframe = (0, 0, 0);
    animationnextsteptime = entity getanimtime(mocompanim) * traversal.animlength;
    movedelta = getmovedelta(mocompanim, traversal.lastanimtime / traversal.animlength, animationnextsteptime / traversal.animlength);
    /#
        assert(traversal.sections.size > 0);
    #/
    section = traversal.sections[0];
    for (index = 0; index < traversal.sections.size; index++) {
        section = traversal.sections[index];
        if (section.starttime <= animationnextsteptime && section.endtime > animationnextsteptime) {
            break;
        }
    }
    if (traversal.lastanimtime >= section.mocompstarttime && lengthsquared(section.deltatoendtotal) < lengthsquared(section.deltatoendposition)) {
        animationtimedelta = (animationnextsteptime - traversal.lastanimtime) / 0.05;
        adjusteddeltaperframe = section.adjusteddeltaperframe * animationtimedelta;
        section.deltatoendtotal += adjusteddeltaperframe;
        if (traversal.lastanimtime <= section.mocompendtime && section.deltatoendmocompmultiplier < 1) {
            animationrate = traversal.initialanimationrate * section.deltatoendmocompmultiplier;
        }
        if (lengthsquared(section.deltatoendtotal) > lengthsquared(section.deltatoendposition)) {
            adjusteddeltaperframe -= section.deltatoendtotal - section.deltatoendposition;
        }
    }
    traversal.lastanimtime = animationnextsteptime;
    newentityorigin = entity.origin + rotatepoint(movedelta, traversal.startangles) + adjusteddeltaperframe;
    if (isdefined(traversal.endnodeparent)) {
        parentdelta = traversal.endnodeparent.origin - traversal.lastendnodeparentorigin;
        traversal.lastendnodeparentorigin = traversal.endnodeparent.origin;
        newentityorigin += parentdelta;
    }
    entity asmsetanimationrate(animationrate);
    entity forceteleport(newentityorigin, traversal.startangles, 0, 0);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0x22be1642, Offset: 0x2d58
// Size: 0x142
function private mocomptraversalproceduralpivotterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    traversal = entity.traversal;
    /#
        assert(isdefined(traversal));
    #/
    mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
    if (isdefined(traversal.origincontents)) {
        entity setcontents(traversal.origincontents);
    }
    entity asmsetanimationrate(traversal.initialanimationrate);
    entity finishtraversal();
    entity setrepairpaths(1);
    entity.blockingpain = 0;
    entity.usegoalanimweight = 0;
    entity.traversal = undefined;
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 0, eflags: 0x2
// Checksum 0x897af6ca, Offset: 0x2ea8
// Size: 0x694
function autoexec initadjusttocoverparams() {
    _addadjusttocover("human", "cover_any", "stance_any", 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.9, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8);
    _addadjusttocover("human", "cover_stand", "stance_any", 0.4, 0.8, 0.6, 0.4, 0.6, 0.3, 0.3, 0.6, 0.9, 0.6, 0.3, 0.4, 0.7, 0.6, 0.6, 0.6);
    _addadjusttocover("human", "cover_crouch", "stance_any", 0.4, 0.4, 0.4, 0.4, 0.8, 0.5, 0.2, 0.7, 0.9, 0.4, 0.2, 0.4, 0.5, 0.5, 0.5, 0.5);
    _addadjusttocover("human", "cover_left", "stand", 0.8, 0.4, 0.4, 0.4, 0.4, 0.7, 0.3, 0.5, 0.8, 0.8, 0.8, 0.9, 0.6, 0.6, 0.4, 0.4);
    _addadjusttocover("human", "cover_left", "crouch", 0.8, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.8, 0.8, 0.7, 0.6, 0.6, 0.4, 0.4);
    _addadjusttocover("human", "cover_right", "stand", 0.8, 0.4, 0.3, 0.4, 0.6, 0.8, 0.4, 0.4, 0.4, 0.4, 0.3, 0.4, 0.6, 0.6, 0.5, 0.4);
    _addadjusttocover("human", "cover_right", "crouch", 0.8, 0.4, 0.2, 0.4, 0.4, 0.7, 0.2, 0.3, 0.3, 0.5, 0.5, 0.7, 0.6, 0.6, 0.5, 0.4);
    _addadjusttocover("human", "cover_pillar", "stance_any", 0.8, 0.7, 0.6, 0.7, 0.6, 0.5, 0.4, 0.4, 0.4, 0.6, 0.4, 0.3, 0.7, 0.5, 0.1, 0.7);
    _addadjusttocover("robot", "cover_any", "stance_any", 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.6, 0.7, 0.5, 0.5, 0.5, 0.5, 0.4, 0.4, 0.4);
    _addadjusttocover("robot", "cover_exposed", "stance_any", 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.9, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 19, eflags: 0x4
// Checksum 0xe503f3c5, Offset: 0x3548
// Size: 0x252
function private _addadjusttocover(archetype, node, stance, rot2, rot32, rot3, rot36, rot6, rot69, rot9, rot98, rot8, rot87, rot7, rot47, rot4, rot14, rot1, rot21) {
    if (!isdefined(level.adjusttocover)) {
        level.adjusttocover = [];
    }
    if (!isdefined(level.adjusttocover[archetype])) {
        level.adjusttocover[archetype] = [];
    }
    if (!isdefined(level.adjusttocover[archetype][node])) {
        level.adjusttocover[archetype][node] = [];
    }
    directions = [];
    directions[2] = rot2;
    directions[32] = rot32;
    directions[3] = rot3;
    directions[63] = rot36;
    directions[6] = rot6;
    directions[96] = rot69;
    directions[9] = rot9;
    directions[89] = rot98;
    directions[8] = rot8;
    directions[78] = rot87;
    directions[7] = rot7;
    directions[47] = rot47;
    directions[4] = rot4;
    directions[14] = rot14;
    directions[1] = rot1;
    directions[21] = rot21;
    level.adjusttocover[archetype][node][stance] = directions;
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 4, eflags: 0x4
// Checksum 0x6eb96dcc, Offset: 0x37a8
// Size: 0x40a
function private _getadjusttocoverrotation(archetype, node, stance, angletonode) {
    /#
        assert(isarray(level.adjusttocover[archetype]));
    #/
    if (!isdefined(level.adjusttocover[archetype][node])) {
        node = "cover_any";
    }
    /#
        assert(isarray(level.adjusttocover[archetype][node]));
    #/
    if (!isdefined(level.adjusttocover[archetype][node][stance])) {
        stance = "stance_any";
    }
    /#
        assert(isarray(level.adjusttocover[archetype][node][stance]));
    #/
    /#
        assert(angletonode >= 0 && angletonode < 360);
    #/
    direction = undefined;
    if (angletonode < 11.25) {
        direction = 2;
    } else if (angletonode < 33.75) {
        direction = 32;
    } else if (angletonode < 56.25) {
        direction = 3;
    } else if (angletonode < 78.75) {
        direction = 63;
    } else if (angletonode < 101.25) {
        direction = 6;
    } else if (angletonode < 123.75) {
        direction = 96;
    } else if (angletonode < 146.25) {
        direction = 9;
    } else if (angletonode < 168.75) {
        direction = 89;
    } else if (angletonode < 191.25) {
        direction = 8;
    } else if (angletonode < 213.75) {
        direction = 78;
    } else if (angletonode < 236.25) {
        direction = 7;
    } else if (angletonode < 258.75) {
        direction = 47;
    } else if (angletonode < 281.25) {
        direction = 4;
    } else if (angletonode < 303.75) {
        direction = 14;
    } else if (angletonode < 326.25) {
        direction = 1;
    } else if (angletonode < 348.75) {
        direction = 21;
    } else {
        direction = 2;
    }
    /#
        assert(isdefined(level.adjusttocover[archetype][node][stance][direction]));
    #/
    adjusttime = level.adjusttocover[archetype][node][stance][direction];
    if (isdefined(adjusttime)) {
        return adjusttime;
    }
    return 0.8;
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 1, eflags: 0x4
// Checksum 0x67b245f6, Offset: 0x3bc0
// Size: 0x17e
function private debuglocoexplosion(entity) {
    entity endon(#"death");
    /#
        startorigin = entity.origin;
        startyawforward = anglestoforward((0, entity.angles[1], 0));
        damageyawforward = anglestoforward((0, entity.damageyaw - entity.angles[1], 0));
        starttime = gettime();
        while (gettime() - starttime < 10000) {
            recordsphere(startorigin, 5, (1, 0, 0), "<dev string:x28>", entity);
            recordline(startorigin, startorigin + startyawforward * 100, (0, 0, 1), "<dev string:x28>", entity);
            recordline(startorigin, startorigin + damageyawforward * 100, (1, 0, 0), "<dev string:x28>", entity);
            waitframe(1);
        }
    #/
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0x6e9820a7, Offset: 0x3d48
// Size: 0xfc
function private mocompflankstandinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("nogravity", 0);
    entity orientmode("face angle", entity.angles[1]);
    entity pathmode("move delayed", 0, randomfloatrange(0.5, 1));
    if (isdefined(entity.enemy)) {
        entity getperfectinfo(entity.enemy);
        entity.newenemyreaction = 0;
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0xd50ce7d3, Offset: 0x3e50
// Size: 0xbc
function private mocomplocoexplosioninit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("nogravity", 0);
    entity orientmode("face angle", entity.angles[1]);
    /#
        if (getdvarint("<dev string:x46>")) {
            entity thread debuglocoexplosion(entity);
        }
    #/
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0xfffcaab5, Offset: 0x3f18
// Size: 0x2a8
function private mocompadjusttocoverinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("angle deltas", 0);
    entity.blockingpain = 1;
    if (isdefined(entity.node)) {
        entity.adjustnode = entity.node;
        entity.nodeoffsetorigin = entity getnodeoffsetposition(entity.node);
        entity.nodeoffsetangles = entity getnodeoffsetangles(entity.node);
        entity.nodeoffsetforward = anglestoforward(entity.nodeoffsetangles);
        entity.nodeforward = anglestoforward(entity.node.angles);
        entity.nodefinalstance = entity getblackboardattribute("_desired_stance");
        covertype = entity getblackboardattribute("_cover_type");
        if (!isdefined(entity.nodefinalstance)) {
            entity.nodefinalstance = aiutility::gethighestnodestance(entity.adjustnode);
        }
        angledifference = floor(absangleclamp360(entity.angles[1] - entity.node.angles[1]));
        entity.mocompanglestarttime = _getadjusttocoverrotation(entity.archetype, covertype, entity.nodefinalstance, angledifference);
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0xd04b0f2b, Offset: 0x41c8
// Size: 0x38c
function private mocompadjusttocoverupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (!isdefined(entity.adjustnode)) {
        return;
    }
    movevector = entity.nodeoffsetorigin - entity.origin;
    if (lengthsquared(movevector) > 1) {
        movevector = vectornormalize(movevector) * 1;
    }
    entity forceteleport(entity.origin + movevector, entity.angles, 0);
    normalizedtime = (entity getanimtime(mocompanim) * getanimlength(mocompanim) + mocompanimblendouttime) / mocompduration;
    if (normalizedtime > entity.mocompanglestarttime) {
        entity orientmode("face angle", entity.nodeoffsetangles);
        entity animmode("normal", 0);
    }
    /#
        if (getdvarint("<dev string:x62>")) {
            record3dtext(entity.mocompanglestarttime, entity.origin + (0, 0, 5), (0, 1, 0), "<dev string:x28>");
            hiptagorigin = entity gettagorigin("<dev string:x77>");
            recordline(entity.nodeoffsetorigin, entity.nodeoffsetorigin + entity.nodeoffsetforward * 30, (1, 0.5, 0), "<dev string:x28>", entity);
            recordline(entity.adjustnode.origin, entity.adjustnode.origin + entity.nodeforward * 20, (0, 1, 0), "<dev string:x28>", entity);
            recordline(entity.origin, entity.origin + anglestoforward(entity.angles) * 10, (1, 0, 0), "<dev string:x28>", entity);
            recordline(hiptagorigin, (hiptagorigin[0], hiptagorigin[1], entity.origin[2]), (0, 0, 1), "<dev string:x28>", entity);
        }
    #/
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0x6a113451, Offset: 0x4560
// Size: 0x11a
function private mocompadjusttocoverterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 0;
    entity.mocompanglestarttime = undefined;
    entity.nodeoffsetangle = undefined;
    entity.nodeoffsetforward = undefined;
    entity.nodeforward = undefined;
    entity.nodefinalstance = undefined;
    if (entity.adjustnode !== entity.node) {
        entity.nodeoffsetorigin = undefined;
        entity.nodeoffsetangles = undefined;
        entity.adjustnode = undefined;
        return;
    }
    entity forceteleport(entity.nodeoffsetorigin, entity.nodeoffsetangles, 0);
    entity.nodeoffsetorigin = undefined;
    entity.nodeoffsetangles = undefined;
    entity.adjustnode = undefined;
}

