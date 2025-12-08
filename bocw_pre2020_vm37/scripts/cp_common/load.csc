#using script_1d4ca739cb476f50;
#using script_31a4e84bd38b34e2;
#using script_c22b8fa254e64a0;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfaceanim_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\helicopter_sounds_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lockpick;
#using scripts\core_common\scene_shared;
#using scripts\core_common\status_effects\status_effects;
#using scripts\core_common\system_shared;
#using scripts\core_common\traps_deployable;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\driving_fx;
#using scripts\cp_common\ambient;
#using scripts\cp_common\global_fx;
#using scripts\cp_common\hazard;
#using scripts\cp_common\oed;
#using scripts\cp_common\rotating_object;
#using scripts\cp_common\skipto;
#using scripts\weapons\antipersonnelguidance;
#using scripts\weapons\cp\weaponobjects;
#using scripts\weapons\spike_charge;

#namespace load;

// Namespace load/load
// Params 3
// Checksum 0x92a8d7da, Offset: 0x160
// Size: 0x4e
function levelnotifyhandler( clientnum, state, *oldstate )
{
    if ( oldstate != "" )
    {
        level notify( oldstate, { #localclientnum:state } );
    }
}

// Namespace load/load
// Params 0, eflags: 0x2
// Checksum 0x1365c405, Offset: 0x1b8
// Size: 0x3c
function autoexec function_aeb1baea()
{
    assert( !isdefined( level.var_f18a6bd6 ) );
    level.var_f18a6bd6 = &function_5e443ed1;
}

// Namespace load/load
// Params 0
// Checksum 0x166a4e32, Offset: 0x200
// Size: 0x174
function function_5e443ed1()
{
    assert( isdefined( level.first_frame ), "<dev string:x38>" );
    
    if ( is_true( level._loadstarted ) )
    {
        return;
    }
    
    level._loadstarted = 1;
    level thread util::init_utility();
    level thread register_clientfields();
    util::registersystem( "levelNotify", &levelnotifyhandler );
    level.createfx_disable_fx = getdvarint( #"disable_fx", 0 ) == 1;
    callback::add_callback( #"on_localclient_connect", &basic_player_connect );
    callback::on_spawned( &on_player_spawned );
    system::function_c11b0642();
    art_review();
    level flag::set( #"load_main_complete" );
}

// Namespace load/load
// Params 1
// Checksum 0x4a31b7e2, Offset: 0x380
// Size: 0x2c
function basic_player_connect( localclientnum )
{
    forcegamemodemappings( localclientnum, "default" );
}

// Namespace load/load
// Params 1
// Checksum 0x5e406c64, Offset: 0x3b8
// Size: 0x3c
function on_player_spawned( localclientnum )
{
    self thread force_update_player_clientfields( localclientnum );
    self function_b181fc06( localclientnum );
}

// Namespace load/load
// Params 1
// Checksum 0x83c140a3, Offset: 0x400
// Size: 0x64
function force_update_player_clientfields( localclientnum )
{
    self endon( #"death" );
    
    while ( !clienthassnapshot( localclientnum ) )
    {
        wait 0.25;
    }
    
    wait 0.25;
    self processclientfieldsasifnew();
}

// Namespace load/load
// Params 0
// Checksum 0x80f724d1, Offset: 0x470
// Size: 0x4
function register_clientfields()
{
    
}

