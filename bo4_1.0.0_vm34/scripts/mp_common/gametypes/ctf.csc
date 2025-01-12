#using script_354f0cf6dd1c85c4;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;

#namespace ctf;

// Namespace ctf/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x34f23b49, Offset: 0xd0
// Size: 0x74
function event_handler[gametype_init] main(eventstruct) {
    callback::on_localclient_connect(&on_localclient_connect);
    clientfield::register("scriptmover", "ctf_flag_away", 1, 1, "int", &setctfaway, 0, 0);
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0x575a3650, Offset: 0x150
// Size: 0x17c
function on_localclient_connect(localclientnum) {
    var_1d2359d9 = [];
    while (!isdefined(var_1d2359d9[#"allies_base"])) {
        var_1d2359d9[#"allies_base"] = serverobjective_getobjective(localclientnum, "allies_base");
        var_1d2359d9[#"axis_base"] = serverobjective_getobjective(localclientnum, "axis_base");
        waitframe(1);
    }
    foreach (key, objective in var_1d2359d9) {
        level.var_1267dd47[key] = spawnstruct();
        level.var_1267dd47[key].objectiveid = objective;
        function_1a39440d(localclientnum, level.var_1267dd47[key]);
    }
    function_45876c81(localclientnum);
}

// Namespace ctf/ctf
// Params 2, eflags: 0x0
// Checksum 0x3e803f84, Offset: 0x2d8
// Size: 0xd6
function function_1a39440d(localclientnum, flag) {
    flag.origin = serverobjective_getobjectiveorigin(localclientnum, flag.objectiveid);
    flag_entity = serverobjective_getobjectiveentity(localclientnum, flag.objectiveid);
    flag.angles = (0, 0, 0);
    if (isdefined(flag_entity)) {
        flag.origin = flag_entity.origin;
        flag.angles = flag_entity.angles;
    }
    flag.team = serverobjective_getobjectiveteam(localclientnum, flag.objectiveid);
}

// Namespace ctf/ctf
// Params 3, eflags: 0x0
// Checksum 0x1a2d6645, Offset: 0x3b8
// Size: 0x124
function function_6364237a(localclientnum, flag, effects) {
    if (isdefined(flag.base_fx)) {
        stopfx(localclientnum, flag.base_fx);
    }
    up = anglestoup(flag.angles);
    forward = anglestoforward(flag.angles);
    flag.base_fx = playfx(localclientnum, effects[flag.team], flag.origin, up, forward);
    setfxteam(localclientnum, flag.base_fx, flag.team);
    thread watch_for_team_change(localclientnum);
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0xdcadef3a, Offset: 0x4e8
// Size: 0x110
function function_45876c81(localclientnum) {
    effects = [];
    if (shoutcaster::is_shoutcaster_using_team_identity(localclientnum)) {
        effects = shoutcaster::get_color_fx(localclientnum, level.var_d23a0410);
    } else {
        effects[#"allies"] = "ui/fx_ctf_flag_base_team";
        effects[#"axis"] = "ui/fx_ctf_flag_base_team";
    }
    foreach (flag in level.var_1267dd47) {
        thread function_6364237a(localclientnum, flag, effects);
    }
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0x7f79c91d, Offset: 0x600
// Size: 0x64
function watch_for_team_change(localclientnum) {
    level notify(#"end_team_change_watch");
    level endon(#"end_team_change_watch");
    level waittill(#"team_changed");
    thread function_45876c81(localclientnum);
}

// Namespace ctf/ctf
// Params 7, eflags: 0x0
// Checksum 0x259a8cd3, Offset: 0x670
// Size: 0x84
function setctfaway(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    team = self.team;
    setflagasaway(localclientnum, team, newval);
    self thread clearctfaway(localclientnum, team);
}

// Namespace ctf/ctf
// Params 2, eflags: 0x0
// Checksum 0x909ec78f, Offset: 0x700
// Size: 0x44
function clearctfaway(localclientnum, team) {
    self waittill(#"death");
    setflagasaway(localclientnum, team, 0);
}

