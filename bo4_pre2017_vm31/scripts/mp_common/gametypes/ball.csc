#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/shoutcaster;

#namespace ball;

// Namespace ball/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x25816627, Offset: 0x390
// Size: 0x24a
function event_handler[GameType_Init] main( eventstruct )
{
    clientfield::register( "allplayers", "ballcarrier", 1, 1, "int", &function_5354f213, 0, 1 );
    clientfield::register( "allplayers", "passoption", 1, 1, "int", &function_8dc589c8, 0, 0 );
    clientfield::register( "world", "ball_away", 1, 1, "int", &function_c27acbbf, 0, 1 );
    clientfield::register( "world", "ball_score_allies", 1, 1, "int", &function_fe891abf, 0, 1 );
    clientfield::register( "world", "ball_score_axis", 1, 1, "int", &function_7d1a6e7e, 0, 1 );
    callback::on_localclient_connect( &on_localclient_connect );
    callback::on_spawned( &on_player_spawned );
    
    if ( !getdvarint( "tu11_programaticallyColoredGameFX" ) )
    {
        level.effect_scriptbundles = [];
        level.effect_scriptbundles[ "goal" ] = struct::get_script_bundle( "teamcolorfx", "teamcolorfx_uplink_goal" );
        level.effect_scriptbundles[ "goal_score" ] = struct::get_script_bundle( "teamcolorfx", "teamcolorfx_uplink_goal_score" );
    }
}

// Namespace ball/ball
// Params 1
// Checksum 0x99a6b6af, Offset: 0x5e8
// Size: 0x184
function on_localclient_connect( localclientnum )
{
    var_1d2359d9 = [];
    
    while ( !isdefined( var_1d2359d9[ "allies" ] ) )
    {
        var_1d2359d9[ "allies" ] = serverobjective_getobjective( localclientnum, "ball_goal_allies" );
        var_1d2359d9[ "axis" ] = serverobjective_getobjective( localclientnum, "ball_goal_axis" );
        waitframe( 1 );
    }
    
    foreach ( key, objective in var_1d2359d9 )
    {
        level.goals[ key ] = spawnstruct();
        level.goals[ key ].objectiveid = objective;
        function_b22de10a( localclientnum, level.goals[ key ] );
    }
    
    function_45876c81( localclientnum );
}

// Namespace ball/ball
// Params 1
// Checksum 0x93775f74, Offset: 0x778
// Size: 0xe2
function on_player_spawned( localclientnum )
{
    players = getplayers( localclientnum );
    
    foreach ( player in players )
    {
        if ( player util::isenemyplayer( self ) )
        {
            player duplicate_render::update_dr_flag( localclientnum, "ballcarrier", 0 );
        }
    }
}

// Namespace ball/ball
// Params 2
// Checksum 0xc10af1f6, Offset: 0x868
// Size: 0xc0
function function_b22de10a( localclientnum, goal )
{
    goal.origin = serverobjective_getobjectiveorigin( localclientnum, goal.objectiveid );
    goal_entity = serverobjective_getobjectiveentity( localclientnum, goal.objectiveid );
    
    if ( isdefined( goal_entity ) )
    {
        goal.origin = goal_entity.origin;
    }
    
    goal.team = serverobjective_getobjectiveteam( localclientnum, goal.objectiveid );
}

// Namespace ball/ball
// Params 3
// Checksum 0x5602f5cb, Offset: 0x930
// Size: 0xc4
function function_2182aedf( localclientnum, goal, effects )
{
    if ( isdefined( goal.base_fx ) )
    {
        stopfx( localclientnum, goal.base_fx );
    }
    
    goal.base_fx = playfx( localclientnum, effects[ goal.team ], goal.origin );
    setfxteam( localclientnum, goal.base_fx, goal.team );
}

// Namespace ball/ball
// Params 1
// Checksum 0x4fbde581, Offset: 0xa00
// Size: 0x1b4
function function_45876c81( localclientnum )
{
    effects = [];
    
    if ( shoutcaster::is_shoutcaster_using_team_identity( localclientnum ) )
    {
        if ( getdvarint( "tu11_programaticallyColoredGameFX" ) )
        {
            effects[ "allies" ] = "ui/fx_uplink_goal_marker_white";
            effects[ "axis" ] = "ui/fx_uplink_goal_marker_white";
        }
        else
        {
            effects = shoutcaster::get_color_fx( localclientnum, level.effect_scriptbundles[ "goal" ] );
        }
    }
    else
    {
        effects[ "allies" ] = "ui/fx_uplink_goal_marker";
        effects[ "axis" ] = "ui/fx_uplink_goal_marker";
    }
    
    foreach ( goal in level.goals )
    {
        thread function_2182aedf( localclientnum, goal, effects );
        thread resetondemojump( localclientnum, goal, effects );
    }
    
    thread watch_for_team_change( localclientnum );
}

// Namespace ball/ball
// Params 2
// Checksum 0x5009da18, Offset: 0xbc0
// Size: 0x154
function function_ea2fff95( localclientnum, goal )
{
    effects = [];
    
    if ( shoutcaster::is_shoutcaster_using_team_identity( localclientnum ) )
    {
        if ( getdvarint( "tu11_programaticallyColoredGameFX" ) )
        {
            effects[ "allies" ] = "ui/fx_uplink_goal_marker_white_flash";
            effects[ "axis" ] = "ui/fx_uplink_goal_marker_white_flash";
        }
        else
        {
            effects = shoutcaster::get_color_fx( localclientnum, level.effect_scriptbundles[ "goal_score" ] );
        }
    }
    else
    {
        effects[ "allies" ] = "ui/fx_uplink_goal_marker_flash";
        effects[ "axis" ] = "ui/fx_uplink_goal_marker_flash";
    }
    
    fx_handle = playfx( localclientnum, effects[ goal.team ], goal.origin );
    setfxteam( localclientnum, fx_handle, goal.team );
}

