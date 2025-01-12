#using scripts\core_common\ai\systems\ai_interface;
#using scripts\zm\ai\zm_ai_gladiator;

#namespace zm_ai_gladiator_interface;

// Namespace zm_ai_gladiator_interface/zm_ai_gladiator_interface
// Params 0, eflags: 0x0
// Checksum 0xc3a1b460, Offset: 0xa8
// Size: 0xa4
function registergladiatorinterfaceattributes() {
    ai::registermatchedinterface("gladiator", "run", 0, array(1, 0));
    ai::registermatchedinterface("gladiator", "axe_throw", 1, array(1, 0));
    ai::registernumericinterface("gladiator", "damage_multiplier", 1, 0, 100);
}

