#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_slider;

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x2
// Checksum 0x353ea461, Offset: 0x128
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_slider", &__init__, undefined, undefined);
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0x2de0a4a8, Offset: 0x170
// Size: 0x3a
function __init__() {
    enable_slider_perk_for_level();
    level._effect[#"hash_7b8ad0ed3ef67813"] = "zombie/fx8_perk_phd_exp";
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0x490120e6, Offset: 0x1b8
// Size: 0xd4
function enable_slider_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_phdflopper", &function_f740aeb6, &function_c4067e0d);
    zm_perks::register_perk_effects(#"specialty_phdflopper", "divetonuke_light");
    zm_perks::register_perk_init_thread(#"specialty_phdflopper", &init_slider);
    zm_perks::function_32b099ec(#"specialty_phdflopper", #"p8_zm_vapor_altar_icon_01_phdslider", "zombie/fx8_perk_altar_symbol_ambient_slider");
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x298
// Size: 0x4
function init_slider() {
    
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0x134f9da, Offset: 0x2a8
// Size: 0x94
function function_f740aeb6() {
    clientfield::register("clientuimodel", "hudItems.perks.slider", 1, 1, "int", undefined, 0, 1);
    clientfield::register("allplayers", "" + #"hash_7b8ad0ed3ef67813", 1, 1, "counter", &function_529574f7, 0, 0);
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x348
// Size: 0x4
function function_c4067e0d() {
    
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 7, eflags: 0x0
// Checksum 0x795e1a00, Offset: 0x358
// Size: 0xa4
function function_529574f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        util::playfxontag(localclientnum, level._effect[#"hash_7b8ad0ed3ef67813"], self, "j_spine");
        self playsound(localclientnum, #"hash_25343ce78e1c9c6c");
    }
}

