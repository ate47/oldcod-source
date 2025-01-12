#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/filter_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_invulnerable;

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 0, eflags: 0x2
// Checksum 0xd64c88d1, Offset: 0x370
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_invulnerable", &__init__, undefined, undefined);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 0, eflags: 0x0
// Checksum 0x29f912cf, Offset: 0x3b0
// Size: 0x9c
function __init__() {
    clientfield::register("allplayers", "invulnerable_status", 1, 1, "int", &player_invulnerable_changed, 0, 0);
    duplicate_render::set_dr_filter_framebuffer_duplicate("invulnerable_pl", 40, "invulnerable_on", undefined, 1, "mc/mtl_ability_freeze", 0);
    callback::on_localplayer_spawned(&on_local_player_spawned);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 1, eflags: 0x0
// Checksum 0x9bb0247a, Offset: 0x458
// Size: 0x50
function on_local_player_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    newval = self clientfield::get("invulnerable_status");
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 7, eflags: 0x0
// Checksum 0xa24eda3f, Offset: 0x4b0
// Size: 0x54
function player_invulnerable_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self player_postfx(newval);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 1, eflags: 0x0
// Checksum 0x74f77dac, Offset: 0x510
// Size: 0x4c
function player_postfx(newval) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_frost_loop");
        return;
    }
    self thread postfx::stoppostfxbundle();
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 2, eflags: 0x0
// Checksum 0x7acb51f7, Offset: 0x568
// Size: 0xb4
function player_invulnerable_overlay(localclientnum, newval) {
    if (newval) {
        self filter::enable_filter_frost(localclientnum, 3);
        self filter::set_filter_frost_layer_two(localclientnum, 3, 0.75);
        util::lerp_generic(localclientnum, 500, &player_invulnerable_overlay_helper, newval);
        return;
    }
    self thread player_invulnerable_overlay_disable(localclientnum, newval);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 2, eflags: 0x0
// Checksum 0x8ec8025e, Offset: 0x628
// Size: 0x74
function player_invulnerable_overlay_disable(localclientnum, newval) {
    self endon(#"death");
    util::lerp_generic(localclientnum, 500, &player_invulnerable_overlay_helper, newval);
    wait 0.5;
    self filter::disable_filter_frost(localclientnum, 3);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 5, eflags: 0x0
// Checksum 0x4b66deb8, Offset: 0x6a8
// Size: 0xa4
function player_invulnerable_overlay_helper(currenttime, elapsedtime, localclientnum, duration, newval) {
    amount = elapsedtime / 500;
    if (!newval) {
        amount = 1 - amount;
    }
    self filter::set_filter_frost_layer_one(localclientnum, 3, amount * 1);
    self filter::set_filter_frost_reveal_direction(localclientnum, 3, amount);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 2, eflags: 0x0
// Checksum 0x165f571f, Offset: 0x758
// Size: 0x214
function player_invulnerable_shader(localclientnum, invulnerablestatusnew) {
    if (invulnerablestatusnew) {
        self duplicate_render::update_dr_flag(localclientnum, "invulnerable_on", 1);
        shieldexpansionncolor = "scriptVector3";
        shieldexpansionvaluex = 0.3;
        colorvector = get_shader_color();
        if (getdvarint("scr_invulnerable_dev")) {
            shieldexpansionvaluex = getdvarfloat("scr_invulnerable_expand", shieldexpansionvaluex);
            colorvector = (getdvarfloat("scr_invulnerable_colorR", colorvector[0]), getdvarfloat("scr_invulnerable_colorG", colorvector[1]), getdvarfloat("scr_invulnerable_colorB", colorvector[2]));
        }
        colortintvaluey = colorvector[0];
        colortintvaluez = colorvector[1];
        colortintvaluew = colorvector[2];
        damagestate = "scriptVector4";
        damagestatevalue = invulnerablestatusnew;
        self mapshaderconstant(localclientnum, 0, shieldexpansionncolor, shieldexpansionvaluex, colortintvaluey, colortintvaluez, colortintvaluew);
        self mapshaderconstant(localclientnum, 0, damagestate, damagestatevalue);
        return;
    }
    self duplicate_render::update_dr_flag(localclientnum, "invulnerable_on", 0);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 0, eflags: 0x0
// Checksum 0x397a363c, Offset: 0x978
// Size: 0x2e
function get_shader_color() {
    color = (0.32, 0.26, 0.84);
    return color;
}

