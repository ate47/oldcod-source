#using scripts/core_common/ai/archetype_human_riotshield;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_interface;

#namespace namespace_cbd97d62;

// Namespace namespace_cbd97d62/archetype_human_riotshield_interface
// Params 0, eflags: 0x0
// Checksum 0x190c1785, Offset: 0x1c8
// Size: 0x21c
function function_8f5cbafa() {
    ai::registermatchedinterface("human_riotshield", "can_be_meleed", 1, array(1, 0), &aiutility::meleeattributescallback);
    ai::registermatchedinterface("human_riotshield", "can_melee", 1, array(1, 0), &aiutility::meleeattributescallback);
    ai::registermatchedinterface("human_riotshield", "can_initiateaivsaimelee", 1, array(1, 0));
    ai::registermatchedinterface("human_riotshield", "coverIdleOnly", 0, array(1, 0));
    ai::registermatchedinterface("human_riotshield", "phalanx", 0, array(1, 0), &aiutility::phalanxattributecallback);
    ai::registermatchedinterface("human_riotshield", "phalanx_force_stance", "normal", array("normal", "stand", "crouch"));
    ai::registermatchedinterface("human_riotshield", "sprint", 0, array(1, 0));
    ai::registermatchedinterface("human_riotshield", "attack_mode", "normal", array("normal", "unarmed"));
}

