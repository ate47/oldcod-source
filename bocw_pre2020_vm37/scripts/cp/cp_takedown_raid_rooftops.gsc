#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_3626f1b2cf51a99c;
#using script_3dc93ca9902a9cda;
#using script_5431e074c1428743;
#using script_61cfc2ab8e60625;
#using script_9bfd3d8a6a89e5e;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_takedown_raid_bar;
#using scripts\cp\cp_takedown_raid_slide;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace tkdn_raid_roof;

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 1
// Checksum 0x6237e995, Offset: 0x8f0
// Size: 0x36c
function starting( *var_d3440450 )
{
    var_8a3bb97c = getspawnerarray( "raid_adler", "targetname" );
    var_8a3bb97c[ 0 ] spawner::add_spawn_function( &namespace_b100dd86::function_9109a1fe );
    woods_spawner = getspawnerarray( "raid_woods", "targetname" );
    woods_spawner[ 0 ] spawner::add_spawn_function( &namespace_b100dd86::function_87d56d50 );
    level.adler = var_8a3bb97c[ 0 ] spawner::spawn( 1 );
    level.woods = woods_spawner[ 0 ] spawner::spawn( 1 );
    var_fcbd93e0 = struct::get( "raid_roof_adler", "targetname" );
    var_1100faeb = struct::get( "raid_roof_woods", "targetname" );
    level.adler forceteleport( var_fcbd93e0.origin, var_fcbd93e0.angles );
    level.woods forceteleport( var_1100faeb.origin, var_1100faeb.angles );
    player = getplayers()[ 0 ];
    var_5ca6956f = getweapon( #"ar_accurate_t9" );
    var_a3379ef0 = getweapon( #"ar_accurate_t9" );
    level.woods setweapon( var_a3379ef0 );
    level.adler setweapon( var_5ca6956f );
    player giveweapon( var_5ca6956f );
    player switchtoweapon( var_5ca6956f );
    var_d1a2cc43 = getspawnerarray( "qasim_runner", "script_noteworthy" );
    
    foreach ( spawner in var_d1a2cc43 )
    {
        spawner spawner::add_spawn_function( &namespace_b100dd86::function_6578b894 );
    }
    
    thread objectives::scripted( "obj_takedown_capture", undefined, #"hash_49c1d860c97e3792" );
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 2
// Checksum 0xe8734fbb, Offset: 0xc68
// Size: 0x134
function main( var_d3440450, *var_50cc0d4f )
{
    player = getplayers()[ 0 ];
    var_6097a10b = getspawnerarray( "qasim_vault", "targetname" );
    var_6097a10b[ 0 ] spawner::add_spawn_function( &function_a1d9cae0 );
    level thread takedown_tutorial();
    level thread function_fb0dffdf();
    level thread rooftop_vo();
    self util::blend_movespeedscale( 0.85, 1 );
    level flag::wait_till( "raid_roof_complete" );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0x6cdc49ed, Offset: 0xda8
// Size: 0x3f4
function takedown_tutorial()
{
    player = getplayers()[ 0 ];
    level thread function_aec55b72();
    level flag::wait_till( "flag_takedown_tutorial_player_mantling" );
    player val::set( #"takedown_tutorial", "allow_sprint", 0 );
    player util::delay( 1, undefined, &val::set, #"takedown_tutorial", "freezecontrols", 1 );
    level thread scene::play( "scene_tkd_hit2_apt_takedown_tutorial" );
    player playgestureviewmodel( #"hash_320d152af1fadd63", undefined, 1, 1, 0, 1, 1 );
    wait 1.25;
    level thread scene::stop( "scene_tkd_hit2_apt_takedown_tutorial" );
    player notifyonplayercommand( "melee_release", "-melee_zoom" );
    player notifyonplayercommand( "melee_release", "-melee_zoom" );
    hint_tutorial::function_4c2d4fc4( #"hash_e67c810a4c45083", #"hash_4f8907e75463e084", undefined, #"hash_1ecd2c8aa801c050" );
    hint_tutorial::pause( "+melee_zoom;", #"hash_8caf8fed0686143", 2 );
    body_shield = 0;
    
    if ( player meleebuttonpressed() )
    {
        ret = player waittilltimeout( 0.15, #"melee_release" );
        body_shield = ret._notify == "timeout";
    }
    
    if ( body_shield )
    {
        if ( isdefined( player.takedown.potential_victims ) && player.takedown.potential_victims.size > 0 )
        {
            player namespace_6cecf2d8::function_e3e4c03c( undefined, player.takedown.potential_victims[ 0 ] );
            player thread actions::function_1c027741( "body_shield" );
        }
    }
    else if ( isdefined( player.takedown.potential_victims ) && player.takedown.potential_victims.size > 0 )
    {
        player namespace_9c83b58d::function_3bab44ea( level.player_actions.actions[ #"takedown" ] );
        player thread actions::function_1c027741( "takedown" );
    }
    
    namespace_b100dd86::function_53531f27( "trig_start_rooftop_combat" );
    player val::reset( #"takedown_tutorial", "allow_sprint" );
    player val::reset( #"takedown_tutorial", "freezecontrols" );
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 2
// Checksum 0x1bd21e65, Offset: 0x11a8
// Size: 0x34
function function_d6a2486( command, flag )
{
    self waittill( command );
    self flag::set( flag );
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0x889a9ace, Offset: 0x11e8
// Size: 0xaa
function function_aec55b72()
{
    level.var_d6f941c8 = 0;
    
    while ( true )
    {
        if ( flag::get( "flag_listen_for_mantle" ) && level.var_d6f941c8 == 0 )
        {
            level thread function_c39dde0e();
        }
        else if ( flag::get( "flag_clear_listen_for_mantle" ) )
        {
            level.var_d6f941c8 = 0;
            level notify( #"hash_34688d2980137bca" );
        }
        
        waitframe( 1 );
    }
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0xe4e29a1f, Offset: 0x12a0
// Size: 0xae
function function_c39dde0e()
{
    player = getplayers()[ 0 ];
    level.var_d6f941c8 = 1;
    level endon( #"hash_34688d2980137bca" );
    
    while ( true )
    {
        if ( player ismantling() && !player flag::get( "body_shield_active" ) )
        {
            level flag::set( "flag_takedown_tutorial_player_mantling" );
        }
        
        waitframe( 1 );
    }
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0xc94a1fb2, Offset: 0x1358
// Size: 0x594
function function_fb0dffdf()
{
    level scene::init( "scene_tkd_hit2_roof_chase_enemy_spawn_01" );
    level scene::init( "scene_tkd_hit2_roof_chase_enemy_spawn_03" );
    level flag::wait_till( "flag_enemy_before_rooftop" );
    ai_spawned = spawner::simple_spawn_single( "dude_before_roof" );
    ai_spawned.var_c681e4c1 = 1;
    var_23811abd = snd::play( "vox_cp_tdwn_04200_irg2_fuckingamerican_9b", [ ai_spawned, "j_head" ] );
    slide_guy1 = getspawnerarray( "slide_guy1", "script_noteworthy" );
    array::run_all( slide_guy1, &spawner::add_spawn_function, &function_4ae05934 );
    slide_guy2 = getspawnerarray( "slide_guy2", "script_noteworthy" );
    array::run_all( slide_guy2, &spawner::add_spawn_function, &function_5d9afea9 );
    var_35447b42 = getspawnerarray( "rooftop_door_guy1", "targetname" );
    array::run_all( var_35447b42, &spawner::add_spawn_function, &function_f57c8f19 );
    level flag::wait_till( "flag_qasim_on_roof" );
    level flag::wait_till( "flag_start_rooftop_combat" );
    level.adler ai::set_behavior_attribute( "demeanor", "combat" );
    level.woods ai::set_behavior_attribute( "demeanor", "combat" );
    var_8c129dc2 = array_spawn_targetname( "initial_rooftop_guys" );
    level thread function_8ddafa22( var_8c129dc2, "trig_rooftop_combat", undefined );
    level flag::wait_till( "flag_rooftop_combat_wave2" );
    var_3d1b4310 = array_spawn_targetname( "rootop_ledge_guys" );
    
    foreach ( guy in var_3d1b4310 )
    {
        guy.ignoresuppression = 1;
    }
    
    level thread function_8ddafa22( var_3d1b4310, "trig_rooftop_combat_wave3", "trig_colors_roof1", 1 );
    level flag::wait_till( "flag_rooftop_combat_wave3" );
    var_158599d4 = array_spawn_targetname( "rootop_wave3_guys" );
    
    foreach ( guy in var_158599d4 )
    {
        guy.ignoresuppression = 1;
    }
    
    level thread function_29f2624a( "rooftop_wave3a", "trig_colors_roof3a", undefined, 1 );
    level flag::wait_till( "flag_colors_roof3a" );
    level thread function_29f2624a( "rooftop_wave3b", "trig_colors_roof3b", undefined, 1 );
    level flag::wait_till( "flag_colors_roof3b" );
    var_70b55036 = array_spawn_targetname( "rootop_wave4_guys" );
    
    foreach ( guy in var_70b55036 )
    {
        guy.ignoresuppression = 1;
    }
    
    level thread function_8ddafa22( var_70b55036, "trig_colors_roof4" );
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0x48e479e9, Offset: 0x18f8
// Size: 0x94
function function_4ae05934()
{
    player = getplayers()[ 0 ];
    self endon( #"death" );
    level thread scene::play( "scene_tkd_hit2_roof_chase_enemy_spawn_01", "Shot 1" );
    self waittill( #"finished_slide" );
    self ai::set_goal( "vol_first_roof", "targetname" );
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0x7327d7a2, Offset: 0x1998
// Size: 0x94
function function_5d9afea9()
{
    player = getplayers()[ 0 ];
    self endon( #"death" );
    level thread scene::play( "scene_tkd_hit2_roof_chase_enemy_spawn_02", "Shot 1" );
    self waittill( #"finished_slide" );
    self ai::set_goal( "vol_last_rooftop", "targetname" );
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0xf653b6d0, Offset: 0x1a38
// Size: 0x74
function function_f57c8f19()
{
    level thread scene::play( "scene_tkd_hit2_roof_chase_enemy_spawn_03", "Shot 1" );
    self waittill( #"finished_slide" );
    self.fixednode = 1;
    self ai::set_goal( "rooftop_guy1_node", "targetname" );
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0xe7f8e84f, Offset: 0x1ab8
// Size: 0x24
function function_90288964()
{
    self animation::set_death_anim( "sdr_com_exposed_stand_death01_midbody_sm_8" );
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 1
// Checksum 0xc6400721, Offset: 0x1ae8
// Size: 0x5a
function array_spawn_targetname( targetname )
{
    spawners = getspawnerarray( targetname, "targetname" );
    ai = spawner::simple_spawn( spawners );
    return ai;
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0x99f804ed, Offset: 0x1b50
// Size: 0x224
function function_a1d9cae0()
{
    self thread namespace_b100dd86::function_a0f1fa27();
    level notify( #"hash_530a04ce72c2c9" );
    objectives::follow( "obj_takedown_qasim", self, undefined, undefined, 0, #"hash_29f1e9a2d045faaf" );
    self val::set( #"qasim", "ignoreall", 1 );
    self val::set( #"qasim", "ignoreme", 1 );
    self.forcesprint = 1;
    self disableaimassist();
    lmg = getweapon( #"lmg_light_t9" );
    self setweapon( lmg );
    self thread namespace_b100dd86::set_ignoreall();
    self thread namespace_b100dd86::function_b1518d0e();
    level flag::wait_till( "flag_qasim_flees_last_roof" );
    level thread scene::play( "scene_tkd_hit2_qasim_vault", "Vault" );
    self waittill( #"end_vault" );
    objectives::remove( "obj_takedown_qasim" );
    self notify( #"hash_637416a1c8f37fe3" );
    self deletedelay();
    level thread namespace_b100dd86::function_a3c6d04c();
    level thread namespace_b100dd86::function_c212022b( 15 );
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 4
// Checksum 0x466a6215, Offset: 0x1d80
// Size: 0xfc
function function_8ddafa22( array, trigger, var_cc856f8d, var_c550e48f )
{
    if ( isdefined( var_cc856f8d ) )
    {
        var_bb96f34c = getent( var_cc856f8d, "targetname" );
    }
    
    function_1eaaceab( array );
    
    if ( array.size > 0 )
    {
        if ( isdefined( var_c550e48f ) )
        {
            level ai::waittill_dead( array, array.size - var_c550e48f );
        }
        else
        {
            level ai::waittill_dead( array, array.size );
        }
    }
    
    namespace_b100dd86::function_53531f27( trigger );
    
    if ( isdefined( var_bb96f34c ) )
    {
        var_bb96f34c delete();
    }
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 5
// Checksum 0xefa1a48f, Offset: 0x1e88
// Size: 0x134
function function_29f2624a( aigroup, trigger, var_cc856f8d, var_c550e48f, delay )
{
    if ( isdefined( var_cc856f8d ) )
    {
        var_bb96f34c = getent( var_cc856f8d, "targetname" );
    }
    
    aienemies = getaiarray( aigroup, "script_aigroup" );
    function_1eaaceab( aienemies );
    
    if ( aienemies.size > 0 )
    {
        if ( isdefined( var_c550e48f ) )
        {
            level ai::waittill_dead( aienemies, aienemies.size - var_c550e48f );
        }
        else
        {
            level ai::waittill_dead( aienemies, aienemies.size );
        }
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    namespace_b100dd86::function_53531f27( trigger );
    
    if ( isdefined( var_bb96f34c ) )
    {
        var_bb96f34c delete();
    }
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0x95130886, Offset: 0x1fc8
// Size: 0x15c
function rooftop_vo()
{
    level thread function_6d063272();
    wait 1;
    level.adler dialogue::queue( "vox_cp_tdwn_03800_adlr_weneedqasimaliv_e5" );
    level flag::wait_till( "flag_qasim_is_fast" );
    wait 2;
    level.adler dialogue::queue( "vox_cp_tdwn_04100_adlr_hesboltingkeepo_86" );
    level.woods dialogue::queue( "vox_cp_tdwn_04100_wood_jesusthisguyisf_42" );
    level flag::wait_till( "flag_rooftop_combat_wave3" );
    wait 4;
    level.adler dialogue::queue( "vox_cp_tdwn_03800_adlr_theresqasim_a2" );
    level flag::wait_till( "flag_colors_roof3b" );
    wait 7;
    level.adler dialogue::queue( "vox_cp_tdwn_03800_adlr_watchitwoodswen_b4" );
    level.woods dialogue::queue( "vox_cp_tdwn_03800_wood_youworrytoomuch_0d" );
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0xe8eaa1f2, Offset: 0x2130
// Size: 0x158
function function_6d063272()
{
    level endon( #"hash_5f84172c70d1eb4c" );
    
    while ( true )
    {
        wait randomintrange( 8, 10 );
        level.adler dialogue::queue( "vox_cp_tdwn_04100_adlr_movemove_9d" );
        wait randomintrange( 8, 10 );
        level.adler dialogue::queue( "vox_cp_tdwn_03800_adlr_gogo_f9" );
        wait randomintrange( 11, 14 );
        level.adler dialogue::queue( "vox_cp_tdwn_03800_adlr_hurryup_40" );
        wait randomintrange( 8, 10 );
        level.adler dialogue::queue( "vox_cp_tdwn_04100_adlr_letsgocomeon_86" );
        wait randomintrange( 11, 14 );
        level.adler dialogue::queue( "vox_cp_tdwn_04100_adlr_qasimcantescape_7b" );
        wait randomintrange( 8, 10 );
    }
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 4
// Checksum 0x86d516d0, Offset: 0x2290
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0xae821132, Offset: 0x22c0
// Size: 0x24
function init_flags()
{
    level flag::init( "raid_apt_complete" );
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0x80f724d1, Offset: 0x22f0
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace tkdn_raid_roof/cp_takedown_raid_rooftops
// Params 0
// Checksum 0x80f724d1, Offset: 0x2300
// Size: 0x4
function function_22b7fffd()
{
    
}

