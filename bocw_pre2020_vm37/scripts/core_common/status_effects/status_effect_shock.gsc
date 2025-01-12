#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;

#namespace status_effect_shock;

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x6
// Checksum 0xd7986be9, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effect_shock", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x5 linked
// Checksum 0xffb36b6a, Offset: 0xf0
// Size: 0x6c
function private function_70a657d8() {
    status_effect::register_status_effect_callback_apply(5, &shock_apply);
    status_effect::function_5bae5120(5, &shock_end);
    status_effect::function_6f4eaf88(getstatuseffect("shock"));
}

// Namespace status_effect_shock/status_effect_shock
// Params 3, eflags: 0x1 linked
// Checksum 0xcfb21eae, Offset: 0x168
// Size: 0x14c
function shock_apply(var_756fda07, *weapon, *applicant) {
    if (isdefined(applicant.var_120475e6) ? applicant.var_120475e6 : 0) {
        self.owner setlowready(1);
        self.owner val::set(#"shock", "freezecontrols");
    }
    self.var_52b189ce = 1;
    if (isdefined(applicant)) {
        self.var_52b189ce = isdefined(applicant.var_52b189ce) ? applicant.var_52b189ce : 1;
    }
    if (self.var_52b189ce) {
        self.owner setelectrifiedstate(1);
        self thread shock_rumble_loop(float(self.duration) / 1000);
        self.owner playsound(#"hash_7d53dd7b886b60ae");
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x1 linked
// Checksum 0x315336dd, Offset: 0x2c0
// Size: 0xc4
function shock_end() {
    if (isdefined(self)) {
        if (isdefined(self.var_4f6b79a4.var_120475e6) ? self.var_4f6b79a4.var_120475e6 : 0) {
            self.owner setlowready(0);
            self.owner val::reset(#"shock", "freezecontrols");
        }
        if (self.var_52b189ce) {
            self.owner stoprumble("proximity_grenade");
            self.owner setelectrifiedstate(0);
        }
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 1, eflags: 0x5 linked
// Checksum 0xacdd1942, Offset: 0x390
// Size: 0xd6
function private shock_rumble_loop(duration) {
    self notify(#"shock_rumble_loop");
    self endon(#"shock_rumble_loop", #"endstatuseffect");
    self.owner endon(#"disconnect", #"death");
    goaltime = gettime() + int(duration * 1000);
    while (gettime() < goaltime && isdefined(self.owner)) {
        self.owner playrumbleonentity("proximity_grenade");
        wait 1;
    }
}

