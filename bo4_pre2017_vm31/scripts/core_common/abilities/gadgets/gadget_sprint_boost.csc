#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/filter_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_sprint_boost;

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 0, eflags: 0x2
// Checksum 0xd3bd129a, Offset: 0x3f0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_sprint_boost", &__init__, undefined, undefined);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 0, eflags: 0x0
// Checksum 0x6b8efce8, Offset: 0x430
// Size: 0x18c
function __init__() {
    clientfield::register("scriptmover", "sprint_boost_aoe_fx", 1, 1, "int", &ability_util::set_aoe_fx, 0, 0);
    clientfield::register("allplayers", "sprint_boost", 1, 1, "int", &ability_util::update_applied_aoe_fx, 0, 0);
    clientfield::register("toplayer", "gadget_sprint_boost_on", 1, 1, "int", &has_sprint_boost_changed, 0, 1);
    /#
        level.debug_sprint_boost_traces = getdvarint("<dev string:x28>", 0);
    #/
    duplicate_render::set_dr_filter_offscreen("sprint_boost_pl", 50, "sprint_boost_player", undefined, 2, "mc/hud_outline_model_z_green");
    init_aoe_fx_info("sprint_boost_aoe_fx");
    init_applied_aoe_fx_info("sprint_boost");
    /#
        level thread debug_update_sprint_boost_radius("<dev string:x46>");
    #/
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0x6ae6b9ee, Offset: 0x5c8
// Size: 0xe8
function init_aoe_fx_info(aoe_name) {
    fx_info = ability_util::init_aoe_fx_info(aoe_name);
    if (!isdefined(fx_info)) {
        return;
    }
    gadget_sprint_boost = getweapon("gadget_sprint_boost");
    fx_info.explosion_radius = gadget_sprint_boost.sprintboostradius > 0 ? gadget_sprint_boost.sprintboostradius : 300;
    fx_info.center_offset_z = 30;
    fx_info.fx_per_frame = 2;
    fx_info.distortion_volume_fx = "player/fx8_plyr_ability_sprint_distort_volume";
    fx_info.distortion_volume_air_fx = "player/fx8_plyr_ability_sprint_distort_volume_air";
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0xb3d5be72, Offset: 0x6b8
// Size: 0x8c
function init_applied_aoe_fx_info(applied_aoe_name) {
    applied_fx_info = ability_util::init_applied_aoe_fx_info(applied_aoe_name);
    if (!isdefined(applied_fx_info)) {
        return;
    }
    applied_fx_info.fx_1p = "player/fx8_plyr_ability_sprint_boost_1p";
    applied_fx_info.fx_3p = "player/fx8_plyr_ability_sprint_boost_3p";
    applied_fx_info.tagfxset = "ability_hero_sprint_boost_player_impact";
    applied_fx_info.dr_set = "sprint_boost_player";
}

/#

    // Namespace gadget_sprint_boost/gadget_sprint_boost
    // Params 1, eflags: 0x0
    // Checksum 0xba4f3cc2, Offset: 0x750
    // Size: 0xd8
    function debug_update_sprint_boost_radius(aoe_name) {
        level endon(#"game_ended");
        wait 5;
        gadget_sprint_boost = getweapon("<dev string:x5a>");
        fx_info = ability_util::get_aoe_fx_info(aoe_name);
        while (isdefined(fx_info) && isstruct(fx_info)) {
            fx_info.explosion_radius = gadget_sprint_boost.sprintboostradius > 0 ? gadget_sprint_boost.sprintboostradius : 300;
            wait 1;
        }
    }

#/

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 7, eflags: 0x0
// Checksum 0x8c265b9d, Offset: 0x830
// Size: 0x98
function has_sprint_boost_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != oldval) {
        if (sessionmodeismultiplayergame()) {
            if (newval) {
                local_player = getlocalplayer(local_client_num);
                if (self == local_player) {
                }
            }
        }
    }
}

