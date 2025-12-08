#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace deathicons;

// Namespace deathicons/deathicons
// Params 0, eflags: 0x6
// Checksum 0x24af6467, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"deathicons", &preinit, undefined, undefined, undefined );
}

// Namespace deathicons/deathicons
// Params 0, eflags: 0x4
// Checksum 0xe3cf5372, Offset: 0xf0
// Size: 0x44
function private preinit()
{
    callback::on_start_gametype( &init );
    callback::on_connect( &on_player_connect );
}

// Namespace deathicons/deathicons
// Params 0
// Checksum 0xfe79596f, Offset: 0x140
// Size: 0x3c
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
// Checksum 0xc1983a5b, Offset: 0x188
// Size: 0xe
function on_player_connect()
{
    self.selfdeathicons = [];
}

// Namespace deathicons/deathicons
// Params 0
// Checksum 0x80f724d1, Offset: 0x1a0
// Size: 0x4
function update_enabled()
{
    
}

// Namespace deathicons/deathicons
// Params 4
// Checksum 0xcfc68a34, Offset: 0x1b0
// Size: 0x19c
function add( entity, dyingplayer, team, timeout )
{
    if ( !level.teambased )
    {
        return;
    }
    
    iconorg = entity.origin;
    dyingplayer endon( #"spawned_player", #"disconnect" );
    waitframe( 1 );
    util::waittillslowprocessallowed();
    assert( isdefined( level.teams[ team ] ) );
    assert( isdefined( level.teamindex[ team ] ) );
    
    if ( !getdvarint( #"ui_hud_showdeathicons", 1 ) )
    {
        return;
    }
    
    if ( level.hardcoremode )
    {
        return;
    }
    
    deathiconobjid = gameobjects::get_next_obj_id();
    objective_add( deathiconobjid, "active", iconorg, #"headicon_dead" );
    objective_setteam( deathiconobjid, team );
    level thread destroy_slowly( timeout, deathiconobjid );
}

// Namespace deathicons/deathicons
// Params 2
// Checksum 0x2eb025a3, Offset: 0x358
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
// Checksum 0xd2946a6d, Offset: 0x3d0
// Size: 0xdc, Type: bool
function ragdoll_override( *idamage, smeansofdeath, *weapon, *shitloc, *vdir, *vattackerorigin, *deathanimduration, *einflictor, *ragdoll_jib, body )
{
    if ( ragdoll_jib == "MOD_FALLING" && self isonground() == 1 )
    {
        body startragdoll();
        
        if ( !isdefined( self.switching_teams ) )
        {
            thread add( body, self, self.team, 5 );
        }
        
        return true;
    }
    
    return false;
}

