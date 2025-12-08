#using script_67ce8e728d8f37ba;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\load_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace mp_cartel;

// Namespace mp_cartel/level_init
// Params 1, eflags: 0x40
// Checksum 0xd8c59426, Offset: 0x178
// Size: 0xc4
function event_handler[level_init] main( *eventstruct )
{
    killstreaks::function_257a5f13( "straferun", 40 );
    killstreaks::function_257a5f13( "helicopter_comlink", 75 );
    namespace_66d6aa44::function_3f3466c9();
    callback::on_end_game( &on_end_game );
    callback::function_6700e8b5( &function_aa95c0bb );
    load::main();
    compass::setupminimap( "" );
}

// Namespace mp_cartel/mp_cartel
// Params 0
// Checksum 0x9e0c7d17, Offset: 0x248
// Size: 0x94
function function_aa95c0bb()
{
    scene::add_scene_func( "cin_mp_cartel_intro_north", &function_7a9eb99a, "init" );
    scene::add_scene_func( "cin_mp_cartel_intro_north", &function_9cb21c4a, "sh010" );
    scene::add_scene_func( "cin_mp_cartel_intro_north", &function_8337682d, "sh020" );
}

// Namespace mp_cartel/mp_cartel
// Params 0
// Checksum 0x80f724d1, Offset: 0x2e8
// Size: 0x4
function on_end_game()
{
    
}

// Namespace mp_cartel/mp_cartel
// Params 1
// Checksum 0x832dc2c7, Offset: 0x2f8
// Size: 0x14c
function function_74906a8b( var_8f9fbf19 )
{
    var_56411b8a = getent( "prb_tn_us_heli_lg_cockpit", "targetname" );
    var_2ad45d4e = getent( "prb_tn_us_heli_lg_cabin", "targetname" );
    var_56411b8a unlink();
    var_2ad45d4e unlink();
    var_56411b8a dontinterpolate();
    var_2ad45d4e dontinterpolate();
    
    if ( isdefined( var_8f9fbf19 gettagorigin( "tag_probe_cockpit" ) ) )
    {
        var_56411b8a linkto( var_8f9fbf19, "tag_probe_cockpit", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    if ( isdefined( var_8f9fbf19 gettagorigin( "tag_probe_cabin" ) ) )
    {
        var_2ad45d4e linkto( var_8f9fbf19, "tag_probe_cabin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
}

// Namespace mp_cartel/mp_cartel
// Params 1
// Checksum 0x3297bf9d, Offset: 0x450
// Size: 0x64
function function_7a9eb99a( a_ents )
{
    if ( !isdefined( a_ents[ #"hash_7adc8fdd333fd073" ] ) )
    {
        /#
            iprintlnbold( "<dev string:x38>" );
        #/
        
        return;
    }
    
    function_74906a8b( a_ents[ #"hash_7adc8fdd333fd073" ] );
}

// Namespace mp_cartel/mp_cartel
// Params 1
// Checksum 0x6a8f646e, Offset: 0x4c0
// Size: 0x64
function function_9cb21c4a( a_ents )
{
    if ( !isdefined( a_ents[ #"hash_7adc8fdd333fd073" ] ) )
    {
        /#
            iprintlnbold( "<dev string:x38>" );
        #/
        
        return;
    }
    
    function_74906a8b( a_ents[ #"hash_7adc8fdd333fd073" ] );
}

// Namespace mp_cartel/mp_cartel
// Params 1
// Checksum 0xc40f7902, Offset: 0x530
// Size: 0x64
function function_8337682d( a_ents )
{
    if ( !isdefined( a_ents[ #"hash_7adc8fdd333fd073" ] ) )
    {
        /#
            iprintlnbold( "<dev string:x38>" );
        #/
        
        return;
    }
    
    function_74906a8b( a_ents[ #"hash_7adc8fdd333fd073" ] );
}

