#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/hive_gun;
#using scripts/mp_common/util;

#namespace hive_gun;

// Namespace hive_gun/hive_gun
// Params 0, eflags: 0x2
// Checksum 0xef18c6fa, Offset: 0x188
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "hive_gun", &__init__, undefined, undefined );
}

// Namespace hive_gun/hive_gun
// Params 0
// Checksum 0x10fb0a30, Offset: 0x1c8
// Size: 0x14
function __init__()
{
    init_shared();
}

