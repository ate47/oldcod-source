#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_slowed;

// Namespace status_effect_slowed/status_effect_slowed
// Params 0, eflags: 0x2
// Checksum 0x4d4a834, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_slowed", &__init__, undefined, undefined);
}

// Namespace status_effect_slowed/status_effect_slowed
// Params 0, eflags: 0x0
// Checksum 0xe69958a5, Offset: 0xc8
// Size: 0x6c
function __init__() {
    status_effect::register_status_effect_callback_apply(2, &slowed_apply);
    status_effect::function_81221eab(2, &function_f4788ce7);
    status_effect::function_5cf962b4(getstatuseffect("slowed"));
}

// Namespace status_effect_slowed/status_effect_slowed
// Params 3, eflags: 0x0
// Checksum 0xe3e69d00, Offset: 0x140
// Size: 0x9e
function slowed_apply(var_adce82d2, weapon, applicant) {
    self.owner.var_94ffc146 = applicant;
    self.owner.var_d0b44166 = weapon;
    if (self.owner == applicant) {
        return;
    }
    var_53c847e4 = applicant getentitynumber();
    if (!isdefined(self.owner.var_d8a2cfc1)) {
        self.owner.var_d8a2cfc1 = [];
    }
}

// Namespace status_effect_slowed/status_effect_slowed
// Params 0, eflags: 0x0
// Checksum 0x401f09eb, Offset: 0x1e8
// Size: 0x5e
function function_f4788ce7() {
    if (isdefined(self.owner) && isdefined(self.owner.var_94ffc146) && isdefined(self.owner.var_94ffc146.var_132fb2fa)) {
        self.owner.var_94ffc146.var_132fb2fa = 0;
    }
}

