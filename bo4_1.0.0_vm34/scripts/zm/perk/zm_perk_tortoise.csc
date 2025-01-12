#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_tortoise;

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x2
// Checksum 0xc7bedb18, Offset: 0x150
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_tortoise", &__init__, undefined, undefined);
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0xfed6304d, Offset: 0x198
// Size: 0x3a
function __init__() {
    enable_tortoise_perk_for_level();
    level._effect[#"perk_tortoise_explosion"] = "zombie/fx8_perk_vic_tort_exp";
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0x69a2f710, Offset: 0x1e0
// Size: 0xd4
function enable_tortoise_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_shield", &function_c7203b4c, &function_6e9cac8b);
    zm_perks::register_perk_effects(#"specialty_shield", "divetonuke_light");
    zm_perks::register_perk_init_thread(#"specialty_shield", &function_c7044943);
    zm_perks::function_32b099ec(#"specialty_shield", #"p8_zm_vapor_altar_icon_01_victorioustortoise", "zombie/fx8_perk_altar_symbol_ambient_victorious_tortoise");
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2c0
// Size: 0x4
function function_c7044943() {
    
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0x56eef7a2, Offset: 0x2d0
// Size: 0x84
function function_c7203b4c() {
    clientfield::register("clientuimodel", "hudItems.perks.tortoise", 1, 1, "int", undefined, 0, 1);
    clientfield::register("allplayers", "perk_tortoise_explosion", 1, 1, "counter", &function_51dfed1, 0, 0);
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x360
// Size: 0x4
function function_6e9cac8b() {
    
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 7, eflags: 0x0
// Checksum 0xe1c934ce, Offset: 0x370
// Size: 0x7c
function function_51dfed1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        util::playfxontag(localclientnum, level._effect[#"perk_tortoise_explosion"], self, " j_spine");
    }
}