// Namespace ball/ball
// Params 6
// Checksum 0xbaa7372c, Offset: 0xd20
// Size: 0x7c
function function_85e74fc9( localclientnum, team, oldval, newval, binitialsnap, bwastimejump )
{
    if ( newval != oldval && !binitialsnap && !bwastimejump )
    {
        function_ea2fff95( localclientnum, level.goals[ team ] );
    }
}

// Namespace ball/ball
// Params 7
// Checksum 0xae02020, Offset: 0xda8
// Size: 0x6c
function function_fe891abf( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_85e74fc9( localclientnum, "allies", oldval, newval, binitialsnap, bwastimejump );
}

// Namespace ball/ball
// Params 7
// Checksum 0xf4a5d77d, Offset: 0xe20
// Size: 0x6c
function function_7d1a6e7e( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_85e74fc9( localclientnum, "axis", oldval, newval, binitialsnap, bwastimejump );
}

// Namespace ball/ball
// Params 7
// Checksum 0xefc326a1, Offset: 0xe98
// Size: 0x19c
function function_5354f213( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    localplayer = getlocalplayer( localclientnum );
    
    if ( localplayer == self )
    {
        if ( newval )
        {
            self.var_25281d17 = 1;
        }
        else
        {
            self.var_25281d17 = 0;
            setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.passOption" ), 0 );
        }
    }
    
    if ( localplayer != self && self isfriendly( localclientnum ) )
    {
        self function_235fe967( localclientnum, newval );
    }
    else
    {
        self function_235fe967( localclientnum, 0 );
    }
    
    if ( isdefined( level.var_300a2507 ) && level.var_300a2507 != self )
    {
        return;
    }
    
    level notify( #"watch_for_death" );
    
    if ( newval == 1 )
    {
        self thread watch_for_death( localclientnum );
    }
}

// Namespace ball/ball
// Params 1
// Checksum 0xe9404673, Offset: 0x1040
// Size: 0x24c
function function_b95d5759( localclientnum )
{
    level.var_300a2507 = self;
    
    if ( shoutcaster::is_shoutcaster( localclientnum ) )
    {
        friendly = self shoutcaster::is_friendly( localclientnum );
    }
    else
    {
        friendly = self isfriendly( localclientnum );
    }
    
    if ( isdefined( self.name ) )
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballStatusText" ), self.name );
    }
    else
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballStatusText" ), "" );
    }
    
    if ( isdefined( friendly ) )
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByFriendly" ), friendly );
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByEnemy" ), !friendly );
        return;
    }
    
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByFriendly" ), 0 );
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByEnemy" ), 0 );
}

// Namespace ball/ball
// Params 1
// Checksum 0xb6ae9df0, Offset: 0x1298
// Size: 0xec
function clear_hud( localclientnum )
{
    level.var_300a2507 = undefined;
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByEnemy" ), 0 );
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByFriendly" ), 0 );
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballStatusText" ), &"MPUI_BALL_AWAY" );
}

// Namespace ball/ball
// Params 1
// Checksum 0xa7ee1129, Offset: 0x1390
// Size: 0x2a
function watch_for_death( localclientnum )
{
    level endon( #"watch_for_death" );
    self waittill( "death" );
}

// Namespace ball/ball
// Params 7
// Checksum 0x707d5f1a, Offset: 0x13c8
// Size: 0xf4
function function_8dc589c8( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    localplayer = getlocalplayer( localclientnum );
    
    if ( localplayer != self && self isfriendly( localclientnum ) )
    {
        if ( isdefined( localplayer.var_25281d17 ) && localplayer.var_25281d17 )
        {
            setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.passOption" ), newval );
        }
    }
}

// Namespace ball/ball
// Params 7
// Checksum 0x252b8e68, Offset: 0x14c8
// Size: 0x84
function function_c27acbbf( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballAway" ), newval );
}

// Namespace ball/ball
// Params 2
// Checksum 0x4d0e015e, Offset: 0x1558
// Size: 0x3c
function function_235fe967( localclientnum, on_off )
{
    self duplicate_render::update_dr_flag( localclientnum, "ballcarrier", on_off );
}

// Namespace ball/ball
// Params 2
// Checksum 0xae62b8fe, Offset: 0x15a0
// Size: 0x3c
function function_115bb67e( localclientnum, on_off )
{
    self duplicate_render::update_dr_flag( localclientnum, "passoption", on_off );
}

// Namespace ball/ball
// Params 3
// Checksum 0xcd71222f, Offset: 0x15e8
// Size: 0x58
function resetondemojump( localclientnum, goal, effects )
{
    for ( ;; )
    {
        level waittill( "demo_jump" + localclientnum );
        function_2182aedf( localclientnum, goal, effects );
    }
}

// Namespace ball/ball
// Params 1
// Checksum 0xa0f2deaa, Offset: 0x1648
// Size: 0x54
function watch_for_team_change( localclientnum )
{
    level notify( #"end_team_change_watch" );
    level endon( #"end_team_change_watch" );
    level waittill( "team_changed" );
    thread function_45876c81( localclientnum );
}

