#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_hazard;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/visionset_mgr_shared;

#namespace zurich_util;

// Namespace zurich_util
// Params 0, eflags: 0x2
// Checksum 0x6df8f0e0, Offset: 0x1a18
// Size: 0x2a
function autoexec __init__sytem__()
{
    system::register( "zurich_util", &__init__, undefined, undefined );
}

// Namespace zurich_util
// Params 0
// Checksum 0x57bc172c, Offset: 0x1a50
// Size: 0x15b
function __init__()
{
    level.lighting_state = 0;
    callback::on_spawned( &on_player_spawned );
    callback::on_disconnect( &on_player_disconnect );
    callback::on_actor_killed( &ai_death_explosions );
    spawner::add_global_spawn_function( "axis", &function_dc8f9fa6 );
    spawner::add_global_spawn_function( "axis", &ai_surreal_spawn_fx );
    spawner::add_global_spawn_function( "team3", &function_dc8f9fa6 );
    spawner::add_global_spawn_function( "axis", &function_b2c5d91c );
    util::init_breath_fx();
    init_client_field_callback_funcs();
    level._effect[ "root_heart_fire" ] = "fire/fx_fire_heart_burn_zurich";
    level._effect[ "hand_vine_fire" ] = "fire/fx_fire_ai_human_hand_vm";
}

