#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_aquifer_accolades;
#using scripts/cp/cp_mi_cairo_aquifer_aitest;
#using scripts/cp/cp_mi_cairo_aquifer_ambience;
#using scripts/cp/cp_mi_cairo_aquifer_boss;
#using scripts/cp/cp_mi_cairo_aquifer_fx;
#using scripts/cp/cp_mi_cairo_aquifer_interior;
#using scripts/cp/cp_mi_cairo_aquifer_objectives;
#using scripts/cp/cp_mi_cairo_aquifer_sound;
#using scripts/cp/cp_mi_cairo_aquifer_utility;
#using scripts/cp/gametypes/_save;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_cairo_aquifer;

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0x11436c24, Offset: 0xf60
// Size: 0x32
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0x65b9971f, Offset: 0xfa0
// Size: 0x2d2
function main()
{
    if ( sessionmodeiscampaignzombiesgame() && 0 )
    {
        setclearanceceiling( 34 );
    }
    else
    {
        setclearanceceiling( 116 );
    }
    
    precache();
    skipto_setup();
    init_flags();
    util::init_streamer_hints( 11 );
    savegame::set_mission_name( "aquifer" );
    cp_mi_cairo_aquifer_fx::main();
    cp_mi_cairo_aquifer_sound::main();
    aquifer_ambience::main();
    cp_mi_cairo_aquifer_aitest::init();
    thread cp_mi_cairo_aquifer_aitest::function_82230f12();
    callback::on_finalize_initialization( &on_finalize_initialization );
    callback::on_connect( &on_player_connected );
    callback::on_disconnect( &on_player_disconnected );
    callback::on_spawned( &on_player_spawned );
    callback::on_loadout( &on_player_loadout );
    callback::on_player_killed( &on_player_death );
    level.overrideplayerdamage = &function_6d9a8286;
    level.custombadplacethread = &function_48694c4a;
    spawner::add_global_spawn_function( "axis", &function_f141f41c );
    compass::setupminimap( "compass_map_cp_mi_cairo_aquifer" );
    load::main();
    aquifer_accolades::function_4d39a2af();
    aquifer_util::loadeffects();
    thread function_c2c4ea75();
    setdvar( "compassmaxrange", "2100" );
    createthreatbiasgroup( "players_vtol" );
    createthreatbiasgroup( "players_ground" );
    createthreatbiasgroup( "defend_hunters" );
    load::function_73adcefc();
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0x5956f0f1, Offset: 0x1280
// Size: 0x25a
function init_flags()
{
    level flag::init( "sniper_boss_spawned" );
    level flag::init( "end_battle" );
    level flag::init( "init_run" );
    level flag::init( "boss_taunt1" );
    level flag::init( "boss_taunt2" );
    level flag::init( "inside_water_room" );
    level flag::init( "inside_data_center" );
    level flag::init( "dogfighting" );
    level flag::init( "flag_khalil_water_igc_done" );
    level flag::init( "start_interior_breadcrumbs" );
    level flag::init( "lcombat_respawn_ground" );
    level flag::init( "show_defenses_mid_objectives" );
    level flag::init( "overload_in_progress" );
    level flag::init( "player_really_landed" );
    level flag::init( "boss_convo" );
    level flag::init( "breach_vo_complete" );
    level flag::init( "flight_to_water_vo_cleared" );
    level flag::init( "water_corvus_vo_cleared" );
    level flag::init( "intro_dogfight_global_active" );
    level flag::init( "enter_dogfight_global_active" );
    level flag::init( "intro_chryon_done" );
    level flag::init( "intro_finished" );
    level flag::init( "intro_dialog_finished" );
    level flag::init( "play_intro" );
    level flag::init( "flying_main_scene_done" );
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0xbf11d202, Offset: 0x14e8
// Size: 0x55f
function skipto_setup()
{
    skipto::add( "level_long_fly_in", &aquifer_obj::skipto_level_long_fly_in_init, "Intro spawnvtol", &aquifer_obj::skipto_level_long_fly_in_done );
    skipto::function_d68e678e( "intro_dogfight", &aquifer_obj::function_9239cf5c, "Destroy Bogey spawnvtol", &aquifer_obj::function_b3635282 );
    skipto::function_d68e678e( "destroy_defenses", &aquifer_obj::skipto_defenses_init, "Destroy AA defenses spawnvtol", &aquifer_obj::skipto_defenses_done );
    skipto::function_d68e678e( "hack_terminal_left", &aquifer_obj::skipto_hack_init, "Hack Left Defend checkkayneexist", &aquifer_obj::skipto_hack_done );
    skipto::function_d68e678e( "destroy_defenses_mid", &aquifer_obj::function_fb03103d, "Destroy Remaining AA spawnvtol", &aquifer_obj::function_46151925 );
    skipto::function_d68e678e( "hack_terminal_right", &aquifer_obj::function_386c647b, "Hack Right Defend checkkayneexist", &aquifer_obj::function_ec898691 );
    skipto::add( "water_room", &aquifer_obj::skipto_water_room_init, "Searching checkenteredwater", &aquifer_obj::skipto_water_room_done );
    skipto::function_d68e678e( "water_room_exit", &aquifer_obj::function_e2e38eb, "Exit Water", &aquifer_obj::function_829aa821 );
    skipto::function_d68e678e( "post_water_room_dogfight", &aquifer_obj::function_5b113d76, "Destroy Bogey", &aquifer_obj::function_427463e0 );
    skipto::function_d68e678e( "destroy_defenses2", &aquifer_obj::skipto_defenses_init2, "Support Egyptian Forces spawnvtol", &aquifer_obj::skipto_defenses_done2 );
    skipto::function_d68e678e( "hack_terminals3", &aquifer_obj::skipto_hack_init3, "L Combat checkplayerlanded", &aquifer_obj::skipto_hack_done3 );
    skipto::function_d68e678e( "breach_hangar", &aquifer_obj::skipto_breach_init, "Hangar Breach", &aquifer_obj::skipto_breach_done );
    skipto::add( "post_breach", &aquifer_obj::skipto_post_breach_init, "Post Breach", &aquifer_obj::skipto_post_breach_done );
    skipto::function_d68e678e( "sniper_boss_intro", &aquifer_obj::function_53d54ffb, "Hyperion Battle Intro", &aquifer_obj::function_7f27211 );
    skipto::add( "sniper_boss", &aquifer_obj::skipto_boss_init, "Hyperion Battle", &aquifer_obj::skipto_boss_done );
    skipto::function_d68e678e( "hideout", &aquifer_obj::skipto_hideout_init, "Hyperion's hideout", &aquifer_obj::skipto_hideout_done );
    skipto::add( "run_out", &aquifer_obj::function_95463da0, "Flee From Aquifer", &aquifer_obj::function_fb8ad8d6 );
    skipto::add( "exfil", &aquifer_obj::skipto_exfil_init, "Exfil", &aquifer_obj::skipto_exfil_done );
    
    /#
        skipto::add_dev( "<dev string:x28>", &aquifer_obj::function_3230f09a, "<dev string:x28>", &aquifer_obj::function_a02afda4 );
    #/
    
    level.skipto_triggers = [];
    a_trigs = getentarray( "objective", "targetname" );
    
    foreach ( trig in a_trigs )
    {
        if ( isdefined( trig.script_objective ) )
        {
            level.skipto_triggers[ trig.script_objective ] = trig;
        }
    }
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0x44021dc7, Offset: 0x1a50
// Size: 0x302
function billboard()
{
    skipto::add_billboard( "level_long_fly_in", "INTRO", "Pacing", "Small" );
    skipto::add_billboard( "intro_dogfight", "DOGFIGHT", "Aerial Combat", "Large" );
    skipto::add_billboard( "destroy_defenses", "DESTROY AA DEFENSES", "Aerial Combat", "Large" );
    skipto::add_billboard( "hack_terminal_left", "HACK_LEFT", "Combat", "Medium" );
    skipto::add_billboard( "destroy_defenses_mid", "DESTROY REMAINING AA DEFENSES", "Combat", "Large" );
    skipto::add_billboard( "hack_terminal_right", "HACK_RIGHT", "Combat", "Medium" );
    skipto::add_billboard( "water_room", "CONFRONT HYPERION", "Pacing", "Small" );
    skipto::add_billboard( "water_room_exit", "WATER ROOM EXIT", "Pacing", "Small" );
    skipto::add_billboard( "post_water_room_dogfight", "DOGFIGHT", "Aerial Combat", "Large" );
    skipto::add_billboard( "destroy_defenses2", "SUPPORT EGYPTIANS", "Combat", "Medium" );
    skipto::add_billboard( "hack_terminals3", "ON HYPERION'S TRAIL", "Pacing", "Large" );
    skipto::add_billboard( "breach_hangar", "BREACH", "Moment", "Small" );
    skipto::add_billboard( "post_breach", "CHASE", "Combat", "Size" );
    skipto::add_billboard( "sniper_boss", "BOSS", "Battle", "Medium" );
    skipto::add_billboard( "hideout", "HIDEOUT", "Story", "Medium" );
    skipto::add_billboard( "exfil", "EXFIL", "Run", "High" );
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0x4c7fd21, Offset: 0x1d60
// Size: 0x36a
function precache()
{
    level flag::init( "boss_finale_ready" );
    level flag::init( "minions_clear" );
    level flag::init( "start_aquifer_objectives" );
    level flag::init( "breach_hangar_active" );
    level flag::init( "hold_for_debug_splash" );
    level flag::init( "on_hangar_exterior" );
    level flag::init( "player_active_in_level" );
    level flag::init( "water_room_checkpoint" );
    level flag::init( "can_spawn_hunters" );
    level flag::init( "hack_terminals2_vtol_flyin" );
    level flag::init( "lcombat_missile_launch" );
    level flag::init( "lcombat_flyby_shake" );
    level flag::init( "lcombat_crash_event" );
    level flag::init( "amb_flyby_jet_crash" );
    level flag::init( "lcombat_quad_missile_launch" );
    level flag::init( "lcombat_flyby_shake_2" );
    level flag::init( "trans_attack_start" );
    level flag::init( "siegebot_overrun_trig" );
    level flag::init( "lcombat_player_landed" );
    level flag::init( "disable_player_exit_vtol" );
    level flag::init( "disable_player_enter_vtol" );
    level flag::init( "background_chatter_active" );
    level flag::init( "enable_vtol_landing_zones" );
    level flag::init( "finished_first_landing_vo" );
    level flag::init( "flag_egyptian_hacking_completed" );
    
    if ( !level flag::exists( "destroy_defenses3_completed" ) )
    {
        level flag::init( "destroy_defenses3_completed" );
        level flag::init( "destroy_defenses3_started" );
        level flag::init( "destroy_defenses3" );
        level flag::init( "hack_terminals3_started" );
        level flag::init( "hack_terminals3" );
        level flag::init( "hack_terminals3_completed" );
    }
    
    level.fast_hack = 0;
    level.hack_upload_range = 4096;
    level.var_f00df7e8 = 1;
    thread aquifer_util::setup_reusable_destructible();
    thread aquifer_util::function_a97555a0( "enemy_vtol_riders", "zone3_vtol_dropoff" );
    thread vehicle_ai::register_custom_add_state_callback( &function_8f9628e0 );
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0xae6aaa5d, Offset: 0x20d8
// Size: 0x77
function function_c2c4ea75()
{
    while ( true )
    {
        level waittill( #"save_restore" );
        
        foreach ( player in level.players )
        {
            player clearplayergravity();
        }
    }
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0x9916101d, Offset: 0x2158
// Size: 0x12
function on_finalize_initialization()
{
    aquifer_util::function_11a9191();
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0x5903ea8c, Offset: 0x2178
// Size: 0x5a
function function_8f9628e0()
{
    if ( isdefined( self.variant ) && self.variant == "rocketpod" )
    {
        self.allow_movement = 0;
        self vehicle_ai::get_state_callbacks( "combat" ).update_func = &aquifer_util::function_11b961b7;
    }
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0x9ff400c5, Offset: 0x21e0
// Size: 0x262
function on_player_connected()
{
    self endon( #"disconnect" );
    self.player_num = self getentitynumber() + 1;
    level flag::wait_till( "start_coop_logic" );
    self flagsys::wait_till( "loadout_given" );
    thread aquifer_util::function_c2768198();
    
    if ( level flag::exists( "intro_dogfight" ) && level flag::get( "intro_dogfight" ) && !level flag::get( "intro_dogfight_completed" ) )
    {
        self thread aquifer_obj::function_ef5a929e();
    }
    else if ( level flag::exists( "post_water_room_dogfight" ) && level flag::get( "post_water_room_dogfight" ) && !level flag::get( "post_water_room_dogfight_completed" ) )
    {
    }
    else if ( level flag::exists( "water_room_exit" ) && level flag::get( "water_room_exit" ) && !level flag::get( "water_room_exit_completed" ) )
    {
    }
    else if ( level flag::exists( "hack_terminals3" ) && !level flag::get( "hack_terminals3_completed" ) )
    {
    }
    
    if ( level flag::exists( "hack_terminals3" ) && !level flag::get( "hack_terminals3_completed" ) )
    {
        if ( level flag::exists( "hack_terminal_right" ) && !level flag::get( "hack_terminal_right_completed" ) )
        {
            self thread aquifer_util::player_init_heightmap_intro_state( 1 );
            return;
        }
        
        if ( level flag::exists( "water_room" ) && !level flag::get( "water_room_completed" ) )
        {
            self thread aquifer_util::function_a0567298( 1 );
            return;
        }
        
        self thread aquifer_util::player_init_heightmap_obj3_state( 1 );
    }
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0x39160386, Offset: 0x2450
// Size: 0x4a
function function_47c53384()
{
    self clientfield::set_to_player( "player_dust_fx", 0 );
    self clientfield::set_to_player( "player_snow_fx", 0 );
    self clientfield::set_to_player( "water_motes", 0 );
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0x2d90b17f, Offset: 0x24a8
// Size: 0x22
function on_player_disconnected()
{
    if ( isdefined( self.pvtol ) )
    {
        self.pvtol delete();
    }
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0x5acb13fc, Offset: 0x24d8
// Size: 0xd2
function on_player_spawned()
{
    self clearplayergravity();
    
    if ( self aquifer_util::function_c43fe5d3() )
    {
        if ( level.var_4063f562 == "scripted" || isdefined( level.var_4063f562 ) && level.var_4063f562 == "piloted" )
        {
            self aquifer_util::function_22a0413d( level.var_4063f562 );
        }
        else
        {
            self aquifer_util::function_22a0413d();
        }
    }
    
    self.var_b9a81bed = self openluimenu( "HackUploadHUD" );
    self thread aquifer_util::player_underwater();
    self thread aquifer_util::function_a05f9e55();
    self thread aquifer_util::function_3de8b7b4();
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0xdddf9f42, Offset: 0x25b8
// Size: 0x6a
function on_player_loadout()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self.my_heightmap = "none";
    level flag::set( "player_active_in_level" );
    self notify( #"hash_a4d83d61" );
    
    if ( level.activeplayers.size == level.players.size )
    {
        level flagsys::set( "all_players_active" );
    }
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0xaa147002, Offset: 0x2630
// Size: 0x22
function on_player_death()
{
    function_47c53384();
    self undolaststand();
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x2660
// Size: 0x2
function function_48694c4a()
{
    
}

// Namespace cp_mi_cairo_aquifer
// Params 0
// Checksum 0xef0c83e8, Offset: 0x2670
// Size: 0x1e
function function_f141f41c()
{
    if ( isdefined( self.propername ) )
    {
        self.propername = "";
    }
}

// Namespace cp_mi_cairo_aquifer
// Params 11
// Checksum 0xdd23e561, Offset: 0x2698
// Size: 0x112
function function_6d9a8286( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex )
{
    if ( isdefined( self.var_cb4b9447 ) && self.var_cb4b9447 > gettime() )
    {
        return;
    }
    
    if ( weapon.name == "vtol_fighter_player_missile_turret" || weapon.name == "vtol_fighter_player_turret" )
    {
        ss = "frag_grenade_mp";
        var_76126537 = 2;
        
        if ( idamage > -56 )
        {
            ss = "proximity_grenade";
            var_76126537 = 3;
        }
        
        self.var_cb4b9447 = gettime() + var_76126537 * 499;
        self shellshock( ss, var_76126537 );
        self playrumbleonentity( "damage_heavy" );
    }
}

