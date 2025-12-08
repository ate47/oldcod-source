#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_61cfc2ab8e60625;
#using script_9bfd3d8a6a89e5e;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_takedown_af_hill;
#using scripts\cp\cp_takedown_af_tarmac;
#using scripts\cp\cp_takedown_fx;
#using scripts\cp_common\debug;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;

#namespace tkdn_af_chase;

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x418b7e01, Offset: 0x1148
// Size: 0x10c
function starting( var_d3440450 )
{
    tkdn_af_hill::function_a2015343( var_d3440450 );
    plane = namespace_b100dd86::function_5431431d();
    namespace_b100dd86::function_c8381339( plane, 1 );
    setdvar( #"hash_135dec1a591c3c02", 0.05 );
    namespace_b100dd86::function_5aabc3fb();
    trigger::use( "approach_airstrip", "targetname", undefined, 0 );
    thread tkdn_af_tarmac::function_565588e1();
    thread namespace_b100dd86::function_19919872();
    thread namespace_a052577e::function_79270d32();
    level clientfield::set( "prop_wash", 1 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x569b7e06, Offset: 0x1260
// Size: 0x1d4
function function_614083bb( var_d3440450 )
{
    namespace_b100dd86::function_5aabc3fb();
    level.player = getplayers()[ 0 ];
    tkdn_af_hill::function_a2015343( var_d3440450 );
    plane = namespace_b100dd86::function_5431431d();
    namespace_b100dd86::function_c8381339( plane, 1 );
    setdvar( #"hash_135dec1a591c3c02", 0.05 );
    setdvar( #"hash_3d9a09e7ecea2271", 0 );
    trigger::use( "approach_airstrip", "targetname", undefined, 0 );
    thread namespace_b100dd86::function_19919872();
    thread function_d9fae56b();
    function_6c9a840b();
    level.player val::set( #"chase", "allowdeath", 0 );
    level flag::set( "af_start_rc_car" );
    level.rc_car thread function_f311ea18();
    thread function_326abc48();
    spawner::add_spawn_function_group( "af_vh_enemy", "targetname", &function_db378ce0 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 4
// Checksum 0x5fd70114, Offset: 0x1440
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 4
// Checksum 0x80940068, Offset: 0x1470
// Size: 0x24
function function_cca97e77( *name, *starting, *direct, *player )
{
    
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x94e6136, Offset: 0x14a0
// Size: 0x64
function init_flags()
{
    level flag::init( "af_start_rc_car" );
    level flag::init( "af_chase_complete" );
    level flag::init( "af_pressed_rc_button" );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x61447f6e, Offset: 0x1510
// Size: 0x154
function init_clientfields()
{
    clientfield::register( "vehicle", "le_door_en2_death_fallout", 1, 1, "int" );
    clientfield::register( "vehicle", "ri_door_en2_death_fallout", 1, 1, "int" );
    clientfield::register( "vehicle", "4x4_getin_door", 1, 1, "int" );
    clientfield::register( "vehicle", "4x4_getin_door_woods", 1, 1, "int" );
    clientfield::register( "vehicle", "af_rc_deploy1", 1, 1, "int" );
    clientfield::register( "vehicle", "af_rc_deploy2", 1, 1, "int" );
    clientfield::register( "vehicle", "af_rc_deploy3", 1, 1, "int" );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x8500bf31, Offset: 0x1670
// Size: 0x54
function function_22b7fffd()
{
    animation::add_notetrack_func( "le_door_en2_death_fallout_server", &le_door_en2_death_fallout_server );
    animation::add_notetrack_func( "ri_door_en2_death_fallout_server", &ri_door_en2_death_fallout_server );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0xf05872e, Offset: 0x16d0
// Size: 0x64
function le_door_en2_death_fallout_server( *params )
{
    self.vehicle clientfield::set( "le_door_en2_death_fallout", 1 );
    self.vehicle setanim( #"hash_55c97e9bf41cf070", 1, 0, 1 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0xaa3bc8d0, Offset: 0x1740
// Size: 0x64
function ri_door_en2_death_fallout_server( *params )
{
    self.vehicle clientfield::set( "ri_door_en2_death_fallout", 1 );
    self.vehicle setanim( #"hash_7ed3204394a2ff5e", 1, 0, 1 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 2
// Checksum 0x63e0d465, Offset: 0x17b0
// Size: 0x2dc
function main( var_d3440450, *var_50cc0d4f )
{
    level.adler dialogue::function_47b06180();
    level.adler.script_accuracy = 100;
    level.woods.script_accuracy = 100;
    setdvar( #"hash_3d9a09e7ecea2271", 0 );
    level.af_plane cp_takedown_fx::function_c5bbfcb8();
    level.af_plane cp_takedown_fx::function_b6cccb8();
    level.af_plane cp_takedown_fx::function_8e4c996d();
    level.af_plane thread function_3a97edf();
    spawner::add_spawn_function_group( "af_vh_enemy", "targetname", &function_db378ce0 );
    vehicle::add_spawn_function_group( "af_enemy_chase_veh_r", "script_noteworthy", &function_40c45b6 );
    vehicle::add_spawn_function_group( "af_enemy_chase_veh_l", "script_noteworthy", &function_40c45b6 );
    player = getplayers()[ 0 ];
    function_d9fae56b();
    thread function_dcc35e0b();
    thread function_9d8f5cd3();
    thread function_4c87c5cf();
    thread function_b90ebd9a();
    thread function_9555ada1();
    wait 2;
    level flag::wait_till( "af_start_ride" );
    thread function_326abc48();
    level flag::wait_till( "af_start_rc_car" );
    thread function_761593b3();
    thread function_9509c87f();
    thread function_7730c3f4();
    level waittill( #"hash_2c1821278dd7ecb1" );
    wait 2;
    level notify( #"hash_351eb749d2c8fa9c" );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
    
    level.woods ai::gun_recall();
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 2
// Checksum 0x5ece4a9, Offset: 0x1a98
// Size: 0x764
function function_2ccc781e( var_d3440450, *var_50cc0d4f )
{
    player = getplayers()[ 0 ];
    setdvar( #"hash_3d9a09e7ecea2271", 0 );
    util::function_323d3227();
    player linkto( level.chase_truck );
    level.chase_truck vehicle::get_off_path();
    pathnode = getvehiclenode( "rc_chase_start", "targetname" );
    level.chase_truck thread vehicle::get_on_and_go_path( pathnode );
    waitframe( 1 );
    player unlink();
    thread function_9535c641();
    thread function_3c7a908d();
    thread mp_av_att_t10_vm_p01_dm_sroger25_underbarrel_dm_p01_fl_tr();
    thread function_1ce84183();
    thread function_bc4a48ea();
    waitframe( 1 );
    org = getent( "rpg_guy_plane_spot", "script_noteworthy" );
    level.plane_rpg_guy = spawner::simple_spawn_single( "plane_rpg_guy" );
    level.plane_rpg_guy linkto( org, undefined, ( 0, 0, 0 ), ( 0, 180, 0 ) );
    level.plane_rpg_guy val::set( #"af_chase", "ignoreall", 1 );
    level waittill( #"car_on_ground" );
    thread function_1c4bdba5();
    player thread util::show_hint_text( #"hash_7aca54ffec0ead0c", 0, "player_driving", -1 );
    player thread function_8bbbfc85();
    thread function_afa87bfc( player );
    level flag::wait_till( "af_start_crash" );
    player enableweapons();
    namespace_82bfe441::fade( 0, "FadeSlow" );
    level objectives::complete( "af_chase_plane_rc", level.var_c7b3a621 );
    level.player notifyonplayercommand( "blow_rc_car", "+vehicleattack" );
    thread function_7766538b();
    player waittill( #"blow_rc_car" );
    level notify( #"starting_crash_seq" );
    player prompts::remove( #"vehicle_attack" );
    level music::setmusicstate( "none" );
    level.player cp_takedown_fx::function_6539055f();
    
    if ( !level flag::get( "af_start_crash" ) )
    {
        level util::missionfailedwrapper( #"hash_4efe29bbbdba2730", #"hash_4d4c51db77bea4d0" );
        level flag::set( "failed_chase" );
    }
    
    if ( level flag::get( "failed_chase" ) )
    {
        level waittill( #"forever" );
    }
    
    level.player notifyonplayercommandremove( "blow_rc_car", "+vehicleattack" );
    level.rc_car makevehicleusable();
    level.rc_car useby( player );
    level.rc_car makevehicleunusable();
    level.rc_car linkto( level.af_plane );
    setdvar( #"r_motionblurmode", 2 );
    array::add( level.var_2e151cca, level.plane_rpg_guy );
    
    foreach ( guy in level.var_2e151cca )
    {
        if ( isalive( guy ) )
        {
            guy kill();
        }
    }
    
    vehs = arraycombine( getvehiclearray( "af_enemy_chase_veh_r", "script_noteworthy" ), getvehiclearray( "af_enemy_chase_veh_l", "script_noteworthy" ) );
    vehs = arraycombine( vehs, getvehiclearray( "pre_chase_delete_vehs", "script_noteworthy" ) );
    
    foreach ( veh in vehs )
    {
        snd::client_targetname( veh, "enemy_chase_veh_tires" );
        veh vehicle_death::death_cleanup_riders();
        veh delete();
    }
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x200d39b4, Offset: 0x2208
// Size: 0x274
function function_8bbbfc85()
{
    thread function_cc5078c1();
    
    while ( length( self getnormalizedmovement() ) < 0.1 )
    {
        waitframe( 1 );
    }
    
    level.player notify( #"player_driving" );
    wait 1;
    
    if ( !level flag::get( "rc_boosted" ) )
    {
        level.player thread util::show_hint_text( #"hash_4b6208b00403f13f", 0, [ "rc_detonate", "rc_boosted" ], -1 );
        level.player waittill( #"rc_boosted" );
    }
    
    level.player endon( #"blow_rc_car" );
    var_727f982c = 20;
    var_727f982c *= 39.3701;
    
    while ( true )
    {
        old_dist = distance2d( level.rc_car.origin, level.af_plane.origin );
        wait 5;
        new_dist = distance2d( level.rc_car.origin, level.af_plane.origin );
        
        if ( new_dist > old_dist || abs( old_dist - new_dist ) < var_727f982c )
        {
            level.player thread util::show_hint_text( #"hash_4b6208b00403f13f", 0, [ "rc_detonate", "rc_boosted" ], -1 );
            thread function_cc5078c1();
            level.player waittill( #"rc_boosted" );
        }
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x24a27e27, Offset: 0x2488
// Size: 0x82
function function_cc5078c1()
{
    level.player endon( #"blow_rc_car" );
    
    while ( true )
    {
        if ( self boostbuttonpressed() )
        {
            level.player notify( #"rc_boosted" );
            level flag::set( "rc_boosted" );
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xdcfa044, Offset: 0x2518
// Size: 0x94
function function_1ce84183()
{
    level.player endon( #"blow_rc_car" );
    level.rc_car waittill( #"death", #"killed" );
    level flag::set( "failed_chase" );
    level util::missionfailedwrapper( #"hash_4efe29bbbdba2730", #"hash_2f0e469c0a45ac0" );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xad76744, Offset: 0x25b8
// Size: 0x6c
function function_9509c87f()
{
    level.woods dialogue::radio( "vox_cp_tdwn_07400_wood_goddamnittheyre_69" );
    level util::delay_notify( 2.5, "show_rc_hint" );
    level.adler dialogue::radio( "vox_cp_tdwn_07400_adlr_werenotdoneyetb_2d" );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x9815f29a, Offset: 0x2630
// Size: 0x214
function function_761593b3()
{
    level endon( #"hash_1177fa275536c828" );
    level waittill( #"show_rc_hint" );
    player = getplayers()[ 0 ];
    player thread util::show_hint_text( #"hash_102900bc26caa616", undefined, "rcxd_stop_hint_controller", -1 );
    
    while ( true )
    {
        if ( player actionslotfourbuttonpressed() )
        {
            player notify( #"rcxd_stop_hint_controller" );
            break;
        }
        
        waitframe( 1 );
    }
    
    thread namespace_82bfe441::fade( 1, "FadeFast" );
    level notify( #"hash_2c1821278dd7ecb1" );
    level flag::set( "af_pressed_rc_button" );
    level music::setmusicstate( "b6.0_rc" );
    level objectives::complete( "af_chase_plane", level.af_plane );
    controller = getweapon( #"hash_1a8252eba901e734" );
    player giveweapon( controller );
    player switchtoweapon( controller );
    player disableweaponcycling();
    level waittill( #"hash_2000b4f0550d06a6" );
    player enableweaponcycling();
    player takeweapon( controller );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xb9793, Offset: 0x2850
// Size: 0xd8
function function_7766538b()
{
    level endon( #"rc_detonate" );
    level flag::wait_till( "af_start_crash" );
    player = getplayers()[ 0 ];
    player prompts::create( #"vehicle_attack", #"hash_6e490c4cf7210a63" );
    
    while ( true )
    {
        level flag::wait_till( "af_start_crash" );
        level flag::wait_till_clear( "af_start_crash" );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x51499a0c, Offset: 0x2930
// Size: 0x224
function function_afa87bfc( *player )
{
    level endon( #"af_doing_crash" );
    wait 2;
    level thread util::handle_nags( [ "vox_cp_tdwn_07500_adlr_takeoutthelandi_3b", "vox_cp_tdwn_07500_adlr_getundertheplan_10", "vox_cp_tdwn_07500_adlr_hurrybeforeitta_8a", "vox_cp_tdwn_07500_adlr_wererunningouto_0c", "vox_cp_tdwn_07500_adlr_getnearoneofthe_67" ], "af_start_crash", 4 );
    level flag::wait_till( "af_plane_raise_gate" );
    level notify( #"hash_4cd47970be99bc1b" );
    clips = getentarray( "plane_floor_clip", "targetname" );
    array::delete_all( clips );
    level.af_plane scene::play( "scene_tkd_hit3_chase_plane", "close_doors" );
    
    if ( !level flag::get( "af_plane_takeoff" ) )
    {
        level.af_plane thread scene::play( "scene_tkd_hit3_chase_plane", "doorup" );
    }
    
    level flag::wait_till( "af_plane_takeoff" );
    
    if ( !level flag::get( "af_doing_crash" ) )
    {
        level.af_plane thread scene::play( "scene_tkd_hit3_chase_plane", "takeoff" );
        level waittill( #"hash_1aef226070f83b0b" );
        thread function_b46ef638( 0.1, "starting_crash_seq" );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x2ffbbd67, Offset: 0x2b60
// Size: 0x2e8
function function_9555ada1()
{
    level endon( #"hash_2c1821278dd7ecb1" );
    level thread function_2205d3f9();
    level flag::wait_till( "af_chase_fire_rpg" );
    weapon = getweapon( "launcher_standard_t9_takedown_chase" );
    org = level.af_plane gettagorigin( "tag_body_ramp_rear_lower_animate" ) + ( 0, 0, 60 );
    trucks = getvehiclearray( "af_enemy_chase_veh_l", "script_noteworthy" );
    truck = array::get_all_closest( level.player.origin, trucks, undefined, 1, 5000 )[ 0 ];
    
    if ( isdefined( truck ) )
    {
        /#
            debugaxis( truck.origin, truck.angles, 36 );
        #/
        
        var_d5843701 = vectornormalize( truck.origin + ( 0, 0, 200 ) - org );
        var_9441d79a = anglestoforward( truck.angles );
        missile = level.player magicmissile( weapon, org, var_d5843701 );
        missile missile_settarget( truck, ( 0, 0, 30 ) );
    }
    
    level flag::wait_till( "af_start_rc_car" );
    
    while ( !flag::get( "af_start_crash" ) )
    {
        org = level.af_plane gettagorigin( "tag_body_ramp_rear_lower_animate" ) + ( 0, 0, 60 );
        var_d5843701 = vectornormalize( level.player.origin + ( 0, 0, 100 ) - org );
        missile = level.player magicmissile( weapon, org, var_d5843701 );
        wait randomfloatrange( 3, 5 );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x5e93e21, Offset: 0x2e50
// Size: 0xfc
function function_2205d3f9()
{
    level waittill( #"hash_6526e39540234e50" );
    trucks = getvehiclearray( "af_enemy_chase_veh_l", "script_noteworthy" );
    truck = array::get_all_closest( level.player.origin, trucks, undefined, 1, 5000 )[ 0 ];
    
    if ( isdefined( truck ) )
    {
        snd::play( "veh_tkd_chase_jeepbump_rev", truck );
        truck callback::on_vehicle_collision( &function_bfd50c68 );
        truck waittill( #"death" );
        snd::play( "veh_tkd_chase_jeepbump_explo_01", truck );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xe65a008b, Offset: 0x2f58
// Size: 0x2b6
function function_f8223b2e()
{
    self endon( #"death" );
    level endon( #"hash_2b1bc16a2395a69d", #"hash_351eb749d2c8fa9c" );
    var_93eeb60a = "shake_med";
    max_speed = 1000;
    
    while ( true )
    {
        scalar = 1;
        
        if ( level.rc_car.active === 1 )
        {
            scalar = level.rc_car.vehspeed / max_speed;
            scalar = max( 0, min( 1, scalar ) );
        }
        
        source = self.origin;
        pitch = randomfloatrange( 0, 0.15 ) * scalar;
        yaw = randomfloatrange( 0, 0.15 ) * scalar;
        roll = 0;
        duration = randomfloatrange( 0.25, 1 );
        freqpitch = randomfloatrange( 2.5, 3.5 );
        freqyaw = randomfloatrange( 2.5, 3.5 );
        
        if ( var_93eeb60a == "shake_med" )
        {
            pitch = randomfloatrange( 0.02, 0.35 ) * scalar;
            yaw = randomfloatrange( 0.02, 0.25 ) * scalar;
            roll = randomfloatrange( 0.02, 0.1 ) * scalar;
            duration = 1;
            freqpitch = 10;
            freqyaw = 7;
        }
        
        if ( pitch + yaw > 0.025 )
        {
            screenshake( source, pitch, yaw, roll, duration, 0, 0, 0, freqpitch, freqyaw );
        }
        
        wait duration;
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x5ce2b09, Offset: 0x3218
// Size: 0xd4
function function_9d8f5cd3()
{
    level endon( #"skip_grenade" );
    level flag::wait_till( "af_grenade_toss" );
    level flag::wait_till( "af_grenade_boom" );
    player = getplayers()[ 0 ];
    player setstance( "prone" );
    player freezecontrolsallowlook( 1 );
    wait 3;
    level.players[ 0 ] freezecontrolsallowlook( 0 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xa06dab45, Offset: 0x32f8
// Size: 0x3ac
function function_4c87c5cf()
{
    plane = level.af_plane;
    org = level.plane_mover;
    plane thread function_3bbaf145();
    thread namespace_b100dd86::function_1c77193b( plane );
    start_pos = struct::get( "plane_chase_start_pos", "targetname" );
    plane clientfield::set( "clf_cargoplane_door_sparks", 1 );
    level thread function_e234cffa( plane );
    exploder::exploder_stop( "hit3_prop_mist" );
    org moveto( start_pos.origin, 20, 3, 0 );
    org rotateto( start_pos.angles, 20, 3, 0 );
    thread function_b46ef638( 20, "af_player_start_ride" );
    snd::client_targetname( org, "cargo_plane" );
    snd::client_msg( #"cargo_plane_takeoff" );
    snd::client_msg( #"hash_5ab7f237fe5d4da8" );
    level waittill( #"player_lookdown" );
    org moveto( start_pos.origin, 3.5, 0, 1 );
    org rotateto( start_pos.angles, 3.5, 0, 1 );
    flag::wait_till( "af_start_ride" );
    level notify( #"skip_grenade" );
    end_pos = struct::get( "plane_chase_end_pos", "targetname" );
    var_bf626e36 = 53.5;
    var_e973bd14 = 6.5;
    org moveto( end_pos.origin, var_bf626e36 + var_e973bd14, 10, 0 );
    org rotateto( end_pos.angles, var_bf626e36 + var_e973bd14, 10, 0 );
    level endon( #"hash_2c1821278dd7ecb1" );
    wait var_bf626e36;
    
    if ( !flag::get( "af_pressed_rc_button" ) )
    {
        level notify( #"hash_1177fa275536c828" );
        level.af_plane thread scene::play( "scene_tkd_hit3_chase_plane", "takeoff_fail" );
        wait 1;
        level flag::set( "failed_chase" );
        level util::missionfailedwrapper( #"hash_4efe29bbbdba2730", #"hash_4d4c51db77bea4d0" );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x82a268e0, Offset: 0x36b0
// Size: 0x1ac
function mp_av_att_t10_vm_p01_dm_sroger25_underbarrel_dm_p01_fl_tr()
{
    level endon( #"starting_crash_seq" );
    org = level.plane_mover;
    end_pos = struct::get( "plane_chase_end_pos", "targetname" );
    start_pos = struct::get( "rc_car_plane_start_pos", "targetname" );
    org moveto( start_pos.origin, 0.01 );
    org rotateto( start_pos.angles, 0.01 );
    waitframe( 1 );
    waitframe( 1 );
    var_bf626e36 = 30;
    var_e973bd14 = 12;
    org moveto( end_pos.origin, var_bf626e36 + var_e973bd14, 1 );
    org rotateto( end_pos.angles, var_bf626e36 + var_e973bd14, 1 );
    wait var_bf626e36;
    level flag::set( "af_plane_raise_gate" );
    level flag::set( "af_plane_takeoff" );
    thread function_b46ef638( var_e973bd14, "starting_crash_seq" );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 2
// Checksum 0x4f5c4953, Offset: 0x3868
// Size: 0x74
function function_b46ef638( time, end_notify )
{
    level endon( end_notify );
    wait time;
    level flag::set( "failed_chase" );
    level util::missionfailedwrapper( #"hash_4efe29bbbdba2730", #"hash_4d4c51db77bea4d0" );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x8d034095, Offset: 0x38e8
// Size: 0x128
function function_3bbaf145()
{
    level endon( #"af_plane_raise_gate" );
    
    while ( !level flag::get( "af_start_rc_car" ) )
    {
        self thread scene::play( "scene_tkd_hit3_chase_plane", "idle_drive" );
        wait randomfloatrange( 5, 10 );
        
        if ( !level flag::get( "af_start_rc_car" ) )
        {
            if ( randomint( 2 ) )
            {
                self scene::play( "scene_tkd_hit3_chase_plane", "swerve" );
            }
            else
            {
                self scene::play( "scene_tkd_hit3_chase_plane", "swerve2" );
            }
            
            continue;
        }
        
        self thread scene::play( "scene_tkd_hit3_chase_plane", "idle_drive" );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xbfd1be69, Offset: 0x3a18
// Size: 0x2c4
function function_3a97edf()
{
    player = getplayers()[ 0 ];
    level waittill( #"rc_detonate" );
    function_41c091de( player.origin );
    self waittill( #"hash_474a6dde316a444d" );
    function_c716afe1( player.origin );
    self waittill( #"hash_1780176f9d302d25" );
    function_9547ba99( player.origin );
    self waittill( #"hash_75c2a1c8e3b8b7f1" );
    function_43cc6136( player.origin );
    self waittill( #"hash_474a6dde316a444d" );
    function_c716afe1( player.origin );
    self waittill( #"hash_474a6dde316a444d" );
    function_41c091de( player.origin );
    self waittill( #"hash_a71dd4f0ea1a311" );
    function_46d1f44( player.origin );
    self waittill( #"hash_a71dd4f0ea1a311" );
    function_46d1f44( player.origin );
    self waittill( #"hash_474a6dde316a444d" );
    function_c716afe1( player.origin );
    self waittill( #"hash_474a6dde316a444d" );
    function_c716afe1( player.origin );
    self waittill( #"hash_474a6dde316a444d" );
    function_41c091de( player.origin );
    self waittill( #"hash_474a6dde316a444d" );
    function_c716afe1( player.origin );
    self waittill( #"hash_474a6dde316a444d" );
    function_c716afe1( player.origin );
    self waittill( #"hash_474a6dde316a444d" );
    function_41c091de( player.origin );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0xea1636f9, Offset: 0x3ce8
// Size: 0x4c
function function_41c091de( origin )
{
    screenshake( origin, 4, 0, 2, 0.66, 0, 0.66, 0, 10, 0, 20, 2 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x5d388f27, Offset: 0x3d40
// Size: 0x4c
function function_c716afe1( origin )
{
    screenshake( origin, 2, 0, 0, 0.5, 0, 0.5, 0, 10, 0, 20, 2 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x1d7f0351, Offset: 0x3d98
// Size: 0x44
function function_9547ba99( origin )
{
    screenshake( origin, 4, 0, 0, 1, 0, 1, 0, 5, 0, 0, 2 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0xbf492329, Offset: 0x3de8
// Size: 0x54
function function_43cc6136( origin )
{
    screenshake( origin, 2, 1, 1, 1, 0.2, 0.75, 0, 4, 2, 2, 4 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x441aeb56, Offset: 0x3e48
// Size: 0x44
function function_46d1f44( origin )
{
    screenshake( origin, 0, 5, 1, 1, 0, 1, 0, 0, 4, 2, 2 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xa7e9151a, Offset: 0x3e98
// Size: 0x3c
function function_cd9b97a8()
{
    level flag::wait_till( "af_start_crash" );
    self delete();
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0xddb35d54, Offset: 0x3ee0
// Size: 0x44
function function_e234cffa( plane )
{
    level waittill( #"hash_7fcda1d7fd297797" );
    plane clientfield::set( "clf_cargoplane_door_sparks", 0 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x74bf97cb, Offset: 0x3f30
// Size: 0x2ec
function function_d9fae56b()
{
    vehs = getvehiclearray( "af_chase_veh", "targetname" );
    chase_truck = vehs[ 0 ];
    trigs = getentarray( "get_in_truck_trig", "targetname" );
    
    foreach ( trig in trigs )
    {
        trig enablelinkto();
        trig linkto( chase_truck );
    }
    
    level.chase_truck = chase_truck;
    level.chase_truck val::set( #"chase", "allowdeath", 0 );
    snd::client_targetname( chase_truck, "plr_chase_veh" );
    snd::client_msg( #"hash_444d03e74f4e7552" );
    waitframe( 1 );
    var_87816bd7 = getent( "bronco_probe", "targetname" );
    
    if ( isdefined( var_87816bd7 ) )
    {
        var_87816bd7 linkto( level.chase_truck, "tag_body_animate", ( 0, 0, 44 ), ( 0, 0, 0 ) );
    }
    
    var_c4042c90 = getent( "bronco_bed_probe", "targetname" );
    
    if ( isdefined( var_c4042c90 ) )
    {
        var_c4042c90 linkto( level.chase_truck, "tag_body_animate", ( -48, 0, 56 ), ( 0, 0, 0 ) );
    }
    
    level.chase_truck vehicle::lights_on();
    level.chase_truck vehicle::toggle_force_driver_taillights( 1 );
    level.chase_truck cp_takedown_fx::function_4c265dee();
    level.chase_truck thread function_c0061b42();
    level.chase_truck setmovingplatformenabled( 1, 0 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x9a2e85ad, Offset: 0x4228
// Size: 0xa2c
function function_b90ebd9a()
{
    util::magic_bullet_shield( level.woods );
    level.woods thread util::handle_nags( [ "vox_cp_tdwn_07200_wood_comeongetin_fa", "vox_cp_tdwn_07200_wood_letsgomoveit_7f", "vox_cp_tdwn_07200_wood_hopin_3f", "vox_cp_tdwn_07200_wood_getinwecancatch_96" ], "af_player_start_ride", 3 );
    level objectives::complete( "af_follow_adler", level.adler );
    objectives::function_4eb5c04a( "af_get_in_truck", level.chase_truck gettagorigin( "tag_bed" ) + ( 0, 0, 24 ) );
    level flag::wait_till_any( [ "af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right" ] );
    level.player namespace_6cecf2d8::function_9fa1a484();
    snd::play( "evt_tkd_chase_veh_enter", level.player );
    snd::client_msg( #"hash_59fa1dfa8bec8836" );
    level flag::set( "af_player_start_ride" );
    battlechatter::function_2ab9360b( 0 );
    level objectives::complete( "af_get_in_truck" );
    level.player = level.players[ 0 ];
    level.player cp_takedown_fx::function_ec0a577();
    thread function_d3cdf2a7();
    a_ar = getweapon( #"ar_accurate_t9" );
    level.adler setweapon( a_ar );
    level.player.fakeplayer = util::spawn_player_clone( level.player );
    level.player.fakeplayer.targetname = "FakePlayer 2";
    level.player.fakeplayer ghost();
    level.player.fakeplayer dontinterpolate();
    shot = undefined;
    
    if ( level flag::get( "af_player_get_in_back" ) )
    {
        shot = "get_in";
        anim = #"hash_5916909863e780a8";
    }
    else if ( level flag::get( "af_player_get_in_right" ) )
    {
        shot = "get_in_right";
        anim = #"hash_139b3208e93b39f5";
    }
    else
    {
        shot = "get_in_left";
        anim = #"hash_697f6a68b0ce4e60";
    }
    
    level.chase_truck thread scene::play( "scene_tkd_hit3_chase_getin", "get_in" );
    level.chase_truck clientfield::set( "4x4_getin_door", 1 );
    level.chase_truck setanim( #"hash_7e2b806a227352d0", 1, 0, 1 );
    level thread function_db746914( shot );
    wait 0.05;
    var_1ae5ba85 = 0.2;
    var_84ce1e3d = 0.5;
    velocity = level.player getvelocity();
    speed = length( velocity );
    normalized_speed = math::normalize_value( 179, 324, speed );
    blendtime = lerpfloat( var_84ce1e3d, var_1ae5ba85, normalized_speed );
    var_9c329e3d = lerpfloat( 0.5, 0, normalized_speed );
    var_1f85a945 = lerpfloat( 0.5, 0, normalized_speed );
    
    if ( blendtime < 0.4 )
    {
        var_3bf4cdb7 = 2;
    }
    else
    {
        var_3bf4cdb7 = 1;
    }
    
    level.player val::set( #"chase", "disable_weapons", var_3bf4cdb7 );
    level.player val::set( #"chase", "freezecontrols", 1 );
    level.player playerlinktoblend( level.player.fakeplayer, "tag_player", blendtime, blendtime * var_9c329e3d, 0, blendtime, blendtime * var_1f85a945, 0, 1 );
    wait blendtime;
    level.player.fakeplayer show();
    level waittill( #"raise_gun" );
    level.player val::set( #"chase", "allowdeath", 0 );
    thread namespace_a052577e::function_bbedb5ab();
    level.player allowjump( 0 );
    level.player val::set( #"rc_chase", "allow_mantle", 0 );
    primary_weapon = getweapon( #"hash_6fb64cfdd4c51dba", array( "reflex", "steadyaim" ) );
    
    if ( level.player hasweapon( primary_weapon ) )
    {
        level.player switchtoweapon( primary_weapon );
    }
    else
    {
        weaps = level.player getweaponslistprimaries();
        level.player switchtoweapon( weaps[ 0 ] );
    }
    
    level.player val::reset( #"chase", "freezecontrols" );
    level.player val::reset( #"chase", "disable_weapons" );
    level flag::set( "af_start_ride" );
    level.chase_truck thread vehicle::go_path();
    objectives::function_4eb5c04a( "af_chase_plane", level.af_plane );
    objectives::function_67f87f80( "af_chase_plane", [ level.af_plane ], #"hash_2b84cc72687b168a" );
    level.player thread function_f8223b2e();
    level waittill( #"hash_7dd48b5765cd3020" );
    level.woods stopanimscripted();
    level.chase_truck thread scene::play( "scene_tkd_hit3_chase" );
    level.chase_truck thread function_8d9f9fd7();
    waitframe( 1 );
    function_6c9a840b();
    level.adler thread dialogue::radio( "vox_cp_tdwn_07200_adlr_gogo_ef" );
    var_f0935a68 = getweapon( #"hash_6fb64cfdd4c51dba", 1 );
    
    if ( !level.player hasweapon( var_f0935a68 ) )
    {
        level.player giveweapon( var_f0935a68 );
    }
    
    level.player givemaxammo( var_f0935a68 );
    level.player switchtoweapon( var_f0935a68 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x20384b35, Offset: 0x4c60
// Size: 0x94
function function_db746914( shot )
{
    level.chase_truck scene::play( "scene_tkd_hit3_chase_getin_player", shot, level.player.fakeplayer );
    level.player unlink();
    
    if ( isdefined( level.player.fakeplayer ) )
    {
        level.player.fakeplayer delete();
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x76f5ce66, Offset: 0x4d00
// Size: 0x5c
function function_6c9a840b()
{
    level.rc_car = vehicle::simple_spawn( "player_rc_car" )[ 0 ];
    level.rc_car makevehicleunusable();
    level.rc_car notsolid();
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x3c3fad30, Offset: 0x4d68
// Size: 0x274
function function_dcc35e0b()
{
    level flag::wait_till( "woods_get_in_truck" );
    
    if ( !flag::get( "woods_waiting_at_truck" ) )
    {
        level flag::wait_till_any( [ "af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right" ] );
        level waittill( #"player_lookdown" );
    }
    
    level.chase_truck thread scene::play( "scene_tkd_hit3_pre_chase", "exit", [ level.woods ] );
    level.chase_truck clientfield::set( "4x4_getin_door_woods", 1 );
    level.chase_truck setanim( #"hash_7310b4167a3dbe5f", 1, 0, 1 );
    
    if ( !flag::get_any( [ "af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right" ] ) )
    {
        level waittill( #"hash_17a948f941d73226" );
        
        if ( !flag::get_any( [ "af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right" ] ) )
        {
            level flag::wait_till_any( [ "af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right" ] );
            level.chase_truck thread scene::play( "scene_tkd_hit3_pre_chase", "chase_start", [ level.woods ] );
        }
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x50401a7f, Offset: 0x4fe8
// Size: 0x1c2
function function_8d9f9fd7()
{
    level endon( #"af_start_rc_car" );
    
    for ( skip_idle = 0; true ; skip_idle = 1 )
    {
        if ( !skip_idle )
        {
            self thread scene::play( "scene_tkd_hit3_chase_adler", "loop" );
        }
        
        wait randomfloatrange( 1, 5 );
        vehs = getvehiclearray( "af_enemy_chase_veh_r", "script_noteworthy" );
        
        if ( vehs.size > 0 )
        {
            vehs = array::get_all_closest( level.adler.origin, vehs );
            dot = level.chase_truck math::get_dot_forward( vehs[ 0 ].origin, 1, 1 );
            shot = "shoot_right_";
            
            if ( dot > 0.2 )
            {
                shot = "shoot_forward_";
            }
            else if ( dot < -0.2 )
            {
                shot = "shoot_behind_";
            }
            
            shot += string( randomint( 2 ) + 1 );
            self scene::play( "scene_tkd_hit3_chase_adler", shot );
            skip_idle = 0;
            continue;
        }
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xb01fd434, Offset: 0x51b8
// Size: 0x70
function function_c0061b42()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_1bab4b4669295d55" );
        self cp_takedown_fx::function_4b711786();
        self waittill( #"hash_26c4e6fedc0c9799" );
        self cp_takedown_fx::function_b21aeabe();
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x860899b9, Offset: 0x5230
// Size: 0x6e
function function_d4dfd1df()
{
    self endon( #"death" );
    
    /#
        while ( true )
        {
            util::debug_line( self.origin, self.origin + ( 0, 0, 5000 ), ( 0, 1, 0 ), undefined, undefined, 1 );
            waitframe( 1 );
        }
    #/
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x34f5fe9a, Offset: 0x52a8
// Size: 0x144
function function_d3cdf2a7()
{
    level flag::wait_till( "af_player_start_ride" );
    level waittill( #"player_lookdown" );
    thread function_142791a7();
    vehs = vehicle::simple_spawn( "af_enemy_chase_veh" );
    level.var_57c220b5 = 0;
    
    foreach ( veh in vehs )
    {
        snd::client_targetname( veh, "af_enemy_chase_veh" );
    }
    
    snd::client_msg( #"hash_706ce4bbfd6f3342" );
    snd::client_msg( "chase_whooshes" );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xab4870a7, Offset: 0x53f8
// Size: 0x2f8
function function_142791a7()
{
    level.var_d18d2af9 = [];
    level.var_d18d2af9[ #"af_enemy_chase_veh_r" ] = 0;
    level.var_d18d2af9[ #"af_enemy_chase_veh_l" ] = 0;
    sides = [ "af_enemy_chase_veh_l", "af_enemy_chase_veh_r" ];
    
    foreach ( side in sides )
    {
        level.var_d18d2af9[ side ] = 0;
        level flag::set( side );
    }
    
    while ( !level flag::get( "af_start_rc_car" ) )
    {
        foreach ( side in sides )
        {
            if ( level.var_d18d2af9[ side ] <= 0 && !level flag::get( side ) )
            {
                level.var_d18d2af9[ side ] = 0;
                level flag::set( side );
            }
            
            if ( level.var_d18d2af9[ side ] > 0 && level flag::get( side ) )
            {
                level flag::clear( side );
                trigs = getentarray( side + "_trig", "targetname" );
                
                foreach ( trig in trigs )
                {
                    trig triggerenable( 0 );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0xe6950e4a, Offset: 0x56f8
// Size: 0x72
function function_3683d2e8( truck )
{
    level.var_d18d2af9[ truck.script_noteworthy ]++;
    truck waittill( #"death", #"kill_self", #"hash_38e103e482582e7f" );
    level.var_d18d2af9[ truck.script_noteworthy ]--;
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x6bbcabf7, Offset: 0x5778
// Size: 0xbc
function function_bfd50c68( params )
{
    var_53c5484a = 20;
    
    if ( !isdefined( self.var_4810ca3e ) )
    {
        self.var_4810ca3e = 0;
    }
    
    if ( isalive( self ) && isdefined( params.entity ) && params.entity == level.chase_truck && gettime() > self.var_4810ca3e )
    {
        self.var_4810ca3e = gettime() + var_53c5484a;
        self notify( #"crunch" );
        snd::play( "veh_tkd_chase_jeepbump_impact", self );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x8b51479, Offset: 0x5840
// Size: 0x264
function function_40c45b6()
{
    self endon( #"death" );
    thread function_3683d2e8( self );
    self.takedamage = 1;
    snd::client_targetname( self, "af_enemy_chase_veh" );
    snd::client_targetname( self, "chase_whooshes" );
    
    while ( !isdefined( self.var_761c973.riders[ #"driver" ] ) )
    {
        wait 0.1;
    }
    
    self thread monitor_death();
    self thread function_b5d668a4( self.var_761c973.riders[ #"driver" ] );
    player = getplayers()[ 0 ];
    self thread function_367b3229( player );
    waitframe( 1 );
    self vehicle::lights_on();
    self vehicle::toggle_force_driver_taillights( 1 );
    self thread function_afa8ab9f();
    self waittill( #"kill_self" );
    self flag::set( "fake_dying" );
    snd::play( "veh_tkd_chase_npc_jeeps_skid_stop", self );
    self thread function_149a7584( level.chase_truck );
    var_b8ef2e = 0;
    
    if ( math::get_dot_right( player.origin, 1, 1 ) >= 0 )
    {
        var_b8ef2e = 1;
    }
    
    if ( randomfloat( 1 ) >= 0.25 )
    {
        wait 0.5;
        self function_ba23e9b( level.player, var_b8ef2e );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 2
// Checksum 0x21e78fe9, Offset: 0x5ab0
// Size: 0x18c
function function_ba23e9b( *player, var_b8ef2e )
{
    self vehicle::get_off_path();
    wait 0.1;
    right_vec = anglestoright( self.angles );
    fwd_vec = anglestoforward( self.angles );
    var_43939108 = ( -6, 0, 0 );
    var_5fb21670 = ( 0, 0, 0 );
    
    if ( !var_b8ef2e )
    {
        var_43939108 += right_vec * 24;
        var_5fb21670 = -1 * right_vec;
    }
    else
    {
        var_43939108 -= right_vec * 24;
        var_5fb21670 = right_vec;
    }
    
    var_5fb21670 = vectornormalize( var_5fb21670 );
    var_5fb21670 += ( 0, 0, 1 );
    var_5fb21670 *= 100;
    self launchvehicle( var_5fb21670, var_43939108, 1, 1 );
    self delete_riders( 1 );
    wait randomfloatrange( 0.75, 1.5 );
    
    if ( self.takedamage )
    {
        self kill();
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xb6d124a8, Offset: 0x5c48
// Size: 0x4c
function function_afa8ab9f()
{
    self endon( #"death" );
    self endon( #"delete" );
    self waittill( #"hash_38e103e482582e7f" );
    self vehicle::get_off_path();
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x58c4c0d6, Offset: 0x5ca0
// Size: 0x92
function function_367b3229( target )
{
    self endon( #"death" );
    self endon( #"kill_self" );
    self endon( #"delete" );
    
    while ( isalive( self ) )
    {
        self.var_135dba79 = self math::get_dot_forward( target.origin, 1 );
        waitframe( 1 );
        waitframe( 1 );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0xdd3b51d6, Offset: 0x5d40
// Size: 0x176
function function_b5d668a4( passenger )
{
    self endon( #"death" );
    level endon( #"af_start_rc_car" );
    passenger endon( #"death" );
    self thread function_868edfac( passenger );
    
    while ( passenger.health > 1 )
    {
        passenger waittill( #"damage" );
        
        if ( passenger.health > 1 )
        {
            level.player playhitmarker( undefined, 5, undefined, 0, 0, 0 );
        }
    }
    
    level.player playhitmarker( undefined, 5, undefined, 1 );
    passenger notify( #"fake_death" );
    passenger stopanimscripted();
    
    if ( isalive( self ) )
    {
        self thread scene::play( "scene_tkd_hit3_chase_jeep_driver", "death", [ passenger ] );
    }
    
    self notify( #"kill_self" );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0xd4d5b344, Offset: 0x5ec0
// Size: 0x1a8
function function_868edfac( passenger )
{
    self endon( #"death" );
    self endon( #"hash_2b34ed034183965" );
    passenger endon( #"fake_death" );
    passenger endon( #"death" );
    
    while ( isalive( self ) )
    {
        self thread scene::play( "scene_tkd_hit3_chase_jeep_driver", "idle", [ passenger ] );
        wait randomfloatrange( 3, 5 );
        
        while ( self.var_135dba79 > 0 )
        {
            wait randomfloatrange( 1, 3 );
        }
        
        passenger stopanimscripted();
        
        if ( isalive( self ) )
        {
            if ( self.script_noteworthy == "af_enemy_chase_veh_r" )
            {
                self scene::play( "scene_tkd_hit3_chase_jeep_driver", "Look_Back_Left", [ passenger ] );
                continue;
            }
            
            self scene::play( "scene_tkd_hit3_chase_jeep_driver", "Look_Back_Right", [ passenger ] );
        }
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x3ec9d6f0, Offset: 0x6070
// Size: 0x1e2
function delete_riders( launch = 0 )
{
    if ( isdefined( self.var_761c973 ) && isdefined( self.var_761c973.riders ) )
    {
        foreach ( rider in self.var_761c973.riders )
        {
            if ( isdefined( rider ) )
            {
                rider notify( #"fake_death" );
                
                if ( launch )
                {
                    rider stopanimscripted();
                    rider val::set( "chase_enemy", "allowdeath", 1 );
                    rider unlink();
                    rider startragdoll( 1 );
                    launch_force = rider.origin - self.origin;
                    launch_force = ( vectornormalize( launch_force ) + anglestoup( self.angles ) ) * 50;
                    rider launchragdoll( launch_force );
                    continue;
                }
                
                rider deletedelay();
            }
        }
        
        self.var_761c973.riders = [];
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xf8dab620, Offset: 0x6260
// Size: 0x70
function monitor_death()
{
    level endon( #"death" );
    self waittill( #"death" );
    self delete_riders( 1 );
    level.var_57c220b5++;
    level notify( #"hash_25795a7707b10909" );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x5dfdcded, Offset: 0x62d8
// Size: 0x230
function function_9535c641()
{
    level.var_55e62e4f = vehicle::simple_spawn_and_drive( "af_enemy_deploy_veh_r" );
    level.var_55e62e4f = arraycombine( level.var_55e62e4f, vehicle::simple_spawn_and_drive( "af_enemy_deploy_veh_l" ) );
    level.var_55e62e4f = arraycombine( level.var_55e62e4f, vehicle::simple_spawn_and_drive( "af_enemy_deploy_veh_f" ) );
    level.var_57c220b5 = 0;
    
    foreach ( veh in level.var_55e62e4f )
    {
        veh.script_noteworthy = "rc_enemy";
        level.var_d18d2af9[ veh.script_noteworthy ] = 0;
        veh thread function_40c45b6();
        veh thread function_e6320cb3();
        veh vehicle::lights_on();
        veh vehicle::toggle_force_driver_taillights( 1 );
        snd::client_targetname( veh, "enemy_chase_veh_tires" );
        snd::client_msg( #"hash_55b5a5f81569910e" );
        veh thread function_6b9d341b();
        veh vehicle::god_on();
        veh val::set( #"rc_chase", "allowdeath", 0 );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xdcfb06ef, Offset: 0x6510
// Size: 0x54
function function_6b9d341b()
{
    self endon( #"death" );
    self waittill( #"lights_off" );
    self vehicle::lights_off();
    self vehicle::toggle_force_driver_taillights( 0 );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xbd371d27, Offset: 0x6570
// Size: 0x160
function function_7730c3f4()
{
    level.rc_car thread function_f311ea18( 1 );
    level.player = level.players[ 0 ];
    level.chase_truck clientfield::set( "af_rc_deploy1", 1 );
    level.chase_truck setanim( #"hash_65fb765a66b27ef1", 1, 0, 1 );
    level scene::play( "scene_tkd_hit3_chase_deploy_rc", "enter" );
    level thread scene::play( "scene_tkd_hit3_chase_deploy_rc", "loop" );
    level.chase_truck setanim( #"hash_77cbdb56c22e71f", 1, 0, 1 );
    level.chase_truck clientfield::set( "af_rc_deploy2", 1 );
    level waittill( #"hash_32caebf20e289c77" );
    waitframe( 1 );
    wait 2;
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xb94c794f, Offset: 0x66d8
// Size: 0x63c
function function_3c7a908d()
{
    thread namespace_a052577e::function_b3b2671a( level.player );
    var_f0d4082e = snd::play( "wpn_tkd_rcxd_start_bg_lp", level.rc_car );
    snd::client_targetname( level.chase_truck, "plr_chase_veh2" );
    snd::client_msg( #"hash_654febf566d7e79e" );
    snd::client_msg( #"hash_55b5a5f81569910e" );
    snd::play( [ 1.1, "wpn_tkd_rcxd_deploy_drop", 0 ], level.rc_car );
    snd::client_targetname( level.rc_car, "plr_rc_car" );
    snd::client_msg( "player_rc_car" );
    level.chase_truck clientfield::set( "af_rc_deploy3", 1 );
    level.chase_truck setanim( #"hash_3be8472c6114d6b6", 1, 0, 1 );
    level thread scene::play( "scene_tkd_hit3_chase_deploy_rc", "exit" );
    level.player cp_takedown_fx::function_701c25a5();
    level waittill( #"hash_2b34ed034183965" );
    snd::stop( var_f0d4082e, 3 );
    org = struct::get( "runway_center", "targetname" );
    corpses = ai::function_4f84c3ed( org.origin, 27500 );
    array::delete_all( corpses );
    vehs = arraycombine( getvehiclearray( "af_enemy_chase_veh_l", "script_noteworthy" ), getvehiclearray( "af_enemy_chase_veh_r", "script_noteworthy" ) );
    
    foreach ( veh in vehs )
    {
        veh vehicle_death::death_cleanup_riders();
        veh delete();
    }
    
    level notify( #"rcxd_stop_hint_controller" );
    level.player cp_takedown_fx::function_2be1d5b0();
    self thread scene::play( "scene_tkd_hit3_chase_adler", "loop" );
    level.chase_truck thread scene::play( "scene_tkd_hit3_chase", "loop" );
    waitframe( 1 );
    level.player enableweapons();
    level.player stopanimscripted( 0, 1 );
    level.rc_car solid();
    level.rc_car unlink();
    level.rc_car stopanimscripted();
    level.rc_car makevehicleusable();
    waitframe( 1 );
    level.rc_car launchvehicle( ( 1, 0, 0 ) * 35 );
    wait 0.5;
    level.player unlink();
    loc = struct::get( "rc_car_safespot", "targetname" );
    level.player setorigin( loc.origin );
    waitframe( 1 );
    
    if ( !level.player vehicle::player_is_driver() )
    {
        level notify( #"rcxd_stop_hint_controller" );
        level.rc_car makevehicleusable();
        level.rc_car usevehicle( level.player, 0 );
    }
    
    waitframe( 1 );
    level notify( #"car_on_ground" );
    level notify( #"hash_6f65948492627624" );
    level.rc_car thread function_c6a4d54b();
    wait 0.5;
    level objectives::function_4eb5c04a( "af_chase_plane_rc", level.var_c7b3a621 );
    level objectives::function_67f87f80( "af_chase_plane_rc", [ level.var_c7b3a621 ], #"hash_2b84cc72687b168a" );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x99817b1c, Offset: 0x6d20
// Size: 0x226
function function_53e16f01( params )
{
    /#
        if ( getdvarint( #"hash_72994415c8ecf806", 0 ) > 0 )
        {
            return;
        }
    #/
    
    if ( !isdefined( self.damage_timer ) )
    {
        self.damage_timer = 0;
    }
    
    var_d1148f2f = 1000;
    screenshake( self.origin, 2, 2, 6, 1, 0, -1, 0, 8, 4, 2, 2 );
    level.player playrumbleonentity( "damage_heavy" );
    
    if ( isdefined( params.entity ) && !( isdefined( params.entity.targetname ) && params.entity.targetname == "crater_clip" ) )
    {
        fwd_vec = anglestoforward( self.angles );
        dot = vectordot( fwd_vec, params.normal );
        var_9602c3bf = params.normal;
        
        if ( dot < 0 )
        {
            var_9602c3bf = vectornormalize( params.normal + fwd_vec );
        }
        
        knockback = -5;
        self launchvehicle( params.normal * knockback, ( 0, 0, 0 ), 1, 0 );
    }
    
    if ( isdefined( params.entity ) && gettime() > self.damage_timer )
    {
        self cp_takedown_fx::function_6bd3950d( 25 );
        self.damage_timer = gettime() + var_d1148f2f;
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x122d1afc, Offset: 0x6f50
// Size: 0x268
function function_bc4a48ea()
{
    level endon( #"death" );
    level waittill( #"car_on_ground" );
    wait 5;
    weapon = getweapon( "launcher_standard_t9_takedown_chase" );
    
    while ( !level flag::get( "af_plane_raise_gate" ) && isalive( level.plane_rpg_guy ) )
    {
        org = level.plane_rpg_guy gettagorigin( "tag_flash" );
        var_b26e76e3 = level.rc_car.origin + ( vectornormalize( anglestoforward( level.rc_car.angles ) ) + vectornormalize( org - level.rc_car.origin ) * 0.5 ) * 750;
        var_b26e76e3 = ( var_b26e76e3[ 0 ], var_b26e76e3[ 1 ], level.rc_car.origin[ 2 ] );
        
        if ( distancesquared( var_b26e76e3, org ) < 40000 )
        {
            var_b26e76e3 = level.rc_car.origin;
        }
        
        var_d5843701 = vectornormalize( var_b26e76e3 - org );
        missile = level.player magicmissile( weapon, org, var_d5843701 );
        playfxontag( #"hash_338c0ef8c7e88199", level.plane_rpg_guy, "tag_flash" );
        missile thread function_e652a247();
        wait randomfloatrange( 3, 6 );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x58392936, Offset: 0x71c0
// Size: 0x21e
function function_e652a247()
{
    level endon( #"death" );
    level endon( #"af_plane_raise_gate" );
    var_74fc3359 = struct::get( "runway_center", "targetname" );
    self waittill( #"death" );
    
    /#
    #/
    
    crater = spawn( "script_model", ( self.origin[ 0 ], self.origin[ 1 ], var_74fc3359.origin[ 2 ] ) );
    crater hide();
    crater.angles = ( 0, randomfloatrange( 0, 360 ), 0 );
    crater setmodel( "p8_zm_esc_spawn_cap_crater" );
    snd::play( "wpn_tkd_chase_rpg_imp", self );
    crater setscale( 0.15 );
    crater show();
    clip = getent( "crater_clip", "targetname" );
    
    if ( isdefined( clip ) && isdefined( crater ) )
    {
        clip.origin = crater.origin;
        clip.angles = crater.angles;
        level waittill( #"starting_crash_seq" );
        crater delete();
        clip.origin -= ( 0, 0, 20 );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x6ae5d099, Offset: 0x73e8
// Size: 0x19c
function function_c6a4d54b()
{
    level flag::wait_till( "af_enemy_skid" );
    var_4a0d7a89 = level.rc_car getspeedmph();
    
    if ( var_4a0d7a89 < 63 )
    {
        wait 2;
    }
    
    thread function_f92dfd2c();
    org = util::spawn_model( "tag_origin", level.af_plane.origin, ( 0, 0, 0 ) );
    org linkto( level.af_plane, undefined, ( 500, 500, -15 ), ( 0, 0, 0 ) );
    veh = vehicle::simple_spawn_single_and_drive( "skid_veh" );
    snd::client_targetname( veh, "skid_veh" );
    thread namespace_a052577e::function_32f20d13( veh );
    wait 0.1;
    veh vehicle::lights_on();
    veh vehicle::toggle_force_driver_taillights( 1 );
    org scene::play( "scene_tkd_hit3_chase_jeep_deaths", "runway_skid", [ veh ] );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x638f406b, Offset: 0x7590
// Size: 0x146
function function_f92dfd2c()
{
    var_ba5c0429 = 2000;
    
    for ( i = 1; i <= 5 ; i++ )
    {
        foreach ( truck in level.var_55e62e4f )
        {
            if ( isdefined( truck ) && isalive( truck ) && !truck flag::get( "fake_dying" ) )
            {
                if ( level.af_plane.origin[ 0 ] - truck.origin[ 0 ] < var_ba5c0429 )
                {
                    truck setspeed( 50, 20, 20 );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0x6b24298f, Offset: 0x76e0
// Size: 0x134
function function_f311ea18( var_bbe56cd4 = 0 )
{
    self notify( "7ef70d577a2a739e" );
    self endon( "7ef70d577a2a739e" );
    self endon( #"death" );
    
    if ( var_bbe56cd4 )
    {
        level waittill( #"hash_32caebf20e289c77" );
    }
    
    self cp_takedown_fx::function_f0ecd8();
    self cp_takedown_fx::function_3419411b();
    level waittill( #"car_on_ground" );
    self.active = 1;
    self thread function_2682a954();
    wait 2;
    level.rc_car callback::on_vehicle_collision( &function_53e16f01 );
    level waittill( #"rc_detonate" );
    self.active = undefined;
    self cp_takedown_fx::function_fe8be1e0();
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x149f301d, Offset: 0x7820
// Size: 0xa0
function function_2682a954()
{
    self endon( #"death" );
    level endon( #"rc_detonate" );
    
    while ( true )
    {
        self cp_takedown_fx::function_323b6e10();
        level flag::wait_till( "af_start_crash" );
        self cp_takedown_fx::function_53bd0317();
        level flag::wait_till_clear( "af_start_crash" );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x6a1ae41a, Offset: 0x78c8
// Size: 0x66c
function function_db378ce0()
{
    self endon( #"death" );
    self endon( #"fake_death" );
    self val::set( "chase_enemy", "allowdeath", 0 );
    
    if ( isdefined( self.script_noteworthy ) )
    {
        while ( !isdefined( self.vehicle ) )
        {
            wait 0.1;
        }
        
        if ( !isdefined( self.vehicle.var_349e69c4 ) )
        {
            self.vehicle.var_349e69c4 = 0;
        }
        
        self.vehicle.var_349e69c4++;
        anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_le_en2";
        var_fa4b90bc = "roll_r1";
        
        switch ( self.script_noteworthy )
        {
            case #"hash_1326aeed0f386d94":
                var_fa4b90bc = "tag_passenger2";
                anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_le_en2";
                break;
            case #"roll_l2":
                var_fa4b90bc = "tag_passenger3";
                anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_le_en3";
                break;
            case #"hash_1326b0ed0f3870fa":
                var_fa4b90bc = "tag_passenger1";
                anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_le_en4";
                break;
            case #"roll_r1":
                var_fa4b90bc = "tag_passenger2";
                anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_ri_en2";
                break;
            case #"hash_12c099ed0ee196b3":
                var_fa4b90bc = "tag_passenger3";
                anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_ri_en3";
                break;
            case #"hash_12c098ed0ee19500":
                var_fa4b90bc = "tag_passenger1";
                anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_ri_en4";
                break;
            case #"hash_48024b666fce275a":
                var_fa4b90bc = "tag_passenger2";
                anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_le_en2";
                break;
            case #"hard_l2":
                var_fa4b90bc = "tag_passenger3";
                anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_le_en3";
                break;
            case #"hash_480249666fce23f4":
                var_fa4b90bc = "tag_passenger1";
                anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_le_en4";
                break;
            case #"hash_47e02f666fb11160":
                var_fa4b90bc = "tag_passenger2";
                anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_ri_en2";
                break;
            case #"hash_47e032666fb11679":
                var_fa4b90bc = "tag_passenger3";
                anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_ri_en3";
                break;
            case #"hash_47e031666fb114c6":
                var_fa4b90bc = "tag_passenger1";
                anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_ri_en4";
                break;
        }
        
        self.vehicle thread scene::play( anim_scene, "idle", [ self ] );
        org = util::spawn_model( "tag_origin", self.vehicle.origin, self.vehicle.angles );
        org linkto( self.vehicle, var_fa4b90bc, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        self thread function_f6fcf011( org, anim_scene );
    }
    
    self thread function_ebfff762();
    
    if ( isdefined( self.script_noteworthy ) )
    {
        idle_shots = 1;
        
        if ( scene::function_9730988a( anim_scene, "idle3" ) )
        {
            idle_shots = 3;
        }
        
        while ( !level flag::get( "af_start_crash" ) )
        {
            var_6eeb49c8 = "firing";
            
            if ( isdefined( self.vehicle.var_135dba79 ) )
            {
                if ( self.vehicle.var_135dba79 > -0.36 )
                {
                    var_6eeb49c8 = "firing_side";
                }
                
                if ( self.vehicle.var_135dba79 < -0.98 )
                {
                    var_6eeb49c8 = "firing_rear";
                }
            }
            
            self stopanimscripted();
            org scene::play( anim_scene, var_6eeb49c8, [ self ] );
            
            if ( self.health > 1 )
            {
                var_ae72f23a = randomintrange( 1, idle_shots + 1 );
                var_27e1b0d4 = "idle";
                
                if ( var_ae72f23a > 1 )
                {
                    var_27e1b0d4 += string( var_ae72f23a );
                }
                
                org thread scene::play( anim_scene, var_27e1b0d4, [ self ] );
                level notify( #"chase_walla", { #enemy:self } );
                wait randomfloatrange( 0.2 * self.vehicle.var_349e69c4, 0.5 * self.vehicle.var_349e69c4 );
            }
            
            waitframe( 1 );
        }
    }
    
    level flag::wait_till( "af_start_crash" );
    
    if ( isdefined( org ) )
    {
        org delete();
    }
    
    if ( isdefined( self ) && isalive( self ) )
    {
        self deletedelay();
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x164741ee, Offset: 0x7f40
// Size: 0x88
function function_ebfff762()
{
    self endon( #"death" );
    self endon( #"fake_death" );
    level endon( #"af_start_rc_car" );
    
    while ( true )
    {
        self waittill( #"damage" );
        level.player playhitmarker( undefined, 5, undefined, 0, 0, 0 );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 2
// Checksum 0xa193021f, Offset: 0x7fd0
// Size: 0x22c
function function_f6fcf011( org, scene )
{
    level endon( #"hash_2b34ed034183965" );
    level endon( #"af_start_crash" );
    self endon( #"death" );
    self endon( #"delete" );
    self.vehicle endon( #"death" );
    
    while ( self.health > 2 )
    {
        wait 0.1;
    }
    
    waitframe( 1 );
    self.vehicle.var_349e69c4--;
    
    if ( self.vehicle.var_349e69c4 == 0 )
    {
        if ( true )
        {
            self.vehicle notify( #"kill_self" );
        }
        else
        {
            self.vehicle notify( #"hash_38e103e482582e7f" );
        }
    }
    
    level.player playhitmarker( undefined, 5, undefined, 1 );
    self notify( #"fake_death" );
    
    if ( isdefined( self.script_noteworthy ) )
    {
        var_f1fd7a1c = "death";
        
        if ( randomfloat( 1 ) >= 0.25 )
        {
            var_f1fd7a1c = "death2";
        }
        
        org scene::play( scene, var_f1fd7a1c, [ self ] );
        
        if ( isalive( self ) )
        {
            self stopanimscripted();
            self val::set( "chase_enemy", "allowdeath", 1 );
            self deletedelay();
        }
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0xb17ae3c3, Offset: 0x8208
// Size: 0x416
function function_149a7584( var_ba735fae )
{
    self endon( #"crash_done", #"crash_move_done", #"death" );
    self thread vehicle_death::monitor_ground_vehicle_crash_collision();
    self.crashing = 1;
    n_current_speed = self getspeedmph();
    
    if ( n_current_speed > 0 || is_true( self.b_stopped_crash ) )
    {
        if ( self vehicle_death::is_crash_detour_nearby() )
        {
            self notify( #"crashpath", { #path:self.nd_crash_path } );
            self.nd_crash_path.derailed = 1;
            self notify( #"newpath" );
            nd_switch = self.currentnode vehicle_death::get_switch_node( self.nd_crash_path );
            self setswitchnode( nd_switch, self.nd_crash_path );
            self thread vehicle_death::watch_for_crash_detour_scene( self.nd_crash_path );
            
            if ( n_current_speed == 0 )
            {
                n_current_speed = 5;
                self setbrake( 0 );
                self vehicle::resume_path();
                self resumespeed( 5 );
            }
            
            n_set_speed = n_current_speed * 3;
            self setspeed( n_set_speed, n_set_speed / 2 );
            self waittilltimeout( 15, #"reached_end_node" );
        }
        else
        {
            self vehicle::detach_path();
            
            if ( self math::get_dot_right( var_ba735fae.origin, 1, 1 ) > 0 )
            {
                n_modifier = 1;
            }
            else
            {
                n_modifier = -1;
            }
            
            if ( n_current_speed == 0 )
            {
                n_current_speed = 5;
                self setbrake( 0 );
                self vehicle::resume_path();
                self resumespeed( 5 );
            }
            
            v_goal = self.origin + anglestoforward( self.angles + ( 0, n_modifier * 35, 0 ) ) * 600;
            a_trace = physicstraceex( v_goal + ( 0, 0, 200 ), v_goal - ( 0, 0, 1000 ) );
            n_set_speed = n_current_speed * 3;
            self setspeed( n_set_speed, n_set_speed / 2 );
            self function_a57c34b7( a_trace[ #"position" ], 0 );
            self waittilltimeout( 15, #"near_goal" );
            self vehicle_ai::clearallmovement( 1 );
            self vehicle_ai::clearalllookingandtargeting();
        }
    }
    
    self notify( #"crash_done" );
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0xbb703149, Offset: 0x8628
// Size: 0xa8
function function_326abc48()
{
    level endon( #"starting_crash_seq" );
    var_8bd12fb4 = 2;
    var_1d542590 = 1;
    level.var_e37c1d1 = 0;
    
    while ( true )
    {
        waitresult = level waittill( #"chase_walla" );
        
        if ( level.var_e37c1d1 < var_8bd12fb4 )
        {
            waitresult.enemy thread function_e4f900a2( var_1d542590 );
        }
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0xb3245940, Offset: 0x86d8
// Size: 0x28
function function_e4f900a2( var_effc03f2 )
{
    level.var_e37c1d1++;
    wait var_effc03f2;
    level.var_e37c1d1--;
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x714342ea, Offset: 0x8708
// Size: 0xd6
function function_1c4bdba5()
{
    level.player endon( #"blow_rc_car" );
    var_b2462917 = 30;
    var_b2462917 *= 12;
    
    while ( true )
    {
        var_72f2834e = level.rc_car.origin + anglestoforward( level.rc_car.angles ) * 150;
        
        if ( var_72f2834e[ 0 ] - level.chase_truck.origin[ 0 ] > var_b2462917 )
        {
            level notify( #"hash_4a8efa61ddc01361" );
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 0
// Checksum 0x78609146, Offset: 0x87e8
// Size: 0x1ce
function function_e6320cb3()
{
    level.player endon( #"blow_rc_car" );
    self endon( #"death" );
    var_908eb0a2 = 50;
    var_908eb0a2 *= 12;
    var_908eb0a2 *= var_908eb0a2;
    var_5d248f34 = -1 * cos( 25 );
    level waittill( #"hash_4a8efa61ddc01361" );
    
    while ( true )
    {
        var_72f2834e = level.rc_car.origin + anglestoforward( level.rc_car.angles ) * 150;
        var_51fb6d83 = distance2dsquared( self.origin, var_72f2834e );
        
        if ( var_51fb6d83 <= var_908eb0a2 )
        {
            /#
            #/
            
            var_25e859c2 = self math::get_dot_forward( var_72f2834e, 1, 1 );
            
            if ( var_25e859c2 < 0 && var_25e859c2 > var_5d248f34 )
            {
                right_dot = self math::get_dot_right( var_72f2834e, 1, 1 );
                
                if ( right_dot > 0 )
                {
                    self function_b9613eb( 1 );
                }
                else
                {
                    self function_b9613eb( 0 );
                }
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace tkdn_af_chase/cp_takedown_af_chase
// Params 1
// Checksum 0xa38496c5, Offset: 0x89c0
// Size: 0x30c
function function_b9613eb( right = 1 )
{
    self endon( #"death" );
    level.player endon( #"blow_rc_car" );
    n_modifier = 1;
    
    if ( right )
    {
        n_modifier = -1;
    }
    
    var_28ec8367 = 4000000;
    cur_node = self.currentnode;
    next_node = getvehiclenode( cur_node.target, "targetname" );
    self vehicle::detach_path();
    n_current_speed = self getspeedmph();
    v_goal = self.origin + anglestoforward( self.angles + ( 0, n_modifier * 10, 0 ) ) * 1200;
    a_trace = physicstraceex( v_goal + ( 0, 0, 200 ), v_goal - ( 0, 0, 200 ) );
    self setspeed( n_current_speed );
    
    /#
    #/
    
    self function_a57c34b7( a_trace[ #"position" ], 0 );
    self waittilltimeout( 3, #"near_goal" );
    var_56b3db36 = math::get_dot_forward( next_node.origin, 1, 1 );
    var_26b9354a = cos( 10 );
    
    while ( isdefined( next_node ) && distance2dsquared( next_node.origin, self.origin ) < var_28ec8367 )
    {
        cur_node = next_node;
        next_node = getvehiclenode( cur_node.target, "targetname" );
    }
    
    if ( isdefined( next_node ) )
    {
        /#
        #/
        
        self function_a57c34b7( next_node.origin, 0 );
        self waittill( #"near_goal" );
        self vehicle::get_on_path( cur_node.target, "targetname" );
        self thread vehicle::go_path();
    }
}

