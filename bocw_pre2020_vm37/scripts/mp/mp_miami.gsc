#using script_67ce8e728d8f37ba;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace mp_miami;

// Namespace mp_miami/level_init
// Params 1, eflags: 0x40
// Checksum 0xa1ee4fad, Offset: 0x170
// Size: 0x124
function event_handler[level_init] main( *eventstruct )
{
    clientfield::register( "scriptmover", "neon_rob", 1, 1, "counter" );
    namespace_66d6aa44::function_3f3466c9();
    callback::on_end_game( &on_end_game );
    scene::function_497689f6( #"cin_mp_miami_intro_cia", "intro_kgb_van", "tag_probe_attach", "probe_miami_van_igc" );
    killstreaks::function_257a5f13( "straferun", 40 );
    killstreaks::function_257a5f13( "helicopter_comlink", 75 );
    load::main();
    compass::setupminimap( "" );
    level thread function_f92fe90c();
}

// Namespace mp_miami/mp_miami
// Params 0
// Checksum 0x9029d0e5, Offset: 0x2a0
// Size: 0x9c
function function_f92fe90c()
{
    level endon( #"game_ended" );
    level flag::wait_till( "first_player_spawned" );
    waitframe( 1 );
    var_2555a1ec = getentarray( "neon_rob_sign", "targetname" );
    var_2555a1ec = array::sort_by_script_int( var_2555a1ec, 1 );
    level thread function_7858899c( var_2555a1ec );
}

// Namespace mp_miami/mp_miami
// Params 1
// Checksum 0x99737aa3, Offset: 0x348
// Size: 0x124
function function_7858899c( var_37473ebc )
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.var_58bc5d04 ) )
    {
        wait 1;
    }
    
    while ( true )
    {
        foreach ( sign in var_37473ebc )
        {
            if ( !isdefined( sign ) )
            {
                continue;
            }
            
            sign clientfield::increment( "neon_rob", 1 );
            wait 0.5;
            
            if ( !isdefined( sign ) )
            {
                continue;
            }
            
            sign clientfield::increment( "neon_rob", 1 );
        }
        
        wait 1;
    }
}

// Namespace mp_miami/mp_miami
// Params 0
// Checksum 0x80f724d1, Offset: 0x478
// Size: 0x4
function on_end_game()
{
    
}

