#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/proximity_grenade;
#using scripts/mp_common/killstreaks/killstreak_hacking;

#namespace killstreak_detect;

// Namespace killstreak_detect/killstreak_detect
// Params 0, eflags: 0x2
// Checksum 0x15a5053b, Offset: 0x218
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "killstreak_detect", &__init__, undefined, undefined );
}

// Namespace killstreak_detect/killstreak_detect
// Params 0
// Checksum 0x431b1dca, Offset: 0x258
// Size: 0x124
function __init__()
{
    clientfield::register( "vehicle", "enemyvehicle", 1, 2, "int" );
    clientfield::register( "scriptmover", "enemyvehicle", 1, 2, "int" );
    clientfield::register( "helicopter", "enemyvehicle", 1, 2, "int" );
    clientfield::register( "missile", "enemyvehicle", 1, 2, "int" );
    clientfield::register( "actor", "enemyvehicle", 1, 2, "int" );
    clientfield::register( "vehicle", "vehicletransition", 1, 1, "int" );
}

// Namespace killstreak_detect/killstreak_detect
// Params 2
// Checksum 0xe8954f3b, Offset: 0x388
// Size: 0x6c
function killstreaktargetset( killstreakentity, offset )
{
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    target_set( killstreakentity, offset );
    
    /#
        killstreakentity thread killstreak_hacking::killstreak_switch_team( killstreakentity.owner );
    #/
}

// Namespace killstreak_detect/killstreak_detect
// Params 1
// Checksum 0x3ad04f6a, Offset: 0x400
// Size: 0x3c
function killstreaktargetclear( killstreakentity )
{
    target_remove( killstreakentity );
    
    /#
        killstreakentity thread killstreak_hacking::killstreak_switch_team_end();
    #/
}

