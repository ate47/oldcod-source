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

#namespace gadget_vision_pulse;

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x2
// Checksum 0x5383851b, Offset: 0x338
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_vision_pulse", &__init__, undefined, undefined);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0x1ed2b5d1, Offset: 0x378
// Size: 0x104
function __init__() {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    duplicate_render::set_dr_filter_offscreen("reveal_en", 50, "reveal_enemy", undefined, 2, "mc/hud_outline_model_z_red", 1);
    duplicate_render::set_dr_filter_offscreen("reveal_self", 50, "reveal_self", undefined, 2, "mc/hud_outline_model_z_red_alpha", 1);
    clientfield::register("toplayer", "vision_pulse_active", 1, 1, "int", &vision_pulse_changed, 0, 1);
    visionset_mgr::register_visionset_info("vision_pulse", 1, 12, undefined, "vision_puls_bw");
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x7e8afd71, Offset: 0x488
// Size: 0xac
function on_localplayer_spawned(localclientnum) {
    if (self == getlocalplayer(localclientnum)) {
        self.vision_pulse_owner = undefined;
        filter::function_1d7f017d(localclientnum);
        self gadgetpulseresetreveal();
        self set_reveal_self(localclientnum, 0);
        self set_reveal_enemy(localclientnum, 0);
        self thread function_d0c5071a(localclientnum);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x64e5a623, Offset: 0x540
// Size: 0x70
function function_d0c5071a(localclientnum) {
    self endon(#"death");
    while (true) {
        if (self isempjammed()) {
            self thread function_2902f0fc(localclientnum, 0);
            self notify(#"hash_3fca355b");
            break;
        }
        waitframe(1);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x16cac6d9, Offset: 0x5b8
// Size: 0x6c
function function_2902f0fc(localclientnum, duration) {
    self endon(#"hash_dc1b8822");
    self endon(#"death");
    self notify(#"hash_7cc7626e");
    self endon(#"hash_7cc7626e");
    wait duration;
    filter::function_3255f545(localclientnum, 3);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xae2ed6f6, Offset: 0x630
// Size: 0x74
function function_d42fa123(localclientnum) {
    self notify(#"hash_70cf2688");
    self endon(#"hash_70cf2688");
    self waittill("death", "emp_jammed_vp");
    filter::function_7fe7fc80(localclientnum, 3, 0, getvisionpulsemaxradius(localclientnum) + 1);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x3e429356, Offset: 0x6b0
// Size: 0x1cc
function function_2cf010aa(localclientnum) {
    self endon(#"death");
    self notify(#"hash_dc1b8822");
    self thread function_d42fa123(localclientnum);
    filter::function_c4f1d452(localclientnum, 3);
    filter::function_7fe7fc80(localclientnum, 3, 1, 1);
    filter::function_7fe7fc80(localclientnum, 3, 2, 0.08);
    filter::function_7fe7fc80(localclientnum, 3, 3, 0);
    filter::function_7fe7fc80(localclientnum, 3, 4, 1);
    filter::function_7fe7fc80(localclientnum, 3, 0, 0);
    filter::function_7fe7fc80(localclientnum, 3, 11, 1);
    waitframe(1);
    pulsemaxradius = 0;
    util::lerp_generic(localclientnum, 2000, &do_vision_world_pulse_lerp_helper);
    filter::function_7fe7fc80(localclientnum, 3, 1, 0);
    self thread function_2902f0fc(localclientnum, 4);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 4, eflags: 0x0
// Checksum 0xf6f6665d, Offset: 0x888
// Size: 0x13c
function do_vision_world_pulse_lerp_helper(currenttime, elapsedtime, localclientnum, duration) {
    if (elapsedtime < 200) {
        irisamount = elapsedtime / 200;
    } else if (elapsedtime < 2000 * 0.6) {
        irisamount = 1 - elapsedtime / 1000;
    } else {
        irisamount = 0;
    }
    pulseradius = getvisionpulseradius(localclientnum);
    pulsemaxradius = getvisionpulsemaxradius(localclientnum);
    filter::function_7fe7fc80(localclientnum, 3, 0, pulseradius);
    filter::function_7fe7fc80(localclientnum, 3, 3, irisamount);
    filter::function_7fe7fc80(localclientnum, 3, 11, pulsemaxradius);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xc2b7d682, Offset: 0x9d0
// Size: 0x4e
function vision_pulse_owner_valid(owner) {
    if (isdefined(owner) && owner isplayer() && isalive(owner)) {
        return true;
    }
    return false;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xa1c04561, Offset: 0xa28
// Size: 0xd6
function watch_vision_pulse_owner_death(localclientnum) {
    self endon(#"death");
    self endon(#"finished_local_pulse");
    self notify(#"watch_vision_pulse_owner_death");
    self endon(#"watch_vision_pulse_owner_death");
    owner = self.vision_pulse_owner;
    if (vision_pulse_owner_valid(owner)) {
        owner waittill("death");
    }
    self notify(#"vision_pulse_owner_death");
    filter::function_7fe7fc80(localclientnum, 3, 7, 0);
    self thread function_2902f0fc(localclientnum, 4);
    self.vision_pulse_owner = undefined;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xef1e2e70, Offset: 0xb08
// Size: 0x28a
function do_vision_local_pulse(localclientnum) {
    self endon(#"death");
    self endon(#"vision_pulse_owner_death");
    self notify(#"hash_dc1b8822");
    self notify(#"startlocalpulse");
    self endon(#"startlocalpulse");
    self thread watch_vision_pulse_owner_death(localclientnum);
    origin = getrevealpulseorigin(localclientnum);
    filter::function_c4f1d452(localclientnum, 3);
    filter::function_7fe7fc80(localclientnum, 3, 5, 0.4);
    filter::function_7fe7fc80(localclientnum, 3, 6, 0.0001);
    filter::function_7fe7fc80(localclientnum, 3, 8, origin[0]);
    filter::function_7fe7fc80(localclientnum, 3, 9, origin[1]);
    filter::function_7fe7fc80(localclientnum, 3, 7, 1);
    starttime = getservertime(localclientnum);
    while (getservertime(localclientnum) - starttime < 4000) {
        if (getservertime(localclientnum) - starttime < 2000) {
            pulseradius = (getservertime(localclientnum) - starttime) / 2000 * 2000;
        }
        filter::function_7fe7fc80(localclientnum, 3, 10, pulseradius);
        waitframe(1);
    }
    filter::function_7fe7fc80(localclientnum, 3, 7, 0);
    self thread function_2902f0fc(localclientnum, 4);
    self notify(#"finished_local_pulse");
    self.vision_pulse_owner = undefined;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 7, eflags: 0x0
// Checksum 0x13196b8e, Offset: 0xda0
// Size: 0xa4
function vision_pulse_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self == getlocalplayer(localclientnum)) {
            if (bnewent || isdemoplaying() && oldval == newval) {
                return;
            }
            self thread function_2cf010aa(localclientnum);
        }
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xae0ad913, Offset: 0xe50
// Size: 0x14c
function function_4ebdb91d(localclientnum) {
    self endon(#"death");
    self notify(#"hash_9564271c");
    self endon(#"hash_9564271c");
    starttime = getservertime(localclientnum);
    currtime = starttime;
    self mapshaderconstant(localclientnum, 0, "scriptVector7", 0, 0, 0, 0);
    while (currtime - starttime < 4000) {
        if (currtime - starttime > 3500) {
            value = float((currtime - starttime - 3500) / 500);
            self mapshaderconstant(localclientnum, 0, "scriptVector7", value, 0, 0, 0);
        }
        waitframe(1);
        currtime = getservertime(localclientnum);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x399ab982, Offset: 0xfa8
// Size: 0x5c
function set_reveal_enemy(localclientnum, on_off) {
    if (on_off) {
        self thread function_4ebdb91d(localclientnum);
    }
    self duplicate_render::update_dr_flag(localclientnum, "reveal_enemy", on_off);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x33066aa0, Offset: 0x1010
// Size: 0x84
function set_reveal_self(localclientnum, on_off) {
    if (on_off && self == getlocalplayer(localclientnum)) {
        self thread do_vision_local_pulse(localclientnum);
        return;
    }
    if (!on_off) {
        filter::function_7fe7fc80(localclientnum, 3, 7, 0);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x42f4ace1, Offset: 0x10a0
// Size: 0x184
function gadget_visionpulse_reveal(localclientnum, breveal) {
    self notify(#"gadget_visionpulse_changed");
    player = getlocalplayer(localclientnum);
    if (!isdefined(self.visionpulserevealself) && player == self) {
        self.visionpulserevealself = 0;
    }
    if (!isdefined(self.visionpulsereveal)) {
        self.visionpulsereveal = 0;
    }
    if (player == self) {
        owner = self gadgetpulsegetowner(localclientnum);
        if (isdefined(self.vision_pulse_owner) && isdefined(owner) && (self.visionpulserevealself != breveal || self.vision_pulse_owner != owner)) {
            self.vision_pulse_owner = owner;
            self.visionpulserevealself = breveal;
            self set_reveal_self(localclientnum, breveal);
        }
        return;
    }
    if (self.visionpulsereveal != breveal) {
        self.visionpulsereveal = breveal;
        self set_reveal_enemy(localclientnum, breveal);
    }
}

