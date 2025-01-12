#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_militia_fx;
#using scripts\mp\mp_militia_sound;
#using scripts\mp_common\load;
#using scripts\mp_common\util;

#namespace mp_militia;

// Namespace mp_militia/level_init
// Params 1, eflags: 0x40
// Checksum 0x2381ddd0, Offset: 0x118
// Size: 0xbc
function event_handler[level_init] main(eventstruct) {
    level.draftxcam = #"ui_cam_draft_common";
    level.var_a49d0b27 = #"hash_12263e5d70551bf9";
    mp_militia_fx::main();
    mp_militia_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
}

// Namespace mp_militia/mp_militia
// Params 2, eflags: 0x0
// Checksum 0xa493aaa2, Offset: 0x1e0
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

// Namespace mp_militia/mp_militia
// Params 2, eflags: 0x0
// Checksum 0x157e1f01, Offset: 0x2b0
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

// Namespace mp_militia/mp_militia
// Params 1, eflags: 0x0
// Checksum 0x17c1031, Offset: 0x380
// Size: 0x2c
function on_localclient_connect(localclientnum) {
    waitframe(1);
    setpbgactivebank(localclientnum, 8);
}

// Namespace mp_militia/mp_militia
// Params 1, eflags: 0x0
// Checksum 0xa220bcfe, Offset: 0x3b8
// Size: 0x2c
function on_gameplay_started(localclientnum) {
    waitframe(1);
    setpbgactivebank(localclientnum, 1);
}

