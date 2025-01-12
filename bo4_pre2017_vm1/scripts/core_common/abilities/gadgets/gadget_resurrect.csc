#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_resurrect;

// Namespace gadget_resurrect/gadget_resurrect
// Params 0, eflags: 0x2
// Checksum 0x2d05b237, Offset: 0x328
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_resurrect", &__init__, undefined, undefined);
}

// Namespace gadget_resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0xe1ecf61e, Offset: 0x368
// Size: 0x114
function __init__() {
    clientfield::register("allplayers", "resurrecting", 1, 1, "int", &function_5563c64b, 0, 1);
    clientfield::register("toplayer", "resurrect_state", 1, 2, "int", &function_294dfc4d, 0, 1);
    duplicate_render::set_dr_filter_offscreen("resurrecting", 99, "resurrecting", undefined, 2, "mc/hud_keyline_resurrect", 0);
    visionset_mgr::register_visionset_info("resurrect", 1, 16, undefined, "mp_ability_resurrection");
    visionset_mgr::register_visionset_info("resurrect_up", 1, 16, undefined, "mp_ability_wakeup");
}

// Namespace gadget_resurrect/gadget_resurrect
// Params 7, eflags: 0x0
// Checksum 0x3c3d9cd8, Offset: 0x488
// Size: 0x64
function function_5563c64b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self duplicate_render::update_dr_flag(localclientnum, "resurrecting", newval);
}

// Namespace gadget_resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0x32905c77, Offset: 0x4f8
// Size: 0x6c
function function_e4115bce(localclientnum) {
    self endon(#"death");
    self endon(#"hash_26d531a9");
    self thread postfx::playpostfxbundle("pstfx_resurrection_close");
    wait 0.5;
    self thread postfx::playpostfxbundle("pstfx_resurrection_pus");
}

// Namespace gadget_resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0xf8f20d77, Offset: 0x570
// Size: 0x44
function function_ec525b13(localclientnum) {
    self endon(#"death");
    self notify(#"hash_26d531a9");
    self thread postfx::playpostfxbundle("pstfx_resurrection_open");
}

// Namespace gadget_resurrect/gadget_resurrect
// Params 7, eflags: 0x0
// Checksum 0xe624bb13, Offset: 0x5c0
// Size: 0xa4
function function_294dfc4d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread function_e4115bce(localclientnum);
        return;
    }
    if (newval == 2) {
        self thread function_ec525b13(localclientnum);
        return;
    }
    self thread postfx::stoppostfxbundle();
}

