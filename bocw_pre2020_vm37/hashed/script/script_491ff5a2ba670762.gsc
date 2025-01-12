#using script_7d712f77ab8d0c16;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace spawning;

// Namespace spawning/namespace_863ecef3
// Params 0, eflags: 0x1 linked
// Checksum 0xf51f1c6c, Offset: 0xb8
// Size: 0x54
function function_d9deb7d7() {
    level.var_8a38cf55 = sessionmodeismultiplayergame() || sessionmodeiswarzonegame();
    if (!isdefined(level.var_e1a685a6)) {
        level.var_e1a685a6 = [];
    }
}

// Namespace spawning/namespace_863ecef3
// Params 1, eflags: 0x1 linked
// Checksum 0x92956890, Offset: 0x118
// Size: 0x2f8
function function_76a18acc(var_8fb24641) {
    if (!isdefined(var_8fb24641.var_ee89b13f)) {
        return undefined;
    }
    typename = var_8fb24641.var_ee89b13f;
    var_e1a8ec1c = function_1dbc6a6(typename);
    var_571293f = [];
    foreach (var_8ad31d96 in var_e1a8ec1c) {
        team = isdefined(var_8ad31d96.team) ? var_8ad31d96.team : #"none";
        if (team == #"none") {
            continue;
        }
        var_4272167e = typename + "_" + team;
        if (!isdefined(var_571293f[var_4272167e])) {
            spawnfilter = spawnstruct();
            spawnfilter.handle = function_4589fcae(var_4272167e);
            spawnfilter.team = team;
            var_571293f[var_4272167e] = spawnfilter;
        } else {
            spawnfilter = var_571293f[var_4272167e];
        }
        function_de7ee873(spawnfilter.handle, var_8ad31d96.id);
    }
    foreach (spawnfilter in var_571293f) {
        if (isdefined(var_8fb24641.friendlyinfluencer)) {
            spawnfilter.friendlyinfluencer = influencers::create_friendly_influencer(var_8fb24641.friendlyinfluencer, (0, 0, 0), spawnfilter.team);
            function_964b011(spawnfilter.friendlyinfluencer, spawnfilter.handle);
        }
        if (isdefined(var_8fb24641.friendlyinfluencer)) {
            spawnfilter.enemyinfluencer = influencers::create_enemy_influencer(var_8fb24641.enemyinfluencer, (0, 0, 0), spawnfilter.team);
            function_964b011(spawnfilter.enemyinfluencer, spawnfilter.handle);
        }
    }
}

// Namespace spawning/namespace_863ecef3
// Params 0, eflags: 0x1 linked
// Checksum 0xf7c9d41c, Offset: 0x418
// Size: 0x10a
function function_fbff01ea() {
    if (!level.var_8a38cf55) {
        return;
    }
    var_8f0eb1d9 = function_fe8b3d2e();
    if (!isdefined(var_8f0eb1d9)) {
        return;
    }
    var_37b279dd = getscriptbundlelist(var_8f0eb1d9);
    if (!isdefined(var_37b279dd)) {
        return;
    }
    foreach (var_2354b422 in var_37b279dd) {
        spawnfilter = getscriptbundle(var_2354b422);
        var_571293f = function_76a18acc(spawnfilter);
    }
}

// Namespace spawning/namespace_863ecef3
// Params 2, eflags: 0x1 linked
// Checksum 0xab96e038, Offset: 0x530
// Size: 0x19c
function function_9b36f6dc(spawnfilter, team) {
    if (team == #"none" || team == #"neutral") {
        if (isdefined(spawnfilter.friendlyinfluencer)) {
            enableinfluencer(spawnfilter.friendlyinfluencer, 0);
        }
        if (isdefined(spawnfilter.enemyinfluencer)) {
            enableinfluencer(spawnfilter.enemyinfluencer, 0);
        }
        if (isdefined(spawnfilter.var_c9150907)) {
            enableinfluencer(spawnfilter.var_c9150907, 1);
        }
        return;
    }
    if (isdefined(spawnfilter.friendlyinfluencer)) {
        enableinfluencer(spawnfilter.friendlyinfluencer, 1);
        function_a32c3352(spawnfilter.friendlyinfluencer, team, 0);
    }
    if (isdefined(spawnfilter.enemyinfluencer)) {
        enableinfluencer(spawnfilter.enemyinfluencer, 1);
        function_a32c3352(spawnfilter.enemyinfluencer, team, 1);
    }
    if (isdefined(spawnfilter.var_c9150907)) {
        enableinfluencer(spawnfilter.var_c9150907, 0);
    }
}

