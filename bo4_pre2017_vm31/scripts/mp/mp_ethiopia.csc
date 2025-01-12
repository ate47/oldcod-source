#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/water_surface;
#using scripts/mp/mp_ethiopia_fx;
#using scripts/mp/mp_ethiopia_sound;
#using scripts/mp_common/load;
#using scripts/mp_common/util;
#using scripts/mp_common/waterfall;

#namespace mp_ethiopia;

// Namespace mp_ethiopia/Level_Init
// Params 1, eflags: 0x40
// Checksum 0xf2949e9f, Offset: 0x260
// Size: 0x154
function event_handler[Level_Init] main(eventstruct) {
    level.draftxcamname = "ui_cam_draft_common";
    mp_ethiopia_fx::main();
    mp_ethiopia_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_ethiopia";
    callback::on_localplayer_spawned(&waterfall::waterfalloverlay);
    callback::on_localplayer_spawned(&waterfall::waterfallmistoverlay);
    callback::on_localplayer_spawned(&waterfall::waterfallmistoverlayreset);
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
}

// Namespace mp_ethiopia/mp_ethiopia
// Params 2, eflags: 0x0
// Checksum 0x5bcfa458, Offset: 0x3c0
// Size: 0x7a
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case #"a":
        break;
    case #"b":
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case #"c":
        break;
    }
}

// Namespace mp_ethiopia/mp_ethiopia
// Params 2, eflags: 0x0
// Checksum 0x487803ed, Offset: 0x448
// Size: 0x7a
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case #"a":
        break;
    case #"b":
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case #"c":
        break;
    }
}

