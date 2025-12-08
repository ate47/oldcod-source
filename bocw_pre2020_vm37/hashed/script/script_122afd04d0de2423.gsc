#using script_2d443451ce681a;
#using script_30cfffd6b7b2b212;
#using script_3890e6e179f6ed13;
#using script_3dc93ca9902a9cda;
#using script_67332a4d085a140a;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
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
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;

#namespace namespace_f464d565;

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 1
// Checksum 0xfd02afc1, Offset: 0x570
// Size: 0xac
function function_dbf2a80e( *var_d3440450 )
{
    level.var_aece851d = [];
    level.var_33621ea7 = 1;
    namespace_42da7c51::function_ed760ecb( "woods" );
    level thread objectives::follow( "woods_hit1", level.woods );
    level.var_95a74232 = 1;
    level thread function_377fcb1e();
    level thread namespace_61150688::function_bff4c800();
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 2
// Checksum 0xd07561ed, Offset: 0x628
// Size: 0x1a4
function function_b474f6be( var_d3440450, *var_50cc0d4f )
{
    level.var_7c11765c = 0;
    level.last_player_attacker = level;
    level thread function_d61cf2f9();
    callback::on_player_damage( &namespace_42da7c51::function_aa3c5fab );
    level.var_9a3944f4 thread namespace_42da7c51::function_cbe25a41( level.woods, "tag_glass_front_left_lower_d0", 1 );
    level thread function_777db94c();
    level thread function_50051760();
    level flag::wait_till( "flag_parking_lot_complete" );
    ai_axis = getaiarray( "axis_hotel_parking_lot", "targetname" );
    
    if ( ai_axis.size )
    {
        level.woods.perfectaim = 1;
        ai::waittill_dead_or_dying( ai_axis, int( ai_axis.size ) );
    }
    
    level.woods.perfectaim = 0;
    level.woods ai::disable_careful();
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 0
// Checksum 0x90c24cf4, Offset: 0x7d8
// Size: 0x94
function function_d61cf2f9()
{
    level flag::wait_till( "flag_obj_parking_lot_update" );
    objectives::remove( "woods_hit1", level.woods );
    var_2c99bea = struct::get( "obj_org_breach", "targetname" );
    objectives::goto( "hotel_breach", var_2c99bea.origin );
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 4
// Checksum 0xfeaeec54, Offset: 0x878
// Size: 0x24
function function_a81c2225( *name, *starting, *direct, *player )
{
    
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 1
// Checksum 0x17571e22, Offset: 0x8a8
// Size: 0x3c
function starting( *var_d3440450 )
{
    namespace_42da7c51::function_ed760ecb( "woods" );
    level thread function_377fcb1e();
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 0
// Checksum 0x44a9ebdd, Offset: 0x8f0
// Size: 0x308
function function_50051760()
{
    var_d9947e6e = getent( "vol_trailer_park_cleanup", "targetname" );
    ai = var_d9947e6e ai::function_18c4ff86( #"axis", "human" );
    
    if ( ai.size )
    {
        foreach ( guy in ai )
        {
            if ( isdefined( guy ) && isalive( guy ) )
            {
                guy thread ai::bloody_death( randomintrange( 2, 7 ) );
            }
        }
    }
    
    a_axis = spawner::simple_spawn( "axis_hotel_parking_lot" );
    a_axis ai::waittill_dead_or_dying( a_axis, int( ceil( a_axis.size * 0.7 ) ) );
    level.woods.perfectaim = 1;
    
    if ( a_axis.size )
    {
        function_1eaaceab( a_axis );
    }
    
    level thread namespace_42da7c51::function_d6fedf97( a_axis, int( ceil( a_axis.size ) ), "flag_parking_lot_complete" );
    
    foreach ( guy in a_axis )
    {
        tar = undefined;
        
        if ( math::cointoss() )
        {
            tar = level.player;
        }
        else
        {
            tar = level.woods;
        }
        
        if ( isdefined( guy ) && isalive( guy ) )
        {
            guy.goalradius = 256;
            guy thread ai::set_goal_ent( tar );
            guy thread ai::bloody_death( 6 );
        }
    }
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 0
// Checksum 0x8db69a01, Offset: 0xc00
// Size: 0x54
function function_777db94c()
{
    level flag::wait_till( "flag_hotel_heli_shootout" );
    level util::delay( 14, undefined, &flag::set, "flag_stop_hotel_heli_shootout" );
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 2
// Checksum 0x7cfe2f5e, Offset: 0xc60
// Size: 0x25c
function main( var_d3440450, *var_50cc0d4f )
{
    level.woods colors::disable();
    level.woods cleargoalvolume();
    node = getnode( "woods_hotel_postup_breach", "targetname" );
    level.woods ai::set_goal_node( node );
    level.woods val::set( #"hash_fc8c2d0605f3557", "goalradius", 32 );
    level.var_9a3944f4 turret::disable( 1 );
    level.var_9a3944f4 turret::disable( 2 );
    level util::delay_notify( 0.5, "heli_focus_door_breach" );
    level thread namespace_61150688::function_b848f0c0();
    level thread function_a7ca15cc();
    level function_6f9e6949();
    level thread function_f4ad0a04();
    level flag::wait_till( "aldrich_dead" );
    level thread function_c182078c();
    level thread function_73a5b42a();
    level flag::wait_till( #"hash_5601fb6019314f30" );
    level.woods colors::enable();
    level.woods val::reset_all( #"hash_fc8c2d0605f3557" );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 4
// Checksum 0x7d5b380b, Offset: 0xec8
// Size: 0x74
function cleanup( *name, starting, *direct, *player )
{
    if ( player )
    {
        mdl_door = getent( "mdl_hotel_breach_door", "targetname" );
        mdl_door rotateyaw( 87, 0.05 );
    }
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 0
// Checksum 0xab51b150, Offset: 0xf48
// Size: 0xdc
function function_377fcb1e()
{
    level.var_40b02b72 = vehicle::simple_spawn_and_drive( "heli_hotel" );
    level.var_9a3944f4 = level.var_40b02b72[ 0 ];
    level.var_9a3944f4 thread namespace_42da7c51::function_fbb0d73f();
    thread namespace_42da7c51::heli_light( level.var_9a3944f4, "ally_heli_spot_light_bustout", "tag_fx_running_light_front_side_left_01", ( -20, 12, 0 ), level.var_9a3944f4, 0, 1 );
    level.var_9a3944f4 thread namespace_42da7c51::function_3cebcd1b();
    level.var_9a3944f4 util::delay_notify( 0.1, "lights_on" );
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 0
// Checksum 0x946d8d4, Offset: 0x1030
// Size: 0x5c
function function_a7ca15cc()
{
    level.woods dialogue::radio( "vox_cp_chao_03100_chp1_theywentuptothe_ed" );
    level.woods dialogue::radio( "vox_cp_chao_03100_wood_letscrashtheirp_d9" );
    dialogue::radio( "vox_cp_chao_03100_chp1_rogerthatillsee_3c" );
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 0
// Checksum 0xa971f64a, Offset: 0x1098
// Size: 0x254
function function_6f9e6949()
{
    mdl_door = getent( "mdl_hotel_breach_door", "targetname" );
    var_8433129 = struct::get( "use_org_door_breach", "targetname" );
    var_8433129 util::create_cursor_hint( undefined, undefined, #"hash_1877ee4cd6e16cce" );
    var_8433129 waittill( #"trigger" );
    level notify( #"hash_6b5c0d1e8b95af4c" );
    objectives::complete( "hotel_breach" );
    level thread scene::play( "scene_tkd_hit1_hotel_breach", [ level.player ] );
    level util::delay( 0.3, undefined, &function_f854346b );
    level waittill( #"hash_7d8e293b60233d56" );
    mdl_door rotateyaw( 87, 0.4, 0.1, 0.25 );
    e_player = getplayers()[ 0 ];
    var_78b3d4a1 = 0.3;
    var_b89fe77a = 1;
    var_af6c8808 = 0.3;
    var_970d5e06 = 3;
    e_player setmovespeedscale( var_78b3d4a1 );
    setslowmotion( var_b89fe77a, var_78b3d4a1, var_af6c8808 );
    level waittilltimeout( var_970d5e06, #"hash_25ea67f07d3237f2" );
    setslowmotion( var_78b3d4a1, var_b89fe77a, var_af6c8808 );
    e_player setmovespeedscale( var_b89fe77a );
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 0
// Checksum 0xe69a413, Offset: 0x12f8
// Size: 0x138
function function_f854346b()
{
    var_a6be88da = spawner::simple_spawn( "perseus_breach_enemies" );
    
    foreach ( guy in var_a6be88da )
    {
        guy.health = 1;
    }
    
    level thread scene::play( "aib_t9_vign_cust_arm_l_cover_stnd_r_startled_react_02", [ var_a6be88da[ 0 ] ] );
    level util::delay( 0.2, undefined, &scene::play, "aib_t9_vign_cust_arm_l_cover_stnd_r_startled_react_01", [ var_a6be88da[ 1 ] ] );
    ai::waittill_dead_or_dying( var_a6be88da, var_a6be88da.size );
    level notify( #"hash_25ea67f07d3237f2" );
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 0
// Checksum 0xd478ca07, Offset: 0x1438
// Size: 0x17c
function function_f4ad0a04()
{
    ai = spawner::simple_spawn_single( "aldrich_spawner" );
    ai setteam( #"axis" );
    ai.health = 1;
    ai.var_c681e4c1 = 1;
    ai.skipdeath = 1;
    level thread scene::play( "aib_engineer_injured_guy_wounded", [ ai ] );
    objectives::kill( "obj_kill_aldrich", ai );
    ai setcandamage( 1 );
    ai waittill( #"damage", #"death" );
    ai stopsounds();
    objectives::complete( "obj_kill_aldrich" );
    level.var_a481715f = util::spawn_model( "tag_origin", ai.origin + ( 0, 0, 15 ), ai.angles );
    level flag::set( "aldrich_dead" );
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 0
// Checksum 0x9461160c, Offset: 0x15c0
// Size: 0x1a4
function function_c182078c()
{
    level.player notifyonplayercommand( "ability_activated_camera", "+actionslot 4" );
    level.player waittill( #"ability_activated_camera" );
    level.player giveweapon( level.var_e3f5eafc );
    level.player switchtoweaponimmediate( level.var_e3f5eafc );
    level.player disableweaponcycling();
    level.player spy_camera::function_b28ab5a9( level.var_a481715f );
    waitframe( 2 );
    level.player spy_camera::function_f785d9e9( level.var_a481715f );
    level.player waittill( #"take_picture" );
    wait 2;
    level flag::set( "kill_confirmed" );
    level.player spy_camera::function_b28ab5a9( level.var_a481715f );
    level.player takeweapon( level.var_e3f5eafc );
    level.player enableweaponcycling();
    level flag::set( #"hash_5601fb6019314f30" );
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 0
// Checksum 0x9c3ed4ab, Offset: 0x1770
// Size: 0x74
function function_73a5b42a()
{
    wait 1;
    iprintlnbold( "Woods: Take a picture of him, and" );
    iprintlnbold( "Then let's get the hell out of here!" );
    wait 2;
    level.player util::show_hint_text( #"hash_2e082b24b46890d6", undefined, undefined, 8 );
}

// Namespace namespace_f464d565/namespace_cd9bac84
// Params 0
// Checksum 0x80f724d1, Offset: 0x17f0
// Size: 0x4
function function_33adb33b()
{
    
}

