#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace namespace_7461932d;

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x6
// Checksum 0x692aeb4e, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_6f1ab109254f7a8e", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x5 linked
// Checksum 0x538fe009, Offset: 0x110
// Size: 0x9c
function private function_70a657d8() {
    zm_perks::register_perk_clientfields(#"talent_juggernog", &function_2d2b95b0, &function_6c832af6);
    zm_perks::register_perk_effects(#"talent_juggernog", "jugger_light");
    zm_perks::register_perk_init_thread(#"talent_juggernog", &function_545fe52d);
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x1 linked
// Checksum 0xa578f3, Offset: 0x1b8
// Size: 0x3c
function function_545fe52d() {
    if (is_true(level.enable_magic)) {
        level._effect[#"jugger_light"] = "zombie/fx_perk_juggernaut_factory_zmb";
    }
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x200
// Size: 0x4
function function_2d2b95b0() {
    
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x210
// Size: 0x4
function function_6c832af6() {
    
}

