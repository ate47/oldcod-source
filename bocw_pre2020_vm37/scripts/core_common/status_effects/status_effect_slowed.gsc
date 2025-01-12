#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_slowed;

// Namespace status_effect_slowed/status_effect_slowed
// Params 0, eflags: 0x6
// Checksum 0xb2e42a9f, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effect_slowed", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace status_effect_slowed/status_effect_slowed
// Params 0, eflags: 0x5 linked
// Checksum 0x9a231fe7, Offset: 0xc8
// Size: 0x6c
function private function_70a657d8() {
    status_effect::register_status_effect_callback_apply(2, &slowed_apply);
    status_effect::function_5bae5120(2, &function_6fe78d40);
    status_effect::function_6f4eaf88(getstatuseffect("slowed"));
}

// Namespace status_effect_slowed/status_effect_slowed
// Params 3, eflags: 0x1 linked
// Checksum 0xbec7ad8, Offset: 0x140
// Size: 0xa6
function slowed_apply(*var_756fda07, weapon, applicant) {
    self.owner.var_a010bd8f = applicant;
    self.owner.var_9060b065 = weapon;
    if (!isdefined(applicant) || self.owner == applicant) {
        return;
    }
    var_c94d654b = applicant getentitynumber();
    if (!isdefined(self.owner.var_a4332cab)) {
        self.owner.var_a4332cab = [];
    }
}

// Namespace status_effect_slowed/status_effect_slowed
// Params 0, eflags: 0x1 linked
// Checksum 0xfdb2e14b, Offset: 0x1f0
// Size: 0x5e
function function_6fe78d40() {
    if (isdefined(self.owner) && isdefined(self.owner.var_a010bd8f) && isdefined(self.owner.var_a010bd8f.var_9d19aa30)) {
        self.owner.var_a010bd8f.var_9d19aa30 = 0;
    }
}

