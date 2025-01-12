#using scripts\core_common\player\player_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_wound;

// Namespace status_effect_wound/status_effect_wound
// Params 0, eflags: 0x2
// Checksum 0x63bdc493, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_wound", &__init__, undefined, undefined);
}

// Namespace status_effect_wound/status_effect_wound
// Params 0, eflags: 0x0
// Checksum 0x67d39223, Offset: 0xe8
// Size: 0x6c
function __init__() {
    status_effect::register_status_effect_callback_apply(6, &wound_apply);
    status_effect::function_81221eab(6, &wound_end);
    status_effect::function_5cf962b4(getstatuseffect("wound"));
}

// Namespace status_effect_wound/status_effect_wound
// Params 3, eflags: 0x0
// Checksum 0xc06dbf74, Offset: 0x160
// Size: 0x204
function wound_apply(var_adce82d2, weapon, applicant) {
    self.var_718800f = var_adce82d2.var_d04219a8;
    self.var_34676247 = var_adce82d2.var_d20b8ed2;
    if (!isdefined(var_adce82d2.var_a8b375f3)) {
        return;
    }
    healthreduction = var_adce82d2.var_a8b375f3;
    if (self.owner.maxhealth - healthreduction < var_adce82d2.var_e716b3f2) {
        healthreduction = self.owner.maxhealth - var_adce82d2.var_e716b3f2;
    }
    var_d111cebf = [];
    var_d111cebf[0] = {#name:"cleanse_buff", #var_1f037ca:undefined};
    if (self.owner.health > 0) {
        self.owner player::function_129882c1(self.var_34676247, healthreduction * -1, var_d111cebf);
    }
    self.var_d20b8ed2 = var_adce82d2.var_d20b8ed2;
    if (self.owner.health > self.owner.var_63f2cd6e) {
        var_f72fa1dd = !isdefined(self.owner.var_bffe7e05);
        if (var_f72fa1dd) {
            self.owner.health = self.owner.var_63f2cd6e;
        }
    }
    if (self.endtime > 0) {
        self thread function_2a8dafa2();
        self thread function_acde4b9e(self.endtime - self.duration);
    }
}

// Namespace status_effect_wound/status_effect_wound
// Params 1, eflags: 0x0
// Checksum 0xa9d7551b, Offset: 0x370
// Size: 0xca
function function_acde4b9e(starttime) {
    self notify(#"hash_77a943337c92549a");
    self endon(#"hash_77a943337c92549a");
    self endon(#"endstatuseffect");
    for (var_6408c332 = self.endtime; self.endtime > gettime(); var_6408c332 = self.endtime) {
        waitframe(1);
        if (self.endtime != var_6408c332) {
            timesincestart = gettime() - starttime;
            self.owner function_1c16217b(starttime, self.duration + timesincestart, self.namehash);
        }
    }
}

// Namespace status_effect_wound/status_effect_wound
// Params 0, eflags: 0x4
// Checksum 0xb2405a6a, Offset: 0x448
// Size: 0xe8
function private function_2a8dafa2() {
    self notify(#"hash_35c63d8ef4b4825");
    self endon(#"hash_35c63d8ef4b4825");
    self endon(#"endstatuseffect");
    while (true) {
        waitresult = self.owner waittill(#"fully_healed", #"death", #"disconnect", #"healing_disabled");
        if (waitresult._notify != "fully_healed") {
            return;
        }
        if (isdefined(self.var_718800f)) {
            self.owner playsoundtoplayer(self.var_718800f, self.owner);
        }
    }
}

// Namespace status_effect_wound/status_effect_wound
// Params 0, eflags: 0x0
// Checksum 0xc65f9817, Offset: 0x538
// Size: 0x24
function wound_end() {
    self.owner player::function_20786ad7(self.var_34676247);
}

