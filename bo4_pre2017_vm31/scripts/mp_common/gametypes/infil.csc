#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/shoutcaster;

#namespace infil;

// Namespace infil/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0xfea265b4, Offset: 0x220
// Size: 0xd4
function event_handler[GameType_Init] main( eventstruct )
{
    callback::on_localclient_connect( &on_localclient_connect );
    clientfield::register( "worlduimodel", "hudItems.war.batteryState1", 1, 3, "int", undefined, 0, 0 );
    clientfield::register( "worlduimodel", "hudItems.war.batteryState2", 1, 3, "int", undefined, 0, 0 );
    clientfield::register( "worlduimodel", "hudItems.war.attackingTeam", 1, 2, "int", undefined, 0, 1 );
}

// Namespace infil/infil
// Params 1
// Checksum 0xdfc2fca3, Offset: 0x300
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

// Namespace infil/infil
// Params 2
// Checksum 0x171e7b94, Offset: 0x490
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

// Namespace infil/infil
// Params 3
// Checksum 0x851ec4e6, Offset: 0x588
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

// Namespace infil/infil
// Params 1
// Checksum 0x9fc8fb73, Offset: 0x6c8
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

// Namespace infil/infil
// Params 1
// Checksum 0xf28418f3, Offset: 0x848
// Size: 0x54
function watch_for_team_change( localclientnum )
{
    level notify( #"end_team_change_watch" );
    level endon( #"end_team_change_watch" );
    level waittill( "team_changed" );
    thread function_45876c81( localclientnum );
}

