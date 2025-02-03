#using script_2a30ac7aa0ee8988;
#using script_54f593f5beb1464a;

#namespace wz_common_mode_hardcore_fixup;

// Namespace wz_common_mode_hardcore_fixup/wz_common_mode_hardcore_fixup
// Params 0, eflags: 0x2
// Checksum 0xf1ce1e77, Offset: 0x70
// Size: 0x14
function autoexec __init__() {
    function_acd44e5f();
}

// Namespace wz_common_mode_hardcore_fixup/wz_common_mode_hardcore_fixup
// Params 0, eflags: 0x0
// Checksum 0x4abe6108, Offset: 0x90
// Size: 0x214
function function_acd44e5f() {
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    if (is_true(getgametypesetting(#"wzhardcore"))) {
        namespace_1c7b37c6::item_remover(var_87d0eef8, #"armor_item_small");
        namespace_1c7b37c6::item_remover(var_87d0eef8, #"armor_item_medium");
        namespace_1c7b37c6::item_remover(var_87d0eef8, #"armor_item_large");
        namespace_1c7b37c6::item_remover(var_87d0eef8, #"armor_shard_item");
        namespace_1c7b37c6::item_remover(var_87d0eef8, #"health_item_large");
        namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_1bb3938ead724a68");
        namespace_1c7b37c6::item_replacer(var_74257310, #"health_item_small", #"health_item_medium");
        namespace_1c7b37c6::item_replacer(var_74257310, #"hash_1b975e4c6ae8b190", #"hash_5119794c0791738");
        namespace_1c7b37c6::item_replacer(var_f8a4c541, #"health_list_low", #"health_list_low_hardcore");
        namespace_1c7b37c6::item_remover(var_87d0eef8, #"sensor_dart_wz_item");
        namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_34fc35458ae105ac");
    }
}

