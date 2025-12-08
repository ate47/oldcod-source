#using script_67ce8e728d8f37ba;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace mp_tundra;

// Namespace mp_tundra/level_preinit
// Params 1, eflags: 0x40
// Checksum 0xac27272c, Offset: 0x1d8
// Size: 0x34
function event_handler[level_preinit] codecallback_preinitialization( *eventstruct )
{
    killstreaks::function_8c83a621( "straferun", #"hash_32c02123dd00c261" );
}

// Namespace mp_tundra/level_init
// Params 1, eflags: 0x40
// Checksum 0x16a58eec, Offset: 0x218
// Size: 0x114
function event_handler[level_init] main( *eventstruct )
{
    namespace_66d6aa44::function_3f3466c9();
    killstreaks::function_257a5f13( "straferun", 60 );
    killstreaks::function_257a5f13( "helicopter_comlink", 75 );
    callback::on_game_playing( &on_game_playing );
    callback::on_end_game( &on_end_game );
    load::main();
    compass::setupminimap( "" );
    level flag::wait_till( "first_player_spawned" );
    level thread function_e33449fd();
    hidemiscmodels( "5v5_asset_boundary" );
}

// Namespace mp_tundra/mp_tundra
// Params 0
// Checksum 0x58ef6829, Offset: 0x338
// Size: 0x218
function on_game_playing()
{
    str_gametype = util::get_game_type();
    
    if ( str_gametype == "tdm" || str_gametype == "dom" )
    {
        showmiscmodels( "5v5_asset_boundary" );
        hidemiscmodels( "turret_model" );
        return;
    }
    
    var_5b84b22c = getentarray( "tundra_oob_clip", "targetname" );
    
    foreach ( var_ec7dad0 in var_5b84b22c )
    {
        if ( isdefined( var_ec7dad0 ) )
        {
            var_ec7dad0 delete();
        }
    }
    
    var_3359f998 = arraycombine( getentarray( "5v5_asset_boundary", "targetname" ), getentarray( "5v5_asset_boundary", "script_noteworthy" ), 0, 0 );
    
    foreach ( var_8da7cb3 in var_3359f998 )
    {
        if ( isdefined( var_8da7cb3 ) )
        {
            var_8da7cb3 delete();
        }
    }
}

// Namespace mp_tundra/mp_tundra
// Params 0
// Checksum 0x5c2dab8, Offset: 0x558
// Size: 0x5c
function on_end_game()
{
    if ( getdvarint( #"hash_5cfa659178399dc6", 0 ) )
    {
        level scene::function_1e327c20( array( "cin_mp_tundra_outro_cia", "cin_mp_tundra_outro_kgb" ) );
    }
}

// Namespace mp_tundra/mp_tundra
// Params 0
// Checksum 0x9ce5154d, Offset: 0x5c0
// Size: 0x4c
function function_e33449fd()
{
    rope_bridge_trig = getent( "rope_bridge_trig", "targetname" );
    rope_bridge_trig callback::on_trigger( &function_95ec9598 );
}

// Namespace mp_tundra/mp_tundra
// Params 1
// Checksum 0x26f43007, Offset: 0x618
// Size: 0x1f6
function function_95ec9598( var_3a72e7b7 )
{
    player = var_3a72e7b7.activator;
    
    if ( isdefined( self ) && isalive( player ) && !is_true( self.activated ) && player function_64fefea() )
    {
        level endon( #"game_ended" );
        scene = struct::get( #"hash_2467352290a052f7", "scriptbundlename" );
        bridge = scene.scene_ents[ #"prop 1" ];
        self.activated = 1;
        level thread scene::play( #"hash_2467352290a052f7", "Shot 2" );
        
        while ( self function_86072b19() )
        {
            waitframe( 1 );
        }
        
        bridge waittill( #"loop_done", #"death" );
        
        if ( function_acf0ca42() && !function_86072b19() )
        {
            level thread scene::stop( #"hash_2467352290a052f7" );
        }
        else if ( !function_acf0ca42() )
        {
            level thread scene::play( #"hash_2467352290a052f7", "Shot 1" );
        }
        
        self.activated = 0;
    }
}

// Namespace mp_tundra/mp_tundra
// Params 0
// Checksum 0xba0b8d44, Offset: 0x818
// Size: 0xdc, Type: bool
function function_86072b19()
{
    foreach ( player in getplayers() )
    {
        if ( isalive( player ) && isdefined( self ) && player istouching( self ) && player function_64fefea() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mp_tundra/mp_tundra
// Params 0
// Checksum 0x60e6235b, Offset: 0x900
// Size: 0xc4, Type: bool
function function_acf0ca42()
{
    foreach ( player in getplayers() )
    {
        if ( isalive( player ) && isdefined( self ) && player istouching( self ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mp_tundra/mp_tundra
// Params 0
// Checksum 0x333e5700, Offset: 0x9d0
// Size: 0x2c, Type: bool
function function_64fefea()
{
    if ( self getvelocity() === ( 0, 0, 0 ) )
    {
        return false;
    }
    
    return true;
}

