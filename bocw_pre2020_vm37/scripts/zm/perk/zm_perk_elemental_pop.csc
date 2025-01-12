#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_elemental_pop;

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 0, eflags: 0x6
// Checksum 0x48134dd, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_perk_elemental_pop", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 0, eflags: 0x5 linked
// Checksum 0x4ac2531b, Offset: 0xf8
// Size: 0x14
function private function_70a657d8() {
    function_27473e44();
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 0, eflags: 0x1 linked
// Checksum 0x61db90a1, Offset: 0x118
// Size: 0x9c
function function_27473e44() {
    zm_perks::register_perk_clientfields(#"hash_51b6cc6dbafb7f31", &client_field_func, &function_f71e2d8f);
    zm_perks::register_perk_effects(#"hash_51b6cc6dbafb7f31", "elemental_pop_light");
    zm_perks::register_perk_init_thread(#"hash_51b6cc6dbafb7f31", &init_perk);
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 0, eflags: 0x1 linked
// Checksum 0x745a6ed4, Offset: 0x1c0
// Size: 0x3c
function init_perk() {
    if (is_true(level.enable_magic)) {
        level._effect[#"elemental_pop_light"] = "zombie/fx_perk_juggernaut_factory_zmb";
    }
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x208
// Size: 0x4
function client_field_func() {
    
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x218
// Size: 0x4
function function_f71e2d8f() {
    
}

