#using scripts/core_common/ai/behavior_zombie_dog;
#using scripts/core_common/ai/systems/ai_interface;

#namespace namespace_273d1a1c;

// Namespace namespace_273d1a1c/archetype_zombie_dog_interface
// Params 0, eflags: 0x0
// Checksum 0x315bd821, Offset: 0x128
// Size: 0xbc
function registerzombiedoginterfaceattributes() {
    ai::registermatchedinterface("zombie_dog", "gravity", "normal", array("low", "normal"), &namespace_1db6d2c9::zombiedoggravity);
    ai::registermatchedinterface("zombie_dog", "min_run_dist", 500);
    ai::registermatchedinterface("zombie_dog", "sprint", 0, array(1, 0));
}

