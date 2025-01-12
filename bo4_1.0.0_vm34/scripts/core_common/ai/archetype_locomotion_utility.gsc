#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\math_shared;

#namespace aiutility;

// Namespace aiutility/archetype_locomotion_utility
// Params 0, eflags: 0x2
// Checksum 0x626a8620, Offset: 0x2c0
// Size: 0x12f4
function autoexec registerbehaviorscriptfunctions() {
    assert(iscodefunctionptr(&btapi_locomotionbehaviorcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_locomotionbehaviorcondition", &btapi_locomotionbehaviorcondition);
    assert(iscodefunctionptr(&btapi_locomotionbehaviorcondition));
    behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_locomotionbehaviorcondition", &btapi_locomotionbehaviorcondition);
    assert(isscriptfunctionptr(&noncombatlocomotioncondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"noncombatlocomotioncondition", &noncombatlocomotioncondition);
    assert(isscriptfunctionptr(&setdesiredstanceformovement));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"setdesiredstanceformovement", &setdesiredstanceformovement);
    assert(isscriptfunctionptr(&clearpathfromscript));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"clearpathfromscript", &clearpathfromscript);
    assert(isscriptfunctionptr(&locomotionshouldpatrol));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldpatrol", &locomotionshouldpatrol);
    assert(isscriptfunctionptr(&locomotionshouldpatrol));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldpatrol", &locomotionshouldpatrol);
    assert(iscodefunctionptr(&btapi_shouldtacticalwalk));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btApi_shouldtacticalwalk", &btapi_shouldtacticalwalk);
    assert(isscriptfunctionptr(&shouldtacticalwalk));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldtacticalwalk", &shouldtacticalwalk);
    assert(iscodefunctionptr(&btapi_shouldtacticalwalk));
    behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldtacticalwalk", &btapi_shouldtacticalwalk);
    assert(isscriptfunctionptr(&shouldtacticalwalk));
    behaviorstatemachine::registerbsmscriptapiinternal(#"shouldtacticalwalk", &shouldtacticalwalk);
    assert(isscriptfunctionptr(&shouldadjuststanceattacticalwalk));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldadjuststanceattacticalwalk", &shouldadjuststanceattacticalwalk);
    assert(isscriptfunctionptr(&adjuststancetofaceenemyinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"adjuststancetofaceenemyinitialize", &adjuststancetofaceenemyinitialize);
    assert(isscriptfunctionptr(&adjuststancetofaceenemyterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"adjuststancetofaceenemyterminate", &adjuststancetofaceenemyterminate);
    assert(isscriptfunctionptr(&tacticalwalkactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"tacticalwalkactionstart", &tacticalwalkactionstart);
    assert(isscriptfunctionptr(&tacticalwalkactionstart));
    behaviorstatemachine::registerbsmscriptapiinternal(#"tacticalwalkactionstart", &tacticalwalkactionstart);
    assert(isscriptfunctionptr(&cleararrivalpos));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleararrivalpos", &cleararrivalpos);
    assert(isscriptfunctionptr(&cleararrivalpos));
    behaviorstatemachine::registerbsmscriptapiinternal(#"cleararrivalpos", &cleararrivalpos);
    assert(isscriptfunctionptr(&shouldstartarrivalcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstartarrival", &shouldstartarrivalcondition);
    assert(isscriptfunctionptr(&shouldstartarrivalcondition));
    behaviorstatemachine::registerbsmscriptapiinternal(#"shouldstartarrival", &shouldstartarrivalcondition);
    assert(isscriptfunctionptr(&locomotionshouldtraverse));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldtraverse", &locomotionshouldtraverse);
    assert(isscriptfunctionptr(&locomotionshouldtraverse));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldtraverse", &locomotionshouldtraverse);
    assert(isscriptfunctionptr(&locomotionshouldparametrictraverse));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldparametrictraverse", &locomotionshouldparametrictraverse);
    assert(isscriptfunctionptr(&locomotionshouldparametrictraverse));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldparametrictraverse", &locomotionshouldparametrictraverse);
    assert(isscriptfunctionptr(&function_66d19120));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7234c48b18665dc6", &function_66d19120);
    assert(isscriptfunctionptr(&function_66d19120));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7234c48b18665dc6", &function_66d19120);
    assert(isscriptfunctionptr(&function_5f392256));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4c93e133d3b1accc", &function_5f392256);
    assert(isscriptfunctionptr(&function_5f392256));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4c93e133d3b1accc", &function_5f392256);
    assert(isscriptfunctionptr(&traverseactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"traverseactionstart", &traverseactionstart);
    assert(isscriptfunctionptr(&function_e745ade6));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5d1b3df7dd4e60c0", &function_e745ade6);
    assert(!isdefined(&traverseactionstart) || isscriptfunctionptr(&traverseactionstart));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_e745ade6) || isscriptfunctionptr(&function_e745ade6));
    behaviortreenetworkutility::registerbehaviortreeaction(#"traverseactionstart", &traverseactionstart, undefined, &function_e745ade6);
    assert(isscriptfunctionptr(&traversesetup));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"traversesetup", &traversesetup);
    assert(isscriptfunctionptr(&traversesetup));
    behaviorstatemachine::registerbsmscriptapiinternal(#"traversesetup", &traversesetup);
    assert(isscriptfunctionptr(&disablerepath));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"disablerepath", &disablerepath);
    assert(isscriptfunctionptr(&enablerepath));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"enablerepath", &enablerepath);
    assert(isscriptfunctionptr(&canjuke));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"canjuke", &canjuke);
    assert(isscriptfunctionptr(&choosejukedirection));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"choosejukedirection", &choosejukedirection);
    assert(isscriptfunctionptr(&locomotionpainbehaviorcondition));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionpainbehaviorcondition", &locomotionpainbehaviorcondition);
    assert(isscriptfunctionptr(&locomotionisonstairs));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionisonstairs", &locomotionisonstairs);
    assert(isscriptfunctionptr(&locomotionshouldlooponstairs));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldlooponstairs", &locomotionshouldlooponstairs);
    assert(isscriptfunctionptr(&locomotionshouldskipstairs));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldskipstairs", &locomotionshouldskipstairs);
    assert(isscriptfunctionptr(&locomotionstairsstart));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionstairsstart", &locomotionstairsstart);
    assert(isscriptfunctionptr(&locomotionstairsend));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionstairsend", &locomotionstairsend);
    assert(isscriptfunctionptr(&delaymovement));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"delaymovement", &delaymovement);
    assert(isscriptfunctionptr(&delaymovement));
    behaviorstatemachine::registerbsmscriptapiinternal(#"delaymovement", &delaymovement);
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x7ed42acd, Offset: 0x15c0
// Size: 0x90
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
// Checksum 0x1b2529ce, Offset: 0x1658
// Size: 0x150
function private locomotionshouldskipstairs(behaviortreeentity) {
    assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
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
// Checksum 0x410803aa, Offset: 0x17b0
// Size: 0x19c
function private locomotionshouldlooponstairs(behaviortreeentity) {
    assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
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
        case #"staircase_up_exit_r_4_stairs":
        case #"staircase_up_exit_l_4_stairs":
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
// Checksum 0x2ea5ffc0, Offset: 0x1958
// Size: 0x3a0
function private locomotionstairsstart(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    endnode = behaviortreeentity.traverseendnode;
    assert(isdefined(startnode) && isdefined(endnode));
    behaviortreeentity._stairsstartnode = startnode;
    behaviortreeentity._stairsendnode = endnode;
    if (startnode.type == #"begin") {
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
    assert(isdefined(numtotalsteps) && isint(numtotalsteps) && numtotalsteps > 0);
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
// Checksum 0x8fb51917, Offset: 0x1d00
// Size: 0x64
function private locomotionstairloopstart(behaviortreeentity) {
    assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
    behaviortreeentity setblackboardattribute("_staircase_state", "staircase_loop");
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x4f88b7ab, Offset: 0x1d70
// Size: 0x4c
function private locomotionstairsend(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_staircase_state", undefined);
    behaviortreeentity setblackboardattribute("_staircase_direction", undefined);
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x51f871d1, Offset: 0x1dc8
// Size: 0x44
function private locomotionpainbehaviorcondition(entity) {
    return entity haspath() && entity hasvalidinterrupt("pain");
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0x2f9e6cf2, Offset: 0x1e18
// Size: 0x24
function clearpathfromscript(behaviortreeentity) {
    behaviortreeentity clearpath();
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x7d603ab9, Offset: 0x1e48
// Size: 0x6c
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
// Checksum 0x4b0b40d, Offset: 0x1ec0
// Size: 0x68
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
// Checksum 0x2536d911, Offset: 0x1f30
// Size: 0x5c
function private setdesiredstanceformovement(behaviortreeentity) {
    if (behaviortreeentity getblackboardattribute("_stance") != "stand") {
        behaviortreeentity setblackboardattribute("_desired_stance", "stand");
    }
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x9e5eebe3, Offset: 0x1f98
// Size: 0x7c
function private locomotionshouldtraverse(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    if (isdefined(startnode) && behaviortreeentity shouldstarttraversal()) {
        /#
            record3dtext("<dev string:x30>", self.origin, (1, 0, 0), "<dev string:x43>");
        #/
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x3ab11cd6, Offset: 0x2020
// Size: 0xa4
function private locomotionshouldparametrictraverse(entity) {
    startnode = entity.traversestartnode;
    if (isdefined(startnode) && entity shouldstarttraversal()) {
        traversaltype = entity getblackboardattribute("_parametric_traversal_type");
        /#
            record3dtext("<dev string:x30>", self.origin, (1, 0, 0), "<dev string:x43>");
        #/
        return (traversaltype != "unknown_traversal");
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x781ee991, Offset: 0x20d0
// Size: 0x7c
function private function_66d19120(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    if (isdefined(startnode) && behaviortreeentity function_e444be7()) {
        /#
            record3dtext("<dev string:x4a>", self.origin, (1, 0, 0), "<dev string:x43>");
        #/
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xa120b40d, Offset: 0x2158
// Size: 0xa4
function private function_5f392256(entity) {
    startnode = entity.traversestartnode;
    if (isdefined(startnode) && entity function_e444be7()) {
        traversaltype = entity getblackboardattribute("_parametric_traversal_type");
        /#
            record3dtext("<dev string:x4a>", self.origin, (1, 0, 0), "<dev string:x43>");
        #/
        return (traversaltype != "unknown_traversal");
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x654c4dd0, Offset: 0x2208
// Size: 0x68
function private traversesetup(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_stance", "stand");
    behaviortreeentity setblackboardattribute("_traversal_type", behaviortreeentity.traversestartnode.animscript);
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 2, eflags: 0x0
// Checksum 0x5b56713c, Offset: 0x2278
// Size: 0x1e0
function traverseactionstart(behaviortreeentity, asmstatename) {
    traversesetup(behaviortreeentity);
    behaviortreeentity.var_3eef3edd = behaviortreeentity function_bdc3a55();
    behaviortreeentity.var_9e3eb0cb = behaviortreeentity function_f371816c();
    behaviortreeentity allowpitchangle(0);
    behaviortreeentity clearpitchorient();
    /#
        result = behaviortreeentity astsearch(asmstatename);
        if (!isdefined(result[#"animation"])) {
            record3dtext("<dev string:x60>", self.origin + (0, 0, 16), (1, 0, 0), "<dev string:x43>");
        } else {
            record3dtext("<dev string:x96>" + (ishash(result[#"animation"]) ? function_15979fa9(result[#"animation"]) : result[#"animation"]), self.origin + (0, 0, 16), (1, 0, 0), "<dev string:x43>");
        }
    #/
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 2, eflags: 0x0
// Checksum 0xc8d07fb8, Offset: 0x2460
// Size: 0x96
function function_e745ade6(behaviortreeentity, asmstatename) {
    behaviortreeentity allowpitchangle(isdefined(behaviortreeentity.var_3eef3edd) && behaviortreeentity.var_3eef3edd);
    if (isdefined(behaviortreeentity.var_9e3eb0cb) && behaviortreeentity.var_9e3eb0cb) {
        behaviortreeentity setpitchorient();
    }
    behaviortreeentity.var_3eef3edd = undefined;
    behaviortreeentity.var_9e3eb0cb = undefined;
    return 4;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x5b410545, Offset: 0x2500
// Size: 0x1a
function private disablerepath(entity) {
    entity.disablerepath = 1;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xda6851fc, Offset: 0x2528
// Size: 0x1a
function private enablerepath(entity) {
    entity.disablerepath = 0;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0x63f5a803, Offset: 0x2550
// Size: 0x2e
function shouldstartarrivalcondition(behaviortreeentity) {
    if (behaviortreeentity shouldstartarrival()) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0xcf4b6e02, Offset: 0x2588
// Size: 0x58
function cleararrivalpos(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.isarrivalpending) || isdefined(behaviortreeentity.isarrivalpending) && behaviortreeentity.isarrivalpending) {
        self function_9f59031e();
    }
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0xfe3f337d, Offset: 0x25e8
// Size: 0x48
function delaymovement(entity) {
    entity pathmode("move delayed", 0, randomfloatrange(1, 2));
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x5d7d9382, Offset: 0x2638
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
// Checksum 0xbb177177, Offset: 0x2690
// Size: 0x60
function private adjuststancetofaceenemyinitialize(behaviortreeentity) {
    behaviortreeentity.newenemyreaction = 0;
    behaviortreeentity setblackboardattribute("_desired_stance", "stand");
    behaviortreeentity orientmode("face enemy");
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x7f2ceec4, Offset: 0x26f8
// Size: 0x34
function private adjuststancetofaceenemyterminate(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_stance", "stand");
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xd4e2986c, Offset: 0x2738
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
// Checksum 0x19192d72, Offset: 0x27e0
// Size: 0x134
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
// Checksum 0xcef5d371, Offset: 0x2920
// Size: 0x2d4
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
// Checksum 0x572a58e5, Offset: 0x2c00
// Size: 0x82
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
// Checksum 0x9f51cf44, Offset: 0x2c90
// Size: 0xd4
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
// Checksum 0x8fafc47c, Offset: 0x2d70
// Size: 0x4c
function choosejukedirection(entity) {
    jukedirection = calculatedefaultjukedirection(entity);
    entity setblackboardattribute("_juke_direction", jukedirection);
}

