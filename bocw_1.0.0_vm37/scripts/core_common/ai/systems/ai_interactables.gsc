#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace aiinteractables;

// Namespace aiinteractables/ai_interactables
// Params 0, eflags: 0x6
// Checksum 0xbbab742b, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"ai_interactables", &preinit, undefined, undefined, undefined);
}

// Namespace aiinteractables/ai_interactables
// Params 0, eflags: 0x4
// Checksum 0xcd4f70ac, Offset: 0xe0
// Size: 0x14c
function private preinit() {
    assert(isscriptfunctionptr(&function_64d25a18));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_57181cf80bd4059f", &function_64d25a18);
    assert(isscriptfunctionptr(&function_64d25a18));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_57181cf80bd4059f", &function_64d25a18);
    assert(isscriptfunctionptr(&function_b4bc7751));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ef372b4649a577e", &function_b4bc7751);
    thread function_2f0f1b62();
}

// Namespace aiinteractables/ai_interactables
// Params 0, eflags: 0x4
// Checksum 0xe6a5ed3e, Offset: 0x238
// Size: 0x120
function private function_2f0f1b62() {
    nodes = getallnodes();
    foreach (node in nodes) {
        if (is_true(node.interact_node) && isdefined(node.target)) {
            if (is_true(node.var_71c87324)) {
                continue;
            }
            var_54d06303 = struct::get(node.target);
            if (isdefined(var_54d06303)) {
                var_54d06303 scene::init();
            }
        }
    }
}

// Namespace aiinteractables/ai_interactables
// Params 1, eflags: 0x0
// Checksum 0xb7aebdd5, Offset: 0x360
// Size: 0xc0
function function_64d25a18(entity) {
    if (entity.archetype !== #"human") {
        return false;
    }
    if (!isdefined(entity.node)) {
        return false;
    }
    if (!iscovernode(entity.node)) {
        return false;
    }
    if (!entity isatcovernode()) {
        return false;
    }
    if (!is_true(entity.node.interact_node)) {
        return false;
    }
    if (isdefined(entity.node.var_31c05612)) {
        return false;
    }
    return true;
}

// Namespace aiinteractables/ai_interactables
// Params 1, eflags: 0x4
// Checksum 0xabcbd7f3, Offset: 0x428
// Size: 0x158
function private function_b4bc7751(entity) {
    assert(!is_true(entity.node.var_31c05612));
    if (isdefined(entity.node.target)) {
        entity pathmode("move delayed", 8);
        entity.node.var_31c05612 = 1;
        var_54d06303 = struct::get(entity.node.target);
        var_54d06303 scene::play(entity);
        var_54d06303 notify(#"hash_4d2293524fe1c94c", {#ai_interactable:entity});
        if (isalive(entity)) {
            entity notify(#"hash_4d2293524fe1c94c", {#var_bad0e17c:var_54d06303, #var_c17a3b30:entity.node});
        }
    }
}

