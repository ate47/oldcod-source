#using script_26850092de25d970;
#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_3dc93ca9902a9cda;
#using script_61cfc2ab8e60625;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_takedown_fx;
#using scripts\cp\cp_takedown_raid_bar;
#using scripts\cp\cp_takedown_raid_rooftops;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace tkdn_raid_apt;

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 1
// Checksum 0xecfb6bc1, Offset: 0x8a0
// Size: 0x474
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
    level.var_efac709f = getent( "player_breach_clip", "targetname" );
    level.var_efac709f disconnectpaths();
    alley_clip = getent( "alley_clip", "targetname" );
    alley_clip delete();
    player = getplayers()[ 0 ];
    player util::delay( 0.25, undefined, &val::set, #"hash_2136bbeceb4d9800", "low_ready", 1 );
    self util::blend_movespeedscale( 0.75, 1 );
    var_5ca6956f = getweapon( #"ar_accurate_t9" );
    var_a3379ef0 = getweapon( #"ar_accurate_t9" );
    w_pistol = getweapon( #"pistol_semiauto_t9" );
    level.woods setweapon( var_a3379ef0 );
    level.adler setweapon( var_5ca6956f );
    level thread scene::init_streamer( #"scene_tkd_hit2_intro_bar_v2", getplayers() );
    level thread scene::init( "scene_tkd_hit2_bar_alley" );
    level thread scene::init( "scene_tkd_hit2_adler_alley" );
    level thread scene::play_from_time( "scene_tkd_hit2_bar_alley", "alley", undefined, 25.5, 0, 1 );
    level thread scene::play( "scene_tkd_hit2_adler_alley", "Yard" );
    level thread function_a6a40606();
    thread objectives::scripted( "obj_takedown_capture", undefined, #"hash_49c1d860c97e3792" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 2
// Checksum 0xeb9bd5a6, Offset: 0xd20
// Size: 0x41c
function main( var_d3440450, *var_50cc0d4f )
{
    level.player = getplayers()[ 0 ];
    battlechatter::function_2ab9360b( 0 );
    var_d1a2cc43 = getspawnerarray( "qasim_runner", "script_noteworthy" );
    
    foreach ( spawner in var_d1a2cc43 )
    {
        spawner spawner::add_spawn_function( &namespace_b100dd86::function_6578b894 );
    }
    
    var_a68fc54f = getspawnerarray( "runner_guys", "script_noteworthy" );
    
    foreach ( spawner in var_a68fc54f )
    {
        spawner spawner::add_spawn_function( &function_719a1d22 );
    }
    
    var_d7e0979c = getspawnerarray( "kitchen_guys", "script_aigroup" );
    
    foreach ( spawner in var_d7e0979c )
    {
        spawner spawner::add_spawn_function( &function_306807e5 );
    }
    
    var_f10203a3 = getspawnerarray( "set_no_context_melee", "script_noteworthy" );
    
    foreach ( spawner in var_f10203a3 )
    {
        spawner spawner::add_spawn_function( &set_no_context_melee );
    }
    
    videostop( "multiple_screens_v2" );
    level thread scene::play( "scene_tkd_hit2_bar_alley", "Enemy_Waiting" );
    level thread function_a6a40606();
    level.player thread function_a8e1bcc4();
    wait 1;
    level thread function_7eba1826();
    videostart( "1981_Dutch_soccer_game_1", 1 );
    level flag::wait_till( "raid_apt_complete" );
    videostop( "1981_Dutch_soccer_game_1" );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x6151c12d, Offset: 0x1148
// Size: 0x12
function set_no_context_melee()
{
    self.var_c681e4c1 = 1;
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x3bded797, Offset: 0x1168
// Size: 0x114
function function_7eba1826()
{
    destructibles = getentarray( "destructible", "targetname" );
    
    for ( i = 0; i < destructibles.size ; i++ )
    {
        if ( destructibles[ i ].destructibledef == "p9_ams_light_hanging_billiard_01_ddef" )
        {
            var_bee3fe47 = destructibles[ i ];
            var_bee3fe47 cp_takedown_fx::function_d1dc8e50();
            var_bee3fe47 cp_takedown_fx::function_7eba1826();
        }
    }
    
    var_4560a8a1 = getentarray( "tkd_ams_pool_bake_light", "targetname" );
    
    for ( i = 0; i < var_4560a8a1.size ; i++ )
    {
        var_4d574e31 = var_4560a8a1[ i ];
        var_4d574e31 setlightintensity( 0 );
    }
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x443a7c30, Offset: 0x1288
// Size: 0x43c
function function_a8e1bcc4()
{
    level flag::wait_till( "flag_setup_apartment_combat" );
    self thread function_c71b0701();
    level scene::init( "scene_tkd_hit2_apt_door_kick" );
    level thread player_told_shoot();
    level thread function_20215540();
    self thread function_c3919cdc();
    level thread function_8c4bd0ee();
    self thread function_85249ea7();
    level thread function_486a4628();
    level waittill( #"hash_218ae3aa673068a9" );
    level notify( #"hash_2d7f82360e399f87" );
    level.var_efac709f connectpaths();
    level.var_efac709f delete();
    
    if ( level flag::get( "flag_player_told_shoot" ) )
    {
        level notify( #"hash_3117f5e88beab534" );
        level thread scene::play( "scene_tkd_hit2_bar_alley", "enemy_react" );
        level scene::stop( "scene_tkd_hit2_adler_alley" );
        level thread scene::play( "scene_tkd_hit2_bar_alley", "Apt_Breach" );
        wait 0.1;
        namespace_b100dd86::function_53531f27( "trig_adler_advance_inside_apt" );
        namespace_b100dd86::function_53531f27( "trig_woods_advance_inside_apt" );
    }
    else
    {
        level notify( #"hash_413da1fbc645aa20" );
        level scene::stop( "scene_tkd_hit2_bar_alley" );
        level thread scene::play( "scene_tkd_hit2_bar_alley", "enemy_react_failsafe" );
        level scene::stop( "scene_tkd_hit2_adler_alley" );
        namespace_b100dd86::function_53531f27( "trig_adler_advance_inside_apt" );
        namespace_b100dd86::function_53531f27( "trig_woods_advance_inside_apt" );
    }
    
    self util::blend_movespeedscale( 0.75, 0.5 );
    exploder::exploder( "hit2_kitchen_papers" );
    thread function_aeaba0c9( "pool_table_mb_pos", "pool_table_mb_dest", 1 );
    namespace_a052577e::function_1dc92e4f();
    wait 1;
    var_a79e4694 = snd::play( "vox_cp_tdwn_03750_adlr_gogogo_c5", [ level.adler, "j_head" ] );
    level thread scene::play( "scene_tkd_hit2_apt_door_kick", "start" );
    battlechatter::function_2ab9360b( 0 );
    wait 1;
    util::delay( 2, undefined, &exploder::exploder, "hit2_pool_table_papers" );
    level thread function_596afdef();
    thread namespace_a052577e::function_f8f5f970();
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x5f9145f5, Offset: 0x16d0
// Size: 0x84
function function_c71b0701()
{
    level flag::wait_till( "flag_player_lowready_apt" );
    self val::reset( #"hash_2136bbeceb4d9800", "low_ready" );
    self enableoffhandweapons();
    self clientfield::set_to_player( "lerp_fov", 0 );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x24b4f422, Offset: 0x1760
// Size: 0x3c
function function_20215540()
{
    level waittill( #"adler_through_gate" );
    level flag::set( "flag_adler_through_gate" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x329090f8, Offset: 0x17a8
// Size: 0x4c
function function_486a4628()
{
    level flag::wait_till( "flag_player_near_kitchen" );
    level scene::play( "scene_tkd_hit2_adler_alley", "gate_closed" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0xbe39d49d, Offset: 0x1800
// Size: 0x30
function function_c3919cdc()
{
    self waittill( #"weapon_fired" );
    level notify( #"hash_218ae3aa673068a9" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x8d13081a, Offset: 0x1838
// Size: 0x30
function function_8c4bd0ee()
{
    level waittill( #"glass_smash" );
    level notify( #"hash_218ae3aa673068a9" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0xc5b7acf0, Offset: 0x1870
// Size: 0x70
function function_85249ea7()
{
    waitresult = self waittill( #"grenade_fire" );
    grenade = waitresult.projectile;
    grenade waittill( #"explode" );
    level notify( #"hash_218ae3aa673068a9" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 3
// Checksum 0xe71f249e, Offset: 0x18e8
// Size: 0xbc
function function_aeaba0c9( pos, dest, delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    var_b84b1bf9 = struct::get( pos, "targetname" );
    var_c19f5c0 = struct::get( dest, "targetname" );
    magicbullet( getweapon( #"ar_standard_t9" ), var_b84b1bf9.origin, var_c19f5c0.origin );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0xf78fb5c3, Offset: 0x19b0
// Size: 0x34
function function_1a76e609()
{
    self waittill( #"hash_28b7423e81461973" );
    namespace_b100dd86::function_53531f27( "trig_adler_advance_inside_apt" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x7fb45f2e, Offset: 0x19f0
// Size: 0x34
function function_25e67322()
{
    self waittill( #"hash_65b683531e7136d1" );
    namespace_b100dd86::function_53531f27( "trig_woods_advance_inside_apt" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x1e81db3e, Offset: 0x1a30
// Size: 0x1ac
function function_306807e5()
{
    self endon( #"death" );
    self endon( #"hash_10622d7e7f80ce71" );
    self.var_c681e4c1 = 1;
    
    if ( self.script_noteworthy == "kitchen_enemy4" )
    {
        level.kitchen_enemy4 = self;
    }
    
    self thread function_5ba83448();
    level waittill( #"hash_2d7f82360e399f87" );
    wait 2;
    self notify( #"hash_72d5a2c9e1d7ed8a" );
    self val::set( #"kitchen_guy", "takedamage", 1 );
    self val::set( #"kitchen_guy", "allowdeath", 1 );
    self.health = 1;
    
    if ( level flag::get( "flag_player_told_shoot" ) )
    {
        self util::delay( randomfloatrange( 1.8, 2.7 ), undefined, &function_629b5919 );
        return;
    }
    
    self util::delay( randomfloatrange( 5, 6.5 ), undefined, &function_629b5919 );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x2c4aba9e, Offset: 0x1be8
// Size: 0x34
function function_629b5919()
{
    if ( !is_true( self.in_melee_death ) )
    {
        self kill();
    }
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0xcde43bc7, Offset: 0x1c28
// Size: 0x1b4
function function_5ba83448()
{
    self endon( #"hash_72d5a2c9e1d7ed8a" );
    self.health = 999;
    result = self waittill( #"damage", #"takedown_begin" );
    
    if ( result._notify === "damage" )
    {
        self val::set( #"kitchen_guy", "takedamage", 0 );
        self val::set( #"kitchen_guy", "allowdeath", 0 );
        scene = "scene_tkd_hit2_bar_alley";
        
        if ( self.script_noteworthy == "kitchen_enemy1" )
        {
            self thread function_8dac85e( scene, "Enemy_Death_1" );
        }
        
        if ( self.script_noteworthy == "kitchen_enemy2" )
        {
            self thread function_8dac85e( scene, "Enemy_Death_2" );
        }
        
        if ( self.script_noteworthy == "kitchen_enemy3" )
        {
            self thread function_8dac85e( scene, "Enemy_Death_3" );
        }
        
        if ( self.script_noteworthy == "kitchen_enemy4" )
        {
            self thread function_8dac85e( scene, "Enemy_Death_4" );
        }
    }
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 4
// Checksum 0x791e1e1a, Offset: 0x1de8
// Size: 0xac
function function_8dac85e( scene, var_a3671203, *var_5505b07f, *loop )
{
    self notify( #"hash_10622d7e7f80ce71" );
    level.player playhitmarker( undefined, 5, undefined, 1 );
    level thread scene::play( var_5505b07f, loop, self );
    self val::set( #"kitchen_guy", "ignoreme", 1 );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0xbc69e013, Offset: 0x1ea0
// Size: 0x76
function function_719a1d22()
{
    self endon( #"death" );
    self.pacifist = 1;
    self.health = 1;
    self ai::set_behavior_attribute( "sprint", 1 );
    self waittill( #"reached_path_end" );
    self.pacifist = 0;
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x421082bd, Offset: 0x1f20
// Size: 0x158
function player_told_shoot()
{
    player = getplayers()[ 0 ];
    level endon( #"hash_413da1fbc645aa20" );
    level endon( #"hash_2d7f82360e399f87" );
    level flag::wait_till( "flag_player_told_shoot" );
    level waittill( #"hash_67f0f350991bdaf4" );
    
    while ( true )
    {
        wait 8;
        var_23811abd = snd::play( "vox_cp_tdwn_03750_adlr_masonletemknowt_75", [ level.adler, "j_head" ] );
        snd::function_2fdc4fb( var_23811abd );
        wait 4;
        var_23811abd = snd::play( "vox_cp_tdwn_03750_adlr_onyoumason_b2", [ level.adler, "j_head" ] );
        snd::function_2fdc4fb( var_23811abd );
    }
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x80bd4433, Offset: 0x2080
// Size: 0x3c
function function_a6a40606()
{
    level waittill( #"player_told_shoot" );
    level flag::set( "flag_player_told_shoot" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0xfadd2820, Offset: 0x20c8
// Size: 0x20c
function function_596afdef()
{
    level.adler ai::set_behavior_attribute( "demeanor", "combat" );
    level.woods ai::set_behavior_attribute( "demeanor", "combat" );
    var_f3ebe39 = ai::array_spawn( "floor1_guys" );
    
    foreach ( guy in var_f3ebe39 )
    {
        guy.var_c681e4c1 = 1;
    }
    
    level thread function_801d630c();
    level thread function_5547ef8b();
    level thread left_flank();
    qasim_runner = getspawnerarray( "qasim_stairs", "targetname" );
    qasim = qasim_runner[ 0 ] spawner::spawn( 1 );
    qasim function_917872db();
    level thread flag::wait_till( "flag_qasim_stairs" );
    level.adler ai::set_behavior_attribute( "demeanor", "cqb" );
    level.woods ai::set_behavior_attribute( "demeanor", "cqb" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x2a0f227d, Offset: 0x22e0
// Size: 0x54
function left_flank()
{
    level flag::wait_till( "flag_left_flank" );
    level thread tkdn_raid_roof::function_29f2624a( "floor1_enemies_flank", "trig_apt_wave2", undefined, undefined, 0.1 );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x55d02aea, Offset: 0x2340
// Size: 0x174
function function_917872db()
{
    self endon( #"death" );
    self thread namespace_b100dd86::function_a0f1fa27();
    objectives::follow( "obj_takedown_qasim", self, undefined, undefined, 0, #"hash_29f1e9a2d045faaf" );
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.forcesprint = 1;
    self disableaimassist();
    level scene::play( "scene_tkd_hit2_qasim_stairs", "Wait" );
    level flag::set( "flag_qasim_stairs" );
    level thread scene::play( "scene_tkd_hit2_qasim_stairs", "Stairs" );
    self waittill( #"hash_36d3b51f9158ec8" );
    level thread namespace_b100dd86::function_c212022b( 45 );
    objectives::remove( "obj_takedown_qasim" );
    self notify( #"hash_637416a1c8f37fe3" );
    self deletedelay();
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x74a4c58, Offset: 0x24c0
// Size: 0x184
function function_801d630c()
{
    level scene::init( "scene_tkd_hit2_apt_blindfire_bathroom" );
    guy = getactorarray( "apt_blindfire_bathroom", "targetname" )[ 0 ];
    guy.health = 999;
    guy.var_c681e4c1 = 1;
    level flag::wait_till( "flag_blindfire_bathroom" );
    level thread function_5001b9be();
    guy thread function_d068d0f8();
    level thread scene::play( "scene_tkd_hit2_apt_blindfire_bathroom", "start" );
    guy waittill( #"damage" );
    level.player playhitmarker( undefined, 5, undefined, 1 );
    guy notsolid();
    level scene::play( "scene_tkd_hit2_apt_blindfire_bathroom", "death" );
    guy notify( #"play_death" );
    guy kill();
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0xca1359e, Offset: 0x2650
// Size: 0x74
function function_d068d0f8()
{
    self endon( #"play_death" );
    level flag::wait_till( "raid_apt_complete" );
    level scene::play( "scene_tkd_hit2_apt_blindfire_bathroom", "death" );
    self kill();
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0xc6bddc9d, Offset: 0x26d0
// Size: 0x44
function function_5001b9be()
{
    level flag::wait_till( "flag_close_to_blindfire_guy" );
    thread function_aeaba0c9( "blindfire_mb_pos", "blindfire_mb_dest" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x4f5023b4, Offset: 0x2720
// Size: 0xfc
function function_5547ef8b()
{
    level.adler dialogue::queue( "vox_cp_tdwn_03800_adlr_theresqasim_a2" );
    wait 1;
    level.adler dialogue::queue( "vox_cp_tdwn_03750_wood_comeonmason_ec" );
    level flag::wait_till( "flag_qasim_stairs" );
    wait 2;
    level.adler dialogue::queue( "vox_cp_tdwn_03800_adlr_qasimsheadedupt_21" );
    level flag::wait_till( "flag_near_apt_stairs" );
    level.adler dialogue::queue( "vox_cp_tdwn_03800_adlr_findhim_00" );
    wait 1.5;
    level.adler dialogue::queue( "vox_cp_tdwn_04100_adlr_qasimcantescape_7b" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 4
// Checksum 0x29fdd80d, Offset: 0x2828
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0xcb8810f9, Offset: 0x2858
// Size: 0x24
function init_flags()
{
    level flag::init( "raid_apt_complete" );
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x80f724d1, Offset: 0x2888
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace tkdn_raid_apt/cp_takedown_raid_apt
// Params 0
// Checksum 0x80f724d1, Offset: 0x2898
// Size: 0x4
function function_22b7fffd()
{
    
}

