#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;

#namespace cp_mi_cairo_ramses_sound;

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0x7b29c3a, Offset: 0x190
// Size: 0x62
function main()
{
    level thread hornsndtrigger();
    level thread defibsndtrigger();
    level thread post_interview_weapon_snapshot();
    level thread vital_snd();
    level thread sndplayrandomexplosions_vtol_ride_start();
    level thread sndlevelfadeout();
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0x799cd5d1, Offset: 0x200
// Size: 0x91
function hornsndtrigger()
{
    trigger = getent( 0, "subway_horn", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_subway_horn", ( 7608, 1158, -415 ) );
            break;
        }
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0xf82d7b32, Offset: 0x2a0
// Size: 0x89
function defibsndtrigger()
{
    trigger = getent( 0, "defibrillator", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_defibrillator", ( 7443, -1682, 74 ) );
            break;
        }
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0xf836226c, Offset: 0x338
// Size: 0x45
function sndpaannouncer()
{
    level endon( #"hosp_amb" );
    
    while ( true )
    {
        playsound( 0, "amb_hospital_pa", ( 7068, -1791, 548 ) );
        wait randomintrange( 30, 46 );
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0xbeb024ae, Offset: 0x388
// Size: 0x42
function post_interview_weapon_snapshot()
{
    level waittill( #"inv" );
    audio::snd_set_snapshot( "cp_ramses_raps_intro" );
    level waittill( #"dro" );
    audio::snd_set_snapshot( "default" );
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0x6ce3acf0, Offset: 0x3d8
// Size: 0xa2
function vital_snd()
{
    if ( !isdefined( level.snd_hrt ) )
    {
        level.snd_hrt = spawn( 0, ( 6610, -2082, 66 ), "script.origin" );
    }
    
    level waittill( #"vital_sign" );
    level.snd_hrt playloopsound( "amb_heart_monitor_lp" );
    level waittill( #"hosp_amb" );
    level.snd_hrt stopallloopsounds( 0.25 );
    wait 1;
    level.snd_hrt delete();
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0xc892092, Offset: 0x488
// Size: 0x12d
function sndplayrandomexplosions_vtol_ride_start()
{
    level endon( #"ride_vtol" );
    spot1 = ( 10198, -9557, 755 );
    spot2 = ( 6406, -9437, 894 );
    spot3 = ( 4810, -8798, 833 );
    spot4 = ( 2412, -7377, 859 );
    spot5 = ( 28, -6302, 777 );
    spot6 = ( -257, -3146, 658 );
    spot7 = ( 334, -300, 620 );
    spots = array( spot1, spot2, spot3, spot4, spot5, spot6, spot7 );
    level waittill( #"hosp_amb" );
    
    while ( true )
    {
        spot = array::random( spots );
        playsound( 0, "exp_dist_heavy", spot );
        wait randomintrange( 3, 6 );
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0xf10cf24f, Offset: 0x5c0
// Size: 0x22
function sndlevelfadeout()
{
    level waittill( #"sndlevelend" );
    audio::snd_set_snapshot( "cmn_level_fadeout" );
}

