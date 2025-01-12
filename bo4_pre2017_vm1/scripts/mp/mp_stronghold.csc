#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp/mp_stronghold_fx;
#using scripts/mp/mp_stronghold_sound;
#using scripts/mp_common/load;
#using scripts/mp_common/util;

#namespace mp_stronghold;

// Namespace mp_stronghold/level_init
// Params 1, eflags: 0x40
// Checksum 0x18f83ef0, Offset: 0x1f0
// Size: 0xb0
function event_handler[level_init] main(eventstruct) {
    level.var_7c4ff662 = "ui_cam_draft_common";
    namespace_eade3e58::main();
    namespace_5f813f0f::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_stronghold";
}

// Namespace mp_stronghold/mp_stronghold
// Params 2, eflags: 0x0
// Checksum 0xa7299aa7, Offset: 0x2a8
// Size: 0x9e
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case #"a":
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case #"b":
        break;
    case #"c":
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    }
}

// Namespace mp_stronghold/mp_stronghold
// Params 2, eflags: 0x0
// Checksum 0xa5a25666, Offset: 0x350
// Size: 0x9e
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case #"a":
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case #"b":
        break;
    case #"c":
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    }
}

