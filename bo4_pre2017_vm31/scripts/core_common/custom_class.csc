#using scripts/core_common/ai/archetype_damage_effects;
#using scripts/core_common/ai/systems/destructible_character;
#using scripts/core_common/ai/zombie;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/character_customization;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/exploder_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/multi_extracam;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace customclass;

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xf63b255a, Offset: 0x5d0
// Size: 0x24
function localclientconnect(localclientnum) {
    level thread custom_class_init(localclientnum);
}

// Namespace customclass/custom_class
// Params 0, eflags: 0x0
// Checksum 0x8996e966, Offset: 0x600
// Size: 0x154
function init() {
    level.weapon_script_model = [];
    level.preload_weapon_model = [];
    level.last_weapon_name = [];
    level.current_weapon = [];
    level.attachment_names = [];
    level.var_ac376924 = [];
    level.paintshophiddenposition = [];
    level.camo_index = [];
    level.reticle_index = [];
    level.show_player_tag = [];
    level.show_emblem = [];
    level.preload_weapon_complete = [];
    level.preload_weapon_complete = [];
    level.weapon_clientscript_cac_model = [];
    level.weaponnone = getweapon("none");
    refeshweaponposition();
    duplicate_render::set_dr_filter_offscreen("cac_locked_weapon", 10, "cac_locked_weapon", undefined, 2, "mc/sonar_frontend_locked_gun", 1);
}

