#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\load;

#namespace bgb_pack;

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x2
// Checksum 0xf56ea0ab, Offset: 0x120
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"bgb_pack", &__init__, &__main__, undefined);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x0
// Checksum 0xbb0aa60d, Offset: 0x170
// Size: 0x1c6
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    clientfield::register("clientuimodel", "zmhud.bgb_carousel.global_cooldown", 1, 5, "float", undefined, 0, 0);
    for (i = 0; i < 4; i++) {
        clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".state", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".gum_idx", 1, 7, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".cooldown_perc", 1, 5, "float", undefined, 0, 0);
        clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".lockdown", 1, 1, "float", undefined, 0, 0);
        clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".unavailable", 1, 1, "float", undefined, 0, 0);
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x4
// Checksum 0x38df7e61, Offset: 0x340
// Size: 0x26
function private __main__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
}

