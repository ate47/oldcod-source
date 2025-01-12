#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_tortoise;

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 0, eflags: 0x2
// Checksum 0x7b532aed, Offset: 0x88
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_tortoise", &__init__, &__main__, undefined);
}

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 0, eflags: 0x0
// Checksum 0xa1f882, Offset: 0xd8
// Size: 0x14
function __init__() {
    function_d809c7dd();
}

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xf8
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 0, eflags: 0x0
// Checksum 0x5436f1f6, Offset: 0x108
// Size: 0x84
function function_d809c7dd() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_shield", "mod_tortoise", #"specialty_shield", 3500);
    zm_perks::register_perk_threads(#"specialty_mod_shield", &function_ccbbfa10, &function_719c0f3a);
}

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function function_ccbbfa10() {
    
}

// Namespace zm_perk_mod_tortoise/zm_perk_mod_tortoise
// Params 3, eflags: 0x0
// Checksum 0xdeb82c56, Offset: 0x1a8
// Size: 0x1c
function function_719c0f3a(b_pause, str_perk, str_result) {
    
}

