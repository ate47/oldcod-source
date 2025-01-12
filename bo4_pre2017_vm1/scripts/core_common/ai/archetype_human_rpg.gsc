#using scripts/core_common/ai/archetype_cover_utility;
#using scripts/core_common/ai/archetype_human_rpg_interface;
#using scripts/core_common/ai/archetype_locomotion_utility;
#using scripts/core_common/ai/archetype_mocomps_utility;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/animation_state_machine_mocomp;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/debug;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai/systems/shared;
#using scripts/core_common/ai/zombie_utility;
#using scripts/core_common/ai_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawner_shared;

#namespace archetype_human_rpg;

// Namespace archetype_human_rpg/archetype_human_rpg
// Params 0, eflags: 0x2
// Checksum 0x34f88a64, Offset: 0x3f0
// Size: 0x4c
function autoexec main() {
    spawner::add_archetype_spawn_function("human_rpg", &humanrpgbehavior::archetypehumanrpgblackboardinit);
    humanrpgbehavior::registerbehaviorscriptfunctions();
    humanrpginterface::registerhumanrpginterfaceattributes();
}

#namespace humanrpgbehavior;

// Namespace humanrpgbehavior/archetype_human_rpg
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x448
// Size: 0x4
function registerbehaviorscriptfunctions() {
    
}

// Namespace humanrpgbehavior/archetype_human_rpg
// Params 0, eflags: 0x4
// Checksum 0xec27fb7b, Offset: 0x458
// Size: 0x74
function private archetypehumanrpgblackboardinit() {
    entity = self;
    blackboard::createblackboardforentity(entity);
    ai::createinterfaceforentity(entity);
    self.___archetypeonanimscriptedcallback = &archetypehumanrpgonanimscriptedcallback;
    entity asmchangeanimmappingtable(1);
}

// Namespace humanrpgbehavior/archetype_human_rpg
// Params 1, eflags: 0x4
// Checksum 0x44c12b48, Offset: 0x4d8
// Size: 0x34
function private archetypehumanrpgonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypehumanrpgblackboardinit();
}

