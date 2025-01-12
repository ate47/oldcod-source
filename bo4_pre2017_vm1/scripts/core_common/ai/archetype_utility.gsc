#using scripts/core_common/ai/archetype_aivsaimelee;
#using scripts/core_common/ai/archetype_mocomps_utility;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_state_machine;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai/systems/shared;
#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/util_shared;

#namespace aiutility;

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x2
// Checksum 0x5c2b9cd2, Offset: 0x11e0
// Size: 0x1efc
function autoexec registerbehaviorscriptfunctions() {
    assert(iscodefunctionptr(&btapi_forceragdoll));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_forceRagdoll", &btapi_forceragdoll);
    assert(iscodefunctionptr(&btapi_hasammo));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_hasAmmo", &btapi_hasammo);
    assert(iscodefunctionptr(&btapi_haslowammo));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_hasLowAmmo", &btapi_haslowammo);
    assert(iscodefunctionptr(&btapi_hasenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_hasEnemy", &btapi_hasenemy);
    assert(iscodefunctionptr(&btapi_issafefromgrenades));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_isSafeFromGrenades", &btapi_issafefromgrenades);
    assert(isscriptfunctionptr(&issafefromgrenades));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isSafeFromGrenades", &issafefromgrenades);
    assert(isscriptfunctionptr(&ingrenadeblastradius));
    behaviortreenetworkutility::registerbehaviortreescriptapi("inGrenadeBlastRadius", &ingrenadeblastradius);
    assert(isscriptfunctionptr(&recentlysawenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi("recentlySawEnemy", &recentlysawenemy);
    assert(isscriptfunctionptr(&shouldbeaggressive));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldBeAggressive", &shouldbeaggressive);
    assert(isscriptfunctionptr(&shouldonlyfireaccurately));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldOnlyFireAccurately", &shouldonlyfireaccurately);
    assert(isscriptfunctionptr(&shouldreacttonewenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldReactToNewEnemy", &shouldreacttonewenemy);
    assert(isscriptfunctionptr(&shouldreacttonewenemy));
    behaviorstatemachine::registerbsmscriptapiinternal("shouldReactToNewEnemy", &shouldreacttonewenemy);
    assert(isscriptfunctionptr(&hasweaponmalfunctioned));
    behaviortreenetworkutility::registerbehaviortreescriptapi("hasWeaponMalfunctioned", &hasweaponmalfunctioned);
    assert(isscriptfunctionptr(&shouldstopmoving));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStopMoving", &shouldstopmoving);
    assert(isscriptfunctionptr(&shouldstopmoving));
    behaviorstatemachine::registerbsmscriptapiinternal("shouldStopMoving", &shouldstopmoving);
    assert(isscriptfunctionptr(&choosebestcovernodeasap));
    behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBestCoverNodeASAP", &choosebestcovernodeasap);
    assert(isscriptfunctionptr(&choosebettercoverservicecodeversion));
    behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBetterCoverService", &choosebettercoverservicecodeversion, 1);
    assert(iscodefunctionptr(&btapi_trackcoverparamsservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_trackcoverparamsservice", &btapi_trackcoverparamsservice);
    assert(isscriptfunctionptr(&trackcoverparamsservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("trackCoverParamsService", &trackcoverparamsservice);
    assert(iscodefunctionptr(&btapi_refillammoifneededservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btApi_refillammoifneededservice", &btapi_refillammoifneededservice);
    assert(isscriptfunctionptr(&refillammo));
    behaviortreenetworkutility::registerbehaviortreescriptapi("refillAmmoIfNeededService", &refillammo);
    assert(isscriptfunctionptr(&trystoppingservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("tryStoppingService", &trystoppingservice);
    assert(isscriptfunctionptr(&isfrustrated));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isFrustrated", &isfrustrated);
    assert(iscodefunctionptr(&btapi_updatefrustrationlevel));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_updatefrustrationLevel", &btapi_updatefrustrationlevel);
    assert(isscriptfunctionptr(&updatefrustrationlevel));
    behaviortreenetworkutility::registerbehaviortreescriptapi("updatefrustrationLevel", &updatefrustrationlevel);
    assert(isscriptfunctionptr(&islastknownenemypositionapproachable));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isLastKnownEnemyPositionApproachable", &islastknownenemypositionapproachable);
    assert(isscriptfunctionptr(&tryadvancingonlastknownpositionbehavior));
    behaviortreenetworkutility::registerbehaviortreescriptapi("tryAdvancingOnLastKnownPositionBehavior", &tryadvancingonlastknownpositionbehavior);
    assert(isscriptfunctionptr(&trygoingtoclosestnodetoenemybehavior));
    behaviortreenetworkutility::registerbehaviortreescriptapi("tryGoingToClosestNodeToEnemyBehavior", &trygoingtoclosestnodetoenemybehavior);
    assert(isscriptfunctionptr(&tryrunningdirectlytoenemybehavior));
    behaviortreenetworkutility::registerbehaviortreescriptapi("tryRunningDirectlyToEnemyBehavior", &tryrunningdirectlytoenemybehavior);
    assert(isscriptfunctionptr(&flagenemyunattackableservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("flagEnemyUnAttackableService", &flagenemyunattackableservice);
    assert(isscriptfunctionptr(&keepclaimnode));
    behaviortreenetworkutility::registerbehaviortreescriptapi("keepClaimNode", &keepclaimnode);
    assert(isscriptfunctionptr(&keepclaimnode));
    behaviorstatemachine::registerbsmscriptapiinternal("keepClaimNode", &keepclaimnode);
    assert(isscriptfunctionptr(&releaseclaimnode));
    behaviortreenetworkutility::registerbehaviortreescriptapi("releaseClaimNode", &releaseclaimnode);
    assert(isscriptfunctionptr(&scriptstartragdoll));
    behaviortreenetworkutility::registerbehaviortreescriptapi("startRagdoll", &scriptstartragdoll);
    assert(isscriptfunctionptr(&notstandingcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("notStandingCondition", &notstandingcondition);
    assert(isscriptfunctionptr(&notcrouchingcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("notCrouchingCondition", &notcrouchingcondition);
    assert(isscriptfunctionptr(&explosivekilled));
    behaviortreenetworkutility::registerbehaviortreescriptapi("explosiveKilled", &explosivekilled);
    assert(isscriptfunctionptr(&electrifiedkilled));
    behaviortreenetworkutility::registerbehaviortreescriptapi("electrifiedKilled", &electrifiedkilled);
    assert(isscriptfunctionptr(&burnedkilled));
    behaviortreenetworkutility::registerbehaviortreescriptapi("burnedKilled", &burnedkilled);
    assert(isscriptfunctionptr(&rapskilled));
    behaviortreenetworkutility::registerbehaviortreescriptapi("rapsKilled", &rapskilled);
    assert(isscriptfunctionptr(&meleeacquiremutex));
    behaviortreenetworkutility::registerbehaviortreescriptapi("meleeAcquireMutex", &meleeacquiremutex);
    assert(isscriptfunctionptr(&meleereleasemutex));
    behaviortreenetworkutility::registerbehaviortreescriptapi("meleeReleaseMutex", &meleereleasemutex);
    assert(isscriptfunctionptr(&prepareforexposedmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareForExposedMelee", &prepareforexposedmelee);
    assert(isscriptfunctionptr(&cleanupmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupMelee", &cleanupmelee);
    assert(iscodefunctionptr(&btapi_shouldnormalmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_shouldNormalMelee", &btapi_shouldnormalmelee);
    assert(isscriptfunctionptr(&shouldnormalmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldNormalMelee", &shouldnormalmelee);
    assert(iscodefunctionptr(&btapi_shouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_shouldmelee", &btapi_shouldmelee);
    assert(iscodefunctionptr(&btapi_shouldmelee));
    behaviorstatemachine::registerbsmscriptapiinternal("btapi_shouldmelee", &btapi_shouldmelee);
    assert(isscriptfunctionptr(&shouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldMelee", &shouldmelee);
    assert(isscriptfunctionptr(&shouldmelee));
    behaviorstatemachine::registerbsmscriptapiinternal("shouldMelee", &shouldmelee);
    assert(isscriptfunctionptr(&hascloseenemytomelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("hasCloseEnemyMelee", &hascloseenemytomelee);
    assert(isscriptfunctionptr(&isbalconydeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isBalconyDeath", &isbalconydeath);
    assert(isscriptfunctionptr(&balconydeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi("balconyDeath", &balconydeath);
    assert(isscriptfunctionptr(&usecurrentposition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("useCurrentPosition", &usecurrentposition);
    assert(isscriptfunctionptr(&isunarmed));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isUnarmed", &isunarmed);
    assert(iscodefunctionptr(&btapi_shouldchargemelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_shouldChargeMelee", &btapi_shouldchargemelee);
    assert(isscriptfunctionptr(&shouldchargemelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChargeMelee", &shouldchargemelee);
    assert(isscriptfunctionptr(&shouldattackinchargemelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldAttackInChargeMelee", &shouldattackinchargemelee);
    assert(isscriptfunctionptr(&cleanupchargemelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupChargeMelee", &cleanupchargemelee);
    assert(isscriptfunctionptr(&cleanupchargemeleeattack));
    behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupChargeMeleeAttack", &cleanupchargemeleeattack);
    assert(isscriptfunctionptr(&setupchargemeleeattack));
    behaviortreenetworkutility::registerbehaviortreescriptapi("setupChargeMeleeAttack", &setupchargemeleeattack);
    assert(isscriptfunctionptr(&shouldchoosespecialpain));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialPain", &shouldchoosespecialpain);
    assert(isscriptfunctionptr(&shouldchoosespecialpronepain));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialPronePain", &shouldchoosespecialpronepain);
    assert(isscriptfunctionptr(&shouldchoosespecialdeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialDeath", &shouldchoosespecialdeath);
    assert(isscriptfunctionptr(&shouldchoosespecialpronedeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialProneDeath", &shouldchoosespecialpronedeath);
    assert(isscriptfunctionptr(&setupexplosionanimscale));
    behaviortreenetworkutility::registerbehaviortreescriptapi("setupExplosionAnimScale", &setupexplosionanimscale);
    assert(isscriptfunctionptr(&shouldstealth));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStealth", &shouldstealth);
    assert(isscriptfunctionptr(&stealthreactcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("stealthReactCondition", &stealthreactcondition);
    assert(isscriptfunctionptr(&locomotionshouldstealth));
    behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionShouldStealth", &locomotionshouldstealth);
    assert(isscriptfunctionptr(&shouldstealthresume));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStealthResume", &shouldstealthresume);
    assert(isscriptfunctionptr(&locomotionshouldstealth));
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldStealth", &locomotionshouldstealth);
    assert(isscriptfunctionptr(&stealthreactcondition));
    behaviorstatemachine::registerbsmscriptapiinternal("stealthReactCondition", &stealthreactcondition);
    assert(isscriptfunctionptr(&stealthreactstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("stealthReactStart", &stealthreactstart);
    assert(isscriptfunctionptr(&stealthreactterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("stealthReactTerminate", &stealthreactterminate);
    assert(isscriptfunctionptr(&stealthidleterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("stealthIdleTerminate", &stealthidleterminate);
    assert(iscodefunctionptr(&btapi_isinphalanx));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_isinphalanx", &btapi_isinphalanx);
    assert(isscriptfunctionptr(&isinphalanx));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isInPhalanx", &isinphalanx);
    assert(isscriptfunctionptr(&isinphalanxstance));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isInPhalanxStance", &isinphalanxstance);
    assert(isscriptfunctionptr(&togglephalanxstance));
    behaviortreenetworkutility::registerbehaviortreescriptapi("togglePhalanxStance", &togglephalanxstance);
    assert(isscriptfunctionptr(&tookflashbangdamage));
    behaviortreenetworkutility::registerbehaviortreescriptapi("tookFlashbangDamage", &tookflashbangdamage);
    assert(isscriptfunctionptr(&isatattackobject));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isAtAttackObject", &isatattackobject);
    assert(isscriptfunctionptr(&shouldattackobject));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldAttackObject", &shouldattackobject);
    behaviortreenetworkutility::registerbehaviortreeaction("defaultAction", undefined, undefined, undefined);
    archetype_aivsaimelee::registeraivsaimeleebehaviorfunctions();
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x4
// Checksum 0x237a074d, Offset: 0x30e8
// Size: 0x172
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
// Checksum 0xfd5c57b8, Offset: 0x3268
// Size: 0x158
function private bb_gettraversalheight() {
    entity = self;
    startposition = entity.traversalstartpos;
    endposition = entity.traversalendpos;
    if (isdefined(entity.traveseheightoverride)) {
        return entity.traveseheightoverride;
    }
    if (isdefined(entity.traversemantlenode)) {
        pivotorigin = archetype_mocomps_utility::calculatepivotoriginfromedge(entity, entity.traversemantlenode, entity.origin);
        return (pivotorigin[2] - entity.origin[2]);
    } else if (isdefined(startposition) && isdefined(endposition)) {
        traversalheight = endposition[2] - startposition[2];
        if (bb_getparametrictraversaltype() == "jump_across_traversal") {
            traversalheight = abs(traversalheight);
        }
        return traversalheight;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x4
// Checksum 0xd5b2d352, Offset: 0x33c8
// Size: 0x9e
function private bb_gettraversalwidth() {
    entity = self;
    startposition = entity.traversalstartpos;
    endposition = entity.traversalendpos;
    if (isdefined(entity.travesewidthoverride)) {
        return entity.travesewidthoverride;
    }
    if (isdefined(startposition) && isdefined(endposition)) {
        return distance2d(startposition, endposition);
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xcf5f85d5, Offset: 0x3470
// Size: 0x1e2
function bb_getparametrictraversaltype() {
    entity = self;
    startposition = entity.traversalstartpos;
    endposition = entity.traversalendpos;
    if (isdefined(entity.travesetypeoverride)) {
        return entity.travesetypeoverride;
    }
    if (!isdefined(entity.traverseendnode) || !isdefined(entity.traversestartnode) || entity.traversestartnode.type != "Volume" || entity.traverseendnode.type != "Volume") {
        return "unknown_traversal";
    }
    if (isdefined(entity.traversestartnode) && isdefined(entity.traversemantlenode)) {
        return "mantle_traversal";
    }
    if (isdefined(startposition) && isdefined(endposition)) {
        traversaldistance = distance2d(startposition, endposition);
        isendpointaboveorsamelevel = startposition[2] <= endposition[2];
        if (isendpointaboveorsamelevel) {
            if (traversaldistance >= 128 && abs(endposition[2] - startposition[2]) <= 100) {
                return "jump_across_traversal";
            }
        }
        if (isendpointaboveorsamelevel) {
            return "jump_up_traversal";
        }
        return "jump_down_traversal";
    }
    return "unknown_traversal";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xa3751c53, Offset: 0x3660
// Size: 0x3a
function bb_getawareness() {
    if (!isdefined(self.stealth) || !isdefined(self.awarenesslevelcurrent)) {
        return "combat";
    }
    return self.awarenesslevelcurrent;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xf2afd217, Offset: 0x36a8
// Size: 0x3a
function bb_getawarenessprevious() {
    if (!isdefined(self.stealth) || !isdefined(self.awarenesslevelprevious)) {
        return "combat";
    }
    return self.awarenesslevelprevious;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x2e886d7e, Offset: 0x36f0
// Size: 0xa6
function function_f8ae4008() {
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
// Checksum 0xcf9896a1, Offset: 0x37a0
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
// Checksum 0xc55b737f, Offset: 0x3850
// Size: 0x114
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
// Checksum 0xae0d643c, Offset: 0x3970
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
// Checksum 0xd89468fa, Offset: 0x3a00
// Size: 0x96
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
// Checksum 0x44b158e9, Offset: 0x3aa0
// Size: 0x1a
function bb_getcurrentcovernodetype() {
    return getcovertype(self.node);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x8f1cc053, Offset: 0x3ac8
// Size: 0x2e
function bb_getcoverconcealed() {
    if (iscoverconcealed(self.node)) {
        return "concealed";
    }
    return "unconcealed";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xaa077afb, Offset: 0x3b00
// Size: 0x6a
function bb_getcurrentlocationcovernodetype() {
    if (isdefined(self.node) && distancesquared(self.origin, self.node.origin) < 48 * 48) {
        return bb_getcurrentcovernodetype();
    }
    return bb_getpreviouscovernodetype();
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xc3e5d213, Offset: 0x3b78
// Size: 0xfa
function bb_getdamagedirection() {
    /#
        if (isdefined(level._debug_damage_direction)) {
            return level._debug_damage_direction;
        }
    #/
    if (self.damageyaw > 135 || self.damageyaw <= -135) {
        self.damage_direction = "front";
        return "front";
    }
    if (self.damageyaw > 45 && self.damageyaw <= 135) {
        self.damage_direction = "right";
        return "right";
    }
    if (self.damageyaw > -45 && self.damageyaw <= 45) {
        self.damage_direction = "back";
        return "back";
    }
    self.damage_direction = "left";
    return "left";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x4f1b5ec4, Offset: 0x3c80
// Size: 0x362
function bb_actorgetdamagelocation() {
    /#
        if (isdefined(level._debug_damage_pain_location)) {
            return level._debug_damage_pain_location;
        }
    #/
    shitloc = self.damagelocation;
    possiblehitlocations = array();
    if (isdefined(shitloc) && shitloc != "none") {
        if (isinarray(array("helmet", "head", "neck"), shitloc)) {
            possiblehitlocations[possiblehitlocations.size] = "head";
        } else if (isinarray(array("torso_upper", "torso_mid"), shitloc)) {
            possiblehitlocations[possiblehitlocations.size] = "chest";
        } else if (isinarray(array("torso_lower"), shitloc)) {
            possiblehitlocations[possiblehitlocations.size] = "groin";
        } else if (isinarray(array("torso_lower"), shitloc)) {
            possiblehitlocations[possiblehitlocations.size] = "legs";
        } else if (isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
            possiblehitlocations[possiblehitlocations.size] = "left_arm";
        } else if (isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
            possiblehitlocations[possiblehitlocations.size] = "right_arm";
        } else if (isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc)) {
            possiblehitlocations[possiblehitlocations.size] = "legs";
        }
    }
    if (possiblehitlocations.size == 0) {
        possiblehitlocations[possiblehitlocations.size] = "chest";
        possiblehitlocations[possiblehitlocations.size] = "groin";
    }
    assert(possiblehitlocations.size > 0, possiblehitlocations.size);
    damagelocation = possiblehitlocations[randomint(possiblehitlocations.size)];
    return damagelocation;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x14c8f3aa, Offset: 0x3ff0
// Size: 0x18e
function bb_getdamageweaponclass() {
    if (isdefined(self.damagemod)) {
        if (isinarray(array("mod_rifle_bullet"), tolower(self.damagemod))) {
            return "rifle";
        }
        if (isinarray(array("mod_pistol_bullet"), tolower(self.damagemod))) {
            return "pistol";
        }
        if (isinarray(array("mod_melee", "mod_melee_assassinate", "mod_melee_weapon_butt"), tolower(self.damagemod))) {
            return "melee";
        }
        if (isinarray(array("mod_grenade", "mod_grenade_splash", "mod_projectile", "mod_projectile_splash", "mod_explosive"), tolower(self.damagemod))) {
            return "explosive";
        }
    }
    return "rifle";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x6e67f1f2, Offset: 0x4188
// Size: 0x82
function bb_getdamageweapon() {
    if (isdefined(self.special_weapon) && isdefined(self.special_weapon.name)) {
        return self.special_weapon.name;
    }
    if (isdefined(self.damageweapon) && isdefined(self.damageweapon.name)) {
        return self.damageweapon.name;
    }
    return "unknown";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xd9831190, Offset: 0x4218
// Size: 0x32
function bb_getdamagemod() {
    if (isdefined(self.damagemod)) {
        return tolower(self.damagemod);
    }
    return "unknown";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x54b8e154, Offset: 0x4258
// Size: 0x100
function bb_getdamagetaken() {
    /#
        if (isdefined(level._debug_damage_intensity)) {
            return level._debug_damage_intensity;
        }
    #/
    damagetaken = self.damagetaken;
    maxhealth = self.maxhealth;
    damagetakentype = "light";
    if (isalive(self)) {
        ratio = damagetaken / self.maxhealth;
        if (ratio > 0.7) {
            damagetakentype = "heavy";
        }
        self.lastdamagetime = gettime();
    } else {
        ratio = damagetaken / self.maxhealth;
        if (ratio > 0.7) {
            damagetakentype = "heavy";
        }
    }
    return damagetakentype;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x9a481e06, Offset: 0x4360
// Size: 0x32
function bb_getshouldturn() {
    if (isdefined(self.should_turn) && self.should_turn) {
        return "should_turn";
    }
    return "should_not_turn";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x6a259d56, Offset: 0x43a0
// Size: 0x32
function bb_idgungetdamagedirection() {
    if (isdefined(self.damage_direction)) {
        return self.damage_direction;
    }
    return self bb_getdamagedirection();
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x98386800, Offset: 0x43e0
// Size: 0x42
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
// Checksum 0xd06b69a5, Offset: 0x4430
// Size: 0x22
function bb_gethaslegsstatus() {
    if (self.missinglegs) {
        return "has_legs_no";
    }
    return "has_legs_yes";
}

// Namespace aiutility/archetype_utility
// Params 3, eflags: 0x0
// Checksum 0x2378e0a9, Offset: 0x4460
// Size: 0x2a6
function addaioverridedamagecallback(entity, callback, addtofront) {
    assert(isentity(entity));
    assert(isfunctionptr(callback));
    assert(!isdefined(entity.aioverridedamage) || isarray(entity.aioverridedamage));
    if (!isdefined(entity.aioverridedamage)) {
        entity.aioverridedamage = [];
    } else if (!isarray(entity.aioverridedamage)) {
        entity.aioverridedamage = array(entity.aioverridedamage);
    }
    if (isdefined(addtofront) && addtofront) {
        damageoverrides = [];
        damageoverrides[damageoverrides.size] = callback;
        foreach (override in entity.aioverridedamage) {
            damageoverrides[damageoverrides.size] = override;
        }
        entity.aioverridedamage = damageoverrides;
        return;
    }
    if (!isdefined(entity.aioverridedamage)) {
        entity.aioverridedamage = [];
    } else if (!isarray(entity.aioverridedamage)) {
        entity.aioverridedamage = array(entity.aioverridedamage);
    }
    entity.aioverridedamage[entity.aioverridedamage.size] = callback;
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0x8e273609, Offset: 0x4710
// Size: 0x178
function removeaioverridedamagecallback(entity, callback) {
    assert(isentity(entity));
    assert(isfunctionptr(callback));
    assert(isarray(entity.aioverridedamage));
    currentdamagecallbacks = entity.aioverridedamage;
    entity.aioverridedamage = [];
    foreach (value in currentdamagecallbacks) {
        if (value != callback) {
            entity.aioverridedamage[entity.aioverridedamage.size] = value;
        }
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xc13dba5, Offset: 0x4890
// Size: 0x1c
function clearaioverridedamagecallbacks(entity) {
    entity.aioverridedamage = [];
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0xe00f6ba6, Offset: 0x48b8
// Size: 0x156
function addaioverridekilledcallback(entity, callback) {
    assert(isentity(entity));
    assert(isfunctionptr(callback));
    assert(!isdefined(entity.aioverridekilled) || isarray(entity.aioverridekilled));
    if (!isdefined(entity.aioverridekilled)) {
        entity.aioverridekilled = [];
    } else if (!isarray(entity.aioverridekilled)) {
        entity.aioverridekilled = array(entity.aioverridekilled);
    }
    entity.aioverridekilled[entity.aioverridekilled.size] = callback;
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0xc0ef3961, Offset: 0x4a18
// Size: 0x1a0
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
// Checksum 0xa6946d91, Offset: 0x4bc0
// Size: 0x66
function bb_actorispatroling() {
    entity = self;
    if (entity ai::has_behavior_attribute("patrol") && entity ai::get_behavior_attribute("patrol")) {
        return "patrol_enabled";
    }
    return "patrol_disabled";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x8b65daa3, Offset: 0x4c30
// Size: 0x36
function bb_actorhasenemy() {
    entity = self;
    if (isdefined(entity.enemy)) {
        return "has_enemy";
    }
    return "no_enemy";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x34898821, Offset: 0x4c70
// Size: 0x54
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
// Checksum 0xa44f3eed, Offset: 0x4cd0
// Size: 0xd0
function bb_actorgetperfectenemyyaw() {
    enemy = self.enemy;
    if (!isdefined(enemy)) {
        return 0;
    }
    toenemyyaw = vectortoangles(enemy.origin - self.origin)[1] - self.angles[1];
    toenemyyaw = absangleclamp360(toenemyyaw);
    /#
        recordenttext("<dev string:x28>" + toenemyyaw, self, (1, 0, 0), "<dev string:x33>");
    #/
    return toenemyyaw;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x2c88e4a0, Offset: 0x4da8
// Size: 0x14c
function bb_actorgetreactyaw() {
    result = 0;
    if (isdefined(self.var_5ded47f6)) {
        result = self.var_5ded47f6;
        self.var_5ded47f6 = undefined;
    } else {
        v_origin = self geteventpointofinterest();
        if (isdefined(v_origin)) {
            str_typename = self getcurrenteventtypename();
            e_originator = self getcurrenteventoriginator();
            if (str_typename == "bullet" && isdefined(e_originator)) {
                v_origin = e_originator.origin;
            }
            deltaorigin = v_origin - self.origin;
            var_9d3fe635 = vectortoangles(deltaorigin);
            result = absangleclamp360(self.angles[1] - var_9d3fe635[1]);
        }
    }
    return result;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x485bfbe8, Offset: 0x4f00
// Size: 0x250
function bb_actorgetfataldamagelocation() {
    /#
        if (isdefined(level._debug_damage_location)) {
            return level._debug_damage_location;
        }
    #/
    shitloc = self.damagelocation;
    if (isdefined(shitloc)) {
        if (isinarray(array("helmet", "head", "neck"), shitloc)) {
            return "head";
        }
        if (isinarray(array("torso_upper", "torso_mid"), shitloc)) {
            return "chest";
        }
        if (isinarray(array("torso_lower"), shitloc)) {
            return "hips";
        }
        if (isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
            return "right_arm";
        }
        if (isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
            return "left_arm";
        }
        if (isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc)) {
            return "legs";
        }
    }
    randomlocs = array("chest", "hips");
    return randomlocs[randomint(randomlocs.size)];
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x9cdad5be, Offset: 0x5158
// Size: 0xca
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
// Checksum 0x72d3d6cc, Offset: 0x5230
// Size: 0x11c
function wasatcovernode() {
    if (isdefined(self.prevnode)) {
        if (self.prevnode.type == "Cover Crouch" || self.prevnode.type == "Cover Crouch Window" || self.prevnode.type == "Cover Stand" || self.prevnode.type == "Cover Left" || self.prevnode.type == "Cover Right" || self.prevnode.type == "Cover Pillar" || self.prevnode.type == "Conceal Stand" || self.prevnode.type == "Conceal Crouch") {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0x86e96a97, Offset: 0x5358
// Size: 0x530
function bb_getlocomotionexityaw(blackboard, yaw) {
    exityaw = undefined;
    if (self haspath()) {
        predictedlookaheadinfo = self predictexit();
        status = predictedlookaheadinfo["path_prediction_status"];
        if (!isdefined(self.pathgoalpos)) {
            return -1;
        }
        if (distancesquared(self.origin, self.pathgoalpos) <= 4096) {
            return -1;
        }
        if (status == 3) {
            start = self.origin;
            end = start + vectorscale((0, predictedlookaheadinfo["path_prediction_travel_vector"][1], 0), 100);
            angletoexit = vectortoangles(predictedlookaheadinfo["path_prediction_travel_vector"])[1];
            exityaw = absangleclamp360(angletoexit - self.prevnode.angles[1]);
        } else if (status == 4) {
            start = self.origin;
            end = start + vectorscale((0, predictedlookaheadinfo["path_prediction_travel_vector"][1], 0), 100);
            angletoexit = vectortoangles(predictedlookaheadinfo["path_prediction_travel_vector"])[1];
            exityaw = absangleclamp360(angletoexit - self.angles[1]);
        } else if (status == 0) {
            if (wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
                end = self.pathgoalpos;
                angletodestination = vectortoangles(end - self.origin)[1];
                angledifference = absangleclamp360(angletodestination - self.prevnode.angles[1]);
                return angledifference;
            }
            start = predictedlookaheadinfo["path_prediction_start_point"];
            end = start + predictedlookaheadinfo["path_prediction_travel_vector"];
            exityaw = getangleusingdirection(predictedlookaheadinfo["path_prediction_travel_vector"]);
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
            record3dtext("<dev string:x3e>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x33>", undefined, 0.4);
        }
    #/
    return exityaw;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x278204f9, Offset: 0x5890
// Size: 0x102
function bb_getlocomotionfaceenemyquadrant() {
    /#
        walkstring = getdvarstring("<dev string:x49>");
        switch (walkstring) {
        case #"right":
            return "<dev string:x65>";
        case #"left":
            return "<dev string:x86>";
        case #"back":
            return "<dev string:xa6>";
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
// Checksum 0x7b598549, Offset: 0x59a0
// Size: 0x292
function bb_getlocomotionpaintype() {
    if (self haspath()) {
        predictedlookaheadinfo = self predictpath();
        status = predictedlookaheadinfo["path_prediction_status"];
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
// Checksum 0xdebd9ace, Offset: 0x5c40
// Size: 0x42
function bb_getlookaheadangle() {
    return absangleclamp360(vectortoangles(self.lookaheaddir)[1] - self.angles[1]);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x2d8a933f, Offset: 0x5c90
// Size: 0x1a
function bb_getpreviouscovernodetype() {
    return getcovertype(self.prevnode);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xe430e5af, Offset: 0x5cb8
// Size: 0x18e
function bb_actorgettrackingturnyaw() {
    pixbeginevent("BB_ActorGetTrackingTurnYaw");
    if (isdefined(self.enemy)) {
        predictedpos = undefined;
        if (distance2dsquared(self.enemy.origin, self.origin) < 180 * 180) {
            predictedpos = self.enemy.origin;
            self.newenemyreaction = 0;
        } else if (!issentient(self.enemy) || self lastknowntime(self.enemy) + 5000 >= gettime()) {
            predictedpos = self lastknownpos(self.enemy);
        }
        if (isdefined(predictedpos)) {
            turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
            pixendevent();
            return turnyaw;
        }
    }
    pixendevent();
    return undefined;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xcb50271f, Offset: 0x5e50
// Size: 0xa
function bb_getweaponclass() {
    return "rifle";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x86a3847d, Offset: 0x5e68
// Size: 0x40
function notstandingcondition(behaviortreeentity) {
    if (behaviortreeentity getblackboardattribute("_stance") != "stand") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xbdf530fe, Offset: 0x5eb0
// Size: 0x40
function notcrouchingcondition(behaviortreeentity) {
    if (behaviortreeentity getblackboardattribute("_stance") != "crouch") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x1e8c3f89, Offset: 0x5ef8
// Size: 0x24
function scriptstartragdoll(behaviortreeentity) {
    behaviortreeentity startragdoll();
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0xa373a6fa, Offset: 0x5f28
// Size: 0x124
function private prepareforexposedmelee(behaviortreeentity) {
    keepclaimnode(behaviortreeentity);
    meleeacquiremutex(behaviortreeentity);
    currentstance = behaviortreeentity getblackboardattribute("_stance");
    if (isdefined(behaviortreeentity.enemy) && isdefined(behaviortreeentity.enemy.vehicletype) && issubstr(behaviortreeentity.enemy.vehicletype, "firefly")) {
        behaviortreeentity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
    }
    if (currentstance == "crouch") {
        behaviortreeentity setblackboardattribute("_desired_stance", "stand");
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x14cb54d1, Offset: 0x6058
// Size: 0x42
function isfrustrated(behaviortreeentity) {
    return isdefined(behaviortreeentity.ai.frustrationlevel) && behaviortreeentity.ai.frustrationlevel > 0;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x176210cf, Offset: 0x60a8
// Size: 0x38
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
// Checksum 0xf7f223a3, Offset: 0x60e8
// Size: 0x490
function updatefrustrationlevel(entity) {
    if (!entity isbadguy()) {
        return false;
    }
    if (!isdefined(entity.ai.frustrationlevel)) {
        entity.ai.frustrationlevel = 0;
    }
    if (!isdefined(entity.enemy)) {
        entity.ai.frustrationlevel = 0;
        return false;
    }
    /#
        record3dtext("<dev string:xc1>" + entity.ai.frustrationlevel, entity.origin, (1, 0.5, 0), "<dev string:x33>");
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
        isawareofenemy = gettime() - entity lastknowntime(entity.enemy) < 10000;
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
// Checksum 0x16a55688, Offset: 0x6580
// Size: 0x24
function flagenemyunattackableservice(behaviortreeentity) {
    behaviortreeentity flagenemyunattackable();
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x7ca93cd6, Offset: 0x65b0
// Size: 0xa6
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
// Checksum 0x72cf2e06, Offset: 0x6660
// Size: 0x114
function tryadvancingonlastknownpositionbehavior(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        if (isdefined(behaviortreeentity.ai.aggressivemode) && behaviortreeentity.ai.aggressivemode) {
            lastknownpositionofenemy = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
            if (behaviortreeentity isingoal(lastknownpositionofenemy) && behaviortreeentity findpath(behaviortreeentity.origin, lastknownpositionofenemy, 1, 0)) {
                behaviortreeentity useposition(lastknownpositionofenemy, lastknownpositionofenemy);
                setnextfindbestcovertime(behaviortreeentity, undefined);
                return true;
            }
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xc239c9bc, Offset: 0x6780
// Size: 0xf4
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
// Checksum 0x77eab788, Offset: 0x6880
// Size: 0x104
function tryrunningdirectlytoenemybehavior(behaviortreeentity) {
    if (isdefined(behaviortreeentity.ai.aggressivemode) && isdefined(behaviortreeentity.enemy) && behaviortreeentity.ai.aggressivemode) {
        origin = behaviortreeentity.enemy.origin;
        if (behaviortreeentity isingoal(origin) && behaviortreeentity findpath(behaviortreeentity.origin, origin, 1, 0)) {
            behaviortreeentity useposition(origin, origin);
            setnextfindbestcovertime(behaviortreeentity, undefined);
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xf0ffea74, Offset: 0x6990
// Size: 0x16
function shouldreacttonewenemy(behaviortreeentity) {
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x53821b79, Offset: 0x6a40
// Size: 0x2e
function hasweaponmalfunctioned(behaviortreeentity) {
    return isdefined(behaviortreeentity.malfunctionreaction) && behaviortreeentity.malfunctionreaction;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xa378873a, Offset: 0x6a78
// Size: 0x1a4
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
// Checksum 0x1d702020, Offset: 0x6c28
// Size: 0x24
function ingrenadeblastradius(entity) {
    return !entity issafefromgrenade();
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x3c0b8a1a, Offset: 0x6c58
// Size: 0x56
function recentlysawenemy(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy) && behaviortreeentity seerecently(behaviortreeentity.enemy, 6)) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x8ef29be4, Offset: 0x6cb8
// Size: 0x3a
function shouldonlyfireaccurately(behaviortreeentity) {
    if (isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xd9bf20f3, Offset: 0x6d00
// Size: 0x4a
function shouldbeaggressive(behaviortreeentity) {
    if (isdefined(behaviortreeentity.ai.aggressivemode) && behaviortreeentity.ai.aggressivemode) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0x4fae5b58, Offset: 0x6d58
// Size: 0xc4
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
// Checksum 0xdc448f37, Offset: 0x6e28
// Size: 0x58
function setnextfindbestcovertime(behaviortreeentity, node) {
    behaviortreeentity.nextfindbestcovertime = behaviortreeentity getnextfindbestcovertime(behaviortreeentity.engagemindist, behaviortreeentity.engagemaxdist, behaviortreeentity.coversearchinterval);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x23454619, Offset: 0x6e88
// Size: 0xaa
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
// Checksum 0x3f67eb00, Offset: 0x6f40
// Size: 0x6c
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
// Checksum 0x134f8265, Offset: 0x6fb8
// Size: 0x47a
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
        shouldlookforbettercover = !shouldusecovernoderesult || shouldbeboredatcurrentcover || !islookingaroundforenemy && !abouttoarriveatcover && !iswithineffectiverangealready && !self isatgoal();
        /#
            if (shouldlookforbettercover) {
                color = (0, 1, 0);
            } else {
                color = (1, 0, 0);
            }
            recordenttext("<dev string:xd3>" + shouldusecovernoderesult + "<dev string:xf1>" + islookingaroundforenemy + "<dev string:xf7>" + abouttoarriveatcover + "<dev string:xfd>" + iswithineffectiverangealready + "<dev string:x103>" + shouldbeboredatcurrentcover, behaviortreeentity, color, "<dev string:x33>");
        #/
    } else {
        return !(behaviortreeentity shouldusecovernode() && behaviortreeentity isapproachinggoal());
    }
    return shouldlookforbettercover;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x1a7c0ea2, Offset: 0x7440
// Size: 0x10e
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
// Checksum 0x9104b030, Offset: 0x7558
// Size: 0x1a6
function private choosebettercoverservice(behaviortreeentity) {
    shouldchoosebettercoverresult = shouldchoosebettercover(behaviortreeentity);
    if (shouldchoosebettercoverresult && !behaviortreeentity.keepclaimednode) {
        transitionrunning = behaviortreeentity asmistransitionrunning();
        substatepending = behaviortreeentity asmissubstatepending();
        transdecrunning = behaviortreeentity asmistransdecrunning();
        isbehaviortreeinrunningstate = behaviortreeentity getbehaviortreestatus() == 5;
        if (!transitionrunning && !substatepending && !transdecrunning && isbehaviortreeinrunningstate) {
            node = getbestcovernodeifavailable(behaviortreeentity);
            goingtodifferentnode = !isdefined(behaviortreeentity.node) || isdefined(node) && node != behaviortreeentity.node;
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
// Checksum 0x7eeaf796, Offset: 0x7708
// Size: 0x58
function refillammo(behaviortreeentity) {
    if (behaviortreeentity.weapon != level.weaponnone) {
        behaviortreeentity.ai.bulletsinclip = behaviortreeentity.weapon.clipsize;
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x3b27a43a, Offset: 0x7768
// Size: 0xbc
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
// Checksum 0x85f4ab98, Offset: 0x7830
// Size: 0x124
function getsecondbestcovernodeifavailable(behaviortreeentity) {
    if (isdefined(behaviortreeentity.fixednode) && behaviortreeentity.fixednode) {
        return undefined;
    }
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
// Checksum 0x86ed5cdd, Offset: 0x7960
// Size: 0x176
function getcovertype(node) {
    if (isdefined(node)) {
        if (node.type == "Cover Pillar") {
            return "cover_pillar";
        } else if (node.type == "Cover Left") {
            return "cover_left";
        } else if (node.type == "Cover Right") {
            return "cover_right";
        } else if (node.type == "Cover Stand" || node.type == "Conceal Stand") {
            return "cover_stand";
        } else if (node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch") {
            return "cover_crouch";
        } else if (node.type == "Exposed" || node.type == "Guard") {
            return "cover_exposed";
        }
    }
    return "cover_none";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x5cf2e03e, Offset: 0x7ae0
// Size: 0x4c
function iscoverconcealed(node) {
    if (isdefined(node)) {
        return (node.type == "Conceal Crouch" || node.type == "Conceal Stand");
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x34c35d0e, Offset: 0x7b38
// Size: 0x4cc
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
    if (node.type == "Cover Left" || node.type == "Cover Right") {
        if (yawtoenemy > 60 || yawtoenemy < -60) {
            return 0;
        }
        if (isdefined(node.spawnflags) && (node.spawnflags & 4) == 4) {
            if (node.type == "Cover Left" && yawtoenemy > 10) {
                return 0;
            }
            if (node.type == "Cover Right" && yawtoenemy < -10) {
                return 0;
            }
        }
    }
    nodeoffset = (0, 0, 0);
    if (node.type == "Cover Pillar") {
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
    if (node.type == "Cover Left") {
        nodeoffset = (-36, 7, 63);
    } else if (node.type == "Cover Right") {
        nodeoffset = (36, 7, 63);
    } else if (node.type == "Cover Stand" || node.type == "Conceal Stand") {
        nodeoffset = (-3.7, -22, 63);
    } else if (node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch") {
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
// Checksum 0x4b774522, Offset: 0x8010
// Size: 0xaa
function calculatenodeoffsetposition(node, nodeoffset) {
    right = anglestoright(node.angles);
    forward = anglestoforward(node.angles);
    return node.origin + vectorscale(right, nodeoffset[0]) + vectorscale(forward, nodeoffset[1]) + (0, 0, nodeoffset[2]);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xfaba6ee3, Offset: 0x80c8
// Size: 0x186
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
    errormsg(node.type + "<dev string:x109>" + node.origin + "<dev string:x112>");
    if (node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch") {
        return "crouch";
    }
    return "stand";
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0x65376108, Offset: 0x8258
// Size: 0x12e
function isstanceallowedatnode(stance, node) {
    assert(isdefined(stance));
    assert(isdefined(node));
    if (isdefined(node.spawnflags) && stance == "stand" && (node.spawnflags & 4) == 4) {
        return true;
    }
    if (isdefined(node.spawnflags) && stance == "crouch" && (node.spawnflags & 8) == 8) {
        return true;
    }
    if (isdefined(node.spawnflags) && stance == "prone" && (node.spawnflags & 16) == 16) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x1b90f14a, Offset: 0x8390
// Size: 0x6a
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
// Checksum 0x636a3711, Offset: 0x8408
// Size: 0x2e
function shouldstopmoving(behaviortreeentity) {
    if (behaviortreeentity shouldholdgroundagainstenemy()) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xf180e107, Offset: 0x8440
// Size: 0xa4
function setcurrentweapon(weapon) {
    self.weapon = weapon;
    self.weaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "<dev string:x127>" + weapon.name + "<dev string:x130>");
    }
    self.weaponmodel = weapon.worldmodel;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x5edccb6b, Offset: 0x84f0
// Size: 0x8c
function setprimaryweapon(weapon) {
    self.primaryweapon = weapon;
    self.primaryweaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "<dev string:x127>" + weapon.name + "<dev string:x130>");
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xa631dc1a, Offset: 0x8588
// Size: 0x8c
function setsecondaryweapon(weapon) {
    self.secondaryweapon = weapon;
    self.secondaryweaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "<dev string:x127>" + weapon.name + "<dev string:x130>");
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x177da72e, Offset: 0x8620
// Size: 0x24
function keepclaimnode(behaviortreeentity) {
    behaviortreeentity.keepclaimednode = 1;
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xcbc99eb7, Offset: 0x8650
// Size: 0x20
function releaseclaimnode(behaviortreeentity) {
    behaviortreeentity.keepclaimednode = 0;
    return true;
}

// Namespace aiutility/archetype_utility
// Params 3, eflags: 0x0
// Checksum 0x57580cd3, Offset: 0x8678
// Size: 0x8a
function getaimyawtoenemyfromnode(behaviortreeentity, node, enemy) {
    return angleclamp180(vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[1] - node.angles[1]);
}

// Namespace aiutility/archetype_utility
// Params 3, eflags: 0x0
// Checksum 0x14cdb645, Offset: 0x8710
// Size: 0x82
function getaimpitchtoenemyfromnode(behaviortreeentity, node, enemy) {
    return angleclamp180(vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[0] - node.angles[0]);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x1f3c2f96, Offset: 0x87a0
// Size: 0x84
function choosefrontcoverdirection(behaviortreeentity) {
    coverdirection = behaviortreeentity getblackboardattribute("_cover_direction");
    behaviortreeentity setblackboardattribute("_previous_cover_direction", coverdirection);
    behaviortreeentity setblackboardattribute("_cover_direction", "cover_front_direction");
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x673d517c, Offset: 0x8830
// Size: 0x1e6
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
// Checksum 0x4a7c8554, Offset: 0x8a20
// Size: 0x11e
function shouldstealth(behaviortreeentity) {
    if (isdefined(behaviortreeentity.stealth)) {
        now = gettime();
        if (behaviortreeentity isinscriptedstate()) {
            return false;
        }
        if (behaviortreeentity hasvalidinterrupt("react")) {
            behaviortreeentity.var_7c966299 = now;
            return true;
        }
        if (isdefined(behaviortreeentity.var_7c966299) && (isdefined(behaviortreeentity.stealth_reacting) && behaviortreeentity.stealth_reacting || now - behaviortreeentity.var_7c966299 < 250)) {
            return true;
        }
        if (behaviortreeentity ai::has_behavior_attribute("stealth") && behaviortreeentity ai::get_behavior_attribute("stealth")) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xd176ebd1, Offset: 0x8b48
// Size: 0x1ee
function locomotionshouldstealth(behaviortreeentity) {
    if (!shouldstealth(behaviortreeentity)) {
        return false;
    }
    if (behaviortreeentity haspath()) {
        if (isdefined(behaviortreeentity.arrivalfinalpos) || isdefined(behaviortreeentity.pathgoalpos)) {
            var_905ca688 = isdefined(self.currentgoal) && isdefined(self.currentgoal.script_wait_min) && isdefined(self.currentgoal.script_wait_max);
            if (var_905ca688) {
                var_905ca688 = self.currentgoal.script_wait_min > 0 || self.currentgoal.script_wait_max > 0;
            }
            if (isdefined(self.currentgoal) && (var_905ca688 || !isdefined(self.currentgoal) || isdefined(self.currentgoal.scriptbundlename))) {
                goalpos = undefined;
                if (isdefined(behaviortreeentity.arrivalfinalpos)) {
                    goalpos = behaviortreeentity.arrivalfinalpos;
                } else {
                    goalpos = behaviortreeentity.pathgoalpos;
                }
                goaldistsq = distancesquared(behaviortreeentity.origin, goalpos);
                if (goaldistsq <= 1936 && goaldistsq <= behaviortreeentity.goalradius * behaviortreeentity.goalradius) {
                    return false;
                }
            }
        }
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x37a36659, Offset: 0x8d40
// Size: 0x62
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
// Checksum 0x6816e6b8, Offset: 0x8db0
// Size: 0xac
function private stealthreactcondition(entity) {
    inscene = isdefined(self._o_scene) && isdefined(self._o_scene._str_state) && self._o_scene._str_state == "play";
    return !(isdefined(entity.stealth_reacting) && entity.stealth_reacting) && entity hasvalidinterrupt("react") && !inscene;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x8583d542, Offset: 0x8e68
// Size: 0x20
function private stealthreactstart(behaviortreeentity) {
    behaviortreeentity.stealth_reacting = 1;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x594fb876, Offset: 0x8e90
// Size: 0x1a
function private stealthreactterminate(behaviortreeentity) {
    behaviortreeentity.stealth_reacting = undefined;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x637e160, Offset: 0x8eb8
// Size: 0x60
function private stealthidleterminate(behaviortreeentity) {
    behaviortreeentity notify(#"stealthidleterminate");
    if (isdefined(behaviortreeentity.stealth_resume_after_idle) && behaviortreeentity.stealth_resume_after_idle) {
        behaviortreeentity.stealth_resume_after_idle = undefined;
        behaviortreeentity.stealth_resume = 1;
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xfdca8551, Offset: 0x8f20
// Size: 0x8e
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
// Params 1, eflags: 0x0
// Checksum 0x4b64808e, Offset: 0x8fb8
// Size: 0x40
function explosivekilled(behaviortreeentity) {
    if (behaviortreeentity getblackboardattribute("_damage_weapon_class") == "explosive") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0xff56edb5, Offset: 0x9000
// Size: 0x8c
function private _dropriotshield(riotshieldinfo) {
    entity = self;
    entity shared::throwweapon(riotshieldinfo.weapon, riotshieldinfo.tag, 0, 1);
    if (isdefined(entity)) {
        entity detach(riotshieldinfo.model, riotshieldinfo.tag);
    }
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0xd2bc8e7f, Offset: 0x9098
// Size: 0xb8
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
// Checksum 0xaf39db67, Offset: 0x9158
// Size: 0x64
function dropriotshield(behaviortreeentity) {
    if (isdefined(behaviortreeentity.riotshield)) {
        riotshieldinfo = behaviortreeentity.riotshield;
        behaviortreeentity.riotshield = undefined;
        behaviortreeentity thread _dropriotshield(riotshieldinfo);
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x2ae7c928, Offset: 0x91c8
// Size: 0x70
function electrifiedkilled(behaviortreeentity) {
    if (behaviortreeentity.damageweapon.rootweapon.name == "shotgun_pump_taser") {
        return true;
    }
    if (behaviortreeentity getblackboardattribute("_damage_mod") == "mod_electrocuted") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xe50202ef, Offset: 0x9240
// Size: 0x40
function burnedkilled(behaviortreeentity) {
    if (behaviortreeentity getblackboardattribute("_damage_mod") == "mod_burned") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x2be5ec78, Offset: 0x9288
// Size: 0x5c
function rapskilled(behaviortreeentity) {
    if (isdefined(self.attacker) && isdefined(self.attacker.archetype) && self.attacker.archetype == "raps") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x639fe825, Offset: 0x92f0
// Size: 0xb0
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
// Checksum 0xe508bb13, Offset: 0x93a8
// Size: 0xca
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
// Checksum 0xbdd2577f, Offset: 0x9480
// Size: 0xb6
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
// Checksum 0x5737c162, Offset: 0x9540
// Size: 0x22
function shouldnormalmelee(behaviortreeentity) {
    return hascloseenemytomelee(behaviortreeentity);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xe2ed0f7c, Offset: 0x9570
// Size: 0x320
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
// Checksum 0xcffc80e1, Offset: 0x9898
// Size: 0x2a
function hascloseenemytomelee(entity) {
    return hascloseenemytomeleewithrange(entity, 64 * 64);
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x0
// Checksum 0x5224d82d, Offset: 0x98d0
// Size: 0x1c4
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
// Checksum 0x31a7b29a, Offset: 0x9aa0
// Size: 0x224
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
// Checksum 0x760266db, Offset: 0x9cd0
// Size: 0xf6
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
// Checksum 0x521aec25, Offset: 0x9dd0
// Size: 0xc4
function private setupchargemeleeattack(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy) && isdefined(behaviortreeentity.enemy.vehicletype) && issubstr(behaviortreeentity.enemy.vehicletype, "firefly")) {
        behaviortreeentity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
    }
    meleeacquiremutex(behaviortreeentity);
    keepclaimnode(behaviortreeentity);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x254116d1, Offset: 0x9ea0
// Size: 0x5c
function private cleanupmelee(behaviortreeentity) {
    meleereleasemutex(behaviortreeentity);
    releaseclaimnode(behaviortreeentity);
    behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x6348be60, Offset: 0x9f08
// Size: 0xbc
function private cleanupchargemelee(behaviortreeentity) {
    behaviortreeentity.ai.nextchargemeleetime = gettime() + 2000;
    behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);
    meleereleasemutex(behaviortreeentity);
    releaseclaimnode(behaviortreeentity);
    behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.75, 1.5));
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xa4d381de, Offset: 0x9fd0
// Size: 0x9c
function cleanupchargemeleeattack(behaviortreeentity) {
    meleereleasemutex(behaviortreeentity);
    releaseclaimnode(behaviortreeentity);
    behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);
    behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.5, 1));
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0xb829fa39, Offset: 0xa078
// Size: 0x54
function private shouldchoosespecialpronepain(behaviortreeentity) {
    stance = behaviortreeentity getblackboardattribute("_stance");
    return stance == "prone_back" || stance == "prone_front";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x97514cba, Offset: 0xa0d8
// Size: 0x4c
function private shouldchoosespecialpain(behaviortreeentity) {
    if (isdefined(behaviortreeentity.damageweapon)) {
        return (behaviortreeentity.damageweapon.specialpain || isdefined(behaviortreeentity.special_weapon));
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x5d695a43, Offset: 0xa130
// Size: 0x3a
function private shouldchoosespecialdeath(behaviortreeentity) {
    if (isdefined(behaviortreeentity.damageweapon)) {
        return behaviortreeentity.damageweapon.specialpain;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x16642946, Offset: 0xa178
// Size: 0x54
function private shouldchoosespecialpronedeath(behaviortreeentity) {
    stance = behaviortreeentity getblackboardattribute("_stance");
    return stance == "prone_back" || stance == "prone_front";
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x4
// Checksum 0xb95bc6a, Offset: 0xa1d8
// Size: 0x48
function private setupexplosionanimscale(entity, asmstatename) {
    self.animtranslationscale = 2;
    self asmsetanimationrate(0.7);
    return 4;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x685f31, Offset: 0xa228
// Size: 0x284
function isbalconydeath(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.node)) {
        return false;
    }
    if (!(behaviortreeentity.node.spawnflags & 1024 || behaviortreeentity.node.spawnflags & 2048)) {
        return false;
    }
    covermode = behaviortreeentity getblackboardattribute("_cover_mode");
    if (covermode == "cover_alert" || covermode == "cover_mode_none") {
        return false;
    }
    if (isdefined(behaviortreeentity.node.script_balconydeathchance) && randomint(100) > int(100 * behaviortreeentity.node.script_balconydeathchance)) {
        return false;
    }
    distsq = distancesquared(behaviortreeentity.origin, behaviortreeentity.node.origin);
    if (distsq > 16 * 16) {
        return false;
    }
    if (isdefined(level.players) && level.players.size > 0) {
        closest_player = util::get_closest_player(behaviortreeentity.origin, level.players[0].team);
        if (isdefined(closest_player)) {
            if (abs(closest_player.origin[2] - behaviortreeentity.origin[2]) < 100) {
                var_9eabeb39 = distance2dsquared(closest_player.origin, behaviortreeentity.origin);
                if (var_9eabeb39 < 600 * 600) {
                    return false;
                }
            }
        }
    }
    self.b_balcony_death = 1;
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x8435e54e, Offset: 0xa4b8
// Size: 0xac
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
// Checksum 0x70cfd3ec, Offset: 0xa570
// Size: 0x2c
function usecurrentposition(entity) {
    entity useposition(entity.origin);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x3566d72c, Offset: 0xa5a8
// Size: 0x34
function isunarmed(behaviortreeentity) {
    if (behaviortreeentity.weapon == level.weaponnone) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x548c1594, Offset: 0xa5e8
// Size: 0x1b0
function preshootlaserandglinton(ai) {
    self endon(#"death");
    if (!isdefined(ai.laserstatus)) {
        ai.laserstatus = 0;
    }
    sniper_glint = "lensflares/fx_lensflare_sniper_glint";
    while (true) {
        self waittill("about_to_fire");
        if (ai.laserstatus !== 1) {
            ai laseron();
            ai.laserstatus = 1;
            if (ai.team != "allies") {
                tag = ai gettagorigin("tag_glint");
                if (isdefined(tag)) {
                    playfxontag(sniper_glint, ai, "tag_glint");
                    continue;
                }
                type = isdefined(ai.classname) ? "" + ai.classname : "";
                println("<dev string:x150>" + type + "<dev string:x154>");
                playfxontag(sniper_glint, ai, "tag_eye");
            }
        }
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xe0552791, Offset: 0xa7a0
// Size: 0x70
function postshootlaserandglintoff(ai) {
    self endon(#"death");
    while (true) {
        self waittill("stopped_firing");
        if (ai.laserstatus === 1) {
            ai laseroff();
            ai.laserstatus = 0;
        }
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x2fcd5048, Offset: 0xa818
// Size: 0x2a
function private isinphalanx(entity) {
    return entity ai::get_behavior_attribute("phalanx");
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x4
// Checksum 0x60c8823d, Offset: 0xa850
// Size: 0xa6
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
// Checksum 0x26cd9c87, Offset: 0xa900
// Size: 0xa6
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
// Params 1, eflags: 0x4
// Checksum 0x5420489, Offset: 0xa9b0
// Size: 0x10e
function private tookflashbangdamage(entity) {
    if (isdefined(entity.damageweapon) && isdefined(entity.damagemod)) {
        weapon = entity.damageweapon;
        return (issubstr(weapon.rootweapon.name, "flash_grenade") || issubstr(weapon.rootweapon.name, "concussion_grenade") || entity.damagemod == "MOD_GRENADE_SPLASH" && isdefined(weapon.rootweapon) && issubstr(weapon.rootweapon.name, "proximity_grenade"));
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xab4579de, Offset: 0xaac8
// Size: 0xd0
function isatattackobject(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.attackable.is_active) && isdefined(entity.attackable) && entity.attackable.is_active) {
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
// Checksum 0x4dade9bd, Offset: 0xaba0
// Size: 0xb2
function shouldattackobject(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.attackable.is_active) && isdefined(entity.attackable) && entity.attackable.is_active) {
        if (isdefined(entity.is_at_attackable) && entity.is_at_attackable) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0x5f2cef43, Offset: 0xac60
// Size: 0xaa
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
// Checksum 0xb0c6a024, Offset: 0xad18
// Size: 0x7e
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
// Checksum 0xe16cc526, Offset: 0xada0
// Size: 0x64
function phalanxattributecallback(entity, attribute, oldvalue, value) {
    if (value) {
        entity.ai.phalanx = 1;
        return;
    }
    entity.ai.phalanx = 0;
}

