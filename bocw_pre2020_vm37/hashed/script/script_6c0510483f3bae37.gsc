#using script_1fd2c6e5fc8cb1c3;
#using script_44aef2868ad2e317;
#using script_4ec222619bffcfd1;
#using script_779f525443585713;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_rus_kgb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\ent_name;
#using scripts\cp_common\util;

#namespace kgb_aslt_elev_down;

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 1
// Checksum 0xca3ef62e, Offset: 0x4c8
// Size: 0xac
function starting( var_d3440450 )
{
    level thread scene::init( "scene_kgb_poison_tea" );
    level.adler = namespace_e77bf565::adler_spawn( var_d3440450 );
    level.adler.ignoreme = 1;
    level.adler.ignoreall = 1;
    level thread scene::init( "scene_kgb_elevator_holdup" );
    level thread namespace_99e99ffa::function_1d90bc4a();
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 2
// Checksum 0xac169fc4, Offset: 0x580
// Size: 0x1e4
function main( var_d3440450, var_50cc0d4f )
{
    level thread function_a8bd0b05();
    level thread function_84594864();
    var_92ce6586 = getentarray( "fake_basement_elevator", "targetname" );
    
    foreach ( piece in var_92ce6586 )
    {
        piece delete();
    }
    
    player = getplayers()[ 0 ];
    player.ignoreme = 1;
    player.ignoreall = 1;
    
    if ( is_true( var_50cc0d4f ) )
    {
        kgb_ins_prepare::function_52f0fcb3();
        kgb_ins_prepare::function_84d00884();
        level thread namespace_99e99ffa::function_99e99ffa( var_d3440450 );
        level thread namespace_e77bf565::function_ada6d016();
        namespace_e77bf565::function_c4de67de();
    }
    
    level flag::wait_till( "aslt_elev_down_complete" );
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 4
// Checksum 0x53313a3d, Offset: 0x770
// Size: 0x3c
function cleanup( *name, *starting, *direct, *player )
{
    level thread namespace_e77bf565::function_27006ab9();
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0xe5a25a37, Offset: 0x7b8
// Size: 0x104
function init_flags()
{
    level flag::init( "question_fail" );
    level flag::init( "knock_out_boris" );
    level flag::init( "team_in_elevator" );
    level flag::init( "aslt_elev_down_complete" );
    level flag::init( "attack_success" );
    level flag::init( "stop_attack_prompt" );
    level flag::init( "flag_cleanup_kgb_hq" );
    level flag::init( "boris_get_off" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x23eaef60, Offset: 0x8c8
// Size: 0x34
function init_clientfields()
{
    scene::add_scene_func( "scene_kgb_elevator_holdup", &function_9165ed13, "Question1" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x80f724d1, Offset: 0x908
// Size: 0x4
function function_22b7fffd()
{
    
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0xd8b13746, Offset: 0x918
// Size: 0x3c
function function_a8bd0b05()
{
    level function_dbef1d1a();
    level flag::set( "aslt_elev_down_complete" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x85cf496, Offset: 0x960
// Size: 0x12c
function function_ff614b0d()
{
    self cp_rus_kgb::function_c235774c();
    setdvar( #"aim_assist_script_disable", 0 );
    self val::reset( #"hash_bc68371784a550b", "allow_sprint" );
    self val::reset( #"hash_5029f31f15e64e63", "allow_jump" );
    self val::reset( #"hash_674e1e53ededa27f", "allow_prone" );
    self val::set( #"hash_192dddd4b6f92f9", "show_weapon_hud", 1 );
    self allowslide( 1 );
    self setmovespeedscale( 1 );
    self clearcinematicmotionoverride();
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x3e53e65c, Offset: 0xa98
// Size: 0xa8
function function_6df467f6()
{
    var_4f2ba130 = self getweaponslistprimaries();
    
    foreach ( e_w in var_4f2ba130 )
    {
        self takeweapon( e_w );
    }
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 1
// Checksum 0x4b0bdf5d, Offset: 0xb48
// Size: 0x5c
function function_9165ed13( a_ents )
{
    vip = a_ents[ #"boris" ];
    vip thread entname::add( #"hash_6a1195604c394694", #"axis" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0xb6647124, Offset: 0xbb0
// Size: 0x804
function function_dbef1d1a()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    level thread scene::play( "scene_kgb_elevator_holdup", "Intro" );
    level flag::set( "flag_prep_elevator" );
    level flag::wait_till( "flag_player_near_elevator" );
    level thread savegame::checkpoint_save();
    level thread function_beefb420();
    level thread scene::play( "scene_kgb_elevator_holdup", "Call_Elevator" );
    namespace_353d803e::music( "8.3_cello_stingers_2" );
    wait 9;
    struct = struct::get( "struct_call_elevator", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_6064d25f8d7de0de" );
    tag waittill( #"trigger" );
    level.player districts::function_930f8c81( [ "kgb_hq_prison_stairs", "kgb_hq_front_04", "kgb_hq_second_floor", "kgb_hq_armory_wing", "kgb_hq_courtyard" ] );
    level thread function_bd2b281();
    setdvar( #"hash_135dec1a591c3c02", 0.9 );
    thread namespace_353d803e::function_d2bfe6bd();
    tag util::remove_cursor_hint();
    tag delete();
    level flag::set( "team_in_elevator" );
    level scene::delete_scene_spawned_ents( "scene_kgb_briefing" );
    level scene::play( "scene_kgb_elevator_holdup", "Question1" );
    level flag::set( "flag_cleanup_kgb_hq" );
    level thread scene::play( "scene_kgb_elevator_holdup", "Question1_Loop" );
    function_56ebd96e();
    
    if ( !level flag::get( "knock_out_boris" ) )
    {
        level scene::play( "scene_kgb_elevator_holdup", "Question2" );
        level thread scene::play( "scene_kgb_elevator_holdup", "Question2_Loop" );
        function_8d79f364();
        
        if ( !level flag::get( "knock_out_boris" ) )
        {
            if ( !level flag::get( "question_fail" ) )
            {
                level thread function_c40f1128();
                thread namespace_353d803e::function_21e6fc96();
                thread namespace_353d803e::function_8b168679();
                level scene::play( "scene_kgb_elevator_holdup", "Success" );
            }
            else
            {
                level thread function_867e4e68();
                level thread function_195e2ff1();
                level thread scene::play( "scene_kgb_elevator_holdup", "Attack" );
                level flag::wait_till_timeout( 8.4, "attack_success" );
                level flag::set( "stop_attack_prompt" );
                
                if ( level flag::get( "attack_success" ) )
                {
                    entname::remove_all();
                    level scene::play( "scene_kgb_elevator_holdup", "Attack_Success" );
                }
                else
                {
                    level thread Attack_Fail();
                    level scene::play( "scene_kgb_elevator_holdup", "Attack_Fail" );
                }
            }
        }
        else
        {
            level notify( #"hash_7d8046bc5c3382d4" );
            level thread function_1ef3bb4();
            level scene::play( "scene_kgb_elevator_holdup", "Knockout" );
        }
    }
    else
    {
        level notify( #"hash_7d8046bc5c3382d4" );
        level thread function_1ef3bb4();
        level scene::play( "scene_kgb_elevator_holdup", "Knockout" );
    }
    
    level.player districts::function_930f8c81( [ "kgb_hq_elevator", "kgb_hq_east_wing", "kgb_hq_intersection" ] );
    level.player districts::function_a7d79fcb( [ "kgb_und_vault_bunker_main" ] );
    level notify( #"hash_7d8046bc5c3382d4" );
    level thread function_ca1bfb16();
    level thread scene::play( "scene_kgb_elevator_holdup", "Gear_Up" );
    thread namespace_353d803e::function_3e72b69a();
    level waittill( #"hash_330539a9fb3725f" );
    player function_ff614b0d();
    namespace_979752dc::set_disguised( 0 );
    thread namespace_353d803e::function_f3f9a760();
    thread namespace_353d803e::function_7972eaf3();
    setdvar( #"hash_135dec1a591c3c02", 0.3 );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x52a608a2, Offset: 0x13c0
// Size: 0x134
function function_56ebd96e()
{
    var_38e8431f = dialog_tree::new_tree( undefined, undefined, 1, 1 );
    var_38e8431f dialog_tree::add_option( #"hash_109e8c5a813dbd41", undefined, undefined, undefined, 1, undefined, undefined, &function_ec2ce1aa );
    var_38e8431f dialog_tree::add_option( #"hash_109e895a813db828", undefined, undefined, undefined, 1, undefined, undefined, &function_ec2ce1aa );
    var_38e8431f dialog_tree::add_option( #"hash_109e8a5a813db9db", undefined, undefined, undefined, 1, undefined, undefined, &function_ec2ce1aa );
    var_38e8431f dialog_tree::add_option( #"hash_6ab903ee7d727152", undefined, undefined, undefined, 1, "knock_out_boris", undefined, &knock_out_boris );
    var_38e8431f dialog_tree::run( undefined, undefined, 6 );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0xb2857c5, Offset: 0x1500
// Size: 0x134
function function_8d79f364()
{
    var_4ea26e93 = dialog_tree::new_tree( undefined, undefined, 1, 1 );
    var_4ea26e93 dialog_tree::add_option( #"hash_74bf855a70ebbd1c", undefined, undefined, undefined, 1, undefined, undefined, &function_5af4b73 );
    var_4ea26e93 dialog_tree::add_option( #"hash_74bf885a70ebc235", undefined, undefined, undefined, 1, undefined, undefined, &function_ec2ce1aa );
    var_4ea26e93 dialog_tree::add_option( #"hash_74bf875a70ebc082", undefined, undefined, undefined, 1, undefined, undefined, &function_5af4b73 );
    var_4ea26e93 dialog_tree::add_option( #"hash_6ab903ee7d727152", undefined, undefined, undefined, 1, "knock_out_boris", undefined, &knock_out_boris );
    var_4ea26e93 dialog_tree::run( undefined, undefined, 6 );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x9722347, Offset: 0x1640
// Size: 0x84
function function_ff8e7eb0()
{
    hack = dialog_tree::new_tree( undefined, undefined, 1, 1 );
    hack dialog_tree::add_option( #"hash_6ab903ee7d727152", undefined, undefined, undefined, 1, undefined, undefined, &function_3ca9698a );
    hack dialog_tree::run( undefined, undefined, 6 );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0xf6886538, Offset: 0x16d0
// Size: 0x24
function function_5af4b73()
{
    level flag::set( "question_fail" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0xfb55a974, Offset: 0x1700
// Size: 0x24
function function_ec2ce1aa()
{
    level flag::set( "boris_get_off" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x69e54267, Offset: 0x1730
// Size: 0x34
function knock_out_boris()
{
    entname::remove_all();
    level flag::set( "knock_out_boris" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x8756c132, Offset: 0x1770
// Size: 0x44
function Attack_Fail()
{
    level thread lui::screen_fade_out( 0.5, "black" );
    wait 2;
    util::missionfailedwrapper();
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0xa65a8e7, Offset: 0x17c0
// Size: 0x24
function function_867e4e68()
{
    wait 2;
    level thread function_ff8e7eb0();
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x61685fb5, Offset: 0x17f0
// Size: 0x24
function function_3ca9698a()
{
    level flag::set( "attack_success" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x4243789d, Offset: 0x1820
// Size: 0xf4
function function_bd2b281()
{
    player = getplayers()[ 0 ];
    f_time = 1.75;
    wait f_time;
    player playrumbleonentity( #"hash_5b7713a379ba4843" );
    wait 6 - f_time;
    player playrumbleonentity( #"hash_557fcb9fd5f0f812" );
    wait 8;
    player playrumbleonentity( #"hash_599c601d51bf76cf" );
    level flag::wait_till( "flag_cleanup_kgb_hq" );
    level thread function_d801675e();
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x80a45ddc, Offset: 0x1920
// Size: 0x6e
function function_d801675e()
{
    player = getplayers()[ 0 ];
    level endon( #"hash_7d8046bc5c3382d4" );
    
    while ( true )
    {
        player playrumbleonentity( #"hash_557fcb9fd5f0f812" );
        wait 5;
    }
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x32b07efa, Offset: 0x1998
// Size: 0xc4
function function_195e2ff1()
{
    namespace_353d803e::music( "deactivate_9.0_infiltrating" );
    player = getplayers()[ 0 ];
    wait 2;
    level notify( #"hash_7d8046bc5c3382d4" );
    player playrumbleonentity( #"hash_3b1938b38d96e123" );
    level flag::wait_till( "attack_success" );
    wait 0.5;
    player playrumbleonentity( #"hash_5b7713a379ba4843" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x109d7ae7, Offset: 0x1a68
// Size: 0xc4
function function_1ef3bb4()
{
    namespace_353d803e::music( "deactivate_9.0_infiltrating" );
    player = getplayers()[ 0 ];
    wait 1;
    level notify( #"hash_7d8046bc5c3382d4" );
    player stoprumble( #"hash_557fcb9fd5f0f812" );
    player playrumbleonentity( #"hash_109e3e977480ca06" );
    wait 2.25;
    player playrumbleonentity( #"hash_5b7713a379ba4843" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x6cfe3838, Offset: 0x1b38
// Size: 0x74
function function_ca1bfb16()
{
    player = getplayers()[ 0 ];
    player playrumbleonentity( #"hash_3b1938b38d96e123" );
    wait 10;
    player playrumbleonentity( #"hash_599c601d51bf76cf" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x2779e5e2, Offset: 0x1bb8
// Size: 0x3c
function function_beefb420()
{
    wait 5;
    playrumbleonposition( #"hash_599c601d51bf76cf", level.elevator.origin );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0x9a75bf62, Offset: 0x1c00
// Size: 0xa4
function function_c40f1128()
{
    namespace_353d803e::music( "deactivate_9.0_infiltrating" );
    player = getplayers()[ 0 ];
    wait 4;
    level notify( #"hash_7d8046bc5c3382d4" );
    wait 3;
    player playrumbleonentity( #"hash_599c601d51bf76cf" );
    wait 7;
    player playrumbleonentity( #"hash_599c601d51bf76cf" );
}

// Namespace kgb_aslt_elev_down/namespace_f4e24fd0
// Params 0
// Checksum 0xf94d578b, Offset: 0x1cb0
// Size: 0xf4
function function_84594864()
{
    level waittill( #"hash_38b5a7da1af26414" );
    level thread lui::screen_fade_out( 0.5, "black" );
    level waittill( #"hash_22a50ec8726e2044" );
    player = getplayers()[ 0 ];
    player thread cp_rus_kgb::function_e876a652( "kgb_officer_exfil" );
    level.adler namespace_e77bf565::function_5770c74( "assault" );
    level waittill( #"hash_1447c9bdddb708f" );
    level thread lui::screen_fade_in( 1 );
}

