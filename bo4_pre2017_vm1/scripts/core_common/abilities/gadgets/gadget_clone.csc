#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/abilities/gadgets/gadget_clone_render;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/filter_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_clone;

// Namespace gadget_clone/gadget_clone
// Params 0, eflags: 0x2
// Checksum 0xedbddea7, Offset: 0x320
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_clone", &__init__, undefined, undefined);
}

// Namespace gadget_clone/gadget_clone
// Params 0, eflags: 0x0
// Checksum 0x51f6c6d3, Offset: 0x360
// Size: 0xdc
function __init__() {
    clientfield::register("actor", "clone_activated", 1, 1, "int", &clone_activated, 0, 1);
    clientfield::register("actor", "clone_damaged", 1, 1, "int", &clone_damaged, 0, 0);
    clientfield::register("allplayers", "clone_activated", 1, 1, "int", &function_a000e134, 0, 0);
}

// Namespace gadget_clone/gadget_clone
// Params 3, eflags: 0x0
// Checksum 0xbcb753ee, Offset: 0x448
// Size: 0x84
function function_87218e55(localclientnum, enabled, entity) {
    if (entity isfriendly(localclientnum)) {
        self duplicate_render::update_dr_flag(localclientnum, "clone_ally_on", enabled);
        return;
    }
    self duplicate_render::update_dr_flag(localclientnum, "clone_enemy_on", enabled);
}

// Namespace gadget_clone/gadget_clone
// Params 7, eflags: 0x0
// Checksum 0x65b416ac, Offset: 0x4d8
// Size: 0xc4
function clone_activated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self._isclone = 1;
        self function_87218e55(localclientnum, 1, self getowner(localclientnum));
        if (isdefined(level._monitor_tracker)) {
            self thread [[ level._monitor_tracker ]](localclientnum);
        }
        self thread namespace_1e7514ce::function_9bad5680(localclientnum);
    }
}

// Namespace gadget_clone/gadget_clone
// Params 7, eflags: 0x0
// Checksum 0xc43df940, Offset: 0x5a8
// Size: 0xdc
function function_a000e134(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self function_87218e55(localclientnum, 1, self);
        self thread namespace_1e7514ce::function_9bad5680(localclientnum);
        return;
    }
    self function_87218e55(localclientnum, 0, self);
    self notify(#"hash_b8916aca");
    self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, 0, 0, 1);
}

// Namespace gadget_clone/gadget_clone
// Params 1, eflags: 0x0
// Checksum 0xe4571a8e, Offset: 0x690
// Size: 0x8c
function function_46c43b11(localclientnum) {
    self endon(#"death");
    self notify(#"start_flicker");
    self endon(#"start_flicker");
    self duplicate_render::update_dr_flag(localclientnum, "clone_damage", 1);
    self waittill("stop_flicker");
    self duplicate_render::update_dr_flag(localclientnum, "clone_damage", 0);
}

// Namespace gadget_clone/gadget_clone
// Params 0, eflags: 0x0
// Checksum 0x5e2e4408, Offset: 0x728
// Size: 0x3e
function function_94521dca() {
    self endon(#"death");
    self endon(#"start_flicker");
    self endon(#"stop_flicker");
    wait 0.2;
    self notify(#"stop_flicker");
}

// Namespace gadget_clone/gadget_clone
// Params 7, eflags: 0x0
// Checksum 0x5dcdffc6, Offset: 0x770
// Size: 0x74
function clone_damaged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_46c43b11(localclientnum);
        return;
    }
    self thread function_94521dca();
}

