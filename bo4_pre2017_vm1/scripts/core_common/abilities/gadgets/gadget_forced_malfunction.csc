#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_forced_malfunction;

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 0, eflags: 0x2
// Checksum 0x8a6f71b6, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_forced_malfunction", &__init__, undefined, undefined);
}

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x270
// Size: 0x4
function __init__() {
    
}

