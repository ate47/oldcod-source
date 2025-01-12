#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_immolation_liquidation;

// Namespace zm_bgb_immolation_liquidation/zm_bgb_immolation_liquidation
// Params 0, eflags: 0x2
// Checksum 0x76e678a8, Offset: 0x98
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_immolation_liquidation", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_immolation_liquidation/zm_bgb_immolation_liquidation
// Params 0, eflags: 0x0
// Checksum 0x86cadedb, Offset: 0xe8
// Size: 0x74
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_immolation_liquidation", "activated", 1, undefined, undefined, &function_3d1f600e, &activation);
}

// Namespace zm_bgb_immolation_liquidation/zm_bgb_immolation_liquidation
// Params 0, eflags: 0x0
// Checksum 0x146685e9, Offset: 0x168
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("fire_sale", undefined, 96);
}

// Namespace zm_bgb_immolation_liquidation/zm_bgb_immolation_liquidation
// Params 0, eflags: 0x0
// Checksum 0xbc89dde1, Offset: 0x198
// Size: 0x56
function function_3d1f600e() {
    if (zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") === 1 || isdefined(level.disable_firesale_drop) && level.disable_firesale_drop) {
        return false;
    }
    return true;
}

