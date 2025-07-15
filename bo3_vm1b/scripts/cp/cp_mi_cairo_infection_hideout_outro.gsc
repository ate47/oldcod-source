#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection3_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_zombies;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace hideout_outro;

// Namespace hideout_outro
// Params 0
// Checksum 0xf84a8878, Offset: 0xb90
// Size: 0x5b
function main()
{
    init_clientfields();
    level thread scene::init( "p7_fxanim_cp_infection_house_ceiling_02_bundle" );
    level flag::init( "underwater_done" );
    level._effect[ "nuke_fx" ] = "explosions/fx_exp_nuke_full_inf";
}

// Namespace hideout_outro
// Params 0
// Checksum 0x4db442ed, Offset: 0xbf8
// Size: 0x1c2
function init_clientfields()
{
    n_clientbits = getminbitcountfornum( 4 );
    clientfield::register( "world", "infection_hideout_fx", 1, 1, "int" );
    clientfield::register( "world", "hideout_stretch", 1, 1, "int" );
    clientfield::register( "world", "stalingrad_rise_nuke", 1, 2, "int" );
    clientfield::register( "world", "stalingrand_nuke_fog_banks", 1, 1, "int" );
    clientfield::register( "world", "city_tree_passed", 1, 1, "int" );
    clientfield::register( "world", "stalingrad_tree_init", 1, 2, "int" );
    clientfield::register( "world", "stalingrad_city_ceilings", 1, n_clientbits, "int" );
    clientfield::register( "world", "infection_nuke_lights", 1, 1, "int" );
    clientfield::register( "toplayer", "ukko_toggling", 1, 1, "counter" );
    clientfield::register( "toplayer", "nuke_earth_quake", 1, getminbitcountfornum( 8 ), "int" );
}

// Namespace hideout_outro
// Params 2
// Checksum 0xc23e6db, Offset: 0xdc8
// Size: 0x2d2
function hideout_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
    }
    
    scene::add_scene_func( "cin_inf_13_01_hideout_vign_briefing", &vo_hideout, "play" );
    scene::add_scene_func( "p7_fxanim_cp_infection_hideout_stretch_bundle", &stretch_lights_play, "play" );
    scene::add_scene_func( "cin_inf_12_01_underwater_1st_fall_hideout03", &infection_util::teleport_coop_players_after_shared_cinematic, "done" );
    level scene::init( "cin_inf_13_01_hideout_vign_briefing" );
    playsoundatposition( "evt_dream_vox", ( -6893, 2203, 5962 ) );
    
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    
    level notify( #"update_billboard" );
    level thread scene::play( "cin_inf_12_01_underwater_1st_fall_hideout03" );
    array::thread_all( level.players, &infection_util::player_enter_cinematic );
    level clientfield::set( "infection_hideout_fx", 1 );
    level thread namespace_99d8554b::function_63b34b78();
    
    if ( isdefined( level.bzm_infectiondialogue15callback ) )
    {
        level thread [[ level.bzm_infectiondialogue15callback ]]();
    }
    
    level thread scene::play( "cin_inf_13_01_hideout_vign_briefing" );
    level waittill( #"hideout_scene_stretch" );
    level thread scene::play( "p7_fxanim_cp_infection_hideout_stretch_bundle" );
    level thread util::set_streamer_hint( 10 );
    level waittill( #"hideout_scene_fade" );
    level thread util::clear_streamer_hint();
    var_7d116593 = struct::get( "s_interrogation_loc", "targetname" );
    infection_util::function_7aca917c( var_7d116593.origin );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "cp_infection_hideout_stretch" );
    }
    
    level util::screen_fade_out( 5, "black" );
    level thread util::clear_streamer_hint();
    level thread hideout_scene_done();
}

