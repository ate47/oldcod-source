#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\load;

#namespace bgb_pack;

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x6
// Checksum 0xf83e265c, Offset: 0x128
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"bgb_pack", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x5 linked
// Checksum 0x4cf3fea2, Offset: 0x180
// Size: 0x3ac
function private function_70a657d8() {
    if (!is_true(level.bgb_in_use)) {
        return;
    }
    clientfield::register_clientuimodel("zmhud.bgb_carousel.global_cooldown", #"bgb_carousel", #"global_cooldown", 1, 5, "float", undefined, 0, 0);
    for (i = 0; i < 4; i++) {
        clientfield::register_clientuimodel("zmhud.bgb_carousel." + i + ".state", #"bgb_carousel", [hash(isdefined(i) ? "" + i : ""), #"state"], 1, 2, "int", undefined, 0, 0);
        clientfield::register_clientuimodel("zmhud.bgb_carousel." + i + ".gum_idx", #"bgb_carousel", [hash(isdefined(i) ? "" + i : ""), #"gum_idx"], 1, 7, "int", undefined, 0, 0);
        clientfield::register_clientuimodel("zmhud.bgb_carousel." + i + ".cooldown_perc", #"bgb_carousel", [hash(isdefined(i) ? "" + i : ""), #"cooldown_perc"], 1, 5, "float", undefined, 0, 0);
        clientfield::register_clientuimodel("zmhud.bgb_carousel." + i + ".lockdown", #"bgb_carousel", [hash(isdefined(i) ? "" + i : ""), #"lockdown"], 1, 1, "float", undefined, 0, 0);
        clientfield::register_clientuimodel("zmhud.bgb_carousel." + i + ".unavailable", #"bgb_carousel", [hash(isdefined(i) ? "" + i : ""), #"unavailable"], 1, 1, "float", undefined, 0, 0);
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x5 linked
// Checksum 0x74d80194, Offset: 0x538
// Size: 0x20
function private postinit() {
    if (!is_true(level.bgb_in_use)) {
        return;
    }
}

