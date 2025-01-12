#using scripts\core_common\duplicaterender_mgr;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;

#namespace customclass;

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xbbd1d4e5, Offset: 0x300
// Size: 0x24
function localclientconnect(localclientnum) {
    level thread custom_class_init(localclientnum);
}

// Namespace customclass/custom_class
// Params 0, eflags: 0x0
// Checksum 0x6d96b891, Offset: 0x330
// Size: 0x124
function init() {
    level.weapon_script_model = [];
    level.preload_weapon_model = [];
    level.last_weapon_name = [];
    level.var_ae07d93f = [];
    level.current_weapon = [];
    level.attachment_names = [];
    level.paintshophiddenposition = [];
    level.camo_index = [];
    level.reticle_index = [];
    level.show_player_tag = [];
    level.show_emblem = [];
    level.preload_weapon_complete = [];
    level.preload_weapon_complete = [];
    level.weapon_clientscript_cac_model = [];
    level.weaponnone = getweapon(#"none");
    refeshweaponposition();
    duplicate_render::set_dr_filter_offscreen("cac_locked_weapon", 10, "cac_locked_weapon", undefined, 2, "mc/sonar_frontend_locked_gun", 1);
}

// Namespace customclass/custom_class
// Params 0, eflags: 0x0
// Checksum 0xfd80d23d, Offset: 0x460
// Size: 0x26
function refeshweaponposition() {
    level.weapon_position = struct::get("loadout_camera");
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x94716fe7, Offset: 0x490
// Size: 0x84
function custom_class_init(localclientnum) {
    level.last_weapon_name[localclientnum] = "";
    level.var_ae07d93f[localclientnum] = "";
    level.current_weapon[localclientnum] = undefined;
    level thread custom_class_start_threads(localclientnum);
    level thread handle_cac_customization(localclientnum);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x2a34e36e, Offset: 0x520
// Size: 0xf2
function custom_class_start_threads(localclientnum) {
    level endon(#"disconnect");
    while (true) {
        if (getdvarint(#"ui_enablecacscene", 0) == 0) {
            level thread custom_class_update(localclientnum);
            level thread custom_class_attachment_select_focus(localclientnum);
            level thread custom_class_remove(localclientnum);
            level thread custom_class_closed(localclientnum);
        }
        level waittill("CustomClass_update" + localclientnum, "CustomClass_focus" + localclientnum, "CustomClass_remove" + localclientnum, "CustomClass_closed" + localclientnum);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xd381e5e1, Offset: 0x620
// Size: 0xae
function handle_cac_customization(localclientnum) {
    level endon(#"disconnect");
    self.lastxcam = [];
    self.lastsubxcam = [];
    self.lastnotetrack = [];
    while (true) {
        level thread handle_cac_customization_focus(localclientnum);
        level thread function_db76bfd5(localclientnum);
        level thread handle_cac_customization_closed(localclientnum);
        level waittill("cam_customization_closed" + localclientnum);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xe893de25, Offset: 0x6d8
// Size: 0x3b4
function custom_class_update(localclientnum) {
    level endon(#"disconnect");
    level endon("CustomClass_focus" + localclientnum);
    level endon("CustomClass_remove" + localclientnum);
    level endon("CustomClass_closed" + localclientnum);
    waitresult = level waittill("CustomClass_update" + localclientnum);
    base_weapon_slot = waitresult.base_weapon_slot;
    var_a716620c = waitresult.weapon;
    attachments = waitresult.attachments;
    camera = waitresult.camera;
    weapon_options_param = waitresult.options;
    is_item_unlocked = waitresult.is_item_unlocked;
    var_40e5de05 = waitresult.var_40e5de05;
    if (!isdefined(is_item_unlocked)) {
        is_item_unlocked = 1;
    }
    if (!isdefined(var_40e5de05)) {
        var_40e5de05 = 0;
    }
    if (isdefined(var_a716620c)) {
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
        update_weapon_script_model(localclientnum, var_a716620c, attachments, undefined, is_item_unlocked, var_40e5de05);
        level notify(#"xcammoved");
        lerpduration = get_lerp_duration(camera);
        setup_paintshop_bg(localclientnum, camera);
        level transition_camera_immediate(localclientnum, base_weapon_slot, "cam_cac_weapon", "cam_cac", lerpduration, camera);
        setallowxcamrightstickrotation(localclientnum, !function_4175762e(camera));
        return;
    }
    if (isdefined(waitresult.state) && waitresult.state == "purchased") {
        function_db89bd0c(localclientnum, 0);
    }
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0x1a185cdf, Offset: 0xa98
// Size: 0x84
function toggle_locked_weapon_shader(localclientnum, is_item_unlocked = 1) {
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
// Checksum 0xce2ca0a3, Offset: 0xb28
// Size: 0x7c
function function_db89bd0c(localclientnum, var_40e5de05 = 0) {
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
// Checksum 0x39dc46e2, Offset: 0xbb0
// Size: 0x98
function is_optic(attachmentname) {
    csv_filename = #"gamedata/weapons/common/attachmenttable.csv";
    row = tablelookuprownum(csv_filename, 4, attachmentname);
    if (row > -1) {
        group = tablelookupcolumnforrow(csv_filename, row, 2);
        return (group == "optic");
    }
    return false;
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x354dbbf6, Offset: 0xc50
// Size: 0x304
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
    donotmovecamera = waitresult.do_no_move_camera;
    update_weapon_options = 0;
    weaponattachmentintersection = get_attachments_intersection(level.last_weapon_name[localclientnum], level.var_ae07d93f[localclientnum], attachments);
    initialdelay = 0.3;
    lerpduration = 400;
    if (is_optic(attachment)) {
        initialdelay = 0;
        lerpduration = 200;
    }
    preload_weapon_model(localclientnum, weapon_name, weaponattachmentintersection, update_weapon_options);
    wait_preload_weapon(localclientnum);
    update_weapon_script_model(localclientnum, weapon_name, weaponattachmentintersection, update_weapon_options);
    if (weapon_name == weaponattachmentintersection) {
        weapon_name = undefined;
    }
    if (isdefined(donotmovecamera) && donotmovecamera) {
        if (isdefined(weapon_name)) {
            preload_weapon_model(localclientnum, weapon_name, weaponattachmentintersection, 0);
            wait initialdelay;
            wait_preload_weapon(localclientnum);
            update_weapon_script_model(localclientnum, weapon_name, weaponattachmentintersection, 0);
        }
    } else {
        level thread transition_camera(localclientnum, base_weapon_slot, "cam_cac_attachments", "cam_cac", initialdelay, lerpduration, attachment, weapon_name, weaponattachmentintersection);
    }
    if (isdefined(weapon_options_param) && weapon_options_param != "none") {
        function_f3037b75(localclientnum, weapon_options_param);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x308870eb, Offset: 0xf60
// Size: 0x84
function function_286dd9f9(localclientnum) {
    level endon(#"disconnect");
    level endon("CustomClass_closed" + localclientnum);
    level endon("cam_customization_closed" + localclientnum);
    setexposureignoreteleport(localclientnum, 1);
    waitframe(1);
    setexposureignoreteleport(localclientnum, 0);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x1fd55b4c, Offset: 0xff0
// Size: 0x1e2
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
    level thread function_286dd9f9(localclientnum);
    playmaincamxcam(localclientnum, xcamname, 0, "cam_cac", camera, position.origin, position.angles);
    setup_paintshop_bg(localclientnum, camera);
    if (isdefined(level.weapon_script_model[localclientnum])) {
        level.weapon_script_model[localclientnum] forcedelete();
    }
    level.last_weapon_name[localclientnum] = "";
    level.var_ae07d93f[localclientnum] = "";
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xdf3efa56, Offset: 0x11e0
// Size: 0x16a
function custom_class_closed(localclientnum) {
    level endon(#"disconnect");
    level endon("CustomClass_update" + localclientnum);
    level endon("CustomClass_focus" + localclientnum);
    level endon("CustomClass_remove" + localclientnum);
    params = level waittill(#"customclass_closed");
    if (params.param1 == localclientnum) {
        if (isdefined(level.weapon_script_model[localclientnum])) {
            level.weapon_script_model[localclientnum] forcedelete();
        }
        postfx::setfrontendstreamingoverlay(localclientnum, "cac", 0);
        enablefrontendlockedweaponoverlay(localclientnum, 0);
        enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
        setexposureignoreteleport(localclientnum, 0);
        level.last_weapon_name[localclientnum] = "";
        level.var_ae07d93f[localclientnum] = "";
    }
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0x2f41ee41, Offset: 0x1358
// Size: 0x7e
function spawn_weapon_model(localclientnum, origin, angles) {
    weapon_model = spawn(localclientnum, origin, "script_model");
    weapon_model sethighdetail(1, 1);
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    return weapon_model;
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x11273d82, Offset: 0x13e0
// Size: 0xbc
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
// Checksum 0xbceed00c, Offset: 0x14a8
// Size: 0x94
function show_paintshop_bg(localclientnum) {
    paintshop_bg = getent(localclientnum, "paintshop_black", "targetname");
    if (isdefined(paintshop_bg)) {
        paintshop_bg show();
        paintshop_bg moveto(level.paintshophiddenposition[localclientnum] + (0, 0, 227), 0.01);
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x3a888328, Offset: 0x1548
// Size: 0x44
function get_camo_index(localclientnum) {
    if (!isdefined(level.camo_index[localclientnum])) {
        level.camo_index[localclientnum] = 0;
    }
    return level.camo_index[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x4c0ed999, Offset: 0x1598
// Size: 0x44
function get_reticle_index(localclientnum) {
    if (!isdefined(level.reticle_index[localclientnum])) {
        level.reticle_index[localclientnum] = 0;
    }
    return level.reticle_index[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x824c2e8a, Offset: 0x15e8
// Size: 0x60
function function_92d1857f(localclientnum) {
    if (!isdefined(level.var_d2def126)) {
        level.var_d2def126 = [];
    }
    if (!isdefined(level.var_d2def126[localclientnum])) {
        level.var_d2def126[localclientnum] = 0;
    }
    return level.var_d2def126[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xc4417589, Offset: 0x1650
// Size: 0x44
function function_a131ff92(localclientnum) {
    if (!isdefined(level.show_player_tag[localclientnum])) {
        level.show_player_tag[localclientnum] = 0;
    }
    return level.show_player_tag[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xb348240e, Offset: 0x16a0
// Size: 0x44
function get_show_emblem(localclientnum) {
    if (!isdefined(level.show_emblem[localclientnum])) {
        level.show_emblem[localclientnum] = 0;
    }
    return level.show_emblem[localclientnum];
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xd39e478b, Offset: 0x16f0
// Size: 0x44
function get_show_paintshop(localclientnum) {
    if (!isdefined(level.show_paintshop[localclientnum])) {
        level.show_paintshop[localclientnum] = 0;
    }
    return level.show_paintshop[localclientnum];
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0x39ee3b90, Offset: 0x1740
// Size: 0x19c
function function_f3037b75(localclientnum, weapon_options_param) {
    weapon_options = strtok(weapon_options_param, ",");
    level.camo_index[localclientnum] = int(weapon_options[0]);
    level.show_player_tag[localclientnum] = 0;
    level.show_emblem[localclientnum] = 0;
    level.reticle_index[localclientnum] = int(weapon_options[1]);
    level.show_paintshop[localclientnum] = int(weapon_options[2]);
    if (isdefined(weapon_options) && isdefined(level.weapon_script_model[localclientnum])) {
        level.weapon_script_model[localclientnum] setweaponrenderoptions(get_camo_index(localclientnum), get_reticle_index(localclientnum), function_92d1857f(localclientnum), function_a131ff92(localclientnum), get_show_emblem(localclientnum), get_show_paintshop(localclientnum));
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xd2474edc, Offset: 0x18e8
// Size: 0xb2
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
// Params 1, eflags: 0x0
// Checksum 0x9be0f443, Offset: 0x19a8
// Size: 0x7a
function function_4175762e(camera) {
    return camera == "left" || camera == "right" || camera == "top" || camera == "paintshop_preview_left" || camera == "paintshop_preview_right" || camera == "paintshop_preview_top";
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x0
// Checksum 0xa7965e28, Offset: 0x1a30
// Size: 0x144
function setup_paintshop_bg(localclientnum, camera) {
    if (isdefined(camera)) {
        playradiantexploder(localclientnum, "weapon_kick");
        if (function_4175762e(camera)) {
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
// Checksum 0x386c9c29, Offset: 0x1b80
// Size: 0x234
function transition_camera_immediate(localclientnum, weapontype, camera, subxcam, lerpduration, notetrack) {
    xcam = getweaponxcam(level.current_weapon[localclientnum], camera);
    if (!isdefined(xcam)) {
        if (strstartswith(weapontype, "tacticalgear")) {
            xcam = "ui_cam_cac_perk";
        } else if (strstartswith(weapontype, "cybercore") || strstartswith(weapontype, "cybercom")) {
            xcam = "ui_cam_cac_perk";
        } else if (strstartswith(weapontype, "bubblegum")) {
            xcam = "ui_cam_cac_bgb";
        } else {
            xcam = getweaponxcam(getweapon(#"ar_accurate_t8"), camera);
        }
    }
    self.lastxcam[weapontype] = xcam;
    self.lastsubxcam[weapontype] = subxcam;
    self.lastnotetrack[weapontype] = notetrack;
    position = level.weapon_position;
    model = level.weapon_script_model[localclientnum];
    level thread function_286dd9f9(localclientnum);
    playmaincamxcam(localclientnum, xcam, lerpduration, subxcam, notetrack, position.origin, position.angles, model, position.origin, position.angles);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xbddb79f, Offset: 0x1dc0
// Size: 0x3a
function wait_preload_weapon(localclientnum) {
    if (level.preload_weapon_complete[localclientnum]) {
        return;
    }
    level waittill("preload_weapon_complete_" + localclientnum);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x798ac716, Offset: 0x1e08
// Size: 0x98
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
// Params 4, eflags: 0x0
// Checksum 0xe7555ba9, Offset: 0x1ea8
// Size: 0x1fc
function preload_weapon_model(localclientnum, newweaponstring, var_d80099a1, should_update_weapon_options = 1) {
    level notify("preload_weapon_changing_" + localclientnum);
    level.preload_weapon_complete[localclientnum] = 0;
    current_weapon = getweapon(newweaponstring, strtok(var_d80099a1, "+"));
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
        if (should_update_weapon_options) {
            level.preload_weapon_model[localclientnum] setweaponrenderoptions(get_camo_index(localclientnum), get_reticle_index(localclientnum), function_92d1857f(localclientnum), function_a131ff92(localclientnum), get_show_emblem(localclientnum), get_show_paintshop(localclientnum));
        }
    }
    level thread preload_weapon_watcher(localclientnum);
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xc7f1c4ef, Offset: 0x20b0
// Size: 0x7c
function function_9db04136(localclientnum) {
    var_8e7f2f4e = createuimodel(getuimodelforcontroller(localclientnum), "WeaponAttachmentFlyout.entNum");
    var_cc05370b = self getentitynumber();
    setuimodelvalue(var_8e7f2f4e, var_cc05370b);
}

// Namespace customclass/custom_class
// Params 6, eflags: 0x0
// Checksum 0xec06b071, Offset: 0x2138
// Size: 0x404
function update_weapon_script_model(localclientnum, newweaponstring, var_d80099a1, should_update_weapon_options = 1, is_item_unlocked = 1, var_40e5de05 = 0) {
    level.last_weapon_name[localclientnum] = newweaponstring;
    level.var_ae07d93f[localclientnum] = var_d80099a1;
    level.current_weapon[localclientnum] = getweapon(level.last_weapon_name[localclientnum], strtok(level.var_ae07d93f[localclientnum], "+"));
    if (level.current_weapon[localclientnum] == level.weaponnone) {
        level.weapon_script_model[localclientnum] delete();
        position = level.weapon_position;
        level.weapon_script_model[localclientnum] = spawn_weapon_model(localclientnum, position.origin, position.angles);
        toggle_locked_weapon_shader(localclientnum, is_item_unlocked);
        function_db89bd0c(localclientnum, is_item_unlocked && var_40e5de05);
        level.weapon_script_model[localclientnum] setmodel(level.last_weapon_name[localclientnum]);
        level.weapon_script_model[localclientnum] setscale(1);
        level.weapon_script_model[localclientnum] setdedicatedshadow(1);
        return;
    }
    if (isdefined(level.current_weapon[localclientnum].frontendmodel)) {
        level.weapon_script_model[localclientnum] useweaponmodel(level.current_weapon[localclientnum], level.current_weapon[localclientnum].frontendmodel);
    } else {
        level.weapon_script_model[localclientnum] useweaponmodel(level.current_weapon[localclientnum]);
    }
    if (isdefined(level.weapon_script_model[localclientnum])) {
        if (should_update_weapon_options) {
            level.weapon_script_model[localclientnum] setweaponrenderoptions(get_camo_index(localclientnum), get_reticle_index(localclientnum), function_92d1857f(localclientnum), function_a131ff92(localclientnum), get_show_emblem(localclientnum), get_show_paintshop(localclientnum));
        }
    }
    level.weapon_script_model[localclientnum] setscale(function_b2d6974(level.current_weapon[localclientnum]));
    level.weapon_script_model[localclientnum] setdedicatedshadow(1);
    level.weapon_script_model[localclientnum] function_9db04136(localclientnum);
}

// Namespace customclass/custom_class
// Params 10, eflags: 0x0
// Checksum 0x8a8aeb88, Offset: 0x2548
// Size: 0x16c
function transition_camera(localclientnum, weapontype, camera, subxcam, initialdelay, lerpduration, notetrack, newweaponstring, var_d80099a1, should_update_weapon_options = 0) {
    self endon(#"death");
    self notify(#"xcammoved");
    self endon(#"xcammoved");
    level endon(#"cam_customization_closed");
    if (isdefined(newweaponstring)) {
        preload_weapon_model(localclientnum, newweaponstring, var_d80099a1, should_update_weapon_options);
    }
    wait initialdelay;
    transition_camera_immediate(localclientnum, weapontype, camera, subxcam, lerpduration, notetrack);
    if (isdefined(newweaponstring)) {
        wait float(lerpduration) / 1000;
        wait_preload_weapon(localclientnum);
        update_weapon_script_model(localclientnum, newweaponstring, var_d80099a1, should_update_weapon_options);
    }
}

// Namespace customclass/custom_class
// Params 3, eflags: 0x0
// Checksum 0x981591af, Offset: 0x26c0
// Size: 0x122
function get_attachments_intersection(oldweapon, oldattachments, var_7a4ae7a1) {
    if (!isdefined(oldweapon)) {
        return var_7a4ae7a1;
    }
    var_b1d06288 = strtok(oldattachments, "+");
    var_9596e4e3 = strtok(var_7a4ae7a1, "+");
    if (!isdefined(var_b1d06288[0]) || var_b1d06288[0] != var_9596e4e3[0]) {
        return var_7a4ae7a1;
    }
    var_4588357a = var_9596e4e3[0];
    for (i = 1; i < var_9596e4e3.size; i++) {
        if (isinarray(var_b1d06288, var_9596e4e3[i])) {
            var_4588357a += "+" + var_9596e4e3[i];
        }
    }
    return var_4588357a;
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x45426ca7, Offset: 0x27f0
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
            level thread transition_camera(localclientnum, base_weapon_slot, "cam_cac_weapon", "cam_cac", 0.3, 400, notetrack, level.last_weapon_name[localclientnum], level.var_ae07d93f[localclientnum], should_update_weapon_options);
        }
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0xe3bf48a2, Offset: 0x2908
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
            level.weapon_script_model[localclientnum] setweaponrenderoptions(get_camo_index(localclientnum), get_reticle_index(localclientnum), function_92d1857f(localclientnum), function_a131ff92(localclientnum), get_show_emblem(localclientnum), get_show_paintshop(localclientnum));
        }
    }
}

// Namespace customclass/custom_class
// Params 1, eflags: 0x0
// Checksum 0x5965e1f8, Offset: 0x2b48
// Size: 0x114
function handle_cac_customization_closed(localclientnum) {
    level endon(#"disconnect");
    level waittill("cam_customization_closed" + localclientnum);
    if (isdefined(level.weapon_clientscript_cac_model[localclientnum]) && isdefined(level.weapon_clientscript_cac_model[localclientnum][level.var_26fcd0f0])) {
        level.weapon_clientscript_cac_model[localclientnum][level.var_26fcd0f0] setweaponrenderoptions(get_camo_index(localclientnum), get_reticle_index(localclientnum), function_92d1857f(localclientnum), function_a131ff92(localclientnum), get_show_emblem(localclientnum), get_show_paintshop(localclientnum));
    }
    setexposureignoreteleport(localclientnum, 0);
}

