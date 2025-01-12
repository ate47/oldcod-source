#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/zombie;

#namespace zombieinterface;

// Namespace zombieinterface/archetype_zombie_interface
// Params 0, eflags: 0x0
// Checksum 0x1aff404d, Offset: 0x120
// Size: 0xe4
function registerzombieinterfaceattributes() {
    ai::registermatchedinterface("zombie", "can_juke", 0, array(1, 0));
    ai::registermatchedinterface("zombie", "suicidal_behavior", 0, array(1, 0));
    ai::registermatchedinterface("zombie", "spark_behavior", 0, array(1, 0));
    ai::registermatchedinterface("zombie", "use_attackable", 0, array(1, 0));
}

