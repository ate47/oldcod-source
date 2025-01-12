#using scripts/core_common/clientfield_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/status_effects/status_effect_util;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace status_effect_pulse;

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x2
// Checksum 0x34a0b476, Offset: 0x208
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("status_effect_pulse", &__init__, undefined, undefined);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x0
// Checksum 0xdf3f9d4e, Offset: 0x248
// Size: 0xac
function __init__() {
    status_effect::register_status_effect_callback_apply(7, &pulse_apply);
    status_effect::register_status_effect_name(7, "pulse");
    status_effect::register_status_effect_base_duration(7, getscriptbundle("pulse").seduration * 1000);
    clientfield::register("toplayer", "pulsed", 1, 1, "int");
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x0
// Checksum 0x51f4b857, Offset: 0x300
// Size: 0x2ac
function pulse_apply() {
    self notify(#"applyPulse");
    self endon(#"applyPulse");
    self endon(#"disconnect");
    self endon(#"death");
    waitframe(1);
    if (!(isdefined(self) && isalive(self))) {
        return;
    }
    currentpulseduration = status_effect::status_effect_get_duration(7);
    if (isdefined(self.pulseendtime)) {
        pulse_time_left_ms = self.pulseendtime - gettime();
        if (pulse_time_left_ms > currentpulseduration) {
            self.pulseduration = pulse_time_left_ms;
        } else {
            self.pulseduration = currentpulseduration;
        }
    } else {
        self.pulseduration = currentpulseduration;
    }
    self clientfield::set_to_player("pulsed", 1);
    self.pulsestarttime = gettime();
    self.pulseendtime = self.pulsestarttime + self.pulseduration;
    shutdownpulserebootindicatormenu();
    pulserebootmenu = self openluimenu("EmpRebootIndicator");
    self setluimenudata(pulserebootmenu, "endTime", int(self.pulseendtime));
    self setluimenudata(pulserebootmenu, "startTime", int(self.pulsestarttime));
    self thread pulse_rumble_loop(0.75);
    self setempjammed(1);
    self thread pulse_death_watcher();
    self thread pulse_cleanse_watcher();
    if (self.pulseduration > 0) {
        wait self.pulseduration / 1000;
    }
    if (isdefined(self)) {
        self notify(#"pulseEnd");
        self pulse_end();
    }
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 1, eflags: 0x4
// Checksum 0xc306e273, Offset: 0x5b8
// Size: 0x76
function private pulse_rumble_loop(duration) {
    self endon(#"pulse_rumble_loop");
    self notify(#"pulse_rumble_loop");
    goaltime = gettime() + duration * 1000;
    while (gettime() < goaltime) {
        self playrumbleonentity("damage_heavy");
        waitframe(1);
    }
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x4
// Checksum 0x15fcf7b8, Offset: 0x638
// Size: 0x54
function private pulse_death_watcher() {
    self notify(#"pulseDeathWatcher");
    self endon(#"pulseDeathWatcher");
    self endon(#"pulseEnd");
    self waittill("death");
    if (isdefined(self)) {
        self pulse_end();
    }
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x4
// Checksum 0x108ced, Offset: 0x698
// Size: 0x54
function private pulse_cleanse_watcher() {
    self notify(#"pulseCleanseWatcher");
    self endon(#"pulseCleanseWatcher");
    self endon(#"pulseEnd");
    self waittill("gadget_cleanse_on");
    if (isdefined(self)) {
        self pulse_end();
    }
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x0
// Checksum 0xd766a816, Offset: 0x6f8
// Size: 0x6c
function pulse_end() {
    if (isdefined(self)) {
        shutdownpulserebootindicatormenu();
        if (self killstreaks::emp_isempd()) {
            return;
        }
        self setempjammed(0);
        self clientfield::set_to_player("pulsed", 0);
    }
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x0
// Checksum 0x8d33734c, Offset: 0x770
// Size: 0x54
function shutdownpulserebootindicatormenu() {
    emprebootmenu = self getluimenu("EmpRebootIndicator");
    if (isdefined(emprebootmenu)) {
        self closeluimenu(emprebootmenu);
    }
}

