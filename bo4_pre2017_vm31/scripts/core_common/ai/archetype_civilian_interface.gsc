#using scripts/core_common/ai/archetype_civilian;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_interface;

#namespace civilianinterface;

// Namespace civilianinterface/archetype_civilian_interface
// Params 0, eflags: 0x0
// Checksum 0x5918dcb9, Offset: 0x140
// Size: 0x84
function registercivilianinterfaceattributes() {
    ai::registermatchedinterface("civilian", "disablearrivals", 0, array(1, 0), &aiutility::arrivalattributescallback);
    ai::registermatchedinterface("civilian", "panic", 0, array(1, 0));
}

