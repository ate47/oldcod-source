#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/status_effects/status_effect_util;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace status_effect_shock;

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x2
// Checksum 0x50f37c43, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("status_effect_shock", &__init__, undefined, undefined);
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x0
// Checksum 0x4a70ca8e, Offset: 0x270
// Size: 0xf0
function __init__() {
    shockbundle = getscriptbundle("shock");
    status_effect::register_status_effect_callback_apply(4, &shock_apply);
    status_effect::register_status_effect_name(4, "shock");
    status_effect::register_status_effect_base_duration(4, shockbundle.seduration * 1000);
    clientfield::register("toplayer", "shocked", 1, 1, "int");
    if (!isdefined(level.shockduration)) {
        level.shockduration = shockbundle.seduration;
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x0
// Checksum 0x7e81b59c, Offset: 0x368
// Size: 0x1f4
function shock_apply() {
    self notify(#"applyShock");
    self endon(#"applyShock");
    self endon(#"disconnect");
    self endon(#"death");
    waitframe(1);
    if (!(isdefined(self) && isalive(self))) {
        return;
    }
    currentshockduration = level.shockduration * 1000;
    self.shockstarttime = status_effect::status_effect_get_starttime(4);
    if (status_effect::status_effect_is_active(4)) {
        shock_time_left_ms = self.shockstarttime + level.shockduration - gettime();
        if (shock_time_left_ms > currentshockduration) {
            self.shockduration = shock_time_left_ms;
        } else {
            self.shockduration = currentshockduration;
        }
    } else {
        self.shockduration = currentshockduration;
    }
    self clientfield::set_to_player("shocked", 1);
    self.shockendtime = self.shockstarttime + self.shockduration;
    self thread shock_effect_loop();
    self thread shock_death_watcher();
    self thread shock_cleanse_watcher();
    if (self.shockduration > 0) {
        wait self.shockduration / 1000;
    }
    if (isdefined(self)) {
        self notify(#"shockEnd");
        self shock_end();
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x4
// Checksum 0x208911d7, Offset: 0x568
// Size: 0x54
function private shock_death_watcher() {
    self notify(#"shockDeathWatcher");
    self endon(#"shockDeathWatcher");
    self endon(#"shockEnd");
    self waittill("death");
    if (isdefined(self)) {
        self shock_end();
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x4
// Checksum 0xe65c51a4, Offset: 0x5c8
// Size: 0x54
function private shock_cleanse_watcher() {
    self notify(#"shockCleanseWatcher");
    self endon(#"shockCleanseWatcher");
    self endon(#"shockEnd");
    self waittill("gadget_cleanse_on");
    if (isdefined(self)) {
        self shock_end();
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x0
// Checksum 0x5c9beac, Offset: 0x628
// Size: 0x8a
function shock_end() {
    if (isdefined(self)) {
        self clientfield::set_to_player("shocked", 0);
        self setlowready(0);
        self util::freeze_player_controls(0);
        self stoprumble("proximity_grenade");
        self notify(#"shockEnd");
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x0
// Checksum 0x2546e4b3, Offset: 0x6c0
// Size: 0xce
function shock_effect_loop() {
    self notify(#"shockEffectLoop");
    self endon(#"shockEffectLoop");
    self endon(#"shockEnd");
    self setlowready(1);
    self util::freeze_player_controls(1);
    self thread shock_rumble_loop(self.shockduration / 1000);
    self playsound("wpn_taser_mine_zap");
    while (true) {
        playfxontag("weapon/fx_prox_grenade_impact_player_spwner", self, "J_SpineUpper");
        wait 1;
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 1, eflags: 0x4
// Checksum 0x2bcbf244, Offset: 0x798
// Size: 0x86
function private shock_rumble_loop(duration) {
    self notify(#"shock_rumble_loop");
    self endon(#"shock_rumble_loop");
    self endon(#"shockEnd");
    goaltime = gettime() + duration * 1000;
    while (gettime() < goaltime) {
        self playrumbleonentity("proximity_grenade");
        wait 1;
    }
}

