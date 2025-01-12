#using scripts/core_common/animation_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/multi_extracam;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace weapon_customization_icon;

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 0, eflags: 0x2
// Checksum 0xbff0d88f, Offset: 0x2c0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("weapon_customization_icon", &__init__, undefined, undefined);
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 0, eflags: 0x0
// Checksum 0x65b6e0f7, Offset: 0x300
// Size: 0x70
function __init__() {
    level.extra_cam_wc_paintjob_icon = [];
    level.extra_cam_wc_variant_icon = [];
    level.extra_cam_render_wc_paintjobicon_func_callback = &process_wc_paintjobicon_extracam_request;
    level.extra_cam_render_wc_varianticon_func_callback = &process_wc_varianticon_extracam_request;
    level.weaponcustomizationiconsetup = &wc_icon_setup;
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 1, eflags: 0x0
// Checksum 0x54e0d70e, Offset: 0x378
// Size: 0x74
function wc_icon_setup(localclientnum) {
    level.extra_cam_wc_paintjob_icon[localclientnum] = spawnstruct();
    level.extra_cam_wc_variant_icon[localclientnum] = spawnstruct();
    level thread update_wc_icon_extracam(localclientnum);
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 1, eflags: 0x0
// Checksum 0xa70f2878, Offset: 0x3f8
// Size: 0x90
function update_wc_icon_extracam(localclientnum) {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill("process_wc_icon_extracam_" + localclientnum);
        setup_wc_weapon_model(localclientnum, waitresult.extracam_data_struct);
        setup_wc_extracam_settings(localclientnum, waitresult.extracam_data_struct);
    }
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 3, eflags: 0x0
// Checksum 0x90cab88e, Offset: 0x490
// Size: 0x9c
function wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct) {
    level waittill("render_complete_" + localclientnum + "_" + extracam_data_struct.extracamindex);
    multi_extracam::extracam_reset_index(localclientnum, extracam_data_struct.extracamindex);
    if (isdefined(extracam_data_struct.weapon_script_model)) {
        extracam_data_struct.weapon_script_model delete();
    }
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 2, eflags: 0x0
// Checksum 0xcddbdadc, Offset: 0x538
// Size: 0x7c
function getxcam(weapon_name, camera) {
    xcam = getweaponxcam(weapon_name, camera);
    if (!isdefined(xcam)) {
        xcam = getweaponxcam(getweapon("ar_damage"), camera);
    }
    return xcam;
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 2, eflags: 0x0
// Checksum 0xb702607, Offset: 0x5c0
// Size: 0x364
function setup_wc_extracam_settings(localclientnum, extracam_data_struct) {
    /#
        assert(isdefined(extracam_data_struct.jobindex));
    #/
    if (!isdefined(level.camera_ents)) {
        level.camera_ents = [];
    }
    initializedextracam = 0;
    camera_ent = isdefined(level.camera_ents[localclientnum]) ? level.camera_ents[localclientnum][extracam_data_struct.extracamindex] : undefined;
    if (!isdefined(camera_ent)) {
        initializedextracam = 1;
        if (isdefined(struct::get("weapon_icon_staging_camera"))) {
            camera_ent = multi_extracam::extracam_init_index(localclientnum, "weapon_icon_staging_camera", extracam_data_struct.extracamindex);
        } else {
            camera_ent = multi_extracam::extracam_init_item(localclientnum, get_safehouse_position_struct(), extracam_data_struct.extracamindex);
        }
    }
    /#
        assert(isdefined(camera_ent));
    #/
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
// Checksum 0x38b4e46e, Offset: 0x930
// Size: 0xf4
function set_wc_icon_weapon_options(weapon_options_param, extracam_data_struct) {
    weapon_options = strtok(weapon_options_param, ",");
    if (isdefined(weapon_options) && isdefined(extracam_data_struct.weapon_script_model)) {
        extracam_data_struct.weapon_script_model setweaponrenderoptions(int(weapon_options[0]), int(weapon_options[1]), 0, 0, int(weapon_options[2]), extracam_data_struct.paintjobslot, extracam_data_struct.paintjobindex, 1, extracam_data_struct.isfilesharepreview);
    }
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 3, eflags: 0x0
// Checksum 0x67be46da, Offset: 0xa30
// Size: 0x80
function spawn_weapon_model(localclientnum, origin, angles) {
    weapon_model = spawn(localclientnum, origin, "script_model");
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    weapon_model sethighdetail();
    return weapon_model;
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 3, eflags: 0x0
// Checksum 0x6b0bbb60, Offset: 0xab8
// Size: 0xd0
function function_6ce525f(var_cf4497db, var_dacb3c7, extracam_data_struct) {
    var_5a183cc0 = strtok(var_cf4497db, ",");
    for (i = 0; i + 1 < var_5a183cc0.size; i += 2) {
        extracam_data_struct.weapon_script_model setattachmentcosmeticvariantindex(var_dacb3c7, var_5a183cc0[i], int(var_5a183cc0[i + 1]));
    }
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 0, eflags: 0x0
// Checksum 0x1cdb7997, Offset: 0xb90
// Size: 0xe6
function get_safehouse_position_struct() {
    position = spawnstruct();
    position.angles = (0, 0, 0);
    switch (tolower(getdvarstring("mapname"))) {
    case #"hash_c0022b6f":
        position.origin = (-527, 1569, -25);
        break;
    case #"hash_709124d9":
        position.origin = (-1215, 2464, 190);
        break;
    default:
        position.origin = (191, 113, -2550);
        break;
    }
    return position;
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 2, eflags: 0x0
// Checksum 0x72709c2, Offset: 0xc80
// Size: 0x254
function setup_wc_weapon_model(localclientnum, extracam_data_struct) {
    base_weapon_slot = extracam_data_struct.loadoutslot;
    var_dacb3c7 = extracam_data_struct.var_8ebc235;
    weapon_options_param = extracam_data_struct.weaponoptions;
    var_cf4497db = extracam_data_struct.var_61813f1a;
    if (isdefined(var_dacb3c7)) {
        position = struct::get("weapon_icon_staging");
        if (!isdefined(position)) {
            position = get_safehouse_position_struct();
        }
        if (!isdefined(extracam_data_struct.weapon_script_model)) {
            extracam_data_struct.weapon_script_model = spawn_weapon_model(localclientnum, position.origin, position.angles);
        }
        extracam_data_struct.current_weapon = getweaponwithattachments(var_dacb3c7);
        if (isdefined(extracam_data_struct.current_weapon.frontendmodel)) {
            extracam_data_struct.weapon_script_model useweaponmodel(extracam_data_struct.current_weapon, extracam_data_struct.current_weapon.frontendmodel);
        } else {
            extracam_data_struct.weapon_script_model useweaponmodel(extracam_data_struct.current_weapon);
        }
        extracam_data_struct.weapon_position = position;
        if (isdefined(var_cf4497db) && var_cf4497db != "none") {
            function_6ce525f(var_cf4497db, var_dacb3c7, extracam_data_struct);
        }
        if (isdefined(weapon_options_param) && weapon_options_param != "none") {
            set_wc_icon_weapon_options(weapon_options_param, extracam_data_struct);
        }
    }
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 10, eflags: 0x0
// Checksum 0xdbdbec25, Offset: 0xee0
// Size: 0x1c6
function process_wc_paintjobicon_extracam_request(localclientnum, extracamindex, jobindex, var_61813f1a, weaponoptions, var_8ebc235, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview) {
    level.extra_cam_wc_paintjob_icon[localclientnum].jobindex = jobindex;
    level.extra_cam_wc_paintjob_icon[localclientnum].extracamindex = extracamindex;
    level.extra_cam_wc_paintjob_icon[localclientnum].var_61813f1a = var_61813f1a;
    level.extra_cam_wc_paintjob_icon[localclientnum].weaponoptions = weaponoptions;
    level.extra_cam_wc_paintjob_icon[localclientnum].var_8ebc235 = var_8ebc235;
    level.extra_cam_wc_paintjob_icon[localclientnum].loadoutslot = loadoutslot;
    level.extra_cam_wc_paintjob_icon[localclientnum].paintjobindex = paintjobindex;
    level.extra_cam_wc_paintjob_icon[localclientnum].paintjobslot = paintjobslot;
    level.extra_cam_wc_paintjob_icon[localclientnum].notetrack = "paintjobpreview";
    level.extra_cam_wc_paintjob_icon[localclientnum].isfilesharepreview = isfilesharepreview;
    level notify("process_wc_icon_extracam_" + localclientnum, {#icon:level.extra_cam_wc_paintjob_icon[localclientnum]});
}

// Namespace weapon_customization_icon/weapon_customization_icon
// Params 10, eflags: 0x0
// Checksum 0x1fe4c3bc, Offset: 0x10b0
// Size: 0x1c6
function process_wc_varianticon_extracam_request(localclientnum, extracamindex, jobindex, var_61813f1a, weaponoptions, var_8ebc235, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview) {
    level.extra_cam_wc_variant_icon[localclientnum].jobindex = jobindex;
    level.extra_cam_wc_variant_icon[localclientnum].extracamindex = extracamindex;
    level.extra_cam_wc_variant_icon[localclientnum].var_61813f1a = var_61813f1a;
    level.extra_cam_wc_variant_icon[localclientnum].weaponoptions = weaponoptions;
    level.extra_cam_wc_variant_icon[localclientnum].var_8ebc235 = var_8ebc235;
    level.extra_cam_wc_variant_icon[localclientnum].loadoutslot = loadoutslot;
    level.extra_cam_wc_variant_icon[localclientnum].paintjobindex = paintjobindex;
    level.extra_cam_wc_variant_icon[localclientnum].paintjobslot = paintjobslot;
    level.extra_cam_wc_variant_icon[localclientnum].notetrack = "variantpreview";
    level.extra_cam_wc_variant_icon[localclientnum].isfilesharepreview = isfilesharepreview;
    level notify("process_wc_icon_extracam_" + localclientnum, {#icon:level.extra_cam_wc_variant_icon[localclientnum]});
}

