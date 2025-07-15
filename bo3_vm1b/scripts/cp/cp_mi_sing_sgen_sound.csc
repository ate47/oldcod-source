#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/trigger_shared;

#namespace cp_mi_sing_sgen_sound;

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xdeac2539, Offset: 0x288
// Size: 0xb2
function main()
{
    thread decon_light();
    thread force_underwater_context();
    thread release_underwater_context();
    level thread sndmusicrampers();
    level thread sndscares();
    level thread sndjumpland();
    level thread function_4e5472a7();
    level thread function_45100b4d();
    level thread battle_cry();
    level thread function_6c080ebb();
    level thread function_66507a64();
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x806d6078, Offset: 0x348
// Size: 0xb
function decon_light()
{
    level notify( #"light_on" );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x2be97c66, Offset: 0x360
// Size: 0xc
function force_underwater_context()
{
    level waittill( #"tuwc" );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xbb54dc26, Offset: 0x378
// Size: 0xc
function release_underwater_context()
{
    level waittill( #"tuwco" );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xa36dfdf1, Offset: 0x390
// Size: 0x12
function sndmusicrampers()
{
    level thread sndrobothall();
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x1747a8f1, Offset: 0x3b0
// Size: 0x92
function sndrobothall()
{
    level waittill( #"sndrhstart" );
    level thread sndrobothallend();
    target_origin = ( -163, -2934, -5050 );
    player = getlocalplayer( 0 );
    level.tensionactive = 1;
    level sndramperthink( player, target_origin, "mus_robothall_layer_1", 0, 1, 400, 1600, "mus_robothall_layer_2", 0, 1, -6, 1000, "mus_robothall_end" );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xf051a564, Offset: 0x450
// Size: 0x16
function sndrobothallend()
{
    level waittill( #"sndrhstop" );
    level.tensionactive = 0;
}

// Namespace cp_mi_sing_sgen_sound
// Params 13
// Checksum 0x72b6088e, Offset: 0x470
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

// Namespace cp_mi_sing_sgen_sound
// Params 4
// Checksum 0x81e3f4d1, Offset: 0x780
// Size: 0xca
function function_860d167b( ent1, ent2, id1, id2 )
{
    level endon( #"hash_61477803" );
    level waittill( #"save_restore" );
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = ( -163, -2934, -5050 );
    wait 2;
    player = getlocalplayer( 0 );
    
    if ( isdefined( player ) )
    {
        level thread sndramperthink( player, target_origin, "mus_robothall_layer_1", 0, 1, 400, 1600, "mus_robothall_layer_2", 0, 1, -6, 1000, "mus_robothall_end" );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xb94d0f01, Offset: 0x858
// Size: 0x5a
function sndscares()
{
    scaretrigs = getentarray( 0, "sndScares", "targetname" );
    
    if ( !isdefined( scaretrigs ) || scaretrigs.size <= 0 )
    {
        return;
    }
    
    array::thread_all( scaretrigs, &sndscaretrig );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x55e5dc51, Offset: 0x8c0
// Size: 0x89
function sndscaretrig()
{
    target = struct::get( self.target, "targetname" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, self.script_sound, target.origin );
            break;
        }
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xba095936, Offset: 0x958
// Size: 0x5a
function sndjumpland()
{
    jumptrigs = getentarray( 0, "sndJumpLand", "targetname" );
    
    if ( !isdefined( jumptrigs ) || jumptrigs.size <= 0 )
    {
        return;
    }
    
    array::thread_all( jumptrigs, &sndjumplandtrig );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xdb9874d, Offset: 0x9c0
// Size: 0x3d
function sndjumplandtrig()
{
    while ( true )
    {
        self waittill( #"trigger", who );
        self thread trigger::function_thread( who, &sndjumplandtrigplaysound );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 1
// Checksum 0x40b37bc3, Offset: 0xa08
// Size: 0x2a
function sndjumplandtrigplaysound( ent )
{
    playsound( 0, self.script_sound, ent.origin );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xaaeb3418, Offset: 0xa40
// Size: 0x62
function function_4e5472a7()
{
    level waittill( #"escp" );
    wait 3;
    audio::playloopat( "evt_escape_walla", ( 20225, 2651, -6631 ) );
    level waittill( #"escps" );
    audio::stoploopat( "evt_escape_walla", ( 20225, 2651, -6631 ) );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xd0345458, Offset: 0xab0
// Size: 0x75
function function_45100b4d()
{
    level endon( #"kw" );
    level waittill( #"sw" );
    
    while ( true )
    {
        playsound( 0, "vox_walla_call", ( -1045, -4195, 564 ) );
        wait 4;
        playsound( 0, "vox_walla_call_response", ( 621, -5090, 376 ) );
        wait randomintrange( 2, 7 );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xe79bbdf9, Offset: 0xb30
// Size: 0x2a
function battle_cry()
{
    level waittill( #"kw" );
    playsound( 0, "vox_walla_battlecry", ( -138, -4871, 311 ) );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x358baf09, Offset: 0xb68
// Size: 0x1ca
function function_6c080ebb()
{
    level waittill( #"escp" );
    level thread function_9d912a9d( 20210, 4156, -6727 );
    level thread function_9d912a9d( 20369, 3460, -6700 );
    level thread function_9d912a9d( 20369, 3460, -6700 );
    level thread function_9d912a9d( 20176, 2461, -6547 );
    level thread function_9d912a9d( 21068, 2494, -6526 );
    level thread function_9d912a9d( 22036, 2473, -6543 );
    level thread function_9d912a9d( 23219, 2550, -6545 );
    level thread function_9d912a9d( 23132, 1542, -6547 );
    level thread function_9d912a9d( 23132, 1542, -6547 );
    level thread function_9d912a9d( 24602, 1593, -6243 );
    level thread function_9d912a9d( 25098, 1888, -6524 );
    level thread function_9d912a9d( 25120, 1258, -6557 );
    level thread function_9d912a9d( 25522, 1821, -6447 );
    level thread function_9d912a9d( 25516, 1302, -6511 );
}

// Namespace cp_mi_sing_sgen_sound
// Params 3
// Checksum 0xb223f8fd, Offset: 0xd40
// Size: 0x3a
function function_9d912a9d( pos1, pos2, pos3 )
{
    audio::playloopat( "evt_escape_alarm", ( pos1, pos2, pos3 ) );
}

// Namespace cp_mi_sing_sgen_sound
// Params 7
// Checksum 0x19c947f0, Offset: 0xd88
// Size: 0xad
function sndLabWalla( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        soundloopemitter( "amb_lab_walla", ( 1240, 285, -1203 ) );
        return;
    }
    
    soundstoploopemitter( "amb_lab_walla", ( 1240, 285, -1203 ) );
    playsound( 0, "amb_lab_walla_stop", ( 1240, 285, -1203 ) );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xae496c0e, Offset: 0xe40
// Size: 0x302
function function_66507a64()
{
    audio::playloopat( "amb_glitchy_screens", ( 3275, -2730, -4743 ) );
    audio::playloopat( "amb_glitchy_screens", ( -24, -939, -4529 ) );
    audio::playloopat( "amb_glitchy_screens", ( 3952, -1962, -4781 ) );
    audio::playloopat( "amb_flourescent_light_quiet", ( 1649, -999, -4547 ) );
    audio::playloopat( "amb_flourescent_light_quiet", ( -47, 53, -4409 ) );
    audio::playloopat( "amb_billboard_glitch_loop", ( 1100, -954, 325 ) );
    audio::playloopat( "amb_billboard_glitch_loop", ( -505, 1787, 4005 ) );
    audio::playloopat( "amb_billboard_glitch_loop", ( -25, -1367, 424 ) );
    audio::playloopat( "amb_billboard_glitch_loop", ( 398, -2739, 399 ) );
    audio::playloopat( "amb_computer", ( 4476, -2321, -4913 ) );
    audio::playloopat( "amb_computer", ( 4492, -2606, -4914 ) );
    audio::playloopat( "amb_air_vent", ( 4214, -2387, -4753 ) );
    audio::playloopat( "amb_air_vent", ( 3623, -2391, -4781 ) );
    audio::playloopat( "amb_quiet_monkey_machine", ( 4200, -2553, -4755 ) );
    audio::playloopat( "amb_quiet_monkey_machine", ( 3691, -2553, -4757 ) );
    audio::playloopat( "amb_quiet_monkey_machine", ( 3663, -2205, -4758 ) );
    audio::playloopat( "amb_quiet_monkey_machine", ( 4121, -2205, -4759 ) );
    audio::playloopat( "pfx_steam_hollow", ( 1487, 1043, -2042 ) );
    audio::playloopat( "pfx_steam_hollow", ( 1903, 1280, -1871 ) );
    audio::playloopat( "amb_flourescent_light_quiet", ( 1678, 416, -1813 ) );
    audio::playloopat( "amb_flourescent_light_quiet", ( 2326, -2166, -4608 ) );
    audio::playloopat( "amb_air_vent", ( 2265, -1672, -4526 ) );
    audio::playloopat( "amb_air_vent_rattle", ( 2265, -1672, -4526 ) );
    audio::playloopat( "amb_flourescent_light_quiet", ( 2652, -2736, -4656 ) );
}

