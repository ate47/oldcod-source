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

#namespace gadget_cleanse;

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x2
// Checksum 0x48c68fde, Offset: 0x3c0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_cleanse", &__init__, undefined, undefined);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x0
// Checksum 0x958768f2, Offset: 0x400
// Size: 0x16c
function __init__() {
    clientfield::register("scriptmover", "cleanse_aoe_fx", 1, 1, "int", &ability_util::set_aoe_fx, 0, 0);
    clientfield::register("allplayers", "cleansed", 1, 1, "int", &ability_util::update_applied_aoe_fx, 0, 0);
    clientfield::register("toplayer", "gadget_cleanse_on", 1, 1, "int", &has_cleanse_changed, 0, 1);
    /#
        level.debug_cleanse_traces = getdvarint("<dev string:x28>", 0);
    #/
    duplicate_render::set_dr_filter_offscreen("cleanse_pl", 50, "cleanse_player", undefined, 2, "mc/hud_outline_model_z_green");
    init_aoe_fx_info("cleanse_aoe_fx");
    init_applied_aoe_fx_info("cleansed");
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0x50ed1f88, Offset: 0x578
// Size: 0xa0
function init_aoe_fx_info(aoe_name) {
    fx_info = ability_util::init_aoe_fx_info(aoe_name);
    if (!isdefined(fx_info)) {
        return;
    }
    fx_info.explosion_radius = 400;
    fx_info.center_offset_z = 30;
    fx_info.fx_per_frame = 2;
    fx_info.distortion_volume_fx = "player/fx8_plyr_ability_cleanse_distort_volume";
    fx_info.distortion_volume_air_fx = "player/fx8_plyr_ability_cleanse_distort_volume_air";
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0x27a5ceff, Offset: 0x620
// Size: 0x8c
function init_applied_aoe_fx_info(applied_aoe_name) {
    applied_fx_info = ability_util::init_applied_aoe_fx_info(applied_aoe_name);
    if (!isdefined(applied_fx_info)) {
        return;
    }
    applied_fx_info.fx_1p = "player/fx8_plyr_ability_cleanse_1p";
    applied_fx_info.fx_3p = "player/fx8_plyr_ability_cleanse_3p";
    applied_fx_info.tagfxset = "ability_hero_cleanse_player_impact";
    applied_fx_info.dr_set = "cleanse_player";
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 7, eflags: 0x0
// Checksum 0x59991f2b, Offset: 0x6b8
// Size: 0x98
function has_cleanse_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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