// Namespace hideout_outro
// Params 1
// Checksum 0x5c4e6cbb, Offset: 0x10a8
// Size: 0x52
function hideout_scene_done( a_ents )
{
    array::thread_all( level.players, &infection_util::player_leave_cinematic );
    level notify( #"hideout_done" );
    level thread skipto::objective_completed( "hideout" );
}

// Namespace hideout_outro
// Params 1
// Checksum 0x7503a489, Offset: 0x1108
// Size: 0x143
function stretch_lights_play( a_ents )
{
    a_str_lights = array( "light_fx_01", "light_fx_02", "light_fx_03", "light_fx_04", "fx_light_1", "fx_light_2", "fx_light_3", "fx_light_5", "fx_light_6", "fx_light_7", "fx_light_9" );
    
    foreach ( string in a_str_lights )
    {
        a_e_lights = getentarray( string, "targetname" );
        
        foreach ( e_light in a_e_lights )
        {
            e_light thread link_hideout_lights( a_ents );
        }
    }
}

// Namespace hideout_outro
// Params 1
// Checksum 0x823ceee1, Offset: 0x1258
// Size: 0x5a
function link_hideout_lights( a_ents )
{
    self linkto( a_ents[ "hideout_stretch" ], self.targetname + "_jnt" );
    level waittill( #"hideout_done" );
    self unlink();
    self delete();
}

// Namespace hideout_outro
// Params 1
// Checksum 0xd177049e, Offset: 0x12c0
// Size: 0xa2
function vo_hideout( a_ents )
{
    wait 1;
    level dialog::player_say( "plyr_where_did_you_go_sa_0", 1 );
    level dialog::say( "hall_we_held_up_in_the_ol_0", 1, 1 );
    level dialog::say( "hall_and_made_our_pla_0", 0, 1 );
    level dialog::player_say( "plyr_the_aquifers_you_0", 0 );
    level dialog::player_say( "plyr_it_must_be_kane_sho_0", 3 );
}

// Namespace hideout_outro
// Params 4
// Checksum 0x24eb4dac, Offset: 0x1370
// Size: 0x22
function hideout_cleanup( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace hideout_outro
// Params 2
// Checksum 0x56defa34, Offset: 0x13a0
// Size: 0x1ea
function interrogation_main( str_objective, b_starting )
{
    level notify( #"update_billboard" );
    scene::add_scene_func( "cin_inf_14_01_nasser_vign_interrogate", &interrogation_scene_play, "init" );
    scene::add_scene_func( "cin_inf_14_01_nasser_vign_interrogate", &interrogation_scene_done, "done" );
    skipto::teleport_players( str_objective, 0 );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level scene::init( "cin_inf_14_01_nasser_vign_interrogate" );
        load::function_a2995f22();
    }
    
    util::screen_fade_out( 0, "black" );
    level util::delay( 0.25, undefined, &util::screen_fade_in, 2, "black" );
    array::thread_all( level.players, &infection_util::player_enter_cinematic );
    level thread function_423ccbef();
    
    if ( isdefined( level.bzm_infectiondialogue16callback ) )
    {
        level thread [[ level.bzm_infectiondialogue16callback ]]();
    }
    
    level thread scene::play( "cin_inf_14_01_nasser_vign_interrogate" );
    level thread util::set_streamer_hint( 4 );
    level waittill( #"interrogation_scene_fade" );
    exploder::exploder( "exploder_interrogation_transition" );
    level thread util::screen_fade_out( 3, "white" );
    wait 3;
    level thread util::clear_streamer_hint();
    level thread skipto::objective_completed( "interrogation" );
}

// Namespace hideout_outro
// Params 1
// Checksum 0xd44ff1dc, Offset: 0x1598
// Size: 0xa
function interrogation_scene_play( a_ents )
{
    
}

// Namespace hideout_outro
// Params 1
// Checksum 0x85d48cd2, Offset: 0x15b0
// Size: 0x3b
function interrogation_scene_done( a_ents )
{
    array::thread_all( level.players, &infection_util::player_leave_cinematic );
    level notify( #"interrogation_done" );
}

// Namespace hideout_outro
// Params 0
// Checksum 0x681b87e, Offset: 0x15f8
// Size: 0x52
function function_423ccbef()
{
    level waittill( #"hash_c71d58c6" );
    playsoundatposition( "evt_interrogation_vtol", ( -7159, 17021, 5990 ) );
    level waittill( #"hash_79fdda3d" );
    playsoundatposition( "evt_interrogation_vtol_fade", ( 0, 0, 0 ) );
}

// Namespace hideout_outro
// Params 4
// Checksum 0x6d64f81b, Offset: 0x1658
// Size: 0x72
function interrogation_cleanup( str_objective, b_starting, b_direct, player )
{
    exploder::exploder( "city_lightning" );
    
    if ( b_starting )
    {
        exploder::exploder( "exploder_interrogation_transition" );
    }
    
    if ( isdefined( level.interrogation_bot ) )
    {
        level.interrogation_bot delete();
    }
}

// Namespace hideout_outro
// Params 2
// Checksum 0x48b0b995, Offset: 0x16d8
// Size: 0x2fa
function stalingrad_creation_main( str_objective, b_starting )
{
    level notify( #"update_billboard" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        util::set_streamer_hint( 4 );
    }
    else
    {
        util::screen_fade_out( 0, "white" );
    }
    
    scene::add_scene_func( "cin_inf_16_01_zombies_vign_treemoment_intro", &stalingrad_creation_play, "play" );
    scene::add_scene_func( "cin_inf_16_01_zombies_vign_treemoment_intro", &stalingrad_creation_done, "done" );
    scene::add_scene_func( "cin_inf_14_04_sarah_vign_05", &function_c5b11e32, "play" );
    
    if ( b_starting )
    {
        load::function_a2995f22();
        util::screen_fade_out( 0 );
        util::delay( 1, undefined, &util::screen_fade_in, 1 );
    }
    else
    {
        util::delay( 1, undefined, &util::screen_fade_in, 1, "white" );
    }
    
    skipto::teleport_players( str_objective, 1 );
    
    if ( isdefined( level.bzm_infectiondialogue17callback ) )
    {
        level thread [[ level.bzm_infectiondialogue17callback ]]();
    }
    
    level scene::play( "cin_inf_14_04_sarah_vign_05" );
    
    if ( b_starting )
    {
        level thread util::clear_streamer_hint();
    }
    
    var_7d116593 = struct::get( "s_city_loc", "targetname" );
    infection_util::function_7aca917c( var_7d116593.origin );
    util::delay( 1, undefined, &util::screen_fade_in, 2.5, "white" );
    level thread scene::play( "cin_inf_16_01_zombies_vign_treemoment_intro" );
    level thread function_579b7304();
    wait 5;
    
    if ( isdefined( level.bzm_infectiondialogue18callback ) )
    {
        level thread [[ level.bzm_infectiondialogue18callback ]]();
    }
    
    level thread growing_tree_init();
    wait 5;
    level thread stalingrad_rise_think();
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "cp_infection_hideout_stretch" );
    }
    
    level thread util::clear_streamer_hint();
}

// Namespace hideout_outro
// Params 0
// Checksum 0x9cc6fbf6, Offset: 0x19e0
// Size: 0x10a
function function_579b7304()
{
    level.pavlov_sarah = getent( "sarah", "animname" );
    
    if ( !isdefined( level.pavlov_sarah ) )
    {
        level.pavlov_sarah = spawner::simple_spawn_single( "sarah" );
    }
    
    level.pavlov_sarah.goalradius = 32;
    level.pavlov_sarah setteam( "allies" );
    level.pavlov_sarah ai::set_ignoreall( 1 );
    level.pavlov_sarah ai::set_ignoreme( 1 );
    level.pavlov_sarah util::magic_bullet_shield();
    level.pavlov_sarah ai::gun_remove();
    level.pavlov_sarah.allowpain = 0;
    level thread scene::play( "cin_inf_16_01_zombies_vign_treemoment_gameplay_loop" );
}

// Namespace hideout_outro
// Params 1
// Checksum 0xdfc21895, Offset: 0x1af8
// Size: 0x32
function function_c5b11e32( a_ents )
{
    level waittill( #"start_fade" );
    level thread util::screen_fade_out( 1, "white" );
}

// Namespace hideout_outro
// Params 1
// Checksum 0x5f55fd52, Offset: 0x1b38
// Size: 0x32
function stalingrad_creation_play( a_ents )
{
    a_ents[ "player 1" ] waittill( #"start_house_fx" );
    level thread scene::play( "p7_fxanim_cp_infection_reverse_stalingrad_house_bundle" );
}

// Namespace hideout_outro
// Params 1
// Checksum 0x409dfef8, Offset: 0x1b78
// Size: 0x22
function stalingrad_creation_done( a_ents )
{
    level thread skipto::objective_completed( "city_barren" );
}

// Namespace hideout_outro
// Params 0
// Checksum 0xf27f128a, Offset: 0x1ba8
// Size: 0x3a
function stalingrad_rise_think()
{
    level.players[ 0 ] playsound( "evt_city_rise" );
    level clientfield::set( "stalingrad_rise_nuke", 1 );
}

// Namespace hideout_outro
// Params 4
// Checksum 0x87a45cc3, Offset: 0x1bf0
// Size: 0x22
function stalingrad_creation_cleanup( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace hideout_outro
// Params 0
// Checksum 0x57f8eab1, Offset: 0x1c20
// Size: 0x3a
function growing_tree_init()
{
    level clientfield::set( "stalingrad_tree_init", 1 );
    level.players[ 0 ] playsound( "evt_tree_grow" );
}

// Namespace hideout_outro
// Params 2
// Checksum 0xd80941b7, Offset: 0x1c68
// Size: 0x22a
function pavlovs_house_main( str_objective, b_starting )
{
    level notify( #"update_billboard" );
    spawner::add_global_spawn_function( "axis", &function_40dc724e );
    infection_accolades::function_6c777c8d();
    infection_accolades::function_a0fb8ca9();
    infection_accolades::function_70cafec1();
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level clientfield::set( "stalingrad_tree_init", 1 );
        level clientfield::set( "stalingrad_rise_nuke", 1 );
        level thread function_579b7304();
        load::function_a2995f22();
        level thread util::screen_fade_in( 2, "black" );
        skipto::teleport_players( str_objective, 1 );
    }
    else
    {
        util::screen_fade_out( 0.3, "white" );
        skipto::teleport_players( str_objective, 1 );
        level thread util::screen_fade_in( 0.2, "white" );
    }
    
    infection_util::enable_exploding_deaths( 1 );
    level thread random_lightning();
    level thread pavlov_house_fxanim_init();
    level flag::clear( "spawn_zombies" );
    level notify( #"start_zombie_sequence" );
    level thread function_33c4ce19();
    objectives::set( "cp_level_infection_zombies" );
    playsoundatposition( "evt_inf_spawn", ( 27444, 554, -3252 ) );
    level thread function_c4fe5f45();
    level flag::wait_till( "sarah_tree" );
    level thread skipto::objective_completed( "city" );
}

// Namespace hideout_outro
// Params 0
// Checksum 0x3bde766, Offset: 0x1ea0
// Size: 0xc2
function function_33c4ce19()
{
    ent1 = spawn( "script_origin", ( 27559, -255, -3078 ) );
    ent2 = spawn( "script_origin", ( 27421, 1613, -2992 ) );
    ent1 playloopsound( "evt_zombies_walla", 2 );
    wait 12;
    ent2 playloopsound( "evt_zombies_walla", 2 );
    level flag::wait_till( "zombies_completed" );
    ent1 delete();
    ent2 delete();
}

// Namespace hideout_outro
// Params 0
// Checksum 0x60bd296, Offset: 0x1f70
// Size: 0x32
function function_40dc724e()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    self clientfield::set( "zombie_tac_mode_disable", 1 );
}

// Namespace hideout_outro
// Params 0
// Checksum 0xbc199338, Offset: 0x1fb0
// Size: 0x32
function function_c4fe5f45()
{
    level dialog::player_say( "plyr_what_the_hell_is_tha_0", 3 );
    level dialog::player_say( "plyr_sarah_these_monste_0", 8 );
}

// Namespace hideout_outro
// Params 0
// Checksum 0x3661ed9d, Offset: 0x1ff0
// Size: 0x4a
function pavlov_house_fxanim_init()
{
    a_t_ceilings = getentarray( "t_house_ceiling", "targetname" );
    array::thread_all( a_t_ceilings, &pavlov_house_fxanim_play );
}

// Namespace hideout_outro
// Params 0
// Checksum 0x8a5b1956, Offset: 0x2048
// Size: 0x42
function function_545f4b96()
{
    wait 2.5;
    var_115ce1e8 = getent( "pavlovs_house_second_floor_railing_clip", "targetname" );
    var_115ce1e8 delete();
}

// Namespace hideout_outro
// Params 0
// Checksum 0xa109daab, Offset: 0x2098
// Size: 0x127
function pavlov_house_fxanim_play()
{
    self endon( #"death" );
    
    if ( isdefined( self.target ) )
    {
        s_target = struct::get( self.target, "targetname" );
    }
    
    wait 3;
    
    while ( true )
    {
        self trigger::wait_till();
        
        if ( isplayer( self.who ) )
        {
            player = self.who;
            
            if ( isdefined( s_target ) )
            {
                self thread player_look_at_watcher( player, s_target );
                self waittill( #"trigger_fxanim_ceiling" );
                self notify( #"fxanim_ceiling_set" );
            }
            
            if ( self.script_int == 2 )
            {
                level thread scene::play( "p7_fxanim_cp_infection_house_ceiling_02_bundle" );
            }
            else
            {
                level clientfield::set( "stalingrad_city_ceilings", self.script_int );
                
                if ( self.script_int == 3 )
                {
                    level thread function_545f4b96();
                }
            }
            
            self delete();
            return;
        }
    }
}

// Namespace hideout_outro
// Params 2
// Checksum 0x1c413a38, Offset: 0x21c8
// Size: 0x63
function player_look_at_watcher( player, s_target )
{
    self endon( #"fxanim_ceiling_set" );
    self endon( #"death" );
    player endon( #"death" );
    
    while ( !player infection_util::lookingatstructdurationonly( s_target, 0.5, 400 ) )
    {
        wait 0.1;
    }
    
    self notify( #"trigger_fxanim_ceiling" );
}

// Namespace hideout_outro
// Params 4
// Checksum 0xc5e78d20, Offset: 0x2238
// Size: 0xe3
function pavlovs_house_cleanup( str_objective, b_starting, b_direct, player )
{
    infection_accolades::function_bbb224b7();
    spawner::remove_global_spawn_function( "axis", &function_40dc724e );
    a_t_ceilings = getentarray( "t_house_ceiling", "targetname" );
    
    foreach ( trig in a_t_ceilings )
    {
        trig delete();
    }
}

// Namespace hideout_outro
// Params 2
// Checksum 0x73788c8d, Offset: 0x2328
// Size: 0x1da
function pavlovs_house_end( str_objective, b_starting )
{
    level thread clientfield::set( "city_tree_passed", 1 );
    level.city_skipped = 1;
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level clientfield::set( "stalingrad_rise_nuke", 1 );
        level clientfield::set( "stalingrad_tree_init", 1 );
        level thread scene::skipto_end( "p7_fxanim_cp_infection_house_ceiling_02_bundle" );
        n_ceilings = 4;
        
        for ( i = 0; i < n_ceilings ; i++ )
        {
            level clientfield::set( "stalingrad_city_ceilings", i );
        }
        
        level thread function_545f4b96();
        wait 3;
        infection_util::enable_exploding_deaths( 1 );
        level thread random_lightning();
        level flag::clear( "spawn_zombies" );
        level.round_number = 4;
        level notify( #"start_zombie_sequence" );
        level thread function_33c4ce19();
        objectives::set( "cp_level_infection_zombies" );
        level flag::set( "zombies_final_round" );
        level flag::set( "spawn_zombies" );
        load::function_a2995f22();
    }
    
    level flag::wait_till( "zombies_completed" );
    level thread skipto::objective_completed( "city_tree" );
    infection_util::enable_exploding_deaths( 0 );
}

// Namespace hideout_outro
// Params 4
// Checksum 0xcbb994c7, Offset: 0x2510
// Size: 0x1fb
function pavlovs_end_cleanup( str_objective, b_starting, b_direct, player )
{
    level notify( #"zombies_completed" );
    level flag::set( "zombies_completed" );
    zombies = getaispeciesarray( level.zombie_team, "all" );
    
    if ( isdefined( zombies ) )
    {
        for ( i = 0; i < zombies.size ; i++ )
        {
            zombies[ i ] delete();
        }
    }
    
    infection_accolades::function_e9c21474();
    
    if ( isdefined( level.pavlov_sarah ) )
    {
        level.pavlov_sarah delete();
    }
    
    t_fire_trig = getent( "pavlov_house_fire", "targetname" );
    
    if ( isdefined( t_fire_trig ) )
    {
        t_fire_trig delete();
    }
    
    t_fire_warning_trig = getent( "pavlov_house_fire_warning", "targetname" );
    
    if ( isdefined( t_fire_warning_trig ) )
    {
        t_fire_warning_trig delete();
    }
    
    firewallfx = getentarray( "firewall_firepos", "targetname" );
    
    foreach ( ent in firewallfx )
    {
        ent clientfield::set( "zombie_fire_wall_fx", 0 );
        util::wait_network_frame();
        ent delete();
    }
}

// Namespace hideout_outro
// Params 0
// Checksum 0xc07a8fe1, Offset: 0x2718
// Size: 0x62
function pavlovs_temp_messages()
{
    level endon( #"zombies_completed" );
    self endon( #"death" );
    
    if ( !( isdefined( level.city_skipped ) && level.city_skipped ) )
    {
        level flag::set( "spawn_zombies" );
        self thread vo_sarah_between_rounds();
        level thread vo_player_fire_warning();
    }
}

// Namespace hideout_outro
// Params 0
// Checksum 0xaf596a5b, Offset: 0x2788
// Size: 0x9a
function vo_sarah_between_rounds()
{
    level endon( #"zombies_completed" );
    self endon( #"death" );
    self endon( #"running_out" );
    level waittill( #"sarah_speaks_surge" );
    wait 2;
    level thread infection_zombies::sarah_flash_kill( 0 );
    self scene::play( "cin_inf_16_01_zombies_vign_treemoment_talk01", self );
    self thread scene::play( "cin_inf_16_01_zombies_vign_treemoment_gameplay_loop", self );
    level flag::set( "zombies_final_round" );
    level flag::set( "spawn_zombies" );
}

// Namespace hideout_outro
// Params 0
// Checksum 0x5a92ed05, Offset: 0x2830
// Size: 0x82
function vo_player_fire_warning()
{
    while ( level.round_number < 3 )
    {
        level waittill( #"end_of_round" );
    }
    
    level dialog::player_say( "plyr_hall_we_can_t_stay_0", 0 );
    wait 2;
    level dialog::say( "corv_let_her_go_0", 0 );
    level dialog::player_say( "plyr_sarah_whoever_that_0", 1 );
    level dialog::player_say( "plyr_who_are_you_what_0", 1 );
}

// Namespace hideout_outro
// Params 0
// Checksum 0x8df60419, Offset: 0x28c0
// Size: 0xcd
function random_lightning()
{
    while ( !level flag::get( "zombies_completed" ) )
    {
        level thread lui::screen_fade( 0.2, 0.7, 1, "white" );
        playsoundatposition( "evt_infection_thunder_special", ( 0, 0, 0 ) );
        wait 0.5;
        level thread lui::screen_fade( 1, 0, 0.7, "white" );
        wait randomfloatrange( 0.3, 1.2 );
        playsoundatposition( "evt_infection_thunder_special", ( 0, 0, 0 ) );
        wait randomfloatrange( 6, 36 );
    }
}

// Namespace hideout_outro
// Params 0
// Checksum 0x345f92df, Offset: 0x2998
// Size: 0x73
function function_5b6766b2()
{
    foreach ( player in getplayers() )
    {
        player thread clientfield::increment_to_player( "ukko_toggling" );
    }
}

// Namespace hideout_outro
// Params 2
// Checksum 0xe23198b6, Offset: 0x2a18
// Size: 0x1a2
function stalingrad_nuke_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level clientfield::set( "stalingrad_rise_nuke", 1 );
        level clientfield::set( "stalingrad_tree_init", 1 );
        skipto::teleport_players( str_objective, 0 );
        level flag::wait_till( "all_players_spawned" );
        level thread scene::skipto_end( "p7_fxanim_cp_infection_house_ceiling_02_bundle" );
        n_ceilings = 4;
        
        for ( i = 0; i < n_ceilings ; i++ )
        {
            level clientfield::set( "stalingrad_city_ceilings", i );
        }
        
        wait 7;
        load::function_a2995f22();
    }
    
    scene::add_scene_func( "cin_inf_18_outro_3rd_sh140", &outro_scene_done, "init" );
    level scene::init( "cin_inf_18_outro_3rd_sh010" );
    level notify( #"update_billboard" );
    array::thread_all( level.players, &infection_util::player_enter_cinematic );
    level thread vo_stalingrad_nuke();
    level thread stalingrad_nuke_think();
    level waittill( #"stalingrad_destroyed" );
    level thread skipto::objective_completed( "city_nuked" );
}

// Namespace hideout_outro
// Params 0
// Checksum 0x1a52172a, Offset: 0x2bc8
// Size: 0x1bf
function stalingrad_nuke_think()
{
    nuke_pos = struct::get( "nuke_fx_pos", "targetname" );
    forward = anglestoforward( nuke_pos.angles );
    up = ( 0, 0, 1 );
    time_nuke = 4;
    time_fade = 4;
    array::thread_all( level.players, &clientfield::set_to_player, "nuke_earth_quake", 2 );
    level clientfield::set( "zombie_root_grow", 0 );
    level clientfield::set( "stalingrad_tree_init", 2 );
    
    if ( isdefined( level.bzm_infectiondialogue19callback ) )
    {
        level thread [[ level.bzm_infectiondialogue19callback ]]();
    }
    
    wait 4;
    level clientfield::set( "infection_nuke_lights", 1 );
    level clientfield::set( "stalingrand_nuke_fog_banks", 1 );
    wait 1;
    playfx( level._effect[ "nuke_fx" ], nuke_pos.origin, forward, up );
    array::thread_all( level.players, &clientfield::set_to_player, "nuke_earth_quake", time_nuke + time_fade );
    level clientfield::set( "stalingrad_rise_nuke", 2 );
    wait time_nuke;
    wait time_fade;
    level thread util::screen_fade_out( 0, "black" );
    wait 2;
    level notify( #"stalingrad_destroyed" );
}

// Namespace hideout_outro
// Params 1
// Checksum 0xa48d4e49, Offset: 0x2d90
// Size: 0xd9
function nuke_earth_quake( time )
{
    start_time = gettime();
    time_passed = 0;
    scale = 0.1;
    self playrumbleonentity( "tank_damage_heavy_mp" );
    earthquake( 0.3, 0.5, self.origin, 100 );
    
    while ( time_passed < time )
    {
        self playrumbleonentity( "damage_heavy" );
        earthquake( scale, 1, self.origin, 100 );
        wait 0.25;
        scale += 0.015;
        time_passed = ( gettime() - start_time ) / 1000;
    }
}

// Namespace hideout_outro
// Params 0
// Checksum 0xd87a30cd, Offset: 0x2e78
// Size: 0x62
function vo_stalingrad_nuke()
{
    level dialog::say( "corv_listen_only_to_the_s_1", 1, 1 );
    level dialog::say( "corv_let_your_mind_relax_1", 1, 1 );
    level dialog::say( "corv_imagine_yourself_in_1", 0, 1 );
}

// Namespace hideout_outro
// Params 4
// Checksum 0x4326f38a, Offset: 0x2ee8
// Size: 0x3a
function stalingrad_nuke_cleanup( str_objective, b_starting, b_direct, player )
{
    level clientfield::set( "stalingrand_nuke_fog_banks", 0 );
}

// Namespace hideout_outro
// Params 2
// Checksum 0xa715a5ac, Offset: 0x2f30
// Size: 0xfa
function outro_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        scene::add_scene_func( "cin_inf_18_outro_3rd_sh140", &outro_scene_done, "init" );
        level scene::init( "cin_inf_18_outro_3rd_sh010" );
        load::function_a2995f22();
    }
    else
    {
        util::streamer_wait();
    }
    
    level thread util::screen_fade_in( 2 );
    
    if ( isdefined( level.bzm_infectiondialogue20callback ) )
    {
        level thread [[ level.bzm_infectiondialogue20callback ]]();
    }
    
    level thread namespace_99d8554b::function_a0a44ed9();
    level thread audio::unlockfrontendmusic( "mus_infection_church_intro" );
    level scene::play( "cin_inf_18_outro_3rd_sh010" );
}

// Namespace hideout_outro
// Params 1
// Checksum 0x8530c814, Offset: 0x3038
// Size: 0xfa
function outro_scene_done( a_ents )
{
    level waittill( #"hash_6a87e7bc" );
    level clientfield::set( "sndIGCsnapshot", 4 );
    
    if ( scene::is_skipping_in_progress() )
    {
        level util::screen_fade_out( 0, "black", "end_level_fade" );
    }
    else
    {
        level util::screen_fade_out( 0.5, "black", "end_level_fade" );
    }
    
    foreach ( player in level.players )
    {
        player disableweapons();
    }
    
    level thread skipto::objective_completed( "outro" );
}

// Namespace hideout_outro
// Params 4
// Checksum 0x5fac10d8, Offset: 0x3140
// Size: 0x22
function outro_cleanup( str_objective, b_starting, b_direct, player )
{
    
}

