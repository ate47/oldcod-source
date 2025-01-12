#using scripts\core_common\ai\archetype_stoker;
#using scripts\core_common\ai\systems\ai_interface;

#namespace stokerinterface;

// Namespace stokerinterface/archetype_stoker_interface
// Params 0, eflags: 0x0
// Checksum 0xf3c46a77, Offset: 0x98
// Size: 0x5c
function registerstokerinterfaceattributes() {
    ai::registermatchedinterface("stoker", "gravity", "normal", array("low", "normal"), &archetype_stoker::function_d9cde0cf);
}

