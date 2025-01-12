#using scripts\core_common\ai\archetype_tiger;
#using scripts\core_common\ai\systems\ai_interface;

#namespace tigerinterface;

// Namespace tigerinterface/archetype_tiger_interface
// Params 0, eflags: 0x0
// Checksum 0x86fff7e2, Offset: 0xa8
// Size: 0xbc
function registertigerinterfaceattributes() {
    ai::registermatchedinterface("tiger", "gravity", "normal", array("low", "normal"), &tigerbehavior::function_ecba8a0c);
    ai::registermatchedinterface("tiger", "min_run_dist", 500);
    ai::registermatchedinterface("tiger", "sprint", 0, array(1, 0));
}