// Namespace zurich_util
// Params 0
// Checksum 0x7e54119, Offset: 0x1bb8
// Size: 0x50a
function init_client_field_callback_funcs()
{
    var_2d20335b = getminbitcountfornum( 5 );
    var_a9ef5da3 = getminbitcountfornum( 6 );
    visionset_mgr::register_info( "visionset", "cp_zurich_hallucination", 1, 100, 1, 1 );
    clientfield::register( "actor", "exploding_ai_deaths", 1, 1, "int" );
    clientfield::register( "actor", "hero_spawn_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "hero_spawn_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "vehicle_spawn_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "set_world_fog", 1, 1, "int" );
    clientfield::register( "scriptmover", "raven_juke_effect", 1, 1, "counter" );
    clientfield::register( "actor", "raven_juke_limb_effect", 1, 1, "counter" );
    clientfield::register( "scriptmover", "raven_teleport_effect", 1, 1, "counter" );
    clientfield::register( "actor", "raven_teleport_limb_effect", 1, 1, "counter" );
    clientfield::register( "scriptmover", "raven_teleport_in_effect", 1, 1, "counter" );
    clientfield::register( "toplayer", "player_weather", 1, var_2d20335b, "int" );
    clientfield::register( "toplayer", "vortex_teleport", 1, 1, "counter" );
    clientfield::register( "toplayer", "postfx_futz", 1, 1, "counter" );
    clientfield::register( "toplayer", "postfx_futz_mild", 1, 1, "counter" );
    clientfield::register( "toplayer", "postfx_transition", 1, 1, "counter" );
    clientfield::register( "world", "zurich_city_ambience", 1, 1, "int" );
    clientfield::register( "actor", "skin_transition_melt", 1, 1, "int" );
    clientfield::register( "scriptmover", "corvus_body_fx", 1, 1, "int" );
    clientfield::register( "actor", "raven_ai_rez", 1, 1, "int" );
    clientfield::register( "scriptmover", "raven_ai_rez", 1, 1, "int" );
    clientfield::register( "toplayer", "zurich_server_cam", 1, 1, "int" );
    clientfield::register( "world", "set_exposure_bank", 1, 1, "int" );
    clientfield::register( "scriptmover", "corvus_tree_shader", 1, 1, "int" );
    clientfield::register( "actor", "hero_cold_breath", 1, 1, "int" );
    clientfield::register( "world", "set_post_color_grade_bank", 1, 1, "int" );
    clientfield::register( "toplayer", "postfx_hallucinations", 1, 1, "counter" );
    clientfield::register( "toplayer", "player_water_transition", 1, 1, "int" );
    clientfield::register( "toplayer", "raven_hallucinations", 1, 1, "int" );
    clientfield::register( "scriptmover", "quadtank_raven_explosion", 1, 1, "int" );
    clientfield::register( "scriptmover", "raven_fade_out", 1, 1, "int" );
}

// Namespace zurich_util
// Params 0
// Checksum 0x8e560f9e, Offset: 0x20d0
// Size: 0x3d1
function on_player_spawned()
{
    a_skiptos = skipto::get_current_skiptos();
    
    /#
        self thread debug_player_damage();
    #/
    
    if ( isdefined( a_skiptos ) )
    {
        switch ( a_skiptos[ 0 ] )
        {
            case "zurich":
                self player_weather( 1, "regular_snow" );
                break;
            case "street":
                self player_weather( 1, "regular_snow" );
                self thread util::player_frost_breath( 1 );
                break;
            case "rails":
                self player_weather( 1, "regular_snow" );
                self thread util::player_frost_breath( 1 );
                break;
            case "plaza_battle":
                self player_weather( 1, "regular_snow" );
                self thread util::player_frost_breath( 1 );
                level thread function_df1fc23b( 0 );
                break;
            case "hq":
                level thread function_2504fb31( 0 );
                level thread function_df1fc23b( 0 );
                break;
            case "sacrifice_igc":
                level thread function_2504fb31( 0 );
                break;
            case "server_room":
                self thread set_world_fog( 1 );
                break;
            case "clearing_start":
                self player_weather( 1, "light_snow" );
                self thread util::player_frost_breath( 1 );
                break;
            case "clearing_waterfall":
                self player_weather( 1, "light_snow" );
                self thread function_39af75ef( "clearing_path_selected" );
                self thread util::player_frost_breath( 1 );
                break;
            case "clearing_path_choice":
                self function_11b424e5();
                self player_weather( 1, "light_snow" );
                self thread util::player_frost_breath( 1 );
                break;
            case "clearing_end":
                self function_11b424e5();
                self player_weather( 1, "light_snow" );
                self thread util::player_frost_breath( 1 );
                break;
            case "root_cairo_start":
                break;
            case "root_cairo_vortex":
                break;
            case "root_singapore_start":
                self thread function_39af75ef( "singapore_root_completed" );
                break;
            case "root_singapore_vortex":
                self thread function_39af75ef( "singapore_root_completed" );
                break;
            case "root_zurich_start":
                self player_weather( 1, "regular_snow" );
                self thread util::player_frost_breath( 1 );
                break;
            case "root_zurich_vortex":
                self thread util::player_frost_breath( 1 );
                break;
            case "frozen_forest":
                self player_weather( 1, "red_rain" );
                break;
            case "server_interior":
                break;
            case "zurich_outro":
                level thread function_2504fb31( 1 );
                level thread function_df1fc23b( 0 );
                self function_11b424e5();
                break;
            default:
                break;
        }
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x24b0
// Size: 0x2
function on_player_disconnect()
{
    
}

// Namespace zurich_util
// Params 0
// Checksum 0xa5bcb6ae, Offset: 0x24c0
// Size: 0xc2
function setup_scene_callbacks()
{
    scene::add_scene_func( "p7_fxanim_cp_sgen_charging_station_open_01_bundle", &function_38b7a56, "init" );
    scene::add_scene_func( "p7_fxanim_cp_sgen_charging_station_break_01_bundle", &function_38b7a56, "init" );
    scene::add_scene_func( "p7_fxanim_cp_sgen_charging_station_break_02_bundle", &function_38b7a56, "init" );
    scene::add_scene_func( "p7_fxanim_cp_sgen_charging_station_break_03_bundle", &function_38b7a56, "init" );
}

// Namespace zurich_util
// Params 1
// Checksum 0x58370cee, Offset: 0x2590
// Size: 0x2a
function function_38b7a56( a_ents )
{
    array::run_all( a_ents, &notsolid );
}

// Namespace zurich_util
// Params 0
// Checksum 0x8346c5d6, Offset: 0x25c8
// Size: 0x1a
function function_a7b5b565()
{
    hidemiscmodels( "zurich_umbra_gate" );
}

// Namespace zurich_util
// Params 1
// Checksum 0xb91b30f1, Offset: 0x25f0
// Size: 0x6b
function function_5f63b2f1( n_state )
{
    foreach ( e_player in level.players )
    {
        e_player thread function_78e8c8b4( n_state );
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0xad8b870e, Offset: 0x2668
// Size: 0x15a
function function_78e8c8b4( n_state )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self notify( #"hash_6ae1015d" );
    
    if ( n_state == 1 )
    {
        self endon( #"hash_6ae1015d" );
        
        while ( true )
        {
            if ( math::cointoss() )
            {
                self util::show_hud( 0 );
            }
            
            if ( math::cointoss() )
            {
                self setclientuivisibilityflag( "weapon_hud_visible", 0 );
            }
            
            self thread clientfield::increment_to_player( "postfx_futz" );
            wait randomfloatrange( 2, 8 );
            
            if ( math::cointoss() )
            {
                self util::show_hud( 1 );
            }
            
            if ( math::cointoss() )
            {
                self setclientuivisibilityflag( "weapon_hud_visible", 1 );
            }
            
            self thread clientfield::increment_to_player( "postfx_futz" );
            wait randomfloatrange( 2, 8 );
        }
        
        return;
    }
    
    self util::show_hud( 0 );
    self setclientuivisibilityflag( "weapon_hud_visible", 0 );
}

// Namespace zurich_util
// Params 1
// Checksum 0xa1371b63, Offset: 0x27d0
// Size: 0x8f
function function_d0e3bb4( b_on )
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    if ( b_on )
    {
        foreach ( player in level.players )
        {
            player thread function_d6b3e7b5();
        }
        
        return;
    }
    
    level notify( #"hash_bdee213c" );
}

// Namespace zurich_util
// Params 0
// Checksum 0xf8861a95, Offset: 0x2868
// Size: 0x65
function function_d6b3e7b5()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"hash_bdee213c" );
    
    while ( true )
    {
        self clientfield::increment_to_player( "postfx_futz_mild" );
        wait 2.7;
        wait randomfloatrange( 2, 3 );
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x136b306a, Offset: 0x28d8
// Size: 0x4a
function function_be06d646()
{
    var_4e3140b1 = getentarray( "trig_falling_death", "targetname" );
    array::thread_all( var_4e3140b1, &falling_death_think );
}

// Namespace zurich_util
// Params 0
// Checksum 0x32e4eda3, Offset: 0x2930
// Size: 0x6d
function falling_death_think()
{
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( isplayer( who ) && !( isdefined( who.is_falling_to_death ) && who.is_falling_to_death ) )
        {
            who thread player_falls_to_death();
        }
        
        util::wait_network_frame();
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x5d769263, Offset: 0x29a8
// Size: 0xda
function player_falls_to_death()
{
    self.is_falling_to_death = 1;
    str_shader = "black";
    self enableinvulnerability();
    self thread hud::fade_to_black_for_x_sec( 0, 2, 0.5, 1, str_shader );
    wait 0 + 2;
    self thread move_player_to_respawn_point();
    wait 0.5;
    self.is_falling_to_death = 0;
    self disableinvulnerability();
    self dodamage( self.health / 10, self.origin );
    
    if ( self.health < 1 )
    {
        self.health = 1;
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x8225f692, Offset: 0x2a90
// Size: 0xc2
function move_player_to_respawn_point()
{
    str_skipto = level.skipto_point;
    a_respawn_points = spawnlogic::get_spawnpoint_array( "cp_coop_respawn" );
    a_respawn_points_filtered = skipto::filter_player_spawnpoints( self, a_respawn_points, str_skipto );
    assert( a_respawn_points_filtered.size, "<dev string:x28>" );
    s_warp = arraygetclosest( self.origin, a_respawn_points_filtered );
    self setorigin( s_warp.origin );
    self setplayerangles( s_warp.angles );
}

// Namespace zurich_util
// Params 2
// Checksum 0x3cf3c5d6, Offset: 0x2b60
// Size: 0x115
function function_39af75ef( str_endon, str_exploder )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( str_endon );
    
    if ( !isdefined( str_exploder ) )
    {
        str_exploder = "ex_underwater_lights";
    }
    
    while ( true )
    {
        if ( self isplayerunderwater() && !( isdefined( self.is_underwater ) && self.is_underwater ) )
        {
            self clientfield::set_to_player( "player_water_transition", 1 );
            self.is_underwater = 1;
            exploder::exploder( str_exploder );
            self thread set_world_fog( 1 );
        }
        else if ( isdefined( self.is_underwater ) && !self isplayerunderwater() && self.is_underwater )
        {
            self clientfield::set_to_player( "player_water_transition", 0 );
            self.is_underwater = undefined;
            exploder::kill_exploder( str_exploder );
            self thread set_world_fog( 0 );
        }
        
        wait 0.05;
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0xa0f6d5e0, Offset: 0x2c80
// Size: 0x2aa
function ai_surreal_spawn_fx()
{
    self endon( #"death" );
    n_min_dist = 256;
    
    if ( self should_use_surreal_fx() )
    {
        if ( sessionmodeiscampaignzombiesgame() && self.script_noteworthy === "zombie_spawner" )
        {
            return;
        }
        
        self thread function_8f40ede();
        
        if ( self.script_string === "in_water" )
        {
            if ( math::cointoss() )
            {
                self scene::play( "cin_zur_11_01_paths_aie_water01", self );
            }
            else
            {
                self scene::play( "cin_zur_11_01_paths_aie_water02", self );
            }
        }
        else if ( self.script_string === "in_ground" )
        {
            if ( math::cointoss() )
            {
                self scene::play( "cin_zur_12_01_root_aie_ground01", self );
            }
            else
            {
                self scene::play( "cin_zur_12_01_root_aie_ground02", self );
            }
        }
        else if ( isdefined( self.type ) && self.type == "human" )
        {
            self.holdfire = 1;
            self disableaimassist();
            self ai::set_ignoreme( 1 );
            util::magic_bullet_shield( self );
            self ghost();
            util::wait_network_frame();
            self clientfield::set( "raven_ai_rez", 1 );
            wait 0.5;
            self enableaimassist();
            self ai::set_ignoreme( 0 );
            util::stop_magic_bullet_shield( self );
            self show();
            self.holdfire = 0;
        }
        else
        {
            self.e_anchor = util::spawn_model( "tag_origin", self.origin, self.angles );
            self linkto( self.e_anchor );
            self thread function_c9e8f95a( self.e_anchor );
            self.e_anchor clientfield::set( "vehicle_spawn_fx", 1 );
            wait 0.15;
        }
        
        self notify( #"spawned" );
        
        if ( self.archetype === "robot" )
        {
            self ai::set_behavior_attribute( "robot_lights", 3 );
        }
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0xf8fff54a, Offset: 0x2f38
// Size: 0x26
function function_b2c5d91c()
{
    if ( self.weaponclass === "rocketlauncher" )
    {
        self.accuracy = 0.4;
    }
}

// Namespace zurich_util
// Params 2
// Checksum 0x6ee1b3e7, Offset: 0x2f68
// Size: 0x1c2
function function_c90e23b6( str_objective, str_end )
{
    level.ai_taylor = util::get_hero( "taylor_hero" );
    level.ai_taylor thread function_f5f0fcce( str_objective, str_end );
    
    if ( issubstr( str_objective, "_vortex" ) )
    {
        level.ai_taylor thread function_11726ad( str_objective );
        return;
    }
    
    s_start_pos = function_c30d095( str_objective );
    level.ai_taylor forceteleport( s_start_pos.origin, s_start_pos.angles );
    level.ai_taylor ai::set_ignoreme( 1 );
    level.ai_taylor ai::set_ignoreall( 1 );
    level.ai_taylor ghost();
    wait 0.5;
    level.ai_taylor clientfield::set( "hero_spawn_fx", 1 );
    wait 0.5;
    level.ai_taylor ai::set_ignoreme( 0 );
    level.ai_taylor ai::set_ignoreall( 0 );
    level.ai_taylor show();
    level.ai_taylor thread function_53fd6e96( str_objective );
    level.ai_taylor thread function_f7f909b0( str_objective );
    level.ai_taylor thread function_11726ad( str_objective );
}

// Namespace zurich_util
// Params 1
// Checksum 0xe5889456, Offset: 0x3138
// Size: 0x1e5
function function_53fd6e96( str_objective )
{
    level endon( str_objective + "_done" );
    level endon( #"root_scene_completed" );
    level endon( str_objective + "enter_vortex" );
    level endon( #"hash_8b1e8360" );
    self endon( #"death" );
    
    while ( true )
    {
        e_player = arraygetclosest( self.origin, level.activeplayers );
        
        if ( isdefined( e_player ) )
        {
            self.follow_player = undefined;
            
            while ( isalive( e_player ) )
            {
                nd_cover = self function_843d0ed6( e_player );
                
                if ( self.ignoreall )
                {
                    self.follow_player = undefined;
                }
                else if ( isdefined( nd_cover ) )
                {
                    setenablenode( nd_cover, 1 );
                    self setgoal( nd_cover, 1 );
                    nd_cover function_47f5a8d2( e_player );
                    self.follow_player = undefined;
                }
                else if ( ispointonnavmesh( e_player.origin, self ) )
                {
                    self setgoal( e_player, 0, 256 );
                    self.follow_player = 1;
                }
                else
                {
                    v_pos = getclosestpointonnavmesh( e_player.origin, 256, 64 );
                    
                    if ( isdefined( v_pos ) )
                    {
                        self setgoal( v_pos, 0, 256 );
                    }
                    else
                    {
                        self setgoal( self.origin, 0, 256 );
                        self.follow_player = undefined;
                    }
                }
                
                wait 0.5;
            }
        }
        
        self setgoal( self.origin );
        wait 0.1;
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0xa687cb51, Offset: 0x3328
// Size: 0x131
function function_f7f909b0( str_objective )
{
    level endon( str_objective + "_done" );
    level endon( str_objective + "enter_vortex" );
    
    while ( true )
    {
        e_player = arraygetclosest( self.origin, level.activeplayers );
        
        if ( isdefined( e_player ) && distance( e_player.origin, self.origin ) > 2500 )
        {
            v_pos = e_player.origin + anglestoforward( e_player.angles ) * 256;
            v_teleport = getclosestpointonnavmesh( v_pos, 100, 30 );
            
            if ( isdefined( v_teleport ) )
            {
                self clientfield::set( "hero_spawn_fx", 0 );
                wait 0.5;
                level.ai_taylor forceteleport( v_teleport, e_player.angles );
                self clientfield::set( "hero_spawn_fx", 1 );
            }
        }
        
        wait 3;
    }
}

// Namespace zurich_util
// Params 2
// Checksum 0xf0294327, Offset: 0x3468
// Size: 0x1ba
function function_f5f0fcce( str_objective, str_end )
{
    level endon( #"root_scene_completed" );
    
    if ( issubstr( str_objective, "_start" ) )
    {
        level waittill( str_objective + "enter_vortex" );
    }
    
    if ( isdefined( str_end ) )
    {
        s_end = struct::get( str_end, "targetname" );
    }
    
    if ( issubstr( str_objective, "root_cairo" ) )
    {
        str_teleport = "root_cairo_vortex";
    }
    else if ( issubstr( str_objective, "root_singapore" ) )
    {
        str_teleport = "root_singapore_vortex";
    }
    else
    {
        str_teleport = "root_zurich_vortex";
    }
    
    var_d476a8cc = function_c30d095( str_teleport );
    var_fa33caf9 = util::spawn_model( "tag_origin", var_d476a8cc.origin, var_d476a8cc.angles );
    
    if ( level.activeplayers.size > 1 && isdefined( s_end ) )
    {
        self setgoal( s_end.origin, 0, 64 );
        self util::waittill_any_timeout( 15, "goal" );
        self clientfield::set( "hero_spawn_fx", 0 );
    }
    else
    {
        wait 1;
    }
    
    self forceteleport( var_d476a8cc.origin, var_d476a8cc.angles );
    self clientfield::set( "hero_spawn_fx", 1 );
    self thread function_53fd6e96( str_objective );
}

// Namespace zurich_util
// Params 1
// Checksum 0x83817cb2, Offset: 0x3630
// Size: 0x3a
function function_11726ad( str_objective )
{
    level waittill( #"root_scene_completed" );
    self util::unmake_hero( "taylor_hero" );
    self util::self_delete();
}

// Namespace zurich_util
// Params 1
// Checksum 0xe5e0d858, Offset: 0x3678
// Size: 0xbe
function function_c30d095( str_objective )
{
    switch ( str_objective )
    {
        case "root_zurich_start":
            str_pos = "root_zurich_end_taylor_start";
            break;
        default:
            str_pos = "root_zurich_end_taylor_vortex";
            break;
        case "root_cairo_start":
            str_pos = "root_cairo_end_taylor_start";
            break;
        case "root_cairo_vortex":
            str_pos = "root_cairo_end_taylor_vortex";
            break;
        case "root_singapore_start":
            str_pos = "root_singapore_end_taylor_start";
            break;
        case "root_singapore_vortex":
            str_pos = "root_singapore_end_taylor_vortex";
            break;
    }
    
    s_pos = struct::get( str_pos, "targetname" );
    return s_pos;
}

// Namespace zurich_util
// Params 1
// Checksum 0x83ff1037, Offset: 0x3740
// Size: 0x18c
function function_843d0ed6( e_player )
{
    if ( !isdefined( level.var_6b5304af ) )
    {
        return undefined;
    }
    
    foreach ( nd_cover in level.var_6b5304af )
    {
        setenablenode( nd_cover, 0 );
    }
    
    a_nd_cover = arraysortclosest( level.var_6b5304af, e_player.origin, 8, 90, 512 );
    
    for ( i = 0; i < a_nd_cover.size ; i++ )
    {
        if ( !( a_nd_cover[ i ].script_noteworthy === "ai_taylor_cover" ) )
        {
            arrayremovevalue( a_nd_cover, a_nd_cover[ i ] );
        }
    }
    
    for ( i = 0; i < a_nd_cover.size ; i++ )
    {
        v_player_pos = e_player geteye();
        
        if ( sighttracepassed( v_player_pos, a_nd_cover[ i ].origin + ( 0, 0, 32 ), 0, e_player ) )
        {
            return a_nd_cover[ i ];
        }
    }
    
    for ( i = 0; i < a_nd_cover.size ; i++ )
    {
        return a_nd_cover[ i ];
    }
    
    return undefined;
}

// Namespace zurich_util
// Params 1
// Checksum 0x59ac4f34, Offset: 0x38d8
// Size: 0xea
function function_47f5a8d2( e_player )
{
    level.ai_taylor endon( #"death" );
    e_player endon( #"disconnect" );
    e_player endon( #"death" );
    n_timepassed = 0;
    n_starttime = gettime();
    
    while ( distance( e_player.origin, self.origin ) < 256 && distance( e_player.origin, self.origin ) > 64 && isalive( e_player ) && n_timepassed < 15 )
    {
        wait 1;
        n_timepassed = ( gettime() - n_starttime ) / 1000;
    }
    
    level.ai_taylor clearforcedgoal();
}

// Namespace zurich_util
// Params 0
// Checksum 0xb6e956c3, Offset: 0x39d0
// Size: 0x131
function function_d93e481f()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level.ai_taylor endon( #"death" );
    self.var_df6d1c12 = self.origin;
    
    while ( true )
    {
        if ( distance( self.origin, self.var_df6d1c12 ) < 16 )
        {
            var_c37d2cb3 = level.ai_taylor geteye();
            
            if ( self util::is_player_looking_at( var_c37d2cb3, 0.8, 1, self ) && !( isdefined( level.var_aec67b62 ) && level.var_aec67b62 ) )
            {
                level.var_aec67b62 = 1;
                
                if ( !level.ai_taylor scene::is_playing() )
                {
                    level.ai_taylor thread scene::play( "cin_gen_ambient_idle_nag", level.ai_taylor );
                }
                
                level.ai_taylor thread function_15d5331f();
            }
        }
        
        self.var_df6d1c12 = self.origin;
        wait 5;
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x345c4224, Offset: 0x3b10
// Size: 0x15
function function_15d5331f()
{
    wait 30;
    level.var_aec67b62 = undefined;
}

// Namespace zurich_util
// Params 0
// Checksum 0xaa62a0ae, Offset: 0x3b30
// Size: 0x1a2
function function_dc8f9fa6()
{
    if ( !self should_use_surreal_fx() )
    {
        if ( self.archetype === "human" && !self util::is_hero() )
        {
            var_72875649 = 0;
            
            if ( isdefined( self.script_int ) )
            {
                var_72875649 = self.script_int;
            }
            
            self.grenadeammo = var_72875649;
        }
        
        if ( self.archetype === "robot" )
        {
            str_level = "forced_level_1";
            
            if ( self.script_noteworthy === "forced_level_2" || self.script_noteworthy === "forced_level_3" )
            {
                str_level = self.script_noteworthy;
                
                if ( self.script_noteworthy === "forced_level_3" )
                {
                    self ai::set_behavior_attribute( "rogue_control_speed", "run" );
                }
            }
            
            self ai::set_behavior_attribute( "rogue_control", str_level );
            self.team = "axis";
            self util::set_rogue_controlled();
            
            if ( self.script_noteworthy === "has_mini_raps" || self.script_string === "has_mini_raps" )
            {
                self ai::set_behavior_attribute( "robot_mini_raps", 1 );
            }
            
            return;
        }
        
        if ( isvehicle( self ) )
        {
            self util::set_rogue_controlled();
            self.team = "axis";
        }
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0xbb34d72f, Offset: 0x3ce0
// Size: 0x52
function ai_death_explosions( params )
{
    if ( self should_use_surreal_fx() )
    {
        if ( isvehicle( self ) )
        {
            return;
        }
        
        self thread explode_when_actor_becomes_corpse();
        self thread explode_on_ragdoll_start();
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0xef1075ad, Offset: 0x3d40
// Size: 0x26, Type: bool
function should_use_surreal_fx()
{
    return surreal_fx_enabled() && self.team != "allies";
}

// Namespace zurich_util
// Params 0
// Checksum 0x7396e394, Offset: 0x3d70
// Size: 0x1d
function surreal_fx_enabled()
{
    if ( !isdefined( level.surreal_fx ) )
    {
        level.surreal_fx = 0;
    }
    
    return level.surreal_fx;
}

// Namespace zurich_util
// Params 2
// Checksum 0xd9481c3e, Offset: 0x3d98
// Size: 0x3a
function enable_surreal_ai_fx( b_enabled, n_delay_time )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    if ( !isdefined( n_delay_time ) )
    {
        n_delay_time = 0;
    }
    
    level.surreal_fx = b_enabled;
    level.exploding_deaths_delay_time = n_delay_time;
}

// Namespace zurich_util
// Params 0
// Checksum 0x862a76b5, Offset: 0x3de0
// Size: 0xa3
function explode_on_ragdoll_start()
{
    self endon( #"ai_explosion_death" );
    self waittill( #"start_ragdoll" );
    
    if ( isdefined( self ) )
    {
        self clientfield::set( "raven_ai_rez", 0 );
    }
    
    death_explode_delay();
    
    if ( isdefined( self ) )
    {
        self ghost();
        self clientfield::set( "exploding_ai_deaths", 1 );
    }
    
    util::wait_network_frame();
    
    if ( isdefined( self ) )
    {
        self delete();
        self notify( #"ai_explosion_death" );
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0xefe1704c, Offset: 0x3e90
// Size: 0x7f
function explode_when_actor_becomes_corpse()
{
    self endon( #"ai_explosion_death" );
    self waittill( #"actor_corpse", e_corpse );
    death_explode_delay();
    
    if ( isdefined( e_corpse ) )
    {
        e_corpse clientfield::set( "exploding_ai_deaths", 1 );
    }
    
    util::wait_network_frame();
    
    if ( isdefined( e_corpse ) )
    {
        e_corpse delete();
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"ai_explosion_death" );
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x66eec41, Offset: 0x3f18
// Size: 0x16
function death_explode_delay()
{
    if ( isdefined( level.exploding_deaths_delay_time ) )
    {
        wait level.exploding_deaths_delay_time;
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x959c0598, Offset: 0x3f38
// Size: 0x3b5
function function_b1d28dc8()
{
    self endon( #"death" );
    self waittill( #"spawned" );
    
    if ( isdefined( self.type ) && self.type == "human" )
    {
        while ( true )
        {
            self ai::disable_pain();
            self waittill( #"damage" );
            
            if ( self.var_5e7a3967 === 1 && ( randomint( 10 ) > 2 || !( isdefined( self.var_de36196f ) && self.var_de36196f ) ) )
            {
                if ( self isatcovernodestrict() )
                {
                    var_dd98891d = self.node.type;
                }
                
                if ( var_dd98891d === "Cover Right" || var_dd98891d === "Cover Left" )
                {
                    var_c9111550 = self.origin + anglestoforward( self.angles ) * -76;
                    var_f473fe28 = self function_c550e7be( var_c9111550 );
                    var_e45d5caa = self.origin + anglestoforward( self.angles ) * -1 * -76;
                    var_667b6d63 = self function_c550e7be( var_e45d5caa );
                }
                else
                {
                    v_pos_right = self.origin + anglestoright( self.angles ) * -76;
                    var_f473fe28 = self function_c550e7be( v_pos_right );
                    v_pos_left = self.origin + anglestoright( self.angles ) * -1 * -76;
                    var_667b6d63 = self function_c550e7be( v_pos_left );
                }
                
                if ( math::cointoss() )
                {
                    var_d3fd0a78 = var_f473fe28;
                    var_460479b3 = var_667b6d63;
                }
                else
                {
                    var_d3fd0a78 = var_667b6d63;
                    var_460479b3 = var_f473fe28;
                }
                
                if ( isdefined( var_d3fd0a78 ) )
                {
                    if ( isdefined( self.attacker ) )
                    {
                        if ( self.attacker.classname != "worldspawn" && self.attacker.classname != "trigger_radius_hurt" )
                        {
                            if ( sighttracepassed( self.attacker geteye(), var_d3fd0a78 + ( 0, 0, 72 ), 0, self.attacker ) )
                            {
                                self function_f5b7f741( var_d3fd0a78 );
                            }
                        }
                    }
                }
                else if ( isdefined( var_460479b3 ) )
                {
                    if ( isdefined( self.attacker ) )
                    {
                        if ( self.attacker.classname != "worldspawn" && self.attacker.classname != "trigger_radius_hurt" )
                        {
                            if ( sighttracepassed( self.attacker geteye(), var_460479b3 + ( 0, 0, 72 ), 0, self.attacker ) )
                            {
                                self function_f5b7f741( var_460479b3 );
                            }
                        }
                    }
                }
                else if ( isdefined( var_d3fd0a78 ) )
                {
                    self function_f5b7f741( var_d3fd0a78 );
                }
                else if ( isdefined( var_460479b3 ) )
                {
                    self function_f5b7f741( var_460479b3 );
                }
            }
            
            self ai::enable_pain();
            wait randomintrange( 5, 10 );
        }
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0xd2dfdb3a, Offset: 0x42f8
// Size: 0xe9
function function_c550e7be( v_juke_pos )
{
    v_juke_pos = getclosestpointonnavmesh( v_juke_pos, -128, 32 );
    
    if ( !isdefined( v_juke_pos ) || distance( self.origin, v_juke_pos ) < 50 )
    {
        return undefined;
    }
    
    foreach ( e_player in level.activeplayers )
    {
        if ( distance( e_player.origin, v_juke_pos ) < -128 )
        {
            return undefined;
        }
    }
    
    if ( !positionwouldtelefrag( v_juke_pos ) && !self isposinclaimedlocation( v_juke_pos ) )
    {
        return v_juke_pos;
    }
    
    return undefined;
}

// Namespace zurich_util
// Params 1
// Checksum 0xb9ab2ed4, Offset: 0x43f0
// Size: 0x2f2
function function_f5b7f741( v_juke_pos )
{
    self endon( #"hash_a30f8b" );
    
    if ( isdefined( v_juke_pos ) )
    {
        n_distance = distance( self.origin, v_juke_pos );
        n_time = n_distance / 400;
        self thread function_8f40ede();
        self clientfield::increment( "raven_juke_limb_effect" );
        self.holdfire = 1;
        self disableaimassist();
        self ai::set_ignoreme( 1 );
        util::magic_bullet_shield( self );
        self ghost();
        var_fb20f2e1 = self.angles;
        var_4fa09666 = vectortoangles( v_juke_pos - self.origin );
        self.e_anchor = util::spawn_model( "tag_origin", self gettagorigin( "J_Spine4" ), var_4fa09666 );
        wait 0.05;
        self.e_anchor clientfield::increment( "raven_juke_effect" );
        self linkto( self.e_anchor );
        self thread function_c9e8f95a( self.e_anchor );
        self.e_anchor moveto( v_juke_pos + ( 0, 0, 25 ), n_time );
        self.e_anchor waittill( #"movedone" );
        self unlink();
        self forceteleport( v_juke_pos, var_fb20f2e1, 1, 0 );
        self setgoalpos( v_juke_pos, 1 );
        self.e_anchor moveto( self gettagorigin( "J_Spine4" ), 0.05 );
        self.e_anchor clientfield::increment( "raven_teleport_in_effect" );
        wait 1.4;
        self forceteleport( v_juke_pos, var_fb20f2e1, 1, 0 );
        self setgoalpos( v_juke_pos, 1 );
        self enableaimassist();
        self ai::set_ignoreme( 0 );
        util::stop_magic_bullet_shield( self );
        self show();
        self.holdfire = 0;
        self notify( #"teleport_done" );
        wait 2;
        self clearforcedgoal();
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0xfc9b1f8e, Offset: 0x46f0
// Size: 0x29
function function_8f40ede()
{
    self endon( #"death" );
    self.var_de36196f = 1;
    wait 6;
    self.var_de36196f = undefined;
}

// Namespace zurich_util
// Params 0
// Checksum 0x881fd3b6, Offset: 0x4728
// Size: 0x1c1
function function_90de3a76()
{
    self endon( #"death" );
    self waittill( #"spawned" );
    wait 1;
    
    if ( isdefined( self.type ) && self.type == "human" )
    {
        if ( !isdefined( self.var_48772f67 ) || !self.var_48772f67 )
        {
            var_8fb5e5da = undefined;
            n_move_time = 3;
            
            while ( true )
            {
                self waittill( #"new_cover" );
                
                for ( nd_cover = self.node; !isdefined( nd_cover ) ; nd_cover = self.node )
                {
                    wait 1.5;
                }
                
                b_close = undefined;
                
                foreach ( e_player in level.activeplayers )
                {
                    if ( distance( e_player.origin, nd_cover.origin ) < -128 )
                    {
                        b_close = 1;
                    }
                }
                
                if ( distance( self.origin, nd_cover.origin ) < -128 )
                {
                    b_close = 1;
                }
                
                if ( randomint( 10 ) > 4 && nd_cover !== var_8fb5e5da && !( isdefined( self.var_de36196f ) && self.var_de36196f ) && !( isdefined( b_close ) && b_close ) )
                {
                    var_8fb5e5da = nd_cover;
                    self thread function_bfc7e6a6( nd_cover.origin );
                }
                
                wait 2;
            }
        }
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0x4a87b3, Offset: 0x48f8
// Size: 0x352
function function_bfc7e6a6( v_pos )
{
    self endon( #"death" );
    n_distance = distance( self.origin, v_pos );
    n_time = n_distance / 400;
    self thread function_8f40ede();
    
    if ( n_time > 0.6 )
    {
        self clientfield::increment( "raven_teleport_limb_effect" );
        n_time = 1;
    }
    else
    {
        self clientfield::increment( "raven_juke_limb_effect" );
        n_time = 0.45;
    }
    
    self.holdfire = 1;
    self disableaimassist();
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    util::magic_bullet_shield( self );
    self ghost();
    var_fb20f2e1 = self.angles;
    var_f8a383f8 = vectortoangles( v_pos - self.origin );
    self.e_anchor = util::spawn_model( "tag_origin", self gettagorigin( "J_Spine4" ), var_f8a383f8 );
    wait 0.05;
    
    if ( n_time == 1 )
    {
        self.e_anchor clientfield::increment( "raven_teleport_effect" );
    }
    else
    {
        self.e_anchor clientfield::increment( "raven_juke_effect" );
    }
    
    self linkto( self.e_anchor );
    self thread function_c9e8f95a( self.e_anchor );
    self.e_anchor moveto( v_pos + ( 0, 0, 25 ), n_time );
    self.e_anchor waittill( #"movedone" );
    self unlink();
    self forceteleport( v_pos, var_fb20f2e1, 0, 0 );
    self setgoalpos( v_pos, 1 );
    self.e_anchor moveto( self gettagorigin( "J_Spine4" ), 0.05 );
    self.e_anchor clientfield::increment( "raven_teleport_in_effect" );
    wait 1.4;
    self forceteleport( v_pos, var_fb20f2e1, 0, 0 );
    self enableaimassist();
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    util::stop_magic_bullet_shield( self );
    self show();
    self.holdfire = 0;
    self notify( #"teleport_done" );
    wait 2;
    self clearforcedgoal();
}

// Namespace zurich_util
// Params 1
// Checksum 0x739c8690, Offset: 0x4c58
// Size: 0x6a
function function_c9e8f95a( e_anchor )
{
    self util::waittill_any( "death", "teleport_done", "spawned" );
    
    if ( isalive( self ) )
    {
        self unlink();
    }
    
    wait 3;
    
    if ( isdefined( e_anchor ) )
    {
        e_anchor delete();
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x4e34234e, Offset: 0x4cd0
// Size: 0x3ab
function raven_spawn_teleport()
{
    self endon( #"death" );
    
    if ( isdefined( self.target ) && self.script_parameters === "raven_spawn_teleport" )
    {
        var_f5cd6771 = getnode( self.target, "targetname" );
        
        if ( !isdefined( var_f5cd6771 ) )
        {
            var_f5cd6771 = struct::get( self.target, "targetname" );
        }
        
        if ( !isdefined( var_f5cd6771 ) )
        {
            return;
        }
        
        self waittill( #"spawned" );
        wait 0.5;
        n_distance = distance( self.origin, var_f5cd6771.origin );
        n_move_time = n_distance / 400;
        
        if ( n_move_time > 0.6 )
        {
            self clientfield::increment( "raven_teleport_limb_effect" );
            n_move_time = 1;
        }
        else
        {
            self clientfield::increment( "raven_juke_limb_effect" );
            n_move_time = 0.45;
        }
        
        self ghost();
        self ai::set_ignoreall( 1 );
        self ai::set_ignoreme( 1 );
        util::magic_bullet_shield( self );
        self disableaimassist();
        var_fb20f2e1 = self.angles;
        var_4fa09666 = vectortoangles( var_f5cd6771.origin - self.origin );
        self.e_anchor = util::spawn_model( "tag_origin", self gettagorigin( "J_Spine4" ), var_4fa09666 );
        util::wait_network_frame();
        
        if ( n_move_time == 1 )
        {
            self.e_anchor clientfield::increment( "raven_teleport_effect" );
        }
        else
        {
            self.e_anchor clientfield::increment( "raven_juke_effect" );
        }
        
        self linkto( self.e_anchor );
        self thread function_c9e8f95a( self.e_anchor );
        self.e_anchor moveto( var_f5cd6771.origin + ( 0, 0, 25 ), n_move_time );
        self.e_anchor waittill( #"movedone" );
        self unlink();
        self forceteleport( var_f5cd6771.origin, var_fb20f2e1, 1, 0 );
        self setgoalpos( var_f5cd6771.origin, 1 );
        self.e_anchor moveto( self gettagorigin( "J_Spine4" ), 0.05 );
        self.e_anchor clientfield::increment( "raven_teleport_in_effect" );
        wait 1.4;
        self ai::set_ignoreall( 0 );
        self ai::set_ignoreme( 0 );
        util::stop_magic_bullet_shield( self );
        self enableaimassist();
        self show();
        self notify( #"teleport_done" );
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0x852b6ddb, Offset: 0x5088
// Size: 0x323
function function_ff6b67ed( target )
{
    self endon( #"death" );
    n_distance = distance( self.origin, target.origin );
    n_move_time = n_distance / 400;
    
    if ( n_move_time > 0.6 )
    {
        self clientfield::increment( "raven_teleport_limb_effect" );
        n_move_time = 1;
    }
    else
    {
        self clientfield::increment( "raven_juke_limb_effect" );
        n_move_time = 0.45;
    }
    
    self ghost();
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    util::magic_bullet_shield( self );
    self disableaimassist();
    var_fb20f2e1 = self.angles;
    var_4fa09666 = vectortoangles( target.origin - self.origin );
    self.e_anchor = util::spawn_model( "tag_origin", self gettagorigin( "J_Spine4" ), var_4fa09666 );
    wait 0.05;
    
    if ( n_move_time == 1 )
    {
        self.e_anchor clientfield::increment( "raven_teleport_effect" );
    }
    else
    {
        self.e_anchor clientfield::increment( "raven_juke_effect" );
    }
    
    self linkto( self.e_anchor );
    self thread function_c9e8f95a( self.e_anchor );
    self.e_anchor moveto( target.origin + ( 0, 0, 25 ), n_move_time );
    self.e_anchor waittill( #"movedone" );
    self unlink();
    self forceteleport( target.origin, var_fb20f2e1, 1, 0 );
    self setgoalpos( target.origin, 1 );
    self.e_anchor moveto( self gettagorigin( "J_Spine4" ), 0.05 );
    self.e_anchor clientfield::increment( "raven_teleport_in_effect" );
    wait 1.4;
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    util::stop_magic_bullet_shield( self );
    self enableaimassist();
    self show();
    self notify( #"teleport_done" );
}

// Namespace zurich_util
// Params 1
// Checksum 0x1df78814, Offset: 0x53b8
// Size: 0x99
function function_d8c91e6b( n_dist )
{
    self endon( #"death" );
    
    if ( !isdefined( n_dist ) )
    {
        n_dist = 4000;
    }
    
    while ( true )
    {
        if ( !( isdefined( self player_can_see_me( n_dist ) ) && self player_can_see_me( n_dist ) ) )
        {
            if ( isalive( self ) && !self util::is_hero() )
            {
                self util::stop_magic_bullet_shield();
                self kill();
            }
        }
        
        wait 5;
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x421e4abd, Offset: 0x5460
// Size: 0x52
function delete_all_ai()
{
    a_ai = getaiteamarray( "axis", "allies", "team3" );
    array::spread_all( a_ai, &function_914c331d );
}

// Namespace zurich_util
// Params 0
// Checksum 0x1a60a36d, Offset: 0x54c0
// Size: 0x42
function function_914c331d()
{
    if ( isalive( self ) && !self util::is_hero() )
    {
        self util::stop_magic_bullet_shield();
        self delete();
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0xee072cad, Offset: 0x5510
// Size: 0x42
function function_48463818()
{
    if ( isalive( self ) && !self util::is_hero() )
    {
        self util::stop_magic_bullet_shield();
        self kill();
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x50f4109c, Offset: 0x5560
// Size: 0x101
function function_289902e8()
{
    self endon( #"death" );
    self waittill( #"spawned" );
    self thread function_d8c91e6b( 4000 );
    
    while ( true )
    {
        e_player = arraygetclosest( self.origin, level.activeplayers );
        
        if ( isdefined( e_player ) && distance( e_player.origin, self.origin ) > 2000 )
        {
            v_pos = e_player.origin + anglestoforward( e_player.angles ) * 512;
            v_teleport = getclosestpointonnavmesh( v_pos, 100, 30 );
            
            if ( isdefined( v_teleport ) )
            {
                self thread function_bfc7e6a6( v_teleport );
            }
        }
        
        wait 5;
    }
}

// Namespace zurich_util
// Params 13
// Checksum 0xc7502199, Offset: 0x5670
// Size: 0x106
function function_8ac3f026( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname )
{
    if ( isai( eattacker ) )
    {
        if ( self.team == "axis" && ( self.team == "allies" && eattacker.team == "axis" || eattacker.team == "allies" ) )
        {
            n_scale = get_num_scaled_by_player_count( 5, -1 );
            idamage = int( idamage * n_scale );
        }
    }
    
    return idamage;
}

// Namespace zurich_util
// Params 1
// Checksum 0xb3736f12, Offset: 0x5780
// Size: 0xe8, Type: bool
function player_can_see_me( n_dist )
{
    if ( !isdefined( n_dist ) )
    {
        n_dist = 512;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        v_player_pos = level.players[ i ] geteye();
        
        if ( sighttracepassed( v_player_pos, self.origin + ( 0, 0, 32 ), 0, level.players[ i ] ) )
        {
            return true;
        }
        
        var_b08b4a3b = distance2dsquared( self.origin, level.players[ i ] geteye() );
        n_dist_sq = n_dist * n_dist;
        
        if ( var_b08b4a3b < n_dist_sq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zurich_util
// Params 1
// Checksum 0x8dfbd01c, Offset: 0x5870
// Size: 0x1e2
function function_2361541e( str_location )
{
    switch ( str_location )
    {
        default:
            level thread function_8d10b109();
            break;
        case "rails":
            level thread function_c27f6351();
            break;
    }
    
    var_cf560aad = struct::get_array( str_location + "_oneshot_bodies", "targetname" );
    
    if ( var_cf560aad.size )
    {
        foreach ( s_oneshot in var_cf560aad )
        {
            a_e_civs = getentarray( "zurich_ambient_civ", "targetname" );
            e_civ = array::random( a_e_civs );
            ai_civ = spawner::simple_spawn_single( e_civ );
            ai_civ ai::set_ignoreme( 1 );
            ai_civ forceteleport( s_oneshot.origin, s_oneshot.angles );
            ai_civ thread scene::init( s_oneshot.scriptbundlename, ai_civ );
        }
    }
    
    var_f201bfb1 = struct::get_array( str_location + "_dead_bodies", "targetname" );
    
    if ( !var_f201bfb1.size )
    {
        return;
    }
    
    level thread scene::play( str_location + "_dead_bodies", "targetname" );
    level waittill( str_location + "_ambient_cleanup" );
    level scene::stop( str_location + "_dead_bodies", "targetname", 1 );
}

// Namespace zurich_util
// Params 2
// Checksum 0xb4742ef3, Offset: 0x5a60
// Size: 0x72
function function_1eb6ea27( trigger, str_location )
{
    var_f201bfb1 = struct::get_array( str_location + "_dead_bodies", "targetname" );
    
    if ( !var_f201bfb1.size )
    {
        return;
    }
    
    trigger::wait_till( trigger );
    level scene::stop( str_location + "_dead_bodies", "targetname", 1 );
}

// Namespace zurich_util
// Params 0
// Checksum 0x4a0104ef, Offset: 0x5ae0
// Size: 0x9a
function function_8d10b109()
{
    level.var_71aac273 = 0;
    scene::add_scene_func( "cin_zur_vign_conversation", &function_6a0676d9, "play" );
    scene::add_scene_func( "cin_zur_vign_seizure_soldier", &function_6a0676d9, "play" );
    scene::add_scene_func( "cin_zur_m_floor_stomach_wounded_zsf", &function_6a0676d9, "play" );
}

// Namespace zurich_util
// Params 1
// Checksum 0x94ac59a6, Offset: 0x5b88
// Size: 0xa3
function function_6a0676d9( a_ents )
{
    foreach ( e_ent in a_ents )
    {
        e_ent setcandamage( 1 );
        e_ent.health = 100000;
        e_ent thread function_16f4964d();
        e_ent thread util::auto_delete( 16, 0, 1000 );
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0xb8191ce5, Offset: 0x5c38
// Size: 0x81
function function_16f4964d()
{
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"damage", n_damage, e_attacker );
        
        if ( isplayer( e_attacker ) )
        {
            level.var_71aac273++;
        }
        
        if ( level.var_71aac273 >= 4 )
        {
            level.var_71aac273 = 0;
            util::missionfailedwrapper_nodeath( &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN" );
        }
        
        wait 1;
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x359ddfec, Offset: 0x5cc8
// Size: 0x82
function function_c27f6351()
{
    scene::add_scene_func( "p7_fxanim_cp_zurich_train_seats_bundle", &function_9f90bc0f, "play", "rails_ambient_cleanup" );
    level scene::init( "p7_fxanim_cp_zurich_train_seats_bundle" );
    trigger::wait_till( "t_enter_train" );
    level thread scene::play( "p7_fxanim_cp_zurich_train_seats_bundle" );
}

// Namespace zurich_util
// Params 0
// Checksum 0xad0d376, Offset: 0x5d58
// Size: 0x4a
function t_skipto_init()
{
    t_skiptos = getentarray( "zurich_skipto", "targetname" );
    array::thread_all( t_skiptos, &t_skipto );
}

// Namespace zurich_util
// Params 0
// Checksum 0x32ac1373, Offset: 0x5db0
// Size: 0x6d
function t_skipto()
{
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            str_objective = self.script_objective;
            
            if ( !isdefined( str_objective ) )
            {
                str_objective = "zurich";
            }
            
            level notify( str_objective + "_done" );
            skipto::objective_completed( str_objective );
        }
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0x7830c8c8, Offset: 0x5e28
// Size: 0xa5
function function_a1851f86( str_objective )
{
    var_e061e0f4 = getentarray( "root_end_skipto", "targetname" );
    
    foreach ( var_8fb0849a in var_e061e0f4 )
    {
        if ( var_8fb0849a.script_string === str_objective )
        {
            var_8fb0849a thread function_3da5d43b( str_objective );
            return var_8fb0849a;
        }
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0xb5ae900e, Offset: 0x5ed8
// Size: 0xca
function function_3da5d43b( str_objective )
{
    if ( !isdefined( str_objective ) )
    {
        assert( isdefined( str_objective ), "<dev string:x5e>" );
    }
    
    mdl_heart = getent( self.target, "targetname" );
    level thread function_8bd6820f( str_objective );
    self thread function_61f7fc15();
    self.var_afacae68 = 0;
    self function_17b739e2( mdl_heart );
    level notify( str_objective + "_done" );
    wait 1;
    self delete();
    mdl_heart delete();
}

// Namespace zurich_util
// Params 1
// Checksum 0x821e3881, Offset: 0x5fb0
// Size: 0xba
function function_8bd6820f( str_objective )
{
    switch ( str_objective )
    {
        default:
            var_9e7910c3 = "zurich_fxanim_heart";
            break;
        case "root_cairo_vortex":
            var_9e7910c3 = "cairo_fxanim_heart";
            break;
        case "root_singapore_vortex":
            var_9e7910c3 = "singapore_fxanim_heart";
            break;
    }
    
    level thread scene::play( var_9e7910c3, "targetname" );
    level waittill( str_objective + "_done" );
    level thread scene::stop( var_9e7910c3, "targetname" );
    playsoundatposition( "evt_heart_burn", ( 0, 0, 0 ) );
}

// Namespace zurich_util
// Params 1
// Checksum 0x92543272, Offset: 0x6078
// Size: 0x33
function function_17b739e2( mdl_heart )
{
    self function_30a6b901( 1, mdl_heart );
    self.var_afacae68 = 1;
    self notify( #"brn" );
}

// Namespace zurich_util
// Params 0
// Checksum 0xf07db820, Offset: 0x60b8
// Size: 0x22
function function_61f7fc15()
{
    self waittill( #"brn" );
    level util::clientnotify( "stp_mus" );
}

// Namespace zurich_util
// Params 3
// Checksum 0xd5cdeb2, Offset: 0x60e8
// Size: 0xcd
function function_dd842585( str_objective, var_ed1d0e16, str_trig )
{
    level endon( str_objective + "_done" );
    level endon( var_ed1d0e16 + "_done" );
    var_50f524fe = getent( str_trig, "targetname" );
    
    while ( true )
    {
        var_50f524fe waittill( #"trigger", who );
        
        if ( isplayer( who ) && !( isdefined( who.teleporting ) && who.teleporting ) )
        {
            who thread function_c51939f4( str_objective, var_ed1d0e16 );
            who player_weather( 0 );
        }
        
        wait 0.25;
    }
}

// Namespace zurich_util
// Params 2
// Checksum 0x1314bd46, Offset: 0x61c0
// Size: 0x163
function function_c51939f4( str_objective, var_ed1d0e16 )
{
    level notify( str_objective + "enter_vortex" );
    str_shader = "black";
    self playrumbleonentity( "damage_heavy" );
    self.teleporting = 1;
    self enableinvulnerability();
    self thread hud::fade_to_black_for_x_sec( 0, 2, 0.5, 1, str_shader );
    self playsoundtoplayer( "evt_teleport", self );
    wait 0 + 2;
    a_s_spots = skipto::get_spots( var_ed1d0e16, 0 );
    s_spot = array::random( a_s_spots );
    self setorigin( s_spot.origin );
    self setplayerangles( s_spot.angles );
    wait 0.5;
    self.teleporting = undefined;
    self disableinvulnerability();
    self clientfield::increment_to_player( "vortex_teleport" );
    self notify( #"hash_a71a53c4" );
}

// Namespace zurich_util
// Params 3
// Checksum 0x41d75d4e, Offset: 0x6330
// Size: 0x5a
function function_a03f30f2( str_objective, var_ed1d0e16, str_trig )
{
    trigger::wait_till( str_trig );
    level flag::set( var_ed1d0e16 );
    level notify( str_objective + "_done" );
    level player_weather( 0 );
}

// Namespace zurich_util
// Params 2
// Checksum 0xb5e04365, Offset: 0x6398
// Size: 0x1bb
function function_30a6b901( var_929e1778, var_de2c41d4 )
{
    if ( isdefined( self.target ) )
    {
        var_5e4d2a14 = struct::get_array( self.target, "targetname" );
        
        if ( var_5e4d2a14.size )
        {
            for ( i = 0; i < var_5e4d2a14.size ; i++ )
            {
                if ( var_5e4d2a14[ i ].script_noteworthy === "burn_pos" )
                {
                    self.burn_pos = var_5e4d2a14[ i ];
                }
            }
        }
    }
    
    if ( var_929e1778 )
    {
        str_obj = &"cp_level_zurich_burn_heart";
    }
    else
    {
        str_obj = &"cp_level_zurich_burn_vines";
    }
    
    self.var_90971f20 = util::init_interactive_gameobject( self, str_obj, &"CP_MI_ZURICH_COALESCENCE_BURN", &function_64158e74 );
    self triggerenable( 1 );
    level waittill( #"hash_914d02c2" );
    self notify( #"hash_3600bf2b" );
    e_player = self.var_90971f20.e_player;
    self.var_90971f20 gameobjects::disable_object();
    
    if ( isdefined( e_player ) )
    {
        e_player thread function_4a447e94();
        e_pos = e_player;
        
        if ( !var_929e1778 )
        {
            if ( isdefined( self.burn_pos ) )
            {
                e_pos = self.burn_pos;
            }
            
            e_pos scene::play( "p_zur_burn_vines_bundle", e_player );
        }
        
        if ( isdefined( self.target ) )
        {
            util::teleport_players_igc( self.target );
        }
    }
    
    level notify( #"hash_87560491" );
}

// Namespace zurich_util
// Params 1
// Checksum 0x6f330bfb, Offset: 0x6560
// Size: 0x1b
function function_64158e74( e_player )
{
    self.e_player = e_player;
    level notify( #"hash_914d02c2" );
}

// Namespace zurich_util
// Params 0
// Checksum 0x56162df9, Offset: 0x6588
// Size: 0x1a
function function_4a447e94()
{
    wait 1;
    self cybercom::cybercom_armpulse( 1 );
}

// Namespace zurich_util
// Params 2
// Checksum 0x585f8219, Offset: 0x65b0
// Size: 0x5a
function function_cdd5119b( e_attacker, v_impact_point )
{
    var_19fd2f7 = vectortoangles( e_attacker.origin - v_impact_point );
    self fx::play( "corvus_blood", v_impact_point, var_19fd2f7 );
}

// Namespace zurich_util
// Params 0
// Checksum 0x5b497b2d, Offset: 0x6618
// Size: 0x4a
function function_91d852fa()
{
    var_2cfeb5a9 = getentarray( "zurich_vinewalls", "targetname" );
    array::thread_all( var_2cfeb5a9, &function_ff5e6201 );
}

// Namespace zurich_util
// Params 1
// Checksum 0x41c56449, Offset: 0x6670
// Size: 0x162
function function_ff5e6201( var_8d6d1339 )
{
    if ( isdefined( self.script_string ) )
    {
        var_8d6d1339 = self.script_string;
    }
    
    a_e_parts = getentarray( self.target, "targetname" );
    
    for ( i = 0; i < a_e_parts.size ; i++ )
    {
        if ( a_e_parts[ i ].script_noteworthy === "vinewall_clip" )
        {
            var_9d50b546 = a_e_parts[ i ];
            continue;
        }
        
        if ( a_e_parts[ i ].script_noteworthy === "vinewall_vine" )
        {
            var_ecf05dd0 = a_e_parts[ i ];
        }
    }
    
    if ( isdefined( self.script_flag_true ) )
    {
        level flag::wait_till( self.script_flag_true );
    }
    else if ( isdefined( var_8d6d1339 ) )
    {
        self setinvisibletoall();
        level waittill( var_8d6d1339 );
        self setvisibletoall();
    }
    
    self function_30a6b901( 0, var_ecf05dd0 );
    var_9d50b546 notsolid();
    var_9d50b546 connectpaths();
    var_ecf05dd0 delete();
    wait 0.1;
    var_9d50b546 delete();
}

// Namespace zurich_util
// Params 1
// Checksum 0xc66622f6, Offset: 0x67e0
// Size: 0x22
function set_world_fog( bank )
{
    self clientfield::set_to_player( "set_world_fog", bank );
}

// Namespace zurich_util
// Params 2
// Checksum 0x8d05508b, Offset: 0x6810
// Size: 0x7b
function get_num_scaled_by_player_count( n_base, n_add_per_player )
{
    n_num = n_base - n_add_per_player;
    
    foreach ( e_player in level.players )
    {
        n_num += n_add_per_player;
    }
    
    return n_num;
}

// Namespace zurich_util
// Params 7
// Checksum 0xed1c3659, Offset: 0x6898
// Size: 0x12a
function spawn_phalanx( str_phalanx, str_formation, n_remaining_to_disperse, b_scatter, n_timeout_scatter, var_6f456ea4, var_42e6f5b4 )
{
    if ( !isdefined( b_scatter ) )
    {
        b_scatter = 0;
    }
    
    if ( !isdefined( n_timeout_scatter ) )
    {
        n_timeout_scatter = 0;
    }
    
    s_start = struct::get( str_phalanx + "_start" );
    s_end = struct::get( s_start.target );
    o_phalanx = new robotphalanx();
    [[ o_phalanx ]]->initialize( str_formation, s_start.origin, s_end.origin, n_remaining_to_disperse, var_42e6f5b4 );
    wait n_timeout_scatter;
    
    if ( isdefined( var_6f456ea4 ) && level flag::exists( var_6f456ea4 ) )
    {
        level flag::wait_till( var_6f456ea4 );
    }
    
    if ( b_scatter && o_phalanx.scattered_ == 0 )
    {
        o_phalanx thread robotphalanx::scatterphalanx();
    }
}

// Namespace zurich_util
// Params 2
// Checksum 0x8b8f12fe, Offset: 0x69d0
// Size: 0x6a
function init_kane( str_objective, var_d44e356e )
{
    level.ai_kane = util::get_hero( "kane" );
    
    if ( var_d44e356e )
    {
        level.ai_kane thread function_fe5160df( 1 );
    }
    
    skipto::teleport_ai( str_objective, level.heroes );
}

// Namespace zurich_util
// Params 2
// Checksum 0x6aa94212, Offset: 0x6a48
// Size: 0x2c5
function function_d0103e8d( var_95fca89b, var_62320a5b )
{
    if ( !isdefined( var_95fca89b ) )
    {
        var_95fca89b = 395;
    }
    
    if ( !isdefined( var_62320a5b ) )
    {
        var_62320a5b = 0.7;
    }
    
    self notify( #"hash_2f673cce" );
    self endon( #"hash_2f673cce" );
    
    while ( true )
    {
        a_players = arraycopy( level.activeplayers );
        array::randomize( a_players );
        a_enemies = getaiteamarray( "axis", "team3" );
        a_enemies = arraysort( a_enemies, self.origin, 0 );
        
        foreach ( player in a_players )
        {
            for ( i = 0; i < a_enemies.size ; i++ )
            {
                var_10b4a7a6 = a_enemies[ i ] geteye();
                var_b8f6e26f = player util::is_player_looking_at( var_10b4a7a6, var_62320a5b, 1, player );
                in_range = distancesquared( self.origin, a_enemies[ i ].origin ) >= var_95fca89b * var_95fca89b;
                var_7792c65f = sighttracepassed( self geteye(), var_10b4a7a6, 0, a_enemies[ i ] );
                var_39e0fee4 = isalive( a_enemies[ i ] ) && a_enemies[ i ].allowdeath !== 0 && a_enemies[ i ].magic_bullet_shield !== 1 && a_enemies[ i ].ignoreme == 0;
                
                if ( var_b8f6e26f && var_7792c65f && var_39e0fee4 && in_range && a_enemies[ i ] function_50c2e8b0() )
                {
                    self thread function_fc91db35( a_enemies[ i ] );
                    break;
                }
            }
        }
        
        n_min_wait = get_num_scaled_by_player_count( 5, 2 );
        n_max_wait = get_num_scaled_by_player_count( 10, 2 );
        wait randomintrange( n_min_wait, n_max_wait );
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x64b265fa, Offset: 0x6d18
// Size: 0x11, Type: bool
function function_50c2e8b0()
{
    if ( isdefined( self.scriptvehicletype ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zurich_util
// Params 0
// Checksum 0x30849aa7, Offset: 0x6d38
// Size: 0x22
function function_121ba443()
{
    self notify( #"hash_2f673cce" );
    self notify( #"hash_65af34bc" );
    self ai::stop_shoot_at_target();
}

// Namespace zurich_util
// Params 1
// Checksum 0x661dfdb9, Offset: 0x6d68
// Size: 0xe2
function function_fc91db35( ai_enemy )
{
    self notify( #"hash_65af34bc" );
    self endon( #"hash_65af34bc" );
    self ai::stop_shoot_at_target();
    str_mode = "kill_within_time";
    str_tag = "j_head";
    var_9b192fc6 = ai_enemy.scriptvehicletype;
    
    if ( isdefined( var_9b192fc6 ) )
    {
        switch ( var_9b192fc6 )
        {
            case "quadtank":
                str_mode = "shoot_until_target_dead";
                str_tag = undefined;
                break;
            default:
                str_mode = "normal";
                str_tag = undefined;
                break;
        }
    }
    
    self ai::set_ignoreme( 1 );
    self ai::shoot_at_target( str_mode, ai_enemy, str_tag, 5 );
    self ai::set_ignoreme( 0 );
}

// Namespace zurich_util
// Params 1
// Checksum 0x4ca6d5ce, Offset: 0x6e58
// Size: 0x95
function function_deebcec2( var_51d0e2ea )
{
    self endon( #"hash_65af34bc" );
    
    if ( isalive( var_51d0e2ea ) && isdefined( var_51d0e2ea.scriptvehicletype ) )
    {
        switch ( var_51d0e2ea.scriptvehicletype )
        {
            case "quadtank":
                self waittill( #"shoot" );
                
                if ( var_51d0e2ea function_51590606() )
                {
                }
                else if ( var_51d0e2ea quadtank::trophy_destroyed() )
                {
                }
                
                break;
            default:
                break;
        }
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0x828749fd, Offset: 0x6ef8
// Size: 0x72
function function_c000269f( var_51d0e2ea )
{
    self endon( #"hash_65af34bc" );
    var_51d0e2ea waittill( #"death", e_attacker );
    
    if ( self === e_attacker )
    {
        if ( isdefined( var_51d0e2ea.scriptvehicletype ) )
        {
            switch ( var_51d0e2ea.scriptvehicletype )
            {
                case "siegebot":
                    return;
                default:
                    break;
            }
        }
        
        self function_738e77ab();
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x3b28c066, Offset: 0x6f78
// Size: 0x39
function function_738e77ab()
{
    switch ( randomint( 2 ) )
    {
        case 0:
            break;
        case 1:
            break;
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0xd0f05768, Offset: 0x6fc0
// Size: 0x241
function function_2a6e38e()
{
    self notify( #"hash_e2457c05" );
    self endon( #"hash_e2457c05" );
    self endon( #"death" );
    
    while ( true )
    {
        while ( self haspath() || self function_f8645b6( -128, self geteye(), 0.65 ) )
        {
            wait 2;
        }
        
        var_8dc746d1 = undefined;
        var_1f5a4954 = distance2dsquared( self.goalpos, self geteye() );
        var_564617aa = arraysortclosest( level.activeplayers, self.origin, 1 );
        
        foreach ( e_player in var_564617aa )
        {
            var_8dc746d1 = distance2dsquared( self.origin, e_player.origin );
        }
        
        var_10dc781e = self.goalradius * self.goalradius;
        var_1535123f = !self player_can_see_me( 256 ) && !self function_f8645b6( -128, self.goalpos + ( 0, 0, 72 ), 0.65 );
        var_63f4e3a5 = isdefined( var_8dc746d1 ) && var_8dc746d1 > 360 * 360 && var_1f5a4954 > var_10dc781e;
        var_92315b88 = !self haspath() && var_1f5a4954 > var_10dc781e;
        
        if ( var_63f4e3a5 || var_1535123f && var_92315b88 )
        {
            /#
                iprintln( "<dev string:x7e>" );
            #/
            
            self forceteleport( self.goalpos );
        }
        
        wait 2;
    }
}

// Namespace zurich_util
// Params 3
// Checksum 0x125ec5cb, Offset: 0x7210
// Size: 0xf8, Type: bool
function function_f8645b6( n_dist, v_pos, n_dot )
{
    if ( !isdefined( n_dot ) )
    {
        n_dot = 0.7;
    }
    
    if ( !isdefined( n_dist ) )
    {
        n_dist = 320;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        v_player_pos = level.players[ i ] geteye();
        
        if ( level.players[ i ] util::is_player_looking_at( v_pos, n_dot, 1, level.players[ i ] ) )
        {
            return true;
        }
        
        var_b08b4a3b = distance2dsquared( v_pos, level.players[ i ] geteye() );
        n_dist_sq = n_dist * n_dist;
        
        if ( var_b08b4a3b < n_dist_sq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zurich_util
// Params 0
// Checksum 0xd1c4350e, Offset: 0x7310
// Size: 0xb
function function_4fb68dd5()
{
    self notify( #"hash_e2457c05" );
}

// Namespace zurich_util
// Params 0
// Checksum 0xba84ee2c, Offset: 0x7328
// Size: 0x21, Type: bool
function function_51590606()
{
    if ( !self vehicle_ai::iscooldownready( "trophy_down" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zurich_util
// Params 3
// Checksum 0xa4711831, Offset: 0x7358
// Size: 0xba
function move_model( n_multiplier, str_start, var_bd62ea22 )
{
    if ( !isdefined( n_multiplier ) )
    {
        n_multiplier = 1;
    }
    
    self endon( #"death" );
    s_start = self;
    
    if ( isdefined( str_start ) )
    {
        s_start = struct::get( str_start );
    }
    
    do
    {
        s_next = struct::get( s_start.target );
        self function_2153e0ef( s_start, s_next, n_multiplier, var_bd62ea22 );
        s_start = s_next;
    }
    while ( isdefined( s_start.target ) );
    
    self rotateto( s_next.angles, 0.05 );
}

// Namespace zurich_util
// Params 4
// Checksum 0xf07394a7, Offset: 0x7420
// Size: 0xc5
function function_2153e0ef( s_start, s_next, n_multiplier, var_bd62ea22 )
{
    if ( !isdefined( s_start ) )
    {
        s_start = self;
    }
    
    if ( !isdefined( var_bd62ea22 ) )
    {
        var_bd62ea22 = 1;
    }
    
    n_move = distance( s_next.origin, s_start.origin ) / 72 / n_multiplier;
    self moveto( s_next.origin, n_move );
    
    if ( var_bd62ea22 )
    {
        var_d9f4bdfd = s_next.origin - s_start.origin;
        self.angles = vectortoangles( var_d9f4bdfd );
    }
    
    wait n_move;
}

// Namespace zurich_util
// Params 3
// Checksum 0x45b9895, Offset: 0x74f0
// Size: 0xc1
function function_f9afa212( str_key, str_val, var_d646fb81 )
{
    if ( !isdefined( str_val ) )
    {
        str_val = "targetname";
    }
    
    var_33b370d9 = getspawnerarray( str_key, str_val );
    
    foreach ( n_index, var_907b6d46 in var_33b370d9 )
    {
        var_d697d6e2[ n_index ] = spawner::simple_spawn_single( var_907b6d46, &function_12141c31 );
    }
    
    return var_d697d6e2;
}

// Namespace zurich_util
// Params 0
// Checksum 0x7ac133b7, Offset: 0x75c0
// Size: 0x42
function function_12141c31()
{
    self vehicle::lights_off();
    self disableaimassist();
    self ai::set_ignoreme( 1 );
    self cybercom::function_58c312f2();
}

// Namespace zurich_util
// Params 3
// Checksum 0x78545aaa, Offset: 0x7610
// Size: 0xea
function function_3adbd846( str_val, str_key, b_once )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    if ( !isdefined( b_once ) )
    {
        b_once = 0;
    }
    
    t_trig = getent( str_val, str_key );
    
    if ( isdefined( t_trig ) )
    {
        t_trig endon( #"death" );
        
        while ( true )
        {
            t_trig waittill( #"trigger", e_triggerer );
            var_ccf2685a = isdefined( e_triggerer.owner ) && isplayer( e_triggerer.owner );
            
            if ( isplayer( e_triggerer ) || var_ccf2685a )
            {
                break;
            }
        }
        
        if ( b_once )
        {
            t_trig delete();
        }
    }
}

// Namespace zurich_util
// Params 7
// Checksum 0xf6f5040f, Offset: 0x7708
// Size: 0xd2
function function_1b3dfa61( str_name, str_type, n_width, n_height, n_length, b_spawn, str_objective )
{
    if ( !isdefined( str_type ) )
    {
        str_type = "trigger_radius";
    }
    
    if ( !isdefined( n_width ) )
    {
        n_width = -128;
    }
    
    if ( !isdefined( n_height ) )
    {
        n_height = -128;
    }
    
    if ( !isdefined( b_spawn ) )
    {
        b_spawn = 1;
    }
    
    t_trig = getent( str_name, "targename" );
    
    if ( b_spawn )
    {
        t_trig = function_3789d4db( str_name, str_type, n_width, n_height, n_length, str_objective );
    }
    
    t_trig waittill( #"trigger" );
    
    if ( isdefined( t_trig ) )
    {
        t_trig delete();
    }
}

// Namespace zurich_util
// Params 6
// Checksum 0x921eae75, Offset: 0x77e8
// Size: 0x140
function function_3789d4db( str_name, str_type, n_width, n_height, n_length, str_objective )
{
    if ( !isdefined( str_type ) )
    {
        str_type = "trigger_radius";
    }
    
    if ( !isdefined( n_height ) )
    {
        n_height = -128;
    }
    
    if ( !isdefined( n_length ) )
    {
        n_length = 0;
    }
    
    s_spot = struct::get( str_name );
    
    if ( !isdefined( s_spot ) )
    {
        s_spot = getent( str_name, "targetname" );
    }
    
    if ( !isdefined( n_width ) )
    {
        n_width = -128;
        
        if ( isdefined( s_spot.radius ) )
        {
            n_width = s_spot.radius;
        }
    }
    
    t_trig = spawn( str_type, s_spot.origin, 0, n_width, n_height, n_length );
    t_trig.angles = s_spot.angles;
    t_trig.targetname = s_spot.targetname;
    t_trig.target = s_spot.target;
    t_trig.script_noteworthy = s_spot.script_noteworthy;
    t_trig.script_objective = str_objective;
    return t_trig;
}

// Namespace zurich_util
// Params 4
// Checksum 0xd62241a1, Offset: 0x7930
// Size: 0xb3
function function_5bb4d484( str_val, str_key, n_count, var_a3e7056a )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    if ( !isdefined( var_a3e7056a ) )
    {
        var_a3e7056a = 0.05;
    }
    
    sp_spawner = self;
    
    if ( sp_spawner == level )
    {
        sp_spawner = getent( str_val, str_key );
    }
    
    a_ai = [];
    
    for ( i = 0; i < n_count ; i++ )
    {
        a_ai[ i ] = spawner::simple_spawn_single( sp_spawner );
        wait var_a3e7056a;
    }
    
    return a_ai;
}

// Namespace zurich_util
// Params 3
// Checksum 0xf29d5c38, Offset: 0x79f0
// Size: 0xed
function function_b0dd51f4( str_spawner, str_key, var_a3e7056a )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    if ( !isdefined( var_a3e7056a ) )
    {
        var_a3e7056a = 0.05;
    }
    
    a_sp = getspawnerarray( str_spawner, str_key );
    
    if ( a_sp.size == 0 )
    {
        a_sp = getvehiclespawnerarray( str_spawner, str_key );
    }
    
    a_ents = [];
    
    foreach ( n_index, sp in a_sp )
    {
        a_ents[ n_index ] = spawner::simple_spawn_single( sp );
        wait var_a3e7056a;
    }
    
    return a_ents;
}

// Namespace zurich_util
// Params 9
// Checksum 0x5b1d8ce4, Offset: 0x7ae8
// Size: 0x265
function function_33ec653f( str_val, str_key, var_a3e7056a, spawn_func, param1, param2, param3, param4, param5 )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    if ( !isdefined( var_a3e7056a ) )
    {
        var_a3e7056a = 0.05;
    }
    
    s_spawn_manager = struct::get( str_val, str_key );
    s_spawn_manager endon( #"stop" );
    s_spawn_manager.a_ai = [];
    s_spawn_manager.n_spawned = 0;
    assert( isdefined( s_spawn_manager.target ), "<dev string:xa0>" + s_spawn_manager.origin + "<dev string:xb9>" + s_spawn_manager.targetname + "<dev string:xcb>" );
    s_spawn_manager.var_431a4b23 = getnodearray( s_spawn_manager.target, "targetname" );
    
    if ( s_spawn_manager.var_431a4b23.size == 0 )
    {
        s_spawn_manager.var_431a4b23 = getvehiclenodearray( s_spawn_manager.target, "targetname" );
    }
    
    if ( s_spawn_manager.var_431a4b23.size == 0 )
    {
        s_spawn_manager.var_431a4b23 = struct::get_array( s_spawn_manager.target );
    }
    
    s_spawn_manager.var_431a4b23 = array::randomize( s_spawn_manager.var_431a4b23 );
    
    foreach ( i, nd_point in s_spawn_manager.var_431a4b23 )
    {
        if ( isdefined( nd_point.script_int ) && nd_point.script_int > level.players.size )
        {
            continue;
        }
        
        s_spawn_manager.a_ai[ i ] = s_spawn_manager function_a569867c( nd_point, spawn_func, i, param1, param2, param3, param4, param5 );
        
        if ( i === s_spawn_manager.script_int )
        {
            break;
        }
        
        wait var_a3e7056a;
    }
    
    return s_spawn_manager.a_ai;
}

// Namespace zurich_util
// Params 8
// Checksum 0x4b2dab4e, Offset: 0x7d58
// Size: 0x28a
function function_a569867c( nd_point, spawn_func, i, param1, param2, param3, param4, param5 )
{
    if ( !isdefined( nd_point ) )
    {
        nd_point = self;
    }
    
    if ( !isdefined( i ) )
    {
        i = 0;
    }
    
    assert( isdefined( nd_point.script_noteworthy ), "<dev string:xeb>" + nd_point.origin + "<dev string:x102>" + self.targetname + "<dev string:x117>" );
    sp_spawn = getent( nd_point.script_noteworthy, "targetname" );
    assert( isdefined( sp_spawn ), "<dev string:x154>" + nd_point.script_noteworthy );
    self.a_ai[ i ] = spawner::simple_spawn_single( sp_spawn );
    
    if ( !isalive( self.a_ai[ i ] ) )
    {
        return;
    }
    
    if ( !isdefined( self.n_spawned ) )
    {
        self.n_spawned = 0;
    }
    
    self.n_spawned++;
    
    if ( isactor( self.a_ai[ i ] ) )
    {
        self.a_ai[ i ] forceteleport( nd_point.origin, nd_point.angles );
    }
    
    self.a_ai[ i ].var_cdb0be8 = nd_point;
    self.a_ai[ i ].script_string = nd_point.script_string;
    self.a_ai[ i ].script_parameters = nd_point.script_parameters;
    
    if ( isdefined( self.a_ai[ i ].var_cdb0be8.radius ) )
    {
        self.a_ai[ i ].goalradius = self.a_ai[ i ].var_cdb0be8.radius;
    }
    
    if ( isdefined( spawn_func ) )
    {
        util::single_thread( self.a_ai[ i ], spawn_func, param1, param2, param3, param4, param5 );
    }
    
    if ( isvehicle( self.a_ai[ i ] ) )
    {
        self.a_ai[ i ] thread function_e8d7d9();
    }
    else
    {
        self.a_ai[ i ] thread function_dea7f09f();
    }
    
    return self.a_ai[ i ];
}

// Namespace zurich_util
// Params 0
// Checksum 0x5990b277, Offset: 0x7ff0
// Size: 0x1aa
function function_dea7f09f()
{
    self endon( #"death" );
    target = self.var_cdb0be8;
    
    if ( !isdefined( target.target ) )
    {
        return;
    }
    
    a_s_scene = struct::get_array( target.target );
    s_scene = array::random( a_s_scene );
    wait 0.05;
    
    while ( isdefined( s_scene ) && isdefined( s_scene.scriptbundlename ) )
    {
        level scene::play( s_scene.targetname, "targetname", self );
        target = s_scene;
        
        if ( !isdefined( target.target ) )
        {
            break;
        }
        
        s_scene = struct::get( target.target, "targetname" );
    }
    
    if ( !isdefined( target.target ) || isdefined( self.scriptvehicletype ) )
    {
        return;
    }
    
    goals = getnodearray( target.target, "targetname" );
    
    if ( goals.size == 0 )
    {
        goals = getentarray( target.target, "targetname" );
    }
    
    if ( goals.size == 0 )
    {
        goal = target;
    }
    else
    {
        goal = array::random( goals );
    }
    
    if ( isdefined( goal ) && !ispointonnavmesh( goal.origin ) )
    {
        return;
    }
    
    self setgoal( goal );
}

// Namespace zurich_util
// Params 0
// Checksum 0x3403939f, Offset: 0x81a8
// Size: 0x82
function function_e8d7d9()
{
    self endon( #"death" );
    
    if ( isdefined( self.scriptvehicletype ) )
    {
        self ai::set_ignoreme( 1 );
        self vehicle_ai::start_scripted();
    }
    
    self vehicle::get_on_and_go_path( self.var_cdb0be8 );
    
    if ( !isdefined( self.scriptvehicletype ) )
    {
        return;
    }
    
    self ai::set_ignoreme( 0 );
    self vehicle_ai::stop_scripted();
}

// Namespace zurich_util
// Params 2
// Checksum 0xa5377b4b, Offset: 0x8238
// Size: 0xca
function function_3ee4a3b3( str_triggers, str_objective )
{
    a_trigs = [];
    a_s_triggers = struct::get_array( str_triggers );
    
    foreach ( i, s_trig in a_s_triggers )
    {
        a_trigs[ i ] = function_3789d4db( s_trig.targetname, undefined, undefined, undefined, 768, str_objective );
    }
    
    array::thread_all( a_trigs, &function_1fb1b1c4 );
}

// Namespace zurich_util
// Params 0
// Checksum 0xbd88ba63, Offset: 0x8310
// Size: 0x3a
function function_1fb1b1c4()
{
    self endon( #"death" );
    self waittill( #"trigger" );
    function_33ec653f( self.target, undefined, undefined, &function_d065a580 );
}

// Namespace zurich_util
// Params 0
// Checksum 0xdcd2617e, Offset: 0x8358
// Size: 0xf2
function function_d065a580()
{
    self endon( #"death" );
    wait 0.05;
    
    for ( var_5f2b7673 = self.var_cdb0be8; isdefined( var_5f2b7673 ) ; var_5f2b7673 = array::random( var_b3a8bd53 ) )
    {
        self function_ff6b67ed( var_5f2b7673 );
        
        if ( !isdefined( var_5f2b7673.target ) )
        {
            break;
        }
        
        wait randomfloatrange( 0.25, 0.38 );
        var_b3a8bd53 = getnodearray( var_5f2b7673.target, "targetname" );
        
        if ( var_b3a8bd53.size < 1 )
        {
            var_b3a8bd53 = struct::get_array( var_5f2b7673.target );
        }
        
        if ( var_b3a8bd53.size < 1 )
        {
            break;
        }
    }
    
    self delete();
}

// Namespace zurich_util
// Params 1
// Checksum 0xeaf38b20, Offset: 0x8458
// Size: 0x191
function function_a00fa665( str_objective )
{
    if ( isdefined( level.var_65070634 ) )
    {
        level.var_65070634 notify( #"hash_11a8c313" );
    }
    
    switch ( str_objective )
    {
        case "clearing_hub":
            var_ef5507a6 = "clearing_start";
            break;
        case "clearing_hub_2":
            var_ef5507a6 = "clearing_start";
            var_9636f088 = "p7_fxanim_cp_zurich_dni_tree_broken01_mod";
            break;
        case "clearing_hub_3":
            var_ef5507a6 = "clearing_start";
            var_9636f088 = "p7_fxanim_cp_zurich_dni_tree_broken02_mod";
            break;
        default:
            var_ef5507a6 = str_objective;
            break;
    }
    
    s_tree = struct::get( var_ef5507a6, "script_noteworthy" );
    
    if ( isdefined( var_9636f088 ) )
    {
        var_814bdb75 = var_9636f088;
    }
    else
    {
        var_814bdb75 = s_tree.model;
    }
    
    if ( !isdefined( var_814bdb75 ) )
    {
        var_814bdb75 = "p7_zur_coalescence_dni_tree";
    }
    
    level.var_65070634 = util::spawn_model( var_814bdb75, s_tree.origin, s_tree.angles );
    
    if ( !isdefined( s_tree.script_float ) )
    {
        s_tree.script_float = 1;
    }
    
    level.var_65070634 setscale( s_tree.script_float );
    level.var_65070634.shadow_casting = 0;
    level.var_65070634 thread function_17fdda66();
    return level.var_65070634;
}

// Namespace zurich_util
// Params 0
// Checksum 0x91c38d8a, Offset: 0x85f8
// Size: 0x82
function function_17fdda66()
{
    wait 0.1;
    self clientfield::set( "corvus_tree_shader", 1 );
    self waittill( #"hash_11a8c313" );
    self clientfield::set( "corvus_tree_shader", 0 );
    
    if ( isdefined( self.mdl_exploder ) )
    {
        self.mdl_exploder delete();
    }
    
    util::wait_network_frame();
    self delete();
}

// Namespace zurich_util
// Params 2
// Checksum 0x9f800264, Offset: 0x8688
// Size: 0x31b
function player_weather( is_on, str_effect )
{
    if ( is_on && isdefined( str_effect ) )
    {
        switch ( str_effect )
        {
            case "regular_snow":
                if ( isplayer( self ) )
                {
                    self clientfield::set_to_player( "player_weather", 1 );
                }
                else
                {
                    foreach ( player in level.players )
                    {
                        player clientfield::set_to_player( "player_weather", 1 );
                    }
                }
                
                break;
            case "light_snow":
                if ( isplayer( self ) )
                {
                    self clientfield::set_to_player( "player_weather", 4 );
                }
                else
                {
                    foreach ( player in level.players )
                    {
                        player clientfield::set_to_player( "player_weather", 4 );
                    }
                }
                
                break;
            case "red_rain":
                if ( isplayer( self ) )
                {
                    self clientfield::set_to_player( "player_weather", 2 );
                }
                else
                {
                    foreach ( player in level.players )
                    {
                        player clientfield::set_to_player( "player_weather", 2 );
                    }
                }
                
                break;
            default:
                if ( isplayer( self ) )
                {
                    self clientfield::set_to_player( "player_weather", 3 );
                }
                else
                {
                    foreach ( player in level.players )
                    {
                        player clientfield::set_to_player( "player_weather", 3 );
                    }
                }
                
                break;
        }
        
        return;
    }
    
    if ( isplayer( self ) )
    {
        self clientfield::set_to_player( "player_weather", 0 );
        return;
    }
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "player_weather", 0 );
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0xfd561b07, Offset: 0x89b0
// Size: 0x8f
function function_7be427b1( n_damage )
{
    if ( !isdefined( n_damage ) )
    {
        n_damage = 5;
    }
    
    self endon( #"hash_17344cca" );
    self endon( #"death" );
    var_dd075cd2 = 1;
    self hazard::function_459e5eff( "biohazard", 0 );
    level.overrideplayerdamage = &player_callback_damage;
    
    while ( true )
    {
        wait 1;
        var_dd075cd2 = self hazard::do_damage( "biohazard", n_damage );
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0x41691209, Offset: 0x8a48
// Size: 0x22
function function_61bb5738()
{
    level.overrideplayerdamage = undefined;
    self hazard::function_459e5eff( "biohazard", 1 );
}

// Namespace zurich_util
// Params 11
// Checksum 0x398916fa, Offset: 0x8a78
// Size: 0x5b, Type: bool
function player_callback_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex )
{
    return false;
}

// Namespace zurich_util
// Params 0
// Checksum 0x94b0d3ad, Offset: 0x8ae0
// Size: 0x72, Type: bool
function mobile_armory_in_use()
{
    foreach ( e_player in level.activeplayers )
    {
        if ( e_player flagsys::get( "mobile_armory_in_use" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zurich_util
// Params 1
// Checksum 0xb5ca9c2b, Offset: 0x8b60
// Size: 0x7a
function function_41753e77( str_pstfx )
{
    a_postfx_field = [];
    a_postfx_field[ "dni_futz" ] = "postfx_futz";
    assert( isdefined( a_postfx_field[ str_pstfx ] ), "<dev string:x177>" + str_pstfx );
    wait randomfloat( 0.25 );
    self thread clientfield::increment_to_player( a_postfx_field[ str_pstfx ] );
}

// Namespace zurich_util
// Params 1
// Checksum 0x6df08f71, Offset: 0x8be8
// Size: 0xea
function function_11b424e5( is_on )
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    if ( isdefined( is_on ) && !isplayer( self ) )
    {
        if ( is_on )
        {
            level.var_60bad7a5 = 1;
            array::run_all( level.players, &util::set_low_ready, 1 );
        }
        else
        {
            level.var_60bad7a5 = 0;
            array::run_all( level.players, &util::set_low_ready, 0 );
        }
        
        return;
    }
    
    if ( isdefined( level.var_60bad7a5 ) )
    {
        if ( level.var_60bad7a5 )
        {
            self util::set_low_ready( 1 );
            return;
        }
        
        self util::set_low_ready( 0 );
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0x8bf33d1f, Offset: 0x8ce0
// Size: 0x62
function function_c049667c( is_true )
{
    if ( is_true )
    {
        w_kane_weapon = getweapon( "smg_standard_hero" );
    }
    else
    {
        w_kane_weapon = level.ai_kane.primaryweapon;
    }
    
    level.ai_kane ai::gun_switchto( w_kane_weapon, "right" );
}

// Namespace zurich_util
// Params 0
// Checksum 0xfebf825d, Offset: 0x8d50
// Size: 0x6c
function function_d1996775()
{
    str_obj = &"cp_level_zurich_hack_lobby_door";
    str_hint = &"CP_MI_ZURICH_COALESCENCE_HACK";
    self hacking::init_hack_trigger( 3, str_obj, str_hint );
    e_who = self hacking::trigger_wait();
    self triggerenable( 0 );
    return e_who;
}

// Namespace zurich_util
// Params 1
// Checksum 0xa8359b5e, Offset: 0x8dc8
// Size: 0x13
function function_9bb12e2f( params )
{
    level notify( #"hash_9bb12e2f" );
}

// Namespace zurich_util
// Params 0
// Checksum 0x6ac8d8a1, Offset: 0x8de8
// Size: 0x5c
function function_74c09be7()
{
    str_obj = &"cp_level_zurich_hack_lobby_door";
    str_hint = &"CP_MI_ZURICH_COALESCENCE_HACK";
    util::init_interactive_gameobject( self, str_obj, str_hint, &function_89a1383e );
    self triggerenable( 1 );
    level waittill( #"hash_a271fdb7" );
}

// Namespace zurich_util
// Params 1
// Checksum 0x4a6ac2dd, Offset: 0x8e50
// Size: 0x3b
function function_89a1383e( e_player )
{
    self gameobjects::disable_object();
    self.e_player = e_player;
    e_player cybercom::cybercom_armpulse( 1 );
    level notify( #"hash_a271fdb7" );
}

// Namespace zurich_util
// Params 0
// Checksum 0xea8b3780, Offset: 0x8e98
// Size: 0x5c
function function_f3bcbbb1()
{
    str_obj = &"cp_level_zurich_burn_vines";
    str_hint = &"CP_MI_ZURICH_COALESCENCE_BURN";
    util::init_interactive_gameobject( self, str_obj, str_hint, &function_b6a9fc24 );
    self triggerenable( 1 );
    level waittill( #"hash_e9197af7" );
}

// Namespace zurich_util
// Params 1
// Checksum 0xe9db5a64, Offset: 0x8f00
// Size: 0x33
function function_b6a9fc24( e_player )
{
    self gameobjects::disable_object();
    e_player thread function_4a447e94();
    level notify( #"hash_e9197af7" );
}

// Namespace zurich_util
// Params 0
// Checksum 0x604ae061, Offset: 0x8f40
// Size: 0x99
function function_aceff870()
{
    self endon( #"death" );
    self.var_48772f67 = 1;
    
    while ( true )
    {
        e_player = util::get_closest_player( self.origin, "allies" );
        
        if ( isdefined( e_player ) )
        {
            var_eb23928c = getclosestpointonnavmesh( e_player.origin, -128, 32 );
            
            if ( isdefined( var_eb23928c ) )
            {
                self ai::force_goal( var_eb23928c, -128, 1 );
            }
        }
        
        wait 3;
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0xe45dd02c, Offset: 0x8fe8
// Size: 0x3a
function function_f3e247d6( a_ents )
{
    if ( isdefined( a_ents[ "corvus" ] ) )
    {
        a_ents[ "corvus" ] clientfield::set( "corvus_body_fx", 1 );
    }
}

// Namespace zurich_util
// Params 0
// Checksum 0xb91e5ca9, Offset: 0x9030
// Size: 0x62
function function_c83720c9()
{
    var_347ccc07 = getent( "garage_bounds", "targetname" );
    var_347ccc07 setinvisibletoall();
    trigger::wait_till( "triage_regroup" );
    var_347ccc07 setvisibletoall();
}

// Namespace zurich_util
// Params 2
// Checksum 0x36a3b0d4, Offset: 0x90a0
// Size: 0x216
function function_2e1830eb( str_station, str_objective )
{
    s_scene = undefined;
    a_mdl_parts = [];
    mdl_origin = undefined;
    a_s_station = struct::get_array( str_station );
    
    foreach ( i, s_part in a_s_station )
    {
        if ( isdefined( s_part.scriptbundlename ) )
        {
            s_scene = s_part;
            continue;
        }
        
        wait 0.05;
        
        if ( s_part.script_noteworthy === "origin" )
        {
            mdl_origin = util::spawn_model( "tag_origin", s_part.origin, s_part.angles );
            mdl_origin.targetname = s_part.targetname;
            mdl_origin.script_objective = str_objective;
            
            /#
                recordent( mdl_origin );
            #/
            
            continue;
        }
        
        if ( !isdefined( s_part.model ) )
        {
            continue;
        }
        
        a_mdl_parts[ i ] = util::spawn_model( "p7_sgen_charging_station_pod_white", s_part.origin, s_part.angles );
        a_mdl_parts[ i ].script_objective = str_objective;
        
        /#
            recordent( a_mdl_parts[ i ] );
        #/
    }
    
    foreach ( j, mdl_part in a_mdl_parts )
    {
        mdl_part linkto( mdl_origin );
        mdl_origin.a_mdl_parts[ j ] = mdl_part;
    }
    
    mdl_origin.s_scene = s_scene;
}

// Namespace zurich_util
// Params 6
// Checksum 0x10ba192e, Offset: 0x92c0
// Size: 0x5bd
function function_27904cd4( str_station, str_objective, n_count, var_31561fde, n_min_time, n_max_time )
{
    if ( !isdefined( n_count ) )
    {
        n_count = 0;
    }
    
    if ( !isdefined( var_31561fde ) )
    {
        var_31561fde = 1;
    }
    
    if ( !isdefined( n_min_time ) )
    {
        n_min_time = 1;
    }
    
    if ( !isdefined( n_max_time ) )
    {
        n_max_time = 4;
    }
    
    level endon( str_objective + "_completed" );
    str_scenedef = "cin_zur_02_01_climb_aie_charging_station";
    a_str_spawners = array( "sec_assault_ar", "sec_suppressor_ar", "sec_cqb_shotgun", "sec_rpg_rocket", "sec_suppressor_mg", "sec_sniper", "sec_rusher", "sec_exploder" );
    var_ce83537c = getent( str_station, "targetname" );
    var_ce83537c endon( #"death" );
    var_ce83537c endon( #"disable" );
    
    if ( !isdefined( var_ce83537c.mdl_origin ) )
    {
        var_ce83537c.mdl_origin = util::spawn_model( "tag_origin", var_ce83537c.s_scene.origin, var_ce83537c.s_scene.angles );
    }
    
    var_ce83537c.v_start_angles = var_ce83537c.angles;
    var_ce83537c.mdl_origin.script_objective = str_objective;
    var_ce83537c.a_ai = [];
    var_ce83537c.n_spawned = 0;
    var_ce83537c.b_active = 1;
    wait 0.05;
    
    do
    {
        var_ce83537c.a_ai = array::remove_dead( var_ce83537c.a_ai );
        
        if ( var_ce83537c.a_ai.size >= var_31561fde )
        {
            wait 2;
            continue;
        }
        
        str_spawner = array::random( a_str_spawners );
        var_ce83537c.ai_spawned = spawner::simple_spawn_single( str_spawner );
        var_ce83537c.mdl_origin linkto( var_ce83537c );
        
        if ( !isalive( var_ce83537c.ai_spawned ) )
        {
            wait 0.05;
            continue;
        }
        
        var_ce83537c.ai_spawned ai::set_ignoreme( 1 );
        
        if ( isdefined( var_ce83537c.s_scene.script_label ) )
        {
            var_ce83537c.ai_spawned colors::set_force_color( var_ce83537c.s_scene.script_label );
        }
        
        if ( !isdefined( var_ce83537c.a_ai ) )
        {
            var_ce83537c.a_ai = [];
        }
        else if ( !isarray( var_ce83537c.a_ai ) )
        {
            var_ce83537c.a_ai = array( var_ce83537c.a_ai );
        }
        
        var_ce83537c.a_ai[ var_ce83537c.a_ai.size ] = var_ce83537c.ai_spawned;
        var_ce83537c.n_spawned++;
        var_ce83537c.ai_spawned forceteleport( var_ce83537c.mdl_origin.origin, var_ce83537c.mdl_origin.angles );
        var_ce83537c.ai_spawned linkto( var_ce83537c.mdl_origin );
        var_ce83537c.mdl_origin scene::init( str_scenedef, var_ce83537c.ai_spawned );
        var_ce83537c rotateyaw( -76, randomfloatrange( 0.89, 1.4 ) );
        var_ce83537c waittill( #"rotatedone" );
        
        if ( !isalive( var_ce83537c.ai_spawned ) )
        {
            var_ce83537c.mdl_origin unlink();
            var_ce83537c.mdl_origin.origin = var_ce83537c.s_scene.origin;
            var_ce83537c.mdl_origin.angles = var_ce83537c.s_scene.angles;
            continue;
        }
        
        var_ce83537c.mdl_origin scene::play( str_scenedef, var_ce83537c.ai_spawned );
        
        if ( isalive( var_ce83537c.ai_spawned ) )
        {
            var_ce83537c.ai_spawned ai::set_ignoreme( 0 );
            var_ce83537c.ai_spawned unlink();
        }
        
        var_ce83537c.ai_spawned = undefined;
        var_ce83537c.mdl_origin unlink();
        var_ce83537c.mdl_origin.origin = var_ce83537c.s_scene.origin;
        var_ce83537c.mdl_origin.angles = var_ce83537c.s_scene.angles;
        wait randomfloatrange( n_min_time, n_max_time );
        
        if ( n_count != 0 && var_ce83537c.n_spawned >= n_count )
        {
            b_active = 0;
        }
    }
    while ( isdefined( var_ce83537c.b_active ) && var_ce83537c.b_active );
}

// Namespace zurich_util
// Params 1
// Checksum 0x99f32a57, Offset: 0x9888
// Size: 0xba
function function_5b0d9c63( str_station )
{
    var_ce83537c = getent( str_station, "targetname" );
    
    if ( !isdefined( var_ce83537c ) )
    {
        /#
            iprintln( "<dev string:x1ba>" + str_station + "<dev string:x1dc>" );
        #/
        
        return;
    }
    
    var_ce83537c notify( #"disable" );
    var_ce83537c.b_active = 0;
    
    if ( isalive( var_ce83537c.ai_spawned ) )
    {
        var_ce83537c.ai_spawned kill();
    }
    
    var_ce83537c rotateto( var_ce83537c.v_start_angles, 1 );
}

// Namespace zurich_util
// Params 0
// Checksum 0x7ff9c584, Offset: 0x9950
// Size: 0x18d
function function_6d571441()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", n_damage, e_attacker, _, _, str_damage_type );
        self.health = self.health + n_damage;
        var_a4a673a9 = str_damage_type == "MOD_PROJECTILE" || str_damage_type === "MOD_EXPLOSIVE";
        
        if ( isplayer( e_attacker ) && var_a4a673a9 )
        {
            self.var_7a04481c = self.var_7a04481c - n_damage;
        }
        
        if ( self.var_7a04481c <= 0 )
        {
            s_crash_point = array::random( self.var_90937e6 );
            self vehicle::god_on();
            self vehicle::get_off_path();
            self setspeed( 42, 18, 12 );
            self setvehgoalpos( s_crash_point.origin );
            self waittill( #"goal" );
            self vehicle::god_off();
            array::run_all( self.riders, &kill );
            self dodamage( self.health + 100, self.origin, e_attacker );
        }
    }
}

// Namespace zurich_util
// Params 1
// Checksum 0x2f1520b8, Offset: 0x9ae8
// Size: 0x5a
function function_fe5160df( b_true )
{
    self endon( #"death" );
    
    if ( b_true )
    {
        wait randomfloatrange( 1, 3 );
        self clientfield::set( "hero_cold_breath", 1 );
        return;
    }
    
    self clientfield::set( "hero_cold_breath", 0 );
}

// Namespace zurich_util
// Params 1
// Checksum 0xeddad38d, Offset: 0x9b50
// Size: 0x4a
function function_e547724d( a_ents )
{
    a_ents[ "raven" ] hide();
    level waittill( #"hash_755edaa4" );
    a_ents[ "raven" ] show();
}

// Namespace zurich_util
// Params 1
// Checksum 0xcbd3de0c, Offset: 0x9ba8
// Size: 0x22
function function_3f6f483d( a_ents )
{
    a_ents[ "raven" ] show();
}

// Namespace zurich_util
// Params 1
// Checksum 0xc54e2394, Offset: 0x9bd8
// Size: 0xc2
function function_86b1cd8a( a_ents )
{
    a_ents[ "raven" ] endon( #"death" );
    a_ents[ "raven" ] hide();
    a_ents[ "raven" ] waittill( #"hash_db8335ba" );
    a_ents[ "raven" ] show();
    a_ents[ "raven" ] waittill( #"hash_c03e8e55" );
    a_ents[ "raven" ] clientfield::set( "raven_fade_out", 1 );
    wait 0.5;
    a_ents[ "raven" ] hide();
}

// Namespace zurich_util
// Params 1
// Checksum 0x77729bcb, Offset: 0x9ca8
// Size: 0x7a
function function_2504fb31( b_on )
{
    a_clip = getentarray( "hq_atrium_player_clip", "targetname" );
    
    if ( b_on )
    {
        array::run_all( a_clip, &solid );
        return;
    }
    
    array::run_all( a_clip, &notsolid );
}

// Namespace zurich_util
// Params 1
// Checksum 0x1e2ee1d7, Offset: 0x9d30
// Size: 0x6a
function function_df1fc23b( b_hacked )
{
    if ( b_hacked )
    {
        hidemiscmodels( "hq_exit_panel_outro" );
        showmiscmodels( "hq_exit_panel_hacked_outro" );
        return;
    }
    
    hidemiscmodels( "hq_exit_panel_hacked_outro" );
    showmiscmodels( "hq_exit_panel_outro" );
}

// Namespace zurich_util
// Params 1
// Checksum 0x18bcd404, Offset: 0x9da8
// Size: 0x3a
function function_162b9ea0( a_ents )
{
    e_door = a_ents[ "tower_door" ];
    level waittill( #"hash_1851c43a" );
    e_door delete();
}

// Namespace zurich_util
// Params 1
// Checksum 0xcd686b31, Offset: 0x9df0
// Size: 0x735
function function_4a00a473( str_location )
{
    if ( str_location == "street" )
    {
        level struct::delete_script_bundle( "scene", "cin_zur_01_01_intro_1st_lost_contact" );
        return;
    }
    
    if ( str_location == "garage" )
    {
        level struct::delete_script_bundle( "scene", "cin_zur_melee_robot_choke_throw" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_car_crash_stuck_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_parking_wall_explode_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_truck_crash_01_bundle" );
        return;
    }
    
    if ( str_location == "plaza_battle" )
    {
        level struct::delete_script_bundle( "scene", "cin_zur_02_01_climb_aie_charging_station" );
        level struct::delete_script_bundle( "scene", "cin_zur_03_01_train_vign_bodies02" );
        level struct::delete_script_bundle( "scene", "cin_zur_03_01_train_vign_bodies03" );
        level struct::delete_script_bundle( "scene", "cin_zur_03_01_train_vign_bodies04" );
        level struct::delete_script_bundle( "scene", "cin_zur_03_01_train_vign_strapped" );
        level struct::delete_script_bundle( "scene", "cin_zur_04_01_ext_vign_lockdown" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_car_crash_01_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_car_crash_02_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_car_crash_03_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_car_crash_04_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_car_crash_05_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_hunter_start_01_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_hunter_start_02_bundle" );
        return;
    }
    
    if ( str_location == "server_room" )
    {
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_train_seats_bundle" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_02_decontamination_vign_schematic" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh010" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh020" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh030" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh040" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh050" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh060" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh070" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh080" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh090" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh100" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh110" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh120" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh130" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh140" );
        level struct::delete_script_bundle( "scene", "cin_zur_06_sacrifice_3rd_sh150" );
        return;
    }
    
    if ( str_location == "clearing_hub" )
    {
        level struct::delete_script_bundle( "scene", "cin_zur_09_01_standoff_1st_hostage" );
        level struct::delete_script_bundle( "scene", "cin_zur_09_02_standoff_1st_forest" );
        level struct::delete_script_bundle( "scene", "cin_zur_09_02_standoff_3rd_forest_part2_sh010" );
        level struct::delete_script_bundle( "scene", "cin_zur_09_01_standoff_vign_far_as_i_go" );
        level struct::delete_script_bundle( "scene", "cin_zur_10_01_kruger_3rd_questioned_sh010" );
        level struct::delete_script_bundle( "scene", "cin_zur_10_01_kruger_3rd_questioned_sh020" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_rock_slide_bundle" );
        return;
    }
    
    if ( str_location == "root_zurich" )
    {
        level struct::delete_script_bundle( "scene", "cin_zur_12_01_root_1st_mirror_01" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_roots_train_bundle" );
        return;
    }
    
    if ( str_location == "root_cairo" )
    {
        level struct::delete_script_bundle( "scene", "cin_zur_14_01_cairo_root_1st_fall" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_checkpoint_wall_01_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_wall_drop_bundle" );
        return;
    }
    
    if ( str_location == "clearing_hub_3" )
    {
        level struct::delete_script_bundle( "scene", "cin_zur_12_01_root_1st_crumble" );
        level struct::delete_script_bundle( "scene", "cin_zur_12_01_root_1st_crumble3" );
        return;
    }
    
    if ( str_location == "root_singapore" )
    {
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_ferris_wheel_wave_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_container_collapse_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_ferris_wheel_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_car_slide_bundle" );
    }
}

// Namespace zurich_util
// Params 2
// Checksum 0x6161c29b, Offset: 0xa530
// Size: 0xdb
function function_9f90bc0f( a_ents, str_notify )
{
    if ( isdefined( str_notify ) )
    {
        level waittill( str_notify );
    }
    
    if ( isdefined( self.scriptbundlename ) )
    {
        level struct::delete_script_bundle( "scene", self.scriptbundlename );
    }
    
    a_ents = array::remove_undefined( a_ents );
    
    if ( a_ents.size )
    {
        foreach ( e_ent in a_ents )
        {
            if ( !isplayer( e_ent ) )
            {
                e_ent delete();
            }
        }
    }
}

// Namespace zurich_util
// Params 3
// Checksum 0x20931b38, Offset: 0xa618
// Size: 0xb3
function enable_nodes( str_key, str_val, b_enable )
{
    if ( !isdefined( str_val ) )
    {
        str_val = "targetname";
    }
    
    if ( !isdefined( b_enable ) )
    {
        b_enable = 1;
    }
    
    a_nodes = getnodearray( str_key, str_val );
    
    foreach ( nd in a_nodes )
    {
        setenablenode( nd, b_enable );
    }
}

/#

    // Namespace zurich_util
    // Params 7
    // Checksum 0x8c2a2fe2, Offset: 0xa6d8
    // Size: 0xa5, Type: dev
    function debug_draw_line( var_eff163a9, e_ent2, str_endon, v_color, str_endon2, str_tag1, str_tag2 )
    {
        if ( !isdefined( str_endon ) )
        {
            str_endon = "<dev string:x1e4>";
        }
        
        if ( !isdefined( v_color ) )
        {
            v_color = ( 0, 1, 0 );
        }
        
        var_eff163a9 endon( str_endon );
        e_ent2 endon( str_endon );
        self endon( str_endon2 );
        
        while ( true )
        {
            recordline( var_eff163a9.origin, e_ent2.origin, v_color, "<dev string:x1ea>", var_eff163a9 );
            wait 0.05;
        }
    }

    // Namespace zurich_util
    // Params 3
    // Checksum 0x490e2a42, Offset: 0xa788
    // Size: 0x7d, Type: dev
    function function_9ff5370d( n_radius, v_color, e_owner )
    {
        if ( !isdefined( n_radius ) )
        {
            n_radius = 64;
        }
        
        if ( !isdefined( v_color ) )
        {
            v_color = ( 0, 1, 0 );
        }
        
        if ( !isdefined( e_owner ) )
        {
            e_owner = self;
        }
        
        self endon( #"hash_dc898c8" );
        
        while ( isdefined( self ) )
        {
            recordcircle( self.origin, n_radius, v_color, "<dev string:x1ea>", e_owner );
            wait 0.05;
        }
    }

    // Namespace zurich_util
    // Params 3
    // Checksum 0xaff7d2f5, Offset: 0xa810
    // Size: 0x7d, Type: dev
    function function_68a764f6( n_radius, v_color, e_owner )
    {
        if ( !isdefined( n_radius ) )
        {
            n_radius = 64;
        }
        
        if ( !isdefined( v_color ) )
        {
            v_color = ( 0, 1, 0 );
        }
        
        if ( !isdefined( e_owner ) )
        {
            e_owner = self;
        }
        
        self endon( #"hash_5322c93b" );
        
        while ( isdefined( self ) )
        {
            recordsphere( self.origin, n_radius, v_color, "<dev string:x1ea>", e_owner );
            wait 0.05;
        }
    }

    // Namespace zurich_util
    // Params 3
    // Checksum 0xa622e89a, Offset: 0xa898
    // Size: 0x6d, Type: dev
    function function_ff016910( str_text, v_color, e_owner )
    {
        if ( !isdefined( v_color ) )
        {
            v_color = ( 0, 1, 0 );
        }
        
        if ( !isdefined( e_owner ) )
        {
            e_owner = self;
        }
        
        self endon( #"hash_8fba9" );
        
        while ( isdefined( self ) )
        {
            record3dtext( str_text, self.origin, v_color, "<dev string:x1ea>", e_owner );
            wait 0.05;
        }
    }

    // Namespace zurich_util
    // Params 0
    // Checksum 0xb9198ec0, Offset: 0xa910
    // Size: 0xf, Type: dev
    function debug_player_damage()
    {
        self endon( #"death" );
    }

    // Namespace zurich_util
    // Params 0
    // Checksum 0x40475e66, Offset: 0xa928
    // Size: 0x135, Type: dev
    function function_c118d07d()
    {
        self endon( #"death" );
        
        while ( true )
        {
            self waittill( #"damage", n_damage, e_attacker, v_direction, v_point, str_type, str_tagname, str_modelname, str_partname, w_weapon );
            str_class = "<dev string:x1f1>";
            
            if ( !isdefined( str_type ) )
            {
                str_type = "<dev string:x1f1>";
            }
            
            if ( isentity( e_attacker ) )
            {
                str_class = e_attacker.classname;
                
                if ( str_class === "<dev string:x1f9>" )
                {
                    str_class = e_attacker.scriptvehicletype;
                }
                
                self thread function_4363773d( e_attacker, v_point, n_damage, str_class, str_type );
            }
            
            iprintln( "<dev string:x208>" + n_damage );
            iprintln( "<dev string:x211>" + str_class );
            iprintln( "<dev string:x21c>" + str_type );
        }
    }

    // Namespace zurich_util
    // Params 5
    // Checksum 0x2967f377, Offset: 0xaa68
    // Size: 0x23d, Type: dev
    function function_4363773d( e_attacker, v_hit, n_damage, str_class, str_type )
    {
        self endon( #"damage" );
        self endon( #"death" );
        var_7cc4d7ae = e_attacker.origin;
        v_player_pos = self.origin;
        var_ba43239b = e_attacker gettagorigin( "<dev string:x223>" );
        
        if ( !isdefined( var_ba43239b ) )
        {
            var_ba43239b = e_attacker.origin;
        }
        
        var_b19349be = distance( var_ba43239b, v_hit );
        
        while ( true )
        {
            record3dtext( "<dev string:x211>" + str_class, var_ba43239b + ( 0, 0, 8 ), ( 1, 0, 0 ), "<dev string:x1ea>", self );
            record3dtext( "<dev string:x208>" + n_damage, var_ba43239b, ( 1, 0, 0 ), "<dev string:x1ea>", self );
            record3dtext( "<dev string:x21c>" + str_type, var_ba43239b + ( 0, 0, -8 ), ( 1, 0, 0 ), "<dev string:x1ea>", self );
            record3dtext( "<dev string:x22d>" + var_b19349be, var_ba43239b + ( 0, 0, -16 ), ( 1, 0, 0 ), "<dev string:x1ea>", self );
            recordcircle( var_7cc4d7ae, 32, ( 1, 0, 0 ), "<dev string:x1ea>", self );
            recordcircle( v_player_pos, 32, ( 0, 1, 0 ), "<dev string:x1ea>", self );
            recordsphere( var_ba43239b, 6, ( 1, 0, 0 ), "<dev string:x1ea>", self );
            recordsphere( v_hit, 6, ( 1, 1, 0 ), "<dev string:x1ea>", self );
            recordline( var_ba43239b, v_hit, ( 1, 0, 0 ), "<dev string:x1ea>", self );
            
            if ( isdefined( e_attacker ) )
            {
                recordcircle( e_attacker.origin, 24, ( 1, 1, 0 ), "<dev string:x1ea>", self );
                recordline( var_7cc4d7ae, e_attacker.origin, ( 1, 1, 0 ), "<dev string:x1ea>", self );
            }
            
            wait 0.05;
        }
    }

#/
