#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mystery;

// Namespace zm_perk_mystery/zm_perk_mystery
// Params 0, eflags: 0x2
// Checksum 0x722228d5, Offset: 0xd8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mystery", &__init__, undefined, undefined);
}

// Namespace zm_perk_mystery/zm_perk_mystery
// Params 0, eflags: 0x0
// Checksum 0x737e371a, Offset: 0x120
// Size: 0x14
function __init__() {
    function_1b8229bc();
}

// Namespace zm_perk_mystery/zm_perk_mystery
// Params 0, eflags: 0x0
// Checksum 0x42ad1f34, Offset: 0x140
// Size: 0xbc
function function_1b8229bc() {
    zm_perks::register_perk_basic_info(#"specialty_mystery", "perk_mystery", 1500, #"zombie/perk_mystery", getweapon("zombie_perk_bottle_sleight"), getweapon("zombie_perk_vapor_juggernaut"), #"zmperkssecretsauce");
    zm_perks::register_perk_mod_basic_info(#"hash_23c63c9a3acb397", "perk_mod_mystery", #"specialty_mystery", 2500);
}

