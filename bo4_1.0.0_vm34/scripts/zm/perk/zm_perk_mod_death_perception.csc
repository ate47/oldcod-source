#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_death_perception;

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 0, eflags: 0x2
// Checksum 0x766f38a6, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_death_perception", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 0, eflags: 0x0
// Checksum 0xa0c23499, Offset: 0xc0
// Size: 0x14
function __init__() {
    function_491602ae();
}

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 0, eflags: 0x0
// Checksum 0x15d1ae2c, Offset: 0xe0
// Size: 0x74
function function_491602ae() {
    zm_perks::register_perk_clientfields(#"specialty_mod_awareness", &function_76ac2d6c, &function_796109ab);
    zm_perks::register_perk_init_thread(#"specialty_mod_awareness", &function_383cfadf);
}

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function function_383cfadf() {
    
}

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x170
// Size: 0x4
function function_76ac2d6c() {
    
}

// Namespace zm_perk_mod_death_perception/zm_perk_mod_death_perception
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x180
// Size: 0x4
function function_796109ab() {
    
}

