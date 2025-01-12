#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_death_perception;

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 0, eflags: 0x2
// Checksum 0x6e96421f, Offset: 0x90
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_death_perception", &__init__, &__main__, undefined);
}

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 0, eflags: 0x0
// Checksum 0xe6a1556b, Offset: 0xe0
// Size: 0x14
function __init__() {
    function_491602ae();
}

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x100
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 0, eflags: 0x0
// Checksum 0xd6c6be2e, Offset: 0x110
// Size: 0x84
function function_491602ae() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_awareness", "mod_death_perception", #"specialty_awareness", 3500);
    zm_perks::register_perk_threads(#"specialty_mod_awareness", &function_669f8577, &function_af7e5e1d);
}

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1a0
// Size: 0x4
function function_669f8577() {
    
}

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 3, eflags: 0x0
// Checksum 0xe4e97628, Offset: 0x1b0
// Size: 0x1c
function function_af7e5e1d(b_pause, str_perk, str_result) {
    
}

