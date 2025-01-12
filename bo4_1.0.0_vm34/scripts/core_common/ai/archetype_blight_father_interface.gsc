#using scripts\core_common\ai\archetype_blight_father;
#using scripts\core_common\ai\systems\ai_interface;

#namespace blightfatherinterface;

// Namespace blightfatherinterface/archetype_blight_father_interface
// Params 0, eflags: 0x0
// Checksum 0x74ed87a7, Offset: 0xc0
// Size: 0xdc
function registerblightfatherinterfaceattributes() {
    ai::registermatchedinterface("blight_father", "tongue_grab_enabled", 1, array(1, 0));
    ai::registermatchedinterface("blight_father", "lockdown_enabled", 1, array(1, 0), &archetypeblightfather::function_355b7d09);
    ai::registermatchedinterface("blight_father", "gravity", "normal", array("low", "normal"), &archetypeblightfather::function_723e62dd);
}

