#using scripts\core_common\character_customization;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dialog_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace draft;

// Namespace draft/draft
// Params 0, eflags: 0x2
// Checksum 0x559b2231, Offset: 0x1a50
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"draft", &__init__, undefined, undefined);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x41574fbf, Offset: 0x1a98
// Size: 0x944
function __init__() {
    clientfield::register("world", "draft", 1, 3, "int", &handledraftstage, 0, 0);
    clientfield::register("clientuimodel", "PositionDraft.stage", 1, 4, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "PositionDraft.autoSelected", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "PositionDraft.cooldown", 1, 5, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "PositionDraft.timeRemaining", 1, 7, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "PositionDraft.waitingForPlayers", 1, 1, "int", undefined, 0, 0);
    serverfield::register("PositionDraft.uiLoaded", 1, 1, "int");
    level.var_86428271 = [];
    level.var_86428271[#"free"] = [];
    level.var_86428271[#"free"][0] = #"hash_6eb882c3b52cdbb3";
    level.var_86428271[#"free"][2] = #"hash_6eb881c3b52cda00";
    level.var_86428271[#"free"][1] = #"hash_6eb884c3b52cdf19";
    level.var_86428271[#"free"][3] = #"hash_6eb883c3b52cdd66";
    level.var_86428271[#"free"][4] = #"hash_6eb886c3b52ce27f";
    level.var_86428271[#"allies"] = [];
    level.var_86428271[#"allies"][0] = #"draft_player_struct_0_allies";
    level.var_86428271[#"allies"][2] = #"draft_player_struct_1_allies";
    level.var_86428271[#"allies"][1] = #"draft_player_struct_2_allies";
    level.var_86428271[#"allies"][3] = #"draft_player_struct_3_allies";
    level.var_86428271[#"allies"][4] = #"draft_player_struct_4_allies";
    level.var_86428271[#"axis"] = [];
    level.var_86428271[#"axis"][0] = #"hash_3b2607cfca030035";
    level.var_86428271[#"axis"][2] = #"hash_253fd3975ea7547c";
    level.var_86428271[#"axis"][1] = #"hash_1edd5ff5456df7f7";
    level.var_86428271[#"axis"][3] = #"hash_61f816d9a00b29c6";
    level.var_86428271[#"axis"][4] = #"hash_753a11f84aa8941";
    level.var_aac1999 = [];
    level.var_aac1999[#"free"] = #"hash_24d789c80dba10e6";
    level.var_aac1999[#"allies"] = #"hash_e2e52f9cab15dce";
    level.var_aac1999[#"axis"] = #"hash_50c9ef9e41155cf9";
    level.draftstructs = [];
    level.draftstructs[#"free"] = #"draft_team_struct";
    level.draftstructs[#"allies"] = #"draft_team_struct_allies";
    level.draftstructs[#"axis"] = #"hash_700492f71a083a7c";
    level.var_e5f8a54 = [];
    level.var_e5f8a54[#"allies"] = "mp_draft_lights_allies";
    level.var_e5f8a54[#"axis"] = "mp_draft_lights_axis";
    level.var_90991f70 = undefined;
    level.playerscriptstructs = [];
    level.playerscriptstructs[#"free"] = [];
    level.playerscriptstructs[#"allies"] = [];
    level.playerscriptstructs[#"axis"] = [];
    for (i = 0; i < 5; i++) {
        level.playerscriptstructs[#"free"][i] = struct::get(level.var_86428271[#"free"][i]);
        level.playerscriptstructs[#"allies"][i] = struct::get(level.var_86428271[#"allies"][i]);
        level.playerscriptstructs[#"axis"][i] = struct::get(level.var_86428271[#"axis"][i]);
    }
    level thread function_c277b2a1();
    level thread function_a305a32b();
    level.draftstage = 0;
    level.draftcharacters = [];
    level.draftactive = [];
    level.var_8962241 = [];
    level.var_24f5a391 = [];
    level.draftintroplayed = [];
    for (i = 0; i < getmaxlocalclients(); i++) {
        level.draftactive[i] = 0;
        level.draftintroplayed[i] = 0;
        level.var_8962241[i] = "";
        level.var_24f5a391[i] = "";
        level.draftcharacters[i] = [];
    }
    autoselectcharacter = getdvarint(#"auto_select_character", -1);
    if (player_role::is_valid(autoselectcharacter)) {
        clearstreamerloadinghints();
    }
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0xe8d17990, Offset: 0x23e8
// Size: 0x62
function function_835971c7(team, index) {
    if (!isdefined(level.var_86428271[team])) {
        team = #"free";
    }
    return struct::get(level.var_86428271[team][index]);
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x905ebb49, Offset: 0x2458
// Size: 0x252
function play_intro_cinematic(localclientnum) {
    if (isdefined(level.draftintroplayed[localclientnum]) && level.draftintroplayed[localclientnum]) {
        return false;
    }
    localplayer = function_f97e7787(localclientnum);
    if (isdefined(level.var_aac1999[localplayer.team])) {
        var_843c3e66 = struct::get(level.var_aac1999[localplayer.team]);
        if (isdefined(var_843c3e66) && isdefined(level.var_b0a63eb6) && isdefined(level.var_b0a63eb6[localplayer.team])) {
            level.var_8962241[localclientnum] = "cam_draft_intro";
            playmaincamxcam(localclientnum, level.var_b0a63eb6[localplayer.team], 0, "cam_draft_intro", "", var_843c3e66.origin, var_843c3e66.angles);
            duration = getcamanimtime(level.var_b0a63eb6[localplayer.team]);
            wait float(duration) / 1000;
            level.draftintroplayed[localclientnum] = 1;
        }
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "PositionDraft.introPlayed"), 1);
    function_396382a0(localclientnum, 0);
    function_86022e3a(localclientnum);
    return isdefined(level.draftintroplayed[localclientnum]) && level.draftintroplayed[localclientnum];
}

// Namespace draft/draft
// Params 4, eflags: 0x0
// Checksum 0x97c243a6, Offset: 0x26b8
// Size: 0x1aa
function show_cam(localclientnum, xcam, animname, lerpduration) {
    if (isdefined(level.var_6fba5d94) && level.var_6fba5d94) {
        return;
    }
    if (!isdefined(xcam) || !isdefined(animname)) {
        return;
    }
    if (isdefined(level.var_8962241[localclientnum]) && level.var_8962241[localclientnum] == animname && isdefined(level.var_24f5a391[localclientnum]) && level.var_24f5a391[localclientnum] == xcam) {
        return;
    }
    localplayer = function_f97e7787(localclientnum);
    if (isdefined(level.draftstructs[localplayer.team])) {
        draftstruct = struct::get(level.draftstructs[localplayer.team], "targetname");
        if (isdefined(draftstruct)) {
            playmaincamxcam(localclientnum, xcam, lerpduration, animname, "", draftstruct.origin, draftstruct.angles);
            level.var_8962241[localclientnum] = animname;
            level.var_24f5a391[localclientnum] = xcam;
        }
    }
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0xf3612f6a, Offset: 0x2870
// Size: 0x44
function stop_cameras(localclientnum) {
    stopmaincamxcam(localclientnum);
    level.var_8962241[localclientnum] = undefined;
    level.var_24f5a391[localclientnum] = undefined;
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0xfe197c86, Offset: 0x28c0
// Size: 0x3c
function function_362ca1c3(localclientnum, lerpduration) {
    show_cam(localclientnum, level.var_a49d0b27, "cam_draft_zoom", lerpduration);
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0x8d25f1d0, Offset: 0x2908
// Size: 0x3c
function function_396382a0(localclientnum, lerpduration) {
    show_cam(localclientnum, level.draftxcam, "cam_draft_ingame", lerpduration);
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0x12145010, Offset: 0x2950
// Size: 0x3c
function function_a02d2a2b(localclientnum, lerpduration) {
    show_cam(localclientnum, "ui_cam_frontend_loadout_mp", "cam_loadout_mp", lerpduration);
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x717e9342, Offset: 0x2998
// Size: 0x8c
function enable_lights(localclientnum) {
    localplayer = function_f97e7787(localclientnum);
    if (isdefined(level.var_e5f8a54[localplayer.team])) {
        level.var_90991f70 = level.var_e5f8a54[localplayer.team];
        playradiantexploder(localclientnum, level.var_90991f70);
    }
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0xeba1a7dc, Offset: 0x2a30
// Size: 0x66
function function_eef40235(localclientnum) {
    localplayer = function_f97e7787(localclientnum);
    if (isdefined(level.var_90991f70)) {
        killradiantexploder(localclientnum, level.var_90991f70);
        level.var_90991f70 = undefined;
    }
}

// Namespace draft/draft
// Params 7, eflags: 0x0
// Checksum 0x198230c0, Offset: 0x2aa0
// Size: 0xa4
function handledraftstage(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(newval)) {
        controllermodel = getuimodelforcontroller(localclientnum);
        var_da2ad088 = createuimodel(controllermodel, "PositionDraft.stage");
        setuimodelvalue(var_da2ad088, newval);
    }
}

// Namespace draft/draft
// Params 3, eflags: 0x0
// Checksum 0x40149e7c, Offset: 0x2b50
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

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0xfa356d11, Offset: 0x2c58
// Size: 0x84
function function_938519dd(localclientnum) {
    foreach (character in level.draftcharacters[localclientnum]) {
        [[ character ]]->show_model();
    }
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x9b7779be, Offset: 0x2ce8
// Size: 0x84
function function_86022e3a(localclientnum) {
    foreach (character in level.draftcharacters[localclientnum]) {
        [[ character ]]->hide_model();
    }
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0xaa436d16, Offset: 0x2d78
// Size: 0xa6
function function_b2f5a53(localclientnum) {
    for (i = 0; i < level.draftcharacters[localclientnum].size; i++) {
        if ([[ level.draftcharacters[localclientnum][i] ]]->function_e5bdd4ae().islocalclient) {
            [[ level.draftcharacters[localclientnum][i] ]]->show_model();
            continue;
        }
        [[ level.draftcharacters[localclientnum][i] ]]->hide_model();
    }
}

// Namespace draft/draft
// Params 4, eflags: 0x0
// Checksum 0xc9b0817f, Offset: 0x2e28
// Size: 0xd4
function function_2996cfb6(localclientnum, draftcharacter, oldcharacterindex, var_e506b18e) {
    if (!isdefined([[ draftcharacter ]]->function_e5bdd4ae().player)) {
        return;
    }
    if (isdefined([[ draftcharacter ]]->function_e5bdd4ae().localclientnum) && [[ draftcharacter ]]->function_e5bdd4ae().localclientnum == localclientnum && player_role::is_valid([[ draftcharacter ]]->function_e5bdd4ae().selectedcharacterindex)) {
        [[ draftcharacter ]]->function_e5bdd4ae().player dialog_shared::play_dialog("characterSelect", localclientnum);
    }
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0xe072daa9, Offset: 0x2f08
// Size: 0x10e4
function function_2717fafe(var_e01ec9a8) {
    weapon_group_anim = "default";
    weapon = var_e01ec9a8.activeweapon;
    if (isdefined(weapon)) {
        weapon_group = function_b3cd8cdc(weapon);
        if (weapon_group == #"") {
            weapon_group_anim = "brawler";
        } else if (weapon_group == #"weapon_launcher" || weapon_group == #"weapon_launcher_alt") {
            weapon_group_anim = "launcher";
        } else if (weapon_group == #"weapon_pistol" || weapon_group == #"weapon_pistol_dw") {
            weapon_group_anim = "pistol";
        } else if (weapon_group == #"weapon_smg") {
            weapon_group_anim = "smg";
        }
    }
    return associativearray(#"default", associativearray(#"select", associativearray(#"male", "pb_rifle_male_draft_ch_select_3", #"female", "pb_rifle_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_rifle_male_draft_select_to_preready_3", #"female", "pb_rifle_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_rifle_male_draft_preready_to_select_3", #"female", "pb_rifle_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_rifle_male_draft_preready_1", "pb_rifle_male_draft_preready_2", "pb_rifle_male_draft_preready_3", "pb_rifle_male_draft_preready_4", "pb_rifle_male_draft_preready_5"), #"female", array("pb_rifle_fem_draft_preready_1", "pb_rifle_fem_draft_preready_2", "pb_rifle_fem_draft_preready_3", "pb_rifle_fem_draft_preready_4", "pb_rifle_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_rifle_male_draft_transition_1", "pb_rifle_male_draft_transition_2", "pb_rifle_male_draft_transition_3", "pb_rifle_male_draft_transition_4", "pb_rifle_male_draft_transition_5"), #"female", array("pb_rifle_fem_draft_transition_1", "pb_rifle_fem_draft_transition_2", "pb_rifle_fem_draft_transition_3", "pb_rifle_fem_draft_transition_4", "pb_rifle_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_rifle_male_draft_readyup_1", "pb_rifle_male_draft_readyup_2", "pb_rifle_male_draft_readyup_3", "pb_rifle_male_draft_readyup_4", "pb_rifle_male_draft_readyup_5"), #"female", array("pb_rifle_fem_draft_readyup_1", "pb_rifle_fem_draft_readyup_2", "pb_rifle_fem_draft_readyup_3", "pb_rifle_fem_draft_readyup_4", "pb_rifle_fem_draft_readyup_5"))), #"brawler", associativearray(#"select", associativearray(#"male", "pb_brawler_male_draft_idle_ch_select_3", #"female", "pb_brawler_fem_draft_idle_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_brawler_male_draft_select_to_preready_3", #"female", "pb_brawler_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_brawler_male_draft_preready_to_select_3", #"female", "pb_brawler_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_brawler_male_draft_idle_preready1", "pb_brawler_male_draft_idle_preready2", "pb_brawler_male_draft_idle_preready3", "pb_brawler_male_draft_idle_preready4", "pb_brawler_male_draft_idle_preready5"), #"female", array("pb_brawler_fem_draft_idle_preready1", "pb_brawler_fem_draft_idle_preready2", "pb_brawler_fem_draft_idle_preready3", "pb_brawler_fem_draft_idle_preready4", "pb_brawler_fem_draft_idle_preready5")), #"ready", associativearray(#"male", array("pb_brawler_male_draft_idle_transition_1", "pb_brawler_male_draft_idle_transition_2", "pb_brawler_male_draft_idle_transition_3", "pb_brawler_male_draft_idle_transition_4", "pb_brawler_male_draft_idle_transition_5"), #"female", array("pb_brawler_fem_draft_idle_transition_1", "pb_brawler_fem_draft_idle_transition_2", "pb_brawler_fem_draft_idle_transition_3", "pb_brawler_fem_draft_idle_transition_4", "pb_brawler_fem_draft_idle_transition_5")), #"readyidle", associativearray(#"male", array("pb_brawler_male_draft_readyup_1", "pb_brawler_male_draft_readyup_2", "pb_brawler_male_draft_readyup_3", "pb_brawler_male_draft_readyup_4", "pb_brawler_male_draft_readyup_5"), #"female", array("pb_brawler_fem_draft_readyup_1", "pb_brawler_fem_draft_readyup_2", "pb_brawler_fem_draft_readyup_3", "pb_brawler_fem_draft_readyup_4", "pb_brawler_fem_draft_readyup_5"))), #"launcher", associativearray(#"select", associativearray(#"male", "pb_launcher_male_draft_ch_select_3", #"female", "pb_launcher_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_launcher_male_draft_select_to_preready_3", #"female", "pb_launcher_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_launcher_male_draft_preready_to_select_3", #"female", "pb_launcher_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_launcher_male_draft_preready1", "pb_launcher_male_draft_preready2", "pb_launcher_male_draft_preready3", "pb_launcher_male_draft_preready4", "pb_launcher_male_draft_preready5"), #"female", array("pb_launcher_fem_draft_ch_preready_1", "pb_launcher_fem_draft_ch_preready_2", "pb_launcher_fem_draft_ch_preready_3", "pb_launcher_fem_draft_ch_preready_4", "pb_launcher_fem_draft_ch_preready_5")), #"ready", associativearray(#"male", array("pb_launcher_male_draft_transition_1", "pb_launcher_male_draft_transition_2", "pb_launcher_male_draft_transition_3", "pb_launcher_male_draft_transition_4", "pb_launcher_male_draft_transition_5"), #"female", array("pb_launcher_fem_draft_transition_1", "pb_launcher_fem_draft_transition_2", "pb_launcher_fem_draft_transition_3", "pb_launcher_fem_draft_transition_4", "pb_launcher_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_launcher_male_draft_readyup_1", "pb_launcher_male_draft_readyup_2", "pb_launcher_male_draft_readyup_3", "pb_launcher_male_draft_readyup_4", "pb_launcher_male_draft_readyup_5"), #"female", array("pb_launcher_fem_draft_readyup_1", "pb_launcher_fem_draft_readyup_2", "pb_launcher_fem_draft_readyup_3", "pb_launcher_fem_draft_readyup_4", "pb_launcher_fem_draft_readyup_5"))), #"pistol", associativearray(#"select", associativearray(#"male", "pb_pistol_male_draft_ch_select_3", #"female", "pb_pistol_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_pistol_male_draft_select_to_preready_3", #"female", "pb_pistol_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_pistol_male_draft_preready_to_select_3", #"female", "pb_pistol_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_pistol_male_draft_preready_1", "pb_pistol_male_draft_preready_2", "pb_pistol_male_draft_preready_3", "pb_pistol_male_draft_preready_4", "pb_pistol_male_draft_preready_5"), #"female", array("pb_pistol_fem_draft_preready_1", "pb_pistol_fem_draft_preready_2", "pb_pistol_fem_draft_preready_3", "pb_pistol_fem_draft_preready_4", "pb_pistol_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_pistol_male_draft_transition_1", "pb_pistol_male_draft_transition_2", "pb_pistol_male_draft_transition_3", "pb_pistol_male_draft_transition_4", "pb_pistol_male_draft_transition_5"), #"female", array("pb_pistol_fem_draft_transition_1", "pb_pistol_fem_draft_transition_2", "pb_pistol_fem_draft_transition_3", "pb_pistol_fem_draft_transition_4", "pb_pistol_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_pistol_male_draft_readyup_1", "pb_pistol_male_draft_readyup_2", "pb_pistol_male_draft_readyup_3", "pb_pistol_male_draft_readyup_4", "pb_pistol_male_draft_readyup_5"), #"female", array("pb_pistol_fem_draft_readyup_1", "pb_pistol_fem_draft_readyup_2", "pb_pistol_fem_draft_readyup_3", "pb_pistol_fem_draft_readyup_4", "pb_pistol_fem_draft_readyup_5"))), #"smg", associativearray(#"select", associativearray(#"male", "pb_smg_male_draft_idle_ch_select_3", #"female", "pb_smg_fem_draft_idle_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_smg_male_draft_select_to_preready_3", #"female", "pb_smg_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_smg_male_draft_preready_to_select_3", #"female", "pb_smg_fem_draft_preready_to_select_3"), #"preready", associativearray(#"male", array("pb_smg_male_draft_preready_1", "pb_smg_male_draft_preready_2", "pb_smg_male_draft_preready_3", "pb_smg_male_draft_preready_4", "pb_smg_male_draft_preready_5"), #"female", array("pb_smg_fem_draft_preready_1", "pb_smg_fem_draft_preready_2", "pb_smg_fem_draft_preready_3", "pb_smg_fem_draft_preready_4", "pb_smg_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_smg_male_draft_transition_1", "pb_smg_male_draft_transition_2", "pb_smg_male_draft_transition_3", "pb_smg_male_draft_transition_4", "pb_smg_male_draft_transition_5"), #"female", array("pb_smg_fem_draft_transition_1", "pb_smg_fem_draft_transition_2", "pb_smg_fem_draft_transition_3", "pb_smg_fem_draft_transition_4", "pb_smg_fem_draft_transition_5")), #"readyidle", associativearray(#"male", array("pb_smg_male_draft_readyup_1", "pb_smg_male_draft_readyup_2", "pb_smg_male_draft_readyup_3", "pb_smg_male_draft_readyup_4", "pb_smg_male_draft_readyup_5"), #"female", array("pb_smg_fem_draft_readyup_1", "pb_smg_fem_draft_readyup_2", "pb_smg_fem_draft_readyup_3", "pb_smg_fem_draft_readyup_4", "pb_smg_fem_draft_readyup_5"))))[weapon_group_anim];
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0x50e560e0, Offset: 0x3ff8
// Size: 0x316
function function_242782c1(var_e01ec9a8, sessionmode) {
    posindex = var_e01ec9a8.positionindex;
    anim_intro_name = undefined;
    anim_name = undefined;
    weapongroupanim = function_2717fafe(var_e01ec9a8);
    if (player_role::is_valid(var_e01ec9a8.activecharacter)) {
        gender = getherogender(var_e01ec9a8.activecharacter, sessionmode);
        if (var_e01ec9a8.var_c2158b0e != var_e01ec9a8.var_3d77214d) {
            if (var_e01ec9a8.var_c2158b0e) {
                var_eed800cc = weapongroupanim[#"ready"][gender];
                anim_intro_name = var_eed800cc[posindex % var_eed800cc.size];
                var_b91175da = weapongroupanim[#"readyidle"][gender];
                anim_name = var_b91175da[posindex % var_b91175da.size];
            }
            var_e01ec9a8.var_3d77214d = var_e01ec9a8.var_c2158b0e;
        } else if (player_role::is_valid(var_e01ec9a8.focusedcharacterindex)) {
            if (var_e01ec9a8.selected) {
                anim_intro_name = weapongroupanim[#"hash_2fe61241a25ee67c"][gender];
                var_e01ec9a8.selected = 0;
            }
            anim_name = weapongroupanim[#"select"][gender];
        } else {
            if (!var_e01ec9a8.var_c2158b0e) {
                if (posindex == 1) {
                    anim_intro_name = weapongroupanim[#"hash_6eaac8719751cb14"][gender];
                }
                var_ca53630d = weapongroupanim[#"preready"][gender];
                anim_name = var_ca53630d[posindex % var_ca53630d.size];
            }
            var_e01ec9a8.selected = 1;
        }
    } else {
        anim_name = array("pb_rifle_male_draft_preready_1", "pb_rifle_male_draft_preready_2", "pb_rifle_male_draft_preready_3", "pb_rifle_male_draft_preready_4", "pb_rifle_male_draft_preready_5")[posindex % array("pb_rifle_male_draft_preready_1", "pb_rifle_male_draft_preready_2", "pb_rifle_male_draft_preready_3", "pb_rifle_male_draft_preready_4", "pb_rifle_male_draft_preready_5").size];
    }
    var_e01ec9a8.params.anim_intro_name = anim_intro_name;
    var_e01ec9a8.params.anim_name = anim_name;
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0xcfa40a5f, Offset: 0x4318
// Size: 0x208
function function_bd9af109(localclientnum, draftcharacter) {
    var_e01ec9a8 = [[ draftcharacter ]]->function_e5bdd4ae();
    if (player_role::is_valid(var_e01ec9a8.focusedcharacterindex)) {
        if (isdefined(var_e01ec9a8.activecharacter) && var_e01ec9a8.activecharacter == var_e01ec9a8.focusedcharacterindex) {
            return false;
        }
        var_e01ec9a8.activecharacter = var_e01ec9a8.focusedcharacterindex;
    } else if (!isdefined(var_e01ec9a8.activecharacter) || var_e01ec9a8.activecharacter != var_e01ec9a8.selectedcharacterindex) {
        function_2996cfb6(localclientnum, draftcharacter, var_e01ec9a8.activecharacter, var_e01ec9a8.selectedcharacterindex);
        var_e01ec9a8.activecharacter = var_e01ec9a8.selectedcharacterindex;
    }
    sessionmode = currentsessionmode();
    [[ draftcharacter ]]->set_character_mode(sessionmode);
    if (player_role::is_valid(var_e01ec9a8.activecharacter)) {
        [[ draftcharacter ]]->function_abb62848(0);
        [[ draftcharacter ]]->set_character_index(var_e01ec9a8.activecharacter);
        [[ draftcharacter ]]->function_fd80d28b();
        function_9f457d30(localclientnum, draftcharacter, 0);
    } else {
        [[ draftcharacter ]]->function_abb62848(1);
        [[ draftcharacter ]]->set_character_index(0);
        function_9f457d30(localclientnum, draftcharacter, 1);
    }
    return true;
}

// Namespace draft/draft
// Params 4, eflags: 0x0
// Checksum 0x24afade0, Offset: 0x4528
// Size: 0x24
function function_2263ff6(localclientnum, draftcharacter, oldweapon, newweapon) {
    
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0xdcf345c6, Offset: 0x4558
// Size: 0xd8
function function_d97bfd53(localclientnum, draftcharacter) {
    if (isdefined([[ draftcharacter ]]->function_e5bdd4ae().primaryweapon)) {
        if (!isdefined([[ draftcharacter ]]->function_e5bdd4ae().activeweapon)) {
            return true;
        }
        if (isdefined(level.var_ab22f020) && level.var_ab22f020) {
            return ([[ draftcharacter ]]->function_e5bdd4ae().activeweapon != getweapon(#"pistol_standard_t8"));
        } else {
            return ([[ draftcharacter ]]->function_e5bdd4ae().activeweapon != [[ draftcharacter ]]->function_e5bdd4ae().primaryweapon);
        }
    }
    return false;
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0x50cc5895, Offset: 0x4638
// Size: 0x142
function update_player_weapon(localclientnum, draftcharacter) {
    changed = 0;
    if (function_d97bfd53(localclientnum, draftcharacter)) {
        function_2263ff6(localclientnum, draftcharacter, [[ draftcharacter ]]->function_e5bdd4ae().activeweapon, [[ draftcharacter ]]->function_e5bdd4ae().primaryweapon);
        if (!(isdefined(level.var_ab22f020) && level.var_ab22f020)) {
            [[ draftcharacter ]]->function_e5bdd4ae().activeweapon = [[ draftcharacter ]]->function_e5bdd4ae().primaryweapon;
        } else {
            [[ draftcharacter ]]->function_e5bdd4ae().activeweapon = getweapon(#"pistol_standard_t8");
        }
        [[ draftcharacter ]]->function_e5bdd4ae().params.activeweapon = [[ draftcharacter ]]->function_e5bdd4ae().activeweapon;
        changed = 1;
    }
    return changed;
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0xb43691cd, Offset: 0x4788
// Size: 0xe0
function function_a251e6d6(localclientnum, draftcharacter) {
    update = 0;
    if (function_bd9af109(localclientnum, draftcharacter)) {
        update = 1;
    }
    if (update_player_weapon(localclientnum, draftcharacter)) {
        update = 1;
    }
    if (update) {
        sessionmode = currentsessionmode();
        var_e01ec9a8 = [[ draftcharacter ]]->function_e5bdd4ae();
        function_242782c1(var_e01ec9a8, sessionmode);
        [[ draftcharacter ]]->update([[ draftcharacter ]]->function_e5bdd4ae().params);
    }
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0x4a9c0bdb, Offset: 0x4870
// Size: 0x5ee
function update_team(localclientnum, var_470f22d6) {
    localplayer = function_f97e7787(localclientnum);
    controllermodel = getuimodelforcontroller(localclientnum);
    positiondraftclientsmodel = getuimodel(controllermodel, "PositionDraftClients");
    for (i = 0; i < 5; i++) {
        if (!isdefined(level.draftcharacters[localclientnum][i])) {
            continue;
        }
        draftcharacter = level.draftcharacters[localclientnum][i];
        [[ draftcharacter ]]->function_e5bdd4ae().selectedcharacterindex = 0;
        [[ draftcharacter ]]->function_e5bdd4ae().primaryweapon = level.weaponnone;
        if (isdefined(positiondraftclientsmodel)) {
            luaindex = i + 1;
            positionmodel = getuimodel(positiondraftclientsmodel, luaindex);
            clientnum = getuimodelvalue(getuimodel(positionmodel, "clientNum"));
            [[ draftcharacter ]]->function_e5bdd4ae().islocalclient = getuimodelvalue(getuimodel(positionmodel, "isLocalClient"));
            [[ draftcharacter ]]->function_e5bdd4ae().entnummodel = createuimodel(positionmodel, "entNum");
            setuimodelvalue([[ draftcharacter ]]->function_e5bdd4ae().entnummodel, [[ draftcharacter ]]->function_295fce60());
            if (clientnum >= 0) {
                player = getentbynum(localclientnum, clientnum);
                if (isdefined(player)) {
                    [[ draftcharacter ]]->function_e5bdd4ae().player = player;
                    [[ draftcharacter ]]->function_e5bdd4ae().selectedcharacterindex = player getselectedcharacterindex();
                    if (player_role::is_valid([[ draftcharacter ]]->function_e5bdd4ae().selectedcharacterindex) && player_role::is_valid([[ draftcharacter ]]->function_e5bdd4ae().focusedcharacterindex)) {
                        [[ draftcharacter ]]->function_e5bdd4ae().activecharacter = 0;
                        [[ draftcharacter ]]->function_e5bdd4ae().focusedcharacterindex = 0;
                    }
                    [[ draftcharacter ]]->function_e5bdd4ae().primaryweapon = player getprimaryweapon();
                } else {
                    [[ draftcharacter ]]->function_e5bdd4ae().player = undefined;
                }
                if (isdefined([[ draftcharacter ]]->function_e5bdd4ae().islocalclient) && [[ draftcharacter ]]->function_e5bdd4ae().islocalclient) {
                    if (!isdefined([[ draftcharacter ]]->function_e5bdd4ae().player)) {
                        [[ draftcharacter ]]->function_e5bdd4ae().player = localplayer;
                        [[ draftcharacter ]]->function_e5bdd4ae().primaryweapon = localplayer getprimaryweapon();
                    }
                    [[ draftcharacter ]]->function_e5bdd4ae().localclientnum = localclientnum;
                    if (player_role::is_valid([[ draftcharacter ]]->function_e5bdd4ae().selectedcharacterindex)) {
                        function_938519dd(localclientnum);
                        lerpduration = 1000;
                        if (var_470f22d6) {
                            lerpduration = 0;
                        }
                        function_396382a0(localclientnum, lerpduration);
                    } else {
                        function_b2f5a53(localclientnum);
                        lerpduration = 1000;
                        if (var_470f22d6) {
                            lerpduration = 0;
                        }
                        function_362ca1c3(localclientnum, lerpduration);
                        positiondraftmodel = getuimodel(controllermodel, "PositionDraft");
                        if (isdefined(positiondraftmodel)) {
                            [[ draftcharacter ]]->function_e5bdd4ae().focusedcharacterindex = getuimodelvalue(getuimodel(positiondraftmodel, "focusedCharacterIndex"));
                        }
                    }
                } else {
                    [[ draftcharacter ]]->function_e5bdd4ae().localclientnum = undefined;
                }
                var_3f0c466b = getuimodelvalue(getuimodel(positionmodel, "clientInfo"));
                [[ draftcharacter ]]->function_e5bdd4ae().var_c2158b0e = getuimodelvalue(getuimodel(var_3f0c466b, "ready"));
            }
        }
        function_a251e6d6(localclientnum, draftcharacter);
    }
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0x5a881e44, Offset: 0x4e68
// Size: 0x64
function function_806165df(localclientnum, draftcharacter) {
    if (isdefined([[ draftcharacter ]]->function_e5bdd4ae().entnummodel)) {
        setuimodelvalue([[ draftcharacter ]]->function_e5bdd4ae().entnummodel, [[ draftcharacter ]]->function_295fce60());
    }
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x56be3075, Offset: 0x4ed8
// Size: 0x6e
function function_123364a3(localclientnum) {
    for (i = 0; i < level.draftcharacters[localclientnum].size; i++) {
        [[ level.draftcharacters[localclientnum][i] ]]->delete_models();
    }
    level.draftcharacters[localclientnum] = [];
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0xab8e5268, Offset: 0x4f50
// Size: 0x252
function setup_team(localclientnum) {
    function_123364a3(localclientnum);
    localplayer = function_f97e7787(localclientnum);
    if (isdefined(level.playerscriptstructs[localplayer.team])) {
        for (i = 0; i < level.playerscriptstructs[localplayer.team].size; i++) {
            if (!isdefined(level.draftcharacters[localclientnum][i])) {
                model = util::spawn_model(localclientnum, "tag_origin", level.playerscriptstructs[localplayer.team][i].origin, level.playerscriptstructs[localplayer.team][i].angles);
                model.targetname = level.playerscriptstructs[localplayer.team][i].targetname;
                draftcharacter = character_customization::function_9de1b403(model, localclientnum, 0);
                [[ draftcharacter ]]->function_91db38af(&function_806165df);
                var_e01ec9a8 = [[ draftcharacter ]]->function_e5bdd4ae();
                var_e01ec9a8.positionindex = i;
                var_e01ec9a8.var_3d77214d = 0;
                var_e01ec9a8.var_c2158b0e = 0;
                var_e01ec9a8.selected = 0;
                var_e01ec9a8.params = spawnstruct();
                var_e01ec9a8.params.sessionmode = currentsessionmode();
                var_e01ec9a8.islocalclient = 0;
                level.draftcharacters[localclientnum][i] = draftcharacter;
            }
        }
    }
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0xcbe1cab, Offset: 0x51b0
// Size: 0xa0
function watchupdate(localclientnum) {
    level endon(#"disconnect", #"draft_closed");
    while (true) {
        waitresult = level waittill(#"positiondraft_update", #"positiondraft_reject");
        if (localclientnum == waitresult.localclientnum) {
            update_team(localclientnum, 0);
        }
    }
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0xebcc1d04, Offset: 0x5258
// Size: 0xa0
function watchteamchange(localclientnum) {
    self endon(#"disconnect", #"draft_closed");
    while (true) {
        waitresult = level waittill(#"team_changed");
        if (localclientnum == waitresult.localclientnum) {
            setup_team(localclientnum);
            update_team(localclientnum, 1);
        }
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x89441a90, Offset: 0x5300
// Size: 0xa0
function watchkillcam() {
    self notify(#"hash_79dc7957d60fa25");
    self endon(#"hash_79dc7957d60fa25", #"disconnect", #"draft_closed");
    while (true) {
        level.var_6fba5d94 = 0;
        level waittill(#"killcam_begin");
        level.var_6fba5d94 = 1;
        level waittill(#"killcam_end");
    }
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x7b02c173, Offset: 0x53a8
// Size: 0x14c
function function_c301db9c(localclientnum) {
    self notify("718d6ac012510ccc");
    self endon("718d6ac012510ccc");
    self endon(#"draft_closed");
    if (!(isdefined(level.draftactive[localclientnum]) && level.draftactive[localclientnum])) {
        level.draftactive[localclientnum] = 1;
        setup_team(localclientnum);
        play_intro_cinematic(localclientnum);
        enable_lights(localclientnum);
        level thread watchupdate(localclientnum);
        level thread watchteamchange(localclientnum);
        if (!(isdefined(level.var_da8d6b70) && level.var_da8d6b70)) {
            level.var_da8d6b70 = 1;
            level thread watchkillcam();
        }
        update_team(localclientnum, 1);
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x4c6c379e, Offset: 0x5500
// Size: 0xb8
function function_c277b2a1() {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"positiondraft_open");
        localclientnum = waitresult.localclientnum;
        localplayer = function_f97e7787(localclientnum);
        localplayer serverfield::set("PositionDraft.uiLoaded", 1);
        level thread function_c301db9c(localclientnum);
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x4647d379, Offset: 0x55c0
// Size: 0x136
function function_a305a32b() {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"positiondraft_close");
        localclientnum = waitresult.localclientnum;
        if (isdefined(level.draftactive[localclientnum]) && level.draftactive[localclientnum]) {
            if (!(isdefined(level.draftclosed) && level.draftclosed)) {
                level notify(#"draft_closed");
                clearstreamerloadinghints();
                level.draftclosed = 1;
            }
            function_123364a3(localclientnum);
            function_eef40235(localclientnum);
            stop_cameras(localclientnum);
            level.draftactive[localclientnum] = 0;
        }
    }
}

