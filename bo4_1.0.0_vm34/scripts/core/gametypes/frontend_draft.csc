#using scripts\core_common\array_shared;
#using scripts\core_common\character_customization;
#using scripts\core_common\dialog_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace draft;

// Namespace draft/frontend_draft
// Params 0, eflags: 0x0
// Checksum 0xebedfa8f, Offset: 0x210
// Size: 0xf6
function init() {
    level.var_e5f8a54 = [];
    level.var_e5f8a54[#"allies"] = "mp_draft_lights_allies";
    level.var_e5f8a54[#"axis"] = "mp_draft_lights_axis";
    level.var_90991f70 = undefined;
    level thread function_c277b2a1();
    level thread function_a305a32b();
    level.var_8962241 = "";
    level.draftxcam = #"ui_cam_draft_common";
    level.var_a49d0b27 = #"hash_12263e5d70551bf9";
    level.var_24f5a391 = undefined;
    level.draftcharacters = [];
}

// Namespace draft/frontend_draft
// Params 0, eflags: 0x0
// Checksum 0xa3d7ce6d, Offset: 0x310
// Size: 0x3c
function function_e082872d() {
    if (currentsessionmode() == 0) {
        return #"zm_lobby_struct";
    }
    return #"draft_team_struct_allies";
}

// Namespace draft/frontend_draft
// Params 1, eflags: 0x0
// Checksum 0x8d81563a, Offset: 0x358
// Size: 0x13e
function function_835971c7(index) {
    var_86428271 = [];
    if (currentsessionmode() == 0) {
        var_86428271[0] = #"zm_lobby_player_2";
        var_86428271[1] = #"zm_lobby_player_1";
        var_86428271[2] = #"zm_lobby_player_0";
        var_86428271[3] = #"zm_lobby_player_3";
    } else {
        var_86428271[0] = #"draft_player_struct_2_allies";
        var_86428271[1] = #"draft_player_struct_1_allies";
        var_86428271[2] = #"draft_player_struct_0_allies";
        var_86428271[3] = #"draft_player_struct_3_allies";
        var_86428271[4] = #"draft_player_struct_4_allies";
    }
    if (index < var_86428271.size) {
        return struct::get(var_86428271[index]);
    }
    return undefined;
}

// Namespace draft/frontend_draft
// Params 1, eflags: 0x0
// Checksum 0x33f7297d, Offset: 0x4a0
// Size: 0x60
function getpositionforlocalclient(localclientnum) {
    localclientmapping = [];
    localclientmapping[0] = 2;
    localclientmapping[1] = 1;
    localclientmapping[2] = 3;
    localclientmapping[3] = 0;
    return localclientmapping[localclientnum];
}

// Namespace draft/frontend_draft
// Params 0, eflags: 0x0
// Checksum 0x939810af, Offset: 0x508
// Size: 0x82
function function_52bf47d3() {
    if (sessionmodeiswarzonegame()) {
        return 3;
    }
    if (sessionmodeiszombiesgame()) {
        return 2;
    }
    if (level.lastlobbystate === #"lobby_pose") {
        return 0;
    } else if (level.lastlobbystate === #"arena_pose") {
        return 1;
    }
    return -1;
}

// Namespace draft/frontend_draft
// Params 2, eflags: 0x0
// Checksum 0x673d4e79, Offset: 0x598
// Size: 0xa4
function function_cbd3597c(localclientnum, character) {
    var_cec5d4a0 = [[ character ]]->function_e5bdd4ae();
    if (!(isdefined(var_cec5d4a0) && isdefined(var_cec5d4a0.entnummodel))) {
        return;
    }
    var_73cb444e = function_52bf47d3();
    if (var_cec5d4a0.var_93860d34 === var_73cb444e) {
        setuimodelvalue(var_cec5d4a0.entnummodel, [[ character ]]->function_295fce60());
    }
}

// Namespace draft/frontend_draft
// Params 3, eflags: 0x0
// Checksum 0xad094688, Offset: 0x648
// Size: 0x154
function function_e19ab3c8(ccobject, index, var_93860d34) {
    var_a43b6239 = getuimodel(getglobaluimodel(), "LobbyClients");
    var_1a81530f = getuimodel(var_a43b6239, index + 1);
    if (!isdefined(var_1a81530f)) {
        return;
    }
    [[ ccobject ]]->function_e5bdd4ae().entnummodel = createuimodel(var_1a81530f, "entNum");
    [[ ccobject ]]->function_e5bdd4ae().var_93860d34 = var_93860d34;
    [[ ccobject ]]->function_91db38af(&function_cbd3597c);
    entnum = getuimodelvalue([[ ccobject ]]->function_e5bdd4ae().entnummodel);
    if (!isdefined(entnum)) {
        setuimodelvalue([[ ccobject ]]->function_e5bdd4ae().entnummodel, [[ ccobject ]]->function_295fce60());
    }
}

// Namespace draft/frontend_draft
// Params 5, eflags: 0x0
// Checksum 0x18942e5b, Offset: 0x7a8
// Size: 0x162
function show_cam(localclientnum, xcam, animname, lerpduration, force) {
    if (isdefined(level.var_6fba5d94) && level.var_6fba5d94) {
        return;
    }
    if (!isdefined(xcam) || !isdefined(animname)) {
        return;
    }
    if (!(isdefined(force) && force) && isdefined(level.var_8962241) && level.var_8962241 == animname && isdefined(level.var_24f5a391) && level.var_24f5a391 == xcam) {
        return;
    }
    draftstruct = struct::get(function_e082872d(), "targetname");
    if (isdefined(draftstruct)) {
        playmaincamxcam(localclientnum, xcam, lerpduration, animname, "", draftstruct.origin, draftstruct.angles);
        level.var_8962241 = animname;
        level.var_24f5a391 = xcam;
    }
}

// Namespace draft/frontend_draft
// Params 1, eflags: 0x0
// Checksum 0x6f306175, Offset: 0x918
// Size: 0x3a
function stop_cameras(localclientnum) {
    stopmaincamxcam(localclientnum);
    level.var_8962241 = undefined;
    level.var_24f5a391 = undefined;
}

// Namespace draft/frontend_draft
// Params 2, eflags: 0x0
// Checksum 0xd05b1c8b, Offset: 0x960
// Size: 0x3c
function function_362ca1c3(localclientnum, lerpduration) {
    show_cam(localclientnum, level.var_a49d0b27, "cam_draft_zoom", lerpduration);
}

// Namespace draft/frontend_draft
// Params 3, eflags: 0x0
// Checksum 0xe72fa63d, Offset: 0x9a8
// Size: 0x44
function function_396382a0(localclientnum, lerpduration, force) {
    show_cam(localclientnum, level.draftxcam, "cam_draft_ingame", lerpduration, force);
}

// Namespace draft/frontend_draft
// Params 4, eflags: 0x0
// Checksum 0xd2dc2c5d, Offset: 0x9f8
// Size: 0xbc
function function_2996cfb6(localclientnum, draftcharacter, oldcharacterindex, var_e506b18e) {
    if (isdefined([[ draftcharacter ]]->function_e5bdd4ae().localclientnum) && [[ draftcharacter ]]->function_e5bdd4ae().localclientnum == localclientnum && player_role::is_valid([[ draftcharacter ]]->function_e5bdd4ae().selectedcharacterindex)) {
        function_f97e7787(localclientnum) dialog_shared::play_dialog("characterSelect", localclientnum);
    }
}

// Namespace draft/frontend_draft
// Params 3, eflags: 0x0
// Checksum 0xc6a69443, Offset: 0xac0
// Size: 0xfe
function function_9f457d30(localclientnum, draftcharacter, masked) {
    if (masked && !(isdefined([[ draftcharacter ]]->function_e5bdd4ae().masked) && [[ draftcharacter ]]->function_e5bdd4ae().masked)) {
        [[ draftcharacter ]]->function_43f376f0(1);
        [[ draftcharacter ]]->function_e5bdd4ae().masked = 1;
        return;
    }
    if (!masked && isdefined([[ draftcharacter ]]->function_e5bdd4ae().masked) && [[ draftcharacter ]]->function_e5bdd4ae().masked) {
        [[ draftcharacter ]]->function_43f376f0(0);
        [[ draftcharacter ]]->function_e5bdd4ae().masked = 0;
    }
}

// Namespace draft/frontend_draft
// Params 2, eflags: 0x0
// Checksum 0x36dd831c, Offset: 0xbc8
// Size: 0x486
function function_bd9af109(localclientnum, draftcharacter) {
    if (player_role::is_valid([[ draftcharacter ]]->function_e5bdd4ae().focusedcharacterindex)) {
        if (isdefined([[ draftcharacter ]]->function_e5bdd4ae().activecharacter) && [[ draftcharacter ]]->function_e5bdd4ae().activecharacter == [[ draftcharacter ]]->function_e5bdd4ae().focusedcharacterindex) {
            return false;
        }
        [[ draftcharacter ]]->function_e5bdd4ae().activecharacter = [[ draftcharacter ]]->function_e5bdd4ae().focusedcharacterindex;
    } else if (!isdefined([[ draftcharacter ]]->function_e5bdd4ae().activecharacter) || [[ draftcharacter ]]->function_e5bdd4ae().activecharacter != [[ draftcharacter ]]->function_e5bdd4ae().selectedcharacterindex) {
        function_2996cfb6(localclientnum, draftcharacter, [[ draftcharacter ]]->function_e5bdd4ae().activecharacter, [[ draftcharacter ]]->function_e5bdd4ae().selectedcharacterindex);
        [[ draftcharacter ]]->function_e5bdd4ae().activecharacter = [[ draftcharacter ]]->function_e5bdd4ae().selectedcharacterindex;
    }
    sessionmode = currentsessionmode();
    var_2d65f5be = "scene_frontend_t8_mp_male_team_0";
    [[ draftcharacter ]]->set_character_mode(sessionmode);
    if (player_role::is_valid([[ draftcharacter ]]->function_e5bdd4ae().activecharacter)) {
        [[ draftcharacter ]]->set_character_index([[ draftcharacter ]]->function_e5bdd4ae().activecharacter);
        function_9f457d30(localclientnum, draftcharacter, 0);
        var_189908ae = [[ draftcharacter ]]->function_e5bdd4ae().var_189908ae;
        characterindex = [[ draftcharacter ]]->function_e5bdd4ae().activecharacter;
        fields = getcharacterfields(characterindex, sessionmode);
        if (sessionmodeiszombiesgame()) {
            if (isdefined(fields) && isdefined(fields.var_2d65f5be)) {
                var_2d65f5be = fields.var_2d65f5be;
                [[ draftcharacter ]]->function_abb62848(0);
            } else {
                [[ draftcharacter ]]->function_abb62848(1);
            }
        } else if (isdefined(fields) && isdefined(fields.lobbyscenes) && fields.lobbyscenes.size > 0) {
            var_2d65f5be = fields.lobbyscenes[var_189908ae % fields.lobbyscenes.size].scene;
            [[ draftcharacter ]]->function_abb62848(0);
        } else {
            [[ draftcharacter ]]->function_abb62848(1);
        }
    } else {
        [[ draftcharacter ]]->function_abb62848(1);
        [[ draftcharacter ]]->set_character_index(0);
        function_9f457d30(localclientnum, draftcharacter, 1);
        if (isdefined([[ draftcharacter ]]->function_e5bdd4ae().visible) && [[ draftcharacter ]]->function_e5bdd4ae().visible) {
            function_9f457d30(localclientnum, draftcharacter, 1);
            [[ draftcharacter ]]->show_model();
        } else {
            [[ draftcharacter ]]->hide_model();
        }
    }
    [[ draftcharacter ]]->function_fd80d28b();
    [[ draftcharacter ]]->function_e5bdd4ae().params.scene = var_2d65f5be;
    return true;
}

// Namespace draft/frontend_draft
// Params 3, eflags: 0x0
// Checksum 0x8f6b2898, Offset: 0x1058
// Size: 0x78
function function_a251e6d6(localclientnum, draftcharacter, isvalidxuid) {
    if (isvalidxuid && function_bd9af109(localclientnum, draftcharacter)) {
        [[ draftcharacter ]]->update([[ draftcharacter ]]->function_e5bdd4ae().params);
        return;
    }
    [[ draftcharacter ]]->hide_model();
}

// Namespace draft/frontend_draft
// Params 1, eflags: 0x0
// Checksum 0xa4fcdbac, Offset: 0x10d8
// Size: 0x2f6
function update_team(localclientnum) {
    if (currentsessionmode() == 4) {
        return;
    }
    var_f5e3e11 = getuimodel(getuimodelforcontroller(localclientnum), "PositionDraftClients");
    for (i = 0; i < 4; i++) {
        if (!isdefined(level.draftcharacters[i])) {
            continue;
        }
        draftcharacter = level.draftcharacters[i];
        [[ draftcharacter ]]->function_e5bdd4ae().selectedcharacterindex = 0;
        if (isdefined(var_f5e3e11)) {
            luaindex = i + 1;
            var_2b2a364a = getuimodel(var_f5e3e11, luaindex);
            xuid = getuimodelvalue(getuimodel(var_2b2a364a, "xuid"));
            characterindex = getuimodelvalue(getuimodel(var_2b2a364a, "characterIndex"));
            [[ draftcharacter ]]->function_e5bdd4ae().xuid = xuid;
            [[ draftcharacter ]]->function_e5bdd4ae().selectedcharacterindex = characterindex;
            [[ draftcharacter ]]->function_e5bdd4ae().visible = getuimodelvalue(getuimodel(var_2b2a364a, "visible"));
            function_e19ab3c8(draftcharacter, i, function_52bf47d3());
            focusedcharacterindex = undefined;
            isvalidxuid = xuid != 0;
            if (isvalidxuid) {
                var_d264410c = getuimodel(getuimodelforcontroller(localclientnum), "PositionDraft.focusedCharacterIndex");
                if (isdefined(var_d264410c)) {
                    focusedcharacterindex = getuimodelvalue(var_d264410c);
                    if (!player_role::is_valid(focusedcharacterindex)) {
                        focusedcharacterindex = undefined;
                    }
                }
            }
            [[ draftcharacter ]]->function_e5bdd4ae().focusedcharacterindex = focusedcharacterindex;
            function_a251e6d6(localclientnum, draftcharacter, isvalidxuid);
        }
    }
}

// Namespace draft/frontend_draft
// Params 1, eflags: 0x0
// Checksum 0x9b35222, Offset: 0x13d8
// Size: 0x5e
function function_123364a3(localclientnum) {
    for (i = 0; i < level.draftcharacters.size; i++) {
        [[ level.draftcharacters[i] ]]->delete_models();
    }
    level.draftcharacters = [];
}

// Namespace draft/frontend_draft
// Params 1, eflags: 0x0
// Checksum 0xf67504f4, Offset: 0x1440
// Size: 0x308
function setup_team(localclientnum) {
    function_123364a3(localclientnum);
    sessionmode = currentsessionmode();
    targetname = "draftCharacter";
    if (sessionmode == 3) {
        level.draftxcam = #"hash_2598b6f5e72695c7";
        targetname = "WZdraftCharacter";
    } else if (sessionmode == 0) {
        level.draftxcam = #"hash_590b617ac1441b1b";
        targetname = "ZMdraftCharacter";
    }
    var_caf8b806 = array::randomize(array(#"pb_launcher_alt_endgame_1stplace_idle", #"pb_sniper_endgame_1stplace_idle", #"pb_lmg_endgame_1stplace_idle"));
    for (i = 0; true; i++) {
        var_1de23248 = function_835971c7(i);
        if (!isdefined(var_1de23248)) {
            break;
        }
        if (!isdefined(level.draftcharacters[i])) {
            model = util::spawn_model(localclientnum, "tag_origin", var_1de23248.origin, var_1de23248.angles);
            model.targetname = targetname + i;
            level.draftcharacters[i] = character_customization::function_9de1b403(model, localclientnum, 0);
            [[ level.draftcharacters[i] ]]->function_e5bdd4ae().var_34de0799 = var_caf8b806[i % var_caf8b806.size];
            [[ level.draftcharacters[i] ]]->function_e5bdd4ae().var_189908ae = i;
            [[ level.draftcharacters[i] ]]->function_e5bdd4ae().params = spawnstruct();
            [[ level.draftcharacters[i] ]]->function_e5bdd4ae().params.sessionmode = sessionmode;
            [[ level.draftcharacters[i] ]]->function_e5bdd4ae().params.scene_target = var_1de23248;
            [[ level.draftcharacters[i] ]]->function_e5bdd4ae().params.var_573638fb = 1;
        }
    }
}

// Namespace draft/frontend_draft
// Params 1, eflags: 0x0
// Checksum 0xb5d40730, Offset: 0x1750
// Size: 0xb8
function function_e3881ad(localclientnum) {
    self notify("68fcfd5c3a5fb9d5");
    self endon("68fcfd5c3a5fb9d5");
    level endon(#"disconnect", #"draft_closed");
    while (true) {
        level waittill(#"hash_4bb9479c29665c84");
        function_362ca1c3(localclientnum, 1000);
        level waittill(#"hash_4ef5fa5de0b8868b");
        function_396382a0(localclientnum, 1000);
    }
}

// Namespace draft/frontend_draft
// Params 1, eflags: 0x0
// Checksum 0x3aba0e6a, Offset: 0x1810
// Size: 0xb0
function function_ac316e8e(localclientnum) {
    self notify("342f2e6b502dc7f5");
    self endon("342f2e6b502dc7f5");
    level endon(#"disconnect", #"draft_closed");
    while (true) {
        waitresult = level waittill(#"positiondraft_update", #"positiondraft_reject", #"hash_6f2435126950e914");
        update_team(localclientnum);
    }
}

// Namespace draft/frontend_draft
// Params 1, eflags: 0x0
// Checksum 0xc2c8c371, Offset: 0x18c8
// Size: 0x98
function function_4b27bd58(localclientnum) {
    self notify("7d52e285512756b3");
    self endon("7d52e285512756b3");
    level endon(#"disconnect", #"draft_closed");
    while (true) {
        waitresult = level waittill(#"hash_8946580b1303e30");
        function_396382a0(localclientnum, 0, 1);
    }
}

// Namespace draft/frontend_draft
// Params 1, eflags: 0x0
// Checksum 0xda43408e, Offset: 0x1968
// Size: 0xf4
function function_c301db9c(localclientnum) {
    self notify("573c3844997d42d9");
    self endon("573c3844997d42d9");
    self endon(#"draft_closed");
    if (!(isdefined(level.draftactive) && level.draftactive)) {
        level.draftactive = 1;
        setup_team(localclientnum);
        function_396382a0(localclientnum, 0);
        level thread function_ac316e8e(localclientnum);
        level thread function_e3881ad(localclientnum);
        level thread function_4b27bd58(localclientnum);
        update_team(localclientnum);
    }
}

// Namespace draft/frontend_draft
// Params 0, eflags: 0x0
// Checksum 0xf6be675d, Offset: 0x1a68
// Size: 0x78
function function_c277b2a1() {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"positiondraft_open");
        localclientnum = waitresult.localclientnum;
        function_c301db9c(localclientnum);
    }
}

// Namespace draft/frontend_draft
// Params 0, eflags: 0x0
// Checksum 0xcf717c25, Offset: 0x1ae8
// Size: 0xce
function function_a305a32b() {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"positiondraft_close");
        localclientnum = waitresult.localclientnum;
        if (isdefined(level.draftactive) && level.draftactive) {
            level notify(#"draft_closed");
            function_123364a3(localclientnum);
            stop_cameras(localclientnum);
            level.draftactive = 0;
        }
    }
}

