#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_bandolier;

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x2
// Checksum 0xf0911b82, Offset: 0xe8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_bandolier", &__init__, undefined, undefined);
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x0
// Checksum 0xc76bd0ff, Offset: 0x130
// Size: 0x14
function __init__() {
    function_1b8229bc();
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x0
// Checksum 0xac04ac92, Offset: 0x150
// Size: 0xd4
function function_1b8229bc() {
    zm_perks::register_perk_clientfields(#"specialty_extraammo", &function_124e3889, &function_75dd2cd4);
    zm_perks::register_perk_effects(#"specialty_extraammo", "sleight_light");
    zm_perks::register_perk_init_thread(#"specialty_extraammo", &init_perk);
    zm_perks::function_32b099ec(#"specialty_extraammo", #"p8_zm_vapor_altar_icon_01_bandolierbandit", "zombie/fx8_perk_altar_symbol_ambient_bandolier");
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x0
// Checksum 0x51b080e4, Offset: 0x230
// Size: 0x24
function init_perk() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
    }
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x0
// Checksum 0x1decc745, Offset: 0x260
// Size: 0x3c
function function_124e3889() {
    clientfield::register("clientuimodel", "hudItems.perks.bandolier", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2a8
// Size: 0x4
function function_75dd2cd4() {
    
}

