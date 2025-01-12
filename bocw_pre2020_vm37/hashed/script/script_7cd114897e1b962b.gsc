#using script_309ce7f5a9a023de;
#using script_644007a8c3885fc;

#namespace namespace_7613a4d0;

// Namespace namespace_7613a4d0/namespace_7613a4d0
// Params 0, eflags: 0x2
// Checksum 0x22b9b7f4, Offset: 0x80
// Size: 0x24
function autoexec __init__() {
    function_6e338a1c();
    level.var_21f73755 = 1;
}

// Namespace namespace_7613a4d0/namespace_7613a4d0
// Params 0, eflags: 0x1 linked
// Checksum 0x769d5acd, Offset: 0xb0
// Size: 0xbb4
function function_6e338a1c() {
    str_gametype = getdvarstring(#"g_gametype");
    var_a12b4736 = &item_world_fixup::function_96ff7b88;
    var_d2223309 = &item_world_fixup::function_261ab7f5;
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    if (str_gametype == "zclassic") {
    }
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_74efc2f0523a1b43", #"acog_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_1bdc6102e1922ee1", #"barrel2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_3d79e8fa4d04bbe9", #"barrel_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_63a257f430cb24e4", #"compensator2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_7e68f63f8995b1e6", #"compensator_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_66f7a79dbd87eec0", #"dualoptic_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_409656a5454ca9a1", #"elo2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_139fe0e3be289c29", #"elo_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_1d1e0f96c57550a2", #"elo3_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_43a7c00ebad019fc", #"extclip2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_2551991b0ce4278e", #"extclip_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_2a74aa6c21425de8", #"fastreload2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_13e7b5e35b27fda2", #"fastreload_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_1e87409dae378d95", #"grip2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_780b6e02fd11b515", #"grip_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_5e8e59ff7a020c33", #"handle2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_72c4fa7a2b91b0b3", #"handle_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_7a28e0acec4d71b2", #"heavy2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_355338f948fa31c", #"heavy_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_6edd00dc752c24e1", #"holo_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_13101dfb0ca2d5fe", #"ir_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_a89044fba7b2c27", #"light2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_4e931ec838beed9f", #"light_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_2beafef30af1e8c5", #"mixbarrel2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_693720c039d99805", #"mixbarrel_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_63dd998473d02f01", #"mixbody2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_6d0a8b21a8b8b789", #"mixbody_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_7ec532c309e0eef7", #"mixclip2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_8337602f5a165af", #"mixclip_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_4bfc4ce4d3e99f07", #"mixhandle2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_13623c18b49d567f", #"mixhandle_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_6cc986f0af4b142a", #"mixmuzzle2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_438ee0a9ed0f3b64", #"mixmuzzle_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_6db3b0a25b06fbb9", #"mixstock2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_311a6366c098f011", #"mixstock_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_26a11c1d57bbb4d1", #"mixunder2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_64d48522d34c4f99", #"mixunder_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_776efcf8d78c80", #"quickdraw2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_2b8002d0d1dd882a", #"quickdraw_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_2ff1e718a658a883", #"reddot_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_60df57f4f5a14577", #"reflex2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_53ac88663aebc40", #"reflex3_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_7935909de8935589", #"reflex4_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_28efceaacc63752f", #"reflex_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_6e6118f39468cb2c", #"scope3x_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_af064392d860f1f", #"scope4x_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_10ade3abf18cb742", #"smoothzoom2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_4bc121b59bfe4a2c", #"smoothzoom_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_3c63a8769b611006", #"speedgrip2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_114f1df6ad46f598", #"speedgrip_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_fddd3e0764a6167", #"sprintout2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_21f2c71ee52d3d5f", #"sprintout_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_767e2b6d5150883b", #"stalker2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_12aaf0a984a5418b", #"stalker_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_100ffabc91f834d2", #"steadyaim2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_1d25af262e371b3c", #"steadyaim_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_7823002429b5d54f", #"suppressed2_t9_item_sr");
    namespace_1c7b37c6::item_replacer(var_d2223309, var_74257310, #"hash_bec81919557da77", #"suppressed_t9_item_sr");
}

