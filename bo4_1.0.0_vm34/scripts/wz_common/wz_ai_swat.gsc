#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace wz_ai_swat;

// Namespace wz_ai_swat/wz_ai_swat
// Params 0, eflags: 0x2
// Checksum 0x6bd25ca1, Offset: 0xe0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"swat", &__init__, undefined, undefined);
}

// Namespace wz_ai_swat/wz_ai_swat
// Params 0, eflags: 0x0
// Checksum 0x4f218c3, Offset: 0x128
// Size: 0x14
function __init__() {
    registerbehaviorscriptfunctions();
}

// Namespace wz_ai_swat/wz_ai_swat
// Params 0, eflags: 0x4
// Checksum 0x1d28dc13, Offset: 0x148
// Size: 0x244
function private registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_fe4d8225));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_62335a0608a02309", &function_fe4d8225);
    assert(isscriptfunctionptr(&function_934c4ec1));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4a938922d1af0c4d", &function_934c4ec1);
    assert(isscriptfunctionptr(&function_d17507ce));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4cc583c8bb841d4c", &function_d17507ce);
    assert(isscriptfunctionptr(&function_87d5f452));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3861dc092e2bcf88", &function_87d5f452);
    assert(isscriptfunctionptr(&function_c266062c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_48334fe2b83169f2", &function_c266062c);
    animationstatenetwork::registeranimationmocomp("mocomp_swat_team_pain", &function_bcd9b8e6, undefined, &function_829bb385);
}

// Namespace wz_ai_swat/wz_ai_swat
// Params 5, eflags: 0x0
// Checksum 0xa271f0f2, Offset: 0x398
// Size: 0xa2
function function_bcd9b8e6(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", self.angles[1]);
    entity animmode("zonly_physics", 1);
    entity pathmode("dont move");
    entity.blockingpain = 1;
}

// Namespace wz_ai_swat/wz_ai_swat
// Params 5, eflags: 0x0
// Checksum 0xb6e55eb4, Offset: 0x448
// Size: 0x5a
function function_829bb385(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity pathmode("move allowed");
    entity.blockingpain = 0;
}

// Namespace wz_ai_swat/wz_ai_swat
// Params 1, eflags: 0x4
// Checksum 0xc19187ac, Offset: 0x4b0
// Size: 0x2c
function private function_fe4d8225(entity) {
    if (entity.var_ea94c12a === "human_swat_gunner") {
        return true;
    }
    return false;
}

// Namespace wz_ai_swat/wz_ai_swat
// Params 1, eflags: 0x4
// Checksum 0x325b6797, Offset: 0x4e8
// Size: 0x24
function private function_934c4ec1(entity) {
    entity unlink();
}

// Namespace wz_ai_swat/wz_ai_swat
// Params 1, eflags: 0x4
// Checksum 0x92f1bd05, Offset: 0x518
// Size: 0x76
function private function_d17507ce(entity) {
    if (isdefined(entity.enemy)) {
        if (util::within_fov(entity.origin, entity.angles, entity.enemy.origin, cos(90))) {
            return true;
        }
    }
    return false;
}

// Namespace wz_ai_swat/wz_ai_swat
// Params 1, eflags: 0x4
// Checksum 0x2d98bc35, Offset: 0x598
// Size: 0xe
function private function_87d5f452(entity) {
    return false;
}

// Namespace wz_ai_swat/wz_ai_swat
// Params 1, eflags: 0x4
// Checksum 0x97056d6d, Offset: 0x5b0
// Size: 0xe
function private function_c266062c(entity) {
    return false;
}

