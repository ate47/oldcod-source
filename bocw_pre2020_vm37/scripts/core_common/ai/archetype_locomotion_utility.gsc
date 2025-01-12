#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\math_shared;

#namespace aiutility;

// Namespace aiutility/archetype_locomotion_utility
// Params 0, eflags: 0x2
// Checksum 0xf215b787, Offset: 0x338
// Size: 0x171c
function autoexec registerbehaviorscriptfunctions() {
    assert(iscodefunctionptr(&btapi_locomotionbehaviorcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_locomotionbehaviorcondition", &btapi_locomotionbehaviorcondition);
    assert(iscodefunctionptr(&btapi_locomotionbehaviorcondition));
    behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_locomotionbehaviorcondition", &btapi_locomotionbehaviorcondition);
    assert(isscriptfunctionptr(&setdesiredstanceformovement));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"setdesiredstanceformovement", &setdesiredstanceformovement);
    assert(isscriptfunctionptr(&clearpathfromscript));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"clearpathfromscript", &clearpathfromscript);
    assert(isscriptfunctionptr(&function_41b88b98));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleararrivalpos", &function_41b88b98);
    assert(isscriptfunctionptr(&function_41b88b98));
    behaviorstatemachine::registerbsmscriptapiinternal(#"cleararrivalpos", &function_41b88b98);
    assert(iscodefunctionptr(&btapi_shouldtacticalwalk));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btApi_shouldtacticalwalk", &btapi_shouldtacticalwalk);
    assert(iscodefunctionptr(&btapi_shouldtacticalwalk));
    behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldtacticalwalk", &btapi_shouldtacticalwalk);
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
    assert(isscriptfunctionptr(&function_63edf1f4));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_357c9f602346da68", &function_63edf1f4);
    assert(isscriptfunctionptr(&function_63edf1f4));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_357c9f602346da68", &function_63edf1f4);
    assert(isscriptfunctionptr(&function_907ba31a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7f40a2df5ff125a6", &function_907ba31a);
    assert(isscriptfunctionptr(&function_907ba31a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7f40a2df5ff125a6", &function_907ba31a);
    assert(isscriptfunctionptr(&function_37e22c7));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1a211a9a98652ef2", &function_37e22c7);
    assert(isscriptfunctionptr(&function_37e22c7));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1a211a9a98652ef2", &function_37e22c7);
    assert(isscriptfunctionptr(&shouldstartarrivalcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstartarrival", &shouldstartarrivalcondition);
    assert(isscriptfunctionptr(&shouldstartarrivalcondition));
    behaviorstatemachine::registerbsmscriptapiinternal(#"shouldstartarrival", &shouldstartarrivalcondition);
    assert(isscriptfunctionptr(&function_2f14d74f));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1e1d62204a080a4", &function_2f14d74f);
    assert(isscriptfunctionptr(&locomotionshouldtraverse));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldtraverse", &locomotionshouldtraverse);
    assert(isscriptfunctionptr(&locomotionshouldtraverse));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldtraverse", &locomotionshouldtraverse);
    assert(isscriptfunctionptr(&locomotionshouldparametrictraverse));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldparametrictraverse", &locomotionshouldparametrictraverse);
    assert(isscriptfunctionptr(&locomotionshouldparametrictraverse));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldparametrictraverse", &locomotionshouldparametrictraverse);
    assert(isscriptfunctionptr(&function_5ef5b35a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7234c48b18665dc6", &function_5ef5b35a);
    assert(isscriptfunctionptr(&function_5ef5b35a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7234c48b18665dc6", &function_5ef5b35a);
    assert(isscriptfunctionptr(&function_8a8c5d44));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4c93e133d3b1accc", &function_8a8c5d44);
    assert(isscriptfunctionptr(&function_8a8c5d44));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4c93e133d3b1accc", &function_8a8c5d44);
    assert(isscriptfunctionptr(&traverseactionstart));
    behaviorstatemachine::registerbsmscriptapiinternal(#"traverseactionstart", &traverseactionstart);
    assert(isscriptfunctionptr(&wpn_debug_bot_joinleave));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5d1b3df7dd4e60c0", &wpn_debug_bot_joinleave);
    assert(isscriptfunctionptr(&traverseactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"traverseactionstart", &traverseactionstart);
    assert(isscriptfunctionptr(&wpn_debug_bot_joinleave));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5d1b3df7dd4e60c0", &wpn_debug_bot_joinleave);
    assert(!isdefined(&traverseactionstart) || isscriptfunctionptr(&traverseactionstart));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&wpn_debug_bot_joinleave) || isscriptfunctionptr(&wpn_debug_bot_joinleave));
    behaviortreenetworkutility::registerbehaviortreeaction(#"traverseactionstart", &traverseactionstart, undefined, &wpn_debug_bot_joinleave);
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
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionisonstairs", &locomotionisonstairs);
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
    assert(isscriptfunctionptr(&function_7589776c));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_69eb39facbba57d5", &function_7589776c);
    assert(isscriptfunctionptr(&function_39c609a4));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7497a51aec712e8e", &function_39c609a4);
    assert(isscriptfunctionptr(&function_95b175c0));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4e3d1194b4da7cdd", &function_95b175c0);
    assert(isscriptfunctionptr(&function_9948d7a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3339c9781a08f98f", &function_9948d7a);
    assert(isscriptfunctionptr(&delaymovement));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"delaymovement", &delaymovement);
    assert(isscriptfunctionptr(&delaymovement));
    behaviorstatemachine::registerbsmscriptapiinternal(#"delaymovement", &delaymovement);
    /#
        function_5ac4dc99(#"hash_1d32e0542bbcf72d", 0);
        level.var_ace44d97 = getdvar(#"hash_1d32e0542bbcf72d");
        function_cd140ee9(#"hash_1d32e0542bbcf72d", &function_73bd30d3);
    #/
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xe010768b, Offset: 0x1a60
// Size: 0x166
function private locomotionisonstairs(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    if (isdefined(startnode) && behaviortreeentity shouldstarttraversal()) {
        if (isdefined(startnode.animscript) && issubstr(tolower(startnode.animscript), "stairs")) {
            /#
                if (behaviortreeentity function_3b027260()) {
                    println("<dev string:x38>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2]);
                }
            #/
            return true;
        }
    }
    /#
        if (behaviortreeentity function_3b027260()) {
            println("<dev string:x67>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2]);
        }
    #/
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xd390088e, Offset: 0x1bd0
// Size: 0x1ac
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
        /#
            if (behaviortreeentity function_3b027260()) {
                println("<dev string:x91>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2]);
            }
        #/
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x6d5438c1, Offset: 0x1d88
// Size: 0x194
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
// Params 1, eflags: 0x5 linked
// Checksum 0xfddbbc41, Offset: 0x1f28
// Size: 0x400
function private locomotionstairsstart(behaviortreeentity) {
    /#
        if (behaviortreeentity function_3b027260()) {
            println("<dev string:xb0>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2]);
        }
    #/
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
// Params 1, eflags: 0x5 linked
// Checksum 0x28e9fc3c, Offset: 0x2330
// Size: 0xb4
function private locomotionstairsend(behaviortreeentity) {
    /#
        if (behaviortreeentity function_3b027260()) {
            println("<dev string:xcd>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2]);
        }
    #/
    behaviortreeentity setblackboardattribute("_staircase_state", undefined);
    behaviortreeentity setblackboardattribute("_staircase_direction", undefined);
}

// Namespace aiutility/archetype_locomotion_utility
// Params 2, eflags: 0x5 linked
// Checksum 0x9f9a8656, Offset: 0x23f0
// Size: 0x148
function private function_f39879f2(remainingdistance, points) {
    end = self.origin;
    if (!isdefined(points)) {
        points = self function_f14f56a8(4);
    }
    if (isdefined(points) && points.size > 1) {
        startindex = 1;
        if (self getblackboardattribute("_staircase_state") === "staircase_loop") {
            startindex = 2;
        }
        for (i = startindex; i < points.size; i++) {
            var_c5699cf2 = distance2d(end, points[i]);
            if (var_c5699cf2 >= remainingdistance) {
                direction = vectornormalize(points[i] - end);
                end += direction * remainingdistance;
                return end;
            }
            end = points[i];
            remainingdistance -= var_c5699cf2;
        }
    }
    return end;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 3, eflags: 0x5 linked
// Checksum 0x90e9f454, Offset: 0x2540
// Size: 0xaa
function private function_4c6ebf22(startindex, remainingdistance, points) {
    start = points[startindex];
    nextpoint = points[startindex + 1];
    direction = vectornormalize(nextpoint - start);
    lookaheadpoint = start + direction * remainingdistance;
    var_8ff4a8a5 = ispointonstairs(lookaheadpoint);
    return var_8ff4a8a5;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x350f15d2, Offset: 0x25f8
// Size: 0x2d6
function private function_7589776c(behaviortreeentity) {
    if (isdefined(behaviortreeentity getblackboardattribute("_staircase_state"))) {
        return false;
    }
    if (!behaviortreeentity function_ab533a33()) {
        return false;
    }
    points = self function_f14f56a8(4);
    if (points.size >= 4) {
        var_926e8ff9 = function_4c6ebf22(1, 12 * 2, points);
        if (var_926e8ff9) {
            if (points[1][2] > points[2][2]) {
                var_c5699cf2 = distance2dsquared(behaviortreeentity.origin, points[1]);
                if (var_c5699cf2 <= 60) {
                    /#
                        if (behaviortreeentity function_3b027260()) {
                            record3dtext("<dev string:xe8>" + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0, 0), "<dev string:xf7>", behaviortreeentity);
                        }
                    #/
                    return true;
                } else {
                    /#
                        if (behaviortreeentity function_3b027260()) {
                            record3dtext("<dev string:x105>" + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:xf7>", behaviortreeentity);
                        }
                    #/
                }
            } else {
                var_c5699cf2 = distance2dsquared(behaviortreeentity.origin, points[1]);
                if (var_c5699cf2 <= 40) {
                    /#
                        if (behaviortreeentity function_3b027260()) {
                            record3dtext("<dev string:x11f>" + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0, 0), "<dev string:xf7>", behaviortreeentity);
                        }
                    #/
                    return true;
                } else {
                    /#
                        if (behaviortreeentity function_3b027260()) {
                            record3dtext("<dev string:x12c>" + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:xf7>", behaviortreeentity);
                        }
                    #/
                }
            }
        }
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x9330c01f, Offset: 0x28d8
// Size: 0x188
function private function_118d27ad(behaviortreeentity) {
    points = self function_f14f56a8(4);
    start = behaviortreeentity.origin;
    end = points[3];
    if (end[2] > start[2]) {
        direction = "staircase_up";
    } else {
        direction = "staircase_down";
    }
    behaviortreeentity setblackboardattribute("_staircase_state", "staircase_start");
    behaviortreeentity setblackboardattribute("_staircase_direction", direction);
    /#
        if (behaviortreeentity function_3b027260()) {
            println("<dev string:x144>", direction, "<dev string:x158>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2] + "<dev string:x160>" + end[0] + "<dev string:x61>" + end[1] + "<dev string:x61>" + end[2]);
        }
    #/
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x290fcae5, Offset: 0x2a68
// Size: 0x78
function private function_9948d7a(behaviortreeentity) {
    behaviortreeentity.var_73e3e2aa = 1;
    if (!isdefined(behaviortreeentity getblackboardattribute("_staircase_state"))) {
        self function_118d27ad(behaviortreeentity);
    }
    behaviortreeentity setblackboardattribute("_staircase_state", "staircase_loop");
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x18d574ac, Offset: 0x2ae8
// Size: 0x30a
function private function_39c609a4(behaviortreeentity) {
    dir = behaviortreeentity getblackboardattribute("_staircase_direction");
    if (dir === "staircase_up") {
        end = function_f39879f2(12 / 2);
        var_23093c4a = !ispointonstairs(end);
        if (var_23093c4a) {
            var_ad460965 = function_f39879f2(12 * 2);
            var_23093c4a = !ispointonstairs(var_ad460965);
            /#
                if (var_23093c4a && behaviortreeentity function_3b027260()) {
                    record3dtext("<dev string:x173>" + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:xf7>", behaviortreeentity);
                    println("<dev string:x17e>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2] + "<dev string:x160>" + end[0] + "<dev string:x61>" + end[1] + "<dev string:x61>" + end[2]);
                }
            #/
            return var_23093c4a;
        }
        return 0;
    }
    end = function_f39879f2(12);
    var_23093c4a = !ispointonstairs(end);
    /#
        if (var_23093c4a && behaviortreeentity function_3b027260()) {
            record3dtext("<dev string:x19a>" + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:xf7>", behaviortreeentity);
            println("<dev string:x1a7>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2] + "<dev string:x160>" + end[0] + "<dev string:x61>" + end[1] + "<dev string:x61>" + end[2]);
        }
    #/
    return var_23093c4a;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xbb8a0fba, Offset: 0x2e00
// Size: 0xe8
function private function_95b175c0(behaviortreeentity) {
    behaviortreeentity.var_73e3e2aa = undefined;
    /#
        if (behaviortreeentity function_3b027260()) {
            println("<dev string:x1c5>", behaviortreeentity getblackboardattribute("<dev string:x1e7>"), "<dev string:x158>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2]);
        }
    #/
    behaviortreeentity setblackboardattribute("_staircase_state", undefined);
    behaviortreeentity setblackboardattribute("_staircase_direction", undefined);
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x734542fa, Offset: 0x2ef0
// Size: 0x44
function private locomotionpainbehaviorcondition(entity) {
    return entity haspath() && entity hasvalidinterrupt("pain");
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xeba11036, Offset: 0x2f40
// Size: 0x24
function clearpathfromscript(behaviortreeentity) {
    behaviortreeentity clearpath();
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x80f36d82, Offset: 0x2f70
// Size: 0x5c
function private setdesiredstanceformovement(behaviortreeentity) {
    if (behaviortreeentity getblackboardattribute("_stance") != "stand") {
        behaviortreeentity setblackboardattribute("_desired_stance", "stand");
    }
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xaec16790, Offset: 0x2fd8
// Size: 0x54
function private function_2f14d74f(entity) {
    result = 0;
    if (locomotionshouldtraverse(entity) || locomotionshouldparametrictraverse(entity)) {
        result = 1;
    }
    return result;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x6a180271, Offset: 0x3038
// Size: 0xfc
function private locomotionshouldtraverse(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    if (isdefined(startnode) && isdefined(startnode.animscript) && behaviortreeentity shouldstarttraversal()) {
        behaviortreeentity setblackboardattribute("_staircase_type", startnode.animscript);
        /#
            if (behaviortreeentity function_3b027260()) {
                print("<dev string:x1ff>" + self.origin + "<dev string:x213>");
            }
            record3dtext("<dev string:x218>" + startnode.animscript, self.origin, (1, 0, 0), "<dev string:x231>");
        #/
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x99b3ae5f, Offset: 0x3140
// Size: 0xfc
function private locomotionshouldparametrictraverse(entity) {
    if (isdefined(entity.traversestartnode) || entity function_3c566724()) {
        if (entity shouldstarttraversal()) {
            traversaltype = entity getblackboardattribute("_parametric_traversal_type");
            /#
                if (entity function_3b027260()) {
                    print("<dev string:x23b>" + self.origin + "<dev string:x213>");
                }
                record3dtext("<dev string:x251>", self.origin, (1, 0, 0), "<dev string:x231>");
            #/
            return (traversaltype != "unknown_traversal");
        }
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x9a363b84, Offset: 0x3248
// Size: 0xc4
function private function_5ef5b35a(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    if (isdefined(startnode) && behaviortreeentity function_420d1e6b()) {
        /#
            if (behaviortreeentity function_3b027260()) {
                print("<dev string:x267>" + self.origin + "<dev string:x213>");
            }
            record3dtext("<dev string:x280>", self.origin, (1, 0, 0), "<dev string:x231>");
        #/
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x3dabe5b4, Offset: 0x3318
// Size: 0xfc
function private function_8a8c5d44(entity) {
    if (isdefined(entity.traversestartnode) || entity function_3c566724()) {
        if (entity function_420d1e6b()) {
            traversaltype = entity getblackboardattribute("_parametric_traversal_type");
            /#
                if (entity function_3b027260()) {
                    print("<dev string:x280>" + self.origin + "<dev string:x213>");
                }
                record3dtext("<dev string:x280>", self.origin, (1, 0, 0), "<dev string:x231>");
            #/
            return (traversaltype != "unknown_traversal");
        }
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x2de6c83f, Offset: 0x3420
// Size: 0xe8
function traversesetup(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_stance", "stand");
    /#
        if (behaviortreeentity function_3b027260()) {
            print("<dev string:x299>" + behaviortreeentity.origin + "<dev string:x213>");
        }
    #/
    if (behaviortreeentity function_3c566724()) {
        behaviortreeentity setblackboardattribute("_traversal_type", undefined);
    } else {
        behaviortreeentity setblackboardattribute("_traversal_type", behaviortreeentity.traversestartnode.animscript);
    }
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x8ec1b6c5, Offset: 0x3510
// Size: 0x240
function traverseactionstart(behaviortreeentity, asmstatename) {
    traversesetup(behaviortreeentity);
    /#
        if (behaviortreeentity function_3b027260()) {
            print("<dev string:x2ab>" + behaviortreeentity.origin + "<dev string:x213>");
        }
    #/
    if (!isdefined(asmstatename) && isdefined(self.ai.var_2b570fa6)) {
        asmstatename = self.ai.var_2b570fa6;
    }
    behaviortreeentity.var_efe0efe7 = behaviortreeentity function_b7350442();
    behaviortreeentity.var_846d7e33 = behaviortreeentity function_f650e40b();
    behaviortreeentity allowpitchangle(0);
    behaviortreeentity clearpitchorient();
    /#
        result = behaviortreeentity astsearch(asmstatename);
        if (!isdefined(result[#"animation"])) {
            record3dtext("<dev string:x2c3>", self.origin + (0, 0, 16), (1, 0, 0), "<dev string:x231>");
        } else {
            record3dtext("<dev string:x2fc>" + (ishash(result[#"animation"]) ? function_9e72a96(result[#"animation"]) : result[#"animation"]), self.origin + (0, 0, 16), (1, 0, 0), "<dev string:x231>");
        }
    #/
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x51c7e94d, Offset: 0x3758
// Size: 0xd6
function wpn_debug_bot_joinleave(behaviortreeentity, *asmstatename) {
    /#
        if (asmstatename function_3b027260()) {
            print("<dev string:x31b>" + asmstatename.origin + "<dev string:x213>");
        }
    #/
    asmstatename allowpitchangle(is_true(asmstatename.var_efe0efe7));
    if (is_true(asmstatename.var_846d7e33)) {
        asmstatename setpitchorient();
    }
    asmstatename.var_efe0efe7 = undefined;
    asmstatename.var_846d7e33 = undefined;
    return 4;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xdc477b36, Offset: 0x3838
// Size: 0x1a
function private disablerepath(entity) {
    entity.disablerepath = 1;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x76802dc5, Offset: 0x3860
// Size: 0x16
function private enablerepath(entity) {
    entity.disablerepath = 0;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xc19bcd45, Offset: 0x3880
// Size: 0x178
function shouldstartarrivalcondition(behaviortreeentity) {
    shouldstart = 0;
    if (function_c94f0d1(behaviortreeentity)) {
        shouldstart = behaviortreeentity shouldstartarrival();
        if (shouldstart) {
            results = behaviortreeentity function_a2befaeb();
            if (isdefined(results[#"desiredspeed"]) && isdefined(results[#"hash_3fc33abf1f04da29"]) && isdefined(results[#"hash_13f016dddc314e5b"])) {
                var_e82fa08f = results[#"desiredspeed"] / results[#"hash_3fc33abf1f04da29"];
                var_e82fa08f = math::clamp(var_e82fa08f, 0.8, 3);
                behaviortreeentity function_771b538d(var_e82fa08f);
                if (isdefined(behaviortreeentity getblackboardattribute("_human_current_speed_threshold"))) {
                    behaviortreeentity setblackboardattribute("_human_current_speed_threshold", results[#"hash_13f016dddc314e5b"]);
                }
            }
        }
    }
    return shouldstart;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x784f2518, Offset: 0x3a00
// Size: 0x28
function private function_907ba31a(entity) {
    keepclaimnode(entity);
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x65f91020, Offset: 0x3a30
// Size: 0x28
function private function_37e22c7(entity) {
    keepclaimnode(entity);
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xf86d0ba3, Offset: 0x3a60
// Size: 0x54
function function_c94f0d1(entity) {
    var_55a3f1d3 = entity function_144f21ef();
    if (var_55a3f1d3 < -90 || var_55a3f1d3 > 90) {
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xcada95c3, Offset: 0x3ac0
// Size: 0x58
function cleararrivalpos(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.isarrivalpending) || is_true(behaviortreeentity.isarrivalpending)) {
        self function_d4c687c9();
    }
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x651260f0, Offset: 0x3b20
// Size: 0x70
function private function_63edf1f4(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.isarrivalpending) || is_true(behaviortreeentity.isarrivalpending)) {
        self function_d4c687c9();
    }
    self clearpath();
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xd669a71f, Offset: 0x3b98
// Size: 0x58
function private function_41b88b98(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.isarrivalpending) || is_true(behaviortreeentity.isarrivalpending)) {
        self function_d4c687c9();
    }
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x9df1107, Offset: 0x3bf8
// Size: 0x48
function delaymovement(entity) {
    entity pathmode("move delayed", 0, randomfloatrange(1, 2));
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x264d7617, Offset: 0x3c48
// Size: 0x50
function private shouldadjuststanceattacticalwalk(behaviortreeentity) {
    stance = behaviortreeentity getblackboardattribute("_stance");
    if (stance != "stand") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x94dd7abc, Offset: 0x3ca0
// Size: 0x60
function private adjuststancetofaceenemyinitialize(behaviortreeentity) {
    behaviortreeentity.newenemyreaction = 0;
    behaviortreeentity setblackboardattribute("_desired_stance", "stand");
    behaviortreeentity orientmode("face enemy");
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xd91b85b1, Offset: 0x3d08
// Size: 0x34
function private adjuststancetofaceenemyterminate(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_stance", "stand");
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x684c000a, Offset: 0x3d48
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
// Params 4, eflags: 0x5 linked
// Checksum 0x3ea0a66f, Offset: 0x3df0
// Size: 0x12c
function private validjukedirection(entity, *entitynavmeshposition, forwardoffset, lateraloffset) {
    jukenavmeshthreshold = 6;
    forwardposition = entitynavmeshposition.origin + lateraloffset + forwardoffset;
    backwardposition = entitynavmeshposition.origin + lateraloffset - forwardoffset;
    forwardpositionvalid = ispointonnavmesh(forwardposition, entitynavmeshposition) && tracepassedonnavmesh(entitynavmeshposition.origin, forwardposition);
    backwardpositionvalid = ispointonnavmesh(backwardposition, entitynavmeshposition) && tracepassedonnavmesh(entitynavmeshposition.origin, backwardposition);
    if (!isdefined(entitynavmeshposition.ignorebackwardposition)) {
        return (forwardpositionvalid && backwardpositionvalid);
    } else {
        return forwardpositionvalid;
    }
    return 0;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 3, eflags: 0x1 linked
// Checksum 0x3dab4877, Offset: 0x3f28
// Size: 0x2c4
function calculatejukedirection(entity, entityradius, jukedistance) {
    jukenavmeshthreshold = 30;
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
// Params 1, eflags: 0x5 linked
// Checksum 0xa8a49c03, Offset: 0x41f8
// Size: 0x7a
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
// Params 1, eflags: 0x1 linked
// Checksum 0xb78d1d9e, Offset: 0x4280
// Size: 0xac
function canjuke(entity) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa456ad02, Offset: 0x4338
// Size: 0x4c
function choosejukedirection(entity) {
    jukedirection = calculatedefaultjukedirection(entity);
    entity setblackboardattribute("_juke_direction", jukedirection);
}

/#

    // Namespace aiutility/archetype_locomotion_utility
    // Params 0, eflags: 0x4
    // Checksum 0xaafdbc56, Offset: 0x4390
    // Size: 0x52
    function private function_3b027260() {
        return level.var_ace44d97 != 0 && (level.var_ace44d97 == 1 || level.var_ace44d97 == self getentnum());
    }

    // Namespace aiutility/archetype_locomotion_utility
    // Params 1, eflags: 0x4
    // Checksum 0xe5ab9e1c, Offset: 0x43f0
    // Size: 0x24
    function private function_73bd30d3(params) {
        level.var_ace44d97 = params.value;
    }

#/