// Namespace spawning/namespace_863ecef3
// Params 2, eflags: 0x1 linked
// Checksum 0x970783f3, Offset: 0x6d8
// Size: 0x304
function function_245cb231(var_8fb24641, objectiveid) {
    spawnfilter = spawnstruct();
    typename = var_8fb24641.var_ee89b13f;
    spawnfilter.var_e1a8ec1c = function_1dbc6a6(typename);
    if (!isdefined(spawnfilter.var_e1a8ec1c)) {
        return;
    }
    spawnfilter.handle = function_4589fcae(typename);
    assert(isdefined(spawnfilter.handle));
    if (!isdefined(spawnfilter.handle)) {
        return;
    }
    foreach (var_8ad31d96 in spawnfilter.var_e1a8ec1c) {
        function_de7ee873(spawnfilter.handle, var_8ad31d96.id);
    }
    var_7c69bb09 = objective_team(objectiveid);
    if (isdefined(var_8fb24641.friendlyinfluencer)) {
        spawnfilter.friendlyinfluencer = influencers::create_friendly_influencer(var_8fb24641.friendlyinfluencer, (0, 0, 0), var_7c69bb09);
        function_964b011(spawnfilter.friendlyinfluencer, spawnfilter.handle);
    }
    if (isdefined(var_8fb24641.enemyinfluencer)) {
        spawnfilter.enemyinfluencer = influencers::create_enemy_influencer(var_8fb24641.enemyinfluencer, (0, 0, 0), var_7c69bb09);
        function_964b011(spawnfilter.enemyinfluencer, spawnfilter.handle);
    }
    if (isdefined(var_8fb24641.var_c9150907)) {
        spawnfilter.var_c9150907 = influencers::create_influencer_generic(var_8fb24641.var_c9150907, (0, 0, 0), #"all");
        function_964b011(spawnfilter.var_c9150907, spawnfilter.handle);
    }
    if (isdefined(var_8fb24641.var_1efc9a1c) && isdefined(var_8fb24641.var_f85ab167)) {
        function_f5c3a4c5(spawnfilter.handle, var_8fb24641.var_f85ab167);
    }
    if (!isdefined(level.var_e1a685a6)) {
        level.var_e1a685a6 = [];
    }
    level.var_e1a685a6[objectiveid] = spawnfilter;
    function_9b36f6dc(spawnfilter, var_7c69bb09);
}

// Namespace spawning/namespace_863ecef3
// Params 0, eflags: 0x0
// Checksum 0x3bd64b8c, Offset: 0x9e8
// Size: 0x12c
function function_89e9e213() {
    if (!isdefined(level.var_e1a685a6) || !level.var_8a38cf55) {
        return;
    }
    foreach (spawnfilter in level.var_e1a685a6) {
        foreach (var_8ad31d96 in spawnfilter.var_e1a8ec1c) {
            function_de7ee873(spawnfilter.handle, var_8ad31d96.id);
        }
    }
}

// Namespace spawning/event_39ae83fb
// Params 1, eflags: 0x40
// Checksum 0xa1b26803, Offset: 0xb20
// Size: 0x84
function event_handler[event_39ae83fb] function_74cfa0e(eventstruct) {
    if (!level.var_8a38cf55) {
        return;
    }
    var_2354b422 = function_6fc9795b(eventstruct.objectiveindex);
    if (!isdefined(var_2354b422)) {
        return;
    }
    spawnfilter = getscriptbundle(var_2354b422);
    function_245cb231(spawnfilter, eventstruct.objectiveindex);
}

// Namespace spawning/event_4f15a780
// Params 1, eflags: 0x40
// Checksum 0x2b7bdbf0, Offset: 0xbb0
// Size: 0x64
function event_handler[event_4f15a780] function_8e8c3fcc(eventstruct) {
    if (!level.var_8a38cf55) {
        return;
    }
    spawnfilter = level.var_e1a685a6[eventstruct.objectiveindex];
    if (!isdefined(spawnfilter)) {
        return;
    }
    function_9b36f6dc(spawnfilter, eventstruct.team);
}

