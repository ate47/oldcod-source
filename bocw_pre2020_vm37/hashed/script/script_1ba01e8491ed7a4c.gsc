#using script_1b9f100b85b7e21d;
#using script_290b454abd681dd4;
#using script_2d443451ce681a;
#using script_37f9ff47f340fbe8;
#using script_7409560e3a0c9884;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_sidemission_tundra;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;

#namespace namespace_da32b76a;

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 1
// Checksum 0x1130716, Offset: 0x778
// Size: 0xa4
function function_c17355e( *var_d3440450 )
{
    level flag::set( "tundra_intro_done" );
    thread namespace_c1cfab6c::function_f5421481();
    level thread namespace_ba979a10::setup_allies();
    level.music = snd::function_9ae4fc6f( "mus_tmp_kgb_combat_3b_lp" );
    level thread namespace_ba979a10::function_cb6a2e9b();
    level thread namespace_ba979a10::function_ee211e0d();
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 2
// Checksum 0x5b1cbcc3, Offset: 0x828
// Size: 0x44
function function_baff9422( *var_d3440450, *var_50cc0d4f )
{
    thread function_896664a1();
    wait 1;
    skipto::function_4e3ab877( "dev_vip_active" );
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0xfafb78a4, Offset: 0x878
// Size: 0x5c
function function_896664a1()
{
    wait 5;
    flag::set( "flag_obj_2_search_clear_1" );
    wait 0.5;
    flag::set( "flag_obj_3_search_clear_1" );
    flag::set( "flag_obj_3_search_clear_2" );
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 2
// Checksum 0x873cb569, Offset: 0x8e0
// Size: 0x16c
function function_bf8d2448( *var_d3440450, *var_50cc0d4f )
{
    level thread function_89e4fd54();
    level thread function_81f64302();
    level thread function_335d39d4();
    level thread function_8a11a2c7();
    level thread function_86097daf();
    level thread function_6ae9bdde();
    level thread function_40c20c88();
    level thread function_3d8085b3();
    level thread function_85f13965();
    level.woods ai::set_behavior_attribute( "demeanor", "combat" );
    level flag::wait_till( "flag_tundra_vip_kill_confirmed" );
    level.player thread cp_sidemission_tundra::function_2b05a144();
    wait 2;
    skipto::function_4e3ab877( "tundra_combat" );
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0x939961a0, Offset: 0xa58
// Size: 0x34
function function_89e4fd54()
{
    spawner::add_spawn_function_group( "vip_enemy_spawners", "script_noteworthy", &namespace_ba979a10::function_78a1b9ef );
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0x80f724d1, Offset: 0xa98
// Size: 0x4
function init_flags()
{
    
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 4
// Checksum 0xed6a5c81, Offset: 0xaa8
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0x96cfbaab, Offset: 0xad8
// Size: 0x4e
function function_86097daf()
{
    flag::wait_till( "flag_spawn_motor_pool_enemies" );
    var_a7bf3fdb = spawner::simple_spawn( "tundra_motor_pool_enemies", &function_11c72468 );
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0x5cfda300, Offset: 0xb30
// Size: 0x4e
function function_6ae9bdde()
{
    flag::wait_till( "flag_spawn_radar_enemies" );
    var_85e8ce7 = spawner::simple_spawn( "tundra_radar_enemies", &function_11c72468 );
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0xb476ef81, Offset: 0xb88
// Size: 0x4e
function function_40c20c88()
{
    flag::wait_till( "flag_spawn_fuel_depot_enemies" );
    var_ce5c48e8 = spawner::simple_spawn( "tundra_fuel_depot_enemies", &function_11c72468 );
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0x1eaa05ab, Offset: 0xbe0
// Size: 0xec
function function_8a11a2c7()
{
    level flag::wait_till( "tundra_vip_enemy_spawned" );
    iprintlnbold( "Woods: There's that bastard!" );
    level flag::wait_till( "flag_tundra_vip_killed" );
    iprintlnbold( "Mason: Target eliminated." );
    wait 5;
    iprintlnbold( "Command: We need kill confirmation." );
    level flag::wait_till( "flag_tundra_vip_kill_confirmed" );
    iprintlnbold( "Mason: Kill confirmed. We've got the pic to prove it." );
    wait 4;
    iprintlnbold( "Woods: I want a copy for my scrapbook." );
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0xe8b79df2, Offset: 0xcd8
// Size: 0x16c
function function_3d8085b3()
{
    clear_flags = [ "search_objective_1_cleared", "search_objective_2_cleared", "search_objective_3_cleared" ];
    cleared = level flag::wait_till_any( clear_flags );
    arrayremovevalue( clear_flags, cleared._notify );
    iprintlnbold( "Mason: Building clear!" );
    wait 4;
    iprintlnbold( "Woods: Rudnik's not in here. Let's move to one of the other buildings!" );
    cleared = level flag::wait_till_any( clear_flags );
    arrayremovevalue( clear_flags, cleared._notify );
    var_ebe5de4 = getsubstr( clear_flags[ 0 ], 17, 18 );
    var_ebe5de4 = int( var_ebe5de4 );
    iprintlnbold( "Mason: Clear!" );
    wait 4;
    iprintlnbold( "Woods: He's not here either.  Let's get over to the other building!" );
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0x1834b371, Offset: 0xe50
// Size: 0xe4
function function_85f13965()
{
    level endon( #"flag_tundra_vip_kill_confirmed" );
    level flag::wait_till( "flag_tundra_vip_kill_confirmed" );
    nags = [];
    nags[ nags.size ] = "Woods: Use your camera, Mason. We need a photo of this asshole.";
    nags[ nags.size ] = "Woods: We need a photo of Rudnik for Langley, Mason.";
    nags[ nags.size ] = "Woods: Jesus, Mason, take the damn picture.";
    wait 15;
    i = 0;
    
    while ( true )
    {
        iprintlnbold( "" + nags[ i ] );
        i++;
        
        if ( i + 1 > nags.size )
        {
            i = 0;
        }
        
        wait 15;
    }
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0x34c81060, Offset: 0xf40
// Size: 0x12
function function_11c72468()
{
    self.maxsightdistsqrd = 4000000;
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0x10b41a60, Offset: 0xf60
// Size: 0x5c
function function_335d39d4()
{
    level.woods waittill( #"damage", #"bulletwhizby" );
    level.woods val::set( "intro", "ignoreall", 0 );
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0x4b85248c, Offset: 0xfc8
// Size: 0x2bc
function function_81f64302()
{
    level flag::wait_till( "flag_tundra_vip_killed" );
    snd::function_4286bd2c( level.music );
    level.player notifyonplayercommand( "ability_activated_camera", "+actionslot 4" );
    level thread function_38ac2a96();
    level.player waittill( #"ability_activated_camera" );
    level.player giveweapon( level.var_e3f5eafc );
    level.player switchtoweaponimmediate( level.var_e3f5eafc );
    level.player disableweaponcycling();
    level thread function_3239474f();
    
    foreach ( e_obj in level.var_a4592423 )
    {
        level.player spy_camera::function_f785d9e9( e_obj );
    }
    
    array::wait_any( level.var_a4592423, "photo_taken" );
    level flag::set( "flag_tundra_vip_kill_confirmed" );
    
    foreach ( e_obj in level.var_a4592423 )
    {
        level.player spy_camera::function_b28ab5a9( e_obj );
        waitframe( 1 );
    }
    
    array::delete_all( level.var_a4592423 );
    level.player takeweapon( level.var_e3f5eafc );
    level.player enableweaponcycling();
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0x7574d7a4, Offset: 0x1290
// Size: 0x252
function function_38ac2a96()
{
    player = getplayers()[ 0 ];
    level endon( #"flag_tundra_vip_kill_confirmed" );
    player endon( #"death" );
    
    while ( true )
    {
        level flag::clear( "cancel_ability_wheel_select_camera_hint" );
        level flag::clear( "cancel_camera_up_hint" );
        level flag::clear( "cancel_hint_camera_use" );
        player util::show_hint_text( #"hash_62b200bcfa871ac", undefined, undefined, 8 );
        player waittill( #"ability_activated_camera" );
        level flag::set( "cancel_ability_wheel_select_camera_hint" );
        wait 0.5;
        player util::show_hint_text( #"hash_65f560d181b08c7", undefined, undefined, 8 );
        s_waitresult = player waittill( #"enter_camera_ads", #"ability_deactivated_camera" );
        level flag::set( "cancel_camera_up_hint" );
        wait 0.5;
        
        if ( s_waitresult._notify == "ability_deactivated_camera" )
        {
            continue;
        }
        
        player util::show_hint_text( #"hash_7e88a33f7f3c1d91", undefined, undefined, 8 );
        s_waitresult = player waittilltimeout( 4, #"end_camera_ads_begin", #"ability_deactivated_camera", #"take_picture" );
        level flag::set( "cancel_hint_camera_use" );
        return;
    }
}

// Namespace namespace_da32b76a/namespace_da32b76a
// Params 0
// Checksum 0x961d4cf1, Offset: 0x14f0
// Size: 0x130
function function_3239474f()
{
    level endon( #"flag_tundra_vip_kill_confirmed" );
    vo = [];
    vo[ vo.size ] = "Woods: Make sure you get a clear picture of the body.";
    vo[ vo.size ] = "Woods: We need a good photo of the kill, get the whole body.";
    vo[ vo.size ] = "Woods: Get a picture of the body that will show command it\x92s Rudnik.";
    vo[ vo.size ] = "Woods: We need a picture of the whole body.";
    i = 0;
    
    while ( !level flag::get( "flag_tundra_vip_kill_confirmed" ) )
    {
        level.player waittill( #"take_picture" );
        waitframe( 1 );
        
        if ( !level flag::get( "flag_tundra_vip_kill_confirmed" ) )
        {
            iprintlnbold( "" + vo[ i ] );
            i++;
            
            if ( i + 1 > vo.size )
            {
                i = 0;
            }
            
            wait 0.5;
        }
    }
}

