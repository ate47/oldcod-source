#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/core_common/weapons_shared;
#using scripts/mp_common/util;

#namespace weaponobjects;

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x2
// Checksum 0x56eaca8c, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "weaponobjects", &__init__, undefined, undefined );
}

// Namespace weaponobjects/weaponobjects
// Params 0
// Checksum 0x6ab92446, Offset: 0x240
// Size: 0x34
function __init__()
{
    init_shared();
    callback::on_start_gametype( &start_gametype );
}

// Namespace weaponobjects/weaponobjects
// Params 0
// Checksum 0x83179f5d, Offset: 0x280
// Size: 0x44
function start_gametype()
{
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
}

// Namespace weaponobjects/weaponobjects
// Params 0
// Checksum 0x480ac20b, Offset: 0x2d0
// Size: 0x24
function on_player_spawned()
{
    self createspikelauncherwatcher( "hero_spike_launcher" );
}

