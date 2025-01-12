#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mystery;

// Namespace zm_perk_mystery/zm_perk_mystery
// Params 0, eflags: 0x2
// Checksum 0x5688786f, Offset: 0xb8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mystery", &__init__, undefined, undefined);
}

// Namespace zm_perk_mystery/zm_perk_mystery
// Params 0, eflags: 0x0
// Checksum 0xf3232f91, Offset: 0x100
// Size: 0x14
function __init__() {
    function_1b8229bc();
}

// Namespace zm_perk_mystery/zm_perk_mystery
// Params 0, eflags: 0x0
// Checksum 0x3d43a3f1, Offset: 0x120
// Size: 0x7c
function function_1b8229bc() {
    zm_perks::register_perk_clientfields(#"specialty_mystery", &function_124e3889, &function_75dd2cd4);
    zm_perks::function_32b099ec(#"specialty_mystery", #"p8_zm_vapor_altar_icon_01_secretsauce", "zombie/fx8_perk_altar_symbol_ambient_secret_sauce");
}

// Namespace zm_perk_mystery/zm_perk_mystery
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1a8
// Size: 0x4
function function_124e3889() {
    
}

// Namespace zm_perk_mystery/zm_perk_mystery
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1b8
// Size: 0x4
function function_75dd2cd4() {
    
}

