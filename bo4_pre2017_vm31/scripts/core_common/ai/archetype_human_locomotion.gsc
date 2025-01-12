#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_state_machine;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;

#namespace archetype_human_locomotion;

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 0, eflags: 0x2
// Checksum 0xef11ad2f, Offset: 0x650
// Size: 0xa84
function autoexec registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&prepareformovement));
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareForMovement", &prepareformovement);
    assert(isscriptfunctionptr(&prepareformovement));
    behaviorstatemachine::registerbsmscriptapiinternal("prepareForMovement", &prepareformovement);
    assert(isscriptfunctionptr(&shouldtacticalarrivecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldTacticalArrive", &shouldtacticalarrivecondition);
    assert(isscriptfunctionptr(&planhumanarrivalatcover));
    behaviorstatemachine::registerbsmscriptapiinternal("planHumanArrivalAtCover", &planhumanarrivalatcover);
    assert(isscriptfunctionptr(&shouldplanarrivalintocover));
    behaviorstatemachine::registerbsmscriptapiinternal("shouldPlanArrivalIntoCover", &shouldplanarrivalintocover);
    assert(iscodefunctionptr(&btapi_shouldarriveexposed));
    behaviorstatemachine::registerbsmscriptapiinternal("btapi_shouldArriveExposed", &btapi_shouldarriveexposed);
    assert(isscriptfunctionptr(&shouldarriveexposed));
    behaviorstatemachine::registerbsmscriptapiinternal("shouldArriveExposed", &shouldarriveexposed);
    assert(iscodefunctionptr(&btapi_humannoncombatlocomotionupdate));
    behaviorstatemachine::registerbsmscriptapiinternal("btapi_humanNonCombatLocomotionUpdate", &btapi_humannoncombatlocomotionupdate);
    assert(isscriptfunctionptr(&noncombatlocomotionupdate));
    behaviorstatemachine::registerbsmscriptapiinternal("nonCombatLocomotionUpdate", &noncombatlocomotionupdate);
    assert(isscriptfunctionptr(&combatlocomotionstart));
    behaviorstatemachine::registerbsmscriptapiinternal("combatLocomotionStart", &combatlocomotionstart);
    assert(iscodefunctionptr(&btapi_combatlocomotionupdate));
    behaviorstatemachine::registerbsmscriptapiinternal("btapi_combatLocomotionUpdate", &btapi_combatlocomotionupdate);
    assert(isscriptfunctionptr(&combatlocomotionupdate));
    behaviorstatemachine::registerbsmscriptapiinternal("combatLocomotionUpdate", &combatlocomotionupdate);
    assert(iscodefunctionptr(&btapi_humannoncombatlocomotioncondition));
    behaviorstatemachine::registerbsmscriptapiinternal("btapi_humanNonCombatLocomotionCondition", &btapi_humannoncombatlocomotioncondition);
    assert(isscriptfunctionptr(&humannoncombatlocomotioncondition));
    behaviorstatemachine::registerbsmscriptapiinternal("humanNonCombatLocomotionCondition", &humannoncombatlocomotioncondition);
    assert(iscodefunctionptr(&btapi_humancombatlocomotioncondition));
    behaviorstatemachine::registerbsmscriptapiinternal("btapi_humanCombatLocomotionCondition", &btapi_humancombatlocomotioncondition);
    assert(isscriptfunctionptr(&humancombatlocomotioncondition));
    behaviorstatemachine::registerbsmscriptapiinternal("humanCombatLocomotionCondition", &humancombatlocomotioncondition);
    assert(iscodefunctionptr(&btapi_shouldswitchtotacticalwalkfromrun));
    behaviorstatemachine::registerbsmscriptapiinternal("btapi_shouldSwitchToTacticalWalkFromRun", &btapi_shouldswitchtotacticalwalkfromrun);
    assert(isscriptfunctionptr(&shouldswitchtotacticalwalkfromrun));
    behaviorstatemachine::registerbsmscriptapiinternal("shouldSwitchToTacticalWalkFromRun", &shouldswitchtotacticalwalkfromrun);
    assert(isscriptfunctionptr(&preparetostopnearenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToStopNearEnemy", &preparetostopnearenemy);
    assert(isscriptfunctionptr(&preparetostopnearenemy));
    behaviorstatemachine::registerbsmscriptapiinternal("prepareToStopNearEnemy", &preparetostopnearenemy);
    assert(isscriptfunctionptr(&preparetomoveawayfromnearbyenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToMoveAwayFromNearByEnemy", &preparetomoveawayfromnearbyenemy);
    assert(isscriptfunctionptr(&shouldtacticalwalkpain));
    behaviorstatemachine::registerbsmscriptapiinternal("shouldTacticalWalkPain", &shouldtacticalwalkpain);
    assert(isscriptfunctionptr(&begintacticalwalkpain));
    behaviorstatemachine::registerbsmscriptapiinternal("beginTacticalWalkPain", &begintacticalwalkpain);
    assert(isscriptfunctionptr(&shouldcontinuetacticalwalkpain));
    behaviorstatemachine::registerbsmscriptapiinternal("shouldContinueTacticalWalkPain", &shouldcontinuetacticalwalkpain);
    assert(isscriptfunctionptr(&shouldtacticalwalkscan));
    behaviorstatemachine::registerbsmscriptapiinternal("shouldTacticalWalkScan", &shouldtacticalwalkscan);
    assert(isscriptfunctionptr(&continuetacticalwalkscan));
    behaviorstatemachine::registerbsmscriptapiinternal("continueTacticalWalkScan", &continuetacticalwalkscan);
    assert(isscriptfunctionptr(&tacticalwalkscanterminate));
    behaviorstatemachine::registerbsmscriptapiinternal("tacticalWalkScanTerminate", &tacticalwalkscanterminate);
    assert(isscriptfunctionptr(&bsmlocomotionhasvalidpaininterrupt));
    behaviorstatemachine::registerbsmscriptapiinternal("BSMLocomotionHasValidPainInterrupt", &bsmlocomotionhasvalidpaininterrupt);
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xf57b7f5e, Offset: 0x10e0
// Size: 0x20
function private tacticalwalkscanterminate(entity) {
    entity.lasttacticalscantime = gettime();
    return true;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xcf27c9b5, Offset: 0x1108
// Size: 0x130
function private shouldtacticalwalkscan(entity) {
    if (isdefined(entity.lasttacticalscantime) && entity.lasttacticalscantime + 2000 > gettime()) {
        return false;
    }
    if (!entity haspath()) {
        return false;
    }
    if (isdefined(entity.enemy)) {
        return false;
    }
    if (entity shouldfacemotion()) {
        if (ai::hasaiattribute(entity, "forceTacticalWalk") && !ai::getaiattribute(entity, "forceTacticalWalk")) {
            return false;
        }
    }
    animation = entity asmgetcurrentdeltaanimation();
    if (isdefined(animation)) {
        animtime = entity getanimtime(animation);
        return (animtime <= 0.05);
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xfc90d1a4, Offset: 0x1240
// Size: 0x150
function private continuetacticalwalkscan(entity) {
    if (!entity haspath()) {
        return false;
    }
    if (isdefined(entity.enemy)) {
        return false;
    }
    if (entity shouldfacemotion()) {
        if (ai::hasaiattribute(entity, "forceTacticalWalk") && !ai::getaiattribute(entity, "forceTacticalWalk")) {
            return false;
        }
    }
    animation = entity asmgetcurrentdeltaanimation();
    if (isdefined(animation)) {
        animlength = getanimlength(animation);
        animtime = entity getanimtime(animation) * animlength;
        normalizedtime = (animtime + 0.2) / animlength;
        return (normalizedtime < 1);
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x54ca05fb, Offset: 0x1398
// Size: 0x76
function private shouldtacticalwalkpain(entity) {
    if ((!isdefined(entity.startpaintime) || entity.startpaintime + 3000 < gettime()) && randomfloat(1) > 0.25) {
        return bsmlocomotionhasvalidpaininterrupt(entity);
    }
    return 0;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x51edc033, Offset: 0x1418
// Size: 0x20
function private begintacticalwalkpain(entity) {
    entity.startpaintime = gettime();
    return true;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xf912b367, Offset: 0x1440
// Size: 0x24
function private shouldcontinuetacticalwalkpain(entity) {
    return entity.startpaintime + 100 >= gettime();
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x698904a4, Offset: 0x1470
// Size: 0x2a
function private bsmlocomotionhasvalidpaininterrupt(entity) {
    return entity hasvalidinterrupt("pain");
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xe116e0be, Offset: 0x14a8
// Size: 0xdc
function private shouldarriveexposed(behaviortreeentity) {
    if (behaviortreeentity ai::get_behavior_attribute("disablearrivals")) {
        return false;
    }
    if (behaviortreeentity haspath()) {
        if (isdefined(behaviortreeentity.node) && iscovernode(behaviortreeentity.node) && isdefined(behaviortreeentity.pathgoalpos) && distancesquared(behaviortreeentity.pathgoalpos, behaviortreeentity getnodeoffsetposition(behaviortreeentity.node)) < 8) {
            return false;
        }
    }
    return true;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xc85e6014, Offset: 0x1590
// Size: 0x38
function private preparetostopnearenemy(behaviortreeentity) {
    behaviortreeentity clearpath();
    behaviortreeentity.keepclaimednode = 1;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xfeb02a1c, Offset: 0x15d0
// Size: 0x38
function private preparetomoveawayfromnearbyenemy(behaviortreeentity) {
    behaviortreeentity clearpath();
    behaviortreeentity.keepclaimednode = 1;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xf5d73e81, Offset: 0x1610
// Size: 0x1c8
function private shouldplanarrivalintocover(behaviortreeentity) {
    goingtocovernode = isdefined(behaviortreeentity.node) && iscovernode(behaviortreeentity.node);
    if (!goingtocovernode) {
        return false;
    }
    if (isdefined(behaviortreeentity.pathgoalpos)) {
        if (isdefined(behaviortreeentity.arrivalfinalpos)) {
            if (behaviortreeentity.arrivalfinalpos != behaviortreeentity.pathgoalpos) {
                return true;
            } else if (behaviortreeentity.ai.replannedcoverarrival === 0 && isdefined(behaviortreeentity.exitpos) && isdefined(behaviortreeentity.predictedexitpos)) {
                behaviortreeentity.ai.replannedcoverarrival = 1;
                exitdir = vectornormalize(behaviortreeentity.predictedexitpos - behaviortreeentity.exitpos);
                currentdir = vectornormalize(behaviortreeentity.origin - behaviortreeentity.exitpos);
                if (vectordot(exitdir, currentdir) < cos(30)) {
                    behaviortreeentity.predictedarrivaldirectionvalid = 0;
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xc48a72be, Offset: 0x17e0
// Size: 0x146
function private shouldswitchtotacticalwalkfromrun(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (ai::hasaiattribute(behaviortreeentity, "forceTacticalWalk") && ai::getaiattribute(behaviortreeentity, "forceTacticalWalk")) {
        return true;
    }
    goalpos = undefined;
    if (isdefined(behaviortreeentity.arrivalfinalpos)) {
        goalpos = behaviortreeentity.arrivalfinalpos;
    } else {
        goalpos = behaviortreeentity.pathgoalpos;
    }
    if (isdefined(behaviortreeentity.pathstartpos) && isdefined(goalpos)) {
        pathdist = distancesquared(behaviortreeentity.pathstartpos, goalpos);
        if (pathdist < 250 * 250) {
            return true;
        }
    }
    if (!behaviortreeentity shouldfacemotion()) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x79ad2e59, Offset: 0x1930
// Size: 0x90
function private humannoncombatlocomotioncondition(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
        return true;
    }
    if (behaviortreeentity humanshouldsprint()) {
        return true;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    return true;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x9333cfe3, Offset: 0x19c8
// Size: 0x8c
function private humancombatlocomotioncondition(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
        return false;
    }
    if (behaviortreeentity humanshouldsprint()) {
        return false;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xa4c3a2ca, Offset: 0x1a60
// Size: 0xc8
function private combatlocomotionstart(behaviortreeentity) {
    randomchance = randomint(100);
    if (randomchance > 50) {
        behaviortreeentity setblackboardattribute("_run_n_gun_variation", "variation_forward");
        return true;
    }
    if (randomchance > 25) {
        behaviortreeentity setblackboardattribute("_run_n_gun_variation", "variation_strafe_1");
        return true;
    }
    behaviortreeentity setblackboardattribute("_run_n_gun_variation", "variation_strafe_2");
    return true;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x984c8ce3, Offset: 0x1b30
// Size: 0x116
function private noncombatlocomotionupdate(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (!(isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) && isdefined(behaviortreeentity.enemy) && !behaviortreeentity humanshouldsprint()) {
        return false;
    }
    if (!behaviortreeentity asmistransitionrunning()) {
        behaviortreeentity setblackboardattribute("_stance", "stand");
        if (!isdefined(behaviortreeentity.ai.replannedcoverarrival)) {
            behaviortreeentity.ai.replannedcoverarrival = 0;
        }
    } else {
        behaviortreeentity.ai.replannedcoverarrival = undefined;
    }
    return true;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x4149f0b3, Offset: 0x1c50
// Size: 0xec
function private combatlocomotionupdate(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (behaviortreeentity humanshouldsprint()) {
        return false;
    }
    if (!behaviortreeentity asmistransitionrunning()) {
        behaviortreeentity setblackboardattribute("_stance", "stand");
        if (!isdefined(behaviortreeentity.replannedcoverarrival)) {
            behaviortreeentity.ai.replannedcoverarrival = 0;
        }
    } else {
        behaviortreeentity.ai.replannedcoverarrival = undefined;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x1e807b37, Offset: 0x1d48
// Size: 0x38
function private prepareformovement(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_stance", "stand");
    return true;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x8ec37909, Offset: 0x1d88
// Size: 0x30
function private isarrivingfour(arrivalangle) {
    if (arrivalangle >= 45 && arrivalangle <= 120) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x25a6c404, Offset: 0x1dc0
// Size: 0x30
function private isarrivingone(arrivalangle) {
    if (arrivalangle >= 120 && arrivalangle <= 165) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x6fb83e7e, Offset: 0x1df8
// Size: 0x30
function private isarrivingtwo(arrivalangle) {
    if (arrivalangle >= 165 && arrivalangle <= 195) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xbc2076d, Offset: 0x1e30
// Size: 0x30
function private isarrivingthree(arrivalangle) {
    if (arrivalangle >= 195 && arrivalangle <= 240) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x15f3ef9d, Offset: 0x1e68
// Size: 0x30
function private isarrivingsix(arrivalangle) {
    if (arrivalangle >= 240 && arrivalangle <= 315) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xa4aa597d, Offset: 0x1ea0
// Size: 0x30
function private isfacingfour(facingangle) {
    if (facingangle >= 45 && facingangle <= 135) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xb1cf8bfb, Offset: 0x1ed8
// Size: 0x30
function private isfacingeight(facingangle) {
    if (facingangle >= -45 && facingangle <= 45) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x9647eac7, Offset: 0x1f10
// Size: 0x2e
function private isfacingseven(facingangle) {
    if (facingangle >= 0 && facingangle <= 90) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xd5537135, Offset: 0x1f48
// Size: 0x30
function private isfacingsix(facingangle) {
    if (facingangle >= -135 && facingangle <= -45) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x67632f10, Offset: 0x1f80
// Size: 0x2e
function private isfacingnine(facingangle) {
    if (facingangle >= -90 && facingangle <= 0) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x71616f24, Offset: 0x1fb8
// Size: 0x400
function private shouldtacticalarrivecondition(behaviortreeentity) {
    if (getdvarint("enableTacticalArrival") != 1) {
        return false;
    }
    if (!isdefined(behaviortreeentity.node)) {
        return false;
    }
    if (!(behaviortreeentity.node.type == "Cover Left")) {
        return false;
    }
    stance = behaviortreeentity getblackboardattribute("_arrival_stance");
    if (stance != "stand") {
        return false;
    }
    arrivaldistance = 35;
    /#
        arrivaldvar = getdvarint("<dev string:x28>");
        if (arrivaldvar != 0) {
            arrivaldistance = arrivaldvar;
        }
    #/
    nodeoffsetposition = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);
    if (distance(nodeoffsetposition, behaviortreeentity.origin) > arrivaldistance || distance(nodeoffsetposition, behaviortreeentity.origin) < 25) {
        return false;
    }
    entityangles = vectortoangles(behaviortreeentity.origin - nodeoffsetposition);
    if (abs(behaviortreeentity.node.angles[1] - entityangles[1]) < 60) {
        return false;
    }
    tacticalfaceangle = behaviortreeentity getblackboardattribute("_tactical_arrival_facing_yaw");
    arrivalangle = behaviortreeentity getblackboardattribute("_locomotion_arrival_yaw");
    if (isarrivingfour(arrivalangle)) {
        if (!isfacingsix(tacticalfaceangle) && !isfacingeight(tacticalfaceangle) && !isfacingfour(tacticalfaceangle)) {
            return false;
        }
    } else if (isarrivingone(arrivalangle)) {
        if (!isfacingnine(tacticalfaceangle) && !isfacingseven(tacticalfaceangle)) {
            return false;
        }
    } else if (isarrivingtwo(arrivalangle)) {
        if (!isfacingeight(tacticalfaceangle)) {
            return false;
        }
    } else if (isarrivingthree(arrivalangle)) {
        if (!isfacingseven(tacticalfaceangle) && !isfacingnine(tacticalfaceangle)) {
            return false;
        }
    } else if (isarrivingsix(arrivalangle)) {
        if (!isfacingfour(tacticalfaceangle) && !isfacingeight(tacticalfaceangle) && !isfacingsix(tacticalfaceangle)) {
            return false;
        }
    } else {
        return false;
    }
    return true;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 0, eflags: 0x4
// Checksum 0x4c20cee9, Offset: 0x23c0
// Size: 0x3c
function private humanshouldsprint() {
    currentlocomovementtype = self getblackboardattribute("_human_locomotion_movement_type");
    return currentlocomovementtype == "human_locomotion_movement_sprint";
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 2, eflags: 0x4
// Checksum 0xabf84dd, Offset: 0x2408
// Size: 0x57c
function private planhumanarrivalatcover(behaviortreeentity, arrivalanim) {
    if (behaviortreeentity ai::get_behavior_attribute("disablearrivals")) {
        return false;
    }
    behaviortreeentity setblackboardattribute("_desired_stance", "stand");
    if (!isdefined(arrivalanim)) {
        return false;
    }
    if (isdefined(behaviortreeentity.node) && isdefined(behaviortreeentity.pathgoalpos)) {
        if (!iscovernode(behaviortreeentity.node)) {
            return false;
        }
        nodeoffsetposition = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);
        if (nodeoffsetposition != behaviortreeentity.pathgoalpos) {
            return false;
        }
        if (isdefined(arrivalanim)) {
            isright = behaviortreeentity.node.type == "Cover Right";
            splittime = getarrivalsplittime(arrivalanim, isright);
            issplitarrival = splittime < 1;
            nodeapproachyaw = behaviortreeentity getnodeoffsetangles(behaviortreeentity.node)[1];
            angle = (0, nodeapproachyaw - getangledelta(arrivalanim), 0);
            if (issplitarrival) {
                forwarddir = anglestoforward(angle);
                rightdir = anglestoright(angle);
                animlength = getanimlength(arrivalanim);
                movedelta = getmovedelta(arrivalanim, 0, (animlength - 0.2) / animlength);
                premovedelta = getmovedelta(arrivalanim, 0, splittime);
                postmovedelta = movedelta - premovedelta;
                forward = vectorscale(forwarddir, postmovedelta[0]);
                right = vectorscale(rightdir, postmovedelta[1]);
                coverenterpos = nodeoffsetposition - forward + right;
                postenterpos = coverenterpos;
                forward = vectorscale(forwarddir, premovedelta[0]);
                right = vectorscale(rightdir, premovedelta[1]);
                coverenterpos = coverenterpos - forward + right;
                /#
                    recordline(postenterpos, nodeoffsetposition, (1, 0.5, 0), "<dev string:x3b>", behaviortreeentity);
                    recordline(coverenterpos, postenterpos, (1, 0.5, 0), "<dev string:x3b>", behaviortreeentity);
                #/
                if (!behaviortreeentity maymovefrompointtopoint(postenterpos, nodeoffsetposition, 1, 0)) {
                    return false;
                }
                if (!behaviortreeentity maymovefrompointtopoint(coverenterpos, postenterpos, 1, 0)) {
                    return false;
                }
            } else {
                forwarddir = anglestoforward(angle);
                rightdir = anglestoright(angle);
                movedeltaarray = getmovedelta(arrivalanim);
                forward = vectorscale(forwarddir, movedeltaarray[0]);
                right = vectorscale(rightdir, movedeltaarray[1]);
                coverenterpos = nodeoffsetposition - forward + right;
                if (!behaviortreeentity maymovefrompointtopoint(coverenterpos, nodeoffsetposition, 1, 1)) {
                    return false;
                }
            }
            if (!checkcoverarrivalconditions(coverenterpos, nodeoffsetposition)) {
                return false;
            }
            if (ispointonnavmesh(coverenterpos, behaviortreeentity)) {
                /#
                    recordcircle(coverenterpos, 2, (1, 0, 0), "<dev string:x46>", behaviortreeentity);
                #/
                behaviortreeentity useposition(coverenterpos, behaviortreeentity.pathgoalpos);
                return true;
            }
        }
    }
    return false;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 2, eflags: 0x4
// Checksum 0xa7a08c8a, Offset: 0x2990
// Size: 0x2dc
function private checkcoverarrivalconditions(coverenterpos, coverpos) {
    distsqtonode = distancesquared(self.origin, coverpos);
    distsqfromnodetoenterpos = distancesquared(coverpos, coverenterpos);
    awayfromenterpos = distsqtonode >= distsqfromnodetoenterpos + 150;
    if (!awayfromenterpos) {
        return false;
    }
    trace = groundtrace(coverenterpos + (0, 0, 72), coverenterpos + (0, 0, -72), 0, 0, 0);
    if (isdefined(trace["position"]) && abs(trace["position"][2] - coverpos[2]) > 30) {
        /#
            if (getdvarint("<dev string:x4d>")) {
                recordcircle(coverenterpos, 1, (1, 0, 0), "<dev string:x3b>");
                record3dtext("<dev string:x5e>", coverenterpos, (1, 0, 0), "<dev string:x3b>", undefined, 0.4);
                recordcircle(trace["<dev string:x75>"], 1, (1, 0, 0), "<dev string:x3b>");
                record3dtext("<dev string:x7e>" + int(abs(trace["<dev string:x75>"][2] - coverpos[2])), trace["<dev string:x75>"] + (0, 0, 5), (1, 0, 0), "<dev string:x3b>", undefined, 0.4);
                record3dtext("<dev string:x93>" + 30, trace["<dev string:x75>"], (1, 0, 0), "<dev string:x3b>", undefined, 0.4);
                recordline(coverenterpos, trace["<dev string:x75>"], (1, 0, 0), "<dev string:x3b>");
            }
        #/
        return false;
    }
    return true;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 2, eflags: 0x4
// Checksum 0xa6f1d36a, Offset: 0x2c78
// Size: 0x2ea
function private getarrivalsplittime(arrivalanim, isright) {
    if (!isdefined(level.animarrivalsplittimes)) {
        level.animarrivalsplittimes = [];
    }
    if (isdefined(level.animarrivalsplittimes[arrivalanim])) {
        return level.animarrivalsplittimes[arrivalanim];
    }
    bestsplit = -1;
    if (animhasnotetrack(arrivalanim, "cover_split")) {
        times = getnotetracktimes(arrivalanim, "cover_split");
        assert(times.size > 0);
        bestsplit = times[0];
    } else {
        animlength = getanimlength(arrivalanim);
        var_be6be71a = (animlength - 0.2) / animlength;
        angledelta = getangledelta(arrivalanim, 0, var_be6be71a);
        var_a346de34 = getmovedelta(arrivalanim, 0, var_be6be71a);
        bestvalue = -100000000;
        for (i = 0; i < 100; i++) {
            splittime = 1 * i / (100 - 1);
            delta = getmovedelta(arrivalanim, 0, splittime);
            delta = deltarotate(var_a346de34 - delta, 180 - angledelta);
            if (isright) {
                delta = (delta[0], 0 - delta[1], delta[2]);
            }
            val = min(delta[0] - 32, delta[1]);
            if (val > bestvalue || bestsplit < 0) {
                bestvalue = val;
                bestsplit = splittime;
            }
        }
    }
    level.animarrivalsplittimes[arrivalanim] = bestsplit;
    return bestsplit;
}

// Namespace archetype_human_locomotion/archetype_human_locomotion
// Params 2, eflags: 0x4
// Checksum 0xe1d74c28, Offset: 0x2f70
// Size: 0x9c
function private deltarotate(delta, yaw) {
    cosine = cos(yaw);
    sine = sin(yaw);
    return (delta[0] * cosine - delta[1] * sine, delta[1] * cosine + delta[0] * sine, 0);
}

