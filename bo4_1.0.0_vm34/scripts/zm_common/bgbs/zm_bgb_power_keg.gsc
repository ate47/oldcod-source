#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_power_keg;

// Namespace zm_bgb_power_keg/zm_bgb_power_keg
// Params 0, eflags: 0x2
// Checksum 0x62f17d4d, Offset: 0x98
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_power_keg", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_power_keg/zm_bgb_power_keg
// Params 0, eflags: 0x0
// Checksum 0x5000a550, Offset: 0xe8
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_power_keg", "activated", 1, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_power_keg/zm_bgb_power_keg
// Params 0, eflags: 0x0
// Checksum 0x12258070, Offset: 0x158
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("hero_weapon_power");
}

