#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\util_shared;

#namespace dog;

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0xedf499d4, Offset: 0x108
// Size: 0x16c
function init_shared() {
    if (!isdefined(level.var_f90de4ee)) {
        level.var_f90de4ee = {};
        clientfield::register_clientuimodel("hudItems.dogState", #"hash_6f4b11a0bee9b73d", #"dogstate", 1, 2, "int", undefined, 0, 0);
        clientfield::register("actor", "dogState", 1, 1, "int", &function_654bd68b, 0, 0);
        clientfield::register("actor", "ks_dog_bark", 1, 1, "int", &function_14740469, 0, 0);
        clientfield::register("actor", "ks_shocked", 1, 1, "int", &function_e464e22b, 0, 0);
    }
    ai::add_archetype_spawn_function("mp_dog", &function_b0f3bc1f);
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0xf3f64926, Offset: 0x280
// Size: 0x3c
function function_b0f3bc1f(localclientnum) {
    self thread watchdeath(localclientnum);
    self thread function_49fa3016(localclientnum);
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0x10a6519d, Offset: 0x2c8
// Size: 0x74
function watchdeath(localclientnum) {
    self waittill(#"death");
    if (isdefined(self) && self hasdobj(localclientnum)) {
        self clearanim(#"ai_nomad_dog_additive_bark_01", 0.1);
    }
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0xaaa566f9, Offset: 0x348
// Size: 0x2ae
function function_49fa3016(localclientnum) {
    self endon(#"death");
    if (!isdefined(self.var_4c13e52c)) {
        self.var_4c13e52c = "";
    }
    self.var_5104f0dd = spawn(localclientnum, self.origin + (0, 0, 25), "script_origin");
    self.var_5104f0dd linkto(self);
    self thread function_2eef48a(self.var_5104f0dd);
    while (true) {
        waitresult = self waittill(#"hash_7de07458cbf371cd");
        if (waitresult.state != self.var_4c13e52c) {
            self.var_4c13e52c = waitresult.state;
            if (isdefined(self.var_b01a7996)) {
                self.var_5104f0dd stoploopsound(self.var_b01a7996);
            }
            switch (waitresult.state) {
            case #"idle":
                self.var_b01a7996 = self.var_5104f0dd playloopsound(#"hash_3c53f92e7904a95e");
                break;
            case #"run":
            case #"sprint":
            case #"walk":
                str_alias = #"hash_3c53f92e7904a95e";
                if (isdefined(self.enemy)) {
                    str_alias = #"hash_42874d7913968c8f";
                }
                self.var_b01a7996 = self.var_5104f0dd playloopsound(#"hash_3c53f92e7904a95e");
                break;
            case #"hash_73f9755a0eea145f":
                self.var_b01a7996 = self.var_5104f0dd playloopsound(#"hash_69f731857e79b992");
                break;
            case #"targeting":
                self.var_b01a7996 = self.var_5104f0dd playloopsound(#"hash_42874d7913968c8f");
                break;
            }
        }
    }
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0x293ef187, Offset: 0x600
// Size: 0x34
function function_2eef48a(e_sound) {
    self waittill(#"death");
    e_sound delete();
}

// Namespace dog/dog_shared
// Params 7, eflags: 0x4
// Checksum 0x91ff7066, Offset: 0x640
// Size: 0xbc
function private function_654bd68b(*localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    if (wasdemojump) {
        if (self flag::exists(#"friendly")) {
            self renderoverridebundle::stop_bundle(#"friendly", sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp", 0);
        }
    }
}

// Namespace dog/dog_shared
// Params 7, eflags: 0x0
// Checksum 0x30dde9cc, Offset: 0x708
// Size: 0x154
function function_14740469(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self notify(#"hash_7de07458cbf371cd", {#state:"targeting"});
        self playsound(fieldname, #"hash_21775fa77c0df395");
        if (isdefined(self) && self hasdobj(fieldname)) {
            self setflaggedanimknobrestart(#"hash_506d2ece42569653", #"ai_nomad_dog_additive_bark_01", 1, 0.1, 1);
        }
        return;
    }
    if (isdefined(self) && self hasdobj(fieldname)) {
        self clearanim(#"ai_nomad_dog_additive_bark_01", 0.1);
    }
}

// Namespace dog/dog_shared
// Params 7, eflags: 0x0
// Checksum 0x8c8c788d, Offset: 0x868
// Size: 0xfc
function function_e464e22b(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (isdefined(self.zmpowerupinstakill_introduction)) {
            stopfx(fieldname, self.zmpowerupinstakill_introduction);
        }
        params = getscriptbundle(#"killstreak_dog");
        self.zmpowerupinstakill_introduction = util::playfxontag(fieldname, params.var_d423184f, self, params.var_f4e41a58);
        return;
    }
    if (isdefined(self.zmpowerupinstakill_introduction)) {
        stopfx(fieldname, self.zmpowerupinstakill_introduction);
    }
}

