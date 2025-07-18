#using scripts\core_common\ai\archetype_human_cover;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;

#namespace aiutility;

// Namespace aiutility/archetype_cover_utility
// Params 0, eflags: 0x2
// Checksum 0x107e1e74, Offset: 0x280
// Size: 0x10bc
function autoexec registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&isatcrouchnode));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcrouchnode", &isatcrouchnode);
    assert(isscriptfunctionptr(&function_1d3ee45b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5f2632e56b895b62", &function_1d3ee45b);
    assert(isscriptfunctionptr(&function_3fe92ec8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6139d3f7c5a6dcb4", &function_3fe92ec8);
    assert(iscodefunctionptr(&btapi_isatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_isatcovercondition", &btapi_isatcovercondition);
    assert(isscriptfunctionptr(&function_94bbbfa3));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_42946f41bb05517f", &function_94bbbfa3);
    assert(isscriptfunctionptr(&function_b7e28483));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3efb15f0f79edb81", &function_b7e28483);
    assert(isscriptfunctionptr(&isatcoverstrictcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcoverstrictcondition", &isatcoverstrictcondition);
    assert(isscriptfunctionptr(&isatcovermodeover));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcovermodeover", &isatcovermodeover);
    assert(isscriptfunctionptr(&isatcovermodenone));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcovermodenone", &isatcovermodenone);
    assert(isscriptfunctionptr(&function_d18f7e29));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6f3930f6d8ab6bea", &function_d18f7e29);
    assert(isscriptfunctionptr(&keepclaimednodeandchoosecoverdirection));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"keepclaimednodeandchoosecoverdirection", &keepclaimednodeandchoosecoverdirection);
    assert(isscriptfunctionptr(&resetcoverparameters));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"resetcoverparameters", &resetcoverparameters);
    assert(isscriptfunctionptr(&cleanupcovermode));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupcovermode", &cleanupcovermode);
    assert(isscriptfunctionptr(&shouldcoveridleonly));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldcoveridleonly", &shouldcoveridleonly);
    assert(isscriptfunctionptr(&issuppressedatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"issuppressedatcovercondition", &issuppressedatcovercondition);
    assert(isscriptfunctionptr(&function_5d963944));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_60d82d9556b0acbd", &function_5d963944);
    assert(isscriptfunctionptr(&function_af89626a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_18e7de5d241af663", &function_af89626a);
    assert(isscriptfunctionptr(&coveridleinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveridleinitialize", &coveridleinitialize);
    assert(iscodefunctionptr(&btapi_coveridleupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_coveridleupdate", &btapi_coveridleupdate);
    assert(isscriptfunctionptr(&coveridleterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveridleterminate", &coveridleterminate);
    assert(isscriptfunctionptr(&supportsovercovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportsovercovercondition", &supportsovercovercondition);
    assert(isscriptfunctionptr(&shouldoveratcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldoveratcovercondition", &shouldoveratcovercondition);
    assert(isscriptfunctionptr(&function_74e272f2));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2fd631156a51cc06", &function_74e272f2);
    assert(isscriptfunctionptr(&function_2b201dbe));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_66501b5b5629a24f", &function_2b201dbe, 1);
    assert(isscriptfunctionptr(&coveroverinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveroverinitialize", &coveroverinitialize);
    assert(isscriptfunctionptr(&function_2f4d2a0a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_194073d411274903", &function_2f4d2a0a);
    assert(isscriptfunctionptr(&coveroverterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveroverterminate", &coveroverterminate);
    assert(isscriptfunctionptr(&function_b605a3b2));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_58ddf57d938c96a6", &function_b605a3b2);
    assert(isscriptfunctionptr(&supportsleancovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportsleancovercondition", &supportsleancovercondition);
    assert(isscriptfunctionptr(&shouldleanatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldleanatcovercondition", &shouldleanatcovercondition);
    assert(isscriptfunctionptr(&function_5d1688a6));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3bcae642a03335e8", &function_5d1688a6);
    assert(isscriptfunctionptr(&continueleaningatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"continueleaningatcovercondition", &continueleaningatcovercondition, 1);
    assert(isscriptfunctionptr(&coverleaninitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverleaninitialize", &coverleaninitialize);
    assert(isscriptfunctionptr(&function_bbe42083));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4d634385ba6c9d69", &function_bbe42083);
    assert(isscriptfunctionptr(&coverleanterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverleanterminate", &coverleanterminate);
    assert(isscriptfunctionptr(&function_9e5575be));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72e14fa3a8f112e4", &function_9e5575be);
    assert(isscriptfunctionptr(&supportspeekcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportspeekcovercondition", &supportspeekcovercondition);
    assert(isscriptfunctionptr(&coverpeekinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverpeekinitialize", &coverpeekinitialize);
    assert(isscriptfunctionptr(&coverpeekterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverpeekterminate", &coverpeekterminate);
    assert(isscriptfunctionptr(&coverreloadinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverreloadinitialize", &coverreloadinitialize);
    assert(isscriptfunctionptr(&function_6c5a8f1e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_52e41eb7d054eea4", &function_6c5a8f1e);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x58d1441a, Offset: 0x1348
// Size: 0x64
function private coverreloadinitialize(entity) {
    entity setblackboardattribute("_cover_mode", "cover_alert");
    keepclaimnode(entity);
    function_43a090a8(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x6fb963e, Offset: 0x13b8
// Size: 0x6c
function private function_6c5a8f1e(entity) {
    if (isalive(entity)) {
        function_dc44803c(entity);
    }
    releaseclaimnode(entity);
    cleanupcovermode(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xfa9dae94, Offset: 0x1430
// Size: 0x3c
function private supportspeekcovercondition(entity) {
    if (entity ai::get_behavior_attribute("disablepeek")) {
        return false;
    }
    return isdefined(entity.node);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x47240cc0, Offset: 0x1478
// Size: 0x64
function private coverpeekinitialize(entity) {
    entity setblackboardattribute("_cover_mode", "cover_alert");
    keepclaimnode(entity);
    choosecoverdirection(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x38b922ba, Offset: 0x14e8
// Size: 0x46
function private coverpeekterminate(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    entity.var_fcadfdcd = gettime();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xb89b0a35, Offset: 0x1538
// Size: 0x144
function private supportsleancovercondition(entity) {
    if (entity ai::get_behavior_attribute("disablelean")) {
        return false;
    }
    if (isdefined(entity.node)) {
        if (entity.node.type == #"cover left" || entity.node.type == #"cover right") {
            return true;
        } else if (entity.node.type == #"cover pillar") {
            if (!(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024) || !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x711c693f, Offset: 0x1688
// Size: 0x312
function private shouldleanatcovercondition(entity) {
    if (!isdefined(entity.node) || !isdefined(entity.node.type) || !isdefined(entity.enemy) || !isdefined(entity.enemy.origin)) {
        return 0;
    }
    legalaim = 0;
    if (entity.node.type == #"cover left") {
        if (!(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 4) == 4)) {
            legalaim = function_cfe04a8d(entity, "cover_left_crouch_lean");
        } else {
            legalaim = function_cfe04a8d(entity, "cover_left_lean");
        }
    } else if (entity.node.type == #"cover right") {
        if (!(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 4) == 4)) {
            legalaim = function_cfe04a8d(entity, "cover_right_crouch_lean");
        } else {
            legalaim = function_cfe04a8d(entity, "cover_right_lean");
        }
    } else if (entity.node.type == #"cover pillar") {
        supportsleft = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024);
        supportsright = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048);
        angleleeway = 10;
        if (supportsright && supportsleft) {
            angleleeway = 0;
        }
        if (!legalaim && supportsleft) {
            legalaim = function_cfe04a8d(entity, "pillar_left_lean", undefined, angleleeway);
        }
        if (!legalaim && supportsright) {
            legalaim = function_cfe04a8d(entity, "pillar_right_lean", angleleeway, undefined);
        }
    }
    return legalaim;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x7217a4c0, Offset: 0x19a8
// Size: 0x46
function private function_5d1688a6(entity) {
    if (!supportsleancovercondition(entity)) {
        return false;
    }
    if (!shouldleanatcovercondition(entity)) {
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xe4a7c38f, Offset: 0x19f8
// Size: 0x42
function private continueleaningatcovercondition(entity) {
    if (entity asmistransitionrunning()) {
        return 1;
    }
    return shouldleanatcovercondition(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x2db842f9, Offset: 0x1a48
// Size: 0xae
function private coverleaninitialize(entity) {
    setcovershootstarttime(entity);
    thread function_4ec57157(entity);
    keepclaimnode(entity);
    entity setblackboardattribute("_cover_mode", "cover_lean");
    choosecoverdirection(entity);
    entity.var_1a0b2452 = 0;
    entity.var_a4f84a7f = entity.lastshottime;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x3990c63e, Offset: 0x1b00
// Size: 0xde
function private function_bbe42083(entity) {
    if (entity asmistransitionrunning()) {
        return;
    }
    if (entity.lastshottime > entity.var_a4f84a7f) {
        entity.var_1a0b2452 = 0;
        entity.var_a4f84a7f = entity.lastshottime;
    }
    if (isdefined(entity.enemy) && entity cansee(entity.enemy)) {
        entity.var_1a0b2452 += 0.05;
    } else {
        entity.var_1a0b2452 = 0;
    }
    if (entity.var_1a0b2452 >= 5) {
        entity.nextfindbestcovertime = gettime();
        entity.var_1a0b2452 = 0;
    }
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x28fcb8ed, Offset: 0x1be8
// Size: 0x6a
function private coverleanterminate(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
    entity.var_1a0b2452 = undefined;
    entity.var_a4f84a7f = undefined;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x91cf19e8, Offset: 0x1c60
// Size: 0x76
function private function_9e5575be(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
    entity ai::gun_recall();
    entity.blockingpain = 0;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x43b18e8f, Offset: 0x1ce0
// Size: 0x23c
function private supportsovercovercondition(entity) {
    if (entity ai::get_behavior_attribute("disablelean")) {
        return false;
    }
    stance = entity getblackboardattribute("_stance");
    if (isdefined(entity.node)) {
        if (entity.node.type == #"conceal crouch" || entity.node.type == #"conceal stand") {
            return true;
        }
        if (!isinarray(getvalidcoverpeekouts(entity.node), "over")) {
            return false;
        }
        if (entity.node.type == #"cover left" || entity.node.type == #"cover right" || entity.node.type == #"cover crouch" || entity.node.type == #"cover crouch window" || entity.node.type == #"conceal crouch") {
            if (stance == "crouch") {
                return true;
            }
        } else if (entity.node.type == #"cover stand" || entity.node.type == #"conceal stand") {
            if (stance == "stand") {
                return true;
            }
        }
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x61c34f85, Offset: 0x1f28
// Size: 0xba
function private shouldoveratcovercondition(entity) {
    if (!isdefined(entity.node) || !isdefined(entity.node.type) || !isdefined(entity.enemy) || !isdefined(entity.enemy.origin)) {
        return 0;
    }
    aimtable = iscoverconcealed(entity.node) ? "cover_concealed_over" : "cover_over";
    return function_cfe04a8d(entity, aimtable);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xe3411b4, Offset: 0x1ff0
// Size: 0x46
function private function_74e272f2(entity) {
    if (!supportsovercovercondition(entity)) {
        return false;
    }
    if (!shouldoveratcovercondition(entity)) {
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xe4129d11, Offset: 0x2040
// Size: 0x42
function private function_2b201dbe(entity) {
    if (entity asmistransitionrunning()) {
        return 1;
    }
    return shouldoveratcovercondition(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x3af31ec8, Offset: 0x2090
// Size: 0x96
function private coveroverinitialize(entity) {
    setcovershootstarttime(entity);
    thread function_4ec57157(entity);
    keepclaimnode(entity);
    entity setblackboardattribute("_cover_mode", "cover_over");
    entity.var_d9884655 = 0;
    entity.var_a4f84a7f = entity.lastshottime;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xbd5d63d5, Offset: 0x2130
// Size: 0xde
function private function_2f4d2a0a(entity) {
    if (entity asmistransitionrunning()) {
        return;
    }
    if (entity.lastshottime > entity.var_a4f84a7f) {
        entity.var_d9884655 = 0;
        entity.var_a4f84a7f = entity.lastshottime;
    }
    if (isdefined(entity.enemy) && entity cansee(entity.enemy)) {
        entity.var_d9884655 += 0.05;
    } else {
        entity.var_d9884655 = 0;
    }
    if (entity.var_d9884655 >= 5) {
        entity.nextfindbestcovertime = gettime();
        entity.var_1a0b2452 = 0;
    }
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x28d572e7, Offset: 0x2218
// Size: 0x52
function private coveroverterminate(entity) {
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
    entity.var_d9884655 = undefined;
    entity.var_a4f84a7f = undefined;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x42ac86c3, Offset: 0x2278
// Size: 0x46
function private function_b605a3b2(entity) {
    coveroverterminate(entity);
    entity ai::gun_recall();
    entity.blockingpain = 0;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x21d0919a, Offset: 0x22c8
// Size: 0x16
function private function_af89626a(entity) {
    return entity.var_ca9e83c;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xb35bce34, Offset: 0x22e8
// Size: 0xda
function private coveridleinitialize(entity) {
    keepclaimnode(entity);
    entity setblackboardattribute("_cover_mode", "cover_alert");
    entity.var_ca9e83c = 2000;
    curtime = gettime();
    if (curtime == entity.var_79f94433) {
        entity.var_ca9e83c = randomintrange(500, 2000);
    }
    if (isdefined(entity.var_fcadfdcd) && curtime == entity.var_fcadfdcd) {
        entity.var_ca9e83c = randomintrange(500, 2000);
    }
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x2f82265e, Offset: 0x23d0
// Size: 0x46
function private coveridleterminate(entity) {
    releaseclaimnode(entity);
    cleanupcovermode(entity);
    entity.var_3afb60bf = undefined;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x1763f9a0, Offset: 0x2420
// Size: 0x128
function isatcrouchnode(entity) {
    if (isdefined(entity.node) && (entity.node.type == #"exposed" || entity.node.type == #"guard" || entity.node.type == #"path")) {
        if (distancesquared(entity.origin, entity.node.origin) <= sqr(24)) {
            return (!entity function_c97b59f8("stand", entity.node) && entity function_c97b59f8("crouch", entity.node));
        }
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xaa01c4f7, Offset: 0x2550
// Size: 0x158
function function_1d3ee45b(entity) {
    if (isdefined(entity.node) && (entity.node.type == #"exposed" || entity.node.type == #"guard" || entity.node.type == #"path")) {
        if (distancesquared(entity.origin, entity.node.origin) <= sqr(24)) {
            return (!entity function_c97b59f8("stand", entity.node) && !entity function_c97b59f8("crouch", entity.node) && entity function_c97b59f8("prone", entity.node));
        }
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x16534cdf, Offset: 0x26b0
// Size: 0x8a
function function_3fe92ec8(entity) {
    if (isdefined(entity.enemy)) {
        deltayaw = entity bb_actorgettrackingturnyaw();
    } else {
        deltayaw = entity bb_getyawtocovernode();
    }
    absdeltayaw = absangleclamp180(deltayaw);
    if (absdeltayaw > 45) {
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xf9472a7d, Offset: 0x2748
// Size: 0x134
function private function_94bbbfa3(entity) {
    if (!btapi_isatcovercondition(entity)) {
        if (entity isatcovernodestrict() && is_true(entity.var_b8cc25c)) {
            if (archetype_human_cover::function_1fa73a96(entity)) {
                return true;
            }
            if (is_true(entity.ai.reloading) && !btapi_shouldmelee(entity)) {
                return true;
            }
            if (isdefined(entity.var_f13fb34f) && gettime() - entity.var_f13fb34f < 3000) {
                if (distancesquared(entity.origin, entity.var_39226de1) < sqr(32)) {
                    return true;
                }
            }
        }
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x1e5434a4, Offset: 0x2888
// Size: 0x6c
function private function_b7e28483(entity) {
    if (entity isatcovernodestrict()) {
        entity.var_342553bc = 0;
        entity.var_b8cc25c = 1;
        entity.var_541abeb7 = gettime();
        entity.var_99d0daef = entity.origin;
    }
    function_c1ac838a(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x19f72c2a, Offset: 0x2900
// Size: 0x3e
function isatcoverstrictcondition(entity) {
    return entity isatcovernodestrict() && !entity haspath();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xac4a493f, Offset: 0x2948
// Size: 0x44
function isatcovermodeover(entity) {
    covermode = entity getblackboardattribute("_cover_mode");
    return covermode == "cover_over";
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x8865bcb1, Offset: 0x2998
// Size: 0x44
function isatcovermodenone(entity) {
    covermode = entity getblackboardattribute("_cover_mode");
    return covermode == "cover_mode_none";
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x7c9e11b8, Offset: 0x29e8
// Size: 0x98
function function_d18f7e29(entity) {
    if (entity.node.type == #"cover stand" || entity.node.type == #"conceal stand") {
        covermode = entity getblackboardattribute("_cover_mode");
        if (covermode == "cover_over") {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xd0751893, Offset: 0x2a88
// Size: 0x3e
function isexposedatcovercondition(entity) {
    return isatcoverstrictcondition(entity) && !entity shouldusecovernode();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xbd13adc7, Offset: 0x2ad0
// Size: 0x3c
function function_bd4a2ff7(entity) {
    return isatcoverstrictcondition(entity) && entity shouldusecovernode();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xe5d63e0, Offset: 0x2b18
// Size: 0x5e
function shouldcoveridleonly(entity) {
    if (entity ai::get_behavior_attribute("coverIdleOnly")) {
        return true;
    }
    if (is_true(entity.node.script_onlyidle)) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xce0ac41c, Offset: 0x2b80
// Size: 0x2a
function issuppressedatcovercondition(entity) {
    if (entity.suppressionmeter > entity.var_4a68f84b) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xf6090078, Offset: 0x2bb8
// Size: 0x10
function function_5d963944(*entity) {
    return true;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x764c31d8, Offset: 0x2bd0
// Size: 0x3c
function keepclaimednodeandchoosecoverdirection(entity) {
    keepclaimnode(entity);
    choosecoverdirection(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x36da4563, Offset: 0x2c18
// Size: 0x54
function resetcoverparameters(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 2, eflags: 0x0
// Checksum 0xfe702967, Offset: 0x2c78
// Size: 0x9c
function choosecoverdirection(entity, stepout) {
    if (!isdefined(entity.node)) {
        return;
    }
    coverdirection = entity getblackboardattribute("_cover_direction");
    entity setblackboardattribute("_previous_cover_direction", coverdirection);
    entity setblackboardattribute("_cover_direction", calculatecoverdirection(entity, stepout));
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xcf5a735c, Offset: 0x2d20
// Size: 0x142
function function_f6d48a6a(entity) {
    if (isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024) {
        return "cover_right_direction";
    }
    if (isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048) {
        return "cover_left_direction";
    }
    if (isdefined(entity.enemy)) {
        aimlimits = entity getaimlimitsfromentry("pillar_right_lean");
        if (function_1587e509(entity, aimlimits, 0, undefined)) {
            return "cover_right_direction";
        }
        return "cover_left_direction";
    } else {
        return array::random(["cover_left_direction", "cover_right_direction"]);
    }
    return "cover_left_direction";
}

// Namespace aiutility/archetype_cover_utility
// Params 2, eflags: 0x0
// Checksum 0x268f001b, Offset: 0x2e70
// Size: 0x1d2
function calculatecoverdirection(entity, stepout) {
    if (isdefined(entity.treatallcoversasgeneric)) {
        if (!isdefined(stepout)) {
            stepout = 0;
        }
        coverdirection = "cover_front_direction";
        if (entity.node.type == #"cover left") {
            if (entity function_c97b59f8("stand", entity.node) || math::cointoss() || stepout) {
                coverdirection = "cover_left_direction";
            }
        } else if (entity.node.type == #"cover right") {
            if (entity function_c97b59f8("stand", entity.node) || math::cointoss() || stepout) {
                coverdirection = "cover_right_direction";
            }
        } else if (entity.node.type == #"cover pillar") {
            coverdirection = function_f6d48a6a(entity);
        }
        return coverdirection;
    } else {
        coverdirection = "cover_front_direction";
        if (entity.node.type == #"cover pillar") {
            coverdirection = function_f6d48a6a(entity);
        }
    }
    return coverdirection;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xab4c313, Offset: 0x3050
// Size: 0x16
function clearcovershootstarttime(entity) {
    entity.covershootstarttime = undefined;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x7a67fec6, Offset: 0x3070
// Size: 0x16
function setcovershootstarttime(entity) {
    entity.covershootstarttime = gettime();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xfb285831, Offset: 0x3090
// Size: 0xd2
function function_4ec57157(entity) {
    self notify("13292104f94d8690");
    self endon("13292104f94d8690");
    entity endon(#"death");
    starttime = gettime();
    while (!entity asmistransitionrunning()) {
        if (gettime() - starttime > 5000) {
            return;
        }
        wait 0.05;
    }
    starttime = gettime();
    while (entity asmistransitionrunning()) {
        if (gettime() - starttime > 5000) {
            return;
        }
        wait 0.05;
    }
    wait 0.25;
    entity.lastcanshootenemytime = 0;
    entity.lastcanshootlastsightpostime = 0;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xff962de3, Offset: 0x3170
// Size: 0x28
function canbeflanked(entity) {
    return isdefined(entity.canbeflanked) && entity.canbeflanked;
}

// Namespace aiutility/archetype_cover_utility
// Params 2, eflags: 0x0
// Checksum 0x1a149f23, Offset: 0x31a0
// Size: 0x22
function setcanbeflanked(entity, canbeflanked) {
    entity.canbeflanked = canbeflanked;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x81471ae4, Offset: 0x31d0
// Size: 0xe4
function cleanupcovermode(entity) {
    if (btapi_isatcovercondition(entity)) {
        covermode = entity getblackboardattribute("_cover_mode");
        entity setblackboardattribute("_previous_cover_mode", covermode);
        entity setblackboardattribute("_cover_mode", "cover_mode_none");
        return;
    }
    entity setblackboardattribute("_previous_cover_mode", "cover_mode_none");
    entity setblackboardattribute("_cover_mode", "cover_mode_none");
}

// Namespace aiutility/archetype_cover_utility
// Params 4, eflags: 0x4
// Checksum 0xe5f0b79e, Offset: 0x32c0
// Size: 0xfa
function private function_1587e509(entity, aimlimits, var_b0b60311, var_ec53bfd8) {
    yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
    var_8c878d2c = 10;
    if (isdefined(var_b0b60311)) {
        var_8c878d2c = var_b0b60311;
    }
    var_dce16ce3 = 10;
    if (isdefined(var_ec53bfd8)) {
        var_dce16ce3 = var_ec53bfd8;
    }
    var_5aeb5aa8 = aimlimits[#"aim_left"] + var_8c878d2c;
    var_e43acc7e = aimlimits[#"aim_right"] - var_dce16ce3;
    legalaimyaw = yawtoenemyposition >= var_e43acc7e && yawtoenemyposition <= var_5aeb5aa8;
    return legalaimyaw;
}

// Namespace aiutility/archetype_cover_utility
// Params 2, eflags: 0x4
// Checksum 0x58260a85, Offset: 0x33c8
// Size: 0xaa
function private function_db059f5c(entity, aimlimits) {
    pitchtoenemyposition = getaimpitchtoenemyfromnode(entity, entity.node, entity.enemy);
    var_d50d64a8 = aimlimits[#"aim_up"] - 10;
    var_fb118db8 = aimlimits[#"aim_down"] + 10;
    legalaimpitch = pitchtoenemyposition >= var_d50d64a8 && pitchtoenemyposition <= var_fb118db8;
    return legalaimpitch;
}

// Namespace aiutility/archetype_cover_utility
// Params 4, eflags: 0x4
// Checksum 0x1678ea26, Offset: 0x3480
// Size: 0x8e
function private function_cfe04a8d(entity, aimtable, var_b0b60311, var_ec53bfd8) {
    aimlimits = entity getaimlimitsfromentry(aimtable);
    if (!function_1587e509(entity, aimlimits, var_b0b60311, var_ec53bfd8)) {
        return false;
    }
    if (!function_db059f5c(entity, aimlimits)) {
        return false;
    }
    return true;
}

