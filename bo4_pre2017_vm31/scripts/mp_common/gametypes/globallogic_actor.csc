#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace globallogic_actor;

// Namespace globallogic_actor/globallogic_actor
// Params 0, eflags: 0x2
// Checksum 0xb4d6d115, Offset: 0x1d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "globallogic_actor", &__init__, undefined, undefined );
}

// Namespace globallogic_actor/globallogic_actor
// Params 0
// Checksum 0x733efc7b, Offset: 0x218
// Size: 0x22
function __init__()
{
    level._effect[ "rcbombexplosion" ] = "killstreaks/fx_rcxd_exp";
}

