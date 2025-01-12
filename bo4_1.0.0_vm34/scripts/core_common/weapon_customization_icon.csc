#using scripts\core_common\multi_extracam;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace weapon_customization_icon;

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 0, eflags: 0x2
// Checksum 0x370a02b5, Offset: 0x158
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"weapon_customization_icon", &__init__, undefined, undefined);
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 0, eflags: 0x0
// Checksum 0xa3dc876b, Offset: 0x1a0
// Size: 0x66
function __init__() {
    level.extra_cam_wc_paintjob_icon = [];
    level.extra_cam_wc_variant_icon = [];
    level.extra_cam_render_wc_paintjobicon_func_callback = &process_wc_paintjobicon_extracam_request;
    level.extra_cam_render_wc_varianticon_func_callback = &process_wc_varianticon_extracam_request;
    level.weaponcustomizationiconsetup = &wc_icon_setup;
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 1, eflags: 0x0
// Checksum 0xc368de5c, Offset: 0x210
// Size: 0x6c
function wc_icon_setup(localclientnum) {
    level.extra_cam_wc_paintjob_icon[localclientnum] = spawnstruct();
    level.extra_cam_wc_variant_icon[localclientnum] = spawnstruct();
    level thread update_wc_icon_extracam(localclientnum);
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 1, eflags: 0x0
// Checksum 0x424f1661, Offset: 0x288
// Size: 0x90
function update_wc_icon_extracam(localclientnum) {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill("process_wc_icon_extracam_" + localclientnum);
        setup_wc_weapon_model(localclientnum, waitresult.icon);
        setup_wc_extracam_settings(localclientnum, waitresult.icon);
    }
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 3, eflags: 0x0
// Checksum 0x47fcca09, Offset: 0x320
// Size: 0x8c
function wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct) {
    level waittill("render_complete_" + localclientnum + "_" + extracam_data_struct.extracamindex);
    multi_extracam::extracam_reset_index(localclientnum, extracam_data_struct.extracamindex);
    if (isdefined(extracam_data_struct.weapon_script_model)) {
        extracam_data_struct.weapon_script_model delete();
    }
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 2, eflags: 0x0
// Checksum 0xcb985bb1, Offset: 0x3b8
// Size: 0x7a
function getxcam(weapon_name, camera) {
    xcam = getweaponxcam(weapon_name, camera);
    if (!isdefined(xcam)) {
        xcam = getweaponxcam(getweapon(#"ar_damage"), camera);
    }
    return xcam;
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 2, eflags: 0x0
// Checksum 0x3c6e32b4, Offset: 0x440
// Size: 0x314
function setup_wc_extracam_settings(localclientnum, extracam_data_struct) {
    assert(isdefined(extracam_data_struct.jobindex));
    if (!isdefined(level.camera_ents)) {
        level.camera_ents = [];
    }
    initializedextracam = 0;
    camera_ent = isdefined(level.camera_ents[localclientnum]) ? level.camera_ents[localclientnum][extracam_data_struct.extracamindex] : undefined;
    if (!isdefined(camera_ent)) {
        initializedextracam = 1;
        if (isdefined(struct::get("weapon_icon_staging"))) {
            camera_ent = multi_extracam::extracam_init_index(localclientnum, "weapon_icon_staging", extracam_data_struct.extracamindex);
        } else {
            camera_ent = multi_extracam::extracam_init_item(localclientnum, get_safehouse_position_struct(), extracam_data_struct.extracamindex);
        }
    }
    assert(isdefined(camera_ent));
    if (extracam_data_struct.loadoutslot == "default_camo_render") {
        extracam_data_struct.xcam = "ui_cam_icon_camo_export";
        extracam_data_struct.subxcam = "cam_icon";
    } else {
        extracam_data_struct.xcam = getxcam(extracam_data_struct.current_weapon, "cam_icon_weapon");
        extracam_data_struct.subxcam = "cam_icon";
    }
    position = extracam_data_struct.weapon_position;
    camera_ent playextracamxcam(extracam_data_struct.xcam, 0, extracam_data_struct.subxcam, extracam_data_struct.notetrack, position.origin, position.angles, extracam_data_struct.weapon_script_model, position.origin, position.angles);
    while (!extracam_data_struct.weapon_script_model isstreamed()) {
        waitframe(1);
    }
    if (extracam_data_struct.loadoutslot == "default_camo_render") {
        wait 0.5;
    } else {
        level waittilltimeout(5, "paintshop_ready_" + extracam_data_struct.jobindex);
    }
    setextracamrenderready(extracam_data_struct.jobindex);
    extracam_data_struct.jobindex = undefined;
    if (initializedextracam) {
        level thread wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct);
    }
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 2, eflags: 0x0
// Checksum 0xab01cd22, Offset: 0x760
// Size: 0x11c
function set_wc_icon_weapon_options(weapon_options_param, extracam_data_struct) {
    weapon_options = strtok(weapon_options_param, ",");
    if (isdefined(weapon_options) && isdefined(extracam_data_struct.weapon_script_model)) {
        var_d2def126 = 0;
        if (isdefined(weapon_options[3])) {
            var_d2def126 = int(weapon_options[3]);
        }
        extracam_data_struct.weapon_script_model setweaponrenderoptions(int(weapon_options[0]), int(weapon_options[1]), var_d2def126, 0, 0, int(weapon_options[2]), extracam_data_struct.paintjobslot, 1, extracam_data_struct.isfilesharepreview);
    }
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 3, eflags: 0x0
// Checksum 0xff408dc2, Offset: 0x888
// Size: 0x78
function spawn_weapon_model(localclientnum, origin, angles) {
    weapon_model = spawn(localclientnum, origin, "script_model");
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    weapon_model sethighdetail();
    return weapon_model;
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 0, eflags: 0x0
// Checksum 0xf69e5195, Offset: 0x908
// Size: 0x86
function get_safehouse_position_struct() {
    position = spawnstruct();
    position.angles = (0, 0, 0);
    switch (util::get_map_name()) {
    default:
        position.origin = (191, 113, -2550);
        break;
    }
    return position;
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 2, eflags: 0x0
// Checksum 0xe6f76ed9, Offset: 0x998
// Size: 0x1cc
function setup_wc_weapon_model(localclientnum, extracam_data_struct) {
    base_weapon_slot = extracam_data_struct.loadoutslot;
    weapon_name = extracam_data_struct.weapon;
    weapon_options_param = extracam_data_struct.weaponoptions;
    if (isdefined(weapon_name)) {
        position = struct::get("weapon_icon_staging");
        if (!isdefined(position)) {
            position = get_safehouse_position_struct();
        }
        if (!isdefined(extracam_data_struct.weapon_script_model)) {
            extracam_data_struct.weapon_script_model = spawn_weapon_model(localclientnum, position.origin, position.angles);
        }
        extracam_data_struct.current_weapon = getweapon(weapon_name);
        if (isdefined(extracam_data_struct.current_weapon.frontendmodel)) {
            extracam_data_struct.weapon_script_model useweaponmodel(extracam_data_struct.current_weapon, extracam_data_struct.current_weapon.frontendmodel);
        } else {
            extracam_data_struct.weapon_script_model useweaponmodel(extracam_data_struct.current_weapon);
        }
        extracam_data_struct.weapon_position = position;
        if (isdefined(weapon_options_param) && weapon_options_param != "none") {
            set_wc_icon_weapon_options(weapon_options_param, extracam_data_struct);
        }
    }
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 8, eflags: 0x0
// Checksum 0xbb83c71e, Offset: 0xb70
// Size: 0x15e
function process_wc_paintjobicon_extracam_request(localclientnum, extracamindex, jobindex, weaponoptions, weapon, loadoutslot, paintjobslot, isfilesharepreview) {
    level.extra_cam_wc_paintjob_icon[localclientnum].jobindex = jobindex;
    level.extra_cam_wc_paintjob_icon[localclientnum].extracamindex = extracamindex;
    level.extra_cam_wc_paintjob_icon[localclientnum].weaponoptions = weaponoptions;
    level.extra_cam_wc_paintjob_icon[localclientnum].weapon = weapon;
    level.extra_cam_wc_paintjob_icon[localclientnum].loadoutslot = loadoutslot;
    level.extra_cam_wc_paintjob_icon[localclientnum].paintjobslot = paintjobslot;
    level.extra_cam_wc_paintjob_icon[localclientnum].notetrack = "paintjobpreview";
    level.extra_cam_wc_paintjob_icon[localclientnum].isfilesharepreview = isfilesharepreview;
    level notify("process_wc_icon_extracam_" + localclientnum, {#icon:level.extra_cam_wc_paintjob_icon[localclientnum]});
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 8, eflags: 0x0
// Checksum 0x9d53895c, Offset: 0xcd8
// Size: 0x15e
function process_wc_varianticon_extracam_request(localclientnum, extracamindex, jobindex, weaponoptions, weapon, loadoutslot, paintjobslot, isfilesharepreview) {
    level.extra_cam_wc_variant_icon[localclientnum].jobindex = jobindex;
    level.extra_cam_wc_variant_icon[localclientnum].extracamindex = extracamindex;
    level.extra_cam_wc_variant_icon[localclientnum].weaponoptions = weaponoptions;
    level.extra_cam_wc_variant_icon[localclientnum].weapon = weapon;
    level.extra_cam_wc_variant_icon[localclientnum].loadoutslot = loadoutslot;
    level.extra_cam_wc_variant_icon[localclientnum].paintjobslot = paintjobslot;
    level.extra_cam_wc_variant_icon[localclientnum].notetrack = "variantpreview";
    level.extra_cam_wc_variant_icon[localclientnum].isfilesharepreview = isfilesharepreview;
    level notify("process_wc_icon_extracam_" + localclientnum, {#icon:level.extra_cam_wc_variant_icon[localclientnum]});
}

