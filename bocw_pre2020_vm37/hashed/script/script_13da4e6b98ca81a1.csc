#using scripts\core_common\flag_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\util_shared;

#namespace codcaster;

// Namespace codcaster/codcaster
// Params 1, eflags: 0x1 linked
// Checksum 0x72a47611, Offset: 0x1b0
// Size: 0x22
function function_b8fe9b52(localclientnum) {
    return function_4e3684f2(localclientnum);
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x1 linked
// Checksum 0x140fda73, Offset: 0x1e0
// Size: 0x3c
function function_45a5c04c(localclientnum) {
    return function_b8fe9b52(localclientnum) && function_21dc7cf(localclientnum);
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x0
// Checksum 0xde0a2988, Offset: 0x228
// Size: 0x3c
function function_936862dc(localclientnum) {
    return function_b8fe9b52(localclientnum) && function_4af9029c(localclientnum);
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x1 linked
// Checksum 0x45e91d42, Offset: 0x270
// Size: 0x44
function function_39bce377(localclientnum) {
    return function_b8fe9b52(localclientnum) && function_aa0b7b86(localclientnum, "codcaster_team_identity");
}

// Namespace codcaster/codcaster
// Params 3, eflags: 0x1 linked
// Checksum 0x371935dc, Offset: 0x2c0
// Size: 0x7a
function function_f47e494a(localclientnum, team, colorindex) {
    if (team == #"allies") {
        return function_aa0b7b86(localclientnum, "codcaster_team1_color" + colorindex);
    }
    return function_aa0b7b86(localclientnum, "codcaster_team2_color" + colorindex);
}

// Namespace codcaster/codcaster
// Params 3, eflags: 0x1 linked
// Checksum 0x905d69e2, Offset: 0x348
// Size: 0xb2
function function_1f84bb65(local_client_num, team, colorindex) {
    if (function_39bce377(local_client_num)) {
        var_216b0054 = function_f47e494a(local_client_num, team, colorindex);
        teamcolor = (var_216b0054[0] / 255, var_216b0054[1] / 255, var_216b0054[2] / 255);
    } else {
        teamcolor = function_45a33458(local_client_num, team, colorindex);
    }
    return teamcolor;
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x0
// Checksum 0x9c788516, Offset: 0x408
// Size: 0x84
function is_friendly(localclientnum) {
    scorepanel_flipped = function_aa0b7b86(localclientnum, "codcaster_flip_scorepanel");
    if (!scorepanel_flipped) {
        friendly = self.team == #"allies";
    } else {
        friendly = self.team == #"axis";
    }
    return friendly;
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x0
// Checksum 0xfcc65153, Offset: 0x498
// Size: 0x54
function function_57a6b7b0(local_client_num) {
    thread codcaster_monitor_xray_change(local_client_num);
    thread codcaster_monitor_player_pucks(local_client_num);
    thread function_914ef81b(local_client_num);
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x5 linked
// Checksum 0x5aa57a32, Offset: 0x4f8
// Size: 0x9c
function private function_914ef81b(localclientnum) {
    level waittill(#"localplayer_spawned");
    waitframe(1);
    util::waitforclient(localclientnum);
    if (function_b8fe9b52(localclientnum)) {
        function_9e0f8f9d(localclientnum);
        level waittill(#"game_ended");
        function_63c282e0(localclientnum);
    }
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x5 linked
// Checksum 0x5de1345c, Offset: 0x5a0
// Size: 0x2c8
function private codcaster_monitor_xray_change(local_client_num) {
    level notify("codcaster_monitor_xray_change" + local_client_num);
    level endon("codcaster_monitor_xray_change" + local_client_num);
    level waittill(#"localplayer_spawned");
    waitframe(1);
    util::waitforclient(local_client_num);
    forceupdate = 1;
    localplayer = function_5c10bd79(local_client_num);
    lastteam = localplayer.team;
    var_f4e066d = 0;
    var_fb32b8ee = 0;
    var_adcf5c30 = 0;
    if (function_b8fe9b52(local_client_num)) {
        var_f4e066d = function_aa0b7b86(local_client_num, "codcaster_xray");
        var_fb32b8ee = function_aa0b7b86(local_client_num, "codcaster_xray_target");
        var_adcf5c30 = function_aa0b7b86(local_client_num, "codcaster_xray_advanced_target");
    }
    while (true) {
        waitframe(1);
        if (!function_b8fe9b52(local_client_num)) {
            continue;
        }
        localplayer = function_5c10bd79(local_client_num);
        team = localplayer.team;
        var_52fe6881 = function_aa0b7b86(local_client_num, "codcaster_xray");
        var_6f36c5bc = function_aa0b7b86(local_client_num, "codcaster_xray_target");
        var_349e9a55 = function_aa0b7b86(local_client_num, "codcaster_xray_advanced_target");
        needupdate = team != lastteam || var_52fe6881 != var_f4e066d || var_6f36c5bc != var_fb32b8ee || var_349e9a55 != var_adcf5c30;
        if (needupdate || forceupdate) {
            forceupdate = 0;
            lastteam = team;
            var_f4e066d = var_52fe6881;
            var_fb32b8ee = var_6f36c5bc;
            var_adcf5c30 = var_349e9a55;
            self function_1cc61419(local_client_num, [var_52fe6881, var_6f36c5bc, var_349e9a55]);
        }
    }
}

// Namespace codcaster/codcaster
// Params 2, eflags: 0x5 linked
// Checksum 0x5cacda4d, Offset: 0x870
// Size: 0x2e0
function private function_1cc61419(local_client_num, settings) {
    var_f2a410c9 = [];
    players = getplayers(local_client_num);
    foreach (player in players) {
        if (!isalive(player)) {
            continue;
        }
        var_f2a410c9[var_f2a410c9.size] = [player, #"hash_5982cfcbc143bf28", #"rob_codcaster_keyline"];
    }
    ents = getentarraybytype(local_client_num, 15);
    foreach (entity in ents) {
        if (!isdefined(entity.archetype)) {
            continue;
        }
        if (entity.archetype != #"mp_dog") {
            continue;
        }
        var_f2a410c9[var_f2a410c9.size] = [entity, #"hash_597d12ed59905d57", #"rob_codcaster_keyline"];
    }
    foreach (array in var_f2a410c9) {
        entity = array[0];
        robkey = array[1];
        rob = array[2];
        entity function_89106df8(local_client_num, robkey, rob, undefined, settings);
    }
}

// Namespace codcaster/codcaster
// Params 5, eflags: 0x1 linked
// Checksum 0x8ae18712, Offset: 0xb58
// Size: 0x3cc
function function_89106df8(local_client_num, robkey, rob, entity, settings) {
    if (!function_b8fe9b52(local_client_num)) {
        return;
    }
    team = self.team;
    if (isdefined(entity) && isdefined(entity.team)) {
        team = entity.team;
    }
    if (team == #"spectator") {
        return;
    }
    if (isdefined(settings)) {
        var_52fe6881 = settings[0];
        var_6f36c5bc = settings[1];
        var_349e9a55 = settings[2];
    }
    localplayer = function_5c10bd79(local_client_num);
    localplayerteam = localplayer.team;
    isplayer = isplayer(self);
    if (isdefined(settings) && (!var_52fe6881 || var_6f36c5bc == 1 && localplayerteam != #"allies" || var_6f36c5bc == 2 && localplayerteam != #"axis" || var_349e9a55 == 2 && isplayer || var_349e9a55 == 1 && !isplayer)) {
        self function_6d9b84d9(rob);
        return;
    }
    self renderoverridebundle::function_c8d97b8e(local_client_num, #"hash_7e51b929877df918", robkey);
    teamcolor = function_1f84bb65(local_client_num, team, 1);
    if (isdefined(entity) && entity function_21c0fa55() && !function_4af9029c(local_client_num)) {
        if (getdvarint(#"hash_e1667821061167", 0)) {
            teamcolor = function_1f84bb65(local_client_num, team, 2);
        }
        gradient = getdvarfloat(#"hash_595a2f8a298ab607", 1);
        teamcolor *= gradient;
    }
    self function_78233d29(rob, "", #"tintr", teamcolor[0]);
    self function_78233d29(rob, "", #"tintg", teamcolor[1]);
    self function_78233d29(rob, "", #"tintb", teamcolor[2]);
    self function_78233d29(rob, "", #"alpha", 1);
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x1 linked
// Checksum 0x21c93e2c, Offset: 0xf30
// Size: 0x54
function function_6d9b84d9(rob) {
    if (self flag::exists(#"hash_7e51b929877df918")) {
        self renderoverridebundle::stop_bundle(#"hash_7e51b929877df918", rob, 0);
    }
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x5 linked
// Checksum 0xc9298d7, Offset: 0xf90
// Size: 0x4a
function private function_7ed4edd3(playername) {
    if (!isdefined(playername)) {
        return false;
    }
    if (!isdefined(level.var_f5a7b6e9)) {
        return false;
    }
    if (!isdefined(level.var_f5a7b6e9[playername])) {
        return false;
    }
    return true;
}

// Namespace codcaster/codcaster
// Params 2, eflags: 0x1 linked
// Checksum 0x506d479a, Offset: 0xfe8
// Size: 0xf6
function function_995e01b6(localclientnum, player) {
    if (!isdefined(player)) {
        return;
    }
    rob = #"hash_58a6f58aee1cda35";
    var_1762ffa = util::spawn_model(localclientnum, #"hash_445c4aedaf62d3b9", player.origin, player.angles - (90, 0, 0));
    var_1762ffa playrenderoverridebundle(rob);
    var_1762ffa function_89106df8(localclientnum, #"hash_7a2c1fbc9f2b9754", rob, player);
    level.var_f5a7b6e9[player.name] = var_1762ffa;
    level.var_f5a7b6e9[player.name].player = player;
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x5 linked
// Checksum 0x79034264, Offset: 0x10e8
// Size: 0x44
function private function_425a51a2(var_5854d8e) {
    var_5854d8e stoprenderoverridebundle(#"hash_58a6f58aee1cda35");
    var_5854d8e delete();
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x5 linked
// Checksum 0xf686a97f, Offset: 0x1138
// Size: 0x6c
function private function_35248a94(playername) {
    if (!isdefined(level.var_f5a7b6e9) || !isdefined(level.var_f5a7b6e9[playername])) {
        return;
    }
    function_425a51a2(level.var_f5a7b6e9[playername]);
    level.var_f5a7b6e9[playername] = undefined;
}

// Namespace codcaster/codcaster
// Params 1, eflags: 0x5 linked
// Checksum 0x203a1ce2, Offset: 0x11b0
// Size: 0x46e
function private codcaster_monitor_player_pucks(localclientnum) {
    level notify("codcaster_monitor_player_pucks" + localclientnum);
    level endon("codcaster_monitor_player_pucks" + localclientnum);
    while (true) {
        waitframe(1);
        if (!function_b8fe9b52(localclientnum)) {
            continue;
        }
        var_15dfb7fc = function_4af9029c(localclientnum) && function_aa0b7b86(localclientnum, "codcaster_freecam_pucks");
        var_c36a1b34 = function_21dc7cf(localclientnum) && function_aa0b7b86(localclientnum, "codcaster_aerialcam_pucks");
        var_1aee36ff = var_c36a1b34 || var_15dfb7fc;
        foreach (player in getplayers(localclientnum)) {
            var_1db99579 = function_7ed4edd3(player.name);
            var_950b4dc5 = isdefined(player) && var_1aee36ff && isalive(player) && !function_3132f113(player);
            if (!var_15dfb7fc && var_1db99579 && player function_21c0fa55() && (!isdefined(level.var_4f107064) || level.var_4f107064 != player.name)) {
                function_35248a94(level.var_4f107064);
                function_35248a94(player.name);
                level.var_4f107064 = player.name;
            } else if (var_15dfb7fc && var_1db99579 && isdefined(level.var_4f107064)) {
                function_35248a94(level.var_4f107064);
                level.var_4f107064 = undefined;
            }
            if (var_1db99579 && !var_950b4dc5) {
                function_35248a94(player.name);
                continue;
            }
            if (!var_1db99579 && var_950b4dc5) {
                function_995e01b6(localclientnum, player);
            }
        }
        if (isdefined(level.var_f5a7b6e9)) {
            foreach (var_5854d8e in level.var_f5a7b6e9) {
                if (!isdefined(var_5854d8e)) {
                    continue;
                }
                linkedent = var_5854d8e.player;
                if (!isdefined(linkedent) || function_3132f113(linkedent) || !isalive(linkedent)) {
                    function_425a51a2(var_5854d8e);
                    continue;
                }
                angles = linkedent getplayerangles();
                var_5854d8e.angles = (-90, angles[1], 0);
                var_5854d8e.origin = linkedent.origin;
            }
        }
    }
}

// Namespace codcaster/codcaster
// Params 4, eflags: 0x0
// Checksum 0xea5e9373, Offset: 0x1628
// Size: 0x29c
function function_773f6e31(local_client_num, entity, var_d0ada253, state) {
    var_be6642de = (1, 1, 1);
    var_b76d5d98 = (0, 0, 0);
    if (state == 1) {
        var_be6642de = function_1f84bb65(local_client_num, #"allies", 1);
    } else if (state == 2) {
        var_be6642de = function_1f84bb65(local_client_num, #"axis", 1);
    } else if (state == 3) {
        var_be6642de = function_1f84bb65(local_client_num, #"allies", 1);
        var_b76d5d98 = function_1f84bb65(local_client_num, #"axis", 2);
    }
    if (isdefined(var_be6642de)) {
        entity function_78233d29(var_d0ada253, "", #"hash_6be0f6c7665077c7", var_be6642de[0]);
        entity function_78233d29(var_d0ada253, "", #"hash_6be0e1c766505418", var_be6642de[1]);
        entity function_78233d29(var_d0ada253, "", #"hash_6be0e6c766505c97", var_be6642de[2]);
        entity function_78233d29(var_d0ada253, "", #"hash_53eaa05730d4cddf", 1);
    }
    if (isdefined(var_b76d5d98)) {
        entity function_78233d29(var_d0ada253, "", #"hash_15e64a875216af23", var_b76d5d98[0]);
        entity function_78233d29(var_d0ada253, "", #"hash_15e63d875216990c", var_b76d5d98[1]);
        entity function_78233d29(var_d0ada253, "", #"hash_15e63a87521693f3", var_b76d5d98[2]);
        entity function_78233d29(var_d0ada253, "", #"hash_6ecae9ba3282976b", 1);
    }
}

