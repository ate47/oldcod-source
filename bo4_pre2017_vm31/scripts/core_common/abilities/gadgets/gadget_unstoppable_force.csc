#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_unstoppable_force;

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 0, eflags: 0x2
// Checksum 0x146df75f, Offset: 0x438
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_unstoppable_force", &__init__, undefined, undefined);
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 0, eflags: 0x0
// Checksum 0x8f19282f, Offset: 0x478
// Size: 0x6c
function __init__() {
    callback::on_localclient_shutdown(&on_localplayer_shutdown);
    clientfield::register("toplayer", "unstoppableforce_state", 1, 1, "int", &player_unstoppableforce_handler, 0, 1);
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0xdb6de6a1, Offset: 0x4f0
// Size: 0x24
function on_localplayer_shutdown(localclientnum) {
    stop_boost_camera_fx(localclientnum);
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 7, eflags: 0x0
// Checksum 0x80bd81d3, Offset: 0x520
// Size: 0x20a
function player_unstoppableforce_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.localplayers[localclientnum]) && (!self islocalplayer() || isspectating(localclientnum, 0) || self getentitynumber() != level.localplayers[localclientnum] getentitynumber())) {
        return;
    }
    if (newval != oldval && newval) {
        enablespeedblur(localclientnum, getdvarfloat("scr_unstoppableforce_amount", 0.15), getdvarfloat("scr_unstoppableforce_inner_radius", 0.6), getdvarfloat("scr_unstoppableforce_outer_radius", 1), getdvarint("scr_unstoppableforce_velShouldScale", 1), getdvarint("scr_unstoppableforce_velScale", 220));
        self thread activation_flash(localclientnum);
        self boost_fx_on_velocity(localclientnum);
        return;
    }
    if (newval != oldval && !newval) {
        self stop_boost_camera_fx(localclientnum);
        disablespeedblur(localclientnum);
        self notify(#"end_unstoppableforce_boost_fx");
    }
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0xdf11275c, Offset: 0x738
// Size: 0x10c
function activation_flash(localclientnum) {
    self waittilltimeout(getdvarfloat("scr_unstoppableforce_activation_delay", 0.35), "unstoppableforce_arm_cross_end");
    lui::screen_fade(getdvarfloat("scr_unstoppableforce_flash_fade_in_time", 0.075), getdvarfloat("scr_unstoppableforce_flash_alpha", 0.6), 0, "white");
    wait getdvarfloat("scr_unstoppableforce_flash_fade_in_time", 0.075);
    lui::screen_fade(getdvarfloat("scr_unstoppableforce_flash_fade_out_time", 0.9), 0, getdvarfloat("scr_unstoppableforce_flash_alpha", 0.6), "white");
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0x3cd01ef, Offset: 0x850
// Size: 0x3c
function enable_boost_camera_fx(localclientnum) {
    self.firstperson_fx_unstoppableforce = playfxoncamera(localclientnum, "player/fx_plyr_ability_screen_blur_overdrive", (0, 0, 0), (1, 0, 0), (0, 0, 1));
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0xc259775, Offset: 0x898
// Size: 0x46
function stop_boost_camera_fx(localclientnum) {
    if (isdefined(self.firstperson_fx_unstoppableforce)) {
        stopfx(localclientnum, self.firstperson_fx_unstoppableforce);
        self.firstperson_fx_unstoppableforce = undefined;
    }
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0xca9250db, Offset: 0x8e8
// Size: 0x52
function boost_fx_interrupt_handler(localclientnum) {
    self endon(#"end_unstoppableforce_boost_fx");
    self waittill("disable_cybercom", "death");
    stop_boost_camera_fx(localclientnum);
    self notify(#"end_unstoppableforce_boost_fx");
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0x30445c85, Offset: 0x948
// Size: 0x19e
function boost_fx_on_velocity(localclientnum) {
    self endon(#"disable_cybercom");
    self endon(#"death");
    self endon(#"end_unstoppableforce_boost_fx");
    self endon(#"disconnect");
    self thread boost_fx_interrupt_handler(localclientnum);
    while (isdefined(self)) {
        v_player_velocity = self getvelocity();
        v_player_forward = anglestoforward(self.angles);
        n_dot = vectordot(vectornormalize(v_player_velocity), v_player_forward);
        n_speed = length(v_player_velocity);
        if (n_speed >= getdvarint("scr_unstoppableforce_boost_speed_tol", 320) && n_dot > 0.8) {
            if (!isdefined(self.firstperson_fx_unstoppableforce)) {
                self enable_boost_camera_fx(localclientnum);
            }
        } else if (isdefined(self.firstperson_fx_unstoppableforce)) {
            self stop_boost_camera_fx(localclientnum);
        }
        waitframe(1);
    }
}

