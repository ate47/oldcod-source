#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_4d0e7ced9714e7d4;
#using script_63ae018f589c2e64;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;

#namespace namespace_3562695;

// Namespace namespace_3562695/namespace_be817e37
// Params 1
// Checksum 0x90131161, Offset: 0x850
// Size: 0x1b4
function starting( *str_objective )
{
    spawner::simple_spawn( "spawner_perseus_forces", &function_c50c5a2a );
    level thread scene::init_streamer( #"scene_duga_loose_ends", getplayers() );
    level thread scene::init_streamer( #"scene_duga_loose_ends_adler", getplayers() );
    level thread scene::init_streamer( #"scene_duga_loose_ends_tappy", getplayers() );
    level.perseus = spawner::simple_spawn_single( "perseus" );
    level.perseus setteam( #"allies" );
    level.perseus setgoal( level.perseus.origin );
    level.perseus.goalradius = 32;
    level scene::add_scene_func( "scene_duga_loose_ends_tappy", &function_a444d829, "init" );
    level scene::init( "scene_duga_loose_ends_tappy" );
}

// Namespace namespace_3562695/namespace_be817e37
// Params 2
// Checksum 0x2e984689, Offset: 0xa10
// Size: 0x1e4
function main( str_objective, *b_skipto )
{
    battlechatter::function_2ab9360b( 0 );
    level scene::add_scene_func( "scene_duga_loose_ends_tappy", &function_a444d829, "init" );
    level scene::init( "scene_duga_loose_ends_tappy" );
    level thread namespace_e1ccb37b::function_b8f05dfb();
    level thread function_f7d3abcf();
    level thread objectives();
    level.perseus ai::set_behavior_attribute( "demeanor", "cqb" );
    level.perseus thread function_b132d5eb();
    level flag::wait_till( "flag_perseus_path_3" );
    level thread scene::play( "scene_duga_ending_prep", "init", [ level.perseus ] );
    level waittill( #"hash_54bae82df394800e" );
    level thread function_45405080();
    level flag::wait_till( "flag_loose_ends_complete" );
    skipto::function_4e3ab877( b_skipto );
    skipto::function_f02f0c63();
    skipto::function_1c2dfc20();
}

// Namespace namespace_3562695/namespace_be817e37
// Params 4
// Checksum 0x9d76962, Offset: 0xc00
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0xd2b27765, Offset: 0xc30
// Size: 0xc0
function function_c50c5a2a()
{
    self setteam( #"allies" );
    
    if ( !isdefined( level.var_69c98a58 ) )
    {
        level.var_69c98a58 = [];
    }
    else if ( !isarray( level.var_69c98a58 ) )
    {
        level.var_69c98a58 = array( level.var_69c98a58 );
    }
    
    if ( !isinarray( level.var_69c98a58, self ) )
    {
        level.var_69c98a58[ level.var_69c98a58.size ] = self;
    }
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0x3207e1b, Offset: 0xcf8
// Size: 0x14c
function function_b132d5eb()
{
    nd = getnode( "nd_path_perseus_loose_ends", "targetname" );
    self colors::disable();
    self thread spawner::go_to_node( nd );
    self waittill( #"goal" );
    level flag::set( "flag_perseus_in_pos" );
    self thread dialogue::queue( "vox_cp_duga_01300_pers_overherecomrade_88" );
    level flag::wait_till( "flag_perseus_path_1" );
    self thread dialogue::queue( "vox_cp_duga_01300_pers_thisisit_b2" );
    level flag::wait_till( "flag_perseus_path_2" );
    self dialogue::queue( "vox_cp_duga_01300_pers_yourfriendwentt_9c" );
    self thread dialogue::queue( "vox_cp_duga_01300_pers_heisnotfar_a1" );
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0x2fd5e046, Offset: 0xe50
// Size: 0xcc
function function_f7d3abcf()
{
    level.var_709556b8 = dialog_tree::new_tree( undefined, undefined, 1, 1 );
    var_f562392f = 1;
    level.var_709556b8 dialog_tree::add_option( #"hash_7b62db444c847d8", undefined, undefined, undefined, var_f562392f );
    level.var_709556b8 dialog_tree::function_6ebd37a4();
    level.var_709556b8 dialog_tree::add_option( #"hash_7b630b444c84cf1", undefined, undefined, undefined, var_f562392f );
    level.var_709556b8 dialog_tree::function_6ebd37a4();
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0xda5811ae, Offset: 0xf28
// Size: 0x1b4
function objectives()
{
    objectives::scripted( "obj_loose_ends", undefined, #"hash_34ca6a345039f8df" );
    objectives::follow( "obj_follow_perseus", level.perseus );
    level flag::wait_till( "flag_loose_ends_obj" );
    objectives::remove( "obj_follow_perseus", level.perseus );
    s_org = struct::get( "obj_loose_ends_org", "targetname" );
    objectives::goto( "obj_loose_ends_door", s_org.origin, #"hash_34ca6a345039f8df" );
    level flag::wait_till( #"hash_62d033072bf4254b" );
    objectives::complete( "obj_loose_ends_door" );
    level flag::wait_till( "flag_obj_kill_adler" );
    objectives::update_position( "obj_loose_ends", level.adler.origin );
    objectives::show( "obj_loose_ends" );
    level flag::wait_till( "flag_adler_dead" );
    objectives::complete( "obj_loose_ends" );
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0xc694135d, Offset: 0x10e8
// Size: 0x974
function function_45405080()
{
    level flag::set( "flag_loose_ends_obj" );
    str_scene = "scene_duga_loose_ends";
    var_2759773 = struct::get( "org_use_prompt_roof_doors", "targetname" );
    var_2759773 util::create_cursor_hint( undefined, undefined, #"hash_6e61bbc938438d7d" );
    var_2759773 waittill( #"trigger" );
    e_player = getplayers()[ 0 ];
    namespace_82bfe441::fade( 1, "FadeSlow" );
    e_player showcrosshair( 0 );
    e_player util::function_749362d7( 1 );
    level flag::set( #"hash_62d033072bf4254b" );
    namespace_ac5221d7::function_ed760ecb( "adler" );
    level.adler val::reset_all( #"hash_32527366ce1b4fb" );
    level.adler setteam( #"axis" );
    level.adler val::set( #"hash_32527366ce1b4fb", "take_weapons", 1 );
    level.adler.var_c681e4c1 = 1;
    level.adler thread function_de4103eb();
    
    if ( !isdefined( level.perseus ) )
    {
        level.perseus = spawner::simple_spawn_single( "perseus" );
        level.perseus setteam( #"allies" );
        
        /#
            iprintlnbold( "<dev string:x38>" );
        #/
    }
    
    var_b9335c1c = getent( "roof_door_clip", "targetname" );
    door_left = getent( "door_left", "targetname" );
    door_right = getent( "door_right", "targetname" );
    a_actors = [ e_player, level.perseus ];
    scene::add_scene_func( str_scene + "_adler", &function_93654377, "enter" );
    scene::add_scene_func( str_scene, &function_e0799719, "quick_response" );
    scene::add_scene_func( str_scene, &function_e0799719, "slow_response" );
    level thread scene::play( str_scene, "enter", a_actors );
    level thread scene::play( str_scene + "_adler", "enter", level.adler );
    result = level flag::wait_till_any( [ "flag_lighter_prompt_used", "flag_adler_killed_no_tappy" ] );
    str_shot = "";
    
    if ( result._notify === "flag_lighter_prompt_used" )
    {
        level thread namespace_e1ccb37b::function_b9cce48d();
        level.adler stopsounds();
        level scene::stop( str_scene + "_adler" );
        level scene::play( "scene_duga_loose_ends_tappy", "enter", [ getplayers()[ 0 ], level.adler ] );
        level thread function_3babb313();
        level flag::wait_till( "flag_stab_finished" );
        str_shot = "slow_response";
    }
    else
    {
        level.player.var_5c361958 = gettime();
        
        if ( level.player.var_5c361958 < level.player.var_bfd336b0 )
        {
            str_shot = "quick_response";
        }
        else
        {
            str_shot = "slow_response";
        }
    }
    
    level flag::set( #"flag_obj_kill_adler" );
    namespace_82bfe441::fade( 0, "FadeMedium" );
    level.cig delete();
    wait 1;
    level thread scene::play( str_scene, str_shot, [ level.perseus ] );
    level waittill( #"hash_7c0b0716af5a9907" );
    level.perseus util::create_cursor_hint( "j_spine4", undefined, "OBJECTIVES/TALK_TO", 80, undefined, undefined, undefined, undefined, 0 );
    level.perseus prompts::function_92127496( 1 );
    level.perseus prompts::function_1a5e1da6( #"use", 1 );
    level.perseus waittill( #"trigger" );
    namespace_82bfe441::fade( 1, "FadeMedium" );
    e_player showcrosshair( 0 );
    level thread scene::play( str_scene, "reveal", [ level.perseus, e_player ] );
    level waittill( #"hash_6166ba3b67203b5b" );
    level.perseus util::create_cursor_hint( "j_spine4", undefined, #"hash_6e61bbc938438d7d" );
    level.perseus waittill( #"trigger" );
    a_actors = [ level.perseus, e_player ];
    level thread scene::play( "scene_duga_loose_ends", "grab_radio", a_actors );
    wait getanimlength( #"hash_74e111f08ef85a03" );
    level.var_709556b8 dialog_tree::run();
    var_d7022772 = [];
    
    switch ( level.var_de6ca1e4 )
    {
        case 0:
            var_d7022772[ var_d7022772.size ] = "vox_cp_duga_01300_rms1_yescommander_41";
            break;
        case 1:
            var_d7022772[ var_d7022772.size ] = "vox_cp_duga_01300_rms1_yessir_f9_1";
            break;
        case 2:
            var_d7022772[ var_d7022772.size ] = "vox_cp_duga_01300_rms1_yesmaam_6e";
            break;
    }
    
    var_d7022772[ var_d7022772.size ] = "vox_cp_duga_01300_rms1_asyoucommandper_91";
    level thread dialogue::radio( array::random( var_d7022772 ) );
    level scene::play( "scene_duga_loose_ends", "end", a_actors );
    level flag::set( #"flag_loose_ends_complete" );
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0x3a9efdad, Offset: 0x1a68
// Size: 0x88c
function function_3babb313()
{
    level endon( #"flag_tappy_succusseful" );
    animation::add_notetrack_func( "duga_loose_ends::stabby_tappy_success", &function_96bef5d0 );
    s_org = struct::get( "tag_align_loose_ends", "targetname" );
    var_4ca79834 = 0.2;
    var_f01a6b5d = 1;
    n_timer = 6;
    var_e4dd1cf2 = "t9_duga_loose_ends_tappy_adler_struggle_fwd";
    var_608bca2a = "t9_duga_loose_ends_tappy_adler_struggle_bwd";
    var_6c0ebc80 = "t9_duga_loose_ends_tappy_player_struggle_fwd";
    var_6a2be0f6 = "t9_duga_loose_ends_tappy_player_struggle_bwd";
    var_6969be79 = var_e4dd1cf2;
    var_9b3e2106 = var_6c0ebc80;
    var_b807e01e = var_6969be79;
    var_bb34c906 = var_9b3e2106;
    n_start_time = 0.5;
    level.player thread animation::play( var_9b3e2106, s_org, undefined, 1, undefined, undefined, undefined, n_start_time, undefined, undefined, undefined, 1 );
    level.adler thread animation::play( var_6969be79, s_org, undefined, 1, undefined, undefined, undefined, n_start_time, undefined, undefined, undefined, 1 );
    level thread function_6cfa94fc();
    level.adler thread function_597bc742();
    level.player thread function_13a846c4();
    level.player clientfield::set_to_player( "pstfx_chromatic_aberration", 1 );
    
    while ( n_timer > 0 )
    {
        if ( level.player.var_5588383e )
        {
            var_f01a6b5d = 1;
            
            if ( var_f01a6b5d > 0 )
            {
                var_bb34c906 = var_6c0ebc80;
                var_b807e01e = var_e4dd1cf2;
            }
            
            level.player.var_5588383e = 0;
        }
        else
        {
            var_f01a6b5d -= float( function_60d95f53() ) / 1000 / var_4ca79834;
            var_f01a6b5d = max( var_f01a6b5d, -1 );
            
            if ( var_f01a6b5d < 0 )
            {
                var_bb34c906 = var_6a2be0f6;
                var_b807e01e = var_608bca2a;
            }
        }
        
        if ( var_bb34c906 != var_9b3e2106 )
        {
            var_facf831 = 1 - level.player getanimtime( var_9b3e2106 );
            var_c5c054a5 = 1 - level.adler getanimtime( var_6969be79 );
            var_9b3e2106 = var_bb34c906;
            var_6969be79 = var_b807e01e;
            level.player thread animation::play( var_9b3e2106, s_org, undefined, abs( var_f01a6b5d ), undefined, undefined, undefined, var_facf831 );
            level.adler thread animation::play( var_6969be79, s_org, undefined, abs( var_f01a6b5d ), undefined, undefined, undefined, var_c5c054a5 );
        }
        
        var_facf831 = level.player getanimtime( var_9b3e2106 );
        var_c5c054a5 = level.adler getanimtime( var_6969be79 );
        level.player thread animation::play( var_9b3e2106, s_org, undefined, abs( var_f01a6b5d ), undefined, undefined, undefined, var_facf831 );
        level.adler thread animation::play( var_6969be79, s_org, undefined, abs( var_f01a6b5d ), undefined, undefined, undefined, var_c5c054a5 );
        
        if ( var_9b3e2106 === var_6c0ebc80 )
        {
            level.player playrumbleonentity( "damage_heavy" );
        }
        else
        {
            level.player playrumbleonentity( "damage_light" );
        }
        
        level notify( #"struggle_loop", { #var_9b3e2106:var_9b3e2106 } );
        waitframe( 1 );
        n_timer -= float( function_60d95f53() ) / 1000;
    }
    
    level notify( #"stabby_tappy_end" );
    level.adler notify( #"stabby_tappy_end" );
    level notify( #"hash_682922b33897d911" );
    
    if ( var_9b3e2106 === var_6c0ebc80 )
    {
        var_facf831 = 1 - level.player getanimtime( var_9b3e2106 );
        var_c5c054a5 = 1 - level.adler getanimtime( var_6969be79 );
        var_9b3e2106 = var_6a2be0f6;
        var_6969be79 = var_608bca2a;
        level.player thread animation::play( var_9b3e2106, s_org, undefined, 1, undefined, undefined, undefined, var_facf831 );
        level.player thread function_5235e07c();
        level.adler animation::play( var_6969be79, s_org, undefined, 1, undefined, undefined, undefined, var_c5c054a5 );
    }
    else
    {
        var_facf831 = level.player getanimtime( var_9b3e2106 );
        var_c5c054a5 = level.adler getanimtime( var_6969be79 );
        level.player thread animation::play( var_9b3e2106, s_org, undefined, 1, undefined, undefined, undefined, var_facf831 );
        level.player thread function_5235e07c();
        level.adler animation::play( var_6969be79, s_org, undefined, 1, undefined, undefined, undefined, var_c5c054a5 );
    }
    
    level flag::set( "flag_tappy_failed" );
    level.player val::set( #"tappy_failed", "health_regen", 0 );
    level scene::play( "scene_duga_loose_ends_tappy", "lose", [ level.player, level.adler ] );
    level.player thread animation::play( "t9_duga_loose_ends_tappy_player_lose", s_org, undefined, 1, undefined, undefined, undefined, 1, undefined, undefined, undefined, 1 );
    level.adler thread animation::play( "t9_duga_loose_ends_tappy_adler_lose", s_org, undefined, 1, undefined, undefined, undefined, 1, undefined, undefined, undefined, 1 );
    util::missionfailedwrapper();
}

// Namespace namespace_3562695/namespace_be817e37
// Params 1
// Checksum 0x309c1eae, Offset: 0x2300
// Size: 0x134
function function_a444d829( a_ents )
{
    level waittill( #"hash_5769defdfaab860d" );
    level endon( #"flag_adler_killed_no_tappy" );
    level.player.var_38ea0d27 = gettime();
    level.player.var_bfd336b0 = level.player.var_38ea0d27 + 12000;
    level.player thread util::function_749362d7( 0 );
    level.adler thread function_699d75f9();
    savegame::checkpoint_save( 1 );
    level.var_3b2b8e1f = a_ents[ #"lighter" ];
    level.var_3b2b8e1f util::create_cursor_hint();
    level.var_3b2b8e1f waittill( #"trigger" );
    level flag::set( "flag_lighter_prompt_used" );
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0xdd7938e7, Offset: 0x2440
// Size: 0x74
function function_699d75f9()
{
    self endon( #"flag_lighter_prompt_used" );
    self waittill( #"death" );
    self stopsounds();
    level flag::set( "flag_adler_killed_no_tappy" );
    level.var_3b2b8e1f util::remove_cursor_hint();
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0xd921a5cc, Offset: 0x24c0
// Size: 0xe4
function function_5235e07c()
{
    self waittill( #"hash_4c606409d590ec9c" );
    self clientfield::set_to_player( "pstfx_player_stabbed", 1 );
    self dodamage( self.health * 0.5, level.adler.origin, level.adler, level.adler );
    self waittill( #"hash_4c606709d590f1b5" );
    self dodamage( self.health * 0.3, level.adler.origin, level.adler, level.adler );
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0x6244d5a3, Offset: 0x25b0
// Size: 0xd2
function function_597bc742()
{
    var_181ec148 = 180;
    var_6c695939 = 1;
    
    while ( var_6c695939 )
    {
        self util::create_cursor_hint( "j_radio_cord_9", undefined, undefined, undefined, 0.01, undefined, undefined, undefined, var_181ec148 );
        str_result = self waittill( #"trigger", #"stabby_tappy_end" );
        
        if ( str_result._notify === "stabby_tappy_end" )
        {
            self util::remove_cursor_hint();
            var_6c695939 = 0;
            break;
        }
    }
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0xfa1d2304, Offset: 0x2690
// Size: 0x72
function function_13a846c4()
{
    self endon( #"stabby_tappy_end" );
    self notifyonplayercommand( "stabby_tappy_button_pressed", "+usereload" );
    self.var_5588383e = 0;
    
    while ( true )
    {
        self waittill( #"stabby_tappy_button_pressed" );
        self.var_5588383e = 1;
    }
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0x682502b5, Offset: 0x2710
// Size: 0x2d8
function function_6cfa94fc()
{
    var_4c371ed7 = [];
    var_4c371ed7[ #"struggle_heavy" ] = function_3ced19b6( level.player.origin, 1, 0, 1, 0.05, 0, 0, 0, 6, 0, 2, 9 );
    var_4c371ed7[ #"struggle_medium" ] = function_3ced19b6( level.player.origin, 1, 0, 1, 0.05, 0, 0, 0, 4, 0, 2, 3 );
    var_4c371ed7[ #"struggle_light" ] = function_3ced19b6( level.player.origin, 0.5, 0, 1, 0.05, 0, 0, 0, 2, 0, 1, 1 );
    
    while ( true )
    {
        s_result = level waittill( #"struggle_loop" );
        var_9fa7870b = "struggle_heavy";
        var_facf831 = level.player getanimtime( s_result.var_9b3e2106 );
        
        if ( s_result.var_9b3e2106 === "t9_duga_loose_ends_tappy_player_struggle_bwd" )
        {
            if ( var_facf831 > 0.8 )
            {
                var_9fa7870b = "struggle_heavy";
            }
            else if ( var_facf831 > 0.3 )
            {
                var_9fa7870b = "struggle_medium";
            }
            else
            {
                var_9fa7870b = "struggle_light";
            }
        }
        else if ( var_facf831 < 0.2 )
        {
            var_9fa7870b = "struggle_heavy";
        }
        else if ( var_facf831 < 0.7 )
        {
            var_9fa7870b = "struggle_medium";
        }
        else
        {
            var_9fa7870b = "struggle_light";
        }
        
        s = var_4c371ed7[ var_9fa7870b ];
        screenshake( s.sourcepoint, s.scalepitch, s.var_7a0e1e7a, s.var_296bd501, s.duration, s.durationfadeup, s.durationfadedown, s.radius, s.var_c6c2e5d9, s.var_d8508ca6, s.var_9588f89f, s.exponent );
    }
}

// Namespace namespace_3562695/namespace_be817e37
// Params 12
// Checksum 0x8b19122b, Offset: 0x29f0
// Size: 0x12c
function function_3ced19b6( sourcepoint, scalepitch, var_7a0e1e7a, var_296bd501, duration, durationfadeup, durationfadedown, radius, var_c6c2e5d9, var_d8508ca6, var_9588f89f, exponent )
{
    return { #sourcepoint:sourcepoint, #scalepitch:scalepitch, #var_7a0e1e7a:var_7a0e1e7a, #var_296bd501:var_296bd501, #duration:duration, #durationfadeup:durationfadeup, #durationfadedown:durationfadedown, #radius:radius, #var_c6c2e5d9:var_c6c2e5d9, #var_d8508ca6:var_d8508ca6, #var_9588f89f:var_9588f89f, #exponent:exponent };
}

// Namespace namespace_3562695/namespace_be817e37
// Params 1
// Checksum 0x3d8d956b, Offset: 0x2b28
// Size: 0x184
function function_96bef5d0( *params )
{
    if ( level flag::get( "flag_tappy_succusseful" ) )
    {
        return;
    }
    
    level flag::set( "flag_tappy_succusseful" );
    level.adler notify( #"stabby_tappy_end" );
    s_org = struct::get( "tag_align_loose_ends", "targetname" );
    level.player thread animation::play( "t9_duga_loose_ends_tappy_player_struggle_fwd", s_org, undefined, 1, undefined, undefined, undefined, 0.9 );
    level.adler animation::play( "t9_duga_loose_ends_tappy_adler_struggle_fwd", s_org, undefined, 1, undefined, undefined, undefined, 0.9 );
    level scene::play( "scene_duga_loose_ends_tappy", "win", [ level.player, level.adler ] );
    level.adler function_de4103eb();
    level flag::set( "flag_stab_finished" );
}

// Namespace namespace_3562695/namespace_be817e37
// Params 1
// Checksum 0x3330bc3f, Offset: 0x2cb8
// Size: 0x28
function function_93654377( a_ents )
{
    level.cig = a_ents[ #"cigarette" ];
}

// Namespace namespace_3562695/namespace_be817e37
// Params 1
// Checksum 0x894e61d2, Offset: 0x2ce8
// Size: 0x28
function function_e0799719( a_ents )
{
    level.var_20c5b092 = a_ents[ #"radio" ];
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0x2e2fc61d, Offset: 0x2d18
// Size: 0x6c
function function_69d490da()
{
    level endon( #"flag_adler_dead" );
    level waittill( #"hash_64d9dd69bbc846e9" );
    level thread scene::play( "scene_duga_loose_ends", "nag", [ level.perseus ] );
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0x1e972065, Offset: 0x2d90
// Size: 0x7c
function function_de4103eb()
{
    self.skipdeath = 1;
    self setcandamage( 1 );
    self ai::gun_remove();
    self stopsounds();
    level flag::set( "flag_adler_dead" );
}

// Namespace namespace_3562695/namespace_be817e37
// Params 0
// Checksum 0x675126f, Offset: 0x2e18
// Size: 0x124
function function_ea8ca6bb()
{
    a_weapons = self getweaponslist();
    
    foreach ( w in a_weapons )
    {
        self givemaxammo( w );
        self setweaponammoclip( w, w.clipsize );
    }
    
    g = getweapon( #"frag_grenade" );
    
    if ( self hasweapon( g ) )
    {
        self takeweapon( g );
    }
}

// Namespace namespace_3562695/namespace_be817e37
// Params 1
// Checksum 0xdada1400, Offset: 0x2f48
// Size: 0x174
function function_f5d9adcd( *str_objective )
{
    spawner::simple_spawn( "spawner_perseus_forces", &function_c50c5a2a );
    level thread scene::init_streamer( #"scene_duga_loose_ends", getplayers() );
    level thread scene::init_streamer( #"scene_duga_loose_ends_adler", getplayers() );
    level thread scene::init_streamer( #"scene_duga_loose_ends_tappy", getplayers() );
    level.perseus = spawner::simple_spawn_single( "perseus" );
    level.perseus setteam( #"allies" );
    level scene::add_scene_func( "scene_duga_loose_ends_tappy", &function_a444d829, "init" );
    level scene::init( "scene_duga_loose_ends_tappy" );
}

// Namespace namespace_3562695/namespace_be817e37
// Params 2
// Checksum 0xd25b0cb, Offset: 0x30c8
// Size: 0x284
function function_dbe8c8f4( *str_objective, *b_skipto )
{
    var_b9335c1c = getent( "roof_door_clip", "targetname" );
    door_left = getent( "door_left", "targetname" );
    door_right = getent( "door_right", "targetname" );
    var_b9335c1c delete();
    door_left delete();
    door_right delete();
    namespace_ac5221d7::function_ed760ecb( "adler" );
    level.adler val::reset_all( #"hash_32527366ce1b4fb" );
    level.adler setteam( #"axis" );
    level.adler setcandamage( 1 );
    level.adler.var_c681e4c1 = 1;
    level.player util::function_749362d7( 1 );
    level thread scene::play( "scene_duga_loose_ends_adler", "enter", level.adler );
    level flag::wait_till( "flag_lighter_prompt_used" );
    level thread namespace_e1ccb37b::function_b9cce48d();
    level.adler stopsounds();
    level scene::play( "scene_duga_loose_ends_tappy", "enter", [ getplayers()[ 0 ], level.adler ] );
    level thread function_3babb313();
}

