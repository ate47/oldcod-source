#using script_309ce7f5a9a023de;
#using script_644007a8c3885fc;

#namespace namespace_1bfb9327;

// Namespace namespace_1bfb9327/namespace_1bfb9327
// Params 0, eflags: 0x2
// Checksum 0x1ffc2e6c, Offset: 0x70
// Size: 0x14
function autoexec __init__() {
    function_a38f195f();
}

// Namespace namespace_1bfb9327/namespace_1bfb9327
// Params 0, eflags: 0x1 linked
// Checksum 0x8464fa6a, Offset: 0x90
// Size: 0x624
function function_a38f195f() {
    var_a12b4736 = &item_world_fixup::function_96ff7b88;
    var_d2223309 = &item_world_fixup::function_261ab7f5;
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    if (is_true(getgametypesetting(#"hash_2e25d475b271a700"))) {
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday");
    }
    if (is_true(getgametypesetting(#"wzgreeneyes"))) {
        maxteamplayers = isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1;
        if (maxteamplayers == 1) {
            item_world_fixup::function_2749fcc3(#"hash_47a63bc4a605b45f", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_solo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_779cba7072600ad1", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_solo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_75cc919e81dc8b19", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_solo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_6056a687e77f7229", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_solo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_550872d1d1938f94", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_solo", 2147483647);
            item_world_fixup::function_2749fcc3(#"zombie_stash_graveyard_ee", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_solo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_a211476d10546c", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_solo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_7d028af90dad72ae", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_solo", 2147483647);
            return;
        }
        if (maxteamplayers == 2) {
            item_world_fixup::function_2749fcc3(#"hash_47a63bc4a605b45f", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_duo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_779cba7072600ad1", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_duo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_75cc919e81dc8b19", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_duo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_6056a687e77f7229", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_duo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_550872d1d1938f94", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_duo", 2147483647);
            item_world_fixup::function_2749fcc3(#"zombie_stash_graveyard_ee", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_duo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_a211476d10546c", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_duo", 2147483647);
            item_world_fixup::function_2749fcc3(#"hash_7d028af90dad72ae", #"zombie_supply_stash_ee_parent", #"zombie_supply_stash_ee_parent_duo", 2147483647);
        }
    }
}
