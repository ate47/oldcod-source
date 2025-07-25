#using script_309ce7f5a9a023de;
#using script_644007a8c3885fc;

#namespace wz_common_mode_ambush_fixup;

// Namespace wz_common_mode_ambush_fixup/wz_common_mode_ambush_fixup
// Params 0, eflags: 0x2
// Checksum 0x7d90eb0, Offset: 0x88
// Size: 0x14
function autoexec __init__() {
    function_62cd02cc();
}

// Namespace wz_common_mode_ambush_fixup/wz_common_mode_ambush_fixup
// Params 0, eflags: 0x0
// Checksum 0x2d9a30c0, Offset: 0xa8
// Size: 0xa7c
function function_62cd02cc() {
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    var_edfbccd0 = &item_world_fixup::function_e70fa91c;
    var_e92b5b25 = getgametypesetting(#"wzambush");
    if (is_true(var_e92b5b25)) {
        namespace_1c7b37c6::item_replacer(var_74257310, #"ammo_type_45_item", #"ammo_type_50cal_item");
        namespace_1c7b37c6::item_replacer(var_74257310, #"ammo_type_556_item", #"ammo_type_338_item");
        namespace_1c7b37c6::item_replacer(var_74257310, #"ammo_type_762_item", #"ammo_type_338_item");
        namespace_1c7b37c6::item_replacer(var_74257310, #"ammo_type_9mm_item", #"ammo_type_338_item");
        namespace_1c7b37c6::item_replacer(var_74257310, #"ammo_type_12ga_item", #"ammo_type_50cal_item");
        if (var_e92b5b25 == 1) {
            str_list = #"ambush";
        } else {
            namespace_1c7b37c6::item_replacer(var_f8a4c541, #"equipment_list_good", #"equipment_list_good_ambush_v2");
            namespace_1c7b37c6::item_replacer(var_f8a4c541, #"hash_30dcaca16025cb02", #"ambush_v2_supply_stash_weapons");
            str_list = #"ambush_v2";
        }
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"open_skyscraper_vehicles_arav", #"open_skyscraper_vehicles_cargo_truck_small");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"guns_zombie_dlc1", str_list + "_guns");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"guns_pistols_dlc1", str_list + "_guns");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"guns_shotguns_dlc1", str_list + "_guns");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"guns_smgs_dlc1", str_list + "_guns");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"guns_ars_dlc1", str_list + "_guns");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"guns_trs_dlc1", str_list + "_guns");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"guns_lmgs_dlc1", str_list + "_guns");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"guns_gold_parent", str_list + "_guns_gold");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"guns_gold_parent_dlc1", str_list + "_guns_gold");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"attachment_list_good", #"attachment_list_good_ambush");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"attachment_list_med", #"attachment_list_med_ambush");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"attachment_list_low", #"attachment_list_low_ambush");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"equipment_list_low", #"equipment_list_low_ambush");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"equipment_list_zombie", #"equipment_list_zombie_ambush");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"gear_list_good", #"gear_list_good_ambush");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"consumable_list_low", #"consumable_list_low_ambush");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"consumable_list_med", #"consumable_list_med_ambush");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"consumable_list_good", #"consumable_list_good_ambush");
        if (is_true(getgametypesetting(#"wzenablewallbuyasylum")) || is_true(getgametypesetting(#"hash_232750b87390cbff"))) {
            namespace_1c7b37c6::item_replacer(var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_asylum", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
        }
        if (is_true(getgametypesetting(#"wzenablewallbuydiner")) || is_true(getgametypesetting(#"hash_232750b87390cbff"))) {
            namespace_1c7b37c6::item_replacer(var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_diner", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
        }
        if (is_true(getgametypesetting(#"wzenablewallbuycemetary")) || is_true(getgametypesetting(#"hash_232750b87390cbff"))) {
            namespace_1c7b37c6::item_replacer(var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_cemetary", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
        }
        if (is_true(getgametypesetting(#"wzenablewallbuyfarm")) || is_true(getgametypesetting(#"hash_232750b87390cbff"))) {
            namespace_1c7b37c6::item_replacer(var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_farm", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
        }
        if (is_true(getgametypesetting(#"wzenablewallbuynuketown")) || is_true(getgametypesetting(#"hash_232750b87390cbff"))) {
            namespace_1c7b37c6::item_replacer(var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_nuketown", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
        }
        if (is_true(getgametypesetting(#"wzenablewallbuyboxinggym")) || is_true(getgametypesetting(#"hash_232750b87390cbff"))) {
            namespace_1c7b37c6::item_replacer(var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_boxing_gym", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
        }
        if (is_true(getgametypesetting(#"wzenablewallbuyghosttown")) || is_true(getgametypesetting(#"hash_232750b87390cbff"))) {
            namespace_1c7b37c6::item_replacer(var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_ghosttown", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
        }
        if (is_true(getgametypesetting(#"wzenablewallbuylighthouse")) || is_true(getgametypesetting(#"hash_232750b87390cbff"))) {
            namespace_1c7b37c6::item_replacer(var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_lighthouse", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
        }
    }
}

