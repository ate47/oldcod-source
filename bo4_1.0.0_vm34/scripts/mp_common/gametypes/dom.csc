#using scripts\core_common\callbacks_shared;

#namespace dom;

// Namespace dom/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x1a08b380, Offset: 0x100
// Size: 0x74
function event_handler[gametype_init] main(eventstruct) {
    callback::on_localclient_connect(&on_localclient_connect);
    if (getgametypesetting(#"silentplant") != 0) {
        setsoundcontext("bomb_plant", "silent");
    }
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0x190649d4, Offset: 0x180
// Size: 0x160
function on_localclient_connect(localclientnum) {
    self.domflags = [];
    while (!isdefined(level.domflags[#"a"])) {
        self.domflags[#"a"] = serverobjective_getobjective(localclientnum, "dom_a");
        self.domflags[#"b"] = serverobjective_getobjective(localclientnum, "dom_b");
        self.domflags[#"c"] = serverobjective_getobjective(localclientnum, "dom_c");
        waitframe(1);
    }
    foreach (key, flag_objective in self.domflags) {
        self thread monitor_flag_fx(localclientnum, flag_objective, key);
    }
}

// Namespace dom/dom
// Params 3, eflags: 0x0
// Checksum 0xa38502d8, Offset: 0x2e8
// Size: 0x2a6
function monitor_flag_fx(localclientnum, flag_objective, flag_name) {
    if (!isdefined(flag_objective)) {
        return;
    }
    flag = spawnstruct();
    flag.name = flag_name;
    flag.objectiveid = flag_objective;
    flag.origin = serverobjective_getobjectiveorigin(localclientnum, flag_objective);
    flag.angles = (0, 0, 0);
    flag_entity = serverobjective_getobjectiveentity(localclientnum, flag_objective);
    if (isdefined(flag_entity)) {
        flag.origin = flag_entity.origin;
        flag.angles = flag_entity.angles;
    }
    fx_name = get_base_fx(flag, #"neutral");
    play_base_fx(localclientnum, flag, fx_name, #"neutral");
    flag.last_progress = 0;
    while (true) {
        team = serverobjective_getobjectiveteam(localclientnum, flag_objective);
        if (team != flag.last_team) {
            flag update_base_fx(localclientnum, flag, team);
        }
        progress = serverobjective_getobjectiveprogress(localclientnum, flag_objective) > 0;
        if (progress != flag.last_progress) {
            var_90290bd4 = team;
            if (var_90290bd4 == #"neutral") {
                var_736d06a4 = serverobjective_getobjectivegamemodeflags(localclientnum, flag_objective);
                if (var_736d06a4 == 2) {
                    var_90290bd4 = #"allies";
                } else if (var_736d06a4 == 1) {
                    var_90290bd4 = #"axis";
                }
            }
            flag update_cap_fx(localclientnum, flag, var_90290bd4, progress);
        }
        waitframe(1);
    }
}

// Namespace dom/dom
// Params 4, eflags: 0x0
// Checksum 0x1111f127, Offset: 0x598
// Size: 0x10a
function play_base_fx(localclientnum, flag, fx_name, team) {
    if (isdefined(flag.base_fx)) {
        stopfx(localclientnum, flag.base_fx);
    }
    up = anglestoup(flag.angles);
    forward = anglestoforward(flag.angles);
    flag.base_fx = playfx(localclientnum, fx_name, flag.origin, up, forward);
    setfxteam(localclientnum, flag.base_fx, team);
    flag.last_team = team;
}

// Namespace dom/dom
// Params 3, eflags: 0x0
// Checksum 0xe7a5c785, Offset: 0x6b0
// Size: 0xfa
function update_base_fx(localclientnum, flag, team) {
    fx_name = get_base_fx(flag, team);
    if (team == #"neutral") {
        play_base_fx(localclientnum, flag, fx_name, team);
        return;
    }
    if (flag.last_team == #"neutral") {
        play_base_fx(localclientnum, flag, fx_name, team);
        return;
    }
    setfxteam(localclientnum, flag.base_fx, team);
    flag.last_team = team;
}

// Namespace dom/dom
// Params 4, eflags: 0x0
// Checksum 0x8dab7979, Offset: 0x7b8
// Size: 0xfc
function play_cap_fx(localclientnum, flag, fx_name, team) {
    if (isdefined(flag.cap_fx)) {
        killfx(localclientnum, flag.cap_fx);
    }
    up = anglestoup(flag.angles);
    forward = anglestoforward(flag.angles);
    flag.cap_fx = playfx(localclientnum, fx_name, flag.origin, up, forward);
    setfxteam(localclientnum, flag.cap_fx, team);
}

// Namespace dom/dom
// Params 4, eflags: 0x0
// Checksum 0xfe3811c6, Offset: 0x8c0
// Size: 0xba
function update_cap_fx(localclientnum, flag, team, progress) {
    if (progress == 0) {
        if (isdefined(flag.cap_fx)) {
            killfx(localclientnum, flag.cap_fx);
        }
        flag.last_progress = progress;
        return;
    }
    fx_name = get_cap_fx(flag, team);
    play_cap_fx(localclientnum, flag, fx_name, team);
    flag.last_progress = progress;
}

// Namespace dom/dom
// Params 2, eflags: 0x0
// Checksum 0x6cd76c39, Offset: 0x988
// Size: 0x7c
function get_base_fx(flag, team) {
    if (isdefined(level.domflagbasefxoverride)) {
        fx = [[ level.domflagbasefxoverride ]](flag, team);
        if (isdefined(fx)) {
            return fx;
        }
    }
    if (team == #"neutral") {
        return "ui/fx_dom_marker_neutral";
    }
    return "ui/fx_dom_marker_team";
}

// Namespace dom/dom
// Params 2, eflags: 0x0
// Checksum 0x56157f4, Offset: 0xa10
// Size: 0x7c
function get_cap_fx(flag, team) {
    if (isdefined(level.domflagcapfxoverride)) {
        fx = [[ level.domflagcapfxoverride ]](flag, team);
        if (isdefined(fx)) {
            return fx;
        }
    }
    if (team == #"neutral") {
        return "ui/fx_dom_cap_indicator_neutral";
    }
    return "ui/fx_dom_cap_indicator_team";
}

