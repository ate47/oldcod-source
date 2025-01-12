#using scripts\abilities\gadgets\gadget_jammer_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zombie_dog_toxic_cloud;

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 0, eflags: 0x6
// Checksum 0xab067f53, Offset: 0x130
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_33449a50d9656246", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 0, eflags: 0x5 linked
// Checksum 0x7878b7a6, Offset: 0x188
// Size: 0x154
function private function_70a657d8() {
    clientfield::register("actor", "" + #"hash_584428de7fdfefe2", 1, 1, "int", &function_3c2a50f4, 0, 0);
    clientfield::register("toplayer", "" + #"hash_313a6af163e4bef1", 1, 1, "counter", &function_d89c5699, 0, 0);
    clientfield::register("toplayer", "" + #"hash_10eff6a8464fb235", 1, 1, "counter", &function_29b682f8, 0, 0);
    clientfield::register("actor", "pustule_pulse_plague", 1, 1, "int", &function_a17af3df, 0, 0);
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x2e8
// Size: 0x4
function private postinit() {
    
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 7, eflags: 0x1 linked
// Checksum 0x67f298d7, Offset: 0x2f8
// Size: 0xe2
function function_d89c5699(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::waittill_dobj(bwastimejump);
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.time_to_wait)) {
        self.time_to_wait = 0;
    }
    if (isdefined(self.time_to_wait) && self.time_to_wait < gettime()) {
        self thread postfx::playpostfxbundle(#"hash_15272b37ec3c6110");
        self thread function_bdc0d799(bwastimejump);
        return;
    }
    self.time_to_wait = gettime() + 1000;
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 7, eflags: 0x1 linked
// Checksum 0xbc8ae061, Offset: 0x3e8
// Size: 0x104
function function_29b682f8(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    util::waittill_dobj(bwasdemojump);
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.time_to_wait)) {
        self.time_to_wait = 0;
    }
    if (isdefined(self.time_to_wait) && self.time_to_wait < gettime()) {
        self thread postfx::playpostfxbundle(#"hash_15272b37ec3c6110");
        self thread function_bdc0d799(bwasdemojump);
    } else {
        self.time_to_wait = gettime() + 1000;
    }
    self playrumbleonentity(bwasdemojump, "zm_plague_hound_bite_rumble");
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 1, eflags: 0x1 linked
// Checksum 0xa6ee703e, Offset: 0x4f8
// Size: 0x9a
function function_bdc0d799(*localclientnum) {
    self endon(#"death");
    self.time_to_wait = gettime() + 1000;
    while (true) {
        if (isdefined(self.time_to_wait) && self.time_to_wait < gettime()) {
            self.time_to_wait = 0;
            break;
        } else {
            self thread postfx::stoppostfxbundle(#"hash_15272b37ec3c6110");
            break;
        }
        wait 1;
    }
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 7, eflags: 0x1 linked
// Checksum 0xc3273ded, Offset: 0x5a0
// Size: 0xbe
function function_3c2a50f4(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::waittill_dobj(fieldname);
    if (!isdefined(self)) {
        return;
    }
    if (bwastimejump) {
        self thread function_87a4de18(fieldname);
        return;
    }
    if (bwastimejump === 0) {
        if (isdefined(self.var_348db091)) {
            stopfx(fieldname, self.var_348db091);
            self.var_348db091 = undefined;
        }
    }
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 1, eflags: 0x1 linked
// Checksum 0x6ffec0d9, Offset: 0x668
// Size: 0x134
function function_87a4de18(localclientnum) {
    util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    var_348db091 = playfx(localclientnum, "zm_ai/fx9_hound_plague_dth_aoe", self.origin + (0, 0, 18), anglestoup(self.angles));
    var_18407835 = self.origin + (0, 0, 18);
    self playsound(localclientnum, #"hash_1cbebe710791b56c");
    audio::playloopat(#"hash_155791cb3cba6094", var_18407835);
    wait 5;
    stopfx(localclientnum, var_348db091);
    audio::stoploopat(#"hash_155791cb3cba6094", var_18407835);
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 7, eflags: 0x1 linked
// Checksum 0x392f6816, Offset: 0x7a8
// Size: 0xbc
function function_a17af3df(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::waittill_dobj(fieldname);
    if (!isdefined(self)) {
        return;
    }
    if (bwastimejump) {
        self playrenderoverridebundle(#"hash_254bc28c3959a2ec");
        self callback::on_shutdown(&function_c88acbea);
        return;
    }
    function_c88acbea();
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 1, eflags: 0x1 linked
// Checksum 0x9dc79790, Offset: 0x870
// Size: 0x2c
function function_c88acbea(*params) {
    self stoprenderoverridebundle(#"hash_254bc28c3959a2ec");
}

