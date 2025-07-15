#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;

#namespace cp_mi_cairo_ramses2_sound;

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0x37364187, Offset: 0x1a8
// Size: 0x112
function main()
{
    level thread hospital_walla();
    level thread setigcsnapshot( "igcds1", "cp_ramses_demostreet_1" );
    level thread setigcsnapshot( "igcds2", "cp_ramses_demostreet_2" );
    level thread setigcsnapshot( "igcds3", "cp_ramses_demostreet_3", "igc" );
    level thread setigcsnapshot( "igcds4", "default", "normal" );
    level thread setoutrosnapshot( "outrofoley", "outroduck" );
    level thread set_prevtol_snapshot();
    level thread play_igc_fire_loop();
    level thread function_6a0726e7();
    level thread function_72b86ad7();
    level thread function_671db01b();
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0xa5df3811, Offset: 0x2c8
// Size: 0xb
function hospital_walla()
{
    level notify( #"walla_off" );
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 3
// Checksum 0xed73809b, Offset: 0x2e0
// Size: 0x52
function setigcsnapshot( arg1, arg2, arg3 )
{
    level waittill( arg1 );
    audio::snd_set_snapshot( arg2 );
    
    if ( isdefined( arg3 ) )
    {
        setsoundcontext( "foley", arg3 );
    }
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 2
// Checksum 0x10359d21, Offset: 0x340
// Size: 0x4a
function setoutrosnapshot( arg1, arg2 )
{
    level waittill( arg1 );
    setsoundcontext( "foley", "igc" );
    level waittill( arg2 );
    audio::snd_set_snapshot( "cp_ramses_outro" );
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0xfcdfe69d, Offset: 0x398
// Size: 0x42
function set_prevtol_snapshot()
{
    level waittill( #"pres" );
    audio::snd_set_snapshot( "cp_ramses_pre_vtol" );
    level waittill( #"pst" );
    audio::snd_set_snapshot( "cp_ramses_plaza_battle" );
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0x52f7f3bc, Offset: 0x3e8
// Size: 0x22
function play_igc_fire_loop()
{
    audio::playloopat( "amb_vtol_fire_loop", ( 8101, -16182, 322 ) );
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0xd92d3069, Offset: 0x418
// Size: 0x22
function function_6a0726e7()
{
    level waittill( #"hash_24819a18" );
    audio::snd_set_snapshot( "cp_ramses_vtol_walk" );
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0x4ab7381f, Offset: 0x448
// Size: 0x22
function function_72b86ad7()
{
    level waittill( #"hash_4e8ca471" );
    audio::snd_set_snapshot( "default" );
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0xeaf5150e, Offset: 0x478
// Size: 0x2a
function function_671db01b()
{
    level waittill( #"pst" );
    wait 0.5;
    audio::snd_set_snapshot( "cp_ramses_plaza_battle" );
}