// Namespace customclass/custom_class
// Params 0, eflags: 0x0
// Checksum 0xd9e1b366, Offset: 0x760
// Size: 0x60
function refeshweaponposition() {
    if (lui::function_ba479141()) {
        level.weapon_position = struct::get("paintshop_weapon_position");
        return;
    }
    level.weapon_position = struct::get("paintshop_weapon_position");
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x70ca1b82, Offset: 0x7c8
// Size: 0x6c
function custom_class_init(localclientnum) {
    level.last_weapon_name[localclientnum] = "";
    level.current_weapon[localclientnum] = undefined;
    level thread custom_class_start_threads(localclientnum);
    level thread handle_cac_customization(localclientnum);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xb52fc4cc, Offset: 0x840
// Size: 0xc2
function custom_class_start_threads(localclientnum) {
    level endon(#"disconnect");
    while (true) {
        level thread custom_class_update(localclientnum);
        level thread custom_class_attachment_select_focus(localclientnum);
        level thread custom_class_remove(localclientnum);
        level thread custom_class_closed(localclientnum);
        level waittill("CustomClass_update" + localclientnum, "CustomClass_focus" + localclientnum, "CustomClass_remove" + localclientnum, "CustomClass_closed" + localclientnum);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xbbafc428, Offset: 0x910
// Size: 0xc6
function handle_cac_customization(localclientnum) {
    level endon(#"disconnect");
    self.lastxcam = [];
    self.lastsubxcam = [];
    self.lastnotetrack = [];
    while (true) {
        level thread handle_cac_customization_focus(localclientnum);
        level thread function_db76bfd5(localclientnum);
        level thread function_ade2f410(localclientnum);
        level thread handle_cac_customization_closed(localclientnum);
        level waittill("cam_customization_closed" + localclientnum);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x3017e449, Offset: 0x9e0
// Size: 0x40c
function custom_class_update(localclientnum) {
    level endon(#"disconnect");
    level endon("CustomClass_focus" + localclientnum);
    level endon("CustomClass_remove" + localclientnum);
    level endon("CustomClass_closed" + localclientnum);
    waitresult = level waittill("CustomClass_update" + localclientnum);
    base_weapon_slot = waitresult.base_weapon_slot;
    var_dacb3c7 = waitresult.weapon;
    camera = waitresult.camera;
    weapon_options_param = waitresult.options;
    var_cf4497db = waitresult.var_c4d24b45;
    is_item_unlocked = waitresult.is_item_unlocked;
    var_40e5de05 = waitresult.var_40e5de05;
    if (!isdefined(is_item_unlocked)) {
        is_item_unlocked = 1;
    }
    if (!isdefined(var_40e5de05)) {
        var_40e5de05 = 0;
    }
    if (isdefined(var_dacb3c7)) {
        if (isdefined(var_cf4497db) && var_cf4497db != "none") {
            function_2632634e(localclientnum, var_cf4497db);
        }
        if (isdefined(weapon_options_param) && weapon_options_param != "none") {
            function_f3037b75(localclientnum, weapon_options_param);
        }
        postfx::setfrontendstreamingoverlay(localclientnum, "cac", 1);
        position = level.weapon_position;
        if (!isdefined(level.weapon_script_model[localclientnum])) {
            level.weapon_script_model[localclientnum] = spawn_weapon_model(localclientnum, position.origin, position.angles);
            level.preload_weapon_model[localclientnum] = spawn_weapon_model(localclientnum, position.origin, position.angles);
            level.preload_weapon_model[localclientnum] hide();
        }
        toggle_locked_weapon_shader(localclientnum, is_item_unlocked);
        function_db89bd0c(localclientnum, is_item_unlocked && var_40e5de05);
        update_weapon_script_model(localclientnum, var_dacb3c7, undefined, is_item_unlocked, var_40e5de05);
        level notify(#"xcammoved");
        lerpduration = get_lerp_duration(camera);
        setup_paintshop_bg(localclientnum, camera);
        level transition_camera_immediate(localclientnum, base_weapon_slot, "cam_cac_weapon", "cam_cac", lerpduration, camera);
        return;
    }
    if (isdefined(waitresult.state) && waitresult.state == "purchased") {
        function_db89bd0c(localclientnum, 0);
    }
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0x96a097ba, Offset: 0xdf8
// Size: 0x8c
function toggle_locked_weapon_shader(localclientnum, is_item_unlocked) {
    if (!isdefined(is_item_unlocked)) {
        is_item_unlocked = 1;
    }
    if (!isdefined(level.weapon_script_model[localclientnum])) {
        return;
    }
    if (is_item_unlocked != 1) {
        enablefrontendlockedweaponoverlay(localclientnum, 1);
        return;
    }
    enablefrontendlockedweaponoverlay(localclientnum, 0);
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0xe0a978bf, Offset: 0xe90
// Size: 0x84
function function_db89bd0c(localclientnum, var_40e5de05) {
    if (!isdefined(var_40e5de05)) {
        var_40e5de05 = 0;
    }
    if (!isdefined(level.weapon_script_model[localclientnum])) {
        return;
    }
    if (var_40e5de05) {
        enablefrontendtokenlockedweaponoverlay(localclientnum, 1);
        return;
    }
    enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xcaac12ac, Offset: 0xf20
// Size: 0x90
function is_optic(attachmentname) {
    csv_filename = "gamedata/weapons/common/attachmentTable.csv";
    row = tablelookuprownum(csv_filename, 4, attachmentname);
    if (row > -1) {
        group = tablelookupcolumnforrow(csv_filename, row, 2);
        return (group == "optic");
    }
    return false;
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x802c3513, Offset: 0xfb8
// Size: 0x364
function custom_class_attachment_select_focus(localclientnum) {
    level endon(#"disconnect");
    level endon("CustomClass_update" + localclientnum);
    level endon("CustomClass_remove" + localclientnum);
    level endon("CustomClass_closed" + localclientnum);
    waitresult = level waittill("CustomClass_focus" + localclientnum);
    level endon("CustomClass_focus" + localclientnum);
    base_weapon_slot = waitresult.base_weapon_slot;
    var_dacb3c7 = waitresult.weapon;
    attachment = waitresult.attachment;
    weapon_options_param = waitresult.options;
    var_cf4497db = waitresult.var_c4d24b45;
    donotmovecamera = waitresult.do_no_move_camera;
    update_weapon_options = 0;
    weaponattachmentintersection = get_attachments_intersection(level.last_weapon_name[localclientnum], var_dacb3c7);
    if (isdefined(var_cf4497db) && var_cf4497db != "none") {
        function_2632634e(localclientnum, var_cf4497db);
    }
    initialdelay = 0.3;
    lerpduration = 400;
    if (is_optic(attachment)) {
        initialdelay = 0;
        lerpduration = 200;
    }
    preload_weapon_model(localclientnum, weaponattachmentintersection, update_weapon_options);
    wait_preload_weapon(localclientnum);
    update_weapon_script_model(localclientnum, weaponattachmentintersection, update_weapon_options);
    if (var_dacb3c7 == weaponattachmentintersection) {
        var_dacb3c7 = undefined;
    }
    if (isdefined(donotmovecamera) && donotmovecamera) {
        if (isdefined(var_dacb3c7)) {
            preload_weapon_model(localclientnum, var_dacb3c7, 0);
            wait initialdelay;
            wait_preload_weapon(localclientnum);
            update_weapon_script_model(localclientnum, var_dacb3c7, 0);
        }
    } else {
        level thread transition_camera(localclientnum, base_weapon_slot, "cam_cac_attachments", "cam_cac", initialdelay, lerpduration, attachment, var_dacb3c7);
    }
    if (isdefined(weapon_options_param) && weapon_options_param != "none") {
        function_f3037b75(localclientnum, weapon_options_param);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x3d788568, Offset: 0x1328
// Size: 0x1a6
function custom_class_remove(localclientnum) {
    level endon(#"disconnect");
    level endon("CustomClass_update" + localclientnum);
    level endon("CustomClass_focus" + localclientnum);
    level endon("CustomClass_closed" + localclientnum);
    level waittill("CustomClass_remove" + localclientnum);
    postfx::setfrontendstreamingoverlay(localclientnum, "cac", 0);
    enablefrontendlockedweaponoverlay(localclientnum, 0);
    enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
    position = level.weapon_position;
    camera = "select01";
    xcamname = "ui_cam_cac_ar_standard";
    playmaincamxcam(localclientnum, xcamname, 0, "cam_cac", camera, position.origin, position.angles);
    setup_paintshop_bg(localclientnum, camera);
    if (isdefined(level.weapon_script_model[localclientnum])) {
        level.weapon_script_model[localclientnum] forcedelete();
    }
    level.last_weapon_name[localclientnum] = "";
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x1c67a6d9, Offset: 0x14d8
// Size: 0x116
function custom_class_closed(localclientnum) {
    level endon(#"disconnect");
    level endon("CustomClass_update" + localclientnum);
    level endon("CustomClass_focus" + localclientnum);
    level endon("CustomClass_remove" + localclientnum);
    level waittill("CustomClass_closed" + localclientnum);
    if (isdefined(level.weapon_script_model[localclientnum])) {
        level.weapon_script_model[localclientnum] forcedelete();
    }
    postfx::setfrontendstreamingoverlay(localclientnum, "cac", 0);
    enablefrontendlockedweaponoverlay(localclientnum, 0);
    enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
    level.last_weapon_name[localclientnum] = "";
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0xc4aa97aa, Offset: 0x15f8
// Size: 0x84
function spawn_weapon_model(localclientnum, origin, angles) {
    weapon_model = spawn(localclientnum, origin, "script_model");
    weapon_model sethighdetail(1, 1);
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    return weapon_model;
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0x3d98b1b5, Offset: 0x1688
// Size: 0x120
function function_2632634e(localclientnum, var_cf4497db) {
    var_5a183cc0 = strtok(var_cf4497db, ",");
    level.attachment_names[localclientnum] = [];
    level.var_ac376924[localclientnum] = [];
    for (i = 0; i + 1 < var_5a183cc0.size; i += 2) {
        level.attachment_names[localclientnum][level.attachment_names[localclientnum].size] = var_5a183cc0[i];
        level.var_ac376924[localclientnum][level.var_ac376924[localclientnum].size] = int(var_5a183cc0[i + 1]);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x9462fcdf, Offset: 0x17b0
// Size: 0xcc
function hide_paintshop_bg(localclientnum) {
    paintshop_bg = getent(localclientnum, "paintshop_black", "targetname");
    if (isdefined(paintshop_bg)) {
        if (!isdefined(level.paintshophiddenposition[localclientnum])) {
            level.paintshophiddenposition[localclientnum] = paintshop_bg.origin;
        }
        paintshop_bg hide();
        paintshop_bg moveto(level.paintshophiddenposition[localclientnum], 0.01);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x7339f724, Offset: 0x1888
// Size: 0xa4
function show_paintshop_bg(localclientnum) {
    paintshop_bg = getent(localclientnum, "paintshop_black", "targetname");
    if (isdefined(paintshop_bg)) {
        paintshop_bg show();
        paintshop_bg moveto(level.paintshophiddenposition[localclientnum] + (0, 0, 227), 0.01);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xe4931af8, Offset: 0x1938
// Size: 0x48
function get_camo_index(localclientnum) {
    if (!isdefined(level.camo_index[localclientnum])) {
        level.camo_index[localclientnum] = 0;
    }
    return level.camo_index[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xcac2b952, Offset: 0x1988
// Size: 0x48
function get_reticle_index(localclientnum) {
    if (!isdefined(level.reticle_index[localclientnum])) {
        level.reticle_index[localclientnum] = 0;
    }
    return level.reticle_index[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x27267167, Offset: 0x19d8
// Size: 0x48
function function_bcfb8776(localclientnum) {
    if (!isdefined(level.show_player_tag[localclientnum])) {
        level.show_player_tag[localclientnum] = 0;
    }
    return level.show_player_tag[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x43795e37, Offset: 0x1a28
// Size: 0x48
function get_show_emblem(localclientnum) {
    if (!isdefined(level.show_emblem[localclientnum])) {
        level.show_emblem[localclientnum] = 0;
    }
    return level.show_emblem[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xb8aa5262, Offset: 0x1a78
// Size: 0x48
function get_show_paintshop(localclientnum) {
    if (!isdefined(level.show_paintshop[localclientnum])) {
        level.show_paintshop[localclientnum] = 0;
    }
    return level.show_paintshop[localclientnum];
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0x50638c50, Offset: 0x1ac8
// Size: 0x1ac
function function_f3037b75(localclientnum, weapon_options_param) {
    weapon_options = strtok(weapon_options_param, ",");
    level.camo_index[localclientnum] = int(weapon_options[0]);
    level.show_player_tag[localclientnum] = 0;
    level.show_emblem[localclientnum] = 0;
    level.reticle_index[localclientnum] = int(weapon_options[1]);
    level.show_paintshop[localclientnum] = int(weapon_options[2]);
    if (isdefined(weapon_options) && isdefined(level.weapon_script_model[localclientnum])) {
        level.weapon_script_model[localclientnum] setweaponrenderoptions(get_camo_index(localclientnum), get_reticle_index(localclientnum), function_bcfb8776(localclientnum), get_show_emblem(localclientnum), get_show_paintshop(localclientnum));
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xafb57d31, Offset: 0x1c80
// Size: 0xa8
function get_lerp_duration(camera) {
    lerpduration = 0;
    if (isdefined(camera)) {
        paintshopcameracloseup = camera == "left" || camera == "right" || camera == "top" || camera == "paintshop_preview_left" || camera == "paintshop_preview_right" || camera == "paintshop_preview_top";
        if (paintshopcameracloseup) {
            lerpduration = 500;
        }
    }
    return lerpduration;
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0x36a731f, Offset: 0x1d30
// Size: 0x19c
function setup_paintshop_bg(localclientnum, camera) {
    if (isdefined(camera)) {
        paintshopcameracloseup = camera == "left" || camera == "right" || camera == "top" || camera == "paintshop_preview_left" || camera == "paintshop_preview_right" || camera == "paintshop_preview_top";
        playradiantexploder(localclientnum, "weapon_kick");
        if (paintshopcameracloseup) {
            show_paintshop_bg(localclientnum);
            killradiantexploder(localclientnum, "lights_paintshop");
            killradiantexploder(localclientnum, "weapon_kick");
            playradiantexploder(localclientnum, "lights_paintshop_zoom");
            return;
        }
        hide_paintshop_bg(localclientnum);
        killradiantexploder(localclientnum, "lights_paintshop_zoom");
        playradiantexploder(localclientnum, "lights_paintshop");
        playradiantexploder(localclientnum, "weapon_kick");
    }
}

// Namespace customclass/custom_class
// Params 6, eflags: 0x0
// Checksum 0x7b104af7, Offset: 0x1ed8
// Size: 0x29c
function transition_camera_immediate(localclientnum, weapontype, camera, subxcam, lerpduration, notetrack) {
    xcam = getweaponxcam(level.current_weapon[localclientnum], camera);
    if (!isdefined(xcam)) {
        if (strstartswith(weapontype, "specialty")) {
            xcam = "ui_cam_cac_perk";
        } else if (strstartswith(weapontype, "bonuscard")) {
            xcam = "ui_cam_cac_wildcard";
        } else if (strstartswith(weapontype, "cybercore") || strstartswith(weapontype, "cybercom")) {
            xcam = "ui_cam_cac_perk";
        } else if (strstartswith(weapontype, "bubblegum")) {
            xcam = "ui_cam_cac_bgb";
        } else {
            xcam = getweaponxcam(getweapon("ar_standard"), camera);
        }
    }
    self.lastxcam[weapontype] = xcam;
    self.lastsubxcam[weapontype] = subxcam;
    self.lastnotetrack[weapontype] = notetrack;
    position = level.weapon_position;
    model = level.weapon_script_model[localclientnum];
    playmaincamxcam(localclientnum, xcam, lerpduration, subxcam, notetrack, position.origin, position.angles, model, position.origin, position.angles);
    if (notetrack == "top" || notetrack == "right" || notetrack == "left") {
        setallowxcamrightstickrotation(localclientnum, 0);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x984467af, Offset: 0x2180
// Size: 0x3a
function wait_preload_weapon(localclientnum) {
    if (level.preload_weapon_complete[localclientnum]) {
        return;
    }
    level waittill("preload_weapon_complete_" + localclientnum);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xa9698ef3, Offset: 0x21c8
// Size: 0xa0
function preload_weapon_watcher(localclientnum) {
    level endon("preload_weapon_changing_" + localclientnum);
    level endon("preload_weapon_complete_" + localclientnum);
    while (true) {
        if (level.preload_weapon_model[localclientnum] isstreamed()) {
            level.preload_weapon_complete[localclientnum] = 1;
            level notify("preload_weapon_complete_" + localclientnum);
            return;
        }
        wait 0.1;
    }
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0x90da8da9, Offset: 0x2270
// Size: 0x2cc
function preload_weapon_model(localclientnum, newweaponstring, should_update_weapon_options) {
    if (!isdefined(should_update_weapon_options)) {
        should_update_weapon_options = 1;
    }
    level notify("preload_weapon_changing_" + localclientnum);
    level.preload_weapon_complete[localclientnum] = 0;
    current_weapon = getweaponwithattachments(newweaponstring);
    if (current_weapon == level.weaponnone) {
        level.preload_weapon_complete[localclientnum] = 1;
        level notify("preload_weapon_complete_" + localclientnum);
        return;
    }
    if (isdefined(current_weapon.frontendmodel)) {
        level.preload_weapon_model[localclientnum] useweaponmodel(current_weapon, current_weapon.frontendmodel);
    } else {
        level.preload_weapon_model[localclientnum] useweaponmodel(current_weapon);
    }
    if (isdefined(level.preload_weapon_model[localclientnum])) {
        if (isdefined(level.attachment_names[localclientnum]) && isdefined(level.var_ac376924[localclientnum])) {
            for (i = 0; i < level.attachment_names[localclientnum].size; i++) {
                level.preload_weapon_model[localclientnum] setattachmentcosmeticvariantindex(newweaponstring, level.attachment_names[localclientnum][i], level.var_ac376924[localclientnum][i]);
            }
        }
        if (should_update_weapon_options) {
            level.preload_weapon_model[localclientnum] setweaponrenderoptions(get_camo_index(localclientnum), get_reticle_index(localclientnum), function_bcfb8776(localclientnum), get_show_emblem(localclientnum), get_show_paintshop(localclientnum));
        }
    }
    level thread preload_weapon_watcher(localclientnum);
}

// Namespace customclass/custom_class
// Params 5, eflags: 0x0
// Checksum 0xcfeb12ea, Offset: 0x2548
// Size: 0x444
function update_weapon_script_model(localclientnum, newweaponstring, should_update_weapon_options, is_item_unlocked, var_40e5de05) {
    if (!isdefined(should_update_weapon_options)) {
        should_update_weapon_options = 1;
    }
    if (!isdefined(is_item_unlocked)) {
        is_item_unlocked = 1;
    }
    if (!isdefined(var_40e5de05)) {
        var_40e5de05 = 0;
    }
    level.last_weapon_name[localclientnum] = newweaponstring;
    level.current_weapon[localclientnum] = getweaponwithattachments(level.last_weapon_name[localclientnum]);
    if (level.current_weapon[localclientnum] == level.weaponnone) {
        level.weapon_script_model[localclientnum] delete();
        position = level.weapon_position;
        level.weapon_script_model[localclientnum] = spawn_weapon_model(localclientnum, position.origin, position.angles);
        toggle_locked_weapon_shader(localclientnum, is_item_unlocked);
        function_db89bd0c(localclientnum, is_item_unlocked && var_40e5de05);
        level.weapon_script_model[localclientnum] setmodel(level.last_weapon_name[localclientnum]);
        level.weapon_script_model[localclientnum] setdedicatedshadow(1);
        return;
    }
    if (isdefined(level.current_weapon[localclientnum].frontendmodel)) {
        level.weapon_script_model[localclientnum] useweaponmodel(level.current_weapon[localclientnum], level.current_weapon[localclientnum].frontendmodel);
    } else {
        level.weapon_script_model[localclientnum] useweaponmodel(level.current_weapon[localclientnum]);
    }
    if (isdefined(level.weapon_script_model[localclientnum])) {
        if (isdefined(level.attachment_names[localclientnum]) && isdefined(level.var_ac376924[localclientnum])) {
            for (i = 0; i < level.attachment_names[localclientnum].size; i++) {
                level.weapon_script_model[localclientnum] setattachmentcosmeticvariantindex(newweaponstring, level.attachment_names[localclientnum][i], level.var_ac376924[localclientnum][i]);
            }
        }
        if (should_update_weapon_options) {
            level.weapon_script_model[localclientnum] setweaponrenderoptions(get_camo_index(localclientnum), get_reticle_index(localclientnum), function_bcfb8776(localclientnum), get_show_emblem(localclientnum), get_show_paintshop(localclientnum));
        }
    }
    level.weapon_script_model[localclientnum] setdedicatedshadow(1);
}

// Namespace customclass/custom_class
// Params 9, eflags: 0x0
// Checksum 0x8a227d09, Offset: 0x2998
// Size: 0x13c
function transition_camera(localclientnum, weapontype, camera, subxcam, initialdelay, lerpduration, notetrack, newweaponstring, should_update_weapon_options) {
    if (!isdefined(should_update_weapon_options)) {
        should_update_weapon_options = 0;
    }
    self endon(#"death");
    self notify(#"xcammoved");
    self endon(#"xcammoved");
    level endon(#"cam_customization_closed");
    if (isdefined(newweaponstring)) {
        preload_weapon_model(localclientnum, newweaponstring, should_update_weapon_options);
    }
    wait initialdelay;
    transition_camera_immediate(localclientnum, weapontype, camera, subxcam, lerpduration, notetrack);
    if (isdefined(newweaponstring)) {
        wait lerpduration / 1000;
        wait_preload_weapon(localclientnum);
        update_weapon_script_model(localclientnum, newweaponstring, should_update_weapon_options);
    }
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0xd12f0bc6, Offset: 0x2ae0
// Size: 0x11c
function get_attachments_intersection(oldweapon, newweapon) {
    if (!isdefined(oldweapon)) {
        return newweapon;
    }
    var_76a49db6 = strtok(oldweapon, "+");
    var_e1181707 = strtok(newweapon, "+");
    if (var_76a49db6[0] != var_e1181707[0]) {
        return newweapon;
    }
    newweaponstring = var_e1181707[0];
    for (i = 1; i < var_e1181707.size; i++) {
        if (isinarray(var_76a49db6, var_e1181707[i])) {
            newweaponstring += "+" + var_e1181707[i];
        }
    }
    return newweaponstring;
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xa0174f7a, Offset: 0x2c08
// Size: 0x110
function handle_cac_customization_focus(localclientnum) {
    level endon(#"disconnect");
    level endon("cam_customization_closed" + localclientnum);
    while (true) {
        waitresult = level waittill("cam_customization_focus" + localclientnum);
        base_weapon_slot = waitresult.base_weapon_slot;
        notetrack = waitresult.notetrack;
        if (isdefined(level.weapon_script_model[localclientnum])) {
            should_update_weapon_options = 1;
            level thread transition_camera(localclientnum, base_weapon_slot, "cam_cac_weapon", "cam_cac", 0.3, 400, notetrack, level.last_weapon_name[localclientnum], should_update_weapon_options);
        }
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x860e2a0e, Offset: 0x2d20
// Size: 0x238
function function_db76bfd5(localclientnum) {
    level endon(#"disconnect");
    level endon("cam_customization_closed" + localclientnum);
    while (true) {
        waitresult = level waittill("cam_customization_wo" + localclientnum);
        var_d01f310b = waitresult.var_d01f310b;
        var_f19f1a0d = waitresult.var_f19f1a0d;
        var_a7708f26 = waitresult.var_a7708f26;
        if (isdefined(level.weapon_script_model[localclientnum])) {
            if (isdefined(var_a7708f26) && var_a7708f26) {
                var_f19f1a0d = 0;
            }
            switch (var_d01f310b) {
            case #"camo":
                level.camo_index[localclientnum] = int(var_f19f1a0d);
                break;
            case #"reticle":
                level.reticle_index[localclientnum] = int(var_f19f1a0d);
                break;
            case #"paintjob":
                level.show_paintshop[localclientnum] = int(var_f19f1a0d);
                break;
            default:
                break;
            }
            level.weapon_script_model[localclientnum] setweaponrenderoptions(get_camo_index(localclientnum), get_reticle_index(localclientnum), function_bcfb8776(localclientnum), get_show_emblem(localclientnum), get_show_paintshop(localclientnum));
        }
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x16f5f98d, Offset: 0x2f60
// Size: 0x188
function function_ade2f410(localclientnum) {
    level endon(#"disconnect");
    level endon("cam_customization_closed" + localclientnum);
    while (true) {
        waitresult = level waittill("cam_customization_acv" + localclientnum);
        var_d1a9fc4f = waitresult.var_d1a9fc4f;
        var_73feac4c = waitresult.var_73feac4c;
        for (i = 0; i < level.attachment_names[localclientnum].size; i++) {
            if (level.attachment_names[localclientnum][i] == var_d1a9fc4f) {
                level.var_ac376924[localclientnum][i] = int(var_73feac4c);
                break;
            }
        }
        if (isdefined(level.weapon_script_model[localclientnum])) {
            level.weapon_script_model[localclientnum] setattachmentcosmeticvariantindex(level.last_weapon_name[localclientnum], var_d1a9fc4f, int(var_73feac4c));
        }
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xef4eae00, Offset: 0x30f0
// Size: 0x1c6
function handle_cac_customization_closed(localclientnum) {
    level endon(#"disconnect");
    level waittill("cam_customization_closed" + localclientnum);
    if (isdefined(level.weapon_clientscript_cac_model[localclientnum]) && isdefined(level.weapon_clientscript_cac_model[localclientnum][level.var_26fcd0f0])) {
        level.weapon_clientscript_cac_model[localclientnum][level.var_26fcd0f0] setweaponrenderoptions(get_camo_index(localclientnum), get_reticle_index(localclientnum), function_bcfb8776(localclientnum), get_show_emblem(localclientnum), get_show_paintshop(localclientnum));
        for (i = 0; i < level.attachment_names[localclientnum].size; i++) {
            level.weapon_clientscript_cac_model[localclientnum][level.var_26fcd0f0] setattachmentcosmeticvariantindex(level.last_weapon_name[localclientnum], level.attachment_names[localclientnum][i], level.var_ac376924[localclientnum][i]);
        }
    }
}

