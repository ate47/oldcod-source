#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace dom;

// Namespace dom/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0xbfd76aed, Offset: 0x1c0
// Size: 0x6c
function event_handler[GameType_Init] main( eventstruct )
{
    callback::on_localclient_connect( &on_localclient_connect );
    
    if ( getgametypesetting( "silentPlant" ) != 0 )
    {
        setsoundcontext( "bomb_plant", "silent" );
    }
}

// Namespace dom/dom
// Params 1
// Checksum 0x308cdba6, Offset: 0x238
// Size: 0x15a
function on_localclient_connect( localclientnum )
{
    self.domflags = [];
    
    while ( !isdefined( level.domflags[ "a" ] ) )
    {
        self.domflags[ "a" ] = serverobjective_getobjective( localclientnum, "dom_a" );
        self.domflags[ "b" ] = serverobjective_getobjective( localclientnum, "dom_b" );
        self.domflags[ "c" ] = serverobjective_getobjective( localclientnum, "dom_c" );
        waitframe( 1 );
    }
    
    foreach ( key, flag_objective in self.domflags )
    {
        self thread monitor_flag_fx( localclientnum, flag_objective, key );
    }
}

// Namespace dom/dom
// Params 3
// Checksum 0x949a4753, Offset: 0x3a0
// Size: 0x246
function monitor_flag_fx( localclientnum, flag_objective, flag_name )
{
    if ( !isdefined( flag_objective ) )
    {
        return;
    }
    
    flag = spawnstruct();
    flag.name = flag_name;
    flag.objectiveid = flag_objective;
    flag.origin = serverobjective_getobjectiveorigin( localclientnum, flag_objective );
    flag.angles = ( 0, 0, 0 );
    flag_entity = serverobjective_getobjectiveentity( localclientnum, flag_objective );
    
    if ( isdefined( flag_entity ) )
    {
        flag.origin = flag_entity.origin;
        flag.angles = flag_entity.angles;
    }
    
    fx_name = get_base_fx( flag, "neutral" );
    play_base_fx( localclientnum, flag, fx_name, "neutral" );
    flag.last_progress = 0;
    
    while ( true )
    {
        team = serverobjective_getobjectiveteam( localclientnum, flag_objective );
        
        if ( team != flag.last_team )
        {
            flag update_base_fx( localclientnum, flag, team );
        }
        
        progress = serverobjective_getobjectiveprogress( localclientnum, flag_objective ) > 0;
        
        if ( progress != flag.last_progress )
        {
            flag update_cap_fx( localclientnum, flag, team, progress );
        }
        
        waitframe( 1 );
    }
}

// Namespace dom/dom
// Params 4
// Checksum 0x517ddccc, Offset: 0x5f0
// Size: 0x120
function play_base_fx( localclientnum, flag, fx_name, team )
{
    if ( isdefined( flag.base_fx ) )
    {
        stopfx( localclientnum, flag.base_fx );
    }
    
    up = anglestoup( flag.angles );
    forward = anglestoforward( flag.angles );
    flag.base_fx = playfx( localclientnum, fx_name, flag.origin, up, forward );
    setfxteam( localclientnum, flag.base_fx, team );
    flag.last_team = team;
}

// Namespace dom/dom
// Params 3
// Checksum 0x1e8066a5, Offset: 0x718
// Size: 0xf0
function update_base_fx( localclientnum, flag, team )
{
    fx_name = get_base_fx( flag, team );
    
    if ( team == "neutral" )
    {
        play_base_fx( localclientnum, flag, fx_name, team );
        return;
    }
    
    if ( flag.last_team == "neutral" )
    {
        play_base_fx( localclientnum, flag, fx_name, team );
        return;
    }
    
    setfxteam( localclientnum, flag.base_fx, team );
    flag.last_team = team;
}

// Namespace dom/dom
// Params 4
// Checksum 0xf139c834, Offset: 0x810
// Size: 0x10c
function play_cap_fx( localclientnum, flag, fx_name, team )
{
    if ( isdefined( flag.cap_fx ) )
    {
        killfx( localclientnum, flag.cap_fx );
    }
    
    up = anglestoup( flag.angles );
    forward = anglestoforward( flag.angles );
    flag.cap_fx = playfx( localclientnum, fx_name, flag.origin, up, forward );
    setfxteam( localclientnum, flag.cap_fx, team );
}

// Namespace dom/dom
// Params 4
// Checksum 0x2910dd7a, Offset: 0x928
// Size: 0xd8
function update_cap_fx( localclientnum, flag, team, progress )
{
    if ( progress == 0 )
    {
        if ( isdefined( flag.cap_fx ) )
        {
            killfx( localclientnum, flag.cap_fx );
        }
        
        flag.last_progress = progress;
        return;
    }
    
    fx_name = get_cap_fx( flag, team );
    play_cap_fx( localclientnum, flag, fx_name, team );
    flag.last_progress = progress;
}

// Namespace dom/dom
// Params 2
// Checksum 0x4a6f2126, Offset: 0xa08
// Size: 0x80
function get_base_fx( flag, team )
{
    if ( isdefined( level.domflagbasefxoverride ) )
    {
        fx = [[ level.domflagbasefxoverride ]]( flag, team );
        
        if ( isdefined( fx ) )
        {
            return fx;
        }
    }
    
    if ( team == "neutral" )
    {
        return "ui/fx_dom_marker_neutral";
    }
    
    return "ui/fx_dom_marker_team";
}

// Namespace dom/dom
// Params 2
// Checksum 0x4bb9d258, Offset: 0xa90
// Size: 0x80
function get_cap_fx( flag, team )
{
    if ( isdefined( level.domflagcapfxoverride ) )
    {
        fx = [[ level.domflagcapfxoverride ]]( flag, team );
        
        if ( isdefined( fx ) )
        {
            return fx;
        }
    }
    
    if ( team == "neutral" )
    {
        return "ui/fx_dom_cap_indicator_neutral";
    }
    
    return "ui/fx_dom_cap_indicator_team";
}

