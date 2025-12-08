#using script_4052585f7ae90f3a;
#using script_4134e1e2e7684c4c;
#using script_43e82b8f8b9aea77;
#using script_4937c6974f43bb71;
#using script_527bb22a76994e54;
#using script_5513c8efed5ff300;
#using script_6d3108868022b9bf;
#using script_9e487583a27d590;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_ger_hub_post_armada;
#using scripts\cp\cp_ger_hub_post_cuba;
#using scripts\cp\cp_ger_hub_post_kgb;
#using scripts\cp\cp_ger_hub_post_yamantau;
#using scripts\cp_common\arcade_machine;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\flashback_tv;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;

#namespace namespace_31c67f6d;

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x11c25fa2, Offset: 0x18e0
// Size: 0x294
function function_1c920347()
{
    clientfield::register( "scriptmover", "eboard_review_handle_viewmodel", 1, 1, "int" );
    clientfield::register( "scriptmover", "eboard_evidence_angle_limit_x", 1, 8, "int" );
    clientfield::register( "scriptmover", "eboard_evidence_angle_limit_y", 1, 8, "int" );
    clientfield::register( "toplayer", "eboard_camera_position", 1, 5, "int" );
    clientfield::register( "world", "eboard_notify_from_server", 1, 3, "int" );
    clientfield::register( "toplayer", "set_hub_fov", 1, 3, "int" );
    clientfield::register( "toplayer", "set_hub_dof", 1, 3, "int" );
    clientfield::register( "toplayer", "pstfx_t9_cp_hub_eboard_vignette", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_t9_cp_hub_eboard_overview", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_teleport", 1, 3, "int" );
    clientfield::register( "toplayer", "computer_terminal_switch", 1, 1, "int" );
    init_flags();
    level.var_70888df5 = getdvarint( #"hash_2023f46f30138540", 1 ) > 0;
    
    if ( !level.var_70888df5 )
    {
        namespace_cd80be1c::function_107f09b();
    }
    
    level function_5f05b132();
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x23cc463d, Offset: 0x1b80
// Size: 0xa34
function init_flags()
{
    level thread flag::init( "flag_wait_forever" );
    level thread hub_post_takedown::function_f50bc4b9();
    level thread hub_post_armada::function_f50bc4b9();
    level thread hub_post_yamantau::function_f50bc4b9();
    level thread hub_post_kgb::function_f50bc4b9();
    level thread hub_post_cuba::function_f50bc4b9();
    level thread namespace_fdde5f3d::function_f50bc4b9();
    level flag::init( "flag_dialog_player_spoke" );
    level flag::init( "flag_dialog_asked_question" );
    level flag::init( "flag_dialog_reset" );
    level flag::init( "flag_dialog_nevermind" );
    level flag::init( "flag_player_in_dialog" );
    level flag::init( "flag_in_dialog" );
    level flag::init( "flag_fidgeting" );
    level flag::init( "flag_speak_while_fidgeting" );
    level flag::init( "flag_all_greeting_vo_delivered" );
    level flag::init( "flag_all_parting_vo_delivered" );
    level flag::init( "flag_dialog_exhausted" );
    level flag::init( "flag_close_to_player" );
    level flag::init( "flag_adler_dialog_option1a" );
    level flag::init( "flag_adler_dialog_option1a2" );
    level flag::init( "flag_adler_dialog_option1b" );
    level flag::init( "flag_adler_dialog_option1b2" );
    level flag::init( "flag_adler_dialog_option1c" );
    level flag::init( "flag_adler_dialog_option1c2" );
    level flag::init( "flag_adler_dialog_option1_unlocked" );
    level flag::init( "flag_adler_dialog_option2a" );
    level flag::init( "flag_adler_dialog_option2a2" );
    level flag::init( "flag_adler_dialog_option2b" );
    level flag::init( "flag_adler_dialog_option2b2" );
    level flag::init( "flag_adler_dialog_option2c" );
    level flag::init( "flag_adler_dialog_option2c2" );
    level flag::init( "flag_adler_dialog_option2_unlocked" );
    level flag::init( "flag_adler_dialog_option3a" );
    level flag::init( "flag_adler_dialog_option3a2" );
    level flag::init( "flag_adler_dialog_option3b" );
    level flag::init( "flag_park_dialog_option1a" );
    level flag::init( "flag_park_dialog_option1a2" );
    level flag::init( "flag_park_dialog_option1b" );
    level flag::init( "flag_park_dialog_option1b2" );
    level flag::init( "flag_park_dialog_option1c" );
    level flag::init( "flag_park_dialog_option1c2" );
    level flag::init( "flag_lazar_dialog_option1a" );
    level flag::init( "flag_lazar_dialog_option1a2" );
    level flag::init( "flag_lazar_dialog_option1b" );
    level flag::init( "flag_lazar_dialog_option1b2" );
    level flag::init( "flag_lazar_dialog_option1c" );
    level flag::init( "flag_lazar_dialog_option1c2" );
    level flag::init( "flag_lazar_dialog_option1_unlocked" );
    level flag::init( "flag_sims_dialog_option1a" );
    level flag::init( "flag_sims_dialog_option1a2" );
    level flag::init( "flag_sims_dialog_option1b" );
    level flag::init( "flag_sims_dialog_option1b2" );
    level flag::init( "flag_sims_dialog_option1c" );
    level flag::init( "flag_sims_dialog_option1c2" );
    level flag::init( "flag_hudson_dialog_option1a" );
    level flag::init( "flag_hudson_dialog_option1a2" );
    level flag::init( "flag_hudson_dialog_option1b" );
    level flag::init( "flag_hudson_dialog_option1b2" );
    level flag::init( "flag_hudson_dialog_option1c" );
    level flag::init( "flag_hudson_dialog_option1c2" );
    level flag::init( "flag_woods_dialog_option1a" );
    level flag::init( "flag_woods_dialog_option1a2" );
    level flag::init( "flag_woods_dialog_option1b" );
    level flag::init( "flag_woods_dialog_option1b2" );
    level flag::init( "flag_woods_dialog_option1c" );
    level flag::init( "flag_woods_dialog_option1c2" );
    level flag::init( "flag_scene_ambient_active" );
    level flag::init( "flag_in_scene" );
    level flag::init( "flag_hub_large_complete" );
    level flag::init( "flag_hub_small_complete" );
    level flag::init( "flag_player_read_dossier" );
    level flag::init( "flag_radio_on" );
    level flag::init( "flag_tv_on" );
    level flag::init( "flag_reading_station_active" );
    level flag::init( "flag_reading_station_object_02" );
    level flag::init( "flag_player_not_in_darkroom", 1 );
    level flag::init( "flag_player_using_evidence_board" );
    level flag::init( "flag_player_used_evidence_board" );
    level flag::init( "flag_cursor_over_mission" );
    level flag::init( "flag_cursor_snapped" );
    level flag::init( "flag_review_mode_active" );
    level flag::init( "flag_post_full_board_complete" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x3cdf759e, Offset: 0x25c0
// Size: 0xf8
function function_5f05b132()
{
    a_mdls = [];
    a_mdls = getentarray( "hub_hidden_mdl", "targetname" );
    
    if ( a_mdls.size == 0 )
    {
        /#
            iprintlnbold( "<dev string:x38>" + a_mdls.size + "<dev string:x46>" );
        #/
    }
    
    foreach ( mdl in a_mdls )
    {
        mdl hide();
    }
}

/#

    // Namespace namespace_31c67f6d/namespace_89829bca
    // Params 0
    // Checksum 0x2a852611, Offset: 0x26c0
    // Size: 0x8, Type: dev
    function function_e81f8ff1()
    {
        
    }

#/

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x1a4a2b6f, Offset: 0x26d0
// Size: 0xa4
function function_9fa4f621()
{
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    init_spawnfunctions();
    level thread function_ea259f56();
    level thread function_7ad4f5cb();
    namespace_82bfe441::fade( 1, "FadeImmediate" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0, eflags: 0x4
// Checksum 0x35a29699, Offset: 0x2780
// Size: 0xfc
function private function_7ad4f5cb()
{
    level flag::wait_till( "all_players_connected" );
    a_s_interacts = struct::get_array( #"hash_3dd86258529972ca" );
    array::thread_all( a_s_interacts, &function_f78628e6 );
    level.player notifyonplayercommand( #"hash_55b6e1fbec32b71", "+stance" );
    level.player notifyonplayercommand( #"hash_55b6e1fbec32b71", "+movedown" );
    level.player notifyonplayercommand( #"hash_55b6e1fbec32b71", "+lowerstance" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0, eflags: 0x4
// Checksum 0x739b3638, Offset: 0x2888
// Size: 0x264
function private function_f78628e6()
{
    level.player endon( #"death" );
    e_interact = util::spawn_model( #"tag_origin", self.origin, self.angles );
    var_cffbeaae = struct::get( #"hash_23c049910e1e4a97" );
    assert( isdefined( self.target ) );
    var_f35de83 = struct::get( self.target );
    
    while ( true )
    {
        e_interact util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_77965c9740b1082d", 40, undefined, undefined, undefined, 150 );
        e_interact waittill( #"trigger" );
        e_interact util::delay( 0.2, undefined, &util::remove_cursor_hint );
        wait 0.5;
        self arcade_machine::function_2a291669( var_cffbeaae, var_f35de83 );
        level.player flag::set( "playing_arcade_game" );
        self arcade_machine::function_85de737f( var_f35de83 );
        level.player waittill( #"hash_55b6e1fbec32b71" );
        level.player flag::clear( "playing_arcade_game" );
        self arcade_machine::function_b6d06a2d( var_f35de83 );
        self arcade_machine::function_67a244d3( var_cffbeaae );
        level.player val::reset_all( #"arcade_machine" );
    }
    
    e_interact util::remove_cursor_hint();
    e_interact delete();
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x1582d1fe, Offset: 0x2af8
// Size: 0x84
function on_player_connect()
{
    if ( isdefined( level.var_28c22d88 ) )
    {
        util::function_f3cadc9a( "cp_player_ready" );
        
        if ( isdefined( level.var_d7d201ba ) && !self flag::exists( level.var_d7d201ba ) )
        {
            self flag::init( level.var_d7d201ba );
        }
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xda804949, Offset: 0x2b88
// Size: 0x114
function on_player_spawned()
{
    level flag::wait_till( "all_players_connected" );
    level.player = getplayers()[ 0 ];
    level.player takeallweapons();
    level.player setclientuivisibilityflag( "weapon_hud_visible", 0 );
    level.player setclientuivisibilityflag( "radar_client", 0 );
    level.player playgestureviewmodel( "dem_raise_camera" );
    level.player setcharacterbodytype( 1 );
    level.player setcharacteroutfit( 2 );
    level.player_connected = 1;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x42cc202, Offset: 0x2ca8
// Size: 0x2a4
function init_spawnfunctions()
{
    var_42acb07e = getspawnerarray( "hero_adler", "script_noteworthy" );
    array::run_all( var_42acb07e, &spawner::add_spawn_function, &function_d3918b2e, "adler" );
    var_cbd6dc94 = getspawnerarray( "hero_lazar", "script_noteworthy" );
    array::run_all( var_cbd6dc94, &spawner::add_spawn_function, &function_d3918b2e, "lazar" );
    var_3aaffb3e = getspawnerarray( "hero_park", "script_noteworthy" );
    array::run_all( var_3aaffb3e, &spawner::add_spawn_function, &function_d3918b2e, "park" );
    var_c08cab6 = getspawnerarray( "hero_sims", "script_noteworthy" );
    array::run_all( var_c08cab6, &spawner::add_spawn_function, &function_d3918b2e, "sims" );
    var_ebd0f12d = getspawnerarray( "hero_hudson", "script_noteworthy" );
    array::run_all( var_ebd0f12d, &spawner::add_spawn_function, &function_d3918b2e, "hudson" );
    var_5b7b93ad = getspawnerarray( "hero_woods", "script_noteworthy" );
    array::run_all( var_5b7b93ad, &spawner::add_spawn_function, &function_d3918b2e, "woods" );
    var_535ce24f = getspawnerarray( "hero_mason", "script_noteworthy" );
    array::run_all( var_535ce24f, &spawner::add_spawn_function, &function_d3918b2e, "mason" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0xb5451b55, Offset: 0x2f58
// Size: 0xf0
function function_d3918b2e( var_1ef13f7e )
{
    assert( isdefined( var_1ef13f7e ), "<dev string:x72>" );
    
    if ( var_1ef13f7e == "adler" )
    {
        level.adler = self;
    }
    
    if ( var_1ef13f7e == "lazar" )
    {
        level.lazar = self;
    }
    
    if ( var_1ef13f7e == "park" )
    {
        level.park = self;
    }
    
    if ( var_1ef13f7e == "sims" )
    {
        level.sims = self;
    }
    
    if ( var_1ef13f7e == "hudson" )
    {
        level.hudson = self;
    }
    
    if ( var_1ef13f7e == "woods" )
    {
        level.woods = self;
    }
    
    if ( var_1ef13f7e == "mason" )
    {
        level.mason = self;
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0xd1e7bec1, Offset: 0x3050
// Size: 0xc
function function_4613fab8( *var_d3440450 )
{
    
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 2
// Checksum 0xbe34c87d, Offset: 0x3068
// Size: 0x254
function function_13fc27ea( var_d3440450, *var_50cc0d4f )
{
    var_7a191936 = savegame::function_8136eb5a();
    level thread pstfx_teleport( 5.5, 1, 1, 1 );
    
    if ( var_7a191936 == "cp_ger_hub8" )
    {
        level namespace_fdde5f3d::main();
        level flag::wait_till( "flag_wait_forever" );
    }
    
    if ( var_7a191936 == "cp_ger_hub_post_cuba" )
    {
        level hub_post_cuba::main();
        level flag::wait_till( "flag_wait_forever" );
    }
    
    if ( var_7a191936 == "cp_ger_hub_post_kgb" )
    {
        level hub_post_kgb::main();
        level flag::wait_till( "flag_wait_forever" );
    }
    
    if ( var_7a191936 == "cp_ger_hub_post_yamantau" )
    {
        level hub_post_yamantau::main();
        level flag::wait_till( "flag_wait_forever" );
    }
    
    if ( var_7a191936 == "cp_ger_hub_post_armada" )
    {
        level hub_post_armada::main();
        level flag::wait_till( "flag_wait_forever" );
    }
    
    if ( var_7a191936 == "cp_ger_hub" )
    {
        if ( is_true( savegame::function_2ee66e93( #"hash_2895afd5f948f51" ) ) )
        {
            level hub_post_takedown::main();
            level flag::wait_till( "flag_wait_forever" );
        }
    }
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x2c90bf30, Offset: 0x32c8
// Size: 0x124
function function_a2af041c()
{
    level.player val::set( #"temp_intro", "show_hud", 0 );
    level.player val::set( #"temp_intro", "freezecontrols" );
    level.player val::set( #"temp_intro", "disable_weapons" );
    level.player val::set( #"temp_intro", "takedamage", 0 );
    level.player val::set( #"temp_intro", "allowdeath", 0 );
    level.player val::set( #"temp_intro", "hide" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x60ac4081, Offset: 0x33f8
// Size: 0x124
function function_cbec2adc()
{
    level.player val::set( #"temp_intro", "show_hud", 0 );
    level.player val::set( #"temp_intro", "freezecontrols" );
    level.player val::set( #"temp_intro", "disable_weapons" );
    level.player val::set( #"temp_intro", "takedamage", 0 );
    level.player val::set( #"temp_intro", "allowdeath", 0 );
    level.player val::set( #"temp_intro", "hide" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0xad854c9a, Offset: 0x3528
// Size: 0xc
function function_b438df4d( *var_d3440450 )
{
    
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 2
// Checksum 0x309e0591, Offset: 0x3540
// Size: 0x134
function function_58f8a0d8( var_d3440450, *var_50cc0d4f )
{
    videostart( "Vietnam_Brainwash_v1", 1 );
    
    if ( isdefined( level.var_d7d201ba ) && isdefined( level.var_28c22d88 ) )
    {
        level.player flag::set( level.var_d7d201ba );
    }
    
    level.player freezecontrols( 1 );
    level.player namespace_70eba6e6::function_f8bd1258();
    level thread pstfx_teleport( 5.5, 1, 1, 1 );
    level.player freezecontrols( 0 );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        savegame::checkpoint_save( 1 );
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 3
// Checksum 0x57557bf1, Offset: 0x3680
// Size: 0x20c
function function_6194f34a( var_8ced85ea, var_3223cb64, *var_ef49aa65 = 0 )
{
    while ( !isdefined( level.player ) )
    {
        waitframe( 1 );
    }
    
    s_player_start = struct::get( "s_default_player_start", "targetname" );
    
    if ( isdefined( s_player_start ) )
    {
        level.player setorigin( s_player_start.origin );
        level.player setplayerangles( s_player_start.angles );
    }
    
    level.var_f5552371 = var_3223cb64;
    level function_91c383b1( var_3223cb64 );
    level function_1f4ed1b4( var_3223cb64 );
    waitframe( 1 );
    level.player thread clientfield::set_to_player( "set_hub_fov", 3 );
    level.player clientfield::set_to_player( "set_hub_dof", 1 );
    
    if ( var_ef49aa65 == 0 )
    {
        level thread function_a422a4a9();
    }
    
    if ( is_true( level.var_70888df5 ) && !( var_3223cb64 == "post_prisoner" ) )
    {
        level.player thread namespace_fa335fda::function_12624bb8( var_3223cb64, "eboard_ready" );
    }
    else
    {
        level.player thread namespace_cd80be1c::function_3fc4da12( var_3223cb64, "eboard_ready" );
    }
    
    level thread function_15231086( "eboard_ready" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0x601e05ca, Offset: 0x3898
// Size: 0x5b0
function function_91c383b1( chapter )
{
    assert( isdefined( chapter ), "<dev string:x90>" );
    level.a_ai_allies = [];
    level.var_58ccee4 = [];
    
    switch ( chapter )
    {
        case #"post_takedown":
            var_959954b3 = [ "adler", "park", "lazar", "sims" ];
            break;
        case #"post_armada":
            var_959954b3 = [ "adler", "park", "lazar", "sims" ];
            break;
        case #"post_yamantau":
            var_959954b3 = [ "adler", "park", "lazar", "sims", "hudson" ];
            break;
        case #"post_kgb":
            var_959954b3 = [ "adler", "park", "lazar", "sims", "hudson", "woods", "mason" ];
            break;
        case #"post_cuba":
            level.var_ea95c1e7 = function_c9dc0e79();
            
            if ( level.var_ea95c1e7 != "sims" )
            {
                var_959954b3 = [ "adler", "sims", "hudson", level.var_ea95c1e7 ];
            }
            else
            {
                var_959954b3 = [ "adler", "hudson", level.var_ea95c1e7 ];
            }
            
            break;
        case #"post_prisoner":
            level.var_ea95c1e7 = function_c9dc0e79();
            
            if ( level.var_ea95c1e7 != "sims" )
            {
                var_959954b3 = [ "adler", "sims", level.var_ea95c1e7 ];
            }
            else
            {
                var_959954b3 = [ "adler", level.var_ea95c1e7 ];
            }
            
            if ( level.var_ea95c1e7 == "lazar" )
            {
                var_ac85c33a = getent( "park", "targetname" );
                var_ac85c33a delete();
            }
            
            if ( level.var_ea95c1e7 == "park" )
            {
                var_ac85c33a = getent( "lazar", "targetname" );
                var_ac85c33a delete();
            }
            
            break;
        default:
            /#
                iprintlnbold( "<dev string:xc8>" );
            #/
            
            break;
    }
    
    foreach ( str_spawner in var_959954b3 )
    {
        ai = spawner::simple_spawn( str_spawner );
        level.a_ai_allies[ level.a_ai_allies.size ] = ai;
        level.var_58ccee4[ level.var_58ccee4.size ] = ai[ 0 ];
        
        if ( isdefined( ai ) && ai.size > 0 )
        {
            ai[ 0 ] flag::init( "show_dialog_options" );
            ai[ 0 ] flag::init( "show_ally_in_position" );
            ai[ 0 ] flag::init( "fidgeting_done" );
            ai[ 0 ] flag::init( "flag_fidget_interrupt_start" );
        }
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0x46a9c3e6, Offset: 0x3e50
// Size: 0x6a0
function function_1f4ed1b4( var_8ced85ea )
{
    a_mdls = [];
    
    switch ( var_8ced85ea )
    {
        case #"post_takedown":
            a_mdls = level function_23128418( a_mdls );
            mdl = getent( "hub_mdl_maptable_briefcase_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_mug_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_mug_02", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_ashtray_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_lighter_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_folder_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_tape_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_papers_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_papers_02", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_recorder_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_case_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_passport_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_passport_02", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_amp_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_maptable_snack_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_computer_tarp_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            break;
        case #"post_armada":
            a_mdls = level function_23128418( a_mdls );
            mdl = getent( "hub_mdl_puddle_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_puddle_02", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_puddle_03", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_puddle_04", "script_noteworthy" );
            array::add( a_mdls, mdl );
            mdl = getent( "hub_mdl_bucket_01", "script_noteworthy" );
            array::add( a_mdls, mdl );
            break;
        case #"post_yamantau":
            a_mdls = level function_31d12195( a_mdls );
            var_b8337ef7 = getentarray( "post_yamantau_only_models", "script_noteworthy" );
            a_mdls = arraycombine( a_mdls, var_b8337ef7 );
            break;
        case #"post_kgb":
            a_mdls = level function_31d12195( a_mdls );
            break;
        case #"post_cuba":
            a_mdls = level function_31d12195( a_mdls );
            break;
        case #"post_prisoner":
            a_mdls = level function_31d12195( a_mdls );
            break;
    }
    
    foreach ( mdl in a_mdls )
    {
        mdl show();
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0xb9437eeb, Offset: 0x44f8
// Size: 0x140
function function_23128418( a_mdls )
{
    mdl = getent( "hub_mdl_tarp_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_tarp_02", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_sheet_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_boxing_worklight", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_computer_01", "script_noteworthy" );
    level.var_b8e8fb10 = mdl;
    array::add( a_mdls, mdl );
    return a_mdls;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0x8eda5916, Offset: 0x4640
// Size: 0x638
function function_31d12195( a_mdls )
{
    mdl = getent( "hub_mdl_lounge_chair", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_lounge_chair_clip", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_evidence_box_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_evidence_box_02", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_evidence_box_03", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_liquor_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_station_chair_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_station_chair_02", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_computer_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_floodlight_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_floodlight_02", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_paper_bag_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_rifle_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_pistol_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_pistol_02", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_food_container_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_food_container_02", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_crushed_can_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_trash_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_trash_02", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_trash_03", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_backroom_cart_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_backroom_tapes_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_backroom_tape_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_backroom_tv_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_backroom_papers_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_backroom_vcr_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    mdl = getent( "hub_mdl_backroom_supplies_01", "script_noteworthy" );
    array::add( a_mdls, mdl );
    return a_mdls;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 2
// Checksum 0x7affdc53, Offset: 0x4c80
// Size: 0xf4
function function_82743d25( var_8ced85ea, var_ef49aa65 )
{
    var_45ddb155 = [ "post_takedown", "post_armada", "post_yamantau", "post_kgb", "post_cuba", "post_prisoner" ];
    
    for ( i = 0; i < var_45ddb155.size ; i++ )
    {
        if ( var_8ced85ea === var_45ddb155[ i ] )
        {
            var_af175293 = i;
            break;
        }
    }
    
    level thread util::delay( var_ef49aa65, undefined, &globallogic_ui::function_7bc0e4b9, 1, var_af175293 );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0xccf8374e, Offset: 0x4d80
// Size: 0x7c
function function_15231086( str_notify )
{
    if ( isdefined( str_notify ) )
    {
        level waittill( str_notify );
    }
    
    var_21de0571 = struct::get( "hint_evidence_board", "targetname" );
    level objectives::goto( "obj_use_board", var_21de0571.origin, #"hash_2f7e787370cedff6" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 4
// Checksum 0xe0272c1c, Offset: 0x4e08
// Size: 0x470
function function_7fd3a4d8( var_7784a8ae = 0, var_a8627b29 = undefined, n_wait_time = undefined, var_ef49aa65 = 0 )
{
    foreach ( var_3d43d7b8 in level.a_ai_allies )
    {
        var_3d43d7b8[ 0 ] flag::set( "flag_in_scene" );
        var_3d43d7b8[ 0 ] thread function_ac8d8290();
    }
    
    if ( var_7784a8ae == 1 )
    {
        while ( !isdefined( level.player_connected ) && level.player_connected != 1 )
        {
            waitframe( 1 );
        }
        
        if ( isdefined( n_wait_time ) && n_wait_time > 0 )
        {
            wait n_wait_time;
        }
        
        if ( isdefined( level.var_d7d201ba ) && isdefined( level.var_28c22d88 ) )
        {
            level.player flag::set( level.var_d7d201ba );
        }
        
        level scene::skipto_end( "scene_hub_" + level.var_f5552371 + "_briefing", undefined, undefined, undefined, 0 );
        waitframe( 1 );
        
        foreach ( var_3d43d7b8 in level.a_ai_allies )
        {
            var_3d43d7b8[ 0 ] notify( #"dialog_ready" );
        }
    }
    else
    {
        level thread scene::init( "scene_hub_" + level.var_f5552371 + "_briefing" );
        
        while ( !isdefined( level.player_connected ) && level.player_connected != 1 )
        {
            waitframe( 1 );
        }
        
        if ( isdefined( n_wait_time ) && n_wait_time > 0 )
        {
            wait n_wait_time;
        }
        
        if ( isdefined( level.var_d7d201ba ) && isdefined( level.var_28c22d88 ) )
        {
            level.player flag::set( level.var_d7d201ba );
        }
        
        level thread function_82743d25( level.var_f5552371, var_ef49aa65 );
        level thread namespace_4ed3ce47::function_7edafa59( level.var_f5552371 + "_briefing" );
        
        if ( !isdefined( var_a8627b29 ) )
        {
            level scene::play( "scene_hub_" + level.var_f5552371 + "_briefing" );
        }
        else
        {
            level scene::play_from_time( "scene_hub_" + level.var_f5552371 + "_briefing", undefined, undefined, var_a8627b29, 0 );
        }
    }
    
    foreach ( var_3d43d7b8 in level.a_ai_allies )
    {
        var_3d43d7b8[ 0 ] flag::clear( "flag_in_scene" );
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 3
// Checksum 0x50e5c07c, Offset: 0x5280
// Size: 0xa4
function function_ac8d8290( var_5d4b50a7, var_750bd08, var_e0db02bb )
{
    self waittill( #"dialog_ready" );
    
    if ( isdefined( var_5d4b50a7 ) )
    {
        self scene::stop( "false", var_5d4b50a7 );
        
        if ( isdefined( var_750bd08 ) )
        {
            level thread scene::play( var_750bd08, var_e0db02bb );
        }
    }
    
    self flag::clear( "flag_in_scene" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xc861a1ec, Offset: 0x5330
// Size: 0xbae
function function_95e9dca3()
{
    self endon( #"hash_5704775be690735b" );
    
    if ( !isdefined( self.var_ba1eee16.var_890ce7a8 ) )
    {
        self.var_ba1eee16.allow_movement = 0;
    }
    
    if ( !isdefined( self.var_ba1eee16.var_18674cfa ) )
    {
        self.var_ba1eee16.var_18674cfa = 1;
    }
    
    if ( !isdefined( self.var_ba1eee16.v_offset ) )
    {
        self.var_ba1eee16.v_offset = ( 0, 0, 8 );
    }
    
    if ( !isdefined( self.var_ba1eee16.var_94c6ba73 ) )
    {
        self.var_ba1eee16.var_94c6ba73 = 0;
    }
    
    if ( !isdefined( self.var_ba1eee16.var_9adc53b6 ) )
    {
        self.var_ba1eee16.var_9adc53b6 = 0;
    }
    
    if ( !isdefined( self.var_ba1eee16.var_14ee760c ) )
    {
        self.var_ba1eee16.var_14ee760c = 0;
    }
    
    self.var_ba1eee16.var_f16ae1ba = 0;
    self.var_ba1eee16.var_c97a6a24 = 0;
    self.var_ba1eee16.var_91f6b4c9 = 0;
    self.var_ba1eee16.var_f2190d3d = "scene_hub_" + level.var_f5552371 + "_dialog_" + self.animname;
    self waittill( #"dialog_ready" );
    self scene::stop( "false", "scene_hub_" + level.var_f5552371 + "_briefing" );
    level thread scene::play( self.var_ba1eee16.var_f2190d3d, "zone_idle" );
    
    if ( isdefined( self.var_ba1eee16.var_91756769 ) )
    {
        wait self.var_ba1eee16.var_91756769;
    }
    
    self.var_ba1eee16.s_tree = dialog_tree::new_tree( &function_282ccb63, &function_7b9b6d21, self.var_ba1eee16.var_890ce7a8, 0 );
    self.var_ba1eee16.s_tree.scriptbundle = self.var_ba1eee16.var_f2190d3d;
    
    if ( isdefined( self.var_ba1eee16.var_cc88ab09 ) )
    {
        for ( i = 0; i < self.var_ba1eee16.var_cc88ab09.size ; i++ )
        {
            for ( j = 0; j < self.var_ba1eee16.var_cc88ab09[ i ].size ; j++ )
            {
                for ( k = 0; k < self.var_ba1eee16.var_cc88ab09[ i ][ j ].size ; k++ )
                {
                    if ( i == 0 && k == 0 )
                    {
                        self.var_ba1eee16.s_tree dialog_tree::add_option( self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 0 ], self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 1 ], self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 2 ], "waiting_idle", self.var_ba1eee16.var_94c6ba73, "flag_" + self.animname + "_dialog_option" + i + j + k, "flag_" + self.animname + "_dialog_option" + i + j + k, &function_7942fda9, self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ] );
                        continue;
                    }
                    
                    if ( i == 0 && k >= 1 )
                    {
                        self.var_ba1eee16.s_tree dialog_tree::function_9e36808( self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 0 ], self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 1 ], self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 2 ], "waiting_idle", 0, "flag_" + self.animname + "_dialog_option" + i + j + k, "flag_" + self.animname + "_dialog_option" + i + j + k, &function_7942fda9, self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ] );
                        continue;
                    }
                    
                    if ( i > 0 && k == 0 )
                    {
                        self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "flag_" + self.animname + "_dialog_option" + i + "_unlocked", self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 0 ], self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 1 ], self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 2 ], "waiting_idle", self.var_ba1eee16.var_14ee760c, "flag_" + self.animname + "_dialog_option" + i + j + k, "flag_" + self.animname + "_dialog_option" + i + j + k, &function_7942fda9, self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ] );
                        continue;
                    }
                    
                    if ( i > 0 && k >= 1 )
                    {
                        self.var_ba1eee16.s_tree dialog_tree::function_9e36808( self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 0 ], self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 1 ], self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ][ 2 ], "waiting_idle", 0, "flag_" + self.animname + "_dialog_option" + i + j + k, "flag_" + self.animname + "_dialog_option" + i + j + k, &function_7942fda9, self.var_ba1eee16.var_cc88ab09[ i ][ j ][ k ] );
                    }
                }
            }
        }
    }
    
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "flag_dialog_reset", self.var_ba1eee16.var_a6bf452, undefined, undefined, undefined, 1, "flag_dialog_nevermind", "forever" );
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "flag_dialog_asked_question", self.var_ba1eee16.var_5956b0f3, undefined, self.var_ba1eee16.var_274d9415, undefined, 1, undefined, undefined, &function_df035a54 );
    self.var_ba1eee16.s_tree dialog_tree::function_f5d1891( "flag_dialog_asked_question", self.var_ba1eee16.var_5956b0f3, undefined, self.var_ba1eee16.var_274d9415, undefined, 1, undefined, undefined, &function_df035a54 );
    self.var_ba1eee16.s_tree dialog_tree::function_f5d1891( "flag_dialog_asked_question", self.var_ba1eee16.var_5956b0f3, undefined, self.var_ba1eee16.var_274d9415, undefined, 1, undefined, undefined, &function_df035a54 );
    self.var_ba1eee16.s_tree dialog_tree::function_f5d1891( "flag_dialog_asked_question", self.var_ba1eee16.var_5956b0f3, undefined, self.var_ba1eee16.var_274d9415, undefined, 1, undefined, undefined, &function_df035a54 );
    self.var_ba1eee16.s_tree dialog_tree::function_f5d1891( "flag_dialog_asked_question", self.var_ba1eee16.var_5956b0f3, undefined, self.var_ba1eee16.var_274d9415, undefined, 1, undefined, undefined, &function_df035a54 );
    self.var_ba1eee16.s_tree dialog_tree::function_f5d1891( "flag_dialog_asked_question", self.var_ba1eee16.var_5956b0f3, undefined, self.var_ba1eee16.var_274d9415, undefined, 1, undefined, undefined, &function_df035a54 );
    
    while ( true )
    {
        if ( !self flag::get( "flag_in_scene" ) && !self flag::get( "flag_in_dialog" ) && !level flag::get( "flag_player_in_dialog" ) && !level flag::get( "flag_player_using_evidence_board" ) )
        {
            waitframe( 1 );
            self dialog_tree::function_cfa96cee( self.var_ba1eee16.s_tree, undefined, undefined, "kill_dialog", 160, 240, undefined, self.var_ba1eee16.v_offset );
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xb824fc4e, Offset: 0x5ee8
// Size: 0x3ae
function function_7b0516d7()
{
    self endon( #"hash_5704775be690735b" );
    
    if ( !isdefined( self.var_ba1eee16.v_offset ) )
    {
        self.var_ba1eee16.v_offset = ( 0, 0, 8 );
    }
    
    self.var_ba1eee16.var_f16ae1ba = 0;
    self.var_ba1eee16.var_91f6b4c9 = 0;
    self.var_ba1eee16.var_f2190d3d = "scene_hub_" + level.var_f5552371 + "_dialog_" + self.animname;
    self waittill( #"dialog_ready" );
    self scene::stop( "false", "scene_hub_" + level.var_f5552371 + "_briefing" );
    level thread scene::play( self.var_ba1eee16.var_f2190d3d, "zone_idle" );
    
    if ( isdefined( self.var_ba1eee16.var_91756769 ) )
    {
        wait self.var_ba1eee16.var_91756769;
    }
    
    self.radius = 2.5;
    
    if ( self haspart( "j_spine4" ) )
    {
        tagname = "j_spine4";
    }
    else
    {
        tagname = undefined;
    }
    
    interactstring = #"OBJECTIVES/TALK_TO";
    
    while ( true )
    {
        if ( !self flag::get( "flag_in_scene" ) && !self flag::get( "flag_in_dialog" ) && !level flag::get( "flag_player_in_dialog" ) && !level flag::get( "flag_player_using_evidence_board" ) )
        {
            waitframe( 1 );
            self util::create_cursor_hint( tagname, self.var_ba1eee16.v_offset, interactstring, 160, undefined, undefined, undefined, undefined, 0 );
            self prompts::function_92127496( 1 );
            self prompts::function_1a5e1da6( #"use", 1 );
            msg = self waittill( #"trigger", #"death", #"start_context_melee", #"deleted", #"kill_dialog" );
            
            if ( msg._notify == "trigger" )
            {
                if ( self.var_ba1eee16.s_tree dialog_tree::function_6a2674b8() > 1 )
                {
                    self.var_ba1eee16.s_tree dialog_tree::run( self );
                }
                else
                {
                    self thread function_aad62702();
                }
            }
            else
            {
                self util::remove_cursor_hint();
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 2
// Checksum 0xf3780e63, Offset: 0x62a0
// Size: 0x25c
function function_7942fda9( var_2bdad064, var_bdaf74c3 )
{
    if ( isdefined( var_2bdad064[ 4 ] ) )
    {
        level flag::set( var_2bdad064[ 4 ] );
    }
    
    if ( isdefined( var_2bdad064[ 5 ] ) )
    {
        level flag::set( var_2bdad064[ 5 ] );
    }
    
    if ( isdefined( var_2bdad064[ 6 ] ) )
    {
        level flag::set( var_2bdad064[ 6 ] );
    }
    
    level flag::set( "flag_dialog_player_spoke" );
    level thread function_c15440f4();
    n_length = 0.01;
    
    if ( is_true( var_bdaf74c3 ) )
    {
        level thread scene::play( self.var_ba1eee16.var_f2190d3d, var_2bdad064[ 2 ] );
        n_length = scene::function_8582657c( self.var_ba1eee16.var_f2190d3d, var_2bdad064[ 2 ] );
    }
    
    s_notify = self waittilltimeout( n_length, #"dialog_tree_cancel_response", #"run_function", #"end_shot" );
    self flag::clear( "_dialog_anim_playing" );
    
    if ( s_notify._notify === "dialog_tree_cancel_response" )
    {
        self stopsounds();
    }
    
    if ( isdefined( var_2bdad064[ 3 ] ) )
    {
        self [[ var_2bdad064[ 3 ] ]]();
    }
    
    if ( is_true( var_bdaf74c3 ) )
    {
        level thread scene::play( self.var_ba1eee16.var_f2190d3d, "waiting_idle" );
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x9a4f4f, Offset: 0x6508
// Size: 0x224
function function_282ccb63()
{
    function_a99a7273();
    
    if ( !isdefined( self.var_ba1eee16.n_fov ) )
    {
        self.var_ba1eee16.n_fov = 5;
    }
    
    if ( !isdefined( self.var_ba1eee16.var_e1eebb0b ) )
    {
        self.var_ba1eee16.var_e1eebb0b = 2;
    }
    
    if ( !self flag::get( "flag_dialog_exhausted" ) )
    {
        thread namespace_4ed3ce47::dia_focus_on();
        
        if ( isdefined( self.var_ba1eee16.var_82a12581 ) )
        {
            self thread function_a07bfe0f();
        }
        
        self util::delay( 0.3, undefined, &function_3f024e94 );
        level.player thread clientfield::set_to_player( "set_hub_dof", self.var_ba1eee16.var_e1eebb0b );
        level.player thread clientfield::set_to_player( "set_hub_fov", self.var_ba1eee16.n_fov );
        self function_bd82b8ad();
        self thread function_250d203b();
        self thread function_875a5bea();
        self function_7cccaccb();
        self thread function_29699066();
        self function_fba5945d();
        self flag::wait_till( "show_dialog_options" );
        self childthread function_208b416c();
        return;
    }
    
    self thread function_aad62702();
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x4c229ae7, Offset: 0x6738
// Size: 0x44
function function_208b416c()
{
    waitframe( 1 );
    self flag::clear( "show_dialog_options" );
    self flag::clear( "show_ally_in_position" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x641feac5, Offset: 0x6788
// Size: 0x164
function function_bd82b8ad()
{
    level.var_4d1402c5 = undefined;
    var_5f75397b = vectornormalize( level.player.origin - self.origin );
    v_forward = anglestoforward( self.angles );
    var_3f9826ab = vectordot( var_5f75397b, v_forward );
    v_right = anglestoright( self.angles );
    var_8ecbd20e = vectordot( var_5f75397b, v_right );
    
    if ( var_3f9826ab >= 0.7 )
    {
        level.var_4d1402c5 = "player_in_front";
        return;
    }
    
    if ( var_3f9826ab <= -0.7 )
    {
        level.var_4d1402c5 = "player_in_back";
        return;
    }
    
    if ( var_8ecbd20e <= -0.7 )
    {
        if ( isdefined( self.var_d68b6f08 ) )
        {
            level.var_4d1402c5 = self.var_d68b6f08;
        }
        else
        {
            level.var_4d1402c5 = "player_to_left";
        }
        
        return;
    }
    
    level.var_4d1402c5 = "player_to_right";
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xafb2f24d, Offset: 0x68f8
// Size: 0x23c
function function_250d203b()
{
    if ( !isdefined( self.var_ba1eee16.var_142355f9 ) )
    {
        self.var_ba1eee16.var_142355f9 = array( 1224, 650 );
    }
    
    if ( !isdefined( self.var_ba1eee16.var_9b7161e6 ) )
    {
        self.var_ba1eee16.var_9b7161e6 = array( 1224, 650 );
    }
    
    if ( !isdefined( self.var_ba1eee16.var_e9797a7f ) )
    {
        self.var_ba1eee16.var_e9797a7f = array( 1224, 650 );
    }
    
    if ( !isdefined( self.var_ba1eee16.var_cbdef43f ) )
    {
        self.var_ba1eee16.var_cbdef43f = array( 1224, 650 );
    }
    
    if ( level.var_4d1402c5 == "player_in_front" )
    {
        level dialog_tree::function_21780fc5( self.var_ba1eee16.s_tree, self.var_ba1eee16.var_142355f9 );
    }
    
    if ( level.var_4d1402c5 == "player_in_back" )
    {
        level dialog_tree::function_21780fc5( self.var_ba1eee16.s_tree, self.var_ba1eee16.var_9b7161e6 );
    }
    
    if ( level.var_4d1402c5 == "player_to_right" )
    {
        level dialog_tree::function_21780fc5( self.var_ba1eee16.s_tree, self.var_ba1eee16.var_e9797a7f );
    }
    
    if ( level.var_4d1402c5 == "player_to_left" )
    {
        level dialog_tree::function_21780fc5( self.var_ba1eee16.s_tree, self.var_ba1eee16.var_cbdef43f );
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x6692ed0, Offset: 0x6b40
// Size: 0x252
function function_875a5bea()
{
    if ( !isdefined( self.var_ba1eee16.str_location ) )
    {
        self.var_ba1eee16.str_location = "";
    }
    
    switch ( level.var_4d1402c5 )
    {
        case #"player_in_front":
            level thread scene::play( "scene_hub_" + level.var_f5552371 + "_dialog_player", "talk_" + self.animname + "_" + self.var_ba1eee16.str_location + "_front" );
            break;
        case #"player_in_back":
            level thread scene::play( "scene_hub_" + level.var_f5552371 + "_dialog_player", "talk_" + self.animname + "_" + self.var_ba1eee16.str_location + "_behind" );
            break;
        case #"player_to_right":
            level thread scene::play( "scene_hub_" + level.var_f5552371 + "_dialog_player", "talk_" + self.animname + "_" + self.var_ba1eee16.str_location + "_right" );
            break;
        case #"player_to_left":
            level thread scene::play( "scene_hub_" + level.var_f5552371 + "_dialog_player", "talk_" + self.animname + "_" + self.var_ba1eee16.str_location + "_left" );
            break;
        default:
            /#
                iprintlnbold( "<dev string:x104>" );
            #/
            
            break;
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x6012da4a, Offset: 0x6da0
// Size: 0x1e4
function function_29699066()
{
    switch ( level.var_4d1402c5 )
    {
        case #"player_in_front":
            level scene::play( self.var_ba1eee16.var_f2190d3d, "enter_forward" );
            break;
        case #"player_in_back":
            level scene::play( self.var_ba1eee16.var_f2190d3d, "enter_behind" );
            break;
        case #"player_to_right":
            level scene::play( self.var_ba1eee16.var_f2190d3d, "enter_right" );
            break;
        case #"player_to_left":
            level scene::play( self.var_ba1eee16.var_f2190d3d, "enter_left" );
            break;
        default:
            /#
                iprintlnbold( "<dev string:x104>" );
            #/
            
            break;
    }
    
    self function_daffdf1( self.var_ba1eee16.var_f2190d3d );
    
    if ( !level flag::get( "flag_dialog_player_spoke" ) )
    {
        level thread scene::play( self.var_ba1eee16.var_f2190d3d, "waiting_idle" );
    }
    
    self flag::set( "show_ally_in_position" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0x64ab1bcb, Offset: 0x6f90
// Size: 0x7a
function function_daffdf1( scene )
{
    assert( isdefined( scene ), "<dev string:x123>" );
    s_scene = struct::get( scene, "targetname" );
    s_scene.origin = self.origin;
    s_scene.angles = self.angles;
    return s_scene;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x98947d3c, Offset: 0x7018
// Size: 0x20c
function function_7b9b6d21()
{
    if ( !isdefined( self.var_ba1eee16.var_18674cfa ) || self.var_ba1eee16.var_18674cfa )
    {
        level notify( #"hash_1745d1d7e74ea81b" );
        level thread namespace_4ed3ce47::dia_focus_off();
        
        if ( isdefined( self.var_ba1eee16.var_d0816878 ) )
        {
            self thread function_f62f3fea();
        }
        
        level flag::set( "flag_dialog_player_spoke" );
        
        if ( !self flag::get( "flag_dialog_exhausted" ) )
        {
            if ( !isdefined( self.var_ba1eee16.var_6edf22e1 ) || !self.var_ba1eee16.var_6edf22e1 )
            {
                self thread function_8c594bc7();
            }
            
            level thread function_6441ea33();
            level flag::clear( "flag_dialog_asked_question" );
            level flag::clear( "flag_dialog_nevermind" );
            level flag::clear( "flag_dialog_player_spoke" );
        }
        
        if ( isdefined( self.var_ba1eee16.var_85ed2b41 ) && level flag::get_all( self.var_ba1eee16.var_85ed2b41 ) )
        {
            self thread function_28c8705b();
        }
        
        return;
    }
    
    level util::delay( 6, undefined, &flag::clear, "flag_player_in_dialog" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x43b6b2c6, Offset: 0x7230
// Size: 0x204
function function_8c594bc7()
{
    level util::delay( 3, undefined, &flag::clear, "flag_player_in_dialog" );
    
    switch ( level.var_4d1402c5 )
    {
        case #"player_in_front":
            level scene::play( self.var_ba1eee16.var_f2190d3d, "exit_forward" );
            break;
        case #"player_in_back":
            level scene::play( self.var_ba1eee16.var_f2190d3d, "exit_behind" );
            break;
        case #"player_to_right":
            level scene::play( self.var_ba1eee16.var_f2190d3d, "exit_right" );
            break;
        case #"player_to_left":
            level scene::play( self.var_ba1eee16.var_f2190d3d, "exit_left" );
            break;
        default:
            level scene::play( self.var_ba1eee16.var_f2190d3d, "exit_forward" );
            iprintlnbold( "Using Default Exit!" );
            break;
    }
    
    level thread scene::play( self.var_ba1eee16.var_f2190d3d, "zone_idle" );
    self util::delay( 0.1, undefined, &flag::clear, "flag_in_dialog" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x48db6660, Offset: 0x7440
// Size: 0xbc
function function_6441ea33()
{
    s_scene = struct::get( "scene_hub_player_dialog_exit", "targetname" );
    s_scene.origin = level.player.origin;
    s_scene.angles = level.player.angles;
    level.player thread function_30be2431();
    s_scene scene::play( "scene_hub_player_dialog_exit" );
    level.player playgestureviewmodel( "dem_raise_camera" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xc45a5fa3, Offset: 0x7508
// Size: 0x5c
function function_30be2431()
{
    wait 0.5;
    level.player clientfield::set_to_player( "set_hub_fov", 2 );
    level.player clientfield::set_to_player( "set_hub_dof", 1 );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x88810112, Offset: 0x7570
// Size: 0x66
function function_28c8705b()
{
    level flag::wait_till_clear( "flag_player_in_dialog" );
    self notify( #"hash_5704775be690735b" );
    self flag::set( "flag_dialog_exhausted" );
    self notify( #"dialog_ready" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x7741c8e5, Offset: 0x75e0
// Size: 0x2d0
function function_3f024e94()
{
    if ( !isdefined( self.var_ba1eee16.var_c5c9acca ) )
    {
        self flag::wait_till( "show_ally_in_position" );
        self flag::set( "show_dialog_options" );
        return;
    }
    
    if ( self flag::get( "flag_all_greeting_vo_delivered" ) )
    {
        if ( self.var_ba1eee16.var_c5c9acca.size - 1 >= 1 )
        {
            self.var_ba1eee16.var_f16ae1ba = randomintrange( 1, self.var_ba1eee16.var_c5c9acca.size - 1 );
        }
        else
        {
            self.var_ba1eee16.var_f16ae1ba = 0;
        }
    }
    
    if ( isdefined( self.var_ba1eee16.var_c5c9acca[ self.var_ba1eee16.var_f16ae1ba ] ) )
    {
        if ( isdefined( self.var_ba1eee16.var_c5c9acca[ self.var_ba1eee16.var_f16ae1ba ][ 1 ] ) )
        {
            level thread util::delay( self.var_ba1eee16.var_c5c9acca[ self.var_ba1eee16.var_f16ae1ba ][ 1 ], undefined, &dialogue::radio, self.var_ba1eee16.var_c5c9acca[ self.var_ba1eee16.var_f16ae1ba ][ 0 ] );
        }
        else
        {
            dialogue::radio( self.var_ba1eee16.var_c5c9acca[ self.var_ba1eee16.var_f16ae1ba ][ 0 ] );
        }
        
        if ( isdefined( self.var_ba1eee16.var_c5c9acca[ self.var_ba1eee16.var_f16ae1ba ][ 2 ] ) )
        {
            wait self.var_ba1eee16.var_c5c9acca[ self.var_ba1eee16.var_f16ae1ba ][ 2 ];
        }
    }
    
    self flag::wait_till( "show_ally_in_position" );
    self flag::set( "show_dialog_options" );
    
    if ( self.var_ba1eee16.var_f16ae1ba >= self.var_ba1eee16.var_c5c9acca.size - 1 )
    {
        self flag::set( "flag_all_greeting_vo_delivered" );
        return;
    }
    
    self.var_ba1eee16.var_f16ae1ba++;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x6502d99c, Offset: 0x78b8
// Size: 0x248
function function_df035a54()
{
    if ( !isdefined( self.var_ba1eee16.var_274d9415 ) )
    {
        self.var_ba1eee16.var_274d9415 = undefined;
    }
    
    if ( !isdefined( self.var_ba1eee16.var_97e686a7 ) )
    {
        return;
    }
    
    level flag::set( "flag_dialog_player_spoke" );
    
    if ( self flag::get( "flag_all_parting_vo_delivered" ) )
    {
        if ( self.var_ba1eee16.var_c5c9acca.size - 1 > 0 )
        {
            self.var_ba1eee16.var_f16ae1ba = randomintrange( 1, self.var_ba1eee16.var_c5c9acca.size - 1 );
        }
        else
        {
            self.var_ba1eee16.var_f16ae1ba = 0;
        }
    }
    
    if ( isdefined( self.var_ba1eee16.var_97e686a7[ self.var_ba1eee16.var_c97a6a24 ] ) )
    {
        if ( isdefined( self.var_ba1eee16.var_97e686a7[ self.var_ba1eee16.var_c97a6a24 ][ 1 ] ) )
        {
            level thread util::delay( self.var_ba1eee16.var_97e686a7[ self.var_ba1eee16.var_c97a6a24 ][ 1 ], undefined, &dialogue::radio, self.var_ba1eee16.var_97e686a7[ self.var_ba1eee16.var_c97a6a24 ][ 0 ] );
        }
        else
        {
            dialogue::radio( self.var_ba1eee16.var_97e686a7[ self.var_ba1eee16.var_c97a6a24 ][ 0 ] );
        }
    }
    
    if ( self.var_ba1eee16.var_c97a6a24 >= self.var_ba1eee16.var_97e686a7.size - 1 )
    {
        self flag::set( "flag_all_parting_vo_delivered" );
        return;
    }
    
    self.var_ba1eee16.var_c97a6a24++;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xd0563ed4, Offset: 0x7b08
// Size: 0x274
function function_aad62702()
{
    if ( !isdefined( self.var_ba1eee16.var_962cbf19 ) )
    {
        return;
    }
    
    var_8c3f52f6 = 6;
    self flag::set( "flag_in_dialog" );
    
    if ( !self flag::get( "flag_speak_while_fidgeting" ) )
    {
        while ( self flag::get( "flag_fidgeting" ) )
        {
            waitframe( 1 );
        }
    }
    
    if ( isdefined( self.var_ba1eee16.var_962cbf19[ self.var_ba1eee16.var_91f6b4c9 ] ) )
    {
        if ( isdefined( self.var_ba1eee16.var_962cbf19[ self.var_ba1eee16.var_91f6b4c9 ][ 1 ] ) )
        {
            level thread util::delay( self.var_ba1eee16.var_962cbf19[ self.var_ba1eee16.var_91f6b4c9 ][ 1 ], undefined, &dialogue::radio, self.var_ba1eee16.var_962cbf19[ self.var_ba1eee16.var_91f6b4c9 ][ 0 ] );
        }
        else
        {
            dialogue::radio( self.var_ba1eee16.var_962cbf19[ self.var_ba1eee16.var_91f6b4c9 ][ 0 ] );
        }
    }
    
    if ( self.var_ba1eee16.var_91f6b4c9 >= self.var_ba1eee16.var_962cbf19.size - 1 )
    {
        self.var_ba1eee16.var_91f6b4c9 = 0;
    }
    else
    {
        self.var_ba1eee16.var_91f6b4c9++;
    }
    
    self util::delay( var_8c3f52f6, undefined, &flag::clear, "flag_in_dialog" );
    
    if ( !is_true( self.var_ba1eee16.var_89db7e3d ) )
    {
        self lookatentity( level.player, 1 );
        wait 3;
        self lookatentity();
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x4350f3a4, Offset: 0x7d88
// Size: 0x44
function function_c15440f4()
{
    level flag::set( "flag_dialog_asked_question" );
    level flag::clear( "flag_dialog_reset" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xb511f8a8, Offset: 0x7dd8
// Size: 0x44
function function_fba5945d()
{
    level flag::clear( "flag_dialog_asked_question" );
    level flag::set( "flag_dialog_reset" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xfa76b688, Offset: 0x7e28
// Size: 0x44
function function_a99a7273()
{
    level flag::set( "flag_player_in_dialog" );
    self flag::set( "flag_in_dialog" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xff147d53, Offset: 0x7e78
// Size: 0x44
function function_8af85155()
{
    level flag::clear( "flag_player_in_dialog" );
    self flag::clear( "flag_in_dialog" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x5c0c12fb, Offset: 0x7ec8
// Size: 0x44
function function_a07bfe0f()
{
    self util::delay( self.var_ba1eee16.var_82a12581, undefined, &lookatentity, level.player, 1 );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x8523e845, Offset: 0x7f18
// Size: 0x34
function function_f62f3fea()
{
    self util::delay( self.var_ba1eee16.var_d0816878, undefined, &lookatentity );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xdb7233ee, Offset: 0x7f58
// Size: 0x22
function function_c9dc0e79()
{
    var_ea95c1e7 = util::function_875955a();
    return var_ea95c1e7;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 3
// Checksum 0x1c04475c, Offset: 0x7f88
// Size: 0x34
function function_abcc7f5c( var_e42e6f3e, var_3d1c64c9, var_ef555baf )
{
    util::function_c76fa9e1( var_e42e6f3e, var_3d1c64c9, var_ef555baf );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x1c4e1292, Offset: 0x7fc8
// Size: 0xa8
function function_a422a4a9()
{
    foreach ( var_3d43d7b8 in level.a_ai_allies )
    {
        while ( !isdefined( var_3d43d7b8[ 0 ].var_ba1eee16 ) )
        {
            waitframe( 1 );
        }
        
        var_3d43d7b8[ 0 ] thread function_159b3e();
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xfc2e56f6, Offset: 0x8078
// Size: 0x240
function function_159b3e()
{
    self endon( #"kill_all_fidgets" );
    var_9a2dd7eb = 0;
    str_scene = "scene_hub_" + level.var_f5552371 + "_dialog_" + self.animname;
    a_str_shots = level scene::get_all_shot_names( str_scene );
    
    for ( i = 0; i < a_str_shots.size ; i++ )
    {
        if ( a_str_shots[ i ] == "fidget_" + string( var_9a2dd7eb + 1 ) )
        {
            var_9a2dd7eb++;
        }
    }
    
    if ( var_9a2dd7eb > 0 && isdefined( self ) )
    {
        while ( true )
        {
            self flag::clear( "fidgeting_done" );
            self flag::clear( "flag_fidget_interrupt_start" );
            wait randomintrange( 12, 24 );
            
            while ( distance2d( self.origin, level.player.origin ) < 24 )
            {
                waitframe( 1 );
            }
            
            if ( !self flag::get( "flag_in_dialog" ) && !self flag::get( "flag_in_scene" ) && !self flag::get( "flag_delivering_exhaustion_vo" ) )
            {
                var_7868cbd8 = function_a70e8e05( str_scene, var_9a2dd7eb );
                self function_68f8c016( str_scene, var_7868cbd8 );
                self flag::wait_till_clear( "flag_fidgeting" );
            }
        }
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 2
// Checksum 0xefb3c879, Offset: 0x82c0
// Size: 0xfe
function function_a70e8e05( str_scene, var_9a2dd7eb )
{
    while ( true )
    {
        var_7868cbd8 = randomintrange( 1, var_9a2dd7eb + 1 );
        var_229db2f = scene::function_8582657c( str_scene, "fidget_" + string( var_7868cbd8 ) );
        
        if ( var_229db2f < 4 )
        {
            break;
        }
        
        var_aa19e187 = distance2d( self.origin, level.player.origin );
        var_63293649 = 8 * var_229db2f;
        
        if ( var_aa19e187 > var_63293649 )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    return var_7868cbd8;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 2
// Checksum 0xca684795, Offset: 0x83c8
// Size: 0xbc
function function_68f8c016( str_scene, var_7868cbd8 )
{
    self endon( #"hash_7d22c6f32f3a3cdb" );
    self flag::set( "flag_fidgeting" );
    self thread function_8462032a( str_scene, var_7868cbd8 );
    level scene::play( str_scene, "fidget_" + string( var_7868cbd8 ) );
    self notify( #"hash_3bf08c93cc60b82d" );
    self thread function_4932aa90( str_scene );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 2
// Checksum 0x11525ec7, Offset: 0x8490
// Size: 0x24c
function function_8462032a( str_scene, var_7868cbd8 )
{
    self endon( #"kill_all_fidgets" );
    self notify( #"hash_3bf08c93cc60b82d" );
    self endon( #"hash_3bf08c93cc60b82d" );
    self flag::wait_till( "flag_fidget_interrupt_start" );
    self notify( #"hash_7d22c6f32f3a3cdb" );
    var_49827ac8 = function_6d085bdc( str_scene );
    var_dda281b5 = self getanimtime( self.str_current_anim );
    var_5033cae6 = self.n_script_anim_rate;
    
    foreach ( e_object in var_49827ac8 )
    {
        e_object.n_script_anim_rate = 10;
    }
    
    self thread function_7c3ca9b3();
    self scene::stop( "false" );
    level scene::play_from_time( str_scene, "fidget_" + string( var_7868cbd8 ), var_49827ac8, var_dda281b5, 1, 1 );
    
    foreach ( e_object in var_49827ac8 )
    {
        e_object.n_script_anim_rate = var_5033cae6;
    }
    
    self thread function_4932aa90( str_scene );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0xd53bd629, Offset: 0x86e8
// Size: 0x84
function function_4932aa90( str_scene )
{
    self endon( #"kill_all_fidgets" );
    level thread scene::play( str_scene, "zone_idle" );
    self flag::set( "fidgeting_done" );
    self flag::clear( "flag_fidgeting" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0x70e99adf, Offset: 0x8778
// Size: 0x42
function function_6d085bdc( str_scene )
{
    s_bundle = struct::get_array( str_scene, "scriptbundlename" );
    return s_bundle[ 0 ].scene_ents;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x30173a20, Offset: 0x87c8
// Size: 0xd4
function function_7cccaccb()
{
    if ( self flag::get( "flag_fidgeting" ) )
    {
        var_af1678fb = self getanimtime( self.str_current_anim );
        var_c580e4db = getanimlength( self.str_current_anim );
        var_77da992f = var_af1678fb * var_c580e4db;
        
        if ( var_c580e4db - var_77da992f > 4 )
        {
            self flag::set( "flag_fidget_interrupt_start" );
        }
        
        self flag::wait_till( "fidgeting_done" );
        wait 0.25;
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xdf1b10e8, Offset: 0x88a8
// Size: 0x8c
function function_7c3ca9b3()
{
    if ( is_true( self.var_add1d491 ) )
    {
        level thread lui::screen_fade_out( 0.25, "black" );
        self flag::wait_till( "fidgeting_done" );
        level thread lui::screen_fade_in( 0.25, "black" );
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x7eff8d18, Offset: 0x8940
// Size: 0x34
function function_ea259f56()
{
    level thread function_877b571();
    level thread function_25df3863();
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x6f5924e6, Offset: 0x8980
// Size: 0x180
function function_877b571()
{
    while ( true )
    {
        var_385a06f0 = struct::get( "struct_obj_computer2", "targetname" );
        tag = spawn( "script_model", var_385a06f0.origin );
        tag setmodel( "tag_origin" );
        tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_77965c9740b1082d", 48 );
        tag waittill( #"trigger" );
        tag util::remove_cursor_hint();
        tag delete();
        level.player clientfield::set_to_player( "computer_terminal_switch", 1 );
        
        while ( true )
        {
            if ( level.player stancebuttonpressed() )
            {
                break;
            }
            
            waitframe( 1 );
        }
        
        level.player clientfield::set_to_player( "computer_terminal_switch", 0 );
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x7c3a48d2, Offset: 0x8b08
// Size: 0x138
function function_25df3863()
{
    while ( true )
    {
        var_385a06f0 = struct::get( "struct_obj_computer", "targetname" );
        tag = spawn( "script_model", var_385a06f0.origin );
        tag setmodel( "tag_origin" );
        tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_77965c9740b1082d", 48 );
        tag waittill( #"trigger" );
        tag util::remove_cursor_hint();
        tag delete();
        function_140d2db3( 0, #"hash_27050e599034898f" );
        function_819bc4e6();
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xc3d8c6b, Offset: 0x8c48
// Size: 0x84
function function_819bc4e6()
{
    namespace_6f1d35e1::function_487b4340( #"hash_35e421d5b19eafa6" );
    namespace_6f1d35e1::function_5d2e6f6a( 2 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    level thread function_141307f2();
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x56cc7171, Offset: 0x8cd8
// Size: 0x1ac
function function_141307f2()
{
    function_17f054b8();
    function_c59f3e2f();
    level.var_a6c79953 = dialog_tree::new_tree( undefined, undefined, 1 );
    level.var_a6c79953 dialog_tree::function_6bb91351( 1 );
    level.var_a6c79953 dialog_tree::add_option( #"hash_2e54e1701e5e69bf", undefined, undefined, undefined, undefined, undefined, "forever", &function_ef3775d7 );
    level.var_a6c79953 dialog_tree::add_option( #"hash_884c0b0de4368bc", undefined, undefined, undefined, undefined, undefined, "forever", &function_1967c4b6 );
    level.var_a6c79953 dialog_tree::add_option( #"hash_5af22c9d13a055f5", undefined, undefined, undefined, undefined, undefined, "forever", &function_2d5943c4 );
    level.var_a6c79953 dialog_tree::add_option( #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, undefined, "forever" );
    level.var_a6c79953 dialog_tree::function_6ebd37a4();
    level.var_a6c79953 thread dialog_tree::run();
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x7231a5e6, Offset: 0x8e90
// Size: 0x1fc
function function_17f054b8()
{
    namespace_6f1d35e1::function_5cffb9f2( #"hash_22991d7388c6e6bf", 1, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_487b4340( #"hash_3eddbc438b2a44e6" );
    namespace_6f1d35e1::function_5d2e6f6a( 1 );
    namespace_6f1d35e1::function_4951a2c8( 1, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 5, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 6, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 7, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 8, 30 );
    level waittill( #"typing_complete" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x91002099, Offset: 0x9098
// Size: 0x18c
function function_c59f3e2f()
{
    namespace_6f1d35e1::function_5cffb9f2( #"hash_1534525e35e45db7", 8, 0, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_487b4340( #"hash_4ef7a9c966dac71c" );
    namespace_6f1d35e1::function_5d2e6f6a( 1 );
    namespace_6f1d35e1::function_4951a2c8( 1, 10 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_487b4340( #"hash_3d1ba8ca98db9b7" );
    namespace_6f1d35e1::function_5d2e6f6a( 1 );
    namespace_6f1d35e1::function_4951a2c8( 1, 100 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 1 );
    namespace_6f1d35e1::function_4951a2c8( 3, 1 );
    namespace_6f1d35e1::function_4951a2c8( 4, 1 );
    namespace_6f1d35e1::function_4951a2c8( 5, 50 );
    level waittill( #"typing_complete" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x562ca812, Offset: 0x9230
// Size: 0x32c
function function_ef3775d7()
{
    level thread savegame::checkpoint_save();
    namespace_6f1d35e1::function_487b4340( #"hash_e9e43c4d19faa95" );
    namespace_6f1d35e1::function_5d2e6f6a( 7 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 50 );
    level waittill( #"typing_complete" );
    wait 2;
    namespace_6f1d35e1::function_5d2e6f6a( 8 );
    namespace_6f1d35e1::function_487b4340( #"hash_64c36c1200285612" );
    namespace_6f1d35e1::function_5d2e6f6a( 9 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 2 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 5, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 6, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 7, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 8, 10 );
    level waittill( #"typing_complete" );
    level flag::set( "macguffin_found" );
    level.adler thread dialogue::queue( "vox_cp_rkgb_04100_adlr_thatsitbellyoug_38" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x4115790b, Offset: 0x9568
// Size: 0xfc
function function_1967c4b6()
{
    namespace_6f1d35e1::function_487b4340( #"hash_208fbf208175ea49" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xc207ff83, Offset: 0x9670
// Size: 0x21c
function function_2d5943c4()
{
    namespace_6f1d35e1::function_487b4340( #"hash_375a7b8b525491c6" );
    namespace_6f1d35e1::function_5d2e6f6a( 4 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 5, 200 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 6, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 7, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 8, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 9, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 10, 50 );
    level waittill( #"typing_complete" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x9fad7af7, Offset: 0x9898
// Size: 0xfc
function function_8edf7bdb()
{
    namespace_6f1d35e1::function_487b4340( #"hash_6fed9de9bb212370" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xa3fd63c6, Offset: 0x99a0
// Size: 0xfc
function function_cbf70b31()
{
    namespace_6f1d35e1::function_487b4340( #"hash_59ceb3c6f94ddb26" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 80 );
    level waittill( #"typing_complete" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xa62b3bc9, Offset: 0x9aa8
// Size: 0xfc
function function_3e372438()
{
    namespace_6f1d35e1::function_487b4340( #"hash_ba9cdd2f1ff1995" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 80 );
    level waittill( #"typing_complete" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xde41e252, Offset: 0x9bb0
// Size: 0x21c
function function_c01978a0()
{
    namespace_6f1d35e1::function_487b4340( #"hash_40ce0f6ece54adca" );
    namespace_6f1d35e1::function_5d2e6f6a( 6 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 5, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 6, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 7, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 8, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 9, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 10, 50 );
    level waittill( #"typing_complete" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x1a9caf12, Offset: 0x9dd8
// Size: 0x21c
function function_d43932c9()
{
    namespace_6f1d35e1::function_487b4340( #"hash_6ba62ea0ae83cb93" );
    namespace_6f1d35e1::function_5d2e6f6a( 5 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 5, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 6, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 7, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 8, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 9, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 10, 50 );
    level waittill( #"typing_complete" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 3
// Checksum 0xa4c815de, Offset: 0xa000
// Size: 0xd2
function function_140d2db3( var_ad95c7d0, var_d2dad7cf, content = #"hash_6a49038dbf554db" )
{
    namespace_6f1d35e1::function_b2911127( 0 );
    namespace_6f1d35e1::function_b2911127( 1 );
    wait 0.5;
    namespace_6f1d35e1::function_eea42dd9( var_d2dad7cf );
    namespace_6f1d35e1::function_487b4340( content );
    namespace_6f1d35e1::function_5d2e6f6a( var_ad95c7d0 );
    namespace_6f1d35e1::function_4951a2c8( 1, 1 );
    wait 5;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 3
// Checksum 0xa2bc806c, Offset: 0xa0e0
// Size: 0x164
function function_cdbadaff( n_time, var_4961ddd2, var_97fef14f )
{
    self endon( #"death" );
    self endon( #"entitydeleted" );
    assert( self.classname == "<dev string:x15f>", "<dev string:x168>" );
    
    if ( !isdefined( n_time ) )
    {
        n_time = 1;
    }
    
    if ( !isdefined( var_4961ddd2 ) )
    {
        var_4961ddd2 = 0;
    }
    
    if ( !isdefined( var_97fef14f ) )
    {
        var_97fef14f = function_b342ec0e( self getlightintensity() );
    }
    
    t = 0;
    
    while ( t < n_time )
    {
        var_76bd8d90 = var_97fef14f + ( var_4961ddd2 - var_97fef14f ) * t / n_time;
        t += 0.025;
        self setlightintensity( function_5d783702( var_76bd8d90 ) );
        wait 0.025;
    }
    
    self setlightintensity( function_5d783702( var_76bd8d90 ) );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0xa5c34cc1, Offset: 0xa250
// Size: 0x48
function function_5d783702( n_stop )
{
    n_base = pow( 2, n_stop );
    var_2fcfdce8 = n_base * 1600;
    return var_2fcfdce8;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0x93572f4b, Offset: 0xa2a0
// Size: 0x42
function function_b342ec0e( var_73ab8aa8 )
{
    var_2fcfdce8 = var_73ab8aa8 / 1600;
    var_7a96a771 = log2( var_2fcfdce8 );
    return var_7a96a771;
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 3
// Checksum 0x94bd5acf, Offset: 0xa2f0
// Size: 0xe4
function function_ae83465e( n_time, var_64ba523d, var_e15fe12b )
{
    self endon( #"death" );
    self endon( #"entitydeleted" );
    
    if ( !isdefined( var_e15fe12b ) )
    {
        var_e15fe12b = self getlightcolor();
    }
    
    self.end_color = var_64ba523d;
    t = 0;
    
    while ( t < n_time )
    {
        var_2f339140 = var_e15fe12b + ( var_64ba523d - var_e15fe12b ) * t / n_time;
        t += 0.05;
        self setlightcolor( var_2f339140 );
        wait 0.025;
    }
    
    self setlightcolor( var_64ba523d );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 4
// Checksum 0x4ea74900, Offset: 0xa3e0
// Size: 0x1cc
function pstfx_teleport( var_5d5112e8, short, fade, var_68001b81 )
{
    if ( is_true( fade ) )
    {
        if ( is_true( var_68001b81 ) )
        {
            level thread lui::screen_fade_out( 0.05, "white" );
        }
        else
        {
            level thread lui::screen_fade_out( 0.5, "white" );
        }
    }
    
    if ( is_true( short ) && is_true( fade ) )
    {
        level.player clientfield::set_to_player( "pstfx_teleport", 3 );
    }
    else if ( is_true( short ) )
    {
        level.player clientfield::set_to_player( "pstfx_teleport", 2 );
    }
    else
    {
        level.player clientfield::set_to_player( "pstfx_teleport", 1 );
    }
    
    wait var_5d5112e8;
    
    if ( is_true( fade ) )
    {
        level thread lui::screen_fade_in( 0.5, "white" );
    }
    
    wait 0.5;
    level.player clientfield::set_to_player( "pstfx_teleport", 0 );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0xfb6961d8, Offset: 0xa5b8
// Size: 0x1c4
function function_29279de1( var_8ced85ea )
{
    switch ( var_8ced85ea )
    {
        case #"post_takedown":
            var_ec670c03 = "1981_Dutch_soccer_game_1";
            var_46f9f605 = "Vietnam_Brainwash_v1";
            break;
        case #"post_armada":
            var_ec670c03 = "1981_Dutch_soccer_game_1";
            var_46f9f605 = "Vietnam_Brainwash_v1";
            break;
        case #"post_yamantau":
            var_ec670c03 = "1981_Dutch_soccer_game_1";
            var_46f9f605 = "Vietnam_Brainwash_v1";
            break;
        case #"post_kgb":
            var_ec670c03 = "1981_Dutch_soccer_game_1";
            var_46f9f605 = "Vietnam_Brainwash_v1";
            break;
        case #"post_cuba":
            var_ec670c03 = "1981_Dutch_soccer_game_1";
            var_46f9f605 = "Vietnam_Brainwash_v1";
            break;
        case #"post_prisoner":
            var_ec670c03 = "1981_Dutch_soccer_game_1";
            var_46f9f605 = "Vietnam_Brainwash_v1";
            break;
        default:
            var_ec670c03 = "1981_Dutch_soccer_game_1";
            var_46f9f605 = "Vietnam_Brainwash_v1";
            break;
    }
    
    level.var_8391b06c = 1;
    waitframe( 1 );
    level.player thread namespace_78e9b80::function_15eaa2db( var_ec670c03, var_46f9f605, "flag_player_approached_flashback_TV", "flag_player_not_in_darkroom", "flashback_tv_lookat", "flashback_tv_screen", "exp_post_takedown_special_tv", #"tv_flashback_safehouse_video" );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1
// Checksum 0xc6c2b104, Offset: 0xa788
// Size: 0x2b8
function function_b0558ba2( var_690057e6 )
{
    var_c8d10663 = getent( "model_clock1", "targetname" );
    var_fa9a69f5 = getent( "model_clock2", "targetname" );
    var_581b24f5 = getent( "model_clock3", "targetname" );
    var_c8d10663 useanimtree( "generic" );
    var_fa9a69f5 useanimtree( "generic" );
    var_581b24f5 useanimtree( "generic" );
    var_c8d10663 thread function_42655283( "t9_hub_env_clock_sh" + var_690057e6 + "_germany", randomfloatrange( 0.05, 0.15 ) );
    var_fa9a69f5 thread function_42655283( "t9_hub_env_clock_sh" + var_690057e6 + "_moscow", randomfloatrange( 0.55, 0.75 ) );
    var_581b24f5 thread function_42655283( "t9_hub_env_clock_sh" + var_690057e6 + "_wash_dc", randomfloatrange( 0.25, 0.45 ) );
    var_2eb7eec2 = getentarray( "model_clock_amb", "targetname" );
    
    foreach ( var_d96c2e88 in var_2eb7eec2 )
    {
        var_d96c2e88 useanimtree( "generic" );
        var_d96c2e88 thread function_42655283( "t9_hub_env_clock_sh" + var_690057e6 + "_germany", randomfloatrange( 0.05, 0.25 ) );
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 2
// Checksum 0xeb73f456, Offset: 0xaa48
// Size: 0x3c
function function_42655283( var_85d8359e, n_start_time )
{
    self animation::play( var_85d8359e, undefined, undefined, undefined, undefined, undefined, undefined, n_start_time );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0x536559d7, Offset: 0xaa90
// Size: 0x8e
function function_f3dc3a44()
{
    while ( !isdefined( level.player ) )
    {
        waitframe( 1 );
    }
    
    while ( true )
    {
        var_483c8820 = level.player getnormalizedmovement();
        
        /#
            iprintlnbold( "<dev string:x19d>" + var_483c8820[ 0 ] + "<dev string:x1a9>" + var_483c8820[ 1 ] );
        #/
        
        waitframe( 1 );
    }
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 0
// Checksum 0xe927b590, Offset: 0xab28
// Size: 0x2c
function test_scripted_camera_lens()
{
    wait 3;
    level clientfield::set( "test_scripted_camera_lens", 1 );
}

// Namespace namespace_31c67f6d/namespace_89829bca
// Params 1, eflags: 0x4
// Checksum 0x986aa6c5, Offset: 0xab60
// Size: 0x46
function private waittill_end( str_scene_name )
{
    self waittillmatch( { #notetrack:"end" }, str_scene_name );
    self notify( #"hash_5083923aa1b3d146" );
}

