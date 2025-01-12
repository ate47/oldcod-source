#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_hacienda_fx;
#using scripts\mp\mp_hacienda_sound;
#using scripts\mp_common\load;

#namespace mp_hacienda;

// Namespace mp_hacienda/level_init
// Params 1, eflags: 0x40
// Checksum 0x916dd0d2, Offset: 0x190
// Size: 0xf4
function event_handler[level_init] main(eventstruct) {
    level.draftxcam = #"ui_cam_draft_common";
    level.var_a49d0b27 = #"hash_12263e5d70551bf9";
    callback::on_localclient_connect(&on_localclient_connect);
    callback::on_gameplay_started(&on_gameplay_started);
    mp_hacienda_fx::main();
    mp_hacienda_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
}

// Namespace mp_hacienda/mp_hacienda
// Params 2, eflags: 0x0
// Checksum 0xde502f61, Offset: 0x290
// Size: 0xf2
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case #"a":
        if (team == #"neutral") {
            return "ui/fx_dom_marker_neutral_r90";
        } else {
            return "ui/fx_dom_marker_team_r90";
        }
        break;
    case #"b":
        if (team == #"neutral") {
            return "ui/fx_dom_marker_neutral_r250";
        } else {
            return "ui/fx_dom_marker_team_r250";
        }
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

// Namespace mp_hacienda/mp_hacienda
// Params 2, eflags: 0x0
// Checksum 0x22316674, Offset: 0x390
// Size: 0xf2
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case #"a":
        if (team == #"neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r90";
        } else {
            return "ui/fx_dom_cap_indicator_team_r90";
        }
        break;
    case #"b":
        if (team == #"neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r250";
        } else {
            return "ui/fx_dom_cap_indicator_team_r250";
        }
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

// Namespace mp_hacienda/mp_hacienda
// Params 1, eflags: 0x0
// Checksum 0x69ffde89, Offset: 0x490
// Size: 0x2c
function on_localclient_connect(localclientnum) {
    waitframe(1);
    setpbgactivebank(localclientnum, 8);
}

// Namespace mp_hacienda/mp_hacienda
// Params 1, eflags: 0x0
// Checksum 0x38496636, Offset: 0x4c8
// Size: 0x2c
function on_gameplay_started(localclientnum) {
    waitframe(1);
    setpbgactivebank(localclientnum, 1);
}

