#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\math_shared;

#namespace aiutility;

// Namespace aiutility/archetype_cover_utility
// Params 0, eflags: 0x2
// Checksum 0xba0a41fd, Offset: 0x1e0
// Size: 0x112c
function autoexec registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&isatcrouchnode));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcrouchnode", &isatcrouchnode);
    assert(iscodefunctionptr(&btapi_isatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_isatcovercondition", &btapi_isatcovercondition);
    assert(isscriptfunctionptr(&isatcoverstrictcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcoverstrictcondition", &isatcoverstrictcondition);
    assert(isscriptfunctionptr(&isatcovermodeover));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcovermodeover", &isatcovermodeover);
    assert(isscriptfunctionptr(&isatcovermodenone));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcovermodenone", &isatcovermodenone);
    assert(isscriptfunctionptr(&isexposedatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isexposedatcovercondition", &isexposedatcovercondition);
    assert(isscriptfunctionptr(&keepclaimednodeandchoosecoverdirection));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"keepclaimednodeandchoosecoverdirection", &keepclaimednodeandchoosecoverdirection);
    assert(isscriptfunctionptr(&resetcoverparameters));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"resetcoverparameters", &resetcoverparameters);
    assert(isscriptfunctionptr(&cleanupcovermode));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupcovermode", &cleanupcovermode);
    assert(isscriptfunctionptr(&canbeflankedservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"canbeflankedservice", &canbeflankedservice);
    assert(isscriptfunctionptr(&shouldcoveridleonly));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldcoveridleonly", &shouldcoveridleonly);
    assert(isscriptfunctionptr(&issuppressedatcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"issuppressedatcovercondition", &issuppressedatcovercondition);
    assert(isscriptfunctionptr(&coveridleinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveridleinitialize", &coveridleinitialize);
    assert(iscodefunctionptr(&btapi_coveridleupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_coveridleupdate", &btapi_coveridleupdate);
    assert(isscriptfunctionptr(&coveridleupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveridleupdate", &coveridleupdate);
    assert(isscriptfunctionptr(&coveridleterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveridleterminate", &coveridleterminate);
    assert(isscriptfunctionptr(&shouldleanatcoveridlecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldleanatcoveridlecondition", &shouldleanatcoveridlecondition);
    assert(isscriptfunctionptr(&continueleaningatcoveridlecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"continueleaningatcoveridlecondition", &continueleaningatcoveridlecondition, 5);
    assert(isscriptfunctionptr(&isflankedbyenemyatcover));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isflankedbyenemyatcover", &isflankedbyenemyatcover);
    assert(isscriptfunctionptr(&coverflankedinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverflankedactionstart", &coverflankedinitialize);
    assert(isscriptfunctionptr(&coverflankedactionterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverflankedactionterminate", &coverflankedactionterminate);
    assert(isscriptfunctionptr(&supportsovercovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportsovercovercondition", &supportsovercovercondition);
    assert(isscriptfunctionptr(&shouldoveratcovercondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldoveratcovercondition", &shouldoveratcovercondition);
    assert(isscriptfunctionptr(&coveroverinitialize));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveroverinitialize", &coveroverinitialize);
    assert(isscriptfunctionptr(&coveroverterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveroverterminate", &coveroverterminate);
    assert(isscriptfunctionptr(&function_9bc131f0));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_58ddf57d938c96a6", &function_9bc131f0);
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
    assert(isscriptfunctionptr(&function_181f0ca2));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72e14fa3a8f112e4", &function_181f0ca2);
    assert(isscriptfunctionptr(&function_7bd16e3e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_229844e28015a254", &function_7bd16e3e);
    assert(isscriptfunctionptr(&function_a4929b06));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_65aba356fa88122c", &function_a4929b06);
    assert(isscriptfunctionptr(&function_2fb0992e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_35b14110efcdb018", &function_2fb0992e, 1);
    assert(isscriptfunctionptr(&function_87af6a35));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_636e311aa7ebc589", &function_87af6a35);
    assert(isscriptfunctionptr(&function_b1f29408));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2005ffaf6edd8e46", &function_b1f29408);
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
// Params 1, eflags: 0x4
// Checksum 0x1314ea92, Offset: 0x1318
// Size: 0x4c
function private coverreloadinitialize(entity) {
    entity setblackboardattribute("_cover_mode", "cover_alert");
    keepclaimnode(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xbef948b, Offset: 0x1370
// Size: 0x54
function refillammoandcleanupcovermode(entity) {
    if (isalive(entity)) {
        refillammo(entity);
    }
    cleanupcovermode(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xe3663567, Offset: 0x13d0
// Size: 0x18
function private supportspeekcovercondition(entity) {
    return isdefined(entity.node);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x2b284a18, Offset: 0x13f0
// Size: 0x64
function private coverpeekinitialize(entity) {
    entity setblackboardattribute("_cover_mode", "cover_alert");
    keepclaimnode(entity);
    choosecoverdirection(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x354b198e, Offset: 0x1460
// Size: 0x3c
function private coverpeekterminate(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xb502127b, Offset: 0x14a8
// Size: 0x120
function private function_7bd16e3e(entity) {
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
// Checksum 0x130d23eb, Offset: 0x15d0
// Size: 0x348
function private function_a4929b06(entity) {
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
// Params 1, eflags: 0x4
// Checksum 0x8ae43012, Offset: 0x1920
// Size: 0x42
function private function_2fb0992e(entity) {
    if (entity asmistransitionrunning()) {
        return 1;
    }
    return function_a4929b06(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x4ec8e4c1, Offset: 0x1970
// Size: 0x3c0
function private function_a53b2060(entity) {
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
// Checksum 0x8a53c20e, Offset: 0x1d38
// Size: 0x42
function private function_3ff85aea(entity) {
    if (entity asmistransitionrunning()) {
        return 1;
    }
    return function_a53b2060(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x3ce66a7f, Offset: 0x1d88
// Size: 0x7c
function private function_87af6a35(entity) {
    setcovershootstarttime(entity);
    keepclaimnode(entity);
    entity setblackboardattribute("_cover_mode", "cover_lean");
    choosecoverdirection(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x8e7d5259, Offset: 0x1e10
// Size: 0x54
function private function_b1f29408(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xc55dcdfc, Offset: 0x1e70
// Size: 0x120
function private supportsleancovercondition(entity) {
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
// Checksum 0x9abcdd0b, Offset: 0x1f98
// Size: 0x348
function private shouldleanatcovercondition(entity) {
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
// Params 1, eflags: 0x4
// Checksum 0x18d8789a, Offset: 0x22e8
// Size: 0x42
function private continueleaningatcovercondition(entity) {
    if (entity asmistransitionrunning()) {
        return 1;
    }
    return shouldleanatcovercondition(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x6b03fc00, Offset: 0x2338
// Size: 0x3c0
function private shouldleanatcoveridlecondition(entity) {
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
// Checksum 0x84ba7a2a, Offset: 0x2700
// Size: 0x42
function private continueleaningatcoveridlecondition(entity) {
    if (entity asmistransitionrunning()) {
        return 1;
    }
    return shouldleanatcoveridlecondition(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x1d391cc6, Offset: 0x2750
// Size: 0x7c
function private coverleaninitialize(entity) {
    setcovershootstarttime(entity);
    keepclaimnode(entity);
    entity setblackboardattribute("_cover_mode", "cover_lean");
    choosecoverdirection(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xa16bc912, Offset: 0x27d8
// Size: 0x54
function private coverleanterminate(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xda48f266, Offset: 0x2838
// Size: 0x7a
function private function_181f0ca2(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
    entity ai::gun_recall();
    entity.blockingpain = 0;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x8787809d, Offset: 0x28c0
// Size: 0x22c
function private supportsovercovercondition(entity) {
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
// Checksum 0xcdefb635, Offset: 0x2af8
// Size: 0x1f6
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
// Params 1, eflags: 0x4
// Checksum 0x1477bcba, Offset: 0x2cf8
// Size: 0x64
function private coveroverinitialize(entity) {
    setcovershootstarttime(entity);
    keepclaimnode(entity);
    entity setblackboardattribute("_cover_mode", "cover_over");
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x656ca8ff, Offset: 0x2d68
// Size: 0x3c
function private coveroverterminate(entity) {
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xf3b52e1e, Offset: 0x2db0
// Size: 0x4a
function private function_9bc131f0(entity) {
    coveroverterminate(entity);
    entity ai::gun_recall();
    entity.blockingpain = 0;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xa12e1dc8, Offset: 0x2e08
// Size: 0x4c
function private coveridleinitialize(entity) {
    keepclaimnode(entity);
    entity setblackboardattribute("_cover_mode", "cover_alert");
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xc6b7ad6, Offset: 0x2e60
// Size: 0x3c
function private coveridleupdate(entity) {
    if (!entity asmistransitionrunning()) {
        releaseclaimnode(entity);
    }
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x511f0df1, Offset: 0x2ea8
// Size: 0x3c
function private coveridleterminate(entity) {
    releaseclaimnode(entity);
    cleanupcovermode(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x3cbab45c, Offset: 0x2ef0
// Size: 0x6e
function private isflankedbyenemyatcover(entity) {
    return canbeflanked(entity) && entity isatcovernodestrict() && entity isflankedatcovernode() && !entity haspath();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xdea25f06, Offset: 0x2f68
// Size: 0x24
function private canbeflankedservice(entity) {
    setcanbeflanked(entity, 1);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0xef122276, Offset: 0x2f98
// Size: 0xcc
function private coverflankedinitialize(entity) {
    if (isdefined(entity.enemy)) {
        entity getperfectinfo(entity.enemy);
        entity pathmode("move delayed", 0, 2);
    }
    setcanbeflanked(entity, 0);
    cleanupcovermode(entity);
    keepclaimnode(entity);
    entity setblackboardattribute("_desired_stance", "stand");
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x4
// Checksum 0x1b81f9c3, Offset: 0x3070
// Size: 0x2c
function private coverflankedactionterminate(entity) {
    entity.newenemyreaction = 0;
    releaseclaimnode(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x72f46238, Offset: 0x30a8
// Size: 0x120
function isatcrouchnode(entity) {
    if (isdefined(entity.node) && (entity.node.type == #"exposed" || entity.node.type == #"guard" || entity.node.type == #"path")) {
        if (distancesquared(entity.origin, entity.node.origin) <= 24 * 24) {
            return (!isstanceallowedatnode("stand", entity.node) && isstanceallowedatnode("crouch", entity.node));
        }
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x685195c, Offset: 0x31d0
// Size: 0x3e
function isatcoverstrictcondition(entity) {
    return entity isatcovernodestrict() && !entity haspath();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x9c0974f5, Offset: 0x3218
// Size: 0x44
function isatcovermodeover(entity) {
    covermode = entity getblackboardattribute("_cover_mode");
    return covermode == "cover_over";
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x9d935954, Offset: 0x3268
// Size: 0x44
function isatcovermodenone(entity) {
    covermode = entity getblackboardattribute("_cover_mode");
    return covermode == "cover_mode_none";
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xc5290579, Offset: 0x32b8
// Size: 0x3e
function isexposedatcovercondition(entity) {
    return entity isatcovernodestrict() && !entity shouldusecovernode();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x1d498cab, Offset: 0x3300
// Size: 0x6c
function shouldcoveridleonly(entity) {
    if (entity ai::get_behavior_attribute("coverIdleOnly")) {
        return true;
    }
    if (isdefined(entity.node.script_onlyidle) && entity.node.script_onlyidle) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xc8b31258, Offset: 0x3378
// Size: 0x24
function issuppressedatcovercondition(entity) {
    return entity.suppressionmeter > entity.suppressionthreshold;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x48722935, Offset: 0x33a8
// Size: 0x3c
function keepclaimednodeandchoosecoverdirection(entity) {
    keepclaimnode(entity);
    choosecoverdirection(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xfc32d1cc, Offset: 0x33f0
// Size: 0x54
function resetcoverparameters(entity) {
    choosefrontcoverdirection(entity);
    cleanupcovermode(entity);
    clearcovershootstarttime(entity);
}

// Namespace aiutility/archetype_cover_utility
// Params 2, eflags: 0x0
// Checksum 0x7819586b, Offset: 0x3450
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
// Params 2, eflags: 0x0
// Checksum 0x6d842543, Offset: 0x34f8
// Size: 0x452
function calculatecoverdirection(entity, stepout) {
    if (isdefined(entity.treatallcoversasgeneric)) {
        if (!isdefined(stepout)) {
            stepout = 0;
        }
        coverdirection = "cover_front_direction";
        if (entity.node.type == #"cover left") {
            if (isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 4) == 4 || math::cointoss() || stepout) {
                coverdirection = "cover_left_direction";
            }
        } else if (entity.node.type == #"cover right") {
            if (isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 4) == 4 || math::cointoss() || stepout) {
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
// Params 1, eflags: 0x0
// Checksum 0x5accfaa5, Offset: 0x3958
// Size: 0x16
function clearcovershootstarttime(entity) {
    entity.covershootstarttime = undefined;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x7f107ffc, Offset: 0x3978
// Size: 0x1a
function setcovershootstarttime(entity) {
    entity.covershootstarttime = gettime();
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0x42bf9b0e, Offset: 0x39a0
// Size: 0x28
function canbeflanked(entity) {
    return isdefined(entity.canbeflanked) && entity.canbeflanked;
}

// Namespace aiutility/archetype_cover_utility
// Params 2, eflags: 0x0
// Checksum 0x96d487f1, Offset: 0x39d0
// Size: 0x22
function setcanbeflanked(entity, canbeflanked) {
    entity.canbeflanked = canbeflanked;
}

// Namespace aiutility/archetype_cover_utility
// Params 1, eflags: 0x0
// Checksum 0xd65dadc0, Offset: 0x3a00
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

