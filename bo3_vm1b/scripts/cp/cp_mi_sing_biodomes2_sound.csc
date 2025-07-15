#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;

#namespace cp_mi_sing_biodomes2_sound;

// Namespace cp_mi_sing_biodomes2_sound
// Params 0
// Checksum 0x609ef8bc, Offset: 0x110
// Size: 0x22
function main()
{
    thread party_stop();
    level thread function_625f0409();
}

// Namespace cp_mi_sing_biodomes2_sound
// Params 0
// Checksum 0xacab2b2a, Offset: 0x140
// Size: 0xb
function party_stop()
{
    level notify( #"no_party" );
}

// Namespace cp_mi_sing_biodomes2_sound
// Params 0
// Checksum 0x588a0888, Offset: 0x158
// Size: 0x92
function function_625f0409()
{
    level waittill( #"hash_ace596" );
    level thread function_69ca5e40();
    target_origin = ( -3972, 759, 4462 );
    player = getlocalplayer( 0 );
    level.tensionactive = 1;
    level thread sndramperthink( player, target_origin, "mus_diveramper_layer_1", 0, 1, 450, 1200, "mus_diveramper_layer_2", 0, 1, -6, 700, "mus_diveramper_stinger" );
}

// Namespace cp_mi_sing_biodomes2_sound
// Params 0
// Checksum 0x68a2a16b, Offset: 0x1f8
// Size: 0x16
function function_69ca5e40()
{
    level waittill( #"sndRampEnd" );
    level.tensionactive = 0;
}

// Namespace cp_mi_sing_biodomes2_sound
// Params 13
// Checksum 0x36282bf0, Offset: 0x218
// Size: 0x302
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
        playsound( 0, end_alias, ( 0, 0, 0 ) );
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

// Namespace cp_mi_sing_biodomes2_sound
// Params 4
// Checksum 0xf83c1389, Offset: 0x528
// Size: 0xca
function function_860d167b( ent1, ent2, id1, id2 )
{
    level endon( #"sndRampEnd" );
    level waittill( #"save_restore" );
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = ( -3972, 759, 4462 );
    wait 2;
    player = getlocalplayer( 0 );
    
    if ( isdefined( player ) )
    {
        level thread sndramperthink( player, target_origin, "mus_diveramper_layer_1", 0, 1, -6, 700, "mus_diveramper_layer_2", 0, 1, 50, 300, "mus_diveramper_stinger" );
    }
}

