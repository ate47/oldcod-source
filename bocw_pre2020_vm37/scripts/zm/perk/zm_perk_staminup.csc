#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_staminup;

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x6
// Checksum 0x62f6b1e, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_perk_staminup", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x5 linked
// Checksum 0x6293eac3, Offset: 0x110
// Size: 0x14
function private function_70a657d8() {
    enable_staminup_perk_for_level();
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x1 linked
// Checksum 0x57bf54e2, Offset: 0x130
// Size: 0x9c
function enable_staminup_perk_for_level() {
    zm_perks::register_perk_clientfields(#"hash_602a1b6107105f07", &staminup_client_field_func, &staminup_callback_func);
    zm_perks::register_perk_effects(#"hash_602a1b6107105f07", "marathon_light");
    zm_perks::register_perk_init_thread(#"hash_602a1b6107105f07", &init_staminup);
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x1 linked
// Checksum 0x9b12056, Offset: 0x1d8
// Size: 0x3c
function init_staminup() {
    if (is_true(level.enable_magic)) {
        level._effect[#"marathon_light"] = "zombie/fx_perk_sleight_of_hand_factory_zmb";
    }
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x220
// Size: 0x4
function staminup_client_field_func() {
    
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x230
// Size: 0x4
function staminup_callback_func() {
    
}

