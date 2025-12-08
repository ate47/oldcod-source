#using script_1b9f100b85b7e21d;
#using script_237e957844a8197c;
#using script_3dc93ca9902a9cda;
#using script_6b2490222adab2af;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\friendly;
#using scripts\core_common\stealth\neutral;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;

#namespace namespace_69b8cbbe;

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 1
// Checksum 0x6576c8ad, Offset: 0x618
// Size: 0x8c
function start( *str_objective )
{
    level hms_util::function_ee1d1df6( "park", "Park", "park_church_struct" );
    level hms_util::function_ee1d1df6( "lazar", "Lazar", "lazar_church_struct" );
    level.player setmovespeedscale( 0.85 );
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 2
// Checksum 0x4bcbdc59, Offset: 0x6b0
// Size: 0x294
function main( *str_objective, *var_50cc0d4f )
{
    /#
        hms_util::print( "<dev string:x38>" );
    #/
    
    level thread function_90611d3c();
    level thread function_ed8e64e1();
    level thread function_e1ea1ec2();
    level thread function_99e351b3();
    level hms_util::function_ee1d1df6( "adler", "Adler", "adler_plaza_struct", "plaza_squad_2_spawn_colors" );
    level hms_util::function_ee1d1df6( "mason", "Mason", "mason_plaza_struct" );
    level hms_util::function_ee1d1df6( "woods", "Woods", "woods_plaza_struct" );
    level thread namespace_a789f8ae::function_716ff5d8( "church" );
    savegame::checkpoint_save();
    level.park.ignoreall = 1;
    level.lazar.ignoreall = 1;
    level flag::wait_till( "flg_church_explosion" );
    level.park.ignoreall = 0;
    level.lazar.ignoreall = 0;
    var_322fd646 = struct::get( "ride_initial_explosion", "targetname" );
    var_5094cb26 = getent( "ride_sfx_ent", "targetname" );
    playfx( level._effect[ #"hash_5334c84fbd555272" ], var_322fd646.origin );
    earthquake( 0.5, 1, var_322fd646.origin, 2000 );
    snd::client_msg( "church_explosion_event" );
}

/#

    // Namespace namespace_69b8cbbe/namespace_69b8cbbe
    // Params 4
    // Checksum 0x350d1743, Offset: 0x950
    // Size: 0x44, Type: dev
    function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
    {
        hms_util::print( "<dev string:x4b>" );
    }

#/

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 0
// Checksum 0x112691d6, Offset: 0x9a0
// Size: 0x74
function function_ed8e64e1()
{
    var_b6ac0499 = struct::get( "s_church_objective", "targetname" );
    objectives::goto( "obj_church", var_b6ac0499.origin, #"hash_1c332385c05be388" );
    level thread function_a77ca5fc();
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 0
// Checksum 0xcc371c22, Offset: 0xa20
// Size: 0x3c
function function_a77ca5fc()
{
    level flag::wait_till( "flag_obj_church_done" );
    objectives::complete( "obj_church" );
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 0
// Checksum 0x9f3f40ff, Offset: 0xa68
// Size: 0x11c
function function_90611d3c()
{
    namespace_307260b8::function_2b6287f4( "church_allies_path_trigger" );
    level.lazar function_77316c32();
    level.park function_77316c32();
    var_39327768 = struct::get( "church_path_chain_1", "targetname" );
    var_5e3f4181 = struct::get( "church_path_chain_2", "targetname" );
    level.park spawner::function_461ce3e9();
    level.park thread spawner::go_to_struct( var_5e3f4181 );
    wait 0.15;
    level.lazar spawner::function_461ce3e9();
    level.lazar thread spawner::go_to_struct( var_39327768 );
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 0
// Checksum 0x26b22185, Offset: 0xb90
// Size: 0xbc
function function_77316c32()
{
    self setdesiredspeed( 250 );
    self.pushable = 0;
    self val::set( #"hash_5b20d1b59a41939d", "push_player", 1 );
    self ai::set_behavior_attribute( "vignette_mode", "fast" );
    self ai::set_behavior_attribute( "disablepeek", 1 );
    self ai::set_behavior_attribute( "disablelean", 1 );
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 1
// Checksum 0xa15ba8c7, Offset: 0xc58
// Size: 0xa4
function function_89d8a2ed( *s_info )
{
    if ( isdefined( self.go_to_node.script_noteworthy ) )
    {
        self ai::function_3a5e9945( 0 );
        var_bccd1cd = struct::get( self.go_to_node.script_noteworthy, "targetname" );
        self ai::poi_enable( 1, var_bccd1cd );
        return;
    }
    
    self ai::function_3a5e9945( 1 );
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 0
// Checksum 0x1cf1a4b1, Offset: 0xd08
// Size: 0x194
function function_e1ea1ec2()
{
    level.player endon( #"death" );
    level endon( #"flg_vo_church_done" );
    level flag::set( "flg_vo_ride_done" );
    var_e534dcb = struct::get( "ai_alder_radio", "targetname" );
    var_662759db = struct::get( "ai_woods_radio", "targetname" );
    level flag::wait_till( "flg_church_explosion_vo" );
    var_e534dcb hms_util::dialogue( "vox_cp_cbcr_01000_adlr_alrightwoodslig_e8", 1, "allies", "Adler" );
    wait 0.35;
    level flag::set( "flg_church_explosion" );
    wait 1;
    var_662759db hms_util::dialogue( "vox_cp_cbcr_01000_wood_boutfuckingtime_8b", 1, "allies", "Woods" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01100_park_gogogo_c5", undefined, "allies", "Park" );
    level thread function_9d00d19b();
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 0
// Checksum 0x904ddec3, Offset: 0xea8
// Size: 0xf8
function function_9d00d19b()
{
    level endon( #"flag_obj_church_done" );
    wait 10;
    var_ffbbfc35 = [];
    var_ffbbfc35[ 0 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01100_park_bellweneedtomov_33" );
    var_ffbbfc35[ 1 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01100_park_dothehonorsbell_b9" );
    var_ffbbfc35[ 2 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01100_park_kickopenthedoor_aa" );
    var_ffbbfc35[ 3 ] = hms_util::function_e1449992( level.lazar, "vox_cp_cbcr_01100_lazr_bellgetyourhead_f0" );
    
    while ( true )
    {
        hms_util::vo_knockout_manager( "cuban_church_nags", var_ffbbfc35 );
        wait 15;
    }
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 0
// Checksum 0xd433fb6f, Offset: 0xfa8
// Size: 0x17a
function function_eef92c2d()
{
    var_3ff42a2f = getent( "plaza_initial_guys_goal_volume", "targetname" );
    var_93e592a6 = getent( "plaza_shoot_at_pos_01", "targetname" );
    self setgoal( self.origin );
    self.goalradius = 16;
    self val::set( "church_plaza_playfight_guys", "takedamage", 0 );
    
    if ( isdefined( var_93e592a6 ) )
    {
        self thread ai::shoot_at_target( "normal", var_93e592a6, undefined, 20 );
    }
    
    level flag::wait_till( "flg_initial_plaza_guys_normal_combat" );
    
    if ( isalive( self ) )
    {
        self ai::stop_shoot_at_target();
        self val::set( "church_plaza_playfight_guys", "takedamage", 1 );
        self setgoal( var_3ff42a2f );
        self.goalradius = 250;
    }
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 0
// Checksum 0xacc92530, Offset: 0x1130
// Size: 0x9c
function function_350051ea()
{
    self val::set( "church_plaza_playfight_guys", "takedamage", 0 );
    level flag::wait_till( "flg_initial_plaza_guys_normal_combat" );
    
    if ( isalive( self ) )
    {
        self.script_forcecolor = "g";
        self val::set( "church_plaza_playfight_guys", "takedamage", 1 );
    }
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 0
// Checksum 0x258d1b90, Offset: 0x11d8
// Size: 0xa4
function function_12e2740f()
{
    var_a38a8f8c = struct::get( "plaza_grenade_origin", "targetname" );
    var_1fb4acab = struct::get( "plaza_grenade_target", "targetname" );
    var_e94a1e39 = spawner::simple_spawn( "molotov_victim_guy", &function_72ac9f7b );
    level flag::wait_till( "flg_initial_plaza_guys_normal_combat" );
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 0
// Checksum 0xd809f5ea, Offset: 0x1288
// Size: 0x106
function function_72ac9f7b()
{
    self endon( #"death" );
    self.ignoreall = 1;
    self.ignoreme = 1;
    self setgoal( self.origin );
    self.goalradius = 16;
    self.health = 10;
    self val::set( "molotov_victim_guy", "takedamage", 0 );
    level flag::wait_till( "flg_initial_plaza_guys_normal_combat" );
    self val::set( "molotov_victim_guy", "takedamage", 1 );
    wait 5;
    
    if ( isalive( self ) )
    {
        self.ignoreall = 0;
        self.ignoreme = 0;
    }
}

// Namespace namespace_69b8cbbe/namespace_69b8cbbe
// Params 0
// Checksum 0x66773b20, Offset: 0x1398
// Size: 0x168
function function_99e351b3()
{
    var_931f6882 = getentarray( "plaza_veh_destructibles", "script_noteworthy" );
    
    foreach ( veh in var_931f6882 )
    {
        veh val::set( "plaza_destructibles", "takedamage", 0 );
    }
    
    level flag::wait_till( "flg_initial_plaza_guys_normal_combat" );
    
    foreach ( veh in var_931f6882 )
    {
        veh val::set( "plaza_destructibles", "takedamage", 1 );
    }
}

