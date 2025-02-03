#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\math_shared;

#namespace archetype_mocomps_utility;

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 0, eflags: 0x2
// Checksum 0xe788e474, Offset: 0x408
// Size: 0x34c
function autoexec registerdefaultanimationmocomps() {
    animationstatenetwork::registeranimationmocomp("adjust_to_cover", &mocompadjusttocoverinit, &mocompadjusttocoverupdate, &mocompadjusttocoverterminate);
    animationstatenetwork::registeranimationmocomp("locomotion_explosion_death", &mocomplocoexplosioninit, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_traversal_procedural", &mocomptraversalproceduralinit, &mocomptraversalproceduralpivotupdate, &mocomptraversalproceduralpivotterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_traversal_procedural_pivot", &mocomptraversalproceduralpivotinit, &mocomptraversalproceduralpivotupdate, &mocomptraversalproceduralpivotterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_traversal_procedural_no_time_scale", &function_5f0e6de2, &mocomptraversalproceduralpivotupdate, &mocomptraversalproceduralpivotterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_traversal_procedural_pivot_no_time_scale", &function_41323d2, &mocomptraversalproceduralpivotupdate, &mocomptraversalproceduralpivotterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_traversal_procedural_pivot_zeus_human", &function_f8a10630, &function_74ff11d0, &function_56a2bbe4);
    animationstatenetwork::registeranimationmocomp("mocomp_traversal_teleport", &function_82b9d7b7, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_react_stealth", &function_7ea5e21f, &function_8def77d1, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_react_stealth_move", &function_9b568914, &function_8def77d1, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_force_face_enemy_zombie", &function_37dd625c, &function_f79866a1, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_pain_ignore_pain", &function_59fe75e2, &function_8559a6cd, &function_4b95cde);
    animationstatenetwork::registeranimationmocomp("mocomp_ignore_pain_face_enemy", &mocompignorepainfaceenemyinit, &mocompignorepainfaceenemyupdate, &mocompignorepainfaceenemyterminate);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 6, eflags: 0x4
// Checksum 0x29af7249, Offset: 0x760
// Size: 0x404
function private drawtraversal(traversal, entity, animation, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (getdvarint(#"ai_debugvolumetool", 0) <= 1) {
        return;
    }
    /#
        recordsphere(mocompanimblendouttime.startposition, 2, (1, 0.5, 0), "<dev string:x38>", mocompanimflag);
        recordsphere(mocompanimblendouttime.endposition, 2, (1, 0.5, 0), "<dev string:x38>", mocompanimflag);
    #/
    animlength = getanimlength(mocompduration);
    currentposition = mocompanimblendouttime.startposition;
    nextposition = currentposition;
    segments = 0;
    for (segmenttime = 0; segmenttime <= animlength; segmenttime += float(function_60d95f53()) / 1000) {
        nexttime = segmenttime + float(function_60d95f53()) / 1000;
        if (nexttime > animlength) {
            nexttime = animlength;
        }
        movedelta = getmovedelta(mocompduration, segmenttime / animlength, nexttime / animlength);
        nextposition = currentposition + rotatepoint(movedelta, mocompanimblendouttime.startangles);
        /#
            recordline(currentposition, nextposition, (1, 0.5, 0), "<dev string:x38>", mocompanimflag);
        #/
        currentposition = nextposition;
    }
    /#
        recordsphere(nextposition, 2, (1, 0, 0), "<dev string:x38>", mocompanimflag);
    #/
    if (isdefined(mocompanimblendouttime.mantlenode)) {
        edgepoints = getnodeedge(mocompanimblendouttime.mantlenode);
        for (index = 1; index < edgepoints.size; index++) {
            /#
                recordline(edgepoints[index - 1], edgepoints[index], (1, 0, 0), "<dev string:x38>", mocompanimflag);
            #/
        }
    }
    if (!mocompanimflag function_3c566724()) {
        edgepoints = getnodeedge(mocompanimblendouttime.startnode);
        for (index = 1; index < edgepoints.size; index++) {
            /#
                recordline(edgepoints[index - 1], edgepoints[index], (1, 0, 0), "<dev string:x38>", mocompanimflag);
            #/
        }
        edgepoints = getnodeedge(mocompanimblendouttime.endnode);
        for (index = 1; index < edgepoints.size; index++) {
            /#
                recordline(edgepoints[index - 1], edgepoints[index], (1, 0, 0), "<dev string:x38>", mocompanimflag);
            #/
        }
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 6, eflags: 0x4
// Checksum 0x74d4899b, Offset: 0xb70
// Size: 0x3b6
function private drawtraversalsection(section, entity, animation, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (getdvarint(#"ai_debugvolumetool", 0) <= 1) {
        return;
    }
    /#
        recordsphere(mocompanimblendouttime.startposition, 2, (1, 0.5, 0), "<dev string:x38>", mocompanimflag);
        recordsphere(mocompanimblendouttime.endposition, 2, (1, 0.5, 0), "<dev string:x38>", mocompanimflag);
        recordsphere(mocompanimblendouttime.mocompstartposition, 2, (0, 1, 0), "<dev string:x38>", mocompanimflag);
        recordsphere(mocompanimblendouttime.adjustedmocompendposition, 2, (0, 1, 0), "<dev string:x38>", mocompanimflag);
    #/
    animlength = getanimlength(mocompduration);
    currentposition = mocompanimblendouttime.startposition;
    nextposition = currentposition;
    segments = 0;
    deltatoendtotal = (0, 0, 0);
    for (segmenttime = mocompanimblendouttime.starttime; segmenttime <= mocompanimblendouttime.endtime; segmenttime += float(function_60d95f53()) / 1000) {
        nexttime = segmenttime + float(function_60d95f53()) / 1000;
        if (nexttime > mocompanimblendouttime.endtime) {
            nexttime = mocompanimblendouttime.endtime;
        }
        movedelta = getmovedelta(mocompduration, segmenttime / animlength, nexttime / animlength);
        nextposition = currentposition + rotatepoint(movedelta, mocompanimblendouttime.startangles);
        if (nexttime >= mocompanimblendouttime.mocompstarttime && lengthsquared(deltatoendtotal) < lengthsquared(mocompanimblendouttime.deltatoendposition)) {
            adjusteddeltaperframe = mocompanimblendouttime.adjusteddeltaperframe;
            deltatoendtotal += adjusteddeltaperframe;
            if (lengthsquared(deltatoendtotal) > lengthsquared(mocompanimblendouttime.deltatoendposition)) {
                adjusteddeltaperframe -= deltatoendtotal - mocompanimblendouttime.deltatoendposition;
            }
            nextposition += adjusteddeltaperframe;
            /#
                recordline(currentposition, nextposition, (0, 1, 0), "<dev string:x38>", mocompanimflag);
            #/
        } else {
            /#
                recordline(currentposition, nextposition, (1, 0.5, 0), "<dev string:x38>", mocompanimflag);
            #/
        }
        currentposition = nextposition;
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 10, eflags: 0x4
// Checksum 0x1e8524ca, Offset: 0xf30
// Size: 0x662
function private function_54b5f203(*entity, *traversal, animation, starttime, endtime, startposition, endposition, startangles, timescale = 1, animlength) {
    assert(endtime >= starttime);
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
    section.mocomptimeinframes = floor(section.mocomptimelength / float(function_60d95f53()) / 1000);
    if (section.mocomptimeinframes <= 0) {
        section.mocomptimeinframes = 1;
    }
    endtime = 1;
    if (animlength > 0) {
        endtime = section.mocompstarttime / animlength;
    }
    endtime = math::clamp(endtime, 0, 1);
    movedelta = getmovedelta(animation, section.starttimenormalized, endtime);
    section.mocompstartposition = section.startposition + rotatepoint(movedelta, section.startangles);
    endtime = 1;
    if (animlength > 0) {
        endtime = section.mocompendtime / animlength;
    }
    endtime = math::clamp(endtime, 0, 1);
    movedelta = getmovedelta(animation, section.starttimenormalized, endtime);
    section.mocompendposition = section.startposition + rotatepoint(movedelta, section.startangles);
    endtime = 1;
    if (animlength > 0) {
        endtime = section.endtime / animlength;
    }
    endtime = math::clamp(endtime, 0, 1);
    section.animationendposition = section.startposition + rotatepoint(getmovedelta(animation, section.starttimenormalized, endtime), section.startangles);
    section.deltatoendposition = section.endposition - section.animationendposition;
    section.deltatoendmocompposition = section.mocompendposition - section.mocompstartposition;
    section.adjustedmocompendposition = section.mocompendposition + section.deltatoendposition;
    section.adjusteddeltaperframe = section.deltatoendposition / section.mocomptimeinframes;
    section.deltatoendmocomplength = length(section.deltatoendmocompposition);
    section.deltatoendmocomplengthdesired = length(section.deltatoendposition + section.deltatoendmocompposition);
    section.deltatoendmocompmultiplier = 1;
    if (timescale && section.deltatoendmocomplength > 0 && section.deltatoendmocomplengthdesired > 0) {
        if (section.deltatoendmocomplengthdesired > section.deltatoendmocomplength) {
            section.deltatoendmocompmultiplier = section.deltatoendmocomplengthdesired / section.deltatoendmocomplength;
            section.deltatoendmocompmultiplier = max(0.01, float(int(section.deltatoendmocompmultiplier * 10)) / 10);
        } else {
            section.deltatoendmocompmultiplier = 1;
        }
    } else {
        section.deltatoendmocompmultiplier = 1;
    }
    section.deltatoendtotal = (0, 0, 0);
    return section;
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 9, eflags: 0x4
// Checksum 0xdeafd209, Offset: 0x15a0
// Size: 0x74a
function private calculatetraveralsection(*entity, traversal, animation, starttime, endtime, startposition, endposition, startangles, timescale = 1) {
    assert(endtime >= starttime);
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
                if (index == 1) {
                    section.endtime = mocomptime;
                }
            }
        }
    }
    section.mocomptimelength = section.mocompendtime - section.mocompstarttime;
    section.mocomptimeinframes = floor(section.mocomptimelength / float(function_60d95f53()) / 1000);
    if (section.mocomptimeinframes <= 0) {
        section.mocomptimeinframes = 1;
    }
    endtime = 1;
    if (animlength > 0) {
        endtime = section.mocompstarttime / animlength;
    }
    endtime = math::clamp(endtime, 0, 1);
    movedelta = getmovedelta(animation, section.starttimenormalized, endtime);
    section.mocompstartposition = section.startposition + rotatepoint(movedelta, section.startangles);
    endtime = 1;
    if (animlength > 0) {
        endtime = section.mocompendtime / animlength;
    }
    endtime = math::clamp(endtime, 0, 1);
    movedelta = getmovedelta(animation, section.starttimenormalized, endtime);
    section.mocompendposition = section.startposition + rotatepoint(movedelta, section.startangles);
    endtime = 1;
    if (animlength > 0) {
        endtime = section.endtime / animlength;
    }
    endtime = math::clamp(endtime, 0, 1);
    section.animationendposition = section.startposition + rotatepoint(getmovedelta(animation, section.starttimenormalized, endtime), section.startangles);
    section.deltatoendposition = section.endposition - section.animationendposition;
    section.deltatoendmocompposition = section.mocompendposition - section.mocompstartposition;
    section.adjustedmocompendposition = section.mocompendposition + section.deltatoendposition;
    section.adjusteddeltaperframe = section.deltatoendposition / section.mocomptimeinframes;
    section.deltatoendmocomplength = length(section.deltatoendmocompposition);
    section.deltatoendmocomplengthdesired = length(section.deltatoendposition + section.deltatoendmocompposition);
    section.deltatoendmocompmultiplier = 1;
    if (timescale && section.deltatoendmocomplength > 0 && section.deltatoendmocomplengthdesired > 0) {
        section.deltatoendmocompmultiplier = section.deltatoendmocomplength / section.deltatoendmocomplengthdesired;
        section.deltatoendmocompmultiplier = max(0.01, float(int(section.deltatoendmocompmultiplier * 10)) / 10);
    }
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
// Params 2, eflags: 0x4
// Checksum 0xb23e4f5e, Offset: 0x1cf8
// Size: 0x3b8
function private function_39c2a42c(entity, traversalstart) {
    mantlepoints = entity function_1382c7a1();
    assert(mantlepoints.size >= 2);
    mantlestart = mantlepoints[0];
    mantleend = mantlepoints[mantlepoints.size - 1];
    mantlestartproj = mantlestart;
    mantleendproj = (mantleend[0], mantleend[1], mantlestartproj[2]);
    traversalstartproj = (traversalstart[0], traversalstart[1], mantlestartproj[2]);
    tomantleendproj = mantleendproj - mantlestartproj;
    totraversalproj = traversalstartproj - mantlestartproj;
    mantleoriginproj = mantlestartproj + vectorprojection(totraversalproj, tomantleendproj);
    mantleedgelength = length(mantleendproj - mantlestartproj);
    time = length(mantleoriginproj - mantlestartproj) / mantleedgelength;
    time = math::clamp(time, 0, 1);
    mantleorigin = mantlepoints[0];
    for (index = 1; index < mantlepoints.size; index++) {
        endpoint = mantlepoints[index];
        endpointproj = (endpoint[0], endpoint[1], mantlestartproj[2]);
        endpointtime = length(endpointproj - mantlestartproj) / mantleedgelength;
        if (endpointtime >= time) {
            startpoint = mantlepoints[index - 1];
            startpointproj = (startpoint[0], startpoint[1], mantlestartproj[2]);
            startpointtime = length(startpointproj - mantlestartproj) / mantleedgelength;
            timedelta = time - startpointtime;
            mantleorigin = startpoint + (endpoint - startpoint) * timedelta / (endpointtime - startpointtime);
            break;
        }
    }
    if (index == mantlepoints.size) {
        mantleorigin = mantleend;
    }
    /#
        recordline(mantleoriginproj, mantleendproj, (0, 0, 1), "<dev string:x38>", entity);
        recordline(mantlestartproj, traversalstartproj, (0, 0, 1), "<dev string:x38>", entity);
        recordline(traversalstartproj, mantleoriginproj, (0, 0, 1), "<dev string:x38>", entity);
        recordline(mantlestart, mantleend, (1, 0, 0), "<dev string:x38>", entity);
        recordline(mantlestart, mantleoriginproj, (1, 0, 0), "<dev string:x38>", entity);
        recordline(mantleoriginproj, mantleorigin, (1, 0, 0), "<dev string:x38>", entity);
    #/
    return mantleorigin;
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 3, eflags: 0x0
// Checksum 0xef86767, Offset: 0x20b8
// Size: 0x548
function calculatepivotoriginfromedge(entity, mantlenode, traversalstart) {
    assert(isvec(traversalstart));
    if (entity function_dd4f686e()) {
        return function_39c2a42c(entity, traversalstart);
    }
    assert(isdefined(mantlenode));
    mantlepoints = [];
    if (isdefined(mantlenode) && ispathnode(mantlenode)) {
        mantlepoints = getnodeedge(mantlenode);
    }
    mantlestart = undefined;
    mantleend = undefined;
    if (mantlepoints.size > 0) {
        assert(isarray(mantlepoints));
        assert(mantlepoints.size >= 2);
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
        mantleorigin = physicstraceex(mantleoriginproj + (0, 0, mantlenode.aabb_extents[2]), mantleoriginproj - (0, 0, mantlenode.aabb_extents[2]), (0, 0, 0), (0, 0, 0), entity)[#"position"];
    }
    /#
        recordline(mantleoriginproj, mantleendproj, (0, 0, 1), "<dev string:x38>", entity);
        recordline(mantlestartproj, traversalstartproj, (0, 0, 1), "<dev string:x38>", entity);
        recordline(traversalstartproj, mantleoriginproj, (0, 0, 1), "<dev string:x38>", entity);
        recordline(mantlestart, mantleend, (1, 0, 0), "<dev string:x38>", entity);
        recordline(mantlestart, mantleoriginproj, (1, 0, 0), "<dev string:x38>", entity);
        recordline(mantleoriginproj, mantleorigin, (1, 0, 0), "<dev string:x38>", entity);
    #/
    return mantleorigin;
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0xd34587ba, Offset: 0x2608
// Size: 0x4c
function function_5f0e6de2(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    mocomptraversalproceduralinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration, 0);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 6, eflags: 0x0
// Checksum 0x800ae45b, Offset: 0x2660
// Size: 0x49c
function mocomptraversalproceduralinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration, timescale = 1) {
    traversal = spawnstruct();
    traversal.startnode = entity.traversestartnode;
    traversal.endnode = entity.traverseendnode;
    traversal.initialanimationrate = isactor(entity) ? isdefined(entity function_ebbebf56()) ? entity function_ebbebf56() : 1 : 1;
    traversal.animlength = getanimlength(mocompanim);
    traversal.actualanimlength = traversal.animlength - mocompanimblendouttime;
    traversal.var_98d8ca66 = (0, 0, 0);
    traversal.startposition = entity.origin;
    traversal.adjustedendposition = isdefined(entity.var_e4615d76) ? entity.var_e4615d76 : entity.traversalendpos;
    traversal.traversalforward = traversal.adjustedendposition - traversal.startposition;
    traversal.traversalforward = (traversal.traversalforward[0], traversal.traversalforward[1], 0);
    traversal.startangles = vectortoangles(traversal.traversalforward);
    end_time = math::clamp(traversal.actualanimlength / traversal.animlength, 0, 1);
    traversal.endposition = traversal.startposition + rotatepoint(getmovedelta(mocompanim, 0, end_time), traversal.startangles);
    if (isdefined(traversal.endnode) && isdefined(traversal.endnode.script_linkname)) {
        traversal.endnodeparent = getent(traversal.endnode.script_linkname, "targetname");
        if (isdefined(traversal.endnodeparent)) {
            traversal.origincontents = entity setcontents(8192);
            traversal.lastendnodeparentorigin = traversal.endnodeparent.origin;
            traversal.adjustedendposition = physicstraceex(entity.traversalendpos + (0, 0, 24), entity.traversalendpos - (0, 0, 24), (0, 0, 0), (0, 0, 0), entity)[#"position"];
        }
    }
    traversal.sections = [];
    traversal.sections[traversal.sections.size] = calculatetraveralsection(entity, traversal, mocompanim, 0, traversal.actualanimlength, traversal.startposition, traversal.adjustedendposition, traversal.startangles, timescale);
    traversal.lastanimtime = 0;
    entity.traversal = traversal;
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity.lasttraversalanimation = mocompanim;
    entity.lasttraversalblendout = mocompanimblendouttime;
    entity.lasttraversalstartpos = traversal.startposition;
    entity.lasttraversalendpos = traversal.adjustedendposition;
    entity.lasttraversalpivot = undefined;
    if (isactor(entity)) {
        entity setrepairpaths(0);
        entity orientmode("face angle", traversal.startangles[1]);
        entity animmode("angle deltas noclip", 0);
    }
    mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0x4e7c2d6d, Offset: 0x2b08
// Size: 0x4c
function function_41323d2(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    mocomptraversalproceduralpivotinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration, 0);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 6, eflags: 0x0
// Checksum 0xf1525668, Offset: 0x2b60
// Size: 0x814
function mocomptraversalproceduralpivotinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration, timescale = 1) {
    traversal = spawnstruct();
    traversal.startnode = entity.traversestartnode;
    traversal.endnode = entity.traverseendnode;
    traversal.mantlenode = entity.traversemantlenode;
    traversal.initialanimationrate = isactor(entity) ? isdefined(entity function_ebbebf56()) ? entity function_ebbebf56() : 1 : 1;
    traversal.animlength = getanimlength(mocompanim);
    traversal.actualanimlength = traversal.animlength - mocompanimblendouttime;
    traversal.var_98d8ca66 = (0, 0, 0);
    traversal.startposition = entity.origin;
    traversal.adjustedendposition = isdefined(entity.var_e4615d76) ? entity.var_e4615d76 : entity.traversalendpos;
    traversal.traversalforward = traversal.adjustedendposition - traversal.startposition;
    traversal.traversalforward = (traversal.traversalforward[0], traversal.traversalforward[1], 0);
    traversal.startangles = vectortoangles(traversal.traversalforward);
    end_time = math::clamp(traversal.actualanimlength / traversal.animlength, 0, 1);
    traversal.endposition = traversal.startposition + rotatepoint(getmovedelta(mocompanim, 0, end_time), traversal.startangles);
    if (isdefined(traversal.endnode) && isdefined(traversal.endnode.script_linkname)) {
        traversal.endnodeparent = getent(traversal.endnode.script_linkname, "targetname");
        if (isdefined(traversal.endnodeparent)) {
            traversal.origincontents = entity setcontents(8192);
            traversal.lastendnodeparentorigin = traversal.endnodeparent.origin;
            traversal.adjustedendposition = physicstraceex(entity.traversalendpos + (0, 0, 24), entity.traversalendpos - (0, 0, 24), (0, 0, 0), (0, 0, 0), entity)[#"position"];
        }
    }
    pivottimes = getnotetracktimes(mocompanim, "pivot_procedural");
    traversal.pivottime = traversal.actualanimlength / 2;
    if (isdefined(pivottimes) && pivottimes.size > 0) {
        traversal.pivottime = pivottimes[0] * traversal.animlength;
    }
    traversal.pivottime = floor(traversal.pivottime / float(function_60d95f53()) / 1000) * float(function_60d95f53()) / 1000;
    traversal.pivotorigin = calculatepivotoriginfromedge(entity, traversal.mantlenode, traversal.startposition);
    pivottagorigin = getanimtagorigin(mocompanim, 0, "tag_sync");
    animpivotorigin = traversal.pivotorigin;
    if (lengthsquared(pivottagorigin) > 0) {
        animpivotorigin = rotatepoint(pivottagorigin, traversal.startangles) + traversal.startposition;
    }
    pivotoffset = traversal.pivotorigin - animpivotorigin;
    animlen = 1;
    if (traversal.animlength > 0) {
        animlen = math::clamp(traversal.pivottime / traversal.animlength, 0, 1);
    }
    pivotorigin = traversal.startposition + rotatepoint(getmovedelta(mocompanim, 0, animlen), traversal.startangles) + pivotoffset;
    /#
        if (getdvarint(#"ai_debugvolumetool", 0) > 1) {
            recordsphere(animpivotorigin, 2, (0, 0, 1), "<dev string:x38>", entity);
            recordline(traversal.pivotorigin, animpivotorigin, (1, 0, 0), "<dev string:x38>", entity);
            recordsphere(traversal.pivotorigin, 2, (1, 0, 0), "<dev string:x38>", entity);
        }
    #/
    traversal.sections = [];
    traversal.sections[traversal.sections.size] = calculatetraveralsection(entity, traversal, mocompanim, 0, traversal.pivottime, traversal.startposition, pivotorigin, traversal.startangles, timescale);
    traversal.sections[traversal.sections.size] = calculatetraveralsection(entity, traversal, mocompanim, traversal.pivottime, traversal.actualanimlength, pivotorigin, traversal.adjustedendposition, traversal.startangles, timescale);
    if (traversal.sections[0].deltatoendmocompmultiplier != 1) {
        traversal.sections[1].deltatoendmocompmultiplier = 1;
    }
    traversal.lastanimtime = 0;
    entity.traversal = traversal;
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity.lasttraversalanimation = mocompanim;
    entity.lasttraversalblendout = mocompanimblendouttime;
    entity.lasttraversalstartpos = traversal.startposition;
    entity.lasttraversalendpos = traversal.adjustedendposition;
    entity.lasttraversalpivot = traversal.pivotorigin;
    if (isactor(entity)) {
        entity setrepairpaths(0);
        entity animmode("angle deltas noclip", 0);
    }
    mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0xdfe9e84, Offset: 0x3380
// Size: 0x51c
function mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
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
    assert(isdefined(traversal));
    animationrate = traversal.initialanimationrate;
    adjusteddeltaperframe = (0, 0, 0);
    animationnextsteptime = entity getanimtime(mocompanim) * traversal.animlength;
    movedelta = getmovedelta(mocompanim, 0, animationnextsteptime / traversal.animlength);
    assert(traversal.sections.size > 0);
    section = traversal.sections[0];
    for (index = 0; index < traversal.sections.size; index++) {
        section = traversal.sections[index];
        if (section.starttime <= animationnextsteptime && section.endtime > animationnextsteptime) {
            break;
        }
    }
    if (traversal.lastanimtime >= section.mocompstarttime && lengthsquared(section.deltatoendtotal) < lengthsquared(section.deltatoendposition)) {
        animationtimedelta = (animationnextsteptime - traversal.lastanimtime) / float(function_60d95f53()) / 1000;
        adjusteddeltaperframe = section.adjusteddeltaperframe * animationtimedelta;
        section.deltatoendtotal += adjusteddeltaperframe;
        if (traversal.lastanimtime <= section.mocompendtime && section.deltatoendmocompmultiplier < 1 && !is_true(level.var_881e464e)) {
            animationrate = traversal.initialanimationrate * section.deltatoendmocompmultiplier;
        }
        if (lengthsquared(section.deltatoendtotal) > lengthsquared(section.deltatoendposition)) {
            adjusteddeltaperframe -= section.deltatoendtotal - section.deltatoendposition;
        }
    }
    traversal.lastanimtime = animationnextsteptime;
    traversal.var_98d8ca66 += adjusteddeltaperframe;
    newentityorigin = traversal.startposition + rotatepoint(movedelta, traversal.startangles) + traversal.var_98d8ca66;
    if (isdefined(traversal.endnodeparent)) {
        parentdelta = traversal.endnodeparent.origin - traversal.lastendnodeparentorigin;
        traversal.lastendnodeparentorigin = traversal.endnodeparent.origin;
        newentityorigin += parentdelta;
    }
    if (isactor(entity)) {
        if (!is_true(entity.ai.var_8a9efbb6)) {
            entity asmsetanimationrate(animationrate);
        }
        entity forceteleport(newentityorigin, traversal.startangles, 0, 0);
        return;
    }
    if (isplayer(entity)) {
        entity lerporigin(newentityorigin);
        entity setplayerangles(traversal.startangles);
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0x22c68e9c, Offset: 0x38a8
// Size: 0x18c
function mocomptraversalproceduralpivotterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    traversal = entity.traversal;
    if (isdefined(traversal)) {
        mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
        if (isdefined(traversal.origincontents)) {
            entity setcontents(traversal.origincontents);
        }
        if (isactor(entity)) {
            entity asmsetanimationrate(traversal.initialanimationrate);
        }
    }
    entity.blockingpain = 0;
    entity.usegoalanimweight = 0;
    entity.traversal = undefined;
    if (isactor(entity)) {
        entity animmode("normal", 0);
        entity orientmode("face motion");
        entity function_af554597(mocompanim);
        entity finishtraversal();
        entity setrepairpaths(1);
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 6, eflags: 0x0
// Checksum 0x6b4a1bbb, Offset: 0x3a40
// Size: 0x87c
function function_f8a10630(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration, *timescale) {
    assert(isactor(mocompanim));
    traversal = spawnstruct();
    traversal.startnode = mocompanim.traversestartnode;
    traversal.endnode = mocompanim.traverseendnode;
    traversal.mantlenode = mocompanim.traversemantlenode;
    traversal.initialanimationrate = isactor(mocompanim) ? isdefined(mocompanim function_ebbebf56()) ? mocompanim function_ebbebf56() : 1 : 1;
    traversal.animlength = getanimlength(mocompanimblendouttime);
    var_4843d198 = traversal.animlength - mocompanimflag;
    endtimes = getnotetracktimes(mocompanimblendouttime, "stop_procedural");
    if (isdefined(endtimes) && endtimes.size > 1) {
        var_4843d198 = endtimes[1] * traversal.animlength;
    }
    traversal.actualanimlength = var_4843d198;
    traversal.var_98d8ca66 = (0, 0, 0);
    traversal.startposition = mocompanim.origin;
    traversal.adjustedendposition = mocompanim.traversalendpos;
    traversal.traversalforward = traversal.adjustedendposition - traversal.startposition;
    traversal.traversalforward = (traversal.traversalforward[0], traversal.traversalforward[1], 0);
    traversal.startangles = vectortoangles(traversal.traversalforward);
    end_time = math::clamp(traversal.actualanimlength / traversal.animlength, 0, 1);
    traversal.endposition = traversal.startposition + rotatepoint(getmovedelta(mocompanimblendouttime, 0, end_time), traversal.startangles);
    if (isdefined(traversal.endnode) && isdefined(traversal.endnode.script_linkname)) {
        traversal.endnodeparent = getent(traversal.endnode.script_linkname, "targetname");
        if (isdefined(traversal.endnodeparent)) {
            traversal.origincontents = mocompanim setcontents(8192);
            traversal.lastendnodeparentorigin = traversal.endnodeparent.origin;
            traversal.adjustedendposition = physicstraceex(mocompanim.traversalendpos + (0, 0, 24), mocompanim.traversalendpos - (0, 0, 24), (0, 0, 0), (0, 0, 0), mocompanim)[#"position"];
        }
    }
    pivottimes = getnotetracktimes(mocompanimblendouttime, "pivot_procedural");
    traversal.pivottime = traversal.actualanimlength / 2;
    if (isdefined(pivottimes) && pivottimes.size > 0) {
        traversal.pivottime = pivottimes[0] * traversal.animlength;
    }
    traversal.pivottime = floor(traversal.pivottime / float(function_60d95f53()) / 1000) * float(function_60d95f53()) / 1000;
    traversal.pivotorigin = calculatepivotoriginfromedge(mocompanim, traversal.mantlenode, traversal.startposition);
    pivottagorigin = getanimtagorigin(mocompanimblendouttime, 0, "tag_sync");
    animpivotorigin = traversal.pivotorigin;
    if (lengthsquared(pivottagorigin) > 0) {
        animpivotorigin = rotatepoint(pivottagorigin, traversal.startangles) + traversal.startposition;
    }
    pivotoffset = traversal.pivotorigin - animpivotorigin;
    animlen = 1;
    if (traversal.animlength > 0) {
        animlen = math::clamp(traversal.pivottime / traversal.animlength, 0, 1);
    }
    pivotorigin = traversal.startposition + rotatepoint(getmovedelta(mocompanimblendouttime, 0, animlen), traversal.startangles) + pivotoffset;
    /#
        if (getdvarint(#"ai_debugvolumetool", 0) > 1) {
            recordsphere(animpivotorigin, 2, (0, 0, 1), "<dev string:x38>", mocompanim);
            recordline(traversal.pivotorigin, animpivotorigin, (1, 0, 0), "<dev string:x38>", mocompanim);
            recordsphere(traversal.pivotorigin, 2, (1, 0, 0), "<dev string:x38>", mocompanim);
        }
    #/
    traversal.sections = [];
    traversal.sections[traversal.sections.size] = function_54b5f203(mocompanim, traversal, mocompanimblendouttime, 0, traversal.pivottime, traversal.startposition, pivotorigin, traversal.startangles, 0, traversal.animlength);
    traversal.sections[traversal.sections.size] = function_54b5f203(mocompanim, traversal, mocompanimblendouttime, traversal.pivottime, traversal.actualanimlength, pivotorigin, traversal.adjustedendposition, traversal.startangles, 1, traversal.animlength);
    if (traversal.sections[0].deltatoendmocompmultiplier != 1) {
        traversal.sections[1].deltatoendmocompmultiplier = 1;
    }
    traversal.lastanimtime = 0;
    mocompanim.traversal = traversal;
    mocompanim.blockingpain = 1;
    mocompanim.usegoalanimweight = 1;
    mocompanim.lasttraversalanimation = mocompanimblendouttime;
    mocompanim.lasttraversalblendout = mocompanimflag;
    mocompanim.lasttraversalstartpos = traversal.startposition;
    mocompanim.lasttraversalendpos = traversal.adjustedendposition;
    mocompanim.lasttraversalpivot = traversal.pivotorigin;
    mocompanim setrepairpaths(0);
    mocompanim animmode("angle deltas noclip", 0);
    function_74ff11d0(mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration, timescale);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0xcd19ce2a, Offset: 0x42c8
// Size: 0x414
function function_74ff11d0(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
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
    assert(isdefined(traversal));
    adjusteddeltaperframe = (0, 0, 0);
    animationnextsteptime = entity getanimtime(mocompanim) * traversal.animlength;
    movedelta = getmovedelta(mocompanim, 0, animationnextsteptime / traversal.animlength);
    assert(traversal.sections.size > 0);
    section = traversal.sections[0];
    for (index = 0; index < traversal.sections.size; index++) {
        section = traversal.sections[index];
        if (section.starttime <= animationnextsteptime && (section.endtime > animationnextsteptime || section.endtime == animationnextsteptime)) {
            break;
        }
    }
    if (!isdefined(section.var_9bcea3fe)) {
        section.var_9bcea3fe = 0;
    }
    if (traversal.lastanimtime >= section.mocompstarttime && section.var_9bcea3fe <= section.mocomptimeinframes) {
        animationtimedelta = (animationnextsteptime - traversal.lastanimtime) / float(function_60d95f53()) / 1000;
        adjusteddeltaperframe = section.adjusteddeltaperframe * animationtimedelta;
        section.deltatoendtotal += adjusteddeltaperframe;
        section.var_9bcea3fe++;
        if (lengthsquared(section.deltatoendtotal) > lengthsquared(section.deltatoendposition)) {
            adjusteddeltaperframe -= section.deltatoendtotal - section.deltatoendposition;
        }
    }
    traversal.lastanimtime = animationnextsteptime;
    traversal.var_98d8ca66 += adjusteddeltaperframe;
    newentityorigin = traversal.startposition + rotatepoint(movedelta, traversal.startangles) + traversal.var_98d8ca66;
    if (isdefined(traversal.endnodeparent)) {
        parentdelta = traversal.endnodeparent.origin - traversal.lastendnodeparentorigin;
        traversal.lastendnodeparentorigin = traversal.endnodeparent.origin;
        newentityorigin += parentdelta;
    }
    entity forceteleport(newentityorigin, traversal.startangles, 0, 0);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0xcdbdfa81, Offset: 0x46e8
// Size: 0x134
function function_56a2bbe4(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    traversal = entity.traversal;
    if (isdefined(traversal)) {
        function_74ff11d0(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
        if (isdefined(traversal.origincontents)) {
            entity setcontents(traversal.origincontents);
        }
    }
    entity.blockingpain = 0;
    entity.usegoalanimweight = 0;
    entity function_af554597(mocompanim);
    entity finishtraversal();
    entity setrepairpaths(1);
    entity animmode("normal", 0);
    entity orientmode("face motion");
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 0, eflags: 0x2
// Checksum 0x7cfe3cd8, Offset: 0x4828
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
// Checksum 0xea0aa9f8, Offset: 0x4ec8
// Size: 0x210
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
// Checksum 0x6cd46a4e, Offset: 0x50e0
// Size: 0x396
function private _getadjusttocoverrotation(archetype, node, stance, angletonode) {
    assert(isarray(level.adjusttocover[archetype]));
    if (!isdefined(level.adjusttocover[archetype][node])) {
        node = "cover_any";
    }
    assert(isarray(level.adjusttocover[archetype][node]));
    if (!isdefined(level.adjusttocover[archetype][node][stance])) {
        stance = "stance_any";
    }
    assert(isarray(level.adjusttocover[archetype][node][stance]));
    assert(angletonode >= 0 && angletonode < 360);
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
    assert(isdefined(level.adjusttocover[archetype][node][stance][direction]));
    adjusttime = level.adjusttocover[archetype][node][stance][direction];
    if (isdefined(adjusttime)) {
        return adjusttime;
    }
    return 0.8;
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 1, eflags: 0x4
// Checksum 0xdb77f1af, Offset: 0x5480
// Size: 0x156
function private debuglocoexplosion(entity) {
    entity endon(#"death");
    /#
        startorigin = entity.origin;
        startyawforward = anglestoforward((0, entity.angles[1], 0));
        damageyawforward = anglestoforward((0, entity.damageyaw - entity.angles[1], 0));
        starttime = gettime();
        while (gettime() - starttime < 10000) {
            recordsphere(startorigin, 5, (1, 0, 0), "<dev string:x38>", entity);
            recordline(startorigin, startorigin + startyawforward * 100, (0, 0, 1), "<dev string:x38>", entity);
            recordline(startorigin, startorigin + damageyawforward * 100, (1, 0, 0), "<dev string:x38>", entity);
            waitframe(1);
        }
    #/
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0xab23fc41, Offset: 0x55e0
// Size: 0xac
function private mocomplocoexplosioninit(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration animmode("nogravity", 0);
    mocompduration orientmode("face current");
    /#
        if (getdvarint(#"ai_debuglocoexplosionmocomp", 0)) {
            mocompduration thread debuglocoexplosion(mocompduration);
        }
    #/
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0xd06f3679, Offset: 0x5698
// Size: 0x25a
function private mocompadjusttocoverinit(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration orientmode("face current");
    mocompduration animmode("angle deltas", 0);
    mocompduration.blockingpain = 1;
    if (isdefined(mocompduration.node)) {
        mocompduration.adjustnode = mocompduration.node;
        mocompduration.nodeoffsetorigin = mocompduration getnodeoffsetposition(mocompduration.node);
        mocompduration.nodeoffsetangles = mocompduration getnodeoffsetangles(mocompduration.node);
        mocompduration.nodeoffsetforward = anglestoforward(mocompduration.nodeoffsetangles);
        mocompduration.nodeforward = anglestoforward(mocompduration.node.angles);
        mocompduration.nodefinalstance = mocompduration getblackboardattribute("_desired_stance");
        covertype = mocompduration getblackboardattribute("_cover_type");
        if (!isdefined(mocompduration.nodefinalstance)) {
            mocompduration.nodefinalstance = mocompduration aiutility::gethighestnodestance(mocompduration.adjustnode);
        }
        angledifference = floor(absangleclamp360(mocompduration.angles[1] - mocompduration.node.angles[1]));
        var_c9145b1d = mocompduration.archetype;
        if (var_c9145b1d == #"civilian") {
            var_c9145b1d = #"human";
        }
        mocompduration.mocompanglestarttime = _getadjusttocoverrotation(var_c9145b1d, covertype, mocompduration.nodefinalstance, angledifference);
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0x2cc0ba08, Offset: 0x5900
// Size: 0x31c
function private mocompadjusttocoverupdate(entity, mocompanim, mocompanimblendouttime, *mocompanimflag, mocompduration) {
    if (!isdefined(mocompanim.adjustnode)) {
        return;
    }
    movevector = mocompanim.nodeoffsetorigin - mocompanim.origin;
    if (lengthsquared(movevector) > 1) {
        movevector = vectornormalize(movevector) * 1;
    }
    mocompanim forceteleport(mocompanim.origin + movevector, mocompanim.angles, 0);
    normalizedtime = (mocompanim getanimtime(mocompanimblendouttime) * getanimlength(mocompanimblendouttime) + mocompanimflag) / mocompduration;
    if (normalizedtime > mocompanim.mocompanglestarttime) {
        mocompanim orientmode("face angle", mocompanim.nodeoffsetangles);
        mocompanim animmode("normal", 0);
    }
    /#
        if (getdvarint(#"ai_debugadjustmocomp", 0)) {
            record3dtext(mocompanim.mocompanglestarttime, mocompanim.origin + (0, 0, 5), (0, 1, 0), "<dev string:x38>");
            hiptagorigin = mocompanim gettagorigin("<dev string:x46>");
            recordline(mocompanim.nodeoffsetorigin, mocompanim.nodeoffsetorigin + mocompanim.nodeoffsetforward * 30, (1, 0.5, 0), "<dev string:x38>", mocompanim);
            recordline(mocompanim.adjustnode.origin, mocompanim.adjustnode.origin + mocompanim.nodeforward * 20, (0, 1, 0), "<dev string:x38>", mocompanim);
            recordline(mocompanim.origin, mocompanim.origin + anglestoforward(mocompanim.angles) * 10, (1, 0, 0), "<dev string:x38>", mocompanim);
            recordline(hiptagorigin, (hiptagorigin[0], hiptagorigin[1], mocompanim.origin[2]), (0, 0, 1), "<dev string:x38>", mocompanim);
        }
    #/
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0xeefd03e, Offset: 0x5c28
// Size: 0x142
function private mocompadjusttocoverterminate(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompanimflag.blockingpain = 0;
    mocompanimflag.nodeoffsetangle = undefined;
    mocompanimflag.nodeoffsetforward = undefined;
    mocompanimflag.nodeforward = undefined;
    mocompanimflag.nodefinalstance = undefined;
    if (mocompanimflag.adjustnode !== mocompanimflag.node) {
        mocompanimflag.nodeoffsetorigin = undefined;
        mocompanimflag.nodeoffsetangles = undefined;
        mocompanimflag.adjustnode = undefined;
        return;
    }
    if (mocompduration != #"") {
        animtime = mocompanimflag getanimtime(mocompduration);
        if (animtime > mocompanimflag.mocompanglestarttime) {
            mocompanimflag forceteleport(mocompanimflag.nodeoffsetorigin, mocompanimflag.nodeoffsetangles, 0);
        }
    }
    mocompanimflag.mocompanglestarttime = undefined;
    mocompanimflag.nodeoffsetorigin = undefined;
    mocompanimflag.nodeoffsetangles = undefined;
    mocompanimflag.adjustnode = undefined;
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0xe1ab5176, Offset: 0x5d78
// Size: 0x16c
function private function_82b9d7b7(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration orientmode("face current");
    mocompduration animmode("normal");
    if (isdefined(mocompduration.traverseendnode)) {
        /#
            print3d(mocompduration.traversestartnode.origin, "<dev string:x54>", (1, 0, 0), 1, 1, 60);
            print3d(mocompduration.traverseendnode.origin, "<dev string:x54>", (0, 1, 0), 1, 1, 60);
            line(mocompduration.traversestartnode.origin, mocompduration.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
        #/
        mocompduration forceteleport(mocompduration.traverseendnode.origin, mocompduration.traverseendnode.angles, 0);
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0x6faa1b4f, Offset: 0x5ef0
// Size: 0x6c
function function_9b568914(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration orientmode("face motion");
    mocompduration animmode("zonly_physics", 1);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0x8fd1e763, Offset: 0x5f68
// Size: 0xa6
function function_7ea5e21f(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompanimflag animmode("gravity", 1);
    mocompanimflag.var_82d6d030 = 0.5;
    notetrack_times = getnotetracktimes(mocompduration, "face_react");
    if (isdefined(notetrack_times) && notetrack_times.size > 0) {
        mocompanimflag.var_82d6d030 = notetrack_times[0];
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0xe8e887ce, Offset: 0x6018
// Size: 0xa4
function function_8def77d1(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (mocompanimflag getanimtime(mocompduration) >= mocompanimflag.var_82d6d030) {
        mocompanimflag orientmode("face angle", self getblackboardattribute("_react_yaw_world"));
        mocompanimflag animmode("pos deltas", 0);
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0xe9f48452, Offset: 0x60c8
// Size: 0xc4
function function_37dd625c(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompduration.enemy)) {
        toenemy = mocompduration.enemy.origin - mocompduration.origin;
        var_8e08536c = vectortoangles(toenemy);
        mocompduration orientmode("face angle", var_8e08536c);
        return;
    }
    mocompduration orientmode("face enemy");
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0x969ed929, Offset: 0x6198
// Size: 0xdc
function function_f79866a1(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompduration.enemy) && mocompduration.enemy.health > 0 && mocompduration function_ebbebf56() > 0.5) {
        toenemy = mocompduration.enemy.origin - mocompduration.origin;
        var_8e08536c = vectortoangles(toenemy);
        mocompduration orientmode("face angle", var_8e08536c);
    }
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0xf97ac337, Offset: 0x6280
// Size: 0x74
function function_59fe75e2(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.blockingpain = 1;
    mocompduration orientmode("face current");
    mocompduration animmode("zonly_physics", 1);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0x486cdc06, Offset: 0x6300
// Size: 0x74
function function_8559a6cd(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.blockingpain = 1;
    mocompduration orientmode("face current");
    mocompduration animmode("zonly_physics", 1);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x0
// Checksum 0xb28899c, Offset: 0x6380
// Size: 0x74
function function_4b95cde(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.blockingpain = 0;
    mocompduration orientmode("face current");
    mocompduration animmode("normal", 0);
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0xb2618686, Offset: 0x6400
// Size: 0xa4
function private mocompignorepainfaceenemyinit(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.blockingpain = 1;
    if (isdefined(mocompduration.enemy)) {
        mocompduration orientmode("face enemy");
    } else {
        mocompduration orientmode("face current");
    }
    mocompduration animmode("pos deltas");
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0x41d0ec3d, Offset: 0x64b0
// Size: 0x9c
function private mocompignorepainfaceenemyupdate(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompanimflag.enemy) && mocompanimflag getanimtime(mocompduration) < 0.5) {
        mocompanimflag orientmode("face enemy");
        return;
    }
    mocompanimflag orientmode("face current");
}

// Namespace archetype_mocomps_utility/archetype_mocomps_utility
// Params 5, eflags: 0x4
// Checksum 0xe25d7c88, Offset: 0x6558
// Size: 0x36
function private mocompignorepainfaceenemyterminate(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.blockingpain = 0;
}

