#using scripts\core_common\ai\archetype_brutus;
#using scripts\core_common\ai\systems\ai_interface;

#namespace brutusinterface;

// Namespace brutusinterface/archetype_brutus_interface
// Params 0, eflags: 0x0
// Checksum 0xb0ef444a, Offset: 0xa8
// Size: 0xbc
function registerbrutusinterfaceattributes() {
    ai::registermatchedinterface("brutus", "can_ground_slam", 0, array(1, 0));
    ai::registermatchedinterface("brutus", "scripted_mode", 0, array(1, 0), &archetypebrutus::function_186daff5);
    ai::registermatchedinterface("brutus", "patrol", 0, array(1, 0));
}

