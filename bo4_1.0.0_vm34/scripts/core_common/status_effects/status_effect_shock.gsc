#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;

#namespace status_effect_shock;

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x2
// Checksum 0x19ad437, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_shock", &__init__, undefined, undefined);
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x0
// Checksum 0x603fbc12, Offset: 0xf0
// Size: 0x6c
function __init__() {
    status_effect::register_status_effect_callback_apply(5, &shock_apply);
    status_effect::function_81221eab(5, &shock_end);
    status_effect::function_5cf962b4(getstatuseffect("shock"));
}

// Namespace status_effect_shock/status_effect_shock
// Params 3, eflags: 0x0
// Checksum 0x9ec050c3, Offset: 0x168
// Size: 0x14c
function shock_apply(var_adce82d2, weapon, applicant) {
    if (isdefined(var_adce82d2.var_bc84005b) ? var_adce82d2.var_bc84005b : 0) {
        self.owner setlowready(1);
        self.owner val::set(#"shock", "freezecontrols");
    }
    self.var_35e7485f = 1;
    if (isdefined(var_adce82d2)) {
        self.var_35e7485f = isdefined(var_adce82d2.var_35e7485f) ? var_adce82d2.var_35e7485f : 1;
    }
    if (self.var_35e7485f) {
        self.owner setelectrifiedstate(1);
        self thread shock_rumble_loop(float(self.duration) / 1000);
        self.owner playsound(#"hash_7d53dd7b886b60ae");
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x0
// Checksum 0x4aae1790, Offset: 0x2c0
// Size: 0xc4
function shock_end() {
    if (isdefined(self)) {
        if (isdefined(self.var_2fcb5e92.var_bc84005b) ? self.var_2fcb5e92.var_bc84005b : 0) {
            self.owner setlowready(0);
            self.owner val::reset(#"shock", "freezecontrols");
        }
        if (self.var_35e7485f) {
            self.owner stoprumble("proximity_grenade");
            self.owner setelectrifiedstate(0);
        }
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 1, eflags: 0x4
// Checksum 0x5f3f90ff, Offset: 0x390
// Size: 0xde
function private shock_rumble_loop(duration) {
    self notify(#"shock_rumble_loop");
    self endon(#"shock_rumble_loop");
    self endon(#"endstatuseffect");
    self.owner endon(#"disconnect");
    self.owner endon(#"death");
    goaltime = gettime() + int(duration * 1000);
    while (gettime() < goaltime && isdefined(self.owner)) {
        self.owner playrumbleonentity("proximity_grenade");
        wait 1;
    }
}

