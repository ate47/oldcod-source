#using script_210ec734a4149bac;
#using script_3c70d86dfe255354;
#using script_3dc93ca9902a9cda;
#using script_6f92dbd09c4e8204;
#using script_758226507b1afa11;
#using script_7e8d968512a21e26;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_ger_stakeout_fx;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;

#namespace namespace_acaa3a2e;

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x94266d8f, Offset: 0x10e0
// Size: 0x164
function init_flags()
{
    level flag::init( "fade_in_rooftop_door_amb" );
    level flag::init( "saw_kraus" );
    level flag::init( "used_binocs" );
    level flag::init( "sign_spotlight_away" );
    level flag::init( "start_camera_hints" );
    level flag::init( "at_street_overlook" );
    level flag::init( "identify_kraus_done" );
    level flag::init( "rooftop_vo_done" );
    level flag::init( "wall_done" );
    level flag::init( "street_player_captured" );
    level flag::init( "kraus_reached_bar" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x71db6793, Offset: 0x1250
// Size: 0xa4
function function_22b7fffd()
{
    animation::add_notetrack_func( "cp_ger_stakeout_wall::assign_my_umbrella", &function_39369cca );
    scene::add_scene_func( "aib_vign_stakeout_harass_check_papers", &function_5e77e85, "play" );
    var_cbd9930a = getentarray( "checkpoint_trunk_props", "targetname" );
    array::run_all( var_cbd9930a, &hide );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0xcf83dfae, Offset: 0x1300
// Size: 0x54
function wall_start( *str_objective )
{
    util::function_268bdf4f( "adler", &namespace_11998b8f::function_2f0f0a84 );
    level flag::set( "start_berlin_wall_lighting" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 2
// Checksum 0x66b99692, Offset: 0x1360
// Size: 0x314
function function_cca0368( *str_objective, var_50cc0d4f )
{
    scene::add_scene_func( "aib_vign_stakeout_wall_gl", &function_a23963d2, "wall_start" );
    scene::add_scene_func( "aib_vign_stakeout_wall_gl", &function_ba702467, "wall_acroof" );
    player = getplayers()[ 0 ];
    
    if ( var_50cc0d4f )
    {
        level scene::init( "aib_vign_stakeout_wall_alley_door" );
        namespace_11998b8f::function_cdb7cc7e();
        player namespace_979752dc::set_disguised( 1 );
        player setmovespeedscale( 0.72 );
        level.var_6eed8aea = 0;
    }
    
    level thread namespace_11998b8f::function_de88eefd();
    level.var_4e5a623b = 1;
    level thread wall_adler();
    level thread function_713528d5();
    level thread identify_kraus();
    level thread function_e76b838d();
    level thread function_11a4c23();
    level thread function_13778421();
    level thread function_3fae1e4a();
    level thread namespace_5ceacc03::function_ddb87390();
    level flag::wait_till( "move_wall_allies_01" );
    player val::reset( "sewer_exit", "allow_melee" );
    level flag::wait_till( "move_wall_allies_01a" );
    savegame::checkpoint_save();
    level flag::wait_till_all( array( "player_at_street_overlook", "ally_at_street_overlook" ) );
    level flag::set( "at_street_overlook" );
    level thread music::function_edda155f( "4.0_rooftops_stinger_2" );
    level flag::set( "wall_done" );
    skipto::function_4e3ab877( "wall" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 4
// Checksum 0x8bec6b10, Offset: 0x1680
// Size: 0x6c
function function_f39fdd43( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( player )
    {
        level flag::set( "climbed_out_of_sewer" );
        level flag::set( "at_street_overlook" );
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x737fdf64, Offset: 0x16f8
// Size: 0x34
function function_a23963d2( a_ents )
{
    namespace_3aaa42f7::function_d1bc79a0( "adler_alley_door", a_ents[ #"hash_475ee55621b83ca0" ] );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x5e2d7c08, Offset: 0x1738
// Size: 0x34
function function_ba702467( a_ents )
{
    namespace_3aaa42f7::function_d1bc79a0( "adler_roof_door1", a_ents[ #"hash_475ee55621b83ca0" ] );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0xa05a9639, Offset: 0x1778
// Size: 0x7c
function wall_adler()
{
    level.adler val::set( "wall_adler", "ignoreall", 1 );
    level.adler val::set( "wall_adler", "ignoreme", 1 );
    level thread function_7ad62e4();
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x15c7e715, Offset: 0x1800
// Size: 0x304
function function_7ad62e4()
{
    level flag::wait_till( "go_in_roof_door" );
    level scene::stop( "aib_vign_stakeout_wall_alley_door" );
    level scene::play( "aib_vign_stakeout_wall_gl", "wall_start" );
    level thread scene::play( "aib_vign_stakeout_wall_gl", "wall_door_loop" );
    level flag::wait_till_all( array( "move_wall_allies_01a", "approach_spotlight_done" ) );
    scene::add_scene_func( "aib_vign_stakeout_street_rooftop_descend", &namespace_dd1bf157::function_bd064da5, "init" );
    level scene::init( "aib_vign_stakeout_street_rooftop_descend" );
    level thread music::function_edda155f( "4.0_rooftops_stinger_1" );
    level flag::set( "fade_in_rooftop_door_amb" );
    level thread namespace_5ceacc03::function_bc932ea6();
    snd::play( "amb_thunder_rumble" );
    level thread namespace_3e1df757::function_fafe48ab();
    level notify( #"hash_7bbbeb96c2b3efcd" );
    level scene::play( "aib_vign_stakeout_wall_gl", "wall_acroof" );
    
    if ( !level flag::get( "move_wall_allies_02" ) )
    {
        level thread scene::play( "aib_vign_stakeout_wall_gl", "wall_roof_wait_in" );
        wait 7;
        level flag::wait_till( "move_wall_allies_02" );
        level scene::play( "aib_vign_stakeout_wall_gl", "wall_roof_wait_out" );
    }
    else
    {
        level scene::play( "aib_vign_stakeout_wall_gl", "wall_roof_goahead" );
    }
    
    level scene::play( "aib_vign_stakeout_wall_gl", "wall_finish" );
    level.adler setgoal( level.adler.origin );
    level thread scene::play( "aib_vign_stakeout_wall_gl", "wall_finish_loop" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0xf2b9a83b, Offset: 0x1b10
// Size: 0x24c
function function_713528d5( skipto )
{
    level thread function_4fbe7d07();
    level thread function_a673fa00( skipto );
    
    if ( !is_true( skipto ) )
    {
        level flag::wait_till( "move_wall_allies_02a" );
    }
    
    level thread namespace_dd1bf157::function_16806e9();
    
    if ( !is_true( skipto ) )
    {
        level flag::wait_till( "start_umbrella_civ_01" );
    }
    
    scene::add_scene_func( "scene_z_stk_wall_umbrella_civs", &function_5e77e85, "play" );
    scene::add_scene_func( "scene_z_stk_wall_umbrella_civs", &function_c15c5894, "done" );
    level thread scene::play( "scene_z_stk_wall_umbrella_civs" );
    
    if ( !is_true( skipto ) )
    {
        level thread checkpoint_scene();
    }
    else
    {
        level thread checkpoint_scene( skipto );
    }
    
    if ( !is_true( skipto ) )
    {
        level flag::wait_till( "start_umbrella_civ_02" );
    }
    
    scene::add_scene_func( "scene_z_stk_wall_umbrella_civs2", &function_5e77e85, "play" );
    scene::add_scene_func( "scene_z_stk_wall_umbrella_civs2", &function_c15c5894, "done" );
    level thread scene::play( "scene_z_stk_wall_umbrella_civs2" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x54f745ff, Offset: 0x1d68
// Size: 0x154
function function_4fbe7d07()
{
    spawner::add_spawn_function_group( "wall_enemies", "targetname", &function_6a048393 );
    spawner::add_spawn_function_group( "wall_tower_enemies", "targetname", &function_6a048393 );
    level flag::wait_till( "move_wall_allies_01a" );
    level.wall_enemies = spawner::simple_spawn( "wall_enemies" );
    level.wall_tower_enemies = spawner::simple_spawn( "wall_tower_enemies" );
    level scene::init( "scene_z_stk_tower_patrol", level.wall_tower_enemies );
    level flag::wait_till( "move_wall_allies_02a" );
    level scene::play( "scene_z_stk_tower_patrol", level.wall_tower_enemies );
    level flag::set( "move_tower_patrol" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x7a6e0b70, Offset: 0x1ec8
// Size: 0x176
function function_6a048393()
{
    self endon( #"death" );
    self stealth_enemy::set_blind( 1 );
    self.holdfire = 1;
    self thread function_fadf5523( "checkpoint" );
    
    if ( self.script_noteworthy === "flashlight_guy" )
    {
        self.flashlightoverride = 1;
    }
    
    if ( self.script_noteworthy === "flashlight_idle" )
    {
        scripted_node = struct::get( self.target, "targetname" );
        self flashlight::function_65e5c8c8( 1 );
        self.flashlightfxoverridetag = "tag_light";
        self flashlight::function_7c2f623b();
        scripted_node thread scene::play( "aib_vign_stakeout_wall_flashlight_idle", "flashlight_idle_1" );
        return;
    }
    
    if ( isdefined( self.target ) )
    {
        scripted_node = struct::get( self.target, "targetname" );
        
        if ( isdefined( scripted_node.animation ) )
        {
            if ( !isdefined( self.animname ) )
            {
                self.animname = "generic";
            }
        }
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0xa6c86236, Offset: 0x2048
// Size: 0x13c
function function_fadf5523( str_id )
{
    self endon( #"death" );
    level endon( #"street_done" );
    util::waittill_any_ents( self, "set_alert_level", self, "damage", level, "stealth_spotted" );
    level notify( #"street_car_scene_end" );
    self animation::stop();
    self val::reset( str_id, "ignoreall" );
    self val::reset( str_id, "ignoreme" );
    self val::reset( str_id, "allowdeath" );
    player = getplayers()[ 0 ];
    self function_a3fcf9e0( "attack", player, player.origin );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x8fb48764, Offset: 0x2190
// Size: 0xde
function function_39369cca( params )
{
    if ( isdefined( self.var_a0639f34 ) )
    {
        return;
    }
    
    if ( isdefined( params ) )
    {
        if ( isstring( params ) )
        {
            a_strings = strtok( params, "," );
        }
        
        self.var_a0639f34 = spawnstruct();
        self.var_a0639f34.name = undefined;
        self.var_a0639f34.hand = undefined;
        
        if ( isdefined( a_strings[ 0 ] ) )
        {
            self.var_a0639f34.name = a_strings[ 0 ];
        }
        
        if ( isdefined( a_strings[ 1 ] ) )
        {
            self.var_a0639f34.hand = a_strings[ 1 ];
        }
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0xff9c7bae, Offset: 0x2278
// Size: 0xf0
function function_5e77e85( a_ents )
{
    foreach ( actor in a_ents )
    {
        if ( isactor( actor ) )
        {
            if ( !isdefined( actor.animname ) || isdefined( actor.animname ) && !issubstr( actor.animname, "guard" ) )
            {
                actor thread function_106c684b( a_ents );
            }
        }
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0xdc2a0f8a, Offset: 0x2370
// Size: 0x54
function function_c15c5894( a_ents )
{
    if ( level flag::get_any( array( "stealth_spotted", "street_umbrella_drop" ) ) )
    {
        return;
    }
    
    array::delete_all( a_ents );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0xe566ccd2, Offset: 0x23d0
// Size: 0x314
function function_106c684b( a_ents )
{
    self endon( #"death" );
    level endon( #"street_done" );
    util::waittill_any_ents( self, "damage", level, "street_car_scene_end" );
    level flag::set( "street_umbrella_drop" );
    
    if ( self.health == self.maxhealth )
    {
        wait randomfloatrange( 0.1, 1 );
    }
    
    self thread cp_ger_stakeout_fx::function_a2a2a7e9();
    self animation::stop();
    
    if ( isdefined( self.var_a0639f34 ) && isdefined( self.var_a0639f34.name ) )
    {
        if ( is_true( self.var_a0639f34.hand == "left" ) )
        {
            anim_org = util::spawn_model( "tag_origin", self gettagorigin( "tag_accessory_left" ), self gettagangles( "tag_accessory_left" ) );
            
            if ( isarray( a_ents ) )
            {
                anim_org thread scene::play( "scene_z_stk_umbrella_left_drop", a_ents[ self.var_a0639f34.name ] );
            }
            else
            {
                anim_org thread scene::play( "scene_z_stk_umbrella_left_drop", a_ents );
            }
        }
        else
        {
            anim_org = util::spawn_model( "tag_origin", self gettagorigin( "tag_accessory_right" ), self gettagangles( "tag_accessory_right" ) );
            
            if ( isarray( a_ents ) )
            {
                anim_org thread scene::play( "scene_z_stk_umbrella_right_drop", a_ents[ self.var_a0639f34.name ] );
            }
            else
            {
                anim_org thread scene::play( "scene_z_stk_umbrella_right_drop", a_ents );
            }
        }
    }
    
    self ai::set_behavior_attribute( #"_civ_mode", "panic" );
    
    if ( !level flag::get( "stealth_spotted" ) )
    {
        level flag::set( "stealth_spotted" );
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0xb340220f, Offset: 0x26f0
// Size: 0xf4
function function_ecb49051()
{
    self endon( #"death" );
    level endon( #"street_done" );
    util::waittill_any_ents( self, "damage", level, "street_car_scene_end" );
    wait randomfloatrange( 0.1, 1 );
    self animation::stop();
    self ai::set_behavior_attribute( #"_civ_mode", "panic" );
    
    if ( !level flag::get( "stealth_spotted" ) )
    {
        level flag::set( "stealth_spotted" );
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x7701fb4c, Offset: 0x27f0
// Size: 0x124
function function_a673fa00( skipto )
{
    level endon( #"rooftop_done" );
    
    if ( !is_true( skipto ) )
    {
        level flag::wait_till( "move_wall_allies_01a" );
    }
    
    level flag::wait_till( "stealth_spotted" );
    player = getplayers()[ 0 ];
    player namespace_979752dc::set_disguised( 0 );
    level.adler dialogue::function_47b06180();
    
    if ( level flag::get( "rooftop_done" ) )
    {
        return;
    }
    
    wait 3;
    level util::missionfailedwrapper( #"hash_4c5af5a1cd80371", #"hash_4e9d4bf1d65f17f5" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x379acee8, Offset: 0x2920
// Size: 0x18c
function function_e76b838d( skipto )
{
    level thread namespace_11998b8f::function_2ba7047( "west_berlin_window_cards", 8, 20, "bar_done" );
    
    if ( !is_true( skipto ) )
    {
        level flag::wait_till( "move_wall_allies_01" );
    }
    
    level thread function_43de25e0();
    
    if ( !is_true( skipto ) )
    {
        level flag::wait_till( "move_wall_allies_01a" );
    }
    
    level thread function_ffb7e31d();
    
    if ( !is_true( skipto ) )
    {
        level flag::wait_till( "move_wall_allies_02a" );
    }
    
    level thread namespace_11998b8f::function_973a721b( "vista_car", "street_done" );
    var_da154b8a = struct::get_array( "wall_street_area_traffic_lights", "targetname" );
    array::thread_all( var_da154b8a, &namespace_11998b8f::function_f76805ab, "bar_done" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0xc7d5e001, Offset: 0x2ab8
// Size: 0x9c
function function_ffb7e31d()
{
    logo = getent( "vista_building_logo", "targetname" );
    
    while ( !level flag::get( "street_done" ) )
    {
        logo rotateyaw( 360, 30, 0, 0 );
        wait 30;
    }
    
    if ( isdefined( logo ) )
    {
        logo delete();
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0xff892217, Offset: 0x2b60
// Size: 0x19c
function function_43de25e0()
{
    scene::add_scene_func( "p9_fxanim_cp_stakeout_spotlights_rooftop_scripted_bundle", &function_9862307b, "Shot 1" );
    scene::add_scene_func( "p9_fxanim_cp_stakeout_spotlights_rooftop_scripted_bundle", &function_9862307b, "Shot 2" );
    scene::add_scene_func( "p9_fxanim_cp_stakeout_spotlights_rooftop_scripted_bundle", &function_becd1d99, "play" );
    scene::add_scene_func( "p9_fxanim_cp_stakeout_spotlights_rooftop_tower_01_bundle", &function_becd1d99, "play" );
    scene::add_scene_func( "p9_fxanim_cp_stakeout_spotlights_rooftop_tower_02_bundle", &function_becd1d99, "play" );
    scene::add_scene_func( "p9_fxanim_cp_stakeout_spotlights_rooftop_tower_03_bundle", &function_becd1d99, "play" );
    level thread scene::play( "p9_fxanim_cp_stakeout_spotlights_rooftop_tower_01_bundle" );
    level thread scene::play( "p9_fxanim_cp_stakeout_spotlights_rooftop_tower_02_bundle" );
    level thread scene::play( "p9_fxanim_cp_stakeout_spotlights_rooftop_tower_03_bundle" );
    level thread function_de07a5d6();
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x81c092aa, Offset: 0x2d08
// Size: 0x9e
function function_becd1d99( a_ents )
{
    foreach ( ent in a_ents )
    {
        ent setforcenocull();
        ent.script_objective = "street";
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x543ed0f6, Offset: 0x2db0
// Size: 0x5c
function function_9862307b( a_ents )
{
    if ( !isdefined( level.var_fef3d782 ) )
    {
        level.var_fef3d782 = a_ents[ #"prop 1" ];
        level.var_fef3d782 clientfield::set( "rooftop_spotlight", 1 );
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0xbc8fbaa1, Offset: 0x2e18
// Size: 0x17c
function function_de07a5d6()
{
    b_first_time = 1;
    
    while ( !level flag::get( "street_done" ) )
    {
        if ( !b_first_time )
        {
            wait randomintrange( 5, 7 );
        }
        
        level scene::play( "p9_fxanim_cp_stakeout_spotlights_rooftop_scripted_bundle", "Shot 2" );
        
        if ( !flag::get_all( array( "move_wall_allies_01a", "approach_spotlight_done" ) ) )
        {
            level flag::wait_till_all( array( "move_wall_allies_01a", "approach_spotlight_done" ) );
        }
        
        if ( b_first_time )
        {
            wait 3.5;
        }
        else
        {
            wait randomintrange( 5, 9 );
        }
        
        b_first_time = 0;
        level scene::play( "p9_fxanim_cp_stakeout_spotlights_rooftop_scripted_bundle", "Shot 1" );
    }
    
    if ( isdefined( level.var_fef3d782 ) )
    {
        level.var_fef3d782 clientfield::set( "rooftop_spotlight", 0 );
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0xde032d1, Offset: 0x2fa0
// Size: 0x7c
function function_11a4c23()
{
    level scene::init( "p9_fxanim_cp_stakeout_spotlight_roof_approach_bundle" );
    trigger::wait_till( "t_rooftop_spotlight_approach" );
    level scene::play( "p9_fxanim_cp_stakeout_spotlight_roof_approach_bundle" );
    wait 1;
    level flag::set( "approach_spotlight_done" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0xb3617385, Offset: 0x3028
// Size: 0x144
function function_13778421( skipto )
{
    if ( !is_true( skipto ) )
    {
        level flag::wait_till_all( array( "move_wall_allies_01a", "approach_spotlight_done" ) );
        level thread scene::play( "p9_fxanim_cp_stakeout_rooftop_pigeons_bundle" );
    }
    
    level thread scene::play( "p9_fxanim_cp_stakeout_tarp_rooftop_bundle" );
    level thread function_59b4c034();
    level thread scene::init( "rooftop_pigeons_ambient", "targetname" );
    level flag::wait_till( "player_in_bar" );
    level scene::stop( "rooftop_pigeons_ambient", "targetname", 1 );
    level scene::stop( "p9_fxanim_cp_stakeout_tarp_rooftop_bundle", 1 );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x613f8978, Offset: 0x3178
// Size: 0x64
function function_59b4c034()
{
    level thread scene::play( "p9_fxanim_cp_stakeout_rooftop_street_traffic_bundle" );
    level flag::wait_till( "player_left_warehouse_intro_vehicle" );
    level scene::stop( "p9_fxanim_cp_stakeout_rooftop_street_traffic_bundle", 1 );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0xe2894d94, Offset: 0x31e8
// Size: 0x1c
function function_3fae1e4a()
{
    level waittill( #"hash_91d8b090b6da8a9" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x8de65c5a, Offset: 0x3210
// Size: 0xfc
function rooftop_start( *str_objective )
{
    util::function_268bdf4f( "adler", &namespace_11998b8f::function_2f0f0a84 );
    level flag::set( "start_berlin_wall_lighting" );
    level thread scene::play( "aib_vign_stakeout_wall_gl", "wall_finish_loop" );
    level thread function_e76b838d( 1 );
    level thread function_13778421( 1 );
    scene::add_scene_func( "aib_vign_stakeout_street_rooftop_descend", &namespace_dd1bf157::function_bd064da5, "init" );
    level scene::init( "aib_vign_stakeout_street_rooftop_descend" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 2
// Checksum 0x932dfd43, Offset: 0x3318
// Size: 0x1fc
function rooftop_main( *str_objective, var_50cc0d4f )
{
    player = getplayers()[ 0 ];
    
    if ( var_50cc0d4f )
    {
        namespace_11998b8f::function_cdb7cc7e();
        level.adler val::set( "wall_adler", "ignoreall", 1 );
        level.adler val::set( "wall_adler", "ignoreme", 1 );
        level thread namespace_11998b8f::function_de88eefd();
        player namespace_979752dc::set_disguised( 1 );
        player setmovespeedscale( 0.72 );
        level.var_6eed8aea = 0;
        level.var_4e5a623b = 1;
        level thread function_713528d5( 1 );
        level thread identify_kraus( 1 );
    }
    
    level thread rooftop_vo();
    level flag::wait_till( "identify_kraus_done" );
    level thread function_85133ec9();
    level flag::wait_till( "rooftop_vo_done" );
    level flag::set( "rooftop_done" );
    skipto::function_4e3ab877( "rooftop" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x6fddd54e, Offset: 0x3520
// Size: 0x64
function function_85133ec9()
{
    level flag::wait_till( "flag_player_cleanup_wall" );
    
    if ( isdefined( level.wall_enemies ) )
    {
        array::thread_all( level.wall_enemies, &util::auto_delete, undefined, undefined, 1500 );
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 4
// Checksum 0x570dcc45, Offset: 0x3590
// Size: 0x4c
function rooftop_cleanup( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( player )
    {
        level flag::set( "identify_kraus_done" );
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x878aa798, Offset: 0x35e8
// Size: 0x4d4
function checkpoint_scene( skipto )
{
    civs = spawner::simple_spawn( "cp_civ" );
    guards = spawner::simple_spawn( "cp_guard" );
    var_64be3b5a = util::spawn_anim_model( "vehicle_rus_civ_gaz_24_volga" );
    actors = arraycombine( civs, guards, 0, 0 );
    
    foreach ( actor in actors )
    {
        actor.animname = actor.script_noteworthy;
    }
    
    foreach ( guard in guards )
    {
        guard stealth_enemy::set_blind( 1 );
        guard thread function_fadf5523( "checkpoint_scene" );
        guard.holdfire = 1;
    }
    
    foreach ( civ in civs )
    {
        civ thread function_ecb49051();
    }
    
    if ( !isdefined( actors ) )
    {
        actors = [];
    }
    else if ( !isarray( actors ) )
    {
        actors = array( actors );
    }
    
    actors[ actors.size ] = var_64be3b5a;
    
    foreach ( actor in actors )
    {
        actor sethighdetail( 1 );
    }
    
    if ( !is_true( skipto ) )
    {
        level thread scene::init( "aib_vign_stakeout_wall_checkpoint_scene", actors );
        level flag::wait_till( "start_umbrella_civ_02" );
        level thread scene::play( "aib_vign_stakeout_wall_checkpoint_scene", actors );
        level waittill( #"hash_642ae3c5f89a9501" );
        var_cbd9930a = getentarray( "checkpoint_trunk_props", "targetname" );
        array::run_all( var_cbd9930a, &show );
        level flag::wait_till( "checkpoint_trunk_closed" );
        var_cbd9930a = getentarray( "checkpoint_trunk_props", "targetname" );
        array::run_all( var_cbd9930a, &delete );
    }
    else
    {
        level thread scene::init( "aib_vign_stakeout_wall_checkpoint_scene", actors );
        waitframe( 1 );
        level thread scene::play_from_time( "aib_vign_stakeout_wall_checkpoint_scene", actors, undefined, 78, 0 );
    }
    
    level flag::wait_till( "bar_done" );
    level scene::stop( "aib_vign_stakeout_wall_checkpoint_scene", 1 );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x66cad014, Offset: 0x3ac8
// Size: 0x194
function identify_kraus( skipto )
{
    level.checkpoint_question_guard = spawner::simple_spawn_single( "checkpoint_question_guard" );
    level.checkpoint_question_guard stealth_enemy::set_blind( 1 );
    level.checkpoint_question_guard.holdfire = 1;
    level.checkpoint_question_guard thread function_fadf5523( "checkpoint_scene" );
    player = getplayers()[ 0 ];
    level thread function_967ed4a( skipto );
    level flag::wait_till( "start_camera_hints" );
    player spy_camera::function_6de171e9();
    level thread function_32b46292();
    level flag::wait_till( "saw_kraus" );
    spy_camera::function_b28ab5a9( level.kraus );
    self notify( #"hash_2977cbecfddfcab6" );
    level thread namespace_3e1df757::function_dda7b522();
    level flag::set( "identify_kraus_done" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0xa9498d44, Offset: 0x3c68
// Size: 0x17c
function function_967ed4a( skipto )
{
    if ( !is_true( skipto ) )
    {
        level flag::wait_till( "at_street_overlook" );
    }
    
    level.kraus = spawner::simple_spawn_single( "kraus_cp_streets" );
    level.kraus val::set( "identify_kraus", "ignoreall", 1 );
    level.kraus val::set( "identify_kraus", "ignoreme", 1 );
    level.kraus thread function_3f531d4();
    level.kraus thread function_69f72ac5();
    level.kraus.name = "Kraus";
    level.kraus.goalradius = 24;
    spy_camera::function_f785d9e9( level.kraus, 1 );
    level.kraus thread namespace_11998b8f::function_d3e635a9( "saw_kraus", "photo_taken" );
    level.kraus thread function_11009074();
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x65eb1b9a, Offset: 0x3df0
// Size: 0x2fc
function function_11009074()
{
    level endon( #"mission_failed" );
    self endon( #"death" );
    level.checkpoint_question_anim_org = struct::get( "checkpoint_question_anim_org", "targetname" );
    self.animname = "kraus";
    self sethighdetail( 1 );
    level.checkpoint_question_guard sethighdetail( 1 );
    level.checkpoint_question_guard flashlight::function_bfffb3fe();
    self.var_34fc6abf = getent( "kraus_cp_umbrella", "targetname" );
    self.var_34fc6abf sethighdetail( 1 );
    self.var_34fc6abf.animname = "kraus_umbrella";
    self.briefcase = getent( "kraus_cp_briefcase", "targetname" );
    self.briefcase sethighdetail( 1 );
    self.briefcase.animname = "kraus_briefcase";
    level.kraus thread function_106c684b( self.var_34fc6abf );
    level thread scene::play( "aib_vign_stakeout_wall_checkpoint_question", "shot 1", array( self, level.checkpoint_question_guard, self.briefcase, self.var_34fc6abf ) );
    level flag::wait_till( "rooftop_vo_done" );
    wait 2;
    self util::delay( float( function_60d95f53() ) / 1000, "death", &function_aefb4fb1 );
    level.checkpoint_question_guard util::delay( float( function_60d95f53() ) / 1000, "death", &function_9c72e558 );
    level scene::play( "aib_vign_stakeout_wall_checkpoint_question", "exit", array( self, level.checkpoint_question_guard, self.briefcase, self.var_34fc6abf ) );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0xce6d1add, Offset: 0x40f8
// Size: 0x21c
function function_aefb4fb1()
{
    level endon( #"mission_failed" );
    self endon( #"death" );
    self thread function_bfd89ef1();
    self waittill( #"hash_e91490899d05716" );
    self sethighdetail( 0 );
    self.var_34fc6abf sethighdetail( 0 );
    self.var_34fc6abf hide();
    self.briefcase sethighdetail( 0 );
    self.briefcase hide();
    self.var_5b22d53 = 0;
    self flag::wait_till_clear( #"scriptedanim" );
    self namespace_f592a7b::function_7bd21c92( "UMBRELLA_LEFT_AND_BRIEFCASE_RIGHT" );
    goal = struct::get( "kraus_path_part_2", "targetname" );
    self thread spawner::go_to_node( goal );
    util::waittill_any_ents_two( level, "start_rooftop_descend_alley", self, "reached_path_end" );
    self namespace_f592a7b::function_7bd21c92( "NONE" );
    
    if ( isdefined( self.civilian_props ) )
    {
        array::delete_all( self.civilian_props );
        self.civilian_props = [];
    }
    
    self.var_34fc6abf show();
    self.briefcase show();
    self thread function_9a126ef9();
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x3b42fd, Offset: 0x4320
// Size: 0xdc
function function_9c72e558()
{
    level endon( #"mission_failed" );
    self endon( #"death" );
    self flag::wait_till_clear( #"scriptedanim" );
    self flashlight::function_65e5c8c8( 0 );
    struct = struct::get( "checkpoint_question_guard_spot_2", "targetname" );
    self thread spawner::go_to_node( struct );
    self sethighdetail( 0 );
    self stealth_enemy::set_blind( 0 );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0xff5fbb03, Offset: 0x4408
// Size: 0xb4
function function_e0855d12( a_ents )
{
    if ( !isdefined( level.var_74647f74 ) )
    {
        level.var_74647f74 = a_ents[ #"hash_5aa24d6a1d003dc2" ];
    }
    
    if ( !isdefined( level.var_c49f9f4d ) )
    {
        level.var_c49f9f4d = a_ents[ #"hash_3b179fbfb1dea828" ];
        level.var_c49f9f4d attach( "aac_kitchen_chair_01", "j_prop_1" );
        level.var_c49f9f4d attach( "stk_glass_beer_bottle_01", "j_prop_2" );
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x69d5771, Offset: 0x44c8
// Size: 0xbc
function function_ba06bd3a( a_ents )
{
    if ( !isdefined( level.var_c0e9c7c4 ) )
    {
        level.var_c0e9c7c4 = doors::function_73f09315( "bar_front_door" );
    }
    
    level.var_c0e9c7c4 linkto( a_ents[ #"hash_5aa24d6a1d003dc2" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    a_ents[ #"hash_5aa24d6a1d003dc2" ] flag::wait_till_clear( #"scriptedanim" );
    level.var_c0e9c7c4 unlink();
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x9042f035, Offset: 0x4590
// Size: 0x134
function function_bfd89ef1()
{
    level endon( #"mission_failed" );
    self endon( #"death" );
    player = getplayers()[ 0 ];
    player forcestreambundle( "cin_stakeout_wall_bar_enter" );
    scene::add_scene_func( "cin_stakeout_wall_bar_enter", &function_e0855d12, "init" );
    scene::add_scene_func( "cin_stakeout_wall_bar_enter", &function_ba06bd3a, "bar_dialogue_exit" );
    scene::add_scene_func( "cin_stakeout_wall_bar_enter", &function_ba06bd3a, "bar_enter" );
    level scene::init( "cin_stakeout_wall_bar_enter" );
    doors::function_f35467ac( "bar_front_door" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 1
// Checksum 0x10c34466, Offset: 0x46d0
// Size: 0x11c
function function_9a126ef9( str_id )
{
    level endon( #"mission_failed" );
    self endon( #"death" );
    
    if ( !isdefined( str_id ) || isdefined( str_id ) && str_id != "bar" )
    {
        level scene::play( "cin_stakeout_wall_bar_enter", "bar_enter", array( self, self.briefcase, self.var_34fc6abf ) );
    }
    
    level.var_c0e9c7c4 unlink();
    doors::function_f5dd4f8f( "bar_front_door" );
    level thread scene::play( "cin_stakeout_wall_bar_enter", "bar_enter_loop", array( self, self.briefcase, self.var_34fc6abf ) );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0xe16b255e, Offset: 0x47f8
// Size: 0x8c
function function_69f72ac5()
{
    level endon( #"flag_player_cleanup_wall" );
    s_waitresult = self waittill( #"death" );
    
    if ( isdefined( s_waitresult.attacker ) && s_waitresult.attacker === getplayers()[ 0 ] )
    {
        level thread function_cb0dcac();
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x806c57c9, Offset: 0x4890
// Size: 0xb0
function function_3f531d4()
{
    level endon( #"flag_player_cleanup_wall" );
    self endon( #"death" );
    
    while ( true )
    {
        s_waitresult = self waittill( #"damage" );
        
        if ( isdefined( s_waitresult.attacker ) && s_waitresult.attacker == getplayers()[ 0 ] )
        {
            level thread function_cb0dcac();
        }
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0xb73ae9ec, Offset: 0x4948
// Size: 0x64
function function_cb0dcac()
{
    getplayers()[ 0 ] endon( #"death" );
    wait 1;
    level util::missionfailedwrapper( #"hash_4c5af5a1cd80371", #"hash_4d106f3a6b13c1a" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x6519c5be, Offset: 0x49b8
// Size: 0xf4
function function_32b46292()
{
    player = getplayers()[ 0 ];
    level endon( #"saw_kraus" );
    player endon( #"death" );
    player function_7d7b4491();
    player thread function_5c4360e6();
    wait 0.1;
    player function_274a9831();
    wait 0.1;
    player function_3b103fbc();
    wait 0.1;
    
    if ( !flag::get( "saw_kraus" ) )
    {
        player function_44cd5336();
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x6cd881e8, Offset: 0x4ab8
// Size: 0x9c
function function_5c4360e6()
{
    level endon( #"saw_kraus" );
    level endon( #"identify_kraus_done" );
    wait 45;
    objectives::goto( "identify_kraus_pos", level.kraus.origin + ( 0, 0, 72 ), undefined, 0 );
    objectives::function_67f87f80( "identify_kraus_pos", undefined, #"hash_25690fa219cddf5a" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x76e6ff0c, Offset: 0x4b60
// Size: 0x4a
function function_7d7b4491()
{
    self util::show_hint_text( #"hash_549b99af44962dbf", undefined, "ability_activated_camera", 8 );
    self waittill( #"ability_activated_camera" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x501dabbd, Offset: 0x4bb8
// Size: 0x5c
function function_274a9831()
{
    level spy_camera::function_f91a82ef( 1, undefined, undefined, "enter_camera_ads" );
    self waittill( #"enter_camera_ads" );
    level spy_camera::function_f91a82ef( 0 );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x241e4334, Offset: 0x4c20
// Size: 0x7a
function function_3b103fbc()
{
    self endon( #"zoomed" );
    clientfield::set_to_player( "kraus_zoom_hint_start", 1 );
    wait 8;
    self util::show_hint_text( #"hash_70bca84d8e31e618", undefined, "zoomed", 8 );
    self waittill( #"zoomed" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 2
// Checksum 0xb3d93fcf, Offset: 0x4ca8
// Size: 0x58
function function_afc2d473( *oldval, newval )
{
    if ( newval )
    {
        player = getplayers()[ 0 ];
        player notify( #"zoomed" );
    }
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x8e03ebc0, Offset: 0x4d08
// Size: 0x64
function function_44cd5336()
{
    level endon( #"saw_kraus" );
    level.kraus waittill( #"hash_54596dc066040d8c" );
    self util::show_hint_text( #"hash_1b44f90418fbe7c6", undefined, "saw_kraus", 8 );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0x60e309c7, Offset: 0x4d78
// Size: 0x1dc
function rooftop_vo()
{
    level endon( #"stealth_spotted" );
    savegame::checkpoint_save();
    wait 1;
    level.adler dialogue::queue( "vox_cp_stkt_05100_adlr_keepaneyeonthat_23" );
    wait 1;
    level flag::set( "flag_give_camera" );
    level.adler dialogue::queue( "vox_cp_stkt_05100_adlr_lookforkrauswit_a4" );
    wait 0.5;
    level flag::set( "start_camera_hints" );
    level thread function_d5a5cf11();
    wait 4;
    level.adler dialogue::queue( "vox_cp_stkt_05100_adlr_damnsecuritysev_0b" );
    level flag::wait_till_timeout( 6, "saw_kraus" );
    
    if ( !level flag::get( "saw_kraus" ) )
    {
        level.adler dialogue::queue( "vox_cp_stkt_05100_adlr_nearthecheckpoi_3f" );
    }
    
    level flag::wait_till( "saw_kraus" );
    level.adler dialogue::queue( "vox_cp_stkt_05100_adlr_goodjobthatsour_e3" );
    wait 1;
    level flag::wait_till( "identify_kraus_done" );
    level flag::set( "rooftop_vo_done" );
}

// Namespace namespace_acaa3a2e/namespace_acaa3a2e
// Params 0
// Checksum 0xb5e6a102, Offset: 0x4f60
// Size: 0x1b8
function function_d5a5cf11()
{
    var_54ca8df4 = [];
    var_54ca8df4[ var_54ca8df4.size ] = "vox_cp_stkt_05100_adlr_thatsnotkraus_c4";
    var_54ca8df4[ var_54ca8df4.size ] = "vox_cp_stkt_05100_adlr_keeplooking_c6";
    var_54ca8df4[ var_54ca8df4.size ] = "vox_cp_stkt_05100_adlr_negative_61";
    var_54ca8df4[ var_54ca8df4.size ] = "vox_cp_stkt_05100_adlr_thatsnothim_fc";
    var_54ca8df4[ var_54ca8df4.size ] = "vox_cp_stkt_05100_adlr_krausdoesntlook_47";
    var_54ca8df4[ var_54ca8df4.size ] = "vox_cp_stkt_05100_adlr_notourguy_4a";
    var_54ca8df4[ var_54ca8df4.size ] = "vox_cp_stkt_05100_adlr_no_eb";
    feedback = arraycopy( var_54ca8df4 );
    var_8b6eeb37 = "vox_cp_stkt_05100_adlr_hesnotinuniform_d1";
    player = getplayers()[ 0 ];
    
    while ( true )
    {
        player waittill( #"take_picture" );
        wait 0.2;
        
        if ( !flag::get( "saw_kraus" ) )
        {
            if ( feedback.size == 0 )
            {
                feedback = arraycopy( var_54ca8df4 );
            }
            
            vo = array::random( feedback );
            arrayremovevalue( feedback, vo );
            level.adler dialogue::queue( vo );
            continue;
        }
        
        break;
    }
}

