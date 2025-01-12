#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\zombie;

#namespace catalystinterface;

// Namespace catalystinterface/archetype_catalyst_interface
// Params 0, eflags: 0x0
// Checksum 0xbda42372, Offset: 0x98
// Size: 0x5c
function registercatalystinterfaceattributes() {
    ai::registermatchedinterface("catalyst", "gravity", "normal", array("low", "normal"), &zombiebehavior::zombiegravity);
}

