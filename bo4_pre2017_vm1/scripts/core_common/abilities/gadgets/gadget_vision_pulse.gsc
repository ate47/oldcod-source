#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/abilities/gadgets/gadget_camo;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_vision_pulse;

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x2
// Checksum 0x2c57c275, Offset: 0x370
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_vision_pulse", &__init__, undefined, undefined);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0x7a54cf18, Offset: 0x3b0
// Size: 0x19c
function __init__() {
    ability_player::register_gadget_activation_callbacks(6, &gadget_vision_pulse_on, &gadget_vision_pulse_off);
    ability_player::register_gadget_possession_callbacks(6, &function_97e4169e, &function_bfa5bd70);
    ability_player::register_gadget_flicker_callbacks(6, &gadget_vision_pulse_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(6, &gadget_vision_pulse_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(6, &gadget_vision_pulse_is_flickering);
    callback::on_connect(&function_e8ada75);
    callback::on_spawned(&gadget_vision_pulse_on_spawn);
    clientfield::register("toplayer", "vision_pulse_active", 1, 1, "int");
    if (!isdefined(level.vsmgr_prio_visionset_visionpulse)) {
        level.vsmgr_prio_visionset_visionpulse = 61;
    }
    visionset_mgr::register_info("visionset", "vision_pulse", 1, level.vsmgr_prio_visionset_visionpulse, 12, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x1111e104, Offset: 0x558
// Size: 0x2a
function gadget_vision_pulse_is_inuse(slot) {
    return self flagsys::get("gadget_vision_pulse_on");
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xe6de54f3, Offset: 0x590
// Size: 0x22
function gadget_vision_pulse_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xf26562d6, Offset: 0x5c0
// Size: 0x34
function gadget_vision_pulse_on_flicker(slot, weapon) {
    self thread gadget_vision_pulse_flicker(slot, weapon);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xa36290c1, Offset: 0x600
// Size: 0x14
function function_97e4169e(slot, weapon) {
    
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x8a40fee, Offset: 0x620
// Size: 0x14
function function_bfa5bd70(slot, weapon) {
    
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x640
// Size: 0x4
function function_e8ada75() {
    
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0x710bd6e0, Offset: 0x650
// Size: 0x5c
function gadget_vision_pulse_on_spawn() {
    self.visionpulseactivatetime = 0;
    self.visionpulsearray = [];
    self.visionpulseorigin = undefined;
    self.visionpulseoriginarray = [];
    if (isdefined(self._pulse_ent)) {
        self._pulse_ent delete();
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0xc6d7c54d, Offset: 0x6b8
// Size: 0x1a
function gadget_vision_pulse_ramp_hold_func() {
    self waittilltimeout(5, "ramp_out_visionset");
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0xe5a07fa9, Offset: 0x6e0
// Size: 0x84
function gadget_vision_pulse_watch_death() {
    self notify(#"vision_pulse_watch_death");
    self endon(#"vision_pulse_watch_death");
    self endon(#"disconnect");
    self waittill("death");
    visionset_mgr::deactivate("visionset", "vision_pulse", self);
    if (isdefined(self._pulse_ent)) {
        self._pulse_ent delete();
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0x1d6a9121, Offset: 0x770
// Size: 0xbc
function gadget_vision_pulse_watch_emp() {
    self notify(#"vision_pulse_watch_emp");
    self endon(#"vision_pulse_watch_emp");
    self endon(#"disconnect");
    while (true) {
        if (self isempjammed()) {
            visionset_mgr::deactivate("visionset", "vision_pulse", self);
            self notify(#"emp_vp_jammed");
            break;
        }
        waitframe(1);
    }
    if (isdefined(self._pulse_ent)) {
        self._pulse_ent delete();
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x28343492, Offset: 0x838
// Size: 0xf4
function gadget_vision_pulse_on(slot, weapon) {
    if (isdefined(self._pulse_ent)) {
        return;
    }
    self flagsys::set("gadget_vision_pulse_on");
    self thread gadget_vision_pulse_start(slot, weapon);
    visionset_mgr::activate("visionset", "vision_pulse", self, 0.25, &gadget_vision_pulse_ramp_hold_func, 0.75);
    self thread gadget_vision_pulse_watch_death();
    self thread gadget_vision_pulse_watch_emp();
    self clientfield::set_to_player("vision_pulse_active", 1);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x44e70c96, Offset: 0x938
// Size: 0x54
function gadget_vision_pulse_off(slot, weapon) {
    self flagsys::clear("gadget_vision_pulse_on");
    self clientfield::set_to_player("vision_pulse_active", 0);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xd5396af3, Offset: 0x998
// Size: 0x3ec
function gadget_vision_pulse_start(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"emp_vp_jammed");
    wait 0.1;
    if (isdefined(self._pulse_ent)) {
        return;
    }
    self._pulse_ent = spawn("script_model", self.origin);
    self._pulse_ent setmodel("tag_origin");
    self gadgetsetentity(slot, self._pulse_ent);
    self gadgetsetactivatetime(slot, gettime());
    self set_gadget_vision_pulse_status("Activated");
    self.visionpulseactivatetime = gettime();
    enemyarray = level.players;
    gadget = getweapon("gadget_vision_pulse");
    visionpulsearray = arraysort(enemyarray, self._pulse_ent.origin, 1, undefined, gadget.gadget_pulse_max_range);
    self.visionpulseorigin = self._pulse_ent.origin;
    self.visionpulsearray = [];
    self.visionpulseoriginarray = [];
    spottedenemy = 0;
    self.visionpulsespottedenemy = [];
    self.visionpulsespottedenemytime = gettime();
    for (i = 0; i < visionpulsearray.size; i++) {
        if (visionpulsearray[i] gadget_camo::function_6b246a0f() == 0) {
            self.visionpulsearray[self.visionpulsearray.size] = visionpulsearray[i];
            self.visionpulseoriginarray[self.visionpulseoriginarray.size] = visionpulsearray[i].origin;
            if (isalive(visionpulsearray[i]) && visionpulsearray[i].team != self.team) {
                spottedenemy = 1;
                self.visionpulsespottedenemy[self.visionpulsespottedenemy.size] = visionpulsearray[i];
                visionpulsearray[i].lastvisionpulsedby = self;
                visionpulsearray[i].lastvisionpulsedtime = self.visionpulsespottedenemytime;
            }
        }
    }
    self wait_until_is_done(slot, self._gadgets_player[slot].gadget_pulse_duration);
    if (spottedenemy && isdefined(level.playgadgetsuccess)) {
        self [[ level.playgadgetsuccess ]](weapon);
    } else {
        self playsoundtoplayer("gdt_vision_pulse_no_hits", self);
        self notify(#"ramp_out_visionset");
    }
    self set_gadget_vision_pulse_status("Done");
    self._pulse_ent delete();
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x2a0fb39f, Offset: 0xd90
// Size: 0x5e
function wait_until_is_done(slot, timepulse) {
    starttime = gettime();
    while (true) {
        wait 0.25;
        currenttime = gettime();
        if (currenttime > starttime + timepulse) {
            return;
        }
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x8cd2f27f, Offset: 0xdf8
// Size: 0xfc
function gadget_vision_pulse_flicker(slot, weapon) {
    self endon(#"disconnect");
    time = gettime();
    if (!self gadget_vision_pulse_is_inuse(slot)) {
        return;
    }
    eventtime = self._gadgets_player[slot].gadget_flickertime;
    self set_gadget_vision_pulse_status("^1" + "Flickering.", eventtime);
    while (true) {
        if (!self gadgetflickering(slot)) {
            set_gadget_vision_pulse_status("^2" + "Normal");
            return;
        }
        wait 0.25;
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xfa5d6be7, Offset: 0xf00
// Size: 0x9c
function set_gadget_vision_pulse_status(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Vision Pulse:" + status + timestr);
    }
}

