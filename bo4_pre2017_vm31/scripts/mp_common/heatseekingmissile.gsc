#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/heatseekingmissile;
#using scripts/mp_common/util;

#namespace heatseekingmissile;

// Namespace heatseekingmissile/heatseekingmissile
// Params 0, eflags: 0x2
// Checksum 0x991cf348, Offset: 0x1a0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "heatseekingmissile", &__init__, undefined, undefined );
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 0
// Checksum 0x64291370, Offset: 0x1e0
// Size: 0x34
function __init__()
{
    level.lockoncloserange = 220;
    level.lockoncloseradiusscaler = 1;
    init_shared();
}

