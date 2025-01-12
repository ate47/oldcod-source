#using scripts\core_common\ai\systems\ai_interface;
#using scripts\zm\ai\zm_ai_dog;

#namespace zm_ai_dog_interface;

// Namespace zm_ai_dog_interface/zm_ai_dog_interface
// Params 0, eflags: 0x0
// Checksum 0xcc06111f, Offset: 0xb8
// Size: 0xf4
function registerzombiedoginterfaceattributes() {
    ai::registermatchedinterface("zombie_dog", "gravity", "normal", array("low", "normal"), &zm_ai_dog::zombiedoggravity);
    ai::registermatchedinterface("zombie_dog", "min_run_dist", 500);
    ai::registermatchedinterface("zombie_dog", "sprint", 0, array(1, 0));
    ai::registermatchedinterface("zombie_dog", "patrol", 0, array(1, 0));
}

