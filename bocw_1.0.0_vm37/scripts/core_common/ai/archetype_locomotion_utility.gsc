#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\math_shared;

#namespace aiutility;

// Namespace aiutility/archetype_locomotion_utility
// Params 0, eflags: 0x2
// Checksum 0x944eb298, Offset: 0x310
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
// Params 1, eflags: 0x4
// Checksum 0x29cfd116, Offset: 0x1a38
// Size: 0x186
function private locomotionisonstairs(behaviortreeentity) {
    if (is_true(behaviortreeentity.var_73e3e2aa)) {
        return false;
    }
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
// Params 1, eflags: 0x4
// Checksum 0x25b09759, Offset: 0x1bc8
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
// Params 1, eflags: 0x4
// Checksum 0x30cf3163, Offset: 0x1d80
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
// Params 1, eflags: 0x4
// Checksum 0x22a2e85b, Offset: 0x1f20
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
// Params 1, eflags: 0x4
// Checksum 0x91bcb39e, Offset: 0x2328
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
// Params 0, eflags: 0x4
// Checksum 0x80b46e8, Offset: 0x23e8
// Size: 0x342
function private function_bb046570() {
    if (!isdefined(self.ai.var_4183a6fc)) {
        self.ai.var_4183a6fc = spawnstruct();
    }
    self.ai.var_4183a6fc.goalpos = self.pathgoalpos;
    points = self function_f14f56a8();
    for (i = 1; i < points.size - 1; i++) {
        direction = vectornormalize(points[i + 1] - points[i]);
        checkpoint = points[i] + direction;
        if (ispointonstairs(checkpoint)) {
            startpoint = points[i];
            endpoint = self.pathgoalpos;
            for (j = i + 1; j < points.size; j++) {
                direction = vectornormalize(points[j] - points[j - 1]);
                if (!ispointonstairs(points[j] + direction)) {
                    endpoint = points[j];
                    break;
                }
            }
            var_ef0e5eed = distance2dsquared(startpoint, endpoint);
            if (var_ef0e5eed >= sqr(36)) {
                self.ai.var_4183a6fc.var_60198839 = 1;
                self.ai.var_4183a6fc.startpos = startpoint;
                self.ai.var_4183a6fc.endpos = endpoint;
                self.ai.var_4183a6fc.var_ef0e5eed = var_ef0e5eed;
                if (startpoint[2] < endpoint[2]) {
                    self.ai.var_4183a6fc.direction = "staircase_up";
                    return;
                }
                self.ai.var_4183a6fc.direction = "staircase_down";
                return;
            }
        }
    }
    self.ai.var_4183a6fc.var_60198839 = 0;
    self.ai.var_4183a6fc.startpos = undefined;
    self.ai.var_4183a6fc.endpos = undefined;
    self.ai.var_4183a6fc.direction = undefined;
    self.ai.var_4183a6fc.var_ba319abd = undefined;
    self.ai.var_4183a6fc.var_4a6a42e4 = undefined;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 0, eflags: 0x4
// Checksum 0xd684bdb9, Offset: 0x2738
// Size: 0x4a2
function private function_37ae0b11() {
    var_25f63bae = self.ai.var_4183a6fc.endpos - self.ai.var_4183a6fc.startpos;
    var_25f63bae = (var_25f63bae[0], var_25f63bae[1], 0);
    var_25f63bae = vectornormalize(var_25f63bae);
    startorigin = self.origin;
    var_c0292a97 = 0;
    if (distance2dsquared(self.origin, self.var_14b548c5) < distance2dsquared(self.origin, self.ai.var_4183a6fc.startpos)) {
        startorigin = self.var_14b548c5;
        var_c0292a97 = 1;
    }
    dirtogoal = self.ai.var_4183a6fc.endpos - startorigin;
    var_a0bb1f9c = self.ai.var_4183a6fc.startpos - startorigin;
    var_95c1be9 = (var_25f63bae[1], var_25f63bae[0] * -1, 0);
    dirtoorigin = startorigin - self.ai.var_4183a6fc.startpos;
    dot = vectordot(dirtoorigin, var_95c1be9);
    if (var_c0292a97) {
        if (dot > 12) {
            dot = 12;
        }
    }
    var_ba319abd = self.ai.var_4183a6fc.startpos + var_95c1be9 * dot;
    var_92cbdd4c = distance2dsquared(self.var_14b548c5, var_ba319abd);
    var_afc4c793 = distance2dsquared(self.var_14b548c5, self.ai.var_4183a6fc.endpos);
    var_93cae7cc = distance2dsquared(var_ba319abd, self.ai.var_4183a6fc.endpos);
    if (var_92cbdd4c < var_afc4c793 && var_afc4c793 < var_93cae7cc) {
        if (vectordot(var_25f63bae, vectornormalize(dirtogoal)) > 0.7) {
            self.ai.var_4183a6fc.var_ba319abd = (self.var_14b548c5[0], self.var_14b548c5[1], self.ai.var_4183a6fc.startpos[2]);
            self.ai.var_4183a6fc.var_4a6a42e4 = 1;
        } else {
            self.ai.var_4183a6fc.var_ba319abd = var_ba319abd;
            self.ai.var_4183a6fc.var_4a6a42e4 = 0;
        }
    } else if (!is_true(self.ai.var_4183a6fc.var_4a6a42e4)) {
        self.ai.var_4183a6fc.var_ba319abd = var_ba319abd;
    }
    if (isdefined(self.ai.var_4183a6fc.var_ba319abd)) {
        var_48a0209 = distance2dsquared(self.ai.var_4183a6fc.var_ba319abd, self.origin);
        var_b0a0a668 = distance2dsquared(self.origin, self.ai.var_4183a6fc.startpos);
        return min(var_48a0209, var_b0a0a668);
    }
    self.ai.var_4183a6fc.var_ba319abd = undefined;
    return length2dsquared(var_a0bb1f9c);
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x985f6aeb, Offset: 0x2be8
// Size: 0x61e
function private function_7589776c(behaviortreeentity) {
    if (!behaviortreeentity function_ab533a33()) {
        return false;
    }
    if (is_true(behaviortreeentity.var_73e3e2aa)) {
        return false;
    }
    if (!isdefined(self.ai.var_4183a6fc) || distancesquared(self.ai.var_4183a6fc.goalpos, self.pathgoalpos) > 1) {
        self function_bb046570();
    }
    if (isdefined(self.ai.var_4183a6fc) && is_true(self.ai.var_4183a6fc.var_60198839)) {
        var_4226005f = self function_37ae0b11();
        /#
            if (behaviortreeentity function_3b027260()) {
                recordcircle(self.origin, 2, (0, 1, 1), "<dev string:xe8>", self);
                recordcircle(self.ai.var_4183a6fc.startpos, 2, (0, 1, 0), "<dev string:xe8>", self);
                recordcircle(self.ai.var_4183a6fc.endpos, 2, (1, 0, 0), "<dev string:xe8>", self);
                if (isdefined(self.ai.var_4183a6fc.var_ba319abd)) {
                    recordcircle(self.ai.var_4183a6fc.var_ba319abd, 2, (1, 0.5, 0), "<dev string:xe8>", self);
                }
                recordcircle(self.var_14b548c5, 3, (0, 0, 1), "<dev string:xe8>", self);
            }
        #/
        if (self.ai.var_4183a6fc.direction == "staircase_down") {
            if (var_4226005f <= max(60, length2dsquared(self getvelocity() * float(function_60d95f53()) / 1000 * 2))) {
                behaviortreeentity setblackboardattribute("_staircase_direction", self.ai.var_4183a6fc.direction);
                /#
                    if (behaviortreeentity function_3b027260()) {
                        record3dtext("<dev string:xf2>" + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0, 0), "<dev string:x101>", behaviortreeentity);
                    }
                #/
                return true;
            } else {
                /#
                    if (behaviortreeentity function_3b027260()) {
                        record3dtext("<dev string:x10f>" + var_4226005f + "<dev string:x129>" + length2dsquared(self getvelocity() * float(function_60d95f53()) / 1000 * 2) + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x101>", behaviortreeentity);
                    }
                #/
            }
        } else if (var_4226005f <= max(40, length2dsquared(self getvelocity() * float(function_60d95f53()) / 1000 * 2))) {
            behaviortreeentity setblackboardattribute("_staircase_direction", self.ai.var_4183a6fc.direction);
            /#
                if (behaviortreeentity function_3b027260()) {
                    record3dtext("<dev string:x130>" + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0, 0), "<dev string:x101>", behaviortreeentity);
                }
            #/
            return true;
        } else {
            /#
                if (behaviortreeentity function_3b027260()) {
                    record3dtext("<dev string:x13d>" + var_4226005f + "<dev string:x129>" + length2dsquared(self getvelocity() * float(function_60d95f53()) / 1000 * 2) + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x101>", behaviortreeentity);
                }
            #/
        }
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x10c3766c, Offset: 0x3210
// Size: 0xf0
function private function_118d27ad(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_staircase_state", "staircase_start");
    behaviortreeentity.ai.var_4183a6fc.var_2b01e722 = behaviortreeentity.enableterrainik;
    behaviortreeentity.enableterrainik = 1;
    /#
        if (behaviortreeentity function_3b027260()) {
            println("<dev string:x155>", self.ai.var_4183a6fc.direction, "<dev string:x169>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2]);
        }
    #/
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x13279db3, Offset: 0x3308
// Size: 0xbe
function private function_9948d7a(behaviortreeentity) {
    behaviortreeentity.var_73e3e2aa = 1;
    if (!isdefined(behaviortreeentity getblackboardattribute("_staircase_state"))) {
        self function_118d27ad(behaviortreeentity);
    }
    behaviortreeentity setblackboardattribute("_staircase_state", "staircase_loop");
    behaviortreeentity.ai.var_4183a6fc.var_ef0e5eed = distance2dsquared(behaviortreeentity.origin, behaviortreeentity.ai.var_4183a6fc.endpos);
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xe4ee7393, Offset: 0x33d0
// Size: 0x310
function private function_39c609a4(behaviortreeentity) {
    var_ef0e5eed = distance2dsquared(behaviortreeentity.origin, behaviortreeentity.ai.var_4183a6fc.endpos);
    if (behaviortreeentity.ai.var_4183a6fc.direction === "staircase_up") {
        if (var_ef0e5eed <= 60 || var_ef0e5eed > behaviortreeentity.ai.var_4183a6fc.var_ef0e5eed) {
            /#
                if (behaviortreeentity function_3b027260()) {
                    record3dtext("<dev string:x171>" + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x101>", behaviortreeentity);
                    end = behaviortreeentity.ai.var_4183a6fc.endpos;
                    println("<dev string:x17c>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2] + "<dev string:x198>" + end[0] + "<dev string:x61>" + end[1] + "<dev string:x61>" + end[2]);
                }
            #/
            return true;
        }
    } else if (var_ef0e5eed <= 30 || var_ef0e5eed > behaviortreeentity.ai.var_4183a6fc.var_ef0e5eed) {
        /#
            if (behaviortreeentity function_3b027260()) {
                record3dtext("<dev string:x1ab>" + behaviortreeentity.origin, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x101>", behaviortreeentity);
                end = behaviortreeentity.ai.var_4183a6fc.endpos;
                println("<dev string:x1b8>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2] + "<dev string:x198>" + end[0] + "<dev string:x61>" + end[1] + "<dev string:x61>" + end[2]);
            }
        #/
        return true;
    }
    behaviortreeentity.ai.var_4183a6fc.var_ef0e5eed = var_ef0e5eed;
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x39082bdd, Offset: 0x36e8
// Size: 0x148
function private function_95b175c0(behaviortreeentity) {
    behaviortreeentity.enableterrainik = isdefined(behaviortreeentity.ai.var_4183a6fc.var_2b01e722) ? behaviortreeentity.ai.var_4183a6fc.var_2b01e722 : 0;
    behaviortreeentity.ai.var_4183a6fc = undefined;
    behaviortreeentity.var_73e3e2aa = undefined;
    /#
        if (behaviortreeentity function_3b027260()) {
            println("<dev string:x1d6>", behaviortreeentity getblackboardattribute("<dev string:x1f8>"), "<dev string:x169>", behaviortreeentity.origin[0], "<dev string:x61>", behaviortreeentity.origin[1], "<dev string:x61>", behaviortreeentity.origin[2]);
        }
    #/
    behaviortreeentity setblackboardattribute("_staircase_state", undefined);
    behaviortreeentity setblackboardattribute("_staircase_direction", undefined);
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xbdec6ea, Offset: 0x3838
// Size: 0x44
function private locomotionpainbehaviorcondition(entity) {
    return entity haspath() && entity hasvalidinterrupt("pain");
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0x8fb0991a, Offset: 0x3888
// Size: 0x24
function clearpathfromscript(behaviortreeentity) {
    behaviortreeentity clearpath();
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x78cea7f8, Offset: 0x38b8
// Size: 0x5c
function private setdesiredstanceformovement(behaviortreeentity) {
    if (behaviortreeentity getblackboardattribute("_stance") != "stand") {
        behaviortreeentity setblackboardattribute("_desired_stance", "stand");
    }
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x7dbb32f6, Offset: 0x3920
// Size: 0x54
function private function_2f14d74f(entity) {
    result = 0;
    if (locomotionshouldtraverse(entity) || locomotionshouldparametrictraverse(entity)) {
        result = 1;
    }
    return result;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xb64632b8, Offset: 0x3980
// Size: 0xfc
function private locomotionshouldtraverse(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    if (isdefined(startnode) && isdefined(startnode.animscript) && behaviortreeentity shouldstarttraversal()) {
        behaviortreeentity setblackboardattribute("_staircase_type", startnode.animscript);
        /#
            if (behaviortreeentity function_3b027260()) {
                print("<dev string:x210>" + self.origin + "<dev string:x224>");
            }
            record3dtext("<dev string:x229>" + startnode.animscript, self.origin, (1, 0, 0), "<dev string:x242>");
        #/
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x52c28aab, Offset: 0x3a88
// Size: 0xfc
function private locomotionshouldparametrictraverse(entity) {
    if (isdefined(entity.traversestartnode) || entity function_3c566724()) {
        if (entity shouldstarttraversal()) {
            traversaltype = entity getblackboardattribute("_parametric_traversal_type");
            /#
                if (entity function_3b027260()) {
                    print("<dev string:x24c>" + self.origin + "<dev string:x224>");
                }
                record3dtext("<dev string:x262>", self.origin, (1, 0, 0), "<dev string:x242>");
            #/
            return (traversaltype != "unknown_traversal");
        }
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x93faa2ba, Offset: 0x3b90
// Size: 0xc4
function private function_5ef5b35a(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    if (isdefined(startnode) && behaviortreeentity function_420d1e6b()) {
        /#
            if (behaviortreeentity function_3b027260()) {
                print("<dev string:x278>" + self.origin + "<dev string:x224>");
            }
            record3dtext("<dev string:x291>", self.origin, (1, 0, 0), "<dev string:x242>");
        #/
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x3d43b63e, Offset: 0x3c60
// Size: 0xfc
function private function_8a8c5d44(entity) {
    if (isdefined(entity.traversestartnode) || entity function_3c566724()) {
        if (entity function_420d1e6b()) {
            traversaltype = entity getblackboardattribute("_parametric_traversal_type");
            /#
                if (entity function_3b027260()) {
                    print("<dev string:x291>" + self.origin + "<dev string:x224>");
                }
                record3dtext("<dev string:x291>", self.origin, (1, 0, 0), "<dev string:x242>");
            #/
            return (traversaltype != "unknown_traversal");
        }
    }
    return false;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0x871a45d9, Offset: 0x3d68
// Size: 0xe8
function traversesetup(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_stance", "stand");
    /#
        if (behaviortreeentity function_3b027260()) {
            print("<dev string:x2aa>" + behaviortreeentity.origin + "<dev string:x224>");
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
// Params 2, eflags: 0x0
// Checksum 0x79f70023, Offset: 0x3e58
// Size: 0x240
function traverseactionstart(behaviortreeentity, asmstatename) {
    traversesetup(behaviortreeentity);
    /#
        if (behaviortreeentity function_3b027260()) {
            print("<dev string:x2bc>" + behaviortreeentity.origin + "<dev string:x224>");
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
            record3dtext("<dev string:x2d4>", self.origin + (0, 0, 16), (1, 0, 0), "<dev string:x242>");
        } else {
            record3dtext("<dev string:x30d>" + (ishash(result[#"animation"]) ? function_9e72a96(result[#"animation"]) : result[#"animation"]), self.origin + (0, 0, 16), (1, 0, 0), "<dev string:x242>");
        }
    #/
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 2, eflags: 0x0
// Checksum 0x51be3218, Offset: 0x40a0
// Size: 0xd6
function wpn_debug_bot_joinleave(behaviortreeentity, *asmstatename) {
    /#
        if (asmstatename function_3b027260()) {
            print("<dev string:x32c>" + asmstatename.origin + "<dev string:x224>");
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
// Params 1, eflags: 0x4
// Checksum 0x2fc03617, Offset: 0x4180
// Size: 0x1a
function private disablerepath(entity) {
    entity.disablerepath = 1;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xc39d3e4c, Offset: 0x41a8
// Size: 0x16
function private enablerepath(entity) {
    entity.disablerepath = 0;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0x7d17237, Offset: 0x41c8
// Size: 0xb8
function shouldstartarrivalcondition(behaviortreeentity) {
    shouldstart = 0;
    if (function_c94f0d1(behaviortreeentity)) {
        shouldstart = behaviortreeentity shouldstartarrival();
        /#
            if (shouldstart && getdvarint(#"ai_debugarrivals", 0)) {
                record3dtext("<dev string:x348>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x101>", behaviortreeentity);
            }
        #/
    }
    return shouldstart;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xa1b5614b, Offset: 0x4288
// Size: 0x28
function private function_907ba31a(entity) {
    keepclaimnode(entity);
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x7c9fa93e, Offset: 0x42b8
// Size: 0x28
function private function_37e22c7(entity) {
    keepclaimnode(entity);
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0x19d94887, Offset: 0x42e8
// Size: 0x54
function function_c94f0d1(entity) {
    var_55a3f1d3 = entity function_144f21ef();
    if (var_55a3f1d3 < -60 || var_55a3f1d3 > 60) {
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0x78d80678, Offset: 0x4348
// Size: 0x58
function cleararrivalpos(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.isarrivalpending) || is_true(behaviortreeentity.isarrivalpending)) {
        self function_d4c687c9();
    }
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xc6b11d29, Offset: 0x43a8
// Size: 0x70
function private function_63edf1f4(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.isarrivalpending) || is_true(behaviortreeentity.isarrivalpending)) {
        self function_d4c687c9();
    }
    self clearpath();
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x89392048, Offset: 0x4420
// Size: 0x58
function private function_41b88b98(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.isarrivalpending) || is_true(behaviortreeentity.isarrivalpending)) {
        self function_d4c687c9();
    }
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x0
// Checksum 0x7db98c68, Offset: 0x4480
// Size: 0x48
function delaymovement(entity) {
    entity pathmode("move delayed", 0, randomfloatrange(1, 2));
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0xc80e80cd, Offset: 0x44d0
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
// Checksum 0xff13d23, Offset: 0x4528
// Size: 0x60
function private adjuststancetofaceenemyinitialize(behaviortreeentity) {
    behaviortreeentity.newenemyreaction = 0;
    behaviortreeentity setblackboardattribute("_desired_stance", "stand");
    behaviortreeentity orientmode("face enemy");
    return true;
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x7c77a1a0, Offset: 0x4590
// Size: 0x34
function private adjuststancetofaceenemyterminate(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_stance", "stand");
}

// Namespace aiutility/archetype_locomotion_utility
// Params 1, eflags: 0x4
// Checksum 0x86a93627, Offset: 0x45d0
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
// Checksum 0x5ea0b329, Offset: 0x4678
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
// Params 3, eflags: 0x0
// Checksum 0x1b4a100, Offset: 0x47b0
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
// Params 1, eflags: 0x4
// Checksum 0x2415fb0d, Offset: 0x4a80
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
// Params 1, eflags: 0x0
// Checksum 0x7f0125cd, Offset: 0x4b08
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
// Params 1, eflags: 0x0
// Checksum 0x5eee4f47, Offset: 0x4bc0
// Size: 0x4c
function choosejukedirection(entity) {
    jukedirection = calculatedefaultjukedirection(entity);
    entity setblackboardattribute("_juke_direction", jukedirection);
}

/#

    // Namespace aiutility/archetype_locomotion_utility
    // Params 0, eflags: 0x4
    // Checksum 0x911472ad, Offset: 0x4c18
    // Size: 0x52
    function private function_3b027260() {
        return level.var_ace44d97 != 0 && (level.var_ace44d97 == 1 || level.var_ace44d97 == self getentnum());
    }

    // Namespace aiutility/archetype_locomotion_utility
    // Params 1, eflags: 0x4
    // Checksum 0xbf60d858, Offset: 0x4c78
    // Size: 0x24
    function private function_73bd30d3(params) {
        level.var_ace44d97 = params.value;
    }

#/
