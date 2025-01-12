#using scripts\core_common\ai\archetype_aivsaimelee;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;

#namespace aiutility;

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x2
// Checksum 0x44598614, Offset: 0x6a0
// Size: 0x21f4
function autoexec registerbehaviorscriptfunctions() {
    assert(iscodefunctionptr(&btapi_forceragdoll));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_forceragdoll", &btapi_forceragdoll);
    assert(iscodefunctionptr(&btapi_hasammo));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_hasammo", &btapi_hasammo);
    assert(iscodefunctionptr(&btapi_haslowammo));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_haslowammo", &btapi_haslowammo);
    assert(iscodefunctionptr(&btapi_hasenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_hasenemy", &btapi_hasenemy);
    assert(iscodefunctionptr(&btapi_issafefromgrenades));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_issafefromgrenades", &btapi_issafefromgrenades);
    assert(isscriptfunctionptr(&issafefromgrenades));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"issafefromgrenades", &issafefromgrenades);
    assert(isscriptfunctionptr(&ingrenadeblastradius));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"ingrenadeblastradius", &ingrenadeblastradius);
    assert(isscriptfunctionptr(&recentlysawenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"recentlysawenemy", &recentlysawenemy);
    assert(isscriptfunctionptr(&shouldbeaggressive));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldbeaggressive", &shouldbeaggressive);
    assert(isscriptfunctionptr(&shouldonlyfireaccurately));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldonlyfireaccurately", &shouldonlyfireaccurately);
    assert(isscriptfunctionptr(&shouldreacttonewenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldreacttonewenemy", &shouldreacttonewenemy);
    assert(isscriptfunctionptr(&shouldreacttonewenemy));
    behaviorstatemachine::registerbsmscriptapiinternal(#"shouldreacttonewenemy", &shouldreacttonewenemy);
    assert(isscriptfunctionptr(&hasweaponmalfunctioned));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hasweaponmalfunctioned", &hasweaponmalfunctioned);
    assert(isscriptfunctionptr(&shouldstopmoving));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstopmoving", &shouldstopmoving);
    assert(isscriptfunctionptr(&shouldstopmoving));
    behaviorstatemachine::registerbsmscriptapiinternal(#"shouldstopmoving", &shouldstopmoving);
    assert(isscriptfunctionptr(&choosebestcovernodeasap));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"choosebestcovernodeasap", &choosebestcovernodeasap);
    assert(isscriptfunctionptr(&choosebettercoverservicecodeversion));
    behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBetterCoverService", &choosebettercoverservicecodeversion, 1);
    assert(iscodefunctionptr(&btapi_trackcoverparamsservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_trackcoverparamsservice", &btapi_trackcoverparamsservice);
    assert(isscriptfunctionptr(&trackcoverparamsservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"trackcoverparamsservice", &trackcoverparamsservice);
    assert(iscodefunctionptr(&btapi_refillammoifneededservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_refillammoifneededservice", &btapi_refillammoifneededservice);
    assert(isscriptfunctionptr(&refillammo));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"refillammoifneededservice", &refillammo);
    assert(isscriptfunctionptr(&trystoppingservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"trystoppingservice", &trystoppingservice);
    assert(isscriptfunctionptr(&isfrustrated));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isfrustrated", &isfrustrated);
    assert(iscodefunctionptr(&btapi_updatefrustrationlevel));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_updatefrustrationlevel", &btapi_updatefrustrationlevel);
    assert(isscriptfunctionptr(&updatefrustrationlevel));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"updatefrustrationlevel", &updatefrustrationlevel);
    assert(isscriptfunctionptr(&islastknownenemypositionapproachable));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"islastknownenemypositionapproachable", &islastknownenemypositionapproachable);
    assert(isscriptfunctionptr(&tryadvancingonlastknownpositionbehavior));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"tryadvancingonlastknownpositionbehavior", &tryadvancingonlastknownpositionbehavior);
    assert(isscriptfunctionptr(&trygoingtoclosestnodetoenemybehavior));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"trygoingtoclosestnodetoenemybehavior", &trygoingtoclosestnodetoenemybehavior);
    assert(isscriptfunctionptr(&tryrunningdirectlytoenemybehavior));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"tryrunningdirectlytoenemybehavior", &tryrunningdirectlytoenemybehavior);
    assert(isscriptfunctionptr(&flagenemyunattackableservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"flagenemyunattackableservice", &flagenemyunattackableservice);
    assert(isscriptfunctionptr(&keepclaimnode));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"keepclaimnode", &keepclaimnode);
    assert(isscriptfunctionptr(&keepclaimnode));
    behaviorstatemachine::registerbsmscriptapiinternal(#"keepclaimnode", &keepclaimnode);
    assert(isscriptfunctionptr(&releaseclaimnode));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"releaseclaimnode", &releaseclaimnode);
    assert(isscriptfunctionptr(&releaseclaimnode));
    behaviorstatemachine::registerbsmscriptapiinternal(#"releaseclaimnode", &releaseclaimnode);
    assert(isscriptfunctionptr(&scriptstartragdoll));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"startragdoll", &scriptstartragdoll);
    assert(isscriptfunctionptr(&notstandingcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"notstandingcondition", &notstandingcondition);
    assert(isscriptfunctionptr(&notcrouchingcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"notcrouchingcondition", &notcrouchingcondition);
    assert(isscriptfunctionptr(&meleeacquiremutex));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"meleeacquiremutex", &meleeacquiremutex);
    assert(isscriptfunctionptr(&meleereleasemutex));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"meleereleasemutex", &meleereleasemutex);
    assert(isscriptfunctionptr(&prepareforexposedmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"prepareforexposedmelee", &prepareforexposedmelee);
    assert(isscriptfunctionptr(&cleanupmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupmelee", &cleanupmelee);
    assert(iscodefunctionptr(&btapi_shouldnormalmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldnormalmelee", &btapi_shouldnormalmelee);
    assert(iscodefunctionptr(&btapi_shouldnormalmelee));
    behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldnormalmelee", &btapi_shouldnormalmelee);
    assert(isscriptfunctionptr(&shouldnormalmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldnormalmelee", &shouldnormalmelee);
    assert(iscodefunctionptr(&btapi_shouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldmelee", &btapi_shouldmelee);
    assert(iscodefunctionptr(&btapi_shouldmelee));
    behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldmelee", &btapi_shouldmelee);
    assert(isscriptfunctionptr(&shouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldmelee", &shouldmelee);
    assert(isscriptfunctionptr(&shouldmelee));
    behaviorstatemachine::registerbsmscriptapiinternal(#"shouldmelee", &shouldmelee);
    assert(isscriptfunctionptr(&hascloseenemytomelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hascloseenemymelee", &hascloseenemytomelee);
    assert(isscriptfunctionptr(&isbalconydeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isbalconydeath", &isbalconydeath);
    assert(isscriptfunctionptr(&balconydeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"balconydeath", &balconydeath);
    assert(isscriptfunctionptr(&usecurrentposition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"usecurrentposition", &usecurrentposition);
    assert(isscriptfunctionptr(&isunarmed));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isunarmed", &isunarmed);
    assert(iscodefunctionptr(&btapi_shouldchargemelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldchargemelee", &btapi_shouldchargemelee);
    assert(isscriptfunctionptr(&shouldchargemelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchargemelee", &shouldchargemelee);
    assert(iscodefunctionptr(&btapi_shouldchargemelee));
    behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldchargemelee", &btapi_shouldchargemelee);
    assert(isscriptfunctionptr(&shouldattackinchargemelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldattackinchargemelee", &shouldattackinchargemelee);
    assert(isscriptfunctionptr(&cleanupchargemelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchargemelee", &cleanupchargemelee);
    assert(isscriptfunctionptr(&cleanupchargemeleeattack));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchargemeleeattack", &cleanupchargemeleeattack);
    assert(isscriptfunctionptr(&setupchargemeleeattack));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"setupchargemeleeattack", &setupchargemeleeattack);
    assert(isscriptfunctionptr(&shouldchoosespecialpain));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpain", &shouldchoosespecialpain);
    assert(isscriptfunctionptr(&function_54565247));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_50fc16dcf1175197", &function_54565247);
    assert(isscriptfunctionptr(&shouldchoosespecialpronepain));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpronepain", &shouldchoosespecialpronepain);
    assert(isscriptfunctionptr(&function_1209ee0e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_78675d76c0c51e10", &function_1209ee0e);
    assert(isscriptfunctionptr(&shouldchoosespecialdeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialdeath", &shouldchoosespecialdeath);
    assert(isscriptfunctionptr(&shouldchoosespecialpronedeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpronedeath", &shouldchoosespecialpronedeath);
    assert(isscriptfunctionptr(&setupexplosionanimscale));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"setupexplosionanimscale", &setupexplosionanimscale);
    assert(isscriptfunctionptr(&shouldstealth));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstealth", &shouldstealth);
    assert(isscriptfunctionptr(&stealthreactcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactcondition", &stealthreactcondition);
    assert(isscriptfunctionptr(&locomotionshouldstealth));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldstealth", &locomotionshouldstealth);
    assert(isscriptfunctionptr(&shouldstealthresume));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstealthresume", &shouldstealthresume);
    assert(isscriptfunctionptr(&locomotionshouldstealth));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldstealth", &locomotionshouldstealth);
    assert(isscriptfunctionptr(&stealthreactcondition));
    behaviorstatemachine::registerbsmscriptapiinternal(#"stealthreactcondition", &stealthreactcondition);
    assert(isscriptfunctionptr(&stealthreactstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactstart", &stealthreactstart);
    assert(isscriptfunctionptr(&stealthreactterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactterminate", &stealthreactterminate);
    assert(isscriptfunctionptr(&stealthidleterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthidleterminate", &stealthidleterminate);
    assert(iscodefunctionptr(&btapi_isinphalanx));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_isinphalanx", &btapi_isinphalanx);
    assert(isscriptfunctionptr(&isinphalanx));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinphalanx", &isinphalanx);
    assert(isscriptfunctionptr(&isinphalanxstance));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinphalanxstance", &isinphalanxstance);
    assert(isscriptfunctionptr(&togglephalanxstance));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"togglephalanxstance", &togglephalanxstance);
    assert(isscriptfunctionptr(&isatattackobject));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatattackobject", &isatattackobject);
    assert(isscriptfunctionptr(&shouldattackobject));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldattackobject", &shouldattackobject);
    assert(isscriptfunctionptr(&generictryreacquireservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"generictryreacquireservice", &generictryreacquireservice);
    behaviortreenetworkutility::registerbehaviortreeaction(#"defaultaction", undefined, undefined, undefined);
    archetype_aivsaimelee::registeraivsaimeleebehaviorfunctions();
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x4
// Checksum 0xa24ba961, Offset: 0x28a0
// Size: 0x162
function private bb_getstairsnumskipsteps() {
    assert(isdefined(self._stairsstartnode) && isdefined(self._stairsendnode));
    numtotalsteps = self getblackboardattribute("_staircase_num_total_steps");
    stepssofar = self getblackboardattribute("_staircase_num_steps");
    direction = self getblackboardattribute("_staircase_direction");
    numoutsteps = 2;
    totalstepswithoutout = numtotalsteps - numoutsteps;
    assert(stepssofar < totalstepswithoutout);
    remainingsteps = totalstepswithoutout - stepssofar;
    if (remainingsteps >= 8) {
        return "staircase_skip_8";
    } else if (remainingsteps >= 6) {
        return "staircase_skip_6";
    }
    assert(remainingsteps >= 3);
    return "staircase_skip_3";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x4
// Checksum 0xc607d6e5, Offset: 0x2a10
// Size: 0x1cc
function private bb_gettraversalheight() {
    entity = self;
    startposition = entity.traversalstartpos;
    endposition = entity.traversalendpos;
    if (isdefined(entity.traveseheightoverride)) {
        return entity.traveseheightoverride;
    }
    if (isdefined(entity.traversemantlenode)) {
        pivotorigin = archetype_mocomps_utility::calculatepivotoriginfromedge(entity, entity.traversemantlenode, entity.origin);
        traversalheight = pivotorigin[2] - entity.origin[2];
        /#
            record3dtext("<dev string:x30>" + traversalheight, self.origin + (0, 0, 32), (1, 0, 0), "<dev string:x42>");
        #/
        return traversalheight;
    } else if (isdefined(startposition) && isdefined(endposition)) {
        traversalheight = endposition[2] - startposition[2];
        if (bb_getparametrictraversaltype() == "jump_across_traversal") {
            traversalheight = abs(traversalheight);
        }
        /#
            record3dtext("<dev string:x30>" + traversalheight, self.origin + (0, 0, 32), (1, 0, 0), "<dev string:x42>");
        #/
        return traversalheight;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x4
// Checksum 0x5ce4b5fe, Offset: 0x2be8
// Size: 0x134
function private bb_gettraversalwidth() {
    entity = self;
    startposition = entity.traversalstartpos;
    endposition = entity.traversalendpos;
    if (isdefined(entity.travesewidthoverride)) {
        /#
            record3dtext("<dev string:x49>" + entity.travesewidthoverride, self.origin + (0, 0, 48), (1, 0, 0), "<dev string:x42>");
        #/
        return entity.travesewidthoverride;
    }
    if (isdefined(startposition) && isdefined(endposition)) {
        var_84ecc745 = distance2d(startposition, endposition);
        /#
            record3dtext("<dev string:x49>" + var_84ecc745, self.origin + (0, 0, 48), (1, 0, 0), "<dev string:x42>");
        #/
        return var_84ecc745;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x3d428df9, Offset: 0x2d28
// Size: 0x2a6
function bb_getparametrictraversaltype() {
    entity = self;
    startposition = entity.traversalstartpos;
    endposition = entity.traversalendpos;
    if (isdefined(entity.travesetypeoverride)) {
        return entity.travesetypeoverride;
    }
    if (!isdefined(entity.traversestartnode) || entity.traversestartnode.type != "Volume" || !isdefined(entity.traverseendnode) || entity.traverseendnode.type != "Volume") {
        return "unknown_traversal";
    }
    if (isdefined(entity.traversestartnode) && isdefined(entity.traversemantlenode)) {
        if (isdefined(entity.traversemantlenode.uneven_mantle_traversal) && entity.traversemantlenode.uneven_mantle_traversal && isdefined(entity.var_817e15c1) && entity.var_817e15c1) {
            isendpointaboveorsamelevel = startposition[2] < endposition[2];
            if (isendpointaboveorsamelevel) {
                return "jump_up_mantle_traversal";
            } else {
                return "jump_down_mantle_traversal";
            }
        }
        return "mantle_traversal";
    }
    if (isdefined(startposition) && isdefined(endposition)) {
        traversaldistance = distance2d(startposition, endposition);
        isendpointaboveorsamelevel = startposition[2] <= endposition[2];
        if (traversaldistance >= 108 && abs(endposition[2] - startposition[2]) <= 100) {
            return "jump_across_traversal";
        }
        if (isendpointaboveorsamelevel) {
            if (isdefined(entity.traverseendnode.hanging_traversal) && entity.traverseendnode.hanging_traversal && isdefined(entity.var_cd095456) && entity.var_cd095456) {
                return "jump_up_hanging_traversal";
            } else {
                return "jump_up_traversal";
            }
        }
        return "jump_down_traversal";
    }
    return "unknown_traversal";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x52f6a304, Offset: 0x2fd8
// Size: 0xa
function bb_getawareness() {
    return self.awarenesslevelcurrent;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x1e3f7a09, Offset: 0x2ff0
// Size: 0xa
function bb_getawarenessprevious() {
    return self.awarenesslevelprevious;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x5951c1f6, Offset: 0x3008
// Size: 0x92
function function_d0d49a4e() {
    if (isdefined(self.zombie_move_speed)) {
        if (self.zombie_move_speed == "walk") {
            return "locomotion_speed_walk";
        } else if (self.zombie_move_speed == "run") {
            return "locomotion_speed_run";
        } else if (self.zombie_move_speed == "sprint") {
            return "locomotion_speed_sprint";
        } else if (self.zombie_move_speed == "super_sprint") {
            return "locomotion_speed_super_sprint";
        }
    }
    return "locomotion_speed_walk";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x4
// Checksum 0x4a691fce, Offset: 0x30a8
// Size: 0xa6
function private bb_getgibbedlimbs() {
    entity = self;
    rightarmgibbed = gibserverutils::isgibbed(entity, 16);
    leftarmgibbed = gibserverutils::isgibbed(entity, 32);
    if (rightarmgibbed && leftarmgibbed) {
        return "both_arms";
    } else if (rightarmgibbed) {
        return "right_arm";
    } else if (leftarmgibbed) {
        return "left_arm";
    }
    return "none";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x4
// Checksum 0x33f3ceed, Offset: 0x3158
// Size: 0x102
function private bb_getyawtocovernode() {
    if (!isdefined(self.node)) {
        return 0;
    }
    disttonodesqr = distance2dsquared(self getnodeoffsetposition(self.node), self.origin);
    if (isdefined(self.keepclaimednode) && self.keepclaimednode) {
        if (disttonodesqr > 64 * 64) {
            return 0;
        }
    } else if (disttonodesqr > 24 * 24) {
        return 0;
    }
    angletonode = ceil(angleclamp180(self.angles[1] - self getnodeoffsetangles(self.node)[1]));
    return angletonode;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x47f015de, Offset: 0x3268
// Size: 0x84
function bb_gethigheststance() {
    if (self isatcovernodestrict() && self shouldusecovernode()) {
        higheststance = gethighestnodestance(self.node);
        return higheststance;
    }
    return self getblackboardattribute("_stance");
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x47ceca8a, Offset: 0x32f8
// Size: 0xba
function bb_getlocomotionfaceenemyquadrantprevious() {
    if (isdefined(self.prevrelativedir)) {
        direction = self.prevrelativedir;
        switch (direction) {
        case 0:
            return "locomotion_face_enemy_none";
        case 1:
            return "locomotion_face_enemy_front";
        case 2:
            return "locomotion_face_enemy_right";
        case 3:
            return "locomotion_face_enemy_left";
        case 4:
            return "locomotion_face_enemy_back";
        }
    }
    return "locomotion_face_enemy_none";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x5df8de5e, Offset: 0x33c0
// Size: 0x1a
function bb_getcurrentcovernodetype() {
    return getcovertype(self.node);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x9914cdbe, Offset: 0x33e8
// Size: 0x2e
function bb_getcoverconcealed() {
    if (iscoverconcealed(self.node)) {
        return "concealed";
    }
    return "unconcealed";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xcbc9ed89, Offset: 0x3420
// Size: 0x6a
function bb_getcurrentlocationcovernodetype() {
    if (isdefined(self.node) && distancesquared(self.origin, self.node.origin) < 48 * 48) {
        return bb_getcurrentcovernodetype();
    }
    return bb_getpreviouscovernodetype();
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xdc87fd27, Offset: 0x3498
// Size: 0x2a
function bb_getshouldturn() {
    if (isdefined(self.should_turn) && self.should_turn) {
        return "should_turn";
    }
    return "should_not_turn";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x879c90c9, Offset: 0x34d0
// Size: 0x3a
function bb_getarmsposition() {
    if (isdefined(self.zombie_arms_position)) {
        if (self.zombie_arms_position == "up") {
            return "arms_up";
        }
        return "arms_down";
    }
    return "arms_up";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xa37e04d8, Offset: 0x3518
// Size: 0x1e
function bb_gethaslegsstatus() {
    if (self.missinglegs) {
        return "has_legs_no";
    }
    return "has_legs_yes";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xe2773f8f, Offset: 0x3540
// Size: 0x2e
function function_65e6e2b7() {
    if (gibserverutils::isgibbed(self, 32)) {
        return "has_left_arm_no";
    }
    return "has_left_arm_yes";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x554e828, Offset: 0x3578
// Size: 0x2e
function function_73823808() {
    if (gibserverutils::isgibbed(self, 16)) {
        return "has_right_arm_no";
    }
    return "has_right_arm_yes";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x171a288a, Offset: 0x35b0
// Size: 0x1e
function function_a80c647e() {
    if (isdefined(self.e_grapplee)) {
        return "has_grapplee_yes";
    }
    return "has_grapplee_no";
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0x2a1b276a, Offset: 0x35d8
// Size: 0x16e
function actorgetpredictedyawtoenemy(entity, lookaheadtime) {
    if (isdefined(entity.predictedyawtoenemy) && isdefined(entity.predictedyawtoenemytime) && entity.predictedyawtoenemytime == gettime()) {
        return entity.predictedyawtoenemy;
    }
    selfpredictedpos = entity.origin;
    moveangle = entity.angles[1] + entity getmotionangle();
    selfpredictedpos += (cos(moveangle), sin(moveangle), 0) * 200 * lookaheadtime;
    yaw = vectortoangles(entity lastknownpos(entity.enemy) - selfpredictedpos)[1] - entity.angles[1];
    yaw = absangleclamp360(yaw);
    entity.predictedyawtoenemy = yaw;
    entity.predictedyawtoenemytime = gettime();
    return yaw;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x45de2ece, Offset: 0x3750
// Size: 0x5e
function bb_actorispatroling() {
    entity = self;
    if (entity ai::has_behavior_attribute("patrol") && entity ai::get_behavior_attribute("patrol")) {
        return "patrol_enabled";
    }
    return "patrol_disabled";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xdd1af118, Offset: 0x37b8
// Size: 0x32
function bb_actorhasenemy() {
    entity = self;
    if (isdefined(entity.enemy)) {
        return "has_enemy";
    }
    return "no_enemy";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x7c8d5464, Offset: 0x37f8
// Size: 0x4a
function bb_actorgetenemyyaw() {
    enemy = self.enemy;
    if (!isdefined(enemy)) {
        return 0;
    }
    toenemyyaw = actorgetpredictedyawtoenemy(self, 0.2);
    return toenemyyaw;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x41041ca2, Offset: 0x3850
// Size: 0xb0
function bb_actorgetperfectenemyyaw() {
    enemy = self.enemy;
    if (!isdefined(enemy)) {
        return 0;
    }
    toenemyyaw = vectortoangles(enemy.origin - self.origin)[1] - self.angles[1];
    toenemyyaw = absangleclamp360(toenemyyaw);
    /#
        recordenttext("<dev string:x5a>" + toenemyyaw, self, (1, 0, 0), "<dev string:x65>");
    #/
    return toenemyyaw;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x7d70da, Offset: 0x3908
// Size: 0x124
function function_be6de5c5() {
    result = self.angles[1];
    v_origin = self geteventpointofinterest();
    if (!isdefined(v_origin) && isdefined(self.ai.var_1dd56593)) {
        v_origin = self.ai.var_1dd56593.origin;
    }
    if (isdefined(v_origin)) {
        str_typename = self getcurrenteventtypename();
        e_originator = self getcurrenteventoriginator();
        if (str_typename == "bullet" && isdefined(e_originator)) {
            v_origin = e_originator.origin;
        }
        deltaorigin = v_origin - self.origin;
        result = vectortoangles(deltaorigin)[1];
    }
    return result;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xfc1cc707, Offset: 0x3a38
// Size: 0x42
function bb_actorgetreactyaw() {
    return absangleclamp360(self.angles[1] - self getblackboardattribute("_react_yaw_world"));
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xd892e6e7, Offset: 0x3a88
// Size: 0xba
function getangleusingdirection(direction) {
    directionyaw = vectortoangles(direction)[1];
    yawdiff = directionyaw - self.angles[1];
    yawdiff *= 0.00277778;
    flooredyawdiff = floor(yawdiff + 0.5);
    turnangle = (yawdiff - flooredyawdiff) * 360;
    return absangleclamp360(turnangle);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x538a51da, Offset: 0x3b50
// Size: 0x13c
function wasatcovernode() {
    if (isdefined(self.prevnode)) {
        if (self.prevnode.type == #"cover left" || self.prevnode.type == #"cover right" || self.prevnode.type == #"cover pillar" || self.prevnode.type == #"cover stand" || self.prevnode.type == #"conceal stand" || self.prevnode.type == #"cover crouch" || self.prevnode.type == #"cover crouch window" || self.prevnode.type == #"conceal crouch") {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0xb53b1272, Offset: 0x3c98
// Size: 0x4d0
function bb_getlocomotionexityaw(blackboard, yaw) {
    exityaw = undefined;
    if (self haspath()) {
        predictedlookaheadinfo = self predictexit();
        status = predictedlookaheadinfo[#"path_prediction_status"];
        if (!isdefined(self.pathgoalpos)) {
            return -1;
        }
        if (distancesquared(self.origin, self.pathgoalpos) <= 4096) {
            return -1;
        }
        if (status == 3) {
            start = self.origin;
            end = start + vectorscale((0, predictedlookaheadinfo[#"path_prediction_travel_vector"][1], 0), 100);
            angletoexit = vectortoangles(predictedlookaheadinfo[#"path_prediction_travel_vector"])[1];
            exityaw = absangleclamp360(angletoexit - self.prevnode.angles[1]);
        } else if (status == 4) {
            start = self.origin;
            end = start + vectorscale((0, predictedlookaheadinfo[#"path_prediction_travel_vector"][1], 0), 100);
            angletoexit = vectortoangles(predictedlookaheadinfo[#"path_prediction_travel_vector"])[1];
            exityaw = absangleclamp360(angletoexit - self.angles[1]);
        } else if (status == 0) {
            if (wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
                end = self.pathgoalpos;
                angletodestination = vectortoangles(end - self.origin)[1];
                angledifference = absangleclamp360(angletodestination - self.prevnode.angles[1]);
                return angledifference;
            }
            start = predictedlookaheadinfo[#"path_prediction_start_point"];
            end = start + predictedlookaheadinfo[#"path_prediction_travel_vector"];
            exityaw = getangleusingdirection(predictedlookaheadinfo[#"path_prediction_travel_vector"]);
        } else if (status == 2) {
            if (distancesquared(self.origin, self.pathgoalpos) <= 4096) {
                return undefined;
            }
            if (wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
                end = self.pathgoalpos;
                angletodestination = vectortoangles(end - self.origin)[1];
                angledifference = absangleclamp360(angletodestination - self.prevnode.angles[1]);
                return angledifference;
            }
            start = self.origin;
            end = self.pathgoalpos;
            exityaw = getangleusingdirection(vectornormalize(end - start));
        }
    }
    /#
        if (isdefined(exityaw)) {
            record3dtext("<dev string:x70>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x65>", undefined, 0.4);
        }
    #/
    return exityaw;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xba825082, Offset: 0x4170
// Size: 0x14a
function bb_getlocomotionfaceenemyquadrant() {
    /#
        walkstring = getdvarstring(#"tacticalwalkdirection");
        switch (walkstring) {
        case #"right":
            return "<dev string:x7b>";
        case #"left":
            return "<dev string:x97>";
        case #"back":
            return "<dev string:xb2>";
        }
    #/
    if (isdefined(self.relativedir)) {
        direction = self.relativedir;
        switch (direction) {
        case 0:
            return "locomotion_face_enemy_front";
        case 1:
            return "locomotion_face_enemy_front";
        case 2:
            return "locomotion_face_enemy_right";
        case 3:
            return "locomotion_face_enemy_left";
        case 4:
            return "locomotion_face_enemy_back";
        }
    }
    return "locomotion_face_enemy_front";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x647a5b1a, Offset: 0x42c8
// Size: 0x272
function bb_getlocomotionpaintype() {
    if (self haspath()) {
        predictedlookaheadinfo = self predictpath();
        status = predictedlookaheadinfo[#"path_prediction_status"];
        startpos = self.origin;
        furthestpointtowardsgoalclear = 1;
        if (status == 2) {
            furthestpointalongtowardsgoal = startpos + vectorscale(self.lookaheaddir, 300);
            furthestpointtowardsgoalclear = self findpath(startpos, furthestpointalongtowardsgoal, 0, 0) && self maymovetopoint(furthestpointalongtowardsgoal);
        }
        if (furthestpointtowardsgoalclear) {
            forwarddir = anglestoforward(self.angles);
            possiblepaintypes = [];
            endpos = startpos + vectorscale(forwarddir, 300);
            if (self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
                possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_long";
            }
            endpos = startpos + vectorscale(forwarddir, 200);
            if (self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
                possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_med";
            }
            endpos = startpos + vectorscale(forwarddir, 150);
            if (self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
                possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_short";
            }
            if (possiblepaintypes.size) {
                return array::random(possiblepaintypes);
            }
        }
    }
    return "locomotion_inplace_pain";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x735c50fb, Offset: 0x4548
// Size: 0x42
function bb_getlookaheadangle() {
    return absangleclamp360(vectortoangles(self.lookaheaddir)[1] - self.angles[1]);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x30f493c7, Offset: 0x4598
// Size: 0x1a
function bb_getpreviouscovernodetype() {
    return getcovertype(self.prevnode);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xdee41ff1, Offset: 0x45c0
// Size: 0x306
function bb_actorgettrackingturnyaw() {
    var_bc18d2fb = undefined;
    if (isdefined(self.enemy)) {
        if (self cansee(self.enemy)) {
            var_bc18d2fb = self.enemy.origin;
        } else if (issentient(self.enemy)) {
            if (self.highlyawareradius && distance2dsquared(self.enemy.origin, self.origin) < self.highlyawareradius * self.highlyawareradius) {
                var_bc18d2fb = self.enemy.origin;
            } else {
                var_5e534fba = self function_5e534fba(self.enemy);
                attackedrecently = self attackedrecently(self.enemy, 2);
                if (attackedrecently && isdefined(var_5e534fba)) {
                    if (self canshoot(var_5e534fba)) {
                        var_bc18d2fb = self.var_5e534fba;
                    }
                }
                if (!isdefined(var_bc18d2fb)) {
                    if (issentient(self.enemy)) {
                        lastknownpostime = self lastknowntime(self.enemy);
                        lastknownpos = self lastknownpos(self.enemy);
                    } else {
                        lastknownpostime = gettime();
                        lastknownpos = self.enemy.origin;
                    }
                    if (gettime() <= lastknownpostime + 2) {
                        if (sighttracepassed(self geteye(), lastknownpos, 0, self, self.enemy)) {
                            var_bc18d2fb = lastknownpos;
                        }
                    }
                }
            }
        }
    } else if (isdefined(self.ai.var_d829299a)) {
        var_bc18d2fb = [[ self.ai.var_d829299a ]](self);
    } else if (isdefined(self.likelyenemyposition)) {
        if (self canshoot(self.likelyenemyposition)) {
            var_bc18d2fb = self.likelyenemyposition;
        }
    }
    if (isdefined(var_bc18d2fb)) {
        turnyaw = absangleclamp360(self.angles[1] - vectortoangles(var_bc18d2fb - self.origin)[1]);
        return turnyaw;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xa4bb0d09, Offset: 0x48d0
// Size: 0xa
function bb_getweaponclass() {
    return "rifle";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x7fee5ae0, Offset: 0x48e8
// Size: 0x4a
function function_333b8895() {
    angles = self gettagangles("tag_origin");
    return angleclamp180(angles[0]);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x81a4bb7c, Offset: 0x4940
// Size: 0x4a
function function_bf0b4c75() {
    if (!isdefined(self.favoriteenemy)) {
        return 0;
    }
    velocity = self.favoriteenemy getvelocity();
    return length(velocity);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x63135df4, Offset: 0x4998
// Size: 0x36
function function_15239fd6() {
    if (!isdefined(self.enemy)) {
        return 0;
    }
    return self.enemy.origin[2] - self.origin[2];
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xb4e92af, Offset: 0x49d8
// Size: 0x40
function notstandingcondition(behaviortreeentity) {
    if (behaviortreeentity getblackboardattribute("_stance") != "stand") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xec28b561, Offset: 0x4a20
// Size: 0x40
function notcrouchingcondition(behaviortreeentity) {
    if (behaviortreeentity getblackboardattribute("_stance") != "crouch") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xc493b55c, Offset: 0x4a68
// Size: 0x24
function scriptstartragdoll(behaviortreeentity) {
    behaviortreeentity startragdoll();
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x468f5362, Offset: 0x4a98
// Size: 0xf4
function private prepareforexposedmelee(behaviortreeentity) {
    keepclaimnode(behaviortreeentity);
    meleeacquiremutex(behaviortreeentity);
    currentstance = behaviortreeentity getblackboardattribute("_stance");
    if (isdefined(behaviortreeentity.enemy) && behaviortreeentity.enemy.scriptvehicletype === "firefly") {
        behaviortreeentity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
    }
    if (currentstance == "crouch") {
        behaviortreeentity setblackboardattribute("_desired_stance", "stand");
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xe79d3730, Offset: 0x4b98
// Size: 0x3c
function isfrustrated(behaviortreeentity) {
    return isdefined(behaviortreeentity.ai.frustrationlevel) && behaviortreeentity.ai.frustrationlevel > 0;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x4e8e0d7f, Offset: 0x4be0
// Size: 0x34
function clampfrustration(frustrationlevel) {
    if (frustrationlevel > 4) {
        return 4;
    } else if (frustrationlevel < 0) {
        return 0;
    }
    return frustrationlevel;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xd311765, Offset: 0x4c20
// Size: 0x42e
function updatefrustrationlevel(entity) {
    if (!isdefined(entity.ai.frustrationlevel)) {
        entity.ai.frustrationlevel = 0;
    }
    if (!isdefined(entity.enemy)) {
        entity.ai.frustrationlevel = 0;
        return false;
    }
    /#
        record3dtext("<dev string:xcd>" + entity.ai.frustrationlevel, entity.origin, (1, 0.5, 0), "<dev string:x65>");
    #/
    if (isactor(entity.enemy) || isplayer(entity.enemy)) {
        if (entity.ai.aggressivemode) {
            if (!isdefined(entity.ai.lastfrustrationboost)) {
                entity.ai.lastfrustrationboost = gettime();
            }
            if (entity.ai.lastfrustrationboost + 5000 < gettime()) {
                entity.ai.frustrationlevel++;
                entity.ai.lastfrustrationboost = gettime();
                entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
            }
        }
        isawareofenemy = gettime() - entity lastknowntime(entity.enemy) < int(10 * 1000);
        if (entity.ai.frustrationlevel == 4) {
            hasseenenemy = entity seerecently(entity.enemy, 2);
        } else {
            hasseenenemy = entity seerecently(entity.enemy, 5);
        }
        hasattackedenemyrecently = entity attackedrecently(entity.enemy, 5);
        if (!isawareofenemy || isactor(entity.enemy)) {
            if (!hasseenenemy) {
                entity.ai.frustrationlevel++;
            } else if (!hasattackedenemyrecently) {
                entity.ai.frustrationlevel += 2;
            }
            entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
            return true;
        }
        if (hasattackedenemyrecently) {
            entity.ai.frustrationlevel -= 2;
            entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
            return true;
        } else if (hasseenenemy) {
            entity.ai.frustrationlevel--;
            entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xe2821ae4, Offset: 0x5058
// Size: 0x24
function flagenemyunattackableservice(behaviortreeentity) {
    behaviortreeentity flagenemyunattackable();
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xd195a720, Offset: 0x5088
// Size: 0x98
function islastknownenemypositionapproachable(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        lastknownpositionofenemy = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
        if (behaviortreeentity isingoal(lastknownpositionofenemy) && behaviortreeentity findpath(behaviortreeentity.origin, lastknownpositionofenemy, 1, 0)) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x4343fe07, Offset: 0x5128
// Size: 0xfc
function tryadvancingonlastknownpositionbehavior(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        if (isdefined(behaviortreeentity.ai.aggressivemode) && behaviortreeentity.ai.aggressivemode) {
            lastknownpositionofenemy = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
            if (behaviortreeentity isingoal(lastknownpositionofenemy) && behaviortreeentity findpath(behaviortreeentity.origin, lastknownpositionofenemy, 1, 0)) {
                behaviortreeentity function_3c8dce03(lastknownpositionofenemy, lastknownpositionofenemy);
                setnextfindbestcovertime(behaviortreeentity, undefined);
                return true;
            }
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x2a172352, Offset: 0x5230
// Size: 0xe4
function trygoingtoclosestnodetoenemybehavior(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        closestrandomnode = behaviortreeentity findbestcovernodes(behaviortreeentity.engagemaxdist, behaviortreeentity.enemy.origin)[0];
        if (isdefined(closestrandomnode) && behaviortreeentity isingoal(closestrandomnode.origin) && behaviortreeentity findpath(behaviortreeentity.origin, closestrandomnode.origin, 1, 0)) {
            usecovernodewrapper(behaviortreeentity, closestrandomnode);
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x401b1c91, Offset: 0x5320
// Size: 0xf4
function tryrunningdirectlytoenemybehavior(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy) && isdefined(behaviortreeentity.ai.aggressivemode) && behaviortreeentity.ai.aggressivemode) {
        origin = behaviortreeentity.enemy.origin;
        if (behaviortreeentity isingoal(origin) && behaviortreeentity findpath(behaviortreeentity.origin, origin, 1, 0)) {
            behaviortreeentity function_3c8dce03(origin, origin);
            setnextfindbestcovertime(behaviortreeentity, undefined);
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xafca3d8a, Offset: 0x5420
// Size: 0x16
function shouldreacttonewenemy(behaviortreeentity) {
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x6a9f89da, Offset: 0x54c0
// Size: 0x28
function hasweaponmalfunctioned(behaviortreeentity) {
    return isdefined(behaviortreeentity.malfunctionreaction) && behaviortreeentity.malfunctionreaction;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xe36e9c76, Offset: 0x54f0
// Size: 0x186
function issafefromgrenades(entity) {
    if (isdefined(entity.grenade) && isdefined(entity.grenade.weapon) && entity.grenade !== entity.knowngrenade && !entity issafefromgrenade()) {
        if (isdefined(entity.node)) {
            offsetorigin = entity getnodeoffsetposition(entity.node);
            percentradius = distance(entity.grenade.origin, offsetorigin);
            if (entity.grenadeawareness >= percentradius) {
                return true;
            }
        } else {
            percentradius = distance(entity.grenade.origin, entity.origin) / entity.grenade.weapon.explosionradius;
            if (entity.grenadeawareness >= percentradius) {
                return true;
            }
        }
        entity.knowngrenade = entity.grenade;
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xa384868d, Offset: 0x5680
// Size: 0x24
function ingrenadeblastradius(entity) {
    return !entity issafefromgrenade();
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x3d1a433, Offset: 0x56b0
// Size: 0x58
function recentlysawenemy(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy) && behaviortreeentity seerecently(behaviortreeentity.enemy, 6)) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x56dbef7a, Offset: 0x5710
// Size: 0x34
function shouldonlyfireaccurately(behaviortreeentity) {
    if (isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x78a8a979, Offset: 0x5750
// Size: 0x44
function shouldbeaggressive(behaviortreeentity) {
    if (isdefined(behaviortreeentity.ai.aggressivemode) && behaviortreeentity.ai.aggressivemode) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0x939fa7b6, Offset: 0x57a0
// Size: 0xbc
function usecovernodewrapper(behaviortreeentity, node) {
    samenode = behaviortreeentity.node === node;
    behaviortreeentity usecovernode(node);
    if (!samenode) {
        behaviortreeentity setblackboardattribute("_cover_mode", "cover_mode_none");
        behaviortreeentity setblackboardattribute("_previous_cover_mode", "cover_mode_none");
    }
    setnextfindbestcovertime(behaviortreeentity, node);
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0x52a85911, Offset: 0x5868
// Size: 0x56
function setnextfindbestcovertime(behaviortreeentity, node) {
    behaviortreeentity.nextfindbestcovertime = behaviortreeentity getnextfindbestcovertime(behaviortreeentity.engagemindist, behaviortreeentity.engagemaxdist, behaviortreeentity.coversearchinterval);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xfa0e7656, Offset: 0x58c8
// Size: 0xa2
function trackcoverparamsservice(behaviortreeentity) {
    if (isdefined(behaviortreeentity.node) && behaviortreeentity isatcovernodestrict() && behaviortreeentity shouldusecovernode()) {
        if (!isdefined(behaviortreeentity.covernode)) {
            behaviortreeentity.covernode = behaviortreeentity.node;
            setnextfindbestcovertime(behaviortreeentity, behaviortreeentity.node);
        }
        return;
    }
    behaviortreeentity.covernode = undefined;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x25fa0bf2, Offset: 0x5978
// Size: 0x5c
function choosebestcovernodeasap(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.enemy)) {
        return 0;
    }
    node = getbestcovernodeifavailable(behaviortreeentity);
    if (isdefined(node)) {
        usecovernodewrapper(behaviortreeentity, node);
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x50f94a3b, Offset: 0x59e0
// Size: 0x43c
function shouldchoosebettercover(behaviortreeentity) {
    if (behaviortreeentity ai::has_behavior_attribute("stealth") && behaviortreeentity ai::get_behavior_attribute("stealth")) {
        return 0;
    }
    if (isdefined(behaviortreeentity.avoid_cover) && behaviortreeentity.avoid_cover) {
        return 0;
    }
    if (behaviortreeentity isinanybadplace()) {
        return 1;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        shouldusecovernoderesult = 0;
        shouldbeboredatcurrentcover = 0;
        abouttoarriveatcover = 0;
        iswithineffectiverangealready = 0;
        islookingaroundforenemy = 0;
        if (behaviortreeentity shouldholdgroundagainstenemy()) {
            return 0;
        }
        if (behaviortreeentity haspath() && isdefined(behaviortreeentity.arrivalfinalpos) && isdefined(behaviortreeentity.pathgoalpos) && self.pathgoalpos == behaviortreeentity.arrivalfinalpos) {
            if (distancesquared(behaviortreeentity.origin, behaviortreeentity.arrivalfinalpos) < 4096) {
                abouttoarriveatcover = 1;
            }
        }
        shouldusecovernoderesult = behaviortreeentity shouldusecovernode();
        if (self isatgoal()) {
            if (shouldusecovernoderesult && isdefined(behaviortreeentity.node) && self isatgoal()) {
                lastknownpos = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
                dist = distance2d(behaviortreeentity.origin, lastknownpos);
                if (dist > behaviortreeentity.engageminfalloffdist && dist <= behaviortreeentity.engagemaxfalloffdist) {
                    iswithineffectiverangealready = 1;
                }
            }
            shouldbeboredatcurrentcover = !iswithineffectiverangealready && behaviortreeentity isatcovernode() && gettime() > self.nextfindbestcovertime;
            if (!shouldusecovernoderesult) {
                if (isdefined(behaviortreeentity.ai.frustrationlevel) && behaviortreeentity.ai.frustrationlevel > 0 && behaviortreeentity haspath()) {
                    islookingaroundforenemy = 1;
                }
            }
        }
        shouldlookforbettercover = !islookingaroundforenemy && !abouttoarriveatcover && !iswithineffectiverangealready && (!shouldusecovernoderesult || shouldbeboredatcurrentcover || !self isatgoal());
        /#
            if (shouldlookforbettercover) {
                color = (0, 1, 0);
            } else {
                color = (1, 0, 0);
            }
            recordenttext("<dev string:xdf>" + shouldusecovernoderesult + "<dev string:xfd>" + islookingaroundforenemy + "<dev string:x103>" + abouttoarriveatcover + "<dev string:x109>" + iswithineffectiverangealready + "<dev string:x10f>" + shouldbeboredatcurrentcover, behaviortreeentity, color, "<dev string:x65>");
        #/
    } else {
        return !(behaviortreeentity shouldusecovernode() && behaviortreeentity isapproachinggoal());
    }
    return shouldlookforbettercover;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x1ddbf056, Offset: 0x5e28
// Size: 0x126
function choosebettercoverservicecodeversion(behaviortreeentity) {
    if (isdefined(behaviortreeentity.stealth) && behaviortreeentity ai::get_behavior_attribute("stealth")) {
        return false;
    }
    if (isdefined(behaviortreeentity.avoid_cover) && behaviortreeentity.avoid_cover) {
        return false;
    }
    if (isdefined(behaviortreeentity.knowngrenade)) {
        return false;
    }
    if (!issafefromgrenades(behaviortreeentity)) {
        behaviortreeentity.nextfindbestcovertime = 0;
    }
    if (isdefined(behaviortreeentity.keepclaimednode) && behaviortreeentity.keepclaimednode) {
        return false;
    }
    newnode = behaviortreeentity choosebettercovernode();
    if (isdefined(newnode)) {
        usecovernodewrapper(behaviortreeentity, newnode);
        return true;
    }
    setnextfindbestcovertime(behaviortreeentity, undefined);
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x675ab8d, Offset: 0x5f58
// Size: 0x196
function private choosebettercoverservice(behaviortreeentity) {
    shouldchoosebettercoverresult = shouldchoosebettercover(behaviortreeentity);
    if (shouldchoosebettercoverresult && !behaviortreeentity.keepclaimednode) {
        transitionrunning = behaviortreeentity asmistransitionrunning();
        substatepending = behaviortreeentity asmissubstatepending();
        transdecrunning = behaviortreeentity asmistransdecrunning();
        isbehaviortreeinrunningstate = behaviortreeentity getbehaviortreestatus() == 5;
        if (!transitionrunning && !substatepending && !transdecrunning && isbehaviortreeinrunningstate) {
            node = getbestcovernodeifavailable(behaviortreeentity);
            goingtodifferentnode = isdefined(node) && (!isdefined(behaviortreeentity.node) || node != behaviortreeentity.node);
            if (goingtodifferentnode) {
                usecovernodewrapper(behaviortreeentity, node);
                return true;
            }
            setnextfindbestcovertime(behaviortreeentity, undefined);
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xbf1a02d9, Offset: 0x60f8
// Size: 0x4a
function refillammo(behaviortreeentity) {
    if (behaviortreeentity.weapon != level.weaponnone) {
        behaviortreeentity.ai.bulletsinclip = behaviortreeentity.weapon.clipsize;
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x5eec7c9f, Offset: 0x6150
// Size: 0xae
function getbestcovernodeifavailable(behaviortreeentity) {
    node = behaviortreeentity findbestcovernode();
    if (!isdefined(node)) {
        return undefined;
    }
    if (behaviortreeentity nearclaimnode()) {
        currentnode = self.node;
    }
    if (isdefined(currentnode) && node == currentnode) {
        return undefined;
    }
    if (isdefined(behaviortreeentity.covernode) && node == behaviortreeentity.covernode) {
        return undefined;
    }
    return node;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x44ffc172, Offset: 0x6208
// Size: 0xe6
function getsecondbestcovernodeifavailable(behaviortreeentity) {
    nodes = behaviortreeentity findbestcovernodes(behaviortreeentity.goalradius, behaviortreeentity.origin);
    if (nodes.size > 1) {
        node = nodes[1];
    }
    if (!isdefined(node)) {
        return undefined;
    }
    if (behaviortreeentity nearclaimnode()) {
        currentnode = self.node;
    }
    if (isdefined(currentnode) && node == currentnode) {
        return undefined;
    }
    if (isdefined(behaviortreeentity.covernode) && node == behaviortreeentity.covernode) {
        return undefined;
    }
    return node;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xae0df6ed, Offset: 0x62f8
// Size: 0x19a
function getcovertype(node) {
    if (isdefined(node)) {
        if (node.type == #"cover pillar") {
            return "cover_pillar";
        } else if (node.type == #"cover left") {
            return "cover_left";
        } else if (node.type == #"cover right") {
            return "cover_right";
        } else if (node.type == #"cover stand" || node.type == #"conceal stand") {
            return "cover_stand";
        } else if (node.type == #"cover crouch" || node.type == #"cover crouch window" || node.type == #"conceal crouch") {
            return "cover_crouch";
        } else if (node.type == #"exposed" || node.type == #"guard") {
            return "cover_exposed";
        }
    }
    return "cover_none";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x92b454b3, Offset: 0x64a0
// Size: 0x52
function iscoverconcealed(node) {
    if (isdefined(node)) {
        return (node.type == #"conceal crouch" || node.type == #"conceal stand");
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xa1078d70, Offset: 0x6500
// Size: 0x4c4
function canseeenemywrapper() {
    if (!isdefined(self.enemy)) {
        return 0;
    }
    if (!isdefined(self.node)) {
        return self cansee(self.enemy);
    }
    node = self.node;
    enemyeye = self.enemy geteye();
    yawtoenemy = angleclamp180(node.angles[1] - vectortoangles(enemyeye - node.origin)[1]);
    if (node.type == #"cover left" || node.type == #"cover right") {
        if (yawtoenemy > 60 || yawtoenemy < -60) {
            return 0;
        }
        if (isdefined(node.spawnflags) && (node.spawnflags & 4) == 4) {
            if (node.type == #"cover left" && yawtoenemy > 10) {
                return 0;
            }
            if (node.type == #"cover right" && yawtoenemy < -10) {
                return 0;
            }
        }
    }
    nodeoffset = (0, 0, 0);
    if (node.type == #"cover pillar") {
        assert(!(isdefined(node.spawnflags) && (node.spawnflags & 2048) == 2048) || !(isdefined(node.spawnflags) && (node.spawnflags & 1024) == 1024));
        canseefromleft = 1;
        canseefromright = 1;
        nodeoffset = (-32, 3.7, 60);
        lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
        canseefromleft = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
        nodeoffset = (32, 3.7, 60);
        lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
        canseefromright = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
        return (canseefromright || canseefromleft);
    }
    if (node.type == #"cover left") {
        nodeoffset = (-36, 7, 63);
    } else if (node.type == #"cover right") {
        nodeoffset = (36, 7, 63);
    } else if (node.type == #"cover stand" || node.type == #"conceal stand") {
        nodeoffset = (-3.7, -22, 63);
    } else if (node.type == #"cover crouch" || node.type == #"cover crouch window" || node.type == #"conceal crouch") {
        nodeoffset = (3.5, -12.5, 45);
    }
    lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
    if (sighttracepassed(lookfrompoint, enemyeye, 0, undefined)) {
        return 1;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0xf8fc426, Offset: 0x69d0
// Size: 0x9e
function calculatenodeoffsetposition(node, nodeoffset) {
    right = anglestoright(node.angles);
    forward = anglestoforward(node.angles);
    return node.origin + vectorscale(right, nodeoffset[0]) + vectorscale(forward, nodeoffset[1]) + (0, 0, nodeoffset[2]);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x1823c455, Offset: 0x6a78
// Size: 0x16a
function gethighestnodestance(node) {
    assert(isdefined(node));
    if (isdefined(node.spawnflags) && (node.spawnflags & 4) == 4) {
        return "stand";
    }
    if (isdefined(node.spawnflags) && (node.spawnflags & 8) == 8) {
        return "crouch";
    }
    if (isdefined(node.spawnflags) && (node.spawnflags & 16) == 16) {
        return "prone";
    }
    errormsg(node.type + "<dev string:x115>" + node.origin + "<dev string:x11e>");
    if (node.type == #"cover crouch" || node.type == #"cover crouch window" || node.type == #"conceal crouch") {
        return "crouch";
    }
    return "stand";
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0xbf967011, Offset: 0x6bf0
// Size: 0x112
function isstanceallowedatnode(stance, node) {
    assert(isdefined(stance));
    assert(isdefined(node));
    if (stance == "stand" && isdefined(node.spawnflags) && (node.spawnflags & 4) == 4) {
        return true;
    }
    if (stance == "crouch" && isdefined(node.spawnflags) && (node.spawnflags & 8) == 8) {
        return true;
    }
    if (stance == "prone" && isdefined(node.spawnflags) && (node.spawnflags & 16) == 16) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x1a99279f, Offset: 0x6d10
// Size: 0x60
function trystoppingservice(behaviortreeentity) {
    if (behaviortreeentity shouldholdgroundagainstenemy()) {
        behaviortreeentity clearpath();
        behaviortreeentity.keepclaimednode = 1;
        return true;
    }
    behaviortreeentity.keepclaimednode = 0;
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x267806a1, Offset: 0x6d78
// Size: 0x2e
function shouldstopmoving(behaviortreeentity) {
    if (behaviortreeentity shouldholdgroundagainstenemy()) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x86afa041, Offset: 0x6db0
// Size: 0x96
function setcurrentweapon(weapon) {
    self.weapon = weapon;
    self.weaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "<dev string:x133>" + weapon.name + "<dev string:x13c>");
    }
    self.weaponmodel = weapon.worldmodel;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x3bf28319, Offset: 0x6e50
// Size: 0x84
function setprimaryweapon(weapon) {
    self.primaryweapon = weapon;
    self.primaryweaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "<dev string:x133>" + weapon.name + "<dev string:x13c>");
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xa3ee0ec2, Offset: 0x6ee0
// Size: 0x84
function setsecondaryweapon(weapon) {
    self.secondaryweapon = weapon;
    self.secondaryweaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "<dev string:x133>" + weapon.name + "<dev string:x13c>");
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x1b9d7cdb, Offset: 0x6f70
// Size: 0x1e
function keepclaimnode(behaviortreeentity) {
    behaviortreeentity.keepclaimednode = 1;
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x6e0751ae, Offset: 0x6f98
// Size: 0x1e
function releaseclaimnode(behaviortreeentity) {
    behaviortreeentity.keepclaimednode = 0;
    return true;
}

// Namespace aiutility/archetype_utility
// Params 3, eflags: 0x0
// Checksum 0x11416381, Offset: 0x6fc0
// Size: 0x82
function getaimyawtoenemyfromnode(behaviortreeentity, node, enemy) {
    return angleclamp180(vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[1] - node.angles[1]);
}

// Namespace aiutility/archetype_utility
// Params 3, eflags: 0x0
// Checksum 0x22dd8457, Offset: 0x7050
// Size: 0x82
function getaimpitchtoenemyfromnode(behaviortreeentity, node, enemy) {
    return angleclamp180(vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[0] - node.angles[0]);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x222e0eeb, Offset: 0x70e0
// Size: 0x7c
function choosefrontcoverdirection(behaviortreeentity) {
    coverdirection = behaviortreeentity getblackboardattribute("_cover_direction");
    behaviortreeentity setblackboardattribute("_previous_cover_direction", coverdirection);
    behaviortreeentity setblackboardattribute("_cover_direction", "cover_front_direction");
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xfbf6d719, Offset: 0x7168
// Size: 0x1c6
function shouldtacticalwalk(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (ai::hasaiattribute(behaviortreeentity, "forceTacticalWalk") && ai::getaiattribute(behaviortreeentity, "forceTacticalWalk")) {
        return true;
    }
    if (ai::hasaiattribute(behaviortreeentity, "disablesprint") && !ai::getaiattribute(behaviortreeentity, "disablesprint")) {
        if (ai::hasaiattribute(behaviortreeentity, "sprint") && ai::getaiattribute(behaviortreeentity, "sprint")) {
            return false;
        }
    }
    goalpos = undefined;
    if (isdefined(behaviortreeentity.arrivalfinalpos)) {
        goalpos = behaviortreeentity.arrivalfinalpos;
    } else {
        goalpos = behaviortreeentity.pathgoalpos;
    }
    if (isdefined(behaviortreeentity.pathstartpos) && isdefined(goalpos)) {
        pathdist = distancesquared(behaviortreeentity.pathstartpos, goalpos);
        if (pathdist < 9216) {
            return true;
        }
    }
    if (behaviortreeentity shouldfacemotion()) {
        return false;
    }
    if (!behaviortreeentity issafefromgrenade()) {
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xba1ae2d2, Offset: 0x7338
// Size: 0x58
function shouldstealth(behaviortreeentity) {
    if (behaviortreeentity ai::has_behavior_attribute("stealth") && behaviortreeentity ai::get_behavior_attribute("stealth")) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xb59cd1cc, Offset: 0x7398
// Size: 0x2e
function locomotionshouldstealth(behaviortreeentity) {
    if (behaviortreeentity haspath()) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xf39aff6e, Offset: 0x73d0
// Size: 0x5e
function shouldstealthresume(behaviortreeentity) {
    if (!shouldstealth(behaviortreeentity)) {
        return false;
    }
    if (isdefined(behaviortreeentity.stealth_resume) && behaviortreeentity.stealth_resume) {
        behaviortreeentity.stealth_resume = undefined;
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x733acc9a, Offset: 0x7438
// Size: 0xa0
function private stealthreactcondition(entity) {
    inscene = isdefined(self._o_scene) && isdefined(self._o_scene._str_state) && self._o_scene._str_state == "play";
    return !(isdefined(entity.stealth_reacting) && entity.stealth_reacting) && entity hasvalidinterrupt("react") && !inscene;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0xbfd06b4a, Offset: 0x74e0
// Size: 0x1a
function private stealthreactstart(behaviortreeentity) {
    behaviortreeentity.stealth_reacting = 1;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x7976491e, Offset: 0x7508
// Size: 0x16
function private stealthreactterminate(behaviortreeentity) {
    behaviortreeentity.stealth_reacting = undefined;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x47c62309, Offset: 0x7528
// Size: 0x5a
function private stealthidleterminate(behaviortreeentity) {
    behaviortreeentity notify(#"stealthidleterminate");
    if (isdefined(behaviortreeentity.stealth_resume_after_idle) && behaviortreeentity.stealth_resume_after_idle) {
        behaviortreeentity.stealth_resume_after_idle = undefined;
        behaviortreeentity.stealth_resume = 1;
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x70f4d520, Offset: 0x7590
// Size: 0x88
function locomotionshouldpatrol(behaviortreeentity) {
    if (shouldstealth(behaviortreeentity)) {
        return false;
    }
    if (behaviortreeentity haspath() && behaviortreeentity ai::has_behavior_attribute("patrol") && behaviortreeentity ai::get_behavior_attribute("patrol")) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x1385457, Offset: 0x7620
// Size: 0x7c
function private _dropriotshield(riotshieldinfo) {
    entity = self;
    entity shared::throwweapon(riotshieldinfo.weapon, riotshieldinfo.tag, 1, 0);
    if (isdefined(entity)) {
        entity detach(riotshieldinfo.model, riotshieldinfo.tag);
    }
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0x103607a2, Offset: 0x76a8
// Size: 0xa2
function attachriotshield(entity, riotshieldweapon, riotshieldmodel, riotshieldtag) {
    riotshield = spawnstruct();
    riotshield.weapon = riotshieldweapon;
    riotshield.tag = riotshieldtag;
    riotshield.model = riotshieldmodel;
    entity attach(riotshieldmodel, riotshield.tag);
    entity.riotshield = riotshield;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x5ad6487e, Offset: 0x7758
// Size: 0x54
function dropriotshield(behaviortreeentity) {
    if (isdefined(behaviortreeentity.riotshield)) {
        riotshieldinfo = behaviortreeentity.riotshield;
        behaviortreeentity.riotshield = undefined;
        behaviortreeentity thread _dropriotshield(riotshieldinfo);
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xfec7782c, Offset: 0x77b8
// Size: 0xa4
function meleeacquiremutex(behaviortreeentity) {
    if (isdefined(behaviortreeentity) && isdefined(behaviortreeentity.enemy)) {
        behaviortreeentity.meleeenemy = behaviortreeentity.enemy;
        if (isplayer(behaviortreeentity.meleeenemy)) {
            if (!isdefined(behaviortreeentity.meleeenemy.meleeattackers)) {
                behaviortreeentity.meleeenemy.meleeattackers = 0;
            }
            behaviortreeentity.meleeenemy.meleeattackers++;
        }
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xe89de898, Offset: 0x7868
// Size: 0xb6
function meleereleasemutex(behaviortreeentity) {
    if (isdefined(behaviortreeentity.meleeenemy)) {
        if (isplayer(behaviortreeentity.meleeenemy)) {
            if (isdefined(behaviortreeentity.meleeenemy.meleeattackers)) {
                behaviortreeentity.meleeenemy.meleeattackers -= 1;
                if (behaviortreeentity.meleeenemy.meleeattackers <= 0) {
                    behaviortreeentity.meleeenemy.meleeattackers = undefined;
                }
            }
        }
    }
    behaviortreeentity.meleeenemy = undefined;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x3658e865, Offset: 0x7928
// Size: 0xaa
function shouldmutexmelee(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        if (!isplayer(behaviortreeentity.enemy)) {
            if (behaviortreeentity.enemy.meleeattackers) {
                return false;
            }
        } else {
            if (!sessionmodeiscampaigngame()) {
                return true;
            }
            behaviortreeentity.enemy.meleeattackers = 0;
            return (behaviortreeentity.enemy.meleeattackers < 1);
        }
    }
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xa75aa982, Offset: 0x79e0
// Size: 0x22
function shouldnormalmelee(behaviortreeentity) {
    return hascloseenemytomelee(behaviortreeentity);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x38966140, Offset: 0x7a10
// Size: 0x2ee
function shouldmelee(entity) {
    if (isdefined(entity.ai.lastshouldmeleeresult) && !entity.ai.lastshouldmeleeresult && entity.ai.lastshouldmeleechecktime + 50 >= gettime()) {
        return false;
    }
    entity.lastshouldmeleechecktime = gettime();
    entity.lastshouldmeleeresult = 0;
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (!entity.enemy.allowdeath) {
        return false;
    }
    if (!isalive(entity.enemy)) {
        return false;
    }
    if (!issentient(entity.enemy)) {
        return false;
    }
    if (isvehicle(entity.enemy) && !(isdefined(entity.enemy.ai.good_melee_target) && entity.enemy.ai.good_melee_target)) {
        return false;
    }
    if (isplayer(entity.enemy) && entity.enemy getstance() == "prone") {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) > 140 * 140) {
        return false;
    }
    if (ai::hasaiattribute(entity, "can_melee") && !ai::getaiattribute(entity, "can_melee")) {
        return false;
    }
    if (ai::hasaiattribute(entity.enemy, "can_be_meleed") && !ai::getaiattribute(entity.enemy, "can_be_meleed")) {
        return false;
    }
    if (!shouldmutexmelee(entity)) {
        return false;
    }
    if (shouldnormalmelee(entity) || shouldchargemelee(entity)) {
        entity.ai.lastshouldmeleeresult = 1;
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xe20b2d38, Offset: 0x7d08
// Size: 0x2a
function hascloseenemytomelee(entity) {
    return hascloseenemytomeleewithrange(entity, 64 * 64);
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0xfc8c3381, Offset: 0x7d40
// Size: 0x1a4
function hascloseenemytomeleewithrange(entity, melee_range_sq) {
    assert(isdefined(entity.enemy));
    if (!entity cansee(entity.enemy)) {
        return false;
    }
    predicitedposition = entity.enemy.origin + vectorscale(entity getenemyvelocity(), 0.25);
    distsq = distancesquared(entity.origin, predicitedposition);
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (distsq <= 36 * 36) {
        return (abs(yawtoenemy) <= 40);
    }
    if (distsq <= melee_range_sq && entity maymovetopoint(entity.enemy.origin)) {
        return (abs(yawtoenemy) <= 80);
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x805ee3b9, Offset: 0x7ef0
// Size: 0x20c
function shouldchargemelee(entity) {
    assert(isdefined(entity.enemy));
    currentstance = entity getblackboardattribute("_stance");
    if (currentstance != "stand") {
        return false;
    }
    if (isdefined(entity.ai.nextchargemeleetime)) {
        if (gettime() < entity.ai.nextchargemeleetime) {
            return false;
        }
    }
    enemydistsq = distancesquared(entity.origin, entity.enemy.origin);
    if (enemydistsq < 64 * 64) {
        return false;
    }
    offset = entity.enemy.origin - vectornormalize(entity.enemy.origin - entity.origin) * 36;
    if (enemydistsq < 140 * 140 && entity maymovetopoint(offset, 1, 1)) {
        yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
        return (abs(yawtoenemy) <= 80);
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x6090f8cc, Offset: 0x8108
// Size: 0xe4
function private shouldattackinchargemelee(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) < 74 * 74) {
            yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
            if (abs(yawtoenemy) > 80) {
                return 0;
            }
            return 1;
        }
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0xc53132f0, Offset: 0x81f8
// Size: 0x94
function private setupchargemeleeattack(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy) && behaviortreeentity.enemy.scriptvehicletype === "firefly") {
        behaviortreeentity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
    }
    meleeacquiremutex(behaviortreeentity);
    keepclaimnode(behaviortreeentity);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0xbae3318, Offset: 0x8298
// Size: 0xe4
function private cleanupmelee(behaviortreeentity) {
    meleereleasemutex(behaviortreeentity);
    releaseclaimnode(behaviortreeentity);
    behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);
    if (isdefined(behaviortreeentity.ai.var_b8307596) && isdefined(behaviortreeentity.ai.var_5d8a9708)) {
        behaviortreeentity pathmode("move delayed", 1, randomfloatrange(behaviortreeentity.ai.var_b8307596, behaviortreeentity.ai.var_5d8a9708));
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0xe579f51b, Offset: 0x8388
// Size: 0xb4
function private cleanupchargemelee(behaviortreeentity) {
    behaviortreeentity.ai.nextchargemeleetime = gettime() + 2000;
    behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);
    meleereleasemutex(behaviortreeentity);
    releaseclaimnode(behaviortreeentity);
    behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.75, 1.5));
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x41b8a920, Offset: 0x8448
// Size: 0x124
function cleanupchargemeleeattack(behaviortreeentity) {
    meleereleasemutex(behaviortreeentity);
    releaseclaimnode(behaviortreeentity);
    behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);
    if (isdefined(behaviortreeentity.ai.var_b8307596) && isdefined(behaviortreeentity.ai.var_5d8a9708)) {
        behaviortreeentity pathmode("move delayed", 1, randomfloatrange(behaviortreeentity.ai.var_b8307596, behaviortreeentity.ai.var_5d8a9708));
        return;
    }
    behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.5, 1));
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0xc5a63046, Offset: 0x8578
// Size: 0x56
function private shouldchoosespecialpronepain(behaviortreeentity) {
    stance = behaviortreeentity getblackboardattribute("_stance");
    return stance == "prone_back" || stance == "prone_front";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x413d09a3, Offset: 0x85d8
// Size: 0x20
function private function_54565247(behaviortreeentity) {
    return behaviortreeentity.var_a38dd6f === "concussion";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x6dac8a3b, Offset: 0x8600
// Size: 0x18
function private shouldchoosespecialpain(behaviortreeentity) {
    return isdefined(behaviortreeentity.var_a38dd6f);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x4c1eda83, Offset: 0x8620
// Size: 0x16
function private function_1209ee0e(behaviortreeentity) {
    return behaviortreeentity.var_95f5f66f;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x3f8a3681, Offset: 0x8640
// Size: 0x32
function private shouldchoosespecialdeath(behaviortreeentity) {
    if (isdefined(behaviortreeentity.damageweapon)) {
        return behaviortreeentity.damageweapon.specialpain;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x49e9e569, Offset: 0x8680
// Size: 0x56
function private shouldchoosespecialpronedeath(behaviortreeentity) {
    stance = behaviortreeentity getblackboardattribute("_stance");
    return stance == "prone_back" || stance == "prone_front";
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x4
// Checksum 0xd3ff351e, Offset: 0x86e0
// Size: 0x40
function private setupexplosionanimscale(entity, asmstatename) {
    self.animtranslationscale = 2;
    self asmsetanimationrate(0.7);
    return 4;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x3fd8bd5f, Offset: 0x8728
// Size: 0x14e
function isbalconydeath(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.node)) {
        return false;
    }
    if (!(behaviortreeentity.node.spawnflags & 1024 || behaviortreeentity.node.spawnflags & 2048)) {
        return false;
    }
    covermode = behaviortreeentity getblackboardattribute("_cover_mode");
    if (isdefined(behaviortreeentity.node.script_balconydeathchance) && randomint(100) > int(100 * behaviortreeentity.node.script_balconydeathchance)) {
        return false;
    }
    distsq = distancesquared(behaviortreeentity.origin, behaviortreeentity.node.origin);
    if (distsq > 64 * 64) {
        return false;
    }
    self.b_balcony_death = 1;
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xdd1ed4b2, Offset: 0x8880
// Size: 0xa4
function balconydeath(behaviortreeentity) {
    behaviortreeentity.clamptonavmesh = 0;
    if (behaviortreeentity.node.spawnflags & 1024) {
        behaviortreeentity setblackboardattribute("_special_death", "balcony");
        return;
    }
    if (behaviortreeentity.node.spawnflags & 2048) {
        behaviortreeentity setblackboardattribute("_special_death", "balcony_norail");
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xd4018643, Offset: 0x8930
// Size: 0x2c
function usecurrentposition(entity) {
    entity function_3c8dce03(entity.origin);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x2a1105ad, Offset: 0x8968
// Size: 0x2c
function isunarmed(behaviortreeentity) {
    if (behaviortreeentity.weapon == level.weaponnone) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x8860748, Offset: 0x89a0
// Size: 0x180
function preshootlaserandglinton(ai) {
    self endon(#"death");
    if (!isdefined(ai.laserstatus)) {
        ai.laserstatus = 0;
    }
    sniper_glint = #"hash_3db1ecb54b192a49";
    while (true) {
        self waittill(#"about_to_fire");
        if (ai.laserstatus !== 1) {
            ai laseron();
            ai.laserstatus = 1;
            tag = ai gettagorigin("tag_flash");
            if (isdefined(tag)) {
                playfxontag(sniper_glint, ai, "tag_flash");
                continue;
            }
            type = isdefined(ai.classname) ? "" + ai.classname : "";
            println("<dev string:x15c>" + type + "<dev string:x160>");
            playfxontag(sniper_glint, ai, "tag_eye");
        }
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x2be3aa89, Offset: 0x8b28
// Size: 0x76
function postshootlaserandglintoff(ai) {
    self endon(#"death");
    while (true) {
        self waittill(#"stopped_firing");
        if (ai.laserstatus === 1) {
            ai laseroff();
            ai.laserstatus = 0;
        }
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x3de02fc6, Offset: 0x8ba8
// Size: 0x2a
function private isinphalanx(entity) {
    return entity ai::get_behavior_attribute("phalanx");
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x979749b9, Offset: 0x8be0
// Size: 0xb6
function private isinphalanxstance(entity) {
    phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
    currentstance = entity getblackboardattribute("_stance");
    switch (phalanxstance) {
    case #"stand":
        return (currentstance == "stand");
    case #"crouch":
        return (currentstance == "crouch");
    }
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x5926c9df, Offset: 0x8ca0
// Size: 0xba
function private togglephalanxstance(entity) {
    phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
    switch (phalanxstance) {
    case #"stand":
        entity setblackboardattribute("_desired_stance", "stand");
        break;
    case #"crouch":
        entity setblackboardattribute("_desired_stance", "crouch");
        break;
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xd94eb763, Offset: 0x8d68
// Size: 0xbe
function isatattackobject(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.attackable) && isdefined(entity.attackable.is_active) && entity.attackable.is_active) {
        if (!isdefined(entity.attackable_slot)) {
            return false;
        }
        if (entity isatgoal()) {
            entity.is_at_attackable = 1;
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x84d31b09, Offset: 0x8e30
// Size: 0xa4
function shouldattackobject(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.attackable) && isdefined(entity.attackable.is_active) && entity.attackable.is_active) {
        if (isdefined(entity.is_at_attackable) && entity.is_at_attackable) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0x8af18145, Offset: 0x8ee0
// Size: 0xb2
function meleeattributescallback(entity, attribute, oldvalue, value) {
    switch (attribute) {
    case #"can_melee":
        if (value) {
            entity.canmelee = 1;
        } else {
            entity.canmelee = 0;
        }
        break;
    case #"can_be_meleed":
        if (value) {
            entity.canbemeleed = 1;
        } else {
            entity.canbemeleed = 0;
        }
        break;
    }
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0xeac182ff, Offset: 0x8fa0
// Size: 0x82
function arrivalattributescallback(entity, attribute, oldvalue, value) {
    switch (attribute) {
    case #"disablearrivals":
        if (value) {
            entity.ai.disablearrivals = 1;
        } else {
            entity.ai.disablearrivals = 0;
        }
        break;
    }
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0x5fab6844, Offset: 0x9030
// Size: 0x5a
function phalanxattributecallback(entity, attribute, oldvalue, value) {
    if (value) {
        entity.ai.phalanx = 1;
        return;
    }
    entity.ai.phalanx = 0;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x91754a0a, Offset: 0x9098
// Size: 0x2ba
function private generictryreacquireservice(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.reacquire_state)) {
        behaviortreeentity.reacquire_state = 0;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    if (behaviortreeentity haspath()) {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    if (behaviortreeentity seerecently(behaviortreeentity.enemy, 4)) {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    dirtoenemy = vectornormalize(behaviortreeentity.enemy.origin - behaviortreeentity.origin);
    forward = anglestoforward(behaviortreeentity.angles);
    if (vectordot(dirtoenemy, forward) < 0.5) {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    switch (behaviortreeentity.reacquire_state) {
    case 0:
    case 1:
    case 2:
        step_size = 32 + behaviortreeentity.reacquire_state * 32;
        reacquirepos = behaviortreeentity reacquirestep(step_size);
        break;
    case 4:
        if (!behaviortreeentity cansee(behaviortreeentity.enemy) || !behaviortreeentity canshootenemy()) {
            behaviortreeentity flagenemyunattackable();
        }
        break;
    default:
        if (behaviortreeentity.reacquire_state > 15) {
            behaviortreeentity.reacquire_state = 0;
            return false;
        }
        break;
    }
    if (isvec(reacquirepos)) {
        behaviortreeentity function_3c8dce03(reacquirepos);
        return true;
    }
    behaviortreeentity.reacquire_state++;
    return false;
}

