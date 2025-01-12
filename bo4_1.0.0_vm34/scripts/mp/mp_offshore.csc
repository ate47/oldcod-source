#using scripts\core_common\util_shared;
#using scripts\mp\mp_offshore_fx;
#using scripts\mp\mp_offshore_sound;
#using scripts\mp_common\load;

#namespace mp_offshore;

// Namespace mp_offshore/level_init
// Params 1, eflags: 0x40
// Checksum 0x93e8314d, Offset: 0x128
// Size: 0xce
function event_handler[level_init] main(eventstruct) {
    level.draftxcam = #"ui_cam_draft_common";
    level.var_a49d0b27 = #"hash_12263e5d70551bf9";
    mp_offshore_fx::main();
    mp_offshore_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_common";
}

// Namespace mp_offshore/mp_offshore
// Params 2, eflags: 0x0
// Checksum 0x3ce7ba25, Offset: 0x200
// Size: 0xc2
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case #"a":
        if (team == #"neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case #"b":
        break;
    case #"c":
        if (team == #"neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    }
}

// Namespace mp_offshore/mp_offshore
// Params 2, eflags: 0x0
// Checksum 0xb7f77d7c, Offset: 0x2d0
// Size: 0xc2
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case #"a":
        if (team == #"neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case #"b":
        break;
    case #"c":
        if (team == #"neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    }
}

// Namespace mp_offshore/mp_offshore
// Params 1, eflags: 0x0
// Checksum 0xe4a8929, Offset: 0x3a0
// Size: 0x2c
function on_localclient_connect(localclientnum) {
    waitframe(1);
    setpbgactivebank(localclientnum, 8);
}

// Namespace mp_offshore/mp_offshore
// Params 1, eflags: 0x0
// Checksum 0xc5fa7303, Offset: 0x3d8
// Size: 0x2c
function on_gameplay_started(localclientnum) {
    waitframe(1);
    setpbgactivebank(localclientnum, 1);
}

