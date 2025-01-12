#using script_2a30ac7aa0ee8988;
#using script_54f593f5beb1464a;

#namespace namespace_5f402033;

// Namespace namespace_5f402033/namespace_5f402033
// Params 0, eflags: 0x2
// Checksum 0x72925afb, Offset: 0x80
// Size: 0x54
function autoexec function_ceb1991() {
    gametype = getdvarstring(#"g_gametype");
    if (gametype === "survival") {
        function_c2e022a9();
    }
}

// Namespace namespace_5f402033/namespace_5f402033
// Params 0, eflags: 0x1 linked
// Checksum 0xf4185265, Offset: 0xe0
// Size: 0x1b4
function function_c2e022a9() {
    var_a12b4736 = &item_world_fixup::function_96ff7b88;
    var_d2223309 = &item_world_fixup::function_261ab7f5;
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"ammo_shotgun_item_t9", #"ammo_shotgun_item_t9_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"ammo_large_caliber_item_t9", #"ammo_large_caliber_item_t9_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"ammo_small_caliber_item_t9", #"ammo_small_caliber_item_t9_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"ammo_sniper_item_t9", #"ammo_sniper_item_t9_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"ammo_ar_item_t9", #"ammo_ar_item_t9_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"ammo_special_item_t9", #"ammo_special_item_t9_sr");
}

