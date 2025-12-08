#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/shoutcaster;

#namespace escort;

// Namespace escort/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x5185781a, Offset: 0x220
// Size: 0xbc
function event_handler[GameType_Init] main( eventstruct )
{
    clientfield::register( "actor", "robot_state", 1, 2, "int", &function_76a7d70, 0, 1 );
    clientfield::register( "actor", "escort_robot_burn", 1, 1, "int", &robot_burn, 0, 0 );
    callback::on_localclient_connect( &on_localclient_connect );
}

// Namespace escort/escort
// Params 0
// Checksum 0x80f724d1, Offset: 0x2e8
// Size: 0x4
function onprecachegametype()
{
    
}

// Namespace escort/escort
// Params 0
// Checksum 0x80f724d1, Offset: 0x2f8
// Size: 0x4
function onstartgametype()
{
    
}

// Namespace escort/escort
// Params 1
// Checksum 0x7c0ba4a7, Offset: 0x308
// Size: 0xfc
function on_localclient_connect( localclientnum )
{
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.robotStatusText" ), &"MPUI_ESCORT_ROBOT_MOVING" );
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.robotStatusVisible" ), 0 );
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.enemyRobot" ), 0 );
    level wait_team_changed( localclientnum );
}

// Namespace escort/escort
// Params 7
// Checksum 0x5b0882, Offset: 0x410
// Size: 0xb4
function robot_burn( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self endon( #"death" );
        self util::waittill_dobj( localclientnum );
        fxhandles = playtagfxset( localclientnum, "escort_robot_burn", self );
        self thread watch_fx_shutdown( localclientnum, fxhandles );
    }
}

// Namespace escort/escort
// Params 2
// Checksum 0x8babaa3, Offset: 0x4d0
// Size: 0xa2
function watch_fx_shutdown( localclientnum, fxhandles )
{
    wait 3;
    
    foreach ( fx in fxhandles )
    {
        stopfx( localclientnum, fx );
    }
}

// Namespace escort/escort
// Params 7
// Checksum 0x85fa96e7, Offset: 0x580
// Size: 0x184
function function_76a7d70( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( bnewent )
    {
        if ( !isdefined( level.escortrobots ) )
        {
            level.escortrobots = [];
        }
        else if ( !isarray( level.escortrobots ) )
        {
            level.escortrobots = array( level.escortrobots );
        }
        
        level.escortrobots[ level.escortrobots.size ] = self;
        self thread update_robot_team( localclientnum );
    }
    
    if ( newval == 1 )
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.robotStatusVisible" ), 1 );
        return;
    }
    
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.robotStatusVisible" ), 0 );
}

// Namespace escort/escort
// Params 1
// Checksum 0xaf28897d, Offset: 0x710
// Size: 0xf6
function wait_team_changed( localclientnum )
{
    while ( true )
    {
        level waittill( "team_changed" );
        
        while ( !isdefined( getnonpredictedlocalplayer( localclientnum ) ) )
        {
            waitframe( 1 );
        }
        
        if ( !isdefined( level.escortrobots ) )
        {
            continue;
        }
        
        foreach ( robot in level.escortrobots )
        {
            robot thread update_robot_team( localclientnum );
        }
    }
}

// Namespace escort/escort
// Params 1
// Checksum 0x6fb7697, Offset: 0x810
// Size: 0x174
function update_robot_team( localclientnum )
{
    localplayerteam = getlocalplayerteam( localclientnum );
    
    if ( shoutcaster::is_shoutcaster( localclientnum ) )
    {
        friend = self shoutcaster::is_friendly( localclientnum );
    }
    else
    {
        friend = self.team == localplayerteam;
    }
    
    if ( friend )
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.enemyRobot" ), 0 );
    }
    else
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.enemyRobot" ), 1 );
    }
    
    self duplicate_render::set_dr_flag( "enemyvehicle_fb", !friend );
    localplayer = getlocalplayer( localclientnum );
    localplayer duplicate_render::update_dr_filters( localclientnum );
}

