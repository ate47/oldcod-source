#using script_35ae72be7b4fec10;
#using script_4134e1e2e7684c4c;
#using script_5513c8efed5ff300;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\util;

#namespace namespace_2b049a09;

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 0, eflags: 0x6
// Checksum 0x92d77b5c, Offset: 0x658
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"hash_635ff968b6476f85", &preload, undefined, undefined, #"collectibles" );
}

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 0, eflags: 0x4
// Checksum 0x72876777, Offset: 0x6a8
// Size: 0x244
function private preload()
{
    clientfield::register( "toplayer", "get_anagram_solution", 1, 1, "int" );
    serverfield::register( "anagram_solution_index", 1, int( ceil( log2( 60 ) ) ), "int", &function_5ecf5ec2 );
    callback::on_spawned( &on_player_spawned );
    collectibles::add_callback( "chaos_newspaper", &newspaper );
    collectibles::add_callback( "chaos_radio_broadcast", &radio_broadcast );
    collectibles::add_callback( "chaos_coded_message", &coded_message );
    collectibles::add_callback( "chaos_floppy_disk", &function_af235cd2 );
    
    /#
        if ( !isdefined( level.var_455ccc8b ) )
        {
            level.var_455ccc8b = [];
        }
        
        util::init_dvar( "<dev string:x38>", 0, &function_db698ba5 );
        util::init_dvar( "<dev string:x56>", 0, &function_db698ba5 );
        util::init_dvar( "<dev string:x6e>", 0, &function_db698ba5 );
        util::init_dvar( "<dev string:x8c>", 0, &function_db698ba5 );
        util::init_dvar( "<dev string:xa8>", 0, &function_db698ba5 );
    #/
}

