#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;

#namespace cp_mi_sing_vengeance_sound;

// Namespace cp_mi_sing_vengeance_sound
// Params 0
// Checksum 0x4dfb3166, Offset: 0x238
// Size: 0x7a
function main()
{
    clientfield::register( "toplayer", "slowmo_duck_active", 1, 2, "int", &function_41d671f5, 0, 0 );
    level thread function_dcd7454a();
    level thread function_38ba2136();
    level thread function_4035bef1();
    level thread sndmusicrampers();
}

// Namespace cp_mi_sing_vengeance_sound
// Params 7
// Checksum 0x9bbc2583, Offset: 0x2c0
// Size: 0x72
function function_41d671f5( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval > 0 )
    {
        audio::snd_set_snapshot( "cp_mi_sing_vengeance_slowmo" );
        return;
    }
    
    audio::snd_set_snapshot( "default" );
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0
// Checksum 0xbf351ea6, Offset: 0x340
// Size: 0x5a
function function_dcd7454a()
{
    level waittill( #"hash_52a22e61" );
    level endon( #"hash_c2155d7e" );
    level thread function_cc438941();
    audio::snd_set_snapshot( "cp_vengeance_cafe" );
    level waittill( #"hash_d240c7d8" );
    audio::snd_set_snapshot( "default" );
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0
// Checksum 0x2517248f, Offset: 0x3a8
// Size: 0x22
function function_cc438941()
{
    level waittill( #"hash_c2155d7e" );
    audio::snd_set_snapshot( "default" );
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0
// Checksum 0x1fdeb4e5, Offset: 0x3d8
// Size: 0x1a2
function function_38ba2136()
{
    audio::playloopat( "mus_stereo_apartment", ( 19235, -5438, 328 ) );
    audio::playloopat( "amb_tv_static", ( 19770, -5345, 476 ) );
    audio::playloopat( "amb_toilet_loop", ( 19517, -5609, 483 ) );
    audio::playloopat( "amb_light_buzzer", ( 20871, 1399, -38 ) );
    audio::playloopat( "amb_light_buzzer", ( 21833, -1005, -49 ) );
    audio::playloopat( "amb_light_buzzer", ( 22547, -1539, 351 ) );
    audio::playloopat( "amb_light_buzzer", ( 20765, -3112, 294 ) );
    audio::playloopat( "amb_light_buzzer_quiet", ( 21250, -1740, -9 ) );
    audio::playloopat( "amb_subway_light", ( 20871, 1399, -38 ) );
    audio::playloopat( "amb_light_buzzer", ( -18962, -19697, -40 ) );
    audio::playloopat( "mus_diagetic_ethnic", ( 21756, 2890, 266 ) );
    audio::playloopat( "amb_tv_static", ( 22486, 8265, -46 ) );
    audio::playloopat( "amb_tv_static", ( 21856, 8521, -47 ) );
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0
// Checksum 0xefc935e5, Offset: 0x588
// Size: 0x91
function function_4035bef1()
{
    trigger = getent( 0, "siren", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_police_siren", ( 23974, 2768, 631 ) );
            break;
        }
    }
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0
// Checksum 0x5a0ce321, Offset: 0x628
// Size: 0x12
function sndmusicrampers()
{
    level thread function_759e7aaa();
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0
// Checksum 0x6635cde2, Offset: 0x648
// Size: 0x92
function function_759e7aaa()
{
    level waittill( #"sndLRstart" );
    level thread function_60df3271();
    target_origin = ( 21636, -1368, -28 );
    player = getlocalplayer( 0 );
    level.tensionactive = 1;
    level sndramperthink( player, target_origin, "mus_assassination_layer_1", 0, 1, -6, 600, "mus_assassination_layer_2", 0, 1, 50, 400, "mus_assassination_stinger" );
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0
// Checksum 0xaafac6a7, Offset: 0x6e8
// Size: 0x1f
function function_60df3271()
{
    level waittill( #"sndLRstop" );
    wait 3;
    level.tensionactive = 0;
    level notify( #"hash_1842ee53" );
}

// Namespace cp_mi_sing_vengeance_sound
// Params 13
// Checksum 0x553b12f9, Offset: 0x710
// Size: 0x2ea
function sndramperthink( player, target_origin, alias1, min_vol1, max_vol1, min_dist1, max_dist1, alias2, min_vol2, max_vol2, min_dist2, max_dist2, end_alias )
{
    level endon( #"save_restore" );
    level endon( #"disconnect" );
    player endon( #"death" );
    player endon( #"disconnect" );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    volume1 = undefined;
    volume2 = undefined;
    
    if ( isdefined( alias1 ) )
    {
        sndloop1_ent = spawn( 0, ( 0, 0, 0 ), "script_origin" );
        sndloop1_id = sndloop1_ent playloopsound( alias1, 3 );
        sndloop1_min_volume = min_vol1;
        sndloop1_max_volume = max_vol1;
        sndloop1_min_distance = min_dist1;
        sndloop1_max_distance = max_dist1;
        volume1 = 0;
    }
    
    if ( isdefined( alias2 ) )
    {
        sndloop2_ent = spawn( 0, ( 0, 0, 0 ), "script_origin" );
        sndloop2_id = sndloop2_ent playloopsound( alias2, 3 );
        sndloop2_min_volume = min_vol2;
        sndloop2_max_volume = max_vol2;
        sndloop2_min_distance = min_dist2;
        sndloop2_max_distance = max_dist2;
        volume2 = 0;
    }
    
    level thread function_860d167b( sndloop1_ent, sndloop2_ent, sndloop1_id, sndloop2_id );
    
    while ( isdefined( level.tensionactive ) && level.tensionactive )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        distance = distance( target_origin, player.origin );
        
        if ( isdefined( volume1 ) )
        {
            volume1 = audio::scale_speed( sndloop1_min_distance, sndloop1_max_distance, sndloop1_min_volume, sndloop1_max_volume, distance );
            volume1 = abs( 1 - volume1 );
            setsoundvolume( sndloop1_id, volume1 );
        }
        
        if ( isdefined( volume2 ) )
        {
            volume2 = audio::scale_speed( sndloop2_min_distance, sndloop2_max_distance, sndloop2_min_volume, sndloop2_max_volume, distance );
            volume2 = abs( 1 - volume2 );
            setsoundvolume( sndloop2_id, volume2 );
        }
        
        wait 0.1;
    }
    
    level notify( #"hash_61477803" );
    
    if ( isdefined( end_alias ) )
    {
    }
    
    if ( isdefined( sndloop1_ent ) )
    {
        sndloop1_ent delete();
    }
    
    if ( isdefined( sndloop2_ent ) )
    {
        sndloop2_ent delete();
    }
}

// Namespace cp_mi_sing_vengeance_sound
// Params 4
// Checksum 0xd2eff320, Offset: 0xa08
// Size: 0xca
function function_860d167b( ent1, ent2, id1, id2 )
{
    level endon( #"hash_61477803" );
    level waittill( #"save_restore" );
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = ( 21636, -1368, -28 );
    wait 2;
    player = getlocalplayer( 0 );
    
    if ( isdefined( player ) )
    {
        level thread sndramperthink( player, target_origin, "mus_assassination_layer_1", 0, 1, -6, 1300, "mus_assassination_layer_2", 0, 1, 50, 700, "mus_assassination_stinger" );
    }
}

