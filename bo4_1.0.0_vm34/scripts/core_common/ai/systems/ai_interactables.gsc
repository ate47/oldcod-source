#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace aiinteractables;

// Namespace aiinteractables/ai_interactables
// Params 0, eflags: 0x2
// Checksum 0xad26892c, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"ai_interactables", &__init__, undefined, undefined);
}

// Namespace aiinteractables/ai_interactables
// Params 0, eflags: 0x0
// Checksum 0x271e07b9, Offset: 0xf0
// Size: 0x14c
function __init__() {
    assert(isscriptfunctionptr(&function_afe8d517));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_57181cf80bd4059f", &function_afe8d517);
    assert(isscriptfunctionptr(&function_afe8d517));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_57181cf80bd4059f", &function_afe8d517);
    assert(isscriptfunctionptr(&function_fc588eec));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ef372b4649a577e", &function_fc588eec);
    thread function_3797cb63();
}

// Namespace aiinteractables/ai_interactables
// Params 0, eflags: 0x4
// Checksum 0x62913efe, Offset: 0x248
// Size: 0x118
function private function_3797cb63() {
    nodes = getallnodes();
    foreach (node in nodes) {
        if (isdefined(node.interact_node) && node.interact_node && isdefined(node.target)) {
            if (isdefined(node.var_2cad1aa7) && node.var_2cad1aa7) {
                continue;
            }
            var_7ce05adf = struct::get(node.target);
            if (isdefined(var_7ce05adf)) {
                var_7ce05adf scene::init();
            }
        }
    }
}

// Namespace aiinteractables/ai_interactables
// Params 1, eflags: 0x0
// Checksum 0x9aa01e5e, Offset: 0x368
// Size: 0xc8
function function_afe8d517(entity) {
    if (entity.archetype !== "human") {
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
    if (!(isdefined(entity.node.interact_node) && entity.node.interact_node)) {
        return false;
    }
    if (isdefined(entity.node.var_dc2c452f)) {
        return false;
    }
    return true;
}

// Namespace aiinteractables/ai_interactables
// Params 1, eflags: 0x4
// Checksum 0x68095cb2, Offset: 0x438
// Size: 0x160
function private function_fc588eec(entity) {
    assert(!(isdefined(entity.node.var_dc2c452f) && entity.node.var_dc2c452f));
    if (isdefined(entity.node.target)) {
        entity pathmode("move delayed", 8);
        entity.node.var_dc2c452f = 1;
        var_7ce05adf = struct::get(entity.node.target);
        var_7ce05adf scene::play(entity);
        var_7ce05adf notify(#"hash_4d2293524fe1c94c", {#ai_interactable:entity});
        if (isalive(entity)) {
            entity notify(#"hash_4d2293524fe1c94c", {#var_39873fb5:var_7ce05adf, #var_b4ed38d8:entity.node});
        }
    }
}

