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

#namespace namespace_61b1b96d;

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 0, eflags: 0x2
// Checksum 0xd64c88d1, Offset: 0x370
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_invulnerable", &__init__, undefined, undefined);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 0, eflags: 0x0
// Checksum 0x29f912cf, Offset: 0x3b0
// Size: 0x9c
function __init__() {
    clientfield::register("allplayers", "invulnerable_status", 1, 1, "int", &function_3d29a4b5, 0, 0);
    duplicate_render::set_dr_filter_framebuffer_duplicate("invulnerable_pl", 40, "invulnerable_on", undefined, 1, "mc/mtl_ability_freeze", 0);
    callback::on_localplayer_spawned(&on_local_player_spawned);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 1, eflags: 0x0
// Checksum 0x9bb0247a, Offset: 0x458
// Size: 0x50
function on_local_player_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    newval = self clientfield::get("invulnerable_status");
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 7, eflags: 0x0
// Checksum 0xa24eda3f, Offset: 0x4b0
// Size: 0x54
function function_3d29a4b5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_8bc490c9(newval);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 1, eflags: 0x0
// Checksum 0x74f77dac, Offset: 0x510
// Size: 0x4c
function function_8bc490c9(newval) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_frost_loop");
        return;
    }
    self thread postfx::stoppostfxbundle();
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 2, eflags: 0x0
// Checksum 0x7acb51f7, Offset: 0x568
// Size: 0xb4
function function_6d3afa8d(localclientnum, newval) {
    if (newval) {
        self filter::function_2c78ed36(localclientnum, 3);
        self filter::function_55d6d5f2(localclientnum, 3, 0.75);
        util::lerp_generic(localclientnum, 500, &function_c1e0e350, newval);
        return;
    }
    self thread function_da4fc4d4(localclientnum, newval);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 2, eflags: 0x0
// Checksum 0x8ec8025e, Offset: 0x628
// Size: 0x74
function function_da4fc4d4(localclientnum, newval) {
    self endon(#"death");
    util::lerp_generic(localclientnum, 500, &function_c1e0e350, newval);
    wait 0.5;
    self filter::function_acba895b(localclientnum, 3);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 5, eflags: 0x0
// Checksum 0x4b66deb8, Offset: 0x6a8
// Size: 0xa4
function function_c1e0e350(currenttime, elapsedtime, localclientnum, duration, newval) {
    amount = elapsedtime / 500;
    if (!newval) {
        amount = 1 - amount;
    }
    self filter::function_3ca70cf0(localclientnum, 3, amount * 1);
    self filter::function_c5f718d7(localclientnum, 3, amount);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 2, eflags: 0x0
// Checksum 0x165f571f, Offset: 0x758
// Size: 0x214
function function_3aca6c84(localclientnum, var_c7c877c) {
    if (var_c7c877c) {
        self duplicate_render::update_dr_flag(localclientnum, "invulnerable_on", 1);
        var_279cb0f6 = "scriptVector3";
        var_6936235c = 0.3;
        var_190c23ef = function_e8bd83f9();
        if (getdvarint("scr_invulnerable_dev")) {
            var_6936235c = getdvarfloat("scr_invulnerable_expand", var_6936235c);
            var_190c23ef = (getdvarfloat("scr_invulnerable_colorR", var_190c23ef[0]), getdvarfloat("scr_invulnerable_colorG", var_190c23ef[1]), getdvarfloat("scr_invulnerable_colorB", var_190c23ef[2]));
        }
        var_f37ae0c5 = var_190c23ef[0];
        var_197d5b2e = var_190c23ef[1];
        var_776218ab = var_190c23ef[2];
        damagestate = "scriptVector4";
        var_966e9c00 = var_c7c877c;
        self mapshaderconstant(localclientnum, 0, var_279cb0f6, var_6936235c, var_f37ae0c5, var_197d5b2e, var_776218ab);
        self mapshaderconstant(localclientnum, 0, damagestate, var_966e9c00);
        return;
    }
    self duplicate_render::update_dr_flag(localclientnum, "invulnerable_on", 0);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 0, eflags: 0x0
// Checksum 0x397a363c, Offset: 0x978
// Size: 0x2e
function function_e8bd83f9() {
    color = (0.32, 0.26, 0.84);
    return color;
}