/#

    // Namespace namespace_2b049a09/namespace_2b049a09
    // Params 1, eflags: 0x4
    // Checksum 0xde5bf618, Offset: 0x8f8
    // Size: 0x4ac, Type: dev
    function private function_db698ba5( dvar )
    {
        level.var_455ccc8b[ dvar.name ] = dvar.value;
        
        if ( dvar.name == "<dev string:x56>" && is_true( level.var_455ccc8b[ #"hash_2db6dee0f1729341" ] ) )
        {
            thread newspaper();
            setdvar( #"hash_2db6dee0f1729341", 0 );
        }
        
        if ( dvar.name == "<dev string:x6e>" && is_true( level.var_455ccc8b[ #"hash_24e6120d6a8d655d" ] ) )
        {
            num_entries = max( 4, level.var_455ccc8b[ #"hash_24e6120d6a8d655d" ] );
            thread radio_broadcast( num_entries );
            setdvar( #"hash_24e6120d6a8d655d", 0 );
        }
        
        if ( dvar.name == "<dev string:x8c>" && is_true( level.var_455ccc8b[ #"hash_1412afe4a2259541" ] ) )
        {
            thread coded_message();
            setdvar( #"hash_1412afe4a2259541", 0 );
        }
        
        if ( dvar.name == "<dev string:x38>" && is_true( level.var_455ccc8b[ #"hash_743976f5cb9fa81c" ] ) )
        {
            thread function_d444c39c( 1 );
            setdvar( #"hash_743976f5cb9fa81c", 0 );
            
            if ( scripted_widgets::exists( #"anagrams" ) )
            {
                player = getplayers()[ 0 ];
                
                if ( isdefined( player ) )
                {
                    player endon( #"death" );
                    player notify( #"hash_66c52f852ccf249f" );
                    player flag::wait_till( "<dev string:xbb>" );
                    thread newspaper();
                }
            }
            
            if ( scripted_widgets::exists( #"coded_message" ) )
            {
                player = getplayers()[ 0 ];
                
                if ( isdefined( player ) )
                {
                    player endon( #"death" );
                    player notify( #"hash_4d971fa74eb99bb7" );
                    player flag::wait_till( "<dev string:xbb>" );
                    thread coded_message();
                }
            }
        }
        
        if ( dvar.name == "<dev string:xa8>" && is_true( level.var_455ccc8b[ #"hash_4c83d232b1ef9d7d" ] ) )
        {
            savegame::set_player_data( #"hash_4c19b5801ce1bc5d" );
            savegame::set_player_data( #"hash_af0385a1ce3480a" );
            savegame::set_player_data( #"hash_7cb97d07f8fd21fc" );
            savegame::set_player_data( #"hash_1a4a28d720563dea" );
            savegame::set_player_data( #"hash_74dace636845482f" );
            savegame::set_player_data( #"hash_84cb867109a043e" );
            setdvar( #"hash_4c83d232b1ef9d7d", 0 );
        }
    }

#/

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 0, eflags: 0x4
// Checksum 0x453b0641, Offset: 0xdb0
// Size: 0x14
function private on_player_spawned()
{
    function_9eb15176();
}

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 0, eflags: 0x4
// Checksum 0x5bb8be6e, Offset: 0xdd0
// Size: 0x3c
function private function_9eb15176()
{
    level flag::wait_till( #"gameplay_started" );
    function_d444c39c( 0 );
}

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 1, eflags: 0x4
// Checksum 0x6620f30c, Offset: 0xe18
// Size: 0x2fc
function private function_d444c39c( reset )
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    
    if ( is_true( reset ) )
    {
        savegame::set_player_data( #"hash_5dd320f3ff491aed" );
        savegame::set_player_data( #"hash_6ac9f93e38b74633" );
        player flag::clear( "anagram_solution_set" );
    }
    
    if ( !isdefined( savegame::function_2ee66e93( #"hash_5dd320f3ff491aed" ) ) || !isdefined( savegame::function_2ee66e93( #"hash_6ac9f93e38b74633" ) ) || !isdefined( savegame::function_2ee66e93( #"hash_1cec68d3f5bf55f8" ) ) || !isdefined( savegame::function_2ee66e93( #"hash_35b29e7e753dc631" ) ) || !isdefined( savegame::function_2ee66e93( #"hash_100ec76505ac8673" ) ) )
    {
        player clientfield::set_to_player( "get_anagram_solution", 1 );
        player flag::wait_till( "anagram_solution_set" );
        player clientfield::set_to_player( "get_anagram_solution", 0 );
        return;
    }
    
    player globallogic_ui::function_9ed5232e( "OperationChaos.passphraseIndex", savegame::function_2ee66e93( #"hash_5dd320f3ff491aed" ) );
    player globallogic_ui::function_9ed5232e( "OperationChaos.code", savegame::function_2ee66e93( #"hash_6ac9f93e38b74633" ) );
    player globallogic_ui::function_9ed5232e( "OperationChaos.anagramIndex", savegame::function_2ee66e93( #"hash_1cec68d3f5bf55f8" ) );
    player globallogic_ui::function_9ed5232e( "OperationChaos.number_sequence", savegame::function_2ee66e93( #"hash_35b29e7e753dc631" ) );
    player globallogic_ui::function_9ed5232e( "OperationChaos.seed", savegame::function_2ee66e93( #"hash_100ec76505ac8673" ) );
}

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 2, eflags: 0x4
// Checksum 0xe9b2d735, Offset: 0x1120
// Size: 0x314
function private function_5ecf5ec2( *oldval, newval )
{
    if ( newval > 0 )
    {
        var_9487875 = getscriptbundle( "operation_chaos_anagrams" );
        seed = int( ( function_b6db3f71() + randomint( 2147483647 ) ) % 2147483647 );
        code = randomint( 10000 );
        
        for ( var_2d96435a = randomint( 10000 ); function_7655bab6( code, var_2d96435a ) ; var_2d96435a = randomint( 10000 ) )
        {
        }
        
        player = getplayers()[ 0 ];
        
        if ( newval > 60 )
        {
            newval = randomint( var_9487875.anagrams.size ) * -1;
        }
        else
        {
            newval--;
        }
        
        for ( var_e9ef7dab = randomint( var_9487875.anagrams.size ); var_e9ef7dab == newval ; var_e9ef7dab = randomint( var_9487875.anagrams.size ) )
        {
        }
        
        savegame::set_player_data( #"hash_5dd320f3ff491aed", var_e9ef7dab );
        savegame::set_player_data( #"hash_6ac9f93e38b74633", code );
        savegame::set_player_data( #"hash_1cec68d3f5bf55f8", newval );
        savegame::set_player_data( #"hash_35b29e7e753dc631", var_2d96435a );
        savegame::set_player_data( #"hash_100ec76505ac8673", seed );
        player globallogic_ui::function_9ed5232e( "OperationChaos.passphraseIndex", var_e9ef7dab );
        player globallogic_ui::function_9ed5232e( "OperationChaos.code", code );
        player globallogic_ui::function_9ed5232e( "OperationChaos.anagramIndex", newval );
        player globallogic_ui::function_9ed5232e( "OperationChaos.number_sequence", var_2d96435a );
        player globallogic_ui::function_9ed5232e( "OperationChaos.seed", seed );
        player flag::set( "anagram_solution_set" );
    }
}

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 0
// Checksum 0x4c24a4d2, Offset: 0x1440
// Size: 0x314
function newspaper()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    var_43381ccf = savegame::function_2ee66e93( #"hash_1cec68d3f5bf55f8" );
    seed = savegame::function_2ee66e93( #"hash_100ec76505ac8673" );
    player globallogic_ui::function_9ed5232e( "OperationChaos.anagramIndex", var_43381ccf );
    player globallogic_ui::function_9ed5232e( "OperationChaos.seed", seed );
    uid = #"newspaper";
    scripted_widgets::create( uid, #"hash_2f387cc5510b5100" );
    scripted_widgets::function_d3c3e5c3( uid, #"interactive_map" );
    scripted_widgets::set_state( uid, "DefaultState" );
    
    if ( !is_true( savegame::function_2ee66e93( #"hash_af0385a1ce3480a" ) ) )
    {
        var_bc8da67d = player namespace_70eba6e6::function_b6a02677();
        vox = "vox_cp_chao_01200_sims_sometimesthered_c7";
        
        switch ( var_bc8da67d )
        {
            case 1:
                vox = "vox_cp_chao_01200_sims_sometimesthered_8a";
                break;
            case 2:
                vox = "vox_cp_chao_01200_sims_sometimesthered_aa";
                break;
            case 3:
                vox = "vox_cp_chao_01200_sims_sometimesthered_d6";
                break;
        }
        
        player dialogue::radio( vox );
        savegame::set_player_data( #"hash_af0385a1ce3480a", 1 );
    }
    else
    {
        wait 0.5;
    }
    
    scripted_widgets::set_state( uid, "Highlight" );
    
    /#
        if ( is_true( level.var_455ccc8b[ #"hash_2db6dee0f1729341" ] ) )
        {
            scripted_widgets::function_29703592( uid );
        }
    #/
    
    player waittill( #"ui_cancel", #"hash_66c52f852ccf249f" );
    scripted_widgets::remove( uid );
}

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 1
// Checksum 0x8806b9f9, Offset: 0x1760
// Size: 0x7d4
function radio_broadcast( num_entries = 10 )
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    
    if ( !is_true( savegame::function_2ee66e93( #"hash_1a4a28d720563dea" ) ) )
    {
        player dialogue::radio( "vox_cp_chao_01300_sims_youdidgoodfindi_15" );
        savegame::set_player_data( #"hash_1a4a28d720563dea", 1 );
    }
    
    var_674fe008 = [ "vox_cp_chao_02000_fbro_one_22", "vox_cp_chao_02000_fbro_one_22", "vox_cp_chao_02000_fbro_two_3a", "vox_cp_chao_02000_fbro_three_f8", "vox_cp_chao_02000_fbro_four_9c", "vox_cp_chao_02000_fbro_five_8a", "vox_cp_chao_02000_fbro_six_34", "vox_cp_chao_02000_fbro_seven_01", "vox_cp_chao_02000_fbro_eight_f1", "vox_cp_chao_02000_fbro_nine_8a" ];
    var_9487875 = getscriptbundle( "operation_chaos_anagrams" );
    var_e9ef7dab = savegame::function_2ee66e93( #"hash_5dd320f3ff491aed" );
    code = savegame::function_2ee66e93( #"hash_6ac9f93e38b74633" );
    var_bf871b87 = int( abs( savegame::function_2ee66e93( #"hash_1cec68d3f5bf55f8" ) ) );
    var_2d96435a = savegame::function_2ee66e93( #"hash_35b29e7e753dc631" );
    seed = savegame::function_2ee66e93( #"hash_100ec76505ac8673" );
    var_721f874b = getarraykeys( var_9487875.anagrams );
    arrayremovevalue( var_721f874b, var_e9ef7dab );
    arrayremovevalue( var_721f874b, var_bf871b87 );
    var_28ddca2c = [];
    var_28ddca2c[ var_28ddca2c.size ] = { #passphrase:var_9487875.anagrams[ var_e9ef7dab ].var_d0354c50, #code:var_2d96435a, #vox:var_9487875.anagrams[ var_e9ef7dab ].var_21d92d5d };
    var_28ddca2c[ var_28ddca2c.size ] = { #passphrase:var_9487875.anagrams[ var_bf871b87 ].var_d0354c50, #code:code, #vox:var_9487875.anagrams[ var_bf871b87 ].var_21d92d5d };
    
    for ( i = 3; i <= num_entries ; i++ )
    {
        rand = function_c9e9e505( seed, 10000 );
        seed = rand.seed;
        
        for ( code = rand.rand; function_7655bab6( var_28ddca2c, code ) ; code = rand.rand )
        {
            rand = function_c9e9e505( seed, 10000 );
            seed = rand.seed;
        }
        
        rand = function_c9e9e505( seed, var_721f874b.size );
        seed = rand.seed;
        passphrase = var_9487875.anagrams[ var_721f874b[ rand.rand ] ].var_d0354c50;
        vox = var_9487875.anagrams[ var_721f874b[ rand.rand ] ].var_21d92d5d;
        arrayremoveindex( var_721f874b, rand.rand );
        var_28ddca2c[ var_28ddca2c.size ] = { #passphrase:passphrase, #code:code, #vox:vox };
    }
    
    for ( i = 0; i < var_28ddca2c.size ; i++ )
    {
        rand = function_c9e9e505( seed, var_28ddca2c.size );
        seed = rand.seed;
        temp = var_28ddca2c[ i ];
        var_28ddca2c[ i ] = var_28ddca2c[ rand.rand ];
        var_28ddca2c[ rand.rand ] = temp;
    }
    
    uid = #"radio_broadcast";
    scripted_widgets::create( uid, #"hash_4f385401c5bccff2" );
    scripted_widgets::function_d3c3e5c3( uid, #"interactive_map" );
    
    /#
        if ( is_true( level.var_455ccc8b[ #"hash_24e6120d6a8d655d" ] ) )
        {
            scripted_widgets::function_29703592( uid );
        }
    #/
    
    for ( i = 0; i < var_28ddca2c.size ; i++ )
    {
        scripted_widgets::function_f2a9266( uid, i, "passphrase", var_28ddca2c[ i ].passphrase );
        scripted_widgets::function_f2a9266( uid, i, "code", var_28ddca2c[ i ].code );
        player thread dialogue::radio( var_28ddca2c[ i ].vox );
        var_a70a37a2 = string( var_28ddca2c[ i ].code, 4 );
        
        for ( str_index = 0; str_index < 4 ; str_index++ )
        {
            player thread dialogue::radio( var_674fe008[ int( getsubstr( var_a70a37a2, str_index, str_index + 1 ) ) ] );
        }
    }
    
    player waittill( #"ui_cancel", #"hash_2e2cf90fec5db49b" );
    player dialogue::function_9e580f95();
    scripted_widgets::remove( uid );
}

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 0
// Checksum 0xe31b48f0, Offset: 0x1f40
// Size: 0x264
function coded_message()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    code = savegame::function_2ee66e93( #"hash_35b29e7e753dc631" );
    seed = savegame::function_2ee66e93( #"hash_100ec76505ac8673" );
    player globallogic_ui::function_9ed5232e( "OperationChaos.number_sequence", code );
    player globallogic_ui::function_9ed5232e( "OperationChaos.seed", seed );
    uid = #"coded_message";
    scripted_widgets::create( uid, #"hash_29246bd6b5d544d2" );
    scripted_widgets::function_d3c3e5c3( uid, #"interactive_map" );
    scripted_widgets::function_f942c3ed( uid, "DefaultClip" );
    
    /#
        if ( is_true( level.var_455ccc8b[ #"hash_1412afe4a2259541" ] ) )
        {
            scripted_widgets::function_29703592( uid );
        }
    #/
    
    if ( !is_true( savegame::function_2ee66e93( #"hash_7cb97d07f8fd21fc" ) ) )
    {
        player dialogue::radio( "vox_cp_chao_01400_sims_aftermasonbroug_51" );
        savegame::set_player_data( #"hash_7cb97d07f8fd21fc", 1 );
    }
    
    waitframe( 1 );
    scripted_widgets::function_f942c3ed( uid, "Reveal" );
    player waittill( #"ui_cancel", #"hash_4d971fa74eb99bb7" );
    scripted_widgets::remove( uid );
}

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 0
// Checksum 0x691d6007, Offset: 0x21b0
// Size: 0xdf4
function function_af235cd2()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    thread util::screen_fade_out( 0.15 );
    namespace_6f1d35e1::function_b2911127( 0 );
    var_2f8f8378 = clientfield::get_to_player( "set_hub_dof" );
    var_5a0a6894 = clientfield::get_to_player( "set_hub_fov" );
    var_1464e28f = player clientfield::get_to_player( "pstfx_t9_cp_hub_eboard_vignette" );
    overview = player clientfield::get_to_player( "pstfx_t9_cp_hub_eboard_overview" );
    link_ent = player getlinkedent();
    playerpos = player getplayercamerapos();
    playerangles = player getplayerangles();
    wait 0.25;
    
    if ( !is_true( savegame::function_2ee66e93( #"hash_74dace636845482f" ) ) )
    {
        player thread dialogue::radio( "vox_cp_chao_01500_sims_ifwedecryptthep_4d" );
    }
    
    player clientfield::set_to_player( "set_hub_dof", 1 );
    player clientfield::set_to_player( "set_hub_fov", 2 );
    player clientfield::set_to_player( "pstfx_t9_cp_hub_eboard_vignette", 0 );
    player clientfield::set_to_player( "pstfx_t9_cp_hub_eboard_overview", 0 );
    shot = undefined;
    scenes = level scene::get_active_scenes( "scene_hub_eboard_handler" );
    
    foreach ( scene in scenes )
    {
        if ( isdefined( scene.last_scene_state_instance[ #"scene_hub_eboard_handler" ] ) )
        {
            shot = scene.last_scene_state_instance[ #"scene_hub_eboard_handler" ];
            break;
        }
    }
    
    level scene::stop( "scene_hub_eboard_handler" );
    player unlink();
    var_7ab1a25c = struct::get( "computer_camera_position" );
    player camerasetposition( var_7ab1a25c.origin, var_7ab1a25c.angles );
    thread util::screen_fade_in( 0.25 );
    scripted_widgets::function_4279fd02( #"interactive_map" );
    var_795ae76c = 1;
    
    while ( var_795ae76c )
    {
        namespace_6f1d35e1::function_eea42dd9( #"hash_53e6026705a8bb51", 1 );
        namespace_6f1d35e1::function_487b4340( #"hash_678fbc89038dae9a", 0 );
        namespace_6f1d35e1::function_5d2e6f6a( 1 );
        namespace_6f1d35e1::function_314087bb( 1 );
        namespace_6f1d35e1::function_4951a2c8( 1, 1 );
        namespace_6f1d35e1::function_8a58b10c( 1, 2 );
        namespace_6f1d35e1::function_29438cc( 1, 4 );
        namespace_6f1d35e1::function_28321961( 1, 1 );
        namespace_6f1d35e1::function_7bfd800c( 1, 0 );
        namespace_6f1d35e1::function_be760dc8( 1, 9999 );
        namespace_6f1d35e1::function_9806766( 1, "" );
        
        if ( !is_true( savegame::function_2ee66e93( #"hash_74dace636845482f" ) ) )
        {
            namespace_6f1d35e1::function_6ed8776d( 1, 0 );
            player.player_radio_emitter waittill( #"hash_75bc5c9143187846" );
            savegame::set_player_data( #"hash_74dace636845482f", 1 );
        }
        
        namespace_6f1d35e1::function_6ed8776d( 1, 1 );
        var_3d79eff5 = 0;
        
        while ( true )
        {
            response = player function_7cfb600();
            
            if ( is_true( response ) )
            {
                entry = namespace_6f1d35e1::function_f887fdff( 1 );
                
                if ( entry.size == 4 )
                {
                    player globallogic_ui::function_9ed5232e( "OperationChaos.floppyEntry.code", entry );
                    var_3d79eff5 = 1;
                    break;
                }
                
                ret = player waittill( #"ui_confirm", #"ui_cancel" );
                
                if ( ret._notify === #"ui_confirm" )
                {
                    namespace_6f1d35e1::function_6ed8776d( 1, 1, 1 );
                    continue;
                }
                
                break;
            }
        }
        
        if ( is_true( var_3d79eff5 ) )
        {
            namespace_6f1d35e1::function_6ed8776d( 1, 0 );
            namespace_6f1d35e1::function_314087bb( 2 );
            namespace_6f1d35e1::function_4951a2c8( 2, 1 );
            namespace_6f1d35e1::function_8a58b10c( 2, 0 );
            namespace_6f1d35e1::function_29438cc( 2, 30 );
            namespace_6f1d35e1::function_9806766( 2, "" );
            namespace_6f1d35e1::function_6ed8776d( 2, 1 );
            wait 0.1;
            authenticate = 0;
            
            while ( true )
            {
                response = player function_7cfb600();
                
                if ( is_true( response ) )
                {
                    entry = namespace_6f1d35e1::function_f887fdff( 2 );
                    
                    if ( entry.size > 0 )
                    {
                        player globallogic_ui::function_9ed5232e( "OperationChaos.floppyEntry.passphrase", entry );
                        authenticate = 1;
                        break;
                    }
                    
                    ret = player waittill( #"ui_confirm", #"ui_cancel" );
                    
                    if ( ret._notify === #"ui_confirm" )
                    {
                        namespace_6f1d35e1::function_6ed8776d( 2, 1, 1 );
                        continue;
                    }
                    
                    break;
                }
            }
            
            player flag::wait_till_clear_all( [ #"ui_confirm", #"ui_cancel" ] );
            
            if ( is_true( authenticate ) )
            {
                namespace_6f1d35e1::function_314087bb( 3 );
                namespace_6f1d35e1::function_4951a2c8( 3, 1 );
                ret = player waittill( #"ui_confirm", #"ui_cancel" );
                
                if ( ret._notify == #"ui_confirm" )
                {
                    namespace_6f1d35e1::function_6f9dba44( 3, #"hash_3e2eeb47e243c784" );
                    wait 0.1;
                    player globallogic_ui::function_9ed5232e( "OperationChaos.floppyEntry.authenticate", 1, undefined, 1, undefined, undefined, 1 );
                    result = player waittillmatch( { #menu:#"ScriptedHudWidgetMenu", #response:#"authentication" }, #"menuresponse" );
                    
                    if ( result.intpayload == 0 )
                    {
                        namespace_6f1d35e1::function_314087bb( 4 );
                        namespace_6f1d35e1::function_4951a2c8( 4, 1 );
                    }
                    else
                    {
                        namespace_6f1d35e1::function_314087bb( 5 );
                        namespace_6f1d35e1::function_4951a2c8( 5, 1 );
                        var_795ae76c = 0;
                        
                        if ( !is_true( savegame::function_2ee66e93( #"hash_84cb867109a043e" ) ) )
                        {
                            player util::delay( 1, undefined, &dialogue::radio, "vox_cp_chao_01600_sims_hellyeahthatsit_51" );
                        }
                    }
                    
                    wait 2;
                }
                else
                {
                    namespace_6f1d35e1::function_6f9dba44( 3, #"hash_7459144792eda2c6" );
                    wait 0.1;
                    player flag::wait_till_clear_all( [ #"ui_confirm", #"ui_cancel" ] );
                }
            }
            
            continue;
        }
        
        break;
    }
    
    if ( !var_795ae76c && is_true( savegame::function_2ee66e93( #"hash_84cb867109a043e" ) ) )
    {
        player.player_radio_emitter waittill( #"hash_19bb840c1a741fef" );
        savegame::set_player_data( #"hash_84cb867109a043e", 1 );
    }
    
    player flag::wait_till_clear_all( [ #"ui_confirm", #"ui_cancel" ] );
    thread util::screen_fade_out( 0.15 );
    wait 0.15;
    player clientfield::set_to_player( "set_hub_dof", var_2f8f8378 );
    player clientfield::set_to_player( "set_hub_fov", var_5a0a6894 );
    player clientfield::set_to_player( "pstfx_t9_cp_hub_eboard_vignette", var_1464e28f );
    player clientfield::set_to_player( "pstfx_t9_cp_hub_eboard_overview", overview );
    player unlink();
    player playerlinkto( link_ent, "tag_origin" );
    waitframe( 1 );
    player camerasetposition( playerpos, playerangles );
    
    if ( isdefined( shot ) )
    {
        level thread scene::play( "scene_hub_eboard_handler", shot );
    }
    
    wait 0.1;
    namespace_6f1d35e1::function_b2911127( 0 );
    thread util::screen_fade_in( 0.15 );
    wait 0.15;
    scripted_widgets::function_28027c42( #"interactive_map" );
}

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 0, eflags: 0x4
// Checksum 0xf3e93a4b, Offset: 0x2fb0
// Size: 0x80, Type: bool
function private function_7cfb600()
{
    self endon( #"death", #"ui_cancel" );
    self waittillmatch( { #menu:#"ScriptedHudWidgetMenu", #response:#"hash_260e4568c570b4ba" }, #"menuresponse" );
    return true;
}

// Namespace namespace_2b049a09/namespace_2b049a09
// Params 2, eflags: 0x4
// Checksum 0x86ae8c72, Offset: 0x3038
// Size: 0x184, Type: bool
function private function_7655bab6( var_df3d8ccf, var_947f605b )
{
    var_be3496f3 = floor( var_947f605b / 100 );
    var_2f18ad1 = var_947f605b - var_be3496f3 * 100;
    
    if ( !isdefined( var_df3d8ccf ) )
    {
        var_df3d8ccf = [];
    }
    else if ( !isarray( var_df3d8ccf ) )
    {
        var_df3d8ccf = array( var_df3d8ccf );
    }
    
    foreach ( code in var_df3d8ccf )
    {
        if ( isstruct( code ) )
        {
            code = code.code;
        }
        
        var_34a354e2 = floor( code / 100 );
        var_7535d84c = code - var_34a354e2 * 100;
        
        if ( code == var_947f605b || var_34a354e2 == var_2f18ad1 && var_7535d84c == var_be3496f3 )
        {
            return true;
        }
    }
    
    return false;
}

