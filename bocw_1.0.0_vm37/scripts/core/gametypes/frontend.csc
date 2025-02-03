#using script_209c9c119ef6fc06;
#using script_53cd49b939f89fd7;
#using script_7ca3324ffa5389e4;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\activecamo_shared_util;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\character_customization;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\custom_class;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapon_customization_icon;
#using scripts\mp_common\devgui;

#namespace frontend;

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xb59bbab5, Offset: 0xa30
// Size: 0x90
function function_9bfe9255(var_f75a02ea, mode) {
    var_a2865de6 = getplayerroletemplatecount(mode);
    for (i = 0; i < var_a2865de6; i++) {
        var_eb49090f = function_b14806c6(i, mode);
        if (isdefined(var_eb49090f) && var_eb49090f == var_f75a02ea) {
            return i;
        }
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x7dfb3d9d, Offset: 0xac8
// Size: 0x7e
function function_b9f8bbd9(character_index, session_mode, *var_3f0e790b) {
    if (var_3f0e790b == 4) {
        return false;
    }
    if (!function_f4bf7e3f(session_mode, var_3f0e790b)) {
        return false;
    }
    fields = getcharacterfields(session_mode, var_3f0e790b);
    if (!isdefined(fields)) {
        return false;
    }
    return true;
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xced2a651, Offset: 0xb50
// Size: 0xea
function function_8d1cae0b(character_index, session_mode, var_3f0e790b) {
    if (!function_b9f8bbd9(character_index, session_mode, var_3f0e790b)) {
        return 0;
    }
    if (session_mode == 3) {
        fields = getplayerrolefields(character_index, session_mode);
        return is_true(fields.isdefaultcharacter);
    }
    characterfields = getcharacterfields(character_index, session_mode);
    if (isdefined(characterfields.requireddvar) && !getdvarint(characterfields.requireddvar, 0)) {
        return 0;
    }
    return 1;
}

// Namespace frontend/frontend
// Params 5, eflags: 0x0
// Checksum 0x5c288975, Offset: 0xc48
// Size: 0x2d6
function function_e3efec59(localclientnum, xuid, session_mode, var_3f0e790b, var_6ddefc3d = 0) {
    if (!isdefined(level.var_dd1c817)) {
        level.var_dd1c817 = [];
    }
    if (!isdefined(level.var_dd1c817[session_mode])) {
        level.var_dd1c817[session_mode] = [];
    }
    character_index = undefined;
    if (var_6ddefc3d > 0) {
        character_index = var_6ddefc3d;
    } else {
        character_index = getequippedheroindex(localclientnum, session_mode);
        if (!function_8d1cae0b(character_index, session_mode, var_3f0e790b)) {
            if (isdefined(level.var_dd1c817[session_mode][xuid])) {
                return level.var_dd1c817[session_mode][xuid];
            } else {
                playerroletemplatecount = getplayerroletemplatecount(session_mode);
                var_53b30724 = [];
                for (i = 0; i < playerroletemplatecount; i++) {
                    if (function_8d1cae0b(i, session_mode, var_3f0e790b)) {
                        if (session_mode == 1 && (xuid >> 32 & -1334837248) == -1334837248) {
                            rf = getplayerrolefields(i, session_mode);
                            if (isdefined(rf) && is_true(rf.var_ae8ab113)) {
                                if (!isdefined(var_53b30724)) {
                                    var_53b30724 = [];
                                } else if (!isarray(var_53b30724)) {
                                    var_53b30724 = array(var_53b30724);
                                }
                                var_53b30724[var_53b30724.size] = i;
                            }
                            continue;
                        }
                        if (!isdefined(var_53b30724)) {
                            var_53b30724 = [];
                        } else if (!isarray(var_53b30724)) {
                            var_53b30724 = array(var_53b30724);
                        }
                        var_53b30724[var_53b30724.size] = i;
                    }
                }
                if (var_53b30724.size > 0) {
                    character_index = array::random(var_53b30724);
                } else {
                    character_index = 0;
                }
            }
        }
    }
    level.var_dd1c817[session_mode][xuid] = character_index;
    return level.var_dd1c817[session_mode][xuid];
}

// Namespace frontend/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x8fc3216, Offset: 0xf28
// Size: 0x20c
function event_handler[gametype_init] main(*eventstruct) {
    level.callbackentityspawned = &entityspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.orbis = getdvarstring(#"orbisgame") == "true";
    level.durango = getdvarstring(#"durangogame") == "true";
    level.var_762a4ab = &function_79ac87ac;
    level.var_696537bb = &function_8567daf2;
    level.var_29369e8c = &function_d47a6728;
    level.var_6365df1f = &function_286efebf;
    level.var_633071d0 = 1;
    level.var_d508403d = findvolumedecalindexarray("decals_zm_lobby");
    level.var_8a620c67 = findstaticmodelindexarray("misc_models_zm_lobby");
    level.var_1a55d2dd = findvolumedecalindexarray("decals_mp_lobby");
    level.var_fec4a8fd = findstaticmodelindexarray("misc_models_mp_lobby");
    customclass::init();
    level thread blackscreen_watcher();
    setstreamerrequest(1, "core_frontend");
    util::function_21aef83c();
    util::function_5ff170ee();
    function_24ae4ffb();
}

// Namespace frontend/gametype_start
// Params 1, eflags: 0x40
// Checksum 0x282e0e05, Offset: 0x1140
// Size: 0x1c
function event_handler[gametype_start] start(*eventstruct) {
    setupclientmenus();
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x5045283, Offset: 0x1168
// Size: 0x74
function function_e843475e(menuname) {
    lui_camera::function_f603fc4d(menuname, #"tag_align_frontend_background", #"ui_scene_cam_background");
    lui_camera::function_460e6001(menuname, 3, #"tag_align_frontend_background", #"ui_scene_cam_background");
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x7ea31330, Offset: 0x11e8
// Size: 0xf74
function setupclientmenus() {
    lui_camera::function_6425472c("PressStart");
    lui_camera::function_17384292("PressStart", &lobby_main);
    lui_camera::function_866692f8("PressStart", #"loadout_room", #"hash_25876c04ba3c35a8", undefined, "idle");
    lui_camera::function_f852c52c("PressStart", #"loadout_room", 1);
    lui_camera::function_866692f8("PressStart", #"scorestreaks", #"scene_frontend_t9_scorestreak", undefined, "idle");
    lui_camera::function_866692f8("PressStart", #"armory", #"scene_frontend_t9_cac_overview", undefined, "overview");
    lui_camera::function_f852c52c("PressStart", #"armory", 1);
    lui_camera::function_866692f8("PressStart", #"character_room", #"scene_frontend_t9_character", undefined, "select_idle");
    lui_camera::function_866692f8("PressStart", #"room1", #"scene_frontend_start", undefined, "start", undefined);
    lui_camera::function_866692f8("PressStart", #"room2", #"scene_frontend_start", undefined, "start", undefined);
    lui_camera::function_866692f8("PressStart", #"mode_select", #"scene_frontend_start", undefined, "main", undefined);
    lui_camera::function_866692f8("PressStart", #"cp_story", #"scene_frontend_t9_cp_mission_select", undefined, "idle");
    lui_camera::function_866692f8("PressStart", #"cp_evidence", #"scene_frontend_t9_cp_evidence", undefined, "idle");
    lui_camera::function_8950260c("PressStart", #"character_room", #"lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"loadout_room", #"lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"character_room", #"lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"loadout_room", #"lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"character_room", #"lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"loadout_room", #"lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"armory", #"lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"scorestreaks", #"lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"character_room", #"private_lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"loadout_room", #"private_lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"character_room", #"private_lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"loadout_room", #"private_lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"character_room", #"private_lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"loadout_room", #"private_lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"armory", #"private_lobby_pose", "idle");
    lui_camera::function_8950260c("PressStart", #"scorestreaks", #"private_lobby_pose", "idle");
    lui_camera::function_6425472c("Armory", #"scene_frontend_t9_cac_overview", undefined, "overview");
    lui_camera::function_866692f8("Armory", #"gunsmith", #"scene_frontend_t9_gunsmith", undefined, "overview");
    lui_camera::function_f852c52c("Armory", undefined, 1);
    lui_camera::function_969a2881("LobbyInspection", &handle_inspect_player, 0, &start_character_rotating_any, &end_character_rotating_any);
    lui_camera::function_1337c436("LobbyInspection", "inspection_character", 0);
    lui_camera::function_969a2881("SinglePlayerInspection", &handle_inspect_player, 0, &start_character_rotating_any, &end_character_rotating_any);
    lui_camera::function_1337c436("SinglePlayerInspection", "inspection_character", 0);
    lui_camera::function_969a2881("Paintshop", undefined, 0, undefined, undefined);
    lui_camera::function_969a2881("PaintjobWeaponSelect", undefined, 0, undefined, undefined);
    lui_camera::function_6425472c("Gunsmith", #"scene_frontend_t9_gunsmith", undefined, "overview");
    lui_camera::function_f852c52c("Gunsmith", undefined, 1);
    lui_camera::function_6425472c("GunsmithAttachmentSelect", #"scene_frontend_t9_gunsmith", undefined, "overview");
    lui_camera::function_f852c52c("GunsmithAttachmentSelect", undefined, 1);
    lui_camera::function_6425472c("SupportSelection", #"scene_frontend_t9_scorestreak", undefined, "idle");
    lui_camera::function_969a2881("BubblegumBuffSelect", undefined, undefined, undefined, undefined);
    lui_camera::function_969a2881("Pregame_Main", &lobby_main, 1);
    lui_camera::function_969a2881("MPCustomizeClassMenu", undefined, 0, undefined, undefined);
    lui_camera::function_f852c52c("MPCustomizeClassMenu", undefined, 1);
    lui_camera::function_969a2881("ZMCustomizeClassMenu", undefined, 0, undefined, undefined);
    lui_camera::function_f852c52c("ZMCustomizeClassMenu", undefined, 1);
    lui_camera::function_6425472c("WeaponSelectFlyout", #"scene_frontend_t9_cac_overview", undefined, "overview");
    lui_camera::function_f852c52c("WeaponSelectFlyout", undefined, 1);
    lui_camera::function_969a2881("AAR_T8_MP", &function_73b8462a, 1, undefined, &function_48fb04a7);
    lui_camera::function_1337c436("AAR_T8_MP", "aar_character");
    lui_camera::function_969a2881("AAR_T8_ZM", &function_73b8462a, 1, undefined, &function_48fb04a7);
    lui_camera::function_1337c436("AAR_T8_ZM", "aar_character");
    lui_camera::function_969a2881("AAR_T8_WZ", &function_73b8462a, 1, undefined, &function_48fb04a7);
    lui_camera::function_1337c436("AAR_T8_WZ", "aar_character");
    lui_camera::function_969a2881("AAR_T8_ARENA", &function_73b8462a, 1, undefined, &function_48fb04a7);
    lui_camera::function_1337c436("AAR_T8_ARENA", "aar_character");
    lui_camera::function_969a2881("AARMissionRewardOverlay", &function_f8cec907, 1, undefined, &end_character_rotating);
    lui_camera::function_1337c436("AARMissionRewardOverlay", "specialist_customization");
    function_e843475e("EmblemSelect");
    function_e843475e("EmblemChooseIcon");
    function_e843475e("EmblemEditor");
    function_e843475e("Store");
    function_e843475e("Store_DLC");
    function_e843475e("DirectorFindGame");
    lui_camera::function_6425472c("PersonalizeCharacter");
    lui_camera::function_17384292("PersonalizeCharacter", &function_763f40c4);
    lui_camera::function_866692f8("PersonalizeCharacter", #"character", #"scene_frontend_t9_character_customization_camera", undefined, "outfit_idle", undefined);
    lui_camera::function_866692f8("PersonalizeCharacter", #"face", #"scene_frontend_t9_character_customization_camera", undefined, "warpaint_idle", undefined);
    lui_camera::function_8950260c("PersonalizeCharacter", #"character", #"face", "warpaint_idle");
    lui_camera::function_8950260c("PersonalizeCharacter", #"face", #"character", "outfit_idle");
    lui_camera::function_969a2881("MPSpecialistHUBGestures", &function_9602c423, 1, &start_character_rotating, &end_character_rotating);
    lui_camera::function_1337c436("MPSpecialistHUBGestures", "specialist_customization");
    function_e843475e("MPSpecialistHUBTags");
    lui_camera::function_969a2881("ItemShopDetails", &function_837446a8, 1, array(&function_98088878), array(&end_character_rotating, &function_7142469f));
    lui_camera::function_1337c436("ItemShopDetails", "specialist_customization");
    var_5ef5aa96 = "scene_frontend_arena_team";
    scene::add_scene_func(var_5ef5aa96, &function_fad4ce33, "init");
    scene::add_scene_func(var_5ef5aa96, &function_c5cbf7d6, "stop");
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0xba53a355, Offset: 0x2168
// Size: 0x168
function blackscreen_watcher() {
    blackscreenuimodel = getuimodel(function_5f72e972(#"director_global"), "hideWorldForStreamer");
    setuimodelvalue(blackscreenuimodel, 1);
    while (true) {
        waitresult = level waittill(#"streamer_change");
        var_d0b01271 = waitresult.var_d0b01271;
        setuimodelvalue(blackscreenuimodel, 1);
        wait 0.1;
        while (true) {
            charready = 1;
            if (isdefined(var_d0b01271)) {
                charready = [[ var_d0b01271 ]]->is_streamed();
            }
            sceneready = getstreamerrequestprogress(0) >= 100;
            if (charready && sceneready) {
                break;
            }
            wait 0.1;
        }
        setuimodelvalue(blackscreenuimodel, 0);
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xc5fbb780, Offset: 0x22d8
// Size: 0x78
function streamer_change(hint, var_d0b01271) {
    if (isdefined(hint)) {
        setstreamerrequest(0, hint);
    } else {
        clearstreamerrequest(0);
    }
    level notify(#"streamer_change", {#var_d0b01271:var_d0b01271});
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xd53850ad, Offset: 0x2358
// Size: 0x128
function handle_inspect_player(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    level thread scene::play("scene_frontend_inspection_camera", "inspection_full");
    level thread function_b885d47c(menu_name, localclientnum);
    level thread function_37304ace(localclientnum, menu_name);
    while (true) {
        waitresult = level waittill(#"inspect_player");
        assert(isdefined(waitresult.xuid));
        level childthread update_inspection_character(localclientnum, waitresult.xuid, menu_name);
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x74cfa08c, Offset: 0x2488
// Size: 0x5c
function function_b885d47c(menu_name, *localclientnum) {
    level waittill(localclientnum + "_closed");
    level thread scene::stop("scene_frontend_inspection_camera");
    level.var_44011752 hide();
}

// Namespace frontend/frontend
// Params 4, eflags: 0x0
// Checksum 0x12c07e45, Offset: 0x24f0
// Size: 0x4e0
function update_inspection_character(localclientnum, xuid, menu_name, var_6ddefc3d = 0) {
    self notify("3396e792a6a76216");
    self endon("3396e792a6a76216");
    var_d0b01271 = lui_camera::function_daadc836(menu_name, localclientnum);
    var_a708693a = isdefined(level.draftcharacters) && level.draftcharacters.size > 0;
    if (var_a708693a) {
        foreach (character in level.draftcharacters) {
            info = [[ character ]]->function_82e05d64();
            if (isdefined(info) && util::function_48e57e36(xuid) == info.xuid) {
                var_23904c1d = [[ character ]]->function_e599283f();
            }
        }
    }
    if (!isdefined(var_23904c1d)) {
        var_23904c1d = getcharactercustomizationforxuid(localclientnum, util::function_48e57e36(xuid));
    }
    if (!isdefined(var_23904c1d)) {
        [[ var_d0b01271 ]]->function_1ec9448d(1);
        [[ var_d0b01271 ]]->function_27945cb8(1);
        params = {#anim_name:[[ var_d0b01271 ]]->function_8144231c()};
        [[ var_d0b01271 ]]->update(params);
        for (iterations = 0; !isdefined(var_23904c1d) && iterations < 15; iterations++) {
            wait 1;
            var_23904c1d = getcharactercustomizationforxuid(localclientnum, xuid);
        }
        [[ var_d0b01271 ]]->function_1ec9448d(0);
        [[ var_d0b01271 ]]->function_27945cb8(0);
    }
    session_mode = currentsessionmode();
    if (!isdefined(var_23904c1d) || !var_a708693a && !function_8d1cae0b(var_23904c1d.charactertype, var_23904c1d.charactermode, 4) || session_mode != 4 && var_23904c1d.charactermode != session_mode) {
        if (session_mode == 4 || session_mode == 2) {
            session_mode = 1;
            if (getplayerroletemplatecount(session_mode) == 0) {
                session_mode = 3;
            }
            if (getplayerroletemplatecount(session_mode) == 0) {
                session_mode = 0;
            }
        }
        character_index = function_e3efec59(localclientnum, xuid, session_mode, 4, var_6ddefc3d);
        if (isdefined(character_index)) {
            level.var_dd1c817[xuid] = character_index;
            var_23904c1d = character_customization::function_3f5625f1(session_mode, character_index);
            fields = getcharacterfields(character_index, session_mode);
        }
    } else {
        fields = getcharacterfields(var_23904c1d.charactertype, var_23904c1d.charactermode);
    }
    var_8e0277a = undefined;
    if (isdefined(fields)) {
        var_8e0277a = fields.var_2081b2ed;
    }
    if (isdefined(var_8e0277a) && character_customization::function_aa5382ed([[ var_d0b01271 ]]->function_e599283f(), var_23904c1d)) {
        [[ var_d0b01271 ]]->function_1ec9448d(0);
        params = {#var_401d9a1:1, #var_c76f3e47:1, #scene:var_8e0277a};
        [[ var_d0b01271 ]]->function_15a8906a(var_23904c1d);
        [[ var_d0b01271 ]]->update(params);
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xa464db15, Offset: 0x29d8
// Size: 0x178
function function_37304ace(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    while (true) {
        waitresult = level waittill(#"hash_6d381d5ecca233c6");
        if (is_true(waitresult.clear_weapon)) {
            level.var_44011752 hide();
            level thread scene::stop(#"scene_frontend_inspection_weapon");
            continue;
        }
        assert(isdefined(waitresult.weapon));
        assert(isdefined(waitresult.attachments));
        assert(isdefined(waitresult.camoindex));
        assert(isdefined(waitresult.paintjobslot));
        level childthread function_daa3f7d0(localclientnum, waitresult, 1);
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xb07da84a, Offset: 0x2b58
// Size: 0x2cc
function function_daa3f7d0(*localclientnum, weaponinfo, *should_update_weapon_options) {
    newweaponstring = should_update_weapon_options.weapon;
    var_f020955 = should_update_weapon_options.attachments;
    current_weapon = getweapon(newweaponstring, strtok(var_f020955, "+"));
    if (isdefined(current_weapon) && isdefined(level.var_44011752)) {
        if (level scene::is_playing(#"scene_frontend_inspection_weapon")) {
            level.var_44011752 show();
            level thread scene::stop(#"scene_frontend_inspection_weapon");
        }
        wait 0.1;
        s_info = customclass::function_5f70d1c8(current_weapon);
        render_options = function_6eff28b5(should_update_weapon_options.camoindex, 0, 0);
        blueprint = 0;
        if (isdefined(should_update_weapon_options.blueprint)) {
            blueprint = should_update_weapon_options.blueprint;
        }
        level.var_44011752 useweaponmodel(current_weapon, undefined, render_options, blueprint);
        level.var_44011752 setscale(s_info.scale);
        level.var_44011752.targetname = "customized_inspection_weapon";
        level.var_44011752 useanimtree("generic");
        position = struct::get(#"tag_align_inspection_weapon1");
        origin = position.origin + s_info.offset;
        angles = position.angles + s_info.angles;
        level.var_44011752 thread animation::play(#"hash_3689442490c2e5dd", origin, angles);
        level thread scene::play(#"scene_frontend_inspection_weapon", "inspection_weapon_full");
        level.var_44011752 show();
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xa2030232, Offset: 0x2e30
// Size: 0xc
function entityspawned(*localclientnum) {
    
}

/#

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0x96303ad0, Offset: 0x2e48
    // Size: 0x208
    function function_90646a7f(localclientnum) {
        while (true) {
            ct_cmd = getdvarint(#"hash_52d9845c30e27ace", 0);
            if (ct_cmd == 0) {
                wait 0.25;
                continue;
            }
            roommodel = getuimodel(function_5f72e972(#"lobby_root"), "<dev string:x38>");
            room = getuimodelvalue(roommodel);
            origin = getcamposbylocalclientnum(localclientnum);
            angles = getcamanglesbylocalclientnum(localclientnum);
            sendmenuresponse(localclientnum, #"spawn_noclip", int(origin[0]) + "<dev string:x40>" + int(origin[1]) + "<dev string:x40>" + int(origin[2]) + "<dev string:x40>" + int(angles[0]) + "<dev string:x40>" + int(angles[1]) + "<dev string:x40>" + int(angles[2]), 1);
            setdvar(#"hash_52d9845c30e27ace", 0);
        }
    }

    // Namespace frontend/frontend
    // Params 2, eflags: 0x0
    // Checksum 0xb3a4ad09, Offset: 0x3058
    // Size: 0x182
    function function_da10fc8f(localclientnum, var_da239274) {
        var_38b900c2 = getent(localclientnum, "<dev string:x45>", "<dev string:x5d>");
        var_51a0f339 = getent(localclientnum, "<dev string:x6b>", "<dev string:x5d>");
        var_38b900c2 show();
        var_51a0f339 hide();
        function_45180840(localclientnum);
        do {
            waitframe(1);
        } while (function_6911e8d(localclientnum));
        var_38b900c2 hide();
        var_51a0f339 show();
        waitframe(1);
        function_c6df7fed(localclientnum);
        do {
            waitframe(1);
        } while (function_6911e8d(localclientnum));
        function_84469b54(var_da239274);
        var_38b900c2 show();
        var_51a0f339 hide();
        waitframe(1);
    }

    // Namespace frontend/frontend
    // Params 4, eflags: 0x0
    // Checksum 0x432ab63e, Offset: 0x31e8
    // Size: 0x22e
    function function_93ccf33d(var_62d90151, entrytype, &var_37451b86, &var_7f0244ba) {
        foreach (i, item in var_62d90151) {
            entry = {#index:i, #type:entrytype, #item:item};
            if (isdefined(var_37451b86[item.name])) {
                if (!isdefined(var_37451b86[item.name].options[entrytype])) {
                    var_37451b86[item.name].options[entrytype] = [];
                } else if (!isarray(var_37451b86[item.name].options[entrytype])) {
                    var_37451b86[item.name].options[entrytype] = array(var_37451b86[item.name].options[entrytype]);
                }
                var_37451b86[item.name].options[entrytype][var_37451b86[item.name].options[entrytype].size] = entry;
                continue;
            }
            if (i != 0) {
                if (!isdefined(var_7f0244ba)) {
                    var_7f0244ba = [];
                } else if (!isarray(var_7f0244ba)) {
                    var_7f0244ba = array(var_7f0244ba);
                }
                var_7f0244ba[var_7f0244ba.size] = entry;
            }
        }
    }

    // Namespace frontend/frontend
    // Params 7, eflags: 0x0
    // Checksum 0x2d969849, Offset: 0x3420
    // Size: 0x31c
    function function_23bc6f08(localclientnum, var_d0b01271, itemtype, item_data, mode, character_index, var_b34f01f0) {
        if (item_data.lootid == #"") {
            return;
        }
        switch (itemtype) {
        case 1:
            return;
        case 2:
            shot_name = "<dev string:x83>";
            break;
        case 3:
            shot_name = "<dev string:x8b>";
            break;
        case 7:
            shot_name = "<dev string:x97>";
            break;
        case 6:
            shot_name = "<dev string:xa3>";
            break;
        case 0:
            shot_name = "<dev string:xac>";
            break;
        case 4:
            shot_name = "<dev string:xb4>";
            break;
        default:
            shot_name = "<dev string:xbc>";
            break;
        }
        scene_name = #"scene_frontend_character_male_render";
        if (#"female" == getherogender(character_index, mode)) {
            scene_name = #"scene_frontend_character_female_render";
        }
        [[ var_d0b01271 ]]->update({#var_c76f3e47:1, #var_5bd51249:8, #var_13fb1841:8, #scene:scene_name, #scene_shot:shot_name});
        do {
            wait 0.5;
        } while (![[ var_d0b01271 ]]->function_ea4ac9f8());
        var_f75a02ea = function_9e72a96(function_b14806c6(character_index, mode));
        if (var_b34f01f0) {
            shot_name = "<dev string:xc8>" + var_f75a02ea + "<dev string:xdb>" + function_9e72a96(item_data.lootid) + "<dev string:xe0>";
        } else {
            shot_name = "<dev string:xc8>" + var_f75a02ea + "<dev string:xdb>" + function_9e72a96(item_data.lootid) + "<dev string:xfb>";
        }
        function_da10fc8f(localclientnum, shot_name);
    }

    // Namespace frontend/frontend
    // Params 2, eflags: 0x0
    // Checksum 0x35940ff9, Offset: 0x3748
    // Size: 0xb0
    function function_2351cba1(itemtype, mode) {
        switch (itemtype) {
        case 1:
            return 0;
        case 0:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
            return (mode != 1);
        }
        return 1;
    }

    // Namespace frontend/frontend
    // Params 3, eflags: 0x0
    // Checksum 0xbbfcea78, Offset: 0x3800
    // Size: 0x89c
    function function_4920c25a(localclientnum, menu_name, state) {
        self notify("<dev string:x108>");
        self endon("<dev string:x108>");
        function_25485718();
        var_38b900c2 = getent(localclientnum, "<dev string:x45>", "<dev string:x5d>");
        var_51a0f339 = getent(localclientnum, "<dev string:x6b>", "<dev string:x5d>");
        var_38b900c2 show();
        var_51a0f339 hide();
        args = strtok(state, "<dev string:x11c>");
        mode = int(args[0]);
        character_index = int(args[1]);
        outfit_index = int(args[2]);
        var_7823b8b1 = int(args[3]);
        var_d0b01271 = lui_camera::function_daadc836(menu_name, localclientnum);
        [[ var_d0b01271 ]]->set_character_mode(mode);
        [[ var_d0b01271 ]]->set_character_index(character_index);
        [[ var_d0b01271 ]]->function_22039feb();
        var_13240050 = function_d299ef16(character_index, mode);
        var_f750af1d = outfit_index == -1 ? 0 : outfit_index;
        var_f58d84ac = outfit_index == -1 ? var_13240050 - 1 : outfit_index;
        for (outfitindex = var_f750af1d; outfitindex <= var_f58d84ac; outfitindex++) {
            var_9cf37283 = function_d7c3cf6c(character_index, outfitindex, mode);
            [[ var_d0b01271 ]]->set_character_outfit(outfitindex);
            [[ var_d0b01271 ]]->function_158505aa(outfitindex);
            if (mode == 1 && (var_7823b8b1 == -1 || var_7823b8b1 == 8)) {
                foreach (preset in var_9cf37283.presets) {
                    if (preset.isvalid && preset.lootid != #"") {
                        [[ var_d0b01271 ]]->function_95779b72();
                        foreach (type, option in preset.parts) {
                            [[ var_d0b01271 ]]->set_character_outfit_item(option, type);
                        }
                        function_23bc6f08(localclientnum, var_d0b01271, 8, preset, mode, character_index, 0);
                        foreach (option, war_paint in var_9cf37283.options[7]) {
                            if (war_paint.name == preset.name) {
                                [[ var_d0b01271 ]]->set_character_outfit_item(option, 7);
                                break;
                            }
                        }
                        foreach (option, war_paint in var_9cf37283.options[1]) {
                            if (war_paint.name == preset.name) {
                                [[ var_d0b01271 ]]->set_character_outfit_item(option, 7);
                                break;
                            }
                        }
                        function_23bc6f08(localclientnum, var_d0b01271, 8, preset, mode, character_index, 1);
                    }
                }
            }
            foreach (type, options in var_9cf37283.options) {
                if (function_2351cba1(type, mode) && (var_7823b8b1 == -1 || var_7823b8b1 == type)) {
                    [[ var_d0b01271 ]]->set_character_outfit(outfitindex);
                    [[ var_d0b01271 ]]->function_158505aa(outfitindex);
                    foreach (i, option in options) {
                        [[ var_d0b01271 ]]->function_95779b72();
                        [[ var_d0b01271 ]]->set_character_outfit_item(i, type);
                        if (type == 7 && mode == 1) {
                            var_47e7e198 = undefined;
                            foreach (j, palette in var_9cf37283.options[5]) {
                                if (palette.name == option.name) {
                                    var_47e7e198 = j;
                                    break;
                                }
                            }
                            if (isdefined(var_47e7e198)) {
                                [[ var_d0b01271 ]]->set_character_outfit(outfitindex);
                                [[ var_d0b01271 ]]->set_character_outfit_item(var_47e7e198, 5);
                            } else {
                                [[ var_d0b01271 ]]->set_character_outfit(0);
                            }
                        }
                        function_23bc6f08(localclientnum, var_d0b01271, type, option, mode, character_index, 0);
                    }
                }
            }
        }
        [[ var_d0b01271 ]]->function_39a68bf2();
        level notify("<dev string:x121>" + localclientnum, {#menu:"<dev string:x130>", #status:"<dev string:x146>"});
        setdvar(#"char_render", "<dev string:x150>");
        function_59013397();
    }

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0x2ec42f10, Offset: 0x40a8
    // Size: 0x9c
    function function_92087f1b(localclientnum) {
        if (getdvarint(#"hash_af3e02adb15e8ec", 0) > 0) {
            level thread function_fb399a61(localclientnum);
            return;
        }
        util::add_devgui(localclientnum, "<dev string:x154>" + "<dev string:x16c>", "<dev string:x17f>");
        level thread function_622b5dc0(localclientnum);
    }

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0x8a583d4b, Offset: 0x4150
    // Size: 0xa4
    function function_622b5dc0(localclientnum) {
        level endon(#"game_ended");
        while (true) {
            if (getdvarint(#"hash_af3e02adb15e8ec", 0) > 0) {
                util::remove_devgui(localclientnum, "<dev string:x154>" + "<dev string:x16c>");
                level thread function_fb399a61(localclientnum);
                return;
            }
            wait 1;
        }
    }

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0x9e16eae5, Offset: 0x4200
    // Size: 0x6f2
    function function_fb399a61(localclientnum) {
        lui_camera::function_969a2881("<dev string:x130>", &function_4920c25a, 1, undefined, undefined, 0);
        lui_camera::function_1337c436("<dev string:x130>", "<dev string:x1a9>");
        target = struct::get(#"character_staging_extracam1");
        assert(isdefined(target));
        var_663588d = "<dev string:x154>";
        var_f4b452be = [1:"<dev string:x1cc>", 3:"<dev string:x1d2>", 0:"<dev string:x1d8>"];
        var_8d6e963c = ["<dev string:xac>", 2:"<dev string:x1de>", 3:"<dev string:x1e7>", 4:"<dev string:xb4>", 5:"<dev string:x1f5>", 6:"<dev string:x201>", 7:"<dev string:x20b>"];
        foreach (mode, display_name in var_f4b452be) {
            var_82414930 = var_663588d + display_name + "<dev string:xdb>";
            for (index = 0; index < getplayerroletemplatecount(mode); index++) {
                var_f75a02ea = function_9e72a96(function_b14806c6(index, mode));
                var_11f96a92 = var_82414930 + var_f75a02ea + "<dev string:xdb>";
                adddebugcommand(localclientnum, "<dev string:x219>" + var_11f96a92 + "<dev string:x229>" + "<dev string:x230>" + "<dev string:x236>" + "<dev string:x23f>" + "<dev string:x11c>" + mode + "<dev string:x11c>" + index + "<dev string:x11c>" + -1 + "<dev string:x11c>" + -1 + "<dev string:x24e>" + "<dev string:x253>");
                var_13240050 = function_d299ef16(index, mode);
                for (outfitindex = 0; outfitindex < var_13240050; outfitindex++) {
                    var_9cf37283 = function_d7c3cf6c(index, outfitindex, mode);
                    if (var_9cf37283.valid) {
                        var_b614b3ba = var_11f96a92 + function_9e72a96(var_9cf37283.namehash) + "<dev string:xdb>";
                        adddebugcommand(localclientnum, "<dev string:x219>" + var_b614b3ba + "<dev string:x229>" + "<dev string:x230>" + "<dev string:x236>" + "<dev string:x23f>" + "<dev string:x11c>" + mode + "<dev string:x11c>" + index + "<dev string:x11c>" + outfitindex + "<dev string:x11c>" + -1 + "<dev string:x24e>" + "<dev string:x253>");
                        if (mode == 1) {
                            adddebugcommand(localclientnum, "<dev string:x219>" + var_b614b3ba + "<dev string:x258>" + "<dev string:x230>" + "<dev string:x236>" + "<dev string:x23f>" + "<dev string:x11c>" + mode + "<dev string:x11c>" + index + "<dev string:x11c>" + outfitindex + "<dev string:x11c>" + 8 + "<dev string:x24e>" + "<dev string:x253>");
                        }
                        foreach (type, name in var_8d6e963c) {
                            if (function_2351cba1(type, mode)) {
                                adddebugcommand(localclientnum, "<dev string:x219>" + var_b614b3ba + name + "<dev string:x230>" + "<dev string:x236>" + "<dev string:x23f>" + "<dev string:x11c>" + mode + "<dev string:x11c>" + index + "<dev string:x11c>" + outfitindex + "<dev string:x11c>" + type + "<dev string:x24e>" + "<dev string:x253>");
                            }
                        }
                        waitframe(1);
                    }
                }
            }
        }
        setdvar(#"char_render", "<dev string:x150>");
        var_f7a528f2 = "<dev string:x150>";
        while (true) {
            wait 0.1;
            if (getdvarstring(#"char_render", var_f7a528f2) != var_f7a528f2) {
                var_f7a528f2 = getdvarstring(#"char_render");
                if (var_f7a528f2 != "<dev string:x150>") {
                    level notify("<dev string:x121>" + localclientnum, {#menu:"<dev string:x130>", #status:"<dev string:x263>", #state:var_f7a528f2});
                }
            }
        }
    }

    // Namespace frontend/frontend
    // Params 6, eflags: 0x0
    // Checksum 0x69c99845, Offset: 0x4900
    // Size: 0x2b4
    function function_5d6480a0(localclientnum, weapon, weapon_model, weapon_name, var_2d8a24a3, var_f879230e) {
        camo_index = var_2d8a24a3.item_index == 0 ? 0 : function_8b51d9d1(hash(var_2d8a24a3.name));
        var_9ce34e01 = var_2d8a24a3.name;
        if (isdefined(camo_index)) {
            activecamoinfo = activecamo::function_13e12ab1(camo_index);
            if (isdefined(activecamoinfo) && activecamoinfo.stages.size > 1) {
                var_3594168e = activecamoinfo.stages[2];
                if (!is_true(var_3594168e.disabled)) {
                    camo_index = function_8b51d9d1(var_3594168e.camooption);
                    var_9ce34e01 = function_9e72a96(var_3594168e.camooption);
                } else {
                    var_3594168e = undefined;
                }
            }
            if (isdefined(level.var_43aac701[localclientnum])) {
                weapon_model stoprenderoverridebundle(level.var_43aac701[localclientnum]);
                level.var_43aac701[localclientnum] = undefined;
            }
            render_options = function_6eff28b5(camo_index, 0, 0);
            weapon_model useweaponmodel(weapon, undefined, render_options, var_f879230e);
            if (isdefined(var_3594168e)) {
                activecamo::function_6c9e0e1a(localclientnum, weapon_model, var_3594168e, level.var_43aac701);
            }
            iteration = 0;
            do {
                wait 0.5;
                iteration++;
            } while (!weapon_model isstreamed(8, 8) && iteration < 1);
            wait 2;
            function_da10fc8f(localclientnum, "<dev string:x26d>" + weapon_name + "<dev string:xdb>" + weapon_name + "<dev string:x280>" + var_9ce34e01 + "<dev string:xfb>");
        }
    }

    // Namespace frontend/frontend
    // Params 3, eflags: 0x0
    // Checksum 0xccf3a443, Offset: 0x4bc0
    // Size: 0x56c
    function function_f2c538de(localclientnum, *menu_name, state) {
        self notify("<dev string:x285>");
        self endon("<dev string:x285>");
        args = strtok(state, "<dev string:x11c>");
        weapon_name = args[0];
        camo = int(args[1]);
        var_c58c03de = int(args[2]);
        filter = args[3];
        function_25485718();
        var_38b900c2 = getent(menu_name, "<dev string:x45>", "<dev string:x5d>");
        var_51a0f339 = getent(menu_name, "<dev string:x6b>", "<dev string:x5d>");
        var_38b900c2 show();
        var_51a0f339 hide();
        weapon = getweapon(weapon_name);
        target = struct::get(#"weapon_icon_staging");
        weapon_model = spawn(menu_name, target.origin, "<dev string:x299>");
        weapon_model.targetname = "<dev string:x2a9>";
        weapon_model.angles = target.angles;
        weapon_model sethighdetail();
        weapon_model useweaponmodel(weapon);
        s_info = customclass::function_3bff05ba(weapon);
        weapon_model setscale(s_info.scale);
        level thread scene::play(#"scene_frontend_weapon_camo_render");
        if (camo != -2) {
            options = function_ea647602("<dev string:x2c0>");
            if (camo == -1) {
                start_index = 0;
                end_index = options.size - 1;
            } else {
                start_index = camo;
                end_index = camo;
            }
            for (i = start_index; i <= end_index; i++) {
                var_2d8a24a3 = options[i];
                if (filter != "<dev string:x2c8>") {
                    category = function_57411076(var_2d8a24a3.name);
                    if (filter == "<dev string:x2d0>") {
                        if (category != "<dev string:x2df>" && category != "<dev string:x2e7>" && category != "<dev string:x2ef>") {
                            continue;
                        }
                    } else if (category != filter) {
                        continue;
                    }
                }
                function_5d6480a0(menu_name, weapon, weapon_model, weapon_name, var_2d8a24a3, 0);
            }
        }
        if (var_c58c03de != 0) {
            if (var_c58c03de == -1) {
                start_index = 0;
                end_index = weapon.var_2a2adea3;
            } else {
                start_index = var_c58c03de;
                end_index = var_c58c03de + 1;
            }
            for (i = start_index; i < end_index; i++) {
                function_5d6480a0(menu_name, weapon, weapon_model, weapon_name, {#item_index:0, #name:"<dev string:x2f7>" + i}, function_e601ff48(weapon, i));
            }
        }
        level thread scene::stop(#"scene_frontend_weapon_camo_render");
        level notify("<dev string:x121>" + menu_name, {#menu:"<dev string:x305>", #status:"<dev string:x146>"});
        weapon_model delete();
        setdvar(#"weap_render", "<dev string:x150>");
        function_59013397();
    }

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0xbef9ff6d, Offset: 0x5138
    // Size: 0x26
    function function_d583ca36(weapon) {
        return weapon.inventorytype == "<dev string:x318>";
    }

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0x5857911, Offset: 0x5168
    // Size: 0x7ca
    function function_db3c4c69(localclientnum) {
        lui_camera::function_969a2881("<dev string:x305>", &function_f2c538de, 1, undefined, undefined, 0);
        target = struct::get(#"weapon_icon_staging");
        assert(isdefined(target));
        level.var_43aac701 = [];
        var_663588d = "<dev string:x323>";
        root_weapon = var_663588d + "<dev string:x33e>";
        a_weapons = enumerateweapons("<dev string:x352>");
        if (!isdefined(a_weapons)) {
            a_weapons = [];
        }
        a_weapons = array::filter(a_weapons, 1, &function_d583ca36);
        foreach (weapon in a_weapons) {
            name = getweaponname(weapon);
            var_ee63b362 = root_weapon + "<dev string:xdb>" + name;
            adddebugcommand(localclientnum, "<dev string:x219>" + var_ee63b362 + "<dev string:x35c>" + "<dev string:x367>" + "<dev string:x11c>" + name + "<dev string:x37b>");
        }
        setdvar(#"hash_1311d7636a782655", "<dev string:x150>");
        setdvar(#"weap_render", "<dev string:x150>");
        var_c11ba901 = array("<dev string:x2d0>", "<dev string:x2df>", "<dev string:x2e7>", "<dev string:x2ef>", "<dev string:x381>", "<dev string:x38b>", "<dev string:x397>");
        weapon_name = "<dev string:x150>";
        var_f7a528f2 = "<dev string:x150>";
        while (true) {
            wait 0.1;
            if (getdvarstring(#"hash_1311d7636a782655", weapon_name) != weapon_name) {
                weapon_name = getdvarstring(#"hash_1311d7636a782655");
                if (weapon_name != "<dev string:x150>") {
                    foreach (weapon in a_weapons) {
                        name = getweaponname(weapon);
                        if (name != weapon_name) {
                            continue;
                        }
                        var_c001baa1 = var_663588d + "<dev string:xdb>" + name;
                        adddebugcommand(localclientnum, "<dev string:x219>" + var_c001baa1 + "<dev string:x3a0>" + "<dev string:x35c>" + "<dev string:x3aa>" + "<dev string:x11c>" + name + "<dev string:x11c>" + -1 + "<dev string:x11c>" + -1 + "<dev string:x11c>" + "<dev string:x2c8>" + "<dev string:x37b>");
                        for (i = 0; i < var_c11ba901.size; i++) {
                            type = var_c11ba901[i];
                            adddebugcommand(localclientnum, "<dev string:x219>" + var_c001baa1 + "<dev string:xdb>" + type + "<dev string:x3b9>" + 2 + i + "<dev string:x35c>" + "<dev string:x3aa>" + "<dev string:x11c>" + name + "<dev string:x11c>" + -1 + "<dev string:x11c>" + -1 + "<dev string:x11c>" + type + "<dev string:x37b>");
                        }
                        options = function_ea647602("<dev string:x2c0>");
                        foreach (i, option in options) {
                            adddebugcommand(localclientnum, "<dev string:x219>" + var_c001baa1 + "<dev string:xdb>" + option.name + "<dev string:x35c>" + "<dev string:x3aa>" + "<dev string:x11c>" + name + "<dev string:x11c>" + i + "<dev string:x11c>" + 0 + "<dev string:x11c>" + "<dev string:x2c8>" + "<dev string:x37b>");
                        }
                        for (i = 0; i < weapon.var_2a2adea3; i++) {
                            adddebugcommand(localclientnum, "<dev string:x219>" + var_c001baa1 + "<dev string:x3be>" + i + "<dev string:x35c>" + "<dev string:x3aa>" + "<dev string:x11c>" + name + "<dev string:x11c>" + -2 + "<dev string:x11c>" + i + "<dev string:x11c>" + "<dev string:x2c8>" + "<dev string:x37b>");
                        }
                    }
                }
            }
            if (getdvarstring(#"weap_render", var_f7a528f2) != var_f7a528f2) {
                var_f7a528f2 = getdvarstring(#"weap_render");
                if (var_f7a528f2 != "<dev string:x150>") {
                    level notify("<dev string:x121>" + localclientnum, {#menu:"<dev string:x305>", #status:"<dev string:x263>", #state:var_f7a528f2});
                }
            }
        }
    }

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0xf6015937, Offset: 0x5940
    // Size: 0xbc
    function function_3d29f330(localclientnum) {
        util::add_devgui(localclientnum, "<dev string:x3cd>" + "<dev string:x16c>", "<dev string:x3e2>");
        while (getdvarint(#"hash_2a806885aa30e65b", 0) == 0) {
            wait 1;
        }
        util::remove_devgui(localclientnum, "<dev string:x3cd>" + "<dev string:x16c>");
        function_ea9a5e69(localclientnum);
    }

    // Namespace frontend/frontend
    // Params 0, eflags: 0x0
    // Checksum 0xc357be96, Offset: 0x5a08
    // Size: 0x1a
    function function_671eb8fa() {
        return [1:"<dev string:x40a>"];
    }

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0xc25aaef9, Offset: 0x5a30
    // Size: 0x522
    function function_ea9a5e69(localclientnum) {
        lui_camera::function_969a2881("<dev string:x413>", &function_4cd43ca2, 1, undefined, undefined, 0);
        var_2067e07 = function_671eb8fa();
        adddebugcommand(localclientnum, "<dev string:x219>" + "<dev string:x3cd>" + "<dev string:x427>" + "<dev string:x435>" + "<dev string:x11c>" + -1 + "<dev string:x11c>" + -1 + "<dev string:x37b>");
        foreach (type, name in var_2067e07) {
            adddebugcommand(localclientnum, "<dev string:x219>" + "<dev string:x3cd>" + name + "<dev string:x35c>" + "<dev string:x435>" + "<dev string:x11c>" + -1 + "<dev string:x11c>" + type + "<dev string:x37b>");
        }
        assert(isdefined(getent(localclientnum, "<dev string:x447>", "<dev string:x5d>")));
        assert(isdefined(struct::get(#"fx_trail_start")));
        assert(isdefined(struct::get(#"fx_trail_end")));
        jumpkits = namespace_eb06e24d::get_jumpkits();
        foreach (i, jumpkit in jumpkits) {
            name = function_9e72a96(jumpkit);
            var_c23e6a40 = "<dev string:x3cd>" + name + "<dev string:xdb>";
            adddebugcommand(localclientnum, "<dev string:x219>" + var_c23e6a40 + "<dev string:x229>" + "<dev string:x35c>" + "<dev string:x435>" + "<dev string:x11c>" + i + "<dev string:x11c>" + -1 + "<dev string:x37b>");
            foreach (type, name in var_2067e07) {
                adddebugcommand(localclientnum, "<dev string:x219>" + var_c23e6a40 + name + "<dev string:x35c>" + "<dev string:x435>" + "<dev string:x11c>" + i + "<dev string:x11c>" + type + "<dev string:x37b>");
            }
            waitframe(1);
        }
        setdvar(#"hash_4243dd01393aa940", "<dev string:x150>");
        var_f7a528f2 = "<dev string:x150>";
        while (true) {
            wait 0.1;
            if (getdvarstring(#"hash_4243dd01393aa940", var_f7a528f2) != var_f7a528f2) {
                var_f7a528f2 = getdvarstring(#"hash_4243dd01393aa940");
                if (var_f7a528f2 != "<dev string:x150>") {
                    level notify("<dev string:x121>" + localclientnum, {#menu:"<dev string:x413>", #status:"<dev string:x263>", #state:var_f7a528f2});
                }
            }
        }
    }

    // Namespace frontend/frontend
    // Params 3, eflags: 0x0
    // Checksum 0xec9b6c8d, Offset: 0x5f60
    // Size: 0x64c
    function function_4cd43ca2(localclientnum, *menu_name, state) {
        self notify("<dev string:x458>");
        self endon("<dev string:x458>");
        args = strtok(state, "<dev string:x11c>");
        jumpkit = int(args[0]);
        type = int(args[1]);
        function_25485718();
        var_38b900c2 = getent(menu_name, "<dev string:x45>", "<dev string:x5d>");
        var_51a0f339 = getent(menu_name, "<dev string:x6b>", "<dev string:x5d>");
        var_38b900c2 show();
        var_51a0f339 hide();
        if (jumpkit == -1) {
            var_d4e4e3a8 = 0;
            var_dcb0ef67 = namespace_eb06e24d::function_3045dd71() - 1;
        } else {
            var_d4e4e3a8 = jumpkit;
            var_dcb0ef67 = jumpkit;
        }
        types = function_671eb8fa();
        if (type != -1) {
            type_data = types[type];
            types = [];
            types[type] = type_data;
        }
        var_351da865 = getent(menu_name, "<dev string:x447>", "<dev string:x5d>");
        fx_start = struct::get(#"fx_trail_start");
        fx_end = struct::get(#"fx_trail_end");
        foreach (type, type_name in types) {
            switch (type) {
            case 1:
                level thread scene::play(#"scene_frontend_fxtrail_render");
                break;
            default:
                continue;
            }
            for (i = var_d4e4e3a8; i <= var_dcb0ef67; i++) {
                kit_name = namespace_eb06e24d::get_jumpkits()[i];
                switch (type) {
                case 1:
                    trail = namespace_eb06e24d::function_6452f9c5(i);
                    if (!isdefined(trail) || !isdefined(trail.body_trail)) {
                        continue;
                    }
                    var_351da865.origin = fx_start.origin;
                    handle = util::playfxontag(menu_name, trail.body_trail, var_351da865, "<dev string:x46c>");
                    if (!isdefined(handle)) {
                        continue;
                    }
                    direction = fx_end.origin - fx_start.origin;
                    step_size = direction / getdvarint(#"hash_522e5987825dd16e", 100);
                    for (var_d7f46807 = 0; var_d7f46807 <= getdvarint(#"hash_522e5987825dd16e", 100); var_d7f46807++) {
                        waitframe(1);
                        var_351da865.origin += step_size;
                    }
                    function_da10fc8f(menu_name, "<dev string:x47a>" + function_9e72a96(kit_name) + "<dev string:xdb>" + function_9e72a96(trail.name) + "<dev string:x48e>");
                    killfx(menu_name, handle);
                    break;
                default:
                    continue;
                }
                waitframe(1);
            }
            switch (type) {
            case 1:
                level thread scene::stop(#"scene_frontend_fxtrail_render");
            default:
                break;
            }
        }
        level notify("<dev string:x121>" + menu_name, {#menu:"<dev string:x413>", #status:"<dev string:x146>"});
        setdvar(#"hash_4243dd01393aa940", "<dev string:x150>");
        function_59013397();
    }

#/

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xe033d1af, Offset: 0x65b8
// Size: 0x10c
function function_8567daf2(localclientnum, var_302876c9) {
    /#
        var_cd31cd6a = getdvarstring(#"hash_575aeb603638c901", "<dev string:x150>");
        if (var_cd31cd6a != "<dev string:x150>") {
            return getweapon(var_cd31cd6a);
        }
    #/
    if (!isdefined(var_302876c9) || var_302876c9 == 0) {
        var_bba3d6af = function_a699aed5(localclientnum);
    }
    if (isdefined(var_bba3d6af.weapon) && var_bba3d6af.weapon !== level.weaponnone) {
        return var_bba3d6af.weapon;
    }
    return getweapon(#"ar_accurate_t9");
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x224b5e02, Offset: 0x66d0
// Size: 0xaa
function function_1fa47915(localclientnum, var_302876c9) {
    /#
        var_cd31cd6a = getdvarstring(#"hash_575aeb603638c901", "<dev string:x150>");
        if (var_cd31cd6a != "<dev string:x150>") {
            return undefined;
        }
    #/
    if (!isdefined(var_302876c9) || var_302876c9 == 0) {
        var_bba3d6af = function_a699aed5(localclientnum);
    }
    return var_bba3d6af.renderoptionsweapon;
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x569412c8, Offset: 0x6788
// Size: 0x112
function function_d47a6728(*localclientnum, var_302876c9) {
    if (!isdefined(var_302876c9) || var_302876c9 == 0) {
        character = level.var_1c43dd3e;
    } else {
        character = level.var_6f1da91a[function_f701ad2a()][var_302876c9].character;
    }
    if (!isdefined(character) || !isclass(character)) {
        return (randomint(2) < 0 ? "male" : "female");
    }
    n_character_index = [[ character ]]->get_character_index();
    var_3b97696d = getherogender(n_character_index, 1);
    return var_3b97696d;
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xe8974eed, Offset: 0x68a8
// Size: 0xcc
function function_65d7f2a7(localclientnum) {
    target_name = "player_start";
    var_50896672 = getent(localclientnum, target_name, "targetname");
    if (!isdefined(var_50896672)) {
        var_50896672 = util::spawn_model(localclientnum, "tag_origin");
        var_50896672.targetname = target_name;
    }
    var_50896672 useanimtree("all_player");
    level.var_1c43dd3e = character_customization::function_dd295310(var_50896672, localclientnum, 0);
    function_aba0885b(localclientnum);
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x4b1577a9, Offset: 0x6980
// Size: 0x6c
function function_becded4f(localclientnum) {
    level.var_44011752 = util::spawn_model(localclientnum, #"wpn_t8_ar_accurate_prop_animate", (0, 0, 0), (0, 0, 0));
    level.var_44011752.targetname = "customized_inspection_weapon";
    level.var_44011752 hide();
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x5400950d, Offset: 0x69f8
// Size: 0x90
function function_a588eb2e(localclientnum) {
    var_e6977977 = util::spawn_model(localclientnum, #"wpn_t8_ar_accurate_prop_animate", (0, 0, 0), (0, 0, 0));
    var_e6977977.targetname = "quartermaster_weapon";
    var_e6977977 hide();
    var_e6977977 sethighdetail(1, 1);
    level.var_324c3190 = [];
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x6fae0a46, Offset: 0x6a90
// Size: 0x32c
function localclientconnect(localclientnum) {
    println("<dev string:x496>" + localclientnum);
    var_acd4d941 = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_acd4d941.targetname = "__masked_char";
    var_22f20461 = character_customization::function_dd295310(var_acd4d941, localclientnum, 0);
    [[ var_22f20461 ]]->function_1ec9448d(1);
    [[ var_22f20461 ]]->update();
    function_becded4f(localclientnum);
    function_a588eb2e(localclientnum);
    function_65d7f2a7(localclientnum);
    level thread function_f00ff0c7(localclientnum);
    level thread function_45827126();
    if (isdefined(level.charactercustomizationsetup)) {
        [[ level.charactercustomizationsetup ]](localclientnum);
    }
    if (isdefined(level.weaponcustomizationiconsetup)) {
        [[ level.weaponcustomizationiconsetup ]](localclientnum);
    }
    callback::callback(#"on_localclient_connect", localclientnum);
    customclass::localclientconnect(localclientnum);
    roommodel = getuimodel(function_5f72e972(#"lobby_root"), "room");
    room = getuimodelvalue(roommodel);
    postfx::setfrontendstreamingoverlay(localclientnum, "frontend", 1);
    toggle_postfx(localclientnum, 1, #"pstfx_frontend");
    level.frontendclientconnected = 1;
    level notify("menu_change" + localclientnum, {#menu:"PressStart", #status:"opened", #state:room});
    /#
        level function_92087f1b(localclientnum);
        level thread function_db3c4c69(localclientnum);
        level thread function_3d29f330(localclientnum);
        level thread function_90646a7f(localclientnum);
    #/
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x6dc8
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x6dd8
// Size: 0x4
function onstartgametype() {
    
}

// Namespace frontend/frontend
// Params 4, eflags: 0x0
// Checksum 0xbf8ba505, Offset: 0x6de8
// Size: 0x30e
function function_175db490(localclientnum, var_d0b01271, waitresult, params) {
    fields = [[ var_d0b01271 ]]->function_e8b0acef();
    if (isdefined(fields)) {
        params.var_401d9a1 = 1;
        params.var_c76f3e47 = 1;
        if (lui_camera::is_current_menu(localclientnum, "PersonalizeCharacter", "character") || lui_camera::is_current_menu(localclientnum, "PersonalizeCharacter", "face")) {
            var_7d79c1a5 = [[ var_d0b01271 ]]->function_782bdd96();
            if (isdefined(var_7d79c1a5)) {
                params.scene = var_7d79c1a5;
            } else {
                params.scene = function_2ca65924(var_d0b01271);
            }
            if (var_d0b01271 character_customization::function_f40eb809()) {
                function_286efebf(localclientnum, var_d0b01271, params);
            } else {
                var_814ef009 = [[ var_d0b01271 ]]->function_1f70adfe();
                if (isdefined(var_814ef009)) {
                    params.var_a68ab9c2 = var_814ef009;
                    if (var_814ef009 == "turn_cw_idle" || var_814ef009 == "turn_ccw_idle") {
                        model = [[ var_d0b01271 ]]->function_217b10ed();
                        params.scene_target = {#origin:model.origin, #angles:model.angles};
                    }
                } else {
                    params.var_a68ab9c2 = "change_skin_idle";
                    params.scene_target = level;
                }
            }
            params.var_a34c858c = 1;
            params.var_f5332569 = [[ var_d0b01271 ]]->function_98d70bef();
            params.activeweapon = function_8567daf2(localclientnum);
            params.var_b8f20727 = function_1fa47915(localclientnum);
            return;
        }
        if (lui_camera::is_current_menu(localclientnum, "AARMissionRewardOverlay", waitresult.character_index)) {
            params.scene = fields.var_be6ea125;
            params.scene_target = struct::get(#"hash_dd8a67627ed7326");
            return;
        }
        if (lui_camera::is_current_menu(localclientnum, "MPSpecialistHUBGestures")) {
            params.anim_name = [[ var_d0b01271 ]]->function_8144231c();
            params.align_struct = struct::get(#"cac_specialist");
            params.scene = undefined;
        }
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x98e5cb2f, Offset: 0x7100
// Size: 0x222
function function_286efebf(localclientnum, var_d0b01271, params) {
    if (!isdefined(params.scene)) {
        params = spawnstruct();
        fields = [[ var_d0b01271 ]]->function_e8b0acef();
        var_7d79c1a5 = [[ var_d0b01271 ]]->function_782bdd96();
        if (isdefined(var_7d79c1a5)) {
            params.scene = var_7d79c1a5;
        } else {
            params.scene = function_2ca65924(var_d0b01271);
        }
    }
    model = [[ var_d0b01271 ]]->function_217b10ed();
    s_align = {#origin:isdefined(var_d0b01271.var_ae32b908) ? var_d0b01271.var_ae32b908 : model.origin, #angles:isdefined(var_d0b01271.var_aba63ea) ? var_d0b01271.var_aba63ea : model.angles};
    params.var_401d9a1 = 1;
    params.var_c76f3e47 = 1;
    params.var_a34c858c = 1;
    params.scene_target = s_align;
    params.var_bfbc1f4f = 1;
    params.activeweapon = function_8567daf2(localclientnum);
    params.var_b8f20727 = function_1fa47915(localclientnum);
    params.var_74741b75 = var_d0b01271.var_c492e538;
    if (params.var_74741b75 === "turn_cw_intro") {
        params.var_a68ab9c2 = "turn_cw_idle";
    } else {
        params.var_a68ab9c2 = "turn_ccw_idle";
    }
    var_b1e821c5 = {#blend:0};
    params.var_b1e821c5 = var_b1e821c5;
    return params;
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x9ea2db69, Offset: 0x7330
// Size: 0x274
function function_763f40c4(localclientnum, menu_name, state) {
    level endon(menu_name + "_closed");
    str_scene = function_2ca65924(level.var_1c43dd3e);
    if (!isdefined(state)) {
        params = {#scene:str_scene, #var_74741b75:undefined, #var_a68ab9c2:"change_skin_idle", #var_a34c858c:1, #activeweapon:function_8567daf2(localclientnum), #var_b8f20727:function_1fa47915(localclientnum)};
        [[ level.var_1c43dd3e ]]->update(params);
        var_cd34be2e = {#str_scene:params.scene, #var_c76d5a0b:"turn_cw_intro", #var_e982dc6b:"turn_ccw_idle", #var_3480dd47:"turn_ccw_intro", #var_1aa99c8b:"turn_ccw_idle"};
        if (getdvarint(#"hash_4ae5fc5108968bfe", 0)) {
            level thread character_customization::rotation_thread_spawner(localclientnum, level.var_1c43dd3e, ["end_character_rotating" + localclientnum, "PersonalizeCharacter_closed"], var_cd34be2e);
        }
        level childthread character_customization::updateeventthread(localclientnum, level.var_1c43dd3e, "updateSpecialistCustomization", &function_175db490);
        return;
    }
    if (state === "character") {
        return;
    }
    if (state === "face") {
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x1abc3608, Offset: 0x75b0
// Size: 0xb2
function function_2ca65924(var_d0b01271) {
    fields = [[ var_d0b01271 ]]->function_e8b0acef();
    if (isdefined(fields.var_bb70c379) && scene::function_9730988a(fields.var_bb70c379, "select_intro") && scene::function_9730988a(fields.var_bb70c379, "select_idle")) {
        var_dde940e7 = fields.var_bb70c379;
    } else {
        var_dde940e7 = #"scene_frontend_t9_character";
    }
    return var_dde940e7;
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xcfbff614, Offset: 0x7670
// Size: 0xec
function function_84ba276(localclientnum, character_index) {
    self notify("1ab76239e21a983b");
    self endon("1ab76239e21a983b");
    level endon(#"hash_cf870c6cd8a0798");
    level flag::set("waiting_for_character_change");
    wait getdvarfloat(#"hash_720d4385f4e050c2", 0.5);
    level flag::clear("waiting_for_character_change");
    var_dd102759 = character_customization::function_7474681d(localclientnum, 1, character_index);
    level thread function_90cad834(localclientnum, 0, var_dd102759);
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x86a1bfa9, Offset: 0x7768
// Size: 0x190
function function_c5aa56cd(localclientnum) {
    self notify("1cf8a04e5a0b0b60");
    self endon("1cf8a04e5a0b0b60");
    while (true) {
        var_bec52aca = level waittill(#"hash_cf870c6cd8a0798");
        character_index = var_bec52aca.character_index;
        if (isdefined(character_index)) {
            if (isdefined(level.var_1c43dd3e) && [[ level.var_1c43dd3e ]]->get_character_index() != character_index) {
                level.var_45cf7171 = character_index;
                level thread function_84ba276(localclientnum, level.var_45cf7171);
            } else {
                level.var_45cf7171 = undefined;
            }
            continue;
        }
        level.var_45cf7171 = undefined;
        mode = currentsessionmode();
        character_index = getequippedheroindex(localclientnum, mode);
        if (isdefined(level.var_1c43dd3e) && [[ level.var_1c43dd3e ]]->get_character_index() != character_index) {
            var_dd102759 = character_customization::function_7474681d(localclientnum, mode, character_index);
            level thread function_90cad834(localclientnum, 0, var_dd102759);
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x9546bb3b, Offset: 0x7900
// Size: 0x54
function start_character_rotating_any(localclientnum, menu_data) {
    maxlocalclient = getmaxlocalclients();
    while (localclientnum < maxlocalclient) {
        start_character_rotating(localclientnum, menu_data);
        localclientnum++;
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x87dad7eb, Offset: 0x7960
// Size: 0x54
function end_character_rotating_any(localclientnum, menu_data) {
    maxlocalclient = getmaxlocalclients();
    while (localclientnum < maxlocalclient) {
        end_character_rotating(localclientnum, menu_data);
        localclientnum++;
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x60e7d7c3, Offset: 0x79c0
// Size: 0x44
function start_character_rotating(localclientnum, menu_data) {
    level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "end_character_rotating" + localclientnum);
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x50468b06, Offset: 0x7a10
// Size: 0x2a
function end_character_rotating(localclientnum, *menu_data) {
    level notify("end_character_rotating" + menu_data);
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x803ed514, Offset: 0x7a48
// Size: 0x118
function function_b0442428(var_ce754e62, var_3f0e790b) {
    if (isdefined(var_ce754e62) && isdefined(var_ce754e62[var_3f0e790b])) {
        foreach (object in var_ce754e62[var_3f0e790b]) {
            var_2d0192e5 = [[ object.character ]]->function_82e05d64();
            if (isdefined(var_2d0192e5) && isdefined(var_2d0192e5.entnummodel) && isdefined([[ object.character ]]->function_217b10ed())) {
                setuimodelvalue(var_2d0192e5.entnummodel, [[ object.character ]]->function_47cb6b19());
            }
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x8a514516, Offset: 0x7b68
// Size: 0xf0
function function_f5eca51d(var_ce754e62, var_3f0e790b) {
    if (isdefined(var_ce754e62) && isdefined(var_ce754e62[var_3f0e790b])) {
        foreach (object in var_ce754e62[var_3f0e790b]) {
            var_2d0192e5 = [[ object.character ]]->function_82e05d64();
            if (isdefined(var_2d0192e5) && isdefined(var_2d0192e5.entnummodel)) {
                setuimodelvalue(var_2d0192e5.entnummodel, -1);
            }
        }
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xd27053f7, Offset: 0x7c60
// Size: 0x254
function function_e1f85a64(ccobject, index, var_3f0e790b) {
    var_6b71abc1 = function_5f72e972(#"lobby_clients");
    var_c4caf9dd = getuimodel(var_6b71abc1, string(index + 1));
    if (!isdefined(var_c4caf9dd)) {
        return;
    }
    [[ ccobject ]]->function_82e05d64().entnummodel = createuimodel(var_c4caf9dd, "entNum");
    [[ ccobject ]]->function_82e05d64().var_3f0e790b = var_3f0e790b;
    [[ ccobject ]]->function_184a4d2e(&function_8be87802);
    entnum = getuimodelvalue([[ ccobject ]]->function_82e05d64().entnummodel);
    if (!isdefined(entnum)) {
        setuimodelvalue([[ ccobject ]]->function_82e05d64().entnummodel, [[ ccobject ]]->function_47cb6b19());
    }
    [[ ccobject ]]->function_82e05d64().visible_model = getuimodel(var_c4caf9dd, "visible");
    setuimodelvalue([[ ccobject ]]->function_82e05d64().visible_model, [[ ccobject ]]->function_ea4ac9f8() && [[ ccobject ]]->is_visible());
    var_2097336a = createuimodel(var_c4caf9dd, "sprayGestureIndex");
    [[ ccobject ]]->function_82e05d64().var_5da50127 = var_2097336a;
    setuimodelvalue(var_2097336a, isdefined(getuimodelvalue(var_2097336a)) ? getuimodelvalue(var_2097336a) : -1);
}

// Namespace frontend/frontend
// Params 6, eflags: 0x0
// Checksum 0xddf45d20, Offset: 0x7ec0
// Size: 0x2a4
function function_f00765ad(localclientnum, xuid, ccobject, index, var_3f0e790b, var_2451e8ac) {
    ccobject notify("42fdda373bc47f92");
    ccobject endon("42fdda373bc47f92");
    level endon(#"lobby_change", #"disconnect");
    iterations = 0;
    var_a65df30 = [[ ccobject ]]->function_e599283f();
    current_index = [[ ccobject ]]->get_character_index();
    var_23904c1d = getcharactercustomizationforxuid(localclientnum, xuid);
    while (!isdefined(var_23904c1d) && iterations < 15) {
        wait 1;
        var_23904c1d = getcharactercustomizationforxuid(localclientnum, xuid);
        iterations++;
    }
    [[ ccobject ]]->show_model();
    [[ ccobject ]]->set_xuid(xuid);
    [[ ccobject ]]->set_character_mode(1);
    if (!isdefined(var_23904c1d) || var_23904c1d.charactermode != currentsessionmode() || !function_b9f8bbd9(var_23904c1d.charactertype, var_23904c1d.charactermode)) {
        var_23904c1d = undefined;
        character_index = function_e3efec59(localclientnum, xuid, 1, var_3f0e790b, undefined);
        if (isdefined(character_index)) {
            [[ ccobject ]]->set_character_index(character_index);
        }
    }
    if (isdefined(var_23904c1d)) {
        if (character_customization::function_aa5382ed(var_23904c1d, var_a65df30, 0)) {
            function_c033e4cc(localclientnum, var_2451e8ac, ccobject, index, var_23904c1d);
        }
    } else {
        [[ ccobject ]]->set_character_index(character_index);
        [[ ccobject ]]->function_22039feb();
        function_c033e4cc(localclientnum, var_2451e8ac, ccobject, index);
    }
    function_e1f85a64(ccobject, index, var_3f0e790b);
}

// Namespace frontend/frontend
// Params 5, eflags: 0x0
// Checksum 0xd7b95981, Offset: 0x8170
// Size: 0x174
function function_c033e4cc(localclientnum, var_2451e8ac, ccobject, index, var_7f395102) {
    if (isdefined(var_2451e8ac)) {
        switch (var_2451e8ac) {
        case #"character_change":
            level thread function_90cad834(localclientnum, 0, var_7f395102);
            break;
        case #"lobby_intro":
            if (isdefined(var_7f395102)) {
                [[ ccobject ]]->function_15a8906a(var_7f395102);
            }
            level thread function_c47e078a(1, index, ccobject, localclientnum);
            break;
        case #"lobby_idle":
        default:
            if (isdefined(var_7f395102)) {
                [[ ccobject ]]->function_15a8906a(var_7f395102);
            }
            level thread function_c47e078a(0, index, ccobject, localclientnum);
            break;
        }
        return;
    }
    params = {#var_c76f3e47:1, #var_401d9a1:1};
    [[ ccobject ]]->update(params);
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xfed941e1, Offset: 0x82f0
// Size: 0x1ce
function function_7c77108d(localclientnum, &var_13ef9467, var_63aea26e) {
    for (i = 0; true; i++) {
        target = struct::get(var_63aea26e + i);
        if (!isdefined(target)) {
            break;
        }
        charactermodel = util::spawn_model(localclientnum, "tag_origin", target.origin, target.angles);
        charactermodel.targetname = var_63aea26e + "character_" + i;
        if (is_true(level.var_633071d0) && i == 0 && isclass(level.var_1c43dd3e)) {
            var_a4fe2697 = level.var_1c43dd3e;
        } else {
            var_a4fe2697 = character_customization::function_dd295310(charactermodel, localclientnum, 0);
        }
        var_ac2e02ac = {#target:target, #character:var_a4fe2697, #scene_name:undefined};
        if (!isdefined(var_13ef9467)) {
            var_13ef9467 = [];
        } else if (!isarray(var_13ef9467)) {
            var_13ef9467 = array(var_13ef9467);
        }
        var_13ef9467[var_13ef9467.size] = var_ac2e02ac;
    }
    return i;
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x4ee939b5, Offset: 0x84c8
// Size: 0x114
function function_8be87802(*localclientnum, character) {
    var_2d0192e5 = [[ character ]]->function_82e05d64();
    if (!(isdefined(var_2d0192e5) && isdefined(var_2d0192e5.entnummodel))) {
        return;
    }
    var_c2ab6c5b = function_f701ad2a();
    if (var_2d0192e5.var_3f0e790b === var_c2ab6c5b) {
        setuimodelvalue(var_2d0192e5.entnummodel, [[ character ]]->function_47cb6b19());
    }
    if (isdefined(var_2d0192e5.var_3f0e790b) && isdefined(var_c2ab6c5b) && var_2d0192e5.var_3f0e790b != var_c2ab6c5b) {
        character_customization::function_bee62aa1(character);
    }
    setuimodelvalue(var_2d0192e5.visible_model, [[ character ]]->function_ea4ac9f8() && [[ character ]]->is_visible());
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x9aed4e90, Offset: 0x85e8
// Size: 0x100
function function_45827126() {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"hash_6f2435126950e914");
        if (level.var_f7aea3ff != waitresult.characterindex) {
            level.var_f7aea3ff = waitresult.characterindex;
            battlechatter::function_ad01601e(waitresult.localclientnum, waitresult.characterindex);
            level notify(#"hash_cf870c6cd8a0798");
            var_4f8e8422 = character_customization::function_7474681d(waitresult.localclientnum, 1, waitresult.characterindex);
            level thread function_90cad834(waitresult.localclientnum, 0, var_4f8e8422, 1);
        }
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xe5e5d04a, Offset: 0x86f0
// Size: 0x768
function function_f00ff0c7(localclientnum) {
    level endon(#"disconnect");
    var_11302f48 = function_5f72e972(#"hash_5573c0775fbf1bb1");
    level.var_6f1da91a = [[], [], [], []];
    var_6aeec2ad = getdvarstring(#"hash_52abdac1a234fa29", "");
    var_c7581878 = function_7c77108d(localclientnum, level.var_6f1da91a[0], "lobby_player" + var_6aeec2ad + "_");
    var_c7581878 = max(function_7c77108d(localclientnum, level.var_6f1da91a[1], "lobby_player" + var_6aeec2ad + "_"), var_c7581878);
    var_c7581878 = max(function_7c77108d(localclientnum, level.var_6f1da91a[2], "lobby_player" + var_6aeec2ad + "_"), var_c7581878);
    var_c7581878 = max(function_7c77108d(localclientnum, level.var_6f1da91a[3], "lobby_player" + var_6aeec2ad + "_"), var_c7581878);
    level.var_90fa1c3e = var_c7581878;
    var_68a9a63c = [];
    while (true) {
        var_6b002e4d = var_68a9a63c.size;
        waitresult = level waittill(#"lobby_change");
        if (level.lastlobbystate === #"matchmaking" || level.lastlobbystate === #"zm_online" || level.lastlobbystate === #"lobby_pose") {
            var_68a9a63c = function_664bca26(localclientnum, 1, 0);
        } else {
            var_68a9a63c = function_77ccb73(1);
        }
        var_3d095a85 = var_68a9a63c.size;
        if (is_true(waitresult.var_a3325423) || is_true(waitresult.var_2c5ad26b)) {
            for (i = 0; i < var_c7581878; i++) {
                if (isdefined(level.var_45cf7171) && i == 0) {
                    continue;
                }
                if (i < var_68a9a63c.size) {
                    setuimodelvalue(getuimodel(var_11302f48, string(i)), var_68a9a63c[i]);
                    foreach (var_3f0e790b, character_array in level.var_6f1da91a) {
                        var_7d4d74d3 = i > character_array.size ? undefined : character_array[i];
                        if (isdefined(var_7d4d74d3)) {
                            if (level.lastlobbystate === #"mode_select" || level.lastlobbystate === #"directorselect" || level.lastlobbystate === #"room1" || level.lastlobbystate === #"room2") {
                                continue;
                            }
                            if (level.lastlobbystate === #"character_room" && i == 0) {
                                var_2451e8ac = #"character_change";
                            } else if (function_50806385(i) && is_true(waitresult.var_a3325423) && var_3d095a85 > var_6b002e4d && i >= var_6b002e4d) {
                                var_2451e8ac = #"lobby_intro";
                            } else if (function_50806385(i)) {
                                var_2451e8ac = #"lobby_idle";
                            } else {
                                var_2451e8ac = #"lobby_idle";
                            }
                            var_7d4d74d3.target thread function_f00765ad(localclientnum, var_68a9a63c[i], var_7d4d74d3.character, i, var_3f0e790b, var_2451e8ac);
                        }
                    }
                    continue;
                }
                foreach (var_3f0e790b, character_array in level.var_6f1da91a) {
                    var_7d4d74d3 = i > character_array.size ? undefined : character_array[i];
                    if (isclass(var_7d4d74d3.character) && isdefined([[ var_7d4d74d3.character ]]->function_217b10ed())) {
                        [[ var_7d4d74d3.character ]]->hide_model();
                    }
                }
            }
            forcenotifyuimodel(var_11302f48);
        }
        character_array = level.var_6f1da91a[function_f701ad2a()];
        if (isdefined(character_array)) {
            for (i = 0; i < var_c7581878; i++) {
                if (i < var_68a9a63c.size) {
                    var_7d4d74d3 = i > character_array.size ? undefined : character_array[i];
                    if (isdefined(var_7d4d74d3) && (function_34fbc01b() || function_4fd0d58e())) {
                        function_8be87802(localclientnum, var_7d4d74d3.character);
                    }
                }
            }
        }
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xbf9b07fc, Offset: 0x8e60
// Size: 0xe4
function function_50806385(n_index) {
    if ((level.lastlobbystate === #"loadout_room" || level.lastlobbystate === #"character_room" || level.lastlobbystate === #"armory") && n_index != 0 || level.lastlobbystate === #"lobby_pose" || level.lastlobbystate === #"arena_pose" || level.lastlobbystate === #"private_lobby_pose") {
        return true;
    }
    return false;
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x9164528b, Offset: 0x8f50
// Size: 0xaa
function function_34fbc01b() {
    if (level.lastlobbystate === #"lobby_pose" || level.lastlobbystate === #"private_lobby_pose" || level.lastlobbystate === #"character_room" || level.lastlobbystate === #"armory" || level.lastlobbystate === #"loadout_room") {
        return true;
    }
    return false;
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x68bdea9a, Offset: 0x9008
// Size: 0x8a
function function_4fd0d58e() {
    if (level.lastlobbystate === #"arena_pose" || level.lastlobbystate === #"character_room" || level.lastlobbystate === #"armory" || level.lastlobbystate === #"loadout_room") {
        return true;
    }
    return false;
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xb1031928, Offset: 0x90a0
// Size: 0x170
function function_b1b8f767(localclientnum, play) {
    if (play) {
        function_b0442428(level.var_6f1da91a, 0);
        var_bf321a0c = !isdefined(level.lastlobbystate) || level.lastlobbystate == "room2" || level.lastlobbystate == "mode_select";
        var_f647c5b2 = var_bf321a0c ? "intro" : undefined;
        function_aba0885b(localclientnum);
        level notify(#"hash_46855140938f532c");
        function_c47e078a(var_bf321a0c, 0, undefined, localclientnum);
        var_9032876b = function_7104551f(localclientnum);
        if (var_9032876b == 1) {
            level thread function_c336d245(localclientnum);
        }
        return;
    }
    if (!play) {
        function_f5eca51d(level.var_6f1da91a, 0);
        [[ level.var_1c43dd3e ]]->show_model();
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xbc936f5b, Offset: 0x9218
// Size: 0xbc
function function_7104551f(localclientnum) {
    var_68a9a63c = [];
    if (level.lastlobbystate === #"matchmaking" || level.lastlobbystate === #"zm_online" || level.lastlobbystate === #"lobby_pose") {
        var_68a9a63c = function_664bca26(localclientnum, 1, 0);
    } else {
        var_68a9a63c = function_77ccb73(1);
    }
    return var_68a9a63c.size;
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xf050c79, Offset: 0x92e0
// Size: 0x182
function function_c336d245(localclientnum) {
    self notify("2a3b12cfce9e765e");
    self endon("2a3b12cfce9e765e");
    while (true) {
        s_waitresult = level waittill(#"lobby_change");
        var_9032876b = function_7104551f(localclientnum);
        if (is_true(s_waitresult.var_a3325423) && var_9032876b >= 2) {
            if (function_50806385(0)) {
                if (level scene::is_playing(#"scene_frontend_t9_lobby_player1_initial", "intro")) {
                    level.var_1c43dd3e.var_72e4ebb3 = "scene_frontend_t9_lobby_player1";
                    level.var_1c43dd3e.var_31ccd6da = "xanim_only_idle";
                }
                level scene::play(#"scene_frontend_t9_lobby_player1_initial", "xcam_only_intro");
            }
            if (function_50806385(0)) {
                level thread scene::play(#"scene_frontend_t9_lobby_player1_initial", "xcam_only_idle");
            }
            return;
        }
    }
}

// Namespace frontend/frontend
// Params 4, eflags: 0x0
// Checksum 0x62658153, Offset: 0x9470
// Size: 0x54c
function function_c47e078a(var_bf321a0c = 1, var_302876c9, character, localclientnum) {
    level notify(#"hash_250179ae4bc30aef" + var_302876c9);
    level endon(#"hash_250179ae4bc30aef" + var_302876c9, #"hash_9a862f4c6d59905");
    if (!isdefined(character)) {
        if (var_302876c9 == 0) {
            character = level.var_1c43dd3e;
            var_16be1107 = function_2ca65924(character);
            level scene::cancel(#"scene_frontend_t9_character");
            level scene::cancel(var_16be1107);
            level scene::cancel(#"scene_frontend_t9_character_customization_camera");
        } else {
            character = level.var_6f1da91a[function_f701ad2a()][var_302876c9].character;
        }
    }
    str_scene = function_cfb00e7d(var_302876c9, localclientnum, character);
    a_str_shots = scene::get_all_shot_names(str_scene);
    var_78651d54 = [];
    var_fc395698 = [];
    foreach (str_shot in a_str_shots) {
        if (strstartswith(tolower(str_shot), "intro")) {
            if (!isdefined(var_78651d54)) {
                var_78651d54 = [];
            } else if (!isarray(var_78651d54)) {
                var_78651d54 = array(var_78651d54);
            }
            var_78651d54[var_78651d54.size] = str_shot;
        }
        if (strstartswith(tolower(str_shot), "idle")) {
            if (!isdefined(var_fc395698)) {
                var_fc395698 = [];
            } else if (!isarray(var_fc395698)) {
                var_fc395698 = array(var_fc395698);
            }
            var_fc395698[var_fc395698.size] = str_shot;
        }
    }
    if (var_bf321a0c) {
        var_f647c5b2 = array::random(var_78651d54);
        var_559c5c3e = strreplace(var_f647c5b2, "intro", "idle");
        assert(isinarray(var_fc395698, var_559c5c3e), "<dev string:x4c6>" + var_559c5c3e + "<dev string:x4ee>" + function_9e72a96(str_scene) + "<dev string:x4f6>" + var_f647c5b2);
        if (!isinarray(var_fc395698, var_559c5c3e)) {
            var_559c5c3e = array::random(var_fc395698);
        }
    } else {
        var_559c5c3e = array::random(var_fc395698);
    }
    if (!var_bf321a0c && level scene::is_playing(str_scene, var_559c5c3e)) {
        var_b8f75d74 = [[ character ]]->function_98d70bef();
    }
    if (var_302876c9 == 0) {
        weapon = function_8567daf2(localclientnum);
        var_5b38793b = function_1fa47915(localclientnum);
    }
    params = {#var_c76f3e47:1, #var_401d9a1:1, #scene:str_scene, #var_74741b75:var_f647c5b2, #var_a68ab9c2:var_559c5c3e, #var_a34c858c:1, #var_f5332569:var_b8f75d74, #activeweapon:weapon, #var_b8f20727:var_5b38793b};
    [[ character ]]->update(params);
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x5f13dc41, Offset: 0x99c8
// Size: 0x1be
function function_cfb00e7d(n_index, localclientnum, *character) {
    assert(isdefined(localclientnum), "<dev string:x50b>");
    var_3d095a85 = function_7104551f(character);
    switch (localclientnum) {
    case 0:
        if (var_3d095a85 == 1) {
            str_scene = #"scene_frontend_t9_lobby_player1_initial";
        } else {
            str_scene = #"scene_frontend_t9_lobby_player1";
        }
        break;
    case 1:
        str_scene = #"scene_frontend_t9_lobby_player2";
        break;
    case 2:
        str_scene = #"scene_frontend_t9_lobby_player3";
        break;
    case 3:
        str_scene = #"scene_frontend_t9_lobby_player4";
        break;
    case 4:
        str_scene = #"scene_frontend_t9_lobby_player5";
        break;
    case 5:
        str_scene = #"scene_frontend_t9_lobby_player6";
        break;
    default:
        assertmsg("<dev string:x529>" + localclientnum);
        break;
    }
    return str_scene;
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x4229a116, Offset: 0x9b90
// Size: 0x114
function function_db9d479f(*localclientnum, play) {
    var_bfe5e572 = struct::get(#"arena_align_tag");
    if (isdefined(var_bfe5e572)) {
        if (play) {
            var_bfe5e572.var_e8b5aff5 = 1;
            function_b0442428(level.var_6f1da91a, 1);
            var_bfe5e572 thread scene::play("scene_frontend_arena_team");
            return;
        }
        if (!play && is_true(var_bfe5e572.var_e8b5aff5)) {
            var_bfe5e572.var_e8b5aff5 = 0;
            function_f5eca51d(level.var_6f1da91a, 1);
            var_bfe5e572 thread scene::stop("scene_frontend_arena_team", 1);
        }
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x18af2728, Offset: 0x9cb0
// Size: 0xc4
function toggle_postfx(localclientnum, on_off, postfx) {
    player = function_5c10bd79(localclientnum);
    if (on_off && !player postfx::function_556665f2(postfx)) {
        player codeplaypostfxbundle(postfx);
        return;
    }
    if (!on_off && player postfx::function_556665f2(postfx)) {
        player codestoppostfxbundle(postfx);
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xc0b63719, Offset: 0x9d80
// Size: 0x444
function lobby_main(localclientnum, menu_name, state) {
    level endon(menu_name + "_closed");
    level childthread function_c5aa56cd(localclientnum);
    level thread function_49efdec6(localclientnum, menu_name, state);
    if (state == #"room1" || state == #"room2") {
        level function_4431001a(localclientnum, "start", menu_name);
    } else if (state == #"mode_select" || state == #"directorselect") {
        level function_4431001a(localclientnum, "main", menu_name);
    } else {
        level function_4431001a(localclientnum);
    }
    level thread function_63a85bfb();
    if (state == #"matchmaking" && level.lastlobbystate !== #"matchmaking") {
        level notify(#"lobby_change", {#var_a3325423:1});
    } else if (state == #"lobby_pose" || state == #"private_lobby_pose" || state == #"arena_pose") {
        level notify(#"lobby_change", {#var_a3325423:1});
        function_b1b8f767(localclientnum, 1);
    } else if (state == #"character_room") {
        function_90cad834(localclientnum, 0);
    } else if (state == #"inspect_specialist" && level.lastlobbystate !== #"inspect_specialist") {
        waitframe(1);
        var_aa16ae79 = getuimodel(function_1df4c3b0(localclientnum, #"hash_3e045efc97005502"), "ChosenSpecialistID");
        for (character_index = getuimodelvalue(var_aa16ae79); !isdefined(character_index) || character_index == 0; character_index = getuimodelvalue(var_aa16ae79)) {
            wait 0.1;
        }
        level notify("menu_change" + localclientnum, {#menu:"directorTraining", #status:"opened", #state:character_index, #mode:1});
    }
    if (!isdefined(state) || state != #"room1") {
        setallcontrollerslightbarcolor();
        level notify(#"end_controller_pulse");
    }
    level.lastlobbystate = state;
    level thread function_97b4eb2c(localclientnum, menu_name, state);
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x289ec7a3, Offset: 0xa1d0
// Size: 0x430
function function_63a85bfb() {
    if (sessionmodeiszombiesgame()) {
        foreach (var_201e3ba3 in level.var_d508403d) {
            unhidevolumedecal(var_201e3ba3);
        }
        foreach (var_e9a37674 in level.var_8a620c67) {
            unhidestaticmodel(var_e9a37674);
        }
        foreach (var_5661a499 in level.var_1a55d2dd) {
            hidevolumedecal(var_5661a499);
        }
        foreach (var_c00eda0d in level.var_fec4a8fd) {
            hidestaticmodel(var_c00eda0d);
        }
        return;
    }
    foreach (var_201e3ba3 in level.var_d508403d) {
        hidevolumedecal(var_201e3ba3);
    }
    foreach (var_e9a37674 in level.var_8a620c67) {
        hidestaticmodel(var_e9a37674);
    }
    foreach (var_5661a499 in level.var_1a55d2dd) {
        unhidevolumedecal(var_5661a499);
    }
    foreach (var_c00eda0d in level.var_fec4a8fd) {
        unhidestaticmodel(var_c00eda0d);
    }
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x98882e95, Offset: 0xa608
// Size: 0x70
function function_f701ad2a() {
    if (sessionmodeiswarzonegame()) {
        return 3;
    }
    if (sessionmodeiszombiesgame()) {
        return 2;
    }
    if (function_34fbc01b()) {
        return 0;
    } else if (function_4fd0d58e()) {
        return 1;
    }
    return -1;
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x3a3f2f5b, Offset: 0xa680
// Size: 0x21a
function function_79ac87ac(clientnum) {
    var_f33f3800 = self function_a5248552();
    if (isarray(level.var_6f1da91a) && var_f33f3800.size > 0) {
        var_91389554 = function_f701ad2a();
        if (!isdefined(var_91389554) || var_91389554 < 0) {
            var_91389554 = 0;
        }
        var_b2694f96 = level.var_6f1da91a[var_91389554];
        if (isdefined(self._s.var_1b22ecf4)) {
            var_302876c9 = int(self._s.var_1b22ecf4);
            var_bf735535 = var_b2694f96[var_302876c9];
            if (isdefined(var_bf735535)) {
                self._e_array[clientnum] = [[ var_bf735535.character ]]->function_217b10ed();
            }
            if (var_302876c9 != 0) {
                self.var_8bba7189 = 1;
            }
            return;
        }
        foreach (var_c1468bbf, s_obj in var_f33f3800) {
            var_bf735535 = var_b2694f96[var_c1468bbf];
            if (!isdefined(var_bf735535)) {
                continue;
            }
            if (self == s_obj) {
                self._e_array[clientnum] = [[ var_bf735535.character ]]->function_217b10ed();
                if (var_c1468bbf != 0) {
                    self.var_8bba7189 = 1;
                }
                break;
            }
        }
    }
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x2dd27392, Offset: 0xa8a8
// Size: 0xfa
function function_a5248552() {
    var_f33f3800 = [];
    foreach (s_obj in self._o_scene._a_objects) {
        if (s_obj._s.type === #"player") {
            if (!isdefined(var_f33f3800)) {
                var_f33f3800 = [];
            } else if (!isarray(var_f33f3800)) {
                var_f33f3800 = array(var_f33f3800);
            }
            var_f33f3800[var_f33f3800.size] = s_obj;
        }
    }
    return var_f33f3800;
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x2e7f6e8b, Offset: 0xa9b0
// Size: 0x330
function function_97b4eb2c(localclientnum, *var_2a4208a4, str_state = #"lobby_pose") {
    self notify("11a81e6061eca17");
    self endon("11a81e6061eca17");
    level endon(#"disconnect");
    switch (str_state) {
    case #"mode_select":
    case #"directorselect":
        return;
    case #"private_lobby_pose":
    case #"arena_pose":
    case #"lobby_pose":
    default:
        str_rumble = #"hash_795b2f3495784147";
        var_58b22097 = 2;
        var_685248c4 = 7;
        n_delay_min = 45;
        n_delay_max = 60;
        str_fxanim = #"p9_fxanim_mp_frontend_plane_station_lobby_bundle";
        var_df4e70cd = #"hash_4acc84527a510fcb";
        break;
    case #"loadout_room":
        str_rumble = #"hash_4830baac0547b450";
        var_58b22097 = 15;
        var_685248c4 = 20;
        n_delay_min = 120;
        n_delay_max = 180;
        str_fxanim = #"p9_fxanim_mp_frontend_plane_station_guns_bundle";
        var_df4e70cd = #"hash_20e4410e7a619aab";
        break;
    case #"character_room":
        str_rumble = #"hash_4a7c098220c7b9be";
        var_58b22097 = 10;
        var_685248c4 = 15;
        n_delay_min = 60;
        n_delay_max = 75;
        str_fxanim = #"p9_fxanim_mp_frontend_plane_station_character_bundle";
        var_df4e70cd = #"hash_4332c2e140d253";
        break;
    }
    v_source = struct::get(str_fxanim, "scriptbundlename").origin;
    b_first_time = 1;
    while (true) {
        if (b_first_time) {
            n_timeout = randomfloatrange(var_58b22097, var_685248c4);
            level scene::stop(str_fxanim);
        } else {
            n_timeout = randomfloatrange(n_delay_min, n_delay_max);
        }
        wait n_timeout;
        b_first_time = 0;
        playsound(var_2a4208a4, var_df4e70cd, (0, 0, 0));
        playrumbleonposition(var_2a4208a4, str_rumble, v_source);
        level thread scene::play(str_fxanim);
    }
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0xbaec2e54, Offset: 0xace8
// Size: 0xf4
function function_24ae4ffb() {
    function_5ea2c6e3("amb_frontend_volume_zero", 1, 1);
    function_5ea2c6e3("amb_frontend_volume_full", 1, 0);
    function_5ea2c6e3("amb_frontend_volume_mid", 1, 0);
    function_5ea2c6e3("amb_frontend_volume_low", 1, 0);
    function_5ea2c6e3("ui_frontend_mute_movies");
    audio::playloopat("amb_frontend_plane_drone", (0, 0, 0));
    audio::playloopat("amb_frontend_plane_rattle", (0, 0, 0));
    level thread function_4ff471c2();
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0xd329195e, Offset: 0xade8
// Size: 0x120
function function_4ff471c2() {
    level endon(#"disconnect");
    while (true) {
        wait randomintrange(7, 20);
        if (math::cointoss()) {
            n_amount = randomfloatrange(0, 1);
            var_fd343efd = randomintrange(4, 11);
            function_5ea2c6e3("amb_frontend_planerattle_flux", var_fd343efd, n_amount);
        }
        if (math::cointoss()) {
            n_amount = randomfloatrange(0, 1);
            var_fd343efd = randomintrange(4, 11);
            function_5ea2c6e3("amb_frontend_planedrone_flux", var_fd343efd, n_amount);
        }
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x1b2df3c1, Offset: 0xaf10
// Size: 0x372
function function_49efdec6(*localclientnum, *menu_name, str_state) {
    self notify("568883f0e1ce2e3c");
    self endon("568883f0e1ce2e3c");
    level endon(#"disconnect");
    switch (str_state) {
    case #"cp_story":
    case #"cp_evidence":
    case #"mode_select":
    case #"directorselect":
    default:
        function_672403ca("amb_frontend_volume_full", 0.5, 0);
        function_672403ca("amb_frontend_volume_mid", 0.5, 0);
        function_672403ca("amb_frontend_volume_low", 0.5, 0);
        function_672403ca("amb_frontend_volume_zero", 0.5, 1);
        break;
    case #"scorestreaks":
        function_672403ca("amb_frontend_volume_full", 0.5, 0);
        function_672403ca("amb_frontend_volume_zero", 0.5, 0);
        function_672403ca("amb_frontend_volume_low", 0.5, 0);
        function_672403ca("amb_frontend_volume_low", 0.5, 1);
        break;
    case #"armory":
    case #"medium_vol":
    case #"loadout_room":
        function_672403ca("amb_frontend_volume_full", 0.5, 0);
        function_672403ca("amb_frontend_volume_zero", 0.5, 0);
        function_672403ca("amb_frontend_volume_low", 0.5, 0);
        function_672403ca("amb_frontend_volume_mid", 0.5, 1);
        break;
    case #"private_lobby_pose":
    case #"arena_pose":
    case #"character_room":
    case #"lobby_pose":
        function_672403ca("amb_frontend_volume_zero", 0.5, 0);
        function_672403ca("amb_frontend_volume_mid", 0.5, 0);
        function_672403ca("amb_frontend_volume_low", 0.5, 0);
        function_672403ca("amb_frontend_volume_full", 0.5, 1);
        break;
    }
}

/#

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0x89113f5b, Offset: 0xb290
    // Size: 0x2c
    function update_room2_devgui(localclientnum) {
        level thread mp_devgui::remove_mp_contracts_devgui(localclientnum);
    }

    // Namespace frontend/frontend
    // Params 2, eflags: 0x0
    // Checksum 0x334c96b6, Offset: 0xb2c8
    // Size: 0x74
    function update_mp_lobby_room_devgui(localclientnum, state) {
        if (state == "<dev string:x554>" || state == "<dev string:x561>") {
            level thread mp_devgui::create_mp_contracts_devgui(localclientnum);
            return;
        }
        level mp_devgui::remove_mp_contracts_devgui(localclientnum);
    }

#/

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0xc7b7671a, Offset: 0xb348
// Size: 0xc6
function pulse_controller_color() {
    level endon(#"end_controller_pulse");
    delta_t = -0.01;
    t = 1;
    while (true) {
        setallcontrollerslightbarcolor((1 * t, 0.2 * t, 0));
        t += delta_t;
        if (t < 0.2 || t > 0.99) {
            delta_t *= -1;
        }
        waitframe(1);
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x754d9cbc, Offset: 0xb418
// Size: 0x7a
function function_74e1ca20(str_notify) {
    if (level.lastlobbystate === #"character_room" && str_notify === #"hash_248ca22abc6b78ed" && isdefined(level.var_debe8147)) {
        [[ level.var_1c43dd3e ]]->function_15a8906a(level.var_debe8147);
        level.var_debe8147 = undefined;
    }
}

// Namespace frontend/frontend
// Params 4, eflags: 0x0
// Checksum 0x77d57c9, Offset: 0xb4a0
// Size: 0x4a4
function function_90cad834(localclientnum, var_3449052c = 0, var_7f395102, var_e6db60fc = 0) {
    level notify(#"hash_53d7a69385304e8");
    level notify(#"end_character_rotating" + localclientnum);
    level endoncallback(&function_74e1ca20, #"hash_53d7a69385304e8", #"hash_248ca22abc6b78ed", #"disconnect");
    weapon = function_8567daf2(localclientnum);
    var_5b38793b = function_1fa47915(localclientnum);
    var_b1e821c5 = spawnstruct();
    var_16be1107 = function_2ca65924(level.var_1c43dd3e);
    if (var_3449052c) {
        if (isdefined(level.var_debe8147)) {
            var_b8f75d74 = [[ level.var_1c43dd3e ]]->function_98d70bef();
        }
        level.var_debe8147 = var_7f395102;
        params = {#var_a34c858c:1, #scene:var_16be1107, #var_74741b75:"select_outro", #var_99a89f83:1, #var_f5332569:var_b8f75d74, #activeweapon:weapon, #var_b8f20727:var_5b38793b};
        [[ level.var_1c43dd3e ]]->update(params);
        var_c74251a4 = scene::function_8582657c(var_16be1107, "select_outro");
        if (isdefined(var_b8f75d74)) {
            n_wait_time = var_c74251a4 - var_b8f75d74 * var_c74251a4;
            wait n_wait_time;
        } else {
            wait var_c74251a4;
        }
        if (isdefined(var_7f395102)) {
            [[ level.var_1c43dd3e ]]->function_15a8906a(var_7f395102);
        }
    } else if (isdefined(var_7f395102)) {
        [[ level.var_1c43dd3e ]]->function_15a8906a(var_7f395102);
    }
    level.var_debe8147 = undefined;
    if (var_e6db60fc && getdvarint(#"hash_4ae5fc5108968bfe", 0)) {
        var_f647c5b2 = "select_intro";
        if (!level flag::get("waiting_for_character_change") && [[ level.var_1c43dd3e ]]->is_streamed() && [[ level.var_1c43dd3e ]]->function_ea4ac9f8() && [[ level.var_1c43dd3e ]]->is_visible()) {
            var_b1e821c5.blend = 0.5;
        } else {
            var_b1e821c5.blend = 0;
            var_b1e821c5.var_9e6d8a3d = 0.5;
        }
    } else {
        var_b8f75d74 = [[ level.var_1c43dd3e ]]->function_98d70bef();
    }
    params = {#var_a34c858c:1, #var_c76f3e47:1, #var_401d9a1:1, #var_f5332569:var_b8f75d74, #var_b1e821c5:var_b1e821c5, #scene:var_16be1107, #var_74741b75:var_f647c5b2, #var_a68ab9c2:"select_idle", #var_99a89f83:1, #activeweapon:weapon, #var_b8f20727:var_5b38793b};
    [[ level.var_1c43dd3e ]]->update(params);
    level flag::clear("waiting_for_character_change");
}

// Namespace frontend/frontend
// Params 7, eflags: 0x0
// Checksum 0x684a126, Offset: 0xb950
// Size: 0x22c
function function_67dbdad(localclientnum, menu_name, str_scene, var_f647c5b2, var_559c5c3e, var_77e970fa = 1, var_dd5c339d = 1) {
    level notify(#"hash_779b1d50d2895b97");
    level endon(#"hash_779b1d50d2895b97", #"disconnect");
    if (isdefined(menu_name)) {
        level endon(menu_name + "_closed");
    }
    var_1dfa126c = 1;
    while (true) {
        player_data = function_25f808c9(localclientnum, 1);
        if (!isdefined(player_data)) {
            player_data = character_customization::function_3f5625f1(1, 2);
        }
        var_c0a8925e = player_data.charactertype;
        if (isdefined(var_c0a8925e) && (var_c0a8925e !== level.var_f7aea3ff || var_1dfa126c)) {
            var_1dfa126c = 0;
            localxuid = function_9bed6a71(localclientnum, 1);
            [[ level.var_1c43dd3e ]]->function_15a8906a(player_data);
            params = {#var_401d9a1:var_77e970fa, #var_c76f3e47:var_dd5c339d, #scene:str_scene, #var_74741b75:var_f647c5b2, #var_a68ab9c2:var_559c5c3e};
            [[ level.var_1c43dd3e ]]->update(params);
            level.var_f7aea3ff = var_c0a8925e;
        }
        wait 0.1;
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x6e2dc4bd, Offset: 0xbb88
// Size: 0xac
function function_aba0885b(localclientnum) {
    player_data = function_25f808c9(localclientnum, 1);
    if (!isdefined(player_data)) {
        player_data = character_customization::function_3f5625f1(1, 2);
    }
    var_c0a8925e = player_data.charactertype;
    if (isdefined(var_c0a8925e) && var_c0a8925e !== level.var_f7aea3ff) {
        [[ level.var_1c43dd3e ]]->function_15a8906a(player_data);
        level.var_f7aea3ff = var_c0a8925e;
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xd0d6d27c, Offset: 0xbc40
// Size: 0x70
function function_4431001a(localclientnum, scene_shot, menu_name) {
    if (isdefined(scene_shot)) {
        level childthread function_67dbdad(localclientnum, menu_name, #"scene_frontend_start", undefined, scene_shot);
        return;
    }
    level notify(#"hash_779b1d50d2895b97");
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x74a0ac65, Offset: 0xbcb8
// Size: 0x136
function function_9602c423(localclientnum, menu_name, state) {
    var_d0b01271 = lui_camera::function_daadc836(menu_name, localclientnum);
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get(#"cac_specialist_angle");
    playmaincamxcam(localclientnum, #"ui_cam_character_gesture", 0, "", "", camera_ent.origin, camera_ent.angles);
    if (isdefined(state)) {
        [[ var_d0b01271 ]]->set_character_index(state);
        level notify("updateSpecialistCustomization" + localclientnum, {#event_name:"changeHero", #character_index:state, #mode:currentsessionmode()});
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xd7b736e1, Offset: 0xbdf8
// Size: 0x126
function function_25b060af(localclientnum, menu_name, state) {
    var_d0b01271 = lui_camera::function_daadc836(menu_name, localclientnum);
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get(#"cac_specialist_angle");
    playmaincamxcam(localclientnum, #"ui_cam_loadout_character", 0, "", "", camera_ent.origin, camera_ent.angles);
    if (isdefined(state)) {
        [[ var_d0b01271 ]]->set_character_index(state);
        level notify("updateSpecialistCustomization" + localclientnum, {#event_name:"changeHero", #character_index:state, #mode:1});
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xf9826ed0, Offset: 0xbf28
// Size: 0x1c6
function function_f8cec907(localclientnum, menu_name, state) {
    var_d0b01271 = lui_camera::function_daadc836(menu_name, localclientnum);
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get(#"hash_dd8a67627ed7326");
    playmaincamxcam(localclientnum, #"ui_scene_cam_wz_unlock", 0, "", "", camera_ent.origin, camera_ent.angles);
    if (isdefined(state)) {
        args = strtok(state, ";");
        char_index = int(isdefined(args[0]) ? args[0] : 0);
        outfit_index = int(isdefined(args[1]) ? args[1] : 0);
        [[ var_d0b01271 ]]->set_character_mode(3);
        [[ var_d0b01271 ]]->set_character_index(char_index);
        level notify("updateSpecialistCustomization" + localclientnum, {#event_name:"changeOutfit", #outfit_index:outfit_index});
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xd842a0b5, Offset: 0xc0f8
// Size: 0xb4
function function_a8095769(localclientnum, menu_name) {
    var_d0b01271 = lui_camera::function_daadc836(menu_name, localclientnum);
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get(#"tag_align_quartermaster");
    playmaincamxcam(localclientnum, #"ui_cam_store_camera", 0, "", "", camera_ent.origin, camera_ent.angles);
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x391824b4, Offset: 0xc1b8
// Size: 0xdc
function function_7142469f(localclientnum, *menu_data) {
    level notify(#"blackmarket_closed");
    level thread scene::stop(level.var_d29ac799, 1);
    level.var_d29ac799 = undefined;
    if (isdefined(level.var_c7cd91f5)) {
        stopradiantexploder(menu_data, level.var_c7cd91f5);
        level.var_c7cd91f5 = undefined;
    }
    season = getdvarstring(#"mtx_seasonal_exploder");
    stopradiantexploder(menu_data, "fxexp_mtx_ambient" + season);
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xfd072109, Offset: 0xc2a0
// Size: 0x29a
function function_1f5168a3(localclientnum, weapon_model, waitresult) {
    self notify("5d987b1946cbf8bd");
    self endon("5d987b1946cbf8bd");
    level endon(#"qmweaponupdate");
    var_9d7ee952 = getdvarint(#"hash_41ef264ae8370dc7", 5);
    activecamoinfo = activecamo::function_13e12ab1(waitresult.activecamoindex);
    if (isdefined(activecamoinfo) && activecamoinfo.stages.size > 1) {
        for (stage = 0; true; stage = (stage + 1) % activecamoinfo.stages.size) {
            if (isdefined(level.var_324c3190[localclientnum])) {
                weapon_model stoprenderoverridebundle(level.var_324c3190[localclientnum]);
                level.var_324c3190[localclientnum] = undefined;
            }
            var_3594168e = activecamoinfo.stages[stage];
            if (!isdefined(var_3594168e.disabled) || var_3594168e.disabled == 0) {
                var_d6e83d42 = function_8b51d9d1(var_3594168e.camooption);
                render_options = function_6eff28b5(var_d6e83d42, 0, 0);
                blueprint = 0;
                if (isdefined(waitresult.blueprint)) {
                    blueprint = waitresult.blueprint;
                }
                weapon = getweapon(waitresult.weapon_ref);
                var_2d45743e = customclass::function_5f70d1c8(weapon);
                weapon_model useweaponmodel(weapon, undefined, render_options, blueprint);
                weapon_model setscale(var_2d45743e.scale);
                activecamo::function_6c9e0e1a(localclientnum, weapon_model, var_3594168e, level.var_324c3190);
                wait var_9d7ee952;
            }
        }
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x2f26c59e, Offset: 0xc548
// Size: 0x2a8
function function_98088878(localclientnum, menu_data) {
    level endon(menu_data.menu_name + "_closed");
    season = getdvarstring(#"mtx_seasonal_exploder");
    playradiantexploder(localclientnum, "fxexp_mtx_ambient" + season);
    weapon_model = getent(localclientnum, "quartermaster_weapon", "targetname");
    var_7ef44086 = struct::get("tag_align_quartermaster_weapon");
    while (true) {
        waitresult = level waittill(#"qmweaponupdate");
        if (isdefined(level.var_324c3190[localclientnum])) {
            weapon_model stoprenderoverridebundle(level.var_324c3190[localclientnum]);
            level.var_324c3190[localclientnum] = undefined;
        }
        camoindex = 0;
        if (isdefined(waitresult.camoindex)) {
            camoindex = waitresult.camoindex;
        }
        render_options = function_6eff28b5(camoindex, 0, 0);
        blueprint = 0;
        if (isdefined(waitresult.blueprint)) {
            blueprint = waitresult.blueprint;
        }
        weapon = getweapon(waitresult.weapon_ref);
        var_2d45743e = customclass::function_5f70d1c8(weapon);
        weapon_model useweaponmodel(weapon, undefined, render_options, blueprint);
        weapon_model setscale(var_2d45743e.scale);
        weapon_model.origin = var_7ef44086.origin + var_2d45743e.offset;
        weapon_model.angles = var_7ef44086.angles;
        if (isdefined(waitresult.activecamoindex)) {
            childthread function_1f5168a3(localclientnum, weapon_model, waitresult);
        }
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x51571b1f, Offset: 0xc7f8
// Size: 0x4b4
function function_837446a8(localclientnum, menu_name, state) {
    var_d0b01271 = lui_camera::function_daadc836(menu_name, localclientnum);
    weapon_model = getent(localclientnum, "quartermaster_weapon", "targetname");
    level notify("end_character_rotating" + localclientnum);
    switch (state) {
    case #"character":
    case #"gesture":
        [[ var_d0b01271 ]]->function_4240a39a(1, (0, 90, 0));
        level thread character_customization::rotation_thread_spawner(localclientnum, var_d0b01271, "end_character_rotating" + localclientnum);
        [[ var_d0b01271 ]]->function_4240a39a(0);
        [[ var_d0b01271 ]]->show_model();
        weapon_model hide();
        scene = #"scene_frontend_quartermaster_character";
        break;
    case #"character_full":
        [[ var_d0b01271 ]]->function_4240a39a(1, (0, 90, 0));
        level thread character_customization::rotation_thread_spawner(localclientnum, var_d0b01271, "end_character_rotating" + localclientnum);
        [[ var_d0b01271 ]]->function_4240a39a(0);
        [[ var_d0b01271 ]]->show_model();
        weapon_model hide();
        scene = #"scene_frontend_quartermaster_character_full";
        break;
    case #"character_face":
        [[ var_d0b01271 ]]->function_4240a39a(1, (0, 90, 0));
        level thread character_customization::rotation_thread_spawner(localclientnum, var_d0b01271, "end_character_rotating" + localclientnum);
        [[ var_d0b01271 ]]->function_4240a39a(0);
        [[ var_d0b01271 ]]->show_model();
        weapon_model hide();
        scene = #"scene_frontend_quartermaster_character_face";
        break;
    case #"weapon":
        [[ var_d0b01271 ]]->hide_model();
        weapon_model show();
        scene = #"scene_frontend_quartermaster_weapon";
        break;
    case #"crate":
        [[ var_d0b01271 ]]->hide_model();
        weapon_model hide();
        season = getdvarstring(#"mtx_seasonal_exploder");
        scene = #"scene_frontend_quartermaster_crate" + season;
        exploder = "fxexp_mtx_crate" + season;
        break;
    default:
        [[ var_d0b01271 ]]->hide_model();
        weapon_model hide();
        scene = #"scene_frontend_quartermaster";
        break;
    }
    if (level.var_c7cd91f5 !== exploder) {
        if (isdefined(level.var_c7cd91f5)) {
            stopradiantexploder(localclientnum, level.var_c7cd91f5);
        }
        if (isdefined(exploder)) {
            playradiantexploder(localclientnum, exploder);
        }
        level.var_c7cd91f5 = exploder;
    }
    if (level.var_d29ac799 !== scene) {
        if (isdefined(level.var_d29ac799)) {
            level scene::stop(level.var_d29ac799, 1);
        }
        level.var_d29ac799 = scene;
        level thread scene::play(level.var_d29ac799);
    }
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x8d3f8cfc, Offset: 0xccb8
// Size: 0xdc
function function_36962bc4(localclientnum, menu_name, *state) {
    self notify("471bdc9c0712a491");
    self endon("471bdc9c0712a491");
    var_d0b01271 = lui_camera::function_daadc836(state, menu_name);
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get(#"cac_specialist_angle");
    playmaincamxcam(menu_name, #"ui_cam_character_customization_3d", 0, "", "", camera_ent.origin, camera_ent.angles);
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x41cb07c2, Offset: 0xcda0
// Size: 0x144
function function_8ad37038(localclientnum, menu_name, state) {
    self notify("261acd86b3999d16");
    self endon("261acd86b3999d16");
    var_d0b01271 = lui_camera::function_daadc836(menu_name, localclientnum);
    if (isdefined(state)) {
        [[ var_d0b01271 ]]->set_character_index(state);
        level notify("updateSpecialistCustomization" + localclientnum, {#event_name:"changeHero", #character_index:state, #mode:3});
    }
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get(#"cac_specialist_angle");
    playmaincamxcam(localclientnum, #"ui_cam_loadout_character", 0, "", "", camera_ent.origin, camera_ent.angles);
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0x6622c453, Offset: 0xcef0
// Size: 0x8c
function function_bc98f036(localclientnum, *menu_name, *state) {
    camera_ent = struct::get(#"cac_specialist_angle");
    playmaincamxcam(state, #"ui_cam_character_customization_3d", 0, "", "", camera_ent.origin, camera_ent.angles);
}

// Namespace frontend/frontend
// Params 3, eflags: 0x0
// Checksum 0xb63457c0, Offset: 0xcf88
// Size: 0x234
function function_73b8462a(localclientnum, menu_name, state) {
    var_d0b01271 = lui_camera::function_daadc836(menu_name, localclientnum);
    if (state === "character") {
        [[ var_d0b01271 ]]->show_model();
    } else {
        [[ var_d0b01271 ]]->hide_model();
    }
    session_mode = currentsessionmode();
    if (session_mode == 4) {
        return;
    }
    character_index = getequippedheroindex(localclientnum, session_mode);
    if (isdefined(character_index)) {
        fields = getcharacterfields(character_index, session_mode);
    }
    if (isdefined(fields) && isdefined(fields.var_47c73c9d)) {
        level.var_c8fac6ea = fields.var_47c73c9d;
    } else if (currentsessionmode() == 0) {
        level.var_c8fac6ea = "scene_frontend_aar";
    } else if (currentsessionmode() == 3) {
        level.var_c8fac6ea = "scene_frontend_aar";
    } else if (util::is_arena_lobby()) {
        level.var_c8fac6ea = "scene_frontend_aar";
    } else {
        level.var_c8fac6ea = "scene_frontend_aar";
    }
    if (!level scene::is_playing(level.var_c8fac6ea)) {
        [[ var_d0b01271 ]]->set_character_mode(session_mode);
        [[ var_d0b01271 ]]->set_character_index(character_index);
        [[ var_d0b01271 ]]->function_77e3be08();
        [[ var_d0b01271 ]]->update(undefined);
        level thread scene::play(level.var_c8fac6ea);
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x88e9f46d, Offset: 0xd1c8
// Size: 0x4e
function function_48fb04a7(*localclientnum, *menu_name) {
    if (isdefined(level.var_c8fac6ea)) {
        level thread scene::stop(level.var_c8fac6ea);
        level.var_c8fac6ea = undefined;
    }
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0xbb34d4c6, Offset: 0xd220
// Size: 0x36
function function_3dde055b(localclientnum, *new_menu) {
    var_d0b01271 = lui_camera::function_daadc836("MPSpecialistHUBPreviewMoment", new_menu);
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x2697a51, Offset: 0xd260
// Size: 0x14
function function_c4db2740(*localclientnum, *prev_menu) {
    
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x79fb9aa9, Offset: 0xd280
// Size: 0x14
function function_fad4ce33(*localclientnum, *entities) {
    
}

// Namespace frontend/frontend
// Params 2, eflags: 0x0
// Checksum 0x1737ec3, Offset: 0xd2a0
// Size: 0x14
function function_c5cbf7d6(*localclientnum, *entities) {
    
}

