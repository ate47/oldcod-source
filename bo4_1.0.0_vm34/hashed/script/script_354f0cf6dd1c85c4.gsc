#namespace shoutcaster;

// Namespace shoutcaster/shoutcaster
// Params 1, eflags: 0x0
// Checksum 0x232ae5db, Offset: 0xd8
// Size: 0x22
function is_shoutcaster(localclientnum) {
    return function_d224c0e6(localclientnum);
}

// Namespace shoutcaster/shoutcaster
// Params 1, eflags: 0x0
// Checksum 0x71f964d1, Offset: 0x108
// Size: 0x44
function is_shoutcaster_using_team_identity(localclientnum) {
    return is_shoutcaster(localclientnum) && getshoutcastersetting(localclientnum, "shoutcaster_fe_team_identity");
}

// Namespace shoutcaster/shoutcaster
// Params 2, eflags: 0x0
// Checksum 0x40390380, Offset: 0x158
// Size: 0x62
function get_team_color_id(localclientnum, team) {
    if (team == #"allies") {
        return getshoutcastersetting(localclientnum, "shoutcaster_fe_team1_color");
    }
    return getshoutcastersetting(localclientnum, "shoutcaster_fe_team2_color");
}

// Namespace shoutcaster/shoutcaster
// Params 3, eflags: 0x0
// Checksum 0x2fa74a4e, Offset: 0x1c8
// Size: 0x56
function get_team_color_fx(localclientnum, team, script_bundle) {
    color = get_team_color_id(localclientnum, team);
    return script_bundle.objects[color].fx_colorid;
}

// Namespace shoutcaster/shoutcaster
// Params 2, eflags: 0x0
// Checksum 0x4539c782, Offset: 0x228
// Size: 0x96
function get_color_fx(localclientnum, script_bundle) {
    effects = [];
    effects[#"allies"] = get_team_color_fx(localclientnum, #"allies", script_bundle);
    effects[#"axis"] = get_team_color_fx(localclientnum, #"axis", script_bundle);
    return effects;
}

// Namespace shoutcaster/shoutcaster
// Params 1, eflags: 0x0
// Checksum 0x134f715e, Offset: 0x2c8
// Size: 0xa4
function is_friendly(localclientnum) {
    localplayer = function_f97e7787(localclientnum);
    scorepanel_flipped = getshoutcastersetting(localclientnum, "shoutcaster_flip_scorepanel");
    if (!scorepanel_flipped) {
        friendly = self.team == #"allies";
    } else {
        friendly = self.team == #"axis";
    }
    return friendly;
}

