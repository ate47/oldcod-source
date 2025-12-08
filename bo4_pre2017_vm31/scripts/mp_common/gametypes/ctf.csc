#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/shoutcaster;

#namespace ctf;

// Namespace ctf/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x6c2a76a8, Offset: 0x1c0
// Size: 0x2c
function event_handler[GameType_Init] main( eventstruct )
{
    callback::on_localclient_connect( &on_localclient_connect );
}

// Namespace ctf/ctf
// Params 1
// Checksum 0x265913bf, Offset: 0x1f8
// Size: 0x184
function on_localclient_connect( localclientnum )
{
    var_1d2359d9 = [];
    
    while ( !isdefined( var_1d2359d9[ "allies_base" ] ) )
    {
        var_1d2359d9[ "allies_base" ] = serverobjective_getobjective( localclientnum, "allies_base" );
        var_1d2359d9[ "axis_base" ] = serverobjective_getobjective( localclientnum, "axis_base" );
        waitframe( 1 );
    }
    
    foreach ( key, objective in var_1d2359d9 )
    {
        level.var_1267dd47[ key ] = spawnstruct();
        level.var_1267dd47[ key ].objectiveid = objective;
        function_1a39440d( localclientnum, level.var_1267dd47[ key ] );
    }
    
    function_45876c81( localclientnum );
}

// Namespace ctf/ctf
// Params 2
// Checksum 0x6dc41299, Offset: 0x388
// Size: 0xf0
function function_1a39440d( localclientnum, flag )
{
    flag.origin = serverobjective_getobjectiveorigin( localclientnum, flag.objectiveid );
    flag_entity = serverobjective_getobjectiveentity( localclientnum, flag.objectiveid );
    flag.angles = ( 0, 0, 0 );
    
    if ( isdefined( flag_entity ) )
    {
        flag.origin = flag_entity.origin;
        flag.angles = flag_entity.angles;
    }
    
    flag.team = serverobjective_getobjectiveteam( localclientnum, flag.objectiveid );
}

// Namespace ctf/ctf
// Params 3
// Checksum 0xc9e69d5b, Offset: 0x480
// Size: 0x134
function function_6364237a( localclientnum, flag, effects )
{
    if ( isdefined( flag.base_fx ) )
    {
        stopfx( localclientnum, flag.base_fx );
    }
    
    up = anglestoup( flag.angles );
    forward = anglestoforward( flag.angles );
    flag.base_fx = playfx( localclientnum, effects[ flag.team ], flag.origin, up, forward );
    setfxteam( localclientnum, flag.base_fx, flag.team );
    thread watch_for_team_change( localclientnum );
}

// Namespace ctf/ctf
// Params 1
// Checksum 0x4c3e1d9a, Offset: 0x5c0
// Size: 0x172
function function_45876c81( localclientnum )
{
    effects = [];
    
    if ( shoutcaster::is_shoutcaster_using_team_identity( localclientnum ) )
    {
        if ( getdvarint( "tu11_programaticallyColoredGameFX" ) )
        {
            effects[ "allies" ] = "ui/fx_ctf_flag_base_white";
            effects[ "axis" ] = "ui/fx_ctf_flag_base_white";
        }
        else
        {
            effects = shoutcaster::get_color_fx( localclientnum, level.var_d23a0410 );
        }
    }
    else
    {
        effects[ "allies" ] = "ui/fx_ctf_flag_base_team";
        effects[ "axis" ] = "ui/fx_ctf_flag_base_team";
    }
    
    foreach ( flag in level.var_1267dd47 )
    {
        thread function_6364237a( localclientnum, flag, effects );
    }
}

// Namespace ctf/ctf
// Params 1
// Checksum 0x47bc4c55, Offset: 0x740
// Size: 0x54
function watch_for_team_change( localclientnum )
{
    level notify( #"end_team_change_watch" );
    level endon( #"end_team_change_watch" );
    level waittill( "team_changed" );
    thread function_45876c81( localclientnum );
}

