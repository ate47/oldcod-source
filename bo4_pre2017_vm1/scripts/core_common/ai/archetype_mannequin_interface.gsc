#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/zombie;

#namespace mannequininterface;

// Namespace mannequininterface/archetype_mannequin_interface
// Params 0, eflags: 0x0
// Checksum 0x371bff0, Offset: 0x118
// Size: 0xac
function registermannequininterfaceattributes() {
    ai::registermatchedinterface("mannequin", "can_juke", 0, array(1, 0));
    ai::registermatchedinterface("mannequin", "suicidal_behavior", 0, array(1, 0));
    ai::registermatchedinterface("mannequin", "spark_behavior", 0, array(1, 0));
}

