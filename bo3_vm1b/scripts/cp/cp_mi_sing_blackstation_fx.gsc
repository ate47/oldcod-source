#using scripts/codescripts/struct;

#namespace cp_mi_sing_blackstation_fx;

// Namespace cp_mi_sing_blackstation_fx
// Params 0
// Checksum 0x7513a3c6, Offset: 0x168
// Size: 0x63
function main()
{
    level._effect[ "rain_light" ] = "weather/fx_rain_system_lite_runner";
    level._effect[ "rain_medium" ] = "weather/fx_rain_system_med_runner";
    level._effect[ "rain_heavy" ] = "weather/fx_rain_system_hvy_runner_blackstation";
    level._effect[ "barge_sheeting" ] = "weather/fx_rain_barge_sheeting_blkstn";
}

