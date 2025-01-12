#using script_2a30ac7aa0ee8988;
#using script_54f593f5beb1464a;

#namespace namespace_69456f97;

// Namespace namespace_69456f97/namespace_69456f97
// Params 0, eflags: 0x2
// Checksum 0xd03454a5, Offset: 0x70
// Size: 0x14
function autoexec __init__() {
    function_acd44e5f();
}

// Namespace namespace_69456f97/namespace_69456f97
// Params 0, eflags: 0x1 linked
// Checksum 0x7fe4dc4d, Offset: 0x90
// Size: 0x25c
function function_acd44e5f() {
    var_a12b4736 = &item_world_fixup::function_96ff7b88;
    var_d2223309 = &item_world_fixup::function_261ab7f5;
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    if (is_true(getgametypesetting(#"wzhardcore"))) {
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_small");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_medium");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_large");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"armor_shard_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"health_item_large");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"hash_1bb3938ead724a68");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"health_item_small", #"health_item_medium");
        namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_1b975e4c6ae8b190", #"hash_5119794c0791738");
        namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"health_list_low", #"health_list_low_hardcore");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"sensor_dart_wz_item");
        namespace_1c7b37c6::item_remover(var_a12b4736, var_87d0eef8, #"hash_34fc35458ae105ac");
    }
}

