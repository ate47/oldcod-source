#using scripts\core_common\ai\archetype_human_cover;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\math_shared;

#namespace aiutility;

// Namespace aiutility/archetype_cover_utility
// Params 0, eflags: 0x2
// Checksum 0x53bf0eca, Offset: 0x238
// Size: 0x10c4
function autoexec registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&isatcrouchnode));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcrouchnode", &isatcrouchnode);
    assert(isscriptfunctionptr(&function_1d3ee45b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5f2632e56b895b62", &function_1d3ee45b);
    assert(iscodefunctionptr(&btapi_isatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_isatcovercondition", &btapi_isatcovercondition);
    assert(isscriptfunctionptr(&function_94bbbfa3));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_42946f41bb05517f", &function_94bbbfa3);
    assert(isscriptfunctionptr(&isatcoverstrictcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcoverstrictcondition", &isatcoverstrictcondition);
    assert(isscriptfunctionptr(&isatcovermodeover));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcovermodeover", &isatcovermodeover);
    assert(isscriptfunctionptr(&isatcovermodenone));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcovermodenone", &isatcovermodenone);
    assert(isscriptfunctionptr(&function_d18f7e29));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6f3930f6d8ab6bea", &function_d18f7e29);
    assert(isscriptfunctionptr(&isexposedatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isexposedatcovercondition", &isexposedatcovercondition);
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
    assert(isscriptfunctionptr(&function_2b201dbe));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_66501b5b5629a24f", &function_2b201dbe, 1);
    assert(isscriptfunctionptr(&coveroverinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveroverinitialize", &coveroverinitialize);
    assert(isscriptfunctionptr(&coveroverterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveroverterminate", &coveroverterminate);
    assert(isscriptfunctionptr(&function_b605a3b2));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_58ddf57d938c96a6", &function_b605a3b2);
    assert(isscriptfunctionptr(&supportsleancovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportsleancovercondition", &supportsleancovercondition);
    assert(isscriptfunctionptr(&shouldleanatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldleanatcovercondition", &shouldleanatcovercondition);
    assert(isscriptfunctionptr(&continueleaningatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"continueleaningatcovercondition", &continueleaningatcovercondition, 1);
    assert(isscriptfunctionptr(&coverleaninitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverleaninitialize", &coverleaninitialize);
    assert(isscriptfunctionptr(&coverleanterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverleanterminate", &coverleanterminate);
    assert(isscriptfunctionptr(&function_9e5575be));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72e14fa3a8f112e4", &function_9e5575be);
    assert(isscriptfunctionptr(&function_dc503571));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_229844e28015a254", &function_dc503571);
    assert(isscriptfunctionptr(&function_eb148f38));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_65aba356fa88122c", &function_eb148f38);
    assert(isscriptfunctionptr(&function_4c672ae3));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_35b14110efcdb018", &function_4c672ae3, 1);
    assert(isscriptfunctionptr(&function_a938cb03));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_636e311aa7ebc589", &function_a938cb03);
    assert(isscriptfunctionptr(&function_f82f8634));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2005ffaf6edd8e46", &function_f82f8634);
    assert(isscriptfunctionptr(&supportspeekcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportspeekcovercondition", &supportspeekcovercondition);
    assert(isscriptfunctionptr(&coverpeekinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverpeekinitialize", &coverpeekinitialize);
    assert(isscriptfunctionptr(&coverpeekterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverpeekterminate", &coverpeekterminate);
    assert(isscriptfunctionptr(&coverreloadinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverreloadinitialize", &coverreloadinitialize);
    assert(isscriptfunctionptr(&refillammoandcleanupcovermode));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"refillammoandcleanupcovermode", &refillammoandcleanupcovermode);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x27e1594f, Offset: 0x1308
// Size: 0x4c
function private coverreloadinitialize(entity) {
    entity setblackboardattribute("_cover_mode", "cover_alert");
    keepclaimnode(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xa01fe7f7, Offset: 0x1360
// Size: 0x54
function refillammoandcleanupcovermode(entity) {
    if (isalive(entity)) {
        btapi_refillammo(entity);
    }
    cleanupcovermode(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x35cd8fc4, Offset: 0x13c0
// Size: 0x3c
function private supportspeekcovercondition(entity) {
    if (entity ai::get_behavior_attribute("disablepeek")) {
        return false;
    }
    return isdefined(entity.node);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xdf1c400a, Offset: 0x1408
// Size: 0x64
function private coverpeekinitialize(entity) {
    entity setblackboardattribute("_cover_mode", "cover_alert");
    keepclaimnode(entity);
    choosecoverdirection(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x9d316fb7, Offset: 0x1478
// Size: 0x46
function private coverpeekterminate(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    entity.var_fcadfdcd = gettime();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x8b896591, Offset: 0x14c8
// Size: 0x11c
function private function_dc503571(entity) {
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
// Params 1, eflags: 0x5 linked
// Checksum 0x658152e1, Offset: 0x15f0
// Size: 0x31a
function private function_eb148f38(entity) {
    if (!isdefined(entity.node) || !isdefined(entity.node.type) || !isdefined(entity.enemy) || !isdefined(entity.enemy.origin)) {
        return 0;
    }
    yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
    legalaimyaw = 0;
    if (entity.node.type == #"cover left") {
        aimlimitsforcover = entity getaimlimitsfromentry("cover_left_lean");
        legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= -10;
    } else if (entity.node.type == #"cover right") {
        aimlimitsforcover = entity getaimlimitsfromentry("cover_right_lean");
        legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= 10;
    } else if (entity.node.type == #"cover pillar") {
        aimlimitsforcover = entity getaimlimitsfromentry("cover");
        supportsleft = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024);
        supportsright = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048);
        angleleeway = 10;
        if (supportsright && supportsleft) {
            angleleeway = 0;
        }
        if (supportsleft) {
            legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= angleleeway * -1;
        }
        if (!legalaimyaw && supportsright) {
            legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= angleleeway;
        }
    }
    return legalaimyaw;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x71209f70, Offset: 0x1918
// Size: 0x42
function private function_4c672ae3(entity) {
    if (entity asmistransitionrunning()) {
        return 1;
    }
    return function_eb148f38(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xb2600ea8, Offset: 0x1968
// Size: 0x38a
function private function_7353f95b(entity) {
    if (!isdefined(entity.node) || !isdefined(entity.node.type)) {
        return 0;
    }
    if (isdefined(entity.enemy)) {
        yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
    } else {
        pos = entity.node.origin + 250 * entity.node.angles;
        yawtoenemyposition = angleclamp180(vectortoangles(pos - entity.node.origin)[1] - entity.node.angles[1]);
    }
    legalaimyaw = 0;
    if (entity.node.type == #"cover left") {
        aimlimitsforcover = entity getaimlimitsfromentry("cover_left_lean");
        legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= -10;
    } else if (entity.node.type == #"cover right") {
        aimlimitsforcover = entity getaimlimitsfromentry("cover_right_lean");
        legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= 10;
    } else if (entity.node.type == #"cover pillar") {
        aimlimitsforcover = entity getaimlimitsfromentry("cover");
        supportsleft = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024);
        supportsright = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048);
        angleleeway = 10;
        if (supportsright && supportsleft) {
            angleleeway = 0;
        }
        if (supportsleft) {
            legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= angleleeway * -1;
        }
        if (!legalaimyaw && supportsright) {
            legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= angleleeway;
        }
    }
    return legalaimyaw;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xdbc3cf5, Offset: 0x1d00
// Size: 0x42
function private function_e9788bfb(entity) {
    if (entity asmistransitionrunning()) {
        return 1;
    }
    return function_7353f95b(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x7b54b5f0, Offset: 0x1d50
// Size: 0x7c
function private function_a938cb03(entity) {
    setcovershootstarttime(entity);
    keepclaimnode(entity);
    entity setblackboardattribute("_cover_mode", "cover_lean");
    choosecoverdirection(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x51b03869, Offset: 0x1dd8
// Size: 0x54
function private function_f82f8634(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x48d9c548, Offset: 0x1e38
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
// Params 1, eflags: 0x5 linked
// Checksum 0xa3d934de, Offset: 0x1f88
// Size: 0x35a
function private shouldleanatcovercondition(entity) {
    if (!isdefined(entity.node) || !isdefined(entity.node.type) || !isdefined(entity.enemy) || !isdefined(entity.enemy.origin)) {
        return 0;
    }
    yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
    legalaimyaw = 0;
    if (entity.node.type == #"cover left") {
        aimlimitsforcover = entity getaimlimitsfromentry("cover_left_lean");
        var_5aeb5aa8 = aimlimitsforcover[#"aim_left"] + 10;
        var_e43acc7e = aimlimitsforcover[#"aim_right"] - 10;
        legalaimyaw = yawtoenemyposition <= var_5aeb5aa8 && yawtoenemyposition >= var_e43acc7e;
    } else if (entity.node.type == #"cover right") {
        aimlimitsforcover = entity getaimlimitsfromentry("cover_right_lean");
        var_5aeb5aa8 = aimlimitsforcover[#"aim_left"] + 10;
        var_e43acc7e = aimlimitsforcover[#"aim_right"] - 10;
        legalaimyaw = yawtoenemyposition >= var_e43acc7e && yawtoenemyposition <= var_5aeb5aa8;
    } else if (entity.node.type == #"cover pillar") {
        aimlimitsforcover = entity getaimlimitsfromentry("cover");
        supportsleft = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024);
        supportsright = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048);
        angleleeway = 10;
        if (supportsright && supportsleft) {
            angleleeway = 0;
        }
        var_5aeb5aa8 = aimlimitsforcover[#"aim_left"] + 10;
        var_e43acc7e = aimlimitsforcover[#"aim_right"] - 10;
        if (supportsleft) {
            legalaimyaw = yawtoenemyposition <= var_5aeb5aa8 && yawtoenemyposition >= angleleeway * -1;
        }
        if (!legalaimyaw && supportsright) {
            legalaimyaw = yawtoenemyposition >= var_e43acc7e && yawtoenemyposition <= angleleeway;
        }
    }
    return legalaimyaw;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xb5ae25e1, Offset: 0x22f0
// Size: 0x42
function private continueleaningatcovercondition(entity) {
    if (entity asmistransitionrunning()) {
        return 1;
    }
    return shouldleanatcovercondition(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xe508e428, Offset: 0x2340
// Size: 0x94
function private coverleaninitialize(entity) {
    setcovershootstarttime(entity);
    thread function_4ec57157(entity);
    keepclaimnode(entity);
    entity setblackboardattribute("_cover_mode", "cover_lean");
    choosecoverdirection(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xf5b7d75a, Offset: 0x23e0
// Size: 0x54
function private coverleanterminate(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x28da4a28, Offset: 0x2440
// Size: 0x76
function private function_9e5575be(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
    entity ai::gun_recall();
    entity.blockingpain = 0;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xf46e952c, Offset: 0x24c0
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
// Params 1, eflags: 0x5 linked
// Checksum 0xc332c699, Offset: 0x2708
// Size: 0x1dc
function private shouldoveratcovercondition(entity) {
    if (!isdefined(entity.node) || !isdefined(entity.node.type) || !isdefined(entity.enemy) || !isdefined(entity.enemy.origin)) {
        return false;
    }
    aimtable = iscoverconcealed(entity.node) ? "cover_concealed_over" : "cover_over";
    aimlimitsforcover = entity getaimlimitsfromentry(aimtable);
    yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
    legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10;
    if (!legalaimyaw) {
        return false;
    }
    pitchtoenemyposition = getaimpitchtoenemyfromnode(entity, entity.node, entity.enemy);
    legalaimpitch = pitchtoenemyposition >= aimlimitsforcover[#"aim_up"] + 10 && pitchtoenemyposition <= aimlimitsforcover[#"aim_down"] + 10;
    if (!legalaimpitch) {
        return false;
    }
    return true;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xdb4cea6c, Offset: 0x28f0
// Size: 0x42
function private function_2b201dbe(entity) {
    if (entity asmistransitionrunning()) {
        return 1;
    }
    return shouldoveratcovercondition(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x30705a82, Offset: 0x2940
// Size: 0x7c
function private coveroverinitialize(entity) {
    setcovershootstarttime(entity);
    thread function_4ec57157(entity);
    keepclaimnode(entity);
    entity setblackboardattribute("_cover_mode", "cover_over");
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xa3487bc2, Offset: 0x29c8
// Size: 0x3c
function private coveroverterminate(entity) {
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xad7d0202, Offset: 0x2a10
// Size: 0x46
function private function_b605a3b2(entity) {
    coveroverterminate(entity);
    entity ai::gun_recall();
    entity.blockingpain = 0;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xb9bfa0c2, Offset: 0x2a60
// Size: 0x16
function private function_af89626a(entity) {
    return entity.var_ca9e83c;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xf56db5c8, Offset: 0x2a80
// Size: 0xea
function private coveridleinitialize(entity) {
    keepclaimnode(entity);
    entity setblackboardattribute("_cover_mode", "cover_alert");
    entity.var_ca9e83c = 2000;
    curtime = gettime();
    if (isdefined(entity.var_79f94433) && curtime == entity.var_79f94433) {
        entity.var_ca9e83c = randomintrange(500, 2000);
    }
    if (isdefined(entity.var_fcadfdcd) && curtime == entity.var_fcadfdcd) {
        entity.var_ca9e83c = randomintrange(500, 2000);
    }
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xa698082a, Offset: 0x2b78
// Size: 0x46
function private coveridleterminate(entity) {
    releaseclaimnode(entity);
    cleanupcovermode(entity);
    entity.var_3afb60bf = undefined;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xb15feb04, Offset: 0x2bc8
// Size: 0x128
function isatcrouchnode(entity) {
    if (isdefined(entity.node) && (entity.node.type == #"exposed" || entity.node.type == #"guard" || entity.node.type == #"path")) {
        if (distancesquared(entity.origin, entity.node.origin) <= function_a3f6cdac(24)) {
            return (!entity function_c97b59f8("stand", entity.node) && entity function_c97b59f8("crouch", entity.node));
        }
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x83cb1348, Offset: 0x2cf8
// Size: 0x158
function function_1d3ee45b(entity) {
    if (isdefined(entity.node) && (entity.node.type == #"exposed" || entity.node.type == #"guard" || entity.node.type == #"path")) {
        if (distancesquared(entity.origin, entity.node.origin) <= function_a3f6cdac(24)) {
            return (!entity function_c97b59f8("stand", entity.node) && !entity function_c97b59f8("crouch", entity.node) && entity function_c97b59f8("prone", entity.node));
        }
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xfc7a7fa3, Offset: 0x2e58
// Size: 0x46
function private function_94bbbfa3(entity) {
    if (!btapi_isatcovercondition(entity)) {
        if (!archetype_human_cover::function_1fa73a96(entity)) {
            return false;
        }
    }
    return true;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xab5d328c, Offset: 0x2ea8
// Size: 0x3e
function isatcoverstrictcondition(entity) {
    return entity isatcovernodestrict() && !entity haspath();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x389c608f, Offset: 0x2ef0
// Size: 0x44
function isatcovermodeover(entity) {
    covermode = entity getblackboardattribute("_cover_mode");
    return covermode == "cover_over";
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xeb311775, Offset: 0x2f40
// Size: 0x44
function isatcovermodenone(entity) {
    covermode = entity getblackboardattribute("_cover_mode");
    return covermode == "cover_mode_none";
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xe0180cb, Offset: 0x2f90
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
// Params 1, eflags: 0x1 linked
// Checksum 0x8489d8b1, Offset: 0x3030
// Size: 0x3e
function isexposedatcovercondition(entity) {
    return isatcoverstrictcondition(entity) && !entity shouldusecovernode();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x30ab6ad7, Offset: 0x3078
// Size: 0x3c
function function_bd4a2ff7(entity) {
    return isatcoverstrictcondition(entity) && entity shouldusecovernode();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x67955d26, Offset: 0x30c0
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
// Params 1, eflags: 0x1 linked
// Checksum 0x7ba0d89a, Offset: 0x3128
// Size: 0x2a
function issuppressedatcovercondition(entity) {
    if (entity.suppressionmeter > entity.var_4a68f84b) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xb028a231, Offset: 0x3160
// Size: 0x10
function function_5d963944(*entity) {
    return true;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x3914a587, Offset: 0x3178
// Size: 0x3c
function keepclaimednodeandchoosecoverdirection(entity) {
    keepclaimnode(entity);
    choosecoverdirection(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xa5668356, Offset: 0x31c0
// Size: 0x54
function resetcoverparameters(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xfb3611cc, Offset: 0x3220
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
// Params 2, eflags: 0x1 linked
// Checksum 0x88c26cad, Offset: 0x32c8
// Size: 0x40e
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
            if (isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024) {
                return "cover_right_direction";
            }
            if (isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048) {
                return "cover_left_direction";
            }
            coverdirection = "cover_left_direction";
            if (isdefined(entity.enemy)) {
                yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
                aimlimitsfordirectionright = entity getaimlimitsfromentry("pillar_right_lean");
                legalrightdirectionyaw = yawtoenemyposition >= aimlimitsfordirectionright[#"aim_right"] - 10 && yawtoenemyposition <= 0;
                if (legalrightdirectionyaw) {
                    coverdirection = "cover_right_direction";
                }
            }
        }
        return coverdirection;
    } else {
        coverdirection = "cover_front_direction";
        if (entity.node.type == #"cover pillar") {
            if (isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024) {
                return "cover_right_direction";
            }
            if (isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048) {
                return "cover_left_direction";
            }
            coverdirection = "cover_left_direction";
            if (isdefined(entity.enemy)) {
                yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
                aimlimitsfordirectionright = entity getaimlimitsfromentry("pillar_right_lean");
                legalrightdirectionyaw = yawtoenemyposition >= aimlimitsfordirectionright[#"aim_right"] - 10 && yawtoenemyposition <= 0;
                if (legalrightdirectionyaw) {
                    coverdirection = "cover_right_direction";
                }
            }
        }
    }
    return coverdirection;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x58ef269d, Offset: 0x36e0
// Size: 0x16
function clearcovershootstarttime(entity) {
    entity.covershootstarttime = undefined;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x49d3a6b6, Offset: 0x3700
// Size: 0x16
function setcovershootstarttime(entity) {
    entity.covershootstarttime = gettime();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x4e295f42, Offset: 0x3720
// Size: 0xd2
function function_4ec57157(entity) {
    self notify("107056b6aa72ada1");
    self endon("107056b6aa72ada1");
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
// Checksum 0x373cf4db, Offset: 0x3800
// Size: 0x28
function canbeflanked(entity) {
    return isdefined(entity.canbeflanked) && entity.canbeflanked;
}

// Namespace aiutility/archetype_cover_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xaf9394cd, Offset: 0x3830
// Size: 0x22
function setcanbeflanked(entity, canbeflanked) {
    entity.canbeflanked = canbeflanked;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x24a82153, Offset: 0x3860
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

