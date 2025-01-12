#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace namespace_fd3f1217;

// Namespace namespace_fd3f1217/namespace_fd3f1217
// Params 0, eflags: 0x6
// Checksum 0x88b28b55, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_439842ab3085be64", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_fd3f1217/namespace_fd3f1217
// Params 0, eflags: 0x5 linked
// Checksum 0xcc20b81f, Offset: 0x110
// Size: 0x14
function private function_70a657d8() {
    function_a8fdd433();
}

// Namespace namespace_fd3f1217/namespace_fd3f1217
// Params 0, eflags: 0x1 linked
// Checksum 0xc24b8730, Offset: 0x130
// Size: 0x9c
function function_a8fdd433() {
    zm_perks::register_perk_clientfields(#"hash_5930cf0eb070e35a", &function_38dda839, &function_3bdb96bc);
    zm_perks::register_perk_effects(#"hash_5930cf0eb070e35a", "sleight_light");
    zm_perks::register_perk_init_thread(#"hash_5930cf0eb070e35a", &function_7d2154f5);
}

// Namespace namespace_fd3f1217/namespace_fd3f1217
// Params 0, eflags: 0x1 linked
// Checksum 0xe342784c, Offset: 0x1d8
// Size: 0x3c
function function_7d2154f5() {
    if (is_true(level.enable_magic)) {
        level._effect[#"sleight_light"] = "zombie/fx_perk_sleight_of_hand_factory_zmb";
    }
}

// Namespace namespace_fd3f1217/namespace_fd3f1217
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x220
// Size: 0x4
function function_38dda839() {
    
}

// Namespace namespace_fd3f1217/namespace_fd3f1217
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x230
// Size: 0x4
function function_3bdb96bc() {
    
}

