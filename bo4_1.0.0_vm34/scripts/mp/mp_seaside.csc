#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_seaside_fx;
#using scripts\mp\mp_seaside_sound;
#using scripts\mp_common\load;

#namespace mp_seaside;

// Namespace mp_seaside/level_init
// Params 1, eflags: 0x40
// Checksum 0x321d0111, Offset: 0x1a8
// Size: 0x106
function event_handler[level_init] main(eventstruct) {
    level.draftxcam = #"ui_cam_draft_common";
    level.var_a49d0b27 = #"hash_12263e5d70551bf9";
    callback::on_localclient_connect(&on_localclient_connect);
    callback::on_gameplay_started(&on_gameplay_started);
    mp_seaside_fx::main();
    mp_seaside_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_common";
}

// Namespace mp_seaside/mp_seaside
// Params 2, eflags: 0x0
// Checksum 0x79e4a54d, Offset: 0x2b8
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
            return "ui/fx_dom_marker_neutral_r90";
        } else {
            return "ui/fx_dom_marker_team_r90";
        }
        break;
    }
}

// Namespace mp_seaside/mp_seaside
// Params 2, eflags: 0x0
// Checksum 0x42980c72, Offset: 0x388
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
            return "ui/fx_dom_cap_indicator_neutral_r90";
        } else {
            return "ui/fx_dom_cap_indicator_team_r90";
        }
        break;
    }
}

// Namespace mp_seaside/mp_seaside
// Params 1, eflags: 0x0
// Checksum 0x4e0d7e07, Offset: 0x458
// Size: 0x2c
function on_localclient_connect(localclientnum) {
    waitframe(1);
    setpbgactivebank(localclientnum, 8);
}

// Namespace mp_seaside/mp_seaside
// Params 1, eflags: 0x0
// Checksum 0xac751ccc, Offset: 0x490
// Size: 0x2c
function on_gameplay_started(localclientnum) {
    waitframe(1);
    setpbgactivebank(localclientnum, 1);
}

