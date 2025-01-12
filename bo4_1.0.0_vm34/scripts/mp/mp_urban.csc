#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_urban_fx;
#using scripts\mp\mp_urban_sound;
#using scripts\mp_common\load;

#namespace mp_urban;

// Namespace mp_urban/level_init
// Params 1, eflags: 0x40
// Checksum 0x248c382b, Offset: 0x130
// Size: 0x106
function event_handler[level_init] main(eventstruct) {
    level.draftxcam = #"ui_cam_draft_common";
    level.var_a49d0b27 = #"hash_12263e5d70551bf9";
    callback::on_localclient_connect(&on_localclient_connect);
    callback::on_gameplay_started(&on_gameplay_started);
    mp_urban_fx::main();
    mp_urban_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_common";
}

// Namespace mp_urban/mp_urban
// Params 2, eflags: 0x0
// Checksum 0x960a52e9, Offset: 0x240
// Size: 0xf2
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
        if (team == #"neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
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

// Namespace mp_urban/mp_urban
// Params 2, eflags: 0x0
// Checksum 0xd4e68da7, Offset: 0x340
// Size: 0xf2
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
        if (team == #"neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
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

// Namespace mp_urban/mp_urban
// Params 1, eflags: 0x0
// Checksum 0x3e5f58b3, Offset: 0x440
// Size: 0x2c
function on_localclient_connect(localclientnum) {
    waitframe(1);
    setpbgactivebank(localclientnum, 8);
}

// Namespace mp_urban/mp_urban
// Params 1, eflags: 0x0
// Checksum 0x88cb87e1, Offset: 0x478
// Size: 0x2c
function on_gameplay_started(localclientnum) {
    waitframe(1);
    setpbgactivebank(localclientnum, 1);
}

