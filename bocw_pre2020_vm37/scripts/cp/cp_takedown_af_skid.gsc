#using script_31e9b35aaacbbd93;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_61cfc2ab8e60625;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_takedown_af_chase;
#using scripts\cp\cp_takedown_af_hill;
#using scripts\cp\cp_takedown_fx;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;

#namespace tkdn_af_skid;

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 1
// Checksum 0xcda38c4f, Offset: 0x298
// Size: 0x1ac
function starting( *var_d3440450 )
{
    namespace_b100dd86::function_5aabc3fb();
    level.af_plane = namespace_b100dd86::function_5431431d();
    namespace_b100dd86::function_c8381339( level.af_plane, 0 );
    thread namespace_b100dd86::function_1c77193b( level.af_plane );
    level.chase_truck = getvehiclearray( "af_chase_veh", "targetname" )[ 0 ];
    level.chase_truck vehicle::lights_on();
    level.chase_truck vehicle::toggle_force_driver_taillights( 1 );
    level.chase_truck cp_takedown_fx::function_4c265dee();
    tkdn_af_hill::function_a2015343();
    a_ar = getweapon( #"ar_accurate_t9" );
    level.adler setweapon( a_ar );
    level flag::set( "af_start_enemy_crash_vehs" );
    tkdn_af_chase::function_9535c641();
    setdvar( #"hash_135dec1a591c3c02", 0.05 );
    thread namespace_a052577e::function_3dbad6f5();
}

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 2
// Checksum 0xe08f5e3f, Offset: 0x450
// Size: 0x1c4
function main( var_d3440450, *var_50cc0d4f )
{
    player = getplayers()[ 0 ];
    setdvar( #"hash_3d9a09e7ecea2271", 0 );
    level clientfield::set( "crash_models", 1 );
    veh = vehicle::simple_spawn_single( "smash_veh" );
    wait 0.1;
    veh vehicle::lights_on();
    veh vehicle::toggle_force_driver_taillights( 1 );
    level flag::set( "af_doing_crash" );
    thread function_243c9d46( player );
    level notify( #"hash_2000b4f0550d06a6" );
    level flag::wait_till( "af_skid_complete" );
    
    if ( isdefined( level.adler ) )
    {
        level.adler util::stop_magic_bullet_shield();
        level.adler delete();
    }
    
    setdvar( #"hash_3d9a09e7ecea2271", 1 );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 4
// Checksum 0x93ff6583, Offset: 0x620
// Size: 0x44
function cleanup( *name, *starting, *direct, *player )
{
    level clientfield::set( "crash_models", 0 );
}

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 0
// Checksum 0x8571b00f, Offset: 0x670
// Size: 0x44
function init_flags()
{
    level flag::init( "af_skid_complete" );
    level flag::init( "af_doing_crash" );
}

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 0
// Checksum 0x80f724d1, Offset: 0x6c0
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 0
// Checksum 0x80f724d1, Offset: 0x6d0
// Size: 0x4
function function_22b7fffd()
{
    
}

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 1
// Checksum 0x23e5d79f, Offset: 0x6e0
// Size: 0x5d4
function function_243c9d46( player )
{
    player_veh = getvehiclearray( "af_chase_veh", "targetname" )[ 0 ];
    level.chase_truck = player_veh;
    level.player = getplayers()[ 0 ];
    thread function_c0f9442c();
    thread function_e99dbb58( player );
    player_veh vehicle::get_off_path();
    woods = getactorarray( "af_woods", "targetname" );
    
    if ( woods.size > 0 )
    {
        woods[ 0 ] unlink();
    }
    
    plane = getent( "cargo_plane", "targetname" );
    plane unlink();
    level.adler unlink();
    
    if ( isdefined( level.var_55e62e4f ) )
    {
        foreach ( veh in level.var_55e62e4f )
        {
            veh vehicle_death::death_cleanup_riders();
        }
    }
    
    actors = [];
    level.fake_player = util::spawn_player_clone( level.player );
    level.fake_player.targetname = "FakePlayer";
    actors[ #"fakeplayer" ] = level.fake_player;
    level.fake_player hide();
    level thread scene::play_from_time( "scene_tkd_hit3_planecrash_intro", "crash_fakeplayer", actors, 0.8, 0, 1 );
    waitframe( 1 );
    level.fake_player hide();
    level.fake_player setinvisibletoall();
    player playerlinktodelta( level.fake_player, "tag_player", 1, 180, 180, 180, 180, 1, 0, 1 );
    level waittill( #"hash_2d945658a781d296" );
    namespace_82bfe441::fade( 1, "FadeImmediate" );
    player playerlinktoblend( level.fake_player, "tag_player", 0.2, 0, 0, 0.2, 0, 0, 1 );
    wait 0.2;
    level.fake_player show();
    level.fake_player setvisibletoall();
    player val::set( "crash", "disable_weapons", 1 );
    player playerlinktodelta( level.fake_player, "tag_player", 1, 0, 0, 0, 0, 1, 0, 1 );
    level waittill( #"hash_360943c8eac07426" );
    waitframe( 1 );
    level.chase_truck vehicle::lights_off();
    level.chase_truck vehicle::toggle_force_driver_taillights( 0 );
    level.chase_truck cp_takedown_fx::function_2c185955();
    level waittill( #"hash_557087a4ef59ae6c" );
    wait 3;
    level flag::set( "af_skid_complete" );
    snd::client_msg( "af_skid_complete" );
    player unlink();
    level.fake_player delete();
    player val::reset( "crash", "disable_weapons" );
    player val::reset( "crash", "allow_crouch" );
    player val::reset( "crash", "allow_prone" );
    player val::reset( #"chase", "allowdeath" );
}

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 0
// Checksum 0xb96f34cf, Offset: 0xcc0
// Size: 0x54
function function_c0f9442c()
{
    level waittill( #"hash_164bf872d25545af" );
    level notify( #"hash_6f65948492627624" );
    snd::client_msg( #"hash_164bf872d25545af" );
}

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 2
// Checksum 0xb6ae0d5c, Offset: 0xd20
// Size: 0x70
function function_71a64494( player, *guy )
{
    guy waittill( #"weapon_fired" );
    level.player playhitmarker( undefined, 5, undefined, 1 );
    wait 0.01;
    level notify( #"hash_79d44a2e92237673" );
}

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 1
// Checksum 0xc003980f, Offset: 0xd98
// Size: 0x5e
function function_c2f81a50( notification )
{
    level endon( notification );
    self waittill( #"damage" );
    level.player playhitmarker( undefined, 5, undefined, 1 );
    level notify( notification );
}

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 1
// Checksum 0x967c7909, Offset: 0xe00
// Size: 0x1b4
function function_e99dbb58( player )
{
    player unlink();
    player playersetgroundreferenceent( undefined );
    level.chase_truck setmovingplatformenabled( 1, 0 );
    player setstance( "stand" );
    waitframe( 1 );
    player val::set( "crash", "allow_crouch", 0 );
    player val::set( "crash", "allow_prone", 0 );
    wait 2;
    
    if ( isdefined( level.rc_car ) )
    {
        level.rc_car delete();
    }
    
    level waittill( #"hash_61855c3885c438e6" );
    player shellshock( #"frag_grenade_mp", 4 );
    level lui::screen_fade_out( 0.2 );
    player playrumbleonentity( "damage_heavy" );
    level notify( #"hash_351eb749d2c8fa9c" );
    flag::clear( "af_wing_smash" );
}

// Namespace tkdn_af_skid/cp_takedown_af_skid
// Params 0
// Checksum 0x1c52422d, Offset: 0xfc0
// Size: 0x26
function function_c9f7e2d2()
{
    vehs = vehicle::simple_spawn_and_drive( "af_enemy_crash_veh" );
}

