#using script_2a30ac7aa0ee8988;
#using script_54f593f5beb1464a;

#namespace namespace_7faf5154;

// Namespace namespace_7faf5154/namespace_7faf5154
// Params 0, eflags: 0x2
// Checksum 0x34a5016, Offset: 0xa0
// Size: 0xec
function autoexec __init__() {
    str_gametype = getdvarstring(#"g_gametype");
    var_869e3f2f = getdvarstring(#"hash_31435ea827fda47b");
    if (str_gametype === "survival") {
        function_db4c9863();
    } else if (str_gametype === "zsurvival") {
        function_bcd11f83();
    } else if (str_gametype === "incursion") {
        function_8bc58e8a();
    }
    if (var_869e3f2f === "") {
        function_e1f0de0e();
    }
}

// Namespace namespace_7faf5154/namespace_7faf5154
// Params 0, eflags: 0x1 linked
// Checksum 0xf96164e3, Offset: 0x198
// Size: 0x4cc
function function_db4c9863() {
    var_a12b4736 = &item_world_fixup::function_96ff7b88;
    var_d2223309 = &item_world_fixup::function_261ab7f5;
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    var_edfbccd0 = &item_world_fixup::function_e70fa91c;
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_63cae5fcd6d8139d", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_59712033424fcb5", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_7837852097232062", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_1ac0b92447d885c2", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_55e3c88dadb84048", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_4ab3f55ea84505f8", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_48fdac39435ceaba", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_236440cd20c8be44", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_6ae284eaf16662ea", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_5de6b5f9e52cac08", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_7ef200785f38b7d8", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_694cfad6e9e3f2e1", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_4c938d6cde1f9f0a", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_38b07f137849eb74", #"hash_38fb81137889da54");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_47521f5f5d3111e", #"hash_40f0ff5f57c3f56");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_5b8e89b203fd7f7f", #"hash_5b5f93b203d61fbb");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_2c0ce4d504e277bb", #"hash_2bf7ded504d0117f");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_8c78d9cbc396367", #"hash_861779cbbe28ad3");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_8186b03e9dd0460", #"hash_8117d03e9d70448");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_41cc49f77f951d6a", #"hash_41ee47f77fb2006a");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_39a2c3836ee48057", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_3265a77cdea82a18", #"t9_empty_global");
}

// Namespace namespace_7faf5154/namespace_7faf5154
// Params 0, eflags: 0x1 linked
// Checksum 0x8f6af9fb, Offset: 0x670
// Size: 0x1c4
function function_bcd11f83() {
    function_db4c9863();
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_3529e2fc96b06b88", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_21b6e6141157e65a", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_7bbaf1bdd50f5c78", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_1bcf2ad3d97bfde", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_4efccac910b4e0bf", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_5b29f8214752981d", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_618675e83d84bca0", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_6096fa4278a2bab0", #"t9_empty_global");
}

// Namespace namespace_7faf5154/namespace_7faf5154
// Params 0, eflags: 0x0
// Checksum 0xed3a8dda, Offset: 0x840
// Size: 0xae
function function_51b10e5c() {
    var_a12b4736 = &item_world_fixup::function_96ff7b88;
    var_d2223309 = &item_world_fixup::function_261ab7f5;
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    var_edfbccd0 = &item_world_fixup::function_e70fa91c;
}

// Namespace namespace_7faf5154/namespace_7faf5154
// Params 0, eflags: 0x1 linked
// Checksum 0xa91827cb, Offset: 0x8f8
// Size: 0x37c
function function_8bc58e8a() {
    var_a12b4736 = &item_world_fixup::function_96ff7b88;
    var_d2223309 = &item_world_fixup::function_261ab7f5;
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    var_edfbccd0 = &item_world_fixup::function_e70fa91c;
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_63cae5fcd6d8139d", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_59712033424fcb5", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_7837852097232062", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_1ac0b92447d885c2", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_55e3c88dadb84048", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_4ab3f55ea84505f8", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_48fdac39435ceaba", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_236440cd20c8be44", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_6ae284eaf16662ea", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_5de6b5f9e52cac08", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_7ef200785f38b7d8", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_694cfad6e9e3f2e1", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_4c938d6cde1f9f0a", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_39a2c3836ee48057", #"t9_empty_global");
    namespace_1c7b37c6::item_replacer(var_b5014996, var_f8a4c541, #"hash_3265a77cdea82a18", #"t9_empty_global");
}

// Namespace namespace_7faf5154/namespace_7faf5154
// Params 0, eflags: 0x1 linked
// Checksum 0xb1986c10, Offset: 0xc80
// Size: 0x244
function function_e1f0de0e() {
    var_bf04a705 = &item_world_fixup::function_19089c75;
    var_c9915900 = &item_world_fixup::function_6991057;
    namespace_1c7b37c6::item_replacer(var_bf04a705, var_c9915900, #"hash_7f569c6eee010582", #"vehicle_list_empty_wz");
    namespace_1c7b37c6::item_replacer(var_bf04a705, var_c9915900, #"hash_29ea339b33a0da07", #"vehicle_list_empty_wz");
    namespace_1c7b37c6::item_replacer(var_bf04a705, var_c9915900, #"hash_c3a28c5b16ad001", #"vehicle_list_empty_wz");
    namespace_1c7b37c6::item_replacer(var_bf04a705, var_c9915900, #"hash_4738c064b6945229", #"vehicle_list_empty_wz");
    namespace_1c7b37c6::item_replacer(var_bf04a705, var_c9915900, #"hash_5ddefb47f2a64130", #"vehicle_list_empty_wz");
    namespace_1c7b37c6::item_replacer(var_bf04a705, var_c9915900, #"hash_37e3bf041099a834", #"vehicle_list_empty_wz");
    namespace_1c7b37c6::item_replacer(var_bf04a705, var_c9915900, #"hash_7da54b6ea49c9807", #"vehicle_list_empty_wz");
    namespace_1c7b37c6::item_replacer(var_bf04a705, var_c9915900, #"hash_3d7cf11813b0d7dc", #"vehicle_list_empty_wz");
    namespace_1c7b37c6::item_replacer(var_bf04a705, var_c9915900, #"hash_799401e2d5d54ce1", #"vehicle_list_empty_wz");
    namespace_1c7b37c6::item_replacer(var_bf04a705, var_c9915900, #"hash_525f6e6e8c1c2ab3", #"vehicle_list_empty_wz");
    namespace_1c7b37c6::item_replacer(var_bf04a705, var_c9915900, #"hash_2a324fd5e3a02bfd", #"vehicle_list_empty_wz");
}

