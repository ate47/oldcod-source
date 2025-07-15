#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/voice/voice_sgen;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_sgen_sound;

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x9e59bb94, Offset: 0x548
// Size: 0xc2
function main()
{
    voice_sgen::init_voice();
    level thread raven_fly();
    level thread upper_silo_door_bang();
    level thread water_monster_scare();
    level thread robot_hallway_scare();
    level thread underwater_explosions();
    level thread underwater_bump_handling();
    level thread silo_robot_awaken();
    level thread under_silo_metal_groan();
    level thread play_dni_chamber_hum();
    level thread function_a56ceafc();
    level thread namespace_d40478f6::function_af9045f8();
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x2b03e591, Offset: 0x618
// Size: 0x32
function function_a56ceafc()
{
    level flag::wait_till( "exterior_gone_hot" );
    util::clientnotify( "kw" );
}

// Namespace cp_mi_sing_sgen_sound
// Params 2
// Checksum 0xab8c6d8d, Offset: 0x658
// Size: 0x141
function sndmusicset( area, musicend )
{
    if ( !isdefined( musicend ) )
    {
        musicend = 0;
    }
    
    if ( !isdefined( area ) )
    {
        return;
    }
    
    message_mid = undefined;
    message_bot = undefined;
    
    switch ( area )
    {
        case "igc_intro":
            message_mid = "Oneshot: IGC Intro Music";
            break;
        case "quadtank_intro":
            if ( !musicend )
            {
            }
            
            break;
        case "sgen_enter":
            break;
        case "dark_battle":
            if ( !musicend )
            {
            }
            
            break;
        case "pallas":
            if ( !musicend )
            {
            }
            else
            {
                message_mid = "StopLooper: Pallas Battle Music";
                message_bot = "Oneshot: Pallas Defeat Stinger";
            }
            
            break;
        default:
            if ( !musicend )
            {
                message_mid = "Looper: Water Exit";
            }
            else
            {
                message_mid = "StopLooper: Water Exit";
                message_bot = "Oneshot: Level End";
            }
            
            break;
    }
    
    foreach ( player in level.players )
    {
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x6bec717a, Offset: 0x7a8
// Size: 0x62
function raven_fly()
{
    trigger = getent( "amb_raven_fly", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 2;
        playsoundatposition( "evt_raven_caw", ( 420, -2031, 590 ) );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xaf21eacd, Offset: 0x818
// Size: 0x6a
function upper_silo_door_bang()
{
    trigger = getent( "amb_door_bang_silo_office", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 0.5;
        playsoundatposition( "evt_door_bang", ( 660, -608, -1195 ) );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x1fef2fb2, Offset: 0x890
// Size: 0x6a
function silo_door_scare()
{
    trigger = getent( "silo_door_scare", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 0.5;
        playsoundatposition( "evt_silo_door_scare", ( -780, 874, -2806 ) );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xb4192e1d, Offset: 0x908
// Size: 0x62
function under_silo_metal_groan()
{
    trigger = getent( "evt_metal_groan_undersilo", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 3;
        playsoundatposition( "evt_dist_metal", ( 82, -863, -4551 ) );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x1a04bd75, Offset: 0x978
// Size: 0x46
function water_monster_scare()
{
    trigger = getent( "evt_water_monster", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 0.5;
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xefca1cc6, Offset: 0x9c8
// Size: 0x6a
function robot_hallway_scare()
{
    trigger = getent( "amb_robot_hallway", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 0.5;
        playsoundatposition( "evt_robot_hallway", ( -40, -2624, -5120 ) );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x440dacae, Offset: 0xa40
// Size: 0x59
function underwater_explosions()
{
    water_exp_trigs = getentarray( "evt_underwater_exp", "targetname" );
    
    for ( i = 0; i < water_exp_trigs.size ; i++ )
    {
        water_exp_trigs[ i ] thread play_explosions();
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x6f42b706, Offset: 0xaa8
// Size: 0x52
function play_explosions()
{
    target = struct::get( self.target, "targetname" );
    self waittill( #"trigger" );
    playsoundatposition( self.script_sound, target.origin );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xf34297c2, Offset: 0xb08
// Size: 0x59
function underwater_bump_handling()
{
    underwater_bump_trigs = getentarray( "amb_underwater_bump", "targetname" );
    
    for ( i = 0; i < underwater_bump_trigs.size ; i++ )
    {
        underwater_bump_trigs[ i ] thread play_underwater_bumps();
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xb512f1a, Offset: 0xb70
// Size: 0x22
function play_underwater_bumps()
{
    self waittill( #"trigger" );
    self playsound( self.script_sound );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xcad368f8, Offset: 0xba0
// Size: 0x59
function silo_robot_awaken()
{
    sound_locs = getentarray( "evt_robots_awaken", "targetname" );
    
    for ( i = 0; i < sound_locs.size ; i++ )
    {
        sound_locs[ i ] thread play_robot_awaken();
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x4947fe97, Offset: 0xc08
// Size: 0x55
function play_robot_awaken()
{
    self.counter = 0;
    level waittill( #"ambush" );
    
    while ( self.counter < 2 )
    {
        wait randomintrange( 0, 4 );
        self playsound( "evt_robots_awaken" );
        self.counter++;
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x510b354e, Offset: 0xc68
// Size: 0x52
function play_dni_chamber_hum()
{
    level waittill( #"enter_server" );
    sound_org = getent( "amb_dni_chamber_origin", "targetname" );
    
    if ( isdefined( sound_org ) )
    {
        sound_org playloopsound( "amb_dni_chamber_hum", 0 );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xa996cfb2, Offset: 0xcc8
// Size: 0x2a
function function_2b89e6e8()
{
    level waittill( #"debris_hit" );
    playsoundatposition( "fly_hendricks_kick_debris_beam_b", ( -562, -326, -135 ) );
}

#namespace namespace_d40478f6;

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x4d8c4d1c, Offset: 0xd00
// Size: 0x1a
function function_973b77f9()
{
    music::setmusicstate( "none" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x65f8fd48, Offset: 0xd28
// Size: 0x1a
function function_3440789f()
{
    music::setmusicstate( "quad_awaken" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xa5b3bf05, Offset: 0xd50
// Size: 0x32
function play_genlab_music()
{
    music::setmusicstate( "genlab" );
    level clientfield::set( "sndLabWalla", 0 );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xc620515d, Offset: 0xd90
// Size: 0x1a
function play_robot_knock_music()
{
    wait 6;
    music::setmusicstate( "knockbot" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x3146dfca, Offset: 0xdb8
// Size: 0x1a
function function_98762d53()
{
    music::setmusicstate( "pre_silo" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x7fa4c0ee, Offset: 0xde0
// Size: 0x1a
function play_robot_ambush_music()
{
    music::setmusicstate( "ambush" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x395db088, Offset: 0xe08
// Size: 0x1a
function function_55f6ee71()
{
    music::setmusicstate( "corvus_entrance" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xea28136d, Offset: 0xe30
// Size: 0x1a
function function_3eb3d06()
{
    music::setmusicstate( "gas_battle_silo" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x9ab05207, Offset: 0xe58
// Size: 0x1a
function function_874f01d()
{
    music::setmusicstate( "elevator_ride" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x1c66f3e0, Offset: 0xe80
// Size: 0x1a
function function_ad14681b()
{
    music::setmusicstate( "diaz_fight_part_one" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x93fa6deb, Offset: 0xea8
// Size: 0x2a
function function_3d554ba8()
{
    music::setmusicstate( "none" );
    wait 12;
    level thread function_fdf54ba5();
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xecdc1a06, Offset: 0xee0
// Size: 0x1a
function function_fdf54ba5()
{
    music::setmusicstate( "diaz_fight_part_two" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x988e5838, Offset: 0xf08
// Size: 0x2a
function function_af5cbae3()
{
    music::setmusicstate( "none" );
    wait 10;
    level thread function_7881343b();
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x2bf42489, Offset: 0xf40
// Size: 0x1a
function function_7881343b()
{
    music::setmusicstate( "diaz_fight_part_three" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x45184799, Offset: 0xf68
// Size: 0x1a
function function_895a407a()
{
    wait 3;
    music::setmusicstate( "none" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xc73bcd16, Offset: 0xf90
// Size: 0x1a
function function_72ef07c3()
{
    wait 1;
    music::setmusicstate( "defend_hendrix" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xba495cf, Offset: 0xfb8
// Size: 0x1a
function function_5d6d7c60()
{
    wait 1;
    music::setmusicstate( "depth_charge_ambience" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xa40fa304, Offset: 0xfe0
// Size: 0x1a
function function_71f06599()
{
    wait 4;
    music::setmusicstate( "silo_water" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x3b7496f4, Offset: 0x1008
// Size: 0x1a
function function_29597dc9()
{
    music::setmusicstate( "robot_hallway" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xf2e2035f, Offset: 0x1030
// Size: 0x1a
function robot_hallway_underscore()
{
    music::setmusicstate( "robot_hallway_underscore" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x91d90daf, Offset: 0x1058
// Size: 0x22
function function_af9045f8()
{
    level waittill( #"hash_ddeafd5d" );
    music::setmusicstate( "diaz_igc3" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x5ffdd52b, Offset: 0x1088
// Size: 0x1a
function function_34465ae6()
{
    music::setmusicstate( "dark_battle_stg" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x78fc86ee, Offset: 0x10b0
// Size: 0x1a
function function_4a262c0b()
{
    wait 2;
    music::setmusicstate( "dni_lab_igc2" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x649146a8, Offset: 0x10d8
// Size: 0x1a
function function_6cad5ce0()
{
    music::setmusicstate( "flyin_igc1" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xe6622bb5, Offset: 0x1100
// Size: 0x1a
function function_26fc5a92()
{
    wait 3;
    music::setmusicstate( "hendricks_bodies" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x694f9c19, Offset: 0x1128
// Size: 0x1a
function function_fb17452c()
{
    music::setmusicstate( "descent" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x88350c25, Offset: 0x1150
// Size: 0x1a
function play_outro()
{
    music::setmusicstate( "outro" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xa1c70680, Offset: 0x1178
// Size: 0xa2
function function_22982c6e()
{
    playsoundatposition( "evt_sgen_hallway_scare", ( -74, -1189, -4560 ) );
    ent = spawn( "script_origin", ( -74, -1189, -4560 ) );
    ent playloopsound( "amb_sgen_corporate_jingle_scripted" );
    wait 25;
    playsoundatposition( "evt_sgen_hallway_scare_off", ( -74, -1189, -4560 ) );
    ent stoploopsound();
    ent delete();
}

