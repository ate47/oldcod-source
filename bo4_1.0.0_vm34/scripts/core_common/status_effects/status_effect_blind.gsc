#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace status_effect_blind;

// Namespace status_effect_blind/status_effect_blind
// Params 0, eflags: 0x2
// Checksum 0x78761725, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_blind", &__init__, undefined, undefined);
}

// Namespace status_effect_blind/status_effect_blind
// Params 0, eflags: 0x0
// Checksum 0x46e60666, Offset: 0xf0
// Size: 0x6c
function __init__() {
    status_effect::register_status_effect_callback_apply(1, &blind_apply);
    status_effect::function_81221eab(1, &function_27ff680c);
    status_effect::function_5cf962b4(getstatuseffect("blind"));
}

// Namespace status_effect_blind/status_effect_blind
// Params 3, eflags: 0x0
// Checksum 0x8d97f959, Offset: 0x168
// Size: 0x242
function blind_apply(var_adce82d2, weapon, applicant) {
    self.owner.flashendtime = gettime() + var_adce82d2.var_804bc9d5;
    self.owner.lastflashedby = applicant;
    if (self.owner == applicant) {
        return;
    }
    var_53c847e4 = applicant getentitynumber();
    if (!isdefined(self.owner.var_2d30e61c)) {
        self.owner.var_2d30e61c = [];
    }
    blindarray = self.owner.var_2d30e61c;
    if (!isdefined(blindarray[var_53c847e4])) {
        blindarray[var_53c847e4] = 0;
    }
    if (isdefined(blindarray[var_53c847e4]) && blindarray[var_53c847e4] + 3000 < gettime()) {
        if (isdefined(weapon) && weapon == getweapon(#"hash_3f62a872201cd1ce")) {
            if (isdefined(level.playgadgetsuccess)) {
                self.owner.var_d2fdfbd2 = 1;
                level notify(#"hash_ac034f4f7553641");
                applicant.var_31453fa6 = (isdefined(applicant.var_31453fa6) ? applicant.var_31453fa6 : 0) + 1;
                if (isdefined(level.var_86ebfbc0)) {
                    var_848752a7 = [[ level.var_86ebfbc0 ]]("swatGrenadeSuccessLineCount", 0);
                }
                if (applicant.var_31453fa6 == (isdefined(var_848752a7) ? var_848752a7 : 0)) {
                    applicant thread [[ level.playgadgetsuccess ]](getweapon(#"hash_3f62a872201cd1ce"), undefined, self.owner, undefined);
                }
            }
        }
        blindarray[var_53c847e4] = gettime();
    }
}

// Namespace status_effect_blind/status_effect_blind
// Params 0, eflags: 0x4
// Checksum 0x2c32106c, Offset: 0x3b8
// Size: 0x7e
function private function_27ff680c() {
    if (isdefined(self.owner) && isdefined(self.owner.lastflashedby) && isdefined(self.owner.lastflashedby.var_31453fa6)) {
        self.owner.lastflashedby.var_31453fa6 = 0;
    }
    if (isdefined(self.owner)) {
        self.owner.var_d2fdfbd2 = 0;
    }
}

