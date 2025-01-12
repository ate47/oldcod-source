#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_dot;

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x2
// Checksum 0x34437b8a, Offset: 0xd8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_dot", &__init__, undefined, undefined);
}

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x0
// Checksum 0x31a3bc97, Offset: 0x120
// Size: 0xec
function __init__() {
    status_effect::register_status_effect_callback_apply(7, &dot_apply);
    status_effect::function_81221eab(7, &dot_end);
    status_effect::function_5cf962b4(getstatuseffect("dot"));
    clientfield::register("toplayer", "dot_splatter", 1, 1, "counter");
    clientfield::register("toplayer", "dot_no_splatter", 1, 1, "counter");
    callback::on_spawned(&on_player_spawned);
}

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x218
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace status_effect_dot/status_effect_dot
// Params 3, eflags: 0x0
// Checksum 0x7ef3ce1a, Offset: 0x228
// Size: 0x1e4
function dot_apply(var_adce82d2, weapon, applicant) {
    self.var_4b59c52a = var_adce82d2.var_4b59c52a;
    self.var_8931fbcd = var_adce82d2.var_8931fbcd;
    self.var_c0fb82ab = var_adce82d2.var_c0fb82ab;
    self.var_a2795859 = var_adce82d2.var_b804cb6d;
    self.var_44ea3709 = var_adce82d2.var_44ea3709;
    self.var_7a65c095 = var_adce82d2.dotdamage;
    self.var_8b3ff725 = var_adce82d2.var_3d16b1d9;
    self.var_b804cb6d = self.var_a2795859;
    self.var_f6884c49 = self.var_7a65c095;
    self.var_e59df05a = var_adce82d2.var_e59df05a;
    self.var_b9f66640 = 1 / self.var_b804cb6d / 1000;
    self.weapon = weapon;
    self.var_38884834 = var_adce82d2.var_38884834;
    self.var_672b4b74 = var_adce82d2.var_672b4b74;
    self.var_29f01feb = var_adce82d2.var_29f01feb;
    self.dotrumble = var_adce82d2.dotrumble;
    if (!isdefined(self.var_50317ba9)) {
        self.owner.var_2334f41d = 1;
        self.var_50317ba9 = gettime();
        self.var_5e06a4a3 = 0;
        if (self.var_38884834 > 0) {
            self dot_report(applicant);
        }
        self thread function_b7b832f3(applicant, var_adce82d2.killcament);
        self thread dot_rumble_loop();
    }
}

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x4
// Checksum 0x533a243c, Offset: 0x418
// Size: 0xc0
function private dot_rumble_loop() {
    self notify(#"dot_rumble_loop");
    self endon(#"dot_rumble_loop");
    self endon(#"endstatuseffect");
    waitframe(1);
    if (!isplayer(self.owner)) {
        return;
    }
    rumble = isdefined(self.dotrumble) ? self.dotrumble : "status_effect_dot";
    while (isdefined(self) && isdefined(self.owner)) {
        self.owner playrumbleonentity(rumble);
        wait 0.1;
    }
}

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x0
// Checksum 0xddb45f06, Offset: 0x4e0
// Size: 0x5a
function dot_end() {
    self.owner.var_2334f41d = undefined;
    self.owner stoprumble("status_effect_dot");
    self.owner.var_355829db = undefined;
    self.owner.var_7c4064a2 = undefined;
    self.var_50317ba9 = undefined;
}

// Namespace status_effect_dot/status_effect_dot
// Params 1, eflags: 0x4
// Checksum 0x95200c58, Offset: 0x548
// Size: 0xbc
function private function_198ffa75(count) {
    if (!isplayer(self.owner)) {
        return;
    }
    if (!(self.var_29f01feb === 1)) {
        self.owner clientfield::increment_to_player("dot_no_splatter");
    }
    if (!isdefined(self.var_672b4b74)) {
        return;
    }
    if (count % self.var_672b4b74) {
        self.owner clientfield::increment_to_player("dot_no_splatter");
        return;
    }
    self.owner clientfield::increment_to_player("dot_splatter");
}

// Namespace status_effect_dot/status_effect_dot
// Params 2, eflags: 0x4
// Checksum 0xe70ab7e1, Offset: 0x610
// Size: 0x288
function private function_b7b832f3(applicant, killcament) {
    self endon(#"endstatuseffect");
    var_fd2486df = 0;
    var_22b435e = 0;
    while (true) {
        self function_5e401c96();
        var_a2d1cc3f = 5;
        mod = "MOD_DOT";
        function_198ffa75(var_22b435e);
        var_22b435e++;
        if (isdefined(self.owner)) {
            resistance = 0;
            if (isplayer(self.owner)) {
                resistance = self.owner status_effect::function_508e1a13(7);
            }
            var_b302cbd7 = (1 - resistance) * self.var_f6884c49;
            if (isdefined(self.var_85e878ff) && self.owner === self.var_85e878ff) {
                var_b302cbd7 *= self.owner status_effect::function_1a7334aa();
            }
            var_fd2486df += var_b302cbd7;
            if (var_fd2486df >= 1) {
                var_3b0ca7b = int(floor(var_fd2486df));
                location = isdefined(self.location) ? self.location : self.owner.origin;
                if (isdefined(applicant) && isdefined(applicant.var_1dee8972)) {
                    location = applicant.var_1dee8972.origin;
                }
                self.owner dodamage(var_3b0ca7b, location, applicant, killcament, undefined, mod, var_a2d1cc3f, self.weapon);
                var_fd2486df -= var_3b0ca7b;
            }
        }
        wait self.var_b804cb6d / 1000;
        self function_fb41e7b5(applicant);
    }
}

// Namespace status_effect_dot/status_effect_dot
// Params 1, eflags: 0x4
// Checksum 0x7415275e, Offset: 0x8a0
// Size: 0xa6
function private function_fb41e7b5(applicant) {
    if (self.var_5e06a4a3 == self.var_38884834) {
        self.var_5e06a4a3 = 0;
        self dot_report(applicant);
        return;
    }
    self.var_5e06a4a3++;
    if (isdefined(self.owner)) {
        self.owner.var_74a21aed = undefined;
    }
    if (isdefined(applicant) && (!isdefined(self.owner) || self.owner != applicant)) {
        applicant.var_74a21aed = undefined;
    }
}

// Namespace status_effect_dot/status_effect_dot
// Params 1, eflags: 0x4
// Checksum 0x77acfc14, Offset: 0x950
// Size: 0x12c
function private dot_report(applicant) {
    if (!isdefined(self.owner)) {
        return;
    }
    if (!isdefined(applicant)) {
        return;
    }
    self.owner.var_74a21aed = 1;
    applicant.var_74a21aed = 1;
    location = isdefined(self.location) ? self.location : self.owner.origin;
    if (isdefined(applicant) && isdefined(applicant.var_1dee8972)) {
        location = applicant.var_1dee8972.origin;
    }
    dir = self.owner.origin - location;
    if (isplayer(self.owner) && !self.owner getinvulnerability()) {
        self.owner addtodamageindicator(self.var_f6884c49, dir);
    }
}

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x4
// Checksum 0xc99147a5, Offset: 0xa88
// Size: 0xda
function private function_5e401c96() {
    if (!self.var_4b59c52a) {
        return;
    }
    var_fc8c7615 = gettime() - (isdefined(self.var_50317ba9) ? self.var_50317ba9 : 0) + (isdefined(self.var_c0fb82ab) ? self.var_c0fb82ab : 0);
    if (var_fc8c7615 < 0) {
        return;
    }
    lerpval = var_fc8c7615 / self.var_8931fbcd;
    self.var_b804cb6d = lerpfloat(self.var_a2795859, self.var_44ea3709, lerpval);
    self.var_f6884c49 = int(lerpfloat(self.var_7a65c095, self.var_8b3ff725, lerpval));
}

