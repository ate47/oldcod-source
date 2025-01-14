#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/abilities/gadgets/gadget_camo_render;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/filter_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_camo;

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x2
// Checksum 0xce2f3d93, Offset: 0x2f8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_camo", &__init__, undefined, undefined);
}

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x0
// Checksum 0x4759628d, Offset: 0x338
// Size: 0x4c
function __init__() {
    clientfield::register("allplayers", "camo_shader", 1, 3, "int", &ent_camo_material_callback, 0, 1);
}

// Namespace gadget_camo/gadget_camo
// Params 7, eflags: 0x0
// Checksum 0x466f9809, Offset: 0x390
// Size: 0x274
function ent_camo_material_callback(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval == newval && oldval == 0 && !bwastimejump) {
        return;
    }
    flags_changed = self duplicate_render::set_dr_flag_not_array("gadget_camo_friend", util::friend_not_foe(local_client_num, 1));
    flags_changed |= self duplicate_render::set_dr_flag_not_array("gadget_camo_flicker", newval == 2);
    flags_changed |= self duplicate_render::set_dr_flag_not_array("gadget_camo_break", newval == 3);
    flags_changed |= self duplicate_render::set_dr_flag_not_array("gadget_camo_reveal", newval != oldval);
    flags_changed |= self duplicate_render::set_dr_flag_not_array("gadget_camo_on", newval != 0);
    flags_changed |= self duplicate_render::set_dr_flag_not_array("hide_model", newval == 0);
    flags_changed |= bnewent;
    if (flags_changed) {
        self duplicate_render::update_dr_filters(local_client_num);
    }
    self notify(#"endtest");
    if (bwastimejump || newval && bnewent) {
        self thread gadget_camo_render::forceon(local_client_num);
    } else if (newval != oldval) {
        self thread gadget_camo_render::doreveal(local_client_num, newval != 0);
    }
    if (bwastimejump || newval && (newval && !oldval || bnewent)) {
        self gadgetpulseresetreveal();
    }
}

