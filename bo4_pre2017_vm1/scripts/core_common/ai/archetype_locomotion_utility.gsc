#using scripts/core_common/ai/archetype_cover_utility;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_state_machine;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai_shared;
#using scripts/core_common/math_shared;

#namespace aiutility;

// Namespace aiutility/archetype_locomotion_utility
// Params 0, eflags: 0x2
// Checksum 0x18166784, Offset: 0x6b8
// Size: 0xed4
function autoexec registerbehaviorscriptfunctions() {
    /#
        assert(iscodefunctionptr(&btapi_locomotionbehaviorcondition));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("btApi_locomotionBehaviorCondition", &btapi_locomotionbehaviorcondition);
    /#
        assert(iscodefunctionptr(&btapi_locomotionbehaviorcondition));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("btApi_locomotionBehaviorCondition", &btapi_locomotionbehaviorcondition);
    /#
        assert(isscriptfunctionptr(&noncombatlocomotioncondition));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("nonCombatLocomotionCondition", &noncombatlocomotioncondition);
    /#
        assert(isscriptfunctionptr(&setdesiredstanceformovement));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("setDesiredStanceForMovement", &setdesiredstanceformovement);
    /#
        assert(isscriptfunctionptr(&clearpathfromscript));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("clearPathFromScript", &clearpathfromscript);
    /#
        assert(isscriptfunctionptr(&locomotionshouldpatrol));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionShouldPatrol", &locomotionshouldpatrol);
    /#
        assert(isscriptfunctionptr(&locomotionshouldpatrol));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldPatrol", &locomotionshouldpatrol);
    /#
        assert(iscodefunctionptr(&btapi_shouldtacticalwalk));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("btApi_shouldtacticalwalk", &btapi_shouldtacticalwalk);
    /#
        assert(isscriptfunctionptr(&shouldtacticalwalk));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldTacticalWalk", &shouldtacticalwalk);
    /#
        assert(iscodefunctionptr(&btapi_shouldtacticalwalk));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("btApi_shouldtacticalwalk", &btapi_shouldtacticalwalk);
    /#
        assert(isscriptfunctionptr(&shouldtacticalwalk));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("shouldTacticalWalk", &shouldtacticalwalk);
    /#
        assert(isscriptfunctionptr(&shouldadjuststanceattacticalwalk));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldAdjustStanceAtTacticalWalk", &shouldadjuststanceattacticalwalk);
    /#
        assert(isscriptfunctionptr(&adjuststancetofaceenemyinitialize));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("adjustStanceToFaceEnemyInitialize", &adjuststancetofaceenemyinitialize);
    /#
        assert(isscriptfunctionptr(&adjuststancetofaceenemyterminate));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("adjustStanceToFaceEnemyTerminate", &adjuststancetofaceenemyterminate);
    /#
        assert(isscriptfunctionptr(&tacticalwalkactionstart));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("tacticalWalkActionStart", &tacticalwalkactionstart);
    /#
        assert(isscriptfunctionptr(&tacticalwalkactionstart));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("tacticalWalkActionStart", &tacticalwalkactionstart);
    /#
        assert(isscriptfunctionptr(&cleararrivalpos));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("clearArrivalPos", &cleararrivalpos);
    /#
        assert(isscriptfunctionptr(&cleararrivalpos));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("clearArrivalPos", &cleararrivalpos);
    /#
        assert(isscriptfunctionptr(&shouldstartarrivalcondition));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStartArrival", &shouldstartarrivalcondition);
    /#
        assert(isscriptfunctionptr(&shouldstartarrivalcondition));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("shouldStartArrival", &shouldstartarrivalcondition);
    /#
        assert(isscriptfunctionptr(&locomotionshouldtraverse));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionShouldTraverse", &locomotionshouldtraverse);
    /#
        assert(isscriptfunctionptr(&locomotionshouldtraverse));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldTraverse", &locomotionshouldtraverse);
    /#
        assert(isscriptfunctionptr(&locomotionshouldparametrictraverse));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionShouldParametricTraverse", &locomotionshouldparametrictraverse);
    /#
        assert(isscriptfunctionptr(&locomotionshouldparametrictraverse));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldParametricTraverse", &locomotionshouldparametrictraverse);
    /#
        assert(!isdefined(&traverseactionstart) || isscriptfunctionptr(&traverseactionstart));
    #/
    /#
        assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    #/
    /#
        assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    #/
    behaviortreenetworkutility::registerbehaviortreeaction("traverseActionStart", &traverseactionstart, undefined, undefined);
    /#
        assert(isscriptfunctionptr(&traversesetup));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("traverseSetup", &traversesetup);
    /#
        assert(isscriptfunctionptr(&disablerepath));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("disableRepath", &disablerepath);
    /#
        assert(isscriptfunctionptr(&enablerepath));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("enableRepath", &enablerepath);
    /#
        assert(isscriptfunctionptr(&canjuke));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("canJuke", &canjuke);
    /#
        assert(isscriptfunctionptr(&choosejukedirection));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("chooseJukeDirection", &choosejukedirection);
    /#
        assert(isscriptfunctionptr(&locomotionpainbehaviorcondition));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionPainBehaviorCondition", &locomotionpainbehaviorcondition);
    /#
        assert(isscriptfunctionptr(&locomotionisonstairs));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionIsOnStairs", &locomotionisonstairs);
    /#
        assert(isscriptfunctionptr(&locomotionshouldlooponstairs));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldLoopOnStairs", &locomotionshouldlooponstairs);
    /#
        assert(isscriptfunctionptr(&locomotionshouldskipstairs));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldSkipStairs", &locomotionshouldskipstairs);
    /#
        assert(isscriptfunctionptr(&locomotionstairsstart));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionStairsStart", &locomotionstairsstart);
    /#
        assert(isscriptfunctionptr(&locomotionstairsend));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionStairsEnd", &locomotionstairsend);
    /#
        assert(isscriptfunctionptr(&delaymovement));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("delayMovement", &delaymovement);
    /#
        assert(isscriptfunctionptr(&delaymovement));
    #/
    behaviorstatemachine::registerbsmscriptapiinternal("delayMovement", &delaymovement);
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x12d2e22b, Offset: 0x1598
// Size: 0xa6
function private locomotionisonstairs(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    if (isdefined(startnode) && behaviortreeentity shouldstarttraversal()) {
        if (isdefined(startnode.animscript) && issubstr(tolower(startnode.animscript), "stairs")) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x81af5141, Offset: 0x1648
// Size: 0x15a
function private locomotionshouldskipstairs(behaviortreeentity) {
    /#
        assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
    #/
    numtotalsteps = behaviortreeentity getblackboardattribute("_staircase_num_total_steps");
    stepssofar = behaviortreeentity getblackboardattribute("_staircase_num_steps");
    direction = behaviortreeentity getblackboardattribute("_staircase_direction");
    if (direction != "staircase_up") {
        return false;
    }
    numoutsteps = 2;
    totalstepswithoutout = numtotalsteps - numoutsteps;
    if (stepssofar >= totalstepswithoutout) {
        return false;
    }
    remainingsteps = totalstepswithoutout - stepssofar;
    if (remainingsteps >= 3 || remainingsteps >= 6 || remainingsteps >= 8) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x5f088980, Offset: 0x17b0
// Size: 0x18c
function private locomotionshouldlooponstairs(behaviortreeentity) {
    /#
        assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
    #/
    numtotalsteps = behaviortreeentity getblackboardattribute("_staircase_num_total_steps");
    stepssofar = behaviortreeentity getblackboardattribute("_staircase_num_steps");
    exittype = behaviortreeentity getblackboardattribute("_staircase_exit_type");
    direction = behaviortreeentity getblackboardattribute("_staircase_direction");
    numoutsteps = 2;
    if (direction == "staircase_up") {
        switch (exittype) {
        case #"staircase_up_exit_l_3_stairs":
        case #"staircase_up_exit_r_3_stairs":
            numoutsteps = 3;
            break;
        case #"staircase_up_exit_l_4_stairs":
        case #"staircase_up_exit_r_4_stairs":
            numoutsteps = 4;
            break;
        }
    }
    if (stepssofar >= numtotalsteps - numoutsteps) {
        behaviortreeentity setstairsexittransform();
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x5380bf8, Offset: 0x1948
// Size: 0x390
function private locomotionstairsstart(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    endnode = behaviortreeentity.traverseendnode;
    /#
        assert(isdefined(startnode) && isdefined(endnode));
    #/
    behaviortreeentity._stairsstartnode = startnode;
    behaviortreeentity._stairsendnode = endnode;
    if (startnode.type == "Begin") {
        direction = "staircase_down";
    } else {
        direction = "staircase_up";
    }
    behaviortreeentity setblackboardattribute("_staircase_type", behaviortreeentity._stairsstartnode.animscript);
    behaviortreeentity setblackboardattribute("_staircase_state", "staircase_start");
    behaviortreeentity setblackboardattribute("_staircase_direction", direction);
    numtotalsteps = undefined;
    if (isdefined(startnode.script_int)) {
        numtotalsteps = int(endnode.script_int);
    } else if (isdefined(endnode.script_int)) {
        numtotalsteps = int(endnode.script_int);
    }
    /#
        assert(isdefined(numtotalsteps) && isint(numtotalsteps) && numtotalsteps > 0);
    #/
    behaviortreeentity setblackboardattribute("_staircase_num_total_steps", numtotalsteps);
    behaviortreeentity setblackboardattribute("_staircase_num_steps", 0);
    exittype = undefined;
    if (direction == "staircase_up") {
        switch (int(behaviortreeentity._stairsstartnode.script_int) % 4) {
        case 0:
            exittype = "staircase_up_exit_r_3_stairs";
            break;
        case 1:
            exittype = "staircase_up_exit_r_4_stairs";
            break;
        case 2:
            exittype = "staircase_up_exit_l_3_stairs";
            break;
        case 3:
            exittype = "staircase_up_exit_l_4_stairs";
            break;
        }
    } else {
        switch (int(behaviortreeentity._stairsstartnode.script_int) % 2) {
        case 0:
            exittype = "staircase_down_exit_l_2_stairs";
            break;
        case 1:
            exittype = "staircase_down_exit_r_2_stairs";
            break;
        }
    }
    behaviortreeentity setblackboardattribute("_staircase_exit_type", exittype);
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x87672ddc, Offset: 0x1ce0
// Size: 0x6c
function private locomotionstairloopstart(behaviortreeentity) {
    /#
        assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
    #/
    behaviortreeentity setblackboardattribute("_staircase_state", "staircase_loop");
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x55fc87, Offset: 0x1d58
// Size: 0x4c
function private locomotionstairsend(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_staircase_state", undefined);
    behaviortreeentity setblackboardattribute("_staircase_direction", undefined);
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x7f475c6, Offset: 0x1db0
// Size: 0x42
function private locomotionpainbehaviorcondition(entity) {
    return entity haspath() && entity hasvalidinterrupt("pain");
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0xdeb6c6e8, Offset: 0x1e00
// Size: 0x24
function clearpathfromscript(behaviortreeentity) {
    behaviortreeentity clearpath();
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xe6d42343, Offset: 0x1e30
// Size: 0x70
function private noncombatlocomotioncondition(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
        return true;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xbe8d8a14, Offset: 0x1ea8
// Size: 0x6c
function private combatlocomotioncondition(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
        return false;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xd08e12b9, Offset: 0x1f20
// Size: 0x5c
function private setdesiredstanceformovement(behaviortreeentity) {
    if (behaviortreeentity getblackboardattribute("_stance") != "stand") {
        behaviortreeentity setblackboardattribute("_desired_stance", "stand");
    }
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x97356d7e, Offset: 0x1f88
// Size: 0x56
function private locomotionshouldtraverse(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    if (isdefined(startnode) && behaviortreeentity shouldstarttraversal()) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x40ace93c, Offset: 0x1fe8
// Size: 0x88
function private locomotionshouldparametrictraverse(entity) {
    startnode = entity.traversestartnode;
    if (isdefined(startnode) && entity shouldstarttraversal()) {
        traversaltype = entity getblackboardattribute("_parametric_traversal_type");
        return (traversaltype != "unknown_traversal");
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x55b9537a, Offset: 0x2078
// Size: 0x68
function private traversesetup(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_stance", "stand");
    behaviortreeentity setblackboardattribute("_traversal_type", behaviortreeentity.traversestartnode.animscript);
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 2, eflags: 0x0
// Checksum 0x99f10bc9, Offset: 0x20e8
// Size: 0x100
function traverseactionstart(behaviortreeentity, asmstatename) {
    traversesetup(behaviortreeentity);
    /#
        var_be841c75 = behaviortreeentity astsearch(istring(asmstatename));
        /#
            assert(isdefined(var_be841c75["<dev string:x28>"]), behaviortreeentity.archetype + "<dev string:x32>" + behaviortreeentity.traversestartnode.animscript + "<dev string:x57>" + behaviortreeentity.traversestartnode.origin + "<dev string:x5b>");
        #/
    #/
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x8773a3d1, Offset: 0x21f0
// Size: 0x20
function private disablerepath(entity) {
    entity.disablerepath = 1;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x66746279, Offset: 0x2218
// Size: 0x1c
function private enablerepath(entity) {
    entity.disablerepath = 0;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0x222004d7, Offset: 0x2240
// Size: 0x2e
function shouldstartarrivalcondition(behaviortreeentity) {
    if (behaviortreeentity shouldstartarrival()) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0xbb2f1b30, Offset: 0x2278
// Size: 0x60
function cleararrivalpos(behaviortreeentity) {
    if (isdefined(behaviortreeentity.isarrivalpending) && (!isdefined(behaviortreeentity.isarrivalpending) || behaviortreeentity.isarrivalpending)) {
        self clearuseposition();
    }
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0x7a0c28a2, Offset: 0x22e0
// Size: 0x48
function delaymovement(entity) {
    entity pathmode("move delayed", 0, randomfloatrange(1, 2));
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xdb23b544, Offset: 0x2330
// Size: 0x50
function private shouldadjuststanceattacticalwalk(behaviortreeentity) {
    stance = behaviortreeentity getblackboardattribute("_stance");
    if (stance != "stand") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x3fb357c7, Offset: 0x2388
// Size: 0x68
function private adjuststancetofaceenemyinitialize(behaviortreeentity) {
    behaviortreeentity.newenemyreaction = 0;
    behaviortreeentity setblackboardattribute("_desired_stance", "stand");
    behaviortreeentity orientmode("face enemy");
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x16bb4b91, Offset: 0x23f8
// Size: 0x34
function private adjuststancetofaceenemyterminate(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_stance", "stand");
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x89e052bc, Offset: 0x2438
// Size: 0xa0
function private tacticalwalkactionstart(behaviortreeentity) {
    cleararrivalpos(behaviortreeentity);
    resetcoverparameters(behaviortreeentity);
    setcanbeflanked(behaviortreeentity, 0);
    behaviortreeentity setblackboardattribute("_stance", "stand");
    behaviortreeentity orientmode("face enemy");
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 4, eflags: 0x4
// Checksum 0x91a6ba2a, Offset: 0x24e0
// Size: 0x14e
function private validjukedirection(entity, entitynavmeshposition, forwardoffset, lateraloffset) {
    jukenavmeshthreshold = 6;
    forwardposition = entity.origin + lateraloffset + forwardoffset;
    backwardposition = entity.origin + lateraloffset - forwardoffset;
    forwardpositionvalid = ispointonnavmesh(forwardposition, entity) && tracepassedonnavmesh(entity.origin, forwardposition);
    backwardpositionvalid = ispointonnavmesh(backwardposition, entity) && tracepassedonnavmesh(entity.origin, backwardposition);
    if (!isdefined(entity.ignorebackwardposition)) {
        return (forwardpositionvalid && backwardpositionvalid);
    } else {
        return forwardpositionvalid;
    }
    return 0;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 3, eflags: 0x0
// Checksum 0x2cb59802, Offset: 0x2638
// Size: 0x31c
function calculatejukedirection(entity, entityradius, jukedistance) {
    jukenavmeshthreshold = 6;
    defaultdirection = "forward";
    if (isdefined(entity.defaultjukedirection)) {
        defaultdirection = entity.defaultjukedirection;
    }
    if (isdefined(entity.enemy)) {
        navmeshposition = getclosestpointonnavmesh(entity.origin, jukenavmeshthreshold);
        if (!isvec(navmeshposition)) {
            return defaultdirection;
        }
        vectortoenemy = entity.enemy.origin - entity.origin;
        vectortoenemyangles = vectortoangles(vectortoenemy);
        forwarddistance = anglestoforward(vectortoenemyangles) * entityradius;
        rightjukedistance = anglestoright(vectortoenemyangles) * jukedistance;
        preferleft = undefined;
        if (entity haspath()) {
            rightposition = entity.origin + rightjukedistance;
            leftposition = entity.origin - rightjukedistance;
            preferleft = distancesquared(leftposition, entity.pathgoalpos) <= distancesquared(rightposition, entity.pathgoalpos);
        } else {
            preferleft = math::cointoss();
        }
        if (preferleft) {
            if (validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance * -1)) {
                return "left";
            } else if (validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance)) {
                return "right";
            }
        } else if (validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance)) {
            return "right";
        } else if (validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance * -1)) {
            return "left";
        }
    }
    return defaultdirection;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x8d2e8716, Offset: 0x2960
// Size: 0x9a
function private calculatedefaultjukedirection(entity) {
    jukedistance = 30;
    entityradius = 15;
    if (isdefined(entity.jukedistance)) {
        jukedistance = entity.jukedistance;
    }
    if (isdefined(entity.entityradius)) {
        entityradius = entity.entityradius;
    }
    return calculatejukedirection(entity, entityradius, jukedistance);
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0xd010586d, Offset: 0x2a08
// Size: 0xec
function canjuke(entity) {
    if (isdefined(self.is_disabled) && self.is_disabled) {
        return false;
    }
    if (isdefined(entity.jukemaxdistance) && isdefined(entity.enemy)) {
        maxdistsquared = entity.jukemaxdistance * entity.jukemaxdistance;
        if (distance2dsquared(entity.origin, entity.enemy.origin) > maxdistsquared) {
            return false;
        }
    }
    jukedirection = calculatedefaultjukedirection(entity);
    return jukedirection != "forward";
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0x92a73282, Offset: 0x2b00
// Size: 0x54
function choosejukedirection(entity) {
    jukedirection = calculatedefaultjukedirection(entity);
    entity setblackboardattribute("_juke_direction", jukedirection);
}

