#using scripts\core_common\fx_shared;
#using scripts\core_common\struct;

#namespace mp_militia_fx;

// Namespace mp_militia_fx/mp_militia_fx
// Params 0, eflags: 0x0
// Checksum 0xe5bd59d1, Offset: 0x80
// Size: 0xc4
function main() {
    setsaveddvar(#"enable_global_wind", 1);
    setsaveddvar(#"wind_global_vector", "88 0 0");
    setsaveddvar(#"wind_global_low_altitude", 0);
    setsaveddvar(#"wind_global_hi_altitude", 10000);
    setsaveddvar(#"wind_global_low_strength_percent", 100);
}
