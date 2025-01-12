#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\duplicaterender_mgr;
#using scripts\core_common\util_shared;

#namespace prop;

// Namespace prop/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xb2f1419, Offset: 0x168
// Size: 0x104
function event_handler[gametype_init] main(eventstruct) {
    clientfield::register("allplayers", "hideTeamPlayer", 1, 2, "int", &function_8e3b5ce2, 0, 0);
    clientfield::register("allplayers", "pingHighlight", 1, 1, "int", &highlightplayer, 0, 0);
    callback::on_localplayer_spawned(&onlocalplayerspawned);
    level.var_f12ccf06 = &hideprop;
    level.var_c301d021 = &highlightprop;
    thread function_576e8126();
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xc6366dba, Offset: 0x278
// Size: 0x64
function onlocalplayerspawned(localclientnum) {
    level notify("localPlayerSpectatingEnd" + localclientnum);
    if (function_9a47ed7f(localclientnum)) {
        level thread localplayerspectating(localclientnum);
    }
    level thread setuppropplayernames(localclientnum);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x7c64762e, Offset: 0x2e8
// Size: 0xb0
function localplayerspectating(localclientnum) {
    level notify("localPlayerSpectating" + localclientnum);
    level endon("localPlayerSpectatingEnd" + localclientnum);
    var_cfcb9b39 = playerbeingspectated(localclientnum);
    while (true) {
        player = playerbeingspectated(localclientnum);
        if (player != var_cfcb9b39) {
            level notify("localPlayerSpectating" + localclientnum);
        }
        wait 0.1;
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x76e4471e, Offset: 0x3a0
// Size: 0x5e
function function_576e8126() {
    while (true) {
        res = level waittill(#"team_changed");
        localclientnum = res.localclientnum;
        level notify("team_changed" + localclientnum);
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xb5b38acd, Offset: 0x408
// Size: 0x6c
function function_c5c7c3ef(player) {
    for (parent = self getlinkedent(); isdefined(parent); parent = parent getlinkedent()) {
        if (parent == player) {
            return true;
        }
    }
    return false;
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x1cc5c59b, Offset: 0x480
// Size: 0x112
function function_8ef128e8(localclientnum, player) {
    if (isdefined(player.prop)) {
        return player.prop;
    }
    ents = getentarray(localclientnum);
    foreach (ent in ents) {
        if (!ent isplayer() && isdefined(ent.owner) && ent.owner == player && ent function_c5c7c3ef(player)) {
            return ent;
        }
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xaac68988, Offset: 0x5a0
// Size: 0x280
function setuppropplayernames(localclientnum) {
    level notify("setupPropPlayerNames" + localclientnum);
    level endon("setupPropPlayerNames" + localclientnum);
    while (true) {
        localplayer = function_f97e7787(localclientnum);
        spectating = function_9a47ed7f(localclientnum);
        players = getplayers(localclientnum);
        foreach (player in players) {
            if ((player != localplayer || spectating) && player ishidden() && isdefined(player.team) && player.team == localplayer.team) {
                player.prop = function_8ef128e8(localclientnum, player);
                if (isdefined(player.prop)) {
                    if (!(isdefined(player.var_3a6ca2d4) && player.var_3a6ca2d4)) {
                        player.prop setdrawownername(1, spectating);
                        player.var_3a6ca2d4 = 1;
                    }
                }
                continue;
            }
            if (isdefined(player.var_3a6ca2d4) && player.var_3a6ca2d4) {
                player.prop = function_8ef128e8(localclientnum, player);
                if (isdefined(player.prop)) {
                    player.prop setdrawownername(0, spectating);
                }
                player.var_3a6ca2d4 = 0;
            }
        }
        wait 1;
    }
}

// Namespace prop/prop
// Params 7, eflags: 0x0
// Checksum 0x3b1f1cf0, Offset: 0x828
// Size: 0xc4
function highlightprop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        self notify(#"hash_3fe34dcd29fd6a0f");
        self duplicate_render::update_dr_flag(localclientnum, "prop_ally", 0);
        self duplicate_render::update_dr_flag(localclientnum, "prop_clone", 0);
        return;
    }
    self thread function_e622a96b(localclientnum, newval);
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0xd7e14634, Offset: 0x8f8
// Size: 0x20a
function function_e622a96b(localclientnum, var_2300871f) {
    self endon(#"entityshutdown");
    level endon(#"disconnect");
    self notify(#"hash_3fe34dcd29fd6a0f");
    self endon(#"hash_3fe34dcd29fd6a0f");
    while (true) {
        localplayer = function_f97e7787(localclientnum);
        spectating = function_9a47ed7f(localclientnum) && !function_1fe374eb(localclientnum);
        var_9d961790 = (!isdefined(self.owner) || self.owner != localplayer || spectating) && isdefined(self.team) && isdefined(localplayer.team) && self.team == localplayer.team;
        if (var_2300871f == 1) {
            self duplicate_render::update_dr_flag(localclientnum, "prop_ally", var_9d961790);
            self duplicate_render::update_dr_flag(localclientnum, "prop_clone", 0);
        } else {
            self duplicate_render::update_dr_flag(localclientnum, "prop_clone", var_9d961790);
            self duplicate_render::update_dr_flag(localclientnum, "prop_ally", 0);
        }
        self duplicate_render::update_dr_filters(localclientnum);
        level waittill("team_changed" + localclientnum, "localPlayerSpectating" + localclientnum);
    }
}

// Namespace prop/prop
// Params 7, eflags: 0x0
// Checksum 0x91c07b3d, Offset: 0xb10
// Size: 0xa4
function highlightplayer(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        self notify(#"hash_3fe34dcd29fd6a0f");
        self duplicate_render::update_dr_flag(localclientnum, "prop_clone", 0);
        return;
    }
    self thread function_b001ad83(localclientnum, newval);
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x99017f45, Offset: 0xbc0
// Size: 0x112
function function_b001ad83(localclientnum, var_2300871f) {
    self endon(#"entityshutdown");
    self notify(#"hash_3f606627f154954b");
    self endon(#"hash_3f606627f154954b");
    while (true) {
        localplayer = function_f97e7787(localclientnum);
        var_9d961790 = self != localplayer && isdefined(self.team) && isdefined(localplayer.team) && self.team == localplayer.team;
        self duplicate_render::update_dr_flag(localclientnum, "prop_clone", var_9d961790);
        level waittill("team_changed" + localclientnum, "localPlayerSpectating" + localclientnum);
    }
}

// Namespace prop/prop
// Params 7, eflags: 0x0
// Checksum 0xdbe755c9, Offset: 0xce0
// Size: 0x1d4
function hideprop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayer = function_f97e7787(localclientnum);
    var_9d961790 = newval && isdefined(self.owner) && self.owner == localplayer;
    if (var_9d961790) {
        self duplicate_render::update_dr_flag(localclientnum, "prop_look_through", 1);
        self duplicate_render::set_dr_flag("hide_model", 1);
        self duplicate_render::set_dr_flag("active_camo_reveal", 0);
        self duplicate_render::set_dr_flag("active_camo_on", 1);
        self duplicate_render::update_dr_filters(localclientnum);
        return;
    }
    self duplicate_render::update_dr_flag(localclientnum, "prop_look_through", 0);
    self duplicate_render::set_dr_flag("hide_model", 0);
    self duplicate_render::set_dr_flag("active_camo_reveal", 0);
    self duplicate_render::set_dr_flag("active_camo_on", 0);
    self duplicate_render::update_dr_filters(localclientnum);
}

// Namespace prop/prop
// Params 7, eflags: 0x0
// Checksum 0x109391d9, Offset: 0xec0
// Size: 0xac
function function_8e3b5ce2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        self notify(#"hash_65350e9157e1e7fd");
        if (!self function_4ff87091(localclientnum)) {
            self show();
        }
        return;
    }
    self function_4bf4d3e1(localclientnum, newval);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xe5b26146, Offset: 0xf78
// Size: 0x60
function function_4ff87091(localclientnum) {
    if (isdefined(self.prop)) {
        return true;
    }
    if (self isplayer()) {
        self.prop = function_8ef128e8(localclientnum, self);
        return isdefined(self.prop);
    }
    return false;
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0xdbc9d8e0, Offset: 0xfe0
// Size: 0x17e
function function_4bf4d3e1(localclientnum, teamint) {
    self endon(#"entityshutdown");
    self notify(#"hash_65350e9157e1e7fd");
    self endon(#"hash_65350e9157e1e7fd");
    assert(teamint == 1 || teamint == 2);
    team = "allies";
    if (teamint == 2) {
        team = "axis";
    }
    while (true) {
        localplayer = function_f97e7787(localclientnum);
        ishidden = isdefined(localplayer.team) && team == localplayer.team && !function_9a47ed7f(localclientnum);
        if (ishidden) {
            self hide();
        } else if (!self function_4ff87091(localclientnum)) {
            self show();
        }
        level waittill("team_changed" + localclientnum);
    }
}

