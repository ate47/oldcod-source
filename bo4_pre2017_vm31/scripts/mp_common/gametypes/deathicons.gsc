#using scripts/core_common/callbacks_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/globallogic_utils;

#namespace deathicons;

// Namespace deathicons/deathicons
// Params 0, eflags: 0x2
// Checksum 0x61cfa5bc, Offset: 0x1d0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "deathicons", &__init__, undefined, undefined );
}

// Namespace deathicons/deathicons
// Params 0
// Checksum 0x64a44a06, Offset: 0x210
// Size: 0x44
function __init__()
{
    callback::on_start_gametype( &init );
    callback::on_connect( &on_player_connect );
}

// Namespace deathicons/deathicons
// Params 0
// Checksum 0x128b3575, Offset: 0x260
// Size: 0x40
function init()
{
    if ( !isdefined( level.ragdoll_override ) )
    {
        level.ragdoll_override = &ragdoll_override;
    }
    
    if ( !level.teambased )
    {
        return;
    }
}

// Namespace deathicons/deathicons
// Params 0
// Checksum 0xcc457995, Offset: 0x2a8
// Size: 0x10
function on_player_connect()
{
    self.selfdeathicons = [];
}

// Namespace deathicons/deathicons
// Params 0
// Checksum 0x80f724d1, Offset: 0x2c0
// Size: 0x4
function update_enabled()
{
    
}

// Namespace deathicons/deathicons
// Params 3
// Checksum 0x6bd821fc, Offset: 0x2d0
// Size: 0x1e4
function add( entity, dyingplayer, team )
{
    if ( !level.teambased )
    {
        return;
    }
    
    timeout = getdvarfloat( "scr_deathicon_time", 5 );
    iconorg = entity.origin;
    dyingplayer endon( #"spawned_player" );
    dyingplayer endon( #"disconnect" );
    waitframe( 1 );
    util::waittillslowprocessallowed();
    assert( isdefined( level.teams[ team ] ) );
    assert( isdefined( level.teamindex[ team ] ) );
    
    if ( getdvarstring( "ui_hud_showdeathicons" ) == "0" )
    {
        return;
    }
    
    if ( level.hardcoremode )
    {
        return;
    }
    
    deathiconobjid = gameobjects::get_next_obj_id();
    objective_add( deathiconobjid, "active", iconorg, &"headicon_dead" );
    objective_setteam( deathiconobjid, team );
    objective_visibleteams( deathiconobjid, level.spawnsystem.ispawn_teammask[ team ] );
    level thread destroy_slowly( timeout, deathiconobjid );
}

// Namespace deathicons/deathicons
// Params 2
// Checksum 0xafd4413e, Offset: 0x4c0
// Size: 0x6c
function destroy_slowly( timeout, deathiconobjid )
{
    wait timeout;
    objective_setstate( deathiconobjid, "done" );
    wait 1;
    objective_delete( deathiconobjid );
    gameobjects::release_obj_id( deathiconobjid );
}

// Namespace deathicons/deathicons
// Params 10
// Checksum 0x233edb8a, Offset: 0x538
// Size: 0xd4, Type: bool
function ragdoll_override( idamage, smeansofdeath, sweapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body )
{
    if ( smeansofdeath == "MOD_FALLING" && self isonground() == 1 )
    {
        body startragdoll();
        
        if ( !isdefined( self.switching_teams ) )
        {
            thread add( body, self, self.team );
        }
        
        return true;
    }
    
    return false;
}

