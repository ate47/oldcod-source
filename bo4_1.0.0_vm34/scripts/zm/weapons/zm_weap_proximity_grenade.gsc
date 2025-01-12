#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\weapons\proximity_grenade;

#namespace proximity_grenade;

// Namespace proximity_grenade/zm_weap_proximity_grenade
// Params 0, eflags: 0x2
// Checksum 0x5d3f924f, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"proximity_grenade", &__init__, undefined, undefined);
}

// Namespace proximity_grenade/zm_weap_proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0xb533c653, Offset: 0xd8
// Size: 0x22
function __init__() {
    init_shared();
    level.trackproximitygrenadesonowner = 1;
}

