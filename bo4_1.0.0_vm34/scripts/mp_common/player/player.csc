#using script_354f0cf6dd1c85c4;
#using script_4daa124bc391e7ed;
#using scripts\abilities\gadgets\gadget_vision_pulse;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace player;

// Namespace player/player
// Params 0, eflags: 0x2
// Checksum 0x9e1b5bbf, Offset: 0x120
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"player_mp", &__init__, undefined, "renderoverridebundle");
}

// Namespace player/player
// Params 0, eflags: 0x0
// Checksum 0xec2e3de2, Offset: 0x168
// Size: 0x194
function __init__() {
    callback::on_spawned(&on_player_spawned);
    callback::on_player_corpse(&on_player_corpse);
    callback::function_948e38c4(&function_948e38c4);
    callback::on_localclient_connect(&function_e523b8c1);
    level.var_38ea2f7f = 1;
    renderoverridebundle::function_9f4eff5e(#"hash_27554b8df2b9e92b", sessionmodeiscampaigngame() ? #"hash_1cbf6d26721c59a7" : #"hash_1c90592671f4c6e9", &function_c84d46f);
    renderoverridebundle::function_9f4eff5e(#"hash_757cb7d3be0afb26", sessionmodeiscampaigngame() ? #"hash_1cbf6d26721c59a7" : #"hash_7a8f0ff83c7ba2be", &function_86336718);
    renderoverridebundle::function_9f4eff5e(#"hash_7e4097eb89d1343b", #"hash_71fbf1094f57b910", &function_bf19e70f);
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0x972f9ce5, Offset: 0x308
// Size: 0x66
function function_d93dc37(playername) {
    if (!isdefined(playername)) {
        return false;
    }
    if (!isdefined(level.shoutcasterpucks)) {
        return false;
    }
    if (!isdefined(level.shoutcasterpucks[playername])) {
        return false;
    }
    if (level.shoutcasterpucks[playername] == -1) {
        return false;
    }
    return true;
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0xc360adb0, Offset: 0x378
// Size: 0x50
function function_3e45c919(playername) {
    if (!isdefined(level.var_c017b469)) {
        return false;
    }
    if (level.var_c017b469 != playername) {
        return false;
    }
    if (!isdefined(level.var_2a04154a)) {
        return false;
    }
    return true;
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0xcb1d51ea, Offset: 0x3d0
// Size: 0x9e
function function_c8834f8f(localclientnum, player) {
    if (player.team == #"allies") {
        var_6456580 = #"hash_e7985dec7c3faa9";
    } else {
        var_6456580 = #"hash_40193ed2b55dd6b6";
    }
    level.shoutcasterpucks[player.name] = util::playfxontag(localclientnum, var_6456580, self, "tag_origin");
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0x703aa660, Offset: 0x478
// Size: 0xa6
function function_69303971(localclientnum, player) {
    level.var_c017b469 = player.name;
    if (player.team == #"allies") {
        var_e2a94611 = #"hash_1e1361dd9519bc55";
    } else {
        var_e2a94611 = #"hash_7a180b53914e467a";
    }
    level.var_2a04154a = util::playfxontag(localclientnum, var_e2a94611, self, "tag_origin");
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0x6d8dc5af, Offset: 0x528
// Size: 0x52
function function_d045da1(localclientnum, playername) {
    stopfx(localclientnum, level.shoutcasterpucks[playername]);
    level.shoutcasterpucks[playername] = -1;
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0xd362fb57, Offset: 0x588
// Size: 0x46
function function_4b4596a7(localclientnum) {
    if (isdefined(level.var_2a04154a)) {
        stopfx(localclientnum, level.var_2a04154a);
        level.var_2a04154a = undefined;
    }
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0x6d50ec03, Offset: 0x5d8
// Size: 0x278
function shoutcaster_monitor_player_pucks(localclientnum) {
    while (true) {
        waitframe(1);
        if (!function_d224c0e6(localclientnum)) {
            continue;
        }
        foreach (player in getplayers(localclientnum)) {
            if (isdefined(player) && !function_f68f5e32(player)) {
                if (isalive(player)) {
                    if (function_a7feace9(localclientnum)) {
                        if (!function_d93dc37(player.name)) {
                            player function_c8834f8f(localclientnum, player);
                        }
                        if (player function_60dbc438() && !function_3e45c919(player.name)) {
                            function_4b4596a7(localclientnum);
                            player function_69303971(localclientnum, player);
                        }
                    } else if (function_d93dc37(player.name)) {
                        function_d045da1(localclientnum, player.name);
                    }
                    continue;
                }
                if (function_d93dc37(player.name)) {
                    function_d045da1(localclientnum, player.name);
                }
                if (function_3e45c919(player.name)) {
                    function_4b4596a7(localclientnum);
                }
            }
        }
        if (!function_a7feace9(localclientnum)) {
            function_4b4596a7(localclientnum);
        }
    }
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0xd0a5aad2, Offset: 0x858
// Size: 0x36
function function_86336718(local_client_num, bundle) {
    if (function_d224c0e6(local_client_num)) {
        return false;
    }
    return true;
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0x9dd7dee5, Offset: 0x898
// Size: 0x94
function function_1ff37160(localclientnum, var_993f778e) {
    if (!var_993f778e && function_d224c0e6(localclientnum)) {
        self function_456477e6(localclientnum);
        return;
    }
    if (self function_60dbc438()) {
        self function_40425065(localclientnum);
        return;
    }
    self function_89303eee(localclientnum);
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0xbbe49f43, Offset: 0x938
// Size: 0xd4
function on_player_spawned(localclientnum) {
    if (function_d224c0e6(localclientnum)) {
        if (self postfx::function_7348f3a5("pstfx_radiation_dot")) {
            self postfx::exitpostfxbundle("pstfx_radiation_dot");
        }
        if (self postfx::function_7348f3a5("pstfx_burn_loop")) {
            self postfx::exitpostfxbundle("pstfx_burn_loop");
        }
    }
    function_1ff37160(localclientnum, 0);
    self namespace_104bbcd1::function_1773d7da();
}

// Namespace player/player
// Params 1, eflags: 0x4
// Checksum 0x52eb7141, Offset: 0xa18
// Size: 0xd8
function private function_a84765ca(localclientnum) {
    if (sessionmodeiswarzonegame()) {
        foreach (player in getplayers(localclientnum)) {
            if (player.team == self.team && !player function_60dbc438()) {
                player function_89303eee(localclientnum);
            }
        }
    }
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0xa2b9164, Offset: 0xaf8
// Size: 0x4c
function function_948e38c4(localclientnum) {
    if (self function_40efd9db()) {
        level notify(#"hash_21eba590bb904092");
        self function_a84765ca(localclientnum);
    }
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0xb781515e, Offset: 0xb50
// Size: 0xec
function on_player_corpse(localclientnum, params) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self function_1ff37160(localclientnum, 1);
    self renderoverridebundle::stop_bundle(#"friendly", sessionmodeiscampaigngame() ? #"hash_1cbf6d26721c59a7" : #"hash_1c90592671f4c6e9");
    if (function_d224c0e6(localclientnum)) {
        self stoprenderoverridebundle(#"hash_71fbf1094f57b910");
    }
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0x1da630ee, Offset: 0xc48
// Size: 0x44
function function_40425065(local_client_num) {
    self renderoverridebundle::function_15e70783(local_client_num, #"friendly", #"hash_757cb7d3be0afb26");
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0xd33e0c67, Offset: 0xc98
// Size: 0x1d0
function shoutcaster_monitor_xray_change(local_client_num) {
    firsttime = 1;
    localplayer = function_f97e7787(local_client_num);
    lastteam = localplayer.team;
    var_e7da0600 = getshoutcastersetting(local_client_num, "shoutcaster_qs_xray");
    var_a82fdf38 = getshoutcastersetting(local_client_num, "shoutcaster_xray");
    while (true) {
        waitframe(1);
        if (!function_d224c0e6(local_client_num)) {
            continue;
        }
        localplayer = function_f97e7787(local_client_num);
        team = localplayer.team;
        var_a85ef8e0 = getshoutcastersetting(local_client_num, "shoutcaster_qs_xray");
        var_10648998 = getshoutcastersetting(local_client_num, "shoutcaster_xray");
        if (firsttime) {
            firsttime = 0;
        } else if (team == lastteam && var_a85ef8e0 == var_e7da0600 && var_10648998 == var_a82fdf38) {
            continue;
        }
        lastteam = team;
        var_e7da0600 = var_a85ef8e0;
        var_a82fdf38 = var_10648998;
        self function_13f62c8b(local_client_num, team, var_a85ef8e0, var_10648998);
    }
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0x71ad777f, Offset: 0xe70
// Size: 0x3c
function function_e523b8c1(local_client_num) {
    thread shoutcaster_monitor_xray_change(local_client_num);
    thread shoutcaster_monitor_player_pucks(local_client_num);
}

// Namespace player/player
// Params 4, eflags: 0x0
// Checksum 0xa170e4fc, Offset: 0xeb8
// Size: 0x1b8
function function_13f62c8b(local_client_num, localplayerteam, var_a85ef8e0, var_10648998) {
    players = getplayers(local_client_num);
    foreach (player in players) {
        if (isalive(player)) {
            if (!var_a85ef8e0 || var_10648998 == 0) {
                if (player flag::exists(#"shoutcaster_flag")) {
                    player renderoverridebundle::stop_bundle(#"shoutcaster_flag", #"hash_71fbf1094f57b910");
                }
                continue;
            }
            if (var_10648998 == 1 && localplayerteam == player.team) {
                if (player flag::exists(#"shoutcaster_flag")) {
                    player renderoverridebundle::stop_bundle(#"shoutcaster_flag", #"hash_71fbf1094f57b910");
                }
                continue;
            }
            player function_456477e6(local_client_num);
        }
    }
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0x7de1a45a, Offset: 0x1078
// Size: 0x29c
function function_456477e6(local_client_num) {
    var_a85ef8e0 = getshoutcastersetting(local_client_num, "shoutcaster_qs_xray");
    var_10648998 = getshoutcastersetting(local_client_num, "shoutcaster_xray");
    localplayer = function_f97e7787(local_client_num);
    localplayerteam = localplayer.team;
    if (!var_a85ef8e0 || var_10648998 == 0) {
        return;
    }
    if (var_10648998 == 1 && localplayerteam == self.team) {
        return;
    }
    self renderoverridebundle::function_15e70783(local_client_num, #"shoutcaster_flag", #"hash_7e4097eb89d1343b");
    teamcolor = self.team == #"allies" ? (0.13, 0.87, 0.94) : (0.98, 0.18, 0.1);
    if (shoutcaster::is_shoutcaster_using_team_identity(local_client_num)) {
        var_37476d85 = shoutcaster::get_team_color_id(local_client_num, self.team);
        teamcolor = function_ecabccbd(var_37476d85);
    }
    self function_98a01e4c(#"hash_71fbf1094f57b910", #"tintr", teamcolor[0]);
    self function_98a01e4c(#"hash_71fbf1094f57b910", #"tintg", teamcolor[1]);
    self function_98a01e4c(#"hash_71fbf1094f57b910", #"tintb", teamcolor[2]);
    self function_98a01e4c(#"hash_71fbf1094f57b910", #"alpha", 1);
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0x97a8f6fb, Offset: 0x1320
// Size: 0x44
function function_89303eee(local_client_num) {
    self renderoverridebundle::function_15e70783(local_client_num, #"friendly", #"hash_27554b8df2b9e92b");
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0xb016b54, Offset: 0x1370
// Size: 0x46
function function_bf19e70f(local_client_num, bundle) {
    if (level.gameended) {
        return false;
    }
    if (!function_d224c0e6(local_client_num)) {
        return false;
    }
    return true;
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0x8584f9a4, Offset: 0x13c0
// Size: 0x7a
function function_c84d46f(local_client_num, bundle) {
    if (!function_de528029(local_client_num, #"specialty_friendliesthroughwalls")) {
        return 0;
    }
    if (level.gameended) {
        return 0;
    }
    if (gadget_vision_pulse::is_active(local_client_num)) {
        return 0;
    }
    return renderoverridebundle::function_c84d46f(local_client_num, bundle);
}

