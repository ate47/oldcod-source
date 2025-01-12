#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace item_world_util;

// Namespace item_world_util/item_world_util
// Params 0, eflags: 0x2
// Checksum 0x1393753d, Offset: 0xa0
// Size: 0x174
function autoexec __init__() {
    level.var_d8caca76 = function_a3975ce9();
    level.var_3f501cff = function_a04d222e();
    level.var_d051f0fe = function_d634ed59();
    level.var_8ee4985f = 17 + 1 + 8 + 1 + 8 + 1;
    level.var_c4160ac0 = level.var_d8caca76 - 2;
    assert(level.var_c4160ac0 + 1 == 32767);
    level.var_c1fb34bd = level.var_c4160ac0;
    level.var_b52c46a6 = level.var_c1fb34bd - level.var_8ee4985f;
    level.var_7d942c18 = level.var_b52c46a6 - 1;
    level.var_afaaa0ee = level.var_3f501cff;
    assert(level.var_7d942c18 - level.var_afaaa0ee > 1024);
    level.var_b7364e19 = level.var_afaaa0ee - 1;
    level.var_6e47811c = 0;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0x339ff97, Offset: 0x220
// Size: 0x37c
function function_3531b9ba(scorestreak) {
    if (!isdefined(level.var_1953a530)) {
        level.var_1953a530 = [];
        level.var_1953a530[#"inventory_ac130"] = #"hash_59372818d5a4b00";
        level.var_1953a530[#"inventory_chopper_gunner"] = #"hash_6fa05dcae5ac1c4b";
        level.var_1953a530[#"inventory_counteruav"] = #"hash_6eb09ea5da35e18f";
        level.var_1953a530[#"inventory_helicopter_comlink"] = #"hash_11b95062385cd071";
        level.var_1953a530[#"inventory_helicopter_guard"] = #"hash_52ee32e14c642494";
        level.var_1953a530[#"inventory_hero_annihilator"] = #"hash_48c54ff5d128d347";
        level.var_1953a530[#"inventory_hero_flamethrower"] = #"hash_5987d17c5829e656";
        level.var_1953a530[#"inventory_hero_pineapplegun"] = #"hash_78406ffa639f4bf";
        level.var_1953a530[#"inventory_hoverjet"] = #"hash_24f5473ce475912e";
        level.var_1953a530[#"hash_49d514608adc6a24"] = #"hash_569b6056354984ee";
        level.var_1953a530[#"inventory_napalm_strike"] = #"hash_bedd703cad46c40";
        level.var_1953a530[#"inventory_planemortar"] = #"hash_6a7de03254c6a4d5";
        level.var_1953a530[#"inventory_recon_car"] = #"hash_4980f99d633760cf";
        level.var_1953a530[#"inventory_recon_plane"] = #"hash_348085cf61f674ad";
        level.var_1953a530[#"inventory_remote_missile"] = #"hash_6739b1e55d16500";
        level.var_1953a530[#"inventory_sig_bow_flame"] = #"hash_257e121804c12624";
        level.var_1953a530[#"inventory_sig_lmg"] = #"hash_3cef4b4ca5fd8984";
        level.var_1953a530[#"inventory_straferun"] = #"hash_2640bc24c6eb39bd";
        level.var_1953a530[#"inventory_supply_drop"] = #"hash_e22ed3950927a02";
        level.var_1953a530[#"inventory_uav"] = #"hash_654445f6cc7a7e1c";
        level.var_1953a530[#"inventory_ultimate_turret"] = #"hash_5f50a43f7034eefa";
    }
    return level.var_1953a530[scorestreak];
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0x152e1a, Offset: 0x5a8
// Size: 0x13e4
function function_6a0ee21a(attachmentname) {
    if (!isdefined(level.var_4d26e905)) {
        if (sessionmodeiszombiesgame()) {
            level.var_4d26e905 = [];
            level.var_4d26e905[#"acog"] = #"acog_t9_item_sr";
            level.var_4d26e905[#"break"] = #"hash_52158dff02a348c";
            level.var_4d26e905[#"break2"] = #"hash_628946b7b73932f2";
            level.var_4d26e905[#"barrel"] = #"barrel_t9_item_sr";
            level.var_4d26e905[#"barrel2"] = #"barrel2_t9_item_sr";
            level.var_4d26e905[#"compensator"] = #"compensator_t9_item_sr";
            level.var_4d26e905[#"compensator2"] = #"compensator2_t9_item_sr";
            level.var_4d26e905[#"extclip"] = #"extclip_t9_item_sr";
            level.var_4d26e905[#"extclip2"] = #"extclip2_t9_item_sr";
            level.var_4d26e905[#"fastreload"] = #"fastreload_t9_item_sr";
            level.var_4d26e905[#"fastreload2"] = #"fastreload2_t9_item_sr";
            level.var_4d26e905[#"grip"] = #"grip_t9_item_sr";
            level.var_4d26e905[#"grip2"] = #"grip2_t9_item_sr";
            level.var_4d26e905[#"handle"] = #"handle_t9_item_sr";
            level.var_4d26e905[#"handle2"] = #"handle2_t9_item_sr";
            level.var_4d26e905[#"heavy"] = #"heavy_t9_item_sr";
            level.var_4d26e905[#"heavy2"] = #"heavy2_t9_item_sr";
            level.var_4d26e905[#"light"] = #"light_t9_item_sr";
            level.var_4d26e905[#"light2"] = #"light2_t9_item_sr";
            level.var_4d26e905[#"mixclip"] = #"mixclip_t9_item_sr";
            level.var_4d26e905[#"mixclip2"] = #"mixclip2_t9_item_sr";
            level.var_4d26e905[#"mixbarrel"] = #"mixbarrel_t9_item_sr";
            level.var_4d26e905[#"mixbarrel2"] = #"mixbarrel2_t9_item_sr";
            level.var_4d26e905[#"mixbody"] = #"mixbody_t9_item_sr";
            level.var_4d26e905[#"mixbody2"] = #"mixbody2_t9_item_sr";
            level.var_4d26e905[#"mixhandle"] = #"mixhandle_t9_item_sr";
            level.var_4d26e905[#"mixhandle2"] = #"mixhandle2_t9_item_sr";
            level.var_4d26e905[#"mixmuzzle"] = #"mixmuzzle_t9_item_sr";
            level.var_4d26e905[#"mixmuzzle2"] = #"mixmuzzle2_t9_item_sr";
            level.var_4d26e905[#"mixstock"] = #"mixstock_t9_item_sr";
            level.var_4d26e905[#"mixstock2"] = #"mixstock2_t9_item_sr";
            level.var_4d26e905[#"mixunder"] = #"mixunder_t9_item_sr";
            level.var_4d26e905[#"mixunder2"] = #"mixunder2_t9_item_sr";
            level.var_4d26e905[#"quickdraw"] = #"quickdraw_t9_item_sr";
            level.var_4d26e905[#"quickdraw2"] = #"quickdraw2_t9_item_sr";
            level.var_4d26e905[#"reddot"] = #"reddot_t9_item_sr";
            level.var_4d26e905[#"reflex"] = #"reflex_t9_item_sr";
            level.var_4d26e905[#"reflex2"] = #"reflex2_t9_item_sr";
            level.var_4d26e905[#"reflex3"] = #"reflex3_t9_item_sr";
            level.var_4d26e905[#"reflex4"] = #"reflex4_t9_item_sr";
            level.var_4d26e905[#"dualoptic"] = #"dualoptic_t9_item_sr";
            level.var_4d26e905[#"holo"] = #"holo_t9_item_sr";
            level.var_4d26e905[#"ir"] = #"ir_t9_item_sr";
            level.var_4d26e905[#"elo"] = #"elo_t9_item_sr";
            level.var_4d26e905[#"elo2"] = #"elo2_t9_item_sr";
            level.var_4d26e905[#"elo3"] = #"elo3_t9_item_sr";
            level.var_4d26e905[#"scope3x"] = #"scope3x_t9_item_sr";
            level.var_4d26e905[#"scope4x"] = #"scope4x_t9_item_sr";
            level.var_4d26e905[#"smoothzoom"] = #"smoothzoom_t9_item_sr";
            level.var_4d26e905[#"smoothzoom2"] = #"smoothzoom2_t9_item_sr";
            level.var_4d26e905[#"speedgrip"] = #"speedgrip_t9_item_sr";
            level.var_4d26e905[#"speedgrip2"] = #"speedgrip2_t9_item_sr";
            level.var_4d26e905[#"sprintout"] = #"sprintout_t9_item_sr";
            level.var_4d26e905[#"sprintout2"] = #"sprintout2_t9_item_sr";
            level.var_4d26e905[#"stalker"] = #"stalker_t9_item_sr";
            level.var_4d26e905[#"stalker2"] = #"stalker2_t9_item_sr";
            level.var_4d26e905[#"steadyaim"] = #"steadyaim_t9_item_sr";
            level.var_4d26e905[#"steadyaim2"] = #"steadyaim2_t9_item_sr";
            level.var_4d26e905[#"suppressed"] = #"suppressed_t9_item_sr";
            level.var_4d26e905[#"suppressed2"] = #"suppressed2_t9_item_sr";
            level.var_4d26e905[#"swayreduc"] = #"hash_57d83338a5296980";
            level.var_4d26e905[#"hash_cfd82035c8077ea"] = #"hash_66b9864ca183b4ae";
        } else {
            level.var_4d26e905 = [];
            level.var_4d26e905[#"acog"] = #"hash_74efc2f0523a1b43";
            level.var_4d26e905[#"break"] = #"hash_62fe2eebac0f72a4";
            level.var_4d26e905[#"break2"] = #"hash_2cdf0a02b981e7ea";
            level.var_4d26e905[#"barrel"] = #"hash_3d79e8fa4d04bbe9";
            level.var_4d26e905[#"barrel2"] = #"hash_1bdc6102e1922ee1";
            level.var_4d26e905[#"compensator"] = #"hash_7e68f63f8995b1e6";
            level.var_4d26e905[#"compensator2"] = #"hash_63a257f430cb24e4";
            level.var_4d26e905[#"extclip"] = #"hash_2551991b0ce4278e";
            level.var_4d26e905[#"extclip2"] = #"hash_43a7c00ebad019fc";
            level.var_4d26e905[#"fastreload"] = #"hash_13e7b5e35b27fda2";
            level.var_4d26e905[#"fastreload2"] = #"hash_2a74aa6c21425de8";
            level.var_4d26e905[#"grip"] = #"hash_780b6e02fd11b515";
            level.var_4d26e905[#"grip2"] = #"hash_1e87409dae378d95";
            level.var_4d26e905[#"handle"] = #"hash_72c4fa7a2b91b0b3";
            level.var_4d26e905[#"handle2"] = #"hash_5e8e59ff7a020c33";
            level.var_4d26e905[#"heavy"] = #"hash_355338f948fa31c";
            level.var_4d26e905[#"heavy2"] = #"hash_7a28e0acec4d71b2";
            level.var_4d26e905[#"light"] = #"hash_4e931ec838beed9f";
            level.var_4d26e905[#"light2"] = #"hash_a89044fba7b2c27";
            level.var_4d26e905[#"mixclip"] = #"hash_8337602f5a165af";
            level.var_4d26e905[#"mixclip2"] = #"hash_7ec532c309e0eef7";
            level.var_4d26e905[#"mixbarrel"] = #"hash_693720c039d99805";
            level.var_4d26e905[#"mixbarrel2"] = #"hash_2beafef30af1e8c5";
            level.var_4d26e905[#"mixbody"] = #"hash_6d0a8b21a8b8b789";
            level.var_4d26e905[#"mixbody2"] = #"hash_63dd998473d02f01";
            level.var_4d26e905[#"mixhandle"] = #"hash_13623c18b49d567f";
            level.var_4d26e905[#"mixhandle2"] = #"hash_4bfc4ce4d3e99f07";
            level.var_4d26e905[#"mixmuzzle"] = #"hash_438ee0a9ed0f3b64";
            level.var_4d26e905[#"mixmuzzle2"] = #"hash_6cc986f0af4b142a";
            level.var_4d26e905[#"mixstock"] = #"hash_311a6366c098f011";
            level.var_4d26e905[#"mixstock2"] = #"hash_6db3b0a25b06fbb9";
            level.var_4d26e905[#"mixunder"] = #"hash_64d48522d34c4f99";
            level.var_4d26e905[#"mixunder2"] = #"hash_26a11c1d57bbb4d1";
            level.var_4d26e905[#"quickdraw"] = #"hash_2b8002d0d1dd882a";
            level.var_4d26e905[#"quickdraw2"] = #"hash_776efcf8d78c80";
            level.var_4d26e905[#"reddot"] = #"hash_2ff1e718a658a883";
            level.var_4d26e905[#"reflex"] = #"hash_28efceaacc63752f";
            level.var_4d26e905[#"reflex2"] = #"hash_60df57f4f5a14577";
            level.var_4d26e905[#"reflex3"] = #"hash_53ac88663aebc40";
            level.var_4d26e905[#"reflex4"] = #"hash_7935909de8935589";
            level.var_4d26e905[#"dualoptic"] = #"hash_66f7a79dbd87eec0";
            level.var_4d26e905[#"holo"] = #"hash_6edd00dc752c24e1";
            level.var_4d26e905[#"ir"] = #"hash_13101dfb0ca2d5fe";
            level.var_4d26e905[#"elo"] = #"hash_139fe0e3be289c29";
            level.var_4d26e905[#"elo2"] = #"hash_409656a5454ca9a1";
            level.var_4d26e905[#"elo3"] = #"hash_1d1e0f96c57550a2";
            level.var_4d26e905[#"scope3x"] = #"hash_6e6118f39468cb2c";
            level.var_4d26e905[#"scope4x"] = #"hash_af064392d860f1f";
            level.var_4d26e905[#"smoothzoom"] = #"hash_4bc121b59bfe4a2c";
            level.var_4d26e905[#"smoothzoom2"] = #"hash_10ade3abf18cb742";
            level.var_4d26e905[#"speedgrip"] = #"hash_114f1df6ad46f598";
            level.var_4d26e905[#"speedgrip2"] = #"hash_3c63a8769b611006";
            level.var_4d26e905[#"sprintout"] = #"hash_21f2c71ee52d3d5f";
            level.var_4d26e905[#"sprintout2"] = #"hash_fddd3e0764a6167";
            level.var_4d26e905[#"stalker"] = #"hash_12aaf0a984a5418b";
            level.var_4d26e905[#"stalker2"] = #"hash_767e2b6d5150883b";
            level.var_4d26e905[#"steadyaim"] = #"hash_1d25af262e371b3c";
            level.var_4d26e905[#"steadyaim2"] = #"hash_100ffabc91f834d2";
            level.var_4d26e905[#"suppressed"] = #"hash_bec81919557da77";
            level.var_4d26e905[#"suppressed2"] = #"hash_7823002429b5d54f";
            level.var_4d26e905[#"swayreduc"] = #"hash_6cd8671e4bd51c28";
            level.var_4d26e905[#"hash_cfd82035c8077ea"] = #"hash_59f84dd254fda616";
        }
    }
    assert(isdefined(level.var_4d26e905[attachmentname]));
    return level.var_4d26e905[attachmentname];
}

// Namespace item_world_util/item_world_util
// Params 0, eflags: 0x1 linked
// Checksum 0x71a41f2, Offset: 0x1998
// Size: 0xb2
function use_item_spawns() {
    gametype = util::get_game_type();
    mapname = util::get_map_name();
    if (!isdefined(gametype) || gametype == "frontend") {
        return 0;
    }
    if (isdefined(mapname) && mapname == "core_frontend") {
        return 0;
    }
    return is_true(getgametypesetting(#"useitemspawns"));
}

// Namespace item_world_util/item_world_util
// Params 2, eflags: 0x1 linked
// Checksum 0xc0769d11, Offset: 0x1a58
// Size: 0x21e
function function_2eb2c17c(origin, item) {
    traceoffset = (0, 0, 4);
    var_5d97fed1 = function_83c20f83(item);
    offsetposition = item.origin + traceoffset;
    var_b0fbfe59 = bullettrace(origin, offsetposition, 0, self, 0);
    if (var_b0fbfe59[#"fraction"] < 1 && var_b0fbfe59[#"entity"] !== item) {
        if (var_5d97fed1) {
            var_acdfe076 = isdefined(var_b0fbfe59[#"dynent"]) && distance2dsquared(var_b0fbfe59[#"dynent"].origin, item.origin) <= function_a3f6cdac(12);
            var_45127074 = isdefined(var_b0fbfe59[#"entity"]) && distance2dsquared(var_b0fbfe59[#"entity"].origin, item.origin) <= function_a3f6cdac(12);
            if (!var_acdfe076 && !var_45127074) {
                return false;
            }
        } else {
            var_5408bd2a = physicstraceex(origin, offsetposition, (0, 0, 0), (0, 0, 0), self, 1);
            if (var_5408bd2a[#"fraction"] >= 1) {
                return true;
            }
            return false;
        }
    }
    return true;
}

// Namespace item_world_util/item_world_util
// Params 7, eflags: 0x1 linked
// Checksum 0xdbe2e1c7, Offset: 0x1c80
// Size: 0x7b6
function function_6061a15(var_f4b807cb, maxdist, origin, angles, forward, var_4bd72bfe = 0, var_82043550 = 0) {
    var_9b882d22 = undefined;
    bestdot = -1;
    var_1530699e = undefined;
    var_7cd624f6 = 2147483647;
    var_431e5926 = undefined;
    var_548943d3 = 2147483647;
    var_95d4627b = 0;
    var_490fd61a = undefined;
    var_6b7d827a = 2147483647;
    var_404fbede = 0;
    var_ba6bb2bd = undefined;
    var_9fd8216d = -1;
    var_75f6d739 = anglestoforward((0, angles[1], 0));
    var_66347f1f = function_a3f6cdac(115);
    var_6b35a0b8 = function_a3f6cdac(24);
    for (itemindex = 0; itemindex < var_f4b807cb.size; itemindex++) {
        itemdef = var_f4b807cb[itemindex];
        if (var_82043550) {
        }
        if (!isdefined(itemdef)) {
            continue;
        }
        if (is_true(itemdef.var_a6762160.var_b362e309) && !is_true(itemdef.var_a6762160.var_a6616b9c)) {
            continue;
        }
        toitem = itemdef.origin - origin;
        var_abd887b5 = distance2dsquared(itemdef.origin, origin);
        if (var_abd887b5 < var_66347f1f && abs(itemdef.origin[2] - origin[2]) < 72) {
            dot = vectordot(forward, vectornormalize(toitem));
            if (dot >= 0.965 && var_abd887b5 < var_66347f1f && dot > var_9fd8216d) {
                if (!self can_pick_up(itemdef) || !function_2eb2c17c(origin, itemdef)) {
                    continue;
                }
                var_ba6bb2bd = itemdef;
                var_9fd8216d = dot;
            }
            if (isdefined(var_ba6bb2bd) && var_abd887b5 >= var_66347f1f) {
                break;
            }
            var_1777205e = vectordot(var_75f6d739, vectornormalize((toitem[0], toitem[1], 0)));
            var_c5722fe1 = 0;
            if (var_4bd72bfe) {
                var_c5722fe1 = itemdef.var_a6762160.itemtype == #"weapon";
            }
            if (var_1777205e >= 0.965 && (var_abd887b5 < var_6b7d827a || !var_c5722fe1 && var_404fbede) && var_abd887b5 > var_6b35a0b8) {
                if (isdefined(var_490fd61a) && var_c5722fe1 && !var_404fbede) {
                    continue;
                }
                if (!self can_pick_up(itemdef) || !function_2eb2c17c(origin, itemdef)) {
                    continue;
                }
                var_490fd61a = itemdef;
                var_6b7d827a = var_abd887b5;
                var_404fbede = var_c5722fe1;
            }
            if (isdefined(var_490fd61a) && !var_404fbede) {
                break;
            }
            var_19b17831 = var_95d4627b || var_404fbede;
            if (var_1777205e >= 0.866 && var_1777205e < 0.965 && (var_abd887b5 < var_548943d3 || !var_c5722fe1 && var_19b17831) && var_abd887b5 > var_6b35a0b8) {
                if ((isdefined(var_490fd61a) || isdefined(var_431e5926)) && var_c5722fe1 && !var_19b17831) {
                    continue;
                }
                if (!self can_pick_up(itemdef) || !function_2eb2c17c(origin, itemdef)) {
                    continue;
                }
                var_431e5926 = itemdef;
                var_548943d3 = var_abd887b5;
                var_95d4627b = var_c5722fe1;
            }
            continue;
        }
        var_7ef7c839 = isdefined(var_ba6bb2bd) || isdefined(var_490fd61a) || isdefined(var_431e5926) || isdefined(var_1530699e);
        if (var_7ef7c839) {
            break;
        }
        var_1777205e = vectordot(var_75f6d739, vectornormalize((toitem[0], toitem[1], 0)));
        if (var_1777205e >= 0.866 && var_abd887b5 < var_7cd624f6) {
            if (!self can_pick_up(itemdef) || !function_2eb2c17c(origin, itemdef)) {
                continue;
            }
            var_1530699e = itemdef;
            var_7cd624f6 = var_abd887b5;
        }
    }
    if (isdefined(var_ba6bb2bd)) {
        var_9b882d22 = var_ba6bb2bd;
    } else if (isdefined(var_490fd61a) && (!isdefined(var_431e5926) || !var_404fbede)) {
        var_9b882d22 = var_490fd61a;
    } else if (isdefined(var_431e5926)) {
        var_9b882d22 = var_431e5926;
    } else if (isdefined(var_1530699e)) {
        var_9b882d22 = var_1530699e;
    }
    if (isdefined(var_9b882d22)) {
        neardist = util::function_4c1656d5();
        var_9b882d22.isfar = neardist < maxdist && distance2dsquared(origin, var_9b882d22.origin) > function_a3f6cdac(neardist);
        var_9b882d22.isclose = distance2dsquared(origin, var_9b882d22.origin) < function_a3f6cdac(128 - 12);
        var_9b882d22.var_5d97fed1 = function_83c20f83(var_9b882d22);
    }
    return var_9b882d22;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0x32c358d8, Offset: 0x2440
// Size: 0xe2
function function_45efe0ab(var_a6762160) {
    var_caafaa25 = #"";
    if (isdefined(var_a6762160.weapon) && var_a6762160.weapon != level.weaponnone) {
        if (var_a6762160.itemtype != #"ammo") {
            var_caafaa25 = var_a6762160.weapon.displayname;
        } else {
            var_caafaa25 = isdefined(var_a6762160.hintstring) ? var_a6762160.hintstring : #"";
        }
    } else {
        var_caafaa25 = isdefined(var_a6762160.hintstring) ? var_a6762160.hintstring : #"";
    }
    return var_caafaa25;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0x95c25bdf, Offset: 0x2530
// Size: 0xb0
function function_808be9a3(networkid) {
    assert(networkid >= level.var_b52c46a6 && networkid <= level.var_c1fb34bd);
    slotid = networkid - level.var_b52c46a6;
    assert(slotid >= 0 && slotid < 17 + 1 + 8 + 1 + 8 + 1);
    return slotid;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0x1c289040, Offset: 0x25e8
// Size: 0x36
function function_c094ccd3(networkid) {
    if (function_da09de95(networkid)) {
        return (networkid - level.var_afaaa0ee);
    }
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0xd6599f85, Offset: 0x2628
// Size: 0x130
function function_1f0def85(item) {
    assert(isdefined(item));
    if (!isdefined(item)) {
        return 32767;
    }
    if (isstruct(item)) {
        assert(isdefined(item.id));
        assert(item.id >= level.var_6e47811c && item.id <= level.var_b7364e19);
        return item.id;
    }
    entnum = item getentitynumber();
    networkid = entnum + level.var_afaaa0ee;
    assert(networkid >= level.var_afaaa0ee && networkid <= level.var_7d942c18);
    return networkid;
}

// Namespace item_world_util/item_world_util
// Params 2, eflags: 0x1 linked
// Checksum 0x8e4ae2aa, Offset: 0x2760
// Size: 0x110
function function_970b8d86(slotid, var_259f58f3 = undefined) {
    if (isdefined(var_259f58f3)) {
        assert(var_259f58f3 <= 8);
        slotid += var_259f58f3;
    }
    assert(slotid >= 0 && slotid < 17 + 1 + 8 + 1 + 8 + 1);
    var_f5e3c230 = slotid;
    networkid = var_f5e3c230 + level.var_b52c46a6;
    assert(networkid >= level.var_b52c46a6 && networkid <= level.var_c1fb34bd);
    return networkid;
}

// Namespace item_world_util/item_world_util
// Params 3, eflags: 0x1 linked
// Checksum 0x787c2e95, Offset: 0x2878
// Size: 0x260
function function_6af455de(*localclientnum, origin, angles) {
    forward = anglestoforward(angles);
    vehicles = getentitiesinradius(origin, 1024, 12);
    var_bf3cabc9 = undefined;
    var_e664ecda = undefined;
    var_33b49591 = undefined;
    var_1dd6e163 = undefined;
    foreach (vehicle in vehicles) {
        occupied = 0;
        occupied = vehicle getvehoccupants().size > 0;
        if (occupied) {
            continue;
        }
        tovehicle = vectornormalize(vehicle.origin - origin);
        dot = vectordot(forward, tovehicle);
        var_aba3faed = distance2dsquared(vehicle.origin, origin);
        if (dot >= 0.965 && (!isdefined(var_e664ecda) || var_aba3faed < var_e664ecda)) {
            var_bf3cabc9 = vehicle;
            var_e664ecda = var_aba3faed;
        }
        if (dot >= 0.5 && var_aba3faed <= function_a3f6cdac(128) && (!isdefined(var_1dd6e163) || var_aba3faed < var_1dd6e163)) {
            var_33b49591 = vehicle;
            var_1dd6e163 = var_aba3faed;
        }
    }
    if (isdefined(var_33b49591)) {
        return var_33b49591;
    }
    return var_bf3cabc9;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0xb32e00d9, Offset: 0x2ae0
// Size: 0x196
function function_c62ad9a7(vehicle) {
    hinttext = #"";
    if (isdefined(vehicle) && isdefined(vehicle.scriptvehicletype)) {
        switch (vehicle.scriptvehicletype) {
        case #"player_atv":
            hinttext = #"wz/player_atv";
            break;
        case #"helicopter_light":
            hinttext = #"wz/helicopter";
            break;
        case #"cargo_truck_wz":
            hinttext = #"wz/cargo_truck";
            break;
        case #"tactical_raft_wz":
            hinttext = #"hash_602556b5bd4f952d";
            break;
        case #"player_fav":
            hinttext = #"wz/arav";
            break;
        case #"player_suv":
            hinttext = #"wz/suv";
            break;
        case #"player_muscle":
            hinttext = #"wz/muscle_car";
            break;
        case #"pbr_boat_wz":
            hinttext = #"wz/pbr";
            break;
        }
    }
    return hinttext;
}

// Namespace item_world_util/item_world_util
// Params 2, eflags: 0x1 linked
// Checksum 0x5461bfd5, Offset: 0x2c80
// Size: 0x190
function can_pick_up(item, servertime = undefined) {
    if (!isdefined(item) || !isdefined(item.var_a6762160)) {
        return false;
    }
    if (isdefined(servertime)) {
        if (item.hidetime > 0 && item.hidetime <= servertime) {
            return false;
        }
    } else if (item.hidetime > 0 && !function_83c20f83(item)) {
        return false;
    }
    if (!isstruct(item) && item getitemindex() == 32767) {
        return false;
    }
    if (isentity(item)) {
        entitytype = item getentitytype();
        if (entitytype == 6 || entitytype == 4 || entitytype == 12 || entitytype == 1) {
            if (isdefined(level.var_578f7c6d) && item clientfield::get("isJammed")) {
                return false;
            }
        }
    }
    return true;
}

// Namespace item_world_util/item_world_util
// Params 4, eflags: 0x0
// Checksum 0xedf9c5e0, Offset: 0x2e18
// Size: 0x2b0
function function_4cbb6617(inventory, itemtype, var_da328e7b, var_bcc2655a) {
    assert(ishash(itemtype));
    assert(isarray(var_da328e7b));
    if (!isdefined(var_bcc2655a)) {
        return;
    }
    items = [];
    var_c7837092 = get_itemtype(var_bcc2655a);
    foreach (item in inventory.items) {
        if (!isdefined(item)) {
            continue;
        }
        if (item.id == 32767) {
            continue;
        }
        if (!isdefined(item.var_a6762160)) {
            continue;
        }
        var_b74300d3 = get_itemtype(item.var_a6762160);
        if (item.var_a6762160.itemtype == itemtype) {
            if (isdefined(items[var_b74300d3])) {
                if (item.count > items[var_b74300d3].count) {
                    items[var_b74300d3] = item;
                }
                continue;
            }
            items[var_b74300d3] = item;
        }
    }
    listitems = [];
    for (currentindex = 0; currentindex < var_da328e7b.size; currentindex++) {
        if (var_da328e7b[currentindex] == var_c7837092) {
            break;
        }
    }
    for (index = currentindex + 1; index < var_da328e7b.size; index++) {
        var_b74300d3 = var_da328e7b[index];
        if (isdefined(items[var_b74300d3])) {
            listitems[listitems.size] = items[var_b74300d3];
        }
    }
    if (currentindex < var_da328e7b.size) {
        for (index = 0; index < currentindex; index++) {
            var_b74300d3 = var_da328e7b[index];
            if (isdefined(items[var_b74300d3])) {
                listitems[listitems.size] = items[var_b74300d3];
            }
        }
    }
    return listitems;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0x7092d259, Offset: 0x30d0
// Size: 0x6a
function function_49ce7663(itemname) {
    if (isdefined(level.var_4afb8f5a[itemname]) && level.var_4afb8f5a[itemname] != #"") {
        itemname = level.var_4afb8f5a[itemname];
    }
    return function_4ba8fde(itemname);
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0xcabccad7, Offset: 0x3148
// Size: 0x32
function function_f73bc33(item) {
    return isdefined(item.networkid) ? item.networkid : item.id;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0xea3442f5, Offset: 0x3188
// Size: 0x46
function get_itemtype(var_a6762160) {
    return isdefined(var_a6762160.var_456aa154) ? getscriptbundle(var_a6762160.var_456aa154).name : var_a6762160.name;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0x778160e1, Offset: 0x31d8
// Size: 0xe4
function function_31f5aa51(item) {
    if (!isdefined(item) || !isdefined(item.targetname) && !isdefined(item.targetnamehash)) {
        return;
    }
    targetname = isdefined(item.targetname) ? item.targetname : item.targetnamehash;
    stashes = level.var_93d08989[targetname];
    if (!isdefined(stashes) || stashes.size <= 0) {
        return;
    }
    stashes = arraysortclosest(stashes, item.origin, 1, 0, 12);
    if (stashes.size <= 0) {
        return;
    }
    return stashes[0];
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0xada06259, Offset: 0x32c8
// Size: 0x32
function function_da09de95(id) {
    return id >= level.var_afaaa0ee && id <= level.var_7d942c18;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0x2000adc2, Offset: 0x3308
// Size: 0x60
function function_7363384a(name) {
    bundle = getscriptbundle(name);
    if (!isdefined(bundle)) {
        return false;
    }
    if (bundle.type != #"itemspawnentry") {
        return false;
    }
    return true;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0xeda74e4c, Offset: 0x3370
// Size: 0x32
function function_db35e94f(id) {
    return id >= level.var_b52c46a6 && id <= level.var_c1fb34bd;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0x85c55769, Offset: 0x33b0
// Size: 0x66
function function_41f06d9d(var_a6762160) {
    if (!isdefined(var_a6762160) || !isdefined(var_a6762160.name)) {
        return false;
    }
    return var_a6762160.name == #"resource_item_paint" || var_a6762160.name == #"resource_item_paint_stack_10";
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0xac5df406, Offset: 0x3420
// Size: 0xec
function function_a57773a4(var_a6762160) {
    if (!isdefined(var_a6762160) || !isdefined(var_a6762160.itemtype)) {
        return false;
    }
    foreach (itemtype in array(#"perk_tier_1", #"perk_tier_2", #"perk_tier_3")) {
        if (var_a6762160.itemtype == itemtype) {
            return true;
        }
    }
    return false;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0x5a63c119, Offset: 0x3518
// Size: 0x22
function function_74e1e547(point) {
    return function_3238d10d(point);
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0xbe78afb4, Offset: 0x3548
// Size: 0x40
function function_83c20f83(item) {
    assert(isdefined(item));
    if (!isdefined(item)) {
        return false;
    }
    return item.hidetime === -1;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0x907fcb0f, Offset: 0x3590
// Size: 0x32
function function_2c7fc531(id) {
    return id >= level.var_6e47811c && id <= level.var_b7364e19;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0x77f4a863, Offset: 0x35d0
// Size: 0x2c
function function_d9648161(id) {
    return id >= level.var_6e47811c && id <= 32767;
}

// Namespace item_world_util/item_world_util
// Params 2, eflags: 0x1 linked
// Checksum 0x98eed117, Offset: 0x3608
// Size: 0x2de
function function_35e06774(var_a6762160, var_48cfb6ca = 0) {
    if (isdefined(var_a6762160) && isdefined(var_a6762160.weapon) && (isarray(var_a6762160.attachments) || var_48cfb6ca)) {
        attachments = [];
        if (isarray(var_a6762160.attachments)) {
            foreach (attachment in var_a6762160.attachments) {
                attachments[attachments.size] = attachment.var_6be1bec7;
            }
            if (var_48cfb6ca) {
                foreach (attachment in var_a6762160.attachments) {
                    var_fe35755b = getscriptbundle(attachment.var_6be1bec7);
                    if (!isdefined(var_fe35755b) || var_fe35755b.type != #"itemspawnentry" || !isarray(var_fe35755b.attachments)) {
                        continue;
                    }
                    foreach (var_a4559ed2 in var_fe35755b.attachments) {
                        attachments[attachments.size] = var_a4559ed2.var_6be1bec7;
                    }
                }
            }
        }
        weapon = getweapon(var_a6762160.weapon.name, attachments);
        return function_1242e467(weapon);
    } else if (isdefined(var_a6762160)) {
        return var_a6762160.weapon;
    }
    return undefined;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x1 linked
// Checksum 0xfed03de0, Offset: 0x38f0
// Size: 0x86
function function_f4a8d375(itemid) {
    assert(function_2c7fc531(itemid));
    point = function_b1702735(itemid);
    if (isdefined(point)) {
        var_a6762160 = point.var_a6762160;
        return function_35e06774(var_a6762160);
    }
    return undefined;
}

