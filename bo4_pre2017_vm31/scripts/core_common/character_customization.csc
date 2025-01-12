#using scripts/core_common/abilities/gadgets/gadget_camo_render;
#using scripts/core_common/animation_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/end_game_taunts;
#using scripts/core_common/filter_shared;
#using scripts/core_common/multi_extracam;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace character_customization;

// Namespace character_customization/character_customization
// Params 0, eflags: 0x2
// Checksum 0x1beabc6f, Offset: 0x918
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("character_customization", &__init__, undefined, undefined);
}

// Namespace character_customization/character_customization
// Params 0, eflags: 0x0
// Checksum 0x5a131c7f, Offset: 0x958
// Size: 0x200
function __init__() {
    level.var_81c41302 = &function_bc334e1a;
    level.var_c35758c9 = &function_cdc26129;
    level.extra_cam_render_current_hero_headshot_func_callback = &process_current_hero_headshot_extracam_request;
    level.extra_cam_render_head_preview_func_callback = &process_head_preview_extracam_request;
    level.var_63d084fe = &function_c27b6e13;
    level.var_a89ad62b = &function_b345c4d8;
    level.extra_cam_render_character_head_item_func_callback = &process_character_head_item_extracam_request;
    level.extra_cam_render_gender_func_callback = &process_gender_extracam_request;
    level.model_type_bones = associativearray("helmet", "", "head", "");
    if (!isdefined(level.liveccdata)) {
        level.liveccdata = [];
    }
    if (!isdefined(level.custom_characters)) {
        level.custom_characters = [];
    }
    if (!isdefined(level.extra_cam_hero_data)) {
        level.extra_cam_hero_data = [];
    }
    if (!isdefined(level.var_3bd0563c)) {
        level.var_3bd0563c = [];
    }
    if (!isdefined(level.extra_cam_headshot_hero_data)) {
        level.extra_cam_headshot_hero_data = [];
    }
    if (!isdefined(level.extra_cam_head_preview_data)) {
        level.extra_cam_head_preview_data = [];
    }
    if (!isdefined(level.extra_cam_gender_preview_data)) {
        level.extra_cam_gender_preview_data = [];
    }
    level.charactercustomizationsetup = &localclientconnect;
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0xecfcd6f, Offset: 0xb60
// Size: 0xa0
function localclientconnect(localclientnum) {
    level.liveccdata[localclientnum] = setup_live_character_customization_target(localclientnum, "updateHero");
    if (isdefined(level.liveccdata[localclientnum])) {
        function_f61cd9d1(level.liveccdata[localclientnum]);
    }
    level.staticccdata = setup_static_character_customization_target(localclientnum);
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x1b439e73, Offset: 0xc08
// Size: 0x3a0
function function_b79cb078(charactermodel, localclientnum, alt_render_mode) {
    if (!isdefined(alt_render_mode)) {
        alt_render_mode = 1;
    }
    if (!isdefined(charactermodel)) {
        return undefined;
    }
    if (!isdefined(level.custom_characters[localclientnum])) {
        level.custom_characters[localclientnum] = [];
    }
    if (isdefined(level.custom_characters[localclientnum][charactermodel.targetname])) {
        return level.custom_characters[localclientnum][charactermodel.targetname];
    }
    data_struct = spawnstruct();
    level.custom_characters[localclientnum][charactermodel.targetname] = data_struct;
    data_struct.charactermodel = charactermodel;
    data_struct.var_b6087788 = array();
    data_struct.attached_models = array();
    data_struct.var_14726a6d = array();
    data_struct.origin = charactermodel.origin;
    data_struct.angles = charactermodel.angles;
    data_struct.characterindex = 0;
    data_struct.charactermode = 3;
    data_struct.var_2fee1906 = undefined;
    data_struct.bodyindex = 0;
    data_struct.bodycolors = array(0, 0, 0);
    data_struct.var_bf37af0a = 0;
    data_struct.helmetcolors = array(0, 0, 0);
    data_struct.headindex = 0;
    data_struct.align_target = undefined;
    data_struct.var_a5c8c7ea = undefined;
    data_struct.var_b1813a38 = undefined;
    data_struct.var_d3b4ae4f = getcharacterbodyrenderoptions(0, 0, 0, 0, 0);
    data_struct.var_a75d14ae = getcharacterhelmetrenderoptions(0, 0, 0, 0, 0);
    data_struct.var_19072699 = getcharacterheadrenderoptions(0);
    data_struct.var_b841ac58 = getcharactermoderenderoptions(0);
    data_struct.alt_render_mode = alt_render_mode;
    data_struct.var_62e980f = 0;
    data_struct.var_d11acdfe = "weapon";
    data_struct.show_helmets = 1;
    data_struct.var_418b6e8a = 0;
    data_struct.var_28223325 = 0;
    charactermodel sethighdetail(1, data_struct.alt_render_mode);
    return data_struct;
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0xe710ed9f, Offset: 0xfb0
// Size: 0xac
function function_3a4cce98(game_mode) {
    
}

// Namespace character_customization/character_customization
// Params 4, eflags: 0x0
// Checksum 0x46510a4e, Offset: 0x1270
// Size: 0x38a
function function_d79d6d7(localclientnum, data_struct, characterindex, params) {
    assert(isdefined(data_struct));
    data_lcn = isdefined(data_struct.var_2fee1906) ? data_struct.var_2fee1906 : localclientnum;
    if (!isdefined(characterindex)) {
        characterindex = getequippedheroindex(data_lcn, params.sessionmode);
    }
    defaultindex = undefined;
    if (isdefined(params.isdefaulthero) && params.isdefaulthero) {
        defaultindex = 0;
    }
    set_character(data_struct, characterindex);
    charactermode = params.sessionmode;
    set_character_mode(data_struct, charactermode);
    body = function_7d59e996(data_lcn, charactermode, characterindex, params.extracam_data);
    bodycolors = function_a4a750bd(data_lcn, charactermode, characterindex, body, params.extracam_data);
    function_56dceb6(data_struct, charactermode, characterindex, body, bodycolors);
    head = function_ba2060c8(data_lcn, charactermode, params.extracam_data);
    function_5b80fae8(data_struct, charactermode, head);
    helmet = function_f9865c49(data_lcn, charactermode, characterindex, params.extracam_data);
    helmetcolors = function_227c64d8(data_lcn, charactermode, data_struct.characterindex, helmet, params.extracam_data);
    function_5fa9d769(data_struct, charactermode, characterindex, helmet, helmetcolors);
    if (isdefined(data_struct.var_418b6e8a) && data_struct.var_418b6e8a) {
        showcaseweapon = function_e37bf19c(data_lcn, charactermode, characterindex, params.extracam_data);
        function_f374c6fc(data_struct, charactermode, data_lcn, undefined, characterindex, showcaseweapon.weaponname, showcaseweapon.attachmentinfo, showcaseweapon.weaponrenderoptions, 0, 1);
    }
    return update(localclientnum, data_struct, params);
}

// Namespace character_customization/character_customization
// Params 7, eflags: 0x0
// Checksum 0xcdc6b812, Offset: 0x1608
// Size: 0x524
function update_model_attachment(localclientnum, data_struct, attached_model, slot, model_anim, model_intro_anim, force_update) {
    assert(isdefined(data_struct.attached_models));
    assert(isdefined(data_struct.var_b6087788));
    assert(isdefined(level.model_type_bones));
    if (force_update || attached_model !== data_struct.attached_models[slot] || model_anim !== data_struct.var_b6087788[slot]) {
        bone = slot;
        if (isdefined(level.model_type_bones[slot])) {
            bone = level.model_type_bones[slot];
        }
        assert(isdefined(bone));
        if (isdefined(data_struct.attached_models[slot])) {
            if (isdefined(data_struct.var_14726a6d[slot])) {
                data_struct.var_14726a6d[slot] unlink();
                data_struct.var_14726a6d[slot] delete();
                data_struct.var_14726a6d[slot] = undefined;
            } else if (data_struct.charactermodel isattached(data_struct.attached_models[slot], bone)) {
                data_struct.charactermodel detach(data_struct.attached_models[slot], bone);
            }
            data_struct.attached_models[slot] = undefined;
        }
        data_struct.attached_models[slot] = attached_model;
        if (isdefined(data_struct.attached_models[slot])) {
            if (isdefined(model_anim)) {
                ent = spawn(localclientnum, data_struct.charactermodel.origin, "script_model");
                ent sethighdetail(1, data_struct.alt_render_mode);
                data_struct.var_14726a6d[slot] = ent;
                ent setmodel(data_struct.attached_models[slot]);
                if (!ent hasanimtree()) {
                    ent useanimtree(#generic);
                }
                ent.origin = data_struct.charactermodel.origin;
                ent.angles = data_struct.charactermodel.angles;
                ent.var_efd873ed = ent.origin;
                ent.var_81ec66f3 = ent.angles;
                ent thread play_intro_and_animation(model_intro_anim, model_anim, 1);
            } else if (!data_struct.charactermodel isattached(data_struct.attached_models[slot], bone)) {
                data_struct.charactermodel attach(data_struct.attached_models[slot], bone);
            }
            data_struct.var_b6087788[slot] = model_anim;
        }
    }
    if (isdefined(data_struct.var_14726a6d[slot])) {
        data_struct.var_14726a6d[slot] setbodyrenderoptions(data_struct.var_b841ac58, data_struct.var_d3b4ae4f, data_struct.var_a75d14ae, data_struct.var_19072699);
    }
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0xd74d6aa5, Offset: 0x1b38
// Size: 0x28
function set_character(data_struct, characterindex) {
    data_struct.characterindex = characterindex;
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0x89757279, Offset: 0x1b68
// Size: 0x68
function set_character_mode(data_struct, charactermode) {
    assert(isdefined(charactermode));
    data_struct.charactermode = charactermode;
    data_struct.var_b841ac58 = getcharactermoderenderoptions(charactermode);
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0xbfbc627e, Offset: 0x1bd8
// Size: 0x1cc
function function_56dceb6(data_struct, mode, characterindex, bodyindex, bodycolors) {
    assert(isdefined(mode));
    assert(mode != 3);
    if (isdefined(data_struct.var_28223325) && mode == 2 && data_struct.var_28223325) {
        bodyindex = 1;
    }
    data_struct.bodyindex = bodyindex;
    data_struct.bodymodel = getcharacterbodymodel(characterindex, bodyindex, mode);
    if (isdefined(data_struct.bodymodel)) {
        data_struct.charactermodel setmodel(data_struct.bodymodel);
    }
    if (isdefined(bodycolors)) {
        function_b36a5f9d(data_struct, mode, bodycolors);
    }
    render_options = getcharacterbodyrenderoptions(data_struct.characterindex, data_struct.bodyindex, data_struct.bodycolors[0], data_struct.bodycolors[1], data_struct.bodycolors[2]);
    data_struct.var_d3b4ae4f = render_options;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0xbfe7ee31, Offset: 0x1db0
// Size: 0x7e
function function_b36a5f9d(data_struct, mode, bodycolors) {
    for (i = 0; i < bodycolors.size && i < bodycolors.size; i++) {
        function_f87a1792(data_struct, i, bodycolors[i]);
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x828906b6, Offset: 0x1e38
// Size: 0xbc
function function_f87a1792(data_struct, var_6f15f34e, colorindex) {
    data_struct.bodycolors[var_6f15f34e] = colorindex;
    render_options = getcharacterbodyrenderoptions(data_struct.characterindex, data_struct.bodyindex, data_struct.bodycolors[0], data_struct.bodycolors[1], data_struct.bodycolors[2]);
    data_struct.var_d3b4ae4f = render_options;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x5ffa3857, Offset: 0x1f00
// Size: 0x8c
function function_5b80fae8(data_struct, mode, headindex) {
    data_struct.headindex = headindex;
    data_struct.headmodel = getcharacterheadmodel(headindex, mode);
    render_options = getcharacterheadrenderoptions(headindex);
    data_struct.var_19072699 = render_options;
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0x9e115afb, Offset: 0x1f98
// Size: 0x8c
function function_5fa9d769(data_struct, mode, characterindex, var_bf37af0a, helmetcolors) {
    data_struct.var_bf37af0a = var_bf37af0a;
    data_struct.helmetmodel = getcharacterhelmetmodel(characterindex, var_bf37af0a, mode);
    if (isdefined(helmetcolors)) {
        function_f8e56a38(data_struct, helmetcolors);
    }
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0xa35ab899, Offset: 0x2030
// Size: 0x514
function function_5eb98c9a(data_struct) {
    var_59883122 = data_struct.var_8f9c1e31.rootweapon.name;
    var_17092b81 = data_struct.var_8f9c1e31.isdualwield;
    weapon_group = getitemgroupforweaponname(var_59883122);
    if (weapon_group == "weapon_launcher") {
        if (var_59883122 == "launcher_lockonly" || var_59883122 == "launcher_multi") {
            weapon_group = "weapon_launcher_alt";
        }
    } else if (weapon_group == "weapon_pistol" && var_17092b81) {
        weapon_group = "weapon_pistol_dw";
    } else if (weapon_group == "weapon_special") {
        if (var_59883122 == "special_crossbow") {
            weapon_group = "weapon_smg";
        } else if (var_59883122 == "special_crossbow_dw") {
            weapon_group = "weapon_pistol_dw";
        }
    } else if (weapon_group == "weapon_knife") {
        if (var_59883122 == "melee_knuckles") {
            weapon_group = "weapon_knuckles";
        } else if (var_59883122 == "melee_improvise") {
            weapon_group = "weapon_improvise";
        } else if (var_59883122 == "melee_wrench" || var_59883122 == "melee_crowbar" || var_59883122 == "melee_shockbaton") {
            weapon_group = "weapon_wrench";
        } else if (var_59883122 == "melee_nunchuks") {
            weapon_group = "weapon_nunchucks";
        } else if (var_59883122 == "melee_sword" || var_59883122 == "melee_bat" || var_59883122 == "melee_fireaxe" || var_59883122 == "melee_mace") {
            weapon_group = "weapon_sword";
        }
    } else if (weapon_group == "miscweapon") {
        if (var_59883122 == "blackjack_coin") {
            weapon_group = "brawler";
        } else if (var_59883122 == "blackjack_cards") {
            weapon_group = "brawler";
        }
    }
    if (data_struct.charactermode === 0) {
        data_struct.anim_name = "pb_cac_rifle_showcase_cp";
        return;
    }
    if (isdefined(associativearray("weapon_smg", "pb_cac_smg_showcase", "weapon_assault", "pb_cac_rifle_showcase", "weapon_cqb", "pb_cac_rifle_showcase", "weapon_lmg", "pb_cac_rifle_showcase", "weapon_sniper", "pb_cac_sniper_showcase", "weapon_pistol", "pb_cac_pistol_showcase", "weapon_pistol_dw", "pb_cac_pistol_dw_showcase", "weapon_launcher", "pb_cac_launcher_showcase", "weapon_launcher_alt", "pb_cac_launcher_alt_showcase", "weapon_knife", "pb_cac_knife_showcase", "weapon_knuckles", "pb_cac_brass_knuckles_showcase", "weapon_wrench", "pb_cac_wrench_showcase", "weapon_improvise", "pb_cac_improvise_showcase", "weapon_sword", "pb_cac_sword_showcase", "weapon_nunchucks", "pb_cac_nunchucks_showcase", "weapon_mace", "pb_cac_sword_showcase", "brawler", "pb_cac_brawler_showcase")[weapon_group])) {
        data_struct.anim_name = associativearray("weapon_smg", "pb_cac_smg_showcase", "weapon_assault", "pb_cac_rifle_showcase", "weapon_cqb", "pb_cac_rifle_showcase", "weapon_lmg", "pb_cac_rifle_showcase", "weapon_sniper", "pb_cac_sniper_showcase", "weapon_pistol", "pb_cac_pistol_showcase", "weapon_pistol_dw", "pb_cac_pistol_dw_showcase", "weapon_launcher", "pb_cac_launcher_showcase", "weapon_launcher_alt", "pb_cac_launcher_alt_showcase", "weapon_knife", "pb_cac_knife_showcase", "weapon_knuckles", "pb_cac_brass_knuckles_showcase", "weapon_wrench", "pb_cac_wrench_showcase", "weapon_improvise", "pb_cac_improvise_showcase", "weapon_sword", "pb_cac_sword_showcase", "weapon_nunchucks", "pb_cac_nunchucks_showcase", "weapon_mace", "pb_cac_sword_showcase", "brawler", "pb_cac_brawler_showcase")[weapon_group];
    }
}

// Namespace character_customization/character_customization
// Params 10, eflags: 0x0
// Checksum 0x4062f7a3, Offset: 0x2550
// Size: 0x4ac
function function_f374c6fc(data_struct, mode, localclientnum, xuid, characterindex, var_a7a58d47, var_93ecb41d, weaponrenderoptions, var_58d20c34, var_974ed5f5) {
    if (isdefined(xuid)) {
        setshowcaseweaponpaintshopxuid(localclientnum, xuid);
    } else {
        setshowcaseweaponpaintshopxuid(localclientnum);
    }
    data_struct.var_a7a58d47 = var_a7a58d47;
    data_struct.var_8f9c1e31 = getweaponwithattachments(var_a7a58d47);
    if (data_struct.var_8f9c1e31 == getweapon("none")) {
        data_struct.var_8f9c1e31 = getweapon("ar_standard");
        data_struct.var_a7a58d47 = data_struct.var_8f9c1e31.name;
    }
    attachmentnames = [];
    attachmentindices = [];
    tokenizedattachmentinfo = strtok(var_93ecb41d, ",");
    for (index = 0; index + 1 < tokenizedattachmentinfo.size; index += 2) {
        attachmentnames[attachmentnames.size] = tokenizedattachmentinfo[index];
        attachmentindices[attachmentindices.size] = int(tokenizedattachmentinfo[index + 1]);
    }
    for (index = tokenizedattachmentinfo.size; index + 1 < 16; index += 2) {
        attachmentnames[attachmentnames.size] = "none";
        attachmentindices[attachmentindices.size] = 0;
    }
    data_struct.acvi = getattachmentcosmeticvariantindexes(data_struct.var_8f9c1e31, attachmentnames[0], attachmentindices[0], attachmentnames[1], attachmentindices[1], attachmentnames[2], attachmentindices[2], attachmentnames[3], attachmentindices[3], attachmentnames[4], attachmentindices[4], attachmentnames[5], attachmentindices[5], attachmentnames[6], attachmentindices[6], attachmentnames[7], attachmentindices[7]);
    camoindex = 0;
    paintjobslot = 15;
    paintjobindex = 15;
    showpaintshop = 0;
    tokenizedweaponrenderoptions = strtok(weaponrenderoptions, ",");
    if (tokenizedweaponrenderoptions.size > 2) {
        camoindex = int(tokenizedweaponrenderoptions[0]);
        paintjobslot = int(tokenizedweaponrenderoptions[1]);
        paintjobindex = int(tokenizedweaponrenderoptions[2]);
        showpaintshop = paintjobslot != 15 && paintjobindex != 15;
    }
    var_ab7e5449 = 0;
    if (var_58d20c34) {
        var_ab7e5449 = 1;
    } else if (var_974ed5f5) {
        var_ab7e5449 = 2;
    }
    data_struct.weaponrenderoptions = calcweaponoptions(localclientnum, camoindex, 0, 0, 0, 0, showpaintshop, var_ab7e5449);
    function_5eb98c9a(data_struct);
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0x762a0134, Offset: 0x2a08
// Size: 0x104
function function_f8e56a38(data_struct, colors) {
    for (i = 0; i < colors.size && i < data_struct.helmetcolors.size; i++) {
        function_883d8451(data_struct, i, colors[i]);
    }
    render_options = getcharacterhelmetrenderoptions(data_struct.characterindex, data_struct.var_bf37af0a, data_struct.helmetcolors[0], data_struct.helmetcolors[1], data_struct.helmetcolors[2]);
    data_struct.var_a75d14ae = render_options;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x47e14167, Offset: 0x2b18
// Size: 0xbc
function function_883d8451(data_struct, var_6f15f34e, colorindex) {
    data_struct.helmetcolors[var_6f15f34e] = colorindex;
    render_options = getcharacterhelmetrenderoptions(data_struct.characterindex, data_struct.var_bf37af0a, data_struct.helmetcolors[0], data_struct.helmetcolors[1], data_struct.helmetcolors[2]);
    data_struct.var_a75d14ae = render_options;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x709b111e, Offset: 0x2be0
// Size: 0x304
function update(localclientnum, data_struct, params) {
    data_struct.charactermodel setbodyrenderoptions(data_struct.var_b841ac58, data_struct.var_d3b4ae4f, data_struct.var_a75d14ae, data_struct.var_19072699);
    var_88932ad4 = "tag_origin";
    show_helmet = !isdefined(params) || data_struct.show_helmets && !(isdefined(params.hide_helmet) && params.hide_helmet);
    if (show_helmet) {
        var_88932ad4 = data_struct.helmetmodel;
    }
    update_model_attachment(localclientnum, data_struct, var_88932ad4, "helmet", undefined, undefined, 1);
    head_model = data_struct.headmodel;
    if (show_helmet && isdefined(params) && getcharacterhelmethideshead(data_struct.characterindex, data_struct.var_bf37af0a, isdefined(params.sessionmode) ? params.sessionmode : data_struct.charactermode)) {
        assert(var_88932ad4 != "<dev string:x28>");
        head_model = "tag_origin";
    }
    update_model_attachment(localclientnum, data_struct, head_model, "head", undefined, undefined, 1);
    changed = function_873d37c(localclientnum, data_struct, params);
    data_struct.charactermodel.bodymodel = data_struct.bodymodel;
    data_struct.charactermodel.helmetmodel = data_struct.helmetmodel;
    data_struct.charactermodel.var_957cc42 = data_struct.var_b841ac58;
    data_struct.charactermodel.var_6f30937d = data_struct.var_d3b4ae4f;
    data_struct.charactermodel.var_d44a8060 = data_struct.var_a75d14ae;
    data_struct.charactermodel.var_ebda9e17 = data_struct.var_19072699;
    return changed;
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0x1bd77fd3, Offset: 0x2ef0
// Size: 0xe4
function function_ddd0628f(data_struct) {
    if (isdefined(data_struct.charactermodel)) {
        if (!data_struct.charactermodel isstreamed()) {
            return false;
        }
    }
    foreach (ent in data_struct.var_14726a6d) {
        if (isdefined(ent)) {
            if (!ent isstreamed()) {
                return false;
            }
        }
    }
    return true;
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0xc48cb8e9, Offset: 0x2fe0
// Size: 0xf2
function function_f61cd9d1(data_struct) {
    if (isdefined(data_struct.charactermodel)) {
        data_struct.charactermodel sethighdetail(1, data_struct.alt_render_mode);
    }
    foreach (ent in data_struct.var_14726a6d) {
        if (isdefined(ent)) {
            ent sethighdetail(1, data_struct.alt_render_mode);
        }
    }
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0x8a3ca18c, Offset: 0x30e0
// Size: 0x22
function get_character_mode(localclientnum) {
    return getequippedheromode(localclientnum);
}

// Namespace character_customization/character_customization
// Params 4, eflags: 0x0
// Checksum 0x75c6081d, Offset: 0x3110
// Size: 0x14c
function function_7d59e996(localclientnum, charactermode, characterindex, var_66ec6e) {
    assert(isdefined(characterindex));
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return 0;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedbodyindexforhero(localclientnum, charactermode, var_66ec6e.jobindex, 1);
    }
    if (isdefined(var_66ec6e) && isdefined(var_66ec6e.var_59ecf1ca)) {
        return var_66ec6e.var_59ecf1ca;
    }
    if (isdefined(var_66ec6e.defaultimagerender) && isdefined(var_66ec6e) && var_66ec6e.defaultimagerender) {
        return 0;
    }
    return getequippedbodyindexforhero(localclientnum, charactermode, characterindex);
}

// Namespace character_customization/character_customization
// Params 6, eflags: 0x0
// Checksum 0x71050de3, Offset: 0x3268
// Size: 0x11c
function function_87ec3132(localclientnum, charactermode, characterindex, bodyindex, var_6f15f34e, var_66ec6e) {
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return 0;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedbodyaccentcolorforhero(localclientnum, charactermode, var_66ec6e.jobindex, bodyindex, var_6f15f34e, 1);
    }
    if (isdefined(var_66ec6e.defaultimagerender) && isdefined(var_66ec6e) && var_66ec6e.defaultimagerender) {
        return 0;
    }
    return getequippedbodyaccentcolorforhero(localclientnum, charactermode, characterindex, bodyindex, var_6f15f34e);
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0xfbf78c7a, Offset: 0x3390
// Size: 0xf4
function function_a4a750bd(localclientnum, charactermode, characterindex, bodyindex, var_66ec6e) {
    var_a86f93e5 = getbodyaccentcolorcountforhero(localclientnum, charactermode, characterindex, bodyindex);
    colors = [];
    for (i = 0; i < 3; i++) {
        colors[i] = 0;
    }
    for (i = 0; i < var_a86f93e5; i++) {
        colors[i] = function_87ec3132(localclientnum, charactermode, characterindex, bodyindex, i, var_66ec6e);
    }
    return colors;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0xfd5ce9e1, Offset: 0x3490
// Size: 0x11c
function function_ba2060c8(localclientnum, charactermode, var_66ec6e) {
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return 0;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedheadindexforhero(localclientnum, charactermode, var_66ec6e.jobindex);
    }
    if (isdefined(var_66ec6e) && isdefined(var_66ec6e.useheadindex)) {
        return var_66ec6e.useheadindex;
    }
    if (isdefined(var_66ec6e.defaultimagerender) && isdefined(var_66ec6e) && var_66ec6e.defaultimagerender) {
        return 0;
    }
    return getequippedheadindexforhero(localclientnum, charactermode);
}

// Namespace character_customization/character_customization
// Params 4, eflags: 0x0
// Checksum 0x21351875, Offset: 0x35b8
// Size: 0x12c
function function_f9865c49(localclientnum, charactermode, characterindex, var_66ec6e) {
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return 0;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedhelmetindexforhero(localclientnum, charactermode, var_66ec6e.jobindex, 1);
    }
    if (isdefined(var_66ec6e) && isdefined(var_66ec6e.var_3c23be53)) {
        return var_66ec6e.var_3c23be53;
    }
    if (isdefined(var_66ec6e.defaultimagerender) && isdefined(var_66ec6e) && var_66ec6e.defaultimagerender) {
        return 0;
    }
    return getequippedhelmetindexforhero(localclientnum, charactermode, characterindex);
}

// Namespace character_customization/character_customization
// Params 4, eflags: 0x0
// Checksum 0x1f8b0e7a, Offset: 0x36f0
// Size: 0xf4
function function_e37bf19c(localclientnum, charactermode, characterindex, var_66ec6e) {
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return undefined;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedshowcaseweaponforhero(localclientnum, charactermode, var_66ec6e.jobindex, 1);
    }
    if (isdefined(var_66ec6e) && isdefined(var_66ec6e.var_77b585e5)) {
        return var_66ec6e.var_77b585e5;
    }
    return getequippedshowcaseweaponforhero(localclientnum, charactermode, characterindex);
}

// Namespace character_customization/character_customization
// Params 6, eflags: 0x0
// Checksum 0x81e580dd, Offset: 0x37f0
// Size: 0x11c
function function_6abaf171(localclientnum, charactermode, characterindex, var_bf37af0a, var_6f15f34e, var_66ec6e) {
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return 0;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedhelmetaccentcolorforhero(localclientnum, charactermode, var_66ec6e.jobindex, var_bf37af0a, var_6f15f34e, 1);
    }
    if (isdefined(var_66ec6e.defaultimagerender) && isdefined(var_66ec6e) && var_66ec6e.defaultimagerender) {
        return 0;
    }
    return getequippedhelmetaccentcolorforhero(localclientnum, charactermode, characterindex, var_bf37af0a, var_6f15f34e);
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0x709bd236, Offset: 0x3918
// Size: 0xf4
function function_227c64d8(localclientnum, charactermode, characterindex, var_bf37af0a, var_66ec6e) {
    var_54f15524 = gethelmetaccentcolorcountforhero(localclientnum, charactermode, characterindex, var_bf37af0a);
    colors = [];
    for (i = 0; i < 3; i++) {
        colors[i] = 0;
    }
    for (i = 0; i < var_54f15524; i++) {
        colors[i] = function_6abaf171(localclientnum, charactermode, characterindex, var_bf37af0a, i, var_66ec6e);
    }
    return colors;
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0xbba602c4, Offset: 0x3a18
// Size: 0x44
function function_2142a641(charactermodel) {
    if (!charactermodel hasanimtree()) {
        charactermodel useanimtree(#all_player);
    }
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0x4399e44c, Offset: 0x3a68
// Size: 0xd0
function function_40b8ba(params) {
    if (isdefined(params.weapon_right) && params.weapon_right == "wpn_t7_hero_reaper_minigun_prop" && isdefined(level.var_5b12555e.charactermodel) && issubstr(level.var_5b12555e.charactermodel.model, "body3")) {
        params.weapon_right = "wpn_t7_loot_hero_reaper3_minigun_prop";
        params.weapon = getweapon("hero_minigun_body3");
        return true;
    }
    return false;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x6590539f, Offset: 0x3b40
// Size: 0x4d4
function function_fd188096(localclientnum, data_struct, params) {
    fields = getcharacterfields(data_struct.characterindex, data_struct.charactermode);
    if (data_struct.var_d11acdfe == "weapon") {
        if (isdefined(fields.var_a58a63b2)) {
            params.anim_name = fields.var_a58a63b2;
        }
        params.scene = undefined;
        if (isdefined(fields.var_8bf65b3)) {
            params.weapon_left = fields.var_8bf65b3;
        }
        if (isdefined(fields.var_1eb5dbdb)) {
            params.weapon_left_anim = fields.var_1eb5dbdb;
        }
        if (isdefined(fields.var_49430442)) {
            params.weapon_right = fields.var_49430442;
        }
        if (isdefined(fields.var_f2fe4e54)) {
            params.weapon_right_anim = fields.var_f2fe4e54;
        }
        if (isdefined(fields.var_4635da0c)) {
            params.exploder_id = fields.var_4635da0c;
        }
        if (isdefined(struct::get(fields.var_4e6dd005))) {
            params.align_struct = struct::get(fields.var_4e6dd005);
        }
        if (isdefined(fields.var_32517f52)) {
            params.xcam = fields.var_32517f52;
        }
        if (isdefined(fields.var_4b2ece39)) {
            params.subxcam = fields.var_4b2ece39;
        }
        if (isdefined(fields.var_a61911f5)) {
            params.xcamframe = fields.var_a61911f5;
        }
    } else if (data_struct.var_d11acdfe == "ability") {
        if (isdefined(fields.var_7eecb64e)) {
            params.anim_name = fields.var_7eecb64e;
        }
        params.scene = undefined;
        if (isdefined(fields.var_b59ca217)) {
            params.weapon_left = fields.var_b59ca217;
        }
        if (isdefined(fields.var_631e94bf)) {
            params.weapon_left_anim = fields.var_631e94bf;
        }
        if (isdefined(fields.var_bb57939e)) {
            params.weapon_right = fields.var_bb57939e;
        }
        if (isdefined(fields.var_2e64080)) {
            params.weapon_right_anim = fields.var_2e64080;
        }
        if (isdefined(fields.var_b46f15b8)) {
            params.exploder_id = fields.var_b46f15b8;
        }
        if (isdefined(struct::get(fields.var_a5b9d889))) {
            params.align_struct = struct::get(fields.var_a5b9d889);
        }
        if (isdefined(fields.var_538075fe)) {
            params.xcam = fields.var_538075fe;
        }
        if (isdefined(fields.var_f621fcd)) {
            params.subxcam = fields.var_f621fcd;
        }
        if (isdefined(fields.var_502195e1)) {
            params.xcamframe = fields.var_502195e1;
        }
    }
    function_40b8ba(params);
    if (!isdefined(params.align_struct)) {
        params.align_struct = data_struct;
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x9c7f61a1, Offset: 0x4020
// Size: 0xb4
function play_intro_and_animation(intro_anim_name, anim_name, b_keep_link) {
    self notify(#"hash_4ff7fd85");
    self endon(#"hash_4ff7fd85");
    if (isdefined(intro_anim_name)) {
        self animation::play(intro_anim_name, self.var_efd873ed, self.var_81ec66f3, 1, 0, 0, 0, b_keep_link);
    }
    self animation::play(anim_name, self.var_efd873ed, self.var_81ec66f3, 1, 0, 0, 0, b_keep_link);
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0xcfd6efab, Offset: 0x40e0
// Size: 0x6c
function function_e6f3ac24(data_struct, params) {
    if (!isdefined(params.weapon_right) && !isdefined(params.weapon_left)) {
        if (isdefined(data_struct.anim_name)) {
            params.anim_name = data_struct.anim_name;
        }
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0xaf0aa51f, Offset: 0x4158
// Size: 0x88c
function function_873d37c(localclientnum, data_struct, params) {
    changed = 0;
    if (!isdefined(params)) {
        params = spawnstruct();
    }
    if (data_struct.var_62e980f && isdefined(data_struct.var_d11acdfe)) {
        function_fd188096(localclientnum, data_struct, params);
    }
    if (!isdefined(params.exploder_id)) {
        params.exploder_id = data_struct.default_exploder;
    }
    align_changed = 0;
    if (!isdefined(params.align_struct)) {
        params.align_struct = struct::get(data_struct.align_target);
    }
    if (!isdefined(params.align_struct)) {
        params.align_struct = data_struct;
    }
    if (params.align_struct.origin !== data_struct.charactermodel.var_efd873ed || isdefined(params.align_struct) && params.align_struct.angles !== data_struct.charactermodel.var_81ec66f3) {
        data_struct.charactermodel.var_efd873ed = params.align_struct.origin;
        data_struct.charactermodel.var_81ec66f3 = params.align_struct.angles;
        params.anim_name = isdefined(params.anim_name) ? params.anim_name : data_struct.var_a5c8c7ea;
        align_changed = 1;
    }
    if (isdefined(data_struct.var_418b6e8a) && data_struct.var_418b6e8a) {
        function_e6f3ac24(data_struct, params);
    }
    if (function_40b8ba(params)) {
        align_changed = 1;
        changed = 1;
    }
    if (isdefined(params.weapon_right) && params.weapon_right !== data_struct.weapon_right) {
        align_changed = 1;
    }
    if (params.anim_name !== data_struct.var_a5c8c7ea || isdefined(params.anim_name) && align_changed) {
        changed = 1;
        end_game_taunts::function_7222354d(localclientnum, data_struct.charactermodel);
        end_game_taunts::function_1926278(data_struct.charactermodel);
        data_struct.var_a5c8c7ea = params.anim_name;
        data_struct.weapon_right = params.weapon_right;
        if (!data_struct.charactermodel hasanimtree()) {
            data_struct.charactermodel useanimtree(#all_player);
        }
        data_struct.charactermodel thread play_intro_and_animation(params.anim_intro_name, params.anim_name, 0);
    } else if (isdefined(params.scene) && params.scene !== data_struct.var_b1813a38) {
        if (isdefined(data_struct.var_b1813a38)) {
            level scene::stop(data_struct.var_b1813a38, 0);
        }
        function_2142a641(data_struct.charactermodel);
        data_struct.var_b1813a38 = params.scene;
        level thread scene::play(params.scene);
    }
    if (data_struct.exploder_id !== params.exploder_id) {
        if (isdefined(data_struct.exploder_id)) {
            killradiantexploder(localclientnum, data_struct.exploder_id);
        }
        if (isdefined(params.exploder_id)) {
            playradiantexploder(localclientnum, params.exploder_id);
        }
        data_struct.exploder_id = params.exploder_id;
    }
    if (isdefined(params.weapon_right) || isdefined(params.weapon_left)) {
        update_model_attachment(localclientnum, data_struct, params.weapon_right, "tag_weapon_right", params.weapon_right_anim, params.weapon_right_anim_intro, align_changed);
        update_model_attachment(localclientnum, data_struct, params.weapon_left, "tag_weapon_left", params.weapon_left_anim, params.weapon_left_anim_intro, align_changed);
    } else if (isdefined(data_struct.var_8f9c1e31)) {
        if (isdefined(data_struct.attached_models["tag_weapon_right"]) && data_struct.charactermodel isattached(data_struct.attached_models["tag_weapon_right"], "tag_weapon_right")) {
            data_struct.charactermodel detach(data_struct.attached_models["tag_weapon_right"], "tag_weapon_right");
        }
        if (isdefined(data_struct.attached_models["tag_weapon_left"]) && data_struct.charactermodel isattached(data_struct.attached_models["tag_weapon_left"], "tag_weapon_left")) {
            data_struct.charactermodel detach(data_struct.attached_models["tag_weapon_left"], "tag_weapon_left");
        }
        data_struct.charactermodel attachweapon(data_struct.var_8f9c1e31, data_struct.weaponrenderoptions, data_struct.acvi);
        data_struct.charactermodel useweaponhidetags(data_struct.var_8f9c1e31);
        data_struct.charactermodel.showcaseweapon = data_struct.var_8f9c1e31;
        data_struct.charactermodel.var_7ff9e1d4 = data_struct.weaponrenderoptions;
        data_struct.charactermodel.var_4b073b25 = data_struct.acvi;
    }
    return changed;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0xb7fb47c3, Offset: 0x49f0
// Size: 0x11a
function function_b0a8e76d(localclientnum, data_struct, var_51a4f7fb) {
    if (data_struct.var_62e980f != var_51a4f7fb) {
        data_struct.var_62e980f = var_51a4f7fb;
        params = spawnstruct();
        if (!data_struct.var_62e980f) {
            params.align_struct = struct::get("character_customization");
            params.anim_name = "pb_cac_main_lobby_idle";
        }
        markasdirty(data_struct.charactermodel);
        function_873d37c(localclientnum, data_struct, params);
        if (data_struct.var_62e980f) {
            level notify("frozenMomentChanged" + localclientnum);
        }
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0xbac733d4, Offset: 0x4b18
// Size: 0xcc
function function_ea9faed5(localclientnum, data_struct, show_helmets) {
    if (data_struct.show_helmets != show_helmets) {
        data_struct.show_helmets = show_helmets;
        params = spawnstruct();
        params.weapon_right = data_struct.attached_models["tag_weapon_right"];
        params.weapon_left = data_struct.attached_models["tag_weapon_left"];
        update(localclientnum, data_struct, params);
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0xcb56ecd5, Offset: 0x4bf0
// Size: 0xcc
function function_474a5989(localclientnum, data_struct, align_target) {
    if (data_struct.align_target !== align_target) {
        data_struct.align_target = align_target;
        params = spawnstruct();
        params.weapon_right = data_struct.attached_models["tag_weapon_right"];
        params.weapon_left = data_struct.attached_models["tag_weapon_left"];
        update(localclientnum, data_struct, params);
    }
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0xaccd6deb, Offset: 0x4cc8
// Size: 0xd4
function setup_live_character_customization_target(localclientnum, notifyname) {
    characterent = getent(localclientnum, "character_customization", "targetname");
    if (isdefined(characterent)) {
        var_fbfb9ecd = function_b79cb078(characterent, localclientnum, 1);
        var_fbfb9ecd.default_exploder = "char_customization";
        var_fbfb9ecd.var_418b6e8a = 1;
        level thread updateeventthread(localclientnum, var_fbfb9ecd, notifyname);
        return var_fbfb9ecd;
    }
    return undefined;
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0xb105e593, Offset: 0x4da8
// Size: 0x7c
function update_locked_shader(localclientnum, params) {
    if (isdefined(params.isitemunlocked) && params.isitemunlocked != 1) {
        enablefrontendlockedweaponoverlay(localclientnum, 1);
        return;
    }
    enablefrontendlockedweaponoverlay(localclientnum, 0);
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x44f09c65, Offset: 0x4e30
// Size: 0x86a
function updateeventthread(localclientnum, data_struct, notifyname) {
    while (true) {
        waitresult = level waittill(notifyname + localclientnum);
        eventtype = waitresult.param1;
        param1 = waitresult.param2;
        param2 = waitresult.param3;
        param3 = waitresult.param4;
        param4 = waitresult.param5;
        switch (eventtype) {
        case #"update_lcn":
            data_struct.var_2fee1906 = param1;
            break;
        case #"refresh":
            data_struct.var_2fee1906 = param1;
            params = spawnstruct();
            params.anim_name = "pb_cac_main_lobby_idle";
            params.sessionmode = param2;
            function_d79d6d7(localclientnum, data_struct, undefined, params);
            if (isdefined(param3) && param3 != "") {
                level.var_5b12555e.playsound = param3;
            }
            break;
        case #"changehero":
            params = spawnstruct();
            params.anim_name = "pb_cac_main_lobby_idle";
            params.sessionmode = param2;
            function_d79d6d7(localclientnum, data_struct, param1, params);
            break;
        case #"changegender":
            params = spawnstruct();
            params.anim_name = "pb_cac_main_lobby_idle";
            params.sessionmode = param2;
            bodyindex = getfirstheroofgender(param1, param2);
            headindex = getfirstheadofgender(param1, param2);
            function_d79d6d7(localclientnum, data_struct, bodyindex, params);
            function_5b80fae8(data_struct, param2, headindex);
            update(localclientnum, data_struct, params);
            break;
        case #"hash_e7981b89":
            params = spawnstruct();
            params.sessionmode = param2;
            params.isitemunlocked = param3;
            function_56dceb6(data_struct, param2, data_struct.characterindex, param1, function_a4a750bd(localclientnum, param2, data_struct.characterindex, param1));
            update(localclientnum, data_struct, params);
            update_locked_shader(localclientnum, params);
            break;
        case #"hash_f8bd53ea":
            params = spawnstruct();
            params.sessionmode = param2;
            params.isitemunlocked = param3;
            function_5fa9d769(data_struct, param2, data_struct.characterindex, param1, function_227c64d8(localclientnum, param2, data_struct.characterindex, param1));
            update(localclientnum, data_struct, params);
            update_locked_shader(localclientnum, params);
            break;
        case #"hash_f9e2e346":
            params = spawnstruct();
            params.sessionmode = param4;
            function_f374c6fc(data_struct, param4, localclientnum, undefined, data_struct.characterindex, param1, param2, param3, 0, 1);
            update(localclientnum, data_struct, params);
            break;
        case #"changehead":
            params = spawnstruct();
            params.sessionmode = param2;
            function_5b80fae8(data_struct, param2, param1);
            update(localclientnum, data_struct, params);
            break;
        case #"hash_7c8317a4":
            params = spawnstruct();
            params.sessionmode = param3;
            function_f87a1792(data_struct, param1, param2);
            update(localclientnum, data_struct, params);
            break;
        case #"hash_4806cf3d":
            params = spawnstruct();
            params.sessionmode = param3;
            function_883d8451(data_struct, param1, param2);
            update(localclientnum, data_struct, params);
            break;
        case #"hash_98df80af":
            data_struct.var_d11acdfe = param1;
            if (data_struct.var_62e980f) {
                markasdirty(data_struct.charactermodel);
                function_873d37c(localclientnum, data_struct, undefined);
            }
            level notify("frozenMomentChanged" + localclientnum);
            break;
        case #"previewgesture":
            data_struct.var_a5c8c7ea = param1;
            thread end_game_taunts::previewgesture(localclientnum, data_struct.charactermodel, data_struct.anim_name, param1);
            break;
        case #"hash_b5457a9d":
            if (function_ddd0628f(data_struct)) {
                data_struct.var_a5c8c7ea = param1;
                thread end_game_taunts::function_b5457a9d(localclientnum, data_struct.charactermodel, data_struct.anim_name, param1);
            }
            break;
        case #"hide":
            data_struct.charactermodel hide();
            break;
        case #"show":
            data_struct.charactermodel show();
            break;
        }
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0xc570c701, Offset: 0x56a8
// Size: 0xf8
function rotation_thread_spawner(localclientnum, data_struct, endonevent) {
    if (!isdefined(endonevent)) {
        return;
    }
    assert(isdefined(data_struct.charactermodel));
    model = data_struct.charactermodel;
    baseangles = model.angles;
    level thread update_model_rotation_for_right_stick(localclientnum, data_struct, endonevent);
    level waittill(endonevent);
    if (!(isdefined(data_struct.charactermodel.var_e10c584d) && data_struct.charactermodel.var_e10c584d)) {
        model.angles = baseangles;
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x8d296370, Offset: 0x57a8
// Size: 0x2b6
function update_model_rotation_for_right_stick(localclientnum, data_struct, endonevent) {
    level endon(endonevent);
    assert(isdefined(data_struct.charactermodel));
    model = data_struct.charactermodel;
    while (true) {
        data_lcn = isdefined(data_struct.var_2fee1906) ? data_struct.var_2fee1906 : localclientnum;
        if (localclientactive(data_lcn) && !(isdefined(data_struct.charactermodel.var_e10c584d) && data_struct.charactermodel.var_e10c584d)) {
            pos = getcontrollerposition(data_lcn);
            if (isdefined(pos["rightStick"])) {
                model.angles = (model.angles[0], absangleclamp360(model.angles[1] + pos["rightStick"][0] * 3), model.angles[2]);
            } else {
                model.angles = (model.angles[0], absangleclamp360(model.angles[1] + pos["look"][0] * 3), model.angles[2]);
            }
            if (ispc()) {
                pos = getxcammousecontrol(data_lcn);
                model.angles = (model.angles[0], absangleclamp360(model.angles[1] - pos["yaw"] * 3), model.angles[2]);
            }
        }
        waitframe(1);
    }
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0x14657ca8, Offset: 0x5a68
// Size: 0x1d4
function setup_static_character_customization_target(localclientnum) {
    characterent = getent(localclientnum, "character_customization_staging", "targetname");
    level.extra_cam_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_character_customization", "cam_menu_unfocus", "pb_cac_main_lobby_idle", 0);
    level.var_3bd0563c[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", "pb_cac_vs_screen_idle_1", 1);
    level.extra_cam_headshot_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", "pb_cac_vs_screen_idle_1", 0);
    level.extra_cam_head_preview_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", "pb_cac_main_lobby_idle", 0);
    level.extra_cam_gender_preview_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", "pb_cac_main_lobby_idle", 0);
    if (isdefined(characterent)) {
        var_fbfb9ecd = function_b79cb078(characterent, localclientnum, 0);
        level thread update_character_extracam(localclientnum, var_fbfb9ecd);
        return var_fbfb9ecd;
    }
    return undefined;
}

// Namespace character_customization/character_customization
// Params 4, eflags: 0x0
// Checksum 0xe28489a8, Offset: 0x5c48
// Size: 0x94
function setup_character_extracam_struct(xcam, subxcam, model_animation, var_9d818304) {
    newstruct = spawnstruct();
    newstruct.xcam = xcam;
    newstruct.subxcam = subxcam;
    newstruct.anim_name = model_animation;
    newstruct.var_9d818304 = var_9d818304;
    return newstruct;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x77dddd39, Offset: 0x5ce8
// Size: 0x5c
function wait_for_extracam_close(localclientnum, camera_ent, extracamindex) {
    level waittill("render_complete_" + localclientnum + "_" + extracamindex);
    multi_extracam::extracam_reset_index(localclientnum, extracamindex);
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x89cae456, Offset: 0x5d50
// Size: 0x33c
function setup_character_extracam_settings(localclientnum, data_struct, extracam_data_struct) {
    assert(isdefined(extracam_data_struct.jobindex));
    if (!isdefined(level.camera_ents)) {
        level.camera_ents = [];
    }
    initializedextracam = 0;
    camera_ent = isdefined(level.camera_ents[localclientnum]) ? level.camera_ents[localclientnum][extracam_data_struct.extracamindex] : undefined;
    if (!isdefined(camera_ent)) {
        initializedextracam = 1;
        multi_extracam::extracam_init_index(localclientnum, "character_staging_extracam" + extracam_data_struct.extracamindex + 1, extracam_data_struct.extracamindex);
        camera_ent = level.camera_ents[localclientnum][extracam_data_struct.extracamindex];
    }
    assert(isdefined(camera_ent));
    camera_ent playextracamxcam(extracam_data_struct.xcam, 0, extracam_data_struct.subxcam);
    params = spawnstruct();
    params.anim_name = extracam_data_struct.anim_name;
    params.extracam_data = extracam_data_struct;
    params.isdefaulthero = extracam_data_struct.isdefaulthero;
    params.sessionmode = extracam_data_struct.sessionmode;
    params.hide_helmet = isdefined(extracam_data_struct.hidehelmet) && extracam_data_struct.hidehelmet;
    data_struct.alt_render_mode = 0;
    function_d79d6d7(localclientnum, data_struct, extracam_data_struct.characterindex, params);
    while (!function_ddd0628f(data_struct)) {
        waitframe(1);
    }
    if (isdefined(extracam_data_struct.defaultimagerender) && extracam_data_struct.defaultimagerender) {
        wait 0.5;
    } else {
        wait 0.1;
    }
    setextracamrenderready(extracam_data_struct.jobindex);
    extracam_data_struct.jobindex = undefined;
    if (initializedextracam) {
        level thread wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct.extracamindex);
    }
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0x95937365, Offset: 0x6098
// Size: 0x78
function update_character_extracam(localclientnum, data_struct) {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill("process_character_extracam" + localclientnum);
        setup_character_extracam_settings(localclientnum, data_struct, waitresult.extracam_data_struct);
    }
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0x5a550c22, Offset: 0x6118
// Size: 0xda
function function_bc334e1a(localclientnum, jobindex, extracamindex, sessionmode, characterindex) {
    level.extra_cam_hero_data[localclientnum].jobindex = jobindex;
    level.extra_cam_hero_data[localclientnum].extracamindex = extracamindex;
    level.extra_cam_hero_data[localclientnum].characterindex = characterindex;
    level.extra_cam_hero_data[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:level.extra_cam_hero_data[localclientnum]});
}

// Namespace character_customization/character_customization
// Params 4, eflags: 0x0
// Checksum 0xc7d3ab34, Offset: 0x6200
// Size: 0xe6
function function_cdc26129(localclientnum, jobindex, extracamindex, sessionmode) {
    level.var_3bd0563c[localclientnum].jobindex = jobindex;
    level.var_3bd0563c[localclientnum].extracamindex = extracamindex;
    level.var_3bd0563c[localclientnum].characterindex = getequippedcharacterindexforlobbyclienthero(localclientnum, jobindex);
    level.var_3bd0563c[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:level.var_3bd0563c[localclientnum]});
}

// Namespace character_customization/character_customization
// Params 6, eflags: 0x0
// Checksum 0x4143113, Offset: 0x62f0
// Size: 0x102
function process_current_hero_headshot_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, characterindex, isdefaulthero) {
    level.extra_cam_headshot_hero_data[localclientnum].jobindex = jobindex;
    level.extra_cam_headshot_hero_data[localclientnum].extracamindex = extracamindex;
    level.extra_cam_headshot_hero_data[localclientnum].characterindex = characterindex;
    level.extra_cam_headshot_hero_data[localclientnum].isdefaulthero = isdefaulthero;
    level.extra_cam_headshot_hero_data[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:level.extra_cam_headshot_hero_data[localclientnum]});
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0x3c62ca15, Offset: 0x6400
// Size: 0x126
function process_head_preview_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, headindex) {
    level.extra_cam_head_preview_data[localclientnum].jobindex = jobindex;
    level.extra_cam_head_preview_data[localclientnum].extracamindex = extracamindex;
    level.extra_cam_head_preview_data[localclientnum].useheadindex = headindex;
    level.extra_cam_head_preview_data[localclientnum].characterindex = getfirstheroofgender(getheadgender(headindex, sessionmode), sessionmode);
    level.extra_cam_head_preview_data[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:level.extra_cam_outfit_preview_data[localclientnum]});
}

// Namespace character_customization/character_customization
// Params 7, eflags: 0x0
// Checksum 0xfab738c1, Offset: 0x6530
// Size: 0x18a
function function_c27b6e13(localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultimagerender) {
    extracam_data = undefined;
    if (defaultimagerender) {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "loot_body", "pb_cac_vs_screen_idle_1", 0);
        extracam_data.useheadindex = getfirstheadofgender(getherogender(characterindex, sessionmode), sessionmode);
    } else {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_body", "pb_cac_vs_screen_idle_1", 0);
    }
    extracam_data.jobindex = jobindex;
    extracam_data.extracamindex = extracamindex;
    extracam_data.sessionmode = sessionmode;
    extracam_data.characterindex = characterindex;
    extracam_data.var_59ecf1ca = itemindex;
    extracam_data.defaultimagerender = defaultimagerender;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:extracam_data});
}

// Namespace character_customization/character_customization
// Params 7, eflags: 0x0
// Checksum 0xe2495bd, Offset: 0x66c8
// Size: 0x18a
function function_b345c4d8(localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultimagerender) {
    extracam_data = undefined;
    if (defaultimagerender) {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "loot_helmet", "pb_cac_vs_screen_idle_1", 0);
        extracam_data.useheadindex = getfirstheadofgender(getherogender(characterindex, sessionmode), sessionmode);
    } else {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_helmet", "pb_cac_vs_screen_idle_1", 0);
    }
    extracam_data.jobindex = jobindex;
    extracam_data.extracamindex = extracamindex;
    extracam_data.sessionmode = sessionmode;
    extracam_data.characterindex = characterindex;
    extracam_data.var_3c23be53 = itemindex;
    extracam_data.defaultimagerender = defaultimagerender;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:extracam_data});
}

// Namespace character_customization/character_customization
// Params 6, eflags: 0x0
// Checksum 0x88e79758, Offset: 0x6860
// Size: 0x182
function process_character_head_item_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, headindex, defaultimagerender) {
    extracam_data = undefined;
    if (defaultimagerender) {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "cam_head", "pb_cac_vs_screen_idle_1", 0);
        extracam_data.characterindex = getfirstheroofgender(getheadgender(headindex, sessionmode), sessionmode);
    } else {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_head", "pb_cac_vs_screen_idle_1", 0);
    }
    extracam_data.jobindex = jobindex;
    extracam_data.extracamindex = extracamindex;
    extracam_data.sessionmode = sessionmode;
    extracam_data.useheadindex = headindex;
    extracam_data.hidehelmet = 1;
    extracam_data.defaultimagerender = defaultimagerender;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:extracam_data});
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0x43339a13, Offset: 0x69f0
// Size: 0x126
function process_gender_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, gender) {
    level.extra_cam_gender_preview_data[localclientnum].jobindex = jobindex;
    level.extra_cam_gender_preview_data[localclientnum].extracamindex = extracamindex;
    level.extra_cam_gender_preview_data[localclientnum].useheadindex = getfirstheadofgender(gender, sessionmode);
    level.extra_cam_gender_preview_data[localclientnum].characterindex = getfirstheroofgender(gender, sessionmode);
    level.extra_cam_gender_preview_data[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:level.extra_cam_gender_preview_data[localclientnum]});
}
