#using script_309ce7f5a9a023de;
#using script_644007a8c3885fc;

#namespace wz_common_mode_hot_pursuit_fixup;

// Namespace wz_common_mode_hot_pursuit_fixup/wz_common_mode_hot_pursuit_fixup
// Params 0, eflags: 0x2
// Checksum 0x9a3169f6, Offset: 0x70
// Size: 0x14
function autoexec __init__() {
    function_b01adb59();
}

// Namespace wz_common_mode_hot_pursuit_fixup/wz_common_mode_hot_pursuit_fixup
// Params 0, eflags: 0x0
// Checksum 0xf2fa3d78, Offset: 0x90
// Size: 0x524
function function_b01adb59() {
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    if (is_true(getgametypesetting(#"hash_3083d02ea0f5761c"))) {
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"equipment_list_good", #"equipment_list_good_no_cluster_conc");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"health_list_good", #"health_list_good_nothing");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"gear_list_good", #"gear_list_good_nothing");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"guns_launchers_dlc1", #"guns_launchers_dlc1_limit_world_high_value");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"equipment_list_zombie", #"equipment_list_zombie_no_acid");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"guns_gold_parent_dlc1", #"guns_gold_parent_dlc1_limit_world_high_value");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"ammo_stash_parent_dlc1", #"ammo_stash_parent_dlc1_limit_world_high_value");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"supply_stash_parent_dlc1", #"supply_stash_parent_dlc1_limit_world_high_value");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"supply_stash_slot1_dlc1", #"supply_stash_slot1_dlc1_limit_high_world_value");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"supply_stash_slot2_dlc1", #"supply_stash_slot2_dlc1_limit_world_high_value");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"supply_stash_slot3_dlc1", #"supply_stash_slot3_dlc1_limit_world_high_value");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"supply_stash_slot4_dlc1", #"supply_stash_slot4_dlc1_with_conc");
    }
    if (is_true(getgametypesetting(#"wzenablehotpursuit"))) {
        namespace_1c7b37c6::item_remover(var_87d0eef8, #"perk_item_outlander");
        namespace_1c7b37c6::item_remover(var_87d0eef8, #"recon_car_wz_item");
    }
    if (is_true(getgametypesetting(#"wzenablebountyhuntervehicles")) && !is_true(getgametypesetting(#"wztestallvehicles"))) {
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_police");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"open_skyscraper_vehicles_atv_ghost_town", #"open_skyscraper_vehicles_atv_ghost_town_police");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"open_skyscraper_vehicles_suv_police");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"open_skyscraper_vehicles_heli", #"open_skyscraper_vehicles_heli_police");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"open_skyscraper_vehicles_heli_clearing", #"open_skyscraper_vehicles_heli_clearing_police");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"open_skyscraper_vehicles_arav_clearing", #"open_skyscraper_vehicles_suv_clearing_police");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"open_skyscraper_vehicles_pbr", #"open_skyscraper_vehicles_pbr_police");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck_clearing", #"open_skyscraper_vehicles_suv_clearing_police");
    }
}

