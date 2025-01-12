#using script_354f0cf6dd1c85c4;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\duplicaterender_mgr;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace ball;

// Namespace ball/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x5f17b9bc, Offset: 0x220
// Size: 0x262
function event_handler[gametype_init] main(eventstruct) {
    clientfield::register("allplayers", "ballcarrier", 1, 1, "int", &function_5354f213, 0, 1);
    clientfield::register("allplayers", "passoption", 1, 1, "int", &function_8dc589c8, 0, 0);
    clientfield::register("world", "ball_away", 1, 1, "int", &function_c27acbbf, 0, 1);
    clientfield::register("world", "ball_score_allies", 1, 1, "int", &function_fe891abf, 0, 1);
    clientfield::register("world", "ball_score_axis", 1, 1, "int", &function_7d1a6e7e, 0, 1);
    callback::on_localclient_connect(&on_localclient_connect);
    callback::on_spawned(&on_player_spawned);
    if (!getdvarint(#"tu11_programaticallycoloredgamefx", 0)) {
        level.effect_scriptbundles = [];
        level.effect_scriptbundles[#"goal"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal");
        level.effect_scriptbundles[#"hash_141412a5485af87"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal_score");
    }
}

// Namespace ball/ball
// Params 1, eflags: 0x0
// Checksum 0xed700e34, Offset: 0x490
// Size: 0x17c
function on_localclient_connect(localclientnum) {
    var_1d2359d9 = [];
    while (!isdefined(var_1d2359d9[#"allies"])) {
        var_1d2359d9[#"allies"] = serverobjective_getobjective(localclientnum, "ball_goal_allies");
        var_1d2359d9[#"axis"] = serverobjective_getobjective(localclientnum, "ball_goal_axis");
        waitframe(1);
    }
    foreach (key, objective in var_1d2359d9) {
        level.goals[key] = spawnstruct();
        level.goals[key].objectiveid = objective;
        function_b22de10a(localclientnum, level.goals[key]);
    }
    function_45876c81(localclientnum);
}

// Namespace ball/ball
// Params 1, eflags: 0x0
// Checksum 0x34af7ef3, Offset: 0x618
// Size: 0xd0
function on_player_spawned(localclientnum) {
    players = getplayers(localclientnum);
    foreach (player in players) {
        if (player util::isenemyplayer(self)) {
            player duplicate_render::update_dr_flag(localclientnum, "ballcarrier", 0);
        }
    }
}

// Namespace ball/ball
// Params 2, eflags: 0x0
// Checksum 0xe8dfb580, Offset: 0x6f0
// Size: 0xae
function function_b22de10a(localclientnum, goal) {
    goal.origin = serverobjective_getobjectiveorigin(localclientnum, goal.objectiveid);
    var_ecb500c6 = serverobjective_getobjectiveentity(localclientnum, goal.objectiveid);
    if (isdefined(var_ecb500c6)) {
        goal.origin = var_ecb500c6.origin;
    }
    goal.team = serverobjective_getobjectiveteam(localclientnum, goal.objectiveid);
}

// Namespace ball/ball
// Params 3, eflags: 0x0
// Checksum 0x5e0e8657, Offset: 0x7a8
// Size: 0xb4
function function_2182aedf(localclientnum, goal, effects) {
    if (isdefined(goal.base_fx)) {
        stopfx(localclientnum, goal.base_fx);
    }
    goal.base_fx = playfx(localclientnum, effects[goal.team], goal.origin);
    setfxteam(localclientnum, goal.base_fx, goal.team);
}

// Namespace ball/ball
// Params 1, eflags: 0x0
// Checksum 0xe198cf78, Offset: 0x868
// Size: 0x1bc
function function_45876c81(localclientnum) {
    effects = [];
    if (shoutcaster::is_shoutcaster_using_team_identity(localclientnum)) {
        if (getdvarint(#"tu11_programaticallycoloredgamefx", 0)) {
            effects[#"allies"] = "ui/fx_uplink_goal_marker";
            effects[#"axis"] = "ui/fx_uplink_goal_marker";
        } else {
            effects = shoutcaster::get_color_fx(localclientnum, level.effect_scriptbundles[#"goal"]);
        }
    } else {
        effects[#"allies"] = "ui/fx_uplink_goal_marker";
        effects[#"axis"] = "ui/fx_uplink_goal_marker";
    }
    foreach (goal in level.goals) {
        thread function_2182aedf(localclientnum, goal, effects);
        thread resetondemojump(localclientnum, goal, effects);
    }
    thread watch_for_team_change(localclientnum);
}

// Namespace ball/ball
// Params 2, eflags: 0x0
// Checksum 0xb2720f9a, Offset: 0xa30
// Size: 0x174
function function_ea2fff95(localclientnum, goal) {
    effects = [];
    if (shoutcaster::is_shoutcaster_using_team_identity(localclientnum)) {
        if (getdvarint(#"tu11_programaticallycoloredgamefx", 0)) {
            effects[#"allies"] = "ui/fx_uplink_goal_marker_flash";
            effects[#"axis"] = "ui/fx_uplink_goal_marker_flash";
        } else {
            effects = shoutcaster::get_color_fx(localclientnum, level.effect_scriptbundles[#"hash_141412a5485af87"]);
        }
    } else {
        effects[#"allies"] = "ui/fx_uplink_goal_marker_flash";
        effects[#"axis"] = "ui/fx_uplink_goal_marker_flash";
    }
    fx_handle = playfx(localclientnum, effects[goal.team], goal.origin);
    setfxteam(localclientnum, fx_handle, goal.team);
}

// Namespace ball/ball
// Params 6, eflags: 0x0
// Checksum 0xb92fdf15, Offset: 0xbb0
// Size: 0x7c
function function_85e74fc9(localclientnum, team, oldval, newval, binitialsnap, bwastimejump) {
    if (newval != oldval && !binitialsnap && !bwastimejump) {
        function_ea2fff95(localclientnum, level.goals[team]);
    }
}

// Namespace ball/ball
// Params 7, eflags: 0x0
// Checksum 0x6339e9cc, Offset: 0xc38
// Size: 0x6c
function function_fe891abf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_85e74fc9(localclientnum, #"allies", oldval, newval, binitialsnap, bwastimejump);
}

// Namespace ball/ball
// Params 7, eflags: 0x0
// Checksum 0xd46fbedc, Offset: 0xcb0
// Size: 0x6c
function function_7d1a6e7e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_85e74fc9(localclientnum, #"axis", oldval, newval, binitialsnap, bwastimejump);
}

// Namespace ball/ball
// Params 7, eflags: 0x0
// Checksum 0x66ebb181, Offset: 0xd28
// Size: 0x174
function function_5354f213(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self function_60dbc438()) {
        if (newval) {
            self.var_25281d17 = 1;
        } else {
            self.var_25281d17 = 0;
            setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.passOption"), 0);
        }
    } else if (self function_55a8b32b()) {
        self function_235fe967(localclientnum, newval);
    } else {
        self function_235fe967(localclientnum, 0);
    }
    if (isdefined(level.var_300a2507) && level.var_300a2507 != self) {
        return;
    }
    level notify(#"watch_for_death");
    if (newval == 1) {
        self thread watch_for_death(localclientnum);
    }
}

// Namespace ball/ball
// Params 1, eflags: 0x0
// Checksum 0x789b4217, Offset: 0xea8
// Size: 0x214
function function_b95d5759(localclientnum) {
    level.var_300a2507 = self;
    if (shoutcaster::is_shoutcaster(localclientnum)) {
        friendly = self shoutcaster::is_friendly(localclientnum);
    } else {
        friendly = self function_55a8b32b();
    }
    if (isdefined(self.name)) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), self.name);
    } else {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), "");
    }
    if (isdefined(friendly)) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), friendly);
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), !friendly);
        return;
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), 0);
}

// Namespace ball/ball
// Params 1, eflags: 0x0
// Checksum 0x439f04c9, Offset: 0x10c8
// Size: 0xdc
function clear_hud(localclientnum) {
    level.var_300a2507 = undefined;
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), #"hash_5c376bae65a55609");
}

// Namespace ball/ball
// Params 1, eflags: 0x0
// Checksum 0x66b12446, Offset: 0x11b0
// Size: 0x3a
function watch_for_death(localclientnum) {
    level endon(#"watch_for_death");
    self waittill(#"death");
}

// Namespace ball/ball
// Params 7, eflags: 0x0
// Checksum 0x1be7d974, Offset: 0x11f8
// Size: 0xf4
function function_8dc589c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self function_60dbc438() && self function_55a8b32b()) {
        localplayer = function_f97e7787(localclientnum);
        if (isdefined(localplayer.var_25281d17) && localplayer.var_25281d17) {
            setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.passOption"), newval);
        }
    }
}

// Namespace ball/ball
// Params 7, eflags: 0x0
// Checksum 0x4371f520, Offset: 0x12f8
// Size: 0x7c
function function_c27acbbf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballAway"), newval);
}

// Namespace ball/ball
// Params 2, eflags: 0x0
// Checksum 0x6b0f465a, Offset: 0x1380
// Size: 0x34
function function_235fe967(localclientnum, on_off) {
    self duplicate_render::update_dr_flag(localclientnum, "ballcarrier", on_off);
}

// Namespace ball/ball
// Params 2, eflags: 0x0
// Checksum 0xc6a42c20, Offset: 0x13c0
// Size: 0x34
function function_115bb67e(localclientnum, on_off) {
    self duplicate_render::update_dr_flag(localclientnum, "passoption", on_off);
}

// Namespace ball/ball
// Params 3, eflags: 0x0
// Checksum 0x1317f578, Offset: 0x1400
// Size: 0x50
function resetondemojump(localclientnum, goal, effects) {
    for (;;) {
        level waittill("demo_jump" + localclientnum);
        function_2182aedf(localclientnum, goal, effects);
    }
}

// Namespace ball/ball
// Params 1, eflags: 0x0
// Checksum 0x44d99527, Offset: 0x1458
// Size: 0x64
function watch_for_team_change(localclientnum) {
    level notify(#"end_team_change_watch");
    level endon(#"end_team_change_watch");
    level waittill(#"team_changed");
    thread function_45876c81(localclientnum);
}

