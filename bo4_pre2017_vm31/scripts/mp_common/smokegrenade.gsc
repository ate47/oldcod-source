#using scripts/core_common/callbacks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/smokegrenade;
#using scripts/mp_common/util;

#namespace smokegrenade;

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x2
// Checksum 0x7a76b2df, Offset: 0x188
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "smokegrenade", &__init__, undefined, undefined );
}

// Namespace smokegrenade/smokegrenade
// Params 0
// Checksum 0x90cd1d62, Offset: 0x1c8
// Size: 0x14
function __init__()
{
    init_shared();
}

