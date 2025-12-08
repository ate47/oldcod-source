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
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snipercam;
#using scripts\cp_common\util;

#namespace duga_ambush;

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 1
// Checksum 0x17001055, Offset: 0x580
// Size: 0x17c
function starting( *str_objective )
{
    a_actors = [];
    
    if ( isdefined( level.var_deda09e ) )
    {
        level namespace_ac5221d7::function_ed760ecb( namespace_ac5221d7::function_7b37895() );
    }
    
    level namespace_ac5221d7::function_ed760ecb( "woods" );
    level namespace_ac5221d7::function_ed760ecb( "mason" );
    level namespace_ac5221d7::function_ed760ecb( "adler" );
    e_player = getplayers()[ 0 ];
    e_player thread val::set( #"hold_fire", "disable_weapon_fire", 1 );
    level.var_574a6d1a = spawner::simple_spawn( "spawners_us_forces_intro" );
    array::thread_all( level.allies, &colors::disable );
    level.adler val::set( #"ambush", "ignoreme", 1 );
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 2
// Checksum 0x986227ae, Offset: 0x708
// Size: 0xec
function main( str_objective, *b_skipto )
{
    level thread spawn_funcs();
    level thread objectives();
    level thread function_c8e55c36();
    waitframe( 3 );
    level thread function_d5f016b9();
    level thread combat();
    level flag::wait_till( "flag_ambush_complete" );
    trigger::use( "trigger_last_perseus_color", "targetname" );
    skipto::function_4e3ab877( b_skipto );
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 4
// Checksum 0xeb545ed3, Offset: 0x800
// Size: 0x44
function cleanup( *name, *starting, *direct, *player )
{
    level flag::set( "flag_ambush_complete" );
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 0
// Checksum 0x5130728b, Offset: 0x850
// Size: 0x8c
function objectives()
{
    level flag::wait_till( "flag_getup_complete" );
    objectives::scripted( "obj_ambush", undefined, #"hash_739277ddb7cc806" );
    level flag::wait_till( "flag_ambush_complete" );
    objectives::complete( "obj_ambush", undefined, 1 );
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 0
// Checksum 0xd967853c, Offset: 0x8e8
// Size: 0xdc
function ambush_vehicles()
{
    level flag::wait_till( #"hash_496251d9eeea009" );
    gunship = vehicle::simple_spawn_single_and_drive( "perseus_gunship" );
    gunship setteam( #"allies" );
    gunship setrotorspeed( 1 );
    level flag::wait_till( "flag_play_gunship_sound" );
    obj = snd::play( "tmp_veh_helicopter_flyby_close_slow", gunship );
    snd::stop_on_ent_death( obj, gunship );
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 0
// Checksum 0x1e0e25cd, Offset: 0x9d0
// Size: 0x358
function function_c8e55c36()
{
    level.var_9a7fa939 = spawner::simple_spawn( "spawner_perseus_forces" );
    array::thread_all( level.var_9a7fa939, &ai::set_goal, "vol_perseus_guys_1", "targetname" );
    level.var_a01307ee = spawner::simple_spawn( "spawner_perseus_forces_ambience" );
    array::run_all( level.var_a01307ee, &setteam, #"allies" );
    array::thread_all( level.var_a01307ee, &util::magic_bullet_shield );
    level waittill( #"hash_3a1e61f4b8c22889" );
    
    foreach ( guy in level.var_574a6d1a )
    {
        if ( isdefined( guy ) && isalive( guy ) )
        {
            guy setcandamage( 1 );
            guy delete();
        }
    }
    
    foreach ( guy in level.allies )
    {
        guy val::reset_all( #"hash_4cf5e706fc89474b" );
        guy setcandamage( 1 );
    }
    
    level thread colors::function_4156cb7d( "r", #"allies" );
    level thread colors::function_4156cb7d( "r", #"axis" );
    var_c5735292 = getnodearray( "nd_disable_for_combat", "script_noteworthy" );
    
    foreach ( n in var_c5735292 )
    {
        setenablenode( n, 0 );
    }
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 0
// Checksum 0x70c33870, Offset: 0xd30
// Size: 0x56c
function combat()
{
    level.var_8d67230a = spawner::simple_spawn( "spawners_us_forces" );
    level thread function_58a5048();
    a_heroes = [];
    a_heroes[ a_heroes.size ] = spawner::simple_spawn_single( "ambush_hero_woods" );
    a_heroes[ a_heroes.size ] = spawner::simple_spawn_single( "ambush_hero_mason" );
    
    if ( isdefined( level.var_deda09e ) )
    {
        a_heroes[ a_heroes.size ] = spawner::simple_spawn_single( "ambush_safehouse_hero_" + level.var_deda09e );
    }
    
    array::run_all( a_heroes, &setteam, #"axis" );
    array::thread_all( a_heroes, &snipercam::set_enabled, 1 );
    
    foreach ( guy in a_heroes )
    {
        guy.var_8a3fb9e2 = 100;
        var_f95b722f = "obj_duga_hero_kill_" + guy.targetname;
        guy thread objectives::kill( var_f95b722f, guy );
        
        switch ( guy.targetname )
        {
            case #"ambush_hero_woods":
                objectives::function_67f87f80( var_f95b722f, guy, #"hash_19b8d38e0f3b4a7b" );
                break;
            case #"ambush_hero_mason":
                objectives::function_67f87f80( var_f95b722f, guy, #"hash_6406649fc8fbed87" );
                break;
            case #"hash_479849dc827c578b":
                objectives::function_67f87f80( var_f95b722f, guy, #"hash_6d82fbc8379ff4a7" );
                break;
            case #"hash_26630c1ef7708da5":
                objectives::function_67f87f80( var_f95b722f, guy, #"hash_1ce5d2e21e8f8b51" );
                break;
        }
    }
    
    level thread namespace_ac5221d7::function_cfc94b81( level.var_8d67230a, int( level.var_8d67230a.size * 0.5 ), "flag_street_retreat" );
    level flag::wait_till( "flag_street_retreat" );
    function_1eaaceab( level.var_8d67230a );
    array::thread_all( level.var_8d67230a, &namespace_ac5221d7::function_603d935, "vol_heroes_street" );
    var_f39fa7e2 = spawner::simple_spawn( "spawners_us_forces_wave_2" );
    level.var_8d67230a = arraycombine( level.var_8d67230a, var_f39fa7e2 );
    level thread namespace_ac5221d7::function_cfc94b81( level.var_8d67230a, int( level.var_8d67230a.size * 0.6 ), "flag_building_retreat" );
    level flag::wait_till( "flag_building_retreat" );
    function_1eaaceab( level.var_8d67230a );
    array::thread_all( level.var_8d67230a, &namespace_ac5221d7::function_603d935, "vol_heroes_laststand" );
    var_2a4d953d = spawner::simple_spawn( "spawners_us_forces_wave_3" );
    level.var_8d67230a = arraycombine( level.var_8d67230a, var_2a4d953d );
    function_1eaaceab( a_heroes );
    
    if ( a_heroes.size )
    {
        level.var_8d67230a = arraycombine( level.var_8d67230a, a_heroes );
    }
    
    level thread namespace_ac5221d7::function_cfc94b81( level.var_8d67230a, level.var_8d67230a.size, "flag_ambush_complete" );
    level flag::wait_till( "flag_ambush_complete" );
    ai::waittill_dead_or_dying( a_heroes );
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 0
// Checksum 0xf965cc58, Offset: 0x12a8
// Size: 0x28c
function function_58a5048()
{
    level flag::wait_till( "flag_getup_complete" );
    var_2c3de56f = spawner::get_ai_group_ai( "perseus_ai" );
    array::thread_all( level.var_9a7fa939, &ai::enable_careful );
    array::thread_all( level.var_9a7fa939, &colors::set_force_color, "y" );
    
    foreach ( guy in level.var_9a7fa939 )
    {
        guy.fixednodesaferadius = 500;
    }
    
    trigger::use( "trig_perseus_colors_first", "targetname" );
    level.perseus dialogue::queue( "vox_cp_duga_01300_pers_notimetowasteco_4c" );
    level flag::wait_till( "flag_street_retreat" );
    var_d3eaca6b = [ "vox_cp_duga_01300_pers_pushthemback_40", "vox_cp_duga_01300_pers_nomercy_1e", "vox_cp_duga_01300_pers_laughforthemoth_59", "vox_cp_duga_01300_pers_forward_f6" ];
    var_c4c06aca = array::random( var_d3eaca6b );
    level.perseus dialogue::queue( var_c4c06aca );
    level flag::wait_till( "flag_building_retreat" );
    var_1026ae9b = var_c4c06aca;
    
    while ( var_1026ae9b === var_c4c06aca )
    {
        var_1026ae9b = array::random( var_d3eaca6b );
        waitframe( 1 );
    }
    
    var_c4c06aca = var_1026ae9b;
    level.perseus dialogue::queue( var_c4c06aca );
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 0
// Checksum 0x38202b35, Offset: 0x1540
// Size: 0xc4
function spawn_funcs()
{
    spawner::add_spawn_function_group( "spawner_perseus_forces", "targetname", &function_e41a9c12 );
    spawner::add_spawn_function_group( "spawners_us_forces", "targetname", &function_7369d400 );
    spawner::add_spawn_function_group( "spawners_us_forces_wave_2", "targetname", &function_7369d400 );
    spawner::add_spawn_function_group( "spawners_us_forces_wave_3", "targetname", &function_7369d400 );
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 0
// Checksum 0x3d6e6374, Offset: 0x1610
// Size: 0x112
function function_e41a9c12()
{
    self endon( #"death" );
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
    
    self val::set( #"ambush", "goalradius", 256 );
    self.script_accuracy = 0.1;
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 0
// Checksum 0x26bbed52, Offset: 0x1730
// Size: 0x24
function function_7369d400()
{
    self setteam( #"axis" );
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 0
// Checksum 0x6f10c660, Offset: 0x1760
// Size: 0x324
function function_d5f016b9()
{
    e_player = getplayers()[ 0 ];
    e_player val::set( #"hash_74901644ca8bb461", "freezecontrols", 1 );
    e_player val::set( #"hash_74901644ca8bb461", "ignoreme", 1 );
    e_player val::set( #"hash_74901644ca8bb461", "allow_melee", 0 );
    a_actors = [ level.woods, level.mason, level.adler, e_player ];
    
    if ( isdefined( level.var_deda09e ) )
    {
        array::add( a_actors, level.var_c1881cdd );
    }
    
    a_actors = arraycombine( level.var_9a7fa939, a_actors );
    scene::add_scene_func( "scene_duga_ambush", &function_3524b1f1 );
    scene::function_d0d7d9f7( "scene_duga_ambush", &namespace_ac5221d7::function_6f94ced5 );
    namespace_82bfe441::fade( 1, "FadeImmediate" );
    level thread namespace_e1ccb37b::function_e062d70c();
    level.player thread function_6915ba82();
    level scene::play( "scene_duga_ambush", "ambush", a_actors );
    level flag::set( "flag_getup_complete" );
    level thread namespace_e1ccb37b::function_1890889d();
    e_player namespace_ac5221d7::function_a22db743();
    e_player val::reset( #"hold_fire", "disable_weapon_fire" );
    e_player val::reset_all( #"hash_74901644ca8bb461" );
    e_player val::reset_all( #"hash_2e97aa66c8fb4309" );
    e_player showcrosshair( 1 );
    battlechatter::function_2ab9360b( 1 );
    namespace_82bfe441::fade( 0, "FadeMedium" );
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 1
// Checksum 0xa76c5165, Offset: 0x1a90
// Size: 0x44
function function_3524b1f1( a_ents )
{
    level.perseus = a_ents[ #"perseus" ];
    level.perseus util::magic_bullet_shield();
}

// Namespace duga_ambush/cp_rus_duga_ambush
// Params 0
// Checksum 0x120440cb, Offset: 0x1ae0
// Size: 0x74
function function_6915ba82()
{
    self waittill( #"hash_546aaa958caa6862" );
    level.player clientfield::set_to_player( "pstfx_slow_motion", 1 );
    self waittill( #"hash_38606eb71a01a2cc" );
    level.player clientfield::set_to_player( "pstfx_slow_motion", 0 );
}

