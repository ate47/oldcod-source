#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_tortoise;

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 0, eflags: 0x2
// Checksum 0x764585b, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_tortoise", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 0, eflags: 0x0
// Checksum 0xfa770ad2, Offset: 0xc0
// Size: 0x14
function __init__() {
    function_d809c7dd();
}

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 0, eflags: 0x0
// Checksum 0x2ab05a0c, Offset: 0xe0
// Size: 0x74
function function_d809c7dd() {
    zm_perks::register_perk_clientfields(#"specialty_mod_shield", &function_c65c5671, &function_2a38d1bc);
    zm_perks::register_perk_init_thread(#"specialty_mod_shield", &function_78e77c6a);
}

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function function_78e77c6a() {
    
}

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x170
// Size: 0x4
function function_c65c5671() {
    
}

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x180
// Size: 0x4
function function_2a38d1bc() {
    
}

