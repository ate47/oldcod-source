#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai_shared;
#using scripts/core_common/math_shared;

#namespace aiutility;

// Namespace aiutility/archetype_cover_utility
// Params 0, eflags: 0x2
// Checksum 0xa745d9ef, Offset: 0x6e0
// Size: 0xd34
function autoexec registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&isatcrouchnode));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCrouchNode", &isatcrouchnode);
    assert(iscodefunctionptr(&btapi_isatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_isAtCoverCondition", &btapi_isatcovercondition);
    assert(isscriptfunctionptr(&isatcoverstrictcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCoverStrictCondition", &isatcoverstrictcondition);
    assert(isscriptfunctionptr(&isatcovermodeover));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCoverModeOver", &isatcovermodeover);
    assert(isscriptfunctionptr(&isatcovermodenone));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCoverModeNone", &isatcovermodenone);
    assert(isscriptfunctionptr(&isexposedatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isExposedAtCoverCondition", &isexposedatcovercondition);
    assert(isscriptfunctionptr(&keepclaimednodeandchoosecoverdirection));
    behaviortreenetworkutility::registerbehaviortreescriptapi("keepClaimedNodeAndChooseCoverDirection", &keepclaimednodeandchoosecoverdirection);
    assert(isscriptfunctionptr(&resetcoverparameters));
    behaviortreenetworkutility::registerbehaviortreescriptapi("resetCoverParameters", &resetcoverparameters);
    assert(isscriptfunctionptr(&cleanupcovermode));
    behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupCoverMode", &cleanupcovermode);
    assert(isscriptfunctionptr(&canbeflankedservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("canBeFlankedService", &canbeflankedservice);
    assert(isscriptfunctionptr(&shouldcoveridleonly));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldCoverIdleOnly", &shouldcoveridleonly);
    assert(isscriptfunctionptr(&issuppressedatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isSuppressedAtCoverCondition", &issuppressedatcovercondition);
    assert(isscriptfunctionptr(&coveridleinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverIdleInitialize", &coveridleinitialize);
    assert(iscodefunctionptr(&btapi_coveridleupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("btapi_coverIdleUpdate", &btapi_coveridleupdate);
    assert(isscriptfunctionptr(&coveridleupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverIdleUpdate", &coveridleupdate);
    assert(isscriptfunctionptr(&coveridleterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverIdleTerminate", &coveridleterminate);
    assert(isscriptfunctionptr(&shouldleanatcoveridlecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldLeanAtCoverIdleCondition", &shouldleanatcoveridlecondition);
    assert(isscriptfunctionptr(&continueleaningatcoveridlecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("continueLeaningAtCoverIdleCondition", &continueleaningatcoveridlecondition, 5);
    assert(isscriptfunctionptr(&isflankedbyenemyatcover));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isFlankedByEnemyAtCover", &isflankedbyenemyatcover);
    assert(isscriptfunctionptr(&coverflankedinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverFlankedActionStart", &coverflankedinitialize);
    assert(isscriptfunctionptr(&coverflankedactionterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverFlankedActionTerminate", &coverflankedactionterminate);
    assert(isscriptfunctionptr(&supportsovercovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("supportsOverCoverCondition", &supportsovercovercondition);
    assert(isscriptfunctionptr(&shouldoveratcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldOverAtCoverCondition", &shouldoveratcovercondition);
    assert(isscriptfunctionptr(&coveroverinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverOverInitialize", &coveroverinitialize);
    assert(isscriptfunctionptr(&coveroverterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverOverTerminate", &coveroverterminate);
    assert(isscriptfunctionptr(&supportsleancovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("supportsLeanCoverCondition", &supportsleancovercondition);
    assert(isscriptfunctionptr(&shouldleanatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldLeanAtCoverCondition", &shouldleanatcovercondition);
    assert(isscriptfunctionptr(&continueleaningatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("continueLeaningAtCoverCondition", &continueleaningatcovercondition, 1);
    assert(isscriptfunctionptr(&coverleaninitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverLeanInitialize", &coverleaninitialize);
    assert(isscriptfunctionptr(&coverleanterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverLeanTerminate", &coverleanterminate);
    assert(isscriptfunctionptr(&supportspeekcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("supportsPeekCoverCondition", &supportspeekcovercondition);
    assert(isscriptfunctionptr(&coverpeekinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverPeekInitialize", &coverpeekinitialize);
    assert(isscriptfunctionptr(&coverpeekterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverPeekTerminate", &coverpeekterminate);
    assert(isscriptfunctionptr(&coverreloadinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverReloadInitialize", &coverreloadinitialize);
    assert(isscriptfunctionptr(&refillammoandcleanupcovermode));
    behaviortreenetworkutility::registerbehaviortreescriptapi("refillAmmoAndCleanupCoverMode", &refillammoandcleanupcovermode);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x60225845, Offset: 0x1420
// Size: 0x4c
function private coverreloadinitialize(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_cover_mode", "cover_alert");
    keepclaimnode(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x20d870cf, Offset: 0x1478
// Size: 0x54
function refillammoandcleanupcovermode(behaviortreeentity) {
    if (isalive(behaviortreeentity)) {
        refillammo(behaviortreeentity);
    }
    cleanupcovermode(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x97a10c02, Offset: 0x14d8
// Size: 0x1c
function private supportspeekcovercondition(behaviortreeentity) {
    return isdefined(behaviortreeentity.node);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xf3642879, Offset: 0x1500
// Size: 0x64
function private coverpeekinitialize(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_cover_mode", "cover_alert");
    keepclaimnode(behaviortreeentity);
    choosecoverdirection(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x25eb481e, Offset: 0x1570
// Size: 0x3c
function private coverpeekterminate(behaviortreeentity) {
    choosefrontcoverdirection(behaviortreeentity);
    cleanupcovermode(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x58a42b08, Offset: 0x15b8
// Size: 0x124
function private supportsleancovercondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.node)) {
        if (behaviortreeentity.node.type == "Cover Left" || behaviortreeentity.node.type == "Cover Right") {
            return true;
        } else if (behaviortreeentity.node.type == "Cover Pillar") {
            if (!(isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024) || !(isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x6b47c9af, Offset: 0x16e8
// Size: 0x340
function private shouldleanatcovercondition(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.node) || !isdefined(behaviortreeentity.node.type) || !isdefined(behaviortreeentity.enemy) || !isdefined(behaviortreeentity.enemy.origin)) {
        return 0;
    }
    yawtoenemyposition = getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
    legalaimyaw = 0;
    if (behaviortreeentity.node.type == "Cover Left") {
        aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover_left_lean");
        legalaimyaw = yawtoenemyposition <= aimlimitsforcover["aim_left"] + 10 && yawtoenemyposition >= -10;
    } else if (behaviortreeentity.node.type == "Cover Right") {
        aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover_right_lean");
        legalaimyaw = yawtoenemyposition >= aimlimitsforcover["aim_right"] - 10 && yawtoenemyposition <= 10;
    } else if (behaviortreeentity.node.type == "Cover Pillar") {
        aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover");
        supportsleft = !(isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024);
        supportsright = !(isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048);
        angleleeway = 10;
        if (supportsright && supportsleft) {
            angleleeway = 0;
        }
        if (supportsleft) {
            legalaimyaw = yawtoenemyposition <= aimlimitsforcover["aim_left"] + 10 && yawtoenemyposition >= angleleeway * -1;
        }
        if (!legalaimyaw && supportsright) {
            legalaimyaw = yawtoenemyposition >= aimlimitsforcover["aim_right"] - 10 && yawtoenemyposition <= angleleeway;
        }
    }
    return legalaimyaw;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x82a775cf, Offset: 0x1a30
// Size: 0x42
function private continueleaningatcovercondition(behaviortreeentity) {
    if (behaviortreeentity asmistransitionrunning()) {
        return 1;
    }
    return shouldleanatcovercondition(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x5577435a, Offset: 0x1a80
// Size: 0x3d0
function private shouldleanatcoveridlecondition(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.node) || !isdefined(behaviortreeentity.node.type)) {
        return 0;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        yawtoenemyposition = getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
    } else {
        pos = behaviortreeentity.node.origin + 250 * behaviortreeentity.node.angles;
        yawtoenemyposition = angleclamp180(vectortoangles(pos - behaviortreeentity.node.origin)[1] - behaviortreeentity.node.angles[1]);
    }
    legalaimyaw = 0;
    if (behaviortreeentity.node.type == "Cover Left") {
        aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover_left_lean");
        legalaimyaw = yawtoenemyposition <= aimlimitsforcover["aim_left"] + 10 && yawtoenemyposition >= -10;
    } else if (behaviortreeentity.node.type == "Cover Right") {
        aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover_right_lean");
        legalaimyaw = yawtoenemyposition >= aimlimitsforcover["aim_right"] - 10 && yawtoenemyposition <= 10;
    } else if (behaviortreeentity.node.type == "Cover Pillar") {
        aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover");
        supportsleft = !(isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024);
        supportsright = !(isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048);
        angleleeway = 10;
        if (supportsright && supportsleft) {
            angleleeway = 0;
        }
        if (supportsleft) {
            legalaimyaw = yawtoenemyposition <= aimlimitsforcover["aim_left"] + 10 && yawtoenemyposition >= angleleeway * -1;
        }
        if (!legalaimyaw && supportsright) {
            legalaimyaw = yawtoenemyposition >= aimlimitsforcover["aim_right"] - 10 && yawtoenemyposition <= angleleeway;
        }
    }
    return legalaimyaw;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xc233ee09, Offset: 0x1e58
// Size: 0x42
function private continueleaningatcoveridlecondition(behaviortreeentity) {
    if (behaviortreeentity asmistransitionrunning()) {
        return 1;
    }
    return shouldleanatcoveridlecondition(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x70635a30, Offset: 0x1ea8
// Size: 0x7c
function private coverleaninitialize(behaviortreeentity) {
    setcovershootstarttime(behaviortreeentity);
    keepclaimnode(behaviortreeentity);
    behaviortreeentity setblackboardattribute("_cover_mode", "cover_lean");
    choosecoverdirection(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xf9f5db28, Offset: 0x1f30
// Size: 0x54
function private coverleanterminate(behaviortreeentity) {
    choosefrontcoverdirection(behaviortreeentity);
    cleanupcovermode(behaviortreeentity);
    clearcovershootstarttime(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xe634eba, Offset: 0x1f90
// Size: 0x1b4
function private supportsovercovercondition(behaviortreeentity) {
    stance = behaviortreeentity getblackboardattribute("_stance");
    if (isdefined(behaviortreeentity.node)) {
        if (!isinarray(getvalidcoverpeekouts(behaviortreeentity.node), "over")) {
            return false;
        }
        if (behaviortreeentity.node.type == "Cover Crouch" || behaviortreeentity.node.type == "Cover Crouch Window" || behaviortreeentity.node.type == "Cover Left" || behaviortreeentity.node.type == "Cover Right" || behaviortreeentity.node.type == "Conceal Crouch") {
            if (stance == "crouch") {
                return true;
            }
        } else if (behaviortreeentity.node.type == "Cover Stand" || behaviortreeentity.node.type == "Conceal Stand") {
            if (stance == "stand") {
                return true;
            }
        }
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x65c0760f, Offset: 0x2150
// Size: 0x1f2
function private shouldoveratcovercondition(entity) {
    if (!isdefined(entity.node) || !isdefined(entity.node.type) || !isdefined(entity.enemy) || !isdefined(entity.enemy.origin)) {
        return false;
    }
    aimtable = iscoverconcealed(entity.node) ? "cover_concealed_over" : "cover_over";
    aimlimitsforcover = entity getaimlimitsfromentry(aimtable);
    yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
    legalaimyaw = yawtoenemyposition >= aimlimitsforcover["aim_right"] - 10 && yawtoenemyposition <= aimlimitsforcover["aim_left"] + 10;
    if (!legalaimyaw) {
        return false;
    }
    pitchtoenemyposition = getaimpitchtoenemyfromnode(entity, entity.node, entity.enemy);
    legalaimpitch = pitchtoenemyposition >= aimlimitsforcover["aim_up"] + 10 && pitchtoenemyposition <= aimlimitsforcover["aim_down"] + 10;
    if (!legalaimpitch) {
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x65b4f38f, Offset: 0x2350
// Size: 0x64
function private coveroverinitialize(behaviortreeentity) {
    setcovershootstarttime(behaviortreeentity);
    keepclaimnode(behaviortreeentity);
    behaviortreeentity setblackboardattribute("_cover_mode", "cover_over");
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x80402f84, Offset: 0x23c0
// Size: 0x3c
function private coveroverterminate(behaviortreeentity) {
    cleanupcovermode(behaviortreeentity);
    clearcovershootstarttime(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xc622a442, Offset: 0x2408
// Size: 0x4c
function private coveridleinitialize(behaviortreeentity) {
    keepclaimnode(behaviortreeentity);
    behaviortreeentity setblackboardattribute("_cover_mode", "cover_alert");
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xa809d6d, Offset: 0x2460
// Size: 0x3c
function private coveridleupdate(behaviortreeentity) {
    if (!behaviortreeentity asmistransitionrunning()) {
        releaseclaimnode(behaviortreeentity);
    }
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xf5b102f, Offset: 0x24a8
// Size: 0x3c
function private coveridleterminate(behaviortreeentity) {
    releaseclaimnode(behaviortreeentity);
    cleanupcovermode(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x4b0bcfe4, Offset: 0x24f0
// Size: 0x6c
function private isflankedbyenemyatcover(behaviortreeentity) {
    return canbeflanked(behaviortreeentity) && behaviortreeentity isatcovernodestrict() && behaviortreeentity isflankedatcovernode() && !behaviortreeentity haspath();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x4daefcde, Offset: 0x2568
// Size: 0x24
function private canbeflankedservice(behaviortreeentity) {
    setcanbeflanked(behaviortreeentity, 1);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xaeea5742, Offset: 0x2598
// Size: 0xd4
function private coverflankedinitialize(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        behaviortreeentity getperfectinfo(behaviortreeentity.enemy);
        behaviortreeentity pathmode("move delayed", 0, 2);
    }
    setcanbeflanked(behaviortreeentity, 0);
    cleanupcovermode(behaviortreeentity);
    keepclaimnode(behaviortreeentity);
    behaviortreeentity setblackboardattribute("_desired_stance", "stand");
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x5a0bb999, Offset: 0x2678
// Size: 0x34
function private coverflankedactionterminate(behaviortreeentity) {
    behaviortreeentity.newenemyreaction = 0;
    releaseclaimnode(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x2913f2b4, Offset: 0x26b8
// Size: 0x11e
function isatcrouchnode(behaviortreeentity) {
    if (behaviortreeentity.node.type == "Exposed" || behaviortreeentity.node.type == "Guard" || isdefined(behaviortreeentity.node) && behaviortreeentity.node.type == "Path") {
        if (distancesquared(behaviortreeentity.origin, behaviortreeentity.node.origin) <= 24 * 24) {
            return (!isstanceallowedatnode("stand", behaviortreeentity.node) && isstanceallowedatnode("crouch", behaviortreeentity.node));
        }
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xc39c1b85, Offset: 0x27e0
// Size: 0x3c
function isatcoverstrictcondition(behaviortreeentity) {
    return behaviortreeentity isatcovernodestrict() && !behaviortreeentity haspath();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xa8453fb6, Offset: 0x2828
// Size: 0x44
function isatcovermodeover(behaviortreeentity) {
    covermode = behaviortreeentity getblackboardattribute("_cover_mode");
    return covermode == "cover_over";
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x7e288ba, Offset: 0x2878
// Size: 0x44
function isatcovermodenone(behaviortreeentity) {
    covermode = behaviortreeentity getblackboardattribute("_cover_mode");
    return covermode == "cover_mode_none";
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x54e8d813, Offset: 0x28c8
// Size: 0x3c
function isexposedatcovercondition(behaviortreeentity) {
    return behaviortreeentity isatcovernodestrict() && !behaviortreeentity shouldusecovernode();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xef663f10, Offset: 0x2910
// Size: 0x72
function shouldcoveridleonly(behaviortreeentity) {
    if (behaviortreeentity ai::get_behavior_attribute("coverIdleOnly")) {
        return true;
    }
    if (isdefined(behaviortreeentity.node.script_onlyidle) && behaviortreeentity.node.script_onlyidle) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xed17f240, Offset: 0x2990
// Size: 0x28
function issuppressedatcovercondition(behaviortreeentity) {
    return behaviortreeentity.suppressionmeter > behaviortreeentity.suppressionthreshold;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x759a7d0c, Offset: 0x29c0
// Size: 0x3c
function keepclaimednodeandchoosecoverdirection(behaviortreeentity) {
    keepclaimnode(behaviortreeentity);
    choosecoverdirection(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x989efea8, Offset: 0x2a08
// Size: 0x54
function resetcoverparameters(behaviortreeentity) {
    choosefrontcoverdirection(behaviortreeentity);
    cleanupcovermode(behaviortreeentity);
    clearcovershootstarttime(behaviortreeentity);
}

// Namespace aiutility/archetype_cover_utility
// Params 2, eflags: 0x0
// Checksum 0x8208afdf, Offset: 0x2a68
// Size: 0xac
function choosecoverdirection(behaviortreeentity, stepout) {
    if (!isdefined(behaviortreeentity.node)) {
        return;
    }
    coverdirection = behaviortreeentity getblackboardattribute("_cover_direction");
    behaviortreeentity setblackboardattribute("_previous_cover_direction", coverdirection);
    behaviortreeentity setblackboardattribute("_cover_direction", calculatecoverdirection(behaviortreeentity, stepout));
}

// Namespace aiutility/archetype_cover_utility
// Params 2, eflags: 0x0
// Checksum 0x9b41711, Offset: 0x2b20
// Size: 0x494
function calculatecoverdirection(behaviortreeentity, stepout) {
    if (isdefined(behaviortreeentity.treatallcoversasgeneric)) {
        if (!isdefined(stepout)) {
            stepout = 0;
        }
        coverdirection = "cover_front_direction";
        if (behaviortreeentity.node.type == "Cover Left") {
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 4) == 4 || math::cointoss() || stepout) {
                coverdirection = "cover_left_direction";
            }
        } else if (behaviortreeentity.node.type == "Cover Right") {
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 4) == 4 || math::cointoss() || stepout) {
                coverdirection = "cover_right_direction";
            }
        } else if (behaviortreeentity.node.type == "Cover Pillar") {
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024) {
                return "cover_right_direction";
            }
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048) {
                return "cover_left_direction";
            }
            coverdirection = "cover_left_direction";
            if (isdefined(behaviortreeentity.enemy)) {
                yawtoenemyposition = getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
                aimlimitsfordirectionright = behaviortreeentity getaimlimitsfromentry("pillar_right_lean");
                legalrightdirectionyaw = yawtoenemyposition >= aimlimitsfordirectionright["aim_right"] - 10 && yawtoenemyposition <= 0;
                if (legalrightdirectionyaw) {
                    coverdirection = "cover_right_direction";
                }
            }
        }
        return coverdirection;
    } else {
        coverdirection = "cover_front_direction";
        if (behaviortreeentity.node.type == "Cover Pillar") {
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024) {
                return "cover_right_direction";
            }
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048) {
                return "cover_left_direction";
            }
            coverdirection = "cover_left_direction";
            if (isdefined(behaviortreeentity.enemy)) {
                yawtoenemyposition = getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
                aimlimitsfordirectionright = behaviortreeentity getaimlimitsfromentry("pillar_right_lean");
                legalrightdirectionyaw = yawtoenemyposition >= aimlimitsfordirectionright["aim_right"] - 10 && yawtoenemyposition <= 0;
                if (legalrightdirectionyaw) {
                    coverdirection = "cover_right_direction";
                }
            }
        }
    }
    return coverdirection;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xe875ee9f, Offset: 0x2fc0
// Size: 0x1a
function clearcovershootstarttime(behaviortreeentity) {
    behaviortreeentity.covershootstarttime = undefined;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x308d218c, Offset: 0x2fe8
// Size: 0x1c
function setcovershootstarttime(behaviortreeentity) {
    behaviortreeentity.covershootstarttime = gettime();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x3a9473bb, Offset: 0x3010
// Size: 0x2e
function canbeflanked(behaviortreeentity) {
    return isdefined(behaviortreeentity.canbeflanked) && behaviortreeentity.canbeflanked;
}

// Namespace aiutility/archetype_cover_utility
// Params 2, eflags: 0x0
// Checksum 0x7352ea09, Offset: 0x3048
// Size: 0x28
function setcanbeflanked(behaviortreeentity, canbeflanked) {
    behaviortreeentity.canbeflanked = canbeflanked;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xf855022, Offset: 0x3078
// Size: 0xec
function cleanupcovermode(behaviortreeentity) {
    if (btapi_isatcovercondition(behaviortreeentity)) {
        covermode = behaviortreeentity getblackboardattribute("_cover_mode");
        behaviortreeentity setblackboardattribute("_previous_cover_mode", covermode);
        behaviortreeentity setblackboardattribute("_cover_mode", "cover_mode_none");
        return;
    }
    behaviortreeentity setblackboardattribute("_previous_cover_mode", "cover_mode_none");
    behaviortreeentity setblackboardattribute("_cover_mode", "cover_mode_none");
}

