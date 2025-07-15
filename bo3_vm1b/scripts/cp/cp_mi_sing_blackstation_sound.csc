#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;

#namespace cp_mi_sing_blackstation_sound;

// Namespace cp_mi_sing_blackstation_sound
// Params 0
// Checksum 0xee077bf4, Offset: 0x2c8
// Size: 0x5a
function main()
{
    level thread function_87c8026c();
    level thread function_ca589ae4();
    clientfield::register( "toplayer", "slowmo_duck_active", 1, 2, "int", &function_41d671f5, 0, 0 );
}

// Namespace cp_mi_sing_blackstation_sound
// Params 7
// Checksum 0x37f42272, Offset: 0x330
// Size: 0x221
function sndwindsystem( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        if ( !isdefined( self.soundid1 ) )
        {
            self stopallloopsounds();
            self.soundid1 = self playloopsound( "amb_scripted_wind_normal", 2 );
            setsoundvolume( self.soundid1, 1 );
            setsoundvolumerate( self.soundid1, 0.5 );
        }
        
        if ( !isdefined( self.soundid2 ) )
        {
            self.soundid2 = self playloopsound( "amb_scripted_wind_heavy", 2 );
            setsoundvolume( self.soundid2, 0 );
            setsoundvolumerate( self.soundid2, 0.5 );
        }
        
        self thread function_d84ed3d1();
        
        switch ( newval )
        {
            case 1:
                setsoundvolume( self.soundid1, 1 );
                setsoundvolume( self.soundid2, 0 );
                audio::snd_set_snapshot( "default" );
                break;
            case 2:
                setsoundvolume( self.soundid1, 0.5 );
                setsoundvolume( self.soundid2, 1 );
                audio::snd_set_snapshot( "cp_blackstation_scripted_wind" );
                break;
        }
        
        return;
    }
    
    self notify( #"hash_450e1742" );
    self stopallloopsounds();
    
    if ( isdefined( self.soundid1 ) )
    {
        self.soundid1 = undefined;
    }
    
    if ( isdefined( self.soundid2 ) )
    {
        self.soundid2 = undefined;
    }
}

