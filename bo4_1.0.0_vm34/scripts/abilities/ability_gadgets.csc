#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace ability_gadgets;

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x2
// Checksum 0x95bd6611, Offset: 0xe8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"ability_gadgets", &__init__, undefined, undefined);
}

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x0
// Checksum 0xb046812f, Offset: 0x130
// Size: 0xac
function __init__() {
    clientfield::register("clientuimodel", "huditems.abilityHoldToActivate", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "huditems.abilityDelayProgress", 1, 5, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.abilityHintIndex", 1, 2, "int", undefined, 0, 0);
}

