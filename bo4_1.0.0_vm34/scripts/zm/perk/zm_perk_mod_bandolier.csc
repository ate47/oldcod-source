#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_bandolier;

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 0, eflags: 0x2
// Checksum 0xa67dff40, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_bandolier", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 0, eflags: 0x0
// Checksum 0x20c25a6a, Offset: 0x108
// Size: 0x14
function __init__() {
    function_1b8229bc();
}

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 0, eflags: 0x0
// Checksum 0x68fd1ae0, Offset: 0x128
// Size: 0x9c
function function_1b8229bc() {
    zm_perks::register_perk_clientfields(#"specialty_mod_extraammo", &function_124e3889, &function_75dd2cd4);
    zm_perks::register_perk_effects(#"specialty_mod_extraammo", "sleight_light");
    zm_perks::register_perk_init_thread(#"specialty_mod_extraammo", &init_perk);
}

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 0, eflags: 0x0
// Checksum 0x7331c31c, Offset: 0x1d0
// Size: 0x24
function init_perk() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
    }
}

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 0, eflags: 0x0
// Checksum 0x5e00be76, Offset: 0x200
// Size: 0x3c
function function_124e3889() {
    clientfield::register("clientuimodel", "hudItems.perks.bandolier", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x248
// Size: 0x4
function function_75dd2cd4() {
    
}

