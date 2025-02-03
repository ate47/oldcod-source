#using script_53cd49b939f89fd7;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\activecamo_shared_util;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace customclass;

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x1082f0d6, Offset: 0x5f0
// Size: 0x24
function localclientconnect(localclientnum) {
    level thread custom_class_init(localclientnum);
}

// Namespace customclass/custom_class
// Params 0, eflags: 0x0
// Checksum 0xfa43e15c, Offset: 0x620
// Size: 0x45c
function init() {
    level.var_636c2236 = 0;
    level.weapon_script_model = [];
    level.preload_weapon_model = [];
    level.last_weapon_name = [];
    level.var_8ad413c = [];
    level.current_weapon = [];
    level.attachment_names = [];
    level.paintshophiddenposition = [];
    level.camo_index = [];
    level.reticle_index = [];
    level.var_dd70be5b = [];
    level.var_aa10d0b4 = [];
    level.weapon_clientscript_cac_model = [];
    level.weaponnone = getweapon(#"none");
    level.weapon_position[#"primary"] = struct::get("cac_weapon_position_primary");
    level.weapon_position[#"secondary"] = struct::get("cac_weapon_position_secondary");
    level.weapon_position[#"hash_5f2a18f0e771a387"] = struct::get("cac_weapon_position_secondary_oversized");
    level.weapon_position[#"secondarygrenade"] = struct::get("cac_weapon_position_tactical_grenade");
    level.weapon_position[#"hash_777a08527f2da4e1"] = struct::get("cac_weapon_position_tactical_grenade_2");
    level.weapon_position[#"primarygrenade"] = struct::get("cac_weapon_position_lethal_grenade");
    level.weapon_position[#"hash_6148898d5ac59179"] = struct::get("cac_weapon_position_lethal_grenade_2");
    level.weapon_position[#"specialgrenade"] = struct::get("cac_weapon_position_field_upgrade");
    level.weapon_position[#"perk1"] = struct::get("cac_weapon_position_perk_1");
    level.weapon_position[#"hash_75a53afe5fb30f2c"] = struct::get("cac_weapon_position_perk_1_2nd");
    level.weapon_position[#"hash_1e3b6d1c50127b6d"] = struct::get("cac_weapon_position_perk_1_3rd");
    level.weapon_position[#"perk2"] = struct::get("cac_weapon_position_perk_2");
    level.weapon_position[#"hash_27460ccf4582b502"] = struct::get("cac_weapon_position_perk_2_2nd");
    level.weapon_position[#"hash_551e597e4fcfe0e4"] = struct::get("cac_weapon_position_perk_2_3rd");
    level.weapon_position[#"perk3"] = struct::get("cac_weapon_position_perk_3");
    level.weapon_position[#"hash_344ad3ebce2569"] = struct::get("cac_weapon_position_perk_3_2nd");
    level.weapon_position[#"hash_3c0f3d3aa7135e86"] = struct::get("cac_weapon_position_perk_3_3rd");
    level.weapon_position[#"bonuscard1"] = struct::get("cac_weapon_position_wildcard");
    level.weapon_position[#"gunsmith"] = struct::get("gunsmith_weapon_position");
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x8a564f4e, Offset: 0xa88
// Size: 0x5c
function function_bf9f3492(var_d4c489c0) {
    switch (var_d4c489c0) {
    case #"primarygrenade":
        return #"hash_6148898d5ac59179";
    case #"secondarygrenade":
        return #"hash_777a08527f2da4e1";
    }
    return undefined;
}

// Namespace customclass/custom_class
// Params 5, eflags: 0x0
// Checksum 0x7d9d2a6a, Offset: 0xaf0
// Size: 0x4f4
function function_1cd1374d(var_1d35315f, var_d4c489c0 = #"primary", var_e81ceea = "", localclientnum, var_85d87aca) {
    if (isdefined(var_1d35315f) && (isstring(var_1d35315f) || ishash(var_1d35315f))) {
        var_1d35315f = getweapon(var_1d35315f);
    }
    if (var_d4c489c0 == #"gunsmith") {
        s_info = function_5f70d1c8(var_1d35315f, var_e81ceea);
    } else {
        s_info = function_3bff05ba(var_1d35315f, var_d4c489c0, localclientnum);
    }
    var_d3c21d73 = s_info.origin;
    v_ang_offset = s_info.angles;
    switch (var_d4c489c0) {
    case #"primary":
    default:
        if (is_true(var_1d35315f.islauncher)) {
            if (function_4dcbc16b(localclientnum, var_d4c489c0, var_1d35315f)) {
                s_location = level.weapon_position[#"primary"];
            } else {
                s_location = level.weapon_position[#"hash_5f2a18f0e771a387"];
            }
        } else {
            s_location = level.weapon_position[#"primary"];
        }
        break;
    case #"secondary":
        if (is_true(var_1d35315f.islauncher)) {
            s_location = level.weapon_position[#"hash_5f2a18f0e771a387"];
        } else {
            s_location = level.weapon_position[#"secondary"];
        }
        break;
    case #"primarygrenade":
        s_location = level.weapon_position[#"primarygrenade"];
        break;
    case #"hash_6148898d5ac59179":
        s_location = level.weapon_position[#"hash_6148898d5ac59179"];
        break;
    case #"secondarygrenade":
        s_location = level.weapon_position[#"secondarygrenade"];
        break;
    case #"hash_777a08527f2da4e1":
        s_location = level.weapon_position[#"hash_777a08527f2da4e1"];
        break;
    case #"specialgrenade":
        s_location = level.weapon_position[#"specialgrenade"];
        break;
    case #"talent1":
    case #"talents":
    case #"perk1":
        s_location = function_3ca8f346(var_85d87aca, var_d4c489c0);
        break;
    case #"talent2":
    case #"perk2":
        s_location = function_3ca8f346(var_85d87aca, var_d4c489c0);
        break;
    case #"talent3":
    case #"perk3":
        s_location = function_3ca8f346(var_85d87aca, var_d4c489c0);
        break;
    case #"bonuscard1":
        s_location = level.weapon_position[#"bonuscard1"];
        break;
    case #"gunsmith":
        s_location = level.weapon_position[#"gunsmith"];
        break;
    }
    function_3de4843(localclientnum, var_d4c489c0, s_info.var_697bf2ff, var_1d35315f, s_info);
    var_cb7a50a5 = {#origin:s_location.origin + var_d3c21d73, #angles:s_location.angles + v_ang_offset};
    return var_cb7a50a5;
}

// Namespace customclass/custom_class
// Params 5, eflags: 0x0
// Checksum 0xdb85428c, Offset: 0xff0
// Size: 0x962
function function_3de4843(localclientnum, var_8a4ba442, b_show = 0, weapon, s_info) {
    switch (var_8a4ba442) {
    case #"primary":
    default:
        var_35be18f5 = getentarray(localclientnum, "hooks_primary_weapon", "script_noteworthy");
        foreach (var_bc94f6f in var_35be18f5) {
            if (!isdefined(var_bc94f6f.var_a4fadd7e)) {
                var_bc94f6f.var_a4fadd7e = var_bc94f6f.origin;
            }
            if (isdefined(var_bc94f6f.targetname)) {
                switch (var_bc94f6f.targetname) {
                case #"hooks_primary_weapon_hook_left":
                    var_bc94f6f.origin = var_bc94f6f.var_a4fadd7e + s_info.var_a5946026;
                    break;
                case #"hooks_primary_weapon_hook_right":
                    var_bc94f6f.origin = var_bc94f6f.var_a4fadd7e + s_info.var_36859b17;
                    break;
                case #"hooks_primary_weapon_middle":
                    var_bc94f6f.origin = var_bc94f6f.var_a4fadd7e + s_info.var_a7adf514;
                    break;
                case #"hooks_primary_weapon_plate_left":
                    var_bc94f6f.origin = var_bc94f6f.var_a4fadd7e + (0, s_info.var_a5946026[1], s_info.var_a5946026[2]);
                    break;
                case #"hooks_primary_weapon_plate_right":
                    var_bc94f6f.origin = var_bc94f6f.var_a4fadd7e + (0, s_info.var_36859b17[1], s_info.var_36859b17[2]);
                    break;
                }
            }
            if (b_show) {
                if (weapon.weapclass === "pistol") {
                    if (var_bc94f6f.targetname === "hooks_primary_weapon_middle") {
                        var_bc94f6f show();
                    } else {
                        var_bc94f6f hide();
                    }
                } else if (var_bc94f6f.targetname === "hooks_primary_weapon_middle") {
                    var_bc94f6f hide();
                } else {
                    var_bc94f6f show();
                }
                continue;
            }
            var_bc94f6f hide();
        }
        break;
    case #"secondary":
        var_d74b0620 = getentarray(localclientnum, "hooks_secondary_weapon", "script_noteworthy");
        foreach (var_72ff5fa4 in var_d74b0620) {
            if (!isdefined(var_72ff5fa4.var_a4fadd7e)) {
                var_72ff5fa4.var_a4fadd7e = var_72ff5fa4.origin;
            }
            if (isdefined(var_72ff5fa4.targetname)) {
                switch (var_72ff5fa4.targetname) {
                case #"hooks_secondary_weapon_hook_left":
                    var_72ff5fa4.origin = var_72ff5fa4.var_a4fadd7e + s_info.var_a5946026;
                    break;
                case #"hooks_secondary_weapon_middle":
                    var_72ff5fa4.origin = var_72ff5fa4.var_a4fadd7e + s_info.var_a7adf514;
                    break;
                case #"hooks_secondary_weapon_hook_right":
                    var_72ff5fa4.origin = var_72ff5fa4.var_a4fadd7e + s_info.var_36859b17;
                    break;
                case #"hooks_secondary_weapon_plate_left":
                    var_72ff5fa4.origin = var_72ff5fa4.var_a4fadd7e + (0, s_info.var_a5946026[1], s_info.var_a5946026[2]);
                    break;
                case #"hooks_secondary_weapon_plate_right":
                    var_72ff5fa4.origin = var_72ff5fa4.var_a4fadd7e + (0, s_info.var_36859b17[1], s_info.var_36859b17[2]);
                    break;
                }
            }
            if (b_show) {
                if (weapon.weapclass === "pistol") {
                    if (var_72ff5fa4.targetname === "hooks_secondary_weapon_middle") {
                        var_72ff5fa4 show();
                    } else {
                        var_72ff5fa4 hide();
                    }
                } else if (var_72ff5fa4.targetname === "hooks_secondary_weapon_middle") {
                    var_72ff5fa4 hide();
                } else {
                    var_72ff5fa4 show();
                }
                continue;
            }
            var_72ff5fa4 hide();
        }
        break;
    case #"primarygrenade":
        var_f33b540a = getentarray(localclientnum, "shelves_primary_grenade", "script_noteworthy");
        foreach (var_6f552f36 in var_f33b540a) {
            if (!isdefined(var_6f552f36.var_a4fadd7e)) {
                var_6f552f36.var_a4fadd7e = var_6f552f36.origin;
            }
            if (var_6f552f36.targetname === "shelf_primary_grenade_middle") {
                var_6f552f36.origin = var_6f552f36.var_a4fadd7e + s_info.var_a7adf514;
            }
            if (b_show) {
                var_6f552f36 show();
                continue;
            }
            var_6f552f36 hide();
        }
        break;
    case #"secondarygrenade":
        var_b74cf891 = getentarray(localclientnum, "shelves_secondary_grenade", "script_noteworthy");
        foreach (var_3878ec49 in var_b74cf891) {
            if (!isdefined(var_3878ec49.var_a4fadd7e)) {
                var_3878ec49.var_a4fadd7e = var_3878ec49.origin;
            }
            if (var_3878ec49.targetname === "shelf_secondary_grenade_middle") {
                var_3878ec49.origin = var_3878ec49.var_a4fadd7e + s_info.var_a7adf514;
            }
            if (b_show) {
                var_3878ec49 show();
                continue;
            }
            var_3878ec49 hide();
        }
        break;
    case #"hash_6148898d5ac59179":
        break;
    case #"hash_777a08527f2da4e1":
        break;
    case #"specialgrenade":
        break;
    case #"talent3":
    case #"talent2":
    case #"talent1":
    case #"talents":
    case #"perk1":
    case #"perk3":
    case #"perk2":
        break;
    case #"bonuscard1":
        break;
    case #"gunsmith":
        break;
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xa43a6706, Offset: 0x1960
// Size: 0x5c
function custom_class_init(localclientnum) {
    level.last_weapon_name[localclientnum] = "";
    level.var_8ad413c[localclientnum] = "";
    level.current_weapon[localclientnum] = undefined;
    level thread custom_class_start_threads(localclientnum);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x40b8c896, Offset: 0x19c8
// Size: 0xf4
function custom_class_start_threads(localclientnum) {
    level endon(#"disconnect");
    level thread function_13c748a(localclientnum);
    while (true) {
        level thread custom_class_update(localclientnum);
        level thread custom_class_attachment_select_focus(localclientnum);
        level thread custom_class_remove(localclientnum);
        level thread custom_class_closed(localclientnum);
        s_waitresult = level waittill("CustomClass_update" + localclientnum, "CustomClass_focus" + localclientnum, "CustomClass_remove" + localclientnum, "CustomClass_closed" + localclientnum);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xc7e4917c, Offset: 0x1ac8
// Size: 0xce
function function_b4e01020(weapon) {
    result = undefined;
    foreach (attachment in weapon.attachments) {
        if (isdefined(result)) {
            result += "+" + attachment;
            continue;
        }
        result = attachment;
    }
    return isdefined(result) ? result : "";
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x5b7f3a69, Offset: 0x1ba0
// Size: 0x70
function function_13c748a(localclientnum) {
    level endon(#"disconnect");
    while (true) {
        wait_result = level waittill(#"hash_6e24a55f8db9dad9");
        function_bfa844a3(localclientnum, wait_result.classindex);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xce9e843, Offset: 0x1c18
// Size: 0xf6
function function_4aa0a8f6(var_ccf52c44) {
    switch (var_ccf52c44) {
    case #"primary":
    case #"specialgrenade":
    case #"secondary":
    case #"primarygrenade":
    case #"secondarygrenade":
        var_d8ebd573 = 1;
        break;
    case #"talent3":
    case #"talent2":
    case #"talent1":
        var_d8ebd573 = 5;
        break;
    case #"bonuscard1":
        var_d8ebd573 = 6;
        break;
    default:
        var_d8ebd573 = 0;
        break;
    }
    return var_d8ebd573;
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0x993d2fbe, Offset: 0x1d18
// Size: 0xac
function function_de681e67(localclientnum, var_73cd9b6e, var_1eee7d73) {
    itemindex = getloadoutitem(localclientnum, isdefined(var_73cd9b6e) ? var_73cd9b6e : level.var_41c1f7b9, #"bonuscard1");
    var_82e23366 = getunlockableiteminfofromindex(itemindex, function_4aa0a8f6(#"bonuscard1"));
    return var_82e23366.namehash === var_1eee7d73;
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0x51bc0c59, Offset: 0x1dd0
// Size: 0x90
function function_902cfbde(var_85d87aca, var_8a4ba442) {
    if (var_8a4ba442 !== #"talent1" && var_8a4ba442 !== #"talent2" && var_8a4ba442 !== #"talent3") {
        return true;
    }
    var_2a06d510 = function_60663bf8(var_85d87aca);
    if (var_8a4ba442 === var_2a06d510) {
        return true;
    }
    return false;
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xbcfa2925, Offset: 0x1e68
// Size: 0x1d4
function function_60663bf8(var_85d87aca) {
    if (isinarray(array(#"hash_35c80ca3d496436b", #"hash_5223a6478b827ae2", #"hash_2b8196a115a43717", #"hash_3c1acb367fc720b9", #"hash_771ac27519b59ae1"), hash(var_85d87aca))) {
        return #"talent1";
    }
    if (isinarray(array(#"hash_1f2871685383c0ce", #"hash_7ba3d840a075bb38", #"hash_27f40b888568660e", #"hash_5b36c90fb9767fbd", #"hash_7141f961caa3e322"), hash(var_85d87aca))) {
        return #"talent2";
    }
    if (isinarray(array(#"hash_36f90c4eff587435", #"hash_3a01bee9e73c5940", #"hash_2c45c89bceef41d1", #"hash_32e6e64c0881c14b", #"hash_320186f753bdd5fa"), hash(var_85d87aca))) {
        return #"talent3";
    }
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0xdd27b36c, Offset: 0x2048
// Size: 0x37e
function function_3ca8f346(var_85d87aca, var_c7d83c08) {
    if (var_c7d83c08 === #"talents" || function_902cfbde(var_85d87aca, var_c7d83c08)) {
        switch (var_c7d83c08) {
        case #"talent1":
        case #"talents":
        case #"perk1":
            s_location = level.weapon_position[#"perk1"];
            break;
        case #"talent2":
        case #"perk2":
            s_location = level.weapon_position[#"perk2"];
            break;
        case #"talent3":
        case #"perk3":
            s_location = level.weapon_position[#"perk3"];
            break;
        }
    } else {
        var_6ff86e8e = function_60663bf8(var_85d87aca);
        if (var_6ff86e8e === #"talent1") {
            if (var_c7d83c08 === #"talent2") {
                s_location = level.weapon_position[#"hash_75a53afe5fb30f2c"];
            } else {
                s_location = level.weapon_position[#"hash_1e3b6d1c50127b6d"];
            }
        } else if (var_6ff86e8e === #"talent2") {
            if (var_c7d83c08 === #"talent1") {
                s_location = level.weapon_position[#"hash_27460ccf4582b502"];
            } else {
                s_location = level.weapon_position[#"hash_551e597e4fcfe0e4"];
            }
        } else if (var_6ff86e8e === #"talent3") {
            if (var_c7d83c08 === #"talent1") {
                s_location = level.weapon_position[#"hash_344ad3ebce2569"];
            } else {
                s_location = level.weapon_position[#"hash_3c0f3d3aa7135e86"];
            }
        }
    }
    if (!isdefined(s_location)) {
        switch (var_c7d83c08) {
        case #"talent1":
        case #"talents":
        case #"perk1":
            s_location = level.weapon_position[#"perk1"];
            break;
        case #"talent2":
        case #"perk2":
            s_location = level.weapon_position[#"perk2"];
            break;
        case #"talent3":
        case #"perk3":
            s_location = level.weapon_position[#"perk3"];
            break;
        }
    }
    return s_location;
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0x497e36f0, Offset: 0x23d0
// Size: 0x1c8
function function_b8990106(*localclientnum, var_8a4ba442, var_b078b50b) {
    if (var_8a4ba442 === #"primary" || var_8a4ba442 === #"secondary") {
        if (isweapon(var_b078b50b)) {
            weapon = var_b078b50b;
        } else {
            weapon = getweapon(var_b078b50b);
        }
        if ((weapon.weapclass === #"pistol" || weapon.weapclass === #"spread" || weapon.weapclass === #"melee" || is_true(weapon.islauncher)) && var_8a4ba442 === #"secondary") {
            return true;
        } else if (weapon.weapclass !== #"pistol" && weapon.weapclass !== #"spread" && weapon.weapclass !== #"melee" && !is_true(weapon.islauncher) && var_8a4ba442 === #"primary") {
            return true;
        }
        return false;
    }
    return true;
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0xdb29edfe, Offset: 0x25a0
// Size: 0x500
function function_bfa844a3(localclientnum, var_73cd9b6e) {
    level.var_41c1f7b9 = var_73cd9b6e;
    var_9d78be26 = function_e2ae0e9(localclientnum, var_73cd9b6e);
    var_674329bc = array(#"primary", #"secondary", #"primarygrenade", #"secondarygrenade", #"specialgrenade", #"talent1", #"talent2", #"talent3", #"bonuscard1");
    foreach (var_8a4ba442 in var_674329bc) {
        if (isdefined(level.weapon_script_model[localclientnum][var_8a4ba442])) {
            level.weapon_script_model[localclientnum][var_8a4ba442] delete();
        }
        if (isdefined(level.preload_weapon_model[localclientnum][var_8a4ba442])) {
            level.preload_weapon_model[localclientnum][var_8a4ba442] delete();
        }
        if (var_8a4ba442 == #"primary" || var_8a4ba442 == #"secondary") {
            weapon = getloadoutweapon(localclientnum, var_73cd9b6e, var_8a4ba442);
        } else {
            itemindex = getloadoutitem(localclientnum, var_73cd9b6e, var_8a4ba442);
            var_82e23366 = getunlockableiteminfofromindex(itemindex, function_4aa0a8f6(var_8a4ba442));
            if (isdefined(var_82e23366) && isdefined(var_82e23366.namehash) && (var_8a4ba442 == #"primarygrenade" || var_8a4ba442 == #"secondarygrenade")) {
                weapon = getweapon(var_82e23366.namehash);
            } else {
                var_438da649 = function_b143666d(itemindex, function_4aa0a8f6(var_8a4ba442));
                model_name = isdefined(var_438da649.previewmodelname) ? var_438da649.previewmodelname : #"";
                var_95970e62 = isdefined(var_438da649.previewmodelscale) ? var_438da649.previewmodelscale : 1;
                weapon = level.weaponnone;
            }
        }
        s_position = function_1cd1374d(weapon, var_8a4ba442, undefined, localclientnum, model_name);
        level.weapon_script_model[localclientnum][var_8a4ba442] = spawn_weapon_model(localclientnum, s_position.origin, s_position.angles);
        level.preload_weapon_model[localclientnum][var_8a4ba442] = spawn_weapon_model(localclientnum, s_position.origin, s_position.angles);
        level.preload_weapon_model[localclientnum][var_8a4ba442] hide();
        toggle_locked_weapon_shader(localclientnum, 1, var_8a4ba442);
        update_weapon_script_model(localclientnum, weapon.name, function_b4e01020(weapon), undefined, 1, var_95970e62, model_name, var_8a4ba442);
        level.weapon_script_model[localclientnum][var_8a4ba442].origin = s_position.origin;
        level.weapon_script_model[localclientnum][var_8a4ba442].angles = s_position.angles;
        function_89f7e68e(localclientnum, var_73cd9b6e, var_8a4ba442, weapon, var_9d78be26);
    }
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0xc0aa6fbb, Offset: 0x2aa8
// Size: 0x94
function function_e2ae0e9(localclientnum, var_73cd9b6e) {
    var_33257025 = 0;
    var_4cda8464 = function_de681e67(localclientnum, isdefined(var_73cd9b6e) ? var_73cd9b6e : level.var_41c1f7b9, #"hash_4a12859000892dda");
    if (var_4cda8464 !== level.var_256be2c9) {
        var_33257025 = 1;
    }
    level.var_256be2c9 = var_4cda8464;
    return var_33257025;
}

// Namespace customclass/custom_class
// Params 5, eflags: 0x0
// Checksum 0xea950f96, Offset: 0x2b48
// Size: 0x4f0
function function_89f7e68e(localclientnum, var_c70fb4f3, var_8a4ba442, weapon, var_5405cbdb = 0) {
    if (var_8a4ba442 === #"primarygrenade" || var_8a4ba442 === #"secondarygrenade") {
        var_674329bc = array(var_8a4ba442);
    } else if (var_8a4ba442 === #"bonuscard1" && var_5405cbdb) {
        var_674329bc = array(#"primarygrenade", #"secondarygrenade");
    } else {
        return;
    }
    foreach (var_8a4ba442 in var_674329bc) {
        if (ishash(weapon) || isstring(weapon)) {
            weapon = getweapon(weapon);
        } else if (!isdefined(weapon) || weapon == level.weaponnone) {
            itemindex = getloadoutitem(localclientnum, isdefined(var_c70fb4f3) ? var_c70fb4f3 : level.var_41c1f7b9, var_8a4ba442);
            var_82e23366 = getunlockableiteminfofromindex(itemindex, function_4aa0a8f6(var_8a4ba442));
            if (isdefined(var_82e23366) && isdefined(var_82e23366.namehash) && (var_8a4ba442 == #"primarygrenade" || var_8a4ba442 == #"secondarygrenade")) {
                weapon = getweapon(var_82e23366.namehash);
            }
        }
        var_4342bc54 = function_bf9f3492(var_8a4ba442);
        if (isdefined(var_4342bc54)) {
            if (isdefined(level.weapon_script_model[localclientnum][var_4342bc54])) {
                level.weapon_script_model[localclientnum][var_4342bc54] delete();
            }
            if (isdefined(level.preload_weapon_model[localclientnum][var_4342bc54])) {
                level.preload_weapon_model[localclientnum][var_4342bc54] delete();
            }
            settings = function_34668e22(weapon);
            var_d5a66a55 = level.weaponnone;
            if (!is_true(settings.var_d1e947c6) && level.var_256be2c9) {
                var_d5a66a55 = weapon;
            }
            s_position = function_1cd1374d(var_d5a66a55, var_4342bc54, undefined, localclientnum);
            level.weapon_script_model[localclientnum][var_4342bc54] = spawn_weapon_model(localclientnum, s_position.origin, s_position.angles);
            level.preload_weapon_model[localclientnum][var_4342bc54] = spawn_weapon_model(localclientnum, s_position.origin, s_position.angles);
            level.preload_weapon_model[localclientnum][var_4342bc54] hide();
            toggle_locked_weapon_shader(localclientnum, 1, var_4342bc54);
            update_weapon_script_model(localclientnum, var_d5a66a55.name, function_b4e01020(var_d5a66a55), undefined, 1, undefined, undefined, var_4342bc54);
            level.weapon_script_model[localclientnum][var_4342bc54].origin = s_position.origin;
            level.weapon_script_model[localclientnum][var_4342bc54].angles = s_position.angles;
            weapon = undefined;
        }
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x1da1517a, Offset: 0x3040
// Size: 0x78
function function_831397a7(localclientnum) {
    level.var_636c2236 = 1;
    var_14bec5d2 = 0;
    function_bfa844a3(localclientnum, isdefined(level.var_41c1f7b9) ? level.var_41c1f7b9 : var_14bec5d2);
    [[ level.var_1c43dd3e ]]->function_39a68bf2();
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x4bac7b6a, Offset: 0x30c0
// Size: 0x188
function function_415febc4(localclientnum) {
    level.var_636c2236 = 0;
    level.var_64ee434 = undefined;
    level.var_908d7e4d = undefined;
    if (isdefined(level.weapon_script_model[localclientnum]) && !function_df656039(localclientnum)) {
        foreach (__, model in level.weapon_script_model[localclientnum]) {
            model hide();
        }
    }
    if (isdefined(level.preload_weapon_model[localclientnum]) && !function_df656039(localclientnum)) {
        foreach (model in level.preload_weapon_model[localclientnum]) {
            model hide();
        }
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x845ab30b, Offset: 0x3250
// Size: 0x68
function function_df656039(localclientnum) {
    if (lui_camera::is_current_menu(localclientnum, "PressStart", #"scorestreaks") || lui_camera::is_current_menu(localclientnum, "PressStart", #"loadout_room")) {
        return true;
    }
    return false;
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xa74ce10e, Offset: 0x32c0
// Size: 0x4e4
function custom_class_update(localclientnum) {
    level endon(#"disconnect", "CustomClass_focus" + localclientnum, "CustomClass_remove" + localclientnum, "CustomClass_closed" + localclientnum);
    waitresult = level waittill("CustomClass_update" + localclientnum);
    base_weapon_slot = waitresult.base_weapon_slot;
    var_f0bf9259 = waitresult.weapon;
    attachments = waitresult.attachments;
    weapon_options_param = waitresult.options;
    is_item_unlocked = waitresult.is_item_unlocked;
    xmodel_name = waitresult.xmodel_name;
    xmodel_scale = waitresult.xmodel_scale;
    var_cc6c0ec0 = waitresult.var_8d4568cf;
    var_f2af4049 = waitresult.var_820bb448;
    if (base_weapon_slot === #"gunsmith") {
        var_e81ceea = waitresult.attachment_group;
    }
    if (!isdefined(is_item_unlocked)) {
        is_item_unlocked = 1;
    }
    if (!isdefined(xmodel_scale)) {
        xmodel_scale = 1;
    }
    if (!isdefined(xmodel_name)) {
        xmodel_name = #"";
    }
    if (base_weapon_slot !== #"gunsmith" && isdefined(level.weapon_script_model[localclientnum][#"gunsmith"])) {
        level.weapon_script_model[localclientnum][#"gunsmith"] forcedelete();
        arrayremovevalue(level.weapon_script_model[localclientnum], undefined, 1);
    }
    if (isdefined(var_f0bf9259)) {
        if (isdefined(weapon_options_param) && weapon_options_param != "none") {
            function_998e2be7(localclientnum, weapon_options_param);
        }
        var_88cd6325 = getweapon(var_f0bf9259, strtok(attachments, "+"));
        s_position = function_1cd1374d(var_88cd6325, base_weapon_slot, var_e81ceea, localclientnum, xmodel_name);
        if (!isdefined(level.weapon_script_model[localclientnum][base_weapon_slot])) {
            level.weapon_script_model[localclientnum][base_weapon_slot] = spawn_weapon_model(localclientnum, s_position.origin, s_position.angles);
            level.preload_weapon_model[localclientnum][base_weapon_slot] = spawn_weapon_model(localclientnum, s_position.origin, s_position.angles);
            level.preload_weapon_model[localclientnum][base_weapon_slot] hide();
        }
        toggle_locked_weapon_shader(localclientnum, is_item_unlocked, base_weapon_slot);
        update_weapon_script_model(localclientnum, var_f0bf9259, attachments, undefined, is_item_unlocked, xmodel_scale, xmodel_name, base_weapon_slot, var_e81ceea);
        level.weapon_script_model[localclientnum][base_weapon_slot].origin = s_position.origin;
        level.weapon_script_model[localclientnum][base_weapon_slot].angles = s_position.angles;
        var_9d78be26 = function_e2ae0e9(localclientnum);
        function_89f7e68e(localclientnum, undefined, base_weapon_slot, var_f0bf9259, var_9d78be26);
        if (base_weapon_slot === #"gunsmith") {
            function_f87ec9a8(var_e81ceea, var_f0bf9259, var_f2af4049);
        } else {
            function_d39cd2b5(base_weapon_slot, var_f0bf9259, var_cc6c0ec0, var_f2af4049, localclientnum);
        }
        if (base_weapon_slot === #"talents") {
            function_483b3111(localclientnum);
        }
        function_36b453c7(localclientnum, base_weapon_slot, var_f0bf9259);
        setallowxcamrightstickrotation(localclientnum, !lui_camera::is_current_menu(localclientnum, "Paintshop"));
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x21fff0e5, Offset: 0x37b0
// Size: 0x84
function function_483b3111(localclientnum) {
    function_77630de5(localclientnum, level.var_41c1f7b9, #"talent1");
    function_77630de5(localclientnum, level.var_41c1f7b9, #"talent2");
    function_77630de5(localclientnum, level.var_41c1f7b9, #"talent3");
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0x60505b8d, Offset: 0x3840
// Size: 0x306
function function_77630de5(localclientnum, var_c70fb4f3, var_297c7602) {
    if (var_297c7602 !== #"talent1" && var_297c7602 !== #"talent2" && var_297c7602 !== #"talent3") {
        return;
    }
    itemindex = getloadoutitem(localclientnum, var_c70fb4f3, var_297c7602);
    var_438da649 = function_b143666d(itemindex, 5);
    if (isdefined(var_438da649)) {
        model_name = isdefined(var_438da649.previewmodelname) ? var_438da649.previewmodelname : #"";
        var_95970e62 = isdefined(var_438da649.previewmodelscale) ? var_438da649.previewmodelscale : 1;
    } else {
        return;
    }
    if (isdefined(level.weapon_script_model[localclientnum][var_297c7602])) {
        level.weapon_script_model[localclientnum][var_297c7602] delete();
    }
    if (isdefined(level.preload_weapon_model[localclientnum][var_297c7602])) {
        level.preload_weapon_model[localclientnum][var_297c7602] delete();
    }
    s_position = function_1cd1374d(level.weaponnone, var_297c7602, undefined, localclientnum, model_name);
    level.weapon_script_model[localclientnum][var_297c7602] = spawn_weapon_model(localclientnum, s_position.origin, s_position.angles);
    level.preload_weapon_model[localclientnum][var_297c7602] = spawn_weapon_model(localclientnum, s_position.origin, s_position.angles);
    level.preload_weapon_model[localclientnum][var_297c7602] hide();
    toggle_locked_weapon_shader(localclientnum, 1, var_297c7602);
    update_weapon_script_model(localclientnum, level.weaponnone.name, function_b4e01020(level.weaponnone), undefined, 1, var_95970e62, model_name, var_297c7602);
    level.weapon_script_model[localclientnum][var_297c7602].origin = s_position.origin;
    level.weapon_script_model[localclientnum][var_297c7602].angles = s_position.angles;
}

// Namespace customclass/custom_class
// Params 5, eflags: 0x0
// Checksum 0x9e8a132c, Offset: 0x3b50
// Size: 0x3dc
function function_d39cd2b5(var_8a4ba442 = "", str_weapon, var_cc6c0ec0 = 0, var_f2af4049 = 0, localclientnum) {
    if (var_cc6c0ec0) {
        var_c6abe208 = #"scene_frontend_t9_cac_select";
    } else {
        var_c6abe208 = #"scene_frontend_t9_cac_overview";
    }
    if (var_f2af4049 && scene::function_9730988a(var_c6abe208, "overview")) {
        var_23f6420e = "overview";
    } else {
        if (isdefined(str_weapon)) {
            weapon = getweapon(str_weapon);
        }
        switch (var_8a4ba442) {
        case #"primary":
            if (is_true(weapon.islauncher)) {
                if (function_4dcbc16b(localclientnum, var_8a4ba442, weapon)) {
                    var_23f6420e = "primary";
                } else {
                    var_23f6420e = "secondary_alt";
                }
            } else {
                var_23f6420e = "primary";
            }
            break;
        case #"secondary":
            if (is_true(weapon.islauncher)) {
                var_23f6420e = "secondary_alt";
            } else {
                var_23f6420e = "secondary";
            }
            break;
        case #"primarygrenade":
            var_23f6420e = "lethal";
            break;
        case #"secondarygrenade":
            var_23f6420e = "tactical";
            break;
        case #"tacticalgear":
            var_23f6420e = "tactical";
            break;
        case #"specialgrenade":
            var_23f6420e = "fieldupgrade";
            break;
        case #"talents":
            var_23f6420e = "perks";
            break;
        case #"talent1":
            var_23f6420e = "perk1";
            break;
        case #"talent2":
            var_23f6420e = "perk2";
            break;
        case #"talent3":
            var_23f6420e = "perk3";
            break;
        case #"bonuscard1":
            var_23f6420e = "wildcard";
            break;
        default:
            assertmsg("<dev string:x38>" + function_9e72a96(var_c6abe208) + "<dev string:x52>" + var_8a4ba442);
            break;
        }
    }
    if (var_c6abe208 !== level.var_64ee434 || var_23f6420e !== level.var_908d7e4d) {
        if (isdefined(level.var_64ee434)) {
            level scene::stop(level.var_64ee434);
        }
        level thread scene::play(var_c6abe208, var_23f6420e);
    }
    level.var_64ee434 = var_c6abe208;
    level.var_908d7e4d = var_23f6420e;
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0x5ad62331, Offset: 0x3f38
// Size: 0x244
function function_f87ec9a8(var_e81ceea = "", str_weapon, var_f2af4049 = 0) {
    if (!isdefined(level.var_f0a17a7b)) {
        level.var_f0a17a7b = #"scene_frontend_t9_gunsmith";
    }
    level scene::stop(level.var_f0a17a7b);
    if (var_f2af4049 && scene::function_9730988a(level.var_f0a17a7b, "overview")) {
        var_7dae7df8 = "overview";
    } else {
        if (isdefined(str_weapon)) {
            weapon = getweapon(str_weapon);
        }
        switch (var_e81ceea) {
        case #"optic":
            var_7dae7df8 = "optic";
            break;
        case #"muzzle":
            var_7dae7df8 = "muzzle";
            break;
        case #"barrel":
            var_7dae7df8 = "barrel";
            break;
        case #"underbarrel":
            var_7dae7df8 = "underbarrel";
            break;
        case #"body":
            var_7dae7df8 = "body";
            break;
        case #"stock":
            var_7dae7df8 = "stock";
            break;
        case #"magazine":
            var_7dae7df8 = "magazine";
            break;
        case #"handle":
            var_7dae7df8 = "handle";
            break;
        default:
            var_7dae7df8 = "overview";
            break;
        }
    }
    level thread scene::play(level.var_f0a17a7b, var_7dae7df8);
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0x8372dda9, Offset: 0x4188
// Size: 0xa4
function toggle_locked_weapon_shader(localclientnum, is_item_unlocked = 1, var_8a4ba442 = #"primary") {
    if (!isdefined(level.weapon_script_model[localclientnum][var_8a4ba442])) {
        return;
    }
    if (is_item_unlocked != 1) {
        enablefrontendlockedweaponoverlay(localclientnum, 1);
        return;
    }
    enablefrontendlockedweaponoverlay(localclientnum, 0);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x13eac2ab, Offset: 0x4238
// Size: 0x1ec
function custom_class_attachment_select_focus(localclientnum) {
    level endon(#"disconnect");
    level endon("CustomClass_update" + localclientnum);
    level endon("CustomClass_remove" + localclientnum);
    level endon("CustomClass_closed" + localclientnum);
    waitresult = level waittill("CustomClass_focus" + localclientnum);
    level endon("CustomClass_focus" + localclientnum);
    base_weapon_slot = waitresult.base_weapon_slot;
    weapon_name = waitresult.weapon;
    attachments = waitresult.attachments;
    attachment = waitresult.attachment;
    weapon_options_param = waitresult.options;
    weaponattachmentintersection = get_attachments_intersection(level.last_weapon_name[localclientnum], level.var_8ad413c[localclientnum], attachments);
    if (isdefined(weapon_options_param) && weapon_options_param != "none") {
        function_998e2be7(localclientnum, weapon_options_param);
    }
    preload_weapon_model(localclientnum, weapon_name, weaponattachmentintersection, base_weapon_slot);
    update_weapon_script_model(localclientnum, weapon_name, weaponattachmentintersection, 0, undefined, undefined, undefined, base_weapon_slot);
    if (weapon_name == weaponattachmentintersection) {
        weapon_name = undefined;
    }
    level thread change_weapon(localclientnum, base_weapon_slot, attachment, weapon_name, weaponattachmentintersection);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xc460f14b, Offset: 0x4430
// Size: 0x18c
function custom_class_remove(localclientnum) {
    level endon(#"disconnect", "CustomClass_update" + localclientnum, "CustomClass_focus" + localclientnum, "CustomClass_closed" + localclientnum);
    level waittill("CustomClass_remove" + localclientnum);
    enablefrontendlockedweaponoverlay(localclientnum, 0);
    enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
    if (isarray(level.weapon_script_model[localclientnum])) {
        foreach (mdl_weapon in level.weapon_script_model[localclientnum]) {
            mdl_weapon forcedelete();
        }
        arrayremovevalue(level.weapon_script_model[localclientnum], undefined, 1);
    }
    level.last_weapon_name[localclientnum] = "";
    level.var_8ad413c[localclientnum] = "";
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x8fd24b08, Offset: 0x45c8
// Size: 0xd4
function custom_class_closed(localclientnum) {
    level endon(#"disconnect", "CustomClass_update" + localclientnum, "CustomClass_focus" + localclientnum, "CustomClass_remove" + localclientnum);
    params = level waittill(#"customclass_closed");
    if (params.param1 == localclientnum) {
        enablefrontendlockedweaponoverlay(localclientnum, 0);
        enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
        level.last_weapon_name[localclientnum] = "";
        level.var_8ad413c[localclientnum] = "";
    }
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0x36032a4a, Offset: 0x46a8
// Size: 0x86
function spawn_weapon_model(localclientnum, origin, angles) {
    weapon_model = spawn(localclientnum, origin, "script_model");
    weapon_model sethighdetail(level.var_636c2236, level.var_636c2236);
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    return weapon_model;
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x4a863aa8, Offset: 0x4738
// Size: 0x44
function get_camo_index(localclientnum) {
    if (!isdefined(level.camo_index[localclientnum])) {
        level.camo_index[localclientnum] = 0;
    }
    return level.camo_index[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x5d913bfa, Offset: 0x4788
// Size: 0x44
function get_reticle_index(localclientnum) {
    if (!isdefined(level.reticle_index[localclientnum])) {
        level.reticle_index[localclientnum] = 0;
    }
    return level.reticle_index[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x6f62ede5, Offset: 0x47d8
// Size: 0x60
function function_1d61dcf3(localclientnum) {
    if (!isdefined(level.var_f1c6301d)) {
        level.var_f1c6301d = [];
    }
    if (!isdefined(level.var_f1c6301d[localclientnum])) {
        level.var_f1c6301d[localclientnum] = 0;
    }
    return level.var_f1c6301d[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x5dc96e41, Offset: 0x4840
// Size: 0x44
function get_show_paintshop(localclientnum) {
    if (!isdefined(level.show_paintshop[localclientnum])) {
        level.show_paintshop[localclientnum] = 0;
    }
    return level.show_paintshop[localclientnum];
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0xac8cb987, Offset: 0x4890
// Size: 0x68
function function_162e1121(localclientnum, var_571f2574) {
    if (!isdefined(level.var_571f2574)) {
        level.var_571f2574 = [];
    }
    if (!isdefined(level.var_571f2574[localclientnum])) {
        level.var_571f2574[localclientnum] = 0;
    }
    level.var_571f2574[localclientnum] = var_571f2574;
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x7fd809d2, Offset: 0x4900
// Size: 0x60
function function_52145a0d(localclientnum) {
    if (!isdefined(level.var_571f2574)) {
        level.var_571f2574 = [];
    }
    if (!isdefined(level.var_571f2574[localclientnum])) {
        level.var_571f2574[localclientnum] = 0;
    }
    return level.var_571f2574[localclientnum];
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0xaaed4ced, Offset: 0x4968
// Size: 0x194
function function_998e2be7(localclientnum, weapon_options_param) {
    weapon_options = strtok(weapon_options_param, ",");
    level.camo_index[localclientnum] = int(weapon_options[0]);
    level.reticle_index[localclientnum] = int(weapon_options[1]);
    level.show_paintshop[localclientnum] = int(weapon_options[2]);
    if (isdefined(weapon_options[3])) {
        level.var_f1c6301d[localclientnum] = int(weapon_options[3]);
    }
    if (isdefined(weapon_options[4])) {
        level.var_dd70be5b[localclientnum] = int(weapon_options[4]);
    } else {
        level.var_dd70be5b[localclientnum] = -1;
    }
    if (isdefined(weapon_options[5])) {
        function_162e1121(localclientnum, int(weapon_options[5]));
        return;
    }
    function_162e1121(localclientnum, 0);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xd2ead119, Offset: 0x4b08
// Size: 0x52
function get_weapon_options(localclientnum) {
    return function_6eff28b5(localclientnum, get_camo_index(localclientnum), get_reticle_index(localclientnum), get_show_paintshop(localclientnum));
}

// Namespace customclass/custom_class
// Params 4, eflags: 0x0
// Checksum 0xe77cc8, Offset: 0x4b68
// Size: 0x134
function preload_weapon_model(localclientnum, newweaponstring, var_f020955, var_8a4ba442 = #"primary") {
    level notify("preload_weapon_changing_" + localclientnum);
    current_weapon = getweapon(newweaponstring, strtok(var_f020955, "+"));
    if (current_weapon == level.weaponnone) {
        return;
    }
    level.preload_weapon_model[localclientnum][var_8a4ba442] useweaponmodel(current_weapon, undefined, get_weapon_options(localclientnum), function_1d61dcf3(localclientnum));
    while (true) {
        if (level.preload_weapon_model[localclientnum][var_8a4ba442] isstreamed()) {
            return;
        }
        wait 0.1;
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xda4876c9, Offset: 0x4ca8
// Size: 0x84
function function_8bf05e82(localclientnum) {
    var_cc22b19 = createuimodel(function_1df4c3b0(localclientnum, #"hash_4979ef8c6b71470b"), "entNum");
    var_b65f6ce3 = self getentitynumber();
    setuimodelvalue(var_cc22b19, var_b65f6ce3);
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x4
// Checksum 0xf7053833, Offset: 0x4d38
// Size: 0xca
function private function_70be20f4(localclientnum, weaponmodel) {
    if (!isdefined(level.var_dd70be5b[localclientnum]) || level.var_dd70be5b[localclientnum] <= -1) {
        return 0;
    }
    activecamoinfo = activecamo::function_13e12ab1(level.camo_index[localclientnum]);
    if (!isdefined(activecamoinfo)) {
        return 0;
    }
    var_3594168e = activecamoinfo.stages[level.var_dd70be5b[localclientnum]];
    return activecamo::function_6c9e0e1a(localclientnum, weaponmodel, var_3594168e, level.var_aa10d0b4);
}

// Namespace customclass/custom_class
// Params 9, eflags: 0x0
// Checksum 0x40431e9d, Offset: 0x4e10
// Size: 0x68c
function update_weapon_script_model(localclientnum, newweaponstring, var_f020955, *should_update_weapon_options, is_item_unlocked = 1, xmodel_scale = 1, xmodel_name = #"", var_8a4ba442 = #"primary", var_e81ceea) {
    /#
        assert(isdefined(var_f020955), "<dev string:x6d>");
        assert(isdefined(should_update_weapon_options), "<dev string:xba>");
    #/
    level.last_weapon_name[newweaponstring] = isdefined(var_f020955) ? var_f020955 : #"ar_accurate_t9";
    level.var_8ad413c[newweaponstring] = isdefined(should_update_weapon_options) ? should_update_weapon_options : "";
    var_571f2574 = function_52145a0d(newweaponstring);
    if (var_571f2574 > 0) {
        if (!issubstr(level.var_8ad413c[newweaponstring], "custom2")) {
            attachments = strtok(level.var_8ad413c[newweaponstring], "+");
            if (attachments.size < 7) {
                if (!isdefined(attachments)) {
                    attachments = [];
                } else if (!isarray(attachments)) {
                    attachments = array(attachments);
                }
                attachments[attachments.size] = "custom2";
                should_update_weapon_options = "";
                for (i = 0; i < attachments.size; i++) {
                    if (i > 0) {
                        should_update_weapon_options += "+";
                    }
                    should_update_weapon_options += attachments[i];
                }
                level.var_8ad413c[newweaponstring] = should_update_weapon_options;
            }
        }
    }
    level.current_weapon[newweaponstring] = getweapon(level.last_weapon_name[newweaponstring], strtok(level.var_8ad413c[newweaponstring], "+"));
    if (level.current_weapon[newweaponstring] == level.weaponnone || xmodel_name !== #"") {
        level.weapon_script_model[newweaponstring][var_8a4ba442] delete();
        s_position = function_1cd1374d(level.last_weapon_name[newweaponstring], var_8a4ba442, var_e81ceea, newweaponstring, xmodel_name);
        level.weapon_script_model[newweaponstring][var_8a4ba442] = spawn_weapon_model(newweaponstring, s_position.origin, s_position.angles);
        toggle_locked_weapon_shader(newweaponstring, is_item_unlocked, var_8a4ba442);
        if (xmodel_name !== #"") {
            level.weapon_script_model[newweaponstring][var_8a4ba442] setmodel(xmodel_name);
        } else if (level.last_weapon_name[newweaponstring] === #"none") {
            level.weapon_script_model[newweaponstring][var_8a4ba442] setmodel(#"tag_origin");
        } else {
            level.weapon_script_model[newweaponstring][var_8a4ba442] setmodel(level.last_weapon_name[newweaponstring]);
        }
        level.weapon_script_model[newweaponstring][var_8a4ba442] setscale(xmodel_scale);
        return;
    }
    function_975f521b(var_571f2574);
    level.weapon_script_model[newweaponstring][var_8a4ba442] useweaponmodel(level.current_weapon[newweaponstring], undefined, get_weapon_options(newweaponstring), function_1d61dcf3(newweaponstring));
    weaponmodel = level.weapon_script_model[newweaponstring][var_8a4ba442];
    if (!function_70be20f4(newweaponstring, weaponmodel)) {
        if (isdefined(level.var_aa10d0b4[newweaponstring])) {
            weaponmodel stoprenderoverridebundle(level.var_aa10d0b4[newweaponstring]);
            level.var_aa10d0b4[newweaponstring] = undefined;
        }
    }
    if (var_8a4ba442 == #"gunsmith") {
        s_info = function_5f70d1c8(level.current_weapon[newweaponstring], var_e81ceea);
    } else {
        s_info = function_3bff05ba(level.current_weapon[newweaponstring], var_8a4ba442, newweaponstring);
    }
    level.weapon_script_model[newweaponstring][var_8a4ba442] setscale(s_info.scale);
    level.weapon_script_model[newweaponstring][var_8a4ba442] function_8bf05e82(newweaponstring);
    if (isdefined(s_info.var_402cbe2d)) {
        level.weapon_script_model[newweaponstring][var_8a4ba442] setmodel(s_info.var_402cbe2d);
    }
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0xf1024ed, Offset: 0x54a8
// Size: 0x228
function function_4dcbc16b(localclientnum, var_3f5552f9, var_53f950ea) {
    if (var_3f5552f9 === #"primary" || var_3f5552f9 === #"secondary") {
        var_4f84f11f = getloadoutweapon(localclientnum, level.var_41c1f7b9, #"primary");
        var_e6cbc2be = getloadoutweapon(localclientnum, level.var_41c1f7b9, #"secondary");
        if (is_true(var_4f84f11f.islauncher) && is_true(var_e6cbc2be.islauncher) || is_true(var_53f950ea.islauncher) && var_3f5552f9 === #"primary" && is_true(var_e6cbc2be.islauncher) || is_true(var_53f950ea.islauncher) && var_3f5552f9 === #"secondary" && is_true(var_4f84f11f.islauncher) || isdefined(level.var_fe51f5a8) && var_3f5552f9 === #"primary" && level.var_fe51f5a8 === var_4f84f11f || isdefined(level.var_fe51f5a8) && var_3f5552f9 === #"secondary" && level.var_fe51f5a8 === var_e6cbc2be) {
            return true;
        }
    }
    return false;
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0xa9fe8a5b, Offset: 0x56d8
// Size: 0x28e
function function_36b453c7(localclientnum, var_8a4ba442, weapon) {
    if (ishash(weapon) || isstring(weapon)) {
        weapon = getweapon(weapon);
    }
    if (var_8a4ba442 === #"primary" || var_8a4ba442 === #"secondary") {
        if (var_8a4ba442 === #"primary") {
            var_3ce5447 = #"secondary";
        } else {
            var_3ce5447 = #"primary";
        }
        if (function_4dcbc16b(localclientnum, var_8a4ba442, weapon)) {
            level.var_fe51f5a8 = getloadoutweapon(localclientnum, level.var_41c1f7b9, var_3ce5447);
            weapon = level.var_fe51f5a8;
        } else {
            weapon = getloadoutweapon(localclientnum, level.var_41c1f7b9, var_3ce5447);
        }
        if (is_true(weapon.islauncher) && isdefined(level.weapon_script_model[localclientnum][var_3ce5447]) && isdefined(level.preload_weapon_model[localclientnum][var_3ce5447])) {
            s_position = function_1cd1374d(weapon, var_3ce5447, undefined, localclientnum);
            toggle_locked_weapon_shader(localclientnum, 1, var_3ce5447);
            update_weapon_script_model(localclientnum, weapon.name, function_b4e01020(weapon), undefined, 1, undefined, undefined, var_3ce5447);
            level.weapon_script_model[localclientnum][var_3ce5447].origin = s_position.origin;
            level.weapon_script_model[localclientnum][var_3ce5447].angles = s_position.angles;
            level.weapon_script_model[localclientnum][var_3ce5447] show();
        }
        level.var_fe51f5a8 = undefined;
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x370cbf1e, Offset: 0x5970
// Size: 0x3e
function function_ccfcedeb(localclientnum) {
    if (isdefined(self.var_a8f1ca4e)) {
        stopfx(localclientnum, self.var_a8f1ca4e);
        self.var_a8f1ca4e = undefined;
    }
}

// Namespace customclass/custom_class
// Params 5, eflags: 0x0
// Checksum 0x65b87f30, Offset: 0x59b8
// Size: 0xbc
function change_weapon(localclientnum, var_8a4ba442, newweaponstring, var_f020955, should_update_weapon_options = 0) {
    self notify("5cebae0646b5fa7d");
    self endon("5cebae0646b5fa7d");
    self endon(#"death");
    level endon(#"cam_customization_closed");
    if (isdefined(newweaponstring)) {
        preload_weapon_model(localclientnum, newweaponstring, var_f020955, var_8a4ba442);
        update_weapon_script_model(localclientnum, newweaponstring, var_f020955, should_update_weapon_options, undefined, undefined, undefined, var_8a4ba442);
    }
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0x5ac7cbff, Offset: 0x5a80
// Size: 0x10c
function get_attachments_intersection(oldweapon, oldattachments, var_6714c3a0) {
    if (!isdefined(oldweapon)) {
        return var_6714c3a0;
    }
    var_3f8fbddf = strtok(oldattachments, "+");
    var_95e90a5e = strtok(var_6714c3a0, "+");
    if (!isdefined(var_3f8fbddf[0]) || var_3f8fbddf[0] != var_95e90a5e[0]) {
        return var_6714c3a0;
    }
    var_a014270e = var_95e90a5e[0];
    for (i = 1; i < var_95e90a5e.size; i++) {
        if (isinarray(var_3f8fbddf, var_95e90a5e[i])) {
            var_a014270e += "+" + var_95e90a5e[i];
        }
    }
    return var_a014270e;
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xa54f37b3, Offset: 0x5b98
// Size: 0x6c
function function_34668e22(weapon) {
    if (isdefined(weapon)) {
        var_fda44b34 = function_5f7c1515(weapon);
        if (isdefined(var_fda44b34.var_640479c3)) {
            settings = getscriptbundle(var_fda44b34.var_640479c3);
            return settings;
        }
    }
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0x1a0738af, Offset: 0x5c10
// Size: 0x10d2
function function_5f70d1c8(weapon, var_e81ceea = "") {
    settings = function_34668e22(weapon);
    var_5ac895fb = struct::spawn((isdefined(settings.var_2a929786) ? settings.var_2a929786 : 0, isdefined(settings.var_57d6720d) ? settings.var_57d6720d : 0, isdefined(settings.var_4e105e81) ? settings.var_4e105e81 : 0), (isdefined(settings.var_107b50df) ? settings.var_107b50df : 0, isdefined(settings.var_d9546292) ? settings.var_d9546292 : 0, isdefined(settings.var_eb1f0627) ? settings.var_eb1f0627 : 0));
    if (var_e81ceea == "") {
        var_f3d83915 = (0, 0, 0);
        var_dd6869e3 = (0, 0, 0);
        if (function_cd84dead(weapon, "barrel") && function_cd84dead(weapon, "muzzle")) {
            var_f3d83915 = (isdefined(settings.var_c451d2fd) ? settings.var_c451d2fd : 0, isdefined(settings.var_79913d89) ? settings.var_79913d89 : 0, isdefined(settings.var_8dd96619) ? settings.var_8dd96619 : 0);
            var_dd6869e3 = (isdefined(settings.var_7010317b) ? settings.var_7010317b : 0, isdefined(settings.var_4c5eea19) ? settings.var_4c5eea19 : 0, isdefined(settings.var_3ead4eb6) ? settings.var_3ead4eb6 : 0);
            var_d098ea88 = isdefined(settings.var_38287270) ? settings.var_38287270 : 0;
        } else if (function_cd84dead(weapon, "muzzle")) {
            var_f3d83915 = (isdefined(settings.var_4a27453e) ? settings.var_4a27453e : 0, isdefined(settings.var_5861e1b3) ? settings.var_5861e1b3 : 0, isdefined(settings.var_74941a17) ? settings.var_74941a17 : 0);
            var_dd6869e3 = (isdefined(settings.var_8f5ed804) ? settings.var_8f5ed804 : 0, isdefined(settings.var_81b53cb1) ? settings.var_81b53cb1 : 0, isdefined(settings.var_23e08109) ? settings.var_23e08109 : 0);
            var_d098ea88 = isdefined(settings.var_72dfbab8) ? settings.var_72dfbab8 : 0;
        } else if (function_cd84dead(weapon, "barrel")) {
            var_f3d83915 = (isdefined(settings.var_ba85afd3) ? settings.var_ba85afd3 : 0, isdefined(settings.var_a84b0b5e) ? settings.var_a84b0b5e : 0, isdefined(settings.var_d50064c8) ? settings.var_d50064c8 : 0);
            var_dd6869e3 = (isdefined(settings.var_a903d0e5) ? settings.var_a903d0e5 : 0, isdefined(settings.var_bb36754a) ? settings.var_bb36754a : 0, isdefined(settings.var_cd7899ce) ? settings.var_cd7899ce : 0);
            var_d098ea88 = isdefined(settings.var_12bacd52) ? settings.var_12bacd52 : 0;
        } else if (function_cd84dead(weapon, "stock")) {
            var_f3d83915 = (isdefined(settings.var_504e1d0c) ? settings.var_504e1d0c : 0, isdefined(settings.var_7a9c71a8) ? settings.var_7a9c71a8 : 0, isdefined(settings.var_6ce3d637) ? settings.var_6ce3d637 : 0);
            var_dd6869e3 = (isdefined(settings.var_ddba9446) ? settings.var_ddba9446 : 0, isdefined(settings.var_ebfd30cb) ? settings.var_ebfd30cb : 0, isdefined(settings.var_350942ea) ? settings.var_350942ea : 0);
            var_d098ea88 = isdefined(settings.var_da2aed5a) ? settings.var_da2aed5a : 0;
        }
        var_5ac895fb.origin += var_f3d83915;
        var_5ac895fb.angles += var_dd6869e3;
        var_5ac895fb.scale = isdefined(settings.var_9c241dd8) ? settings.var_9c241dd8 : 1;
        if (isdefined(var_d098ea88)) {
            var_5ac895fb.scale += var_d098ea88;
        }
    } else {
        var_639f35c4 = (0, 0, 0);
        var_31d7e562 = (0, 0, 0);
        switch (var_e81ceea) {
        case #"optic":
            var_639f35c4 = (isdefined(settings.var_679ca3b5) ? settings.var_679ca3b5 : 0, isdefined(settings.var_bc194cb1) ? settings.var_bc194cb1 : 0, isdefined(settings.var_67a5a3cb) ? settings.var_67a5a3cb : 0);
            var_31d7e562 = (isdefined(settings.var_80cb53e7) ? settings.var_80cb53e7 : 0, isdefined(settings.var_9294f77a) ? settings.var_9294f77a : 0, isdefined(settings.var_5d408cd2) ? settings.var_5d408cd2 : 0);
            var_3245d5de = isdefined(settings.var_2685ca21) ? settings.var_2685ca21 : 0;
            break;
        case #"muzzle":
            var_639f35c4 = (isdefined(settings.var_89849ace) ? settings.var_89849ace : 0, isdefined(settings.var_f73a7638) ? settings.var_f73a7638 : 0, isdefined(settings.var_77edf7a1) ? settings.var_77edf7a1 : 0);
            var_31d7e562 = (isdefined(settings.var_390d2d1) ? settings.var_390d2d1 : 0, isdefined(settings.var_19bdff2b) ? settings.var_19bdff2b : 0, isdefined(settings.var_e7ef1b8e) ? settings.var_e7ef1b8e : 0);
            var_3245d5de = isdefined(settings.var_b3516d45) ? settings.var_b3516d45 : 0;
            break;
        case #"barrel":
            var_639f35c4 = (isdefined(settings.var_7c3d339b) ? settings.var_7c3d339b : 0, isdefined(settings.var_6e029726) ? settings.var_6e029726 : 0, isdefined(settings.var_a0bffca0) ? settings.var_a0bffca0 : 0);
            var_31d7e562 = (isdefined(settings.var_8ca3e332) ? settings.var_8ca3e332 : 0, isdefined(settings.var_7ee247af) ? settings.var_7ee247af : 0, isdefined(settings.var_47f3d9d3) ? settings.var_47f3d9d3 : 0);
            var_3245d5de = isdefined(settings.var_ad8114a5) ? settings.var_ad8114a5 : 0;
            break;
        case #"underbarrel":
            var_639f35c4 = (isdefined(settings.var_98adab76) ? settings.var_98adab76 : 0, isdefined(settings.var_74056226) ? settings.var_74056226 : 0, isdefined(settings.var_66bec799) ? settings.var_66bec799 : 0);
            var_31d7e562 = (isdefined(settings.var_d03599ea) ? settings.var_d03599ea : 0, isdefined(settings.var_9258bc1) ? settings.var_9258bc1 : 0, isdefined(settings.var_2e65d641) ? settings.var_2e65d641 : 0);
            var_3245d5de = isdefined(settings.var_c8287774) ? settings.var_c8287774 : 0;
            break;
        case #"body":
            var_639f35c4 = (isdefined(settings.var_d0af4d25) ? settings.var_d0af4d25 : 0, isdefined(settings.var_e2ea719b) ? settings.var_e2ea719b : 0, isdefined(settings.var_b75b1a7d) ? settings.var_b75b1a7d : 0);
            var_31d7e562 = (isdefined(settings.var_807fd135) ? settings.var_807fd135 : 0, isdefined(settings.var_66581c7a) ? settings.var_66581c7a : 0, isdefined(settings.var_5beb080c) ? settings.var_5beb080c : 0);
            var_3245d5de = isdefined(settings.var_ca6cd5d0) ? settings.var_ca6cd5d0 : 0;
            break;
        case #"stock":
            var_639f35c4 = (isdefined(settings.var_933f2ee0) ? settings.var_933f2ee0 : 0, isdefined(settings.var_7d95038c) ? settings.var_7d95038c : 0, isdefined(settings.var_210b4a7a) ? settings.var_210b4a7a : 0);
            var_31d7e562 = (isdefined(settings.var_14141efc) ? settings.var_14141efc : 0, isdefined(settings.var_3a32eb39) ? settings.var_3a32eb39 : 0, isdefined(settings.var_2858c785) ? settings.var_2858c785 : 0);
            var_3245d5de = isdefined(settings.var_72fa56e9) ? settings.var_72fa56e9 : 0;
            break;
        case #"magazine":
            var_639f35c4 = (isdefined(settings.var_c1b38db7) ? settings.var_c1b38db7 : 0, isdefined(settings.var_f5f1f633) ? settings.var_f5f1f633 : 0, isdefined(settings.var_e42f52ae) ? settings.var_e42f52ae : 0);
            var_31d7e562 = (isdefined(settings.var_91fc7515) ? settings.var_91fc7515 : 0, isdefined(settings.var_80a5d268) ? settings.var_80a5d268 : 0, isdefined(settings.var_5ed38ec4) ? settings.var_5ed38ec4 : 0);
            var_3245d5de = isdefined(settings.var_b41f3012) ? settings.var_b41f3012 : 0;
            break;
        case #"handle":
            var_639f35c4 = (isdefined(settings.var_41ebb7d) ? settings.var_41ebb7d : 0, isdefined(settings.var_ab648ac) ? settings.var_ab648ac : 0, isdefined(settings.var_18806440) ? settings.var_18806440 : 0);
            var_31d7e562 = (isdefined(settings.var_59c4fda9) ? settings.var_59c4fda9 : 0, isdefined(settings.var_ebd421b9) ? settings.var_ebd421b9 : 0, isdefined(settings.var_5983fd1b) ? settings.var_5983fd1b : 0);
            var_3245d5de = isdefined(settings.var_52846704) ? settings.var_52846704 : 0;
            break;
        }
        var_5ac895fb.origin += var_639f35c4;
        var_5ac895fb.angles += var_31d7e562;
        var_5ac895fb.scale = isdefined(settings.var_9c241dd8) ? settings.var_9c241dd8 : 1;
        if (isdefined(var_3245d5de)) {
            var_5ac895fb.scale += var_3245d5de;
        }
    }
    var_5ac895fb.var_402cbe2d = settings.var_6b6e0c5a;
    return var_5ac895fb;
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0x66416470, Offset: 0x6cf0
// Size: 0xd4a
function function_3bff05ba(weapon, var_8a4ba442, localclientnum = 0) {
    settings = function_34668e22(weapon);
    var_f3d83915 = (0, 0, 0);
    var_dd6869e3 = (0, 0, 0);
    if (function_cd84dead(weapon, "barrel") && function_cd84dead(weapon, "muzzle")) {
        var_f3d83915 = (isdefined(settings.var_d58892) ? settings.var_d58892 : 0, isdefined(settings.var_80c00869) ? settings.var_80c00869 : 0, isdefined(settings.var_ee9ae41d) ? settings.var_ee9ae41d : 0);
        var_dd6869e3 = (isdefined(settings.var_acdc6bf0) ? settings.var_acdc6bf0 : 0, isdefined(settings.var_9e8acf4d) ? settings.var_9e8acf4d : 0, isdefined(settings.var_fa188663) ? settings.var_fa188663 : 0);
        var_d098ea88 = isdefined(settings.var_7bba1c55) ? settings.var_7bba1c55 : 0;
    } else if (function_cd84dead(weapon, "muzzle")) {
        var_f3d83915 = (isdefined(settings.var_b633cdaf) ? settings.var_b633cdaf : 0, isdefined(settings.var_dad616fb) ? settings.var_dad616fb : 0, isdefined(settings.var_e88bb266) ? settings.var_e88bb266 : 0);
        var_dd6869e3 = (isdefined(settings.var_6a09650) ? settings.var_6a09650 : 0, isdefined(settings.var_18e1bad2) ? settings.var_18e1bad2 : 0, isdefined(settings.var_50dbaae9) ? settings.var_50dbaae9 : 0);
        var_d098ea88 = isdefined(settings.var_ab56153b) ? settings.var_ab56153b : 0;
    } else if (function_cd84dead(weapon, "barrel")) {
        var_f3d83915 = (isdefined(settings.var_50e7f41f) ? settings.var_50e7f41f : 0, isdefined(settings.var_3fa15192) ? settings.var_3fa15192 : 0, isdefined(settings.var_7590bd70) ? settings.var_7590bd70 : 0);
        var_dd6869e3 = (isdefined(settings.var_892173b6) ? settings.var_892173b6 : 0, isdefined(settings.var_7adad729) ? settings.var_7adad729 : 0, isdefined(settings.var_548b8a8b) ? settings.var_548b8a8b : 0);
        var_d098ea88 = isdefined(settings.var_a8f47ab) ? settings.var_a8f47ab : 0;
    } else if (function_cd84dead(weapon, "stock")) {
        var_f3d83915 = (isdefined(settings.var_ec765089) ? settings.var_ec765089 : 0, isdefined(settings.var_3ba0eee1) ? settings.var_3ba0eee1 : 0, isdefined(settings.var_ca0b8bb4) ? settings.var_ca0b8bb4 : 0);
        var_dd6869e3 = (isdefined(settings.var_8290a87e) ? settings.var_8290a87e : 0, isdefined(settings.var_a8c7f4ec) ? settings.var_a8c7f4ec : 0, isdefined(settings.var_5fa9e2b1) ? settings.var_5fa9e2b1 : 0);
        var_d098ea88 = isdefined(settings.var_f5a9d911) ? settings.var_f5a9d911 : 0;
    }
    var_2cbf4808 = struct::spawn((isdefined(settings.var_6ee0b1d8) ? settings.var_6ee0b1d8 : 0, isdefined(settings.var_5cae8d74) ? settings.var_5cae8d74 : 0, isdefined(settings.var_8934e680) ? settings.var_8934e680 : 0), (isdefined(settings.var_cf03cb96) ? settings.var_cf03cb96 : 0, isdefined(settings.var_4f264bd9) ? settings.var_4f264bd9 : 0, isdefined(settings.var_84f7b77f) ? settings.var_84f7b77f : 0));
    var_2cbf4808.origin += var_f3d83915;
    var_2cbf4808.angles += var_dd6869e3;
    var_2cbf4808.scale = isdefined(settings.var_a31af46c) ? settings.var_a31af46c : 1;
    if (isdefined(var_d098ea88)) {
        var_2cbf4808.scale += var_d098ea88;
    }
    var_2cbf4808.var_697bf2ff = settings.var_a20b23a4;
    var_2cbf4808.var_402cbe2d = settings.var_6b6e0c5a;
    if (is_true(weapon.islauncher) && (var_8a4ba442 === #"secondary" || var_8a4ba442 === #"primary" && !function_4dcbc16b(localclientnum, var_8a4ba442, weapon))) {
        var_2cbf4808.var_697bf2ff = undefined;
    }
    if (var_8a4ba442 === #"primary" || var_8a4ba442 == #"secondary") {
        var_7975e84f = var_2cbf4808.origin;
        if (!function_b8990106(localclientnum, var_8a4ba442, weapon)) {
            var_f617db00 = 1;
        }
    } else {
        var_7975e84f = (0, 0, 0);
    }
    if (is_true(var_f617db00)) {
        var_2cbf4808.var_a5946026 = var_7975e84f + (isdefined(settings.var_a29aa4a) ? settings.var_a29aa4a : 0, isdefined(settings.var_fc750ee1) ? settings.var_fc750ee1 : 0, isdefined(settings.var_2ec07377) ? settings.var_2ec07377 : 0);
        var_2cbf4808.var_a7adf514 = var_7975e84f + (isdefined(settings.var_9326937c) ? settings.var_9326937c : 0, isdefined(settings.var_b154cfd8) ? settings.var_b154cfd8 : 0, isdefined(settings.var_db89243c) ? settings.var_db89243c : 0);
        var_2cbf4808.var_36859b17 = var_7975e84f + (isdefined(settings.var_91d3fe8f) ? settings.var_91d3fe8f : 0, isdefined(settings.var_7f0d5902) ? settings.var_7f0d5902 : 0, isdefined(settings.var_2d4fb580) ? settings.var_2d4fb580 : 0);
        if (is_true(weapon.islauncher)) {
            if (var_8a4ba442 === #"primary" && function_4dcbc16b(localclientnum, var_8a4ba442, weapon)) {
                var_2cbf4808.origin += (isdefined(settings.var_ac657f76) ? settings.var_ac657f76 : 0, isdefined(settings.var_e130690b) ? settings.var_e130690b : 0, isdefined(settings.var_87eeb689) ? settings.var_87eeb689 : 0);
                var_2cbf4808.angles += (isdefined(settings.var_6d848856) ? settings.var_6d848856 : 0, isdefined(settings.var_a13b6fc3) ? settings.var_a13b6fc3 : 0, isdefined(settings.var_8b0e4369) ? settings.var_8b0e4369 : 0);
            }
        } else {
            var_2cbf4808.origin += (isdefined(settings.var_ac657f76) ? settings.var_ac657f76 : 0, isdefined(settings.var_e130690b) ? settings.var_e130690b : 0, isdefined(settings.var_87eeb689) ? settings.var_87eeb689 : 0);
            var_2cbf4808.angles += (isdefined(settings.var_6d848856) ? settings.var_6d848856 : 0, isdefined(settings.var_a13b6fc3) ? settings.var_a13b6fc3 : 0, isdefined(settings.var_8b0e4369) ? settings.var_8b0e4369 : 0);
        }
    } else {
        var_2cbf4808.var_a5946026 = var_7975e84f + (isdefined(settings.var_b058b27b) ? settings.var_b058b27b : 0, isdefined(settings.var_13c87959) ? settings.var_13c87959 : 0, isdefined(settings.var_229096ed) ? settings.var_229096ed : 0);
        var_2cbf4808.var_a7adf514 = var_7975e84f + (isdefined(settings.var_c287975b) ? settings.var_c287975b : 0, isdefined(settings.var_f0b173ae) ? settings.var_f0b173ae : 0, isdefined(settings.var_9e06ce56) ? settings.var_9e06ce56 : 0);
        var_2cbf4808.var_36859b17 = var_7975e84f + (isdefined(settings.var_d0a96d99) ? settings.var_d0a96d99 : 0, isdefined(settings.var_bd3046a3) ? settings.var_bd3046a3 : 0, isdefined(settings.var_d0766d2f) ? settings.var_d0766d2f : 0);
    }
    return var_2cbf4808;
}

