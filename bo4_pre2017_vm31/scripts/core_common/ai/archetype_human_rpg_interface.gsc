#using scripts/core_common/ai/archetype_human_rpg;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_interface;

#namespace humanrpginterface;

// Namespace humanrpginterface/archetype_human_rpg_interface
// Params 0, eflags: 0x0
// Checksum 0xfc9706b0, Offset: 0x160
// Size: 0x13c
function registerhumanrpginterfaceattributes() {
    ai::registermatchedinterface("human_rpg", "can_be_meleed", 1, array(1, 0), &aiutility::meleeattributescallback);
    ai::registermatchedinterface("human_rpg", "can_melee", 1, array(1, 0), &aiutility::meleeattributescallback);
    ai::registermatchedinterface("human_rpg", "coverIdleOnly", 0, array(1, 0));
    ai::registermatchedinterface("human_rpg", "sprint", 0, array(1, 0));
    ai::registermatchedinterface("human_rpg", "patrol", 0, array(1, 0));
}