// Namespace cp_mi_sing_blackstation_sound
// Params 0
// Checksum 0xb1a218b6, Offset: 0x560
// Size: 0x3a
function function_d84ed3d1()
{
    self notify( #"hash_d84ed3d1" );
    self endon( #"hash_d84ed3d1" );
    self endon( #"hash_450e1742" );
    self waittill( #"entityshutdown" );
    
    if ( isdefined( self ) )
    {
        self stopallloopsounds();
    }
}

// Namespace cp_mi_sing_blackstation_sound
// Params 0
// Checksum 0x9af471ef, Offset: 0x5a8
// Size: 0x22
function function_87c8026c()
{
    soundloopemitter( "evt_barge_wave_looper", ( 1193, -8283, -63 ) );
}

// Namespace cp_mi_sing_blackstation_sound
// Params 0
// Checksum 0x880dc7bf, Offset: 0x5d8
// Size: 0x402
function function_ca589ae4()
{
    audio::playloopat( "amb_glass_shake_loop", ( -8446, 10255, 419 ) );
    audio::playloopat( "amb_glass_shake_loop", ( -9941, 11040, 452 ) );
    audio::playloopat( "amb_rain_on_windows", ( -8347, 10197, 369 ) );
    audio::playloopat( "amb_wind_blend", ( -8422, 9652, 382 ) );
    audio::playloopat( "amb_wind_blend", ( -8161, 9575, 435 ) );
    audio::playloopat( "amb_subway_light", ( -5813, 5559, 285 ) );
    audio::playloopat( "amb_subway_light", ( -5509, 4875, 123 ) );
    audio::playloopat( "amb_subway_light", ( -6675, 4978, -98 ) );
    audio::playloopat( "amb_subway_light", ( 3167, -3813, 126 ) );
    audio::playloopat( "amb_subway_light", ( 3497, -3427, 124 ) );
    audio::playloopat( "amb_river_debris", ( -9133, 9903, -64 ) );
    audio::playloopat( "amb_river_debris", ( -6101, 9777, 61 ) );
    audio::playloopat( "amb_wind_whistle_loud_right", ( -8291, 9671, 378 ) );
    audio::playloopat( "amb_subway_light", ( -7624, 9896, 406 ) );
    audio::playloopat( "amb_rain_on_concrete", ( -6483, 6114, 550 ) );
    audio::playloopat( "amb_rain_on_concrete", ( -6478, 6181, 551 ) );
    audio::playloopat( "amb_rain_on_concrete", ( -6477, 6230, 548 ) );
    audio::playloopat( "amb_wind_whistle_left", ( 4552, 820, 695 ) );
    audio::playloopat( "amb_metal_debris_shake", ( 5238, 710, 699 ) );
    audio::playloopat( "amb_rain_on_concrete", ( 4698, 917, 656 ) );
    audio::playloopat( "amb_rain_on_concrete", ( 4767, 823, 632 ) );
    audio::playloopat( "amb_rain_on_concrete", ( 4871, 802, 636 ) );
    audio::playloopat( "amb_rain_on_concrete", ( 4659, 860, 663 ) );
    audio::playloopat( "amb_rain_on_metal_debris", ( 5075, 733, 650 ) );
    audio::playloopat( "amb_buoy", ( 436, -4077, 119 ) );
    audio::playloopat( "amb_sea_distant", ( -90, -3692, -79 ) );
    audio::playloopat( "amb_subway_light", ( -1409, 10106, 395 ) );
    audio::playloopat( "amb_subway_light", ( -1306, 9830, 19 ) );
    audio::playloopat( "amb_subway_light", ( -1547, 10060, 19 ) );
    audio::playloopat( "amb_subway_light", ( -288, 9298, 21 ) );
    audio::playloopat( "amb_subway_light", ( -1058, 9718, -85 ) );
    audio::playloopat( "amb_subway_light", ( -571, 9460, 30 ) );
}

// Namespace cp_mi_sing_blackstation_sound
// Params 7
// Checksum 0xe3b80d9, Offset: 0x9e8
// Size: 0x82
function sndStationWalla( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        audio::playloopat( "amb_station_walla", ( -4172, 4988, 40 ) );
        return;
    }
    
    audio::stoploopat( "amb_station_walla", ( -4172, 4988, 40 ) );
}

// Namespace cp_mi_sing_blackstation_sound
// Params 7
// Checksum 0x48d6da06, Offset: 0xa78
// Size: 0xfa
function sndBlackStationSounds( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    audio::playloopat( "amb_computer_error", ( 84, 9455, -116 ) );
    audio::playloopat( "amb_computer_error", ( -950, 1088, -36 ) );
    audio::playloopat( "amb_computer_error", ( -1351, 9976, -36 ) );
    audio::playloopat( "amb_computer_future", ( -672, 9640, -40 ) );
    audio::playloopat( "amb_computer_future", ( -1136, 9630, -56 ) );
    audio::playloopat( "amb_computer_future", ( -783, 9675, -36 ) );
}

// Namespace cp_mi_sing_blackstation_sound
// Params 7
// Checksum 0x7ccea668, Offset: 0xb80
// Size: 0x3aa
function sndDrillWalla( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        audio::stoploopat( "amb_glass_shake_loop", ( -8446, 10255, 419 ) );
        audio::stoploopat( "amb_glass_shake_loop", ( -9941, 11040, 452 ) );
        audio::stoploopat( "amb_rain_on_windows", ( -8347, 10197, 369 ) );
        audio::stoploopat( "amb_wind_blend", ( -8422, 9652, 382 ) );
        audio::stoploopat( "amb_wind_blend", ( -8161, 9575, 435 ) );
        audio::stoploopat( "amb_subway_light", ( -5813, 5559, 285 ) );
        audio::stoploopat( "amb_subway_light", ( -5509, 4875, 123 ) );
        audio::stoploopat( "amb_subway_light", ( -6675, 4978, -98 ) );
        audio::stoploopat( "amb_subway_light", ( 3167, -3813, 126 ) );
        audio::stoploopat( "amb_subway_light", ( 3497, -3427, 124 ) );
        audio::stoploopat( "amb_river_debris", ( -9133, 9903, -64 ) );
        audio::stoploopat( "amb_river_debris", ( -6101, 9777, 61 ) );
        audio::stoploopat( "amb_wind_whistle_loud_right", ( -8291, 9671, 378 ) );
        audio::stoploopat( "amb_subway_light", ( -7624, 9896, 406 ) );
        audio::stoploopat( "amb_rain_on_concrete", ( -6483, 6114, 550 ) );
        audio::stoploopat( "amb_rain_on_concrete", ( -6478, 6181, 551 ) );
        audio::stoploopat( "amb_rain_on_concrete", ( -6477, 6230, 548 ) );
        audio::stoploopat( "amb_computer_error", ( 84, 9455, -116 ) );
        audio::stoploopat( "amb_computer_error", ( -950, 1088, -36 ) );
        audio::stoploopat( "amb_computer_error", ( -1351, 9976, -36 ) );
        audio::stoploopat( "amb_computer_future", ( -672, 9640, -40 ) );
        audio::stoploopat( "amb_computer_future", ( -1136, 9630, -56 ) );
        audio::stoploopat( "amb_computer_future", ( -783, 9675, -36 ) );
        audio::playloopat( "amb_drill_walla", ( -968, 9589, 380 ) );
        audio::playloopat( "evt_drilling", ( -968, 9589, 380 ) );
        return;
    }
    
    audio::stoploopat( "amb_drill_walla", ( -968, 9589, 380 ) );
    audio::stoploopat( "evt_drilling", ( -968, 9589, 380 ) );
}

// Namespace cp_mi_sing_blackstation_sound
// Params 7
// Checksum 0x225c4c58, Offset: 0xf38
// Size: 0x72
function function_41d671f5( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval > 0 )
    {
        audio::snd_set_snapshot( "cp_barge_slowtime" );
        return;
    }
    
    audio::snd_set_snapshot( "default" );
}

