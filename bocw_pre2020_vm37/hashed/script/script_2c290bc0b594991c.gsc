#using script_309ce7f5a9a023de;
#using script_644007a8c3885fc;

#namespace namespace_e27c7374;

// Namespace namespace_e27c7374/namespace_e27c7374
// Params 0, eflags: 0x2
// Checksum 0x9e75bf5f, Offset: 0x160
// Size: 0x14
function autoexec function_88ff61e0() {
    thread function_45a212c0();
}

// Namespace namespace_e27c7374/namespace_e27c7374
// Params 0, eflags: 0x1 linked
// Checksum 0xd647ca6b, Offset: 0x180
// Size: 0x4754
function function_45a212c0() {
    var_a12b4736 = &item_world_fixup::function_96ff7b88;
    var_d2223309 = &item_world_fixup::function_261ab7f5;
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    maxteamplayers = isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1;
    if (!is_true(getgametypesetting(#"hash_232750b87390cbff"))) {
        if (!is_true(getgametypesetting(#"wzenablewallbuyasylum"))) {
            namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_asylum", #"wz_open_skyscrapers_wallbuy_none");
        }
        if (!is_true(getgametypesetting(#"wzenablewallbuydiner"))) {
            namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_diner", #"wz_open_skyscrapers_wallbuy_none");
        }
        if (!is_true(getgametypesetting(#"wzenablewallbuycemetary"))) {
            namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_cemetary", #"wz_open_skyscrapers_wallbuy_none");
        }
        if (!is_true(getgametypesetting(#"wzenablewallbuyfarm"))) {
            namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_farm", #"wz_open_skyscrapers_wallbuy_none");
        }
        if (!is_true(getgametypesetting(#"wzenablewallbuynuketown"))) {
            namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_nuketown", #"wz_open_skyscrapers_wallbuy_none");
        }
        if (!is_true(getgametypesetting(#"wzenablewallbuyboxinggym"))) {
            namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_boxing_gym", #"wz_open_skyscrapers_wallbuy_none");
        }
        if (!is_true(getgametypesetting(#"wzenablewallbuyghosttown"))) {
            namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_ghosttown", #"wz_open_skyscrapers_wallbuy_none");
        }
        if (!is_true(getgametypesetting(#"wzenablewallbuylighthouse"))) {
            namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_lighthouse", #"wz_open_skyscrapers_wallbuy_none");
        }
    }
    if (maxteamplayers == 1) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_medic");
    }
    if (!is_true(getgametypesetting(#"wzsnowballsenabled"))) {
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"wz_snowball", #"");
    }
    if (!is_true(getgametypesetting(#"wzwaterballoonsenabled")) && !is_true(getgametypesetting(#"hash_3e2d2cf6b1cc6c68"))) {
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"wz_waterballoon", #"");
    }
    if (is_true(getgametypesetting(#"hash_230e67d5ddfb2c06"))) {
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"melee_bowie_t8_item", #"melee_bloody_bowie_t8_item");
    }
    if (is_true(getgametypesetting(#"hash_661ee23f114191c1"))) {
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"melee_bowie_t8_item", #"melee_bloody_bowie_t8_item");
    }
    if (is_true(getgametypesetting(#"wztestallvehicles"))) {
        namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"equipment_list_med", #"equipment_list_med_vehicle_test");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"shotgun_fullauto_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"shotgun_pump_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"shotgun_semiauto_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"pistol_fullauto_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"pistol_burst_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"pistol_revolver_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"pistol_standard_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"smg_accurate_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"smg_standard_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"smg_fastburst_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"smg_fastfire_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"smg_capacity_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"smg_folding_t8_item", #"launcher_standard_t8_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"ammo_type_12ga_item", #"ammo_type_rocket_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"ammo_type_9mm_item", #"ammo_type_rocket_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"ammo_type_45_item", #"ammo_type_rocket_item");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"health_item_small", #"grapple_wz_item");
    }
    var_77c6811d = 1;
    if (var_77c6811d) {
        while (!function_82a4c7da() && var_77c6811d) {
            waitframe(1);
            function_205a8326("game mode is invalid.");
        }
    } else if (!function_82a4c7da()) {
        function_205a8326("game mode is invalid. Warning... being ignored!");
    }
    customgame = gamemodeismode(1) || gamemodeismode(7);
    namespace_1c7b37c6::item_remover(var_a12b4736, undefined, #"resource_item_paint");
    if (!is_true(getgametypesetting(#"wzenablespraycans")) || customgame) {
        namespace_1c7b37c6::item_remover(var_87d0eef8, undefined, #"resource_item_paint");
        function_48b77dbf(customgame);
    } else {
        maxteamplayers = isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1;
        if (maxteamplayers == 1) {
            namespace_1c7b37c6::item_replacer(var_f8a4c541, undefined, #"resource_item_paint_list_furniture", #"resource_item_paint_list_furniture_solo");
            namespace_1c7b37c6::item_replacer(var_f8a4c541, undefined, #"resource_item_paint_list", #"resource_item_paint_list_solo");
            function_205a8326("using solo paintcan spawners.", "not a custom game and max team players is 1");
        } else {
            function_205a8326("using default paintcan spawners.", "not a custom game and max team players is " + maxteamplayers);
        }
    }
    if (!is_true(getgametypesetting(#"wzenablesecretsanta"))) {
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"melee_secretsanta_t8_item", #"");
    }
    if (!is_true(getgametypesetting(#"wzenableslaybell"))) {
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"melee_slaybell_t8_item", #"");
    }
    if (is_true(getgametypesetting(#"wzenablecontrabandstash"))) {
        namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"blackjack_ammo_stash_parent_placeholder", #"blackjack_ammo_stash_parent_guns");
    }
    if (is_true(getgametypesetting(#"hash_5a53f3b3ea6cb7be"))) {
    }
    if (!is_true(getgametypesetting(#"wzenableoperatorweapons"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_fastfire_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_stealth_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_longburst_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_midburst_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_powersemi_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_fastrechamber_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_quickscope_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_spray_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_standard_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_accurate_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastfire_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_revolver_t8_operator_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_mini14_t8_operator_item");
    } else {
        if (!is_true(getgametypesetting(#"wzenablemaddox"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_fastfire_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenablevapr"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_stealth_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenableswordfish"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_longburst_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenableabr"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_midburst_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenableauger"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_powersemi_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenableoutlaw"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_fastrechamber_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenablekoshka"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_quickscope_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenablehades"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_spray_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenabletitan"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_standard_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenablegks"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_accurate_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenablespitfire"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastfire_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenablemozu"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_revolver_t8_operator_item");
        }
        if (!is_true(getgametypesetting(#"wzenablevendetta"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_mini14_t8_operator_item");
        }
    }
    if (!is_true(getgametypesetting(#"hash_5c6371ef701d7485"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_revolver_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_handling_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_accurate_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_standard_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_capacity_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastburst_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_folding_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_accurate_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_modular_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_standard_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_damage_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_fastfire_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_stealth_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_longburst_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_midburst_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_powersemi_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_mini14_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_standard_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_spray_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_heavy_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_quickscope_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powerbolt_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powersemi_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powersemi_t8_gold_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_fastrechamber_t8_gold_item");
    } else {
        if (!is_true(getgametypesetting(#"wzenablestrife"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_standard_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablemozu"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_revolver_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablerk7"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_burst_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablekap45"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_fullauto_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablemog12"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_pump_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablesg12"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_semiauto_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablerampage"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_fullauto_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablesaug"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_handling_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablespitfire"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastfire_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablemx9"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_standard_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablecordite"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_capacity_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablegks"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_accurate_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenabledaemon"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastburst_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenableswitchblade"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_folding_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenableicr"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_accurate_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablekn"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_modular_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenableswat"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_standard_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablerampart"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_damage_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablemaddox"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_fastfire_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablevapr"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_stealth_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenableswordfish"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_longburst_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenableabr"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_midburst_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenableauger"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_powersemi_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablevendetta"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_mini14_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenabletitan"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_standard_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablehades"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_spray_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablevkm"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_heavy_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablekoshka"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_quickscope_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablepaladin"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powerbolt_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenablesdm"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powersemi_t8_gold_item");
        }
        if (!is_true(getgametypesetting(#"wzenableoutlaw"))) {
            namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_fastrechamber_t8_gold_item");
        }
    }
    if (!is_true(getgametypesetting(#"wzenablewarmachine"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"warmachine_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablepurifier"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"flamethrower_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenableannihilator"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"hash_6c0eed50f4c26acb");
    }
    if (!is_true(getgametypesetting(#"wzenablesparrow"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sparrow_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenableraygun"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ray_gun_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableraygunmark2"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ray_gun_mk2_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableblundergat"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"blundergat_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablecoinbag"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"melee_coinbag_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablestrife"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_standard_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablemozu"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_revolver_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablerk7"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_burst_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablekap45"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_fullauto_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablemog12"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_pump_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablesg12"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_semiauto_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablerampage"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_fullauto_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableargus"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_precision_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablesaug"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_handling_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablespitfire"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastfire_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablemx9"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_standard_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablemp40"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_mp40_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablecordite"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_capacity_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablegks"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_accurate_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenabledaemon"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastburst_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableswitchblade"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smg_folding_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableicr"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_accurate_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablekn"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_modular_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableswat"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_standard_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablerampart"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_damage_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablemaddox"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_fastfire_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablevapr"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_stealth_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablegrav"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ar_galil_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableswordfish"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_longburst_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableabr"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_midburst_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableauger"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_powersemi_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablevendetta"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_mini14_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablem16"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_damageburst_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenabletitan"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_standard_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablehades"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_spray_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablevkm"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_heavy_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablekoshka"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_quickscope_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablepaladin"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powerbolt_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablesdm"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powersemi_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableoutlaw"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_fastrechamber_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablevivaldi"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniper_damagesemi_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableessex"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tr_leveraction_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablezweihander"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"lmg_double_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablelauncher"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"launcher_standard_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablebowieknife"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"melee_bowie_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablehomewrecker"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"melee_demohammer_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablezombiearm"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"melee_zombiearm_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablestopsign"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"melee_stopsign_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableblade"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sig_blade_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenabledeathoforion"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"death_of_orion_t8_item");
    }
    if (!is_true(getgametypesetting(#"hash_5408e974098bc234"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ray_gun_mk2x_t8_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ray_gun_mk2y_t8_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ray_gun_mk2z_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablesavageimpaler"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ww_crossbow_impaler_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablegambit22"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"special_crossbow_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenablewintersfury"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ww_winters_fury_t8_item");
    }
    if (!is_true(getgametypesetting(#"wzenableempgrenade"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"emp_grenade_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenableconcussiongrenade"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"concussion_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablesensordart"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sensor_dart_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenableclustergrenade"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"cluster_semtex_wz_item");
    }
    if (!is_true(getgametypesetting(#"hash_33f617edacaa066a"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"hash_6a07ccefe7f84985");
    }
    if (!is_true(getgametypesetting(#"wzenablegrapple"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"grapple_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablegrapple"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"grapple_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablebarricade"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"barricade_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablereconcar"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"recon_car_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablemeshmines"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"trip_wire_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenabletrophysystem"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"trophy_system_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablesmokegrenade"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"smoke_grenade_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablemolotov"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"molotov_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablecombataxe"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"hatchet_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablerazorwire"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"concertina_wire_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablefraggrenade"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"frag_grenade_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenableacidbomb"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"acid_bomb_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablewraithfire"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"wraithfire_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablecymbalmonkey"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"cymbal_monkey_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablebackpack"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"backpack_item");
    }
    if (!is_true(getgametypesetting(#"wzenableflareguns"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"flare_gun_wz_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"flare_gun_veh_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablespectregrenade"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"spectre_grenade_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenabledart"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"dart_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablehawk"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"hawk_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablehellsretriever"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tomahawk_t8_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablehomunculus"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"homunculus_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablesentrygun"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"ultimate_turret_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablebandages"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"health_item_small");
    }
    if (!is_true(getgametypesetting(#"wzenablemedkit"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"health_item_medium");
    }
    if (!is_true(getgametypesetting(#"wzenabletraumakit"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"health_item_large");
    }
    if (!is_true(getgametypesetting(#"wzenabletak5"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"health_item_squad");
    }
    if (!is_true(getgametypesetting(#"wzenableperkparanoia"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_paranoia");
    }
    if (!is_true(getgametypesetting(#"wzenableperkconsumer"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_consumer");
    }
    if (!is_true(getgametypesetting(#"wzenableperkironlungs"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_ironlungs");
    }
    if (!is_true(getgametypesetting(#"wzenableperkbrawler"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_brawler");
    }
    if (!is_true(getgametypesetting(#"wzenableperkawareness"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_awareness");
    }
    if (!is_true(getgametypesetting(#"wzenableperklooter"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_looter");
    }
    if (!is_true(getgametypesetting(#"wzenableperksquadlink"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_squadlink");
    }
    if (!is_true(getgametypesetting(#"wzenableperkreinforced"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_reinforced");
    }
    if (!is_true(getgametypesetting(#"wzenableperkmedic"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_medic");
    }
    if (!is_true(getgametypesetting(#"hash_78e459ad87509a46"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_drifter");
    }
    if (!is_true(getgametypesetting(#"wzenableperkdeadsilence"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_deadsilence");
    }
    if (!is_true(getgametypesetting(#"wzenableperkstimulant"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_stimulant");
    }
    if (!is_true(getgametypesetting(#"wzenableperkmobility"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_lightweight");
    }
    if (!is_true(getgametypesetting(#"wzenableperkengineer"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_engineer");
    }
    if (!is_true(getgametypesetting(#"wzenableperkoutlander"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_outlander");
    }
    if (!is_true(getgametypesetting(#"wzenablelv3armor"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_large");
    }
    if (!is_true(getgametypesetting(#"wzenablelv2armor"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_medium");
    }
    if (!is_true(getgametypesetting(#"wzenablelv1armor"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_small");
    }
    if (!is_true(getgametypesetting(#"wzenablearmorplate"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"armor_shard_item");
    }
    if (!is_true(getgametypesetting(#"wzenable4xscope"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"acog_plus_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenable3xscope"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"reddot_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenable2xscope"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"acog_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenableextfastmag"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"advmag_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenableextmag"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"extmag_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenableextbarrel"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"extbarrel_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablefastmag"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"fastmag_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenableforegrip"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"foregrip_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenableholo"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"holo_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablelasersight"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"laser_sight_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablepistolgrip"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"pistol_grip_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablereflex"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"reflex_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablesniperscope"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sniperscope_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablestock"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"stock_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenablesuppressor"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"suppressor_wz_item");
    }
    if (!is_true(getgametypesetting(#"wzenableelo"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"tritium_wz_item");
    }
}

// Namespace namespace_e27c7374/namespace_e27c7374
// Params 2, eflags: 0x5 linked
// Checksum 0xbb3352ea, Offset: 0x48e0
// Size: 0x74
function private function_205a8326(msg, var_9fb99f62) {
    /#
        if (isdefined(var_9fb99f62)) {
            println("<dev string:x38>" + msg + "<dev string:x50>" + var_9fb99f62);
            return;
        }
        println("<dev string:x38>" + msg);
    #/
}

// Namespace namespace_e27c7374/namespace_e27c7374
// Params 1, eflags: 0x5 linked
// Checksum 0xe68fd15, Offset: 0x4960
// Size: 0x124
function private function_48b77dbf(customgame) {
    /#
        var_9fb99f62 = "<dev string:x5e>";
        if (!is_true(getgametypesetting(#"wzenablespraycans"))) {
            var_9fb99f62 = "<dev string:x69>" + (isdefined(getgametypesetting(#"wzenablespraycans")) ? getgametypesetting(#"wzenablespraycans") : "<dev string:x81>");
        } else if (customgame) {
            if (gamemodeismode(1)) {
                var_9fb99f62 = "<dev string:x8e>";
            } else if (gamemodeismode(7)) {
                var_9fb99f62 = "<dev string:x9f>";
            }
        }
        function_205a8326("<dev string:xb6>", var_9fb99f62);
    #/
}

