#using scripts/core_common/ai/archetype_civilian_interface;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_state_machine;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai_shared;
#using scripts/core_common/spawner_shared;

#namespace archetype_civilian;

// Namespace archetype_civilian/archetype_civilian
// Params 0, eflags: 0x2
// Checksum 0x8f793584, Offset: 0x328
// Size: 0x24
function autoexec main() {
    archetypecivilian::registerbehaviorscriptfunctions();
    civilianinterface::registercivilianinterfaceattributes();
}

#namespace archetypecivilian;

// Namespace archetypecivilian/archetype_civilian
// Params 0, eflags: 0x0
// Checksum 0x986bf2ac, Offset: 0x358
// Size: 0x314
function registerbehaviorscriptfunctions() {
    spawner::add_archetype_spawn_function("civilian", &civilianblackboardinit);
    spawner::add_archetype_spawn_function("civilian", &function_f0d98b47);
    assert(!isdefined(&civilianmoveactioninitialize) || isscriptfunctionptr(&civilianmoveactioninitialize));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&civilianmoveactionfinalize) || isscriptfunctionptr(&civilianmoveactionfinalize));
    behaviortreenetworkutility::registerbehaviortreeaction("civilianMoveAction", &civilianmoveactioninitialize, undefined, &civilianmoveactionfinalize);
    assert(!isdefined(&function_d752eb0e) || isscriptfunctionptr(&function_d752eb0e));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction("civilianCowerAction", &function_d752eb0e, undefined, undefined);
    assert(isscriptfunctionptr(&civilianispanicked));
    behaviortreenetworkutility::registerbehaviortreescriptapi("civilianIsPanicked", &civilianispanicked);
    assert(isscriptfunctionptr(&civilianarrivalallowed));
    behaviorstatemachine::registerbsmscriptapiinternal("civilianArrivalAllowed", &civilianarrivalallowed);
}

// Namespace archetypecivilian/archetype_civilian
// Params 0, eflags: 0x4
// Checksum 0xea8145c2, Offset: 0x678
// Size: 0x4c
function private civilianblackboardinit() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &civilianonanimscriptedcallback;
}

// Namespace archetypecivilian/archetype_civilian
// Params 0, eflags: 0x4
// Checksum 0xfd2201c8, Offset: 0x6d0
// Size: 0xbc
function private function_f0d98b47() {
    entity = self;
    locomotiontypes = array("alt1", "alt2", "alt3", "alt4");
    altindex = entity getentitynumber() % locomotiontypes.size;
    entity setblackboardattribute("_human_locomotion_variation", locomotiontypes[altindex]);
    entity setavoidancemask("avoid ai");
}

// Namespace archetypecivilian/archetype_civilian
// Params 1, eflags: 0x4
// Checksum 0xcf58cbc8, Offset: 0x798
// Size: 0x34
function private civilianonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity civilianblackboardinit();
}

// Namespace archetypecivilian/archetype_civilian
// Params 2, eflags: 0x4
// Checksum 0x6bf2e1a9, Offset: 0x7d8
// Size: 0x58
function private civilianmoveactioninitialize(entity, asmstatename) {
    entity setblackboardattribute("_desired_stance", "stand");
    animationstatenetworkutility::requeststate(entity, asmstatename);
    return 5;
}

// Namespace archetypecivilian/archetype_civilian
// Params 2, eflags: 0x4
// Checksum 0xf958b204, Offset: 0x838
// Size: 0x68
function private civilianmoveactionfinalize(entity, asmstatename) {
    if (entity getblackboardattribute("_stance") != "stand") {
        entity setblackboardattribute("_desired_stance", "stand");
    }
    return 4;
}

// Namespace archetypecivilian/archetype_civilian
// Params 2, eflags: 0x4
// Checksum 0x1fb976a3, Offset: 0x8a8
// Size: 0xc8
function private function_d752eb0e(entity, asmstatename) {
    if (isdefined(entity.node)) {
        higheststance = aiutility::gethighestnodestance(entity.node);
        if (higheststance == "crouch") {
            entity setblackboardattribute("_stance", "crouch");
        } else {
            entity setblackboardattribute("_stance", "stand");
        }
    }
    animationstatenetworkutility::requeststate(entity, asmstatename);
    return 5;
}

// Namespace archetypecivilian/archetype_civilian
// Params 1, eflags: 0x4
// Checksum 0xac0b1950, Offset: 0x978
// Size: 0x34
function private civilianispanicked(entity) {
    return entity getblackboardattribute("_panic") == "panic";
}

// Namespace archetypecivilian/archetype_civilian
// Params 0, eflags: 0x4
// Checksum 0xb71c2970, Offset: 0x9b8
// Size: 0x36
function private function_e0be6cd5() {
    if (ai::getaiattribute(self, "panic")) {
        return "panic";
    }
    return "calm";
}

// Namespace archetypecivilian/archetype_civilian
// Params 1, eflags: 0x4
// Checksum 0xdf405b27, Offset: 0x9f8
// Size: 0x36
function private civilianarrivalallowed(entity) {
    if (ai::getaiattribute(entity, "disablearrivals")) {
        return false;
    }
    return true;
}

