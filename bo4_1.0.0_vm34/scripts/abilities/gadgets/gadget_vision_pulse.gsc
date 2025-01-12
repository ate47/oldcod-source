#using scripts\abilities\ability_player;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\visionset_mgr_shared;

#namespace gadget_vision_pulse;

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0xd5a4a9eb, Offset: 0x188
// Size: 0x22e
function init_shared() {
    level.weaponvisionpulse = getweapon(#"gadget_vision_pulse");
    ability_player::register_gadget_activation_callbacks(4, &gadget_vision_pulse_on, &gadget_vision_pulse_off);
    ability_player::register_gadget_flicker_callbacks(4, &gadget_vision_pulse_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(4, &gadget_vision_pulse_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(4, &gadget_vision_pulse_is_flickering);
    ability_player::function_642003d3(4, undefined, &deployed_off);
    callback::on_spawned(&gadget_vision_pulse_on_spawn);
    clientfield::register("toplayer", "vision_pulse_active", 1, 1, "int");
    clientfield::register("toplayer", "toggle_postfx", 1, 1, "int");
    if (!isdefined(level.vsmgr_prio_visionset_visionpulse)) {
        level.vsmgr_prio_visionset_visionpulse = 61;
    }
    visionset_mgr::register_info("visionset", "vision_pulse", 1, level.vsmgr_prio_visionset_visionpulse, 12, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
    globallogic_score::register_kill_callback(level.weaponvisionpulse, &is_pulsed);
    globallogic_score::function_55e3f7c(level.weaponvisionpulse, &is_pulsed);
    level.shutdown_vision_pulse = &shutdown_vision_pulse;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xd56f2668, Offset: 0x3c0
// Size: 0x34
function deployed_off(slot, weapon) {
    self gadgetpowerset(slot, 0);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 5, eflags: 0x0
// Checksum 0x412309ed, Offset: 0x400
// Size: 0x5a
function is_pulsed(attacker, victim, weapon, attackerweapon, meansofdeath) {
    return isdefined(attacker._pulse_ent) && isdefined(victim.ispulsed) && victim.ispulsed;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xf40d6e02, Offset: 0x468
// Size: 0x1a
function function_664b9227(func) {
    level.var_b95105cb = func;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x64b28b99, Offset: 0x490
// Size: 0x2a
function gadget_vision_pulse_is_inuse(slot) {
    return self flagsys::get(#"gadget_vision_pulse_on");
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x218d8c67, Offset: 0x4c8
// Size: 0x22
function gadget_vision_pulse_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xa557ac8a, Offset: 0x4f8
// Size: 0x2c
function gadget_vision_pulse_on_flicker(slot, weapon) {
    self thread gadget_vision_pulse_flicker(slot, weapon);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0xe79f13d1, Offset: 0x530
// Size: 0x54
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
// Checksum 0x62fd1533, Offset: 0x590
// Size: 0x4c
function gadget_vision_pulse_ramp_hold_func() {
    self waittilltimeout(float(level.weaponvisionpulse.var_c66c0cbf) / 1000 - 0.35, #"ramp_out_visionset");
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x5aad8976, Offset: 0x5e8
// Size: 0x144
function gadget_vision_pulse_watch_death(slot, weapon) {
    self notify(#"vision_pulse_watch_death");
    self endon(#"vision_pulse_watch_death");
    self endon(#"disconnect");
    self waittill(#"death");
    self endon(#"shutdown_vision_pulse");
    if (isdefined(self._pulse_ent)) {
        self._pulse_ent delete();
        self ability_player::function_281eba9f(weapon, 1);
    }
    slot = self gadgetgetslot(getweapon(#"gadget_vision_pulse"));
    self gadgetcharging(slot, 1);
    self flagsys::clear(#"gadget_vision_pulse_on");
    self globallogic_score::function_8fe8d71e(#"hash_32591f4be1bf4f22");
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xc43601d7, Offset: 0x738
// Size: 0xdc
function gadget_vision_pulse_watch_emp(slot, weapon) {
    self notify(#"vision_pulse_watch_emp");
    self endon(#"vision_pulse_watch_emp");
    self endon(#"disconnect");
    self endon(#"shutdown_vision_pulse");
    while (true) {
        if (self isempjammed()) {
            self notify(#"emp_vp_jammed");
            break;
        }
        waitframe(1);
    }
    if (isdefined(self._pulse_ent)) {
        self._pulse_ent delete();
    }
    self flagsys::clear(#"gadget_vision_pulse_on");
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0x904f0bf6, Offset: 0x820
// Size: 0x12e
function function_5a390ead() {
    self notify(#"remote_control");
    self endon(#"remote_control");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"shutdown_vision_pulse");
    while (true) {
        if (self isremotecontrolling() || self clientfield::get_to_player("remote_missile_screenfx") != 0) {
            self clientfield::set_to_player("toggle_postfx", 1);
            while (self isremotecontrolling() || self clientfield::get_to_player("remote_missile_screenfx") != 0) {
                waitframe(1);
            }
            self clientfield::set_to_player("toggle_postfx", 0);
        }
        waitframe(1);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x1919841a, Offset: 0x958
// Size: 0xf4
function gadget_vision_pulse_on(slot, weapon) {
    if (isdefined(self._pulse_ent)) {
        return;
    }
    self notify(#"vision_pulse_on");
    self flagsys::set(#"gadget_vision_pulse_on");
    self thread gadget_vision_pulse_start(slot, weapon);
    if (!(isdefined(level.var_2d85b616) && level.var_2d85b616)) {
        self thread function_5a390ead();
    }
    self thread gadget_vision_pulse_watch_death(slot, weapon);
    self thread gadget_vision_pulse_watch_emp(slot, weapon);
    self clientfield::set_to_player("vision_pulse_active", 1);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x4bb9690f, Offset: 0xa58
// Size: 0x1e
function gadget_vision_pulse_off(slot, weapon) {
    self.visionpulsekill = 0;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x5bba1157, Offset: 0xa80
// Size: 0x3a4
function gadget_vision_pulse_start(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"emp_vp_jammed");
    self endon(#"shutdown_vision_pulse");
    self endon(#"hash_7e581b90612825f4");
    wait 0.1;
    if (isdefined(self._pulse_ent)) {
        return;
    }
    self ability_player::function_184edba5(weapon);
    self._pulse_ent = spawn("script_model", self.origin);
    self._pulse_ent setmodel(#"tag_origin");
    self gadgetsetentity(slot, self._pulse_ent);
    self gadgetsetactivatetime(slot, gettime());
    self set_gadget_vision_pulse_status("Activated");
    self.visionpulseactivatetime = gettime();
    enemyarray = level.players;
    visionpulsearray = arraysort(enemyarray, self._pulse_ent.origin, 1, undefined, weapon.gadget_pulse_max_range);
    self.var_5d66498 = weapon;
    self.visionpulseorigin = self._pulse_ent.origin;
    self.visionpulsearray = [];
    self.visionpulseoriginarray = [];
    spottedenemy = 0;
    self.visionpulsespottedenemy = [];
    self.visionpulsespottedenemytime = gettime();
    for (i = 0; i < visionpulsearray.size; i++) {
        self.visionpulsearray[self.visionpulsearray.size] = visionpulsearray[i];
        self.visionpulseoriginarray[self.visionpulseoriginarray.size] = visionpulsearray[i].origin;
        if (isalive(visionpulsearray[i]) && visionpulsearray[i].team != self.team) {
            if (isdefined(level.var_b95105cb)) {
                self [[ level.var_b95105cb ]](visionpulsearray[i]);
            }
            spottedenemy = 1;
            self.visionpulsespottedenemy[self.visionpulsespottedenemy.size] = visionpulsearray[i];
            visionpulsearray[i].lastvisionpulsedby = self;
            visionpulsearray[i].lastvisionpulsedtime = self.visionpulsespottedenemytime;
        }
    }
    if (isdefined(level.var_b4fc9d7)) {
        self thread [[ level.var_b4fc9d7 ]]();
    }
    self thread function_a02bfd70(weapon);
    self wait_until_is_done(slot, self._gadgets_player[slot].gadget_pulse_duration);
    self shutdown_vision_pulse(spottedenemy, 0, weapon);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 3, eflags: 0x0
// Checksum 0x4e822103, Offset: 0xe30
// Size: 0x144
function shutdown_vision_pulse(spottedenemy, immediate, weapon) {
    self notify(#"vision_pulse_off");
    self.var_91a331bc = 0;
    if (!spottedenemy) {
        self playsoundtoplayer("gdt_vision_pulse_no_hits", self);
        self notify(#"ramp_out_visionset");
    }
    self set_gadget_vision_pulse_status("Done");
    self flagsys::clear(#"gadget_vision_pulse_on");
    self clientfield::set_to_player("vision_pulse_active", 0);
    self notify(#"remote_control");
    if (isdefined(self._pulse_ent)) {
        self._pulse_ent delete();
    }
    if (immediate) {
        self notify(#"hash_7e581b90612825f4");
        self ability_player::function_281eba9f(weapon, 0);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x22144c5d, Offset: 0xf80
// Size: 0x114
function function_a02bfd70(weapon) {
    self endon(#"death");
    self endon(#"shutdown_vision_pulse");
    self endon(#"hash_7e581b90612825f4");
    wait float(weapon.var_c66c0cbf) / 1000;
    self disableoffhandweapons();
    self switchtooffhand(level.weaponvisionpulse);
    waitframe(1);
    self ability_player::function_281eba9f(weapon, 0);
    played = 0;
    while (!played) {
        played = self gestures::function_d32a43ab("ges_vision_pulse_deactivate", undefined, 1);
        waitframe(1);
    }
    self enableoffhandweapons();
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xa5cd163c, Offset: 0x10a0
// Size: 0x84
function wait_until_is_done(slot, timepulse) {
    self endon(#"hash_7e581b90612825f4");
    self endon(#"shutdown_vision_pulse");
    self endon(#"death");
    wait float(timepulse) / 1000;
    self globallogic_score::function_8fe8d71e(#"hash_32591f4be1bf4f22");
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xd03523de, Offset: 0x1130
// Size: 0xec
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
// Checksum 0xb8fa3e9f, Offset: 0x1228
// Size: 0x9c
function set_gadget_vision_pulse_status(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
        self iprintlnbold("Vision Pulse:" + status + timestr);
    }
}

